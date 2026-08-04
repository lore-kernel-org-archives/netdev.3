Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F73B05B0;
	Tue,  4 Aug 2026 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840136; cv=none; b=CmpujHwwTwEldNzS4Yf4oG3vMOmU9oOGzAQUocCVM2vBECkYV13x98YvoBNB8O91WFzzzitEK799WdqTqXmcuFdiPUmHOqssnWDvSjU3XGbjVUiNA4NiukzfUgtyeVknb0rqvGxRFm0rV2JDfWVP5owzqNi6GFjQBkSmXygkvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840136; c=relaxed/simple;
	bh=NVzIhmsWwrGs+zQoe/95wU5WgMI9L8GECLvmTzcA4jU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2Dvc/pGDs59e2bR7qq36eO3xjLLIurI8h40OyHjWi9z7aSsIhHUwl8CqBRNh0zbLS37Y5owZQ4EfGJQQizAb0CFu45mMDs01aM4W12CGBaAPNEh9n8N0kippB8J2vr7+7siERTdEABo8J+Wwvcp82sgDkQsrI4iFGYlzZRRETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JtXI9M5W; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JtXI9M5W"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6749c2OR2676660;
	Tue, 4 Aug 2026 03:41:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=NVzIhmsWwrGs+zQoe/95wU5Wg
	MI9L8GECLvmTzcA4jU=; b=JtXI9M5WzFr5M/u/073UoTPj2Nh2E02g/pVNxlk/w
	LA9wLrCLpA6hOqTx3DbB1M2LI8j7Jho4kssSobi/QTbMJiOFT3PYqaJQcpfIX1SU
	gG9zEqyuBkY3cnefIFn4xke3bQf9kskCaIjgR0GDh4Ngmix0eco3Pypsp28Jew35
	455IMOM+Qs6t7UNMQ1tUGgjY4pYZzfjo6y9Y7EBewatdlsKAKnrTBWcesUGlJeGj
	kTSBbFFuFnkhlPIlSgxnDCFNPUX4rfgE+nYFnFvp316XaqlDcoxsg7ruUAI3jXlL
	S3JoRTLybjda+tNH57h3LmoWHbwuUN7RPoAHRoGsMfqDg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ft5266pkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 03:41:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 4 Aug 2026 03:41:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 4 Aug 2026 03:41:49 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 976D25B693A;
	Tue,  4 Aug 2026 03:41:46 -0700 (PDT)
Date: Tue, 4 Aug 2026 16:11:45 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v6 net-next 0/9] Switch support
Message-ID: <anHB6SxjtU8aLDkJ@rkannoth-OptiPlex-7090>
References: <20260729045100.2177958-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260729045100.2177958-1-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=VdbH+lp9 c=1 sm=1 tr=0 ts=6a71c1ee cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=rmKE_tzFG4I4O5f6_9QA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 8lPQLPGtOizMg-pYKPLOpUPZH46MWwhY
X-Proofpoint-GUID: 8lPQLPGtOizMg-pYKPLOpUPZH46MWwhY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NCBTYWx0ZWRfX2c6+si/2e4xp
 /YO7McdvXQsqQ1x5Eyu8LZin6icKXep8PfDX46fd2KvFE8G2G6CB7mjBl921Mvc6a8cznieyqzl
 kzWsOLF7i3hOPP+6oitS2jwfpXCFKj4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NCBTYWx0ZWRfXwqqjDlXn3bQa
 biScI9wbn0Yo43xDVEcWTi9cU0uF6HM/EltYZ1xFoy1+oIGEgw19fGgCCXYuEydlO5DLbA8o1vb
 RzAr/dTkxjayxSMM4WouBYg3vux0igJY34D04F8U6GByx2lDroGIvTS5uPwqTW413QhpAwSpimw
 dXEyvSJEwiv0HF59QDE657hlX3c5yX4xp+th5fvBXITZUr8XnFdHlxbp+j/5S4PTQzsVwOG9kDD
 XYegD994SAUVa7rIPBHkYmYgtDKwjN6a3tXn5mXY/fjZhcIZgeNSlvPrweo4tKLK9ePQvdSwgrD
 ZUjztO22cj9N95QJRnZOStUua/4UvsMLsu5xiM4RoBxMqhi6M/byj4nL8mMqPgJQZCCZYlUPZC9
 Upi4jWYkig06JZn5aUOwBPUZywCU9GTo32AZdzDylOlb2j895e6qUtGlewiJqzY5QjtBk9P7ENL
 OChnj2gu1o3FF7Hxovg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01

On 2026-07-29 at 10:20:50, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Marvell OcteonTX2 switch hardware is capable of accelerating L2, L3, and
> flow. When representors are enabled through devlink, a logical port is
> created in switch hardware for each representor device.
>

Will address sashiko comments in v7.

pw-bot: changes-requested
