Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88A41E6C5;
	Thu, 24 Sep 2026 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245280; cv=none; b=UJ50a22T2UFVSUnMwtPToehSVZPTNIq12ouiYh1XRbPQ9fBOBk/wu2u7Ht4min1qpL5pSH7Uj7tG18xH81e9zAQVBEmPRYbyfyotzZ3yClof4ZfgrJxp/ba/5EOgcMT4hLV+eTkGhBw9SHDB25AdjiCMNe/X7eh/bpVDU0v3aD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245280; c=relaxed/simple;
	bh=e6U7HtN7tuHH/q2YTm1qs8PPphQr/V6NMOs5CF87Pc4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iRx636MmA1ee9F0hN323a/EZVz4Hx6lMQhrWJbpPP/AaUAsDsRIxGLGf+LA0BHd1n9hLWfCrAdpPBATctRlJE2EaHuxoE5Fe5xGtayG6Lr9qOD0rKql7T7gQ4ygy9nn9rdxthEwhNnma/qbOcHP1aZaYraF6iiC4dVdDJRDlD+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctGHFJOR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctGHFJOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B093E1F00898;
	Thu, 24 Sep 2026 10:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790245274;
	bh=GaxU7473rtAERe1Snk/CdpzH+KozHodtotBW2wNZyj4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ctGHFJORHgyTYVRW7Z/L+PJ3vLKR2Ajw2Yjj9UHEb+U3Zrf9RCbhI/VR0odGPBimj
	 M1mGPl8hF/Zi7U1nSU3yUdAC3VyCRFARGciGMltyovS7c0Z3NIH3yqN9OUk9gl93UF
	 LBc3g5HB9NTKdh/2a5mnRZsB5p8nD/pwUMqPuy7oeso4YSSRjmg6WF/SJgqsodXT5u
	 UosuFsIKZU+KmyT8xafQx0plemxkB0hnJ1kdeXYyBvyHLaQu9uuGwrBN9/J+foUS2D
	 +rNJCO+8Og/pzQWN5uI/Gif8j/BAd2jx5w9fwKK2zK7QEW8EWhkkV1rwm4NIUBTbrW
	 V/1P7zISnG+ag==
Subject:
 Re: [PATCH net-next 3/3] net: phy: realtek: add LED support for RTL8261C/D
