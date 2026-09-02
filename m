Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B31329C60;
	Wed,  2 Sep 2026 00:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788310581; cv=none; b=DGn5Z887PY5WlmwnDvDB6V9aZ4yupMBEfCNkK1Imqa2WpQAWEk3X7zN/pgIZeORyZRXG41sPXhL7reNxI1aCmu1hcSSFzlZIn/R1fkGJMSgl0YVPxl31Y1xBtu7EWI0/mO7qJajx3yuKJfyhkeu2BD21+Fjby8KDgZtm/pdyUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788310581; c=relaxed/simple;
	bh=e/Sum9l5zbYf0MfNkLEKUWR8X75hA4gRDi7OuRtIIrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dE1GxDoZSl3dOgYH5zJRvSpXWlBhgoeVHXDrMy+MYmY2gqTY2Diu0mXXuec4YSjjGggFuNU3DliNjBTuLwCLnuGbq3NDO687faigliHs7g9PDL9d344esJEKZGqNmPFWIPk2jioHjAWtSoXdwODkdC4Yh543n4w5HRnGvyeUdFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEsu9wI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEsu9wI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5F11F000E9;
	Wed,  2 Sep 2026 00:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788310579;
	bh=bTjhRluqmiYwB/atn5IJkCcuknLjkHr/oL99RfN5JnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WEsu9wI3IGUJBjvzVSrH41H1fMaeHrUlkYtSd60TNV0f0n7vEpquAfZ8JHhTypjL2
	 SbUR20CI6fcejTOo8FowoNQBguLNNAR8vG5kLn2ArBNXXCNvmEgyrLj1bMRZNVdvt8
	 jac55uaC4nhqgWqZNVdzBrP4y/Vr2LcRVq9rp3Zr5LAASdYp5jnh5u1shI4ck3V18n
	 3HRtTUFHS9T1ULVIufgohxWVjV5cRvVBQtKMQN544kza2tWt07+rAO1zepuFMETcQK
	 zMCp2GbOiwaaX3WexSDS1KJPde0NXlnnMsWr+Kel1XqPDBK7fNYCBThSOC+LJtq+71
	 l0U8DabUp11Xw==
Date: Tue, 1 Sep 2026 17:56:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 4/5] net: dsa: motorcomm: Add LED support
Message-ID: <20260901175618.28d81bd6@kernel.org>
In-Reply-To: <20260831044818.4103477-5-mmyangfl@gmail.com>
References: <20260831044818.4103477-1-mmyangfl@gmail.com>
	<20260831044818.4103477-5-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 5

- [Medium] `yt921x_led_blink_set()` (via the `blink_set` callback
  `yt921x_cled_blink_set()`) special-cases only the both-delays-zero=E2=80=
=A6
- [Medium] LED class devices are removed only from the DSA `.teardown`
  callback (`yt921x_dsa_teardown()` =E2=86=92 `yt921x_leds_remove()`), but=
=E2=80=A6
- [Low] Dead error-handling plumbing in the LED setup chain:
  `yt921x_leds_setup()` (drivers/net/dsa/motorcomm/leds.c) ends with an=E2=
=80=A6
- [Low] Concern (assessed false positive): the driver programs only per-
  port LED registers (YT921X_LED0/1/2_PORTn) plus YT921X_LED_PAR_INV and=E2=
=80=A6
- [Low] Concern (assessed resolved later in the series): the driver
  introduces an undocumented DT contract =E2=80=94 a per-port `leds` child =
node,=E2=80=A6
- [Low] `yt921x_led_trigger_get()` (hw_control_get) is not the inverse of
  `yt921x_led_trigger_set()` (hw_control_set): TRIGGER_NETDEV_LINK is=E2=80=
=A6
- [Low] The `revoke`/`revoke_led2` rollback in `yt921x_led_setup()`
  writes back a whole-register snapshot of YT921X_LED2_PORTn(port)=E2=80=A6

--

net: dsa: motorcomm: Add LED support

