Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792719489;
	b=QE4/p9F2Rfsk6pIVUZmDEzjQ+sXqF+Vbr+y3kB5ncevHcjSrW8iMwLcE/Vao6mres0SC
	 LdKNx/f4Of2cxiwnm6xTomlWWQlLr2qbW/evZbKaGBiwa3XMTia5qi/tqKp22TR0n53Tz
	 tQbm+DTPm6QoGifvJuuVbFzwWXBY5ywwrsGhFnfNggxFI7XDXH+k8TwaWZw0EuQI+awzo
	 w76VnX9Bxc/tvR1ombcqzXilhCe8pg9y548xynCboe5FxL7/HfMdwPykVVpsK1pi2T10B
	 B+zkyCsR2upuAUTFK2rj7IMVEq3oTUkpUscPvoWO7F3Cs4QYeUfJ/Qk9w/V2v1QWI4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792719489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VyS6G3Kx6WPq1nBIZXm3hw0RmZ6T3d+8BhWqtGP+Tt4=;
	b=TBEO+6ngPc+QWAw/xKjYS5LQNBRcPmXzg7nupvTZdMEdIKSPI3BEB2QgD/+ChYxkODjm
	 LJxN/YGHKTs1KlykphXTcLIquKsGv1YLPtvbY0F6xN4Fk85X0oq0Cgw6ZXncONnme2QR0
	 NvkEgypOUGU/R8VsVUabKErwaRiwuZVTyGVTFxr66KN/GubAF6KH3jw2H0BAXZbEAbY3F
	 GtJ1Lo3zNf+3oFN6seepYvs4X87IcXahTjocI0b3JCQqz5DvbRwonOvshctZAJcEh8Mzk
	 l1drbcuQaUDaTZKZ7tKifyAMGSVr0a9TAbQT+cxKP4KoTpR0D0TFnSuUVpUgcZPLsoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NS4IRFub;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B09606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B09606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NS4IRFub
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-8256106635eso192489a34.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792719487; x=1793324287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VyS6G3Kx6WPq1nBIZXm3hw0RmZ6T3d+8BhWqtGP+Tt4=;
        b=NS4IRFubSNO2j9Y1WVfgO6Awpo3hnuCUulnPg4eByIxHDtOwxZOdWL4UoKe1Adbhp4
         xCnMZ5IuP/e9cEYfwwR5qi+85GwzSDYRfb7FHzEkqxC1SaasJk01AezXkpJCr0++wswi
         QsHVXluMi9q3rz+c0KuCyFS5VP4sFSUY/S/WaUDqGacY7dbnytqOIFRZ/O8WAa4En9Ez
         CwnxTZk9XNb2DV6ApTf+KT1MyysDlqIHsizc4zrngtmjpWuvPI2z0WP/1HFToV1qH+5v
         ml0Iq6VBpUD9Mp6+GsXfBJsq3NZkpQfVMg3h8O3J2wMpj4PHzcU1YR4pqPcy2QWu6qXy
         YqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792719487; x=1793324287;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VyS6G3Kx6WPq1nBIZXm3hw0RmZ6T3d+8BhWqtGP+Tt4=;
        b=u/ZWMGBOAoh57JwJHzewVV4porJcwOmcszmZX5vKdZ/tFIWvNSpbOmmH9Aw9PG5A4Q
         4btRsqWx6AyaAJdOgXhvo1gMEv82JGTI/PoQjisqr3AJqATLnKlUrIaRkTXYPDIJxZty
         jkRI0GSBhOeC7G2PM0KEJROGbFlQtUCDvmrSONMlK/3yLl21tcuB+pXgtZn7+gP/A/Lm
         y8OQ5xBjBSnTL8dCMkz1GKGaYLNJpG9qU3wGc4OWpoTKtqCyO9I6qag5lkrAqoR7A60m
         qeo4Zu/7qHxQvBI8MsvewVLPp+/elKZULJHRd8i2quZzvYON2610yLowHS8r01nRWFK/
         lluQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsDM7KFvxPUnrz2ZY2V55HadikKgJFoaIqks7uy4Ib8ZCYwYQd8HvVi1ChVBornQnMnJ2d6YM=@vger.kernel.org
X-Gm-Message-State: AFq9FYINuPk52ztjdrWKe4weNTImoF18TIcXqsiDbII213TFRS1otBLr
	9RppIi7tBEUBTzeBxssT3k63LuF6eT5NMwsTrD99ReGvUppzFfe7coF1GG+GgZRXr7k=
X-Gm-Gg: AYBFou3uishiE2dxUge+STq1JMmjlH1kIUTUh9U/9Xf04brdvIA1DcL+XgUXnsMBazP
	Dt8QPfepKHoujvmJqIIwmOBjN7TijNBTk5mW8XKnJA4VjBmdrQoFKcSRj53SGDgNgBARcbDFQW8
	aQaFX1gaKr3kigUs0UXfJH3Gm9oOkXmR6dMSlXz/Wssm7n93IKVEH2cCh1iyhB1SCAulPo0TPaW
	HcyAX/3h6iAwoaWlSjRfSAB3XDGOLgLQmWB3L8hP5v4XIc5OvfK2/MvgFGeAf1B5K81KYIugT0M
	J/lYl8ldesK8QyUCcwA9NJQA7VS9GdFIz20lZBIpO1jztXWY2g1oNLx01pHqkZxRAWvCXuUym56
	yPYlxJqq0SYHAvUX+HraUxYBh7yQHy1OHOvkjFhGNZWD64c8pMqZRSWdWZuZXspJOL+MwD0Q8MW
	fCezrrarAyNIdoQGTcqHkS+8vbsrmlqWfmoCho0oWEAtneA/A5zv6vKKKiHrn3xgEpMVB1J9t8E
	mTFqsl0wbpI3GqXxKYLT3OHBwuzy6n2xVc=
