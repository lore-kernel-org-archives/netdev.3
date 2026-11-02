Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640832;
	b=a09jh+91uUI+S8x2cAmqJQe7xmWWFnkdGJt7jtp0Kx/ttugHUPQflZ37N7qcpEitdApF
	 tP46pXUYo9Y7FjuF/G07jVIu0KYcaHEosIOdrZEqWVG5AZGJ6fQ5vREXcIJma0GqtfHnG
	 RAFbWsVvcrKl192a88lQWBQ9KUvRxU2bqPZvV0l49GsZnAn2KbfgkaBquOfS1nipMJ8aO
	 HlzveglkoMl7+no+OBuK7qdcXibILvtKwGpWnVzCMVlOkGFPcE6IBzjWgi9gXBxrcwJlF
	 CUDe3rhhGlO3Fh2eQg45oNJ3xLPIIKL4FR0yOZG6YlJq+NWtou00eZm+9ovQ1m9idvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640832;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NW8ZU0sBpbVBOi33hW0BCgeDRWT6riQdrCZk2EpkxOw=;
	b=WqGt7JecWsUwzOvkfBWStV7Jq6I9JJMNoEG45pMW1aqhOy9HGkBXxBjfI6WX+mBJ2EXg
	 K58ncSHbRjR0uBdIXG9X6utjG1CWkMFrBiYwkxbBknZ+qnroCsyC9iENkNvmOFAE8nzfp
	 lx7h2i4Pz3CG1PCFDfJmuBIc2hWeJGfn6gm+FFZD1vhVNUgv+XC97wagt+YxFEpEWXAkv
	 GPHS10N85NBhZ+uIym8ayfEUJKT7PUSo+NaytKgWK5oMbD7obSZRdWKLmfCtBwQtyfB9N
	 imymQPcZlBE56ocuoFQ6+RdRwPo9XqMjwu1YrCO3VjuRLAYvTNmDEVYbfdRMmivE/wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1O8e8lm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AA606A326;
	Mon,  2 Nov 2026 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1O8e8lm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7B41F00A16;
	Mon,  2 Nov 2026 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640831;
	bh=NW8ZU0sBpbVBOi33hW0BCgeDRWT6riQdrCZk2EpkxOw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C1O8e8lmOwb8wMV8hZ7tS1FAol7Ms9KBziEIwSqZ0qBWIfb4DXAvbjEkkFw0TWldd
	 G8YeyTCpCxwus+gpT/Veq5Sfr9FByNm8akxZ1sE3+wrfAW+6bpQyFyv3BNzb3crMQ+
	 uzgO5oxfC4+7CpjkScv2OQ9uzBMHjm5OA+zVXmjXh8lh8V6BCqTU3fa5rE1SbSvUuW
	 hSqkFBkxoltUlmzLeZeAH/UTR+rmEe9bYhO/zPxhhoRNuy+BnzTYFJTRI1xFgwKs00
	 CX5Q/1YBL5iS1uFvcvZKNnlwv30833xlHWWJzI8Pl1okkmc+uldCSUhEU88FzrZmaZ
	 jxJvsMP3US+Ig==
Subject: Re: [PATCH net v3] net: bgmac: fix RX frame length check
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 nbd@openwrt.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 17:33:50 +0000
Message-ID: <179364083073.3131.3402405376014910148@kernel.org>
In-Reply-To: <20261029173122.29636-1-rosenp@gmail.com>
References: <20261029173122.29636-1-rosenp@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] When bgmac_dma_rx_read() rejects an oversized frame, it only
  drops the current slot.
