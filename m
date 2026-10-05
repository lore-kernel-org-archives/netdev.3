Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBD24BD351;
	Mon,  5 Oct 2026 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212683; cv=none; b=u4hSjJTuYQnv1xUj9sXWbh4x/dNO6E9vITqKKjecKLosN2AwodAogU2pPORaKOyJAZiONKFyshJgdb9HhcRG1Q6GRIN28hE3F++XQ3lbzq0YD7GY/8sWN+IJRle82hSivKok3VqZiGV3b0lHGjVURaWb32cczXFYEMSQgTXZgHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212683; c=relaxed/simple;
	bh=wkajE99C7lrt6vnROJengACJvUytQEeleSzljqgSdhA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyX/TNDp8LRJGFC1IzEEh16YH2moqMwOzQ3VbEMEOvua4MiktLK/xXL+ZgWaQvRq8Rut8M8LQ3Q/Ntrt34YPKL+HqgwG71+9i5m7RLJmbXIBinILC0RE5YVyHQYT7IwFlolNcOwpzEXgjSVxwzuj8K7PTmCwR4j4eSw+mgBvOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAD/tprD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAD/tprD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704561F00898;
	Mon,  5 Oct 2026 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212682;
	bh=HOwZrvejhvNTl9kbRgoChk6v8fUesQ4KHvfvAqh0vfU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nAD/tprDcTPrtn3T+Lzpq7im8HSKOPddfBVxBlTM2ANnAljPiLRYjA8r8yEjF6Oqy
	 b0s/EFj9BUwssn+q9JNpp1weN/Hi709f1Ii92Iro3IpwEfRukBnFjgZLG+e8+ZwjQj
	 BxgrzhdxBqZDYlengBV4F5gsecYjgPtQujUqdHlvGNXyTxzFFclEm/zt2DU14m3CKM
	 UUQu9PSsLiwd9Hap8wT2W3pOcYlVhNMP4zNBxWh/fqyV/GsuU8Ojof1RKGpswzFwgN
	 wUg2oowp//UAQ+gPHvOSbuMWcultiGOVgMiDcmUrPnlUSeOKBPpIemrzV39bHn3xqU
	 9G4a+PnnmRedg==
Subject: Re: [PATCH net-next 2/7] net: bcmgenet: allow a continuation
 descriptor without the alignment pad
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com
Date: Mon, 05 Oct 2026 15:04:40 +0000
Message-ID: <179121268098.434549.5173504855357905347@kernel.org>
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-2-96dc6d54cbee@tipi-net.de>
References: <20261002-nb-genet-mtu-nn-v2-v1-2-96dc6d54cbee@tipi-net.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Possible commit message mismatch in "net: bcmgenet: allow a
  continuation descriptor without the alignment pad".
- [Low] The RX buffer layout comment above GENET_RSB_PAD
  (bcmgenet.c:54-58 at this commit, 67-72 at the end of the series) is…

--

net: bcmgenet: allow a continuation descriptor without the alignment pad

This patch changes the RX length check in bcmgenet_desc_rx(). Only the
first (DMA_SOP) descriptor of a frame now has to carry the 2-byte
alignment pad after the status block. Continuation descriptors only need
room for the 64-byte struct status_64. The patch prepares for a larger
MTU.

> A frame longer than the packet ready threshold arrives in several
> descriptors, each with its own status block. Only the first one also
> carries the two alignment bytes. The length check assumes the pad is always
> there, so a continuation holding a single byte looks two bytes too short
> and the whole frame is dropped.

[Severity: Low]
Is this description accurate for the tree at this commit?

A continuation holding a single byte has len = 64 + 1 = 65. That is one
byte below the old GENET_RSB_PAD minimum of 66, not two.

Also, a continuation descriptor that passes the new min_len check still
reaches the unchanged check just below it in bcmgenet_desc_rx():

	if (unlikely(!(dma_flag & DMA_EOP) || !(dma_flag & DMA_SOP))) {
		netif_err(priv, rx_status, dev,
			  "dropping fragmented packet!\n");
		BCMGENET_STATS64_INC(stats, fragmented_errors);
		...
		goto next;
	}

So at this commit, the only change for such a descriptor is the counter
and log message. It goes to fragmented_errors instead of length_errors.

The behaviour the message describes, where a length error drops the whole
frame through bcmgenet_discard_frags(), only exists once the later patch
in the series is applied: "net: bcmgenet: reassemble jumbo frames from
status block fragments".

Could the message say that this bound is meant for the reassembly path
added later in the series? Could it also correct the one versus two byte
arithmetic?

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index a82579879f4b5..d89ae65997604 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2365,8 +2366,12 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  			  __func__, p_index, ring->c_index,
>  			  ring->read_ptr, dma_length_status);
>  
> +		/* Only the first descriptor carries the alignment pad */
> +		min_len = dma_flag & DMA_SOP ? GENET_RSB_PAD
> +					     : sizeof(struct status_64);

[Severity: Low]
This isn't a bug, but the RX buffer layout comment above GENET_RSB_PAD
still says every buffer has the pad:

/* Page pool RX buffer layout:
 * RSB(64) + pad(2) | frame data | skb_shared_info
 * The HW writes the 64B RSB + 2B alignment padding before the frame.
 */
#define GENET_RSB_PAD		(sizeof(struct status_64) + 2)

That contradicts the rule added here. The later reassembly patch in the
series depends on this rule: bcmgenet_add_frag() reads continuation data
from offset + sizeof(struct status_64), not offset + GENET_RSB_PAD.
However, no patch in the series updates the layout comment.

Should the layout comment say that only the SOP buffer carries the 2-byte
pad?

> +
>  		/* Reject lengths that would underflow the SKB build path. */
> -		if (unlikely(len > RX_BUF_LENGTH || len < GENET_RSB_PAD)) {
> +		if (unlikely(len > RX_BUF_LENGTH || len < min_len)) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee%40tipi-net.de
