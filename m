Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541132;
	b=xY+4bFHmKEREB3n9ow9ix/7JozFXliq3U6eYMYcH9ZKFiDj7LmgH4U4zykafFpcwn4LU
	 bbLZ9AKu+hwiDykO1aK8+ImYYUKVCsB2x2a/iYdAIHe8U7CqhgfZr/xijdMGcy9+TrDBi
	 FIatOXDEqaiONDq8+osxMGZDP0l/LdcIoBYmcOdsOriLSscMOY6szjMF/WTjq8cg8MF37
	 8CbQ5f/JckCy/Ef6DUpzR2MlT6qsF3vV6BXVNkqMGILlntKjcw4yLJ4+PF6UQqqMmk8uS
	 ToyYtatFbVdMCq7MzncEjkNuS4ohONH+af8f6SRP4+/32e9FJo/2IwQQQq5VEr6iTKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9KmVjMJTY8zcLg9QfQKrHKxwneViwt4HwZ1IqLmXRp8=;
	b=u3a4Cc5qM5nXJfYOjKohmwqYYy76XrYFQzkhAtipTkeBjlb8j7gVJRoqkJd4FYaVDyrI
	 0LPKUKVIaguko7lk5HvGscaN0jWaPjHd1myAfSNrfCrfb0dTTTeuH6MB+suHlpXZEv03M
	 vMtVPcPfkJU3ZTXgnQZfhzH+jLp+BLMIS0s3X+Fm0RqYGSkA8lAAZYdi3iYjmGR78VQzh
	 m6gbu2cSOJzxbtDAFIWTEbrT/qvQuiPyN2TEpO0t7lyR9gXx39w/uw+X7JziTUALD5Xkp
	 SyrIpP+qTlSJZ4oP8LBD1Zer+lH+HF6Fjrwk7yFWjzvopM4bQ2uptGjWV+uRFPUa3XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oheBebjs;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5832606A320
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5832606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oheBebjs
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5e931215e5fso77901e0c.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792541131; x=1793145931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9KmVjMJTY8zcLg9QfQKrHKxwneViwt4HwZ1IqLmXRp8=;
        b=oheBebjsamFrOmbLheQaS9kwhGj2/5c8GFJHxr1Jfk8Ef0D34wwjyBvsEuKf35hI0e
         ztFETiGiNiTqwzVtvgcutrbe8xxY0xHvKLB2UNa5RoZIS0HWDfL6Dvty6FSovI5n6Xku
         /KfXaRvgxwuzIdR4tzYn/Bt8iOegGcUfGHNA0QmVwZBoJ304o/WuLdOjczSNAyjAhMV2
         wgaMP6IwezPX6lF2zR8kRvmI/0gArW9734zefhGoFIFVpLLtAltqkztEsqTKHt3s1XjX
         y7WuFnIyWIxtggIiJJe9ZwlTYEbqoZqWc9D7k6qqNmoBMTNJr7xWng2tkaPsVfD9eRFN
         kEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541131; x=1793145931;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KmVjMJTY8zcLg9QfQKrHKxwneViwt4HwZ1IqLmXRp8=;
        b=ln/FULIktwOGSlE62xWOAkgvfdDp2tVUE1kUOThUv0n04wSki0dxXLNlrH/n7EtXD1
         oj/ZlHn9BmZ4Rdk7V8p9xIgTZ+n8pjoy4xZXTOThRITS3o02EMCKLnoc79IlMFNtrb4N
         XmCCPEdCX5UfAd4gUgRvVUaMgVWQFhtB01OtAaeNR7SwEdzto6qX2Imez/x1yWUcf5Fi
         dWkKYlx2nPShxi8iREcdmPmRpmnXIcBuYQdY3Gh+usXZnRAeGXV1bxPjrVtoL+2XA8AJ
         LX6o+Ox11tNSIvXXTPI80eLXgJhnfhrk64M9r4RorgObfcmf8DRaFYx1S5B9/9ZSJcFG
         H9fg==
