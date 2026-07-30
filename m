Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0029380FC4
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397569; cv=none; b=Aeq61cEebyTDT1EZ3/2g56ZyHL7O29AAPWsRd6YpMNU6TngauPyNBPS8SCnkNndXQbjtb+8qJDFvO3WwFO5vkxnCamVxnIzqOx9PWOzrCC+h4pojjY8F0mtDntkTPJ2NU+iPRewkQpUZumfCrMTNiynuZa4r1GkfUp3LD1zXQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397569; c=relaxed/simple;
	bh=PfBPNOtpFdbuSDIVqBy0MnRsviWeGKooezDpGmkPdOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcrJyc6sM5eF6BH7SZ/4no7nJISv7UQKz8GCL6uUN6yngnrDfngGttb2+Sw5gkUoKp6xWcOFUgMzcOv/Q+6dSWHXs+TVSgHsY51fNWpASUMpZMhZKhaODYl57mNfaUOQXfH91mpyP0qvFMaCBGH4qycSrguV7c35y/Ybfgcshns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iymaUKGj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJ6pbIxT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iymaUKGj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJ6pbIxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785397566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEu4Whn6/VhWgzbr5zcc31fQM8Ixy+oar4j+cn9O7Gg=;
	b=iymaUKGjCtw4SDRRXt9PuTm7mJ1w1WxeNcS9/caM246+mb8hCC/hVVDxkRrZaOpWQoTE3J
	HfrSyM9Y4kwqoiyZG5xy6Bq0aB4R7dm8woC8kZaLYO3ja3NPJnMJbe+Tk4eiNnE6h6YI9F
	TAUx/l5mqn3uorOMj6D4s//Q0MN+Et0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-_ZOKGJc3OTu4Ik2lumqSAw-1; Thu, 30 Jul 2026 03:46:04 -0400
X-MC-Unique: _ZOKGJc3OTu4Ik2lumqSAw-1
X-Mimecast-MFC-AGG-ID: _ZOKGJc3OTu4Ik2lumqSAw_1785397564
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-472a798fc7cso1332170f8f.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785397563; x=1786002363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wEu4Whn6/VhWgzbr5zcc31fQM8Ixy+oar4j+cn9O7Gg=;
        b=CJ6pbIxTcCcow7X1FK0dDkFAnzF0Wt38SY1Gb/AjBnkhu+yS6r4MkFHXQrMMKQfYFw
         EfE13iAo42CFlIKdLzt2ralZtkq8Sfugo18AfrKZyB4Azbbb5EMl8vXkSBprCxTmii6A
         dXs8Va7rzSUzBTJIxkeRy7/rs2/TIJs7VOOF3Oq+NPNUe9VRgPyi59/Uavzhu6ucNOaV
         0OTIo5Ivc/xJySgktFt0tcZMqjsITncZQIxLtdyfEEHisTJRwV6UfUsS36Mozftn/vvE
         ta0Az8FtBjVQeq4LNnNoBAGHxtARP6fdI53btgSj8X4yTYDK/8WFj14M3TK7ymuGyz0V
         VBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785397563; x=1786002363;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wEu4Whn6/VhWgzbr5zcc31fQM8Ixy+oar4j+cn9O7Gg=;
        b=RCjJhbA5WYS8loZqzFEwLWGZNMZijOYmiWS/kZhFsYHYies3Dtq4cGSeB9kztEnTtq
         wn+THFCGBtAX+1YJlNNXVt6eqsm8usXAkGFOj6vw8B2uIa6vjqZYuh2PW+inI4V07DIC
         WXKiS5rEt0jVQY+InmIvydvZ6+HAwxvnPz/Ao5A0ZkakZeq3bcIzjnD2gC7j5Tq520hS
         DxDr2msR0S8oAWeKRUYrSm0kYsgirR2jVubYePbjxGP8DOREhsjZeJRaWl83lO17T1oP
         32lVfKr4AH12tk2YKgCsE2voxyQ14eXUC4IB9v8JTGHpX1H57u0ez9O6+qphXdosGpfC
         R4qA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8jXvEYIIg/PprlKnOyYufv2cWid8WEZDBa57w/+PYuXXmBfUkLgNlTHGrWtEhlUci3Rl0bNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0o0/6On/tOb1nEmLjSL1hrJGpjYvBqRytafqP5TehVCyurdz
	YIGx8M1acfU/Cz72b2P+5Mg4XLwZG4H5dh/sGLQkfDoP5KNI9Fr2Hls7Trdr+lR8Hn+pkNyGMDb
	w4FBHkYOUXyWcGOKJZy+sfwR/QkxTf2RjnVaenHq8LwxuB2hMUqET60Z5GQ==
