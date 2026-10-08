Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972714B3365;
	Thu,  8 Oct 2026 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470010; cv=none; b=Hdfz/yLn37xz5INJ1RI1c4zeiDP+gyaKQDygirs5woGKnDdHnrK+0wILApJyeOrTg6EPJB3mMPOh6/47FG4comI4Re49i9MLm/wH/MApwHu46+hihHaxFUZFzLMFnC7tAo4ojXZJgxfqwjDksp9e7OgP0UsloBA4hIouF8z/GU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470010; c=relaxed/simple;
	bh=081OT79ESADLQjKABpXgPLkdKKM4hbV2uxb5WjdjdJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtrFRnQ8MWTIMPaVsVpC/W1NoDRaaIkHlmXd4RAhRwS4H08AHiV/H2HQFyfJBLVsbIygTGCASEeb0mwiOQqSuNiy6mGEIupWPfk/bViSB5dBA0ERW/oS+nqtAIwxDROhGuxdaKkIkT5tzncgYytSvUmrF37BMtkYnh+okVKg8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org; spf=pass smtp.mailfrom=phrozen.org; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1400:26fc:ddc6:af15:b0f7:2808] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xEpBC-000l4X-16;
	Thu, 08 Oct 2026 16:33:06 +0200
From: John Crispin <john@phrozen.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [RFC net-next 04/12] net: pon: add the device state and the lent context
Date: Thu,  8 Oct 2026 16:32:41 +0200
Message-Id: <20261008143249.3439762-5-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008143249.3439762-1-john@phrozen.org>
References: <20261008143249.3439762-1-john@phrozen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core lends a MAC driver its serialized context: one ordered
workqueue per instance and the instance lock, which the netlink handlers
take in their pre_doit. A driver queues a pon_work from any context. The
handler runs with the lock held, so a PLOAM transition never interleaves
with a netlink transaction.

The core owns the activation state. A driver reports the state it
reached through pon_dev_state_report(). The core validates the edge
against Table C.12.4 of ITU-T G.9807.1, publishes it and warns about an
illegal edge instead of hiding it. The PON network devices have a
carrier in O5 and O6 while a GEM port rides a bound alloc-id and the
conduit is paired and up. The driver reports the assignment and the
release of an alloc-id through pon_dev_event(), which is where the
carrier learns of them.

Every edge that pon_dev_state_report() publishes gets one line in the
kernel log at info level, for example "pon0: PLOAM state O5 -> O6". An
XGS-PON ONU is often a router whose developers watch the serial
console. The state reaches userspace through ploam-ntf only, so without
the line the console shows nothing when the ONU loses its link or comes
back. A repeated report changes nothing and logs nothing. The line uses
the names of the uapi states. O2 is named O2-3 in every mode but G-PON,
because ITU-T G.9807.1 Table C.12.1 has one Serial Number state that a
driver reports as o2.

A print to a serial console blocks for milliseconds, while the driver's
PLOAM work answers the OLT within a deadline. pon_dev_log() therefore
records a line in a ring of PON_LOG_LINES lines under the instance lock
and queues a work item on system_dfl_wq that prints it. The work holds
the lock only to take one line out, never across a print. The lines
keep their order. A full ring drops the oldest line and counts it. The
count is printed in its place. Nothing is recorded once unregister has
begun. Each line keeps its printk level. pon_dev_log() records at info
level. The core helper pon_dev_log_level() takes the level from its
caller.

pon_dev_log() is exported for a PON MAC driver: only the driver knows
why it leaves an activation state. It logs that from the same PLOAM
work, so it must not print there either. Through the same ring its line
keeps its place next to the edge that the core logs.

types.h and functions.h carry the whole contract between the core and a
driver, so the files that follow add code and no declarations.

The lent context exists for the MAC driver more than for the core. A PON
MAC signals PLOAM messages and PHY edges in hard interrupt context,
while its state machine sleeps and must not run against a netlink
transaction. The driver therefore queues a pon_work from its interrupt
handler. The handler runs under the instance lock. The core's own user
of this context is the OMCI receive path. A plain work item would serve
it. The mechanism exists for the driver.

The same holds for the reports. pon_dev_state_report() and
pon_dev_event() have no caller in the core: the driver runs the state
machine and receives the messages of the OLT. The core validates,
publishes and relays what the driver reports.

Assisted-by: LLM
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/pon.h           |  14 ++
 include/net/pon/functions.h | 129 +++++++++++
 include/net/pon/types.h     | 443 ++++++++++++++++++++++++++++++++++++
 net/pon/pon.h               | 162 +++++++++++++
 net/pon/pon_state.c         | 408 +++++++++++++++++++++++++++++++++
 net/pon/pon_work.c          | 106 +++++++++
 6 files changed, 1262 insertions(+)
 create mode 100644 include/net/pon.h
 create mode 100644 include/net/pon/functions.h
 create mode 100644 include/net/pon/types.h
 create mode 100644 net/pon/pon.h
 create mode 100644 net/pon/pon_state.c
 create mode 100644 net/pon/pon_work.c

