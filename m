Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E72BEC23
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146569; cv=none; b=kaBwJEVAl1MGPMtbvTqFL+OxxTcPkEMM2A2lYVaVdpNctxmmaVpWVuOXQ9p7mLTAN9EK1KGCpbteS43xiN432WTJDb6H8B1hOFKBAUuA7rzCPeylvh3T0CbO9iXOkBnpqhXNa2NbnLexU9Jkg/kJs2Qy6pxOTh9213mtJKHD6F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146569; c=relaxed/simple;
	bh=lumYmKi1YzsPZs03CVRw50EqbA3t49tNGOgVq2Rndh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YttsEXmAvONMBNVMySbg/d1bUnSFqshnou5SM4GvRP0IpdNd0HNVEMaBDBUezex2KkRadU3eylrRg0Yu8HVCZlHNpU0ppKhgRP/7dx1nlFy922BQ/T7r0WRP3BRvJF0TOu1k+drz6PVwUxby3sAbFwba7wgZlrGaHX+yIKkFhw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nkox4cr5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nkox4cr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964E41F000E9;
	Fri,  7 Aug 2026 23:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786146567;
	bh=pG/pbK9K4nKemgRcqIOIcSrOukuyD7k9STqrw4/isco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nkox4cr5vWY/vBAV+6DG+N1Ni6SVVuyHsfw+X9W38Yhc8Zfn3RQNwDiDOwNHF/yS1
	 jKaoFtOVa5G9yaLCMNeH5hxEMu/AjQNl5KrygY6czB4nuIJhqmVYNDYOh5jQ7p1ja0
	 RJbTYOgNPPugHZ7nbRjNjHXICAfDiOLLBAfccCUiPWOkJY7op+UQe4jFACzeDjxMgR
	 QrLM/tjLXAObyGiNttFoT8MpekW3jJGrtdVpKf1utAtOvHFwaft0IHLmiwdQEQ2DJa
	 TeltJftihKmNyo7miKRyD0d4xaqflTk/EN7kQP9JrrX75k69oQd+rGZIhHdtgTef6V
	 ICkNXLWixkUDg==
From: Jakub Kicinski <kuba@kernel.org>
To: nikhil.rao@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	eric.joyner@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net v2] pds_core: fix cmd_regs access racing BAR unmap on reset
Date: Fri,  7 Aug 2026 16:47:00 -0700
Message-ID: <20260807234700.1979723-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804235946.177762-1-nikhil.rao@amd.com>
References: <20260804235946.177762-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
pds_core: fix cmd_regs access racing BAR unmap on reset

This takes devcmd_lock across the BAR unmap in pdsc_reset_prepare() and
the remap in pdsc_reset_done(), skips the unmap entirely for VFs, and adds
cmd_regs NULL checks in pdsc_core_init(), pdsc_identify() and the
pdsc_firmware_update() download loop.

Closes: https://sashiko.dev/#/patchset/20260708212222.296202-1-nikhil.rao%40amd.com?part=3

A few questions below.

>     pdsc_unmap_bars() also clears info_regs, intr_status, intr_ctrl and
>     db_pages.

[Severity: Low]
Is this part of the changelog accurate?  pdsc_unmap_bars() clears exactly
four pointers:

	pdsc->info_regs = NULL;
	pdsc->cmd_regs = NULL;
	pdsc->intr_status = NULL;
	pdsc->intr_ctrl = NULL;

It never touches pdsc->db_pages or pdsc->phy_db_pages.  Grepping the
driver, db_pages is assigned only in pdsc_map_bars():

	pdsc->db_pages = bar->vaddr;
	pdsc->phy_db_pages = bar->bus_addr;

