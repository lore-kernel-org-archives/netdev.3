Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BB4C33D1;
	Thu, 15 Oct 2026 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051593; cv=none; b=XnqctZmn7kgKRv4Jrg6Nb7kBoXV8viG/Es4k9cPF7HrGqw/WOTCFkUzU1E9rnUlaZsnCIw3Aax+cKEtklSHAjDP9EpPGKBVvngAVBNto7U4maLIHS6Iiv8wZMPHdFDrKvrD/3Z3jk2lD1kv5G8JiTOIU8xgLIyZkyHpIZCeVAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051593; c=relaxed/simple;
	bh=xA5gc0agyNEYI8zd9Te1fiN5lgSG0+tnrmo7+uG2oa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Vw/WKKNSgTkPbeAQRmd5pfomG+2pqZOzIBbjcFu1bTaRToODJ0HoI4kGxPyuMiQP1a0oT3L248sxEEWGyPm0SdHTiPC1Vh6zeHXdCPCMO4QZojc3wF/q6i3A0zECMWJNJqKGhIxTcB9abcwiRxH/S7n3fapulkUMLEJXps1mgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1szRDHgE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1szRDHgE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792051597; x=1823587597;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xA5gc0agyNEYI8zd9Te1fiN5lgSG0+tnrmo7+uG2oa0=;
  b=1szRDHgEb/iLOtA11GwmoR8l4KHhgxuQQuvHzElyz1mvodZnCL6s1kMi
   NICfLwlAVhYFff/TWgCsPZIbHH+XL1acYpfPggER5VVTc5txPbdHV7cBu
   0wKl+sm0D7RFEJu50enIu9epReErG0A4eP1Dqu2BSibfSYke18B1Vitr+
   J+xqLcqlBX5eHxZBRUNkBh5bQmy6oAQHd+sEf95kS6azuCS6vuCeEdgOm
   dnUWSmIh+00J+lMnDfYeRRWjIkIbDhT4n27qW5arEuw+wierxwrvYVLoN
   zijeeyaPtDX7GPb3uuvrX/8QBmy/RY/2c97J+FJTtwah9Qb1X0nqY9J4i
   A==;
X-CSE-ConnectionGUID: 8Rh0mPZYTZypalAZwPKx5Q==
X-CSE-MsgGUID: m9ATKFF3TWCT2kBztz2kWw==
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="296490685"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2026 01:06:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 15 Oct 2026 01:06:29 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 15 Oct 2026 01:06:25 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Thu, 15 Oct 2026 10:05:59 +0200
Subject: [PATCH net-next v15 5/9] net: dsa: lan9645x: add vlan support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20261015-dsa_lan9645x_switch_driver_base-v15-5-562f316f78b9@microchip.com>
References: <20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9@microchip.com>
In-Reply-To: <20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Eric Dumazet <edumazet@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
	<edumazet@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

Add VLAN support for VLAN-aware and VLAN-unaware bridges.

VID 4095 (HOST_PVID) is reserved and used internally as the port
VLAN for standalone (non-bridged) ports so their FDB domain is
isolated from bridged traffic.

VID 0 is used internally as the port VLAN for VLAN-unaware bridge ports
(UNAWARE_PVID).

The VLAN table and the per port VLAN configuration are serialized with
fwd_domain_lock, since .port_setup runs without rtnl held.

There are two chip limitations. Only one egress-untagged VLAN is
supported on a port that also has tagged VLANs. The rewriter can exempt
a single PORT_VID from tagging, so adding a second untagged VLAN
alongside tagged ones is rejected with -EBUSY.

Both TPIDs are recognized as VLAN tags unconditionally. There is no per
port control to classify one TPID as tagged while treating the other as
untagged customer data.

Only bridge vlan_protocol 802.1Q is offloaded. Enabling VLAN filtering
on an 802.1ad bridge is refused, which also covers joining a VLAN-aware
802.1ad bridge. DSA does not pass SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL
to drivers, so a protocol change on a bridge that is already VLAN-aware
is not seen.

