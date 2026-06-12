Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2531F998;
	Fri, 12 Jun 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282562; cv=none; b=rBCb1QH0pxoKTDxzG/ukbAYPgIaGECjd5hKrYgUSKX2wtfMMPFz5LW0kK11wjHEVBWXw6CbwtEQKzwVdkt6dVX626u/urIXV8u0vKiw9lECbvS4ntOb8n4xvYysR1/yGqZoXuX24xzAUdrW0WtJC6Iaftpf+j74O3QFpF2tO3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282562; c=relaxed/simple;
	bh=pDlJRwm2q4MtfrMGx52E5MGlwxRmk+JgAQ+BX3789jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEQWwfttILzJzFA0V3q31PadGfV7eGpCs9tz1LezJKXLEmS6GzpHpfTdOUxJ02+iAovi7r2cdRQH22lBV7mZUHgULdxK2+y2SqQGSn5D47IMTzTxNuo7uea+vk2Xp8e9eHu37vekEviIH3XY9gDmWDO4ZdB5S31yw0pxZJdZH04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc01agrX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc01agrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50751F000E9;
	Fri, 12 Jun 2026 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781282561;
	bh=I99C95VSZFAqZWdmJRiXGaTYkzTe9GzY8sHQ6ZTyQlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uc01agrXbxRlTOO7LyCWS3kaTBbkV6SPNfqxp/j2mfJgPnSbBgHGrnHvkDxpX1d6A
	 Qyegf7x2849XwfGcQWnTeoWN6OlMOmaNPzpl7zuqPxcj7jDO2+X2xfxjXSDlBASYNO
	 7taYy/rFJAig2GMOECaQFxYPtkAuX1LNiZugnFwIFEZTh8vsF551waf7uBo6taDFAr
	 fSXrnJLNrijUsYzyZfDHUHkP3QOjNENNtREqb6RUnHtulKN5oBiIFVWUlJanuA9dR2
	 8g4TFidlSuglS3J+E2rv0buHZmUK787z0UFPs3CGqy/VbW7vY5DC3esNAFkf6drglq
	 3/yea1CdVELdQ==
From: Simon Horman <horms@kernel.org>
To: angelayucode@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	dsahern@kernel.or,
	blair.steven@alliedtelesis.co.nz,
	carl.smith@alliedtelesis.co.nz,
	linux-kernel@vger.kernel.org,
	angela.yu@alliedtelesis.co.nz,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] [PATCH] l2tp: fix IPv6 xmit frag failure for oversized non-GSO packets
Date: Fri, 12 Jun 2026 17:42:14 +0100
Message-ID: <20260612164213.694784-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610223557.2765487-1-angela.yu@alliedtelesis.co.nz>
References: <20260610223557.2765487-1-angela.yu@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
l2tp: fix IPv6 xmit frag failure for oversized non-GSO packets

This patch sets skb->ignore_df from ip6_sk_ignore_df(sk) inside ip6_xmit()
so that oversized non-GSO L2TPv3-over-IPv6 outer packets follow the
fragmentation path instead of being dropped with EMSGSIZE.

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index c14adcdd4396..f5370554cfb5 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -359,6 +359,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
>  	skb->protocol = htons(ETH_P_IPV6);
>  	skb->priority = priority;
>  	skb->mark = mark;
> +	skb->ignore_df = ip6_sk_ignore_df(sk);

[High]
Can this unconditional assignment clobber an skb->ignore_df that the
caller deliberately set before invoking ip6_xmit()?

For example, sctp_v6_xmit() in net/sctp/ipv6.c does:

	if (!(t->param_flags & SPP_PMTUD_ENABLE))
		skb->ignore_df = 1;
	...
	res = ip6_xmit(sk, skb, fl6, sk->sk_mark,
		       rcu_dereference(np->opt),
		       tclass, READ_ONCE(sk->sk_priority));

If the SCTP socket has pmtudisc set to IPV6_PMTUDISC_DO, _PROBE, or
_INTERFACE via setsockopt(IPV6_MTU_DISCOVER), ip6_sk_ignore_df() returns
false:

	static inline bool ip6_sk_ignore_df(const struct sock *sk)
	{
		u8 pmtudisc = READ_ONCE(inet6_sk(sk)->pmtudisc);

		return pmtudisc < IPV6_PMTUDISC_DO ||
		       pmtudisc == IPV6_PMTUDISC_OMIT;
	}

In that combination, won't the new write reset ignore_df back to 0 and
defeat the per-transport SPP_PMTUD_ENABLE-off setting, sending the
packet down the EMSGSIZE / IPSTATS_MIB_FRAGFAILS branch that the patch
is trying to avoid?

The same concern applies to L2TP itself. l2tp_xmit_queue() in
net/l2tp/l2tp_core.c does:

	skb->ignore_df = 1;
	skb_dst_drop(skb);
	if (l2tp_sk_is_v6(tunnel->sock))
		err = inet6_csk_xmit(tunnel->sock, skb, NULL);

inet6_csk_xmit() does not touch skb->ignore_df before reaching
ip6_xmit(). If the tunnel socket is configured with
IPV6_PMTUDISC_DO, doesn't the new line in ip6_xmit() also overwrite the
ignore_df=1 that l2tp_xmit_queue() just set?

Other ip6_xmit() callers (TCP via inet6_csk_xmit/tcp_v6_send_synack/
tcp_v6_send_response, XFRM NAT keepalive via nat_keepalive_send_ipv6)
inherit this behaviour change too. Would an OR-merge such as

	skb->ignore_df = skb->ignore_df || ip6_sk_ignore_df(sk);

or fixing this in the offending L2TP path be more appropriate, so the
contract of ip6_xmit() with its other callers is preserved?

[Medium]
The commit message says:

    For oversized non-GSO packets skb->ignore_df is not set, causing the
    packet to fail the transmit checks and hit the
    EMSGSIZE/IPSTATS_MIB_FRAGFAILS path instead of being fragments.

Is that accurate for the L2TPv3 data path? l2tp_xmit_queue() already
unconditionally does:

	skb->ignore_df = 1;
	...
	err = inet6_csk_xmit(tunnel->sock, skb, NULL);

and inet6_csk_xmit() does not clear it before ip6_xmit(). With the
pre-patch test

	if (likely((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb)))

ignore_df=1 should already short-circuit the MTU check on the data
path. Is the failure actually coming from a different path (for
instance an L2TPIP control-socket send that bypasses
l2tp_xmit_queue())? Could the changelog be updated to identify the
exact path that was hitting the EMSGSIZE branch?

>  	mtu = dst6_mtu(dst);
>  	if (likely((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb))) {

[Low]
After this change, ip6_xmit() and __ip_queue_xmit() have asymmetric
semantics for skb->ignore_df. The IPv4 helper only reads it:

	if (ip_dont_fragment(sk, &rt->dst) && !skb->ignore_df)

while ip6_xmit() now writes it from the socket's pmtudisc, overriding
callers. Should the two paths be aligned, or should this divergence be
documented near ip6_xmit()?

Also, two small typos in the commit message:

    the packet length does not excent the MTU
                              ^^^^^^ exceed?

    instead of being fragments.
                     ^^^^^^^^^ fragmented?

    transmited as intended.
    ^^^^^^^^^^ transmitted?
