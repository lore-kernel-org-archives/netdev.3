Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=12.32.117.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850287;
	b=zcjM/rtMUfBwzY5sGA7HDT8hQZsK4Ro198VLAmCaepd7Lyg6ncxYMmzsk/HONkBN2b33
	 no6eRUvM/Kd5xutNjPIF0gleoN0kle7Ebek4rmghRXRp+oxZ+Y8ZfNTZi1/trSC7l7gWm
	 +GQNsoZEsyHd3i4Hq09ZWEtoQNry0RjnBJVGwBiNCgX06EdFPOEkiJe50o4eCvWPprGYI
	 IjiVKbK3KSO/bsKn4dAw0N90XFTY3d/gdrJJC39p5O+Ubm02dMVB280Kz9bMd2NTNtA7A
	 cpnmm5Oc4jKURz6+/P736FDL1QDQAjCay4dnYQNYRq/T+fHOR/xE/hIeAF1niK9aOtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850287;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IBhXjvwr01uOkBWIRPjjTU6nXZTaYHrAwUzWhoOEqQI=;
	b=4wamod9lBarqILsv4BSn3aAkDp5Z6PmVz1tpGCvB0Ed6bgjUSQAc2ilsyua+yBCkFerM
	 HL5cvZKoS4loPg0PUNjYmrvVeWIG0df3I8RfDu0XwQrd51rbuAm4WuF2ya+PDv5rEdTyC
	 qULGeKOOTTo07A6QWRQonGCMdxEH7veP60r2yOtA0hvrSJWjzd7soVAgoQ0rCZ17fr+ep
	 B2AfHoJCGAf00fapu9n6cGnup9j5lpkymPyhNz4xmLH/YmaLYDbv3pqCmpygbSp2S/hID
	 RU6PZgAFCMMOLsJL1VV9L+xbswS7n4kI1GXGONkbcFsv3bOKfumydW1e8nRuWY+RGDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chelsio.com;
	spf=pass smtp.mailfrom=chelsio.com;
	arc=none smtp.remote-ip=12.32.117.8
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F4606A333
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 03:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8F4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 6A53hj3q002480;
	Wed, 4 Nov 2026 19:44:31 -0800
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        harshitha.vr@chelsio.com
Subject: [PATCH net-next v5 REPOST 04/12] cxgb4: move PCI device management into cxgb4_pci.c and rework driver helpers
Date: Thu,  5 Nov 2026 08:15:41 -0500
Message-Id: <20261105131549.547554-5-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261105131549.547554-1-bharat@chelsio.com>
References: <20261105131549.547554-1-bharat@chelsio.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxgb4_main.c has accumulated all of the PCI bus glue - the device ID
table, probe, remove, shutdown and the EEH error handlers - alongside
the actual network driver.  Split the bus-facing half out into a new
cxgb4_pci.c so that adding a new chip generation does not require
touching PCI enumeration code, and so that the probe path can be read
as a sequence of named steps rather than one 400 line function.

init_one() becomes cxgb4_pci_init_one() (bus side) plus
cxgb4_adap_probe() (driver side); remove_one() and shutdown_one() are
split the same way.  Resource acquisition, chip identification, memory
window setup and the firmware handshake move into
cxgb4_pci_resource_init(), cxgb4_pci_chip_init(),
cxgb4_pci_setup_memwin{,_rdma}() and cxgb4_pci_fw_init().  The EEH
handlers are renamed cxgb4_pci_eeh_* and exported so the
pci_error_handlers table can live next to the pci_driver.

Because the pci_driver structure is no longer in cxgb4_main.c, the two
places that identified a cxgb4 netdevice by comparing its parent
device driver now compare netdev_ops against cxgb4_netdev_ops instead.

Several helpers are reworked while the code is being moved:

  - cxgb4_work_queue()/cxgb4_work_cancel() and
    cxgb4_workqueues_{create,destroy}() replace the open coded
    workqueue calls.
  - cxgb4_pci_msi{x,}_enabled() replace direct tests of
    CXGB4_USING_MSI/CXGB4_USING_MSIX, and enable_msix() now records
    which interrupt mode was actually selected.
  - cxgb4_port_chan_to_netdev() looks a netdevice up by channel and
    returns NULL if none matches, so the DCB firmware event paths no
    longer index chan_map[] blindly.
  - The HMA page size calculation picks the largest power of two page
    size the scatterlist actually provides instead of assuming a fixed
    page order.
  - SGE doorbell addresses are computed once at probe and used via
    writel() rather than recomputed per doorbell ring.

Fixed while moving the code:

  - CXGB4_DEV_ENABLED is now set in cxgb4_pci_resource_init()
    immediately after pci_enable_device() and cleared where the VF
    management PF disables the device again.  Previously the flag was
    set late in probe, so an early probe failure left the device
    enabled.
  - enable_msix() leaked the msix_entry array on its success path.
  - free_some_resources() passed adapter->pf to t4_fw_bye() where the
    mailbox number is wanted.
  - cxgb_udp_tunnel_set_port() now unwinds the MAC filters it
    allocated if a later port fails, and only programs the MPS
    register once every filter is in place.

No functional change is intended for T4/T5/T6 beyond the fixes listed
above.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/Makefile   |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  18 +
 .../net/ethernet/chelsio/cxgb4/cxgb4_dcb.c    |  19 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 647 ++++++++----------
 .../net/ethernet/chelsio/cxgb4/cxgb4_pci.c    | 332 +++++++++
 .../net/ethernet/chelsio/cxgb4/cxgb4_pci.h    |  23 +
 drivers/net/ethernet/chelsio/cxgb4/sge.c      |  96 +--
 7 files changed, 715 insertions(+), 422 deletions(-)
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.h

diff --git a/drivers/net/ethernet/chelsio/cxgb4/Makefile b/drivers/net/ethernet/chelsio/cxgb4/Makefile
index a4b4d475abf8..08aef803a14a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/Makefile
+++ b/drivers/net/ethernet/chelsio/cxgb4/Makefile
@@ -9,7 +9,7 @@ cxgb4-objs := cxgb4_main.o l2t.o smt.o t4_hw.o sge.o clip_tbl.o cxgb4_ethtool.o
 	      cxgb4_uld.o srq.o sched.o cxgb4_filter.o cxgb4_tc_u32.o \
 	      cxgb4_ptp.o cxgb4_tc_flower.o cxgb4_cudbg.o cxgb4_mps.o \
 	      cudbg_common.o cudbg_lib.o cudbg_zlib.o cxgb4_tc_mqprio.o \
