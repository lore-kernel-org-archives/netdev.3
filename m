Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5F4C9DEA;
	Thu, 15 Oct 2026 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051599; cv=none; b=BrGWdBMN/+lK+geFcyzZA/NaFLDtZtRRu7ZiMKhVPUi5Uma5GWSQDpjsyvxUDM1AxGMxd/WSDVQx43TT04vNZQR8TyF/qA5Q6w8FkCTI9LB7ZiAhtE45HYCngJTr3hcjgAn9m6myQq0YtaIIsZWWL+wUzrPd3TvMnYOe1lgFFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051599; c=relaxed/simple;
	bh=NJigHk5NSg6ZnOUxJ8yEMtPkGK1f0o5Tk28ZNzyezUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JXzQKYo+x8ma2rCFF8r3NhSUvvErZyBSfrj3QC4effuwVh7t4pFsWrItsk98svgtaAASHyZzCajBCm4jB2DAvYHJ1H/ar55D2MQir9YE7Ct3PlIBNZOmOQvti6pJl3OAr96dSJIEwVR5gSLmrmAqPiwePeGV5+NpsDDhUd9T7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TssAG3AG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TssAG3AG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792051596; x=1823587596;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NJigHk5NSg6ZnOUxJ8yEMtPkGK1f0o5Tk28ZNzyezUA=;
  b=TssAG3AGZooQao+gVkm1C0FH7AlaPIVSbQrkHa2sDGSvfJyXpM1ibHC7
   rdAWUuZHPodhCDbDxu8xoFTq7c80dy5rfHGAo44aSLYpdGBXsCFjd/7FR
   dJtE2hOlIuOgWQ5xpJiK6ohe8f+0CqtXlv4FiBEg8JnCtK1LrknjzSGQL
   4kfMBKUsF3UsSMfbVXE30eD84Zpjmcr2dxx0D4kGi2kQboZKKXzZ/9fzY
   4WViTgVpepv19GR8kwO5MK00cTzClIAI3ODEoHQBMg+DiIYoDCUKSJox8
   vb1DlkELwBq9vK27rU+ys2FBdDDy6EfjS4dmuMIO3sL2V9CAFhTtvBC8T
   g==;
X-CSE-ConnectionGUID: hJlYUvSXRkeFgIU9elURlA==
X-CSE-MsgGUID: l4Zm8dOVRwKGXGiUaMtf3Q==
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="75465740"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2026 01:06:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 15 Oct 2026 01:06:34 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 15 Oct 2026 01:06:30 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Thu, 15 Oct 2026 10:06:00 +0200
Subject: [PATCH net-next v15 6/9] net: dsa: lan9645x: add mac table
 integration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20261015-dsa_lan9645x_switch_driver_base-v15-6-562f316f78b9@microchip.com>
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

Add MAC table support, and dsa fdb callback integration. The mactable is
keyed on (vid,mac) and each row has 4 buckets. A mac table entry
typically points to a PGID index, the first 9 of which represent a front
port.

Mac table entries for L2 multicast will use a PGID containing a group
port mask. For IP multicast entries in the mac table a trick is used,
where the group port mask is packed into the MAC data, exploiting the
fact that the top bits are fixed, and that the number of switch ports is
small enough to fit in the redundant bits.

Therefore, we can avoid using sparse PGID resources for IP multicast
entries in the mac table.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v14:
- Only forget a CPU port host entry when no other database still uses
  the same MAC table key, including databases of a different type.

Changes in v12:
- Log a failure from lan9645x_mact_flush() in port_fast_age(), which
  returns void and cannot propagate it.
- Fix a comment to name PGID_CPU rather than the CPU port module.
- Move this patch before bridge support, so .port_fast_age exists when
  port_stp_state_set() is introduced.
