Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE233D6E6
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355827; cv=none; b=H9VPm/QWYjd1BfNKZba39g+m+vb80OVKeiziaiMPFjHKHvWSEfjhpuaQKfQ0TWAb7QXSqtgpOS1c4DnjAWgA/hrY8qdL+9bARXEMqa4nnULLQj65IlpCA8Upngw3ymoxL9ZWWGA7/4PzpNdC7bmzeAZvi4oau6Kbr8CDh3jLj9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355827; c=relaxed/simple;
	bh=Gkt/OPG06/9bznvO/Iuk2Q7/02kwk1lB+FB6Wi/2gpw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tczUuy8KOUgUZ86ubJJLMYKlaQP8JGnJBvIuE+CVLeDcE7eQ3jkXuAAGtO+bzAGaSCffpnT0Gx7BX66B0fa3CeqD9vhtASnlTf3IB08C/CwwokUeOfHEH7cmYD6BztGEL2YU8shOb49Mk+t+xu74WsuYNwtpY1JEheROqd0pvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LiqoE4vt; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LiqoE4vt"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2eM5b3644367;
	Sun, 13 Sep 2026 20:02:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Gkt/OPG06/9bznvO/Iuk2Q7/0
	2kwk1lB+FB6Wi/2gpw=; b=LiqoE4vtwwps60uQpp3p04G6Lv0rPzz29Jre6TtFD
	bkdxa9n31eFxmS9dYxvtHyoEaN3ND2TXdof3PTAGd6E5nugeqHPz2KARdxkuZVZT
	t5DayNviuEOAQOuWLUqWRAg8ljAH8+MA3TBe0WBn7O3vZhFw6UXLNbaKzzrCQyNo
	+OomIIIAfYzeo9wYsxdoBkPJOtinRYel3gCSmZRQkFn2lY6HMU0uJvi2MH4PPRJI
	3bNSPa0zPgheXH6Wvbj7FnQ0OHvO4R/Qv61GhAabqJN9Jg5I1nGl0fEwbOObrmxg
	c6WptmZUeMsqQIpeEEbPV6o7545vfSFzEKHzZg44OA2lA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gp7vyg2ek-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Sep 2026 20:02:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 13 Sep 2026 20:02:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 13 Sep 2026 20:02:11 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 802793F706F;
	Sun, 13 Sep 2026 20:02:09 -0700 (PDT)
Date: Mon, 14 Sep 2026 08:32:03 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Heyang Tan <thy15333007817@163.com>
CC: <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>
Subject: Re: [PATCH v4] octeontx2-af: use seq_file for rsrc_alloc debugfs
Message-ID: <aqdjq-dSEFpDPD4g@rkannoth-OptiPlex-7090>
References: <20260914020521.146-1-thy15333007817@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260914020521.146-1-thy15333007817@163.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAzOSBTYWx0ZWRfX5rXIgRn3/URt
 dOYv3P6NTwuaIWlQ5RF/4S3Zd6Pz+Q4a1IDNyhrrfYYxMQI+YAXSOHeFD0g1XYzi716LDiktOny
 zR6sEnVUdSsPXYuvv/51tVRJXLyzBtk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAzOSBTYWx0ZWRfX6WqEqhLpOsWB
 DUnsxtP7wz5oxCda5zW1aNbj2HcQDhYQW4nceKomvM9kvfGXmlPcgoeFp5PVkQ3Vt4NJ66NFq30
 yJraIQr5hkKh9rqHTCH6gdOTt/v50/AgRVY/oF7JcT1e0Vm+nHIFmvXbA9I66MAR5hxK/5x3PX3
 yA44U4N8jcFeTLhyRwsqnsuVTLNor3nbhXbG9H1l5yCDSVnAqIBvc3jybtd53SRpVd16B6WwFb/
 1kN8obphyvqX3aJJr4m4DoM0QzlOWbZJVeZ6YOhr4nhh85WycIXeNYMi3dPSyqOL8Wdz28+5C9z
 9btjT1hTaphH6Oy5X25hCceQmP97QkU+wLGQSfjTd8Q0fzpLBR8iN46kaZQYipvP30LQSMstohg
 LBLoIRjW8d714mSHMSoASDA48ffywYMu887nnKLDXSL3THdVVJLBqbq+ORw529zW9u17Hh04ZOr
 aTsknVGWS25eq9TnBzQ==
X-Authority-Analysis: v=2.4 cv=a/ulZkSF c=1 sm=1 tr=0 ts=6aa763c7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=Byx-y9mGAAAA:8
 a=M5GUcnROAAAA:8 a=IH1zLOG4o_rlb5JGYfkA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=1CYo9-gkzx054UpEq_5a:22
X-Proofpoint-GUID: J2JHrhuFWGcFgOkvsDW4ET_SRscATRRV
X-Proofpoint-ORIG-GUID: J2JHrhuFWGcFgOkvsDW4ET_SRscATRRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01

On 2026-09-14 at 07:35:21, Heyang Tan (thy15333007817@163.com) wrote:
> The rsrc_alloc debugfs reader writes rows directly to userspace without
> respecting the caller's read count. It also uses the current row length as
> the userspace stride, which can corrupt output when rows have different
> widths.
>
> Use seq_file to handle userspace buffer sizes, offsets, and partial reads,
> and write output columns directly to the seq_file buffer.
>
> Fixes: 23205e6d06d4 ("octeontx2-af: Dump current resource provisioning status")
> Assisted-by: LLM Codex
> Signed-off-by: Heyang Tan <thy15333007817@163.com>

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
