Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5563B95FF
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786665; cv=none; b=uNvFrKtZNd5RiQ+Vbno6tvs5uyTra+wus9uy18zvHCqC61lx7J/y8L7GP6A0qNV4Nwacz+btRRNISFOJUnyMPYvNo8yny7tzDGk81gJQWhmyn/DoJ1kPQTfP5Ky36cnlC9haI2tH+c6B/JaqL2E5G8H9NELu6bEDHd3Igm7QU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786665; c=relaxed/simple;
	bh=ifZk4jymJiLUGcyXwLDaMIOsDf0aii1f+VtjbmvsShc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbXy17QKJbR1xLeQXAYnaNNXalvurBVnQ4Gq8shozLQVcNz5v9dpV1FZxA+REe0J2h+P6r5h1OfcQ+95B/9Tavm2lLYtx/+c8LyLsdJAeDPQ389zm46Xfp4fuVlFqVM1/U0Jj7Rd2p2I74ajF82PwJUPHp+EQAh70QlHeVRvJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY1NxU/d; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY1NxU/d"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc502d509c0so327098a12.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791786662; x=1792391462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LxsKVuVbCokcStaX9909Y7xuwbZTKwt8+2Tb8Dk91kE=;
        b=QY1NxU/d7UnmzOrYqNSyq9scMF8JJrXhAtfJ0pdM5luK+g0YpsC43PpK2Xm3R5HJAx
         r11lGHzvD0cgh9aw0tG/2EjsMyojFV2JNRhd04Y0mk7Fy3MlL4782HemJaibfIGh/JId
         4qTATDUDcbJNzmzi+9Xk3RmuFk0HcS/CwjTBa52nXg/JEtgjoitA24CwjOhcMbQVMcQA
         foUOHDAxjPaq4Mc7pdijiAXV3nOiT9SJ4bbxEJJVCkRy6pKRwa17x4SiLYP9iNREfu4p
         VYP4lxvyriW9nR/6ZCLa2ae3/XPjY3kw9a7Wzp1/OjUyWWjGi1yp6PBJtZh/Quj8Fx9w
         PrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791786662; x=1792391462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LxsKVuVbCokcStaX9909Y7xuwbZTKwt8+2Tb8Dk91kE=;
        b=UmaoTP+SLduh345prhGuAmBk+aLHPqIj/ZpW9KYcVvjUBv64zioewU5aPSIAE1wLAT
         jYc5Ss3gdpB5Ovqq/fbxZbwmD4pLmybU18aLgwP0sTSAGUk9mt7yuLRKhZ/0q29JI3Py
         BM6rLhDUpNIdtx0Ahd990QD0W+lO/nBtK9VPJYiTUcDVCgNX83wA233F+fD2hSebt51p
         89BfEFPaNHkLjqGv5MJqIdFP8wkBGvOky8+huXIyZpsxzVHqRp5t0ntfy9Fw/3qEh5G3
         yWUQ7nOwaWg0vxCw3L8V7wusX5smRvRp2MoD8AinyAvQTC/42cW4a2/x69HB2qjzNpDR
         hPYA==
X-Gm-Message-State: AFq9FYKZqxcNWFgtu0CrknSbN3NqiXhCK9Mugi4pfYYg1Qvu74KMGHxp
	CLLvza6RoxKzdxAwipAsQR7GHZK4nr8Kdvblkpf91e36eYlZFHHPjf1x
X-Gm-Gg: AYBFou2fR4vE3W0A30lw+gJxo9170WljONDlvs93YthpM/gatL212Uhs8K3FCnElI6S
	FIMdCOb1Fq2tBbodI4uVSQqKPyNp9I3UJahggGSt4bCciZPNpYtQmEqXGl9fxr5STllMJNYLkOY
	M96UVyuH7ksZaVnh0+8IFfnzMO6sHsWGatRzX+WRmll6E6lLzh2WHOEXoQT4I3viYdktOrvZO1S
	TwpydLF6rMKE9ZVDtabUf4FuOg7he2w2sM+AkLlTInvVidTQel90rfnlhV1u2ifTmz1yfHa4BGY
	AOFiGMnY8jc7/yjpYXPx4D+DqwltworcHU9kxpDjifRTD9VlmYVQ73ypoOznslJuZvvjKBwpH2K
	AQ0A2rILvyx73Rd0F1KkcU3DG1xJ7NoDqE/10NzIx/gLdBJdqXXyOwg8ZJEkl0teVAyZ6AOkQ8P
	btIV9nDBQei0+Ub8XJp3YxbWOuVqEfUO9A61EGfbiUxcMxbP5tnEZ1Rk1w/J9Px4ANDWMpCIlg1
	C4t1/qLf02OeFfDjqMwtwID9Bi00jwOJnv+e2FFggC16fHE0rEIkge0lZfTbe3Vcj7Ts8Dz4FhE
	3KE=
