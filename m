Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A149A3A0
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401420; cv=none; b=bOfRbIaXmOfDyHnaTUmHxAExKEGxWSfW3ixpB6qeH70TeL0MaCm8g/RzddBjhyteclMeYMz+kz+F3EWsZOks/FZowryQfo541V+wg1Be8K1bkJPOKKTFXbSz119uyqCWBunkaIpVzaJNvpP39gT4iBqJd7UqT+ymgNDDUbauquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401420; c=relaxed/simple;
	bh=uAieFqZzWEE4iir5H94XDVzwP5csEDO6wN3/uC+uEDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEuOIj6gHMOaQcFzpVsxAwhRzT5VDBYXXagQMfnfDY1RSwpsNBqPC8eC84IgFsjhIEMRpB5UBNTxADHulZU8s/DhzY2CVF5qdOhbYEkH1SbSXgyKYnGseQmahq3TBBnWsC+d96SyOI27BNxuoYlLrtW41BxlH0/O6aGMSuhcBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kVakKz93; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kVakKz93"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 10ABE4E41285;
	Mon, 19 Oct 2026 09:16:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D685960582;
	Mon, 19 Oct 2026 09:16:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7151F10328429;
	Mon, 19 Oct 2026 11:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792401415; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=p0C3J2UWXMiY3krnUqz0whueT56JxA8h4FYf7ytSkmo=;
	b=kVakKz93Uj9+nlSaxTOv3iLyjXJ50snK2OiTdJnAduyj08IwTc6fhSFFRNrpGXs1NwRCJe
	SyaaBxab0gGZ+4K9Dw3M/PvZZdn62rPZnBF/SehXkAk3kFulEasWfZfsj9g9kc7d1s21BH
	SH4sJ5aA/iZKmKjV/cAG6y8/TSdSdorYXdY+JP4XIgA0KPnWUpr8IpDQyVAachL92Nbo1G
	bOUcQBfFsJULm+v8pm+syt2BXFySm3Mbojg7FCGI9tzZdmc/fn/7JPpXDuiTtNfRu7BmTg
	ycq2dhFSf1D+08R8rkBVsiiEfhQSBaUGRMTpaADYlz9zmcZ0gONp+ecYojNiaA==
Message-ID: <dad770a7-1c4e-4037-a6f4-89ec499855b4@bootlin.com>
Date: Mon, 19 Oct 2026 11:16:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net-next 0/2] net: pse-pd: Plain I2C transport for Realtek
 Gen1
To: Sander Vanheule <sander@svanheule.net>,
 Jonas Jelonek <jelonek.jonas@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261018161248.376205-1-sander@svanheule.net>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261018161248.376205-1-sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 10/18/26 18:12, Sander Vanheule wrote:
> While for the Gen2 protocol both a plain I2C transport and an SMBus
> transport were provided, Gen1 only got SMBus. The Unifi Switch Lite 16
> PoE uses the Gen1 protocol to manage a single BCM59121, but does to
> using plain I2C.
> 
> These patches simply add a new compatible for the plain I2C transport
> and the associated match data. This is sufficient to let the existing
> code talk to the management MCU.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

> Sander Vanheule (2):
>    dt-bindings: net: pse-pd: realtek,pse: add gen1 I2C transport
>    net: pse-pd: realtek-pse-mcu: add gen1 I2C transport
> 
>   .../bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml         | 7 +++++++
>   drivers/net/pse-pd/realtek-pse-mcu-core.c                 | 8 +++++++-
>   drivers/net/pse-pd/realtek-pse-mcu-i2c.c                  | 1 +
>   drivers/net/pse-pd/realtek-pse-mcu.h                      | 1 +
>   4 files changed, 16 insertions(+), 1 deletion(-)
> 

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

