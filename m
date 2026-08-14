Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5D2F290A;
	Fri, 14 Aug 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697820; cv=none; b=Ps8+I3A1j07w9KylYrUqdC7bWooPPpjEVeI3A0U4rfkEhmn93jF5a5+UF4k6foaUZXzWmruWFHyQBHg/TGOnDMHk5ZAYtCrzV+SIRweooDpNRuxZpjop59tgrE8JXikzvW5E5XWYfDV7Dj84uhKgBJnYzQMKVWiEzN9j2Uh47Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697820; c=relaxed/simple;
	bh=3Pgja917bt0zLh/rH8BxjbhamtXHhAfMh/o/xMp7G+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8obzuJUgYymmt0DN0/1OTDjnbXaLO/JO5qfSfp1HCHMEpTC+uwwWaLeFzyas/mtrlCrt60QQ8dxM2NVk5z3vwbm/sX9sluSvV5JIcUpjaoY65mGUXovLt8cHSLRB5yO6lGIIkHYchPgEYThGiarot5mq0sM3Nz9y9MJLgzC/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7xp4n9l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7xp4n9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425A81F000E9;
	Fri, 14 Aug 2026 08:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786697819;
	bh=bDiho2RndS9Y2AXlBrJ+6gmkaqD0s53nec4rACtNwuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S7xp4n9luTmWA0zmvXuOk1kVvC0Z1/uPr0XDgZ08JAZYRceiJ0UWc6UCnb4SuXM9w
	 nQviOyT1xULegKJKZztCUehxcnbpWbXEPv+odoPBk0xRz5vQ2J4l0fu3n8qh4STKTM
	 4c9NN6+wZXzSS5GENR3lok2P61cG7Ed0C1d+PV5mILN3tv48lZ8xfsXmlrSxDxS59Y
	 0swpislEIgs/EjHvNCWwRunJnm1E3zv2LDeXJqR0oiX5c8xv/PLoTtAbvNAjwh0K7c
	 QDTdXwM51yvpA+e1VstPVnM6T6gaC85jgqZLZnqmLEqh1sslrydO+c/dhXNIm5Gl2c
	 Ru9n1QPDFDQIA==
Date: Fri, 14 Aug 2026 09:56:54 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	Suman Ghosh <sumang@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-af: add NPC TEID matching for
 GTP-U and GTP-C flows
Message-ID: <20260814085654.GG265046@horms.kernel.org>
References: <20260812051215.456258-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812051215.456258-1-rkannoth@marvell.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260812051215.456258-1-rkannoth@marvell.com?part=1

Simon says:

Thanks for the updates in v2.
There is another round of feedback from Sashiko.
I would appreciate it if you could take a look.

---
--- Patch [1]: [PATCH v2 net-next] octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows ---
commit 58f64feb1709d91cb7f52c12d7e09c8779588a04
Author: Suman Ghosh <sumang@marvell.com>

octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows

This patch adds NPC_GTPU_TEID and NPC_GTPC_TEID key fields to the octeontx2
driver. It wires them through the AF MCAM path to allow ethtool Rx flow rules
to match on the TEID of GTP-U and GTP-C packets.

Link: https://sashiko.dev/#/patchset/20260810050436.1822566-1-rkannoth%40marvell.com

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index d422bdd5e8f80..773097cd85343 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c

[ ... ]

> @@ -1805,6 +1821,26 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
>  		req->features |= BIT_ULL(NPC_LXMB);
>  	}
>  
> +	if ((req->features & BIT_ULL(NPC_GTPU_TEID)) &&
> +	    !npc_check_field(rvu, blkaddr, NPC_GTPU_TEID, req->intf)) {
> +		dev_warn(rvu->dev,
> +			 "%s: mkex profile does not extract GTP-U TEID\n",
> +			 __func__);

[Severity: Medium]
Are these MKEX profile capability checks effectively dead code in the standard
execution path?

Looking earlier in rvu_mbox_handler_npc_install_flow(), there is a check:

	if (npc_check_field(rvu, blkaddr, NPC_DMAC, req->intf))
		goto process_flow;

Does this mean the new GTP TEID checks are completely bypassed if the profile
supports DMAC?

Also, if a profile without DMAC support is used, does this expose an
un-ratelimited warning log spam vector if a VF repeatedly requests GTP rules?
The preceding DMAC warnings check for is_pffunc_af(req->hdr.pcifunc) to limit
who can trigger them, but that seems to be missing here.

> +		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
> +						    allocated, req->entry);
> +		return NPC_FLOW_NOT_SUPPORTED;
> +	}
> +
> +	if ((req->features & BIT_ULL(NPC_GTPC_TEID)) &&
> +	    !npc_check_field(rvu, blkaddr, NPC_GTPC_TEID, req->intf)) {
> +		dev_warn(rvu->dev,
> +			 "%s: mkex profile does not extract GTP-C TEID\n",
> +			 __func__);
> +		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
> +						    allocated, req->entry);
> +		return NPC_FLOW_NOT_SUPPORTED;
> +	}
> +
>  process_flow:
>  	if (from_vf && req->default_rule) {
>  		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 99d78fc5a2c4a..7f69e386638ce 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c

[ ... ]

> @@ -1036,8 +1038,31 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
>  		return -EOPNOTSUPP;
>  	}
>  	if (fsp->flow_type & FLOW_EXT) {
> +		int skip_user_def = false;
>  		u16 vlan_etype;
>  
> +		switch (flow_type) {
> +		case UDP_V4_FLOW:
> +		case UDP_V6_FLOW:
> +		case TCP_V4_FLOW:
> +		case TCP_V6_FLOW:
> +			if (ntohs(pmask->dport) == 0xFFFF &&
> +			    ntohs(pkt->dport) == GTPU_PORT) {
> +				/* Check for GTP-U packets */
> +				skip_user_def = true;
> +				pkt->gtpu_teid = fsp->h_ext.data[1];
> +				pmask->gtpu_teid = fsp->m_ext.data[1];
> +				req->features |= BIT_ULL(NPC_GTPU_TEID);

[Severity: High]
Does this unconditional conversion hijack legitimate non-GTP rules and TCP
flows?

Since this logic runs for TCP_V4_FLOW and TCP_V6_FLOW, will it incorrectly
force GTP matching on TCP flows, breaking the rule completely?

Also, if a user specifies a non-GTP UDP rule with FLOW_EXT (e.g. providing a
VLAN or MAC address) but doesn't provide a TEID mask in m_ext.data[1], does
this still set skip_user_def to true and require hardware to identify a GTP
layer?

> +			} else if (ntohs(pmask->dport) == 0xFFFF &&
> +				   ntohs(pkt->dport) == GTPC_PORT) {
> +				/* Check for GTP-C packets */
> +				skip_user_def = true;
> +				pkt->gtpc_teid = fsp->h_ext.data[1];
> +				pmask->gtpc_teid = fsp->m_ext.data[1];
> +				req->features |= BIT_ULL(NPC_GTPC_TEID);
> +			}
> +		}
> +
>  		if (fsp->m_ext.vlan_etype) {
>  			/* Partial masks not supported */
>  			if (be16_to_cpu(fsp->m_ext.vlan_etype) != 0xFFFF)

[ ... ]