X-Received: by 2002:a17:90b:5346:b0:3a4:f9cc:3b9b with SMTP id 98e67ed59e1d1-3ab3a7a1950mr7067950a91.33.1791786662259;
        Sun, 11 Oct 2026 23:31:02 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab371c32cesm14452767a91.16.2026.10.11.23.30.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 23:31:01 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	decot@google.com,
	milena.olech@intel.com,
	joshua.a.hay@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v4 2/2] idpf: keep the mailbox up while tearing down vports on shutdown
Date: Mon, 12 Oct 2026 14:30:27 +0800
Message-ID: <20261012063027.27750-3-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012063027.27750-1-luckilystar08@gmail.com>
References: <20261012063027.27750-1-luckilystar08@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tian Xun Ng <tianxun.ng@bytedance.com>

Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
transaction manager down. Without it, libie_ctlq_xn_shutdown() runs
before idpf_deinit_task() tears the vports down, so every message sent
during that teardown (disable vport, disable queues, destroy vport)
fails at once, and the device is never told that the vports are gone.

A reset should clear that state, but on the system where this was found
the device kept the queues enabled across a warm reboot. The first queue
reconfiguration in the next kernel (udev setting the MTU) sends
VIRTCHNL2_OP_DEL_QUEUES, and the device then writes SW_MARKER TX
completions to the previous kernel's completion rings. With the IOMMU
translating, those writes fault about 19 s into every such boot:

  arm-smmu-v3 arm-smmu-v3.12.auto: event: F_TRANSLATION client: 0006:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0x3ef60840 ipa: 0x0

In IOMMU pass-through mode they corrupt pages the new kernel has reused.

