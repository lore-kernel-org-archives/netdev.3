Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182D43FD2B;
	Fri,  4 Sep 2026 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511482; cv=none; b=pfyp5fJdWRMm8yjloMQ4ZWs4DWGLmEDgjXNVUALKR4QS1bHHi/+tZkiS8XD0hV0z/NFW2+7OEds90tyVhwwpf5WHSbfZWMVE1E3vC2qJK85PtXS54galqgxm8GlgJ7YqCi/BvJZ5O97YpzxNC+x8B/5uKyy5If9aupYa59z1iCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511482; c=relaxed/simple;
	bh=61urIKvR+fBXt/rexz41f85Z0mE6CPIeycnH+rt7hZQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZHoe+IN1jAZm+HFAN5c0KG7fAmA2hrNmKEXjyWsLH9X8zPDCAPwl6t1CkmSYngdkbWm4ceREWq4DCYif8zkeJfa1y1E6BM7NmJkIWezrfzJtSl2QdDgTaoG8/DIVWwmKnjqQH+eNgmcVOMQee2Knsjqk2vqic0jO0FKAGYrxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=K7Jpq6W7; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="K7Jpq6W7"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68462aJ82050440;
	Fri, 4 Sep 2026 01:44:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=7
	d1070I1Ae+3CJyEiJ14WKuAIk/HH3IgDcz7A+9EBWw=; b=K7Jpq6W7zoPC2hASO
	VxARXd6GAgrXDplFp0eCbOPC6VzAhyKmfa5bxAcyYupEA0cmLm3vPtMtvvI79+l7
	fErkHagmhTyicMBOX0cu3WWZS0mgK5Doh9MYD9K3ElANf8L9LQuBOx6hSySL5tub
	PIGG7dkLX/RjqoQUafqxHEUh5TTxkNo41uub3m9f9AyHdqF+OVIQliVOF49ONYzO
	VKJuf4Y2xqEEiLtwdlNauVnN5TYNOpRsxetxEI/CoNm639AzTqEnX94b6Og8uEwE
	b1dHSJKnbtnXP901CdMSeidwyuOfWRltiDCHLgo0vQ5e40DPTzKaGWRZtVXFM+CK
	Say/A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gfdtsj8sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 01:44:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Sep 2026 01:44:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 4 Sep 2026 01:44:30 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 1AFEA3F7099;
	Fri,  4 Sep 2026 01:44:26 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:14:20 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <sbhatta@marvell.com>
Subject: Re: [PATCH net-next] octeontx2-af: fix PF/CGX debugfs PCI bus lookup
Message-ID: <apqE5CT5_M4coO0m@rkannoth-OptiPlex-7090>
References: <20260901044939.2772845-1-rkannoth@marvell.com>
 <178850836833.4131868.13905270816601203708@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178850836833.4131868.13905270816601203708@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3OSBTYWx0ZWRfXwN2y+0PDVeEY
 P6ovNuCqFA41n2nrAsYkXZZgkwqk9bSpd9WCHFow9Nu/IC72mKxbJxNIEyl3AdDba0lCWDAZ9MH
 TYrzffuhQ1DzaDgiyJsT2R4bGYPwum0=
X-Proofpoint-ORIG-GUID: oZnAtUX_oCWV8DdcR8g1WrhlVQCfBH06
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3OSBTYWx0ZWRfX5TWQnWP5hgws
 ZYXgng5Nb9+xdOLSN9NO7Xb9av+jIKRsbpReEy6J7KjYtRlmT7K9qgXbd71zF/P6zGvqIy5M6wx
 86BMdHGGLOb7mmg8o3ORoLgvLFiNB0bvs9jsWGpPOQK+hR9HtJgZVsj5KCr54Y7XTRvOzk++uxk
 kP1QV8v8WiX96QvyKLB0PXS6M8kn8iv81MvndFPzBccioWIEHtZYzni/UDmdp+dH9jRHnHqGtp/
 UeyCEsX5knqn+LYrf7jI6Z5JmaA0ZEY2H+HAiZWeROzSEQi7iZ3+cOH8PEAQm5HEDtKKOEtC+G0
 O3IzbbwQieA/WPvxljoZkLL1WhaUPq/t+RBbi99tgxhPdg44OL1RpxnBPnlMg3NP+qBi1ld+TZc
 IzKNN7HZnr3rDAmadrrEosneizazlNijw/Dz2fd3eB6aRzkUXruxT2fIzGLP8h9MSFTVZYLGcW3
 JsbPhNjtSG4stZlIw+w==
X-Proofpoint-GUID: oZnAtUX_oCWV8DdcR8g1WrhlVQCfBH06
X-Authority-Analysis: v=2.4 cv=HqxG3UTS c=1 sm=1 tr=0 ts=6a9a84ef cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=zC9DFQm34HchxxdeavQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01

On 2026-09-04 at 13:22:48, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 2 · Low: 1
>
> - [Medium] rvu_dbg_rvu_pf_cgx_map_display()
>   (drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c) now derives…
> - [Medium] The patch fixes only one of the driver's PF→PCI-device
>   conversions, leaving the same 'RVU PF n is on bus n + 1' assumption in…
> - [Low] The commit fixes a user-visible debugfs defect (the
>   rvu_pf_cgx_map file silently omitted every mapped PF when the AF was…
>
> --
>
> octeontx2-af: fix PF/CGX debugfs PCI bus lookup
>
> The rvu_pf_cgx_map debugfs file looked up each RVU PF PCI device assuming
> PF0 always lives on PCI bus 1. This commit takes the base bus number from
> rvu->pdev->bus->number instead, so the per-PF lookup uses pf + start.
will address in v2

pw-bot: changes-requested
