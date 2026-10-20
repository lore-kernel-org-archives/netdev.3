Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532982;
	b=Shrvip5yNIeBr0vcMzX1FybP63CpGgYIlmTMnG9THzRqasocuQsGa6ZOKJy/Lh4aBZf1
	 8PwcIw9d8Ob48S02nme+rJ0KTMnNcuAdU6Dwn6/6MPLXWWTfn74KTO9yJax86HN4Cxm05
	 14+9Uhd8YmCA3MHXKJJLmstqroxcudUMlqH+s/psGcke19v41nl6V03yDT+VmFO9zPUny
	 jthy2uPhbx4/mV6GDKNO2qX1hzhEjneHZABvFQF5Tpxb+kAl0fjbm8WfShD3WhijcaB0C
	 Yfo6rfEs60SA3Tr6iRowAOZl5uFmONDCnQ4wcvUOSNslRATZ9pOKpx03Gst9vCe/vAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532982;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6a23BIgyFqsOlkHIU2aMu3SBCeDxKSj45oBJ7lnIkkY=;
	b=uq/6kKd4gheyOfVzhV7GVArV1KNXyqCVlj6+jlz7kZos1NeMXBESXuDZDB8fCkvekkYW
	 4PB8VEG7BSxhFiWw/YXU7v7gon7Fwu8lcR1UtIug9RvN8xw8KBY6FaHVmi1cuT2Ruvj/T
	 9YP8lyjKdG/0mgiBk+NvnDZ4EunZz25rulc6d5BhGoyajgkUMVVjb/2Ez1JPxKW70Dfdh
	 e5qSfrOwwTlx7Q6s0GZewgcCoZSUJQmv6CBNS2J+x3tczL8lFYxxjLzyZcgTJRBmekwV6
	 vjzmFupDBA6YJOLkfI/Tn8b9MO0KPHU7IyG0QSrIGtMrlc6fNbZZ9nqChJhW7Iony8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eXxUXygj;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jgnvcfjc;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F6606A322
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF0F6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eXxUXygj;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jgnvcfjc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792532980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6a23BIgyFqsOlkHIU2aMu3SBCeDxKSj45oBJ7lnIkkY=;
	b=eXxUXygjpIdNOWXdt2do2mPWMPNSImKQTPSXrcCwWEKGg+WvQyVWcLSixU7jZwhX7Qym2A
	wYMWQvdX6+WOf87CRW+xm1Dtdi5N2uBwuGchQJ3SpP+Xh6zej8Ljm7LGkY6LiACzQ2yjRS
	P0OLdYxSmQhh8SOQjR2UZ+hAyBXAviY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-KbyyPFB7Oz-UvI61OqHsjA-1; Tue, 20 Oct 2026 17:49:39 -0400
X-MC-Unique: KbyyPFB7Oz-UvI61OqHsjA-1
X-Mimecast-MFC-AGG-ID: KbyyPFB7Oz-UvI61OqHsjA_1792532978
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso44283f8f.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792532978; x=1793137778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6a23BIgyFqsOlkHIU2aMu3SBCeDxKSj45oBJ7lnIkkY=;
        b=jgnvcfjciRC70SNW+z/J6p1+SLeinjYoFjgJ6KaAoaQ6B5lhe5JqXtzBd8al8g1raX
         bE1boKYFMCO2NDh4Y355KudDl771dVKYqHA4i24aYf2uv9TwWS3fFWNUnWGQyuENB4+O
         MlO0PdWM0Bg4z8oVaueaa5m0GvSHQD5hUqQ0lx6NT4M/hZ5YW21aODtouS2eIu4FArN3
         gnZhn8NMinctq/TAfvBa3nvSuWtDgu+SA42SvMH2ZvSaiwF1aH6yotFJ/bXWTfaPkmmw
         N42BTSZxjpLBydzXMZJH5L29a5CxXDnrh4sKBtvU66J2t8jYIAqpIxZW16RDvK/zfu3H
         t9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792532978; x=1793137778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6a23BIgyFqsOlkHIU2aMu3SBCeDxKSj45oBJ7lnIkkY=;
        b=sFNXPaRi1VMI1w3q1yPUAECalTB3SmnSAMlmL8r/zBFwKuM3pzEyZIECrwVsPdsKWN
         g2XfCStTIyHgC2YuW5zGCTwT5ahsccHpJXi/1cYbrkEtxCdagkfIfRrXowjoLsmaGIDZ
         GllCn149hCtuNH/pBjg3sekDRz6FvBIoiAYOSQjErzppjmE4GAf32S4x4pBdYJDLhgSv
         mQdzNbFEXmOjj+y4eGcxmY1rkI/nTrTfrsMbFeGTE1aqGjXoYJQKU3BjWaCDCgISMHNE
         HB71nQrdtGT6xhFWPAcg62j7y5RiS/g5r4cMFWyNdMsH2ZWKYk/HIH+CWAbGRjXZdtgx
         aM5A==
