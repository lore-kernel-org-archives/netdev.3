Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537DC416849;
	Mon, 31 Aug 2026 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182430; cv=none; b=ebtQQ6dLcnM2ZUOEKDdI5hk1CfRSvln6ZZzZn+EJr6tZHRJEgthnrTTfiV+Rl+3t/YbxMGNqruAb5jG5DtSqPDfLtrrTNIH3PassHR0BG38lYtS460JpeorQNFG97yRy6CPx5Imo/PrzLqQnY0jPnLGTHkWzCAKzquVrevGRXpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182430; c=relaxed/simple;
	bh=WQhCXQtvU7tUI+wLujTIud7FTecOsOPJrHNSDLIVDgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWNpeCtf5hiFEsuvDaiRs2LLDEkNTD4LxNjFab9PthWy4w9Y5JwG/k4SUXOrdTkA3gT43xcuePfIxC/A8WMzYFtJ0jN2Lktyx+gRLxHANQ8KUSbhtjmnq9GX1xneu2kKxIVlObK4/TJgPzOpSTTmqo6EJaj/U7EaWFZXA9wDM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MFqk90Oe; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MFqk90Oe"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBBnEq1225663;
	Mon, 31 Aug 2026 06:20:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
	g/sbcOHHjL6g4RrVuQ6rnx8ZXTC/e8dgB3RBpbAgkw=; b=MFqk90OeMA6h+oYw1
	Rxuy3aqNqsqNKqA3XusvjcbPRiCt7c0yStzfhqWAucY/Vf7J9qpftuj5X1o7K8Dz
	sAwiOxbb2le0SCyYJBbaEfT7ip1ZfnLWSAStJ0gT373guDCs92gcto49YEXbhbif
	lXKYGpUzEbXnt2KZtZSKOzgKHKwmwOg73fQjJuM39SCtjdpO3q0Lr/qD/u3t8fhJ
	Oaz/ecDwUcyL/3gh8WuiWNe2jlyhQI5ulB5l0030a0mU5ScK6Mmc2UvjVFoLgFjo
	FhUCaGclNcr+9vqRQb8MhEFXBMv0o4n7Ck8jOW3b2ZSVcmIcyRZLm/vQHWbElAby
	fHbGA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gcy3ssmk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:20:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 06:20:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 06:20:14 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D99833F7089;
	Mon, 31 Aug 2026 06:20:11 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v9 net-next 6/8] octeontx2-pf: switch: Register notifiers for switch offload
Date: Mon, 31 Aug 2026 18:49:42 +0530
Message-ID: <20260831131944.2649362-7-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831131944.2649362-1-rkannoth@marvell.com>
References: <20260831131944.2649362-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfX4hGA9SnZiECi
 7B0aRrY3Q6fKKTItxSZP+806JAwNYhcSQB1dMKnQLAjlbivFdLriEWLHXFzOJU5C5cF2b4U/8ls
 SXuA893XysSHJmSNAjMx1xlPNsQo/OuPI+7rw6aiYtyx7TUg4VaN23xcPvrC3OtLeUY9lE+6l85
 Ak7HbsvZu5mZZTAkaQgGJmfMxig2SwvvMZxWVOkhkHpnBft+sI0Q7QMIRqLi7FAa48pTiXSt7Zz
 AmM5N6CcAE7XQ/QG0Cbb2j6m4B6RDbDyveYRmM55u1kQOG5g+ATwZRwwzbYplfgn4FzGV6F2961
 JJ5xYeHuQGF6c5jjN6CdCPmkf03jhlHT4lIEIKUpdEjdVXRg1rGB8LiBZK3BRGcH7MnruZBqcQg
 nqohU2QSCdv8OXnqJQ+adbIlsFSEIbpRl0yPk5P1psZL5CgOVMxG1DownZz9L0A9DcESvQgdWxt
 b8Q0eLKcP05UXJsfKBg==
X-Proofpoint-ORIG-GUID: O5Sn7w471WUjf43_74C1jzyTH23sB0wl
X-Proofpoint-GUID: O5Sn7w471WUjf43_74C1jzyTH23sB0wl
X-Authority-Analysis: v=2.4 cv=baVbluPB c=1 sm=1 tr=0 ts=6a957f8f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=ODqplUojrltCzwWjIakA:9
 a=O8hF6Hzn-FEA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfX5gNJTajLKujk
 w9znKJKc/+/KkXVv00wkpVyBlfmjzAuxLe0BZvfJ9l5W0iHD4+OrjHV/VQ8yzocesoUIvnIzkTr
 XOmH7QFgKqX5Tbm5ehUxwFI19BkPtLk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01

The representor enables switch mode via devlink; register and unregister
the switch notifier blocks when that mode is turned on or off so the PF
can observe FIB routes, neighbour updates, IPv4/IPv6 address changes,
netdev state, and switchdev FDB notifications.
Add sw_nb_v4.c and sw_nb_v6.c for IPv4 and IPv6-specific handling, build
sw_nb_v6.o only when CONFIG_IPV6 is set, and extend sw_nb.c with device
filtering for Cavium ports behind bridges and VLANs.
Initialize and tear down the existing sw_fdb, sw_fib, and sw_fl helpers
together with notifier registration.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/Makefile   |  13 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  45 +-
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 541 +++++++++++++++++-
 .../marvell/octeontx2/nic/switch/sw_nb.h      |  37 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v4.c   | 360 ++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb_v4.h   |  21 +
 .../marvell/octeontx2/nic/switch/sw_nb_v6.c   | 301 ++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb_v6.h   |  21 +
 8 files changed, 1330 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 27590b94133b..6050228be067 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -11,7 +11,18 @@ rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
                otx2_devlink.o qos_sq.o qos.o otx2_xsk.o switch/sw_fdb.o \
 	       switch/sw_fl.o
-rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb.o switch/sw_fib.o
+rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb.o switch/sw_fib.o \
+				       switch/sw_nb_v4.o
+# sw_nb_v6.o calls IPv6 symbols exported by the ipv6 module; only link it
+# when those symbols are reachable (IPv6 built-in, or both driver and IPv6
+# are modules).
+ifeq ($(CONFIG_IPV6),y)
+rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb_v6.o
+else ifneq ($(CONFIG_IPV6),)
+ifeq ($(CONFIG_OCTEONTX2_PF),m)
+rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb_v6.o
+endif
+endif
 
 rvu_nicvf-y := otx2_vf.o
 rvu_rep-y := rep.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 257a2ae6a53e..96ec58c50843 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -15,6 +15,7 @@
 #include "cn10k.h"
 #include "otx2_reg.h"
 #include "rep.h"