This adds LED class device support to the Motorcomm yt921x DSA driver, with
up to three LEDs per port described by the standard device tree LEDs
structure, plus hardware offload of the netdev trigger. Only the hardware
default (parallel mode, 1:1 mapping) is handled, and the LEDs are torn down
from a new DSA teardown callback.

A few questions on the new code below.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm=
/chip.c
> index 6dee25b6754a..d663af010f43 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c =20

[ ... ]

> @@ -4225,6 +4224,15 @@ static int yt921x_edata_read(struct yt921x_priv *p=
riv, u8 addr, u8 *valp)
>  	return yt921x_edata_read_cont(priv, addr, valp);
>  }
> =20
> +static void yt921x_dsa_teardown(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> +
> +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> +	yt921x_leds_remove(priv);
> +#endif
> +}
> + =20

[Severity: Medium]

Can removing the LEDs only from the DSA teardown callback leave the LED
class devices registered after the port netdevs have been freed?

net/dsa/dsa.c tears the tree down in this order:

dsa_tree_teardown()
    dsa_tree_teardown_ports()
        dsa_port_teardown()
            dsa_user_destroy(dp->user);   /* ends in free_netdev() */
            dp->user =3D NULL;
    dsa_tree_teardown_switches()
        dsa_switch_teardown()
            ds->ops->teardown(ds)        /* yt921x_leds_remove() */

So between free_netdev() and the dp->user =3D NULL assignment, dp->user is a
dangling pointer while the LEDs are still registered and reachable from
sysfs.

yt921x_cled_hw_control_get_device() reads dp->user / dp->conduit with no
rtnl_lock, no RCU and takes no reference:

	if (dsa_port_is_user(dp))
		return !dp->user ? NULL : &dp->user->dev;

and ledtrig-netdev dereferences the returned device immediately, with
dev_name() in netdev_trig_activate() and to_net_dev() in
validate_net_dev().

Would an "echo netdev > /sys/class/leds/<led>/trigger" racing with switch
unbind, or with the dsa_tree_setup() error path, touch a freed
net_device here? Would removing the LEDs per port before the netdevs go
away, or validating dp->user under rtnl_lock, avoid that?

> @@ -4581,6 +4589,12 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
>  	if (res)
>  		return res;
> =20
> +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> +	res =3D yt921x_leds_setup(priv);
> +	if (res)
> +		dev_warn(dev, "Failed to setup LEDs: %d\n", res);
> +#endif
> + =20

[Severity: Low]

Can this dev_warn() ever be reached? yt921x_leds_setup() in leds.c ends
with an unconditional return 0 and drops the result of
yt921x_leds_setup_port():

	dsa_switch_for_each_port(dp, ds) {
		...
		yt921x_leds_setup_port(priv, port);
		/* Allow partial configuration: LEDs are optional */
	}

	return 0;

yt921x_leds_setup_port() in turn discards every yt921x_led_setup() return
value, so the -EINVAL it produces for port >=3D YT921X_LED_PORT_NUM is also
thrown away.

Should the error be propagated, or should this branch in yt921x_dsa_setup()
be dropped?

> diff --git a/drivers/net/dsa/motorcomm/leds.c b/drivers/net/dsa/motorcomm=
/leds.c
> new file mode 100644
> index 000000000000..7d3c0f68d8ff
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/leds.c
> @@ -0,0 +1,641 @@ =20

[ ... ]

