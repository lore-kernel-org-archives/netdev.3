Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C62D2381
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410587; cv=none; b=kHZQELS4rvuyw1igk6Di5kTu74T/8lpVMEAU0G5esidQDGUpu7yqXOpVmo+JvkuSft66POuNwQ6bY14cD+co2JL0DQbdvJOeR0EWlpLM5EFOwHEE09/FH9bPnWXVXbKv7m+CAvw/jt5NQKBT5M4vII9Y6kgsDryGZ5m+YW7BUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410587; c=relaxed/simple;
	bh=J383ZO+au06r5d5n5Jz3V4U9m39Y2JlrUyqZ0O53JOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9puo+lcNA9yvBAYkAgEjqWi/ZtYUHqzfLK7+jpeJh7YDqTvRnczvdb5q9rrEXINpyyNZlsq7JIsgULwbckaMZ6cMhNqhaPERgnMj81H57sG/h/BbZQ1Igr1+2oHo7eeyTvGw80Hy3824vscikGC7astp1SNnSPhCyl/Y10912s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRs2F1V3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=abz6QlFz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRs2F1V3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="abz6QlFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791410585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iXVdyY2SRhC90pYI8z2IbymtmYLVrbXNIZjkno+QXY=;
	b=QRs2F1V3bLNlqesHaaRGAQNU5L7G2Ty3w/SzEn6BW0o15DAbbJEVz37M4CBeRuGNUTy0PX
	Tu8/YEuCIjdfFYBwQgmTcOBJXh7iOM+zw6oWF8JmfMXeEqlQeYoOiVWncsSsyHDixZ6G6A
	45U2Lms9/KEjdcj6Vgg5PxkYYU/S1xg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-AHO_IySnNmGZ6quX1CCODw-1; Wed, 07 Oct 2026 18:03:03 -0400
X-MC-Unique: AHO_IySnNmGZ6quX1CCODw-1
X-Mimecast-MFC-AGG-ID: AHO_IySnNmGZ6quX1CCODw_1791410582
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a01c621dc2so34304765e9.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791410582; x=1792015382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/iXVdyY2SRhC90pYI8z2IbymtmYLVrbXNIZjkno+QXY=;
        b=abz6QlFzljrR6U93gUWC7F5r8CAlvbjmwOFOFrWX922fRjg04OzvXwgAdwQxqQEXLD
         a7CJgCtNj51KFsjk2vVzA0bDCS99I/Ta7QHFTjy2KG2WIrIlj87HxdN1/nBtymBeovPq
         F0zHXQ9UXt6d7t1vXeDylg6eBe+Jv2eVdWSJoefnWnBeQdQgVCMBAu726oQUAOZJPrPD
         0kGWizgb3XPE9p9dXeZP/vYZMK7hh4bptQ8vOjvCmKoylm9qPa+TXLXW9VhWqtBnkgpu
         W8mBAxEFvT7fnUrfn73d8pR8upgqPNHe2eaYFH37r7hlzlmFKiSkxnZtqZ+d9TG/jSN/
         ssaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410582; x=1792015382;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/iXVdyY2SRhC90pYI8z2IbymtmYLVrbXNIZjkno+QXY=;
        b=EqZGt0viLrvfEE4QJ1E52vGHgCpX4vR1d8OJ7WI9Q2+TpkR4wWKcQRi/+zUZGG1ydg
         c5URXtb987yeJlmHrsC4UrfZtThmp80tJsLXypJrVOPp7UAKeeps2t73f1o9AcClYHT8
         D0Bk9TTpoud11a/7Fux/sPhf+VLUfzA+9ogQ8anX2RaS1KhTUH9JcT/vwm8dv+7mFEG+
         UP1WTtNrZsrN3l9KtSIVcCm0eIjjkhBPtknK7Zj3lPlVdZbwqD9fqXMBFs8jgepIOUIl
         drcWRXJwjwbyxrVuM+96VkekyXnBFo+i/ZgB3LOc5efp1+jLL1cj+4pQtWBYdy6v5IQQ
         kQkw==
X-Gm-Message-State: AFuF++mNUU0DIPLnU2+Mn0D712x1hU/x1v21NovnTnwNHurMSBiB325T
	fLn/hQYfsRs2kDWcz/+bxqz/cnrAdJW8sOicO6/EMcrFXVCNgNrX6REMOQz4boEtBkTtHu3cunJ
	fdN4J87sKB9VpTs9UDm9UUBbSZpE8Gzf845Zqd1eGfCDx8uydpYcExn3oKw==
