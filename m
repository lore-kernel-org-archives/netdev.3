Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C40484254;
	Tue, 18 Aug 2026 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073030; cv=none; b=Hr2wiEhlYPcfO6rZ0lfhHLvIssm9aCyL7zW4+/bJm6n1yvk7TVlqKzWunBS8GW2iotaiUIDLfp8w65zqeeOWm5QIX46A9N419pCcVPgmuigfo375Lo/L62d5hTJ5gpqSwOsDmW31HPxx8pgDj2F0wnAyn26GGoOrRZi69ySf9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073030; c=relaxed/simple;
	bh=xkpL7PqZOLYz3ht2yPI9zd6uUAwuLySAyoczyWVQTVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mA8QRB6OeciaApQeMGzVX0ub/1qMBdcc4HVAr3hl/tvzewEU7ZY5Z7Jjfq6Tr9VOuEEU89f80RNVn2GSgwSrgX6e3izycNfbLsh8BQk7OLon1U3KdYPa8UTiseGdofBbeY6Rbj/gdxC7gxYRMp/Dc4kJ//jmu3XcU/HNRCOwT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHh9mS9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHh9mS9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A711F000E9;
	Tue, 18 Aug 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787073028;
	bh=36y6QDrRgKutYaFettVVkQbkxfnmq6Z/p9tAv/2+gwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iHh9mS9uXgLgCQ1gOwHxJZxYcvSAQc+Ben+ex/PoZMq0PyGt6Awotgk3uhQyXHWlj
	 ar6hjNq+S2Zu80dASDLNxm1eKXZkbJpFYQgxRioXKLj/cHVwAOe6JN2mocAGYLeQJT
	 yWIoEds3eQN1lEaCUXfPdxh+Jm/xwZ4mSlVvp1v80wGhq4uaM8lkWqr4bB/wnXIvv1
	 3Tj+m+6G4OvPnT+jW+QHBIdiPfDXKNIPuDtETxgrVXdEue7XnH/bNVNQFj04jsfwM5
	 ZmA2ZAzM6U6/65ibxqlVgGG8KA39/MBjMTQSLXtZGp8PFNl2EgTTwsLyJlztszcvat
	 GwwWB99prslPA==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/4] net: dsa: motorcomm: Add LED support
Date: Tue, 18 Aug 2026 10:10:27 -0700
Message-ID: <20260818171027.4020346-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816193905.218112-4-mmyangfl@gmail.com>
References: <20260816193905.218112-4-mmyangfl@gmail.com>
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

This adds a new leds.c to the motorcomm DSA driver which registers up to
three LED class devices per port from the standard DT "leds" child node,
supporting brightness, hardware blink and the netdev hardware-offload
trigger.  Registration happens from the DSA .setup callback and cleanup
from the mdio .remove callback.

A few questions below.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 6dee25b6754a8..553efacd4f5ee 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -4581,6 +4580,12 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
>  	if (res)
>  		return res;
>  
> +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> +	res = yt921x_leds_setup(priv);
> +	if (res)
> +		dev_warn(dev, "Failed to setup LEDs: %d\n", res);
> +#endif
> +
>  	return 0;
>  }

[Severity: Low]
Can this dev_warn() ever be reached?  yt921x_leds_setup() discards the
result of every yt921x_leds_setup_port() call and has a single

	return 0;

as its only exit, so res is always zero here.

Similarly, yt921x_leds_setup_port() returns -EINVAL for
port >= YT921X_LED_PORT_NUM, but that value is dropped by
yt921x_leds_setup().  And inside the for_each_child_of_node_scoped() loop
the return value of yt921x_led_setup() is not stored at all, so a
duplicated group (-EEXIST), a devm_kzalloc() failure (-ENOMEM) or a
devm_led_classdev_register_ext() failure leaves the LED silently absent
with no message in the log.  Was some diagnostic intended for at least the
-EEXIST and -ENOMEM cases?

> @@ -4681,6 +4686,10 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
>  	if (!priv)
>  		return;
>  
> +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> +	yt921x_leds_remove(priv);
> +#endif
> +
>  	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
>  		struct yt921x_port *pp = &priv->ports[i];
>  

[Severity: Medium]
The LEDs are created from ds->ops->setup() (yt921x_dsa_setup) but the only
ordered bulk release lives here in the mdio .remove callback, and
yt921x_dsa_switch_ops has no .teardown.  Are the two other exit paths
covered?

