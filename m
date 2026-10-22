Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685495;
	b=YFhUVdd6OIyILL/v50Kkb6ZhbdeRBVuiDgFgeZIGKeZyV+QJUrDstcSLH95be+NP62o2
	 IRHdFsGgVleJB8YNpWzESAd35jSE14OYEc34zQuR82fu65++Ty0vOClQ67PIfy313LDep
	 Y1+2924457cdZH+o+DivHUwugI2sYCLBq5Ba6ianis6kdIdumRUVUEpCBV71OiTjvzLdm
	 A6e7mrhdetnMcqIksF+ShsV6LSpVO67bk1qoVQ2qPkqV2f68eQf7FLlbCRolMsIGxPDP3
	 HYT7CgRxrhxwdumeGq32FMRQmdeXjT9lYzbBwplZATXf7TEnASbth06JMxi9Ukbphxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685495;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZolVYJhL5yPQgM/2Gp/lmOIhd5O8wGaOXv+Tfsjy2X0=;
	b=wnlAbE9kkwy7MwVqxaYQc9SlqF3PHPgqxfFC6Pw3gPwEfBNQSpyao5dK+1B7i4gA7VEi
	 ziEk+FoPgyRHVVYaQrQwEBIiRmHo4MikxtDAiPUkmu3/cV4ugqluFYGMN2dVvQWd1gZ/c
	 YirQCM1STKH7PguD5OH43+5aGLLuiIX/p3ZcOkMoP5g9pgv1HQoyhkdWWDu8HD1Jya+pS
	 UqXFbBd8nKrTIOnUu4OWLH97GKOo6dFk6QYPG66sphwNfnv0N4+bKi4B8Xjol0naY3Cwq
	 kYbKbOqMPSJ/n13PW1EXX3RRtea4Br2VBhXZHHc78WB+gUhPwtFm3p1UutKGD2/Wsnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cSSObIE7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Wm3xLdkS;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C39606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C39606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cSSObIE7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Wm3xLdkS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792685488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZolVYJhL5yPQgM/2Gp/lmOIhd5O8wGaOXv+Tfsjy2X0=;
	b=cSSObIE72kYP7W3whM9h7EYnm8n2hLV97yQF3zeVSg6HPbR+vFZtCPfFnUKbIygGZabwqQ
	ACfvQHYtbDsuSl2nPPghr5hNnFZkTqt2NbxDm5Xdi9Lef4bWT3ptG9lSzs4ENe28CuRsl/
	hl54Aydg+CPuO03l4jFbd9E3u23OY8c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-Fthb6zj5NlWstlUrmscfcw-1; Thu, 22 Oct 2026 12:11:20 -0400
X-MC-Unique: Fthb6zj5NlWstlUrmscfcw-1
X-Mimecast-MFC-AGG-ID: Fthb6zj5NlWstlUrmscfcw_1792685479
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so1237319f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792685479; x=1793290279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZolVYJhL5yPQgM/2Gp/lmOIhd5O8wGaOXv+Tfsjy2X0=;
        b=Wm3xLdkSV0OCBazHQwWI17CgdpSMK5TM9eCoLyzlgOXTyaBhc1bBEHB0ioHfuDOi+n
         chvs3zBwGvvekWC7XeEViZrjskNa91SXu86r2nH3rHa4YBtzOJhtvNUuAmZIct6gItqd
         qIifk8wkOniLaZyUI/eyMX0Ifsfz7fKXS0bBQyPb0MlO730an+tRzT6AbX5J0qfIo5Ok
         NVzHG8S3Xjx4FqzZcuSASD4xPXYsQopMpevP7Am8h2BaUiOANxS6pNlSeytqtjNH5rYo
         o6o8fHN0Ho6pCebqxePGSeKHmCGHMPpqDOYOilysv7Vi+415wjH2QpWYwa3vVa6tLgar
         gBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685479; x=1793290279;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZolVYJhL5yPQgM/2Gp/lmOIhd5O8wGaOXv+Tfsjy2X0=;
        b=hF3euqPCJAjT6CuhK+gtLBDWTocdhwu3Bc5wK8CTpK92LVGlxwTqcZ/rV5AxVt0RE3
         tn33kMiA0fgVGXaeb6QHlj9E6l1ywBC0vURnKsTepN0O2Kn4NcV901MA6TeOXIHtORuH
         S9oHhn0DWZhearBju20edQJzSarDbflIFdEBQ06+5EIgTEbZNdB3w13iRX03Ymu2xVxz
         BbxXO4Ta1xQrFfCxi2gKJHfqLX2r/EOndrtv8cUDfJNHyRsxM6J3VwJa89SqdUYWnXCL
         mNVIgwZaKA2lR9/+n28SDqQ5eueBR8qLVmJEoWKIrU78VkEpNa3jQlTKDrUeQwldWWQy
         iHqA==
