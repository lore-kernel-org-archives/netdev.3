Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739E40F72B
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221607; cv=none; b=D3CdZobwyD3ZfDUvr0lD6/+/Spul7IQDOy60i0JDrE1q1u9pJQGBmiaMOGFM6/lW5Nuhn5ixntbrc87ebPR69EL27LbalqpHlOO243tV5LPIjctMheEEBhD4fPHuQKskEPhFHiXlLYLQq+2bm+1yX2Bmg3E/qosNjGbxZZ3VW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221607; c=relaxed/simple;
	bh=bMqcPCyNgfU6qizssxjNwkfBRqE+hJLoReApgCWJepA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJxqkddfPzlVsTFzcyhj4nvrsxgMd9ZCpr2kadctzonhOHJZpAkKYarGH1tUbSUwSPVnNidWjA+VZ0zHbyACv9o9NRZPsAyN2jeMyTJlcmeTdP6KaPZxRDrJYcLBN1zW85TLQR2D4VFqBgEflp0wCxgWEsFyn/zbQrpxeTHuUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UtevU7tw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=natCF/UE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtevU7tw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="natCF/UE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787221598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyw3EZ/t9k/GcnByzESslFgBYkRvy5+O8+sE89RYu/E=;
	b=UtevU7twNagEgZdCtlx3jEuftCjcr2cgq8OtFFjjcWrf3D2G31rHsCAZTKZUC/dgJIy+aP
	raNiE4lUGy6dDFRkrxgQvHbURtpNW3agBF9Q4M43+bha5woPl8kWNVYQu5Jo4ad4TGmmTU
	gniFJbXvRyHgXNC9XhT6MZ64uxaBStI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-wpzJM8oAPlC12PqAf8ZKuA-1; Thu, 20 Aug 2026 06:26:37 -0400
X-MC-Unique: wpzJM8oAPlC12PqAf8ZKuA-1
X-Mimecast-MFC-AGG-ID: wpzJM8oAPlC12PqAf8ZKuA_1787221596
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47faa02f707so658854f8f.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 03:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787221596; x=1787826396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pyw3EZ/t9k/GcnByzESslFgBYkRvy5+O8+sE89RYu/E=;
        b=natCF/UEyQqZth8fiZLEiqWsK+dYoF6mcLbwZFqwCYe6siN1+7LR53ViEXYKqTOHgi
         EVA/AjbpOglw9jJDOpnEVFVyX3CAzqE14guEY2Xvn3viombQNDC/e/frsPkB6C3J4ycg
         mB/KZ7JWM8/lNcnIT/D+6O3xufGCz+LafqUsYFH/vtsUEIVxwGq/1yti+Ios55qBYPM7
         SC9kwytLRZ5XxW1cFKefPwilwoeFfBwQ8QLdt8fCcyIpwa1zXQv6njlOcR/oa9QUvQR/
         f5NlJpKcxDDcDEaqLs1wNX37Yj/dwbC0qjWNbqABetA3qSnc95SbznKNHoauhHQXTswu
         yIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221596; x=1787826396;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pyw3EZ/t9k/GcnByzESslFgBYkRvy5+O8+sE89RYu/E=;
        b=XrPyIhOhi+tTioucYew/4KniwCssYrXKX+A7qmsa4FlgWT1yKKGK2P1wXkosxoUlI3
         6/WPTikdhYzLFGLdNu5IdZauK2mhoIADjeg3YAk3y8C5+2JVDN9iGG5Jl5KbgSvxRRdu
         vJ08EUq82CaD5AFTEkusI1hJREmlPWlb5+pvdF6dShxS5Po06dC4FM9T6+UO/8TwASQ0
         Tgz3In75uB3dOqCONy/+ZeNltKiw0Fq7QxmX2/tlYt33cD5PPBynDvlywTiBEu/CXOd5
         SFqCE/VZdz2XkhE8u4CGmNzdAxijq26skQQrIbur2socP4DambirdbV4CM4epE0l6r6z
         dYxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpu9WAUW1AOHYsFS2Uioj5TZmp4m0obAIuW1K0Jdjju/niW0BtA7ArxoMbutPMC7/sLThs3KnI=@vger.kernel.org
X-Gm-Message-State: AFuF++mxBamPKvUZ1LOuPt2UMgLU+nzFx4E7DAIPjcgi0uN8m12iO05p
	LCAYUH9l+oBB0hK1aCXvW036PIEDYQJdXZOwQQrSEs3E/ezIMYRZf+MFgBuHZ75CtjGfWbLChyr
	LZg6ThdFxnTnjFxYHIXqaypp0TpWaYg4oNZwOVIusOW6FU+/3qGms9EbPyg==
X-Gm-Gg: AR+sD10eK3+qj6oze92PuK4V5iQBZ64aE4x623kt6tOFJWEKYjPKzoYYelTPQNQb2TT
	vyE8j7vN/A5yZVQsJ0w/R6uKLb3DvQVSPDTYhBWhYJi+tOvnyqbwK0T5Gk1XSojrtRFL2+LLb4a
	FGMVPs9g49cHrwmQoHui0/mIQUbwESe+A2wYy2Ep/UenvQ6JnTujtyS/dh+4l8e1rLdvLO8UsY6
	cH9iovROvkSz9XSDgHiPzbogV/f+obtozH9ohtjM4MED2FvogaPpPbNKiM7l7BwFXYMxHrZWWbw
	nMKWmOx67TYqe8l4CfmXUoNgzZ53A7l1kTfPZxKPko/GwbughzQUpXprvH0/dUY/FtSoUNhoG34
	XJLmTo/3J8IekVWEQQYvvartjlRxh3KMOzfAh526YUzUApVZAglSuWn4HbTqTQQSujbFIUhrE+y
	E=
X-Received: by 2002:a05:6000:4a17:b0:47f:ece1:1eca with SMTP id ffacd0b85a97d-482b78100a4mr9785311f8f.1.1787221595830;
        Thu, 20 Aug 2026 03:26:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4a17:b0:47f:ece1:1eca with SMTP id ffacd0b85a97d-482b78100a4mr9785225f8f.1.1787221595308;
        Thu, 20 Aug 2026 03:26:35 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482bab42f8esm4232205f8f.28.2026.08.20.03.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 03:26:34 -0700 (PDT)
Message-ID: <eeb04db2-3c08-4b4d-97a0-02e418ed2537@redhat.com>
Date: Thu, 20 Aug 2026 12:26:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] Netfilter/IPVS fixes for net-next
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 horms@kernel.org, ja@ssi.bg
References: <20260817232957.1281637-1-pablo@netfilter.org>
 <aoTzAYyHk7E-HTE_@strlen.de> <aoYlM3J0SP51Kpoh@chamomile>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <aoYlM3J0SP51Kpoh@chamomile>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/26 11:50 PM, Pablo Neira Ayuso wrote:
> TLDR; I can post new v2 for this PR if needed, the left-over of
> LIST_HEAD(set_update_list) in patch #6 is a bit embarrasing from
> cosmetic standpoint because I will need a oneliner patch to remove it.
> And I can re-target to net.git as Paolo already mentioned.
> 
> Anything else can be addressed by follow ups.
Note that we are waiting for Linus to pull the net-next PR, so we have
to wait a little more to process this one.

WRT report, I think follow-ups are preferable where possible and really
reduce pressure on the ML, but if _you prefer_ a v2 please go ahead.

Thanks,

Paolo

