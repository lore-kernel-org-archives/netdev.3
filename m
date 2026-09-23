Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205FE33936F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126851; cv=none; b=C6mBL9Ffz1TNZD9xtRqDUwHwrQkmXtD1mmRywyXrekSru2cpoqWNADmtFO/E4gUZv4OTC4jgXYIszwBGnKjPwcTpEsDjPT2PiStbQsHyMWS1Ekuwco35VVaqFbjVuE7wzA6BX6PjSFLYeLml+4l2YSuxURj622Mm13wc1Q4lXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126851; c=relaxed/simple;
	bh=MWZEeEEHXxP0UMNeEEcffTntxJwcZE16u9STmxmylgs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Q7pc7idaz90BksMyV6OMtv7I/cGngk72JkfDMMmheNnqo5MjYV2DSytco54eZHWRdxb4z3UK2z5dPimJ9rKZKC6Gaq2oaaD3m9SlSgU3y5FE+BhxyMVkOmKTknR0S/CmLHyMTIl75Mu2z1OiuV+T2+Trr09fEab0Vz0yEt6VIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBbc9Cy/; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBbc9Cy/"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-8716a5baf64so6603567b3.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790126848; x=1790731648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lWen8M3Dy9y4fMx+Bf5KiQ+THttX5a/EDRsfysX8uYE=;
        b=ZBbc9Cy/EYasTbBOc4eTC8ZPohEoDvIRmxx+1fOsWfRxpMXWytFzO6Vu/MxEeWkan4
         d8aA3CZpTnw5bzhuKkRvgzlu1X4QC5T2MWCLiP2Y1WiiVIu6oykqAYodsLhB3NklCyey
         pqKD2ISqRexRkV+vdm1c0V5Uw2YJ0bfOjC2bbvdS4ZjXoUbycMEtZx3gLyYNd4FEi5Le
         n6wGc7ec3ToAUEuFQMcDRyowZqROeAqjbo+jVT4W4SMirNm9Cu6br67gThtYP1LVJjPZ
         Pn7GSRxjX0UN5hgFP5wbVUjwXgzSL/3RHjBbBG+aapx07xB/5WvjokxdInk+0MY7XOv+
         2Psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790126848; x=1790731648;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lWen8M3Dy9y4fMx+Bf5KiQ+THttX5a/EDRsfysX8uYE=;
        b=oSIXmEJRtZfu/uLx7lRto4Bgwj4wgaszvajDly3NH2uGDytofazRsA62FBvi5rntMP
         LxUnjqt/kGGUC77QyAx2s5sJbEg6oVwALbogWHdA0hIYOZ/l2DkpLJFsCfMcVAlQt7ca
         wUjlL1a+rEKrWmi5cdCswcBHRFbwWsynkPFr0rG11hsXxVBwn61r2T9fAmwMoSUnIcz6
         l9y4m/PwhwRDk3VKivm2/GkMCy2jBWqsx9QWuz/GiS3G0wan7rOLCDdzROrivUgyt5x0
         FRqx0kORfkX5k5EFICMtpbJg1dejKAfmz65EAYvm+xwNWuBua1PUtMASvE94fiqkaRtu
         t6XA==
X-Forwarded-Encrypted: i=1; AKwUvBwAP4FeANap+Ns99h7eEVBZrg97cBi65n66tVWMJgHjCuTxBkyvTbPbbfosHixM2yHyV2R/wJ4=@vger.kernel.org
X-Gm-Message-State: AFuF++nPVN52SUycNKB+OkFcYk4L2/bKwaT22m8xSjAtxIwsXJdRUsQk
	qSYb46SPK92brSqEAgrNFleE+/xqsGZ6rphCXRgP6PvZoa4z+5/VKUA4
X-Gm-Gg: AYBFou2wLNglT/gG3poQ7QZo9saBTBtfhrCNjtyqtSBDYOCpEfw2LJrKADPKBjX+E2H
	Y2C0kqHwtOh60gNcT39K2MoQD+k0mzFQMTWzY7g4l0CUxobYVmNYzgDbZx5n5pHI8TtvP750nKe
	FCFnV+eUqR9h6my67vGyfeS/qpy8GNPYqyXKyiHITDqL12qjgc3R/13JQ6rm9a9tw7bKKiJNIIX
	yinIJb9TbIAPCCJrbdRsdqciX81rwbdRx1fhD1YhglXGDOS64pv7hZwVamajYe9Uzhbbp64PgmY
	SynlxZciORuRSf8G4+9nvHhLQDipS0rNR8kHrKkQ32/Zn0Z7YOgRC8nO5fKzFaZ4M08M0feWLEq
	7yd0CJQ/u+Bmn18IevNi4LUsJK28cWbMBOLVDCnDFcmSG3gstrusc3gJTyzfbtvG34vl0w8Ncqe
	n27COnLSDohPWh6xGe/kQkAtsV4KvA+YL/ViE8KXabPzF1ewLcg/bvjiVwZXceiKiVxv2AKCxAK
	Ygv1S4jE9lYqd2n/aGl+5uQK2MDlqHr0RU3n4qj12t0K3QwPhlI
X-Received: by 2002:a05:690c:a703:b0:87c:32da:de03 with SMTP id 00721157ae682-8a45bb75aeemr4672467b3.69.1790126848128;
        Tue, 22 Sep 2026 18:27:28 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a465dc9ebcsm4427937b3.20.2026.09.22.18.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:27:27 -0700 (PDT)
Date: Tue, 22 Sep 2026 21:27:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Paulos Yibelo <habte.yibelo@gmail.com>, 
 netdev@vger.kernel.org
