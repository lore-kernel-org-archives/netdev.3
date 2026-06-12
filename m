Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5AE3988E1
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249544; cv=none; b=BTCEciypcCbahjT77Qyh7VK+WwnyCMBN6SYVEYvM4/6QMTB2Rup87noKaZCZ40PYh3+za+gs9vDdLc5ghbaaPXTW3udz7LZsy/YOdBucpNZa64L/SdVIkuFap6k5iWUZJtkuuCxmiJ6Qu/tYpmvAzA74PD4Qox8KEx7GMFlti7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249544; c=relaxed/simple;
	bh=NgUl5ze2R6cPjkdpjBbEIo3CVyrDmBAbwEjtiZgBzbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myY5K0yeKTaGj6j6Glb6Kq4sI495vebWv+5k9qqTpyGmKKvRf5V/Q1ByMbmTEeUBBFy41URSWwzSXPffBQlTGovKk+7X/RSrW5C42REENO+LxYOREs6qFOe9W/WUj2cy1ukzKqc0WCKrP92gIxptSqhWKI8axIbI0imlz0uA1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXYnaism; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXYnaism"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490c1915793so4981675e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249541; x=1781854341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCTuB+MXgEq/TOOfGAZOksakwpYDc+Ri1GI0aJ9Y6Rk=;
        b=gXYnaism6TZcHnHX3Ad8e/CF2BTEtJ1cCqFF6kHL8VrAiZzI///lZmS4lPFB5+R3Mt
         yEmrQj6rERCLrrF7TE7Wx5vmNLob5I9FJWYeyt5lXNW9i/4Ln9+riS2XverMoM+yLk1e
         oCg4O/nJlYTGrGJ/iBTNpsP50cG96fNELWehypudlgBlTvvH5246cwvQ7NqqF7vLFdNG
         h6Zq85jnIX5Ciua9ljEWfFqbrhOGQe/y/FvHseirO/k/rrpnhshvoIc4w7WaempyFM6M
         6yTDyUFR2zhyBjREZJzQsTjOdiSm5HkfwwhoMqP2BQCKA66K67Zs/4QgNRCCDAHpmDba
         EULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249541; x=1781854341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCTuB+MXgEq/TOOfGAZOksakwpYDc+Ri1GI0aJ9Y6Rk=;
        b=Ip4Vc4uPnUyxtjZ6WqBk8InNN25JtxErQVVCBuam2rfEhJPUharqRK7yiFPCBQvXc3
         6AzBvcyY2wPE3+sQ82eevZ1z4GsUOFvkTbPMDgg54vHOCxOa6k+myODdPjMYyg/Bk3jO
         UO/wxQcg1YEkFWJdAaHgpXJ/Jfp2ATV8IEG5/1wM6VQFrFYNXZGO2ep38tUVWDJbwIzG
         gWVYc0gFd++C0cXA72YFme7aU+pI5MddSz7mzVowNNvmcx17TJHdTtCQm6Th6H60+xVt
         IckT1g+2iZpU9XBS9RIlW0sa7/7D76JhcC4vNWsBzzL7mYQE9Q1MzwgfSZgf/WYdOGWl
         244Q==
X-Forwarded-Encrypted: i=1; AFNElJ/3eKs5MgLokODkjPTM+fs9SU8oQ0ZMHQ+Gq1V5z9PN6W1E1oO/jIYC2Umlqucw+sDLLGdEIYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhB7MJq7puZaqdoWS3Lx4Gao3uL+f19pPadd9AEtqtUBJubhc
	h80DfxxeSKxIRyLLzw00j5t8k1dv2Yn06IYJgB7lkplPm7Y3o6ETZ5aE
X-Gm-Gg: Acq92OHqsLl0waDQ5BQN5epPcpqMe3ozIRhDYLEpVdQIrSZrVGHN41/UqtiHshv79kW
	vaZSix2MpXyIXpJvhTkemK593X4SeSi8vdnhmeydslbNWeCcvhXd4e6zeLHTuuBqRcziAHaY6mv
	V+RUPoSgnfoyN3vrPISUlyv6MrS8LZJT4VPu+146JwBPgPxjsk31dwaCXLFbzXnE4jLiyyQZyn6
	viu+oMEGhxv4Wy9r/QVXHvQbc3fYYnZ2rpuEdrvRbjs1arMTxN0wGprETTc1pIFWfV8PyNjg82d
	ny3zb3Jzv0o+V4GZ1z5liamVhqDLLSl8D0XNzx/WoyTGlXhz33+3UX75ncmD1mQh76pvzPnjm62
	oUE97Ph4sc6hNS9lMyaHw//mBeNOqH60uBgR5NOOH6oa1u0r69bo7LPXCNWwbw/m0sOHUxFuKmt
	b8pEPx0jB5yuuuTD4EZCiTNRYkL99HVYLSAw/AslxuoezWEko+mtFToelIjRhR4XGBwa97bv+Uc
	LA8YHyG/17UCt+gI/zP6fM=
