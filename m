Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806592;
	b=P2XY2dOwmhZjqDaj4x/AjOhdMWMq6Vb/uv0+HlpnE2PGF0ybtbhHv/EXH9x+S1GQPcM7
	 kha4GH1fY3ppkJ/zrGh8lVe/Yw5SoCQEJxzDZ71uB8dVaq/IHSJNuFQ9FWJ5J6CYF2u0W
	 y+vjHLTTClNX5Je9aPiwly3/6tPBs3xrsl5fdyzalUcrYd6QzXAQ65CnPSSgdWCXjj2zD
	 ebqU8S3FY5sq7XnX8Ywlc5xym5DMWMgMaGm2zjt989W3UcPrsQyX0kyP5va/ghpSJV3g6
	 iUzr/Lkks1wS6DDhhxsg9ojPA5CeKs8Gj8jBCV2m9TEdRotUlRwNhkAxYRVzzVCnfyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806592;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xAtQKWzjOXKb3958QswYlotWoI/LcxYVqBPkJ2eRTAs=;
	b=nL+2fL9LRGE3CeXKyNJftKQjDUcW+nPDQdxbLFLbtqVFe0KXIkh+ZYBKTr68SUpScXgb
	 CSlWI5/6Y28RpriDguPAxvnd+vMRdq67la/XNfpLW2wyLubsdX9uboe2xdWVCdA63Z9Y4
	 tMpTDYVuQ1BJL2S36VLDOGPEYO3iVdaz2tINMJOiUNAuXoc0iJAalG6E0snIm5JQ2H1gH
	 EP3VaJ4m4n6Kqk4kANFrlegfyoDvMsVuyliHsVEy8L6Q0dy0NG8DQEafIeJMcTa3Q9XPe
	 LBRttjJnhYCVPxoOkkoeL/3gtG18TijiORhnPp0OLAA46jQBYPK7v9hXmQpm64i2Rcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=foWPc5jH;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ljIiye3Z;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F4606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F8F4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=foWPc5jH;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ljIiye3Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793806591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xAtQKWzjOXKb3958QswYlotWoI/LcxYVqBPkJ2eRTAs=;
	b=foWPc5jHooaBPfoYegsjAnCNRABDcdxk88PXlcICWq8v4RB4SvdWDn//ZGqwpY+chdheko
	rGqyKgSe5IfCWRLGn2ufmHz2w52KkWLGpaqi4hD/kjaGI0VnVRwdx23iny0ZDW58QOvCIc
	CKO7j3MVpTLnMH5Ah2L+B9HCRJYJzv8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-OkNkmnwtNYud3qk9h5bWMA-1; Wed, 04 Nov 2026 10:36:30 -0500
X-MC-Unique: OkNkmnwtNYud3qk9h5bWMA-1
X-Mimecast-MFC-AGG-ID: OkNkmnwtNYud3qk9h5bWMA_1793806589
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so6561445e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793806588; x=1794411388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xAtQKWzjOXKb3958QswYlotWoI/LcxYVqBPkJ2eRTAs=;
        b=ljIiye3ZRmS9kIhLzHOUfUzvecShWCWf+gXzjQHqzihZomRI+scVRFOOH3+W7ZQK6i
         GqjorngMm2VZ9PrQxxIz5VGWgbCil52zdXBYQYvu+JJej2kxsOt2fN/r9lLhuOHhlU5g
         2z18FpfrdcIV9XzE2cwQfPJBdCjzySlHXgzGvOf88cgZ1p0mfPZGASjFXNY7DwBlAepK
         0y2QICRgOJ0YznmvFJCTJa2DJ7aBZ5qnjR6DBh/W6WNqmZPhmtaDUTTmGc/36ADHUgQP
         U3qs0N2GO74tjJMr5Y29XJYh4QSqSxqpl3xMpK82FuH3l1XiyzGr5HTZf1sAdWkWsaQH
         lIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806588; x=1794411388;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAtQKWzjOXKb3958QswYlotWoI/LcxYVqBPkJ2eRTAs=;
        b=tiCymAVjX8c5sNfYLyTpqgCBAamJ9mDG1bnr1FrHUFRay85/wOrVOHJDhgeoRDiDPF
         zcdbtHppTK3QHsza3PvI9jMLI6iiQaFlFJHvq+DhM9deybhgACEZ1vGi1aJoZLhQqgZA
         w8Do7mSEU6Nwnq9SdPMDA2TyeOVgit2PuoaT1aQ7pSmBQK40oYThyRQIUFL3TbL9HCX9
         V6pCwQJvZgs2r1M5Bm6fc1PMUllvjkE8uxSCO/ndM/f9HVh2Pv2XdpHKHCbiQGja1qqy
         HbjkpOguMNa7KPCGOzBUJltYPLeM8tc9EyaPQvArpmXVHrYoCS8aA2ty+iiozY1YfDEg
         zG8g==
