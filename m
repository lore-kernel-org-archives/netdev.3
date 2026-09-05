Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49D3112B2
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 01:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570413; cv=none; b=YjbKM/zRNfij9EEFm9tRUy7evV3IXoYyBVlijpsvF5L9jAv5cQPPyJZMfFr26l+U+TMAyEvV9LZvFN4ktA7R7NhXYaBLSPTDIUOoRucc7t227/y/JbXoxjwtyJmaPZANG68rk8sTJLkWFvDBoCB9TcyspgROj0o3MgM0b1OVKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570413; c=relaxed/simple;
	bh=t5/5ogNYpwP/QgINvoDMz722AhGgFyYsqEYftxpOoqk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=howi/Z/iE7Rui9KzaOm3H6Ye38MNrCCjm/qT7qAKSE2ABIfWt52Do4JGdasQZ5D7/HGJWVhoqUTtrtWVA9kmAJx8MxNFnJTzheDZ49PUWIKvRS68F1J1R+gol/46JOY3jHAMDcxp5pHg+lbOkdif7DQlOO+F6DPxg9lrDcZV+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPSVbt7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPSVbt7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378F71F00A3D;
	Sat,  5 Sep 2026 01:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570411;
	bh=DPUmNS2+00V+gEiSbLYowlorarWHxlcbQBQM/JtROR0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HPSVbt7dOJRoDsFd4MjD0qjQgGYstU5aX71UKLfy2y35t1p3H0miCTvuQpMPRZux/
	 y/Slo8Tb7j1d5hUhHT7fKy0gvpzDIVIFV7Hritl2sifMgVjTgP8WOCWj8BvkyNfadh
	 HABw7LsyoThmeMEGznx1wjIy1ubkOVyhSR2zcs1ZRUotWfqbGioZwD5kvZTR2bcjTd
	 5Pvf1vjlFSxA3trg4lb4yCOUYRiqkbNG9ViztoYCY01cPT0EQpOM5/A5QJ3LqSNZGZ
	 vAKfn0C7kLtA2VX191bLYUeJbdZC86l1KVo8Lxts1MbZi9sAvpxKk5FvwsvwmvnRNi
	 Eo63u+2nKMPcg==
Subject:
 Re: [PATCH net v3 2/3] pds_core: don't release PCI regions for VFs on reset
From: netdev-bot+sashiko@kernel.org
To: nikhil.rao@amd.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 brett.creeley@amd.com, eric.joyner@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Date: Sat, 05 Sep 2026 01:06:50 +0000
Message-ID: <178857041070.219967.13178305658939860424@kernel.org>
In-Reply-To: <20260901044219.1361466-3-nikhil.rao@amd.com>
References: <20260901044219.1361466-3-nikhil.rao@amd.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] pdsc_reset_prepare()
  (drivers/net/ethernet/amd/pds_core/main.c:516-521) now gates…

--

pds_core: don't release PCI regions for VFs on reset

This moves pci_release_regions() in pdsc_reset_prepare() inside the
existing !pdev->is_virtfn block, since only the PF path calls
pci_request_regions() in pdsc_init_pf(). The stated goal is to stop the
"Trying to free nonexistent resource" warning on a VF FLR.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804235946.177762-1-nikhil.rao%40amd.com

> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 6e1079f9ba0f5..a971c66d36f98 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -517,8 +517,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
>  		mutex_lock(&pdsc->devcmd_lock);
>  		pdsc_unmap_bars(pdsc);
>  		mutex_unlock(&pdsc->devcmd_lock);
> +		pci_release_regions(pdev);
>  	}
> -	pci_release_regions(pdev);

[Severity: High]

The new condition keys the release off the device type rather than off
whether the driver currently holds the regions.  Can the PF still hit the
same "Trying to free nonexistent resource" warning from __release_region()
because pdsc_reset_prepare() runs twice per AER frozen-channel recovery
with no pdsc_reset_done() in between?

The first call comes from the error_detected callback:

drivers/net/ethernet/amd/pds_core/main.c:pdsc_pci_error_detected() {
	if (error == pci_channel_io_frozen) {
		...
		pdsc_reset_prepare(pdev);
		if (!pdev->is_virtfn)
			cancel_work_sync(&pdsc->pci_reset_work);
		return PCI_ERS_RESULT_NEED_RESET;
	}
}

For a PF this unmaps the bars, releases the regions and disables the
device, and pdsc_fw_down() leaves PDSC_S_FW_DEAD set.

pcie_do_recovery() then does reset_subordinates(), which for AER goes
pci_bus_error_reset() -> pci_reset_bridge() -> pci_bus_reset() or
pci_slot_reset().  None of those call pci_dev_save_and_disable(), so no
reset_prepare/reset_done pair happens there, and pdsc_err_handler has no
.slot_reset, so report_slot_reset() is a no-op for this driver.  Recovery
proceeds to report_resume():

drivers/net/ethernet/amd/pds_core/main.c:pdsc_pci_error_resume() {
	if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
		pci_reset_function_locked(pdev);
}

PDSC_S_FW_DEAD is still set here, since pdsc_fw_up() only runs from
pdsc_reset_done(), which has not run yet.  pci_reset_function_locked()
calls pci_dev_save_and_disable():

drivers/pci/pci.c:pci_dev_save_and_disable() {
	...
	if (err_handler && err_handler->reset_prepare)
		err_handler->reset_prepare(dev);
}

so pdsc_reset_prepare() is entered a second time on a PF whose regions are
already released, and pci_release_regions() -> release_mem_region() ->
__release_region() prints the same message the commit sets out to remove.

Every other teardown step in pdsc_reset_prepare() already tolerates a
double invocation, which suggests re-entry is an expected condition:

drivers/net/ethernet/amd/pds_core/core.c:pdsc_fw_down() {
	if (test_and_set_bit(PDSC_S_FW_DEAD, &pdsc->state)) {
		dev_warn(pdsc->dev, "%s: already happening\n", __func__);
		return;
	}
}

pdsc_unmap_bars() skips NULL vaddrs, and the disable is guarded:

	if (pci_is_enabled(pdev))
		pci_disable_device(pdev);

Only pci_release_regions() has no equivalent ownership tracking.

There also seems to be a second unbalanced-release path on the PF.
pdsc_reset_done() returns early when pci_enable_device(),
pci_request_regions() or pdsc_map_bars() fail:

drivers/net/ethernet/amd/pds_core/main.c:pdsc_reset_done() {
	...
		err = pci_request_regions(pdsc->pdev, PDS_CORE_DRV_NAME);
		if (err) {
			dev_err(pdsc->dev, "Cannot request PCI regions: %pe\n",
				ERR_PTR(err));
			return;
		}
	...
}

After such a bail-out the PF holds no regions, but pdsc_remove() still
does:

		pdsc_unmap_bars(pdsc);
		pci_release_regions(pdev);

as does the next pdsc_reset_prepare().  Would tracking region ownership in
struct pdsc, for example a flag set on a successful pci_request_regions()
and cleared on release, cover both the VF case and these PF cases instead
of keying the release off pdev->is_virtfn?

>  	if (pci_is_enabled(pdev))
>  		pci_disable_device(pdev);
>  	pdsc_deferred_dma_free(pdsc);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901044219.1361466-1-nikhil.rao%40amd.com
