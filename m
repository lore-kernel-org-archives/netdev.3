Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024854B1B8
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932499; cv=none; b=fpPbUgjf3ngxfTjxTpRJZ1yWAwpZ4CnxVrHPBO+WjeyWp8GZwxlBqZsRfbG5FVFWTkRisvxd0514qlerKiXymOBcCQXWaHpZx2dLEY/6+3zpaCLIBAxB/ulMgo0pCmLcZBj7ExEvCXG0EInc0JN2yvwPgtT4rBpl/o7y7XRviGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932499; c=relaxed/simple;
	bh=7DmAygeQLoFtDgrmLC30f8geW1Oko0wdxABUD17iri4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4r66sIhVKfsbVhfgoRyknc+rltmxTHtDKIGPatofZoPjnjGPVzD+vOmTw9kHnpZFegCsjHaKcOafAx+Ydr2sg1sgDK4yvSGv59LMrJcUYMDg4EYkLwS/yMK3JWIPzXWbwDjdNd5zsgzFmxojDKnPrvNZM30jim4CLhTo9WkvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl3pzmZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl3pzmZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B911F000FF;
	Tue, 13 Oct 2026 23:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932498;
	bh=Tf1zYJ5/Q7UFWgn71lCNImwGk8TnyDNxLE1gKJz+4kA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Nl3pzmZwiuU1jji0oU5eLCwJE4NUuVnnnql4lB6ximOxsSHiBRiboD6M1+skhBG9e
	 6pHiQZEjicA5uue6j3tdy7NSMoDbc/3iIePsdB7tdq7AGWLyDKJ6XZmowjvRgnMZNo
	 liJ2KCih4eb43G0sxTKvL2Y3voTQ+hOT4vpZ6OVnlZsSP03WpEeeMjK+1IBnhMIJ6H
	 OcF5JqiYCdNF1fvu1vd7Ml3PwEp/kgAspmP2NPRzr5xZGkv1Hnyvo3KinmgUm+b636
	 mjQz3npDfA48G/dy3xe7bCUbdw6TD4gdvQ6WbAihXqNiYnuHnpG5b3/VYtXu5G0U32
	 3E8wXGPQHqsZA==
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: Fix ring accounting and
 validation when rings are constrained
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Date: Tue, 13 Oct 2026 23:01:37 +0000
Message-ID: <179193249717.434549.8103445657077169884@kernel.org>
In-Reply-To: <20261012220827.340998-8-michael.chan@broadcom.com>
References: <20261012220827.340998-8-michael.chan@broadcom.com>
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
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bnxt_reserve_rings() has a new branch, `else if (irq_re_init &&
  BNXT_NEW_RM(bp) && !rc)`, that can call bnxt_change_msix() while…
- [Medium] In bnxt_reserve_rings()'s callees, __bnxt_reserve_rings() and
  bnxt_init_int_mode(), bnxt_trim_rings() still runs before…

Pre-existing issues:
- [High] The patch adds a new way for RX rings to shrink, and that path
  reaches an existing out-of-bounds access.

--

bnxt_en: Fix ring accounting and validation when rings are constrained

