Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C91C48B38A;
	Mon,  7 Sep 2026 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783313; cv=none; b=hsvHnnStZwncZYaBT2F1HP3VBTGwHkoxkMM7MiUdrcyV9xMpL+0ttngV9jssngQSvLqpb4aj3UC02uIJ1YejsulKeRxd4PaTfuE3pbNIT8tXtTjkbxrxZIVJqu6zwJg8vvzr8uuxG6HW0+J3iBU9G0FwuDHYFikoy9Fb8wM0uYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783313; c=relaxed/simple;
	bh=5PyYdMswPoWuC/vz/WpSF8rYKbgXA8kSCw+SpxwQX2E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITKVctEjrRvZbeFfPUIjhGng4rBpnl423kHL6FNGbKistHYyj5YbzlZW7QtLJrsealKYw6z17fbs1IyQFVQtRgVihNkgGxSS/Tv4vZNop1qhZG5FY4c7f+hco1UuhiU8Nej72LabtAvXm4btteGkevI262J6j8q1ViS2+4T0TF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BaDH57ab; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BaDH57ab"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687ArdET2711095;
	Mon, 7 Sep 2026 05:15:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=7qVAtyZ/oURqi1HhgNSfPYKR5
	MPqNxaytKxW6SYp8KE=; b=BaDH57abVroa+NTp3VmjafmyYHWs8MxxU18//ejG4
	x699Sdo6Z1/JTD0Y5qSinNn2mKfHz4aIepxIbciqaHIOcmmW0ASsrbFJSECQUN3R
	uzJKP4WVRWbIOwO0RediAe53DJKq0SRxcS/conW8lYgpPqTSKf/pT+TUGzCC8+6W
	zPMdQsRUguCX91Xt/+O34Hs24eeyMXANHzDHlLyi4L7VuYDwqtGExOxshK/7xqn/
	YjmroietPU1eCRLYMBbNy2pqGzvm7t/4VnCyx450DwsYMwnM0HRomLp//sicLyLK
	iylxZGpQquq6OsVUKb1xV4CFo6I62yj2s6g+wzlY47IKw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ghuwjg686-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 05:15:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Sep 2026 05:14:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 7 Sep 2026 05:14:57 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id CAF313F709F;
	Mon,  7 Sep 2026 05:14:54 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:44:48 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v7 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <ap6quHlmYxI0cJAl@rkannoth-OptiPlex-7090>
References: <20260907042617.4076723-1-rkannoth@marvell.com>
 <20260907072055.GF13683@unreal>
 <ap6VHVYnXcUcMTNG@rkannoth-OptiPlex-7090>
 <20260907113244.GJ13683@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907113244.GJ13683@unreal>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzNSBTYWx0ZWRfX/d232z6LeXRO
 J2bzI9nc8W8bZfKdSKLLxu3R7slaCT604szPlx+uG4fpLYY2Y5LYLkfBtP0+Pav7gY0M+JiFdOL
 vMTYz1gRQZbEjR11Lt6lcP5cj/a7eP/yWraOONqQA6tlpb07Y2gfH4whMxD8wTGumL4tO0+G4AH
 bME46pHuE9e9N0AJ+g8+vAqcA04odjmmywAhpvtwstyglO6BbsPofvx+PHSszKYiJZZgOteghhC
 zZLihs72qXFNzyzcztbc6m1x0vhiikGkjBAxMHb+zO4Vkml03uxGZioiP1AUZOckdVsFlp79EAp
 NZI2Ml3YYBdPcXndM1v3mZ0rTJc5ev093iSSDk2WeMg7sDIwq38DKadGlNmEr0uopnjPfIEIRxw
 4okGW+xdjRlt9fNT2DWVTDLy4A9iM1GGrqbKHle8Hd8UtNU1TLT08V4NQBNyAYYq3TAsIDkxtZ1
 wwi/vAOV8/bgA0e89vA==
X-Proofpoint-GUID: OxZlxKwyvaGdrDAYSzHO-MQ0nODM1V77
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzNSBTYWx0ZWRfXxmb32u8JRmpw
 pyNE3yAMCMvjP3eX9pNuN+BoUpM7rSTWCpmL7MIuyvVtTAaoD6JouGOQAC1nVHhUiDSXGwPw2e3
 k0ubrToQeB0ZorKKZ1fiNCQF2Nw8igg=
X-Proofpoint-ORIG-GUID: OxZlxKwyvaGdrDAYSzHO-MQ0nODM1V77
X-Authority-Analysis: v=2.4 cv=GewnWwXL c=1 sm=1 tr=0 ts=6a9eaac5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=Okv2uDtsJ0kjqiF-2gsA:9 a=CjuIK1q_8ugA:10 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01

On 2026-09-07 at 17:02:44, Leon Romanovsky (leon@kernel.org) wrote:
> > > > +	 */
> > > > +	if (order > MAX_PAGE_ORDER) {
> > >
> > > Size is coming from the kernel, how can it be with order more than MAX_PAGE_ORDER?
> > There is contigious memory allocation request from driver for PF-to-VF mail box memory.
> > It is crossing max page order in newer platforms as number of VFs per PF increased.
>
> I'm not sure what this means. You can't create a VF without assigning it
> enough memory for DMA. You shouldn't get an "order > MAX_PAGE_ORDER"
> error at this stage. If you do, there is likely another bug involved.

I will move the MAX_PAGE_ORDER / size validation out of the DMA helper and handle any
allocation failure with a clear error at the call site, where we know the required size and VF count.

One question on dev_is_dma_coherent(): this qmem path relies on the platform being DMA-coherent
(as noted in the commit message). Would you prefer that we keep this check in this function as explicit
guard so that a future port to a non-I/O-coherent SoC fails early rather than silently misbehaving?
