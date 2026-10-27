Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104743;
	b=U2ntz6poD/LEOCFLofZSsEVNiYDjIJ/x0vq9c4Mtt7GwmtsGOp3VZhsvVdr3WcE+wsCJ
	 +empZ8hbdq/xiWxQ3snpXMeT/U0vLbL7/vPSibd3SSRj1g81N4KUmKvfKySII7H3uGKAj
	 g4c0MpffBiVOKxz7wESV1G6N4Jk6shUcqQgfKK6S5IkbxjUHj8MYKakXHPM8KJALExZsp
	 539OBiNrjm90JxOO3U9/CeoLzYNxmd/Z32FWrkBv86KnnRmfOO7HkGtU0M3xc2aE/ngo1
	 km09rtCeFT9cHnzQIToU77fSGkNeX+ShceQ/exUDQZuvGtxp0/r6WdwKgwjKrdRcS4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104743;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Jswp2crzQp9KqexGzBb3t1FkcdKy9t2g2KSUpLlbZf0=;
	b=gKeZsemnhtE+ESIRG/InIukkd+ELbimYgibffOYup06hp0u6bF4yk9Hic+lQvfzhYBWh
	 zG/TdsX7IzosETAWEimARp2mgSMdC/2P7UtWqn7crmAbkRcy64u/xvTD1ym/EyAj9c/gS
	 w96zwMhUZtRVskPJPp9CFE8gs/2lUN/3MvgS9yXBuWe6domEOaYYlWVRzhdvSS/W/0K0D
	 jONhKwtDLHu/THV2WD2w9KTc04OTjQJ/359Xhb9mscTIwuhjFhsw8jbU5uAmL8J+HHed2
	 tKLUwSlTJ3lkW/+EGoXuVuFZfXf7vJKjyu7tzjmiN2R3EtxkTRikkksWAd2MPy5k+7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fC/kv9PZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E0606A31D;
	Tue, 27 Oct 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fC/kv9PZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CDD1F01825;
	Tue, 27 Oct 2026 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104742;
	bh=Jswp2crzQp9KqexGzBb3t1FkcdKy9t2g2KSUpLlbZf0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fC/kv9PZxxLXB6LBGvhYqCEArhYUkOlWtJrZH9VYZWQ6+7oQ/ZE3HlQayWc0Lv3d9
	 qNWAyH1rQGwUHX1FZfsbn3Kr7vUb1gDrgng7WMNRp6O3B4VkdlBymh7Yic3rIeiTeg
	 MWC2M3qmb7xaglhX5yi0z2N3KmzVdn1JmoHkrE/4T/mxpZNtYgfICwwIdBY/tF4dnV
	 +NrKrLuAqIygI3gBBRZaLsCm2YzdODyNc4UvO3YX6zYvhd/HaKbQcaX1ZISOg3ad8f
	 QJthbWvm5rCAPG3Gjc8G61uDZy/Mhkougzi8BUmAWTPHmEIFMjadvyEuZ/4nHWMP9c
	 Mdu5M7pw+bKww==
Subject: Re: [PATCH net] bnxt_en: Don't keep MSI-X vectors added before FW
 reserves them
From: netdev-bot+sashiko@kernel.org
To: vlad.wing@gmail.com
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew.gospodarek@broadcom.com, tglx@kernel.org, maz@kernel.org,
 yangjinqian1@huawei.com, apreece@meta.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 12:39:01 +0000
Message-ID: <179310474137.3134.4690740150964769309@kernel.org>
In-Reply-To: <20261023121321.2127263-1-vlad.wing@gmail.com>
References: <20261023121321.2127263-1-vlad.wing@gmail.com>
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

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix is incomplete when FW grants fewer MSI-X vectors than
  requested.
- [Medium] New error path leaves the state inconsistent.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the DCB IEEE
  ETS path reaches bnxt_check_rings() and bnxt_change_msix() holding…

--

bnxt_en: Don't keep MSI-X vectors added before FW reserves them

When dynamic MSI-X is supported, bnxt_check_rings() grows the MSI-X
vectors before FW has reserved them. On arm64 GICv3 the MSI message is
written only once, at allocation, so the message for those entries is
lost. This patch keeps the allocation in bnxt_check_rings() as an
availability check. When BNXT_NEW_RM is set it frees the new vectors
again right away, so that bnxt_reserve_rings() allocates them after
__bnxt_reserve_rings().

Closes: https://lore.kernel.org/all/20261022193620.2152038-1-vlad.wing@gmail.com/

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 0682060b048ce..2d14d991a3ead 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15093,6 +15093,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
>  			hwr.cp = min_t(int, hwr.cp, bnxt_get_max_func_irqs(bp));
>  		}
>  		if (hwr.cp > bp->total_irqs) {
> +			int old_total = bp->total_irqs;
>  			int total_msix = bnxt_change_msix(bp, hwr.cp);
>  
>  			if (total_msix < hwr.cp) {
> @@ -15100,6 +15101,17 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
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

[Severity: Medium]

The comment says bnxt_reserve_rings() allocates the vectors after
__bnxt_reserve_rings(). Is that allocation capped at the number of
vectors FW actually granted?

In bnxt_reserve_rings(), irqs_required is computed before the
reservation is made:

	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(edev)) {
		...
		irqs_required = ulp_msix + bp->cp_nr_rings;
	}
	...
	rc = __bnxt_reserve_rings(bp);
	...
	} else if (irq_change && !rc) {
		if (bnxt_change_msix(bp, irqs_required) != irqs_required)
			rc = -ENOSPC;
	}

