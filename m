Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0212E282B;
	Thu, 20 Aug 2026 03:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787197107; cv=none; b=aHyrqSjBy95WDwuJn9jMl7DJidaR4Na0sbbEslruEBDtZwrHSGLudcqwzwGNrUTKZCdn05sbJGmW+/RgbsCIukWlAuDjYe9PkN/asXc4/kCNNqUOVQYUyeDbQljPuqxHQPh7OO950hnzycp0Ksv/OuHS/Ynb0yeOaqOo46yzJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787197107; c=relaxed/simple;
	bh=QNr2dL0L0FcuEHkO16XqkuFxX2OKCLY1w7SHSmFJcmw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbWCSgcb2MOdLyoF9xPX1d9n+LUJdQ8a41HwXo+ysv03wv9fq3VN7MPnWxJczjTUuTz15IOBp7bU2DmZNhlJ1gpDEoflu0BPeGfCqiZaQ7A829DtFmkJhkx2gY2BmGSiGPPEX9w0MgmgxNCKwbFzHIyYtdFo/58gGg1+AgyVUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dVSUyKbf; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dVSUyKbf"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JM8K6p429483;
	Wed, 19 Aug 2026 20:38:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=QNr2dL0L0FcuEHkO16XqkuFxX
	2OKCLY1w7SHSmFJcmw=; b=dVSUyKbfvUS/resJu5ohXwrWUVdF0AeJdqM0ccXPT
	rd7JwDqiFhRvvBbkqVbcOQTW9jVqQmgL49vKhLC5gu62YcJmqp9r6pIf/D/oPVrN
	iKIjWxOthIymAf7ScpwVPzb2rEgxSuUq493mSkNDTQC020Rap0iIKbqfRTScvw6q
	D56FM8KTcJSZVrbY/owTJQAT/ho7d6UET/nHgFP4kgLeFHwggTbKleIK+hDth1P2
	iIFQHg+Ie2pLRZ44B0iY8DS+h86cShXuvGB7ImzQWHj7JWDfIuQIA2jVEtEXaYRK
	/8utftACYSS7yvz3WSqViMzTCGQHL2iQvfcQwTJJt72LQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g4yeue3xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 20:38:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 19 Aug 2026 20:38:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 19 Aug 2026 20:38:16 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id B5C0F3F707E;
	Wed, 19 Aug 2026 20:38:12 -0700 (PDT)
Date: Thu, 20 Aug 2026 09:08:11 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <cjacob@marvell.com>, <davem@davemloft.net>, <hkelam@marvell.com>,
        <jbrandeb@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: poll for TX link credits before link
 mode change
Message-ID: <aoZ2o2JeHruIRqCH@rkannoth-OptiPlex-7090>
References: <20260818033652.2038116-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260818033652.2038116-1-rkannoth@marvell.com>
X-Proofpoint-GUID: KGF0ETKmXDVLoAyOAbz1a-rPbC6MYHIQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAyMyBTYWx0ZWRfX/jCd2ESwAvWK
 ulaFD3EpKejTdrQpwPZRfphXRh0bru2C0mHuiuSB8llpUZ39QD5VahDlLVoGCHvfrXZqoEYPl6+
 B7QFRmitlmn0hjDTszWUlgTdqMEYgE3e8AbAVRg+rqF0ESnRLUJtyf1hCu+kkODKX0t9+ULaeOi
 Emq03OB1CMUUCm9kzIsGQzSwRy+b3OYzqQypjxBcwfM+pxzAmqVepnXDAhWqcGNDDk3HZM9EZ34
 rAPGFClkYQ9m6blO9KkZLLRFGTE9tpbmJtnJ2Fbjze8lY37qxGbh2badNEJXdmzGkpavDi8yXI3
 YsfOl7e06mBsPxv7N+/SKS9oa/Gh+ASDOPN0kLz8xLsAAmV+QHwnliFPwlEyjUXsNkCt0VypdE5
 c5X2S85BCZ2YVkKs0ipOHLtoRM5hWSJl+wNJeuPGwtBnz82ycsVCb8BU6dY9R4Y2RNa89q2uMCH
 TjvtI5l0f3O1D7/0OUQ==
X-Authority-Analysis: v=2.4 cv=ed8NubEH c=1 sm=1 tr=0 ts=6a8676a9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=vrmAYhDT-tgqGnncLU0A:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAyMyBTYWx0ZWRfXzjKzdToC1AcM
 YUtg2po72BYuSWPJQCQNDnYNzwZzbk0tJ8WkwkzQ/Hk1Qs608GT/l3vbClyD2Krv0X264UnJyXd
 9l03dwPXTlKl4j96dF+3G3wnQzUscIY=
X-Proofpoint-ORIG-GUID: KGF0ETKmXDVLoAyOAbz1a-rPbC6MYHIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01

On 2026-08-18 at 09:06:52, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Naveen Mamindlapalli <naveenm@marvell.com>
>
> When a CGX/RPM link mode change is performed while traffic is flowing,
> the link is temporarily disabled. NIX TX link credits can drop below
> zero during this window and are not restored when the link comes back,
> leading to a TX hang.
>
> Set TL1 SW_XOFF before initiating a link mode change and poll until TX
> link credits return to their original value. Clear TL1 SW_XOFF when the
> link comes back up.
>
> Fixes: 56b6d5398613 ("octeontx2-af: Physical link configuration support")
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Will sashiko address comments in v2

pw-bot: changes-requested
