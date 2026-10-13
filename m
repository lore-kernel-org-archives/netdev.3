Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CCE550DB3
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922519; cv=none; b=ZhINrNczuCleU5bAqTeuQ9xOBQFFeXBisbplLo6sviTVSPW5Yck2+XbU7ECWHvIr4Ps9hOKsvY/uIqORuy6K3enpJ5hw9tPP21bDcMn1q7mB/5HoGFM4P/RxH0eF0JVhYb+i63QEJUvxtV7IwKLBrMQ4iKUkM8+mPEbSisuA5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922519; c=relaxed/simple;
	bh=VelkTehF4drr9gNOsSSnuu6r1AOcSox8mD3aPhtgf7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muwC299w6q9G62/PxGYRn9NpSIqUuPC/2Gw/YZHaw0C6r+QxksBAvO57KNUrz8bBkVmWAdmDj3OYd/qvrPzWk/sCh3Gy9zmS+DGUovOKL6bdDwYg0HtN+B1sGC7M9NMpW+PgPTWQpwSvthZIG0wo3C4INjLPTZty9OTkZH4xCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfljHpM1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pZb6TIWD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfljHpM1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pZb6TIWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791922513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ny40RLCqmtqln21EVFzUzRBxml9MuUjONSew3K/qpUk=;
	b=cfljHpM1NaaYCf0lxLIbbF0cESFqx0A/erGeasf2MKsAIp1VGdk8MpfbruXiZdeLNXXhmP
	QrgKYxi9sngqT0H0WiCRNYaXZygVvCwvY+ZfmQwBy6InI6trrCceh/rNX3cyoMVUBaUImH
	6khaileYAnCRRImu/I/GmH7WoEf8hfg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-VKXkQypLOtCQDW8rqkIQqQ-1; Tue, 13 Oct 2026 20:15:12 +0000
X-MC-Unique: VKXkQypLOtCQDW8rqkIQqQ-1
X-Mimecast-MFC-AGG-ID: VKXkQypLOtCQDW8rqkIQqQ_1791922511
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-486f9d150c3so2010830f8f.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791922511; x=1792527311; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ny40RLCqmtqln21EVFzUzRBxml9MuUjONSew3K/qpUk=;
        b=pZb6TIWDKPJ4SzcmXGg94k+XWvK8RM3zeGxCiYK3lpt8RCfedNGtQd7Mre+MMAIZG+
         fKIHOSuWq48t7eZO8xj5qeQIWHT9FxngMjRlNQKEgwT/0/eLLLdPB+xtQ1pBQZQpDKHF
         NIhsHn75t7RG/+W3TKIRTlWc15xIUl63bamc925U9XJHg24UAFRDOPWOWl19pOXMxZtu
         AbBxafzWSpGCcvQJ0XLgoYdYTQHdct4J3af7XBYeOl7mhcyxmydKitBZ4Eg+pgvclt3m
         WdI1bVXVU368s6JfxjwNjpoyLFSf+bomnwkZR284WP/qTkvj/P3NFw2oBEbBJfWKzp/N
         BE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922511; x=1792527311;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ny40RLCqmtqln21EVFzUzRBxml9MuUjONSew3K/qpUk=;
        b=CWkZ23WWu8NMn92/MRqVWRl3S7Z7rIcBS/Caj2nrVXeg53O2mk9LezHlg3+X4SuIRH
         RHMDKH5hfFKcuis+oAOtLguOTROYrhwVR+zckLemHM11GZUbA0ZLbhaO3f2/LODFeT9i
         BJop4CD98oO+p6JUiv85ecY1OdpfUSs9vIly9yLpUrsel7B4c5CQ37hXLccN5jLB6cHo
         z0MeybX/sBjGU7ca2bykqY9f003rspWcw9eBdqU91U49GZBcACtZhpRdUxsMWV4Lowy6
         ZbXv3tCar+aOWHcBMSMigvUKVlJK0FrfqLVY5tnYR1LiSVWnkBt8+QZNe2aGjNGhMC6Q
         DcGQ==
