Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DCC2DFA3A
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541219; cv=none; b=CdwZmmysltW6LjCuAMPNeFxlihBInBBjov6jkWgNwWyKN9W+J8AHxH2Sye15dxUBGf24CyUJFfZZCSuDvA0AXYoSZXRdmZYUm/8f54FatgOIv8TnR9TBAF7xJkUfNLTPvtJH3b3rSoVXs6smjNNwuBHxQneK5jVvuatPc+vKDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541219; c=relaxed/simple;
	bh=EdrRhRbGz4vcK0+ZzJABZLkqNgsxtIa6LE5BexlR1Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iblYk8uWI2xZBjumXXgoe5bdYKwtefXoXJXkgpOD6ApIXzZ1FGO8j9d5IpEKzmcprUvMevEQmsxo1+/sLQ458pMVP7IMpGoOA13sEGqxERX9Vy1KkOyQEwqpa8/lnWNDu61T6gqBeJ1occ6TCjAQb8WTBkOhG7FdLUtmal+oOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEh711Ug; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKYduRfQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEh711Ug";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKYduRfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790541215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z7+9ha8qRIkil3dyXXFMQiCYT96N0PYGVy3du4aK/RY=;
	b=WEh711UgsQVpAEzLoemQg1F0a4DqcCLLgOWwnk1YZyCj3Mzj29UsfM8b8GltDnNknH2DM+
	an2wp8ScWbbO2IRkW0foVj1tGKK6YIOttWM0HYRS3rcUVuOvKrPCtBhMvpCQNv5RGbkGki
	lg7I94uVHoGCWALzH+8sB/7vb4jaC+0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-yga46ip7P1WNhG8vEz3Bow-1; Sun, 27 Sep 2026 16:33:32 -0400
X-MC-Unique: yga46ip7P1WNhG8vEz3Bow-1
X-Mimecast-MFC-AGG-ID: yga46ip7P1WNhG8vEz3Bow_1790541211
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-487038a4a88so1356855f8f.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790541211; x=1791146011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z7+9ha8qRIkil3dyXXFMQiCYT96N0PYGVy3du4aK/RY=;
        b=LKYduRfQXiALyGxIMX9Z/ZAa/J87zA0sH+ufxxh2mvffXfBXGc5WIOtQ/7PHBsfGhq
         wwL6HMtrMaQUmeWI40bo8aB/zWs8x+Nx+NgWl3S7kVMc7u6tSrqMmwtnY1PVYIBojTuV
         ISSBoD4MbjnJyvOg5UnHbr7WVzBgkCRDP7Glrae61IItZzMRUnojnWmOmLgyggAOThBW
         BzpvNAtqRBp4o8RiuUZKWZ0ZXxwMFMyurrv5QjO9lv5YTZKINp6XC/BWHbSbtR4Ox4a2
         xnuG/5a20FoRRB09GlONLhhH+b0bzvZFfHC7XWavCAtKF35SskvXU5Hyr6AVyaiChUFV
         Rkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790541211; x=1791146011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7+9ha8qRIkil3dyXXFMQiCYT96N0PYGVy3du4aK/RY=;
        b=FfQ3CojBoXMjtx7UlGRUSxczP3zU5/mM6jSxA2s2xQinlv/xTq8gGeHiU4l6K19ilE
         y1myOJo+FfewAI3M/3wFf6hSGy1EyLclp8yYwFg6CDpR/83x77JuHncKN4YM+NthrrWo
         lO3q40NssRO0Xg05r/xTjGW9zPm5gYQYa06XWcQdqsNlR1qz3lLu8FUu63vB45+DwXGe
         +ePrLxPyuVr5vH4lBsOmkBZgsmbZ4VEsiQN0WSz4YhgtVZMB3rJj7FkMnzFgmKjKhYVC
         yak3GW4/fyf062HIOmb4iZ3oSA6fkcRT/9TWSHzfoDzj1z8TrmP99s6Gk9EPHDpmqa6O
         85tg==
X-Forwarded-Encrypted: i=1; AKwUvByqg7DhU2iKKMtvt2M8JKIkyCwWfhnxSL7cpobAdrbRedF0ukxgtHDbJ4pyvJyESZdqjDBtom4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKA7wLFCeCQYdsvFOvXv+co4du1P7Mctky/ZT3IrcMzO7d1mrE4
	UH9IFQvr37YWqLaqHS1kMM6wgFQmocN6UcQ54jQxK8o/F7sXpkO6/P4UXE7Qrb6wq/VTKu59P9y
	0qveMrUO5ZxY4KoKTY9S7xqryWgXV0YYuN97qI3d+V82fGrGFtZvkt4A8zQ==
X-Gm-Gg: AYBFou35sFOxpuS+CqP4rdIkuQZ5e0vdS4flZeikxP7HkAQFW5qJ3WMQz7nyh47XQrU
	HCr9fgUVXcL4VWRbsEGvl8lx+RpMAs1JPoZVcizwkq6grIFhW/+j7GKVrXRUbwI5rSm3ty3a5Fd
	RAxULjVKd4G65RKUOYrZQJ+JlCLMPBamd/u/pnz1wRVV60m7dCjBxZDO6DUNxLWipPramRZZA1p
	RJFLJxd6dQRU9SWo8lzrF6gxmUhg6OEmwvnGrGanmtD0mpG4clITNjwZ6Ldxm3+4o+DtT1FVnk9
	yveSmzwAfffCvHDKwWoVweFLkPSyaApsywvJRn3AGnLDeZkos+szwSqnVeu9eBjUKn0o3rB4fI1
	R3Z9+6V79UHQaGJ8zowMByGBU8Bqt9bnVKobOt90Vg8FGQMrleHBj+MHrzFkDD0qWjg==
X-Received: by 2002:a05:6000:3c4:b0:487:8ba:8aa4 with SMTP id ffacd0b85a97d-4887169fae2mr22047640f8f.38.1790541210950;
        Sun, 27 Sep 2026 13:33:30 -0700 (PDT)
X-Received: by 2002:a05:6000:3c4:b0:487:8ba:8aa4 with SMTP id ffacd0b85a97d-4887169fae2mr22047616f8f.38.1790541210438;
        Sun, 27 Sep 2026 13:33:30 -0700 (PDT)
Received: from redhat.com (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk. [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349fa1sm32485374f8f.8.2026.09.27.13.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:33:29 -0700 (PDT)
Date: Sun, 27 Sep 2026 16:33:27 -0400
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
Message-ID: <20260927160750-mutt-send-email-mst@kernel.org>
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
> LL_RESERVED_SPACE_EX(dev, 0) == 0), skb_reset_network_header(skb)
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


Could you explain why is this being removed?
What sets the mac header then?
Thanks!


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

