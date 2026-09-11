Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC8401494;
	Fri, 11 Sep 2026 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152739; cv=none; b=S7kCEPD/2QxSucTYtgWOOGtjQkf7zSrUXR6+6ZYpNz02MMjX++NhIyfhouV/wXFgZ6ZqveJkmrmfwA0MeFEf7YlqMF+7WofbJ5jCMdTdOOCOsB06/fVWOPzDoyL2Wn2CudMkA8CK/k4zN4q1sFcL1f6BT/6QyOSdHvj19gKI8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152739; c=relaxed/simple;
	bh=DGImqdO9yPVU1FbO0unlvuKtJwxZxH7FVAPCHhLedn8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3j2ZmOTDclUtCKsqQaPfi+JrHqvM0Fp/4Gj04bdxkibWERZiRRx9MsMKjQzBKvyyGw2a9r9PLNWKI0c2VX2sZO5YGb4Jr8WrA6o6YIjLkhTdqOw6iJ05dq+pl1Fd7I0rtH8T6TJxh5wsWKYFpK7Pugk2UBG4HORpoHaXfLiVGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrI5ZsSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrI5ZsSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F2A1F0089B;
	Fri, 11 Sep 2026 18:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152735;
	bh=nymIeaY2CPURXZL5BRkPttPdOPj7Tafm1YKSR9DuzSA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WrI5ZsSsZjhHO7TGpWuq8qpx8gJOFRCGHzVK4QBqhxhdMwzbC3f5I8+q2E4RnKd3R
	 w+7tTnThpii5YLa2z3ILQEN6FRQAdbdH6kO+OlWkSmDfxwCp0btVmLCS0bMOKtGh+E
	 LvQPaWUskP5Dn2MLTpvKUbotzyG0zgzFZ+GCT32QAh9REvSj+cQUSONaEBmPwarfSY
	 8P1uCx7B/eAD+syYrnKXLvUYRA+tXODpD5+hvbNRTiJLJbZGIisajitRDh3MWIPhCy
	 9jX9ZfZ6nNxHs2RRFkduqzUU9/RwFx5xVau2sUOkJC7d3zs1gL4tW3URbKc3MGi1u0
	 CFjwWXNOFl0rQ==
Subject: Re: [PATCH RESEND net-next v17 09/10] net: ethtool: Introduce ethtool
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
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it
Date: Fri, 11 Sep 2026 18:52:13 +0000
Message-ID: <178915273371.219967.17579333464618318374@kernel.org>
In-Reply-To: <20260910170103.1029108-10-maxime.chevallier@bootlin.com>
References: <20260910170103.1029108-10-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 4

- [Medium] ETHTOOL_A_PORT_SUPPORTED_INTERFACES publishes bit indices that
  are the raw values of the kernel-internal `enum phy_interface_t` (0 ..…
- [Medium] `ctx->pos_portid` in struct port_dump_ctx is a per-device sub-
  cursor but is not bound to `ctx->pos_ifindex`, and it is reset only…
- [Medium] port_dump_one_dev() reads and dereferences dev->link_topo and
  walks the RTNL-protected link_topo->ports xarray with no lock at all:…
- [Low] The commit message describes the new command inaccurately in two
  ways.
- [Low] The YAML spec declares the port-get DUMP request as carrying only
  `header` (Documentation/netlink/specs/ethtool.yaml:2912-2916), but the…
- [Low] Concern (dismissed after verification):
  Documentation/networking/phy-port.rst was said to still claim that…
- [Low] The "List of message types" inventory tables in
  Documentation/networking/ethtool-netlink.rst are not updated: at the…

--

net: ethtool: Introduce ethtool command to list ports

This adds a new ETHTOOL_MSG_PORT_GET netlink command that exposes the
phy_port objects registered in a netdev's link topology, with a custom
dump implementation in the new net/ethtool/port.c.  MDI ports report
supported linkmodes, MII ports report supported PHY interface modes.

A couple of questions on the commit message and on the new dump code
below.

[Severity: Low]
The changelog says:

    "For MDI ports, we report the list of supported linkmodes based on
    what the PHY that drives this port says.  For MII ports, i.e. empty
    SFP cages, we report the MII linkmodes that we can output on this
    port."

Are both halves of that accurate for this series?

For the first half, phylink_add_sfp_mod_port() fills the MDI port's
supported mask from the module, not from a PHY:

	caps = sfp_get_module_caps(pl->sfp_bus);
	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
					pl->sfp_cage_port->interfaces);
	...
	port->upstream_port = pl->sfp_cage_port;

For the second half, the cage's MII port stays registered while a module
is inserted (pl->sfp_cage_port lives from sfp bus attach to detach), and
a PHY-less module registers a second, MDI port pointing back at the cage
via upstream_port.  So one populated SFP connector yields two dump
records, which makes "we can know how many ports are available on a given
interface" ambiguous.  Could the wording be adjusted to describe the
cage port and the module port separately?

[Severity: Low]
Should the message-type inventory tables in
Documentation/networking/ethtool-netlink.rst be extended too?  At the end
of the series the userspace-to-kernel table still ends at
``ETHTOOL_MSG_MSE_GET`` and the kernel-to-userspace table at
``ETHTOOL_MSG_MSE_GET_REPLY``, even though the PORT_GET section and the
ioctl translation table in the same file already mention the new command.

> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 1af395b54330e..c076c07d0a080 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -26,6 +26,8 @@ static u32 ethnl_bcast_seq;
>  			     ETHTOOL_FLAG_OMIT_REPLY)
>  #define ETHTOOL_FLAGS_STATS (ETHTOOL_FLAGS_BASIC | ETHTOOL_FLAG_STATS)
>  
> +char phy_interface_names[PHY_INTERFACE_MODE_MAX][ETH_GSTRING_LEN] __ro_after_init;
> +
>  const struct nla_policy ethnl_header_policy[] = {

[ ... ]

> @@ -1594,10 +1606,23 @@ static struct genl_family ethtool_genl_family __ro_after_init = {
>  
>  /* module setup */
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

[Severity: Medium]
These names are built at init time from phy_modes() and are not exported
through any ETH_SS_* string set.  enum ethtool_stringset in
include/uapi/linux/ethtool.h ends at ETH_SS_TS_FLAGS, and
net/ethtool/strset.c info_template has no entry for them, so userspace
cannot resolve the bit indices via ETHTOOL_MSG_STRSET_GET the way it can
for ETH_SS_LINK_MODES.

Does that make the raw values of enum phy_interface_t part of the uAPI?
See the port_fill_reply() comment below.

> diff --git a/net/ethtool/port.c b/net/ethtool/port.c
> new file mode 100644
> index 0000000000000..0d6150e5f66a2
> --- /dev/null
> +++ b/net/ethtool/port.c
> @@ -0,0 +1,382 @@

[ ... ]

> +const struct nla_policy ethnl_port_get_policy[ETHTOOL_A_PORT_ID + 1] = {
> +	[ETHTOOL_A_PORT_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
> +	[ETHTOOL_A_PORT_ID] = NLA_POLICY_MIN(NLA_U32, 1),
> +};

[Severity: Low]
The YAML spec declares the port-get dump request as carrying only
"header", but this single policy is shared by both doit and dumpit, so a
dump request that carries ETHTOOL_A_PORT_ID passes validation.
ethnl_port_dump_start() only looks at tb[ETHTOOL_A_PORT_HEADER], so the
port id is silently ignored and every port is returned.

Would it be better to reject it explicitly, the way
ethnl_rss_dump_start() does for its do-only filter attribute?

	/* Filtering by context not supported */
	if (tb[ETHTOOL_A_RSS_CONTEXT]) {
		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_CONTEXT]);
		return -EINVAL;
	}

[ ... ]

> +static int port_fill_reply(struct sk_buff *skb,
> +			   const struct ethnl_req_info *req_info,
> +			   const struct ethnl_reply_data *reply_data)
> +{

[ ... ]

> +	} else {
> +		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
> +				       reply->interfaces, NULL,
> +				       PHY_INTERFACE_MODE_MAX,
> +				       phy_interface_names, compact);
> +		if (ret < 0)
> +			return ret;
> +	}

[Severity: Medium]
This publishes bit indices that are the raw values of the kernel-internal
enum phy_interface_t, and Documentation/netlink/specs/ethtool.yaml
declares supported-interfaces only as a plain bitset nest with no enum:

        name: supported-interfaces
        type: nest
        nested-attributes: bitset

A client that sets ETHTOOL_FLAG_COMPACT_BITSETS gets only
ETHTOOL_A_BITSET_VALUE, with no way to map bits to names, so it has to
hard-code the enum values.  Does that freeze the ordering of
enum phy_interface_t as ABI?

The enum has been edited in the middle before:
PHY_INTERFACE_MODE_100BASEX sits between TRGMII and 1000BASEX in the
enum while its phy_modes() case is appended near the end, which suggests
it was inserted rather than appended.  Any future insertion would
re-label already-published bits.

Would adding an ETH_SS_* string set for these names (or defining the
values in the YAML spec) avoid that?

[ ... ]

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

[Severity: Medium]
Can ctx->pos_portid be applied to the wrong device?  It is a per-device
sub-cursor but it is not tied to ctx->pos_ifindex, and it is only reset
after the port loop runs to completion.

In port_dump_all_dev(), the -EMSGSIZE break leaves pos_ifindex pointing
at the interrupted device (for_each_netdev_dump() increments only after
the body) and pos_portid non-zero.  No reference is held on that device
between two ->dumpit() invocations, so if it goes away, xa_find() in
for_each_netdev_dump() returns the next higher ifindex, and this loop
resumes a different device's xarray at the stale index.  Port ids start
at 1:

drivers/net/phy/phy_link_topology.c:netdev_alloc_phy_link_topology() {
	...
	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
	topo->next_port_index = 1;
	...
}

so ports 1..N-1 of that device would be dropped from the reply with no
error reported.

The "if (!dev->link_topo) return 0;" early exit also returns before
"ctx->pos_portid = 0;", so a stale cursor survives every topology-less
device visited in the same invocation.  Should the reset happen at the
top of the function, or should pos_portid be cleared whenever
pos_ifindex changes?

[Severity: Medium]
What protects dev->link_topo and the ports xarray during this walk?
port_dump_all_dev() calls rcu_read_unlock() before invoking this
function, the filtered path in ethnl_port_dumpit() holds nothing, and
RTNL is taken only inside the loop body by port_dump_one().

The accessor added in this same series documents the opposite contract:

include/linux/phy_link_topology.h:phy_link_topo_get_port() {
	/* ports in the topo are RTNL protected, ... */
	ASSERT_RTNL();

	/* Caller must hold RTNL while handling the phy_port */
	return xa_load(&topo->ports, port_id);
}

Two things follow from that.  First, dev->link_topo is published with a
plain store after the xarray is initialised:

drivers/net/phy/phy_link_topology.c:netdev_alloc_phy_link_topology() {
	...
	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
	topo->next_port_index = 1;

	dev->link_topo = topo;
	...
}

and read here with a plain load.  Can a first port registration (for
instance phy_attach_direct() or phylink SFP cage creation from ndo_open)
racing with the dump expose a non-NULL topology whose xarray stores are
not yet visible on a weakly-ordered architecture?  At minimum this looks
like a data race KCSAN would flag.

Second, since RTNL is dropped between every port, every netdev and every
recvmsg resumption, ports added or removed mid-dump (for example
phylink_add_sfp_mod_port() / phylink_del_sfp_mod_port() on module
hotplug) can be skipped or repeated.  There is no generation counter and
NLM_F_DUMP_INTR is never set, so userspace cannot detect it.  Would
holding rtnl_lock() across the xa_for_each_start() loop, or snapshotting
the ids under RTNL, be preferable?

For what it is worth, the returned port pointer is never dereferenced
here and port_prepare_data() re-looks-up the id under
rtnl_lock()+netdev_lock_ops(), so a stale id turns into -ENODEV rather
than a use-after-free.  The same lockless pattern also already exists in
ethnl_perphy_dump_one_dev() for link_topo->phys.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910170103.1029108-1-maxime.chevallier%40bootlin.com