X-Forwarded-Encrypted: i=1; AKwUvByKsWz5pHD+u2QOTjcSwIcBlNDqLJlrRAZTlcHBl+UxHREIT7MdBAeM2eg8B+30eiou1ljgCV0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDxSOSsH0rf15N3/HnBwUH2hkJXPdZ4epApNQLf9jgVzpftB7o
	HRkOB9+HktXANCI/zdxMSY0E84pOvmZzQ27tngvuJYU8Uwf+TjqwefOIvConNslc3i+FP4uQSXU
	pAdvN2Znods3tQ+mIO8f4JEYgHHvO9WTqk4e+Ws8LkSOH0eVVUssx48um+w==
X-Gm-Gg: AYBFou2XzUZV8ncvrkvcAidr0Wo1tvRh0eF82IanZShGDqPX5rXnS/NptffzxpUKyNt
	mVTLKkJCJKxk7FApc/59mFAnhBBzP1RFcnIj36HooTaPhvQCXyVe7Vzl/DYvbeKrJwnsyMRCOLt
	BuEGRYT/qIPm6yfXY03fXv8l0+Ul1XxruKdnhZosjbSkVtWbCTZgX7yU9EeEF2ZyUAC2MEShXJA
	GE34YcitjPmOnAJQpMg+xe2WAfS5z22uTNi2Gz5fwwNgw6q4Y4fvGxoEuaKWKARBOvAser1bdd1
	jXnMgKrnkfOaG/QLUyCxZJpO8B2ZW05If+t2h5NWAptEpaMZ90dLyIjPEYYxGukERBLnVg==
X-Received: by 2002:a05:600c:548d:b0:4a1:71e5:9420 with SMTP id 5b1f17b1804b1-4a18e49c128mr273547085e9.13.1791922510852;
        Tue, 13 Oct 2026 13:15:10 -0700 (PDT)
X-Received: by 2002:a05:600c:548d:b0:4a1:71e5:9420 with SMTP id 5b1f17b1804b1-4a18e49c128mr273546465e9.13.1791922510283;
        Tue, 13 Oct 2026 13:15:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b3602990sm8945025e9.0.2026.10.13.13.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:15:09 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:15:06 -0400
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
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261013145937-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
 <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
 <20261013070549-mutt-send-email-mst@kernel.org>
 <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>

