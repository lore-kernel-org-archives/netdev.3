Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256101;
	b=ij1oEQpbVwU5RGW3sPmiEIiiqE3XUnQD8X2YB1mlki0sJVKVUoRTsQQaCZyltChGc2en
	 Pk8NFKkP3wMcJAiTtsPrqvX5xlztWe13V7l0aBXFSljb4L4TFVAlk+p11YAYiggM7+7ob
	 NPg+sryLtxe5LNPDe6Kx2y9v8SuVfMJFDmWn+fcR1yJtBrWu277jlgvu141OhtSq4EyiO
	 Krb2yIJJQAkTtRxlWDGVb8VjHefOY9NfCuLGKcpKE/wzMj/dSTHACJDSStNAl1qNKUSS1
	 IghIyJJaRMbDD1HE3llT4JqquzTljD1FZrVvLAGzn9iIM2xADSRFPXg3e3iERvQEn6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256101;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NeGV0RtPxT8luGTspx/HCm1L7zfy/Htekx3NJ1ID1zE=;
	b=e+KyCm1j5lzn294oaBchCLV9z7KtdBN2WBmniAiwClazNy8g1uJYQO6Q2ElzlAF7cPCg
	 GH+e0eK+5BUM+9N1TYtvZZ3z+HlwZDotiYcK6AQ3Fp5y3IcudygUVlkvCOQaGD46b70Um
	 UZzqwZjBiK5nFkQVd9UKueiqaepcRbNdJdFBBhrfCH1UCMeJRey/hvkaWAa8cqrSoApBG
	 F9/p5VqAbqVF0vsttmWOl4JJmpip9NhHltcBUfu6KrHnIBNtr5kyqnrmMSpGGzj0lHXXp
	 EyMmdigbH4UZ4DxApssoS3pBVRxgc9dX4SrNb2Au1NT/pjgYt6klUI3+joe7FNhYPmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcUUvXP6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE6606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcUUvXP6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56171F008A2;
	Mon,  9 Nov 2026 20:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794256100;
	bh=NeGV0RtPxT8luGTspx/HCm1L7zfy/Htekx3NJ1ID1zE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VcUUvXP6lWTkL/Qa3JIEuUIIgUS6VZ0UkRUPXryze9jfu57XDMyS/Q85A4HBedCcI
	 F5j/XpBr22odkr3v5SIobhDhUDctZIzBUt1Uzdc+3hQ1lvfoUOZeA7CjbLN65o+hhO
	 0mj+VIgjiJtTMm5JuNpKDVJdMwvB13fV2GHmgURKR1UKJmMSVm3BqxKziRgv0cX3iT
	 Tt8yr2Ihz3AoKCy/Qt2NK80LcLop6WeyOyaVx6Zs/54hhJa+qEHOiWvmTBYB5+2qlq
	 aMzOMDwN037X00Z4Vo91kUw29TN4Je9PprEQ4zYHK0Oq8cRGfFssbH6anS/WEB81pz
	 rfel5QudIsorQ==