X-Received: by 2002:a05:6830:4412:b0:7eb:9464:ac2e with SMTP id 46e09a7af769-84fb0d542femr668994a34.11.1792719487276;
        Thu, 22 Oct 2026 18:38:07 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:96::f:3b8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84fbdf59d82sm770666a34.15.2026.10.22.18.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:38:05 -0700 (PDT)
Date: Thu, 22 Oct 2026 20:38:03 -0500
From: Chris Arges <carges@cloudflare.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Max Krasnyansky <maxk@qualcomm.com>, Rusty Russell <rusty@rustcorp.com.au>, 
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net v5 4/7] net: resolve uncommon partial checksums at
 ingress
Message-ID: <atq3hiJcsVi_1v0u@20HS2G4>
References: <cover.v5.git.mst@redhat.com>
 <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
 <willemdebruijn.kernel.2987fc5710162@gmail.com>
 <atpIiwcUlH5ttBb6@20HS2G4>
 <20261022193052-mutt-send-email-mst@kernel.org>
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
In-Reply-To: <20261022193052-mutt-send-email-mst@kernel.org>

On 2026-10-22 19:38:53, Michael S. Tsirkin wrote:
> On Thu, Oct 22, 2026 at 12:52:36PM -0500, Chris Arges wrote:
> > > > @@ -335,9 +592,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > > >  	/* Let the basic parsing deal with plain GSO features. */
> > > >  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
> > > >  				      hdr->gso_type & ~gso_tunnel_type);
> > > > -	if (ret)
> > > > +	if (ret < 0)
> > > >  		return ret;
> > > >  
> > 
> > One other case I found in testing is that a producer can set gso_size
> > larger than the remaining packet data. __virtio_net_hdr_to_skb() then
> > succeeds, but intentionally does not install GSO state because the packet
> > is too small to segment. NEEDS_CSUM has still left the skb with
> > CHECKSUM_PARTIAL.
> 
> So why is this a problem? If checksum offset is correct we leave
> packet as CHECKSUM_PARTIAL. That's intentional.
> What does your test do that makes this a problem?

The problem I saw used this case and setting inner_nh_offset incorrectly.
I'll dig more into this, and follow-up separately if this indeed is a
real problem.

> 
> > The following check fixes my test case:
> > 
> > 	if (!virtio_net_hdr_validate_disabled(skb) &&
> > 	    !skb_is_gso(skb))
> > 		return -EINVAL;
> > 
> > A concern I have is this may reject valid packets, so maybe there's a better
> > place for this.
> 
> 
> Indeed, it's not uncommon to have small packets with !gso.
> 
> See also:
> commit 7c6d2ecbda83150b2036a2b36b21381ad4667762
>     net: be more gentle about silly gso requests coming from user
>     

Ok this is helpful, I can see why that doesn't work.
Thanks

> 
> 
> > 
> > > > +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> > > > +		return -EINVAL;
> > > > +
> > > >  	/* In case of USO, the inner protocol is still unknown and
> > > >  	 * `inner_isv6` is just a guess, additional parsing is needed.
> > > >  	 * The previous validation ensures that accessing an ipv4 inner
> > > > @@ -353,7 +613,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > > >  	}
> > > >  
> > > >  	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> > > > -						 htons(ETH_P_IP));
> > > > +			    htons(ETH_P_IP));
> > > >  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> > > >  		if (!tnl_csum_negotiated)
> > > >  			return -EINVAL;
> > > > @@ -368,7 +628,22 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > > >  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
> > > >  	skb->transport_header = outer_th + skb_headroom(skb);
> > > >  	skb->encapsulation = 1;
> > > > -	return 0;
> > > > +
> > > > +	if (!skb_is_gso(skb))
> > > > +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> > > > +					       SKB_GSO_UDP_TUNNEL);
> > > > +
> > > > +	/*
> > > > +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> > > > +	 * set CHECKSUM_PARTIAL.
> > > > +	 */
> > > > +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> > > 
> > > on second thought, if having to respin, might as well fold the trivial
> > > fix in patch 7 in here from the start.
> > > 
> > > > +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > > +						 inner_proto))
> > > > +		return 0;
> > > > +
> > > > +	/* A tunnel header implies GSO, so drop. */
> > > 
> > > no longer true for the above !skb_is_gso(skb) case
> > >
> > 
> > virtio_net_csum_partial_ok_at_offset()
> 
> Sorry I don't get what you are saying.
> 
> >  
> > > > +	return __virtio_net_resolve_csum_partial_mismatch(skb);
> > > >  }
> > > >  
> > > >  /* Checksum-related fields validation for the driver */
> > > > -- 
> > > > MST
> > > > 
> > > 
> > > 
> 
