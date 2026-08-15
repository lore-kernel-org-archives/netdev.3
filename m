Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353092AD2E
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786797399; cv=none; b=bqm4WJoGyYYn3n0uN3y89IoPdWHwXP2+mScUSVNHuiTuQ4dG6vIUKM6ukmRPHvAE4WcV91d3UFoOdiM/J7/NTgqQuVF757FPDcxesV6KVonAz9K/XFm2xlLyeKZJOE3OV0Tz131csxB8YiGcqSaUSAzzZJw4CeerF2x0xNG3qq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786797399; c=relaxed/simple;
	bh=upPbpF5Ns7qjSG+Be6PRgfPc4f8xoS3GZ+mZqvs9saw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K04mo7q1WOD8T/nO5nkvBF+IMCXDO462RkNQbGPQsxe6B0ZHRCzbWw7MFMJdZceNNgP9yJeOhMYr44TVn8vWrFmcbpIxvPFaw2pqKJ0aY+dxB5Z0MYupWVtP9NAnZKvgsNwvkG395xUD+o70iKTZ/toacV726wMy3KFtOy85gmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9dee2f7b5so3201836a34.1
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 05:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786797397; x=1787402197;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3xZSYDBIyjPwAGqMxYB6n/h7DUmVr2x6TyLtNgxh4p8=;
        b=nY9TBeGhVu2YXDBpxEjwltoG3iyL9R+mB7UT8zRBJlC4+DWPDFkyAv4l8pOe2naT4B
         zj9mz5U/Yip5VNQZWMK5R3cOePjjsWZXEzexbfCopRGBJlQkWaKIUkuIo8uUQElMkYNh
         7i38dFubiWOcqnHsiB/CS/xrKo5CodrDIFA+JyPERDK0yKRkI3KsMy0b14cNYFuHElN5
         wpEWzutTp70Sk5Fzz44M1lmd/TV22OUIcN6DfTlE+jMHjE1tx8sZVqqYtsAFhTWZmF9L
         wkd97xcxTrCrON1PdBIKWDK4EHS1+jGPzUsWckEgg6Yn2UBESHysTXJvI4DgqAi/QGkT
         NVsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHRPzIJpNPoNqmxi6z1U4AAm11nsZj7krry7Y2C8Jx1rwxgqAj/IDFapVCbbJQGNdm09//ZUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy677o7yLZLNg+eHkH0IkxAlvpuyG0ZfVWNDGgMDGai5CLmNbI
	5/Puis0yqjGV8dhqIC3W3iL5nZiftDLSjRm4+Tb+p+C0bNinTE6KHF/aKplIOZEuR1HXlaqgb9V
	VcaRGFH7XpYlPUp6BPENn3i0ZPOoH5rpDOrbU+xo/bJxzGI7qTM+OCSvmc6Y=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f029:b0:6b0:4a08:17d9 with SMTP id
 006d021491bc7-6b0d68f6815mr9877005eaf.28.1786797397106; Sat, 15 Aug 2026
 05:36:37 -0700 (PDT)
Date: Sat, 15 Aug 2026 05:36:37 -0700
In-Reply-To: <6a0ca269.a70a0220.1a69d3.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a805d55.dbb3a75c.20434b.0016.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in stack_depot_save_flags (2)
From: syzbot <syzbot+1827030ed7bc886dd0a5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    15ef2f78c49d Merge tag 'input-for-v7.2-rc7' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b53279580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d67342c314f228d
dashboard link: https://syzkaller.appspot.com/bug?extid=1827030ed7bc886dd0a5
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137fa949580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1827030ed7bc886dd0a5@syzkaller.appspotmail.com

