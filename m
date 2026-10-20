Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481137;
	b=bib1nt5281N3YqBDIqudPxMwWksxvY9vnD+tg07UaPtc4wRBJVS8D8t1upiKPNgtdYtk
	 i0+PF0ZuzR7JVeWBEiXd6BDsOhQyzfGw02obT56SerQM+c+UmqOKkVj4qkyG+heXp4cn2
	 bDaWhKmRlHpExlQR+v41Uj0ihW6BCPQTfZ5GFYf9B3cWQOm7QVqd1oa5WwRLvuYBRPL41
	 Yvug+DEcP9cBxWc6KSYHew6CgKMnbnFYj2mbElsRRfMU83OEnFY25exh7FY/jwffPMH8g
	 fKhzycCuBOFdWRoWO8/0tBX9WkC+TBbJQGrsIl2YwcDpVbIXDXgNHPDrTXo2OmkkyZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481137;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lfp58XwQi70g7NLqVgPwHNlO3lGqNpuNaYUDj97KvYY=;
	b=NQ4Q5O9OL9XJ2BXdomvVtj2mC1x3Ih63VkIb2sWEXkR1L+TNEy+cXpbDP1E7z/oz0Avx
	 sIK+LBgXqUEoQIHwm8uqLvJxp9fGkN83sPXssw0Tu6gX+y3C/d7fEzlbPkLt77c6sj9cD
	 /kFPu9rij6cMPXIo9JADkmdFkCbO/Xgk6j2qTMNeVnL93ngO1eMxAM3BFLV3MD0jALhk0
	 S/RhmzRKDBAjmKHsZVjc+MIKdPY/OV4AkMZhLvpkHuIpCKuAh6Ro+vQal2WTNrIwKibCr
	 twUuJeNeisjdEBPjsJ0s9Kfj9Eyo5n52uvyKkzfu6g0IZ5aPqEjqSasKm9zfF8kiTCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EPRS/1Rj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A48606A33A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPRS/1Rj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928571F000C6;
	Tue, 20 Oct 2026 07:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792481137;
	bh=lfp58XwQi70g7NLqVgPwHNlO3lGqNpuNaYUDj97KvYY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EPRS/1RjpS5N5xK7XrhqtsfWzWxGJHhLOtp5rAWrSX97U1iMIKXyCPdu8x2njqbU1
	 2S+hhFJauJ+ePl02MDCABlViSW+FiiAhaWXO/tRMawcDLySr0t4FyXOoe/7DLVvyhj
	 97fyM7wTuzCBVjPkMh+4IfKafz7CUSjyMglehP1RsrYgDz15RFs+FXYOcSXGHG/mep
	 iwglMxftT9nRukwc9gLPQ7w46WwYglV+mMclvHKw65NAKcx/l1m09+v2YA09KkXJg4
	 CeJQYABTmfpXV9SuLPl9w8flFlqS7Y44JE6z8YJvoNbSTLIzxGf2CqsuQZd1ywDvK1
	 tKz9Urvmxmxog==