From: netdev-bot+sashiko@kernel.org
To: spolack+git@mailbox.org
Cc: andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, javen_xu@realsil.com.cn, chad@monroe.io,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 10:21:13 +0000
Message-ID: <179024527327.2160803.1269151929435917793@kernel.org>
In-Reply-To: <20260921161817.565185-4-spolack+git@mailbox.org>
References: <20260921161817.565185-4-spolack+git@mailbox.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Asymmetric LED register programming:
  rtl8261x_led_hw_control_set() (drivers/net/phy/realtek/realtek_main.c,…
- [Low] rtl8261x_led_hw_control_get()
  (drivers/net/phy/realtek/realtek_main.c ~2570-2620) reports the…
- [Low] rtl8261x_led_hw_is_supported()
  (drivers/net/phy/realtek/realtek_main.c ~2542-2568) accepts asymmetric…
- [Low] Out-of-range shift evaluated before the bounds check: in both
  rtl8261x_led_hw_control_set() and rtl8261x_led_brightness_set() the…

Pre-existing issues:
- [Low] Claimed non-atomic hardware programming sequence:
  rtl8261x_led_hw_control_set() and rtl8261x_led_brightness_set() each…

--

net: phy: realtek: add LED support for RTL8261C/D

Adds LED callbacks for the RTL8261C/D reusing the RTL8221B LED register
block, with four LEDs, extra 5G/10G link speed bits, a new per-LED output
enable bit and caching of the configured polarity in the private data.
The callbacks are wired into the RTL8261C_CG and RTL8261CE_CG driver
entries.

A few questions below.

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 04d397f0a2d80..b1f020aa77604 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -183,12 +183,15 @@
>  #define RTL822X_VND2_LCR_LINK_100		BIT(1)
>  #define RTL822X_VND2_LCR_LINK_1000		BIT(2)
>  #define RTL822X_VND2_LCR_LINK_2500		BIT(5)
> +#define RTL822X_VND2_LCR_LINK_5000		BIT(6)
> +#define RTL822X_VND2_LCR_LINK_10000		BIT(4)
>  
>  #define RTL822X_VND2_LCR6			0xd040
>  #define RTL822X_VND2_LED_ACT(x)			BIT(x)
>  
>  #define RTL822X_VND2_LCR7			0xd044
>  #define RTL822X_VND2_LED_POLAR(x)		BIT(x)
> +#define RTL822X_VND2_LED_EN(x)			BIT((x) + 4)

[ ... ]

> @@ -305,6 +308,7 @@
>  #define FW_SUB_MAGIC_8261D		0x32363144
>  #define RTL8261X_POLL_TIMEOUT_MS	100
>  #define RTL8261X_MAX_MMD_DEV		31
> +#define RTL8261X_LED_COUNT		4

[ ... ]

> @@ -2530,6 +2539,215 @@ static int rtl822xb_led_brightness_set(struct phy_device *phydev, u8 index,
> +static int rtl8261x_led_hw_is_supported(struct phy_device *phydev, u8 index,
> +					unsigned long rules)
> +{
> +	const unsigned long act_mask = BIT(TRIGGER_NETDEV_RX) |
> +				       BIT(TRIGGER_NETDEV_TX);

[ ... ]

> +	/* RX and TX are not differentiated, they are not possible
> +	 * without combination with a link trigger.
> +	 */
> +	if ((rules & act_mask) && !(rules & link_mask))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}

[Severity: Low]
Should rtl8261x_led_hw_is_supported() also reject asymmetric activity
requests?  As written, LINK|RX without TX (and LINK|TX without RX) passes
validation, but the hardware bit those map to is a single combined
RX/TX activity bit:

rtl8261x_led_hw_control_set()
	act = test_bit(TRIGGER_NETDEV_RX, &rules) ||
	      test_bit(TRIGGER_NETDEV_TX, &rules);

rtl8261x_led_hw_control_get()
	if (val & RTL822X_VND2_LED_ACT(index)) {
		__set_bit(TRIGGER_NETDEV_RX, rules);
		__set_bit(TRIGGER_NETDEV_TX, rules);
	}

Since hw_is_supported() returns 0, the netdev trigger offloads the request
instead of falling back to software blinking, so an rx=1 tx=0 configuration
blinks on transmit as well, which differs from what
Documentation/ABI/testing/sysfs-class-led-trigger-netdev describes for
writing 0 to tx.

rtl8211f_led_hw_is_supported() in the same file handles the same hardware
limitation by rejecting the mismatch:

	/* RX and TX are not differentiated, either both are set or not set. */
	if (!(rules & BIT(TRIGGER_NETDEV_RX)) ^ !(rules & BIT(TRIGGER_NETDEV_TX)))
		return -EOPNOTSUPP;

Would following that variant instead of the rtl822xb one be preferable
here?

> +
> +static int rtl8261x_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				       unsigned long *rules)
> +{
> +	const u16 all_links = RTL822X_VND2_LCR_LINK_10 |
> +			      RTL822X_VND2_LCR_LINK_100 |
> +			      RTL822X_VND2_LCR_LINK_1000 |
> +			      RTL822X_VND2_LCR_LINK_2500 |
> +			      RTL822X_VND2_LCR_LINK_5000 |
> +			      RTL822X_VND2_LCR_LINK_10000;
> +	int val;
> +
> +	if (index >= RTL8261X_LED_COUNT)
> +		return -EINVAL;
> +
> +	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LED(index));
> +	if (val < 0)
> +		return val;
> +
> +	if (val & RTL822X_VND2_LCR_LINK_10)
> +		__set_bit(TRIGGER_NETDEV_LINK_10, rules);

[ ... ]

> +	if (val & RTL822X_VND2_LCR_LINK_10000)
> +		__set_bit(TRIGGER_NETDEV_LINK_10000, rules);
> +
> +	if ((val & all_links) == all_links)
> +		__set_bit(TRIGGER_NETDEV_LINK, rules);

[Severity: Low]
Can this report a rule combination that the netdev trigger itself refuses?
When all six speed bits are set, the per-speed bits stay set and
TRIGGER_NETDEV_LINK is added on top.

netdev_trig_activate() in drivers/leds/trigger/ledtrig-netdev.c takes the
bitmap verbatim:

	rc = led_cdev->hw_control_get(led_cdev, &mode);
	if (!rc)
		trigger_data->mode = mode;

and netdev_led_attr_store() rejects that same combination:

	if (test_bit(TRIGGER_NETDEV_LINK, &mode) &&
	    (test_bit(TRIGGER_NETDEV_LINK_10, &mode) || ... ))
		return -EINVAL;

So with an all-speeds hardware configuration, would every subsequent write
to link_10 ... rx/tx/full_duplex fail with -EINVAL until the user clears
link?  Should the getter clear the per-speed bits when it sets
TRIGGER_NETDEV_LINK?

The same pattern already exists in rtl822xb_led_hw_control_get() and
rtl8211e_led_hw_control_get(), so any canonicalisation probably belongs
there too, but this patch adds a new instance.

> +
> +	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR6);
> +	if (val < 0)
> +		return val;
> +
> +	if (val & RTL822X_VND2_LED_ACT(index)) {
> +		__set_bit(TRIGGER_NETDEV_RX, rules);
> +		__set_bit(TRIGGER_NETDEV_TX, rules);
> +	}
> +
> +	return 0;
> +}