> +static int
> +yt921x_led_blink_select(const struct yt921x_priv *priv, unsigned long on,
> +			unsigned long off, unsigned short *cyclep,
> +			unsigned char *dutyp)
> +{
> +	static const unsigned char dutys[] =3D {
> +		YT921X_LED_DUTY(1, 6),
> +		YT921X_LED_DUTY(1, 4),
> +		YT921X_LED_DUTY(1, 3),
> +		YT921X_LED_DUTY(1, 2),
> +	}; =20

[ ... ]

> +	duty_req =3D DIV_ROUND_CLOSEST(YT921X_LED_DUTY_DENOM *
> +				     (on > off ? off : on), cycle_req);
> +	for (unsigned int i =3D ARRAY_SIZE(dutys) - 1;; i--)
> +		if (i =3D=3D 0 || duty_req >=3D (dutys[i - 1] + dutys[i]) / 2) {
> +			duty =3D dutys[i];
> +			break;
> +		} =20

[ ... ]

> +	if (!*onp && !*offp) {
> +		cycle =3D YT921X_LED_BLINK_DEF;
> +		duty =3D (pp->led_duty_mask & ~BIT(group)) ? pp->led_duty :
> +		       YT921X_LED_DUTY(1, 2);
> +
> +		use_cycle =3D false;
> +	} else {
> +		res =3D yt921x_led_blink_select(priv, *onp, *offp, &cycle, &duty);
> +		if (res)
> +			return res; =20

[Severity: Medium]

What happens when exactly one of *delay_on / *delay_off is zero? The LED
core defines delay_on =3D=3D 0 as steady off and delay_off =3D=3D 0 as stea=
dy on,
but drivers/leds/led-core.c led_blink_setup() returns as soon as
blink_set() succeeds:

	if (!test_bit(LED_BLINK_ONESHOT, &led_cdev->work_flags) &&
	    led_cdev->blink_set &&
	    !led_cdev->blink_set(led_cdev, delay_on, delay_off))
		return;

so led_set_software_blink() and its zero-delay handling never run.

Only the both-zero case is special-cased here. For *onp =3D=3D 0 and
*offp =3D=3D 500, yt921x_led_blink_select() computes duty_req =3D=3D 0, the=
 search
bottoms out at dutys[0] (1/6), and yt921x_led_blink_set() then programs
YT921X_LED1_PORT_BLINK_DUTY_5_6 with _COMP plus
YT921X_LED2_PORT_FORCEn_BLINK(group) and returns 0.

Does the LED then blink at roughly 1/6 duty where a steady off was
requested (and roughly 5/6 for delay_off =3D=3D 0)?

> +	*onp =3D DIV_ROUND_CLOSEST(duty * cycle, YT921X_LED_DUTY_DENOM);
> +	*offp =3D cycle - *onp; =20

These two lines also replace the requested zero with a non-zero value, so
the timer trigger's delay_on / delay_off files report timings user space
never asked for. Would driving the steady states through
YT921X_LED2_PORT_FORCEn_ON / _OFF, or returning -EOPNOTSUPP for a single
zero delay, be preferable?

[ ... ]

> +static const struct yt921x_led_trigger_map yt921x_led_trigger_maps[] =3D=
 {
> +	{BIT(TRIGGER_NETDEV_LINK),
> +	 YT921X_LEDx_PORT_ACT_DUPLEX_HALF | YT921X_LEDx_PORT_ACT_DUPLEX_FULL}, =
=20

[ ... ]

> +	{BIT(TRIGGER_NETDEV_HALF_DUPLEX), YT921X_LEDx_PORT_ACT_DUPLEX_HALF},
> +	{BIT(TRIGGER_NETDEV_FULL_DUPLEX), YT921X_LEDx_PORT_ACT_DUPLEX_FULL}, =20

[ ... ]

> +	*flagsp =3D 0;
> +	for (unsigned int i =3D 0; i < ARRAY_SIZE(yt921x_led_trigger_maps); i++=
) {
> +		const struct yt921x_led_trigger_map *map =3D &yt921x_led_trigger_maps[=
i];
> +
> +		if ((val & map->mask) =3D=3D map->mask)
> +			*flagsp |=3D map->flags;
> +	} =20

[Severity: Low]

Is yt921x_led_trigger_get() intended to be the inverse of
yt921x_led_trigger_set()?

TRIGGER_NETDEV_LINK is encoded as the union of the two duplex masks, and
this read-back loop ORs in the flags of every entry whose mask bits are all
set, with no early break. yt921x_led_trigger_set() instead matches the LINK
entry first and breaks once the flags are consumed.

So a LED programmed with only BIT(TRIGGER_NETDEV_LINK) appears to read back
as LINK | HALF_DUPLEX | FULL_DUPLEX. ledtrig-netdev keeps that value as the
trigger state at activation:

	rc =3D led_cdev->hw_control_get(led_cdev, &mode);
	if (!rc)
		trigger_data->mode =3D mode;

Would /sys/class/leds/<led>/half_duplex and full_duplex then report 1 even
though only link indication was requested?

[ ... ]

> +	if (group >=3D YT921X_LED_GROUP_NUM) {
> +		dev_err(dev, "Invalid LED reg %u for port %d\n", group, port);
> +		return -EINVAL;
> +	} =20

[Severity: Low]

This isn't a bug, but the device tree contract introduced here (a per-port
leds child node, a per-LED reg in 0..2, LEDs only on ports below
YT921X_LED_PORT_NUM) is not described in
Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml by this
commit.

The follow-on patch in the same series, "dt-bindings: net: dsa: yt921x: Add
LEDs definition example", adds the description text and a worked leds
example, so this is only a question about ordering within the series.

What the schema still does not express is a maximum for reg, so a device
tree with led@3 validates cleanly and is rejected only at probe time by the
dev_err() above. Would adding that constraint to the binding be worthwhile?

[ ... ]

> +	led2_val =3D U32_MAX;
> +	res =3D yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &led2_val);
> +	if (res)
> +		goto revoke_led2; =20

[ ... ]

> +	mutex_unlock(&priv->reg_lock); =20

[ ... ]

> +	res =3D devm_led_classdev_register_ext(dev, led_cdev, &init_data);
> +	if (res)
> +		goto revoke;
> +
> +	return 0;
> +
> +revoke:
> +	mutex_lock(&priv->reg_lock);
> +revoke_led2:
> +	if (led2_val !=3D U32_MAX) {
> +		ret =3D yt921x_reg_write(priv, YT921X_LED2_PORTn(port), led2_val); =20

[Severity: Low]

Can this rollback clobber the other LED groups of the same port?

led2_val is a snapshot of the whole YT921X_LED2_PORTn(port) word, taken
before mutex_unlock(&priv->reg_lock) and before
devm_led_classdev_register_ext() runs. That word holds the FORCE and
FORCE_BLINK fields of all three groups, and the groups set up in earlier
loop iterations are already registered class devices reachable from sysfs.

If devm_led_classdev_register_ext() fails (for example -ENOMEM from
devres_alloc()) while a concurrent brightness or delay_on write for a
sibling LED has gone through yt921x_cled_brightness_set_blocking() or
yt921x_cled_blink_set(), does the revoke path write the stale word back and
silently revert that sibling's force/blink state, leaving pp->led_duty,
pp->led_cycle and the masks out of sync with the hardware?

Would re-reading the register under reg_lock and using
yt921x_reg_update_bits() with
YT921X_LED2_PORT_FORCEn_M(group) | YT921X_LED2_PORT_FORCE_BLINKn_M(group)
be safer here?

[ ... ]

> +int yt921x_leds_setup(struct yt921x_priv *priv)
> +{
> +	struct dsa_switch *ds =3D &priv->ds;
> +	struct dsa_port *dp;
> +
> +	/* LEDs are always enabled. There is no way to disable them altogether
> +	 * (as far as I know).
> +	 */ =20

[Severity: Low]

This isn't a bug, just a question about scope: the driver programs only the
per-port registers (YT921X_LED0/1/2_PORTn) and YT921X_LED_PAR_INV, and
never reads YT921X_LED_CTRL, YT921X_LED_PAR_PORTS or the parallel/serial
mapping registers declared in leds.h.

As far as I can tell that is fine, since yt921x_dsa_setup() runs
yt921x_chip_reset() (which writes YT921X_RST_HW, described in the code as
almost the same as a GPIO hard reset) before yt921x_leds_setup(), so the
LED block is back at the parallel mode plus 1:1 mapping default that the
commit message names.

Is a check of YT921X_LED_CTRL_MODE_M worth adding anyway, or is the reset
considered sufficient?
--=20
Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patchse=
t/20260831044818.4103477-1-mmyangfl%40gmail.com
