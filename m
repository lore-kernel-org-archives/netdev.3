Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01A3264DA
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570414; cv=none; b=qHB82/avEui2jEGir1huVeAfJeLgp19qyN7eQv1+pkJ+5JghwQhUpcF1KaexiYnJszg7tnDGH/u23TgRybUTEWdjMJkK1fZdu1ygm6cv3f4DDH7xAF5QHAUGKubDIHsXFtMXb63jeJ60ofduBAAEu6NsWqaKxNJwqo6O5SmBaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570414; c=relaxed/simple;
	bh=McN/1+4e4B6MTvPnnBW+7rksuIh5engTTK5+lUshNF4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MjGgUUGw2Zqye68/xaji18mHSqwQOrTs9gyDnLGDWR8Los6Z7OJfD68v2ibRWEkMMbXbRBeNrIARfuPYjAUZzkU3vt9ylkKUQpNGSnEnjKBdgZrZWb9bQSOFgaoWSMBtu3w6FkAGefhPiXD9Z24z48BgkMFAQAkajKiJZzeZT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otONxkXH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otONxkXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556741F00A3E;
	Sat,  5 Sep 2026 01:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570412;
	bh=IQE7MRp+Es6evjPirxpX1lS83LQETHoPT7MPbpxTNX0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=otONxkXH0S4hKOtg0/gsoDOTqhGWXLhZzmcsg3zF3bDSH7Mr/+rWszt02QlinNAeh
	 Uf0zvzK1sgB+TVejxh0Loa3+DQI4LG6txdonCHx5WxjMP7PVsQ544fu+SWNhpG1ovE
	 sYoS8/MAMMZ69tnFFs7Pt4LsnGCrMTbPhCf+dyZyRHx3EBSIc9N5nEMcqGuyClVpJH
	 KHpxoDRqULf/bWOSb5Hk7QC9AeUzF27uBIdfXwbvZYslieusPO5/kAx5LwhLHlFEqt
	 eHtsq6A18z7ucUmRIJAcE1VkWxN7z2Nqs5tdAPtPDj8Ce/4Z8VwfoGuEO/MJG81vsZ
	 XajcF2/iEBiUw==
Subject: Re: [PATCH net v3 3/3] pds_core: check info_regs in the identity
 debugfs reader
From: netdev-bot+sashiko@kernel.org
To: nikhil.rao@amd.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 brett.creeley@amd.com, eric.joyner@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Date: Sat, 05 Sep 2026 01:06:51 +0000
Message-ID: <178857041188.219967.13424554495565611887@kernel.org>
In-Reply-To: <20260901044219.1361466-4-nikhil.rao@amd.com>
References: <20260901044219.1361466-4-nikhil.rao@amd.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

- [Medium] The newly added guard in `identity_show()` is an
  unsynchronized check-then-use of an `__iomem` pointer that a…

Pre-existing issues:
- [High] NULL-pointer dereference in the sibling debugfs reader
  `viftype_show()` (drivers/net/ethernet/amd/pds_core/debugfs.c:81-96).

--

pds_core: check info_regs in the identity debugfs reader

This adds a NULL test around the fw_heartbeat read in identity_show() so
the identity debugfs file does not dereference pdsc->info_regs after
pdsc_unmap_bars() has cleared it. The identity file is deliberately kept
across a reset, so the reader can run while the BARs are unmapped.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804235946.177762-1-nikhil.rao%40amd.com

> diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
> index ef0a1b7d159b5..c458e6758959a 100644
> --- a/drivers/net/ethernet/amd/pds_core/debugfs.c
> +++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
> @@ -38,8 +38,9 @@ static int identity_show(struct seq_file *seq, void *v)
>  
>  	ident = &pdsc->dev_ident;
>  
> -	seq_printf(seq, "fw_heartbeat:     0x%x\n",
> -		   ioread32(&pdsc->info_regs->fw_heartbeat));
> +	if (pdsc->info_regs)
> +		seq_printf(seq, "fw_heartbeat:     0x%x\n",
> +			   ioread32(&pdsc->info_regs->fw_heartbeat));

[Severity: Medium]
Is the guard enough when the unmap happens concurrently with the read?
The test and the use are two separate plain loads of pdsc->info_regs,
and identity_show() holds none of the driver's locks:

	if (pdsc->info_regs)
		seq_printf(seq, "fw_heartbeat:     0x%x\n",
			   ioread32(&pdsc->info_regs->fw_heartbeat));

Meanwhile pdsc_unmap_bars() in main.c clears the pointer and then drops
the mapping:

	pdsc->info_regs = NULL;
	pdsc->cmd_regs = NULL;
	...
		if (bars[i].vaddr)
			pci_iounmap(pdsc->pdev, bars[i].vaddr);

So can the second load still observe NULL and make ioread32() fault at
offsetof(struct pds_core_dev_info_regs, fw_heartbeat)?  And even if the
compiler keeps the first value, can pci_iounmap() have already torn the
mapping down, leaving the ioread32() touching an unmapped ioremap range?

The other info_regs readers appear to be serialized against the unmap:
pdsc_check_pci_health() and pdsc_is_fw_running() run from the health work
under config_lock, which pdsc_reset_prepare() stops first, and the adminq
readers are gated by PDSC_S_FW_DEAD plus the adminq_refcnt drain in
pdsc_fw_down().  pdsc_reset_prepare() serializes the unmap only with
devcmd_lock:

	mutex_lock(&pdsc->devcmd_lock);
	pdsc_unmap_bars(pdsc);
	mutex_unlock(&pdsc->devcmd_lock);
	pci_release_regions(pdev);

which identity_show() never takes.  In pdsc_remove() the ordering looks
worse, since the lock is gone before the unmap and the debugfs consumer of
the mapping is only removed afterwards:

	mutex_destroy(&pdsc->devcmd_lock);
	...
	pdsc_unmap_bars(pdsc);
	pci_release_regions(pdev);
	...
	pdsc_debugfs_del_dev(pdsc);

Would snapshotting the pointer into a local plus serializing against
map/unmap (or removing the debugfs entries before unmapping the BARs) close
this properly?

[Severity: High]
This isn't a bug introduced by this patch, but the sibling reader in the
same file, viftype_show(), has the same shape of problem and no NULL test
at all:

	for (vt = 0; vt < PDS_DEV_TYPE_MAX; vt++) {
		if (!pdsc->viftype_status[vt].name)
			continue;

pdsc_teardown() with PDSC_TEARDOWN_REMOVING frees and clears the base
pointer:

	if (removing) {
		kfree(pdsc->viftype_status);
		pdsc->viftype_status = NULL;
	}

In pdsc_remove() that teardown runs well before pdsc_debugfs_del_dev(),
with destroy_workqueue(), two mutex_destroy() calls, pdsc_unmap_bars(),
pci_release_regions(), pci_disable_device(), pdsc_deferred_dma_free() and
ida_free() in between, so can a read of the still-registered viftypes file
dereference a NULL pdsc->viftype_status?  The same window looks present on
the pdsc_init_pf() error path, where err_out_teardown runs long before
pdsc_debugfs_del_dev().

The other readers of that member treat NULL as reachable, for example
pdsc_dl_find_viftype_by_id() in devlink.c:

	if (!pdsc->viftype_status)
		return NULL;

and host_mem_show() in this same file NULL-checks pdsc->host_mem_reqs.
Should viftype_show() get the same treatment while this area is being
touched?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901044219.1361466-1-nikhil.rao%40amd.com
