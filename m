Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE7348C5C
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917587; cv=none; b=nytGfdUpc57rz1y3ekN22Mu78AFcomtltr8BAUnioFCPfZEv93hlBH3H6b33IhHZVR3Ysgt2iE9jxAVQ2JCsxRU8rBJHBHzeWm7/2Q5RXC3uU2PUHFxYYeJR1+JSLvhG/0JZtimJ743SKynwOs0YCiPDYUjzk8EW98CCEtPeCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917587; c=relaxed/simple;
	bh=mzaX6C6vuZHr13pss6u4zN5KYvfwiAcxJDMYW//l64s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9VLlKCvtr172qC08kv8jUuUtqj9YzDrf1MoGLQnmxMF9Z0H+ebrDXmaZfrDJOiu74Va8lKl7iwJ/rzxhOEmZWxPojZ5cw+xAdGQna3PQwoZDHCAQU6skZDNMapaCN4jjODi5rgZS/xP/46Fi1LzFDFmPD0w5QU728JIOvzpkUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kezx2qMo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oATqSGD6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kezx2qMo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oATqSGD6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782917585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZhnJ37qmK4wXhmEG2SVGmBhlYiKgFgvUvUlcftgiQY=;
	b=Kezx2qMoLP6TCXjJEhM70Po92moV2QgqEU8iUOlZIDnWNAcvfmKYaMKi4/RJbfpfZbBPwx
	eRjq+P9RauG/tyrBOhFKm8g6aaqqMJOFRb4SBMZ/GxoStKy7Nj7bbg+SYA0Md5ll6ryOi+
	I/k2a0dR4dGCfsDn3RD3nefyKSYxBss=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-sV_HoMjTOyabqrJfKlw2qg-1; Wed, 01 Jul 2026 10:53:02 -0400
X-MC-Unique: sV_HoMjTOyabqrJfKlw2qg-1
X-Mimecast-MFC-AGG-ID: sV_HoMjTOyabqrJfKlw2qg_1782917582
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4926d371224so6805115e9.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782917581; x=1783522381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZhnJ37qmK4wXhmEG2SVGmBhlYiKgFgvUvUlcftgiQY=;
        b=oATqSGD6QB4+JHQLokL1cfhuSCvDiuARY9u6a2AlBCGtQ5jI7zWzj42amiLVfBAAke
         t+e5nhJvSyloVtzuB9VjZCkaXVpap4TDIAYSt18EZg5QouoToWqHs6XX5CK9Tj7102Jc
         qsI34T8LPEmiVmKBVkDVMM+CawqfunpDdy3uPGCIodRi2KhNiLG9MZdswmjIAdsC69+y
         o/j2RjXABYdEpDoKzM4sGDr7k9Gn3lL5DRbzg5QkXGJPIFRfC2rZ+MrdvBne0LejzDq6
         ljrLzhKI7PP6DclPrXsmLu7f5PtVH8FBz0+GWDIMjAAjIPEnatyi3KqXmezl6kJMkdZm
         6nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782917581; x=1783522381;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZhnJ37qmK4wXhmEG2SVGmBhlYiKgFgvUvUlcftgiQY=;
        b=B5uO2gZ/MGfYLemfYyFVjeiEeNcnsbMOA/0TkWgSFmFAGP1zP007Jl3ysTMQtRI6zc
         pA5LD1cNxoKNAn8yxmFU13FrsOYtorUNrPajOjLMN/KFKHsza2sJa5wbOF6fzNVNrmLm
         s8tT1IjkUCdZ8YatB6s67Sasz6tJlcipzNpRH9Xum9dzkTZBs0/O2sMo6Bw062SN7Vf+
         ln93Z5d1xdPDN+UZFU0GAAzzQYaqf/RuSasz1kaSlDPs5SAxyJwI7bg8A8bdLjBHciNY
         kWFlntrQdUf9sQkdDjLbelp2aHPNjXPCqGpWo4d9Tk65VE78F4fkEOdmLr9r9hrzJsxX
         JK8A==
X-Forwarded-Encrypted: i=1; AFNElJ/IwbCEQ6/3YvLJzQyQBK4rQVqfKKD5hanTadOD3DsK4rjOv+COwiwaBwEFedgwqTZ4uFkoII0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcq/Cq9c3+1nE6Ki6dEMUXoFb/7ELEag+x5nGc2GE8qCk4tcfj
	zC5sSRY676796bkgQjy+pT1+6ZcwPo7f8brI4vdiTePAXppaQ4Pz1YFSD9N+ghgmnf75GZ9NVG1
	ualNnZgO40943xSU9LKKA014pBeAUVhxdOUAw+5f6NKnSfLuCW205xhhmeg==
