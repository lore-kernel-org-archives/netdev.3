Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52630F540
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816523; cv=none; b=UOsa6TUW6pUtPyWxR974p3mpq6NdThSBDeaJXtarvpowYQUwj1jYfRcrCo/fqzuwQpszCOdBkwmxDUn3xX55o0ZEtXdHEZvAxrrVchDeyBepxqakilIfXgXRjgJObreQmSlcATZs7CGxRrCDyydye+vMcyGbGWCu1stJMA61F1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816523; c=relaxed/simple;
	bh=Bxvby+9zSBNs5CTtJMKh13l3rF2in6Feqmg0KrkbCQg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nYIlomVTz4cZInf3ErSBUP3mqCW0pHTRqmsWIs52zAJ5VqpVNvubSRBOJl1ErqJV7ey9PYT8v+5kRdIpv3mat9vwd9PGX+k1I1qq9zQRwGICBx123Shr74Rrv85cs9rSoMJg2bB/pdeZHuITZtlWINb6Hhbk2ZTSgkxvfHOmpss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKMsvGs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKMsvGs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B8B1F00899;
	Thu,  1 Oct 2026 01:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790816517;
	bh=n2AttnS75dzESB2HximjODlkzRG3/d3M96SP0ctR+JI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KKMsvGs7mfHu7Po5O43JbQUOT61BGare5h9TNa6WUGDpA193x2wriCXecCrneUC3y
	 f8jM2siKTSIAqQdEQydDBzxhnvWxDXzMNmJSZMa6z6cMtOh/Vm/y26RCrdwmY6KmlZ
	 8yO/XPTssygCkBrCOLsNkhhCuo+FCk0dEuR641zC6Sd248hRHZ07VbowyjUch9Tn8l
	 RBfAtFGnIzqKzfSsdgca2zozpGA4URvQ0wf3W6tcJi2HwiHggTG3uhYfSZezKhi2A0
	 VIbsmPa5tRHQ5UlJ8TSkNsFOtIPzsgrxouzs5mQf90ntXzeqKUDBZwaFDaY0/T45Tl
	 KlWFfa3pxA46A==
Subject: Re: [PATCH net v2 6/9] bnxt_en: Fix ring accounting and validation
 when rings are constrained
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, joe@dama.to,
 kalesh-anakkur.purayil@broadcom.com, scott.branden@broadcom.com
Date: Thu, 01 Oct 2026 01:01:56 +0000
Message-ID: <179081651631.434549.10407639155217796366@kernel.org>
In-Reply-To: <20260928041712.3467803-7-michael.chan@broadcom.com>
References: <20260928041712.3467803-7-michael.chan@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] NITRO_A0 regression: this patch makes bnxt_init_int_mode() call
  bnxt_adj_rings() every time.
- [Medium] bnxt_reserve_rings() gains a new branch, 'else if (irq_re_init
  && BNXT_NEW_RM(bp) && !rc)'.
- [Medium] With TCs and XDP both active, bnxt_trim_rings() converts the
  trimmed completion-ring count back to a TX count with…

--

bnxt_en: Fix ring accounting and validation when rings are constrained

This patch renames bnxt_adj_tx_rings() to bnxt_adj_rings(). The new
function rebalances TX, RX and CP rings for TCs, XDP and shared-ring
mode, and is called from __bnxt_reserve_rings() and bnxt_init_int_mode().
The patch also tightens bnxt_rings_ok() to check minimum ring counts,
and removes the TC reset error path from bnxt_reserve_rings().

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index bf902da945cb..8e4bde720ef5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -11680,19 +11723,56 @@ static int bnxt_init_int_mode(struct bnxt *bp)

[ ... ]

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

[Severity: Medium]
Can this check reject a configuration that bnxt_adj_rings() could still
rebalance?

When both TCs and XDP are active, bnxt_trim_rings() turns the trimmed
completion-ring count back into a TX count with bnxt_num_cp_to_tx():

    return (tx_cp - bp->tx_nr_rings_xdp) * tcs +
           bp->tx_nr_rings_xdp;

This keeps the original XDP ring count fixed.

For example, take num_tc = 2, XDP attached and 8 combined channels. That
gives tx = 24, xdp = 8 and tx_cp = 16. If total_vecs - ulp_msix is 5,
shared-mode trimming sets tx_cp = 5, and the TX count becomes
(5 - 8) * 2 + 8 = 2.

That is below min_tx = 3, so this path returns -ENOMEM with "Not enough
MSI-X to satisfy min. TX rings". But a balanced setup with
per_tc = xdp = rx = 2 (tx = 6, tx_cp = 4) fits in 5 vectors.

The same conversion feeds bnxt_rings_ok() in __bnxt_reserve_rings(), so
FW-constrained reservations would fail the same way.

The commit message says bnxt_adj_rings() "will now correctly scale down
TX rings for XDP and TCs evenly". That seems to hold only for mild
shrinkage. Should the minimum check run after rebalancing, or should the
conversion scale the XDP count too?

