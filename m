Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793535039;
	b=1gED/VvhlTim+K1GgAndvR2PbvGYsBnzjG+tpoUy2iq0CvOCcqMGPgNRvFA3Hoeq1Gb7
	 SieDzbm36bfcQTjShWMxB4txxa9bgk/KfNYJt7siKpIPwE3JYkShZ/MX7BW+NtG+B2WhH
	 NHfEiTP7+8HiTZBZjPX5EI2iy2ElYaddHE+dz7rWj689Cro+2rTimh9Sa85kH0cKUGoZo
	 8DR+LS4A8e9EtN53O9+jtMFNr0T/FYdIYROB3Of/+FyzdtEPeIMYtyPpsFt4cbj6riOXB
	 aSMLoGBIs9gERbFB3hwZ3Vbejnql2Rs3BXZ+TAp9hvkoKzfdFhQ3pVufggnvKYyl6ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793535039;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3CAGqxHDzH5gPKRDzvc+9sP4UxKCwz3ISyZgTHK2sZo=;
	b=HjJmi5nVcLXPd4mbvNXTSt1DPO8lbFe4lyRkWG7ASZXECS5LnJEaVJaXRbbkl1gt0wBI
	 oUnt5k6owRO7WSjhw8eP0k4jjFtrm10NcJCbeMe1t4HKoV/mW7H4aL36kNx+aqnHKqk9/
	 bQzff50gngYGW6IxLV7TrRSSpANfUZmwR8fM3iU6ym0XJv9zetrZyxk1Uw7Uu/iKXUmpV
	 GxfFHhxrbgiWKDG5u1REbZYlSVMByoA29J5yyun4EchWlzt/hoIhWQb48+BhEBJiT/sQm
	 dN2h1+xyqB2BEoSVT36S8vQG1BqFbgApEURUcfZY+70ynjbvOu8xHmbo71lGlIojhYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhB79Tip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC3606A324;
	Sun,  1 Nov 2026 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhB79Tip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2E81F000C1;
	Sun,  1 Nov 2026 12:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793535038;
	bh=3CAGqxHDzH5gPKRDzvc+9sP4UxKCwz3ISyZgTHK2sZo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NhB79TipwC2CEPOKxsNWnxP3JcwDiaCmCs+jmnRZPE8MVOmTserHlpl/QchLpelw8
	 dH904Qxjj/cz45cPF9yY4EVYipFagPJ/hKjECdgbudyaEcdKLxHNIL15RTdaF0NwOq
	 q0AuxV9Wzmm0tCVF9AqqnSPwaJY/HWCH71eled6+XesY7LBXz1BpNMdfB9Z9ZKSvDJ
	 /1VOE/LZMR6qvOHjlDk7tQY2b3MDwbzx3J2K2rRZ7v4UCkf/w5tQ0LCYXq+rIY/rtq
	 Ju5jDXWGuYfEoftWWvBa5Q2746SKZ2sEjWLb61s2AhN/UTpNP3vrLkOSr0Ew2mHpy1
	 0l55a7Wvi0kMw==
Subject: Re: [PATCH net v2] bnxt_en: Don't keep MSI-X vectors added before FW
 reserves them
From: netdev-bot+sashiko@kernel.org
To: vlad.wing@gmail.com
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew.gospodarek@broadcom.com, tglx@kernel.org, maz@kernel.org,
 yangjinqian1@huawei.com, apreece@meta.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Sun, 01 Nov 2026 12:10:37 +0000
Message-ID: <179353503740.3131.17689939110178639939@kernel.org>
In-Reply-To: <20261028114933.256298-1-vlad.wing@gmail.com>
References: <20261028114933.256298-1-vlad.wing@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In bnxt_reserve_rings()
  (drivers/net/ethernet/broadcom/bnxt/bnxt.c), the new recompute in the…
- [Low] With BNXT_NEW_RM, bnxt_check_rings() now allocates the extra
  dynamic MSI-X vectors only to test availability, then frees them at…

Pre-existing issues:
- [High] bnxt_clear_int_mode() frees the vectors and sets bp->irq_tbl =
  NULL but leaves bp->total_irqs stale.
