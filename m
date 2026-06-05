Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B72FE071;
	Fri,  5 Jun 2026 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638894; cv=none; b=kZOv74mIVlnjPmCq9KCHzEGToTvFy+BmaESyAfdDYCTo4MBkkMQ6e8BZAVbVhUVDgXWZwu0rARaUvuv36eGxcHa6MsiZh3vI8hWuGAgv3ejWWWuVvc9wVYHOY93kQyMHHkG3LJ9cXi0IQz/CAkgrHq7UdYDw9K4VYtkYKE1S54o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638894; c=relaxed/simple;
	bh=aIrNNkA5hjQOvnDtmFg9Pk30u8K9cXtHCT2zSHekpYw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfH6UVT+kM7tBAm34aF/o1pdPFYj2RRCo6V7gN3Ldqxt6mjfHDDru64SyQahR2jQ3TbQ2b300/weHD7moilgIf54KjmG40hm7U4xfrg2TekF5qB/hPfiJnBiIlqwoDzBCu4TIppW8eFXJTSd8UkRwUJOQSe1/jBVdmHVKRGcAzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=a2lF+RLJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="a2lF+RLJ"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6553RN60302225;
	Thu, 4 Jun 2026 22:54:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=aIrNNkA5hjQOvnDtmFg9Pk30u
	8K9cXtHCT2zSHekpYw=; b=a2lF+RLJMtZm32V3Hj3ubnOgLrn0JFn3+uq3fWugy
	rUM6COUYr2Br/Rw55WOq//xkSwtY8BwSTyPTUVD5UrDezRTIdA1DAbuW9NCffqOq
	fuyYE6XvEQxZRt0XFNkNs+HZeFO9gxb5ouTIdmEuGgOJ9yzsnXyAKzrCCSR2uWBs
	EkHxkvx0I31T0o29a8b2kmZtDymq7Kl5dAgj4AfoKrXQMpCCMyvpCROxv2yagKnB
	0vVBJQwiBR5Mg94BelF9iS89LgaEJpzag+IvIAcoNEaCJ+9VBkZEKXFC0HqKBb1Z
	qIX86GncIeB68GDDPjFTtF6uDYWCtOdKL9w1HUQqYiogg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ekcj0ad8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 22:54:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 22:54:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Jun 2026 22:54:30 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id DA88F3F707A;
	Thu,  4 Jun 2026 22:54:25 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:24:24 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <rkannoth@marvell.com>
Subject: Re: [PATCH v19 net-next 0/9] octeontx2-af: npc: Enhancements.
Message-ID: <aiJkkJInFbSI1xh8@rkannoth-OptiPlex-7090>
References: <20260605035030.3195141-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605035030.3195141-1-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=G78s1dk5 c=1 sm=1 tr=0 ts=6a226496 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=WjyWZ82MCIjM4GrPYkoA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA1NCBTYWx0ZWRfX0FWkJHjSqyTw
 +BjhCTO3Hu3ULxTXTvpcCIf8O1HwiaVWPtKej7wYAxrSqE0G7CGKdNZwlDbq48zZKA6zD4EIn+/
 xju8TJQa91KutWgjbrVqS9w0liW+ms53YJxA+e9bm1PDLclNhvf/F9dfGknc/TcZgE3CryvQ6Ot
 elay815+9EbTTKSqy2kww1NyBna2l2r4xDi2aGYOhtF/zxLHJbIp8qHwJwbxy3JX33IW8hd69Jm
 PfHpwogaQoT3HwD3gv7dr0laOml6HNlP5X0j35QcSleNhBzWrj2p9mSxZ1EbrLekKXWc5N6YmYs
 vx+etRRAy8wYzX2QXGjLRQKjOEt9LGg63pvae8V9iGavCBgvTU0jlXY47S97mwW6Cd8cpzFfip9
 N+T+qgk785Kk9zFoXU5wmHVYsa/lOrSd4oxs5MHVrIr7A8whB0eIBCncEDSeBRfsXFEpyiVGQ3E
 S/0t7l4N4PQ3duqJGiA==
X-Proofpoint-GUID: jkWaSrVt0ca8cx1T4RCm62rWuBYAzelR
X-Proofpoint-ORIG-GUID: jkWaSrVt0ca8cx1T4RCm62rWuBYAzelR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01

On 2026-06-05 at 09:20:20, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> This series extends Marvell octeontx2-af support for CN20K NPC (MCAM
> debuggability, allocation policy, default-rule lifetime, optional KPU
> profiles from firmware files, X2/X4 MCAM keyword handling in flows and
> defaults, and dynamic CN20K NPC private state), adds a devlink mechanism
> for multi-value parameters, and moves devlink_nl_param_fill() temporaries
> to the heap so stack usage stays reasonable once union devlink_param_value
> grows (patch 3).

pw-bot: changes-requested

Please disregard the previous partial patch submission. We experienced an internal SMTP error mid-way through running the
git send-email, which caused only a few patches to go through.

I apologize for the noise and will resend the complete series shortly.
