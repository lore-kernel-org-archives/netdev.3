Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54833403E97
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091913; cv=none; b=sskFS3y/eSbgMPPPzMNa2EctzauWe4ud/LqhrKhEJ64QEZ6VgDtFRksxRQ2y1jsFC+QrqOgTgOBUkfz74PJlXzgMshpPTZLRRYb1L/Kc7sBaixrkcqCnd2hZFg88v40Sj40UeiFh7xcas51EcWzjyqw4phDxzm2jLMV56Z5mHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091913; c=relaxed/simple;
	bh=XunIyjLglWkEZuy79Gjq1aaR8lLHvXzOggez2eNhydw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFEB7c/OW/Xd2jmicSP0oYLisp8mQOTJpwnlTC6abAlXFjcKJ4Hq/30Ramt3+ACI2BuXC7mhl78FM87sewSDw4MqquGLYfHTo2liiCK+SrSks1GC5DFyEgQcRrWkRGA2yeUuuT8Fzv+YmJ3wRTp95vI3iWqxwVxQraQpXtV7d8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=a0hwrlbr; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="a0hwrlbr"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-824e6e6ed71so1996401a34.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792091909; x=1792696709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O5Iu6sJ0mFXdzJYujaA1QWqjcUesBfii0INSCkpe85Q=;
        b=a0hwrlbrdPVM+pQx4313bLOKTvwIa1amhQncapyKsnSR/EZ8X8O9uuQrGv5fHeLSNV
         68tZbqhdClZtLjjWds0N+H+g7Ts9NvqXeNAwZFk9fOJVZojSXN1ay+mYLwuvjIqpw5KY
         prNNj+AXJxpQMlUCtfZ8UGn2PR7pSgX0tX/SJGNs8dUPXP5wdFLcYQh7gGYJ25b8+8fA
         H4Q5jdSnSYXxMTBftJFewjE+FCDGbHkO0S6IciaAzBkq8YNCLIIJCkjcjPCqYeoPrOFl
         vmASKbojkUQOSS/HvNQaQ2PJwPBxCadHE8skXoZ7jmgMxsCCz5j2U03DZv/tQ97PcL6f
         YrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792091909; x=1792696709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O5Iu6sJ0mFXdzJYujaA1QWqjcUesBfii0INSCkpe85Q=;
        b=ZJNAVaGNmuKXpnRVHda70mlB62QuxjOfa2biqyL/8Ej2hBX//zkHx3rk9rAEcxnEMg
         GizuFmA0amzj1U8FtL7mTWoOMbC5sac2FXg+oj+nvbL901Tpn00ifEJo+vy60qGVQNbB
         f67eJ8A2xgQVvr+rS4+uozX+T5H/+Ba/iiH9WTHTkCMR+Mu8+wWp6Jt51sDz1PMHaVHq
         SZEX5VXnUehlLuVBjcoN9M1DANfG/aEqAOAv+oAIaZvHVlVOu1r+naIckKBGkICVxHEN
         ohQdITe0XowaCpPGIQblhD3aDw4zOxY3RUnhcVw65eH6PizIH5PziufmvPoWAjXgZ+7W
         5Eog==
X-Forwarded-Encrypted: i=1; AKwUvBw8Hg3b1vczCgytueJf4Nrl4SIO6JpdQ4MF3Qml4elgyx/ZmAITGLw59NVjQaE+1YslyIbmL/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKY9J+Xd3P4xGSWcgpbs4OqIyvJUUYPizhz9W4PWJyNxtsn7YWK
	TyJPe5RXDYj51xU08sri6cFhhyKCPOGUUxopNRl6EG8Y8DHK7HOSx6WGgcKyFiKOAFY=
X-Gm-Gg: AYBFou0INV/0XDsmU6fPjziptLtiAnKtns0bWRAA9Fg/nSB2kmCT4Q1Kfi9szA18uFp
	iRdJtWaH4DpL4UvDamfO3vYb/l5ZvGNbh1N0BSUaMZ6qkZ3hfuykGa76Ac6Gv5+ORGrWgO+SxsV
	vcMLro2fpnOzqvTRpUFYKEb+esuzedvWYrml+HcRXMrvOzDYziW4kqHhP6TM669lg4mfpM4alty
	hPWiBO3IXszrlcl3h0BQWNlVVD48paNndm+vrEwUX9oZKRHxHM979CingSOn6dvGOMAhGFmADse
	6BhwkSNrmPOcr0SH4xCZf7AwhSIWMKGKhzPrX9x9e37mm0ZTtJgdroZiq5cqO3pTljKj/4KN3+k
	wGgixwnkuMYE6qFraRi+b+rqtXLinC6TsiM7LyvQgkWCq4h5/UzGhSoO+oMeSaAbqLXYk2KX/0O
	KtS/wn8qXMICwXKY1QXyV78kg5w8nxhlPpUzXBD6ure9G+8VTeJ9fbQg==
