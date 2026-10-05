Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F404BEE5D;
	Mon,  5 Oct 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212688; cv=none; b=Mrk6lJa9+saYW6Cfr8cY6JlKcUKAI1fHe3pccL7Qwb2yiegJyaTEt7F3aGBfxH8XP/dW/mnHUNgjbLOKPJgsK88pA9jlApp3dyaL0sbtcY3TfeyiyXKRIf0AfIsBs1zpdXj3/5nkKWUdFAMYHQ8lSTnyfqsbc15PCPOeByVB89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212688; c=relaxed/simple;
	bh=a+tWMfDQxhuiVL5zX+mLPOHNtoUHMgNR2awxwgBfbh4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/+LMED19V2qBAHdjkjep2tbx8s5J4VruT472GjfM2wnqhx0CRBcKDuOBdzDhSF7Ao4FSmHREJrI5rlo6GmTEvczI4rHBEt0GQG3mZKtfSbL59bVlagJ+geUDfnoAOBEaaOA5L8Zg2MSPJwN5pQihEZ8L/wBImk2LPbrzZ1QZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1dHuR/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1dHuR/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F26E1F00899;
	Mon,  5 Oct 2026 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212687;
	bh=BCzSeUhYqyJpy5J24LGb4/Ecw8TCvKPvZku0q8I6a20=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G1dHuR/TXivaIeOSVhhftpd4Nsf99tYZhW2XN2Bvg7g+fmc3yIxeAQm4XSjQDhcQw
	 EH2qlSo5mps0luS6cUr4JwqampWcetz+U8q/uR5BSQq3RL80mYr7ClwSDKJOhdgtzU
	 EyUZrRdiPA+in8DtxnLSdAk5anf3cHxBV3WtLpUK3m9gzzSHAelUI026gpKbEybcq+
	 1l5KOHzYwZv8elLXpSJo8GbMl2DX9p30qqDGiP+c/tK5DiJc/rha4l8WBaX+kIV1ik
	 HYWFKuoNd7q9Ig71JhcIP0FlH1jfuT47bRZWxtd1hggggcyXnrMDDlLZptEwF4x3/d
	 Sa+xjA9j66U/Q==
Subject: Re: [PATCH net-next 6/7] net: bcmgenet: pad transmit frames out of
 the packet ready window
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com
Date: Mon, 05 Oct 2026 15:04:46 +0000
Message-ID: <179121268616.434549.17024293577065479280@kernel.org>
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-6-96dc6d54cbee@tipi-net.de>
References: <20261002-nb-genet-mtu-nn-v2-v1-6-96dc6d54cbee@tipi-net.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] bcmgenet_xmit() pads every frame whose length falls in
  (tx_thld_len, tx_thld_len + 64) with up to 63 zero bytes via…
- [Medium] (Baseline: resolved later in the series.) At this commit,
  bcmgenet_tx_pkt_rdy_thld() lowers TBUF_PKT_RDY_THLD from 3840 to 3584…
- [Low] When skb_put_padto() fails, the new error path in bcmgenet_xmit()
  jumps to 'out' and skips the TDMA_PROD_INDEX doorbell write.

--

net: bcmgenet: pad transmit frames out of the packet ready window