+#include "switch/sw_nb.h"
 
 #define DRV_NAME	"rvu_rep"
 #define DRV_STRING	"Marvell RVU Representor Driver"
@@ -399,22 +400,62 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 
 static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 {
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+	struct net_device *netdev = priv->netdev;
+#endif
 	struct devlink_port_attrs attrs = {};
 	struct esw_cfg_req *req;
+	int mbox_err;
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+	int err;
+#endif
 
 	rvu_rep_devlink_set_switch_id(priv, &attrs.switch_id);
 
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+	/* Disable unregisters PF notifiers before ESW_CFG clears rep_mode on
+	 * the AF.  unregister_*_notifier() removes each block synchronously,
+	 * so there is no window where the AF considers the eswitch off while
+	 * sw_nb_* handlers remain registered and could still send mailbox
+	 * traffic (that race existed only when disable ran after the mailbox).
+	 */
+	if (ena) {
+		err = otx2_sw_nb_register(netdev);
+		if (err)
+			return err;
+	} else {
+		/* TODO: On disable, notifiers are unregistered before ESW_CFG. If
+		 * mailbox allocation fails below, restore otx2_sw_nb_register()
+		 * so software notifiers are not abandoned while hardware remains
+		 * in eswitch mode.
+		 */
+		err = otx2_sw_nb_unregister(netdev);
+		if (err)
+			return err;
+	}
+#endif
+
 	mutex_lock(&priv->mbox.lock);
 	req = otx2_mbox_alloc_msg_esw_cfg(&priv->mbox);
 	if (!req) {
 		mutex_unlock(&priv->mbox.lock);
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+		if (ena)
+			otx2_sw_nb_unregister(netdev);
+#endif
 		return -ENOMEM;
 	}
 	req->ena = ena;
 	memcpy(req->switch_id, attrs.switch_id.id, attrs.switch_id.id_len);
-	otx2_sync_mbox_msg(&priv->mbox);
+	mbox_err = otx2_sync_mbox_msg(&priv->mbox);
 	mutex_unlock(&priv->mbox.lock);
-	return 0;
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+	if (ena && mbox_err)
+		otx2_sw_nb_unregister(netdev);
+#endif
+
+	return mbox_err;
 }
 
 static netdev_tx_t rvu_rep_xmit(struct sk_buff *skb, struct net_device *dev)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index 426a42011930..b51d8d2d01b8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -4,18 +4,555 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/route.h>
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
 #include "sw_nb.h"
+#include "sw_fdb.h"
+#include "sw_fib.h"
+#include "sw_fl.h"
+#include "sw_nb_v4.h"
+#include "sw_nb_v6.h"
 
 #if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
 
-int otx2_sw_nb_unregister(void)
+/* PF netdev for netdev_* logging when notifier info has no device */
+static struct net_device *sw_nb_pf_netdev;
+/* Notifier registration is toggled only from rvu_eswitch_config(), which is
+ * reached exclusively when switchdev mode is enabled on the RVU eswitch
+ * representor PF (PCI_DEVID_RVU_REP). The sole call path is:
+ *
+ *   DEVLINK_CMD_ESWITCH_MODE_SET
+ *     -> otx2_devlink_eswitch_mode_set()  [otx2_rep_dev() only]
+ *       -> rvu_rep_create() / rvu_rep_destroy()
+ *         -> rvu_eswitch_config(ena = 1) -> otx2_sw_nb_register()
+ *         -> rvu_eswitch_config(ena = 0) -> otx2_sw_nb_unregister()
+ *
+ * On disable, otx2_sw_nb_unregister() runs before the ESW_CFG mailbox so flush
+ * paths in sw_fdb/fib/fl_deinit() can still reach hardware.
+ *
+ * Other OcteonTX2 netdev PFs/VFs also have a devlink, but their
+ * eswitch_mode_set handler returns -EOPNOTSUPP. The AF rvu_devlink
+ * eswitch_mode_set does not register these notifiers. There is exactly
+ * one RVU_REP PCI function (and netdev devlink) per RVU, and devlink
+ * core holds devlink->lock for the full DEVLINK_CMD_ESWITCH_MODE_SET
+ * handler, so this path cannot run concurrently on the same device.
+ * otx2_sw_nb_registered further ensures at most one active registration.
+ */
+static bool otx2_sw_nb_registered;
+
+static const char *sw_nb_cmd2str[OTX2_CMD_MAX] = {
+	[OTX2_DEV_UP]  = "OTX2_DEV_UP",
+	[OTX2_DEV_DOWN] = "OTX2_DEV_DOWN",
+	[OTX2_DEV_CHANGE] = "OTX2_DEV_CHANGE",
+	[OTX2_NEIGH_UPDATE] = "OTX2_NEIGH_UPDATE",
+	[OTX2_FIB_ENTRY_REPLACE] = "OTX2_FIB_ENTRY_REPLACE",
+	[OTX2_FIB_ENTRY_ADD] = "OTX2_FIB_ENTRY_ADD",
+	[OTX2_FIB_ENTRY_DEL] = "OTX2_FIB_ENTRY_DEL",
+	[OTX2_FIB_ENTRY_APPEND] = "OTX2_FIB_ENTRY_APPEND",
+};
+
+const char *sw_nb_get_cmd2str(int cmd)
+{
+	return sw_nb_cmd2str[cmd];
+}
+EXPORT_SYMBOL(sw_nb_get_cmd2str);
+
+bool sw_nb_is_cavium_dev(struct net_device *netdev)
+{
+	struct pci_dev *pdev;
+	struct device *dev;
+
+	dev = netdev->dev.parent;
+	if (!dev || dev->bus != &pci_bus_type)
+		return false;
+
+	pdev = to_pci_dev(dev);
+	if (pdev->vendor != PCI_VENDOR_ID_CAVIUM)
+		return false;
+
+	return true;
+}
+
+/* Resolve the Cavium PF netdev used to reach the switch AF for offload.
+ *
+ * For a bridge master netdev, any Cavium netdev enslaved to the bridge is
+ * sufficient: callers only need a PF netdev to obtain the switch AF mailbox
+ * context (pcifunc). Bridge-specific information is tagged separately in
+ * the offload entry (entry->bridge), so walking every lower netdev is not
+ * required here.
+ *
+ * Only a single level of netdev nesting is resolved (bridge lower dev or
+ * VLAN real dev). Nested topologies such as VLAN-over-bridge are not
+ * supported; offload will not work for those configurations.
+ */
+struct net_device *sw_nb_resolve_pf_dev(struct net_device *dev)
+{
+	struct net_device *pf_dev = dev;
+	struct list_head *iter;
+
+	rcu_read_lock();
+
+	if (netif_is_bridge_master(dev)) {
+		iter = &dev->adj_list.lower;
+		pf_dev = netdev_next_lower_dev_rcu(dev, &iter);
+		if (!pf_dev)
+			pf_dev = dev;
+	} else if (is_vlan_dev(dev)) {
+		pf_dev = vlan_dev_real_dev(dev);
+	}
+
+	rcu_read_unlock();
+
+	if (!sw_nb_is_cavium_dev(pf_dev))
+		return NULL;
+
+	return pf_dev;
+}
+
+static int sw_nb_check_slaves(struct net_device *dev,
+			      struct netdev_nested_priv *priv)
 {
+	int *cnt;
+
+	if (!priv->flags)
+		return 0;
+
+	priv->flags &= sw_nb_is_cavium_dev(dev);
+	if (priv->flags) {
+		cnt = priv->data;
+		(*cnt)++;
+	}
+
 	return 0;
 }
 
