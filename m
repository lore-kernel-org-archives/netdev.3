Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98D17BB21
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621262; cv=pass; b=nZDWz8qfwtv5DlHjXmYWco9p01oj/eAK1j6oJUlcvwuTWADkj1+v/NjQjAuYOCPRyg9jH1/GICuHkCCcQtnILYqdzFp8P6xibTODJSuYIPe9dLqNrAlKt5Zrp6ed7xFVhvTUdHhNCP/dLpGiI3wRXGU8/mci+l3CC5tK2erwJhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621262; c=relaxed/simple;
	bh=ykEI8MTHk3wP+PXoFTdfUhwpqe51/gHoWiBe40afaIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WE2NhaP3pZC74m6NaO1JiH5GTLNqRE8XCZDmB9gw61ynrqdtjTU85slkcdhxw/UWbehJXN0N8R+xm/etNysa+IBFEtjukxSnaVl4DAVeN5TmzrWtMzulkwEMip7E/0v8lXhtIr9CQVnZht7oi9b757L05nsNBmzcIkJk4UQvV/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DRF0X23P; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRF0X23P"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52b6543169fso28922671cf.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 18:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787621259; cv=none;
        d=google.com; s=arc-20260327;
        b=MFektfh44cVv+nGDmLJeyWApZeqMVAVblu4aP4q1ivpgJL1RrMHHlyO1UBUzRxxzy4
         ikhVG+9UZ7znUdudNyFblrkWf+1GjP9Bf0dtX/1b2Axd85ut4BUZC7V5K7+buQQD7yRw
         DQP8/NWa/4pMyu3gO7MtQxux+5XTceqc7HkNEoa2rNnQgCt0mV+dFr1eHdp4NSol8GwX
         MCrgI3J7QJEf63pzQz4+rRZMr1awOL3qKJd0tjQCeKZ0GCuTlqEzueCstJZnrZKE1n9G
         4Sq5YhuX7lRsSgJZLIAQhc/0xgX/oN89mEyvJjNJQOOq/7EXNhC6Y3IPg8w/4NHYclQf
         KFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CzGhn8tkEirJiftgSFXuP+XYSALuE25GQubbx5hwLCU=;
        fh=3gJEqfV2uj5yqdM6YBNJupTsR7MevDjP/bqonDeVLWw=;
        b=qbiC7wre8frsiYGOo1jtFp14OEL8gSQTuCu70iV8D7y5NxXrUDQknMRGGCGSCA7k4m
         rd7nZzAaz3p60uh0Zy6lO7xiaGnIf6LJB4T/KRPcuwMzN0RUqhWWCHTJt8q46DMTsHry
         3jnEVZsjk4STplwI/7YIafjZzWNR/qHDp6giZsllzBaZAB/YjWs+VFWBZh5aeYR2+Eq0
         sqLbEpMhm5bSpwUlffYX8MOWK9kIjKnlmmw/OHLvlq5ulkIUBq+z+X+5uUfqx1/Mr+hA
         6JlXHNEXpnW3nQcoOx+VszLVHGj+CjK0wvULaCVn2SevNdmu4W4K1eA5Unv5VaUmWxue
         R3xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787621259; x=1788226059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CzGhn8tkEirJiftgSFXuP+XYSALuE25GQubbx5hwLCU=;
        b=DRF0X23Pyzppz8b0gj2bts3PsmgGsNbJ5zpFTU8Xuw370LPkQIFeBMqmSU3WB6/UZE
         pTFae6wNO/e6fCNCxDKiAP48Dc/NwJvFsdP1sxPnrlb+jFuXPNTxUYFjD4mymMYMTVC6
         aOjPCiYPSG1I+X0k3JiwKlY2VJ2sPGM0gl/UsRXwew3Q2PFKdn3pP8V4yWE9oDyEjPJN
         f5l1Klyv6+3vQpBV16eozPnKgj+3ZdpvMErL6gAK2ne6LcZ72aQPzSDZliJ0z2dRaLfy
         XRk1Yf6fPBOt23D1LlUc3JaZjAa7s4uKOxvzqlWpXEndjoSzox2fTNcVtCefhnRHuLtD
         K/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787621259; x=1788226059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CzGhn8tkEirJiftgSFXuP+XYSALuE25GQubbx5hwLCU=;
        b=YGXcuzdp6vp+nF67TkGFNPYX4l+EHvyg/6UJAwN4egQ2W/UoQlrEJAvehB8mcLz/Re
         eANHG01YbR7e8GmyG2fLwmJEGckkfx143XoMw7/OqIJsZ8zqUB6nTQfyG7UXQwSYVof2
         hPsOCkXNfY4Bui05Uzrazzj4KBagxWOY2odujdkSQPh1bSIEc8f2vtof9dCy4bdjsmkC
         FBq1TFuLBvPJNwshDyqTenAvLjQNefh48BYNE8xzy53tzOTW/w98nBxGhJKIEHVUBKJW
         1CMWAeigA9CpzCALavdn2ZTO2Efp/VN2uwVWS/y7rkBVByuhXohdZYRtgLSNhMLNwJbi
         QwEg==
X-Forwarded-Encrypted: i=1; AHgh+RoGP2FwUlNBswqQXls2JXg44sWxspyk3SK6MuOmwPcrbuMKM4VF2OgEmjYC6yt56J9vsZZuzJQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mk5M+81SOvpATf5htxYG8m1nOqjQeSjTGCOnGCqCStl6uRxLIU
	ZkFQEA+qGcplpm9Tkb09yX8acEw/sPjOABLQReXwMm9vM+sLYwfPIrJ4hm0u9abeb55xS621g+J
	94mD/TjZdWEexaOCtzsDkq86P0uYoODUSFQTu2jiu
