Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708243;
	b=qzt0Mf/hXOqvYoLVK9lX5CeWSliSRbWP3JDVeogDSdbDNDTQENL19YQAz6lQPEMzFIw8
	 7xSVWuNjZ3C6DTxLGFCuBem7tW/IrBxd+gpClIXLsvvJ9v8Hm4ItIhsm0cLanILmpFIj5
	 vQmEWyhjQeBsN6BNkpouLAa9DSg2ZYJivPWzi/DN96YclT6sjF3EhP7Xu7eyEENSlj4FP
	 42SDVN5JY2Txqz48EW+Z7jFKwqCGkjBs5/LqiBpCIoWPBz2bOE84rtGZG0A0/5OZd8KHX
	 AYS4aOXvud4/vnJMvlvkCX19f45UNbtRKw7Fh3ocT3Gu3wBarX7lJlmjmwbYFLxVAAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708243;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ymJxRce/XjE02+zK1X5IJ9APZi0warqyAJ+7wOyo8UA=;
	b=z8TC9m7GQEmvpBgliDIKPK5B+VTxqBiDQdyZovQbmZKUAkspSMjakjsFvdrzpBt7H7TG
	 ctjDmkgrNC0NtwtPpycp1yw+9l9z6NUKZepsqHp3nOHqOuKo3jpLgrTehFaz5ur8l3BU+
	 9gC7sVT1MA6so2WlOhnntg4oRppQ/ALrU7Bc19oAbSzo6+9/Ug1Nnhg+lcllSrTXVrCXo
	 z63xPyUsTz08D+8Govnd9sy1EZuYXroMGEAKFf8LbfywNlyTyMztMZN2NIHPxJ1zLj0Jj
	 kui+f93yIQFO39Q9XX68K968qK0JOF0hvncpbm4D2at99XgVhGpZOi2cLQKLxmmHWYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="JlYh/ZFh";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EiEo+QWV;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B434606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B434606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JlYh/ZFh;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EiEo+QWV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793708242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymJxRce/XjE02+zK1X5IJ9APZi0warqyAJ+7wOyo8UA=;
	b=JlYh/ZFhLfUn1fUosS+/YWgrRn8S0Nzd+UaoxsVY0kA8TZzkGXJBJj+j3BT4XxGMyNZTsZ
	jhG4z3Dtb8h9vLZ+UZooQTxYiOVqKWegvS3wPR2EkiRXitIAwJ2A89jv31pfHGQHSibwPv
	J2hagljR33MIQEUou3vmYwPs4Ce5SdA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-0QOQGxP8OtaKjjtPhPe5hQ-1; Tue, 03 Nov 2026 07:17:19 -0500
X-MC-Unique: 0QOQGxP8OtaKjjtPhPe5hQ-1
X-Mimecast-MFC-AGG-ID: 0QOQGxP8OtaKjjtPhPe5hQ_1793708239
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e17d30a79so2193031f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793708238; x=1794313038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ymJxRce/XjE02+zK1X5IJ9APZi0warqyAJ+7wOyo8UA=;
        b=EiEo+QWVs+gDDF+IfDX/P1dmR3Gi5yELMaqqp/e2NZGBjqVek73awkvxuDEpvZkIPl
         Cfh3VSkAxaGBZuNGMi1b9NjLxsVWKrzZ3G3EMj/j6RPVcwrsxp3H4v52WhrQK4JVLBl1
         45VOlzpzbVRx5eIT6F4lPOvCqHtaIjT+x12+ZoC4lrfo++brGBb6spNl4wtojNKIHFhl
         504hgHUVl/9Dfb0phWUpwFQEV6euH8viVxb8PorjhVC+1OFwfzkeBp8a2jFUOgppnbBz
         b4yCiX6bhGJMc6LKH552O2MXGrPu45lptKb1p6Z27ASiCRc5tYhzsgxHRlcwTsFOgs+x
         0ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793708238; x=1794313038;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ymJxRce/XjE02+zK1X5IJ9APZi0warqyAJ+7wOyo8UA=;
        b=179V0j0dR6SabBjKI2SwrccykLf8GuolkxiNgRK1dVWCBhyyBRQne3f2NPp3FXY8d0
         6H/u4FCJnAFx00iI9nks03p7X6QUTq0Fwypaspspajqxb51Dv4f9DWkWA2Kx/BpFRXtK
         FjXp64ebUMKpWi8RWlubkCxdS/w53WLsaKVhefLx0Z5PhZ73ePCvCHEHaj11Er1cVmrD
         3wJGluU0lYMZoh4//yA71h2Cecwh1TWI6VwwNV1LzLHju4Mdb5NgnDob85FB3EPQR9sA
         OAURfMcyNhOLncnq4xa6ZonkhYqNr2ULNvonJDLguVKXkmowNBIafkWsyMDimVwaezYE
         33ww==
