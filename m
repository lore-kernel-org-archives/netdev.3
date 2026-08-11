Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754843E07D;
	Tue, 11 Aug 2026 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447535; cv=none; b=GUDavwrj7aTJcAC7+CsdxgnuvE/Vn3tEEqIFuTHCCVt2oUnLa3cFYXLkEcJodpI2drWZGn1/05POviuruThyGRCJj7PJRt5wHRkeCYpb7RODVbI+JbspiQV136oOxUbXxpJ1t0Ahc+PLX9KqWxnYabpf1p6R9oDV/pDaPaAtvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447535; c=relaxed/simple;
	bh=5vlHI1NCkgEZeqiHJ22QUNs8CkyEkvCaIeKW5aMPJG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOL9fRSCxmMoKZHff9/TiLUpQe2N5f4sI9fkmdv8sPAW626XDaLAI2gCxBMRS6zp5IKnnixiBJRIsGg6fbeOt9P5giUdb9y6UEeOdxpmx1MhEQtwxIHzmPtMDT3XWrhO6/FDyMoR8SsEctbzLVgaDFkXy4q0s4Ce3GwJ85WkBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op/hwaol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op/hwaol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758FB1F000E9;
	Tue, 11 Aug 2026 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447531;
	bh=XaxONoBeedhKqdTiZBFe3QzEzLliadeDNiuIiXIDC9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=op/hwaolEehe+eCiC9MzXKnYpQAZ4iCN13R8RouigNvGwRp+y0QVd8BECW9elH50N
	 CztoaNQXEUXpRJeccDM1khiPFVwMdBLyQHGwOqq+Y9sfCiYiEa3O7NQOgGwQP/X34W
	 Yy55a3qtQ8xd8uk0KzUZ/kwSmb+9cMASV+nvcXbBr4TTaC74IwVN4tAkd37s2uI8OB
	 TM+99V1neK2U/SWlsFAqVzU5mTMfV9jmDxqclZNsVUUwG3wLwlrd8lu7leeHGiJRda
	 tXa9q12aKB21fSRXjCNUginazSvKSo1Un4zbLXHE4X9V2La52WwO3gkvm3j4CpmlBy
	 eVqePwZwLtRdg==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgoutham@marvell.com,
	sumang@marvell.com,
	gakula@marvell.com
Subject: Re: [PATCH net-next] octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows
Date: Tue, 11 Aug 2026 12:25:09 +0100
Message-ID: <20260811112509.829542-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810050436.1822566-1-rkannoth@marvell.com>
References: <20260810050436.1822566-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260810050436.1822566-1-rkannoth@marvell.com?part=1
---
--- Patch [1]: [PATCH net-next] octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows ---
commit 98f9555a96987d26df070fd9f55b613312f67f14
Author: Suman Ghosh <sumang@marvell.com>
Subject: octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows

This patch adds NPC_GTPU_TEID and NPC_GTPC_TEID key fields to support
ethtool Rx flow rules matching on GTP-U and GTP-C TEIDs. It wires these
fields through the AF MCAM path and exposes them in debugfs.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1839,6 +1839,8 @@ struct flow_msg {
>  		u8 next_header;
>  	};
>  	__be16 vlan_itci;
> +	__be32 gtpu_teid;
> +	__be32 gtpc_teid;

[Severity: Critical]
Is it safe to insert these new fields in the middle of struct flow_msg? 

Since this structure is embedded in the npc_install_flow_req mailbox message,
wouldn't this shift the memory offsets of all subsequent fields (like mpls_lse
and the trailing fields in npc_install_flow_req)? This might break the PF/VF
mailbox ABI for older VFs communicating with a newer PF, potentially allowing
corrupted state.

