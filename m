Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174B3A873D;
	Fri,  4 Sep 2026 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517909; cv=none; b=DQhvQhwYPiNq+8xTMK4sIc/F2FTDiyqh35WzjPwS5HFggtRsaqUGj4bm+9K9aZKPokOuttJWY/ChSdjy93WfUCiXAFGsaOcUYHTBR1Lnvk7P/bO2feIKP+mvg4l9jJC4/ejjpqISPPP4VfQ/Kn2MGDzxdmdiGhUMIOO/61CXSA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517909; c=relaxed/simple;
	bh=rRXCCalqfFNsIVKRQX7ydoNgK5N95LEqS2NZPDAjp6U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lo+r4Px6nGsjO2SUL3kNvKdmOZJiLu1aVCn7y49E3dL4EmjYch7g1ukjXU/kc5FKwD5HU6VHp/R4fc232XGZeCVXXx2VUIFIGlTU8HQ0ACftWNSlI9nX8t0qTyoFW1r0IQtOtYWHPTbWP/TgT0pnxMH/t9LC95umXFJmQZ4i6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtMilclr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtMilclr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875D01F00A3F;
	Fri,  4 Sep 2026 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517907;
	bh=BQXlgGbF0S49ekM6YtK1+M8FqSOqwV5jHC1jvFtp6UU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TtMilclrxwyUz8Lq9mklFrBQi4pHSiTln2oF5MtV6+bN1ky1aNr3UOAvZbDT61HYu
	 oqMQZX0q3EMoKsAu4qnUm+2qxTsDaQV1w5xR+pyoFwSmxZG5Rxa1aN1HNbIJIX5iCV
	 1Lqk9foaxNXSHzl0O7YWrOEB6CB+lEAvzgYG4OLKeAIaBdBKTwnDz+vhGnVHnK7U23
	 57xtc16w6EjgFpDwKoGpH+j1tUfHRNE0+oYbWreS3utkyBTU3IFxTuF57mUz1l44lM
	 GtK6KUIlL87b3pRaDyGfD9SiOylVkQkekGEiMoyGSgLp+mq+TBD+wPhT3u5jB/WMeE
	 Qk0xGJ0obAB6Q==
Subject: Re: [PATCH v4 net-next] octeontx2-af: add NPC TEID matching for GTP-U
 and GTP-C flows
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, sumang@marvell.com,
 gakula@marvell.com
Date: Fri, 04 Sep 2026 10:31:46 +0000
Message-ID: <178851790608.4131868.10164736795399223191@kernel.org>
In-Reply-To: <20260901043027.2765502-1-rkannoth@marvell.com>
References: <20260901043027.2765502-1-rkannoth@marvell.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] uAPI field overload: the new GTP TEID handling in
  otx2_prepare_flow_request()…
- [Medium] Missing NPC_LE (LE LTYPE) gate for the new GTP TEID features.
- [Low] Wire-format assumption: NPC_SCAN_HDR(NPC_GTPC_TEID, NPC_LID_LE,
  NPC_LT_LE_GTPC, 4, 4) in npc_scan_ldata() (rvu_npc_fs.c:667)…

--

octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows

This adds NPC_GTPU_TEID and NPC_GTPC_TEID key fields and wires them through
the AF MCAM path, so ethtool ntuple rules on UDP port 2152/2123 can match
the GTP TEID taken from h_ext.data[1].  The new fields are also printed in
the debugfs MCAM dumps.

A few questions about the new key fields and the reuse of the ethtool
user-def field below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index d422bdd5e8f80..84be78ab73516 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c

[ ... ]

> @@ -661,6 +663,8 @@ do {									       \
>  	NPC_SCAN_HDR(NPC_VLAN_TAG1, NPC_LID_LB, NPC_LT_LB_CTAG, 2, 2);
>  	NPC_SCAN_HDR(NPC_VLAN_TAG2, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 2, 2);
>  	NPC_SCAN_HDR(NPC_VLAN_TAG3, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 6, 2);
> +	NPC_SCAN_HDR(NPC_GTPU_TEID, NPC_LID_LE, NPC_LT_LE_GTPU, 4, 4);
> +	NPC_SCAN_HDR(NPC_GTPC_TEID, NPC_LID_LE, NPC_LT_LE_GTPC, 4, 4);

[Severity: Low]
Is bytes 4..7 always the TEID for NPC_LT_LE_GTPC?

For GTPv2-C (3GPP TS 29.274), which is what runs on UDP/2123 in EPC/5GC,
the TEID field is only present when the T flag in octet 0 is set.  For T=0
messages (Echo Request/Response, Version Not Supported Indication) octets
4..6 hold the sequence number and octet 7 is spare.

The KPU labels the packet as GTP-C purely from the UDP destination port,
kpu8_action_entries() in npc_profile.h:

		NPC_S_KPU9_GTPC, 8, 1,
		NPC_LID_LD, NPC_LT_LD_UDP,

and the kpu9 GTPC CAM entry matches with all-zero data and mask, so the
kpu9 action emits NPC_LID_LE/NPC_LT_LE_GTPC without any version or T flag
check.

Can a rule asking for GTP-C TEID X therefore also match a T=0 GTPv2-C
control message whose sequence number bytes happen to equal the upper
three bytes of X, and conversely never match T=0 messages that the user
expected to be covered?

> @@ -720,7 +724,7 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
>  		*features |= BIT_ULL(NPC_IPPROTO_ICMP6);
>  	}
>  
> -	/* for ESP, check if corresponding layer type is present in the key */
> +	/* for ESP check if corresponding layer type is present in the key */
>  	if (npc_check_field(rvu, blkaddr, NPC_LE, intf))
>  		*features |= BIT_ULL(NPC_IPPROTO_ESP);

[Severity: Medium]
Should the two new TEID features get the same NPC_LE gate that ESP has
here?

NPC_GTPU_TEID and NPC_GTPC_TEID were added inside the [NPC_DMAC,
NPC_HEADER_FIELDS_MAX) range, so npc_set_features() advertises them from
the generic loop alone:

	for (hdr = NPC_DMAC; hdr < NPC_HEADER_FIELDS_MAX; hdr++) {
		if (npc_check_field(rvu, blkaddr, hdr, intf))
			*features |= BIT_ULL(hdr);
	}

That only requires the MKEX profile to extract the four TEID bytes of
layer LE, not that the LE LTYPE nibble is part of the search key.  The
ESP check right below exists precisely because an LE match is meaningless
without the LE LTYPE in the key.

Also, this comment change drops a comma that was there before, which
looks unintentional in a patch that is otherwise adding a feature.

[ ... ]

> @@ -1113,6 +1117,14 @@ void npc_update_flow(struct rvu *rvu, struct mcam_entry_mdata *mdata,
>  		npc_update_entry(rvu, NPC_LE, mdata, NPC_LT_LE_ESP,
>  				 0, ~0ULL, 0, intf);
>  
> +	if (features & BIT_ULL(NPC_GTPU_TEID))
> +		npc_update_entry(rvu, NPC_LE, mdata, NPC_LT_LE_GTPU,
> +				 0, ~0ULL, 0, intf);
> +
> +	if (features & BIT_ULL(NPC_GTPC_TEID))
> +		npc_update_entry(rvu, NPC_LE, mdata, NPC_LT_LE_GTPC,
> +				 0, ~0ULL, 0, intf);
> +

[Severity: Medium]
Continuing the question above: when the LE LTYPE is not in the generated
key, do these two calls silently do nothing?

npc_update_entry() bails out early in that case:

	if (!field->nr_kws)
		return;

So the LTYPE qualifier is dropped and only the TEID bytes end up in the
MCAM entry, with no warning and no error.

npc_check_overlap_fields() deliberately allows same-LID/different-LTYPE
fields to share key bits:

	/* Fields with same layer id and different ltypes are mutually
	 * exclusive hence they can be overlapped
	 */
	if (input1->layer_mdata.lid == input2->layer_mdata.lid &&
	    input1->layer_mdata.ltype != input2->layer_mdata.ltype)
		return false;

which means NPC_LT_LE_ESP, NPC_LT_LE_GTPU and NPC_LT_LE_GTPC can occupy
the same key bytes and the LTYPE is the only discriminator.

With such a profile, can a rule installed as "GTP-U TEID == X" also match
ESP packets whose SPI equals X, or GTP-C packets with TEID X?

[ ... ]

> @@ -1769,6 +1785,28 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
>  
>  	req->entry = npc_cn20k_vidx2idx(req->entry);
>  
> +	if ((req->features & BIT_ULL(NPC_GTPU_TEID)) &&
> +	    !npc_check_field(rvu, blkaddr, NPC_GTPU_TEID, req->intf)) {
> +		if (is_pffunc_af(req->hdr.pcifunc))
> +			dev_warn(rvu->dev,
> +				 "%s: mkex profile does not extract GTP-U TEID\n",
> +				 __func__);
> +		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
> +						    allocated, req->entry);
> +		return NPC_FLOW_NOT_SUPPORTED;
> +	}
> +
> +	if ((req->features & BIT_ULL(NPC_GTPC_TEID)) &&
> +	    !npc_check_field(rvu, blkaddr, NPC_GTPC_TEID, req->intf)) {
> +		if (is_pffunc_af(req->hdr.pcifunc))
> +			dev_warn(rvu->dev,
> +				 "%s: mkex profile does not extract GTP-C TEID\n",
> +				 __func__);
> +		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
> +						    allocated, req->entry);
> +		return NPC_FLOW_NOT_SUPPORTED;
> +	}
> +

[Severity: Medium]
This validation only checks that the TEID bytes are extracted.  Would it
be worth also rejecting the request when npc_check_field(rvu, blkaddr,
NPC_LE, req->intf) is false, so that an under-qualified rule (TEID bytes
without the LE LTYPE) is not accepted and programmed?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 99d78fc5a2c4a..73401e7ec68d6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> @@ -11,6 +11,8 @@
>  #include "otx2_common.h"
>  
>  #define OTX2_DEFAULT_ACTION	0x1
> +#define GTPU_PORT		2152
> +#define GTPC_PORT		2123

[ ... ]

> @@ -1076,7 +1079,30 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
>  			req->features |= BIT_ULL(NPC_OUTER_VID);
>  		}
>  
> +		/* GTP TEID uses FLOW_EXT data[1]; VLAN/MAC use other fields. */
>  		if (fsp->m_ext.data[1]) {
> +			switch (flow_type) {
> +			case UDP_V4_FLOW:
> +			case UDP_V6_FLOW:
> +				if (ntohs(pmask->dport) == 0xFFFF &&
> +				    ntohs(pkt->dport) == GTPU_PORT) {
> +					/* Check for GTP-U packets */
> +					skip_user_def = true;
> +					pkt->gtpu_teid = fsp->h_ext.data[1];
> +					pmask->gtpu_teid = fsp->m_ext.data[1];
> +					req->features |= BIT_ULL(NPC_GTPU_TEID);
> +				} else if (ntohs(pmask->dport) == 0xFFFF &&
> +					   ntohs(pkt->dport) == GTPC_PORT) {
> +					/* Check for GTP-C packets */
> +					skip_user_def = true;
> +					pkt->gtpc_teid = fsp->h_ext.data[1];
> +					pmask->gtpc_teid = fsp->m_ext.data[1];
> +					req->features |= BIT_ULL(NPC_GTPC_TEID);
> +				}
> +			}
> +		}
> +
> +		if (fsp->m_ext.data[1] && !skip_user_def) {
>  			if (flow_type == IP_USER_FLOW) {
>  				if (be32_to_cpu(fsp->h_ext.data[1]) != IPV4_FLAG_MORE)
>  					return -EINVAL;

[Severity: Medium]
Does this change the meaning of rules that already work today?

h_ext.data[1] already has an interpretation in this same function, in the
block that is now guarded by !skip_user_def:

			} else if (fsp->h_ext.data[1] ==
					cpu_to_be32(OTX2_DEFAULT_ACTION)) {
				/* Not Drop/Direct to queue but use action
				 * in default entry
				 */
				req->op = NIX_RX_ACTION_DEFAULT;
			}

otx2_prepare_ipv4_flow()/otx2_prepare_ipv6_flow() copy pdst and its mask
verbatim into pkt->dport/pmask->dport, so for

	ethtool -N ethX flow-type udp4 dst-port 2152 user-def 0x1 action N

the new block sets skip_user_def and the OTX2_DEFAULT_ACTION branch is no
longer reached.  The rule installs a GTP-U TEID == 1 match with the
ring_cookie-derived action instead of deferring to the default entry
action, and no error is returned.

Conversely, is the default-action encoding now inexpressible for UDP
ports 2152 and 2123, and is a TEID value of 0x1 indistinguishable from
the legacy encoding?

The commit message says only:

    take the TEID value and mask from h_ext.data[1] and install the
    corresponding LE layer match in NPC.

Could it mention that data[1] already carries the default-action encoding,
and how the two are meant to be told apart?

Also, skip_user_def is declared as int but assigned true/false; bool looks
like the intended type here.  The switch has only UDP_V4_FLOW/UDP_V6_FLOW
cases with no break statement before the closing brace, which builds fine
but reads oddly for a switch that gates two cases.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901043027.2765502-1-rkannoth%40marvell.com
