Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2D54528C;
	Wed, 14 Oct 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987781; cv=none; b=MIlYVdK/ViOAIKUe51ZGEcSdf1GuLpMRRmF/chhfDIaonHngQUcfVJlOWu19wbt9EYkYTao/zJplSZkf8fbMW9iOXM4uNauCJnOAf262k0/ZX76qerDNdOwReuEUy7V3jG8QNTyabvB4hbe5LD6HqypjPOPSy8zYkNupl+tr46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987781; c=relaxed/simple;
	bh=C1NGfgrv1E5ASxsQwAznI/T8oQm41TP2gZwE+h0mmig=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i3hB3jC9FvK/kfh3T1ujOBcxcBx/gQm9NhdRgsas1jDhzd357Hp2Yllu2m6OD4LoOcSmpTW1mjp4jXS3ulXZt1+uyG3fBC/tV6f4k09Lx5X1Kw2IBscpwLI/FJyycZZMPF0m/xPB7PaEWAGchVJsadp2z8HTjbVlrhiN+mz4avE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee80/v85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee80/v85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F001F000C4;
	Wed, 14 Oct 2026 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791987779;
	bh=Uu0P8kyflDZVf/mBGOCfDqo7epBS82w1BcqWgsceJh8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ee80/v85iVdOzFnlzkhUNS6zeauvYcctg1O8l8ATTt1LmuyRY/y2Jf14Hnj/KiFXG
	 65D5y+2pGHsofCQT+51x3Wp02kjgL5B6YwJ5PIyXRTRi+d2bTrJFTei0Q1fxb3Yp9G
	 kpePOWdzSYFJUFc1uVgLVVR4cimgOeOk05x3w7FyGJi5KZbMcjU3cmg2v527iKaYbq
	 KTXeKX1oiAKbyn+E4f+W0/Qk4ZcS1UIwdv0KR1ucnxMJuCUdPwgq7afEjMXRQlwGrE
	 semSmL0qweM6Cf3uWjL+L+Jrk12XZuwvGE4qJ7UavPHtOeIfMdX6MEfPtdGNKx4IZD
	 ZcT6tsgv7nQGw==
Subject: Re: [PATCH net-next v5 8/8] net: bcmgenet: reassemble jumbo frames
 from status block fragments
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Date: Wed, 14 Oct 2026 14:22:58 +0000
Message-ID: <179198777861.434549.7442931129502036522@kernel.org>
In-Reply-To: <20261013-nb-genet-mtu-nn-v2-v5-8-076b6fc240be@tipi-net.de>
References: <20261013-nb-genet-mtu-nn-v2-v5-8-076b6fc240be@tipi-net.de>
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

- [Low] This patch rewrote the comment above the TX checksum fallback in
  bcmgenet_xmit() to say: "The MAC holds a frame to insert its checksum,…
- [Low] This patch updated the comment on bcmgenet_pkt_rdy_thld() to say
  the threshold covers the frame "up to the register maximum".

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but adaptive RX
  coalescing gets per-poll counts where it expects cumulative counters.

--

net: bcmgenet: reassemble jumbo frames from status block fragments

The hardware can split a frame across several RX descriptors and write a
status block at the start of each one. With this commit,
bcmgenet_desc_rx() strips those status blocks and joins the pieces into
one skb. The commit also raises max_mtu to the limit of the 14-bit
UMAC_MAX_FRAME_LEN, and TX frames longer than the threshold now fall back
to a software checksum.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 9f28006957d4d..323839adebbae 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2200,8 +2197,8 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
>  		}
>  	}
>  
> -	/* The MAC only inserts a checksum into a frame it holds in full, and
> -	 * silently drops a longer one, so fall back to software.
> +	/* The MAC holds a frame to insert its checksum, but only as much as
> +	 * its FIFO takes. Longer frames are dropped silently.
>  	 */
>  	if (unlikely(skb->len > priv->tx_thld_len) &&
>  	    skb->ip_summed == CHECKSUM_PARTIAL) {

[Severity: Low]
This isn't a bug, but does the new comment in bcmgenet_xmit() describe the
limit the code checks?

The condition under the comment compares skb->len with
priv->tx_thld_len. That is the programmable packet ready threshold that
bcmgenet_tx_pkt_rdy_thld() picks from the MTU, somewhere between
ENET_THLD_DEFAULT and ENET_THLD_MAX units. It is not a fixed FIFO size.
The commit message also says "anything longer than the threshold falls
back to software".

The new wording also drops "so fall back to software". The comment no
longer says that these frames go through skb_checksum_help() rather than
being dropped.

Could the comment name the threshold and mention the software fallback?

[ ... ]

> @@ -2552,7 +2637,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  	}
>  
>  	ring->dim.bytes = bytes_processed;
> -	ring->dim.packets = rxpktprocessed;
> +	/* A long frame spans several descriptors but is one packet */
> +	ring->dim.packets = rxframes;
>  
>  	return rxpktprocessed;
>  }

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch, but this
hunk touches the DIM accounting. Should ring->dim.packets and
ring->dim.bytes be cumulative counters?

Each poll overwrites them with that poll's counts. bcmgenet_rx_poll() then
passes them to DIM as a sample:

drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_rx_poll() {
    ...
	if (ring->dim.use_dim) {
		dim_update_sample(ring->dim.event_ctr, ring->dim.packets,
				  ring->dim.bytes, &dim_sample);
		net_dim(&ring->dim.dim, &dim_sample);
	}
    ...
}

dim_calc_stats() treats both values as counters that only go up and takes
a wrap-aware difference:

lib/dim/dim.c:dim_calc_stats() {
    ...
	u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
	u32 nbytes = BIT_GAP(BITS_PER_TYPE(u32), end->byte_ctr,
			     start->byte_ctr);
    ...
}

Two polls of the same size give a difference of zero, even under steady
traffic. A smaller poll after a larger one wraps to about 4 billion.

With adaptive-rx turned on through ethtool -C, would the ppms and bpms
values that net_dim_stats_compare() uses to pick coalescing profiles be
meaningless?

The baseline assigned rxpktprocessed per poll in the same way.

[ ... ]

> @@ -2696,7 +2784,8 @@ static void bcmgenet_link_intr_enable(struct bcmgenet_priv *priv)
>  }
>  
>  /* Receive threshold in register units. Covers the alignment bytes and the
> - * frame, but not the status block, which the hardware adds on top.
> + * frame up to the register maximum, but not the status block, which the
> + * hardware adds on top. A longer frame arrives in several descriptors.
>   */
>  static unsigned int bcmgenet_pkt_rdy_thld(unsigned int mtu)
>  {

[Severity: Low]
This isn't a bug, but is "up to the register maximum" accurate for
bcmgenet_pkt_rdy_thld()?

The function clamps to ENET_THLD_MAX_LEN / ENET_THLD_UNIT, and
ENET_THLD_MAX_LEN takes the smaller of the register limit and the page
limit:

#define ENET_THLD_MAX_LEN	min_t(unsigned int, \
				      ENET_THLD_MAX * ENET_THLD_UNIT, \
				      ENET_THLD_PAGE_LEN)

The comment above ENET_THLD_PAGE_LEN says "on 4K pages the page bounds
the threshold before the register does". On 64-bit with 4K pages,
ENET_THLD_PAGE_LEN works out to 3584, below the register limit of 3840.
That value is also where jumbo frames get split across descriptors.

Could the comment refer to the page or ENET_THLD_MAX_LEN limit rather than
the register maximum?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be%40tipi-net.de
