Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F297D370AF5
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327997; cv=none; b=W8Zoy492pkDKSIGG98jADN5G6c+ZUZtta9jN3gDM7byMwd9kcWKxIrmQn6VBQHdJ2WNf0WISJl/i/cUEdGOLUhF6fD9Utmq1uziDa1tRTBthWH90R4NZTJJzI62Zp8l79vJ0dE+UemaZ8Va4cfs9c73SUIwBAy/rfzZ88bt4XYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327997; c=relaxed/simple;
	bh=HRSOz7rQx1SJSADljNwXUJRLH1fycpOMr8eVM0/5K7s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ttg7fljwgKJ10cNJvGH97e85dk/0aJ/82OZRhyAH4W+1BjyU5LR9MG1mKOPx2FHATiA30n0fLx2SdmEOHbrVdSkxrC0VIdoXqed6VPtv+CTrqohLe4Io/Gc8LOmW8Fo7Hr+eNts5tEihBKb/pmsLc1tN1aGFBswZjyUqibPVLFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIQYAeSR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIQYAeSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1BB1F000E9;
	Wed,  2 Sep 2026 05:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327995;
	bh=2YSK7GaYEo81DDo1+3OihOm4d8Ocw/fHifBZqtjr/MU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MIQYAeSRkdGC10KkehzpEekIvtEQlYsE6R+VB01mjxjDY18oOGu9NuiW/Hm6w5plY
	 lSFSBiridxMBqJ6Qh5R2ylCxi+Qey970iwXuKckvSVmCU4kJ2dZ/Uuh5cITcxjtXGg
	 qirZTyQkgs3yRVid5oy70NcqdIE1uZr7HSTlObG6g3yF71dpx/vr0hpa8xNVi1p5k+
	 n8gMYkBVC+pCuEnMSMMtaebOEBQOIMJWXJMbO/s2VBFoeBZziIWuK30IAOIuWTKESE
	 odZrtVeiwr2DOeeRbLZfsFXukBb3vh+xbZ5BPaGUmcEIbE5iOVOwrYfvQuNhrrqKAE
	 vmHAHxmJ8JxqQ==
Subject: Re: [net,1/4] bnxt_en: Fix ring accounting underflow when rings are
 constrained
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 kalesh-anakkur.purayil@broadcom.com, scott.branden@broadcom.com
Date: Wed, 02 Sep 2026 05:46:34 +0000
Message-ID: <178832799404.3394541.4960261764775066999@kernel.org>
In-Reply-To: <20260831024342.2161156-2-michael.chan@broadcom.com>
References: <20260831024342.2161156-2-michael.chan@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0

- [High] bnxt_adj_tx_rings()
  (drivers/net/ethernet/broadcom/bnxt/bnxt.c:13214) now scales…
