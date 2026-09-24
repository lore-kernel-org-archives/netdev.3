Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710630D41F;
	Thu, 24 Sep 2026 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252405; cv=none; b=VmjDkls2VauhxA/PF4P7yNjl8p5AYaWQSU2NKCdP/Kv4AU8UQ1f3zkZmUvHKsV8QJ/n6QbN2MONDUf0W8XQLMAAuYFn4aAw2uNXLu16RNkUOyqt3k1ttstZ6Y8/2cvJuEI830iuxRywttaTf8EATMS25gfj9pIkWFyamF6oE8IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252405; c=relaxed/simple;
	bh=RI6IIGMOcUnTDad8UMdUIFxfWRJdRBMFe65r33rMKVs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYskD6YvYA5cXDAxMYsRoPjmBPeUlN9qHBrFY1/dW3sbcJPDIc/TePAqa+cpJ5C6tnn5p9UOUEBZ87ix7EcVtHKnXHHAJUJpA2/wHXCQclN+HRb+Zx/qqS3Bckf8CfwTU+KvLEP4qP86aG7r9iu9vGm1yMeV4AvcxVjB5TVy6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lts5Cd0c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lts5Cd0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4AA1F00893;
	Thu, 24 Sep 2026 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790252404;
	bh=hzAxlskymR1IoDwgC79UlkXZ+hL3WPjPGFR+iB9I0nk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Lts5Cd0cBZtm+6YYUTEYYzlS0q5ixTC/nr19E+eJ5cGZahOtzVGEVklyL/gsBSPNq
	 MBdV6dEJlzuaixbAKCunOxlbi8RZaf+wvMpgvOwW95jQXE6EygzgmleHyCZtOVKysr
	 qBvWgjBzRZ4r89wmLmxgJI5jnkqFZn11Q9DSuNPvvzUIu6N069OgoPSpIM6YqgACYW
	 PR1S4QzSGg5E54tV4YDgSMlCJhSA0utdQXATgAIMylz1l9zTXTDgSXyxgUGsRCgIQi
	 xaVKdJr1bh27RS3vFHgRkT78fwLNlbczZGIPG/EP4WpHdoOIFLbcTScm/94L/68bnJ
	 uGsJC7G43s8Sg==
Subject: Re: [PATCH net v2 2/2] net: ethtool: let tsconfig reach a PHY-only
 timestamp provider
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kory.maincent@bootlin.com,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 12:20:03 +0000
Message-ID: <179025240309.2160803.13124415103175394580@kernel.org>
In-Reply-To: <20260923121644.2194183-3-nb@tipi-net.de>
References: <20260923121644.2194183-3-nb@tipi-net.de>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ethnl_set_tsconfig() can now install an HWTSTAMP_SOURCE_NETDEV
  provider on a device that has no hwtstamp NDOs, and that provider can…
- [Low] The new TSCONFIG_SET gate in ethnl_set_tsconfig()
  (tsconfig.c:303-305) looks only at whether dev->phydev is the default…

--

net: ethtool: let tsconfig reach a PHY-only timestamp provider

This commit lets TSCONFIG_GET and TSCONFIG_SET work on devices that have
no hwtstamp NDOs but whose PHY can timestamp. It drops the NDO check on the
get side. It replaces the set_validate callback with a check inside
ethnl_set_tsconfig() that also accepts a default timestamping PHY, and it
adds a NULL check for ndo_hwtstamp_get in dev_get_hwtstamp_phylib().

> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index 164643140a523..f6029f60c1dc9 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -267,7 +267,8 @@ int dev_get_hwtstamp_phylib(struct net_device *dev,
>  		    hwprov->phydev)
>  			return phy_hwtstamp_get(hwprov->phydev, cfg);
>  
> -		if (hwprov->source == HWTSTAMP_SOURCE_NETDEV)
> +		if (hwprov->source == HWTSTAMP_SOURCE_NETDEV &&
> +		    dev->netdev_ops->ndo_hwtstamp_get)
>  			return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
>  
>  		return -EOPNOTSUPP;

[Severity: Medium]

The commit message says "this makes a netdev provider reachable without
ndo_hwtstamp_get". Should a netdev provider be reachable at all on a device
without the NDOs?

With ethnl_set_tsconfig_validate() removed, the only gate left is the new
check in ethnl_set_tsconfig(). That check lets an NDO-less device through
whenever dev->phydev is the default timestamping PHY.

