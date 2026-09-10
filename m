Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24ED37C10A;
	Thu, 10 Sep 2026 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008792; cv=none; b=sGoypTabEVwAjXvsbd5DFLnDa0x2mmTHPrAx6uu+7+HayvuTHNw3J80Pco/bVAFCRkaauxbHJciXBraCqZ6nWyJAjoINX4r6lE25srx9Iu2T/WocDRcY2lwWWQOhFkhYzciCmKsr+g1QsIDYrm1a6cbdPy4M7cUGoEBQCIYxgyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008792; c=relaxed/simple;
	bh=43FG7pkpL/skF9Ii9G7n8wA1bnEefSTZ5+H9O0X6wmU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B0rWc+XGy/FTJRBMc6EUzndWNZFNNvLi2IOte8RJ8lvFb4yDUAr0V3E3JMmrvlCtUMWEcOz6QBOnhM4Zr7deSdjnpP2VBwf+8HXoVaCvLrTLG7pJj7jcAHHgyt9Qt7LeH6FJc9V2it36KlcGAi/ebBLRRYUEaZ2jxkdIDIzrywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQT99cNF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQT99cNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9711F00893;
	Thu, 10 Sep 2026 02:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789008790;
	bh=dQgDCT5aZalq1n0/D0fRroWpHmS8F4tkO1hZ7FGOReI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cQT99cNF2krihWnpIe3mvi76S9xr1or1Ol/pY5w1WviKGcG50aGB3RDVSXzolbsXV
	 nksIdIcm6Pe0hnyYHEv4PLqvO8P+WXYhNXGY+uxm11d9HZfhyJPdGnlVGkxU5cr17g
	 f6ndYWey7xztX+ILyFjWHGWEudBrP/dSoqXl1cz+aTXIzLH3deZEwfBudqfQBdq/da
	 Sp3xhb60yMnhCJovIbQEIh3QGMVIF5Fpb3jtYf/lbeHDKUgDFouq4BQq7ifJZf8d7S
	 Qo27x3Ekt1kIinYD6kfC+zlfDJWCvUVVJ3TxButGBG6GRtNPmGBg3n8Xc72Civoj4b
	 yTAUX/wRAlbtA==
Subject: Re: [PATCH v2 net] octeontx2-af: fix PF/CGX debugfs PCI bus lookup
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 rsaladi2@marvell.com, sbhatta@marvell.com, sgoutham@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Date: Thu, 10 Sep 2026 02:53:09 +0000
Message-ID: <178900878938.219967.12274726532197277893@kernel.org>
In-Reply-To: <20260904085114.3385530-1-rkannoth@marvell.com>
References: <20260904085114.3385530-1-rkannoth@marvell.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 1

- [High] Incomplete fix: the identical PF->PCI-device lookup in the
  sibling CGX debugfs file is left broken.
