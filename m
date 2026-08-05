Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1C3E2771
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914220; cv=none; b=R4kj/ePu80v88F5UPPXRkho1tcE6++rETcnwX41QidkgrWV0lktN+P5djgnsDdYKbrOhTEDx9RneehgbMcdNXEW7N+zJ8cykNmlnJvSH2Xu18JXFx9s7qaMu5QpY4jIwuFGxNWFxnV+6fERM7K7Grb0Ecf6BxuGfcCmhma9cwQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914220; c=relaxed/simple;
	bh=ydq3KJ6HFbUbua+r3QVqS+DAwqBI5uB2yIXhaz7/6mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHMOVctrmySfLuaoKTULHY+69FKw+9KIxRuBa280i5TRe2AxQJvfZuXNfKqyDtYoUudhAr5DpHzDx3T+5CJg3cbes/Ah7mu5P92wiA584KP3oVEi97+vO8Ffs9nQ3erEK0DYIqbU8V/DtcT77yfKEY2szE8NFm78atvovHjqQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEKITBJG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uCrJ7bxs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEKITBJG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uCrJ7bxs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785914217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjE2D6TGMd7S5ADEufvcotWtYmjivTdanKouDhycSjA=;
	b=UEKITBJGvCTP3f4gg65foyBDbTZuZLorzHjlxYSMZFct7T7Y7/3stU1e6LfkNaen2RVI9x
	I3xY/hgZrs0Co5x+1wfQ1g+jr7ST8XnBikRMPiX1bMmKxeazPRfpsEdYvRHpdHPOIQDb6m
	YE2wtfBcMPRdAkKuBjEEiWBFbvegS98=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-G4BRPrjNP3qcMwF1xhk7LA-1; Wed, 05 Aug 2026 03:16:56 -0400
X-MC-Unique: G4BRPrjNP3qcMwF1xhk7LA-1
X-Mimecast-MFC-AGG-ID: G4BRPrjNP3qcMwF1xhk7LA_1785914215
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496b6f97676so6455805e9.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 00:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785914215; x=1786519015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OjE2D6TGMd7S5ADEufvcotWtYmjivTdanKouDhycSjA=;
        b=uCrJ7bxsQT8ficC9zJOSo3n46BguRD5xY5KA9zsoMAQklHAA9oSLQx3bHZx/8nT1M/
         F+/8yTAtNFBxEakF247RzTtEACuLF75YxhIK8zwUba1oQZd3IjDOhnZiuxRXpaYMiAOp
         9sdGdiA3yxopTLIXUAYM5CxO6HxnvMudo9ZEXTCBxhdsHZggWtS83P/uGDb8qSXdnLul
         EpOTchQtAfBLyYoQ/+UEADhpYgd/o5NjjBeR2zXYIREPxld8b1Pb8lEuLN5AfsCyKP13
         IuKIR+ZQQY5hmlSnzBnveX90dX8OXnxRC9A5J1aNmJfp6MZVmEi2KhUM8eVc+gZwNe1R
         9N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914215; x=1786519015;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OjE2D6TGMd7S5ADEufvcotWtYmjivTdanKouDhycSjA=;
        b=qg5aw3N8mdATwmhqKx3bHyrPeEb+0VgC9J6gYLi1Zj1iNDVJYjUJ4cvurW4L6ZEr9g
         J8QUToV9WwKVffRFwAkiM12Tq7Z+FIpSTs9Y6wqjufHqFbkClDyV/eODWQbGDX/VtRGn
         32rDlL+oufpXNp6qTFUV1rRzau5LLGmtHz6cBCXT9ztq+dKkKHd5dPl13s5SmbWZVNq0
         6sHaMHYE1DHut27s5xNSkKA4+DiLFPhN6Rfzwk38wjfjOetPOJ92ZrowY6/Txbb0pb16
         DAMUhf9txuHmT6xJfmQ5o84AnJqGyRJbJQTHejUmKC32pFMD03oiCE87Bi4kHHE9AsFr
         GYIg==
