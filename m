Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CEF4E80C1;
	Mon, 19 Oct 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415834; cv=none; b=ELsY/VzfReV7cpszYr4ZNny8J3dw7Y+wdoPOwVYqUF/Y1NLv6oxqcv/oMJlhSZu6fzFDaHTz9iT8l06fE3IjTBZSg/JO97uQtq5xXGCVUmrmJx8vYCv0BT5aHUxuU4P7+mHfdejQQn3oFieaP8grlwO2M5ondT/aWnWwXV7fKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415834; c=relaxed/simple;
	bh=tvNocZvs3q0zbhmES0iDoNjJBJVp+S0P4aU8tlbUkho=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TPu9oshVZBqVZr1jDoQOL5sTJJ7kVxlXvZS5Ai/F0UevvGBeuffT3MIFyHdB6U61/EgyNDPjm+2PrTzbrgUkMfaMF3pb+KEriyg50Z7Yl+SHEdqMgfvi7EPruX1g86ODfqvr1tVRIHQZKTVclZrmc6yb2daILWYJAclS40/lHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIGbfaqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIGbfaqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2C31F000C4;
	Mon, 19 Oct 2026 13:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415832;
	bh=HJM8MsI0/kWBMtdbFL7xjbegM4ZYe3v7LeQ5DuOUkjE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fIGbfaqI5SWhefTH8f8yNfkrfWQjaeJwI4gpcNnn1ImA0Uu2b7/MSUu4FG3bEy+1/
	 7/qbTF2su6lPFg+koOWkOEPf4to3odEXEwrLLlE8yvM6Kp1P6ViiT6pIPHKt7tXd3k
	 8fs8Ei/wMqDwCcaChamuyfxfOT51X6P3A/W+RS2K1IYhlgqfvg3hLeQWG3mlziyVCw
	 RBNFFLdBF9NILWmbwYBePf34llKV3lUbEHb/R81nGmpSWDJz/yrkvGSf/bBOp4+K9/
	 Z+1ODmUlaIfsz+07DpJRPYyhS5lkyTMp+ot5g7vs7Rq6JmeleCycomQeIJNlwMllg8
	 1vZ4JCDqMRcVA==
Subject: Re: [PATCH net v3 4/4] ipmr: do not drop GSO packets that fit the MTU
 after segmentation
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, steffen.klassert@secunet.com, willemb@google.com,
 jiayuan.chen@linux.dev, mfleming@cloudflare.com, almasrymina@google.com,
 bigeasy@linutronix.de, richardbgobert@gmail.com, ecree.xilinx@gmail.com,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 13:17:10 +0000
Message-ID: <179241583068.3135.17027966387414517090@kernel.org>
In-Reply-To: =?utf-8?q?=3Cba6744246a54f77d4ff5acd72a0f1a1ee695bdad=2E1792327?=
 =?utf-8?q?155=2Egit=2Ejulius=40bairaktaris=2Ede=3E?=
References: =?utf-8?q?=3Cba6744246a54f77d4ff5acd72a0f1a1ee695bdad=2E17923271?=
 =?utf-8?q?55=2Egit=2Ejulius=40bairaktaris=2Ede=3E?=
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new GSO exemption in ipmr_prepare_xmit()
  (net/ipv4/ipmr.c:1952-1953) trusts skb_gso_validate_network_len() to…

--

ipmr: do not drop GSO packets that fit the MTU after segmentation

This patch changes ipmr_prepare_xmit() so that DF-marked GSO packets
longer than the route MTU are no longer dropped when
skb_gso_validate_network_len() says the segments will fit. This matches
what ip_forward() already does. On tunnel vifs it leaves room for the
outer header.

> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 6f2eb571f30f7..0a2c573ceeb79 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c

[ ... ]

> @@ -1946,7 +1947,10 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
>  			return -1;
>  	}
>  
> -	if (skb->len+encap > dst4_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
> +	mtu = dst4_mtu(&rt->dst);
> +	if (skb->len + encap > mtu && (ntohs(iph->frag_off) & IP_DF) &&
> +	    !(skb_is_gso(skb) && mtu > encap &&
> +	      skb_gso_validate_network_len(skb, mtu - encap))) {

[Severity: Medium]
Can this exemption let oversized DF segments out of ipmr for encapsulated
UDP-in-UDP aggregates?

skb_gso_validate_network_len() gets the segment length from
skb_gso_transport_seglen(). The encapsulated branch of that helper only
adds an inner L4 header length for TCP:

net/core/gso.c:skb_gso_transport_seglen() {
    ...
	if (skb->encapsulation) {
		thlen = skb_inner_transport_header(skb) -
			skb_transport_header(skb);

		if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
			thlen += inner_tcp_hdrlen(skb);
	} else if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
		thlen = tcp_hdrlen(skb);
	} else if (unlikely(skb_is_gso_sctp(skb))) {
		thlen = sizeof(struct sctphdr);
	} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
		thlen = sizeof(struct udphdr);
	}
    ...
}

If the inner aggregate is SKB_GSO_UDP_L4, gso_size does not include the
8-byte inner UDP header. Nothing adds it back, so each segment is
counted 8 bytes too short.

Receive-side GRO builds aggregates like this when a local tunnel socket
exists, for example a VXLAN device bound to the port.
udp_gro_complete() sets skb->encapsulation = 1. The inner
udp_gro_complete_segment() then sets inner_transport_header and
SKB_GSO_UDP_L4.

Here is an example: outer IPv4 (20) + UDP (8) + VXLAN (8) + inner
Ethernet (14) + inner IPv4 (20) + inner UDP (8) + 1424 bytes of payload.
Each real segment is 1502 bytes, but the helper reports 1494.

Say the multicast route sends such a DF aggregate to a non-tunnel vif
with MTU 1500, and the ingress MTU is at least 1502. The old check
dropped it. The new check lets it through.

Later, ip_finish_output_gso() calls the same helper:

net/ipv4/ip_output.c:ip_finish_output_gso() {
    ...
	if (skb_gso_validate_network_len(skb, mtu))
		return ip_finish_output2(net, sk, skb);
    ...
}

So it takes the fast path, and 1502-byte DF segments go out on a
1500-MTU link.

The undercount in skb_gso_transport_seglen() is older than this patch.
It also affects ip_exceeds_mtu() on the unicast forwarding path. This
patch is the first to make the multicast MTU decision depend on the
helper.

Should the inner UDP header length be accounted for in the
skb->encapsulation branch of skb_gso_transport_seglen()?

>  		/* Do not fragment multicasts. Alas, IPv4 does not
>  		 * allow to send ICMP, so that packets will disappear
>  		 * to blackhole.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792293419.git.julius%40bairaktaris.de
