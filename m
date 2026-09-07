Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595751E443;
	Mon,  7 Sep 2026 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799982; cv=none; b=Rz4jbnHR76rtx6y4XUqv2tsmTyL0J5C6j7C/m+KfcKUxriE3fAGW9cWpWTMU9jd8Cz23JenjlADXq59Dz4lhlxMkySOzdp7g6jEWptICRyZnxXpk8dubBPACN2nEHA1qokioL6DYhzufRhyyHs6FdRJDF1XZ/gGf9W0ylIYHZc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799982; c=relaxed/simple;
	bh=bBRbQ94ZOEkSEakBN1pIgYkF19BeSbsVt2yRQi0m7k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnE3i4dHhrVpKTjDackQXHV/8EpNZK2wQQtzblMjlagrsMYHs02Q6j89HQudACE0I8RsnXBn4c7mcG8Q6yOr801J0YazmpGUNmBjZZ2ogcB3eDGyQJRQ/kz9sybwRaa8Rk3+cLvVMN1w+n6nJ2oPHCBK4s2Ycpi4Byw7qSY5aAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=z42pw5VT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="z42pw5VT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3B3C44E41575;
	Mon,  7 Sep 2026 16:52:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0CC2360383;
	Mon,  7 Sep 2026 16:52:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC4B411C7A34F;
	Mon,  7 Sep 2026 18:52:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788799977; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SaxvEmxspb626SKeKU9mGlI9YVMzBYhU6QaMsiPoRkw=;
	b=z42pw5VT/hKkzDp1oZOWeeLe8QHIWVUwnodkcevKFLGyygzG2ttmLhuahw9f2l8O+qheKo
	KrSY7uRg5oyLcgUD7CNvQ+kpLfRFV8upBGS8anhHtMKLaSUvSV6epFhOwHCIeNX0yVsvH+
	RGpluv3ZTz5OCfneviWZDiCX2hjhkR4cMThml22MJZn5ypHKr7puyrumT+QB4n7ZUe6cXa
	/hobKyvbhZFpif7b/rRVYBaJ9+/66u/Q0XNAJl+z1n5kOa752D0RItCG3AeHM5mffBX8IT
	QW0hA9LrWMRfmYzpbIu3qKbZJVM8jRZqOchau2KEQsANi/mIIGr6oS18LANS3Q==
Message-ID: <e01d0dc2-a1e5-415d-9126-fbf2344e6b7d@bootlin.com>
Date: Mon, 7 Sep 2026 18:52:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Rayagond Kokatanur <rayagond@vayavyalabs.com>,
 Thierry Reding <treding@nvidia.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260907-stmmac-ptp-error-propagate-v2-1-4a2e8e41e860@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260907-stmmac-ptp-error-propagate-v2-1-4a2e8e41e860@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/7/26 13:50, Lorenzo Bianconi wrote:
> stmmac_setup_ptp() returns void and swallows both PTP setup errors:
> the PTP reference clock enable and stmmac_init_timestamping()
> failures are logged but never propagated. When they fail, the MAC
> system time counter is left in its post-reset, non-running state,
> while the driver keeps operating as if timestamping were up.
> This matters for TAPRIO/EST qdisc offloading, which derives the EST
> base time from the hardware timestamp counter: arming the gate list
> against a non-advancing time base would leave the schedule permanently
> stuck.
> 
> Make stmmac_setup_ptp() return an error code and propagate the
> failure in __stmmac_open() and stmmac_resume(), stopping the DMA
> engines when PTP setup fails.
> 
> Extend the same error propagation to the timestamping counter
> initialisation: stmmac_update_subsecond_increment() and
> stmmac_init_tstamp_counter() now return the addend and system time
> programming errors instead of discarding them, so a counter that
> cannot be configured is reported as a failure rather than silently
> left non-running.
> 
> While at it, factor the timestamping availability check into a
> stmmac_check_timestamp_cap() helper that requires both the hardware
> timestamping capability and a valid PTP reference clock rate. This
> keeps the interface operational on platforms with PTP-capable
> silicon but an unconfigured PTP clock, where timestamping cannot be
> enabled: those are treated as PTP-less rather than failing to open
> or resume. Apply the same helper to the hwtstamp get/set paths so
> they consistently report -EOPNOTSUPP when timestamping is not usable.
> 
> Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")
> Fixes: 0ad2be79f254 ("net: stmmac: Balance PTP reference clock enable/disable")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
> Changes in v2:
> - Check clk_ptp_rate value in stmmac_check_timestamp_cap().
> - Return error code in stmmac_update_subsecond_increment() and
>   stmmac_init_tstamp_counter().
> - Rely on stmmac_check_timestamp_cap() in stmmac_hwtstamp_set() and
>   stmmac_hwtstamp_get().
> - Link to v1: https://lore.kernel.org/r/20260904-stmmac-ptp-error-propagate-v1-1-80f01b03dafa@oss.qualcomm.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 96 +++++++++++++++--------
>  1 file changed, 64 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 07a6fab6460e..99d4fbccc300 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -601,7 +601,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
>  	}
>  }
>  
> -static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
> +static int stmmac_update_subsecond_increment(struct stmmac_priv *priv)
>  {
>  	bool xmac = dwmac_is_xmac(priv->plat->core_type);
>  	u32 sec_inc = 0;
> @@ -625,7 +625,18 @@ static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
>  	 */
>  	temp = (u64)(temp << 32);
>  	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
> -	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
> +	return stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
> +}
> +
> +static bool stmmac_check_timestamp_cap(struct stmmac_priv *priv)
> +{
> +	if (!priv->dma_cap.time_stamp && !priv->dma_cap.atime_stamp)
> +		return false;
> +
> +	if (!priv->plat->clk_ptp_rate)
> +		return false;
> +
> +	return true;
>  }
>  
>  /**
> @@ -653,7 +664,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  	u32 ts_master_en = 0;
>  	u32 ts_event_en = 0;
>  
> -	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> +	if (!stmmac_check_timestamp_cap(priv)) {

This isn't equivalent, as here we check for adv_ts. adv_ts is more restrictive than
just checking the atime_stamp cap, as on dwmac1000 we need both extend descriptors
and atime_stamp capa to set adv_ts.

Now we do have a discrepancy between the _set and _get timestamping ops, as the _get
part only checks the atime_stamp capa.

It seems to me that your fix is the correct one though.

To me the patch looks OK,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
