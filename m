Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308427;
	b=UlqXt4rtyEgp4TbIUdS7TBr16Vz9e7bntPUK5kuIc7HuycF7kzGfOPYq1oPNF5xEKTKi
	 axqbBeNmCG7wuOaFMBeZUqL9lBaQUSZQxSIqjzjs+goiT9LR5Vc8RqbOBTfqKrUQedPAV
	 xnOdU8ZkAOte5Jb/cNqbsERrS0xgcQ4l71vztcj5Rq/MTgrtUs+5z/3bwiyXbULWxB0qM
	 rILzS5RcYYKmd74F1o9mDWNZAxYx6Sp7ccsZ0xwi8S9q5CX2LQVNsWHevw9evRTnQxlDp
	 wz8rLVx1zaJTCCoEdPA2Q5Y+quo2XZFrwHB0/d1SDK3E+3a49e1rOe+zWjXM/pg92sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308427;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PvjZgTETpTgpa2EwGhWe6LWOvKhagS++4LBHee0TILc=;
	b=h7epLwBZsZU0iiuZc7seEOuKDq+avCcTWGGoGY8q4fADbhQOdXncwTQdOTPNDh6izDg4
	 mHft8ROjt/SEbLD6wWUqIfIDi+qAKOsIq/f4nczwo9ohrIM0IiN3yvylnfHxTujLwRP27
	 pbC/2jV9rrtgXW/ZK7GYBbtj4pEn1TYhtjMFSIX4hkn6gDjKIXPf0+Qmdzpo9gRwTiza3
	 5vaH5PTFALoebYZpk5c3P9MdPVPD1RhCPGUEOLLeYDIibWG0mU+2WOPd3NaGo6wU+MqCo
	 cjJDQITo7iqycuQ6cfsB7rW/Q192U+RxzZgT9Vq4vbgVVhawuqitShuQjObJifTUbNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a6uCxUsS;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Y+HSlY3Z;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB0606A333
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6CB0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a6uCxUsS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Y+HSlY3Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794308425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PvjZgTETpTgpa2EwGhWe6LWOvKhagS++4LBHee0TILc=;
	b=a6uCxUsSS/xiUQS+WuLiglbvWEKl5dd+YWmU1reFVojt0fFvtd8X7gNOWeUgPN4Lnbw76Q
	VvuqidciN/32qJPjd765fQNBj9UYgi8kPpNZq67OlY5sorEdQj+gc3lZOIGb2AaeCcRfKy
	vweohSfSIDkuGUmLgyqAZr2xMY8qyBM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-pqHpN1a7My6eGKbY9Rt2OQ-1; Tue, 10 Nov 2026 06:00:23 -0500
X-MC-Unique: pqHpN1a7My6eGKbY9Rt2OQ-1
X-Mimecast-MFC-AGG-ID: pqHpN1a7My6eGKbY9Rt2OQ_1794308423
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a80bd45e1cso10602465e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794308422; x=1794913222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PvjZgTETpTgpa2EwGhWe6LWOvKhagS++4LBHee0TILc=;
        b=Y+HSlY3Z+JZq1CQCwXJrtDdi3z6rZDmup9WlROYS9xjK1kUni5DSy7Petr/3hyPedF
         g6R48wSLiVIwAnv/RC3PxqmPKyYfpS6lMUQYVcYzHBki2C0vH/HMJAbboLCLaqd+lnQU
         WS4mtabAXLH43WCn9TWICq7ua90/+AiHVsOs2AO2b7qMGpipiUDFPx1x6FkllFyQzlQ6
         yJ0pvAWKzdHxgreGIe6rz3UyUOfwchznzqDPDYHbLmsO5uZ2xcjAGFVMxp9uV1Tc4Xa3
         LQPGU463tQTc4bdQsMh/6xe2hxXZm9p8VDq9Xk5nJ1u10LPQL6NWu9ClJRrbHTYF8U3e
         gnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308422; x=1794913222;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PvjZgTETpTgpa2EwGhWe6LWOvKhagS++4LBHee0TILc=;
        b=MIZf7myhfD7HR3afdbVsFtr0zo1LWfZa2o9DgiCFoSKyUjCqCTFzge7pBwu1kBYkg7
         8HtF/IcMcCB7regqYSXBbnP4/10FsNL2TwM+XgcSyAPTV3OR5T8iZ2NJxRrrEVVNR/uI
         6Q2EWO2z77/73Ak4V61hSbPzwm1f2B1dnnCqSNLautuRUxykvwa/YYmAgm7z8y25DuUp
         RJYqRgRw6ETs3Wnr/6MTGmsM8teMZcAXJfNB87Bou2LPUcrP4NmDqBndiIGugLkCdW+b
         vn65J2ODmpoYzNa1cFqjz5WrlHyM6XogOAowSA/Ve0x/FBv5BdAjNj8NHB0PXnScHtXQ
         u77g==
