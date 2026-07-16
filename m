Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB6D3D522C
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220639; cv=none; b=qh/vEDzxhr1wllgpP3LUar2J02pl050Wqzn1g6kngb1g6e7+cWCBXSaxc1sUOVsfsUhqWMnwSULrdFPSZxIOUF7BvOR55IKh8AAw6zmYeuQVuLAx9kL/Yw0SgDQuc0ptHWPVtGKFqQ92uLAGW67t+yMiVh+xeIiur/1YX2zy2pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220639; c=relaxed/simple;
	bh=xRnhCY+k7z1dleRqIlO8T/pUtA8zwogHlTW7un2uqqs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FrtaRzylh5+NAi7ihmpHVtmLysE2TfCMq/kP+lVgU/P3T428phe2EILMNxikaS54SaKzUI/vEhp6k6CxpUxEVT0EJXeRdGoPQS8G/+B3rizYawZWM3g3H0aV91br3rWt2EeIMVe3kNhCt0DeCAlSNtB2vQKp29BdoPv5k62+DDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4959c49e054so6515183b6e.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220634; x=1784825434;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=130vXAEr8kfQks0tdluythHVQMOFL0FGy2rzRI/DZaU=;
        b=JEu/7TQQ9+EZims/xCIyCUKLfxCMcB1/86KIZv1taQgsNCwF+m9guek1HolIXDWynP
         qNY66FGbV8y0rh8fOTE97m7xW/ADO8TwIh+e3DOxWMOLhKc6s0C7Rn9Ja3gCkR4bE+/Q
         SG9qdJWzk2KA3kMc5eGeUNIsUDgQ2ocGxqU4OdxBK/AgqWhjM8Kt9tFdacQK2huzgLFw
         KQy0G/02yW70IzPnRmessTsoR7DuolzYqL8UbR2taClP6lbJrDUAX005vD9V3mcajPtK
         Jq5HsE0+YUVqlS0SM7UqrHKFV0Aiqh2dRAogvVK3kP7YqqG9gGZGYWXKstTAl2jkNzFu
         cLlg==
X-Forwarded-Encrypted: i=1; AHgh+RqeLJ+vCaQdzgLN9LbcA+5hEE5Hlr7xYNC4quG3o11D4j0croFV6mSwiX75Kq5LOYiyWehZnwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxmp5z6K8FeyXttHyD1+SWEHwr14no1feB3K7aZkOWZNLHB5kI
	mPhjf2mCAWMSN3U48BZWEs/TRPz1Ce72hGiLqhETeQhSE03PNcO8Nc3E5JXq1h24Dg4kTbVGxXM
	O/d4pVUTcQcqIbhJfD+rSu7swq0wTV/5fRla6dndRNxy2pDJeKaC/UD3nKc8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6b89:b0:496:301:36b9 with SMTP id
 5614622812f47-4a4959865a2mr5532528b6e.0.1784220633954; Thu, 16 Jul 2026
 09:50:33 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:50:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a590bd9.5622734e.c905.0031.GAE@google.com>
Subject: [syzbot] [rds?] KCSAN: data-race in rds_sendmsg / rds_sendmsg (3)
From: syzbot <syzbot+879c1877016972360186@syzkaller.appspotmail.com>
To: achender@kernel.org, allison.henderson@oracle.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rds-devel@oss.oracle.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b029c035b34 Merge tag 'cgroup-for-7.2-rc3-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1638fb89580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84b3039e8461eef5
dashboard link: https://syzkaller.appspot.com/bug?extid=879c1877016972360186
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9ab6065d4938/disk-3b029c03.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7373fbe29535/vmlinux-3b029c03.xz
kernel image: https://storage.googleapis.com/syzbot-assets/938cb90d037d/bzImage-3b029c03.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+879c1877016972360186@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in rds_sendmsg / rds_sendmsg

write to 0xffff888101dec818 of 8 bytes by task 30904 on cpu 0:
 rds_sendmsg+0xc1f/0x1580 net/rds/send.c:1332
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x532/0x580 net/socket.c:2684
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2773
 x64_sys_call+0x194c/0x3020 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff888101dec818 of 8 bytes by task 30905 on cpu 1:
 rds_sendmsg+0xc1f/0x1580 net/rds/send.c:1332
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x532/0x580 net/socket.c:2684
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2773
 x64_sys_call+0x194c/0x3020 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000000 -> 0xffff88811b61faf0

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 30905 Comm: syz.5.5733 Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
==================================================================
atomic_op ffff888118e74d28 conn xmit_atomic 0000000000000000


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