After that, tsconfig_set_hwprov_from_desc() chooses the netdev source based
only on a PHC index match:

	ret = ethtool_net_get_ts_info_by_phc(dev, &ts_info, hwprov_desc);
	if (!ret) {
		/* Found */
		source = HWTSTAMP_SOURCE_NETDEV;

ethtool_net_get_ts_info_by_phc() compares only the get_ts_info phc_index and
the qualifier. It never looks at the NDOs.

Suppose user space selects the MAC PHC on such a device. Then:

ethnl_set_tsconfig()
  dev_set_hwtstamp_phylib(dev, &zero_config, ...)
    /* no hwprov yet, goes to default PHY, disables PHY timestamping */
  rcu_replace_pointer(dev->hwprov, hwprov, ...)
    /* NETDEV hwprov is committed */
  if (config_mod)
    dev_set_hwtstamp_phylib(dev, &hwtst_config, ...)
      if (!ops->ndo_hwtstamp_set)
          return -EOPNOTSUPP;

That error is returned, but the provider is not rolled back.

If no config attributes are given, tsconfig_send_reply() gets -EOPNOTSUPP
from the new guard above, and ethnl_set_tsconfig() ignores it:

	ret = tsconfig_send_reply(dev, info);
	if (ret && ret != -EOPNOTSUPP) {

The request then returns 0 and no reply is sent.

Can the device get out of this state afterwards? Switching back to the PHY
runs the zero_config disable through the NETDEV branch of
dev_set_hwtstamp_phylib(). That fails at the same !ops->ndo_hwtstamp_set
check.

SIOCSHWTSTAMP, SIOCGHWTSTAMP and TSCONFIG_GET also return -EOPNOTSUPP. Both
skb_defer_rx_timestamp() and skb_clone_tx_timestamp() skip the PHY because
hwprov->source is not PHYLIB. phy_detach() clears dev->hwprov only when
hwprov->phydev matches, so it never clears this provider.

As far as I can tell, PHY timestamping stays off until the netdev is
re-created.

I could not find an in-tree driver that meets all the conditions. ena and
netdevsim report a PHC without the NDOs, but they have no phydev. The
commit message does suggest this state is expected to be reachable, though.

Would it be better to reject a netdev source in
tsconfig_set_hwprov_from_desc() or ethnl_set_tsconfig() when ndo_hwtstamp_set
or ndo_hwtstamp_get is missing, rather than only guarding the call here?

> diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
> index 6be3aa5d4bc1e..2b1cdd9b5a232 100644
> --- a/net/ethtool/tsconfig.c
> +++ b/net/ethtool/tsconfig.c

[ ... ]

> @@ -313,6 +300,10 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
>  	if (!netif_device_present(dev))
>  		return -ENODEV;
>  
> +	if (!dev->netdev_ops->ndo_hwtstamp_set &&
> +	    !phy_is_default_hwtstamp(dev->phydev))
> +		return -EOPNOTSUPP;
> +

[Severity: Low]

This check runs before dev->hwprov or the requested provider is looked at,
and it only considers dev->phydev. Could it reject requests that an already
installed PHYLIB provider can serve?

dev_set_hwtstamp_phylib() serves an installed PHYLIB hwprov without needing
any NDO:

	if (hwprov) {
		if (hwprov->source == HWTSTAMP_SOURCE_PHYLIB &&
		    hwprov->phydev) {
			phy_ts = true;
			phydev = hwprov->phydev;

ethtool_phy_get_ts_info_by_phc() also accepts any timestamping PHY in
dev->link_topo. It does not require default_timestamp.

Take an NDO-less MAC whose dev->phydev is a default timestamper. A PHYLIB
hwprov for a different topology PHY, such as an SFP module PHY, can be
selected on it.

Some drivers disconnect the PHY in ndo_stop. If dev->phydev is detached that
way, phy_detach() leaves the hwprov alone because hwprov->phydev != phydev:

	if (hwprov && hwprov->phydev == phydev) {
		rcu_assign_pointer(dev->hwprov, NULL);

>From then on SIOCSHWTSTAMP still works through hwprov->phydev. TSCONFIG_SET
fails with -EOPNOTSUPP at this check because dev->phydev is NULL. That is the
ioctl/netlink mismatch the commit sets out to remove.

This does not apply when a non-default PHY is selected for the first time.
In that case the zero_config disable step fails with or without this check,
so the check only matters once a PHYLIB hwprov is already installed. I also
have not confirmed the SFP and link topology lifetime details, so this
scenario may be narrower than described.

Would it make sense to move this check after provider resolution and also
accept an installed or requested PHYLIB provider?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923121644.2194183-2-nb%40tipi-net.de
