Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE01E8826
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539878; cv=none; b=MqNfI0iuLFuro/4wHX9g5CsJdBbl/NG8OzKQxdSrZZorX8ZTmFbFxVZsU7TXeGqc5vQk5gsUS14yV191sgIwQRJmbpiLJZHhwZ7LM7ItkPW7mSm161NUYq8D4z8AvcwyHrgN0t4rFx5qfzWnRxFX69yPFq/0kZrMCPeM6GT0C1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539878; c=relaxed/simple;
	bh=zS192RHwYiA7BAe2k/MWKAMMfvMF8U/nMyIDGFgYk70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRemOuA1bEK9mUuAv3YrdiZZenDTZ8guR2+lhIt4qoEc2ZLXlIUAvJQ6T+r0UwyVKc1bHa/LtE1bSTUfLC5vM2SwLNRn44RjOiKjM3xbhec7ZOo0u7kYZQfw1tkr/mX+PhriyKBGXIHvpL9r7ysOaMaORPHZvZ/IVD0Sfttb83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so2568795e9.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539875; x=1789144675;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q0aQSdKzOF0PPgy6y9xp4TSkRi235Alw+wnMM1Rh6xs=;
        b=jssqgt55b3/PqD9IydA/Lbg8kgKgCsahFrch1EbFXTilxgtm83HAYxBCBXnMpFk6oz
         2jGW9HhK1x4RK3JOHfPnZM/MFguHGteh1hIBQBD54XRB551z33tjDHgZN/iESzJXIR1J
         BhSS11JkoQgjl5b6sWmRVLc65yyAFqbHJBGba2SKXn7w0GqCQOVN2qLEp30vb9RD0fBZ
         ObW7EdLGsDqLYhIOsq8wiBQEW/pZuMjr/bthj8cdXYnMQKIXPiHcHeqUDFULF9zijKzA
         HOczLUDReez/0M3gW9s+2zslXklH4d2rAN+kz7t1hL7QkGHGOZSO1FrP3a64K/NwW6CC
         Ov7w==
X-Gm-Message-State: AFuF++ldjbKQpjlBVPJY/eCcR/aw3N99+vUykaFDuXJR+MTtSZ6ccv6x
	dqBfzx75gng8ikEMnjjxBGJreBl1wQaVuLwcW/X+2YFdJaoBglFOVHPdDaElN7Tz
X-Gm-Gg: AYBFou2u2yBqGQ+qsGu11GVaaX8YCjiTyuKKztQxvjFpJVkWu1EhRTBhAEezTGIL8bV
	oCo9eyRQOJeuPuVO5FufcwxQ3O2gaSZaYhxSqgDGwyeMm42eIcBTzT5wA5QveskTRPygFaSJoQB
	xtyaB7ChhFRUo7nU4+D8Dwm8rkzmeynYTpuYYa6+01HCVIZGb49hbz/ctyiMFShpe4LFzsfP/q9
	bkm5BO2RNZ0F5NQu7IiZMECqDvayn/kXTCfeRVBkI8n/s1nTRr1FBLSQ4zTgfFwRE+IYr7T4UFb
	WhRWS76f7QQWWHuy/IqijUaGdP3lRW/dWlInIu2xBw981piZkIfzBZWtA/uOEK86dMmIp5yuRat
	+YtOwqSi3Je0hidn60BW363CEkv7c7oYifOUpSsZHrA6f+mx9wCSccoIpfqvUcAlVQunswA3HtA
	kZmGJVGEQXOTdnwk0AJ7GSGKKcHjex4pc4tMj0zi/x3nY1fgdMVwttc36wePaVH1DyvzYIcMXRm
	UzbdgWRqmiSew==
X-Received: by 2002:a05:600c:4515:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49cf8273002mr65953065e9.14.1788539874756;
        Fri, 04 Sep 2026 09:37:54 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce554d52esm142440015e9.3.2026.09.04.09.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 09:37:54 -0700 (PDT)
