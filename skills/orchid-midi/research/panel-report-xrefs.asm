
; 0x8034836 -> #0x8031f68
08034814: bne      #0x8034802
08034816: mov      r0, r4
08034818: movs     r1, #0
0803481a: pop.w    {r4, r5, r6, lr}
0803481e: b.w      #0x8034198
08034822: mov      r0, r4
08034824: movs     r1, #1
08034826: pop.w    {r4, r5, r6, lr}
0803482a: b.w      #0x8033b9c
0803482e: ldrb.w   r3, [r4, #0x3e]
08034832: movs     r2, #0x73
08034834: ldr      r0, [r4, #4]
08034836: bl       #0x8031f68
0803483a: b        #0x8034808
0803483c: .byte    0x94, 0xf8

; 0x8034848 -> #0x8031f68
08034826: pop.w    {r4, r5, r6, lr}
0803482a: b.w      #0x8033b9c
0803482e: ldrb.w   r3, [r4, #0x3e]
08034832: movs     r2, #0x73
08034834: ldr      r0, [r4, #4]
08034836: bl       #0x8031f68
0803483a: b        #0x8034808
0803483c: ldrb.w   r3, [r4, #0x40]
08034840: movs     r2, #0x74
08034842: ldr      r0, [r4, #4]
08034844: pop.w    {r4, r5, r6, lr}
08034848: b.w      #0x8031f68
0803484c: adds     r1, #0x34
0803484e: lsrs     r7, r0, #0x20

; 0x80348c4 -> #0x8031f68
080348a2: cbnz     r1, #0x803490c
080348a4: movs     r1, #1
080348a6: ldr      r0, [r4, #4]
080348a8: bl       #0x8031908
080348ac: movs     r3, #1
080348ae: ldrb.w   r2, [r4, #0x584]
080348b2: mov      r0, r4
080348b4: mov      r1, r3
080348b6: bl       #0x8033c2c
080348ba: movs     r2, #0x6d
080348bc: ldrb.w   r3, [r4, #0x584]
080348c0: movs     r1, #1
080348c2: ldr      r0, [r4, #4]
080348c4: bl       #0x8031f68
080348c8: ldrb.w   r0, [r4, #0x584]

; 0x8034986 -> #0x8031f68
08034964: movs     r4, #0x2a
08034966: mov      r5, r0
08034968: mls      r3, r4, r3, r1
0803496c: cmp      r3, #0x14
0803496e: strb.w   r3, [r0, #0x38]
08034972: ble      #0x80349de
08034974: ldr      r2, [pc, #0x70]
08034976: add      r2, r3
08034978: ldrb     r0, [r2, #-0x15]
0803497c: movs     r1, #0
0803497e: uxtb     r3, r3
08034980: strh     r0, [r5, #0x3a]
08034982: movs     r2, #0x6b
08034984: ldr      r0, [r5, #4]
08034986: bl       #0x8031f68
0803498a: ldrsb.w  ip, [r5, #0x38]

; 0x8034b18 -> #0x8031f68
08034af6: bl       #0x80367e8
08034afa: movs     r1, #3
08034afc: ldrb.w   r2, [r4, #0x3c]
08034b00: ldr      r0, [r4]
08034b02: bl       #0x8036ed4
08034b06: ldrb.w   r3, [r4, #0x3c]
08034b0a: movs     r1, #0
08034b0c: movs     r2, #0x6c
08034b0e: ldr      r0, [r4, #4]
08034b10: cmp      r3, r1
08034b12: ite      ne
08034b14: movne    r3, #0x7f
08034b16: moveq    r3, r1
08034b18: bl       #0x8031f68
08034b1c: ldrb.w   r3, [r4, #0x3c]

; 0x8034be0 -> #0x8031f68
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
08034be6: .byte    0x90, 0xf8

; 0x8034c12 -> #0x8031f68
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

; 0x8034cfa -> #0x8031f68
08034cd8: ldrb     r7, [r4, #0xb]
08034cda: vmov     r3, s15
08034cde: strh.w   r3, [r4, #0x2d0]
08034ce2: cbnz     r2, #0x8034ce8
08034ce4: add      sp, #8
08034ce6: pop      {r4, r5, r6, pc}
08034ce8: ldrb.w   r3, [r1, #0x1ac]
08034cec: movs     r2, #0x67
08034cee: ldr      r0, [r4, #4]
08034cf0: movs     r1, #0
08034cf2: subs     r5, r5, r3
08034cf4: movs     r6, #0
08034cf6: uxtb     r5, r5
08034cf8: mov      r3, r5
08034cfa: bl       #0x8031f68
08034cfe: ldrsb.w  r1, [r4, #0x585]

; 0x8034d24 -> #0x8034c18
08034d02: movs     r3, #1
08034d04: ldr      r0, [r4]
08034d06: add.w    r1, r4, r1, lsl #4
08034d0a: mov      r2, r5
08034d0c: str      r3, [sp]
08034d0e: movs     r3, #2
08034d10: addw     r1, r1, #0x113
08034d14: str      r6, [sp, #4]
08034d16: bl       #0x803674c
08034d1a: add      sp, #8
08034d1c: pop      {r4, r5, r6, pc}
08034d1e: ldrsh.w  r1, [r4, #0x58c]
08034d22: mov      r0, r4
08034d24: bl       #0x8034c18
08034d28: add.w    r2, r4, r6, lsl #4

; 0x8034e6e -> #0x8034c18
08034e4c: lsls     r2, r0, #0x12
08034e4e: lsls     r4, r0, #0x10
08034e50: lsls     r0, r2, #1
08034e52: movs     r5, #0
08034e54: movs     r7, #1
08034e56: ldrsh.w  r1, [r0, #0x58c]
08034e5a: strb.w   r5, [r0, #0x2d3]
08034e5e: strb.w   r5, [r0, #0x2d6]
08034e62: strb.w   r7, [r0, #0x1c0]
08034e66: strh.w   r5, [r0, #0x2ca]
08034e6a: strh.w   r5, [r0, #0x2cc]
08034e6e: bl       #0x8034c18
08034e72: cmp      r6, #0
08034e74: .byte    0x40, 0xf0

; 0x8035072 -> #0x8031f68
08035050: ldr      r0, [r4, #4]
08035052: bl       #0x8031908
08035056: mov      r3, r7
08035058: ldrb.w   r2, [r4, #0x583]
0803505c: mov      r1, r5
0803505e: mov      r0, r4
08035060: bl       #0x8033c2c
08035064: cbnz     r6, #0x80350cc
08035066: ldr      r6, [pc, #0xac]
08035068: ldrb.w   r3, [r4, #0x583]
0803506c: movs     r2, #0x66
0803506e: movs     r1, #0
08035070: ldr      r0, [r4, #4]
08035072: bl       #0x8031f68
08035076: ldr      r3, [r6]
08035078: .byte    0x0f, 0xfa

; 0x80353c8 -> #0x8031f68
080353a6: asrs     r2, r1, #0x16
080353a8: lsls     r2, r2, #1
080353aa: uxtb     r2, r2
080353ac: orr      r1, r2, #1
080353b0: cmp      r3, #3
080353b2: bhi      #0x8035402
080353b4: tbb      [pc, r3]
080353b8: adds     r2, r0, r4
080353ba: lsrs     r0, r4, #8
080353bc: movs     r2, #1
080353be: strb     r1, [r0, #0x10]
080353c0: strb     r2, [r0, #0xf]
080353c2: movs     r2, #0x6e
080353c4: movs     r1, #1
080353c6: ldr      r0, [r0, #4]
080353c8: b.w      #0x8031f68
080353cc: strb     r2, [r0, #0x10]
080353ce: strb     r2, [r0, #0xf]

; 0x80353e6 -> #0x8031f68
080353c4: movs     r1, #1
080353c6: ldr      r0, [r0, #4]
080353c8: b.w      #0x8031f68
080353cc: strb     r2, [r0, #0x10]
080353ce: strb     r2, [r0, #0xf]
080353d0: cbnz     r2, #0x80353fe
080353d2: movs     r1, #1
080353d4: ldrb     r2, [r0, #0xf]
080353d6: strb     r1, [r0, #0x10]
080353d8: cmp      r2, #0
080353da: bne      #0x80353c2
080353dc: movs     r2, #1
080353de: movs     r1, #1
080353e0: strb     r2, [r0, #0xf]
080353e2: movs     r2, #0x6e
080353e4: ldr      r0, [r0, #4]
080353e6: b.w      #0x8031f68
080353ea: strb     r1, [r0, #0x10]
080353ec: movs     r2, #0x6e

; 0x80353f4 -> #0x8031f68
080353d2: movs     r1, #1
080353d4: ldrb     r2, [r0, #0xf]
080353d6: strb     r1, [r0, #0x10]
080353d8: cmp      r2, #0
080353da: bne      #0x80353c2
080353dc: movs     r2, #1
080353de: movs     r1, #1
080353e0: strb     r2, [r0, #0xf]
080353e2: movs     r2, #0x6e
080353e4: ldr      r0, [r0, #4]
080353e6: b.w      #0x8031f68
080353ea: strb     r1, [r0, #0x10]
080353ec: movs     r2, #0x6e
080353ee: strb     r1, [r0, #0xf]
080353f0: movs     r1, #1
080353f2: ldr      r0, [r0, #4]
080353f4: b.w      #0x8031f68
080353f8: strb     r1, [r0, #0x10]
080353fa: strb     r2, [r0, #0xf]

; 0x8035622 -> #0x8031f68
08035600: push     {r3, r4, r5, lr}
08035602: ldrb     r5, [r0, #0xe]
08035604: mov      r4, r0
08035606: eor      r5, r5, #1
0803560a: strb     r5, [r0, #0xe]
0803560c: bl       #0x80355b4
08035610: cmp      r5, #0
08035612: mov.w    r2, #0x6f
08035616: mov.w    r1, #1
0803561a: ite      ne
0803561c: movne    r3, #0x7f
0803561e: moveq    r3, #0
08035620: ldr      r0, [r0, #4]
08035622: bl       #0x8031f68
08035626: ldr      r1, [pc, #0x34]
08035628: ldrb     r2, [r4, #0xe]

; 0x803568c -> #0x8031f68
0803566a: ldr      r0, [r0]
0803566c: eor      r2, r2, #1
08035670: movs     r1, #2
08035672: strb.w   r2, [r4, #0x1be]
08035676: bl       #0x8036ed4
0803567a: ldrb.w   r3, [r4, #0x1be]
0803567e: movs     r1, #0
08035680: ldr      r0, [r4, #4]
08035682: movs     r2, #0x76
08035684: cmp      r3, r1
08035686: ite      eq
08035688: moveq    r3, r1
0803568a: movne    r3, #0x7f
0803568c: bl       #0x8031f68
08035690: ldrb.w   r2, [r4, #0x1be]

; 0x80356b6 -> #0x8031f68
08035694: ldr      r0, [r4]
08035696: movs     r1, #2
08035698: eor      r2, r2, #1
0803569c: strb.w   r2, [r4, #0x1be]
080356a0: bl       #0x8036ed4
080356a4: ldrb.w   r3, [r4, #0x1be]
080356a8: movs     r1, #0
080356aa: ldr      r0, [r4, #4]
080356ac: movs     r2, #0x76
080356ae: cmp      r3, r1
080356b0: ite      eq
080356b2: moveq    r3, r1
080356b4: movne    r3, #0x7f
080356b6: bl       #0x8031f68
080356ba: movs     r3, #0
080356bc: .byte    0x94, 0xf8

; 0x80356ec -> #0x8031f68
080356ca: movs     r1, #0x12
080356cc: movs     r1, #1
080356ce: ldr      r0, [r4]
080356d0: eors     r2, r1
080356d2: strb.w   r2, [r4, #0x112]
080356d6: bl       #0x8036ed4
080356da: ldrb.w   r3, [r4, #0x112]
080356de: movs     r1, #0
080356e0: ldr      r0, [r4, #4]
080356e2: movs     r2, #0x75
080356e4: cmp      r3, r1
080356e6: ite      eq
080356e8: moveq    r3, r1
080356ea: movne    r3, #0x7f
080356ec: bl       #0x8031f68
080356f0: ldrb.w   r2, [r4, #0x112]

; 0x8035714 -> #0x8031f68
080356f2: movs     r1, #0x12
080356f4: movs     r1, #1
080356f6: ldr      r0, [r4]
080356f8: eors     r2, r1
080356fa: strb.w   r2, [r4, #0x112]
080356fe: bl       #0x8036ed4
08035702: ldrb.w   r3, [r4, #0x112]
08035706: movs     r1, #0
08035708: ldr      r0, [r4, #4]
0803570a: movs     r2, #0x75
0803570c: cmp      r3, r1
0803570e: ite      eq
08035710: moveq    r3, r1
08035712: movne    r3, #0x7f
08035714: bl       #0x8031f68
08035718: ldrb.w   r0, [r4, #0x1be]

; 0x803592a -> #0x8031f68
08035908: adds     r5, #0x54
0803590a: mov      r3, r5
0803590c: strb.w   r5, [r4, #0x558]
08035910: bl       #0x80364b8
08035914: ldrb     r3, [r4, #0xe]
08035916: movs     r2, #0x6e
08035918: mov      r1, r6
0803591a: lsls     r3, r6
0803591c: ldr      r0, [r4, #4]
0803591e: strb.w   r5, [r4, #0x58a]
08035922: orrs     r3, r6
08035924: strb     r6, [r4, #0xf]
08035926: strb     r3, [r4, #0x10]
08035928: mov      r3, r5
0803592a: bl       #0x8031f68
0803592e: mov      r1, r5
08035930: ldr      r0, [r4, #4]

; 0x80359e2 -> #0x8031f68
080359c0: ldr      r3, [r4, #4]
080359c2: mov      r0, r4
080359c4: strb.w   r2, [r3, #0x143]
080359c8: add      sp, #8
080359ca: pop.w    {r4, r5, r6, r7, r8, sb, sl, pc}
080359ce: ldrsh.w  r3, [r4, #0x40]
080359d2: cmp      r3, r0
080359d4: beq      #0x803599c
080359d6: uxtb     r3, r0
080359d8: strh.w   r0, [r4, #0x40]
080359dc: movs     r2, #0x74
080359de: mov      r1, r6
080359e0: ldr      r0, [r4, #4]
080359e2: bl       #0x8031f68
080359e6: b        #0x803599c
080359e8: str      r1, [sp, #0xe0]

; 0x8035a4c -> #0x8031f68
08035a2a: bl       #0x803501c
08035a2e: movs     r2, #0x18
08035a30: mov      r1, r5
08035a32: mov      r0, r4
08035a34: bl       #0x80347d4
08035a38: ldrsh.w  r3, [r4, #0x40]
08035a3c: cmp      r3, #0x17
08035a3e: beq      #0x8035a50
08035a40: movs     r3, #0x17
08035a42: movs     r2, #0x74
08035a44: mov      r1, r6
08035a46: ldr      r0, [r4, #4]
08035a48: strh.w   r3, [r4, #0x40]
08035a4c: bl       #0x8031f68
08035a50: ldr      r0, [r4, #4]
08035a52: movs     r1, #0x4b

; 0x8035a70 -> #0x8031f68
08035a4e: .byte    0x8c, 0xfa
08035a50: ldr      r0, [r4, #4]
08035a52: movs     r1, #0x4b
08035a54: bl       #0x8032288
08035a58: movs     r5, #1
08035a5a: movs     r6, #0
08035a5c: mov.w    r2, #0x100
08035a60: mov      r1, r5
08035a62: ldr      r0, [r4, #4]
08035a64: mov      r3, r6
08035a66: strh     r2, [r4, #0xe]
08035a68: strb.w   r6, [r4, #0x58a]
08035a6c: movs     r2, #0x6e
08035a6e: strb     r5, [r4, #0x10]
08035a70: bl       #0x8031f68
08035a74: mov      r1, r6
08035a76: mov      r0, r4

; 0x8036148 -> #0x8031f68
08036126: ldrb     r6, [r0, #0xf]
08036128: vstr     s15, [sp, #0xc]
0803612c: ldrb.w   r6, [sp, #0xc]
08036130: mov      r2, r6
08036132: mov      r1, r4
08036134: mov      r0, r5
08036136: bl       #0x8035f18
0803613a: mov      r3, r6
0803613c: movs     r2, #0x69
0803613e: movs     r1, #0
08036140: ldr      r0, [r5]
08036142: add      sp, #0x10
08036144: pop.w    {r4, r5, r6, r7, r8, lr}
08036148: b.w      #0x8031f68
0803614c: ldr      r3, [r0]
0803614e: ldr      r3, [r3]

; 0x80392aa -> #0x8031f68
08039288: ldrsb.w  r3, [r3, #0x585]
0803928c: strb.w   r3, [r5, #0x8c]
08039290: bl       #0x8039218
08039294: mov      r1, r7
08039296: ldr      r0, [r4, #4]
08039298: add      sp, #0xc
0803929a: pop.w    {r4, r5, r6, r7, lr}
0803929e: b.w      #0x8038808
080392a2: movs     r3, #0x7f
080392a4: movs     r2, #0x68
080392a6: movs     r1, #0
080392a8: ldr      r0, [r0, #8]
080392aa: bl       #0x8031f68
080392ae: mov      r0, r5
080392b0: .byte    0x08, 0xf0

; 0x8039478 -> #0x8031f68
08039456: pop.w    {r4, r5, r6, r7, lr}
0803945a: b.w      #0x80386ac
0803945e: ldrb.w   r3, [r5, #0x8c]
08039462: mov      r0, r5
08039464: subs     r3, #1
08039466: strb.w   r3, [r4, #0x33]
0803946a: bl       #0x8042034
0803946e: ldrb.w   r3, [r4, #0x33]
08039472: ldr      r0, [r4, #8]
08039474: movs     r2, #0x6a
08039476: movs     r1, #0
08039478: bl       #0x8031f68
0803947c: ldr      r3, [r4, #0x10]
0803947e: movs     r2, #0

; 0x80394ec -> #0x8031f68
080394ca: adds     r0, #0x8c
080394cc: mov      r0, r5
080394ce: subs     r3, #1
080394d0: strb.w   r3, [r4, #0x33]
080394d4: bl       #0x8042034
080394d8: mov      r0, r5
080394da: bl       #0x80422b0
080394de: cmp      r0, #6
080394e0: bne      #0x8039442
080394e2: ldrb.w   r3, [r4, #0x33]
080394e6: movs     r2, #0x6a
080394e8: ldr      r0, [r4, #8]
080394ea: movs     r1, #0
080394ec: bl       #0x8031f68
080394f0: movs     r2, #0
080394f2: .byte    0x94, 0xf8

; 0x8039ff4 -> #0x8034c18
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

; 0x803a018 -> #0x8031f68
08039ff6: vselvs.f64 d4, d0, d18
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
0803a01e: .byte    0x07, 0xee

; 0x803ac2c -> #0x8031f68
0803ac0a: movs     r3, #4
0803ac0c: mov      r2, r0
0803ac0e: ldr      r1, [pc, #0xe8]
0803ac10: mov      r0, r6
0803ac12: sxth     r2, r2
0803ac14: str      r3, [sp]
0803ac16: str      r7, [sp, #4]
0803ac18: movs     r3, #2
0803ac1a: bl       #0x803674c
0803ac1e: mov      r3, r5
0803ac20: movs     r2, #0x71
0803ac22: mov      r1, r7
0803ac24: ldr      r0, [r4, #8]
0803ac26: add      sp, #8
0803ac28: pop.w    {r4, r5, r6, r7, r8, lr}
0803ac2c: b.w      #0x8031f68
0803ac30: add      sp, #8
0803ac32: .byte    0xbd, 0xe8

; 0x803c9e0 -> #0x8034c18
0803c9be: strb.w   r3, [r4, #0x37a]
0803c9c2: bl       #0x803d6fc
0803c9c6: ldrb.w   r1, [r8, #0x5c]
0803c9ca: ldr      r0, [r4]
0803c9cc: bl       #0x8035118
0803c9d0: ldrb.w   r1, [r8, #0x5d]
0803c9d4: ldr      r0, [r4]
0803c9d6: bl       #0x8034928
0803c9da: ldr      r0, [r4]
0803c9dc: ldrsh.w  r1, [r5, #0x5a]
0803c9e0: bl       #0x8034c18
0803c9e4: ldrh.w   r1, [r5, #0x5a]
