Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FEC3F4851
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421268; cv=none; b=EG0p3WLxM+JpO4WJAR1S7z3knpWyTsLOy8P5azNSCz4IUyvgHbe9aCbT+j9lYufT/CGLviUr6YB5olfmI57hSTXNwFuveGjeGM65cVXpGsqDv9qDQyZQhRaZ1C6GLj1Irmhfx+f8LE1XmdpQT8hC/rt6Uh/waw11DW1lUSfq6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421268; c=relaxed/simple;
	bh=nzf/22I5se0CdXJZXVAIlEU8iLeXURz65UJyG9gt3PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhHlhpXpUyF7BnhM7WmZ/ko9hYR3P+IA6izijdtlwDI/zdLgof1jAYSO6feAUCh1ASzUv/J4QmhQDnI6qo8Ox7NKwPzFPrvZBmmwxTOVjOvAAaPQOSbc3eyfTeaAYVanjavDCUBXEqhlFrs56V4sPgH3OmNdgTjrLRLj3Elw+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B/FVoT+E; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B/FVoT+E"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2018F4E40CC8;
	Tue,  7 Jul 2026 10:47:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CEAFA601A3;
	Tue,  7 Jul 2026 10:47:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6D1811BC00ED;
	Tue,  7 Jul 2026 12:47:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783421260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=T7msZIwIUl4a7w3MTqGtUjGwFmBk9ZptIRA6rZoMqzo=;
	b=B/FVoT+ENzSnCuu1jyki4sT8rXw23ZPcUAlOguSL1qYnrc3xVYiKdpwcoiwZRzi4wTNxck
	P135EHd/XNhuXViK8m+v1gdxGdmAekQqw8Aq82Pe98OfMaoqssmg6TxOj/w0PO6j2g4Ja/
	Ym2mECXPPTFR+bdllRxm2KPb2Vz8xPjnXa2QZZvulI29jbP91Ghzj5a7bXtQE7QPTwnKTK
	lOIV5C3ruUYrUcFzHFP30zFB9Unq7mger1w/68jsPyQ+wgAPVMOzIFaq9s+6gEFfQd6Wbf
	8w8DliozZajo9ba0TM8VzuG1q46NXCO5DdCQuWJEfv0ENcFdc/iakKnvxndvcQ==
Message-ID: <7f47104f-8333-4c10-aab6-90552daabefe@bootlin.com>
Date: Tue, 7 Jul 2026 12:47:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 09/10] net: ethtool: Introduce ethtool
 command to list ports
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>
References: <20260701110427.143945-1-maxime.chevallier@bootlin.com>
 <20260701110427.143945-10-maxime.chevallier@bootlin.com>
 <aaef7304-573a-419e-b631-30b300373a08@redhat.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aaef7304-573a-419e-b631-30b300373a08@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Paolo,

On 7/7/26 12:12, Paolo Abeni wrote:
> 
> Both sashikos instances points to multiple races with dumps. I suspect
> some explicit locking is required.
> 
> https://sashiko.dev/#/patchset/20260701110427.143945-1-maxime.chevallier%40bootlin.com
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260701110427.143945-1-maxime.chevallier%40bootlin.com
> 
> I *think* this is hopefully the last pending issue.

True indeed, the other issues are sashiko saying "what if we detach a PHY and attach it
to another netdev", which can't happen :) I agree with some of the locking points that
were found, I'll address that likely as a separate cleanup.

Thanks :)

Maxime 

> 
> /P
> 

