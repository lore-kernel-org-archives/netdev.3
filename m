Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081533;
	b=Q/3SlyysEXVNmwJQguymp3H3CBX8HPSfhNBhHhCie7FECCwyqf4COnhhTm9/nUhpUunQ
	 xXLDzsR19kCPwpOZfUs9IiPC/3M8f1mmLYkXFN6871a+zqkswu80ZJFgVlV2KDf/CLs62
	 FK9zfdCOZSgfqU8i+YyeWEhIyaB6LjRg6klDt8TR5rjN8d9PizaUSqUVP8QAod7kJjj0o
	 xYA9J3Y5ylBEQ6sDNGZ7YM63QYkYiUUhb8K9X6V9HVOKzuiyVn+JBFGGv4jx6y9mhuwbi
	 fFoEwZw+MEegOaWW4civ/wtE0lZoOm3M5XyRTJEfFuoaNqOVgufY/EmK9PQKbqrFREw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081533;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CTce4zEAlVGArBtBpRATcSZzHWtxlOE/W4XhWcLleWs=;
	b=iCemkijKrvNZnc32jMCfpFb/sJr6+UU54m4T4s01Ktxk5npgUCHZwIgawqrNdT2rFA/2
	 Ylk5ymq1WbYhDs7Pj0GDhfV0D6nnOGM0UuFBLaahotxCEA8Y/Qy8SMzcTuE1yOBpOVwCZ
	 RXgpIE2B8yRvLywcew6gaVaibcudPvUSxa8TRHFcFfzFXuRsu9nOEG6Y/5GymhQaKAC1h
	 k2mbN9eo22u7LO09I6y26LqEHjTU8vXSuS15Sv0vEq9TQFzbxLiLVo9/n/U0mwmRG4rvZ
	 NPbLH8Cf01Z9pwBbSyoeHXbWGxJbBIpFP1xhwNWOpBRkqX87iD+ttNQaLplBJffypEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gw/XS5zR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F9606A337;
	Sat,  7 Nov 2026 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gw/XS5zR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6CD1F0089F;
	Sat,  7 Nov 2026 19:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081533;
	bh=CTce4zEAlVGArBtBpRATcSZzHWtxlOE/W4XhWcLleWs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gw/XS5zR/IrhMcXflmaNydsxa6ETv+TA8rCTdGQpG1N4ubpmq8ow3ghsheAjihXTW
	 Z2AjHOLUqyAY07ei3rWriordPQvDQJToJfv79TwVzd6ks1eEX9pNNCcpR1oHeQnQYX
	 wcreTybdW03vZyWM/yk3eGQD4svStyphhDrjkX0L6rq1yYzH4ZlwA2hItn+pE9ITEU
	 /+fMkdEAEMuAVAJ9HLAuE1InGEp5gQCbbqzCzy3IDmJApkc/jd9ZgOS39l2Yjdyohm
	 ct7CKdH5PDXGFieJxQEgRCgfiJNfE4tw0pXeJyiGd1Q3J126GdJGgHZmRrHQV/w31I
	 2IoKamCEKbW9g==
Subject: Re: [PATCH net v5 3/4] bnxt_en: stop DMA before releasing rings the
 firmware did not free
From: netdev-bot+sashiko@kernel.org
To: joe@dama.to
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 prashant@broadcom.com, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 19:58:52 +0000
Message-ID: <179408153226.994134.1709355150317602595@kernel.org>
In-Reply-To: <20261106191423.4194081-4-joe@dama.to>
References: <20261106191423.4194081-4-joe@dama.to>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves out completion/NQ rings and stat contexts.
- [High] The queue-restart path still frees ring memory after a RING_FREE
  failure.
- [Medium] bnxt_stop_dma() calls pci_clear_master() on the whole PCI
  function without quiescing anything else that uses it.
- [Medium] The trigger for an irreversible bus-master disable is broader
  than the commit justifies.
- [Medium] Bus mastering can be turned back on while stale firmware rings
  may still exist.
- [Medium] RING_FREE failures that only happen because a firmware reset
  is in progress are counted as stuck rings, and in the final series…

--

bnxt_en: stop DMA before releasing rings the firmware did not free

