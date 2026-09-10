Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D339656D;
	Thu, 10 Sep 2026 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028120; cv=none; b=D5w1LG3LfC8sKHF/hIynmeHHd3U9vBZgcrWP3Y+QCps/1HaXe5TrxQCUo5h3Ih2OMSH/w8EtlhUPH7OD9ACsko3fX0b9eA6Z5rhlT0bhhgya5/tr+XorSd8k/mtD6FFKVTJv1a4ILJGwtKmGrs/cBslAHtT9XESVpbtKzqbqbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028120; c=relaxed/simple;
	bh=Ruw0SOBmANT0vxffjrMQywQ3ulDk7wSCRg+DW4rBQyc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBOpT6ISSgADnMDwhtinnxuMvBA6ySQ9s56b1+fv93uF1OUGfh/iRFmX7FqKhNG/3ocH/2mxQ9x5IYnH6v0oURVMe9/oYBIPTTNsMDTZDzOEZk/YsTfgXoJyzdIVs64pZq0PkEE5TujygJJlc2oy6+j/45ftVztJWMZrWOzbSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2iia2h4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2iia2h4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41201F000FF;
	Thu, 10 Sep 2026 08:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789028116;
	bh=cBvIB5TYupW+Z6yAgdUlBTiX/pY+svsenb2J97lcoMw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l2iia2h4vw4uEGPRMUQnffAOao/BB6P2eHZr25ID+KE5nyct48UA3xsYb3aEQxvle
	 xhEkX9imlJc3l7yMEJ18hqkbyL+IeipodnY5whEyMlgKt0LZn4lFS1M8Y0io3ZedF0
	 IEiwNt6EmD/jdXqyMrIeraGP+qSELXoJpCqIQ4AZkCO4g2KfS6+K2th4fVvPa/vDZ+
	 xIsmM3DImYg1yoZCt6THD7FSD3+yy4uNG/4S2gMqYh2xO28W+9AjS4/aFN9jvRxjos
	 qF9cDBAG1gb62lPt+PbxRYOG978mzMs5oHDF4ulNJbggDGzKscJziiixF7UGdzr3Uu
	 vQKIBoRsLntDA==
Subject:
 Re: [PATCH net-next v15] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
 jie.han@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Date: Thu, 10 Sep 2026 08:15:15 +0000
Message-ID: <178902811520.219967.15378845257301961249@kernel.org>
In-Reply-To: <20260909074911.2378402-1-kyle.switch@motor-comm.com>
References: <20260909074911.2378402-1-kyle.switch@motor-comm.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] New, undocumented device-tree ABI for YT8824.
- [Medium] Lock-initialization race: priv->shared_lock is mutex_init()'d
  (motorcomm.c:4624) and priv->interface_mode published (4625) *after*…
- [Low] yt8824_restore_working_status()'s kernel-doc summary says "called
  to do store working status" while the function stores nothing: it…

--

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

This adds support for the Motorcomm YT8824 quad-port 2.5G PHY to the
existing motorcomm driver, sharing the top extended register space through
the phy_package helpers. It also exports a new phylib helper,
genphy_c45_template_testmode(), and adds the 10GBASE-T test mode register
definitions to the uapi mdio header.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 90a4f86f2758..86f1e93aa82d 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -626,11 +722,1056 @@ static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)

[ ... ]

> +/**
> + * yt8824_restore_working_status() - called to do store working status
> + * @phydev: a pointer to a &struct phy_device
> + * @ret: operation's return code
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_restore_working_status(struct phy_device *phydev, int ret)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int r;
> +
> +	/* configure normal test mode */
> +	r = yt8824_utp_normal_test_mode_paged(phydev);
> +	if (ret >= 0 && r < 0)
> +		ret = r;

[Severity: Low]
This isn't a bug, but the kernel-doc summary says "called to do store
working status" while the body stores nothing.  It calls
yt8824_utp_normal_test_mode_paged() and, for the non-internal interface
mode, yt8824_sds_isolate_and_softreset_paged(), so it restores the PHY to
its working configuration.  Should the summary say something like
"restore the PHY working configuration"?

[ ... ]

> +/**
> + * yt8824_phy_package_probe_once()  - init phy packet for phy8824.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
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
> +		phydev_warn(phydev, "%s, motorcomm,interface-mode missing in DTS.\n",
> +			    __func__);
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Is there a device tree binding update planned for this?  This introduces a
new vendor property, motorcomm,interface-mode, read from the PHY package
node, with the legal values fixed by
phy_modes(PHY_INTERFACE_MODE_USXGMII) and
phy_modes(PHY_INTERFACE_MODE_INTERNAL).

The only Motorcomm PHY schema,
Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml, is not touched
by this patch and lists only:

    enum:
      - ethernet-phy-id4f51.e91a
      - ethernet-phy-id4f51.e91b

so there is no YT8824 compatible (ethernet-phy-id4f51.e8b8), no
description of the package node layout, and no description of the new
property.  Without that, can dt_binding_check or dtbs_check validate boards
using this part, and how do device tree authors know which node carries
the property?

An in-tree example of a documented vendor property on a PHY package node is
Documentation/devicetree/bindings/net/qcom,qca807x.yaml.

> +
> +/**
> + * yt8824_probe() - phy8824 probe.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct yt8824_shared_priv *shared_priv;
> +	int ret;
> +
> +	ret = devm_of_phy_package_join(dev, phydev, sizeof(*shared_priv));
> +	if (ret)
> +		return ret;

[Severity: Medium]
Related to the binding question above: this call is unconditional, and
of_phy_package_join() in drivers/net/phy/phy_package.c requires a specific,
currently undocumented device tree topology:

    if (!of_node_name_eq(package_node, "ethernet-phy-package")) {
        ret = -EINVAL;

It also requires the PHY to have an OF node and the package node to carry a
reg property.  Does a board that describes this part as four ordinary PHY
nodes, or a non-OF system, then fail probe with -EINVAL and leave the ports
unusable?

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
Can a sibling PHY of the same package use priv->shared_lock before it has
been initialised?

phy_package_probe_once() is only an election:

drivers/net/phy/phy_package.c:__phy_package_set_once() {
    ...
	return !test_and_set_bit(b, &shared->flags);
    ...
}

It does not wait for the winner to finish, so:

CPU0                                CPU1
yt8824_probe()
  phy_package_probe_once() -> true
                                    yt8824_probe()
                                      phy_package_probe_once() -> false
                                      return 0
                                    phy_probe()
                                      yt8824_get_features()
                                        mutex_lock(&priv->shared_lock);
  yt8824_phy_package_probe_once()
    mutex_init(&priv->shared_lock);
    priv->interface_mode = ...;

The shared priv is allocated zeroed by phy_package_join(), so CPU1 would
lock a mutex that has not been through mutex_init() and would read
priv->interface_mode as 0 (PHY_INTERFACE_MODE_NA), which selects the
external SerDes paths in yt8824_config_init() and
yt8824_restore_working_status().

dp83640_probe() wraps the same pattern in the package lock for this reason:

drivers/net/phy/dp83640.c:dp83640_probe() {
    ...
	/* Ensure other PHY probes wait for shared clock initialization. */
	phy_package_lock(phydev);
	if (phy_package_probe_once(phydev))
		dp83640_clock_init(clock);
	phy_package_unlock(phydev);
    ...
}

Would phy_package_lock()/phy_package_unlock() around the once-block here be
appropriate too?

Note also that when the property parse returns -EINVAL, the once bit stays
set, so no other port in the package will retry the shared initialisation.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909074911.2378402-1-kyle.switch%40motor-comm.com
