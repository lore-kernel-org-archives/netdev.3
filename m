Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8282D061C
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058232; cv=none; b=iAmlKSyt42H47ht1mgnsan8AXbShU4yhPwxhlPNxwraF0TdD75WrBkHg8iTAtInfokHvs2EVRdUjIZDpGhwVgHPKsXBWfgqFi1vPJQJqpbEPkiJTsaE5rTHiry/5/CC5cTOlH70cUkk4/rGttDoLKfxk+YUS695OIiRPULRA2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058232; c=relaxed/simple;
	bh=6CtZYMYT4XpUFtb1WYTDbjv8lDt8QsA8X9rTqudbuL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFH1OeL1lepjGn9QC5kr+/H69Wl7y3cz6TFF6XqySgtfjuuY0qiGT7lb3eGgckoskskOTU6dJ0CCuBdGxvYC9EuC5I9TaZMsxN7WYKNkNjZ5J3Zum+7tafhghe/BgJ9n7UfBQ2kZQjA/tzVpGlMlXPcv0DOYulzJ9wQ0YtW1BI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ef4WgYVg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ohv1np9n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ef4WgYVg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ohv1np9n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787058227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+uKpz7vxdNODpZByPKeGLjosat28K4nUQ0xLNtgYDM=;
	b=Ef4WgYVgyci4SYKrVZBFsm1j9XCGimpBHcP9Bz9tmmYOAP6Jadc79dV9fnf5Zg2P8iZBu5
	WkPdhzfVG5+531Ua1HEix/4duWPEDcuErwM5UT+FpnvplQIqEL6ps590pPs0a4qCB/q0X0
	BwvppVA8DV+SSQ7MlU6ZuH2ptQbe01U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-53ZGLSJ_OEiUDrFMaBZuwA-1; Tue, 18 Aug 2026 09:03:46 -0400
X-MC-Unique: 53ZGLSJ_OEiUDrFMaBZuwA-1
X-Mimecast-MFC-AGG-ID: 53ZGLSJ_OEiUDrFMaBZuwA_1787058225
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1f548718d0so196253866b.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787058225; x=1787663025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+uKpz7vxdNODpZByPKeGLjosat28K4nUQ0xLNtgYDM=;
        b=Ohv1np9nDTeiGArPJ/V1CQbOkmziALY26iWRG/3qctOJV3pwMyFHmvoAoAGQ1tfp8a
         MSHIhM7Jii0Fh27t2NH9jV99y40pPNrOAjuKNuGWHBFJXmZK2wmMEMLoXOIvPGaxVKNm
         IFTwlte5M9xOlWAN5k/XVu8cZTvAkGW4Z7LtpBIyivEbyvHkN1UdKsMy/YKItQwVyqWt
         Ff8xBtM9xiMq6j2MedGa8Bd+ppVqbPnuXeb1XzbZ3ub3/OOqBQYxV4OHUlKroZYBmkj4
         9d+g+745h532XPjXKOYowGuN9qo5UTO7WiCqYMZhIuhno1XX+zkYuNB57JBwK1bTZGBN
         CHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058225; x=1787663025;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+uKpz7vxdNODpZByPKeGLjosat28K4nUQ0xLNtgYDM=;
        b=Nd8DOAWbOsS4OmfzxgJn+qNT+kYg5xZsPmmWovCLm7V5s8QkQHVvnGwUuWdMxH9r0P
         ttVfqG4nhFohObGmjgKZons2iE18Z+CouLt+WkVxN/lI2+hS5mw34X5Q5e2vA3LPYDZE
         VVsO/w88k3/nX1Rbo/VsUlc7W6PfkQwG2hUn7hd78+DqXs2nOrVaZtTh4HjG9bitDsXl
         WqzzQqS2bAH3/X3uIpBN8jbNMsIJfvUJyGypPBnVmNK7QmpCMwTJQxmyPSwht/jRRVgW
         2D8iSmg1JbhWNG3nnjNYjXWugswDz/KETJ2F8c0xlsN83ozcSXZVkd4foo0wA4YeOu2L
         eW8Q==
X-Gm-Message-State: AOJu0YxaFa8p80FMNBDjBoPhMbIrB1WNSljR09QA+jC/D7OudHQONSxk
	egcDNGXyaTdlfkPCjLuEK5kdi849x9tnI6iEtc8FqJvmRIvu/012v8rBxYMZsvqAiC7g0M6NP1T
	tiD5ka0CgTGoIsSvmJL2qelCyExyx3vsWaINyx4dSBazXRf82x1/E0XfiHw==
X-Gm-Gg: AR+sD10u0Z/cOTKUAcrbgdfBZ0plRY9+9nvZIatmx2TamVST+WlA/udRecuHhLZf2Of
	BHVUhs2RlLPTNWylL92+xjuTSYYO9FMXC0mVP/ebY1ccsYxwRS+t1mZBI8TD8gdPyR6lBpAt7U9
	ZWix56zHR9JYibX2Nl9ZKlD/319+jBezw6eCPYuVepyWSbeNEORIVceT+nLqV+ZUde7njSR9mVl
	Wqktu/HXQxecNchqJaK80jvFLQ3wQCpTvZ4H1ODDzzCkDrO70TsnGMxIqNY8L4SzWJBPpadhVyL
	LzkIKZ3nwRkbe5ptyvfFJwbVU7iq9akSWDCLJhINO7Ox94Bj67P1McbfbAPFtRnKTMhQUz0rc4K
	D9KWSteweacwmbBXQb9RhcBLrCfg8ng0N4+YsqBEGOUhEEKpa+v9qcsI2LUhnV+5e4ZXeu22433
	s=
