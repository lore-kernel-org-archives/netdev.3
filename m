Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498238;
	b=Aiilxz96h6A3Kk3HsX7UswaJo4JVAYg2TPgAruatt1GSACjGP8pcu7uE1jMvcLrbYf/b
	 86QqsEN3bRoGf3MuOjVg8G4YYtu1bGzyVrZoB+Y3+tnaxFG2+5C1LM5WvD131ivAu9sIA
	 Ovtx1T/Fv54mDPkKg59rpvlMdbO6Io421dHlh4gPw0Qicb3CIgzCug5Ivgg6TUf7GRdO/
	 puyHa0DMogsLO9lOxG8I3hFpU8ZQBtBE+VCdEh9plCepjR3y5Q5dESDoNi/FK2bJaX17w
	 +q7a4JGycVBLHDk+aiXIV9UTcZjgnbH3O+1vuq28PaiEu+obPxXy5x/1mamE9WBUQGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498238;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=u3oSPp0s0TNWLPGdlKU4E7LGbHQev6fgdUE8CLBuuZQ=;
	b=HDYV4XnmDfzVGxzU/IcxdGW5yOoDP2ezHuj50mMF4XPZH5MbAAQXloDKeP7OvUMTHsf5
	 PoKHi7wzUBWyX2qwbY7IWzQPXCbsUYNRCrHADD2yJnfg1bjiWYPTHKePHJ4tmdvKf4bPC
	 PsGZvU3unUDBGhp+Ke7bECkOAeMI/kyirUIMdJhmRARXyoj/q2pA4F9Djz89ZDjMXrQs/
	 GxCOrPnfA/GxFaeEIoz8O/22ULPswhMXmGMmMjSRMSTvGDVL+DTi16HF2VK/QZLJUGido
	 RSUipKC/MEvQIs/DGIY9RYnzB52T2qxifBJi2MiiHAMUCZSN2D3tFNmcNgHpIdJdS4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RKNtdemw;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="s/hYPa93";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD26606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCD26606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RKNtdemw;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=s/hYPa93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794498236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3oSPp0s0TNWLPGdlKU4E7LGbHQev6fgdUE8CLBuuZQ=;
	b=RKNtdemwyJYeJUcMYvH/+lTTfBJQU18LMMp6o5KTXGyAG7mllHgxR+BE0Rkydsd7Vh9wqE
	xxVkJQl8RJQn3f7OxyJ/XQPoJAhSkAQSw22YLB1M4VGr6obQ1RAfOplIoqbeHjnXImNwFb
	jjYPpLayYUgNPUOqr/iC/yWgY5ppRII=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-h_-eNIsUNQmU6HuGhUMI5w-1; Thu, 12 Nov 2026 10:43:55 -0500
X-MC-Unique: h_-eNIsUNQmU6HuGhUMI5w-1
X-Mimecast-MFC-AGG-ID: h_-eNIsUNQmU6HuGhUMI5w_1794498234
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c505eecba6cso198981466b.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 07:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794498234; x=1795103034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3oSPp0s0TNWLPGdlKU4E7LGbHQev6fgdUE8CLBuuZQ=;
        b=s/hYPa93e6SMiNZH8OlpKaKC3y92cAgC7zLTTlNgEOFdDRpM+KBnp9SkrIRQPo29b9
         4srFxkYUNChpzbnj7Z0OrbYLIv+oNsDEaLxNtxjiVFDz1pFnHngvawn9rgbHgq00joyX
         wOdikQRRnDayPrs5ZScxwMlGYJOXEs3Y2ecg9jJbXVDMqOZdbLKUJxKK6/2R3AW6XriI
         Rh+9iLTBDxp1pZ6Zp04SrdeO/mZiQnKX9L2UAyeAdAFHVG8atKk1LkCz1MhLm4k+31FG
         SkoyEtqxkDyootmrU66yu9KyDcpYDmWjzVBNH1vphm3QraHEGgO12gG6oTfl2dp60rCs
         uzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498234; x=1795103034;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3oSPp0s0TNWLPGdlKU4E7LGbHQev6fgdUE8CLBuuZQ=;
        b=BP5TTdJs3gxHKjk4yTk2T0DjZisb99owcLGraNhpox/9kNRlJXUDhpBNs2JZKX4qTn
         LQrsp6UU7FKZrlRRE1jNKWr8pS8jQAbQtSlni8e8UrDIEQm0vKdlhoODD8iuZ2j4FTWp
         m1ZwPwJ953t8z9sKaz1XtyKQ0YXhGJs86oKL1YOJ3PQ8zxRI/C+8mgfjwycG/FUukxZY
         gOZs1NMDU232N77GHMYpk4D1L/PTO7ui15lVJ28rf7j4E1pZNTdm37Wrf29wRAGxa8WJ
         tp/Zi5YFBOUuxc8q+zZjqe/6TSIwroqnAnBzqIkFFfxPA8BiaKsWcl5Fdx/8royZQQoU
         C+uA==
