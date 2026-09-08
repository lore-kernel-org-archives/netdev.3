Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475E47C0E1;
	Tue,  8 Sep 2026 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898563; cv=none; b=ksgmMjxVrNn7K+MnlR/VHVyAcEHB9GWS8aBCCqqti1gisNv5UmZyuW5dLiftxJB2gRPPV5RPn2Sbih8hd3RyLzhufXcVG5lYu/uc+ce7d9/Y9D6WpmZdIKmuFwi63z7rvXZ9ex9XAW826UQJ/NyLLTglSHsDN5UcF8pkadP1/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898563; c=relaxed/simple;
	bh=D7zKvfBJDCj2rL9mZMt0ChD5DC2okDC3rLeWFObr1EI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lpley8Lj7FFl5uOLFkLhNla6oSpKxusFdFvAdEBUtAkPUdJHvhDYIXLYuweGimHxUp8VDZXQza9H4IlpKpJxuR5w4z6jegTZnkEbYOENF6rWowpAC0a6algd0Rz62Ay54DIFRZlRv1KhuJMfQQSTJkLomXjZQzjTwAWNkz9nj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgQsJCGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgQsJCGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C025B1F00A3D;
	Tue,  8 Sep 2026 20:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788898559;
	bh=4NoxvgQ+8YXCW+M4GGo7uOJe17o/DUq1HLfZ5JijRO8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PgQsJCGHu17ojZF1ZFtSxzaB8sjPiwBxGtTJqFVjQjxBR2cwqLCC4/ujf9YNLVctl
	 poXNLMp4ppdwAfOUBLPkbf0c3xfiAa/xRWXWl6Yyg0U2tQ0aaspGcp4OhwuTpf8BEb
	 mU5uC84WFo7ODgYWEGfiWQye0oUH7Ny9gnL5lr5fM49iKIxeMfQLUrNntlN8dGndBY
	 +pyOq3fBzcfpsAfkg4ttoZDbCCbZsVcTe/X1/wZd19zzPjpaICwNUt3LZKCyDPAefw
	 ERiIob+3uIapR2kxPyNVsfOMACFs8EWQgjTiaJcgtM+2SrCJXkcHBayEscDEiwrvng
	 +Cpy8MU98Bm1g==
Subject: Re: [RESEND PATCH net-next v14] net: phy: Add driver for Motorcomm
 Quad 2.5GbE phy
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
 jie.han@motor-comm.com
Date: Tue, 08 Sep 2026 20:15:58 +0000
Message-ID: <178889855829.219967.16779952165725338109@kernel.org>
In-Reply-To: <20260904081544.1673619-1-kyle.switch@motor-comm.com>
References: <20260904081544.1673619-1-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 4 · Low: 6

