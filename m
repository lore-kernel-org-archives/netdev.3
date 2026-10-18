Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C74A2E24
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340516; cv=none; b=ty1vxS0OMzlf2coYlQkzoCb6UfqwJa33bHWLws0aawnKzvvvf9l/st3bG//YJtrNzZULlNWBuDDa1+6xTkE1j+kiiEGwDCAGdUd+ta9/KKP3XEw318PnsDrsychsNEWk6VK/lf1yr5OViA8DljW1i5cbcAV28Ks9pq3U1xGKD6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340516; c=relaxed/simple;
	bh=st0vO++5Er4odpCXX/Ftnk6EBLXfCc0bNWpChEwT1q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keWxJo6S0FzaS8awh+kyVLcgTUF8YBR5c0zlibDQ7xX65E4S45Trew+OYuqFfXDoAl5YjImBTncjS0buGPPT7WbRai7nAd8kGg41iRRTCDgOmh7Ht/irbuxSNIHl9nId4ZbIoKO23znrFJIiLY854S5z+8rYSeNV5bGjMG4j7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erK8CFgN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpwlTjwq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erK8CFgN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpwlTjwq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792340513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYWhgKkOyBGQpTdOqbbR6FCgBN0C/ix0eXA3fu8Y1OY=;
	b=erK8CFgNXbKiejTJFxNrSfyKjZLNjR/pvzK7exnrP4ca0yG1hMrAUAm0GAgCZc0rvpIeFm
	xzJmId3AeyLZ4Amf+QM6zHY9Q8g6XOkfh8M/7VZVxKkCZGL53dgbz6kpNXXcVQuTr3e/PK
	4YHqE0193X6XS4uvxv8t19kR3EXRjz0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-4LPYHfNfMOqEfFHnGAz1WQ-1; Sun, 18 Oct 2026 16:21:36 +0000
X-MC-Unique: 4LPYHfNfMOqEfFHnGAz1WQ-1
X-Mimecast-MFC-AGG-ID: 4LPYHfNfMOqEfFHnGAz1WQ_1792340495
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0c896d05so813265f8f.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792340495; x=1792945295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MYWhgKkOyBGQpTdOqbbR6FCgBN0C/ix0eXA3fu8Y1OY=;
        b=bpwlTjwq5tKKLpeEaqm6DX01ePY9lvRbFSGdGX8zBXgmiokGfNbGpt3WbBt3DMZBro
         5bpqBPbYUbMC1Qp0PbAngtViuKlK7j2guCKqS8ASKLTYaa9/q5JMB8pJrNTdbqkhDbXx
         CW30MJjQuzxUJJmcKdLABUCos+uqw3wg1/J/qRxkCrfk77LCPKLX+kZ7j+c3atlg9apb
         SIed/OoDspaUuQwIgCQlCyzD+Roz2LN3ROJP+L6eFTxwhw2W9jrizNZuU+U5UWMfVjD3
         iMCQW9ZAuedlzBYZYqbq7Mln1bLzrYaQkuYzGv8uzDC+0U26NOBnz/fWopXyS4S38YRf
         qMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792340495; x=1792945295;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MYWhgKkOyBGQpTdOqbbR6FCgBN0C/ix0eXA3fu8Y1OY=;
        b=2kbJ1B8ConZ0n+VQG1aapvEGbRjer7w9nYVGSvc9NDt74a2O8QzmWb7ExfIjdD38QJ
         sGt0jImMQNdTCRo/OY73yX3q4CuJ9LxtDs56kV7L658VGiRRUeyv2f1ZJDytPLeKZWa0
         CHBfGDwLroovFboIXq8qEJFgDc55JPye7yAiAogv6CC0tHASRqUIFFcxKfO/il/jVZwS
         w0LAkv4YaWQ5JZPt4qpxqg/nF8UKz/65Xx4XDXH5RMXazbdoxo2JoO+K2+xHJ0Qaxsmt
         6BLHpQCARfJgTIPJN5MDigH+IYROjkURT6HFWUXD6Y9u0QZq5StR8Xi9ysB//18hsVIE
         TELg==
X-Forwarded-Encrypted: i=1; AKwUvBxM9uIgfbMC4mIMR1wfDK1gvkcb5j9s5UIlEN6Kkc/sNuGu5duC52pSGnKosRbrrfiODilRKLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK49akdrKoecsoVEtAEYjYw0YPdYOTLIs9erD8xFOKINBC96Tkb
	uCRZt4U7HaM2HAz7H/7PCZPX6WAadnAodUt370bgwLpdV0f4DvOuXrDCRriX9sv3YPZBVgjYnwm
	2b53ojof0rsHSKMT4rL3WT7KuQPN7r0nw+j2bBCdDj085DOKHPYSjF3Ydjg==
X-Gm-Gg: AYBFou0wMXyla1p7Arv/k66U++HgNWV8hfx69EFEviczQo5KOP+qyIavEZ2eSymnL8k
	eyFwNKuUtGgiZr0+UQdykZ9Wc3hs1+JKDGQLS9FB278CIdlRNcAUXRJwx/rql8Ab6kEQ6kHbxRr
	3C2EJdOSkIRvZXvyWVRT9nXAfO/mkp/eXuhGvM+oo1J7oomJmKyQvlAVgi4QMpHYFkbzhVjOIAC
	N0vcGIZXzilDuT4Uhn8WH4SsIv5GrsHKQbR4DVRIdymkTYSN4vqN2sDHzTDg939xa0RyF3ylSxm
	SIQO4lrUIe611sFN5eYpJKgzNOe0L/Vd2eyMjatzfzCEyvIZ8cZnGjLLm6tsMDZnHEvXgw==
