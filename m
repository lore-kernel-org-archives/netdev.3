Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA3541440F;
	Wed, 23 Sep 2026 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158210; cv=none; b=U6e4U+nahqE1elhA5oaa927N5Gn+37218n5H9mVrht+8tTfZbGEhWo4hewURlf4MMJtOzrKV6y7g0iFa6IsXu8exhFDxCcTM1CgvoXkR1066IFij9WzstXNjayR2ED1MqxVYgnYMJexZg8nT1N+IeRDsKsGqgG7Bw38i3DePHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158210; c=relaxed/simple;
	bh=YlRjqU7qdRO3t9HF1d76XSpTza3WLe/iIEq0QQAcP1Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJTkt99M3A9g/lD5to8Yk0ITujhchV4jEKD0IIQtGbSUjgI0nBcCUvm1WozNCsoHdJBbAY68T3eK66M22lFBxF49qWfXYzw7t9o3G0v7fBok4MgFoYcp4XtGV8BATF0GXr/psFM7O6LkFTx58GKCnuf8sWB6EVdR00W+B1JLKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHj2Z7Os; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHj2Z7Os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085A71F000FF;
	Wed, 23 Sep 2026 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790158203;
	bh=ZuKrVehW9NyrajvUxUA+Rr/3wR8H3So0oZQUFWwChDQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fHj2Z7OsugRX4pu2dhgT0sLcUnWK6BOQ1TBTe8Y41dPlDWZ6cj/3ixsSJ7VkKsa8y
	 3aParcnFSkyaaAnnRkZn7lg50efs350aETmqeROowAI486EMr593U3cyzHCnidBmaH
	 HJqCNQ95/fBJecSBVSAm8ji/9fIgaDI4kVnZUvJ6WlTX4lYP/gAzLTcy4uTTbqxrXB
	 cOlGnv4KahET5mRBIaO/ItoLk+dFMiniwR5y0OgMp7FH6s/gLm8EdQxoQ8X688ILIW
	 xzAi3IuCWMjsKKHSnR9gMKuDd70wbZRxkdOhYczKLUUESZxn6bp8lAy2XHSLfo2dqc
	 oarFCPVdtha2g==
Subject: Re: [PATCH net] net: ethtool: let tsconfig reach a PHY-only timestamp
 provider
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 kory.maincent@bootlin.com, jjc@jclark.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 10:10:02 +0000
Message-ID: <179015820246.2160803.17295463468229392731@kernel.org>
In-Reply-To: <20260922070813.1458713-1-nb@tipi-net.de>
References: <20260922070813.1458713-1-nb@tipi-net.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] TSCONFIG_SET now reports success (bare ACK, ret 0) with no
  ETHTOOL_MSG_TSCONFIG_SET_REPLY on devices that have no hardware…
- [Medium] With ethnl_set_tsconfig_validate() gone, ethnl_set_tsconfig()
  is reachable on netdevs that implement neither ndo_hwtstamp_get nor…
- [Medium] net: ethtool: TSCONFIG_SET provider switch fails on devices
  lacking ndo_hwtstamp_set

Pre-existing issues:
- [Medium] A struct hwtstamp_provider installed into dev->hwprov by
  TSCONFIG_SET is never freed when the netdevice is unregistered/freed…

--

net: ethtool: let tsconfig reach a PHY-only timestamp provider

This drops the ndo_hwtstamp_get check in tsconfig_prepare_data() and the
whole ethnl_set_tsconfig_validate() gate so that TSCONFIG_GET/SET can be
served by a PHY on a MAC that implements no hwtstamp NDO. A guard is added
in dev_get_hwtstamp_phylib() before calling ndo_hwtstamp_get.

Related discussion for the ioctl side:
https://lore.kernel.org/netdev/20260918095540.34286-1-nb@tipi-net.de/

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
This guard makes the read side safe, but can the install side now latch a
HWTSTAMP_SOURCE_NETDEV provider on a device that has no hwtstamp NDOs at
all, with no way back?

With ethnl_set_tsconfig_validate() gone, ethnl_set_tsconfig() runs on a MAC
like bcmgenet (no ndo_hwtstamp_*, .get_ts_info = ethtool_op_get_ts_info)
that has a default-timestamp PHY, e.g. BCM54213PE. Two requests:

1) TSCONFIG_SET with provider {index = PHY phc index, qualifier = precise}.
   dev->hwprov is still NULL and phy_is_default_hwtstamp(dev->phydev) is
   true, so dev_set_hwtstamp_phylib(&zero_config) succeeds through
   phy_hwtstamp_set() and the PHYLIB provider is installed.

