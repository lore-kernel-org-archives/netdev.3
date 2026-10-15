Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE34CA28C;
	Thu, 15 Oct 2026 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051604; cv=none; b=TBHQgQscGai8cbcVKpe02KlFy6m9Qav01oeONND5SZ22PBhL1VJ7xEEv8XI2jo/CnLdLNocRJxbRBVnMv2QLDrJ7GXn82g4iBEdzd9fe3KuCIkE8FvnoUy1fl0gk8Qlip6rLCQfjD608ojEg8ElwEa1suj4vTASROVXGJsVseg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051604; c=relaxed/simple;
	bh=qNCq7jPnLjxp7vav/5XpG/PX1pQNz7r8W9PH+ZbR5F0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=falLaDfM+bO6DWQFFqyAGQEJas0ouu6mk9ruGEC4XzQp7H9p9EnRtBML4GQIdc4+6gEl7wHt3IxHwZZOOs0DJgfS9uvMws1cQsMJSNhU176pVF2nVYRCD4b8cYaWphTE5QLO2g2ZuoIyf9Wyl8xpVm6sOvMUPYNXow7CBm67Ico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Bu408uLt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Bu408uLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792051607; x=1823587607;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qNCq7jPnLjxp7vav/5XpG/PX1pQNz7r8W9PH+ZbR5F0=;
  b=Bu408uLt1oIDPJ2rS7tbHHr/V2+jpW1YWuiaskThH24FxQ4yhtaEq4o7
   Hdx3k9QKoHApOGLoPF1jP8H07qrgj4y0sc4jcMr/nK3jA5mPKZCLe7NhI
   YRVhRDW3IgmHtl7r7dPxQ4z/Pceof4SIfMjpGAnV7Zfn0DL9mrCUZ7Gm4
   EimUX9W3PSQ/CoA7qprWR/2pvVaIRJCb81RO2F64bAq5S7C4Kg/Lgg4Vx
   QauVK/QBxIjgn7JTG5O93Jv0sckY2GdpqjnZIaS1uA7NtMiZfDjeiHumY
   Qu4V5hTY+Ho0cWZdOPQvqdK7JgnYaZ5zGehYVlg1bS43sjUtV6u/Pdb/B
   w==;
X-CSE-ConnectionGUID: 6EYSuM1ARY+gmDHuJiubbw==
X-CSE-MsgGUID: MJuOs6qTSYO39si6KOj+lQ==
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="296490688"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 01:06:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 15 Oct 2026 01:06:39 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 15 Oct 2026 01:06:35 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Thu, 15 Oct 2026 10:06:01 +0200
Subject: [PATCH net-next v15 7/9] net: dsa: lan9645x: add mdb management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20261015-dsa_lan9645x_switch_driver_base-v15-7-562f316f78b9@microchip.com>
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

Add support for dsa mdb callbacks. L2 multicast and IP multicast is
handled differently. IP multicast stores the port group mask inline in
the mac table. L2 multicast points at a PGID, whose destination mask is
the port group.

CPU port module membership is carried by the mac table entry's
MAC_CPU_COPY bit rather than by the PGID destination mask. This differs
from mscc/ocelot, which keeps the CPU port module bit inside the PGID
mask, and it lets groups that differ only in host membership share a
PGID.

The PGID table is finite, so it is possible to exhaust it and be unable to
service an L2 MC mdb request. The two directions then behave differently on
purpose.

On add we report the error and leave the group forwarding to the port group
it already had, so the caller learns the port was not joined and the
existing members are undisturbed.

On delete we always report success. Reporting a failure has negative
effects. The switchdev_port_obj_del_deferred() path only logs the error,
while br_switchdev_mdb_replay() abandons the remaining entries after the
first failure, so failing one delete during a bridge leave would leave
the other groups programmed. The group falls back to forwarding
according to the flood masks and host membership instead.

A group on the flood masks keeps accepting adds, from front ports and the
CPU port module alike, so that the host can still join it. The new
members also forward according to the flood masks, until an add or
delete finds a PGID for the group again.

IGMP and MLD frames are redirected to the CPU, and IPv4 multicast
control frames are copied to it, so that the bridge can snoop them.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v14:
- Keep the PGID reference when a mac table write fails while widening a
  group, so the index cannot be reused while hardware may point at it.
- Drop the reference a failed narrow write kept when the old and new
  PGID are the same.
- Keep a CPU port host entry while a host group in another DSA
  database maps to the same mac table entry. This replaces the
  dsa_mdb_present_in_other_db() check, which only covered databases
  of the same type.

Changes in v12:
- Move this patch before bridge support.
- lan9645x_teardown(): deinit the mdb before the mac table, so teardown
  unwinds in reverse order of init.
- Move the IGMP, MLD and IPMC CPU queue configuration from
  lan9645x_mdb_init() to lan9645x_setup(), next to the other CPUQ setup.
