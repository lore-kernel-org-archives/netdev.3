Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619602;
	b=bOZjeVeRLhai+YZqi4H8+r/V3tw+1mTnmSyIqnjZUWwLSJXXV+rlrMyxXJy/S8N6W0yQ
	 nbh0RaHuIxnFBXdhBYHf2M8zi8nA7Fk1jm25ZAkrBaK/ubSzj9X2QwqiaSoimuIvx8l5p
	 RoS8XV/iAhNEOZGQI9GWYgGFEu8eaM4rRy8WKkC9do0OHmT2YbzcEQgvnQjS2OS74HrjD
	 iK/ef2qOHlIbCBWb5xtCq9Yl0cApNcvNSP3b8Xyt7FKU1upyvsK7cb6gfnFXmPfOHWueQ
	 zuZ/hO4ouRaMg3EbcrBV0eW91LuDjbLCjJ1ahHBxpWfXCtJk34cz4A5Gg7Zez/T/8sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619602;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BVuyCsNuPDKfGswdTC+QFH5JQ3zW3jmol69S0GRJXKg=;
	b=OlRTCfYIIetI2wETIntL4vOBWO4VsjidxWNE2babq4FLIuZLz1iDLm8sOqCTZIQZfyLu
	 nmmykFoQu16fOa9fmCNqLhDRaWK77ahzKnEGFT7nlULIJd8lnZuv6bt5Nt9jc/lklv+jq
	 8Wwvjh4fiYx2NydZu+7mWJ169oODpbpnoJEZLyx0ZwIMaYcghT99BrEl9ndaP6Trv0SNh
	 6d4e1MVp8365ZZ95vapwBqN9VTsLSh2yV8VcTtQI7j0rSB70pgN5SG+7hySWvP/uSmbdw
	 q3m7UJ9bGxEBE/oaJjGI6KtPDUwEKBT6XtH8nq0XWrElCYG4/AHmx7U1NNwg12TF3jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nf4RMy73;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nEN0JHII;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC4606A32D
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30CC4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nf4RMy73;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nEN0JHII
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793619601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVuyCsNuPDKfGswdTC+QFH5JQ3zW3jmol69S0GRJXKg=;
	b=Nf4RMy73R9SduGIInOB6GjJkwav8nRyEZZFfvlA6LX3d2Js6s2FeuF5UiFhYPQj1TOFhxu
	+pepCmj/KD5gNBuxyAfUWxjOkQB9h1DXmmYcIT8BLd29oNqvT+S9nOWIzS/VNbsaUwBPTj
	BYMiXfWpMHHM/rPbuYvPQ8KEJCJEzR8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Xks2vVehOGGSAWSvic6pUw-1; Mon, 02 Nov 2026 06:39:58 -0500
X-MC-Unique: Xks2vVehOGGSAWSvic6pUw-1
X-Mimecast-MFC-AGG-ID: Xks2vVehOGGSAWSvic6pUw_1793619597
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a2065a2ef9so28063755e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793619597; x=1794224397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BVuyCsNuPDKfGswdTC+QFH5JQ3zW3jmol69S0GRJXKg=;
        b=nEN0JHII4mPkqlER0y17oAezn9JUpYdUYZ0YQjlajHgjn13MgT2ny9hkkqSxMuNG1s
         PO7NsMYDsALDmvjGXZSUcag+Ene9nQwektWd8DzBtjxk8UeUrBr98wRcUSO/LCJmzydO
         oBHWefuu3VxGgsW3Ictk57IKTzJf30ZU9L4W6pbc7xo7fEvem5mHNJjod3RdipTWtdwW
         Qx1y7OaVUHCT+FT9f4/ts/CcDi6aF8Eb9OZZ2duPXp5Vg61hfnftpfJ/Be57Ca+5uP+S
         lxbPls6yb7i5ymBcyQI8HWq1eh2GCrk4uSA/1TX6QcKBzVatvBAKt8e07p9efKMpq8uC
         WVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619597; x=1794224397;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BVuyCsNuPDKfGswdTC+QFH5JQ3zW3jmol69S0GRJXKg=;
        b=B5ua0CUBHRKK2ZRQpd29r8eG6sxH8pc2Z8B+ZQfrI7kyqpuVPZmpaRUWalS4IIxk0F
         Jal1SQxA+oYQcW8Jf72+BeXgMFvA61gxbukgtYp/a8tlKIxIuSWELC9iHufa+m6xNlqq
         tQzpe9jPLxisNPk6DDdqR/nl3sXTg+njMgv36T693lv6SslTs4zA3ZGTn3SmwuxrfV3F
         zCcysETuojsB6YCHH/guOnqzxuwFshxG5GG/380c3wqM0sFWUEX0h7UCc5/HL2egjWJP
         UXKJqGm3DyY4yKvo3gMe0DbMgeWEe4x+wLxfBeQXHmQ6AufKDry8tR3r1HrOWrzy1FCS
         g6lQ==
