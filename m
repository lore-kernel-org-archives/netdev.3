Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519913B7767;
	Fri,  5 Jun 2026 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645692; cv=none; b=Bi79qj0SZTeguXecf3StRofwneRYVECUpWkHT0BFhYOmgSZelyDXPyzYNBwlPjwYXNlhNxOQ5b7LEPd2Ptcj/n2kDUyQ037+eOF+RQ91WFUQpnahHUZSwOTC5jlKHsw1t4pTwh333sMIZVY5hc6k4sE0VyD0IJM1u6ZWoviW97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645692; c=relaxed/simple;
	bh=bLVa+it7Fcgvro+pv1jm7ZG4kvYOadKHZDdsUxgN6uI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfvW4F1Y7+lJlEYLM6haSFhgjAGaAUMCEv496VbpXSZODFHvdv3uc1vROu1mruZ28vYQnoMTqrKaFh0c+N3Kq6kHJ8EuemaUBwCgD2y3eGE+jEP6vWLRmub2zI56UWZ3UUyyQH5rgYzksODK+kNM/KM4oSJBF7d6sJcMkO44TtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IVEFAsoI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IVEFAsoI"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654NS1Zr1933112;
	Fri, 5 Jun 2026 00:48:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=wQSEh8Sz1qZGPBUxTZT2mHSrL
	TncE9qcUGzA4n5NyLI=; b=IVEFAsoIcqRDfUWD3S78EPMED5kRhP52I9ZiqjZAn
	y4wLVBBb3ngmdYVD7YS6sqslsSUwOx0nxE1gabtZy4v0hLiXxVAHEkvTp2++APPl
	k7GGvISQ7k7z/NNFO+HYrOZRZ8du5Z3bWfFMfnjQYCQKB3Z/012VaU18ZTkQdN/I
	qo96Xgv+ZkCzDfLep7h6aYbupWMK811X/vXMBnHyxI0gcxBDbnfFZSsWzYQRZZcN
	LNKSgZMVSTAB5H0vwVi7OquOPr5ABUwuAXGXTnxxjywrgii0BzeYKazCFJ4/PL+q
	HiU2nxGO6rGRwHkKqo/ypIUAhN/6JAg7EnJK4CDF+GwRA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ekk2916a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 00:48:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 5 Jun 2026 00:48:01 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 5 Jun 2026 00:48:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 5 Jun 2026 00:48:00 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 53AAE3F7079;
	Fri,  5 Jun 2026 00:47:56 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:17:55 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 1/9] octeontx2-af: Enforce single RVU AF
 probe
Message-ID: <aiJ_K-Z7bV1Syyde@rkannoth-OptiPlex-7090>
References: <20260605035030.3195141-1-rkannoth@marvell.com>
 <20260605035030.3195141-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605035030.3195141-2-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=MOlQXsZl c=1 sm=1 tr=0 ts=6a227f32 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=PhMr_M3VcTPrr3iKzVkA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-ORIG-GUID: VdwKVJYtSzj-W70ExOloTnELllTISmKo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA3NCBTYWx0ZWRfX/xtX4H9hn3Pi
 k597YJd/e5A4XeBPlbTcndVrVZkAwGfWD50gLT0H11WLSk/n3kilp6bNHDFGyTlmmgeyu0ztUhB
 NkCQNn97wmR4u8K4uATxJqSBCjL5sh6dqyKpl8XxSZYu/pDI8gZosw4L/2RJHTufibDJphgIKSK
 hYOhrR0zoXbKXSjPASDNn8e6Wd9oWCetQ4CmnrBok1crCdTc02B41nEI68Ja+eDggNbNJBj5Dot
 Ap3CEFBFLoZ2RyjJLgozJeUbl29UR4m/ItqUejig9CxQALCI0iu3vS9aumE0V6sBPefI/+oDmgA
 zlsSdihZ7TMG9JKu58YOJTYuGKqn1qItHT9RFvKNyI9VcAmkXKrBhto4Em5w55HgdjSU1+mlPx8
 /5DJBz0ycn2ibtz8RJ/owGkPVcFO/WobxvDhfIVA2WWOQqzUL7ILXuXZciNNvr3HasTDr2p7Qoc
 2qo8lGufxAyA6D/xmRg==
X-Proofpoint-GUID: VdwKVJYtSzj-W70ExOloTnELllTISmKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01

On 2026-06-05 at 09:20:21, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> There is only one admin-function PCI device per system.
> Reject any additional AF probe with -EBUSY so the driver model matches
> hardware and automated reviewers can rely on a single bound instance.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Apologies. Mavell SMTP server had many issues which resulted delaying,requeing, resending
emails. Sorry for the noise. Please abandon this set as another patch (same patch) is
active.
pw-bot: changes-requested

> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 3cf131508ecf..1f0c962e10f4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -3542,12 +3542,19 @@ static void rvu_update_module_params(struct rvu *rvu)
>  		kpu_profile ? kpu_profile : default_pfl_name, KPU_NAME_LEN);
>  }
>
> +static atomic_t device_bound = ATOMIC_INIT(0);
> +
>  static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct rvu *rvu;
>  	int    err;
>
> +	if (atomic_cmpxchg(&device_bound, 0, 1) != 0) {
> +		dev_warn(dev, "Only one af device is supported.\n");
> +		return -EBUSY;
> +	}
> +
>  	rvu = devm_kzalloc(dev, sizeof(*rvu), GFP_KERNEL);
>  	if (!rvu)
>  		return -ENOMEM;
> --
> 2.43.0
>
