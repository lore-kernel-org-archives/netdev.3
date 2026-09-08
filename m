Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835F329C40;
	Tue,  8 Sep 2026 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788834541; cv=none; b=iTfte1f7uY0bIXNAKVF3Z5nXiGengJ0U0v2MIqCpK+Zr5OH008DUhSY/8ri0LbH+LYC4DqM5+VrPi7XwZM6EtiO3C9h4lBhwPLKWD/dVRuLWbmE/EWEVzPcT17dXXpz5kg21lA+1dpXQ30cKSAwwPpsAZHBiEz9Zq9DAHt8rzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788834541; c=relaxed/simple;
	bh=o/jlZBfcQN48R3SbLyNep0hMHFcbfzUcib9TvlXX//k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sFk3yzpFwBSrajSfZsI8TI95JHndKsdMSBzwvRIWyEDj85dOfzIl3T1GHyJhsC9SM8ZhDuP7aiuotxoE34t7nUyHGkirpDdr/Ak04aVTqvrccr8KpwiT28+JE6aRuVqKX4aSmOClR+0M+4cw0A4ZlCoZ+ONb8hbrPQ6ZKhkYf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig2WQWrZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig2WQWrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC341F00A3A;
	Tue,  8 Sep 2026 02:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788834539;
	bh=nyOpiYX9uH9mrUbxc3R0tHJ2rWsTX6ZOUV7i5/rVwlQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ig2WQWrZBans5lqv5dBxqQJ173R1PzHmacn2mz1Of925baS3caCGl7C3r8LnmMzaG
	 FYyEvUQ5gHxiYzI5SXkEXEidM2UXWyzoJG6GnoYDwRehLuErNJ1Y65iyateNdlMaGd
	 h41jXsu1rKaDnvjq5maN1TKSGG3ZJLO4NbyLxyJ+StJ3AqBHwf356tWhN1H1E0KAGY
	 eObqHfJE3YUrhDlPAeDpZnV0BLm4sCw7STrJfCMEQcFpN4xC5BvWs2DGJJjAOyvQXm
	 b4b/uSClgcTtNaK0hKGK5sx/Ne+KO4dt+7MduX8Ns18V7Vs/4Q/m4qxl857KQUx6qw
	 PJ3azJpQX3n8Q==
Subject:
 Re: [PATCH net] net: phy: dp83867: handle the active-high LED polarity mode
From: netdev-bot+sashiko@kernel.org
To: donggeunyoo.kernel@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 08 Sep 2026 02:28:58 +0000
Message-ID: <178883453869.219967.14274249048169843169@kernel.org>
In-Reply-To: <20260903022839.4006614-1-donggeunyoo.kernel@gmail.com>
References: <20260903022839.4006614-1-donggeunyoo.kernel@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

- [Medium] Incomplete fix of the a274465cc3be regression class: after
  this patch, two other in-tree ->led_polarity_set() implementers still…

Pre-existing issues:
- [Medium] The LEDCR2 polarity bit programmed from DT is written during
  phy_probe() and is then discarded by the driver's own software reset,…
- [Low] dp83867_led_polarity_set() (drivers/net/phy/dp83867.c:1141) uses
  the DT-supplied LED index in DP83867_LED_POLARITY(index) ==…

--

net: phy: dp83867: handle the active-high LED polarity mode

This adds a PHY_LED_ACTIVE_HIGH case to dp83867_led_polarity_set() so that
a device tree LED node carrying the 'active-high' property no longer makes
the callback return -EINVAL and abort phy_probe().  The new case programs
the same polarity bit that the function already uses as its default.

> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index 88255e92b4cd..61a941aa02d9 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c
> @@ -1150,6 +1150,9 @@ static int dp83867_led_polarity_set(struct phy_device *phydev, int index,
>  		case PHY_LED_ACTIVE_LOW:
>  			polarity = 0;
>  			break;
> +		case PHY_LED_ACTIVE_HIGH:
> +			polarity = DP83867_LED_POLARITY(index);
> +			break;
>  		default:
>  			return -EINVAL;
>  		}

[Severity: Medium]
Are there other drivers left with the same problem after this patch?

The commit message lists mxl-gpy and aquantia as the drivers the original
series updated, and presents dp83867 as the one that "was not part of that
series".  Two more ->led_polarity_set() implementers still reject
PHY_LED_ACTIVE_HIGH.