Subject: Re: [PATCH v12 net-next 2/3] netdevsim: Implement basic ptp support
From: netdev-bot+sashiko@kernel.org
To: maciek@machnikowski.net
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org, almasrymina@google.com
Date: Mon, 09 Nov 2026 20:28:19 +0000
Message-ID: <179425609934.994134.5338593155278222514@kernel.org>
In-Reply-To: <20261108201503.85000-3-maciek@machnikowski.net>
References: <20261108201503.85000-3-maciek@machnikowski.net>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nsim_start_xmit() (drivers/net/netdevsim/netdev.c) only
  overwrites or clears skb_hwtstamps(skb)->hwtstamp inside `if…

--

netdevsim: Implement basic ptp support

This adds virtual hardware timestamping to netdevsim. Each netdevsim
uses an attached ptp_mock clock. TX timestamps are reported through
skb_tstamp_tx(), and RX timestamps are written into the forwarded
skb's shinfo hwtstamps. The patch also adds ndo_hwtstamp_get/set and
updates ethtool ts_info.

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 0372a9bd63bbb..f098520bdb034 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c

[ ... ]

> @@ -167,7 +173,53 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	      cfg->hds_thresh > len)))
>  		skb_linearize(skb);
>  
> +	if (unlikely(READ_ONCE(peer_ns->tstamp_config.rx_filter) !=
> +		     HWTSTAMP_FILTER_NONE))
> +		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);
> +
> +	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
> +	    READ_ONCE(ns->tstamp_config.tx_type) == HWTSTAMP_TX_ON) {
> +		ptp_info_tx = mock_phc_get_ptp_info(ns->phc);
> +		if (ptp_info_tx)
> +			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +	}
> +
>  	skb_tx_timestamp(skb);
> +
> +	if (unlikely(ptp_info_tx || ptp_info_rx)) {
> +		/* Capture both timestamps closely */
> +		if (ptp_info_tx)
> +			ptp_info_tx->gettime64(ptp_info_tx, &tx_ts);
> +		if (ptp_info_rx)
> +			ptp_info_rx->gettime64(ptp_info_rx, &rx_ts);
> +
> +		/* If TX hardware timestamping is enabled report TX timestamp */
> +		if (ptp_info_tx) {
> +			shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
> +			skb_tstamp_tx(skb, &shhwtstamps);
> +		}
> +
> +		/* Clones (e.g. the TX timestamp errqueue skb) share shinfo */
> +		if (unlikely(skb_unclone(skb, GFP_ATOMIC))) {
> +			kfree_skb(skb);
> +			if (psp_ext)
> +				__skb_ext_put(psp_ext);
> +			goto out_drop_cnt;
> +		}
> +
> +		if (ptp_info_rx) {
> +			/* hwtstamp aliases xsk_meta; orphan first so any
> +			 * pending AF_XDP completion isn't corrupted.
> +			 */
> +			skb_orphan(skb);
> +			skb_hwtstamps(skb)->hwtstamp =
> +				timespec64_to_ktime(rx_ts);
> +		} else {
> +			/* Don't leak the TX timestamp as an RX timestamp */
> +			skb_hwtstamps(skb)->hwtstamp = 0;
> +		}
> +	}

[Severity: Medium]
Can the TX timestamp still leak out as an RX timestamp through the
retransmit queue skb?

In nsim_start_xmit(), skb_tstamp_tx() runs before skb_unclone(). If the
socket does not use SOF_TIMESTAMPING_OPT_TSONLY, __skb_tstamp_tx() clones
the skb and writes the hardware timestamp into the clone:

net/core/skbuff.c:__skb_tstamp_tx() {
    ...
	skb = skb_clone(orig_skb, GFP_ATOMIC);
    ...
	if (hwtstamps)
		*skb_hwtstamps(skb) = *hwtstamps;
    ...
}

That clone shares skb_shared_info with the skb that was passed to the
driver. For TCP, the driver's skb is itself a clone of the retransmit
queue skb. If it is still cloned at this point, tx_ts ends up in the rtx
queue skb's shinfo.

skb_unclone() and the hwtstamp = 0 branch only clean the private copy
that gets forwarded.

By default, the earlier skb_linearize() goes through pskb_expand_head()
and gives the skb a private shinfo. That call is skipped when the peer
has tcp-data-split enabled and hds_thresh <= len. The default hds_thresh
is 0. The path is also open when skb_linearize() fails, because its
return value is ignored.

A later retransmit can then skip the TX branch in one of two ways:

  - tcp_fragment() copies the stale hwtstamps into the head via
    skb_unclone_keeptruesize(), while tcp_fragment_tstamp() moves
    SKBTX_HW_TSTAMP to the tail fragment.
  - tx_type has been switched to HWTSTAMP_TX_OFF in the meantime.

If the peer also has rx_filter == HWTSTAMP_FILTER_NONE, this check is
false:

	if (unlikely(ptp_info_tx || ptp_info_rx)) {

So nothing touches hwtstamp before
nsim_forward_skb()->__dev_forward_skb()->skb_scrub_packet(), and none of
those clear the shinfo hwtstamps.

Would the peer's TCP socket then report the sender's old TX PHC time as
a hardware RX timestamp, even though RX timestamping is disabled on that
device?

A related problem existed before this patch and was not introduced by
it: an AF_XDP generic-xmit skb's xsk_meta.tx_timestamp pointer lives in
the same union. It is forwarded to the peer unchanged when neither
branch runs.

> +
>  	if (unlikely(nsim_forward_skb(dev, peer_dev,
>  				      skb, rq, psp_ext) == NET_RX_DROP))
>  		goto out_drop_cnt;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108201503.85000-1-maciek%40machnikowski.net
