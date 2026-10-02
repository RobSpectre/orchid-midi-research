; Offline disassembly. Literal pools may decode as instructions.
; Recognized jump-table data is explicitly identified below.
08045d58: push.w     {r4, r5, r6, r7, r8, sb, sl, fp, lr}
08045d5c: sub        sp, #0xcc
08045d5e: bl         #0x8045c00
08045d62: cmp        r0, #0
08045d64: beq.w      #0x8045e8e
08045d68: ldr        r4, [pc, #0x288]
08045d6a: ldrb       r2, [r4]
08045d6c: cmp        r2, #5
08045d6e: bls.w      #0x8045e8a
08045d72: ldr        r5, [pc, #0x284]
08045d74: ldrb       r3, [r5, #1]
08045d76: cmp        r3, #0x7e
08045d78: beq.w      #0x8045e7e
08045d7c: ldrb       r1, [r5]
08045d7e: cmp        r1, #0xf0
08045d80: bne.w      #0x8045e8a
08045d84: cmp        r3, #0
08045d86: bne.w      #0x8045e94
08045d8a: ldrb       r3, [r5, #2]
08045d8c: cmp        r3, #0x22
08045d8e: beq        #0x8045d94
08045d90: cmp        r3, #0x6c
08045d92: bne        #0x8045e8a
08045d94: ldrb       r3, [r5, #3]
08045d96: cmp        r3, #0x70
08045d98: beq        #0x8045d9e
08045d9a: cmp        r3, #0xc
08045d9c: bne        #0x8045e8a
08045d9e: ldrb       r3, [r5, #4]
08045da0: cmp        r3, #1
08045da2: bne        #0x8045e8a
08045da4: ldr        r3, [pc, #0x250]
08045da6: movs       r0, #0
08045da8: add.w      ip, r3, #-1
08045dac: add        ip, r2
08045dae: b          #0x8045db6
08045db0: cmp        r3, ip
08045db2: uxtb       r0, r6
08045db4: beq        #0x8045dc0
08045db6: ldrb       r1, [r3, #1]!
08045dba: adds       r6, r1, r0
08045dbc: lsls       r1, r1, #0x18
08045dbe: bpl        #0x8045db0
08045dc0: lsls       r3, r0, #0x19
08045dc2: bne.w      #0x80462ba
08045dc6: ldrb.w     r8, [r5, #5]
08045dca: cmp.w      r8, #0x7f
08045dce: beq.w      #0x804627a
08045dd2: ldr        r6, [pc, #0x228]
08045dd4: movs       r3, #5
08045dd6: movs       r7, #6
08045dd8: sub.w      r8, r8, #0x34
08045ddc: cmp.w      r8, #0x4b
08045de0: bhi        #0x8045e9c
08045de2: tbh        [pc, r8, lsl #1]
08045de6: .table 3f 02
08045de8: .table 01 02
08045dea: .table ae 01
08045dec: .table 5b 00
08045dee: .table 52 00
08045df0: .table 52 00
08045df2: .table 52 00
08045df4: .table 52 00
08045df6: .table 5b 00
08045df8: .table 5b 00
08045dfa: .table a6 01
08045dfc: .table 1b 02
08045dfe: .table 5b 00
08045e00: .table 5b 00
08045e02: .table 5b 00
08045e04: .table 0a 02
08045e06: .table 5b 00
08045e08: .table 2d 02
08045e0a: .table 8b 01
08045e0c: .table 78 01
08045e0e: .table 68 01
08045e10: .table 5b 00
08045e12: .table 5b 00
08045e14: .table 5b 00
08045e16: .table 5b 00
08045e18: .table 5b 00
08045e1a: .table 5b 00
08045e1c: .table 5b 00
08045e1e: .table 49 01
08045e20: .table 27 01
08045e22: .table ff 00
08045e24: .table d4 00
08045e26: .table 47 02
08045e28: .table c5 00
08045e2a: .table bb 00
08045e2c: .table 5b 00
08045e2e: .table 5b 00
08045e30: .table 5b 00
08045e32: .table 5b 00
08045e34: .table 5b 00
08045e36: .table 5b 00
08045e38: .table 5b 00
08045e3a: .table 5b 00
08045e3c: .table 5b 00
08045e3e: .table 5b 00
08045e40: .table 5b 00
08045e42: .table 5b 00
08045e44: .table 5b 00
08045e46: .table 5b 00
08045e48: .table 5b 00
08045e4a: .table 5b 00
08045e4c: .table 5b 00
08045e4e: .table 5b 00
08045e50: .table 5b 00
08045e52: .table 5b 00
08045e54: .table 5b 00
08045e56: .table 5b 00
08045e58: .table 5b 00
08045e5a: .table 5b 00
08045e5c: .table 5b 00
08045e5e: .table 5b 00
08045e60: .table a9 00
08045e62: .table 9a 00
08045e64: .table 83 00
08045e66: .table 5b 00
08045e68: .table 5b 00
08045e6a: .table 7f 00
08045e6c: .table 79 00
08045e6e: .table 5b 00
08045e70: .table 5b 00
08045e72: .table 75 00
08045e74: .table 6b 00
08045e76: .table 5b 00
08045e78: .table 5b 00
08045e7a: .table 5b 00
08045e7c: .table 52 00
08045e7e: ldrb       r3, [r5, #3]
08045e80: cmp        r3, #6
08045e82: bne        #0x8045e8a
08045e84: ldrb       r3, [r5, #4]
08045e86: cmp        r3, #1
08045e88: beq        #0x8045eae
08045e8a: movs       r3, #0
08045e8c: strb       r3, [r4]
08045e8e: add        sp, #0xcc
08045e90: pop.w      {r4, r5, r6, r7, r8, sb, sl, fp, pc}
08045e94: cmp        r3, #0x54
08045e96: beq.w      #0x8045d8a
08045e9a: b          #0x8045e8a
08045e9c: ldr        r2, [pc, #0x160]
08045e9e: ldr        r3, [pc, #0x164]
08045ea0: movs       r1, #8
08045ea2: add        r0, sp, #0x1c
08045ea4: str        r2, [sp, #0x1c]
08045ea6: str        r3, [sp, #0x20]
08045ea8: bl         #0x802eea0
08045eac: b          #0x8045e8a
08045eae: movs       r1, #0x11
08045eb0: ldr        r0, [pc, #0x154]
08045eb2: bl         #0x802eea0
08045eb6: movs       r3, #0
08045eb8: strb       r3, [r4]
08045eba: b          #0x8045e8e
08045ebc: ldrb       r1, [r5, #7]
08045ebe: cmp        r1, #0xf
08045ec0: bls.w      #0x80462e2
08045ec4: ldr        r2, [pc, #0x144]
08045ec6: movs       r0, #0
08045ec8: ldr        r3, [pc, #0x144]
08045eca: strb       r0, [r2]
08045ecc: strb       r1, [r3]
08045ece: b          #0x8045e8a
08045ed0: ldr        r0, [pc, #0x124]
08045ed2: bl         #0x803feb0
08045ed6: b          #0x8045e8a
08045ed8: mov.w      r3, #0x8000000
08045edc: movs       r0, #0
08045ede: ldr        r3, [r3, #0x1c]
08045ee0: blx        r3
08045ee2: b          #0x8045e8a
08045ee4: ldr        r0, [pc, #0x12c]
08045ee6: bl         #0x8041604
08045eea: b          #0x8045e8a
08045eec: ldr        r0, [pc, #0x128]
08045eee: ldr        r3, [pc, #0x12c]
08045ef0: ldr        r2, [r0, #4]
08045ef2: cmp        r2, r3
08045ef4: beq.w      #0x80462f8
08045ef8: movs       r3, #2
08045efa: ldr        r0, [pc, #0x104]
08045efc: movw       r1, #0x7801
08045f00: movs       r2, #0xf7
08045f02: strb.w     r3, [sp, #0x22]
08045f06: str        r0, [sp, #0x1c]
08045f08: add        r0, sp, #0x1c
08045f0a: strh.w     r1, [sp, #0x20]
08045f0e: movs       r1, #8
08045f10: strb.w     r2, [sp, #0x23]
08045f14: bl         #0x802eea0
08045f18: b          #0x8045e8a
08045f1a: ldr        r3, [pc, #0xfc]
08045f1c: ldr.w      r5, [r3, #0x80]
08045f20: uxth       r3, r5
08045f22: cmp        r3, #0
08045f24: beq.w      #0x80462da
08045f28: ldr        r2, [pc, #0xec]
08045f2a: movs       r1, #0x80
08045f2c: mov        r0, r5
08045f2e: bl         #0x804570c
08045f32: ldr        r2, [pc, #0xcc]
08045f34: ldr        r3, [pc, #0xe8]
08045f36: b          #0x8045ea0
08045f38: ldr        r3, [pc, #0xe8]
08045f3a: ldrb       r1, [r5, #9]
08045f3c: ldrb       r2, [r5, #0xa]
08045f3e: rsb.w      r0, r3, #0x24000000
08045f42: add.w      r5, r3, #0x80
08045f46: add.w      r2, r2, r1, lsl #7
08045f4a: add.w      r0, r0, r2, lsl #7
08045f4e: adds       r2, r0, r3
08045f50: ldr        r1, [r3, #4]!
08045f54: cmp        r3, r5
08045f56: str        r1, [r2]
08045f58: bne        #0x8045f4e
08045f5a: b          #0x8045e8a
08045f5c: ldr        r2, [pc, #0xc8]
08045f5e: movs       r3, #0
08045f60: movs       r1, #5
08045f62: add        r0, sp, #0x1c
08045f64: str        r2, [sp, #0x1c]
08045f66: strb.w     r3, [sp, #0x20]
08045f6a: bl         #0x8045d04
08045f6e: b          #0x8045e8a
08045f70: movs       r1, #1
08045f72: ldr        r0, [pc, #0xb8]
08045f74: bl         #0x803488c
08045f78: movs       r3, #0x55
08045f7a: mov        r2, r0
08045f7c: movs       r1, #2
08045f7e: add        r0, sp, #0x1c
08045f80: strb.w     r2, [sp, #0x1d]
08045f84: strb.w     r3, [sp, #0x1c]
08045f88: bl         #0x8045d04
08045f8c: b          #0x8045e8a
08045f8e: add.w      sb, sp, #0x1c
08045f92: movs       r3, #0
08045f94: movs       r1, #1
08045f96: mov        r0, sb
08045f98: strb.w     r3, [sp, #0x1c]
08045f9c: bl         #0x8045d04
08045fa0: movs       r2, #0x21
08045fa2: movs       r1, #0
08045fa4: mov        r0, sb
08045fa6: bl         #0x8048f2a
08045faa: movs       r3, #0x54
08045fac: movs       r1, #1
08045fae: ldr        r0, [pc, #0x80]
08045fb0: strb.w     r3, [sp, #0x1c]
08045fb4: bl         #0x803194c
08045fb8: mov        r2, r0
08045fba: movs       r1, #1
08045fbc: ldr        r0, [pc, #0x70]
08045fbe: strb.w     r2, [sp, #0x1d]
08045fc2: bl         #0x80319d8
08045fc6: mov        r5, r0
08045fc8: bl         #0x802703c
08045fcc: mov        r2, r0
08045fce: add.w      r0, sp, #0x1e
08045fd2: mov        r1, r5
08045fd4: uxtb       r2, r2
08045fd6: bl         #0x804907c
08045fda: movs       r1, #0x21
08045fdc: mov        r0, sb
08045fde: bl         #0x8045d04
08045fe2: b          #0x8045e8a
08045fe4: movs       r1, #0
08045fe6: ldr        r0, [pc, #0x44]
08045fe8: bl         #0x803488c
08045fec: movs       r3, #0x52
08045fee: mov        r2, r0
08045ff0: b          #0x8045f7c
08045ff2: nop        
08045ff4: mla        r4, r0, r4, r2
08045ff8: mla        r4, r4, r4, r2
08045ffc: mla        r4, sl, r4, r2
08046000: lsls       r0, r6, #3
08046002: lsrs       r2, r4, #0x10
08046004: ldrb       r1, [r0]
08046006: bl         #0x7b486da
0804600a: lsrs       r0, r1, #0x20
0804600c: b          #0x804599a
0804600e: movs       r4, #4
08046010: b          #0x80459a0
08046012: movs       r4, #4
08046014: mla        r4, ip, r4, r2
08046018: .byte      0x04, 0xfc
0804601a: movs       r4, #4
0804601c: add        r7, sp, #0x3f8
0804601e: stm        r0!, {r1, r2, r3, r4, r6, r7}
08046020: ldrb       r1, [r0]
08046022: bl         #0x7f46826
08046026: movs       r4, #4
08046028: mov        r6, sl
0804602a: lsrs       r6, r3, #0x10
0804602c: str        r5, [sp, #0x240]
0804602e: movs       r4, #4
08046030: ldr        r4, [sp, #0x240]
08046032: movs       r4, #4
08046034: movs       r2, #0x21
08046036: movs       r1, #0
08046038: add        r0, sp, #0x1c
0804603a: bl         #0x8048f2a
0804603e: movs       r3, #0x51
08046040: movs       r1, #0
08046042: ldr        r0, [pc, #0x2c0]
08046044: strb.w     r3, [sp, #0x1c]
08046048: bl         #0x803194c
0804604c: mov        r2, r0
0804604e: movs       r1, #0
08046050: ldr        r0, [pc, #0x2b0]
08046052: strb.w     r2, [sp, #0x1d]
08046056: bl         #0x80319d8
0804605a: mov        r5, r0
0804605c: bl         #0x802703c
08046060: mov        r2, r0
08046062: add.w      r0, sp, #0x1e
08046066: mov        r1, r5
08046068: uxtb       r2, r2
0804606a: bl         #0x804907c
0804606e: movs       r1, #0x21
08046070: add        r0, sp, #0x1c
08046072: bl         #0x8045d04
08046076: b          #0x8045e8a
08046078: add.w      sb, sp, #0x1c
0804607c: movs       r2, #0x1f
0804607e: movs       r1, #0
08046080: add.w      r8, sp, #0x3a
08046084: mov        r0, sb
08046086: mov        r5, sb
08046088: bl         #0x8048f2a
0804608c: rsb.w      r7, sb, #0x46
08046090: movs       r3, #0x50
08046092: ldr        r6, [pc, #0x270]
08046094: strb.w     r3, [sp, #0x1c]
08046098: adds       r2, r7, r5
0804609a: movs       r1, #0
0804609c: mov        r0, r6
0804609e: uxtb       r2, r2
080460a0: bl         #0x8031a28
080460a4: strb       r0, [r5, #1]!
080460a8: cmp        r5, r8
080460aa: bne        #0x8046098
080460ac: movs       r1, #0x1f
080460ae: mov        r0, sb
080460b0: bl         #0x8045d04
080460b4: b          #0x8045e8a
080460b6: ldr        r5, [pc, #0x250]
080460b8: mov        r0, r5
080460ba: bl         #0x8034be4
080460be: movs       r2, #0x48
080460c0: ldrb.w     r3, [r5, #0x1be]
080460c4: movs       r1, #2
080460c6: add        r0, sp, #0x1c
080460c8: strb.w     r2, [sp, #0x1c]
080460cc: strb.w     r3, [sp, #0x1d]
080460d0: bl         #0x8045d04
080460d4: b          #0x8045e8a
080460d6: adds       r3, #2
080460d8: subs       r2, r2, r3
080460da: cmp        r2, #3
080460dc: bls.w      #0x80462c8
080460e0: ldrb       r0, [r6, #2]
080460e2: ldrb       r1, [r6, #1]
080460e4: ldrb       r2, [r5, r7]
080460e6: orr.w      r1, r1, r0, lsl #7
080460ea: ldrb       r3, [r6, #3]
080460ec: cmp        r1, #0x86
080460ee: bgt.w      #0x8045e8a
080460f2: uxtb       r1, r1
080460f4: ldr        r0, [pc, #0x20c]
080460f6: bl         #0x8032178
080460fa: b          #0x8045e8a
080460fc: ldrb       r2, [r5, r7]
080460fe: movs       r1, #1
08046100: ldr        r0, [pc, #0x204]
08046102: bl         #0x80347d4
08046106: movs       r1, #1
08046108: ldr        r0, [pc, #0x1fc]
0804610a: bl         #0x803488c
0804610e: mov        r5, r0
08046110: movs       r1, #1
08046112: ldr        r0, [pc, #0x1f8]
08046114: uxtb       r5, r5
08046116: adds       r2, r5, r1
08046118: uxtb       r2, r2
0804611a: bl         #0x803ad00
0804611e: movs       r3, #0x46
08046120: movs       r1, #2
08046122: add        r0, sp, #0x1c
08046124: strb.w     r3, [sp, #0x1c]
08046128: strb.w     r5, [sp, #0x1d]
0804612c: bl         #0x8045d04
08046130: b          #0x8045e8a
08046132: adds       r0, r3, #2
08046134: mov        r1, r6
08046136: movs       r3, #1
08046138: subs       r2, r2, r0
0804613a: ldr        r0, [pc, #0x1c8]
0804613c: bl         #0x8032148
08046140: b          #0x8045e8a
08046142: adds       r3, #2
08046144: subs       r3, r2, r3
08046146: cmp        r3, #0x8b
08046148: bne.w      #0x80462c0
0804614c: ldrb.w     ip, [r5, r7]
08046150: ldrb.w     sl, [r6, #1]
08046154: add.w      r8, ip, #0x45
08046158: ldrb.w     fp, [r6, #2]
0804615c: uxtb.w     r8, r8
08046160: cmp.w      r8, #0x63
08046164: bhi.w      #0x80462c0
08046168: movs       r1, #1
0804616a: ldr        r2, [pc, #0x1a4]
0804616c: add.w      sb, sp, #0xc
08046170: movs       r3, #0
08046172: str        r1, [sp]
08046174: adds       r6, #3
08046176: strb.w     r3, [sp, #0x1a]
0804617a: strh.w     r3, [sp, #0x18]
0804617e: ldm        r2, {r0, r1, r2}
08046180: stm.w      sb, {r0, r1, r2}
08046184: mov        r1, ip
08046186: movs       r2, #2
08046188: add        r0, sp, #8
0804618a: bl         #0x803da64
0804618e: add        r1, sp, #8
08046190: mov        r0, sb
08046192: bl         #0x8048f3a
08046196: mov        r3, fp
08046198: mov        r2, sl
0804619a: mov        r1, r8
0804619c: ldr        r0, [pc, #0x16c]
0804619e: add.w      r8, r8, r8, lsl #2
080461a2: str.w      sb, [sp, #4]
080461a6: str        r6, [sp]
080461a8: bl         #0x803b3bc
080461ac: ldr        r3, [pc, #0x164]
080461ae: ldrb       r2, [r5, r7]
080461b0: ldr        r5, [r3]
080461b2: movs       r3, #0x36
080461b4: strb.w     r2, [sp, #0x1d]
080461b8: movs       r2, #0x1e
080461ba: add.w      r5, r5, r8, lsl #3
080461be: strb.w     r3, [sp, #0x1c]
080461c2: add.w      r0, sp, r2
080461c6: mov        r1, r5
080461c8: bl         #0x804907c
080461cc: ldrh       r3, [r5, #0x24]
080461ce: movs       r2, #0x87
080461d0: add.w      r0, sp, #0x3e
080461d4: strh.w     r3, [sp, #0x3c]
080461d8: ldr        r1, [r5, #0x20]
080461da: bl         #0x804907c
080461de: movs       r1, #0xa9
080461e0: add        r0, sp, #0x1c
080461e2: bl         #0x8045d04
080461e6: b          #0x8045e8a
080461e8: ldrb       r1, [r5, r7]
080461ea: ldr        r0, [pc, #0x11c]
080461ec: bl         #0x8035118
080461f0: movs       r1, #0
080461f2: ldr        r0, [pc, #0x118]
080461f4: bl         #0x803a8e8
080461f8: b          #0x8045e8a
080461fa: ldr        r0, [pc, #0x10c]
080461fc: bl         #0x8035600
08046200: movs       r3, #0x43
08046202: ldr        r0, [pc, #0x104]
08046204: strb.w     r3, [sp, #0x1c]
08046208: bl         #0x8035188
0804620c: mov        r3, r0
0804620e: movs       r1, #2
08046210: add        r0, sp, #0x1c
08046212: strb.w     r3, [sp, #0x1d]
08046216: bl         #0x8045d04
0804621a: b          #0x8045e8a
0804621c: ldrb       r1, [r5, r7]
0804621e: cmp        r1, #0xb
08046220: bhi        #0x80462c0
08046222: ldr        r0, [pc, #0xe4]
08046224: bl         #0x8034928
08046228: ldr        r0, [pc, #0xe0]
0804622a: bl         #0x803a9e8
0804622e: movs       r1, #1
08046230: ldr        r0, [pc, #0xd0]
08046232: bl         #0x803194c
08046236: movs       r1, #1
08046238: mov        r0, r6
0804623a: bl         #0x8045d04
0804623e: b          #0x8045e8a
08046240: ldrb       r2, [r5, r7]
08046242: movs       r1, #0
08046244: ldr        r0, [pc, #0xc0]
08046246: bl         #0x80347d4
0804624a: movs       r1, #0
0804624c: ldr        r0, [pc, #0xb8]
0804624e: bl         #0x803488c
08046252: mov        r5, r0
08046254: movs       r1, #0
08046256: ldr        r0, [pc, #0xb4]
08046258: uxtb       r5, r5
0804625a: mov        r2, r5
0804625c: bl         #0x803ad00
08046260: movs       r3, #0x45
08046262: b          #0x8046120
08046264: adds       r0, r3, #2
08046266: mov        r1, r6
08046268: movs       r3, #0
0804626a: subs       r2, r2, r0
0804626c: ldr        r0, [pc, #0x94]
0804626e: bl         #0x8032148
08046272: b          #0x8045e8a
08046274: add.w      sb, sp, #0x1c
08046278: b          #0x8045fa0
0804627a: ldrb.w     r8, [r5, #6]
0804627e: sub.w      r3, r8, #0x71
08046282: cmp        r3, #2
08046284: bhi        #0x80462b2
08046286: ldr        r6, [pc, #0x90]
08046288: ldr        r7, [pc, #0x90]
0804628a: add.w      sb, r6, #0x85
0804628e: subs       r0, r6, #7
08046290: mov        ip, r7
08046292: ldrb       r1, [r7, #7]
08046294: and        r3, r1, #1
08046298: ldrb       lr, [ip], #1
0804629c: lsrs       r1, r1, #1
0804629e: orr.w      r3, r3, lr, lsl #1
080462a2: strb       r3, [r0], #1
080462a6: cmp        r0, r6
080462a8: bne        #0x8046294
080462aa: adds       r6, #7
080462ac: adds       r7, #8
080462ae: cmp        r6, sb
080462b0: bne        #0x804628e
080462b2: ldr        r6, [pc, #0x6c]
080462b4: movs       r3, #6
080462b6: movs       r7, #7
080462b8: b          #0x8045dd8
080462ba: ldr        r2, [pc, #0x68]
080462bc: ldr        r3, [pc, #0x68]
080462be: b          #0x8045ea0
080462c0: movs       r0, #4
080462c2: bl         #0x8045cd8
080462c6: b          #0x8045e8a
080462c8: bne.w      #0x8045e8a
080462cc: ldrb       r3, [r6, #2]
080462ce: ldrb       r2, [r5, r7]
080462d0: ldrb       r1, [r6, #1]
080462d2: ldr        r0, [pc, #0x30]
080462d4: bl         #0x8032178
080462d8: b          #0x8045e8a
080462da: mov        r0, r5
080462dc: bl         #0x80456f8
080462e0: b          #0x8045f28
080462e2: ldr        r3, [pc, #0x48]
080462e4: movs       r2, #0
080462e6: ldr        r0, [pc, #0x48]
080462e8: strb       r2, [r3]
080462ea: bl         #0x803ff38
080462ee: mov        r1, r0
080462f0: ldr        r0, [pc, #0x3c]
080462f2: bl         #0x802eea0
080462f6: b          #0x8045e8a
080462f8: ldr        r3, [r0], #4
080462fc: blx        r3
080462fe: mov        r3, r0
08046300: b          #0x8045efa
08046302: nop        
08046304: ldr        r4, [sp, #0x240]
08046306: movs       r4, #4
08046308: str        r5, [sp, #0x240]
0804630a: movs       r4, #4
0804630c: str        r1, [sp, #0x20]
0804630e: movs       r4, #4
08046310: str        r3, [sp, #0xe0]
08046312: lsrs       r4, r0, #0x20
08046314: lsls       r4, r0, #5
08046316: movs       r4, #0
08046318: .byte      0x0b, 0xfc
0804631a: movs       r4, #4
0804631c: mla        r4, pc, r4, r2
08046320: mla        r4, fp, r4, r2
08046324: lsls       r0, r6, #3
08046326: lsrs       r2, r4, #0x10
08046328: ldrb       r1, [r0]
0804632a: blx        #0x7b47cb8
0804632e: movs       r4, #4
08046330: mla        r4, r4, r4, r2