X-Gm-Message-State: APuU4Z/rwZv5Ak+IydsTH8AlAAe4n6TQf1IMjNZSGrbNiDTrmp86zOSZ
	XTO08YmEqUOD3eVcMx0GgyhQKIaq3lhrhgqFLl/trHC+x5OU2lk7HtfAdD4G/u82Uzemn3x3dg8
	8X2EB8vj7Timxtp2jt/Yzg8SBQ5HItbzM1wrfc72V9YkehXiLe5jLv4NvIw==
X-Gm-Gg: AYBFou1aXTRxPcPlytTtM5GwSabVg3hTpouzkskWfVE32F69HZD74kDmKwxzOs4feb5
	5nv+G2m3XtMCgxXiuvOAhh49QbxnThKOyG3Vta1nQPJ5KFx7qmi15dK02Te23Omkzr01f/aXYAz
	e/3LzbLa2aTr6ceKts75IhAOhHvF9AEVjSuLMWAVM6SNWG/BSMGR7icvv45vUwHrLlw0kIW/DzA
	p5mHZ7T6waq1yu/dRMPHIQHslKq4vC3Y7dBAXbkQ/211e+4EfmUZxQP320Ympuoc+jZEr5mbrN/
	ZBrop5/SjZs0yjkdKLe/wnTqVw3drTDN70wdALp1jXjb+GVZUs309DVEVZoisex276/6IjP09fK
	M++6S+xHR6oxfsbh0GMR06HSY70Uxmc4YkFdfLxmMcA==
X-Received: by 2002:a05:600c:4e11:b0:4a0:eae0:769a with SMTP id 5b1f17b1804b1-4ac185bc7d0mr365205525e9.28.1793806588299;
        Wed, 04 Nov 2026 07:36:28 -0800 (PST)
X-Received: by 2002:a05:600c:4e11:b0:4a0:eae0:769a with SMTP id 5b1f17b1804b1-4ac185bc7d0mr365204975e9.28.1793806587601;
        Wed, 04 Nov 2026 07:36:27 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa481a45sm135508985e9.7.2026.11.04.07.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:36:26 -0800 (PST)
Date: Wed, 4 Nov 2026 10:36:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v2 1/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
Message-ID: <20261104103616-mutt-send-email-mst@kernel.org>
References: <20261104050131.629967-1-edumazet@kernel.org>
 <20261104050131.629967-2-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104050131.629967-2-edumazet@kernel.org>

