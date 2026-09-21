Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6446D540;
	Mon, 21 Sep 2026 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984672; cv=none; b=Dca+U0QGx8EpkIgPItORjaylzlcsfG9HP9TUCOCNPQwuezCP54I1Bv+jYwtWHTJEyvrvNRGF7WiULdQZBLHQZF3Pq5Bpp5r77QfTY3CIlQ/6XWCdb3r+AgCs7euzuquldPtqzJdOvgHtVjloaLDFDPjJqvxJP5hfH81DtkDNLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984672; c=relaxed/simple;
	bh=LkyOuO48Am+yJ1OXWE3MbaROGlTK7J6JilxoxnXKs1k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u28NDm6y5PeGMqnna+LB4EP3f11BuUErcnG4LXXY4Uimf3nloEK4ByHVwu9iDF/y5DaQTty05U/pQttGp62u26ICu8cvMGcbZ0tPbD0P2UO1FAco7MTygc9eCDeoXClGGf2MRgN05WfKFkmi7wDYZLqzaQ+8Ll70TVtsFZRo45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqyMndfd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqyMndfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1081F000FF;
	Mon, 21 Sep 2026 09:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984670;
	bh=LWDf7Z4urWWk1OLakaZebmc5Ei86IWbtJatcDASCO2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZqyMndfdFlOk7NVkd9QfEfzFHMfD+3k5Xfm5HsNs6FzlE0voWRlvb0YbZno/nB9dG
	 wCGCh9RAT6/uK1SOYaaBUKpyR+a9unpo2G37CxJKObHI1C9Sd+R/a26x7Hr6Y35Z6m
	 lu36ylZvZlQ+auC8a0qWSi4mQVitNoLQpO7hDwc1Xl2mQJAt+D4+yASHM8hHnkJs6f
	 75cf/dT+pslptD0a04C7R7UBEUDywCIzS8UI85dbJTQa4C0zmZyaNUzHPxy9lq9CcB
	 Jou6n8vV/aOjBWNMbEe7b5ArCsMjZ0VckdA3+dOMwKEzCwvIbtNUUJZW10AvjFioQT
	 H7OQ8FXpxP/Sg==
Subject: Re: [PATCH net] net: don't require the hwtstamp NDOs when a PHY
 provides timestamping
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev, jjc@jclark.com,
 florian.fainelli@broadcom.com, opendmb@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 09:57:49 +0000
Message-ID: <178998466913.2160803.80702009306181180@kernel.org>
In-Reply-To: <20260918095540.34286-1-nb@tipi-net.de>
References: <20260918095540.34286-1-nb@tipi-net.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete fix: the ethtool-netlink tsconfig path still
  rejects PHY-only devices, so the two documented-equivalent uAPIs now…

--

net: don't require the hwtstamp NDOs when a PHY provides timestamping

This moves the ndo_hwtstamp_get/ndo_hwtstamp_set presence checks out of
dev_get_hwtstamp()/dev_set_hwtstamp() and the generic_hwtstamp_*_lower()
helpers, and puts them where the callbacks are actually invoked, so a
device that only timestamps in its PHY can use SIOCGHWTSTAMP and
SIOCSHWTSTAMP again.

> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index a320e264eaaf..164643140a52 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -276,19 +276,18 @@ int dev_get_hwtstamp_phylib(struct net_device *dev,
>  	if (phy_is_default_hwtstamp(dev->phydev))
>  		return phy_hwtstamp_get(dev->phydev, cfg);
>  
> +	if (!dev->netdev_ops->ndo_hwtstamp_get)
> +		return -EOPNOTSUPP;
> +
>  	return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
>  }
>  
>  static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
>  {
> -	const struct net_device_ops *ops = dev->netdev_ops;
>  	struct kernel_hwtstamp_config kernel_cfg = {};
>  	struct hwtstamp_config cfg;
>  	int err;
>  
> -	if (!ops->ndo_hwtstamp_get)
> -		return -EOPNOTSUPP;
> -
>  	if (!netif_device_present(dev))
>  		return -ENODEV;
>  
> @@ -359,12 +358,18 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
>  	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
>  
>  	if (phy_ts && dev->see_all_hwtstamp_requests) {
> +		if (!ops->ndo_hwtstamp_get)
> +			return -EOPNOTSUPP;
> +
>  		err = ops->ndo_hwtstamp_get(dev, &old_cfg);
>  		if (err)
>  			return err;
>  	}
>  
>  	if (!phy_ts || dev->see_all_hwtstamp_requests) {
> +		if (!ops->ndo_hwtstamp_set)
> +			return -EOPNOTSUPP;
> +
>  		err = ops->ndo_hwtstamp_set(dev, cfg, extack);
>  		if (err) {
>  			if (extack->_msg)

[Severity: Medium]
With the checks relocated here, the ioctl entry points now reach
phy_hwtstamp_get()/phy_hwtstamp_set() for a device whose MAC implements
neither NDO but whose phydev satisfies phy_is_default_hwtstamp().  The
ethtool netlink peers of those ioctls keep the old unconditional gates,
and they run before these helpers are ever called.

net/ethtool/tsconfig.c:tsconfig_prepare_data() {
	...
	if (!dev->netdev_ops->ndo_hwtstamp_get)
		return -EOPNOTSUPP;

	ret = ethnl_ops_begin(dev);
	...
	ret = dev_get_hwtstamp_phylib(dev, &cfg);
	...
}

net/ethtool/tsconfig.c:ethnl_set_tsconfig_validate() {
	const struct net_device_ops *ops = req_base->dev->netdev_ops;

	if (!ops->ndo_hwtstamp_set || !ops->ndo_hwtstamp_get)
		return -EOPNOTSUPP;

	return 1;
}

Does this leave the two interfaces disagreeing on the same hardware?  On
the bcmgenet plus BCM54213PE setup named in the changelog,
SIOCGHWTSTAMP/SIOCSHWTSTAMP would succeed after this patch, while
ETHTOOL_MSG_TSCONFIG_GET and ETHTOOL_MSG_TSCONFIG_SET would still return
-EOPNOTSUPP, even though Documentation/networking/ethtool-netlink.rst
lists those netlink operations as the replacements for the two ioctls in
its ioctl-to-netlink mapping table.

The note about this ("tsconfig keeps its own copy of the check ... IMHO
this is an extra patch for net-next") sits below the --- separator, so it
does not end up in git history.  Could it be moved into the commit message
so that maintainers and stable backporters can see that PHY-only
timestamping devices are only fixed on the ioctl path?

One detail for whoever narrows the tsconfig gates later: the fix is not a
mechanical copy of this one.  The HWTSTAMP_SOURCE_NETDEV branch in
dev_get_hwtstamp_phylib() still calls the callback with no NULL test:

net/core/dev_ioctl.c:dev_get_hwtstamp_phylib() {
	...
	if (hwprov->source == HWTSTAMP_SOURCE_NETDEV)
		return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
	...
}

dev->hwprov is only ever assigned in ethnl_set_tsconfig(), which is
reached through ethnl_set_tsconfig_validate(), so that branch is safe
today precisely because of the check under discussion.  Should the two
sites be changed together?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918095540.34286-1-nb%40tipi-net.de