The port VLAN awareness is only applied to hardware while the port is
bridged, and is otherwise only changed by .port_vlan_filtering, so it
matches the VLAN filtering state DSA has cached for the port.

S-tag and C-tag are always treated as interchangeable. Full C-component
conformance would need S-tagged frames treated as untagged by a VLAN
aware bridge, dropped on a port without a pvid and classified to the
pvid on a port with one.

Of those, only the drop is expressible, through
ANA_DROP_CFG.DROP_S_TAGGED_ENA. The reclassification needs the VCAP to
match on tag type and overwrite the classified VID, see
ocelot_update_vlan_reclassify_rule().

We program neither, since dropping without reclassifying is less
consistent than treating both tag types alike.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v15:
- Refuse VLAN filtering on bridges with vlan_protocol other than 802.1Q.
- Do not clear vlan_aware when a port leaves the bridge. Apply VLAN
  awareness only while the port is bridged, so a later join to a
  VLAN-aware bridge is configured correctly when DSA skips
  .port_vlan_filtering.

Changes in v14:
- Use TAG_NO_UNAWARE instead of TAG_ALL on ports with only tagged
  VLANs, so frames injected with classified VID 0 are not tagged.

Changes in v12:
- Serialize the VLAN table with fwd_domain_lock, and assert it in the
  lan9645x_vlan.c entry points. .port_setup runs outside rtnl, so a
  registered user port can be bridged while a later port is still being
  set up.
- Move this patch before bridge support. It now carries bridge_mask,
  fwd_domain_lock and lan9645x_port_is_bridged().
- Move lan9645x_vlan_clear_hostmode() to the bridge patch, together with
  its only caller.
- Describe the untagged VLAN limit, and why S-tag and C-tag are treated
  as interchangeable.
- Say that only bridge vlan_protocol 802.1Q is offloaded.
- lan9645x_teardown(): destroy fwd_domain_lock before the NPI port deinit,
  so teardown unwinds in reverse order of setup.
- Drop the six unused lan9645x_vlan bitfields.
- Spell VLAN in upper case in the two dev_err() strings.
- Split the extack in lan9645x_vlan_port_add_vlan(). The condition also
  fires when a tagged VLAN is added to a port with several untagged ones,
  where there is no native VLAN to report.

Changes in v8:
- Use lan9645x->num_phys_ports instead of CPU_PORT for the CPU port
  module, and reword the portmask comment.

Changes in v5:
- switch -EBUSY to -EINVAL for vlan add/del in the reserved range.
- remove reserved HSR vlan
- update commit message

Changes in v4:
- fix clear HOST_PVID vlan membership when a port joins a bridge
- explicit default value write to tag type register for untagged frames
- use lan_rmw for ANA_DROP_CFG
- add comment for error path in lan9645x_vlan_hw_wr
- use dsa_switch_for_each_user_port to iterate ports

Changes in v3:
- use SET register macros in vlan_hw_wr
- add vlan id bounds check to vlan_del
- return vlan_hw_wr timeout err on init
- move cpu vlan action after bounds check

Changes in v2:
- redesign based on selftests which rely on changing vlan_default_pvid.
  Our HW limitations were too forward. Following Vladimirs changes to
  ocelot VLAN implementation, we now dynamically change egress tag
  configuration, allowing more states.
- selftests are passing, except an expected failure w.r.t ctag/stag
  conformance, which is a hw limitation.
---
 drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  76 ++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  40 ++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |   6 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c | 402 +++++++++++++++++++++
 5 files changed, 525 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
index 7cc0ae0ada40..e049114b3563 100644
--- a/drivers/net/dsa/microchip/lan9645x/Makefile
+++ b/drivers/net/dsa/microchip/lan9645x/Makefile
@@ -6,3 +6,4 @@ mchp-lan9645x-objs := \
 	lan9645x_npi.o \
 	lan9645x_phylink.o \
 	lan9645x_port.o \