- __lan9645x_mdb_del(): do not bail out when no PGID is free. If the
  entry owns its PGID outright, narrow the port mask in place.
  Otherwise fall back to the L2 MC flood mask.
- Split lan9645x_mdb_update_dest() into lan9645x_mdb_widen_dest() for the
  add direction and lan9645x_mdb_narrow_dest() for the delete direction.
  The bridge reads the return value of a .port_mdb_add but not of a
  .port_mdb_del, so the two need opposite error handling.
- __lan9645x_mdb_add(): let a group already on the flood mask absorb
  membership changes, so the host can still join it.
- Note that IGMP and MLD are redirected to the CPU and IPv4 multicast
  control frames copied, so the bridge can snoop them.
- __lan9645x_mdb_del(): log a failing CMD_FORGET but drop the software
  entry anyway. The bridge never repeats a delete, so a kept entry
  would be wedged.
- Issue a CMD_FORGET before discarding a freshly allocated mdb entry whose
  CMD_LEARN reported an error, so a bus failure between the command and
  the status read cannot leave an unreachable entry behind in hardware.
- Use GPL-2.0+ in the SPDX identifier, matching the rest of the driver.
- Assert mdb_lock in every helper that walks the mdb or pgid lists.
- Replace the PGID_INDEX() macro with lan9645x_pgid_idx().
- Spell the mac argument as mac[ETH_ALEN] and the vid as unsigned int.
- Keep the PGID reference when a mac table write fails, both in
  lan9645x_mdb_narrow_dest() and when the CMD_FORGET fails for the last
  port leaving a group, so the index cannot be handed to an unrelated
  group while hardware may still point at it.
- lan9645x_mdb_deinit(): drain pgid_entries, which can now outlive every
  mdb entry.
- Note why the delete side reports success. One switchdev path ignores
  the error and br_switchdev_mdb_replay() truncates on it.
- Classify IPv4 multicast on the 01:00:5E prefix alone rather than with
  ether_addr_is_ipv4_mcast().
- Name the DSA ops lan9645x_port_mdb_add()/_del() after the
  .port_mdb_add hooks, rename the lan9645x_mdb.c entry points to
  lan9645x_mdb_add()/_del(), and fold the mdb_lock wrappers into them.
  The two files previously defined the same names at different levels
  of the same call chain.
- lan9645x_mdb_pgid_entry_get(): drop the unreachable !ports test, so
  a NULL return means an IP entry and nothing else.

Changes in v8:
- Use lan9645x->num_phys_ports instead of CPU_PORT for the CPU port
  module, and reword the related comments.

Changes in v7:
- refactor IGMP/MLD/IPMC_CTRL to use new LAN9645X_CPUQ_DEF,
  LAN9645X_CPUQ_TRAP and LAN9645X_CPUQ_COPY queues
- add __aligned(2) to mac variable in lan9645x_mdb_update_dest

Changes in v5:
- skip igmp/mld redir for npi port

Changes in v4:
- clean up fresh mdb when hw mac table write fails.
- avoid void return in lan9645x_offload_fwd_mark

Changes in v3:
- avoid mdb add/del dealloc when mac table writes fail
- dealloc mdb entries on deinit

Changes in v2:
- New file: selftests required implementation of the mdb callbacks.
---
 drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  74 +++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  18 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c  | 582 +++++++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |   8 +
 5 files changed, 683 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
index 70815edca5b9..2413d11fe849 100644
--- a/drivers/net/dsa/microchip/lan9645x/Makefile
+++ b/drivers/net/dsa/microchip/lan9645x/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X) += mchp-lan9645x.o
 mchp-lan9645x-objs := \
 	lan9645x_mac.o \
 	lan9645x_main.o \
+	lan9645x_mdb.o \
 	lan9645x_npi.o \
 	lan9645x_phylink.o \
 	lan9645x_port.o \
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
index 058e47e58b9a..d2e8c52e2a17 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -74,6 +74,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
 {
 	struct lan9645x *lan9645x = ds->priv;
 
+	lan9645x_mdb_deinit(lan9645x);
 	lan9645x_mac_deinit(lan9645x);
 	mutex_destroy(&lan9645x->fwd_domain_lock);
 	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
@@ -166,6 +167,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
 	err = lan9645x_mac_init(lan9645x);
 	if (err)
 		goto err_mutex;
+	lan9645x_mdb_init(lan9645x);
 
 	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
 	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
@@ -253,6 +255,17 @@ static int lan9645x_setup(struct dsa_switch *ds)
 			lan9645x, ANA_CPUQ_8021_CFG(i));
 	}
 
+	/* Use CPU queues to communicate frame classification to the CPU */
+	lan_rmw(ANA_CPUQ_CFG_CPUQ_MAC_COPY_SET(LAN9645X_CPUQ_DEF) |
+		ANA_CPUQ_CFG_CPUQ_IGMP_SET(LAN9645X_CPUQ_TRAP) |
+		ANA_CPUQ_CFG_CPUQ_MLD_SET(LAN9645X_CPUQ_TRAP) |
+		ANA_CPUQ_CFG_CPUQ_IPMC_CTRL_SET(LAN9645X_CPUQ_COPY),
+		ANA_CPUQ_CFG_CPUQ_MAC_COPY |
+		ANA_CPUQ_CFG_CPUQ_IGMP |
+		ANA_CPUQ_CFG_CPUQ_MLD |
+		ANA_CPUQ_CFG_CPUQ_IPMC_CTRL,
+		lan9645x, ANA_CPUQ_CFG);
+
 	/* Reserve 1664 bytes, 26 buffer cells, per (port, prio) for source
 	 * tracking (resource 0, indices 0..95) and destination tracking
 	 * (resource 2, indices 512..607). These are access watermarks, not
@@ -484,6 +497,63 @@ static int lan9645x_fdb_del(struct dsa_switch *ds, int port,
 				    ENTRYTYPE_LOCKED);
 }
 
+static int lan9645x_port_mdb_add(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_mdb *mdb,
+				 struct dsa_db db)
+{
+	struct net_device *bridge_dev = lan9645x_db2bridge(db);
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct lan9645x *lan9645x = ds->priv;
+
+	dev_dbg(lan9645x->dev, "port=%d addr=%pM vid=%u\n", port, mdb->addr,
+		mdb->vid);
+
+	if (IS_ERR(bridge_dev))
+		return PTR_ERR(bridge_dev);
+
+	if (dsa_port_is_cpu(dp) &&
+	    lan9645x_host_addr_shared(dp, &dp->mdbs, mdb->addr, mdb->vid, &db))
+		return 0;
+
+	if (port == lan9645x->npi)
+		port = lan9645x->num_phys_ports;
+
+	return lan9645x_mdb_add(lan9645x, port, mdb, bridge_dev);
+}
+
+static int lan9645x_port_mdb_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_mdb *mdb,
+				 struct dsa_db db)
+{
+	struct net_device *bridge_dev = lan9645x_db2bridge(db);
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct lan9645x *lan9645x = ds->priv;
+	int err;
+
+	dev_dbg(lan9645x->dev, "port=%d addr=%pM vid=%u\n", port, mdb->addr,
+		mdb->vid);
+
+	if (IS_ERR(bridge_dev))
+		return PTR_ERR(bridge_dev);
+
+	if (dsa_port_is_cpu(dp) &&
+	    lan9645x_host_addr_shared(dp, &dp->mdbs, mdb->addr, mdb->vid, &db))
+		return 0;
+
+	if (port == lan9645x->npi)
+		port = lan9645x->num_phys_ports;
+
+	err = lan9645x_mdb_del(lan9645x, port, mdb, bridge_dev);
+	if (err == -ENOENT) {
+		dev_dbg(lan9645x->dev,
+			"mdb not found port=%d addr=%pM vid=%u\n", port,
+			mdb->addr, mdb->vid);
+		return 0;
+	}
+
+	return err;
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 
@@ -508,6 +578,10 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.port_fdb_dump			= lan9645x_fdb_dump,
 	.port_fdb_add			= lan9645x_fdb_add,
 	.port_fdb_del			= lan9645x_fdb_del,
+
+	/* Multicast database */
+	.port_mdb_add			= lan9645x_port_mdb_add,
+	.port_mdb_del			= lan9645x_port_mdb_del,
 };
 
 static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
index e442c222e360..fb097119588b 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -207,6 +207,14 @@ struct lan9645x {
 	struct mutex fwd_domain_lock;
 	struct mutex mact_lock; /* serialize mac table register access */
 
+	/* Multicast Forwarding Database */
+	struct list_head mdb_entries;
+	struct list_head pgid_entries;
+	/* lock for mdb_entries and pgid_entries. Must be taken before mact_lock
+	 * if both are taken.
+	 */
+	struct mutex mdb_lock;
+
 	int num_port_dis;
 
 	/* VLAN entries */
@@ -412,4 +420,14 @@ void lan9645x_mac_deinit(struct lan9645x *lan9645x);
 int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
 			   dsa_fdb_dump_cb_t *cb, void *data);
 
