Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B343B48C
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802412; cv=none; b=q1744WVfXF2lJCmnyy3KNjcjYEMmuLSbcnCzF3p599+stlTRED4ZvyXTlMCvvU1e8Q5DSC/PdYAUzuNc/Yj5gx6sB1cw8osJMsOTJD+c5KZkN77vQi6E1fUnP9REf7/ljMWs9YWcLx6c1bv2rjcWAaMZ7IqZG7/hk/WLhS94y98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802412; c=relaxed/simple;
	bh=gR+hILfs9JaVILip6p2fY59TZJegMJ+6aegMjs81qKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhEIEyqwc6ZttX+YwCAbl5MHfMyumm5qtg5l1ee7IImrzWPzqmxCXNefIcH/lVmEDJMG//dvLCV5k4wHAEi5QFluPh9M1FcVU9kZodKOSWMfcU6EqQn5QdhttPpm81/oirzPqxMhUQcQdG7mrYYbrYAGteKso5AG4j2S49w4E/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjGR1Ho9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjGR1Ho9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc73e322dbso5290705ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784802410; x=1785407210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=01n37iktC7STPimw6Zf4vYgQpw8EUgozHpcb0fjUKyc=;
        b=pjGR1Ho9e4rCjb/iaSox5Jmy9puVU2Q1AXzQpqzdZVWtHD3JmE/Jh83VdRmg7KGyze
         jItSFvNnt6vG75hmYG9qbI7wB5O2xvrhtyBo88ak1Wp8it+9sXdv7vbVhor2a40dMjot
         ZrwXlKhI5+8ACM8/MPTT7FwDEazxblw+kcGb1gVQ+Tv3HC9yBMWGPGse5e1DqWGegyk0
         ry+qCPMRymh/AGudqm6zTr/1++LElN2LGKQsWRccTBxUJ51bs/x9OiAEwnK46KgSE0wx
         WfFhysVvbNAwhMD9md23/J8uVxVzoy27wH3r27sa11ew1u8kq4AijkGJy7phlBy9lpsB
         C8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784802410; x=1785407210;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=01n37iktC7STPimw6Zf4vYgQpw8EUgozHpcb0fjUKyc=;
        b=OuHlN07lJs8kt291dj2fCtVgkECYCztOcBnfxotLFQta+CVhn1dn68+tldfzvbqKQd
         uuZV59RLB78Acxbh/iP8vCkdgETvoYmaYfRJzujf5imKPXDW32mAdAydiDIXVK8y9Zld
         NxOmej/V9VP4mBVAVGkEwY2/wg6zh/MHAvW99rw4ODApJrMxe056Mr+Csz9PzQJv0iwK
         mkGd67+DbjmN801KIFDdamQTftYhmn+p6o1zfTAnYIG2erZ9C/vngvTqjKzsV8llaJks
         8gj3wMxIwtrYy5psa1rcGg+8XI1kRl/3HGHAl9RTh8VsZqbOuw24/zvwNxvXSh7+4xpU
         l2qg==
X-Forwarded-Encrypted: i=1; AHgh+RqP41JraRY06XuTMEvvU5Skg/oejQDzizLAIZlNnuu5fJYeErkBEq12HfvcUxu/NTFtZhiqdGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUZ3BKE3iQJJ1fkR+2K30GyX9MvYIBamR5sD8rEHhcsjGEwMp2
	LNHH1i3qbQ2Otdmmnbh7/tDaP0IOn8GiZbQB/Mh+2gxiSsclDdtbfpQo