X-Gm-Message-State: APuU4Z9ao99tvVOHFlmYoemoHcs33zOTxl++0kH7SRuFdFWlFdFRDHwa
	gAhdKWFGopqRQFWYgC8Z33uMB99HIsDqP0VeVvIlN0aj772XC8W5P08SgStS3QQ/Fy9kQ46+Jq+
	6PhWMNHmvYxGjxCyaDQa2uPcwcFCRka+CsupGtJGm4FY8O5ZE05V0MY6yCA==
X-Gm-Gg: AYBFou186Rhu+2sE312NkekMx8vn2I66Q5YeqOU/pDkVdhEUXbqvLg4a2WxVwnSwKCd
	jFrmkNLajX/MxWKE0CfumxnqFTzfSuXkuw4TZe8Xbmswtc2WTPp9GG9v1Y+dB/l4/TOPzDgxRNt
	Id7WKbDqn+PupNv+SSGCX15rhuLj6PKjwAtBeHS0mNiEmjulOO82LVYyUX4RXsHoZocNn05KHmA
	IHcWhvxANWhTt5PvfxuPtmL05ihFyB5Vkmz8qGsMMtAeKiA9/hiCBdBY8ZRCsESA/COSsjZWxxp
	2Xgb6sh8JYwHgM7kJUJwotNpqOkQ0+q72PMYmV1xwYhEtE2/k5Y3zOrv/7jvxFmRSwgI1vquYNm
	A6QeQDAWXUluOOtCPgcV2Oh9eryT1qjzarMLiLgAoav73jyfklYVwJgRpOL4klzVXM7N5CXgxtV
	JXuvdH/657LW2IYE9x6b46fHtRngSv9ZItbBkDRnq/Pv1q
X-Received: by 2002:a17:907:3e9e:b0:c42:102f:15e8 with SMTP id a640c23a62f3a-c5066af2caamr478212966b.14.1794498234026;
        Thu, 12 Nov 2026 07:43:54 -0800 (PST)
X-Received: by 2002:a17:907:3e9e:b0:c42:102f:15e8 with SMTP id a640c23a62f3a-c5066af2caamr478211566b.14.1794498233631;
        Thu, 12 Nov 2026 07:43:53 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a651csm375554966b.4.2026.11.12.07.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 07:43:53 -0800 (PST)
Message-ID: <c014414f-fdd2-4a79-b133-44671c0e4475@redhat.com>
Date: Thu, 12 Nov 2026 16:43:51 +0100
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
To: Robin Murphy <robin.murphy@arm.com>, Jakub Kicinski <kuba@kernel.org>,
 m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
 <20261106184433.761422-5-kuba@kernel.org>
 <c83426a5-d21c-4f0d-b13e-099b6f96df6f@redhat.com>
 <d00d3435-fcce-4c0f-8ed5-a672b5b85dfb@arm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d00d3435-fcce-4c0f-8ed5-a672b5b85dfb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/26 14:28, Robin Murphy wrote:
> On 2026-11-12 9:53 am, Paolo Abeni wrote:
>> On 11/6/26 19:44, Jakub Kicinski wrote:
>>> --- a/kernel/dma/mapping.c
>>> +++ b/kernel/dma/mapping.c
>>> @@ -642,6 +642,13 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
>>>    * Same as dma_alloc_attrs() but places the memory on @node rather than on the
>>>    * node of @dev. Like with kmalloc_node() the node is only a preference,
>>>    * the page allocator may fall back to other nodes if @node is out of memory.
>>> + * The contiguous memory allocator (CMA) does not: only the CMA area of @node
>>> + * and the global CMA area are tried. The allocation may fail even though the
>>> + * CMA area of another node, e.g. that of @dev, still has free space.
>>> + *
>>> + * Allocations served from per-device or global coherent pools, per- device CMA
>>> + * areas, restricted or atomic pools, arch_dma_alloc() or dma_map_ops
>>> + * implementations do not take @node into account.
>> I'm possibly over-thinking here, but AFAICS there are a bunch of dma_map_ops that
>> are using dev_to_node():
>>
>> dma_iommu_alloc_coherent() in arch/powerpc/kernel/dma-iommu.c
>> vio_dma_iommu_alloc_coherent() in arch/powerpc/platforms/pseries/vio.c
>> gart_alloc_coherent() in arch/x86/kernel/amd_gart_64.c
>>
>> With this series they will stop using the driver provided numa node.
>> Probably not a blocker but possibly worth to call out?
> 
> Nothing "stops" - this series adds a *new* interface by which drivers can now indicate a specific preferred node, but DMA API backends are still free to ignore the caller-provided hint and continue doing whatever they want. This is already called out all over the series in commit messages, documentation and comments including the one above.
I mean: the series also replaces the old hacks with the new APIs usage
in a few drivers, and in the above cases there could be actual regressions.

But I guess we could handle them if and when they will surface.

/P

