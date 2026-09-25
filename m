Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E95486B8C
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334726; cv=none; b=J/Am4+YPwAxvBPFly2BUTDT+yWPbUT4Pie6cHhN7C5b3wBRfI/aaW0ogOKWWvYqn0oue73WZzNx3A07AkcTIrXRUR3yf445Ju9uQUVtpnq28uaV120KuHx6tW1yMn5USR7Pd4kFbqEW2fK68V4uI4F1NFvq8iXXpFBQyUDGY5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334726; c=relaxed/simple;
	bh=GuW7eXEh2gVczNln7jtlJt8uCjI8l0C1PzUKgYCAbxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9n8rhx2BwAz6gqRe8AdqmJsX5uaLeQt08XyBbtBaDqp3b2Szsd+BGKW5st69Kp/dfFps7fASGD9B6bAQx0y6OKFQTzbYdeyUosJ7qcBp6jE/7LhRotAKLviTyyC9GKJxXGXVAoKPE5+cxDpLRggVg0xrCCJShpdOfEGnn8OnVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmX9Rq0s; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmX9Rq0s"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so5013935e9.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790334723; x=1790939523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUYgotJhZ6LNOKd9OKnwgJyVznPrlzbQCA8QrOOaWH4=;
        b=YmX9Rq0sXPA2AUzkrD21A/2+kmiQUlAynaMsf08bZzRFzX1Bp+FV4Fs9H7rdvhqbE5
         LinO2fYd+h1FbNWPb0R0Yn9rztwgKcd9EST3I+XWfJjn+Kw7MNQj2Jv2VxbJmgPLWd1H
         5+lgwA+7wKlEi3mVK9+LkKEUzLDR6pfywrnZGYYSEdqwz4R/qMMpE1GANHsg1WrRGZA/
         fpbsNIzC/7m4/CgqWVqZdR/5YLx98R9LNZnEh0uQqpElEGR/lEstMmPH5WmBHbC20nlj
         ETlbOBZYWuM1kLnAyvwEkLUU8u7eJqitNz15nwIBet8/NlnnUjx5kmmoNJsLiJTn/roO
         kD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790334723; x=1790939523;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QUYgotJhZ6LNOKd9OKnwgJyVznPrlzbQCA8QrOOaWH4=;
        b=fWQgJ/5BBdOthUx27AM2ZF3V6GN53pr409LLUB9ahqR4XfxAq4PObRRj+CwQY0uFb3
         zkPP8GlFmL1xhIKzr4XrK200w67kT4hKuF7ypWoB+ozgtGMWFeRB2tnw4KjE2wEkaInz
         SvIuM74U8H8Enid2V035wnX7V5QGfjlsyt727AYlgESsqV68OwA0UlqaRK5y1wHwDRQ4
         AOgbZYaakOf3dbeMyRq5Uly4jogXFr2XrTYsP25V+OAk9flg9DF5xoXFXM0DWW6wXDhn
         8rJ8r97s2nszmWio5MQj6va1EP4oKV5z7Ue75GHbnslB46QQbGBYqGYfo3aAk2CAw3Hb
         9y2Q==
X-Forwarded-Encrypted: i=1; AKwUvByqMicqZpbHdmpWS0Gp8LEjwp0ng7VqTKfTEKhTJi6IRUSKa7371Jl7dAd2BSKrA3Rh+60RvS8=@vger.kernel.org
X-Gm-Message-State: AFuF++lgvRYu+sTQdTSFKCjrIAnBZudxgfiYWvyBPRrPaPIsEXkELWR8
	ag0ylfyENOpfXg4/+KJZ2Dnt2TdrsPZ8lhNai1F508f9NCwTcfTrQC60
