Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2C5448BF;
	Thu, 10 Sep 2026 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062208; cv=none; b=clEiBcRFPeohO+yHZxuzrEXoOKz2bkPNM4jXX68G9omKWManZ918GctqCLCxyLNwjlSPVoP0R+D78Awz3rO+NhUjxU6+F0UGn8qTimaKJaLNE995R8HZEL72HQ/pWm35PTtnH8TiHjPpFBpySjohYZFJhyBjLsX/UOhgG+oS8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062208; c=relaxed/simple;
	bh=2NkyM88ysK2/1+nEtSxMcx6Ajcda02sPASrIrjZLHEw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Sy1FWDdTyKamLbRS2fTYXzBQBRCG8FQE5m1rK0nzCjeyuNMEmgoVdfhmjM+a4nrnVgQEZ0pc/DvKKeOcVye2jczNYp5qleo7SZQgbfddG1HEv4ut2b9FUrtbUp2mSmM6ctmGI+RztWDO1BOepWuYR97cHTX9lj9YORIVipK9cR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=s4kzlA9z; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="s4kzlA9z"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94DEFA02B3;
	Thu, 10 Sep 2026 19:43:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789062197; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N2jLRbdlPtNCfQqn4UIVQslnB8/tvN3bZyU9rPBE/A4=;
	b=s4kzlA9zD145la6gKnyU5JFxS6rad2qVPoa9Fh/Oo7+cQ/i6qxJ1SltCe2xkD2kmMQWWfP
	TIKm3wgIM5u8YjCQHLRX8k62rlp3XgU84l+dA/pE7JO637XjDqJhheeBu/zhQospkhhVW1
	FwRW6PqkR6dVynGvxUVrGUfLLX+NBgi39ovhxDp/3EbdGuiqu2UWRox9JCJjPo9WcnCDhQ
	uz6OAJlPdkwGK0n0GI7bgkV549BmOwdVhJAbwRzb90kSLM9U2ydFQCIXc3N4knmFTyBWU7
	YfygUV7IiQa58pjdKQEZuolRFXf+adQSaETUo6X4FSekpBSL3q0oL4FeauBYEw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 19:43:08 +0200
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
Message-ID: <89e242e8ddc78db7531d17a8a8adb904@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime,

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
>  .../stmicro/stmmac/stmmac_selftests.c         | 39 +++++++++++++++----
>  1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index 6503678b646e..a8280834185c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> @@ -462,7 +462,7 @@ static int stmmac_test_mmc(struct stmmac_priv 
> *priv)
>  static int stmmac_test_eee(struct stmmac_priv *priv)
>  {
>  	struct stmmac_extra_stats *initial, *final;
> -	int retries = 10;
> +	unsigned long timeout, max_duration;
>  	int ret;
> 
>  	if (!priv->dma_cap.eee || !priv->eee_active)
> @@ -478,14 +478,21 @@ static int stmmac_test_eee(struct stmmac_priv 
> *priv)
>  		goto out_free_initial;
>  	}
> 
> +	/* Snapshot stats, we want to count the in_lpi events. We may enter
> +	 * LPI just after the packet was sent.
> +	 */
>  	memcpy(initial, &priv->xstats, sizeof(*initial));
> 
> +	/* Send a frame, then wait to enter LPI */
>  	ret = stmmac_test_mac_loopback(priv);
>  	if (ret)
>  		goto out_free_final;
> 
> +	max_duration = usecs_to_jiffies(2 * priv->tx_lpi_timer);
> +
>  	/* We have no traffic in the line so, sooner or later it will go LPI 
> */
> -	while (--retries) {
> +	timeout = jiffies + max_duration;
> +	while (!time_after(jiffies, timeout)) {
>  		memcpy(final, &priv->xstats, sizeof(*final));
> 
>  		if (final->irq_tx_path_in_lpi_mode_n >
> @@ -494,20 +501,38 @@ static int stmmac_test_eee(struct stmmac_priv 
> *priv)
>  		msleep(100);
>  	}
> 
> -	if (!retries) {
> +	memcpy(final, &priv->xstats, sizeof(*final));
> +	if (final->irq_tx_path_in_lpi_mode_n <=
> +	    initial->irq_tx_path_in_lpi_mode_n) {
>  		ret = -ETIMEDOUT;
>  		goto out_free_final;
>  	}
> 
> -	if (final->irq_tx_path_in_lpi_mode_n <=
> -	    initial->irq_tx_path_in_lpi_mode_n) {
> -		ret = -EINVAL;
> +	/* Re-snapshot, as we want to measure exit_lpi events. We should be
> +	 * in LPI right now.
> +	 */
> +	memcpy(initial, &priv->xstats, sizeof(*initial));
> +
> +	/* TX something so we go out of LPI */
> +	ret = stmmac_test_mac_loopback(priv);
> +	if (ret)
>  		goto out_free_final;
> +
> +	/* Wait for the exit LPI interrupt */
> +	timeout = jiffies + max_duration;
> +	while (!time_after(jiffies, timeout)) {
> +		memcpy(final, &priv->xstats, sizeof(*final));
> +
> +		if (final->irq_tx_path_exit_lpi_mode_n >
> +		    initial->irq_tx_path_exit_lpi_mode_n)
> +			break;
> +		msleep(100);
>  	}
> 
> +	memcpy(final, &priv->xstats, sizeof(*final));
>  	if (final->irq_tx_path_exit_lpi_mode_n <=
>  	    initial->irq_tx_path_exit_lpi_mode_n) {
> -		ret = -EINVAL;
> +		ret = -ETIMEDOUT;
>  		goto out_free_final;
>  	}

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de

Thanks,
Nicolai
