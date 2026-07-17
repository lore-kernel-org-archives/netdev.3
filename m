Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13993E5EC4
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281631; cv=none; b=OiPWjVowqNDGV18mnnKB+UkMqyWuy7R6MVmqKkbSg429kuG/Kc3me/QuKDX21WBd/q+odPWdZuB4Z2dtqYwikPzaRLsqFDzSKXfIf/lLU4OoWOjhZeqQrT+N+Pfyxkoge9ldVaxqLaft7yRHXFyGfcLBG0KoNcLGaNht711S/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281631; c=relaxed/simple;
	bh=w5u456siBg8ManQqixCLUPiV3lo3wWn8o02amKlK058=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIUHPJZBZMClTUlMJPFePbzaXEIilWt+NzlrUQy/H0490hGepMaxsO/IcXjSkcfemJPaGrSJqp8B4xfXdDg/xRmCTNed1LHKrsepo+GYiMtPNhmKLo8XtaSM5wL0e2QLu7jXshG2CqtOtgfwrINDb5EQaYgVbpTlYGU83uunbms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mROS9WP4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mROS9WP4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AF573C2B9F7;
	Fri, 17 Jul 2026 09:47:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ED31560361;
	Fri, 17 Jul 2026 09:47:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 225EE11BD0424;
	Fri, 17 Jul 2026 11:47:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784281627; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=NhWr7DyYHBMitYnhvrVIDsh6S5Eu/wdCCtdb6dUizGM=;
	b=mROS9WP4u4nxqxbIO1iWw/9DeCH9lbJu8Ab/BWzz1frh9hKmb/fwE9chdLymD9nlntHSf/
	c7+0UJEJqVsC54NRjD7lwGZxzQImUznXSEfrXk7wOzMS0MnMWg1+WKv8tU3rTFQteBAqKZ
	LYZQlalnWyWA/aJAPXymyEPxp+iYv51idDSlRh7ZoccNo7i6WNCRObiMOkfAaA5T+Czauc
	GTQzX39riEHKT1Csj4bAkmQeEiiQkwZseNtYmj2Fn0TUILcsuiW1jMykBndqLgwaiyN12C
	BtnzMtBsN/b05Z5ZFlSbSguapSTmgRKeeoMOPepO/PNW9SKHwq81DCWj4Ot4PQ==
Message-ID: <da7d4ee0-8122-4839-b807-5d23ee6aeef7@bootlin.com>
Date: Fri, 17 Jul 2026 11:47:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: dwmac-rk: enable the
 reference clock for output mode
To: Jiaxing Hu <gahing@gahingwoo.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, heiko@sntech.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
References: <20260717065933.2629501-1-gahing@gahingwoo.com>
 <20260717065933.2629501-3-gahing@gahingwoo.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260717065933.2629501-3-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/17/26 08:59, Jiaxing Hu wrote:
> rk_gmac_clk_init() only requests the refout clock group for RMII. The
> ArmSoM CM5 has an on-module YT8531 RGMII PHY with no crystal that needs
> the SoC 25 MHz reference (clk_mac_refout), so in RGMII the clock was
> never enabled and the PHY did not respond on MDIO.
> 
> Request the group whenever the SoC drives the clock (clock_in_out =
> "output"), not just for RMII. The clocks are optional, so other boards
> are unaffected.

You've taken my review into account (thanks :) ), but you're failing to
address Andrew's comment.

The PHY should be the one requesting the MAC to output the refclk, in
that case the MAC will act as a clock provider, something like this :

https://elixir.bootlin.com/linux/v7.1.3/source/drivers/net/phy/air_en8811h.c#L1156

The PHY then requests the clock (probably an optional clock).

Maxime

