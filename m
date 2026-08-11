Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485523393E;
	Tue, 11 Aug 2026 03:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786419500; cv=none; b=Cw4xVUslwTSS6oSuBWxcRPaAUb8mLNKUlbQG4QI8IIB8EaUS2TxxaRo4/MqZvR5HSYt1GFjjNJUCtSgsf9+bBHgAY8rsuRbtcL+89qtKB/4nih2RMlLZImlsaGcvVz/wQbM4BccoTZDtJtLSqqFRcgMOP0hOtNdPQEQBHy3ZACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786419500; c=relaxed/simple;
	bh=BIXiFQq7DyyJbwbXJSIVtsJs3hkn501rJfyKdFTQFMQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPUwzNl6MA00iTF1aatpVm9XgXk2gYEF7nT0//GIHV5cN9pJO+gjVGbbpeCCnGih6KETdMjGoz7joDtUbD2BJyn3Er4ZFpfpK0PHbRROoWmc5yWzKR+wj46UETejJSmoAYcGa1UUdHx28YZ1kMWjspkEUXEf/lylDqKbZadNeCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cpVlYrJ8; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cpVlYrJ8"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ANS5J42811551;
	Mon, 10 Aug 2026 20:38:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=BIXiFQq7DyyJbwbXJSIVtsJs3
	hkn501rJfyKdFTQFMQ=; b=cpVlYrJ8IJOONiaZNgHnYBkkwVOghcAULYGB7Sxn0
	75/Ep+WOVcICFL9qfNtFB/vtVIRaY7CdLbx75InhIuzRTLxMnHhRVzs8lg4PTcUt
	IltEONtaHB/RO7X9v52+CpXduCDjPSEmJrDsRHl4j0mMQrPIuHZ6BeLlYIIBewdK
	AWmeLGqXeeB0wk7TvZoXcHkMSuEak+eMxSrQdHi0lCXoRRPTjvzixhBRDLKoXJd2
	pC8D99w8hTPZluJ9Q/eDCis56RoSIp8uR9Q5PHONM01sTSHnO/iHlmi1k/me8FMT
	JS5bViiyRMCDRXHEMfX3VxF+D4EzlCdMmcsBHOB/yhePQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fyrbg0jdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 20:38:11 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 10 Aug 2026 20:38:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 10 Aug 2026 20:38:10 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 74C1A3F7066;
	Mon, 10 Aug 2026 20:38:07 -0700 (PDT)
Date: Tue, 11 Aug 2026 09:08:06 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v7 net-next 0/9] Switch support
Message-ID: <anqZHrFb-S2LMVkG@rkannoth-OptiPlex-7090>
References: <20260804104706.120996-1-rkannoth@marvell.com>
 <20260810181658.3135ab41@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260810181658.3135ab41@kernel.org>
X-Authority-Analysis: v=2.4 cv=FuY1OWrq c=1 sm=1 tr=0 ts=6a7a9923 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=tcAcekI4X1uNMd8AgF8A:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: EXpyh83N94J3kFh9skdW6bTQaZ56-RKf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAyNyBTYWx0ZWRfX6/DYO+lbySDV
 +ScE8wRiyedE1wJGgxaNs4DyRgWzG1vWTrSURLEhs0LV6P0vitie/Z0IxJXpuPTJTSa9XuCUnUM
 aKLDv/xUeS5kaxFLAa8clCjfiUMGmDA=
X-Proofpoint-GUID: EXpyh83N94J3kFh9skdW6bTQaZ56-RKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAyNyBTYWx0ZWRfX9NZ1mGDFAcPi
 PK6uI5/MIqmooH/jiEq6Uo9P6RoamcxTLpefl21rLKCD0dtuM63i2jNy8TPFYD3n8LE4e1hauP+
 62XSl7JlKXN96T4iyRQij7Poo7zrg5aOPdvLQ1DSoWe7lEXOrB/JLUcG7qvAtCHEqA9Nf+iRQPQ
 bpTeMQ6PbtNDdnFlr3OgkzQ/+6iixQ4nPwEPtKkrk5oHQBRPCe48MfaZGsl7SjPHxVv4t1oOdIc
 rPW2aebUvdgoXOaglQhj9dQtmH6bH91+IEeCJ6z71YwJYgXz3bvJa3d1rwIeEOi335NubDpUDMN
 plcD7U0aOIV8a/1ErCXZNMrhyFzFTBSXX18lGnvZaJ4ikn1vxWfnd/44PVmpBADqmyYKeKPcKh5
 sD63+1d+PjSyqvqQQ3ADq0BvG6j5qXPAZvIWeWHAjetaOe7T9OhS/jn8Ea8BUySXvMVXC1Gh8CK
 7nlXmZxP26XlRAa9rHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01

On 2026-08-11 at 06:46:58, Jakub Kicinski (kuba@kernel.org) wrote:
> On Tue, 4 Aug 2026 16:16:57 +0530 Ratheesh Kannoth wrote:
> > Marvell OcteonTX2 switch hardware is capable of accelerating L2, L3, and
> > flow. When representors are enabled through devlink, a logical port is
> > created in switch hardware for each representor device.
>
> Should we read your silence as "all remaining netdev-ai reports are
> false positives"?

No. will address them in v8.

pw-bot: changes-requested
