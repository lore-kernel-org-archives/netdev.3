Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791965;
	b=Mk0E+asRvxk9rx/u+trwu0+Ef+7SC7yJAcI4MSEgq/lRNG0O6Zb7ag8dPQrGFQvbSNWb
	 oc+AAkClYiFzyP5xUQeqJh8ZBtDSZ1AFYnRBcBgiVogcHT/l0+e6KHsaRfGFY/b89UZ4+
	 dgaxAjUXTxrj242sKwJlBz7Dw85LwBHkIt4i1d+MPZH8v2cSWKnsci16u9FKU3XYhhHWM
	 r7oyRc/BLFW2Uh0iGZvZpr7t8nTbRbMN7KOmWI8k1k2rFgscWeuckG37J6rLsfN7TiDAu
	 n85gCcpRZp3Lwri2zPx3xnwQyVWGDKLTax/oJBkZQhJMh7XzgqDbJ3bQdekoh98BiNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791965;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=nSAdp7d2w4x8lFKtRcJRBiPEu1Q6p424n1DTy1d1p1c=;
	b=05jwpE3SXWf9LR/fcdInnMC2U/tzbF5beYe3GMK1N535CWl9c/mhqXqnW3npSI4aMN1z
	 i/0JAgdh8P+SPsOjEoY+y93XpNLAcMbOugXetmcXnCgkksCSJSYa5fbDKewDOmJCc7aHD
	 pSL80uREAI9OjLi+UxvgFNHo2rsFcBXkOpYya+lyth7kl1ZEbu08FIjHphlVeNhb3uswI
	 ntsJhs0gl8JLxvn6hjVtvQwZvzC4mTE1q9d2H1NHdOqwnVg/OhHgQu/oLMnokMQ1YB/s/
	 BWfDURKJB55dQ5rlvN98wIjEcdQ+ca83VjDHNXUCSo4FkkXeEA5PnUOlcE0Tz/jDglg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MvHjrEne;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26189606A31B;
	Wed,  4 Nov 2026 11:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26189606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MvHjrEne
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6AEDA4E413FB;
	Wed,  4 Nov 2026 11:32:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 35DFE60770;
	Wed,  4 Nov 2026 11:32:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1DD210329171;
	Wed,  4 Nov 2026 12:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793791961; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nSAdp7d2w4x8lFKtRcJRBiPEu1Q6p424n1DTy1d1p1c=;
	b=MvHjrEneFWYCZlFWinNnQWxc2Ej/64pyntWK44iPlXCjj6rUOBf1i/rrTeCrUf9vIy9kB+
	gK7TMl0m2lYTCKMseG9zh4e3+De0Mo0m7eRyZ9zB2an3rcmntu6mZuiAIvAVLZIZuaaZR9
	OvHVrMcrONF5rZozO2M5hxT/L0SCnOMf9TnOfYy3uXvEQmPQAVD838DYJiL7uImpaUALvq
	gQ8f7OWL1NoHXASD9I89dyQPYM1N4qlD9j1o4hZbpfiOe69MGDJ9RgYuPE9AIS9plpEmfR
	mHoB5pFxaujF4YWP7ZsKG+uR/S4HPqSGWrD1fTzVnA/X8kGxi2nnStBa0oOzEg==
Message-ID: <5e00fd7f-40f9-4041-8dfa-fff222b57b92@bootlin.com>
Date: Wed, 4 Nov 2026 12:32:34 +0100
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
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261103220312.860629-4-jonas@jonasjelonek.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 11/3/26 23:03, Jonas Jelonek wrote:
> Use the optional VMAIN regulator power budget to configure the MCU's
> aggregate PoE power limit during probe. Quantize the available budget to
> the protocol's 100 mW units and reserve exactly that amount through the
> regulator core.
> 
> The regulator budget represents the usable PoE allowance. Program zero
> reserved power so the previous firmware guard band does not further reduce
> that allowance.
> 
> Require a finite budget of at least one protocol unit when vmain-supply is
> provided. Program the budget before selecting dynamic power management and
> ungating the ports, so enforcement starts with the regulator-derived limit.
> 
> Enable VMAIN before hardware initialization and register one managed cleanup
> action to free any reserved budget and release the enable reference on probe
> failure and driver removal. Record each successful reservation immediately
> so subsequent initialization failures are covered by this action.
> 
> Read the current budget index before programming the MCU. Retain the
> programmed MCU limit on probe failure and driver removal, as reducing that
> limit to zero would interrupt ongoing power delivery.
> 
> Boards without vmain-supply retain their existing firmware-managed
> budget.
> 
> Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
> ---

...

>   
> +static void rtpse_mcu_cleanup_vmain(void *data)
> +{
> +	struct rtpse_mcu_ctrl *pse = data;
> +
> +	if (pse->requested_budget_mW)
> +		regulator_free_power_budget(pse->vmain, pse->requested_budget_mW);
> +	regulator_disable(pse->vmain);
> +}

Following patch 4 logic, you might not want to disable the PSE 
controller power supply, this will lead to a power off of all your PIs.
I think you should still free the power budget, to not allocate it twice 
if the module is loaded again.

Else is ok to me.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

