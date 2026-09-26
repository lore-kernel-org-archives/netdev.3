Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6DD456DFD;
	Sat, 26 Sep 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430859; cv=none; b=qqQPVTInuk7dxRueMku3G+CdCjuuIlpMrsNMhHYXQo8pr2LOOXfkfOSMwSBQf6/esIt6MgcIvAHMnAGbRmKkY5T9DnMPkYL0yYoxJo9UQMKvNJT3Sdr4JTN9+/YvMc/7iP6PjrEgkNn4AXokNzNv4LOWPS73f+6Aw7lLdFgqL5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430859; c=relaxed/simple;
	bh=V+7N3CEMlMcV2/cogsgxa37P79t+Z9n/URPasGHb+V8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnK4o770L1H6LEYxk5BHCEwAvVYVdTf7J5YArJjPs28LAMS0RXMrVoay0Uw6/oZ8QNYG1qR7UQLSggiVa4q7XFGvdhRZtCvtpa5HJphgpmFF5eDxh4/vdhWSA4MKz6lk87oxCLXEzZ/Vz1RtJYxUYixMcUF2L0P7MoM6dRFKNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II3d8iPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II3d8iPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655631F000FF;
	Sat, 26 Sep 2026 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790430852;
	bh=iHcuMOQ5i7mli5/wKk6P3y5eiCCYwTcMR3JJCsc8cgE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=II3d8iPd4o35qYc/yO/BwQphWhgYwKAtya/ox9mjjehqrbqG2RFaXhErP8988xBM9
	 DdJKM4FWk5iMM6LVNDrYXiF4ocVai/iofjUfVbdalzUvyTm9Wp0togf99/6jA5E8yq
	 /deVV01C57Mm13xhuRDd/3ee6L4UaKJeAj+kw+EekH+ocZ5w6G1tcYkgNKNdcDL8WG
	 QTFcdpTkYjaA+UH1UakuYUQ3JTqrQ2I83yA96CuoIG/QbSOsCyZapGSGWnqeB4nFn/
	 GFsnFz8o6EvdgUbR1J+5SzVRG1P0eu3uiZb1PNInekPU5ef4hJKGfb/fpsWRLMiRzW
	 KFTg4L1Q7rTnA==
Subject: Re: [PATCH net v3 2/2] net: ethtool: let tsconfig reach a PHY-only
 timestamp provider
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 26 Sep 2026 13:54:10 +0000
Message-ID: <179043085090.2160803.7251184093173489740@kernel.org>
In-Reply-To: <20260925135237.3432266-3-nb@tipi-net.de>
References: <20260925135237.3432266-3-nb@tipi-net.de>
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

- [Medium] The removed ethnl_set_tsconfig_validate() required both
  ndo_hwtstamp_set and ndo_hwtstamp_get.

--

net: ethtool: let tsconfig reach a PHY-only timestamp provider

This patch lets TSCONFIG_GET and TSCONFIG_SET accept a device whose
timestamping is served by a default timestamping PHY or an already
installed hwprov, even when the netdev has no hwtstamp NDOs. It removes
the set_validate callback and moves the check into ethnl_set_tsconfig().
It also stops selecting a netdev source without ndo_hwtstamp_set, and
adds a NULL check for ndo_hwtstamp_get in dev_get_hwtstamp_phylib().

> diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
> index 6be3aa5d4bc1e..2db0e7ba8b9f5 100644
> --- a/net/ethtool/tsconfig.c
> +++ b/net/ethtool/tsconfig.c

[ ... ]

> @@ -42,7 +43,9 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
>  	struct kernel_hwtstamp_config cfg = {};
>  	int ret;
>  
> -	if (!dev->netdev_ops->ndo_hwtstamp_get)
> +	if (!dev->netdev_ops->ndo_hwtstamp_get &&
> +	    !phy_is_default_hwtstamp(dev->phydev) &&
> +	    !netdev_ops_lock_dereference(dev->hwprov, dev))
>  		return -EOPNOTSUPP;
>  
>  	ret = ethnl_ops_begin(dev);
> @@ -248,17 +251,6 @@ static int tsconfig_send_reply(struct net_device *dev, struct genl_info *info)
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

[ ... ]

> @@ -313,6 +305,11 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
>  	if (!netif_device_present(dev))
>  		return -ENODEV;
>  
> +	if (!dev->netdev_ops->ndo_hwtstamp_set &&
> +	    !phy_is_default_hwtstamp(dev->phydev) &&
> +	    !netdev_ops_lock_dereference(dev->hwprov, dev))
> +		return -EOPNOTSUPP;
> +

[Severity: Medium]

The removed ethnl_set_tsconfig_validate() required both ndo_hwtstamp_set
and ndo_hwtstamp_get. This new check in ethnl_set_tsconfig() only tests
ndo_hwtstamp_set. The matching check in tsconfig_prepare_data() only
tests ndo_hwtstamp_get.

What happens on a netdev that has ndo_hwtstamp_set but no
ndo_hwtstamp_get, and has neither a default timestamping PHY nor a
hwprov?

TSCONFIG_SET now accepts that device. However, reading the current
config fails in dev_get_hwtstamp_phylib():

	if (!dev->netdev_ops->ndo_hwtstamp_get)
		return -EOPNOTSUPP;

and ethnl_set_tsconfig() ignores that error:

		ret = dev_get_hwtstamp_phylib(dev, &hwtst_config);
		if (ret < 0 && ret != -EOPNOTSUPP)
			goto err_free_hwprov;

This means the read-modify-write starts from an all-zero hwtst_config.

A request that carries only RX_FILTERS or only FLAGS would then reset
tx_type to HWTSTAMP_TX_OFF and zero the other fields.

A full disable request (TX_OFF, FILTER_NONE, no flags) matches the
assumed zero state, so ethnl_bitmap32_update() never sets *mod. As a
result, config_mod stays false and dev_set_hwtstamp_phylib() is
skipped. Can hardware timestamping stay enabled while the command
reports success?

After that, tsconfig_send_reply()->tsconfig_prepare_data() fails its
own check with -EOPNOTSUPP, and ethnl_set_tsconfig() swallows it:

	ret = tsconfig_send_reply(dev, info);
	if (ret && ret != -EOPNOTSUPP) {

So the ETHTOOL_MSG_TSCONFIG_SET_REPLY documented in
Documentation/netlink/specs/ethtool.yaml is never sent. TSCONFIG_GET on
the same device still returns EOPNOTSUPP even though SET succeeds.

Every in-tree driver seems to implement both NDOs today. Elsewhere,
though, the patch treats set-without-get as a valid state: it selects
the NETDEV source in tsconfig_set_hwprov_from_desc() based on
ndo_hwtstamp_set alone, and it adds a NULL check for ndo_hwtstamp_get
in dev_get_hwtstamp_phylib().

For the netdev case, should the SET check also require
ndo_hwtstamp_get, so that GET and SET accept the same devices?

>  	if (tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER]) {
>  		struct hwtstamp_provider_desc __hwprov_desc = {.index = -1};
>  		struct hwtstamp_provider *__hwprov;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925135237.3432266-2-nb%40tipi-net.de
