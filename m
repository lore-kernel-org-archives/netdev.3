Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2DB3CF210;
	Wed, 30 Sep 2026 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808796; cv=none; b=eHc9uGgNw2oUmcqMZrOFzul8q0PWeXBIHlidrH7rG5V+3bSXgZuvgRQLxtXSbMtensOr3gmjY2ui4rCmP1znFQbWBFMFajSugyvMDwcCPg2S1yXDcLir0y7nPdGhyHI4kZ0ugBncw2qW/z4lo0b6UEqgeRLRWoAMrVwo2P74h+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808796; c=relaxed/simple;
	bh=UhfM0G+kTLgyxZZAX2wlZvUt+48Vvwcr5UvtCZH+oFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCCSCf4qBFAZnh3fKB9lZUYNPTuEn54WHVVw92B5LsZAKIPBEY2Ee2nMdCohE7BjDzj3mFNclZLV6Pnoy/67suCNsmLch8e4zm6flDgqoI7kSQCddZE1XlsFIKqWGDRRBf41g5s4TLsZH64jzgimPQs6woE9mGB3OGyES5XvoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6f3c24e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6f3c24e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A4C1F000FF;
	Wed, 30 Sep 2026 22:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790808792;
	bh=S5YQQHsyLdAZTatqcMV/D8SWkHaopLEYGQzEyksxTkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T6f3c24ecTDBif2RR7B33lPWGhRWrUzcBRcya6D1HLJt5bKuP7C6H+b3oao5YlofY
	 x/Px162+GPfxnGcqQfYCLQdt0kwIXudRcTqaaJOy4bPe7iNa33B8O1hYLs82TPW0sF
	 1M4I9FOdKoFQklFxiarScdi3H2zpKdgCwfItXuvxplhreFlfhaG8nv4/lUUyHgGtJf
	 +K3ZVvSj4qu5rpZyKovgRZTEBXxr8Y/EJDLYqxTNBfylqOTyO7ftLcvbZKHIz6+eXn
	 3Ggc/m/Kk7z/bAa+I7cVbApuBs6Lw6uSi3RWGCbZfl3yEvDXLTklh03UE1bL6RpHeV
	 eNadpr992Q4qw==
Date: Wed, 30 Sep 2026 15:53:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>, Daniel
 Golle <daniel@makrotopia.org>, Dimitri Fedrau
 <dimitri.fedrau@liebherr.com>, Frank Wunderlich
 <frank.wunderlich@linux.dev>, Pietro Ameruoso <p.ameruoso@live.it>, Aleksei
 Sviridkin <f@lex.la>
Subject: Re: [PATCH net-next v18 09/10] net: ethtool: Introduce ethtool
 command to list ports
Message-ID: <20260930155310.775843d4@kernel.org>
In-Reply-To: <20260927133619.955236-10-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
	<20260927133619.955236-10-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 15:36:18 +0200 Maxime Chevallier wrote:
> Expose the phy_port information to userspace, so that we can know how
> many ports are available on a given interface, as well as their
> capabilities. For MDI ports, we report the list of supported linkmodes
> based on what the PHY that drives this port says.
> For MII ports, i.e. empty SFP cages, we report the MII linkmodes that we
> can output on this port.
> 
> Tested-by: Aleksei Sviridkin <f@lex.la>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> +static void __init ethnl_phy_names_populate(void)
> +{
> +	const char *name;
> +	int i;
> +
> +	for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++) {
> +		name = phy_modes(i);
> +		strscpy(phy_interface_names[i], name, ETH_GSTRING_LEN);

Feels a bit backward, we run thru a switch statement to dump it down
to an array.. Why not convert to an array and then make phy_modes()
also use it?

> +	}
> +}

> +static int port_fill_reply(struct sk_buff *skb,
> +			   const struct ethnl_req_info *req_info,
> +			   const struct ethnl_reply_data *reply_data)
> +{
> +	bool compact = req_info->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
> +	struct port_reply_data *reply = PORT_REPDATA(reply_data);
> +	int ret, port_type = ETHTOOL_PORT_TYPE_MDI;
> +
> +	if (nla_put_u32(skb, ETHTOOL_A_PORT_ID, reply->port_id))
> +		return -EMSGSIZE;
> +
> +	if (!reply->mii) {
> +		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_MODES,
> +				       reply->supported, NULL,
> +				       __ETHTOOL_LINK_MODE_MASK_NBITS,
> +				       link_mode_names, compact);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
> +				       reply->interfaces, NULL,
> +				       PHY_INTERFACE_MODE_MAX,
> +				       phy_interface_names, compact);
> +		if (ret < 0)
> +			return ret;
> +	}
> +

please move the port_type init from inline up to to here.
initializing things inline often lowers readability

> +	if (reply->mii || reply->sfp)
> +		port_type = ETHTOOL_PORT_TYPE_SFP;
> +
> +	if (nla_put_u32(skb, ETHTOOL_A_PORT_TYPE, port_type))
> +		return -EMSGSIZE;
> +
> +	if (reply->upstream_port &&
> +	    nla_put_u32(skb, ETHTOOL_A_PORT_UPSTREAM_PORT,
> +			reply->upstream_port))
> +		return -EMSGSIZE;
> +
> +	return 0;
> +}

> +static int port_dump_all_dev(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
> +	struct net *net = sock_net(skb->sk);
> +	netdevice_tracker dev_tracker;
> +	struct net_device *dev;
> +	int ret = 0;
> +
> +	rcu_read_lock();
> +	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> +		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
> +		rcu_read_unlock();
> +
> +		ctx->req_info->base.dev = dev;
> +		ret = port_dump_one_dev(skb, cb);
> +
> +		rcu_read_lock();
> +		netdev_put(dev, &dev_tracker);
> +		ctx->req_info->base.dev = NULL;
> +
> +		if (ret < 0 && ret != -EOPNOTSUPP) {
> +			if (likely(skb->len))
> +				ret = skb->len;

smells of pre-commit b5a899154 netlink
Can we delete the skb->len check and override here?
There's one more such construct below

> +			break;
> +		}
> +
> +		ret = 0;

