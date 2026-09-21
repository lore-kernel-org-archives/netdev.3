Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D658749BD98;
	Mon, 21 Sep 2026 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996680; cv=none; b=ISgKzOk+1ysAjMv/eLUWvXJIub+f64KldwSK2pxHDGs2oeGS3li9UAZ6VrGqjMuzs9/eGP1ukSu6HvSzfgtG4SRxVeun+97dIXDkR+uc3XmqEk0GiWOEvfw7soyYRQYVKYK4N73T9upXTzWevnhyicm/sjAKFledlwl47l449Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996680; c=relaxed/simple;
	bh=qOdwXq7yvAGagsh8UL0vTX0GQp8KoW5iNxGc1BirMg4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DmI7CNxMLc4GQtmkrTx81vLU5R9HbinSE6ZVGzb2xbi9AkII8QcePuLv6FHNdnN+QgnYjw5nSuJ4XAqlT0q9A0EMwKDFyEQWHId2004ZV9yYA/WmyiKI8G1F0jnXulTOVw8vzq8E/VGO15JKX1jVryUzBdmQJGZE3yzUMB/K9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUSMU9MV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUSMU9MV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCEE1F00898;
	Mon, 21 Sep 2026 13:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789996678;
	bh=mnb/qW3GVJmUZbUVtdVGzSfb4kbWmF2jKHn38cZyuq8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UUSMU9MVgqR8juqsFVTW+BrqGuuM9MyNQc2li8zxnyKQv99/BbtmG94rgZyKEevIJ
	 eVhzPGH/aIuZOP0Wjhaiegu0IYnKrgw76YX1OKCDNwWUw+nevap4JTLooVznXuCk4M
	 088nMXb7eUSZqkz83b8rbiAjEKH7zmLdqkypD9fswczBItPnXG7xMbflj9yHk6IS5z
	 j+vvSiAOXWldfHsvdrB1EJBPzDWURjZu0XwWGAu1v8OvAFjG+tTHwTehyFOjMQ/Fzm
	 QGe1/nqPhB7oIndagbUfxdzmQOi/B3xQPM6k9FVOm16+C6GtVOqWMBPPq4fHu28wt0
	 Q8i4aO9Xgf/Ig==
Subject: Re: [PATCH net-next v20 2/3] net: phy: Add support for Template
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
Date: Mon, 21 Sep 2026 13:17:56 +0000
Message-ID: <178999667698.2160803.7178096705095178478@kernel.org>
In-Reply-To: <20260917131441.3428554-3-kyle.switch@motor-comm.com>
References: <20260917131441.3428554-3-kyle.switch@motor-comm.com>
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

- [Low] DISCARDED (resolved later in the series):
  genphy_c45_template_testmode() has no in-tree caller at this commit,…
- [Low] include/uapi/linux/mdio.h:325 defines the newly exported macro
  MDIO_PMA_10GBT_TESTMODE_MASK as GENMASK(15, 13).

--

net: phy: Add support for Template Control register for PMA

This adds a new phylib helper, genphy_c45_template_testmode(), which writes
the 10GBASE-T PMA template test mode field, along with the register and
field definitions in the exported mdio.h header.  Eight values are defined,
Normal plus TestMode1 through TestMode7.

Two small observations below.

> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 870920311f9a0..c5f5753f7194b 100644
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

[Severity: Low]
This isn't a bug, just a note for the record.  At this commit
genphy_c45_template_testmode() has no in-tree caller.

The following patch in the series, "net: phy: Add driver for Motorcomm Quad
2.5GbE phy", adds the consumers, for example in
yt8824_utp_set_template_test_mode():

	return genphy_c45_template_testmode(phydev, test_mode);

along with uses of MDIO_PMA_10GBT_TESTMODE_1 and
MDIO_PMA_10GBT_TESTMODE_NORMAL in yt8824_soft_reset() and
yt8824_restore_working_status(), so the transient state resolves within the
series.

> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index 06f4bc3c20c71..353ca13c64fca 100644
> --- a/include/uapi/linux/mdio.h
> +++ b/include/uapi/linux/mdio.h

[ ... ]

> @@ -320,6 +321,17 @@
>  /* PMA 10GBASE-R Fast Retrain status and control register. */
>  #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
>  
> +/* PMA 10GBASE-T Template Test Mode Register*/
> +#define MDIO_PMA_10GBT_TESTMODE_MASK GENMASK(15, 13) /* Template test mode */

[Severity: Low]
Can userspace expand this new mask?  GENMASK() comes from the kernel-only
include/linux/bits.h, and the exported header only pulls in:

	#include <linux/types.h>
	#include <linux/mii.h>

Neither uapi mii.h nor uapi ethtool.h defines GENMASK or BIT, so a
userspace translation unit that includes <linux/mdio.h> and actually uses
MDIO_PMA_10GBT_TESTMODE_MASK, for instance in a constant initializer, would
fail to compile with GENMASK undeclared.

Would __GENMASK() from include/uapi/linux/bits.h, or a plain 0xe000, be
preferable here?

The in-kernel user in phy-c45.c is unaffected, since it reaches GENMASK and
FIELD_PREP through the in-kernel linux/mdio.h chain.  Note the header
already carries a few bare GENMASK() uses that predate this patch, so this
is an existing wart in the file rather than newly broken userspace, but new
uapi additions probably should not repeat it.

> +#define MDIO_PMA_10GBT_TESTMODE_NORMAL 0x0 /* Template Normal */
> +#define MDIO_PMA_10GBT_TESTMODE_1 0x1 /* Template TestMode1 */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917131441.3428554-1-kyle.switch%40motor-comm.com
