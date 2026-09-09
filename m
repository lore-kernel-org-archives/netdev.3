Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116A298CAF;
	Wed,  9 Sep 2026 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973039; cv=none; b=LXQULssgvDpVS2eKOyI/qIazTk0RkD4IYJANg1UrbkPt6jFf8IIU+3I954HsqmlKRP2BQHgdFOv5qdjTyNbeBx9yJkpCyWHQ7DsahzEGAcc2cYypEh9R7Zms23hJR86Ycvplg2BxcWqVLlaiVuukPyAMNPbianDka8hx0VSZceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973039; c=relaxed/simple;
	bh=Vmx0X4nzunNaL7FUjY7UkS9yt6Dza+5LT0xMtWzBaSk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GgayKgTy4TIJSLqhLSbYWTjmaRWE+q65dl+bHmwjJworqkudQ/60P2WmniTUrSYVFrXWVDfB9/InTSPJlYvQ5fIYMepLWvk8neeYcJengwESo0wjUl29+GKXeIkL2P5dm6k0ZvbpnHIYI12lCDP/g23eUDjId11WVTZ9LvjN8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxssZqQ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxssZqQ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00631F000FF;
	Wed,  9 Sep 2026 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973037;
	bh=bAVhB1TR9T/6sa4eS8RCZ3jxJOT8Df+ARcoVYLoq5pk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IxssZqQ8/rZ7Yyxopzlc3VfYRTHj4RJpjZ/0kMrq1b5qcf65t7dPG9KbYrxwOnDMo
	 ymFTQ2hcdjI7rDv3HRKhN5NNRELIp8lMPJHPL9a9c8BTzWVGaMmhwFDVo/UkosdxUp
	 OiVfzkfxtEavaAIUO5mn0l5uOdLKRnexaaCp+0GFZn0pkDRWutDaeWTl6N+/N91roY
	 lc8zouRqgeqXP8jOY5X1sUU1aBWSv1Bw3xqZvByJaefjZ6eWw3otsbhxycuog8KxYF
	 uDr83TuW64uhlpjLk9YBxJNKNxUbCwF2+dhoiw+eXwbDAkUNYP3XU0KFX4ghi2FKSW
	 T9AYJQfMMOytw==
Subject: Re: [PATCH v3 net-next] net: phy: air_en8811h: select LED GPIO pins
 based on AN8811HB package variant
From: netdev-bot+sashiko@kernel.org
To: weiting.lee@airoha.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 bjorn@mork.no, ericwouds@gmail.com, frank-w@public-files.de,
 joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 albert-al.lee@airoha.com
Date: Wed, 09 Sep 2026 16:57:16 +0000
Message-ID: <178897303632.219967.12350879229326827803@kernel.org>
In-Reply-To: <20260907015638.2875763-1-weiting.lee@airoha.com>
References: <20260907015638.2875763-1-weiting.lee@airoha.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] Multi-bit hardware field implicitly cast to a boolean
  evaluates to true for any non-zero value, potentially misidentifying…
- [Low] The commit message states that "Using a fixed GPIO assignment
  causes incorrect LED behavior on one of the variants", i.e. it…
- [Low] The in-file comment at drivers/net/phy/air_en8811h.c:188-192
  documents the default LED-to-GPIO mapping unconditionally ("GPIO5 <->…

--

net: phy: air_en8811h: select LED GPIO pins based on AN8811HB package variant

This patch reads the AN8811HB package variant from the read-only silicon
identification bits in AN8811HB_HWTRAP2 during an8811hb_probe() and stores
it in priv->is_an8811hbcn.  A new helper an8811hb_led_gpio_setup() then
programs either GPIO 0/1/15 (AN8811HBCN) or GPIO 3/4/5 (AN8811HBN) from
an8811hb_config_init().

No Link: tags were present in the commit header.

> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
> index ec7c44ca68e7d..b6eac8dc63d9f 100644
> --- a/drivers/net/phy/air_en8811h.c
> +++ b/drivers/net/phy/air_en8811h.c

[ ... ]

> @@ -1077,10 +1090,49 @@ static int en8811h_leds_setup(struct phy_device *phydev)
>  	return ret;
>  }
>  
> +static int an8811hb_led_gpio_setup(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	int ret;
> +
> +	if (priv->is_an8811hbcn) {
> +		/* AN8811HBCN: LED GPIOs are 0, 1, 15 */
> +		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> +						  AN8811HB_GPIO_OUTPUT_0115,
> +						  AN8811HB_GPIO_OUTPUT_0115);
> +		if (ret < 0)
> +			return ret;

[Severity: Low]

This isn't a bug, but should the LED mapping comment above the trigger
defaults be qualified per package now?

The only in-tree description of which LED index drives which pin sits
above AIR_DEFAULT_TRIGGER_LED0/1/2 and is written unconditionally:

  /* Default LED setup:
   * GPIO5 <-> LED0  On: Link detected, blink Rx/Tx
   * GPIO4 <-> LED1  On: Link detected at 2500 or 1000 Mbps
   * GPIO3 <-> LED2  On: Link detected at 2500 or  100 Mbps
   */

Those same defaults are applied by en8811h_leds_setup(), which is called
from both en8811h_probe() and an8811hb_probe().  After this patch the
GPIO 3/4/5 wording only holds for EN8811H and AN8811HBN, since on
AN8811HBCN the identical trigger defaults now drive pads 0, 1 and 15 via
AN8811HB_GPIO_OUTPUT_0115 plus the SEL1/SEL2 mux codes.

Could the comment mention the AN8811HBCN pin assignment as well?

> +
> +		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL1,
> +						  AN8811HB_GPIO_SEL1_0_MASK |
> +						  AN8811HB_GPIO_SEL1_1_MASK,
> +						  AN8811HB_GPIO_SEL1_0 |
> +						  AN8811HB_GPIO_SEL1_1);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL2,
> +						  AN8811HB_GPIO_SEL2_15_MASK,
> +						  AN8811HB_GPIO_SEL2_15);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		/* AN8811HBN: LED GPIOs are 3, 4, 5 */
> +		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> +						  AN8811HB_GPIO_OUTPUT_345,
> +						  AN8811HB_GPIO_OUTPUT_345);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -1269,10 +1327,11 @@ static int an8811hb_config_init(struct phy_device *phydev)
>  		return ret;
>  	}
>  
> -	/* Restore LED GPIO output enables after MCU initialization. */
> -	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> -					  AN8811HB_GPIO_OUTPUT_345,
> -					  AN8811HB_GPIO_OUTPUT_345);
> +	ret = an8811hb_led_gpio_setup(phydev);
> +	if (ret < 0) {
> +		phydev_err(phydev, "Failed to set up LED GPIO: %d\n", ret);
> +		return ret;
> +	}
>  	return ret;
>  }

