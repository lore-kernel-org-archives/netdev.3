Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B54418F5;
	Wed, 19 Aug 2026 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131843; cv=none; b=XlPwA0jzVcmuzX+7XSrk9QCmwW75SHB6KacFuBD7Nawo+QmZIB+iFHTyD8S94M5y8bMqZTDMcRnV7aAEDJVI8zKC7bp8XT6RKxPb4lGje8aKdTa8Lv/8WpZIPyMVPulzob5kutpmo0YiZ1yVc9JqJ8F5I8mqByVDdrjh8KdEw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131843; c=relaxed/simple;
	bh=z98k2eawydxgks6C9aMXblOgbVN1/stHAVBtJ8M2C80=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASa1HgfBi25oAmdsqRCvO9hAFt9GAgWrBH5llw7F4fK/ThwVG6S+NcPb1rI9reB8IHnXNIAh3Oyk47zBrKbQEQPvvebGx61xP4qysRaJdlHuP4oULO/p00UsdyV7X7aBVGUKTzLBFJc8+ZjzximB1YNimyphCsX9lckTS66Cbms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lAi0kZp6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lAi0kZp6"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6X3H42961236;
	Wed, 19 Aug 2026 02:30:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=z98k2eawydxgks6C9aMXblOgb
	VN1/stHAVBtJ8M2C80=; b=lAi0kZp64tCtXp/dnXFl9Cxci2hVmF7D9zbxs12J5
	THGI1VeYlashXGqSFDZruG+RsqrwkcX/wTSM79DBplSbOqXXv8f6V3lLFXZBYsji
	GNo8jkVN2KNDZJbuqbR4IUTpCOEIBt08HzBZrjdFxOVoLgwMNZ2/taJX8+G5DHGt
	zXkNycOot8f5QFPMruvXsWPCyXScpCAz8tahOs+52VWVx0KlqBVpv0EkmBvUARTI
	WmWE0fTrTlg5J7jGRu4/yrKpse0QDzbRD9wlygwPyGeUMh6KuPd1nO5ndQuIEaSt
	nDuJBDfnxhpAh81QkQFmfP0qHCEq4t767Ndi2N49fSolA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g4yeua0ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 02:30:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 19 Aug 2026 02:30:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 19 Aug 2026 02:30:11 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 764493F7097;
	Wed, 19 Aug 2026 02:30:07 -0700 (PDT)
Date: Wed, 19 Aug 2026 15:00:06 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
CC: "cjacob@marvell.com" <cjacob@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "hkelam@marvell.com" <hkelam@marvell.com>,
        "jbrandeb@kernel.org" <jbrandeb@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "sgoutham@marvell.com" <sgoutham@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: poll for TX link credits before link
 mode change
Message-ID: <aoV3nsNGhII1ukPt@rkannoth-OptiPlex-7090>
References: <20260818033652.2038116-1-rkannoth@marvell.com>
 <PH0PR11MB5902CB2559DB564EA0F2488EF0A62@PH0PR11MB5902.namprd11.prod.outlook.com>
 <aoUzX2qMMDmp2_fB@rkannoth-OptiPlex-7090>
 <PH0PR11MB5902FD7CDC98BEB8D8BFE356F0A52@PH0PR11MB5902.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5902FD7CDC98BEB8D8BFE356F0A52@PH0PR11MB5902.namprd11.prod.outlook.com>
X-Proofpoint-GUID: -6xgw8VQX6yr-xHlaKTHLWoKvTJLDEBe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3MSBTYWx0ZWRfX8VcSZuJbCYVB
 vxXsV4nNcAsvEEfcf/kpcgdwhRv0PtaVzaPgRIpdOY0hBJdJIM5RzuBu6mv+jvkp5XxR4i2Ro1H
 8HC/tOrG2Mpav1z0jrbJ+XOP7EEb9nVdn2Pu5zjQt+VqC7CJp7fJYZnxIovu2W3tBl9HMs9fndo
 JHuwyv+++xzNL0ZWckXZQZZkQYb34L0hnDH+Wa3sLR97jt3C4Ak0yIL55EoeVKlStr/ByiAwBJB
 GfDZWeLCUMVSzxybwyJ9lK7o+MhpNLdIodteKq2xLfhExxf2vAOI4FnppAZBrCovo9pTGKlWkf3
 QS2iRDPOaNPC0fFBNwKb7X05AZx2yc/q0XTU3nZqMZFGaVFV8VV7OlLJwGcKDBzA3q6UH77VKVc
 3HkOWYRABpU1sw87uVmzpyAqg9Lq0SEG0fdx0VmwiSVL7fveToVD+n7sJVAPGvuyXeQKvjji+v/
 IqTLfOArZsLzpyxx2LQ==
X-Authority-Analysis: v=2.4 cv=ed8NubEH c=1 sm=1 tr=0 ts=6a8577a4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=QyXUC8HyAAAA:8
 a=KcJbdcoG6f6bOcUs3PYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3MSBTYWx0ZWRfXwwseVmfq5hAU
 P0Y+Rph4d0a2Gc8gBPbGq1seqCFIK/4c8l0PzQiB+v1KMJUtwt0JDsBIuW6p5d3t/tt84Y7Lm8+
 2qRCE+0zNu6vbKwSv4KSk3hnsgmOI68=
X-Proofpoint-ORIG-GUID: -6xgw8VQX6yr-xHlaKTHLWoKvTJLDEBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01

On 2026-08-19 at 14:47:52, Jagielski, Jedrzej (jedrzej.jagielski@intel.com) wrote:
>
> if something is a clear for loop why make it complicated?
> again, not insisting - just asking

I really appreciate you taking the time to review this and share your
perspective. We generally aim to keep established code as is unless
there's a functional bug or clear readability issue, so we'll leave this
part as is for now.
