Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493F45D5D1
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849429; cv=none; b=ObJ9T6T+GigAKFzQzgqSyBxqlzwZ+sWCItZQcoz0WeMnvQ90zDp0jHlRySodZnEGqzqFuIB0kXFE259pcrwzJrF+pinFbQFwLI4pmIN3q8hKyc5IWhNjzh/bK9jjU20AoIKsUySoJWat3r29Ag1ONccATkrr2FrPdA0OZPgqcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849429; c=relaxed/simple;
	bh=h7uY72MFN3ZCqO+ejtJMF2ouulPOzx4A4RyVX1xWRRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBSFnrVN93SpGBZVYSKDh8NW8F3fWNJoemrbZjy1wLAC4mj4b9ViB2XpYduV/YBBRANniQHwQbVKu6thCQppMFKWh3fFcXKgL3C9E4BcdEAfLcCmiL2mxUnXmZbps16JA4p3sP5OH3dA7f5is7baQk6zptes84L1AeaFGaOzHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xq8cMZYN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoDWjOW6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq8cMZYN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoDWjOW6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785849421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgKDAwfYkCsBa1/O9slq+N/Od4IInZ7YxbXYIKaLNVI=;
	b=Xq8cMZYNwiPsjvbOKV4/B6WH8Pb7nfhCpyx4cc2bzf1z85kQb3JWvs4jVzXVegJfpn7B1W
	s3F1L3UoalxBIAyBoV4bY2PkuV4of0LSb27sL+gpOq7/D82K6Us5fIUEkbYr5y2oM495h7
	BixE60R7/GooZbXa2qTpv83QCCQ8rwI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-q4XahpWhOLOfbHgQes8F3Q-1; Tue, 04 Aug 2026 09:16:57 -0400
X-MC-Unique: q4XahpWhOLOfbHgQes8F3Q-1
X-Mimecast-MFC-AGG-ID: q4XahpWhOLOfbHgQes8F3Q_1785849416
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15fc5a1b7eso315519566b.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785849416; x=1786454216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kgKDAwfYkCsBa1/O9slq+N/Od4IInZ7YxbXYIKaLNVI=;
        b=AoDWjOW6iMGh0jz4uFV1E9kiE1Pj3BA8whB/efCin2LWW2maVthNRIEVqYa64qYyAN
         rXGREcIarbw6ena6wmZNfHpqKFUSNuJux6/qYHSEPXwacAoSy1TQ1MWPZZXghuGxeSXU
         yts/FeuFepzbre5ecGxSWFb27ZF4wCv10+eocTWfp/rNWu1EJDyV4AESRQO4lB+O75wT
         4z58v9iFu2ZHv2/BMXtmpx46Mb5+E/EflSr9Y2ItQbFimO8WPXXOfKFFXJZB4Zv3RgCi
         N0YXoAMWYxJtVt47QdsSnTIzgX2SoDagu4gjw8wplEEgjqFnejxYbf06T6iaQlSMH1DM
         Vs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785849416; x=1786454216;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kgKDAwfYkCsBa1/O9slq+N/Od4IInZ7YxbXYIKaLNVI=;
        b=A4mvxOeyrr1CdiUzMrsnjUYTl2Pf0XYstBrkIGCl/LMrZbWM5ylK6LwCxJp+UYYH4o
         GsMz7dlSe2KzUv3FCk4uv/PV4+XKPn+7kgUWMmoK54x/iBKvqPWKTpbn9WVv7V5DIr3b
         YbbckKWRamEzUltDfO7fi8Ny2kJE63GT2bqCVadbV3rlbuJ12lykcLlhlI1yZ58NpgpE
         sdN/Vd8OzDPEsJ8Y7vvD84Kn+u2YFqU37Ae9Px0FUd5vHgFgQ49aXOjxvDuYm8mTGXUE
         EOj491+2pBoKQN6kH+3mUPPb/ph5e72WFsvhcPq0ap/y5DzEQNqDgUir6sqUtIGHolRn
         GM9g==
