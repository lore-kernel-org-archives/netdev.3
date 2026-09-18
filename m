Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227123E334;
	Fri, 18 Sep 2026 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710967; cv=none; b=b2G32Xtiz9OudgNCPx5jCzvNcfJ3wunQQ2G0dUo3YHxf3eFLXpX2mIApbK8Hhhq1z5djvBP0EKGLXXyTm0vwr3120buVdipHM3lgrIrVgVAbIMNsYgLnoylasITErywiTzFuI+XC014WlVMKgt3rsv7j49D7mjWIo1aktgaQGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710967; c=relaxed/simple;
	bh=KCFGA4rDMcZIHlBCko152R4ud+YTFm/tOcNyS3NmT/0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGnDOc1xMtV1F7DXxU7DNYnGsx/p/m4MXNvbfqzGnxla7VzOt9ygztz0SXsWF8cJsv+peltlph/DUBo9mxzOB3pDolOMMocBgRgarLMmMWlffktRpBW18FNP8cMCd5E8tlXu45iavR4917++tOAzN/i/Ex/UfSbx8FVk9MorUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QyOoXlrc; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QyOoXlrc"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I3PU3Q2583830;
	Thu, 17 Sep 2026 22:55:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	We8Si240QbrqgFU1KotVBvNd4i388rrhWqARcyxb1c=; b=QyOoXlrcGlu4EOBNC
	WBgMnTbi2M8fwU6KPZHasUkD/x3BuUG2b2cVkzcGE/2A7MQWmqnVYEMai32CUBN5
	Phuk5ZlsOcMMc7kAK69G0TyLQwYRbeHINaIIvffGQhl12+QpmCf+vp3snvFO6fYP
	IYKu70HOIFgB+mYPo+km3r3JwNoKgFVatrsztbGP84t8Sxevtnez7UpC5msw4AYK
	rtUShQsSAysaFu4za/Gi3t/pqNDuN5378gHUPcGx/7HOhBzltigoGfeJycbNm/AW
	8pvDouALAw81wsHrudVsd00VTZIglyA0bd3QVP1y8POBp73lOUxPI7B702yGnFKC
	7t5hg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4grwcjrjsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 22:55:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 22:55:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 22:55:56 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B7F8B3F7055;
	Thu, 17 Sep 2026 22:55:52 -0700 (PDT)
Date: Fri, 18 Sep 2026 11:25:46 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <davem@davemloft.net>, <gakula@marvell.com>, <lcherian@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <saikrishnag@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: guard is_pf_cgxmapped() when PF to CGX
 map is absent
Message-ID: <aqzSYu6KduRWM42T@rkannoth-OptiPlex-7090>
References: <20260915022952.886639-1-rkannoth@marvell.com>
 <178970941782.22033.17901214089531533321@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178970941782.22033.17901214089531533321@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA3NyBTYWx0ZWRfXxvRfNTULVq7+
 +pFCrNiUDIe16hXwXYj7PijQi6WW9mH7g+/WDp1wfe0iE7k8QqaCjytHzBdBfAuTqj76UYPL8aM
 xoR/LHJdktiP0en59M8nOJyfpW0TegLsq8DoQRrGkQU86oSkf1s9Im3ct//6PU2CgMX5urk1SSI
 fqInAykHyYqVD7lj5goLjJZrVdxzg88ixd6fHxBTB7rUr5R9v7nUvgO3W0PqNkz9Bl2IqKRjzUE
 VDJhu244k1J48m8hhBidn4w4a+cNMd4dL7cNWeO/cU4c/sD6ELkTp99vCMgCvYUN9qsEqGQNqV9
 PHLjMwp6j6zVcfnYhVC3jb/Qc6u5UNdPo9zsb9Z57dMFIg+VakKzds7hTDRcZzG5GlTTxNTVB0g
 bt75SVOPNSqxYlN1D1fRwKeYidnzt4o7aszpGcNWW2Y6qELhkye01vJClZVqz31X/dIFf6ttA8V
 zxWptuhqJqkyf4nY6wQ==
X-Authority-Analysis: v=2.4 cv=bYr+w+PB c=1 sm=1 tr=0 ts=6aacd26d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=8DdJMXqlxYccBHa1dKUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA3NyBTYWx0ZWRfXxpMTYLin0o90
 eqoyD3BEKLgnqL349bc6dkdg1BfytjfcA+BDH9KXeTYxXfjLwzISJvTsRwmT6Y9P2kVzB3kIIqr
 3MCFFeSSUhQuMDdQJX3RMoCBscFxKCA=
X-Proofpoint-ORIG-GUID: t2Ey05JUBUVkElddBAblltZQilMwb48Q
X-Proofpoint-GUID: t2Ey05JUBUVkElddBAblltZQilMwb48Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01

On 2026-09-18 at 11:00:17, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
>
> - [Medium] The added `if (!rvu->pf2cgxlmac_map) return false;` in
>   `is_pf_cgxmapped()`…
Will modify the commit message and will post v2 to net-next as a hardening patch.
