Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91C4AA033;
	Mon, 19 Oct 2026 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401772; cv=none; b=CPGl7EzY0w4ij9xdGoCC5XI+QkBTqR9M5oATPtcBpXWgqX8KdcdgyrfaoWqRb+D056cH4RIThZJ/JGmGf8DZB/iFdFXG8+tZWPLpM1t0QlyOn8JvMo8YVltQ85D3HXyImk8ddgqbA9rkNRIyZwH7BzMNAprn4OG8VBjiQNFB3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401772; c=relaxed/simple;
	bh=W50cj58I41P0amBD3Gwmn1grFT2/yBXFDueFYbxiJoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmlJ+wqVasLEqFkIWn5wuNOgVVWVoYdSl7Z2okJHTyM5fNBuI3t6ZCyEWIYYHnHwGrtg8Uxesy4a0+JuN+shwYop3XuOd05avXxccdBQ++t5ws04RjDZOeU8jYfTsiXMivPJbk70F9RlUGQcMFzRmtwljIX1ctLvNWORCOXZCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HFj1YThk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HFj1YThk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 213201A1279;
	Mon, 19 Oct 2026 09:22:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E02C460582;
	Mon, 19 Oct 2026 09:22:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8649F10328429;
	Mon, 19 Oct 2026 11:22:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792401766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=aFzwGLSO7+RbqxryM9GCX4O+lQKeiiXFkttu5dRw2bc=;
	b=HFj1YThkrMwCC0zp4DujoOXanRDftrdtowffwYLa58N99pmuWVaGjLS8C8J3Aw7yWHavOW
	sCvDw0xFVDx4l7T7W+eZ/4pRBwoLbRdXOGUnwMus27YkOLkL4Tt4Z84p8EctWyKAhfLjRL
	8cKtFi51W6Go1/BtiFX0R984VjvrHbynIuWtPa9Kpl2kyHL/m2+s/aMzreF4h0iRMFwzg4
	nbkx29hxtIyy2e/9326toXpxjHXK8Fzs2qfyRwXIHP2kG0moKN30L5ANBb07T23asjqwIO
	07dvh+ynhxU6r7eaJwwaDM/QTXl9acy4mmb1zuOd2gyolmNc5y2kp9Rvfn3OYg==
Message-ID: <4d2eeba6-30d9-4628-a755-96a635c6bf42@bootlin.com>
Date: Mon, 19 Oct 2026 11:22:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net 01/10] net: pse-pd: size the notification kfifo after
 defaulting nr_lines
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
 <20261018082314.48950-2-github@szelinsky.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261018082314.48950-2-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/18/26 10:23, Carlo Szelinsky wrote:
> pse_controller_register() allocates the notification kfifo before it
> turns nr_lines == 0 into 1, and kfifo_alloc() fails for a size below 2.
> So a controller with nr_lines 0 or 1 cannot register. pse_regulator
> (podl-pse-regulator) never sets nr_lines, so its probe has failed with
> -EINVAL ever since the kfifo was added.
> 
> Apply the default first, and allocate at least two entries.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

> Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
> ---
>   drivers/net/pse-pd/pse_core.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index a5e6d7b26b9f..c0573cbbba5b 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1044,16 +1044,19 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>   	mutex_init(&pcdev->lock);
>   	INIT_LIST_HEAD(&pcdev->pse_control_head);
>   	spin_lock_init(&pcdev->ntf_fifo_lock);
> -	ret = kfifo_alloc(&pcdev->ntf_fifo, pcdev->nr_lines, GFP_KERNEL);
> +
> +	if (!pcdev->nr_lines)
> +		pcdev->nr_lines = 1;
> +
> +	/* kfifo_alloc() rejects a size that rounds up to less than 2 */
> +	ret = kfifo_alloc(&pcdev->ntf_fifo, max(pcdev->nr_lines, 2U),
> +			  GFP_KERNEL);
>   	if (ret) {
>   		dev_err(pcdev->dev, "failed to allocate kfifo notifications\n");
>   		return ret;
>   	}
>   	INIT_WORK(&pcdev->ntf_work, pse_send_ntf_worker);
>   
> -	if (!pcdev->nr_lines)
> -		pcdev->nr_lines = 1;
> -
>   	if (!pcdev->ops->pi_get_admin_state ||
>   	    !pcdev->ops->pi_get_pw_status) {
>   		dev_err(pcdev->dev,

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