2) TSCONFIG_SET with provider {index = 0xFFFFFFFF, qualifier = precise}.
   ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX is a plain NLA_U32 stored into the
   int hwtstamp_provider_desc.index, so the request index becomes -1. In
   ethtool_net_get_ts_info_by_phc():

	if (info->phc_index == hwprov_desc->index &&
	    net_support_hwtstamp_qualifier(dev, hwprov_desc->qualifier))
		return 0;

   ethtool_init_tsinfo() presets phc_index = -1 and ethtool_op_get_ts_info()
   leaves it at -1, and net_support_hwtstamp_qualifier() returns true for
   PRECISE when the driver declares no qualifier mask, so
   tsconfig_set_hwprov_from_desc() picks source = HWTSTAMP_SOURCE_NETDEV
   with phydev == NULL.

In ethnl_set_tsconfig() the hwprov_mod block then only disables the old
provider before committing the new one:

	ret = dev_set_hwtstamp_phylib(dev, &zero_config, info->extack);
	if (ret < 0)
		goto err_free_hwprov;

	/* Change the selected hwtstamp source */
	__hwprov = rcu_replace_pointer(dev->hwprov, hwprov,
				       netdev_is_locked_ops_compat(dev));

Nothing checks that the new NETDEV provider can be programmed, and there is
no rollback. After that, this hunk's guard returns -EOPNOTSUPP for every
GET, and dev_set_hwtstamp_phylib() takes the phy_ts = false path and stops
at its "if (!ops->ndo_hwtstamp_set)" check, so SIOCGHWTSTAMP/SIOCSHWTSTAMP
fail too.

Is recovery possible through the same interface? A later TSCONFIG_SET
re-selecting the PHY provider enters the hwprov_mod block and fails on its
first statement, dev_set_hwtstamp_phylib(&zero_config) evaluated against the
current NETDEV provider, jumping to err_free_hwprov before ever reaching
rcu_replace_pointer(). phy_detach() only clears dev->hwprov when
hwprov->phydev == phydev, which is NULL here, so ifdown or PHY disconnect
does not clear it either.

> diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
> index 6be3aa5d4bc1e..8c99b2dc26d03 100644
> --- a/net/ethtool/tsconfig.c
> +++ b/net/ethtool/tsconfig.c
> @@ -42,9 +42,6 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
>  	struct kernel_hwtstamp_config cfg = {};
>  	int ret;
>  
> -	if (!dev->netdev_ops->ndo_hwtstamp_get)
> -		return -EOPNOTSUPP;
> -
>  	ret = ethnl_ops_begin(dev);
>  	if (ret < 0)
>  		return ret;
> @@ -248,17 +245,6 @@ static int tsconfig_send_reply(struct net_device *dev, struct genl_info *info)
>  	return ret;
>  }
>  
> -static int ethnl_set_tsconfig_validate(struct ethnl_req_info *req_base,
> -				       struct genl_info *info)
> -{
> -	const struct net_device_ops *ops = req_base->dev->netdev_ops;
> -
> -	if (!ops->ndo_hwtstamp_set || !ops->ndo_hwtstamp_get)
> -		return -EOPNOTSUPP;
> -
> -	return 1;
> -}
> -

[Severity: Medium]
With ethnl_set_tsconfig_validate() gone, a TSCONFIG_SET that selects
the PHY provider now reaches ethnl_set_tsconfig() on a MAC without
hwtstamp NDOs. Does the provider switch itself ever succeed there
unless the PHY happens to be the default timestamper?

Take this setup:

  - a MAC with no ndo_hwtstamp_get/set
  - a PHY that implements timestamping but has
    phydev->default_timestamp cleared
  - dev->hwprov still NULL

A TSCONFIG_SET naming the PHY's phc index makes
tsconfig_set_hwprov_from_desc() return a HWTSTAMP_SOURCE_PHYLIB
provider. hwprov_mod is then true, and the handler first tries to turn
the current provider off:

	ret = dev_set_hwtstamp_phylib(dev, &zero_config, info->extack);
	if (ret < 0)
		goto err_free_hwprov;

In dev_set_hwtstamp_phylib(), hwprov is NULL and
phy_is_default_hwtstamp(dev->phydev) is false, so phy_ts is false and
the function ends up at:

	if (!ops->ndo_hwtstamp_set)
		return -EOPNOTSUPP;

The request then fails with -EOPNOTSUPP before rcu_replace_pointer() is
reached, so the PHY provider is never installed. The provider being
disabled here is an implicit netdev source that cannot have been
enabled in the first place.

The GET side does not improve for this hardware either.
dev_get_hwtstamp_phylib() still falls through to the !ndo_hwtstamp_get
check and returns -EOPNOTSUPP. The ioctls cannot select a non-default
PHY either, so TSCONFIG_SET is the only way to reach it, and that path
still refuses.

Should the disable step tolerate -EOPNOTSUPP when the outgoing provider
is the implicit netdev one and ndo_hwtstamp_set is absent? That would
match how the !hwprov_mod branch already ignores -EOPNOTSUPP from
dev_get_hwtstamp_phylib(). Or is only the default-timestamp PHY case
meant to be covered, in which case could the commit message say so?

