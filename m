Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5483E49DA;
	Mon, 24 Aug 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553121; cv=none; b=j2z2+MWvjwksHBZAMk/oClkbxx03LfqY8Mkyd4cm88bVAxmgixphAtZZvNKveGv2E/gGiJQD68wtnjc1kiCmHEJB/ZJghboiw0YNM3bw5y8UJCF65DgFpN9BS9PrahdFAMAgT0fC5mtRXDovOo8Qby53elzqf5SYHMgs24K4K4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553121; c=relaxed/simple;
	bh=ItdZhMEQViQQ3EtxhfAB2BezkAhHpJ6lEcecyb/boHk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBGUvMUcvQKWCx03jjIHAuo+7tJpfuZJ4ju94oqcPOINpX0YABKk4EJ8d3EkJYJHfMRfqeQciVgHxuUL3b/Zdj9cffUo62em5dbzVo4Ob3iGAyI8qOBetEXMZMg5AeeLWgRGUMmTzKRtuoxWkLWCHPK8dydcdPlHnIQq2IqFFWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kcCcBQiq; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kcCcBQiq"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5UimT3045682;
	Sun, 23 Aug 2026 23:31:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ItdZhMEQViQQ3EtxhfAB2Bezk
	AhHpJ6lEcecyb/boHk=; b=kcCcBQiq+zmpbkCzgFHSvmfgDwIKhkFHbYD1vvQuO
	/Emp2gh4AUQCW4wikkyqd4A8m/Hqv0tTx1QvDEcv+AUlYrAUzxl89UIawPYFDM3M
	ed7jGnhSgVbRDgKoLSlh4CA1kcqx2qnXB9DoPzN1FbuXGGpJLm6Q2v9y4Uv2fJ+8
	XqjmJCQGcPzYqyi/w9u1lF3Ln/V6+v+4DOlwa4D0JbR4tsGuDLFX7gCGSiWT6Pdl
	Whg4jGKNLelwpDndA5UUt49JJ48NATNzYKzgSVty+CJXNzFyz5s5fp+dMkcIzGR3
	jwrcS6uOd3lRu+kbIeeQve8OHY3w+KQW3p3UMe3Jcot2A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g801720f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 23:31:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 23 Aug 2026 23:31:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 23 Aug 2026 23:31:37 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id A02F83F704A;
	Sun, 23 Aug 2026 23:31:33 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:01:32 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <sbhatta@marvell.com>,
        <sgoutham@marvell.com>, <zyta@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>, Sai Krishna <saikrishnag@marvell.com>
Subject: Re: [PATCH v2 net] octeontx2: fix PTP RX enable notification on VF
Message-ID: <aovlRCN217lBuFY4@rkannoth-OptiPlex-7090>
References: <20260820044439.2592441-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260820044439.2592441-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1NiBTYWx0ZWRfX3a1muGoLDTW3
 dPBOWojmbS2JeKJQ2ewhNVag31UXdWPti47t89AQl+ErHG09AcnwgbxxSUKq2raOrebeBkkSGqu
 0Pw4d91FYUKgeNeI/h0IF7xuH+ozZlCIpAW6hnFs2vyWp6a9vfLcxaO4KwDh8gbFXPZ53Pq+h4F
 zkMstzB5UeLxTpFhMvp6mgabMTQtIZspXfRcMm+FMTrQeO27QuCwR9t42ap5xrI4X2M4+kb2IyJ
 wNW8dBcwjKu1etQ8kGTB9qKkhGrjlv653ui6UM4SIsrzryAQAIBM1LwgNLr/G4N6D8HjtLxn8MQ
 dhgY7N1iXmDmS36Q5Ux3YkW7/7OT1SrlH6X1YyojXj2zjuVvD0qi6HqLPSA3p+mP2kV5kRpLjo5
 rIjkKdgvjdNbTSttmthDwhKIiSjhep4+tOPi7XF8zFTPQCbluDdCYkYGrqqGIFolJSPIs2URgsc
 6Pa3frGGTXGZmHyDD2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1NiBTYWx0ZWRfX0EbMKRMTK8i7
 RHs5VhfcZq4BS39iyvdwve5DCTkP6fH5xKNv4Rqxz+Wc07IkI6TKTr2YJRL0SIt+FrlBWg3AX3v
 K0RlrwO10TCnWUn+OBD+ov+XK/x8pxk=
X-Proofpoint-ORIG-GUID: uPn3isNQEKNnTguxp4QGNWD-7Skmgut4
X-Authority-Analysis: v=2.4 cv=Z+Hc2nRA c=1 sm=1 tr=0 ts=6a8be54a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=YdiEzXpmXrc7NoMvOvUA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-GUID: uPn3isNQEKNnTguxp4QGNWD-7Skmgut4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01

On 2026-08-20 at 10:14:39, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Sai Krishna <saikrishnag@marvell.com>
>
> When a VF enables PTP RX timestamping, CGX prepends an 8-byte timestamp
> header to each packet. The parent PF and its VFs must adjust their RX
> data offset before that happens, but enabling PTP RX only configured CGX
> and never notified the PF or VFs.
>
> Add a CGX_PTP_RX_INFO mailbox upcall from AF to PF when RX timestamping
> is enabled or disabled. On receipt, the PF records the state and forwards
> it to active VFs. Handle the upcall on the VF mailbox path so the
> notification completes correctly.
>
> Use the asynchronous upcall pattern (wait for zero, then send) on both
> AF-to-PF and PF-to-VF paths, and serialize PF-to-VF delivery with the
> mailbox lock, consistent with link-event notification.
>
> Fixes: 421572175ba5 ("octeontx2-af: Support to enable/disable HW timestamping")
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
>
> 2.43.0
>

Will address sashiko comments in v3

pw-bot: changes-requested