- Give lan9645x_mact_learn() a cpu_copy argument, and drop
  lan9645x_mac_ports_use_cpu() and the wrapper that used it to derive
  the flag from the encoded mac. The helper could only return false,
  since its one caller passes ENTRYTYPE_LOCKED, and the mdb path needs
  the flag passed in rather than derived.
- Bound the CMD_GET_NEXT walk in lan9645x_mact_dsa_dump() at the mac table
  size plus one, derived from ANA_MACTINDX. Log and return -EIO on overrun.
- lan9645x_mact_dsa_dump(): leave automatic ageing enabled during the
  GET_NEXT walk, as it does not disturb the walk, and toggling ageing
  resets the timer.
- lan9645x_teardown(): deinit the mac table before fwd_domain_lock.
- Spell the mac argument as mac[ETH_ALEN] and the vid as unsigned int.

Changes in v8:
- Pass lan9645x into lan9645x_mac_ports_use_cpu() and reference the CPU
  port module as lan9645x->num_phys_ports instead of CPU_PORT.

Changes in v5:
- lan9645x_mac_init returns error on table init timeout
- add comment about skipping LOCKED entries on fdb dump

Changes in v4:
- remove mac_entries list and just do direct IO to mac table from
  fdb_add/fdb_del

Changes in v3:
- avoid mac add/del dealloc when mac table writes fail
- add mact_lock to change ageing time
- dealloc all mac_entries on deinit
- dsa_dump returns mac table timeout error

Changes in v2:
- use a single lock for hw and sw
- remove unused row struct field and define
- remove list element INIT_LIST_HEAD
- consistent use of err vs ret
- remove mutex_lock in init
- use empty initializer { 0 } -> {}
- do not move fwd_domain_lock init to this unit
- add newline to dev_* log statements
---
 drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c  | 268 +++++++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 123 ++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  27 +++
 4 files changed, 419 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
index e049114b3563..70815edca5b9 100644
--- a/drivers/net/dsa/microchip/lan9645x/Makefile
+++ b/drivers/net/dsa/microchip/lan9645x/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X) += mchp-lan9645x.o
 
 mchp-lan9645x-objs := \
