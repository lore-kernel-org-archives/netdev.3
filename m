Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33B282F0C;
	Mon, 10 Aug 2026 22:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786400906; cv=none; b=rJ6y15IrhNareMtnZ3e6kAw7eGJCHju1P8glS9RmYACh/w7NIFIRv4KbPAYk2FICLPedRYfEasOAWK9JnWhK5tFy4S+uLGW/lQoyjuaXINFRIv76rDE20w8jzdTIloi7enE0D+gPKu7FMaLF7sVG0E92S4OTWqJ+FcGsyNpDwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786400906; c=relaxed/simple;
	bh=7g75z6m3HR2rnlfsyQ0saC7Nw+raXgaeD4mvQT3/d7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5hPb+MEm/yf9zB2dYsF5wzXOSt0Rbn/bpzhohwz5JIR6Bqd6Id6CuLGb1KE2aw50dFZ+DWq+U0JD2gvQEdjmuf/wGpgL8diWBaxa35XjWDvDJAPZgaXzk8eL3qXKkQUitIWDb5eJm408WSuVeIr/7c4mJGgXMJ7KLyVZNEjOqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/cynmbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/cynmbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F322E1F000E9;
	Mon, 10 Aug 2026 22:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786400904;
	bh=5A10ScZkEKAiH+1QXJ6r6ff0tFnVCPE9Xv/u7EBt6Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j/cynmbZYLzLDoNN67w73UrWv1nY6ZdyGWUCL42xr/6XUCWcXiMWiL/d93iK8h1HF
	 hb/oJqrXu2cXUj0rdn16PNJNqH3NN+ZAwJpfKBQEp68Vjh9GL1pMDszY9oF0wcocfO
	 jkwdNSnTQ8RuZFFLD0E4mUO1E9HZ9c0S8Z7bZeypiyiiQ1s6ZgGxSJXbQ1ecLplRsT
	 hWUXxECer4dDusmQJOoHIrKpw2FxCXPv0r3FxTZsW8jbI0WWr2so/IydVjIbwFwvp1
	 scErhqbXKhrPOF0ezdvJxqO162cFxx7rP+BDVCgcr6s3PYX5AL5fH4x0W9iVWeH6wz
	 QlqF16cTB67Pg==
From: Jakub Kicinski <kuba@kernel.org>
To: kyle.switch@motor-comm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v9] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Date: Mon, 10 Aug 2026 15:26:17 -0700
Message-ID: <20260810222616.906676-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804114419.4129109-1-kyle.switch@motor-comm.com>
References: <20260804114419.4129109-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: Add driver for Motorcomm Quad 2.5GbE phy
    
Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
motorcomm driver, using the phy_package helpers for the shared top
extended register space.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index c5a2cda8d31bd..6ca6618993182 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -538,15 +538,15 @@
> +static int phy8824_page_write_with_lock(struct phy_device *phydev, int page)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +	ret = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
> +	if (ret < 0)
> +		goto err;
> +	ret &= ~YT8824_RSSR_SPACE_MASK;
> +	ret |= (page & YT8824_RSSR_SPACE_MASK);
> +	ret = ytphy_write_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG, ret);
> +
> +err:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}

[ ... ]

> @@ -881,18 +881,18 @@
> +static int yt8824_sds_isolate_and_softreset_paged(struct phy_device *phydev)
> +{
> +	int val = 0;
> +	int ret = -1;
> +	int r;
> +
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_USXGMII_SPACE);
> +	if (ret < 0)
> +		goto err_restore_page;
> +
> +	/* sds softreset and enable isolate */
> +	ret = phy_modify(phydev, MII_BMCR, BMCR_RESET | BMCR_ISOLATE,
> +			 BMCR_RESET & ~BMCR_ISOLATE);
> +	if (ret < 0)
> +		goto err_restore_page;
> +
> +	ret = phy_read_poll_timeout(phydev, MII_BMCR, val,
> +				    !(val & BMCR_RESET),
> +				    50000, 600000, true);

[Severity: High]
Does swapping the global register space and then releasing the mdio bus lock
expose other generic phylib operations to silent data corruption?

Because phy8824_page_write_with_lock() acquires and then immediately
releases mdio_lock after modifying YT8521_REG_SPACE_SELECT_REG, the global
page is left pointing to USXGMII_SPACE while this function runs its 600ms
polling loop.

If a generic PHY operation (like a background status poll or an ioctl from
userspace) runs on another port during this window, it will only acquire
mdio_lock, not the driver's private shared_lock, and end up reading or
writing the wrong register space.

[ ... ]

> @@ -1181,18 +1181,18 @@
> +static int yt8824_extern_config_sds_init_paged(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *shared_priv;
> +	int val_1, val_2, val_3, tmp;
> +	int port;
> +	int val;
> +	int ret;
> +	int r;
> +
> +	shared_priv = phy_package_get_priv(phydev);
> +	port = phydev->mdio.addr - shared_priv->offset;
> +	if (port < 0)
> +		return -EINVAL;
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_USXGMII_SPACE);
> +	if (ret < 0)
> +		goto err_restore_page;

[ ... ]

> +	if (port == 0) {
> +		/* Serdes optimization */
> +		ret = ytphy_write_ext_with_lock(phydev, 0x04be, 0x000d);

[Severity: Medium]
Will the shared package-level SerDes remain uninitialized if the user or
system brings up secondary ports without ever bringing up Port 0?

Because this global SerDes optimization is gated behind the port == 0 check
during the per-port config_init phase, it seems the hardware may be left
with degraded 2.5G performance or a failing link if Port 0 happens to be
unused in a given configuration.

[ ... ]

> @@ -4494,9 +4494,9 @@
> +static int yt8824_config_aneg(struct phy_device *phydev)
> +{
> +	int phy_ctrl = 0;
> +	int ret = 0;
> +
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);

[Severity: High]
Does this function need to hold the package's shared_lock?

If auto-negotiation is triggered on one port concurrently with the
initialization of another port, yt8824_config_aneg() will force the global
page to UTP_SPACE. The port performing initialization (which holds
shared_lock and assumes the page is set to USXGMII_SPACE) will then
accidentally write its configuration to the UTP registers.

[ ... ]

> @@ -4523,14 +4523,14 @@
> +static int yt8824_phy_package_probe_once(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	struct device_node *np = phy_package_get_node(phydev);
> +	const char *interface_mode_name;
> +
> +	/* Initialise shared lock for YT8824 */
> +	mutex_init(&priv->shared_lock);
> +	priv->interface_mode = PHY_INTERFACE_MODE_NA;
> +	priv->offset = INTERNAL_PHY8824_ADDR_UTP0;
> +	if (!of_property_read_string(np, "motorcomm,interface-mode",
> +				     &interface_mode_name)) {

[Severity: High]
How does the driver behave if the motorcomm,interface-mode device tree
property is missing?

If of_property_read_string() returns an error because the property is absent,
priv->interface_mode remains PHY_INTERFACE_MODE_NA and priv->offset remains
INTERNAL_PHY8824_ADDR_UTP0 (which evaluates to 4).

Later during initialization, yt8824_config_init() checks:
if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL)

Since PHY_INTERFACE_MODE_NA does not equal PHY_INTERFACE_MODE_INTERNAL, the
code falls through to the external USXGMII initialization path. For an
internal PHY, the port index calculation (4 - 4 = 0) succeeds, causing the
driver to actively misconfigure the internal PHY with external SerDes
settings. For an external PHY (0 - 4 = -4), it results in a silent -EINVAL
abort.

Should there be a definitive default or a clean probe failure if this
property is missing?
-- 
pw-bot: cr
