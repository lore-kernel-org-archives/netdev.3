Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE266FC5
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791777668; cv=none; b=hFKMMbgV/t9mBv/CVEj7pR63+8e6GRHQWRHtao5UwmMTJfTMTFEn0fyg6C14SCsiAA00qUlppGrMv37UPqS1TAH4HM0uXH1hdKQmM3DaNt+CzdjnLuMQ78VlLYME9P1WU0IcbfXmru7dliIRU9Xpki7NIhOu6Fda5kB1HzNKUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791777668; c=relaxed/simple;
	bh=N+FIg/Gv+LGk5AAru1EHn5w96fNABpSRmXmupfszQY0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB1kRsyCTpOzKyiTUDTfrv3IvH2u9Ty0iV+LQdUfJU0YjSFkM/Ni9WCF3XnhpGiYiAapAJznuICzrxDgyMIB6iTPKeYpYnYU5G1G7JPkkNJJ/dpIs0ceVB0AF/K0UEcFXKJU5wqzKF84pdBXegvry7Db3OwG5Rsd5+lg2/SXGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AeNJgJiZ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AeNJgJiZ"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C1mZ5W889913;
	Sun, 11 Oct 2026 21:00:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=N+FIg/Gv+LGk5AAru1EHn5w96
	fNABpSRmXmupfszQY0=; b=AeNJgJiZH41Rz3J6zinIOVZdxZOAsJ3vLdbX8yQwT
	d0/oRwFXsG9qc+i/dIoDxYriOdQJD3GVsv5zd8LIQs2Hw1g0WljXnNfGlVQ+Bkz8
	wRqJiqqL0VYvhOd4Cb6JL/xI/RiVJT4VPD/FRhWm0600a8EuN0tEGttifzCv6gSs
	1yrJpWGkr6IwrFcV5ws/PGBYTR6gA/slg5qGnHg7T0c/zLyV4XJdsZJTV7EvyM3W
	rVfkESfE4X2l85WOhm2J1SR3w1RiV6Vtt/7UHn/3/4RZoYfxsHmCjvTGN9FZUAeF
	ZO8REE1jnfqqldpGPXjUCOkhLG27vDB+OW7o8BVyZhoNw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h7mvecqdb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Oct 2026 21:00:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 11 Oct 2026 21:00:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 11 Oct 2026 21:00:56 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 3E2B93F7061;
	Sun, 11 Oct 2026 21:00:53 -0700 (PDT)
Date: Mon, 12 Oct 2026 09:30:47 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <sbhatta@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <skardach@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <alok.a.tiwarilinux@gmail.com>
Subject: Re: [PATCH net] octeontx2-af: Fix CQ enable state tracking after AQ
 writes
Message-ID: <asxbb4sxJ1f1tekt@rkannoth-OptiPlex-7090>
References: <20261011125508.534618-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261011125508.534618-1-alok.a.tiwari@oracle.com>
X-Proofpoint-GUID: bbC3RkLE1_s8x2xYl7NsHK5kYyKwxGW6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNSBTYWx0ZWRfX++MYxmauvdwS
 sgGPIRKcl/tE3x08xiiWJAyFrSYWMOON1xTlP5UbSwQq8HikOtxVnaIl7UH9RXzFEs5PyZyjL/O
 +a/bWfM38XjwxNXnglT+3E7I0sJSEln7v3mKfB1+CxH160oQF0xisBHITtjhWe/INOaywxEoiI3
 FRhKZD5xdMZoVR7EV1/taqZx77RtpShiULzbnk/9ZSaWSOaPslvZ7/B8KZWedYuwahw/yD1x7Ou
 /EhE0pLk02oY9eJDewwp+ZjvpPML8UXZJq4/Un6kTZpnt3vZh3rHRVt6N/kgxMo8JJPhF8Gphq+
 q8r3wLOMyqtNQxR67xPvINYUWGO8b9Dnqwdihhx60zSrui0OY67f9NcSYzgITeoFFlAIiL19+bo
 lcytzTUK0QYuR1Gan+Ptrg6Y8eVex4r0VRpYFyAYxxtk0LQTfbnhgTa6n1A6SdRoQDLs2H3X+Dn
 HOg3NRDoJbkC8IfmTvw==
X-Authority-Analysis: v=2.4 cv=O66sLx9W c=1 sm=1 tr=0 ts=6acc5b79 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=yPCof4ZbAAAA:8
 a=M5GUcnROAAAA:8 a=N-oI3wHz8EH1jbYSNtEA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: bbC3RkLE1_s8x2xYl7NsHK5kYyKwxGW6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNSBTYWx0ZWRfXw4kHD5PJ8xe/
 sDwQrfBYBp9wZ6mGBCVzewh4EQjNUX+F8nJG5u1QofZMYReFhlfFKkemuJcT5IzOGfMX5hL8QNz
 rCorlIY45EboaufDENxzH2i+tueeGN4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01

On 2026-10-11 at 18:24:59, Alok Tiwari (alok.a.tiwari@oracle.com) wrote:
> Use the CQ context's ena field when updating the CQ enable bitmap.
> The current code reads rq.ena, which overlaps bit 0 of the CQ base address
> and can leave the bitmap out of sync with the hardware context. This can
> cause enabled CQs to be skipped during teardown.
>
> Use sq.ena for the SQ bitmap update as well, so each queue type reads
> its own context.
>
> Fixes: 557dd485eaeb ("octeontx2-af: Support for disabling NIX RQ/SQ/CQ contexts")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks.

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