X-Gm-Gg: AR+sD11og8WxwnAPtDWV0SUtkqrG7ulCefsNQvL1etDIJdIQa4oGj1emEM6T635Rffd
	Y/VmQln6P69wDksLb8OWWEpzK1Lv9lO9pWNga+Vd7Nt0Bs9fyVQcIR9mA8LrFLJpnUXPA5APWQB
	M95I+DNBC9PKLXWA8E7vKr7+PYzEYXp624237toFs8+vq5o9ruD/81anUVe9R7+M46YkxBWiMn0
	sFMaHHCczLP9J/YD5eUlJP7tSKga2haZHgL8iQxLx5Jt0Ybv9un2Knns2L8q5n/j9V8HUZT27KK
	MWyJSPVdCDsSqUTU5x/EwvXhEs9hK60JVZlydfOvUQxB8L42eKccnF4Zd67JGd1I+/fdto1az1l
	Ubvu/gu/U49OTbwB39fQl0rbwh9CZlpp+pKcE6B8mRz8JFPD5RlCIJnU1IqGWTiwiVbFegDEmE7
	u42Q==
X-Received: by 2002:a05:6000:2302:b0:47f:5a97:2a5d with SMTP id ffacd0b85a97d-47fc822e563mr1779827f8f.11.1785397563526;
        Thu, 30 Jul 2026 00:46:03 -0700 (PDT)
X-Received: by 2002:a05:6000:2302:b0:47f:5a97:2a5d with SMTP id ffacd0b85a97d-47fc822e563mr1779780f8f.11.1785397563114;
        Thu, 30 Jul 2026 00:46:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d6e5bsm4070850f8f.3.2026.07.30.00.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 00:46:02 -0700 (PDT)
Message-ID: <606acc01-e22d-4e69-ad26-a8afff262b98@redhat.com>
Date: Thu, 30 Jul 2026 09:46:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: Add a missing config option
To: Alice Mikityanska <alice@isovalent.com>,
 Matthieu Baerts <matttbe@kernel.org>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260723140241.132120-1-alice.kernel@fastmail.im>
 <47b580de-9d11-46c9-91c5-55eb13c00bc4@kernel.org>
 <CAD0BsJVqmQRz1yNKMMWH1MT+kgVEh=wY=LOTy_ObeTDCsrhHFg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAD0BsJVqmQRz1yNKMMWH1MT+kgVEh=wY=LOTy_ObeTDCsrhHFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 10:44 PM, Alice Mikityanska wrote:
> On Mon, 27 Jul 2026 at 12:09, Matthieu Baerts <matttbe@kernel.org> wrote:
>> On 23/07/2026 16:02, Alice Mikityanska wrote:
>>> From: Alice Mikityanska <alice@isovalent.com>
>>>
>>> Commit 5cb53743e1ff ("selftests: net: Add a test for BIG TCP in UDP
>>> tunnels") used iptables match comment, which was missed from the CI
>>> kernel config. Add the missing config option.
>>
>> It helps, the CI can now run this test!
>>
>> Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
>>
>>
>> But I think another follow-up patch is required, because this test is
>> flaky when using a debug kernel config:
>>
>>
>> https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=big-tcp-tunnels-sh
>>
>> Maybe because wait_local_port_listen() is required after having called
>> netserver?
> 
> The issue is hard to reproduce on my machine, but I could reproduce it
> in ~12 hours of non-stop testing in a loop. It reproduces even with
> wait_local_port_listen, so it must be something else. The log above
> (and my repro attempts) shows that it fails in a non-first test, but
> netserver starts only once, before the first test. If the failure was
> due to netserver not being ready, it would fail in the first test.
> I'll keep investigating.
I *think* this kind of flakes are sort of expected for 'performance'
related tests when running on debug kernel: the environment can be
painful slow, and few failed iterations I saw has csum offload disabled
- even lower expected tput.

AFAICS the target packet number is independent from KSFT_MACHINE_SLOW
and the actual offload setting. Possibly you can tune the target value a
bit WRT the mentioned variables or skip entirely pkts number validation
in the slowest permutation (note that the self-test will still have some
value due to code coverage with sanitizers enabled).

/p

