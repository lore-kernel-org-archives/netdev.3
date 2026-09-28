Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32B3CAA31
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790639268; cv=none; b=iDVD34eQzzn7kK6R6yOGJE4wGM2gG9ZJWRfQp4j6bCIhG+zuhPrnWG2tRxapTsv9jDBjiPPxlMA9UA/ktRgaotNETdcYDoAyorXIUBURVbpspf45QlVKWWt7IIu7QvmS18eeUSlK8abDLfBZwRZchPG8tpVXICJbbpo5q5BVz4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790639268; c=relaxed/simple;
	bh=gEm1Rj5jMfZKM/6FtNd+3rsm7NpgWYwLPAoNNWVJZK8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MxMaOw7olx+wO4IqveFa3yT8lIb5kqohNclCSQfEP7rZI1oHSpufuxyzWk2nubvbHMCnuIj0pTi0HKbmjAJ4VEMQ8GUgkS2bEiRNW11sjeL3UFMXU6rkTBaom+dk5p0avbmWfA5EKEde3S7vmV7hkYp08Bf8+r3OjmchGOiBrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWwRCRIz; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWwRCRIz"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f90fc533so3484720d50.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790639265; x=1791244065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GvJsAN90fqY6o1hF60P1EIFX33FNwyZxbNSmpj4kLK8=;
        b=MWwRCRIz9oXoyfBuYQEVyJoemJ+4UzgywNg5n4SVxBgBgXpERN/sJNzkf263vbEFjD
         i+IMPmUZmG7SmtuYeC9SRKf8kxQZ1K8u3SWVYk1G8OmPrYAFXnR5yPcMGppB8/W8CnTt
         zvC7nuwkzo0w9gwgIpWq1wcfmFznPtd/D+GUsWH6Ht/LPJvcduxf+PF60G7ag/FqnS5B
         C+zUK7G1XCsya3IyH2sAzQXaLFMA9NYnXp5eDgwBwCMZ9gY5qWuzK22q3Z8CyVcnTvOp
         Xo9+RjAZimJX68A3dAbWp4tqnYPzwQUiZjaJoTs0eW26/Axxvg/1cQBSHyr5Napk66SD
         BsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790639265; x=1791244065;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GvJsAN90fqY6o1hF60P1EIFX33FNwyZxbNSmpj4kLK8=;
        b=Xkqqp474gBDVuN6tTjPJW+aUGXh4WjVc4SG+EwwOBVGhnzmpp6Zu/9UQ8fD3nmG0Bb
         Nb/dnKP4yZDnqwlPZ7ZT4LmPMMBkquuTF27fxSd5ne9gmW6chgr0ws79XkPHFwmcU1Im
         hAO6q1aolmGb2wlutX0UraWBk4nKL9R7plFYEqq80LHWjXCtx/8Kf9oy/sabMbbEvEP3
         6ZmjFH2mJZF9C2xDNv2tkAIkyoLyPFV5Z01y8s66fyv1/M4xKVXaQqew0Q8+CSJoNwbk
         KksfPIIsVl9pTPglJH+HZCBye7i0G+omqct4cTYbcvuubMGdM49hZDuAXqiUEosvTJ7S
         T9Zw==
X-Forwarded-Encrypted: i=1; AKwUvBwnQTwCgxtflupoVBtH/J4KS5+FZ0qDWZk2/4e2aBCVYV9qAL0+cYF4VrT0hUSjm2Sb4PvCu2Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLipX5ej5SvdAcOI+0+4vn8wXfJqgRDTnIKwR0HXdL+Pptp5vRx
	Jx8doWgNDEeGa5KHOCnHDwUWk2i1OWoaR25HFh1LuRTo3ZWGfIyDw3J+
X-Gm-Gg: AYBFou1fxXcB8jTwG9wmtT2sdCU8sVPemCSzKC7G2ZCBAotIg6PyVtSqTFb0iW8iUia
	rleOswaO1vlh0gHSRhMXChjf2f0Ge3qKukPVP1+ynYmeGPCcV5SP469j4BEBdlKHRevV7BykerI
	NwXdrc0E5pUbTAbKGBFKIAQ4hkV4FiJtoPbZ0i/UB1u1glFE0J/0SJFmN/h/a+48cnlRVO75bfd
	+3gagHAWH0rRc14VhrKFMmwAf8nUEd6u30SAWEcOzho9C1z4sRfijEe+s8qxcroyAvHRI17GQfc
	EYxqs/ntTzi8TjjcCcq0KuloXZ/dBzlrYy6IS/MFLnT3bMnGt/pEut8xZFK3b7uWw0domNwBSad
	NsXnp41oQm2cu4ooI0k5pBkT4Mxb+8jdvIy66u7k+PEs4zuXvwPA6MrJl1xoIg5RfaDw5K3EPbN
	lys5gT1TAxPfx4R8Mhm127Zx24kgMFRmJEjyTdgmFRq54VFbLHnnFCPSzejwUSvrCk+LhEFgLAi
	vPfwGRsLdYka1RxKTWLLqayRU+uI3ZGvrWkee2oCAH3YOjOCnHS
X-Received: by 2002:a53:ac8b:0:b0:675:62c9:1a52 with SMTP id 956f58d0204a3-67562c929abmr147640d50.74.1790639265322;
        Mon, 28 Sep 2026 16:47:45 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740efc941csm5254693d50.20.2026.09.28.16.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 16:47:44 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:47:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 Wang Zhan <wang.zhan@smartx.com>
Message-ID: <willemdebruijn.kernel.3b556463ed93f@gmail.com>
In-Reply-To: <20260928044102.1004310-5-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
 <20260928044102.1004310-5-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v3 4/5] net: core: resegment oversized TCP GSO
 skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> A GSO skb which exceeds an egress device limit loses its GSO feature mask
