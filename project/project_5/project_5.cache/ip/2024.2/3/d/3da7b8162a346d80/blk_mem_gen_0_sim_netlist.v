// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Thu Apr 24 11:52:12 2025
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19904)
`pragma protect data_block
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
kCnhQco4Bx4CtaU=
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
