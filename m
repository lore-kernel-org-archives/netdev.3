Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0C432E6D;
	Tue, 21 Jul 2026 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618020; cv=none; b=Np0a1Wki/+BMNtPk4QWd1K/4hNMzNlBmVeBHb27YWhvBeuNaee5CQ7+RJ9WYQJUfM5AYTVbd5NksifJWqnoyHtoRgUrrF6oTtGN9wtW4ULxRgu0kdPCVO4lPmIOltImB1dkNTqaya3+wbBah3tg5iALAG+/nh43TVmRQMmYLAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618020; c=relaxed/simple;
	bh=TEQnk1cNQF/vNhqcGHx/+FPZxtB2cMmEWVpBNTaO8X0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjF9fReHinJLCwv5mepHnK8HcVf2xOoIQ6obCUwzuDl2e7qkMPh8ASaDUV/vFPHvddcPpzK44RIuMsoNeOLCfJzec+hWjS5T9MxPQ5m0eXVxOyRzFJtukiGPOab24HYfQYWaIG8Jwz1muBQp+TlD9U/MtoVKYyQTx6rpe/ape2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hIt6xbfs; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hIt6xbfs"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNcVVG3069953;
	Tue, 21 Jul 2026 00:13:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=TAqIWbiQh0VIbaI/MHxPJSqSS
	j6aoc/fOHEVAIsr55I=; b=hIt6xbfsZmGBBu8KiUL8NqprvX78zTo3AgNMfILfN
	uBEZ5bwPLSPku7Gh3MWa249gvWOPJ+qQ9DQ8wGc+zym/fIQbg2n+amIaTiJgMCq7
	p/4dipYBG1VDiwPnWdTY6ZQOWy+RHGeOlDtCHXFv4i38JTaqtKGXnl4d2bXf9/b7
	IUHiFpgBHU/2v97IgOzu7qUrOz7vPIw35oPNX1EqhUE+wbGeGiUYFvX8zN04M61h
	AOmCltA+5D6ubhJWK3UhvdKLRqzqfv3pXp4wRmXbkRahpmHdJOincK8IeegyVKjG
	18lf88OXiXWJ9ZIDslytZyLpRXSRlevbnn+dGSPPY0eXg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fhwdkh34f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 00:13:31 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 00:13:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 00:13:30 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id B410B3F7064;
	Tue, 21 Jul 2026 00:13:27 -0700 (PDT)
Date: Tue, 21 Jul 2026 12:43:26 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <hkelam@marvell.com>
Subject: Re: [PATCH net-next] octeontx2-af: npc: Warn on NPC_IPSEC_SPI key
 overlap
Message-ID: <al8cFr8QoSPBe3lJ@rkannoth-OptiPlex-7090>
References: <20260713144247.545592-1-rkannoth@marvell.com>
 <20260720171857.278396-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260720171857.278396-2-horms@kernel.org>
X-Proofpoint-ORIG-GUID: ltPDQMb0lZcGsQaz1BK4E70ry98Ef14B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA3MiBTYWx0ZWRfXxRGYjAlLdo3x
 SwiO/kegRSddiHqbGk13/Ma3LYo6gHju+pcsdZIG9XA+ybO321rxwbvX/tHWrCNcyoKut5gvmaH
 6LxwtC+ryw9R2LizSHcsnxPh6GfHz0M=
