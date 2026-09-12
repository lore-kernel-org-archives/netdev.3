Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A751E36657B
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789256367; cv=none; b=kXAHbL0I5ES5MwKnJWX9r8C5dQboGc5QMmGs2PGGk+cEXH84WdFe4tSUiyiMFxnIVUT02NxXqa8BqEHoLPBn1ONR4y6UgvNp6O33j8q83x6ityT4VCIbU6a7viOiwjvcQyAeGrIVNPz3/8qd3f2OduAYJrSoRBuZpvma1KWru2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789256367; c=relaxed/simple;
	bh=CJOvd6ShywdZs1rx7fjJCsC/4XAK4z3X2gQXF3/nugw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B+G86rV7omU3lUx8OjPgjxsPmjwqcK9gDgdrZoGZHUdS0jDzghLZB1qcWvtvh2gH0HSP3HjKI6VvIGjQUb6EZKT9JPksw2jypJsD+PEjI8fNO3HYKlc2SAfpD2WFzUPxseFa9KSJSLNXP/m+bJAH0BYhOrWT4Ij/Kqp+CZbZ28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6b1b1ca0f3aso308141eaf.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 16:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789256364; x=1789861164;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+4nm1uFj1dV7vSKZCHtdIxVm+oQk/J5Z2TW7/T4cvs=;
        b=U6rs7nVG3f6WAS8JdiLU1GSjU5GULTYa1Q/tqmE9Rj3JvfwErbUeLAV+5uOckKnCt+
         Trb1T0On7QmXDYNL4jGUS8oEKSpgEW+Ae67pJ2jAIuq8iujjEFfuomagYpBkyLc936DI
         RRqxlOzFSI8CTTvpHZ1/56Ii6oE3gYhZQEO+V9eHNic1rrdgbr/LnOXMnAMo/pX1vzFU
         J6ITpWGX+OlCwZ2ZHnl+PUwpBz/z9gzJnz/JkLjRXxHtnOqCGmYAqt/HrvI11QbtmLJu
         KtSz+DTxNFup7CYhixGNEIiwXtW0Q+5SdHDVB3TMuYG462Fmfbts02EdQXxXmKSDzLaM
         n4FA==
X-Forwarded-Encrypted: i=1; AKwUvBynOIP/Ry6ML1kLHkGJRZLBJ/Ap8BP66wzlBVj8fXYr/IqtQQmRCig73UkWke5sX9ZLHUNuaOo=@vger.kernel.org
X-Gm-Message-State: AFuF++llQLgy6n69AdiTlmcVhg19bYOzjWsOM1pqU4MZepOdbjQPjhSh
	Jhn7ESDROnp6nKwNmlq2KmShnIwApgZgtJvHanr+4S8zLi6rL/N31MhqM/eyVoimHmE9gYIf/UX
	b6oBDbsVAT1pyShYcB2IvKhYg/AoLJHGQ04HYi70qtz1yBg2lkGWKhmR2g4k=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16aa:b0:6c1:e01b:3b1e with SMTP id
 006d021491bc7-6c1e01b48b3mr4716143eaf.48.1789256364568; Sat, 12 Sep 2026
 16:39:24 -0700 (PDT)
Date: Sat, 12 Sep 2026 16:39:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa5e2ac.6e6c5f9e.28f11f.0052.GAE@google.com>
Subject: [syzbot] [net?] WARNING in tcf_ct_flow_table_process_conn
From: syzbot <syzbot+6cc37aba98dac721c415@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5225b8eec4c9 mailmap: update entry for Jens Axboe
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165795f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=6cc37aba98dac721c415
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8ec9ac0f583a/disk-5225b8ee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba864b419b40/vmlinux-5225b8ee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ddacae1aa6db/bzImage-5225b8ee.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6cc37aba98dac721c415@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: net/sched/act_ct.c:437 at tcf_ct_flow_table_add net/sched/act_ct.c:437 [inline], CPU#0: ksoftirqd/0/15
WARNING: net/sched/act_ct.c:437 at tcf_ct_flow_table_process_conn+0x449/0x7c0 net/sched/act_ct.c:513, CPU#0: ksoftirqd/0/15
Modules linked in:
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:tcf_ct_flow_table_add net/sched/act_ct.c:437 [inline]
RIP: 0010:tcf_ct_flow_table_process_conn+0x449/0x7c0 net/sched/act_ct.c:513
Code: 85 81 02 00 00 41 0f b7 2f 31 ff 89 ee e8 6f b1 e9 f7 85 ed 0f 84 7c 01 00 00 e8 22 ad e9 f7 e9 e0 01 00 00 e8 18 ad e9 f7 90 <0f> 0b 90 e9 b2 01 00 00 e8 0a ad e9 f7 4d 89 f7 40 84 ed 74 27 e8
RSP: 0018:ffffc900001471d8 EFLAGS: 00010246
RAX: ffffffff89de1d98 RBX: ffff8880774aa000 RCX: ffff88801e299f40
RDX: 8000000000000100 RSI: 0000000000000100 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000100 R09: 1ffff1100ee95418
R10: dffffc0000000000 R11: ffffed100ee95419 R12: dffffc0000000000
R13: 1ffff1100ee9541e R14: ffff8880774aa0c0 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888124cd2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f40fd23ffd0 CR3: 0000000028424000 CR4: 00000000003526f0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000083
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tcf_ct_act+0x2a75/0x4050 net/sched/act_ct.c:1123
 tc_act include/net/tc_wrapper.h:131 [inline]
 tcf_action_exec+0x185/0x8d0 net/sched/act_api.c:1162
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
 process_backlog+0x727/0x18b0 net/core/dev.c:6728
 __napi_poll+0xaa/0x330 net/core/dev.c:7787
 napi_poll net/core/dev.c:7850 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:8007
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1099
 smpboot_thread_fn+0x565/0xa70 kernel/smpboot.c:160
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
