/* Quartus Prime Version 18.1.1 Build 646 04/11/2019 SJ Lite Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(SOCVHPS) MfrSpec(OpMask(0));
	P ActionCode(Cfg)
		Device PartName(5CSTFD6D5F31) Path("/opt/pro/llrf/sw/hp/soc/fpga/syn/hp/output_files/") File("hp.sof") MfrSpec(OpMask(1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
