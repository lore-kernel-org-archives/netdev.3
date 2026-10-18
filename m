Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D05442380;
	Sun, 18 Oct 2026 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792305933; cv=none; b=C3BI8jdzenyzGSqUrjuoeFkSeg1QCoKQZ4nz7Y0sJsuv8RDJOPkQKIJBmp31ZSBuvbjmsZZVcVEWM+q8Zb3nHFATNilDjbHijq5gQWKn1NE80bONJMw3pR7o4C7w4M5y1/czNVXm04Zdl/MzMSdQHJ309H4Ooh21o0sA8+71LIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792305933; c=relaxed/simple;
	bh=7JYsESJxdmD+ewgea22YvZqiUBr62VnQW+NVePX4znQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xwvw7gUJHtUCeDzlFO1kZp2MYDX5282iVgiThAqvjnPFQHcSxURKbrm5AaPyyS4NQhdz5vqXbLWX23XNkltxPg9zep4tRizq4i0H7ypOYj3Hi0H1ALMZFkKQz27+u0vFP6tTEFQ18bDOh1nttOA2/Ufwq7fX65xYd6nIfK3ieAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4tTjBwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4tTjBwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AE61F000C4;
	Sun, 18 Oct 2026 06:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792305932;
	bh=nwoQYoQto1YAJAYheTDELDgBOILwkL0JCAKNhO6a2hY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h4tTjBwM6zpfQOywL3uF1jwlI56Xdkk7WyoAmFRcXqbxCqhbxKPR8ateniSXxhWf7
	 iZrGYpvwzyC0S+PlHAAAguyoNOlKtZTS/jPetIMqTf8mgvcyG/miJZMGB1DG5AQIJ3
	 c7kwAktY40uPE61DOUXRT/voGdkkLQA+vf6sVj/pnp9FBXx2n2hSCTrpVuL4SG4SyZ
	 KksJtcCIYQHcAlrDFj3kpbKICRvNUM6sC/IXIiK3k7Xh7kqIvoDSrrmtmk3dH7k912
	 JhZ4Ce2z0+7IW/sQbt4Lzr5+vmUxupTzI1fXjvxPpPeL+j0H8N8260BH5EgayOyS/r
	 8dg0H1C/tngIQ==
Subject: Re: [PATCH net-next v12 3/6] net: pcs: xpcs: add Rockchip RK3568
 platform glue driver
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 david.wu@rock-chips.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 06:45:30 +0000
Message-ID: <179230593040.3135.11436989904007018210@kernel.org>
In-Reply-To: <20261017054406.1828061-4-coiaprant@gmail.com>
References: <20261017054406.1828061-4-coiaprant@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The system-suspend design for keeping PD_PIPE powered does not
  work.
- [Medium] xpcs_rk_create() (drivers/net/pcs/pcs-xpcs-rk.c:481) first
  calls device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)…
- [Low] The patch moves pcs-xpcs-plat.o (the generic snps,dw-xpcs
  platform driver, name "dwxpcs") out of the pcs_xpcs composite object…
- [Low] Concern: xpcs_rk_create() is exported with no in-tree caller, and
  include/linux/pcs/pcs-xpcs-rk.h has no !CONFIG_PCS_XPCS_ROCKCHIP stub,…

--

net: pcs: xpcs: add Rockchip RK3568 platform glue driver

This adds a platform glue driver for the Synopsys DesignWare XPCS in the
RK3568. The driver exposes the XPCS APB3 registers through a virtual MDIO
bus and remaps the MMD per port. It also moves pcs-xpcs-plat.o out of the
pcs_xpcs composite object behind a new PCS_XPCS_PLATFORM symbol, and tries
to keep PD_PIPE powered across system suspend with
device_set_wakeup_path().

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 59, CRU_CLKSEL_CON29)
Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part2%20V1.1-20210301.pdf (Page 2078)

> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index e417fd66f660a..108d47257bee2 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -12,6 +12,29 @@ config PCS_XPCS
>  	  This module provides a driver and helper functions for Synopsys
>  	  DesignWare XPCS controllers.
>  
> +if PCS_XPCS
> +
> +config PCS_XPCS_PLATFORM
> +	tristate "Generic XPCS controller support"
> +	help
> +	  Generic DWXPCS driver for platforms that don't require any
> +	  platform specific code to function or is using platform
> +	  data for setup.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +

[ ... ]

> diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
> index 4f7920618b900..f9f6cf2578d72 100644
> --- a/drivers/net/pcs/Makefile
> +++ b/drivers/net/pcs/Makefile
> @@ -1,10 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for Linux PCS drivers
>  
> -pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
> -				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
> +pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-nxp.o pcs-xpcs-wx.o
>  
>  obj-$(CONFIG_PCS_XPCS)		+= pcs_xpcs.o
> +obj-$(CONFIG_PCS_XPCS_PLATFORM) += pcs-xpcs-plat.o

[Severity: Low]
Is it intended that existing configs lose the generic snps,dw-xpcs
platform driver here?

Before this change, any config with PCS_XPCS enabled (for example through
the select PCS_XPCS in STMMAC_ETH) always built pcs-xpcs-plat.o. The new
PCS_XPCS_PLATFORM has no default, so make olddefconfig silently turns the
generic glue off.

Some systems have a DT, for instance one provided by firmware, with an
MMIO node using the documented snps,dw-xpcs binding. On those systems no
MDIO device would be created for that node, and a MAC calling
xpcs_create_fwnode() would get -EPROBE_DEFER forever:

drivers/net/pcs/pcs-xpcs.c:xpcs_create_fwnode() {
    ...
	mdiodev = fwnode_mdio_find_device(fwnode);
	if (!mdiodev)
		return ERR_PTR(-EPROBE_DEFER);
    ...
}

No in-tree DTS uses the binding, and the commit message says the change
is deliberate. However, the Rockchip glue only uses exported core
symbols, so it does not seem to need the split.

Would adding "default PCS_XPCS" keep the old behaviour? Alternatively,
could the split go into its own patch?

> +obj-$(CONFIG_PCS_XPCS_ROCKCHIP) += pcs-xpcs-rk.o
>  obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
>  obj-$(CONFIG_PCS_MTK_LYNXI)	+= pcs-mtk-lynxi.o
>  obj-$(CONFIG_PCS_RZN1_MIIC)	+= pcs-rzn1-miic.o
> diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
> new file mode 100644
> index 0000000000000..698a43b753341
> --- /dev/null
> +++ b/drivers/net/pcs/pcs-xpcs-rk.c
> @@ -0,0 +1,598 @@

[ ... ]

