Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081531;
	b=tme9mNnnhSGi+mxlbLaCo5qpDqSBvFOLETzriuMaHeMTNq1U2dn3HpbnoyLRhGYf687X
	 kus2dsQhlMSEE0plbiZg54TG8y3Eo1u4bysmgtiCwlZ82sGUzbjd05hLAEaSfwIWKs2VZ
	 FwK8Ej8fwGY5IN3Y6GmfxElq9K/t5ZGMWuYDdujN2woVUDIypmmo/eCHwK5nu2uGsKpXn
	 zf4g+7B/7by+a0P1/g1LaRxeLv53BmDmOh+sI3DR/JpeanLnpR30E6XN3VxqklGhc6cAd
	 yjQq48X5gYjXJ7hL7RE9fe4ZJcCQ4SJ4odj+2BNMcKFI9p+U4Ztizu/dz6HOj5s95qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081531;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HsH/ESsjxGT6Amr/Yi1q7u+6v57LDKwT2C5DQH3AF4o=;
	b=Pa4cWWU6h+p6n/prWHGUmrhybE3ZX2bRqU3FWFO+nZVcJuaT7WB3nAg3jz2tqPjzL4Ke
	 PGExw+u7J3gqJJiP8+UgsUaq1luOLXPr+98qGr5n0mOIeeaOQZ4P8+UbtPoK35gufpjrn
	 LYikVz6L9Ov3yk+pMV5dD6xU4Nrp2i+qaGwHYsIKNziiBzqUac2lB5nYNsGhXC7ieytqg
	 vl+4g13ZtoKSZdhy8zYF0NlWaV2FSV9SjFHOAVQAaYs32GKa1ciVl13997Y7afv/3iXhv
	 L6h0KAHd2javLsdDyH5b9ZmD0JDWlK0DtWiE0n8tWkN56+aPnqa7ZiV/IGJIY6be+3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ar9bK5wV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767C606A326;
	Sat,  7 Nov 2026 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ar9bK5wV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3917E1F0089F;
	Sat,  7 Nov 2026 19:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081530;
	bh=HsH/ESsjxGT6Amr/Yi1q7u+6v57LDKwT2C5DQH3AF4o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ar9bK5wVmRadgJhlJXaQpAm2lxh3PsDy4DRIkbZJ3FADImtkGLIXCAfVozfHg3G9S
	 9TAtOr5NTfv1KCmAA7EP7WJatk8/TAC4id068YdMXmzQ4hlYo1wjwH0UPVE/NdaRf2
	 hT86EIbxigIxL4H4Inr/JEc2+J1xn8iDgsyqXnyCkGPeELUWLDw89pJSmlOhQnQlhy
	 qQogmARgqA0PW2q5dAYjbtDewkZDzKu6aObrbiYgSDpfbUrponrFso//jGzbJxyW1n
	 9u6Mq6SuWa5FK7YO7Q+FgafCb9ZIvvt06VnuAxcFoSS5Vjxs293uv5V3pw5KnFNQOJ
	 Ki5LFrNJMd01g==
Subject:
 Re: [PATCH net v5 1/4] bnxt_en: return the RING_FREE status to callers
From: netdev-bot+sashiko@kernel.org
To: joe@dama.to
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 prashant@broadcom.com, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 19:58:49 +0000
Message-ID: <179408152976.994134.11735257663578231009@kernel.org>
In-Reply-To: <20261106191423.4194081-2-joe@dama.to>
References: <20261106191423.4194081-2-joe@dama.to>
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

- [High] The patch makes bnxt_hwrm_rx_ring_free(),
  bnxt_hwrm_rx_agg_ring_free() and bnxt_hwrm_tx_ring_free() return the…
- [Medium] The commit message says "All three ring free helpers that send
  the command discard the value", but four helpers send HWRM_RING_FREE,…

--

bnxt_en: return the RING_FREE status to callers

This commit changes bnxt_hwrm_tx_ring_free(), bnxt_hwrm_rx_ring_free()
and bnxt_hwrm_rx_agg_ring_free() so they return the status from
hwrm_ring_free_send_msg() instead of discarding it. No caller acts on
the returned value yet.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 33c4cacc8ffe3..ea8529c789947 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -7679,50 +7679,55 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,

[ ... ]

