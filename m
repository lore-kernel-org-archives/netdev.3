Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D63D1716;
	Thu, 24 Sep 2026 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216488; cv=none; b=X4whqu43c1SitE1Z5M1M77sOi1NrxtuWhfKWEj9ykLk5Xk1QW42jompOlT1gAv/AKpOPi04DKTIRNpyk+wfRtf5NJja/JZAh8ISMSK7loFs/QtslRYEU345o+FU17LerhGgKOuW8o9xgb/BJtY2F+WbXQp+yZ3omnLqSmHV0dCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216488; c=relaxed/simple;
	bh=SgSCkGPY2sbxbY+Pl7AK1cAPnmcrxZr7VydXIx0I1WU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QSpAxO4iik3wkLxPgkjdokRQWKCrsReE9SkLhPnERmcetb0iag6JIQ+QBbT2oYp9RFyzBlQSgHINmGo1ybgnQtujVSqUtDf6QdaXaGU3inAsHjRMwddkSckHd5fm201L31MbZc+3t6X7a0YqOT28Nxzmdfdw8WsDvjZzoel1gmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz9bbl+9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz9bbl+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED171F00898;
	Thu, 24 Sep 2026 02:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216487;
	bh=JyIRzNYQcnTjoAdUOnWAU1E7WOm0VWPMQK+qbBONPXQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gz9bbl+9/BkeAmfaqXAgWB3vh2djgZrKnT/cBUuUCcjVtS6uQuQmgdie5afgq+l9W
	 ikqMNiIDHyUp2HFHf4idacEVQWegUBEud6vGAJKMjbd52TWTQE/9kMC3D3yEFkrHSb
	 VMAo5yhjiBIUccrlmuG+MN8WdauJ915REfy8X/xIeucZcltRtbZNTBez7K+Vms7PvU
	 SUS8kQBZ8CNtvxeQm7wsxBSzIXCLl7NrORZUYxa7YnwZJKY9U+r5eVG2P9UF32nmbl
	 EuZbgwMiKuV6WpK7lAaGSOhfEHAiHYdq81MbaZl5KC67yr08b5DkhlW8lrzunK/f8R
	 lcZDepc8IPsqw==
Subject: Re: [PATCH net v2 06/10] net: systemport: Fix potential packet length
 underflow in bcm_sysport_desc_rx()
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, nb@tipi-net.de, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 02:21:26 +0000
Message-ID: <179021648603.2160803.17242302637851024692@kernel.org>
In-Reply-To: <20260922232440.598918-7-florian.fainelli@broadcom.com>
References: <20260922232440.598918-7-florian.fainelli@broadcom.com>
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

- [Medium] The new minimum length in bcm_sysport_desc_rx() does not
  include ETH_HLEN.
- [Low] The commit message for "net: systemport: Fix potential packet
  length underflow in bcm_sysport_desc_rx()" has an unfinished sentence,…

--

net: systemport: Fix potential packet length underflow in bcm_sysport_desc_rx()

This patch adds a lower bound check to bcm_sysport_desc_rx() for the
length reported in the RSB. The length must now cover the Receive Status
Block, the 2 byte pad and, when CRC forwarding is enabled, the FCS.
Shorter frames are dropped and counted as rx_length_errors.

> In bcm_sysport_desc_rx(), the packet length 'len' extracted from the RSB
> is only validated against RX_BUF_LENGTH. If a malformed or corrupted
> frame is received with 'len' smaller than the prepended Receive Status
> Block (sizeof(*rsb)) plus 2 padding bytes (and optional FCS).

[Severity: Low]
This isn't a bug, but the second sentence here is unfinished. It doesn't
say what happens in that case.

Is "a malformed or corrupted frame is received" accurate? rbuf_init()
always enables the RSB and 4 byte alignment:

rbuf_init() {
    ...
	reg |= RBUF_4B_ALGN | RBUF_RSB_EN;
    ...
}

So every length the MAC reports already includes the 8 byte RSB and the
2 pad bytes. The driver also never sets CMD_RUNT_FILTER_DIS, so the
UniMAC runt filter stays on.

It looks like this can only happen if the hardware misreports the length,
not because of a frame on the wire.

> Furthermore, subtracting (sizeof(*rsb) + 2) from 'len' (u16) will
> underflow, resulting in corrupted packet stats and potential
> out-of-bounds operations.

Does "potential out-of-bounds operations" overstate the impact before this
patch? When len < 10, skb_pull() goes through skb_pull_inline():

	return unlikely(len > skb->len) ? NULL : __skb_pull(skb, len);

so skb->data doesn't move.

The u16 len then wraps to 65526 or more. That inflates processed_bytes,
priv->dim.bytes, ndev->stats.rx_bytes and stats64->rx_bytes.

skb_trim() does nothing. eth_type_trans() reads the RSB as the Ethernet
header, past skb->tail but still inside the 2048 byte RX buffer. Nothing
seems to write out of bounds.

Could the message describe this as a guard against the hardware
misreporting the length? It could also list the actual consequences:
corrupted byte counters and a garbage runt skb passed up the stack.

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 9c1b515dc8cc9..ed4337af58da1 100644
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
Should this lower bound also include ETH_HLEN? As written, a reported len
of 10 to 23 (or 14 to 27 with crc_fwd) passes the check. The rest of
bcm_sysport_desc_rx() then does this:

		skb_put(skb, len);
		...
		skb_pull(skb, sizeof(*rsb) + 2);
		len -= (sizeof(*rsb) + 2);
		...
		if (priv->crc_fwd) {
			skb_trim(skb, len - ETH_FCS_LEN);
		...
		skb->protocol = eth_type_trans(skb, ndev);

After that, skb->len can be anywhere from 0 to 13.

In the call chain eth_type_trans()->eth_skb_pull_mac(), the result of the
pull is ignored:

	struct ethhdr *eth = (struct ethhdr *)skb->data;

	skb_pull_inline(skb, ETH_HLEN);
	return eth;

skb_pull_inline() refuses to pull 14 bytes from the shorter skb, but the
header pointer is still returned. eth_skb_pkt_type() then reads
eth->h_dest, and eth_type_trans() reads eth->h_proto. Both reads are past
skb->tail, in bytes of the RX_BUF_LENGTH buffer that the device didn't
write for this transfer.

Can this set skb->protocol and skb->pkt_type from stale memory? AF_PACKET
listeners see those values as sll_protocol and sll_pkttype.

The runt skb is also counted in rx_packets and rx_bytes and handed to
napi_gro_receive(). Its skb->len is below ETH_HLEN, and skb->data was
never moved past the MAC header.

This is the same kind of hardware misreport the patch guards against. The
eth_type_trans() read past the data is also the only out-of-bounds
operation on this path that the commit message could be referring to.
Would a bound like this close the gap?

	len < sizeof(*rsb) + 2 + ETH_HLEN + (priv->crc_fwd ? ETH_FCS_LEN : 0)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922232440.598918-1-florian.fainelli%40broadcom.com
