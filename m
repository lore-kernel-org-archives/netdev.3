Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE281D5146;
	Fri, 16 Oct 2026 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123112; cv=none; b=YsTcNcsiM8N7bzoS4/NK5LDFD53l1zpJP7zsH5gbheJAodKLnTPM/AX+npIrkz/lsyneLLTJ4/fhXPyhdCfceox8SbcAGahsV0aNTcipZzH7WnVRI3Knd9q+j/tWvJmOrw1K0E+CIS70gWuEmYJ5nh5/+GQ+17jkufPuXuxHAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123112; c=relaxed/simple;
	bh=o8knNmKbwni93ndQr26ckoCYWTOHKQ7tdW4QMghAOsw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD1LWo6hi5vCPm0YN/jbRObGBVvmuiFp3OZr+qbV64Ex7BIgBVoAyAgEJPqErK2fnwBJCHUdPmoo1IWI9X3ex0EuK3igvfLt4gLG75K1BjKMMBv0+5XRioc/qfLlYOYrl5h72KSTF61o+CP5sa76MEHpIZmD3rFyQBjRleLan+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aSbPCCaq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aSbPCCaq"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G0hHtE3702173;
	Thu, 15 Oct 2026 19:44:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=QT4Awu5TidmNGqflwTrlMnPqQ
	f7PXq4o4cGDIype+IU=; b=aSbPCCaq0UphXQSMVMW35tm7cl6hKNsVjllOvSxZ0
	tZqL3/dmHcYgICDmKu5JAxNtLx8pWIYgoX1p3qoPnu5MkPdjrT5Ls/Yyg7PPsTeg
	u/ZhPGG56ANlFQ2MlNh+ZSTA0/QSCLBN/oOIjOpfUDNYEucAbp3q/rmFYL+DJDQ4
	VhnJH7UrycljSa/0GEh2joKFIV7D3LeMKAq5EdR2CB6+wm9VVIlNSqlGvtNFEkLh
	NhTxmWw5AhLYcWnjNCJDheoJkLFcFGgEWeyRu79rni5KmV2J1/dC6JePY+6vG3/0
	xuzVNikAyod/HLWjXe0QMW/76Yn8CcfbC/xyD9pEbENrg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hapqmde1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 19:44:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 15 Oct 2026 19:44:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 15 Oct 2026 19:44:24 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 52BF33F704A;
	Thu, 15 Oct 2026 19:44:21 -0700 (PDT)
Date: Fri, 16 Oct 2026 08:14:20 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Binbin Deng <18983559317@163.com>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <bbhushan2@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] octeontx2: Fix use-after-free of qos node in delete
 path
Message-ID: <atGPhOA3oH_g1RTm@rkannoth-OptiPlex-7090>
References: <20261014064204.291688-1-18983559317@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014064204.291688-1-18983559317@163.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAxMCBTYWx0ZWRfX5Cx7BpKZut0N
 U8yusISLIY3Q+vlYloiE9NEFtyovMJV9SWun2ZSI+0khH80+s49rAvU96uqnBk4mDzZmHZDNfUT
 XWZxvWcMXGXIlZ5WT7TpYXxHLkTdDgnG2hJRqyofkzOm+W/JLyIV6/3N4TkiuI1ZCx/05OiQmvW
 9p4EfNxCOR4lkHeC+yC+fxhA/Q8ndu4klh+DzDxGWtYdw5ENYpH0n/qIqMXWJ4xe2KaT/pE4wbs
 1rHuWLH3y+sHQW311/SMBh46kCBiL3RFfhNzhg9zNZlVFquN2jlz9a/cZdvVRq9IEDnO/zeaTex
 XjS0To0QMRelon/Vw8uQ2mFXE3LPHAujHJyAFC7gdRymkT4EUUDMZft/5O1IW9RtmLzqtMBvNKm
 tWAMDDGrNBXfMF3K+27kjYFKdThKw3pFZLxXZwEJqC0UJrWkFu/zqlXuDCWxwth/8RjXrxUlTvQ
 QSr7N5GXVLMq9IK5h4Q==
X-Proofpoint-GUID: Bqa6uQRUTSqIv8jb8axeeSeeeetxstTr
X-Proofpoint-ORIG-GUID: Bqa6uQRUTSqIv8jb8axeeSeeeetxstTr
X-Authority-Analysis: v=2.4 cv=U+sHnuru c=1 sm=1 tr=0 ts=6ad18f89 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=Byx-y9mGAAAA:8
 a=M5GUcnROAAAA:8 a=itfu8BSAOx6kz2H9srYA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=1CYo9-gkzx054UpEq_5a:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAxMCBTYWx0ZWRfXzLrwTvvdVPeK
 E/ji5tkwuaCwpcrZjquZ5kkXA5aeOxk46lEd2JXLByqNJx3m1oLv8IfZhVkormnAdu7sS4tCrTf
 TaVHlmrdBWTQCHUzcPtu7sTlx7ju8eQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01

On 2026-10-14 at 12:12:04, Binbin Deng (18983559317@163.com) wrote:
> hash_del_rcu() only unlinks the node; a reader that already holds the
> bucket iterator still uses the node.  The immediate kfree() has no
> grace period, so a concurrent transmit on a socket whose skb priority
> carries the deleted classid reads node->classid / node->qid from freed
> memory (use-after-free in the softirq transmit path).
>
> Fix this by calling synchronize_net() before the node is freed, as
> mlx5e does.
>
> Found during a static-analysis-assisted audit: candidate sites were
> surfaced by a Coccinelle rule, and the reader/writer paths were
> confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
> not observed at runtime; it is identified by code inspection only.
>
> Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
> Signed-off-by: Binbin Deng <18983559317@163.com>

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