X-Gm-Gg: AYBFou2hnF7kPkuDarSzE/obdxKRYop6BceVbimvRV12PC36yiGUynbzNiczYQI+gJM
	gbc2Nlb9IDb/3ZgX+JK4MwYvwqMrMHXwm6EUqhHenkCJdncRzMTDrvB88XJWU0W/5aoLzPA9rPs
	imcO9/ro81StKPEJ6EPKovEl4BMTiAH8Psv8mk8SVxlyIE4scATILJQqxfNUcZi0v8AGiDZaZbl
	EWb7Q3wj9PxWyuBFj9/tJWuHCk9gmNK8e94bBXxmjueV48+dQ5TAOuMzS3UlbHi7nliNKpVUWuY
	N9+Kr4ytk37vZoYoTIFNcCN5n/GY+LZlfKtxADYpSjULISTMPzwCa3jHvm/BhtvPcLlGEig=
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a180423af6mr75343545e9.16.1791410581824;
        Wed, 07 Oct 2026 15:03:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a180423af6mr75343155e9.16.1791410581296;
        Wed, 07 Oct 2026 15:03:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843cb256sm19021895e9.5.2026.10.07.15.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 15:03:00 -0700 (PDT)
Date: Wed, 7 Oct 2026 18:02:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	andrew+netdev@lunn.ch, jasowangio@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to
 VLAN, IPv6 and IP options
Message-ID: <20261007175957-mutt-send-email-mst@kernel.org>
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>

On Wed, Oct 07, 2026 at 12:36:59PM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> __virtio_net_hdr_to_skb() validates hdr->csum_start against nh_min_len:
> 
>     if (skb_transport_offset(skb) < nh_min_len)
>         return -EINVAL;
> 
> Extend the check to account for the link layer header including VLAN
> tags, IPv4 options, and IPv6 other than VIRTIO_NET_HDR_GSO_TCPV6.
> 
> Payload, gso_type and skb->protocol can come from userspace, so cannot
> be trusted to be consistent, or correct.
> 
> Therefore:
> - For Ethernet packets (ARPHRD_ETHER), parse from ETH_HLEN and
>   eth_hdr(skb)->h_proto, advancing past any VLAN tags with
>   __vlan_get_protocol().
> - For non-Ethernet packets, use skb_network_offset(skb) as nhoff and
>   infer the L3 protocol from iph->version at skb->data + nhoff.
> - If skb->protocol is set and disagrees with the protocol parsed from
>   the packet, enforce the minimum header length of both.
> - For non-IP protocols, require only nhoff + nh_min_len. No in-tree
>   non-IP protocol generates CHECKSUM_PARTIAL itself. They only carry it
>   when encapsulating IP (e.g., MPLS), in which case csum_start lies
>   beyond an inner IP header.
> 
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Link: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yibelo@gmail.com/
> Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_net_hdr_to_skb()")
> Co-developed-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

This doesn't fix all the issues, or does it? If not, I am confused why we
are doing this piecemeal approach. I thought we agreed to

a. validate some basic things about the checksum in the core ip stack

b. in virtio, validate specific checksum values
   and for anything else, fill in the checksum and fragment then
   and there


> ---
>  include/linux/virtio_net.h | 48 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd0..6a30f58d9d65 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -48,6 +48,52 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static inline bool virtio_net_hdr_thoff_valid(const struct sk_buff *skb,
> +					      unsigned int nh_min_len)
> +{
> +	int thoff = skb_transport_offset(skb);
> +	const struct iphdr *iph;
> +	__be16 proto = 0;
> +	int nhoff;
> +
> +	DEBUG_NET_WARN_ON_ONCE(skb->mac_len);
> +
> +	if (skb->dev->type == ARPHRD_ETHER) {
> +		if (unlikely(thoff < ETH_HLEN))
> +			return false;
> +		nhoff = ETH_HLEN;
> +		proto = eth_hdr(skb)->h_proto;
> +		if (eth_type_vlan(proto)) {
> +			proto = __vlan_get_protocol(skb, proto, &nhoff);
> +			if (!proto)
> +				return false;
> +		}
> +	} else {
> +		nhoff = skb_network_offset(skb);
> +	}
> +
> +	if (unlikely(thoff < nhoff + nh_min_len))
> +		return false;
> +
> +	iph = (const void *)(skb->data + nhoff);
> +	if (!proto) {
> +		if (iph->version == 4)
> +			proto = htons(ETH_P_IP);
> +		else if (iph->version == 6)
> +			proto = htons(ETH_P_IPV6);
> +	}
> +
> +	if (proto == htons(ETH_P_IP) || skb->protocol == htons(ETH_P_IP)) {
> +		if (unlikely(iph->ihl < 5))
> +			return false;
> +		nh_min_len = max_t(u32, iph->ihl * 4, nh_min_len);
> +	}
> +	if (proto == htons(ETH_P_IPV6) || skb->protocol == htons(ETH_P_IPV6))
> +		nh_min_len = max_t(u32, sizeof(struct ipv6hdr), nh_min_len);
> +
> +	return thoff >= nhoff + nh_min_len;
> +}
> +
>  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					  const struct virtio_net_hdr *hdr,
>  					  bool little_endian, u8 hdr_gso_type)
> @@ -104,7 +150,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  
>  		if (!skb_partial_csum_set(skb, start, off))
>  			return -EINVAL;
> -		if (skb_transport_offset(skb) < nh_min_len)
> +		if (!virtio_net_hdr_thoff_valid(skb, nh_min_len))
>  			return -EINVAL;
>  
>  		nh_min_len = skb_transport_offset(skb);
> -- 
> 2.56.0.360.g66cac248cb-goog

