Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5C3CE099;
	Tue, 28 Jul 2026 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222955; cv=none; b=WAfFHY/HXmZM9nXvBosb4ZoqF7ey8O4FZmSRk+FOBQHQN3ndAJwxHSFA3gdvMnSPjOyUtfgxfcXZjaeGPhRFoM+ITedhhtO7en9TkfELLJ1MKMQB0hZu5on/LuJWoWUJXW3UOYXIR8vDPANG7sclyKQrMac5S1C64K7mVf5k7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222955; c=relaxed/simple;
	bh=uEv2gw5pyQyyvzD8mMMctcA14teaSJObgjApkshkdeA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpGqI8LoxMzpju0iHEvilGAQT9p30duCzbGcaQojgFtW4i+RmBKIOEiN7H4nxMsiANr+BegwN/LUTPWGeRnCOtbj7EElRWYluirqgaOE/wjhycklkMtP9Agt7H05GMoDhxqbyhxyLGCaEr15FgR0jBlSaSlSvKrvyNxtiElgvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gLvEOsYZ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gLvEOsYZ"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3ZNEj2866593;
	Tue, 28 Jul 2026 00:15:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ZrO+fTpK4Z3N/Pj4/bH+cprAO
	Eq0xBRc44JFex2dDp4=; b=gLvEOsYZzWfArTIIL0RER2K0I5Kg/WkI1lMru3lWF
	I4ECOQk7Nq6KU0smzJUthxTBtOROqF4wOTBlddZ2pgfz9kTLv1nRbfcr9lOku31W
	V+CjUnKZ0Jauzq4t9cYuER6QQqtsFQsjzG05XRnBfv42n+W0qpRcD/L6mK+LE2rd
	9Ds+e7rTvDToMpgltYDMcVf9CUXM9+rWGrQEx3QmhoiyQ1+wu3ZlcpUgXrImO5Sh
	XKKhL4w9LM4R6d6BZRtPForFPHeAGyjjMowp6HH8mr1P+g6Sc90Zs66YZOTA2Z2z
	yQ3YS9YAc9v6NZ+1dHabxSj3/pn8DhocCihmA14zgOcuA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fpen09m6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 00:15:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Jul 2026 00:15:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Jul 2026 00:15:43 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 4BE773F7061;
	Tue, 28 Jul 2026 00:15:41 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:45:40 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v5 net-next 9/9] octeontx2: switch: add TC flow offload
 path for switch flows
Message-ID: <amhXHG6etEUc9IYi@rkannoth-OptiPlex-7090>
References: <20260724094018.3213907-1-rkannoth@marvell.com>
 <20260724094018.3213907-10-rkannoth@marvell.com>
 <20260727135059.6e0c8fdd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260727135059.6e0c8fdd@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MiBTYWx0ZWRfX8x27QzufJEmS
 HA7boUvm0nw2zRkxTWBy/9QGRaH2fb037WhCGQolGPzssu3STliCQLljQq+iDjvGBcMH6CaJHc5
 UE6FbZDj1JMUzvm4GTIWmb+jUPgiCVlqXuPdpHSNUp1j0OmSHOxEq2QjkX8ltTMTb2z/SzUJ5K9
 hbe9Whr6c5WxbXRRJ8ta3oH2HhppmOdCt9jJ5Cwr0NXhyU9ZiUK629L4UJTiImgAlBEdRudE7fP
 3FryMk0L1hDtEqtFPGAlk+1VzYV7dNBbohCkul+Ig91kturjyCRCH2U7WqaSwOO7YX50UPxgrXh
 CgvVxvZ0CIFbeO4ndK31QnFvZcQOsXP809aox5SmdAoc3fS6D+yx7wB3WFik5vsNQshml3S6VJ5
 kmlVNPEshDOGnlDicIg2U46l/wHWsbJ2EyqE7zHBf2P9mrpT+YJyhZNuBTTRzMDLHIWnQcTmbgC
 SkhewtXOb26/UAWuHgw==
X-Authority-Analysis: v=2.4 cv=GN841ONK c=1 sm=1 tr=0 ts=6a685721 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=CMi7HlEGNmTIVbthW6MA:9 a=CjuIK1q_8ugA:10 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: Fs0UqXiMpS-yTVSmcfyMSwvg-3Mpgo_8
X-Proofpoint-GUID: Fs0UqXiMpS-yTVSmcfyMSwvg-3Mpgo_8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MiBTYWx0ZWRfXxJU+u4qG4BdD
 kFeTrTKKm+JA7pNVQoSqccQezmT0woMAEovHrJJVy7rQ5FPIhqHgWvY+ZjZT0DqxIAQRrhbNsRL
 NHkGsKmzze/Q1R6kgSTrx//Pn+OkLBg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01

On 2026-07-28 at 02:20:59, Jakub Kicinski (kuba@kernel.org) wrote:
> On Fri, 24 Jul 2026 15:10:18 +0530 Ratheesh Kannoth wrote:
> > Register an ingress flow-table offload callback that translates TC
> > flower rules into fl_tuple state, resolves ingress and egress
> > pcifunc via FIB for accelerated ports, and notifies the RVU AF over
> > the PF mailbox.  The AF forwards flow updates to switchdev and
> > keeps per-cookie packet counters in sync using NPC MCAM multi-stats
> > when the switch requests SWDEV2AF refresh.
>
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:682:35: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:682:35:    expected void volatile [noderef] __iomem *addr
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:682:35:    got void *hwbase
> --
> pw-bot: cr
otx2_pf.c is not modified in this patch. Could you please help me understand why this warning
 is popping up for this patch ?