[Severity: High]
Does removing this gate turn TSCONFIG_SET into a silent success on devices
that have no timestamp provider at all?

On a netdev with neither ndo_hwtstamp_get/set nor a default-timestamp PHY
(loopback, veth, tun, bcmgenet without a PTP PHY), a TSCONFIG_SET carrying
only the header, or asking for tx-type off / rx-filter none:

  - no ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER attribute, so hwprov_mod stays
    false and ethnl_set_tsconfig() calls:

	if (!hwprov_mod) {
		ret = dev_get_hwtstamp_phylib(dev, &hwtst_config);
		if (ret < 0 && ret != -EOPNOTSUPP)
			goto err_free_hwprov;
	}

    dev_get_hwtstamp_phylib() returns -EOPNOTSUPP here (hwprov NULL,
    phy_is_default_hwtstamp(NULL) false, no ndo_hwtstamp_get) and that is
    deliberately swallowed, leaving hwtst_config all zero.

  - ethnl_update_bitset32() reports no change, so config_mod stays false and
    the "if (config_mod)" dev_set_hwtstamp_phylib() call is skipped.
    net_hwtstamp_validate({0,0,0}) returns 0 because HWTSTAMP_TX_OFF and
    HWTSTAMP_FILTER_NONE are both valid.

  - the tail then swallows the error from the reply path as well:

	ret = tsconfig_send_reply(dev, info);
	if (ret && ret != -EOPNOTSUPP) {
		NL_SET_ERR_MSG(info->extack,
			       "error while reading the new configuration set");
		return ret;
	}

	/* tsconfig has no notification */
	return 0;

    tsconfig_send_reply() -> tsconfig_prepare_data() ->
    dev_get_hwtstamp_phylib() is the -EOPNOTSUPP that gets filtered out, so
    the handler returns 0.

Two consequences follow. First, the user space contradiction the commit
message sets out to remove seems to get worse rather than better:
TSCONFIG_GET on the very same device still fails with -EOPNOTSUPP from
tsconfig_prepare_data(), and SIOCSHWTSTAMP still fails in
dev_set_hwtstamp_phylib() at "if (!ops->ndo_hwtstamp_set)", while
TSCONFIG_SET now reports success.

Second, a successful do operation completes with a bare ACK and no
ETHTOOL_MSG_TSCONFIG_SET_REPLY, although the spec declares a full reply:

Documentation/netlink/specs/ethtool.yaml, tsconfig-set:
      do:
        request:
          attributes: *tsconfig
        reply:
          attributes: *tsconfig

That is the case commit e8ab231782e9 ("net: ethtool: tsconfig: set command
must provide a reply") closed.

The commit message says "Drop both checks and let the phylib helpers
decide, like the ioctls do." On the SET path, is the phylib helper
consulted at all when config_mod is false? Would narrowing the gate to
reject only when neither a PHY nor an NDO provider can serve the device, or
building the reply from the configuration SET already has, keep both the
error and the reply semantics intact?

Could the change in SET error and reply semantics also be mentioned in the
commit message?

>  static struct hwtstamp_provider *
>  tsconfig_set_hwprov_from_desc(struct net_device *dev,
>  			      struct genl_info *info,
> @@ -459,6 +445,5 @@ const struct ethnl_request_ops ethnl_tsconfig_request_ops = {
>  	.reply_size		= tsconfig_reply_size,
>  	.fill_reply		= tsconfig_fill_reply,
>  
> -	.set_validate		= ethnl_set_tsconfig_validate,
>  	.set			= ethnl_set_tsconfig,
>  };

[Severity: Medium]
This isn't a bug introduced by this patch, but the dev->hwprov lifetime
looks unbalanced and dropping .set_validate widens the set of devices that
can reach the install path.

tsconfig_set_hwprov_from_desc() kzalloc's the provider and
ethnl_set_tsconfig() publishes it, freeing only the one it replaced:

	__hwprov = rcu_replace_pointer(dev->hwprov, hwprov,
				       netdev_is_locked_ops_compat(dev));
	if (__hwprov)
		kfree_rcu(__hwprov, rcu_head);

The only teardown-time free is in phy_detach():

	hwprov = rtnl_dereference(dev->hwprov);
	/* Disable timestamp if it is the one selected */
	if (hwprov && hwprov->phydev == phydev) {
		rcu_assign_pointer(dev->hwprov, NULL);
		kfree_rcu(hwprov, rcu_head);
	}

A HWTSTAMP_SOURCE_NETDEV provider has phydev == NULL, so that branch never
matches, and neither unregister_netdevice() nor free_netdev() releases
dev->hwprov. Does the allocation then outlive the struct net_device when an
interface with a netdev-source provider selected is unbound or its netns
goes away?

With the ndo_hwtstamp_get/set gate gone, provider selection now depends only
on ethtool_ops->get_ts_info() plus net_support_hwtstamp_qualifier(), so more
devices can install such a provider.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922070813.1458713-1-nb%40tipi-net.de
