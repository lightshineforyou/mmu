// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Thu Apr 24 11:52:14 2025
// Host        : LAPTOP-MUII7O6N running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               e:/cache/project_5/project_5.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (clka,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [1:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [3:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [17:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [17:0]douta;

  wire [3:0]addra;
  wire clka;
  wire [17:0]dina;
  wire [17:0]douta;
  wire [1:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [17:0]NLW_U0_doutb_UNCONNECTED;
  wire [3:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [17:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "4" *) 
  (* C_ADDRB_WIDTH = "4" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.95605 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_0.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "16" *) 
  (* C_READ_DEPTH_B = "16" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "18" *) 
  (* C_READ_WIDTH_B = "18" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "2" *) 
  (* C_WEB_WIDTH = "2" *) 
  (* C_WRITE_DEPTH_A = "16" *) 
  (* C_WRITE_DEPTH_B = "16" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "18" *) 
  (* C_WRITE_WIDTH_B = "18" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_9 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[17:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[3:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[3:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[17:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web({1'b0,1'b0}));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
FPXllyX2NFs/RMngGqZy2bLYbZr92CdofeZrJOHklWXExpaPgHNYp2Lzm4MnflbnrfSkCmLwwKT5
zfRgEip7FKQ5Zhb73p0MAIADixBZ/ZRt4hQkJL0T9brm0waLHfanjnov2aCX6jN3LbQc3ujmDga6
Dd73k78u4xjRTDv1/P4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kr7VKKvChFoiyRCReag+OvU3jnmG9pN0cv+BxhNmMKLthg/ksgNZyU3L+fQ7cmIQELtlUjwjkBAP
Jjq5RsCnHbJxj+Ys1GNhriiBsxLqxWCP8onhAVvgZN2xZFOih0UWpqlU8NVP8Eww1ohvkDgxTstC
3kDmYehxIUJjqCC/mgRZmuezqugrFdubYmBoz16tUvD17iA5qqCIMS9xSIXYp2LBNekmWEwrVqzu
R4koEo4UlXl/CEw0XY3QvMoHnlXgu6N/6sc+nxZtKSwjiMVvGnZE9UVvJPAC3Hn3zKFGlK53mmGO
Tj0dWzhwX0ahSYzkyJC/HLdbGZmriL2UNvDyFw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
CaLc9FGt3AdRHfNtGAsGFY/QEvHY1Vv4TvvgCDsdDMqiuDeLizFJDJeskBWjeKDoE2cufK8TxiBq
mySRQNJoeOKnxTiDdf+Rx6m0iR6h/YeswegYwgghpM5KVrl6mSwF3+4yEovPM7a+9ArDQ5vl+WT8
SilNGzyW0KnTwe7+szs=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cEnudSW1X71p0Xuq6jrXOxHnBku87IA0RA3zKqmeZHZM0r+9rEm5MSzX8RecnQ994yiqeyxbIH2l
fGEzUzr0ZzryS3fkf2LnJuB39f2YARW9eVCSiaeWaraZuY1l89T+h3vgdlurS/1LIraYLS1MyOXa
6F1LAcQp3W4OO4ctc3q1FRMZGldRS1biMsKwJ8Lxj8NEOm67UfgFrJNQAxbVXEfbWRWhKtwNxcTB
JbgC8j4EHkIA46mzoHloeBAL6KieplQUBjKXSSTb66rxglbFhWLy+mirROHcocu9J4ZbvTRYZEww
4lso1lqAllVLAoKYqa3WImZuSRoTbGDngBt9Lg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rOyI+x4PlmKcVSFoN3oKgSYpVlmYxc194Ej04il/YmBg10xopy4zmtu5sdCP/uGSNYcNGWeAiw01
mNf98KyNgTUFXruHCA38qjhhEIvl4vfWWn3W3mFRxrIuwmnreT6qTvgMaxIkCdVBDP7Iy7O6WmCf
3Va5X5hnCHhtXgX5UYniBHiLjmupv63B8XMAYDH2n6mQ3H0DF7mtb7psBafd0Z6+IWUbmzwMtKrf
ZrRJBGAhNT0i1KrEjEh/rWjN7Z7N32zQ+Pl1kc5gYCQIX5McfdTdqSaRVXZ/HF90ymS7/8d5LDyj
Er+ORdcjnOn6oAyY4PuUUl4OYUHv5k+RglTe5Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bJa7kPSpDipzoJoQu1APEjc8vFLqBfQZK/grZvWijD7/FgMTerFCWLUY6n8DWeGdvjXvTeyrqCHE
2rP/H57wUqPC8tIJlGm6ZYQGjZ3TgYqLrJshDE5zYMTO//q0vuSraWvZP7A7SLuW6y7tFE/nplpx
L8gbYORx6j70okGUwnamCMS9yhFr7Z2QTJne1k4GNFGvy66URk3k5cBPl5j4/1yc4xGV+aWYl6L8
q8RorRU/CltObHKrji/jdiY1WtdGrkpRyCEFc+XNPazL9xSLLu5bz6XlvKwoks+8a5KYT/VFUovM
JbM0bpAXM8Z7rGaPuXjqXtZBg5praTZLu/WNcA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PYKBDinOGc/kIVdFzXrz2wA4/QNFxLDrQfTWfR5TjYE6bm49vrZi0bawcr9HXp4OP1+XxPLB3oCP
oV5e/rYeDln531ebt8yEg27XCoSHEX4FU8oG8aBJ8fqgWayOnAMJt025WodOxuZXbhT1zPo7J3uh
6iO9Mv7RtYE2fZ1W+G8oN//FTOEJYPWlKYnt0cDeZrN3I4rHHptZHuu7l8T+df0PYea3x6U3Mvkl
ojZ+TwQtdu0NuYY5j3QNgx3+W2XYq1M773FAnEz/deW54EjE+jf1jjrBk2pl8SYxeKuutS15oPVF
eHdqXYVcJxoUY5JH8z04lITKEnZ4oq6sYS6dog==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
tl+2vFCWZ583gQGsVC7oopz2NCKBiJ9uOHYBGzJZheOHJMqI/ehNvo25l710eBx00tztXzM30AH6
ZhAJg+kJwE2jO0MV5fmG5dnwXmLqoGEJMBs7xwWxvYK7w/0z9M0AJKD7HnuC+IiLhNU/fIxyuE+I
+vWqp//RcfY0tMMp2I2J1yEW6GUahS1ve/4JchssZ7Xu7VthoSDWXMQWATbvsUsDzeSo2+Ruz8Kq
Dc05HqEU8NgBxDPPEKLCcdKLp4byglwj7iCAtCjsPy8P18qjgb2sycFjNgmaiNMMB51WqeD+hneG
hLOue9bqVdEojkrb3q4WbsGZKz0bAGsryxslOlYHP1b8vey3yI2ixA80wyERe8d3GRIeZiSxGykH
qWxsE6x/iyi8QRb5mXZPMApA+Fln8tYmn7+1rFCm8gF4gJWhr1PsSJqTi658symGrzT0Ghjvf2QL
SvvoaeNdy0pOsWs7jLBFndd4GiFA+9K6Y33sziLToU9EvvFokENIslod

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
oYiCujFRj1F3wKsGZlHR9niEtR9MLXEVAVfy+f/3xrmpW6Ye5a+fBCvm4TH+iRQefGHNdMPnzTNW
K/pEPAS9uMJjOdFiu+APT+LYrSRnEg4W0dX5buSDGM6LBWAuMseoTMjbJJoYDGLRckJgW43E30mX
ej4823nkbfwc+Ecbrup825qLyv8RTQLNHafvJA5lSapdqXwnlOIYRmcHn+sfAh5pGv9kW9aokcdh
ObR2XYxX99rYloyvz3x0pmjxD5ILW4SQMB1IUEuuyqX6eb5IQ+kZ41hjvsHIuQH29vzpCfV9Jqha
WC5yxxK1R+cleZSKD1H1gVzbTei8uFs/91Bgeg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
urNc+S8AFPj+GVFdqJE5V7P8O6QI6MA3nkwYb8NKbYbVufnXKg6voJIRYYeYr7EOa8mrqirozWbY
Lln9SLWnkaAy2LvL/N6WahoQdCt++4RH+xe768XvSrVUFPrIwZRixqMLurc/tPov4i5P/ukZKl18
ZPZvXRzUNlvCZnMPcF+5QCQihqPbjcZ0YyGgWgX/ipTGG3sNqmylGN7qLa4Rgqu/mB5a2xVyu5Wc
911+/X3VVFx697WVaP5V0SbOzYN8R8+8B8kdznwixMA+f4lSbBXyRysVOSzYjo8bKEMqyKMVBQn9
xDmEuV0DvVWXdO7VPvWA1LuJFwS07OxeI2GCcQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QcP7fsLZxaDrG29e9HQeXfu2TsKsdyW7Yc1vWct6lbmDEfXkWMU1fFWSPIjPzRc9UOnfEu0bRn+B
D+8MWokqes3WF7txljBmgUPiNGZ8arUU6ENa/IY/Wv7iaB/ZKM5PtdnFAkjDIrYyKFCTz/U6Yzwi
hBGGarK/wYQOLzeeKRewiPTiNUL7tztWuMZ1t1msxD951EeKrwjrjcXIIuf/TzrOGUOlWgjHlnrl
4Q/lfMAnRLBNTSWG+5wWewCE8jK2X/gJ5AV4p3x1WP3+JglbxpP39l3pzedXqciZPbuz2XlFnRPV
KByaUaAShzJ56p8+0HjWebibqQdieGNPiPWW0Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19888)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