This patch renames bnxt_adj_tx_rings() to bnxt_adj_rings(). TX, RX and CP
rings are now scaled down together for XDP, TCs and shared rings, and
bnxt_rings_ok() now checks for a minimum viable ring layout. The
adjustment is centralized in __bnxt_reserve_rings() and
bnxt_init_int_mode(), and bnxt_reserve_rings() recomputes the required
IRQs after the rings may have shrunk.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index ed3f67dea0306..cbf7aef1d5b82 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -11530,19 +11573,50 @@ static int bnxt_init_int_mode(struct bnxt *bp)
>  		bp->irq_tbl[i].vector = pci_irq_vector(bp->pdev, i);
>  
>  	bp->total_irqs = total_vecs;
> +	req_tx_rings = bp->tx_nr_rings;
> +	req_tx_per_tc = bp->tx_nr_rings_per_tc;
> +	req_tx_xdp = bp->tx_nr_rings_xdp;
> +	req_rx_rings = bp->rx_nr_rings;
> +	req_cp_rings = bp->cp_nr_rings;
> +
>  	/* Trim rings based upon num of vectors allocated */
>  	rc = bnxt_trim_rings(bp, &bp->rx_nr_rings, &bp->tx_nr_rings,
>  			     total_vecs - ulp_msix, min == 1);
>  	if (rc)
>  		goto msix_setup_exit;
>  
> -	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
> -	bp->cp_nr_rings = (min == 1) ?
> -			  max_t(int, tx_cp, bp->rx_nr_rings) :
> -			  tx_cp + bp->rx_nr_rings;
> +	min_tx = bp->tx_nr_rings_xdp ? tcs + 1 : tcs;
> +	if (bp->tx_nr_rings < min_tx) {
> +		netdev_err(bp->dev, "Not enough MSI-X to satisfy min. TX rings\n");
> +		rc = -ENOMEM;
> +		goto msix_setup_exit_restore;
> +	}
> +
> +	bnxt_adj_rings(bp);

[Severity: Medium]
Can the TX count returned by bnxt_trim_rings() be negative or too small
here when XDP and mqprio TCs are both in use?

bnxt_trim_rings() still runs before bnxt_adj_rings(). When it trims the CP
count, it converts back to a TX count with:

bnxt_num_cp_to_tx() {
	int tcs = bp->num_tc;

	return (tx_cp - bp->tx_nr_rings_xdp) * tcs +
	       bp->tx_nr_rings_xdp;
}

This uses the untrimmed tx_nr_rings_xdp. Take num_tc=2 with XDP,
per_tc=8, xdp=8 and tx=24, so tx_cp is 16. With a limit of 5, tx becomes
(5 - 8) * 2 + 8 = 2. That is below min_tx = 3, so this returns -ENOMEM.

The layout per_tc=2, xdp=2, tx=6, rx=2 needs only cp = max(4, 2) = 4,
which fits in 5.

The result is also not monotonic. A limit of 6 gives tx=4, which
bnxt_adj_rings() turns into a valid per_tc=1 layout, but limits of 5
and 4 both fail.

__bnxt_reserve_rings() has the same trim. The hwr.tx it produces is then
rejected by the new bnxt_rings_ok() check.

The commit message says:

    It will now correctly scale down TX rings for XDP and TCs evenly.

Should the trim path also scale the XDP rings down, rather than failing
with -ENOMEM when a smaller valid layout exists?

