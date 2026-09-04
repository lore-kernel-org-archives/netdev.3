Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1558370AC0;
	Fri,  4 Sep 2026 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508371; cv=none; b=g7iuoNfOxkq6NlS+iA4uKxSKyY9cSgyksaOzUWdcP+Ld+hc5OCzz2Rs6X8E04Wk/PNHyFINq0PHfGunfXFdjHp4LGn2S1xLiypovAd+Pe7d+kOfAUj/RV6H4Cpa+bLVFW7C8q+ohMewqepChzrY5ecdueIsiRZJ0Ov+tpdZKiW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508371; c=relaxed/simple;
	bh=4U0pdawU5K3EkvrtwAnu4RwK8qBPFQcU8RRQHJlDR5s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dOYhV8Do9DmGLaef8bQNTBPAQZzZmRVrA8/2vugA1BljQccOJy9z7iaT7uJPaAHW9AoTX2Gud6lJepOY1sf6yAgno8veiM7QrK1USDEeatwLvuAk3LWmkV4hqumqoyqAfaGdiTQf79Eugt1vIQKAzrgzOaxhgd5sG+0La8Pyyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzrAqYlD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzrAqYlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72CB1F00A3D;
	Fri,  4 Sep 2026 07:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788508369;
	bh=pbzq0XTwmls3FFV3AU7UuO/jHL5zotZMGdor4Ck16xY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MzrAqYlDG5vvnHOsnBaCXUEUny5H9UN9B8o7QBLvnOGJTsZnAN58VWm85Rbr7tblX
	 q/azTy/O11BMBufl8vKV5IhSIquoumtBId5xLLP1AMPFqSVG6P/5b52s/OBj/sSVg3
	 smazt1hMbO1+tLDF6PTsyP7skgWBikigpPicZ+lQ8L479Zi2drj+yyqNtc1ehyieuP
	 0p7hAAMptC1pnTZAimvo/n3ZI/GYj17wnWJAN4jzc0ONeJqcyR8pe2+EmGgc/RBZNM
	 cREkmoMHJ4komEMQkLPgUYaP7ex9fpH9FH7mglTFFJchppTw2WBntxVFH3BC9cc5sa
	 +TPLlsOe48Ayg==
Subject: Re: [PATCH net-next] octeontx2-af: fix PF/CGX debugfs PCI bus lookup
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com
Date: Fri, 04 Sep 2026 07:52:48 +0000
Message-ID: <178850836833.4131868.13905270816601203708@kernel.org>
In-Reply-To: <20260901044939.2772845-1-rkannoth@marvell.com>
References: <20260901044939.2772845-1-rkannoth@marvell.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] rvu_dbg_rvu_pf_cgx_map_display()
  (drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c) now derives…
- [Medium] The patch fixes only one of the driver's PF→PCI-device
  conversions, leaving the same 'RVU PF n is on bus n + 1' assumption in…