drivers/net/phy/dp83td510.c:dp83td510_led_polarity_set() {
	u16 polarity = DP83TD510E_LED_POLARITY(index);
	...
		case PHY_LED_ACTIVE_LOW:
			polarity = 0;
			break;
		default:
			return -EINVAL;
	...
}

drivers/net/phy/qcom/qca808x.c:qca808x_led_polarity_set() {
	bool active_low = false;
	...
		case PHY_LED_ACTIVE_LOW:
			active_low = true;
			break;
		default:
			return -EINVAL;
	...
}

In both cases the pre-initialised value is already active high, exactly as
in dp83867, so the missing case label is the only difference.  Since
of_phy_led() sets PHY_LED_ACTIVE_HIGH from the device tree property and
of_phy_leds() -> phy_probe() propagate the error, boards with an
'active-high' LED on a DP83TD510 or QCA808x PHY still fail to probe.  All
other implementers (air_an8801, as21xxx, intel-xway, mxl-gpy,
aquantia_leds, mtk-ge-soc) already have the case.

Would it make sense to send this as a small series covering those two as
well, so the class of failures the Fixes: tag refers to is fully closed?

[Severity: Low]
This isn't a bug introduced by this patch, but should
dp83867_led_polarity_set() validate index the way the other LED callbacks
in this driver do?

DP83867_LED_POLARITY(index) expands to BIT((index) * 4 + 2) and is
evaluated three times here (the initialiser, the new active-high case, and
the phy_modify() mask) with no bound check, while the neighbouring
callbacks start with:

drivers/net/phy/dp83867.c:dp83867_led_brightness_set() {
	if (index >= DP83867_LED_COUNT)
		return -EINVAL;
	...
}

drivers/net/phy/dp83867.c:dp83867_led_mode() {
	if (index >= DP83867_LED_COUNT)
		return -EINVAL;
	...
}

The core does not filter this either.  of_phy_led() reads led@N's 'reg'
and only rejects values above U8_MAX before calling led_polarity_set(),
and ethernet-phy.yaml puts no numeric limit on the LED index.

For reg values 4 to 7 the computed bit does not fit in the u16 polarity
variable or the u16 phy_modify() mask, so the read-modify-write becomes a
no-op that still returns success, and the LED classdev is registered as if
the polarity had been programmed.  For larger reg values the shift count in
BIT() reaches the width of the shifted type, which is undefined behaviour
and reported by UBSAN.

Since the patch touches this function anyway, would adding
'if (index >= DP83867_LED_COUNT) return -EINVAL;' at the top be a
reasonable companion change?

[Severity: Medium]
This is a pre-existing issue, but does the polarity programmed here survive
the driver's own soft reset?

This phy_modify() is the only write to the LEDCR2 polarity bits in the
driver, and it runs from phy_probe() -> of_phy_leds() -> of_phy_led().
Afterwards, phy_init_hw() (called from phy_attach_direct() and from MDIO
bus resume) runs the registered .soft_reset:

drivers/net/phy/dp83867.c:dp83867_phy_reset() {
	err = phy_write(phydev, DP83867_CTRL, DP83867_SW_RESET);
	if (err < 0)
		return err;
	...
}

That reset clears registers, which is why dp83867_phy_reset() re-programs
PHYCTRL and DSP_FFE_CFG right after it, and why dp83867_config_init()
re-programs CFG2, the FIFO depth and so on.  Neither of those functions
touches DP83867_LEDCR1 or DP83867_LEDCR2, and struct dp83867_private does
not cache the requested polarity, so an 'active-low' LED ends up running
with the reset default the commit message describes as active high.

The aquantia driver keeps the requested polarity and re-applies it:

drivers/net/phy/aquantia/aquantia_main.c:aqr107_config_init() {
	/* Restore LED polarity state after reset */
	for_each_set_bit(led_idx, &priv->leds_active_low, AQR_MAX_LEDS) {
		ret = aqr_phy_led_active_low_set(phydev, led_idx, true);
	...
}

Would latching the requested polarity in struct dp83867_private and
re-applying it from dp83867_config_init() be the right fix here?  The newly
added active-high case happens to be unaffected only because it programs
the reset default.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903022839.4006614-1-donggeunyoo.kernel%40gmail.com
