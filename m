Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483B2ED141
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789832270; cv=none; b=hf2UXjAKg1jslI8sBPZVg6/BqiVwJqP2Q9aGzplNCuZfx6Vyh/KNP8x52xHD1owWZY5qY20gTjHyfGlEbAG+6x6UiY354T9jvCaMpKVrFOlel0xOtcu/6q+GXQRk6NODfgw2wJX7b45B4IDSTncAIqirT/cwXl0/1g5kqo67PYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789832270; c=relaxed/simple;
	bh=mfUJiTi+gGbpVlqo3GpBKnEnp6I3eaFOLIpYsMT/0Us=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BKzh4QSjOk0u5O331fFwr04rp075x0AsbQ3LLQ51RrTvAWzQOq3LnBecIuaJPQZq8oOfaRHWL9HRn2/G1ugJxBL7n3Nv6yK0xWsmQj3iefIOcGs6y9w/TWqEa5qC+1QM7V7GjR6HiaRGow6lK0Vc9u0xAZwmMHbvzZ4yXookW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODTL0UNO; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODTL0UNO"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-89666ee9b3bso10647897b3.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789832267; x=1790437067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RVj3rO42m1M7ZOjQMlG+l8AKpOheIGneKdCx5lNnpyE=;
        b=ODTL0UNOQE/tfDnURzattmZ+IHj0kALtiWca+sjUeHDcGqZFVdMDoKBvYX7CoC7xJa
         8nZBbcaBwgFUFvBX9OjgfRL7psYCqrtIzaazCxrRXXuR4QQTBK/J6J3f89h6NHhfGRRB
         LaVjgmudgauW1h17flf2lq0knObhJnfPSHOFOVSHC7DZVZFXAZ5NCJCDUSjEu+Co6q2M
         rHD7HuVDOXzbhYBk3/kHT0DYXW24IXVOkEk5L9SyGpv1qxthq0kJHr19DJ0NLTRozLsY
         XCqz00O2IdTJxLR5xg+16lgm66L+FB9JGLswOLqnRbz6RFWyC1az5YQrwjhai0JYIYoC
         l2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789832267; x=1790437067;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVj3rO42m1M7ZOjQMlG+l8AKpOheIGneKdCx5lNnpyE=;
        b=mdX169lCs1TiA8uwfUbLXKs+gDtVob8oZypE1NLz78Zn0uR3FoAxcFmJGT/4vh7Uob
         46+FUROz8nf40ZEuEVkmXwejvc0wlV320K2ruS83wVDlWA4YWXyk08zXy2fazIpKYDz8
         4JBGRrwtFfXK2Jv3z6U3MMhcLetFWtGwMIEz+pEh7yRGMeBvUtqrftYP8soRQNxpgdp3
         EHVxDDy176cgamA8e5WGYEVAWJZcsznvzLpDzAh6n4T2P39MgHzLSZQ9ahZAFgK1Rzdy
         1+LRm0CTGQWwnzZzwD15hqGQqMJKMcL8Nlu56qJ72OJ2Dzt/J2O2SgPlIByfG6ibWwii
         TqUA==
X-Forwarded-Encrypted: i=1; AKwUvBzvq6+iIznAGKTbJCdlgjJeOMy89/KVZ881uYIyoSFMfT2xMwZtAwVmhj5CqaC5y+NI4AU72qE=@vger.kernel.org
X-Gm-Message-State: AFuF++n9A5Mjm/j6zTp5NXiN8hy6RKmZJCxSlH5NIScGC69NxhQyMqpM
	1CnGcAntZXScFwmAoWrfL28hTNdb48z5tMIocC4jAo7DvmluH9ZJ0mWA
X-Gm-Gg: AYBFou3q1WErBIhoEf+b71kl3d59JPW4N0584gd+GdotsPauiyKXzS3LOGc+AcAJMyC
	njKf8Q+nfcbiWRfcKh7/Wayk5cSmo7yzUiAm2rvKL1nJe+t/Ezn9Bso8sY/tNRYJdjPy2wyYEj5
	N+5WCzgVGrbj+68Ent9Z0Fe4R6D60vxLubx5i2CXYRIjfzLgncbBgd+oLj7sxQ7iWQ/26GNQC0e
	eeVEgeLb2c6Mtjk0RW7rE9mbu19PtNvvaPa7bUgsQsBM2UxHhvnET6J2tGcQQaOL1j2UA/HXq1s
	LBOwDcV9/z6dfaXgNVwO3+dtEZYcizKjejoa+wvzaA1jhFSjgPVl9SwiF3ZFaqt3PPeQyvwMf+B
	BJDMgbFMCiARue5vyNrLxs6gM+2onzDDbftUHbO1M8gy5fbBpRYzuLs7RcKV3BnzgaNd2mkwvR8
	DXiw66qJlyHeeHTnr2fSl6HhOdLGQKaupNR+b5CLHoEua56VKmF34m0l/sxAgB0vyGFNp7lZCXs
	MEAV/CM/A+nBSSg25m9mEk1syS0QnFdNCG5N16zTdRTIBXVoLBi
