Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F96283FC4
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414391; cv=none; b=pRRjEDsQUtYO/Ftp1/3kqa8kpvFZ09C6jYeREVCP9xHeJXzSuuwZ/u0FHVvahAZ0XcJJBecm/7Nz2vvFyd2O0gSD79P+aBTHpHMxBzb6UPmhVzkOU9YaTwHhXl3RVv4yf9gSaNvARBPy0x5Afa2HCdz3R6+MXlrlRTczmfoIfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414391; c=relaxed/simple;
	bh=gJRyttemlzcnkE5/HtqKk6As373C9UZkywAUyeOrZIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZ19hgfEhA6u8CdKw6WfUKpGB/iVshERSfsCcIK/6m3oFSTG21VqUJmyvkURFTbo6CtOsZZtJEMivKxiz8zkJTXcfYZJuTibT54te1kINgrs+UECq4TfdlD1JBobOKr7aWxkrrkHJbuanFzk2j9chZ+HsfV0xucqcNec1WEv5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PduUopRt; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PduUopRt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0407CC5CD5B;
	Mon, 19 Oct 2026 12:54:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DFEFC60582;
	Mon, 19 Oct 2026 12:53:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C569610328D37;
	Mon, 19 Oct 2026 14:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792414386; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=hnnaa0qcYgq7LEL7vongHZ/bO108jfN4Q2NbDs5WGKY=;
	b=PduUopRt/eBxrpCDy2Wg8lyy1PIJkDXN18qT2anxFVc8xx4SsUplAa5DjYc6YGY0JPNISV
	qgPIOcxfOhHblv4w0YFHZnQmawEl2T+i0uO+IIPmo/e+/K6N9IgkcqP7a45h0cVm/jZONF
	UFOT6G5DZD2RzwS04NU5ENLoPOtwYso3mkazbRZhr4CYy9SczMdJggSJrFmlOzNqOZBhsM
	ksYi4H6HwUbIhjGCob7fFq5SP7XHkWLqsJmkPatArHVrO2WyiJRx9n3SjXJWzFnvpkakCB
	x90cHXICjT5mAG8I18G+nTGmY/sgNINhWL4gB5gdUtlTKf2Ryx5eofHEFWXnuA==
Message-ID: <8f1a899c-e026-4887-8d5d-400c5c73581f@bootlin.com>
Date: Mon, 19 Oct 2026 14:53:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net 10/10] net: pse-pd: reject a power limit whose current
 does not fit an int
To: Carlo Szelinsky <github@szelinsky.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Piotr Kubik <piotr.kubik@adtran.com>,
 Sai Krishna <saikrishnag@marvell.com>, Simon Horman <horms@kernel.org>,
 Kyle Swenson <kyle.swenson@est.tech>, netdev-bot+sashiko@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261018082314.48950-1-github@szelinsky.de>
 <20261018082314.48950-11-github@szelinsky.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261018082314.48950-11-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/18/26 10:23, Carlo Szelinsky wrote:
> pse_ethtool_set_pw_limit() turns the power limit into a current as
> mW * 10^9 / uV and stores it in an int. For the largest allowed limit,
> 99900 mW, that overflows below about 46.5 mV. Only 0 V is rejected, and
> si3474 reports the measured voltage of each port. A negative result then
> hits the BUG_ON() in regulator_check_current_limit().
> 
> pse_pi_get_current_limit() does the same conversion and can return a
> wrapped value that looks like an error code.
> 
> Do the conversion in one helper that returns -ERANGE when the result
> does not fit an int.

Same as patch 9. This is not a fix.
Can you send both to net-next instead.
You can add my R-by tag to it.

> Fixes: 4a83abcef5f4 ("net: pse-pd: Add new power limit get and set c33 features")
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
> ---
>   drivers/net/pse-pd/pse_core.c | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 0d1e5d5039f8..3e333bef4e48 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -741,12 +741,19 @@ static int pse_pi_get_voltage(struct regulator_dev *rdev)
>   	return ret;
>   }
>   
> +/* uA = mW * 1000000000 / uV, which does not fit an int for a low uV */
> +static int pse_mw_to_ua(unsigned int mW, int uV)
> +{
> +	u64 uA = DIV_ROUND_CLOSEST_ULL((u64)mW * 1000000000ull, uV);
> +
> +	return uA > INT_MAX ? -ERANGE : uA;
> +}
> +
>   static int pse_pi_get_current_limit(struct regulator_dev *rdev)
>   {
>   	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
>   	const struct pse_controller_ops *ops;
>   	int id, uV, mW, ret;
> -	s64 tmp_64;
>   
>   	ops = pcdev->ops;
>   	id = rdev_get_id(rdev);
> @@ -769,10 +776,7 @@ static int pse_pi_get_current_limit(struct regulator_dev *rdev)
>   		goto out;
>   	uV = ret;
>   
> -	tmp_64 = mW;
> -	tmp_64 *= 1000000000ull;
> -	/* uA = mW * 1000000000 / uV */
> -	ret = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
> +	ret = pse_mw_to_ua(mW, uV);
>   
>   out:
>   	mutex_unlock(&pcdev->lock);
> @@ -1910,7 +1914,6 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
>   {
>   	int uV, uA, ret, previous_pw_allocated = 0;
>   	bool updated;
> -	s64 tmp_64;
>   
>   	if (pw_limit > MAX_PI_PW)
>   		return -ERANGE;
> @@ -1928,10 +1931,12 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
>   	}
>   	uV = ret;
>   
> -	tmp_64 = pw_limit;
> -	tmp_64 *= 1000000000ull;
> -	/* uA = mW * 1000000000 / uV */
> -	uA = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
> +	uA = pse_mw_to_ua(pw_limit, uV);
> +	if (uA < 0) {
> +		NL_SET_ERR_MSG(extack,
> +			       "PSE voltage read is too low to set the limit");
> +		return uA;
> +	}
>   
>   	/* Update power budget only in software power control case and
>   	 * if a Power Device is powered.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