+	lan9645x_mac.o \
 	lan9645x_main.o \
 	lan9645x_npi.o \
 	lan9645x_phylink.o \
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
new file mode 100644
index 000000000000..50ce1378b9da
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include "lan9645x_main.h"
+
+#define CMD_IDLE		0
+#define CMD_LEARN		1
+#define CMD_FORGET		2
+#define CMD_AGE			3
+#define CMD_GET_NEXT		4
+#define CMD_INIT		5
+#define CMD_READ		6
+#define CMD_WRITE		7
+#define CMD_SYNC_GET_NEXT	8
+
+/* The chip has 2048 * 4 = 8192 total entries in the mac table */
+#define MACT_ROWS		(FIELD_MAX(ANA_MACTINDX_M_INDEX) + 1)
+#define MACT_BUCKETS		(FIELD_MAX(ANA_MACTINDX_BUCKET) + 1)
+#define MACT_ENTRIES		(MACT_ROWS * MACT_BUCKETS)
+#define MACT_GET_NEXT_MAX	(MACT_ENTRIES + 1)
+
+static int lan9645x_mac_wait_for_completion(struct lan9645x *lan9645x,
+					    u32 *maca)
+{
+	u32 val = 0;
+	int err;
+
+	lockdep_assert_held(&lan9645x->mact_lock);
+
+	err = lan9645x_rd_poll_timeout(lan9645x, ANA_MACACCESS, val,
+				       ANA_MACACCESS_MAC_TABLE_CMD_GET(val) ==
+				       CMD_IDLE);
+	if (err)
+		return err;
+
+	if (maca)
+		*maca = val;
+
+	return 0;
+}
+
+static void lan9645x_mac_select(struct lan9645x *lan9645x,
+				const unsigned char mac[ETH_ALEN],
+				unsigned int vid)
+{
+	u64 maddr = ether_addr_to_u64(mac);
+
+	lockdep_assert_held(&lan9645x->mact_lock);
+
+	lan_wr(ANA_MACHDATA_VID_SET(vid) |
+	       ANA_MACHDATA_MACHDATA_SET(upper_32_bits(maddr)),
+	       lan9645x,
+	       ANA_MACHDATA);
+
+	lan_wr(lower_32_bits(maddr),
+	       lan9645x,
+	       ANA_MACLDATA);
+}
+
+static int __lan9645x_mact_forget(struct lan9645x *lan9645x,
+				  const unsigned char mac[ETH_ALEN],
+				  unsigned int vid,
+				  enum macaccess_entry_type type)
+{
+	lockdep_assert_held(&lan9645x->mact_lock);
+
+	lan9645x_mac_select(lan9645x, mac, vid);
+
+	lan_wr(ANA_MACACCESS_ENTRYTYPE_SET(type) |
+	       ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_FORGET),
+	       lan9645x,
+	       ANA_MACACCESS);
+
+	return lan9645x_mac_wait_for_completion(lan9645x, NULL);
+}
+
+int lan9645x_mact_forget(struct lan9645x *lan9645x,
+			 const unsigned char mac[ETH_ALEN], unsigned int vid,
+			 enum macaccess_entry_type type)
+{
+	int err;
+
+	mutex_lock(&lan9645x->mact_lock);
+	err = __lan9645x_mact_forget(lan9645x, mac, vid, type);
+	mutex_unlock(&lan9645x->mact_lock);
+
+	return err;
+}
+
+static int __lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
+				 const unsigned char mac[ETH_ALEN],
+				 unsigned int vid,
+				 enum macaccess_entry_type type,
+				 bool cpu_copy)
+{
+	lockdep_assert_held(&lan9645x->mact_lock);
+
+	lan9645x_mac_select(lan9645x, mac, vid);
+
+	lan_wr(ANA_MACACCESS_VALID_SET(1) |
+	       ANA_MACACCESS_DEST_IDX_SET(port) |
+	       ANA_MACACCESS_MAC_CPU_COPY_SET(cpu_copy) |
+	       ANA_MACACCESS_ENTRYTYPE_SET(type) |
+	       ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_LEARN),
+	       lan9645x, ANA_MACACCESS);
+
+	return lan9645x_mac_wait_for_completion(lan9645x, NULL);
+}
+
+int lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
+			const unsigned char mac[ETH_ALEN], unsigned int vid,
+			enum macaccess_entry_type type, bool cpu_copy)
+{
+	int err;
+
+	mutex_lock(&lan9645x->mact_lock);
+	err = __lan9645x_mact_learn(lan9645x, port, mac, vid, type, cpu_copy);
+	mutex_unlock(&lan9645x->mact_lock);
+
+	return err;
+}
+
+int lan9645x_mact_flush(struct lan9645x *lan9645x, int port)
+{
+	int err;
+
+	mutex_lock(&lan9645x->mact_lock);
+	/* MAC table entries with dst index matching port are aged on scan. */
+	lan_wr(ANA_ANAGEFIL_PID_EN_SET(1) |
+	       ANA_ANAGEFIL_PID_VAL_SET(port),
+	       lan9645x, ANA_ANAGEFIL);
+
+	/* Flushing requires two scans. First sets AGE_FLAG=1, second removes
+	 * entries with AGE_FLAG=1.
+	 */
+	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_AGE),
+	       lan9645x,
+	       ANA_MACACCESS);
+
+	err = lan9645x_mac_wait_for_completion(lan9645x, NULL);
+	if (err)
+		goto mact_unlock;
+
+	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_AGE),
+	       lan9645x,
+	       ANA_MACACCESS);
+
+	err = lan9645x_mac_wait_for_completion(lan9645x, NULL);
+
+mact_unlock:
+	lan_wr(0, lan9645x, ANA_ANAGEFIL);
+	mutex_unlock(&lan9645x->mact_lock);
+	return err;
+}
+
+int lan9645x_mac_init(struct lan9645x *lan9645x)
+{
+	u32 val;
+	int err;
+
+	/* Clear the MAC table */
+	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_INIT), lan9645x,
+	       ANA_MACACCESS);
+
+	err = lan9645x_rd_poll_timeout(lan9645x, ANA_MACACCESS, val,
+				       ANA_MACACCESS_MAC_TABLE_CMD_GET(val) ==
+				       CMD_IDLE);
+	if (err) {
+		dev_err(lan9645x->dev, "MAC table clear timeout\n");
+		return err;
+	}
+
+	mutex_init(&lan9645x->mact_lock);
+	return 0;
+}
+
+void lan9645x_mac_deinit(struct lan9645x *lan9645x)
+{
+	mutex_destroy(&lan9645x->mact_lock);
+}
+
+int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
+			   dsa_fdb_dump_cb_t *cb, void *data)
+{
+	u8 mac[ETH_ALEN] __aligned(2);
+	u32 mach, macl, maca;
+	int err = 0;
+	u64 addr;
+	int iter;
+	u16 vid;
+	u8 type;
+
+	mutex_lock(&lan9645x->mact_lock);
+
+	/* The aging filter works both for aging scans and GET_NEXT table scans.
+	 * With it, the HW table iteration only stops at entries matching our
+	 * filter. Since DSA calls us for each port on a table dump, this helps
+	 * avoid unnecessary work.
+	 *
+	 * Setup agefilter on our port
+	 */
+	lan_wr(ANA_ANAGEFIL_PID_EN_SET(1) |
+	       ANA_ANAGEFIL_PID_VAL_SET(port),
+	       lan9645x, ANA_ANAGEFIL);
+
+	lan_wr(0, lan9645x, ANA_MACHDATA);
+	lan_wr(0, lan9645x, ANA_MACLDATA);
+
+	type = ENTRYTYPE_NORMAL;
+
+	for (iter = 0; iter < MACT_GET_NEXT_MAX; iter++) {
+		/* CMD_GET_NEXT returns the smallest entry ordered above the one
+		 * left in the registers.
+		 * We rely on mach, macl and type being set correctly in
+		 * the registers from previous round, vis a vis the GET_NEXT
+		 * semantics, so locking entire loop is important.
+		 */
+		lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_GET_NEXT) |
+		       ANA_MACACCESS_ENTRYTYPE_SET(type),
+		       lan9645x, ANA_MACACCESS);
+
+		err = lan9645x_mac_wait_for_completion(lan9645x, &maca);
+		if (err)
+			break;
+
+		if (ANA_MACACCESS_VALID_GET(maca) == 0)
+			break;
+
+		type = ANA_MACACCESS_ENTRYTYPE_GET(maca);
+		mach = lan_rd(lan9645x, ANA_MACHDATA);
+		macl = lan_rd(lan9645x, ANA_MACLDATA);
+
+		/* Only dynamic entries are surfaced through the user port dump.
+		 * ENTRYTYPE_LOCKED entries are already reported by the bridge
+		 * master's ndo_fdb_dump as NTF_MASTER, so we avoid duplicating
+		 * them as NTF_SELF.
+		 * Entries toward the host (NTF_SELF) have DEST_IDX == PGID_CPU
+		 * and are filtered out by the DEST_IDX check.
+		 */
+		if (ANA_MACACCESS_DEST_IDX_GET(maca) == port &&
+		    type == ENTRYTYPE_NORMAL) {
+			addr = (u64)ANA_MACHDATA_MACHDATA_GET(mach) << 32 |
+			       macl;
+			u64_to_ether_addr(addr, mac);
+			vid = ANA_MACHDATA_VID_GET(mach);
+			if (vid > VLAN_MAX)
+				vid = 0;
+
+			err = cb(mac, vid, false, data);
+			if (err)
+				break;
+		}
+	}
+
+	if (iter == MACT_GET_NEXT_MAX) {
+		dev_err(lan9645x->dev,
+			"MAC table walk on port %d did not terminate\n", port);
+		err = -EIO;
+	}
+
+	/* Remove aging filters */
+	lan_wr(0, lan9645x, ANA_ANAGEFIL);
+
+	mutex_unlock(&lan9645x->mact_lock);
+
+	return err;
+}
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
index cddd10cfb45a..058e47e58b9a 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -74,6 +74,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
 {
 	struct lan9645x *lan9645x = ds->priv;
 
+	lan9645x_mac_deinit(lan9645x);
 	mutex_destroy(&lan9645x->fwd_domain_lock);
 	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
 }