-	      cxgb4_tc_matchall.o
+	      cxgb4_tc_matchall.o cxgb4_pci.o
 cxgb4-$(CONFIG_CHELSIO_T4_DCB) +=  cxgb4_dcb.o
 cxgb4-$(CONFIG_CHELSIO_T4_FCOE) +=  cxgb4_fcoe.o
 cxgb4-$(CONFIG_DEBUG_FS) += cxgb4_debugfs.o
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index f07fdb99d83b..f08bb0993c37 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -70,6 +70,8 @@ enum dev_state {
 
 #include "cxgb4_uld.h"
 #include "t4fw_api.h"
+#include "t4_values.h"
+#include "cxgb4_pci.h"
 
 #define CH_WARN(adap, fmt, ...) dev_warn(adap->pdev_dev, fmt, ## __VA_ARGS__)
 extern struct list_head adapter_list;
@@ -1636,6 +1638,9 @@ extern char cxgb4_driver_name[];
 void t4_os_portmod_changed(struct adapter *adap, int port_id);
 void t4_os_link_changed(struct adapter *adap, int port_id, int link_stat);
 
+void cxgb4_work_queue(struct workqueue_struct *workq, struct work_struct *work);
+void cxgb4_work_cancel(struct workqueue_struct *workq, struct work_struct *work);
+struct net_device *cxgb4_port_chan_to_netdev(struct adapter *adap, u8 chan);
 void t4_free_sge_resources(struct adapter *adap);
 irq_handler_t t4_intr_handler(struct adapter *adap);
 netdev_tx_t t4_start_xmit(struct sk_buff *skb, struct net_device *dev);
@@ -2067,6 +2072,19 @@ int t4_free_mac_filt(struct adapter *adap, unsigned int mbox,
 		     const u8 **addr, bool sleep_ok);
 int t4_change_mac(struct adapter *adap, unsigned int mbox, unsigned int viid,
 		  int idx, const u8 *addr, bool persist, u8 *smt_idx);
+int cxgb4_is_primary_pf(struct adapter *adapter);
+int cxgb4_mbox_log_init(struct adapter *adap);
+
+pci_ers_result_t cxgb4_pci_eeh_err_detected(struct pci_dev *pdev,
+					    pci_channel_state_t state);
+pci_ers_result_t cxgb4_pci_eeh_slot_reset(struct pci_dev *pdev);
+void cxgb4_pci_eeh_resume(struct pci_dev *pdev);
+void cxgb4_pci_eeh_reset_prepare(struct pci_dev *pdev);
+void cxgb4_pci_eeh_reset_done(struct pci_dev *pdev);
+int cxgb4_iov_configure(struct pci_dev *pdev, int num_vfs);
+int cxgb4_adap_probe(struct adapter *adapter);
+void cxgb4_adap_remove(struct adapter *adapter);
+void cxgb4_adap_shutdown(struct adapter *adapter);
 int t4_set_addr_hash(struct adapter *adap, unsigned int mbox, unsigned int viid,
 		     bool ucast, u64 vec, bool sleep_ok);
 int t4_enable_vi_params(struct adapter *adap, unsigned int mbox,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
index 7d5204834ee2..7c5437423696 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
@@ -273,13 +273,24 @@ void cxgb4_dcb_state_fsm(struct net_device *dev,
 void cxgb4_dcb_handle_fw_update(struct adapter *adap,
 				const struct fw_port_cmd *pcmd)
 {
-	const union fw_port_dcb *fwdcb = &pcmd->u.dcb;
 	int port = FW_PORT_CMD_PORTID_G(be32_to_cpu(pcmd->op_to_portid));
-	struct net_device *dev = adap->port[adap->chan_map[port]];
-	struct port_info *pi = netdev_priv(dev);
-	struct port_dcb_info *dcb = &pi->dcb;
+	const union fw_port_dcb *fwdcb = &pcmd->u.dcb;
 	int dcb_type = pcmd->u.dcb.pgid.type;
+	struct port_dcb_info *dcb;
 	int dcb_running_version;
+	struct net_device *dev;
+	struct port_info *pi;
+
+	dev = cxgb4_port_chan_to_netdev(adap, port);
+	if (!dev) {
+		dev_warn(adap->pdev_dev,
+			 "Could not get netdevice for handling DCB FW update for port: %d\n",
+			 port);
+		return;
+	}
+
+	pi = netdev_priv(dev);
+	dcb = &pi->dcb;
 
 	/* Handle Firmware DCB Control messages separately since they drive
 	 * our state machine.
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index b7f0df9704a2..05ee6c1f9923 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -98,28 +98,6 @@ char cxgb4_driver_name[] = KBUILD_MODNAME;
 			 NETIF_MSG_TIMER | NETIF_MSG_IFDOWN | NETIF_MSG_IFUP |\
 			 NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
 
-/* Macros needed to support the PCI Device ID Table ...
- */
-#define CH_PCI_DEVICE_ID_TABLE_DEFINE_BEGIN \
-	static const struct pci_device_id cxgb4_pci_tbl[] = {
-#define CXGB4_UNIFIED_PF 0x4
-
-#define CH_PCI_DEVICE_ID_FUNCTION CXGB4_UNIFIED_PF
-
-/* Include PCI Device IDs for both PF4 and PF0-3 so our PCI probe() routine is
- * called for both.
- */
-#define CH_PCI_DEVICE_ID_FUNCTION2 0x0
-
-#define CH_PCI_ID_TABLE_ENTRY(devid) \
-		{ PCI_VDEVICE(CHELSIO, (devid)), .driver_data = CXGB4_UNIFIED_PF }
-
-#define CH_PCI_DEVICE_ID_TABLE_DEFINE_END \
-		{ } \
-	}
-
-#include "t4_pci_id_tbl.h"
-
 #define FW4_FNAME "cxgb4/t4fw.bin"
 #define FW5_FNAME "cxgb4/t5fw.bin"
 #define FW6_FNAME "cxgb4/t6fw.bin"
@@ -134,7 +112,6 @@ char cxgb4_driver_name[] = KBUILD_MODNAME;
 MODULE_DESCRIPTION(DRV_DESC);
 MODULE_AUTHOR("Chelsio Communications");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DEVICE_TABLE(pci, cxgb4_pci_tbl);
 MODULE_FIRMWARE(FW4_FNAME);
 MODULE_FIRMWARE(FW5_FNAME);
 MODULE_FIRMWARE(FW6_FNAME);
@@ -171,14 +148,15 @@ static int rx_dma_offset = 2;
  * queue. Select between the kernel provided function (select_queue=0) or user
  * cxgb_select_queue function (select_queue=1)
  *
- * Default: select_queue=0
+ * Default: select_queue=1
  */
-static int select_queue;
+static int select_queue = 1;
 module_param(select_queue, int, 0644);
 MODULE_PARM_DESC(select_queue,
 		 "Select between kernel provided method of selecting or driver method of selecting TX queue. Default is kernel method.");
 
 static struct dentry *cxgb4_debugfs_root;
+static const struct net_device_ops cxgb4_netdev_ops;
 
 LIST_HEAD(adapter_list);
 DEFINE_MUTEX(uld_mutex);
@@ -333,6 +311,40 @@ void t4_os_portmod_changed(struct adapter *adap, int port_id)
 	pi->link_cfg.redo_l1cfg = netif_running(dev);
 }
 
+void cxgb4_work_queue(struct workqueue_struct *workq, struct work_struct *work)
+{
+	if (!workq)
+		return;
+
+	queue_work(workq, work);
+}
+
+void cxgb4_work_cancel(struct workqueue_struct *workq, struct work_struct *work)
+{
+	if (!workq)
+		return;
+
+	cancel_work_sync(work);
+}
+
+static void cxgb4_workqueues_destroy(struct adapter *adap)
+{
+	if (adap->workq) {
+		flush_workqueue(adap->workq);
+		destroy_workqueue(adap->workq);
+		adap->workq = NULL;
+	}
+}
+
+static int cxgb4_workqueues_create(struct adapter *adap)
+{
+	adap->workq = create_singlethread_workqueue("cxgb4");
+	if (!adap->workq)
+		return -ENOMEM;
+
+	return 0;
+}
+
 int dbfifo_int_thresh = 10; /* 10 == 640 entry threshold */
 module_param(dbfifo_int_thresh, int, 0644);
 MODULE_PARM_DESC(dbfifo_int_thresh, "doorbell fifo interrupt threshold");
@@ -534,9 +546,17 @@ static int link_start(struct net_device *dev)
 static void dcb_rpl(struct adapter *adap, const struct fw_port_cmd *pcmd)
 {
 	int port = FW_PORT_CMD_PORTID_G(ntohl(pcmd->op_to_portid));
-	struct net_device *dev = adap->port[adap->chan_map[port]];
-	int old_dcb_enabled = cxgb4_dcb_enabled(dev);
-	int new_dcb_enabled;
+	int old_dcb_enabled, new_dcb_enabled;
+	struct net_device *dev;
+
+	dev = cxgb4_port_chan_to_netdev(adap, port);
+	if (!dev) {
+		dev_warn(adap->pdev_dev,
+			 "Could not get netdevice for handling dcb_rpl for port %d\n", port);
+		return;
+	}
+
+	old_dcb_enabled = cxgb4_dcb_enabled(dev);
 
 	cxgb4_dcb_handle_fw_update(adap, pcmd);
 	new_dcb_enabled = cxgb4_dcb_enabled(dev);
@@ -608,7 +628,14 @@ static int fwevtq_handler(struct sge_rspq *q, const __be64 *rsp,
 			struct net_device *dev;
 			int dcbxdis, state_input;
 
-			dev = q->adap->port[q->adap->chan_map[port]];
+			dev = cxgb4_port_chan_to_netdev(q->adap, port);
+			if (!dev) {
+				dev_warn(q->adap->pdev_dev,
+					 "Could not get netdevice for handling DCB event for port %d\n",
+					 port);
+				goto out;
+			}
+
 			dcbxdis = (action == FW_PORT_ACTION_GET_PORT_INFO
 			  ? !!(pcmd->u.info.dcbxdis_pkd & FW_PORT_CMD_DCBXDIS_F)
 			  : !!(be32_to_cpu(pcmd->u.info32.lstatus32_to_cbllen32)
@@ -959,7 +986,7 @@ void cxgb4_enable_rx(struct adapter *adap, struct sge_rspq *q)
 	/* 0-increment GTS to start the timer and enable interrupts */
 	t4_write_reg(adap, MYPF_REG(SGE_PF_GTS_A),
 		     SEINTARM_V(q->intr_params) |
-		     INGRESSQID_V(q->cntxt_id));
+		     INGRESSQID_V(q->cntxt_id) | CIDXINC_V(0));
 }
 
 /*
@@ -1286,17 +1313,6 @@ static int cxgb_set_features(struct net_device *dev, netdev_features_t features)
 	return err;
 }
 
-static int setup_debugfs(struct adapter *adap)
-{
-	if (IS_ERR_OR_NULL(adap->debugfs_root))
-		return -1;
-
-#ifdef CONFIG_DEBUG_FS
-	t4_setup_debugfs(adap);
-#endif
-	return 0;
-}
-
 static void cxgb4_port_mirror_free_rxq(struct adapter *adap,
 				       struct sge_eth_rxq *mirror_rxq)
 {
@@ -2126,6 +2142,20 @@ unsigned int cxgb4_port_chan(const struct net_device *dev)
 }
 EXPORT_SYMBOL(cxgb4_port_chan);
 
+struct net_device *cxgb4_port_chan_to_netdev(struct adapter *adap, u8 chan)
+{
+	struct port_info *pi;
+	u8 i;
+
+	for_each_port(adap, i) {
+		pi = adap2pinfo(adap, i);
+		if (pi->lport == chan)
+			return adap->port[pi->port_id];
+	}
+
+	return NULL;
+}
+
 /**
  *      cxgb4_port_e2cchan - get the HW c-channel of a port
  *      @dev: the net device for the port
@@ -2357,8 +2387,6 @@ int cxgb4_bar2_sge_qregs(struct net_device *dev,
 }
 EXPORT_SYMBOL(cxgb4_bar2_sge_qregs);
 
-static struct pci_driver cxgb4_driver;
-
 static void check_neigh_update(struct neighbour *neigh)
 {
 	const struct device *parent;
@@ -2367,7 +2395,7 @@ static void check_neigh_update(struct neighbour *neigh)
 	if (is_vlan_dev(netdev))
 		netdev = vlan_dev_real_dev(netdev);
 	parent = netdev->dev.parent;
-	if (parent && parent->driver == &cxgb4_driver.driver)
+	if (parent && netdev->netdev_ops == &cxgb4_netdev_ops)
 		t4_l2t_update(dev_get_drvdata(parent), neigh);
 }
 
@@ -2393,7 +2421,6 @@ static struct notifier_block cxgb4_netevent_nb = {
 static void drain_db_fifo(struct adapter *adap, int usecs)
 {
 	u32 v1, v2, lp_count, hp_count;
-
 	do {
 		v1 = t4_read_reg(adap, SGE_DBFIFO_STATUS_A);
 		v2 = t4_read_reg(adap, SGE_DBFIFO_STATUS2_A);
@@ -2608,7 +2635,7 @@ void t4_db_full(struct adapter *adap)
 		notify_rdma_uld(adap, CXGB4_CONTROL_DB_FULL);
 		t4_set_reg_field(adap, SGE_INT_ENABLE3_A,
 				 DBFIFO_HP_INT_F | DBFIFO_LP_INT_F, 0);
-		queue_work(adap->workq, &adap->db_full_task);
+		cxgb4_work_queue(adap->workq, &adap->db_full_task);
 	}
 }
 
@@ -2618,7 +2645,7 @@ void t4_db_dropped(struct adapter *adap)
 		disable_dbs(adap);
 		notify_rdma_uld(adap, CXGB4_CONTROL_DB_FULL);
 	}
-	queue_work(adap->workq, &adap->db_drop_task);
+	cxgb4_work_queue(adap->workq, &adap->db_drop_task);
 }
 
 void t4_register_netevent_notifier(void)
@@ -2669,7 +2696,6 @@ static int cxgb4_inet6addr_handler(struct notifier_block *this,
 {
 	struct inet6_ifaddr *ifa = data;
 	struct net_device *event_dev = ifa->idev->dev;
-	const struct device *parent = NULL;
 #if IS_ENABLED(CONFIG_BONDING)
 	struct adapter *adap;
 #endif
@@ -2695,10 +2721,7 @@ static int cxgb4_inet6addr_handler(struct notifier_block *this,
 	}
 #endif
 
-	if (event_dev)
-		parent = event_dev->dev.parent;
-
-	if (parent && parent->driver == &cxgb4_driver.driver) {
+	if (event_dev && event_dev->netdev_ops == &cxgb4_netdev_ops) {
 		switch (event) {
 		case NETDEV_UP:
 			cxgb4_clip_get(event_dev, (const u32 *)ifa, 1);
@@ -2768,7 +2791,6 @@ static int cxgb_up(struct adapter *adap)
 			err = -ENOMEM;
 			goto irq_err;
 		}
-
 		err = request_irq(adap->msix_info[s->nd_msix_idx].vec,
 				  t4_nondata_intr, 0,
 				  adap->msix_info[s->nd_msix_idx].desc, adap);
@@ -2779,10 +2801,13 @@ static int cxgb_up(struct adapter *adap)
 		if (err)
 			goto irq_err_free_nd_msix;
 	} else {
+		unsigned long flags = 0;
+
+		if (!cxgb4_pci_msix_enabled(adap) && !cxgb4_pci_msi_enabled(adap))
+			flags = IRQF_SHARED;
+
 		err = request_irq(adap->pdev->irq, t4_intr_handler(adap),
-				  (adap->flags & CXGB4_USING_MSI) ? 0
-								  : IRQF_SHARED,
-				  adap->port[0]->name, adap);
+				  flags, adap->port[0]->name, adap);
 		if (err)
 			goto irq_err;
 	}
@@ -2812,9 +2837,9 @@ static int cxgb_up(struct adapter *adap)
 
 static void cxgb_down(struct adapter *adapter)
 {
-	cancel_work_sync(&adapter->tid_release_task);
-	cancel_work_sync(&adapter->db_full_task);
-	cancel_work_sync(&adapter->db_drop_task);
+	cxgb4_work_cancel(adapter->workq, &adapter->tid_release_task);
+	cxgb4_work_cancel(adapter->workq, &adapter->db_full_task);
+	cxgb4_work_cancel(adapter->workq, &adapter->db_drop_task);
 	adapter->tid_release_task_busy = false;
 	adapter->tid_release_head = NULL;
 
@@ -3856,13 +3881,13 @@ static const struct net_device_ops cxgb4_netdev_ops = {
 	.ndo_open             = cxgb_open,
 	.ndo_stop             = cxgb_close,
 	.ndo_start_xmit       = t4_start_xmit,
-	.ndo_select_queue     =	cxgb_select_queue,
+	.ndo_select_queue     = cxgb_select_queue,
 	.ndo_get_stats64      = cxgb_get_stats,
 	.ndo_set_rx_mode      = cxgb_set_rxmode,
 	.ndo_set_mac_address  = cxgb_set_mac_addr,
 	.ndo_set_features     = cxgb_set_features,
 	.ndo_validate_addr    = eth_validate_addr,
-	.ndo_eth_ioctl         = cxgb_ioctl,
+	.ndo_eth_ioctl        = cxgb_ioctl,
 	.ndo_change_mtu       = cxgb_change_mtu,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller  = cxgb_netpoll,
@@ -3937,35 +3962,7 @@ void t4_fatal_err(struct adapter *adap)
 		netif_carrier_off(dev);
 	}
 	dev_alert(adap->pdev_dev, "encountered fatal error, adapter stopped\n");
-	queue_work(adap->workq, &adap->fatal_err_notify_task);
-}
-
-static void setup_memwin(struct adapter *adap)
-{
-	u32 nic_win_base = t4_get_util_window(adap);
-
-	t4_setup_memwin(adap, nic_win_base, MEMWIN_NIC);
-}
-
-static void setup_memwin_rdma(struct adapter *adap)
-{
-	if (adap->vres.ocq.size) {
-		u32 start;
-		unsigned int sz_kb;
-
-		start = t4_read_pcie_cfg4(adap, PCI_BASE_ADDRESS_2);
-		start &= PCI_BASE_ADDRESS_MEM_MASK;
-		start += OCQ_WIN_OFFSET(adap->pdev, &adap->vres);
-		sz_kb = roundup_pow_of_two(adap->vres.ocq.size) >> 10;
-		t4_write_reg(adap,
-			     PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_BASE_WIN_A, 3),
-			     start | BIR_V(1) | WINDOW_V(ilog2(sz_kb)));
-		t4_write_reg(adap,
-			     PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_OFFSET_A, 3),
-			     adap->vres.ocq.start);
-		t4_read_reg(adap,
-			    PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_OFFSET_A, 3));
-	}
+	cxgb4_work_queue(adap->workq, &adap->fatal_err_notify_task);
 }
 
 /* HMA Definitions */
@@ -3975,11 +3972,13 @@ static void setup_memwin_rdma(struct adapter *adap)
 
 #define HMA_PAGE_SIZE		PAGE_SIZE
 
+/* HW supports max 16M page size */
+#define HMA_MAX_PAGE_SIZE      (16UL << 20)
+
 #define HMA_MAX_NO_FW_ADDRESS	(16 << 10)  /* FW supports 16K addresses */
 
-#define HMA_PAGE_ORDER					\
-	((HMA_PAGE_SIZE < HMA_MAX_NO_FW_ADDRESS) ?	\
-	ilog2(HMA_MAX_NO_FW_ADDRESS / HMA_PAGE_SIZE) : 0)
+/* Allocate pages of size page_size << page_order */
+#define HMA_PAGE_ORDER	ilog2((4 << 20) / HMA_PAGE_SIZE)
 
 /* The minimum and maximum possible HMA sizes that can be specified in the FW
  * configuration(in units of MB).
@@ -4025,7 +4024,9 @@ static int adap_config_hma(struct adapter *adapter)
 	unsigned int i, j, k;
 	u32 param, hma_size;
 	unsigned int ncmds;
+	unsigned int nents;
 	size_t page_size;
+	u32 best_page_size;
 	u32 page_order;
 	int node, ret;
 
@@ -4076,8 +4077,8 @@ static int adap_config_hma(struct adapter *adapter)
 	sgl = adapter->hma.sgt->sgl;
 	node = dev_to_node(adapter->pdev_dev);
 	for_each_sg(sgl, iter, sgt->orig_nents, i) {
-		newpage = alloc_pages_node(node, __GFP_NOWARN | GFP_KERNEL |
-					   __GFP_ZERO, page_order);
+		newpage = alloc_pages_node(node, __GFP_NOWARN | __GFP_ZERO |
+					   GFP_KERNEL, page_order);
 		if (!newpage) {
 			dev_err(adapter->pdev_dev,
 				"Not enough memory for HMA page allocation\n");
@@ -4097,16 +4098,32 @@ static int adap_config_hma(struct adapter *adapter)
 	}
 	adapter->hma.flags |= HMA_DMA_MAPPED_FLAG;
 
-	adapter->hma.phy_addr = kzalloc_objs(dma_addr_t, sgt->nents);
+	best_page_size = HMA_MAX_PAGE_SIZE;
+	for_each_sg(sgl, iter, sgt->nents, i) {
+		if (!is_power_of_2(sg_dma_len(iter))) {
+			best_page_size = min(page_size << page_order, HMA_MAX_PAGE_SIZE);
+			break;
+		}
+
+		if (sg_dma_len(iter) < best_page_size)
+			best_page_size = sg_dma_len(iter);
+	}
+
+	nents = (hma_size << 20) / best_page_size;
+	adapter->hma.phy_addr = kcalloc(nents, sizeof(dma_addr_t), GFP_KERNEL);
 	if (unlikely(!adapter->hma.phy_addr))
 		goto free_hma;
 
+	k = 0;
 	for_each_sg(sgl, iter, sgt->nents, i) {
-		newpage = sg_page(iter);
-		adapter->hma.phy_addr[i] = sg_dma_address(iter);
+		u32 npages = sg_dma_len(iter) / best_page_size;
+
+		for (j = 0; j < npages; j++)
+			adapter->hma.phy_addr[k++] =
+				sg_dma_address(iter) + (j * best_page_size);
 	}
 
-	ncmds = DIV_ROUND_UP(sgt->nents, HMA_MAX_ADDR_IN_CMD);
+	ncmds = DIV_ROUND_UP(nents, HMA_MAX_ADDR_IN_CMD);
 	/* Pass on the addresses to firmware */
 	for (i = 0, k = 0; i < ncmds; i++, k += HMA_MAX_ADDR_IN_CMD) {
 		struct fw_hma_cmd hma_cmd;
@@ -4121,7 +4138,7 @@ static int adap_config_hma(struct adapter *adapter)
 		 * addresses
 		 */
 		if (i == ncmds - 1) {
-			naddr = sgt->nents % HMA_MAX_ADDR_IN_CMD;
+			naddr = nents % HMA_MAX_ADDR_IN_CMD;
 			naddr = naddr ? naddr : HMA_MAX_ADDR_IN_CMD;
 		}
 		memset(&hma_cmd, 0, sizeof(hma_cmd));
@@ -4140,8 +4157,7 @@ static int adap_config_hma(struct adapter *adapter)
 
 		/* Total Page size specified in units of 4K */
 		hma_cmd.addr_size_pkd =
-			htonl(FW_HMA_CMD_ADDR_SIZE_V
-				((page_size << page_order) >> 12));
+			htonl(FW_HMA_CMD_ADDR_SIZE_V(best_page_size >> 12));
 
 		/* Fill the 5 addresses */
 		for (j = 0; j < naddr; j++) {
@@ -4285,7 +4301,7 @@ static int adap_init0_tweaks(struct adapter *adapter)
 	 * Process module parameters which affect early initialization.
 	 */
 	if (rx_dma_offset != 2 && rx_dma_offset != 0) {
-		dev_err(&adapter->pdev->dev,
+		dev_err(adapter->pdev_dev,
 			"Ignoring illegal rx_dma_offset=%d, using 2\n",
 			rx_dma_offset);
 		rx_dma_offset = 2;
@@ -4356,9 +4372,9 @@ static struct info_10gbt_phy_fw {
 	{ 0, NULL, NULL },
 };
 
-static struct info_10gbt_phy_fw *find_phy_info(int devid)
+static struct info_10gbt_phy_fw *find_phy_info(struct adapter *adap)
 {
-	int i;
+	int i, devid = adap->pdev->device;
 
 	for (i = 0; i < ARRAY_SIZE(phy_info_array); i++) {
 		if (phy_info_array[i].phy_fw_id == devid)
@@ -4374,13 +4390,13 @@ static struct info_10gbt_phy_fw *find_phy_info(int devid)
  */
 static int adap_init0_phy(struct adapter *adap)
 {
+	struct info_10gbt_phy_fw *phy_info;
 	const struct firmware *phyf;
 	int ret;
-	struct info_10gbt_phy_fw *phy_info;
 
 	/* Use the device ID to determine which PHY file to flash.
 	 */
-	phy_info = find_phy_info(adap->pdev->device);
+	phy_info = find_phy_info(adap);
 	if (!phy_info) {
 		dev_warn(adap->pdev_dev,
 			 "No PHY Firmware file found for this PHY\n");
@@ -4766,14 +4782,10 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 	if (ret < 0)
 		return ret;
 
-	/* Contact FW, advertising Master capability */
-	ret = t4_fw_hello(adap, adap->mbox, adap->mbox,
-			  is_kdump_kernel() ? MASTER_MUST : MASTER_MAY, &state);
-	if (ret < 0) {
-		dev_err(adap->pdev_dev, "could not connect to FW, error %d\n",
-			ret);
+	ret = cxgb4_pci_fw_init(adap, &state);
+	if (ret < 0)
 		return ret;
-	}
+
 	if (ret == adap->mbox)
 		adap->flags |= CXGB4_MASTER_PF;
 
@@ -5021,7 +5033,8 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 	adap->sge.egr_sz = val[0] - adap->sge.egr_start + 1;
 	adap->sge.ingr_sz = val[1] - adap->sge.ingr_start + 1;
 
-	adap->sge.egr_map = kzalloc_objs(*adap->sge.egr_map, adap->sge.egr_sz);
+	adap->sge.egr_map = kcalloc(adap->sge.egr_sz,
+				    sizeof(*adap->sge.egr_map), GFP_KERNEL);
 	if (!adap->sge.egr_map) {
 		ret = -ENOMEM;
 		goto bye;
@@ -5415,8 +5428,8 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 
 /* EEH callbacks */
 
-static pci_ers_result_t eeh_err_detected(struct pci_dev *pdev,
-					 pci_channel_state_t state)
+pci_ers_result_t cxgb4_pci_eeh_err_detected(struct pci_dev *pdev,
+					    pci_channel_state_t state)
 {
 	int i;
 	struct adapter *adap = pci_get_drvdata(pdev);
@@ -5448,7 +5461,7 @@ out:	return state == pci_channel_io_perm_failure ?
 		PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_NEED_RESET;
 }
 
-static pci_ers_result_t eeh_slot_reset(struct pci_dev *pdev)
+pci_ers_result_t cxgb4_pci_eeh_slot_reset(struct pci_dev *pdev)
 {
 	int i, ret;
 	struct fw_caps_config_cmd c;
@@ -5504,13 +5517,13 @@ static pci_ers_result_t eeh_slot_reset(struct pci_dev *pdev)
 
 	t4_load_mtus(adap, adap->params.mtus, adap->params.a_wnd,
 		     adap->params.b_wnd);
-	setup_memwin(adap);
+	cxgb4_pci_setup_memwin(adap);
 	if (cxgb_up(adap))
 		return PCI_ERS_RESULT_DISCONNECT;
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static void eeh_resume(struct pci_dev *pdev)
+void cxgb4_pci_eeh_resume(struct pci_dev *pdev)
 {
 	int i;
 	struct adapter *adap = pci_get_drvdata(pdev);
@@ -5532,7 +5545,7 @@ static void eeh_resume(struct pci_dev *pdev)
 	rtnl_unlock();
 }
 
-static void eeh_reset_prepare(struct pci_dev *pdev)
+void cxgb4_pci_eeh_reset_prepare(struct pci_dev *pdev)
 {
 	struct adapter *adapter = pci_get_drvdata(pdev);
 	int i;
@@ -5557,7 +5570,7 @@ static void eeh_reset_prepare(struct pci_dev *pdev)
 		cxgb_down(adapter);
 }
 
-static void eeh_reset_done(struct pci_dev *pdev)
+void cxgb4_pci_eeh_reset_done(struct pci_dev *pdev)
 {
 	struct adapter *adapter = pci_get_drvdata(pdev);
 	int err, i;
@@ -5572,7 +5585,7 @@ static void eeh_reset_done(struct pci_dev *pdev)
 		return;
 	}
 
-	setup_memwin(adapter);
+	cxgb4_pci_setup_memwin(adapter);
 
 	err = adap_init0(adapter, 1);
 	if (err) {
@@ -5581,7 +5594,7 @@ static void eeh_reset_done(struct pci_dev *pdev)
 		return;
 	}
 
-	setup_memwin_rdma(adapter);
+	cxgb4_pci_setup_memwin_rdma(adapter);
 
 	if (adapter->flags & CXGB4_FW_OK) {
 		err = t4_port_init(adapter, adapter->pf, adapter->pf, 0);
@@ -5613,14 +5626,6 @@ static void eeh_reset_done(struct pci_dev *pdev)
 			cxgb_open(adapter->port[i]);
 }
 
-static const struct pci_error_handlers cxgb4_eeh = {
-	.error_detected = eeh_err_detected,
-	.slot_reset     = eeh_slot_reset,
-	.resume         = eeh_resume,
-	.reset_prepare  = eeh_reset_prepare,
-	.reset_done     = eeh_reset_done,
-};
-
 /* Return true if the Link Configuration supports "High Speeds" (those greater
  * than 1Gb/s).
  */
@@ -5956,6 +5961,7 @@ static int enable_msix(struct adapter *adap)
 			goto out_free;
 		}
 
+		adap->flags |= CXGB4_USING_MSI;
 		dev_info(adap->pdev_dev,
 			 "Disabling offload due to insufficient MSI-X vectors\n");
 		adap->params.offload = 0;
@@ -5967,6 +5973,8 @@ static int enable_msix(struct adapter *adap)
 		uld_need = 0;
 		ethofld_need = 0;
 		mirror_need = 0;
+	} else {
+		adap->flags |= CXGB4_USING_MSIX;
 	}
 
 	num_vec = allocated;
@@ -6066,16 +6074,21 @@ static int enable_msix(struct adapter *adap)
 		adap->msix_info[i].idx = i;
 	}
 
-	dev_info(adap->pdev_dev,
-		 "%d MSI-X vectors allocated, nic %d eoqsets %d per uld %d mirrorqsets %d\n",
-		 allocated, s->max_ethqsets, s->eoqsets, s->nqs_per_uld,
-		 s->mirrorqsets);
+	if (cxgb4_pci_msix_enabled(adap))
+		dev_info(adap->pdev_dev, "%d MSI-X vectors allocated, ", allocated);
+	else if (cxgb4_pci_msi_enabled(adap))
+		dev_info(adap->pdev_dev, "%d MSI vectors allocated, ", allocated);
+	else
+		dev_info(adap->pdev_dev, "%d Legacy vectors allocated, ", allocated);
+
+	dev_info(adap->pdev_dev, "nic %d eoqsets %d per uld %d mirrorqsets %d\n",
+		 s->max_ethqsets, s->eoqsets, s->nqs_per_uld, s->mirrorqsets);
 
 	kfree(entries);
 	return 0;
 
 out_disable_msix:
-	pci_disable_msix(adap->pdev);
+	disable_msi(adap);
 
 out_free:
 	kfree(entries);
@@ -6111,10 +6124,10 @@ static void print_adapter_info(struct adapter *adapter)
 
 	/* Software/Hardware configuration */
 	dev_info(adapter->pdev_dev, "Configuration: %sNIC %s, %s capable\n",
-		 is_offload(adapter) ? "R" : "",
-		 ((adapter->flags & CXGB4_USING_MSIX) ? "MSI-X" :
-		  (adapter->flags & CXGB4_USING_MSI) ? "MSI" : ""),
-		 is_offload(adapter) ? "Offload" : "non-Offload");
+		 is_uld(adapter) ? "R" : "",
+		 cxgb4_pci_msix_enabled(adapter) ? "MSI-X" :
+		 (cxgb4_pci_msi_enabled(adapter) ? "MSI" : ""),
+		 is_uld(adapter) ? "Offload" : "non-Offload");
 }
 
 static void print_port_info(const struct net_device *dev)
@@ -6190,7 +6203,7 @@ static void free_some_resources(struct adapter *adapter)
 			free_netdev(adapter->port[i]);
 		}
 	if (adapter->flags & CXGB4_FW_OK)
-		t4_fw_bye(adapter, adapter->pf);
+		t4_fw_bye(adapter, adapter->mbox);
 }
 
 #define TSO_FLAGS (NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_TSO_ECN | \
@@ -6215,7 +6228,7 @@ static void cxgb4_mgmt_setup(struct net_device *dev)
 	dev->ethtool_ops = &cxgb4_mgmt_ethtool_ops;
 }
 
-static int cxgb4_iov_configure(struct pci_dev *pdev, int num_vfs)
+int cxgb4_iov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	struct adapter *adap = pci_get_drvdata(pdev);
 	int err = 0;
@@ -6551,109 +6564,71 @@ static const struct xfrmdev_ops cxgb4_xfrmdev_ops = {
 
 #endif /* CONFIG_CHELSIO_IPSEC_INLINE */
 
-static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int cxgb4_primary_pf(struct adapter *adapter)
+{
+	return adapter->primary_pf;
+}
+
+int cxgb4_is_primary_pf(struct adapter *adapter)
+{
+	return adapter->pf == cxgb4_primary_pf(adapter);
+}
+
+int cxgb4_mbox_log_init(struct adapter *adap)
+{
+	adap->mbox_log =
+		kzalloc(sizeof(struct mbox_cmd_log) +
+			(sizeof(struct mbox_cmd) *
+			 T4_OS_LOG_MBOX_CMDS), GFP_KERNEL);
+	if (!adap->mbox_log)
+		return -ENOMEM;
+
+	spin_lock_init(&adap->mbox_lock);
+	INIT_LIST_HEAD(&adap->mlist.list);
+	adap->mbox_log->size = T4_OS_LOG_MBOX_CMDS;
+	return 0;
+}
+
+int cxgb4_adap_probe(struct adapter *adapter)
 {
 	struct net_device *netdev;
-	struct adapter *adapter;
 	static int adap_idx = 1;
-	int s_qpp, qpp, num_seg;
 	struct port_info *pi;
-	enum chip_type chip;
-	void __iomem *regs;
-	int func, chip_ver;
-	u16 device_id;
+	int chip_ver;
 	int i, err;
-	u32 whoami;
 
-	err = pci_request_regions(pdev, KBUILD_MODNAME);
-	if (err) {
-		/* Just info, some other driver may have claimed the device. */
-		dev_info(&pdev->dev, "cannot obtain PCI resources\n");
+	err = cxgb4_pci_resource_init(adapter);
+	if (err < 0)
 		return err;
-	}
 
-	err = pci_enable_device(pdev);
-	if (err) {
-		dev_err(&pdev->dev, "cannot enable PCI device\n");
-		goto out_release_regions;
-	}
-
-	regs = pci_ioremap_bar(pdev, 0);
-	if (!regs) {
-		dev_err(&pdev->dev, "cannot map device registers\n");
-		err = -ENOMEM;
-		goto out_disable_device;
-	}
-
-	adapter = kzalloc_obj(*adapter);
-	if (!adapter) {
-		err = -ENOMEM;
-		goto out_unmap_bar0;
-	}
-
-	adapter->regs = regs;
-	err = t4_wait_dev_ready(regs);
+	err = t4_wait_dev_ready(adapter->regs);
 	if (err < 0)
-		goto out_free_adapter;
-
-	/* We control everything through one PF */
-	whoami = t4_read_reg(adapter, PL_WHOAMI_A);
-	pci_read_config_word(pdev, PCI_DEVICE_ID, &device_id);
-	chip = t4_get_chip_type(adapter, CHELSIO_PCI_ID_VER(device_id));
-	if ((int)chip < 0) {
-		dev_err(&pdev->dev, "Device %d is not supported\n", device_id);
-		err = chip;
-		goto out_free_adapter;
-	}
-	chip_ver = CHELSIO_CHIP_VERSION(chip);
-	func = chip_ver <= CHELSIO_T5 ?
-	       SOURCEPF_G(whoami) : T6_SOURCEPF_G(whoami);
+		goto out_free_resources;
 
-	adapter->pdev = pdev;
-	adapter->pdev_dev = &pdev->dev;
-	adapter->name = pci_name(pdev);
-	adapter->mbox = func;
-	adapter->pf = func;
-	adapter->params.chip = chip;
 	adapter->adap_idx = adap_idx;
-	adapter->msg_enable = DFLT_MSG_ENABLE;
-	adapter->mbox_log = kzalloc(sizeof(*adapter->mbox_log) +
-				    (sizeof(struct mbox_cmd) *
-				     T4_OS_LOG_MBOX_CMDS),
-				    GFP_KERNEL);
-	if (!adapter->mbox_log) {
-		err = -ENOMEM;
-		goto out_free_adapter;
-	}
-	spin_lock_init(&adapter->mbox_lock);
-	INIT_LIST_HEAD(&adapter->mlist.list);
-	adapter->mbox_log->size = T4_OS_LOG_MBOX_CMDS;
-	pci_set_drvdata(pdev, adapter);
+	err = cxgb4_pci_chip_init(adapter);
+	if (err < 0)
+		goto out_free_resources;
 
-	if (func != ent->driver_data) {
-		pci_disable_device(pdev);
-		pci_save_state(pdev);        /* to restore SR-IOV later */
+	if (!cxgb4_is_primary_pf(adapter))
 		return 0;
-	}
 
-	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (err) {
-		dev_err(&pdev->dev, "no usable DMA configuration\n");
-		goto out_free_adapter;
-	}
+	/*
+	 * Everything from here down is now the Primary Physical Function!
+	 */
+	chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
 
-	pci_set_master(pdev);
-	pci_save_state(pdev);
+	memset(adapter->chan_map, 0xff, sizeof(adapter->chan_map));
 	adap_idx++;
-	adapter->workq = create_singlethread_workqueue("cxgb4");
-	if (!adapter->workq) {
-		err = -ENOMEM;
-		goto out_free_adapter;
-	}
+	/*
+	 * Default message set for the interfaces. This can be changed later
+	 * via "ethtool -s ethX msglvl N".
+	 */
+	adapter->msg_enable = DFLT_MSG_ENABLE;
 
-	/* PCI device has been enabled */
-	adapter->flags |= CXGB4_DEV_ENABLED;
-	memset(adapter->chan_map, 0xff, sizeof(adapter->chan_map));
+	err = cxgb4_workqueues_create(adapter);
+	if (err < 0)
+		goto out_free_adapter;
 
 	/* If possible, we use PCIe Relaxed Ordering Attribute to deliver
 	 * Ingress Packet Data to Free List Buffers in order to allow for
@@ -6669,7 +6644,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * PCIe configuration space to see if it's flagged with advice against
 	 * using Relaxed Ordering.
 	 */
-	if (!pcie_relaxed_ordering_enabled(pdev))
+	if (!pcie_relaxed_ordering_enabled(adapter->pdev))
 		adapter->flags |= CXGB4_ROOT_NO_RELAXED_ORDERING;
 
 	spin_lock_init(&adapter->stats_lock);
@@ -6696,46 +6671,14 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	if (!is_t4(adapter->params.chip)) {
-		s_qpp = (QUEUESPERPAGEPF0_S +
-			(QUEUESPERPAGEPF1_S - QUEUESPERPAGEPF0_S) *
-			adapter->pf);
-		qpp = 1 << QUEUESPERPAGEPF0_G(t4_read_reg(adapter,
-		      SGE_EGRESS_QUEUES_PER_PAGE_PF_A) >> s_qpp);
-		num_seg = PAGE_SIZE / SEGMENT_SIZE;
-
-		/* Each segment size is 128B. Write coalescing is enabled only
-		 * when SGE_EGRESS_QUEUES_PER_PAGE_PF reg value for the
-		 * queue is less no of segments that can be accommodated in
-		 * a page size.
-		 */
-		if (qpp > num_seg) {
-			dev_err(&pdev->dev,
-				"Incorrect number of egress queues per page\n");
-			err = -EINVAL;
-			goto out_free_adapter;
-		}
-		adapter->bar2 = ioremap_wc(pci_resource_start(pdev, 2),
-		pci_resource_len(pdev, 2));
-		if (!adapter->bar2) {
-			dev_err(&pdev->dev, "cannot map device bar2 region\n");
-			err = -ENOMEM;
-			goto out_free_adapter;
-		}
-	}
-
-	setup_memwin(adapter);
+	cxgb4_pci_setup_memwin(adapter);
 	err = adap_init0(adapter, 0);
 	if (err)
-		goto out_unmap_bar;
-
-	setup_memwin_rdma(adapter);
+		dev_err(adapter->pdev_dev,
+			"Adapter initialization failed, error %d. Continuing in debug mode\n",
+			-err);
 
-	/* configure SGE_STAT_CFG_A to read WC stats */
-	if (!is_t4(adapter->params.chip))
-		t4_write_reg(adapter, SGE_STAT_CFG_A, STATSOURCE_T5_V(7) |
-			     (is_t5(adapter->params.chip) ? STATMODE_V(0) :
-			      T6_STATMODE_V(0)));
+	cxgb4_pci_setup_memwin_rdma(adapter);
 
 	/* Initialize hash mac addr list */
 	INIT_LIST_HEAD(&adapter->mac_hlist);
@@ -6748,20 +6691,20 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 * know the actual # of EOTIDs supported.
 		 */
 		netdev = alloc_etherdev_mq(sizeof(struct port_info),
-					   MAX_ETH_QSETS + MAX_ATIDS);
+					   MAX_ETH_QSETS + CXGB4_MAX_ATIDS);
 		if (!netdev) {
 			err = -ENOMEM;
 			goto out_free_dev;
 		}
 
-		SET_NETDEV_DEV(netdev, &pdev->dev);
+		SET_NETDEV_DEV(netdev, adapter->pdev_dev);
 
 		adapter->port[i] = netdev;
 		pi = netdev_priv(netdev);
 		pi->adapter = adapter;
 		pi->xact_addr_filt = -1;
 		pi->port_id = i;
-		netdev->irq = pdev->irq;
+		netdev->irq = adapter->pdev->irq;
 
 		netdev->hw_features = NETIF_F_SG | TSO_FLAGS |
 			NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
@@ -6819,10 +6762,8 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	cxgb4_init_ethtool_dump(adapter);
 
-	pci_set_drvdata(pdev, adapter);
-
 	if (adapter->flags & CXGB4_FW_OK) {
-		err = t4_port_init(adapter, func, func, 0);
+		err = t4_port_init(adapter, adapter->mbox, adapter->pf, 0);
 		if (err)
 			goto out_free_dev;
 	} else if (adapter->params.nports == 1) {
@@ -6856,13 +6797,13 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->smt = t4_init_smt();
 	if (!adapter->smt) {
 		/* We tolerate a lack of SMT, giving up some functionality */
-		dev_warn(&pdev->dev, "could not allocate SMT, continuing\n");
+		dev_warn(adapter->pdev_dev, "could not allocate SMT, continuing\n");
 	}
 
 	adapter->l2t = t4_init_l2t(adapter->l2t_start, adapter->l2t_end);
 	if (!adapter->l2t) {
 		/* We tolerate a lack of L2T, giving up some functionality */
-		dev_warn(&pdev->dev, "could not allocate L2T, continuing\n");
+		dev_warn(adapter->pdev_dev, "could not allocate L2T, continuing\n");
 		adapter->params.offload = 0;
 	}
 
@@ -6872,9 +6813,8 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		/* CLIP functionality is not present in hardware,
 		 * hence disable all offload features
 		 */
-		dev_warn(&pdev->dev,
+		dev_warn(adapter->pdev_dev,
 			 "CLIP not enabled in hardware, continuing\n");
-		adapter->params.offload = 0;
 	} else {
 		adapter->clipt = t4_init_clip_tbl(adapter->clipt_start,
 						  adapter->clipt_end);
@@ -6882,9 +6822,8 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			/* We tolerate a lack of clip_table, giving up
 			 * some functionality
 			 */
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not allocate Clip table, continuing\n");
-			adapter->params.offload = 0;
 		}
 	}
 #endif
@@ -6893,7 +6832,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		pi = adap2pinfo(adapter, i);
 		pi->sched_tbl = t4_init_sched(adapter->params.nsched_cls);
 		if (!pi->sched_tbl)
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not activate scheduling on port %d\n",
 				 i);
 	}
@@ -6917,49 +6856,40 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	if (tid_init(&adapter->tids) < 0) {
-		dev_warn(&pdev->dev, "could not allocate TID table, "
+		dev_warn(adapter->pdev_dev, "could not allocate TID table, "
 			 "continuing\n");
 		adapter->params.offload = 0;
 	} else {
 		adapter->tc_u32 = cxgb4_init_tc_u32(adapter);
 		if (!adapter->tc_u32)
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not offload tc u32, continuing\n");
 
 		if (cxgb4_init_tc_flower(adapter))
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not offload tc flower, continuing\n");
 
 		if (cxgb4_init_tc_mqprio(adapter))
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not offload tc mqprio, continuing\n");
 
 		if (cxgb4_init_tc_matchall(adapter))
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not offload tc matchall, continuing\n");
 		if (cxgb4_init_ethtool_filters(adapter))
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not initialize ethtool filters, continuing\n");
 	}
 
-	/* See what interrupts we'll be using */
-	if (msi > 1 && enable_msix(adapter) == 0)
-		adapter->flags |= CXGB4_USING_MSIX;
-	else if (msi > 0 && pci_enable_msi(pdev) == 0) {
-		adapter->flags |= CXGB4_USING_MSI;
-		if (msi > 1)
-			free_msix_info(adapter);
-	}
-
-	/* check for PCI Express bandwidth capabiltites */
-	pcie_print_link_status(pdev);
-
-	cxgb4_init_mps_ref_entries(adapter);
-
 	err = init_rss(adapter);
 	if (err)
 		goto out_free_dev;
 
+	/* See what interrupts we'll be using */
+	err = enable_msix(adapter);
+	if (err)
+		goto out_disable_interrupts;
+
 	err = setup_non_data_intr(adapter);
 	if (err) {
 		dev_err(adapter->pdev_dev,
@@ -6975,6 +6905,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 fw_attach_fail:
+	cxgb4_init_mps_ref_entries(adapter);
 	/*
 	 * The card is now ready to go.  If any errors occur during device
 	 * registration we do not fail the whole card but rather proceed only
@@ -6992,26 +6923,25 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = register_netdev(adapter->port[i]);
 		if (err)
 			break;
+
 		adapter->chan_map[pi->tx_chan] = i;
 		print_port_info(adapter->port[i]);
 	}
 	if (i == 0) {
-		dev_err(&pdev->dev, "could not register any net devices\n");
+		dev_err(adapter->pdev_dev, "could not register any net devices\n");
 		goto out_free_dev;
 	}
 	if (err) {
-		dev_warn(&pdev->dev, "only %d net devices registered\n", i);
+		dev_warn(adapter->pdev_dev, "only %d net devices registered\n", i);
 		err = 0;
 	}
 
 	if (cxgb4_debugfs_root) {
-		adapter->debugfs_root = debugfs_create_dir(pci_name(pdev),
-							   cxgb4_debugfs_root);
-		setup_debugfs(adapter);
-	}
+		const char *dir_name = pci_name(adapter->pdev);
 
-	/* PCIe EEH recovery on powerpc platforms needs fundamental reset */
-	pdev->needs_freset = 1;
+		adapter->debugfs_root = debugfs_create_dir(dir_name, cxgb4_debugfs_root);
+		t4_setup_debugfs(adapter);
+	}
 
 	if (is_uld(adapter))
 		cxgb4_uld_enable(adapter);
@@ -7026,40 +6956,29 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	print_adapter_info(adapter);
 	return 0;
 
- out_free_dev:
+out_disable_interrupts:
+	disable_msi(adapter);
+
+out_free_dev:
 	t4_free_sge_resources(adapter);
 	free_some_resources(adapter);
-	if (adapter->flags & CXGB4_USING_MSIX)
-		free_msix_info(adapter);
 	if (adapter->num_uld || adapter->num_ofld_uld)
 		t4_uld_mem_free(adapter);
- out_unmap_bar:
-	if (!is_t4(adapter->params.chip))
-		iounmap(adapter->bar2);
- out_free_adapter:
-	if (adapter->workq)
-		destroy_workqueue(adapter->workq);
-
-	kfree(adapter->mbox_log);
-	kfree(adapter);
- out_unmap_bar0:
-	iounmap(regs);
- out_disable_device:
-	pci_disable_device(pdev);
- out_release_regions:
-	pci_release_regions(pdev);
+out_free_adapter:
+	cxgb4_workqueues_destroy(adapter);
+	cxgb4_pci_chip_free(adapter);
+
+out_free_resources:
+	cxgb4_pci_resource_free(adapter);
 	return err;
 }
 
-static void remove_one(struct pci_dev *pdev)
+void cxgb4_adap_remove(struct adapter *adapter)
 {
-	struct adapter *adapter = pci_get_drvdata(pdev);
 	struct hash_mac_addr *entry, *tmp;
 
-	if (!adapter) {
-		pci_release_regions(pdev);
+	if (!adapter)
 		return;
-	}
 
 	/* If we allocated filters, free up state associated with any
 	 * valid filters ...
@@ -7068,26 +6987,26 @@ static void remove_one(struct pci_dev *pdev)
 
 	adapter->flags |= CXGB4_SHUTTING_DOWN;
 
-	if (adapter->pf == 4) {
+	if (cxgb4_is_primary_pf(adapter)) {
 		int i;
 
 		/* Tear down per-adapter Work Queue first since it can contain
 		 * references to our adapter data structure.
 		 */
-		destroy_workqueue(adapter->workq);
+		cxgb4_workqueues_destroy(adapter);
 
-		detach_ulds(adapter);
+		if (is_uld(adapter)) {
+			if (!list_empty(&adapter->list_node))
+				detach_ulds(adapter);
+			t4_uld_clean_up(adapter);
+		}
+		adap_free_hma_mem(adapter);
+		disable_interrupts(adapter);
 
 		for_each_port(adapter, i)
 			if (adapter->port[i]->reg_state == NETREG_REGISTERED)
 				unregister_netdev(adapter->port[i]);
 
-		t4_uld_clean_up(adapter);
-
-		adap_free_hma_mem(adapter);
-
-		disable_interrupts(adapter);
-
 		cxgb4_free_mps_ref_entries(adapter);
 
 		debugfs_remove_recursive(adapter->debugfs_root);
@@ -7104,6 +7023,7 @@ static void remove_one(struct pci_dev *pdev)
 			free_msix_info(adapter);
 		if (adapter->num_uld || adapter->num_ofld_uld)
 			t4_uld_mem_free(adapter);
+
 		free_some_resources(adapter);
 		list_for_each_entry_safe(entry, tmp, &adapter->mac_hlist,
 					 list) {
@@ -7114,23 +7034,16 @@ static void remove_one(struct pci_dev *pdev)
 #if IS_ENABLED(CONFIG_IPV6)
 		t4_cleanup_clip_tbl(adapter);
 #endif
-		if (!is_t4(adapter->params.chip))
-			iounmap(adapter->bar2);
 	}
 #ifdef CONFIG_PCI_IOV
 	else {
 		cxgb4_iov_configure(adapter->pdev, 0);
 	}
 #endif
-	iounmap(adapter->regs);
-	if ((adapter->flags & CXGB4_DEV_ENABLED)) {
-		pci_disable_device(pdev);
-		adapter->flags &= ~CXGB4_DEV_ENABLED;
-	}
-	pci_release_regions(pdev);
-	kfree(adapter->mbox_log);
+	cxgb4_pci_chip_free(adapter);
+	cxgb4_pci_resource_free(adapter);
+	adapter->flags &= ~CXGB4_DEV_ENABLED;
 	synchronize_rcu();
-	kfree(adapter);
 }
 
 /* "Shutdown" quiesces the device, stopping Ingress Packet and Interrupt
@@ -7138,22 +7051,18 @@ static void remove_one(struct pci_dev *pdev)
  * function where we do the minimal amount of work necessary to shutdown any
  * further activity.
  */
-static void shutdown_one(struct pci_dev *pdev)
+void cxgb4_adap_shutdown(struct adapter *adapter)
 {
-	struct adapter *adapter = pci_get_drvdata(pdev);
-
 	/* As with remove_one() above (see extended comment), we only want do
 	 * do cleanup on PCI Devices which went all the way through init_one()
 	 * ...
 	 */
-	if (!adapter) {
-		pci_release_regions(pdev);
+	if (!adapter)
 		return;
-	}
 
 	adapter->flags |= CXGB4_SHUTTING_DOWN;
 
-	if (adapter->pf == 4) {
+	if (cxgb4_is_primary_pf(adapter)) {
 		int i;
 
 		for_each_port(adapter, i)
@@ -7178,33 +7087,21 @@ static void shutdown_one(struct pci_dev *pdev)
 	}
 }
 
-static struct pci_driver cxgb4_driver = {
-	.name     = KBUILD_MODNAME,
-	.id_table = cxgb4_pci_tbl,
-	.probe    = init_one,
-	.remove   = remove_one,
-	.shutdown = shutdown_one,
-#ifdef CONFIG_PCI_IOV
-	.sriov_configure = cxgb4_iov_configure,
-#endif
-	.err_handler = &cxgb4_eeh,
-};
-
 static int __init cxgb4_init_module(void)
 {
 	int ret;
 
 	cxgb4_debugfs_root = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	ret = pci_register_driver(&cxgb4_driver);
+	ret = cxgb4_pci_driver_register();
 	if (ret < 0)
-		goto err_pci;
+		goto out_err;
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (!inet6addr_registered) {
 		ret = register_inet6addr_notifier(&cxgb4_inet6addr_notifier);
 		if (ret)
-			pci_unregister_driver(&cxgb4_driver);
+			cxgb4_pci_driver_unregister();
 		else
 			inet6addr_registered = true;
 	}
@@ -7212,10 +7109,8 @@ static int __init cxgb4_init_module(void)
 
 	if (ret == 0)
 		return ret;
-
-err_pci:
+out_err:
 	debugfs_remove(cxgb4_debugfs_root);
-
 	return ret;
 }
 
@@ -7227,7 +7122,7 @@ static void __exit cxgb4_cleanup_module(void)
 		inet6addr_registered = false;
 	}
 #endif
-	pci_unregister_driver(&cxgb4_driver);
+	cxgb4_pci_driver_unregister();
 	debugfs_remove(cxgb4_debugfs_root);  /* NULL ok */
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c
new file mode 100644
index 000000000000..356109729d56
--- /dev/null
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file is part of the Chelsio T4/T5/T6/T7 Ethernet driver for Linux.
+ *
+ * Copyright (C) 2026 Chelsio Communications.  All rights reserved.
+ *
+ */
+
+#include <linux/crash_dump.h>
+
+#include "cxgb4.h"
+#include "t4_regs.h"
+
+#include "cxgb4_pci.h"
+
+int cxgb4_pci_resource_init(struct adapter *adap)
+{
+	struct pci_dev *pdev = adap->pdev;
+	int ret;
+
+	ret = pci_request_regions(pdev, KBUILD_MODNAME);
+	if (ret) {
+		/* Just info, some other driver may have claimed the device. */
+		dev_info(adap->pdev_dev, "cannot obtain PCI resources\n");
+		return ret;
+	}
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		dev_err(adap->pdev_dev, "cannot enable PCI device\n");
+		goto out_release_regions;
+	}
+	adap->flags |= CXGB4_DEV_ENABLED;
+
+	adap->regs = pci_ioremap_bar(pdev, 0);
+	if (!adap->regs) {
+		dev_err(adap->pdev_dev, "cannot map device registers\n");
+		ret = -ENOMEM;
+		goto out_disable_device;
+	}
+
+	adap->sge.tx_db_addr = adap->regs + MYPF_REG(SGE_PF_KDOORBELL_A);
+	adap->sge.rx_db_addr = adap->regs + MYPF_REG(SGE_PF_GTS_A);
+
+	adap->name = pci_name(pdev);
+	adap->primary_pf = CXGB4_UNIFIED_PF;
+	return 0;
+
+out_disable_device:
+	pci_disable_device(pdev);
+
+out_release_regions:
+	pci_release_regions(pdev);
+	return ret;
+}
+
+void cxgb4_pci_resource_free(struct adapter *adap)
+{
+	struct pci_dev *pdev = adap->pdev;
+
+	iounmap(adap->regs);
+	if ((adap->flags & CXGB4_DEV_ENABLED))
+		pci_disable_device(pdev);
+	pci_release_regions(pdev);
+}
+
+int cxgb4_pci_chip_init(struct adapter *adap)
+{
+	struct pci_dev *pdev = adap->pdev;
+	u16 device_id;
+	u32 whoami;
+	u8 func;
+	int ret;
+
+	/*
+	 * Note that we use the PL_WHOAMI register to figure out to which PF
+	 * we're actually attached rather than PCI_FUNC(pdev->devfn).  We do
+	 * this because we could be operating within a Virtual Machine where,
+	 * say, PF4 has been inserted via some form of "PCI Pass Through"
+	 * resulting in the VM PCI Device having a completely different PCI
+	 * Function Number, say, PF0.  However, there are many communications
+	 * with the firmware (and the hardware) where we need to use the
+	 * actual Physical Function Number and we can get this from the
+	 * PL_WHOAMI register ...
+	 */
+	whoami = t4_read_reg(adap, PL_WHOAMI_A);
+	pci_read_config_word(pdev, PCI_DEVICE_ID, &device_id);
+	ret = t4_get_chip_type(adap, CHELSIO_PCI_ID_VER(device_id));
+	if (ret < 0)
+		return ret;
+
+	adap->params.chip = ret;
+	func = CHELSIO_CHIP_VERSION(adap->params.chip) <= CHELSIO_T5 ?
+		       SOURCEPF_G(whoami) :
+		       T6_SOURCEPF_G(whoami);
+
+	adap->mbox = func;
+	adap->pf = func;
+
+	ret = cxgb4_mbox_log_init(adap);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * If we're not the MASTER Physical Function, there's not much more
+	 * we need to do.
+	 */
+	if (!cxgb4_is_primary_pf(adap)) {
+		/* We must be a PCIe SR-IOV Virtual Function.  We won't be
+		 * doing any DMA, but we will be offering VF Management
+		 * services ...
+		 */
+		pci_disable_device(pdev);
+		adap->flags &= ~CXGB4_DEV_ENABLED;
+		pci_save_state(pdev); /* to restore SR-IOV later */
+		return 0;
+	}
+
+	ret = dma_set_mask_and_coherent(adap->pdev_dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_err(adap->pdev_dev, "no usable DMA configuration\n");
+		goto out_free_mbox_log;
+	}
+
+	pci_set_master(pdev);
+	pci_save_state(pdev);
+
+	if (!is_t4(adap->params.chip)) {
+		adap->bar2 = ioremap_wc(pci_resource_start(pdev, 2),
+					pci_resource_len(pdev, 2));
+		if (!adap->bar2) {
+			dev_err(adap->pdev_dev,
+				"cannot map device bar2 region\n");
+			ret = -ENOMEM;
+			goto out_free_mbox_log;
+		}
+
+		t4_write_reg(adap, SGE_STAT_CFG_A,
+			     STATSOURCE_T5_V(7) | (is_t5(adap->params.chip) ?
+							   STATMODE_V(0) :
+							   T6_STATMODE_V(0)));
+	}
+
+       /* check for PCI Express bandwidth capabiltites */
+	pcie_print_link_status(pdev);
+
+	/* PCIe EEH recovery on powerpc platforms needs fundamental reset */
+	pdev->needs_freset = 1;
+
+	return 0;
+
+out_free_mbox_log:
+	kfree(adap->mbox_log);
+	return ret;
+}
+
+void cxgb4_pci_chip_free(struct adapter *adap)
+{
+	if (!is_t4(adap->params.chip)) {
+		if (adap->bar2)
+			iounmap(adap->bar2);
+	}
+
+	kfree(adap->mbox_log);
+}
+
+void cxgb4_pci_setup_memwin(struct adapter *adap)
+{
+	u32 nic_win_base = t4_get_util_window(adap);
+
+	t4_setup_memwin(adap, nic_win_base, MEMWIN_NIC);
+}
+
+void cxgb4_pci_setup_memwin_rdma(struct adapter *adap)
+{
+	unsigned int sz_kb;
+	u32 start;
+
+	if (!adap->vres.ocq.size)
+		return;
+
+	start = t4_read_pcie_cfg4(adap, PCI_BASE_ADDRESS_2);
+	start &= PCI_BASE_ADDRESS_MEM_MASK;
+	start += OCQ_WIN_OFFSET(adap->pdev, &adap->vres);
+	sz_kb = roundup_pow_of_two(adap->vres.ocq.size) >> WINDOW_SHIFT_X;
+
+	/*
+	 * Set up RDMA memory window for accessing adapter memory
+	 * ranges.  (Read back MA register to ensure that changes
+	 * propagate before we attempt to use the new values.)
+	 */
+	t4_write_reg(adap, t4_pcie_mem_access_base_win_reg(adap, MEMWIN_RDMA),
+		     start | BIR_V(1) | WINDOW_V(ilog2(sz_kb)));
+	t4_pcie_mem_access_offset_write(adap, adap->vres.ocq.start, MEMWIN_RDMA,
+					0);
+}
+
+int cxgb4_pci_fw_init(struct adapter *adap, enum dev_state *state)
+{
+	int ret;
+
+	/* Contact FW, advertising Master capability */
+	ret = t4_fw_hello(adap, adap->mbox, adap->mbox, MASTER_MAY, state);
+	if (ret < 0 && is_kdump_kernel())
+		ret = t4_fw_hello(adap, adap->mbox, adap->mbox, MASTER_MUST,
+				  state);
+	if (ret < 0) {
+		dev_err(adap->pdev_dev, "could not connect to FW, error %d\n",
+			ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+bool cxgb4_pci_msix_enabled(struct adapter *adap)
+{
+	if (!pci_dev_msi_enabled(adap->pdev))
+		return false;
+
+	return adap->pdev->msix_enabled;
+}
+
+bool cxgb4_pci_msi_enabled(struct adapter *adap)
+{
+	if (!pci_dev_msi_enabled(adap->pdev))
+		return false;
+
+	return adap->pdev->msi_enabled;
+}
+
+#ifdef CONFIG_PCI_IOV
+static int cxgb4_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	if (pci_is_bridge(pdev))
+		return -EOPNOTSUPP;
+
+	return cxgb4_iov_configure(pdev, num_vfs);
+}
+#endif
+
+static int cxgb4_pci_init_one(struct pci_dev *pdev,
+			      const struct pci_device_id *ent)
+{
+	struct adapter *adap;
+	int ret;
+
+	if (pci_is_bridge(pdev))
+		return 0;
+
+	adap = devm_kzalloc(&pdev->dev, sizeof(struct adapter), GFP_KERNEL);
+	if (!adap)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, adap);
+
+	adap->pdev = pdev;
+	adap->pdev_dev = &pdev->dev;
+
+	ret = cxgb4_adap_probe(adap);
+	if (ret < 0)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	pci_set_drvdata(pdev, NULL);
+	return ret;
+}
+
+static void cxgb4_pci_remove_one(struct pci_dev *pdev)
+{
+	if (pci_is_bridge(pdev))
+		return;
+
+	cxgb4_adap_remove(pci_get_drvdata(pdev));
+	pci_set_drvdata(pdev, NULL);
+}
+
+static void cxgb4_pci_shutdown_one(struct pci_dev *pdev)
+{
+	if (pci_is_bridge(pdev))
+		return;
+
+	cxgb4_adap_shutdown(pci_get_drvdata(pdev));
+}
+
+#define CH_PCI_DEVICE_ID_TABLE_DEFINE_BEGIN \
+static const struct pci_device_id cxgb4_pci_tbl[] = {
+#define CH_PCI_DEVICE_ID_FUNCTION CXGB4_UNIFIED_PF
+#define CH_PCI_DEVICE_ID_FUNCTION2 0x0
+
+#define CH_PCI_ID_TABLE_ENTRY(devid) \
+	{ PCI_VDEVICE(CHELSIO, (devid)), CXGB4_UNIFIED_PF }
+
+#define CH_PCI_DEVICE_ID_TABLE_DEFINE_END \
+	{ 0, } \
+}
+
+#include "t4_pci_id_tbl.h"
+
+static const struct pci_error_handlers cxgb4_pci_eeh = {
+	.error_detected = cxgb4_pci_eeh_err_detected,
+	.slot_reset = cxgb4_pci_eeh_slot_reset,
+	.resume = cxgb4_pci_eeh_resume,
+	.reset_prepare = cxgb4_pci_eeh_reset_prepare,
+	.reset_done = cxgb4_pci_eeh_reset_done,
+};
+
+static struct pci_driver cxgb4_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = cxgb4_pci_tbl,
+	.probe = cxgb4_pci_init_one,
+	.remove = cxgb4_pci_remove_one,
+	.shutdown = cxgb4_pci_shutdown_one,
+#ifdef CONFIG_PCI_IOV
+	.sriov_configure = cxgb4_pci_sriov_configure,
+#endif
+	.err_handler = &cxgb4_pci_eeh,
+};
+
+int cxgb4_pci_driver_register(void)
+{
+	return pci_register_driver(&cxgb4_pci_driver);
+}
+
+void cxgb4_pci_driver_unregister(void)
+{
+	pci_unregister_driver(&cxgb4_pci_driver);
+}
+
+MODULE_DEVICE_TABLE(pci, cxgb4_pci_tbl);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.h
new file mode 100644
index 000000000000..78a814207f61
--- /dev/null
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Copyright (C) 2026 Chelsio Communications.  All rights reserved.
+ */
+
+#ifndef __CXGB4_PCI_H__
+#define __CXGB4_PCI_H__
+
+#define CXGB4_UNIFIED_PF 0x4
+
+int cxgb4_pci_resource_init(struct adapter *adap);
+void cxgb4_pci_resource_free(struct adapter *adap);
+int cxgb4_pci_chip_init(struct adapter *adap);
+void cxgb4_pci_chip_free(struct adapter *adap);
+void cxgb4_pci_setup_memwin(struct adapter *adap);
+void cxgb4_pci_setup_memwin_rdma(struct adapter *adap);
+int cxgb4_pci_fw_init(struct adapter *adap, enum dev_state *state);
+bool cxgb4_pci_msix_enabled(struct adapter *adap);
+bool cxgb4_pci_msi_enabled(struct adapter *adap);
+
+int cxgb4_pci_driver_register(void);
+void cxgb4_pci_driver_unregister(void);
+#endif /* __CXGB4_PCI_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 4fe6c10d50e0..492cd35ce9d2 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -496,8 +496,7 @@ static inline void ring_fl_db(struct adapter *adap, struct sge_fl *q)
 		 * mechanism.
 		 */
 		if (unlikely(q->bar2_addr == NULL)) {
-			t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-				     val | QID_V(q->cntxt_id));
+			writel(val | QID_V(q->cntxt_id), adap->sge.tx_db_addr);
 		} else {
 			writel(val | QID_V(q->bar2_qid),
 			       q->bar2_addr + SGE_UDB_KDOORBELL);
@@ -734,14 +733,14 @@ static inline int is_eth_imm(const struct sk_buff *skb, unsigned int chip_ver)
 	if (skb->encapsulation && skb_shinfo(skb)->gso_size &&
 	    chip_ver > CHELSIO_T5) {
 		hdrlen = sizeof(struct cpl_tx_tnl_lso);
-		hdrlen += sizeof(struct cpl_tx_pkt_core);
 	} else if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
 		return 0;
 	} else {
 		hdrlen = skb_shinfo(skb)->gso_size ?
 			 sizeof(struct cpl_tx_pkt_lso_core) : 0;
-		hdrlen += sizeof(struct cpl_tx_pkt);
 	}
+
+	hdrlen += sizeof(struct cpl_tx_pkt);
 	if (skb->len <= MAX_IMM_TX_PKT_LEN - hdrlen)
 		return hdrlen;
 	return 0;
@@ -984,6 +983,7 @@ void cxgb4_write_partial_sgl(const struct sk_buff *skb, struct sge_txq *q,
 }
 EXPORT_SYMBOL(cxgb4_write_partial_sgl);
 
+#if defined(ARCH_HAS_IOREMAP_WC)
 /* This function copies 64 byte coalesced work request to
  * memory mapped BAR2 space. For coalesced WR SGE fetches
  * data from the FIFO instead of from Host.
@@ -999,6 +999,7 @@ static void cxgb_pio_copy(u64 __iomem *dst, u64 *src)
 		count--;
 	}
 }
+#endif
 
 /**
  *	cxgb4_ring_tx_db - check and potentially ring a Tx queue's doorbell
@@ -1010,11 +1011,6 @@ static void cxgb_pio_copy(u64 __iomem *dst, u64 *src)
  */
 inline void cxgb4_ring_tx_db(struct adapter *adap, struct sge_txq *q, int n)
 {
-	/* Make sure that all writes to the TX Descriptors are committed
-	 * before we tell the hardware about them.
-	 */
-	wmb();
-
 	/* If we don't have access to the new User Doorbell (T5+), use the old
 	 * doorbell mechanism; otherwise use the new BAR2 mechanism.
 	 */
@@ -1027,8 +1023,7 @@ inline void cxgb4_ring_tx_db(struct adapter *adap, struct sge_txq *q, int n)
 		 */
 		spin_lock_irqsave(&q->db_lock, flags);
 		if (!q->db_disabled)
-			t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-				     QID_V(q->cntxt_id) | val);
+			writel(val | QID_V(q->cntxt_id), adap->sge.tx_db_addr);
 		else
 			q->db_pidx_inc += n;
 		q->db_pidx = q->pidx;
@@ -1044,6 +1039,15 @@ inline void cxgb4_ring_tx_db(struct adapter *adap, struct sge_txq *q, int n)
 		 */
 		WARN_ON(val & DBPRIO_F);
 
+		/*
+		 * Make sure that all writes to the TX Descriptors are committed
+		 * before we tell the hardware about them.
+		 */
+		wmb();
+
+#if !defined(ARCH_HAS_IOREMAP_WC)
+		writel(val | QID_V(q->bar2_qid), q->bar2_addr + SGE_UDB_KDOORBELL);
+#else
 		/* If we're only writing a single TX Descriptor and we can use
 		 * Inferred QID registers, we can use the Write Combining
 		 * Gather Buffer; otherwise we use the simple doorbell.
@@ -1072,6 +1076,7 @@ inline void cxgb4_ring_tx_db(struct adapter *adap, struct sge_txq *q, int n)
 		 * PIDX (User Doorbell area SGE_UDB_KDOORBELL) and have the
 		 * hardware DMA read the actual Work Request.
 		 */
+#endif
 		wmb();
 	}
 }
@@ -1299,6 +1304,7 @@ enum cpl_tx_tnl_lso_type cxgb_encap_offload_supported(struct sk_buff *skb)
 
 	return tnl_type;
 }
+EXPORT_SYMBOL(cxgb_encap_offload_supported);
 
 static inline void t6_fill_tnl_lso(struct sk_buff *skb,
 				   struct cpl_tx_tnl_lso *tnl_lso,
@@ -1510,6 +1516,7 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 	pi = netdev_priv(dev);
 	adap = pi->adapter;
 	ssi = skb_shinfo(skb);
+
 #if IS_ENABLED(CONFIG_CHELSIO_IPSEC_INLINE)
 	if (xfrm_offload(skb) && !ssi->gso_size)
 		return adap->uld[CXGB4_ULD_IPSEC].tx_handler(skb, dev);
@@ -3036,6 +3043,7 @@ static void service_ofldq(struct sge_uld_txq *q)
 		__skb_unlink(skb, &q->sendq);
 		if (is_ofld_imm(skb))
 			kfree_skb(skb);
+
 	}
 	if (likely(written))
 		cxgb4_ring_tx_db(q->adap, &q->q, written);
@@ -3662,17 +3670,17 @@ static int cxgb4_validate_lb_pkt(struct port_info *pi, const struct pkt_gl *si)
 int t4_ethrx_handler(struct sge_rspq *q, const __be64 *rsp,
 		     const struct pkt_gl *si)
 {
-	bool csum_ok;
-	struct sk_buff *skb;
-	const struct cpl_rx_pkt *pkt;
 	struct sge_eth_rxq *rxq = container_of(q, struct sge_eth_rxq, rspq);
 	struct adapter *adapter = q->adap;
 	struct sge *s = &q->adap->sge;
 	int cpl_trace_pkt = is_t4(q->adap->params.chip) ?
 			    CPL_TRACE_PKT : CPL_TRACE_PKT_T5;
 	u16 err_vec, tnl_hdr_len = 0;
+	const struct cpl_rx_pkt *pkt;
+	struct sk_buff *skb;
 	struct port_info *pi;
 	int ret = 0;
+	bool csum_ok;
 
 	pi = netdev_priv(q->netdev);
 	/* If we're looking at TX Queue CIDX Update, handle that separately
@@ -4011,8 +4019,8 @@ static int napi_rx_handler(struct napi_struct *napi, int budget)
 	 * doorbell mechanism; otherwise use the new BAR2 mechanism.
 	 */
 	if (unlikely(q->bar2_addr == NULL)) {
-		t4_write_reg(q->adap, MYPF_REG(SGE_PF_GTS_A),
-			     val | INGRESSQID_V((u32)q->cntxt_id));
+		writel(val | INGRESSQID_V((u32)q->cntxt_id),
+		       q->adap->sge.rx_db_addr);
 	} else {
 		writel(val | INGRESSQID_V(q->bar2_qid),
 		       q->bar2_addr + SGE_UDB_GTS);
@@ -4346,6 +4354,9 @@ static void __iomem *bar2_address(struct adapter *adapter,
 	u64 bar2_qoffset;
 	int ret;
 
+	if (!adapter->bar2)
+		return NULL;
+
 	ret = t4_bar2_sge_qregs(adapter, qid, qtype, 0,
 				&bar2_qoffset, pbar2_qid);
 	if (ret)
@@ -4409,17 +4420,19 @@ int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 		 * descriptor ring.  The free list size needs to be a multiple
 		 * of the Egress Queue Unit and at least 2 Egress Units larger
 		 * than the SGE's Egress Congrestion Threshold
-		 * (fl_starve_thres - 1).
+		 * (fl_starve_thres).
 		 */
-		if (fl->size < s->fl_starve_thres - 1 + 2 * 8)
-			fl->size = s->fl_starve_thres - 1 + 2 * 8;
+		if (fl->size < s->fl_starve_thres + 2 * 8)
+			fl->size = s->fl_starve_thres + 2 * 8;
 		fl->size = roundup(fl->size, 8);
 		fl->desc = alloc_ring(adap->pdev_dev, fl->size, sizeof(__be64),
 				      sizeof(struct rx_sw_desc), &fl->addr,
 				      &fl->sdesc, s->stat_len,
 				      dev_to_node(adap->pdev_dev));
-		if (!fl->desc)
-			goto fl_nomem;
+		if (!fl->desc) {
+			ret = -ENOMEM;
+			goto err;
+		}
 
 		flsz = fl->size / 8 + s->stat_len / sizeof(struct tx_desc);
 		c.iqns_to_fl0congen |= htonl(FW_IQ_CMD_FL0PACKEN_F |
@@ -4532,8 +4545,6 @@ int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 
 	return 0;
 
-fl_nomem:
-	ret = -ENOMEM;
 err:
 	if (iq->desc) {
 		dma_free_coherent(adap->pdev_dev, iq->size * iq->iqe_len,
@@ -4644,18 +4655,12 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 				    FW_EQ_ETH_CMD_TIMERIX_V(txq->dbqtimerix));
 
 	ret = t4_wr_mbox(adap, adap->mbox, &c, sizeof(c), &c);
-	if (ret) {
-		kfree(txq->q.sdesc);
-		txq->q.sdesc = NULL;
-		dma_free_coherent(adap->pdev_dev,
-				  nentries * sizeof(struct tx_desc),
-				  txq->q.desc, txq->q.phys_addr);
-		txq->q.desc = NULL;
-		return ret;
-	}
+	if (ret < 0)
+		goto out_free_txq;
 
 	txq->q.q_type = CXGB4_TXQ_ETH;
 	init_txq(adap, &txq->q, FW_EQ_ETH_CMD_EQID_G(ntohl(c.eqid_pkd)));
+
 	txq->txq = netdevq;
 	txq->tso = 0;
 	txq->uso = 0;
@@ -4663,8 +4668,15 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 	txq->vlan_ins = 0;
 	txq->mapping_err = 0;
 	txq->dbqt = dbqt;
-
 	return 0;
+
+out_free_txq:
+	kfree(txq->q.sdesc);
+	txq->q.sdesc = NULL;
+	dma_free_coherent(adap->pdev_dev, nentries * sizeof(struct tx_desc),
+			  txq->q.desc, txq->q.phys_addr);
+	txq->q.desc = NULL;
+	return ret;
 }
 
 int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
@@ -4708,21 +4720,23 @@ int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 	c.eqaddr = cpu_to_be64(txq->q.phys_addr);
 
 	ret = t4_wr_mbox(adap, adap->mbox, &c, sizeof(c), &c);
-	if (ret) {
-		dma_free_coherent(adap->pdev_dev,
-				  nentries * sizeof(struct tx_desc),
-				  txq->q.desc, txq->q.phys_addr);
-		txq->q.desc = NULL;
-		return ret;
-	}
+	if (ret < 0)
+		goto out_free_ctrlq;
 
-	txq->q.q_type = CXGB4_TXQ_CTRL;
 	init_txq(adap, &txq->q, FW_EQ_CTRL_CMD_EQID_G(ntohl(c.cmpliqid_eqid)));
+
+	txq->q.q_type = CXGB4_TXQ_CTRL;
 	txq->adap = adap;
 	skb_queue_head_init(&txq->sendq);
 	tasklet_setup(&txq->qresume_tsk, restart_ctrlq);
 	txq->full = 0;
 	return 0;
+
+out_free_ctrlq:
+	dma_free_coherent(adap->pdev_dev, nentries * sizeof(struct tx_desc),
+			  txq->q.desc, txq->q.phys_addr);
+	txq->q.desc = NULL;
+	return ret;
 }
 
 int t4_sge_mod_ctrl_txq(struct adapter *adap, unsigned int eqid,
-- 
2.39.1

