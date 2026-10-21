Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569129;
	b=e8K8FwHSwfmZjjf6t9sXY82IbpcqDJbpkQZnnbfL0kBprDHldTSghHxIAOvRCdIsKhlJ
	 tFc6efv5hGomng3dV2Qg1EnzfEwpkrdxRlPyEDdcJx85sl+vHd1klqaVzp7EaejUnZcoo
	 JBP5wApMos37Wjm8l7I5AJFz+1eTVjw1nfL7fhAuNkKAl/8p9DP2QKgbn+pKQ7Xu3XnRy
	 lGKlegaoqeosgvEeCDmLGvE9Aakyn0ozQ9UX48ngh3yOMbK+8LNcZ8HqftBbdoGVHbUX6
	 md5lJJxvSW5RfzGlfiO1rNymnLrlGRcZ61kDWNKUBmmJaTis915PNQIgglm0n68aogA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569129;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QITuyYs5+tqSrKrfIpvUKD41r2Vyp9d2xbchRm7msa8=;
	b=U4330KoacQJzwMTytdFUyJmHQEKFt1vnsUy1e+fjrmoes940J9TbzZDQedDhjp4Lvbtu
	 C3zs7mTVyRvp0kXeTrNbiGyLsiuWCMWmou1zlGTnom4d43GnSw5FVQDpxi1FhF370DoWv
	 IxKLMBFFEYb82nOQ7GFebvYtHA6c9KD36bLSd8Sb3e8CoFa4QDjL8rQItC9/zIjKWtfXy
	 hI6X/iNjg0yY2kwKvD9KwcDVANReudho3hRmjg6qhvJ4RIUWoK+ZlLpS52uwmQ3/e3VJx
	 lIwboLVvzdP+kRaIu7cY6HAKTutLuiVG03qm3tenviSLEr7iO1FXUKd3FhNA1Cs2iUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZyaCfOMZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=J4BWEF5P;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14153606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14153606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZyaCfOMZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=J4BWEF5P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792569128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QITuyYs5+tqSrKrfIpvUKD41r2Vyp9d2xbchRm7msa8=;
	b=ZyaCfOMZaLkfkP5CIbv/1k8OFGPI/rFHCd+WinSm2OaUZ+PlPMpdVEhD1lGH48qxwGoxSI
	hSZ6reKymyIhMi3j3r3N93eNEbIy0IEv5b95MVvEUVZcl6jVtKadplSALa6X3QOGPVoKmW
	npPsF3ueHC72nh73zQz8LCW2p0+M2vA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-r6XxrOUOM36LEir9FLMUvw-1; Wed, 21 Oct 2026 07:52:06 +0000
X-MC-Unique: r6XxrOUOM36LEir9FLMUvw-1
X-Mimecast-MFC-AGG-ID: r6XxrOUOM36LEir9FLMUvw_1792569125
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0af48c18so334689f8f.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792569125; x=1793173925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QITuyYs5+tqSrKrfIpvUKD41r2Vyp9d2xbchRm7msa8=;
        b=J4BWEF5PNGoV82MCnAZffDR3ZZvNJwcMin/NFwAjKIm7DdUufKnGGJbpVy4LN8JXXD
         xpEDoIJqPhZD1fXC+KTbyXSaLflsyjfNfQ+aiFi5iDySJ/eS5BhYml2czPeoB/2kHRVQ
         HLRhyEqOpA6FWmarX65ITFblyghzCToej9kOZgVG75vRlJFRSMcq72LyDBcGgZml5EXa
         IKVl0DPLISk9BBKkAXW9S+KlcgmYIsUi+4uj+/5DEMkB3kS20Rk3qtEZBmPrVz28DoBb
         uSL8anh7hbU5qXnptZc0/+rzfpnR1gPCGNQsDS8zvCOFc2NHOdOe5uACtSDbLfja10Yi
         KfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569125; x=1793173925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QITuyYs5+tqSrKrfIpvUKD41r2Vyp9d2xbchRm7msa8=;
        b=dSKhUviUv21zukkHcjbYxmplzqxx6a4PozMdaPddzNokd9+9KhuWSvhI7Hh9e786cY
         xwBFZJpXx4owo7eTT7wFl2cctAmJ4/fbkuZGm/TPh0fifPdmRpw9tWuUwlA/HX5C8dzW
         hweiRZLHMUEfBftSQsX7ouj/M638uo3V659/KqrmVJRBt/gheqWlt7UpYH+unKUWKoVe
         z3epKe+oQs79jIf/Y1lUt/mL+wlR3dRgtHFbuuk+W30PONu/RnjyZQk5fUoUYQkOpx9+
         /7L7Af5YLZ1JS4jK0lmsD0xOcJKUcjfDt6lSXTBSEnFJqRQg2fIY5/kcNFN2H/crchrw
         vDig==