- [Medium] New, undocumented Device Tree ABI for YT8824.
- [Medium] motorcomm.c now uses the phy_package helpers
  (devm_of_phy_package_join(), phy_package_probe_once(),…
- [Medium] yt8824_restore_working_status() (motorcomm.c:892)
  unconditionally executes the USXGMII/SerDes recovery step…
- [Medium] yt8824_config_init() (motorcomm.c:1702) has no hardware
  rollback on failure: its `err:` label only does…
- [Low] The commit message states the patch adds "two new definitions in
  the MDIO uAPI header", but include/uapi/linux/mdio.h gains ten…
- [Low] drivers/net/phy/motorcomm.c adds YT8824_UTP_TEST_MODE_M
  (GENMASK(15, 13)) and YT8824_UTP_TEST_MODE(x) (FIELD_PREP) at lines…
- [Low] CONFIG_MOTORCOMM_PHY's help text still reads "Currently supports
  YT85xx Gigabit Ethernet PHYs" while motorcomm_phy_drvs[] now also…
- [Low] The newly added YT8824 register-map comment
  (drivers/net/phy/motorcomm.c lines 38-48) labels the alternate…
- [Low] yt8824_power_down() (motorcomm.c:4418) can successfully assert
  UTP BMCR_PDOWN via yt8824_utp_power_down() and then fail in a later…
- [Low] Concern (assessed as a false positive): priv->shared_lock and
  priv->interface_mode in the phy_package shared private data are…

--

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

This adds YT8824 quad-port 2.5G support to the existing motorcomm driver,
using the phy_package helpers for the shared top extended register space.
It also exports a new phylib helper, genphy_c45_template_testmode(), and
adds test-mode definitions to the MDIO uAPI header.

A few questions on the new code below.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index c5a2cda8d31bd..510bd0639a858 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -1,24 +1,29 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Motorcomm 8511/8521/8522/8531/8531S/8821 PHY driver.
> + * Motorcomm 8511/8521/8522/8531/8531S/8821/8824 PHY driver.
>   *
>   * Author: Peter Geis <pgwipeout@gmail.com>
>   * Author: Frank <Frank.Sae@motor-comm.com>
> + * Author: Kyle <kyle.switch@motor-comm.com>
>   */
>  
>  #include <linux/clk.h>
>  #include <linux/etherdevice.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/phy.h>
>  #include <linux/property.h>
>  
> +#include "phylib.h"
> +

[Severity: Medium]
Does this still link when MOTORCOMM_PHY is the only PHY driver enabled?

drivers/net/phy/Makefile builds the package helpers conditionally:

obj-$(CONFIG_PHY_PACKAGE)	+= phy_package.o

and drivers/net/phy/phylib.h declares devm_of_phy_package_join(),
phy_package_probe_once(), phy_package_get_priv(), phy_package_get_node(),
__phy_package_read() and __phy_package_write() unconditionally, with no
stubs for the disabled case.

config MOTORCOMM_PHY in drivers/net/phy/Kconfig has no "select
PHY_PACKAGE", and CONFIG_PHY_PACKAGE is promptless, so it can only be
turned on by a select. With MOTORCOMM_PHY=y and no other driver selecting
it, do these six symbols end up undefined at link time (and unresolved
module symbols for =m)?

Every other in-tree user (BCM54140_PHY, MICREL_PHY, MICROSEMI_PHY,
QCA807X_PHY, REALTEK_PHY, DP83640) selects PHY_PACKAGE explicitly.

>  #define PHY_ID_YT8511		0x0000010a
>  #define PHY_ID_YT8521		0x0000011a
>  #define PHY_ID_YT8522		0x4f51e928
>  #define PHY_ID_YT8531		0x4f51e91b
>  #define PHY_ID_YT8531S		0x4f51e91a
>  #define PHY_ID_YT8821		0x4f51ea19
> +#define PHY_ID_YT8824		0x4f51e8b8
>  /* YT8521/YT8531S/YT8821 Register Overview
>   *	UTP Register space	|	FIBER Register space
>   *  ------------------------------------------------------------
> @@ -30,6 +35,18 @@
>   *  ------------------------------------------------------------
>   */
>  
> +/* YT8824 Register Overview
> + *	UTP Register space	|	FIBER Register space
> + *  ------------------------------------------------------------
> + * |	UTP MII			|	FIBER MII	        |
> + * |	UTP MMD			|				|
> + * |	UTP Extended		|	FIBER Extended		|
> + * |	UTP Top Extended	|	FIBER Top Extended	|
> + *  ------------------------------------------------------------
> + * |			Common Top Extended			|
> + *  ------------------------------------------------------------
> + */
> +

[Severity: Low]
This isn't a bug, but the new YT8824 map calls the alternate bank "FIBER
Register space", while the code names and uses that same bank as USXGMII:

#define YT8824_RSSR_USXGMII_SPACE		(0x1)

old_page = phy_select_page(phydev, YT8824_RSSR_USXGMII_SPACE);

The v7 changelog renamed YT8824_RSSR_FIBER_SPACE to
YT8824_RSSR_USXGMII_SPACE.  Should this comment block follow the rename,
since selector bit 0 is what both describe?

>  /* 0x10 ~ 0x15 , 0x1E and 0x1F are common MII registers of yt phy */
>  
>  /* Specific Function Control Register */
> @@ -376,6 +393,17 @@
>  #define YT8821_CHIP_MODE_AUTO_BX2500_SGMII	0
>  #define YT8821_CHIP_MODE_FORCE_BX2500		1
>  
> +#define YT8824_RSSR_SPACE_MASK			BIT(0)
> +#define YT8824_RSSR_USXGMII_SPACE		(0x1)
> +#define YT8824_RSSR_UTP_SPACE			(0x0)
> +#define YT8824_UTP_TEMPLATE_TEST_MODE1		0x1
> +#define YT8824_UTP_TEMPLATE_TEST_NORMAL		0x0
> +#define YT8824_UTP_TEST_MODE_M			GENMASK(15, 13)
> +#define YT8824_UTP_TEST_MODE(x)	FIELD_PREP(YT8824_UTP_TEST_MODE_M, (x))
                                        ^^^^^^^^^^

[Severity: Low]
Are YT8824_UTP_TEST_MODE_M and YT8824_UTP_TEST_MODE() referenced anywhere?
Grepping motorcomm.c shows only these two definition lines.

The same 15:13 field is now defined in the uAPI as
MDIO_PMA_10GBT_TESTMODE_TEMPLATE (0xE000) and is programmed only through
genphy_c45_template_testmode(), so can these two be dropped rather than
kept as a second copy of the encoding?

> +#define YT8824_SDS_CFG_MIN_PRE_MASK		GENMASK(3, 0)
> +#define YT8824_SDS_EN_FILL_PRE			BIT(13)
> +#define YT8824_SDS_TX_PRE_PADDING		(0x7)
> +

[ ... ]

> @@ -621,11 +719,1013 @@ static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)

