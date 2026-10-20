Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533480;
	b=vng7qvR3OazWGpoOp1yOYZl4ZGMdsCmv9eVVcxnurej0cLi6NHmEUGEoKwzxbDix+4ma
	 /SRn7md9Jr8rTYIG/2VF40FqlPQ9DnGi9XDJ8KYsXSZ11k0LkRguKfDYRkSAmUC0flbsh
	 LV0BkWPHWl0p+18bzzKZNshq8CzyYOcfGCYZtY4eRuGhNl0cgw2vEY/zkslRU+h3Wkpoi
	 UGQxqxmPjRVTzPrbE/pUNqui7yzCEpgNWjfY9RPIE+8DB7GsZNl8YNNLrifTsMS9pCJsh
	 3kn2QVTPwOAWGxdV6dwB4eVg8g588ZLaQQl8K/FtkD/fS1gzGrApYBomAAkNFNKN0QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hYnXTzJewxVnTsYQsR0lTJu5zv/qnETwI2MNTZueBaE=;
	b=w8pDMqksdEUYgaKszkLL43yQJZ+wDJmX2PxUgBIM76GTIENZaqez8T/nXZfR1xYAd03m
	 IgegiN3EvyGDXVARGVfxSqHiZujX73XC84bJXrVaUiyD1LVqqxH6UBBE12+lFvH8LR5X8
	 OMuOqAOCWOJ53V4FcgZC3R/mjSxJnay5ifiTH9att/ZAhyqiD5eyB0QT2vwnWEzil3Qbz
	 4lA6898qHMbES1j4h2du3eVDVTvttML4a++lNKzQ6xyBuJh0eWun8AW+WeVfwAH5wJ099
	 r8u4015ed59KQ3cRwY/SSnSdiOiOJxRXRN1VRq7vqxWlwezg4rDTl32E0rvU1XXIRIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J+M8k3LW;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19984606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19984606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J+M8k3LW
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-33baa8eb238so13198eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792533479; x=1793138279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hYnXTzJewxVnTsYQsR0lTJu5zv/qnETwI2MNTZueBaE=;
        b=J+M8k3LW1y1p2rAPNOoanZEOm8pIOU1+hFBlot9nZuGIe4j/NEAa3FoXR4K0fIC/Ww
         nMySMKfpE2Akc8lwd9+qGjYpg65pMLQArQFxr4tam3HsNsKTXdlfbPjO2xBVcl2cHAk5
         5zHbTyv+gliwodCFR7WwgWQY720cCKozaMjhp6H0kmml3W2bYWCO0bmj2aC2HDVJlTv4
         qR0UCKjB/bpPAJupIljMfGC8oih7hHdEW9uM09884Y/2Qa0kNX/x6LnMQp+92vf8im2B
         qGwF2UGwdNw88cc+T6dT47t7P8G/p9wcCyLXIZf8fox/xEFre6sXoE5mS4Iui8gmh8xT
         z51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792533479; x=1793138279;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hYnXTzJewxVnTsYQsR0lTJu5zv/qnETwI2MNTZueBaE=;
        b=XyrcFoFed6ay6wa+ka7o+3B2Jg3ENmN1RGkmDyYytyNxX8HrNqT64oXkZOn0K53/5I
         GOGQjDEzg8C7ZziLqOmtUnwRO6Mo1PvY7jwdPWOMF1vGJfBo151Mr9ndXcH5OPK7Naeb
         1m0uRHF5Ue7bjukOv5mlxQ4XTdNsuEVRQmjFCcO9+cwuSaeG3cIVay5IY1tFeDg5nXPW
         AX41JweXAkvfIcXb6Ts23blO1K3+WNV3RIIGCIewFHrnJEC62aVxW/Ku4XQMjq0njsIT
         eUcQBgCxv/0dHERTtjrlRaLtzrAqrlTwGWIgH+fn0QveZ0ygynllKFT6DyQ5SWQ/4Ksh
         vUsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJFtPPQltz/ne3+aAYgUfZOePVWwVHGZ84cJVe0xeG9QzO1sJb3SWp3zbDFjb2pXPHMeLjX94=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBsTSSFcHfA32Y5skLRat40V4t8MyYx2xM5/4b/qwt3wPQsCC5
	/a42KN+glQQdfN6J3GqdGloi8yE022yh5O2DCthIIDvhyJ3oovZ0hOXI
X-Gm-Gg: AYBFou19G8F9ccZoZmzlAexUNrbgmNfzsnc5sEktAqetGHX6l1jAyIH5oA5T/lYXxGq
	QRxJGFizBTlJw3McMh/pjzdLbVHVihraagvIqKxGJqhjtFSjCy9PZpFf4Rzhhz9VSrNwO5ICECN
	1jzzwoc2kSbRR6AFTJpCBzyvBl1hNbmOYv6NECPjAwP5EBBoXuSvQzUEt/pSOn3k6sPiqFNm5av
	gkKLnpdkKSvDwRbyZN2pKdfB63tF9B/KfM9GnhVGctRBG9zWLJoC0kJw1abgZCcUWXyRPSjHTuH
	Qo/4MX8U2hTl0JFf12twr6c2ir8Xc+AiWvICh2/CrMS90RLcrnBoF+hKitdQ3HDGGTHv2Fd1HZx
	2R28y2du3wZscuBiXoTA0hs9Q9eU1KsC/cWs227FVUgi7gLrqEuFQ0CMpMKYhPFLdATs6nD/fuq
	cXbEKdPx5j3SkHdNJMFfN5Wr1/9LZ/WyprsfmoQFyh1ioFHIRu/cV+10JVmjBfFb927u8yixrZl
	ILnKyUSoWKlJ9x1tT2zkOIcD+aY5/Op2KXlvNaqOv0c4FW01w==
X-Received: by 2002:a05:7022:7e84:b0:143:4450:e1e6 with SMTP id a92af1059eb24-190a7660d75mr193063c88.35.1792533478955;
        Tue, 20 Oct 2026 14:57:58 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:70::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bb7f098sm1857639c88.12.2026.10.20.14.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 14:57:58 -0700 (PDT)
Date: Tue, 20 Oct 2026 14:57:33 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH net] net/mlx5e: Stop asserting for RTNL when closing
 channels
Message-ID: <atfjx6iJJiqAq3Io@devvm16445.scu0.facebook.com>
References: <20261020153659.3440902-1-tariqt@nvidia.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020153659.3440902-1-tariqt@nvidia.com>

On 10/20, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> mlx5e_close_channels() has an ASSERT_RTNL() from the time when RTNL was
> required for closing channels.
> But the driver has been switched to using the netdev lock a while back,
> and this fired from a flow which was forgotten during the conversion:
> 
> mlx5e_tx_timeout_work()
>   -> mlx5e_reporter_tx_timeout()
>   -> mlx5e_health_report()
>   -> mlx5e_tx_reporter_timeout_recover()
>   -> mlx5e_safe_reopen_channels()
>   -> mlx5e_safe_switch_params()
>   -> mlx5e_close_channels()
> 
> The RTNL is not acquired here, but the netdev lock is, and it is enough.
> 
> Rather than switching to netdev_assert_locked(), simply drop the assert.
> Upper layers (networking core, ethtool core) provide locking and lower
> layers (NAPI helpers) assert that the netdev lock is held.
> 
> Fixes: 8f7b00307bf1 ("net/mlx5e: Convert mlx5 netdevs to instance locking")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