X-Forwarded-Encrypted: i=1; AKwUvBzMt7bBZCKZKOzVpECxSbcjAuZEFMnYuzni7mgTJBZNSEFmtkUyq8m2W8jMx+9Ttmg6iaAbVS8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgruJ75DxxoqWlKY30vGEiy8vxWg7S9a4v3oo/sgOpDo4TFzj+
	MRiKydCyf4bkyw1cE6MaJ3KgVNlOuc4tkCqcIJZxzPWxidHSWbAbNtiYAAhp/nhLw+vcgp8VukY
	V2MZZc0qVUc2x0iG1HO1OkJ/IK4VGc0SznqAa/QV14yV57F7jR/HkYk+oBw==
X-Gm-Gg: AYBFou23wLGi3DGCkfpPnCh2iPpz+Pak6Iw2MljWpGs9aBhGV9w2nRzK9avmFlisSez
	aL8ScFkvU+t/feLcsJyUfeS84duEe+WsS4AyLPfOGNVLzY/FrSxS9vRSAI1RvNL8vLNOaAYSTL7
	Kodp78RplrhIOx8tzVSyu63xj0N2wPzuGXKMqDQGt/o/3aYzjRDDS5LPKWc5fDB2UjuBc2YHfqA
	7JFl/NX/3Pr/Sh8hPBLojg5c+Yo/qxZ4NWAxwP6yDE30ViZp25mm39R+ZLCv4d/4Yg/r3RTes0V
	fDKIpXBXreaLPHOHzc54M2P5u9AvZo7zJXndyQMettEB3f0MEqO5kxYBAxZufJM4nEOwdw==
X-Received: by 2002:a05:6000:478a:b0:48c:7ee3:e07d with SMTP id ffacd0b85a97d-48e264ef9cdmr1191048f8f.52.1792569125344;
        Wed, 21 Oct 2026 00:52:05 -0700 (PDT)
X-Received: by 2002:a05:6000:478a:b0:48c:7ee3:e07d with SMTP id ffacd0b85a97d-48e264ef9cdmr1191026f8f.52.1792569124881;
        Wed, 21 Oct 2026 00:52:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583ffa8sm3908268f8f.51.2026.10.21.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:52:04 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:52:00 -0400
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
Message-ID: <20261021035050-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <9c08d12b3a7819ae03ded6a154e4f908276e93d4.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.2eb449439b094@gmail.com>
 <20261020170908-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.1da723f98c23a@gmail.com>
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
In-Reply-To: <willemdebruijn.kernel.1da723f98c23a@gmail.com>

On Tue, Oct 20, 2026 at 08:05:29PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Oct 20, 2026 at 03:44:35PM -0400, Willem de Bruijn wrote:
> > > > +/* Walk the L3 header at @nhoff: where does its transport header
> > > > + * start, and which protocol is it?  Returns false if the header
> > > > + * is truncated, malformed or fragmented.
> > > > + */
> > > > +static inline bool
> > > > +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> > > > +		    unsigned int *thoff, int *ip_proto)
> > > > +{
> > > > +	if (proto == htons(ETH_P_IP)) {
> > > > +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> > > > +
> > > > +		if (!iph || ip_is_fragment(iph))
> > > > +			return false;
> > > > +		*ip_proto = iph->protocol;
> > > > +		return true;
> > > > +	}
> > > > +
> > > > +	if (proto == htons(ETH_P_IPV6)) {
> > > > +		const struct ipv6hdr *iph;
> > > > +		int flags = 0;
> > > > +
> > > > +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > > > +			return false;
> > > > +		iph = (const void *)(skb->data + nhoff);
> > > > +		if (iph->version != 6)
> > > > +			return false;
> > > > +		*thoff = nhoff + sizeof(*iph);
> > > > +		*ip_proto = iph->nexthdr;
> > > > +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> > > > +			*thoff = nhoff;
> > > > +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> > > > +						  &flags);
> > > > +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > > > +				return false;
> > > > +		}
> > > > +		return true;
> > > > +	}
> > > > +
> > > > +	return false;
> > > > +}
> > > 
> > > for all this parsing: could we use flow dissection, like the
> > > !VIRTIO_NET_HDR_F_NEEDS_CSUM case?
> > 
> > Hmm I don't see how.  That one trusts the caller's protocol and network
> > header. We could parse L2 ourselves and use the dissector for L3+. But
> > it stops at whatever it does not know, and every miss would turn into a
> > drop or a software checksum for a packet the stack delivers fine.  Our
> > parser deliberately covers everything the stack can deliver.
> 
> You're right, the protocol and network offset need to be parsed
> manually. After that it could be passed to the flow dissector.

I posted v4 with the custom parser, since i had it tested. Let's do
cleanups on top? I spent too much time on this, to be frank.

-- 
MST

