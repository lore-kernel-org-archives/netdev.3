Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8D282F0A
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170362; cv=none; b=ni8EMzgdybMu0Zeo0lmb7yOZaFGuf1XfujqVypf4ndyke2RMiuLCLBKtMCHSX2vkKdG/XhDebhd56++/moqJggONnv8e224hqtUQWDFosOfdgTMrhqmHf/UOX5DoX393VWTD+e+CWi7fKduNWu0YlBOJmIGaJhArZ0TpI7BGEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170362; c=relaxed/simple;
	bh=WplzDdnCS+71PsXKDF4b0oNPugOrz3tfVe/1z5xRtk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7YzQiUL6UQ6dPPyL34h/pfS1+vPVBtu5M5JQIvSFfVvI7Z4d2MCTRC5DBriqAmIajawkBltqgtFIky8bdJbqLsc/JoJZec0CeYPFeeBJ5T/xl/WxuEq91vqejE2g4HMz1pKC+oqZqSMua8Vc+VCmDJ8DSCQ+I5LzIFT5qT/4OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFJLaVzt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFJLaVzt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso19589165e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785170359; x=1785775159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=malQCOcVTnhvlSglj8xagyh6DGO/pkvzAAjITzKDfKw=;
        b=OFJLaVzt078Z0Th8RehwLMMgcWijwwRq1v5DTbpe5y3QtKDWbHZCShp21PUZnKNgyO
         EZrdmMR2/QmSYFZmjUgQE6p+76FNuSX7b2TdRBMG2oTq9Y9Lwiog49ypEr1DrK+twJ/S
         Pt2coQLY2p6ctYD8TNVbubrmQz5WXR361eMxEUciz7/iTHgNg/6zt3Dg0p8ATr/R6qnJ
         oTrr9Wa1/hqKa8dn515KCNs6q2nAlPP3mg2ImLJ462a8hceqs7kN/l3Q6B0L0kGPZe8i
         08gw7yhb5SaTJuOj/NdYzDAqRKc4YTsO4LXfb28Eeo624ZQwszf8jWGD9+n/75kTb2L9
         r4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170359; x=1785775159;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=malQCOcVTnhvlSglj8xagyh6DGO/pkvzAAjITzKDfKw=;
        b=V4zwtWCGNgkbtwDG/AnRVzwRgMc+sE41DReZyWsLpMNhhv9gwk/mRme2xsWJirxW32
         ZmMcyHnY6KlV1vKXaYSw4+Nif4dJ9+ZPbqU4NT3Db3bQEKf9UN+TTJulfD+/KDUnGPkg
         osScdpYO81BMVywsz+fKo/dCFIzEvKnFp2QRGAGjG+XFAWAhxRDpC50qXBktygvWkALv
         Rl2f4a5om8h3P0+m8rArd/D9AwJ2GNKDso2u34WSdXPsKNVdDnXjGQwo9+O8CJhNrhU4
         Vu0dIAp+rI4jLOjjdlceT77MZvWvI+mrOOw9oghNb5SDneRAXGlGkKIAFttU0oEY15ls
         qUfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQFHtyeP/rdQ72koataJ7qnBqKEpUVdYZkLnnz0mNIhAiVb+1vZJPCGL3l3w0/4E0vNkGyDkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytuD61NCx1STQR3W1Pd32LWVcCfZ4Jr4cKzyV5NgWnJ4pXZk3u
	RYamDZ+GJ2NfXpfhF5AWIdpUe2GGjRxcHRKaDyMmPziYd1l2qUOPtQ2A
X-Gm-Gg: AR+sD13fOhCSKnMJGrjc+abufDyPBU+YyUENMiHupuWED6hxBDeN1mQ+xMmYr9pGMqI
	x80wTviwtCJ7UynOqk/DBrVMqUwuMQ4dgDQhtWwL83a/mEwYVkS+v6xUfsHqY0+EqhLYh7WlTsl
	V+0beuxtPgJnyM39KZNC1s/zIc0+h1+hePm+Gi/ZmBocV4ieb47kSQQK1UUsceedZFlZG8fQmOB
	G2M6xCWh/SgCaDeqdF0SMGl1PAGvyvcEuKcG9Va4Iq5rpFqdHNgXASQmFQw0LyJpCcloUV28m0J
	N5EsBexwSdafXCQ/4gwNaWVRAeXdLY8A9FUl6Uxq1FWluo5wkWpfCM+vxOpbnaQql4OVlITR9YY
	XBxl+6ZbmOokXkcz8Zf96pJnJcNRdgmj18pF/dwfMrhom1rb7egkBhhkUpuax4H2TwuKrDeqFKJ
	9Yrozo+7kynlKtmNLwMXxdoLgwyha9q46NL/jFZibApL8cCnpmGrmzMl/YJyvoUd1yDWTYARNG2
	QpJB+Ar8+Z7amB+hGY4yPb+w+fMXobMevqRykRdYudZ7f8weY1VJHcwXNAWtwa6Nx5F7R0GaBCU
	G3f1tRcCAnYEk1P/hwpi
X-Received: by 2002:a05:600c:46ca:b0:496:c0f6:78d6 with SMTP id 5b1f17b1804b1-496c0f6ae6amr40332635e9.2.1785170359284;
        Mon, 27 Jul 2026 09:39:19 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:4f63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45b1c76sm4492315e9.6.2026.07.27.09.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 09:39:18 -0700 (PDT)
Message-ID: <9d8eaf93-9d2d-46aa-8f12-ecfde1a906f2@gmail.com>
Date: Mon, 27 Jul 2026 17:39:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: devmem: prevent net-iov / page mixing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Mina Almasry <almasrymina@google.com>
References: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
 <ameCMuhluA6j21mL@devvm29614.prn0.facebook.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ameCMuhluA6j21mL@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/27/26 17:07, Bobby Eshleman wrote:
> On Mon, Jul 27, 2026 at 12:19:37PM +0100, Pavel Begunkov wrote:
>> We should either have net_iov or page backed frags in a single skb,
>> otherwise it blows up down the stack. Don't allow mixing in
>> zerocopy_fill_skb_from_devmem().
>>
>> Fixes: bd61848900bff ("net: devmem: Implement TX path")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> v2: EEXIST -> EFAULT, as skb_zerocopy_iter_stream() doesn't handle
>>      the former + for consistency.
>>
>>   net/core/datagram.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/core/datagram.c b/net/core/datagram.c
>> index c285c6465923..173b5d97bd40 100644
>> --- a/net/core/datagram.c
>> +++ b/net/core/datagram.c
>> @@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>>   	size_t virt_addr, size, off;
>>   	struct net_iov *niov;
>>   
>> +	if (i && skb_frags_readable(skb))
>> +		return -EFAULT;
>> +
> 
> Doesn't this still break the allowed scenario where the user does
> sendmsg(not devmem) before sendmsg(devmem), and tcp tries to append to
> the write tail skb?
Considering that it crashes the kernel, no, it doesn't.

-- 
Pavel Begunkov