If dsa_register_switch() fails after ds->ops->setup() already succeeded,
yt921x_mdio_probe() returns an error and .remove is never called, so
cleanup falls back to plain devres unwinding.  Each LED has two devres
entries, in the order devm_kzalloc(led) then
devm_led_classdev_register_ext(), so reverse release frees LED N's control
block while LED N-1 is still registered in sysfs and pp->leds[N] still
points at the freed block.  A concurrent write to LED N-1's delay_on then
enters yt921x_led_blink_set(), which reads the siblings:

	if ((change_cycle && pp->leds[i]->use_cycle) ||
	    (change_duty && pp->leds[i]->use_duty))

Is that a read of freed memory?  yt921x_leds_remove_port() deliberately
unregisters everything first, then clears pp->leds[] before devm_kfree(),
which suggests that ordering is required and devres unwinding does not
provide it.

Also, on a DSA tree teardown that leaves the driver bound,
dsa_switch_teardown() has no driver hook here, so the LED class devices
stay registered and user-space-callable while dsa_port_teardown() sets
dp->user = NULL and the chip is reset.  A subsequent tree re-setup
re-initialises nothing, because yt921x_led_setup() bails out early:

	if (pp->leds[group])
		return -EEXIST;

leaving led_cdev->brightness, pp->led_duty/led_cycle and
led->use_cycle/use_duty describing a hardware state that no longer exists.
Would a .teardown that calls yt921x_leds_remove() address both cases?

> diff --git a/drivers/net/dsa/motorcomm/leds.c b/drivers/net/dsa/motorcomm/leds.c
> new file mode 100644
> index 0000000000000..e7ef0ef80a266
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/leds.c
> @@ -0,0 +1,654 @@

[ ... ]

> +static int
> +yt921x_led_force_set(struct yt921x_priv *priv, int port, int group, bool on)
> +{
> +	struct yt921x_port *pp = &priv->ports[port];
> +	struct yt921x_led *led = pp->leds[group];
> +	u32 ctrl;
> +	u32 mask;
> +
> +	led->use_cycle = false;
> +	led->use_duty = false;
> +
> +	mask = YT921X_LED2_PORT_FORCEn_M(group);
> +	ctrl = on ? YT921X_LED2_PORT_FORCEn_ON(group) :
> +	       YT921X_LED2_PORT_FORCEn_OFF(group);
> +	return yt921x_reg_update_bits(priv, YT921X_LED2_PORTn(port), mask,
> +				      ctrl);
> +}

[Severity: Low]
Should use_cycle/use_duty only be cleared once the register update has
succeeded?  If the SMI/MDIO transfer in yt921x_reg_update_bits() fails,
the LED keeps hardware-blinking while the driver records that this group no
longer uses the shared per-port duty and cycle fields.

The same pattern appears in yt921x_led_trigger_set(), which clears both
flags before two fallible yt921x_reg_update_bits() calls and never
restores them on failure.

[ ... ]

> +	/* The chip seems to jam a while if changing duty directly */
> +	res = yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &val);
> +	if (res)
> +		return res;
> +
> +	ctrl = val & ~YT921X_LED2_PORT_FORCEn_M(group);
> +	ctrl |= YT921X_LED2_PORT_FORCEn_DONTCARE(group);
> +	if (val != ctrl) {
> +		res = yt921x_reg_write(priv, YT921X_LED2_PORTn(port), ctrl);
> +		if (res)
> +			return res;
> +	}

[ ... ]

> +	res = yt921x_reg_update_bits(priv, YT921X_LED1_PORTn(port), mask, ctrl);
> +	if (res)
> +		return res;

[Severity: Low]
This is a multi-register sequence: FORCE is first switched to DONTCARE, so
the LED immediately follows whatever activity bits happen to be programmed,
then the shared YT921X_LED1_PORTn duty and OTHER_BLINK fields are updated,
then forced blinking is selected.  Both intermediate error returns leave
the earlier writes in place with no unwind.

Since the conflict check earlier in this function trusts use_cycle and
use_duty to decide whether another group owns the shared timing fields, can
a later request silently retime a sibling LED that is still blinking, or
leave an LED driven by stale activity bits?

[ ... ]

> +static struct device * __maybe_unused
> +yt921x_cled_hw_control_get_device(struct led_classdev *led_cdev)
> +{
> +	struct yt921x_led *led = to_yt921x_led(led_cdev);
> +	struct yt921x_port *pp = to_yt921x_port(led);
> +	struct yt921x_priv *priv = to_yt921x_priv(pp);
> +	struct dsa_port *dp;
> +
> +	dp = dsa_to_port(&priv->ds, pp->index);
> +	if (!dp)
> +		return NULL;
> +
> +	if (dsa_port_is_user(dp))
> +		return &dp->user->dev;
> +	if (dsa_port_is_cpu(dp))
> +		return &dp->conduit->dev;
> +
> +	return NULL;
> +}

