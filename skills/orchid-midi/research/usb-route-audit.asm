; Offline stock 3.92 trace. Literal pools and tables can decode as instructions.
; range 0x802ee14–0x802eea0
0802ee14: push       {r3, lr}
0802ee16: and        r0, r0, #1
0802ee1a: ldr        r3, [pc, #0x60]
0802ee1c: movs       r2, #1
0802ee1e: strb       r0, [r3]
0802ee20: cbnz       r0, #0x802ee54
0802ee22: ldr        r1, [pc, #0x5c]
0802ee24: ldr        r0, [pc, #0x5c]
0802ee26: bl         #0x802f560
0802ee2a: cbz        r0, #0x802ee2e
0802ee2c: bkpt       #0
0802ee2e: ldr        r1, [pc, #0x58]
0802ee30: ldr        r0, [pc, #0x50]
0802ee32: bl         #0x802f588
0802ee36: cbnz       r0, #0x802ee76
0802ee38: movs       r3, #0
0802ee3a: ldr        r1, [pc, #0x50]
0802ee3c: ldr        r2, [pc, #0x50]
0802ee3e: ldr        r0, [pc, #0x44]
0802ee40: strb       r3, [r1]
0802ee42: str        r3, [r2]
0802ee44: bl         #0x802f5c0
0802ee48: cbz        r0, #0x802ee4c
0802ee4a: bkpt       #0
0802ee4c: pop.w      {r3, lr}
0802ee50: b.w        #0x802d7a8
0802ee54: ldr        r1, [pc, #0x3c]
0802ee56: ldr        r0, [pc, #0x2c]
0802ee58: bl         #0x802f560
0802ee5c: cbz        r0, #0x802ee60
0802ee5e: bkpt       #0
0802ee60: ldr        r1, [pc, #0x34]
0802ee62: ldr        r0, [pc, #0x20]
0802ee64: bl         #0x802f588
0802ee68: cbz        r0, #0x802ee6c
0802ee6a: bkpt       #0
0802ee6c: ldr        r1, [pc, #0x2c]
0802ee6e: ldr        r0, [pc, #0x14]
0802ee70: bl         #0x80303e8
0802ee74: b          #0x802ee38
0802ee76: bkpt       #0
0802ee78: b          #0x802ee38
0802ee7a: nop        
0802ee7c: asrs       r1, r2, #1
0802ee7e: subs       r0, #0
0802ee80: sub        sp, #0
0802ee82: lsrs       r4, r0, #0x20
0802ee84: asrs       r4, r4, #0x1e
0802ee86: subs       r0, #0
0802ee88: cbz        r4, #0x802ee90
0802ee8a: lsrs       r4, r0, #0x20
0802ee8c: asrs       r0, r2, #1
0802ee8e: subs       r0, #0
0802ee90: asrs       r4, r2, #1
0802ee92: subs       r0, #0
0802ee94: lsls       r4, r1, #3
0802ee96: movs       r4, #0
0802ee98: lsls       r4, r1, #1
0802ee9a: movs       r4, #0
0802ee9c: lsls       r4, r5, #3
0802ee9e: movs       r4, #0
; range 0x802f150–0x802f160
0802f150: movs       r0, #0
0802f152: ldr        r3, [pc, #8]
0802f154: str.w      r0, [r3, #0x80]
0802f158: b.w        #0x802ee14
0802f15c: add        r0, r0
0802f15e: ldr        r2, [r0, r0]
; range 0x803f9bc–0x803f9ce
0803f9bc: bl         #0x803f7c8
0803f9c0: movs       r0, #0
0803f9c2: bl         #0x802ee14
0803f9c6: bl         #0x8041e80
0803f9ca: bl         #0x8047030
; range 0x8030574–0x80306d0
08030574: ldr        r2, [pc, #0x90]
08030576: ldr        r3, [r2]
08030578: cmp        r0, #0x23
0803057a: bhi        #0x80305a4
0803057c: tbb        [pc, r0]
08030580: adds       r7, r2, #0
08030582: movs       r6, #0x21
08030584: asrs       r3, r5, #8
08030586: asrs       r2, r2, #8
08030588: asrs       r2, r2, #8
0803058a: asrs       r2, r2, #8
0803058c: asrs       r2, r2, #8
0803058e: asrs       r2, r2, #8
08030590: asrs       r2, r2, #8
08030592: asrs       r2, r2, #8
08030594: asrs       r2, r2, #8
08030596: asrs       r2, r2, #8
08030598: asrs       r2, r2, #8
0803059a: asrs       r2, r2, #8
0803059c: asrs       r2, r2, #8
0803059e: asrs       r2, r2, #8
080305a0: adds       r5, #0x30
080305a2: subs       r7, #0x3a
080305a4: orr        r3, r3, #0x200
080305a8: movs       r0, #0
080305aa: str        r3, [r2]
080305ac: bx         lr
080305ae: orr        r3, r3, #1
080305b2: movs       r0, #0
080305b4: str        r3, [r2]
080305b6: bx         lr
080305b8: orr        r3, r3, #2
080305bc: movs       r0, #0
080305be: str        r3, [r2]
080305c0: bx         lr
080305c2: orr        r3, r3, #4
080305c6: movs       r0, #0
080305c8: str        r3, [r2]
080305ca: bx         lr
080305cc: orr        r3, r3, #8
080305d0: movs       r0, #0
080305d2: str        r3, [r2]
080305d4: bx         lr
080305d6: orr        r3, r3, #0x10
080305da: movs       r0, #0
080305dc: str        r3, [r2]
080305de: bx         lr
080305e0: orr        r3, r3, #0x20
080305e4: movs       r0, #0
080305e6: str        r3, [r2]
080305e8: bx         lr
080305ea: orr        r3, r3, #0x40
080305ee: movs       r0, #0
080305f0: str        r3, [r2]
080305f2: bx         lr
080305f4: orr        r3, r3, #0x80
080305f8: movs       r0, #0
080305fa: str        r3, [r2]
080305fc: bx         lr
080305fe: orr        r3, r3, #0x100
08030602: movs       r0, #0
08030604: str        r3, [r2]
08030606: bx         lr
08030608: adds       r5, #0xa8
0803060a: subs       r0, #0
0803060c: movs       r0, #0
0803060e: bx         lr
08030610: push       {r4, r5, r6, lr}
08030612: mov        r6, r1
08030614: ldr        r5, [pc, #0x3c]
08030616: mov        r1, r0
08030618: ldrb       r2, [r5]
0803061a: ldr        r3, [r6]
0803061c: uxtb       r2, r2
0803061e: cbz        r3, #0x8030640
08030620: add.w      ip, r0, #-1
08030624: ldr        r0, [pc, #0x30]
08030626: mov        r3, ip
08030628: ldrb       r4, [ip, #1]!
0803062c: add.w      lr, r2, #1
08030630: adds       r3, #2
08030632: strb       r4, [r0, r2]
08030634: ldr        r4, [r6]
08030636: uxtb.w     r2, lr
0803063a: subs       r3, r3, r1
0803063c: cmp        r4, r3
0803063e: bhi        #0x8030626
08030640: ldr        r0, [pc, #0x18]
08030642: strb       r2, [r5]
08030644: bl         #0x803041c
08030648: ldr        r0, [pc, #0x10]
0803064a: bl         #0x803046c
0803064e: movs       r0, #0
08030650: pop        {r4, r5, r6, pc}
08030652: nop        
08030654: adds       r5, #0xac
08030656: subs       r0, #0
08030658: adds       r5, #0xb0
0803065a: subs       r0, #0
0803065c: asrs       r4, r4, #0x1e
0803065e: subs       r0, #0
08030660: push       {r4, lr}
08030662: ldr        r4, [pc, #0x18]
08030664: movs       r2, #0
08030666: ldr        r1, [pc, #0x18]
08030668: mov        r0, r4
0803066a: bl         #0x8030400
0803066e: ldr        r1, [pc, #0x14]
08030670: mov        r0, r4
08030672: bl         #0x803041c
08030676: movs       r0, #0
08030678: pop        {r4, pc}
0803067a: nop        
0803067c: asrs       r4, r4, #0x1e
0803067e: subs       r0, #0
08030680: movs       r5, #0xa8
08030682: subs       r0, #0
08030684: cmp        r5, #0xa8
08030686: subs       r0, #0
08030688: push       {r3, r4, r5, r6, r7, lr}
0803068a: ldr        r3, [pc, #0x40]
0803068c: mov        r6, r0
0803068e: mov        r7, r1
08030690: ldr.w      r5, [r3, #0x2bc]
08030694: ldr.w      r3, [r5, #0x214]
08030698: cbz        r3, #0x80306ac
0803069a: movs       r4, #4
0803069c: movs       r0, #0xa
0803069e: bl         #0x8027120
080306a2: ldr.w      r3, [r5, #0x214]
080306a6: cbz        r3, #0x80306ac
080306a8: subs       r4, #1
080306aa: bne        #0x803069c
080306ac: ldr.w      r3, [r5, #0x214]
080306b0: cbz        r3, #0x80306b6
080306b2: movs       r0, #1
080306b4: pop        {r3, r4, r5, r6, r7, pc}
080306b6: mov        r2, r7
080306b8: mov        r1, r6
080306ba: ldr        r0, [pc, #0x10]
080306bc: bl         #0x8030400
080306c0: ldr        r0, [pc, #8]
080306c2: pop.w      {r3, r4, r5, r6, r7, lr}
080306c6: b.w        #0x8030434
080306ca: nop        
080306cc: asrs       r4, r4, #0x1e
080306ce: subs       r0, #0
; range 0x802f900–0x802f980
0802f900: push       {r4, r5, r6, lr}
0802f902: ldrb       r3, [r1]
0802f904: sub        sp, #8
0802f906: mov        r5, r1
0802f908: mov        r4, r0
0802f90a: and        r3, r3, #0x60
0802f90e: cmp        r3, #0x20
0802f910: beq        #0x802f964
0802f912: cmp        r3, #0x40
0802f914: beq        #0x802f964
0802f916: cbz        r3, #0x802f930
0802f918: movs       r1, #0x80
0802f91a: mov        r0, r4
0802f91c: bl         #0x802f3e4
0802f920: movs       r1, #0
0802f922: mov        r0, r4
0802f924: bl         #0x802f3e4
0802f928: movs       r5, #0
0802f92a: mov        r0, r5
0802f92c: add        sp, #8
0802f92e: pop        {r4, r5, r6, pc}
0802f930: ldrb       r3, [r1, #1]
0802f932: cmp        r3, #9
0802f934: bhi        #0x802f918
0802f936: adr        r2, #4
0802f938: ldr.w      pc, [r2, r3, lsl #2]
0802f93c: ldrsh.w    r0, [r5, #0x802]
0802f940: .byte      0xdd, 0xf9
0802f942: lsrs       r2, r0, #0x20
0802f944: .byte      0x19, 0xf9
0802f946: lsrs       r2, r0, #0x20
0802f948: .byte      0xfb, 0xf9
0802f94a: lsrs       r2, r0, #0x20
0802f94c: .byte      0x19, 0xf9
0802f94e: lsrs       r2, r0, #0x20
0802f950: .byte      0x13, 0xfa
0802f952: lsrs       r2, r0, #0x20
0802f954: .byte      0x55, 0xfa
0802f956: lsrs       r2, r0, #0x20
0802f958: .byte      0x19, 0xf9
0802f95a: lsrs       r2, r0, #0x20
0802f95c: .byte      0xa9, 0xfa
0802f95e: lsrs       r2, r0, #0x20
0802f960: .byte      0x7d, 0xf9
0802f962: lsrs       r2, r0, #0x20
0802f964: ldr.w      r3, [r4, #0x2d4]
0802f968: mov        r1, r5
0802f96a: mov        r0, r4
0802f96c: adds       r3, #0xae
0802f96e: ldr.w      r3, [r4, r3, lsl #2]
0802f972: ldr        r3, [r3, #8]
0802f974: add        sp, #8
0802f976: pop.w      {r4, r5, r6, lr}
0802f97a: bx         r3
0802f97c: ldrb       r1, [r1, #2]
0802f97e: ldr        r5, [pc, #0x2d4]
; range 0x802fc7c–0x802fcfc
0802fc7c: push       {r3, r4, r5, lr}
0802fc7e: ldrb       r3, [r1]
0802fc80: mov        r5, r1
0802fc82: mov        r4, r0
0802fc84: lsls       r2, r3, #0x19
0802fc86: bpl        #0x802fca4
0802fc88: and        r2, r3, #0x60
0802fc8c: cmp        r2, #0x40
0802fc8e: beq        #0x802fca4
0802fc90: movs       r1, #0x80
0802fc92: bl         #0x802f3e4
0802fc96: movs       r1, #0
0802fc98: mov        r0, r4
0802fc9a: bl         #0x802f3e4
0802fc9e: movs       r5, #0
0802fca0: mov        r0, r5
0802fca2: pop        {r3, r4, r5, pc}
0802fca4: ldrb.w     r3, [r4, #0x29c]
0802fca8: subs       r3, #1
0802fcaa: cmp        r3, #2
0802fcac: bhi        #0x802fcb4
0802fcae: ldrb       r1, [r5, #4]
0802fcb0: cmp        r1, #1
0802fcb2: bls        #0x802fcc6
0802fcb4: movs       r1, #0x80
0802fcb6: mov        r0, r4
0802fcb8: bl         #0x802f3e4
0802fcbc: movs       r1, #0
0802fcbe: mov        r0, r4
0802fcc0: bl         #0x802f3e4
0802fcc4: b          #0x802fc9e
0802fcc6: mov        r0, r4
0802fcc8: bl         #0x802f8c4
0802fccc: cbnz       r0, #0x802fcf6
0802fcce: ldr.w      r3, [r4, #0x2b8]
0802fcd2: ldr        r2, [r3, #8]
0802fcd4: cbz        r2, #0x802fcf6
0802fcd6: str.w      r0, [r4, #0x2d4]
0802fcda: mov        r1, r5
0802fcdc: ldr        r3, [r3, #8]
0802fcde: mov        r0, r4
0802fce0: blx        r3
0802fce2: ldrh       r3, [r5, #6]
0802fce4: mov        r5, r0
0802fce6: cmp        r3, #0
0802fce8: bne        #0x802fca0
0802fcea: cmp        r0, #0
0802fcec: bne        #0x802fca0
0802fcee: mov        r0, r4
0802fcf0: bl         #0x802ff54
0802fcf4: b          #0x802fca0
0802fcf6: movs       r5, #3
0802fcf8: mov        r0, r5
0802fcfa: pop        {r3, r4, r5, pc}
