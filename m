Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1617BB21
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787619544; cv=none; b=WBzX5YZGZdsLVSXy9T2bH9w8kwGzs36188kuSYJ59zVWBoh47Z8Q2ROAS3SULI7tUqEZRBcW3n+DDwndiJei3rpIVVYk5VfxTSMVw2xsvIvU1SwrWK8CtA2zrvjafn0sngdBpQPHfkI5d02iB3pPyPXSOPGoTG6tcOq8BgKCLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787619544; c=relaxed/simple;
	bh=VQNd6jhlxL14tHxZqTtILYJTRI5SLBWvAqIw2UQYIfU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n32xprK7Tk6P0vRmVuQKut2Tg79XJvTN3qOZbA8Lp+a4aAQ+ON6x2dKZ0foTf3V8HYTse3PI/1vRASaX9YsjbsjGGI21bJa1k9fUd3dFxnetMZ50562vqN5TopVxHD3oM+S+FzTZQdMwsBFrYooDraXDOqPQGovfArWSThRwAKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4ab4ca7ce3fso6470949b6e.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 17:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787619542; x=1788224342;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XHN3WmZQWZX+LIE7fOr7prja+LlGk4nSTkd1bGXhP8s=;
        b=JheKS2rt62o7qZEdEpPm9B5C0dnW+gBe9x5hIjQ0fswtL+/KaHxno0Wd1OX0HCM5ib
         d8W/nwxbOo2ySgFJsGqVQ9Pq6aK00cRAkazOZTayUldSJMYL09nxgwUnz+gLuPikDniC
         q27glm4fkE5USTs65JEy4zQfhLSMr9B2d7reQPCaPJxAe8RjNfZAAxvYAwQx3u9PJON7
         6WnXikj6G1iDiOpv4eOA8ed49fA22QK9FRkQG46nwnBc1MBGtUQg6jiGf/8a4MT3Nz8P
         g0D1aDBWdhksQNdh1vrREuDPZaFepDb3TLO7E+XVbOK+NWjL3t+1LJVISdes0mzMafHq
         td9A==
X-Forwarded-Encrypted: i=1; AHgh+RrM+l6tLFt9Ws5Ye9AtSneZ7igh0JNH2qTr6wwtzeVc6aNH4YE9T/qlT2l+SQdp9nDJhHphJQ4=@vger.kernel.org
X-Gm-Message-State: AFuF++kj+GGKRMOrbmK7iYkquGkESPyqYO5cE7sXEmNnOZWKF1tq3/Fa
	gXdQmNLm9QxGuvF9oaMteIhbiJRULlV0yFz/han3AisF4PHV5IyZ9JDX/NBj+J7OZgAPS4vI6Q2
	2A3q2ISZtZ79vAQkW1dInX5dqSuG6RdXmBK2F4ZQOo30j7FPwcprN2G0ThfE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1642:b0:495:feaa:9e39 with SMTP id
 5614622812f47-4b309a06e98mr20614736b6e.6.1787619541998; Mon, 24 Aug 2026
 17:59:01 -0700 (PDT)
Date: Mon, 24 Aug 2026 17:59:01 -0700
In-Reply-To: <20260825002924.1439-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8ce8d5.dbb3a75c.7844.0018.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
From: syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>
To: boqun@kernel.org, edumazet@google.com, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in tcp_tsq_handler

------------[ cut here ]------------
!lockdep_sock_is_held(sk) && debug_locks
WARNING: ./include/net/sock.h:1799 at sock_owned_by_me include/net/sock.h:1799 [inline], CPU#1: kworker/1:0/24
WARNING: ./include/net/sock.h:1799 at sock_owned_by_user include/net/sock.h:1812 [inline], CPU#1: kworker/1:0/24
WARNING: ./include/net/sock.h:1799 at tcp_tsq_handler+0x1a6/0x200 net/ipv4/tcp_output.c:1292, CPU#1: kworker/1:0/24
Modules linked in:
CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
RIP: 0010:sock_owned_by_me include/net/sock.h:1799 [inline]
RIP: 0010:sock_owned_by_user include/net/sock.h:1812 [inline]
RIP: 0010:tcp_tsq_handler+0x1a6/0x200 net/ipv4/tcp_output.c:1292
Code: 30 96 96 01 e8 7b b3 7a f7 be 02 00 00 00 eb 0a e8 6f b3 7a f7 be 01 00 00 00 4c 89 ff e8 82 3e 8f fa eb d0 e8 5b b3 7a f7 90 <0f> 0b 90 e9 fd fe ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 07
RSP: 0018:ffffc90000a08bb0 EFLAGS: 00010246
RAX: ffffffff8a4c8ba5 RBX: ffff88802db742d0 RCX: ffff88801e6e5dc0
RDX: 8000000000000100 RSI: 0000000000000100 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000100 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000141164 R12: dffffc0000000000
R13: ffffc90000a08c20 R14: ffff88802db74100 R15: ffff88802db74100
FS:  0000000000000000(0000) GS:ffff888124df1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005635f5ecdbd8 CR3: 0000000072ba6000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 tcp_tsq_workfn+0x384/0x410 net/ipv4/tcp_output.c:1325
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 bh_worker+0x451/0x870 kernel/workqueue.c:3773
 tasklet_action+0xc/0x70 kernel/softirq.c:997
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 do_softirq+0x77/0xd0 kernel/softirq.c:546
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x140 kernel/softirq.c:473
 wg_socket_send_skb_to_peer+0x16b/0x1d0 drivers/net/wireguard/socket.c:183
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x1c8/0x7e0 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         66498c75 Merge tag 'dmaengine-7.3-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10adc979580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9ce1d694820ba2b
dashboard link: https://syzkaller.appspot.com/bug?extid=2d770620059281e225a4
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1497b549580000