X-Gm-Gg: AR+sD11eS9mRl7x7MLGkni+76UXXBvyR9JuVNpFQ8ka5eSsnkQV3j+IQIcbdK+QRVUa
	BcGougUDOHKUmD4rSbvpvVgLt5fpmWfl473i5HpsOiuZ3eR/0UPeewAeynw1l9Cm9IAjTUcf8rA
	yOwr0F2ewluJ9TXb2I/oNFZRB4/1uYohecnrLg7+Vh4ZkblUgcyLEN/G7SLWhLldvplJ9vzzBok
	Pq3USnzr7ijZA3J/qZZ9RxEWhF3oWh1aXy0DlGgEp5iurIow9ISldaMC9t8crMPkJcPKEIgbWeT
	mZcFI+s+/EC183bkJ9tXqevzuPgKtZfvSTtYIpH6OfuA8jSmKDijRVxvQoaWOGvHH80xvq96JM7
	VD5pWbl6bAZze1Ws1unaKxTazuc+38NMKos98b5RINVfXC1bSxzmN8+Gz
X-Received: by 2002:ac8:5703:0:b0:51c:849e:e222 with SMTP id
 d75a77b69052e-52e2f15a7c0mr34212681cf.36.1787621258937; Mon, 24 Aug 2026
 18:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825002924.1439-1-hdanton@sina.com> <6a8ce8d5.dbb3a75c.7844.0018.GAE@google.com>
In-Reply-To: <6a8ce8d5.dbb3a75c.7844.0018.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 03:27:27 +0200
X-Gm-Features: AcwNN1WXiD_Cx4o_7gWRytCEaDCjxDvOJpkZrTYSyiZ3qjXpboVSJD7i75K26ds
Message-ID: <CANn89i+wnTLC==UnXCpjsS4YxvEfhe5oK0N7fttbqr1zKyqdug@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
To: syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>
Cc: boqun@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:59=E2=80=AFAM syzbot
<syzbot+2d770620059281e225a4@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> WARNING in tcp_tsq_handler
>
> ------------[ cut here ]------------
> !lockdep_sock_is_held(sk) && debug_locks
> WARNING: ./include/net/sock.h:1799 at sock_owned_by_me include/net/sock.h=
:1799 [inline], CPU#1: kworker/1:0/24
> WARNING: ./include/net/sock.h:1799 at sock_owned_by_user include/net/sock=
.h:1812 [inline], CPU#1: kworker/1:0/24
> WARNING: ./include/net/sock.h:1799 at tcp_tsq_handler+0x1a6/0x200 net/ipv=
4/tcp_output.c:1292, CPU#1: kworker/1:0/24

Note this is a different warning.

This one might have been added in nvme-tcp in commit

commit 19bdb70c77d3b24239a453291299b64040bdba86
Author: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Date:   Thu Jun 4 11:32:08 2026 +0900

    nvme-tcp: lockdep: use dynamic lockdep keys per socket instance

The authors assumed that __fput_sync(queue->sock->file) in
nvme_tcp_free_queue() synchronously destroys the socket, so they
unregistered the keys immediately:

__fput_sync(queue->sock->file);
queue->sock =3D NULL;
...
#ifdef CONFIG_DEBUG_LOCK_ALLOC
lockdep_unregister_key(&queue->nvme_tcp_sk_key);
lockdep_unregister_key(&queue->nvme_tcp_slock_key);
#endif

However, a TCP socket's lifetime is asynchronous:
in-flight skbs (e.g. buffered in a qdisc or device ring) hold
references on sk->sk_wmem_alloc.

When those packets are freed later, tcp_wfree() puts sk on TSQ and
tcp_tsq_handler(sk)
acquires bh_lock_sock(sk) on a socket whose lockdep key has already
been unregistered and zapped.

All other kernel storage/networking clients (sunrpc, nbd, cifs,
iscsi_tcp, rxe, siw) use static lockdep keys without issue.

> Modules linked in:
> CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted syzkaller #0 PREEMPT(=
full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/24/2026
> Workqueue: wg-crypt-wg0 wg_packet_tx_worker
> RIP: 0010:sock_owned_by_me include/net/sock.h:1799 [inline]
> RIP: 0010:sock_owned_by_user include/net/sock.h:1812 [inline]
> RIP: 0010:tcp_tsq_handler+0x1a6/0x200 net/ipv4/tcp_output.c:1292
> Code: 30 96 96 01 e8 7b b3 7a f7 be 02 00 00 00 eb 0a e8 6f b3 7a f7 be 0=
1 00 00 00 4c 89 ff e8 82 3e 8f fa eb d0 e8 5b b3 7a f7 90 <0f> 0b 90 e9 fd=
 fe ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 07
> RSP: 0018:ffffc90000a08bb0 EFLAGS: 00010246
> RAX: ffffffff8a4c8ba5 RBX: ffff88802db742d0 RCX: ffff88801e6e5dc0
> RDX: 8000000000000100 RSI: 0000000000000100 RDI: 0000000000000000
> RBP: 0000000000000001 R08: 0000000000000100 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffff52000141164 R12: dffffc0000000000
> R13: ffffc90000a08c20 R14: ffff88802db74100 R15: ffff88802db74100
> FS:  0000000000000000(0000) GS:ffff888124df1000(0000) knlGS:0000000000000=
000
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
>  wg_socket_send_skb_to_peer+0x16b/0x1d0 drivers/net/wireguard/socket.c:18=
3
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
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10adc97958000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3De9ce1d694820b=
a2b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2d770620059281e=
225a4
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e25=
5-1~exp1~20260613092250.77), Debian LLD 22.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1497b54958=
0000
>
