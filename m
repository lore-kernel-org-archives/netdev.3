Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5FE4E433F;
	Mon, 19 Oct 2026 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414246; cv=none; b=T+2jxhjmSmJwLDFwH813TyX7YLeLvxrpfUxB+C0fyXwV2X4tRn0QBO1nd6Ge7dmGQIXVYfLMn1SFzWS9slrm8D+0b4oNjw8zETxj+jS8F2jPbSpG46dNo0EckhckRmtnlT2GUqBero7lApYzXF2yo+e0bA3e5AF5YdxLT5b3jHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414246; c=relaxed/simple;
	bh=zCsy6e9Bt2dq/Px6jDSSK5zcyrJRZAo8Uo76I5mQw3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9je5cl/FByfTKcAVrZbeTP/lZabnCArMSR7kCsRREYkfJvtORw8tpGvE6tx+zD4AuD+fV2eHqUsGy2i+78+QgqWTCntZJqdcsxY6fz0KS5qzegmgnTvta0Rjll+n6zO/9Kfv/h+AdTQOJP4yJk+viBHPvfmKlJf00ZZAM4t4UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bmkxdmwg; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bmkxdmwg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6809E4E411CB;
	Mon, 19 Oct 2026 12:50:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3BCD960582;
	Mon, 19 Oct 2026 12:50:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3526C10328D37;
	Mon, 19 Oct 2026 14:50:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792414237; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=k8eO+sIYmJYfoiM/+c7wKwg3jchnyvQXxOnYb69grB8=;
	b=bmkxdmwg3KaQNaN6vE02shBqu1L0emWE7NYvIKnIPY3/Am+RowXdoAetmQS8B374afKzOl
	aNNn9C6MyDpdMVf6dFmeAv47BAp0kfW7qoCyWpZv25zIWfP4kg1FQkpF2u9l4GRRruBZ8S
	dnS53dnWa9czjWRuFib3WK691ecdHp9XR0UxZo0vPsOQ2C7xAF6JQrzZHdR7Woz6ux2Krl
	HZHo7oNU9931vm/H0Ci6WDzsUwST2kPYHB823e8jFBDrFXmq7EuauN3pUe7vjqb7S8czne
	Xh/XTi+IG2e/gJtviiIagByRPio1lfkGJHdcz3NaztjDQ78wfTl36GFXIARgMg==
Message-ID: <d9233496-7549-4c53-b240-344bb7a8d9a5@bootlin.com>
Date: Mon, 19 Oct 2026 14:50:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net 09/10] net: pse-pd: si3474: fix use-after-free in
 ancillary client error path
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
 <20261018082314.48950-10-github@szelinsky.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261018082314.48950-10-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/18/26 10:23, Carlo Szelinsky wrote:
> If devm_add_action_or_reset() fails, it has already unregistered the
> ancillary I2C client, and the error message then reads that client's
> device. It can only fail with -ENOMEM, which is already reported, so
> drop the message.

That's not really a fix but well:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

> Fixes: a2317231df4b ("net: pse-pd: Add Si3474 PSE controller driver")
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
> ---
>   drivers/net/pse-pd/si3474.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/pse-pd/si3474.c b/drivers/net/pse-pd/si3474.c
> index 1845b9c51cf7..2f4f241a48af 100644
> --- a/drivers/net/pse-pd/si3474.c
> +++ b/drivers/net/pse-pd/si3474.c
> @@ -516,10 +516,8 @@ static int si3474_i2c_probe(struct i2c_client *client)
>   		return PTR_ERR(priv->client[1]);
>   
>   	ret = devm_add_action_or_reset(dev, si3474_ancillary_i2c_remove, priv->client[1]);
> -	if (ret < 0) {
> -		dev_err(&priv->client[1]->dev, "Cannot register remove callback\n");
> +	if (ret)
>   		return ret;
> -	}
>   
>   	ret = i2c_smbus_read_byte_data(priv->client[1], VENDOR_IC_ID_REG);
>   	if (ret < 0) {

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

