Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952773;
	b=3+mJXDRJn9zZNIobErOSscPI8DFbhL8ljVo0fSH/uIT5F/5eZSSMrX84RAV5DmfnLSk6
	 DxR9m1FUeIslmKTLNA2RFbmSh7H6N5KUlgdrq1nIVCiAnzLcn5z+quzE0A6WXW6D4L1Cr
	 /P3ZqCDPW1xtH8nDclBAs0tui8ESUUqUMCaeG8kwkcMRzrWbkQP3zUvmp6wcfZH+XscxZ
	 bAHxoR8eO0qj/DBZy+//Oc564ULVmnrupq+aQrdEB9ahHDiC2UQyQ9NwOssDjEAqWlurB
	 NUIW+w1AH2XU56Q7YEs32Rj48ZFeNfw+ZFbThF/x5xXnqdIth+CwWA9zU+/64VwElAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952773;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version;
	bh=vK1O462TcjJwJdrHcM6IXUBg2Hc82ddME/vlDO0CVf4=;
	b=SeEGSAuLlLicm4/N5W8Q76jNtWsgy2JY4OPl5KoWQ3V/bCGwFGMdtroThLTQ94jxEbOO
	 J7r4vV6eR0jWjzFPcnQcFbkZBUaNjG8lchdf7FT70XKch1H1OGiGOuvAi1Rl61Wmv6mHG
	 eBd2hOOKwkkD55gcSmJ5W1VVXuyhIw2QCjyjs8Tf77+6FVAyCN1+3SBWqMEBfO2iD08eJ
	 G8eAmTNRBc9hAHc3q3dw6le3L/3VjrDwXL7HwP3QpqVEBZ49XfYZkqUaVMO98nuvoJDvW
	 5xZ6K45G8IXJOzuSj6aK7L0G6VyJrNpK1D9QmI2R/v1GjypJUWHxdElm/twLLzJ479g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b="AvSk/6qn";
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A55606A334;
	Fri,  6 Nov 2026 08:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6A55606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=AvSk/6qn
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67SL234164076;
	Fri, 6 Nov 2026 00:12:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=vK1O462TcjJwJdrHcM6IXUBg2
	Hc82ddME/vlDO0CVf4=; b=AvSk/6qnePJfaDChzAbk58vV25RUr2hCTHdA/VVi9
	H5vF8SSgIq1T8oKBedE8jdtoeD3qS0zSQtJKC5LGN1qsqPonVGQ7horXOg+Fiqt6
	5+p7o5JeAv6cB6MX8GsZNRXj9ShVma9dgcRkLdxZi5w2ebDmZ6+3zMbZZ2U27gVx
	NK64S7yS8Iuq4gRCUCOlHDDiEBKsULJm3QJH/mtvGFdJzci9huucN5I9AY04B6OM
	JGV97cwHLVCJ6NrgqGiTpZGRNFnISVw6bLldWbxK6tI3RBf2gSCCLDdJcEmfqYTS
	jFA2Gz9FG52/B871ZpmudgcYkZvMmxwEhSt3o/UtzyAhw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hs3qs1jxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 00:12:35 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Nov 2026 00:12:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 6 Nov 2026 00:12:33 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 31BC95B695F;
	Fri,  6 Nov 2026 00:12:28 -0800 (PST)
Date: Fri, 6 Nov 2026 13:42:28 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Suman Ghosh
	<sumang@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Kiran Kumar K <kirankumark@marvell.com>,
        "Michael
 Bommarito" <michael.bommarito@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] net: octeontx2: fix building without DEBUGFS
Message-ID: <au2L7FZlj0uyF9ba@rkannoth-OptiPlex-7090>
References: <20261105161945.1658464-1-arnd@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261105161945.1658464-1-arnd@kernel.org>
X-Authority-Analysis: v=2.4 cv=WZCZ+EhX c=1 sm=1 tr=0 ts=6aed8bf3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=ShSd-FWY-unVLXGE1vIA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: O6aTpAeTmti8oCqHhf9aQ_rkqBg8h89e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzMiBTYWx0ZWRfX3/2E1WyyYymj
 V2jiJPGgKZ57B2gx2lbGTzsMe3rNfNyCCNR8YDB+Lmwgj0P5D32a+Qvo3Hoq15UBryB7vs/jBN5
 6E+dbEIidSmJnLNQHQJUrCGBMyDlTkh7Xz+B3gTTzjlH0AkmluwKd6qy4mPRplhmtF195/wUEsw
 9kptyVyaSsERtn7iTGzzC9EnQNLdFrnZgRFqNoNQN+y0OEYaNAH3y+ffmToyAFoCQVzpkn+9sEw
 mHgngsLO/2HU8ckCsHFy+BJKbckUAIENLkBmFgLfqOmSrZRSYpPd7nPL0d4EuIn9UV9NWrFuoG8
 zHP/LPH/B5NkwN6kd3kX0yzoM1cWDi8AkGTp0wKxZqPQGbQ+gFZWhpqrGzFQ9ULRWhND4ymZ8aO
 b0P/66N01NWNhUbNDmfh7JDvk9HtcCMIYhi7M4iBgAuh5CU4VYG3YD91OO/TcV45I2Rs4zh61Yc
 9/EfgWAANJz3QkQHiRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzMiBTYWx0ZWRfXwLOjQY4MqV8R
 WuiI9bi312w871Kcvcjt7usBUnAfYk9v6FZZik2hd3lF1iV6XqbnwCMLa3b32qvjbkpTlVShvLO
 7LPN9tmZQ2UUP+59cQYqD//RZwSd6VU=
X-Proofpoint-GUID: O6aTpAeTmti8oCqHhf9aQ_rkqBg8h89e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01

On 2026-11-05 at 21:49:13, Arnd Bergmann (arnd@kernel.org) wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This error came up on my randconfig tests this week:
>
> drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c: In function 'npc_cn20k_debugfs_init':
> drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c:392:55: error: 'struct rvu' has no member named 'rvu_dbg'; did you mean 'rvu_dl'?
>   392 |         debugfs_create_file("mcam_layout", 0444, rvu->rvu_dbg.npc,
>
> The problem here is that the rvu_dbg member is hidden in an #ifdef
> block, but the reference to it is not.
>
> Remove the #ifdef and waste a few bytes in the structure in this
> config. Note that the debugfs_create_file() call end up ignoring
> the arguments, so the actual debugfs implementation is still
> ignored here.
>
> Fixes: 528530dff56b ("octeontx2-af: npc: cn20k: add debugfs support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ratheesh Kannoth <rkannoth@marvell.com>
