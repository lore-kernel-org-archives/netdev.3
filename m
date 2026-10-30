Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400595;
	b=2XF0ENZddRPY3YpZ6+oSriePGDN7sUiMFaaSlz0AKQ5/oQQZWH6PG25omNQUNtdHUOPC
	 TeAfW6zqUQQvCHSCJPCjDStjtoT2p+hzxMIRqQ77bUKZe88Q9EZmKLfXCEAmaIFliG41q
	 CQJyjR5wxt6FHWBjLmsaBN5GJKhUhVUwMrGvJMY0Dr6YEEIymXnte8JbByMtmRW6vw2xW
	 6nOsujSYv/xnZ+SN33TTzcH1xCIMu/VJLmBsZFyZKT8MS/oUmcuTEqAf6erBcgI4ZJdwj
	 DmEWCmoIrwKGi+ajzy8LZxsDmtUjq79Bg3IsjhHRc75JCD8G1HU0gn+mjm17lFcBlIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400595;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+T9BCD4WHAeHhgAEVu7K97ymFe/bRNG12NnyP6fiFZk=;
	b=IlUSaicRy3wjsoE3YRd5jGdFHIG0dx8u3NeZhU2lHOjj5+KVKRt/+33JnCezmemgKKNJ
	 cWv1nY8As3et7qoezCbbAVsTIANrDLBHXn4uJRVqiQrbcd6FRp2geP1CBIyzgdaN197zS
	 1BI/Fqh05Y0QEJ6Q9uxCRO4FRBpum9TBQl9d6RSU/yEfHNvKIWr4GE3nSZA334Q350EWv
	 1Cd3aZUVL+P/QyQZh5LKJUxfzkZpmhlfjePNU4Dz0cR9Ysym5BCr/05Dt8oAzyMTx8FMj
	 P6NRR1ZJ41+aEZw028kIj+kh/vjo5NK/UN7ERGljql4nzSTy0XlLzYMo3VRmrWaz9dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pxy4fQ2u;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oaWb7p3H;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FF4606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07FF4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pxy4fQ2u;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oaWb7p3H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793400593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+T9BCD4WHAeHhgAEVu7K97ymFe/bRNG12NnyP6fiFZk=;
	b=Pxy4fQ2uW7rA1gS1nswrtud4oKoBldxUpaF46GJK1vxdEiJPGO6Vj662LGx63kFJakw50V
	pA7EeQjetWxxJcVwqXfTZwz1FwaxIQ6pfwDP76Mnv0g/jvhvTq6qSrnNcsdlmoOm9T89ZU
	MvjcNPdurKiAK+vwQFT1+dk8jWp7qXI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-16XkUxWWPaiOM_bDLEHAVw-1; Fri, 30 Oct 2026 18:49:52 -0400
