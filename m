Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A493E171F
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853981; cv=none; b=Ou9ufoLksFCl+WPIXsDl5wxr3H8OBcXPp1ktgMYG+Z0bXYEQEeGv69Z5GreKy0ny2DI7b8F7TYUwnewiqwB0Fw9mQG+mJsEzjJgpYAZUV9ATRo/m1uZnRMPyhUa2SyArD/3faOHEA6PE7FjHUkHmfeAUEK77Jn2+JcVqZUV7X40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853981; c=relaxed/simple;
	bh=kn+YB4KdX6gzE0cSD9I/1GsySqihz01vxAHeLtRBS7g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vxk5jyfQQTCPAUOTVV90qeFwNmQXRKvraplR84kadXY4lixxAxncVA/hzMWBOWhPEUQIzt1wXKIrdY1d59zJFuWUGnVTRrRspV1kz5WNc6OghLGfqrgguVDzzPnYPsVT8VrDzaixZYlCufGY2LVldJjhRyXdvA/JfIBlHIIsCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7e9ee20bde0so3435877a34.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 07:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785853965; x=1786458765;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIWh+MuuKJnCrhJDGHpX6JEMCkNxEUgCFjoaSiOaBGc=;
        b=f9U5oKkQldDemgjZMxYCNj/+Qtu9lSFZl8VAQm6PCtbNYZYn19bTKtVbb+6pBVx5+i
         1cW6xSbhJlfLeCRJyuwT4HvSU1a2Q3Mhfjdu3N1d7bqUyhLzRAN4d4/mRErhcN1k078g
         i6qnAmQqnF4w045Uu/Id91FrK32pe1xAvAdYkCMx2YP2lPQ5Z75ED0OZs6VzP++LRDPa
         lqe4wiD49OLn2GIobDVYfqTFVcUF6cZupmdNB5BH1LefgAXd5kdg4UoFAZOgnsjoXDd7
         YGf/+IRCxTi6ALMt6GbJEKe8Riex30B+IJS0pzjgBAcXXZYf5w5Aysy2h692KVJie9Tn
         JlBQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQCUxjDYXdtF61fzh1yjKTPyF/DcJyPSbJi+ryNBHoD4GdvG/2VUzUF+sJIyfpWaCGc2da2qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgbjbad6FFZBbVmt9QNxuZ74uWYcsYXg9LHLz7HAKLo4807hh6
	xG/bbsT53CWPNKZmBNqmFE3ze9BYvTprm3+aXAvnQy3FfThfyn7dW+wGi1w7oNNwFTtUPLF8jFJ
	eqhPFzIkb5VqEo3u0udjFV914/+3mjg5wB51GhGN5rpG1js0pfxWQrMiT78Y=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e845:0:b0:6aa:d909:1457 with SMTP id
 006d021491bc7-6ae433e58d2mr17742594eaf.36.1785853964747; Tue, 04 Aug 2026
 07:32:44 -0700 (PDT)
Date: Tue, 04 Aug 2026 07:32:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a71f80c.40259c87.584f4.04b9.GAE@google.com>
Subject: [syzbot] [net?] WARNING in netdev_queue_get_dma_dev
From: syzbot <syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    075b74841bd0 Linux 7.2-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=176a7db9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=a78926bdac2adb52dc0e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16225db9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bade32580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1dc04730d019/disk-075b7484.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d76da42271f4/vmlinux-075b7484.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07b1cdbcbe45/bzImage-075b7484.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com

------------[ cut here ]------------
RTNL: assertion failed at ./include/net/netdev_lock.h (72)
WARNING: ./include/net/netdev_lock.h:72 at netdev_assert_locked_ops_compat include/net/netdev_lock.h:72 [inline], CPU#1: syz-executor223/5620
WARNING: ./include/net/netdev_lock.h:72 at netdev_queue_get_dma_dev+0x52e/0x660 net/core/netdev_queues.c:43, CPU#1: syz-executor223/5620
Modules linked in:
CPU: 1 UID: 0 PID: 5620 Comm: syz-executor223 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:netdev_assert_locked_ops_compat include/net/netdev_lock.h:72 [inline]
RIP: 0010:netdev_queue_get_dma_dev+0x53a/0x660 net/core/netdev_queues.c:43
Code: 89 c5 89 c6 e8 27 f7 68 f8 45 85 ed 0f 85 be fb ff ff e8 a9 fc 68 f8 48 8d 3d 12 0e 90 07 ba 48 00 00 00 48 c7 c6 a0 88 18 8d <67> 48 0f b9 3a e9 9c fb ff ff e8 87 fc 68 f8 48 8d bd 00 08 00 00
RSP: 0018:ffffc90003b47a80 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888029874000 RCX: ffffffff89a16569
RDX: 0000000000000048 RSI: ffffffff8d1888a0 RDI: ffffffff91317390
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88807b3f2568 R15: ffffc90003b47be0
FS:  00005555885ac400(0000) GS:ffff888123ed8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 000000006f8b6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 zcrx_register_netdev io_uring/zcrx.c:831 [inline]
 io_register_zcrx+0xe94/0x1d30 io_uring/zcrx.c:983
 __io_uring_register io_uring/register.c:942 [inline]
 __do_sys_io_uring_register+0x1193/0x1bc0 io_uring/register.c:1040
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd0b54bbcb9
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe25f0a7f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 00007ffe25f0a928 RCX: 00007fd0b54bbcb9
RDX: 0000200000000400 RSI: 0000000000000020 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffe25f0a928
R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffe25f0a918
R13: 0000000000000002 R14: 00007fd0b554cca0 R15: 0000000000000002
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 c5                	mov    %eax,%ebp
   2:	89 c6                	mov    %eax,%esi
   4:	e8 27 f7 68 f8       	call   0xf868f730
   9:	45 85 ed             	test   %r13d,%r13d
   c:	0f 85 be fb ff ff    	jne    0xfffffbd0
  12:	e8 a9 fc 68 f8       	call   0xf868fcc0
  17:	48 8d 3d 12 0e 90 07 	lea    0x7900e12(%rip),%rdi        # 0x7900e30
  1e:	ba 48 00 00 00       	mov    $0x48,%edx
  23:	48 c7 c6 a0 88 18 8d 	mov    $0xffffffff8d1888a0,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 9c fb ff ff       	jmp    0xfffffbd0
  34:	e8 87 fc 68 f8       	call   0xf868fcc0
  39:	48 8d bd 00 08 00 00 	lea    0x800(%rbp),%rdi


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