+	lan9645x_vlan.o \
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
index c7de3836e696..cddd10cfb45a 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -74,6 +74,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
 {
 	struct lan9645x *lan9645x = ds->priv;
 
+	mutex_destroy(&lan9645x->fwd_domain_lock);
 	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
 }
 
@@ -157,6 +158,11 @@ static int lan9645x_setup(struct dsa_switch *ds)
 		return err;
 	}
 
+	mutex_init(&lan9645x->fwd_domain_lock);
+	err = lan9645x_vlan_init(lan9645x);
+	if (err)
+		goto err_mutex;
+
 	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
 	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
 	       ANA_AGGR_CFG_AC_DMAC_ENA,
@@ -288,6 +294,11 @@ static int lan9645x_setup(struct dsa_switch *ds)
 		 lan9645x->num_phys_ports - lan9645x->num_port_dis);
 
 	return 0;
+
+err_mutex:
+	mutex_destroy(&lan9645x->fwd_domain_lock);
+	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
+	return err;
 }
 
 static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
@@ -296,6 +307,66 @@ static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
 	lan9645x_phylink_get_caps(ds->priv, port, config);
 }
 
+static int lan9645x_port_vlan_filtering(struct dsa_switch *ds, int port,
+					bool enabled,
+					struct netlink_ext_ack *extack)
+{
+	struct net_device *br = dsa_port_bridge_dev_get(dsa_to_port(ds, port));
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+
+	if (enabled && !lan9645x_bridge_vlan_proto_ok(br)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only 802.1Q VLAN-aware bridges are supported");
+		return -EINVAL;
+	}
+
+	/* DSA core does not call this for the CPU port */
+	p = lan9645x_to_port(lan9645x, port);
+	mutex_lock(&lan9645x->fwd_domain_lock);
+	p->vlan_aware = enabled;
+	lan9645x_vlan_port_apply(p);
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+
+	return 0;
+}
+
+static int lan9645x_port_vlan_add(struct dsa_switch *ds, int port,
+				  const struct switchdev_obj_port_vlan *vlan,
+				  struct netlink_ext_ack *extack)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+	bool pvid, untagged;
+	int err;
+
+	p = lan9645x_to_port(lan9645x, port);
+	pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
+	untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+
+	mutex_lock(&lan9645x->fwd_domain_lock);
+	err = lan9645x_vlan_port_add_vlan(p, vlan->vid, pvid, untagged, extack);
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+
+	return err;
+}
+
+static int lan9645x_port_vlan_del(struct dsa_switch *ds, int port,
+				  const struct switchdev_obj_port_vlan *vlan)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+	int err;
+
+	p = lan9645x_to_port(lan9645x, port);
+
+	mutex_lock(&lan9645x->fwd_domain_lock);
+	err = lan9645x_vlan_port_del_vlan(p, vlan->vid);
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+
+	return err;
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 
@@ -309,6 +380,11 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
 	/* MTU  */
 	.port_change_mtu		= lan9645x_change_mtu,
 	.port_max_mtu			= lan9645x_get_max_mtu,
+
+	/* VLAN integration */
+	.port_vlan_filtering		= lan9645x_port_vlan_filtering,
+	.port_vlan_add			= lan9645x_port_vlan_add,
+	.port_vlan_del			= lan9645x_port_vlan_del,
 };
 
 static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
index 3a4abedafa2c..73a91087824a 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -7,6 +7,7 @@
 
 #include <linux/dsa/lan9645x.h>
 #include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/regmap.h>
 #include <net/dsa.h>
 
@@ -171,6 +172,11 @@ enum lan9645x_vlan_port_tag {
 	LAN9645X_TAG_ALL = 3,
 };
 
