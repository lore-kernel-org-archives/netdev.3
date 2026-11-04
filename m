Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795814;
	b=kdF8+nCegbGPZwIO4AVz1Yh30mD0uHyexTEUnP9HvrVa+zUBql8YWr7UnZ5VGo4LFI+e
	 lweHd0erqhjaniqWKjKw1cIWRs2849he05DMCdg+kAmGZplxSvnKgsCXVAS/HzGzZQdky
	 7Xv/1kDzr8DbwRyoOUDFkzIRcJydqWdiDjqH9g1LPbkFvNzYLwAmYlmWTR3MzY3eGg6vI
	 F2DAzoFpzz7pOUp5t02Q+nLw0Jtt3Af/jhnpcJFADP7lWRyoJWOMIiq4knwdwVBkWQvJM
	 qcRSflfBaojtbOJ4bP7lkpsUB2FGin+WGQ2t9dk1Ame98pxXHATdHyrS5fetWbGOq8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795814;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=m2q5zprOd1HlfNJGZr5kfMMxRfdDFLnmMobPdffdDHQ=;
	b=17UFa2vKieP2m48KdpdkqklmNQONzamAkhVEQQAFQSA/lTyikekU+p82nx9wzk926Nf0
	 61yhzRFjnHXi2BN2yKVzCBA0ofPhPOwBoFkh3FsQWSy53Xs7WUZxaWspNnrXhb08WkvXm
	 NlwmzqRe13MexMH33W61K9gV1MEenPHTzI4/baNgJfuLaQq2wDgSNgMMBKqSuSskHhr3M
	 ZUCfdpawxhMKVO5AFt6mjuEcLMyH+DT2qc7J2nTfiA4ifWi4mqtFEE/4rm+PajLId7Fel
	 xQ0md1V2ElTcbNBwxlx3Y0Nyt65bHCgbOlAldajTZLcbkg8Jn22JTO4VY7W2+t2foAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QN5FGuoG;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDE606A326;
	Wed,  4 Nov 2026 12:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63CDE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QN5FGuoG
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 72C69C8F46F;
	Wed,  4 Nov 2026 12:37:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70EFD60770;
	Wed,  4 Nov 2026 12:36:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D33CF103291D1;
	Wed,  4 Nov 2026 13:36:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793795804; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=m2q5zprOd1HlfNJGZr5kfMMxRfdDFLnmMobPdffdDHQ=;
	b=QN5FGuoGBU8EK/D8Ta5MqTqxt7iivT2JbjzmWJP8NCrtXBFPM3wQbQERdll8Nyh8be5YkZ
	iD2b3TErWXdJPkY0+ZS2iqlzVkDQmaCV3SYJ+OuQ7SAnzU83fwrFJE6gb9wHW6a94fvC+0
	ECqAxa5m5BFVKlw+BIpq4tydMCC5tlNJBAeoiRJ4kZ8FTKIEQKd8vTGbdZlkncjq0BK0Kl
	skxzauoqpAoJhzmKTyqI9Da51N8aK/Z2TmmWET7bsdHPRURIvkM7mNLdPMVyIElsKtviuC
	MP8U1QSlNjCZT6q1BBV75gPx9D0fgREUvSy/xuwnOWyr4K/a8h402dCF+xnVUw==
Message-ID: <357f6311-7f00-42c3-8eec-e0fd0c35749e@bootlin.com>
Date: Wed, 4 Nov 2026 13:36:36 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net-next 3/4] net: pse-pd: realtek-pse-mcu: configure
 global power budget
To: Jonas Jelonek <jonas@jonasjelonek.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Sander Vanheule <sander@svanheule.net>,
 Russell Senior <russell@personaltelco.net>
References: <20261103220312.860629-1-jonas@jonasjelonek.de>
 <20261103220312.860629-4-jonas@jonasjelonek.de>
 <5e00fd7f-40f9-4041-8dfa-fff222b57b92@bootlin.com>
 <e0910567-999c-4c96-9b20-2e34434bec3d@jonasjelonek.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <e0910567-999c-4c96-9b20-2e34434bec3d@jonasjelonek.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 11/4/26 13:20, Jonas Jelonek wrote:
> Hi Kory,
> 
> On 04.11.26 12:32, Kory Maincent wrote:
>>
>>
>> On 11/3/26 23:03, Jonas Jelonek wrote:
>>> Use the optional VMAIN regulator power budget to configure the MCU's
>>> aggregate PoE power limit during probe. Quantize the available budget to
>>> the protocol's 100 mW units and reserve exactly that amount through the
>>> regulator core.
>>>
>>> The regulator budget represents the usable PoE allowance. Program zero
>>> reserved power so the previous firmware guard band does not further reduce
>>> that allowance.
>>>
>>> Require a finite budget of at least one protocol unit when vmain-supply is
>>> provided. Program the budget before selecting dynamic power management and
>>> ungating the ports, so enforcement starts with the regulator-derived limit.
>>>
>>> Enable VMAIN before hardware initialization and register one managed cleanup
>>> action to free any reserved budget and release the enable reference on probe
>>> failure and driver removal. Record each successful reservation immediately
>>> so subsequent initialization failures are covered by this action.
>>>
>>> Read the current budget index before programming the MCU. Retain the
>>> programmed MCU limit on probe failure and driver removal, as reducing that
>>> limit to zero would interrupt ongoing power delivery.
>>>
>>> Boards without vmain-supply retain their existing firmware-managed
>>> budget.
>>>
>>> Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
>>> ---
>>
>> ...
>>
>>>    +static void rtpse_mcu_cleanup_vmain(void *data)
>>> +{
>>> +    struct rtpse_mcu_ctrl *pse = data;
>>> +
>>> +    if (pse->requested_budget_mW)
>>> +        regulator_free_power_budget(pse->vmain, pse->requested_budget_mW);
>>> +    regulator_disable(pse->vmain);
>>> +}
>>
>> Following patch 4 logic, you might not want to disable the PSE controller power supply,
> 
> I added it because of the requirement that regulator_enable() calls must be
> balanced with regulator_disable() calls. Accepting that this may power off the
> rail in theory, something outside of the driver would need to keep the supply
> enabled. Concretely, I'm thinking of "regulator-always-on". And all boards
> I've seen so far which can use this driver do not provide a provide to really
> power off the PoE rail. Sure this is no finite guarantee.
> 
> What is the correct way? I see either droping the enable call too, just relying on
> that it is correctly handled outside of this driver, or I keep enable + disable and
> the continued delivery is ensured with "regulator-always-on".

Indeed if you use "regulator-always-on" it does not turn off the power 
supply when we call regulator_disable().
https://elixir.bootlin.com/linux/v7.3/source/drivers/regulator/core.c#L3269

Does the PSE controller needs this supply to start, or is it only 
required to power the PSE PIs?

If it is the first you will need to enable it in the driver.
If it's the latter, you could describe it as the PI's regulator parent 
supply. An enable of any PI will enable this vmain regulator.

>> this will lead to a power off of all your PIs.
> 
> Is this enforced by PSE-PD or just based on the rail really being turned off?

If you call regulator_disable() on the main PSE power supply it will 
turn off the power rail which will turn off you PIs.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

