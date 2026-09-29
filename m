Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C03AEF37;
	Tue, 29 Sep 2026 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668201; cv=none; b=o2TNVrh9A3/A8HucCuQyW4tRIATiCFE9otKw1iZV49cDYgk01+4+O4RatCVvXioG7cGGhbxAjcyE03urn0lK7q8fvLvLWRHt/ZoTyW3X+UpIpyy7XSXBPkbiK5w7ZvaS96LOnLI7qBRTrWLC41E1RtOEFAO0x3ucS7xZhGPgHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668201; c=relaxed/simple;
	bh=Lr0VnnV+9olAqLndLK/oYl/Df2yy0o/e2dbp2UgYUbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=S4LKP7fvE52KiVE1YAy64D+mRgofNgBXSHGEmQzQuEIaSJ+Yj+lHb0t1lNbqn8Szx65k5PMCwTB2rGw+9UI4wctFZpfT5OY+CLBrM+hp8/fUvafCLIFAViPQ0eaM86u9ev9O21s9Us1pDQCzLmWGzV0gIZznTaJTE9soiamon7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BXTu4xue; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BXTu4xue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790668204; x=1822204204;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Lr0VnnV+9olAqLndLK/oYl/Df2yy0o/e2dbp2UgYUbM=;
  b=BXTu4xueUu+2rVUVHR6w4zXFRPv0IMajJcXpF6/uohTpYjxhoDegBWPM
   0K7waelMkqUcjHmPd59GJQYGhIEfs96KmyLycD9mPrLdEXGJel4/iwV66
   8EbLmU6q2BOJ6G/wtpTXYZO3GWswyEcJeci8zahFjzjNLb5Ez1Y+TTB8q
   EAhqXWLyyffr2KkzRkvDRmtmCsPZT4RsKNpbTYkr8kP5TokfPIfgz5KNC
   M1tLLaC6flDCmQovfAQdidqverk6Do0Zqqwu6zchIiEU55EFNXoFGQoW4
   VYWmTaNjzPUwm05cnL0OpdPayfemIjanJFbS/aMFKbvSypC1qOXhU59AL
   w==;
X-CSE-ConnectionGUID: iLyullmyR4uPz8RNY6JKbQ==
X-CSE-MsgGUID: 7fsmP+soSzyYf+nVi5KnQQ==
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="74490990"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:50:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 29 Sep 2026 00:49:58 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 29 Sep 2026 00:49:53 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 29 Sep 2026 09:48:29 +0200
Subject: [PATCH net-next v13 8/9] net: dsa: lan9645x: add bridge support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260929-dsa_lan9645x_switch_driver_base-v13-8-827c2d3617f2@microchip.com>
References: <20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2@microchip.com>
In-Reply-To: <20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Russell King
	<linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

Add support for hardware offloading of the bridge. We support a single
bridge device.

Mac entry ageing can be configured with a 2s granularity, and a
requested time is rounded down. An ANA_AUTOAGE.AGE_PERIOD of 0 stops the
analyzer from ageing at all, which is the opposite of what a bridge
ageing time of 0 asks for, so ds->ageing_time_min and
ds->ageing_time_max let the DSA core reject what the hardware cannot
express.

The flood masks are global and not per ingress port, so a host flood
request from one port causes unknown unicast or multicast from every
port to be forwarded to the CPU.

The bridge applies promiscuous mode to enslaved ports under most
conditions even when VLAN filtering is enabled. To protect a weak
external CPU, port_set_host_flood requests for offloaded bridged ports
are recorded, but not programmed until the port leaves the bridge.
Standalone ports get programmed, so software bridging works.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v12:
- Move this patch after vlan, mac table and mdb support, so
  .port_fast_age exists for the STP state transitions and host address
  filtering is already advertised.
- Drop the open coded single bridge check now that ds->max_num_bridges
  makes the core reject a second bridge, and the now unused bridge field.
- Set ds->ageing_time_min and drop the clamp and the msecs == 0 case
  from lan9645x_set_ageing_time(). An ANA_AUTOAGE.AGE_PERIOD of 0 stops
  the analyzer from ageing, which is the opposite of what a bridge
  ageing_time of 0 asks for, so the DSA core now rejects out of range
  values instead.
