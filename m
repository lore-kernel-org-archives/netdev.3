Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB134279FD;
	Wed, 29 Jul 2026 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321584; cv=none; b=KgPy636EpBOgiGGkx1f/e/nLmCL3LzxR7QgpRxRtlhk3Jb4m2Tl+qrnnCplcVL0CiNf5esQqS85paXgJKV/A9Timm6ay1CyidJz52gkP4OAXyFjcPuicT3YMpmzOl4PCHP5XcjAmVreso+uEIKaUsjIXSiVpwgvJJzJsHvffQFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321584; c=relaxed/simple;
	bh=RBTurJF4bjeZsnP9KISRN5qhXaqxY5pWRzre0XhQyho=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueufd0BuggNQEOCEFiwCKy/HAcv0Rnr0FeE5pbFBxkIK+GDLqOhr5yGkK1Hd0XOx2LgP7JhmVRyOSvBDcG7zVzJfA9gnVIhfNivqWgQlpax5lvGm1557YP+uNyyJ4Ihs5fENJI4fJhd2TA4sjhWkDlL6pjFAULlZnm6Ud2V20EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IWi5hqjG; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IWi5hqjG"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7f4xR3755976;
	Wed, 29 Jul 2026 03:39:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=RBTurJF4bjeZsnP9KISRN5qhX
	aqxY5pWRzre0XhQyho=; b=IWi5hqjGXT67eI7FAyFfyO9ApXNHdPM+HcvT71OH+
	TABohiwVs8pDDf3Dl4+MTU5XssJb4/TyE1GKDd/At0tEbvhVDox/1hmI05uIg49+
	2BLh3s09998qFnOT+KuTAG/JWbUcIffhbynisDiuWrhiX+bzaS6HpKnjqKviOqyf
	q/nRE6W5sU8ukLV//IGaq5VxHNdfU7hWxhu3F1KU3bfSc8miuiqzLYCZH0DF7eyM
	dxAq3sgWLPwMYpzq7L48Fj17uMGLB/53w0IurkTcidAaA6e/IFtVvldghbRTPQXt
	kf4uIq2FaoDyywQhr0PKr0nav3Qd1iL4UshCwZAT4dMwQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fq64ghpgf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 03:39:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Jul 2026 03:39:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Jul 2026 03:39:31 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 6055F5B6988;
	Wed, 29 Jul 2026 03:39:28 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:09:27 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <amnYX866mYx02cBe@rkannoth-OptiPlex-7090>
References: <20260727094008.273527-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260727094008.273527-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4OCBTYWx0ZWRfX9GVkFLw0PNHw
 GHWHMWb12GcX1VyQCxf2qoeZEGr/8fVn+UOPKk7kDgX6FVbtx0WzHWVznsAQGFTAam4NmZu8ml4
 THESXEbnAvSRt5h/ueW5vTgdj6tzrdJ3Oe1/CjFciPrOqbAUKvZyM3wQTqA2mbpeQ+ue3qj4NCw
 AQdPofjT4yf7OqcM9KztKcrt3506IOFJ3dROyteingQy4GtPkagwE2jDQcvo4VLHMfVkYfQGB7Q
 v8sRsLEfozXnhjNfgcVSm7zy2G2KLsfsiJRdhrf5Q4P440M2ZTbFEl10XIqpRri7RA+CYOgcdyi
 YBq6j5WZyREQM7gXKi3pz7ZsfKQp1aL7gph1akYd0ZX8kC/tLzxH9eT7Yvu2/hmKypyznHlk8Ad
 /09r54d0xjmfjtGs5sV4cJOU2EOtAliOjJXIxZ4TC3O/pZ1zgODGiaYbQIykvIjyVaiDydW9VWi
 r7ntRmdsqyaR9k2DNPw==
X-Proofpoint-ORIG-GUID: _U2d5Q5Bk7G_euGq7Eq7e62j2coUCyaN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4OCBTYWx0ZWRfX3bH1LumCimX4
 CGfz6g7JfOiJLGqHszq+0KNbV4of4mJ8f/8wsJwZgBFQjOfsrzD2n/Ok5IXMg+LI3Zjc5UUvSAc
 OWIcRJwcuPT/q7+nePEvcgKbm/qrVl8=
X-Authority-Analysis: v=2.4 cv=GM841ONK c=1 sm=1 tr=0 ts=6a69d864 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=pUhW0NasXGczhlxQT_kA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: _U2d5Q5Bk7G_euGq7Eq7e62j2coUCyaN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01

On 2026-07-27 at 15:10:08, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add TC_SETUP_QDISC_MQPRIO handling to program per-queue MDQ CIR/PIR
> shaping after mqprio channel mode setup, widen SMQ allocation when
> per-queue rate limiting is enabled, and align MDQ parents under that
> mode. Reuse otx2_convert_rate for bps-to-Mbps, fix sparse register
> writes when only one of min/max is set, and improve AF txschq map
> mismatch diagnostics.
>

Will Sahisko address comments (https://sashiko.dev/#/patchset/20260727094008.273527-1-rkannoth%40marvell.com) v3

pw-bot: changes-requested
