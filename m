Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553732;
	b=WJQScoMelbW2o1iS2csYWWbS4Ns6WdHHOhRHxG/rrXZvXDKPN1hj/hILFQ82dekr0YzG
	 aYM+io3UZ/DujLYm1nko99SHotVCEFDywtTJOTHjIGeZl20krta0R5EuELmcJ2ll5Ykmz
	 pVBRxA4u61MSzwcwPWTKfYiLiEqhQDDPT5GYN+IV1Dls2zuJLduMLQq5IYKaHfN6n/he7
	 juRrh8ltCgrW1NKRqnsIqHrytCx3/NxmO+y3SMG4SQpZhP5iW03xPka2CK1Isds7CORNL
	 3WRgRjzYPUiBXIVPBohyH6yH9qrQQcoEnr1oUTDdOT+Cj+9GeJsZUwmNZiaT19MzAAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oPLe3JqMkwYhFYfTROnA/4YF+cUNwjTAHP+fO6fqRl4=;
	b=RUhISESqWtl5GuTsx2+R7tYBGGYzOOUPspIFfu1U00cjiHxDh5KYDcFGzgOTq4k2/kYE
	 ps8q2l976h3PMgkN1H7+n8fhrsZLbpZbdrIVN6Xx+5R4aJgbi9QxRVkHV3zjShXe//n/J
	 6YVeb7MCMWW7JIkVVHsDkI/2DxdHcIgSoVfFZw4tziaofGSIwQFAQbifdh6kKC5O0MxnT
	 4wt8NiBG0aPyQFF+PqWPkUdKsW/7SVTw9xfSznEUZUP/67G8a1zAwWBbqBSZqd3zF9VBH
	 Z0Qx17sYyW5Mm2UHHlkX5tLEss88etU4P0Xgn6cKMkXWIM5nPYMKWvWwS9rps0qO2uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TVpIvV4n;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB6606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AAB6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TVpIvV4n
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e4edb98adso714285a.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792553730; x=1793158530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPLe3JqMkwYhFYfTROnA/4YF+cUNwjTAHP+fO6fqRl4=;
        b=TVpIvV4nlJDTXMxKun41kRC7eXRkav02KYDYRyX/LvrY7eBqI5T5cJXj37c1DndobH
         tjZq4JEpHfW/TqMqCJuraJkUf+T5mEGgF8YaqS4YjZ+/iyyZZjURaU7R5yrFBSDswETB
         4a9cKq4vIcn4KeXk0tk8GzpZ54x2CJfggRatQobDXg0f4qzPblbYPG/7vdhDnxJgnGoB
         XRDbrhuG+QJ5AgUoy2+rUBxHCNDlinTFset/cqzuSFRvdgf2WfxVC9jU+BhJ5FWKy0d2
         9oifpUC5fdq+1d2Zq/RTfUreRrJ9CDsm/5zGzYM7/FpsER3cN9O9FtYzQeLTDCga48Y4
         CRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553730; x=1793158530;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPLe3JqMkwYhFYfTROnA/4YF+cUNwjTAHP+fO6fqRl4=;
        b=Mt/fzO1ae9I2IGJ1Nnf1u2Rr7mPB/MOXIAwBpoyhTNqZ9Xw41VoHthGeE6W4b6ZOuU
         aMQP+S34cWi3ZV6bSKOOSbi+5JImJG6Zf1Yc8+I4eWH5Ao9K2GQUTOCwTdOtiQHZSqr7
         TZngRpzDhUO0DTBCsEjKcw8YkyAdwQml0NEJZzv4mCq3v8ier3u4s0WrJJJmjzAXMSdM
         M26MznG7ub2/tdlBPCjzvowllJqTfWV6hi+Zh+J/NBfwKleGvd6L6arxtDkYP5ds+H0N
         xR40EaJVKgxTSDWbP0NPqd4N5vWF6RGI2zAIx33NO9QG/Rbt+XSzjZOgBvDJNyAFbmok
         Kf1A==
X-Forwarded-Encrypted: i=1; AKwUvBzkv9MNoLnCMgp5qvNiOTYzZ6N1LyFJCnj8SqzyCAYmzm3nk6BqX2QK9Lv7yB4KB+nzzrv09qM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLubA7NdiJWbdARoFv6t832To5atgapZ/nqDnleNI++om4K63BJ
	0av3qzvRBzlri7fLL2+nh3E5heUJLPU5A32y8RhNGzVYZOhk9ShMVifi
X-Gm-Gg: AYBFou35E2wfrlDmUpo7ByZaZmP8keUbmIhIdDI9fbWPWUJ4X3P7WiSdJ9A91xZ9HJW
	8BDQBqeZZDLGoQ2JJTFL03IdlWlKQlKNzkcDLhNAEO9Z7wEQdK2z6+6CNgAZvZEvQHL9GtswaSn
	VL1Wy995Knzs6LEEQMhE5Veqq1jswVOL4sOTz7lbLB1tKC3s/8PIaSrPPcBHo36IohUEFQ+vZxF
	LfE96x3xQ6NA5RvHkj7lDyXyoS8bgov+OWif/j2VWAVfvJRb2TffsOVOWj+ZXaIscYjfmAmonGd
	4eyPT4YrV3zWd7i9lVwISEgIoVdXNMIfvpL1xURfG3F/cdXON7oAkwidExBQqgkFn/H4MooToYR
	pGSkb/jpMwkqRrkGGLN8BEFQBDYiGKs2oTkXAsFxqXulpQ7CN7UyFmJR3JfHymuvHJ4TlSsHJL7
	kylIW/hwZlndKAqg5zDOE/GL+liC62NLrNK2Kjmob1cGOPQZCuHflVP2iNI62C8VQdWcE79hV45
	frRaaaF2iJyJkGtLgzJRcWIMXT/RBSir/wzv2sbxt80eVMX5/PzGsJE2/Q3MyEceJzuLtkdhA/6
	4SJNHSTT5utz8eIfE8VRh6p8
X-Received: by 2002:a05:620a:800c:b0:93e:5a3f:ac13 with SMTP id af79cd13be357-93f57dbbb66mr253545085a.0.1792553730527;
        Tue, 20 Oct 2026 20:35:30 -0700 (PDT)
Received: from ?IPV6:2600:4040:498b:e200:2d8:61ff:fe7c:5d59? ([2600:4040:498b:e200:2d8:61ff:fe7c:5d59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d98e5asm144819385a.7.2026.10.20.20.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:35:29 -0700 (PDT)
Message-ID: <3a043f5a-9ff3-e22c-08ca-0a735b45b025@gmail.com>
Date: Tue, 20 Oct 2026 23:35:29 -0400
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH net v2] net: sunhme: fix infinite loop in
 unmap_partial_tx_skb()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Denis Arefev <arefev@swemel.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
References: <20261015114355.14906-1-arefev@swemel.ru>
 <20261020124001.655104c9@kernel.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20261020124001.655104c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 15:40, Jakub Kicinski wrote:
> On Thu, 15 Oct 2026 14:43:54 +0300 Denis Arefev wrote:
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> We don't take LLM fixes for ancient HW drivers

FWIW this does appear to be a real infinite loop. There's nothing
in the body that modifies the variables used in the condition. Based
on the original commit, the testing probably did not actually involve
exercising this function. I suppose no one has complained about this
for the same reason no one complained about unhandled DMA mapping
errors (DMA mapping mostly succeeds).

[1] https://lore.kernel.org/netdev/20141031.134354.207893264084946385.davem@davemloft.net/