> -static void bnxt_hwrm_rx_ring_free(struct bnxt *bp,
> -				   struct bnxt_rx_ring_info *rxr,
> -				   bool close_path)
> +static int bnxt_hwrm_rx_ring_free(struct bnxt *bp,
> +				  struct bnxt_rx_ring_info *rxr,
> +				  bool close_path)
>  {
>  	struct bnxt_ring_struct *ring = &rxr->rx_ring_struct;
>  	u32 grp_idx = rxr->bnapi->index;
>  	u32 cmpl_ring_id;
> +	int rc;
>  
>  	if (ring->fw_ring_id == INVALID_HW_RING_ID)
> -		return;
> +		return 0;
>  
>  	cmpl_ring_id = bnxt_cp_ring_for_rx(bp, rxr);
> -	hwrm_ring_free_send_msg(bp, ring,
> -				RING_FREE_REQ_RING_TYPE_RX,
> -				close_path ? cmpl_ring_id :
> -				INVALID_HW_RING_ID);
> +	rc = hwrm_ring_free_send_msg(bp, ring,
> +				     RING_FREE_REQ_RING_TYPE_RX,
> +				     close_path ? cmpl_ring_id :
> +				     INVALID_HW_RING_ID);
>  	ring->fw_ring_id = INVALID_HW_RING_ID;
>  	bp->grp_info[grp_idx].rx_fw_ring_id = INVALID_HW_RING_ID;
> +	return rc;
>  }

[Severity: High]
The per-queue callers of these helpers still ignore the returned status,
and none of the later patches in the series seems to change them. Can
the queue restart path still release rings that the firmware did not
free?

In bnxt_queue_stop():

	bnxt_hwrm_rx_ring_free(bp, rxr, false);
	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
	...
	memcpy(qmem, rxr, sizeof(*rxr));
	bnxt_init_rx_ring_struct(bp, qmem);

	return 0;

If the firmware rejects HWRM_RING_FREE or it times out, ndo_queue_stop
still returns 0. netdev_rx_queue_reconfig() then calls
ndo_queue_mem_free() on the old queue memory.

bnxt_queue_mem_free() then frees the RX buffers, destroys the page pools
and frees the RX and AGG descriptor rings. The firmware ring may still be
live at that point.

With tph_mode set, bnxt_tx_queue_stop() does the same thing for TX:

		bnxt_hwrm_tx_ring_free(bp, txr, true);
		bnxt_hwrm_cp_ring_free(bp, txr->tx_cpr);
		bnxt_free_one_tx_ring_skbs(bp, txr, txr->txq_index);

The helpers also clear ring->fw_ring_id even when rc is non-zero. After
that, the stale firmware ring is no longer visible to the stuck ring
accounting that the later patch "bnxt_en: stop DMA before releasing
rings the firmware did not free" adds to bnxt_hwrm_ring_free(). Would a
later close then skip bnxt_stop_dma() for that ring?

This path can be reached through netdev_rx_queue_restart(), either from
devmem TCP or io_uring zcrx memory provider binding, or from the bnxt
TPH IRQ affinity work.

> -static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
> -				       struct bnxt_rx_ring_info *rxr,
> -				       bool close_path)
> +static int bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
> +				      struct bnxt_rx_ring_info *rxr,
> +				      bool close_path)

[ ... ]

> @@ -7730,14 +7735,15 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
>  		type = RING_FREE_REQ_RING_TYPE_RX;
>  
>  	if (ring->fw_ring_id == INVALID_HW_RING_ID)
> -		return;
> +		return 0;
>  
>  	cmpl_ring_id = bnxt_cp_ring_for_rx(bp, rxr);
> -	hwrm_ring_free_send_msg(bp, ring, type,
> -				close_path ? cmpl_ring_id :
> -				INVALID_HW_RING_ID);
> +	rc = hwrm_ring_free_send_msg(bp, ring, type,
> +				     close_path ? cmpl_ring_id :
> +				     INVALID_HW_RING_ID);
>  	ring->fw_ring_id = INVALID_HW_RING_ID;
>  	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
> +	return rc;
>  }
>  
>  static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,

[Severity: Medium]
The commit message says:

    All three ring free helpers that send the command discard the value.

Is that count right? bnxt_hwrm_cp_ring_free() also sends HWRM_RING_FREE,
and it still returns void:

	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_L2_CMPL,
				INVALID_HW_RING_ID);
	ring->fw_ring_id = INVALID_HW_RING_ID;

The inline NQ/L2_CMPL free in bnxt_hwrm_ring_free() also drops its
status:

		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
			hwrm_ring_free_send_msg(bp, ring, type,
						INVALID_HW_RING_ID);

By the end of the series, bnxt_hwrm_ring_free() counts stuck rings only
for TX, RX and AGG failures. If a CP or NQ RING_FREE fails, would
bnxt_stop_dma() be skipped, with __bnxt_close_nic() going on to free
that ring's memory in bnxt_free_mem()?

Ring 0 of the CP/NQ set is also registered as the firmware async event
completion ring by bnxt_hwrm_set_async_event_cr() in
bnxt_hwrm_ring_alloc(). The close path does not move that registration.

It is not certain that firmware keeps writing to an unfreed CP/NQ ring
after the TX and RX rings are gone. Async event completions are the
likely source if it does.

On the per-queue paths, bnxt_tx_queue_stop() and bnxt_queue_stop() (with
tph_mode) call the converted helpers right next to
bnxt_hwrm_cp_ring_free(). The CP ring free status is not available to
those callers either.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106191423.4194081-1-joe%40dama.to