X-Forwarded-Encrypted: i=1; AKwUvBzZLdpN41v440PNO/9Leh55InSHK3pghSL5hQVl8wXD9QJ/Dt+eKYwjl6lnnPIX/wgbKvKGiio=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDyrITuV/jsJbHxvums5fhe3HspxB2oe/3Iikx9GQFVU9FhYeD
	fnDp3NPIntaAXZV5Ear1fJgYY/mdyM5ie9yGLFbOsGehJ0WpiZbROh4hSrMvyphmZ4rDM+T39Mg
	JjrwdrcFooM6MW3zfTzOQAI5nM6UNOL567MGLiL+QOK1R2AV5mj9QHoHnfg==
X-Gm-Gg: AYBFou2eW+BS3j3XI3PBPLbJIh8pgIMzUb/4vBacZYaLNtvXjjzmQ6tFY+UdTiOrYEw
	rh0CG4ZNF6trgXcS12+LSlzs8rwNbXqwDxHI+P1JPc8Au6oORtQ8PbDbi3ZWd9jV5lpyBfz7bT0
	D6WjaUuxhFeBY+AKxN0KLWCKqNLqAdVVnDh5r4GUHt2J8wGF7q430euJgKJMK03a8QiSZwlJ2g2
	XA0AIiJ24V4XupucehsjEK1gSFj5x4vGEQ/aY2vPs3jL2YevycNxYVZD7B3ETaroFlJgbRo2HtD
	o4s4GCjK3PhqQbsUw4Ksg15jLwN8glsdYwe6Bi4bwpg3fHS9qXwI/GuJLQKuVt8xldbZlA==
X-Received: by 2002:a5d:6f17:0:b0:48e:cd3:64f8 with SMTP id ffacd0b85a97d-48e2641dda7mr47252f8f.4.1792532977743;
        Tue, 20 Oct 2026 14:49:37 -0700 (PDT)
X-Received: by 2002:a5d:6f17:0:b0:48e:cd3:64f8 with SMTP id ffacd0b85a97d-48e2641dda7mr47229f8f.4.1792532977316;
        Tue, 20 Oct 2026 14:49:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828c6dsm1149327f8f.24.2026.10.20.14.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 14:49:35 -0700 (PDT)
Date: Tue, 20 Oct 2026 17:49:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
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
Subject: Re: [PATCH net v3 5/8] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261020170908-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <9c08d12b3a7819ae03ded6a154e4f908276e93d4.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.2eb449439b094@gmail.com>
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
In-Reply-To: <willemdebruijn.kernel.2eb449439b094@gmail.com>

On Tue, Oct 20, 2026 at 03:44:35PM -0400, Willem de Bruijn wrote:
> > +/* Walk the L3 header at @nhoff: where does its transport header
> > + * start, and which protocol is it?  Returns false if the header
> > + * is truncated, malformed or fragmented.
> > + */
> > +static inline bool
> > +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> > +		    unsigned int *thoff, int *ip_proto)
> > +{
> > +	if (proto == htons(ETH_P_IP)) {
> > +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> > +
> > +		if (!iph || ip_is_fragment(iph))
> > +			return false;
> > +		*ip_proto = iph->protocol;
> > +		return true;
> > +	}
> > +
> > +	if (proto == htons(ETH_P_IPV6)) {
> > +		const struct ipv6hdr *iph;
> > +		int flags = 0;
> > +
> > +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > +			return false;
> > +		iph = (const void *)(skb->data + nhoff);
> > +		if (iph->version != 6)
> > +			return false;
> > +		*thoff = nhoff + sizeof(*iph);
> > +		*ip_proto = iph->nexthdr;
> > +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> > +			*thoff = nhoff;
> > +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> > +						  &flags);
> > +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > +				return false;
> > +		}
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> 
> for all this parsing: could we use flow dissection, like the
> !VIRTIO_NET_HDR_F_NEEDS_CSUM case?

Hmm I don't see how.  That one trusts the caller's protocol and network
header. We could parse L2 ourselves and use the dissector for L3+. But
it stops at whatever it does not know, and every miss would turn into a
drop or a software checksum for a packet the stack delivers fine.  Our
parser deliberately covers everything the stack can deliver.

-- 
MST

