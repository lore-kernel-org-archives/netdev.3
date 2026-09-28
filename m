Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA83148D2
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559085; cv=none; b=DVaQ2iyCH/hF7P+6i17FRcycR0VwW3q3voGL5ZWmKbRcnN2xoLgJKdfcMJ/PbP1BZ4DkMFe9vUhz0rn9JNCljXgYJFe3t0sEgHHGdxQmYesg7XzyuM+l0AJtlZJB9d6+SaTrvD3aHvtzKcM9rUKTXGQLyVuKDXszDq2ZhNx9Qdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559085; c=relaxed/simple;
	bh=VEBx5m+ML8407G19GDAgsFHyAVNqgYgB+zy6MAoSrEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuRfftI4jih8Keno/CmOknwBT5Rfhsvp9iofIDJ85+1t+WXePgygdK06eqwA8n7ch22wwEPJovyKbVlOewKzfdRoLRtN0FKhr5spCROMrOT+RxlXcJVSRkzWCJ6MXbqlpCQHJuVpTLZPJ1dL6kOitaxiRruIEF3RHFU4uWzxt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbPcqmuk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNivYQtn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbPcqmuk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNivYQtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790559082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rJb7ejVo7TKKs46NUFdGnvEpPv9QXIZVqUUekYCSI7o=;
	b=DbPcqmukqphcdeM3K/YmI9//2+yCzyBqVff/rAQ01YK1yP/MDUmVFvdOZzlj3oqQbQPHOx
	7fs+ViHGtUXdc8m5sKtfqopJbESx/GJAKkfCYFmez2slShtOIaWLejpCiPLVnmkjAA8Gqf
	w7stcGYH6ZoHx+VxxFI+x/1wJrdRKl4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-7b1t-OXjO7eqw2xekrpl9A-1; Sun, 27 Sep 2026 21:31:20 -0400
X-MC-Unique: 7b1t-OXjO7eqw2xekrpl9A-1
X-Mimecast-MFC-AGG-ID: 7b1t-OXjO7eqw2xekrpl9A_1790559079
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0053eb950so2067335e9.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 18:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790559079; x=1791163879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rJb7ejVo7TKKs46NUFdGnvEpPv9QXIZVqUUekYCSI7o=;
        b=TNivYQtns1gGSEETUA9f52j0Scgs3YRHmokxqizR4+8Mm/jKq0NBjWI/PNiDMp4hlJ
         d3QoAZCy85ZRv/7x/zzr+QFQ+J4Nq5fmFWSe/XuP3eQkEXsxCyG8Mzv9UOBPo5eihOsH
         c/OUFJCM3EZGnDh4AuyEXJAdyXSzaTwRq0lG2cItO2tAJXj9J/JjINtQYtw+3ezE8dNp
         cY+Wn8Exu1bgIXzFqoYi8QjLUvBnDxdxf44VW6OxznhGuiAl8GXZ0qznhq7UcQ1vd1zn
         IDMsle6ZIrvoOjSM0TmjeWo8PtgdwIOaAtjYB2JmNY7609F529ECGLDPlH7CsMPiNAC7
         mM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790559079; x=1791163879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJb7ejVo7TKKs46NUFdGnvEpPv9QXIZVqUUekYCSI7o=;
        b=liDFn/uW1AboVDDBuKdLXQJTtetPqrWMd6GSZjH6epM9oaT6BhoBwkfMWFbzLCL8xw
         v+a0uyLTIGEsE1zRfNk2clPAUzuIHlb/P38OBWT9Q1t+bE0q+fc1SLatag4UxqoKQQAH
         ullPnyUV64jPEr0u9iz1l+LD3msQWgIL+YPfOxoTe+DT4zJVsZVa/G0DYZ9o5AAyY0pQ
         kIIf/O8drI/u83Dnswic/BjdTTgAGPYxUMHfNbAVjpwws1vfxN/kIxw1GT+vx36DweOJ
         N1PoDV10KBGHpwd8ToyjKK5ju9TKnYlRMb3omFDRm7VRuYfULaz5jq+EJXDjG+Hf8JmM
         ownw==