X-MC-Unique: 16XkUxWWPaiOM_bDLEHAVw-1
X-Mimecast-MFC-AGG-ID: 16XkUxWWPaiOM_bDLEHAVw_1793400592
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso10405395e9.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 15:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793400591; x=1794005391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+T9BCD4WHAeHhgAEVu7K97ymFe/bRNG12NnyP6fiFZk=;
        b=oaWb7p3HPm1mrzmvjrrcD+rOOBFyNsI8emRPZ5AatU7kaZAZrx8guT4wTF63JJQorQ
         Y1BY5gLgakr6iMvTeSPMe4ugW4tTRGytqCMpW1rm5pR91agRoDR+S7JsVxFNqNZouGQM
         tGM8I/CGzI2jA9V3P1cRsH8h9VR57LKOD4/79SJnOIRlBpw1Xm7ffbNnmIHilX5I98Gg
         2XHalYTUxfp9mrI5qDBSO+z66INAtJjiyGV8N7j0SozuGYRDxAOmjcXKm786iH5m6go1
         E2j8UKQ8GdE9SHDQzn8uZsP/xlIWKS0m4dzqNZjehYbaNT2qVEXKI2V+7YBviY0aMnuW
         Alwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793400591; x=1794005391;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+T9BCD4WHAeHhgAEVu7K97ymFe/bRNG12NnyP6fiFZk=;
        b=Uaxfs55upa4J7WYvtftXorsT/mGO6hYp6+P6jBxnLCVXvqk5HrDy+J3T1MAvg7nijM
         1NQpsExovXFZ4IIBhKFpKpl0EWMjohcm9q9J3y4EkzcJ2GTc291EfRAvgtRZ9LQT4Byo
         zLMFfq6Ofz3FtnvjGrz5yZ2NaFAC2KhGoLZoyZCvGjxO/XSK5PSvzuVVascsvkEum/eL
         MjTRzeK9bLH0hRlLe2OvG7ibtsZxwBMCHE5myk+wpom84ONpjDWFETmY/5Mx4cWP7COD
         TM8/0+y+Ts1357gbCk1CMr8dL8TMZG3n5/7+jysW8Qb8nOD1HiBiRWPhNzWFhWI5daVH
         u2oQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4hvcPqBItqTZBpVCan3pzZq8LxvtsGY/KBj+URdhY8Nw0Gjx3669PVWEpuj8q7Dd88jEQT2I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtFUZceow10aOQJVmmJTR4b9Rb5ec46hGqpHR9CzJ9Xd/Crvjt
	lGyjauFiC1Me/5+hT4Zth9WJbbvATi8yC7az/mj6ntpsL1PFAUS4y6LswXNupHR8GBMuWOYoGJo
	4rAacTxnyvlVF9AFkzfGeOFt2DPHH8HX+/WXiuyJDmZtsgWWMIljet/HmWQ==
X-Gm-Gg: AYBFou1srfEn5eeu8VGNc4LjLzivoyjmG7CDDy2P0ujQ5vvPnzJevH1PBEtiZj40brT
	EbGY1Iin0tnM0SAhaGTPS8yOGKtsD6xERck1jbhtgG0ARbzsKhat7qHBrNi50fS6w1YnK18GhwS
	uMbkJ47wd1LNxRzzhng72+2LOFgVrpiXmFJMsJudWqAolATEwM0sARL6N6RvGUFYx5+gpC5YGYD
	7vDNSFtY0PJQ6SOZs/GsvWeTiY0t1kiBQPBu4nic1yPyyI09rXiBk2KBgH3VYsD5PH43Ib4V8kx
	coIzDvqaRX9gYf/kqrhWjbis/p9bzPDVAfr71S3X0xU0Xo6Um/6bXuf7wDfPxXC5i9+P/pxHJSU
	Ht4RuYp/aUOq5zYcEsrKFxmeJf1AzfkXPnoaNv8T7RnjC
X-Received: by 2002:a05:600c:46d1:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4ac17b2c8a7mr81098155e9.25.1793400591320;
        Fri, 30 Oct 2026 15:49:51 -0700 (PDT)
X-Received: by 2002:a05:600c:46d1:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4ac17b2c8a7mr81097795e9.25.1793400590841;
        Fri, 30 Oct 2026 15:49:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf0b36853sm80313395e9.0.2026.10.30.15.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:49:49 -0700 (PDT)
Date: Fri, 30 Oct 2026 18:49:46 -0400
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
Subject: Re: [PATCH RFC v7 4/5] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261030184752-mutt-send-email-mst@kernel.org>
References: <cover.1793276116.git.mst@redhat.com>
 <93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com>
 <willemdebruijn.kernel.10a41a35b45f6@gmail.com>
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
In-Reply-To: <willemdebruijn.kernel.10a41a35b45f6@gmail.com>

