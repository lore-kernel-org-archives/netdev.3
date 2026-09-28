Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1E440622
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577010; cv=none; b=aIcA91JBfFdkAm+AQr+l5+cv9wGFf+xdwWzxdIhUH2xblXyTnm8dZrcAsb3M0f04uh8omG0jFKaSlvLFO6JJpBNfUtBJFmUixVYN8fnIqjv1voEShuaJWjipzmSfvunvv4bcN+5VBY09fYB/+53yXnEDap+rgwLPxfpoe+lAy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577010; c=relaxed/simple;
	bh=dlUj2mszs3h2MdMDvwrP3nn2wWoTBOCZT4SWz4ZSVQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoyIYMEoAFhbyNzcXHB30tNTu8WI0otbrxtkpzsJOmeX3PKyOs3ZJC6wqh01pC/x2ex+ZHwOlFOvdUfNR10+inz/gwVm6WaEWT1TS1/t5PkmUp6sryEmbI421nvTYqyytWIegx23d/HcbHgd3DNjVYEXOm1lhYg65zTWcZiJ15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EVdWJG8o; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EVdWJG8o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D078BC5CD4A;
	Mon, 28 Sep 2026 06:30:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9DDB9601BD;
	Mon, 28 Sep 2026 06:30:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70353102F1E74;
	Mon, 28 Sep 2026 08:29:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790577002; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=bLHFqrB2AUJXMa7TnwIkEJ0k4wehW0BbG+sRDBDW7nY=;
	b=EVdWJG8o7hk3j/Yid2903h3z+AipNuWaQQNXL98A4MLA674wHUX/rMlrgx0i4NnsqCbnC4
	Zsj8Y2fZ9xO0NmdGj+uJ0b9F/vNsTdHmwf+dxDFQhbgetY1Et9emWisnZ53aZ150hGwFJ5
	eNwkY1xiCvMkAnzqwZ7Ejale/jtfLf4CPP33Y5MzNS0qajv4/GIiy/0Wmaax/1A55PQ4TO
	GH8ZdwVbP1nmF+TAMt0N3DKAqMudq2QdeariHERn+X+vQGI3KBrfmAuJwiHKFWhtE8kuil
	AvS04UfRIh123GkMrNKlQRIvQAaXzoIeiHW4SwiuSmq5PaS5cuCTLOJeogvaUQ==
Message-ID: <db817925-eb0c-4fe4-8ab2-2cd5cde505d1@bootlin.com>
Date: Mon, 28 Sep 2026 08:29:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 0/7] net: stmmac: More selftest-related fixes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de,
 David Laight <david.laight.linux@gmail.com>
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
 <20260921152202.64d4c67a@kernel.org>
 <f8fc89b7-15ff-4915-8f1c-49c3b2357699@bootlin.com>
 <20260925122202.611d655a@kernel.org>
 <d704ea9d-6cca-4f2f-b18b-0267a9082e18@bootlin.com>
 <20260925132204.03ce9495@kernel.org> <20260927152001.2e890f9b@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260927152001.2e890f9b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 9/28/26 00:20, Jakub Kicinski wrote:

> Added the per-MAINTAINERs entry filters under the funnel icon
> (Note that you also have to enable the filter as a while with 
> the checkbox at the top, or middle-click on the funnel to toggle)

Thanks Jakub, this is helpful :)

Maxime
