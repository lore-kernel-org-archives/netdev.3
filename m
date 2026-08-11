Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB412BEC34
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408518; cv=none; b=NNXEkzhOky4yZYtOyPtYlzG5ehvbyLzc1X+zk1CyrO3DTlr9RiawvFIIrcAMct906KPLeYuOf+sHRGQ5qupNPQemRO2Hgi7YNodifdTLeyaHVRn01xjna18HaQjjImlNguOJRM7Syaw+8TExv6HHNcYeFj2Rdz0aOyrq5Rj/hkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408518; c=relaxed/simple;
	bh=xg5u7z1xRNMPUPPdOLl0mjyGSxPImJI86AOXyMmhiI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1oOGZM8v8v+A3450z/T3Dv5mstu9PIT0Cdbu4MFo5GaSyiOmcm6T7YeS27MIKVWnYPWBgMyHndodsiOKQUgCtnItBS0PGgSIHZ4SCMKHdh7OUtu2pW0IWPQbj5w5bzDXhxCY4Ek+fj/Zm0z29PHvwnNnrAY44uYCCeNCIVHjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1hJNRHH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1hJNRHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C99E1F00A3D;
	Tue, 11 Aug 2026 00:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408516;
	bh=EREOEf9BZ2TSA2rw772gaTSZFhqUihaQqgydf1lJSx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m1hJNRHHu9KXk7EP82WX7KD7t1HkA/5gDUoiSCSYlQzlSjewnao5RR2bVIP5bjPig
	 QOnHBqijGGTkVbLgkG5HKwRm3IKzex2eNRZKwgo1fTalmLiCXRvKENF6N4+bbyfPCm
	 Fs5cjYmZOxpfOJkZGf7+s1egk1qAedposBexvqcx2QUXaw+tmriLjngctnGJgAvEtD
	 v1pyTaBUpYEHu06s5+B72N2KVjDq8+hCROUCnkRdFNM4T8GHsJz/2bJxEcn3zoMQeV
	 uTqm9NyEQVF0LYMjS+VSRVK2ga3V2Ssj9SlLLcG7yH9dsYUO48I5dVBiUg/zdVRRAi
	 JmT/WM6giaLug==
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
Subject: Re: [PATCH net-next 03/15] ice: use NETIF_F_HW_CSUM instead of IP/IPV6
Date: Mon, 10 Aug 2026 17:35:15 -0700
Message-ID: <20260811003515.1056735-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805213541.2281287-4-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-4-anthony.l.nguyen@intel.com>
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
ice: use NETIF_F_HW_CSUM instead of IP/IPV6

This switches the ice netdev checksum offload advertisement from
NETIF_F_IP_CSUM/NETIF_F_IPV6_CSUM to NETIF_F_HW_CSUM, so IPv6 packets
carrying extension headers are no longer pushed down the software checksum
path.  It also removes the conditional NETIF_F_HW_CSUM advertisement for
GCS-capable parts and the TSO/GCS mutual exclusion check in
ice_set_features().

A few questions below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index cc30d8c73a41c..a5e9c3114706f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3491,9 +3491,8 @@ void ice_set_netdev_features(struct net_device *netdev)
>  			NETIF_F_RXHASH;
>  
>  	csumo_features = NETIF_F_RXCSUM	  |
> -			 NETIF_F_IP_CSUM  |
>  			 NETIF_F_SCTP_CRC |
> -			 NETIF_F_IPV6_CSUM;
> +			 NETIF_F_HW_CSUM;

[Severity: Medium]
Should this hunk carry a Fixes: tag and be split out from the GCS/TSO
cleanup?

As far as I can tell this is not just an offload-advertisement cleanup, it
fixes a user-visible drop.  With only NETIF_F_IP_CSUM/NETIF_F_IPV6_CSUM set,
skb_csum_hwoffload_help() in net/core/dev.c forces the software path:

	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
			goto sw_checksum;

and skb_checksum_help() refuses GSO skbs:

	if (unlikely(skb_is_gso(skb))) {
		skb_warn_bad_offload(skb);
		return -EINVAL;
	}

Since ice advertises NETIF_F_TSO6, netif_needs_gso() is false and the skb
arrives still marked GSO, so validate_xmit_skb() takes the
out_kfree_skb path and the frame is dropped rather than de-offloaded.

