Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33755324B20
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834542; cv=none; b=GmuaUSaB4ZsPiy2sdJe/t1UKiOfh/PZsOTrdB9SaicnOpyT4sEGm+fBX5aGlDZcA6Eh/fwqQa3/fWxZob4Aa9J3AikFKtp3iiNedve7XpKq7EC8IKGU1AAGX7BflB45mvVU0XRw7kEf1BWXuGPTWBPIG9e8loeGhecNKBXVm2nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834542; c=relaxed/simple;
	bh=R+Gzx4wF/f/nN9wBJ0TOlVsVE0es6pz+b1hE+LHy7KE=;
	h=From:Message-ID:Date:Subject:To:MIME-Version:Content-Type; b=pGB62365ztEjeduYcTBoT9HUUFBX0poUCfLLD7if14/YyQVNGbsrgBMwAV0+8wJvKOoXkW67bT7gtcsxEg5rSKzHaSDhbXAcNmCUYglqJTU6ABwCZAw02qSGKw/+oZgDXNmd8GvkTGGTrrt9M2aYtegwzV33BdSJgsQ59S21/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=PK0A25kg; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=GLzWGCti; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="PK0A25kg";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="GLzWGCti"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834539; x=1788439339; bh=5mA2MLPVtnhfcq5Bqs
	NPBbOEgYBf8lR5/QGqu07JtM4=; b=PK0A25kgxeN8iRqRVx0JgKUEQxkBC/R/ARIivpVsciSq0
	SV4isFmDeaXqGubWgqWT1SoGJRwPioY3ohGeQpIrU6v19j3GMTfvl5kP8yFp8zdMtbIPIJWaCMZ
	J5p6j7o3m88s1DtSJVzIIljYykromL77t7yqNVd3eqPKozO44QSl/uib2nxwnkLd60aK86MT9BA
	8CMdlZADbmj+wZe5Dq6n+i98PWnKMVnb6Fo/fGj1hs4ZhQ1XHrFL0itueKN476LvuZlPa/P6BTN
	4x+w6m9MRWStFT+iDGXsFKClB5T1Eb4iZmZyS/bA140B4y6fN9hwoeT3ePOOly/hgVC9OlBw==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834539; x=1788439339; bh=5mA2MLPVtnhfcq5Bqs
	NPBbOEgYBf8lR5/QGqu07JtM4=; b=GLzWGCtiynSxmA0F8vGMEdh4IYpU2wmXUMGwxhEd5KayH
	55mglv5fgVo92kK0wK1JGa7Thh6AEXO9W5p0AEraww5gUG6gx1R98lc9zmGTCzBRKp0yUooftel
	Iyw6hvIMZ5pAl2ANDLh75LtKNQwrusJVeStEZNU725lszTeKCVJOc6AWCy/fieJ8AOcEDz8TFTG
	vOlHTvKFUSWyQVCB5eWCntS/JOJNU/AusKFtiM5Zcc/r3t2M2em9wZKXS5hZEyUZSK7uMvT8ZlM
	0X4+Gem3QfsZaMzZakpNM/t+5lTwznzD5w1gZ8FHjDUasYkH3j8pg36i2rnE/Ux/EmQbM6iA==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+2c72469dbbec34af@bugs.sh>
