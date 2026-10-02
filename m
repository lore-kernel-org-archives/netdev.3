Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC2C4AA007;
	Fri,  2 Oct 2026 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975668; cv=none; b=DPjzT4TRlnYnHCllJkNPsPa7R/x0tGIMVh3Xm09bdrhxy2dZKg4Yu7eXFbO8OEO1A1G+Cq4Ji3b2+QcaZuKwbA5YSwscppI0GsKrlFf6f72oK/yl8X3DjIkc8RF6PeuulgbSOZ+zSag6CH8MaMQc5Jyl+0ijyy/jUQM5InKdyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975668; c=relaxed/simple;
	bh=bfNguMEDDjm1cdHdYYx9i1bo4OMGC5TEaNFXyFOI+zM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUhoKr5yrrW7/LF8inNVgSzvnkSxjguODWS7oV10E5wUcBCchF2PE0QZSCSsLmc6LyYmVzWo6HkVo1pR39lGvhAPdI34kph2ihCdLmDle1YFVw7trG2SUvDnlC1A6wdkJHtGfnl2KtSGg/+A4yNAf8/qynV1cyyXLXEyJWMYQNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWKzb9An; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWKzb9An"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1881F000FF;
	Fri,  2 Oct 2026 21:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975666;
	bh=oE1vJbS9yWqyfAD52Wg1WvsvHtCW5hc6ZeR1BRNouGw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YWKzb9AnR6iNWOEcg9COHSAlz3jddHJQQzIbZn3WGyIha3TrchV2hKne6XmQgpN3L
	 jz6qqZRwPmpePseKKYhoG8Af9YlzeQ9CSSYcLWQG6ESsA4hkafx3RraQ62K4K0j6Sp
	 T1zAOLrGCx/Ntj0SlNrAaHZ2Aqov1qvW6LQq8VJygaXjcgyF/i838YahevgQ12VnpR
	 1VxARKb4aR3/Y1l4P7UcywMtW9C/0robSmxmYsOnP2vmltTUe0zQw7hfVl6LLEg4Y/
	 SgZWg58fimS77XXt2TYthMit8e+x2HesoqG5PG+cqwbz23NPx6ASaM4ZIw9a0ZBTMw
	 LCHXSH1lIJFpw==
Subject: Re: [PATCH net-next v13 8/9] net: dsa: lan9645x: add bridge support
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Fri, 02 Oct 2026 21:14:24 +0000
Message-ID: <179097566495.434549.3273751118758202353@kernel.org>
In-Reply-To:
 <20260929-dsa_lan9645x_switch_driver_base-v13-8-827c2d3617f2@microchip.com>
References:
 <20260929-dsa_lan9645x_switch_driver_base-v13-8-827c2d3617f2@microchip.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] __lan9645x_port_set_host_flood() computes uc_ena/mc_ena from
  host_flood_*_mask & ~bridge_mask, so it drops every host flood request…
- [Medium] The MDB code falls back to the L2 multicast flood PGID
  (PGID_MC) when it runs out of general-purpose PGIDs.
