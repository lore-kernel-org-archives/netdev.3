Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180C3128B8
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782967945; cv=none; b=tToUI5o8dkTt4P+4xGrTyQzomQyG0+YKnNBQjDphO+b83VQVvG/zMuqCREPwVLjF416fBFSmSXYKVa6M3bSZB05iZxDWzDVMZ/mSc0uzc2uSGga9tZ7Pn1WZjMzJF1fDB/txGV+FhbsZXTXJTXO5r1eQ+4WN5y1c5CNANfkR184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782967945; c=relaxed/simple;
	bh=92O6wDmyheAdp6RXLYk05B4+Ki7KTzxJ1BJX61W+xko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jsJFUtiHVfMrmotYMvVcBqHJBeuXbrnnoXto4PYsRnNvRFZiUh24hCBSAuXx2LRUSI2Nux3iuDS7m28tDtEf20c39QCG3IkJ+HX/vYYUELz4fYb0yYakEwlwqZ6hynsSHcI5VIhE7wmwrW+JzoD4EiwuHV3JzCFAY4xfj8+g44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from fiesta.blr.asicdesigners.com (fiesta.blr.asicdesigners.com [10.193.80.255])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 6624nwSl019578;
	Wed, 1 Jul 2026 21:49:59 -0700
From: Harsha M <h.mahadeva@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        Harsha M <h.mahadeva@chelsio.com>
Subject: [PATCH net v2] cxgb4: flower: fix 802.1ad VLAN TPID matching in tc flower filters
Date: Thu,  2 Jul 2026 10:18:38 +0530
Message-ID: <20260702044955.20119-1-h.mahadeva@chelsio.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cxgb4 driver does not correctly handle tc flower filters that
match on an 802.1ad (Q-in-Q) outer VLAN tag. While the VLAN VID is
processed, the specified 802.1ad TPID is not programmed into the
adapter's outer VLAN matching configuration, resulting in incorrect
filter matches.

Fix this by configuring the port-specific OVLAN register with the
requested TPID value, enabling OVLAN matching through the RX control
register, and populating the filter specification with the outer VLAN
VID and valid-bit match fields when an 802.1ad TPID is requested.This
restores correct matching for tc flower filters that specify an 802.1ad
outer VLAN tag

Signed-off-by: Harsha M <h.mahadeva@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
v2:
- Compare vlan_tpid with 'cpu_to_be16(ETH_P_8021AD)'
- Program the OVLAN register using the ETH_P_8021AD constant
  and TPID mask as 0xffff instead of deriving the value from the
  filter key and mask
v1:
https://lore.kernel.org/all/20260629184417.31b21223@kernel.org/
---
 .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  | 61 +++++++++++++------
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h  |  3 +
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
index 3307e5042681..8c5cfa6982e7 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -40,6 +40,7 @@
 #include "cxgb4.h"
 #include "cxgb4_filter.h"
 #include "cxgb4_tc_flower.h"
+#include "t4_regs.h"
 
 #define STATS_CHECK_PERIOD (HZ / 2)
 
@@ -266,24 +267,48 @@ static void cxgb4_process_flow_match(struct net_device *dev,
 					       VLAN_PRIO_SHIFT);
 		vlan_tci_mask = match.mask->vlan_id | (match.mask->vlan_priority <<
 						     VLAN_PRIO_SHIFT);
-		fs->val.ivlan = vlan_tci;
-		fs->mask.ivlan = vlan_tci_mask;
-
-		fs->val.ivlan_vld = 1;
-		fs->mask.ivlan_vld = 1;
-
-		/* Chelsio adapters use ivlan_vld bit to match vlan packets
-		 * as 802.1Q. Also, when vlan tag is present in packets,
-		 * ethtype match is used then to match on ethtype of inner
-		 * header ie. the header following the vlan header.
-		 * So, set the ivlan_vld based on ethtype info supplied by
-		 * TC for vlan packets if its 802.1Q. And then reset the
-		 * ethtype value else, hw will try to match the supplied
-		 * ethtype value with ethtype of inner header.
-		 */
-		if (fs->val.ethtype == ETH_P_8021Q) {
-			fs->val.ethtype = 0;
-			fs->mask.ethtype = 0;
+
+		if (match.key->vlan_tpid == cpu_to_be16(ETH_P_8021AD)) {
+			struct adapter *adap = netdev2adap(dev);
+			u32 ovlan_reg, ctl_reg, val, port_id;
+
+			if (!adap) {
+				netdev_err(dev, "%s: adap not found\n", __func__);
+				return;
+			}
+
+			val = (0xffff << 16) | ETH_P_8021AD;
+			port_id = netdev2pinfo(dev)->port_id;
+			fs->val.ovlan = vlan_tci;
+			fs->mask.ovlan = vlan_tci_mask;
+			fs->val.ovlan_vld = 1;
+			fs->mask.ovlan_vld = 1;
+			ovlan_reg = PORT_REG(port_id, MPS_PORT_RX_OVLAN0_A);
+			ctl_reg = PORT_REG(port_id, MPS_PORT_RX_CTL_A);
+			t4_write_reg(adap, ovlan_reg, val);
+			val = t4_read_reg(adap, ctl_reg);
+			t4_write_reg(adap, ctl_reg, val | 1);
+			t4_tp_wr_bits_indirect(adap, TP_INGRESS_CONFIG_A, 1U << 9, 0);
+		} else {
+			fs->val.ivlan = vlan_tci;
+			fs->mask.ivlan = vlan_tci_mask;
+			fs->val.ivlan_vld = 1;
+			fs->mask.ivlan_vld = 1;
+
+			/* Chelsio adapters use ivlan_vld bit to match vlan packets
+			 * as 802.1Q. Also, when vlan tag is present in packets,
+			 * ethtype match is used then to match on ethtype of inner
+			 * header ie. the header following the vlan header.
+			 * So, set the ivlan_vld based on ethtype info supplied by
+			 * TC for vlan packets if its 802.1Q. And then reset the
+			 * ethtype value else, hw will try to match the supplied
+			 * ethtype value with ethtype of inner header.
+			 */
+
+			if (fs->val.ethtype == ETH_P_8021Q) {
+				fs->val.ethtype = 0;
+				fs->mask.ethtype = 0;
+			}
 		}
 	}
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
index 695916ba0405..38c585f3b1ad 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
@@ -1921,6 +1921,9 @@
 #define MAC_PORT_PTP_SUM_LO_A 0x990
 #define MAC_PORT_PTP_SUM_HI_A 0x994
 
+#define MPS_PORT_RX_OVLAN0_A 0x120
+#define MPS_PORT_RX_CTL_A    0X100
+
 #define MPS_CMN_CTL_A	0x9000
 
 #define COUNTPAUSEMCRX_S    5
-- 
2.43.5

