Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553A495524;
	Mon, 28 Sep 2026 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588936; cv=none; b=FUsucWplXGM9X/XfdlMUHAYl61T45LuFM2382ENIV6Fb2VAqZSUbK2Pls4uGzqvVPYtf1s0fztb1lfhYsE2Nysd36LIlTIkeMnQIKkMvw/Fe53/2uZZkPmf8obTPOTvk/gkK7J7ITXp9WtjecX8H9dt9DETNITUXzR3JU/Nl5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588936; c=relaxed/simple;
	bh=zbHX19BzYKHkWn9efvpGjHzR3lMkAfkzbUmoA4oZJOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMAT8Rsnem4ZSon4hAg35OgU99b8t5uXH9BmtlD8CMuznSPCdriStArqZrmnoYDQcyu/Bs+9kJqxhlbyDkAQAYKnAgkiskYui04yQUncjDRPVosQmT/VwKoMH4c3IUNRbRuDvnxt7qX6U44h3g2MQsN+OwijqfpMnyl/s4paPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPDZcTuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPDZcTuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E476C1F00893;
	Mon, 28 Sep 2026 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588933;
	bh=Lfz4r2pfXqGYkSwBB6CtI8ErxPpVdTNwk7uDjInLBK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VPDZcTuHa4IUa92rGAzLMt0gMh6CKe68D969vz4Bd1RQJc+bY/LObGIiS/yotcTQy
	 J0rfAysrC1sdL4zeanBZPz62uZjXOt93RgZoq1sayAncL2gXLPh8na8DlOAZlkPjJy
	 ZDP0U1eFze5w6bjmq6ocEsRHocL1OWH8x0E7Td3cvxNOK3HGaiqyQThGH7QcVCAG0/
	 S742Nzf2QUFgeiAbLamqVxQMMSRR+U7PqsoPSipWUbX28t6xtYUB8xp9VkKmdZ/TPl
	 cN5e3PaEBGhKYDryUb1wyiGsnkDlSOnGMW1lhH4T03aOZi5WOl119yRLVUgcEqPVl3
	 q/IcSPr0yvEHQ==
Message-ID: <10c63e8d-396b-46ea-8e11-79430a39f26c@kernel.org>
Date: Mon, 28 Sep 2026 11:48:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 09/10] net: ethtool: Introduce ethtool
 command to list ports
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
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
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260927133619.955236-10-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 15:36, Maxime Chevallier a écrit :
> Expose the phy_port information to userspace, so that we can know how
> many ports are available on a given interface, as well as their
> capabilities. For MDI ports, we report the list of supported linkmodes
> based on what the PHY that drives this port says.
> For MII ports, i.e. empty SFP cages, we report the MII linkmodes that we
> can output on this port.
> 
> Tested-by: Aleksei Sviridkin <f@lex.la>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   MAINTAINERS           |   1 +
>   net/ethtool/Makefile  |   2 +-
>   net/ethtool/netlink.c |  25 +++
>   net/ethtool/netlink.h |   8 +
>   net/ethtool/port.c    | 382 ++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 417 insertions(+), 1 deletion(-)
>   create mode 100644 net/ethtool/port.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6de1ff058db6..877f3316b5ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19010,6 +19010,7 @@ F:	Documentation/devicetree/bindings/net/ethernet-connector.yaml
>   F:	Documentation/networking/phy-port.rst
>   F:	drivers/net/phy/phy_port.c
>   F:	include/linux/phy_port.h
> +F:	net/ethtool/port.c
>   K:	struct\s+phy_port|phy_port_
>   
>   NETWORKING [GENERAL]
> diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
> index 629c10916670..9b5b09670008 100644
> --- a/net/ethtool/Makefile
> +++ b/net/ethtool/Makefile
> @@ -9,4 +9,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
>   		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
>   		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
>   		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
> -		   phy.o tsconfig.o mse.o
> +		   phy.o tsconfig.o mse.o port.o
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 1af395b54330..c076c07d0a08 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -26,6 +26,8 @@ static u32 ethnl_bcast_seq;
>   			     ETHTOOL_FLAG_OMIT_REPLY)
>   #define ETHTOOL_FLAGS_STATS (ETHTOOL_FLAGS_BASIC | ETHTOOL_FLAG_STATS)
>   
> +char phy_interface_names[PHY_INTERFACE_MODE_MAX][ETH_GSTRING_LEN] __ro_after_init;
> +
>   const struct nla_policy ethnl_header_policy[] = {
>   	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
>   	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
> @@ -431,6 +433,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
>   	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
>   	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
>   	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
> +	[ETHTOOL_MSG_PORT_GET]		= &ethnl_port_request_ops,
>   };
>   
>   static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
> @@ -1572,6 +1575,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
>   		.policy = ethnl_mse_get_policy,
>   		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
>   	},
> +	{
> +		.cmd	= ETHTOOL_MSG_PORT_GET,
> +		.doit	= ethnl_default_doit,
> +		.start	= ethnl_port_dump_start,
> +		.dumpit	= ethnl_port_dumpit,
> +		.done	= ethnl_port_dump_done,
> +		.policy = ethnl_port_get_policy,
> +		.maxattr = ARRAY_SIZE(ethnl_port_get_policy) - 1,
> +	},
>   };
>   
>   static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
> @@ -1594,10 +1606,23 @@ static struct genl_family ethtool_genl_family __ro_after_init = {
>   
>   /* module setup */
>   
> +static void __init ethnl_phy_names_populate(void)
> +{
> +	const char *name;
> +	int i;
> +
> +	for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++) {
> +		name = phy_modes(i);
> +		strscpy(phy_interface_names[i], name, ETH_GSTRING_LEN);
> +	}
> +}
> +
>   static int __init ethnl_init(void)
>   {
>   	int ret;
>   
> +	ethnl_phy_names_populate();
> +
>   	ret = genl_register_family(&ethtool_genl_family);
>   	if (WARN(ret < 0, "ethtool: genetlink family registration failed"))
>   		return ret;
> diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> index 3e969a070f9f..dc7211f67c4d 100644
> --- a/net/ethtool/netlink.h
> +++ b/net/ethtool/netlink.h
> @@ -5,11 +5,14 @@
>   
>   #include <linux/ethtool_netlink.h>
>   #include <linux/netdevice.h>
> +#include <linux/phy.h>
>   #include <net/genetlink.h>
>   #include <net/sock.h>
>   
>   struct ethnl_req_info;
>   
> +extern char phy_interface_names[PHY_INTERFACE_MODE_MAX][ETH_GSTRING_LEN];
> +
>   int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
>   			       const struct nlattr *nest, struct net *net,
>   			       struct netlink_ext_ack *extack,
> @@ -474,6 +477,7 @@ extern const struct ethnl_request_ops ethnl_mm_request_ops;
>   extern const struct ethnl_request_ops ethnl_phy_request_ops;
>   extern const struct ethnl_request_ops ethnl_tsconfig_request_ops;
>   extern const struct ethnl_request_ops ethnl_mse_request_ops;
> +extern const struct ethnl_request_ops ethnl_port_request_ops;
>   
>   extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
>   extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
> @@ -530,6 +534,7 @@ extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
>   extern const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEADER + 1];
>   extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1];
>   extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];
> +extern const struct nla_policy ethnl_port_get_policy[ETHTOOL_A_PORT_ID + 1];
>   
>   int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
>   int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
> @@ -545,6 +550,9 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
>   int ethnl_tsinfo_done(struct netlink_callback *cb);
>   int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info);
>   int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info);
> +int ethnl_port_dump_start(struct netlink_callback *cb);
> +int ethnl_port_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
> +int ethnl_port_dump_done(struct netlink_callback *cb);
>   
>   extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
>   extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
> diff --git a/net/ethtool/port.c b/net/ethtool/port.c
> new file mode 100644
> index 000000000000..0d6150e5f66a
> --- /dev/null
> +++ b/net/ethtool/port.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2026 Bootlin
> + */
> +#include <linux/phy.h>
> +#include <linux/phy_link_topology.h>
> +#include <linux/phy_port.h>
> +#include <net/netdev_lock.h>
> +
> +#include "bitset.h"
> +#include "common.h"
> +#include "netlink.h"
> +
> +struct port_req_info {
> +	struct ethnl_req_info base;
> +	u32 port_id;
> +};
> +
> +struct port_reply_data {
> +	struct ethnl_reply_data	base;
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
> +	DECLARE_PHY_INTERFACE_MASK(interfaces);
> +	u32 port_id;
> +	bool mii;
> +	bool sfp;
> +	u32 upstream_port;
> +};
> +
> +#define PORT_REQINFO(__req_base) \
> +	container_of(__req_base, struct port_req_info, base)
> +
> +#define PORT_REPDATA(__reply_base) \
> +	container_of(__reply_base, struct port_reply_data, base)
> +
> +const struct nla_policy ethnl_port_get_policy[ETHTOOL_A_PORT_ID + 1] = {
> +	[ETHTOOL_A_PORT_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
> +	[ETHTOOL_A_PORT_ID] = NLA_POLICY_MIN(NLA_U32, 1),
> +};
> +
> +static int port_parse_request(struct ethnl_req_info *req_info,
> +			      const struct genl_info *info,
> +			      struct nlattr **tb,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct port_req_info *request = PORT_REQINFO(req_info);
> +
> +	if (GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_PORT_ID))
> +		return -EINVAL;
> +
> +	request->port_id = nla_get_u32(tb[ETHTOOL_A_PORT_ID]);
> +
> +	return 0;
> +}
> +
> +static int port_prepare_data(const struct ethnl_req_info *req_info,
> +			     struct ethnl_reply_data *reply_data,
> +			     const struct genl_info *info)
> +{
> +	struct port_reply_data *reply = PORT_REPDATA(reply_data);
> +	struct port_req_info *request = PORT_REQINFO(req_info);
> +	struct phy_port *port;
> +
> +	/* RTNL must be held while holding a ref to the phy_port. Here, caller
> +	 * holds RTNL.
> +	 */
> +	port = phy_link_topo_get_port(req_info->dev, request->port_id);
> +	if (!port)
> +		return -ENODEV;
> +
> +	linkmode_copy(reply->supported, port->supported);
> +	phy_interface_copy(reply->interfaces, port->interfaces);
> +	reply->port_id = port->id;
> +	reply->mii = port->is_mii;
> +	reply->sfp = port->is_sfp;
> +	reply->upstream_port = port->upstream_port ? port->upstream_port->id : 0;
> +
> +	return 0;
> +}
> +
> +static int port_reply_size(const struct ethnl_req_info *req_info,
> +			   const struct ethnl_reply_data *reply_data)
> +{
> +	bool compact = req_info->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
> +	struct port_reply_data *reply = PORT_REPDATA(reply_data);
> +	size_t size = 0;
> +	int ret;
> +
> +	/* ETHTOOL_A_PORT_ID */
> +	size += nla_total_size(sizeof(u32));
> +
> +	if (!reply->mii) {
> +		/* ETHTOOL_A_PORT_SUPPORTED_MODES */
> +		ret = ethnl_bitset_size(reply->supported, NULL,
> +					__ETHTOOL_LINK_MODE_MASK_NBITS,
> +					link_mode_names, compact);
> +		if (ret < 0)
> +			return ret;
> +
> +		size += ret;
> +	} else {
> +		/* ETHTOOL_A_PORT_SUPPORTED_INTERFACES */
> +		ret = ethnl_bitset_size(reply->interfaces, NULL,
> +					PHY_INTERFACE_MODE_MAX,
> +					phy_interface_names, compact);
> +		if (ret < 0)
> +			return ret;
> +
> +		size += ret;
> +	}
> +
> +	/* ETHTOOL_A_PORT_TYPE */
> +	size += nla_total_size(sizeof(u32));
> +
> +	/* ETHTOOL_A_PORT_UPSTREAM_PORT */
> +	if (reply->upstream_port)
> +		size += nla_total_size(sizeof(u32));
> +
> +	return size;
> +}
> +
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
> +
> +struct port_dump_ctx {
> +	struct port_req_info	*req_info;
> +	struct port_reply_data	*reply_data;
> +	unsigned long		ifindex;
> +	unsigned long		pos_ifindex;
> +	unsigned long		pos_portid;
> +};
> +
> +static struct port_dump_ctx *
> +port_dump_ctx_get(struct netlink_callback *cb)
> +{
> +	return (struct port_dump_ctx *)cb->ctx;
> +}
> +
> +int ethnl_port_dump_start(struct netlink_callback *cb)
> +{
> +	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
> +	struct nlattr **tb = info->info.attrs;
> +	struct port_reply_data *reply_data;
> +	struct port_req_info *req_info;
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
> +
> +	req_info = kzalloc_obj(*req_info);
> +	if (!req_info)
> +		return -ENOMEM;
> +
> +	reply_data = kmalloc_obj(*reply_data);
> +	if (!reply_data) {
> +		ret = -ENOMEM;
> +		goto free_req_info;
> +	}
> +
> +	ret = ethnl_parse_header_dev_get(&req_info->base, tb[ETHTOOL_A_PORT_HEADER],
> +					 genl_info_net(&info->info),
> +					 info->info.extack, false);
> +	if (ret < 0)
> +		goto free_rep_data;
> +
> +	ctx->ifindex = 0;
> +	ctx->pos_ifindex = 0;
> +
> +	/* For filtered DUMP requests, let's just store the ifindex. We'll check
> +	 * again if the netdev is still there when looping over the netdev list
> +	 * in the DUMP loop.
> +	 */
> +	if (req_info->base.dev) {
> +		ctx->ifindex = req_info->base.dev->ifindex;
> +		netdev_put(req_info->base.dev, &req_info->base.dev_tracker);
> +		req_info->base.dev = NULL;
> +	}
> +
> +	ctx->req_info = req_info;
> +	ctx->reply_data = reply_data;
> +
> +	return 0;
> +
> +free_rep_data:
> +	kfree(reply_data);
> +free_req_info:
> +	kfree(req_info);
> +
> +	return ret;
> +}
> +
> +static int port_dump_one(struct sk_buff *skb, struct net_device *dev,
> +			 struct netlink_callback *cb)
> +{
> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
> +	void *ehdr;
> +	int ret;
> +
> +	ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_PORT_GET_REPLY);
> +	if (!ehdr)
> +		return -EMSGSIZE;
> +
> +	memset(ctx->reply_data, 0, sizeof(struct port_reply_data));
> +	ctx->reply_data->base.dev = dev;
> +
> +	rtnl_lock();
> +	netdev_lock_ops(dev);
> +
> +	ret = port_prepare_data(&ctx->req_info->base, &ctx->reply_data->base,
> +				genl_info_dump(cb));
> +
> +	netdev_unlock_ops(dev);
> +	rtnl_unlock();
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = ethnl_fill_reply_header(skb, dev, ETHTOOL_A_PORT_HEADER);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = port_fill_reply(skb, &ctx->req_info->base, &ctx->reply_data->base);
> +
> +out:
> +	ctx->reply_data->base.dev = NULL;
> +	if (ret < 0)
> +		genlmsg_cancel(skb, ehdr);
> +	else
> +		genlmsg_end(skb, ehdr);
> +
> +	return ret;
> +}
> +
> +static int port_dump_one_dev(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
> +	struct net_device *dev;
> +	struct phy_port *port;
> +	int ret;
> +
> +	dev = ctx->req_info->base.dev;
> +
> +	if (!dev->link_topo)
> +		return 0;
> +
> +	xa_for_each_start(&dev->link_topo->ports, ctx->pos_portid, port,
> +			  ctx->pos_portid) {
> +		ctx->req_info->port_id = ctx->pos_portid;
> +
> +		ret = port_dump_one(skb, dev, cb);
> +		if (ret == -ENODEV)
> +			continue;
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ctx->pos_portid = 0;
> +
> +	return 0;
> +}
> +
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
> +			break;
> +		}
> +
> +		ret = 0;
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +int ethnl_port_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
> +	int ret = 0;
> +
> +	if (ctx->ifindex) {
> +		netdevice_tracker dev_tracker;
> +		struct net_device *dev;
> +
> +		dev = netdev_get_by_index(genl_info_net(&info->info),
> +					  ctx->ifindex, &dev_tracker,
> +					  GFP_KERNEL);
> +		if (!dev)
> +			return -ENODEV;
> +
> +		ctx->req_info->base.dev = dev;
> +		ret = port_dump_one_dev(skb, cb);
> +		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
> +			ret = skb->len;
> +
> +		netdev_put(dev, &dev_tracker);
> +	} else {
> +		ret = port_dump_all_dev(skb, cb);
> +	}
> +
> +	return ret;
> +}
> +
> +int ethnl_port_dump_done(struct netlink_callback *cb)
> +{
> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
> +
> +	kfree(ctx->req_info);
> +	kfree(ctx->reply_data);
> +
> +	return 0;
> +}
> +
> +const struct ethnl_request_ops ethnl_port_request_ops = {
> +	.request_cmd		= ETHTOOL_MSG_PORT_GET,
> +	.reply_cmd		= ETHTOOL_MSG_PORT_GET_REPLY,
> +	.hdr_attr		= ETHTOOL_A_PORT_HEADER,
> +	.req_info_size		= sizeof(struct port_req_info),
> +	.reply_data_size	= sizeof(struct port_reply_data),
> +
> +	.parse_request		= port_parse_request,
> +	.prepare_data		= port_prepare_data,
> +	.reply_size		= port_reply_size,
> +	.fill_reply		= port_fill_reply,
> +};

