Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03E1A683E;
	Thu, 10 Sep 2026 03:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009373; cv=none; b=K4u0xHbwCaYb9AHS597NURNSjhamPrLW8ZBTroJ2Nlada/wmt/uCULXipDVNOTgx9mjbwBC/zbhV6sUIXQi3gE+MPpdC1eQTiVFmJHBT+hDDu6Go+dGECg2BsP6N9VLCBhAyHhla74lvjPSxGdzHeox98Q8oXQ/neYjL5gffx50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009373; c=relaxed/simple;
	bh=HAnltt5ucZ8eGOz7q5AcsywSk+oMek2SMRODzGGhCgM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccxlNPdqXVxBgN74IGr5XgJoTDW0R8hT8hidKIRqIMp+eVT0D9J+YduH5lrzI0IPyGBiOZSMc7zgFmyXukTqL+rMFrtkoAOhs0AXbaeREeSeFg85vzB9Q7mrtLTRqQQURy2odxrHo6XI6dEee+oejxMvYJ0lmmkwSO3FQifL7Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FxPjN82c; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FxPjN82c"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A1kTeS4088806;
	Wed, 9 Sep 2026 20:02:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
	4aOLs/3M/5pqvBT9+VaQ3Hxb+odCbnrg6sPoQZXELQ=; b=FxPjN82cdl30J7uBh
	SHEOjPzxfUYSPNXikKN3WY9a6xfodN8+32ek4JxzM+7CJt+4mZ0y7xW+yUTCZ0V+
	OxWr16a38w8MgjVr02Q4N6Ix1LOFoWWOyEvlY2XBR5njbqqcIoo7ygrhAwxEXf41
	2FmycX4wZ3V1FGZx0nUV0bgXLKBON0RLNKp2u+5qDTeO1luTem7MaDUBLA+w2us8
	2Hb6xaNjRjH4r5MB53N0uzeaKJ/mYwIcCXYjDQjBW+rI30HlPP6ZbKKgoKHcAEF5
	uut+kF2hWTZj18LEYuDOBmhRKXM+HqY5qVmoTjXvvl3IdBnaeW8nJLDyxuvdHQ1e
	8eYng==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gkcxnsycb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 20:02:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Sep 2026 20:02:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 9 Sep 2026 20:02:37 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 9E9573F7057;
	Wed,  9 Sep 2026 20:02:33 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:32:27 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <rsaladi2@marvell.com>,
        <sbhatta@marvell.com>, <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net] octeontx2-af: fix PF/CGX debugfs PCI bus lookup
Message-ID: <aqIdw4TpfTRTK5km@rkannoth-OptiPlex-7090>
References: <20260904085114.3385530-1-rkannoth@marvell.com>
 <178900878938.219967.12274726532197277893@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178900878938.219967.12274726532197277893@kernel.org>
X-Authority-Analysis: v=2.4 cv=K923jCWI c=1 sm=1 tr=0 ts=6aa21dcd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=xD8CzUW_WXUoMJ0se0IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: LBxqkqQ-57xVRMrnzb0VSqQ5LQEd9Ss-
X-Proofpoint-GUID: LBxqkqQ-57xVRMrnzb0VSqQ5LQEd9Ss-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDAzMSBTYWx0ZWRfXxmhOsJCqPMAD
 ku23YqmfTQkH57K8XuUUUN1oQxbDfVQq/TEB7ylPqbiVrtb3ihRNrKPd8ka15JE2LZwYdAKMHIG
 be939m4lXqSIJ6Bj+RFzPxVZJ+hWS+4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDAzMSBTYWx0ZWRfX9bCsey8w+eJ/
 hEIChhpxX1PB9+dzGB7vpmRe9nGNIh6BHGiZKEkqZW0E3rZi6uCGAuf+k3pX1BmrDew9DcS5TEh
 XTr+6jvJ9V9B+RXlE6f5jdMrOYQ5TmWW3L40AyAHZc9UakloelNsaoSWBOAmwSsLuHXcQzUXrrT
 rSvlSSN6B65t3O3GdeHTfwqLVY4/r/brpan8+a8RpT02sbg+aA138bTv/VsAsNVOI6TzzvWE5Ns
 fd06d7s4Eh+OPnLhdgW4FAN+OHxgrSBAo8ftwQI1tW++C09EtYdQyEW9QkaGAcAnQg0PaTuQtMV
 hjJqL6WjotK8/3l/P4a92o/+dk+Jk/ThV6Q3PkIodMpunllmJOneFfy/5pY4Q3T/+C2vMN2n1yZ
 3qVCL590F47WEo/tOa1sPgO5vnf+tutMFsY0yaCFMz41YEPk7zCM+heZxx3+VzyuZUgfRyL760U
 zznEdg6aOj+ocnudwvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_01,2026-09-09_02,2025-10-01_01