Message-ID: <YG9s0PiBKJZcXAKld3MToa1IVRJOUoKiaA57@bugs.sh>
Date: Thu, 27 Aug 2026 12:42:14 +0000
Subject: [BUG] net/ipv4: NULL pointer dereference in tcp_v4_rcv()
To: netdev@vger.kernel.org, "Eric Dumazet" <edumazet@google.com>, "Neal
 Cardwell" <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "Simon Horman" <horms@kernel.org>, "Salam
 Noureddine" <noureddine@arista.com>, "David Ahern" <dsahern@kernel.org>, "Dmitry
 Safonov" <0x7f454c46@gmail.com>, "Francesco Ruggeri" <fruggeri@arista.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    net/ipv4
    crash   NULL pointer dereference in tcp_v4_rcv()
    commit  7cbfb180945c ("net/sched: sch_cake: fix autorate reconfiguratio=
n throttling")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+2c72469dbbec34af@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/2c72469dbbec34af/patch.diff
        report.md   https://bugs.sh/b/2c72469dbbec34af/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  7cbfb180945c ("net/sched: sch_cake: fix autorate reconfi=
guration throttling")
    VM setup       https://bugs.sh/b/2c72469dbbec34af/run.sh
    config         https://bugs.sh/b/2c72469dbbec34af/config.gz
    poc            https://bugs.sh/b/2c72469dbbec34af/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Oops: general protection fault, probably for non-canonical address 0xdffffc=
0000000010: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
CPU: 1 UID: 0 PID: 145 Comm: exploit Not tainted 7.2.0+ #63 PREEMPTLAZY
RIP: 0010:tcp_v4_rcv+0x2637/0x3fe0  (net/ipv4/tcp_ipv4.c:1055 <- net/ipv4/t=
cp_ipv4.c:2333)
Call Trace:
 <IRQ>
 ip_protocol_deliver_rcu+0x66/0x310  (net/ipv4/ip_input.c:207 (discriminato=
r 1))
 ip_local_deliver_finish+0x356/0x4f0  (net/ipv4/ip_input.c:241 (discriminat=
or 1))
 ip_local_deliver+0x25c/0x2c0  (./include/linux/netfilter.h:325 <- ./includ=
e/linux/netfilter.h:319 <- net/ipv4/ip_input.c:262)
 ip_rcv+0x301/0x370  (./include/net/dst.h:480 (discriminator 6) <- net/ipv4=
/ip_input.c:492 (discriminator 6) <- ./include/linux/netfilter.h:325 (discr=
iminator 6) <- ./include/linux/netfilter.h:319 (discriminator 6) <- net/ipv=
4/ip_input.c:612 (discriminator 6))
 __netif_receive_skb_one_core+0x166/0x1b0  (net/core/dev.c:6264 (discrimina=
tor 4))
 process_backlog+0x1d7/0x700  (net/core/dev.c:6377 <- net/core/dev.c:6728)
 __napi_poll+0xa1/0x560  (net/core/dev.c:7787)
 net_rx_action+0x401/0xd80  (net/core/dev.c:7850 <- net/core/dev.c:8007)
 handle_softirqs+0x1a4/0x620  (kernel/softirq.c:645)
 do_softirq.part.0+0x3b/0x60  (kernel/softirq.c:546 (discriminator 20))
 </IRQ>
 __local_bh_enable_ip+0x6d/0x70  (kernel/softirq.c:538 <- kernel/softirq.c:=
473)
 __dev_queue_xmit+0x83e/0x36a0  (./include/linux/bottom_half.h:33 (discrimi=
nator 1) <- ./include/linux/rcupdate.h:914 (discriminator 1) <- net/core/de=
v.c:4961 (discriminator 1))
 ip_finish_output2+0x8da/0x19c0  (./include/linux/netdevice.h:3461 <- ./inc=
lude/net/neighbour.h:544 <- ./include/net/neighbour.h:558 <- net/ipv4/ip_ou=
tput.c:236)
 ip_output+0x162/0x2c0  (./include/linux/netfilter.h:314 <- net/ipv4/ip_out=
put.c:437)
 __ip_queue_xmit+0x7cf/0x1dc0  (net/ipv4/ip_output.c:533)
 __tcp_transmit_skb+0x303b/0x4a30  (net/ipv4/tcp_output.c:1716 (discriminat=
or 4))
 tcp_connect+0x2a92/0x5060  (net/ipv4/tcp_output.c:1734 <- net/ipv4/tcp_out=
put.c:4383)
 tcp_v4_connect+0x1186/0x17c0  (net/ipv4/tcp_ipv4.c:345)
 __inet_stream_connect+0x224/0xf60  (net/ipv4/af_inet.c:684)
 inet_stream_connect+0x57/0xa0  (net/ipv4/af_inet.c:755)
 __sys_connect+0x101/0x130  (net/socket.c:2183)
 __x64_sys_connect+0x72/0xb0  (net/socket.c:2189 <- net/socket.c:2186 <- ne=
t/socket.c:2186)
 do_syscall_64+0x94/0x450  (arch/x86/entry/syscall_64.c:61 <- arch/x86/entr=
y/syscall_64.c:84)
 entry_SYSCALL_64_after_hwframe+0x76/0x7e  (arch/x86/entry/entry_64.S:121)
Kernel panic - not syncing: Fatal exception in interrupt


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup


