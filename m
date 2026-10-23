Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757610;
	b=JUNmcjCorgHvBGyCHoxBt9OfqCJZvJdyeaQXD1iukctnROwozkiG2k3X4LkRTfkFvIyD
	 xVUBYozZENVplU5VKBfV6WZq0IkYzZHddSe9NHzzuwKn1pXp5VleFzhtrCNR/v4xClmRH
	 k7cCXCswySBeDTJJA14yz+CRnt8Uhx0LYPsPrPObvTrBDE7MT+DfeLpXyjya4vuYnD/ZR
	 NpMQl424c/9sotKN3J7hVDcsriDKHXALcYSJuIGm3Xz2J/8gHgI0W3PBDsGrE6LSr5n+r
	 6MZMqWcJEBFRsHyL/wiBr9tAHxVtORmIroFLYYoLS1lZzHHv3P2/3z0O3kESVpmL8Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757610;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=143hszKlCW7sBtVDn/0pbEhYSX5YyeOz7B9GvGu+YfE=;
	b=anHXeNY/1+7ExSqWOKJfFwrZrIOuDpstLFe2bhYUKuSE1FDr6dTTOCnqcuK4ItHsclJV
	 7fr+NSuSylHHvQMSGmnhW/ap0uiAFbfKGt0adUT2CrE7j1EDNUgxLQ5P4vIKrq5DglxzI
	 OktnZvAL/bLQpQms+D7tIF7nRD7+V1zL1q2KlaCwI4BdXbeL7XusOwalzYUmD0KeE83h0
	 r4bqNdgPpqaCxXJjOkfZ48j20Ma9j6h7h9TMg1tYsr4hiFCx7S00cA3UojMaAKl+hh40f
	 8Rh+i7udYU6JyJH7Bo0w6byQAI/K5qF6u0kHmH4cRa4xWFTGmA2ysCZrLehXHvYptqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jn+8XzFH;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ea4TIvqx;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD9606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7AD9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jn+8XzFH;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ea4TIvqx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792757608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=143hszKlCW7sBtVDn/0pbEhYSX5YyeOz7B9GvGu+YfE=;
	b=Jn+8XzFHfBr3lC1v5DLvBNlSKy0/PeStp2HZBEfolnzfY7oRkWKbshH3JFb1qnyiMtCgbD
	YU+K8t4hCzBQxYfaQ6Qq3yO26GxAjzNivSI3QDhTdYXkZqyxL1EnanNs1Y7GAkQOwmcv33
	AwXj6onqyLwGrv1tBYW67BAlAAmaggE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-j0AvkAp5MPyBZwu5d3fLXg-1; Fri, 23 Oct 2026 08:13:27 -0400
