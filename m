Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B7145B27
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408517; cv=none; b=u0BlgS9qRBDcjVjwWVE0cSatmLlu2N/Em0t8XVnJBDAKSENhMMu0/6khegSW/vdpq+lYRqUL2Ab+wmnGRIbhK5TE7U47x60GYZbawGA17b4c9O0CSWMa0oKf0KhXm3rilbFm6B7GUX1TPDFOJSNZzfnzJgswSK9D7m0RWPu2IuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408517; c=relaxed/simple;
	bh=C9m81ltvn7TB1snvEUa2I8XL3Fbyy/nYQmB0fi8t7Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GViszH4rjD05h6bewWo0+FuJA2IWcuOTDRN3xiAc9i2cXJQEQ1NdX+iDanH3P3xlFRiO3yhXctctQ9cjgtD6Bk40wz8VDU5nxhcwwakmAvTg4fGZDrvcstwcDS50WC32h8Z0oPY0/7WemwTBwoFlj8SXy79cZM7uk6r0w+geKQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5MCBltY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5MCBltY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C591F00A3A;
	Tue, 11 Aug 2026 00:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408515;
	bh=IneJH6nHwgIclIAVGilBQM6iKUEKCvpT3UfLJg2Hb5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5MCBltY4zlFgqkY6vxxbzi40kqYZ0kczgRVlVIZEmb+N4YnxkM2+XCT3wgmuZyDq
	 zeUkutc+8Iqnoc0IP5tDcoPUWMjzTO0bDDNkEAX/l739iMwRZ7kkIcBGyK72r+gYNg
	 9TjZJq5EHUtLwm+6RN2AZklWkQCaJoSn2cNTDUetNO04rZbQRhy6mYpB2hCip5bl25
	 JaVtFuDXPSiPpBMOck6aLIfdoBpoPcmhD7ggvcT0xSjRAEzif/1swVAVJfIn5ePPor
	 uh0n6ZiMtgb3pTrvZHog35/UpOP2ThcQxkEWiTgA5VkhOjWJwtekr4RrLdaQak6o+0
	 qaLHE+Vvx7/ww==
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
Subject: Re: [PATCH net-next 02/15] ice: always do GCS if hardware supports it
Date: Mon, 10 Aug 2026 17:35:14 -0700
Message-ID: <20260811003514.1056660-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805213541.2281287-3-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-3-anthony.l.nguyen@intel.com>
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
ice: always do GCS if hardware supports it

This replaces the NETIF_F_HW_CSUM test in ice_tx_csum() with a new
per-Tx-ring flag, ICE_TX_RING_FLAGS_GCS, which is set in
ice_vsi_alloc_rings() whenever ICE_F_GCS is supported.  The E830 generic
checksum (GCS) context descriptor is therefore emitted based on hardware
capability instead of the netdev feature bit.  There are no Link: tags in
the commit header.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 8cdc4fda89e97..fc9d4e0fa7558 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1415,6 +1415,10 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
>  			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG2, ring->flags);
>  		else
>  			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG1, ring->flags);
> +
> +		if (ice_is_feature_supported(pf, ICE_F_GCS))
> +			set_bit(ICE_TX_RING_FLAGS_GCS, ring->flags);
> +
>  		WRITE_ONCE(vsi->tx_rings[i], ring);
>  	}

[Severity: Medium]

The changelog says "There is no need to check for NETIF_HW_CSUM."  Was
that check really redundant?  In ice_set_netdev_features() the bit is
added to hw_features only, and that happens after netdev->features has
already been assigned:

	netdev->features |= netdev->hw_features;
	...
	/* Mutual exclusivity for TSO and GCS is enforced by the set features
	 * ndo callback.
	 */
	if (ice_is_feature_supported(pf, ICE_F_GCS))
		netdev->hw_features |= NETIF_F_HW_CSUM;

So NETIF_F_HW_CSUM was advertised as changeable but was off by default,
which makes the removed test the actual on/off switch for the GCS branch
rather than a redundant condition.

