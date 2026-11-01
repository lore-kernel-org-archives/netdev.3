Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793516499;
	b=VofahrrDMhqRipt7/s60OMjqJMkMFHTxGm994Uobry0hRnmfPHu+AUJCD9H2h1fOHU/l
	 SgiWW8xpYhSdQoyNxQ/tIgZeSMtH9W7WzzYCZuIhOLvhbl0yaQJjWmReiJwMTCjQ0AKlg
	 LTFs+hWUCuPad5/U5FpqljK+lffJFGpOrgoxO2+TU2zw2bZiBTU1kaCXNPGT9dRxzlrHG
	 FoaPuITqJDG9ohcPNusxmKasTcHuz20oFk9Vb9/CKrltO4okYZ8AQvtSfpMdIUTkRgvCJ
	 2VMSDjaRG4sXO7/hpeMG8R8HaQ1ykgunJK8Nc2Az9PYt9eauoWgRciOa4yaypqUWZdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793516499;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=nwyjgMoIeiZH8BYwHTrFRoSQQGuNp+c9mZ0aAo5uTqA=;
	b=EehwdEKcNPlA3DuN8bje/lvnbYpdRiLUgfWv23texp0DD+VSOTH+HSELhOWBcYl+iCBE
	 mz5qKgj2vhV1eGz4CVZiXS3r/E/McZy4Z91ZQ/P3z1N7XwRQ0TMCPli253mNUSQYWSWhm
	 AOXRluqIia2y5H0HBsnkzxksE/+jWJFQrqkCQCldhQfdEx02MVSBtiERs8KeMjRd5Ras1
	 XJ96dP0YrSIYqqNFpnomiVdmY38a7XRtZCfsMXSRz0wYwkmt525ecX8D7AH9c4fU4tYAO
	 hMB8XUcl6sd/qCtS85j1FePJf6sO1CBc1ulIX8VkTV3rGatQ4uUl3EWoMrdy/MoxjxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA16606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 07:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA16606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4ab4f652f9bso1638392b6e.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 00:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793516498; x=1794121298;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nwyjgMoIeiZH8BYwHTrFRoSQQGuNp+c9mZ0aAo5uTqA=;
        b=oIaIwwFR3wLxyuikzQOA7doXVFaIPo/j+2SCBRx3CowbMy0cde7IPDUWvyFFq4coMw
         O3BXM4rMlJs5muo06DJ+1QuVZ7ksSXo9rYEMgW622PyjjujvXZhXsFwExRC1S3LcTfsx
         tNYMmx5gXloM098JVBY4EITiU4rhesIRzFokveyKR4J2u0d2HXTdo+LW/BT8aiW2y5a2
         /krFm6dW5MobgXmNYOQTO7VbUgRL3f/h/ZyX7wpUtu+CKXih9XvsELUGVdaDabAs27Xp
         a9+q2slIw6NQd8EmrVMHU9v3VXZygCIEuB2a02em8WfYF0fPzVmnfYJB/yY6uefWLVZV
         z1xQ==
X-Forwarded-Encrypted: i=1; AKwUvBwo5diYKcBtXp1mbSGe0Y95GBcsdLaV/5EfM0b+53MGxICws0P+fipACB/VebY/K7Y5rvboqBo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtmD1MY6DlqV71Cb+/1JnajCs/v3mJmbTRu28ctrjAt1iwNuae
	iZYzooxoEAaKy1nL0DCbBjqZgD2YzRKxI6h1bZx0SGZSTDrS/bLSKnAAVCR0/1YDH0F6fls+6dw
	jxjDbCvMdeXiTgsIKB/Oz3k5SryC0+qGvqBL0SuwVA+FKP+uml3VZetYWJ6A=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:199a:b0:4f7:a3f2:d8b4 with SMTP id
 5614622812f47-5640de44246mr4227384b6e.65.1793516497844; Sun, 01 Nov 2026
 00:01:37 -0700 (PDT)
Date: Sun, 01 Nov 2026 00:01:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae6e3d1.7fe51036.1ecf7.0016.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in
 nsim_drv_port_add (2)
From: syzbot <syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    36aad21d50d1 Merge tag 'ksmbd-for-7.4-rc1-part2' of git://..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1332b159580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc4462df6d1062fe
dashboard link: https://syzkaller.appspot.com/bug?extid=b3fca27eb4005f0111f4
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1194b795580000

