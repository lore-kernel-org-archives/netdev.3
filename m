Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BFA367B73
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791516450; cv=none; b=qWOepmfyJZkr/96NCiT/rohrrrrimp4c+pB0HGURDTvcMz8MmhfRJ231Z9G5U1iGV+kE2VBwNrW/Xi5JUhyasO3g6fiWhtCJrSVkarfrBW1m3lzQ9SizLyeZk99TgZmSXnnX7oRucavlBuIRAwMv2L5fS4tPO8+AETSX9zLjCzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791516450; c=relaxed/simple;
	bh=tBzUrm4k6Las8IYrUJWGETAOwAB+m2KfUu6hK0ORKNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEiQ+/QAvZcsuD3wyk8Utwu5q0TdlJWpYqsIdyJMjVFsy6hCsGrS+dl+PuqChtnlZ0DWRoFoAcVzQSH5M34PHcsNcACaBHAqOcP35x8wd9wACvCwu/3x9TWhG5Y5PlgxHsldN8i40BIhz0SbTRuuAzw2VQTp16YeOpD7I57sfm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0oj19od; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0oj19od"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so104022a91.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791516437; x=1792121237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FhypQyvK+uhKjW29vTvRiillErDVf7GJbX4G0AwamWk=;
        b=q0oj19odEe00rRSUorR0AopcIPCMz85g1FyiF26z1RDzgOLYtz1P3YjoIeaooHeDXB
         XGqgcrLYoDqpHFojOFLCBhPH9ivCIflxADcXAfyhU17dVsqWsrfq/NEl2bTzqncxiwWW
         ZcTba+2EE8o3VfM4jG1axQU5dj53AMrSazUKL6XOhLA5/r5li+ddtRRKuaX6OKCf1WRk
         qQ0O8HC9RcutPJNAJllwRlN8g1Wu/GwKUoK4zHZivyLMPKANCDWzllgo0IJ2bq7twYVe
         N0R9gBeVjCfQ7OJitJwxfQ3JKeDsv+B/irHgsPkspt3KITVCWrsaMWvGy7qmTjsJGRE/
         m5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791516437; x=1792121237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FhypQyvK+uhKjW29vTvRiillErDVf7GJbX4G0AwamWk=;
        b=gQMotEeCaKbIVoRwxqYodP5XktPyupRUViS8jKHkxq028AJAJOS1SVpsCKgp/IK3GY
         uyXSWq/gOHwbzYFZzfsPhU3Tuc9UeA3cuFClDm8+yv0ZWiXU0ef52iFGPhV5WzYanQ5p
         gmm/FV622g6zS5IutL01RkwuBvW3x/Qjx3dh1YjEWat6m2zlNbmajxiANWVsYWpRUqdB
         i29Ez3/QQqSUaem+ZB11jq4BwYriwoi6Hy0ejNYRCqXBD9q5ZPQXtyCCzzhxDyO1KAs5
         MjLks99iAieF/SahG9L7OQPr2RZYZ9RvI90vQPTiaD5TfFtXDcMNKqy/6xsKBsxvys1O
         nygg==
X-Gm-Message-State: AFq9FYIAHL2wFs7e5fSQCW0C8RwqXDyohTrSxqfFJ2K5AE1pNFfctES+
	qMMNlsFZWMc2A/B8FsLotQNREVNne+/LPIiwjdW82nvp95x8WWk3SCMg
X-Gm-Gg: AYBFou0kdPzqyOskR3/P+Dz7vFVhXTML9p6YnZATuAMR1zX4VjN+GLFzqD/izjjfPZp
	zf62f6yHr+ritxImbC5/diTQntYLpB5PyFcQp+F8JNOmJznyZ5nnKngpJ3av9skXYQbVihKIq1c
	q3mvuxI6MagG1tZ0Fv565k/KC/TkonD22t89F5/aUvLG7RDIuiYjh5n2aGEoLmZXsEUZ2o2OuJh
	r8ECe9LrwhDC3zFoU9z3KpVK95V9AkwLVbhLCgFHmL8etiBywjVmPIdoaiy3WNETcQmlW87o12h
	oBj4FU5nrmipVr+KI/PoT4ELnWiImhjBTz4WenbwEyhgTSNQfkV6R5f9J70u5g7vH4v2Hyq7DXl
	6YIzgSQvlx4IxMWm9D2kdfWgFK6cWAuGOjmRhrG1hF3HHFWYmQchEImHOJhD28sWAezhukw965z
	gijAUq2urfHmJ3n5f8lCQWg5KrStg7f5+P7JCzvHXXKXa+EhKIfRqe3C5YYY5w+a9g1sfPp11ik
	CQ3KERiZ/xHEXvmYe6SiS+zzamtvbki0WIzCljUhb1IjFR8nuu1CBzn6M3TlOAl2cFDnqS3GO/4
	fzA=