Message-ID: <d5e7fb9b-2fc6-4331-8071-6bdb51e15c6a@ovn.org>
Date: Fri, 4 Sep 2026 18:37:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] Containers to run Netdev CI tests locally
To: Matthieu Baerts <matttbe@kernel.org>, Ilya Maximets <i.maximets@ovn.org>
Cc: Netdev <netdev@vger.kernel.org>
References: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>
 <dc460046-82bc-4c20-870e-716dee54a6cb@ovn.org>
 <e6d815d3-ed9b-4904-8cbe-8e5ee226661b@kernel.org>
 <275ba183-49fd-45b1-881d-0f362b4c74c0@ovn.org>
 <d456834a-3b3b-4c6b-9c36-d71f7faf5d2d@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <d456834a-3b3b-4c6b-9c36-d71f7faf5d2d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 6:17 PM, Matthieu Baerts wrote:
> On 04/09/2026 17:25, Ilya Maximets wrote:
>> On 9/4/26 4:54 PM, Matthieu Baerts wrote:
>>> Hi Ilya,
>>>
>>> Thank you for your reply!
>>>
>>> On 04/09/2026 16:01, Ilya Maximets wrote:
>>>> On 9/3/26 6:19 PM, Matthieu Baerts wrote:
>>>>>
>>>>> A wiki page has been added to cover this and explain how to validate the
>>>>> different tests:
>>>>>
>>>>>   https://github.com/linux-netdev/nipa/wiki/Running-Netdev-CI-tests-locally
>>>>>
>>>>> To help developers, containers are now built, packing all the required
>>>>> dependencies to run these tests in order to run the tests in an
>>>>> environment that would be as close as possible to the CI one. The goal
>>>>> is to have an environment that is easy to maintain -- no heavy
>>>>> optimisations to reduce the images size -- but also easy to use. In
>>>>> short, people (and non-humans) can continue to use the different tools
>>>>> as before, but add a prefix to the different commands to execute them
>>>>> from a container, e.g.
>>>>>
>>>>>   alias run="${nipa}/docker/selftests/run.sh"
>>>>>   run vng --build
>>>>>   run make headers
>>>>>   (...)
>>>> The headers are not used unless the USERCFLAGS="-I$(pwd)/usr/include" is
>>>> passed into the actual make command for the selftests.  So, uAPI changes
>>>> will not be picked up.  Would be good to fix that in the wiki.
>>>
>>> I think setting USERCFLAGS is not supposed to be required for this
>>> purpose: KHDR_INCLUDES is there for that. According to the doc [1], each
>>> target building binaries should have "CFLAGS = $(KHDR_INCLUDES)" in
>>> their Makefile. If KHDR_INCLUDES is not set by the user, then lib.mk
>>> will set it to "-I$(top_srcdir)/usr/include", so the default directory
>>> when "make headers" is used. It needs to be adapted with building in a
>>> different directory.
>>>
>>> At least, when validating all net and drv-net selftests on my side, I
>>> didn't need to specify extra CFLAGS. (I think the netfilter target is
>>> missing KHDR_INCLUDES, I will fix that.)
>>>
>>> Or did you have to do that for a specific target?
>>
>> I was actually having trouble with the netfilter target specifically
>> as I'm working on a patch that changes uAPI and the selftest build
>> can't pick it up without the USERCFLAGS.  But if it's actually a bug
>> in the makefile for that target, then it's better to fix this target,
>> of course, instead of changing the docs. :)
> 
> Indeed, it looks like you picked a target not setting KHDR_INCLUDES :)
> Apparently the net/forwarding one also had the same issue.
> 
> Fixes have been sent. Don't hesitate to validate them ;)
> 
> https://lore.kernel.org/20260904-net-sft-nf-khdr_includes-v1-0-92455af428e9@kernel.org/
Will do.  Thanks!

Best regards, Ilya Maximets.
