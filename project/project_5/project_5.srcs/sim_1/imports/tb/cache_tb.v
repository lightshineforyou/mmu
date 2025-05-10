module cache_tb;
  reg         clk;
  reg         resetn;
  reg         cpu_valid;
  reg  [3:0]  cpu_wstrb;
  reg  [31:0] cpu_addr;
  reg  [31:0] cpu_wdata;
  wire [31:0] cpu_rdata;
  wire        cpu_ready;

  wire        mem_ready;
  reg         mem_ready_reg;
  wire        mem_valid;
  wire [ 3:0] mem_wstrb;
  wire [33:0] mem_addr;
  wire [31:0] mem_wdata;
  reg  [31:0] mem_rdata;

  wire [31:0] cache_miss_count;

  // dummy MMU signals
  wire is_instruction = 0;
  wire tlb_flush = 0;
  wire stall;
  wire write_back = 0;
  wire [31:0] satp = 0;
  wire [31:0] mstatus = 0;
  wire [1:0]  privilege_mode = 0;
  wire [31:0] fault_address;
  wire page_fault;

  // Instantiate DUT
  sv32 u_dut (
    .clk(clk),
    .resetn(resetn),
    .cpu_valid(cpu_valid),
    .cpu_ready(cpu_ready),
    .cpu_wstrb(cpu_wstrb),
    .cpu_addr(cpu_addr),
    .cpu_wdata(cpu_wdata),
    .cpu_rdata(cpu_rdata),
    .mem_valid(mem_valid),
    .mem_ready(mem_ready_reg),
    .mem_wstrb(mem_wstrb),
    .mem_addr(mem_addr),
    .mem_wdata(mem_wdata),
    .mem_rdata(mem_rdata),
    .cache_miss_count(cache_miss_count),
    .is_instruction(is_instruction),
    .tlb_flush(tlb_flush),
    .stall(stall),
    .write_back(write_back),
    .satp(satp),
    .mstatus(mstatus),
    .privilege_mode(privilege_mode),
    .fault_address(fault_address),
    .page_fault(page_fault)
  );

  // Simple memory model
  reg [31:0] memory [0:255]; // 1KB memory
  integer i;

  always @(posedge clk) begin
    if (mem_valid) begin
      if (|mem_wstrb) begin
        memory[mem_addr[9:2]] <= mem_wdata;
      end else begin
        mem_rdata <= memory[mem_addr[9:2]];
      end
      mem_ready_reg <= 1;
    end else begin
      mem_ready_reg <= 0;
    end
  end

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset
  initial begin
    resetn = 0;
    #20;
    resetn = 1;
  end

  // Test sequences
  initial begin
    // init
    cpu_valid = 0;
    cpu_wstrb = 0;
    cpu_addr = 0;
    cpu_wdata = 0;
    for (i=0; i<256; i=i+1) memory[i] = 0;

    // wait reset
    @(posedge resetn);
    #10;

    // 1) Write then Read same address (hit)
    test_write(32'h0000_0100, 32'hA5A5_A5A5);
    test_read (32'h0000_0100, 32'hA5A5_A5A5);

    // 2) Fill two ways in same set -> provoke LRU replacement
    test_write(32'h0000_0200, 32'h1111_1111); // way0
    test_write(32'h0000_0300, 32'h2222_2222); // way1
    test_write(32'h0000_0400, 32'h3333_3333); // replaces LRU
    test_read (32'h0000_0400, 32'h3333_3333);

    // 3) Read miss then read hit (use different set to avoid LRU collision)
    
    test_read (32'h0000_0600, 32'h0000_0000); // miss allocate from mem (zero)
    @(posedge clk);
    @(posedge clk);
    test_read (32'h0000_0600, 32'h0000_0000); // read hit from cache

    // Summary
    #50;
    $display("[统计] Cache 缺失次数 = %0d 次", cache_miss_count);
    #10 $finish;
  end

  // tasks
  task test_write(input [31:0] addr, input [31:0] data);
    begin
      @(posedge clk);
      cpu_addr = addr;
      cpu_wdata = data;
      cpu_wstrb = 4'hF;
      cpu_valid = 1;
      @(posedge clk);
      wait(cpu_ready);
      @(posedge clk);
      cpu_valid = 0;
      cpu_wstrb = 0;
      #2;
      $display("[测试] 写入 地址＝0x%h 数据＝0x%h 成功", addr, data);
    end
  endtask

  task test_read(input [31:0] addr, input [31:0] exp);
    begin
      @(posedge clk);
      cpu_addr = addr;
      cpu_wstrb = 0;
      cpu_valid = 1;
      @(posedge clk);
      wait(cpu_ready);
      @(posedge clk);
      cpu_valid = 0;
      if (cpu_rdata !== exp) begin
        $error("[错误] 读取 地址＝0x%h 期望＝0x%h 实际＝0x%h", addr, exp, cpu_rdata);
      end else begin
        $display("[测试] 读取 地址＝0x%h 数据＝0x%h 正确", addr, cpu_rdata);
      end
      #2;
    end
  endtask
endmodule