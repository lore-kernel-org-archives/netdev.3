Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90613388899;
	Tue, 29 Sep 2026 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642335; cv=none; b=tmcN+piArZ9SxTSTr62ZUhzC7narP/IH2MoGINc4oF849VT7iSasr6e7c4Zg7hFya7zTV4VlAYgcRobTIXslnS8XdnuqfNKTgx+2UHHSM96QMBTlzB66qyb2Fr5MX4jkezdY9jVn5A2f5fYEj3/hwPLy4hfGzYG+14dfjCDcwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642335; c=relaxed/simple;
	bh=HinjL8W5kIU8nnfw7GSgydvUpDterVRc3E/cd0s+oBM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gU/YouQL6xCxDD8ZkYzq4MU669dyVnzRmvDPm29QOymla6t0BMVjvp0ONibSyR2jxuJAnEn/ZmGxH+dIhqivaXCrVIegNNqx2xplMhRjz39/m0GjCeTy239jtAmTZg9Eb5Yso9k0Yx/ywsyq1w2useqLuRQeLnLlZ1DgZOU7Amk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euZK987+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euZK987+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE56C1F0089B;
	Tue, 29 Sep 2026 00:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642327;
	bh=v+KwyoPjhqWrTT8ZmvlfLyp+aFdOnNaLLEiU5e2k6H4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=euZK987+iVLgVU+fo+esP3BXUql/OCi8UDPu6P0XLwGyULziXzMk9Hbwh4escbe0f
	 93w/hrIHhozFBmNAeQhkJlo6qOUqXvO5ZH0On3Lbp6IUHFtceixzPDx0V9yYoaL5wC
	 bJ2YeWXDRIoIerEDk7w0LWmUxDuhLZZLGlVunpPRm1QaKRz+3qiax8b1F3kKLd0wa+
	 i93lSLtQr6e8p7NKVwaHCdcgIFI45XpgiLsWL5ieG4c7IxaQWPSjEoAtzH7etsW6N0
	 SzGJAv7pb4gWRgE8lBG3wsdE84G8hZVhzVDHnCA4LLu0qxburqtFeSfu2HkKmvEfo+
	 qJeubjIRrlnwA==
Subject: Re: [PATCH net-next v18 09/10] net: ethtool: Introduce ethtool
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
 f@lex.la
Date: Tue, 29 Sep 2026 00:38:45 +0000
Message-ID: <179064232552.3145.9027939570900472817@kernel.org>
In-Reply-To: <20260927133619.955236-10-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-10-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ETHTOOL_A_PORT_SUPPORTED_INTERFACES is sent as an ethtool
  bitset.
- [Medium] In the unfiltered PORT_GET dump, ctx->pos_portid is carried
  from one dumpit() call to the next without recording which device it…
- [Medium] port_dump_one_dev() reads dev->link_topo twice (the NULL
  check, then &dev->link_topo->ports) and walks the ports xarray with no…
- [Low] The ETHTOOL_MSG_PORT_GET genl_ops entry in net/ethtool/netlink.c
  uses ethnl_port_get_policy for both doit and dumpit.

--

net: ethtool: Introduce ethtool command to list ports

This adds a new ETHTOOL_MSG_PORT_GET netlink command that exposes phy_port
information to userspace. MDI ports report their supported linkmodes, and
MII ports (empty SFP cages) report their supported PHY interface modes.
The command has a doit handler and its own dump implementation.

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
The doit and the dumpit of ETHTOOL_MSG_PORT_GET both use this policy. A
dump request that includes ETHTOOL_A_PORT_ID therefore passes validation.

ethnl_port_dump_start() only reads tb[ETHTOOL_A_PORT_HEADER]. The ID is
silently ignored and the dump returns every port. The port-get dump
request in Documentation/netlink/specs/ethtool.yaml only lists header.

Should the dump use a header-only policy, or reject ETHTOOL_A_PORT_ID?
That would keep "ignore the ID" from becoming the de facto behaviour, and
filtering by ID could still be added later.

[ ... ]

> +static int port_fill_reply(struct sk_buff *skb,
> +			   const struct ethnl_req_info *req_info,
> +			   const struct ethnl_reply_data *reply_data)
> +{
> +	bool compact = req_info->flags & ETHTOOL_FLAG_COMPACT_BITSETS;

[ ... ]

> +	} else {
> +		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
> +				       reply->interfaces, NULL,
> +				       PHY_INTERFACE_MODE_MAX,
> +				       phy_interface_names, compact);

[Severity: Medium]
ETHTOOL_A_PORT_SUPPORTED_INTERFACES is sent as an ethtool bitset indexed
by phy_interface_t. The compact flag comes directly from
ETHTOOL_FLAG_COMPACT_BITSETS in the request header, and port_reply_size()
uses the same encoding. In compact mode, userspace only gets raw bit
positions.

How is userspace expected to map those bits to names?

Every other ethtool bitset has a matching string set in info_template in
net/ethtool/strset.c (ETH_SS_LINK_MODES, ETH_SS_FEATURES,
ETH_SS_WOL_MODES, ETH_SS_TS_FLAGS, and so on). That lets userspace decode
compact replies with ETHTOOL_MSG_STRSET_GET.

I couldn't find an ETH_SS_* id in include/uapi/linux/ethtool.h, or a
strset entry, for phy_interface_names.

Without one, a compact client can either request again in verbose mode or
hard-code the phy_interface_t numbering. phy_interface_t is defined in
include/linux/phy.h and is not append-only. PSGMII sits between MOCA and
QSGMII, and 5GBASER sits between 2500BASEX and RXAUI. Inserting a new mode
later would shift what each bit means.

Could phy_interface_names be exported as a new string set? Or could this
bitset always be sent in verbose form? The commit message doesn't say how
userspace is meant to decode it.

A smaller point: ethnl_phy_names_populate() in net/ethtool/netlink.c fills
entry 0 from phy_modes(PHY_INTERFACE_MODE_NA), which returns "":

	for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++) {
		name = phy_modes(i);
		strscpy(phy_interface_names[i], name, ETH_GSTRING_LEN);
	}

A verbose bitset with that bit set would then carry an empty name. Is that
intended?

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

[Severity: Medium]
port_dump_one_dev() reads dev->link_topo twice and walks the ports xarray
with no RTNL, no netdev instance lock and no READ_ONCE(). RTNL is only
taken later, once per port, inside port_dump_one().

On the writer side, the topology is allocated lazily and published with a
plain store:

drivers/net/phy/phy_link_topology.c:netdev_alloc_phy_link_topology() {
	topo = kzalloc_obj(*topo);
	...
	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
	topo->next_port_index = 1;

	dev->link_topo = topo;
}

The comment in phy_link_topo_get_or_alloc() says this can run from
.ndo_open() or from the SFP state machine. At that point the netdev is
already registered and visible to dumps.

Can this race with an unprivileged PORT_GET dump?

CPU0 (ndo_open, RTNL held)
phy_attach_direct()
  phy_link_topo_add_phy()
    netdev_alloc_phy_link_topology()
      dev->link_topo = topo;

CPU1 (PORT_GET dump)
port_dump_all_dev()
  rcu_read_unlock();
  port_dump_one_dev()
    if (!dev->link_topo)
    xa_for_each_start(&dev->link_topo->ports, ...)

On weakly ordered architectures such as arm64 or powerpc, could CPU1 see
the new pointer before the xa_init_flags() stores are visible? xa_find()
would then follow a stale xa_head. Even if that never happens in practice,
this looks like a plain load racing a plain store, which KCSAN would
report.

ethnl_perphy_dump_one_dev() reads the topology the same way, but this
patch adds another lockless reader. Would it be better to take RTNL around
the whole per-device walk, or to pair smp_store_release() with
smp_load_acquire() on dev->link_topo?

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

[ ... ]

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

[Severity: Medium]
Suppose port_dump_one() returns -EMSGSIZE partway through a device's
ports. port_dump_one_dev() then returns with ctx->pos_portid still set to
that port's ID, and this loop breaks without advancing ctx->pos_ifindex.
pos_portid only goes back to 0 once every port on a device has been
dumped.

On the next dumpit() call, for_each_netdev_dump() resumes with xa_find()
from pos_ifindex. If that device was unregistered in between, xa_find()
returns the next device with a higher ifindex. port_dump_one_dev() then
starts walking that device's ports from the stale pos_portid:

	xa_for_each_start(&dev->link_topo->ports, ctx->pos_portid, port,
			  ctx->pos_portid) {

Would ports with lower IDs on that unrelated device be silently dropped
from the dump, with no NLM_F_DUMP_INTR to tell userspace?

ethnl_perphy_dump_all_dev() has the same pattern with pos_phyindex, but
this code is new. Could the dump context record which ifindex pos_portid
belongs to, and reset pos_portid when the device changes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927133619.955236-1-maxime.chevallier%40bootlin.com