diff --git a/include/net/pon.h b/include/net/pon.h
new file mode 100644
index 000000000000..5c85f73f98f9
--- /dev/null
+++ b/include/net/pon.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2026 John Crispin <john@phrozen.org> */
+
+#ifndef __NET_PON_ALL_H
+#define __NET_PON_ALL_H
+
+#include <uapi/linux/pon.h>
+#include <net/pon/ploam.h>
+#include <net/pon/types.h>
+#include <net/pon/functions.h>
+
+/* Do not add any code here. Put it in the sub-headers instead. */
+
+#endif /* __NET_PON_ALL_H */
diff --git a/include/net/pon/functions.h b/include/net/pon/functions.h
new file mode 100644
index 000000000000..aa5110b47663
--- /dev/null
+++ b/include/net/pon/functions.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2026 John Crispin <john@phrozen.org> */
+
+#ifndef __NET_PON_FUNCTIONS_H
+#define __NET_PON_FUNCTIONS_H
+
+#include <linux/netdevice.h>
+#include <linux/rcupdate.h>
+#include <net/pon/types.h>
+
+struct pon_dev;
+struct pon_dev_caps;
+struct pon_dev_ops;
+struct sk_buff;
+
+#if IS_ENABLED(CONFIG_PON)
+
+void pon_work_queue(struct pon_dev *pdev, struct pon_work *work);
+
+/**
+ * pon_work_init() - prepare a work item
+ * @work: the item
+ * @func: the handler pon_work_queue() runs
+ *
+ * Call once before the item is first queued.
+ */
+static inline void pon_work_init(struct pon_work *work, pon_work_func_t func)
+{
+	INIT_LIST_HEAD(&work->entry);
+	work->func = func;
+}
+
+struct pon_dev *pon_dev_create(struct net_device *netdev,
+			       struct device *parent,
+			       const struct pon_dev_ops *ops,
+			       const struct pon_dev_caps *caps,
+			       enum pon_mode mode, void *priv_ptr);
+void pon_dev_unregister(struct pon_dev *pdev);
+void pon_dev_put(struct pon_dev *pdev);
+
+int pon_dev_state_report(struct pon_dev *pdev,
+			 enum pon_ploam_state state);
+__printf(2, 3) void pon_dev_log(struct pon_dev *pdev, const char *fmt, ...);
+void pon_dev_event(struct pon_dev *pdev, const struct pon_event *ev);
+
+int pon_conduit_register(struct net_device *conduit,
+			 const struct pon_conduit_ops *ops);
+void pon_conduit_unregister(struct net_device *conduit);
+int pon_conduit_rx(struct net_device *conduit, struct sk_buff *skb,
+		   const struct pon_rx_info *info);
+int pon_conduit_xmit(struct pon_dev *pdev, struct sk_buff *skb,
+		     const struct pon_tx_info *info);
+int pon_conduit_addr_set(struct pon_dev *pdev, const u8 *addr);
+int pon_conduit_mtu_set(struct pon_dev *pdev, const struct net_device *dev,
+			unsigned int mtu);
+/**
+ * netdev_uses_pon() - whether a network device belongs to a PON MAC
+ * @dev: the network device
+ *
+ * True for the PON data interface, for a GEM network device and for a
+ * conduit that is paired with a PON MAC.
+ *
+ * Return: true when @dev points at a PON instance.
+ */
+static inline bool netdev_uses_pon(const struct net_device *dev)
+{
+	return rcu_access_pointer(dev->pon_dev);
+}
+
+#else /* CONFIG_PON */
+
+/**
+ * pon_conduit_register() - offer a network device's rings to a PON MAC
+ * @conduit: the ethernet device
+ * @ops: what the driver does for the MAC
+ *
+ * The stub for a kernel without CONFIG_PON.
+ *
+ * Return: -ENOENT, there is no PON MAC to serve.
+ */
+static inline int pon_conduit_register(struct net_device *conduit,
+				       const struct pon_conduit_ops *ops)
+{
+	return -ENOENT;
+}
+
+/**
+ * pon_conduit_unregister() - take a network device's rings back
+ * @conduit: the ethernet device
+ *
+ * The stub for a kernel without CONFIG_PON. It does nothing.
+ */
+static inline void pon_conduit_unregister(struct net_device *conduit)
+{
+}
+
+/**
+ * pon_conduit_rx() - hand one received frame to the PON MAC that owns it
+ * @conduit: the ethernet device the frame arrived on
+ * @skb: the frame
+ * @info: what the receive descriptor said about it
+ *
+ * The stub for a kernel without CONFIG_PON. The frame stays the conduit's.
+ *
+ * Return: -ENODEV.
+ */
+static inline int pon_conduit_rx(struct net_device *conduit,
+				 struct sk_buff *skb,
+				 const struct pon_rx_info *info)
+{
+	return -ENODEV;
+}
+
+/**
+ * netdev_uses_pon() - whether a network device belongs to a PON MAC
+ * @dev: the network device
+ *
+ * The stub for a kernel without CONFIG_PON.
+ *
+ * Return: false.
+ */
+static inline bool netdev_uses_pon(const struct net_device *dev)
+{
+	return false;
+}
+
+#endif /* CONFIG_PON */
+
+#endif /* __NET_PON_FUNCTIONS_H */
diff --git a/include/net/pon/types.h b/include/net/pon/types.h
new file mode 100644
index 000000000000..0320c1e1dc10
--- /dev/null
+++ b/include/net/pon/types.h
@@ -0,0 +1,443 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2026 John Crispin <john@phrozen.org> */
+
+#ifndef __NET_PON_TYPES_H
+#define __NET_PON_TYPES_H
+
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/refcount.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+#include <net/pon/ploam.h>
+#include <uapi/linux/pon.h>
+
+struct net_device;
+struct netlink_ext_ack;
+struct pon_conduit;
+struct pon_dev;
+struct pon_work;
+struct sk_buff;
+
+#define PON_LOG_LINES		16
+#define PON_LOG_LINE_LEN	64
+
+typedef void (*pon_work_func_t)(struct pon_dev *pdev, struct pon_work *work);
+
+/**
+ * struct pon_work - a work item that runs in the instance's context
+ * @entry: link in the instance's work list
+ * @func: what to run
+ *
+ * The core lends a driver its serialized context. The handler runs on the
+ * instance's ordered workqueue with the instance lock held, so it may sleep
+ * and it cannot interleave with a netlink transaction.
+ */
+struct pon_work {
+	struct list_head entry;
+	pon_work_func_t func;
+};
+
+/* The wire defines these, so they come from the PLOAM vocabulary. */
+#define PON_SERIAL_LEN		PON_PLOAM_SN_LEN
+#define PON_REG_ID_LEN		PON_PLOAM_REG_ID_LEN
+
+/**
+ * struct pon_identity - what dev-set delivers, identity and the settings
+ *			 that travel with it
+ * @mode: requested operating mode, enum pon_mode
+ * @serial: serial number, 4 ASCII vendor id then 4 vendor specific bytes
+ * @reg_id: registration id used for XG(S)-PON authentication, padded with
+ *	    0x00 bytes to PON_REG_ID_LEN (ITU-T G.9807.1 Table C.11.25)
+ * @serial_set: @serial carries a value
+ * @mode_set: @mode carries a value
+ * @reg_id_len: PON_REG_ID_LEN when @reg_id carries a value, 0 when absent
+ */
+struct pon_identity {
+	enum pon_mode mode;
+	u8 serial[PON_SERIAL_LEN];
+	u8 reg_id[PON_REG_ID_LEN];
+	bool serial_set;
+	bool mode_set;
+	u8 reg_id_len;
+};
+
+/**
+ * struct pon_tcont_cfg - one T-CONT binding
+ * @index: T-CONT index in the device, 0 based
+ * @alloc_id: alloc-id assigned by the OLT
+ */
+struct pon_tcont_cfg {
+	u16 index;
+	u16 alloc_id;
+};
+
+/**
+ * struct pon_gem_cfg - one GEM port
+ * @id: GEM port id assigned by the OLT
+ * @dir: direction, enum pon_gem_dir
+ * @tcont_index: T-CONT the upstream half rides, valid when @tcont_valid
+ * @alloc_id: alloc-id of that T-CONT, resolved by the core, 0 when
+ *	@tcont_valid is false
+ * @key_ring: encryption key ring, enum pon_gem_key_ring (ITU-T G.988
+ *	clause 9.2.3), never broadcast
+ * @tcont_valid: @tcont_index carries a value. A downstream broadcast GEM
+ *	carries none
+ */
+struct pon_gem_cfg {
+	u16 id;
+	enum pon_gem_dir dir;
+	u16 tcont_index;
+	u16 alloc_id;
+	enum pon_gem_key_ring key_ring;
+	bool tcont_valid;
+};
+
+/**
+ * struct pon_gem_map_cfg - one upstream classifier rule
+ * @gem_id: GEM port the matching frames map to
+ * @vid: outer VLAN ID to match, valid when @vid_valid
+ * @tagged: tag state to match, valid when @tag_valid
+ * @pbit: outer VLAN priority to match, valid when @pbit_valid
+ * @dscp: IP DSCP to match, valid when @dscp_valid
+ * @tag_valid: @tagged carries a value
+ * @vid_valid: @vid carries a value
+ * @pbit_valid: @pbit carries a value
+ * @dscp_valid: @dscp carries a value
+ *
+ * A rule matches on the members marked valid. A more specific rule
+ * wins over a less specific one.
+ */
+struct pon_gem_map_cfg {
+	u16 gem_id;
+	u16 vid;
+	bool tagged;
+	u8 pbit;
+	u8 dscp;
+	bool tag_valid;
+	bool vid_valid;
+	bool pbit_valid;
+	bool dscp_valid;
+};
+
+/**
+ * enum pon_event_type - what a driver reports through pon_dev_event()
+ * @PON_EVENT_TYPE_TCONT_ALLOC: the OLT assigned an alloc-id with the
+ *	Assign_Alloc-ID message of ITU-T G.9807.1 clause C.11.3.3.7 and the
+ *	driver bound it to a transmit channel
+ * @PON_EVENT_TYPE_TCONT_DEALLOC: the OLT deallocated the alloc-id with the
+ *	same message and the driver released its channel. The GEM ports that
+ *	ride it carry no upstream traffic until the OLT assigns it again
+ */
+enum pon_event_type {
+	PON_EVENT_TYPE_TCONT_ALLOC,
+	PON_EVENT_TYPE_TCONT_DEALLOC,
+};
+
+/**
+ * struct pon_event - a discrete event a driver reports
+ * @type: what happened, enum pon_event_type
+ * @alloc_id: the alloc-id the OLT allocated or deallocated
+ */
+struct pon_event {
+	enum pon_event_type type;
+	u32 alloc_id;
+};
+
+/**
+ * struct pon_dev_caps - what the device supports
+ * @modes: bitmask of enum pon_mode the hardware can run
+ * @max_tconts: number of T-CONTs
+ * @max_gems: number of GEM ports userspace can create, not counting the
+ *	      GEM port of the OMCC, which the driver holds itself
+ */
+struct pon_dev_caps {
+	u32 modes;
+	u16 max_tconts;
+	u16 max_gems;
+};
+
+/**
+ * struct pon_tx_info - what the conduit needs to send one frame
+ * @gem: the GEM port id the frame goes out on
+ * @channel: the transmit channel the MAC driver bound the T-CONT to. The
+ *	     core carries it between the two drivers and does not interpret it
+ * @queue: the queue within that channel
+ * @mic_index: which OMCI integrity key signs the PDU, valid when @oam
+ * @oam: the frame is an OMCI PDU rather than an Ethernet frame
+ */
+struct pon_tx_info {
+	u16 gem;
+	u8 channel;
+	u8 queue;
+	u8 mic_index;
+	bool oam;
+};
+
+/**
+ * struct pon_rx_info - what the conduit learned from the receive descriptor
+ * @gem: the GEM port id the frame arrived on
+ * @oam: the frame is an OMCI PDU
+ * @mic_unchecked: the MAC did not verify the integrity of the PDU, valid when
+ *		   @oam
+ */
+struct pon_rx_info {
+	u16 gem;
+	bool oam;
+	bool mic_unchecked;
+};
+
+/**
+ * struct pon_conduit_ops - what the ethernet driver does for a PON MAC
+ * @xmit: queue one frame on the conduit's rings with a descriptor built from
+ *	  @info. Owns the skb from the call on (as ndo_start_xmit does) and
+ *	  returns NETDEV_TX_BUSY only when the frame was not taken. Called
+ *	  under rcu_read_lock() with bottom halves disabled, from every PON
+ *	  network device and the OMCI channel at once and without the
+ *	  conduit's own transmit lock, so the driver locks its ring itself.
+ */
+struct pon_conduit_ops {
+	netdev_tx_t (*xmit)(struct net_device *conduit, struct sk_buff *skb,
+			    const struct pon_tx_info *info);
+};
+
+/**
+ * struct pon_dev - one PON MAC
+ * @main_netdev: the PON data network device
+ * @conduit: the ethernet device whose rings carry the frames and what its
+ *	     driver does for the MAC, published as one pointer once the driver
+ *	     has registered it, read under RCU, written under pon_devs_lock
+ * @conduit_tracker: the reference held on the ethernet device of @conduit
+ * @parent: the MAC's device, which every interface the core creates
+ *	    parents onto and whose firmware node a conduit names
+ * @ops: driver callbacks, NULL once the driver has unregistered. The
+ *	 transmit paths read it once under RCU
+ * @caps: device capabilities
+ * @drv_priv: driver priv pointer
+ * @lock: instance lock and the driver's upcalls. It protects every field
+ *	  below it, with these exceptions. @conduit is @pon_devs_lock's. The
+ *	  OMCI fields name their own rules. @ploam and @going_away are
+ *	  written under the lock and read without it through READ_ONCE()
+ * @refcnt: reference count for the instance
+ * @id: instance id
+ * @mode: active mode, enum pon_mode
+ * @ploam: activation state as the driver last reported it
+ * @enabled: the upstream link was last started rather than stopped
+ * @omci_portid: netlink port id of the socket that owns the OMCI channel, 0
+ *		 when none does, changed with cmpxchg, because a socket that
+ *		 closes gives it up without the lock
+ * @omci_rxq: OMCI PDUs from the OLT in the order they arrived, waiting for
+ *	      the instance's context. Each one is marked when the MAC passed
+ *	      it up unchecked
+ * @omci_rx_work: has the driver verify the unchecked PDUs of @omci_rxq and
+ *		  hands every PDU to the owner of the OMCI channel
+ * @identity: the serial number as dev-set last delivered it, which dev-get
+ *	      reports. The registration id goes to the driver and is not kept
+ * @identity.serial: serial number, valid when @identity.serial_set
+ * @identity.serial_set: dev-set delivered a serial number
+ * @tconts: bound T-CONTs, struct pon_tcont
+ * @gems: GEM port objects, struct pon_gem
+ * @gem_maps: upstream classifier rules, struct pon_gem_map
+ * @gem_netdevs: GEM port id to its network device, read under RCU on receive
+ * @wq: ordered workqueue, the instance's one deferred context
+ * @work: the single worker that drains @work_list
+ * @work_list: work items waiting for the instance's context
+ * @work_lock: guards @work_list, taken from hard interrupt
+ * @log_work: prints the lines of @log_lines on system_dfl_wq, outside the
+ *	      instance's context
+ * @log_lines: the lines pon_dev_log() recorded and @log_work has not printed
+ *	       yet, a ring that starts at @log_head
+ * @log_levels: the printk level of each line of @log_lines, such as KERN_INFO
+ * @log_head: the oldest line of @log_lines
+ * @log_count: the lines held in @log_lines
+ * @log_dropped: the oldest lines a full @log_lines dropped since @log_work
+ *		 last printed the count
+ * @going_away: set on the unregister path, so a work item already past its
+ *		scheduling point does not reach a driver that is leaving
+ * @rcu: RCU head for freeing the structure
+ */
+struct pon_dev {
+	struct net_device *main_netdev;
+	struct pon_conduit __rcu *conduit;
+	netdevice_tracker conduit_tracker;
+	struct device *parent;
+
+	const struct pon_dev_ops *ops;
+	const struct pon_dev_caps *caps;
+	void *drv_priv;
+
+	/* guards every field below and the driver's upcalls */
+	struct mutex lock;
+	refcount_t refcnt;
+
+	u32 id;
+	enum pon_mode mode;
+	enum pon_ploam_state ploam;
+	bool enabled;
+	struct {
+		u8 serial[PON_SERIAL_LEN];
+		bool serial_set;
+	} identity;
+
+	struct list_head tconts;
+	struct list_head gems;
+	struct list_head gem_maps;
+	struct xarray gem_netdevs;
+
+	struct workqueue_struct *wq;
+	struct work_struct work;
+	struct list_head work_list;
+	/* guards @work_list, taken from hard interrupt */
+	spinlock_t work_lock;
+
+	u32 omci_portid;
+	struct sk_buff_head omci_rxq;
+	struct pon_work omci_rx_work;
+	struct work_struct log_work;
+	char log_lines[PON_LOG_LINES][PON_LOG_LINE_LEN];
+	const char *log_levels[PON_LOG_LINES];
+	unsigned int log_head;
+	unsigned int log_count;
+	unsigned int log_dropped;
+	bool going_away;
+
+	struct rcu_head rcu;
+};
+
+/**
+ * struct pon_dev_ops - netdev driver facing PON callbacks
+ *
+ * tcont_set, tcont_clear, gem_add, gem_del and omci_xmit are mandatory. The
+ * others may be NULL and the core then answers -EOPNOTSUPP.
+ *
+ * Every callback runs in process context and may sleep, except where its own
+ * description says otherwise. The ones that configure or read the device run
+ * with the instance lock held, from a netlink handler or from the instance's
+ * work, so a driver sees them one at a time and never interleaved with its
+ * own pon_work handlers. The datapath callbacks run without the lock.
+ */
+struct pon_dev_ops {
+	/**
+	 * @enable: start or stop the ONU upstream link
+	 * Instance lock held.
+	 */
+	int (*enable)(struct pon_dev *pdev, bool on,
+		      struct netlink_ext_ack *extack);
+
+	/**
+	 * @set_identity: set the ONU identity and the settings that travel
+	 *		  with it
+	 * Only the members whose _set flag or length is nonzero changed.
+	 * Instance lock held.
+	 */
+	int (*set_identity)(struct pon_dev *pdev,
+			    const struct pon_identity *id,
+			    struct netlink_ext_ack *extack);
+
+	/**
+	 * @tcont_set: bind an alloc-id to a T-CONT, or rebind it
+	 * Instance lock held.
+	 */
+	int (*tcont_set)(struct pon_dev *pdev,
+			 const struct pon_tcont_cfg *cfg,
+			 struct netlink_ext_ack *extack);
+
+	/**
+	 * @tcont_clear: release a T-CONT
+	 * The core passes the stored binding. Instance lock held.
+	 */
+	int (*tcont_clear)(struct pon_dev *pdev,
+			   const struct pon_tcont_cfg *cfg,
+			   struct netlink_ext_ack *extack);
+
+	/**
+	 * @tcont_channel: the conduit transmit channel a T-CONT is bound to,
+	 *		   optional. The core asks it for the carrier, which is
+	 *		   up while a GEM port rides a T-CONT with a channel.
+	 *		   Without it the carrier rises with the first GEM
+	 *		   port. Return the channel, -ENOLINK while the OLT has
+	 *		   not assigned the alloc-id and the T-CONT has no
+	 *		   channel yet, or another negative errno. The default
+	 *		   alloc-id has a channel once the ONU-ID is assigned.
+	 *		   Instance lock held. rtnl is held by some callers and
+	 *		   not by others, so the driver must not rely on it.
+	 */
+	int (*tcont_channel)(struct pon_dev *pdev,
+			     const struct pon_tcont_cfg *cfg);
+
+	/**
+	 * @gem_add: create a GEM port
+	 *
+	 * Must also succeed for a GEM port the driver already holds and
+	 * re-program it, which a T-CONT that moves to another alloc-id
+	 * needs. The driver keeps a GEM port across a loss of the link and
+	 * a new activation, as ITU-T G.9807.1 clause C.6.1.5.8 has the ONU
+	 * keep it. A GEM port whose alloc-id has no channel yet is held and
+	 * carries nothing until the OLT assigns the alloc-id. Instance lock
+	 * held.
+	 */
+	int (*gem_add)(struct pon_dev *pdev, const struct pon_gem_cfg *cfg,
+		       struct netlink_ext_ack *extack);
+
+	/**
+	 * @gem_del: destroy a GEM port
+	 * Instance lock held.
+	 */
+	int (*gem_del)(struct pon_dev *pdev, u16 gem_id,
+		       struct netlink_ext_ack *extack);
+
+	/**
+	 * @gem_xmit: send one frame on a GEM port, optional. Consumes the skb
+	 *	      whatever it returns. Without it a GEM network device
+	 *	      drops what it is given. Runs from ndo_start_xmit of the
+	 *	      GEM network device, without the instance lock. A
+	 *	      concurrent gem_del is the driver's to order.
+	 */
+	int (*gem_xmit)(struct pon_dev *pdev, u16 gem_id, struct sk_buff *skb);
+
+	/**
+	 * @omci_xmit: send one OMCI PDU to the OLT
+	 * The skb carries the bare PDU, validated by the core. The driver
+	 * consumes the skb on success and on failure. Runs from the omci-tx
+	 * netlink handler, with the instance lock held and bottom halves
+	 * disabled.
+	 */
+	int (*omci_xmit)(struct pon_dev *pdev, struct sk_buff *skb);
+
+	/**
+	 * @omci_verify: check the integrity of a received OMCI PDU that the
+	 *		 MAC passed up unchecked, optional. The skb is linear
+	 *		 and ends with the 4 byte MIC, which the driver checks
+	 *		 with its OMCI integrity key and strips on success
+	 *		 (ITU-T G.9807.1 clause C.15.7.2). The check is the
+	 *		 driver's because the key never reaches the core.
+	 *		 Return 0 to deliver it, a negative errno to drop it.
+	 *		 Without it such a PDU is dropped. Runs in the
+	 *		 instance's context with the lock held and may sleep.
+	 */
+	int (*omci_verify)(struct pon_dev *pdev, struct sk_buff *skb);
+
+	/**
+	 * @gem_map_set: add one upstream classifier rule. Idempotent: a rule
+	 *		 the driver already holds is success, not -EEXIST. A
+	 *		 rule outlives the GEM port it names.
+	 *		 Instance lock held.
+	 */
+	int (*gem_map_set)(struct pon_dev *pdev,
+			   const struct pon_gem_map_cfg *cfg,
+			   struct netlink_ext_ack *extack);
+
+	/**
+	 * @gem_map_del: remove one upstream classifier rule
+	 * Instance lock held.
+	 */
+	int (*gem_map_del)(struct pon_dev *pdev,
+			   const struct pon_gem_map_cfg *cfg,
+			   struct netlink_ext_ack *extack);
+
+};
+
+#endif /* __NET_PON_TYPES_H */
diff --git a/net/pon/pon.h b/net/pon/pon.h
new file mode 100644
index 000000000000..daf680790698
--- /dev/null
+++ b/net/pon/pon.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2026 John Crispin <john@phrozen.org> */
+
+#ifndef __PON_PON_H
+#define __PON_PON_H
+
+#include <linux/list.h>
+#include <linux/lockdep.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+#include <net/pon.h>
+
+#define PON_GEM_KIND		"gem"
+
+extern struct xarray pon_devs;
+extern struct mutex pon_devs_lock;
+
+/**
+ * struct pon_tcont - one T-CONT of an instance
+ * @list:	entry in the instance's @tconts list
+ * @cfg:	the configuration tcont-set last stored
+ */
+struct pon_tcont {
+	struct list_head list;
+	struct pon_tcont_cfg cfg;
+};
+
+/**
+ * struct pon_gem - one GEM port of an instance
+ * @list:	entry in the instance's @gems list
+ * @cfg:	the configuration gem-new stored
+ * @gem_netdev:	the GEM port's network device, or NULL when it has none
+ */
+struct pon_gem {
+	struct list_head list;
+	struct pon_gem_cfg cfg;
+	struct net_device *gem_netdev;
+};
+
+/**
+ * struct pon_gem_map - one upstream classifier rule
+ * @list:	entry in the instance's @gem_maps list
+ * @cfg:	what the rule matches on and the GEM port it selects
+ *
+ * One upstream classifier rule, kept for the dumps and the notifications.
+ */
+struct pon_gem_map {
+	struct list_head list;
+	struct pon_gem_map_cfg cfg;
+};
+
+struct pon_tcont *pon_tcont_find(struct pon_dev *pdev, u16 index);
+struct pon_gem *pon_gem_find(struct pon_dev *pdev, u16 gem_id);
+int pon_gem_channel(struct pon_dev *pdev, const struct pon_gem *gem);
+struct pon_gem_map *pon_gem_map_find(struct pon_dev *pdev,
+				     const struct pon_gem_map_cfg *cfg);
+bool pon_tcont_in_use(struct pon_dev *pdev, u16 index);
+bool pon_gems_full(struct pon_dev *pdev);
+bool pon_tcont_alloc_taken(struct pon_dev *pdev, u16 index, u16 alloc_id);
+int pon_tcont_gems_rebind(struct pon_dev *pdev, u16 index, u16 old_alloc_id,
+			  u16 new_alloc_id, struct netlink_ext_ack *extack);
+
+void pon_work_worker(struct work_struct *work);
+void pon_work_drain(struct pon_dev *pdev);
+
+void pon_nl_obj_gen_inc(void);
+void pon_nl_notify_dev(struct pon_dev *pdev, u32 cmd);
+void pon_nl_notify_ploam(struct pon_dev *pdev);
+void pon_nl_notify_tcont(struct pon_dev *pdev, struct pon_tcont *tcont,
+			 u32 cmd);
+void pon_nl_notify_gem(struct pon_dev *pdev, struct pon_gem *gem, u32 cmd);
+void pon_nl_notify_gem_map(struct pon_dev *pdev, struct pon_gem_map *map,
+			   u32 cmd);
+
+void pon_dev_carrier_update(struct pon_dev *pdev);
+
+/* ITU-T G.988 clause 11.2.5 and Table 11.2-2: header and length are 10
+ * bytes and a PDU is at most 1980 bytes including the 4 byte MIC.
+ */
+#define PON_OMCI_MIN_LEN	10
+#define PON_OMCI_MAX_LEN	1976
+#define PON_OMCI_MIC_LEN	4
+#define PON_OMCI_QUEUE_MAX	512
+
+void pon_omci_init(struct pon_dev *pdev);
+void pon_omci_destroy(struct pon_dev *pdev);
+int pon_omci_conduit_rx(struct pon_dev *pdev, struct sk_buff *skb,
+			bool unverified);
+int pon_omci_xmit(struct pon_dev *pdev, const void *pdu, unsigned int len,
+		  struct netlink_ext_ack *extack);
+int pon_omci_register(struct pon_dev *pdev, u32 portid);
+int pon_omci_notifier_register(void);
+void pon_omci_notifier_unregister(void);
+int pon_nl_omci_ntf(struct pon_dev *pdev, const struct sk_buff *skb);
+
+bool pon_conduit_attach(struct pon_dev *pdev);
+void pon_conduit_detach(struct pon_dev *pdev);
+void pon_conduit_sync(struct pon_dev *pdev);
+bool pon_conduit_running(struct pon_dev *pdev);
+void pon_log_init(struct pon_dev *pdev);
+__printf(3, 4) void pon_dev_log_level(struct pon_dev *pdev, const char *level,
+				      const char *fmt, ...);
+int pon_conduit_notifier_register(void);
+void pon_conduit_notifier_unregister(void);
+struct net_device *pon_conduit_hold(struct pon_dev *pdev,
+				    const struct pon_conduit_ops **ops,
+				    netdevice_tracker *tracker);
+
+int pon_gem_link_register(void);
+void pon_gem_link_unregister(void);
+void pon_gem_netdevs_unregister(struct pon_dev *pdev);
+int pon_gem_netdev_id(const struct net_device *dev, u16 *gem_id);
+
+/**
+ * pon_dev_get() - take a reference to a PON device
+ * @pdev:	PON device structure, on which the caller already holds a
+ *		reference or which it found under pon_devs_lock
+ *
+ * The reference is dropped with pon_dev_put().
+ *
+ * Context: Any context.
+ */
+static inline void pon_dev_get(struct pon_dev *pdev)
+{
+	refcount_inc(&pdev->refcnt);
+}
+
+/**
+ * pon_dev_tryget() - take a reference to a PON device that may be going
+ * @pdev:	PON device structure, found under RCU
+ *
+ * Fails once the last reference is gone and the device waits to be freed.
+ *
+ * Context: Any context.
+ * Return: true when the reference was taken, false otherwise.
+ */
+static inline bool pon_dev_tryget(struct pon_dev *pdev)
+{
+	return refcount_inc_not_zero(&pdev->refcnt);
+}
+
+/**
+ * pon_dev_is_registered() - test that a PON device is still registered
+ * @pdev:	PON device structure
+ *
+ * @pdev->ops survives until the end of pon_dev_unregister(), which frees the
+ * instance's objects long before it. @pdev->going_away is set first, so both
+ * are tested: a caller that only asked about @pdev->ops could act on a T-CONT
+ * or a GEM port that has already been freed.
+ *
+ * Context: Called with @pdev->lock held.
+ * Return: true while the driver is registered and pon_dev_unregister() has
+ * not begun, false otherwise.
+ */
+static inline bool pon_dev_is_registered(struct pon_dev *pdev)
+{
+	lockdep_assert_held(&pdev->lock);
+	return pdev->ops && !pdev->going_away;
+}
+
+#endif /* __PON_PON_H */
diff --git a/net/pon/pon_state.c b/net/pon/pon_state.c
new file mode 100644
index 000000000000..5e06df5b072c
--- /dev/null
+++ b/net/pon/pon_state.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 John Crispin <john@phrozen.org> */
+
+#include <linux/bits.h>
+#include <linux/netdevice.h>
+#include <linux/sprintf.h>
+#include <linux/stdarg.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
+#include <net/pon.h>
+
+#include "pon.h"
+
+#define PON_S(x)	BIT(PON_PLOAM_STATE_##x)
+
+/* The activation edges the ITU-T state machine permits, indexed by the state
+ * being left.
+ *
+ * One table serves every mode. G.984.3 ranges in O3 where G.9807.1 merges O2
+ * and O3 into one state and a MAC has one register code for the merged pair,
+ * so a driver reports O2 and then O4. Both edges are legal here because what
+ * is being checked is whether a driver reported something impossible, not
+ * whether it conforms to one mode's text. A per mode split is worth adding
+ * the day a second MAC needs it.
+ *
+ * O1 is reachable from every state: a loss of signal, a deactivation or the
+ * end of TO2 returns the ONU to it. O7 is reachable from O1 to O5, where the
+ * OLT's Disable_Serial_Number stops the ONU, but not from O6, which leaves
+ * only for O5 or O1. O7 itself leaves only for O1, when the OLT enables the
+ * ONU again (G.9807.1 Table C.12.4).
+ */
+static const u32 pon_state_legal[] = {
+	[PON_PLOAM_STATE_UNKNOWN] = PON_S(O1) | PON_S(O2) | PON_S(O3) |
+				    PON_S(O4) | PON_S(O5) | PON_S(O6) |
+				    PON_S(O7),
+	[PON_PLOAM_STATE_O1]	  = PON_S(O2) | PON_S(O7),
+	[PON_PLOAM_STATE_O2]	  = PON_S(O1) | PON_S(O3) | PON_S(O4) |
+				    PON_S(O7),
+	[PON_PLOAM_STATE_O3]	  = PON_S(O1) | PON_S(O4) | PON_S(O7),
+	[PON_PLOAM_STATE_O4]	  = PON_S(O1) | PON_S(O2) | PON_S(O5) |
+				    PON_S(O7),
+	[PON_PLOAM_STATE_O5]	  = PON_S(O1) | PON_S(O6) | PON_S(O7),
+	[PON_PLOAM_STATE_O6]	  = PON_S(O1) | PON_S(O5),
+	[PON_PLOAM_STATE_O7]	  = PON_S(O1),
+};
+
+static const char *const pon_state_names[] = {
+	[PON_PLOAM_STATE_UNKNOWN] = "unknown",
+	[PON_PLOAM_STATE_O1]	  = "O1",
+	[PON_PLOAM_STATE_O2]	  = "O2",
+	[PON_PLOAM_STATE_O3]	  = "O3",
+	[PON_PLOAM_STATE_O4]	  = "O4",
+	[PON_PLOAM_STATE_O5]	  = "O5",
+	[PON_PLOAM_STATE_O6]	  = "O6",
+	[PON_PLOAM_STATE_O7]	  = "O7",
+};
+
+/**
+ * pon_state_edge_legal() - test an activation edge against the state machine
+ * @from:	the state being left, enum pon_ploam_state
+ * @to:		the state being entered, enum pon_ploam_state
+ *
+ * The edges follow the ONU activation cycle state transition table, ITU-T
+ * G.9807.1 clause C.12.1.4.3, Table C.12.4, over the states of Table C.12.1.
+ *
+ * Return: true when pon_state_legal permits the edge, false otherwise or
+ * when @from is out of range.
+ */
+static bool pon_state_edge_legal(u32 from, u32 to)
+{
+	if (from >= ARRAY_SIZE(pon_state_legal))
+		return false;
+
+	return !!(pon_state_legal[from] & BIT(to));
+}
+
+/**
+ * pon_dev_state_name() - the name of an activation state in the device's mode
+ * @pdev:	PON device structure
+ * @state:	the state, enum pon_ploam_state, in range
+ *
+ * ITU-T G.9807.1 Table C.12.1 has one Serial Number state, O2-3, which a
+ * driver reports as O2. Only a G-PON device has an O2 of its own.
+ *
+ * Context: Called with @pdev->lock held.
+ * Return: "O2-3" for O2 in a mode other than G-PON, otherwise the name in
+ * pon_state_names.
+ */
+static const char *pon_dev_state_name(const struct pon_dev *pdev, u32 state)
+{
+	if (state == PON_PLOAM_STATE_O2 && pdev->mode != PON_MODE_GPON)
+		return "O2-3";
+
+	return pon_state_names[state];
+}
+
+/**
+ * pon_netdev_carrier_set() - set the carrier of one network device
+ * @dev:	the network device
+ * @up:		true for carrier on, false for carrier off
+ */
+static void pon_netdev_carrier_set(struct net_device *dev, bool up)
+{
+	if (up)
+		netif_carrier_on(dev);
+	else
+		netif_carrier_off(dev);
+}
+
+/**
+ * pon_dev_gem_bound() - test whether a GEM port can carry traffic
+ * @pdev:	PON device structure
+ *
+ * Without the driver's tcont_channel callback, any GEM port is enough.
+ *
+ * Context: Called with @pdev->lock held.
+ * Return: true when a GEM port rides a T-CONT that has a transmit channel,
+ * false otherwise.
+ */
+static bool pon_dev_gem_bound(struct pon_dev *pdev)
+{
+	struct pon_gem *gem;
+
+	if (list_empty(&pdev->gems))
+		return false;
+
+	if (!pdev->ops->tcont_channel)
+		return true;
+
+	list_for_each_entry(gem, &pdev->gems, list)
+		if (pon_gem_channel(pdev, gem) >= 0)
+			return true;
+
+	return false;
+}
+
+/**
+ * pon_dev_carrier_update() - set the carrier of the PON netdevs from the state
+ * @pdev:	PON device structure
+ *
+ * The carrier is up in O5 or O6 while a conduit that is up is paired with
+ * the instance and at least one GEM port rides a T-CONT that has a transmit
+ * channel, as the driver's tcont_channel callback answers. That includes
+ * the default alloc-id, which carries data too and which the driver binds
+ * without an alloc-id event. Without the callback a GEM port is enough.
+ * The GEM network devices follow the data netdev.
+ *
+ * Called on every change that can alter the answer: an activation edge, an
+ * alloc-id event, a T-CONT or a GEM port that is set or deleted and a
+ * conduit that pairs, goes up, goes down or leaves.
+ */
+void pon_dev_carrier_update(struct pon_dev *pdev)
+{
+	struct pon_gem *gem;
+	bool up;
+
+	lockdep_assert_held(&pdev->lock);
+
+	up = (pdev->ploam == PON_PLOAM_STATE_O5 ||
+	      pdev->ploam == PON_PLOAM_STATE_O6) && pon_dev_gem_bound(pdev) &&
+	     pon_conduit_running(pdev);
+
+	pon_netdev_carrier_set(pdev->main_netdev, up);
+	list_for_each_entry(gem, &pdev->gems, list)
+		if (gem->gem_netdev)
+			pon_netdev_carrier_set(gem->gem_netdev, up);
+}
+
+/**
+ * pon_dev_log_pop() - take the oldest recorded line out of the ring
+ * @pdev:	PON device structure
+ * @line:	filled with the line, PON_LOG_LINE_LEN bytes
+ * @level:	set to the printk level of the line
+ * @dropped:	set to the lines a full ring dropped before this one
+ *
+ * Context: Process context. Takes @pdev->lock.
+ * Return: true when @line holds a line, false when the ring is empty.
+ */
+static bool pon_dev_log_pop(struct pon_dev *pdev, char *line,
+			    const char **level, unsigned int *dropped)
+{
+	bool found;
+
+	mutex_lock(&pdev->lock);
+	*dropped = pdev->log_dropped;
+	pdev->log_dropped = 0;
+	found = pdev->log_count;
+	if (found) {
+		strscpy(line, pdev->log_lines[pdev->log_head],
+			PON_LOG_LINE_LEN);
+		*level = pdev->log_levels[pdev->log_head];
+		pdev->log_head = (pdev->log_head + 1) % PON_LOG_LINES;
+		pdev->log_count--;
+	}
+	mutex_unlock(&pdev->lock);
+
+	return found;
+}
+
+/**
+ * pon_dev_log_work() - print the lines pon_dev_log() recorded
+ * @work:	the instance's @log_work
+ *
+ * Prints the lines in the order they were recorded, each at its own level
+ * with the name of the data network device. Where a full ring dropped lines,
+ * one line at info level with their count comes first, because they were
+ * older. The instance lock is held only to take a line out, never across a
+ * print.
+ *
+ * Context: Process context, on system_dfl_wq. Takes @pdev->lock.
+ */
+static void pon_dev_log_work(struct work_struct *work)
+{
+	struct pon_dev *pdev = container_of(work, struct pon_dev, log_work);
+	char line[PON_LOG_LINE_LEN];
+	unsigned int dropped;
+	const char *level;
+	bool found;
+
+	do {
+		found = pon_dev_log_pop(pdev, line, &level, &dropped);
+		if (dropped)
+			netdev_info(pdev->main_netdev,
+				    "%u log lines dropped\n", dropped);
+		if (found)
+			netdev_printk(level, pdev->main_netdev, "%s\n", line);
+	} while (found);
+}
+
+/**
+ * pon_log_init() - prepare the log of a new PON device
+ * @pdev:	PON device structure
+ *
+ * Context: From pon_dev_create(), before the device is published.
+ */
+void pon_log_init(struct pon_dev *pdev)
+{
+	INIT_WORK(&pdev->log_work, pon_dev_log_work);
+}
+
+/**
+ * pon_dev_log_record() - record one line for the log work
+ * @pdev:	PON device structure
+ * @level:	printk level of the line, such as KERN_INFO
+ * @fmt:	printf format of the line, without a newline
+ * @args:	the arguments of @fmt
+ *
+ * Context: Called with @pdev->lock held.
+ */
+static __printf(3, 0) void pon_dev_log_record(struct pon_dev *pdev,
+					      const char *level,
+					      const char *fmt, va_list args)
+{
+	unsigned int slot;
+
+	lockdep_assert_held(&pdev->lock);
+
+	if (pdev->going_away)
+		return;
+
+	if (pdev->log_count == PON_LOG_LINES) {
+		pdev->log_head = (pdev->log_head + 1) % PON_LOG_LINES;
+		pdev->log_count--;
+		pdev->log_dropped++;
+	}
+
+	slot = (pdev->log_head + pdev->log_count) % PON_LOG_LINES;
+	vsnprintf(pdev->log_lines[slot], PON_LOG_LINE_LEN, fmt, args);
+	pdev->log_levels[slot] = level;
+	pdev->log_count++;
+
+	queue_work(system_dfl_wq, &pdev->log_work);
+}
+
+/**
+ * pon_dev_log_level() - log one line at a given level from the core
+ * @pdev:	PON device structure
+ * @level:	printk level of the line, such as KERN_ERR
+ * @fmt:	printf format of the line, without a newline
+ *
+ * As pon_dev_log(), with the level of the line chosen by the caller.
+ *
+ * Context: Called with @pdev->lock held.
+ */
+void pon_dev_log_level(struct pon_dev *pdev, const char *level,
+		       const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	pon_dev_log_record(pdev, level, fmt, args);
+	va_end(args);
+}
+
+/**
+ * pon_dev_log() - log one line from the instance's context
+ * @pdev:	PON device structure
+ * @fmt:	printf format of the line, without a newline
+ *
+ * Records the line and leaves the print to a work item on system_dfl_wq. A
+ * print to a serial console blocks for milliseconds, while the instance's
+ * context answers the OLT within a deadline. The caller never waits for it.
+ * The lines are printed at info level with the name of the data network
+ * device, in the order they were recorded, the activation edges of
+ * pon_dev_state_report() among them. The ring holds PON_LOG_LINES lines.
+ * When it is full the oldest line is dropped and counted. The count is
+ * printed in its place. A line is cut to PON_LOG_LINE_LEN - 1 characters.
+ * Nothing is recorded once pon_dev_unregister() has begun.
+ *
+ * Context: Called with @pdev->lock held.
+ */
+void pon_dev_log(struct pon_dev *pdev, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	pon_dev_log_record(pdev, KERN_INFO, fmt, args);
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(pon_dev_log);
+
+/**
+ * pon_dev_state_report() - report the activation state the MAC reached
+ * @pdev:	PON device structure
+ * @state:	the new state, enum pon_ploam_state
+ *
+ * The driver computes the state. The core owns, validates and publishes it.
+ * Call with @pdev->lock held, from the instance's work or from a pon_dev_ops
+ * handler.
+ *
+ * A repeat of the state already published is a no-op: this is a level, not an
+ * edge. An edge the standard does not permit is published anyway, because the
+ * hardware is the truth and a core that refused it would publish a state the
+ * ONU is not in. It is warned about instead. Every edge that is published
+ * gets one line in the kernel log at info level through pon_dev_log().
+ *
+ * Return: 0, -ENODEV once pon_dev_unregister() has begun, or -EINVAL for a
+ * value out of range or an illegal edge. An illegal edge is published anyway
+ * and the return value is for the driver author and for a selftest. A value
+ * out of range is not a state and is refused before anything is published.
+ */
+int pon_dev_state_report(struct pon_dev *pdev, enum pon_ploam_state state)
+{
+	u32 old = pdev->ploam;
+	int err = 0;
+
+	lockdep_assert_held(&pdev->lock);
+
+	if (pdev->going_away)
+		return -ENODEV;
+
+	if (state > PON_PLOAM_STATE_O7) {
+		netdev_warn(pdev->main_netdev,
+			    "activation state %u is not a state\n", state);
+		return -EINVAL;
+	}
+
+	if (state == old)
+		return 0;
+
+	if (!pon_state_edge_legal(old, state)) {
+		net_warn_ratelimited("%s: activation went O%u to O%u, which the standard does not permit\n",
+				     netdev_name(pdev->main_netdev), old,
+				     state);
+		err = -EINVAL;
+	}
+
+	WRITE_ONCE(pdev->ploam, state);
+	pon_dev_log(pdev, "PLOAM state %s -> %s",
+		    pon_dev_state_name(pdev, old),
+		    pon_dev_state_name(pdev, state));
+
+	/* Carrier before the notification, so a daemon that reads both sees a
+	 * netdev that agrees with the state. rtnetlink and generic netlink
+	 * have no ordering between them, so this is best effort.
+	 */
+	pon_dev_carrier_update(pdev);
+	pon_nl_notify_ploam(pdev);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(pon_dev_state_report);
+
+/**
+ * pon_dev_event() - report a discrete event
+ * @pdev:	PON device structure
+ * @ev:		what happened and the alloc-id it names
+ *
+ * Runs in the instance's context, with its lock held.
+ *
+ * A PON_EVENT_TYPE_TCONT_ALLOC event means the driver bound the alloc-id to
+ * a channel, so the GEM ports that ride it carry traffic from then on: the
+ * carrier may rise. A PON_EVENT_TYPE_TCONT_DEALLOC event means the driver
+ * released the channel: the carrier may fall. An event that arrives once
+ * pon_dev_unregister() has begun is dropped.
+ */
+void pon_dev_event(struct pon_dev *pdev, const struct pon_event *ev)
+{
+	lockdep_assert_held(&pdev->lock);
+
+	if (pdev->going_away)
+		return;
+
+	if (ev->type == PON_EVENT_TYPE_TCONT_ALLOC ||
+	    ev->type == PON_EVENT_TYPE_TCONT_DEALLOC)
+		pon_dev_carrier_update(pdev);
+}
+EXPORT_SYMBOL_GPL(pon_dev_event);
diff --git a/net/pon/pon_work.c b/net/pon/pon_work.c
new file mode 100644
index 000000000000..59264cec2b41
--- /dev/null
+++ b/net/pon/pon_work.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 John Crispin <john@phrozen.org> */
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <net/pon.h>
+
+#include "pon.h"
+
+/**
+ * DOC: The lent context
+ *
+ * A PON MAC runs the ITU-T activation state machine itself, but it must not
+ * run it in hard interrupt context and it must not run it against a half
+ * finished netlink transaction. The core therefore lends the driver its own
+ * serialized context: one ordered workqueue per instance and one lock that
+ * the netlink handlers take in their pre_doit.
+ *
+ * A driver queues a pon_work from any context, hard interrupt included. The
+ * handler runs with pdev->lock held, so it may sleep.
+ *
+ * One worker drains the list one item at a time and re-queues itself while
+ * the list is not empty, so the ordering a driver sees is the order it
+ * queued in.
+ */
+
+void pon_work_worker(struct work_struct *work)
+{
+	struct pon_dev *pdev = container_of(work, struct pon_dev, work);
+	struct pon_work *item;
+
+	mutex_lock(&pdev->lock);
+
+	if (pdev->going_away) {
+		mutex_unlock(&pdev->lock);
+		return;
+	}
+
+	spin_lock_irq(&pdev->work_lock);
+	item = list_first_entry_or_null(&pdev->work_list, struct pon_work,
+					entry);
+	if (item) {
+		list_del_init(&item->entry);
+		if (!list_empty(&pdev->work_list))
+			queue_work(pdev->wq, work);
+	}
+	spin_unlock_irq(&pdev->work_lock);
+
+	if (item)
+		item->func(pdev, item);
+
+	mutex_unlock(&pdev->lock);
+}
+
+/**
+ * pon_work_queue() - run a work item in the instance's context
+ * @pdev: PON device structure
+ * @work: the item, initialized with pon_work_init()
+ *
+ * Safe from any context, hard interrupt included. Queueing an item that is
+ * already queued and has not yet run does nothing, so a burst of reports
+ * costs one run.
+ */
+void pon_work_queue(struct pon_dev *pdev, struct pon_work *work)
+{
+	unsigned long flags;
+
+	/*
+	 * A driver that reports after pon_dev_unregister() canceled the work
+	 * would queue onto a workqueue that is being drained, which warns. The
+	 * instance is going: drop the item instead.
+	 */
+	if (READ_ONCE(pdev->going_away))
+		return;
+
+	spin_lock_irqsave(&pdev->work_lock, flags);
+	if (list_empty(&work->entry))
+		list_add_tail(&work->entry, &pdev->work_list);
+	spin_unlock_irqrestore(&pdev->work_lock, flags);
+
+	queue_work(pdev->wq, &pdev->work);
+}
+EXPORT_SYMBOL_GPL(pon_work_queue);
+
+/**
+ * pon_work_drain() - drop every queued item
+ * @pdev: PON device structure
+ *
+ * For the unregister path, after @going_away is set. Items still on the list
+ * are dropped rather than run, because the driver that owns them is leaving.
+ */
+void pon_work_drain(struct pon_dev *pdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdev->work_lock, flags);
+	while (!list_empty(&pdev->work_list)) {
+		struct pon_work *item;
+
+		item = list_first_entry(&pdev->work_list, struct pon_work,
+					entry);
+		list_del_init(&item->entry);
+	}
+	spin_unlock_irqrestore(&pdev->work_lock, flags);
+}
-- 
2.34.1