X-Received: by 2002:a05:6402:913:b0:6a1:44c8:edc4 with SMTP id 4fb4d7f45d1cf-6a38a95be16mr16679743a12.12.1787058224917;
        Tue, 18 Aug 2026 06:03:44 -0700 (PDT)
X-Received: by 2002:a05:6402:913:b0:6a1:44c8:edc4 with SMTP id 4fb4d7f45d1cf-6a38a95be16mr16679659a12.12.1787058224457;
        Tue, 18 Aug 2026 06:03:44 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8596ce4sm1724287a12.21.2026.08.18.06.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 06:03:43 -0700 (PDT)
Message-ID: <b33be768-5337-4f6d-8c58-2f7ee5e521a8@redhat.com>
Date: Tue, 18 Aug 2026 15:03:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 0/4] net: pse-pd: add Realtek PSE MCU support
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Sander Vanheule <sander@svanheule.net>
References: <20260813222036.873930-1-jelonek.jonas@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260813222036.873930-1-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 12:20 AM, Jonas Jelonek wrote:
> This series adds a PSE-PD driver for the microcontroller (MCU) that
> fronts the PSE silicon on a range of managed switches, together with its
> DT binding.
> 
> Hardware model
> ==============
> 
> These boards do not expose the PSE chips to the host directly. A small
> microcontroller sits on an I2C/SMBus or UART bus and manages one or more
> PSE chips behind it; the host CPU only ever talks to that MCU, using a
> fixed 12-byte request/response protocol with a trailing checksum. The
> PSE silicon never appears on the bus.
> 
> Two generations of the protocol exist, both Realtek's: an older one on
> boards with Broadcom PSE silicon (BCM59111, BCM59121) and a newer one
> used with Realtek's own PSE silicon (RTL8238B, RTL8239, RTL8239C). They
> diverge in opcode numbering and a few response layouts; the driver
> abstracts that behind a per-dialect opcode table and parser hooks,
> selected by the compatible. The specific PSE chip behind the MCU is
> detected at runtime and only influences per-chip constants (power scaling
> and the per-port cap).
> 
> The compatibles
> ===============
> 
> The protocol compatibles name two generations of the Realtek protocol,
> with the I2C framing folded in:
> 
>   realtek,pse-mcu-gen1        gen1, UART
>   realtek,pse-mcu-gen1-smbus  gen1, I2C/SMBus
>   realtek,pse-mcu-gen2        gen2, UART
>   realtek,pse-mcu-gen2-smbus  gen2, I2C/SMBus
>   realtek,pse-mcu-gen2-i2c    gen2, raw I2C
> 
> and each board carries a device-specific compatible that falls back to one
> of these, e.g.
> 
>   compatible = "zyxel,xs1930-12hp-pse", "realtek,pse-mcu-gen2-smbus";
> 
> The naming is the part most likely to raise questions, so the reasoning up
> front (the binding documents it too):
> 
>   - The node describes the MCU together with its Realtek firmware, not a
>     PSE chip and not the microcontroller silicon. The PSE chips sit behind
>     the MCU, never appear on the bus, and are reported by the MCU and
>     detected at runtime; the microcontroller itself is a general-purpose
>     part (GigaDevice, Nuvoton, ...) that varies across boards. What is
>     fixed and Realtek's is the firmware and its host protocol - hence the
>     'realtek' prefix.
> 
>   - gen1 and gen2 are two generations of that protocol, both Realtek's:
>     gen1 on older boards fronting Broadcom PSE silicon, gen2 the altered
>     protocol used once Realtek shipped their own PSE silicon. The
>     generation is fixed per board and is all the driver needs at DT-parse
>     time, so the compatible encodes it.
> 
>   - On I2C the MCU firmware expects one of two framings - SMBus or raw
>     I2C - which is a genuine programming-model difference, so it is part
>     of the compatible ('-smbus' / '-i2c'). A UART attachment carries no
>     framing suffix; the transport is given structurally by the parent
>     'serial' node.
> 
>   - Each board additionally carries a device-specific compatible that
>     falls back to the protocol one. The driver only ever binds on the
>     protocol compatible; the device-specific string keeps the binding
>     specific and reserves a place for a future per-board quirk without
>     having to retrofit device trees already deployed in the field.
> 
> Testing
> =======
> 
>  - Linksys LGS328MPCv2     (RTL8238B, I2C)
>  - Zyxel GS1900-10HP A1    (BCM59121, UART)
>  - Zyxel GS1900-10HP B1    (RTL8238B, UART)
>  - Zyxel GS1920-24HPv2     (BCM59121, SMBus)
>  - Zyxel XMG1915-10EP      (RTL8239C, UART)
>  - Zyxel XS1930-12HP       (RTL8239, SMBus)
> 
Please note the the nipa sashiko instance as a few more low prio comments:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260813222036.873930-1-jelonek.jonas%40gmail.com

I think it's better to apply the series as-is and follow-up on such points.

Thanks,

Paolo

