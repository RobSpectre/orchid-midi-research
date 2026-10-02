; Range 0x802f560–0x802f8cc
0802f560: cbz      r0, #0x802f582
0802f562: movs     r3, #0
0802f564: str.w    r3, [r0, #0x2b8]
0802f568: str.w    r3, [r0, #0x2c4]
0802f56c: str.w    r3, [r0, #0x2d0]
0802f570: cbz      r1, #0x802f576
0802f572: str.w    r1, [r0, #0x2b4]
0802f576: movs     r3, #1
0802f578: strb     r2, [r0]
0802f57a: strb.w   r3, [r0, #0x29c]
0802f57e: b.w      #0x802f32c
0802f582: movs     r0, #3
0802f584: bx       lr
0802f586: nop      
0802f588: push     {r4, lr}
0802f58a: movs     r3, #0
0802f58c: sub      sp, #8
0802f58e: strh.w   r3, [sp, #6]
0802f592: cbz      r1, #0x802f5b8
0802f594: str.w    r1, [r0, #0x2b8]
0802f598: mov      r4, r0
0802f59a: ldr      r3, [r1, #0x2c]
0802f59c: cbz      r3, #0x802f5a8
0802f59e: add.w    r0, sp, #6
0802f5a2: blx      r3
0802f5a4: str.w    r0, [r4, #0x2d0]
0802f5a8: ldr.w    r3, [r4, #0x2d8]
0802f5ac: movs     r0, #0
0802f5ae: adds     r3, #1
0802f5b0: str.w    r3, [r4, #0x2d8]
0802f5b4: add      sp, #8
0802f5b6: pop      {r4, pc}
0802f5b8: movs     r0, #3
0802f5ba: add      sp, #8
0802f5bc: pop      {r4, pc}
0802f5be: nop      
0802f5c0: b.w      #0x802f398
0802f5c4: ldr.w    r3, [r0, #0x2b8]
0802f5c8: cbz      r3, #0x802f5ce
0802f5ca: ldr      r3, [r3]
0802f5cc: bx       r3
0802f5ce: mov      r0, r3
0802f5d0: bx       lr
0802f5d2: nop      
0802f5d4: push     {r3, lr}
0802f5d6: ldr.w    r3, [r0, #0x2b8]
0802f5da: ldr      r3, [r3, #4]
0802f5dc: blx      r3
0802f5de: cmp      r0, #0
0802f5e0: it       ne
0802f5e2: movne    r0, #3
0802f5e4: pop      {r3, pc}
0802f5e6: nop      
0802f5e8: push     {r3, r4, r5, lr}
0802f5ea: addw     r5, r0, #0x2aa
0802f5ee: mov      r4, r0
0802f5f0: mov      r0, r5
0802f5f2: bl       #0x802fe58
0802f5f6: ldrh.w   r3, [r4, #0x2b0]
0802f5fa: ldrb.w   r1, [r4, #0x2aa]
0802f5fe: movs     r2, #1
0802f600: str.w    r3, [r4, #0x298]
0802f604: and      r3, r1, #0x1f
0802f608: str.w    r2, [r4, #0x294]
0802f60c: cmp      r3, r2
0802f60e: beq      #0x802f62e
0802f610: cmp      r3, #2
0802f612: beq      #0x802f622
0802f614: cbnz     r3, #0x802f63a
0802f616: mov      r1, r5
0802f618: mov      r0, r4
0802f61a: pop.w    {r3, r4, r5, lr}
0802f61e: b.w      #0x802f900
0802f622: mov      r1, r5
0802f624: mov      r0, r4
0802f626: pop.w    {r3, r4, r5, lr}
0802f62a: b.w      #0x802fcfc
0802f62e: mov      r1, r5
0802f630: mov      r0, r4
0802f632: pop.w    {r3, r4, r5, lr}
0802f636: b.w      #0x802fc7c
0802f63a: mov      r0, r4
0802f63c: and      r1, r1, #0x80
0802f640: pop.w    {r3, r4, r5, lr}
0802f644: b.w      #0x802f3e4
0802f648: push     {r4, r5, r6, lr}
0802f64a: mov      r4, r0
0802f64c: cbnz     r1, #0x802f65c
0802f64e: mov      r3, r1
0802f650: ldr.w    r1, [r0, #0x294]
0802f654: cmp      r1, #3
0802f656: beq      #0x802f67c
0802f658: movs     r0, #0
0802f65a: pop      {r4, r5, r6, pc}
0802f65c: ldrb.w   r3, [r0, #0x29c]
0802f660: cmp      r3, #3
0802f662: bne      #0x802f658
0802f664: ldr.w    r3, [r0, #0x2b8]
0802f668: ldr      r2, [r3, #0x18]
0802f66a: cmp      r2, #0
0802f66c: beq      #0x802f658
0802f66e: movs     r2, #0
0802f670: str.w    r2, [r0, #0x2d4]
0802f674: ldr      r3, [r3, #0x18]
0802f676: pop.w    {r4, r5, r6, lr}
0802f67a: bx       r3
0802f67c: ldr.w    r1, [r0, #0x15c]
0802f680: ldr.w    r5, [r0, #0x160]
0802f684: cmp      r1, r5
0802f686: bhi      #0x802f69a
0802f688: ldrb.w   r2, [r0, #0x29c]
0802f68c: cmp      r2, #3
0802f68e: beq      #0x802f6b0
0802f690: mov      r0, r4
0802f692: bl       #0x802ff54
0802f696: movs     r0, #0
0802f698: pop      {r4, r5, r6, pc}
0802f69a: subs     r3, r1, r5
0802f69c: mov      r1, r2
0802f69e: mov      r2, r5
0802f6a0: cmp      r5, r3
0802f6a2: str.w    r3, [r0, #0x15c]
0802f6a6: it       hs
0802f6a8: movhs    r2, r3
0802f6aa: bl       #0x802ff40
0802f6ae: b        #0x802f658
0802f6b0: ldr.w    r2, [r0, #0x2b8]
0802f6b4: ldr      r1, [r2, #0x10]
0802f6b6: cmp      r1, #0
0802f6b8: beq      #0x802f690
0802f6ba: str.w    r3, [r0, #0x2d4]
0802f6be: ldr      r3, [r2, #0x10]
0802f6c0: blx      r3
0802f6c2: b        #0x802f690
0802f6c4: push     {r4, r5, r6, lr}
0802f6c6: mov      r4, r0
0802f6c8: cbnz     r1, #0x802f6e2
0802f6ca: ldr.w    r3, [r0, #0x294]
0802f6ce: cmp      r3, #2
0802f6d0: beq      #0x802f702
0802f6d2: ldrb.w   r3, [r4, #0x2a0]
0802f6d6: cbz      r3, #0x802f6de
0802f6d8: movs     r3, #0
0802f6da: strb.w   r3, [r4, #0x2a0]
0802f6de: movs     r0, #0
0802f6e0: pop      {r4, r5, r6, pc}
0802f6e2: ldrb.w   r3, [r0, #0x29c]
0802f6e6: cmp      r3, #3
0802f6e8: bne      #0x802f6de
0802f6ea: ldr.w    r3, [r0, #0x2b8]
0802f6ee: ldr      r2, [r3, #0x14]
0802f6f0: cmp      r2, #0
0802f6f2: beq      #0x802f6de
0802f6f4: movs     r2, #0
0802f6f6: str.w    r2, [r0, #0x2d4]
0802f6fa: ldr      r3, [r3, #0x14]
0802f6fc: pop.w    {r4, r5, r6, lr}
0802f700: bx       r3
0802f702: ldr      r3, [r0, #0x1c]
0802f704: mov      r5, r1
0802f706: ldr      r6, [r0, #0x20]
0802f708: cmp      r3, r6
0802f70a: bhi      #0x802f72e
0802f70c: beq      #0x802f748
0802f70e: ldrb.w   r3, [r4, #0x29c]
0802f712: cmp      r3, #3
0802f714: beq      #0x802f76e
0802f716: movs     r1, #0x80
0802f718: mov      r0, r4
0802f71a: bl       #0x802f3e4
0802f71e: mov      r0, r4
0802f720: bl       #0x802ff6c
0802f724: ldrb.w   r3, [r4, #0x2a0]
0802f728: cmp      r3, #0
0802f72a: beq      #0x802f6de
0802f72c: b        #0x802f6d8
0802f72e: subs     r3, r3, r6
0802f730: mov      r1, r2
0802f732: str      r3, [r0, #0x1c]
0802f734: mov      r2, r3
0802f736: bl       #0x802ff0c
0802f73a: mov      r3, r5
0802f73c: mov      r2, r5
0802f73e: mov      r1, r5
0802f740: mov      r0, r4
0802f742: bl       #0x802f46c
0802f746: b        #0x802f6d2
0802f748: ldr      r2, [r0, #0x18]
0802f74a: cmp      r3, r2
0802f74c: bhi      #0x802f70e
0802f74e: ldr.w    r3, [r0, #0x298]
0802f752: cmp      r2, r3
0802f754: bhs      #0x802f70e
0802f756: mov      r2, r1
0802f758: bl       #0x802ff0c
0802f75c: mov      r3, r5
0802f75e: mov      r2, r5
0802f760: mov      r1, r5
0802f762: mov      r0, r4
0802f764: str.w    r5, [r4, #0x298]
0802f768: bl       #0x802f46c
0802f76c: b        #0x802f6d2
0802f76e: ldr.w    r3, [r4, #0x2b8]
0802f772: ldr      r2, [r3, #0xc]
0802f774: cmp      r2, #0
0802f776: beq      #0x802f716
0802f778: movs     r2, #0
0802f77a: mov      r0, r4
0802f77c: str.w    r2, [r4, #0x2d4]
0802f780: ldr      r3, [r3, #0xc]
0802f782: blx      r3
0802f784: b        #0x802f716
0802f786: nop      
0802f788: push     {r3, r4, r5, r6, r7, lr}
0802f78a: movs     r1, #0
0802f78c: movs     r2, #1
0802f78e: ldr.w    r3, [r0, #0x2b8]
0802f792: mov      r4, r0
0802f794: strb.w   r2, [r0, #0x29c]
0802f798: str      r1, [r0, #4]
0802f79a: str.w    r1, [r0, #0x294]
0802f79e: str.w    r1, [r0, #0x2a4]
0802f7a2: strb.w   r1, [r0, #0x2a0]
0802f7a6: cbz      r3, #0x802f7b0
0802f7a8: ldr      r3, [r3, #4]
0802f7aa: cbz      r3, #0x802f7b0
0802f7ac: blx      r3
0802f7ae: cbnz     r0, #0x802f7de
0802f7b0: movs     r7, #0
0802f7b2: movs     r2, #0
0802f7b4: movs     r5, #0x40
0802f7b6: movs     r6, #1
0802f7b8: movs     r3, #0x40
0802f7ba: mov      r1, r2
0802f7bc: mov      r0, r4
0802f7be: bl       #0x802f3b0
0802f7c2: mov      r3, r5
0802f7c4: movs     r2, #0
0802f7c6: movs     r1, #0x80
0802f7c8: mov      r0, r4
0802f7ca: str.w    r5, [r4, #0x160]
0802f7ce: strh.w   r6, [r4, #0x164]
0802f7d2: bl       #0x802f3b0
0802f7d6: mov      r0, r7
0802f7d8: strh     r6, [r4, #0x24]
0802f7da: str      r5, [r4, #0x20]
0802f7dc: pop      {r3, r4, r5, r6, r7, pc}
0802f7de: movs     r7, #3
0802f7e0: b        #0x802f7b2
0802f7e2: nop      
0802f7e4: mov      r3, r0
0802f7e6: movs     r0, #0
0802f7e8: strb     r1, [r3, #0x10]
0802f7ea: bx       lr
0802f7ec: ldrb.w   r2, [r0, #0x29c]
0802f7f0: mov      r3, r0
0802f7f2: cmp      r2, #4
0802f7f4: beq      #0x802f800
0802f7f6: ldrb.w   r2, [r0, #0x29c]
0802f7fa: uxtb     r2, r2
0802f7fc: strb.w   r2, [r0, #0x29d]
0802f800: movs     r2, #4
0802f802: movs     r0, #0
0802f804: strb.w   r2, [r3, #0x29c]
0802f808: bx       lr
0802f80a: nop      
0802f80c: ldrb.w   r3, [r0, #0x29c]
0802f810: cmp      r3, #4
0802f812: bne      #0x802f81e
0802f814: ldrb.w   r3, [r0, #0x29d]
0802f818: uxtb     r3, r3
0802f81a: strb.w   r3, [r0, #0x29c]
0802f81e: movs     r0, #0
0802f820: bx       lr
0802f822: nop      
0802f824: ldrb.w   r2, [r0, #0x29c]
0802f828: cmp      r2, #3
0802f82a: beq      #0x802f830
0802f82c: movs     r0, #0
0802f82e: bx       lr
0802f830: push     {r3, lr}
0802f832: ldr.w    r3, [r0, #0x2b8]
0802f836: cbz      r3, #0x802f83e
0802f838: ldr      r3, [r3, #0x1c]
0802f83a: cbz      r3, #0x802f83e
0802f83c: blx      r3
0802f83e: movs     r0, #0
0802f840: pop      {r3, pc}
0802f842: nop      
0802f844: ldr.w    r2, [r0, #0x2d4]
0802f848: adds     r2, #0xae
0802f84a: ldr.w    r2, [r0, r2, lsl #2]
0802f84e: cbz      r2, #0x802f86a
0802f850: push     {r3, lr}
0802f852: ldrb.w   r3, [r0, #0x29c]
0802f856: cmp      r3, #3
0802f858: beq      #0x802f85e
0802f85a: movs     r0, #0
0802f85c: pop      {r3, pc}
0802f85e: ldr      r3, [r2, #0x20]
0802f860: cmp      r3, #0
0802f862: beq      #0x802f85a
0802f864: blx      r3
0802f866: movs     r0, #0
0802f868: pop      {r3, pc}
0802f86a: movs     r0, #3
0802f86c: bx       lr
0802f86e: nop      
0802f870: ldr.w    r2, [r0, #0x2d4]
0802f874: adds     r2, #0xae
0802f876: ldr.w    r2, [r0, r2, lsl #2]
0802f87a: cbz      r2, #0x802f896
0802f87c: push     {r3, lr}
0802f87e: ldrb.w   r3, [r0, #0x29c]
0802f882: cmp      r3, #3
0802f884: beq      #0x802f88a
0802f886: movs     r0, #0
0802f888: pop      {r3, pc}
0802f88a: ldr      r3, [r2, #0x24]
0802f88c: cmp      r3, #0
0802f88e: beq      #0x802f886
0802f890: blx      r3
0802f892: movs     r0, #0
0802f894: pop      {r3, pc}
0802f896: movs     r0, #3
0802f898: bx       lr
0802f89a: nop      
0802f89c: movs     r0, #0
0802f89e: bx       lr
0802f8a0: movs     r1, #1
0802f8a2: ldr.w    r2, [r0, #0x2b8]
0802f8a6: strb.w   r1, [r0, #0x29c]
0802f8aa: cbz      r2, #0x802f8be
0802f8ac: push     {r3, lr}
0802f8ae: ldr      r2, [r2, #4]
0802f8b0: ldrb     r1, [r0, #4]
0802f8b2: blx      r2
0802f8b4: cbnz     r0, #0x802f8ba
0802f8b6: movs     r0, #0
0802f8b8: pop      {r3, pc}
0802f8ba: movs     r0, #3
0802f8bc: pop      {r3, pc}
0802f8be: movs     r0, #0
0802f8c0: bx       lr
0802f8c2: nop      
0802f8c4: movs     r0, #0
0802f8c6: bx       lr
0802f8c8: movs     r0, #0
0802f8ca: bx       lr
; Range 0x80301d4–0x80302d0
080301d4: push     {r4, r5, r6, lr}
080301d6: ldr.w    r3, [r0, #0x2d4]
080301da: sub      sp, #8
080301dc: movs     r2, #0
080301de: add.w    r3, r0, r3, lsl #2
080301e2: strb.w   r2, [sp, #5]
080301e6: ldr.w    r6, [r3, #0x2c0]
080301ea: strh.w   r2, [sp, #6]
080301ee: cbz      r6, #0x803020a
080301f0: ldrb.w   ip, [r1]
080301f4: mov      r4, r0
080301f6: mov      r5, r1
080301f8: ands     r2, ip, #0x60
080301fc: beq      #0x803023c
080301fe: cmp      r2, #0x20
08030200: beq      #0x8030210
08030202: mov      r1, r5
08030204: mov      r0, r4
08030206: bl       #0x802fe80
0803020a: movs     r0, #3
0803020c: add      sp, #8
0803020e: pop      {r4, r5, r6, pc}
08030210: ldrh     r2, [r1, #6]
08030212: ldrb.w   lr, [r1, #1]
08030216: cbz      r2, #0x8030278
08030218: tst.w    ip, #0x80
0803021c: beq      #0x80302b8
0803021e: ldr.w    r3, [r3, #0x2c4]
08030222: mov      r1, r6
08030224: mov      r0, lr
08030226: ldr      r3, [r3, #8]
08030228: blx      r3
0803022a: ldrh     r2, [r5, #6]
0803022c: mov      r1, r6
0803022e: mov      r0, r4
08030230: cmp      r2, #7
08030232: it       hs
08030234: movhs    r2, #7
08030236: bl       #0x802fef0
0803023a: b        #0x8030282
0803023c: ldrb     r3, [r1, #1]
0803023e: cmp      r3, #0xb
08030240: bhi      #0x8030202
08030242: adr      r2, #4
08030244: ldr.w    pc, [r2, r3, lsl #2]
08030248: lsls     r1, r2, #0xa
0803024a: lsrs     r3, r0, #0x20
0803024c: lsls     r3, r0, #0xa
0803024e: lsrs     r3, r0, #0x20
08030250: lsls     r3, r0, #8
08030252: lsrs     r3, r0, #0x20
08030254: lsls     r3, r0, #8
08030256: lsrs     r3, r0, #0x20
08030258: lsls     r3, r0, #8
0803025a: lsrs     r3, r0, #0x20
0803025c: lsls     r3, r0, #8
0803025e: lsrs     r3, r0, #0x20
08030260: lsls     r3, r0, #8
08030262: lsrs     r3, r0, #0x20
08030264: lsls     r3, r0, #8
08030266: lsrs     r3, r0, #0x20
08030268: lsls     r3, r0, #8
0803026a: lsrs     r3, r0, #0x20
0803026c: lsls     r3, r0, #8
0803026e: lsrs     r3, r0, #0x20
08030270: lsls     r5, r4, #0xa
08030272: lsrs     r3, r0, #0x20
08030274: lsls     r7, r0, #0xa
08030276: lsrs     r3, r0, #0x20
08030278: ldr.w    r3, [r3, #0x2c4]
0803027c: mov      r0, lr
0803027e: ldr      r3, [r3, #8]
08030280: blx      r3
08030282: movs     r0, #0
08030284: b        #0x803020c
08030286: ldrb.w   r3, [r0, #0x29c]
0803028a: cmp      r3, #3
0803028c: beq      #0x8030282
0803028e: b        #0x8030202
08030290: ldrb.w   r3, [r0, #0x29c]
08030294: cmp      r3, #3
08030296: bne      #0x8030202
08030298: movs     r2, #2
0803029a: add.w    r1, sp, #6
0803029e: bl       #0x802fef0
080302a2: b        #0x8030282
080302a4: ldrb.w   r3, [r0, #0x29c]
080302a8: cmp      r3, #3
080302aa: bne      #0x8030202
080302ac: movs     r2, #1
080302ae: add.w    r1, sp, #5
080302b2: bl       #0x802fef0
080302b6: b        #0x8030282
080302b8: strb.w   lr, [r6, #0x200]
080302bc: ldrh     r2, [r1, #6]
080302be: mov      r1, r6
080302c0: cmp      r2, #0x40
080302c2: it       hs
080302c4: movhs    r2, #0x40
080302c6: strb.w   r2, [r6, #0x201]
080302ca: bl       #0x802ff20
080302ce: b        #0x8030282
; Range 0x8030574–0x803060c
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