On Fri, Oct 30, 2026 at 03:21:57PM -0400, Willem de Bruijn wrote:
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
> > Note that for zero copy, userspace can change the data after the
> > checksum has been calculated.  This is fundamental to zero copy by
> > design, and the only outcome is a bad checksum and a packet drop.
> > 
> > To mitigate the risks, the following patch will add a sysctl knob to
> > bypass the resolution. This is reasonable if the setup is such that
> > there is no protocol processing at all.
> > 
> > UDP tunnel headers get the same handling on the inner header.
> > 
> > Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
> > 
> > Note a fundamental limitation of this approach: an nf/BPF program
> > that tweaks the payload of a packet in flight may rely on the
> > checksum being fixed up later, assuming the packet carries
> > CHECKSUM_PARTIAL.
> > 
> > For metadata that fails validation the checksum
> > is now completed at input, so such edits leave a stale checksum
> > and the packet is dropped at the receiver.  Protocols whose
> > transport header we cannot parse (anything but TCP and UDP) are
> > affected even when the metadata is self-consistent.
> > 
> > The sysctl added in the next patch is the escape hatch for these setups,
> > but it is a very blunt tool.
> > 
> > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Reported-by: Chris Arges <carges@cloudflare.com>
> > Tested-by: Chris Arges <carges@cloudflare.com>
> > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
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
> > +			/* Find the transport header behind any
> > +			 * extension headers, AH included.
> > +			 */
> > +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> > +						  &flags);
> > +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > +				return false;
> 
> Minor, not cause for respinning on its own.
> 
>     `flags` should include `IP6_FH_F_AUTH` so `ipv6_find_hdr()` stops at
>     `NEXTHDR_AUTH` instead of skipping it:
> 
>     - `CHECKSUM_PARTIAL` and GSO behind IPsec AH are invalid: AH authenticates
>       the inner L4 header including its checksum field
> 
> > +		}
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> 
> > @@ -368,6 +660,21 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
> >  	skb->transport_header = outer_th + skb_headroom(skb);
> >  	skb->encapsulation = 1;
> > +
> > +	if (!skb_is_gso(skb)) {
> > +		/* Too small to segment: complete the checksum in place
> > +		 * instead of dropping - senders do tag small packets
> > +		 * with GSO headers, e.g. packetdrill sets gso_type and
> > +		 * gso_size with --mss, whatever the packet size.
> > +		 * The outer UDP checksum is not calculated, but a zero
> > +		 * one is fine: UDP over IPv4 allows a disabled
> > +		 * checksum, and so do tunnels over IPv6 where the
> > +		 * receiver opts in (RFC 6935, RFC 6936).
> > +		 */
> > +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> > +					       SKB_GSO_UDP_TUNNEL);
> 
> Maybe this carve-out for non-gso packet is best moved to its own
> patch, as that is where the remaining issues (to merging the rest)
> seem to be.
> 
>     1. Moving `!tnl_csum_negotiated` below `virtio_net_csum_partial_ok_at_offset()`
>        accepts packets with an unnegotiated `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM`
>        flag whenever inner validation falls back to
>        `__virtio_net_resolve_csum_partial_mismatch()`.
>     2. `__virtio_net_resolve_csum_partial_mismatch()` calls `skb_checksum_help()`,
>        which completes only the inner checksum at `hdr->csum_start` and sets
>        `skb->ip_summed = CHECKSUM_NONE`, leaving the outer UDP `uh->check` with
>        an uncompleted pseudo-header checksum seed.
> 
>     Despite the comment, this block neither completes any checksum in place nor
>     is the outer UDP checksum zero when `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM` is set:
>   
>     - With `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM`, the outer `uh->check` carries the
>       non-zero pseudo-header checksum seed (as expected by
>       `__skb_udp_tunnel_segment()`), not `0`.

Oh yea i kept tweaking this and forgot to update the ocmment.

>     - Clearing `SKB_GSO_UDP_TUNNEL_CSUM` on a `!skb_is_gso(skb)` packet leaves
>       `skb->ip_summed == CHECKSUM_PARTIAL` at `inner_th` with nothing completing
>       the outer `uh->check` on transmit/forwarding (`validate_xmit_skb()` only
>       completes/offloads the single inner checksum, emitting a corrupt outer UDP
>       checksum). Even zeroing `uh->check` would be invalid over IPv6 unless the
>       receiver explicitly opted into RFC 6936 (`UDP_NO_CHECK6_RX`).

Indeed.

> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > MST
> > 
> 

