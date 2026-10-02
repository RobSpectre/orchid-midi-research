; range 0x8034b80 to 0x8034c90
08034b80: eors     r0, r6
08034b82: b.w      #0x80386a0
08034b86: nop      
08034b88: adr      r1, #0x140
08034b8a: lsrs     r4, r0, #0x20
08034b8c: lsrs     r1, r6, #0x10
08034b8e: adds     r0, #0xc3
08034b90: adds     r1, #0xcc
08034b92: lsrs     r7, r0, #0x20
08034b94: adds     r2, #0xb8
08034b96: lsrs     r7, r0, #0x20
08034b98: bxns     r0
08034b9a: lsrs     r7, r0, #0x20
08034b9c: ldrb.w   r1, [r0, #0x3c]
08034ba0: eor      r1, r1, #1
08034ba4: b.w      #0x8034ae8
08034ba8: ldrsb.w  r3, [r0, #0x585]
08034bac: add      r3, r0
08034bae: ldrb.w   r0, [r3, #0x1a3]
08034bb2: bx       lr
08034bb4: push     {r4, lr}
08034bb6: movs     r1, #1
08034bb8: ldrb.w   r2, [r0, #0x112]
08034bbc: mov      r4, r0
08034bbe: ldr      r0, [r0]
08034bc0: eors     r2, r1
08034bc2: strb.w   r2, [r4, #0x112]
08034bc6: bl       #0x8036ed4
08034bca: ldrb.w   r3, [r4, #0x112]
08034bce: movs     r1, #0
08034bd0: ldr      r0, [r4, #4]
08034bd2: movs     r2, #0x75
08034bd4: cmp      r3, r1
08034bd6: pop.w    {r4, lr}
08034bda: ite      ne
08034bdc: movne    r3, #0x7f
08034bde: moveq    r3, r1
08034be0: b.w      #0x8031f68
08034be4: push     {r4, lr}
08034be6: ldrb.w   r2, [r0, #0x1be]
08034bea: mov      r4, r0
08034bec: movs     r1, #2
08034bee: ldr      r0, [r0]
08034bf0: eor      r2, r2, #1
08034bf4: strb.w   r2, [r4, #0x1be]
08034bf8: bl       #0x8036ed4
08034bfc: ldrb.w   r3, [r4, #0x1be]
08034c00: movs     r1, #0
08034c02: ldr      r0, [r4, #4]
08034c04: movs     r2, #0x76
08034c06: cmp      r3, r1
08034c08: pop.w    {r4, lr}
08034c0c: ite      ne
08034c0e: movne    r3, #0x7f
08034c10: moveq    r3, r1
08034c12: b.w      #0x8031f68
08034c16: nop      
08034c18: ldr      r3, [pc, #0x64]
08034c1a: ldrsb.w  ip, [r0, #0x585]
08034c1e: strh.w   r1, [r0, #0x58c]
08034c22: sub.w    r2, ip, #4
08034c26: sdiv     r3, r3, r1
08034c2a: uxtb     r2, r2
08034c2c: vmov     s15, r3
08034c30: cmp      r2, #1
08034c32: vcvt.f32.s32 s15, s15
08034c36: bls      #0x8034c62
08034c38: vmov     s14, r1
08034c3c: vrintm.f32 s15, s15
08034c40: vcvt.s32.f32 s15, s15
08034c44: vcvt.f64.s32 d6, s14
08034c48: vldr     d4, [pc, #0x2c]
08034c4c: vmov     r3, s15
08034c50: vdiv.f64 d5, d4, d6
08034c54: strh.w   r3, [r0, #0x1c2]
08034c58: vcvt.f32.f64 s10, d5
08034c5c: vstr     s10, [r0, #0x2dc]
08034c60: bx       lr
08034c62: add      ip, r0
08034c64: ldrb.w   r3, [ip, #0x1a3]
08034c68: cmp      r3, #3
08034c6a: bls      #0x8034c38
08034c6c: vmov.f32 s14, #5.000000e-01
08034c70: vmul.f32 s15, s15, s14
08034c74: b        #0x8034c38
08034c76: nop      
08034c78: movs     r0, r0
08034c7a: movs     r0, r0
08034c7c: cmp      r7, #0xf8
08034c7e: lsls     r4, r0
08034c80: cmn      r7, r7
08034c82: movs     r1, r0
08034c84: movs     r0, r0
08034c86: movs     r0, r0
08034c88: push     {r4, r5, r6, lr}
08034c8a: ldrsb.w  r6, [r0, #0x585]
08034c8e: mov      r5, r1
; range 0x8039f64 to 0x803a034
08039f64: push     {r4, r5, r6, lr}
08039f66: ldr      r3, [r0, #0x14]
08039f68: mov      r4, r0
08039f6a: mov      r6, r1
08039f6c: ldr.w    r5, [r3, #0xc10]
08039f70: mov      r0, r5
08039f72: bl       #0x80422b0
08039f76: ldr      r3, [r4, #4]
08039f78: ldrb.w   r2, [r3, #0x15e]
08039f7c: cmp      r2, #9
08039f7e: beq      #0x8039fac
08039f80: ldrb.w   r3, [r5, #0x12f]
08039f84: cbnz     r3, #0x8039f98
08039f86: mov      r0, r5
08039f88: bl       #0x80420b4
08039f8c: ldr      r0, [r4, #4]
08039f8e: movs     r1, #2
08039f90: pop.w    {r4, r5, r6, lr}
08039f94: b.w      #0x8038808
08039f98: mov      r1, r6
08039f9a: mov      r0, r5
08039f9c: bl       #0x804208c
08039fa0: ldr      r0, [r4, #4]
08039fa2: movs     r1, #2
08039fa4: pop.w    {r4, r5, r6, lr}
08039fa8: b.w      #0x8038808
08039fac: ldrb.w   r3, [r3, #0x160]
08039fb0: cmp      r3, r0
08039fb2: bne      #0x8039f80
08039fb4: cmp      r3, #0xb
08039fb6: beq      #0x8039fc4
08039fb8: mov      r1, r6
08039fba: mov      r0, r4
08039fbc: pop.w    {r4, r5, r6, lr}
08039fc0: b.w      #0x8039ab0
08039fc4: mov      r1, r6
08039fc6: mov      r0, r4
08039fc8: pop.w    {r4, r5, r6, lr}
08039fcc: b.w      #0x8039a48
08039fd0: push     {r4, r5, r6, r7, lr}
08039fd2: movs     r7, #0
08039fd4: mov      r6, r2
08039fd6: mov      r4, r0
08039fd8: movs     r3, #0xc8
08039fda: vpush    {d8}
08039fde: sub      sp, #0xc
08039fe0: ldr      r2, [r0]
08039fe2: ldrsh.w  r0, [r2, #0x58c]
08039fe6: movs     r2, #0x3c
08039fe8: str      r7, [sp]
08039fea: bl       #0x803db28
08039fee: mov      r5, r0
08039ff0: mov      r1, r0
08039ff2: ldr      r0, [r4]
08039ff4: bl       #0x8034c18
08039ff8: ldr      r3, [pc, #0x88]
08039ffa: ldr      r2, [r4, #0xc]
08039ffc: sdiv     r3, r3, r5
0803a000: strh.w   r3, [r2, #0x372]
0803a004: uxtb     r3, r5
0803a006: ldr      r0, [r4, #0xc]
0803a008: movs     r2, #0x70
0803a00a: ldrh.w   r1, [r0, #0x372]
0803a00e: subs     r1, #0x14
0803a010: strh.w   r1, [r0, #0x374]
0803a014: mov      r1, r7
0803a016: ldr      r0, [r4, #8]
0803a018: bl       #0x8031f68
0803a01c: ldr      r3, [r4, #0xc]
0803a01e: vmov     s15, r5
0803a022: movs     r2, #4
0803a024: ldrb.w   r1, [r3, #0x370]
0803a028: ldr      r3, [r4, #8]
0803a02a: vcvt.f32.s32 s16, s15
0803a02e: ldr      r0, [r3]
0803a030: vmov.f32 s0, s16
; range 0x803488c to 0x80348b8
0803488c: add.w    r0, r0, r1, lsl #1
08034890: ldrsh.w  r0, [r0, #0x3e]
08034894: bx       lr
08034896: nop      
08034898: push     {r4, r5, lr}
0803489a: mov      r4, r0
0803489c: sub      sp, #0x94
0803489e: ldrb.w   r2, [r0, #0x584]
080348a2: cbnz     r1, #0x803490c
080348a4: movs     r1, #1
080348a6: ldr      r0, [r4, #4]
080348a8: bl       #0x8031908
080348ac: movs     r3, #1
080348ae: ldrb.w   r2, [r4, #0x584]
080348b2: mov      r0, r4
080348b4: mov      r1, r3
080348b6: .byte    0xff, 0xf7
