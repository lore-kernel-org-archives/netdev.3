Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64620145B27
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846573; cv=none; b=PSvdtI6nMc2f4Pe5XXkO76uxJuVZ1xUQt41b3ywjaoxVa9F6iGoMYLIJngOAmQj7Di2I4OHA0UdHddziYiQER/tXxeOz6h/y5DCDRmDdxB7/Ylc8wWVGm8GU32qkpP5TvH/FV83qEGBFNomh7kqbPKnTMhaBPARijIthZiITCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846573; c=relaxed/simple;
	bh=NB44c/iontyfby0/z6SLYsrbBcWm69gIjXt8NWCrKeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBYq+mNnTwWU9hDTV3Buji1HomdvmAl8ToSdCq764oMVMGFnbvWX4OW3/rjFgMQkdcf1RzzprcT2AevPXcb5XSB8XQA2hxWj3+mn69teZMxNt4MqNzYtKjaraY2CpoYYu6oSjd0B7Hzuip+zU1flgbgEMNdh/+Ng2hWL3+pVrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eBTmwlyq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eBTmwlyq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1EDBF1A0F7C;
	Sun, 12 Jul 2026 08:56:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC3B560341;
	Sun, 12 Jul 2026 08:56:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 743A811BD39CB;
	Sun, 12 Jul 2026 10:55:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783846561; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Y7El/GvvQcgfO05yr3MPYiblRZfsw0etG5ZwJOy721U=;
	b=eBTmwlyq5grs9SuLbAKD5Y75NROGxAC1QetQ5b7HUGAnFwTASj+WWM9Y2Iot07rey7XZXP
	dJ0YFCv8Carw54kXlnGxJE/UfFRe1GE5u6FuZv37KeO3KFh7WR4Cf4O4tbdJcYj5mg6bz7
	0Cjqq3AkI+EXauwXN+Fl+CLvRiO597RuxtO5GpSkyHIwkww0pu4ABAmGHXuH7iniyCLzWC
	n2O7JocA0WdizEixyG5XtkjLeNAqVVNlcFbJwOzKWAy9/XtXLivw47muUa7buKjuXB15J8
	R37JSbRS8ynuqRJaJJsnMzV+lKRWSBvpjNNQF+/zwqu25Hkx79lJHJ5MNvk+6A==
Message-ID: <bc78469c-3f45-4234-88b0-49f050d651db@bootlin.com>
Date: Sun, 12 Jul 2026 10:55:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failed to reinit phy of spacemit-dwmac when reset-gpio is present
To: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 E Shattow <e@freeshell.de>, Han Gao <gaohan@iscas.ac.cn>
References: <20260712045233.800748-1-inochiama@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260712045233.800748-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Inochi,

On 7/12/26 06:52, Inochi Amaoto wrote:
> TL;DR:
> 
> The DWMAC on Spacemit K3 is failled to register phy after the reload
> the driver module (rmmod then insmod). Because the reset-gpio is
> asserted while unloading the driver and is not desserted before reading
> the c22 id, which leads to a fault.

You're not the first one facing this type of issues, this is a long standing
source of issues. The problem is partially hidden by the fact that often times
the bootloader deals with the PHY reset (like the case you're facing)

Take a look at these discussions :

https://lore.kernel.org/netdev/cover.1761732347.git.buday.csaba@prolan.hu/

and maybe more intersting, Russell suggested an approach on how we could potentially
address this here :

https://lore.kernel.org/all/aTBeVTlsElGXUCSN@shell.armlinux.org.uk/


> ---
> --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> @@ -196,7 +196,8 @@ &eth0 {
> 
>  	mdio {
>  		phy0: phy@1 {
> -			compatible = "ethernet-phy-ieee802.3-c22";
> +			compatible = "ethernet-phy-id001c.c916",
> +				     "ethernet-phy-ieee802.3-c22";

Indeed that's merely a workaround :(

Maxime