X-Gm-Message-State: AOJu0YxyZEPugUfPtQREIlRD5Y0E5xEhQ3TRe6jMABQxhUcdX01dUQ/F
	k2us2cGqGd74qvKw4+eaGbp8YBrAq8931IJTvQIv416ZAsPJvWgQdQt1usdCtYSAsee7IRbLai6
	wkOUWOtY7/ryj8jSeNQ3fOFMZjjWTOFs2Kq7aOU1mw9RaTWWvE8EgplfvEA==
X-Gm-Gg: AR+sD13/KaQXq4qRa3aa+agZpgInzi7sysXHqGcObiC3QzIeP667rau135rKx+pakYc
	YBLvmSyQDBDO/cTXPc7+dYSomH7Mir8aRM/iU6wvHnWmV87+qM5xLHPwVadvDSBpNdq/yT4f8GI
	F+IMYn5j+On2gAq33dYRPFfZ9oVgUOStKqeKAsAvUWtPmUgnEIqJJBEBcplXpKL57gcA6RlvQs7
	+hm41yGs/TTIus4ES7hs43fMNJEtqejEcWTo3JsLz4G3o9nxRHYLI6k0mGcVCmScvyWKNoON6ZQ
	7UJv+zFJAfUAJV6XS2QjM0nOcA4xRWoMADR3unLpAi88m04rch96Jzi3aUSLZ81imwTsG5VTOgz
	88ARIbz7VeBrxJTZTOEhPzEsaRIw3oxX9LS+m2ij1FAnol1E8VIJ84hp5pU/n61rP0Dl4OGhBfM
	w=
X-Received: by 2002:a17:906:34c3:b0:c16:209f:d48e with SMTP id a640c23a62f3a-c1fe8250ff3mr1087594066b.30.1785849416432;
        Tue, 04 Aug 2026 06:16:56 -0700 (PDT)
X-Received: by 2002:a17:906:34c3:b0:c16:209f:d48e with SMTP id a640c23a62f3a-c1fe8250ff3mr1087589966b.30.1785849415843;
        Tue, 04 Aug 2026 06:16:55 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20361312eesm12924466b.4.2026.08.04.06.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 06:16:55 -0700 (PDT)
Message-ID: <991957eb-65d1-4b3b-b903-76459127c124@redhat.com>
Date: Tue, 4 Aug 2026 15:16:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
To: Sven Eckelmann <sven@narfation.org>,
 Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
 <20260803191920.0e6c5a2c@kernel.org> <3386526.aV6nBDHxoP@sven-l14>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <3386526.aV6nBDHxoP@sven-l14>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 8:55 AM, Sven Eckelmann wrote:
> On Tuesday, 4 August 2026 04:19:20 CEST Jakub Kicinski wrote:
>> On Tue, 28 Jul 2026 15:39:03 +0200 Simon Wunderlich wrote:
>>> here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.
>>
>> Can you look thru the Sashiko comments here (especially Medium+
>> severity)?
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728133918.643267-11-sw@simonwunderlich.de
> 
> https://patchwork.open-mesh.org/bundle/ecsv/pu-main/
> 
> We were just waiting for a verdict. I am guessing it it a "no, will not 
> merge", correct?

Please be aware of net-next commit c82ff94592fb: the expectation is that
submitters reply proactively to AI review comments.

Specifically it would be helpful an evaluation of how critical is
problem reported and if it could safely addressed with a follow-up.

>> At a glance patch 14 does not inspire confidence. I guess patch 15
>> removes the worst part - but is there a real reason not to use locking?
> 
> In its current state, you would need spinlocks over larger (op-count) portions 
> of code in the hot-path. 

I'm not sure if the following is well known/helps, but performance wise
slightly lager critical regions are usually preferable to a larger
number of atomic operations,

/P

