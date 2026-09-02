Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8D372ECA
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788370418; cv=none; b=bYKBqUaENWHq+PmKkmHd1iCVgCT7FWb/WPY/BO9JWf+yXqv6g68noWi5DOk6vo2PCG4Ldk7Wil6VRLaaka26EfaL608S6YcyMe6dMG2jWd6b/WFIjbTLc2Oq43kRE027bxsMoWEF3vax1T/hLYndrRKZac+XVvXiRzNqWkBZsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788370418; c=relaxed/simple;
	bh=kLApcgrDHHoImg7rDx5AlYGkOwXeH6Lwo5nfizTtL/g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PI9V+UzqqOTZIwqgm0pfUoy0HQ8EBFZRO+qauPzB8Ms+SYbQRX0yX4qG1K/JKuMLGt70keUXOSMBGz/pptbdNW4rd2s4ACdwgYzKv745Y6nG4svj/imhmrhef22AblKCwz203W5R5z1dwRhS66ShtkdnzCKnz0F1MstiGrcmVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6b12d30261cso316355eaf.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 10:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788370415; x=1788975215;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E6iyjV1fsTZcltn61mxS6dNsDIgFSmZJkRfo9pUhTJc=;
        b=jPJjSAfqCj9srOv6knxkpQ9AQIy0bab28HioWwVV6tiEM+H28FnXTjVQwI5uDudAx9
         kG1RE3lTTEms6+ZzXh4Wd/1OZD8Moxa/cWtgPj8YsUStET1NRariYPweBMCbtEr+9Uxa
         R05TWCTbh4j+s368yEKQgJHjDgqLrDZms6H9fkG+J298VTto0RWLRjUET1uBrB2mPEF/
         M5yVCcaaJYXTwgsTgEJkK9IoyI+QZX6lWwinm423Gn8HVQ49iyL4DTxSMkbiQotfGQP4
         7TSq1hmmms0fuBL4jLw9TOOLDUmOPQXyBpsAFr6P+HmBRdnZSgXlgHEXMBYnJJ45hAMk
         EwyA==
X-Forwarded-Encrypted: i=1; AHgh+Rqjmnd050CyGFTKXSpeQUsx4+zB5qw8MQ3K5ii+YEXapSsH8QiaugLIAGV0nDp/EgbkOjzTkXU=@vger.kernel.org
X-Gm-Message-State: AFuF++l5I63lPIQpRQcvTAr59N9AIxJtdUdTySgweEyKNt1Ejl2OC5Fo
	1hf4I9myhyHyoJwLukON8GR9AI1n8GH4xe2JErXgXT7JLZLTRK8c2cgbQkcikpiEFqwi3cRSyhO
	02AB2eMOFfYDS0/S4umpnOzzb014mfEGIgcMVAu+FOecrwhGSaEeo3q1+Xas=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:161e:b0:6a0:f44b:1265 with SMTP id
 006d021491bc7-6b47eac399fmr4904452eaf.4.1788370415542; Wed, 02 Sep 2026
 10:33:35 -0700 (PDT)
Date: Wed, 02 Sep 2026 10:33:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a985def.e163c37b.143a1.000a.GAE@google.com>
Subject: [syzbot] [kernfs?] stack segment fault in kernfs_rename_ns (2)
From: syzbot <syzbot+80df2191816d8486bc51@syzkaller.appspotmail.com>
To: driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    594d90519502 af_unix: Unlink scc_entry in unix_del_edge().
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17d87e49580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e8a402093abe6b2
dashboard link: https://syzkaller.appspot.com/bug?extid=80df2191816d8486bc51
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/672b53d154af/disk-594d9051.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f5c69520cde/vmlinux-594d9051.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5f0629640136/bzImage-594d9051.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80df2191816d8486bc51@syzkaller.appspotmail.com

