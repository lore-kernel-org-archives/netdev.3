Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81A41FE44A;
	Mon, 17 Aug 2026 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786938920; cv=none; b=gh6V1BZFguMOkrV3/qy1cC1Vyny5CLBYcu8hcO8MxoXY0gsnkfRh1U9mlRKpTKCH4EuNoR5jfjMlOF+DjWGkszp7v1Fja5d5O54aniiRyXoKMdAKt3rVKF2oTLFc7jfpPCUJ7zDUtNoSlHJirDIOoBfspIlOrMVfDqJmRPxmxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786938920; c=relaxed/simple;
	bh=PY4dpZJIIB6i030nOf/BYUKcqLCGCYwZvY6Qk0Dkfhc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqLC7j61KGTCGwsBqVhKQvnvdbFOhipPQr9Vg4bjyVgCuQu80CsBvIUvIQATyFVUQWWMwqx9LIQIcxveVq2U0kkvMwZwcrdTEZ2H8j8DtyxaIp9cs5RmJx2hqXcOQ9ce7sHefh7uoJ5HgQUHkzwUJSieL7lqdKuEugeUrNg7ONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SDFTRMyX; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SDFTRMyX"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GNgGMN876231;
	Sun, 16 Aug 2026 20:55:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=mG2aOn/jh76iy+NgvJSAnvtUt
	zheYrZbeoUSzaAQ+Nc=; b=SDFTRMyXCoX2OdVbvZIMuHBrJpvl6lovpg4TQCzA/
	MJdpBwurbdKV13eyJQv2Hxv09ONgPXJpignAw5abfy4pkyXYuAbT9NRUvreuPvqB
	bV2oaj0rphNFeS9HwkcW1ggdqL5XB37P47dI8WxjMYvf8hd926P/f/A9GDU+75pT
	QcTki9JxMivd3zR79fLdHfKehXEKuB4WaIQ5Rfz2LIaO+xEeWlB+pARGgzy+pmSM
	bHqwW1v/f9+wiQHaX0+ziJ82aCwZgWuw7wk7DLfEID2adURswNCGaJNhf4ZQrlAo
	sNihoR9qA6T57KUz9cgKUlzHcbZfiCMs1JpMuzNMscLFQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g36v39cx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Aug 2026 20:55:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 16 Aug 2026 20:55:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 16 Aug 2026 20:55:10 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 55DAC3F7080;
	Sun, 16 Aug 2026 20:55:06 -0700 (PDT)
Date: Mon, 17 Aug 2026 09:25:05 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Suman Ghosh
	<sumang@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-af: add NPC TEID matching for
 GTP-U and GTP-C flows
Message-ID: <aoKGGYWIOHQSvevx@rkannoth-OptiPlex-7090>
References: <20260812051215.456258-1-rkannoth@marvell.com>
 <20260814085654.GG265046@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260814085654.GG265046@horms.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyNyBTYWx0ZWRfXyu2ijD9V3NWT
 TURqyXweRLGYbOuHop9Nmdw/bmjBOVWrDe6u10zUkThqpW2VYVkhn2YpaP9il8uhZC2zujVWAIL
 XoCjnPcV77667BNvNzXIodWQCWvMv0s=
X-Proofpoint-ORIG-GUID: AVs2IBUfJOtiWU6GwzFsElwH5yYJKiyi
X-Authority-Analysis: v=2.4 cv=MatcfZ/f c=1 sm=1 tr=0 ts=6a82861e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=cgdB7Ehg_v1XXFyNTNYA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: AVs2IBUfJOtiWU6GwzFsElwH5yYJKiyi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyNyBTYWx0ZWRfXzv7CN4QxMKrS
 nW/zfxxOi/HUEAyuHo+V+emKbZ2fyMZlqRVI35ghjPcDURAEWa9sb4IYtKa8Z15asDGi4fAnbpC
 W1jtQXSwWg0CwfOUlzLdIjyFujmop7wnqCUrGrm2FZxnwYNk5hGgg3cLSWbJPzhzgUVHWB3ZG3l
 FWGhFt6GKRua02tM+KxlNCUgMvFUbRzKpuZNeYs81FsWLFCCdGjik8gJ9WOsCj4WjQHB/QgWyAf
 F3TrIn2RqjznpgnAszahDZty2loC/R+p8/hhhoNro3FmPS+z8Oq2X4c7jz5OfknJAaEa8dMdy4+
 WVHTXF28T2dImhW6reMuoLi35CZ9k/r8D7yZzgZm3LrCoMYV3qXTLnX9BdeB2hlYtGPkLLl5u2h
 ykoIwHe1AL95TNZ8zxYx9XiFjlUpiyITKHHAt05EMjCjvFWwixzJbWwExNoctfSvzFKSO/h2tBM
 JWH7wYqGEUU7Mtx0lpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01

