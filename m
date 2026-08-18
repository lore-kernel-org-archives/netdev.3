Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45137BE6B;
	Tue, 18 Aug 2026 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787016169; cv=none; b=NytHKjpAPpuh8NSV1GtCuct8vbMWUhga4gjGUSc3SRRHanPUYbiEC3IqgPBWS+Mu4F50qFpClw2X+SVVYPjLQt2e7HBj8GO3LQYXcUbXPrkyoTqvFDHx5L7OTLPDyjVMIyrgBOv0Llv0MQ4s1o45bKacR3Q4JlAN5ug10qWeQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787016169; c=relaxed/simple;
	bh=lronJesHfSFBMDjBHtBjvEkezi/iNndM/iCAdmGKIR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NB0cuKJZxKRWNFtIMPWKnZPY8GkEQWcLLCP5/gBUctuJJ8u6mP+JGsOvWWim8oZMNyQVPr+077PXcixciiJ9bPIfDH+HmHjuwTIg574BPmL40x1BmejX69MDawY5t9JbtPVBpMwwqkdqSX9qgVjYm/V5gYUL2Eos5E+37O3Yi4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep4N8HNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep4N8HNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2D51F000E9;
	Tue, 18 Aug 2026 01:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787016154;
	bh=/pUf4UguUZ3PrCyGaWpk3YN1u32lpacWG/svSkNXjuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ep4N8HNGX0IulE1edNrTiyQPY+wl0f73rm4kFGNm8AsLynlQgprSN+T/+rEX6Hb3C
	 gOeTY0Vyb+xDiAn2jlyfzpLqFJIEtMUtfNxLLF18WK7dlkuhXS5GnkN55OAZDNAF5U
	 1ozrWEnF2lTPLcUDD7rA3edkIZzsWRYoYwbtX5kzQZKbfByiFTv582Yz2uviMptD3A
	 X7FCm5VCrdRzTX8DmzFlXuPXUxLkmAL/Cc43hhh+T4RSejy+Nvl1up2DoQQqp7o6UU
	 Ai2yODCnZR2x02Q+pnYh9dMrttoRj+Lc3qHb20FvWLwvYWsCfp2d5pFtYUqXV3jaBt
	 1ZRGAr5/cYtfA==
From: Jakub Kicinski <kuba@kernel.org>
To: PKneuper@dspace.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	0x1207@gmail.com,
	si.yanteng@linux.dev,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	DBaldin@dspace.de
Subject: Re: [PATCH net] net: stmmac: restore NET_IP_ALIGN in the non-XDP RX path
Date: Mon, 17 Aug 2026 18:22:17 -0700
Message-ID: <20260818012216.3825070-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813092923.284285-1-PKneuper@dspace.de>
References: <20260813092923.284285-1-PKneuper@dspace.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: stmmac: restore NET_IP_ALIGN in the non-XDP RX path

This adds NET_IP_ALIGN back to the RX DMA offset returned by
stmmac_rx_offset() for the non-XDP case, so that the page pool page handed
to the stack as the skb head places the IP header at a 4-byte aligned
address again. Without it, ARM32 takes an alignment exception in
icmp_echo() for any received echo request.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a71f0df263785..2a57415be25cf 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1529,7 +1529,7 @@ static unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
>  	if (stmmac_xdp_is_enabled(priv))
>  		return XDP_PACKET_HEADROOM;
>  
> -	return NET_SKB_PAD;
> +	return NET_SKB_PAD + NET_IP_ALIGN;
>  }

[Severity: High]
Should the XDP branch of stmmac_rx_offset() get the same treatment?

When an XDP program is attached, stmmac_rx_offset() returns bare
XDP_PACKET_HEADROOM (256) with no NET_IP_ALIGN, and an XDP_PASS packet goes
to the stack through exactly the code this patch is fixing, in stmmac_rx():

	skb = napi_build_skb(page_address(buf->page),
			     rx_q->napi_skb_frag_size);
	...
	/* XDP program may adjust header */
	head_pad_len = ctx.xdp.data - ctx.xdp.data_hard_start;
	skb_reserve(skb, head_pad_len);
	skb_put(skb, buf1_len);

For a program that returns XDP_PASS without touching the head, head_pad_len
is 256, so the Ethernet header starts at 256, the IP header at 270 and the
ICMP or TCP header at 290:

	290 % 4 == 2

which is the same 2 mod 4 misalignment class as the 98 in the reported
crash, so the icmp_echo() panic quoted in the commit message looks
reproducible on the same board by attaching an XDP_PASS program.

The 2021 commit a955318fe67e ("stmmac: align RX buffers") cited in the
commit message changed both returns (XDP_PACKET_HEADROOM + NET_IP_ALIGN as
well); here only one return changes, leaving the two branches of the same
helper with different alignment guarantees.

Page pool sizing is derived from stmmac_rx_offset() for both branches in
__alloc_dma_rx_desc_resources():

	dma_buf_sz_pad = stmmac_rx_offset(priv) + dma_conf->dma_buf_sz +
			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
	num_pages = DIV_ROUND_UP(dma_buf_sz_pad, PAGE_SIZE);

so wouldn't the extra two bytes be accounted for in the XDP case too?

If the intent is to fix only the non-XDP configuration, could the commit
message say so explicitly, since stable backporters and anyone running XDP
on ARM32 would still hit the panic?

Cross-instance finding from sashiko-gemini (bb586704729c8cac27b6f004c29082ebde7dad94593b943d82d5139137628cdb):
[Severity: Critical]
Hardware DMA address truncation and silent packet corruption due to unaligned RX offset.
-- 
pw-bot: cr