[Severity: Low]
Should rtl8261x_led_hw_control_get() also look at LCR7?  It reads only
RTL822X_VND2_LED(index) and the LCR6 activity bit, while
rtl8261x_led_hw_control_set() is the only place that programs
RTL822X_VND2_LED_EN(index), so the get path cannot tell whether the output
driver is actually enabled.

The commit message says the enable bit is one "which firmware normally
leaves set already".  If a board boots with link condition bits set but the
enable bit clear, netdev_trig_activate() imports those rules and also does:

	trigger_data->hw_control = true;
	...
	rc = led_cdev->hw_control_get(led_cdev, &mode);
	if (!rc)
		trigger_data->mode = mode;

without calling hw_control_set(), so nothing re-asserts the enable bit.
Would the LED then stay dark while userspace is told the triggers are
offloaded, with software blinking suppressed as well?  Should a clear
enable bit be reported as not offloaded?

> +
> +static int rtl8261x_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				       unsigned long rules)
> +{
> +	struct rtl8261x_priv *priv = phydev->priv;
> +	u16 lcr7 = RTL822X_VND2_LED_EN(index);
> +	u16 val = 0;
> +	bool act;
> +	int ret;
> +
> +	if (index >= RTL8261X_LED_COUNT)
> +		return -EINVAL;

[Severity: Low]
Is the shift in the initialiser evaluated before index is validated?
RTL822X_VND2_LED_EN(index) expands to UL(1) << (index + 4), and it runs
ahead of the index >= RTL8261X_LED_COUNT test.  The same ordering appears in
rtl8261x_led_brightness_set().

index comes from the DT LED node reg property, and of_phy_led() in
drivers/net/phy/phy_device.c only bounds it at U8_MAX:

	err = of_property_read_u32(led, "reg", &index);
	if (err)
		return err;
	if (index > U8_MAX)
		return -EINVAL;

So a device tree with led@3c or higher registers a LED classdev whose
brightness write reaches this initialiser with a shift count of 64 or more
on an unsigned long, which is undefined behaviour and should produce a
UBSAN shift-out-of-bounds report.  Can the initialisation be moved below the
bounds check?  The existing rtl822xb_* and rtl8211e_* callbacks compute
their masks only after validating index.

[ ... ]

> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
> +			    RTL822X_VND2_LED(index), val);
> +	if (ret < 0)
> +		return ret;
> +
> +	act = test_bit(TRIGGER_NETDEV_RX, &rules) ||
> +	      test_bit(TRIGGER_NETDEV_TX, &rules);
> +
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR6,
> +			     RTL822X_VND2_LED_ACT(index), act ?
> +			     RTL822X_VND2_LED_ACT(index) : 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable the output and restore the configured polarity, which
> +	 * led_brightness_set() may have used as a level.
> +	 */
> +	if (priv->led_active_low & BIT(index))
> +		lcr7 |= RTL822X_VND2_LED_POLAR(index);
> +
> +	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR7,
> +			      RTL822X_VND2_LED_EN(index) |
> +			      RTL822X_VND2_LED_POLAR(index), lcr7);
> +}

[Severity: Low]
This isn't a bug introduced by this patch, but the three MDIO transactions
here (per-LED link conditions, LCR6 activity, LCR7 enable/polarity) return
on the first failure without undoing the earlier writes, so a mid-sequence
failure leaves the LED enabled with new link conditions, stale activity
state and the manual-mode polarity level.  On the success path the LED is
also briefly inverted between the first and the last write because LCR7's
polarity bit doubles as the manual level.

rtl822xb_led_hw_control_set() and rtl822xb_led_brightness_set() already
use the same unwound sequence on the same register block, so this is the
existing convention in the driver rather than something new, and the same
applies to rtl8261x_led_brightness_set() here.  Worth noting only in case a
rollback or a quiesce-first ordering is wanted for the new callbacks.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921161817.565185-1-spolack%2Bgit%40mailbox.org