> +
> +	if (bp->bnapi && (req_tx_rings != bp->tx_nr_rings ||
> +			  req_rx_rings != bp->rx_nr_rings)) {

[ ... ]

> @@ -11590,7 +11662,6 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  	irqs_required = bnxt_irqs_required(bp);
>  
>  	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
> -		irq_change = true;
>  		if (!pci_msix_can_alloc_dyn(bp->pdev) || !bp->irq_tbl) {
>  			bnxt_ulp_irq_stop(bp);
>  			bnxt_clear_int_mode(bp);
> @@ -11602,25 +11673,23 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  		if (!rc)
>  			rc = bnxt_init_int_mode(bp);
>  		bnxt_ulp_irq_restart(bp, rc);
> -	} else if (irq_change && !rc) {
> -		if (bnxt_change_msix(bp, irqs_required) != irqs_required)
> -			rc = -ENOSPC;
> +	} else if (irq_re_init && BNXT_NEW_RM(bp) && !rc) {
> +		/* __bnxt_reserve_rings() may have shrunk the rings */
> +		irqs_required = bnxt_irqs_required(bp);
> +		if (irqs_required != bp->total_irqs) {
> +			/* Don't bother reducing static IRQs to avoid disrupting
> +			 * RoCE.
> +			 */
> +			if (pci_msix_can_alloc_dyn(bp->pdev) &&
> +			    bnxt_change_msix(bp, irqs_required) !=
> +			    irqs_required)
> +				rc = -ENOSPC;

[Severity: High]
Can this new branch be reached while bp->irq_tbl is NULL?

bnxt_clear_int_mode() frees the vectors and irq_tbl but does not reset
bp->total_irqs:

bnxt_clear_int_mode() {
	pci_free_irq_vectors(bp->pdev);

	kfree(bp->irq_tbl);
	bp->irq_tbl = NULL;
	bp->irq_tbl_size = 0;
}

If the ring config has not changed, irqs_required still equals the stale
bp->total_irqs at the first check, so irq_cleared stays false.

__bnxt_reserve_rings() can then shrink the rings, since bnapi is NULL and
bnxt_adj_rings() runs. After that, the recomputed irqs_required differs
from total_irqs and this calls bnxt_change_msix(), which returns early:

bnxt_change_msix() {
	if (!bp->irq_tbl)
		return 0;
	...
}

So rc becomes -ENOSPC whenever pci_msix_can_alloc_dyn() is true.

Before this patch, irq_change was set only when the first comparison
mismatched. With a NULL irq_tbl, that always took the irq_cleared path,
so bnxt_change_msix() was never called without a table.

Two paths appear to reach this state. The first is AER recovery:

bnxt_io_slot_reset()
    bnxt_clear_int_mode()
    (reservations cleared)
bnxt_io_resume()
    err = bnxt_reserve_rings(bp, true);
    if (!err && !bp->irq_tbl)
        err = bnxt_init_int_mode(bp);

The second is bnxt_hwrm_if_change() on a FW reset or caps change. It
calls bnxt_clear_int_mode() and bnxt_cancel_reservations() before
__bnxt_open_nic()->bnxt_reserve_rings(bp, true).

If firmware grants fewer rings after the reset, does bnxt_io_resume()
skip netif_device_attach() and leave the device detached? On the FW
reset path, does bnxt_open() fail?

Would adding a bp->irq_tbl check to this condition, or resetting
bp->total_irqs in bnxt_clear_int_mode(), avoid this?

> +		}
>  	}

[ ... ]

> @@ -13118,13 +13187,29 @@ static void bnxt_set_xdp_tx_rings(struct bnxt *bp)
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

[Severity: High]
This is a pre-existing issue, but this clamp is a new way for the RX
rings to shrink, and it leads to an existing out-of-bounds access through
non-default RSS contexts.

In shared mode, a shortfall in TX alone now reduces RX. For example, with
TCs=2, 8 combined channels, and FW granting 8 of 16 TX rings, RX drops
from 8 to 4. The old bnxt_adj_tx_rings() left RX unchanged in this case.

bnxt_check_rss_tbl_lost() and bnxt_get_max_rss_ring() only look at the
default bp->rss_indir_tbl. Additional RSS contexts created with
"ethtool -X ... context N" keep their old indices.

On the next open, bnxt_alloc_mem() sizes bp->rx_ring[] from the smaller
rx_nr_rings, and then:

bnxt_hwrm_realloc_rss_ctx_vnic()
  __bnxt_setup_vnic_p5()
    bnxt_fill_hw_rss_tbl_p5()
		else if (vnic->flags & BNXT_VNIC_RSSCTX_FLAG)
			j = ethtool_rxfh_context_indir(vnic->rss_ctx)[i];
		...
		rxr = &bp->rx_ring[j];

		ring_id = rxr->rx_ring_struct.fw_ring_id;
		*ring_tbl++ = cpu_to_le16(ring_id);
		ring_id = bnxt_cp_ring_for_rx(bp, rxr);

Does this read past the end of bp->rx_ring[] on P5+ chips? It would then
dereference rxr->rx_cpr taken from out-of-bounds memory and write garbage
ring IDs into the hardware RSS table.

The commit message says the RSS context and n-tuple filter problems on RX
shrink will be fixed in a separate patchset. This patch makes the shrink
reachable in TX-constrained combined-mode setups that used to keep RX
intact. Should that fix land together with this one?

> +		if (bp->tx_nr_rings_xdp)
> +			bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
> +	}
> +
> +	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tcs;
> +	bnxt_set_cp_rings(bp, bp->flags & BNXT_FLAG_SHARED_RINGS);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012220827.340998-1-michael.chan%40broadcom.com