X-Gm-Gg: AYBFou2UhTAZ7zKfeiE8o2ub7e07J57tH5qoF+fpIG3xoVds7CQN711tmi2kHJ23iO7
	8zf7+edmpSwAx/1L6PCbzr2HmvSCsrrAyBc+R2mh7mmdagg6zNAUAZ+ZPZ9UZLu8W7jxdjuWN12
	cfg+Zg5ScAmgh0lboCPZ8tR3fGPWbScaFy0qVecwyvyv9w/VHyGlJZpLB/AYUOIX5jOJFBolrrX
	Szq1qQ3Y77ij5x6J/pwNYUv6wNQgAfT0pgoDm93L7jGuqquoxY3it63mbG4hNJo/oLkY8ASQYEO
	HlU75zD/n4ptIPvC+AxTo8mqfTJKJB1iXtSjU5yyREJILGj6TDucdieV5SyhqtaQXVoTO1ApGHC
	yrZA860iT0hViUN3nB3BLYbW59R6VK3u1npqxY1WUYR3YF6GQd55WYVQxcfeV43G4LS/NV4scVQ
	fHqCRiBoc/19+O7yITcj85Mc8niVNpSodefg0sgk4iwgmNAv6kzvidDAuu1F/eGmMigERyHt0bi
	Hnkzb0/LYO2YCedI6D7Xs61tjVAH+vVVmFMQ/XyHKQ1FNMyzgvu7W1OENV2Eaa/fjCxod2aS6Ce
	uvKEYoT0gRnvj0XCcJZp8zT31MeKmhROfbsEiAzmJiHtom9U
X-Received: by 2002:a05:600c:6207:b0:49f:bd3c:bc20 with SMTP id 5b1f17b1804b1-49fe66ff476mr101883265e9.27.1790334722519;
        Fri, 25 Sep 2026 04:12:02 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff0658747sm58978745e9.1.2026.09.25.04.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 04:12:01 -0700 (PDT)
Message-ID: <b00ad4a2-d317-4d75-95b1-7d2195c069a9@gmail.com>
Date: Fri, 25 Sep 2026 12:11:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: netmem: add net_iov_area freelist
 helpers
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, axboe@kernel.dk, sdf@fomichev.me,
 bobbyeshleman@meta.com, kaiyuanz@google.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20260922204348.717198-1-sdf@fomichev.me>
 <20260922204348.717198-2-sdf@fomichev.me>
 <CAHS8izPwLBCJXM_0Df8P6S-FVwAq+TaRKn3uTh1h=33Ffj8VmQ@mail.gmail.com>
 <f566591a-cef3-459f-a39e-86addb0c5d7e@gmail.com>
 <CAHS8izOwo2NZGaxtxaMcjDu1APY7ERLjsHN4B_Oucqs4jZafqw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izOwo2NZGaxtxaMcjDu1APY7ERLjsHN4B_Oucqs4jZafqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/26 17:46, Mina Almasry wrote:
> On Thu, Sep 24, 2026 at 8:41 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 9/24/26 16:02, Mina Almasry wrote:
>>> On Tue, Sep 22, 2026 at 1:43 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
>>>>
>>>> io_uring zero-copy receive and devmem both maintain a bounded LIFO for
>>>> net_iovs in a contiguous area. Store the freelist in struct net_iov_area
>>>> and provide common push and pop helpers.
>>>>
>>>> Leave synchronization to area owners. Keep devmem's area adjacent to its
>>>
>>> This could be a follow up change, but I think synchronization should
>>> be provided by the netmem/niov infra, rather than the area owners. TBH
>>> the infra providing an unsynchronized data structure and letting the
>>> area owner use it and shoot themselves in the foot feels error prone.
>>> For now we could use a comment.
>>
>> I don't think we want it. The duplication is minor, but I'm not set
>> on the per area index array approach, and it'd make changing it
>> more difficult.
>>
> 
> What is 'it'? I'm guessing you don't want the freelist array put in
> the net_iov_area at all then? Because even that change will make
> replacing the freelist array hard to swap? Or are you objecting to
> just letting the netmem functions do the locking
I meant this consolidation / patch. Yes, it adds more friction
but I don't see much benefit. And I can guess why Stan didn't
include locking, zcrx takes it for additional sync and keeps
one lock for all areas.

-- 
Pavel Begunkov

