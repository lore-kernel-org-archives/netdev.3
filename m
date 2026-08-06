Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404DF366553
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034392; cv=none; b=CSFAilVbBvvENLPrQejT6aVvFNfDcltT3U+GOfiAb6eAvMcvi0zCgqq/ja1y3Piq0wMsJNXHCLkvmGgmcxIqvizkXfticRtMBUCQh4CVpH3dpgnlAnA33TF0uvCsRqec4YS37bqk6eyMlirs/F/LfTXUdDbr0jvd67aqcxyhD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034392; c=relaxed/simple;
	bh=wvsxxt/FpSJZKCOrF1M7MFRMNZcWQP8tVZ0SORsoR4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qd/9xD0P2CLXx1KRAGhehhkZeFBKnnI5b95L2V+2GHaiYGJs0b0xkLXR+t7dUOto7B4QU+cBRIoyB1rGuyYfRL/+5BdqDMLCkGBzdibM9aaXT3OmM5IJACZG1E8hOxoU0g1rSfzJ61X83Gw9B7BfWfuvdBltVkbq4+Sbgp1VX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTYPclz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTYPclz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAF81F000E9;
	Thu,  6 Aug 2026 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786034390;
	bh=8Z7x3vpS5L/9DV63t4j/E169Et1rDRo5hXWrjcuscOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KTYPclz0kkHnBX5VdRHVX+bK/uVu3yIIHnwHHkucZInfyhf7REtuvE2wDM/yFXFBC
	 RPIjXSFOyVk/0bdXSKVw+IxwMmhgw/Yh/gsBdPiQIN+hXgGdDX1VQx9Tz2uEaLxsgC
	 TBh9wJyIxv7QsU2quMRxNmhYBoPIQIuN/GeJ1Z7jl4K/8zMroVOYhFOsSDxtgTISg/
	 sVECZkN8uflN7QYxmMKMJPHBS8jk7IZOIt318hn8lXr6PvbfYXcEFvBvrL8qyErrfo
	 61A1/JEhHqJP5Qa2/fiH4ye7napxvdJJFTkqtRt+3Uo2FL761/+sRnyZPIeKoS8YIr
	 Hi8n1UkM2FBeQ==
From: Jakub Kicinski <kuba@kernel.org>
To: clementwei90@163.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	weirongguang@kylinos.cn
Subject: Re: [PATCH net v1] tap: fix incorrect variable used for USO check in set_offload()
Date: Thu,  6 Aug 2026 09:39:49 -0700
Message-ID: <20260806163949.2807698-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805072121.117472-1-clementwei90@163.com>
References: <20260805072121.117472-1-clementwei90@163.com>
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
tap: fix incorrect variable used for USO check in set_offload()

This changes the RX_OFFLOADS decision in set_offload() so that the
TUN_F_USO4/TUN_F_USO6 test reads the ioctl argument instead of
feature_mask, since feature_mask only ever holds NETIF_F_* bits.

> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index fae115915c8ef..ce25ebeeccf0e 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -895,7 +895,7 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
>  	 * user-space will not receive TSO frames.
>  	 */
>  	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6) ||
> -	    (feature_mask & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
> +	    (arg & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
>  		features |= RX_OFFLOADS;
>  	else
>  		features &= ~RX_OFFLOADS;

[Severity: High]
This isn't a bug introduced by this patch, but there looks to be a second
wrong-variable defect from the same commit named in the Fixes: tag, a few
lines above in the same function:

drivers/net/tap.c:set_offload() {
	if (arg & TUN_F_CSUM) {
		feature_mask = NETIF_F_HW_CSUM;
		...
			if (arg & TUN_F_TSO4)
				feature_mask |= NETIF_F_TSO;
			if (arg & TUN_F_TSO6)
				feature_mask |= NETIF_F_TSO6;
		...
		/* TODO: for now USO4 and USO6 should work simultaneously */
		if ((arg & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
			features |= NETIF_F_GSO_UDP_L4;
	}
	...
	tap->tap_features = feature_mask;
	if (tap->update_features)
		tap->update_features(tap, features);
}

Should NETIF_F_GSO_UDP_L4 be set in feature_mask rather than features here?
All the TSO bits go into feature_mask, and feature_mask is what becomes
tap->tap_features, i.e. the forward feature mask consulted in
tap_handle_frame():

	if (q->flags & IFF_VNET_HDR)
		features |= tap->tap_features;
	if (netif_needs_gso(skb, features)) {
		struct sk_buff *segs = __skb_gso_segment(skb, features, false);

With NETIF_F_GSO_UDP_L4 missing from tap->tap_features, net_gso_ok() fails
for SKB_GSO_UDP_L4 and every USO super-frame is split by
__skb_gso_segment() before it reaches userspace.

The write into the local features also looks like it cannot have a device
level effect, because macvlan_fix_features() filters vlan->set_features
through MACVLAN_FEATURES (which does not contain NETIF_F_GSO_UDP_L4) and
then does features |= ALWAYS_ON_FEATURES, where NETIF_F_GSO_SOFTWARE
already contains NETIF_F_GSO_UDP_L4.

For comparison, tun.c:set_offload() records NETIF_F_GSO_UDP_L4 in the mask
that becomes tun->set_features:

		if (arg & TUN_F_USO4 && arg & TUN_F_USO6) {
			features |= NETIF_F_GSO_UDP_L4;

Also, macvtap's TUN_OFFLOADS, used to initialise tap_features in
macvtap_newlink(), contains no NETIF_F_GSO_UDP_L4 either.

Would it make sense to fix both occurrences in one patch, so that USO on
tap/macvtap actually takes effect?  As it stands, this patch turns
GRO/LRO on for the USO case while the aggregated skbs are still
re-segmented, and a backporter reading the changelog would likely conclude
USO on tap works afterwards.

[Severity: Medium]
Is the new arg based term meant to be evaluated outside the
if (arg & TUN_F_CSUM) block?  The sibling USO test that sets
NETIF_F_GSO_UDP_L4 sits inside that block, so the two tests now disagree
on their precondition.

tap_ioctl()'s TUNSETOFFLOAD handler only rejects unknown bits:

		if (arg & ~(TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
			    TUN_F_TSO_ECN | TUN_F_UFO |
			    TUN_F_USO4 | TUN_F_USO6))
			return -EINVAL;

so arg == (TUN_F_USO4 | TUN_F_USO6) with TUN_F_CSUM clear is reachable from
userspace holding the tap fd.  In that case the whole
if (arg & TUN_F_CSUM) block is skipped, feature_mask stays 0, no offload is
negotiated, yet the new term is true and features |= RX_OFFLOADS runs.

This looks like a new state transition: the old expression
feature_mask & (TUN_F_USO4 | TUN_F_USO6) was always false, since
TUN_F_USO4/TUN_F_USO6 (0x20/0x40) map onto NETIF_F_HIGHDMA_BIT and
NETIF_F_FRAGLIST_BIT, which feature_mask never contains, so this arg value
previously took the features &= ~RX_OFFLOADS branch.

RX_OFFLOADS is (NETIF_F_GRO | NETIF_F_LRO), and both bits are inside
MACVLAN_FEATURES, so the value reaching macvtap_update_features() ->
vlan->set_features -> netdev_update_features() sticks and shows up in
ethtool -k.  Since tap->tap_features is 0 in that path, tap_handle_frame()
then re-segments everything GRO coalesced.

Would nesting the USO test under arg & TUN_F_CSUM, as tun.c:set_offload()
does, or deriving it from feature_mask once the NETIF_F_GSO_UDP_L4
assignment above is corrected, be preferable here?