- [Medium] The patch deletes the only unwind of the netdev/driver TC
  configuration from bnxt_reserve_rings() (the 'tx ring reservation…

Pre-existing issues:
- [Medium] bnxt_adj_tx_rings() lowers bp->tx_nr_rings (leftover reserved
  rings are, per the new commit message, 'intentionally left unused')…

--

bnxt_en: Fix ring accounting underflow when rings are constrained

The patch reworks bnxt_adj_tx_rings() to scale the XDP and per-TC TX ring
counts down evenly when fewer TX rings were reserved than requested, adds
a minimum TX ring requirement to bnxt_rings_ok(), moves that check earlier
in __bnxt_reserve_rings(), and drops the TC reservation failure path at the
end of bnxt_reserve_rings().

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810051358.1244418-7-michael.chan@broadcom.com

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d59bcca73a2b..219a6f551f1d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -8135,8 +8135,14 @@ static void bnxt_copy_reserved_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
>  
>  static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
>  {
> -	return hwr->tx && hwr->rx && hwr->cp && hwr->grp && hwr->vnic &&
> -	       hwr->stat && (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
> +	int min_tx = bp->num_tc ? bp->num_tc : 1;
> +
> +	if (bp->tx_nr_rings_xdp)
> +		min_tx++;
> +
> +	return hwr->tx >= min_tx && hwr->rx && hwr->cp && hwr->grp &&
> +	       hwr->vnic && hwr->stat &&
> +	       (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
>  }

[ ... ]

> @@ -11701,17 +11709,6 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  		netdev_err(bp->dev, "ring reservation/IRQ init failure rc: %d\n", rc);
>  		return rc;
>  	}
> -	if (tcs && (bp->tx_nr_rings_per_tc * tcs !=
> -		    bp->tx_nr_rings - bp->tx_nr_rings_xdp)) {
> -		netdev_err(bp->dev, "tx ring reservation failure\n");
> -		netdev_reset_tc(bp->dev);
> -		bp->num_tc = 0;
> -		if (bp->tx_nr_rings_xdp)
> -			bp->tx_nr_rings_per_tc = bp->tx_nr_rings_xdp;
> -		else
> -			bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
> -		return -ENOMEM;
> -	}
>  	return 0;
>  }

[Severity: Medium]
This removed block was the only place that reset the TC configuration when
the reservation could not back the configured traffic classes.  Can dropping
it leave bp->num_tc permanently set after a failed reservation?

bnxt_setup_mq_tc() commits the configuration before the reservation happens:

	netdev_set_num_tc(dev, tc);
	bp->num_tc = tc;
	...
	if (netif_running(bp->dev))
		return bnxt_open_nic(bp, true, false);

and has no unwind of its own.  Its pre-flight bnxt_check_rings() only checks
against maximum resources, not against what the firmware will actually
reserve.  If the reservation later yields hwr.tx < bp->num_tc (+1 for XDP),
the new bnxt_rings_ok() check in __bnxt_reserve_rings() now returns -ENOMEM
before any software state is touched, so bp->num_tc stays at tc.

Since bnxt_setup_mq_tc() is the only place in the driver that ever assigns
bp->num_tc, does bnxt_rings_ok() then keep computing min_tx = bp->num_tc,
making every subsequent ifup fail with -ENOMEM until the mqprio
configuration is torn down?

There also seems to be a divergence between driver and core state on the
mqprio path.  When mqprio_init() propagates the error, qdisc_create() calls
mqprio_destroy(), which with priv->hw_offload == 0 does:

net/sched/sch_mqprio.c:mqprio_destroy() {
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
}

That leaves dev->num_tc == 0 while bp->num_tc == tc and bp->tx_nr_rings is
still sized for tc traffic classes.  On a later successful open, the
netdev_set_tc_queue() calls in bnxt_setup_msix() then have no traffic
classes to program while the driver still lays out rings per TC.  Was that
resync intentional to drop?

> @@ -13216,11 +13213,17 @@ static void bnxt_set_xdp_tx_rings(struct bnxt *bp)
>  
>  static void bnxt_adj_tx_rings(struct bnxt *bp)
>  {
> +	int tcs = bp->num_tc ? bp->num_tc : 1;
> +
>  	/* Make adjustments if reserved TX rings are less than requested */
> -	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
> -	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
> -	if (bp->tx_nr_rings_xdp)
> -		bnxt_set_xdp_tx_rings(bp);
> +	if (bp->tx_nr_rings_xdp) {
> +		tcs++;
> +		bp->tx_nr_rings_per_tc = bp->tx_nr_rings / tcs;
> +		bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;

[Severity: High]
bp->tx_nr_rings_xdp is lowered here, but bp->rx_nr_rings is left untouched.
Can that break the 1:1 XDP TX ring to RX ring mapping the commit message
relies on?

bnxt_xdp_set() establishes the invariant:

drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c:bnxt_xdp_set() {
	...
	bp->tx_nr_rings_xdp = tx_xdp;		/* tx_xdp = bp->rx_nr_rings */
}

and bnxt_alloc_mem() only installs XDP TX rings for the first
bp->tx_nr_rings_xdp bnapi entries:

			if (i >= bp->tx_nr_rings_xdp) {
				int k = j + BNXT_RING_TO_TC_OFF(bp, i);

				bnapi2 = bp->bnapi[k];
				...
				bnapi2->tx_int = bnxt_tx_int;
			} else {
				bnapi2 = bp->bnapi[j];
				bnapi2->flags |= BNXT_NAPI_FLAG_XDP;
				bnapi2->tx_ring[0] = txr;
				bnapi2->tx_int = bnxt_tx_int_xdp;

Meanwhile every RX ring still gets the program in bnxt_init_one_rx_ring():

	if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
		bpf_prog_add(bp->xdp_prog, 1);
		rxr->xdp_prog = bp->xdp_prog;
	}

and bnxt_rx_xdp() uses the paired TX ring unconditionally:

drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c:bnxt_rx_xdp() {
	txr = rxr->bnapi->tx_ring[0];
	...
}

Walking a P5+ combined-ring case with num_tc = 0, rx_nr_rings = 8 and XDP
attached (requested tx_nr_rings_xdp = 8, tx_nr_rings = 16):

Firmware reserves hwr.tx = 10.  The new min_tx in bnxt_rings_ok() is
1 + 1 = 2, so the reservation is accepted and bp->tx_nr_rings = 10 with
bp->rx_nr_rings = 8.  Here tcs = 2, so tx_nr_rings_per_tc = 5 and
tx_nr_rings_xdp = 5.  In bnxt_alloc_mem() the regular rings i in [5,10) map
to k = 5..9, so bnapi[5..7] own both an RX ring and a stack TX ring in
tx_ring[0].  RX rings 5-7 then run XDP on a stack-owned TX ring with no txq
lock, and __bnxt_tx_int() sees tx_buf->skb == NULL and calls
bnxt_sched_reset_txr().

Firmware reserves hwr.tx = 6.  Now tx_nr_rings_per_tc = tx_nr_rings_xdp = 3
and bp->tx_nr_rings = 6, while rx_nr_rings is still 8.  The regular rings
map to bnapi[3..5], so bnapi[6] and bnapi[7] get no TX ring at all and
rxr->bnapi->tx_ring[0] is NULL for RX rings 6 and 7.  Does the first packet
received on those rings then oops in bnxt_rx_xdp() via bnxt_tx_avail(),
which reads txr->tx_prod?

Before this patch this second reservation produced a negative
bp->tx_nr_rings whose allocation in bnxt_alloc_mem() failed and aborted the
open, so the device did not reach this state.

Nothing between bnxt_adj_tx_rings() and the data path re-establishes the
invariant: __bnxt_open_nic() calls bnxt_adj_tx_rings() and then
bnxt_alloc_mem() directly, and the only place that resyncs rx_nr_rings to
tx_nr_rings_per_tc is bnxt_trim_dflt_sh_rings()/bnxt_adj_dflt_rings() on the
probe/default-rings path:

	bp->cp_nr_rings = min_t(int, bp->tx_nr_rings_per_tc, bp->rx_nr_rings);
	bp->rx_nr_rings = bp->cp_nr_rings;

Would it work to have bnxt_rings_ok() require num_tc rings plus
bp->rx_nr_rings XDP rings, or to trim bp->rx_nr_rings down to
bp->tx_nr_rings_per_tc here?

> +	} else {
> +		bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
> +	}
> +	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tcs;

[Severity: Medium]
This isn't a bug introduced by this patch, but bp->tx_nr_rings is reduced
here while bp->cp_nr_rings keeps the value __bnxt_reserve_rings() derived
from the un-adjusted hwr.tx:

	tx_cp = bnxt_num_tx_to_cp(bp, hwr.tx);
	hwr.cp = sh ? max_t(int, tx_cp, rx_rings) : tx_cp + rx_rings;
	...
	bp->cp_nr_rings = hwr.cp;

Nothing recomputes it in the open path, since __bnxt_open_nic() calls
bnxt_adj_tx_rings() and then bnxt_alloc_mem(); only the probe path re-runs
bnxt_adj_dflt_rings()/bnxt_set_cp_rings().  Should bnxt_adj_tx_rings() also
resync bp->cp_nr_rings now that leftover rings are "intentionally left
unused"?

With P5+, combined rings, num_tc = 0, rx = 8, requested xdp = 8 and reserved
hwr.tx = 11: tx_cp = (11 - 8) + 8 = 11 so bp->cp_nr_rings = 11, while
bnxt_adj_tx_rings() gives tx_nr_rings_per_tc = tx_nr_rings_xdp = 5 and
bp->tx_nr_rings = 10.  For i = 10 in bnxt_alloc_all_cp_arrays() neither the
rx branch nor the tx branch applies, so cp_count is 0 and:

		cpr->cp_ring_arr = kzalloc_objs(*cpr, cp_count);
		if (!cpr->cp_ring_arr)
			return -ENOMEM;
		cpr->cp_ring_count = cp_count;

returns ZERO_SIZE_PTR, which passes the NULL check.  Besides the wasted
MSIX/NQ/stat context, bnxt_poll_p5() reads that array unguarded at its
poll_done label:

poll_done:
	cpr_rx = &cpr->cp_ring_arr[0];
	if (cpr_rx->cp_ring_type == BNXT_NQ_HDL_TYPE_RX &&

so anything that polls every NAPI of the device, such as netpoll's
poll_napi(), would dereference ZERO_SIZE_PTR.  The pre-patch code shrank
bp->tx_nr_rings even more aggressively and produced the same cp_count == 0
contexts.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831024342.2161156-1-michael.chan%40broadcom.com