This commit makes bnxt_hwrm_ring_free() count TX, RX and RX AGG rings
whose HWRM_RING_FREE failed and return -EIO when any failed. The error
goes up through bnxt_hwrm_resource_free() to the close, half-close and
init_chip error paths. Those paths then call a new bnxt_stop_dma() helper,
which clears PCI bus mastering before ring memory is released.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index ea8529c789947..b5ef86bf92bf5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -7773,21 +7773,25 @@ static void bnxt_clear_one_cp_ring(struct bnxt *bp, struct bnxt_cp_ring_info *cp
>  			memset(cpr->cp_desc_ring[i], 0, size);
>  }
>  
> -static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
> +static int bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
>  {
> +	int stuck = 0;
>  	u32 type;
>  	int i;
>  
>  	if (!bp->bnapi)
> -		return;
> +		return 0;
>  
>  	for (i = 0; i < bp->tx_nr_rings; i++)
> -		bnxt_hwrm_tx_ring_free(bp, &bp->tx_ring[i], close_path);
> +		if (bnxt_hwrm_tx_ring_free(bp, &bp->tx_ring[i], close_path))
> +			stuck++;

[Severity: Medium]
Does every non-zero return here really mean the firmware did not free the
ring? hwrm_ring_free_send_msg() returns the same -EIO for several
different cases:

hwrm_ring_free_send_msg() {
	...
	if (rc || error_code) {
		netdev_err(bp->dev, "hwrm_ring_free type %d failed. rc:%x err:%x\n",
			   ring_type, rc, error_code);
		return -EIO;
	}
	...
}

A timeout ends up here. So does a firmware reply with a non-zero
error_code, for example a rejection of a ring ID the firmware no longer
tracks. Local failures from __hwrm_send() also end up here: -EBUSY when
BNXT_NO_FW_ACCESS() becomes true, or -ENOMEM from token acquisition.

The commit message only makes the case for "When HWRM_RING_FREE is not
answered". An explicit error reply means the firmware processed the
command.

Before this patch such a reply was only logged and the device could be
reopened. Now it leads to bnxt_stop_dma() and the driver has to be
rebound. Should stuck only count the case where no response arrived?

>  
>  	bnxt_cancel_dim(bp);
>  	for (i = 0; i < bp->rx_nr_rings; i++) {
> -		bnxt_hwrm_rx_ring_free(bp, &bp->rx_ring[i], close_path);
> -		bnxt_hwrm_rx_agg_ring_free(bp, &bp->rx_ring[i], close_path);
> +		if (bnxt_hwrm_rx_ring_free(bp, &bp->rx_ring[i], close_path))
> +			stuck++;
> +		if (bnxt_hwrm_rx_agg_ring_free(bp, &bp->rx_ring[i], close_path))
> +			stuck++;
>  	}

[Severity: High]
Earlier in the series these helpers were changed to return the RING_FREE
status, but the queue restart path still ignores it. Can that path free
ring memory after an unanswered RING_FREE?

bnxt_queue_stop() {
	...
	bnxt_hwrm_rx_ring_free(bp, rxr, false);
	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
	...
	if (bp->tph_mode) {
		bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
		bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
	}
	...
	return 0;
}

With TPH, bnxt_tx_queue_stop() does the same for TX, then unmaps the TX
buffers straight away:

		bnxt_hwrm_tx_ring_free(bp, txr, true);
		bnxt_hwrm_cp_ring_free(bp, txr->tx_cpr);
		bnxt_free_one_tx_ring_skbs(bp, txr, txr->txq_index);
		bnxt_clear_one_cp_ring(bp, txr->tx_cpr);

bnxt_queue_stop() returns 0, so netdev_rx_queue_restart() treats the stop
as successful and calls ndo_queue_mem_free(old_mem). That frees the old
RX descriptor rings and the page_pool buffers the firmware may still be
writing to:

netdev_rx_queue_restart()
  bnxt_queue_stop()
    bnxt_hwrm_rx_ring_free()    <- -EIO, ignored
  ndo_queue_mem_free(old_mem)

This path can be reached from bnxt_tph_update() on an IRQ affinity
change, from devmem dmabuf bind/unbind, or from io_uring zcrx
registration.

Neither this patch nor the later "bnxt_en: refuse to open a device with
stopped DMA" changes these paths. Should they be handled the same way?

>  
>  	/* The completion rings are about to be freed.  After that the
> @@ -7817,6 +7821,19 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
>  			bp->grp_info[i].cp_fw_ring_id = INVALID_HW_RING_ID;
>  		}
>  	}
> +
> +	if (!stuck)
> +		return 0;

[Severity: High]
Only the TX, RX and RX AGG frees are counted in stuck. Can the firmware
still own completion or NQ ring memory when this returns 0?

bnxt_hwrm_cp_ring_free() still returns void, and it drops the result for
the L2_CMPL rings in cp_ring_arr:

bnxt_hwrm_cp_ring_free() {
	...
	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_L2_CMPL,
				INVALID_HW_RING_ID);
	ring->fw_ring_id = INVALID_HW_RING_ID;
}

The NQ/L2_CMPL free in the loop just above also ignores its return value:

		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
			hwrm_ring_free_send_msg(bp, ring, type,
						INVALID_HW_RING_ID);
			ring->fw_ring_id = INVALID_HW_RING_ID;

bnxt_hwrm_stat_ctx_free() has the same problem. It ignores each
hwrm_req_send() result and sets hw_stats_ctx_id to INVALID_STATS_CTX_ID
anyway, and bnxt_hwrm_resource_free() takes rc only from
bnxt_hwrm_ring_free().

The commit message says only a subset of RING_FREEs time out. Suppose
that subset is only CP/NQ rings or STAT_CTX_FREE. Then bnxt_stop_dma() is
skipped, and __bnxt_close_nic()/bnxt_half_close_nic() go on to
bnxt_free_mem(). That frees the completion/NQ descriptor pages through
bnxt_free_cp_rings() and bnxt_free_all_cp_arrays(). With irq_re_init it
also frees the hw_stats DMA buffers through bnxt_free_ring_stats().

The device writes to these buffers even with no traffic. It writes
completion and NQ entries, async events on cp ring 0 (registered by
bnxt_hwrm_set_async_event_cr() in bnxt_hwrm_ring_alloc()) and periodic
stats.

Doesn't that leave the IO_PAGE_FAULT case from the commit message still
reachable? The later "bnxt_en: refuse to open a device with stopped DMA"
does not change this.

> +
> +	netdev_err(bp->dev, "Firmware did not free %d ring(s)\n", stuck);
> +	return -EIO;
> +}
> +
> +static void bnxt_stop_dma(struct bnxt *bp)
> +{
> +	netdev_err(bp->dev,
> +		   "Disabling DMA before releasing ring memory, the driver must be rebound to recover\n");
> +	pci_clear_master(bp->pdev);

[Severity: Medium]
The commit message says:

  "bnxt_hwrm_resource_free() still frees the remaining firmware
  resources before returning the error, so the shutdown can send every
  message it needs to before the device is stopped."

Is that accurate? The firmware DMA-writes HWRM responses into host
memory:

__hwrm_req_init() {
	...
	ctx->req->resp_addr = cpu_to_le64(dma_handle + BNXT_HWRM_RESP_OFFSET);
	...
}

Once bus mastering is cleared, every later HWRM can only time out, and
bnxt_close() still sends messages after the close:

bnxt_close() {
	...
	bnxt_close_nic(bp, true, true);
	bnxt_hwrm_shutdown_link(bp);
	bnxt_hwrm_if_change(bp, false);
	...
}

bnxt_fw_reset_close() likewise sends HWRM_FUNC_DRV_UNRGTR through
bnxt_hwrm_func_drv_unrgtr() after __bnxt_close_nic().

pci_clear_master() also acts on the whole PCI function, which the bnxt_re
auxiliary device shares. The normal close and TX timeout reset paths
(bnxt_close(), and bnxt_reset() -> bnxt_reset_task()) never call
bnxt_ulp_stop().

The driver's existing paths that disable the device all call
bnxt_ulp_stop() first: bnxt_fw_exception()/bnxt_fw_reset() before
bnxt_fw_reset_close(), bnxt_io_error_detected() and bnxt_suspend().

Would bnxt_re lose DMA, MSI-X delivery and its HWRM channel here without
being notified?

A separate concern, an immediate reopen through bnxt_reset_task() ->
bnxt_open_nic(), is fixed later in the series by "bnxt_en: refuse to
open a device with stopped DMA". The ULP and post-stop HWRM issues are
still present at the end of the series.

[Severity: Medium]
Can bus mastering be turned back on while the firmware still has the
stuck rings? No caller of pci_set_master() in the driver checks for the
stopped state first. For example:

bnxt_resume() {
	...
	pci_set_master(bp->pdev);
	if (bnxt_hwrm_ver_get(bp)) {
		rc = -ENODEV;
		goto resume_exit;
	}
	rc = bnxt_hwrm_func_reset(bp);
	if (rc) {
		rc = -EBUSY;
		goto resume_exit;
	}
	...
}

VER_GET or FUNC_RESET may well fail if the firmware has already stopped
answering RING_FREE. Resume then exits with bus mastering on and nothing
reset.

If the function kept its ring context across suspend (D3hot without an
internal reset), could the stuck RX rings then DMA into pages that
bnxt_free_mem() has already released?

bnxt_fw_reset_task() also calls pci_set_master() unconditionally in its
ENABLE_DEV state.

The later "bnxt_en: refuse to open a device with stopped DMA" only blocks
bnxt_open*(). So "the driver must be rebound to recover" holds for open,
but not for bus mastering being re-enabled.

>  }
>  
>  static int __bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,

[ ... ]

> @@ -13540,7 +13561,8 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
>  	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
>  		bnxt_clear_rss_ctxs(bp);
>  	/* Flush rings and disable interrupts */
> -	bnxt_shutdown_nic(bp, irq_re_init);
> +	if (bnxt_shutdown_nic(bp, irq_re_init))
> +		bnxt_stop_dma(bp);

[Severity: Medium]
What happens when the only reason these RING_FREEs fail is a firmware
reset in progress?

NAPI and bnxt_timer are still running here, because bnxt_disable_napi()
and timer_delete_sync() come after bnxt_shutdown_nic(). The async
RESET_NOTIFY handler can set BNXT_STATE_FW_FATAL_COND after
hwrm_ring_free_send_msg() has passed its BNXT_NO_FW_ACCESS() check.
__hwrm_send() then returns -EBUSY.

__hwrm_send() also abandons the wait if the firmware health register
reports not healthy:

__hwrm_send() {
	...
				if (hwrm_wait_must_abort(bp, req_type, &sts)) {
					hwrm_err(bp, ctx, "Resp cmpl intr abandoning msg: 0x%x due to firmware status: 0x%x\n",
						 req_type, sts);
					goto exit;
	...
}

bnxt_close_nic() already notes that "Some firmware messages may fail as
we proceed to close" when BNXT_STATE_IN_FW_RESET is set. With this
patch, each such failure becomes -EIO, stuck++ and then bnxt_stop_dma().

That includes the FW reset close path itself:

bnxt_fw_reset_task()
  bnxt_fw_reset_close()
    __bnxt_close_nic()
      bnxt_shutdown_nic()    <- -EIO
      bnxt_stop_dma()

After the later "bnxt_en: refuse to open a device with stopped DMA",
bnxt_stop_dma() also sets BNXT_STATE_DMA_STOPPED, and nothing clears it.

The reset still re-enables bus mastering in ENABLE_DEV. But in the
OPENING state, bnxt_open() then fails in bnxt_check_dma_stopped() with
-ENODEV, and bnxt_fw_reset_abort() runs.

If a close races with a reset, bnxt_close_nic() sets ABORT_ERR. A later
bnxt_open() is then refused before it reaches bnxt_reinit_after_abort(),
which doesn't call pci_set_master() anyway.

Before this patch a coordinated FW reset could recover the device. Is it
intended that a rebind is now the only way to recover?

>  
>  	/* TODO CHIMP_FW: Link/PHY related cleanup if (link_re_init) */
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106191423.4194081-1-joe%40dama.to
