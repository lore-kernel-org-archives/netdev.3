Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BF2175A81
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579927; cv=none; b=HXp0O5a7xrRy/ZJ10nrphnXfFSLD1SqP1fI28e6ygBgXx8hrhEv6b2JR7j8KSS4UL3kx8FlrF5jP2Vvz1tjqYx/O+c+imrsqZaYIVhpYEH03gEo6rVe9omoHnFKFlfS6GwAeRrIKtLI5jvwSW0917bCN1hlOPu7DDzp/jisCxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579927; c=relaxed/simple;
	bh=ZkQWGgFZCoFSBhFJf3coWEqHeUyuA2PzIM81IX4gGR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnXBv0DvGL3ip2K2a8wQg/DWQI9HdZYEitJ+7tR1wJQMaJxZgdSIg60IHDAe8tsZ5VC7j3EcBiFMiFOVaDgTCpfDTCwp/B+mfXDh0vs7ViG4hXGkptVFsCx0IYmQ8lMgGO5mwiTJ1EaPbRiFixefxT9zGSd0Xt3RHtfHqB4L7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cn0RyX4S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkORXdCY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn0RyX4S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkORXdCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780579925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kP12h1LonZWRO930Aw/hrU8SVFS9Dh8cN/DqNFBNMzw=;
	b=cn0RyX4SyBXvDkKCh7k5o7WGSISRmohyKLuZZjTCfKkbIZR6TZjmt78TPxuNTnJYAi+0DF
	Udngmry3Qb/PcL+wG6QAJgS+8coV8Fv2ePBfxdDN4aeS0MreOwGD+puOgdWgrJeI61L/Zr
	gXz7TBIBi+SeWb0l3Ie0DXlbdZoACU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-vehJaKZ7MyCoEGiLvRTecA-1; Thu, 04 Jun 2026 09:32:02 -0400
X-MC-Unique: vehJaKZ7MyCoEGiLvRTecA-1
X-Mimecast-MFC-AGG-ID: vehJaKZ7MyCoEGiLvRTecA_1780579922
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49048e21ea7so12087315e9.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780579921; x=1781184721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kP12h1LonZWRO930Aw/hrU8SVFS9Dh8cN/DqNFBNMzw=;
        b=OkORXdCYvmlXpYgTipIP5dCBW9WeIweyG9wTvVyNsa4ti1trnBMuKoeI1YXcoVc9lp
         v/zuuzBEjShXNWG0ydz8sfLK4TWX1+PBOMRxClD4M/E83lyU311Nh7CV26RVlOyQ/WQe
         EmTt+XZCYzxXvRG9+wXQH8nj8OdBWj0DkHbDY5TglJQbBYWa6Pp86MpV8K0zL1PZi97N
         4JgclbROIWua19OOASLxnARECcxQCJxIWbAT5FA1mGkYNuILivRjdTQwTFH/I7N+LAQs
         F82yrcaPuiHc55xy+SiVw1k04cPN1QK9RbHZDqkdKCGPuErfbmk8yp3TqgqFA6rYOHwP
         b+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579921; x=1781184721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kP12h1LonZWRO930Aw/hrU8SVFS9Dh8cN/DqNFBNMzw=;
        b=S48EyrRgQrVY3BH2WgBkkktp3Y28xaNhWxgavOBfRh3ms+t3Hpmd4qPfIQ2+5TMO7D
         39bCygwx6AMJYDk/B4MGRkJfgSdtC7d7CgO5bDzPKASFTqDEt7ZxCoHSc++NoqxuloUQ
         XAtKqv9JbvMCmIU/jZZTnmDFigQPBbv+VNUWpH9+1edmUHi1u0RD6cCPVAANLd2nVvs6
         UER3PQB+qzOtLZcHPsQk91ULcF9yJXuEvDsORl5+wpri5x416doGZ/qnemRs92yhMudS
         6A9SEmwyMEd/RvKe5PXg6bvT2YaD8YpJ51hrABM/mMna4Ho4kyBrJAhM+I+vLjMkUykB
         cIzA==
