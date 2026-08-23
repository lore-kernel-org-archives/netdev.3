Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD1E3803F8
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787509189; cv=none; b=UUHA7if60OL135n1GFi31lFJeYQ5D89E6wPtyCVkv0O2hZayT/DliAK3AY8ID0l0572FVXR643HQ0WTG8Blzm5QVQFRG6OCYVhQclyUIqL62iYvVcFxuflspXpUuzpCJm9+qfSQAw66O86GD+ce9/TB95nQXwaphKgggrU/x+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787509189; c=relaxed/simple;
	bh=jf5imuzUDrGWQW0D30IbauTDaI7H0/bOyFEg9tdKObk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fVBbTLlrapUjx3x4f9Vybo6KuLFTQ6cvQAASSfHX6+wnDi5KLua9aTbu51r119S1g8E6AwM94TzrZZPXdQbU3RMBuuEqRLQ0fq2jM2P3cNxCthPSLylMQMb6r0Bu9Y/iFFmPV6S4Xl4TBuXuvLfqgWFFVTW71tfZL1k4kIB53FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-4a41b6fb855so1091236b6e.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787509185; x=1788113985;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGloX+V1+57Pi8MeXi194PQoze6c1QdyTbNQsGRbY68=;
        b=Diu4hD9LJfluwxf7lzVOmjStuegR28Txtfz3fMEi17wSqB5xpRH0Xn5I8jxCAPwSFA
         Btwkdcc7AVdFLvPiTSLBxOuQquhilHhkO2tIdZ0VE6uv9SMaw6gnXB6WNAjLx82qkK4v
         IwUj8odL4wmDhvayyoXSjD1+evDcLbe/FeZLT+tbMN25eNSlch0t2vGWBEzBixbauj5g
         f3fLHtKhqsP/P98p1kQakCE4zYeNTMoUilae/aw0vi4aZI333IpnM3pi6pCNyeu44ye+
         FWqYvMfiB4rWAJrC7/8/Z9xv3USdtBLx6gjoXdXpyHHOK0eGPnNetGYa5lYFQpX/LbEc
         Ar0w==
X-Forwarded-Encrypted: i=1; AHgh+RocxvXKDW0GQonAEd1Ohjy0oLLNEBkJxLva+3AmLmsbwn8/wMdTrVFTV+pXmgOGvMnNqFuZUaM=@vger.kernel.org
X-Gm-Message-State: AFuF++nrPKrfIaJFdOptCXfgcIgcMM6l62bK6DUub5NjLjBkz1LCpOYn
	EGoTVkIfT2DIwKnPMmTlvbhH/gJ3BnpQ+3g+1p5i+XAK1kbozYsM2PGS7zh4p7IIPfFrHwdYE2C
	8FCtifc6Hgw8mxWw4K480gP/0l8h5G3lteBUfECeaoZEV05DBGwNOwL6Xzsw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c3f3:b0:4a3:fb6c:9adf with SMTP id
 5614622812f47-4b2ef3e6390mr20588939b6e.12.1787509184819; Sun, 23 Aug 2026
 11:19:44 -0700 (PDT)
Date: Sun, 23 Aug 2026 11:19:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8b39c0.dbb3a75c.13dd47.0051.GAE@google.com>
Subject: [syzbot] [net?] WARNING in tcf_skbmod_act
From: syzbot <syzbot+1d56f14f95c0480cfdc9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66fb95a52111 Merge tag 'caps-pr-20260820' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135f6179580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a70bec3546180b6
dashboard link: https://syzkaller.appspot.com/bug?extid=1d56f14f95c0480cfdc9
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6da0d1c4d90d/disk-66fb95a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/34b5360f76fd/vmlinux-66fb95a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bea190471e9f/bzImage-66fb95a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d56f14f95c0480cfdc9@syzkaller.appspotmail.com

------------[ cut here ]------------
!skb_transport_header_was_set(skb)
WARNING: ./include/linux/skbuff.h:3243 at skb_network_header_len include/linux/skbuff.h:3243 [inline], CPU#0: syz.0.2516/14949
WARNING: ./include/linux/skbuff.h:3243 at tcf_skbmod_act+0xfe8/0x1810 net/sched/act_skbmod.c:55, CPU#0: syz.0.2516/14949
Modules linked in:
CPU: 0 UID: 0 PID: 14949 Comm: syz.0.2516 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:skb_network_header_len include/linux/skbuff.h:3243 [inline]
RIP: 0010:tcf_skbmod_act+0xfe8/0x1810 net/sched/act_skbmod.c:55
Code: 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 6f 05 60 f8 48 8b 03 65 ff 40 10 b8 02 00 00 00 e9 66 ff ff ff e8 99 5b f0 f7 90 <0f> 0b 90 e9 a0 f5 ff ff e8 8b 5b f0 f7 90 0f 0b 90 e9 49 f6 ff ff
RSP: 0018:ffffc90006c571c8 EFLAGS: 00010293
RAX: ffffffff89d6cdf7 RBX: 1ffff1100fa67d56 RCX: ffff888029678000
RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
RBP: 0000000000000010 R08: ffff888029678000 R09: 0000000000000002
R10: 000000000000dd86 R11: 0000000000000000 R12: 000000000000ffff
R13: ffff88807d33eab6 R14: 000000000000000e R15: ffff88807d33eaba
FS:  00007fecc9f156c0(0000) GS:ffff888124cfd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fecc9f14ff8 CR3: 00000000265a6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tc_act include/net/tc_wrapper.h:131 [inline]
 tcf_action_exec+0x185/0x8d0 net/sched/act_api.c:1150
 tcf_exts_exec include/net/pkt_cls.h:361 [inline]
 basic_classify+0x1b2/0x2d0 net/sched/cls_basic.c:54
 tc_classify include/net/tc_wrapper.h:198 [inline]
 __tcf_classify net/sched/cls_api.c:1779 [inline]
 tcf_classify+0x43d/0x1160 net/sched/cls_api.c:1875
 tc_run+0x42d/0x750 net/core/dev.c:4463
 sch_handle_ingress net/core/dev.c:4538 [inline]
 __netif_receive_skb_core+0x1443/0x30c0 net/core/dev.c:6115
 __netif_receive_skb_one_core net/core/dev.c:6262 [inline]
 __netif_receive_skb net/core/dev.c:6377 [inline]
 netif_receive_skb_internal net/core/dev.c:6463 [inline]
 netif_receive_skb+0x1fe/0xbf0 net/core/dev.c:6522
 tun_rx_batched+0x1de/0x790 drivers/net/tun.c:1571
 tun_get_user+0x2be0/0x44d0 drivers/net/tun.c:2045
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2091
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fecc8f5e90e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007fecc9f14fb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fecc9f156c0 RCX: 00007fecc8f5e90e
RDX: 0000000000000097 RSI: 0000200000000080 RDI: 00000000000000c8
RBP: 00007fecc9035024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fecc9226038 R14: 00007fecc9225fa0 R15: 00007fecc934fa48
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