X-Gm-Message-State: AOJu0Yy9aMw5W52D8fPA6f4R5gd4c7sDF/yLBz6Q0nrvZk2KRqepi89G
	W2V+dKZCKPdADnmM9qZD9ixHw5Rvxbzsae5xZ0O2iMOd0LrY9xRVlc7SlIJpCIa7LbIqYERLKvq
	qJMXvKbPcl7dIypjQbQ84oFDNgfniQcv6mBeAM7ysQ5y5P4lhO48P05Nx8MV6pdWFEQ==
X-Gm-Gg: AR+sD10D/UDBII0Q0fLzc8ojdtuz6v8afoDVeWIFSUmhH4/gLtRj0xr3/yYd4cRafAL
	778PeGIPvkFWBTYQ5IDONCV54tR2wfMoDB/sjclGDDalugcB4YnMOyfuICrqEZ+Jl6j/IebW4zD
	3m7PhYi8mmE8Y2gMjnYFd4jMOI/s7t87pL+AcwFwVkZ2hJDEULcm7sTaQnBDz1KQjyO8G7Bq339
	FOwmA665gCtnb+DU+mrQQ5BgLMYwjqQRMmVVBEJ8bPHHLEZlgMQeAUs6mG+l2Wgfqp3JnaHzX5C
	eQKj5d2GDu+seF3GiZosfcdPvGiExj7hrFtPzx97NNkSb4HMFXmCfCafLJ5dZ2ijHLSZ9hXyC6o
	wNlfRxyEYgx7+rsYGkaX4aQ2IBjyn+FHaRdnO1mnzME9IO/xTOXm8PigzOBlSjVGBc2S+8Yp31d
	U=
X-Received: by 2002:a05:600d:6446:10b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-4994e7c5d9amr40428415e9.13.1785914215118;
        Wed, 05 Aug 2026 00:16:55 -0700 (PDT)
X-Received: by 2002:a05:600d:6446:10b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-4994e7c5d9amr40427975e9.13.1785914214661;
        Wed, 05 Aug 2026 00:16:54 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe6b26sm6739470f8f.16.2026.08.05.00.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 00:16:53 -0700 (PDT)
Message-ID: <706584f1-6b68-46d6-9a32-999100ee6447@redhat.com>
Date: Wed, 5 Aug 2026 09:16:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next] net: dsa: b53: srab: propagate errors from
 init helpers
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260729202953.704662-1-rosenp@gmail.com>
 <845bb9f6-73e9-4301-a5ee-94e7f7aacd88@redhat.com>
 <CAKxU2N_hCnbJRRtP5bqVVRavORZVk-1UbKMEZ6s-FhjkDEbMUA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAKxU2N_hCnbJRRtP5bqVVRavORZVk-1UbKMEZ6s-FhjkDEbMUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/4/26 10:55 PM, Rosen Penev wrote:
> On Tue, Aug 4, 2026 at 4:00 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 7/29/26 10:29 PM, Rosen Penev wrote:
>>> -static void b53_srab_mux_init(struct platform_device *pdev)
>>> +static int b53_srab_mux_init(struct platform_device *pdev)
>>>  {
>>>       struct b53_device *dev = platform_get_drvdata(pdev);
>>>       struct b53_srab_priv *priv = dev->priv;
>>>       struct b53_srab_port_priv *p;
>>> +     void __iomem *mux_config;
>>>       unsigned int port;
>>>       u32 reg, off = 0;
>>>       int ret;
>>>
>>> -     if (dev->pdata && dev->pdata->chip_id != BCM58XX_DEVICE_ID)
>>> -             return;
>>> +     if (!dev->pdata || dev->pdata->chip_id != BCM58XX_DEVICE_ID)
>>> +             return 0;
>>>
>>> -     priv->mux_config = devm_platform_ioremap_resource(pdev, 1);
>>> -     if (IS_ERR(priv->mux_config))
>>> -             return;
>>> +     mux_config = devm_platform_ioremap_resource(pdev, 1);
>>> +     if (IS_ERR(mux_config))
>>> +             return PTR_ERR(mux_config);
>>
>> Sashiko noted this strict checking may cause regression on previously
>> working setup:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260729202953.704662-1-rosenp%40gmail.com
> It mentions this only applying to out of tree dtbs.
Ah, it was not obvious to me. Restoring the patch in PW. For the future
please see net-next commit bd5c24e4001d.

/P

