Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14C3AA9D4;
	Sun, 11 Oct 2026 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715885; cv=none; b=HrgGwRMDp4qGmYnpc2CfvvwiiSxKLDkFgo0FdXwIyeGmlN3EaG4uI47nnOOx595ImtEfky73eqEMkfSJO+GoM2YRkYNiOfO+tmFNsmQ6Gc9AYb/Hzn54ffKeZjb49LchEMXEatETpYT+Dl0ilxiKFwTjdYqXAkUE/vDKTqrBNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715885; c=relaxed/simple;
	bh=PjStFF/lDsqvEpcL3EumyNXUaJ43Sr4xyM/CFnKGOEk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ae1auaxUdoKw5PsLalz8sOGh20ADUfDNsMfJObf0NcBoum6ES9oxCtuL5Zsol8JVBNBUg6Sgv/NB1TNmozYeoBJ3fenZLw93Jp7H6XaELKhV1iu+s9d5JtGNS/B+FEpVf5vrJ6w2lWRc7h4TAZ219OHD+/YBKW/Cpxu2hq2ShzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flcor41D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flcor41D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AF01F0089D;
	Sun, 11 Oct 2026 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715883;
	bh=LJKt8YlaEnULvg5+TAeqgUpEZ+Busr/KC/vgVhiQYK8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=flcor41D+C4eDXPW3InKR8gS8hmdxOBCIe2UgOHNQv/ddw732PIdd5BT5QCUvw2jl
	 EsecHmdKKa14Gr0j+7//wK015MjXDasgppnd8Mbegks2LyAcAcSMNtEy6G2hsRkoGs
	 Qxmnietebme89VhD37pfWVljoutRio43SgwvHZd8pp79SdbAgHlhBWsImdsdA8UH/i
	 pLdQNetK9K1nXAx9ivUhPitBm5MUJHRSQAguxJz6p7SEXPlqz1deX2lmCoWqc2qy9A
	 Ljl7BYbPcDgaA54hmPeFPPbo7Jx9zC76r1wrKkA08D5mq2g+lRIXNxqg4x4wXrKgyI
	 F5q1ldjRhQSvw==
Subject: Re: [PATCH v31 net-next 3/8] net/nebula-matrix: add intr resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 10:51:22 +0000
Message-ID: <179171588273.434549.466147310198104278@kernel.org>
In-Reply-To: <20261010095939.2230-4-illusion.wang@nebula-matrix.com>
References: <20261010095939.2230-4-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The comments in nbl_intr_setup_mgt() and
  nbl_res_intr_cfg_msix_map() say the chip MSI-X tables…
- [Low] The commit message says "Only PFs are supported; VF ids are
  rejected with -EOPNOTSUPP".
- [Low] Several comments describe error semantics the code does not have.
- [Low] Concern (not confirmed): the public entry points read
  res_mgt->intr_mgt without a lock and then take intr_mgt->lock.

--

net/nebula-matrix: add intr resource implementation

This patch adds an nbl_interrupt module. It manages the chip-internal
MSI-X vector index space using separate net and control bitmaps, and it
programs the per-PF chip MSI-X mapping tables. It adds the cfg_msix_map,
destroy_msix_map and set_mailbox_irq resource ops plus the hw helpers
behind them, and calls nbl_intr_mgt_start()/nbl_intr_mgt_stop() from
resource init and remove.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 0000000000000..3048af5bfeed3
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c

[ ... ]

> +int nbl_res_intr_cfg_msix_map(struct nbl_resource_mgt *res_mgt,
> +			      u16 func_id, u16 num_net_msix,
> +			      u16 num_others_msix,
> +			      bool net_msix_mask_en)
> +{

[ ... ]

> +	if (func_id >= NBL_MAX_PF) {
> +		dev_err(dev, "Invalid func_id %u\n", func_id);
> +		return -EINVAL;
> +	}

[ ... ]

> +	ret = nbl_res_func_id_to_bdf(res_mgt, func_id, &bus, &devid, &function);
> +	if (ret) {
> +		if (ret == -EOPNOTSUPP)
> +			dev_err(dev,
> +				"MSI-X mapping for VF func_id=%u is not supported\n",
> +				func_id);
> +		return ret;
> +	}

[Severity: Low]
The commit message says "Only PFs are supported; VF ids are rejected with
-EOPNOTSUPP." Does the code do that?

NBL_MAX_PF is 8, so any VF id fails the func_id >= NBL_MAX_PF check above.
It gets -EINVAL before nbl_res_func_id_to_bdf() is ever called.

nbl_res_func_id_to_bdf() returns -EOPNOTSUPP only when rel_pf_id >=
common->max_pf. That is a PF that does not exist on this board, for
example PF 3 on a 2-port card. Even so, its message ("VF BDF unsupported")
and the message here ("MSI-X mapping for VF func_id=%u") both call it a
VF.

The comment on func_intr_res[] in struct nbl_interrupt_mgt has a related
problem. It says "nbl_res_func_id_to_bdf() rejects VF ids before any
func_intr_res[] access". However, nbl_res_intr_destroy_msix_map() and
nbl_res_intr_set_mailbox_irq() never call nbl_res_func_id_to_bdf(). They
only check func_id >= NBL_MAX_PF.

So an absent-PF id in [max_pf, NBL_MAX_PF) is accepted on those paths, and
the en_msix=false path writes NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id) for
it. For the same reason, the "VFs are rejected earlier" comment in
__nbl_res_intr_set_mailbox_irq() is inaccurate.