X-Forwarded-Encrypted: i=1; AKwUvBz9VQOJkCc87FgrbDX6k67TjUEzXk+joq2nw/G4/HiW8WGvLFZeYazcXY3sS6f50CwJfnIdfpQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kjy1ZyjkIDR9rPC9G2yAuxIkIVnO/03BaPw4nL6PnZldHo0c9O
	xuSoq8zELKHnQ2/3LhALH81e4NZ7Em2kCDvoTjlWQU+4yNeMK+8c5CW3Yy/lUTOcbVD7aEJFI83
	wRw6/KU4aSXmAaEuqKwH76CxuwGKXw/tmUVq9nAW8r9qPjSL5rXM2TAiSkg==
X-Gm-Gg: AYBFou0FETT+c4dY91rPMDA91gvT1qXxycmX/I9kPYIhFjBUthOYO9PznzeQtH00VaG
	/xesulKTDvUHEEZHfRRgSexHNgCX2swQ6l2duDzxmWZYTEeHm7Skv/UZcbglsDQ9kEqXswlZ+gV
	cL9B1MmxkxMMnz6bn4w2U+m1fK8cm2fAIH4EggGLfnHy+y1CBB+0B9MtHlFTWGlBaJK9z4DH/my
	anYAC58fE9673kr22UV7AMZojLvV9BMwrI5WdhcgJhy7615cMzitX+njJ40r6paEyF5KjdJo9E3
	A2VBcX31caS/6SpLy1mX/iwO9FL9aVJ6sGL+s80k1Mbmi5Kzi812YkHJxyK7OERjOkOqUKbYeBB
	gyPsSQz5eqTgl392QhtTjqLEMJuES6a9Ud0OQxaVwSEYwBm59fIgdgbGz8RJRsnwDVg==
X-Received: by 2002:a05:600c:8719:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49fe66c6373mr221300815e9.10.1790559079393;
        Sun, 27 Sep 2026 18:31:19 -0700 (PDT)
X-Received: by 2002:a05:600c:8719:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49fe66c6373mr221300575e9.10.1790559078885;
        Sun, 27 Sep 2026 18:31:18 -0700 (PDT)