X-Forwarded-Encrypted: i=1; AKwUvBwaRTIPoUmNXCTMTrV57OjORAbEhNUMKliXoP+Wv4WZfO2PhV6kEDCNC/Bms9NioViOafkHn0I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrO8PgS2LEwbymCz8WQvznA3cRlU+2HTPQ3Nk4MxdUa22Itcub
	wsYQYsBeq4JAinBT0oH7nNGq664U38ZuZlxT2dCMFobUG+CMalnuRZN0h7wC6pK0aiTlsQOtuIU
	U3xCD1mcBP4i3Er46O6/AxuJk3eC/p6y80DqRGTf38icWML5HE5K9YxV9zw==
X-Gm-Gg: AYBFou23OC48yHjfV2+j+AeEBAFKkd7PoREr0Uqcit1SUhJ896CJJkTDaLm1nB0JNXH
	ehvDJAGLE5bXY0AMIY21yjmA3aGsUbts2NjI2ZNUR5c9w42xLd/U5AMQY4A5oYjUnKGGVC1CFGy
	gp194dq+qSrPhY+S06bDDnh+rv3uCq62+KFzn1mcvJTZKXxo+Ofdyz7/vcS14oMCB6fbl7DuMIW
	v+/nRM50o8vyf5LRbks4vmN4yq0RmMN+0/NV4LuCEXSfsazHHBqUNzlX3DAQZlI2w/teTAKz9I6
	eDexzNi2Matlm9CU8H4w0hGpEeU422wsNicLfCI6WnRnSPMrWV5VjzgaDxG6LCYgw5ZxnwHfbht
	/JPBrSy72lw9ykyfmK6jHNYDp5w13ZXEJ3+aIzREkCqOjXxhMbuwr6XhAxfKoYwksVbFBXC/qvw
	XEcrMN+TZypaEdb+OrCIOfWMDsvsCmiwJqML7n1334EVM=
X-Received: by 2002:a05:600c:4715:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4ac150b28bamr228459885e9.4.1793619596747;
        Mon, 02 Nov 2026 03:39:56 -0800 (PST)
X-Received: by 2002:a05:600c:4715:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4ac150b28bamr228459035e9.4.1793619596015;
        Mon, 02 Nov 2026 03:39:56 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm431693975e9.3.2026.11.02.03.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 03:39:55 -0800 (PST)
Message-ID: <c0021e03-2590-4aac-b4ee-9a8fdf26d520@redhat.com>
Date: Mon, 2 Nov 2026 12:39:54 +0100
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
Subject: Re: [PATCH net v2] net/mlx5: macsec: free struct mlx5_fs_id after an
 RCU grace period
To: Joas Antonio dos Santos <joasantonio108@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <179313582625.87630.11382992904624255106@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179313582625.87630.11382992904624255106@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/26 22:17, Joas Antonio dos Santos wrote:
> macsec_fs_id_del() removes a struct mlx5_fs_id from its rhashtable with
> rhashtable_remove_fast() and then frees it with kfree() right away.
> 
> The TX (SCI) table is read locklessly from the transmit path:
> mlx5e_macsec_handle_tx_skb() and mlx5e_macsec_tx_build_eseg() call
> mlx5_macsec_fs_get_fs_id_from_hashtable(), which does
> rhashtable_lookup() under rcu_read_lock() and then reads
> mlx5_fs_id->id. A transmit that looked the entry up just before it was
> removed reads freed memory.
> 
> Before commit d4ece08f4b1d ("net/mlx5: Maintain fs_id xarray per MACsec
> device inside macsec steering") the SCI table held struct
> mlx5e_macsec_sa directly, and mlx5e_macsec_del_txsa() freed it with
> kfree_rcu_mightsleep(). That commit moved the table into macsec_fs.c
> with the new struct mlx5_fs_id, but frees it with a plain kfree().
> 
> Add an rcu_head to struct mlx5_fs_id and free it with kfree_rcu().
> 
> The same issue was flagged by the Sashiko AI review as a pre-existing
> problem while reviewing the HW-GRO for PSP series.
> 
> Fixes: d4ece08f4b1d ("net/mlx5: Maintain fs_id xarray per MACsec device inside macsec steering")
> Link: https://lore.kernel.org/all/20260909065542.4B80D1F00ACA@smtp.kernel.org/
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
Waiting for an explicit ack from Mellanox.

/P

