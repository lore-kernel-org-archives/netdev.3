Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492397;
	b=XQolOiVt0NVhG54br6zbTw/HL8gy85a8Ufz1KSCECFZ0ULcmae1OVB57MAHGIQ7OR7uJ
	 pw+GiBiyAYUP/mvaeg6y+xulyg0mcHwt9I8nsA15rKeckb/r+jTrBC3V57O7bY3DNODb7
	 Fz5zumc258QAxZz59W9zXhnwnZEt8idMa4pDYtx4HA33Z6iiu1WsQAUST3E9GRbdKd+gw
	 cbz0ZN0TE5dH8BE5kjxLE6svqfcfWGPoJqIaZ723nihBYtqlABENBUK7u4GYGs65zZbHC
	 9y5Uqf9pfqYmzdrz2pikH0S8jjF48PlPeXpfBA4NajS0q0h3VpGnXoubD3aOIumfVlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492397;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eQxfLYkOiU0nxAEbk2HPi+UrC6nZfg0/s7ZOZOcgNoQ=;
	b=s6q66FQws51bUDdHGzCj5LPFmbQnx3qvYD49B6xf/vT9rWLfUyQ7rouDKq9ea4iSsSKH
	 XtFWhBOy1qe0ez02QlaxCIVT4nphsx/Y+RkLdyGh8UyMd5ekgxKgXVHenIKx9a+gL+Kop
	 JEwot5aQttMPa2cxZtJdTlNGhb18N3o6vt67qDmCmIhua+2kjVu/seRUhizaUYgM7sNI3
	 8bh6CMIEmG3v6qbTYZQvomGSW4qPKdNhUwCtWzSgKIbALrmtpDo4T1LllGnADywE+lJ3X
	 s2yD1oC9SjnZO+tRsl+vAonVJ+dHteTVPqv3ScoVdQeUP1gq4gzu/rxpMCcqtqkirKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XbrlQHoc;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=C1v1fBvt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09B606A322
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F09B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XbrlQHoc;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=C1v1fBvt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792492396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQxfLYkOiU0nxAEbk2HPi+UrC6nZfg0/s7ZOZOcgNoQ=;
	b=XbrlQHocIjGPoxeB1LhiS8nAghJOE0A58wHHS3MuRwY48VBZpQx43UTZDyiDicGPsN93DX
	/hFH0+fxrNXZwydI5tQnh3G8Oc0zoiPqtVV8F6eTECIZajJIz+20ly3nt0ljzpCySohfi7
	rXsWe6oyGIk2cPmdMgj2fVg1CvKIZVA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-cOezvA6kNpetrOhcKSJUOw-1; Tue, 20 Oct 2026 06:33:13 -0400
X-MC-Unique: cOezvA6kNpetrOhcKSJUOw-1
X-Mimecast-MFC-AGG-ID: cOezvA6kNpetrOhcKSJUOw_1792492393
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af4046a3bso2888486f8f.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792492392; x=1793097192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eQxfLYkOiU0nxAEbk2HPi+UrC6nZfg0/s7ZOZOcgNoQ=;
        b=C1v1fBvtmYHpH3kwwfM0yeK3TlRKCNKe9A5++joaFkDMf+HGxyaPZ5O4tHNA9NPorf
         QOSaUwMCmg/3yy/8T4CLsjoDW5QHWC7GYTT+orXwbR6W5znZDPfpNw/bNmxAZ/9ThtwV
         V9pwyAzqaxGYQ/heIRSIaPcyDXVLqmO50Oe1O2CbkShFJlKHy7Zv6X60OA2Z1/V1W1e1
         DgOaeNHBzbT/2UOswzbjPwjYXXqoYYgDFMbNmKLbLRRoI2k6wt4w1Z3sigT590ibOXuw
         /aEXNFhdJKlUEru5aockHpvcCdElS6ugTIAz7n94NDKNwdfYT8y6iOY9v31u5y14UOZI
         1/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492392; x=1793097192;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQxfLYkOiU0nxAEbk2HPi+UrC6nZfg0/s7ZOZOcgNoQ=;
        b=HiFnES8qvsqnZN4HMt/wnObZJI0nLDOTAj8xfA1WOMKvOg8xI4TkghmhowAxexYt73
         1ivllMswYJ/5El33BQjeJTVMIxEcZ/hEOR80qotO56EEqka9j0VKTFR/dY5l4NWHzw2L
         JILZw307P6txOBeG+gyeLdVUVOiBuTiW7IyLrrwT97ysKn0G0LfH1zbVPB31YxPoM0K5
         8DopkmsaQPkb/cTYmEvTErNupjmUcGF7iRmyFq3+Jgi5gjHQOiXm97VPiT1MH9r1IG83
         AktnR8Rvj39UUw00N9d+p8cm25LvZJf3mEyMspuDGkK6TCz4XDnVu7KQIGkl1fGOGYHc
         U3Ow==
