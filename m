Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABAD37755A;
	Fri, 16 Oct 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137560; cv=none; b=saNSPjoI3HEBhzUH+VPAKp2atZ7EVYS91CASBXGQEMDeWXWNUqvE4MMx6gqt8YbDCi5kuOyyedNyVorZCDXLmgDm2AaXOkY/6XxGOZgyEAAgjucoJo9dZPrgswQepafMUT+DUuuLtRiqXluJJJ4hFPoIzz0x2krWFfhf1rzVww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137560; c=relaxed/simple;
	bh=4vcMN928ZcFN4jUpHUWwi4l826i7uNq4sv/j6WwbK7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ib3lk6QGmCjwpWUBVwpJDPIIkTte6K04cBDRifFIzyO3paN8uSDDf+tBO9XIxDpahqvdBCbyaZaMKkZgwfvmMz5IhMxCtG2cadTnx5c+xFteAuWr/irkgOvT0CsVpzXwcMDZ9tKNhJ/ZP2BwYgRbyhMPVz6vhD5diwYraGCwa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=hr+rqA/x; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="hr+rqA/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=28409; q=dns/txt;
  s=iport01; t=1792137558; x=1793347158;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PhzI30ujDPoCK7nMbUnX/KPSGUTVTnT/KRmq1ZDflgs=;
  b=hr+rqA/x2JxqOdtvFANNL3LTyvMFPjL4iojNV//7Oyc/xxFJT+CHD93u
   lAJg7tV1dNn3nqSw2W5DthyAb33l0Th3CYeFOYzvtN2QZt9rItKSSnjE0
   I4/rUuUyGeXyaBh/7lxK06htYyy1Q/mqTO/tsczb4JDFpatX3dnyLbKxN
   Ourl/k5PcJ2JoDLw/1HfAVWatCwN/XyAFsQTh5pfTEYg5zZokow3LyPvi
   iXOAApZbix04n3J6t/4HUL4jqWAy1AdTwvqGFsmNnMdqj5REva5nWd/HD
   3Pt718Mu5KCZ86qsoSzbydREjGcKu5fT2epcisfUw2F5hXQJYvBJWkUuU
   A==;
X-CSE-ConnectionGUID: 80MWU4ozQge5Rkht0Hfy/A==
X-CSE-MsgGUID: L5kTyvmEQ4eLZIRatzIuog==
X-IPAS-Result: =?us-ascii?q?A0AaAACT19Fq/4z/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBglaBVUNJhFeIG4c3giGBFpA3jFIUgWoPAQEBD1EEAQGCEoJzAo4VA?=
 =?us-ascii?q?iY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZckBMCAQMaC?=
 =?us-ascii?q?QQLAUYQJQImAgJGEAYBEoMCgnUDvS56fzOBAYR+2UqBaAELFAGBCi4BhXGCb?=
 =?us-ascii?q?QGBcYQIO4RBFxAbgUlEgRWCc3aEKoN0gmoEgg0VehKDJ4NBgyuNDgk/gQIcA?=
 =?us-ascii?q?1ksAVUTDQoLBwVjUjMDIAoLEhIYFQIUHAESDwQWMh1wDCcSLBcvWBsGBYEdd?=
 =?us-ascii?q?RQEE4IWIxk2eoEJXoErKWABEBeBCYIHAoJUggACAUlBDgdFUwklQxJHJiIIE?=
 =?us-ascii?q?gkBExowC4EbODwJKEEXDHECCQMdBU4CIggCDQkHKRgNSBEsNwYPGQQ9AW4Hk?=
 =?us-ascii?q?hQegW0HPCUJBwEFEAk5ASIJCwcDCTIGATM9BwEBKQIIMAcDDAEFBxsEOAOSY?=
 =?us-ascii?q?IN+jCiCIYE1gRmeQYQogWagEDOXZ5MImQgjo0gGDwkBAk2EaYFoPIFZMxoIG?=
 =?us-ascii?q?xWDIlMZD4hLhWMWkx0BvxwnMj0CBwIHDgMLkwZgAQE?=
IronPort-Data: A9a23:QTS5Zq9OwfkJHr6AQisYDrUDUn+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 zFJDD3Tb/iCNzf2c40ia47j9EMEu8PSzdNnHQZl+yFEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmB4E/rbei5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mtyyHjEAX9gWAtajtKs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2lmZagnx7pwE1hB+
 KEiKzARNjCNlqWflefTpulE3qzPLeHxN48Z/3UlxjbDALN+GtbIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0Un1lQ/UPrSmM+zj2X+aD1bqHqepLE85C7YywkZPL3FbYGIIYPbGJoJ9qqej
 kab/FjoHBQ3DYCS7QikyHuwlM7SmiyuDer+E5X9rJaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDTdTnWRC85nmesXY0W91KFvYS6wyXzKfQpQGDCQAsTSNLYfQludUwSDhs0
 UWG9/vgAzB1vaLWT3+B+rqKhTevPy5TJm9qTTcNRwYD4vH5rY0zhw6JRdFmeIaxj9voCXTzz
 iqMoSwWmboel4gI2r+98FSBhCijzrDPQxI56xv/QG2o9EV6aZSjaoju7kLUhcusN66DRVWH+
 XxBkM+E4aVWVteGlTeGR6MGG7TBC+u5DQAwSGVHR/EJnwlBMVb5FWyMyFmS/HtUD/s=
