Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA8486620;
	Fri,  2 Oct 2026 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937145; cv=none; b=lSUY8AoegF2kXHpImLDm6KNHgfZ7UW7/14vLmk1FiFC+2B+bm2eYATiKGvr0BuT7nk+bUItIdB9SjrNSuD0F0waFZm6N5PwOgfqx8/lzS+jJOINzpTJ/8qQGGbnadI38GIOf6WEyP5jHVK5geY19hSOP9Widfp6HMPsmrkqLWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937145; c=relaxed/simple;
	bh=Dn1/Tk35X//9iO2VSaYQl9fQIDxaDJc3uK7hc6TiHmM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P/aC4Qnm0Ow/lymTQoruEp6QBkde8dv4N5fAAvJPKvsT2/T8jN5smsPBQSeK/zCpN2EzM35VPDZ/BxmQJZW6N1XBWdnGrEHMzeepeF5qtE8iTUwa9kg/CbtZ6zZfz9MlKdzIHqSg5wMZhz1+ns4319SbIP31IB7dty/aZoDg878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONPhBqOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONPhBqOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C8D1F00898;
	Fri,  2 Oct 2026 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937143;
	bh=iPblK5MVDpqG2uE0q1oYrBT7Aythrfowz9n/YDj2r9U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ONPhBqOuhMwmq2agOX7W9U4xPvcuWygg7V3ipXyP6lzssmWiIpSJN1ObXgSciRqN6
	 g7EhExO5ZaGV6t++n692Jy9VVArS5YL5v5oP9nrzxyZMwCfx3FdbXgy9+FX5cYvuID
	 f+9MIA+vU702WGnCZr6PSktU88zBHiqYwJdeOi3MY6MYM+YlF5EL7Vp0eKi3Z+YUU7
	 OZMx99yVEpq31fonTWscwMNAa6BHDzuXjTRxMvkWy4nsQJxBCyV0k+VWA8MgNzieBn
	 GzoaPgluu+WSzJFozVdTDjuCiYV9+dAZvomZ0B0kRuk8Q7pthXtaCzRt0cSeMKbBem
	 1kQuMY3xjGjSw==
Subject: Re: [PATCH 06/16 net-next v2] ipv4: udp: split IPv4 specific logic
 into udp_ipv4.c
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:22 +0000
Message-ID: <179093714260.434549.7181479065811703026@kernel.org>
In-Reply-To: <20260928193046.6698-7-fmancera@suse.de>
References: <20260928193046.6698-7-fmancera@suse.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch moves udp_rcv() from net/ipv4/udp.c into the new
  net/ipv4/udp_ipv4.c, but the moved copy is stale and undoes commit…

--

ipv4: udp: split IPv4 specific logic into udp_ipv4.c

This patch moves the IPv4 specific UDP code (lookup, input/output, error
handling, multicast and the AF_INET udp_prot) out of net/ipv4/udp.c and
into a new net/ipv4/udp_ipv4.c. The new file is built only when
CONFIG_IPV4 is enabled, which is a step toward building INET without IPv4.

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b534b85bc623c..0f2ff5a9d4ae4 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c

[ ... ]

> -int udp_rcv(struct sk_buff *skb)
> -{
> -	struct rtable *rt = skb_rtable(skb);
> -	struct net *net = dev_net(skb->dev);
> -	struct sock *sk = NULL;
> -	__be32 saddr, daddr;
> -	unsigned int ulen;
> -	struct udphdr *uh;
> -	bool refcounted;
> -	int drop_reason;
> -
> -	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> -
> -	/*
> -	 *  Validate the packet.
> -	 */
> -	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
> -		goto drop;		/* No space for header. */
> -
> -	uh   = udp_hdr(skb);
> -	ulen = udp_get_len(skb, uh, 0);

[ ... ]

> diff --git a/net/ipv4/udp_ipv4.c b/net/ipv4/udp_ipv4.c
> new file mode 100644
> index 0000000000000..466008c218df4
> --- /dev/null
> +++ b/net/ipv4/udp_ipv4.c

[ ... ]

> +int udp_rcv(struct sk_buff *skb)
> +{
> +	struct rtable *rt = skb_rtable(skb);
> +	struct net *net = dev_net(skb->dev);
> +	struct sock *sk = NULL;
> +	unsigned short ulen;
> +	__be32 saddr, daddr;
> +	struct udphdr *uh;
> +	bool refcounted;
> +	int drop_reason;
> +
> +	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> +
> +	/*
> +	 *  Validate the packet.
> +	 */
> +	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
> +		goto drop;		/* No space for header. */
> +
> +	uh   = udp_hdr(skb);
> +	ulen = ntohs(uh->len);
> +	saddr = ip_hdr(skb)->saddr;
> +	daddr = ip_hdr(skb)->daddr;
> +
> +	if (ulen > skb->len)
> +		goto short_packet;
> +
> +	if (ulen < sizeof(*uh))
> +		goto short_packet;

[Severity: High]
The moved copy of udp_rcv() doesn't match the one being removed from
net/ipv4/udp.c. Was this copied from a tree older than commit
efbc1aa8ed54 ("udp: Support gro_ipv4_max_size > 65536")?

The removed version has:

	unsigned int ulen;
	...
	ulen = udp_get_len(skb, uh, 0);

The new version has:

	unsigned short ulen;
	...
	ulen = ntohs(uh->len);

Those are the two lines efbc1aa8ed54 replaced.

The GRO completion side still relies on the newer rule. Both
udp_gro_complete() and the fraglist branch of udp4_gro_complete() call
udp_set_len(), which writes a zero length for large aggregates:

include/linux/udp.h:udp_set_len() {
	uh->len = len < GRO_LEGACY_MAX_SIZE ? htons(len) : 0;
}

udp_get_len() is the helper that reads this marker back:

include/linux/udp.h:udp_get_len() {
	if (uh->len)
		return ntohs(uh->len);
	if (skb_is_gso(skb)) /* BIG TCP */
		return skb->len - dataoff;
	return 0;
}

Take gro_ipv4_max_size or gro_max_size set above 65536, with BIG TCP
running over VXLAN or GENEVE. When a 64KB or larger aggregate reaches
udp_rcv(), won't ulen be 0 here? The "ulen < sizeof(*uh)" check would
then send it to short_packet, and the packet would be dropped with
SKB_DROP_REASON_PKT_TOO_SMALL and counted in UDP_MIB_INERRORS.

__udp6_lib_rcv() in net/ipv6/udp.c still uses udp_get_len(), so IPv4
and IPv6 would now read the same header field differently.

Restoring only the udp_get_len() call would not be enough. With
ulen still declared unsigned short, lengths above 65535 would be
truncated. Could both the unsigned int declaration and the
udp_get_len() call be carried over, so this stays a pure code move as
the commit message describes?

> +
> +	if (ulen < skb->len) {
> +		if (pskb_trim_rcsum(skb, ulen))
> +			goto short_packet;
> +
> +		uh = udp_hdr(skb);
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