X-Forwarded-Encrypted: i=1; AKwUvBxI0YuIncRPnUYrFBjd4jglJwYb2oo6xp1lduAWzJik0FVQpGDyFpijLTdTHD+lWXV4RPA1+kw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8pGIxQOPM2EODkIxKkBXTbR8cE3JVnrUeG+MFS97sS9hNYFr+
	czjn6ehelGZGFiqS1RUzTKCfIiLa3Tf44FeZjazHRivd9AtisPSLMw+RoPQ/1oI/Ej6VrWAeWNh
	0uYU0khvh8rOD4/VyWbQQ1HPiKL2eNVIbdhJY0xMffcewLKKFKgXTmaj2pQ==
X-Gm-Gg: AYBFou24+bpaogS/JNookJA7V5nW0QLi6LMZ++N/MWVD2uNZ6hIuAE+S2JuBfsHFss9
	ZzdUFW6yJHwndeGb4y3VEIPuwMwXrNkiy9sxPCGN0RgSbZ2Ny9NHVMlxt9JpfM1pBPJYi7Bxx/6
	4gderbenaVRAo4XuXmUMrDITEPMxh6TccQYuxYeXQhWv7QQ1Id78oW79yV5x9b8q1NiCTXzexpU
	d9BpIYz/vjcIY/2nWQcfgp++CD+QDNYURXKNOvvyQoAnomczX5/RWSMSBrZxBBPRad64BgGlnjA
	qio0ry21zk4e97DlvLqovrW00r45NrU0PEjnrUvPvucTJYHhmg8ylcMKdjAy9RiRT1g=
X-Received: by 2002:a05:6000:200c:b0:48a:f8fb:cd49 with SMTP id ffacd0b85a97d-48e264d53efmr12352941f8f.22.1792685478897;
        Thu, 22 Oct 2026 09:11:18 -0700 (PDT)
X-Received: by 2002:a05:6000:200c:b0:48a:f8fb:cd49 with SMTP id ffacd0b85a97d-48e264d53efmr12352904f8f.22.1792685478333;
        Thu, 22 Oct 2026 09:11:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835b1dsm14376089f8f.40.2026.10.22.09.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:11:17 -0700 (PDT)
Date: Thu, 22 Oct 2026 12:11:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] net: virtio_net: decode tunnel csum_start as
 little-endian
Message-ID: <20261022121057-mutt-send-email-mst@kernel.org>
References: <179268538303.70821.1734486381476363942@gmail.com>
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
In-Reply-To: <179268538303.70821.1734486381476363942@gmail.com>

On Thu, Oct 22, 2026 at 08:26:48AM -0700, Cheng Yongkang wrote:
> virtio_net_hdr_tnl_to_skb() decodes hdr->csum_start with the caller's
> little_endian argument when it validates the inner header offsets, but
> then calls __virtio_net_hdr_to_skb() with little_endian hard-coded to
> true.  The other tunnel offsets are always decoded as little-endian as
> well.
> 
> tun passes tun_vnet_is_little_endian(), which is false when the device
> uses big-endian legacy headers: by default on big-endian hosts, and
> after TUNSETVNETBE on little-endian hosts with CONFIG_TUN_VNET_CROSS_LE.
> The validation and the parser then disagree on csum_start.  For
> example, the bytes 14 00 decode as 5120 for the validation and as 20
> for the parser, so an inner_nh_offset beyond the data pulled into the
> linear area passes the check, and the USO branch reads iphdr->version
> out of bounds:
> 
>   BUG: KASAN: slab-out-of-bounds in tun_vnet_hdr_tnl_to_skb+0x74b/0x830
>   Read of size 1 at addr ffff88807999d044 by task kvd-program/9399
>   Call Trace:
>    tun_vnet_hdr_tnl_to_skb+0x74b/0x830
>    tun_get_user+0x1827/0x3d00
>    tun_chr_write_iter+0x113/0x200
>    vfs_write+0x5c9/0xb30
> 
> Decode csum_start as little-endian, matching the parser.  Callers that
> pass little_endian == true are unaffected.
> 
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Assisted-by: LLM
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>


duplicate of
dfcede18b8d54519bf586b8e5099e89ec63bf014.1792668082.git.mst@redhat.com ?

> ---
>  include/linux/virtio_net.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd0..ddc6341747e5 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -324,7 +324,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	inner_l3min = virtio_l3min(inner_isv6);
>  	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
>  
> -	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
> +	inner_th = le16_to_cpu(hdr->csum_start);
>  	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
>  	outer_th = le16_to_cpu(vhdr->outer_th_offset);
>  	if (outer_th < outer_l3min ||
> 
> base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
> -- 
> 2.34.1

