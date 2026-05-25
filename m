Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EBF3CDBD8
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693628; cv=none; b=U2yf87JZ4Fjum0yRVZ2uUHYS8jzE97qgr1C69TszfinePUBaRZ2ITHrP8jIl6cJID/SVxYsRiNVBRwMU8CI4w2n4LCsFcuaj+tFB/gEEgt/ofVVKnZSc7M7R/YWP89urPwQ1OnrU3V4X8qi9rySRmx9cyKeX9E+DVpeMTsgkrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693628; c=relaxed/simple;
	bh=6Ibj3rDiuHFvb7dECX6NQqxQiXLzBSgSLJdC4Etgvuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hh1ZHVbqK+Q7COhFFQdbl+yy+z++K+3GOC8+pqxbAAIAu/froQboHdZbBHP/85dSqLFVYeqbV9GGRYdk42C0FxnKpxYt1gjnEf8i8+Rbi460aqicYDMABn1RiY/vRLKup/xBSydraWrJ2Wm65S/lMbfAlD0pUx9wpfTCccu4+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpBfKgo8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpBfKgo8"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso36309145e9.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 00:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779693625; x=1780298425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBef4PSXxz07VNSWA99ybeQ92XZXDnaznRSU+yjQAT0=;
        b=RpBfKgo8QmlcGRd64BoBV4pDkOni91kVVpBeH8Aw3w0UFifbwo2JQzt88GSI55DsRd
         6VYLt8uGTfYbtIhs2K4z24VJQj4SwhGHBkckyoUC/p3Gy4GGXix0sDfP2QPz6T3jKF1S
         DysHIY1URb9n7m0vO9v4kLYL+EJJP/kfW9OrcrjMbqGO+i8o9sjzP4GrmsoVpfr7Eb+j
         79p38aDOq+rZSdi78EUsQxI3uAbWpUL5SXjii1NR7Fj1nrzZIrDYi8Y77jG8IjM/FHLd
         d/A2aja2qJkyjj71rOHHYqsZcQfZOCft+Xhi2CLOFDZM/nCwxEE3faWb+mHVRMa07AAg
         0O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693625; x=1780298425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBef4PSXxz07VNSWA99ybeQ92XZXDnaznRSU+yjQAT0=;
        b=bb2VQE8vrWvde8EgKRaWe94JoPYXNtH4ZxqSZht4AadkKB9Q6HCs/iUxEEC4gKa2gj
         UOzKop5y89VnCVyIEUMaziLJgC77Ciit1C8kHhxCjHEV5R3ugZf+6iIUdmVihVEP6pc/
         f6tERKnw+ciJ9LPQsG8yUPT0RBH40NR+VIq7eKMQCrggOqIQ/sy0uPTc2q8tYFZ55v+v
         Ls5dUR8I7tf+3w+SamC2QAk4oRB7zEZsBi8idxofRYXvxhddO8DF55Ab/PQ83znvWPvL
         HIsnNM1/GvKukdnmgAiFqhOaixABJNBg9rMn8jRFv1qdzTM7jZtjvYsEwFbtM4BCpdvX
         YBhA==
X-Forwarded-Encrypted: i=1; AFNElJ9h16zYoZbuzsEbOAUNTfhZN8VBShcy/rdessEVD+Z4mrDuIQTiaX+4eLKtG7FWw6X68QBwrcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BJ5wJ9yJxB5MHWCOJP2VYZz1pnxDud8WLiHdxkXrfgO1ERJW
	TdsMh5578NbgslTvlAfjApKIfmlTTZ+T5PIZg0ywJvHwe2sNuOcffXJi