AI-generated root cause summary:
In netdevsim, sysfs device attributes such as 'new_port' and 'del_port' are
exposed at the device level on nsim_bus_dev without holding device_lock or
checking if the driver is bound. An access via sysfs after the driver has been
unbound, after a failed probe, or concurrently with device removal finds drvdata
set to NULL; passing this NULL pointer to priv_to_devlink() computes a negative
offset from NULL, triggering a kernel page fault crash when attempting to
acquire devlink->lock.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=b3fca27eb4005f0111f4

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffffffffffeb0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD f1b3067 P4D f1b3067 PUD f1b5067 PMD 0 
Oops: Oops: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6031 Comm: syz-executor405 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/15/2026
RIP: 0010:__lock_acquire+0x41/0x2de0 kernel/locking/lockdep.c:5140
Code: 2d 12 48 89 84 24 e0 00 00 00 65 48 8b 05 0f e3 2d 12 48 89 44 24 08 45 31 f6 83 3d 28 dc 32 0f 00 0f 84 90 14 00 00 48 89 fb <48> 8b 07 48 3d a0 69 92 94 0f 84 7e 14 00 00 45 89 cd 89 cd 41 89
RSP: 0018:ffffc900046978d8 EFLAGS: 00010002
RAX: ffff88801ff11f40 RBX: fffffffffffffeb0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: fffffffffffffeb0
RBP: ffff88801ff11f40 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000007 R12: fffffffffffffeb0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000246
FS:  000055558a5ef400(0000) GS:ffff888124716000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffeb0 CR3: 00000000452a0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 __mutex_lock_common kernel/locking/rtmutex_api.c:561 [inline]
 mutex_lock_nested+0x55/0x1d0 kernel/locking/rtmutex_api.c:580
 nsim_drv_port_add+0x5a/0x140 drivers/net/netdevsim/dev.c:1760
 new_port_store+0x1a5/0x280 drivers/net/netdevsim/bus.c:96
 kernfs_fop_write_iter+0x3a5/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efc00506777
Code: 48 89 fa 4c 89 df e8 58 1c 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007fff1f51a010 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055558a5ef400 RCX: 00007efc00506777
RDX: 0000000000000002 RSI: 00007efc005586de RDI: 0000000000000003
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff1f51a228
R13: 0000000000000002 R14: 00007efc005825a0 R15: 0000000000000002
 </TASK>
Modules linked in:
CR2: fffffffffffffeb0
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x41/0x2de0 kernel/locking/lockdep.c:5140
Code: 2d 12 48 89 84 24 e0 00 00 00 65 48 8b 05 0f e3 2d 12 48 89 44 24 08 45 31 f6 83 3d 28 dc 32 0f 00 0f 84 90 14 00 00 48 89 fb <48> 8b 07 48 3d a0 69 92 94 0f 84 7e 14 00 00 45 89 cd 89 cd 41 89
RSP: 0018:ffffc900046978d8 EFLAGS: 00010002
RAX: ffff88801ff11f40 RBX: fffffffffffffeb0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: fffffffffffffeb0
RBP: ffff88801ff11f40 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000007 R12: fffffffffffffeb0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000246
FS:  000055558a5ef400(0000) GS:ffff888124716000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffeb0 CR3: 00000000452a0000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	2d 12 48 89 84       	sub    $0x84894812,%eax
   5:	24 e0                	and    $0xe0,%al
   7:	00 00                	add    %al,(%rax)
   9:	00 65 48             	add    %ah,0x48(%rbp)
   c:	8b 05 0f e3 2d 12    	mov    0x122de30f(%rip),%eax        # 0x122de321
  12:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  17:	45 31 f6             	xor    %r14d,%r14d
  1a:	83 3d 28 dc 32 0f 00 	cmpl   $0x0,0xf32dc28(%rip)        # 0xf32dc49
  21:	0f 84 90 14 00 00    	je     0x14b7
  27:	48 89 fb             	mov    %rdi,%rbx
* 2a:	48 8b 07             	mov    (%rdi),%rax <-- trapping instruction
  2d:	48 3d a0 69 92 94    	cmp    $0xffffffff949269a0,%rax
  33:	0f 84 7e 14 00 00    	je     0x14b7
  39:	45 89 cd             	mov    %r9d,%r13d
  3c:	89 cd                	mov    %ecx,%ebp
  3e:	41                   	rex.B
  3f:	89                   	.byte 0x89


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
