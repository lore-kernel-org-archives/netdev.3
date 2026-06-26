Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F43750D6
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484740; cv=none; b=JN6ufdSIIrMaN9+9lphGBKjj9rMfALXm9v15ZrPtsZIsOf3p6eXJSiPPuiykPGL2MtzBPQIEjQ3+TaiZPUU0x0Bh+HB96nistZ0ZxXzYJG7HUunMbwiTldMKAdghYWuIITXh8hUj06RJ7aropYFktVjRg9J8CXatpkrZOPXuDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484740; c=relaxed/simple;
	bh=asDRLijXKz0PAu75f1PXRxhfXomGdPm/+X8Jw6/u84U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVUgjOW9eXTNsw7kiDHk6C8ktsTckakzwuGQ8VXhGlISz49Ie1tvyteMXCmb0rLpbVAzZe2xCwiw+tbZiwy9+rPx57BjmEeSK8s5uKY4xBTp+2etRJYvZxyZEHpMVMqp0BRkfjFqlC4S12Xog5hCOOmQAyE8uPXWVwn+TZ2isI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from fcoeperf6.blr.asicdesigners.com (fcoeperf6.blr.asicdesigners.com [10.193.187.161])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 65QDn7aU014223;
	Fri, 26 Jun 2026 06:49:08 -0700
From: Harsha M <h.mahadeva@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        Harsha M <h.mahadeva@chelsio.com>
Subject: [PATCH net v1] cxgb4: flower: fix 802.1ad VLAN TPID matching in tc flower filters
Date: Fri, 26 Jun 2026 19:18:22 +0530
Message-ID: <20260626134848.91281-1-h.mahadeva@chelsio.com>
X-Mailer: git-send-email 2.43.0
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
requested TPID value and mask, enabling OVLAN matching through the RX
control register, and populating the filter specification with the
outer VLAN VID and valid-bit match fields when an 802.1ad TPID is
requested.This restores correct matching for tc flower filters that
specify an 802.1ad outer VLAN tag

Signed-off-by: Harsha M <h.mahadeva@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  | 62 +++++++++++++------
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h  |  3 +
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
index 3307e5042681..41a2998ee2a0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -40,6 +40,7 @@
 #include "cxgb4.h"
 #include "cxgb4_filter.h"
 #include "cxgb4_tc_flower.h"
+#include "t4_regs.h"
 
 #define STATS_CHECK_PERIOD (HZ / 2)
 
@@ -266,24 +267,49 @@ static void cxgb4_process_flow_match(struct net_device *dev,
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
+		if (be16_to_cpu(match.key->vlan_tpid) == ETH_P_8021AD) {
+			struct adapter *adap = netdev2adap(dev);
+			u32 ovlan_reg, ctl_reg, val, port_id;
+
+			if (!adap) {
+				netdev_err(dev, "%s: adap not found\n", __func__);
+				return;
+			}
+
+			val = (be16_to_cpu(match.mask->vlan_tpid) << 16) |
+			      be16_to_cpu(match.key->vlan_tpid);
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
2.43.0