X-Forwarded-Encrypted: i=1; AL+hErFQ/LbDCqgtS2lpdLswztdNz4gG0CgliHsISFbJQQKkO+JyuCdBRyBJCofn6FVa1/3F4BH7ung=@vger.kernel.org
X-Gm-Message-State: APuU4Z99KsDbBzgFryyTEzmvNgU8viB0eyB7+FGdVePcTdIMvvObQGaW
	xnOr6IUXm/wFgXaGHbwciY/zVjWv+pDqKm34GmxFXxlQzXe4WYShCwejrvyMf+Mp3UGou/63P2W
	3y5KPgal1l3vOz7pZ922ZLSqiwc2k+4VuTpc7FsbrwZfmfE9JNBnQ9WTFsw==
X-Gm-Gg: AYBFou2tPNCAwHy2JH90tIkm+PI0cQb1atJRI8PfxW+Y7VA+1wmha2YmPZ5jAg0F5j+
	KG/ztZF70WZALgDk3D65mmnk32ZGPhhBCsqy3DLNu7tRQLGjHLydUbsvcFs6Xt2624FrMiLAM1u
	qU4SelOFNt9pVlpPJHP/tTfZUbDhXHsSy2MaMDDqGxiO+8XyEK76W7SVNogBA9vcH4r9CZkqHPo
	5nqBzqTsZekydVRyxEu2/FxgjY8+ThQm4niGZn7PLnxiPQe8DSJ7Ka3tVfZJg3y1u8+4QOvBRxj
	ZZaMvuJeEvnldrqxpYQkwV9bix6oOP4Y4U9cTbuqQs2cT4n8SHIYQlU56wc5S4YkO2rVTYdBy35
	2dycTSYShpav+Jy6PbvrdgAAhYcKFUF4gQvk+A/TBAq2AlDU4pzq+2/bAYu8YyjeA4MmS5s/cOu
	o3tcmNsn1AbI7+l70W3pJSX27uv1cwuab00OtMhy4zGzE4
X-Received: by 2002:a05:600c:6095:b0:4b2:3c81:d1 with SMTP id 5b1f17b1804b1-4ba02336388mr36938195e9.5.1794308422281;
        Tue, 10 Nov 2026 03:00:22 -0800 (PST)
X-Received: by 2002:a05:600c:6095:b0:4b2:3c81:d1 with SMTP id 5b1f17b1804b1-4ba02336388mr36936355e9.5.1794308420789;
        Tue, 10 Nov 2026 03:00:20 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0204e22csm52154425e9.12.2026.11.10.03.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:00:18 -0800 (PST)
Message-ID: <e15d78be-1e80-469d-96e1-dd83cd90a929@redhat.com>
Date: Tue, 10 Nov 2026 12:00:16 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/15] net/mlx5: LAG, decouple iteration
 end-of-walk from MLX5_MAX_PORTS
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Patrisious Haddad <phaddad@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Shay Drory <shayd@nvidia.com>
References: <20261103171009.563034-1-tariqt@nvidia.com>
 <20261103171009.563034-6-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261103171009.563034-6-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

there are a couple of unanswered comments here...

On 11/3/26 18:09, Tariq Toukan wrote:
> @@ -2095,7 +2096,7 @@ static int mlx5_handle_changeupper_event(struct mlx5_lag *ldev,
>   				break;
>   			}
>   		}
> -		if (i < MLX5_MAX_PORTS) {
> +		if (i < ldev->ports) {

[medium]
Should this compare against ldev->max_funcs, like the other converted call
sites?
The iterator's end-of-walk value is now ldev->max_funcs. That holds both in
mlx5_get_next_lag_func() and in the mlx5_lag_for_each() condition.
Indices are never compacted and max_funcs never shrinks. So a PORT-marked
member can sit at an index in [ldev->ports, max_funcs) while the ldev still
has ldev->ports members. One way to get there: more PFs than num_lag_ports
join the ldev, and a lower-index one is removed later.
In that case the inner loop finds the matching pf and breaks with
i >= ldev->ports. idx has already been incremented, but this block is
skipped, so the bond_status |= (1 << idx) and has_inactive updates are
lost. The later check would then fail:
	is_in_lag = num_slaves == ldev->ports &&
		bond_status == GENMASK(ldev->ports - 1, 0);
Wouldn't that leave this bond silently not offloaded?
The old i < MLX5_MAX_PORTS check covered the whole index range that the old
xa_alloc() limit allowed. This code is unchanged at the end of the series.

This looks valid to me.

>   			if (netif_is_bond_master(upper)) {
>   				slave = bond_slave_get_rcu(ndev_tmp);
>   				if (slave)
> @@ -2360,13 +2361,16 @@ int mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
>   	if (!pf)
>   		return -ENOMEM;
>   
> -	err = xa_alloc(&ldev->pfs, &idx, pf, XA_LIMIT(0, MLX5_MAX_PORTS - 1),
> +	err = xa_alloc(&ldev->pfs, &idx, pf, XA_LIMIT(0, U8_MAX - 1),
>   		       GFP_KERNEL);

[high]
Can this let member indices reach 8 or more while several arrays are still
sized MLX5_MAX_PORTS?

this is solved at the end of the series, so not really a problem.

Note that there are more unanswered comments on patch 15/15.

I think a v2 is need. For the future I suggest using smaller series:
15 non trivial patches will have increasingly hard time with AI
reviews.

/P

