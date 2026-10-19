Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C974FD782;
	Mon, 19 Oct 2026 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416797; cv=none; b=L9ZfsNj0y+7OJgRTuLZJANw4U0lMajrv/b+mL22Cuz6jlh45EEOT6XnPwxHObTnyylLCsuMV/7iLagdNqHyxeC+CkHDmCFexpHpy6ITUh21Y5mNmnVCPEfS7vjkbyTjFjlC3YmTG9nnAdkEXw9PaaJ/f5s4YIeEkgGM4bwUZ2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416797; c=relaxed/simple;
	bh=nRJDJw+OopWZscKbUdIRB+yu3G8FovyuTv3F1y/grBY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u6ppc/ETPxixPUCpa5MHp7hD4nkW9phMpL8WMzIWfvp9kRCjqQ9LFhaFjzvHJaBzJWGJhw5ng/5xie93V5ej7ULSxbEGr4lz8MLLE3Bzl/H+r1qZZa7CxnEPuZ6uw/3erwiRZNJMZuZynkMp8XT/piV7cEpx8eemvMzl//zDzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUB1j6c+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUB1j6c+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E371F000C4;
	Mon, 19 Oct 2026 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416795;
	bh=bUr9V5556DdJtNG6By691K3gfnkhpv+dwx3kOWfuwPs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PUB1j6c+IsTGDhDchSNJ1wmMbiIp9e90kZUXZaoMvon31G7sue4SZXNe5BAZpPyzK
	 v04CcawhANxQcxnVA8/zztFTNuIFBT4Wg0tFMpgW/K0T8jYlXUp9I085e5Ng87K6VB
	 pvOOoZi+sMCcbKbC63yMHE//YoejC+7400foCtkVHQXpYBTYJRgxJiKcdm010XQN1u
	 zioNGYYhA0lTVq+AiH3fusZOgudJEeAhHmaVZ0ltCiONM13lCjnouTXahoDkosmbcU
	 clwituDmKhMbZrNlYiiW4Dmnui0h1vaYowiB8+LnHRqaJNYHfQwDIemGf/H1n6R49K
	 ZSH6Yb65cjmeQ==
Subject: Re: [PATCH net-next v19 09/10] net: ethtool: Introduce ethtool
 command to list ports
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la, chleroy@kernel.org
Date: Mon, 19 Oct 2026 13:33:13 +0000
Message-ID: <179241679388.3135.710826378631966928@kernel.org>
In-Reply-To: <20261016133107.54054-10-maxime.chevallier@bootlin.com>
References: <20261016133107.54054-10-maxime.chevallier@bootlin.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] PORT_GET can read a phy_port after it has been freed if a PHY
  driver is unbound at the same time.
- [Medium] The ETHTOOL_MSG_PORT_GET doit path does not always take RTNL,
  but port_prepare_data() relies on it.
- [Medium] net/ethtool: uapi breakage risk from exposing internal
  phy_interface_t enum
- [Low] When a DO request names an ETHTOOL_A_PORT_ID that does not exist,
  port_prepare_data() returns a bare -ENODEV without setting extack (no…

--

net: ethtool: Introduce ethtool command to list ports

This commit adds a new ethtool netlink command, ETHTOOL_MSG_PORT_GET. It
reports phy_port information to user space: supported linkmodes for MDI
ports, supported MII interfaces for empty SFP cages, the port type and
the upstream port. It also adds an ETH_SS_PHY_INTERFACES string set
backed by phy_interface_names[].

> diff --git a/net/ethtool/port.c b/net/ethtool/port.c
> new file mode 100644
> index 0000000000000..425e5bbdca45d
> --- /dev/null
> +++ b/net/ethtool/port.c
> @@ -0,0 +1,385 @@

[ ... ]

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

[Severity: Medium]
Is the "caller holds RTNL" statement true for the doit path?

PORT_GET uses ethnl_default_doit(), which only takes RTNL in some cases:

net/ethtool/netlink.c:ethnl_default_doit() {
    ...
		need_rtnl = !netdev_need_ops_lock(req_info->dev) ||
			    ethtool_nl_msg_needs_rtnl(req_info->dev, cmd);
		if (need_rtnl)
			rtnl_lock();
    ...
}

ethtool_nl_msg_needs_rtnl() in net/ethtool/common.h has no
ETHTOOL_MSG_PORT_GET case, so it returns false. On an ops-locked netdev,
port_prepare_data() then runs with only netdev_lock_ops() held.

If dev->link_topo is non-NULL, phy_link_topo_get_port() would hit
ASSERT_RTNL(). Also, nothing would order the xa_load() and the reads of
the port against writers that only hold RTNL, such as phylink SFP
add/del or phy_attach/detach.

port_dump_one_dev() always calls rtnl_lock(), so doit and dump use
different locking for the same command.

Right now the WARN in phy_link_topo_add_port() keeps ops-locked devices
from getting ports. That check is skipped when dev->netdev_ops is still
NULL:

    if (WARN_ON_ONCE(dev->netdev_ops && netdev_need_ops_lock(dev)))
        return -EOPNOTSUPP;

One example is the SFP cage port created from phylink_create() before
the driver sets netdev_ops. The check is also not repeated if
request_ops_lock or queue_mgmt_ops is set later.

Would adding "case ETHTOOL_MSG_PORT_GET: return true;" to
ethtool_nl_msg_needs_rtnl() give the doit path the locking this comment
describes?

> +	port = phy_link_topo_get_port(req_info->dev, request->port_id);
> +	if (!port)
> +		return -ENODEV;

[Severity: Low]
When the requested ETHTOOL_A_PORT_ID doesn't exist, this returns -ENODEV
with no extack set. ethnl_parse_header_dev_get() returns the same -ENODEV
for an unknown ifindex or name, but it does set an extack message.

In the doit path, could this use NL_SET_BAD_ATTR() or
NL_SET_ERR_MSG_ATTR() on info->attrs[ETHTOOL_A_PORT_ID]? That would let
user space tell an unknown port apart from an unknown device.
ethnl_req_get_phydev() already does this for phy_index.

> +
> +	linkmode_copy(reply->supported, port->supported);
> +	phy_interface_copy(reply->interfaces, port->interfaces);
> +	reply->port_id = port->id;
> +	reply->mii = port->is_mii;
> +	reply->sfp = port->is_sfp;
> +	reply->upstream_port = port->upstream_port ? port->upstream_port->id : 0;

[Severity: High]
Can this read a phy_port after it has been freed, if the PHY driver is
unbound at the same time?

Only RTNL protects the port here. The unbind path seems to remove and
free ports without holding RTNL:

phy_remove()
  phy_sfp_release(phydev)
  phy_cleanup_ports(phydev)
    phy_del_port(phydev, port)
      phy_link_topo_del_port(phydev->attached_dev, port)  /* xa_erase */
    phy_port_destroy(port)                                /* kfree */

phy_remove() is the mdio bus .remove callback and holds only
device_lock. In phy_sfp_release(), sfp_bus_del_upstream() takes and
then drops RTNL itself:

    rtnl_lock();
    if (bus->sfp)
        sfp_unregister_bus(bus);
    sfp_upstream_clear(bus);
    rtnl_unlock();

So the is_sfp ports are deleted and freed after RTNL has been released.

The device link created in phy_attach_direct() is DL_FLAG_STATELESS.
Unbinding the PHY driver therefore does not unbind the MAC first.

Before this series phy_del_port() did not touch the topology. This patch
adds the first reader of topo->ports.

Suppose a PORT_GET doit or dump loads the port, and then phy_remove()
erases it and calls kfree() on it. Would linkmode_copy() and
phy_interface_copy() here copy freed memory into the reply? Would
port->upstream_port->id follow a stale pointer?

PORT_GET has no GENL_UNS_ADMIN_PERM, so the reader does not need any
privilege.

[ ... ]

> @@ -0,0 +1,385 @@
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
> +	int ret, port_type;
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
> +	port_type = ETHTOOL_PORT_TYPE_MDI;
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
> +	if (tb[ETHTOOL_A_PORT_ID]) {
> +		NL_SET_BAD_ATTR(info->info.extack, tb[ETHTOOL_A_PORT_ID]);
> +		return -EINVAL;
> +	}
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
> +	ret = port_prepare_data(&ctx->req_info->base, &ctx->reply_data->base,
> +				genl_info_dump(cb));
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
> +	int ret = 0;
> +
> +	dev = ctx->req_info->base.dev;
> +
> +	rtnl_lock();
> +	netdev_lock_ops(dev);
> +
> +	if (!dev->link_topo)
> +		goto out;
> +
> +	xa_for_each_start(&dev->link_topo->ports, ctx->pos_portid, port,
> +			  ctx->pos_portid) {
> +		ctx->req_info->port_id = ctx->pos_portid;
> +
> +		ret = port_dump_one(skb, dev, cb);
> +		if (ret == -ENODEV)
> +			continue;
> +		if (ret)
> +			goto out;
> +	}
> +
> +	ret = 0;
> +
> +out:
> +	netdev_unlock_ops(dev);
> +	rtnl_unlock();
> +
> +	return ret;
> +}
> +
> +static int port_dump_all_dev(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
> +	unsigned long start_ifindex = ctx->pos_ifindex;
> +	struct net *net = sock_net(skb->sk);
> +	netdevice_tracker dev_tracker;
> +	struct net_device *dev;
> +	int ret = 0;
> +
> +	rcu_read_lock();
> +	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> +		if (ctx->pos_ifindex != start_ifindex)
> +			ctx->pos_portid = 0;
> +
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
> +		if (ret)
> +			break;
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

[Severity: Medium]
The bit positions in ETHTOOL_A_PORT_SUPPORTED_INTERFACES, and the
string IDs in the new ETH_SS_PHY_INTERFACES set, come directly from
phy_interface_t. That enum lives in include/linux/phy.h, not in a uapi
header, and nothing marks it as append-only. New modes have also not
always been added at the end; some were inserted next to related modes
in the middle of the enum.

Compare this with ETH_SS_LINK_MODES, which is backed by
enum ethtool_link_mode_bit_indices in include/uapi/linux/ethtool.h,
where new entries may only be appended.

With this patch, any later insertion into phy_interface_t renumbers
every interface after it on the wire. A compact bitset (the
ETHTOOL_FLAG_COMPACT_BITSETS case in port_fill_reply()) carries only
the bit positions. A tool that caches or hardcodes those indices would
then silently decode the reply as the wrong interfaces. The
phy_interface_names[] table filled by ethnl_phy_names_populate()
follows the renumbering, so only clients that fetch the string set
every time are unaffected.

Once this is merged the numbering becomes uAPI and can't be fixed
afterwards. Should phy_interface_t, or a uapi copy of it with a
translation table, live in include/uapi/linux/ethtool.h with an
append-only rule? Or, at a minimum, should include/linux/phy.h say
that the values are now ABI and must not be reordered? If the intent
is that user space always resolves these bits through
ETH_SS_PHY_INTERFACES, could that be documented in the netlink spec?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016133107.54054-1-maxime.chevallier%40bootlin.com