Subject: Re: [PATCH net-next v4 8/8] bnxt_en: Fix ring accounting and
 validation when rings are constrained
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Date: Tue, 20 Oct 2026 07:25:36 +0000
Message-ID: <179248113613.3135.941378516751494969@kernel.org>
In-Reply-To: <20261016064427.496944-9-michael.chan@broadcom.com>
References: <20261016064427.496944-9-michael.chan@broadcom.com>
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

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In bnxt_init_int_mode(), the new min_tx check (`min_tx =
  bp->tx_nr_rings_xdp ?

Pre-existing issues:
- [High] Out-of-bounds read of bp->rx_ring in bnxt_fill_hw_rss_tbl_p5()
  through stale non-default RSS context indirection tables after the RX…
- [High] This problem wasn't introduced by this patch, but the
  BNXT_STATE_READ_STATS single-bit reader protocol in bnxt_get_stats64()…

--

bnxt_en: Fix ring accounting and validation when rings are constrained

This patch renames bnxt_adj_tx_rings() to bnxt_adj_rings(). The new
function scales TX, RX and CP rings together when fewer rings are
reserved. It also strengthens bnxt_rings_ok() to check the minimum ring
configuration needed for TCs and XDP. The adjustment is now done only in
__bnxt_reserve_rings() and bnxt_init_int_mode(), and the TC reset error
path at the end of bnxt_reserve_rings() is removed.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 9ea2de8e81358..7cc50c48f3b9e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -11528,20 +11579,50 @@ static int bnxt_init_int_mode(struct bnxt *bp)
>  		bp->irq_tbl[i].vector = pci_irq_vector(bp->pdev, i);
>  
>  	bp->total_irqs = total_vecs;

[ ... ]

>  	/* Trim rings based upon num of vectors allocated */
>  	rc = bnxt_trim_rings(bp, &bp->rx_nr_rings, &bp->tx_nr_rings,
>  			     total_vecs - ulp_msix, min == 1);
>  	if (rc)
>  		goto msix_setup_exit;
>  
> -	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings, bp->tx_nr_rings_xdp,
> -				  bp->rx_nr_rings);
> -	bp->cp_nr_rings = (min == 1) ?
> -			  max_t(int, tx_cp, bp->rx_nr_rings) :
> -			  tx_cp + bp->rx_nr_rings;
> +	min_tx = bp->tx_nr_rings_xdp ? tcs + 1 : tcs;
> +	if (bp->tx_nr_rings < min_tx) {
> +		netdev_err(bp->dev, "Not enough MSI-X to satisfy min. TX rings\n");
> +		rc = -ENOMEM;
> +		goto msix_setup_exit_restore;
> +	}

[Severity: Medium]
Does this check also reject the driver's own "rings not reserved yet"
state, where bp->tx_nr_rings is 0?

That state is created by bnxt_clear_reservations(bp, false), which is
called from bnxt_dl_reload_down() and bnxt_cancel_reservations(). A
failed bnxt_set_dflt_rings() creates it too. In both cases cp_nr_rings
is left nonzero:

bnxt_clear_reservations() {
    ...
	if (!fw_reset) {
		bp->tx_nr_rings = 0;
		bp->rx_nr_rings = 0;
	}
    ...
}

In this state the sequence is:

- bnxt_get_num_msix() returns cp_nr_rings plus the ULP vectors, so
  vectors get allocated.
- bnxt_trim_rings() succeeds with rx = tx = 0.
- tx_nr_rings (0) is then less than min_tx (at least 1).
- The function frees irq_tbl, calls pci_free_irq_vectors() and returns
  -ENOMEM.

Before this patch the same input returned 0.

Some callers run bnxt_init_int_mode() before the default rings are
reserved again:

bnxt_open()
  bnxt_reinit_after_abort()
    bnxt_clear_int_mode()
    bnxt_init_int_mode()   <- fails, BNXT_STATE_ABORT_ERR stays set

bnxt_open() then returns -ENODEV and never reaches
__bnxt_open_nic()->bnxt_init_dflt_ring_mode(), which would rebuild the
rings. Would every later open fail the same way until the driver is
rebound?

bnxt_sriov_disable()->bnxt_restore_pf_fw_resources() has the same
problem. It calls bnxt_clear_int_mode() and bnxt_init_int_mode(), then
passes the -ENOMEM to bnxt_ulp_irq_restart(). With the interface down,
wouldn't the RoCE ULP be left without MSI-X vectors?

Should this check be skipped when tx_nr_rings is 0?

[ ... ]

> @@ -13118,13 +13194,29 @@ static void bnxt_set_xdp_tx_rings(struct bnxt *bp)
>  	bp->tx_nr_rings += bp->tx_nr_rings_xdp;
>  }
>  
> -static void bnxt_adj_tx_rings(struct bnxt *bp)
> +static void bnxt_adj_rings(struct bnxt *bp)
>  {
> -	/* Make adjustments if reserved TX rings are less than requested */
> -	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
> -	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
> -	if (bp->tx_nr_rings_xdp)
> -		bnxt_set_xdp_tx_rings(bp);
> +	int tcs = bp->num_tc ? bp->num_tc : 1;
> +	int rx = bp->rx_nr_rings;
> +
> +	/* Make adjustments to rings based on TC/XDP/shared rings policies */
> +	if (bp->tx_nr_rings_xdp) {
> +		tcs++;
> +		bp->tx_nr_rings_per_tc = bp->tx_nr_rings / tcs;
> +		bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
> +	} else {
> +		bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
> +	}
> +
> +	if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
> +		bp->tx_nr_rings_per_tc = min(bp->tx_nr_rings_per_tc, rx);
> +		bp->rx_nr_rings = bp->tx_nr_rings_per_tc;
> +		if (bp->tx_nr_rings_xdp)
> +			bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
> +	}

[Severity: High]
This is a pre-existing issue, but this clamp gives rx_nr_rings new ways
to shrink:

- In shared-ring mode, a TX-only shortfall from firmware or MSI-X now
  also reduces RX.
- Under XDP, RX is clamped to tx / (tcs + 1).

After a shrink, __bnxt_reserve_rings() and bnxt_init_int_mode() only
check and reset the default table (bp->rss_indir_tbl).

Non-default contexts in dev->ethtool->rss_ctx are kept across close and
applied again at open:

__bnxt_open_nic()
  bnxt_hwrm_realloc_rss_ctx_vnic()
    __bnxt_setup_vnic_p5()
      bnxt_fill_hw_rss_tbl_p5()

In bnxt_fill_hw_rss_tbl_p5() the stored index is used directly:

	else if (vnic->flags & BNXT_VNIC_RSSCTX_FLAG)
		j = ethtool_rxfh_context_indir(vnic->rss_ctx)[i];
	...
	rxr = &bp->rx_ring[j];

bnxt_alloc_mem() has already reallocated bp->rx_ring with the smaller
rx_nr_rings. Can this read past the end of bp->rx_ring[]? Would
bnxt_cp_ring_for_rx() then dereference a garbage rxr->rx_cpr?

The commit message says the fix for non-default RSS contexts is
deferred to a separate patchset. This patch makes the shrink reachable
in more configurations. Would it make sense to land that fix with this
one or before it?

> +
> +	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tcs;
> +	bnxt_set_cp_rings(bp, bp->flags & BNXT_FLAG_SHARED_RINGS);
>  }
>  
>  static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
> @@ -13144,7 +13236,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
>  	if (rc)
>  		return rc;
>  
> -	bnxt_adj_tx_rings(bp);
>  	rc = bnxt_alloc_mem(bp, irq_re_init);
>  	if (rc) {
>  		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);

[Severity: High]
This isn't a bug introduced by this patch, but it concerns the
allocation and freeing of bp->bnapi around this path. The
BNXT_STATE_READ_STATS handshake in bnxt_get_stats64() seems to track
only a single reader:

bnxt_get_stats64() {
	set_bit(BNXT_STATE_READ_STATS, &bp->state);
	...
	clear_bit(BNXT_STATE_READ_STATS, &bp->state);
}

Consider two readers:

- Reader A sets the bit and starts walking
  bp->bnapi[i]->cp_ring.stats.
- Reader B sets and clears the same bit while A is still reading.

__bnxt_close_nic() then sees bnxt_drv_busy() as false and frees the
memory:

	clear_bit(BNXT_STATE_OPEN, &bp->state);
	smp_mb__after_atomic();
	while (bnxt_drv_busy(bp))
		msleep(20);
	...
	bnxt_free_mem(bp, irq_re_init);

RTM_GETSTATS goes through rtnl_stats_get()->dev_get_stats() under RTNL
without rcu_read_lock(). So synchronize_net() in bnxt_del_napi() does
not wait for it.

The FW reset close path also runs under netdev_lock only, without RTNL:

bnxt_fw_reset_task()
  bnxt_fw_reset_close()
    __bnxt_close_nic()

Can reader A then access the freed bnapi and ring stats? Would a real
lock or RCU be a better fit here than the state bit?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016064427.496944-1-michael.chan%40broadcom.com
