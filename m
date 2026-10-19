Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCABD4F55D4
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414094; cv=none; b=KEOKY6yPm4Kv+x6wwRoU/MimJRo1WF1iGMOGJsMhZD0WojD7yBjy432E6LbafIhx0/5HMMfxJO39yEC9qZ2AnwB42kRyVUzTrJumgu0VIIcg7P4MYq7EGEiPbkn3J5GpkvPvvt7n0a+TM2lvfwm4EM8okm4bfb6BbfjEOjv7sTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414094; c=relaxed/simple;
	bh=WNFVVnLt668p+IXoSm9G2pDj9eZK4FmdBnGietE1J6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0sCwqJvP8VHJy0sQRMpUdflA+WlmO7iEaNaLRKsjNjWjDILWTyer6XIdCcGQVtHFLPf9f2RcziEiOaGn5Z858Ux7D9jDl6MOR8uDwgoGVJnL4oE/6ibDShxxjK5Vz22+fsHlmPk0uL1jT2SjxZhqIL1jQdyVtGe1/FEHNzJITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IJdxbAu/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IJdxbAu/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8B6F8C653EB;
	Mon, 19 Oct 2026 12:49:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70E3360582;
	Mon, 19 Oct 2026 12:48:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5085110328BE3;
	Mon, 19 Oct 2026 14:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792414085; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=X7aN/1EMOjauQ/SlwtK7yhZJlVa+Q/Enec5Zc+5lc7s=;
	b=IJdxbAu/ur+1VL5PvinQzEaoiDdAiUryLStMcEP9DYOwlsH6vaqq/+5fcLjiLMUszXP2i4
	z2tFWedzDqLdM5ncs94gjw69Ypmun0jxi9JC+BX9SaV751t5w9Mwd9G4PR484oAShjqVyd
	G/bhVyklKUhOBo7wMpd1KSusXK3qgB4LMbggE8rayw44753G10FRa+IzcP9iigwRXlZk+O
	1pf/EOE/Nah1IHTtCaItcYgAJ4uuYvbZB6mf06sYRvynfdKsgzQ28amHnqavTBro4Edxou
	P61W7/Xs4Iawx7mnRUYPKugaYfWtpBopgTvh6bAbrpiPqjT2PdqCcuEzCGKzWg==
Message-ID: <41b5884e-cc3e-450a-b060-abfb8d27912b@bootlin.com>
Date: Mon, 19 Oct 2026 14:47:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net 08/10] net: pse-pd: pd692x0: defer probe while a
 manager supply is unresolved
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
 <20261018082314.48950-9-github@szelinsky.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261018082314.48950-9-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/18/26 10:23, Carlo Szelinsky wrote:
> pd692x0_req_managers_pw_budget() uses each manager regulator's supply
> without a NULL check. The supply is NULL while the vmain regulator is
> described but not registered yet, because regulator_register() does not
> wait for its supply. Probe then crashes.
> 
> Return -EPROBE_DEFER in that case. On net, each retry also leaks the
> notification kfifo and the PI array until vmain appears; the fix for
> that is in the PSE core fixes for net-next.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

> Fixes: 359754013e6a ("net: pse-pd: pd692x0: Add support for PSE PI priority feature")
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
> ---
>   drivers/net/pse-pd/pd692x0.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
> index 34f0dfbccd06..568789bd912f 100644
> --- a/drivers/net/pse-pd/pd692x0.c
> +++ b/drivers/net/pse-pd/pd692x0.c
> @@ -1056,6 +1056,15 @@ pd692x0_req_managers_pw_budget(struct pd692x0_priv *priv)
>   		struct regulator *supply = priv->manager_reg[i]->supply;
>   		int pw_budget;
>   
> +		/* The regulator core registers the manager regulator even
> +		 * when its vmain supply cannot be resolved yet and retries
> +		 * later, leaving ->supply NULL until then.
> +		 */
> +		if (!supply)
> +			return dev_err_probe(&priv->client->dev, -EPROBE_DEFER,
> +					     "manager %d: vmain supply not resolved\n",
> +					     i);
> +
>   		pw_budget = regulator_get_unclaimed_power_budget(supply);
>   		if (!pw_budget)
>   			/* Do nothing if no power budget */

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