> and is segmented into individual packets.  This is unnecessarily expensive
> when the device can still offload smaller TCP GSO skbs, which is easy to
> hit once one hop of a BIG TCP path raises gso_max_size and the next one
> does not.
> 
> For an unencapsulated TCP GSO skb which exceeds gso_max_size or
> gso_max_segs, work out how many MSS segments each output skb may carry and
> resegment the skb with that max_segs bound instead.  Encapsulated and
> frag-list skbs, GSO types the device cannot offload and bounds which leave
> room for a single MSS keep today's segmentation.  The output obeys the GSO
> feature and limit contract the device already advertises, so it applies
> automatically, without extra device state or a userspace control.
> 
> The output is a plain GSO skb, so its whole length lands in the 16-bit L3
> length field which inet_gso_segment() and ipv6_gso_segment() write.  An
> egress limit above 64 KiB would give outputs whose length truncates, so
> the size limit is also capped at what that field can express.
> 
> The helper runs on the skb which is handed to the driver, after
> validate_xmit_vlan() and sk_validate_xmit_skb(), and only from the
> netif_needs_gso() branch, so an skb which is not segmented pays nothing.
> An over-limit skb pays one device limit test and one ndo_features_check()
> for the bound, in exchange for keeping the output a GSO skb.
> 
> Measured on a veth -> bridge -> TAP -> guest virtio-net path, with BIG TCP
> enabled on the veth endpoints and left off in the guest, so the skbs which
> the veth hop accepts have to be segmented before the TAP device.  A single
> iperf3 TCP flow, six alternating runs per state (`-t 15 -O 5`, fixed CPU
> affinity and port tuple).  The middle column is the same tree with the
> resegmentation disabled:
> 
>   protocol  no BIG TCP   mixed, no reseg  mixed, resegmented
>   TCP/IPv4  51.550 Gbps  15.850 Gbps      52.617 Gbps
>   TCP/IPv6  52.050 Gbps  15.783 Gbps      51.933 Gbps
> 
> Coefficient of variation for the two mixed columns was 0.48% and 0.82% for
> IPv4 and 0.44% and 0.44% for IPv6.  A BIG TCP hop which feeds a 64 KiB hop
> loses 69% of the throughput of a path which never enables BIG TCP at all;
> bounded resegmentation recovers it, 3.3x over the existing segmentation
> path and within noise of the no BIG TCP baseline.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> 
> ---
> v3:
> - the L3 protocol change moved to patch 1
> - fold skb_can_gso_resegment() into the helper, now skb_gso_output_max_segs()
> - pass the caller's features on unchanged, the bound only shapes the output
> - drop the scatter-gather and checksum tests skb_segment() applies itself
> - saturate the size limit with min(), drop the sub-MSS guard
> - cap the output size at GSO_LEGACY_MAX_SIZE, these outputs are not BIG TCP
> v2: https://lore.kernel.org/20260918084651.3022878-4-wang.zhan@smartx.com/
> v1: https://lore.kernel.org/20260917063854.2011613-4-wang.zhan@smartx.com/
> ---
>  net/core/dev.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d66b667071837..728260772f349 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3933,6 +3933,63 @@ netdev_features_t netif_skb_features(struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL(netif_skb_features);
>  
> +static unsigned int
> +skb_gso_output_max_segs(struct sk_buff *skb, struct net_device *dev)
> +{
> +	unsigned int mss = skb_shinfo(skb)->gso_size;
> +	unsigned int gso_max_size, hdr_len, max_segs;
> +	netdev_features_t features;
> +	struct tcphdr _tcph, *th;
> +
> +	/*
> +	 * The TCP frag-list path segments through skb_segment_list(), which
> +	 * does not carry max_segs, so bounded calls skip those skbs.
> +	 */

This comment answers only one of six conditions. And one that is
pretty straightforward. I'd drop.

In general, drop all too-obvious comments. AI has a habit of adding
a lot more, and more low information, comments than is customary in
kernel code (where we also have commit messages). Generally, repeating
what the code does is of little value.

> +	if (!skb_is_gso(skb) || !skb_is_gso_tcp(skb) ||
> +	    skb->encapsulation || skb_has_frag_list(skb) ||
> +	    !skb_mac_header_was_set(skb) ||
> +	    !skb_transport_header_was_set(skb))

Conversely, they last two conditions are less obvious. Are they not
always true for a TSO packet?

> +		return 0;
> +
> +	th = skb_header_pointer(skb, skb_transport_offset(skb), sizeof(_tcph),
> +				&_tcph);
> +	if (!th || th->doff < sizeof(*th) / 4)
> +		return 0;
> +
> +	hdr_len = skb_transport_header(skb) - skb_mac_header(skb) +
> +		  th->doff * 4;
> +
> +	/*
> +	 * The output stays a GSO skb, so the device has to offload the GSO
> +	 * type.  The caller's features cannot tell that: this skb is over
> +	 * the device limits, so gso_features_check() has cleared their GSO
> +	 * bits.  Compute the features again without the limit checks.
> +	 */
> +	features = __netif_skb_features(skb, false);
> +	if (!net_gso_ok(features | NETIF_F_GSO_ROBUST,
> +			skb_shinfo(skb)->gso_type))
> +		return 0;
> +
> +	/*
> +	 * The output is a plain GSO skb, so its whole length lands in the
> +	 * 16-bit L3 length field: only a BIG TCP skb may exceed the legacy
> +	 * GSO size, and this path does not emit one.
> +	 */
> +	gso_max_size = netif_get_gso_max_size(dev, vlan_get_protocol(skb));

Third time this is now called in validate_xmit_skb. Not sure if that can
easily be avoided.

> +	gso_max_size = min(gso_max_size, GSO_LEGACY_MAX_SIZE);
> +
> +	/*
> +	 * gso_within_dev_limits() accepts gso_segs == gso_max_segs but
> +	 * rejects skb->len >= gso_max_size, so only the size bound needs - 1.
> +	 * The min() keeps that subtraction from wrapping when the device
> +	 * limit is smaller than the headers.
> +	 */
> +	max_segs = (gso_max_size - min(gso_max_size, hdr_len + 1)) / mss;
> +	max_segs = min(max_segs, READ_ONCE(dev->gso_max_segs));
> +
> +	return max_segs;
> +}
> +
>  static int xmit_one(struct sk_buff *skb, struct net_device *dev,
>  		    struct netdev_queue *txq, bool more)
>  {
> @@ -4097,9 +4154,13 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>  		goto out_null;
>  
>  	if (netif_needs_gso(skb, features)) {
> +		unsigned int max_segs = 0;
>  		struct sk_buff *segs;
>  
> -		segs = skb_gso_segment(skb, features);
> +		if (unlikely(!gso_within_dev_limits(skb, dev)))
> +			max_segs = skb_gso_output_max_segs(skb, dev);
> +
> +		segs = __skb_gso_segment(skb, features, true, max_segs);
>  		if (IS_ERR(segs)) {
>  			goto out_kfree_skb;
>  		} else if (segs) {
> -- 
> 2.47.3
> 