- [Medium] bnxt_hwrm_check_pf_rings() does not check the return value of
  __bnxt_hwrm_reserve_pf_rings().

--

bnxt_en: Don't keep MSI-X vectors added before FW reserves them

When BNXT_NEW_RM is set, bnxt_check_rings() now frees the dynamically
allocated MSI-X vectors right after the availability check.
bnxt_reserve_rings() then allocates them after __bnxt_reserve_rings(),
sized from bnxt_get_num_msix(). It also grows the vectors when no
reservation is needed but FW already holds one, and clears
irq_tbl[].vector when trimming.

Closes: https://lore.kernel.org/all/20261022193620.2152038-1-vlad.wing@gmail.com/

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 0682060b048ce..55b11c7684313 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -11701,8 +11702,23 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  	int irqs_required;
>  	int rc;
>  
> -	if (!bnxt_need_reserve_rings(bp))
> +	if (!bnxt_need_reserve_rings(bp)) {
> +		/* FW may already hold the reservation from an earlier
> +		 * reservation that was not followed by growing the dynamic
> +		 * MSI-X vectors, e.g. because the allocation failed.
> +		 */
> +		if (irq_re_init && BNXT_NEW_RM(bp) && bp->irq_tbl &&
> +		    pci_msix_can_alloc_dyn(bp->pdev)) {

[ ... ]

> @@ -11728,6 +11744,10 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  			rc = bnxt_init_int_mode(bp);
>  		bnxt_ulp_irq_restart(bp, rc);
>  	} else if (irq_change && !rc) {
> +		/* Size the vectors from what FW actually reserved, which
> +		 * can be less than what was requested.
> +		 */
> +		irqs_required = bnxt_get_num_msix(bp);

[Severity: Medium]
The comment says this sizes the vectors from what FW actually reserved.
Under BNXT_NEW_RM, though, bnxt_get_num_msix() returns
bnxt_nq_rings_in_use(), which is bp->cp_nr_rings +
bnxt_get_ulp_msix_num(bp). It is not hw_resc->resv_irqs.

Can this still activate unreserved MSI-X entries when the RoCE driver is
registered?

In __bnxt_reserve_rings(), the FW IRQ grant (copied into hwr.cp by
bnxt_copy_reserved_rings()) only bounds the L2 count:

	hwr.cp = min_t(int, hwr.cp, bp->cp_nr_rings);

The re-clamp of the ULP vectors against resv_irqs is skipped when a ULP
is registered:

	if (!bnxt_ulp_registered(edev) && BNXT_NEW_RM(bp)) {
		...
		resv_msix = hw_resc->resv_irqs - bp->cp_nr_rings;
		ulp_msix = min_t(int, resv_msix, ulp_msix);
		bnxt_set_ulp_msix_num(bp, ulp_msix);

Take 8 ULP vectors, 32 L2 NQs and a FW grant of resv_irqs = 34.
bnxt_get_num_msix() returns 40, and bnxt_change_msix(bp, 40) activates
entries 34-39 while rc stays 0.

bnxt_alloc_cp_rings() maps L2 NQ i to MSI-X index ulp_msix + i. That
puts L2 NQs 26-31 on entries FW never reserved, which is the
lost-completion case this patch is fixing.

The commit message limits this with "at least while no RoCE driver is
registered" and says the accounting predates the patch. The in-code
comment doesn't mention the RoCE case.

Could the sizing be bounded by hw_resc->resv_irqs here? Or could the
registered ULP vectors be counted against resv_irqs in
__bnxt_reserve_rings()?

>  		if (bnxt_change_msix(bp, irqs_required) != irqs_required)
>  			rc = -ENOSPC;
>  	}

[Severity: High]
This is a pre-existing issue, but can this branch call bnxt_change_msix()
while bp->irq_tbl is NULL?

bnxt_clear_int_mode() frees the table but leaves bp->total_irqs as it
is:

static void bnxt_clear_int_mode(struct bnxt *bp)
{
	pci_free_irq_vectors(bp->pdev);

	kfree(bp->irq_tbl);
	bp->irq_tbl = NULL;
}

It is called from bnxt_hwrm_if_change() on fw_reset or caps_change, just
before bnxt_cancel_reservations(). It is also called from
bnxt_io_slot_reset().

The next bnxt_reserve_rings(bp, true) call comes from __bnxt_open_nic()
or bnxt_io_resume(). At that point bnxt_need_reserve_rings() is true and
pci_msix_can_alloc_dyn() is still true. So irq_change is set whenever
irqs_required differs from the stale bp->total_irqs.

If the count passed to bnxt_change_msix() is below the stale
bp->total_irqs, the trim loop then runs through a NULL bp->irq_tbl:

		map.virq = bp->irq_tbl[i - 1].vector;
		pci_msix_free_irq(bp->pdev, map);
		bp->irq_tbl[i - 1].vector = 0;

This could already happen when the pre-reservation count was below the
stale total. The recompute after __bnxt_reserve_rings() adds a new
trigger: pre-reservation count > stale total_irqs > post-reservation
count.

Before this patch that case took the grow loop instead. There,
pci_msix_alloc_irq_at() failed cleanly and the result was -ENOSPC.

The new !bnxt_need_reserve_rings() branch above checks bp->irq_tbl.
Should this branch check it as well?

[ ... ]

> @@ -15093,6 +15113,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
>  			hwr.cp = min_t(int, hwr.cp, bnxt_get_max_func_irqs(bp));
>  		}
>  		if (hwr.cp > bp->total_irqs) {
> +			int old_total = bp->total_irqs;
>  			int total_msix = bnxt_change_msix(bp, hwr.cp);
>  
>  			if (total_msix < hwr.cp) {
> @@ -15100,6 +15121,17 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
>  					    hwr.cp, total_msix);
>  				rc = -ENOSPC;
>  			}
> +			/* FW has not reserved the new vectors yet, and writes to
> +			 * MSI-X table entries beyond the reserved IRQs don't
> +			 * stick (seen on BCM57508).  Free them again;
> +			 * bnxt_reserve_rings() allocates them after
> +			 * __bnxt_reserve_rings().  Without the new resource
> +			 * manager there is no IRQ reservation and
> +			 * bnxt_reserve_rings() does not grow the vectors, so
> +			 * keep them.
> +			 */
> +			if (BNXT_NEW_RM(bp))
> +				bnxt_change_msix(bp, old_total);

[Severity: Low]
With the vectors freed again here, a 0 return from bnxt_check_rings() no
longer means they will still be available at reopen. Callers such as
bnxt_set_channels() act on that result:

bnxt_set_channels()
  bnxt_check_rings()          <- allocates, then frees the vectors
  bnxt_close_nic()
  (rx/tx ring counts updated)
  bnxt_open_nic()
    bnxt_reserve_rings()
      __bnxt_reserve_rings()  <- FW reservation committed
      bnxt_change_msix()      <- can now fail with -ENOSPC

Suppose the second allocation fails, for example because IRQ descriptor
allocation fails. Would an ethtool -L request that was already accepted
leave the interface down with "ring reservation/IRQ init failure"?

Before this patch, that failure would have come back from
bnxt_check_rings() before the device was closed.

The commit message notes that the allocation can now fail after FW has
committed the reservation, and the next open retries it.

>  		}
>  	}
>  	return rc;

[Severity: Medium]
This isn't a bug introduced by this patch, but bnxt_check_rings() goes
through bnxt_hwrm_check_rings()->bnxt_hwrm_check_pf_rings(), which uses
the request without a NULL check:

	req = __bnxt_hwrm_reserve_pf_rings(bp, hwr);
	flags = FUNC_CFG_REQ_FLAGS_TX_ASSETS_TEST;
	...
	req->flags = cpu_to_le32(flags);

__bnxt_hwrm_reserve_pf_rings() returns NULL when
bnxt_hwrm_func_cfg_short_req_init() fails. That happens, for example,
when dma_pool_alloc() fails in __hwrm_req_init().

Can this dereference a NULL req under memory pressure?
bnxt_hwrm_check_vf_rings() appears to follow the same pattern.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028114933.256298-1-vlad.wing%40gmail.com