[ ... ]

> +static int yt8824_restore_working_status(struct phy_device *phydev, int ret)
> +{
> +	int r;
> +
> +	/* configure normal test mode */
> +	r = yt8824_utp_normal_test_mode_paged(phydev);
> +	if (ret >= 0 && r < 0)
> +		ret = r;
> +	/* sds soft reset and disable isolation */
> +	r = yt8824_sds_isolate_and_softreset_paged(phydev);
> +	if (ret >= 0 && r < 0)
> +		ret = r;
> +	return ret;
> +}

[Severity: Medium]
Should this recovery helper look at priv->interface_mode?

In internal mode the forward paths deliberately never touch the SerDes.
yt8824_soft_reset() only does UTP work:

	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
		ret = yt8824_utp_invalid_test_mode_paged(phydev);
		...
		ret = yt8824_utp_softreset_paged(phydev);
		...
		ret = yt8824_utp_normal_test_mode_paged(phydev);

but its retry label lands here, which unconditionally calls
yt8824_sds_isolate_and_softreset_paged().  That switches the
package-global space selector to YT8824_RSSR_USXGMII_SPACE, writes
MII_BMCR there and then polls:

	ret = read_poll_timeout(__phy_read, val, (val < 0) ||
				!(val & BMCR_RESET),
				50000, 600000, true, phydev, MII_BMCR);

Can that hold the MDIO bus mutex (taken by phy_select_page()) plus the
package shared_lock for 50 ms up to 600 ms, blocking the other three
ports, on a board where the USXGMII side is not in use?  The recovery's
own error is also dropped by "if (ret >= 0 && r < 0) ret = r;", so both
the unexpected SerDes write and the stall happen with no message.
yt8824_power_on() and yt8824_power_down() route into the same helper from
their internal-mode branches.

[ ... ]

> +static int yt8824_config_init(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
> +		ret = yt8824_internal_config_init_paged(phydev);
> +		if (ret < 0)
> +			goto err;
> +	} else {
> +		ret = yt8824_extern_config_sds_init_paged(phydev);
> +		if (ret < 0)
> +			goto err;
> +		ret = yt8824_extern_config_utp_init_paged(phydev);
> +		if (ret < 0)
> +			goto err;
>  	}
> +	mutex_unlock(&priv->shared_lock);
> +	ret = yt8824_soft_reset(phydev);
>  
> -err_restore_page:
> -	return phy_restore_page(phydev, old_page, ret);
> +	phydev_dbg(phydev, "%s done, phy addr: %d\n",
> +		   __func__, phydev->mdio.addr);
> +	return ret;
> +err:
> +	mutex_unlock(&priv->shared_lock);
> +	return ret;
>  }

[Severity: Medium]
Does the err path leave the port powered down and still in template test
mode 1?

Both init helpers assert BMCR_PDOWN on the UTP side near their start, for
example in yt8824_extern_config_utp_init_paged():

	/* power down */
	ret = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);

and later enter test mode 1 before the closing reset:

	ret = genphy_c45_template_testmode
		(phydev, YT8824_UTP_TEMPLATE_TEST_MODE1);
	...
	ret = phy_modify(phydev, MII_BMCR, BMCR_RESET | BMCR_ANENABLE,
			 BMCR_RESET | BMCR_ANENABLE);
	ret = phy_read_poll_timeout(phydev, MII_BMCR, val,
				    !(val & BMCR_RESET),
				    50000, 600000, true);
	if (ret < 0)
		return ret;

	return genphy_c45_template_testmode
		(phydev, YT8824_UTP_TEMPLATE_TEST_NORMAL);

Any intervening "return ret" (an MDIO error, or -ETIMEDOUT from that
600 ms poll) reaches err: here, which only unlocks.  So does the port stay
with BMCR_PDOWN set and, past the test-mode write, with the PMA still
driving the transmit test template?

yt8824_internal_config_init_paged() has the same PDOWN and TEST_MODE1
window, and yt8824_extern_config_sds_init_paged()'s err_restore_page only
restores the page selector, leaving the SerDes half-tuned.

