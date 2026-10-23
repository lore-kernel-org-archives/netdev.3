Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792799181;
	b=Y+xTkRsS0Vz9ap88+j0rzB9uO3xPMdvOpQBDLVnd2m3Hg2gmFoarQ1g8SST55Ocf3He2
	 PU01hgq3ohhzGmfdwt+m/d2G+xGUdoNCTqfOqx/2B06QoPnN1eW/ELWXlsMPt5J5GE8RX
	 XznuU76cV0lCXTTRlSxsXg0lJ/H+gLt0fvmEffL1u6xfyQxu75wNBFqjgbPXDhoP+T0ai
	 xsu4HeH/3spX1pnncKbS/BS76/0ADi35XYCFyyw8fVS9b2C9H+HL40mLbu1dYm+OOSJ31
	 8rTlaEHI83CwihmgLbeDJFr+fo+J1Xx5tRfvfXYLwS2Whi0k/rkSn51KV8F1XoSsKeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792799181;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O5btSrqleegX0p5ha9cygCby9IqJb3FwGDRdWPZ2zaI=;
	b=yngmEd3LJKRDlH+nCu2Fwg9XSD26k/edFwooRCufmK6vwupIARknkGdM7+wAHI4Wr3qB
	 KFlu6KwyOizsEVxDdHtYYFh8iUDJ9fFTCu3MEzTshRql5nAQHb4qcCKLWM5okgsc1A+Bk
	 nDCuZ3teB63Kamd/9GiSLAxhH4wP90G2ma/AwG7kKq9yYx9LMtqHbwaO/WFhl8QGbV60u
	 qmzONnZBBfkXT3dZjhzhX2Azbupqtf/KHgaPhAsowpG/r1DmxE+4gE8lgfc5NtUCDB1oL
	 FDbB9/qXIZHhHhIJTxOpRZQK02N7s1xUk3ETrV9zIyrvwXl4GSZdrK2w2dY834Nr4qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NPY0Ukx4;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sIa10mhW;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC061606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 23:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC061606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NPY0Ukx4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sIa10mhW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792799175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O5btSrqleegX0p5ha9cygCby9IqJb3FwGDRdWPZ2zaI=;
	b=NPY0Ukx4YjD8lxtHF+xGuqEHZHH0Vo7YzDMe2weYAQGH/oe0eqr6FnarMIvU11px18MOuu
	9hZonXfARIe22KjqXQ1a9AOt87ErBygLBnmgKmNzjnNjR57Zkapm9wBmDNYVvJzbEbL7WG
	wMw4MOwFtm2TCMGDCW4FtYBK1P19yoU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-iQfJc7-wNMGmyg3ZBohy5w-1; Fri, 23 Oct 2026 19:46:09 -0400
X-MC-Unique: iQfJc7-wNMGmyg3ZBohy5w-1
X-Mimecast-MFC-AGG-ID: iQfJc7-wNMGmyg3ZBohy5w_1792799165
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a208f409ceso8217265e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 16:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792799165; x=1793403965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O5btSrqleegX0p5ha9cygCby9IqJb3FwGDRdWPZ2zaI=;
        b=sIa10mhWJb9jedb2ALgc++Xo0G/4eTSlD+KEJM2CUAtP3c5YkVLdyK3yGIzz8yVj+/
         J6yv7jktbVRzlvQI4+4eo0YrTnx0/nmEIM1EQwaDBQHWg+r9J2qDgsR7uEadZaOGfiMB
         uiSRkc2bM4YOGluGQunjWBrN4h98IkSR5Dct1b6EFrSKlmQLToaUDRCelXQchtcLpwV8
         rvBnS4evi/VqrT3AG8+qORSkq0xL55ZEwcHbSO97IMch2hBmiH3zCqJHPTS7uKg/vUg9
         rJgGgSyZVoVo2bhHwq9bsknmDB91ZreqC6pue9eQPL6UU80VdFsARrvHlWGCwyTtSHPx
         MzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792799165; x=1793403965;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O5btSrqleegX0p5ha9cygCby9IqJb3FwGDRdWPZ2zaI=;
        b=PmazX0cc04BDwPq3VMbqzTF8MdookqUrehukfZgB4mjVZehFZPtstJCb0yWCo1x+o3
         eNxRWwnw3oU3adE/NWFOpzO1pU+w+1c/I/NNRnkXKe/8Aj+9Ua9VJXgQZb0yy5V4U+8Z
         nz0UmP/ZrzNULMF2JvK2eEUvnRXyPO2p8bRk53wr/AzxX+VD8Y+73WMTFAnAQgheYtH5
         QKgj0CB+zqIlfeRtVQa9BhFerzImxk4QPEGnaFLYlc59Zr5HL+mbwt10lJfrM5kio6HX
         0p2qCB66TBKn0g9cRNad6jHe43IjOv5fo8dereCUc2bwBJk7pllUa/QpIqxi0zZdpZw1
         Rg4w==