X-Received: by 2002:a05:690c:e68d:20b0:89a:63da:cbea with SMTP id 00721157ae682-89a63daccc7mr8047557b3.48.1789832267217;
        Sat, 19 Sep 2026 08:37:47 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a46c43cecsm9677177b3.22.2026.09.19.08.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 08:37:46 -0700 (PDT)
Date: Sat, 19 Sep 2026 11:37:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 dev@openvswitch.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jason Wang <jasowangio@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 Wang Zhan <wang.zhan@smartx.com>
Message-ID: <willemdebruijn.kernel.32be703ea17ab@gmail.com>
In-Reply-To: <20260918084651.3022878-4-wang.zhan@smartx.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
 <20260918084651.3022878-4-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v2 3/4] net: core: resegment oversized TCP GSO
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
> and is segmented into individual packets. This is unnecessarily expensive
> when the device can still offload smaller TCP GSO skbs, which is easy to
> hit once one hop of a BIG TCP path raises gso_max_size and the next one
> does not.
> 
> For an unencapsulated TCP GSO skb which exceeds gso_max_size or
> gso_max_segs, work out how many MSS segments each output skb may carry and
> resegment the skb with that bound instead. Keep the features computed
> without the GSO limit checks, which say whether the device offloads the
> GSO type at all. Encapsulated and frag-list skbs, GSO types the device
> cannot offload, and bounds below two segments keep the existing full
> segmentation path. The result obeys the GSO feature and limit contract the
> device already advertises, so apply it automatically, without extra device
> state or a userspace control.
> 
> The check runs on the skb which is handed to the driver, after
> validate_xmit_vlan() and sk_validate_xmit_skb(), and costs one extra
> ndo_features_check() on the oversized path, against segmenting the skb
> into individual packets. That position is also why the limit follows the
> L3 protocol rather than skb->protocol: validate_xmit_vlan() replaces the
> latter with the VLAN ethertype when it pushes the tag inside the skb.
> 
> Measured on a veth -> bridge -> TAP -> guest virtio-net path, with BIG TCP
> enabled on the veth endpoints and left off in the guest, so the skbs which
> the veth hop accepts have to be segmented before the TAP device. A single
> iperf3 TCP flow, six alternating runs per state (`-t 15 -O 5`, fixed CPU
> affinity and port tuple). The middle column is the same tree with the
> resegmentation disabled:
> 
>   protocol  no BIG TCP   mixed, no reseg  mixed, resegmented
>   TCP/IPv4  51.550 Gbps  15.850 Gbps      52.617 Gbps
>   TCP/IPv6  52.050 Gbps  15.783 Gbps      51.933 Gbps
> 
> Coefficient of variation for the two mixed columns was 0.48% and 0.82%
> for IPv4 and 0.44% and 0.44% for IPv6. A BIG TCP hop which feeds a 64 KiB
> hop loses 69% of the throughput of a path which never enables BIG TCP at
> all; bounded resegmentation recovers it, 3.3x over the existing
> segmentation path and within noise of the no BIG TCP baseline.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> ---
>  net/core/dev.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 106 insertions(+), 7 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 16685888b2812..548db4d4e874c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3834,18 +3834,24 @@ static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
>  			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
>  }
>  
> +/*
> + * Does @skb fit the GSO limits of @dev?  The size limit depends on the L3
> + * protocol, which validate_xmit_vlan() replaces with the VLAN ethertype when
> + * it pushes the tag inside the skb, so look behind the tag.
> + */
>  static bool gso_within_device_limits(const struct sk_buff *skb,
>  				     const struct net_device *dev)
>  {
>  	return skb_shinfo(skb)->gso_segs <= READ_ONCE(dev->gso_max_segs) &&
> -	       skb->len < netif_get_gso_max_size(dev, skb->protocol);
> +	       skb->len < netif_get_gso_max_size(dev, vlan_get_protocol(skb));

If this change is needed, it is not new for this feature and should be
a separate commit.

> +static bool skb_can_gso_resegment(struct sk_buff *skb,
> +				  netdev_features_t features)
> +{
> +	__be16 protocol;
> +
> +	if (!net_gso_ok(features | NETIF_F_GSO_ROBUST,
> +			skb_shinfo(skb)->gso_type))
> +		return false;
> +
> +	if (!(features & NETIF_F_SG))
> +		return false;
> +
> +	protocol = skb_network_protocol(skb, NULL);
> +	if (!protocol || !can_checksum_protocol(features, protocol))
> +		return false;
> +
> +	/*
> +	 * The TCP frag-list path does not carry the bounded segment
> +	 * limit through skb_segment_list(). Keep bounded resegmentation
> +	 * on the regular skb path until that support is added.
> +	 */
> +	if (skb_has_frag_list(skb))
> +		return false;
> +
> +	return true;
> +}
> +
> +static unsigned int
> +skb_gso_resegment_max_segs(struct sk_buff *skb, struct net_device *dev,
> +			   netdev_features_t features)
> +{
> +	unsigned int mss = skb_shinfo(skb)->gso_size;
> +	unsigned int hdr_len, max_segs;
> +	unsigned int gso_max_size;
> +	struct tcphdr _tcph, *th;
> +
> +	gso_max_size = netif_get_gso_max_size(dev, vlan_get_protocol(skb));
> +
> +	if (!skb_is_gso(skb) || !skb_is_gso_tcp(skb) ||
> +	    skb->encapsulation || mss == GSO_BY_FRAGS ||
> +	    !skb_mac_header_was_set(skb) ||
> +	    !skb_transport_header_was_set(skb) ||
> +	    !skb_can_gso_resegment(skb, features))
> +		return 0;

Is this duplicating/extending skb_can_gso_resegment

> +
> +	th = skb_header_pointer(skb, skb_transport_offset(skb), sizeof(_tcph),
> +				&_tcph);
> +	if (!th || th->doff < sizeof(*th) / 4)
> +		return 0;
> +
> +	hdr_len = skb_transport_header(skb) - skb_mac_header(skb) +
> +		  th->doff * 4;
> +	if (gso_max_size <= hdr_len + mss)
> +		return 0;
> +
> +	/*
> +	 * gso_within_device_limits() accepts gso_segs == gso_max_segs but
> +	 * rejects skb->len >= gso_max_size, so only the size bound needs - 1.
> +	 */
> +	max_segs = (gso_max_size - hdr_len - 1) / mss;
> +	max_segs = min_t(unsigned int, max_segs,
> +			 READ_ONCE(dev->gso_max_segs));
> +
> +	return max_segs > 1 ? max_segs : 0;
> +}
> +
>  static int xmit_one(struct sk_buff *skb, struct net_device *dev,
>  		    struct netdev_queue *txq, bool more)
>  {
> @@ -4073,6 +4152,7 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
>   */
>  static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device *dev, bool *again)
>  {
> +	unsigned int resegment_max_segs = 0;
>  	netdev_features_t features;
>  
>  	skb = validate_xmit_unreadable_skb(skb, dev);
> @@ -4088,10 +4168,29 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>  	if (unlikely(!skb))
>  		goto out_null;
>  
> -	if (netif_needs_gso(skb, features)) {
> +	/*
> +	 * An oversized skb loses its GSO feature bits and is segmented
> +	 * down to MSS sized skbs below.  A TCP skb can instead be split
> +	 * into GSO skbs which do fit the device, so keep the bits and
> +	 * bound the resegmentation.  The features computed without the
> +	 * limit checks say whether the device offloads the GSO type at
> +	 * all.
> +	 */
> +	if (skb_is_gso(skb) && skb_is_gso_tcp(skb) && !skb->encapsulation &&
> +	    !gso_within_device_limits(skb, dev)) {
> +		netdev_features_t offload = __netif_skb_features(skb, false);
> +
> +		resegment_max_segs =
> +			skb_gso_resegment_max_segs(skb, dev, offload);
> +		if (resegment_max_segs)
> +			features = offload;
> +	}
> +

This is a lot to put in the hot path for a rare use case. Consider how
to make this less expensive.

> +	if (resegment_max_segs || netif_needs_gso(skb, features)) {
>  		struct sk_buff *segs;
>  
> -		segs = skb_gso_segment(skb, features);
> +		segs = __skb_gso_segment(skb, features, true,
> +					 resegment_max_segs);
>  		if (IS_ERR(segs)) {
>  			goto out_kfree_skb;
>  		} else if (segs) {
> -- 
> 2.47.3
> 


