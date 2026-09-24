Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A38415F1D;
	Thu, 24 Sep 2026 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269661; cv=none; b=MV7Q+GyOEdv7hrFTrGsM1HjNBzk4nlcRp+/1zWq/7NAGaVxr70il4ew7zCsMjx4Sgwi4NQ+6NUgkMNCSCA0R2B+lRlPJZH53oVW9+lgvVQ/T34RmGzJR2Yt9ye/zkCIeMbLlburHTARYKhUHznUJ1HntUvoQc0st/H42ebaPBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269661; c=relaxed/simple;
	bh=SitQVtJ1g4pGBdUuBJNm2LsS3TeaevnP7g1eanItFMM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D27Tn4HEjlEd74TMIioTa3FvbPoxq1CgoU9oJhH6JPG9XxZKzHyFVOwWjPGc+tnKix3/wlmZdSxgTPEbqhqZ3gH2XTeAcdNJliXBG055lgEfo1RtZoL7m2jQeqQnmwrha4soQCuqRnCFEx73mOaEgPMApv3grMCReRViW0xShBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKw5y/DD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKw5y/DD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4D91F000FF;
	Thu, 24 Sep 2026 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269659;
	bh=23jCwliSLgDWUpj07uqzPZsXMJSjw8cFPl8SI56hWCI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QKw5y/DDwWX+MqPCpRAUnDRPRcCiT1DDX+CcWK/J55Obwx7vAXMH0bEflAc3IxDCj
	 NJbdcEapteNKOtMV8ka3ZUKPgJZp0lolnyr+otzUMLyWHwqub26DPJyiZOb6kSrHXJ
	 chTxBK0HjkSzhh4+t6Gaf4mOewvzRYnDoXhfR5aCFMzD4TSHJyWsuPiHVOLnCyD2q5
	 ZQ9dw2eoQTL+ajIs1VVcNe1+5mla7azUsW/LxlZocEuUzqXf9Nr3VPvws7JkvUXxTo
	 1txjeDOiG+YkHZZv/EAQMUf3BCfxlpYPlW5N74x179qe/m7FW1Vq6twbChqpR1GZoD
	 WFA9621iOpJ1A==
Subject: Re: [PATCH net 07/12] net: systemport: Fix potential packet length
 underflow in bcm_sysport_desc_rx()
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Thu, 24 Sep 2026 17:07:38 +0000
Message-ID: <179026965854.2160803.5665629776493855745@kernel.org>
In-Reply-To: <20260921231305.394773-8-florian.fainelli@broadcom.com>
References: <20260921231305.394773-8-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message mischaracterizes the failure mode it claims
  to fix.
- [Medium] The new minimum-length test in bcm_sysport_desc_rx()
  (drivers/net/ethernet/broadcom/bcmsysport.c:784-785) only requires…

--

net: systemport: Fix potential packet length underflow in bcm_sysport_desc_rx()