- [Low] The commit fixes a user-visible debugfs defect (the
  rvu_pf_cgx_map file silently omitted every mapped PF when the AF was…

--

octeontx2-af: fix PF/CGX debugfs PCI bus lookup

The rvu_pf_cgx_map debugfs file looked up each RVU PF PCI device assuming
PF0 always lives on PCI bus 1. This commit takes the base bus number from
rvu->pdev->bus->number instead, so the per-PF lookup uses pf + start.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 22ee996768796..bf0302c0c1fc9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -829,6 +829,7 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
>  	int pf, domain, blkid;
>  	u8 cgx_id, lmac_id;
>  	u16 pcifunc;
> +	u8 start;
>  
>  	domain = 2;

[Severity: Medium]
The bus half of the lookup is now taken from the real device, but the
segment stays a literal in rvu_dbg_rvu_pf_cgx_map_display().  Should the
domain come from the same PCI hierarchy?

The driver already has an idiom for this in get_cpt_pf_num():

  drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c:get_cpt_pf_num() {
	...
	domain_nr = pci_domain_nr(rvu->pdev->bus);
	for (i = 0; i < rvu->hw->total_pfs; i++) {
		pdev = pci_get_domain_bus_and_slot(domain_nr, i + 1, 0);
	...
  }

On a system whose RVU AF is not enumerated in segment 2 - the same class
of non-default enumeration this commit describes - would every iteration
hit the "if (!pdev) continue;" path, leaving rvu_pf_cgx_map with only its
header line?

And if some unrelated device happens to sit at segment 2 / bus
(start + pf) / devfn 0, is there anything after the lookup that validates
vendor/device ID before dev_name(&pdev->dev) is printed next to real
CGX/LMAC/channel state?

>  	mac_ops = get_mac_ops(rvu_first_cgx_pdata(rvu));
> @@ -837,11 +838,16 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
>  		return 0;
>  	seq_printf(filp, "PCI dev\t\tRVU PF Func\tNIX block\t%s\tLMAC\tCHAN\n",
>  		   mac_ops->name);
> +
> +	/* All the PF devices are on contiguous PCI bus numbers, but the PF0(AF)
> +	 * may not start from 1 always. Hence get bus number from PCI device.
> +	 */
> +	start = rvu->pdev->bus->number;

[Severity: Medium]
This new comment states an invariant that several peer sites in the same
driver contradict, and there is no shared helper keeping them in sync.

The closest one is in the same file, cgx_print_dmac_flt(), which does the
identical PF-to-PCI-device conversion with the old base:

  drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:cgx_print_dmac_flt() {
	...
	pf = cgxlmac_to_pf(rvu, cgx_get_cgxid(cgxd), lmac_id);
	domain = 2;

	pdev = pci_get_domain_bus_and_slot(domain, pf + 1, 0);
	if (!pdev)
		return 0;
	...
	seq_printf(s, "%s  PF%d  %9s  %9s",
		   dev_name(&pdev->dev), pf, bcast, mcast);
	...
  }

On the topologies this commit targets, does the CGX dmac_filter debugfs
file end up empty, or print real CGX DMAC control/CAM values next to an
unrelated device's name?

The following two are pre-existing and not introduced by this patch, but
they carry the same assumption in non-debug paths.

get_cpt_pf_num() scans buses i + 1:

  drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c:get_cpt_pf_num() {
	...
		pdev = pci_get_domain_bus_and_slot(domain_nr, i + 1, 0);
	...
  }

With a shifted bus base, would rvu->cpt_pf_num stay at -1, so that
is_cpt_pf()/is_cpt_vf() never recognize the real CPT PF/VF mailbox
requests?

  drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c:is_cpt_pf() {
	int cpt_pf_num = rvu->cpt_pf_num;

	if (rvu_get_pf(rvu->pdev, pcifunc) != cpt_pf_num)
		return false;
  }

rvu_sdp_init() encodes the exact inverse of the new comment and derives an
rvu->pf[] index from it:

  drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c:rvu_sdp_init() {
	...
		/* The RVU PF number is one less than bus number */
		sdp_pf_num[i] = pdev->bus->number - 1;
		pfvf = &rvu->pf[sdp_pf_num[i]];
	...
  }

rvu->pf is only devm_kcalloc(rvu->dev, hw->total_pfs, ...) in
rvu_setup_hw_resources().  Can this index exceed total_pfs when the
discovered SDP PF bus number is shifted, and can that write out of bounds
through pfvf->sdp_info?

That same sdp_pf_num feeds is_sdp_pf() -> is_pf_cgxmapped(), which is the
only per-PF filter in the loop this patch fixes, so the stale assumption
still reaches the corrected listing.

>  	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
>  		if (!is_pf_cgxmapped(rvu, pf))
>  			continue;
>  
> -		pdev =  pci_get_domain_bus_and_slot(domain, pf + 1, 0);
> +		pdev =  pci_get_domain_bus_and_slot(domain, pf + start, 0);
>  		if (!pdev)
>  			continue;
>  

[Severity: Low]
This isn't a bug, but the commit has no Fixes: tag even though it repairs a
user-visible debugfs defect (rvu_pf_cgx_map silently omitting every mapped
PF when the AF is not on bus 1).

git blame on the pre-patch tree attributes both the "domain = 2;"
assignment and the "pci_get_domain_bus_and_slot(domain, pf + 1, 0)" lookup
in rvu_dbg_rvu_pf_cgx_map_display() to commit e2fb3730386541
("octeontx2-af: Add debug messages for failures").  Could
"Fixes: e2fb3730386541" be added so stable tooling can determine the
affected history?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901044939.2772845-1-rkannoth%40marvell.com