X-Gm-Gg: AfdE7ckpwqCvPePgj1r2Mfd4PwwXin/HB1oP/Jcm7P6phP682sSn8Cimg2av4Pyojul
	F+Bj0eNnVSBaUYMszhSUdifLqk/lPnxjuT46U8X+z6FqAoAhGNqccA1nC1AcZAWnXL7vQV2QkBT
	YNY0mDNM/g36G+j5902hU8bgcjo8ZtJnIDqRDajsBfYeYbJPYwoPWey2wDxCpepM8ODXQ/Dxj3o
	9TY64OrjoFTYAC6nbCDB2hAq22y9ADwUXhWVzmM6mt3L9i0ux4iUbzdNIb8XKuINzyjQXIsqAAh
	y9E/2OToAO8/tqegANBydxppath1dhHOSqYwBMGr8+WjUqilXKvxxeD/IxirUUXaKaitPaFSf3T
	9WekhsG5kR6J1JZD0WiCABGIfPsbz6itJwdIiyg51IrlZ15y10pasELsY78scbzSAexmdtFBqkP
	hC3LBTHlrbew==
X-Received: by 2002:a05:600c:64c5:b0:493:bc4b:b8c with SMTP id 5b1f17b1804b1-493c3df3541mr15223425e9.38.1782917581633;
        Wed, 01 Jul 2026 07:53:01 -0700 (PDT)
X-Received: by 2002:a05:600c:64c5:b0:493:bc4b:b8c with SMTP id 5b1f17b1804b1-493c3df3541mr15223095e9.38.1782917581187;
        Wed, 01 Jul 2026 07:53:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bfe616f5sm38773975e9.1.2026.07.01.07.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 07:53:00 -0700 (PDT)
Message-ID: <2e617b47-2209-44ed-89e8-94a7f67b356a@redhat.com>
Date: Wed, 1 Jul 2026 16:52:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
To: Clement Lecigne <clecigne@google.com>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
Cc: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
 "horms@kernel.org" <horms@kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>
References: <20260629072300.1664622-1-clecigne@google.com>
 <DM4SPRMB00455DAA85BD5AEE9784C6EB82E82@DM4SPRMB0045.namprd11.prod.outlook.com>
 <CAHuCGd=KJqrem_WTdZ6LSeTpdaSauw1JXe9EB3x6QRtVvFbTLg@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAHuCGd=KJqrem_WTdZ6LSeTpdaSauw1JXe9EB3x6QRtVvFbTLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/29/26 1:15 PM, Clement Lecigne wrote:
> On Mon, Jun 29, 2026 at 12:34 PM Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com> wrote:
>>
>>>
>>> From: Clément Lecigne <clecigne@google.com>
>>>
>>> Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
>>> introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero-copy
>>> frames.
>>>
>>> Note: Currently, this specific AF_XDP zero-copy conversion path is only
>>> reachable from the drivers/net/ethernet/intel/ice and
>>> drivers/net/ethernet/intel/idpf drivers.
>>>
>>> When building an skb, xdp_build_skb_from_zc() uses the chunk size
>>> (xdp->frame_sz) for the allocation. However, napi_build_skb() automatically
>>> reserves space at the end of the allocation for the skb_shared_info
>>> structure.
>>>
>>> Most high performance UMEM applications use 4K chunks, where the
>>> corruption cannot happen. However, if the UMEM is configured with 2KB
>>> chunks (a very common configuration to maximize packet density in memory),
>>> a standard 1500 MTU packet will trigger the corruption because the required
>>> space exceeds the 2048 byte chunk size:
>>>
>>> Headroom (256) + Packet (1514) + skb_shared_info (320) = 2090 bytes
>>>
>>> Because 2090 bytes > 2048 bytes and __skb_put() does not perform bounds
>>> checking, the memcpy() writes past the available linear data area and
>>> corrupts the skb_shared_info structure. This can lead to arbitrary code
>>> execution if pointers like destructor_arg are overwritten.
>>>
>>> Additionally, in xdp_copy_frags_from_zc(), the allocation size is set
>>> strictly to the fragment size (len), but the subsequent memcpy() uses
>>> LARGEST_ALIGN(len). This mismatch results in an out-of-bounds write of
>>> up to 7 bytes, which triggers KASAN warnings and is unsafe despite typical
>>> page pool allocator padding.
>>>
>>> Fix the skb allocation in xdp_build_skb_from_zc() by dynamically
>>> calculating the exact truesize required using SKB_HEAD_ALIGN() to
>>> properly account for the headroom, the LARGEST_ALIGN(len), and the
>>> skb_shared_info overhead.
>>>
>>> Fix the out-of-bounds write in xdp_copy_frags_from_zc() by rounding up
>>> the allocation request using LARGEST_ALIGN(len) to match the copy
>>> operation.
>>>
>>> Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
>>> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> CC: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Clément Lecigne <clecigne@google.com>
>>
>> Hi Clement,
>>
>> Do you have a reproducer for mentioned issue or is it only a fix from
>> theoretical POV?
>>
>> To be clear, we were addressing headroom issues in this series:
>> https://lore.kernel.org/bpf/20260402154958.562179-1-maciej.fijalkowski@intel.com/
>>
>> so I wanted to ask if you are able to have this malformed setup for
>> 2k chunk size. That series should not allow for that.
> 
> I didn't manage to build a malformed setup and only used a LKM to reproduce
> the issue artificially.

Note that we don't accept patches addressing issue for OoT modules. I
read you reply as the critical setup can't be obtained with the vanilla
tree.

Please clarify otherwise.

/P