- Drop mact_lock from lan9645x_set_ageing_time() after the fdb dump no
  longer toggles ageing.
- Remove the CPU port module from the unicast and multicast flood masks.
  Host address filtering covers the known addresses and
  port_set_host_flood() covers promiscuous and allmulti.
- Move lan9645x_vlan_clear_hostmode() here, with its caller.
- Describe the host flood compromise for offloaded bridged ports.
- lan9645x_port_set_learning() now takes fwd_domain_lock.
- port_set_host_flood(): drop the per port work and ordered workqueue
  and program the masks inline, since the ndo no longer runs in atomic
  context.
- Remove unreachable WARN_ON()s and the equally unreachable NPI port
  check in lan9645x_port_bridge_flags(). DSA does not call the port
  operations for the CPU port.

Changes in v9:
- Drop the port_mux_lock teardown from the setup error path, as the
  mutex has been removed.

Changes in v8:
- Use lan9645x->num_phys_ports instead of CPU_PORT for the CPU port
  module in the port pgid and host flood helpers.

Changes in v5:
- use ds->ageing_time_max
- use packed p->host_flood_req for atomic r/w
- fix typo in set_ageing_time comment
- include lan9645x->bridge deref under lock in brige_join

Changes in v4:
- set_host_flood changed to per port work to coalesce values and skip
  atomic allocations

Changes in v3:
- allow disabling aging with explicit zero parameters.
- fix non-forwarding stp states
- fix restore host_flood requests on bridge leave
- destroy fwd_domain_lock mutex on setup err path

Changes in v2:
- variable name consistency
- port_set_learning use stp_state before writing to hw
- add set_host_flood for selftests, which need promic/all_multi on
standalone interfaces
---
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 291 ++++++++++++++++++++-
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |   7 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c |   9 +
 3 files changed, 296 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
index cc85e18c5a3b..e41a73c20606 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -283,19 +283,15 @@ static int lan9645x_setup(struct dsa_switch *ds)
 
 	lan9645x_port_cpu_init(lan9645x);
 
-	/* Multicast to cpu and all front ports */
-	lan_wr(BIT(lan9645x->num_phys_ports) | front_ports, lan9645x,
-	       ANA_PGID(PGID_MC));
+	/* Multicast to all front ports */
+	lan_wr(front_ports, lan9645x, ANA_PGID(PGID_MC));
 
-	/* IP multicast to cpu and all front ports */
-	lan_wr(BIT(lan9645x->num_phys_ports) | front_ports, lan9645x,
-	       ANA_PGID(PGID_MCIPV4));
-	lan_wr(BIT(lan9645x->num_phys_ports) | front_ports, lan9645x,
-	       ANA_PGID(PGID_MCIPV6));
+	/* IP multicast to all front ports */
+	lan_wr(front_ports, lan9645x, ANA_PGID(PGID_MCIPV4));
+	lan_wr(front_ports, lan9645x, ANA_PGID(PGID_MCIPV6));
 
-	/* Unicast to cpu and all front ports */
-	lan_wr(BIT(lan9645x->num_phys_ports) | front_ports, lan9645x,
-	       ANA_PGID(PGID_UC));
+	/* Unicast to all front ports */
+	lan_wr(front_ports, lan9645x, ANA_PGID(PGID_UC));
 
 	/* Broadcast to cpu and all front ports */
 	lan_wr(BIT(lan9645x->num_phys_ports) | front_ports, lan9645x,
@@ -306,6 +302,19 @@ static int lan9645x_setup(struct dsa_switch *ds)
 	ds->fdb_isolation = true;
 	ds->max_num_bridges = 1;
 
+	/* ANA_AUTOAGE_AGE_PERIOD is a seconds-based field and entries are
+	 * aged after 2 * AGE_PERIOD, giving (2 * FIELD_MAX) seconds of
+	 * maximum aging and 2 seconds of minimum aging.
+	 *
+	 * An AGE_PERIOD of 0 stops the analyzer from aging at all, which is
+	 * the opposite of what a bridge ageing_time of 0 asks for. The bridge
+	 * expires every dynamic entry immediately in that case and floods, so
+	 * reject it rather than keep learned addresses forever.
+	 */
+	ds->ageing_time_min = 2U * MSEC_PER_SEC;
+	ds->ageing_time_max = 2U * MSEC_PER_SEC *
+			      FIELD_MAX(ANA_AUTOAGE_AGE_PERIOD);
+
 	dev_info(lan9645x->dev,
 		 "SKU features: max_ports=%d\n",
 		 lan9645x->num_phys_ports - lan9645x->num_port_dis);
@@ -324,6 +333,257 @@ static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
 	lan9645x_phylink_get_caps(ds->priv, port, config);
 }
 