X-Forwarded-Encrypted: i=1; AKwUvBxi6F2SExcY0orJ4K6EJ2+cI0YmWiezAvV88m5xtN6YbR8jty0v7EB2PaZL/+iGaUiR7PNIf9s=@vger.kernel.org
X-Gm-Message-State: AFq9FYL21BpTztr9TuFnNn6aphAN/vpGFO5BnE9AY79TGvd3VxMrRSo2
	9DvYp9WgbNmJrbQVleJPx/EDG6yuGZfzAAyDO2gWj6fAXNEjeJjoMTBxNxtdEKbPWgh7CzFekO2
	+fKy9EoKCgL7HrXTl3rCAeQTgr8hPSMD4gpJXpqhMJ7023BQ/9rDIdLc3gg==
X-Gm-Gg: AYBFou10k8aJEXYYSO7oOtOQeRpcpp3R4GqcKcybiUp1JOUqBh10V+uo0eLsUXbfDhk
	MT71C6wTExs0s+HAWMuyKVypOL5Uk/qda3mvzAjlseD85oRtNot9OPrxXh3hmDzAj8rmxYqFi8n
	IPmPX+q7rmqVIdjgxre3dr8o0dJN0mkV/K/K1F300AyVp1sHuuN/W0V7VE9BHxOzZq4TqmvXam4
	A1GKIn68K7m1vkKYuRvQp/BiuxVfTaN5QLOCPLIOou3z62uGDzjWhJAVQ2GWwqtaFmjx0mkuSZD
	BW0iYRtHnHaG1Yg+idGrAnsVIEyZxy4pYLOovJ1R+kUtBle53/pTQGqYKrViAOZ90puZN0U=
X-Received: by 2002:a05:600c:4f4f:b0:4a3:5a42:b29c with SMTP id 5b1f17b1804b1-4a35acbc00bmr6034955e9.26.1792799164690;
        Fri, 23 Oct 2026 16:46:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4f4f:b0:4a3:5a42:b29c with SMTP id 5b1f17b1804b1-4a35acbc00bmr6034755e9.26.1792799164158;
        Fri, 23 Oct 2026 16:46:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fc1207sm12576005e9.1.2026.10.23.16.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 16:46:03 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:46:00 -0400
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
Subject: Re: [PATCH net v6 4/5] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261023192005-mutt-send-email-mst@kernel.org>
References: <cover.1792768096.git.mst@redhat.com>
 <bd468c7ea5468d6e3827a3c678eee15243615580.1792768096.git.mst@redhat.com>
 <willemdebruijn.kernel.3ae6f662e1ed8@gmail.com>
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
In-Reply-To: <willemdebruijn.kernel.3ae6f662e1ed8@gmail.com>

On Fri, Oct 23, 2026 at 03:37:48PM -0400, Willem de Bruijn wrote:
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
> > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Reported-by: Chris Arges <carges@cloudflare.com>
> > Tested-by: Chris Arges <carges@cloudflare.com>
> > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> A few comments inline. All but one cosmetic. Feel free to ignore
> those. Please do review the comment from an LLM about the tunnel.
> Aside from that LGTM.
> 

...

> > @@ -368,7 +637,20 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
> >  	skb->transport_header = outer_th + skb_headroom(skb);
> >  	skb->encapsulation = 1;
> > -	return 0;
> > +
> > +	if (!skb_is_gso(skb))
> > +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> > +					       SKB_GSO_UDP_TUNNEL);
> > +
> > +	/*
> > +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> > +	 * set CHECKSUM_PARTIAL.
> > +	 */
> > +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > +						 inner_proto))
> > +		return 0;
> > +
> > +	return __virtio_net_resolve_csum_partial_mismatch(skb);
> 
>     Allowing `!skb_is_gso(skb)` packets through `virtio_net_hdr_tnl_to_skb()`
>     has a few issues:
> 
>     1. When `!skb_is_gso(skb)` and `virtio_net_csum_partial_ok_at_offset()`
>        returns false, `__virtio_net_resolve_csum_partial_mismatch()` completes
>        the checksum in software and lets the packet pass, but `skb->encapsulation`,
>        `skb->inner_protocol`, `skb->inner_transport_header`,
>        `skb->inner_network_header`, and `skb->inner_mac_header` have already
>        been populated with the unvalidated `inner_th` (`csum_start`) and
>        `inner_nh` offsets (unlike `virtio_net_hdr_to_skb()`, which restores
>        `skb->transport_header`).

Oh right. Hmm. I can just run the check first.


>     2. If `!skb_is_gso(skb)` and `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM` is set,
>        clearing `SKB_GSO_UDP_TUNNEL_CSUM` drops the outer UDP checksum request,
>        since a non-GSO skb can only carry a single `CHECKSUM_PARTIAL` offset
>        (at `inner_th`).

Right. But it works! Because the checksum is 0 then. I'll ponder what is
best.


>     3. On RX, a non-GSO UDP packet with `CHECKSUM_PARTIAL` at `inner_th` causes
>        `skb_csum_unnecessary()` (`skb_checksum_start_offset(skb) >= 0`) to treat
>        the outer UDP checksum as already validated.
> 
>     Unlike plain GSO (commit 7c6d2ecbda83), UDP tunnel offload is modern-only and
>     explicitly requires GSO (`/* The UDP tunnel must carry a GSO packet, but no UFO. */`).
>     Why not reject `!skb_is_gso(skb)` right after `__virtio_net_hdr_to_skb()`, and
>     return `-EINVAL` directly if `!virtio_net_csum_partial_ok_at_offset()`?

This will break apps, I think. See 7c6d2ecbda83

-- 
MST

