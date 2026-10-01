Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8FB4AE8B7;
	Thu,  1 Oct 2026 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848474; cv=none; b=MlQmW9L2ZsXHA+f9EkRYsgEHrRedCp1svUapO5ZE018VtoI58ST6LJxXP2EjNAkgrikE4Gx8Dwo0B9lMTWgidXZDVxtjbxoh87g+yQ6uEAf8fcmsvXmuV5kkkf3valakhnEzybJG4CmhA2yiOm6NtUao3w5yVYDH0/+WGii1D2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848474; c=relaxed/simple;
	bh=KKjwUoAO1X/CGcW0P5CEllMx6x3oqMTV83GgdM0qb74=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=suPepbsqMJ8mQc8IULu8YILqMIxhJpNICUpufxdL324AzXWsKhLlLQf/8nUsgVErblJ2g3dGurk8BkkfRn4KGIIr34OenVO7/UakWTU17Q3ZnXdiqdfvTvyHeanGNWm2Z5Aa4EGx5yxA1mi2D3ZW9GyCM5+x4Ltm17/DfLg6xms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD4pgjqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD4pgjqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5C61F00898;
	Thu,  1 Oct 2026 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790848473;
	bh=/y8TTg/O/t/fL9CJ0mIalajJEQpVKeaPfUYQqhryMKE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kD4pgjqavzrraWVz8b4qCsI5QS0RpDcRe1Piu6H4tJAnUQb3SFtyLFGcWWdtxHrhY
	 vk56wdn6VZ3hse7Or2Y0e5AZMWc0gOISgE3ea8zOKmFtOuGfQX9uLMIgKkzRMUytHL
	 ysf72stQWfxEIytjByzH7v5Ur7HBrQkXN28omK7D8P/c3zJtBlG3qB6clu/Nwkttk8
	 3zMPx460iuZBhw1sNfpW6NPfdHcyUWjeIW7pXl2mntN4egORsOfBpsVGpGTTUcxUsw
	 qSh6+qqscPbHVrJam0X0HomdCEIyEuQJx9zHm1bOa7XlZlIcHsj0dCwuQ3+n1barEO
	 xOXFAjPFpx1bA==
Subject: Re: [PATCH net-next v22 2/3] net: phy: Add support for Template
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
Date: Thu, 01 Oct 2026 09:54:32 +0000
Message-ID: <179084847200.434549.17753348636373360897@kernel.org>
In-Reply-To: <20260929095430.508657-3-kyle.switch@motor-comm.com>
References: <20260929095430.508657-3-kyle.switch@motor-comm.com>
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

- [Low] The new uAPI macro MDIO_PMA_10GBT_TESTMODE_MASK in
  include/uapi/linux/mdio.h is defined as GENMASK(15, 13).
- [Low] net: phy: 'template' is a misnomer for standard 10GBASE-T test
  mode

--

net: phy: Add support for Template Control register for PMA

This commit adds genphy_c45_template_testmode(), which programs the
10GBASE-T PMA template test mode field. It also adds new defines for
the register (132) and for the Normal and TestMode1..TestMode7 values
to include/uapi/linux/mdio.h.

> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index 06f4bc3c20c71..353ca13c64fca 100644
> --- a/include/uapi/linux/mdio.h
> +++ b/include/uapi/linux/mdio.h
> @@ -63,6 +63,7 @@
>  /* Media-dependent registers. */
>  #define MDIO_PMA_10GBT_SWAPPOL	130	/* 10GBASE-T pair swap & polarity */
>  #define MDIO_PMA_10GBT_TXPWR	131	/* 10GBASE-T TX power control */
> +#define MDIO_PMA_10GBT_TESTMODE 132 /* Test mode control */
>  #define MDIO_PMA_10GBT_SNR	133	/* 10GBASE-T SNR margin, lane A.
>  					 * Lanes B-D are numbered 134-136. */

[ ... ]

> @@ -320,6 +321,17 @@
>  /* PMA 10GBASE-R Fast Retrain status and control register. */
>  #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
>  
> +/* PMA 10GBASE-T Template Test Mode Register*/
> +#define MDIO_PMA_10GBT_TESTMODE_MASK GENMASK(15, 13) /* Template test mode */

[Severity: Low]
Is "template" the right name for this helper? IEEE 802.3 calls PMA/PMD
register 1.132 the 10GBASE-T test mode register. As far as I can tell,
the word template is not part of the register's name in the standard.

The same wording shows up in several places:

  - the exported symbol genphy_c45_template_testmode()
  - its kerneldoc
  - the "PMA 10GBASE-T Template Test Mode Register" comment and the
    "Template ..." value comments in include/uapi/linux/mdio.h
  - the subject line ("Template Control register")

The new defines themselves are called MDIO_PMA_10GBT_TESTMODE_*, so the
function name no longer matches the register it programs. Someone
reading the code or grepping for the 10GBASE-T test mode register won't
easily find this helper.

This has no functional impact. Still, once the symbol is exported from
the core PHY library, other drivers may start using it and the name
becomes harder to change.

If template refers to something in the Motorcomm datasheet or in the
test procedure, could you say so in the commit message? Otherwise, would
something like genphy_c45_10gbt_testmode() be closer to the standard's
naming, with the comments and subject line updated to match?

[Severity: Low]
Will userspace be able to use this macro? GENMASK() comes from the
kernel-internal include/linux/bits.h. This uapi header only includes:

#include <linux/types.h>
#include <linux/mii.h>

So a userspace program that includes <linux/mdio.h> and uses
MDIO_PMA_10GBT_TESTMODE_MASK will not compile unless it defines GENMASK
itself.

The MDIO_AN_C73_*_MASK defines in this header already have the same
problem, but this change adds another one to the exported header.

Would __GENMASK(15, 13) from include/uapi/linux/bits.h, or a plain 0xe000,
work better here?

This isn't a bug, but the new register define above uses spaces:

#define MDIO_PMA_10GBT_TESTMODE 132 /* Test mode control */

while the lines around it use tabs to line up the values and comments. The
same goes for the new MDIO_PMA_10GBT_TESTMODE_* value defines.

> +#define MDIO_PMA_10GBT_TESTMODE_NORMAL 0x0 /* Template Normal */
> +#define MDIO_PMA_10GBT_TESTMODE_1 0x1 /* Template TestMode1 */
> +#define MDIO_PMA_10GBT_TESTMODE_2 0x2 /* Template TestMode2 */
> +#define MDIO_PMA_10GBT_TESTMODE_3 0x3 /* Template TestMode3 */
> +#define MDIO_PMA_10GBT_TESTMODE_4 0x4 /* Template TestMode4 */
> +#define MDIO_PMA_10GBT_TESTMODE_5 0x5 /* Template TestMode5 */
> +#define MDIO_PMA_10GBT_TESTMODE_6 0x6 /* Template TestMode6 */
> +#define MDIO_PMA_10GBT_TESTMODE_7 0x7 /* Template TestMode7 */
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929095430.508657-1-kyle.switch%40motor-comm.com