+struct lan9645x_vlan {
+	u32 portmask: 10, /* ports 0-8 + CPU port module */
+	    untagged: 9; /* ports 0-8 */
+};
+
 struct lan9645x {
 	struct device *dev;
 	struct dsa_switch *ds;
@@ -182,7 +188,15 @@ struct lan9645x {
 	u8 num_phys_ports;
 	struct lan9645x_port **ports;
 
+	/* Forwarding Database */
+	u16 bridge_mask; /* Mask for bridged ports */
+	/* lock forwarding configuration and vlan table */
+	struct mutex fwd_domain_lock;
+
 	int num_port_dis;
+
+	/* VLAN entries */
+	struct lan9645x_vlan vlans[VLAN_N_VID];
 };
 
 struct lan9645x_port {
@@ -190,6 +204,9 @@ struct lan9645x_port {
 
 	u8 chip_port;
 
+	bool vlan_aware;
+	u16 pvid;
+
 	bool rx_internal_delay;
 	bool tx_internal_delay;
 };
@@ -238,6 +255,19 @@ static inline struct lan9645x_port *lan9645x_to_port(struct lan9645x *lan9645x,
 	return lan9645x->ports[port];
 }
 
+static inline bool lan9645x_port_is_bridged(struct lan9645x_port *p)
+{
+	return p->lan9645x->bridge_mask & BIT(p->chip_port);
+}
+
+static inline bool lan9645x_bridge_vlan_proto_ok(const struct net_device *br)
+{
+	u16 proto;
+
+	return !br || !br_vlan_enabled(br) || br_vlan_get_proto(br, &proto) ||
+	       proto == ETH_P_8021Q;
+}
+
 static inline struct regmap *lan_tgt2rmap(struct lan9645x *lan9645x,
 					  enum lan9645x_target t, int tinst)
 {
@@ -345,4 +375,14 @@ void lan9645x_phylink_get_caps(struct lan9645x *lan9645x, int port,
 			       struct phylink_config *c);
 void lan9645x_phylink_port_down(struct lan9645x *lan9645x, int port);
 
+/* VLAN lan9645x_vlan.c */
+int lan9645x_vlan_init(struct lan9645x *lan9645x);
+u16 lan9645x_vlan_unaware_pvid(bool is_bridged);
+void lan9645x_vlan_port_apply(struct lan9645x_port *p);
+int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
+				bool untagged,
+				struct netlink_ext_ack *extack);
+int lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid);
+void lan9645x_vlan_set_hostmode(struct lan9645x_port *p);
+
 #endif /* __LAN9645X_MAIN_H__ */
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
index 4d2d922bacba..2571380f2c02 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
@@ -162,5 +162,11 @@ int lan9645x_port_setup(struct dsa_switch *ds, int port)
 		ANA_PORT_CFG_PORTID_VAL,
 		lan9645x, ANA_PORT_CFG(p->chip_port));
 
