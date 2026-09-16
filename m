Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60239175A64;
	Wed, 16 Sep 2026 03:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789530860; cv=none; b=P5WHBJoTQyLTMIUUgrfHXVfnk9RUZiOyLUVMPFbkHPBdfMM2NIxC3m+mHTW+syvw1cr6IBxTSqNAcZ1h/hm9Y77bO3uEcnLOq4+lRp0OXsEsnGMGyJUdiNyzFlHzQsVPLIXBzh/pZ1MlyNLRTKpFvaLCXIgWAkuaTXD/urBt9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789530860; c=relaxed/simple;
	bh=gCjz99/UnnRvnz0uHk/SL0imF7as2IQWe+io+FdK2J0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JPmEbU5/Q/AGXh9ejBo4WvTc30FSEfsq0cBJCspaEB8P3w8eaOACyC0n+ZwDOgOf4i3fAzeizguqZhrAbDd3sVhoMT5kVl27yKlp0GtEk5LEHwf1A4fvk6gRbtVxTMXOisy+CR984hNv1gVCitlA7kNx9M79H2VeYaQrioji5xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5nbF4Zp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5nbF4Zp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5051F00893;
	Wed, 16 Sep 2026 03:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789530859;
	bh=S2KABOWXR0jyUKxCRU/Fp1et3tKFdCpRqT9SZgbexh8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g5nbF4ZpGFJGjb1dRlkf/zYSMyku/6FLUFANwK/wMtU9DzKrki3RQcHY/nm6g1pDx
	 R1UKyG9pNbR18TM8Wt6AglA/IKeMNmW/zyZlb7qUip/I5h5JYkvzaxxBbIIzpNqmUn
	 r4I5VyrFq4fQ7mGo7dHMVda0SKb5/k+Xy2iZKdZsOiODbDSqGpBtL7/AqRdHvGoyt/
	 YGkBLus+iUFXM8GiIuhcPpIzX10GtZBI04WsAVSxGuCXVhDAs+bSO8ty5sK4rTSq4G
	 tPgCfugY0AtOz+0p9LBvuxnOED112Ivppw4mp227eE79tJNa3VEDODcfTY0/Tr6LxZ
	 bfYYqK2veHwMw==
Subject: Re: [PATCH net-next v17 2/2] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
 jie.han@motor-comm.com
Date: Wed, 16 Sep 2026 03:54:17 +0000
Message-ID: <178953085772.22033.4285169765061794363@kernel.org>
In-Reply-To: <20260912065224.2723883-3-kyle.switch@motor-comm.com>
References: <20260912065224.2723883-3-kyle.switch@motor-comm.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 2

- [High] YT8824 MAC-side interface mode is not taken from
  phydev->interface (as every other PHY in motorcomm.c does) but from a…
- [Medium] All package-wide state (mutex_init(&priv->shared_lock) at
  drivers/net/phy/motorcomm.c:4626 and priv->interface_mode at 4627) is…
- [Low] The YT8824 .aneg_done callback (yt8824_aneg_done,
  drivers/net/phy/motorcomm.c:4278) reports link state instead of auto-…
- [Low] The YT8824 binding example names the package node ethernet-phy-
  package@0 but gives it reg = <9>…

--

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

This adds YT8824 quad-port 2.5G support to the existing motorcomm driver,
sharing the top extended register space through the phy_package helpers,
and exports a new phylib helper genphy_c45_template_testmode().

A few questions about the new YT8824 code below.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 90a4f86f2758b..7f949ab53b547 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -3104,6 +4247,429 @@ static int yt8821_resume(struct phy_device *phydev)

[ ... ]