- [Low] The recorded commit message describes only the bus-number change
  ('It assumed PF0 always sits on PCI bus 1 and derived other PF bus…

Pre-existing issues:
- [High] get_cpt_pf_num() (rvu_cpt.c:387-407) derives the RVU PF number
  from the PCI bus number using the assumption this patch declares…
- [Medium] The inverse bus->PF translation in rvu_sdp_init() still
  hardcodes base bus 1 and is consumed from inside the function this…

--

octeontx2-af: fix PF/CGX debugfs PCI bus lookup

This changes rvu_dbg_rvu_pf_cgx_map_display() so that the PF-to-CGX map
debugfs file derives the PCI domain and the base bus number from the AF
device (rvu->pdev->bus) instead of assuming domain 2 and bus 1. Each PF
lookup now uses pf + start.

A few questions below.

>     Use rvu->pdev->bus->number as the base bus instead, so each PF lookup
>     uses pf + start on systems where RVU functions are on contiguous buses
>     but do not start at bus 1.

[Severity: Low]
The changelog only describes the bus-number change, but the diff also
replaces domain = 2 with pci_domain_nr(rvu->pdev->bus), which is a second
independent behaviour change for systems whose RVU devices are not in PCI
domain 2.

The only mention of it is the "v1 -> v2: Added fixes tag, and fixed domain
number" note below the --- separator, which is dropped when the patch is
applied.

Since this carries a Fixes: tag, could the commit body also state the
domain change so backporters can see the full scope?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 22ee996768796..904374baae6f3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -829,19 +829,25 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
>  	int pf, domain, blkid;
>  	u8 cgx_id, lmac_id;
>  	u16 pcifunc;
> +	u8 start;
>  
> -	domain = 2;
> +	domain = pci_domain_nr(rvu->pdev->bus);
>  	mac_ops = get_mac_ops(rvu_first_cgx_pdata(rvu));
>  	/* There can be no CGX devices at all */
>  	if (!mac_ops)
>  		return 0;
>  	seq_printf(filp, "PCI dev\t\tRVU PF Func\tNIX block\t%s\tLMAC\tCHAN\n",
>  		   mac_ops->name);
> +
> +	/* All the PF devices are on contiguous PCI bus numbers, but the PF0(AF)
> +	 * may not start from 1 always. Hence get domain and bus from PCI device.
> +	 */
> +	start = rvu->pdev->bus->number;
>  	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
>  		if (!is_pf_cgxmapped(rvu, pf))
>  			continue;
>  
> -		pdev =  pci_get_domain_bus_and_slot(domain, pf + 1, 0);
> +		pdev =  pci_get_domain_bus_and_slot(domain, pf + start, 0);
>  		if (!pdev)
>  			continue;

[Severity: High]
The subject says "PF/CGX debugfs PCI bus lookup", but the sibling CGX
debugfs lookup in the same file is left with the old assumptions.
cgx_print_dmac_flt() still has:

	pf = cgxlmac_to_pf(rvu, cgx_get_cgxid(cgxd), lmac_id);
	domain = 2;

	pdev = pci_get_domain_bus_and_slot(domain, pf + 1, 0);
	if (!pdev)
		return 0;

and it is reachable through a registered file:

	static int rvu_dbg_cgx_dmac_flt_display(struct seq_file *s, void *unused)
	{
		return cgx_print_dmac_flt(s, rvu_dbg_derive_lmacid(s));
	}

On the very systems this patch targets (AF not on bus 1, or not in domain
2), does reading the CGX dmac_filter file just produce empty output because
of the "if (!pdev) return 0;" early exit, with no header and no error?

And if the domain does happen to be 2 while the base bus differs, can the
lookup resolve an unrelated PCI device at that bus/slot and print its
dev_name() as the RVU PF?

After this change the driver holds two contradictory rules for the same
PF-to-BDF mapping. Would it make sense to convert cgx_print_dmac_flt() in
the same patch?

[Severity: High]
This isn't a bug introduced by this patch, but get_cpt_pf_num() in
rvu_cpt.c has the same wrong bus base in a non-debugfs path. It reads the
domain dynamically yet still probes bus i + 1:

	domain_nr = pci_domain_nr(rvu->pdev->bus);
	for (i = 0; i < rvu->hw->total_pfs; i++) {
		pdev = pci_get_domain_bus_and_slot(domain_nr, i + 1, 0);
		...
			cpt_pf_num = i;

With the AF at bus start != 1, either no CPT device is found and
rvu->cpt_pf_num stays -1, or the device found at bus i + 1 is really RVU PF
(i + 1 - start), so cpt_pf_num is shifted by (start - 1).

Can that shift then deny the genuine CPT PF/VF, given is_cpt_pf() /
is_cpt_vf() compare rvu_get_pf(pcifunc) against cpt_pf_num and gate
CPT_RD_WR_REGISTER, CPT_STATS and CPT_RXC_TIME_CFG with
CPT_AF_ERR_ACCESS_DENIED?

	if (rvu_get_pf(rvu->pdev, pcifunc) != cpt_pf_num)
		return false;

And with cpt_pf_num == -1, does cpt_inline_inb_lf_cmd_send() index the mbox
array out of bounds?

	req = (struct cpt_inst_lmtst_req *)
	       otx2_mbox_alloc_msg_rsp(&rvu->afpf_wq_info.mbox_up,
				       cpt_pf_num, sizeof(*req),
				       sizeof(struct msg_rsp));

otx2_mbox_alloc_msg_rsp() in mbox.c does not validate devid:

	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
	...
	spin_lock(&mdev->mbox_lock);

This path is reached without any is_cpt_pf() gating on non-otx2 silicon:

	rvu_nix_lf_teardown() -> rvu_cpt_ctx_flush() ->
		cpt_inline_inb_lf_cmd_send()

Should get_cpt_pf_num() also start its scan at rvu->pdev->bus->number, or
at least should cpt_pf_num be validated before it is used as an mbox device
index?

[Severity: Medium]
This is a pre-existing issue, but the inverse bus-to-PF translation in
rvu_sdp_init() still encodes the base bus 1 that this patch declares
invalid:

	/* The RVU PF number is one less than bus number */
	sdp_pf_num[i] = pdev->bus->number - 1;
	pfvf = &rvu->pf[sdp_pf_num[i]];

Under this patch's premise, shouldn't the inverse be
pdev->bus->number - rvu->pdev->bus->number?

With a base bus start != 1, sdp_pf_num[] is offset by (start - 1), so
is_sdp_pfvf() compares rvu_get_pf(pcifunc) against a wrong PF number. Can
that make a non-SDP PF pick up SDP channel/ring parameters through
pfvf->sdp_info while the real SDP PF is treated as an ordinary PF?

This is also visible from the loop being changed here, since
is_pf_cgxmapped() consults is_sdp_pf():

	return (pf >= PF_CGXMAP_BASE && pf <= rvu->cgx_mapped_pfs) &&
		!is_sdp_pf(rvu, rvu_make_pcifunc(rvu->pdev, pf, 0));

Separately, the index is unchecked while rvu->pf is allocated with only
hw->total_pfs entries in rvu_setup_hw_resources():

	rvu->pf = devm_kcalloc(rvu->dev, hw->total_pfs,
			       sizeof(struct rvu_pfvf), GFP_KERNEL);

If pdev->bus->number - 1 >= hw->total_pfs, does &rvu->pf[sdp_pf_num[i]] and
the following pfvf->sdp_info assignment write past the array? I could not
confirm from the tree that a shipping board combines a non-1 base bus with
an SDP PF, so this part is unproven.

Since the patch makes the two halves of the bus/PF convention openly
contradictory, would it be reasonable to fix them together?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904085114.3385530-1-rkannoth%40marvell.com
