Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478136;
	b=ZZ99O8bNIlDBl/NNqeViTBC1MZskIqPjnOy3jTo9eSRt3t4LBZ/b87C9ChM7KCQEopwP
	 eV7JXfL5oOmZDt1GL4djQ3zRkfgoG4Af2KWn31i7YUQrEeSq41Hc8jZPPVQUQzG9uuT1U
	 pWcNOSB6mq3leUCX7Fl7BQwvDJrGLgb7doilfCrFZVGAgtS4IikSTsOvW5UmmZuWC9rgp
	 RJPQOToPviHcckjqKQ4/2MOSJJFOoYPQEEXB+c/RaWWw4BeRljC3voVj4uuc2dMgNvRSV
	 NosDRDXjCaIjvEsp2ZVuTSRY03xxhpeyFee/4Gk/FY5FnAWROhVqebrwzW+bkTeeYjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478136;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GYZI2TbfNbB54zmF9fDhfS5KLR8hYBAK5ZU+ntDYVgU=;
	b=Q7tSaedzNfWUquZYBJGhiAUiJ8uKavLkwkK2uamNbZ8yfn6DRZ0Io575kHrLNXNHTeeW
	 1ZQPcGuEeNS80GMWbZh8+i3E4oYENoFhcI4RR31UnxDUBY3/HLoS8fOCR6kzb+qZCnkqS
	 9ob5E91QAe+HFdwEBG81MGmnz5GMaq+KjN4R2Ps2Cmjkffsga5tEkEVRVHA2mylKyHUsm
	 e0ccK3/MNtbGhKx70miUL7Cl/zj57UlDG/jh8tp4gz7aBfBM1L/KERuuE90qm2h9rLZBN
	 GXLRPCJKw2sdbS5mRHPdZKOFS6H0vtgubCuhT4FL33Hf32wCsU/c3FZWsS9RMbef4XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilD9MwXC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E297606A321;
	Thu, 12 Nov 2026 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilD9MwXC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9D21F00A05;
	Thu, 12 Nov 2026 10:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478135;
	bh=GYZI2TbfNbB54zmF9fDhfS5KLR8hYBAK5ZU+ntDYVgU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ilD9MwXC5520N6YeS3vN2b1mHsCczauLN+nyrrr3AMQHF0l0WlxTlGo84+HMj6DMZ
	 RWOG9ZmfNQy08QesKrSx0GEsZC8oG+ors7gmYzDY1xdJQeUphUxFVW5QVuiO8vx+Mk
	 9jMBMqSjdAxP+hbUWgIG/KpgUe+fM5dvLJJMN8iacQ+lHNnkbPjojDci+GSFiUi5wg
	 Eysxtl/lQOEL3Ds0N4gQQsWkQsXFqZpu3FKu/wPDth3wWeftrRQpGYa0dmrcCmDWL/
	 jXGmECaG5F4xlKiclG1pFOQOfIGXw6BHG2q4i3axooSTYCSz5ooKmE+qB/7739G8hs
	 62BSxYn/kpiJw==
Subject: Re: [PATCH net-next v2 1/6] eth: mpnic: Tx checksum offload
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, dimitri.daskalakis1@gmail.com, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 10:08:54 +0000
Message-ID: <179447813438.2199510.8203457737182862437@kernel.org>
In-Reply-To: <20261110-mpnic-lso-v2-1-ccd37b051d08@gmail.com>
References: <20261110-mpnic-lso-v2-1-ccd37b051d08@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new per-queue Tx counter `twq.csum_partial`, which reaches
  userspace as the qstats `tx-needs-csum` value, goes up too early.

--

eth: mpnic: Tx checksum offload

This adds generic Tx checksum offload (NETIF_F_HW_CSUM) to mpnic, including
for encapsulated skbs via hw_enc_features. It adds mpnic_features_check() to
make sure the skb header layout fits the Tx descriptor fields. CSO frames are
counted and reported through the netdev qstats needs_csum counter.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index 93abdec44642f..65de6d999d548 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> +static void
> +mpnic_tx_offloads(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
> +{
> +	struct mpnic_tx_hdrs hdrs = {};
> +
> +	if (skb->ip_summed != CHECKSUM_PARTIAL)
> +		return;
> +
> +	mpnic_tx_fill_hdrs(skb, &hdrs);
> +
> +	*meta |= cpu_to_le64(FIELD_PREP(MPNIC_TWD_CSUM_OFFSET,
> +					skb->csum_offset / 2) |
> +			     MPNIC_TWD_FLAG_REQ_CSO);
> +
> +	u64_stats_update_begin(&ring->stats.syncp);
> +	u64_stats_inc(&ring->stats.twq.csum_partial);
> +	u64_stats_update_end(&ring->stats.syncp);

[Severity: Low]
Should this counter be bumped only after the frame is actually queued to
the hardware?

mpnic_tx_offloads() increments twq.csum_partial for every CHECKSUM_PARTIAL
skb before mpnic_xmit_frame_ring() calls mpnic_tx_map():

> @@ -230,6 +263,8 @@ static netdev_tx_t mpnic_xmit_frame_ring(struct sk_buff *skb,
>  	MPNIC_XMIT_CB(skb)->bytecount = skb->len;
>  	MPNIC_XMIT_CB(skb)->desc_count = 0;
>  
> +	mpnic_tx_offloads(ring, skb, meta);
> +
>  	if (mpnic_tx_map(ring, skb, meta))
>  		goto err_free;

mpnic_tx_map() can fail in two ways. One is dma_map_single() or
skb_frag_dma_map() returning a mapping error. The other is the head or a
fragment being larger than FIELD_MAX(MPNIC_TWD_LEN). In either case the
error path frees the skb and counts it as dropped:

mpnic_xmit_frame_ring() {
    ...
err_free:
	dev_kfree_skb_any(skb);
	ring->tx_buf[tail] = NULL;
	ring->tail = tail;
err_drop:
	mpnic_tx_flush_doorbell(ring);

	u64_stats_update_begin(&ring->stats.syncp);
	u64_stats_inc(&ring->stats.twq.dropped);
	u64_stats_update_end(&ring->stats.syncp);
    ...
}

The csum_partial increment is never undone. mpnic_get_queue_stats_tx()
then reports it as tx->needs_csum, so the same packet shows up as both
dropped and checksummed by the device, even though it never reached the
hardware.

The same ordering is still there later in the series. mpnic_tx_offloads()
also bumps hw_gso_wire through mpnic_tx_lso() before mpnic_tx_map() runs.

One option is to have mpnic_tx_offloads() report which offload it used,
and update the stats only after mpnic_tx_map() succeeds. Note that fbnic
uses the same count-before-map pattern in fbnic_tx_offloads().

> +
> +	*meta |= cpu_to_le64(FIELD_PREP(MPNIC_TWD_L2_HLEN,
> +					skb_mac_header_len(skb) / 2) |
> +			     FIELD_PREP(MPNIC_TWD_L3_IHLEN, hdrs.i3len / 2));
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-mpnic-lso-v2-0-ccd37b051d08%40gmail.com