[Severity: Low]

Should this carry a Fixes: tag?  The commit message says:

  "Using a fixed GPIO assignment causes incorrect LED behavior on one of
   the variants."

That describes a user-visible defect in code that already shipped, but
there is no Fixes: tag and no stable annotation.

The AN8811HB entry and .config_init = an8811hb_config_init came in with
5afda1d734ed ("net: phy: air_en8811h: add Airoha AN8811HB support"), and
the unconditional AN8811HB_GPIO_OUTPUT_345 write being replaced here was
moved into config_init by 3498acda6b68 ("net: phy: air_en8811h: restore
AN8811HB LED GPIO after MCU restart").

The driver binds with phy_id_compare_model(phydev->phy_id,
AN8811HB_PHY_ID), so AN8811HBCN parts already bind to this driver in
released kernels and get GPIO 3/4/5 forced as outputs while their LEDs
are on GPIO 0/1/15.

If this is a fix for those kernels, could a Fixes: tag be added?  If it
is instead enablement of a newly supported package, could the changelog
be reworded so it does not describe existing behaviour as incorrect?

[ ... ]

> @@ -1115,6 +1167,12 @@ static int an8811hb_probe(struct phy_device *phydev)
>  	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
>  	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
>  
> +	/* Detect package variant */
> +	ret = air_phy_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &reg_val);
> +	if (ret < 0)
> +		goto err_dev_create;
> +	priv->is_an8811hbcn = FIELD_GET(AN8811HB_HWTRAP2_PKG, reg_val);
> +
>  	ret = en8811h_leds_setup(phydev);
>  	if (ret < 0)
>  		goto err_dev_create;

[Severity: Medium]
AN8811HB_HWTRAP2_PKG is GENMASK(14, 12), so FIELD_GET() yields a
3-bit value here, but it is stored straight into the bool
priv->is_an8811hbcn.  Any non-zero package code therefore collapses to
true, which means the whole variant decision in
an8811hb_led_gpio_setup() rests on the unstated assumption that
AN8811HBCN is the only encoding with a non-zero value and AN8811HBN
reads back exactly 0.

If the field can take any other value - a second AN8811HBN encoding, a
reserved code, or a future package - it lands in the
AN8811HB_GPIO_OUTPUT_0115 branch and the driver drives GPIO 0/1/15
plus the SEL1/SEL2 mux for a part whose LEDs are not on those pads.
That failure mode is silent: the LEDs simply do not work, and there is
nothing in the source that documents what the encoding actually is.

Could you define the expected package identifiers as named constants
and compare against them explicitly, e.g. something like

	pkg = FIELD_GET(AN8811HB_HWTRAP2_PKG, reg_val);
	priv->is_an8811hbcn = (pkg == AN8811HB_HWTRAP2_PKG_HBCN);

so that unknown codes fall into the conservative branch rather than
being treated as AN8811HBCN?  If the hardware really only ever reports
two values and 0 is guaranteed to mean AN8811HBN, please say so in a
comment next to the assignment, since the reader cannot tell that from
the mask alone.  Also, is it worth warning (or failing probe) on an
unrecognised package code rather than silently picking a GPIO mapping?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907015638.2875763-1-weiting.lee%40airoha.com
