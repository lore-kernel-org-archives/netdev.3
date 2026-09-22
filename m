Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BA35DA40;
	Tue, 22 Sep 2026 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046658; cv=none; b=BmkY9Fg/Mw/OMcWpt3a2mgDZEtalp0AOqrm53ksbEpBMTGZej8p3exC5l7rsgEnndngsXY3YbGQv3tGUmk8ztTuC93XKOQPP6oB0t3SsF1SH9DCQdJ3adNbkeYY6hIKqL0lmNm9440AszrPl7pg3rsTJGFxdUJU1BXLHHSOjFeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046658; c=relaxed/simple;
	bh=NllU/WOrUsmJskpSVrPDTGRzxl46+qwRZZY2NvEUyxE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4uNxR2r7FOQJ0xPowQJz4JLWEdMmFG/NI8zD6RgdAUprIyMVlRz0xNOAtvdlBR1QuFhOh08DCuftEFQPnoX8rOxcQBrquB6UjLfwWcI/h9OqkLdob7sIhXb9BlWCuL2rVIbgZDozNz5pIpsVuQAR7VnMGLAT4U3AuM2C4v5k+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr4rXcS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr4rXcS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8771F000FF;
	Tue, 22 Sep 2026 03:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790046657;
	bh=JuRCpvKO2FyROzwUiWDogYR8vNf+2vmDwHRyUrGgkfU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zr4rXcS8NWbl/AZ1+KRIWVSTmrY0JXrchZDednHjdMwHQAWDMAKWSLWXC3rmg7b3U
	 qJemHH70twb0wbVmRxadYffvmudSGHw+1pxSuS8jbHk2E4A9oHiZ7zffPg1WNzbAus
	 ed781A8fePSE/WqP531H7YHO1qXvwPSylFlr1fJrrnsSpgKF4JOp6cdIaVquHd9sK2
	 gbPjJ4DjRYn7Kkg3tnVnieDLpoWFZpB2jpJwDTxrCq76HFe5KxKVYqOqvJQYns0Oj8
	 D2s70+VGoaNw7bZk5A5xvsA8tbk92LO1B2oflhx/621hQwyd4ry9Vlq+avkLvrkxGZ
	 0RL9I33ghv2BA==
Subject: Re: [PATCH net] net: bcmgenet: add hwtstamp callbacks to restore PHY
 timestamping
From: netdev-bot+sashiko@kernel.org
To: jjc@jclark.com
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com, netdev@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, kory.maincent@bootlin.com
Date: Tue, 22 Sep 2026 03:10:55 +0000
Message-ID: <179004665570.2160803.5770454161179957984@kernel.org>
In-Reply-To: <20260918030149.80398-1-jjc@jclark.com>
References: <20260918030149.80398-1-jjc@jclark.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Fix applied at the wrong layer: the regression the commit
  message diagnoses ("the core rejects timestamp configuration requests…
- [Medium] Registering ndo_hwtstamp_get/ndo_hwtstamp_set on a MAC that
  has no PHC opens a one-way trap on the ETHTOOL_MSG_TSCONFIG_SET path.

--

net: bcmgenet: add hwtstamp callbacks to restore PHY timestamping

This adds ndo_hwtstamp_get() and ndo_hwtstamp_set() stubs to bcmgenet that
both return -EOPNOTSUPP, so that the core hwtstamp entry points no longer
reject SIOCSHWTSTAMP/SIOCGHWTSTAMP before the phylib helpers get a chance to
dispatch to a timestamp-capable PHY.  No other behaviour is changed.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index b916080f4ff1..98d861811328 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -3721,6 +3721,19 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
>  	return 0;
>  }
>  
> +static int bcmgenet_hwtstamp_get(struct net_device *dev,
> +				 struct kernel_hwtstamp_config *cfg)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int bcmgenet_hwtstamp_set(struct net_device *dev,
> +				 struct kernel_hwtstamp_config *cfg,
> +				 struct netlink_ext_ack *extack)
> +{
> +	return -EOPNOTSUPP;
> +}
> +

[Severity: High]

Should this be fixed in net/core instead of per driver?  The commit message
describes the failure as "the core rejects timestamp configuration requests
before they reach the PHY", and the rejecting code is provider independent:

net/core/dev_ioctl.c:dev_get_hwtstamp() {
	if (!ops->ndo_hwtstamp_get)
		return -EOPNOTSUPP;
	...
}

net/core/dev_ioctl.c:dev_set_hwtstamp() {
	...
	if (!ops->ndo_hwtstamp_set)
		return -EOPNOTSUPP;
	...
}

The same presence test exists in generic_hwtstamp_get_lower(),
generic_hwtstamp_set_lower() and in ethnl_set_tsconfig_validate()
(net/ethtool/tsconfig.c):

	if (!ops->ndo_hwtstamp_set || !ops->ndo_hwtstamp_get)
		return -EOPNOTSUPP;