- [Medium] The patch sets ds->ageing_time_min = 2000 ms, so enslaving a
  lan9645x port to a bridge with ageing_time below 2 s (for example 0,…

--

net: dsa: lan9645x: add bridge support

This adds hardware bridge offload to the lan9645x DSA driver for a single
bridge. It covers ageing time, bridge port flags, STP state and host flood.
The CPU port module is taken out of the default UC/MC flood PGIDs. Host
flood requests from offloaded bridged ports are recorded, but they are not
programmed until the port leaves the bridge.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index cc85e18c5a3b3..e41a73c20606b 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c

[ ... ]

> @@ -324,6 +333,257 @@ static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,

[ ... ]

> +static int lan9645x_port_bridge_flags(struct dsa_switch *ds, int port,
> +				      struct switchdev_brport_flags f,
> +				      struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	if (f.mask & BR_MCAST_FLOOD) {
> +		bool ena = !!(f.val & BR_MCAST_FLOOD);
> +
> +		lan9645x_port_pgid_set(lan9645x, PGID_MC, port, ena);

[Severity: Medium]
Does this work with the MDB fallback to PGID_MC?

When the general-purpose PGIDs run out, __lan9645x_mdb_add() and
__lan9645x_mdb_del() in lan9645x_mdb.c point a group at PGID_MC:

drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c:__lan9645x_mdb_add() {
    ...
		if (lan9645x_mdb_on_flood_mask(mdb_entry, type))
			return lan9645x_mdb_widen_dest(lan9645x, mdb_entry,
						       type, NULL, PGID_MC,
						       new_ports);
    ...
}

drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c:__lan9645x_mdb_del() {
    ...
	lan9645x_mdb_narrow_dest(lan9645x, mdb_entry, type, NULL, PGID_MC,
				 new_ports);
    ...
}

After the fallback, the MAC table entry forwards to whatever PGID_MC
holds, not to the member mask that the MDB code computed. That worked
when PGID_MC was fixed to all front ports.

With this change, "bridge link set dev swpN mcast_flood off" clears swpN
from PGID_MC. In the software bridge, mcast_flood only affects
unregistered multicast. Here, though, it looks like a registered member
port with mcast_flood off would stop getting any group that has fallen
back to PGID_MC.

One way to reach this is more than 48 distinct front port subsets among
non-IP L2 MDB groups, for example static "bridge mdb add" entries on a
switch with 6 or more user ports. That would use up PGID_GP_START to
PGID_GP_END. IP multicast should not be affected because the MAC entry
encodes the port mask. CPU membership comes from MAC_CPU_COPY.

> +		lan9645x_port_pgid_set(lan9645x, PGID_MCIPV4, port, ena);
> +		lan9645x_port_pgid_set(lan9645x, PGID_MCIPV6, port, ena);
> +	}

[ ... ]

> +static void __lan9645x_port_set_host_flood(struct lan9645x *lan9645x)
> +{
> +	bool mc_ena, uc_ena;
> +	u16 unbridged;
> +
> +	lockdep_assert_held(&lan9645x->fwd_domain_lock);

[ ... ]

> +	unbridged = ~lan9645x->bridge_mask &
> +		    GENMASK(lan9645x->num_phys_ports - 1, 0);
> +
> +	uc_ena = !!(lan9645x->host_flood_uc_mask & unbridged);

[Severity: Medium]
lan9645x_setup() no longer puts the CPU port module in PGID_UC, PGID_MC,
PGID_MCIPV4 or PGID_MCIPV6. That leaves the host flood bit as the only
path for unknown unicast and unregistered multicast to reach the CPU.
With the unbridged filter here, can the CPU ever get that traffic when
only bridged ports ask for host flooding?

The bridge calls dev_set_allmulti(dev, 1) on every port in br_add_if().
br_manage_promisc() sets promisc when vlan_filtering=0, and also when
there is more than one auto port. dsa_user_manage_host_flood() passes
the flags through unchanged:

net/dsa/user.c:dsa_user_manage_host_flood() {
    bool mc = dev->flags & (IFF_PROMISC | IFF_ALLMULTI);
    ...
    bool uc = dev->flags & IFF_PROMISC;

    dsa_port_set_host_flood(dp, uc, mc);
}

Here, however, ~bridge_mask filters those requests out.

A few cases seem to be affected:

- Take a bridge with a lan9645x port and a foreign port such as wlan,
  veth or tap. The software bridge can't flood FDB misses or
  unregistered multicast to the foreign port. Assisted learning only
  covers addresses it has already learned. DSA returns -EOPNOTSUPP for
  MDB entries whose orig_dev is a foreign port, so the hardware would
  drop a multicast stream going to a wifi client.

- With multicast snooping disabled, br0 receives no non-link-local
  multicast.

- Setting promisc or allmulti explicitly on br0 or on a bridged port
  does nothing.

Documentation/networking/switchdev.rst asks for unknown unicast to be
flooded to every port in the domain. It also asks for flooding to the CPU
when IFF_PROMISC or IFF_ALLMULTI is set. I'd also expect the promisc and
allmulti cases of test_bridge in
tools/testing/selftests/net/forwarding/local_termination.sh to fail.

felix has the same global flood mask limitation, but it honours host
flood for bridged ports. The commit message only presents this as
protection for a weak CPU and doesn't mention these consequences.

> +	lan9645x_port_pgid_set(lan9645x, PGID_UC, lan9645x->num_phys_ports,
> +			       uc_ena);

[ ... ]

> +static void lan9645x_port_bridge_leave(struct dsa_switch *ds, int port,
> +				       struct dsa_bridge bridge)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct lan9645x_port *p;
> +
> +	p = lan9645x_to_port(lan9645x, port);
> +
> +	mutex_lock(&lan9645x->fwd_domain_lock);
> +
> +	lan9645x->bridge_mask &= ~BIT(p->chip_port);
> +
> +	__lan9645x_port_set_host_flood(lan9645x);
> +	lan9645x_vlan_set_hostmode(p);

[Severity: Medium]
Can the new ds->ageing_time_min = 2U * MSEC_PER_SEC in lan9645x_setup()
leave the driver and the DSA core disagreeing when a bridge join fails
partway through?

Suppose a port joins a bridge whose ageing_time is below 2 s, for
example 0. dsa_port_switchdev_sync_attrs() applies the brport flags, STP
state and VLAN filtering first. Only after that does
dsa_port_ageing_time() fail with -ERANGE:

dsa_port_bridge_join()
  DSA_NOTIFIER_BRIDGE_JOIN -> lan9645x_port_bridge_join()
  dsa_port_switchdev_sync_attrs()
    dsa_port_inherit_brport_flags()  p->learn_ena = true, dp->learning = true
    dsa_port_set_state()
    dsa_port_vlan_filtering(true)    p->vlan_aware = true, dp->vlan_filtering = true
    dsa_port_ageing_time()           -ERANGE
  out_rollback_unoffload / out_rollback_unbridge
    DSA_NOTIFIER_BRIDGE_LEAVE -> lan9645x_port_bridge_leave()

The rollback never calls dsa_port_switchdev_unsync_attrs(). Here,
lan9645x_vlan_set_hostmode() sets p->vlan_aware = false while
dp->vlan_filtering stays true. p->learn_ena stays true as well.

If the port later joins a vlan_filtering=1 bridge, dsa_port_vlan_filtering()
returns early:

	if (dsa_port_is_vlan_filtering(dp) == vlan_filtering)
		return 0;

As a result, lan9645x_port_vlan_filtering() is never called. Would the
port then run VLAN-unaware (UNAWARE_PVID, no VLAN_AWARE_ENA) inside a
VLAN-aware bridge?

If the port stays standalone and is brought down and up again, this path
runs:

dsa_port_enable_rt()
  dsa_port_set_state_now(BR_STATE_FORWARDING)
    lan9645x_port_bridge_stp_state_set()

learn_ena is computed from the stale p->learn_ena, and
ANA_PORT_CFG_LEARN_ENA gets set on a standalone port in HOST_PVID. Is
that intended?

The missing unsync in the DSA core rollback is older than this patch.
However, ageing_time_min is what makes it reachable for lan9645x. On top
of that, bridge_leave resets vlan_aware without DSA knowing.

> +	lan9645x_update_fwd_mask(lan9645x);
> +
> +	mutex_unlock(&lan9645x->fwd_domain_lock);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip.com
