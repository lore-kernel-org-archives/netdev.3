Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341301A7264;
	Mon, 14 Sep 2026 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355534; cv=none; b=U16ZqJR78d9PngBMCKM2qukPjEwGK7gnwA3KdAC5WuvFHmPsg1P9VPc6r+UrLtnntqn0Ks2E1J+XzIEqaTo4DIrQfssLZjBkeGVoA93RStWdpvWZiEs4FWu8YoWDaMJGzQsZ3+tWHcU8jYrsP8ttej257P1g9H18nZUQrs8o1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355534; c=relaxed/simple;
	bh=HRUvBxom06p5oY1GjniaQ0fJInnnGvb3b+81UHY74j0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMaIBiqo5Pi7E/W1Oe/a5/LneFihfq8kIWmvATOK2Pqm7WURpKNCRZaHcPOzbl1fb1kKh5XAXR6b2pAE2reutEL8QR9pnImZ5fI5AWqF5NGf9lnxQNhgsm3OsPmoUrUbOXoVxbeP4Dci8gVitpmjsj83vt0Ht1/c3iRcN7XcgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KBHFigls; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KBHFigls"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2eKo92115305;
	Sun, 13 Sep 2026 20:12:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Tfg2yuBKplhGObTTcLkBE8LVN
	SXsAPk2h8cfT7qA+e4=; b=KBHFiglsSFpoXfN53WlH4BECvWciyl0/2x557mIqB
	HLlpGYp+hgYVimndI4v3G/5t8AEKe/6JbCJMsEOGpWftfpakF+CTiWt+RCDYPQIQ
	TyAxX/txuTuAE+BTKpyTQPKNgx48NCTid53IqnCyb59D4cEWzGYRkz6PEsMj+N6X
	78fAY5ArHlzEnEvKJ+ITjzhFbFdjXepXg3YOLOmwnevUnTuGZx935sQ0FI/uqSlq
	OcjfoWdQGDNtzGgqOzqkh8E0DlY3ZgriAprtr3P0yGvkxHody5xKpRnaTinccwIo
	Dxvnghhjq+3x0M6W5sKh7JywVOJ2FrsKIBnwHlOD4T4ug==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gnqg6secr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Sep 2026 20:12:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 13 Sep 2026 20:11:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 13 Sep 2026 20:11:59 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 8C5BE3F706F;
	Sun, 13 Sep 2026 20:11:55 -0700 (PDT)
Date: Mon, 14 Sep 2026 08:41:49 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Slavin Liu <bolin.liu@seu.edu.cn>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] octeontx2-af: validate MCS blocks before
 initialization
Message-ID: <aqdl9TJwfk7BrFOU@rkannoth-OptiPlex-7090>
References: <20260913125206.109985-1-bolin.liu@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260913125206.109985-1-bolin.liu@seu.edu.cn>
X-Authority-Analysis: v=2.4 cv=A9/5rKWG c=1 sm=1 tr=0 ts=6aa76600 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=ZEDPxXDkaXkqBP0yybcA:9
 a=CjuIK1q_8ugA:10 a=4Pbm1F1Cy1QVNLGpYn_S:22
X-Proofpoint-ORIG-GUID: wd0xU3CueG7-CsIppAFhwkrbEWBCUhyr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA0MSBTYWx0ZWRfX93DifJsj7FJf
 +t9K4E9G8dL001DoDfgHpGqlyOu4F1ZOzZTT/F7fwItDEGMFyU4vMJckuE2G6WCGmxyqu5Bb5db
 T444B3T2mDaYjIV0uwQ9A1SWYysynl8=
X-Proofpoint-GUID: wd0xU3CueG7-CsIppAFhwkrbEWBCUhyr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA0MSBTYWx0ZWRfX0pJR1Rtffd7M
 bBrjpy3nT5vhVb5kqD0Fy270zK46m3tELv05a4L3fuYIPky/eF77OBXhHrg/O23vNQlSRiRvVCB
 j2xceBIUsSe7xI0EgcsmiJCA4mCbd4i8/EV3xyZ6WnU7b0GqLrXLh7dh7g2a9AdG+6iNM7ix2oA
 gw3gc4JUst0HZSOL9wu2+HEFAN7zB0uHfagmSNroQU80ZKHyuvsDcjaa0yXfqlnToOZd3b6TL+Y
 NqGO0l/jt9+sd2bqj4/3DnHRwWoXkbWSl9cctJHgiVbBPEe/9ETQG7Y0qTpOATQw4OqBosMYuqF
 VVV9uV8qKX9XXD/DgZwo347ZpU9GUi1RU+dhKa6nc28+6ZHOTKZBTkanRZty5cq1w772LE4QfJr
 FT6nnEh9k36Rt7fP1bDZHLD6aMmXHncT/gvVtNItng9bAXWkRZE68Wm7EUB4ngEjQ19pXqioboS
 8K4EFV8CIbTgFuqpx6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01

On 2026-09-13 at 18:22:06, Slavin Liu (bolin.liu@seu.edu.cn) wrote:
> The MCS count is a maximum successful ID plus one, not proof of a
> dense device set. Validate the complete range before programming any
> block, so a failed lower-ID probe cannot cause a NULL dereference.
>
> Detected by static analysis and reviewed with AI-assisted source auditing.
>
> Fixes: 080bbd19c9dd ("octeontx2-af: cn10k: mcs: Add mailboxes for port related operations")
> Assisted-by: LLM
> Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> index fce22e314cac..0ee2d0d698e5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> @@ -889,6 +889,11 @@ int rvu_mcs_init(struct rvu *rvu)
>  		rvu_mcs_set_lmac_bmap(rvu);
>  	}
>
> +	for (mcs_id = 0; mcs_id < rvu->mcs_blk_cnt; mcs_id++) {
> +		if (!mcs_get_pdata(mcs_id))
> +			return -ENODEV;
> +	}
Do we need to move this up to apply for cn10kb as well ?
> +
>  	/* Install default tcam bypass entry and set port to operational mode */
>  	for (mcs_id = 0; mcs_id < rvu->mcs_blk_cnt; mcs_id++) {
>  		mcs = mcs_get_pdata(mcs_id);
