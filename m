Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88263CFF6B;
	Fri, 21 Aug 2026 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307088; cv=none; b=liyDxRzsOwOrFnvrAYNf+DzrQ9mjtq1e7JnaHYeI2UklF93TRyEL1VP5nEiXIiIWkhd1mzjxi+wfAvFBolVGikNdSin2+SBQcL000/4taaklOlBKaC7FUY16LfW8RaQSXYaUZbs+Zx68vBZEIkFhugYl3bcg0rxShCWmvfoVSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307088; c=relaxed/simple;
	bh=vn8PSnxf/IFaEt8oNDb/Ei2xf8JoYm4Lb5zIFJ4wzoU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2eRC5uz1zrwzeaa9wvTGH2XM4ZPjmn5aZ21k7a2NEkvjoK16LArHT61JI9hnpjfI/PlweojHMlc61Efk5NwYwr7fxr7s2Pzy1JGUANCZMEfCLImVsWYqdOATyG7B2UslYPISkVfdqpyCrKUdhyPCOadPWQjKbAV+wlcRuxVlOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Pb9IkZP7; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Pb9IkZP7"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9PwbF4183828;
	Fri, 21 Aug 2026 03:10:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=vn8PSnxf/IFaEt8oNDb/Ei2xf
	8JoYm4Lb5zIFJ4wzoU=; b=Pb9IkZP75EoSowx8sJGDZE0UwukQm1FCuOIXbTZfS
	Hui+/7G2b4EljJ+LhNNvF1iUF7Ivy1IXdfKqJeEZaHhgm99Ol7OdzYQ5QQYwDfLB
	v8I23PvwbQ2K8Uq52Z8LGLV5DPmUJ63BUFwwLG46r+RFXmePPvA2iozHpIWM1vWz
	p+Jk/YmuoIBQqJGrFo0N+tzplnie/JQWrZC9UvxGn12pnSXm6QWq6MEoGGji6sb7
	ZdUXUG7YWutn1aUUBIn1X9LXIWXM1idNIzAVmJnGYi1JXcIH7RaXI2VtdC4FnAxh
	iNJ0Dztvq10bfGMRjBF52HeUmRsp77cscO1FZgnQC+ZVA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g6m1k02ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 03:10:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 21 Aug 2026 03:10:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 21 Aug 2026 03:10:55 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 2B30E3F707F;
	Fri, 21 Aug 2026 03:10:51 -0700 (PDT)
Date: Fri, 21 Aug 2026 15:40:51 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <saikrishnag@marvell.com>,
        <sbhatta@marvell.com>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>
Subject: Re: [PATCH net] octeontx2-af: fix ng_rvu leak on repeated mailbox
 init
Message-ID: <aogkK5l55nvAEN2-@rkannoth-OptiPlex-7090>
References: <20260820053656.2614614-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260820053656.2614614-1-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=UbVhjqSN c=1 sm=1 tr=0 ts=6a882430 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=oygf8xyMqYzuE5L6o7cA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-GUID: Z2J1nZoD-Ri1YUpnh1WwnWZzzYHPco0c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3NSBTYWx0ZWRfXydnRsiYNFBSb
 m+Vka7C6Pdq9iYVTk8yrwpQyI0oc5zwrxfT1U5H5A4xb2+kU1wtgsHte4e8O9hAVyNf3WeHhpys
 QEGehpjFFfPi30R2CFm7gAYYKxPTEDFcEuGTeiDYPqyKU6sJ9YM8EkAINU/KEL+BG93+dpz7cXr
 wJAEi/m/zjCxVs0fl95L2VawW3G/uLXt6ynu7pHAxRIrTi/XNJ30MTKgR5X/ZNL0Iyj5evIgWk7
 UuIT39/70z2W3iNqQ29ajrjOQatoh/zv50VvdY7YEv3cdAtL415W2/P6TLkuPbGYSqJNBn7kr8G
 quWu7Y+UgGcYxNTwKCsH75SNzNTOZ2gewBb3/4ERQXk/t0bnLI5W8cSrBEdgSkbP3R68XBpyOOC
 Y7KIoshuw6Pq64qXVkXqcRDArNXWaf5JvKRyucGKgyQVACWIlw+cn37BcmCBH+0FeA/z6iUpyOI
 1knLmBAJyCJTWST+LVQ==
X-Proofpoint-ORIG-GUID: Z2J1nZoD-Ri1YUpnh1WwnWZzzYHPco0c
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3NSBTYWx0ZWRfXzeu6Ej/9rveV
 mNEDa0zsuQzv+SherQBs0YPJzYNu9UWh6qcImeTbOdbyBLWxpRmTfoGpAgIDwa5hKsxjn3jvIF0
 qpCTNBKYXK2Ct1ChhDwe+tG5eR+wAGQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01

On 2026-08-20 at 11:06:56, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Sai Krishna <saikrishnag@marvell.com>
>
> rvu_mbox_init() allocates an ng_rvu object on every call and assigns
> it to rvu->ng_rvu. The function is invoked separately for AF-PF
> mailboxes during probe and for AF-VF mailboxes when SR-IOV is enabled,
> so the first allocation is leaked when the second call overwrites the
> pointer.
>
> Allocate ng_rvu only once and reuse it across subsequent mailbox init
> paths.
>
> Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Will address sashiko comments in v2.

pw-bot: changes-requested
