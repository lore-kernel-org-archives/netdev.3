Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0044E3AAF68;
	Wed,  9 Sep 2026 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935598; cv=none; b=DfFrVUmPh8yzWZl9Jis0jBzxI1/fVLFgaPAQcFZzGnWVasX43XCC0j1my87lhaPuZOgiNFDfLQn9iIYn/CL2hmywl9VsWggPTD/LcSt+DaFnQTzlmawUPAl9mZphcmUnKbu/cVFDsUU4RpbfVa/xx9SXqrztrOJAwVhIs+Mxd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935598; c=relaxed/simple;
	bh=l00oCkrhB8WApv2kI0s93DjO2XwABobiv71k96Z/pKI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bXDhzQy9rvavvSKp37of8WkAkqyLsyzJrmpOlfIhP4QtqfckHS0CFl2JsK9f6WgN5OgrfHhnLHz/9aNWL0s2B5nbVbkSkYSYi+n8/7cTGTKl0zSwSY0+r7upS7kYMrAOWX02SG6/gfY1OWN2ZqyM26ivRjdXqqUnuUIXHn0qzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okNla4MV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okNla4MV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7F81F00A3A;
	Wed,  9 Sep 2026 06:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935596;
	bh=S0bomz74P8D+80x6eEKJyPlObj99M34NHG7wV6ZKtYM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=okNla4MVzJz3oTgtcVtm8L6dxBQwpMJ9/xgwaBkBKqwjCYcFUE994Kno4NtouQsCt
	 JnUNSrsOTj7Iprgp/uZSMm7eyYYoiCiWBTMqZwIbgOwpYV3qQropKOSC8yrlh03RYz
	 F4ms81uyhE9rFkREw3mDB8wExDFYnXEK+dgqbROrH64nFfHh0FX+rJ3tZDm5wPokSY
	 R3649hj/p0EwKB5ArJKKa4xoRlxsszNphB9hYULppV2dJMKvicKjI/ZWEkP+G+ceJf
	 EQtg6NfbPMkfusbtVPV5ZYIG9gpmRUv9maw2AcSolYGRwLDqzJlWF1YHB5scW3+Bwi
	 TvqWqym2u8EeA==
Subject: Re: [PATCH net-next v6 1/5] net: pse-pd: add notifier chain for
 controller lifecycle events
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corey@leavitt.info,
 jelonek.jonas@gmail.com, horms@kernel.org, olek2@wp.pl,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 06:33:15 +0000
Message-ID: <178893559565.219967.17359688741683052582@kernel.org>
In-Reply-To: <20260906153102.959217-2-github@szelinsky.de>
References: <20260906153102.959217-2-github@szelinsky.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Claim: the patch adds a blocking notifier chain and two
  EXPORT_SYMBOL_GPL() entry points…

--

net: pse-pd: add notifier chain for controller lifecycle events

This adds a blocking notifier chain to pse_core along with
pse_register_notifier() and pse_unregister_notifier() as the subscriber
interface, plus enum pse_controller_event describing PSE_REGISTERED and
PSE_UNREGISTERED. Nothing fires the chain and nothing subscribes to it in
this patch.

No Link: tags present in the commit header.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 69dbdbde9d71a..3c4d09f1d6e4f 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -23,6 +24,39 @@ static LIST_HEAD(pse_controller_list);
>  static DEFINE_XARRAY_ALLOC(pse_pw_d_map);
>  static DEFINE_MUTEX(pse_pw_d_mutex);
>  
> +static BLOCKING_NOTIFIER_HEAD(pse_controller_notifier);
> +
> +/**
> + * pse_register_notifier - register a callback for PSE controller events
> + * @nb: notifier block to register
> + *
> + * See enum pse_controller_event for events fired and their subscriber
> + * contract. Callbacks run in process context; they may sleep, take
> + * rtnl, and call of_pse_control_get(). The chain fires synchronously,
> + * so a PSE controller driver's probe/unbind path must not hold any
> + * such lock when calling pse_controller_register() or
> + * pse_controller_unregister().
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int pse_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&pse_controller_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(pse_register_notifier);
> +
> +/**
> + * pse_unregister_notifier - unregister a previously registered callback
> + * @nb: notifier block previously passed to pse_register_notifier()
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int pse_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&pse_controller_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(pse_unregister_notifier);

[Severity: Low]
This isn't a bug, just a note on something that stood out while reading the
patch on its own.

At this commit, pse_register_notifier() and pse_unregister_notifier() in
drivers/net/pse-pd/pse_core.c are exported with no in-tree caller, and the
event-data contract documented for enum pse_controller_event has no producer
yet, so the documented semantics cannot be checked from this patch alone.

Following the series forward, the producer side shows up in the next commit,
with pse_controller_register() and pse_controller_unregister() doing:

	blocking_notifier_call_chain(&pse_controller_notifier,
				     PSE_REGISTERED, pcdev);

	blocking_notifier_call_chain(&pse_controller_notifier,
				     PSE_UNREGISTERED, pcdev);

and the first subscriber lands in phy_init() in drivers/net/phy/phy_device.c:

	rc = pse_register_notifier(&phy_pse_notifier);

Both call sites pass pcdev, which matches what the kerneldoc for enum
pse_controller_event promises, and the commit message states outright that
nothing fires or subscribes yet.

So nothing to fix here, this is the usual "add the API, then use it" split.

[ ... ]

> diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
> index 4e5696cfade7c..78fe3a2b1ea84 100644
> --- a/include/linux/pse-pd/pse.h
> +++ b/include/linux/pse-pd/pse.h

[ ... ]

> @@ -366,6 +385,9 @@ int pse_ethtool_set_prio(struct pse_control *psec,
>  bool pse_has_podl(struct pse_control *psec);
>  bool pse_has_c33(struct pse_control *psec);
>  
> +int pse_register_notifier(struct notifier_block *nb);
> +int pse_unregister_notifier(struct notifier_block *nb);
> +
>  #else

[ ... ]

No other regressions found.  The CONFIG_PSE_CONTROLLER=n stubs returning 0
match the existing stub style in include/linux/pse-pd/pse.h, and placing
enum pse_controller_event outside the IS_ENABLED() guard is consistent with
the stated goal of letting subscribers reference the values in dead-code
paths.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906153102.959217-1-github%40szelinsky.de
