Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955D4825B0
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401095; cv=none; b=fuw3r71K9b8sSRdIOH3jx8VQK6QUunmp4pKs4BuG0mBtDkCtpcWI/hVD8lRHUR+bFgn3jquptmO5hHmjPWA0AxQ4nv/2rNxSUSvXhZBfTCjQ332gvn/w7B08qNpHZyMxc1DxPp/fwTsl5VyFt34YElB5KHIXcAKNAf9GNU+Wm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401095; c=relaxed/simple;
	bh=ME4BoNojgGyJAJjCHhN5y8G+CBWSO9gJC5gljdc1ePA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWdVQVcwZWiYqjHePXcO/9f+sBsRmLlbpWK0AAyiNQLhuzaJa8pKE04JnICYq6dXzqB1/QshBMH9yQDpm7pcHrIEMB8J6EVcGKvRx//QqU0b5jpWRSBTRYtrDUbXQJXyrZWaK72zHftvYfEIDLUDXmUXaoBVLYV5SESib8bOpSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=t/KQXYf5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="t/KQXYf5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 33D6F1A1279;
	Mon, 19 Oct 2026 09:11:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0775560582;
	Mon, 19 Oct 2026 09:11:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27EEA10328429;
	Mon, 19 Oct 2026 11:11:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792401089; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4YKokKg3orgQFBfeLlmMXK/jeU66aSRwE1cblTmgQpk=;
	b=t/KQXYf5npR/joXA4jFgYpbxRfWBO6FO0UtfbdWU05bo6zWypmzKYfcPaxnchx35+yIq9x
	jcoivrvrzVKUCJMJDtAqI16eFSj24N55dwvRcoLoDiALe/ebrJRss8WYvZ06jjfpl+05Zs
	W42uSS+uTiGb/sAceZmT7phqWqA7NfYJY+T/QQVnl95b+5lett/DJcHefE+tUfixh7rE8P
	TjCrGJiopTlVodktpG/lk9TYmutljprCA8ZDZ3HJgeMQ588I/GLy0AFx9ZwQSFjhueaah4
	Hf2oRDGzue1ccau87mXxdxuTogs3p3LrmSeiniqkVG6PK7TbPlCGl0gHDzHOHQ==
Message-ID: <748d24c8-2576-4958-95e7-01a1d40d5891@bootlin.com>
Date: Mon, 19 Oct 2026 11:11:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net] net: pse-pd: don't enable a PI again while disabling
 it
