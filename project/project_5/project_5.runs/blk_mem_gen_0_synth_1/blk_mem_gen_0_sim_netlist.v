// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Sat Apr 26 14:12:58 2025
// Host        : wangzhangzhuo running 64-bit major release  (build 9200)
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
QH/RWsVOkHaC9Lo=
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
