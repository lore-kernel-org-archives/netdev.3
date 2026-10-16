Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F490470EA0
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143380; cv=none; b=nZHWV6eRlpBYCzPXnWVFyH+9W6TKeXKDPCX4qLLAjwFTthSZkky1UA9752JVDDE/R3hw96ahT5YDGr98Rz/WLeL23LztDEMW3scf4hdDw/0LcdfjGxwDxCNnrzAtTc8jUSBThpCV7/pEaNTElXyZxTfs/1/z88RlUJOgEIO23VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143380; c=relaxed/simple;
	bh=RoFTc+bgT+YiyaaL4TBiebP88H3fEi765U7d5X2xO/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaE1b8Rb1e1CbLyHktVQcmDfZdBCN9OIbnWtqyv11C76rmJWgBa85Ypi+kkm5K6O5hw8fwtxhbUotqFWKN5zr/rL57SS/gyyuRi0qj1KfQQnHYI3hUGs9JtMTUMynIIQQsdTGEBQL2Dr1SqhkrVUPyn6WzQXpxaIm5lMRCs3Pss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPpOxox5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGix0US4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPpOxox5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGix0US4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792143377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeGVMwnnO0pcdPOjq1m3b1Y6CoA/dKS06WTt4589nyM=;
	b=FPpOxox5l5GsW1oPy5yBgfNWelzKv3PP/pi10LVMRAnXDZDNDD82jE0OD1thqc5+QXK0Tx
	/DAerwTc1tfjvAAb+8mi+wCTMG8CfEbH++IZUrXSHNHQtZ5MID13JfwBfASfoPEJCQyksG
	8ZQRRkVxcGinDfu+afzvQn7jSb2mp/4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-Giavck9BOj28Rk0F0Lxv6w-1; Fri, 16 Oct 2026 09:36:16 +0000
X-MC-Unique: Giavck9BOj28Rk0F0Lxv6w-1
X-Mimecast-MFC-AGG-ID: Giavck9BOj28Rk0F0Lxv6w_1792143375
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1ad49096fso8264405e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792143375; x=1792748175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HeGVMwnnO0pcdPOjq1m3b1Y6CoA/dKS06WTt4589nyM=;
        b=bGix0US45ngQT0ZD7qvkr5t54S2b4D2/CcCDpdoIKlMQmgLRzEuV751lJXDu2gabkr
         qMquHiADiUFMwaCmpnLdEfVJFrNofU+/zltb2f1eGVPXzw5Kc/9A8m7SltJshr+EhVkv
         z5wbbhlvE3Os+wm0KZxsUX1yxqLO+LHM53pdxDiqe2MdxjiPor0zYYMXjjIdW9QPrpGJ
         X7uVwDVGdtqG1exLJ/zgZXCyr9UXxJMgAL+oRwaYNQ3fIk09on33RXDPiK5Hq0iJ+No9
         RyCAUMn8JxMNBeb9o25e6n8SEwwa0CDuDgjV9EkawP7iLZeIaG+M0jjKrV2LWKe6pagm
         le2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143375; x=1792748175;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HeGVMwnnO0pcdPOjq1m3b1Y6CoA/dKS06WTt4589nyM=;
        b=SvKerU0B6MPeVX1feDv1juCdvp9T4SGGjsK/bKoMaT74v9S9T8OVDvJ4KlDZrmEHkC
         /HUcYpEKrxo9AJQJzNf8uhIWpj+NbuvqbA3kiq5/DjtBpnTiscutgD3+ndkvb6GUQxWe
         +m3/Z18rmCemHLIDjJWFRSiHhaTt3VhOp2Z9OrpzRscMjle8qScP763LYOKuorNiMXiw
         IhAo1ETsBIgsQ5hAd1w8XAbv1PeINy/Q2JomNWbqXASK7xN23Xav+3cdptLBLGsQPnqi
         JZfyhWUGEp479qDaetsfEaqBm/GJ0VCxf3xdeMpizok0DXA9zCRkX+kASp+y/N3aC1Az
         ew6w==
X-Forwarded-Encrypted: i=1; AKwUvBzwAIFOaScomk7BIo0pcSxeduDxQOJwPyCBmUcGkBFb2G6Op/Qk8O6KIxOdzB0QhmPyN7E+was=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuivXJGaPOjPO06RZAOt40tH8tHyQUeJQL8wetZZz+3pbbY3JW
	69XRsj62vtQ8LPP/ZJBTiEG/rmH5Ad605oFGpnrzul8iWHDy3WkBrUrCB/B5/BGMp1yt47YW9B1
	izHs8/jvV+5AoEt5XDb+UvAsWm9M27NJwIv3YGkT2Ptdilkr/OFu0SL5VLQ==
X-Gm-Gg: AYBFou0x4WcDp5z0KE5rpY09uojyOn6v2T2Y9Sz1G+iatNo4ojCjaur0vQAx+hlyuhQ
	NUotZt4XAgFNhCAKmU2usev8s1886ZHJwGX8CYDCJXKwq/cZGpjBgIe7UEPjVZQCYm5dchNqcAM
	GomMn6crsQkR7JhUaRH7YEvESLu7K6mVm0maGWxIvUTcIGwkVaqJOzxJpTBQOXFuRTSLL61oyTF
	yzE052pCcOozTzvrM+JoOVpa8ul75fB4aLfBtwXFgh2r6N+30OYqJhLgBtWLnCEVT8RmOaRwmjT
	FuVxyx6xfriDjArvoM9CC+5n2ldOLxn8iYX6FLajTxsgv+13LDWefv5hGlwApKPa115I3Q==
X-Received: by 2002:a05:600c:c106:b0:4a1:7a1e:6910 with SMTP id 5b1f17b1804b1-4a1c6635d15mr45744815e9.4.1792143375046;
        Fri, 16 Oct 2026 02:36:15 -0700 (PDT)
X-Received: by 2002:a05:600c:c106:b0:4a1:7a1e:6910 with SMTP id 5b1f17b1804b1-4a1c6635d15mr45743975e9.4.1792143374104;
        Fri, 16 Oct 2026 02:36:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de682bsm42186565e9.13.2026.10.16.02.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:36:13 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:36:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH net-next v2 4/7] net: resolve uncommon partial checksums
 at ingress
Message-ID: <20261016053522-mutt-send-email-mst@kernel.org>
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

On Thu, Oct 15, 2026 at 01:43:56PM -0400, Willem de Bruijn wrote:
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

Yea that commit's pretty important) I'll add that to the commit log.

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

