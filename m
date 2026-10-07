Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FA3D5C1E
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410675; cv=none; b=SAslCXD0NmdOHpT5WqJrY1Cto3lh2lgq1kaRhaFus/zpILkthl1sa4gZBmQi/6ndGi2d/9xW/3KATFrTNgrvoFMR9sxSXgIbFrkzNJoZXttNF+NtdxdxwkB+UqDtx2tskZEF4nLWxvWWjVshs4Gux18Cj6Bwvg7occuz8dBnEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410675; c=relaxed/simple;
	bh=Frc1jJmhfE4VncbY+WuhyyVOoz71FD6vcMiP8V9HJi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juP0/PZZsceMmySnJ573aFEUw+kH1WrrmSox63oY6UGojzqnPTwglMrPB1PYpjtDDisG7/F99SCMOtddaJJFaQ4VYDfh4KS85/c+mwP5Xf8kDMEGJWUTJjny3jKOOTDyqA0DP1+L6TBIqIte7k7CQcBJcFvoCkbz4/Yvm8pyCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXcrm0I+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbLCGGBK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXcrm0I+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbLCGGBK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791410673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1OpxLfFJxHux1ZALIGrt/Kt4jkAyslLEcmS7kqFNhU=;
	b=VXcrm0I+W34MfR1slZN7Eo0UZfE7ME2sY5tjLSWviBN7PGJaxJfmp/RTSa0iV2o5oGeBmD
	2JC8ITMGwIkkiEM4a1HcWmU59L1VQJrQHvAsuSMnUS9Sbmr2igl8VN/mbC++OZX7YdMSb7
	YJQYx0frexsh61ZUdMxFOTQAYDYuiHo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-h13UxSmxNUmHl3ESB7tGDQ-1; Wed, 7 Oct 2026 22:04:31 +0000
X-MC-Unique: h13UxSmxNUmHl3ESB7tGDQ-1
X-Mimecast-MFC-AGG-ID: h13UxSmxNUmHl3ESB7tGDQ_1791410670
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b09f01f56so2886661f8f.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791410670; x=1792015470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/1OpxLfFJxHux1ZALIGrt/Kt4jkAyslLEcmS7kqFNhU=;
        b=SbLCGGBKYxRcoU7bucs7fHigJjq6T5SavuF/VVNpCBdAVkz1wJgPfCU5xBbU+NTFwD
         XQF5PefT/aGqiuHtLoY0Ya2fkUMdiYYuLazelNzN1R05yZSkvk34CWiLmhSGVwh5hIiY
         JxaLerQ+qyYHndgI/f6JsRJQhZyW7rCXAssH/Hjd7QiwlVkYR2k8G82ySZxcLRmVJsLi
         iXIqdaCGYF1x94IPAemVLQFZpnMvAmEdNlYWx7VzcXVlQ8d5zz1NyfMZXqT45o5Nt3D8
         SykhSRxgrgzTQF/BlV0CzRagzYVwnZICq2K6vInz5aFFjOmOUel59XKbKDh/jl90oLG+
         pJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410670; x=1792015470;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/1OpxLfFJxHux1ZALIGrt/Kt4jkAyslLEcmS7kqFNhU=;
        b=LdaZe8a3q3uvlLSTeqtI9mTQePd8AYP0lf4xOTmRUeM4iPmzEcQauCIztkU9B3yBzz
         dD5S+7ZwAGempZ2a3iGZaC3KggkbiYNySIgxr3cHRC37j4Iyo8R3/978pIDqGETi3Cff
         9w625GmvJ0sGKoR9Wy6pOmxtLpAO6i+lQMCp0jl4n2CPMFufoY5Khr9MBbde8TT0qbct
         NHYVA83uOZv32uQE7/1AxBwa5Bht1rTjxboRvmXC0IaSOuNs1rFVpyNaPjuZ4em7BZJf
         2nLKtjMD9DyOMPBleVa9iyOAK71Cin1szbiFurmUF7BJNI7ilOvu5OibeH/zdkKMg5fn
         2hZA==
X-Gm-Message-State: AFuF++lsWPef24kcNpX4iWVvBPCTOoGt9xprw6SE5DRean3RuHONISnW
	g8lrFsMPwcjqP3lFYeQiZeUBFF+894YOWXU0+eoODig7o91kFZParVyO2GvTSkRKIDOpOW23YCx
	6fu7M6S8iTDh6s/IMZX8HtMxtTASsemrukigoqRXv/brd2YmGEbgaM/kzZ7odL5N0Cg==
X-Gm-Gg: AYBFou1vFhCMP2vFTG97f5n7lRF73E0n098kwcCgyd2YoQ81C6TAJ6roRHnqY1+vBvI
	WI/cdIq1w5C/2X6DY0BfW+8+u0UhhestHiVbumfHWIsc00bZjQork2+vfQJ8LWAhFM6spKPESbo
	h7knkwEe1Oi30n6g1G5YQoLN6flX40YkAKWLbh8xm+E8FStCgJk73yIeJo2UI+XRRoxP6SCN8mv
	GZbwMe1+HiXL7KrXAJ03P5JHwAQsjUKn8ScSvkmPdwGXtVvH2EocFkoe2Kx6XuRlBAXofUCe/ug
	tc7E03iJpacFZmBD1ID7KKMHIJjoJkkScco4pKcNyk9mhlnDWcnKsvgk7tUhEwBjtqucdSI=
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a180423af6mr75414975e9.16.1791410670169;
        Wed, 07 Oct 2026 15:04:30 -0700 (PDT)
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a180423af6mr75414385e9.16.1791410669642;
        Wed, 07 Oct 2026 15:04:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842a51afsm21109755e9.1.2026.10.07.15.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 15:04:28 -0700 (PDT)