X-Forwarded-Encrypted: i=1; AKwUvBxI4FUfXg55y5mnLmijfPF6DHH5L1+6xfXbNEGR6lGtsH2tCb2b9/c8nwYoEpK1fvrGG1v0qkY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpaj6ENnKAUqwiNUHrXbp6qSHiKvo/JhN6tHArhaiaoUP/quh0
	6wpYtetkVzuyzigqSZW+uR/tPsQWYgs/CwBuNiqlPIu2J+565aN+xnN3
X-Gm-Gg: AYBFou3ej8atMGyWIiuRYFB+VPfBpAdgAKqMHHJgkK/mkqDy4bup5P9bqF7UuxkaP5j
	YWHpfQCcVPwiGJpfnTFtf/Q3ndV25xBmM6AglJFkEL1CJ7FVzr+l96xRh7HOv3rtxhupKXCtCvV
	WsmP6SzC7EoG0nvoGqBooMYV+Pulq/JYzWBUMT9lGzpXoZL020QVWRCdR/3wq0pVKhDv2/KNO62
	y1kwBCvEuOGV4B2hfcm7pyU7oJxnWchUimx4yT1ScGebtWX6Q1X0ZWy3ax/7LDKuNXU2aJdFR0t
	jzge1qRRFjtCpGii96CVIOXEWKyR21mSyJQM4iKvgQ4ISwSOlvh33Pk3KC4FkL2yUmAXVy9JCuB
	eVbg2CwfqF/oXiKuZSZY407VEVStPvfPIPQa5rCLDH1rwhQFgZpQ6gAzsUdZJ+EB9CDjZEACkDh
	u1P28r9rvj2NOQPu3XoBu+OPBB44/rNW7/8XEN36TcpC0MD9tOwt3pauN/BblJMI9QZ8zLlzBgs
	hoosDtgoCN4xrsuzwAxxwP0xfn6jmSGUMDoqmGAgWzn5ty6aFkVErlMMLwVHpryylSF/1dVH+8X
	xaKG6GJvaRKf2pOcGmfxhArulFDCtSkOZGXipw==
X-Received: by 2002:a05:6122:1d9f:b0:5e6:82ca:c551 with SMTP id 71dfb90a1353d-5eaebef16acmr141977e0c.22.1792541130631;
        Tue, 20 Oct 2026 17:05:30 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae981d239sm1228104e0c.14.2026.10.20.17.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:05:29 -0700 (PDT)
Date: Tue, 20 Oct 2026 20:05:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Paulos Yibelo <habte.yibelo@gmail.com>
Message-ID: <willemdebruijn.kernel.1da723f98c23a@gmail.com>
In-Reply-To: <20261020170908-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <9c08d12b3a7819ae03ded6a154e4f908276e93d4.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.2eb449439b094@gmail.com>
 <20261020170908-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v3 5/8] net: resolve uncommon partial checksums at
 ingress
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Tue, Oct 20, 2026 at 03:44:35PM -0400, Willem de Bruijn wrote:
> > > +/* Walk the L3 header at @nhoff: where does its transport header
> > > + * start, and which protocol is it?  Returns false if the header
> > > + * is truncated, malformed or fragmented.
> > > + */
> > > +static inline bool
> > > +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> > > +		    unsigned int *thoff, int *ip_proto)
> > > +{
> > > +	if (proto == htons(ETH_P_IP)) {
> > > +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> > > +
> > > +		if (!iph || ip_is_fragment(iph))
> > > +			return false;
> > > +		*ip_proto = iph->protocol;
> > > +		return true;
> > > +	}
> > > +
> > > +	if (proto == htons(ETH_P_IPV6)) {
> > > +		const struct ipv6hdr *iph;
> > > +		int flags = 0;
> > > +
> > > +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > > +			return false;
> > > +		iph = (const void *)(skb->data + nhoff);
> > > +		if (iph->version != 6)
> > > +			return false;
> > > +		*thoff = nhoff + sizeof(*iph);
> > > +		*ip_proto = iph->nexthdr;
> > > +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> > > +			*thoff = nhoff;
> > > +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> > > +						  &flags);
> > > +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > > +				return false;
> > > +		}
> > > +		return true;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > 
> > for all this parsing: could we use flow dissection, like the
> > !VIRTIO_NET_HDR_F_NEEDS_CSUM case?
> 
> Hmm I don't see how.  That one trusts the caller's protocol and network
> header. We could parse L2 ourselves and use the dissector for L3+. But
> it stops at whatever it does not know, and every miss would turn into a
> drop or a software checksum for a packet the stack delivers fine.  Our
> parser deliberately covers everything the stack can deliver.

