Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A53EBF02;
	Tue, 21 Jul 2026 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655174; cv=none; b=JEFd7JU8fbRIg6LQmwBnmFQeez+TBNF08b9V0EtEDzpgBnXkJLkCQg85lgYGy170J6VqfSmt/1YEatWEZ+XS/VEjza5bzfjmMJ/MXjry/xV3h9rzhDqPKk9doVOTxdSECZQMZT4WxAOk+yQdhWN7YDFsG3nvY4rSsgQPYlt7miY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655174; c=relaxed/simple;
	bh=wkQayWJmLW5+KYmhUWqfY5VB6vy+t0BzTewB/Q29M8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1mlSD8vJ45yGZeWGs5C9mp8ZXiCdeKJE0C5W/pNcFB2WVXAPCW9RKZddRaWoYIXBXMz/oeN2vnRlbkcuLKsp61dZRC39gFYNqR7AV3XuSYaQaKvZqw7H/Le9jDDruG1WkKA9QUsElNnH6uST3CevyN2kjCG37E2BiA8obmoGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht9poUj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht9poUj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B142A1F00A3A;
	Tue, 21 Jul 2026 17:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784655172;
	bh=+tILezz2oFHtMjMEfFuO0XD7zeGAFF3vn5cDnbVb478=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ht9poUj3cIrVUC/apq8M3DGskPj2UkAJrCBnjgpSmv1yZ6gVtREM5ymKDyIeKUzA6
	 gj1IjVCMYmUegmkiCPzeV6fBeXKm1WHgKI0btf9ijZCC3lEgvR0dFmWTR4p8fzIZZ5
	 XwWJPakoE9vkxQZojOI0ayKDrr8GLfxKv6RlxKv0iBiro58KClzHhBQ3YJX+ZP95ab
	 /ipB2bWVya4DtluuIE2N3fef+1o2JQ7HOGWqOeJywg+kXoFUmvaCN33dBoLnWwxakm
	 /C7wn3VYnzR5Jx0Cm29VosmeOhORt2EoquHVAWIo1DCYZOZcuSnTLSTNrhNpJQCqWS
	 oZIHVX9SuoY6g==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: motorcomm: Add LED support
Date: Tue, 21 Jul 2026 10:32:48 -0700
Message-ID: <20260721173248.815203-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709014812.1158178-4-mmyangfl@gmail.com>
References: <20260709014812.1158178-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: motorcomm: Add LED support

This patch adds LED support for the Motorcomm YT9215 DSA switch, allowing
up to 3 LEDs per port to be described in the device tree using a format
similar to qca8k. Only parallel mode and strict 1:1 mapping are supported.

> diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
> index 1fddd386f866..3438e0b14361 100644
> --- a/drivers/net/dsa/motorcomm/Kconfig
> +++ b/drivers/net/dsa/motorcomm/Kconfig
> @@ -6,3 +6,12 @@ config NET_DSA_YT921X
>  	help
>  	  This enables support for the Motorcomm YT9215 ethernet switch
>  	  chip.
> +
> +config NET_DSA_YT921X_LEDS
> +	bool "LED support for Motorcomm YT9215"
> +	default y
> +	depends on NET_DSA_YT921X
> +	depends on LEDS_CLASS=y || LEDS_CLASS=NET_DSA_YT921X

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 6dee25b6754a..553efacd4f5e 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -4581,6 +4580,12 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
>  	if (res)
>  		return res;
>  
> +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> +	res = yt921x_leds_setup(priv);
> +	if (res)
> +		dev_warn(dev, "Failed to setup LEDs: %d\n", res);
> +#endif

[Medium]
When yt921x_leds_setup() fails, the current handling is a dev_warn plus
continue. Looking at the error path inside yt921x_leds_setup():

    for_each_child_of_node_scoped(leds_np, led_np) {
            res = yt921x_led_setup(priv, port,
                                   of_fwnode_handle(led_np),
                                   &inv_mask, &inv_ctrl);
            if (res) {
                    of_node_put(leds_np);
                    goto err;
            }
    }
    ...