Cc: richard@nod.at, 
 anton.ivanov@cambridgegreys.com, 
 johannes@sipsolutions.net, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 andrew+netdev@lunn.ch, 
 pablo@netfilter.org, 
 fw@strlen.de, 
 phil@nwl.cc, 
 razor@blackwall.org, 
 idosch@nvidia.com, 
 dsahern@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 linux-um@lists.infradead.org, 
 virtualization@lists.linux.dev, 
 netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, 
 bridge@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2cdfef118aa1d@gmail.com>
In-Reply-To: <willemdebruijn.kernel.259bc7096258d@gmail.com>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
 <willemdebruijn.kernel.259bc7096258d@gmail.com>
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Paulos Yibelo wrote:
> > __virtio_net_hdr_to_skb() checks a minimum network-header length for
> > CHECKSUM_PARTIAL packets. Its checksum start is relative to skb->data,
> > but some callers have not established skb->network_header when they
> > convert the virtio header.
> > 
> > Pass the data-relative L3 origin explicitly. Ethernet receive paths
> > parse the frame and nested VLAN headers without changing skb state.
> > AF_PACKET uses the frame's actual L3 origin even when the socket
> > protocol is ETH_P_IP and the raw frame carries VLAN tags. Non-Ethernet
> > AF_PACKET devices retain their established skb network offset.
> > 
> > Also pass the actual L3 protocol so IPv6 packets use the 40-byte base
> > header minimum even without TCPv6 GSO. IFF_TUN obtains that protocol
> > from the packet before skb->protocol is set. Name the Ethernet parser
> > accordingly, use the same origin for tunnel validation, and propagate
> > conversion failures in UML.
> > 
> > The bound remains a minimum; fragmentation paths separately validate
> > the parsed IPv4 or IPv6 header length before completing a checksum.
> > 
> > Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_net_hdr_to_skb()")
> > Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Link: https://lore.kernel.org/netdev/20260920004733.6473-2-habte.yibelo@gmail.com/
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > ---
> >  arch/um/drivers/vector_transports.c | 13 ++++-
> >  drivers/net/tun_vnet.h              | 52 ++++++++++++++++-
> >  drivers/net/virtio_net.c            | 10 +++-
> >  include/linux/virtio_net.h          | 87 ++++++++++++++++++++++++-----
> >  net/packet/af_packet.c              | 24 +++++++-
> >  5 files changed, 163 insertions(+), 23 deletions(-)
> 
> The fix may still miss the case IPv4 packets have options.
> 
> This version is a very large patch.
> 
> Untested shorter first suggestion by bot, which looks plausible as a
> starting point for discussion.

Cleaned up some more:

    diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
    index f4c652b1fa44..c24607af2aad 100644
    --- a/drivers/net/tun_vnet.h
    +++ b/drivers/net/tun_vnet.h
    @@ -180,6 +180,9 @@ static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
     static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
                           const struct virtio_net_hdr *hdr)
     {
    +    if ((flags & TUN_TYPE_MASK) == IFF_TUN)
    +        skb_reset_network_header(skb);
    +
         return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
     }
     
    @@ -199,6 +202,9 @@ tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
                 struct sk_buff *skb,
                 const struct virtio_net_hdr_v1_hash_tunnel *hdr)
     {
    +    if ((flags & TUN_TYPE_MASK) == IFF_TUN)
    +        skb_reset_network_header(skb);
    +

    diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
    index c381b916c1b5..02c448de0802 100644
    --- a/include/linux/virtio_net.h
    +++ b/include/linux/virtio_net.h
    @@ -48,6 +48,42 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
         return 0;
     }
     
    +static inline int virtio_net_hdr_nh_min_len(const struct sk_buff *skb,
    +                        unsigned int nh_min_len)
    +{
    +    int thoff = skb_transport_offset(skb);
    +    __be16 proto;
    +    int nhoff;
    +
    +    if (skb_network_header_was_set(skb)) {
    +        nhoff = skb_network_offset(skb);
    +        proto = skb->protocol;
    +    } else {
    +        if (unlikely(thoff < ETH_HLEN))
    +            return -EINVAL;
    +        nhoff = ETH_HLEN;
    +        proto = eth_hdr(skb)->h_proto;
    +    }
    +
    +    if (eth_type_vlan(proto)) {
    +        proto = __vlan_get_protocol(skb, proto, &nhoff);
    +        if (!proto)
    +            return -EINVAL;
    +    }
    +
    +    if (proto == htons(ETH_P_IP)) {
    +        const struct iphdr *iph = (void *)(skb->data + nhoff);
    +
    +        if (unlikely(thoff < nhoff + sizeof(*iph)))
    +            return -EINVAL;
    +        nh_min_len = max_t(u32, iph->ihl * 4, sizeof(*iph));
    +    } else if (proto == htons(ETH_P_IPV6)) {
    +        nh_min_len = sizeof(struct ipv6hdr);
    +    }
    +
    +    return nhoff + nh_min_len;
    +}
    +
     static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
                           const struct virtio_net_hdr *hdr,
                           bool little_endian, u8 hdr_gso_type)
    @@ -98,13 +134,15 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
             u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
             u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
             u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
    +        int min_thoff;
     
             if (!pskb_may_pull(skb, needed))
                 return -EINVAL;
     
             if (!skb_partial_csum_set(skb, start, off))
                 return -EINVAL;
    -        if (skb_transport_offset(skb) < nh_min_len)
    +        min_thoff = virtio_net_hdr_nh_min_len(skb, nh_min_len);
    +        if (min_thoff < 0 || skb_transport_offset(skb) < min_thoff)
                 return -EINVAL;