>  #define OTX2_FLOWER_MASK_MPLS_LB		GENMASK(31, 12)
>  #define OTX2_FLOWER_MASK_MPLS_TC		GENMASK(11, 9)
>  #define OTX2_FLOWER_MASK_MPLS_BOS		BIT(8)

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> --- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> @@ -214,6 +214,8 @@ enum key_fields {
>  	NPC_DPORT_UDP,
>  	NPC_SPORT_SCTP,
>  	NPC_DPORT_SCTP,
> +	NPC_GTPU_TEID,
> +	NPC_GTPC_TEID,

[Severity: Critical]
Could inserting these enum values in the middle break the PF/VF mailbox ABI
bitmask? 

The integer values of enum key_fields are used as bit indices for the
req->features bitmask sent over the mailbox. Inserting here shifts the integer
values of NPC_IPSEC_SPI and all subsequent fields. An older VF requesting an
IPSec rule using the old bit index might have its request misinterpreted by the
new PF as a GTP rule.

>  	NPC_IPSEC_SPI,
>  	NPC_MPLS1_LBTCBOS,
>  	NPC_MPLS1_TTL,

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -3437,6 +3437,14 @@ static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
>  			seq_printf(s, "%d ", rule->packet.icmp_code);
>  			seq_printf(s, "mask 0x%x\n", rule->mask.icmp_code);
>  			break;
> +		case NPC_GTPU_TEID:
> +			seq_printf(s, "%d ", ntohl(rule->packet.gtpu_teid));
> +			seq_printf(s, "mask 0x%x\n", ntohl(rule->mask.gtpu_teid));

[Severity: Low]
Does the %d format specifier display the unsigned 32-bit TEID correctly here?
If a TEID has its most significant bit set, it appears it will be printed as a
negative number instead of an unsigned value. Using %u might be preferred.

> +			break;

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c

[ ... ]

> @@ -720,9 +724,10 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
>  		*features |= BIT_ULL(NPC_IPPROTO_ICMP6);
>  	}
>  
> -	/* for ESP, check if corresponding layer type is present in the key */
> +	/* for ESP/GTP-U/GTP-C check if corresponding layer type is present in the key */
>  	if (npc_check_field(rvu, blkaddr, NPC_LE, intf))
> -		*features |= BIT_ULL(NPC_IPPROTO_ESP);
> +		*features |= BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_GTPU_TEID) |
> +			     BIT_ULL(NPC_GTPC_TEID);

[Severity: High]
Is it intentional to advertise BIT_ULL(NPC_GTPU_TEID) and
BIT_ULL(NPC_GTPC_TEID) without specifically validating them via
npc_check_field()?

If the hardware Key Extraction (KEX) profile doesn't actually extract the
TEID bytes, claiming support for these features could result in rules being
accepted by otx2_prepare_flow_request() but silently ignored when programming
them in npc_update_entry().

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c

[ ... ]

> @@ -1036,8 +1038,29 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
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
> +			if (ntohs(pkt->dport) == GTPU_PORT) {

[Severity: Medium]
Should we also verify that the port mask is exact (0xFFFF) before inferring
the GTP protocol?

If a user configures a broad UDP matching rule with a base port that aligns
with 2152 under its mask, this logic might misinterpret it as a GTP rule
and apply TEID features incorrectly.

> +				/* Check for GTP-U packets */
> +				skip_user_def = true;

[Severity: Medium]
Is the skip_user_def variable used anywhere after being set to true?

If a user requests a GTP flow rule with a TEID of 1 (which equals
OTX2_DEFAULT_ACTION), the fallback else if condition later in this function
checks if fsp->h_ext.data[1] == cpu_to_be32(OTX2_DEFAULT_ACTION). Because
skip_user_def is never evaluated, wouldn't this incorrectly override the
requested Rx queue action with NIX_RX_ACTION_DEFAULT?

> +				pkt->gtpu_teid = fsp->h_ext.data[1];
> +				pmask->gtpu_teid = fsp->m_ext.data[1];
> +				req->features |= BIT_ULL(NPC_GTPU_TEID);
> +			} else if (ntohs(pkt->dport) == GTPC_PORT) {
> +				/* Check for GTP-C packets */
> +				skip_user_def = true;
> +				pkt->gtpc_teid = fsp->h_ext.data[1];
> +				pmask->gtpc_teid = fsp->m_ext.data[1];
> +				req->features |= BIT_ULL(NPC_GTPC_TEID);
> +			}
> +		}
> +

[ ... ]
