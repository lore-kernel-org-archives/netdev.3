Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E353EA959;
	Mon, 19 Oct 2026 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389202; cv=none; b=CYsEVXMbx3bQwycd57w9xw/u3odj8vsW19zle27qkIv6SjHcNnpfJPqLyVGxq37EUIugtI2ZeqzfNVSv5Yww7kx7VxYsS06t8NbEDIgk+ZIVAHgZ2Z/lCyFtexPP3LSBhItJEq72fc2XGCDIhpg0Mb8AruSHtiOLonRzLOVhzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389202; c=relaxed/simple;
	bh=pt8mhE6dZft29Uj9twhHXoKoNqe2cTOssS/WtGYVZng=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TRVsQ7TGHEs1ymkyZTvxMrqQGIYBXU3Gx4+JE/m07NzsNf2Rjc2ckAQJpvrUxEFVTwz166TnOkknkKnIlcwd1JCVk3Kz7qpgupqgz296JeCpQ6tDtAnrnsseV5kDUI1v8yZmQvrkltn1lbPKpNzx/uMuEqvc1qRpBBRl1Dab3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl13GN9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl13GN9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0281F000C7;
	Mon, 19 Oct 2026 05:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389087;
	bh=1eccO9mnGN2RUheojVYecrDEYPnMrvf6srRoV0GLCS8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hl13GN9KYJfhOZ9vmcr8SD0NxKAbB376T5dO25CmbB615p6VU+VuFbz65zVN3bIGc
	 OJ9B/WUZzAnt28WTxKk8rPLQim71NAEI9Pr7X1evA3OA6ly2M4NXKJKBefY7R2FJ+A
	 ASDXtFpw70gMlyhAi5P1RbMAuvqw0aIpOf7NEhpY+w4ks/708Bijh6mVf2LaodoJnC
	 Jdxq4Lsj81F0fClTiqxJUPmuEfrTfAQkDfLz3y1MxK7tp2JBLDitIyIFPnBGZPm2t0
	 EKQhw59YwtDnLAfWR/+/Cnq8Szsk7NW1VArtxtlZGtpR66hnYq4CR4i1SvysdXG9+l
	 3gHZCngcQu2ug==
Subject: Re: [PATCH net-next v25 2/3] net: phy: Add support for Template
 Control register for PMA
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
Date: Mon, 19 Oct 2026 05:51:26 +0000
Message-ID: <179238908647.3135.17213221250142957970@kernel.org>
In-Reply-To: <20261015145021.2216003-3-kyle.switch@motor-comm.com>
References: <20261015145021.2216003-3-kyle.switch@motor-comm.com>
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

- [Low] The patch adds a uAPI constant, MDIO_PMA_10GBT_TESTMODE_MASK, to
  include/uapi/linux/mdio.h (line 325) and defines it as GENMASK(15, 13).
- [Low] Several names in this patch use 'Template', which is not the IEEE
  802.3 term: the subject ('Template Control register'), the body…

--

net: phy: Add support for Template Control register for PMA

This commit adds an exported helper, genphy_c45_template_testmode(). The
helper writes the test mode field (bits 15:13) of the 10GBASE-T PMA
register 1.132. It also adds the register and field definitions to the
uAPI mdio.h header.

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

[Severity: Low]
This isn't a bug, but is "template" the right name here? The register
define in this same patch calls it test mode control:

#define MDIO_PMA_10GBT_TESTMODE 132 /* Test mode control */

IEEE 802.3 calls register 1.132 the 10GBASE-T test mode register, and
bits 15:13 are the test mode control field. In 802.3, "template" means
the masks that test mode output is measured against, not the register.

The "Template" wording shows up in the subject and commit message, in
the exported genphy_c45_template_testmode() name and its kerneldoc, and
in the uAPI comments ("Template TestMode1" .. "Template TestMode7").

The exported genphy_c45_* name and the uAPI text are hard to change
after merge. Could they use the standard test mode naming instead?

[ ... ]

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
Will this build for userspace? GENMASK() is only defined in the
kernel-internal include/linux/bits.h. The exported uAPI headers only
provide __GENMASK(), in include/uapi/linux/bits.h.

include/uapi/linux/mdio.h only includes:

#include <linux/types.h>
#include <linux/mii.h>

So a userspace program that includes the installed <linux/mdio.h> and
uses MDIO_PMA_10GBT_TESTMODE_MASK would fail to compile, because
GENMASK is undefined. The kernel build still works because phy-c45.c
gets GENMASK() from kernel headers.

The same file already has this problem with MDIO_AN_C73_0_S_MASK,
MDIO_AN_C73_0_E_MASK and MDIO_AN_C73_1_T_MASK. This patch adds one more
constant of that kind.

Would a literal 0xe000, or __GENMASK() with the matching include, keep
the header self-contained?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015145021.2216003-1-kyle.switch%40motor-comm.com
