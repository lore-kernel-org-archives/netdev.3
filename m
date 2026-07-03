Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A6136F419;
	Fri,  3 Jul 2026 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064882; cv=none; b=kBPWez2O41sJ2uS3e/jPfkGrplQs9+V5njl0UhA38Kdp/RaK1oFPVhnFMzOTckUzy+tJ91m11wONc7KUCF4kSkaXUrIwDND84fm8SwZv0Lk2WeuUE0Fmhfd0WreqR1oSlN/RMVK8juxFCrnX7aHEvEOIA7+6QQZQJxzJcpW+TUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064882; c=relaxed/simple;
	bh=DAjIILq1TaU5E2Ahx0lpbH4APlA5n0DMA+J8Hz8QEJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knWeP86KEfS2hwk3X7vizzHcdm8trlLtiscxPedN2SofapN4PPTdtcYb9rt/9F2bK2iVlv2BTcC8VY3YPb0hl7v6ZnyD9hMLk1wQjkFKmXJNoXdp6cTUZLDtyw7vir7lX12S7h/i2vUY+6kPxMoyq3wPDHHTZcpWU3RcdixnQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=h4+nUM5p; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="h4+nUM5p"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 5292360C04;
	Fri,  3 Jul 2026 03:47:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064880; bh=Kc+jdRFnnQabLFrRtTqqiykMsMRAsuVWVZV+YklF7Vc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h4+nUM5p2RjJh8+1/jWev5RnlGPrGj2xfUXSAp0mg//BTukeDYxhLSAjJWnjumw3j
	 oIwJEdfZZvbl90gm+t9zqT7b3oaRz58goY5dDIWnp4D8qq9gnRcVq9Y70egxsN25kT
	 iZhy6s5Syf02G8ZuW1ak0a0LXIrz5G3YyxtxwwHZJ+YePGYmlNFtsJxkhR2Y4Rrahy
	 AruhEsNUZChM+V1lm09zanf6ZBfbKobMbQcIG20iaqVAYUFvw7pE9ovIfP9eY0ua9F
	 SrkxREoqH5VdwY8MMuGKQcpL3/0OUjZ1YTzYpKxeqxu0CzhUSK4B7fyAl5nawjIOKN
	 KLF9udD4SasXA==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:51 +1000
Subject: [PATCH net-next 17/17] net: dsa: mv88e6xxx: RMU DUMP_ATU support
 in devlink
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-17-991a27d78bca@padl.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
 Kieran Tyrrell <kieran@sienda.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=9038;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=DAjIILq1TaU5E2Ahx0lpbH4APlA5n0DMA+J8Hz8QEJM=;
 b=0rsBSfpPYd4Caw5pRexe67hHz6S4F08hG1a+Uf/HOoOo8aIF/ZgqTP7T8g8cIDkyV+Hrm+68k
 xWDyHk1CKteCmgdOVPnZnQt95wENKJ6kwOGDkWr9lqObT6749XXCGCW
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

Support reading an ATU snapshot in a single RMU request.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.h    | 10 +++++
 drivers/net/dsa/mv88e6xxx/devlink.c | 67 ++++++++++++++++++++++---------
 drivers/net/dsa/mv88e6xxx/rmu.c     | 78 +++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/rmu.h     | 35 +++++++++++++++++
 4 files changed, 171 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index fdc87d02469b5..7bbb649330d55 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -205,6 +205,16 @@ struct mv88e6xxx_stu_entry {
 	u8	state[DSA_MAX_PORTS];
 };
 
+struct mv88e6xxx_devlink_atu_entry {
+	/* The FID is scattered over multiple registers. */
+	u16 fid;
+	u16 atu_op;
+	u16 atu_data;
+	u16 atu_01;
+	u16 atu_23;
+	u16 atu_45;
+};
+
 struct mv88e6xxx_bus_ops;
 struct mv88e6xxx_irq_ops;
 struct mv88e6xxx_gpio_ops;
diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index 6d7da381f9f38..5c2a59d1145b8 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -6,6 +6,7 @@
 #include "global1.h"
 #include "global2.h"
 #include "port.h"
+#include "rmu.h"
 
 static int mv88e6xxx_atu_get_hash(struct mv88e6xxx_chip *chip, u8 *hash)
 {
@@ -307,16 +308,6 @@ static int mv88e6xxx_region_global_snapshot(struct devlink *dl,
  * mv88e6xxx generations
  */
 
-struct mv88e6xxx_devlink_atu_entry {
-	/* The FID is scattered over multiple registers. */
-	u16 fid;
-	u16 atu_op;
-	u16 atu_data;
-	u16 atu_01;
-	u16 atu_23;
-	u16 atu_45;
-};
-
 static int mv88e6xxx_region_atu_snapshot_fid(struct mv88e6xxx_chip *chip,
 					     int fid,
 					     struct mv88e6xxx_devlink_atu_entry *table,
@@ -369,6 +360,33 @@ static int mv88e6xxx_region_atu_snapshot_fid(struct mv88e6xxx_chip *chip,
 	return 0;
 }
 
+static int mv88e6xxx_region_atu_snapshot_rmu(struct mv88e6xxx_chip *chip,
+					     struct mv88e6xxx_devlink_atu_entry *table,
+					     int *count)
+{
+	unsigned int num_macs = mv88e6xxx_num_macs(chip);
+	u16 cont_code = 0;
+	int err;
+
+	do {
+		if (*count + MV88E6XXX_RMU_MAX_ATU_ENTRIES > num_macs) {
+			err = -ERANGE;
+			break;
+		}
+
+		err = mv88e6xxx_rmu_dump_atu(chip, &table[*count], &cont_code);
+		if (err < 0)
+			break;
+
+		*count += err;
+	} while (cont_code != 0);
+
+	if (err < 0)
+		*count = 0;
+
+	return err;
+}
+
 static int mv88e6xxx_region_atu_snapshot(struct devlink *dl,
 					 const struct devlink_region_ops *ops,
 					 struct netlink_ext_ack *extack,
@@ -386,18 +404,29 @@ static int mv88e6xxx_region_atu_snapshot(struct devlink *dl,
 
 	mv88e6xxx_reg_lock(chip);
 
-	while (1) {
-		fid = find_next_bit(chip->fid_bitmap, MV88E6XXX_N_FID, fid + 1);
-		if (fid == MV88E6XXX_N_FID)
-			break;
+	err = mv88e6xxx_region_atu_snapshot_rmu(chip, table, &count);
+	if (err >= 0) {
+		/* RMU succeeded, use its results */
+		err = 0;
+	} else if (!mv88e6xxx_rmu_can_mdio_fallback(chip, err)) {
+		kfree(table);
+		goto out;
+	} else {
+		while (1) {
+			fid = find_next_bit(chip->fid_bitmap, MV88E6XXX_N_FID,
+					    fid + 1);
+			if (fid == MV88E6XXX_N_FID)
+				break;
 
-		err =  mv88e6xxx_region_atu_snapshot_fid(chip, fid, table,
-							 &count);
-		if (err) {
-			kfree(table);
-			goto out;
+			err =  mv88e6xxx_region_atu_snapshot_fid(chip, fid,
+								 table, &count);
+			if (err) {
+				kfree(table);
+				goto out;
+			}
 		}
 	}
+
 	*data = (u8 *)table;
 out:
 	mv88e6xxx_reg_unlock(chip);
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.c b/drivers/net/dsa/mv88e6xxx/rmu.c
index 5660372f41ad7..36422039030cd 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.c
+++ b/drivers/net/dsa/mv88e6xxx/rmu.c
@@ -106,6 +106,84 @@ static int mv88e6xxx_rmu_request(struct mv88e6xxx_chip *chip,
 				  resp, resp_len, timeout_ms);
 }
 
+int mv88e6xxx_rmu_dump_atu(struct mv88e6xxx_chip *chip,
+			   struct mv88e6xxx_devlink_atu_entry *entries,
+			   u16 *cont_code)
+{
+	__be16 req[] = {
+		MV88E6XXX_RMU_REQ_FORMAT_SOHO,
+		MV88E6XXX_RMU_REQ_PAD,
+		MV88E6XXX_RMU_REQ_CODE_ATU,
+		htons(*cont_code),
+	};
+	struct mv88e6xxx_rmu_atu_resp resp;
+	int resp_len, count;
+	int ret, i;
+
+	if (chip->rmu_state == MV88E6XXX_RMU_DISABLED)
+		return -EOPNOTSUPP;
+
+	resp_len = sizeof(resp);
+	ret = mv88e6xxx_rmu_request(chip, req, sizeof(req),
+				    &resp, resp_len,
+				    MV88E6XXX_RMU_REQUEST_TIMEOUT_MS);
+	if (ret < 0) {
+		dev_dbg(chip->dev, "RMU: error for command DUMP_ATU %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	/* minimum packet length */
+	resp_len = sizeof(struct mv88e6xxx_rmu_header) + sizeof(__be16); /* cont_code */
+
+	if (ret < resp_len || (ret - resp_len) % sizeof(struct mv88e6xxx_rmu_atu_entry)) {
+		dev_err(chip->dev, "RMU: DUMP_ATU returned wrong length: rx %d expecting %zd\n",
+			ret, sizeof(resp));
+		return -EPROTO;
+	}
+
+	count = (ret - resp_len) / sizeof(struct mv88e6xxx_rmu_atu_entry);
+
+	if (resp.rmu_header.code != MV88E6XXX_RMU_RESP_CODE_ATU) {
+		dev_err(chip->dev, "RMU: DUMP_ATU returned wrong code %d\n",
+			be16_to_cpu(resp.rmu_header.code));
+		return -EPROTO;
+	}
+
+	for (i = 0; i < count; i++) {
+		const struct mv88e6xxx_rmu_atu_entry *src = &resp.entries[i];
+		struct mv88e6xxx_devlink_atu_entry *dst = &entries[i];
+		u16 tmp;
+
+		tmp = ntohs(src->state_trunk_dpv);
+		if (!MV88E6XXX_RMU_ATU_ENTRY_STATE_GET(tmp)) {
+			*cont_code = 0;
+			return i;
+		}
+
+		dst->atu_data = MV88E6XXX_RMU_ATU_ENTRY_STATE_GET(tmp) & 0xf;
+		if (tmp & MV88E6XXX_RMU_ATU_TRUNK)
+			dst->atu_data |= MV88E6XXX_G1_ATU_DATA_TRUNK;
+		dst->atu_data |= (MV88E6XXX_RMU_ATU_DPV_GET(tmp) &
+				  mv88e6xxx_port_mask(chip)) << 4;
+
+		tmp = ntohs(src->pri_fid);
+		dst->fid = MV88E6XXX_RMU_ATU_FID_GET(tmp);
+		dst->atu_op = MV88E6XXX_G1_ATU_OP_GET_NEXT_DB;
+
+		dst->atu_01 = ntohs(src->atu_01);
+		dst->atu_23 = ntohs(src->atu_23);
+		dst->atu_45 = ntohs(src->atu_45);
+	}
+
+	if (i == MV88E6XXX_RMU_MAX_ATU_ENTRIES)
+		*cont_code = ntohs(resp.cont_code);
+	else
+		*cont_code = 0;
+
+	return i;
+}
+
 int mv88e6xxx_rmu_stats(struct mv88e6xxx_chip *chip, int port,
 			u64 *data,
 			const struct mv88e6xxx_hw_stat *hw_stats,
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.h b/drivers/net/dsa/mv88e6xxx/rmu.h
index 0865e899cb340..3a288ff3b113f 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.h
+++ b/drivers/net/dsa/mv88e6xxx/rmu.h
@@ -17,6 +17,7 @@
 #define MV88E6XXX_RMU_REQ_FORMAT_SOHO		htons(0x0001)
 #define MV88E6XXX_RMU_REQ_PAD			htons(0x0000)
 #define MV88E6XXX_RMU_REQ_CODE_GET_ID		htons(0x0000)
+#define MV88E6XXX_RMU_REQ_CODE_ATU		htons(0x1000)
 #define MV88E6XXX_RMU_REQ_CODE_MIB		htons(0x1020)
 #define MV88E6XXX_RMU_REQ_CODE_REG_RW		htons(0x2000)
 #define MV88E6XXX_RMU_REQ_DATA			htons(0x0000)
@@ -50,6 +51,7 @@
 #define MV88E6XXX_RMU_RESP_FORMAT_1		htons(0x0001)
 #define MV88E6XXX_RMU_RESP_FORMAT_2		htons(0x0002)
 #define MV88E6XXX_RMU_RESP_CODE_GOT_ID		htons(0x0000)
+#define MV88E6XXX_RMU_RESP_CODE_ATU		htons(0x1000)
 #define MV88E6XXX_RMU_RESP_CODE_MIB		htons(0x1020)
 #define MV88E6XXX_RMU_RESP_CODE_REG_RW		htons(0x2000)
 
@@ -67,6 +69,34 @@ struct mv88e6xxx_rmu_rw_resp {
 	__be16 end1;
 } __packed;
 
+struct mv88e6xxx_rmu_atu_entry {
+	__be16 state_trunk_dpv;
+	__be16 atu_01;
+	__be16 atu_23;
+	__be16 atu_45;
+	__be16 pri_fid;
+} __packed;
+
+#define MV88E6XXX_RMU_MAX_ATU_ENTRIES		48
+
+#define MV88E6XXX_RMU_ATU_ENTRY_STATE_MASK	GENMASK(15, 12)
+#define MV88E6XXX_RMU_ATU_ENTRY_STATE_GET(p)	FIELD_GET(MV88E6XXX_RMU_ATU_ENTRY_STATE_MASK, p)
+#define MV88E6XXX_RMU_ATU_TRUNK			0x0800
+#define MV88E6XXX_RMU_ATU_DPV_MASK		GENMASK(10, 0)
+#define MV88E6XXX_RMU_ATU_DPV_GET(p)		FIELD_GET(MV88E6XXX_RMU_ATU_DPV_MASK, p)
+
+#define MV88E6XXX_RMU_ATU_PRI_MASK		GENMASK(14, 12)
+#define MV88E6XXX_RMU_ATU_PRI_GET(p)		FIELD_GET(MV88E6XXX_RMU_ATU_PRI_MASK, p)
+
+#define MV88E6XXX_RMU_ATU_FID_MASK		GENMASK(11, 0)
+#define MV88E6XXX_RMU_ATU_FID_GET(p)		FIELD_GET(MV88E6XXX_RMU_ATU_FID_MASK, p)
+
+struct mv88e6xxx_rmu_atu_resp {
+	struct mv88e6xxx_rmu_header rmu_header;
+	struct mv88e6xxx_rmu_atu_entry entries[MV88E6XXX_RMU_MAX_ATU_ENTRIES];
+	__be16 cont_code;
+} __packed;
+
 /* number of RMU MIB statistics, by type, in octets */
 #define MV88E6XXX_RMU_STATS_TYPE_DATA0_LEN	128
 #define MV88E6XXX_RMU_STATS_TYPE_PORT_LEN	12
@@ -81,6 +111,11 @@ struct mv88e6xxx_rmu_mib_resp {
 	__be32 data[MV88E6XXX_RMU_STATS_TYPE_MAX_LEN / 4];
 } __packed;
 
+struct mv88e6xxx_devlink_atu_entry;
+
+int mv88e6xxx_rmu_dump_atu(struct mv88e6xxx_chip *chip,
+			   struct mv88e6xxx_devlink_atu_entry *entries,
+			   u16 *cont_code);
 int mv88e6xxx_rmu_stats(struct mv88e6xxx_chip *chip, int port,
 			u64 *data,
 			const struct mv88e6xxx_hw_stat *hw_stats,

-- 
2.43.0

