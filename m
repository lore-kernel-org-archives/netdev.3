Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23552403123;
	Mon,  7 Sep 2026 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766640; cv=none; b=DLRZt799u23ehjpvsEt5wYO2kc0fpvw68G6S+V9nyhC59po6a6Y0AX+bPcdFU/F5Huumkqs2f55J5nGlWpFWS6rfPEihd0DaTLhnOSqewzz21CxXdTPlDuwWSd1Ou4Duyx0xqS7We48EP7IXXD4WEPsfRpwApYnJs0xHrbkPdMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766640; c=relaxed/simple;
	bh=J2AYW6Dm9yYcgO50fIaAJqVyjDqxzWLcsCiWdo4nB4M=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QYeLn3zE9uUYFbTw5JGj1zAj0Xl137zo/Zm+HGgnsnJoY5NCSvmDxQjWoY1aER7e//wJcFCTSkpTwYxlRa1e+OUomoexnWj1haE762NNYyFPCRh3zM2ZJTnMthM2cvMf/s3+YHXPQV2LxJgPRH5A2/Kzs3VZTS+Mw2P3dD9f3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=L4+Mrl37; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="L4+Mrl37"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=yca5H9leuTntLraFUKSXjmRQdop4d/kDI
	nAvKHOL6XM=; b=L4+Mrl37LZEzlbAu2ITEnxW34sHv15jBjYme7aS51eHA0Mv2+
	6Y3iUWChejdHiA5G1xJXOXpO4g2aB23t6rjzJ/jw9TBP7I7iNyx1omgYUgHneS78
	HXaP8a/I6Z8DZ2t6mve1CHsIknXV8a10QEj2lJelLYBLwD/rNAjEBeZzoc=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDnrwaVaZ5qh1UAAA--.297S2;
	Mon, 07 Sep 2026 15:36:53 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add UltraRISC DP1000 GMAC
 support
From: Jia Wang <wangjia@ultrarisc.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jia Wang <wangjia@ultrarisc.com>, Andrew Lunn <andrew@lunn.ch>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <248c1a07-7a5c-44dc-a73e-f95a69bb4161@bootlin.com>
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
 <20260901-dwmac-ultrarisc-v1-3-f19454814bcf@ultrarisc.com>
 <910be156-b631-4b62-972a-79d9a9e38697@lunn.ch>
 <178842162417.2701756.3296149694160507506.b4-reply@b4>
 <1622b0a7-5516-4e72-b5e1-60c12b65b52e@lunn.ch>
 <8611dff3-56ea-4798-8303-b0a8af84580e@bootlin.com>
 <178850166577.1486454.10728134844652956076.b4-reply@b4>
 <178876008871.2542659.8460758662538260209.b4-reply@b4>
 <248c1a07-7a5c-44dc-a73e-f95a69bb4161@bootlin.com>
Date: Mon, 07 Sep 2026 15:36:42 +0800
Message-Id: <178876660264.2899459.5076892433611051030.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788766602; l=3752;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=J2AYW6Dm9yYcgO50fIaAJqVyjDqxzWLcsCiWdo4nB4M=;
 b=9KbSQW8UhE99F7G6Qwn7bNg/sK74yYDtPoZt4jrJnjquGQOmtEo4fZglWp8/JyOcC4DJ2snbu
 2nJjDqABTX4AsdOG0KdZ7+CD+akuHCQH5wsMNUIq36tXLh3hT3viTA8
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwDnrwaVaZ5qh1UAAA--.297S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyrGF1kWFyxAryUGF4fAFb_yoW5Kw4rpF
	WUGF13tw4kJr4avr1qqr18ZFWFy34xJrWjqw18KryYv3Z0yF15XF18K3y5uas8XrZ7W3W2
	vr1jqasxXF1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQACEWqdDaQAAQAJsE

On 2026-09-07 09:28 +0200, Maxime Chevallier wrote:
> Hi,
> 
> On 9/7/26 07:48, Jia Wang wrote:
> > On 2026-09-04 14:01 +0800, Jia Wang wrote:
> >> On 2026-09-03 14:30 +0200, Maxime Chevallier wrote:
> >>>
> >>>
> >>> On 9/3/26 14:10, Andrew Lunn wrote:
> >>>>>> This looks to be 90% identical to dwmac-sophgo.c.
> >>>>>>
> >>>>>> Do you expect any further changes to this driver? Is everything
> >>>>>> supported? Are there more clocks? A GPIO for WoL?
> >>>>>>
> >>>>>> I'm just wondering if the common code should be pulled out, or even
> >>>>>> dwmac-sophgo.c made generic so it can handle all plain boring devices
> >>>>>> which have RGMII delays and not a lot else.
> >>>>>>
> >>>>>
> >>>>> The probe boilerplate is indeed largely similar because both drivers
> >>>>> use the common stmmac platform helpers. However, their platform-specific
> >>>>> requirements differ: Sophgo requires additional TX clock handling and
> >>>>> other configuration, while DP1000 requires fixed TX and RX delay
> >>>>> handling. ACPI support under development is also intended to use the
> >>>>> UltraRISC glue driver.
> >>>>
> >>>> ACPI is going to be fun, since nobody does ACPI networking.
> >>>>
> >>>> But how big is the change to the glue driver? I expect the change will
> >>>> be minor, a call to devm_stmmac_probe_config_acpi(), in addition to
> >>>> devm_stmmac_probe_config_dt(). Anything else?
> >>>
> >>> I agree that if ACPI support is added, let's try to make it part of the
> >>> core.
> >>>
> >>
> >> The ACPI support is still under development, but the current prototype
> >> adds ACPI device matching and ACPI-specific platform-data setup. Some
> >> common stmmac changes are also needed for ACPI-described platform
> >> resources and MDIO.
> >>
> >>>>
> >>>> One problem the stmmac driver has is cut/paste glue driver
> >>>> development. The same code is repeated again and again. Russell King
> >>>> spent a lot of time and effort trying to reduce the duplication. So we
> >>>> should not be adding more duplicated code unless it is actually
> >>>> required.
> >>>
> >>> It seems to me that all the RGMII handling could be made much more generic,
> >>> as this is commong pattern in glue drivers :
> >>>
> >>> dwmac-sophgo has the "has_internal_rx_delay" field, and dwmac-eic7700 has
> >>> both has_internal_[r|t]x_delay.
> >>>
> >>> With this third one, it makes sense to start sharing that logic across
> >>> glues.
> >>>
> >>
> >> I agree. DP1000 is another user of this pattern, with fixed internal
> >> delays on both the TX and RX paths. I will look at moving this handling
> >> into the common stmmac platform code, leaving each glue driver to
> >> describe its internal delay capabilities.
> >>
> > 
> > After looking further into the implementation, I see two possible
> > approaches:
> > 
> > 1. Keep a minimal UltraRISC glue driver that only describes the fixed TX
> > and RX delay capabilities, while the common stmmac code handles the PHY
> > mode adjustment.
> > 
> > 2. Store these capabilities as compatible-specific match data in
> > dwmac-generic and remove the UltraRISC glue driver entirely.
> Let's go with 1 for now I'd say. UtraRISC will be the only one that's basically
> an empty glue calling core code (maybe you have some plat->flags to passs ?).
> 
> If we manage to simplify even further (e.g. tx clock handling for exmaple), we could
> also deal with dwmac-sophgo the same way. We could then consider something like
> dwmac-simple.c , keeping dwmac-generic.c for the raw dwmac IPs.
> 

Thanks, I will go with approach 1 in the next revision. DP1000 does not
currently require any additional plat->flags.

Best regards,
Jia Wang