+	if (p->chip_port != lan9645x->npi) {
+		mutex_lock(&lan9645x->fwd_domain_lock);
+		lan9645x_vlan_set_hostmode(p);
+		mutex_unlock(&lan9645x->fwd_domain_lock);
+	}
+
 	return 0;
 }
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
new file mode 100644
index 000000000000..effb0104a602
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include "lan9645x_main.h"
+
+#define VLANACCESS_CMD_IDLE		0
+#define VLANACCESS_CMD_READ		1
+#define VLANACCESS_CMD_WRITE		2
+#define VLANACCESS_CMD_INIT		3
+
+struct lan9645x_vlan_port_info {
+	int untagged;
+	int tagged;
+	u16 untagged_vid;
+};
+
+/* Calculate VLAN state of a port, across all VLANS. */
+static void lan9645x_vlan_port_get_info(struct lan9645x *lan9645x, int port,
+					struct lan9645x_vlan_port_info *info)
+{
+	u16 vid;
+
+	info->untagged = 0;
+	info->tagged = 0;
+	info->untagged_vid = 0;
+
+	for (vid = 1; vid <= VLAN_MAX; vid++) {
+		struct lan9645x_vlan *v = &lan9645x->vlans[vid];
+
+		if (!(v->portmask & BIT(port)))
+			continue;
+
+		if (v->untagged & BIT(port)) {
+			info->untagged++;
+			info->untagged_vid = vid;
+		} else {
+			info->tagged++;
+		}
+
+		/* VLAN composition is invalid, so break early. */
+		if (info->untagged > 1 && info->tagged)
+			break;
+	}
+}
+
+static int lan9645x_vlan_wait_for_completion(struct lan9645x *lan9645x)
+{
+	u32 val;
+
+	return lan9645x_rd_poll_timeout(lan9645x, ANA_VLANACCESS, val,
+					ANA_VLANACCESS_VLAN_TBL_CMD_GET(val) ==
+					VLANACCESS_CMD_IDLE);
+}
+
+static int lan9645x_vlan_hw_wr(struct lan9645x *lan9645x, u16 vid)
+{
+	struct lan9645x_vlan *v = &lan9645x->vlans[vid];
+	bool cpu_dis = !(v->portmask & BIT(lan9645x->num_phys_ports));
+	u32 val;
+	int err;
+
+	val = ANA_VLANTIDX_VLAN_PGID_CPU_DIS_SET(cpu_dis) |
+	      ANA_VLANTIDX_V_INDEX_SET(vid);
+
+	lan_wr(val, lan9645x, ANA_VLANTIDX);
+	lan_wr(ANA_VLAN_PORT_MASK_VLAN_PORT_MASK_SET(v->portmask),
+	       lan9645x, ANA_VLAN_PORT_MASK);
+	lan_wr(ANA_VLANACCESS_VLAN_TBL_CMD_SET(VLANACCESS_CMD_WRITE),
+	       lan9645x, ANA_VLANACCESS);
+
+	/* The VLAN access engine completes in a fixed ~1us vs the polling
+	 * timeout of 100_000 us. A timeout here therefore likely means the
+	 * register bus itself is dead, not that the VLAN op failed. There is no
+	 * meaningful recovery at runtime, so this function logs via dev_err()
+	 * and runtime callers discard the return value. Only
+	 * lan9645x_vlan_init() treats this as fatal so that probe fails early
+	 * on a broken bus.
+	 */
+	err = lan9645x_vlan_wait_for_completion(lan9645x);
+	if (err)
+		dev_err(lan9645x->dev, "VLAN set mask failed\n");
+
+	return err;
+}
+
+u16 lan9645x_vlan_unaware_pvid(bool is_bridged)
+{
+	return is_bridged ? UNAWARE_PVID : HOST_PVID;
+}
+
+static u16 lan9645x_vlan_port_get_pvid(struct lan9645x_port *port)
+{
+	bool is_bridged = lan9645x_port_is_bridged(port);
+
+	if (is_bridged && port->vlan_aware)
+		return port->pvid;
+	else
+		return lan9645x_vlan_unaware_pvid(is_bridged);
+}
+
+/* Dynamically choose the egress tagging mode based on the port vlan state:
+ *
+ * Standalone:
+ * TAG_NO_PVID_NO_UNAWARE with PORT_VID=HOST_PVID. This avoids leaking the
+ * internal HOST_PVID tag on ingress mirrored frames while leaving normal
+ * egress frames untagged.
+ *
+ * Bridged, VLAN-aware:
+ *  - N untagged, 0 tagged: TAG_DISABLED
+ *  - 1 untagged, N tagged: TAG_NO_PVID_NO_UNAWARE
+ *  - 0 untagged, N tagged: TAG_NO_UNAWARE
+ *
+ * Bridged, VLAN-unaware:
+ *   TAG_DISABLED
+ */
+static void
+lan9645x_vlan_port_apply_egress(struct lan9645x_port *p,
+				struct lan9645x_vlan_port_info *info)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+	enum lan9645x_vlan_port_tag tag_cfg;
+	u16 port_vid = UNAWARE_PVID;
+
+	if (!lan9645x_port_is_bridged(p)) {
+		tag_cfg = LAN9645X_TAG_NO_PVID_NO_UNAWARE;
+		port_vid = HOST_PVID;
+	} else if (p->vlan_aware) {
+		struct lan9645x_vlan_port_info _info;
+
+		if (!info) {
+			lan9645x_vlan_port_get_info(lan9645x, p->chip_port,
+						    &_info);
+			info = &_info;
+		}
+
+		if (info->untagged == 1 && info->tagged) {
+			tag_cfg = LAN9645X_TAG_NO_PVID_NO_UNAWARE;
+			port_vid = info->untagged_vid;
+		} else if (info->untagged) {
+			tag_cfg = LAN9645X_TAG_DISABLED;
+		} else {
+			tag_cfg = LAN9645X_TAG_NO_UNAWARE;
+		}
+	} else {
+		tag_cfg = LAN9645X_TAG_DISABLED;
+	}
+
+	/* TAG_TPID_CFG encoding:
+	 *
+	 * 0: Use 0x8100.
+	 * 1: Use 0x88A8.
+	 * 2: Use custom value from PORT_VLAN_CFG.PORT_TPID.
+	 * 3: Use PORT_VLAN_CFG.PORT_TPID, unless ingress tag was a C-tag
+	 *    (EtherType = 0x8100)
+	 *
+	 * Use 3 and PORT_VLAN_CFG.PORT_TPID=0x88a8 to ensure stags are not
+	 * rewritten to ctags on egress.
+	 */
+	lan_rmw(REW_TAG_CFG_TAG_TPID_CFG_SET(3) |
+		REW_TAG_CFG_TAG_CFG_SET(tag_cfg),
+		REW_TAG_CFG_TAG_TPID_CFG |
+		REW_TAG_CFG_TAG_CFG,
+		lan9645x, REW_TAG_CFG(p->chip_port));
+
+	lan_rmw(REW_PORT_VLAN_CFG_PORT_TPID_SET(ETH_P_8021AD) |
+		REW_PORT_VLAN_CFG_PORT_VID_SET(port_vid),
+		REW_PORT_VLAN_CFG_PORT_TPID |
+		REW_PORT_VLAN_CFG_PORT_VID,
+		lan9645x, REW_PORT_VLAN_CFG(p->chip_port));
+}
+
+static void lan9645x_vlan_port_apply_ingress(struct lan9645x_port *p)
+{
+	bool aware = lan9645x_port_is_bridged(p) && p->vlan_aware;
+	struct lan9645x *lan9645x = p->lan9645x;
+	u16 pvid;
+	u32 val;
+
+	pvid = lan9645x_vlan_port_get_pvid(p);
+
+	/* Default vlan to classify for untagged frames (may be zero), and set
+	 * their tag type to C-tag.
+	 */
+	val = ANA_VLAN_CFG_VLAN_VID_SET(pvid) |
+	      ANA_VLAN_CFG_VLAN_TAG_TYPE_SET(0);
+	if (aware)
+		val |= ANA_VLAN_CFG_VLAN_AWARE_ENA_SET(1) |
+		       ANA_VLAN_CFG_VLAN_POP_CNT_SET(1);
+
+	lan_rmw(val,
+		ANA_VLAN_CFG_VLAN_VID |
+		ANA_VLAN_CFG_VLAN_AWARE_ENA |
+		ANA_VLAN_CFG_VLAN_POP_CNT |
+		ANA_VLAN_CFG_VLAN_TAG_TYPE,
+		lan9645x, ANA_VLAN_CFG(p->chip_port));
+
+	val = 0;
+	if (aware && !pvid)
+		/* If port is vlan-aware and tagged, drop untagged and priority
+		 * tagged frames.
+		 */
+		val = ANA_DROP_CFG_DROP_UNTAGGED_ENA_SET(1) |
+		      ANA_DROP_CFG_DROP_PRIO_S_TAGGED_ENA_SET(1) |
+		      ANA_DROP_CFG_DROP_PRIO_C_TAGGED_ENA_SET(1);
+
+	lan_rmw(val,
+		ANA_DROP_CFG_DROP_UNTAGGED_ENA |
+		ANA_DROP_CFG_DROP_PRIO_S_TAGGED_ENA |
+		ANA_DROP_CFG_DROP_PRIO_C_TAGGED_ENA,
+		lan9645x, ANA_DROP_CFG(p->chip_port));
+}
+
+void lan9645x_vlan_port_apply(struct lan9645x_port *p)
+{
+	lockdep_assert_held(&p->lan9645x->fwd_domain_lock);
+
+	lan9645x_vlan_port_apply_ingress(p);
+	lan9645x_vlan_port_apply_egress(p, NULL);
+}
+
+static struct lan9645x_vlan *lan9645x_vlan_port_modify(struct lan9645x_port *p,
+						       u16 vid, bool pvid,
+						       bool untagged)
+{
+	struct lan9645x_vlan *v = &p->lan9645x->vlans[vid];
+
+	if (untagged)
+		v->untagged |= BIT(p->chip_port);
+	else
+		v->untagged &= ~BIT(p->chip_port);
+
+	if (pvid)
+		p->pvid = vid;
+	else if (p->pvid == vid)
+		p->pvid = 0;
+
+	return v;
+}
+
+static int lan9645x_vlan_cpu_add(struct lan9645x_port *p, u16 vid)
+{
+	struct lan9645x_vlan *v = &p->lan9645x->vlans[vid];
+
+	v->portmask |= BIT(p->lan9645x->num_phys_ports) | BIT(p->chip_port);
+	lan9645x_vlan_hw_wr(p->lan9645x, vid);
+
+	return 0;
+}
+
+int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
+				bool untagged, struct netlink_ext_ack *extack)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+	struct lan9645x_vlan_port_info info;
+	struct lan9645x_vlan old_vlan;
+	struct lan9645x_vlan *v;
+	u16 old_pvid;
+
+	lockdep_assert_held(&lan9645x->fwd_domain_lock);
+
+	/* Kernel VLAN core adds vid 0, which collides with our UNAWARE_PVID.
+	 * Hardware needs no entry for it: basic VLAN classification replaces a
+	 * VID of 0 with VLAN_CFG.VLAN_VID, keeping the frame's PCP and DEI, so
+	 * a priority tagged frame is classified to the port pvid. Ports with no
+	 * pvid instead drop it, see lan9645x_vlan_port_apply_ingress().
+	 */
+	if (!vid)
+		return 0;
+
+	if (vid > VLAN_MAX) {
+		NL_SET_ERR_MSG_MOD(extack, "VLAN 4095 reserved");
+		return -EINVAL;
+	}
+
+	if (p->chip_port == lan9645x->npi)
+		return lan9645x_vlan_cpu_add(p, vid);
+
+	old_vlan = lan9645x->vlans[vid];
+	old_pvid = p->pvid;
+
+	v = lan9645x_vlan_port_modify(p, vid, pvid, untagged);
+	v->portmask |= BIT(p->chip_port);
+
+	lan9645x_vlan_port_get_info(lan9645x, p->chip_port, &info);
+
+	if (info.untagged > 1 && info.tagged) {
+		*v = old_vlan;
+		p->pvid = old_pvid;
+		if (untagged)
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Port with egress-tagged VLANs cannot have more than one egress-untagged VLAN");
+		else
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Port with more than one egress-untagged VLAN cannot have egress-tagged VLANs");
+		return -EBUSY;
+	}
+
+	lan9645x_vlan_hw_wr(lan9645x, vid);
+	lan9645x_vlan_port_apply_ingress(p);
+	lan9645x_vlan_port_apply_egress(p, &info);
+
+	return 0;
+}
+
+static int lan9645x_vlan_cpu_del(struct lan9645x_port *p, u16 vid)
+{
+	struct lan9645x_vlan *v = &p->lan9645x->vlans[vid];
+
+	v->portmask &= ~(BIT(p->lan9645x->num_phys_ports) |
+			 BIT(p->chip_port));
+	lan9645x_vlan_hw_wr(p->lan9645x, vid);
+
+	return 0;
+}
+
+int lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+	struct lan9645x_vlan *v;
+
+	lockdep_assert_held(&lan9645x->fwd_domain_lock);
+
+	if (!vid)
+		return 0;
+
+	if (vid > VLAN_MAX)
+		return -EINVAL;
+
+	if (p->chip_port == lan9645x->npi)
+		return lan9645x_vlan_cpu_del(p, vid);
+
+	v = lan9645x_vlan_port_modify(p, vid, false, false);
+	v->portmask &= ~BIT(p->chip_port);
+	lan9645x_vlan_hw_wr(lan9645x, vid);
+	lan9645x_vlan_port_apply(p);
+
+	return 0;
+}
+
+void lan9645x_vlan_set_hostmode(struct lan9645x_port *p)
+{
+	lockdep_assert_held(&p->lan9645x->fwd_domain_lock);
+
+	p->lan9645x->vlans[HOST_PVID].portmask |= BIT(p->chip_port);
+	lan9645x_vlan_hw_wr(p->lan9645x, HOST_PVID);
+	lan9645x_vlan_port_apply(p);
+}
+
+int lan9645x_vlan_init(struct lan9645x *lan9645x)
+{
+	u32 all_phys_ports, all_ports;
+	struct dsa_port *dp;
+	u16 vid;
+	int err;
+
+	all_phys_ports = GENMASK(lan9645x->num_phys_ports - 1, 0);
+	all_ports = all_phys_ports | BIT(lan9645x->num_phys_ports);
+
+	/* Clear VLAN table, by default all ports are members of all VLANS */
+	lan_wr(ANA_VLANACCESS_VLAN_TBL_CMD_SET(VLANACCESS_CMD_INIT),
+	       lan9645x, ANA_VLANACCESS);
+
+	err = lan9645x_vlan_wait_for_completion(lan9645x);
+	if (err) {
+		dev_err(lan9645x->dev, "VLAN clear table failed\n");
+		return err;
+	}
+
+	for (vid = 1; vid < VLAN_N_VID; vid++) {
+		err = lan9645x_vlan_hw_wr(lan9645x, vid);
+		if (err)
+			return err;
+	}
+
+	/* Set all the ports + cpu to be part of HOST_PVID and UNAWARE_PVID */
+	lan9645x->vlans[HOST_PVID].portmask = all_ports;
+	err = lan9645x_vlan_hw_wr(lan9645x, HOST_PVID);
+	if (err)
+		return err;
+
+	lan9645x->vlans[UNAWARE_PVID].portmask = all_ports;
+	err = lan9645x_vlan_hw_wr(lan9645x, UNAWARE_PVID);
+	if (err)
+		return err;
+
+	/* Configure the CPU port module to be vlan aware */
+	lan_wr(ANA_VLAN_CFG_VLAN_VID_SET(UNAWARE_PVID) |
+	       ANA_VLAN_CFG_VLAN_AWARE_ENA_SET(1) |
+	       ANA_VLAN_CFG_VLAN_POP_CNT_SET(1),
+	       lan9645x, ANA_VLAN_CFG(lan9645x->num_phys_ports));
+
+	/* Set vlan ingress filter mask to all ports */
+	lan_wr(all_ports, lan9645x, ANA_VLANMASK);
+
+	dsa_switch_for_each_user_port(dp, lan9645x->ds) {
+		lan_wr(0, lan9645x, REW_PORT_VLAN_CFG(dp->index));
+		lan_wr(0, lan9645x, REW_TAG_CFG(dp->index));
+	}
+
+	return 0;
+}

-- 
2.52.0