Date: Wed, 7 Oct 2026 18:04:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	andrew+netdev@lunn.ch, liuhangbin@gmail.com, wei.fang@nxp.com,
	Willem de Bruijn <willemb@google.com>,
	Junnan Zhang <zhangjn_dev@163.com>
Subject: Re: [PATCH net] net/packet: call packet_parse_headers after
 virtio_net_hdr_to_skb
Message-ID: <20261007180417-mutt-send-email-mst@kernel.org>
References: <20261007175816.3138556-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007175816.3138556-1-willemdebruijn.kernel@gmail.com>

On Wed, Oct 07, 2026 at 01:57:30PM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> SOCK_RAW packet sockets incorrectly drop VLAN-tagged GSO packets
> without VIRTIO_NET_HDR_F_NEEDS_CSUM.
> 
> packet_parse_headers() sets skb->protocol to VLAN but advances
> skb->network_header past the VLAN tags. virtio_net_hdr_to_skb()
> then flow dissects these packets, which parses the network header as a
> VLAN tag, and fails.
> 
> Call packet_parse_headers() after virtio_net_hdr_to_skb() instead.
> 
> This matches tun_get_user() and tap_get_user() and thus simplifies
> overall complexity.
> 
> Commit 01fdecc0480d ("net: packet: fix wrong transport_header when
> sending VLAN-tagged frame") fixed the same issue for the transport
> header probe in packet_parse_headers(). That probe is now skipped if
> virtio_net_hdr_to_skb() already set the transport header, avoiding a
> redundant dissection.
> 
> Implementation details:
> - Do not set skb->protocol to the RX wildcard ETH_P_ALL. SOCK_RAW then
>   derives it from the link layer header, as before. SOCK_DGRAM now
>   leaves it 0, or derives it from gso_type for GSO with NEEDS_CSUM.
> - Keep virtio_net_hdr_set_proto() last, so that the link layer protocol
>   takes priority over gso_type.
> 
> Reported-by: Junnan Zhang <zhangjn_dev@163.com>
> Closes: https://lore.kernel.org/netdev/20260821085722.24036-1-zhangjn_dev@163.com/
> Fixes: dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")
> Signed-off-by: Willem de Bruijn <willemb@google.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
> This was discovered through the report linked in the Closes: tag.
> 
> Also independently reported by LLM code reviews as pre-existing issue,
> and verified with a reproducer.
> ---
>  net/packet/af_packet.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 6ff16eef24f4..52ae3d875e97 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1943,8 +1943,7 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  	/* On TX skb->data is the L2 header; anchor it for all socket types. */
>  	skb_reset_mac_header(skb);
>  
> -	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
> -	    sock->type == SOCK_RAW)
> +	if (!skb->protocol && sock->type == SOCK_RAW)
>  		skb->protocol = dev_parse_header_protocol(skb);
>  
>  	skb_probe_transport_header(skb);
> @@ -2614,7 +2613,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
>  	struct page *page;
>  	int err;
>  
> -	skb->protocol = proto;
> +	if (proto != htons(ETH_P_ALL))
> +		skb->protocol = proto;
>  	skb->dev = dev;
>  	skb->priority = sockc->priority;
>  	skb->mark = sockc->mark;
> @@ -2678,8 +2678,6 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
>  	if (unlikely(!skb->len))
>  		return -EINVAL;
>  
> -	packet_parse_headers(skb, sock);
> -
>  	return tp_len;
>  }
>  
> @@ -2919,9 +2917,13 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  				tp_len = -EINVAL;
>  				goto tpacket_error;
>  			}
> -			virtio_net_hdr_set_proto(skb, &vnet_hdr);
>  		}
>  
> +		packet_parse_headers(skb, po->sk.sk_socket);
> +
> +		if (has_vnet_hdr)
> +			virtio_net_hdr_set_proto(skb, &vnet_hdr);
> +
>  		uarg = kmalloc(sizeof(*uarg), GFP_KERNEL);
>  		if (unlikely(!uarg)) {
>  			if (likely(len_sum > 0))
> @@ -3122,7 +3124,8 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  		goto out_free;
>  	}
>  
> -	skb->protocol = proto;
> +	if (proto != htons(ETH_P_ALL))
> +		skb->protocol = proto;
>  	skb->dev = dev;
>  	skb->priority = sockc.priority;
>  	skb->mark = sockc.mark;
> @@ -3131,16 +3134,18 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  	if (unlikely(extra_len == 4))
>  		skb->no_fcs = 1;
>  
> -	packet_parse_headers(skb, sock);
> -
>  	if (vnet_hdr_sz) {
>  		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
>  		if (err)
>  			goto out_free;
>  		len += vnet_hdr_sz;
> -		virtio_net_hdr_set_proto(skb, &vnet_hdr);
>  	}
>  
> +	packet_parse_headers(skb, sock);
> +
> +	if (vnet_hdr_sz)
> +		virtio_net_hdr_set_proto(skb, &vnet_hdr);
> +
>  	err = packet_xmit(po, skb);
>  
>  	if (unlikely(err != 0)) {
> -- 
> 2.56.0.360.g66cac248cb-goog