On Tue, Oct 13, 2026 at 09:03:04AM -0600, Willem de Bruijn wrote:
> On Tue, Oct 13, 2026 at 5:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 13, 2026 at 06:58:41AM -0400, Michael S. Tsirkin wrote:
> > > A virtio net header can place CHECKSUM_PARTIAL at any in-packet
> > > offset.  If that state is retained, later checksum completion can
> > > modify the packet after protocol processing has made decisions from it.
> > >
> > > Let's fix that: let's validate csum_start and csum_offset and only keep
> > > CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> > > UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> > > headers.  Complete other non-GSO checksums immediately, before any
> > > protocol processing runs.
> > >
> > > We can't easily "complete the checksum" for GSO we don't recognize - GSO
> > > assumes knowledge of the protocol. We could segment ignoring the
> > > checksum then do whatever csum_start and csum_offset say, but that
> > > seems like an overkill for something that should happen.
> > >
> > > UDP tunnel headers get the same handling on the inner header.
> > >
> > > Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
> > >
> > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Assisted-by: LLM
> >
> >
> > I forgot reported-by tags:
> >
> > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Reported-by: Chris Arges <carges@cloudflare.com>
> >
> >
> > > ---
> > >  include/linux/virtio_net.h | 151 ++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 133 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > index d6466f96cdd00..b181183118b3a 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -5,7 +5,11 @@
> > >  #include <linux/if_vlan.h>
> > >  #include <linux/ip.h>
> > >  #include <linux/ipv6.h>
> > > +#include <linux/netdevice.h>
> > >  #include <linux/udp.h>
> > > +#include <net/gso.h>
> > > +#include <net/ip.h>
> > > +#include <net/ipv6.h>
> > >  #include <net/tcp.h>
> > >  #include <uapi/linux/tcp.h>
> > >  #include <uapi/linux/virtio_net.h>
> > > @@ -48,15 +52,111 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
> > >       return 0;
> > >  }
> > >
> > > +/* Does checksum metadata match a known TCP or UDP header? */
> > > +static inline bool
> > > +virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
> > > +                                  unsigned int nhoff, __be16 proto)
> > > +{
> > > +     unsigned int thoff;
> > > +     int ip_proto;
> > > +
> > > +     if (proto == htons(ETH_P_IP)) {
> > > +             const struct iphdr *iph = ip4_parse(skb, nhoff, &thoff);
> > > +
> > > +             if (!iph || ip_is_fragment(iph))
> > > +                     return false;
> > > +             ip_proto = iph->protocol;
> > > +     } else if (proto == htons(ETH_P_IPV6)) {
> > > +             const struct ipv6hdr *iph;
> > > +             int flags = 0;
> > > +
> > > +             if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > > +                     return false;
> > > +             iph = (const void *)(skb->data + nhoff);
> > > +             if (iph->version != 6)
> > > +                     return false;
> > > +             thoff = nhoff + sizeof(*iph);
> > > +             ip_proto = iph->nexthdr;
> > > +             if (ip_proto != IPPROTO_TCP && ip_proto != IPPROTO_UDP) {
> > > +                     thoff = nhoff;
> > > +                     ip_proto = ipv6_find_hdr(skb, &thoff, -1, NULL,
> > > +                                              &flags);
> 
> Skip this rare case of extension headers?

but then it will be dropped if it's gso. so we can't.

> > > +                     if (ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > > +                             return false;
> > > +             }
> > > +     } else {
> > > +             return false;
> > > +     }
> > > +
> 
> > >  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >                                         const struct virtio_net_hdr *hdr,
> > > -                                       bool little_endian, u8 hdr_gso_type)
> > > +                                       bool little_endian, u8 hdr_gso_type,
> > > +                                       bool need_csum_check)
> > >  {
> > > -     unsigned int nh_min_len = sizeof(struct iphdr);
> > > +     typeof(skb->transport_header) old_transport = skb->transport_header;
> > >       unsigned int gso_type = 0;
> > >       unsigned int thlen = 0;
> > >       unsigned int p_off = 0;
> > >       unsigned int ip_proto;
> > > +     bool csum_partial_ok = true;
> > >
> > >       if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
> > >               switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> > > @@ -69,7 +169,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >                       gso_type = SKB_GSO_TCPV6;
> > >                       ip_proto = IPPROTO_TCP;
> > >                       thlen = sizeof(struct tcphdr);
> > > -                     nh_min_len = sizeof(struct ipv6hdr);
> > >                       break;
> > >               case VIRTIO_NET_HDR_GSO_UDP:
> > >                       gso_type = SKB_GSO_UDP;
> > > @@ -104,11 +203,11 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >
> > >               if (!skb_partial_csum_set(skb, start, off))
> > >                       return -EINVAL;
> > > -             if (skb_transport_offset(skb) < nh_min_len)
> > > -                     return -EINVAL;
> > > +             if (need_csum_check)
> > > +                     csum_partial_ok =
> > > +                             virtio_net_csum_partial_ok(skb, hdr_gso_type);
> > >
> > > -             nh_min_len = skb_transport_offset(skb);
> > > -             p_off = nh_min_len + thlen;
> > > +             p_off = skb_transport_offset(skb) + thlen;
> > >               if (!pskb_may_pull(skb, p_off))
> > >                       return -EINVAL;
> > >       } else if (gso_type) {
> > > @@ -158,8 +257,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >               case SKB_GSO_UDP_L4:
> > >                       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > >                               return -EINVAL;
> > > -                     if (skb->csum_offset != offsetof(struct udphdr, check))
> > > -                             return -EINVAL;
> > >                       if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
> > >                               return -EINVAL;
> > >                       if (gso_type != SKB_GSO_UDP_L4)
> > > @@ -167,10 +264,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >                       break;
> > >               case SKB_GSO_TCPV4:
> > >               case SKB_GSO_TCPV6:
> > > -                     if (skb->ip_summed == CHECKSUM_PARTIAL &&
> > > -                         skb->csum_offset != offsetof(struct tcphdr, check))
> > > -                             return -EINVAL;
> > > -
> > >                       BUILD_BUG_ON(TCP_MIN_GSO_SIZE * GSO_MAX_SEGS < GSO_MAX_SIZE);
> > >                       gso_size = max(gso_size, TCP_MIN_GSO_SIZE);
> > >                       break;
> > > @@ -191,6 +284,17 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >               }
> > >       }
> > >
> > > +     if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && !csum_partial_ok) {
> > > +             int err;
> > > +
> > > +             if (skb_is_gso(skb))
> > > +                     return -EINVAL;
> > > +
> > > +             err = skb_checksum_help(skb);
> 
> Instead of this variable csum_partial_ok and this branch, could
> virtio_net_csum_partial_ok just call skb_checksum_help directly and
> drop VIRTIO_NET_HDR_F_NEEDS_CSUM?

no, hdr is const. and I think I like it that way. we could
copy flags I guess - I'll play with it a bit.


> > > +             skb->transport_header = old_transport;
> > > +             return err;
> > > +     }
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -198,7 +302,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> > >                                       const struct virtio_net_hdr *hdr,
> > >                                       bool little_endian)
> > >  {
> > > -     return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
> > > +     return __virtio_net_hdr_to_skb(skb, hdr, little_endian,
> > > +                                    hdr->gso_type, true);
> 
> Would be great if we can avoid the extra arg and having to update the callers.

There are 2 callers why is this a concern?

But yes the extra bool is kinda ugly. i'll look into refactoring
this but i do not think the diff will be smaller - likely larger.

> > >  }
> > >
> > >  /* This function must be called after virtio_net_hdr_from_skb(). */
> > > @@ -293,6 +398,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >       unsigned int inner_nh, outer_th, inner_th;
> > >       unsigned int inner_l3min, outer_l3min;
> > >       u8 gso_inner_type, gso_tunnel_type;
> > > +     __be16 inner_proto;
> > >       bool outer_isv6, inner_isv6;
> > >       int ret;
> > >
> > > @@ -334,7 +440,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >
> > >       /* Let the basic parsing deal with plain GSO features. */
> > >       ret = __virtio_net_hdr_to_skb(skb, hdr, true,
> > > -                                   hdr->gso_type & ~gso_tunnel_type);
> > > +                                   hdr->gso_type & ~gso_tunnel_type, false);
> > >       if (ret)
> > >               return ret;
> > >
> > > @@ -352,8 +458,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >                       return -EINVAL;
> > >       }
> > >
> > > -     skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> > > -                                              htons(ETH_P_IP));
> > > +     inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> > > +     skb_set_inner_protocol(skb, inner_proto);
> 
> Can drop