X-MC-Unique: j0AvkAp5MPyBZwu5d3fLXg-1
X-Mimecast-MFC-AGG-ID: j0AvkAp5MPyBZwu5d3fLXg_1792757606
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b00febba3so732316f8f.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792757606; x=1793362406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=143hszKlCW7sBtVDn/0pbEhYSX5YyeOz7B9GvGu+YfE=;
        b=ea4TIvqxgM73jCpx3zkLZBEP4N9/3m9euuQJFBLWpkNDk0mTr6d3PT1CCWuHb4ufaX
         RYWwpZnnQc0TQMG9E0OXuujcPytRxSLqSNw/5vAl+EPcLfXqjKnoHp2Lz1yFUdwxgZIb
         TIq5y57DoiyOAYSzq/aT1Uxea6IJPMCT0bioY95QUJi4LgPHdUIihQ9l6Vzc1qV1Sh4x
         +pW3EFVHiQD2Z6Kv6wDGs6WsBIFPAsoYT9Uj3yGqdj/xCDjHZHrx9mMWksXeiy5rIo1p
         qk4JAjDAuujeL0Q4rkO73bQTqRHG/vrkV6dopaR5ODVfYHgf1mLWY2ZOmS9oAQH5/RRb
         ALag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792757606; x=1793362406;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=143hszKlCW7sBtVDn/0pbEhYSX5YyeOz7B9GvGu+YfE=;
        b=iRWnfojtHkFUu2N6g08CZEk3iKhCYJm1Nl0xRBTPd+14EO9S2DUtzwYo8P6B7qc5gb
         Bvlm5B59eKM2aXA5UddlWN7V9ONLaAdjN/apfo5uOn7Yu45BfOkU6p+ehl+NfX7wXMUG
         shH1svJVSJkaKk7sEv/AQym4jC4CG7orHFSGSpQHGERJcxyqSQrR+ZmtQPhOaeROyBXs
         m//KC9Ty9rvHQNvOMV5nz9HnXgotc2babcvMvFObLjNGYDcvRk+7JbQsnlxGS+U9N0hP
         zzuoBfNGTxxrsUw9q9+JUuOVx1mL90CUzAUGu1rnSRJWxecbR9ueDEJfSllX9AQdlKJH
         5i4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzinEzCdZRxPSAKlKHbDaapo8mJ003RNI6DcXA1HJs1tvn9e1N6h0Cgo5wsNJtqTVjXuAJVMWg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0G//ELKlQhLpDR+l1+YRkYXQqpaVchDADioAo2E1M6DwAdmwA
	IRu631sppzOtWNmabYfPLMQ7dMu5hhhPIn9T1wxLMscdfOO43XxAHYlJ+SBHOc1IE5FfHHR58iG
	KgKZ1i85u3EOFK7V7LbKjmR8cO3ovB745ex8W+pVXgJ5QGQXg66zEmcKcJ/O26q2/ng==
X-Gm-Gg: AYBFou31/bzmQ3v+lTG1ncNYQfUset2PPOSx6PkotXN4VUA8YuoPVZzUHKeAOpZ9Dyw
	0m5DnZiU2b5E8O1cCAo+rcujOF2nyuG08a5CuiUSsA85CEVtDacYwMpE43/S4g2bdWZ2A2m4erp
	RpMfncVPgh++aDVrpzKbnBFm6jFP0hXziuEnwsaHgpe8Jm7Mu7H0kLXgMy0/pD25NNTidgMUHs0
	KaKhUalfZhVAv2aoOQWLwDOVBEh2YLnIjXOQKUCKqm0IdKGPw6Ewllte7G3nJIzsXNFaNZwbFQY
	EIYfToypmKbw/azMw7jWAAZ27DkbKOTxQOGi4QZktWfCtPJBD8BIGiiW5lJWXNU22+npzHU=
X-Received: by 2002:a05:600c:1c04:b0:4a2:a9:ed56 with SMTP id 5b1f17b1804b1-4a211edfd39mr44050785e9.8.1792757605802;
        Fri, 23 Oct 2026 05:13:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1c04:b0:4a2:a9:ed56 with SMTP id 5b1f17b1804b1-4a211edfd39mr44050245e9.8.1792757605196;
        Fri, 23 Oct 2026 05:13:25 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2958bf25dsm1862675e9.2.2026.10.23.05.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:13:24 -0700 (PDT)
Date: Fri, 23 Oct 2026 08:13:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guikun Yang <yangguikun19@qq.com>
Cc: Jason Wang <jasowang@redhat.com>, Eugenio Perez <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: initialize the whole negotiated RX vnet header
Message-ID: <20261023080824-mutt-send-email-mst@kernel.org>
References: <tencent_803981983647D9F9444561A4227F138C600A@qq.com>
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
In-Reply-To: <tencent_803981983647D9F9444561A4227F138C600A@qq.com>