X-Gm-Message-State: AFq9FYIahLf+SAUzzJqkMh1o4VXaucPtC0aEdPoZ2Em/4glSeVHthn1x
	II8Au1fAOyG3I6h1kMk5o08zL8V5jDIoRO9IURnZyJgILnq0PqhRbI+X8mhbuiZ5jv+awKTehA4
	8+oxa5kFspuEaBeOrB50smb3TPb8ybGvpf5vtIcc1Yq3KZJN/7GB4XEjovA==
X-Gm-Gg: AYBFou2n7DYxtE45rQ1l0m7A9ug36qpFA6xigsdRTHu+niwluum2/fnZqcN1o9EmgYA
	ms9uplGS59Sx4e7KfBlnDrIMBuXRlgTqnYp+Gzng78n++mgX0+ea5XPFEiEFQww2GE6HEADemUY
	BnWbmLxcIXsxLIIFs44uWVcgrQ+ZRiO8D3DZC4XJb3LCH5+rHC+AlEmAEu8S0NBEu6U4y78eEOe
	kUjPxo3Gk2qQXYXADmGy4DyhCLBBWV2lmjvKx5wAKmR3Eo7Uk0u5CqQLkWEq5DPOwoziwuKo4T5
	gQqXdZDXT0SD+iWZBbaU3i5gb/n4E8UbCnTgpu0DPa9xUJd8mkW2bysBhlWXKNdetHWzOg==
X-Received: by 2002:a05:6000:4025:b0:48e:1d87:f179 with SMTP id ffacd0b85a97d-48e1d87f1bcmr4575313f8f.25.1792492392427;
        Tue, 20 Oct 2026 03:33:12 -0700 (PDT)
X-Received: by 2002:a05:6000:4025:b0:48e:1d87:f179 with SMTP id ffacd0b85a97d-48e1d87f1bcmr4575254f8f.25.1792492391869;
        Tue, 20 Oct 2026 03:33:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8185d2sm5455794f8f.28.2026.10.20.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:33:11 -0700 (PDT)
Date: Tue, 20 Oct 2026 06:33:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	andrew+netdev@lunn.ch, jasowangio@gmail.com, eperezma@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] virtio-net: fix frag overflow in big packets receive
Message-ID: <20261020003357-mutt-send-email-mst@kernel.org>
References: <20261020032108.81879-1-willemdebruijn.kernel@gmail.com>
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
In-Reply-To: <20261020032108.81879-1-willemdebruijn.kernel@gmail.com>

On Mon, Oct 19, 2026 at 11:15:50PM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> In big packets mode with guest GSO, add_recvbuf_big() posts a chain of
> MAX_SKB_FRAGS + 1 pages. page_to_skb() copies only ETH_HLEN of the
> first page into the linear area and adds the rest of that page as a
> frag, then one frag per remaining page. A device that fills the entire
> buffer therefore causes MAX_SKB_FRAGS + 1 frags, writing one
> skb_frag_t past the end of skb_shinfo(skb)->frags[].
> 
> Post one page less. The buffer still fits a maximal GSO packet. A well
> behaved device does not trigger this, as GSO packets are at most 64KB.
> 
> Also check the frag count in page_to_skb() before adding any frag as
> defense in depth.
> 
> Fixes: 9ab86bbcf8be ("virtio_net: Defer skb allocation in receive path Date: Wed, 13 Jan 2010 12:53:38 -0800")

Wow an old one.


> Signed-off-by: Willem de Bruijn <willemb@google.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
> The "Date: ..." in the Fixes tag is literally part of the subject
> line of commit 9ab86bbcf8be in git history.

Caused me a double take, too.

> 
> Reported by an offline AI review of a related virtio-net patch.
> ---
>  drivers/net/virtio_net.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index daab43ac92ce..cb7ed53fd55e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -906,6 +906,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	}
>  
>  	BUG_ON(offset >= PAGE_SIZE);
> +
> +	/* The first frag starts at offset, each next frag is a full page. */
> +	if (unlikely(DIV_ROUND_UP(offset + len, PAGE_SIZE) > MAX_SKB_FRAGS)) {
> +		pr_debug("%s: rx error: len %u needs more than %d frags\n",
> +			 vi->dev->name, len, MAX_SKB_FRAGS);
> +		kfree_skb(skb);
> +		return NULL;
> +	}
> +
>  	while (len) {
>  		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
>  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
> @@ -6717,7 +6726,8 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
>  	 */
>  	if (mtu > ETH_DATA_LEN || guest_gso) {
>  		vi->big_packets = true;
> -		vi->big_packets_num_skbfrags = guest_gso ? MAX_SKB_FRAGS : DIV_ROUND_UP(mtu, PAGE_SIZE);
> +		vi->big_packets_num_skbfrags = guest_gso ? MAX_SKB_FRAGS - 1 :
> +							   DIV_ROUND_UP(mtu, PAGE_SIZE);

The two most common issues in computer science are off by one bugs.


>  	}
>  }
>  
> -- 
> 2.56.0.212.g129ede20d9-goog

