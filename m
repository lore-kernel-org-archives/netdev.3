Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C05478D;
	Tue,  8 Sep 2026 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788834737; cv=none; b=pT6k9DKguqWko1I2o718tBFsn/KRdPGJ4Z3vXkow2VsWF3uEbpCIrq4qJWHiqD775qxQnZjg4KmpjO667TASawKGFs9AWcZfwNjozObQB5LM/fxCQqKjIUthHHdiXoyzwV8o3GXRT7tU5z7fLLUdhX/oHA3ICCYz2C84njzx8N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788834737; c=relaxed/simple;
	bh=XRCT1ubz8+HlY/EvWyxICur708kK+UqXvVK32h/1UHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLdo1PfSrmsllcAcgLmStLsiYg6dyfyauep7fldg/LcfHiIUEakZfzVT9p8SlXGRNuvIvn/L794HYQX03DVqRf5IdBFuVIfvqt+FhC0spw14R2EDQQx7GRRX8pKOjVBtTsc7sdmPe5aqWgrM/WBqRHq/82JDnOzypgbWydAP7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dZzodWYs; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dZzodWYs"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Nox4e3008823;
	Mon, 7 Sep 2026 19:32:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=dp49UmxUdO9oZ1AZdQZYJcBj9
	DXWEu1C8/+Yn4pgnXw=; b=dZzodWYsDEyAcHvoc30REUUIsLR3rs1SqpUmyl4Tj
	uVhJ4KmCiASLTRd3outxQUGYN1sHsizOpXBHybK1ZkO0fYrYsiO+AvEIvR1UlcuU
	2V632+zWB2h63ON5SRg7T4bnOPD/lbSHcKfT9SA08lGgDdw4X+2t/F/lOjByOB9D
	446KP2sF8bRVo7CxTTXeg59wsPiZ5p34Z2slEjgxsAtwqeZoNmWX9dwcK4h27Zcc
	zNOeLOaZNmbseuaUFhJdH2L6IYLaf2Xj28SEAJ+pb0+KQFE8T9WeeojqTWk0bcnH
	90d3XYw3TyYG1VV9JtZEkrACZ0/VajbjBm3Z8sLQLci4g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gh3u8vdpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 19:32:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Sep 2026 19:32:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 7 Sep 2026 19:32:04 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id AB6743F70BC;
	Mon,  7 Sep 2026 19:32:01 -0700 (PDT)
Date: Tue, 8 Sep 2026 08:01:55 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
Message-ID: <ap9zm3g92LgXyAcE@rkannoth-OptiPlex-7090>
References: <20260907042827.4077114-1-rkannoth@marvell.com>
 <20260907144038.0937d6ff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907144038.0937d6ff@kernel.org>
X-Proofpoint-GUID: xkkKcFJZW6XmOHSNsdhIVgqL3yklF_gj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDAyNSBTYWx0ZWRfX56pxri7+k6fE
 aXOWXfDQHmwhzygdK9KUK6P4uKGjuXhb3ifeiQNkX/bileeLvFVaIhtUpC3Aw0f+kquvSFYkvqu
 VxS4ckaEqFRvg67lpSDob3IpSVxnJzc=
X-Authority-Analysis: v=2.4 cv=b7+CJNGx c=1 sm=1 tr=0 ts=6a9f73a6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=qnbKsyKtNxXklLsWGbYA:9 a=CjuIK1q_8ugA:10 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDAyNSBTYWx0ZWRfX1rw8CO5Bl4Nq
 u32EJCd9h4vPkiGh3790AVHeuER+aQM06/cJPkYCnLaar9a+iOF+RKjt9qJXCFmVJXjA3UI5i1g
 loDmSC3W6uPyFQsdDbwMf1jnUysK5FS1pk+r57UOieadXFhQSaXmEF7qn/eqmTcA6fm/bn0vtku
 A0lDFGZLQ7IAASB9UptcercOOS/C77stb46Kg3NsDjhP2InxXYrKiAuxw4hm56zT0PVNd2yACNZ
 N2vSEzout3otGgHHTWoU1gB79P0GyFS97VDtzt3S0dRMHcfKUDUxgTlRxtYAkUPJAzni7NXPZ/r
 5UCU9iahpor6GQLIZdw7x10CD5mM3p0C6+HHUZgc8pWG6kKoMbxtmhmJs0GQiHAva8FbY5rJlZ1
 aVHUeqXbPkBjrCtStxlLLUCdPFQ2gtgpYxAiuVeA/OTfIyjSStJD+Z8MT0yB/XLVFOO99l8PjuI
 WeTxQDkpU6a7/l7Qpbw==
X-Proofpoint-ORIG-GUID: xkkKcFJZW6XmOHSNsdhIVgqL3yklF_gj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01

On 2026-09-08 at 03:10:38, Jakub Kicinski (kuba@kernel.org) wrote:
> On Mon, 7 Sep 2026 09:58:27 +0530 Ratheesh Kannoth wrote:
> > otx2_get_link_ksettings() already fills speed, duplex, autoneg, link
> > modes and FEC from CGX firmware data, but leaves cmd->base.port unset.
> > As a result, ethtool does not show the physical connector type even
> > though the firmware provides it in fwdata.port.
> >
> > Populate cmd->base.port from rsp->fwdata.port so users can see values
> > such as PORT_TP or PORT_AUI via ethtool.
>
> I said:
>
>   drivers should not blindly pass values between uAPI and the FW.
>
> That means you have to add some explicit validation/translation
> for each value even if they are numerically identical.

A field_get() would be OK to satisfy this translation ?

cmd->base.port = FIELD_GET(GENMASK(7, 0), rsp->fwdata.port);
