Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DA3B993B;
	Wed, 23 Sep 2026 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135992; cv=none; b=KL9jtX304d4pjDqG+LTSwSXaDmtDBpQ/lLVaLQeZ9CRhTsA/jWoa7v7GkWyaDMfcp8yNauE6HAMzy5pB9U53dNsukBZSe2MqEFqJPsqpQZvModzkxjWOw2mVGFXr40PoVFmueLnakth3l09HCB5FsiN6JAEJQgJ3MRctcy+iXdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135992; c=relaxed/simple;
	bh=Ade9z2snR8UANxq8D449N9U8rLoOAtRhCLpA06rC1d8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMnEbthH3HBEzd71SNC8bqDwtcODqjtG8lTRJme59GfilgSci2tPl0uFS3+Imlrd1Mrumy1AEcrOk3J47jrRl3aulvg08vF3P+qc7T4OegKsfMOBUSOq1xs3E47EIvF0zN5YvmIzW9fH/+vhO4XmFVGRI0ycvSGDQ1J23BwlEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=glmLy8V7; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="glmLy8V7"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3jguJ3270954;
	Tue, 22 Sep 2026 20:59:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=583TZTC+aB6USk9lHMGAYPPxI
	yLBzC0OlAKfReC3We8=; b=glmLy8V7s2dGo6NS/MrbbpzsSGWwm5gUiKnzJPoF1
	PeL2sPvwm3Jh6RTr2zd2u0Vymww+C0oPNp+ubjYBm1hQkUC1yUjN1fTcAnA3dFP2
	CVOeKxqSYfXyMa47ciov43JiXcWG6hc9x7liIFtB7IFcQur29oGw/HZgGt2DraPV
	EvUsNEEtT04W3LdFIeONmeCyjA4zoojJWoDiZMnzUz4Jx+IhhUQ7FCK0ggPHVhts
	zDwZH8Z1B4FpdEsp4FonnlpSXn68Xn5aJEynDHLgpf9dxZNfooVc3KK2tiK1dI1B
	af7Ib6Bqbn3BniGNjV2fvnddRaST5d2FLGdnAffwNaDNA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4guabug678-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 20:59:42 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Sep 2026 20:59:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 22 Sep 2026 20:59:41 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 1A3B93F7072;
	Tue, 22 Sep 2026 20:59:37 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:29:31 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-af: Add couple of mailbox support.
Message-ID: <arNOo2m2UV0R7AOZ@rkannoth-OptiPlex-7090>
References: <20260923032816.1740106-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923032816.1740106-1-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: gVm3oQgbp3mLAIAo7zO6K9f75CiZj8Uv
X-Proofpoint-GUID: gVm3oQgbp3mLAIAo7zO6K9f75CiZj8Uv
X-Authority-Analysis: v=2.4 cv=PMOaavqC c=1 sm=1 tr=0 ts=6ab34eae cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=FXRivRzO7OE6NwQmqLIA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxNSBTYWx0ZWRfX4wnlHyE1Rs3T
 0G4QTuGi+ldMPgjCEymB/5PGtR2Dt46yRmfOh4Os/q1Dm1xOdqdXgRVaPSaATl7cbFf3XLzlLHs
 2ITM3XunZFAnwfVmx0NcSFUcgUGzfDsCzHUkmVVOwsPm885sGANBRiek716NjEbBt427KIFld2g
 ClhAnkB3Qo5d9ufTwngte0FBhDL7qX59JrcqMWI2DJp8CBmzdTLb8MYT4bgO4OH35X0uQnbK0m3
 Eu/E2pNYL7Go4jbJFxHa75luDh1d8635ZQLeGKaOI4lWPbzmML5eXBPClJ7kTAKNef/wrCWeeYK
 c5+IsvX4NKhstRDwGdEliJA2Yl4R17OPafbRKKccrYoTxzjpuWj7FXHlnptHRz5tDgbz1W59JL3
 MUyY5qYBpew6bOff+Gfefpv2sealwFNg3TM/NiAKItVa74hZEpk8ukJ5jqMRUyUSxNHyOV5xNo9
 lbTSI3lznW3K9ohKGmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxNSBTYWx0ZWRfX6USUnRXb4BDJ
 3+Js1G2lOqEuiWHfHEm+9TqzIZ9WcWtdeQE+KquaINwQffG3tmq/nAwQ9Wkp9UcfJi1p6JkBzqk
 /0DBtmPEYzdEZTVl/FDdzE8tQySkEOY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01

On 2026-09-23 at 08:58:16, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add IFACE_GET_INFO and NPC batch flow/stats/features handlers for the
> RVU switch PF, with synchronized NIX context and channel publishing.
>
>   IFACE_GET_INFO:           report PF/VF channel and queue topology
>   NPC_MCAM_FLOW_DEL_N_FREE: delete flows and free MCAM entries in bulk
>   NPC_MCAM_GET_MUL_STATS:   read MCAM counter stats in bulk
>   NPC_MCAM_GET_FEATURES:    report supported MCAM features
>
> Rework NIX LF context memory publish and teardown so queue context
> pointers and bitmaps are assigned and cleared under the NIX admin queue
> lock.  Publish interface channel fields under rsrc_lock so IFACE_GET_INFO
> can read a consistent snapshot.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
>
> ---
>
> v1 -> v2:
> - Drop SWDEV2AF_NOTIFY and the switch skeleton hooks from this patch;
>   keep the series focused on the AF mailbox handlers above.
> - Restrict IFACE_GET_INFO to the PAN RVU switch PF (rvu_is_switch_pcifunc())
>   and return -EPERM for other callers.
> - Hold rsrc_lock while building the IFACE_GET_INFO topology snapshot.
> - Publish and clear NIX interface channel fields under rsrc_lock.
> - Publish NIX LF queue context pointers and bitmaps under the admin queue
>   lock; propagate assign failures and free partial allocations on error.
> - Fix nix_get_tx_link() for representor and LBK VF devices.
> - Propagate NPC flow deletion failures from npc_delete_flow() and the
>   bulk delete/free handler; ratelimit bulk handler error logs.
> - Read NPC MCAM features under mcam->lock and clear mul-stats response
>   on entry verification failure.
>   https://lore.kernel.org/netdev/20260918050021.1359606-1-rkannoth@marvell.com/

Please ignore this version as it was sent with an incorrect commit message and changelog.
Apologies for the noise.

pw-bot: changes-requested
