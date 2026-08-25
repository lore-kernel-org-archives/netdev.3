Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B53A1C9
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621157; cv=none; b=lf0SPlm7qi6a4CD6jIJREi8pfXZgr81A9arLF0OCv/81oCximzAnejTmuJbduiUshKDgGQbIVWEu7WwJjix7OBPJQhxrxCj2gM5IHrsRYD5M7H922fbzzVBcDIPrqjsCCqgk8WpL6ufduEqXnGS1/kXRN7xrNAIhE3Lh0sKiW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621157; c=relaxed/simple;
	bh=i/tX3sXaGUJWJSZxJuRHcHRSYfVg9AhXC6ooi9LHSy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5YrY6mjTQwa+ywkCFoobxTTB/0gxQrMb6+04Lhe6uUbJwYCgWpzL+RHxUAz1lRej7+tI2rJqIc+le8mN9HuwOPGMpienDcGv7AihYuNpO7P/Ui+0hWLElu08m6Z9Qmuq+rmgKPJ8ZfKGluLgschUaGKe/WRKe5N0CimW2x/p80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=vt1G5Pnt; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="vt1G5Pnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1787621150;
	bh=d8GDjJ8LQeZl1s9s9+WKqsltoJgYxJLyZsdjHcSnGic=;
	h=From:Subject:Date:Message-ID;
	b=vt1G5Pnt5ZF3MNU2vf4/siGKygMWcUHkK0IwwYFzp+GxUcOxUDh3zEmRYet30dpU/
	 OOsmvaGeEA2a2jbqcBHSJJaYpY8VBg4D+MNZvZpgwD8JlB0SHZjYJMdWRQzM1vwT0r
	 KEqp0t2SVdFWS5/UVEbmdh3/Pjq2/Vf06fVDE4Ss=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.31) with ESMTP
	id 6A8CEF1000006971; Tue, 25 Aug 2026 09:25:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9461346816207
X-SMAIL-UIID: CDBB01B456A7409989722AB5884D9BE1-20260825-092538-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>
Cc: boqun@kernel.org,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
Date: Tue, 25 Aug 2026 09:25:25 +0800
Message-ID: <20260825012527.1462-1-hdanton@sina.com>
In-Reply-To: <6a8ce8d5.dbb3a75c.7844.0018.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 24 Aug 2026 17:59:01 -0700	[thread overview]
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in tcp_tsq_handler
> 
Fine, another case of HBC, half baked croissant, thanks to syzbot.


> ------------[ cut here ]------------
> !lockdep_sock_is_held(sk) && debug_locks
> WARNING: ./include/net/sock.h:1799 at sock_owned_by_me include/net/sock.h:1799 [inline], CPU#1: kworker/1:0/24
> WARNING: ./include/net/sock.h:1799 at sock_owned_by_user include/net/sock.h:1812 [inline], CPU#1: kworker/1:0/24
> WARNING: ./include/net/sock.h:1799 at tcp_tsq_handler+0x1a6/0x200 net/ipv4/tcp_output.c:1292, CPU#1: kworker/1:0/24
> Modules linked in:
> CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> Workqueue: wg-crypt-wg0 wg_packet_tx_worker
> RIP: 0010:sock_owned_by_me include/net/sock.h:1799 [inline]
> RIP: 0010:sock_owned_by_user include/net/sock.h:1812 [inline]
> RIP: 0010:tcp_tsq_handler+0x1a6/0x200 net/ipv4/tcp_output.c:1292
> Code: 30 96 96 01 e8 7b b3 7a f7 be 02 00 00 00 eb 0a e8 6f b3 7a f7 be 01 00 00 00 4c 89 ff e8 82 3e 8f fa eb d0 e8 5b b3 7a f7 90 <0f> 0b 90 e9 fd fe ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 07
> RSP: 0018:ffffc90000a08bb0 EFLAGS: 00010246
> RAX: ffffffff8a4c8ba5 RBX: ffff88802db742d0 RCX: ffff88801e6e5dc0
> RDX: 8000000000000100 RSI: 0000000000000100 RDI: 0000000000000000
> RBP: 0000000000000001 R08: 0000000000000100 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffff52000141164 R12: dffffc0000000000
> R13: ffffc90000a08c20 R14: ffff88802db74100 R15: ffff88802db74100
> FS:  0000000000000000(0000) GS:ffff888124df1000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005635f5ecdbd8 CR3: 0000000072ba6000 CR4: 00000000003526f0
> Call Trace:
>  <IRQ>
>  tcp_tsq_workfn+0x384/0x410 net/ipv4/tcp_output.c:1325
>  process_one_work kernel/workqueue.c:3387 [inline]
>  process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
>  bh_worker+0x451/0x870 kernel/workqueue.c:3773
>  tasklet_action+0xc/0x70 kernel/softirq.c:997
>  handle_softirqs+0x226/0x860 kernel/softirq.c:645
>  do_softirq+0x77/0xd0 kernel/softirq.c:546
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0x100/0x140 kernel/softirq.c:473
>  wg_socket_send_skb_to_peer+0x16b/0x1d0 drivers/net/wireguard/socket.c:183
>  wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
>  wg_packet_tx_worker+0x1c8/0x7e0 drivers/net/wireguard/send.c:276
>  process_one_work kernel/workqueue.c:3387 [inline]
>  process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
>  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
>  kthread+0x38b/0x480 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> 
> Tested on:
> 
> commit:         66498c75 Merge tag 'dmaengine-7.3-rc1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10adc979580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e9ce1d694820ba2b
> dashboard link: https://syzkaller.appspot.com/bug?extid=2d770620059281e225a4
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1497b549580000
