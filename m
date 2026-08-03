Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EA82494F0;
	Mon,  3 Aug 2026 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785730649; cv=none; b=JRu6PraFAQtf4DGzHyki4mgkFd7g/8jtghCKydKFn4hbvJcDuzEWXmJ3ZNkJ3mndRgs2Pjoo18L2Tl8qSuKN0VTQHBqtwdcZ52Q5y/K/nBlbNUYg7XeEZ5TMSOWtKWJrAIepKRBCBSJP4gxKKb228N/LjMYDjAlUZ09BMzG9foc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785730649; c=relaxed/simple;
	bh=7puaKD6WwUBEoT5hXn4jFe8y/EZGwOoGlxsTX9lhCLQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYHcAeT9vgX9oB7D+gpQkU1kXMYEYw2yCWMWU0BiBkIRLZ3I3cJBVE9mXFNIfalS2QMjoZywjVbptjBxyWQF8C/rxbJ18nbgkGgIy7J1noo8tfYepM9PqRBPHWF448S7DwyiQTXavRvkKfRANSroAKz1EOPyI5GcC9iIWF3ph5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jaCm9Wr9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jaCm9Wr9"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6730K9ck1767071;
	Sun, 2 Aug 2026 21:17:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=7puaKD6WwUBEoT5hXn4jFe8y/
	EZGwOoGlxsTX9lhCLQ=; b=jaCm9Wr9SniDXj47vz5PZRoF/frhIgOIKcr/XaKDe
	MC9pSLZdJDCAAKp5VxaJadHEcy9q17eFYlrtceINtj+9/dnFTKrs6h5T3EWjOsx4
	85cSQQ3bHU1ptMeFbSEnUkyt3kkxaC0xI5nuqybuiANXw3YjPZnmcl1sEVHcJzmm
	k4V5JmHHvbZzVkraYaCTphco4WkAMjPhPcWW/+9hyxYiDMCBvfzMQspmLHLPztF4
	sZ1I8eijvNPm/JkJi2L+klxTwllTc1z1yC+xPKQcvIdskxVaJqTwt3U2425PCVts
	PlzTyDGdy9yVz9PTYSsPPOyW/8atMzH2MAnkABlAXmNCQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fsgag34eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 21:17:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 2 Aug 2026 21:17:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 2 Aug 2026 21:17:06 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 694233F704E;
	Sun,  2 Aug 2026 21:17:03 -0700 (PDT)
Date: Mon, 3 Aug 2026 09:47:02 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v3 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <anAEr5qsNBh5_msT@rkannoth-OptiPlex-7090>
References: <20260729105139.2302908-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260729105139.2302908-1-rkannoth@marvell.com>
X-Proofpoint-GUID: xv344PdkBO_9Bx1WG0rxWJnTlipENLyd
X-Authority-Analysis: v=2.4 cv=GaYnWwXL c=1 sm=1 tr=0 ts=6a701643 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=pUhW0NasXGczhlxQT_kA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAzMyBTYWx0ZWRfX6G4FblsSnhuv
 uQqcNyVRHpc899pDkpJuovu2tKpkRqLAk2hnumx5CpHcRcEvYXMWHgiDRAJjhOFi3sjuqv9pv6r
 g1M2wuC7rAgEedCaITAzHaNtj0kuRC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAzMyBTYWx0ZWRfX3TdObwZOifNs
 FdHa0Q0EtVUD2ugIzZNS5mFfQi8scvRNUxi/LOI8PstDWNkyWFwxCR2A6o6rb0L7p3yZyQZfVFC
 Z+o2KLA+NBv/VbjuDHGHUugNJRhw64x1jG7kHHFB/lrh51GhzQSAU2pJdWdyb37TpoPgX8J7s/V
 jesdXJwWbNt/OQD5XdZA/3pQieoXoHEMkpkJ66wvgucEftBPfMDnJdT3TPg8W3brK7zbst3nd5k
 jYOnKqNGgzLaqXthadbg/srwQ7h9pnvny1xRwkhghqz0kr8dBB/0RvKxkkYW/Fplh/3yXS7hJGN
 S6ZIr8BkpeKEn/K/5KoQI0AKDXorkFoCMtUbRtCsm8Nr1dygyGsXuK4ZbKaFbbRxbfk0W+Slntv
 Mi0v/RELdHccYlvfRu1mnPRzgWRLkDU5ob948E3/fY6rawTDWDXUNFosr9+iaTSqp3H+BZ9nnjV
 yS/lpjSYnh6WBpFzHFg==
X-Proofpoint-ORIG-GUID: xv344PdkBO_9Bx1WG0rxWJnTlipENLyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01

On 2026-07-29 at 16:21:39, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add TC_SETUP_QDISC_MQPRIO handling to program per-queue MDQ CIR/PIR
> shaping after mqprio channel mode setup, widen SMQ allocation when
> per-queue rate limiting is enabled, and align MDQ parents under that
> mode. Reuse otx2_convert_rate for bps-to-Mbps, fix sparse register
> writes when only one of min/max is set, and improve AF txschq map
> mismatch diagnostics.

Will address sashiko comments in v4

pw-bot: changes-requested
