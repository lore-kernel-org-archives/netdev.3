Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B24503ED
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402282; cv=none; b=NgqfF7PHmMjsOjtsXkDNBZt1DiLCd1h2wXJOP5HNC7Q13igl2cyjPr5VcIfBT/4PoTSo+ot2Y20TfArUfEa9Acu3xVwKv+4VPpLTRr8P8kVVoA3bFF/awrkRdljzl7RaSXTZc8/DSzl2o9q2dNs9UtJuq3V9AnMZjwr4gEkFolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402282; c=relaxed/simple;
	bh=LkCV4e9PnURAIXIJVZKGnMMtbhVbo7rALVk+tpoSUdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ac+o8Run6GnmuxKfXZA6KJ7hmPVcOYofkatubWlXiq22xNoR4oyuII7dBMOrJ/TDrfXbXimUQJS+ej3VHAASKOqWZObPdAVhnLxAegnqfcNsze57vnwjg/fdJ/fWu66zQId3SLq1+hYfIT16vFYa+OKuS2U7v3vfiTa+ab5TkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1W3UXTsr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1W3UXTsr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 554DC1A1215;
	Mon, 19 Oct 2026 09:31:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2944360582;
	Mon, 19 Oct 2026 09:31:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C03C10328429;
	Mon, 19 Oct 2026 11:31:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792402278; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=X2xD/Phx8CqyDpzsBmaRAmFFK3I+L4V+k6eK0h6K8Xs=;
	b=1W3UXTsrothYUJSklRhLHuh+wv95KYjxau/JriMWgyDirxaBw1I63Hi7mDx/+mHcfR8zQg
	T6UIf43E6vKTtZdAHNORa14RZkjbW1SL0Cem8kTE1x3IVfv4UYDeMUHNKL//LySg42S0eS
	gmQSQwRI6BBQLGJNALFO0g3tgSKq6arjtsfFZtT+Un1QzDsv0+wYLZAllTFBSc84/i+YDk
	UDWCUtNqMorMvcGdoEFCMR6MBIZ/pNTjWaYCosfuUy/Nt3KQf0yMsR+Boqwg4X8W7TY+XM
	vWZ0sbc+c6p6pnkN2MEea5MHw4dWYa76ytL6NbD2+r0CZCbfKc1qP4LPoc0k1A==
Message-ID: <f80f6620-e0dd-4e1d-9fab-c15725c14ec0@bootlin.com>
Date: Mon, 19 Oct 2026 11:31:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net 02/10] net: pse-pd: fix module refcount leak in
 pse_control_get_internal()
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
 <20261018082314.48950-3-github@szelinsky.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261018082314.48950-3-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/18/26 10:23, Carlo Szelinsky wrote:
> pse_control_get_internal() takes a module reference and then has two
> error paths that skip module_put(): a controller without
> pi_get_admin_state(), and a failing pse_pi_is_hw_enabled(). The second
> one happens on any I2C or UART error. Each time, one more reference
> leaks, and the PSE driver can no longer be unloaded.
> 
> Send both to put_module, like the regulator_get_exclusive() error path.
> 
> Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

As spotted by sashiko you can remove the two checks on 
pi_get_admin_state callback as it is already done in the 
pse_controller_register() function.
Maybe you can do it in a patch before this one even if it is not a fix.
With this change:

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

> ---
>   drivers/net/pse-pd/pse_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index c0573cbbba5b..1710f9bb7d27 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1427,7 +1427,7 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
>   
>   	if (!pcdev->ops->pi_get_admin_state) {
>   		ret = -EOPNOTSUPP;
> -		goto free_psec;
> +		goto put_module;
>   	}
>   
>   	/* Initialize admin_state_enabled before the regulator_get. This
> @@ -1436,7 +1436,7 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
>   	 */
>   	ret = pse_pi_is_hw_enabled(pcdev, index);
>   	if (ret < 0)
> -		goto free_psec;
> +		goto put_module;
>   
>   	pcdev->pi[index].admin_state_enabled = ret;
>   	psec->ps = regulator_get_exclusive(pcdev->dev,

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