Received: from redhat.com (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk. [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a007be0761sm893375e9.3.2026.09.27.18.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:31:17 -0700 (PDT)
Date: Sun, 27 Sep 2026 21:31:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	edumazet@kernel.org, Weiming Shi <bestswngs@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] net: always dissect GSO packets in
 __virtio_net_hdr_to_skb()
Message-ID: <20260927212942-mutt-send-email-mst@kernel.org>
References: <20260927195536.2489079-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927195536.2489079-1-edumazet@google.com>

On Sun, Sep 27, 2026 at 07:55:36PM +0000, Eric Dumazet wrote:
> Commit 9e8db5913264 ("net: avoid false positives in untrusted gso
> validation") added a '&& skb->network_header' check before flow-dissecting
> GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM in
> __virtio_net_hdr_to_skb(), because some callers (such as tun_get_user(),
> tun_xdp_one(), virtnet_receive_done(), and raw_verify_header()) called
> virtio_net_hdr_*_to_skb() before initializing skb->network_header and
> skb->dev.
> 
> However, skb->network_header is an offset from skb->head, not a boolean
> flag. When skb_headroom(skb) is 0 on a device without L2 headers (for
> instance packet_snd() or tpacket_snd() on a tunnel/pure-L3 device where
> LL_RESERVED_SPACE_EX(dev, 0) == 0),

Hmm. I have:

LL_RESERVED_SPACE_EX(dev, 0) 
        ((((hlen) + READ_ONCE((dev)->needed_headroom)) \
          & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)

#define HH_DATA_MOD     16

So how can LL_RESERVED_SPACE_EX(dev, 0) == 0 ?


> skb_reset_network_header(skb)
> legitimately sets skb->network_header to 0.
> 
> Whenever the 'if (gso_type && skb->network_header)' branch was skipped,
> the fallback 'else if (gso_type)' only pulled nh_min_len + thlen (40 bytes
> for TCPv4) without dissecting the packet, without validating ip_proto or
> n_proto, and without setting skb->transport_header. If an IPv4 packet
> carries IP options (ihl > 5, up to 60 bytes) or an IPv6 packet carries
> extension headers, pulling only nh_min_len + thlen leaves the TCP header
> outside skb->head, causing tcp_hdrlen(skb) in skb_gso_transport_seglen()
> to read out-of-bounds:
> 
>   BUG: KASAN: slab-out-of-bounds in skb_gso_transport_seglen+0x173/0x200 net/core/skbuff.c:5503
>   Read of size 1 at addr ffff888103c7ec4d by task repro/5718
>   Call Trace:
>    <TASK>
>    skb_gso_transport_seglen+0x173/0x200 net/core/skbuff.c:5503
>    skb_gso_network_seglen include/linux/skbuff.h:4718 [inline]
>    skb_gso_validate_network_len+0x92/0x1a0 net/core/skbuff.c:5566
>    ip_finish_output_gso net/ipv4/ip_output.c:285 [inline]
>    __ip_finish_output+0x28b/0x4a0 net/ipv4/ip_output.c:316
> 
> In addition, when skb->protocol is pre-set by a caller before
> __virtio_net_hdr_to_skb(), 'if (!skb->protocol)' is skipped and
> virtio_net_hdr_match_proto() was not checked.
> 
> Fix this by:
> 1. Initializing skb->dev and skb->network_header (plus skb->protocol for
>    IFF_TUN) before virtio_net_hdr_*_to_skb() in tun_get_user(),
>    tun_xdp_one(), virtnet_receive_done(), and raw_verify_header().
> 2. Removing '&& skb->network_header' and the unvalidated
>    'else if (gso_type)' fallback in __virtio_net_hdr_to_skb() so all GSO
>    packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are flow-dissected, have
>    their transport header pulled into linear data, and have
>    skb->transport_header set.
> 3. Validating virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type)
>    after skb_flow_dissect_flow_keys_basic().
> 
> Fixes: 9e8db5913264 ("net: avoid false positives in untrusted gso validation")
> Fixes: d5be7f632bad ("net: validate untrusted gso packets without csum offload")
> Fixes: 924a9bc362a5 ("net: check if protocol extracted by virtio_net_hdr_set_proto is correct")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260927163117.746432-2-bestswngs@gmail.com/
> Assisted-by: LLM
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/um/drivers/vector_transports.c |  1 +
>  drivers/net/tun.c                   | 23 ++++++----
>  drivers/net/virtio_net.c            |  2 +
>  include/linux/virtio_net.h          | 66 ++++++++++++++---------------
>  4 files changed, 48 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index ddd127ee96785daa4c485b2a06f078686efd2046..e1fb2a76fdff59ef3032d091be06a06fa58046cc 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -209,6 +209,7 @@ static int raw_verify_header(
>  	if ((vheader->flags & VIRTIO_NET_HDR_F_DATA_VALID) > 0)
>  		return 1;
>  
> +	skb_set_network_header(skb, ETH_HLEN);
>  	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
>  	return 0;
>  }
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68aa3308b0c850b4a2957df3260b352..242899f7fd0711c5c59ff85accbf5bd1be9c6f39 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1897,12 +1897,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		}
>  	}
>  
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> -		atomic_long_inc(&tun->rx_frame_errors);
> -		err = -EINVAL;
> -		goto free_skb;
> -	}
> -
> +	skb->dev = tun->dev;
>  	switch (tun->flags & TUN_TYPE_MASK) {
>  	case IFF_TUN:
>  		if (tun->flags & IFF_NO_PI) {
> @@ -1927,9 +1922,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			}
>  		}
>  
> -		skb_reset_mac_header(skb);
> +		skb_reset_network_header(skb);
>  		skb->protocol = pi.proto;
> -		skb->dev = tun->dev;
>  		break;
>  	case IFF_TAP:
>  		if (!pskb_may_pull(skb, ETH_HLEN)) {
> @@ -1937,10 +1931,19 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			drop_reason = SKB_DROP_REASON_HDR_TRUNC;
>  			goto drop;
>  		}
> -		skb->protocol = eth_type_trans(skb, tun->dev);
> +		skb_set_network_header(skb, ETH_HLEN);
>  		break;
>  	}
>  
> +	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> +		atomic_long_inc(&tun->rx_frame_errors);
> +		err = -EINVAL;
> +		goto free_skb;
> +	}
> +
> +	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
> +		skb->protocol = eth_type_trans(skb, tun->dev);
> +
>  	/* copy skb_ubuf_info for callback when skb has no error */
>  	if (zerocopy) {
>  		skb_zcopy_init(skb, msg_control);
> @@ -2600,6 +2603,8 @@ static int tun_xdp_one(struct tun_struct *tun,
>  
>  	features = tun_vnet_hdr_guest_features(READ_ONCE(tun->vnet_hdr_sz));
>  	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
> +	skb->dev = tun->dev;
> +	skb_set_network_header(skb, ETH_HLEN);
>  	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		kfree_skb(skb);
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index bf82ef9874abb4094931496fb6064a12ee75b789..daab43ac92ce4276b0f8f88684991e3993022ce6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2515,6 +2515,8 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
>  		goto frame_err;
>  	}
>  
> +	skb->dev = dev;
> +	skb_set_network_header(skb, ETH_HLEN);
>  	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
>  				      vi->rx_tnl_csum,
>  				      virtio_is_little_endian(vi->vdev))) {
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index c381b916c1b54afacba5473888af589a24fe087c..8902d5a5c418c46af0a6e7b26ae89948c20b0b54 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -111,48 +111,44 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		p_off = nh_min_len + thlen;
>  		if (!pskb_may_pull(skb, p_off))
>  			return -EINVAL;
> -	} else {
> +	} else if (gso_type) {
>  		/* gso packets without NEEDS_CSUM do not set transport_offset.
>  		 * probe and drop if does not match one of the above types.
>  		 */
> -		if (gso_type && skb->network_header) {
> -			struct flow_keys_basic keys;
> -
> -			if (!skb->protocol) {
> -				__be16 protocol = dev_parse_header_protocol(skb);
> -
> -				if (!protocol)
> -					virtio_net_hdr_set_proto(skb, hdr);
> -				else if (!virtio_net_hdr_match_proto(protocol,
> -								 hdr_gso_type))
> -					return -EINVAL;
> -				else
> -					skb->protocol = protocol;
> -			}
> -retry:
> -			if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
> -							      NULL, 0, 0, 0,
> -							      0)) {
> -				/* UFO does not specify ipv4 or 6: try both */
> -				if (gso_type & SKB_GSO_UDP &&
> -				    skb->protocol == htons(ETH_P_IP)) {
> -					skb->protocol = htons(ETH_P_IPV6);
> -					goto retry;
> -				}
> -				return -EINVAL;
> -			}
> +		struct flow_keys_basic keys;
>  
> -			p_off = keys.control.thoff + thlen;
> -			if (!pskb_may_pull(skb, p_off) ||
> -			    keys.basic.ip_proto != ip_proto)
> -				return -EINVAL;
> +		if (!skb->protocol) {
> +			__be16 protocol = dev_parse_header_protocol(skb);
>  
> -			skb_set_transport_header(skb, keys.control.thoff);
> -		} else if (gso_type) {
> -			p_off = nh_min_len + thlen;
> -			if (!pskb_may_pull(skb, p_off))
> +			if (!protocol)
> +				virtio_net_hdr_set_proto(skb, hdr);
> +			else if (!virtio_net_hdr_match_proto(protocol,
> +							     hdr_gso_type))
>  				return -EINVAL;
> +			else
> +				skb->protocol = protocol;
>  		}
> +retry:
> +		if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
> +						      NULL, 0, 0, 0,
> +						      0)) {
> +			/* UFO does not specify ipv4 or 6: try both */
> +			if (gso_type & SKB_GSO_UDP &&
> +			    skb->protocol == htons(ETH_P_IP)) {
> +				skb->protocol = htons(ETH_P_IPV6);
> +				goto retry;
> +			}
> +			return -EINVAL;
> +		}
> +
> +		p_off = keys.control.thoff + thlen;
> +		if (!pskb_may_pull(skb, p_off) ||
> +		    keys.basic.ip_proto != ip_proto ||
> +		    !virtio_net_hdr_match_proto(keys.basic.n_proto,
> +						hdr_gso_type))
> +			return -EINVAL;
> +
> +		skb_set_transport_header(skb, keys.control.thoff);
>  	}
>  
>  	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog

