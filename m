Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFE4ED1B4
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893575; cv=none; b=Qc3RwjOJtABL3etgzSQm2wPKg/RKxXDDjLMHStUPbwr12QStXjUO3Qk/F8AZQaK9Rnj1ya2NJLRApxp6O6JvqXM7tAnQmp4iWQhFiyWr8skYaI1CfEUK5Qz2xYjje821LkU4vWn83egelUwSkjii9lgcaw5lnXask5RCVHHhQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893575; c=relaxed/simple;
	bh=lRbZ5xjeHgzyMRTWCwgkZIrJiwElaHJYWn4mcJDAEXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiI5fd8D/QlrIMEZ0iKZLZa8T9PO11/wO93lhxe+nObWYAAuqtkU1cW7v/rcR3ZyzjurbOt9SalQU1jWSZ11v83Cr0CnBPiI/e52O1LoZAjVGFI1fysrUdJ/xn9FF1Qu+Gcjkmr1f2Y0bv5nw9IxTwoa9clr1i+QG8eh8vnQjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+bgyW35; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+bgyW35"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514b90bb89so5296348eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 05:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791893573; x=1792498373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgSawlgCCv2bUBiG5qpJyX9qIeKEXbciVx8zpVGh7Rs=;
        b=q+bgyW35M/pNPOyK4a02PGxVkwutXmxdoyCfh80lTMXQcpgC4JzxlHLLvvOmEiqLwU
         SWp/YYC/Aky9gAVGZeZC3IVm5ny2v5gdnUOXYJ6EaGcUngrYVy9FqP0CSSYzRNwwIGwB
         TMqk4+jend/d9aNr/xh4rkgxMAzm3FLCQF5EJmK/sDxhyhGTCIXpBCx9xIoW7lbujYG/
         SNTL3IcDpoCoLYpZBGx2ZhZHKVc9ueXusAbCGZi/RlHTFMiNGKZbu8CDPYx+BgBLNYqf
         z1gLSLLJBLjo+Rm5kFSxYXZ7JZ6RCYnw+MOa1t9PqAyPU8DUHKj6wzuPr/vaUlZJEiAu
         f97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893573; x=1792498373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XgSawlgCCv2bUBiG5qpJyX9qIeKEXbciVx8zpVGh7Rs=;
        b=dgtwXodbso01hDtDBSeJWX65qMt1TD0kpLqkQnMzn81t4/bDHiZ08TPiUaIRRxYIye
         w92GyR8UdlWamVvy/LnD50K6rTaxFHYnToE85icP7nLBbxOrGmmmR2O5Ji+/9A8vuhEW
         OC3nH8nJlAIAnJg4wy7bgryJ0Cv1gkAKhT/s8VNEZ927bD57VqzQQXD95YS4VqgTC/Fw
         bAdm5WY1nwFr5BY2tjDBTErJqDeuEdADy2jL0GrfxvGk+j3NgGDmUa9Omq/5z5V7GkQE
         S7lxyIBG7t196x3xT+cG+/eYGkG35Ue3Zr6i26fls+uqQKyFbbtPbUusAU7dJxAoEszY
         YagA==
X-Gm-Message-State: AFq9FYLk69AKMKbVLS6xGrI3X9U4D6GJN8FJ5ysT1XFIZgiEkuGMkUYK
	Ed5v8e4t9ZEoGq+NOrjpo6GgRP/dIDGO/MOuMtIaNDSiXDmPcUbIx3JB
X-Gm-Gg: AYBFou3gWcIDbWGg8IucbQ8i5Sd0fZWPvI7YbucB3bvrObD8scNO7Dej662ujyuWJ7n
	wzmURHMjIgghSGnEzBTS/c6xeZx3+8SIRRBGTlKct1p5UplQvZtcKH05crIAOuya4cgS2JE0TWA
	Oa/Ib8/DJ2fO4OWX8NX6FXr3AwMYmzMDXEFHwcdMoQ/XkUsA/f1TEmlRyf4n8QAF10PHojK/56F
	05PR3NckY4NREz3CYfFJ931dquH3t1d1iKDVWxUXev77UuarKDbJ/5dB5lxrL3WADNi1XHnKDOo
	zJXBME5NVsJLitFJK9BtAwsVGOr5ELSPJzaM93h3vNXzrG5ViOm2S47eevNqrKAUNtj+2lN6uwj
	E/UO6Ot6c5zCdWVTKM/PsAS/iG8sdjcLVGWujsjKBXPTB6NMTfwJDHiFHnCXnFhqCRHoUbOCEVp
	Ti5Z7JPJ5cuj3nKVY+YfdHCtjj44TLwGGsrv2ZZfOlUZYm0IMbEH45cU+rOE2eZa6nVNMDkSHtG
	baF0ZXPQbg6T5ys+Asrbe2TOqKDR/YNa6waEbb9Mu6P3aS6nrt4WjOxTCKSmt49bcNBTsevBvBF
	lw==
X-Received: by 2002:a05:693c:87c5:20b0:35c:34f:7da3 with SMTP id 5a478bee46e88-35c034f7eadmr4048266eec.21.1791893572852;
        Tue, 13 Oct 2026 05:12:52 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (34.224.142.34.bc.googleusercontent.com. [34.142.224.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca7133asm52304765eec.14.2026.10.13.05.12.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 05:12:52 -0700 (PDT)
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
	alan.brady@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v5 3/3] idpf: keep the mailbox up while tearing down vports on shutdown
Date: Tue, 13 Oct 2026 20:12:24 +0800
Message-ID: <20261013121224.84482-4-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013121224.84482-1-luckilystar08@gmail.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
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

Set IDPF_REMOVE_IN_PROG at the start of idpf_shutdown(), as
idpf_remove() does, so that the event task cannot be requeued and the
vports are destroyed while the mailbox is still up; the first two
patches keep the Tx timestamp callback and the link event handler away
from the state released on the way. So that an unresponsive control
plane does not hold up a reboot for long, cap each transaction sent
during the teardown at 500 ms instead of 60 s, through a new
adapter->vc_xn_timeout_ms, and fail later synchronous ones at once after
the first one times out. If the SW marker of one disabled Tx queue does
not arrive, the remaining queues of that vport do not wait for theirs,
but the mailbox messages that follow are still sent: the device has just
answered DISABLE_QUEUES. A control plane that dies at that point costs
one marker timeout per vport and one mailbox timeout. The statistics
task stops sending once IDPF_REMOVE_IN_PROG is set. A request it already
has waiting, or a reset already running in the event task, keeps its own
timeouts, as bounding those would need support in libie. If the function
has already been reset, for instance a VF whose PF went down first,
idpf_is_reset_detected() fails the messages without waiting.

Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
this series backported to a 6.17 kernel and the IOMMU translating: 20
warm reboots without a fault. Each PF's teardown took about 1.2 s for
six mailbox transactions, with all 64 Tx queue markers received; the
slowest transaction, VIRTCHNL2_OP_DEALLOC_VECTORS, took about 300 ms.
With the first Tx queue marker treated as missing, the other 63 queues
did not wait, all six transactions still completed, the teardown took
about 2 s per PF, and 3 of 3 warm reboots were clean. With the driver
made to skip sending the teardown messages, every reboot faulted again.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  5 ++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 ++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 11 +++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 33 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 5 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c8..a789230dd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -85,7 +85,7 @@ enum idpf_state {
  * @IDPF_HR_FUNC_RESET: Hard reset when TxRx timeout
  * @IDPF_HR_DRV_LOAD: Set on driver load for a clean HW
  * @IDPF_HR_RESET_IN_PROG: Reset in progress
- * @IDPF_REMOVE_IN_PROG: Driver remove in progress
+ * @IDPF_REMOVE_IN_PROG: Driver remove or shutdown in progress
  * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
  * @IDPF_VC_CORE_INIT: virtchnl core has been init
  * @IDPF_FLAGS_NBITS: Must be last
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
index 129bccaa6..21be83dc8 100644
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
+	/* Bound the teardown transactions started from here on, so that an
+	 * unresponsive control plane costs a single timeout. A reset or a
+	 * transaction that is already running keeps its own timeouts.
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
index 2cfd216ae..331d56fae 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -194,20 +194,32 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
  * Cleanup the mailbox queue entries of the previously sent message to
  * unmap and release the buffer.
  *
+ * The transaction timeout is capped at adapter->vc_xn_timeout_ms. Once a
+ * synchronous transaction with a shortened timeout times out, later ones
+ * fail at once instead of waiting again.
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
 
-	if (idpf_is_reset_detected(adapter)) {
+	if (idpf_is_reset_detected(adapter))
+		err = -EBUSY;
+	else if (!timeout_ms)
+		err = -ETIMEDOUT;
+
+	if (err) {
 		if (!libie_cp_can_send_onstack(send_buf_size))
 			kfree(send_buf);
 
-		return -EBUSY;
+		return err;
 	}
 
 	idpf_prepare_ptp_mb_msg(adapter, xn_params->chnl_opcode, &ctlq_msg);
@@ -218,10 +230,15 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
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
@@ -371,6 +388,11 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 	struct net_device *netdev;
 	struct idpf_tx_queue *txq;
 	bool markers_rcvd = true;
+	bool wait_all;
+
+	/* On shutdown, once one marker is missing, don't wait for the rest */
+	wait_all = READ_ONCE(qs->adapter->vc_xn_timeout_ms) >=
+		   IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
 	for (u32 i = 0; i < qs->num; i++) {
 		switch (qs->qs[i].type) {
@@ -380,7 +402,8 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 			netdev = txq->netdev;
 
 			idpf_queue_set(SW_MARKER, txq);
-			idpf_wait_for_sw_marker_completion(txq);
+			if (markers_rcvd || wait_all)
+				idpf_wait_for_sw_marker_completion(txq);
 			markers_rcvd &= !idpf_queue_has(SW_MARKER, txq);
 			break;
 		default:
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