X-Received: by 2002:a05:6000:2611:b0:48d:ef93:67a0 with SMTP id ffacd0b85a97d-48e07fa8300mr11806532f8f.50.1792340494947;
        Sun, 18 Oct 2026 09:21:34 -0700 (PDT)
X-Received: by 2002:a05:6000:2611:b0:48d:ef93:67a0 with SMTP id ffacd0b85a97d-48e07fa8300mr11806491f8f.50.1792340494328;
        Sun, 18 Oct 2026 09:21:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8d12sm18054366f8f.36.2026.10.18.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:21:33 -0700 (PDT)
Date: Sun, 18 Oct 2026 12:21:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: gso: validate transport header before
 computing segment length
Message-ID: <20261018121331-mutt-send-email-mst@kernel.org>
References: <b714fa38ab650b313ca3121cd4cb3ee847d06a0d.1792327180.git.mst@redhat.com>
 <willemdebruijn.kernel.3a3160b92eb96@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.3a3160b92eb96@gmail.com>

Thanks for the quick review! I'll wait a bit for more comments
and post v2.

On Sun, Oct 18, 2026 at 10:16:23AM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > If a TCP GSO packet is processed in the stack before a transport
> 
> TSO

right.

> > header was ever established, the TCP data offset is read through the
> > unset header offset, far outside the packet.
> > 
> > This was demonstrated by syzkaller, back when the input path did not
> > dissect such packets: a virtio net header supplying a malformed
> > network header was enough.  Qdisc length estimation has carried a
> > guard against exactly this since a0dce8752193 ("net: Skip GSO
> > length estimation if transport header is not set"); the GSO length
> > validators never got one.
> > 
> > We used to, but we no longer allow such packets in: since 44378d02c5aa
> > ("net: always dissect GSO packets in __virtio_net_hdr_to_skb()") the
> > virtio net input path dissects all GSO packets.
> > 
> > But as a defence in depth measure, let's also check before we read: if
> > the TCP header is unset or outside the linear data, drop it.
> > 
> > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > Cc: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Can be net or net-next, but given we have Eric's patch in net already,
> > net-next seems more appropriate, and it's safer.
> > 
> >  include/linux/skbuff.h |  5 +++++
> >  net/core/gso.c         | 36 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+)
> > 
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index a3ff380d43f0..aa5bc608de06 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -3041,6 +3041,11 @@ static inline bool skb_inner_network_header_was_set(const struct sk_buff *skb)
> >  	return skb->inner_network_header > 0;
> >  }
> >  
> > +static inline bool skb_inner_transport_header_was_set(const struct sk_buff *skb)
> > +{
> > +	return skb->inner_transport_header > 0;
> 
> skb_transport_header_was_set has
> 
>         return skb->transport_header != (typeof(skb->transport_header))~0U;
> 
> is that initialization different for inner_transport_header?
> If so, slightly confusing. But also understandable that zero is the
> default initialization, I guess.


Indeed.


> > +}
> > +
> >  static inline unsigned char *skb_inner_mac_header(const struct sk_buff *skb)
> >  {
> >  	return skb->head + skb->inner_mac_header;
> > diff --git a/net/core/gso.c b/net/core/gso.c
> > index e96ef6350064..d98acfd68595 100644
> > --- a/net/core/gso.c
> > +++ b/net/core/gso.c
> > @@ -131,6 +131,36 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
> >  }
> >  EXPORT_SYMBOL(__skb_gso_segment);
> >  
> > +/*
> > + * GSO processing (but not UDP/SCTP GSO, which uses fixed header
> 
> TSO

right.

> > + * sizes) reads the TCP header as specified by
> > + * skb->transport_header/inner_transport_header.  Make sure it is
> > + * there to read.
> > + */
> > +static bool skb_gso_transport_header_ok(const struct sk_buff *skb)
> > +{
> > +	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> > +	unsigned int thoff;
> > +
> > +	if (likely(!(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))))
> > +		return true;
> 
> The likely case for GSO is TSO.

indeed.

> > +
> > +	if (skb->encapsulation) {
> > +		if (!skb_inner_transport_header_was_set(skb))
> > +			return false;
> > +
> > +		thoff = skb_inner_transport_offset(skb);
> > +	} else {
> > +		if (!skb_transport_header_was_set(skb))
> > +			return false;
> > +
> > +		thoff = skb_transport_offset(skb);
> > +	}
> 
> This is not GSO specific. Could be a helper in skbuff.h?

will do.

> > +
> > +	/* A negative offset converts to a huge value and fails. */
> > +	return thoff + sizeof(struct tcphdr) <= skb_headlen(skb);
> > +}
> > +
> >  /**
> >   * skb_gso_transport_seglen - Return length of individual segments of a gso packet
> >   *
> > @@ -253,6 +283,9 @@ static inline bool skb_gso_size_check(const struct sk_buff *skb,
> >   */
> >  bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu)
> >  {
> > +	if (unlikely(!skb_gso_transport_header_ok(skb)))
> > +		return false;
> > +
> 
> seems weird to test a transport header feature in a network
> header test?
> 
> Should this instead where it is needed?
> >  	return skb_gso_size_check(skb, skb_gso_network_seglen(skb), mtu);
> >  }
> >  EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
> > @@ -268,6 +301,9 @@ EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
> >   */
> >  bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len)
> >  {
> > +	if (unlikely(!skb_gso_transport_header_ok(skb)))
> > +		return false;
> > +
> 
> even more so in a link layer header test
> 

skb_gso_transport_seglen maybe? I'll have to make it return int
and make callers check that then.


> >  	return skb_gso_size_check(skb, skb_gso_mac_seglen(skb), len);
> >  }
> >  EXPORT_SYMBOL_GPL(skb_gso_validate_mac_len);
> > -- 
> > MST
> > 
> 