You're right, the protocol and network offset need to be parsed
manually. After that it could be passed to the flow dissector.

Totally untested:

    static inline bool virtio_net_setup_l3_input(struct sk_buff *skb, int *nhoff, __be16 *proto)
    {
        const struct net_device *dev = skb->dev;

        /* Devices with Ethernet framing: ARPHRD_ETHER, loopback, macvlan, etc. */
        if (dev->header_ops == &eth_header_ops || dev->type == ARPHRD_ETHER) {
            if (!pskb_may_pull(skb, ETH_HLEN))
                return false;
            *nhoff = ETH_HLEN;
            *proto = eth_hdr(skb)->h_proto;
        } else if (dev->type == ARPHRD_NONE) {
            /* Raw L3 devices (e.g. tun in IFF_TUN mode) */
            *nhoff = 0;
            *proto = skb->protocol;
            if (!*proto) {
                if (!pskb_may_pull(skb, 1))
                    return false;
                if ((skb->data[0] >> 4) == 4)
                    *proto = htons(ETH_P_IP);
                else if ((skb->data[0] >> 4) == 6)
                    *proto = htons(ETH_P_IPV6);
                else
                    return false;
            }
        } else {
            /* Fallback for other netdevs using caller's network header */
            *nhoff = skb_network_offset(skb);
            if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
                return false;
            *proto = skb->protocol;
        }

        return true;
    }

    static inline bool virtio_net_csum_partial_ok(struct sk_buff *skb, u8 hdr_gso_type)
    {
        struct flow_keys_basic keys;
        __be16 orig_proto = skb->protocol;
        u16 orig_net_hdr = skb->network_header;
        __be16 proto;
        int nhoff;
        u16 csum_offset;
        size_t min_thlen;
  
        if (!virtio_net_setup_l3_input(skb, &nhoff, &proto))
            return false;
  
        skb_set_network_header(skb, nhoff);
        skb->protocol = proto;
  
        if (!skb_flow_dissect_flow_keys_basic(dev_net(skb->dev), skb, &keys,
                              NULL, 0, 0, 0, 0))
            goto restore_fail;
  
        /* Disallow fragments: partial checksums cannot be retained across frags */
        if (keys.control.flags & FLOW_DIS_IS_FRAGMENT)
            goto restore_fail;
  
        /* Validate protocol matching */
        switch (keys.basic.ip_proto) {
        case IPPROTO_TCP:
            if (!virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type))
                goto restore_fail;
            min_thlen = sizeof(struct tcphdr);
            csum_offset = offsetof(struct tcphdr, check);
            break;
        case IPPROTO_UDP:
            if (!virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type))
                goto restore_fail;
            min_thlen = sizeof(struct udphdr);
            csum_offset = offsetof(struct udphdr, check);
            break;
        default:
            goto restore_fail;
        }

        /* csum_start must match the dissected transport header offset */
        if (skb_transport_offset(skb) != keys.control.thoff)
            goto restore_fail;

        /* csum_offset must point to the transport checksum field */
        if (skb->csum_offset != csum_offset)
            goto restore_fail;

        /* Ensure the transport header is linear */
        if (!pskb_may_pull(skb, keys.control.thoff + min_thlen))
            goto restore_fail;

        return true;

    restore_fail:
        skb->protocol = orig_proto;
        skb->network_header = orig_net_hdr;
        return false;
    }
