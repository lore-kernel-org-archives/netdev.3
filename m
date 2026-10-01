Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B734E4C5A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846966; cv=none; b=I70PMC3BVMZ7/UOhKuddRud4SVdTic/7kjmDoZp4NnvN91RuCPkaCwQngp2IK9b4/PCqUQPYBd3M6z1GlhIUhPBhgb9UZiEOt5iO7DIHhMnD7Ba1gYevugpITTr9BgnLacGMe6LP+CnOucFEI/4c4eJ9ZPX3jnfLC8E96uK6rKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846966; c=relaxed/simple;
	bh=iqYjHIf0lQV9/M9/QkxDY8xuDEdLI6/dX0EQGI4MqcU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJMzOvZQphxHoYYQHw0P2FOh5p9FFsYFRnbpNlV8Tn5zGODIVmJ/91fGsmRCIEHPtCEPPmyVVP9QGuUszXw/bT1UvPCVgARdW9RO/A8ZRZ3TxyCvgwg5HTt7O9y4UkRn8K1q36DRE9rSSUockhla9U3B0W+sy2Npd2e4Owc7fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfn0RCFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfn0RCFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF8B1F000FF;
	Thu,  1 Oct 2026 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846963;
	bh=aCsmBD7o1EvtojJvdgGh4srWvH/CvU/lHcfjKry8z1g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sfn0RCFpwxXIpEVOxuLX38JWo97flNdlo8dPU4PjiuWRQxu1SR6OIEvYOVqSQK1JV
	 pclXURDor7ng4pMxaE/JFc8JArnaBk1RUcRbNMXH+PRO8i8G+gaEbi0vcpLUMWKy46
	 QHXF609HeNhVT+mXY8pwdaFlU55CE5r6dap47uU3QFcVrJasKjB9FUD719SZg5tOGa
	 xua+vbu8xf8LcoP+UdvH2TbrlUVBSr+f30vSzsvrKakxYXDcV/V+3FHUtzXnMXQAlN
	 jKr2elwlR4S7MdT2mSSN6T+a7YehgCYqaqFuRDFPpUCL3LaMu56k1kuNsPTWrebxIA
	 qFWEzBrQ3t3Tg==
Subject: Re: [PATCH net-next] ipv4: use zero IPID for atomic datagrams on
 connected sockets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
 idosch@nvidia.com, edumazet@google.com, netdev@vger.kernel.org
Date: Thu, 01 Oct 2026 09:29:22 +0000
Message-ID: <179084696215.434549.12886942915829094069@kernel.org>
In-Reply-To: <20260929153834.566551-1-edumazet@kernel.org>
References: <20260929153834.566551-1-edumazet@kernel.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] TCP TSO/GSO skbs now carry IPv4 IDs that restart at 0 on every
  skb.
- [Low] The kernel-doc for struct inet_sock (include/net/inet_sock.h)
  still says `@inet_id - ID counter for DF pkts`.

--

ipv4: use zero IPID for atomic datagrams on connected sockets

This patch moves the DF && !ignore_df check in ip_select_ident_segs()
ahead of the per-socket private generator. On connected sockets, atomic
datagrams now get an IP ID of zero, and inet_id is used only for non-DF
packets or packets with skb->ignore_df set. The stated goal is to avoid
an atomic operation on a shared cache line and to keep TCP from touching
inet->inet_id in the fast path.

> diff --git a/include/net/ip.h b/include/net/ip.h
> index 6f602df72ee62..ffa4ba0b571fc 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -584,6 +584,13 @@ static inline void ip_select_ident_segs(struct net *net, struct sk_buff *skb,
>  {
>  	struct iphdr *iph = ip_hdr(skb);
>  
> +	/* RFC 6864: the IPv4 ID of atomic datagrams has no meaning.
> +	 * DF packets without ignore_df can not be fragmented.
> +	 */
> +	if ((iph->frag_off & htons(IP_DF)) && !skb->ignore_df) {
> +		iph->id = 0;
> +		return;
> +	}

[Severity: Medium]
Does this also change the IDs of TCP TSO/GSO skbs, not only single
atomic datagrams?

__ip_queue_xmit() still passes the segment count:

	ip_select_ident_segs(net, skb, sk,
			     skb_shinfo(skb)->gso_segs ?: 1);

The new early return ignores segs. The template ID is now 0, and inet_id
is no longer advanced by segs.

TCP never sets SKB_GSO_TCP_FIXEDID, so inet_gso_segment() in
net/ipv4/af_inet.c takes the !fixedid path:

		} else {
			if (!fixedid)
				iph->id = htons(id++);

TSO hardware behaves the same way. From
Documentation/networking/segmentation-offloads.rst:

  "The default behavior is to increment the IP ID with every segment."

So each TSO skb goes out with IDs 0, 1, ..., n-1, and the next skb of
the flow starts again at 0. Before this patch, the IDs continued across
skbs.

On a Linux receiver, tcp_gro_receive()->gro_receive_network_flush()->
inet_gro_flush() checks ID continuity:

	if (count == 1 && !ipid_offset)
		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;

	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));

At each sender skb boundary, the arriving segment has ID 0, the same as
the held head. So ipid_offset is 0 while count is not, and the flow gets
flushed.

Does this mean receiver GRO can no longer merge across sender TSO skbs?

It can get worse when a single-MSS skb (ID 0) is followed by a TSO skb
(IDs 0, 1, ...). On the second frame, count == 1 and ipid_offset == 0,
so the chain switches to fixed-ID mode. The next incrementing ID then
flushes it again.

How much this hurts probably depends on how the receiver's gro_max_size
compares with the sender's TSO skb size. BIG TCP receivers, small
cwnd-limited TSO bursts, and mixes of single-MSS and TSO skbs look the
most exposed. Connected UDP GSO already lost ID continuity before this
patch, because __ip_make_skb() uses ip_select_ident() with segs=1. The
new behaviour change is on the TCP path.

The commit message says DF packets on connected sockets get their IPID
set to zero, and the new comment says the ID "has no meaning". Neither
holds for multi-segment skbs. The "Minor side effects" paragraph also
does not mention the GRO impact.

Was this trade-off intended, and should the changelog mention it?

[Severity: Low]
This isn't a bug, but the kernel-doc for struct inet_sock in
include/net/inet_sock.h still says:

 * @inet_id - ID counter for DF pkts

After this change, inet_id is used only for non-DF packets and for DF
packets with skb->ignore_df set, which is the reverse of what the
comment says.

Could that comment be updated as well?

tcp_v4_connect() and tcp_v4_syn_recv_sock() still seed inet_id with
get_random_u16(). Non-DF TCP (for example IP_PMTUDISC_DONT) still needs
that, so only the comment is out of date.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929153834.566551-1-edumazet%40kernel.org