If FW grants fewer MSI-X vectors than requested, bnxt_hwrm_get_rings()
records the smaller count:

	hw_resc->resv_irqs = le16_to_cpu(resp->alloc_msix);

__bnxt_reserve_rings() then handles the partial grant by trimming
cp_nr_rings and ulp_msix:

	resv_msix = hw_resc->resv_irqs - bp->cp_nr_rings;
	ulp_msix = min_t(int, resv_msix, ulp_msix);

However, bnxt_reserve_rings() still calls bnxt_change_msix() with the
untrimmed irqs_required. Wouldn't the entries from resv_irqs up to
irqs_required then be allocated and activated before FW backs them?
That is the state this patch is trying to avoid.

bnxt_change_msix() only programs indices at or above bp->total_irqs:

	for (i = bp->total_irqs; i < total; i++) {

so those entries would never be written again. FW could grant them
later, for example on a channel increase where the new count is at or
below total_irqs. Could the NQ rings bound to them then signal address
0, giving the same lost completions and TX watchdog timeouts?

It isn't clear how often FW returns a partial grant after
bnxt_hwrm_check_rings() has succeeded (NPAR, multi-host or VFs may be
cases). The driver does handle partial grants explicitly, though.

Would capping the growth in bnxt_reserve_rings() at hw_resc->resv_irqs
cover this case? Freeing and reallocating any vectors activated beyond
the reservation would be another option.

[Severity: Medium]

Does freeing the vectors here change how an MSI-X allocation failure
is handled?

Before this patch, if pci_msix_alloc_irq_at() failed, bnxt_check_rings()
caught it before any FW or ring state had changed. Now the growth
always happens in bnxt_reserve_rings(). By that point,
__bnxt_reserve_rings() has already committed the FW reservation and
updated bp->hw_resc.

The allocation can fail there, for example under memory pressure or if
another device takes the vectors released here. bnxt_change_msix() then
returns early with bp->total_irqs below irqs_required.
bnxt_reserve_rings() returns -ENOSPC and nothing is rolled back.

On the next open, bnxt_need_reserve_rings() compares only hw_resc
against the ring config:

	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && BNXT_PF(bp) &&
	    hw_resc->resv_irqs != hwr.cp)
		return true;

It returns false, so bnxt_reserve_rings() returns before growing the
vectors:

	if (!bnxt_need_reserve_rings(bp))
		return 0;

bnxt_setup_int_mode() also skips reinitialization, because bp->irq_tbl
is non-NULL.

bnxt_request_irq() then requests an IRQ for every cp ring using
bp->irq_tbl[map_idx].vector, without checking map_idx against
bp->total_irqs. For entries at or above total_irqs, wouldn't .vector be
either 0 or a stale virq? The trim loop in bnxt_change_msix() frees the
vector but leaves irq_tbl[].vector set:

	for (i = bp->total_irqs; i > total; i--) {
		map.index = i - 1;
		map.virq = bp->irq_tbl[i - 1].vector;
		pci_msix_free_irq(bp->pdev, map);
		bp->total_irqs--;
	}

The open would then fail. If another device has reused the stale virq,
could the bnxt handler end up attached to an interrupt it doesn't own?

Running ethtool -L again with the same count seems to repeat the grow
and trim in bnxt_check_rings() and the early return in
bnxt_reserve_rings(). Is there a way to recover other than picking a
different ring configuration or a FW reset?

[Severity: High]

This is a pre-existing issue, not one introduced by this patch.
However, the new rollback adds another access to bp->irq_tbl in a
window that doesn't appear to be protected against PCI error recovery.

The DCB IEEE ETS path reaches this code holding only RTNL:

dcbnl_ieee_set()
  bnxt_dcbnl_ieee_setets()
    bnxt_setup_mq_tc()
      bnxt_check_rings()
        bnxt_change_msix()

net/dcb/dcbnl.c doesn't take the netdev instance lock.
bnxt_io_error_detected(), on the other hand, takes netdev_lock() but
not RTNL. For pci_channel_io_frozen it calls:

bnxt_io_error_detected()
  bnxt_fw_fatal_close()
    bnxt_clear_int_mode()

This frees bp->irq_tbl and sets it to NULL, but leaves bp->total_irqs
unchanged.

Suppose that runs between the grow in bnxt_check_rings() and the new
bnxt_change_msix(bp, old_total). The trim loop would see the stale
total_irqs, which is above old_total, and read
bp->irq_tbl[i - 1].vector through a NULL or freed pointer. The existing
write in the grow loop, bp->irq_tbl[i].vector = map.virq, has the same
race.

Should bnxt_dcbnl_ieee_setets() take the netdev instance lock? Taking
it inside bnxt_check_rings() would deadlock callers that already hold
it.

>  		}
>  	}
>  	return rc;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023121321.2127263-1-vlad.wing%40gmail.com