+static int lan9645x_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	struct lan9645x *lan9645x = ds->priv;
+
+	/* Entry must suffer two aging scans before it is removed, so it is
+	 * aged after 2*AGE_PERIOD, and the unit is in seconds.
+	 */
+	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(msecs / (2 * MSEC_PER_SEC)),
+		ANA_AUTOAGE_AGE_PERIOD,
+		lan9645x, ANA_AUTOAGE);
+
+	return 0;
+}
+
+static int lan9645x_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					  struct switchdev_brport_flags flags,
+					  struct netlink_ext_ack *extack)
+{
+	if (flags.mask &
+	    ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void lan9645x_port_pgid_set(struct lan9645x *lan9645x, u16 pgid,
+				   int chip_port, bool enabled)
+{
+	u32 reg_msk, port_msk;
+
+	port_msk = ANA_PGID_PGID_SET(enabled ? BIT(chip_port) : 0);
+	reg_msk = ANA_PGID_PGID_SET(BIT(chip_port));
+
+	lan_rmw(port_msk, reg_msk, lan9645x, ANA_PGID(pgid));
+}
+
+static void lan9645x_port_set_learning(struct lan9645x *lan9645x, int port,
+				       bool enabled)
+{
+	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
+
+	mutex_lock(&lan9645x->fwd_domain_lock);
+	p->learn_ena = enabled;
+
+	enabled = enabled && (p->stp_state == BR_STATE_LEARNING ||
+			      p->stp_state == BR_STATE_FORWARDING);
+
+	lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(enabled), ANA_PORT_CFG_LEARN_ENA,
+		lan9645x, ANA_PORT_CFG(p->chip_port));
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+}
+
+static int lan9645x_port_bridge_flags(struct dsa_switch *ds, int port,
+				      struct switchdev_brport_flags f,
+				      struct netlink_ext_ack *extack)
+{
+	struct lan9645x *lan9645x = ds->priv;
+
+	/* DSA core does not call this for the CPU port */
+	if (f.mask & BR_LEARNING)
+		lan9645x_port_set_learning(lan9645x, port,
+					   !!(f.val & BR_LEARNING));
+
+	if (f.mask & BR_FLOOD)
+		lan9645x_port_pgid_set(lan9645x, PGID_UC, port,
+				       !!(f.val & BR_FLOOD));
+
+	if (f.mask & BR_MCAST_FLOOD) {
+		bool ena = !!(f.val & BR_MCAST_FLOOD);
+
+		lan9645x_port_pgid_set(lan9645x, PGID_MC, port, ena);
+		lan9645x_port_pgid_set(lan9645x, PGID_MCIPV4, port, ena);
+		lan9645x_port_pgid_set(lan9645x, PGID_MCIPV6, port, ena);
+	}
+
+	if (f.mask & BR_BCAST_FLOOD)
+		lan9645x_port_pgid_set(lan9645x, PGID_BC, port,
+				       !!(f.val & BR_BCAST_FLOOD));
+
+	return 0;
+}
+
+static void lan9645x_update_fwd_mask(struct lan9645x *lan9645x)
+{
+	struct lan9645x_port *p;
+	struct dsa_port *dp;
+
+	lockdep_assert_held(&lan9645x->fwd_domain_lock);
+
+	/* Updates the source port PGIDs, making sure frames from p
+	 * are only forwarded to ports q != p, where q is relevant to forward
+	 */
+	dsa_switch_for_each_available_port(dp, lan9645x->ds) {
+		u32 mask = 0;
+
+		p = lan9645x_to_port(lan9645x, dp->index);
+
+		if (lan9645x_port_is_bridged(p) &&
+		    (lan9645x->bridge_fwd_mask & BIT(dp->index))) {
+			mask = lan9645x->bridge_mask &
+			       lan9645x->bridge_fwd_mask & ~BIT(dp->index);
+		}
+
+		lan_wr(ANA_PGID_PGID_SET(mask), lan9645x,
+		       ANA_PGID(PGID_SRC + dp->index));
+	}
+}
+
+static void __lan9645x_port_mark_host_flood(struct lan9645x *lan9645x, int port,
+					    bool uc, bool mc)
+{
+	lockdep_assert_held(&lan9645x->fwd_domain_lock);
+
+	if (uc)
+		lan9645x->host_flood_uc_mask |= BIT(port);
+	else
+		lan9645x->host_flood_uc_mask &= ~BIT(port);
+
+	if (mc)
+		lan9645x->host_flood_mc_mask |= BIT(port);
+	else
+		lan9645x->host_flood_mc_mask &= ~BIT(port);
+}
+
+static void __lan9645x_port_set_host_flood(struct lan9645x *lan9645x)
+{
+	bool mc_ena, uc_ena;
+	u16 unbridged;
+
+	lockdep_assert_held(&lan9645x->fwd_domain_lock);
+
+	/* We want promiscuous and all_multi to affect standalone ports, for
+	 * software bridging, debug and test purposes.
+	 *
+	 * However, the linux bridge is incredibly eager to put bridged ports in
+	 * promiscuous mode.
+	 *
+	 * This is unfortunate since lan9645x flood masks are global and not per
+	 * ingress port. When some port triggers unknown uc/mc to the CPU, the
+	 * traffic from any port is forwarded to the CPU.
+	 *
+	 * If the host CPU is weak, this can cause tremendous stress. Therefore,
+	 * we compromise by ignoring this host flood request for offloaded
+	 * bridged ports.
+	 */
+	unbridged = ~lan9645x->bridge_mask &
+		    GENMASK(lan9645x->num_phys_ports - 1, 0);
+
+	uc_ena = !!(lan9645x->host_flood_uc_mask & unbridged);
+	lan9645x_port_pgid_set(lan9645x, PGID_UC, lan9645x->num_phys_ports,
+			       uc_ena);
+
+	mc_ena = !!(lan9645x->host_flood_mc_mask & unbridged);
+	lan9645x_port_pgid_set(lan9645x, PGID_MC, lan9645x->num_phys_ports,
+			       mc_ena);
+	lan9645x_port_pgid_set(lan9645x, PGID_MCIPV4, lan9645x->num_phys_ports,
+			       mc_ena);
+	lan9645x_port_pgid_set(lan9645x, PGID_MCIPV6, lan9645x->num_phys_ports,
+			       mc_ena);
+}
+
+static void lan9645x_port_set_host_flood(struct dsa_switch *ds, int port,
+					 bool uc, bool mc)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+
+	mutex_lock(&lan9645x->fwd_domain_lock);
+	__lan9645x_port_mark_host_flood(lan9645x, p->chip_port, uc, mc);
+	__lan9645x_port_set_host_flood(lan9645x);
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+}
+
+static int lan9645x_port_bridge_join(struct dsa_switch *ds, int port,
+				     struct dsa_bridge bridge,
+				     bool *tx_fwd_offload,
+				     struct netlink_ext_ack *extack)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+
+	mutex_lock(&lan9645x->fwd_domain_lock);
+
+	lan9645x->bridge_mask |= BIT(p->chip_port);
+	__lan9645x_port_set_host_flood(lan9645x);
+	lan9645x_vlan_clear_hostmode(p);
+
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+
+	/* Forwarding is updated by .port_stp_state_set(), which the core
+	 * invokes after this returns:
+	 * dsa_port_bridge_join() -> dsa_port_switchdev_sync_attrs() ->
+	 * dsa_port_set_state()
+	 */
+
+	return 0;
+}
+
+static void lan9645x_port_bridge_stp_state_set(struct dsa_switch *ds, int port,
+					       u8 state)
+{
+	struct lan9645x *lan9645x;
+	struct lan9645x_port *p;
+	bool learn_ena;
+
+	lan9645x = ds->priv;
+	p = lan9645x_to_port(lan9645x, port);
+
+	mutex_lock(&lan9645x->fwd_domain_lock);
+
+	p->stp_state = state;
+
+	if (state == BR_STATE_FORWARDING)
+		lan9645x->bridge_fwd_mask |= BIT(p->chip_port);
+	else
+		lan9645x->bridge_fwd_mask &= ~BIT(p->chip_port);
+
+	learn_ena = (state == BR_STATE_LEARNING ||
+		     state == BR_STATE_FORWARDING) && p->learn_ena;
+
+	lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(learn_ena),
+		ANA_PORT_CFG_LEARN_ENA, lan9645x,
+		ANA_PORT_CFG(p->chip_port));
+
+	lan9645x_update_fwd_mask(lan9645x);
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+}
+
+static void lan9645x_port_bridge_leave(struct dsa_switch *ds, int port,
+				       struct dsa_bridge bridge)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+
+	mutex_lock(&lan9645x->fwd_domain_lock);
+
+	lan9645x->bridge_mask &= ~BIT(p->chip_port);
+
+	__lan9645x_port_set_host_flood(lan9645x);
+	lan9645x_vlan_set_hostmode(p);
+	lan9645x_update_fwd_mask(lan9645x);
+
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+}
+
 static int lan9645x_port_vlan_filtering(struct dsa_switch *ds, int port,
 					bool enabled,
 					struct netlink_ext_ack *extack)
