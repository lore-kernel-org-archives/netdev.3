Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449A463B88;
	Mon, 28 Sep 2026 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582022; cv=none; b=UK5rtsYgaaaTWhezrRPRa7hFk7CkfjZ5H9goI4QkgiMjzvgnGBaCCF/QEoO0Tp9xr1+7Eg8JV5v+wB+sjLSFKDV7LRKVVlcZixWSWFTgGGJDpVPFP1tkeJDhYhbYbE0sdMhRecccEOScF8009OV+646EMul6/fPXrr8QXZT8rdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582022; c=relaxed/simple;
	bh=aStAMvaBalBbhKTlUjWcUwuyLZfmwW32Am0dYgSB3AE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bsC9mEEtgHsapNXJo1yz4Hv5EGsWdo2wyKbnIyVhPp7OkWrEKqtzR6+cp8EPg03WOiRvobaHJVLnNpBouoZtYvjXD04DOXPEBFPHwRWDhThwQ3JVJrpVaqD+xSvZJul2RnCOLFp6sdVVtoQnaQyoNDeIvKWZ31dmFq6tA1/pOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9oVkfWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9oVkfWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD7B1F00898;
	Mon, 28 Sep 2026 07:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582021;
	bh=psadr9fQ+NadJ8uxSGav7B40nvRH4qxURO032nWTVI8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H9oVkfWiSU9tDGxMLpd/DspVGuDY3CUUe6Yp7FcjWKXbN8445OfiNG3AiXBHLqohD
	 u1gAgxekqN38z5oyI+eJ2ldMVoYXmsbIMMall0u3iJEdK3QgvyW4THdK689XoWgRm5
	 VXF8c6ozyiDNkQ9HRHWHbMj579zvN1ci7s/y2BLDNaxCZhzvk3xJqE7HAuyk1gfS+1
	 pdKuRli70ziBLKOO3Uq5/HSGBfPT1UmkfPkuN0henINyd6Gqi9Zb78K8/Y4JB/7Hwu
	 lRuzAyK5BPVm+ICHR2H9FZHlHqwEIbOpDHaX8/swI/Z7H+NoeuSxRP1tHvpXys7vQn
	 E2ieI7YVVcwmg==
Subject: Re: [PATCH net-next v21 2/3] net: phy: Add support for Template
 Control register for PMA
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Date: Mon, 28 Sep 2026 07:53:39 +0000
Message-ID: <179058201980.3145.8006245864829581529@kernel.org>
In-Reply-To: <20260924075048.4060414-3-kyle.switch@motor-comm.com>
References: <20260924075048.4060414-3-kyle.switch@motor-comm.com>
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

- [Low] The naming doesn't match the register.
- [Low] The patch adds a new UAPI constant, `#define
  MDIO_PMA_10GBT_TESTMODE_MASK GENMASK(15, 13)`, at…
- [Low] phy-c45: genphy_c45_template_testmode() returns -EOPNOTSUPP for
  invalid argument

--

net: phy: Add support for Template Control register for PMA

This adds definitions to the uapi mdio.h header for the 10GBASE-T PMA
test mode register (1.132) and its test mode field. It also adds a
genphy_c45_template_testmode() helper in drivers/net/phy/phy-c45.c,
which writes one of the modes Normal or TestMode1..TestMode7 into that
field.

> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index 06f4bc3c20c7..353ca13c64fc 100644
> --- a/include/uapi/linux/mdio.h
> +++ b/include/uapi/linux/mdio.h
> @@ -63,6 +63,7 @@
>  /* Media-dependent registers. */
>  #define MDIO_PMA_10GBT_SWAPPOL	130	/* 10GBASE-T pair swap & polarity */
>  #define MDIO_PMA_10GBT_TXPWR	131	/* 10GBASE-T TX power control */
> +#define MDIO_PMA_10GBT_TESTMODE 132 /* Test mode control */

[Severity: Low]
This isn't a bug, but is "Template" the right name here?

