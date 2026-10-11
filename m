Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAD346777
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791702163; cv=none; b=ROmZ2CuGY4gtLqhI8LKld3WCG6wBLrcNTenl6TQiglrM69U7dAnJnBYf8MdLKBibxrlh5ajuw3nS1nzed5v3r3/gdmCsqu08CWZc/DFpfjhVE8LYCwYDJsT0AwHC4a0z1LSZ1uNVaGiSSAmWVPHAj2zp1QX+Ine1etlE3WjHsik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791702163; c=relaxed/simple;
	bh=hqmqGCwbVJx8ioHIcMYlbkKBe0xuh6mKFsHbvXI5YKg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k3LVFBq+GvJ8kBXWccPi3q5wvN+zoyrLtuJCoFDOnupSNmh46QhJjL26KLOKCZlxj+lrHra/Yy7X/vatONBND75dZxo1OuryUptMxoXBaUjlt97hFhagDU/myWsplg21TmBb/q6xy3V9UinwqzygtF/UWwpV6gj7b4xz++ThsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-815f2b1ecc3so2466909a34.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 00:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791702161; x=1792306961;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVDCCtkvR+2GpVfroq+EMg9txxyO2n28YifI2CSvk/U=;
        b=KCS8LAAltjVCBLuTZJ4KRiANaoMvRoyfWlF6F7I4Mw9aisoJ90DLsCyAk/rxsJjhTV
         V1RDsAjkd1TmxuSdlT5nT0i+G/lkQ8nufRPIJqYYHpY/ZEtzl4dXYUzuD0l6aGJfkhcf
         Q17uG7LbxYaukzUvQFR4jARDYgTwM4s/v2wzu9cSHhoaAnIAqSJwHHAQGRh/qQOkur/e
         QPPxrpCmr1tH9XYAxWMEC6cif9gMjChniNfa12fLA2ooPBcmkSfANHflG9AifPfKUwRB
         t44nbmF8ilyJ+iblu4c+9u9iOYUF8TuJt/f0fjHwPUK5VpF6fW7OpqZ/mudNFAPqrQAL
         Tcrw==
X-Forwarded-Encrypted: i=1; AKwUvBzj8dDmU5ruFd75z59mqAFLtyDWYmMn7S1HEqFvvuNpFNO21MwW654GBwcxoLY/9gv9NZYpDKI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+D+JyheTlAqcw4swIVCxg7Rngu3YTMAUCozAwsKcVvwu12+PP
	pnNsZU8Dl9mlhbSkUi3yAJvdn7tpQZ5M5Q6C/ovWmBBeNRrPq4jQgJ8QoHwsNvUpSUUdAInZ2jq
	BpwhXWxNIvricQtc/+gR0wFyOAzbVDlxyuir+OmI5u9TwV4HO7329Qxorq6E=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f6c:b0:4f4:550a:3a86 with SMTP id
 5614622812f47-50c599658bfmr6839516b6e.53.1791702161359; Sun, 11 Oct 2026
 00:02:41 -0700 (PDT)
Date: Sun, 11 Oct 2026 00:02:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acb3491.a150a118.27e199.0039.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in addrconf_verify_work (10)
From: syzbot <syzbot+95263979a9c3af871646@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@kernel.org, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3857c2fe5449 Merge tag 'pci-v7.3-fixes-4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1614c0a5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4118aaa2d227be26
dashboard link: https://syzkaller.appspot.com/bug?extid=95263979a9c3af871646
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/891094e1d3d5/disk-3857c2fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea13e7a03404/vmlinux-3857c2fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/853f16987787/bzImage-3857c2fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95263979a9c3af871646@syzkaller.appspotmail.com

INFO: task kworker/R-ipv6_:3196 blocked for more than 158 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/R-ipv6_ state:D stack:29528 pid:3196  tgid:3196  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: ipv6_addrconf addrconf_verify_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7433
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 rtnl_net_lock include/linux/rtnetlink.h:134 [inline]
 addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4770
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479


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
