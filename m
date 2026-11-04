Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785537;
	b=gD6Bsdo+SqYxZIo1QqI4mnj6poTi9tfAhi24P0khOh2vMFFJ93RS43PxyINIOYO4+EnM
	 i/UPKpabPeFnoQZWNw7gArI/dgw7QDNvPS/heXy2WY9xhMo2UUQgjS6WIO7jtDB9qzJjs
	 fKCbQox+LK8NhpPm4UjV/u3UCfn4W/Xma377EbMSjN9cs2eCbT1eg329y96svnHQihrYc
	 z5Jg8lcK+bFE6FYT8NrpbwqRdKxBuSPRUa6aBDirkaXD7TpySMUGvpNvWLC18xEOtEQhX
	 O/To7qvJmcgmsJ6gifjPzqK4+NyTttBZfIXrh1xFYJQVTgp3ond2CMzHYcMyA1JGjug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785537;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=HMxqBcMF4zdhVRHXKyNcJi3rB8IU09vQZk5XKYn24e4=;
	b=0IvUukXP62idmeTTE/ksTXcrlmfRdNzvnlhuOZVEnKRtKimXGM9mofdjmWRaiWMEPaz2
	 oeH54+l14sKGaDq1nHe/YJ3aF7OQixo/ZEfcuXppB8zpJFS0ZBk21lpUkEwbp8gRzwvbp
	 yDmvhc96ohfe6mILSSokfBkcl2h2nAebTs3fZA0M7h4eLMxLKN/eHHwDKfcRx2iEnZT5U
	 Tc67wmyqQW0V9bG/FGbO1YrUmTb7p5TCX7bGuOM+Brr6pIuYe6WXw1Ab5snGdX4Pukx/D
	 jOm2fqdngU/IF1TZ4m48LDIvrF2kgmCG2VnymAPzYIIYJyJBWPHa/uQBx5H82lSjjvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ku1mQqN4;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE30606A328;
	Wed,  4 Nov 2026 09:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EE30606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ku1mQqN4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C94794E413F7;
	Wed,  4 Nov 2026 09:45:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9BEB960770;
	Wed,  4 Nov 2026 09:45:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4DAAA103291AD;
	Wed,  4 Nov 2026 10:45:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793785526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HMxqBcMF4zdhVRHXKyNcJi3rB8IU09vQZk5XKYn24e4=;
	b=Ku1mQqN4T5p2iBleE/Wm7V8KnULx0Cy6O8EjOeUikWMjgeaNnQD6LtIJ1LLq3Iz7t83uGs
	J+Aat9iaSUNuXNXWGIFXZBQdAKZX4KshsUp4/hZ7+TJ7wjUojLfMhSCr44y44mevgQDmOb
	bBKS5UGWTeWiDM31j9EzOkea3BLQWUjKidcJ3BY2qvoyQZQFoME1lEUAEiV/8WHnF9+4Mh
	AMny3ZR1nJ5SGQ8tQqe02JBvDrlCE6ZkU4rDc26Jjn6Wu6gje70yVWx4+r3ogsJQJAb3ml
	pMoZDzxIg7CBCHtc0sXszSHLIcnZNCaEQ9uokHmQ2mBxz+YsR5SqoYjIxtnABw==
Message-ID: <5fba2b22-a7b6-4c9e-96e3-1ea41b984ba8@bootlin.com>
Date: Wed, 4 Nov 2026 10:45:18 +0100
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
Subject: Re: [PATCH net-next 4/4] net: pse-pd: realtek-pse-mcu: avoid global
 disable on teardown
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
 <20261103220312.860629-5-jonas@jonasjelonek.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261103220312.860629-5-jonas@jonasjelonek.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 11/3/26 23:03, Jonas Jelonek wrote:
> The driver installs a global-disable cleanup action when it enables a
> previously disabled MCU. Consequently, driver teardown stops all ports
> only when the MCU was disabled at probe, making the behavior depend on
> the initial firmware state.
> 
> Leave the MCU globally enabled on teardown so an independently powered
> controller can continue autonomous delivery. This also allows persistent
> supply constraints to keep the rail powered without an explicit global
> disable command stopping the ports.

No SoB?

Also this patch is not related to power management. Please send it 
standalone.
IMHO this should de send as a fix because we don't want to have a remove 
behavior change according to the Linux version.
With all this change you can add my Reviewed-by.

> ---
>   drivers/net/pse-pd/realtek-pse-mcu-core.c | 13 -------------
>   1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/net/pse-pd/realtek-pse-mcu-core.c b/drivers/net/pse-pd/realtek-pse-mcu-core.c
> index a90e19fb90e0..ab57c348436c 100644
> --- a/drivers/net/pse-pd/realtek-pse-mcu-core.c
> +++ b/drivers/net/pse-pd/realtek-pse-mcu-core.c
> @@ -894,13 +894,6 @@ static void rtpse_mcu_cleanup_vmain(void *data)
>   	regulator_disable(pse->vmain);
>   }
>   
> -static void rtpse_mcu_global_disable(void *data)
> -{
> -	struct rtpse_mcu_ctrl *pse = data;
> -
> -	rtpse_mcu_set_global_state(pse, false);
> -}
> -
>   int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
>   {
>   	const struct rtpse_mcu_match_data *match;
> @@ -994,12 +987,6 @@ int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
>   		if (ret && ret != -EOPNOTSUPP)
>   			return dev_err_probe(pse->dev, ret,
>   					     "failed to enable PSE system\n");
> -		if (!ret) {
> -			ret = devm_add_action_or_reset(pse->dev,
> -						       rtpse_mcu_global_disable, pse);
> -			if (ret)
> -				return ret;
> -		}
>   	}
>   
>   	/*

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

