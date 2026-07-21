Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309493BB12F;
	Tue, 21 Jul 2026 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621942; cv=none; b=Y+0acQl0L9T+m+fC7Cl+N6teQ1P01jTICfdqIuaO1qTMlSp5VZiVslzdKA2nq0EsySxp5pHKM0K8O6dOaXrwy4RboY6O+yjF/uq7/zX7jSqqpIYjuyUI51uSLm/O4oAsI8wA+NO/rn7+shkYW0saWlp8EzuNDxqKQ+hDvmTGzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621942; c=relaxed/simple;
	bh=/FYO6HCp4iW/JTRfcT6i+tOX9/22tqc8L/4HPgbptYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOH33+0pOTyPAxAWlg7JcCnm75lUIjQH9Z1Rol/6LJkMEzRQdBUfEiVt0BkOPuGApF/zZEZoKKuxXbohypTmcPWTAD5/Ty/3iSOVWwbWpFpKPH4shGWHJKozArwMNgEjaln9u73bAk8wDF8m0Dm5A6RP9j8drfvsD9b6nIHdqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AbDCq40H; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AbDCq40H"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L4Re0G1213770;
	Tue, 21 Jul 2026 01:18:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	Gni0KMoF6Y+5o8iy1x/sDi1OvjTchI1eEnkE+z7VCs=; b=AbDCq40Hg9yVQG343
	JNz5/qD9mYSI/Q0shRg+X0zS5DnVYHFnjLjXaM3yqzNTzeq+4H9V0RrgOb0UWRPH
	075jCstpNEgrDOhfa/uR+bivlR6rlrmKntKqy66o22ddmoDRzod7e3mgFJAuk0sE
	07srgQa5JuIXPycbzHWVx3KCIZvJkt3xA3IXEIFUnSoM1V6SfFAxKJ7AZWQLuqtp
	DvayY3SyctUBNyetu1doJxXrrmI5WTkL30SbqBzSwqmGtLrdOynaNUKdcDWfbjcJ
	roU2GtLjSQIXsPI2v1ZXZvCzLs6Xismxyuds0/RUanR3w7tN1jMJ2qmUG4IxCqXe
	6E53Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fgd7dfsy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 01:18:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 01:18:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 01:18:47 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3920E3F7091;
	Tue, 21 Jul 2026 01:18:45 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net-next 6/9] octeontx2-pf: switch: Register notifiers for switch offload
Date: Tue, 21 Jul 2026 13:48:21 +0530
Message-ID: <20260721081824.1430607-7-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721081824.1430607-1-rkannoth@marvell.com>
References: <20260721081824.1430607-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX9TK2EdE0YqbA
 O+Qim+ArdTDoIxL1IUHeO9TWViZDdlOLGMtg2gcxpKdtgzrtePnSZuuYFTEzD9RfDM0U55ggB/d
 Bk29seiNycV6VBoIGrT5LcJX+lCtzUY=
X-Proofpoint-ORIG-GUID: TyVB8cun6RaY3QpAGgQusgb5m2gqEGDh
X-Proofpoint-GUID: TyVB8cun6RaY3QpAGgQusgb5m2gqEGDh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX9aPDvLoYNU7F
 aeQLHzeDWAdKVC7B2xpT8gRdVJt+BcyC0mbnaWS+xS7Rh2/OUxP9loYZvjmI+acs3Vi1X0Bs/vp
 /1YVe5m/0BeyMdX5znKRUzcMnc7jpU2uJ3XIx+bLPNNIPcEhLtdptInfrpccJuT107iBx8lGmTF
 gVpKss+dO5JdhP5yUzgvfVNgVP3q24pUdbabm4kweshO1EGTo3cenrbE2jfImA+GBgVh1Ffa+fG
 O8wytDdmFF7Vm1uf8pjhr4VfTqkYNUvEYSXMa36mcizYU2Hl67pDJ1TTM9WQeOIkWct+pqK9Wv5
 XQKSKIKEPP8jCq52M65LTD6r13Scpbvx1Cq+YLCNuyUdEoTwbWcXTXb1Mv6f7mtS3ZAA44EVC3D
 lq8u/Mo088p4FZslQsb1LDWMvoszxbPPfy8mKZKJd7CACLU2QDQZJiqdCko+3j2H9LOfn0wJjM7
 /TevGKwvjAPvrLsgBFw==
X-Authority-Analysis: v=2.4 cv=I9tVgtgg c=1 sm=1 tr=0 ts=6a5f2b69 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=on-D7ewkxeXsN44YeIoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01

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
 .../ethernet/marvell/octeontx2/nic/Makefile   |   6 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  38 +-
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 502 +++++++++++++++++-
 .../marvell/octeontx2/nic/switch/sw_nb.h      |  37 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v4.c   | 358 +++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb_v4.h   |  21 +
 .../marvell/octeontx2/nic/switch/sw_nb_v6.c   | 292 ++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb_v6.h   |  21 +
 8 files changed, 1266 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 123b0af23abd..02ab0634f58f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -11,7 +11,11 @@ rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
                otx2_devlink.o qos_sq.o qos.o otx2_xsk.o \
 	       switch/sw_fdb.o switch/sw_fl.o
-rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb.o switch/sw_fib.o
+rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb.o switch/sw_fib.o \
+				       switch/sw_nb_v4.o
+ifneq ($(CONFIG_IPV6),)
+rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb_v6.o
+endif
 
 rvu_nicvf-y := otx2_vf.o
 rvu_rep-y := rep.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 257a2ae6a53e..1900235fabc5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -15,6 +15,7 @@
 #include "cn10k.h"
 #include "otx2_reg.h"
 #include "rep.h"
+#include "switch/sw_nb.h"
 
 #define DRV_NAME	"rvu_rep"
 #define DRV_STRING	"Marvell RVU Representor Driver"
@@ -399,22 +400,55 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 
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
+	if (ena) {
+		err = sw_nb_register(netdev);
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
+			sw_nb_unregister(netdev);
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
+	if (ena && mbox_err) {
+		sw_nb_unregister(netdev);
+		return mbox_err;
+	}
+
+	if (!ena) {
+		err = sw_nb_unregister(netdev);
+		if (err && !mbox_err)
+			return err;
+	}
+#endif
+
+	return mbox_err;
 }
 
 static netdev_tx_t rvu_rep_xmit(struct sk_buff *skb, struct net_device *dev)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index 243611835e3a..8a09876e8297 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -4,18 +4,516 @@
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
 