[Severity: High]
Should dp->user and dp->conduit be checked for NULL here rather than only
the port type?

dp->type is set at DT parse time, but dp->user is populated later by
dsa_user_create() from dsa_port_setup(), which runs in
dsa_tree_setup_ports() after dsa_tree_setup_switches() has already invoked
ds->ops->setup():

  dsa_tree_setup()
    dsa_tree_setup_switches() -> dsa_switch_setup() -> ds->ops->setup()
      yt921x_dsa_setup() -> yt921x_leds_setup()
    dsa_tree_setup_ports()   -> dsa_port_setup() -> dsa_user_create()

So at LED registration time dp->user is still NULL for user ports and this
returns (char *)NULL + offsetof(struct net_device, dev), which is not NULL.
led_classdev_register_ext() honours linux,default-trigger, so a node with

	linux,default-trigger = "netdev";

runs netdev_trig_activate() synchronously, and there the only guard is a
NULL test:

drivers/leds/trigger/ledtrig-netdev.c:netdev_trig_activate() {
	...
		dev = led_cdev->hw_control_get_device(led_cdev);
		if (dev) {
			const char *name = dev_name(dev);
	...
}

Does dev_name() then dereference that bogus pointer during probe?

The window reopens later as well: dsa_port_teardown() does

	case DSA_PORT_TYPE_USER:
		if (dp->user) {
			dsa_user_destroy(dp->user);
			dp->user = NULL;
		}

while dp->type stays DSA_PORT_TYPE_USER and, with no .teardown in this
driver, the LED class devices remain registered.  A later

	echo netdev > /sys/class/leds/.../trigger

reaches validate_net_dev(), which also only checks if (!dev).

Both peer DSA LED drivers guard the pointer itself, for example
mv88e6xxx_led_hw_control_get_device():

	if (dp->user)
		return &dp->user->dev;
	return NULL;

and qca8k_cled_hw_control_get_device() does the same.

[ ... ]

> +	pp->leds[group] = led;
> +
> +	switch (state) {
> +	case LEDS_DEFSTATE_OFF:
> +	case LEDS_DEFSTATE_ON:
> +	default:
> +		on = state == LEDS_DEFSTATE_ON;
> +		res = yt921x_led_force_set(priv, port, group, on);
> +		break;
> +	case LEDS_DEFSTATE_KEEP:
> +		res = yt921x_led_force_get(priv, port, group, &on);
> +		break;
> +	}

[ ... ]

> +	res = devm_led_classdev_register_ext(dev, led_cdev, &init_data);
> +	if (res)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	ret = res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	if (pp->leds[group]) {
> +		if (force_high || force_low) {
> +			res = yt921x_reg_write(priv, YT921X_LED_PAR_INV, val);
> +			if (res)
> +				dev_warn(dev,
> +					 "Failed to revoke initialization for LED %02d:%02u\n",
> +					 port, group);
> +		}
> +
> +		pp->leds[group] = NULL;
> +	}
> +	mutex_unlock(&priv->reg_lock);
> +
> +	devm_kfree(dev, led);
> +	return ret;
> +}

[Severity: Low]
The FORCE field is programmed for the default on/off state before
devm_led_classdev_register_ext() is called, but the err: path restores only
YT921X_LED_PAR_INV, and only when an explicit active-high/active-low was
given.  Should the previous FORCE field be restored too?

If registration fails (the devres_alloc() -ENOMEM, an -EINVAL from
led_compose_name(), or a device_create_with_groups() failure), the LED is
left forced on or off with no class device through which it can be changed,
and yt921x_leds_setup_port() discards the error so nothing higher up
reports or retries.

> +static int yt921x_leds_setup_port(struct yt921x_priv *priv, int port)
> +{

[ ... ]

> +	for_each_child_of_node_scoped(leds_np, led_np) {
> +		yt921x_led_setup(priv, port, of_fwnode_handle(led_np));
> +		/* Allow partial configuration: LEDs are optional */
> +	}
> +
> +	of_node_put(leds_np);
> +	return 0;
> +}

[ ... ]

> +int yt921x_leds_setup(struct yt921x_priv *priv)
> +{

[ ... ]

> +		yt921x_leds_setup_port(priv, port);
> +		/* Allow partial configuration: LEDs are optional */
> +	}
> +
> +	return 0;
> +}

[Severity: Low]
These two functions are the ones that make the dev_warn() in
yt921x_dsa_setup() unreachable, as noted above.  Is the "LEDs are optional"
policy meant to coexist with that warning, or should one of them go?
