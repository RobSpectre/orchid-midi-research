; Offline disassembly. Literal pools may decode as instructions.
; Recognized jump-table data is explicitly identified below.
08032148: cbz        r2, #0x8032174
0803214a: push.w     {r4, r5, r6, r7, r8, lr}
0803214e: mov        r7, r0
08032150: mov        r8, r3
08032152: mov        r6, r2
08032154: subs       r5, r1, #1
08032156: movs       r4, #0
08032158: mov        r1, r4
0803215a: adds       r4, #1
0803215c: ldrb       r3, [r5, #1]!
08032160: mov        r2, r8
08032162: ldr        r0, [r7]
08032164: bl         #0x80490c8
08032168: cmp        r6, r4
0803216a: bls        #0x8032170
0803216c: cmp        r4, #0x86
0803216e: bls        #0x8032158
08032170: pop.w      {r4, r5, r6, r7, r8, pc}
08032174: bx         lr
08032176: nop        
08032178: cmp        r2, #3
0803217a: beq        #0x8032182
0803217c: cmp        r1, #0x86
0803217e: bls        #0x8032186
08032180: bx         lr
08032182: cmp        r1, #0x23
08032184: bhi        #0x8032180
08032186: ldr        r0, [r0]
08032188: b.w        #0x80490c8
00004ae8: cmp        r2, #3
00004aea: mov        ip, r1
00004aec: push       {r4, lr}
00004aee: mov        lr, r0
00004af0: beq        #0x4b50
00004af2: cmp        r2, #2
00004af4: mov        r4, r2
00004af6: beq        #0x4b38
00004af8: cmp        r1, #0x86
00004afa: bhi        #0x4b36
00004afc: cmp        r2, #1
00004afe: bhi        #0x4b36
00004b00: rsb        r1, r2, r2, lsl #4
00004b04: add.w      r2, r0, #0x6000
00004b08: add.w      r1, r0, r1, lsl #5
00004b0c: and        r0, r3, #0x7f
00004b10: strb.w     r0, [r1, ip]
00004b14: movs       r1, #1
00004b16: ldr.w      r0, [r2, #0x654]
00004b1a: lsls       r1, r4
00004b1c: orrs       r1, r0
00004b1e: sub.w      r0, ip, #0x64
00004b22: cmp        r0, #6
00004b24: str.w      r1, [r2, #0x654]
00004b28: bhi        #0x4b7c
00004b2a: cmp        r4, #0
00004b2c: beq        #0x4bb4
00004b2e: orr        r1, r1, #0x10
00004b32: str.w      r1, [r2, #0x654]
00004b36: pop        {r4, pc}
00004b38: cmp        r1, #0x1b
00004b3a: bls        #0x4ba6
00004b3c: subs       r1, #0x1c
00004b3e: cmp        r1, #0x18
00004b40: bhi        #0x4b36
00004b42: uxtb       r2, r3
00004b44: add.w      r0, r0, #0x590
00004b48: pop.w      {r4, lr}
00004b4c: b.w        #0x6b48
00004b50: cmp        r1, #0x23
00004b52: bhi        #0x4b36
00004b54: add        r0, r1
00004b56: subs       r1, #0x20
00004b58: and        r2, r3, #0x7f
00004b5c: cmp        r1, #3
00004b5e: strb.w     r2, [r0, #0x6b0]
00004b62: bls        #0x4b94
00004b64: cmp.w      ip, #3
00004b68: bhi        #0x4bbe
00004b6a: add.w      r3, lr, #0x6000
00004b6e: ldr.w      r2, [r3, #0x654]
00004b72: orr        r2, r2, #0x80
00004b76: str.w      r2, [r3, #0x654]
00004b7a: pop        {r4, pc}
00004b7c: sub.w      r0, ip, #0x6b
00004b80: cmp        r0, #6
00004b82: bhi        #0x4bd6
00004b84: cmp        r4, #0
00004b86: ite        eq
00004b88: moveq      r3, #8
00004b8a: movne      r3, #0x20
00004b8c: orrs       r1, r3
00004b8e: str.w      r1, [r2, #0x654]
00004b92: pop        {r4, pc}
00004b94: add.w      r3, lr, #0x6000
00004b98: ldr.w      r2, [r3, #0x654]
00004b9c: orr        r2, r2, #0x200
00004ba0: str.w      r2, [r3, #0x654]
00004ba4: pop        {r4, pc}
00004ba6: mov        r2, r3
00004ba8: addw       r0, r0, #0x46c
00004bac: pop.w      {r4, lr}
00004bb0: b.w        #0x6ab0
00004bb4: orr        r1, r1, #4
00004bb8: str.w      r1, [r2, #0x654]
00004bbc: pop        {r4, pc}
00004bbe: ldr        r3, [pc, #0x6c]
00004bc0: sub.w      ip, ip, #4
00004bc4: movw       r0, #0x642c
00004bc8: ldr.w      r1, [r3, ip, lsl #2]
00004bcc: add        r0, lr
00004bce: pop.w      {r4, lr}
00004bd2: b.w        #0x6ab0
00004bd6: cmp.w      ip, #1
00004bda: bne        #0x4bee
00004bdc: cmp        r4, #0
00004bde: it         ne
00004be0: movne.w    ip, #2
00004be4: orr.w      r1, r1, ip
00004be8: str.w      r1, [r2, #0x654]
00004bec: pop        {r4, pc}
00004bee: lsls       r0, r4, #0x1f
00004bf0: bmi        #0x4c08
00004bf2: cmp.w      ip, #0x72
00004bf6: bls        #0x4c08
00004bf8: cmp.w      ip, #0x75
00004bfc: bhi        #0x4c0e
00004bfe: orr        r1, r1, #0x40
00004c02: str.w      r1, [r2, #0x654]
00004c06: pop        {r4, pc}
00004c08: cmp.w      ip, #0x75
00004c0c: bls        #0x4b36
00004c0e: mov.w      r0, #0x680
00004c12: mov        r2, r3
00004c14: sub.w      r1, ip, #0x76
00004c18: mla        r4, r0, r4, lr
00004c1c: movw       r0, #0x50bc
00004c20: add        r0, r4
00004c22: pop.w      {r4, lr}
00004c26: b.w        #0x6b20
00004c2a: nop        
00004c2c: cbz        r4, #0x4c42
00004c2e: lsrs       r4, r0, #0x20