- [Medium] The new upper bound in bgmac_dma_rx_read()
  (drivers/net/ethernet/broadcom/bgmac.c:463-464, `len >…

--

net: bgmac: fix RX frame length check

This patch tightens the RX length check in bgmac_dma_rx_read(). It now
compares against BGMAC_RX_MAX_FRAME_SIZE instead of BGMAC_RX_ALLOC_SIZE,
adds a lower bound of ETH_HLEN + ETH_FCS_LEN, and prints the bad length.

> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 669eb7ce7d40b..b5e1d3c0003d6 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -460,10 +460,11 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
>  				break;
>  			}
>  
> -			if (len > BGMAC_RX_ALLOC_SIZE) {
> +			if (len < ETH_HLEN + ETH_FCS_LEN ||
> +			    len > BGMAC_RX_MAX_FRAME_SIZE) {

[Severity: Medium]
This caps the whole L2 frame at 1536 bytes, Ethernet header and FCS
included. Do the other limits in the driver still agree with that?

bgmac_enet_probe() still advertises:

	net_dev->max_mtu = BGMAC_RX_MAX_FRAME_SIZE - ETH_FCS_LEN;

That allows an MTU of 1532 and does not account for ETH_HLEN or VLAN/DSA
tags.

bgmac_chip_init() programs the MAC with this, which is 1550:

	bgmac_umac_write(bgmac, UMAC_MAX_FRAME_LEN, 32 + ETHER_MAX_LEN);

bgmac_change_mtu() programs 32 + mtu, which can be up to 1564.

So the MAC can accept and DMA frames of 1537 to 1564 bytes, or 1537 to
1550 bytes with the default settings. Won't the new check always drop
these frames? Each drop bumps rx_length_errors and rx_errors and logs
"DMA issue", even though the MAC was configured to accept the frame.

With an MTU between 1519 and 1522, frames of 1537 to 1540 bytes used to
be delivered intact. Only FCS bytes spilled past frame byte 1536, and the
FCS is stripped. These frames are now always dropped, and the commit
message doesn't mention this change in behaviour.

The commit message also says:

    A corrupted length between those two limits passes the check, and the
    following skb_put() runs past the skb tailroom and calls
    skb_over_panic() instead of dropping the frame.

Is that accurate for the whole range? Lengths up to about 1570 (32 byte
cache lines) or about 1602 (64 byte cache lines) seem to fit in the
SKB_DATA_ALIGN tailroom. Those frames were delivered, not panicked on.

Should max_mtu and UMAC_MAX_FRAME_LEN be brought in line with how many
frame bytes an RX buffer can hold, as part of this fix?

>  				if (net_ratelimit())
> -					netdev_err(bgmac->net_dev, "Found oversized packet at slot %d, DMA issue!\n",
> -						   ring->start);
> +					netdev_err(bgmac->net_dev, "Found packet with invalid length %u at slot %d, DMA issue!\n",
> +						   len, ring->start);
>  				put_page(virt_to_head_page(buf));
>  				bgmac->net_dev->stats.rx_length_errors++;
>  				bgmac->net_dev->stats.rx_errors++;

[Severity: High]
When an oversized frame is rejected here, only the current slot is
dropped. What happens to the continuation descriptors that hold the rest
of that frame?

bgmac_dma_rx_enable() sets:

	ctl |= BGMAC_DMA_RX_OVERFLOW_CONT;

As noted above, the MAC accepts frames of up to 1550 bytes by default.
Each buffer only holds 1536 frame bytes after BGMAC_RX_FRAME_OFFSET.

Other drivers for the same Broadcom DMA engine show that such frames
spill into the next descriptor, with the rest written from offset 0.
brcmsmac's dma_rx() computes resid = len - (rxbufsize - rxoffset) and
walks the extra buffers. b43's dma_rx() recycles the continuation
descriptors:

	/* The data did not fit into one descriptor buffer
	 * and is split over multiple buffers.
	 ...

After the break, ring->start moves to the next slot. The loop then reads
rx->len and rx->flags from offset 0 of that buffer. Those would be bytes
1536 to 1539 of the oversized frame, which the remote sender controls.

Any len from 18 to 1536 passes the new check, and flags won't be 0xbeef.
The code then calls build_skb(), skb_put(), eth_type_trans() and
napi_gro_receive() with up to 1532 bytes.

For a 1550 byte frame the hardware writes only 14 bytes into that second
buffer. All of them land before the skb data start at offset 30, and
bgmac_dma_rx_skb_for_slot() poisons only the 4 byte rx header.

Wouldn't this pass stale netdev_alloc_frag() memory, such as old packet
data or other freed kernel memory, up the stack as a received packet?

The commit message says the change stops eth_type_trans() from parsing
"bytes the hardware never wrote". This path still seems reachable.

Before this patch, the same continuation slot could also reach the
skb_over_panic() the commit message describes. The new bounds remove the
panic, but the stale memory is still passed up.

Could the continuation descriptors be consumed the way b43 does, or
SOF/EOF be checked? Another option is to cap UMAC_MAX_FRAME_LEN and
max_mtu so that no frame can exceed BGMAC_RX_MAX_FRAME_SIZE.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029173122.29636-1-rosenp%40gmail.com
