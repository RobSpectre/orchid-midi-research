0803f5c0: ldr.w    sp, [pc, #0x78]
0803f5c4: bl       #0x803f668
0803f5c8: mov.w    r2, #0x24000000
0803f5cc: ldr      r3, [pc, #0x70]
0803f5ce: movs     r4, #0
0803f5d0: movs     r5, #0
0803f5d2: movs     r6, #0
0803f5d4: movs     r7, #0
0803f5d6: stm      r2!, {r4, r5, r6, r7}
0803f5d8: cmp      r2, r3
0803f5da: blo      #0x803f5d6
0803f5dc: mov.w    r2, #0x30000000
0803f5e0: ldr      r3, [pc, #0x60]
0803f5e2: stm      r2!, {r4, r5, r6, r7}
0803f5e4: cmp      r2, r3
0803f5e6: blo      #0x803f5e2
0803f5e8: mov.w    r2, #0x38000000
0803f5ec: ldr      r3, [pc, #0x58]
0803f5ee: stm      r2!, {r4, r5, r6, r7}
0803f5f0: cmp      r2, r3
0803f5f2: blo      #0x803f5ee
0803f5f4: mov.w    r2, #0
0803f5f8: mov.w    r3, #0x10000
0803f5fc: stm      r2!, {r4, r5, r6, r7}
0803f5fe: cmp      r2, r3
0803f600: blo      #0x803f5fc
0803f602: mov.w    r2, #0x20000000
0803f606: ldr      r3, [pc, #0x34]
0803f608: stm      r2!, {r4, r5, r6, r7}
0803f60a: cmp      r2, r3
0803f60c: blo      #0x803f608
0803f60e: ldr      r0, [pc, #0x3c]
0803f610: ldr      r1, [pc, #0x3c]
0803f612: ldr      r2, [pc, #0x40]
0803f614: movs     r3, #0
0803f616: b        #0x803f61e
0803f618: ldr      r4, [r2, r3]
0803f61a: str      r4, [r0, r3]
0803f61c: adds     r3, #4
0803f61e: adds     r4, r0, r3
0803f620: cmp      r4, r1
0803f622: blo      #0x803f618
0803f624: ldr      r0, [pc, #0x30]
0803f626: ldr      r1, [pc, #0x34]
0803f628: ldr      r2, [pc, #0x34]
0803f62a: ldm      r0!, {r3, r4}
0803f62c: stm      r1!, {r3, r4}
0803f62e: cmp      r1, r2
0803f630: blo      #0x803f62a
0803f632: bl       #0x8049024
0803f636: bl       #0x803f80c
0803f63a: bx       lr
0803f63c: movs     r0, r0
0803f63e: movs     r0, #2
0803f640: movs     r0, r0
0803f642: movs     r4, #5
0803f644: strh     r0, [r0]
0803f646: adds     r0, #0
0803f648: ands     r0, r0
0803f64a: subs     r0, #0
0803f64c: movs     r0, r0
0803f64e: movs     r4, #0
0803f650: subs     r6, #4
0803f652: movs     r4, #0
0803f654: ubfx     r8, ip, #0, #9
0803f658: lsls     r4, r1, #0xb
0803f65a: lsrs     r2, r0, #0x20
0803f65c: movs     r0, r0
0803f65e: movs     r0, r0
0803f660: ldr      r0, [r7, #0x34]
0803f662: movs     r0, r0
0803f664: bkpt     #0
0803f666: b        #0x803f664
0803f668: ldr      r1, [pc, #0x8c]
0803f66a: ldr      r2, [pc, #0x90]
0803f66c: push     {r4}
0803f66e: ldr.w    r3, [r1, #0x88]
0803f672: orr      r3, r3, #0xf00000
0803f676: str.w    r3, [r1, #0x88]
0803f67a: ldr      r3, [r2]
0803f67c: and      r3, r3, #0xf
0802e9a0: ldr      r0, [pc, #0x90]
0802e9a2: b        #0x802e8a8
0802e9a4: bl       #0x8027a9c
0802e9a8: cmp      r0, #0
0802e9aa: beq      #0x802e8d0
0802e9ac: b        #0x802e968
0802e9ae: ldr      r3, [r4, #0x1c]
0802e9b0: cmp.w    r3, #0x8000
0802e9b4: beq      #0x802ea0a
0802e9b6: bl       #0x8027ac0
0802e9ba: cmp      r0, #0
0802e9bc: beq      #0x802e8d0
0802e9be: b        #0x802e8a8
0802e9c0: mov      r0, sp
0802e9c2: bl       #0x8029e10
0802e9c6: ldr      r0, [sp, #4]
0802e9c8: cmp      r0, #0
0802e9ca: bne.w    #0x802e760
0802e9ce: b        #0x802e8d0
0802e9d0: add      r0, sp, #0xc
0802e9d2: bl       #0x8029f44
0802e9d6: ldr      r0, [sp, #0x10]
0802e9d8: cmp      r0, #0
0802e9da: bne.w    #0x802e760
0802e9de: b        #0x802e8d0
0802e9e0: bl       #0x8029dec
0802e9e4: cmp      r0, #0
0802e9e6: bne.w    #0x802e760
0802e9ea: b        #0x802e8d0
0802e9ec: mov.w    r0, #0x8000
0802e9f0: b        #0x802e760
0802e9f2: ldr      r0, [pc, #0x44]
0802e9f4: b        #0x802e760
0802e9f6: ldr      r3, [pc, #0x44]
0802e9f8: ldr      r2, [r3]
0802e9fa: lsls     r1, r2, #0x1a
0802e9fc: bpl      #0x802ea2a
0802e9fe: ldr      r3, [r3]
0802ea00: ldr      r0, [pc, #0x30]
0802ea02: ubfx     r3, r3, #3, #2
0802ea06: lsrs     r0, r3
0802ea08: b        #0x802e968
0802ea0a: bl       #0x8027ac0
0802ea0e: cmp      r0, #0
0802ea10: beq.w    #0x802e8d0
0802ea14: b        #0x802e968
0802ea16: add      r0, sp, #0xc
0802ea18: bl       #0x8029f44
0802ea1c: ldr      r0, [sp, #0x10]
0802ea1e: cmp      r0, #0
0802ea20: beq.w    #0x802e8d0
0802ea24: b        #0x802e968
0802ea26: ldr      r0, [pc, #0xc]
0802ea28: b        #0x802e760
0802ea2a: ldr      r0, [pc, #8]
0802ea2c: b        #0x802e968
0802ea2e: nop      
0802ea30: str      r3, [sp, #0x1b0]
0802ea32: lsrs     r4, r0, #0x20
0802ea34: str      r0, [sp]
0802ea36: lsls     r0, r2, #0xf
0802ea38: lsrs     r0, r0, #4
0802ea3a: movs     r5, r7
0802ea3c: add      r0, r0
0802ea3e: ldr      r2, [r0, r0]
0802ea40: ldr      r3, [r0, #0x28]
0802ea42: lsls     r2, r3, #0x1c
0802ea44: bpl      #0x802ea56
0802ea46: ldr      r2, [r0]
0802ea48: ldr      r1, [r0, #0x38]
0802ea4a: ldr      r3, [r2, #4]
0802ea4c: bic      r3, r3, #0x8000
0802ea50: orrs     r3, r1
0802ea52: str      r3, [r2, #4]
0802ea54: ldr      r3, [r0, #0x28]
0802ea56: lsls     r1, r3, #0x1f
0802ea58: bpl      #0x802ea6a
0802ea5a: ldr      r2, [r0]
0802ea5c: ldr      r1, [r0, #0x2c]
0802ea5e: ldr      r3, [r2, #4]
0802ea60: bic      r3, r3, #0x20000
0802ea64: orrs     r3, r1
0802ea66: str      r3, [r2, #4]
0802ea68: ldr      r3, [r0, #0x28]
0802ea6a: lsls     r2, r3, #0x1e
0802ea6c: bpl      #0x802ea7e
0802ea6e: ldr      r2, [r0]
0802ea70: ldr      r1, [r0, #0x30]
0802ea72: ldr      r3, [r2, #4]
0802ea74: bic      r3, r3, #0x10000
0802ea78: orrs     r3, r1
0802ea7a: str      r3, [r2, #4]
0802ea7c: ldr      r3, [r0, #0x28]
0802ea7e: lsls     r1, r3, #0x1d
0802ea80: bpl      #0x802ea92
0802ea82: ldr      r2, [r0]
0802ea84: ldr      r1, [r0, #0x34]
0802ea86: ldr      r3, [r2, #4]
0802ea88: bic      r3, r3, #0x40000
0802ea8c: orrs     r3, r1
0802ea8e: str      r3, [r2, #4]
0802ea90: ldr      r3, [r0, #0x28]
0802ea92: lsls     r2, r3, #0x1b
0802ea94: bpl      #0x802eaa6
0802ea96: ldr      r2, [r0]
0802ea98: ldr      r1, [r0, #0x3c]
0802ea9a: ldr      r3, [r2, #8]
0802ea9c: bic      r3, r3, #0x1000
0802eaa0: orrs     r3, r1
0802eaa2: str      r3, [r2, #8]
0802eaa4: ldr      r3, [r0, #0x28]
0802eaa6: lsls     r1, r3, #0x1a
0802eaa8: bpl      #0x802eaba
0802eaaa: ldr      r2, [r0]
0802eaac: ldr      r1, [r0, #0x40]
0802eaae: ldr      r3, [r2, #8]
0802eab0: bic      r3, r3, #0x2000
0802eab4: orrs     r3, r1
0802eab6: str      r3, [r2, #8]
0802eab8: ldr      r3, [r0, #0x28]
0802eaba: lsls     r2, r3, #0x19
0802eabc: bpl      #0x802ead6
0802eabe: ldr      r2, [r0]
0802eac0: ldr      r1, [r0, #0x44]
0802eac2: ldr      r3, [r2, #4]
0802eac4: bic      r3, r3, #0x100000
0802eac8: orrs     r3, r1
0802eaca: str      r3, [r2, #4]
0802eacc: ldr      r3, [r0, #0x44]
0802eace: cmp.w    r3, #0x100000
0802ead2: beq      #0x802eaea
0802ead4: ldr      r3, [r0, #0x28]
0802ead6: lsls     r3, r3, #0x18
0802ead8: bpl      #0x802eae8
0802eada: ldr      r2, [r0]
0802eadc: ldr      r1, [r0, #0x4c]
0802eade: ldr      r3, [r2, #4]
0802eae0: bic      r3, r3, #0x80000
0802eae4: orrs     r3, r1
0802eae6: str      r3, [r2, #4]
0802eae8: bx       lr
0802eaea: ldr      r2, [r0]
0802eaec: ldr      r1, [r0, #0x48]
0802eaee: ldr      r3, [r2, #4]
0802eaf0: bic      r3, r3, #0x600000
0802eaf4: orrs     r3, r1
0802eaf6: str      r3, [r2, #4]
0802eaf8: b        #0x802ead4
0802eafa: nop      
0802eafc: push.w   {r4, r5, r6, r7, r8, sb, sl, lr}
0802eb00: ldr      r6, [sp, #0x20]
0802eb02: mov      r4, r1
0802eb04: mov      r7, r0
0802eb06: mov      r5, r2
0802eb08: mov      r8, r3
0802eb0a: ldr      r1, [r0]
0802eb0c: ldr      r2, [r1, #0x1c]
0802eb0e: .byte    0x34, 0xea
0803056c: str      r3, [sp, #0x3d0]
0803056e: lsrs     r4, r0, #0x20
08030570: movs     r0, #0
08030572: bx       lr
08030574: ldr      r2, [pc, #0x90]
08030576: ldr      r3, [r2]
08030578: cmp      r0, #0x23
0803057a: bhi      #0x80305a4
0803057c: tbb      [pc, r0]
08030580: adds     r7, r2, #0
08030582: movs     r6, #0x21
08030584: asrs     r3, r5, #8
08030586: asrs     r2, r2, #8
08030588: asrs     r2, r2, #8
0803058a: asrs     r2, r2, #8
0803058c: asrs     r2, r2, #8
0803058e: asrs     r2, r2, #8
08030590: asrs     r2, r2, #8
08030592: asrs     r2, r2, #8
08030594: asrs     r2, r2, #8
08030596: asrs     r2, r2, #8
08030598: asrs     r2, r2, #8
0803059a: asrs     r2, r2, #8
0803059c: asrs     r2, r2, #8
0803059e: asrs     r2, r2, #8
080305a0: adds     r5, #0x30
080305a2: subs     r7, #0x3a
080305a4: orr      r3, r3, #0x200
080305a8: movs     r0, #0
080305aa: str      r3, [r2]
080305ac: bx       lr
080305ae: orr      r3, r3, #1
080305b2: movs     r0, #0
080305b4: str      r3, [r2]
080305b6: bx       lr
080305b8: orr      r3, r3, #2
080305bc: movs     r0, #0
080305be: str      r3, [r2]
080305c0: bx       lr
080305c2: orr      r3, r3, #4
080305c6: movs     r0, #0
080305c8: str      r3, [r2]
080305ca: bx       lr
080305cc: orr      r3, r3, #8
080305d0: movs     r0, #0
080305d2: str      r3, [r2]
080305d4: bx       lr
080305d6: orr      r3, r3, #0x10
080305da: movs     r0, #0
080305dc: str      r3, [r2]
080305de: bx       lr
080305e0: orr      r3, r3, #0x20
080305e4: movs     r0, #0
080305e6: str      r3, [r2]
080305e8: bx       lr
080305ea: orr      r3, r3, #0x40
080305ee: movs     r0, #0
080305f0: str      r3, [r2]
080305f2: bx       lr
080305f4: orr      r3, r3, #0x80
080305f8: movs     r0, #0
080305fa: str      r3, [r2]
080305fc: bx       lr
080305fe: orr      r3, r3, #0x100
08030602: movs     r0, #0
08030604: str      r3, [r2]
08030606: bx       lr
08030608: adds     r5, #0xa8
0803060a: subs     r0, #0
0803060c: movs     r0, #0
0803060e: bx       lr
08030610: push     {r4, r5, r6, lr}
08030612: mov      r6, r1
08030614: ldr      r5, [pc, #0x3c]
08030616: mov      r1, r0
08030618: ldrb     r2, [r5]
0803061a: ldr      r3, [r6]
0803061c: uxtb     r2, r2
0803061e: cbz      r3, #0x8030640
08030620: add.w    ip, r0, #-1
08030624: ldr      r0, [pc, #0x30]
08030626: mov      r3, ip
08030628: ldrb     r4, [ip, #1]!
0803062c: add.w    lr, r2, #1
08030630: adds     r3, #2
08030632: strb     r4, [r0, r2]
08030634: ldr      r4, [r6]
08030636: uxtb.w   r2, lr
0803063a: subs     r3, r3, r1
0803063c: cmp      r4, r3
0803063e: bhi      #0x8030626
08030640: ldr      r0, [pc, #0x18]
08030642: strb     r2, [r5]
08030644: bl       #0x803041c
08030648: ldr      r0, [pc, #0x10]
0803064a: bl       #0x803046c
0803064e: movs     r0, #0
08030650: pop      {r4, r5, r6, pc}
08030652: nop      
08030654: adds     r5, #0xac
08030656: subs     r0, #0
08030658: adds     r5, #0xb0
0803065a: subs     r0, #0
0803065c: asrs     r4, r4, #0x1e
0803065e: subs     r0, #0
08030660: push     {r4, lr}
08030662: ldr      r4, [pc, #0x18]
08030664: movs     r2, #0
08030666: ldr      r1, [pc, #0x18]
08030668: mov      r0, r4
0803066a: bl       #0x8030400
0803066e: ldr      r1, [pc, #0x14]
08030670: mov      r0, r4
08030672: bl       #0x803041c
08030676: movs     r0, #0
08030678: pop      {r4, pc}
0803067a: nop      
0803067c: asrs     r4, r4, #0x1e
0803067e: subs     r0, #0
08030680: movs     r5, #0xa8
08030682: subs     r0, #0
08030684: cmp      r5, #0xa8
08030686: subs     r0, #0
08030688: push     {r3, r4, r5, r6, r7, lr}
0803068a: ldr      r3, [pc, #0x40]
0803068c: mov      r6, r0
0803068e: mov      r7, r1
08030690: ldr.w    r5, [r3, #0x2bc]
08030694: ldr.w    r3, [r5, #0x214]
08030698: cbz      r3, #0x80306ac
0803069a: movs     r4, #4
0803069c: movs     r0, #0xa
0803069e: bl       #0x8027120
080306a2: ldr.w    r3, [r5, #0x214]
080306a6: cbz      r3, #0x80306ac
080306a8: subs     r4, #1
080306aa: bne      #0x803069c
080306ac: ldr.w    r3, [r5, #0x214]
080306b0: cbz      r3, #0x80306b6
080306b2: movs     r0, #1
080306b4: pop      {r3, r4, r5, r6, r7, pc}
080306b6: mov      r2, r7
080306b8: mov      r1, r6
080306ba: ldr      r0, [pc, #0x10]
080306bc: bl       #0x8030400
080306c0: ldr      r0, [pc, #8]
080306c2: pop.w    {r3, r4, r5, r6, r7, lr}
080306c6: b.w      #0x8030434
080306ca: nop      
080306cc: asrs     r4, r4, #0x1e
080306ce: subs     r0, #0
080306d0: ldrb     r3, [r0, #0x14]
080306d2: cbz      r3, #0x803072e
080306d4: ldrd     r2, r3, [r0]
080306d8: add      r3, r2
080306da: cmp      r2, r3
080306dc: blo      #0x803072c
080306de: ldrb     r2, [r0, #0x11]
080306e0: str      r3, [r0]
080306e2: adds     r3, r2, #1
080306e4: ldr      r1, [r0, #8]
080306e6: ldrb.w   ip, [r0, #0x12]
080306ea: uxtb     r3, r3
080306ec: adds     r1, #1
080306ee: cmp      ip, r3
080306f0: str      r1, [r0, #8]
080306f2: strb     r3, [r0, #0x11]
080306f4: bhi      #0x8030742
080306f6: movs     r2, #0
080306f8: push     {r4}
080306fa: ldrb     r3, [r0, #0x10]
080306fc: ldrb     r1, [r0, #0x13]
080306fe: adds     r3, #1
08030700: ldrb     r4, [r0, #0x17]
08030702: strb     r2, [r0, #0x11]
08030704: uxtb     r3, r3
08030706: cmp      r1, r3
08030708: strb     r3, [r0, #0x10]
0803070a: bhi      #0x8030732
0803070c: ldr      r3, [r0, #0xc]
0803070e: ldrb     r1, [r0, #0x15]
08030710: adds     r3, #1
08030712: strb     r2, [r0, #0x10]
08030714: str      r3, [r0, #0xc]
08030716: cbz      r4, #0x8030724
08030718: ldrb     r3, [r0, #0x18]
0803071a: cbz      r3, #0x8030724
0803071c: str      r2, [r0, #0x1c]
0803071e: cbz      r1, #0x8030746
