Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284C3B6C0C;
	Wed, 19 Aug 2026 04:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787114359; cv=none; b=MWSernea1iEQcEVQsISDii3H1ByV6tVu95LCjaZFhQ1dN2IKuxBfy02DHwn9ASecSAIzK7Rrfy+M7Ux8wipN4zTN824tvMLoTapc3mUiHdHZB+ZSGOF07a7dsKK86Q/InOttGiR7YxjtzNYaHP8n0tX1YMMtDXIBz0tC/HCBpOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787114359; c=relaxed/simple;
	bh=ImZo4E2AMGP1sngbCZMQ/6T4jS1FT2tuuTfTB6vJNeg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlG77rNICXAR2QyY8PWJEvVxHvVJtjahoNIk/8fpaHwMdLk/6/1GqZZJi3F3qN+bIH7o4uVUIiZL3MzYLZ9PB9B/GLMir6QM3ZcubXhH1Nnd6TeQxPZEzIyly3DE4OmOZVAQwK0w1AH5Q1l5ltY2lpYdmBJDwes+k0N8w8juwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bdBYh1SK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bdBYh1SK"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J2nngw2319836;
	Tue, 18 Aug 2026 21:39:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=c5UEw0rLlRUu6csCqicHaCUZw
	xYtcObTOODcNfNebnY=; b=bdBYh1SKYK8Eg/P4VrwS1S5HTeS3kgLa8NdLx0heJ
	GGTgfXwHB3gLpy4qQS2XvNlBM/YZ4LuykO/tKy0b2pacyVP2V2k2FpU1AGioIyC5
	8NpUewrAnABC7VBB19u+eLCA95vbvXY15CZIbcJ1zPEbNEWr7lzUj84TdhGqB9cm
	x3tOgFsa6n//idy1sOTexL9m78EXwE4AExkPNHd4l5m/rjF0L6CE56tDBFmRqr1S
	+tWvUVRUsKrPO7O0tQgI+aASnZRWLrh3qGRoYJfYKgg9gbhY1YPR+nfCvACgpzS+
	dfkv/BbM7U5XcYnGN94YVy8oT20CycY8chWz1M8FkoRRg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g4yew98y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 21:39:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 18 Aug 2026 21:39:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 18 Aug 2026 21:39:00 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 788133F7060;
	Tue, 18 Aug 2026 21:38:56 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:08:55 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
CC: "cjacob@marvell.com" <cjacob@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "hkelam@marvell.com" <hkelam@marvell.com>,
        "jbrandeb@kernel.org" <jbrandeb@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "sgoutham@marvell.com" <sgoutham@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: poll for TX link credits before link
 mode change
Message-ID: <aoUzX2qMMDmp2_fB@rkannoth-OptiPlex-7090>
References: <20260818033652.2038116-1-rkannoth@marvell.com>
 <PH0PR11MB5902CB2559DB564EA0F2488EF0A62@PH0PR11MB5902.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5902CB2559DB564EA0F2488EF0A62@PH0PR11MB5902.namprd11.prod.outlook.com>
X-Proofpoint-ORIG-GUID: TevRE_osi8zJhPpoC7GdP5wx3amaW49T
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzMiBTYWx0ZWRfX2yCpWeTGgR5z
 /MB5uQzYV4J5JG03/Rqre5nQ7QmVw4khkpDhdHG4Xihyi4ycziH8jNHXDEFyGnMaO0655bfhQpF
 bENXD39YtR6uhWiqFvAkbRLI+tzCm+Q=
X-Authority-Analysis: v=2.4 cv=Je6Ma0KV c=1 sm=1 tr=0 ts=6a853365 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=QyXUC8HyAAAA:8
 a=M5GUcnROAAAA:8 a=cUxEQTzyCnlu3EwXTy8A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=ZFRsO2Wz9R1JO6LuwK9s:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzMiBTYWx0ZWRfX5Eyxj2F6MwFI
 MegUMB4eB15DGp+pnhLWeovzGp7cihm7H1zFHa8KWdcfS0IUIq3xeHqtiP6CXj1qpdC7g1lUDVH
 bntygWelE9fDi0cRrL163Dl0xgy3niieKHaapp6icdowHv4EFf/odc8t+p5Ooq7r50L2gltmJh5
 bYjRS7UKz4/bl4zxgV3JIewE55P/pCBS50MtNgfbUOd2UUmVEGeDGYQa3KK1VeK9oLGuXiVPdc+
 AnRUP911vYfiKab2aD9nuRzt7PUuqdRKwa9n3BZswmh3+qRbIVKwwu6sV8aPoeE/Bv4kOvjAoEV
 bFLjZZMlUmhy7Llkkw+yEQ0RRk394idxhVFWM3BP17Zvf/NavSStcuOq2prAmhWcYyBaBBT/V5t
 dGUx0O2Crp/XB2ICo2OTm69cyPs4mcRX/x+Vr8lWrl/S97P9dXsvjgFZUFf4hjNSwtUz/567SHS
 WqGzSe99H9yFTUSGy4A==
X-Proofpoint-GUID: TevRE_osi8zJhPpoC7GdP5wx3amaW49T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01

On 2026-08-18 at 13:08:48, Jagielski, Jedrzej (jedrzej.jagielski@intel.com) wrote:
> From: Ratheesh Kannoth <rkannoth@marvell.com>
> Sent: Tuesday, August 18, 2026 5:37 AM
>
> >+int rvu_nix_tl1_xoff_wait_for_link_credits(struct rvu *rvu, u16 pcifunc)
> >+{
> >+	int link, blkaddr, count = 1000;
>
> count can be declared inside the loop as it's not used outside
> same for regval
historically the Linux kernel required declaring all variables at the beginning of a function or block.

>
> moreover defs instead of magic is always better choice
AFAIK, this is not a magic number but a counter.
Could you show me the Kernel coding guidilines which mandates this ?

>
> >+	u64 tx_credits, regval;
> >+	struct nix_hw *nix_hw;
> >+
> >+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
> >+	if (blkaddr < 0)
> >+		return NIX_AF_ERR_AF_LF_INVALID;
> >+
> >+	nix_hw =  get_nix_hw(rvu->hw, blkaddr);
> >+	if (!nix_hw)
> >+		return NIX_AF_ERR_INVALID_NIXBLK;
> >+
> >+	/* set TL1 sw_xoff */
> >+	link = nix_get_tx_link(rvu, pcifunc);
> >+	rvu_write64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(link), 1);
> >+
> >+	/* wait for link credits to return */
> >+	tx_credits = nix_hw->tx_credits[link];
> >+	while (1) {
>
> cant we use just for loop if this is simple cnt decrementing?
Do we see any advantage ?

>
> >+		regval = rvu_read64(rvu, blkaddr, NIX_AF_TX_LINKX_NORM_CREDIT(link));
> >+		if (((regval >> 12) & 0xFFFFF) == tx_credits)
>
> FIELD_GET(GENMASK(31, 12), regval) ?
ACK