The patch adds a lower bound to the RSB-reported packet length check in
bcm_sysport_desc_rx(), requiring len to be at least sizeof(*rsb) + 2,
plus ETH_FCS_LEN when CRC forwarding is enabled. Frames failing the new
check are counted as length errors and dropped.

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index b69833d34bd5b..95cead1df1607 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -781,8 +781,9 @@ static unsigned int bcm_sysport_desc_rx(struct bcm_sysport_priv *priv,
>  			  p_index, priv->rx_c_index, priv->rx_read_ptr,
>  			  len, status);
>  
> -		if (unlikely(len > RX_BUF_LENGTH)) {
> -			netif_err(priv, rx_status, ndev, "oversized packet\n");
> +		if (unlikely(len > RX_BUF_LENGTH ||
> +			     len < sizeof(*rsb) + 2 + (priv->crc_fwd ? ETH_FCS_LEN : 0))) {

[Severity: Medium]
Should this lower bound also reserve room for the Ethernet header that the
same function consumes a few lines later?

With crc_fwd clear, any len in the range 10..23 passes the new test. The
code that follows then does:

drivers/net/ethernet/broadcom/bcmsysport.c:bcm_sysport_desc_rx() {
	...
	skb_put(skb, len);
	...
	skb_pull(skb, sizeof(*rsb) + 2);
	len -= (sizeof(*rsb) + 2);
	processed_bytes += len;

	/* UniMAC may forward CRC */
	if (priv->crc_fwd) {
		skb_trim(skb, len - ETH_FCS_LEN);
		len -= ETH_FCS_LEN;
	}

	skb->protocol = eth_type_trans(skb, ndev);
	...
}

For len == 12 the skb reaching eth_type_trans() has skb->len == 2. With
crc_fwd set and len == 14, skb_trim(skb, 0) leaves a zero-length skb.

In that case eth_type_trans() reads the MAC header without checking that
ETH_HLEN bytes are present:

net/ethernet/eth.c:eth_type_trans() {
	...
	eth = eth_skb_pull_mac(skb);
	eth_skb_pkt_type(skb, dev);
	...
}

include/linux/etherdevice.h:eth_skb_pull_mac() {
	struct ethhdr *eth = (struct ethhdr *)skb->data;

	skb_pull_inline(skb, ETH_HLEN);
	return eth;
}

skb_pull_inline() returns NULL for skb->len < ETH_HLEN and leaves
skb->data untouched, but the return value is discarded, so eth->h_dest
and eth->h_proto are read past skb->len. Those bytes are inside the
2048-byte RX_BUF_LENGTH allocation from __netdev_alloc_skb() in
bcm_sysport_rx_refill(), which is not zeroed and which DMA only filled
with len bytes.

Can this make skb->pkt_type and skb->protocol derive from stale buffer
contents, and leak the 2-byte protocol value to userspace as sll_protocol
for AF_PACKET SOCK_RAW readers in packet_recvmsg()?

The MAC header is also never stripped in this case, yet the frame is
counted in ndev->stats.rx_packets/rx_bytes and stats64 as a good
reception and handed to napi_gro_receive() with mac/network offsets that
upper layers will parse at the wrong offset.

Would sizeof(*rsb) + 2 + ETH_HLEN (or an ETH_ZLEN based bound), plus
ETH_FCS_LEN when crc_fwd is set, be the bound that actually covers the
parsing done in this function? The same incomplete pattern exists in
bcmgenet (len < GENET_RSB_PAD), so this may be intentional copy-over, but
nothing here establishes that sub-ETH_HLEN lengths cannot be reported.

> +			netif_err(priv, rx_status, ndev, "invalid packet size: %d\n", len);
>  			ndev->stats.rx_length_errors++;
>  			ndev->stats.rx_errors++;
>  			dev_kfree_skb_any(skb);

[Severity: Medium]
Is the failure mode described in the commit message accurate? The message
says:

    calling skb_pull() will trigger a BUG() in __skb_pull() when pulling
    beyond skb->len

skb_pull() in net/core/skbuff.c is a wrapper around skb_pull_inline():

include/linux/skbuff.h:skb_pull_inline() {
	return unlikely(len > skb->len) ? NULL : __skb_pull(skb, len);
}

So an over-long pull returns NULL without touching the skb and never
reaches __skb_pull(). The BUG() inside __skb_pull() is conditional:

include/linux/skbuff.h:__skb_pull() {
	skb->len -= len;
	if (unlikely(skb->len < skb->data_len)) {
		...
		BUG();
	}
	...
}

These RX skbs come from __netdev_alloc_skb(RX_BUF_LENGTH) in
bcm_sysport_rx_refill() and are purely linear, so skb->data_len is 0 and
that condition is unreachable.

The message also mentions "potential out-of-bounds operations". The
reachable pre-patch effects look like the u16 wrap in

	len -= (sizeof(*rsb) + 2);

which corrupts ndev->stats.rx_bytes, stats64->rx_bytes and
priv->dim.bytes (the latter feeding the DIM coalescing logic), plus an
skb passed to eth_type_trans()/napi_gro_receive() with the Receive Status
Block and 2 pad bytes still present because the ignored skb_pull() return
meant nothing was stripped.

Since this carries a Fixes: tag and will be considered for stable, could
the changelog describe the stat corruption and unstripped RSB instead of
a BUG() and out-of-bounds accesses?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921231305.394773-1-florian.fainelli%40broadcom.com
