Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637545198B;
	Thu,  3 Sep 2026 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438090; cv=none; b=hYh3F+THKEf/fXVTX5pshWKRhKTDlNhi0T68aTkq3bXrXkddxX2w5e4C0LvI5GBfoXCLMCMs+QOfWePlSY2mNfv9Vnuy80CXOEW6YVedkyENiKVWl46/R7XnrtVJhcC+aoqq5J3JMnIVW0x5MQjS2EEtK3AfJFdG+Gj543fCZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438090; c=relaxed/simple;
	bh=OCqNugGO1ngQNAsLVCH4ieKNzN84bJCShHK79VqAykk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpBf9zkslVL2Du4WJFt9yx7zSjVZ+Za0n4p0GtV1BlA0mijQb98wVEDbT8xuSsV5vtKMXv5sUsNVRZJPU8FIlcIULZKzMmZ0l+/725hAB7mRYIZ/HKKpUHx3UD1UjbickGYAM1WEe84JohANLVwzUfu/hnTFgxWCD69o7giJeJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VhsFPQfv; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VhsFPQfv"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AIB31699642;
	Thu, 3 Sep 2026 05:21:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=yCfRoi9J3kGS69VdepNLCfrUS
	czHHMuSUXU7Yd8h6Ro=; b=VhsFPQfvqNLXL5yDoq3tTdJOh2j8l+c/XxecEQNM1
	uPgtkS7bL7QDPz21d5bSG4r4M0yhpwz55WrDkHnY2lxXviUmgfbiisW9XcYJByzg
	tVgnxoNqY4X822PG4kRdpjrKv9K//A4Xperx+aVZXUaLRuaZ1l9Ot2Kpiog4yzPH
	why3y/R4ijGo/MVFS+PmM8dlVEQbOwwK34UyCQgilzjWS229+FrM9AeAbs7RSsE+
	fNQQdoVhrk9x/t4fm4wSEwFY0/Vp+BDNoipOVM6RT30ljMQPv1dq/aj6TzAuZ2OG
	zSo42qwAjYMBBk0Dk3lxwXDPtp7qNZpZw3DeY7QXMEv5w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gew3k20h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 05:21:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Sep 2026 05:20:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 3 Sep 2026 05:20:44 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7F61F3F7085;
	Thu,  3 Sep 2026 05:20:41 -0700 (PDT)
Date: Thu, 3 Sep 2026 17:50:35 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Ajith P V <ajithpv.linux@gmail.com>
CC: <tung.quang.nguyen@est.tech>, <jmaloy@redhat.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <netdev@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4] tipc: replace deprecated strcpy with strscpy
 in tipc_bearer_get_name()
Message-ID: <aplmE1r2RdHA5JVl@rkannoth-OptiPlex-7090>
References: <20260902053043.1483895-1-ajithpv.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902053043.1483895-1-ajithpv.linux@gmail.com>
X-Proofpoint-ORIG-GUID: YjQ0vSit8coQrQN1DjH98LJo7JX6_PwG
X-Authority-Analysis: v=2.4 cv=OYSoyBTY c=1 sm=1 tr=0 ts=6a99662d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=_fa5mjF3G045dlqOmBAA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwNyBTYWx0ZWRfX+UX9zfLGjbxi
 Mb8TKhSQR27Sn/ytvykrIJZQAige0q8xj9WhfiPLqn3i2dVLTs9132DVC9KHgx/CdJsq4IWB8d8
 Xpi3RH6g/CWig099a0G0LaoJ7Q88JOECbGff6nH56AkSkuP9slE9KqLWs/EUkg8md322bjtSzpn
 KcGvuT9+TsMgLBebG6o1HsM5bLI0I3GgWf4ouIW8e9d+65Rdd4eFhqdhCQQPnADKRiBo1nVPrpE
 4OYTIkBjPRhrYfPGoHJeKQ0hi4ynchNE4te/L9DbVL9no2kppk78gjraPer0sbuqvQiscu6bkYT
 N1RJRbWLlZL2N8H/QznlctS+DHWT+e+IT0e4bTbN+Yi7E3o5VP3e6KkDztjHcWKTuolV7o7ChQe
 PY/gvDAYivjV1q4c357GIer3TurWTilW0c/U8fuMabiqMVyCmvnEnMJavVzP+Wwp5L3nd2A0Baq
 ceb9FLksSAt0pY/5qdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwNyBTYWx0ZWRfXzG0BbO+2KUER
 bO4V2+AsmQyDFPuVycIMCB91oO76mbpOpsP5O6sJCS2DcbgM/S2jniqehWIU+xH2KpWoYhrDwMw
 ckGP0Em3FEltDkJBMhHCiME2BqbPy1s=
X-Proofpoint-GUID: YjQ0vSit8coQrQN1DjH98LJo7JX6_PwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01

On 2026-09-02 at 11:00:43, Ajith P V (ajithpv.linux@gmail.com) wrote:
> @@ -209,7 +211,9 @@ int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
>  	if (!b)
>  		return -EINVAL;
>
> -	strcpy(name, b->name);
> +	ret = strscpy(name, b->name, len);
> +	if (ret < 0)
> +		return ret; /* Returns -E2BIG if destination buffer is too small */
nit: please remove the comment.
>  	return 0;

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
