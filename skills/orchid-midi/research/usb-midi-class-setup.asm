0802f128: subs     r1, r1, r6
0802f12a: subs     r0, #0
0802f12c: subs     r4, r1, r6
0802f12e: subs     r0, #0
0802f130: ldr      r2, [pc, #0x14]
0802f132: ldr      r3, [r2]
0802f134: cmp.w    r3, #0x3e8
0802f138: bhs      #0x802f13e
0802f13a: adds     r3, #1
0802f13c: str      r3, [r2]
0802f13e: ldr      r3, [pc, #0xc]
0802f140: ldr.w    r0, [r3, #0x2c8]
0802f144: b.w      #0x802b658
0802f148: asrs     r4, r2, #1
0802f14a: subs     r0, #0
0802f14c: asrs     r4, r4, #0x1e
0802f14e: subs     r0, #0
0802f150: movs     r0, #0
0802f152: ldr      r3, [pc, #8]
0802f154: str.w    r0, [r3, #0x80]
0802f158: b.w      #0x802ee14
0802f15c: add      r0, r0
0802f15e: ldr      r2, [r0, r0]
0802f160: ldr      r3, [pc, #0x24]
0802f162: ldrb     r0, [r3]
0802f164: cbz      r0, #0x802f174
0802f166: ldr      r3, [pc, #0x24]
0802f168: ldr      r0, [r3]
0802f16a: cmp      r0, #1
0802f16c: ite      ls
0802f16e: movls    r0, #0
0802f170: movhi    r0, #1
0802f172: bx       lr
0802f174: ldr      r2, [pc, #0x18]
0802f176: ldrb.w   r2, [r2, #0x29c]
0802f17a: cmp      r2, #3
0802f17c: ite      eq
0802f17e: moveq    r2, #1
0802f180: movne    r2, #0
0802f182: strb     r2, [r3]
0802f184: beq      #0x802f166
0802f186: bx       lr
0802f188: asrs     r0, r2, #1
0802f18a: subs     r0, #0
0802f18c: asrs     r4, r2, #1
0802f18e: subs     r0, #0