These are the lines 5062245a5a7f turned from a dev_eth_ioctl() fallback into
a hard error, so every MAC whose PTP comes only from the PHY is affected, not
just bcmgenet.

Two drivers in the same directory still have no ndo_hwtstamp_* and rely on
phylib ioctl handling:

drivers/net/ethernet/broadcom/bgmac.c:
	.ndo_eth_ioctl           = phy_do_ioctl_running,

drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c:
	.ndo_eth_ioctl		= phy_do_ioctl_running,

arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dts wires bgmac's gmac0 to
a BCM54210E, and that PHY driver calls bcm_ptp_probe() and sets
phydev->default_timestamp = true, so that board still fails SIOCSHWTSTAMP
after this patch.  Would skipping the NDO presence test when
phy_is_default_hwtstamp(dev->phydev) is true cover all of these at once?

A related question about the stubs themselves: since dev_set_hwtstamp_phylib()
only calls the MAC callback when !phy_ts or dev->see_all_hwtstamp_requests,
and bcmgenet sets neither, are these two functions ever invoked in the PHY
case?  If they exist purely as a capability signal, would a comment saying so
help, so a later "these always fail, remove them" cleanup does not silently
bring the failure back?

>  static const struct net_device_ops bcmgenet_netdev_ops = {
>  	.ndo_open		= bcmgenet_open,
>  	.ndo_stop		= bcmgenet_close,
> @@ -3732,6 +3745,8 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
>  	.ndo_set_features	= bcmgenet_set_features,
>  	.ndo_get_stats64	= bcmgenet_get_stats64,
>  	.ndo_change_carrier	= bcmgenet_change_carrier,
> +	.ndo_hwtstamp_get	= bcmgenet_hwtstamp_get,
> +	.ndo_hwtstamp_set	= bcmgenet_hwtstamp_set,
>  };

[Severity: Medium]

Can advertising these NDOs on a MAC without a PHC make the
ETHTOOL_MSG_TSCONFIG_SET path reachable in a way that cannot be undone?

bcmgenet uses .get_ts_info = ethtool_op_get_ts_info, which reports
info->phc_index = -1.  Before this patch ethnl_set_tsconfig_validate()
returned -EOPNOTSUPP for bcmgenet, so ethnl_set_tsconfig() was never reached.
With both NDOs present, validation passes.

Consider this sequence:

1. TSCONFIG_SET selecting the PHY provider (index = the PHY phc_index), so
   dev->hwprov is non-NULL and PHY timestamping works.

2. TSCONFIG_SET with ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX = 0xFFFFFFFF and
   QUALIFIER = 0.  ts_parse_hwtst_provider() stores that through
   ethnl_update_u32() into the int index field of struct
   hwtstamp_provider_desc, giving -1.

net/ethtool/common.c:ethtool_net_get_ts_info_by_phc() {
	...
	if (info->phc_index == hwprov_desc->index &&
	    net_support_hwtstamp_qualifier(dev, hwprov_desc->qualifier))
		return 0;
	...
}

-1 == -1 matches, and net_support_hwtstamp_qualifier() returns true because
bcmgenet declares no supported_hwtstamp_qualifiers, so the provider becomes
HWTSTAMP_SOURCE_NETDEV with phydev = NULL.

ethnl_set_tsconfig() first disables the working PHY timestamper with
dev_set_hwtstamp_phylib(zero_config) and then installs that provider:

net/ethtool/tsconfig.c:ethnl_set_tsconfig() {
	...
		__hwprov = rcu_replace_pointer(dev->hwprov, hwprov,
					       netdev_is_locked_ops_compat(dev));
	...
}

>From there dev_get_hwtstamp_phylib() and dev_set_hwtstamp_phylib() take the
HWTSTAMP_SOURCE_NETDEV branch:

net/core/dev_ioctl.c:dev_set_hwtstamp_phylib() {
	...
		} else if (hwprov->source == HWTSTAMP_SOURCE_NETDEV) {
			phy_ts = false;
	...
}

so the PHY is never consulted and bcmgenet_hwtstamp_set() returns
-EOPNOTSUPP.

Does that also block recovery?  Reselecting the PHY provider runs the
zero-config disable step first, which now hits the NETDEV branch and the stub,
so ethnl_set_tsconfig() bails out through err_free_hwprov without replacing
dev->hwprov.  dev->hwprov is only cleared in phy_detach() when
hwprov->phydev matches the detaching phydev, which is NULL here, so ifdown
and ifup would not clear it either.

The permissive -1 comparison itself lives in core and predates this change,
but is this patch what makes it reachable for bcmgenet?  Would declaring a
real .get_ts_info (or rejecting an index of -1) avoid it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918030149.80398-1-jjc%40jclark.com
