Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9613AC0FD
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264613; cv=none; b=M7pdPGoqnGboYcxu9CRr3bQrBsZWVyb+Q6hW0MZcus7swxF61SLS8uZ/jOJS+VEdkeGZqQTfZiI8qAdrVVinGWQ/EbU96LnnXkcioxrw2O/c2fbQ4sgLw75E75IhczSMCO5szjLdVBbkzxJ21MZefXzfOYZH4pqZoCCTJruspX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264613; c=relaxed/simple;
	bh=pUAQhpIylhH03veS5v2pJ5187OFtExWloOWxSlrMTWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Riw8njPDiSYzaEigcYyS5KrrnkrdjRbnBZM/DLheowRIX7G+JwNjgprzTeaD24V7QDVy+Xtt69oLS0oNiT3lTckyVeYaq9zEgtah795D4NZjnjo+K41xX0kN9eEKdVrhbZWyqMDX+hilAxRwMFueCeJCFurjYQEjcdkwJ98m71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0WL+qMs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlypWCcK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0WL+qMs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlypWCcK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788264611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fwOGFXieQl813ckc/IUkjGRGe4UDJCJhqZtMy1/kp8=;
	b=L0WL+qMs21h4npjxV39ddsGKirXhBC2Cl/FZGOJIh/G5FNwtWwU95SHLrPTnhGFSJ8HsI5
	besD1hBDa6xLZ3wpkGDuLqMLFferqTRwhMiy5aYqJkNa1o4rVlYTsg3deFRy9asVXwNi+X
	u0DP9Jb7LNrfdvNDT3kv4xhZhkG7ngs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-TJ0WPoW5PiWk94PH_69Qug-1; Tue, 01 Sept 2026 08:10:08 -0400
X-MC-Unique: TJ0WPoW5PiWk94PH_69Qug-1
X-Mimecast-MFC-AGG-ID: TJ0WPoW5PiWk94PH_69Qug_1788264607
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-482f763db88so2573555f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788264607; x=1788869407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fwOGFXieQl813ckc/IUkjGRGe4UDJCJhqZtMy1/kp8=;
        b=MlypWCcKSfGjZY9Eqt5KulJUqs2foa19Ey6tTuqKHzbs+XTIrn6Kff89D6VhhxGpwx
         Pk+QaqxVW2hC/fK5ecRMrEC21EERvDF4Ah8c6IElLrmyTz0lYXuNYIkze1t+xHojUZ1q
         UtgcDDEMTtEmutpZKssgUNSjrDU6dG42m/2PnUaJEMCXDo444Z0+SwccPKAFdp80Lu9G
         +hnraQ4ZPgwgBep6EPjPnoxYv5gg5THpqr6GO1FXat17cBgpfCub+dF4Fj78sfeZvRl3
         BFLNhNO7qPAPnAACXnfrZ6iO79oKZsBHFt3EP1d1XX1btxpP5qVQ9D+a7XmqlzxAmGNI
         OnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264607; x=1788869407;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8fwOGFXieQl813ckc/IUkjGRGe4UDJCJhqZtMy1/kp8=;
        b=CZOLOdaidEdr33gwOi9aRZPdoNz4C+Og/vor2CCAmREol61sXFyuzKfLDiJzMPjkEx
         7jMd7ET9/bAkadtkcGOZLpbTqbkBJKIwf9su5cLCEWUXQhIeyERfq2L/dk3usP+X/zhU
         GBcysP725FXYP0vxRLp2re3uOCTufEckBWDekxHgF3ymIV2JbXtRoiToh1E0c2Hu7YXt
         6Gyln48vMk7eQFucf9/zX7vrmpkDMVDjHfFbaGoPHrCPF6Aamaha7Pxahy51rKWr/NRX
         85fgAD9J6v+qKRL+cMKRNU0vXplOnjxnqaxYbFGD2oVhyfYN6Q4WcVJn79Xa/YeRoGxM
         L1sA==
