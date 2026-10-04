Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D764A8A0E;
	Sun,  4 Oct 2026 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791148225; cv=none; b=lRNBp992owHJN7/kDMXL+RQTht+8GZhJSyDMc+I9i7Xo4MNEHJl1poouZzfVuFp0jsACjbeMau+y6g4VY00E0opYgHqYNMFQfnSEn9ThjUJnfSTXGz00MvjW50nL2wUkUQKOluPLdpnFEwnaLVUG9MMakmsfcXB+k6DzAo0K3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791148225; c=relaxed/simple;
	bh=NR+V+S1hHVg4M0xSkMGuHjZCR8Xq8unSA+fUayPy5aU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bH9GQ5Ekiy6vsU6R/n5ntUopCdt6/+DiMFRLW0UKDiggJZRjYyzGY/EJBp2vZjAyLQZJEV5JlbMOpXjD0CTZSWUMAw7XGejL4a7XtSkW5z4FuVQzoo26/yZzaXN0CkO9HLz+GT18ZQiGtpnU8ETZw7EPGDkFbHLfcM1dLWkwUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYFjUo+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYFjUo+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A421F00893;
	Sun,  4 Oct 2026 21:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791148223;
	bh=xY0CCZnqFVEeJHdVaxwEIrwj6cFNiVlt8GW2jagg290=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gYFjUo+UGBquwwLz3UrrmvkBVV5uYbO1Ym7HfHtKxJN0HVF7GSmmXz8IkGvnvsbxX
	 4IP5ymw25KMyTQM2sEb5woFBduoeteMg6ZDb4rM2o69hyVG8BQnFj5GqeolblBKw5I
	 m+Wm6FTBXxw3M1pQZw3Dzyg/AcAvwtHLltmTx/8xRa0qTlqzZnZdmm0RlZmVQRi+I/
	 tmFcWRkA+REi1Diq/pZvy6Qy38ljTJqpYqINSXrIvv872m9607tRsP+0BU1AAccpuE
	 oPOMfLVhKOIlTFgzQEZVYFiftJLTA4mEhe2TzURZl8w+Z/WjWQHzAhFFP7dHRGbB2j
	 jPCO2S0sZ5RbQ==
Subject: Re: [PATCH net-next v23 2/3] net: phy: Add support for Template
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
Date: Sun, 04 Oct 2026 21:10:22 +0000
Message-ID: <179114822219.434549.6284648991914161094@kernel.org>
In-Reply-To: <20260930194513.663575-3-kyle.switch@motor-comm.com>
References: <20260930194513.663575-3-kyle.switch@motor-comm.com>
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

- [Low] The patch adds MDIO_PMA_10GBT_TESTMODE_MASK to the exported uAPI
  header include/uapi/linux/mdio.h as GENMASK(15, 13).
- [Low] phy: genphy_c45_template_testmode returns -EOPNOTSUPP instead of
  -EINVAL
- [Low] phy: vendor-specific 'Template' terminology pollutes generic API

--

net: phy: Add support for Template Control register for PMA

This commit adds the genphy_c45_template_testmode() helper. The helper
writes the 10GBASE-T PMA test mode field in register 132. The commit
also adds the register and field definitions to the uapi mdio.h header.

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
Will this build in userspace? include/uapi/linux/mdio.h is an exported
header, and GENMASK() isn't defined for userspace.

The uapi header only includes these:

include/uapi/linux/mdio.h:
    #include <linux/types.h>
    #include <linux/mii.h>

Neither of them, nor anything they pull in (ethtool.h, const.h,
if_ether.h, ...), defines GENMASK(). The uapi <linux/bits.h> only
provides __GENMASK(), __GENMASK_ULL() and __GENMASK_U128().

In the kernel this only works because the internal wrapper includes
bitfield.h right after the uapi header:

include/linux/mdio.h:
    #include <uapi/linux/mdio.h>
    #include <linux/bitfield.h>

So a userspace program that includes <linux/mdio.h> and uses
MDIO_PMA_10GBT_TESTMODE_MASK would fail to compile with an undefined
GENMASK.

This file already has the same problem in MDIO_AN_C73_0_S_MASK,
MDIO_AN_C73_0_E_MASK and MDIO_AN_C73_1_T_MASK. This patch adds one more
exported constant with it.

Could this use a literal (0xe000) or a uapi-safe form such as
__GENMASK()? Another option is to move the mask into
include/linux/mdio.h.

> +#define MDIO_PMA_10GBT_TESTMODE_NORMAL 0x0 /* Template Normal */
> +#define MDIO_PMA_10GBT_TESTMODE_1 0x1 /* Template TestMode1 */

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
Where does the term "Template" come from? IEEE 802.3 calls register
1.132 the 10GBASE-T test mode register, and bits 15:13 are the test
mode control field. "Template" is not part of either name. Is it taken
from the Motorcomm datasheet?

The genphy_c45_* helpers and the uapi mdio.h definitions are generic
and should follow the naming in the standard. A vendor term here could
make other driver authors think the standard has a separate "template"
test mode.

The new defines already leave the term out
(MDIO_PMA_10GBT_TESTMODE, MDIO_PMA_10GBT_TESTMODE_MASK). Only the
function name, its kernel-doc and the uapi section comment use it,
which is also inconsistent.

Would a name like genphy_c45_pma_10gbt_test_mode() work for you? The
kernel-doc, the mdio.h comment ("PMA 10GBASE-T test mode register")
and the commit subject could be updated to match.

[Severity: Low]
Is -EOPNOTSUPP the right error code here? A test_mode above
MDIO_PMA_10GBT_TESTMODE_7 means the caller passed a bad argument. It
doesn't mean the operation is unsupported, so -EINVAL seems to fit
better.

genphy_c45_template_testmode() is an exported genphy helper, and PHY
drivers will usually return its value unchanged to their caller.
By convention, -EOPNOTSUPP means the PHY doesn't implement the
operation. Code further up may then report the feature as unsupported
or fall back to something else. It would not tell the user that the
requested mode was out of range.

Could the out-of-range case return -EINVAL instead? -EOPNOTSUPP could
then be kept for a PHY that really lacks register 1.132, if you plan
to check for that.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930194513.663575-1-kyle.switch%40motor-comm.com
