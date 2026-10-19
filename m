Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5342222CC;
	Mon, 19 Oct 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413967; cv=none; b=ZQeIHNdj7MtwHWOf7e5P/fmvy4YuxIVcUunYlhFnubnZtwy8soIjUUgZz7wEFMX5MdO8qELNYAYYsKEZXlnBWx6Vao1KktUomMZXIPQwvp+Nc7p4p52zmixa7zqmUyuxhcnslM5YEzfyJE4WNe7WJPSh2OlkGoLilY2JAqT9ZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413967; c=relaxed/simple;
	bh=MO3bBllVtiPwKBNpdwjPHy15QCtLLvmZIeGXkZxxvfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZA+JGWmYV5vEqcWcLkakZcnQ2CDxDZuho17mkCXMW7zMfO+0iSkjSlxuGdsNO0Ctcy1QWnpEqfXGaAJI0uush/wa2anCCtYn3GsP7oLzLlpmhyxL30J1dTbweU4aDLmSVR/8DsDaT1DDFYa/rs/GzIlpi9Nh4WvglcUEq6xEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A6AGPmlQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A6AGPmlQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3F889C653EB;
	Mon, 19 Oct 2026 12:47:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1E0D160582;
	Mon, 19 Oct 2026 12:46:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE1C210328D37;
	Mon, 19 Oct 2026 14:45:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792413961; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3YskPz3UgoOKTWEGXwGt1ZoVBPz2ApBuqNly6OfeUwQ=;
	b=A6AGPmlQ2pS8tcFcQUrgHqEwl4LUiBVobe6lTIuxtL5cqe51qGRV204HJo/wZ0CtTnQJAJ
	sMgJ9Ji2q64nU9G43WhNtXHFxrU+NW5vobIX79/tYj90LhxQJEd+/OSZejH/FNF0m8iaGS
	loLry2MaPTkQ+Fcnn+w0pJ5K2qSFgt7sTM2dAzVR7dT16YvzngpBk08uu5kjqwNOkfZK6g
	I6Tv+WGDSh4cWH7kYaBkqM8s1dMqKGCa6+boLgm4LiRjz/fJxDZwoUeiXy6nherKEYQdpF
	aJq1S6r8szb9KTJeZTzPUfgyl4BroXpABDt7ZwkkrPwhcm3Y98JG8utmmke/HA==
Message-ID: <76248dfd-a193-4a75-9fb3-771cad207cb4@bootlin.com>
Date: Mon, 19 Oct 2026 14:45:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net 07/10] net: pse-pd: pd692x0: release the manager power
 budget through devres
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
 <20261018082314.48950-8-github@szelinsky.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261018082314.48950-8-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/18/26 10:23, Carlo Szelinsky wrote:
> pd692x0 reserves a power budget on each manager's supply in
> setup_pi_matrix(), but gives it back only on that function's own errors
> and in remove(). If probe fails later, or the request fails for one
> manager after others succeeded, the budget stays reserved on vmain. Each
> probe retry, e.g. after -EPROBE_DEFER, reserves it again until nothing
> is left.
> 
> Release the budget from a devm action instead, and drop the explicit
> release calls.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

> Fixes: 1c67f9c54cdc ("net: pse-pd: pd692x0: Fix power budget leak in manager setup error path")
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
> ---
>   drivers/net/pse-pd/pd692x0.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
> index 209de9cec849..34f0dfbccd06 100644
> --- a/drivers/net/pse-pd/pd692x0.c
> +++ b/drivers/net/pse-pd/pd692x0.c
> @@ -1224,8 +1224,9 @@ static void pd692x0_of_put_managers(struct pd692x0_priv *priv,
>   	}
>   }
>   
> -static void pd692x0_managers_free_pw_budget(struct pd692x0_priv *priv)
> +static void pd692x0_managers_free_pw_budget(void *data)
>   {
> +	struct pd692x0_priv *priv = data;
>   	int i;
>   
>   	for (i = 0; i < PD692X0_MAX_MANAGERS; i++) {
> @@ -1279,31 +1280,39 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
>   	if (ret)
>   		goto err_of_managers;
>   
> +	/* Frees whatever pd692x0_req_managers_pw_budget() manages to
> +	 * request, on any later probe failure and on unbind. Added after
> +	 * the manager regulators so that it runs before devres unregisters
> +	 * them and their supply goes away.
> +	 */
> +	ret = devm_add_action_or_reset(&priv->client->dev,
> +				       pd692x0_managers_free_pw_budget, priv);
> +	if (ret)
> +		goto err_of_managers;
> +
>   	ret = pd692x0_req_managers_pw_budget(priv);
>   	if (ret)
>   		goto err_of_managers;
>   
>   	ret = pd692x0_set_ports_matrix(priv, manager);
>   	if (ret)
> -		goto err_managers_req_pw;
> +		goto err_of_managers;
>   
>   	/* Do not init the conf if it is already saved */
>   	if (!priv->cfg_saved) {
>   		ret = pd692x0_hw_conf_init(priv);
>   		if (ret)
> -			goto err_managers_req_pw;
> +			goto err_of_managers;
>   
>   		ret = pd692x0_save_user_byte(priv);
>   		if (ret)
> -			goto err_managers_req_pw;
> +			goto err_of_managers;
>   	}
>   
>   	pd692x0_of_put_managers(priv, manager);
>   	kfree(manager);
>   	return 0;
>   
> -err_managers_req_pw:
> -	pd692x0_managers_free_pw_budget(priv);
>   err_of_managers:
>   	pd692x0_of_put_managers(priv, manager);
>   err_free_manager:
> @@ -1855,7 +1864,6 @@ static void pd692x0_i2c_remove(struct i2c_client *client)
>   {
>   	struct pd692x0_priv *priv = i2c_get_clientdata(client);
>   
> -	pd692x0_managers_free_pw_budget(priv);
>   	firmware_upload_unregister(priv->fwl);
>   }
>   

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