+/* Multicast Database lan9645x_mdb.c */
+int lan9645x_mdb_add(struct lan9645x *lan9645x, int port,
+		     const struct switchdev_obj_port_mdb *mdb,
+		     struct net_device *bridge);
+int lan9645x_mdb_del(struct lan9645x *lan9645x, int port,
+		     const struct switchdev_obj_port_mdb *mdb,
+		     struct net_device *bridge);
+void lan9645x_mdb_init(struct lan9645x *lan9645x);
+void lan9645x_mdb_deinit(struct lan9645x *lan9645x);
+
 #endif /* __LAN9645X_MAIN_H__ */
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
new file mode 100644
index 000000000000..ca333d43904f
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
@@ -0,0 +1,582 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include "lan9645x_main.h"
+
+/* IPv4/IPv6 types the mac entry dest_idx is not used for forwarding. The
+ * datasheet recommends using 0 as the dummy index.
+ */
+#define IP_ENTRY_PGID		0
+
+struct lan9645x_pgid_entry {
+	struct list_head list;
+	int index;
+	refcount_t refcount;
+	u16 ports;
+};
+
+struct lan9645x_mdb_entry {
+	struct list_head list;
+	unsigned char mac[ETH_ALEN];
+	u16 vid;
+	u16 ports;
+	struct lan9645x_pgid_entry *pgid;
+};
+
+static int lan9645x_pgid_idx(const struct lan9645x_pgid_entry *pgid)
+{
+	return pgid ? pgid->index : IP_ENTRY_PGID;
+}
+
+void lan9645x_mdb_init(struct lan9645x *lan9645x)
+{
+	INIT_LIST_HEAD(&lan9645x->mdb_entries);
+	INIT_LIST_HEAD(&lan9645x->pgid_entries);
+	mutex_init(&lan9645x->mdb_lock);
+}
+
+static enum macaccess_entry_type lan9645x_mdb_classify(const unsigned char *mac)
+{
+	if (mac[0] == 0x01 && mac[1] == 0x00 && mac[2] == 0x5e)
+		return ENTRYTYPE_MACV4;
+	if (mac[0] == 0x33 && mac[1] == 0x33)
+		return ENTRYTYPE_MACV6;
+	return ENTRYTYPE_LOCKED;
+}
+
+static struct lan9645x_mdb_entry *
+lan9645x_mdb_entry_lookup(struct lan9645x *lan9645x, const unsigned char *mac,
+			  u16 vid)
+{
+	struct lan9645x_mdb_entry *mdb;
+
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	list_for_each_entry(mdb, &lan9645x->mdb_entries, list) {
+		if (ether_addr_equal(mdb->mac, mac) && mdb->vid == vid)
+			return mdb;
+	}
+
+	return NULL;
+}
+
+static struct lan9645x_mdb_entry *
+lan9645x_mdb_entry_alloc(struct lan9645x *lan9645x,
+			 const unsigned char addr[ETH_ALEN], u16 vid)
+{
+	struct lan9645x_mdb_entry *mdb_entry;
+
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	mdb_entry = kzalloc_obj(*mdb_entry);
+	if (!mdb_entry)
+		return ERR_PTR(-ENOMEM);
+
+	ether_addr_copy(mdb_entry->mac, addr);
+	mdb_entry->vid = vid;
+
+	list_add_tail(&mdb_entry->list, &lan9645x->mdb_entries);
+
+	dev_dbg(lan9645x->dev, "vid=%u addr=%pM\n", mdb_entry->vid,
+		mdb_entry->mac);
+
+	return mdb_entry;
+}
+
+static void lan9645x_mdb_encode_mac(unsigned char *dst,
+				    const unsigned char *mac, u16 ports,
+				    enum macaccess_entry_type type)
+{
+	ether_addr_copy(dst, mac);
+
+	/* The HW encodes the portmask in the high bits of the mac for ip
+	 * multicast entries, to save on the limited PGID resources.
+	 *
+	 * IPv4 Multicast DMAC: 0x01005Exxxxxx
+	 * IPv6 Multicast DMAC: 0x3333xxxxxxxx
+	 *
+	 * which gives us 24 or 16 bits to encode the portmask.
+	 */
+	if (type == ENTRYTYPE_MACV4) {
+		dst[0] = 0;
+		dst[1] = ports >> 8;
+		dst[2] = ports & 0xff;
+	} else if (type == ENTRYTYPE_MACV6) {
+		dst[0] = ports >> 8;
+		dst[1] = ports & 0xff;
+	}
+}
+
+static void lan9645x_pgid_entry_put(struct lan9645x *lan9645x,
+				    struct lan9645x_pgid_entry *pgid_entry)
+{
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	if (!pgid_entry)
+		return;
+
+	if (!refcount_dec_and_test(&pgid_entry->refcount))
+		return;
+
+	dev_dbg(lan9645x->dev, "pgid=%d ports=0x%x\n", pgid_entry->index,
+		pgid_entry->ports);
+	/* Leave the destination mask programmed in HW. Reusing the index
+	 * rewrites the mask in lan9645x_pgid_entry_alloc() before anything
+	 * points at it.
+	 */
+	list_del(&pgid_entry->list);
+	kfree(pgid_entry);
+}
+
+static void lan9645x_mdb_entry_dealloc(struct lan9645x *lan9645x,
+				       struct lan9645x_mdb_entry *mdb_entry)
+{
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	dev_dbg(lan9645x->dev, "vid=%u addr=%pM\n", mdb_entry->vid,
+		mdb_entry->mac);
+	list_del(&mdb_entry->list);
+	lan9645x_pgid_entry_put(lan9645x, mdb_entry->pgid);
+	kfree(mdb_entry);
+}
+
+static struct lan9645x_pgid_entry *
+lan9645x_mdb_pgid_entry_lookup(struct lan9645x *lan9645x, u16 ports)
+{
+	struct lan9645x_pgid_entry *pgid_entry;
+
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	list_for_each_entry(pgid_entry, &lan9645x->pgid_entries, list) {
+		if (pgid_entry->ports == ports) {
+			refcount_inc(&pgid_entry->refcount);
+			return pgid_entry;
+		}
+	}
+
+	return NULL;
+}
+
+static struct lan9645x_pgid_entry *
+lan9645x_pgid_entry_alloc(struct lan9645x *lan9645x, int index, u16 ports)
+{
+	struct lan9645x_pgid_entry *pgid_entry;
+
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	pgid_entry = kzalloc_obj(*pgid_entry);
+	if (!pgid_entry)
+		return ERR_PTR(-ENOMEM);
+
+	pgid_entry->ports = ports;
+	pgid_entry->index = index;
+	refcount_set(&pgid_entry->refcount, 1);
+
+	list_add_tail(&pgid_entry->list, &lan9645x->pgid_entries);
+
+	dev_dbg(lan9645x->dev, "index=%d ports=0x%x\n", pgid_entry->index,
+		pgid_entry->ports);
+
+	lan_rmw(ANA_PGID_PGID_SET(pgid_entry->ports),
+		ANA_PGID_PGID, lan9645x,
+		ANA_PGID(pgid_entry->index));
+
+	return pgid_entry;
+}
+
+static struct lan9645x_pgid_entry *
+lan9645x_mdb_pgid_entry_create(struct lan9645x *lan9645x, u16 ports)
+{
+	struct lan9645x_pgid_entry *pgid_entry;
+	int index;
+
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	for (index = PGID_GP_START; index < PGID_GP_END; index++) {
+		bool used = false;
+
+		list_for_each_entry(pgid_entry, &lan9645x->pgid_entries, list) {
+			if (pgid_entry->index == index) {
+				used = true;
+				break;
+			}
+		}
+
+		if (!used)
+			return lan9645x_pgid_entry_alloc(lan9645x, index,
+							 ports);
+	}
+
+	return ERR_PTR(-ENOSPC);
+}
+
+static struct lan9645x_pgid_entry *
+lan9645x_mdb_pgid_entry_get(struct lan9645x *lan9645x, u16 ports,
+			    enum macaccess_entry_type type)
+{
+	struct lan9645x_pgid_entry *pgid_entry;
+	u16 pgid_ports;
+
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	if (type == ENTRYTYPE_MACV4 || type == ENTRYTYPE_MACV6)
+		return NULL;
+
+	/* CPU port module forwarding is handled by cpu_copy flag on mac table
+	 * entry. So we can strip the CPU port module here to allow better PGID
+	 * sharing.
+	 */
+	pgid_ports = ports & ~BIT(lan9645x->num_phys_ports);
+
+	pgid_entry = lan9645x_mdb_pgid_entry_lookup(lan9645x, pgid_ports);
+	if (!pgid_entry)
+		return lan9645x_mdb_pgid_entry_create(lan9645x, pgid_ports);
+
+	return pgid_entry;
+}
+
+/* An L2 MC group without a pgid is one that fell back to the flood mask in
+ * __lan9645x_mdb_del().
+ */
+static bool
+lan9645x_mdb_on_flood_mask(const struct lan9645x_mdb_entry *mdb_entry,
+			   enum macaccess_entry_type type)
+{
+	return type == ENTRYTYPE_LOCKED && mdb_entry->ports && !mdb_entry->pgid;
+}
+
+/* Point the hardware mac table entry at pgid_index with the port mask
+ * new_ports. Does not touch mdb_entry, the caller owns the software state.
+ */
+static int lan9645x_mdb_write_dest(struct lan9645x *lan9645x,
+				   struct lan9645x_mdb_entry *mdb_entry,
+				   enum macaccess_entry_type type,
+				   int pgid_index, u16 new_ports)
+{
+	unsigned char mac[ETH_ALEN] __aligned(2);
+	bool cpu_copy;
+
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	lan9645x_mdb_encode_mac(mac, mdb_entry->mac, new_ports, type);
+	cpu_copy = !!(new_ports & BIT(lan9645x->num_phys_ports));
+
+	/* For IP multicast, the hardware lookup uses the DMAC
+	 * (01:00:5E:.. / 33:33:..) as the (mac, vid) key, not the encoded mac.
+	 * Therefore, this CMD_LEARN will atomically rewrite the existing
+	 * hardware entry. We intentionally do not do a forget before learn
+	 * sequence, as that would not be atomic, and leave a forwarding gap.
+	 */
+	return lan9645x_mact_learn(lan9645x, pgid_index, mac, mdb_entry->vid,
+				   type, cpu_copy);
+}
+
+/* Grow the group. A port can be refused membership, and the bridge reads the
+ * return value of a SWITCHDEV_PORT_OBJ_ADD, so a failure must leave the
+ * software entry exactly as it was.
+ */
+static int lan9645x_mdb_widen_dest(struct lan9645x *lan9645x,
+				   struct lan9645x_mdb_entry *mdb_entry,
+				   enum macaccess_entry_type type,
+				   struct lan9645x_pgid_entry *new_pgid,
+				   int pgid_index, u16 new_ports)
+{
+	struct lan9645x_pgid_entry *old_pgid = mdb_entry->pgid;
+	int err;
+
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	err = lan9645x_mdb_write_dest(lan9645x, mdb_entry, type, pgid_index,
+				      new_ports);
+	if (err) {
+		dev_err(lan9645x->dev,
+			"Widening %pM vid %u to mask 0x%x returned %pe\n",
+			mdb_entry->mac, mdb_entry->vid, new_ports,
+			ERR_PTR(err));
+		/* A failed write leaves the hardware state unknown, the mac
+		 * entry may point at old_pgid or new_pgid. Keep the reference
+		 * taken on new_pgid, so its index cannot be handed to an
+		 * unrelated group. If the entry already holds new_pgid, e.g.
+		 * when the CPU port module joins, drop the extra reference.
+		 */
+		if (new_pgid == old_pgid)
+			lan9645x_pgid_entry_put(lan9645x, new_pgid);
+		return err;
+	}
+	mdb_entry->pgid = new_pgid;
+	mdb_entry->ports = new_ports;
+	lan9645x_pgid_entry_put(lan9645x, old_pgid);
+	return 0;
+}
+
+/* Shrink the group. A port cannot be refused leaving, and reporting a failure
+ * is worse than useless. One del path ignores the error:
+ * switchdev_port_obj_del_deferred() only logs it, and unlike RTM_NEWMDB the
+ * RTM_DELMDB path installs no obj.complete. The other truncates on it:
+ * br_switchdev_mdb_replay() abandons the remaining entries after the first
+ * failure, so failing one delete during a bridge leave would leave the other
+ * groups programmed. The bridge has already dropped the group by the time we
+ * run, so it will never ask again.
+ *
+ * Commit the software state first, then program hardware and only log a
+ * failure. That keeps both invariants the rest of this file relies on:
+ *
+ *   mdb_entry->ports stays a subset of the bridge's view of the group, so a
+ *   later delete can still drive it to zero and reclaim the entry, and
+ *
+ *   mdb_entry->pgid->ports stays equal to
+ *   mdb_entry->ports & ~BIT(num_phys_ports), which is what lets
+ *   __lan9645x_mdb_del() conclude that a departing port reaching the
+ *   overwrite in place branch cannot be the CPU port module.
+ */
+static void lan9645x_mdb_narrow_dest(struct lan9645x *lan9645x,
+				     struct lan9645x_mdb_entry *mdb_entry,
+				     enum macaccess_entry_type type,
+				     struct lan9645x_pgid_entry *new_pgid,
+				     int pgid_index, u16 new_ports)
+{
+	struct lan9645x_pgid_entry *old_pgid = mdb_entry->pgid;
+	int err;
+
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	mdb_entry->pgid = new_pgid;
+	mdb_entry->ports = new_ports;
+
+	err = lan9645x_mdb_write_dest(lan9645x, mdb_entry, type, pgid_index,
+				      new_ports);
+	if (err) {
+		dev_err(lan9645x->dev,
+			"Narrowing %pM vid %u to mask 0x%x returned %pe\n",
+			mdb_entry->mac, mdb_entry->vid, new_ports,
+			ERR_PTR(err));
+		if (old_pgid != new_pgid)
+			return;
+	}
+
+	lan9645x_pgid_entry_put(lan9645x, old_pgid);
+}
+
+static int __lan9645x_mdb_add(struct lan9645x *lan9645x, int chip_port,
+			      const unsigned char addr[ETH_ALEN], u16 vid,
+			      enum macaccess_entry_type type)
+{
+	struct lan9645x_pgid_entry *new_pgid;
+	struct lan9645x_mdb_entry *mdb_entry;
+	u16 new_ports;
+	int err;
+
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	mdb_entry = lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
+	if (!mdb_entry) {
+		mdb_entry = lan9645x_mdb_entry_alloc(lan9645x, addr, vid);
+		if (IS_ERR(mdb_entry))
+			return PTR_ERR(mdb_entry);
+	}
+
+	if (mdb_entry->ports & BIT(chip_port))
+		return 0;
+
+	new_ports = mdb_entry->ports | BIT(chip_port);
+
+	/* Update PGID ptr for non-IP entries (L2 multicast) */
+	new_pgid = lan9645x_mdb_pgid_entry_get(lan9645x, new_ports, type);
+	if (IS_ERR(new_pgid)) {
+		/* Out of PGIDs or mem. Remove a fresh mdb_entry again. */
+		if (!mdb_entry->ports) {
+			lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
+			return PTR_ERR(new_pgid);
+		}
+
+		/* For a L2 MC group already on the flood mask, we keep it there
+		 * so that the host can still join/leave a group we had to give
+		 * up offloading. A front port that joins forwards according to
+		 * the flood masks, like the other members.
+		 */
+		if (lan9645x_mdb_on_flood_mask(mdb_entry, type))
+			return lan9645x_mdb_widen_dest(lan9645x, mdb_entry,
+						       type, NULL, PGID_MC,
+						       new_ports);
+
+		/* Continue forwarding to old port group. */
+		return PTR_ERR(new_pgid);
+	}
+
+	err = lan9645x_mdb_widen_dest(lan9645x, mdb_entry, type, new_pgid,
+				      lan9645x_pgid_idx(new_pgid), new_ports);
+	if (err && !mdb_entry->ports) {
+		/* We are about to drop a fresh entry, so make sure the hardware
+		 * does not keep one we can no longer reach. The mac commands
+		 * complete in a few microseconds, so the only way to get here
+		 * with an entry actually written is for the register bus to
+		 * fail between the command and the status read. That is close
+		 * to impossible, but the forget costs nothing: it is a noop if
+		 * the entry was never written.
+		 */
+		if (!lan9645x_mact_forget(lan9645x, mdb_entry->mac,
+					  mdb_entry->vid, type))
+			lan9645x_pgid_entry_put(lan9645x, new_pgid);
+		lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
+	}
+
+	return err;
+}
+
+static int __lan9645x_mdb_del(struct lan9645x *lan9645x, int chip_port,
+			      const unsigned char addr[ETH_ALEN], u16 vid,
+			      enum macaccess_entry_type type)
+{
+	struct lan9645x_pgid_entry *new_pgid;
+	struct lan9645x_mdb_entry *mdb_entry;
+	u16 new_ports;
+	int err;
+
+	lockdep_assert_held(&lan9645x->mdb_lock);
+
+	mdb_entry = lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
+	if (!mdb_entry)
+		return -ENOENT;
+
+	if (!(mdb_entry->ports & BIT(chip_port)))
+		return 0;
+
+	new_ports = mdb_entry->ports & ~BIT(chip_port);
+
+	if (!new_ports) {
+		/* The encoded bytes are not part of the (mac, vid) key used for
+		 * lookups in the mactable, for entries of type 2
+		 * (IPv4 Multicast) and type 3 (IPv6 Multicast). For these types
+		 * the mac used in the key is the 'real' mac e.g.
+		 *
+		 * Type 2 (IPv4 multicast):
+		 * KEY_MAC = 0x01005E000000 | MACLDATA[23:0]
+		 *
+		 * Type 3 (IPv6 multicast):
+		 * KEY_MAC = 0x333300000000 | MACLDATA[31:0]
+		 *
+		 * This holds for both the datapath and the CPU access path.
+		 * Therefore, it is not necessary to encode the mac before a
+		 * CMD_FORGET, because the bytes it changes are unused for the
+		 * lookup.
+		 */
+		err = lan9645x_mact_forget(lan9645x, mdb_entry->mac,
+					   mdb_entry->vid, type);
+		if (err) {
+			dev_err(lan9645x->dev,
+				"Forgetting %pM vid %u on port %d returned %pe\n",
+				mdb_entry->mac, mdb_entry->vid, chip_port,
+				ERR_PTR(err));
+			mdb_entry->pgid = NULL;
+		}
+		lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
+		return 0;
+	}
+
+	/* Update PGID ptr for non-IP entries (L2 multicast) */
+	new_pgid = lan9645x_mdb_pgid_entry_get(lan9645x, new_ports, type);
+	if (!IS_ERR(new_pgid)) {
+		lan9645x_mdb_narrow_dest(lan9645x, mdb_entry, type, new_pgid,
+					 lan9645x_pgid_idx(new_pgid),
+					 new_ports);
+		return 0;
+	}
+
+	/* Out of pgids for L2 MC.
+	 *
+	 * PGID is not shared, so we overwrite in place.
+	 *
+	 * We know the deleted port is not the CPU. Getting here means
+	 * lan9645x_mdb_pgid_entry_get() found no PGID holding the narrowed
+	 * mask, and for a delete of only the CPU port module bit the mask it
+	 * looks up is unchanged, since lan9645x_mdb_pgid_entry_get() strips
+	 * that bit. lan9645x_mdb_pgid_entry_lookup() would have returned the
+	 * PGID this entry already points at. So the departing port is a front
+	 * port, and the mac table entry, which only carries the PGID index and
+	 * MAC_CPU_COPY, does not need rewriting.
+	 *
+	 * refcount_read is safe because mdb_lock serializes every get and put
+	 * of a PGID entry.
+	 */
+	if (mdb_entry->pgid && refcount_read(&mdb_entry->pgid->refcount) == 1) {
+		mdb_entry->pgid->ports = new_ports &
+					 ~BIT(lan9645x->num_phys_ports);
+		mdb_entry->ports = new_ports;
+
+		lan_rmw(ANA_PGID_PGID_SET(mdb_entry->pgid->ports),
+			ANA_PGID_PGID,
+			lan9645x, ANA_PGID(mdb_entry->pgid->index));
+
+		return 0;
+	}
+
+	/* Shared PGID or on flood mask. Point the entry at the L2 MC flood mask
+	 * instead. This way our mac table entry survives and MAC_CPU_COPY
+	 * keeps host membership working.
+	 */
+	if (mdb_entry->pgid)
+		dev_warn_ratelimited(lan9645x->dev,
+				     "No PGID, flooding group %pM vid %u: %pe\n",
+				     mdb_entry->mac, mdb_entry->vid, new_pgid);
+
+	lan9645x_mdb_narrow_dest(lan9645x, mdb_entry, type, NULL, PGID_MC,
+				 new_ports);
+	return 0;
+}
+
+int lan9645x_mdb_add(struct lan9645x *lan9645x, int port,
+		     const struct switchdev_obj_port_mdb *mdb,
+		     struct net_device *bridge)
+{
+	enum macaccess_entry_type type;
+	u16 vid = mdb->vid;
+	int err;
+
+	type = lan9645x_mdb_classify(mdb->addr);
+
+	if (!vid)
+		vid = lan9645x_vlan_unaware_pvid(!!bridge);
+
+	mutex_lock(&lan9645x->mdb_lock);
+	err = __lan9645x_mdb_add(lan9645x, port, mdb->addr, vid, type);
+	mutex_unlock(&lan9645x->mdb_lock);
+	return err;
+}
+
+int lan9645x_mdb_del(struct lan9645x *lan9645x, int port,
+		     const struct switchdev_obj_port_mdb *mdb,
+		     struct net_device *bridge)
+{
+	enum macaccess_entry_type type;
+	u16 vid = mdb->vid;
+	int err;
+
+	type = lan9645x_mdb_classify(mdb->addr);
+
+	if (!vid)
+		vid = lan9645x_vlan_unaware_pvid(!!bridge);
+
+	mutex_lock(&lan9645x->mdb_lock);
+	err = __lan9645x_mdb_del(lan9645x, port, mdb->addr, vid, type);
+	mutex_unlock(&lan9645x->mdb_lock);
+	return err;
+}
+
+void lan9645x_mdb_deinit(struct lan9645x *lan9645x)
+{
+	struct lan9645x_pgid_entry *pgid, *pgid_tmp;
+	struct lan9645x_mdb_entry *mdb, *tmp;
+
+	mutex_lock(&lan9645x->mdb_lock);
+	list_for_each_entry_safe(mdb, tmp, &lan9645x->mdb_entries, list)
+		lan9645x_mdb_entry_dealloc(lan9645x, mdb);
+
+	list_for_each_entry_safe(pgid, pgid_tmp, &lan9645x->pgid_entries, list) {
+		list_del(&pgid->list);
+		kfree(pgid);
+	}
+	mutex_unlock(&lan9645x->mdb_lock);
+
+	mutex_destroy(&lan9645x->mdb_lock);
+}
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
index 2571380f2c02..edcedd7723c9 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
@@ -166,6 +166,14 @@ int lan9645x_port_setup(struct dsa_switch *ds, int port)
 		mutex_lock(&lan9645x->fwd_domain_lock);
 		lan9645x_vlan_set_hostmode(p);
 		mutex_unlock(&lan9645x->fwd_domain_lock);
+
+		lan_rmw(ANA_CPU_FWD_CFG_IGMP_REDIR_ENA_SET(1) |
+			ANA_CPU_FWD_CFG_MLD_REDIR_ENA_SET(1) |
+			ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA_SET(1),
+			ANA_CPU_FWD_CFG_IGMP_REDIR_ENA |
+			ANA_CPU_FWD_CFG_MLD_REDIR_ENA |
+			ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA,
+			lan9645x, ANA_CPU_FWD_CFG(p->chip_port));
 	}
 
 	return 0;

-- 
2.52.0