Set IDPF_REMOVE_IN_PROG at the start of idpf_shutdown(), as idpf_remove()
does, so that the event task cannot be requeued and the vports are
destroyed while the mailbox is still up; the previous patch keeps the Tx
timestamp callback away from the state released on the way. So that an
unresponsive control plane does not hold up a reboot for long, cap each
transaction sent during the teardown at 500 ms instead of 60 s, through
a new adapter->vc_xn_timeout_ms, and fail later ones at once after the
first timeout. The SW marker that each disabled Tx queue waits for is
handled the same way: once one does not arrive, the remaining queues do
not wait for theirs. The statistics task stops sending once
IDPF_REMOVE_IN_PROG is set; a request it already has waiting keeps its
own timeout, as bounding that would need support in libie. If the
function has already been reset, for instance a VF whose PF went down
first, idpf_is_reset_detected() fails the messages without waiting.

Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
this series backported to a 6.17 kernel and the IOMMU translating: 20
warm reboots without a fault. Each PF's teardown took about 1.2 s for
six mailbox transactions, with all 64 Tx queue markers received; the
slowest transaction, VIRTCHNL2_OP_DEALLOC_VECTORS, took about 300 ms.
With the driver made to skip sending the teardown messages, every reboot
faulted again.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  3 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 11 ++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 56 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 5 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c8..0739861a1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -625,6 +625,8 @@ struct idpf_vport_config {
  * @asq: Send control queue info
  * @arq: Receive control queue info
  * @xnm: Xn transaction manager
+ * @vc_xn_timeout_ms: Upper bound for each Xn transaction timeout, shortened
+ *		      on shutdown and set to 0 once a shortened one timed out
  * @num_avail_msix: Available number of MSIX vectors
  * @num_msix_entries: Number of entries in MSIX table
  * @msix_entries: MSIX table
@@ -684,6 +686,7 @@ struct idpf_adapter {
 	struct libie_ctlq_info *asq;
 	struct libie_ctlq_info *arq;
 	struct libie_ctlq_xn_manager *xnm;
+	u32 vc_xn_timeout_ms;
 	u16 num_avail_msix;
 	u16 num_msix_entries;
 	struct msix_entry *msix_entries;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 827c795af..e4af4ebd4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1358,6 +1358,9 @@ void idpf_statistics_task(struct work_struct *work)
 	for (i = 0; i < adapter->max_vports; i++) {
 		struct idpf_vport *vport = adapter->vports[i];
 
+		if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+			return;
+
 		if (vport && !test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
 			idpf_send_get_stats_msg(netdev_priv(vport->netdev),
 						&vport->port_stats);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 129bccaa6..2e018d02f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -194,8 +194,18 @@ static void idpf_shutdown(struct pci_dev *pdev)
 {
 	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
 
+	/* As in idpf_remove(): keep the event task from being requeued, and
+	 * destroy the vports while the mailbox is still up.
+	 */
+	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+
+	/* Bound the teardown transactions and Tx queue marker waits started
+	 * from here on, so that an unresponsive control plane costs a single
+	 * timeout. A transaction already in flight keeps its own timeout.
+	 */
+	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
 
@@ -267,6 +277,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->req_rx_splitq = true;
 
 	adapter->pdev = pdev;
+	adapter->vc_xn_timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
 	err = idpf_dev_init(adapter, ent);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d0db60647..a97279447 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -190,20 +190,32 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
  * Cleanup the mailbox queue entries of the previously sent message to
  * unmap and release the buffer.
  *
+ * The transaction timeout is capped at adapter->vc_xn_timeout_ms. Once a
+ * transaction with a shortened timeout times out, later ones fail at once
+ * instead of waiting again.
+ *
  * Return: 0 if the request was successful, -%EBUSY if reset is detected
- *	   or Tx control queue is full, other negative error code on failure.
+ *	   or Tx control queue is full, -%ETIMEDOUT if a shortened transaction
+ *	   already timed out, other negative error code on failure.
  */
 int idpf_send_mb_msg(struct idpf_adapter *adapter,
 		     struct libie_ctlq_xn_send_params *xn_params,
 		     void *send_buf, size_t send_buf_size)
 {
+	u32 timeout_ms = READ_ONCE(adapter->vc_xn_timeout_ms);
 	struct libie_ctlq_msg ctlq_msg = {};
+	int err = 0;
+
+	if (idpf_is_reset_detected(adapter))
+		err = -EBUSY;
+	else if (!timeout_ms)
+		err = -ETIMEDOUT;
 
-	if (idpf_is_reset_detected(adapter)) {
+	if (err) {
 		if (!libie_cp_can_send_onstack(send_buf_size))
 			kfree(send_buf);
 
-		return -EBUSY;
+		return err;
 	}
 
 	idpf_prepare_ptp_mb_msg(adapter, xn_params->chnl_opcode, &ctlq_msg);
@@ -214,10 +226,15 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
 	xn_params->xnm = adapter->xnm;
 	xn_params->ctlq = xn_params->ctlq ? xn_params->ctlq : adapter->asq;
 	xn_params->rel_tx_buf = kfree;
+	xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms, timeout_ms);
 
 	idpf_mb_clean(xn_params->ctlq, false);
 
-	return libie_ctlq_xn_send(xn_params);
+	err = libie_ctlq_xn_send(xn_params);
+	if (err == -ETIMEDOUT && timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
+		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
+
+	return err;
 }
 
 /**
@@ -355,6 +372,33 @@ static int idpf_send_chunked_msg(struct idpf_adapter *adapter,
 	return 0;
 }
 
+/**
+ * idpf_wait_for_marker - wait for TxQ marker
+ * @adapter: driver specific private structure
+ * @txq: Tx queue to wait for
+ *
+ * Return: %true if the marker was received
+ */
+static bool idpf_wait_for_marker(struct idpf_adapter *adapter,
+				 struct idpf_tx_queue *txq)
+{
+	u32 timeout_ms = READ_ONCE(adapter->vc_xn_timeout_ms);
+
+	idpf_queue_set(SW_MARKER, txq);
+
+	if (!timeout_ms)
+		return false;
+
+	idpf_wait_for_sw_marker_completion(txq);
+	if (!idpf_queue_has(SW_MARKER, txq))
+		return true;
+
+	if (timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
+		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
+
+	return false;
+}
+
 /**
  * idpf_wait_for_marker_event_set - wait for software marker response for
  *				    selected Tx queues
@@ -375,9 +419,7 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 
 			netdev = txq->netdev;
 
-			idpf_queue_set(SW_MARKER, txq);
-			idpf_wait_for_sw_marker_completion(txq);
-			markers_rcvd &= !idpf_queue_has(SW_MARKER, txq);
+			markers_rcvd &= idpf_wait_for_marker(qs->adapter, txq);
 			break;
 		default:
 			break;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 5d27805ff..911a25ad9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -7,6 +7,7 @@
 #include <linux/net/intel/virtchnl2.h>
 
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
+#define IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC	500
 
 struct idpf_adapter;
 struct idpf_netdev_priv;
-- 
2.50.1 (Apple Git-155)