On Wed, Nov 04, 2026 at 06:01:29AM +0100, Eric Dumazet wrote:
> virtio_net_hdr_tnl_to_skb() trusts the virtio header to describe a
> UDP tunnel over IPv4 or IPv6, but never checks that the frame actually
> carries such outer headers. Because VIRTIO_NET_HDR_F_NEEDS_CSUM is
> mandatory for tunnel GSO, __virtio_net_hdr_to_skb() skips the flow
> dissector, so virtio_net_hdr_match_proto() is never applied either.
> 
> A guest (or a tap writer) can then inject a frame with an arbitrary
> outer ethertype, for example ETH_P_NSH, with SKB_GSO_UDP_TUNNEL set.
> The GSO stack then runs nsh_gso_segment() on top of the UDP tunnel
> segmentation, which assumes a different header layout. The result is
> segments with skb->data before skb->head, and a host crash in
> skb_under_panic() as soon as a later layer pushes a header:
> 
>   skbuff: skb_under_panic: ... put:4 ... dev:gretap1
>   kernel BUG at net/core/skbuff.c:215!
>    skb_push
>    __gre_xmit
>    gre_tap_xmit
>    ...
>    tun_get_user
> 
> Validate the outer headers with the parsing helpers from Michael's
> series "net: resolve uncommon partial checksums at ingress":
> 
> - locate the L3 header from the device type: Ethernet with optional
>   VLAN tags, or the network header set by the caller. skb->protocol is
>   not trusted when it disagrees with the frame.
> - require the outer L3 protocol to match the declared tunnel type.
> - require the outer UDP header exactly at outer_th_offset, after IPv4
>   options or IPv6 extension headers, and reject fragments.
> 
> Unlike the original helpers, ipv6_find_hdr() stops at an AH header,
> as Willem suggested in the review of that series.
> 
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Reported-by: Hassan Sultan <hassansultan@google.com>
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Co-developed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio_net.h | 169 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd0..b9c8babb1fd7 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -5,7 +5,10 @@
>  #include <linux/if_vlan.h>
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
> +#include <linux/netdevice.h>
>  #include <linux/udp.h>
> +#include <net/ip.h>
> +#include <net/ipv6.h>
>  #include <net/tcp.h>
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>
> @@ -48,6 +51,146 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +/* TODO: nothing virtio specific here, move to ip.h */
> +
> +/*
> + * Pull and minimally validate the IPv4 header at @nhoff.
> + * Returns the header and stores the transport header offset in
> + * @thoff, or NULL if truncated or malformed.  The whole header,
> + * options included, is guaranteed linear on return.
> + */
> +static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> +						  unsigned int nhoff,
> +						  unsigned int *thoff)
> +{
> +	unsigned int ihl;
> +	struct iphdr *iph;
> +
> +	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
> +		return NULL;
> +
> +	iph = (struct iphdr *)(skb->data + nhoff);
> +	if (iph->version != 4 ||
> +	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
> +		return NULL;
> +
> +	ihl = iph->ihl * sizeof(u32);
> +	*thoff = nhoff + ihl;
> +	/* Pull the options as well: the transport header offset
> +	 * returned above must be within the linear data.  iph goes
> +	 * stale across the pull.
> +	 */
> +	if (!pskb_may_pull(skb, nhoff + ihl))
> +		return NULL;
> +
> +	return (struct iphdr *)(skb->data + nhoff);
> +}
> +
> +/* Where does the L3 header start, and what protocol is it?
> + * Handles Ethernet and VLAN headers; other devices use the
> + * network header offset the caller set up.
> + */
> +static inline bool
> +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> +{
> +	/* skb->dev should always be set here already,
> +	 * but let's not crash when it is not.
> +	 */
> +	if (WARN_ON_ONCE(!skb->dev))
> +		return false;
> +
> +	if (skb->dev->type == ARPHRD_ETHER ||
> +	    skb->dev->type == ARPHRD_LOOPBACK) {
> +		__be16 h_proto;
> +
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		h_proto = eth_hdr(skb)->h_proto;
> +		/* skb->protocol is a sender claim, and parts of the
> +		 * stack parse the packet per it: when it disagrees with
> +		 * the frame we do not know which view the packet will
> +		 * be parsed as, so do not validate.
> +		 */
> +		if (skb->protocol && skb->protocol != h_proto)
> +			return false;
> +		*nhoff = ETH_HLEN;
> +		*proto = h_proto;
> +		if (eth_type_vlan(*proto)) {
> +			*proto = __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}
> +	} else {
> +		const struct iphdr *iph;
> +
> +		*nhoff = skb_network_offset(skb);
> +		/* An unset network header shows up as an offset
> +		 * outside of the packet.
> +		 */
> +		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
> +			return false;
> +		/* No L2 header to cross-check with: take the protocol
> +		 * from the IP version at the network header.
> +		 */
> +		if (!pskb_may_pull(skb, *nhoff + 1))
> +			return false;
> +		iph = (const struct iphdr *)(skb->data + *nhoff);
> +		if (iph->version == 4)
> +			*proto = htons(ETH_P_IP);
> +		else if (iph->version == 6)
> +			*proto = htons(ETH_P_IPV6);
> +		else
> +			return false;
> +		if (skb->protocol && skb->protocol != *proto)
> +			return false;
> +	}
> +	return true;
> +}
> +
> +/* Walk the L3 header at @nhoff: where does its transport header
> + * start, and which protocol is it?  Returns false if the header
> + * is truncated, malformed or fragmented.
> + */
> +static inline bool
> +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> +		    unsigned int *thoff, int *ip_proto)
> +{
> +	if (proto == htons(ETH_P_IP)) {
> +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> +
> +		if (!iph || ip_is_fragment(iph))
> +			return false;
> +		*ip_proto = iph->protocol;
> +		return true;
> +	}
> +
> +	if (proto == htons(ETH_P_IPV6)) {
> +		const struct ipv6hdr *iph;
> +		int flags = IP6_FH_F_AUTH;
> +
> +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> +			return false;
> +		iph = (const void *)(skb->data + nhoff);
> +		if (iph->version != 6)
> +			return false;
> +		*thoff = nhoff + sizeof(*iph);
> +		*ip_proto = iph->nexthdr;
> +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> +			*thoff = nhoff;
> +			/* Find the transport header behind any
> +			 * extension headers, AH included.
> +			 */
> +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> +						  &flags);
> +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> +				return false;
> +		}
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					  const struct virtio_net_hdr *hdr,
>  					  bool little_endian, u8 hdr_gso_type)
> @@ -282,6 +425,29 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
>  
> +/* Do the tunnel offsets match the outer headers in the frame?
> + * The L3 header the tunnel claims must be the one the frame
> + * carries, with UDP following it at @outer_th.
> + */
> +static inline bool
> +virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
> +			  unsigned int outer_th)
> +{
> +	int nhoff;
> +	__be16 proto;
> +	unsigned int thoff;
> +	int ip_proto;
> +
> +	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> +		return false;
> +	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> +		return false;
> +	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> +		return false;
> +
> +	return ip_proto == IPPROTO_UDP && outer_th == thoff;
> +}
> +
>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> @@ -338,6 +504,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	if (ret)
>  		return ret;
>  
> +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +		return -EINVAL;
> +
>  	/* In case of USO, the inner protocol is still unknown and
>  	 * `inner_isv6` is just a guess, additional parsing is needed.
>  	 * The previous validation ensures that accessing an ipv4 inner
> -- 
> 2.53.0

