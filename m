Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792978365;
	b=1Ntjxf44QJLINhfNeVsYwmaACqx3n5BJu9bOKB1gfXyFXIKllxrtg5cJKRFpsdrPoQQw
	 cNCV8QyWRhFbmJIanVTN+Pu+PN78ZHC62Z+lkuXUI6VoTZCL1XzQwSWnzPVoqTC0QnRcG
	 OrIu4nAyTRf/S4XO//da8jhYFItu0fZzofasOXvfnaRUt2cQVQWfhM8rjKCcYIj4XqNeU
	 fakoIL7Y/c8EqtAPUF8gJHhqqBWduj6neqbc/uQDzkkqQjO54yi3twCspNnsbtuw5t1Ji
	 5tuKYMr1TcYynBBFzyO0euHX3bnUinTYeX7I+0vDI7YsZE4XhnX2g3g71qWkssp644g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792978365;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=1WrAPJVqztXGeicWZ8YmBuP6dCF2HqU/IaTH6pLRzhE=;
	b=kR7bgmgJ3tOWrryiPFTKD9MynAcPX/CVr5ebbLbks2rmptztq9sRbfxjwSi7vakIYBIQ
	 ibKNx7DDKQve42dvMia/d1tfTw+u6rH2LvjxlYDsLFR75ExvbKKxHxyMtr8pZV2GYKqk7
	 IT8iAvcrRBjc8UCesMRiUaL3q/gN7cDO69c9fgseJ7CLVu7iZ6fKQ/sAnRubkGQLCjjN0
	 ztw3PcDss16vSQD6gdNtgLAah1Z2DyQkypTpRl3c/2U1pNpKoqds0kA4W2g3rGb/VIgNq
	 9+O9QHHnG7PKkxLANB3jQytBRGfreCE34PjUWsqO5BcCPfwgLPs3oz3F2tLg9pmkj/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08374606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 01:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08374606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4d2f0f77124so3292102b6e.3
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 18:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792978364; x=1793583164;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1WrAPJVqztXGeicWZ8YmBuP6dCF2HqU/IaTH6pLRzhE=;
        b=ZxUCuF/EpBs8GOQn+yEIsMMYB/WX40dnVZ0Ezj5q7t25PiPN6lIvrehwDzjNgJaMzI
         2X4FRAxDFylfkE5mAsHjmBFjvpbeiPNJGwhGbwCrOp37gbishLtBk7BsIJDC8zkpC3SB
         FQpPKbK4Odwx2wseotjryx0eBWwlxw4e1cqCIm5LXMrupHVrleURLB8/Dtu81mY7ToWB
         fbwg7jIKBWE+HxSUHKPiA16espxDeVN13+SH9nfEunnQfDX2pil70mwhV1N2sMeEuD0g
         KSAScCKHvE9AlPsUFhVrCqybhDYGgfpRetvCPU+sM5PQP7ieam+FYDBQgiZCuQZHwKya
         2FxA==
X-Forwarded-Encrypted: i=1; AKwUvBwXLJE7EJV0WCnfmkqWyh50u5KxtAKwmmGxiRvAjMIyIG2fM1mqFDgUuM5LkQLy7djUWbErNnk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKw2PLzHYTqiIIN/ch3MkH2MmTkYjiaIyP7Yfp+7fHq+81DjbXG
	+avIuYKp0TWYdtqgYdHJE20SgosmBgyUpTgqawV+jH+JXYPD2xDKX9dQVnh9UnADaokyNQ55zgD
	U+/itkntx2gFQBNRElvL2hNReaPcK+duxLw5NtCjo5xyqs6kray9WmUD9tEM=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:220a:b0:4ed:7045:d3bc with SMTP id
 5614622812f47-55c002d9ed3mr3460748b6e.32.1792978364068; Sun, 25 Oct 2026
 18:32:44 -0700 (PDT)
Date: Sun, 25 Oct 2026 18:32:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6adeadbc.a6443767.132891.0050.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in cfg80211_cac_event
From: syzbot <syzbot+3df76a08d929e91e5327@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    734bef548a96 Merge tag 'net-next-7.4' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12a55469580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f4f48df8e34eb3
dashboard link: https://syzkaller.appspot.com/bug?extid=3df76a08d929e91e5327
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/585a51a9cc57/disk-734bef54.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b2888e6093ab/vmlinux-734bef54.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74d0b6ec60eb/bzImage-734bef54.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3df76a08d929e91e5327@syzkaller.appspotmail.com

------------[ cut here ]------------
!time_after_eq(jiffies, timeout)
WARNING: net/wireless/mlme.c:1309 at cfg80211_cac_event+0x45b/0x6e0 net/wireless/mlme.c:1309, CPU#1: kworker/u8:3/2120
Modules linked in:
CPU: 1 UID: 0 PID: 2120 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:cfg80211_cac_event+0x45b/0x6e0 net/wireless/mlme.c:1309
Code: fc ff ff e8 67 a8 7d f6 90 0f 0b 90 eb c8 e8 5c a8 7d f6 48 8d 3d 85 18 43 06 67 48 0f b9 3a e9 35 fd ff ff e8 46 a8 7d f6 90 <0f> 0b 90 e9 82 fe ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c 24 fc ff
RSP: 0000:ffffc9000328f918 EFLAGS: 00010293
RAX: ffffffff8b4abdda RBX: 0000000100010317 RCX: ffff888031c13e80
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000000
RBP: 0000000100011a86 R08: ffff888031c13e80 R09: 0000000000000003
R10: 0000000000000005 R11: 0000000000000000 R12: ffff8880569213e8
R13: dffffc0000000000 R14: 0000000100011a87 R15: 1ffff1100ad2427d
FS:  0000000000000000(0000) GS:ffff888123b6b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd8c6a5cdc CR3: 000000007562a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_dfs_cac_timer_work+0x264/0x380 net/mac80211/mlme.c:3995
 cfg80211_wiphy_work+0x29e/0x420 net/wireless/core.c:610
 process_one_work kernel/workqueue.c:3495 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