@@ -160,6 +161,9 @@ static int lan9645x_setup(struct dsa_switch *ds)
 
 	mutex_init(&lan9645x->fwd_domain_lock);
 	err = lan9645x_vlan_init(lan9645x);
+	if (err)
+		goto err_mutex;
+	err = lan9645x_mac_init(lan9645x);
 	if (err)
 		goto err_mutex;
 
@@ -367,6 +371,119 @@ static int lan9645x_port_vlan_del(struct dsa_switch *ds, int port,
 	return err;
 }
 
+static void lan9645x_port_fast_age(struct dsa_switch *ds, int port)
+{
+	int err;
+
+	err = lan9645x_mact_flush(ds->priv, port);
+	if (err)
+		dev_err(ds->dev, "Flushing MAC table on port %d returned %pe\n",
+			port, ERR_PTR(err));
+}
+
+static int lan9645x_fdb_dump(struct dsa_switch *ds, int port,
+			     dsa_fdb_dump_cb_t *cb, void *data)
+{
+	return lan9645x_mact_dsa_dump(ds->priv, port, cb, data);
+}
+
+static struct net_device *lan9645x_db2bridge(struct dsa_db db)
+{
+	switch (db.type) {
+	case DSA_DB_PORT:
+	case DSA_DB_LAG:
+		return NULL;
+	case DSA_DB_BRIDGE:
+		return db.bridge.dev;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+}
+
+static u16 lan9645x_fdb_vid(u16 vid, const struct dsa_db *db)
+{
+	return vid ? vid : lan9645x_vlan_unaware_pvid(db->type == DSA_DB_BRIDGE);
+}
+
+static bool lan9645x_db_equal(const struct dsa_db *a, const struct dsa_db *b)
+{
+	if (a->type != b->type)
+		return false;
+
+	switch (a->type) {
+	case DSA_DB_PORT:
+		return a->dp == b->dp;
+	case DSA_DB_LAG:
+		return a->lag.dev == b->lag.dev;
+	case DSA_DB_BRIDGE:
+		return a->bridge.num == b->bridge.num;
+	}
+
+	return false;
+}
+
+static bool lan9645x_host_addr_shared(struct dsa_port *dp,
+				      const struct list_head *addrs,
+				      const unsigned char *addr, u16 vid,
+				      const struct dsa_db *db)
+{
+	u16 hw_vid = lan9645x_fdb_vid(vid, db);
+	struct dsa_mac_addr *a;
+
+	lockdep_assert_held(&dp->addr_lists_lock);
+
+	list_for_each_entry(a, addrs, list) {
+		if (ether_addr_equal(a->addr, addr) &&
+		    !lan9645x_db_equal(&a->db, db) &&
+		    lan9645x_fdb_vid(a->vid, &a->db) == hw_vid)
+			return true;
+	}
+
+	return false;
+}
+
+static int lan9645x_fdb_add(struct dsa_switch *ds, int port,
+			    const unsigned char *addr, u16 vid,
+			    struct dsa_db db)
+{
+	struct net_device *br = lan9645x_db2bridge(db);
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct lan9645x *lan9645x = ds->priv;
+	int dest;
+
+	if (IS_ERR(br))
+		return PTR_ERR(br);
+
+	if (dsa_port_is_cpu(dp) &&
+	    lan9645x_host_addr_shared(dp, &dp->fdbs, addr, vid, &db))
+		return 0;
+
+	dest = dsa_port_is_cpu(dp) ? PGID_CPU : port;
+
+	return lan9645x_mact_learn(lan9645x, dest, addr,
+				   lan9645x_fdb_vid(vid, &db),
+				   ENTRYTYPE_LOCKED, false);
+}
+
+static int lan9645x_fdb_del(struct dsa_switch *ds, int port,
+			    const unsigned char *addr, u16 vid,
+			    struct dsa_db db)
+{
+	struct net_device *br = lan9645x_db2bridge(db);
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct lan9645x *lan9645x = ds->priv;
+
+	if (IS_ERR(br))
+		return PTR_ERR(br);
+
+	if (dsa_port_is_cpu(dp) &&
+	    lan9645x_host_addr_shared(dp, &dp->fdbs, addr, vid, &db))
+		return 0;
+
+	return lan9645x_mact_forget(lan9645x, addr, lan9645x_fdb_vid(vid, &db),
+				    ENTRYTYPE_LOCKED);
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 
@@ -385,6 +502,12 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.port_vlan_filtering		= lan9645x_port_vlan_filtering,
 	.port_vlan_add			= lan9645x_port_vlan_add,
 	.port_vlan_del			= lan9645x_port_vlan_del,
+
+	/* MAC table integration */
+	.port_fast_age			= lan9645x_port_fast_age,
+	.port_fdb_dump			= lan9645x_fdb_dump,
+	.port_fdb_add			= lan9645x_fdb_add,
+	.port_fdb_del			= lan9645x_fdb_del,
 };
 
 static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
index 73a91087824a..e442c222e360 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -177,6 +177,19 @@ struct lan9645x_vlan {
 	    untagged: 9; /* ports 0-8 */
 };
 
+/* MAC table entry types.
+ * ENTRYTYPE_NORMAL is subject to aging.
+ * ENTRYTYPE_LOCKED is not subject to aging.
+ * ENTRYTYPE_MACV4 is not subject to aging. For IPv4 multicast.
+ * ENTRYTYPE_MACV6 is not subject to aging. For IPv6 multicast.
+ */
+enum macaccess_entry_type {
+	ENTRYTYPE_NORMAL = 0,
+	ENTRYTYPE_LOCKED,
+	ENTRYTYPE_MACV4,
+	ENTRYTYPE_MACV6,
+};
+
 struct lan9645x {
 	struct device *dev;
 	struct dsa_switch *ds;
@@ -192,6 +205,7 @@ struct lan9645x {
 	u16 bridge_mask; /* Mask for bridged ports */
 	/* lock forwarding configuration and vlan table */
 	struct mutex fwd_domain_lock;
+	struct mutex mact_lock; /* serialize mac table register access */
 
 	int num_port_dis;
 
@@ -385,4 +399,17 @@ int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
 int lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid);
 void lan9645x_vlan_set_hostmode(struct lan9645x_port *p);
 
+/* MAC table: lan9645x_mac.c */
+int lan9645x_mact_flush(struct lan9645x *lan9645x, int port);
+int lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
+			const unsigned char mac[ETH_ALEN], unsigned int vid,
+			enum macaccess_entry_type type, bool cpu_copy);
+int lan9645x_mact_forget(struct lan9645x *lan9645x,
+			 const unsigned char mac[ETH_ALEN], unsigned int vid,
+			 enum macaccess_entry_type type);
+int lan9645x_mac_init(struct lan9645x *lan9645x);
+void lan9645x_mac_deinit(struct lan9645x *lan9645x);
+int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
+			   dsa_fdb_dump_cb_t *cb, void *data);
+
 #endif /* __LAN9645X_MAIN_H__ */

-- 
2.52.0