The word "Template" appears in three places:

  - The subject line: "Add support for Template Control register for
    PMA".
  - The new exported helper: genphy_c45_template_testmode() in
    drivers/net/phy/phy-c45.c.
  - The comment on every new field define.

IEEE 802.3 calls register 1.132 the 10GBASE-T test mode register, and
bits 15:13 "Test mode control". The define above already uses that
wording.

"Template" looks like vendor wording, and it becomes part of a generic
exported phylib symbol. Would names based on the standard terminology
work better for the helper and the subject line?

There are also a few small style nits:

  - This define uses spaces where the defines around it are
    tab-aligned.
  - The new MDIO_PMA_10GBT_TESTMODE_* field defines are not
    tab-aligned either.
  - The comment "/* PMA 10GBASE-T Template Test Mode Register*/" has no
    space before the terminator.

[ ... ]

> @@ -320,6 +321,17 @@
>  /* PMA 10GBASE-R Fast Retrain status and control register. */
>  #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
>  
> +/* PMA 10GBASE-T Template Test Mode Register*/
> +#define MDIO_PMA_10GBT_TESTMODE_MASK GENMASK(15, 13) /* Template test mode */

[Severity: Low]
Can userspace actually use this new mask?

GENMASK() is kernel-internal and comes from include/linux/bits.h. The
exported include/uapi/linux/bits.h only provides __GENMASK(),
__GENMASK_ULL() and __GENMASK_U128().

This header only includes <linux/types.h> and <linux/mii.h>, and
neither of them provides GENMASK.

So a userspace program that includes <linux/mdio.h> and uses
MDIO_PMA_10GBT_TESTMODE_MASK would fail to build, because GENMASK is
undeclared. The UAPI header compile test won't catch this, since the
macro is only expanded where it is used.

The MDIO_AN_C73_* masks in this header already have the same problem.
This patch adds another exported symbol that depends on it, though.

Could this use a literal 0xe000, or __GENMASK(15, 13) from
<linux/bits.h>, instead?

[ ... ]

> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -1408,6 +1408,29 @@ int genphy_c45_fast_retrain(struct phy_device *phydev, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(genphy_c45_fast_retrain);
>  
> +/**
> + * genphy_c45_template_testmode - configure template testmode registers
> + * @phydev: target phy_device struct
> + * @test_mode: testmode includes Normal to Test mode 7
> + *
> + * Description: Set template testmode include Normal to Test mode 7
> + *
> + * Return: 0 on success, or a negative error code on failure (e.g. register
> + * read/write error).
> + */
> +int genphy_c45_template_testmode(struct phy_device *phydev, u16 test_mode)
> +{
> +	u16 ctrl;
> +
> +	if (test_mode > MDIO_PMA_10GBT_TESTMODE_7)
> +		return -EOPNOTSUPP;
> +
> +	ctrl = FIELD_PREP(MDIO_PMA_10GBT_TESTMODE_MASK, test_mode);
> +	return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_10GBT_TESTMODE,
> +			      MDIO_PMA_10GBT_TESTMODE_MASK, ctrl);
> +}
> +EXPORT_SYMBOL_GPL(genphy_c45_template_testmode);
> +
>  /**
>   * genphy_c45_plca_get_cfg - get PLCA configuration from standard registers
>   * @phydev: target phy_device struct

[Severity: Low]
Should this return -EINVAL rather than -EOPNOTSUPP?

A test_mode above MDIO_PMA_10GBT_TESTMODE_7 cannot be encoded in the
3-bit MDIO_PMA_10GBT_TESTMODE_MASK field at all. That makes it a bad
argument from the caller of genphy_c45_template_testmode(), not a
feature the PHY lacks.

-EOPNOTSUPP reads as "this PHY does not support test modes". Suppose
a driver logs the error or passes it up towards userspace. The person
debugging it would then look at the hardware instead of at the caller
that passed the bad value.

Elsewhere in phylib, -EOPNOTSUPP is generally used for a missing
capability and -EINVAL for out-of-range arguments. Would -EINVAL fit
better here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924075048.4060414-1-kyle.switch%40motor-comm.com