Oops: stack segment: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 18482 Comm: syz.4.3463 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:kernfs_rename_ns+0x3a/0x800 fs/kernfs/dir.c:1828
Code: ec 38 48 89 cb 48 89 54 24 10 49 89 f5 49 89 fe 49 bc 00 00 00 00 00 fc ff df e8 51 c6 51 ff 4d 8d 7e 30 4c 89 fd 48 c1 ed 03 <42> 80 7c 25 00 00 74 08 4c 89 ff e8 66 5f bf ff 49 83 3f 00 0f 84
RSP: 0018:ffffc900038ff930 EFLAGS: 00010206
RAX: ffffffff82753c3f RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc90003dc1000 RSI: 00000000000012b4 RDI: 00000000000012b5
RBP: 0000000000000006 R08: ffff8880261ebe00 R09: 0000000000000008
R10: 0000000000000007 R11: 0000000000000002 R12: dffffc0000000000
R13: ffff8880232a3870 R14: 0000000000000000 R15: 0000000000000030
FS:  00007facb7ebe6c0(0000) GS:ffff888124f58000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f12dd14a8f0 CR3: 00000000547f4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 kobject_move+0x560/0x720 lib/kobject.c:569
 device_move+0xe0/0x720 drivers/base/core.c:4689
 hci_conn_del_sysfs+0xb8/0x1a0 net/bluetooth/hci_sysfs.c:75
 hci_conn_cleanup net/bluetooth/hci_conn.c:170 [inline]
 hci_conn_del+0xc3d/0x1200 net/bluetooth/hci_conn.c:1308
 hci_conn_hash_flush+0x189/0x260 net/bluetooth/hci_conn.c:2736
 hci_dev_close_sync+0x7fc/0x10a0 net/bluetooth/hci_sync.c:5513
 hci_dev_do_close net/bluetooth/hci_core.c:499 [inline]
 hci_dev_close+0x108/0x260 net/bluetooth/hci_core.c:524
 sock_do_ioctl+0x101/0x320 net/socket.c:1300
 sock_ioctl+0x57a/0x7e0 net/socket.c:1421
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7facb6f9e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007facb7ebe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007facb7225fa0 RCX: 00007facb6f9e0d9
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000004
RBP: 00007facb7035024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007facb7226038 R14: 00007facb7225fa0 R15: 00007ffed9e90828
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kernfs_rename_ns+0x3a/0x800 fs/kernfs/dir.c:1828
Code: ec 38 48 89 cb 48 89 54 24 10 49 89 f5 49 89 fe 49 bc 00 00 00 00 00 fc ff df e8 51 c6 51 ff 4d 8d 7e 30 4c 89 fd 48 c1 ed 03 <42> 80 7c 25 00 00 74 08 4c 89 ff e8 66 5f bf ff 49 83 3f 00 0f 84
RSP: 0018:ffffc900038ff930 EFLAGS: 00010206
RAX: ffffffff82753c3f RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc90003dc1000 RSI: 00000000000012b4 RDI: 00000000000012b5
RBP: 0000000000000006 R08: ffff8880261ebe00 R09: 0000000000000008
R10: 0000000000000007 R11: 0000000000000002 R12: dffffc0000000000
R13: ffff8880232a3870 R14: 0000000000000000 R15: 0000000000000030
FS:  00007facb7ebe6c0(0000) GS:ffff888125058000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc1ac18158 CR3: 00000000547f4000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	ec                   	in     (%dx),%al
   1:	38 48 89             	cmp    %cl,-0x77(%rax)
   4:	cb                   	lret
   5:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
   a:	49 89 f5             	mov    %rsi,%r13
   d:	49 89 fe             	mov    %rdi,%r14
  10:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  17:	fc ff df
  1a:	e8 51 c6 51 ff       	call   0xff51c670
  1f:	4d 8d 7e 30          	lea    0x30(%r14),%r15
  23:	4c 89 fd             	mov    %r15,%rbp
  26:	48 c1 ed 03          	shr    $0x3,%rbp
* 2a:	42 80 7c 25 00 00    	cmpb   $0x0,0x0(%rbp,%r12,1) <-- trapping instruction
  30:	74 08                	je     0x3a
  32:	4c 89 ff             	mov    %r15,%rdi
  35:	e8 66 5f bf ff       	call   0xffbf5fa0
  3a:	49 83 3f 00          	cmpq   $0x0,(%r15)
  3e:	0f                   	.byte 0xf
  3f:	84                   	.byte 0x84


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
