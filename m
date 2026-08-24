Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0C3E49DA;
	Mon, 24 Aug 2026 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553188; cv=none; b=VYuNqLNd7hVEnXFEg/kygzUuqyeUoUT2InxETJwbdmPtBQwk7fnDwn0UuSfzZFuCiwLJZyRBUKE/6C2mHRnE69Lff2JBJxtYyh98MGDbwRV8STxX2FwHWPBAYQxOU34eX4bXFmiqfXwQgqNEqCHfcLVX+Y6RW1/f4jKI5rXdqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553188; c=relaxed/simple;
	bh=4NxF+lhQZdA5dOP1V64bmTM/WrZkAVCR1bc2prj8l2I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyxWXRv/cMPdB9RwlIqLD7rFrt3Bz0Vrt3PC9yfzcwhhHAHs0yXVsVynSW6H1AsMEzjwEVvbWd5DnO1lJnt+iTTBphiVmYCK8fO+IRpX/gDEHhtsn5/gqjPlPmgUaG87WzblIw6KYN6IZPpKux2dccE9Y5QV5MjK0tMWs5DPmek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=A5N+O187; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="A5N+O187"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5UhGa3045512;
	Sun, 23 Aug 2026 23:32:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=4NxF+lhQZdA5dOP1V64bmTM/W
	rZkAVCR1bc2prj8l2I=; b=A5N+O187gjmXKXPjWAmbyvhDuaRuLIJbohZk7ZVFn
	8RW0sb1Lw/imA5/JQGc3QO0cjzhUnF7hO0JUvPpuLe1nSzP2ZVj6njENo0BlevaC
	4CHhG6/YRmtrbgEumzfOFCKt61689QwKYU0ZPNeNOrrtYEuDg2aXSdWNKiUe2YjA
	ivlDKDwXk9E82xlajrE1+2ba/YolPyOr/yDsaLj8lPYrsOL6eXEM2FXqRPgWIEFN
	7u7cMXaOyWj3t2TV6rLP8CPTM/SCI6h+sBmSCg5MBhgHnStW1YBiSOy6mr7mawYg
	SKecxmkbb9gBxb4bg4in79a52Q3afb9b7Ms/cH5wRwRCA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g801720k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 23:32:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 23 Aug 2026 23:32:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 23 Aug 2026 23:32:56 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 899BB3F704B;
	Sun, 23 Aug 2026 23:32:53 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:02:52 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <hkelam@marvell.com>,
        <linux-kernel@vger.kernel.org>, <naveenm@marvell.com>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH net] octeontx2-pf: reset TL4 topology on HTB offload
 teardown
Message-ID: <aovllDUTmYmHlQBy@rkannoth-OptiPlex-7090>
References: <20260821072812.2890922-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821072812.2890922-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1NiBTYWx0ZWRfX7NP4atRE60OQ
 56c2V2zVQYW57fFpDOSurB6CTlzdSrh3FFVxGMjXnXJ1UBNqXdbUky2YMp7KNbYpGjDtA/J6M9t
 QZO2096AU4foFD4dhUxl2byXrsPhrsX3wTqiV4RvwXAkkQX949OFCU5mO3b7iFjBfaO/9WA3wqr
 hCmuRi+qi59x5RGBUF9EwmuP4qQ/MJnNvQ4SFLpwC6OgnQNXbv7U2AIYxHi3ys1OOzHFWNaDpQm
 Zd+2i7SvkT3nRZo4ELNHqsp5vh05J9iiVxwJgorw56o34Nk9K0VP7xBjXX0llSWDw7KeHOWLS/V
 GyyelrEgIEh+C5svzknLV6riPHfef8WEu3t4K8XsIIxRssLPPziY3u015L/kFFQH/1Tu34hTM3s
 qN17hqntPyYW/Bb+QcfkFIBWnDSTjHwDcwnLU4E1ovBATgkxfL6aPOSk5bGJLeooAgN4q6MnEdy
 yqVZ/Q9D3gAa9IB1VDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1NiBTYWx0ZWRfX2aTHfRa+Jlz8
 RjU+eQbhdCXOzSg0ir4MFRekWBPK16xJjLhf4WrQWTlWntFZLjPNq9OTBUDF50K3FI216cQcbMx
 GfhZi/CyKw8wHgg1V2Aien26FP2HA6E=
X-Proofpoint-ORIG-GUID: 24Rj-w1fhlYjyo6QSaOTAtOBynzRmPAY
X-Authority-Analysis: v=2.4 cv=Z+Hc2nRA c=1 sm=1 tr=0 ts=6a8be599 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=AU38-qS1yCvJ3THEYhgA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 24Rj-w1fhlYjyo6QSaOTAtOBynzRmPAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01

On 2026-08-21 at 12:58:12, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> HTB offload programs NIX_AF_TL4X_TOPOLOGY with RR priority and anchor
> settings that the AF retains after scheduler nodes are freed. When mqprio
> bandwidth offload later parents MDQs under TL4[0], stale HTB topology can
> starve transmit queues. Restore the default TL4 topology for every active
> TL4 node when TC_HTB_DESTROY tears down the HTB hierarchy.
>
> Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Will address sashiko comments in v2

pw-bot: changes-requested
