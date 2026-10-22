Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712341;
	b=Ncz7gu9StUJC36As3di1tpMMwx/hJTP7cNQSDuwaRAthfbgsDY5tOEnqbbRaiQv2hw5F
	 W4A2S+19PaVLAsuHT9aGllV7JbheLv9rDwFS6wdj4cLmFa/NQtXu0OwEbLsLb0efW/+4u
	 FaXCarX5F9+YrkX8FFDDcQ3m186geuHD9TlzRTRas/O3bLmRTPBxrJJCkx7X3sNGOHnum
	 zmsjGe07lL+P5zbEmSb4G6xXfluGShOpvYdgHvGlvT80uzx2q3M8JnDHpAmsxbqquVj2i
	 HbQoUATzcCchjjiIURPP/5bcYHobA12atVUr3D+xztPuCs6DjwjbqyOuXe9277SOaMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712341;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Nqaq+KGmgq+7t4ixqZSLUjFN4QjJmmGs/RCocqmgwTQ=;
	b=fkDciLCSbiZoOhuxIEOg6+L/ThV+4mY610uraGey/SPuFoQeWcsDQdr9+L77amkw+qsi
	 fgm/+oMhH6rD8NkrkFAdjFhGOfd8+PaumhbSfwNfljoyeqGImHBl9N/Q6iOJuOm6/XAKe
	 DxPdendf3z3yQghq5hms/VyL/owLELVsu6303+xdRGe6jocoma3qhsa18xTztxGirNhH5
	 GtJjrISZ25S/0ZBVT9kBgtYhmFiBn+UmL5cVO3E/1ligUMFXm+VGp2NKP3rOG/dCz4lXC
	 Up6cXwF6wfRqQ3rYUvAT2s/S4hrjEQSr8O+kkFwmquQX/bs2papYkubMBkX4PmyeZ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fnqsRThz;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="h5T/yWrg";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4B606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 23:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BD4B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fnqsRThz;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=h5T/yWrg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792712340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nqaq+KGmgq+7t4ixqZSLUjFN4QjJmmGs/RCocqmgwTQ=;
	b=fnqsRThz9vxDV5ZsV6Ix4ml+uRyXI9Igbef+PSp/B8dHyIa0I0SzOjnhZIQ1D3JT+1SXu7
	zDnQlS+xSB6SvuMLMPDFlNEzQRfVWfKvblQQJ41r9dfhni+X4JknD0GsHZezpGfwMBssIQ
	3OZEOjd+l5mTr2AZfykPB9RG48V2YZo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-8fO_YYI-PL6bArsIdn4y-Q-1; Thu, 22 Oct 2026 19:38:58 -0400
X-MC-Unique: 8fO_YYI-PL6bArsIdn4y-Q-1
X-Mimecast-MFC-AGG-ID: 8fO_YYI-PL6bArsIdn4y-Q_1792712338
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a208f409ceso1435415e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792712337; x=1793317137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nqaq+KGmgq+7t4ixqZSLUjFN4QjJmmGs/RCocqmgwTQ=;
        b=h5T/yWrg0r0GPks25qnD0SyfNo3HEgZC79cvuuTP6lbU1oSmnbqekgfCsM8CsUnX+U
         8RwmK0Ckd/kHXT8P8WCHefOtaMbF4LWwyXoGhr9dr1prXxrQkKwc+07Q2VGcUtEAZhDo
         TpF+S6hF1iR3bNq6p6JxC+IJKdgwdyFAUtmSFDOrkFc6ngL7n7m1HmgF2sI+b7e/R9Yv
         uy4cbPFb8f2mh2vrfJNqgYeudUzHKnGX5oGxmB2TpqyzpEcGsT/DgZxCexxLN7uWkDxb
         pwNXlfITD4f6TfHZ8Npit2ywRDgwEiOgccypkowTuqifqrhU8GGTEf5bRBr/nGs4jTNO
         5vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792712337; x=1793317137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nqaq+KGmgq+7t4ixqZSLUjFN4QjJmmGs/RCocqmgwTQ=;
        b=M2A4TEj9BC7IkE+eKGJb24jw5BCwDJmzovAOqPwDRwzT1YMgXDkwNk+k5I3tcB4c97
         6vtWlHTF617Y6D9RtfVZMba9Otx0y7AMUa0bRfufe/HcaGRHb6W8GWeYZqgTzqIciyOv
         9ZVTLJeUeNok+maLaOCbby5Kx9EnOJ4Y+tQjB/24SB+Cvt2bL7WXA2vlvp/Y0uA492En
         ptvTzvlA1aU+UCCFfklXRnOKR5OE8glHazK2w9ANMvj24JcOjcK/katN6fVHHqra+Ga5
         K2A/3/jsTUtPC/Siz+TOndQd/JGeY6wms9QwMpSY/M+3HUHxbtEbwmHDjiLe2tk3f4+c
         TvDg==