-int sw_nb_unregister(void)
+/* PF netdev for netdev_* logging when notifier info has no device */
+static struct net_device *sw_nb_pf_netdev;
+/* Notifier registration is only toggled from rvu_eswitch_config(), which is
+ * reached exclusively via otx2_devlink_eswitch_mode_set() on the RVU
+ * representor devlink (otx2_rep_dev()). Devlink holds the per-instance
+ * devlink->lock for the full DEVLINK_CMD_ESWITCH_SET handler (pre_doit
+ * through post_doit), serializing register/unregister on that devlink.
+ * Regular netdev PFs return -EOPNOTSUPP from eswitch_mode_set and never
+ * invoke these helpers, so concurrent devlink changes on other PFs cannot
+ * race on this state.
+ */
+static bool sw_nb_registered;
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
+ */
+struct net_device *sw_nb_resolve_pf_dev(struct net_device *dev)
 {
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
+{
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
 
-int sw_nb_register(void)
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
+		netdev_info(log_dev, "%s: FIB event=%lu dst=%pI4 dstlen=%u type=%u\n",
+			    __func__, event, (const __be32 *)&fen_info->dst,
+			    fen_info->dst_len, fen_info->type);
+
+	if (!fi)
+		return;
+
+	fib_nh = fi->fib_nh;
+	for (i = 0; i < fi->fib_nhs; i++, fib_nh++) {
+		if (!fib_nh->fib_nh_dev)
+			continue;
+		netdev_info(fib_nh->fib_nh_dev,
+			    "%s: dev=%s saddr=%pI4 gw=%pI4\n",
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
+#if IS_ENABLED(CONFIG_IPV6)
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
+#if IS_ENABLED(CONFIG_IPV6)
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
+#if IS_ENABLED(CONFIG_IPV6)
+static struct notifier_block sw_nb_v6_inetaddr = {
+	.notifier_call = sw_nb_v6_inetaddr_event,
+};
+#endif
+
+static int sw_nb_netdev_event(struct notifier_block *unused,
+			      unsigned long event, void *ptr)
 {
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
+#if IS_ENABLED(CONFIG_IPV6)
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
+int sw_nb_unregister(struct net_device *netdev)
+{
+	int err, ret = 0;
+
+	if (!sw_nb_registered)
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
+#if IS_ENABLED(CONFIG_IPV6)
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
+	sw_fib_deinit();
+	sw_fdb_deinit();
+
+	sw_nb_pf_netdev = NULL;
+	sw_nb_registered = false;
+
+	return ret;
+}
+EXPORT_SYMBOL(sw_nb_unregister);
+
+int sw_nb_register(struct net_device *netdev)
+{
+	int err;
+
+	if (sw_nb_registered)
+		return -EBUSY;
+
+	sw_nb_pf_netdev = netdev;
+
+	err = sw_fdb_init();
+	if (err)
+		goto err_clear;
+
+	err = sw_fib_init();
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
+#if IS_ENABLED(CONFIG_IPV6)
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
+	sw_nb_registered = true;
+
 	return 0;
+
+err5:
+	unregister_inetaddr_notifier(&sw_nb_v4_inetaddr);
+
+err4:
+#if IS_ENABLED(CONFIG_IPV6)
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
+	sw_fib_deinit();
+err_fdb:
+	sw_fdb_deinit();
+err_clear:
+	sw_nb_pf_netdev = NULL;
+	return err;
 }
+EXPORT_SYMBOL(sw_nb_register);
 
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
index 73cc1e99b8ec..e995c0e6046b 100644
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
-int sw_nb_register(void);
-int sw_nb_unregister(void);
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
+int sw_nb_register(struct net_device *netdev);
+int sw_nb_unregister(struct net_device *netdev);
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
-static inline int sw_nb_register(void) { return 0; }
-static inline int sw_nb_unregister(void) { return 0; }
+static inline int sw_nb_register(struct net_device *netdev) { return 0; }
+static inline int sw_nb_unregister(struct net_device *netdev) { return 0; }
 #endif
 
 #endif /* SW_NB_H_ */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
new file mode 100644
index 000000000000..c773fce1bc50
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
@@ -0,0 +1,358 @@
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
+	for_each_dev_addr(dev, dev_addr) {
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		break;
+	}
+
+	netdev_dbg(dev, "%s: pushing netdev event from HOST interface address %pI4, %pM, dev=%s\n",
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
+	struct in_device *idev;
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
+	idev = __in_dev_get_rtnl(dev);
+	if (!idev || !idev->ifa_list)
+		return NOTIFY_DONE;
+
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
+	for_each_dev_addr(dev, dev_addr) {
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		break;
+	}
+
+	netdev_dbg(dev, "%s: pushing inetaddr event from HOST interface address %pI4, %pM, %s\n",
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
+		iter->dst = (__force __be32)fen_info->dst;
+		iter->dst_len = fen_info->dst_len;
+		iter->gw = fib_nh->fib_nh_gw4;
+
+		netdev_dbg(dev, "%s: FIB route Rule cmd=%llu dst=%pI4 dst_len=%u gw=%pI4\n",
+			   __func__, iter->cmd, &iter->dst, iter->dst_len, &iter->gw);
+
+		nh_pf_dev = sw_nb_resolve_pf_dev(dev);
+		if (!nh_pf_dev) {
+			iter++;
+			continue;
+		}
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
+		if (!fib_nh->fib_nh_gw4) {
+			if (iter->dst || iter->dst_len)
+				iter++;
+
+			continue;
+		}
+		iter->gw_valid = 1;
+
+		if (fib_nh->nh_saddr)
+			haddr[hcnt++] = fib_nh->nh_saddr;
+
+		rcu_read_lock();
+		neigh = ip_neigh_gw4(fib_nh->fib_nh_dev, fib_nh->fib_nh_gw4);
+		if (!neigh) {
+			rcu_read_unlock();
+			iter++;
+			continue;
+		}
+
+		if (is_valid_ether_addr(neigh->ha)) {
+			iter->mac_valid = 1;
+			neigh_ha_snapshot(iter->mac, neigh, fib_nh->fib_nh_dev);
+		}
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
+		netdev_dbg(pf_dev, "%s: FIB host Rule cmd=%llu dst=%pI4 dst_len=%u gw=%pI4 %s\n",
+			   __func__, iter->cmd, &iter->dst, iter->dst_len, &iter->gw,
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
index 000000000000..62ab00658879
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
@@ -0,0 +1,292 @@
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
+	u32 prefix_len;
+
+	i6dev = __in6_dev_get(dev);
+	if (!i6dev)
+		return NOTIFY_DONE;
+
+	/* Invoked from sw_nb_netdev_event() on NETDEV_UP/DOWN/CHANGE, which
+	 * run with RTNL held. IPv6 address list updates are also serialized
+	 * by RTNL, so addr_list cannot race with concurrent assignments.
+	 */
+	rcu_read_lock();
+	/* Switch offload supports a single IPv6 address per interface for now. */
+	ifp = list_first_entry_or_null(&i6dev->addr_list,
+				       struct inet6_ifaddr, if_list);
+	if (!ifp) {
+		rcu_read_unlock();
+		return NOTIFY_DONE;
+	}
+
+	if (ipv6_addr_type(&ifp->addr) & IPV6_ADDR_LINKLOCAL) {
+		rcu_read_unlock();
+		return NOTIFY_DONE;
+	}
+
+	addr = ifp->addr;
+	prefix_len = ifp->prefix_len;
+	rcu_read_unlock();
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
+	for_each_dev_addr(dev, dev_addr) {
+		entry->mac_valid = 1;
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		break;
+	}
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
+	netdev_dbg(fib_dev, "fib6dst rt6key.addr=%pI6c len=%u\n", &key->addr,
+		   key->plen);
+
+	netdev_dbg(fib_dev, "fib6flags=%#x proto=%u type=%u\n",
+		   f6i->fib6_flags, f6i->fib6_protocol, f6i->fib6_type);
+
+	nh6 = f6i->nh ? nexthop_fib6_nh(f6i->nh) : f6i->fib6_nh;
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
+	if (!neigh) {
+		rcu_read_unlock();
+		kfree(entry);
+		return NOTIFY_DONE;
+	}
+
+	if (is_valid_ether_addr(neigh->ha)) {
+		entry->mac_valid = 1;
+		neigh_ha_snapshot(entry->mac, neigh, fib_dev);
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
+		   n->primary_key, entry->mac, n->tbl->key_len * 8);
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
+	for_each_dev_addr(dev, dev_addr) {
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		entry->mac_valid = 1;
+		break;
+	}
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

