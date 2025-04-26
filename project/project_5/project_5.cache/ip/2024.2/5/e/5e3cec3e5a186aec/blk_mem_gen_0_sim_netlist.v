// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Wed Apr 23 23:22:38 2025
// Host        : LAPTOP-MUII7O6N running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_9 U0
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