The v13 changelog describes yt8824_restore_working_status() as restoring
configuration "ensuring the hardware/device is left in a known good state
upon failure", and soft_reset/power_on/power_down call it, but
config_init does not.  Note that helper also does not clear BMCR_PDOWN,
so a later .soft_reset would not bring the port back either.

[ ... ]

> @@ -3072,6 +4172,413 @@ static int yt8821_resume(struct phy_device *phydev)

[ ... ]

> +static int yt8824_power_down(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
> +		/* invalid test mode */
> +		ret = yt8824_utp_invalid_test_mode_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +		/* utp power down */
> +		ret = yt8824_utp_power_down(phydev);
> +		if (ret < 0)
> +			goto retry;
> +		/* normal mode */
> +		ret = yt8824_utp_normal_test_mode_paged(phydev);
> +		if (ret < 0)
> +			goto retry;

[Severity: Low]
Can the power state phylib records diverge from the hardware here?

yt8824_utp_power_down() can succeed in setting BMCR_PDOWN and then the
following normal-test-mode restore (or the SerDes step in the else
branch) can fail.  The retry path calls yt8824_restore_working_status(),
which never touches BMCR_PDOWN, and the original error is returned.

phy_suspend() only records the transition on success:

	ret = phydrv->suspend(phydev);
	if (!ret)
		phydev->suspended = true;

so does phylib keep treating the PHY as active while the copper side is
powered down?  The mirror case is yt8824_power_on(), where BMCR_PDOWN may
already be cleared when a later step fails, leaving phydev->suspended set
on a powered PHY.

[ ... ]

> +static int yt8824_phy_package_probe_once(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	struct device_node *np = phy_package_get_node(phydev);
> +	const char *interface_mode_name;
> +
> +	/* Initialise shared lock for YT8824 */
> +	mutex_init(&priv->shared_lock);
> +	priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;
> +	if (!of_property_read_string(np, "motorcomm,interface-mode",
> +				     &interface_mode_name)) {
> +		if (!strcasecmp(interface_mode_name,
> +				phy_modes(PHY_INTERFACE_MODE_USXGMII))) {
> +			priv->interface_mode = PHY_INTERFACE_MODE_USXGMII;
> +		} else if (!strcasecmp
> +				(interface_mode_name,
> +				 phy_modes(PHY_INTERFACE_MODE_INTERNAL))) {
> +			priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;
> +		} else {
> +			return -EINVAL;
> +		}
> +	} else {
> +		/* default internal phy */
> +		priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Where is the binding for the DT interface this introduces?

"motorcomm,interface-mode" is a new vendor property that selects the whole
init and power sequence, and
Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml still lists
only:

    enum:
      - ethernet-phy-id4f51.e91a
      - ethernet-phy-id4f51.e91b

with no 4f51.e8b8, no package node and no interface-mode property.  The v4
changelog says "Remove motorcomm,yt8xxx.yaml, will update in other patch
thread", but the property becomes ABI as soon as this driver is merged.
Can the binding update be part of this series?

Also, when the property is absent the driver silently assumes
PHY_INTERFACE_MODE_INTERNAL and never consults phydev->interface, which
phylib already derives from phy-mode.  On a USXGMII board that omits the
undocumented property, does this pick the internal init and power
sequences with no diagnostic?

> +static int yt8824_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct yt8824_shared_priv *shared_priv;
> +	int ret;
> +
> +	ret = devm_of_phy_package_join(dev, phydev, sizeof(*shared_priv));
> +	if (ret)
> +		return ret;
> +
> +	if (phy_package_probe_once(phydev)) {
> +		ret = yt8824_phy_package_probe_once(phydev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Related to the above: devm_of_phy_package_join() is called
unconditionally, and of_phy_package_join() in
drivers/net/phy/phy_package.c requires a specific parent node:

	if (!of_node_name_eq(package_node, "ethernet-phy-package")) {
		ret = -EINVAL;
		goto exit;
	}

plus a "reg" property, so the driver cannot bind at all without that DT
topology.  Should that requirement be documented in the binding as well?

[Severity: Low]
This looks safe today, but is the ordering here intentional?

priv->shared_lock and priv->interface_mode are initialised only after
phy_package_probe_once() has already published the once bit, and the bit
is not cleared when yt8824_phy_package_probe_once() returns -EINVAL.

phy_driver_register() sets
new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS, so PHY
probes are serialised and the -EINVAL case drops the last package
reference via devres, which makes the next member re-run the
initialisation on a fresh shared struct.  Both of those are what makes
this work, so is it worth doing the mutex_init() and interface_mode setup
before the once bit is taken, so it does not depend on that?

> @@ -3158,13 +4665,29 @@ static struct phy_driver motorcomm_phy_drvs[] = {
>  		.suspend		= yt8821_suspend,
>  		.resume			= yt8821_resume,
>  	},
> +	{
> +		PHY_ID_MATCH_EXACT(PHY_ID_YT8824),
> +		.name			= "YT8824 Quad Ports 2.5Gbps Ethernet",

[Severity: Low]
MODULE_DESCRIPTION is updated below to list 8824, but config
MOTORCOMM_PHY's help text in drivers/net/phy/Kconfig still reads:

	  Currently supports YT85xx Gigabit Ethernet PHYs.

which covers neither a quad-port part nor 2.5G.  Should that be updated
in the same patch?

> +		.get_features		= yt8824_get_features,
> +		.read_page		= yt8824_read_page,
> +		.write_page		= yt8824_write_page,
> +		.probe		        = yt8824_probe,
> +		.config_aneg		= yt8824_config_aneg,
> +		.aneg_done		= yt8824_aneg_done,
> +		.config_init		= yt8824_config_init,
> +		.read_status		= yt8824_read_status,
> +		.soft_reset		= yt8824_soft_reset,
> +		.suspend		= yt8824_suspend,
> +		.resume			= yt8824_resume,
> +	},
>  };
>  
>  module_phy_driver(motorcomm_phy_drvs);
>  
> -MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/8821 PHY driver");
> +MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/8821/8824 PHY driver");

[ ... ]

> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index 06f4bc3c20c71..fe339b17e9824 100644
> --- a/include/uapi/linux/mdio.h
> +++ b/include/uapi/linux/mdio.h
> @@ -63,6 +63,7 @@
>  /* Media-dependent registers. */
>  #define MDIO_PMA_10GBT_SWAPPOL	130	/* 10GBASE-T pair swap & polarity */
>  #define MDIO_PMA_10GBT_TXPWR	131	/* 10GBASE-T TX power control */
> +#define MDIO_PMA_10GBT_TESTMODE 132	/* Test mode control */
>  #define MDIO_PMA_10GBT_SNR	133	/* 10GBASE-T SNR margin, lane A.
>  					 * Lanes B-D are numbered 134-136. */
>  #define MDIO_PMA_10GBR_FSRT_CSR	147	/* 10GBASE-R fast retrain status and control */
> @@ -320,6 +321,17 @@
>  /* PMA 10GBASE-R Fast Retrain status and control register. */
>  #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
>  
> +/* PMA 10GBASE-R/-T Template Test Mode Register*/
> +#define MDIO_PMA_10GBT_TESTMODE_TEMPLATE 0xE000 /* Template test mode */
> +#define MDIO_PMA_10GBT_TESTMODE_NORMAL 0x0000 /* Template Normal */
> +#define MDIO_PMA_10GBT_TESTMODE_1 0x2000 /* Template TestMode1 */
> +#define MDIO_PMA_10GBT_TESTMODE_2 0x4000 /* Template TestMode2 */
> +#define MDIO_PMA_10GBT_TESTMODE_3 0x6000 /* Template TestMode3 */
> +#define MDIO_PMA_10GBT_TESTMODE_4 0x8000 /* Template TestMode4 */
> +#define MDIO_PMA_10GBT_TESTMODE_5 0xa000 /* Template TestMode5 */
> +#define MDIO_PMA_10GBT_TESTMODE_6 0xc000 /* Template TestMode6 */
> +#define MDIO_PMA_10GBT_TESTMODE_7 0xe000 /* Template TestMode7 */
> +

[Severity: Low]
The commit message says:

    "plus two new definitions in the MDIO uAPI header."

Ten permanent uAPI symbols are added here: MDIO_PMA_10GBT_TESTMODE,
MDIO_PMA_10GBT_TESTMODE_TEMPLATE and MDIO_PMA_10GBT_TESTMODE_NORMAL plus
_1 through _7.  Could the changelog be updated to match?

Two things about the comments as well.  The block is labelled "PMA
10GBASE-R/-T", but register 132 is added to the 10GBASE-T
media-dependent group, while the 10GBASE-R registers in this file sit at
147 (MDIO_PMA_10GBR_FSRT_CSR) - is the "-R" part intended?

Also, MDIO_PMA_10GBT_TESTMODE_TEMPLATE (0xE000) is the field mask while
MDIO_PMA_10GBT_TESTMODE_7 (0xe000) is a value, and the two are
numerically identical.  Would naming the mask something like
MDIO_PMA_10GBT_TESTMODE_MASK, and describing the field with the standard
test-mode wording rather than "Template", make the header less
confusing for later users?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904081544.1673619-1-kyle.switch%40motor-comm.com
