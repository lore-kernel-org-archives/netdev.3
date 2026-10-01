Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C12E7378
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837363; cv=none; b=u5v2sMb08TaAtVfFqTnGRLa4/2gYtgueVclYp6LprkBMMWXlqq9hj0eEhzTiobuAMyt+ApSlb8jdvGRsx6jwEO74tbVZb6TvykIDl/havSHWLn6Ws0V7IQoYOkS19zSDeKvVqBYzgwNmb6zXjPpVvYLAkosilAZ2n3sBUks8kk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837363; c=relaxed/simple;
	bh=H3ndpuZOs5KbBxoDMRuDjzHiiZfaCII4tMYsCZULh4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIav3ZSFXlbUTNG2rwx2U1S5SvlbfMyFztIho1/XSzFLDpGSo+2F3BOhLsSfFtKeymT+UyVYlBoPoNTozuYdu4epFKlcvUtWPFvom8fLkWWulMse/15bcyLoIalFW8HjUe0MFdb596UEOo7bFsowusRyX4TKNft5m4J7hAEjVkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DDxQXyln; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DDxQXyln"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 32FD14E410EA;
	Thu,  1 Oct 2026 06:49:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0378760341;
	Thu,  1 Oct 2026 06:49:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 229EB1032A044;
	Thu,  1 Oct 2026 08:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790837356; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=VTxE/6MZQnOHf7qilpg+lvqP0ZHWR04NsBK8UTne4+8=;
	b=DDxQXylnjxwZj5zVQc52PWlEHrywz5Bsd2mPZnP67qUX87jSfIDEJ73c7ofISaxlzWxD0y
	PwP/eqkRAtSJjPPCK7i4LEnUZJKL3DTnmbHQ49DvV6E2W8OJHnh8dF1i/4eImhSvL9kcpD
	fIIIRZKi3ZafoLZT5g4u9jNV/1ePtvAIW3glG7yvhzlCdyi0VDBlrt+TEwSiOIcI8lIzVY
	xMeF3QiMQe0XlmgwWpONwNwXbwPEXqHckQCRWNq8Dxjb/MCbITpQe2V0oqFWdek9UCIfXy
	uDLxLzzy1zzeDMFfSp2jQd0Pq0onjLv3PWoHST/SH6dyz9bHkAbm174yaredPQ==
Message-ID: <5e5fc716-3be9-40f5-a74b-9d2eae478194@bootlin.com>
Date: Thu, 1 Oct 2026 08:49:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 09/10] net: ethtool: Introduce ethtool
 command to list ports
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>, Aleksei Sviridkin <f@lex.la>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
 <20260927133619.955236-10-maxime.chevallier@bootlin.com>
 <20260930155310.775843d4@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260930155310.775843d4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/1/26 00:53, Jakub Kicinski wrote:
> On Sun, 27 Sep 2026 15:36:18 +0200 Maxime Chevallier wrote:
>> Expose the phy_port information to userspace, so that we can know how
>> many ports are available on a given interface, as well as their
>> capabilities. For MDI ports, we report the list of supported linkmodes
>> based on what the PHY that drives this port says.
>> For MII ports, i.e. empty SFP cages, we report the MII linkmodes that we
>> can output on this port.
>>
>> Tested-by: Aleksei Sviridkin <f@lex.la>
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
>> +static void __init ethnl_phy_names_populate(void)
>> +{
>> +	const char *name;
>> +	int i;
>> +
>> +	for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++) {
>> +		name = phy_modes(i);
>> +		strscpy(phy_interface_names[i], name, ETH_GSTRING_LEN);
> 
> Feels a bit backward, we run thru a switch statement to dump it down
> to an array.. Why not convert to an array and then make phy_modes()
> also use it?

From my memories on early tries to get it done another way, this was
tricky as I was struggling to find the correct place to put the array
in question.

phy_names() is required even when CONFIG_NET=n as it's used for devicetree
parsing, so we can't put that in phylib nor in any networking code without
doing some trickery to get some of it to build inconditionally. I'll try
harder :)

> 
>> +	}
>> +}
> 
>> +static int port_fill_reply(struct sk_buff *skb,
>> +			   const struct ethnl_req_info *req_info,
>> +			   const struct ethnl_reply_data *reply_data)
>> +{
>> +	bool compact = req_info->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
>> +	struct port_reply_data *reply = PORT_REPDATA(reply_data);
>> +	int ret, port_type = ETHTOOL_PORT_TYPE_MDI;
>> +
>> +	if (nla_put_u32(skb, ETHTOOL_A_PORT_ID, reply->port_id))
>> +		return -EMSGSIZE;
>> +
>> +	if (!reply->mii) {
>> +		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_MODES,
>> +				       reply->supported, NULL,
>> +				       __ETHTOOL_LINK_MODE_MASK_NBITS,
>> +				       link_mode_names, compact);
>> +		if (ret < 0)
>> +			return ret;
>> +	} else {
>> +		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
>> +				       reply->interfaces, NULL,
>> +				       PHY_INTERFACE_MODE_MAX,
>> +				       phy_interface_names, compact);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
> 
> please move the port_type init from inline up to to here.
> initializing things inline often lowers readability

Ack, will do

> 
>> +	if (reply->mii || reply->sfp)
>> +		port_type = ETHTOOL_PORT_TYPE_SFP;
>> +
>> +	if (nla_put_u32(skb, ETHTOOL_A_PORT_TYPE, port_type))
>> +		return -EMSGSIZE;
>> +
>> +	if (reply->upstream_port &&
>> +	    nla_put_u32(skb, ETHTOOL_A_PORT_UPSTREAM_PORT,
>> +			reply->upstream_port))
>> +		return -EMSGSIZE;
>> +
>> +	return 0;
>> +}
> 
>> +static int port_dump_all_dev(struct sk_buff *skb, struct netlink_callback *cb)
>> +{
>> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
>> +	struct net *net = sock_net(skb->sk);
>> +	netdevice_tracker dev_tracker;
>> +	struct net_device *dev;
>> +	int ret = 0;
>> +
>> +	rcu_read_lock();
>> +	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
>> +		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
>> +		rcu_read_unlock();
>> +
>> +		ctx->req_info->base.dev = dev;
>> +		ret = port_dump_one_dev(skb, cb);
>> +
>> +		rcu_read_lock();
>> +		netdev_put(dev, &dev_tracker);
>> +		ctx->req_info->base.dev = NULL;
>> +
>> +		if (ret < 0 && ret != -EOPNOTSUPP) {
>> +			if (likely(skb->len))
>> +				ret = skb->len;
> 
> smells of pre-commit b5a899154 netlink
> Can we delete the skb->len check and override here?
> There's one more such construct below

ah indeed yes :(

Thanks for reviewing,

Maxime