X-Forwarded-Encrypted: i=1; AKwUvByOlNRHyk89n9/R9d4Psr2hwkLWSMnBkOIufd3OmaudvTKgOxIpWJmbZGfday7aQWkHFW31T7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pfsq1SaPqO/f8cWRvY9DBkz0Z10VY4urc2FmgirbHtF9/e/bE
	DztAdPZVkqazwd6u3PMYMQ4C+asJfOybVIvuofII+CGkulH7sI37+bRIo1SEmx0UR6pEPf9BM2I
	42R820IV5wFfhORytYMw1o6DkyQn2VPIXxQ1dj2Pvm0S/lqhm+egO1swkdw==
X-Gm-Gg: AYBFou3N6vEbtZk2vDe0rKmB9MYdPQ9w99s8GhV2OoEDH3DPcht+hql2OLq3Rn2LOlp
	Ee8zyLQC+JkORP2Gb+H4+IGnox/parJ78rMRFdLZYIslJGCbFTpqOcn4/+eV2FkmqB02bmgOS1y
	QPyD3hGpsPrmYcpnDc4fzJyebr6C9gRs3bs3CKh10VTyM6cwShkOL/m1pmhVtqn6MFAeqL3aw3a
	VGzRusYV/DxPFIvkuu8twWsM0Mxh85/91kQUjSvjWTZLqoeCPY5pwqLhAPHnJN6jvEsb3BIqBzl
	bgF8WDOou5CXfddtpX4X9RlARz/a/tKplje04J3qj1CPFTsKGD4DcaRTnkrTwSQx8iKmook6g4S
	hmgNOHsFK95ptBV9DuFmy7uwVXpaXEeSikngG3TF9aFdPxKcmMkr7l5+Ii67onGitkFgmqik2d9
	VrXkQAmM2cpp1CA1ulYL2LI+hyYl8RtvljprfDHrHc/Uo=
X-Received: by 2002:adf:e003:0:20b0:48d:f14a:917d with SMTP id ffacd0b85a97d-48e6e2f293dmr21844614f8f.16.1793708238647;
        Tue, 03 Nov 2026 04:17:18 -0800 (PST)
X-Received: by 2002:adf:e003:0:20b0:48d:f14a:917d with SMTP id ffacd0b85a97d-48e6e2f293dmr21844563f8f.16.1793708238193;
        Tue, 03 Nov 2026 04:17:18 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d4f9sm25135025f8f.2.2026.11.03.04.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:17:17 -0800 (PST)
Message-ID: <7ea0851e-91ab-456e-8349-5470cc75d188@redhat.com>
Date: Tue, 3 Nov 2026 13:17:15 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] xfrm: include mark in MIGRATE_STATE SA collision
 check
To: Steffen Klassert <steffen.klassert@secunet.com>,
 netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org, Antony Antony <antony.antony@secunet.com>
References: <20261102100451.2505200-12-steffen.klassert@secunet.com>
 <179369310574.488856.7247083630566929798@kernel.org>
 <aunB5Kc0Naqn4lx8@gauss4>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aunB5Kc0Naqn4lx8@gauss4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/26 12:13, Steffen Klassert wrote:
> On Tue, Nov 03, 2026 at 08:05:05AM +0000, netdev-bot+sashiko@kernel.org wrote:
>> Before this patch, mark-only migrations used xfrm_state_insert(), which
>> can't fail. They now reach this path too. The same lockless pre-check
>> followed by a destructive install already existed for daddr and family
>> changes.
> 
> This looks valid. But as this issue is not new (daddr and family changes
> have it already), I think we should fix that all together with a
> followup. Antony?

FTR I agree a later follow-up is the way forward.

> Btw. none of these issues were flaged by sashiko on the original
> patchset submittion.

Nipa sashiko instance uses several different frontier models, cross-correlating
the results. According to our experience the final results are consistently
more accurate (both less false-positive and less false-negative) WRT the global
sashiko instance.

Hopefully with time even the global sashiko instance will move to the same
approach.

/P

