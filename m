Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2F54936D;
	Wed,  9 Sep 2026 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954166; cv=none; b=YHumIFZRRJWQwqm9/6ikvViKWL8WYjRNFwnEzhGe1dlw9jcUQuvI+KPnvnJ6gfwL6C4F/lIuyXTGY/JLqNGyd1Q8HCB7ISFNv8v043CNRkHUAF3LfW1A8Afe+ZQxjNa8U32/47DWeaAkV2Z2rYrs6sVZ21zZYtiE8q5m8cFS9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954166; c=relaxed/simple;
	bh=NHuRSVmRbB4nVz4ShQc/CV4keQMxc9xxzTf4mlVXcxg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cv6br12c0cF82Ed6Wv/RccVFtuVKTeSswT7upXqfObDwsHZ5Gv5TE3HBEUUkDwm34kMkM/8/dPVD16kiRAcRYd4Euu177/P8LYwQHkjwnALtoOJLPX1i1x5etKgD4rdDHrMnVRn7BeZg7Gp1FSeYnBJPM8/MzOul6MLsHItaZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=sbRE2tYk; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="sbRE2tYk"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCBDEA91C3;
	Wed,  9 Sep 2026 13:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1788953583; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yPBIL7xp9k71Jeokn/0hO8JzhFF0Afrctk/+t5BAEHE=;
	b=sbRE2tYkP1k8m+7VZC/tSY0yzOQ8YBnjJnZvwjHUTlqrOFt2S+IFcDWSu6pyR+oAtqCEqa
	x8JHfGwqVz7NMO/Fod8/lA9KeBM58l3Kv5BpRWDcyWGpG4LTsKTVSnNkt4khTC6k2n6wbg
	aTbFeLXHYiMu60j+b2fSDKzQ+1bLRVFdpvnedgmYC/wZVWaVOJRZ3DIaRvr+krDKWRXhPa
	D8CPaES0bPYr1YRgt3c33kt2leHuIqp9gxrmMj0fmPTC+7dGlLE11tmNab8vm6zsuciAaY
	8Ifwj7UmXpl/WF5PZJiOq3uP+aKNCpJ0k4jx3Kq8XVhn3ITd22PEXi+8VreUVQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 09 Sep 2026 13:32:45 +0200
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
Subject: Re: [PATCH net 2/6] net: stmmac: selftests: Validate EEE based on the
 actual LPI timer value
In-Reply-To: <20260909074740.1247762-3-maxime.chevallier@bootlin.com>
References: <20260909074740.1247762-1-maxime.chevallier@bootlin.com>
 <20260909074740.1247762-3-maxime.chevallier@bootlin.com>
Message-ID: <2f268c9ff187ba59f69d37dd4e4ba99b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime

On 9.9.2026 09:47, Maxime Chevallier wrote:
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
>  .../stmicro/stmmac/stmmac_selftests.c         | 33 ++++++++++++++-----
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index 6503678b646e..4564b9f29194 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c

> [...]

> -	memcpy(initial, &priv->xstats, sizeof(*initial));
> -
> +	/* Send a frame, then wait to enter LPI */
>  	ret = stmmac_test_mac_loopback(priv);
>  	if (ret)
>  		goto out_free_final;
> 
> +	max_duration = usecs_to_jiffies(2 * priv->tx_lpi_timer);
> +
> +	memcpy(initial, &priv->xstats, sizeof(*initial));

Is the LPI entry already counted here? AFAIU with tx-lpi-timer=0 on 
dwmac4 the
MAC goes directly into LPI after the frame, before 
stmmac_test_mac_loopback()
returns. The loop below would time out although LPI is working.

Snapshot before the first frame, and take a second snapshot right before
the second loopback for the exit check?

> [...]

> +	memcpy(final, &priv->xstats, sizeof(*final));
>  	if (final->irq_tx_path_exit_lpi_mode_n <=
>  	    initial->irq_tx_path_exit_lpi_mode_n) {
>  		ret = -EINVAL;

nit: -ETIMEDOUT here as well, to match the entry check?

Thanks
Nicolai
