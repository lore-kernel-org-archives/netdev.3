Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30083BD22B
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834566; cv=none; b=PLHmUNFRCVHsafJV157BmU0/+MwfNOjXHbqBX1P2Z5srK3g7k2mvyF5UPCSmAODy6/0p2f5DWjzV8703+grWc3o8wC3E1cJo14ZK9kZ+5xlowvD4K5LUMfDOfTMA5pVIAsWDw2HLPscVASF2FE5dVTWVKMT03YD4E/M6Y2aMcf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834566; c=relaxed/simple;
	bh=XQzAfIsC9+flS59+PGlC0Ss1Sp0nUG6zn1cFpGwpHo0=;
	h=From:Message-ID:Date:Subject:To:MIME-Version:Content-Type; b=ZNCfFOx/14v7WgNH5qB/1sWOTow8kW+7ft13NRajavWx2luvddUFKHBj6PtPhOgTvBnEOGQEFD31MobZrIrc/vu75zABHzHlsIqf9bOjWLf0pWZvvqSErmEMru8yrjFLGOtCVGUbH9SlfjS2W89fQdxLmLI2vR+/kbq/pKRyVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=T7T+fCfc; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=eC6Xbdf8; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="T7T+fCfc";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="eC6Xbdf8"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834559; x=1788439359; bh=q8SFxnN1MP94vl/s16
	UCgPLlqsrqwyFpQxZRdVvmd+0=; b=T7T+fCfc9hX471sQXOKoFXui5uj3dkdgfzlmsA2lOZFYh
	XaGGPKLvXKV8nzuNT/mly7jUyxJYDk5xee4OON/pjVJj2e/rsRy0X2FPGBJfcZ2MTzDBIb4mgY5
	tQQcMWLiYUI74ofhMJd6nm6BEal91U/oAQkmzrwQp5oOeucrv8vr2JdGIbEBgx3drIaJH4PAF+A
	yBB9B0dUyLLWlj0JlAx7pfvp2WNLnSAOii9YMF9i+t9J9HF9Aq+MxDC8BLrwYtpjx+faNghGQqK
	Y2NY8ZHPxc7amFUOyLUUahxYnYoGgxm11PfZ7tz4hUffPoKhVpI0uxYuqlLbhJjoLPWxksyA==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834559; x=1788439359; bh=q8SFxnN1MP94vl/s16
	UCgPLlqsrqwyFpQxZRdVvmd+0=; b=eC6Xbdf8inVcBQN7IZoDUjmsF1faANhVv2tepSh9IOmDL
	nsEJGl8NU2puFxWGgWGVNodOSAA78km2pXnBabwlxWhyPbnGwwyFo3xHjqksJPBdpCJ8//Jf2fe
	rHwkXi7qb1fWKhkAs9+bDdxsbkRn0Owm0t0TOsDDvVXItU2ZG+8rUwNhiKkuTgyB1pWGgH4n7YV
	5TauDu0cRO8EnvhCWkfLlkfHYqr9DTo6/DkRkvxUMrJoNFvWXxWOsSNznzKRswyLkAcFnoy9BFv
	SA0h67nX04jFWmfrv+ds32Nin8W3s8tJ3alOuN1hqKZc4SmA5/jWgZfB5QC8so6OKwJac2ww==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+5a7f44e9dc1eab32@bugs.sh>
Message-ID: <J9JLc2EgME43HXjcdEG2ILy4SDCm76YbQAKb@bugs.sh>
Date: Thu, 27 Aug 2026 12:42:32 +0000
Subject: [BUG] net/core: use-after-free in tcp_v4_do_rcv()
To: netdev@vger.kernel.org, "Eric Dumazet" <edumazet@google.com>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Willem
 de Bruijn" <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    net/core/sock.c` (missing handling), `net/psp/psp_sock.c`, `net=
/ipv4
    crash   use-after-free in tcp_v4_do_rcv()
    commit  7cbfb180945c ("net/sched: sch_cake: fix autorate reconfiguratio=
n throttling")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+5a7f44e9dc1eab32@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/5a7f44e9dc1eab32/patch.diff
        report.md   https://bugs.sh/b/5a7f44e9dc1eab32/report.md

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
    VM setup       https://bugs.sh/b/5a7f44e9dc1eab32/run.sh
    config         https://bugs.sh/b/5a7f44e9dc1eab32/config.gz
    poc            https://bugs.sh/b/5a7f44e9dc1eab32/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in tcp_v4_do_rcv (./include/net/psp/functio=
ns.h:107 ./include/net/psp/functions.h:118 net/ipv4/tcp_ipv4.c:1834)
Read of size 4 at addr ffff88800bf51e14 by task exploit/145
CPU: 1 UID: 0 PID: 145 Comm: exploit Not tainted 7.2.0+ #1 PREEMPTLAZY
Call Trace:
<IRQ>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
tcp_v4_do_rcv (./include/net/psp/functions.h:107 ./include/net/psp/function=
s.h:118 net/ipv4/tcp_ipv4.c:1834)
tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2238)
ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/netfilter=
.h:319 net/ipv4/ip_input.c:262)
ip_rcv (./include/net/dst.h:480 (discriminator 6) net/ipv4/ip_input.c:492 (=
discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) ./includ=
e/linux/netfilter.h:319 (discriminator 6) net/ipv4/ip_input.c:612 (discrimi=
nator 6))
__netif_receive_skb_one_core (net/core/dev.c:6264 (discriminator 4))
process_backlog (net/core/dev.c:6377 net/core/dev.c:6728)
__napi_poll (net/core/dev.c:7787)
net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
handle_softirqs (kernel/softirq.c:645)
do_softirq.part.0 (kernel/softirq.c:546 (discriminator 20))
</IRQ>
__local_bh_enable_ip (kernel/softirq.c:538 kernel/softirq.c:473)
__dev_queue_xmit (./include/linux/bottom_half.h:33 (discriminator 1) ./incl=
ude/linux/rcupdate.h:914 (discriminator 1) net/core/dev.c:4961 (discriminat=
or 1))
ip_finish_output2 (./include/linux/netdevice.h:3461 ./include/net/neighbour=
.h:544 ./include/net/neighbour.h:558 net/ipv4/ip_output.c:236)
ip_output (./include/linux/netfilter.h:314 net/ipv4/ip_output.c:437)
__ip_queue_xmit (net/ipv4/ip_output.c:533)
__tcp_transmit_skb (net/ipv4/tcp_output.c:1716 (discriminator 4))
tcp_connect (net/ipv4/tcp_output.c:1734 net/ipv4/tcp_output.c:4383)
tcp_v4_connect (net/ipv4/tcp_ipv4.c:345)
__inet_stream_connect (net/ipv4/af_inet.c:684)
inet_stream_connect (net/ipv4/af_inet.c:755)
__sys_connect (net/socket.c:2183)
__x64_sys_connect (net/socket.c:2189 net/socket.c:2186 net/socket.c:2186)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:8=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
The buggy address belongs to the object at ffff88800bf51e00
which belongs to the cache kmalloc-cg-192 of size 192
The buggy address is located 20 bytes inside of


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