> +/**
> + * yt8824_aneg_done()  - check negotiation state.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: link status or negative errno code
> + */
> +static int yt8824_aneg_done(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int link = 0;
> +	int ret = 0;
> +
> +	mutex_lock(&priv->shared_lock);
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		goto err;
> +
> +	ret = phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
> +	if (ret < 0)
> +		goto err;
> +	mutex_unlock(&priv->shared_lock);
> +	link = !!(ret & YTPHY_SSR_LINK);
> +
> +	phydev_dbg(phydev, "%s, phy addr: %d, link_utp: %d\n",
> +		   __func__, phydev->mdio.addr, link);
> +	return link;

[Severity: Low]
Should .aneg_done report auto-negotiation completion rather than link
state?  The kernel-doc above says "Returns: link status", and the value
returned here is the vendor YTPHY_SSR_LINK bit.

The phylib contract in phy_aneg_done() is:

drivers/net/phy/phy.c:
 * Returns > 0 on success or < 0 on error. 0 means that auto-negotiation
 * is still pending.

and the generic implementation genphy_aneg_done() derives that from
BMSR_ANEGCOMPLETE, which is a different condition from link-up (forced
links, or auto-negotiation completing before the link is usable).

The one in-tree consumer, phy_poll_aneg_done(), loops on zero:

drivers/net/phy/phy.c:phy_poll_aneg_done() {
	do {
		msleep(100);
		ret = phy_aneg_done(phydev);
	} while (!ret && --retries);

	if (!ret)
		return -ETIMEDOUT;
}

so with the link down a caller such as phy_speed_down() spends the full
poll interval and then gets -ETIMEDOUT.  This isn't new behaviour for this
driver, since yt8821_aneg_done() and yt8521_aneg_done_paged() do the same
thing, but should the new part follow the documented contract?

[ ... ]

> +/**
> + * yt8824_phy_package_probe_once()  - init phy package for phy8824.
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
> +	if (!of_property_read_string(np, "phy-mode",
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
> +		phydev_warn(phydev, "%s, phy-mode missing in DTS.\n",
> +			    __func__);
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Why is the MAC-side mode parsed out of a phy-mode string in the package
node instead of coming from phydev->interface?  YT8511, YT8521, YT8531S
and YT8821 in this same file all use phydev->interface, and the new YT8824
code never reads it.

Can a missing or unparsable property leave a wrong configuration in place?
The default is assigned before the read, and any of_property_read_string()
failure only warns and then returns success, so priv->interface_mode stays
PHY_INTERFACE_MODE_INTERNAL.

For an external YT8824 wired over USXGMII, yt8824_config_init() then takes
the internal branch:

drivers/net/phy/motorcomm.c:yt8824_config_init() {
	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
		ret = yt8824_internal_config_init_paged(phydev);
		...
	} else {
		ret = yt8824_extern_config_sds_init_paged(phydev);
		...
		ret = yt8824_extern_config_utp_init_paged(phydev);
	}
}

which means yt8824_extern_config_sds_init_paged() never runs, so the
efuse-derived PLL/VCO trim (ext 0x0429/0x0441/0x042b), the SerDes LDO trim
(0x04b5/0x04b4), the CDR/RX/TX settings, the min-preamble and fill-preamble
configuration and the SerDes calibration restart are all skipped.

The same value also gates yt8824_sds_isolate_and_softreset_paged() from
yt8824_restore_working_status(), yt8824_power_on(), yt8824_power_down() and
yt8824_soft_reset(), so the SerDes can stay in whatever isolate/reset state
it powered up in, while probe and config_init both report success.

The binding added by the preceding patch in the series,
Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml, lists
phy-mode under required: but never declares it under properties:, and
ethernet-phy-package.yaml does not define it either.  So the documented
ABI has no type or value set, while the driver rejects with -EINVAL every
other schema-legal value and uses strcasecmp, accepting spellings the
lowercase DT convention does not use.  Could the legal values be
enumerated in the binding, and could an absent or unparsable required
property be a hard error rather than a silent default?

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
Should this be wrapped in phy_package_lock()/phy_package_unlock(), the way
dp83640_probe() does it, so the other members wait for the shared
initialisation?

phy_package_probe_once() only publishes a one-shot bit:

drivers/net/phy/phy_package.c:__phy_package_set_once() {
	return !test_and_set_bit(b, &shared->flags);
}

It returns false for the other members immediately, before
yt8824_phy_package_probe_once() has run mutex_init(&priv->shared_lock) and
assigned priv->interface_mode.  The shared area comes from
phy_package_join():

drivers/net/phy/phy_package.c:phy_package_join() {
	shared->priv = kzalloc(priv_size, GFP_KERNEL);
}

So can a losing member's probe return 0 and have phy_probe() call
.get_features straight away, where yt8824_get_features() does
mutex_lock(&priv->shared_lock) on an all-zero mutex and reads
interface_mode == 0 (PHY_INTERFACE_MODE_NA, which selects the external
branch everywhere)?

Separately, when yt8824_phy_package_probe_once() returns -EINVAL the
one-shot bit stays set, since it is only cleared when the shared struct is
freed as the last member leaves.  Any member that already joined can then
never redo the initialisation, and the remaining members run with the
zeroed state instead of the configuration error being propagated.  Would
recording the init result in the shared priv and checking it from the other
members address that?

[ ... ]

[Severity: Low]
One more on the binding in the preceding series patch, "dt-bindings: net:
Document Motorcomm YT8824 PHY package".  The example names the package node

        ethernet-phy-package@0 {
            ...
            compatible = "motorcomm,yt8824-package";
            reg = <9>;

Should the unit address match the first reg address, that is
ethernet-phy-package@9?  As written dt_binding_check should emit a
unit_address_vs_reg warning for the example.

The child PHYs in the same example are at reg 4 to 7, all below the
declared package base of 9, which also reads oddly against
ethernet-phy-package.yaml:

  reg:
    minimum: 0
    maximum: 31
    description:
      The base ID number for the PHY package.
      Commonly the ID of the first PHY in the PHY package.

Is reg = <9> intended here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912065224.2723883-1-kyle.switch%40motor-comm.com
