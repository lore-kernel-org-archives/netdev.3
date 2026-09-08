Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F33C279D
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858909; cv=none; b=rlTvdy3OnnjVYOHxDEicR0ZMWz64Wtd8cNePj/H6fvAxSDh8vPsKlrmKiSu+7ITcigiVy3OV8w1GwIxhCPG+HeUVmhs84u3MqmeOK1MbenBcOynuNvOeoMbQMn9Z2GUWN7m70RkosyczvK+VNGp1cdvsptifEx2GPYI6xvy5RU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858909; c=relaxed/simple;
	bh=t/xxnUmrNfICBiCkOoksIKEwk12retoGdTtWu0AOSdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1cJAWDRZ34D6K7fLq0EWnVHO7cR7UAdmdTaXDp5xtUIp4dI8PCOyAj4QxA3mhyfWbfESemacw5KKFQmkK8R0F/ZC4KZVi0dmMv1ahBwoR5QJF3RBHmP+zIS7k/O8lBXba6l0G20kYltJ7cMojkY7Kcq3Wgx3PH8HzHAmUZIVTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpQsnGtP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebGZO4g1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpQsnGtP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebGZO4g1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788858907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nNgGtNecSlAmjqV28TTW1q4l/anKAb2D0PenLdi3DMs=;
	b=KpQsnGtPViUyGeyhkqIapbQ2tLzheSfOl8/Q2y3pVyHIVRnLmN8KjAi/7bIKRalVnzepRA
	CzlZt4jzdPA1LLyHIFu3CRDuTgUFSSOj1bgtcxG51Lw/F7BcBkLthPdA4agHqiXi/UIetD
	5lHomgSVQ0olgTQhz+66GdpBYeaT+Rk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-uKp3-_2bPcub1iFvCUsYeQ-1; Tue, 08 Sep 2026 05:15:05 -0400
X-MC-Unique: uKp3-_2bPcub1iFvCUsYeQ-1
X-Mimecast-MFC-AGG-ID: uKp3-_2bPcub1iFvCUsYeQ_1788858904
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4843e59c32dso2828668f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788858904; x=1789463704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nNgGtNecSlAmjqV28TTW1q4l/anKAb2D0PenLdi3DMs=;
        b=ebGZO4g1ChA6oglwIE44xl2P4JpwETtFkLxAyDYLU3o7OyAmB5gGxEGHWYR/zfOaHj
         HuGIzuLwK87kMtMcm7+8I1iFLPzuxV1JcL4Jx2lctaUTRTqYv9DCbUGAxJ29XRRqJBkF
         iR/Zwd+DIlBk/my7bmhbCpZLk7RZfLQML4atJQX5gEvPMVeCuz36fq7MyIfmGCljHhnt
         17TpX1M7L/239PQsWTI15nY4S1bpiGXX6ERr4lf6rMu8lIjmzBquazemqp6RXr5WBR4c
         HTuF1Et1yCLDk/5326OaY9tXHLeVJcr0YEJ6PlHImRbL6nRHhlYXV89rAFjUB1IrYGHk
         92iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858904; x=1789463704;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nNgGtNecSlAmjqV28TTW1q4l/anKAb2D0PenLdi3DMs=;
        b=O5O0KFiPT6IBocI3wJ+SXiVptgsGD4MliJvOjy0lUsoyvv4ZKKpALbdYFtBsjBnNkO
         YeE6cOG/yEU86Eh6UifuH139EWrhfSJCFmkGsXcbYkBuiHwOObMq+fZNCAbBoey5C+Ka
         73na7DRI4hl4MKFmHx947DNphzR8SD9++svLoS4WTLfhxXTeqgydJh8mGuM4urJ05WwX
         2bcQu/wvaqCstH6K8XgVTU3aC2wB5M+SSXcuXqIAoR37IZD8ow1jnueTIysbFya8TkP1
         Am7Ev/l34/TqakAy0f2nVR40amQxoAdPmlz7ZquN9SPy1hBX6KYiizQN+UWOtv2uWITd
         BT+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwSvZ6SRMALW2w6zbIIk1YF+81BUnDnujKs2QDid+HWQUcUwqNHEFPkS/ufkXJV16bWLpbac1g=@vger.kernel.org
X-Gm-Message-State: AFuF++lprneLpAdi55i1KRm1XVOHDR8+sJi++h3h5cg+S0V9klSr7IMD
	J/Wwr+XBCOSXlpMF0hKzFdPd2CzjTX9hdaLWGsFRLwTz4a6HWraVoIm8fEv8kN11p2p7GDhZAN9
	uCYLp0NeMvhDPk+VC64WuZWgKGcZWkL2qMzBvilRLhBhiN+lpoz0O4igKsKEJlA8ESg==
X-Gm-Gg: AYBFou0FmFuEvyI+RWzL8fMK63JwZgXGYD3nbmKOPujrI3R4eWPJKmv7UfeI31lECxM
	fMhbXNL3gK2FcW3gMNX8UwGRknh9w5IeNmMPQW9nZzrs10ym2fq6whf274KWdmokaSRgLoX5QKP
	wRCkfjmb732IoV9cl9c1sDy31KyLYlCh9EgU5tgQ1dUSEdjwtxgb7Cx9o/UBhSM0NURtoChfavx
	xK6n9JiAh5LMmaHrEjpBQ+9cWZCMBnLA4Duy/npVq/udOSSUh3qIuwBoEm2htwLFnv49IMeMklt
	/OFH45q+NhjukQ8cOTzgw/HOoRNreuYiCAZqucSqmlnshUyW6xSD0ppLNAPk0lm6+R3VNBzPdTw
	yjMpoiZ21SoVqhS9VLD9YNxNWDbi07UayCBmU6jV+72oKG6KOUZAamxFe6NdUy2Lv7yg2ykpd5Q
	==
X-Received: by 2002:a05:600c:6298:b0:49d:17d4:d6ad with SMTP id 5b1f17b1804b1-49d17d4d6e7mr44236085e9.23.1788858904236;
        Tue, 08 Sep 2026 02:15:04 -0700 (PDT)
X-Received: by 2002:a05:600c:6298:b0:49d:17d4:d6ad with SMTP id 5b1f17b1804b1-49d17d4d6e7mr44235535e9.23.1788858903823;
        Tue, 08 Sep 2026 02:15:03 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f815bsm279283445e9.4.2026.09.08.02.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:15:01 -0700 (PDT)
Message-ID: <349fef66-0513-435c-815a-23f2b2df829e@redhat.com>
Date: Tue, 8 Sep 2026 11:15:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: marvell: mvmdio: Handle errors from
 optional IRQ lookup
To: phucduc.bui@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 u.kleine-koenig@baylibre.com,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260903074638.345952-1-phucduc.bui@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260903074638.345952-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 9:46 AM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no optional IRQ is available. Other errors should be propagated so
> that the caller can handle them appropriately.
> 
> The existing code propagates -EPROBE_DEFER, but ignores other negative
> errors. Propagate negative errors other than -ENXIO.
> 
> Found by manual code inspection.
> 
> Fixes: e1f550dc44a4 ("net: mvmdio: avoid error message for optional IRQ")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
> 
> Changes in v2:
>  - Add a Fixes tag.
>  - Add net-next to the --subject-prefix.
It's one or the other: no fixes tag for net-next patches.

This does not look like stable material, stripping the fixes tag.

/P