This patch pads transmit frames that end just past the TX packet ready
threshold, so they land 64 bytes past it. The window causes the
transmitter to stop and Tx DMA to refuse to halt. For MTUs where a
maximum-length frame would fall inside that window, the patch lowers
the TX threshold instead.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 4634b6521ab8e..0cd56ec1c5ccf 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2171,6 +2176,18 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto out;
>  	}
>  
> +	/* Keep the frame out of the window just past the threshold */
> +	if (unlikely(skb->len > priv->tx_thld_len &&
> +		     skb->len < priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {
> +		if (skb_put_padto(skb, priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {

[Severity: Medium]
Can this padding corrupt frames that end in a trailer?

skb_put_padto() appends up to 63 zero bytes after whatever is already at
the end of the frame. It does not check what the frame carries. Some
encapsulations put data at the very end of the frame:

DSA tail taggers (tag_ksz, tag_trailer, tag_hellcreek, tag_xrs700x,
rtl8_4t): the switch would read the zeros as the tag. That is why
dsa_user_xmit() pads before the tail tagger runs:

net/dsa/user.c:dsa_user_xmit() {
    ...
	if (dev->needed_tailroom)
		eth_skb_pad(skb);
    ...
}

PRP: the redundancy control trailer would no longer be the last 6
bytes. The receiver would then treat the frame as non-PRP, and duplicate
discard would fail.

Software MACsec: macsec_decrypt() finds the ICV from the received
length:

	aead_request_set_ad(req, skb->len - icv_len);

so the trailing zeros would make authentication fail.

At this commit, on kernels with 16K or larger pages and an MTU of
3809..3820, the threshold drops to 3584. Frames of 3585..3647 bytes then
get padded.

Later in the series, "net: bcmgenet: reassemble jumbo frames from status
block fragments" raises max_mtu to ENET_MAX_JUMBO_MTU on all page sizes.
After that, any MTU of 3890 or more pads every frame of 3841..3903
bytes. MTUs of 3809..3889 pad frames of 3585..3647 bytes. Nothing later
in the series appears to fix this.

Should frames that carry a trailer be kept out of this window some other
way, rather than by appending bytes?

> +			BCMGENET_STATS64_INC((&ring->stats64), dropped);
> +			ret = NETDEV_TX_OK;
> +			goto out;

[Severity: Low]
If skb_put_padto() fails, this jumps to out. That skips the
TDMA_PROD_INDEX write at the end of bcmgenet_xmit():

	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
		/* Packets are ready, update producer index */
		bcmgenet_tdma_ring_writel(priv, ring->index,
					  ring->prod_index, TDMA_PROD_INDEX);

Suppose earlier skbs in the same xmit_more batch already advanced
ring->prod_index, and the dropped skb was the last one in the batch.
Could those descriptors sit unsubmitted until a later transmit
succeeds? The queue is not stopped, so the TX watchdog would not
notice.

skb_put_padto() can fail when the skb is short on tailroom or is
cloned, and the GFP_ATOMIC expansion fails. The existing
bcmgenet_add_tsb() and DMA mapping failure paths already behave this
way. This patch adds another way to reach that state.

> +		}
> +	}
> +
> +	nr_frags = skb_shinfo(skb)->nr_frags;
> +

[ ... ]

> @@ -2659,6 +2676,23 @@ static unsigned int bcmgenet_pkt_rdy_thld(unsigned int mtu)
>  		       ENET_THLD_MAX_LEN / ENET_THLD_UNIT);
>  }
>  
> +/* Transmit threshold in register units. Frames landing in the window just
> + * past it are padded clear of it, so pick a threshold that leaves room for
> + * that padding inside the frame the MTU allows. Size the window against the
> + * longest frame the MAC has to accept, since the tag count is not bounded.
> + */
> +static unsigned int bcmgenet_tx_pkt_rdy_thld(unsigned int mtu)
> +{
> +	unsigned int thld = ENET_THLD_MAX;
> +
> +	while (thld > ENET_THLD_DEFAULT &&
> +	       ENET_MAX_FRAME_LEN(mtu) - ETH_FCS_LEN > thld * ENET_THLD_UNIT &&
> +	       thld * ENET_THLD_UNIT + ENET_TX_SAFE_MARGIN > mtu + ETH_HLEN)
> +		thld -= ENET_THLD_BURST / ENET_THLD_UNIT;

[Severity: Medium]
For an MTU of 3809..3820, this loop lowers TBUF_PKT_RDY_THLD from 3840
to 3584 bytes. At this commit that range is only reachable on kernels
with 16K or larger pages, where ENET_MAX_MTU is 3820.

bcmgenet_xmit() still sets DMA_TX_DO_CSUM for every CHECKSUM_PARTIAL
frame:

		if (!i) {
			len_stat |= DMA_SOP;
			if (skb->ip_summed == CHECKSUM_PARTIAL)
				len_stat |= DMA_TX_DO_CSUM;
		}

Full-size TCP/UDP frames of 3585..3834 bytes now exceed the transmit
threshold. Before this commit, no frame could.

The last patch in the series, "net: bcmgenet: reassemble jumbo frames
from status block fragments", says the MAC only holds threshold bytes
for checksum insertion and silently drops longer frames. It adds this
fallback:

	if (unlikely(skb->len > priv->tx_thld_len) &&
	    skb->ip_summed == CHECKSUM_PARTIAL) {
		if (skb_checksum_help(skb)) {

Between this patch and that one, are CHECKSUM_PARTIAL frames longer
than 3584 bytes dropped when NETIF_F_HW_CSUM is enabled, which is the
default?

The end of the series fixes this, but bisection can still land in
between. Could the skb_checksum_help() fallback move into this patch?

> +
> +	return thld;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee%40tipi-net.de
