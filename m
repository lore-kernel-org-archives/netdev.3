Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692D541459
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080639; cv=none; b=cHEP5hoRBUrEKGIwP3rC43joXSmo4NUMjTOXSah54srfvg2mYyCwWzWFHqs6ETUVeIUX0fstygYN9PV1T7nvSCv2EDPHQLGaQfGIGARwLlfFz77Hb3nNVp3eJCFRrEZcvvJTazfZiDpO/mkfegiHdM3kbH0i81bvjG5pNd+9yE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080639; c=relaxed/simple;
	bh=NIgXoOhxYU4sgtvuZnnQn48ePcg9HlNF9yvJOgFStXE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lYs6pWlmovIpVHA/Fk56eRzgZ505im83SLU3YhXpb5B3U14R3UMiv/sNoc4Ow+syRH5WGWHtNijvumAGxrKRvEsgIjNooDafs9KWiblBNXuG1H4kbeUJeubWUtyAQA3taVVbtYX30qxX3WboA7Abef+C5C46YH3T7UOKOYGXOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZO6DMBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZO6DMBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4791F00893;
	Tue, 22 Sep 2026 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080635;
	bh=IniJ8j342yCe6zE7HBu2n9lcoyu/DUxNcJqPqnvH5ZU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NZO6DMBupH+to3J3PS7rUr+v+GNfP4sA8GtAjDLbBucbT96y9pORrb5yc40tf10TP
	 VUdiq4hgjgtNc5kxbXWjlChm/Y5F96zik0T81oqHNtpuh8k8aRtwaAksVajT2NRlbh
	 H+TgSJaVJCnNFexVzC2CweNUNC/tRRxY5cIL1dvviquW6MHdRx3ViwT7wY+TSTivjl
	 sP+5/kB+ELs3b59Jg9s/KT7Y3FRNkgCRo6p5qsR/MDKyOPJm7PiBFVc8ITJ3M/OksK
	 2enhTH3ZiEyl5ZxxwK++2f9ZtaeALHWrM2/fprHkmoBrHt83zTXeRIf79kvVZfR/HT
	 HI50hLy99xNXw==
Subject: Re: [PATCH net v2] net: skbuff: fix pull-bound underflow in
 skb_checksum_setup_ipv6()
From: netdev-bot+sashiko@kernel.org
To: shlomojune6@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 22 Sep 2026 12:37:14 +0000
Message-ID: <179008063497.2160803.9963353619055078588@kernel.org>
In-Reply-To: <20260919133604.50948-1-shlomojune6@gmail.com>
References: <20260919133604.50948-1-shlomojune6@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net/core/skbuff.c, skb_checksum_setup_ipv6(): replacing
  MAX_IPV6_HDR_LEN with the per-header requested length (max == len) at…
- [Medium] Because the patch lets skb_checksum_setup_ipv6() walk an
  arbitrarily long extension-header chain in a non-linear skb, `off` can…

--

net: skbuff: fix pull-bound underflow in skb_checksum_setup_ipv6()

The patch changes the three IPv6 extension-header call sites in
skb_checksum_setup_ipv6() so that the max argument passed to
skb_maybe_pull_tail() is the requested length instead of
MAX_IPV6_HDR_LEN, which prevents max - skb_headlen(skb) from wrapping
negative.

v1: https://lore.kernel.org/r/20260823142620.126424-1-shlomojune6@gmail.com/

A couple of questions about the behaviour change this introduces.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 609f2c7f4a47..b4edbd06655e 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5977,7 +5977,8 @@ static int skb_checksum_setup_ipv6(struct sk_buff *skb, bool recalculate)
>  			err = skb_maybe_pull_tail(skb,
>  						  off +
>  						  sizeof(struct ipv6_opt_hdr),
> -						  MAX_IPV6_HDR_LEN);
> +						  off +
> +						  sizeof(struct ipv6_opt_hdr));
>  			if (err < 0)
>  				goto out;

[Severity: High]
Does passing max == len here also remove the 256-byte parse bound for
non-linear skbs?

Before the change, on an skb whose linear area is smaller than
MAX_IPV6_HDR_LEN, once off + sizeof(hdr) grew past 256 the helper
clamped max:

net/core/skbuff.c:skb_maybe_pull_tail() {
	if (max > skb->len)
		max = skb->len;

	if (__pskb_pull_tail(skb, max - skb_headlen(skb)) == NULL)
		return -ENOMEM;

	if (skb_headlen(skb) < len)
		return -EPROTO;
}

so skb_headlen(skb) stayed at 256, the len test failed, and the frame
was dropped with -EPROTO after exactly one bounded pull.

With max == len the same frame is now accepted and the walker keeps
pulling instead:

	while (off <= len && !done) {

where len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len),
and off advances by as little as 8 bytes per iteration because
ipv6_optlen(hp) and ipv6_authlen(hp) are derived from the peer-supplied
hp->hdrlen. For a 64 KiB frame built out of ~8000 eight-byte DSTOPTS or
HOPOPTS headers, is that not up to ~8K __pskb_pull_tail() calls per
packet, each walking the frag array, with repeated
pskb_expand_head(skb, 0, eat + 128, GFP_ATOMIC) reallocations growing
the head towards ~64 KiB in softirq context?