X-Gm-Gg: AR+sD13DLsdLYnllBpI59vrZeXET3V6S36/OF3M90ke9gpbCkqk+n2ulvUQlwf+cXSS
	NhaDX5/hOUzw5ZULq5/L9sGsvjA5S88tvnwaXQcIrMsZQQTg7E2Hbh0oDtX98+fHQaXxEyb0NMH
	yKj6ZImdMt+Xra1DVgo5b+ObzDjiMlRj8KJGuKNVUxdz3KISFabbjFecljz7M5tdPxsp+kI5y41
	bSyZ2ywD4Vfa2/z9lyfY/bzftNzGCztLKFMBhsH0CSvu0MYpvDCjLP/YpuTaFes4YG6kb2vRHpE
	eNVeGeUSMO6ARoioh8hHJxU/K2J/lmwAwmaDFHgLV0RsCm5SlcFbUstdxBxSS+GTkkTJiASuE0D
	dI6eQaBCIs3GP4YS/u8zlwgS9ZW8VipryGDRQvGLrGDuj9uuyDfEHIfNb9iBfEJeT5OmdIs+2Fh
	4DTAYlmwFjyqzT2SRs
X-Received: by 2002:a17:902:f68b:b0:2cf:32bc:971e with SMTP id d9443c01a7336-2cfa6c66618mr27394975ad.29.1784802409495;
        Thu, 23 Jul 2026 03:26:49 -0700 (PDT)
Received: from [10.22.76.22] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5effsm31822045ad.47.2026.07.23.03.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 03:26:48 -0700 (PDT)
Message-ID: <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
Date: Thu, 23 Jul 2026 18:26:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Content-Language: en-GB
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <amHN9mOGj7oMak4-@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/7/26 16:24, Stefano Garzarella wrote:
> On Thu, Jul 23, 2026 at 08:00:31AM +0200, Michal Luczaj wrote:
>> On 7/23/26 06:14, Nguyen Dinh Phi [SG] wrote:
>>> On 22/7/26 15:55, Stefano Garzarella wrote:
>>>> On Tue, Jul 21, 2026 at 01:34:03AM +0800, Phi Nguyen wrote:
>>>>> On 7/20/2026 4:17 PM, Stefano Garzarella wrote:
>>>>>> On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>>>>>>> After vsock_connect() exits the wait loop due to sk->sk_err being
>>>>>>> set, the error was read but not cleared. This left sk->sk_err set
>>>>>>> for subsequent operations.
>>>>>>
>>>>>> So, is this a fix? If yes, we should put a Fixes tag.
>>>>>>
>>>>>> Also, can you describe how to trigger the issue?
>>>>>>
>>>>>> Because I see this in vsock_connect(), so I thought it was in some
>>>>>> way already handled:
>>>>>>
>>>>>>         /* sk_err might have been set as a result of an earlier
>>>>>>          * (failed) connect attempt.
>>>>>>          */
>>>>>>         sk->sk_err = 0;
>>>>>>
>>>>> This only handles the case where the function following the failed
>>>>> connect is another connect() call.
>>>>
>>>> So, can we remove that with this patch, or better to leave as defensive
>>>> action?
>>>>
>>>
>>> I prefer to keep it here as defensive action
>>
>> Is changing how vsock_poll() behaves intended?
> 

I think connect() already delivered the error directly to the
caller when it returned -- there's no reason for poll() to keep
reporting that same, already-handled error afterward.

> Good point, but IIUC __inet_stream_connect() is also using consuming the 
> error with sock_error().
> 
>>
>> I.e. if sk_err should be kept after a failed connect(), what about
>> `sk->sk_err = 0;` in vsock_listen() instead?
> 
> Yeah, maybe this is a bit less invasive.
> 

yes, __inet_stream_connect() does it, and actually, other protocols like 
Bluetooth, TIPC, x25... are also consume sk_err with sock_error() after 
their wait loop.

I think it is an established pattern, so I'd rather keep sock_error() in 
vsock_connect() than move it to vsock_listen(). vsock_listen() would 
only protect the listen() path; I see other places in af_vsock.c use 
this sk_err.

>>
>>>> ...
>>>> Yeah, we need to handle that part better, I think it's a leftover when
>>>> we generalized AF_VSOCK to support more transport than vmci.
>>
>> Speaking of leftovers, I have trouble understanding where does vsock set
>> sk_err on listener sockets anyway. If it doesn't, why vsock_accept() 
>> checks
>> for it?
> 
> I can't also see where it can be set TBH. Should we remove it ?

I couldn't find it for listener side too.

Thanks,
Phi.