X-Received: by 2002:a05:600c:820c:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490ec4c5984mr18981215e9.7.1781249540557;
        Fri, 12 Jun 2026 00:32:20 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f11c:fd01:7c4e:1a8f:d89e:b92? ([2001:9e8:f11c:fd01:7c4e:1a8f:d89e:b92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c51dsm32403035e9.1.2026.06.12.00.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 00:32:20 -0700 (PDT)
Message-ID: <94fc9839-b20e-47de-b530-ebd8eadb25d9@gmail.com>
Date: Fri, 12 Jun 2026 09:32:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net: pse-pd: add Realtek/Broadcom PSE MCU
 support
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>
References: <20260608205758.1830521-1-jelonek.jonas@gmail.com>
 <aiqV_10qQahSHXca@pengutronix.de>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <aiqV_10qQahSHXca@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oleksij,

On 11.06.26 13:03, Oleksij Rempel wrote:
> Hi Jonas,
>
> On Mon, Jun 08, 2026 at 08:57:55PM +0000, Jonas Jelonek wrote:
>> This series adds a PSE-PD driver for the microcontroller (MCU) that fronts
>> the PSE silicon on a range of managed switches, together with its DT
>> binding.
>>
>> Hardware model
>> ==============
>>
>> These boards do not expose the PSE chips to the host directly. A small
>> microcontroller sits on an I2C/SMBus or UART bus and manages one or more PSE
>> chips behind it; the host CPU only ever talks to that MCU, using a fixed
>> 12-byte request/response protocol with a trailing checksum. The PSE silicon
>> never appears on the bus.
>>
>> The same protocol family is used by MCUs fronting Realtek PSE chips
>> (RTL8238B, RTL8239, RTL8239C) and Broadcom PSE chips (BCM59111, BCM59121),
>> diverging in opcode numbering and a few response layouts. The driver
>> abstracts that behind a per-dialect opcode table and parser hooks, selected
>> by the compatible. The specific PSE chip behind the MCU is detected at
>> runtime and only influences per-chip constants (power scaling and the
>> per-port cap).
>>
>> Why the compatible names the protocol, not the chip
>> ===================================================
>>
>> The compatibles are "realtek,pse-mcu-rtk" and "realtek,pse-mcu-bcm". This is
>> a deliberate choice and the part most likely to raise questions, so the
>> reasoning up front.
>>
>> The node names the protocol dialect, not a part:
>>
>>   - The DT node describes the MCU, not a PSE chip: the PSE chips are behind
>>     the MCU and never appear on the bus, so naming the node after one (e.g.
>>     "realtek,rtl8239") would describe hardware that isn't at that address.
>>
>>   - The PSE chips are, in principle, usable without this MCU (host-driven
>>     directly) - different hardware with a different programming model that
>>     would warrant its own binding. Claiming the PSE-chip compatibles here
>>     would collide with that.
>>
>>   - Naming the MCU silicon is equally wrong: these are ordinary
>>     general-purpose microcontrollers (GigaDevice, Nuvoton, ...) that vary
>>     across boards and are not dedicated to this application.
>>
>>   - What is fixed, and all the driver needs at DT-parse time, is the
>>     protocol dialect, so the compatible encodes exactly that. The two
>>     dialects share one protocol family and one binding, kept in a single
>>     "realtek" vendor namespace because this MCU front-end is found almost
>>     exclusively on Realtek-based switches; a "-rtk"/"-bcm" suffix selects
>>     the dialect. This follows the "google,cros-ec-*" pattern: a compatible
>>     for a firmware/protocol interface implemented by varying
>>     microcontrollers.
>>
>> One compatible per dialect spans both transports:
>>
>>   - The 12-byte wire protocol is identical over I2C/SMBus and UART; only the
>>     plumbing differs (SMBus vs native framing on I2C, baud rate on UART),
>>     and the transport is already expressed structurally by the node's parent
>>     bus (i2c@... vs serial@...). A "-i2c"/"-uart" suffix would only
>>     duplicate that, for a protocol that does not change across transports.
>>
>>   - This is the multi-transport model used by e.g. "bosch,bmi160" (one
>>     compatible, separate i2c and spi drivers binding it), rather than the
>>     cros-ec model of per-transport compatibles - cros-ec splits because its
>>     on-wire framing genuinely differs per bus, which is not the case here.
>>
>> The binding documents both points as well.
>>
>> Testing
>> =======
>>
>>  - Linksys LGS328MPCv2  (RTL8238B, I2C)
>>  - Zyxel GS1900-10HP A1 (BCM59121, UART)
>>  - Zyxel GS1900-10HP B1 (RTL8238B, UART)
>>  - Zyxel XMG1915-10EP   (RTL8239C, UART)
>>  - Zyxel XS1930-12HP    (RTL8239, SMBus)
>>
>  
> Thank you for your work!

Thank you!

> Overall, LGTM. Can you please take a look at this report:
> https://sashiko.dev/#/patchset/20260608205758.1830521-1-jelonek.jonas%40gmail.com 
>
> kzalloc_obj - seems to be a false positive. Some other have good points.

Yes, I'll have a look and address those issues in v2 soon.

> Best Regards,
> Oleksij

Best,
Jonas