> +
> +	bnxt_adj_rings(bp);
>  
> +	if (!bnxt_nitro_a0_rings_ok(bp, bp->rx_nr_rings)) {
> +		netdev_err(bp->dev, "Not enough MSI-X to satisfy min. RX rings\n");
> +		rc = -ENOMEM;
> +		goto msix_setup_exit_restore;
> +	}

[Severity: High]
Does this break NITRO_A0 chips at probe time?

After computing the shared-ring defaults, bnxt_set_dflt_rings() adds an
extra RX ring and an extra CP ring for this chip:

    if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
        bp->rx_nr_rings++;
        bp->cp_nr_rings++;
    }

NITRO_A0 always runs in shared mode. bnxt_init_int_mode() now always
calls bnxt_adj_rings(), and its shared branch does:

    bp->tx_nr_rings_per_tc = min(bp->tx_nr_rings_per_tc, rx);
    bp->rx_nr_rings = bp->tx_nr_rings_per_tc;

With a default ring count of N, rx drops from N + 1 back to N, and
bnxt_set_cp_rings() recomputes cp_nr_rings as N. By the time
bnxt_nitro_a0_rings_ok() runs, the extra ring is already gone.

With N == 1 (a kdump kernel, or a single-queue system), rx becomes 1,
bnxt_nitro_a0_rings_ok() fails, and probe returns -ENOMEM. The same
setup probed successfully before this patch.

With N >= 2, bnxt_init_napi() still gives the last bnapi to the special
handler:

    if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
        bnapi = bp->bnapi[cp_nr_rings];
        netif_napi_add_locked(bp->dev, &bnapi->napi, bnxt_poll_nitroa0);

In shared mode, bnxt_alloc_mem() now also puts regular TX ring N - 1 on
that bnapi. bnxt_poll_nitroa0() doesn't process TX completions; it only
logs "Invalid completion received on special ring" for them.

Would that TX queue then stall until the TX watchdog fires?

There are smaller effects as well. The default RSS table loses a ring.
bnxt_get_channels() reports rx_nr_rings - 1 combined channels, one fewer
than configured. Every probe also prints a spurious "RX rings reduced"
warning.

The commit message says "The special NITRO_A0 minimum requirement is
handled by a new helper in bnxt_init_int_mode() only". Should
bnxt_adj_rings() account for the extra RX ring on this chip instead?

[ ... ]

> @@ -11740,7 +11818,6 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  	irqs_required = bnxt_irqs_required(bp);
>  
>  	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
> -		irq_change = true;
>  		if (!pci_msix_can_alloc_dyn(bp->pdev) || !bp->irq_tbl) {
>  			bnxt_ulp_irq_stop(bp);
>  			bnxt_clear_int_mode(bp);
> @@ -11752,25 +11829,17 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  		if (!rc)
>  			rc = bnxt_init_int_mode(bp);
>  		bnxt_ulp_irq_restart(bp, rc);
> -	} else if (irq_change && !rc) {
> -		if (bnxt_change_msix(bp, irqs_required) != irqs_required)
> +	} else if (irq_re_init && BNXT_NEW_RM(bp) && !rc) {
> +		/* __bnxt_reserve_rings() may have shrunk the rings */
> +		irqs_required = bnxt_irqs_required(bp);
> +		if (irqs_required != bp->total_irqs &&
> +		    bnxt_change_msix(bp, irqs_required) != irqs_required)
>  			rc = -ENOSPC;
>  	}

[Severity: Medium]
Can this new branch call bnxt_change_msix() on a device that doesn't
support dynamic MSI-X allocation?

Before this patch, bnxt_change_msix() was only reached through
irq_change. That meant the first branch had already seen
pci_msix_can_alloc_dyn() && bp->irq_tbl; otherwise the clear/re-init
path ran instead. The new condition drops that check.

Take a NEW_RM device without dynamic MSI-X support where the initial
irqs_required equals bp->total_irqs, so irq_cleared stays false. Suppose
__bnxt_reserve_rings() then shrinks the rings: FW grants fewer, and
bnxt_adj_rings() runs because bp->bnapi is NULL. The recomputed
irqs_required drops, and bnxt_change_msix() enters its trim loop:

    for (i = bp->total_irqs; i > total; i--) {
        map.index = i - 1;
        map.virq = bp->irq_tbl[i - 1].vector;
        pci_msix_free_irq(bp->pdev, map);
        bp->total_irqs--;
    }

pci_msix_free_irq() starts with:

    if (WARN_ON_ONCE(!pci_msix_can_alloc_dyn(dev)))
        return;

So the vector is never freed, but bp->total_irqs is still decremented.
bnxt_change_msix() then returns a value equal to irqs_required, and no
error is reported.

Wouldn't this trigger the WARN and leave bp->total_irqs lower than the
number of vectors the PCI core has actually allocated? Should this
branch also check pci_msix_can_alloc_dyn(), or fall back to the
clear/re-init path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928041712.3467803-1-michael.chan%40broadcom.com
