#objdump: -dr --prefix-addresses --show-raw-insn -M reg-names=numeric
#name: MIPS16e
#as: -32


.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <[^>]*> eac0      	jalrc	\$2
0+0002 <[^>]*> eac0      	jalrc	\$2
0+0004 <[^>]*> e8a0      	jrc	\$31
0+0006 <[^>]*> ea80      	jrc	\$2
0+0008 <[^>]*> eac0      	jalrc	\$2
0+000a <[^>]*> eac0      	jalrc	\$2
0+000c <[^>]*> eac0      	jalrc	\$2
0+000e <[^>]*> eac0      	jalrc	\$2
0+0010 <[^>]*> e8a0      	jrc	\$31
0+0012 <[^>]*> ea80      	jrc	\$2
0+0014 <[^>]*> e8a0      	jrc	\$31
0+0016 <[^>]*> ea80      	jrc	\$2
0+0018 <[^>]*> eac0      	jalrc	\$2
0+001a <[^>]*> 1800 0000 	jal	00000000 <[^>]*>
			1a: R_MIPS16_26	foo
0+001e <[^>]*> 4281      	addiu	\$4,\$2,1
0+0020 <[^>]*> eac0      	jalrc	\$2
0+0022 <[^>]*> 1800 0000 	jal	00000000 <[^>]*>
			22: R_MIPS16_26	foo
0+0026 <[^>]*> 6500      	nop
0+0028 <[^>]*> 6782      	move	\$4,\$2
0+002a <[^>]*> eac0      	jalrc	\$2
0+002c <[^>]*> 6782      	move	\$4,\$2
0+002e <[^>]*> ea80      	jrc	\$2
0+0030 <[^>]*> 6782      	move	\$4,\$2
0+0032 <[^>]*> e8a0      	jrc	\$31
0+0034 <[^>]*> ec91      	seb	\$4
0+0036 <[^>]*> ecb1      	seh	\$4
0+0038 <[^>]*> ec11      	zeb	\$4
0+003a <[^>]*> ec31      	zeh	\$4
0+003c <[^>]*> 64c1      	save	8,\$31
0+003e <[^>]*> 64c0      	save	128,\$31
0+0040 <[^>]*> 64e2      	save	16,\$31,\$16
0+0042 <[^>]*> 64f2      	save	16,\$31,\$16-\$17
0+0044 <[^>]*> 64df      	save	120,\$31,\$17
0+0046 <[^>]*> f010 64e1 	save	136,\$31,\$16
0+004a <[^>]*> f004 64f2 	save	\$4,16,\$31,\$16-\$17
0+004e <[^>]*> f308 64e2 	save	\$4-\$5,16,\$31,\$16,\$18-\$20
0+0052 <[^>]*> f30c 64f2 	save	\$4-\$6,16,\$31,\$16-\$20
0+0056 <[^>]*> f70e 64d2 	save	\$4-\$7,16,\$31,\$17-\$30
0+005a <[^>]*> f30a 64e2 	save	\$4-\$5,16,\$31,\$16,\$18-\$20,\$6-\$7
0+005e <[^>]*> 6500      	nop