X-Received: by 2002:a05:6808:309d:b0:4c0:89e5:da46 with SMTP id 5614622812f47-50c54177a6bmr21096130b6e.32.1792091909092;
        Thu, 15 Oct 2026 12:18:29 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:3737::580:5a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-537b3fa80bdsm245942b6e.8.2026.10.15.12.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 12:18:27 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:18:24 -0500
From: Chris Arges <carges@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net-next v2 4/7] net: resolve uncommon partial checksums
 at ingress
Message-ID: <atEnABN9QePqsaIf@20HS2G4>
References: <cover.1792067836.git.mst@redhat.com>
 <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.11ecc15463d9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.11ecc15463d9@gmail.com>

On 2026-10-15 13:43:56, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
> > others, credited below, found more ways the bug can affect users) a
> > virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
> > If that state is retained, later checksum completion can modify the
> > packet after protocol processing has made decisions from it.
> > 
> > Let's fix that: let's validate csum_start and csum_offset and only keep
> > CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> > UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> > headers.  Complete other non-GSO checksums immediately, before any
> > protocol processing runs.
> > 
> > We can't easily "complete the checksum" for GSO we don't recognize - GSO
> > assumes knowledge of the protocol. We could segment ignoring the
> > checksum then do whatever csum_start and csum_offset say, but that
> > seems like an overkill for something that shouldn't happen.
> > 
> > There's some risk here:
> > - non-gso packets which can't be parsed get checksum calculated in
> >   software, adding performance overhead
> > - gso packets which can't be parsed get dropped
> > 
> > To mitigate the risks, the following patch will add a sysctl knob to
> > bypass the resolution. This is reasonable if the setup is such that
> > there is no protocol processing at all.
> > 
> > UDP tunnel headers get the same handling on the inner header.
> > 
> > Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
> > 
> > Assisted-by: LLM
> > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Reported-by: Chris Arges <carges@cloudflare.com>
> > Tested-by: Chris Arges <carges@cloudflare.com>
> > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/virtio_net.h | 251 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 241 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index d6466f96cdd0..357115ff0ec2 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -5,7 +5,11 @@
> >  #include <linux/if_vlan.h>
> >  #include <linux/ip.h>
> >  #include <linux/ipv6.h>
> > +#include <linux/netdevice.h>
> >  #include <linux/udp.h>
> > +#include <net/gso.h>
> > +#include <net/ip.h>
> > +#include <net/ipv6.h>
> >  #include <net/tcp.h>
> >  #include <uapi/linux/tcp.h>
> >  #include <uapi/linux/virtio_net.h>
> > @@ -48,6 +52,171 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
> >  	return 0;
> >  }
> >  
> > +/* TODO: nothing virtio specific here, move to ip.h */
> > +
> > +/*
> > + * Pull and minimally validate the IPv4 header at @nhoff.
> > + * Returns the header and stores the transport header offset in
> > + * @thoff, or NULL if truncated or malformed.  Only the fixed header
> > + * is guaranteed linear; callers that need the options or the
> > + * transport header must pull further.
> > + */
> 
> nit: comment basically describes the code (what), which is quite
> self explanatory. I'd drop. Or else consider converting to kdoc fmt.
> 
> > +static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> > +						  unsigned int nhoff,
> > +						  unsigned int *thoff)
> > +{
> > +	struct iphdr *iph;
> > +
> > +	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
> > +		return NULL;
> > +
> > +	iph = (struct iphdr *)(skb->data + nhoff);
> > +	if (iph->version != 4 ||
> > +	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
> > +		return NULL;
> > +
> > +	*thoff = nhoff + iph->ihl * sizeof(u32);
> > +	return iph;
> > +}
> > +
> > +/* Where does the L3 header start, and what protocol is it?
> > + * Handles Ethernet and VLAN headers; other devices use the
> > + * network header offset the caller set up.
> > + */
> > +static inline bool
> > +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> > +{
> > +	if (skb->dev->type == ARPHRD_ETHER) {
> 
> Only since recent commit 44378d02c5aa ("net: always dissect GSO
> packets in __virtio_net_hdr_to_skb()") can skb->dev be relied on to be
> non-zero.
> 
> We'll have to be careful that this does not get backported to stable
> without that.
> 
> Perhaps an explicit precondition test and error return (and
> DEBUG_NET_WARN_ON_ONCE) if a NULL skb->dev is encountered.
> 
> OTOH, it results in a hard crash so will be discoverd fast without
> that too.
> 
> 
> > +		if (!pskb_may_pull(skb, ETH_HLEN))
> > +			return false;
> > +		*nhoff = ETH_HLEN;
> > +		*proto = eth_hdr(skb)->h_proto;
> 
> When called from virtio_net_hdr_tnl_to_skb, according to my LLM mac
> header may not be set yet. Have not verified yet.
> 
> skb_reset_mac_header(skb) is called inside __virtio_net_hdr_to_skb,
> which is then not called yet.
> 

I am able to confirm this in my testing. I have KASAN enabled, and it
triggered when testing leading me to this change.

Adding `skb_reset_mac_header(skb);` before calling virtio_net_tnl_offsets_ok
mitigates this issue.

--chris


> > +		if (eth_type_vlan(*proto)) {
> > +			*proto = __vlan_get_protocol(skb, *proto, nhoff);
> > +			if (!*proto)
> > +				return false;
> > +		}
> > +	} else {
> > +		*nhoff = skb_network_offset(skb);
> 
> The same is true for skb->network_header. Since an uninitialized/zero
> value there causes more subtle issues, here an explicit check may be
> more valuable (even) than for skb->dev.
> 
> > +		*proto = skb->protocol;
> > +	}
> > +	return true;
> > +}
> > +
> 
> >  
> >  /* This function must be called after virtio_net_hdr_from_skb(). */
> > @@ -282,6 +470,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
> >  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> >  }
> >  
> > +/* Do the tunnel offsets match the outer headers in the frame?
> > + * The L3 header the tunnel claims must be the one the frame
> > + * carries, with UDP following it at @outer_th.
> > + */
> > +static inline bool
> > +virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
> > +			  unsigned int outer_th)
> > +{
> > +	int nhoff;
> > +	__be16 proto;
> > +	unsigned int thoff;
> > +	int ip_proto;
> > +
> > +	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> > +		return false;
> > +	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> > +		return false;
> > +	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> > +		return false;
> > +
> > +	return ip_proto == IPPROTO_UDP && outer_th == thoff;
> > +}
> > +
> > +/*
> > + * Return value:
> > + * 0 - success
> > + * >0 - checksum was completed in software (slow path)
> > + * <0 - failure
> > + */
> >  static inline int
> >  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> > @@ -293,6 +510,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	unsigned int inner_nh, outer_th, inner_th;
> >  	unsigned int inner_l3min, outer_l3min;
> >  	u8 gso_inner_type, gso_tunnel_type;
> > +	__be16 inner_proto;
> >  	bool outer_isv6, inner_isv6;
> >  	int ret;
> >  
> > @@ -332,10 +550,13 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	    inner_th < inner_nh + inner_l3min)
> >  		return -EINVAL;
> >  
> > +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> > +		return -EINVAL;
> > +
> >  	/* Let the basic parsing deal with plain GSO features. */
> >  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
> >  				      hdr->gso_type & ~gso_tunnel_type);
> > -	if (ret)
> > +	if (ret < 0)
> >  		return ret;
> >  
> >  	/* In case of USO, the inner protocol is still unknown and
> > @@ -353,7 +574,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	}
> >  
> >  	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> > -						 htons(ETH_P_IP));
> > +			    htons(ETH_P_IP));
> >  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> >  		if (!tnl_csum_negotiated)
> >  			return -EINVAL;
> > @@ -368,7 +589,17 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
> >  	skb->transport_header = outer_th + skb_headroom(skb);
> >  	skb->encapsulation = 1;
> > -	return 0;
> > +
> > +	/*
> > +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> > +	 * set CHECKSUM_PARTIAL.
> > +	 */
> > +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> > +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > +						 inner_proto))
> > +		return 0;
> > +
> > +	return virtio_net_resolve_csum_partial_mismatch(skb);
> >  }
> >  
> >  /* Checksum-related fields validation for the driver */
> > -- 
> > MST
> > 
> 
> 