X-Forwarded-Encrypted: i=1; AKwUvByDbDjokV4DiedLykDwoW2cFEdCEFjaeNk9IvUOZZaTIaJYEnHjhkVCFFVqgd0a0KDAQcM8/bY=@vger.kernel.org
X-Gm-Message-State: AFuF++kqYJl5efPnL67DJt5jDh7ZQcwIot322vkUBxx7vh8YYGiirxGp
	tudwzDBjfmf2KfGPTqN9gsSYN42js4exytTE9/L3V9psFBPJ+NPciE4a6gkBfNFdjSdmHNV9xaW
	pYKlu18xyVZBkTEBBVCd99codHQy7w6WvtcuDgIhMFicO8rPeA2j83QFZZKbsnyK99g==
X-Gm-Gg: AYBFou2XRHCuZGf+pzofvdF52KFHCLK8h2hz+p7/N11hmUlpq4EkBY/m60m604WAoOu
	VmUjTGgW16CfdDXrw3AGA9InrxgxmensV7mJcltkIsb32jLU2MXsmtW1Z1vA3mJ9Ce3Yjgp5iJw
	TQDowfwrvx/wGOuqOtdbG30fsX+DH9Z2IzJkC4vXYsH0fX1TLG13T8oWrnbqb1aHpukUYeMcCAq
	bZ/syNIqASbu9+Vsex9AwQIr6imjCbwHXxOAcgMLbSWOtIFyHtV1N+hbU1RMp5D9pRIUK+oiJg1
	hhyYGm1hyFp2NK6zuS63MWMV1OU3ln+GHhbkv9qWHsqMldlJ3ekdevaYueOUI3wuyBs1pEv582J
	cB0pyDDgp0AhhVbFU6BUaEJ73UI6XCQD+pFZBo0x1vDpXa/fK/NCe1MqQoiSHakFAkkokcM0fUg
	==
X-Received: by 2002:a05:6000:1ac5:b0:484:3785:210e with SMTP id ffacd0b85a97d-4844103cd55mr13006994f8f.25.1788264607266;
        Tue, 01 Sep 2026 05:10:07 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac5:b0:484:3785:210e with SMTP id ffacd0b85a97d-4844103cd55mr13006886f8f.25.1788264606789;
        Tue, 01 Sep 2026 05:10:06 -0700 (PDT)
Received: from [192.168.188.218] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d36e9csm4881021f8f.3.2026.09.01.05.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 05:10:05 -0700 (PDT)
Message-ID: <b8b6db7b-353d-4d6a-b0b6-3b5e1be22008@redhat.com>
Date: Tue, 1 Sep 2026 14:10:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] bnxt_en: Bound SW TPA IDs to prevent crashes
To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
 colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
 raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260828190900.1767611-1-joe@dama.to>
 <1c87458d-7d76-4da4-9981-51756cef391b@redhat.com>
 <apa9qofhuatqGTra@devvm20253.cco0.facebook.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <apa9qofhuatqGTra@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/26 1:57 PM, Joe Damato wrote:
> On Tue, Sep 01, 2026 at 10:16:54AM +0200, Paolo Abeni wrote:
>> On 8/28/26 9:08 PM, Joe Damato wrote:
>>>   - Moved bp->max_tpa_roundup_size init out of the early return path and
>>>     documented that TPA is unsupported there, as suggested by Michael.
>>
>> Clashiko quite convincingly elaborates that the above is not enough:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
>>
>> Could you please have a look?
[...]
> 3.) "The new assignment sits after the max_tpa_v2 == 0 early return, so on a P5+
> device whose firmware reports max_aggs_supported == 0, does
> bp->max_tpa_roundup_size stay 0 while BNXT_FLAG_TPA is set? ..."
> 
> Michael commented in the v3 that this is a false positive, hence why I changed
> the code from what it was in the v3 to this.

This is the comment I referred to.

AFAICS the problem is that the driver sets

	bp->dev->hw_features |= NETIF_F_LRO;

regardless of the supported capabilities, and that seams to disagree
with Michael.

/P