X-Authority-Analysis: v=2.4 cv=TrXWQjXh c=1 sm=1 tr=0 ts=6a5f1c1b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=L5NBAv4ctI4W4I7cCX0A:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ltPDQMb0lZcGsQaz1BK4E70ry98Ef14B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA3MiBTYWx0ZWRfX5zPFDT5U3e9g
 O7CsgSFbXVIG1Wb5bNcaw6BEr1cksjPt80Omppx1chTDvXwA9dwkneZnklWkq2TFrz4vpTYEOD+
 Hx0iOcHzaUzuBUgkt+6IcLWrRpZfJABVIbOQCoPJ7FXm78yHzPRkpQbD6PaelZfeIQQ8cDDeUtG
 AEkwmHFHqVz7eT/3xO2cTqYmkK49Ko8bjR+C85IwXvDU171QZzeoA78E8uyMfjiI+cC/8opyFg6
 meRh09tnUIf1P8YlT1PQJbPuby/ej2Bmat+7dOFwwusrtqgGv/Wg7WPfNq6YpKrqxMGJsYDs+Kk
 zLchR+eMTm2GnDAcrDnKcRPwqEvGK8V/VFE14575Ri2MP3Xr8pHxIhigeDy9NOB/2vAQ4ojMZiw
 WQkRckf323s7VIDb0WQvQXV6F2bG7T9p+KIRnXxfF8vdoPtwnClqwUlDzsMbYsEWBx8Zsz3T9Xu
 MsB0rh/NKjedFwkqPsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01

On 2026-07-20 at 22:48:58, Simon Horman (horms@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> https://sashiko.dev/#/patchset/20260713144247.545592-1-rkannoth@marvell.com?part=1
> ---
> --- Patch [1]: [PATCH net-next] octeontx2-af: npc: Warn on NPC_IPSEC_SPI key overlap ---
> commit f018da26dc974202fbe56b064f0bc0375c74613a
> Author: Hariprasad Kelam <hkelam@marvell.com>
>
> octeontx2-af: npc: Warn on NPC_IPSEC_SPI key overlap
>
> When scanning the MKEX profile to determine supported NPC features, warn
> if the SPI extraction field overlaps with other key fields. AH and ESP
> may legitimately use the same key offset for SPI, so continue to
> advertise NPC_IPSEC_SPI via npc_is_field_present() instead of treating
> the overlap as a hard failure.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> > index 91b5947dae060..b217c1c19810a 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> > @@ -730,6 +730,9 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
> >  			*features &= ~BIT_ULL(NPC_OUTER_VID);
> >
> >  	/* Allow extracting SPI field from AH and ESP headers at same offset */
> > +	if (npc_check_overlap(rvu, blkaddr, NPC_IPSEC_SPI, 0, intf))
> > +		dev_warn(rvu->dev, "Overlap detected the field NPC_IPSEC_SPI\n");
>
> [Severity: Medium]
> The commit message notes that AH and ESP may legitimately use the same key
> offset for SPI. However, will this new dev_warn() trigger anyway for those
> valid configurations?
>
> If an MKEX profile configures AH and ESP SPI extraction at the same
> offset, npc_check_overlap() will still see them as mutually exclusive fields
> with different lids (LID_LD and LID_LE). Does this result in spurious
> warnings polluting the kernel log on valid hardware configurations?
>
> [Severity: High]
> This is a pre-existing issue, but does npc_check_overlap() have a data
> race when called concurrently?
>
> Looking at npc_check_overlap(), it assigns a local pointer to the shared
> scratchpad array and then mutates it:
>
> rvu_npc_fs.c:npc_check_overlap() {
> 	...
> 	dummy = &mcam->rx_key_fields[NPC_UNKNOWN];
> 	...
> 	memset(dummy, 0, sizeof(struct npc_key_field));
> 	npc_set_layer_mdata(rvu, mcam, NPC_UNKNOWN, cfg, lid, lt, intf);
> 	...
> }
>
> If multiple VFs simultaneously send mailbox commands that trigger overlap
> checks across different CPUs, won't they overwrite this global dummy struct
> and corrupt each other's flow validation?
>
> > +	/* Set SPI flag only if AH/ESP and IPSEC_SPI are in the key */
> >  	if (npc_is_field_present(rvu, NPC_IPSEC_SPI, intf) &&
> >  	    (*features & (BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_IPPROTO_AH))))
> >  		*features |= BIT_ULL(NPC_IPSEC_SPI);

These comments are not valid. Let me modify the code omment so that AI reviewer
wont raise this again.

pw-bot: changes-requested