To: Ross Cawston <ross@r-sc.ca>, netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261018182005.1193-1-ross@r-sc.ca>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261018182005.1193-1-ross@r-sc.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/18/26 20:20, Ross Cawston wrote:
> With software power control, _pse_pi_disable() frees the power budget
> of the PI and then retries the power delivery of the PIs waiting for
> power in its power domain: those that are admin enabled, have a PD
> detected, and are not enabled in hardware. The PI being disabled is one
> of them, as its admin state and PD detection are only cleared after
> _pse_pi_disable() returns, so it is enabled again right away:
> 
> - an admin disable of a port with a PD keeps the port powered, and the
>    next admin enable allocates its budget a second time
> - a disconnection enables the now empty port again, with a new budget
>    allocation that is never freed: when the port reports the
>    disconnection again, its PD detection is already cleared
> - a PI disabled to free budget for a PI of higher priority is enabled
>    again with the budget it just freed, so priorities never take effect
> 
> Clear the admin state and the PD detection before disabling the PI,
> and don't retry the power domain in pse_disable_pi_pol(), whose freed
> budget is meant for the PI being allocated. That PI stays waiting for
> power and is retried when budget is freed later.
> 
> The problem was found, and this fix written, with an AI coding
> assistant, while testing the budget on a switch with two Realtek RTL8239
> PSE controllers, whose driver (not in mainline yet) uses the static
> budget strategy like the TPS23881. Before this change, "ethtool
> --set-pse <port> c33-pse-admin-control disable" left a port with a PD
> powered, and the budget allocated in the power domain grew with every
> disable and every unplug. With it, the port stays off, and the allocated
> budget is back to 0 after a disable and after an unplug. Tested on that
> switch with OpenWrt's 6.18 kernel; the change for mainline is the same
> apart from context and is build-tested.
> 
> Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
> Signed-off-by: Ross Cawston <ross@r-sc.ca>
> ---
>   drivers/net/pse-pd/pse_core.c | 50 ++++++++++++++++++++++++++++-------
>   1 file changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index a5e6d7b26b9..b46e3a13a31 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -448,14 +448,14 @@ static void pse_pi_deallocate_pw_budget(struct pse_pi *pi)
>   }
>   
>   /**
> - * _pse_pi_disable - Call disable operation. Assumes the PSE lock has been
> - *		     acquired.
> + * __pse_pi_disable - Call disable operation and free the power budget of the
> + *		      PI. Assumes the PSE lock has been acquired.
>    * @pcdev: a pointer to the PSE
>    * @id: index of the PSE control
>    *
>    * Return: 0 on success and failure value on error
>    */
> -static int _pse_pi_disable(struct pse_controller_dev *pcdev, int id)
> +static int __pse_pi_disable(struct pse_controller_dev *pcdev, int id)
>   {
>   	const struct pse_controller_ops *ops = pcdev->ops;
>   	int ret;
> @@ -469,6 +469,29 @@ static int _pse_pi_disable(struct pse_controller_dev *pcdev, int id)
>   
>   	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
>   
> +	return 0;
> +}
> +
> +/**
> + * _pse_pi_disable - Disable a PI, then retry the power delivery of the PIs
> + *		     waiting for power in its power domain. Assumes the PSE
> + *		     lock has been acquired.
> + * @pcdev: a pointer to the PSE
> + * @id: index of the PSE control
> + *
> + * The caller must have cleared the admin state or the PD detection of the
> + * PI first, or the retry enables the PI again.
> + *
> + * Return: 0 on success and failure value on error
> + */
> +static int _pse_pi_disable(struct pse_controller_dev *pcdev, int id)
> +{
> +	int ret;
> +
> +	ret = __pse_pi_disable(pcdev, id);
> +	if (ret)
> +		return ret;
> +
>   	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d))
>   		pse_pw_d_retry_power_delivery(pcdev, pcdev->pi[id].pw_d);

Thanks for your fix.
I think, I would prefer to have these two lines moved out of 
_pse_pi_disable() calls than to have another disable function.
Indeed this is not strictly related to the disable call.
This will also simplify your change below.

> @@ -490,7 +513,10 @@ static int pse_disable_pi_pol(struct pse_controller_dev *pcdev, int id)
>   
>   	dev_dbg(pcdev->dev, "Disabling PI %d to free power budget\n", id);
>   
> -	ret = _pse_pi_disable(pcdev, id);
> +	/* The power freed is for the PI being allocated, and this PI waits
> +	 * for power again: no retry of the power domain here.
> +	 */
> +	ret = __pse_pi_disable(pcdev, id);
>   	if (ret)
>   		notifs |= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR;
>   
> @@ -703,14 +729,18 @@ static int pse_pi_disable(struct regulator_dev *rdev)
>   {
>   	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
>   	struct pse_pi *pi;
> +	bool enabled;
>   	int id, ret;
>   
>   	id = rdev_get_id(rdev);
>   	pi = &pcdev->pi[id];
>   	mutex_lock(&pcdev->lock);
> +	/* Disabled before _pse_pi_disable() retries the power domain */
> +	enabled = pi->admin_state_enabled;
> +	pi->admin_state_enabled = 0;
>   	ret = _pse_pi_disable(pcdev, id);
> -	if (!ret)
> -		pi->admin_state_enabled = 0;
> +	if (ret)
> +		pi->admin_state_enabled = enabled;
>   
>   	mutex_unlock(&pcdev->lock);
>   	return 0;
> @@ -1229,10 +1259,12 @@ static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
>   				ret = 0;
>   		}
>   	} else if (notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTION) {
> -		if (pcdev->pi[id].admin_state_enabled &&
> -		    pcdev->pi[id].isr_pd_detected)
> -			ret = _pse_pi_disable(pcdev, id);
> +		bool pd_detected = pcdev->pi[id].isr_pd_detected;
> +
> +		/* Gone before _pse_pi_disable() retries the power domain */
>   		pcdev->pi[id].isr_pd_detected = false;
> +		if (pcdev->pi[id].admin_state_enabled && pd_detected)
> +			ret = _pse_pi_disable(pcdev, id);
>   	}
>   
>   	return ret;

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