That means TSO'd IPv6 traffic with an extension header (SRv6, HOPOPTS,
DSTOPTS) is dropped on every ice device on stable kernels containing the
skb_csum_hwoffload_help() change (04c20a9356f2, v6.13+).  The changelog only
hints at this with "To not drop such packets", and there is no Fixes: tag,
so it is hard to identify for backport.  Would it make sense to make this
one-liner a standalone patch with a Fixes: tag, and keep the GCS/TSO
mutual-exclusion removal (which depends on the earlier "ice: always do GCS
if hardware supports it" patch in this series) separate?

[Severity: Medium]
On non-GCS parts, is NETIF_F_HW_CSUM an accurate description of what the
legacy path in ice_tx_csum() (drivers/net/ethernet/intel/ice/ice_txrx.c)
implements?

NETIF_F_HW_CSUM promises the driver honours skb->csum_start /
skb->csum_offset for any protocol, and once it is set
skb_csum_hwoffload_help() returns 0 unconditionally, so the core no longer
checks that skb->csum_offset is offsetof(struct tcphdr, check) or
offsetof(struct udphdr, check).

The legacy branch of ice_tx_csum() derives the insertion point purely from
its own header parse and never looks at skb->csum_offset:

	switch (l4_proto) {
	case IPPROTO_TCP:
		cmd |= ICE_TX_DESC_CMD_L4T_EOFT_TCP;
		l4_len = l4.tcp->doff;
		offset |= l4_len << ICE_TX_DESC_LEN_L4_LEN_S;
		break;
	...
	default:
		goto checksum_sw_fb;
	}

So for a CHECKSUM_PARTIAL frame that parses as IPv4/IPv6 + TCP/UDP but asks
for a different csum_offset (virtio_net_hdr/tap or AF_PACKET with a vnet
header; skb_partial_csum_set() only checks that start/off lie inside the
linear area), hardware writes the checksum at the standard L4 offset while
the field the stack asked to be filled keeps the pseudo-header seed.  The
checksum_sw_fb fallback does not catch this, since it is only reached when
the network header is neither IPv4 nor IPv6 or when l4_proto hits the switch
default.

i40e has the same loose interpretation (it never references
skb->csum_offset either), so this may well be intended precedent - is that
the reasoning here?

>  
>  	vlano_features = NETIF_F_HW_VLAN_CTAG_FILTER |
>  			 NETIF_F_HW_VLAN_CTAG_TX     |
> @@ -3555,12 +3554,6 @@ void ice_set_netdev_features(struct net_device *netdev)
>  	/* Allow core to manage IRQs affinity */
>  	netif_set_affinity_auto(netdev);
>  
> -	/* Mutual exclusivity for TSO and GCS is enforced by the set features
> -	 * ndo callback.
> -	 */
> -	if (ice_is_feature_supported(pf, ICE_F_GCS))
> -		netdev->hw_features |= NETIF_F_HW_CSUM;
> -

[Severity: High]
With NETIF_F_HW_CSUM now in csumo_features it is enabled by default
(netdev->features |= netdev->hw_features) and also propagated into
hw_enc_features and vlan_features.  On E830 that makes the GCS context
descriptor path in ice_tx_csum() the default Tx checksum path.  Can the
values programmed there be truncated?

	u16 csum_start = (skb->csum_start - skb->mac_header) / 2;
	u16 csum_offset = skb->csum_offset / 2;
	u16 gcs_params;

	gcs_params = FIELD_PREP(ICE_TX_GCS_DESC_START_M, csum_start) |
		     FIELD_PREP(ICE_TX_GCS_DESC_OFFSET_M, csum_offset) |

The descriptor fields in ice_lan_tx_rx.h are narrow:

	#define ICE_TX_GCS_DESC_START_M		GENMASK(7, 0)
	#define ICE_TX_GCS_DESC_OFFSET_M	GENMASK(11, 8)

i.e. at most 510 bytes of L2+L3 header and at most a 30-byte checksum
offset.  Neither value is range-checked, and FIELD_PREP()'s
__BF_FIELD_CHECK only rejects out-of-range constants, so a runtime value is
silently masked.

The driver's ndo_features_check, ice_features_check(), only bounds the two
lengths individually:

	len = skb_network_offset(skb);
	if (len > ICE_TXD_MACLEN_MAX || len & 0x1)
		goto out_rm_features;

	len = skb_network_header_len(skb);
	if (len > ICE_TXD_IPLEN_MAX || len & 0x1)
		goto out_rm_features;

That permits 254 + 508 = 762 combined bytes, well past the 510 bytes the
GCS start field can express.  An IPv6 frame with roughly 498..508 bytes of
header plus extension headers (a long HOPOPTS/DSTOPTS chain, or an SRv6 SRH
with many SIDs over a VLAN) passes both checks, yet
(csum_start - mac_header) / 2 = 259 becomes 3 after masking, so the NIC
sums the wrong byte range and inserts the result inside the MAC/IPv6
header.

The same masking applies to skb->csum_offset > 30, which
virtio_net_hdr_to_skb()/skb_partial_csum_set() allow (they only bound
start/off against skb_headlen()), and which the core no longer filters now
that NETIF_F_HW_CSUM is advertised.  Would a FIELD_MAX() check on both
values before taking the GCS branch, or an added combined-length check in
ice_features_check(), be appropriate here?

>  	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);
>  }
>  
> @@ -6519,18 +6512,6 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
>  	if (changed & NETIF_F_LOOPBACK)
>  		ret = ice_set_loopback(vsi, !!(features & NETIF_F_LOOPBACK));
>  
> -	/* Due to E830 hardware limitations, TSO (NETIF_F_ALL_TSO) with GCS
> -	 * (NETIF_F_HW_CSUM) is not supported.
> -	 */
> -	if (ice_is_feature_supported(pf, ICE_F_GCS) &&
> -	    ((features & NETIF_F_HW_CSUM) && (features & NETIF_F_ALL_TSO))) {
> -		if (netdev->features & NETIF_F_HW_CSUM)
> -			dev_err(ice_pf_to_dev(pf), "To enable TSO, you must first disable HW checksum.\n");
> -		else
> -			dev_err(ice_pf_to_dev(pf), "To enable HW checksum, you must first disable TSO.\n");
> -		return -EIO;
> -	}
> -
>  	return ret;
>  }