------------[ cut here ]------------
Stack depot reached limit capacity
WARNING: lib/stackdepot.c:302 at depot_init_pool lib/stackdepot.c:302 [inline], CPU#1: syz-executor190/6024
WARNING: lib/stackdepot.c:302 at depot_pop_free_pool lib/stackdepot.c:371 [inline], CPU#1: syz-executor190/6024
WARNING: lib/stackdepot.c:302 at depot_alloc_stack lib/stackdepot.c:462 [inline], CPU#1: syz-executor190/6024
WARNING: lib/stackdepot.c:302 at stack_depot_save_flags+0x9a2/0x9d0 lib/stackdepot.c:706, CPU#1: syz-executor190/6024
Modules linked in:
CPU: 1 UID: 0 PID: 6024 Comm: syz-executor190 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:depot_init_pool lib/stackdepot.c:302 [inline]
RIP: 0010:depot_pop_free_pool lib/stackdepot.c:371 [inline]
RIP: 0010:depot_alloc_stack lib/stackdepot.c:462 [inline]
RIP: 0010:stack_depot_save_flags+0x9a2/0x9d0 lib/stackdepot.c:706
Code: 0b 90 eb bf 48 85 ed 74 c6 48 89 2d 80 32 6c 16 48 89 ea 31 ed e9 0b ff ff ff 39 c1 72 1f 48 85 d2 74 20 48 8d 3d 6e e9 f9 0b <67> 48 0f b9 3a 45 31 f6 48 85 ed 0f 85 37 fa ff ff eb 92 90 0f 0b
RSP: 0018:ffffc90003d5f240 EFLAGS: 00010086
RAX: 0000000000002000 RBX: 0000000000000000 RCX: 0000000000002000
RDX: ffff88804f060000 RSI: ffffffff8e387082 RDI: ffffffff914d07e0
RBP: 0000000000000000 R08: 0000000000000001 R09: 000000001f92056e
R10: 00000000000000a0 R11: 0000000000000000 R12: ffffc90003d5f298
R13: 000000000000000f R14: ffff88816cc056e0 R15: ffff88816cc056e0
FS:  0000555582e6b400(0000) GS:ffff8880d5cde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556e2ead1be0 CR3: 00000000368af000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 kasan_save_stack+0x3f/0x50 mm/kasan/common.c:58
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4584 [inline]
 slab_alloc_node mm/slub.c:4917 [inline]
 kmem_cache_alloc_node_noprof+0x27d/0x6b0 mm/slub.c:4989
 kmalloc_reserve+0x148/0x350 net/core/skbuff.c:615
 pskb_expand_head+0x249/0x10e0 net/core/skbuff.c:2312
 skb_ensure_writable+0x2e9/0x480 net/core/skbuff.c:6377
 __bpf_try_make_writable net/core/filter.c:1685 [inline]
 bpf_try_make_writable net/core/filter.c:1691 [inline]
 bpf_try_make_head_writable net/core/filter.c:1699 [inline]
 ____bpf_clone_redirect net/core/filter.c:2491 [inline]
 bpf_clone_redirect+0x1f7/0x500 net/core/filter.c:2460
 bpf_prog_93719f3005523967+0x168e/0x33be
 bpf_dispatcher_nop_func include/linux/bpf.h:1454 [inline]
 __bpf_prog_run include/linux/filter.h:724 [inline]
 bpf_prog_run include/linux/filter.h:731 [inline]
 bpf_test_run+0x39c/0xa40 net/bpf/test_run.c:422
 bpf_prog_test_run_skb+0x15c4/0x3540 net/bpf/test_run.c:1225
 bpf_prog_test_run kernel/bpf/syscall.c:4859 [inline]
 __sys_bpf+0x2a12/0x4e80 kernel/bpf/syscall.c:6436
 __do_sys_bpf kernel/bpf/syscall.c:6537 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6534 [inline]
 __x64_sys_bpf+0xce/0x140 kernel/bpf/syscall.c:6534
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe84f88ff59
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9fca9ef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe84f88ff59
RDX: 0000000000000098 RSI: 00007fff9fcaa040 RDI: 000000000000000a
RBP: 0000000d00000085 R08: 0000555582e74770 R09: 0000555582e74770
R10: 00007fe84f9181a0 R11: 0000000000000246 R12: 00000001000002b7
R13: 00000000000001ce R14: 0000555582e6c760 R15: 0000000000000e14
 </TASK>
----------------
Code disassembly (best guess):
   0:	0b 90 eb bf 48 85    	or     -0x7ab74015(%rax),%edx
   6:	ed                   	in     (%dx),%eax
   7:	74 c6                	je     0xffffffcf
   9:	48 89 2d 80 32 6c 16 	mov    %rbp,0x166c3280(%rip)        # 0x166c3290
  10:	48 89 ea             	mov    %rbp,%rdx
  13:	31 ed                	xor    %ebp,%ebp
  15:	e9 0b ff ff ff       	jmp    0xffffff25
  1a:	39 c1                	cmp    %eax,%ecx
  1c:	72 1f                	jb     0x3d
  1e:	48 85 d2             	test   %rdx,%rdx
  21:	74 20                	je     0x43
  23:	48 8d 3d 6e e9 f9 0b 	lea    0xbf9e96e(%rip),%rdi        # 0xbf9e998
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	45 31 f6             	xor    %r14d,%r14d
  32:	48 85 ed             	test   %rbp,%rbp
  35:	0f 85 37 fa ff ff    	jne    0xfffffa72
  3b:	eb 92                	jmp    0xffffffcf
  3d:	90                   	nop
  3e:	0f 0b                	ud2


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