and bar there is &bars[1], whose vaddr was forced to NULL by the earlier
"only map the whole bar 0" branch:

		/* only map the whole bar 0 */
		if (j > 0) {
			bars[j].vaddr = NULL;

So db_pages is always NULL and never a live mapping.  Would "db_pages is
never mapped" be the correct justification here, rather than saying the
unmap clears it?

> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 04ec2569c61c0..c3c27a7c63d0e 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -364,6 +364,14 @@ static int pdsc_core_init(struct pdsc *pdsc)
>  
>  	mutex_lock(&pdsc->devcmd_lock);
>  
> +	if (!pdsc->cmd_regs) {
> +		mutex_unlock(&pdsc->devcmd_lock);
> +		err = -ENXIO;
> +		dev_err(pdsc->dev, "Device init command failed: %pe\n",
> +			ERR_PTR(err));
> +		goto err_out_uninit;
> +	}
> +

[Severity: Medium]
Does this new bail-out actually avoid the unmapped-MMIO access it is meant
to avoid?  The err_out_uninit path leads to interrupt-control register
writes through the same BAR0 mapping:

pdsc_core_init() -> err_out_uninit -> pdsc_core_uninit() -> pdsc_qcq_free()
-> pdsc_qcq_intr_free() -> pdsc_intr_free()

and pdsc_intr_free() does:

	pds_core_intr_mask(&pdsc->intr_ctrl[index], PDS_CORE_INTR_MASK_SET);
	pds_core_intr_clean(&pdsc->intr_ctrl[index]);

	free_irq(intr_info->vector, intr_info->data);

pdsc_unmap_bars() clears cmd_regs and intr_ctrl in the same four
statements, so cmd_regs == NULL implies intr_ctrl == NULL.  The adminq QCQ
was just allocated in this function with PDS_CORE_QCQ_F_INTR, so
intr_info->vector is non-zero and the early return in pdsc_intr_free() is
not taken.  Does that turn the memcpy_toio() to a NULL cmd_regs into an
iowrite32() at &((struct pds_core_intr *)NULL)[index].mask, and also skip
the intended mask/credit-clean before free_irq() drops the handler?

There is a related asymmetry earlier in the same call sequence:
pdsc_qcq_alloc() -> pdsc_intr_alloc() dereferences pdsc->intr_ctrl in

	pds_core_intr_clean_flags(&pdsc->intr_ctrl[index],
				  PDS_CORE_INTR_CRED_RESET_COALESCE);

with no NULL check, and pdsc_start() does the same with

	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
			   PDS_CORE_INTR_MASK_CLEAR);

Is the window this check covers reachable at all?  If the BARs cannot
vanish inside pdsc_core_init(), this is dead code; if they can, the
intr_ctrl users around it look equally exposed.

[Severity: Low]
This isn't a bug, but the three new checks for the same condition report it
three different ways.