X-Forwarded-Encrypted: i=1; AFNElJ9CeyGEVfnmzSWnWwE+c0ih3MgiapqSMRzCYo+dRfNgP/uCD3Ie55W74aa6lc8FrSDrCx1A1BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWyP8uIYCejcfqFoRbnoWRuZHLlRcSvuje7n3jDgAnA/bc7r/f
	sY202DGv8VlUaUjWGWnJ0SaBM+DBuBoxM+wpESMaQeM3IoTvZm3oTy/cNocbmp46jJpuWKLjCOk
	4AG7TTKoJm8ffh3q/J736zEdubFL1Hf+7hR0JHAXk58cDPg+kH0OiDvNDGQ==
X-Gm-Gg: Acq92OEeX2Om7NgbXIE69VT7UvIJtnfzvetMwAlSFX/EWo2RVpTObrq3D/g9045gmLC
	PivHu4uMN5oOpOOIs/XsNCRdL7LDAqsKHw5TFVz/QbJ7bC8KsvVT01vYSXr6Qm6bDW+o8MxJNpt
	GBzxy3IdfPp6Bw4AWwrw8KuOA+o3scceqAOYeVO1qmNvsENoO8Usfa4irF4dmB469u7orGYeGYK
	zsJu7HkE9LDi90f7ugKBQFVRDiwSd7tYg2rdhQs8D8kEMGI2XY88r+JkYPNKpCtzZk+tPD1bM59
	f5GYRk3VxXOZeGg2xGocC9qUupN59b2L9udTwbLo4u3o7Dm9kB36LvU2c85/VCUfjbxTD0VxxJq
	MeGQ9GCUQnfqhNwCMWyDeAV2gYPglXxYFoIhtH+iOzDgh1JLo5cEhKkGOVtqagzuRge4=
X-Received: by 2002:a05:600c:34d3:b0:490:b26c:64ad with SMTP id 5b1f17b1804b1-490bc4cf867mr58229685e9.5.1780579921523;
        Thu, 04 Jun 2026 06:32:01 -0700 (PDT)
X-Received: by 2002:a05:600c:34d3:b0:490:b26c:64ad with SMTP id 5b1f17b1804b1-490bc4cf867mr58229275e9.5.1780579921137;
        Thu, 04 Jun 2026 06:32:01 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bda4fd52sm61620455e9.0.2026.06.04.06.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 06:32:00 -0700 (PDT)
Message-ID: <d9a23afc-6615-4fe8-a325-f3bde54ec6c2@redhat.com>
Date: Thu, 4 Jun 2026 15:31:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: convert miss_list allocation to
 kvmalloc_array()
To: William Theesfeld <william@theesfeld.net>,
 Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260601193758.626537-1-william@theesfeld.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260601193758.626537-1-william@theesfeld.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/26 9:37 PM, William Theesfeld wrote:
> dr_icm_buddy_init_ste_cache() allocates the per-buddy miss_list using
> the open-coded kvmalloc(n * sizeof(*p), ...) form.  The neighbouring
> allocations in the same function already use the kvcalloc()/
> kvzalloc_objs() forms; switch this last one to kvmalloc_array() for
> consistency and for the size_mul overflow check that kvmalloc_array()
> performs.
> 
> The semantics are unchanged: kvmalloc_array() returns a non-zeroed
> buffer, just like the previous kvmalloc() call.  Existing callers of
> buddy->miss_list initialise each list_head before use.
> 
> Signed-off-by: William Theesfeld <william@theesfeld.net>
> ---
>  .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c
> index 7a0a15822..fa4d24b3d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c
> @@ -239,7 +239,7 @@ static int dr_icm_buddy_init_ste_cache(struct mlx5dr_icm_buddy_mem *buddy)
>  	if (!buddy->hw_ste_arr)
>  		goto free_ste_arr;
>  
> -	buddy->miss_list = kvmalloc(num_of_entries * sizeof(struct list_head), GFP_KERNEL);
> +	buddy->miss_list = kvmalloc_array(num_of_entries, sizeof(struct list_head), GFP_KERNEL);
>  	if (!buddy->miss_list)
>  		goto free_hw_ste_arr;

@Leon, @Tariq: the patch looks obviously correct to me, still an
explicit ack would be nice, I think.

Thanks,

Paolo