> +struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int port)
> +{

[ ... ]

> +	pdev = of_find_device_by_node(pcs);
> +	if (!pdev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	/*
> +	 * Establish the device link before reading the supplier's drvdata.
> +	 * device_link_add() does not fail on a supplier that is unbinding;
> +	 * it creates the link in DL_STATE_SUPPLIER_UNBIND.
> +	 *
> +	 * The check below only confirms that the supplier is bound at this
> +	 * point. It does not fully protect against a concurrent unbind
> +	 * between here and xpcs_create_mdiodev(); closing that window would
> +	 * require reading a managed link's status or device_lock(), neither
> +	 * of which is acceptable on this path. The window is small and
> +	 * requires an explicit unbind from userspace. Discussed on
> +	 * driver-core.
> +	 *
> +	 * The link is released automatically when the consumer device is
> +	 * destroyed (DL_FLAG_AUTOREMOVE_CONSUMER), so no explicit
> +	 * device_link_remove() is needed on the failure paths.
> +	 */
> +	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	if (READ_ONCE(pdev->dev.links.status) != DL_DEV_DRIVER_BOUND) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}

[Severity: Medium]
Does this check protect the rest of the MAC probe?

pcs-handle is not a fw_devlink supplier binding, so the MAC can reach
this point while the XPCS is still unbound. In that case
device_link_init_status() creates the link as DL_STATE_DORMANT.

The XPCS probe can finish on another CPU between device_link_add() and
the READ_ONCE(), for example with parallel module loading or async probe:

CPU1 (MAC probe)                      CPU2 (XPCS probe)
xpcs_rk_create()
  device_link_add()
    link is DL_STATE_DORMANT
                                      device_links_driver_bound()
                                        link becomes DL_STATE_AVAILABLE
  READ_ONCE(pdev->dev.links.status)
    is DL_DEV_DRIVER_BOUND, passes
  xpcs_create_mdiodev(pxpcs->bus, port)

device_links_busy() only counts CONSUMER_PROBE and ACTIVE as busy:

drivers/base/core.c:device_links_busy() {
    ...
		if (link->status == DL_STATE_CONSUMER_PROBE
		    || link->status == DL_STATE_ACTIVE) {
			ret = true;
    ...
}

So until the MAC finishes probing, a sysfs unbind or module unload of
the XPCS would not wait for it. The XPCS devres teardown would then free
pxpcs and the mii_bus. Meanwhile xpcs_rk_create() or the rest of the
stmmac probe can still reach them through bus->priv and reg_base in
xpcs_rk_read_c45() and xpcs_rk_write_c45().

Can this lead to a use-after-free of pxpcs?

Even without an unbind, wouldn't the MAC's own bind hit this warning on
the AVAILABLE link?

drivers/base/core.c:device_links_driver_bound() {
    ...
			WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
			WRITE_ONCE(link->status, DL_STATE_ACTIVE);
    ...
}

Also, if the supplier unbinds while this AUTOREMOVE_CONSUMER link is
still present, device_links_driver_cleanup() would trigger:

	WARN_ON(device_link_test(link, DL_FLAG_AUTOREMOVE_CONSUMER));

The comment above only covers a window up to xpcs_create_mdiodev() opened
by an explicit userspace unbind. In this race, the link never gets
CONSUMER_PROBE protection for the rest of the MAC probe.

Would it work to check the status of the link returned by
device_link_add() instead? That would mean requiring DL_STATE_CONSUMER_PROBE
or DL_STATE_ACTIVE, and otherwise calling device_link_del() and returning
-EPROBE_DEFER. If the supplier is already bound when the link is created,
the link starts as CONSUMER_PROBE and that path looks fine.

> +
> +	pxpcs = platform_get_drvdata(pdev);
> +	if (!pxpcs || !pxpcs->bus) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	xpcs = xpcs_create_mdiodev(pxpcs->bus, port);

[ ... ]

> +static int xpcs_rk_system_suspend(struct device *dev)
> +{
> +	/*
> +	 * Keep the PD_PIPE power domain on during system suspend.
> +	 *
> +	 * PD_PIPE is shared with SATA/PCIe and would be powered down by
> +	 * genpd once all its consumers are suspended, killing the SerDes
> +	 * and breaking MAC WoL.  Mark the XPCS as part of the wakeup path
> +	 * so genpd keeps the domain on.  Unconditional because the XPCS
> +	 * core has no callback to convey the MAC WoL state.
> +	 */
> +	device_set_wakeup_path(dev);
> +	return 0;
> +}
> +
> +static int xpcs_rk_system_resume(struct device *dev)
> +{
> +	return 0;
> +}

[Severity: High]
Does device_set_wakeup_path() in xpcs_rk_system_suspend() actually keep
PD_PIPE on?

genpd only honours the wakeup path when the domain has
GENPD_FLAG_ACTIVE_WAKEUP:

drivers/pmdomain/core.c:genpd_finish_suspend() {
    ...
	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
	    !device_out_band_wakeup(dev))
		return 0;
    ...
}

The commit message says:

  "genpd then leaves the domain powered, because the Rockchip power
  domain driver sets GENPD_FLAG_ACTIVE_WAKEUP on PD_PIPE"

However, PD_PIPE is declared with wakeup set to false:

drivers/pmdomain/rockchip/pm-domains.c:
	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false, false),

rockchip_pm_add_one_domain() only adds the flag when active_wakeup is
set:

	pd->genpd.flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_NO_STAY_ON;
	if (pd_info->active_wakeup)
		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;

So the early return is never taken. suspended_count is incremented and
genpd_sync_power_off() runs. That function ignores the per-device
rpm_always_on set by dev_pm_genpd_rpm_always_on(). Once SATA, PCIe and
the XPCS are all suspended, PD_PIPE would be powered off in the noirq
phase.

Wouldn't that break MAC WoL over SGMII, which this code is meant to
preserve?

If PD_PIPE is power-cycled, xpcs_rk_system_resume() does not repeat the
probe-time setup either. The probe comment says the SerDes phy_init()
and phy_power_on() are needed for register access and soft reset. Also,
need_reset in the core is only set in xpcs_create(), so the XPCS soft
reset is not run again after power loss.

_DEFINE_DEV_PM_OPS() also maps freeze/thaw/poweroff/restore to these
callbacks, so hibernation seems to have the same gap.

Would this need either a change to the PD_PIPE active_wakeup setting
(which also affects PCIe and SATA), or a resume path that restores the
SerDes and the XPCS?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017054406.1828061-1-coiaprant%40gmail.com