err:
    yt921x_leds_remove(priv);

A single malformed subnode on any port (for example reg >= 3, both
active-high and active-low set, or an LED entry attached to the MCU port)
makes yt921x_led_setup() return non-zero, and yt921x_leds_setup() then
tears down every LED that was previously registered on every port. From
the user's perspective this appears as a single dev_warn followed by a
switch that has no working LEDs at all, even on correctly-configured
ports.

Would it be preferable to log the failing LED and continue registering
the rest, so a single DT typo does not disable the whole LED subsystem?

> +#endif
>  
>  	return 0;
>  }
>  
> @@ -4681,6 +4686,10 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/leds.c b/drivers/net/dsa/motorcomm/leds.c
> new file mode 100644
> index 000000000000..46749b57fee3
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/leds.c
> @@ -0,0 +1,630 @@

[ ... ]

> +static const struct yt921x_led_trigger_map yt921x_led_trigger_maps[] = {
> +	{BIT(TRIGGER_NETDEV_LINK),
> +	 YT921X_LEDx_PORT_ACT_DUPLEX_HALF | YT921X_LEDx_PORT_ACT_DUPLEX_FULL},
> +	{BIT(TRIGGER_NETDEV_LINK_10), YT921X_LEDx_PORT_ACT_10M},
> +	{BIT(TRIGGER_NETDEV_LINK_100), YT921X_LEDx_PORT_ACT_100M},
> +	{BIT(TRIGGER_NETDEV_LINK_1000), YT921X_LEDx_PORT_ACT_1000M},
> +	{BIT(TRIGGER_NETDEV_HALF_DUPLEX), YT921X_LEDx_PORT_ACT_DUPLEX_HALF},
> +	{BIT(TRIGGER_NETDEV_FULL_DUPLEX), YT921X_LEDx_PORT_ACT_DUPLEX_FULL},

[ ... ]

> +static int
> +yt921x_led_trigger_get(struct yt921x_priv *priv, int port, int group,
> +		       unsigned long *flagsp)
> +{
[ ... ]
> +	*flagsp = 0;
> +	for (unsigned int i = 0; i < ARRAY_SIZE(yt921x_led_trigger_maps); i++) {
> +		const struct yt921x_led_trigger_map *map = &yt921x_led_trigger_maps[i];
> +
> +		if ((val & map->mask) == map->mask)
> +			*flagsp |= map->flags;
> +	}
> +
> +	return 0;
> +}

[Medium]
Does this iteration over-report the flags for TRIGGER_NETDEV_LINK?

The LINK entry in yt921x_led_trigger_maps sets both DUPLEX_HALF and
DUPLEX_FULL bits. After yt921x_led_trigger_set(LINK) programs the
register with those two bits, yt921x_led_trigger_get() scans every map
entry without breaking:

    /* LINK entry: (val & (HALF|FULL)) == (HALF|FULL)  -> match */
    /* HALF_DUPLEX entry: (val & HALF) == HALF         -> match */
    /* FULL_DUPLEX entry: (val & FULL) == FULL         -> match */

So *flagsp ends up as LINK | HALF_DUPLEX | FULL_DUPLEX rather than just
LINK. Should the map entries with overlapping masks be handled specially,
or should the loop break/clear after a compound match like yt921x_led_
trigger_set() does with flags &= ~map->flags?

[ ... ]

> +int yt921x_leds_setup(struct yt921x_priv *priv)
> +{
[ ... ]
> +	dsa_switch_for_each_port(dp, ds) {
[ ... ]
> +		for_each_child_of_node_scoped(leds_np, led_np) {
> +			res = yt921x_led_setup(priv, port,
> +					       of_fwnode_handle(led_np),
> +					       &inv_mask, &inv_ctrl);
> +			if (res) {
> +				of_node_put(leds_np);
> +				goto err;
> +			}
> +		}
> +
> +		of_node_put(leds_np);
> +	}
> +
> +	mutex_lock(&priv->reg_lock);
> +
> +	mask = YT921X_LED_CTRL_MODE_M | YT921X_LED_CTRL_PORT_NUM_M |
> +	       YT921X_LED_CTRL_EN;
> +	ctrl = YT921X_LED_CTRL_MODE_PARALLEL |
> +	       YT921X_LED_CTRL_PORT_NUM(YT921X_PORT_NUM - 1) |
> +	       YT921X_LED_CTRL_EN;
> +	res = yt921x_reg_update_bits(priv, YT921X_LED_CTRL, mask, ctrl);
> +	if (res)
> +		goto end;
> +
> +	/* Inversion is internal - force on will give low logic.
> +	 * In the rest of the file, treat LEDs as if active-low.
> +	 */
> +	if (inv_mask)
> +		res = yt921x_reg_update_bits(priv, YT921X_LED_PAR_INV, inv_mask,
> +					     inv_ctrl);
> +
> +end:
> +	mutex_unlock(&priv->reg_lock);

[Medium]
The commit message says "strict 1:1 mapping". Where is the port-to-LED
mapping actually being programmed to identity?

The header defines the field macros for these registers:

    #define YT921X_LED_PAR_MAPn(port)	(0xd01d0 + 4 * (port))
    #define  YT921X_LED_PAR_MAP_DSTn_PORT_M(grp)  ...
    #define  YT921X_LED_PAR_MAP_DSTn_PORT(grp, x) ...
    #define  YT921X_LED_PAR_MAP_DSTn_LED_M(grp)   ...
    #define  YT921X_LED_PAR_MAP_DSTn_LED(grp, x)  ...

but there is no writer for YT921X_LED_PAR_MAPn anywhere in the driver.
The 1:1 mapping seems to rely on the reset / bootloader default. If those
values are not identity for some reason, LED operations for port X would
end up steering to a different pin.

Should the driver write an identity mapping into YT921X_LED_PAR_MAPn, or
should the commit message drop the "strict 1:1 mapping" claim?

[Low]
The order in which the LED controller is enabled versus the inversion
register is programmed looks reversed:

    /* enables LED controller first */
    res = yt921x_reg_update_bits(priv, YT921X_LED_CTRL, mask, ctrl);
    ...
    /* programs inversion after */
    if (inv_mask)
            res = yt921x_reg_update_bits(priv, YT921X_LED_PAR_INV, ...);

Per the comment "force on will give low logic", between LED_CTRL_EN
being written and YT921X_LED_PAR_INV being programmed, every
active-high LED with default-state=on would be driven low (LED off)
and only flip to on once the inversion register is written.

If the second write fails, yt921x_leds_remove() is called, which
unregisters classdevs but leaves LED_CTRL_EN set with the wrong
polarity on the physical pins.

Would it be cleaner to program per-LED state and YT921X_LED_PAR_INV
first, and set YT921X_LED_CTRL_EN last?

[High]
Are Documentation/devicetree/bindings updates missing for this change?

The existing binding at
Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml uses
unevaluatedProperties: false and only references
dsa.yaml#/$defs/ethernet-ports for the port schema, which does not
describe a leds subnode. A device tree that uses the new LED feature
would fail make dtbs_check with unevaluated property errors.

Should the YAML be extended to describe the leds subnode and the
per-LED properties reg, active-high, active-low, and default-state that
the driver consumes here?

[Medium]
The driver reads active-high and active-low as boolean properties on
each LED subnode:

    force_high = fwnode_property_read_bool(fwnode, "active-high");
    force_low = fwnode_property_read_bool(fwnode, "active-low");

active-low is a well-established convention used elsewhere (for
example as a GPIO flag), and the common LED subnode binding in
leds/common.yaml does not define active-high/active-low booleans on an
LED node. Since DT properties are ABI once shipped, would it be better
to reuse an already-standard property, or to invent a driver-namespaced
one, so the naming does not collide with existing conventions?
-- 
pw-bot: cr