It is here because inner_proto is used below, seems silly to re-compute
when we have it.


> > >       if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> > >               if (!tnl_csum_negotiated)
> > >                       return -EINVAL;
> > > @@ -368,7 +474,16 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> > >       skb->inner_mac_header = inner_nh + skb_headroom(skb);
> > >       skb->transport_header = outer_th + skb_headroom(skb);
> > >       skb->encapsulation = 1;
> > > -     return 0;
> > > +
> > > +     if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > +                                            inner_proto))
> > > +             return 0;
> > > +
> > > +     if (skb_is_gso(skb))
> > > +             return -EINVAL;
> 
> This is a risk the commit message will have to call out.

I tried but good point, not enough.  Will do.

> I don't see a simple way around it. We discussed segmenting here too,
> but that requires intrusive changes to all callers too.
> 
> Alternatively,
> 
> 1. call segmentation, but only to see it remove the SKB_GSO_DODGY and
> thus verify that the TSO/USO packet is valid. Still drop otherwise.
> This also does not add overhead, because it would be called later
> anyway.

Yes, I implemented this originally. It's an even more messy code but the
big issue is that it's not clear it is worth it. So we get gso with
a bad checksum. Currently it goes out on the wire corrupted. Ideally
we would do exactly that, but that would mean much more work that
SKB_GSO_DODGY play. Conversely we could just ignore the
checksum hints. Then the packet would go on wire because we
"fixed" it but it just has a chance to cause even more problems.
So... shrug. I opted for the simpler way.


So... shrug. I opted for the simpler way.  If a real workload shows
up, the counters in the last patch will tell us and we can revisit.

I will add this to the cover letter I feel, not commit log material,
right?

> 2. a failsafe off-by-default sysctl + static_branch that skips the
> drop when set. Messy, but so is the situation we're dealing with.

good idea, I'll add that.

-- 
MST