The path looks reachable from untrusted input: xen-netback
checksum_setup() -> skb_checksum_setup() -> skb_checksum_setup_ipv6(),
where xenvif_tx_build_gops() builds exactly this shape of skb:

drivers/net/xen-netback/netback.c:xenvif_tx_build_gops() {
	data_len = (txreq.size > XEN_NETBACK_TX_COPY_LEN) ?
		XEN_NETBACK_TX_COPY_LEN : txreq.size;
}

i.e. a 128-byte linear head with the remainder in frags. xen-netfront
handle_incoming_queue() -> checksum_setup() has the same shape with
pull_to capped at RX_COPY_THRESHOLD (256).

Would keeping the bound and rejecting the chain instead fix the
underflow without changing what the parser accepts, for example by
returning -EPROTO when skb_headlen(skb) >= max, or by leaving
max = MAX_IPV6_HDR_LEN and refusing chains that reach beyond it?

Two related comments now disagree with the code. MAX_IPV6_HDR_LEN still
says:

/* This value should be large enough to cover a tagged ethernet header plus
 * an IPv6 header, all options, and a maximal TCP or UDP header.
 */
#define MAX_IPV6_HDR_LEN 256

but after this change the constant only bounds the 40-byte base-header
pull, and no code enforces the "all options" part. Likewise
skb_maybe_pull_tail() still says:

	/* If we need to pullup then pullup to the max, so we
	 * won't need to do it again.
	 */

which no longer holds for these three callers, since each iteration
pulls only the next header.

The v2 changelog says the change keeps "the helper's fast path
untouched", and the patch carries a Fixes: tag so it is stable
material. Could the changelog spell out that extension-header chains
longer than 256 bytes in paged data change from dropped to accepted?

> @@ -5992,7 +5993,8 @@ static int skb_checksum_setup_ipv6(struct sk_buff *skb, bool recalculate)
>  			err = skb_maybe_pull_tail(skb,
>  						  off +
>  						  sizeof(struct ip_auth_hdr),
> -						  MAX_IPV6_HDR_LEN);
> +						  off +
> +						  sizeof(struct ip_auth_hdr));
>  			if (err < 0)
>  				goto out;
> 
> @@ -6007,7 +6009,8 @@ static int skb_checksum_setup_ipv6(struct sk_buff *skb, bool recalculate)
>  			err = skb_maybe_pull_tail(skb,
>  						  off +
>  						  sizeof(struct frag_hdr),
> -						  MAX_IPV6_HDR_LEN);
> +						  off +
> +						  sizeof(struct frag_hdr));
>  			if (err < 0)
>  				goto out;

[Severity: Medium]
Since the walk is no longer capped at 256 bytes, can off now exceed
65535 before the transport header is reached, and get truncated on the
way into skb_partial_csum_set()?

skb_checksum_setup_ip() keeps off as unsigned int:

net/core/skbuff.c:skb_checksum_setup_ip() {
	case IPPROTO_TCP:
		err = skb_maybe_pull_tail(skb, off + sizeof(struct tcphdr),
					  off + MAX_TCP_HDR_LEN);
		if (!err && !skb_partial_csum_set(skb, off,
						  offsetof(struct tcphdr,
							   check)))
			err = -EPROTO;
}

but the callee takes u16:

net/core/skbuff.c:skb_partial_csum_set() {
bool skb_partial_csum_set(struct sk_buff *skb, u16 start, u16 off)
{
	u32 csum_end = (u32)start + (u32)off + sizeof(__sum16);
	u32 csum_start = skb_headroom(skb) + (u32)start;

	if (unlikely(csum_start >= U16_MAX || csum_end > skb_headlen(skb))) {
}

With off == 65536 the argument arrives as start == 0, the range check
cannot see the original value, and skb->csum_start and
skb->transport_header end up pointing at the IPv6 header. With
recalculate == true the caller then writes through
&tcp_hdr(skb)->check, i.e. two bytes at network_header + 16, over the
IPv6 source address; with recalculate == false the skb goes up the
stack with CHECKSUM_PARTIAL metadata describing the IP header as the
transport header.

Reaching off >= 65536 also requires the pull in skb_checksum_setup_ip()
to succeed, so skb->len must be at least off + 20. That looks possible
on the netfront RX side, where xennet_get_responses() allows up to
XEN_NETIF_NR_SLOTS_MIN slots:

drivers/net/xen-netfront.c:xennet_get_responses() {
	int max = XEN_NETIF_NR_SLOTS_MIN + (rx->status <= RX_COPY_THRESHOLD);
}

and xennet_fill_frags() allows up to MAX_SKB_FRAGS frags, giving an
skb->len around 69632. On the xen-netback side the guest cannot get
there because xen_netif_tx_request.size is u16 and
xenvif_count_requests() rejects totals above 65535. Pre-patch this was
unreachable from either driver because MAX_IPV6_HDR_LEN stopped the
walk at 256. Should skb_checksum_setup_ip() reject off > U16_MAX
explicitly?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919133604.50948-1-shlomojune6%40gmail.com
