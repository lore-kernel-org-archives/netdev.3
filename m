Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1C4A498E
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916570; cv=none; b=NVAicu/3iTzx92TUQU0+iaRvb4BGZTNdnJxHjTWu2Iy81vtIdGm6S7ZhociglYN1T0Rh57tvy+hfwWi21SMXu95RndGloXPr69q+Qg4L+8vWbp9R3JpRHsXB8t3j965PdTWjDB8m+TQV8MUxmx5ZGqEG53ka206qJs5P4JkhTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916570; c=relaxed/simple;
	bh=MAxPv79SC7ka08t0N1OqDTI4zs64zksbZuXoiMgh/V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W35YDEPPjO8I8kZfO435RGNCy/6L3KQ5gsRTyl4e4VFTR8nQ1KUPM6gTD6HKhr1vls5Azj62pZpQu6hudkYdBvXj15EFghCAkdc1SbBcjVx7A2HjAFpt2BLrUIlqwGCu9xxeWf/FbCOEay+VpB03L7eVaZWTpy4b2aSdjHGbOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyDAkXX1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rZOlakIH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyDAkXX1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rZOlakIH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791916567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kEbFOpHzK1vzTUUdGzQgP9nZrP1KHSfJ40m7HqU+RSk=;
	b=ZyDAkXX12qkybLWz0/5mPbRVWoR1MCac3VUa+fKlLzFjRHPZ5QGOMI0nzL+2GazDGh8R+K
	lSnSn6Wk3Wwc8Ec8A0dAtVmyrJDJGF1h7RuOQr/HeiWY6PvTy+erDy4oWK/FTVzUmXWV12
	y69XF/5z+pA5pseU01sn3Pz84P5Zbik=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-VT43CtSJPWCMEml2bVJPBg-1; Tue, 13 Oct 2026 18:36:03 +0000
X-MC-Unique: VT43CtSJPWCMEml2bVJPBg-1
X-Mimecast-MFC-AGG-ID: VT43CtSJPWCMEml2bVJPBg_1791916563
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c437ae81eso1885566f8f.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791916562; x=1792521362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kEbFOpHzK1vzTUUdGzQgP9nZrP1KHSfJ40m7HqU+RSk=;
        b=rZOlakIHRlA3te+9smsNDNFlcL9AfV+kcd3b4Qvo7iB33WtJ48RjVmy+BJciPGsJcS
         LaXIUmqvFBlt4X/Pw2nas8s9qGbCZBNFL65UvE7SkbU7md9mFWmObXjB8p1TPV7PigeV
         /iDsOCKtO7cV0u8wIjXrpEo7HN9/wJEoAP4ndgbvUBDzU0ekXSIr/Kouhue+yktOLBSN
         DxxSTDmq+kELjUGFLkXhof5UPwsZrHgv819fJYO8eEQupqk3b6wOrF3ctQ8HPizNyoRw
         SWLChtGeHvZMQVrJjglEtH+LI6+Ye+2heitAvG4WT9CFxI2rccV9fXVHYPaDyFyfLOUG
         /6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791916562; x=1792521362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kEbFOpHzK1vzTUUdGzQgP9nZrP1KHSfJ40m7HqU+RSk=;
        b=eZIx5cHOAorAIRKq8tPfP8+P5lSc9vcWvuvimm4e1u/r57yTvkglfzQwBikrlI+iCd
         ma0tCIYZA9IruqfB7m/XpiYEi/xlo5scwKWK3hgZAP+VemyosMZUhyEXJnCQkGZr+c1f
         O63X+MuLBjbtzAKXHcmrnjRjkj4cfDgNXw7oMx4BR0rr62vonIqOe8gEB9/+7GpdG926
         axnjW7sPTRS6ghl9RJ1QBsFwhYlYdbBMm1TU/6DfXt4CNu7Gd7H+tIMKizIzlEFYY14D
         2zKVabaZzS8OoJmIJYI21ItXg5/EliAp2OpheprFjXWZHDBzLEFanTLRGFCSMbJNFHw1
         xlFA==
X-Forwarded-Encrypted: i=1; AKwUvBwcpCQcBsU+Hv07RVHO+sieHcnd3dvs5A2DNFi6wFXIYsBudSUNjX8EUeJNJW+Pl9J6XXjIhp8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrPEWQCcTvyPeJ9AdyTgIDhjFmUt9bIRo+ydK+C7YXUYy2GHVl
	6CUMFWgm5qun56BQ1oPmhikd+gIXsu5atDVGklOWI1GQzv9z10Myn9kD9HX06EbN8vNaIBGLXbg
	KMNgd51d8jMbhmuNrsmCSVS3eQbN0o7y17fqzuuwlPTEXeXca0IeALoX6OA==
X-Gm-Gg: AYBFou1lZoc4j2HdT2CShBqkbBXUwc+5DqK4YpHAhvcZShX/PKTmZgRIErigcrJD4QC
	w6LX1w8Tfl04AqQljtpEOE0zfJaEF2q5n5joJMMu3H1gohpk6u2laRf6hljl9eap68bcUS5PWKB
	h5LU91ImheYtx1lFQiRhUyEryfhucAzbsfSKOFJHm7P8QaAgf2kKAg8+C+xH9Bx0J4DeMdIbCp1
	5A0txPFHaVCTz5bwxCtWHRo4CquuL2MAw/l5Fp4x1DrkUOFlK9+teWNPVh+iDodLOqNKKr5YjcC
	2owMKF55wgSnvNa1M0tMYd8eYILmKK9Xuv+YKLILBJOG3BXNrWxmcWQPaiSNkGb90VHxoQ==
X-Received: by 2002:a5d:5542:0:b0:487:2777:6354 with SMTP id ffacd0b85a97d-48dbaae7239mr20582207f8f.48.1791916562403;
        Tue, 13 Oct 2026 11:36:02 -0700 (PDT)
X-Received: by 2002:a5d:5542:0:b0:487:2777:6354 with SMTP id ffacd0b85a97d-48dbaae7239mr20582159f8f.48.1791916561732;
        Tue, 13 Oct 2026 11:36:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm8613881f8f.0.2026.10.13.11.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:36:01 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:35:57 -0400
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
Message-ID: <20261013143335-mutt-send-email-mst@kernel.org>
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
> 
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
> 
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
> 
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
> 
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

I tried with this:

	> > > We can't easily "complete the checksum" for GSO we don't recognize - GSO
	> > > assumes knowledge of the protocol. We could segment ignoring the
	> > > checksum then do whatever csum_start and csum_offset say, but that
	> > > seems like an overkill for something that should happen.

I guess I can add a more detailed explanation about what the risk is?


> I don't see a simple way around it. We discussed segmenting here too,
> but that requires intrusive changes to all callers too.
> Alternatively,
> 
> 1. call segmentation, but only to see it remove the SKB_GSO_DODGY and
> thus verify that the TSO/USO packet is valid. Still drop otherwise.
> This also does not add overhead, because it would be called later
> anyway.
> 
> 2. a failsafe off-by-default sysctl + static_branch that skips the
> drop when set. Messy, but so is the situation we're dealing with.

Tack this on top or do you feel it's needed straight away.

