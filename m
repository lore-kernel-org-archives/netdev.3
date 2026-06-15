Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A9F3F4DC6;
	Mon, 15 Jun 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532438; cv=none; b=WrwWPUIHPR9dzRcFXPQUicNEZhu5dHZw8CkYbxhl2486+tha5Z7MbQZ+zeugVZxi0mtj/o1zoBMNCKFs7HQ9l7dYg8agMakJYZP0siKaIhqvxmGz6vtuN+53hOPO4Tut6kc0VhRCCGOMG+pHYGEw2sevYsWdH04SOibyV5I0vCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532438; c=relaxed/simple;
	bh=iunEIKNm11CTXyLswfX8qxc5Ol986Egd0t8gsHMmhrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AKVRdFYElhnkM6cK17eACzqPNlIoiiP4DWBxAqp+xYswdprVZrTAJz9l+J9ox6hmb6aWyyuowHTamVenjEOfPBSXy+c1ryzllg64ma9nTlCmmFYlzK6ReckOqguaD0rALSlbvt24/Hz4ABML0IE2MMyA9hQiqzvoRE3ItEWpoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zdj55i0X; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zdj55i0X"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 54432C5146A;
	Mon, 15 Jun 2026 14:07:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20E3360015;
	Mon, 15 Jun 2026 14:07:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF69D106C96A5;
	Mon, 15 Jun 2026 16:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781532433; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=12cJkgmNpZePALEcCCii3OEhCzXZc//+4qAWWEONSCc=;
	b=zdj55i0XH3giozHt1HpWm9UfrnYusBZsrgy8BIRAXrB12gRGFYttdKWdel5vEcrpKgU3pO
	kBhdbrbf9QdwQ+fPiu2opW/5t31ghiReeLTz6M8Y8J0kWp7gICiIuQG7YVavMSQEiI06nh
	XvF3aocbyXTK/ga1gpylQ0kuKXc0Um1owXiC90x7Ys+HJLXRgCbneEwZiDpMT/vI957D7Q
	/Mj+jd+MV5kLA+KI0SHns+JUCPL7eeozwOQqR9YDjvnN/Pc7ZtsNkSm9VnBjFNVavlxozq
	mJ5t9Eg7cg97pu12QnsGmSdYOCU/VEFxF7+986tvH4yr+YZ/rUitb7n14j6Eew==
Message-ID: <867a39de-ccc2-4dcf-be24-ab2542d20ab6@bootlin.com>
Date: Mon, 15 Jun 2026 16:07:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 05/12] net: phylink: support late PCS provider
 attach
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
 <20260615122950.22281-6-ansuelsmth@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260615122950.22281-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christian,

On 6/15/26 14:29, Christian Marangi wrote:
> Add support for late PCS provider attachment to a phylink instance.
> This works by creating a global notifier for the PCS provider and
> making each phylink instance that makes use of fwnode subscribe to
> this notifier.
> 
> The PCS notifier will emit the event FWNODE_PCS_PROVIDER_ADD every time
> a new PCS provider is added.
> 
> phylink will then react to this event and will call the new function
> fwnode_phylink_pcs_get_from_fwnode() that will check if the PCS fwnode
> provided by the event is present in the pcs-handle property of the
> phylink instance.
> 
> If a related PCS is found, then such PCS is added to the phylink
> instance PCS list.
> 
> Then we link the PCS to the phylink instance and we refresh the supported
> interfaces of the phylink instance.
> 
> Finally we check if we are in a major_config_failed scenario and trigger
> an interface reconfiguration in the next phylink resolve.
> 
> In the example scenario where the link was previously torn down due to
> removal of PCS, the link will be established again as the PCS came back
> and is now available to phylink.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

[...]

> @@ -2151,6 +2204,10 @@ void phylink_destroy(struct phylink *pl)
>  	if (pl->link_gpio)
>  		gpiod_put(pl->link_gpio);
>  
> +	/* Unregister notifier for late PCS attach */
> +	if (pl->fwnode_pcs_nb.notifier_call)
> +		unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);

I wanted to try this out, but I get :

drivers/net/phy/phylink.c:2218:17: error: implicit declaration of function ‘unregister_fwnode_pcs_notifier’; did you mean ‘register_fwnode_pcs_notifier’? [-Werror=implicit-function-declaration]
 2218 |                 unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                 register_fwnode_pcs_notifier

I guess you either need to stub this, or there's a missing Kconfig
dependency somewhere

Maxime



