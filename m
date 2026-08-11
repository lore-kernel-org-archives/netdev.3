Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BB29D268
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408519; cv=none; b=Yn8XfxNSkQpd4zhZqKoeKK5rctBpvBn3UHVCYD+gNjeo4gLZdxkInfoVUaZGTiPGpqQjKu/FyJUgtN9OrSen4ClwcIvNaLedAacTPZ5HKgz3tahPeRO8iEagL/AwQCmhMHACmonBlKVCZw9M+47H+K7H6KwDs6FH3aA7MQiah0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408519; c=relaxed/simple;
	bh=dI+KEUKwEhccpMJ9ON9qZdhi8i4VNLf6wpaRHMuzPcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJOpbT5Ss72HA+wEHN7Z6pISJs5/ZUFuzR34smd9q1boKOyRHK1/bOh1/BxkgjcnYNxigmtYiFaW4Lmg79Gp3CFbNlCpxtB+MElSZOhK+hBuUw4IREuO/QlF5Aiwgw3v5MslDKK3GG++ddKg/ri7XOyVnDdm+b1O03ytCC/EbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXxQ043d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXxQ043d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DFE1F000E9;
	Tue, 11 Aug 2026 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408517;
	bh=Fo1FfNdoicSi88M8Je7ds61pKB3ElyodYdRdrHSyQ4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CXxQ043d+dqYOBD73QiqBPUNfUGJdb0OX9EUCWjJ7RFo1RF2rYOf6PqAU1CA1GovY
	 bxVRrbYh/clVMnZ23ATrP81RVPqAtYLgSMRMjDWs4zIIlpZ1eErJuEbYxCqrCkNSQU
	 4QT3HIbP6/QpnFqQF6DJhZIxtNJygsoknThuLC1+5pA5XxxUaS8JwWORcDVi5GJPg1
	 RhPVsgTPs0tntKDWv+14tMgwA9E/0w/gDQ8kTLn3We3AcTKMB/fuLCvC5UeA01cVdL
	 5md+dxqAclxkJw52B2fyKxhbqGHgfUwNNyN6P9+GafUcs2rYXVWXMhqrANHkeMCoDZ
	 2v77EC9HDIy7g==
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
Subject: Re: [PATCH net-next 04/15] virtchnl: add VIRTCHNL_VLAN_ETHERTYPE_88E7 support
Date: Mon, 10 Aug 2026 17:35:16 -0700
Message-ID: <20260811003516.1056797-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805213541.2281287-5-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-5-anthony.l.nguyen@intel.com>
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
virtchnl: add VIRTCHNL_VLAN_ETHERTYPE_88E7 support

This adds VIRTCHNL_VLAN_ETHERTYPE_88E7 = BIT(3) to enum
virtchnl_vlan_support so that the 0x88E7 VLAN ethertype can be negotiated
over VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS.  The change touches only the
shared virtchnl header.

> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
> index 11bdab5522fd5..511c8827c640f 100644
> --- a/include/linux/avf/virtchnl.h
> +++ b/include/linux/avf/virtchnl.h
> @@ -636,6 +636,7 @@ enum virtchnl_vlan_support {
>  	VIRTCHNL_VLAN_ETHERTYPE_8100 =		BIT(0),
>  	VIRTCHNL_VLAN_ETHERTYPE_88A8 =		BIT(1),
>  	VIRTCHNL_VLAN_ETHERTYPE_9100 =		BIT(2),
> +	VIRTCHNL_VLAN_ETHERTYPE_88E7 =		BIT(3),

[Severity: Medium]
Is there anything in the tree that can actually negotiate this bit?

The commit message says the bit is added "so that VF drivers can advertise
and negotiate 0x88E7 VLAN ethertype support through the existing
VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS handshake", but on the PF side
ice_vc_set_dvm_caps() and ice_vc_set_svm_caps() in
drivers/net/ethernet/intel/ice/virt/virtchnl.c only ever fill in:

	supported_caps->outer = VIRTCHNL_VLAN_ETHERTYPE_8100 |
				VIRTCHNL_VLAN_ETHERTYPE_88A8 |
				VIRTCHNL_VLAN_ETHERTYPE_9100 |
				VIRTCHNL_VLAN_ETHERTYPE_AND;
	caps->filtering.ethertype_init = VIRTCHNL_VLAN_ETHERTYPE_8100 |
					 VIRTCHNL_VLAN_ETHERTYPE_88A8 |
					 VIRTCHNL_VLAN_ETHERTYPE_9100;

so BIT(3) never appears in the caps message stored in vf->vlan_v2_caps.

On the VF side, iavf_tpid_to_vc_ethertype() in
drivers/net/ethernet/intel/iavf/iavf_virtchnl.c maps only ETH_P_8021Q and
ETH_P_8021AD, and iavf_get_netdev_vlan_hw_features() /
iavf_get_netdev_vlan_features() in iavf_main.c test only the _8100 and
_88A8 bits, so a PF that did advertise BIT(3) would be silently ignored.

As a consequence, the ETH_P_8021AH / VIRTCHNL_VLAN_ETHERTYPE_88E7 cases
added by the follow-up patch in this series ("ice: add 0x88E7 handling to
SW validation paths") look unreachable.  ice_vc_validate_vlan_tpid() ends
with:

	if (!(filtering_caps & vlan_ethertype))
		return false;

and filtering_caps never contains BIT(3), so 0x88E7 filters are still
rejected.  Likewise ice_vc_get_tpid() is only reached after
ice_vc_valid_vlan_setting() has already done:

	if (ethertype_setting && !(negotiated_settings & ethertype_setting))
		return false;

Should the advertisement side land in the same series, or is the intent
that only an out-of-tree/firmware PF sets this bit?  If the latter, would
it be worth dropping the claim in the follow-up commit that "the PF
correctly accepts and translates 0x88E7 (ETH_P_8021AH) VLAN filters
requested by VFs", since that is not the case at the end of the series?

[Severity: Medium]
Is the terminology in the commit message right?  It says:

	IEEE 802.1ah (Provider Backbone Bridging) uses ethertype 0x88E7 as the
	Backbone Service Tag (B-TAG).

802.1ah uses 0x88A8 for the Backbone VLAN Tag (B-TAG), which is already
covered by VIRTCHNL_VLAN_ETHERTYPE_88A8, and 0x88E7 for the Backbone
Service Instance Tag (I-TAG).  The ice parser documentation in
drivers/net/ethernet/intel/ice/ice_protocol_type.h agrees:

 * K = STAG or BVLAN - Outer L2 header has STAG (ethernet type 0x88a8) or
 *		       BVLAN (ethernet type 0x88a8).
 * L = ITAG - Outer L2 header has ITAG *ethernet type 0x88e7)

Related to that, how is a 0x88E7 tag meant to be expressed through this
ABI?  struct virtchnl_vlan in this same header carries only:

	u16 tci;	/* tci[15:13] = PCP and tci[11:0] = VID */
	u16 tci_mask;
	u16 tpid;	/* 0x8100, 0x88a8, etc. ... */

which has no room for an 802.1ah 24-bit I-SID.

And on the hardware side, ICE_AQ_VSI_OUTER_TAG_TYPE_M in
drivers/net/ethernet/intel/ice/ice_adminq_cmd.h is a two-bit field with
only NONE/STAG/VLAN_8100/VLAN_9100 encodings, and
tpid_to_vsi_outer_vlan_type() in ice_vsi_vlan_lib.c ends with:

	default:
		*tag_type = 0;
		return -EINVAL;

So a peer that did negotiate BIT(3) and then sent
VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2 would reach
ice_vc_ena_vlan_offload() -> ice_vsi_ena_outer_stripping(vsi,
ETH_P_8021AH) and get -EINVAL, while its own feature flags claim support.
Could the commit message state which 802.1ah tag is meant and how it maps
onto struct virtchnl_vlan and the hardware outer tag types?

[Severity: Low]
Should the documentation block above this enum gain a matching line?  It
currently describes each ethertype bit:

 * VIRTCHNL_VLAN_ETHERTYPE_8100 - This field supports 0x8100 ethertype.
 * VIRTCHNL_VLAN_ETHERTYPE_88A8 - This field supports 0x88A8 ethertype.
 * VIRTCHNL_VLAN_ETHERTYPE_9100 - This field supports 0x9100 ethertype.

but there is no entry for the new bit, and the AND/XOR wording in the same
block is written in terms of the enumerated ethertypes.  Since 0x88E7 is
described as ETH_P_8021AH "802.1ah Backbone Service Tag" in
include/uapi/linux/if_ether.h but as ITAG in ice_protocol_type.h, a
third-party implementer reading this header cannot tell whether the bit
means B-TAG or I-TAG handling.  Adding the documentation line, and
referencing ETH_P_8021AH, would pin that down.

>  	VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1 =	BIT(8),
>  	VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2 =	BIT(9),
>  	VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2_2 =	BIT(10),