On 2026-08-14 at 14:26:54, Simon Horman (horms@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/20260812051215.456258-1-rkannoth@marvell.com?part=1
>
> Simon says:
>
> Thanks for the updates in v2.
> There is another round of feedback from Sashiko.
> I would appreciate it if you could take a look.
>
> ---
> --- Patch [1]: [PATCH v2 net-next] octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows ---
> commit 58f64feb1709d91cb7f52c12d7e09c8779588a04
> Author: Suman Ghosh <sumang@marvell.com>
>
> octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows
>
> This patch adds NPC_GTPU_TEID and NPC_GTPC_TEID key fields to the octeontx2
> driver. It wires them through the AF MCAM path to allow ethtool Rx flow rules
> to match on the TEID of GTP-U and GTP-C packets.
>
> Link: https://sashiko.dev/#/patchset/20260810050436.1822566-1-rkannoth%40marvell.com
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> > index d422bdd5e8f80..773097cd85343 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>
> [ ... ]
>
> > @@ -1805,6 +1821,26 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
> >  		req->features |= BIT_ULL(NPC_LXMB);
> >  	}
> >
> > +	if ((req->features & BIT_ULL(NPC_GTPU_TEID)) &&
> > +	    !npc_check_field(rvu, blkaddr, NPC_GTPU_TEID, req->intf)) {
> > +		dev_warn(rvu->dev,
> > +			 "%s: mkex profile does not extract GTP-U TEID\n",
> > +			 __func__);
>
> [Severity: Medium]
> Are these MKEX profile capability checks effectively dead code in the standard
> execution path?
>
> Looking earlier in rvu_mbox_handler_npc_install_flow(), there is a check:
>
> 	if (npc_check_field(rvu, blkaddr, NPC_DMAC, req->intf))
> 		goto process_flow;
>
> Does this mean the new GTP TEID checks are completely bypassed if the profile
> supports DMAC?
>
> Also, if a profile without DMAC support is used, does this expose an
> un-ratelimited warning log spam vector if a VF repeatedly requests GTP rules?
> The preceding DMAC warnings check for is_pffunc_af(req->hdr.pcifunc) to limit
> who can trigger them, but that seems to be missing here.
>
> > +		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
> > +						    allocated, req->entry);
> > +		return NPC_FLOW_NOT_SUPPORTED;
> > +	}
> > +
> > +	if ((req->features & BIT_ULL(NPC_GTPC_TEID)) &&
> > +	    !npc_check_field(rvu, blkaddr, NPC_GTPC_TEID, req->intf)) {
> > +		dev_warn(rvu->dev,
> > +			 "%s: mkex profile does not extract GTP-C TEID\n",
> > +			 __func__);
> > +		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
> > +						    allocated, req->entry);
> > +		return NPC_FLOW_NOT_SUPPORTED;
> > +	}
> > +
> >  process_flow:
> >  	if (from_vf && req->default_rule) {
> >  		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> > index 99d78fc5a2c4a..7f69e386638ce 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
>
> [ ... ]
>
> > @@ -1036,8 +1038,31 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
> >  		return -EOPNOTSUPP;
> >  	}
> >  	if (fsp->flow_type & FLOW_EXT) {
> > +		int skip_user_def = false;
> >  		u16 vlan_etype;
> >
> > +		switch (flow_type) {
> > +		case UDP_V4_FLOW:
> > +		case UDP_V6_FLOW:
> > +		case TCP_V4_FLOW:
> > +		case TCP_V6_FLOW:
> > +			if (ntohs(pmask->dport) == 0xFFFF &&
> > +			    ntohs(pkt->dport) == GTPU_PORT) {
> > +				/* Check for GTP-U packets */
> > +				skip_user_def = true;
> > +				pkt->gtpu_teid = fsp->h_ext.data[1];
> > +				pmask->gtpu_teid = fsp->m_ext.data[1];
> > +				req->features |= BIT_ULL(NPC_GTPU_TEID);
>
> [Severity: High]
> Does this unconditional conversion hijack legitimate non-GTP rules and TCP
> flows?
>
> Since this logic runs for TCP_V4_FLOW and TCP_V6_FLOW, will it incorrectly
> force GTP matching on TCP flows, breaking the rule completely?
>
> Also, if a user specifies a non-GTP UDP rule with FLOW_EXT (e.g. providing a
> VLAN or MAC address) but doesn't provide a TEID mask in m_ext.data[1], does
> this still set skip_user_def to true and require hardware to identify a GTP
> layer?
>
> > +			} else if (ntohs(pmask->dport) == 0xFFFF &&
> > +				   ntohs(pkt->dport) == GTPC_PORT) {
> > +				/* Check for GTP-C packets */
> > +				skip_user_def = true;
> > +				pkt->gtpc_teid = fsp->h_ext.data[1];
> > +				pmask->gtpc_teid = fsp->m_ext.data[1];
> > +				req->features |= BIT_ULL(NPC_GTPC_TEID);
> > +			}
> > +		}
> > +
> >  		if (fsp->m_ext.vlan_etype) {
> >  			/* Partial masks not supported */
> >  			if (be16_to_cpu(fsp->m_ext.vlan_etype) != 0xFFFF)
>
> [ ... ]

Will address in v3.

pw-bot: changes-requested