On 2026-09-10 at 08:23:09, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 1
>
> - [High] Incomplete fix: the identical PF->PCI-device lookup in the
>   sibling CGX debugfs file is left broken.
Concern is about a different function, which needs a fix of "domain" field.
Will address in seperate patch.

> - [Low] The recorded commit message describes only the bus-number change
>   ('It assumed PF0 always sits on PCI bus 1 and derived other PF bus…
>
> Pre-existing issues:
> - [High] get_cpt_pf_num() (rvu_cpt.c:387-407) derives the RVU PF number
>   from the PCI bus number using the assumption this patch declares…
> - [Medium] The inverse bus->PF translation in rvu_sdp_init() still
>   hardcodes base bus 1 and is consumed from inside the function this…
Will take these up in seperate seperate patches
>
> --
>
> octeontx2-af: fix PF/CGX debugfs PCI bus lookup
>
> This changes rvu_dbg_rvu_pf_cgx_map_display() so that the PF-to-CGX map
> debugfs file derives the PCI domain and the base bus number from the AF
> device (rvu->pdev->bus) instead of assuming domain 2 and bus 1. Each PF
> lookup now uses pf + start.
>
> A few questions below.
>
> >     Use rvu->pdev->bus->number as the base bus instead, so each PF lookup
> >     uses pf + start on systems where RVU functions are on contiguous buses
> >     but do not start at bus 1.
>
> [Severity: Low]
> The changelog only describes the bus-number change, but the diff also
> replaces domain = 2 with pci_domain_nr(rvu->pdev->bus), which is a second
> independent behaviour change for systems whose RVU devices are not in PCI
> domain 2.
>
> The only mention of it is the "v1 -> v2: Added fixes tag, and fixed domain
> number" note below the --- separator, which is dropped when the patch is
> applied.
>
> Since this carries a Fixes: tag, could the commit body also state the
> domain change so backporters can see the full scope?
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> > index 22ee996768796..904374baae6f3 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> > @@ -829,19 +829,25 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
> >  	int pf, domain, blkid;
> >  	u8 cgx_id, lmac_id;
> >  	u16 pcifunc;
> > +	u8 start;
> >
> > -	domain = 2;
> > +	domain = pci_domain_nr(rvu->pdev->bus);
> >  	mac_ops = get_mac_ops(rvu_first_cgx_pdata(rvu));
> >  	/* There can be no CGX devices at all */
> >  	if (!mac_ops)
> >  		return 0;
> >  	seq_printf(filp, "PCI dev\t\tRVU PF Func\tNIX block\t%s\tLMAC\tCHAN\n",
> >  		   mac_ops->name);
> > +
> > +	/* All the PF devices are on contiguous PCI bus numbers, but the PF0(AF)
> > +	 * may not start from 1 always. Hence get domain and bus from PCI device.
> > +	 */
> > +	start = rvu->pdev->bus->number;
> >  	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
> >  		if (!is_pf_cgxmapped(rvu, pf))
> >  			continue;
> >
> > -		pdev =  pci_get_domain_bus_and_slot(domain, pf + 1, 0);
> > +		pdev =  pci_get_domain_bus_and_slot(domain, pf + start, 0);
> >  		if (!pdev)
> >  			continue;
>
> [Severity: High]
> The subject says "PF/CGX debugfs PCI bus lookup", but the sibling CGX
> debugfs lookup in the same file is left with the old assumptions.
> cgx_print_dmac_flt() still has:
>
> 	pf = cgxlmac_to_pf(rvu, cgx_get_cgxid(cgxd), lmac_id);
> 	domain = 2;
>
> 	pdev = pci_get_domain_bus_and_slot(domain, pf + 1, 0);
> 	if (!pdev)
> 		return 0;
>
> and it is reachable through a registered file:
>
> 	static int rvu_dbg_cgx_dmac_flt_display(struct seq_file *s, void *unused)
> 	{
> 		return cgx_print_dmac_flt(s, rvu_dbg_derive_lmacid(s));
> 	}
>
> On the very systems this patch targets (AF not on bus 1, or not in domain
> 2), does reading the CGX dmac_filter file just produce empty output because
> of the "if (!pdev) return 0;" early exit, with no header and no error?
>
> And if the domain does happen to be 2 while the base bus differs, can the
> lookup resolve an unrelated PCI device at that bus/slot and print its
> dev_name() as the RVU PF?
>
> After this change the driver holds two contradictory rules for the same
> PF-to-BDF mapping. Would it make sense to convert cgx_print_dmac_flt() in
> the same patch?
>
> [Severity: High]
> This isn't a bug introduced by this patch, but get_cpt_pf_num() in
> rvu_cpt.c has the same wrong bus base in a non-debugfs path. It reads the
> domain dynamically yet still probes bus i + 1:
>
> 	domain_nr = pci_domain_nr(rvu->pdev->bus);
> 	for (i = 0; i < rvu->hw->total_pfs; i++) {
> 		pdev = pci_get_domain_bus_and_slot(domain_nr, i + 1, 0);
> 		...
> 			cpt_pf_num = i;
>
> With the AF at bus start != 1, either no CPT device is found and
> rvu->cpt_pf_num stays -1, or the device found at bus i + 1 is really RVU PF
> (i + 1 - start), so cpt_pf_num is shifted by (start - 1).
>
> Can that shift then deny the genuine CPT PF/VF, given is_cpt_pf() /
> is_cpt_vf() compare rvu_get_pf(pcifunc) against cpt_pf_num and gate
> CPT_RD_WR_REGISTER, CPT_STATS and CPT_RXC_TIME_CFG with
> CPT_AF_ERR_ACCESS_DENIED?
>
> 	if (rvu_get_pf(rvu->pdev, pcifunc) != cpt_pf_num)
> 		return false;
>
> And with cpt_pf_num == -1, does cpt_inline_inb_lf_cmd_send() index the mbox
> array out of bounds?
>
> 	req = (struct cpt_inst_lmtst_req *)
> 	       otx2_mbox_alloc_msg_rsp(&rvu->afpf_wq_info.mbox_up,
> 				       cpt_pf_num, sizeof(*req),
> 				       sizeof(struct msg_rsp));
>
> otx2_mbox_alloc_msg_rsp() in mbox.c does not validate devid:
>
> 	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
> 	...
> 	spin_lock(&mdev->mbox_lock);
>
> This path is reached without any is_cpt_pf() gating on non-otx2 silicon:
>
> 	rvu_nix_lf_teardown() -> rvu_cpt_ctx_flush() ->
> 		cpt_inline_inb_lf_cmd_send()
>
> Should get_cpt_pf_num() also start its scan at rvu->pdev->bus->number, or
> at least should cpt_pf_num be validated before it is used as an mbox device
> index?
>
> [Severity: Medium]
> This is a pre-existing issue, but the inverse bus-to-PF translation in
> rvu_sdp_init() still encodes the base bus 1 that this patch declares
> invalid:
>
> 	/* The RVU PF number is one less than bus number */
> 	sdp_pf_num[i] = pdev->bus->number - 1;
> 	pfvf = &rvu->pf[sdp_pf_num[i]];
>
> Under this patch's premise, shouldn't the inverse be
> pdev->bus->number - rvu->pdev->bus->number?
>
> With a base bus start != 1, sdp_pf_num[] is offset by (start - 1), so
> is_sdp_pfvf() compares rvu_get_pf(pcifunc) against a wrong PF number. Can
> that make a non-SDP PF pick up SDP channel/ring parameters through
> pfvf->sdp_info while the real SDP PF is treated as an ordinary PF?
>
> This is also visible from the loop being changed here, since
> is_pf_cgxmapped() consults is_sdp_pf():
>
> 	return (pf >= PF_CGXMAP_BASE && pf <= rvu->cgx_mapped_pfs) &&
> 		!is_sdp_pf(rvu, rvu_make_pcifunc(rvu->pdev, pf, 0));
>
> Separately, the index is unchecked while rvu->pf is allocated with only
> hw->total_pfs entries in rvu_setup_hw_resources():
>
> 	rvu->pf = devm_kcalloc(rvu->dev, hw->total_pfs,
> 			       sizeof(struct rvu_pfvf), GFP_KERNEL);
>
> If pdev->bus->number - 1 >= hw->total_pfs, does &rvu->pf[sdp_pf_num[i]] and
> the following pfvf->sdp_info assignment write past the array? I could not
> confirm from the tree that a shipping board combines a non-1 base bus with
> an SDP PF, so this part is unproven.
>
> Since the patch makes the two halves of the bus/PF convention openly
> contradictory, would it be reasonable to fix them together?
>
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904085114.3385530-1-rkannoth%40marvell.com
>