Later in the series, the dispatch responders reject rel_pf_id >= max_pf
with -EPERM before calling these ops, and local callers pass
common->mgt_pf. This therefore looks limited to the documentation and the
diagnostics.

Could the commit message, comments and error strings be updated to match?
Alternatively, should destroy_msix_map and set_mailbox_irq check against
max_pf as well?

[ ... ]

> +/*
> + * Only software state is reset here.  The chip-internal MSI-X tables
> + * (FUNCTION_MSIX_MAP, PADPT_HOST_MSIX_INFO, HOST_MSIX_FID_TABLE) can
> + * survive a kexec or a forced unload without FLR, and there is no
> + * .shutdown callback to scrub them.  They are not cleared here because
> + * the INFO/FID tables are indexed by global vector id, which would mean
> + * rewriting every entry; instead the map entry that the pcompleter
> + * actually fetches is invalidated by nbl_res_intr_cfg_msix_map() before
> + * it is programmed, and by the teardown paths.
> + */
> +static struct nbl_interrupt_mgt *nbl_intr_setup_mgt(struct device *dev)
> +{

[Severity: Medium]
After a kexec or forced unload without FLR, what happens to the
FUNCTION_MSIX_MAP entries of PFs that the new kernel has not configured
yet?

The only stale-map invalidation is the !had_config block in
nbl_res_intr_cfg_msix_map(), and it covers only the func_id being
configured:

	if (!had_config) {
		hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
				     false, 0, 0, 0, 0);

The bitmaps start empty here. The first PF the new kernel configures
therefore gets gvecs from the bottom of each pool and arms INFO/FID for
them.

Meanwhile, a sibling PF's map entry from the previous kernel can still be
VALID. It still points at an old-kernel DMA address and maps into those
same gvecs. Bus mastering is already enabled by pci_set_master() in
nbl_probe() at this point.

Could the pcompleter then fetch that stale table, read memory now owned by
the new kernel, or route an interrupt into a gvec now owned by another
function? This looks like the same hazard the fresh-config comment in
nbl_res_intr_cfg_msix_map() describes, but for a different function.

nbl_intr_mgt_stop() and the destroy path only act on CONFIGURED functions.
A stale entry for a PF that stays IDLE would therefore never be cleared.

FUNCTION_MSIX_MAP is indexed by func_id, not by gvec, so the reason given
above for not scrubbing doesn't seem to apply to it. Would it be possible
to invalidate all NBL_MAX_PF map entries at init, followed by one flush
and one quiesce wait?

[ ... ]

> +/*
> + * nbl_intr_mgt_stop - global control-PF interrupt teardown
> + *
> + * Phase 1 sets the stopping latch and invalidates every configured
> + * function's hardware map entry while holding the lock.  The lock is
> + * dropped for the global quiesce window, so a caller that races the
> + * window is rejected by the latch (checked under the lock), not by the
> + * lock being held.
> + *
> + * After this returns res_mgt->intr_mgt is NULL, so the public entry
> + * points report -EINVAL.  -ESHUTDOWN/-EBUSY/-ENODEV are only observed
> + * by a caller that latched the pointer before it was cleared.
> + */

[Severity: Low]
This isn't a bug, but are these error code descriptions accurate?

The -EBUSY branch in nbl_res_intr_cfg_msix_map() looks unreachable:

	if (intr_mgt->func_intr_res[func_id].state ==
	    NBL_INTR_FUNC_DESTROYING) {
		ret = -EBUSY;

__nbl_res_intr_destroy_msix_map() holds the lock from prepare through
complete, and it always leaves the function IDLE. The only other time
DESTROYING is visible under the lock is the quiesce window in
nbl_intr_mgt_stop(). By then stopping is already true, so the
-ESHUTDOWN check just above fires first.

Also, __nbl_res_intr_set_mailbox_irq() returns -ENODEV whenever en_msix is
true and the function is not CONFIGURED, whether or not stop has run.

The comment on nbl_resource_mgt::intr_mgt in nbl_resource.h has a similar
mismatch. It says a caller that latched the pointer early "sees
stopping == true and fails with -ESHUTDOWN". But the en_msix=false path
returns 0 before any stopping check:

	if (!en_msix) {
		hw_ops->set_mailbox_irq(res_mgt->hw_ops_tbl->priv,
					func_id, false, 0);
		hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
		return 0;
	}

Could these comments be adjusted, and the dead -EBUSY branch dropped?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010095939.2230-1-illusion.wang%40nebula-matrix.com
