Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE935F5F8
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267659; cv=none; b=iKot3u8PbF4Ce1UG36W0JO59CrcTo7b6Dku+E9fJNL8g9Dx+Bq4MLk4NZ9gFAf05WVHwSm/bxz+V75DchiOfhR6R6MyTyNGfZKeI6oOagvSnDLFZIAfPuq10ahoSHfxFQNGS1AqKVWSs6LE2gXoSglDuaYNiqmEXBINeBmBLhTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267659; c=relaxed/simple;
	bh=x3HkxTQhZql3jqj4yHPnz2Mrhm/CGIn5dMsk9yXg8Js=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=InKPsDPIXUJyI254HaHbnPYtKyEvdkrIa5SKky5a6+42dlIH5hR4+wKwPn4m5qTb8c59UwcPgFYRdmXPGHpH7XM/O9xOLeGipc384fcqZVg/jMif1Lxm4eev8Y+yJsKvbBhCTGGcgUy07AmXoPBFoMBVbrL3J1kFwC+G2zBR5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-8069d92e182so185778a34.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 19:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789267657; x=1789872457;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvFXA7ZMQ0Qs9h5Sn4zOQqZDFnGcVyURyKazgFI6Ib8=;
        b=XqdxmrrW82PkjehZa2hdyqPWq8SUxNK8RW6G78kl5nfQJYVk8CcofLS/sVZ0f+M1i9
         AQcxPrHGAqM+MSga7ziLKaYpvoZShRe46hOeCoOB5Ru5viWQ54G9pDYM73KfHPIe+L0f
         dnF26AJ/BeukIFeArg/G2c3IVm8SjCpNUvujYDYt/VZmeUfd24Y4YzzWTcf0+m1hSpnq
         a0/uhJdbjTMkVeR0dZeCTRMOxXlxa1pr1zznhE1ifCo1UatCzLNn+93tRMoFLKEJ3kbk
         CoYlrQbRMrkvxCX104toNDmgx6eOc8zxglBNeRJ2QZJyv6WC3Nw1V0iWd20ItcIkJkrM
         RDIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxN0e6OeJhijt6RS8ZdNkgdd86BH2xQPANcXJMF/5AuYnV6JVJf5H8iHIpyz713SHVj3rPPGO4=@vger.kernel.org
X-Gm-Message-State: AFuF++lAIpD3jYK1i6RJicZHwKjfdx02YDoaOEpENXjfR+XbtBQ/2vx0
	XS4ZmTy6Gm1RU0Jrvu7eIkeMpF2voFO4ObjHmtTK705bpKWHT6IhVAy396XpvS6iVyV7WNDu+X1
	o8U3/V6Xrw744DTNQfIJMzctcV5XhMTOMrnOz6ap+QYhzD36jgS+LvyxATJw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:169e:b0:6aa:da04:b56f with SMTP id
 006d021491bc7-6c24c6ca779mr2331851eaf.3.1789267657282; Sat, 12 Sep 2026
 19:47:37 -0700 (PDT)
Date: Sat, 12 Sep 2026 19:47:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa60ec9.f81106d8.2ab401.0032.GAE@google.com>
Subject: [syzbot] [batman?] WARNING in batadv_iv_ogm_process_per_outif
From: syzbot <syzbot+a079f084653164a652d1@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org, 
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org, 
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170ef749580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=a079f084653164a652d1
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108ef749580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b696f9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/daf497619736/disk-50d05c7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/748fbd82f647/vmlinux-50d05c7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e61c59099d07/bzImage-50d05c7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a079f084653164a652d1@syzkaller.appspotmail.com

RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
!orig_ifinfo
WARNING: net/batman-adv/bat_iv_ogm.c:1413 at batadv_iv_ogm_update_seqnos net/batman-adv/bat_iv_ogm.c:1413 [inline], CPU#1: syz.1.17/5794
WARNING: net/batman-adv/bat_iv_ogm.c:1413 at batadv_iv_ogm_process_per_outif+0x1fe4/0x25c0 net/batman-adv/bat_iv_ogm.c:1550, CPU#1: syz.1.17/5794
Modules linked in:
CPU: 1 UID: 0 PID: 5794 Comm: syz.1.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:batadv_iv_ogm_update_seqnos net/batman-adv/bat_iv_ogm.c:1413 [inline]
RIP: 0010:batadv_iv_ogm_process_per_outif+0x1fe4/0x25c0 net/batman-adv/bat_iv_ogm.c:1550
Code: ff ff e8 af ad 1c f6 49 bc 00 00 00 00 00 fc ff df e9 80 f4 ff ff e8 9b ad 1c f6 90 0f 0b 90 e9 47 e1 ff ff e8 8d ad 1c f6 90 <0f> 0b 90 48 8b bc 24 80 00 00 00 e8 6c df ff ff 48 c7 44 24 50 00
RSP: 0018:ffffc900030e7280 EFLAGS: 00010293
RAX: ffffffff8bab1d03 RBX: ffff888078df0a00 RCX: ffff88802efc3e80
RDX: 0000000000000000 RSI: ffffffff8e475f59 RDI: ffffffff8c6d9a80
RBP: ffffc900030e7410 R08: ffffffff907a2b7f R09: 1ffffffff20f456f
R10: dffffc0000000000 R11: fffffbfff20f4570 R12: dffffc0000000000
R13: 0000000002020000 R14: ffff88802bce4000 R15: ffff888078df0a00
FS:  0000000000000000(0000) GS:ffff888124dd2000(0063) knlGS:000000005807c480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7153200 CR3: 000000007a636000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 batadv_iv_ogm_process net/batman-adv/bat_iv_ogm.c:1866 [inline]
 batadv_iv_ogm_receive+0xc13/0x1740 net/batman-adv/bat_iv_ogm.c:1974
 batadv_batman_skb_recv+0x4b6/0x870 net/batman-adv/main.c:529
 __netif_receive_skb_one_core net/core/dev.c:6264 [inline]
 __netif_receive_skb net/core/dev.c:6377 [inline]
 netif_receive_skb_internal net/core/dev.c:6463 [inline]
 netif_receive_skb+0x4af/0xbf0 net/core/dev.c:6522
 tun_rx_batched+0x1de/0x790 drivers/net/tun.c:1571
 tun_get_user+0x2be0/0x44d0 drivers/net/tun.c:2045
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2091
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x27a/0x6a0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f480ec
Code: 90 85 d2 74 0a 89 ce 81 e6 ff 0f 00 00 89 32 85 c0 74 05 c1 e9 0c 89 08 31 c0 5e 5d c3 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 58 b8
RSP: 002b:00000000f752fa5c EFLAGS: 00000206 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000080000800
RDX: 0000000000000026 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	85 d2                	test   %edx,%edx
   3:	74 0a                	je     0xf
   5:	89 ce                	mov    %ecx,%esi
   7:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
   d:	89 32                	mov    %esi,(%rdx)
   f:	85 c0                	test   %eax,%eax
  11:	74 05                	je     0x18
  13:	c1 e9 0c             	shr    $0xc,%ecx
  16:	89 08                	mov    %ecx,(%rax)
  18:	31 c0                	xor    %eax,%eax
  1a:	5e                   	pop    %rsi
  1b:	5d                   	pop    %rbp
  1c:	c3                   	ret
  1d:	90                   	nop
  1e:	0f 1f 00             	nopl   (%rax)
  21:	51                   	push   %rcx
  22:	52                   	push   %rdx
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	58                   	pop    %rax
  3f:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
