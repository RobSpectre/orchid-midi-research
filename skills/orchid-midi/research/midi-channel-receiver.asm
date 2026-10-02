; Offline disassembly. Literal pools may decode as instructions.
; Recognized jump-table data is explicitly identified below.
000051cc: push       {r4, lr}
000051ce: ldrb.w     ip, [r1]
000051d2: and        lr, ip, #0xf0
000051d6: cmp.w      lr, #0xb0
000051da: beq        #0x5230
000051dc: mov        r3, r1
000051de: mov        r2, r0
000051e0: bhi        #0x5204
000051e2: cmp.w      lr, #0x80
000051e6: beq        #0x5238
000051e8: cmp.w      lr, #0x90
000051ec: bne        #0x522e
000051ee: tst.w      ip, #0xe
000051f2: bne        #0x522e
000051f4: ldrb       r4, [r1, #2]
000051f6: cbnz       r4, #0x5240
000051f8: mov        r1, r3
000051fa: mov        r0, r2
000051fc: pop.w      {r4, lr}
00005200: b.w        #0x4f90
00005204: cmp.w      lr, #0xe0
00005208: bne        #0x522e
0000520a: tst.w      ip, #0xe
0000520e: bne        #0x522e
00005210: ldrb       r1, [r1, #0xc]
00005212: and        ip, ip, #0xf
00005216: ldrb       r3, [r3, #2]
00005218: rsb        ip, ip, ip, lsl #4
0000521c: orr.w      r3, r3, r1, lsl #7
00005220: add.w      r0, r0, ip, lsl #5
00005224: sub.w      r3, r3, #0x2000
00005228: lsls       r3, r3, #0xb
0000522a: str.w      r3, [r0, #0x144]
0000522e: pop        {r4, pc}
00005230: pop.w      {r4, lr}
00005234: b.w        #0x4c30
00005238: tst.w      ip, #0xe
0000523c: beq        #0x51f8
0000523e: pop        {r4, pc}
00005240: pop.w      {r4, lr}
00005244: b.w        #0x4df4
