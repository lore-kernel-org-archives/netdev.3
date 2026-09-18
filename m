Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C2D48C3F5;
	Fri, 18 Sep 2026 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712731; cv=none; b=I92bgtw981fJ89HqVJ6gMz7p3e8ELnKngRQmOcyzFMEEl0pzVd2NOSeDBxwIjuLwuA3AJXt9hTex8vypIAtZxxKg+lcMxLma3HwFWwyu6BelFZhkUZN5T9tMTru/xBLz3LophLkQfT0QmnZ6DJsRNdAYkwaID6BsobSE2BN3UEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712731; c=relaxed/simple;
	bh=jImsgr15XMp4QK3U0ppSsjvKouHpc2EyU9H1C0JcARQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNwArbYADxrmoe7lXgExXgsvP5D8qfyYRoAwRujhXqeFJcARIYYYWBfYEvF921Zb6vuVihS0c/NxtDNVbkvUVT1HhMix6kvQeXSOpSgeievqGGerQRrTqCeyGUpY+kgsWgOOSJ9UF08vQWIVqj5nnIkZNJHi+rI6aL6/pdeVWu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kyLXTwPh; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kyLXTwPh"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I60LS82609464;
	Thu, 17 Sep 2026 23:25:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=jImsgr15XMp4QK3U0ppSsjvKo
	uHpc2EyU9H1C0JcARQ=; b=kyLXTwPhldVAVvHJwfn69O1+niLQ+u/3/uqu+nmLP
	8UgeWUZdKswsYdLN9J3Dq0sEXAXE0B1vhhzC1HOiSKupNF75eWHAzPtg+Y7zo9B1
	ZDCPVzLCfcrkyvXl6UtdP8+tLmdd0Zhpa9SO3KnTHcubUD46Y/M6UMLqOQjRE6IL
	sA61puLPFzkyaiAVpCgMjC71P1uDkR9H2frABkZF4vewFNcV3ECOOMxGSK2UHSnu
	chVU4tvnvj/7FhKY98GRZ/bkR1dt06ku0BjQZr4cH5ccjUU5wgvxTB8271rV7EO6
	lATSryrqLV21vnlig2UDkQNm7OHEIWJoxmQ9dt5o4Sehg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4grkjw4dvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 23:25:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 23:25:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 23:25:17 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 553AB3F70BC;
	Thu, 17 Sep 2026 23:25:14 -0700 (PDT)
Date: Fri, 18 Sep 2026 11:55:08 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Aryan Sinha <sinha.aryan03@gmail.com>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] octeontx2-af: remove duplicate SCTP port flags
Message-ID: <aqzZRG5WcSZYGu6M@rkannoth-OptiPlex-7090>
References: <20260918060323.53860-1-sinha.aryan03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260918060323.53860-1-sinha.aryan03@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA4NSBTYWx0ZWRfX17ASLssgw8G5
 Gdk5IqQEIKXH7B5Bf9LPX7R8NicohkRFTNShcvN4Vv6eRdZYzK8P7Bj2cfBp9RHiY20+Kp3k5/i
 IVjxPDtyJUvfApr0FKFWnJZv6E7gaJsncADw8vuPv5A6u1ewWWz7tX6yfrjvD8wBFZCU8XogOFa
 UKj/y8UTNrM21YCaVQ/q9WtoXJ/tn/hMJIyevZ64mWNijDnZxPpZ+qRf8sgt9dZt4fP+QInoFlc
 YytOiR+PZMBu7QdM5A1yb35QuV7saYsZ7GNBNN0q+Qq1QhXuetQS/OfXAFH9e6E+Xfa4L2TSaEN
 I3EIg2yp/+vvw296hCID/1poB4WdIILmNYjS0O07LvVV2OkYflNnBKjytnMUwiS79r9BczrHEMn
 YoHXZ1vMe2/4+sWDQHfLJWvYvlrda9l3aRx0ZG1Wc6qOd7dclGVqtu7VDFDMhACnDLMs6U1Dovc
 OXi3KqNiCOX0dSAqlZg==
X-Proofpoint-ORIG-GUID: hhvLpnNQsVR5MJDzOV0Rob6yucQjkt6U
X-Proofpoint-GUID: hhvLpnNQsVR5MJDzOV0Rob6yucQjkt6U
X-Authority-Analysis: v=2.4 cv=Zqx4uN7G c=1 sm=1 tr=0 ts=6aacd94f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=pGLkceISAAAA:8
 a=hCOowHWDANwyy3v7PEAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA4NSBTYWx0ZWRfX79MqUh/uDbXn
 AFyYpaSHx85uJbFHMAcDnLKGRC6/lx+zjRRij0+2mrlv043cgSpIRszCiuhkgLIJUkR/g95U+C2
 MF22e83DPLPzl2sDdCAkb2A6ufXEeuQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01

On 2026-09-18 at 11:33:19, Aryan Sinha (sinha.aryan03@gmail.com) wrote:
> proto_flags ORs BIT_ULL(NPC_SPORT_SCTP) and BIT_ULL(NPC_DPORT_SCTP)
> are present twice. Both fields are already covered by the first pair, so the second
> one has no effect.
>
> Drop it. No functional change.
>
> Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
Isn't this a fix? Please include the appropriate Fixes tag:
