Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26AE2D739C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408520; cv=none; b=ugCekfAxgDG9ua20WJhlbJCEhmMzpD0YUwiE8zJ+lI+0rViAGcPsbwEFm1td71BievpmWxmVBYdjb1soLch4MpuHra3UogdwcwYPMLkGWKHk7kSTblKekmPR782S9tRDYK5djb+0WeHvR/AxSHqzpKlyP7yHsF8ZLaR+W6rdMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408520; c=relaxed/simple;
	bh=qw+BIWdNfc74nj7iz5iFcT8/ZXuAKhB8BstMv6RQsTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdQr4VFAMbPyNxMKqKfuinAmVsFDjnbPPcAQ1EJOjhphxrMDmm0Bqk1GZy5TGQ5KYi1uoidVaeokjyKtWt1Xh+XCKE3Eu5VA0Od83xoIHyn+7EE1WJ2ayEdGDAI2/rR+h7IrZWPPqcjWnj0vHJ5/F391+/RjKprayPCap4G0C9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce2z0yYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce2z0yYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9381F00A3D;
	Tue, 11 Aug 2026 00:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408518;
	bh=E/jL/5+O324lKPvlHGL3mkrOwjfaELQSxCV1ZTlX6Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ce2z0yYURtARkcnQpFFGRmtGszTGP5ptE7pnUAadZfx3QabU5nP6ruy8gNqEdXnqK
	 W1hArHwDFXK4Dsdk34CXKQjKGoPAD5PgKlp5XTb3IDwlGPn9CABZI3EFrdHRWxPiYL
	 qDGLKxj0hURMY/iLrfxN1Oiq0S5PI5TGOl/UerDrgee6BhWt5kJAKpdJmgW4uf2NGC
	 kAiRR/K6aUpodkUHyzdVMwyvjA1Tc/lVbM1htAK8E+tt1GMSPm4v4uwUBPLn8Mb62A
	 Hm/3/dGuJaws2MJfcA2frE7IZRNyVblzMm0XWa8w2pUUqrfkn8z2tCrRDeq5x9jGno
	 mFY0q4qVjRpWQ==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	tactii@gmail.com,
	dima.ruinskiy@intel.com,
	aleksandr.loktionov@intel.com,
	pmenzel@molgen.mpg.de,
	michalx.cohen@intel.com
Subject: Re: [PATCH net-next 05/15] ice: add 0x88E7 handling to SW validation paths
Date: Mon, 10 Aug 2026 17:35:17 -0700
Message-ID: <20260811003517.1056848-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805213541.2281287-6-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ice: add 0x88E7 handling to SW validation paths

This adds ETH_P_8021AH (0x88E7) to three software validation paths in ice:
the TC flower TPID check, the per-VSI VLAN filter TPID check, and the
virtchnl VLAN v2 TPID translation helpers.  A few questions below about
the effect of these hunks and about the commit message.

> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index d20357c041273..4560e55c8f9c9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -174,6 +174,7 @@ static u16 ice_check_supported_vlan_tpid(u16 vlan_tpid)
>  	case ETH_P_8021Q:
>  	case ETH_P_8021AD:
>  	case ETH_P_QINQ1:
> +	case ETH_P_8021AH:
>  		return vlan_tpid;
>  	default:
>  		return 0;

[Severity: Medium]
The commit message says this hunk exists "so 0x88E7-tagged flower filters
are not rejected early".  Where was the early rejection?  The only caller
of ice_check_supported_vlan_tpid() is ice_tc_fill_rules():

	rule_info->vlan_type = ice_check_supported_vlan_tpid(vlan_tpid);

There is no check for a 0 return and no -EINVAL or extack emitted, so an
unsupported TPID previously just resulted in vlan_type == 0.

The same paragraph says "no hardware offload path affected" and "does not
alter any datapath", but rule_info->vlan_type reaches hardware rule
programming through ice_add_adv_rule() -> ice_fill_adv_packet_vlan(),
which stamps it into the dummy packet used to program the recipe:

	hdr = (struct ice_vlan_hdr *)&pkt[offset];
	hdr->type = cpu_to_be16(vlan_type);

and it also participates in rule identity in ice_rules_equal().

For a flower rule created with num_of_vlans >= 1 and protocol 0x88E7,
cls_flower's is_vlan_key()/fl_set_key_vlan() copy any ethertype into
key->vlan.vlan_tpid with a full mask, ice_parse_cls_flower() copies it to
headers->vlan_hdr.vlan_tpid, and the programmed rule now carries TPID
0x88E7 where it previously carried the dummy packet default.  Is that
silent change of which frames the offloaded rule matches intended, and
should the commit message describe it rather than state the opposite?

> diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
> index 54984966851d5..b67272e2f603c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
> @@ -24,7 +24,8 @@ static void print_invalid_tpid(struct ice_vsi *vsi, u16 tpid)
>  static bool validate_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan)
>  {
>  	if (vlan->tpid != ETH_P_8021Q && vlan->tpid != ETH_P_8021AD &&
> -	    vlan->tpid != ETH_P_QINQ1 && (vlan->tpid || vlan->vid)) {
> +	    vlan->tpid != ETH_P_QINQ1 && vlan->tpid != ETH_P_8021AH &&
> +	    (vlan->tpid || vlan->vid)) {
>  		print_invalid_tpid(vsi, vlan->tpid);
>  		return false;
>  	}

[Severity: Medium]
The commit message introduces 0x88E7 as "IEEE 802.1ah B-TAG support".  Is
that the right mapping?  ice's own in-tree documentation in
ice_protocol_type.h says otherwise:

 * K = STAG or BVLAN - Outer L2 header has STAG (ethernet type 0x88a8) or
 *		       BVLAN (ethernet type 0x88a8).
 * L = ITAG - Outer L2 header has ITAG *ethernet type 0x88e7)

So the 802.1ah B-TAG is 0x88a8, which the existing ETH_P_8021AD case
already covers, and 0x88E7 is the I-TAG.

That distinction matters for the filter layout.  The I-TAG is a 4-byte
I-TCI (I-PCP/DEI/UCA/reserved plus a 24-bit I-SID) followed by 12 bytes of
encapsulated C-DA/C-SA, but ice_fill_sw_rule() programs the requested vid
at the 802.1Q TCI offset next to the TPID:

	if (!(vlan_id > ICE_MAX_VLAN_ID)) {
		off = (__force __be16 *)(eth_hdr + ICE_ETH_VLAN_TCI_OFFSET);
		*off = cpu_to_be16(vlan_id);
		off = (__force __be16 *)(eth_hdr + ICE_ETH_ETHTYPE_OFFSET);
		*off = cpu_to_be16(vlan_tpid);
	}

For a real 0x88E7 frame those 16 bits are I-PCP/DEI/UCA/reserved plus the
top byte of the I-SID, not a VID.  Can a "vid N, tpid 0x88E7" filter key on
anything meaningful here?

There is also an internal inconsistency: validate_vlan() now accepts
ETH_P_8021AH while tpid_to_vsi_outer_vlan_type() in the same file still
returns -EINVAL for it:

	switch (tpid) {
	case ETH_P_8021Q:
	...
	case ETH_P_QINQ1:
		*tag_type = ICE_AQ_VSI_OUTER_TAG_VLAN_9100;
		break;
	default:
		return -EINVAL;

Should a TPID that can be recorded as a filter also be programmable as an
outer tag type, or is accepting it in validate_vlan() premature?

> diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
> index ca8018e3dd428..06d2f9be93ae4 100644
> --- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
> +++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
> @@ -1702,6 +1702,9 @@ static bool ice_vc_validate_vlan_tpid(u16 filtering_caps, u16 tpid)
>  	case ETH_P_QINQ1:
>  		vlan_ethertype = VIRTCHNL_VLAN_ETHERTYPE_9100;
>  		break;
> +	case ETH_P_8021AH:
> +		vlan_ethertype = VIRTCHNL_VLAN_ETHERTYPE_88E7;
> +		break;
>  	}
>  
>  	if (!(filtering_caps & vlan_ethertype))

[Severity: Medium]
Can this new case ever change the result?  filtering_caps comes from
vf->vlan_v2_caps.filtering.filtering_support, and the only producers are
ice_vc_set_dvm_caps():

	supported_caps->outer = VIRTCHNL_VLAN_ETHERTYPE_8100 |
				VIRTCHNL_VLAN_ETHERTYPE_88A8 |
				VIRTCHNL_VLAN_ETHERTYPE_9100 |
				VIRTCHNL_VLAN_ETHERTYPE_AND;
	caps->filtering.ethertype_init = VIRTCHNL_VLAN_ETHERTYPE_8100 |
					 VIRTCHNL_VLAN_ETHERTYPE_88A8 |
					 VIRTCHNL_VLAN_ETHERTYPE_9100;

and ice_vc_set_svm_caps():

	supported_caps->inner = VIRTCHNL_VLAN_ETHERTYPE_8100;
	supported_caps->outer = VIRTCHNL_VLAN_UNSUPPORTED;
	caps->filtering.ethertype_init = VIRTCHNL_VLAN_ETHERTYPE_8100;

Neither sets VIRTCHNL_VLAN_ETHERTYPE_88E7, so a VF sending
VIRTCHNL_OP_ADD_VLAN_V2 with tpid 0x88E7 still fails the
!(filtering_caps & vlan_ethertype) test and
ice_vc_add_vlan_v2_msg()/ice_vc_remove_vlan_v2_msg() keep returning
VIRTCHNL_STATUS_ERR_PARAM, exactly as before the patch.  Grepping the tree
at this commit shows VIRTCHNL_VLAN_ETHERTYPE_88E7 appearing in ice only at
these two new sites, with no producer of the capability bit added
elsewhere in the series.

Given that, does the commit message claim that "the PF correctly accepts
and translates 0x88E7 (ETH_P_8021AH) VLAN filters requested by VFs" hold?
The validate_vlan() relaxation in ice_vsi_vlan_lib.c is likewise
unreachable from the VF path while this gate stays closed.  Should the
capability advertisement come in the same patch, or the message be reworded
to say the translation is added ahead of the capability?

> @@ -2136,6 +2139,9 @@ static int ice_vc_get_tpid(u32 ethertype_setting, u16 *tpid)
>  	case VIRTCHNL_VLAN_ETHERTYPE_9100:
>  		*tpid = ETH_P_QINQ1;
>  		break;
> +	case VIRTCHNL_VLAN_ETHERTYPE_88E7:
> +		*tpid = ETH_P_8021AH;
> +		break;
>  	default:
>  		*tpid = 0;
>  		return -EINVAL;

[Severity: Low]
This makes ice the first in-tree interpreter of VIRTCHNL_VLAN_ETHERTYPE_88E7,
but that bit is still undocumented in include/linux/avf/virtchnl.h.  The
comment block above enum virtchnl_vlan_support lists only:

 * VIRTCHNL_VLAN_ETHERTYPE_8100 - This field supports 0x8100 ethertype.
 * VIRTCHNL_VLAN_ETHERTYPE_88A8 - This field supports 0x88A8 ethertype.
 * VIRTCHNL_VLAN_ETHERTYPE_9100 - This field supports 0x9100 ethertype.

while the enum itself now has:

	VIRTCHNL_VLAN_ETHERTYPE_88E7 =		BIT(3),

The AND/XOR usage examples in the same block also do not mention 88E7.
Could the documentation be extended to say which fields may carry the bit
and how it combines with VIRTCHNL_VLAN_ETHERTYPE_AND/XOR?

Also worth noting: this arm is reached only via
ice_vc_valid_vlan_setting_msg(), which checks stripping_support and
insertion_support, neither of which contains the 88E7 bit, and the returned
tpid would then be rejected by tpid_to_vsi_outer_vlan_type().