X-Received: by 2002:a17:90b:2d86:b0:3a4:f8da:2478 with SMTP id 98e67ed59e1d1-3ab3a778678mr715625a91.29.1791516436586;
        Thu, 08 Oct 2026 20:27:16 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab395e11a0sm761630a91.2.2026.10.08.20.27.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 20:27:16 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	decot@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v3] idpf: keep the mailbox up while tearing down vports on shutdown
Date: Fri,  9 Oct 2026 11:27:06 +0800
Message-ID: <20261009032706.94324-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
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
destroyed while the mailbox is still up. So that an unresponsive control
plane does not hold up a reboot for long, cap each transaction sent
during the teardown at 500 ms instead of 60 s, through a new
adapter->vc_xn_timeout_ms, and fail later ones at once after the first
timeout. A transaction that is already waiting when shutdown starts
keeps its own timeout; bounding that would need support in libie. If
the function has already been reset, for instance a VF whose PF went
down first, idpf_is_reset_detected() fails the messages without waiting.

Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
this change backported to a 6.17 kernel and the IOMMU translating: 20
warm reboots without a fault. Each PF's teardown took about 1.2 s for
six mailbox transactions; the slowest, VIRTCHNL2_OP_DEALLOC_VECTORS,
took about 300 ms, and the queue-related ones at most 240 ms. With the
driver made to skip sending the teardown messages, the first transaction
timed out after 500 ms, the rest failed at once, and every reboot
faulted again.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
v3:
- No new flags (Emil): idpf_shutdown() lowers adapter->vc_xn_timeout_ms
  (60 s from probe), and idpf_send_mb_msg() caps each transaction with
  it and sets it to 0 once a shortened one times out, which fails the
  rest at once.
- Shutdown timeout 500 ms instead of 2 s (Emil).
- Set IDPF_REMOVE_IN_PROG before cancelling the service and event tasks,
  so the event task cannot be requeued (Emil). The timeout is lowered
  after the tasks are cancelled, so a reset that was still running keeps
  its normal timeouts.
- The comment and commit message no longer state that a reset does not
  clear the vports (Emil), and say that a transaction already waiting
  when shutdown starts keeps its own timeout.
- Retested as a 6.17 backport: 20 warm reboots without a fault; the
  slowest teardown transaction took 306 ms.
- Not addressed here: with the transaction manager shut down later, an
  async PTP Tx timestamp reply can race idpf_ptp_release(). The same
  window already exists on remove; left for a separate fix.

v2: https://lore.kernel.org/all/20261007055741.30629-1-luckilystar08@gmail.com/
- Dropped patch 2 (function reset on shutdown): on a VF it queued
  VIRTCHNL2_OP_RESET_VF and then freed the mailbox.
- Bounded the shutdown teardown and failed the rest after the first
  timeout; no VF special case, since a VF whose PF has been reset already
  fails fast through idpf_is_reset_detected(). Not tested on a VF.

v1: https://lore.kernel.org/all/20260917105205.37561-1-luckilystar08@gmail.com/

 drivers/net/ethernet/intel/idpf/idpf.h        |  3 +++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 10 ++++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 25 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 4 files changed, 35 insertions(+), 4 deletions(-)

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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 129bccaa6..ec751f4a6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -194,8 +194,17 @@ static void idpf_shutdown(struct pci_dev *pdev)
 {
 	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
 
+	/* As in idpf_remove(): keep the event task from being requeued, and
+	 * destroy the vports while the mailbox is still up.
+	 */
+	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+
+	/* Bound each teardown transaction, so that an unresponsive control
+	 * plane does not hold up a reboot for long.
+	 */
+	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
 
@@ -267,6 +276,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->req_rx_splitq = true;
 
 	adapter->pdev = pdev;
+	adapter->vc_xn_timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
 	err = idpf_dev_init(adapter, ent);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706..3afd6e62e 100644
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

