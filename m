Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477221;
	b=Bon+BxAP+rP/V+S97pOpkTihPNvM3dbF54rb/d71Ln73aIvq4NIMNNc6pzaNVhuCaKTE
	 f4z7daziZzCXMazojxbejkoNXfXzggw5Su95OE0XXfQOAn6HBS5pFZjEn0Kx7QrwrZsLf
	 IfytadliFvrfFAjhie7DQMp+/ZsGOOSVIfRAZQEL4z6bfsTeEcHOcp7eNhxoR6Q+uoWH9
	 kLg33tLDaSRm7hD6dQdOVwAoLeANfVcS1bykPdfHqy91Lv+9AUzRkv7fEasoadeK9QVp3
	 XVftr0NODnIBrV3cFoaldQfw0HQG1k6bjgG1wJ8ku9/+4yPwtsA/ERYpIqUmNPXRwBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477221;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=k03Ntp2ry5pgO/TcJOAttfz0cIyCVzxqYcnTvskPTaI=;
	b=gSNRBs2q8vyeCfD40HKHwnsQ6FZKTUSX+CJ/7rvAb7HODAYjljRCI23DchWXwD6wXyuO
	 477JFBztsyU63EZqbvBUjGDGD8NhoDlETUuImJR4Z/Cc/c0RBcdwH5N5BVvHNfTmdzEyK
	 Wmy5VtZUIIBJUqjVgScz/SazxFsWXy+pD0xAUGTv0L4h/GnrOoaYBJ///BBPYgi3/ZGIS
	 YzdoqSr+GBvQL+d7Awvapm7QmcExC/wbOIce2I+9/u09vm3AFQ5Z6hewk7Sz/pZggS1fn
	 Vanyb/Amel7KIBHZUjYY9jcwjtL1ChTdNJtaN2hupFNYHB/zXAJmMbZLZRMa9JNtRWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e8TEnGOQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jJquilm9;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F8606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE1F8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e8TEnGOQ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jJquilm9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794477219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k03Ntp2ry5pgO/TcJOAttfz0cIyCVzxqYcnTvskPTaI=;
	b=e8TEnGOQEmhVgJAIPOFGTYYc+FG8FmaGO2H4AiiY+FlbuYlL0L0R+XJYSh9ajncJnnyVk9
	+s1S+MApXZq3B00nEUGgJnnpb2t42WXtoU3Qb9jNmzXPVFqe3fzGsLwx6w9jzvczpJTL2+
	CtbgA4OPv80XkRFX1hrFRUuQZBPikm0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Dsy56wYLNLOQUQhZ0Ts2Ug-1; Thu, 12 Nov 2026 04:53:37 -0500
X-MC-Unique: Dsy56wYLNLOQUQhZ0Ts2Ug-1
X-Mimecast-MFC-AGG-ID: Dsy56wYLNLOQUQhZ0Ts2Ug_1794477216
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso28569835e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794477216; x=1795082016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k03Ntp2ry5pgO/TcJOAttfz0cIyCVzxqYcnTvskPTaI=;
        b=jJquilm9aduzqvxqXcP+q13sj9GcUXPFmTuwWlcwk8v7Nd60VIgy8cZuigkftUzcxP
         2vQxJdNe9NU7UNfR019TsLE096TO3cp0HmuV9kk48FwmflP5jZ8I9FyRvXFPoqsqYyiR
         pL98w2RSjhOViZXeF/2W+SpgNrgZzFG8/e/pZuJYnG01idkZPvRgb52ryHZE5uCRpkSt
         yoy/HQ29lNuRA1zgCfz5YQI95BMRw+TXwnYqZpylg9HCOVYWVC6G+ErnAUWnFLQV4Tl0
         thP24z1gHNL/hWgpuv5CwR03RGG97BxSVasEuVR7YDcqLyIgGnZGtuRyzOLaC4TazNti
         ItkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794477216; x=1795082016;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k03Ntp2ry5pgO/TcJOAttfz0cIyCVzxqYcnTvskPTaI=;
        b=l2JgmS00ygnru71kCtPGbMqrDjfzE/WPswH7QFWLY7Z/nkQraEqKUFhXq/xbvkCS67
         slf5pNmr9rq+HzpEH+tHYJp2yI4RBQQ5kn78L37FrJRX+HQDID8SnZHlx0HacbFq9tas
         kEXMh1aNrbgRlURIxJOuBhFV1CNcIPI59YudA8yjXwUtcK7L8vJPOaPkFuq6/er+5Qu7
         31o+yXJGkaWvBwXOacdgE3jhVlbh4yp7FALfaEbdqQ/NDbePGx6JGvc/D+ubNNTY5bG9
         lcDmOSQ6imqJbM86iYErXmaEuncyTql6nTVX2x/I0oAN/vdWEISwzPVCux+4E4/oONKP
         3BkQ==
X-Gm-Message-State: APuU4Z9YN/Ggz27GCBpvBNtm3pBPVGw2PSiuHcZoxH/PfkKaJZH1hW6l
	MYUwY4uGsLY4D5XCAFVwGHaWtwD7VRxNZjmFL6ZNMja+S9oOl51XeBmg5dYIqwXwn/8BDTnad09
	5nozR3G96Cg7c/gjfqG4kxPSp+qQh1o5OvrEwqeFo5oSHpgFrdThwmfbZEQ==
X-Gm-Gg: AYBFou1Z60jRUH1l1CfxQrlhvzAgc8txHP6VLYVV56NBHMZr3x+IqS4+F1MAU5rTv3I
	mVmsZWlcS06LmmoB2DrYo4GcxPQmNA5rZAkLM1//Io6E0WJHpOqjJSyBgV7CVI/A2ReJW6abDiH
	zZnNY/mvwoSWKK3PJPC5UiSEJhK4Sl6v4bwIPorLXU0k3LREba+qOaEiMywnytBz1uKzXaArxD1
	fHYETxzEudyTYatAtUzZF5dmcyW8MHmUOi0824ehDtoAqrgmGBGS2WxNLIBbzZrrOpnI9fk0CAd
	LQfz1uszgV5+RwKL0I1u9obA/hIYcjF3BZkruFjMc4uzayLDScc8OOZ8c3uLbEclzaD/mrsG0lB
	r7jTA0Xdwumk/4Y6uyNN5uEMBI/iiREmYFfM9oz6t7Uu7Pcqsv0j7f2PWbPtSBU+ogH8x9RYceo
	PyaL3QACMq5TQXdEEzjqdLA3hdtRS9FW8lJvjP8tlS38ls
X-Received: by 2002:a05:600c:e554:b0:4bb:534b:ada4 with SMTP id 5b1f17b1804b1-4bb534badf0mr2171885e9.33.1794477216211;
        Thu, 12 Nov 2026 01:53:36 -0800 (PST)
X-Received: by 2002:a05:600c:e554:b0:4bb:534b:ada4 with SMTP id 5b1f17b1804b1-4bb534badf0mr2171565e9.33.1794477215780;
        Thu, 12 Nov 2026 01:53:35 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29d24dsm58717545e9.11.2026.11.12.01.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:53:35 -0800 (PST)
Message-ID: <c83426a5-d21c-4f0d-b13e-099b6f96df6f@redhat.com>
Date: Thu, 12 Nov 2026 10:53:34 +0100
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
Subject: Re: [PATCH 04/11] dma-contiguous: pass the NUMA node to
 dma_alloc_contiguous()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
 <20261106184433.761422-5-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261106184433.761422-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 19:44, Jakub Kicinski wrote:
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -642,6 +642,13 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
>    * Same as dma_alloc_attrs() but places the memory on @node rather than on the
>    * node of @dev. Like with kmalloc_node() the node is only a preference,
>    * the page allocator may fall back to other nodes if @node is out of memory.
> + * The contiguous memory allocator (CMA) does not: only the CMA area of @node
> + * and the global CMA area are tried. The allocation may fail even though the
> + * CMA area of another node, e.g. that of @dev, still has free space.
> + *
> + * Allocations served from per-device or global coherent pools, per-device CMA
> + * areas, restricted or atomic pools, arch_dma_alloc() or dma_map_ops
> + * implementations do not take @node into account.
I'm possibly over-thinking here, but AFAICS there are a bunch of dma_map_ops that
are using dev_to_node():

dma_iommu_alloc_coherent() in arch/powerpc/kernel/dma-iommu.c
vio_dma_iommu_alloc_coherent() in arch/powerpc/platforms/pseries/vio.c
gart_alloc_coherent() in arch/x86/kernel/amd_gart_64.c

With this series they will stop using the driver provided numa node.
Probably not a blocker but possibly worth to call out?

/P