Since ICE_TX_RING_FLAGS_GCS is set here for every Tx ring whenever
ICE_F_GCS is supported (set for every ICE_MAC_E830 PF in
ice_init_feature_support(), and never cleared, and never resynchronized
from ndo_set_features), do GCS context descriptors now get emitted while
TSO is simultaneously enabled on the same netdev?  That is the
combination ice_set_features() still refuses at this commit:

	/* Due to E830 hardware limitations, TSO (NETIF_F_ALL_TSO) with GCS
	 * (NETIF_F_HW_CSUM) is not supported.
	 */
	if (ice_is_feature_supported(pf, ICE_F_GCS) &&
	    ((features & NETIF_F_HW_CSUM) && (features & NETIF_F_ALL_TSO))) {
		...
		return -EIO;

commit 905d1a220e8d ("ice: Add E830 checksum offload support") states the
limitation at feature granularity: inner packet header modification is
not supported and MSS is limited to 1023 bytes when both GCS and TSO are
enabled.

If that limitation is device or configuration level, does a default E830
port (MTU 1500, TSO on) now run in the unsupported mode after this patch?
If it is per-packet only, then the -EIO check and the comment claiming the
ndo callback enforces exclusivity are stale, and could be retired in this
same change with that reasoning recorded.

For completeness: the follow-up patch "ice: use NETIF_F_HW_CSUM instead of
IP/IPV6" removes the -EIO check and the stale comment and moves
NETIF_F_HW_CSUM into csumo_features, but GCS being active with TSO enabled
persists to the end of the series.

Two effects not mentioned in the changelog: every checksummed packet now
also consumes a Tx context descriptor, and at this commit
tx-checksum-ip-generic no longer controls GCS at all, since clearing it
leaves NETIF_F_IP_CSUM/NETIF_F_IPV6_CSUM set and CHECKSUM_PARTIAL skbs
still take the GCS branch.  Could the changelog mention both?

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 31303ab5be175..477c86d8c53bc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1739,7 +1739,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
>  	l3_len = l4.hdr - ip.hdr;
>  	offset |= (l3_len / 4) << ICE_TX_DESC_LEN_IPLEN_S;
>  
> -	if ((tx_ring->netdev->features & NETIF_F_HW_CSUM) &&
> +	if (test_bit(ICE_TX_RING_FLAGS_GCS, tx_ring->flags) &&
>  	    !(first->tx_flags & ICE_TX_FLAGS_TSO) &&
>  	    !skb_csum_is_sctp(skb)) {
>  		/* Set GCS */

[Severity: High]

This is a pre-existing issue and was not introduced by this patch, but
making the GCS branch the default widens the exposure of a missing bounds
check in the block right below this hunk in ice_tx_csum():

	u16 csum_start = (skb->csum_start - skb->mac_header) / 2;
	u16 csum_offset = skb->csum_offset / 2;
	u16 gcs_params;

	gcs_params = FIELD_PREP(ICE_TX_GCS_DESC_START_M, csum_start) |
		     FIELD_PREP(ICE_TX_GCS_DESC_OFFSET_M, csum_offset) |
		     FIELD_PREP(ICE_TX_GCS_DESC_TYPE_M,
				ICE_TX_GCS_DESC_CSUM_PSH);

In ice_lan_tx_rx.h these fields are narrow:

	#define ICE_TX_GCS_DESC_START_M		GENMASK(7, 0)
	#define ICE_TX_GCS_DESC_OFFSET_M	GENMASK(11, 8)

Both are in 2-byte units, so only csum_start up to 510 bytes past the MAC
header and csum_offset up to 30 can be expressed.  FIELD_PREP rejects only
out-of-range compile-time constants, so larger runtime values are silently
masked and the descriptor is still committed:

		off->cd_qw1 |= ICE_TX_DESC_DTYPE_CTX;
		off->cd_gcs_params = gcs_params;
		off->td_offset |= offset;
		off->td_cmd |= cmd;
		return 1;

There is no range check, no fall back to the legacy L4T checksum path and
no skb_checksum_help() call.  Can the device then compute the sum over the
wrong span and write the two result bytes over payload, leaving the real
checksum field holding the pseudo-header partial sum?

Are these offsets trustworthy at this point?  skb_partial_csum_set()
bounds them only by skb_headlen():

net/core/skbuff.c:skb_partial_csum_set() {
	...
	if (unlikely(csum_start >= U16_MAX || csum_end > skb_headlen(skb))) {
	...
}

so a tun/tap guest using virtio_net_hdr, or an AF_PACKET sender with
CAP_NET_RAW, can pick csum_start beyond 510 or csum_offset beyond 30, and
skb_csum_hwoffload_help() returns 0 without fixing anything up once
NETIF_F_HW_CSUM is advertised.  Long IPv6 extension header chains and
MPLS/tunnel stacks can also push csum_start past 510.

Would it make sense to validate csum_start and csum_offset against the
descriptor field widths here and fall through to the legacy checksum path
when they do not fit?

[ ... ]