-int otx2_sw_nb_register(void)
+/* Switch offload has no network namespace support. The global notifiers
+ * registered below are not scoped to a netns, and sw_nb_is_cavium_dev()
+ * matches any Cavium PCI netdev without checking dev_net(). All netdevs
+ * involved in offload (PF/VF ports, bridge members, VLANs, neighbours,
+ * and routes) must therefore reside in &init_net for offload to work.
+ */
+bool sw_nb_is_valid_dev(struct net_device *netdev)
+{
+	struct netdev_nested_priv priv;
+	struct net_device *br;
+	int cnt = 0;
+	bool valid;
+
+	priv.flags = true;
+	priv.data = &cnt;
+
+	rcu_read_lock();
+
+	if (netif_is_bridge_master(netdev) || is_vlan_dev(netdev)) {
+		netdev_walk_all_lower_dev_rcu(netdev, sw_nb_check_slaves, &priv);
+		valid = priv.flags && cnt;
+		rcu_read_unlock();
+		return valid;
+	}
+
+	if (netif_is_bridge_port(netdev)) {
+		br = netdev_master_upper_dev_get_rcu(netdev);
+		if (!br) {
+			rcu_read_unlock();
+			return false;
+		}
+		netdev_walk_all_lower_dev_rcu(br, sw_nb_check_slaves, &priv);
+		valid = priv.flags && cnt;
+		rcu_read_unlock();
+		return valid;
+	}
+
+	rcu_read_unlock();
+
+	return sw_nb_is_cavium_dev(netdev);
+}
+
+static int sw_nb_fdb_event(struct notifier_block *unused,
+			   unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		if (fdb_info->is_local)
+			break;
+		break;
+
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		if (fdb_info->is_local)
+			break;
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_fdb = {
+	.notifier_call = sw_nb_fdb_event,
+};
+
+static void __maybe_unused
+sw_nb_fib_event_dump(unsigned long event, void *ptr)
+{
+	struct fib_entry_notifier_info *fen_info = ptr;
+	struct net_device *log_dev;
+	struct fib_nh *fib_nh;
+	struct fib_info *fi;
+	int i;
+
+	fi = fen_info->fi;
+	log_dev = (fi && fi->fib_nhs) ? fi->fib_nh->fib_nh_dev : sw_nb_pf_netdev;
+	if (log_dev)
+		netdev_info(log_dev, "%s: FIB event=%lu dst=%pI4h dstlen=%d type=%u\n",
+			    __func__, event, &fen_info->dst, fen_info->dst_len,
+			    fen_info->type);
+
+	if (!fi)
+		return;
+
+	fib_nh = fi->fib_nh;
+	for (i = 0; i < fi->fib_nhs; i++, fib_nh++) {
+		if (!fib_nh->fib_nh_dev)
+			continue;
+		netdev_info(fib_nh->fib_nh_dev,
+			    "%s: dev=%s saddr=%pI4n gw=%pI4n\n",
+			    __func__, fib_nh->fib_nh_dev->name,
+			    &fib_nh->nh_saddr, &fib_nh->fib_nh_gw4);
+	}
+}
+
+#define SWITCH_NB_FIB_EVENT_DUMP(...) \
+	sw_nb_fib_event_dump(__VA_ARGS__)
+
+int sw_nb_fib_event_to_otx2_event(int event, struct net_device *netdev)
+{
+	switch (event) {
+	case FIB_EVENT_ENTRY_REPLACE:
+		return OTX2_FIB_ENTRY_REPLACE;
+	case FIB_EVENT_ENTRY_ADD:
+		return OTX2_FIB_ENTRY_ADD;
+	case FIB_EVENT_ENTRY_DEL:
+		return OTX2_FIB_ENTRY_DEL;
+	default:
+		break;
+	}
+
+	netdev_err(netdev, "Wrong FIB event %d\n", event);
+	return -1;
+}
+
+static int sw_nb_fib_event(struct notifier_block *nb,
+			   unsigned long event, void *ptr)
+{
+	struct fib_notifier_info *info = ptr;
+
+	switch (event) {
+	case FIB_EVENT_ENTRY_REPLACE:
+	case FIB_EVENT_ENTRY_ADD:
+	case FIB_EVENT_ENTRY_DEL:
+		break;
+	default:
+		if (sw_nb_pf_netdev)
+			netdev_dbg(sw_nb_pf_netdev,
+				   "%s: Won't process FIB event %lu\n",
+				   __func__, event);
+		return NOTIFY_DONE;
+	}
+
+	switch (info->family) {
+	case AF_INET:
+		return sw_nb_v4_fib_event(nb, event, ptr);
+#if IS_REACHABLE(CONFIG_IPV6)
+	case AF_INET6:
+		return sw_nb_v6_fib_event(nb, event, ptr);
+#endif
+	default:
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_fib = {
+	.notifier_call = sw_nb_fib_event,
+};
+
+static int sw_nb_net_event(struct notifier_block *nb,
+			   unsigned long event, void *ptr)
+{
+	struct neighbour *n = ptr;
+
+	if (!sw_nb_is_valid_dev(n->dev))
+		return NOTIFY_DONE;
+
+	if (event != NETEVENT_NEIGH_UPDATE)
+		return NOTIFY_DONE;
+
+	switch (n->tbl->family) {
+	case AF_INET:
+		return sw_nb_net_v4_neigh_update(nb, event, ptr);
+#if IS_REACHABLE(CONFIG_IPV6)
+	case AF_INET6:
+		return sw_nb_net_v6_neigh_update(nb, event, ptr);
+#endif
+	default:
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_netevent = {
+	.notifier_call = sw_nb_net_event,
+
+};
+
+int sw_nb_inetaddr_event_to_otx2_event(int event, struct net_device *netdev)
+{
+	switch (event) {
+	case NETDEV_CHANGE:
+		return OTX2_DEV_CHANGE;
+	case NETDEV_UP:
+		return OTX2_DEV_UP;
+	case NETDEV_DOWN:
+		return OTX2_DEV_DOWN;
+	default:
+		break;
+	}
+	netdev_dbg(netdev, "%s: Wrong interaddr event %d\n",
+		   __func__, event);
+	return -1;
+}
+
+static struct notifier_block sw_nb_v4_inetaddr = {
+	.notifier_call = sw_nb_v4_inetaddr_event,
+};
+
+#if IS_REACHABLE(CONFIG_IPV6)
+static struct notifier_block sw_nb_v6_inetaddr = {
+	.notifier_call = sw_nb_v6_inetaddr_event,
+};
+#endif
+
+static int sw_nb_netdev_event(struct notifier_block *unused,
+			      unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct in_device *idev;
+	struct inet6_dev *i6dev;
+
+	if (event != NETDEV_CHANGE &&
+	    event != NETDEV_UP &&
+	    event != NETDEV_DOWN) {
+		return NOTIFY_DONE;
+	}
+
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	idev = __in_dev_get_rtnl(dev);
+	if (idev)
+		sw_nb_v4_netdev_event(unused, event, ptr);
+
+#if IS_REACHABLE(CONFIG_IPV6)
+	i6dev = __in6_dev_get(dev);
+	if (i6dev)
+		sw_nb_v6_netdev_event(unused, event, ptr);
+#endif
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_netdev = {
+	.notifier_call = sw_nb_netdev_event,
+};
+
+int otx2_sw_nb_unregister(struct net_device *netdev)
+{
+	int err, ret = 0;
+
+	if (!otx2_sw_nb_registered)
+		return 0;
+
+	err = unregister_switchdev_notifier(&sw_nb_fdb);
+	if (err) {
+		netdev_err(netdev, "Failed to unregister switchdev nb\n");
+		ret = err;
+	}
+
+	err = unregister_fib_notifier(&init_net, &sw_nb_fib);
+	if (err) {
+		netdev_err(netdev, "Failed to unregister fib nb\n");
+		if (!ret)
+			ret = err;
+	}
+
+	err = unregister_netevent_notifier(&sw_nb_netevent);
+	if (err) {
+		netdev_err(netdev, "Failed to unregister netevent\n");
+		if (!ret)
+			ret = err;
+	}
+
+	err = unregister_inetaddr_notifier(&sw_nb_v4_inetaddr);
+	if (err) {
+		netdev_err(netdev, "Failed to unregister addr event\n");
+		if (!ret)
+			ret = err;
+	}
+
+#if IS_REACHABLE(CONFIG_IPV6)
+	err = unregister_inet6addr_notifier(&sw_nb_v6_inetaddr);
+	if (err) {
+		netdev_err(netdev, "Failed to unregister addr event\n");
+		if (!ret)
+			ret = err;
+	}
+#endif
+
+	err = unregister_netdevice_notifier(&sw_nb_netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to unregister netdev notifier\n");
+		if (!ret)
+			ret = err;
+	}
+
+	sw_fl_deinit();
+	otx2_sw_fib_deinit();
+	sw_fdb_deinit();
+
+	sw_nb_pf_netdev = NULL;
+	otx2_sw_nb_registered = false;
+
+	return ret;
+}
+EXPORT_SYMBOL(otx2_sw_nb_unregister);
+
+/* Concurrent registration from multiple devlink instances cannot occur on a
+ * given RVU: only the RVU_REP netdev devlink reaches this function (see
+ * comment above). The AF and PF/VF devlinks do not call otx2_sw_nb_register(),
+ * and their eswitch_mode_set handlers return -EOPNOTSUPP. devlink core
+ * holds devlink->lock for the full DEVLINK_CMD_ESWITCH_MODE_SET handler,
+ * so two threads cannot enter here concurrently on that single rep devlink.
+ * A second call after successful registration returns -EBUSY before any
+ * notifier or workqueue state is modified.
+ */
+int otx2_sw_nb_register(struct net_device *netdev)
 {
+	int err;
+
+	/* Notifier blocks are global and only one RVU_REP may register at a
+	 * time (switch offload is init_net-wide; see comment at file top).
+	 * A second RVU card gets -EBUSY here by design.  Concurrent calls on
+	 * the same RVU_REP cannot happen: only that netdev's devlink reaches
+	 * this function (otx2_rep_dev()), and devlink core holds
+	 * devlink->lock for the full DEVLINK_CMD_ESWITCH_MODE_SET handler.
+	 * No extra lock is needed to protect the notifier chains.
+	 */
+	if (otx2_sw_nb_registered)
+		return -EBUSY;
+
+	sw_nb_pf_netdev = netdev;
+
+	err = sw_fdb_init();
+	if (err)
+		goto err_clear;
+
+	err = otx2_sw_fib_init();
+	if (err)
+		goto err_fdb;
+
+	err = sw_fl_init();
+	if (err)
+		goto err_fib;
+
+	err = register_switchdev_notifier(&sw_nb_fdb);
+	if (err) {
+		netdev_err(netdev, "Failed to register switchdev nb\n");
+		goto err_helpers;
+	}
+
+	err = register_fib_notifier(&init_net, &sw_nb_fib, NULL, NULL);
+	if (err) {
+		netdev_err(netdev, "Failed to register fb notifier block\n");
+		goto err1;
+	}
+
+	err = register_netevent_notifier(&sw_nb_netevent);
+	if (err) {
+		netdev_err(netdev, "Failed to register netevent\n");
+		goto err2;
+	}
+
+#if IS_REACHABLE(CONFIG_IPV6)
+	err = register_inet6addr_notifier(&sw_nb_v6_inetaddr);
+	if (err) {
+		netdev_err(netdev, "Failed to register addr event\n");
+		goto err3;
+	}
+#endif
+
+	err = register_inetaddr_notifier(&sw_nb_v4_inetaddr);
+	if (err) {
+		netdev_err(netdev, "Failed to register addr event\n");
+		goto err4;
+	}
+
+	err = register_netdevice_notifier(&sw_nb_netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to register netdevice nb\n");
+		goto err5;
+	}
+
+	otx2_sw_nb_registered = true;
+
 	return 0;
+
+err5:
+	unregister_inetaddr_notifier(&sw_nb_v4_inetaddr);
+
+err4:
+#if IS_REACHABLE(CONFIG_IPV6)
+	unregister_inet6addr_notifier(&sw_nb_v6_inetaddr);
+
+err3:
+#endif
+	unregister_netevent_notifier(&sw_nb_netevent);
+
+err2:
+	unregister_fib_notifier(&init_net, &sw_nb_fib);
+
+err1:
+	unregister_switchdev_notifier(&sw_nb_fdb);
+
+err_helpers:
+	sw_fl_deinit();
+err_fib:
+	otx2_sw_fib_deinit();
+err_fdb:
+	sw_fdb_deinit();
+err_clear:
+	sw_nb_pf_netdev = NULL;
+	return err;
 }
+EXPORT_SYMBOL(otx2_sw_nb_register);
 
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
index 0ba29f76fd41..39435f23427c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
@@ -9,12 +9,41 @@
 
 #include <linux/kconfig.h>
 
+struct net_device;
+struct otx2_nic;
+struct af2pf_fdb_refresh_req;
+struct msg_rsp;
+
 #if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
-int otx2_sw_nb_register(void);
-int otx2_sw_nb_unregister(void);
+enum {
+	OTX2_DEV_UP = 1,
+	OTX2_DEV_DOWN,
+	OTX2_DEV_CHANGE,
+	OTX2_NEIGH_UPDATE,
+	OTX2_FIB_ENTRY_REPLACE,
+	OTX2_FIB_ENTRY_ADD,
+	OTX2_FIB_ENTRY_DEL,
+	OTX2_FIB_ENTRY_APPEND,
+	OTX2_CMD_MAX,
+};
+
+int otx2_sw_nb_register(struct net_device *netdev);
+int otx2_sw_nb_unregister(struct net_device *netdev);
+bool sw_nb_is_valid_dev(struct net_device *netdev);
+struct net_device *sw_nb_resolve_pf_dev(struct net_device *dev);
+
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp);
+
+bool sw_nb_is_cavium_dev(struct net_device *netdev);
+int sw_nb_fib_event_to_otx2_event(int event, struct net_device *netdev);
+int sw_nb_inetaddr_event_to_otx2_event(int event, struct net_device *netdev);
+
+const char *sw_nb_get_cmd2str(int cmd);
 #else
-static inline int otx2_sw_nb_register(void) { return 0; }
-static inline int otx2_sw_nb_unregister(void) { return 0; }
+static inline int otx2_sw_nb_register(struct net_device *netdev) { return 0; }
+static inline int otx2_sw_nb_unregister(struct net_device *netdev) { return 0; }
 #endif
 
 #endif /* SW_NB_H_ */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
new file mode 100644
index 000000000000..31009e00121f
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/route.h>
+#include <linux/inetdevice.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
+#include "sw_fdb.h"
+#include "sw_fib.h"
+#include "sw_fl.h"
+#include "sw_nb_v4.h"
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+
+int sw_nb_v4_netdev_event(struct notifier_block *unused,
+			  unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_hw_addr *dev_addr;
+	struct net_device *pf_dev;
+	struct in_device *idev;
+	struct in_ifaddr *ifa;
+	struct fib_entry *entry;
+	struct otx2_nic *pf;
+
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	idev = __in_dev_get_rtnl(dev);
+	if (!idev || !idev->ifa_list)
+		return NOTIFY_DONE;
+
+	/* Switch offload supports a single IPv4 address per interface for now. */
+	ifa = rtnl_dereference(idev->ifa_list);
+
+	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NOTIFY_DONE;
+
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);
+	entry->dst = ifa->ifa_address;
+	entry->dst_len = 32;
+	entry->mac_valid = 1;
+	entry->host = 1;
+
+	pf_dev = sw_nb_resolve_pf_dev(dev);
+	if (!pf_dev) {
+		kfree(entry);
+		return NOTIFY_DONE;
+	}
+
+	if (netif_is_bridge_master(dev)) {
+		entry->bridge = 1;
+	} else if (is_vlan_dev(dev)) {
+		entry->vlan_valid = 1;
+		entry->vlan_tag = cpu_to_be16(vlan_dev_vlan_id(dev));
+	}
+
+	pf = netdev_priv(pf_dev);
+	entry->port_id = pf->pcifunc;
+
+	rcu_read_lock();
+	for_each_dev_addr(dev, dev_addr) {
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		break;
+	}
+	rcu_read_unlock();
+
+	netdev_dbg(dev, "%s: pushing netdev event from HOST interface address %pI4n, %pM, dev=%s\n",
+		   __func__, &entry->dst, entry->mac, dev->name);
+	kfree(entry);
+
+	return NOTIFY_DONE;
+}
+
+int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
+			    unsigned long event, void *ptr)
+{
+	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
+	struct net_device *dev = ifa->ifa_dev->dev;
+	struct netdev_hw_addr *dev_addr;
+	struct net_device *pf_dev;
+	struct fib_entry *entry;
+	struct otx2_nic *pf;
+
+	if (event != NETDEV_CHANGE &&
+	    event != NETDEV_UP &&
+	    event != NETDEV_DOWN) {
+		return NOTIFY_DONE;
+	}
+
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	/* On NETDEV_DOWN the deleted address is passed in ifa; ifa_list may
+	 * already be empty when the last address is removed.
+	 */
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return NOTIFY_DONE;
+
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);
+	entry->dst = ifa->ifa_address;
+	entry->dst_len = 32;
+	entry->mac_valid = 1;
+	entry->host = 1;
+
+	pf_dev = sw_nb_resolve_pf_dev(dev);
+	if (!pf_dev) {
+		kfree(entry);
+		return NOTIFY_DONE;
+	}
+
+	if (netif_is_bridge_master(dev)) {
+		entry->bridge = 1;
+	} else if (is_vlan_dev(dev)) {
+		entry->vlan_valid = 1;
+		entry->vlan_tag = cpu_to_be16(vlan_dev_vlan_id(dev));
+	}
+
+	pf = netdev_priv(pf_dev);
+	entry->port_id = pf->pcifunc;
+
+	rcu_read_lock();
+	for_each_dev_addr(dev, dev_addr) {
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		break;
+	}
+	rcu_read_unlock();
+
+	netdev_dbg(dev, "%s: pushing inetaddr event from HOST interface address %pI4n, %pM, %s\n",
+		   __func__, &entry->dst, entry->mac, dev->name);
+
+	kfree(entry);
+	return NOTIFY_DONE;
+}
+
+int sw_nb_v4_fib_event(struct notifier_block *nb,
+		       unsigned long event, void *ptr)
+{
+	struct net_device *dev, *pf_dev = NULL, *nh_pf_dev;
+	struct fib_entry_notifier_info *fen_info = ptr;
+	struct fib_entry *entries, *iter;
+	struct netdev_hw_addr *dev_addr;
+	struct neighbour *neigh;
+	struct fib_nh *fib_nh;
+	struct fib_info *fi;
+	struct otx2_nic *pf;
+	__be32 *haddr;
+	int hcnt = 0;
+	int cnt, i;
+
+	/* Process only UNICAST routes add or del */
+	if (fen_info->type != RTN_UNICAST)
+		return NOTIFY_DONE;
+
+	fi = fen_info->fi;
+	if (!fi)
+		return NOTIFY_DONE;
+
+	if (fi->fib_nh_is_v6) {
+		struct net_device *log_dev = (fi->fib_nhs > 0) ?
+			fi->fib_nh->fib_nh_dev : NULL;
+
+		if (log_dev)
+			netdev_dbg(log_dev, "%s: Received v6 notification\n",
+				   __func__);
+		return NOTIFY_DONE;
+	}
+
+	/* TODO: External nexthop routes (fi->nh set, fi->fib_nhs == 0) are not
+	 * yet supported for switch offload. Only embedded fi->fib_nh[] paths
+	 * are walked below; nhid and nexthop-group installs are intentionally
+	 * skipped until fib_info_num_path()/fib_info_nhc() handling is added.
+	 */
+	entries = kcalloc(fi->fib_nhs, sizeof(*entries), GFP_ATOMIC);
+	if (!entries)
+		return NOTIFY_DONE;
+
+	haddr = kcalloc(fi->fib_nhs, sizeof(*haddr), GFP_ATOMIC);
+	if (!haddr) {
+		kfree(entries);
+		return NOTIFY_DONE;
+	}
+
+	iter = entries;
+	fib_nh = fi->fib_nh;
+	for (i = 0; i < fi->fib_nhs; i++, fib_nh++) {
+		dev = fib_nh->fib_nh_dev;
+
+		if (!dev)
+			continue;
+
+		if (dev->type != ARPHRD_ETHER)
+			continue;
+
+		if (!sw_nb_is_valid_dev(dev))
+			continue;
+
+		iter->cmd = sw_nb_fib_event_to_otx2_event(event, dev);
+		iter->dst = htonl(fen_info->dst);
+		iter->dst_len = fen_info->dst_len;
+		iter->gw = fib_nh->fib_nh_gw4;
+
+		netdev_dbg(dev, "%s: FIB route Rule cmd=%llu dst=%pI4n dst_len=%u gw=%pI4n\n",
+			   __func__, iter->cmd, &iter->dst, iter->dst_len, &iter->gw);
+
+		nh_pf_dev = sw_nb_resolve_pf_dev(dev);
+		if (!nh_pf_dev)
+			continue;
+		pf_dev = nh_pf_dev;
+
+		if (netif_is_bridge_master(dev)) {
+			iter->bridge = 1;
+		} else if (is_vlan_dev(dev)) {
+			iter->vlan_valid = 1;
+			iter->vlan_tag = cpu_to_be16(vlan_dev_vlan_id(dev));
+		}
+
+		pf = netdev_priv(pf_dev);
+		iter->port_id = pf->pcifunc;
+
+		/* Point-to-point routes, including default routes with no
+		 * gateway, are not supported for switch offload.
+		 */
+		if (!fib_nh->fib_nh_gw4)
+			continue;
+		iter->gw_valid = 1;
+
+		if (fib_nh->nh_saddr)
+			haddr[hcnt++] = fib_nh->nh_saddr;
+
+		rcu_read_lock();
+		neigh = ip_neigh_gw4(fib_nh->fib_nh_dev, fib_nh->fib_nh_gw4);
+		if (!neigh || IS_ERR(neigh)) {
+			rcu_read_unlock();
+			continue;
+		}
+
+		neigh_ha_snapshot(iter->mac, neigh, fib_nh->fib_nh_dev);
+		if (is_valid_ether_addr(iter->mac))
+			iter->mac_valid = 1;
+
+		iter++;
+		rcu_read_unlock();
+	}
+
+	cnt = iter - entries;
+	if (!cnt) {
+		kfree(entries);
+		kfree(haddr);
+		return NOTIFY_DONE;
+	}
+
+	if (pf_dev)
+		netdev_dbg(pf_dev, "pf_dev is %s cnt=%d\n", pf_dev->name, cnt);
+	kfree(entries);
+
+	if (!hcnt) {
+		kfree(haddr);
+		return NOTIFY_DONE;
+	}
+
+	if (!pf_dev) {
+		kfree(haddr);
+		return NOTIFY_DONE;
+	}
+
+	entries = kcalloc(hcnt, sizeof(*entries), GFP_ATOMIC);
+	if (!entries) {
+		kfree(haddr);
+		return NOTIFY_DONE;
+	}
+
+	iter = entries;
+
+	/* Host routes reuse pf_dev/pf from the last resolved Cavium netdev:
+	 * pf_dev only identifies the switch AF mailbox context for switchdev
+	 * programming; any previously resolved Cavium netdev is sufficient.
+	 */
+	for (i = 0; i < hcnt; i++, iter++) {
+		iter->cmd = sw_nb_fib_event_to_otx2_event(event, pf_dev);
+		iter->dst = haddr[i];
+		iter->dst_len = 32;
+		iter->mac_valid = 1;
+		iter->host = 1;
+		iter->port_id = pf->pcifunc;
+
+		rcu_read_lock();
+		for_each_dev_addr(pf_dev, dev_addr) {
+			ether_addr_copy(iter->mac, dev_addr->addr);
+			break;
+		}
+		rcu_read_unlock();
+
+		netdev_dbg(pf_dev, "%s: FIB host Rule cmd=%llu dst=%pI4n dst_len=%u %s\n",
+			   __func__, iter->cmd, &iter->dst, iter->dst_len,
+			   pf_dev->name);
+	}
+	kfree(entries);
+	kfree(haddr);
+	return NOTIFY_DONE;
+}
+
+int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
+			      unsigned long event, void *ptr)
+{
+	struct net_device *pf_dev;
+	struct neighbour *n = ptr;
+	struct fib_entry *entry;
+	struct otx2_nic *pf;
+
+	if (n->tbl != &arp_tbl)
+		return NOTIFY_DONE;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return NOTIFY_DONE;
+
+	entry->cmd = OTX2_NEIGH_UPDATE;
+	entry->dst = *(__be32 *)n->primary_key;
+	entry->dst_len = n->tbl->key_len * 8;
+	entry->mac_valid = 1;
+	entry->nud_state = n->nud_state;
+	neigh_ha_snapshot(entry->mac, n, n->dev);
+
+	pf_dev = sw_nb_resolve_pf_dev(n->dev);
+	if (!pf_dev) {
+		kfree(entry);
+		return NOTIFY_DONE;
+	}
+
+	if (netif_is_bridge_master(n->dev)) {
+		entry->bridge = 1;
+	} else if (is_vlan_dev(n->dev)) {
+		entry->vlan_valid = 1;
+		entry->vlan_tag = cpu_to_be16(vlan_dev_vlan_id(n->dev));
+	}
+
+	pf = netdev_priv(pf_dev);
+	entry->port_id = pf->pcifunc;
+
+	kfree(entry);
+	return NOTIFY_DONE;
+}
+
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.h
new file mode 100644
index 000000000000..c6dbf4b93a9a
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_NB_V4_H_
+#define SW_NB_V4_H_
+
+int sw_nb_v4_fib_event(struct notifier_block *nb,
+		       unsigned long event, void *ptr);
+
+int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
+			      unsigned long event, void *ptr);
+
+int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
+			    unsigned long event, void *ptr);
+
+int sw_nb_v4_netdev_event(struct notifier_block *unused,
+			  unsigned long event, void *ptr);
+#endif // SW_NB_V4_H__
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
new file mode 100644
index 000000000000..3497e60aedbe
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/route.h>
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+#include <net/ip6_fib.h>
+#include <net/nexthop.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
+#include "sw_fdb.h"
+#include "sw_fib.h"
+#include "sw_fl.h"
+#include "sw_nb_v6.h"
+
+#if IS_ENABLED(CONFIG_IPV6) && IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+
+int sw_nb_v6_netdev_event(struct notifier_block *unused,
+			  unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_hw_addr *dev_addr;
+	struct net_device *pf_dev;
+	struct inet6_ifaddr *ifp;
+	struct inet6_dev *i6dev;
+	struct fib_entry *entry;
+	struct in6_addr addr;
+	struct otx2_nic *pf;
+	bool found = false;
+	u32 prefix_len;
+
+	i6dev = __in6_dev_get(dev);
+	if (!i6dev)
+		return NOTIFY_DONE;
+
+	/* addr_list is RCU-protected; hold rcu_read_lock() while walking it.
+	 * Address updates from SLAAC/DAD may occur under idev->lock without
+	 * RTNL, so the list must be read with an RCU-safe helper.
+	 */
+	rcu_read_lock();
+	/* Switch offload supports a single IPv6 address per interface for now.
+	 * Skip link-local entries and use the first global address on the list.
+	 */
+	list_for_each_entry_rcu(ifp, &i6dev->addr_list, if_list) {
+		if (ipv6_addr_type(&ifp->addr) & IPV6_ADDR_LINKLOCAL)
+			continue;
+
+		addr = ifp->addr;
+		prefix_len = ifp->prefix_len;
+		found = true;
+		break;
+	}
+	rcu_read_unlock();
+
+	if (!found)
+		return NOTIFY_DONE;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NOTIFY_DONE;
+
+	pf_dev = sw_nb_resolve_pf_dev(dev);
+	if (!pf_dev) {
+		kfree(entry);
+		return NOTIFY_DONE;
+	}
+
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);
+	memcpy(entry->dst6, &addr, sizeof(entry->dst6));
+	entry->dst6_plen = prefix_len;
+	entry->host = 1;
+	entry->ipv6 = 1;
+
+	pf = netdev_priv(pf_dev);
+	entry->port_id = pf->pcifunc;
+
+	rcu_read_lock();
+	for_each_dev_addr(dev, dev_addr) {
+		entry->mac_valid = 1;
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		break;
+	}
+	rcu_read_unlock();
+
+	netdev_dbg(dev, "netdev event addr=%pI6c plen=%u mac=%pM\n",
+		   &addr, prefix_len, entry->mac);
+	kfree(entry);
+	return NOTIFY_DONE;
+}
+
+int sw_nb_v6_fib_event(struct notifier_block *nb,
+		       unsigned long event, void *ptr)
+{
+	struct fib6_entry_notifier_info *f6_eni;
+	struct fib_notifier_info *info = ptr;
+	struct net_device *fib_dev, *pf_dev;
+	struct fib_entry *entry;
+	struct fib6_info *f6i;
+	struct neighbour *neigh;
+	struct fib6_nh *nh6;
+	struct rt6key *key;
+	struct otx2_nic *pf;
+
+	f6_eni = container_of(info, struct fib6_entry_notifier_info, info);
+	f6i = f6_eni->rt;
+
+	fib_dev = fib6_info_nh_dev(f6i);
+
+	if (!fib_dev)
+		return NOTIFY_DONE;
+
+	if (fib_dev->type != ARPHRD_ETHER)
+		return NOTIFY_DONE;
+
+	if (!sw_nb_is_valid_dev(fib_dev))
+		return NOTIFY_DONE;
+
+	if (f6i->fib6_type != RTN_UNICAST)
+		return NOTIFY_DONE;
+
+	key = &f6i->fib6_dst;
+	/* TODO: vlan and bridge support */
+	if (ipv6_addr_type(&key->addr) & IPV6_ADDR_LINKLOCAL)
+		return NOTIFY_DONE;
+
+	netdev_dbg(fib_dev, "fib6dst rt6key.addr=%pI6c len=%d\n", &key->addr,
+		   key->plen);
+
+	netdev_dbg(fib_dev, "fib6flags=%#x proto=%u type=%u\n",
+		   f6i->fib6_flags, f6i->fib6_protocol, f6i->fib6_type);
+
+	nh6 = f6i->nh ? nexthop_fib6_nh(f6i->nh) : f6i->fib6_nh;
+	if (nh6->fib_nh_gw_family != AF_INET6)
+		return NOTIFY_DONE;
+
+	netdev_dbg(nh6->fib_nh_dev ? nh6->fib_nh_dev : fib_dev,
+		   "nh family=%u dev=%s  gw=%pI6c gwfamily=%u\n",
+		   nh6->fib_nh_family,
+		   nh6->fib_nh_dev ? nh6->fib_nh_dev->name : "No dev",
+		   &nh6->fib_nh_gw6, nh6->fib_nh_gw_family);
+
+	pf_dev = sw_nb_resolve_pf_dev(fib_dev);
+	if (!pf_dev)
+		return NOTIFY_DONE;
+
+	pf = netdev_priv(pf_dev);
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return NOTIFY_DONE;
+
+	entry->cmd = sw_nb_fib_event_to_otx2_event(event, fib_dev);
+	entry->ipv6 = 1;
+	entry->port_id = pf->pcifunc;
+	memcpy(entry->dst6, &key->addr, sizeof(entry->dst6));
+	entry->dst6_plen = key->plen;
+
+	memcpy(entry->gw6, &nh6->fib_nh_gw6, sizeof(nh6->fib_nh_gw6));
+	entry->gw_valid = !!(ipv6_addr_type(&nh6->fib_nh_gw6) & IPV6_ADDR_UNICAST);
+
+	/* TODO: No replay mechanism yet when the gateway neighbor is unresolved.
+	 * If ip_neigh_gw6() returns NULL the route is skipped here; add replay
+	 * from the neighbor update handler once nexthop resolution completes.
+	 */
+	rcu_read_lock();
+	neigh = ip_neigh_gw6(fib_dev, &nh6->fib_nh_gw6);
+	if (!neigh || IS_ERR(neigh)) {
+		rcu_read_unlock();
+		kfree(entry);
+		return NOTIFY_DONE;
+	}
+
+	neigh_ha_snapshot(entry->mac, neigh, fib_dev);
+	if (is_valid_ether_addr(entry->mac)) {
+		entry->mac_valid = 1;
+		netdev_dbg(fib_dev, "fib found MAC=%pM\n", entry->mac);
+	}
+
+	rcu_read_unlock();
+	kfree(entry);
+
+	return NOTIFY_DONE;
+}
+
+int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
+			      unsigned long event, void *ptr)
+{
+	struct net_device *pf_dev;
+	struct neighbour *n = ptr;
+	struct fib_entry *entry;
+	struct otx2_nic *pf;
+
+	if (n->tbl != &nd_tbl)
+		return NOTIFY_DONE;
+
+	if (ipv6_addr_type((struct in6_addr *)n->primary_key) & IPV6_ADDR_LINKLOCAL)
+		return NOTIFY_DONE;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return NOTIFY_DONE;
+
+	pf_dev = sw_nb_resolve_pf_dev(n->dev);
+	if (!pf_dev) {
+		kfree(entry);
+		return NOTIFY_DONE;
+	}
+
+	pf = netdev_priv(pf_dev);
+
+	entry->cmd = OTX2_NEIGH_UPDATE;
+	entry->dst6_plen = n->tbl->key_len * 8;
+	memcpy(entry->dst6, (struct in6_addr *)n->primary_key,
+	       sizeof(entry->dst6));
+	entry->ipv6 = 1;
+	entry->nud_state = n->nud_state;
+	neigh_ha_snapshot(entry->mac, n, n->dev);
+	entry->mac_valid = 1;
+	entry->port_id = pf->pcifunc;
+
+	netdev_dbg(n->dev, "v6 neigh update %pI6c mac=%pM plen=%u\n",
+		   (struct in6_addr *)n->primary_key, entry->mac,
+		   n->tbl->key_len * 8);
+	kfree(entry);
+
+	return NOTIFY_DONE;
+}
+
+int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
+			    unsigned long event, void *ptr)
+{
+	struct inet6_ifaddr *ifa6 = (struct inet6_ifaddr *)ptr;
+	struct net_device *dev = ifa6->idev->dev;
+	struct netdev_hw_addr *dev_addr;
+	struct net_device *pf_dev;
+	struct fib_entry *entry;
+	struct otx2_nic *pf;
+
+	if (event != NETDEV_CHANGE &&
+	    event != NETDEV_UP &&
+	    event != NETDEV_DOWN) {
+		return NOTIFY_DONE;
+	}
+
+	if (dev->type != ARPHRD_ETHER)
+		return NOTIFY_DONE;
+
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	if (ipv6_addr_type(&ifa6->addr) & IPV6_ADDR_LINKLOCAL)
+		return NOTIFY_DONE;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return NOTIFY_DONE;
+
+	pf_dev = sw_nb_resolve_pf_dev(dev);
+	if (!pf_dev) {
+		kfree(entry);
+		return NOTIFY_DONE;
+	}
+
+	pf = netdev_priv(pf_dev);
+
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);
+	memcpy(entry->dst6, &ifa6->addr, sizeof(entry->dst6));
+	entry->dst6_plen = ifa6->prefix_len;
+	entry->mac_valid = 1;
+	entry->host = 1;
+	entry->ipv6 = 1;
+	entry->port_id = pf->pcifunc;
+
+	rcu_read_lock();
+	for_each_dev_addr(dev, dev_addr) {
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		entry->mac_valid = 1;
+		break;
+	}
+	rcu_read_unlock();
+
+	netdev_dbg(dev, "inetaddr addr=%pI6c len=%u %pM\n",
+		   &ifa6->addr, ifa6->prefix_len, entry->mac);
+	kfree(entry);
+
+	return NOTIFY_DONE;
+}
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h
new file mode 100644
index 000000000000..f73efc98c311
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_NB_V6_H_
+#define SW_NB_V6_H_
+
+int sw_nb_v6_fib_event(struct notifier_block *nb,
+		       unsigned long event, void *ptr);
+
+int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
+			      unsigned long event, void *ptr);
+
+int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
+			    unsigned long event, void *ptr);
+
+int sw_nb_v6_netdev_event(struct notifier_block *unused,
+			  unsigned long event, void *ptr);
+#endif // SW_NB_V6_H__
-- 
2.43.0

