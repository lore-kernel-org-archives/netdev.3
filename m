Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E257F732;
	Thu, 10 Sep 2026 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066250; cv=none; b=tScmjo91/i+ogAaI0TCMkN93R5VjIiEbBn/IR3EYLmleQNa/4JO8X69hVwgsXERQwkup7+fnxbsVgOJrMR/4BSc9qE54O2uvY1wBOasSPUmdzJgXO4w6Xo1KQtqsts0zU/crP22WQy5YCARzmJjw/oDyvH7UZEEkixU445lE0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066250; c=relaxed/simple;
	bh=Pa6zAXfoN4ohhEM9Buwh5inDl6XhPbjleTPchhebZgg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eVZ4CEhw2pmQ45Ov8RPkJCCVU405/HDOG39Y5MOfwdh1Nfi4jW38sod0EmXLcemLYJdYX68N+MrDso2UwOHFonkpXROJImV4rWns+36Dgc9Tc3KracFYf2+TyBJ1HgBZxb5sbx9UYZjq2DRNOljy6qfr6dBqHNeFZ2Rb8UYX53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=LIEWtQn2; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="LIEWtQn2"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A255A4C11;
	Thu, 10 Sep 2026 20:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789066243; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ILJuufaqNcUzTTR4FwZhEK5XMtJpPKS2KUNnrZzHEu0=;
	b=LIEWtQn2q2K3wNf8lJTrV4feoBXYb0rEHyO4tcZn7i7/YuHwHcEDoJA88/HjoX9w6HWV8J
	LaVkYnSs42GL5ueLXk3pjg5zvGIHCTAKsohp25xpUpfpyj3pKAKkJrtcU/daigWszK8A5i
	aWW+qnasQida1DBitAlPyOpV6tS8KA+WKjFZ/h6SmxheeI0iq5vHf/lVAMtHgcJUYESe5U
	IB0emU8VASWIbX1M4KtgvVh9FOryGT7CAh+KKRGG/LAiV1aC8eguhGO0FUm+20UqJv7n1n
	jPRWWfb9XQ/Srac3PRgVj6KYO0TyGAGWhOEppfbf2EOYd3MLTfA/zDsgmg+uXg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 20:50:30 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Emil Renner Berthing
 <kernel@esmil.dk>, Minda Chen <minda.chen@starfivetech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de, David Laight
 <david.laight.linux@gmail.com>
Subject: Re: [PATCH net v2 2/6] net: stmmac: selftests: Validate EEE based on
 the actual LPI timer value
In-Reply-To: <20260910151404.976753-3-maxime.chevallier@bootlin.com>
References: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
 <20260910151404.976753-3-maxime.chevallier@bootlin.com>
Message-ID: <6af83ee5b9ddeeebcc6e4cc29989b856@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime,

Sorry for the noise, but after having a second look, there is something
which I think should be discussed at least.

On 10.9.2026 17:13, Maxime Chevallier wrote:
> The EEE selftest is a 2-step test :
>  - It validates that we enter in LPI mode with the
>    irq_tx_path_in_lpi_mode_n counter
>  - It then validates that we exit LPI when sending a frame, with the
>    irq_tx_path_exit_lpi_mode_n counter.
> 
> The current state of the test lacks 2 main things :
> 
>  - We don't know exactly when was the previous frame sent (it's from 
> the
>    previous selftest)
> 
>  - The timeout is hardcoded, while the LPI is entered after a
>    user-configurable delay. On top of that, the timeout loop uses a
>    pre-decrement iterator (--retries) that actually only iterate nine
>    times, so 900ms while the default LPI value is 1 second.
> 
> Let's therefore make it more deterministic :
> 
>  - Send a frame at the beginning of the test
>  - Wait for more than the lpi timer value, we timeout after about twice
>    the value,
>  - Then send another frame, and verify that we do go out of LPI, also
>    with a timeout.
> 
> Note that the test's goal isn't to validate the LPI timer value itself,
> only that we enter/leave LPI mode.
> 
> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> [...]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> [...]

> 
> +	max_duration = usecs_to_jiffies(2 * priv->tx_lpi_timer);

tx_lpi_timer comes direct from ethtool as an unvalidated u32. So if a 
(arguable privileged
user) does 'ethtool --set-eee eth0 tx-lpi-timer 1000000000', the code 
will sleep ~2000 seconds
under rtnl_lock. Tge old code capped it at 900 ms regardless of the 
timer.

Thus I think we should clamp it at some sane value. Feel free to keep my 
R-b with the clamp.

> [...]

Regards,
Nicolai