X-Forwarded-Encrypted: i=1; AKwUvBz/H8sFyLfkPg29utbdTeXiGzgR2LsxiNpawV0yrFiXyS8D5u7YuUjGDNISYooC1U1ShdtWHE4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYV8V0EjweC4fZVgnCUtDzBrV9DCTKFEr9p8rHsTMXQBTre8hH
	XUELC1/QXJrs58RdXrwRyLqm9wW/AN5iOLcwuxx8NoJmf2K1qy5LPUyjx/vBA8/OEJVa22rarRU
	MZjIx9iEdzoOJXbsEXKnb0XYcrwu22OCWo9ndtmA1QbRxMN5RWRo6ot7LYg==
X-Gm-Gg: AYBFou2rAJlikuEPrAKvFOHv4gHLLkzk+v5PvUixH7NOQWOdGxHPH3KQ9GboKqovODQ
	APEVYsbvUeahxrVWILkrqaPij77ZwcFhKUX1H2FvNP3ngvYz/8kKJFlasnAChz3r+caYD6hal5T
	AnOHQowpTSyfQPZwhFtT1Ax3oaa+e5LGNOr525uHx3Qsx8KCk0KdY+kjFHKWi2tBZvybCcf/X37
	xK7BEYiEoapn6lQaXItEVc+zH0R9Nmq8fHW4aTf1Ws6SmnS5Y04N+Jl46h7xdtXo4G8s7bkyoM4
	vSJvw7p1Lr5HBi1Zpm0rtpbYt7fMCBLz0QmRVwf4zYZjNNMo6kQVHSAbLMaO0EeA36gO0YU=
X-Received: by 2002:a05:600c:350e:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4a211c7fb6bmr9087265e9.4.1792712337443;
        Thu, 22 Oct 2026 16:38:57 -0700 (PDT)
X-Received: by 2002:a05:600c:350e:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4a211c7fb6bmr9087035e9.4.1792712337018;
        Thu, 22 Oct 2026 16:38:57 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210473567sm30620015e9.12.2026.10.22.16.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 16:38:56 -0700 (PDT)
Date: Thu, 22 Oct 2026 19:38:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chris Arges <carges@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net v5 4/7] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261022193052-mutt-send-email-mst@kernel.org>
References: <cover.v5.git.mst@redhat.com>
 <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
 <willemdebruijn.kernel.2987fc5710162@gmail.com>
 <atpIiwcUlH5ttBb6@20HS2G4>
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
In-Reply-To: <atpIiwcUlH5ttBb6@20HS2G4>

On Thu, Oct 22, 2026 at 12:52:36PM -0500, Chris Arges wrote:
> > > @@ -335,9 +592,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >  	/* Let the basic parsing deal with plain GSO features. */
> > >  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
> > >  				      hdr->gso_type & ~gso_tunnel_type);
> > > -	if (ret)
> > > +	if (ret < 0)
> > >  		return ret;
> > >  
> 
> One other case I found in testing is that a producer can set gso_size
> larger than the remaining packet data. __virtio_net_hdr_to_skb() then
> succeeds, but intentionally does not install GSO state because the packet
> is too small to segment. NEEDS_CSUM has still left the skb with
> CHECKSUM_PARTIAL.

So why is this a problem? If checksum offset is correct we leave
packet as CHECKSUM_PARTIAL. That's intentional.
What does your test do that makes this a problem?

> The following check fixes my test case:
> 
> 	if (!virtio_net_hdr_validate_disabled(skb) &&
> 	    !skb_is_gso(skb))
> 		return -EINVAL;
> 
> A concern I have is this may reject valid packets, so maybe there's a better
> place for this.


Indeed, it's not uncommon to have small packets with !gso.

See also:
commit 7c6d2ecbda83150b2036a2b36b21381ad4667762
    net: be more gentle about silly gso requests coming from user
    


> 
> > > +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> > > +		return -EINVAL;
> > > +
> > >  	/* In case of USO, the inner protocol is still unknown and
> > >  	 * `inner_isv6` is just a guess, additional parsing is needed.
> > >  	 * The previous validation ensures that accessing an ipv4 inner
> > > @@ -353,7 +613,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >  	}
> > >  
> > >  	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> > > -						 htons(ETH_P_IP));
> > > +			    htons(ETH_P_IP));
> > >  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> > >  		if (!tnl_csum_negotiated)
> > >  			return -EINVAL;
> > > @@ -368,7 +628,22 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
> > >  	skb->transport_header = outer_th + skb_headroom(skb);
> > >  	skb->encapsulation = 1;
> > > -	return 0;
> > > +
> > > +	if (!skb_is_gso(skb))
> > > +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> > > +					       SKB_GSO_UDP_TUNNEL);
> > > +
> > > +	/*
> > > +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> > > +	 * set CHECKSUM_PARTIAL.
> > > +	 */
> > > +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> > 
> > on second thought, if having to respin, might as well fold the trivial
> > fix in patch 7 in here from the start.
> > 
> > > +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > +						 inner_proto))
> > > +		return 0;
> > > +
> > > +	/* A tunnel header implies GSO, so drop. */
> > 
> > no longer true for the above !skb_is_gso(skb) case
> >
> 
> virtio_net_csum_partial_ok_at_offset()

Sorry I don't get what you are saying.

>  
> > > +	return __virtio_net_resolve_csum_partial_mismatch(skb);
> > >  }
> > >  
> > >  /* Checksum-related fields validation for the driver */
> > > -- 
> > > MST
> > > 
> > 
> > 