@@ -521,6 +781,15 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.port_change_mtu		= lan9645x_change_mtu,
 	.port_max_mtu			= lan9645x_get_max_mtu,
 
+	/* Bridge integration */
+	.set_ageing_time		= lan9645x_set_ageing_time,
+	.port_pre_bridge_flags		= lan9645x_port_pre_bridge_flags,
+	.port_bridge_flags		= lan9645x_port_bridge_flags,
+	.port_bridge_join		= lan9645x_port_bridge_join,
+	.port_bridge_leave		= lan9645x_port_bridge_leave,
+	.port_stp_state_set		= lan9645x_port_bridge_stp_state_set,
+	.port_set_host_flood		= lan9645x_port_set_host_flood,
+
 	/* VLAN integration */
 	.port_vlan_filtering		= lan9645x_port_vlan_filtering,
 	.port_vlan_add			= lan9645x_port_vlan_add,
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
index 82b2e469ff60..0b284eb4e9eb 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -195,6 +195,9 @@ struct lan9645x {
 	struct dsa_switch *ds;
 	struct regmap *rmap[NUM_TARGETS];
 
+	u16 host_flood_uc_mask;
+	u16 host_flood_mc_mask;
+
 	/* NPI chip_port */
 	int npi;
 
@@ -203,6 +206,7 @@ struct lan9645x {
 
 	/* Forwarding Database */
 	u16 bridge_mask; /* Mask for bridged ports */
+	u16 bridge_fwd_mask; /* Mask for forwarding bridged ports */
 	/* lock forwarding configuration and vlan table */
 	struct mutex fwd_domain_lock;
 	struct mutex mact_lock; /* serialize mac table register access */
@@ -225,6 +229,8 @@ struct lan9645x_port {
 	struct lan9645x *lan9645x;
 
 	u8 chip_port;
+	u8 stp_state;
+	bool learn_ena;
 
 	bool vlan_aware;
 	u16 pvid;
@@ -398,6 +404,7 @@ int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
 				struct netlink_ext_ack *extack);
 int lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid);
 void lan9645x_vlan_set_hostmode(struct lan9645x_port *p);
+void lan9645x_vlan_clear_hostmode(struct lan9645x_port *p);
 
 /* MAC table: lan9645x_mac.c */
 int lan9645x_mact_flush(struct lan9645x *lan9645x, int port);
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
index 6d28a7cf1442..29d679c853dc 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
@@ -347,6 +347,15 @@ void lan9645x_vlan_set_hostmode(struct lan9645x_port *p)
 	lan9645x_vlan_port_apply(p);
 }
 
+void lan9645x_vlan_clear_hostmode(struct lan9645x_port *p)
+{
+	lockdep_assert_held(&p->lan9645x->fwd_domain_lock);
+
+	p->lan9645x->vlans[HOST_PVID].portmask &= ~BIT(p->chip_port);
+	lan9645x_vlan_hw_wr(p->lan9645x, HOST_PVID);
+	lan9645x_vlan_port_apply(p);
+}
+
 int lan9645x_vlan_init(struct lan9645x *lan9645x)
 {
 	u32 all_phys_ports, all_ports;

-- 
2.52.0