X-Gm-Gg: Acq92OFdVHWx62ttSxsiwHZXT2WCfjD4bnkgX5IOY7i6zTCFGFGZMM2W97t8lYs+TaH
	Rhk7E5S/OZgle2Q+TbLeSzMAF24GAVDSeV3ktrjPxWSwIco/orSxtVsyo47lqhYwS3bC9uTf8z9
	hwab1McjIpQSr4E43pW5JGPRWvpFn45t5b4qbSQpv4oiNo/0a0Jz8Tg4kHtvnu23tNF0LEHB+Nf
	twZjggWSwQkk/DjxY6NrlttcU+FGar3uce0ZMS13toGdBx3pUCwKvDMKc/wtTRQ5Dv7eAbcYZ+G
	JzENXfZp7WG42G8oy8i4zFHf8hyut9SXGVlNrwKMDnB6Hht2SzlR2hyXwBq8LzQxvOY1e0s+28S
	Buw/XKgxLmUyOCWnGGzQX8R0jdHRtz2rgy+2WZHc5wJPbEJBzloShMW+lHoych6mxyEl2bOVGVa
	yCqaJ2Y3nskZlqtIIjbEPH8JRzusxZoeurOWmLoo3bjxnXuZQflNWLyvA7++F+Y/Qc8c/6tyQU6
	OkbaE0p+ncWelzWKCgbbJ/Ylb26BlFVQrt1oigXwxkSJEV6ltzKn8JHqKylgfbJM60lXS4boFuh
	3w==
X-Received: by 2002:a05:600c:4e0d:b0:490:5655:8d3f with SMTP id 5b1f17b1804b1-49056558e57mr128858945e9.28.1779693625058;
        Mon, 25 May 2026 00:20:25 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452765f5sm235804995e9.5.2026.05.25.00.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 00:20:24 -0700 (PDT)
Message-ID: <ab9ca1d1-e72c-4104-b3ea-0c10666450d9@gmail.com>
Date: Mon, 25 May 2026 08:20:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: gro: don't merge zcopy skbs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Huzaifa Sidhpurwala <huzaifas@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <c3b7f906bbfcbdfd7b4fa9d6c18a438870df85be.1779307748.git.sd@queasysnail.net>
 <willemdebruijn.kernel.8bb6e9bd9a42@gmail.com>
 <willemdebruijn.kernel.2c61f390b462@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2c61f390b462@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/26 02:00, Willem de Bruijn wrote:
> Willem de Bruijn wrote:
>> Sabrina Dubroca wrote:
>>> skb_gro_receive() can currently copy frags between the source and GRO
>>> skb, without checking the zerocopy status, and in particular the
>>> SKBFL_MANAGED_FRAG_REFS flag.
>>>
>>> When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
>>> on the pages in shinfo->frags. Appending those frags to another skb's
>>> frags without fixing up the page refcount can lead to UAF.
>>>
>>> When either the last skb in the GRO chain (the one we would append
>>> frags to) or the source skb is zerocopy, don't merge the skbs.
>>>
>>> Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
>>> Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
>>> Assisted-by: Claude:claude-mythos-preview
>>> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
>>> ---
>>>   net/core/gro.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> Huzaifa has found this to be exploitable to overwrite the page cache
>>>
>>> v3: maybe no stupid mistake this time. sorry again.
>>> v2: as Eric suggested, don't merge those skbs
>>>      https://lore.kernel.org/netdev/9f5afc14ea4ecd22c70d6eaf279a94d10fe29448.1779289597.git.sd@queasysnail.net/
>>> v1: https://lore.kernel.org/netdev/4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net/
>>>
>>> diff --git a/net/core/gro.c b/net/core/gro.c
>>> index 31d21de5b15a..bae89062a053 100644
>>> --- a/net/core/gro.c
>>> +++ b/net/core/gro.c
>>> @@ -109,6 +109,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>>>   	if (p->pp_recycle != skb->pp_recycle)
>>>   		return -ETOOMANYREFS;
>>>   
>>> +	if (skb_zcopy(p) || skb_zcopy(skb))
>>> +		return -ETOOMANYREFS;
>>> +
>>
>> As Pavel pointed out in a previous version, MSG_ZEROCOPY skbs are not
>> looped onto the receive path. From that PoV it's fine to add this
>> check as it will not match them.
>>
>> What is the path that leads to managed frag skbs in the receive path?
>> I can believe that it exists, e.g., a page pool. But since Pavel also
>> brought up this question and knows the managed frag use much better
>> than I do.
> 
> The key is in skb_gro_receive. That can get called earlier in the rx
> path than the skb_orphan_frags_rx check in __netif_receive_skb_core.

Got it, and thanks for taking a look!

-- 
Pavel Begunkov