Here pdsc_core_init() logs "Device init command failed: -ENXIO" on a path
that unlocks and jumps to err_out_uninit before pdsc_devcmd_locked() is
ever called, and the string is identical to the one emitted just below for
a real devcmd failure:

	err = pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
	...
	if (err) {
		dev_err(pdsc->dev, "Device init command failed: %pe\n",
			ERR_PTR(err));

Would something like "BARs unmapped, skipping device init" make the two
distinguishable in dmesg?

pdsc_identify() returns -ENXIO with no log line at all, and
pdsc_firmware_update() now has two checks of the same condition on the same
devlink flash_update path: the pre-existing entry check

	if (!pdsc->cmd_regs)
		return -ENXIO;

returns without an extack, while the new in-loop check sets "Device reset
during flash".  Should userspace see the same extack regardless of which
one fires?

> diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
> index bded6b33289ce..ec96f67dc67b9 100644
> --- a/drivers/net/ethernet/amd/pds_core/dev.c
> +++ b/drivers/net/ethernet/amd/pds_core/dev.c
> @@ -294,6 +294,11 @@ static int pdsc_identify(struct pdsc *pdsc)
>  	 */
>  	mutex_lock(&pdsc->devcmd_lock);
>  
> +	if (!pdsc->cmd_regs) {
> +		mutex_unlock(&pdsc->devcmd_lock);
> +		return -ENXIO;
> +	}
> +
>  	sz = min_t(size_t, sizeof(drv), sizeof(pdsc->cmd_regs->data));
>  	memcpy_toio(&pdsc->cmd_regs->data, &drv, sz);
>  
> diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
> index fa626719e68d1..cd7616ed9ef32 100644
> --- a/drivers/net/ethernet/amd/pds_core/fw.c
> +++ b/drivers/net/ethernet/amd/pds_core/fw.c
> @@ -134,6 +134,12 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
>  
>  		copy_sz = min_t(unsigned int, buf_sz, fw->size - offset);
>  		mutex_lock(&pdsc->devcmd_lock);
> +		if (!pdsc->cmd_regs) {
> +			mutex_unlock(&pdsc->devcmd_lock);
> +			err = -ENXIO;
> +			NL_SET_ERR_MSG_MOD(extack, "Device reset during flash");
> +			goto err_out;
> +		}
>  		memcpy_toio(&pdsc->cmd_regs->data, fw->data + offset, copy_sz);
>  		err = pdsc_devcmd_fw_download_locked(pdsc, data_addr,
>  						     offset, copy_sz);
> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 9a2c64198d03b..1b960139de4e4 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -507,7 +507,11 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
>  		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>  	}
>  
> -	pdsc_unmap_bars(pdsc);
> +	if (!pdev->is_virtfn) {
> +		mutex_lock(&pdsc->devcmd_lock);
> +		pdsc_unmap_bars(pdsc);
> +		mutex_unlock(&pdsc->devcmd_lock);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, and the changelog already calls
the debugfs readers out of scope, but the info_regs case looks like it can
oops without any race at all, so it seems worth mentioning here.

identity_show() reads the heartbeat register with no NULL check:

	seq_printf(seq, "fw_heartbeat:     0x%x\n",
		   ioread32(&pdsc->info_regs->fw_heartbeat));

Every other reader of that same register tests the pointer first, for
example pdsc_is_fw_running():

	if (!pdsc->info_regs)
		return false;

pdsc_unmap_bars() sets pdsc->info_regs = NULL, and the "identity" file
deliberately survives a reset, per pdsc_debugfs_add_ident():

	/* This file will already exist in the reset flow */
	dentry = debugfs_lookup("identity", pdsc->dentry);

So besides the FLR window, if pdsc_reset_done() bails out early at
pci_enable_device(), pci_request_regions() or pdsc_map_bars(), does
info_regs stay NULL permanently while the file stays registered, making
every subsequent read of /sys/kernel/debug/pds_core/<pci-name>/identity
dereference NULL plus the fw_heartbeat offset?

pdsc_remove() also calls pdsc_unmap_bars() before pdsc_debugfs_del_dev(),
which leaves the same window during unbind.

Note that the qcq intr_ctrl regset in debugfs does not have this problem:
pdsc_debugfs_del_qcq() runs from pdsc_qcq_free() via pdsc_fw_down() ->
pdsc_teardown() -> pdsc_core_uninit(), which is before the unmap.

>  	pci_release_regions(pdev);

[Severity: Low]
This is a pre-existing asymmetry rather than something this patch
introduces, but the new is_virtfn guard right above it makes it visible:
pci_release_regions() still runs for VFs, and the VF path never requests
regions.  pdsc_init_vf() has no pci_request_regions() call, and the
counterpart in pdsc_reset_done() is PF-only:

	if (!pdev->is_virtfn) {
		...
		err = pci_request_regions(pdsc->pdev, PDS_CORE_DRV_NAME);

For a VF this reaches pci_release_region() -> release_mem_region() on a
range that was never reserved, so __release_region() prints "Trying to free
nonexistent resource" per memory BAR on every VF FLR.  Should
pci_release_regions() move inside the same !pdev->is_virtfn block?

>  	if (pci_is_enabled(pdev))
>  		pci_disable_device(pdev);

[ ... ]
-- 
pw-bot: cr