IronPort-HdrOrdr: A9a23:v5VqCqELWL6Re5VnpLqEHseALOsnbusQ8zAXPo5KOHhom6uj9v
 xG/c506faaslsssR0b8+xofZPwI080lqQb3WBuB9eftWDd0QPCEGgh1/qA/9SKIUHDH4BmpM
 JdWpk7JdHuAV19lMrgpCu1A78bsaC62ZHtqOvAw3JqVA1wL5th4QBwFxqBHiRNNW977OICZf
 2hz/sCgSa8cnIKacn+LHwEU+/f4+DvrvvdEGY779pN0nj1sdtug4SKaCSl4g==
X-Talos-CUID: =?us-ascii?q?9a23=3A4IHklWjwWP5O/4yKDpL9NZQkRDJuIiX480qMJF2?=
 =?us-ascii?q?BBms0cr6VVQew9rIjup87?=
X-Talos-MUID: 9a23:kvd9OAhoowKXtI4m3GH9lMMpEJpr37WwDW00zZgiiei+PDBiGiqag2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,161,1787011200"; 
   d="scan'208";a="535379574"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 16 Oct 2026 07:58:09 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id 7407B18000594;
	Fri, 16 Oct 2026 07:58:08 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 16 Oct 2026 00:57:51 -0700
Subject: [PATCH net 1/3] enic: retain datapath DMA resources until queues
 stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-1-d27b55f69883@cisco.com>
References: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883@cisco.com>
In-Reply-To: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792137487; l=29084;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=4vcMN928ZcFN4jUpHUWwi4l826i7uNq4sv/j6WwbK7A=;
 b=FT7DmxwSdzljOrY0O3CeK7eOSEIRhzsIeduIdMwIpLQeZWs7BWN9se5lfxzTA5BasyPx35r1d
 JzboImq3fGmBTZKXqRv18Sk1XFUmqYjFLphIflFnye1ExxfJWUuarOG
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-03.cisco.com

enic_stop() returns immediately when the first WQ or RQ disable times
out.  The networking core does not treat ndo_stop() as fallible. A
later open can therefore reuse the still-allocated datapath even though
hardware ownership of one of its rings was never disproved. The same
problem occurs while unwinding a partially opened datapath.

The queue-disable helpers can return -ETIMEDOUT without observing
RUNNING == 0. Firmware defines RUNNING == 0 as conclusive evidence that
queue DMA has stopped. A nonzero RUNNING value does not establish that
DMA is active, but it leaves DMA ownership unresolved. The existing error
path can nevertheless release DMA-backed resources without obtaining the
required ownership proof.

The existing WQ loop waits about 10 ms, while the RQ uses a CPU-dependent
tight loop. Replace both with read_poll_timeout() and a driver-chosen
500 ms bound. Keep the two complete RQ disable passes required
to flush its hardware mini-cache.

Try every WQ and RQ disable and retain the first error. Release the
datapath only when every enabled queue reports RUNNING == 0. Although an
individual queue which reports zero has stopped, the queues, completion
queues, interrupts, mappings, page pools, and notification allocation
form one datapath lifetime graph. If any queue times out, retain that
complete graph instead of partially reclaiming it.

This complete-graph retention is deliberately conservative. It can retain
resources belonging to queues which stopped successfully, but avoids
adding partial teardown and ownership states to this correctness fix.
Per-queue reclamation of proven-stopped packet buffers can be implemented
as a separate follow-up and is not required for DMA safety.

Ring resizing cannot rely on dev_close() to report an ndo_stop()
failure. Stop the datapath explicitly before dev_close(), propagate a
queue-disable error, and reject ring reconfiguration while the datapath
is quarantined so retained DMA resources cannot be freed through the
ethtool path.

Track the datapath state so an internal reset cannot make a later
ndo_stop() disable NAPI or tear down the same graph twice. Do not issue
an internal reset or reopen the datapath when queue stop could not be
confirmed and DMA ownership remains unresolved. A clean internal open
unwind remains retryable; if stop cannot be confirmed for a queue during
that unwind, quarantine the datapath.

These transitions apply to every ENIC device because the reset workers,
ndo_open(), ndo_stop(), and their resource graphs are shared by PFs and
both VF generations.

A persistent RUNNING value means the driver cannot prove that queue DMA
has stopped. Do not reset or reclaim a quarantined datapath during
runtime. Detach the netdev and clear bus mastering to contain the
function. Clearing bus mastering blocks new device-initiated PCI
transactions; it does not cancel DMA which is already in progress or
prevent a queue from draining to RUNNING == 0.

At device removal, make one final direct disable/RUNNING check of every
queue. Release the complete graph only if every queue reports RUNNING == 0.
Do not partially release queues which report zero if any peer remains
nonzero.
If ownership is still unresolved, detach every remaining CPU entry point
and intentionally retain the netdev, BAR mappings and reservations,
rings, mappings, page pools, and buffer metadata until reboot. The final
recheck remains meaningful after bus mastering was cleared because a
queue may subsequently report RUNNING == 0, but the bus-master state is
not proof that already-issued DMA completed. Leaking one failed device
instance is preferable to risking a DMA use-after-free.

The BAR reservation may therefore outlive driver unbind and module
unload while the PCI device remains enumerated. The resource subsystem
stores the supplied owner-name pointer rather than copying it. Request
the regions using the PCI device name instead of DRV_NAME so the pointer
does not refer to module rodata after unload.

A PCI driver's remove callback cannot reject driver unbind. With DMA API
debugging enabled, the unbind notification therefore reports the
deliberately retained DMA allocations. The retained BAR reservation
prevents a normal ENIC rebind, so reboot is the supported recovery from
terminal quarantine.

The early-return behavior dates to the original driver. An automated
Sashiko review of the V2 SR-IOV reset paths prompted the audit of
admin-channel reset error exits which uncovered it. Sashiko prompted the
investigation; the defect and its correction were established through
source analysis of the queue-disable and resource-release paths. Fix the
generic datapath first so the following admin-channel correction does not
create an unsafe intermediate kernel.

Fixes: 01f2e4ead2c5 ("enic: add Cisco 10G Ethernet NIC driver")
Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Reviewed-by: Aravind Dhanasekaran <aradhana@cisco.com>
Reviewed-by: Reese Faucette <rfaucett@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h         |  18 ++
 drivers/net/ethernet/cisco/enic/enic_ethtool.c |  10 +-
 drivers/net/ethernet/cisco/enic/enic_main.c    | 322 ++++++++++++++++++++-----
 drivers/net/ethernet/cisco/enic/vnic_rq.c      |  18 +-
 drivers/net/ethernet/cisco/enic/vnic_wq.c      |  18 +-
 5 files changed, 312 insertions(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 7a509a056990..992ac43d1b0a 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -238,6 +238,12 @@ enum enic_vf_type {
 	ENIC_VF_TYPE_V2,
 };
 
+enum enic_dma_state {
+	ENIC_DMA_DOWN,
+	ENIC_DMA_LIVE,
+	ENIC_DMA_QUARANTINED,
+};
+
 /* Per-instance private data structure */
 struct enic {
 	struct net_device *netdev;
@@ -251,6 +257,8 @@ struct enic {
 	struct work_struct change_mtu_work;
 	struct msix_entry *msix_entry;
 	struct enic_msix_entry *msix;
+	bool non_msix_intr_requested;
+	bool napi_added;
 	u32 msg_enable;
 	spinlock_t devcmd_lock;
 	u8 mac_addr[ETH_ALEN];
@@ -325,6 +333,10 @@ struct enic {
 	spinlock_t vf_link_state_lock;
 	enum enic_vf_link_state vf_link_state;
 	bool vf_link_running;
+	/* A queue-disable failure leaves DMA ownership unresolved.  Retain the
+	 * complete mapped datapath graph for the remainder of this boot.
+	 */
+	enum enic_dma_state datapath_state;
 
 	/* MBOX protocol state — mbox_lock serializes admin WQ sends */
 	struct mutex mbox_lock;
@@ -346,6 +358,11 @@ struct enic {
 	} *vf_state;
 };
 
+static inline bool enic_datapath_is_quarantined(struct enic *enic)
+{
+	return READ_ONCE(enic->datapath_state) == ENIC_DMA_QUARANTINED;
+}
+
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
 {
 	struct enic *enic = vdev->priv;
@@ -466,6 +483,7 @@ int enic_sriov_enabled(struct enic *enic);
 int enic_is_valid_vf(struct enic *enic, int vf);
 int enic_is_dynamic(struct enic *enic);
 int enic_is_sriov_vf_v2(struct enic *enic);
+int enic_close_for_reconfigure(struct net_device *netdev);
 void enic_set_ethtool_ops(struct net_device *netdev);
 int __enic_set_rsskey(struct enic *enic);
 void enic_ext_cq(struct enic *enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 61541fb8db7b..18af3b73cee7 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -381,6 +381,9 @@ static int enic_set_ringparam(struct net_device *netdev,
 	unsigned int tx_pending;
 	int err = 0;
 
+	if (enic_datapath_is_quarantined(enic))
+		return -EBUSY;
+
 	if (ring->rx_mini_max_pending || ring->rx_mini_pending) {
 		netdev_info(netdev,
 			    "modifying mini ring params is not supported");
@@ -407,8 +410,11 @@ static int enic_set_ringparam(struct net_device *netdev,
 			c->max_wq_ring);
 		return -EINVAL;
 	}
-	if (running)
-		dev_close(netdev);
+	if (running) {
+		err = enic_close_for_reconfigure(netdev);
+		if (err)
+			return err;
+	}
 	c->rq_desc_count =
 		ring->rx_pending & 0xffffffe0; /* must be aligned to groups of 32 */
 	c->wq_desc_count =
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 6b5824f45a14..5a205ea3031b 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -71,6 +71,8 @@
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2   0x02b7  /* enet SRIOV V2 VF */
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_VF_USNIC 0x00cf /* enet USNIC VF */
 
+static void enic_terminal_dma_quarantine(struct enic *enic);
+
 /* Supported devices */
 static const struct pci_device_id enic_id_table[] = {
 	{ PCI_VDEVICE(CISCO, PCI_DEVICE_ID_CISCO_VIC_ENET) },
@@ -476,8 +478,7 @@ static void enic_notify_check(struct enic *enic)
 
 static irqreturn_t enic_isr_legacy(int irq, void *data)
 {
-	struct net_device *netdev = data;
-	struct enic *enic = netdev_priv(netdev);
+	struct enic *enic = data;
 	unsigned int io_intr = ENIC_LEGACY_IO_INTR;
 	unsigned int err_intr = ENIC_LEGACY_ERR_INTR;
 	unsigned int notify_intr = ENIC_LEGACY_NOTIFY_INTR;
@@ -1563,22 +1564,25 @@ static void enic_notify_timer(struct timer_list *t)
 
 static void enic_free_intr(struct enic *enic)
 {
-	struct net_device *netdev = enic->netdev;
 	unsigned int i;
 
 	enic_free_rx_cpu_rmap(enic);
 	switch (vnic_dev_get_intr_mode(enic->vdev)) {
 	case VNIC_DEV_INTR_MODE_INTX:
-		free_irq(enic->pdev->irq, netdev);
-		break;
 	case VNIC_DEV_INTR_MODE_MSI:
-		free_irq(enic->pdev->irq, enic);
+		if (enic->non_msix_intr_requested) {
+			free_irq(enic->pdev->irq, enic);
+			enic->non_msix_intr_requested = false;
+		}
 		break;
 	case VNIC_DEV_INTR_MODE_MSIX:
-		for (i = 0; i < enic->intr_count; i++)
-			if (enic->msix[i].requested)
+		for (i = 0; i < enic->intr_count; i++) {
+			if (enic->msix[i].requested) {
 				free_irq(enic->msix_entry[i].vector,
 					enic->msix[i].devid);
+				enic->msix[i].requested = false;
+			}
+		}
 		break;
 	default:
 		break;
@@ -1587,23 +1591,28 @@ static void enic_free_intr(struct enic *enic)
 
 static int enic_request_intr(struct enic *enic)
 {
+	enum vnic_dev_intr_mode intr_mode;
 	struct net_device *netdev = enic->netdev;
+	unsigned long irq_flags;
+	irq_handler_t handler;
 	unsigned int i, intr;
 	int err = 0;
 
 	enic_set_rx_cpu_rmap(enic);
-	switch (vnic_dev_get_intr_mode(enic->vdev)) {
+	intr_mode = vnic_dev_get_intr_mode(enic->vdev);
+	switch (intr_mode) {
 
 	case VNIC_DEV_INTR_MODE_INTX:
-
-		err = request_irq(enic->pdev->irq, enic_isr_legacy,
-			IRQF_SHARED, netdev->name, netdev);
-		break;
-
 	case VNIC_DEV_INTR_MODE_MSI:
-
-		err = request_irq(enic->pdev->irq, enic_isr_msi,
-			0, netdev->name, enic);
+		handler = intr_mode == VNIC_DEV_INTR_MODE_INTX ?
+			enic_isr_legacy : enic_isr_msi;
+		irq_flags = intr_mode == VNIC_DEV_INTR_MODE_INTX ?
+			IRQF_SHARED : 0;
+
+		err = request_irq(enic->pdev->irq, handler, irq_flags,
+				  netdev->name, enic);
+		if (!err)
+			enic->non_msix_intr_requested = true;
 		break;
 
 	case VNIC_DEV_INTR_MODE_MSIX:
@@ -1673,11 +1682,13 @@ static void enic_synchronize_irqs(struct enic *enic)
 	switch (vnic_dev_get_intr_mode(enic->vdev)) {
 	case VNIC_DEV_INTR_MODE_INTX:
 	case VNIC_DEV_INTR_MODE_MSI:
-		synchronize_irq(enic->pdev->irq);
+		if (enic->non_msix_intr_requested)
+			synchronize_irq(enic->pdev->irq);
 		break;
 	case VNIC_DEV_INTR_MODE_MSIX:
 		for (i = 0; i < enic->intr_count; i++)
-			synchronize_irq(enic->msix_entry[i].vector);
+			if (enic->msix[i].requested)
+				synchronize_irq(enic->msix_entry[i].vector);
 		break;
 	default:
 		break;
@@ -1718,11 +1729,51 @@ static void enic_notify_timer_start(struct enic *enic)
 	}
 }
 
+static void enic_datapath_release(struct enic *enic)
+{
+	unsigned int i;
+
+	enic_dev_notify_unset(enic);
+
+	enic_unset_affinity_hint(enic);
+	enic_free_intr(enic);
+
+	for (i = 0; i < enic->wq_count; i++)
+		vnic_wq_clean(&enic->wq[i].vwq, enic_free_wq_buf);
+	for (i = 0; i < enic->rq_count; i++) {
+		vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
+		if (enic->rq[i].pool) {
+			page_pool_destroy(enic->rq[i].pool);
+			enic->rq[i].pool = NULL;
+		}
+	}
+	for (i = 0; i < enic->cq_count; i++)
+		vnic_cq_clean(&enic->cq[i]);
+	for (i = 0; i < enic->intr_count; i++)
+		vnic_intr_clean(&enic->intr[i]);
+
+	WRITE_ONCE(enic->datapath_state, ENIC_DMA_DOWN);
+}
+
+static void enic_datapath_quarantine(struct enic *enic)
+{
+	WRITE_ONCE(enic->datapath_state, ENIC_DMA_QUARANTINED);
+	WRITE_ONCE(enic->mbox_send_disabled, true);
+	netif_device_detach(enic->netdev);
+	netif_carrier_off(enic->netdev);
+	/* Bus-master disable contains the failed function but does not return
+	 * ownership of DMA resources which the device may still reference.
+	 */
+	pci_clear_master(enic->pdev);
+}
+
 /* rtnl lock is held, process context */
 static int enic_open(struct net_device *netdev)
 {
 	struct enic *enic = netdev_priv(netdev);
+	unsigned int rqs_enabled = 0;
 	unsigned int i;
+	int disable_err = 0;
 	int err, ret;
 	unsigned int max_pkt_len = netdev->mtu + VLAN_ETH_HLEN;
 	struct page_pool_params pp_params = {
@@ -1736,6 +1787,11 @@ static int enic_open(struct net_device *netdev)
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 	};
 
+	if (enic_datapath_is_quarantined(enic)) {
+		netdev_err(netdev,
+			   "Datapath DMA remains quarantined until reboot\n");
+		return -EBUSY;
+	}
 	err = enic_request_intr(enic);
 	if (err) {
 		netdev_err(netdev, "Unable to request irq.\n");
@@ -1764,6 +1820,7 @@ static int enic_open(struct net_device *netdev)
 
 		/* enable rq before updating rq desc */
 		vnic_rq_enable(&enic->rq[i].vrq);
+		rqs_enabled++;
 		vnic_rq_fill(&enic->rq[i].vrq, enic_rq_alloc_buf);
 		/* Need at least one buffer on ring to get going */
 		if (vnic_rq_desc_used(&enic->rq[i].vrq) == 0) {
@@ -1802,6 +1859,7 @@ static int enic_open(struct net_device *netdev)
 	enic_rfs_timer_start(enic);
 	if (enic_is_sriov_vf_v2(enic))
 		enic_mbox_vf_link_state_set_running(enic, true);
+	WRITE_ONCE(enic->datapath_state, ENIC_DMA_LIVE);
 
 	return 0;
 
@@ -1814,18 +1872,37 @@ static int enic_open(struct net_device *netdev)
 	netif_tx_disable(netdev);
 	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
 		enic_dev_del_station_addr(enic);
-	for (i = 0; i < enic->wq_count; i++)
-		vnic_wq_disable(&enic->wq[i].vwq);
+	for (i = 0; i < enic->wq_count; i++) {
+		ret = vnic_wq_disable(&enic->wq[i].vwq);
+		if (ret)
+			netdev_err(netdev,
+				   "WQ %u did not stop during open unwind: %d\n",
+				   i, ret);
+		if (ret && !disable_err)
+			disable_err = ret;
+	}
 err_out_free_rq:
-	for (i = 0; i < enic->rq_count; i++) {
+	for (i = 0; i < rqs_enabled; i++) {
 		ret = vnic_rq_disable(&enic->rq[i].vrq);
-		if (!ret) {
-			vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
-			page_pool_destroy(enic->rq[i].pool);
-			enic->rq[i].pool = NULL;
-		}
+		if (ret)
+			netdev_err(netdev,
+				   "RQ %u did not stop during open unwind: %d\n",
+				   i, ret);
+		if (ret && !disable_err)
+			disable_err = ret;
+	}
+	if (disable_err) {
+		/* A partially stopped datapath remains a single DMA ownership
+		 * graph.  Keep every ring, mapping, page pool, interrupt, and the
+		 * notification allocation for the remainder of this boot.
+		 */
+		enic_datapath_quarantine(enic);
+		return err;
 	}
-	enic_dev_notify_unset(enic);
+	enic_datapath_release(enic);
+
+	return err;
+
 err_out_free_intr:
 	enic_unset_affinity_hint(enic);
 	enic_free_intr(enic);
@@ -1838,8 +1915,15 @@ static int enic_stop(struct net_device *netdev)
 {
 	struct enic *enic = netdev_priv(netdev);
 	unsigned int i;
+	int disable_err = 0;
 	int err;
 
+	/* An internal reset can leave IFF_UP set after software has already
+	 * stopped the datapath.  Never disable NAPI or release rings twice.
+	 */
+	if (READ_ONCE(enic->datapath_state) != ENIC_DMA_LIVE)
+		return 0;
+
 	for (i = 0; i < enic->intr_count; i++) {
 		vnic_intr_mask(&enic->intr[i]);
 		(void)vnic_intr_masked(&enic->intr[i]); /* flush write */
@@ -1870,33 +1954,44 @@ static int enic_stop(struct net_device *netdev)
 	for (i = 0; i < enic->wq_count; i++) {
 		err = vnic_wq_disable(&enic->wq[i].vwq);
 		if (err)
-			return err;
+			netdev_err(netdev, "WQ %u did not stop: %d\n", i, err);
+		if (err && !disable_err)
+			disable_err = err;
 	}
 	for (i = 0; i < enic->rq_count; i++) {
 		err = vnic_rq_disable(&enic->rq[i].vrq);
 		if (err)
-			return err;
+			netdev_err(netdev, "RQ %u did not stop: %d\n", i, err);
+		if (err && !disable_err)
+			disable_err = err;
 	}
 
-	enic_dev_notify_unset(enic);
-	enic_unset_affinity_hint(enic);
-	enic_free_intr(enic);
-
-	for (i = 0; i < enic->wq_count; i++)
-		vnic_wq_clean(&enic->wq[i].vwq, enic_free_wq_buf);
-	for (i = 0; i < enic->rq_count; i++) {
-		vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
-		page_pool_destroy(enic->rq[i].pool);
-		enic->rq[i].pool = NULL;
+	if (disable_err) {
+		/* Even queues which stopped belong to this datapath allocation
+		 * graph.  Retain the graph as a unit when any queue times out.
+		 */
+		enic_datapath_quarantine(enic);
+		return disable_err;
 	}
-	for (i = 0; i < enic->cq_count; i++)
-		vnic_cq_clean(&enic->cq[i]);
-	for (i = 0; i < enic->intr_count; i++)
-		vnic_intr_clean(&enic->intr[i]);
+
+	enic_datapath_release(enic);
 
 	return 0;
 }
 
+int enic_close_for_reconfigure(struct net_device *netdev)
+{
+	int err;
+
+	/* dev_close() cannot propagate an ndo_stop() error. */
+	err = enic_stop(netdev);
+	if (err)
+		return err;
+
+	dev_close(netdev);
+	return 0;
+}
+
 static int _enic_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	bool running = netif_running(netdev);
@@ -1974,7 +2069,7 @@ static void enic_poll_controller(struct net_device *netdev)
 		enic_isr_msi(enic->pdev->irq, enic);
 		break;
 	case VNIC_DEV_INTR_MODE_INTX:
-		enic_isr_legacy(enic->pdev->irq, netdev);
+		enic_isr_legacy(enic->pdev->irq, enic);
 		break;
 	default:
 		break;
@@ -2258,11 +2353,17 @@ static void enic_admin_chan_reopen(struct enic *enic)
 static void enic_reset(struct work_struct *work)
 {
 	struct enic *enic = container_of(work, struct enic, reset);
+	int stop_err = 0;
+	bool reopen;
 
-	if (!netif_running(enic->netdev))
+	if (enic_datapath_is_quarantined(enic) ||
+	    !netif_running(enic->netdev))
 		return;
 
 	rtnl_lock();
+	reopen = netif_running(enic->netdev);
+	if (!reopen || enic_datapath_is_quarantined(enic))
+		goto unlock;
 
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
@@ -2276,9 +2377,16 @@ static void enic_reset(struct work_struct *work)
 	if (enic_has_admin_chan(enic))
 		enic_admin_channel_close(enic);
 
-	enic_stop(enic->netdev);
+	if (reopen)
+		stop_err = enic_stop(enic->netdev);
 	if (enic_is_sriov_vf_v2(enic))
 		enic_mbox_vf_link_state_reset(enic);
+	if (enic_datapath_is_quarantined(enic)) {
+		netdev_err(enic->netdev,
+			   "Datapath queue did not stop: %d; DMA resources retained until reboot\n",
+			   stop_err);
+		goto reset_out;
+	}
 
 	enic_dev_soft_reset(enic);
 	enic_reset_addr_lists(enic);
@@ -2287,7 +2395,8 @@ static void enic_reset(struct work_struct *work)
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
 
-	enic_open(enic->netdev);
+	if (reopen)
+		enic_open(enic->netdev);
 
 	/* Re-establish the admin/MBOX channel after the data path is back up.
 	 * It was fully torn down by enic_admin_channel_close() above;
@@ -2297,19 +2406,27 @@ static void enic_reset(struct work_struct *work)
 	if (enic_has_admin_chan(enic))
 		enic_admin_chan_reopen(enic);
 
+reset_out:
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
 
-	call_netdevice_notifiers(NETDEV_REBOOT, enic->netdev);
+	if (reopen)
+		call_netdevice_notifiers(NETDEV_REBOOT, enic->netdev);
 
+unlock:
 	rtnl_unlock();
 }
 
 static void enic_tx_hang_reset(struct work_struct *work)
 {
 	struct enic *enic = container_of(work, struct enic, tx_hang_reset);
+	int stop_err = 0;
+	bool reopen;
 
 	rtnl_lock();
+	reopen = netif_running(enic->netdev);
+	if (!reopen || enic_datapath_is_quarantined(enic))
+		goto unlock;
 
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
@@ -2322,9 +2439,16 @@ static void enic_tx_hang_reset(struct work_struct *work)
 		enic_admin_channel_close(enic);
 
 	enic_dev_hang_notify(enic);
-	enic_stop(enic->netdev);
+	if (reopen)
+		stop_err = enic_stop(enic->netdev);
 	if (enic_is_sriov_vf_v2(enic))
 		enic_mbox_vf_link_state_reset(enic);
+	if (enic_datapath_is_quarantined(enic)) {
+		netdev_err(enic->netdev,
+			   "Datapath queue did not stop: %d; DMA resources retained until reboot\n",
+			   stop_err);
+		goto hang_reset_out;
+	}
 
 	enic_dev_hang_reset(enic);
 	enic_reset_addr_lists(enic);
@@ -2333,7 +2457,8 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
 
-	enic_open(enic->netdev);
+	if (reopen)
+		enic_open(enic->netdev);
 
 	/* Re-establish the admin/MBOX channel after the data path is back up.
 	 * It was fully torn down by enic_admin_channel_close() above;
@@ -2343,11 +2468,14 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	if (enic_has_admin_chan(enic))
 		enic_admin_chan_reopen(enic);
 
+hang_reset_out:
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
 
-	call_netdevice_notifiers(NETDEV_REBOOT, enic->netdev);
+	if (reopen)
+		call_netdevice_notifiers(NETDEV_REBOOT, enic->netdev);
 
+unlock:
 	rtnl_unlock();
 }
 
@@ -2678,10 +2806,13 @@ static int enic_alloc_enic_resources(struct enic *enic)
 	return -ENOMEM;
 }
 
-static void enic_dev_deinit(struct enic *enic)
+static void enic_del_napi(struct enic *enic)
 {
 	unsigned int i;
 
+	if (!enic->napi_added)
+		return;
+
 	for (i = 0; i < enic->rq_count; i++)
 		__netif_napi_del(&enic->napi[i]);
 
@@ -2691,6 +2822,12 @@ static void enic_dev_deinit(struct enic *enic)
 
 	/* observe RCU grace period after __netif_napi_del() calls */
 	synchronize_net();
+	enic->napi_added = false;
+}
+
+static void enic_dev_deinit(struct enic *enic)
+{
+	enic_del_napi(enic);
 
 	enic_free_vnic_resources(enic);
 	enic_clear_intr_mode(enic);
@@ -2783,6 +2920,7 @@ static int enic_dev_init(struct enic *enic)
 				       enic_poll_msix_wq);
 		break;
 	}
+	enic->napi_added = true;
 
 	return 0;
 
@@ -3036,7 +3174,10 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_free_netdev;
 	}
 
-	err = pci_request_regions(pdev, DRV_NAME);
+	/* Terminal DMA quarantine may retain the PCI regions across module
+	 * removal. Use the PCI device name because it outlives module rodata.
+	 */
+	err = pci_request_regions(pdev, dev_name(dev));
 	if (err) {
 		dev_err(dev, "Cannot request PCI regions, aborting\n");
 		goto err_out_disable_device;
@@ -3387,12 +3528,72 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return err;
 }
 
+static int enic_datapath_recheck_on_remove(struct enic *enic)
+{
+	int disable_err = 0;
+	unsigned int i;
+	int err;
+
+	if (!enic_datapath_is_quarantined(enic))
+		return 0;
+
+	/* Removal is the last opportunity to observe that every queue drained.
+	 * Keep the complete graph if even one queue still reports RUNNING.
+	 */
+	for (i = 0; i < enic->wq_count; i++) {
+		err = vnic_wq_disable(&enic->wq[i].vwq);
+		if (err && !disable_err)
+			disable_err = err;
+	}
+	for (i = 0; i < enic->rq_count; i++) {
+		err = vnic_rq_disable(&enic->rq[i].vrq);
+		if (err && !disable_err)
+			disable_err = err;
+	}
+	if (disable_err)
+		return disable_err;
+
+	dev_info(&enic->pdev->dev,
+		 "All datapath queues stopped at remove; releasing DMA graph\n");
+	enic_datapath_release(enic);
+
+	return 0;
+}
+
+static void enic_terminal_dma_quarantine(struct enic *enic)
+{
+	unsigned int i;
+
+	/* Detach every CPU callback before retaining the DMA owner graph.  The
+	 * ordinary stop path can return before freeing IRQs when a queue does
+	 * not stop, so each ownership-aware operation must be idempotent.
+	 */
+	for (i = 0; i < enic->intr_count; i++) {
+		vnic_intr_mask(&enic->intr[i]);
+		(void)vnic_intr_masked(&enic->intr[i]);
+	}
+	if (vnic_dev_get_intr_mode(enic->vdev) == VNIC_DEV_INTR_MODE_INTX)
+		pci_intx(enic->pdev, 0);
+	enic_synchronize_irqs(enic);
+	enic_unset_affinity_hint(enic);
+	enic_free_intr(enic);
+	enic_del_napi(enic);
+	enic_clear_intr_mode(enic);
+	enic_free_affinity_hint(enic);
+
+	/* Preserve netdev, vdev, BAR mappings, regions, rings, and their buffer
+	 * metadata because queue ownership remains unresolved until reboot.
+	 */
+	pci_clear_master(enic->pdev);
+}
+
 static void enic_remove(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 
 	if (netdev) {
 		struct enic *enic = netdev_priv(netdev);
+		bool retain_dma = false;
 
 		disable_work_sync(&enic->reset);
 		disable_work_sync(&enic->tx_hang_reset);
@@ -3429,14 +3630,25 @@ static void enic_remove(struct pci_dev *pdev)
 				pci_disable_sriov(pdev);
 		}
 #endif
+		if (enic_datapath_is_quarantined(enic))
+			enic_datapath_recheck_on_remove(enic);
+		if (enic_datapath_is_quarantined(enic)) {
+			dev_err(&pdev->dev,
+				"Queue DMA ownership unresolved; retaining resources until reboot\n");
+			enic_terminal_dma_quarantine(enic);
+			retain_dma = true;
+			goto disable_device;
+		}
 		enic_dev_deinit(enic);
 		vnic_dev_close(enic->vdev);
 		kfree(enic->pp);
 		vnic_dev_unregister(enic->vdev);
 		enic_iounmap(enic);
 		pci_release_regions(pdev);
+disable_device:
 		pci_disable_device(pdev);
-		free_netdev(netdev);
+		if (!retain_dma)
+			free_netdev(netdev);
 	}
 }
 
diff --git a/drivers/net/ethernet/cisco/enic/vnic_rq.c b/drivers/net/ethernet/cisco/enic/vnic_rq.c
index a662d9fd1199..f76de6432a86 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_rq.c
@@ -6,9 +6,9 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/iopoll.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/delay.h>
 #include <linux/slab.h>
 
 #include "vnic_dev.h"
@@ -150,8 +150,9 @@ void vnic_rq_enable(struct vnic_rq *rq)
 
 int vnic_rq_disable(struct vnic_rq *rq)
 {
-	unsigned int wait;
 	struct vnic_dev *vdev = rq->vdev;
+	u32 running;
+	int err;
 	int i;
 
 	/* Due to a race condition with clearing RQ "mini-cache" in hw, we need
@@ -161,15 +162,16 @@ int vnic_rq_disable(struct vnic_rq *rq)
 	for (i = 0; i < 2; i++) {
 		iowrite32(0, &rq->ctrl->enable);
 
-		/* Wait for HW to ACK disable request */
-		for (wait = 20000; wait > 0; wait--)
-			if (!ioread32(&rq->ctrl->running))
-				break;
-		if (!wait) {
+		/* Poll for up to 500 ms for outstanding operations to drain.
+		 * Preserve both passes required for the RQ mini-cache.
+		 */
+		err = read_poll_timeout(ioread32, running, !running, 10, 500000,
+					false, &rq->ctrl->running);
+		if (err) {
 			vdev_neterr(vdev, "Failed to disable RQ[%d]\n",
 				    rq->index);
 
-			return -ETIMEDOUT;
+			return err;
 		}
 	}
 
diff --git a/drivers/net/ethernet/cisco/enic/vnic_wq.c b/drivers/net/ethernet/cisco/enic/vnic_wq.c
index 5a20bdc62141..3d189d6869dc 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_wq.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_wq.c
@@ -6,9 +6,9 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/iopoll.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/delay.h>
 #include <linux/slab.h>
 
 #include "vnic_dev.h"
@@ -170,21 +170,21 @@ void vnic_wq_enable(struct vnic_wq *wq)
 
 int vnic_wq_disable(struct vnic_wq *wq)
 {
-	unsigned int wait;
 	struct vnic_dev *vdev = wq->vdev;
+	u32 running;
+	int err;
 
 	iowrite32(0, &wq->ctrl->enable);
 
-	/* Wait for HW to ACK disable request */
-	for (wait = 0; wait < 1000; wait++) {
-		if (!(ioread32(&wq->ctrl->running)))
-			return 0;
-		udelay(10);
-	}
+	/* Poll for up to 500 ms for outstanding operations to drain. */
+	err = read_poll_timeout(ioread32, running, !running, 10, 500000,
+				false, &wq->ctrl->running);
+	if (!err)
+		return 0;
 
 	vdev_neterr(vdev, "Failed to disable WQ[%d]\n", wq->index);
 
-	return -ETIMEDOUT;
+	return err;
 }
 
 void vnic_wq_clean(struct vnic_wq *wq,

-- 
2.43.0