On Fri, Oct 23, 2026 at 07:37:20PM +0800, Guikun Yang wrote:
> When VHOST_NET_F_VIRTIO_NET_HDR is negotiated, handle_rx() builds the
> virtio-net header itself and writes it into the guest buffer.  Since
> commit bbca931fce26 ("vhost/net: enable gso over UDP tunnel support.")
> vhost_net_set_features() raises vhost_hlen to
> sizeof(struct virtio_net_hdr_v1_hash_tunnel) as soon as one of the UDP
> tunnel GSO features is enabled, but handle_rx() still copies only
> sizeof(struct virtio_net_hdr) (10 bytes) and then writes num_buffers at
> offset 10.
> 
> The remaining 12 bytes of the 24 byte header (hash_value_lo,
> hash_value_hi, hash_report, padding, outer_th_offset and
> inner_nh_offset) are therefore never initialized, and the guest sees
> whatever its RX buffer contained before in fields whose layout the
> negotiated feature set defines.
> 
> Reproduced on 7.3.0-rc7 with a userspace vhost-net "guest" that fills its
> RX buffer with 0xaa and negotiates VHOST_NET_F_VIRTIO_NET_HDR,
> VIRTIO_F_VERSION_1 and VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: offsets 0..9
> hold the vnet header, num_buffers is at 10..11, the payload correctly
> starts at offset 24, and offsets 12..23 still contain 0xaa.  Without the
> tunnel features the payload starts at offset 12 and nothing is left
> uninitialized.
> 
> Copy the whole vhost_hlen out of a zero initialized header of the
> largest layout, and rewind the iterator so that num_buffers keeps its
> position right after the legacy header.
> 
> Fixes: bbca931fce26 ("vhost/net: enable gso over UDP tunnel support.")
> Signed-off-by: Guikun Yang <yangguikun19@qq.com>


Which backend did you use? Sounds like you did not set
TUN_VNET_TNL_SIZE or did not set TUNSETOFFLOAD?
That's the issue then.


> ---
>  drivers/vhost/net.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1161,9 +1161,15 @@ static void handle_rx(struct vhost_net *net)
>  		.msg_controllen = 0,
>  		.msg_flags = MSG_DONTWAIT,
>  	};
> -	struct virtio_net_hdr hdr = {
> -		.flags = 0,
> -		.gso_type = VIRTIO_NET_HDR_GSO_NONE
> +	/*
> +	 * The negotiated header is struct virtio_net_hdr when only the legacy
> +	 * layout is used, but struct virtio_net_hdr_v1_hash_tunnel (or the
> +	 * v1/v1_hash layouts) when the corresponding features are enabled:
> +	 * size it for the largest layout and let vhost_hlen select how much
> +	 * of it is sent.
> +	 */
> +	struct virtio_net_hdr_v1_hash_tunnel hdr = {
> +		.hash_hdr.hdr.gso_type = VIRTIO_NET_HDR_GSO_NONE,
>  	};
>  	size_t total_len = 0;
>  	int err, mergeable;
> @@ -1260,17 +1266,26 @@ static void handle_rx(struct vhost_net *net)
>  		}
>  		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
>  		if (unlikely(vhost_hlen)) {
> -			if (copy_to_iter(&hdr, sizeof(hdr),
> -					 &fixup) != sizeof(hdr)) {
> +			/*
> +			 * vhost_hlen is never larger than the header above.
> +			 * Copy all of it: the fields vhost does not provide
> +			 * (hash and UDP tunnel information) have to be zeroed
> +			 * instead of being left with the previous content of
> +			 * the guest buffer.
> +			 */
> +			if (copy_to_iter(&hdr, vhost_hlen, &fixup) != vhost_hlen) {
>  				vq_err(vq, "Unable to write vnet_hdr "
>  				       "at addr %p\n", vq->iov->iov_base);
>  				goto out;
>  			}
> +			/* num_buffers follows the legacy header */
> +			iov_iter_revert(&fixup,
> +					vhost_hlen - sizeof(struct virtio_net_hdr));
>  		} else {
>  			/* Header came from socket; we'll need to patch
>  			 * ->num_buffers over if VIRTIO_NET_F_MRG_RXBUF
>  			 */
> -			iov_iter_advance(&fixup, sizeof(hdr));
> +			iov_iter_advance(&fixup, sizeof(struct virtio_net_hdr));
>  		}
>  		/* TODO: Should check and handle checksum. */
>  
> --
> 2.39.5

