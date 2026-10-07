Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833F3C2B92
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352674; cv=none; b=NlhFs0/qkEF9HhQw5JBey+NnaO0wSPKe202vDVacOl8xgeO0E5s8Lm+6M5fEwbjZMbfo/dtS3u0TrQ32ausDGYGNMU+3exiMZbRbCJzf8ObbG8frOKVTGlMyF/WtCej9shGDfb1Lm+7bk78Wpc0pSX0XJStFHudy0vz6HkqIPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352674; c=relaxed/simple;
	bh=TqiIMhaSlGlhCFFLwhmwFqqGF2ZLQjcu6mp35BSNzM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ayuylk/bJ1M5uGqJevt6kKTRYEbyutqEJJhIX8gL2VyK+/FM6C9abA6RTUgQE1nB1qBx6SYGPEjz3dsRKsF3C+NNSYSR+ul3ZTl4RxR2pdqff+7hCuJvGXk30j+/Is5zBfrerRlKur9YDldHL3niilkA06neB1J4wyy5AGZ4Jcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBoZ4h5x; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBoZ4h5x"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398a5aad413so2855052a91.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 22:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791352672; x=1791957472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ikOwxns0VmdI3pIxqCsYIX0nHfPqhedZNBgRsLYW1pU=;
        b=MBoZ4h5xm8fuI6lj5lg9dvO1beTJ4zT/brEZkX234Zne7SV+0yCL1M4QqAeiWA/rAX
         0TICV8UbRoGBVSGeTJ5AwDfuWyoygAu7qIubcRhG+jZE1KXhbqG8RefMwyiIDX0C9N4p
         TAyH6/Q9bHAuvn5c4c46uds35qLPwoSa0T5/mnqOpnNEc9snJTLSDhClvfyeSSarldrz
         LxC1OO/VWgxNYqEDuqTCtgVXuxGa+HZ53IYfutAVc39BSGN/IxNKoBFFVd+aIhw0jZjZ
         2Qb+Tws9I3RpVaj92qHWsje4+FMP89c6T7kYZjRJ0Y3NIfoaxFhMuirkIGexTrZAubBm
         VbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791352672; x=1791957472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikOwxns0VmdI3pIxqCsYIX0nHfPqhedZNBgRsLYW1pU=;
        b=YiWhL0ducas903/Rv+H5xN1vsLeIDoKj3sUZTeB3MnKgqT5z1LOEI9gdqg00K/JfB1
         DepIEp+moA2ERdChlBd5zoCuKHNAYLNDhD/XGbwQV3OhegUHdY8ra5Ymw3JWPfLHCrxk
         loWnNnXp2m3QxPW3PLXZYy2n+ZupEDd9eClIVB0Z8dbB9dheItQ/iiXRiFUbleYbi/IH
         UFMFScSS9IvTnA2Y3EM6eWq9oPJo0X5lXSo5A/zVarwJpaJvCPzmpkm36t2pkpGV0N3h
         L7HnMaRZkTVpuy035uO5vf3MCSIETmaWvzxUKn21YejeVSdTi5wWanbd2c+VtTl6trJJ
         54ag==
X-Gm-Message-State: AFq9FYLXZA/rR3l6btHML6DtJPzUpYJxbHxt64QBSo5zO3Gns3i5cUe2
	YxN2/vb3/pJhGkf9tBA96mGzJ6BW8MKsH8FsHLFkzVm/mqEy+lwGaXva
X-Gm-Gg: AYBFou1wulUDtwyvacZYyT8PyG1EJezPAnqao22BJStJBP5DAWYVKIZQxEYfgLegXF4
	nG8+JaeN+Cu0JywLp8NnNF2kx6R+XtLoCOQ0HAYwE1VzOCuZH0Jk2fpsv7moo1hzrzZAZ4p3WJN
	rTXwBABN7Pe+rqTPowIMI+PTYbRpGMmU++AcxiUeI7jOLEEQpso4ATTUtuIVDtDkqceATyVOPqu
	15/6pdN+QquCUwDU5LVJ4cMjSlCkcmELAJOvhqECjnJ3BIjhaqD9H1Ouf9vdJsYzAq1YLREiEkg
	DMrE1BnpDZOgYywFxwobb9Wwox4daZ5A68cfWN4RjICUDe7vpHi756JIHP0RvJfPkgYfIgjaqcP
	MLgPfqjlY+dSt2LQDn5xw/HnPT1huNqkoCX2xbbOYHDYXeiZi2FuF5BT2GrI2Ete56NdVjV3jLz
	f/Tj86O+ysU+Isn3qeUBJhUraykh3ru6nJW/uqZ8Zs2vE2EiiJTcfQkNygwIups3Gjeiit9V59d
	Y15M7f8KmHT36/36JK0c7whyd6mSVxZeK4IJzKgo2ZNhrLbJrn6vDz9LpSkV0xV7xlUsGrnzP4A
	48QBjp/lO3o5lQ==
X-Received: by 2002:a17:90b:4fc5:b0:3a7:db88:3495 with SMTP id 98e67ed59e1d1-3a8a1d5b8fcmr1120154a91.52.1791352671922;
        Tue, 06 Oct 2026 22:57:51 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60d0b0e2esm3051775ad.7.2026.10.06.22.57.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 22:57:51 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v2] idpf: keep the mailbox up while tearing down vports on shutdown
Date: Wed,  7 Oct 2026 13:57:41 +0800
Message-ID: <20261007055741.30629-1-luckilystar08@gmail.com>
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
fails at once. The device is never told to stop its queues and keeps
them enabled, with the ring addresses of the kernel that is going away.

After a warm reboot, the first queue reconfiguration of a port that has
not been opened yet (udev setting the MTU) sends VIRTCHNL2_OP_DEL_QUEUES.
The device then drains the queues it still considers live and writes
SW_MARKER TX completions to the previous kernel's completion rings. With
the IOMMU translating, those writes fault about 19 s into every such
boot:

  arm-smmu-v3 arm-smmu-v3.12.auto: event: F_TRANSLATION client: 0006:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0x3ef60840 ipa: 0x0

In IOMMU pass-through mode they land on pages the new kernel has already
reused, which shows up as "pagealloc: memory corruption" with
page_poison=1 and as crashes in unrelated code without it.

A function reset on shutdown does not help on these devices: with a PF
reset issued in idpf_shutdown() and PFGEN_RSTAT polled until the reset
completed, every warm reboot still faulted, and the reset the next
kernel issues at probe does not clear the queues either. Delivering the
teardown messages does.

Set IDPF_REMOVE_IN_PROG in idpf_shutdown(), as idpf_remove() does, so
that the vports are destroyed while the mailbox is still up. So that an
unresponsive control plane cannot hold up a reboot, give each mailbox
transaction during shutdown a 2 s timeout instead of 60 s, and fail the
remaining ones at once after the first timeout. If the function has
already been reset, for instance a VF whose PF went down first,
idpf_is_reset_detected() fails them without waiting.

Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
this change backported to a 6.17 kernel and the IOMMU translating: no
faults in 25 warm reboots, against a fault on every warm reboot
without it. Each PF's teardown took about 1.2 s for six mailbox
transactions; the slowest, VIRTCHNL2_OP_DEALLOC_VECTORS, took about
300 ms. To stand in for a control plane that does not reply, the driver
was also built to skip sending mailbox messages during shutdown: the
first transaction timed out after 2 s, the rest failed at once, the
teardown took 2.8 s per PF, and every reboot faulted again.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
v2:
- Drop patch 2 (function reset on shutdown). On a VF it queued
  VIRTCHNL2_OP_RESET_VF and then freed the mailbox, and on these devices
  a PF reset does not clear the stale queues anyway (numbers in the v1
  thread).
- Set IDPF_REMOVE_IN_PROG in idpf_shutdown() instead of changing the
  condition in idpf_vc_core_deinit(); no new idpf_is_reset_detected()
  call (Emil).
- Bound the shutdown teardown: 2 s per transaction instead of 60 s, and
  fail the remaining ones at once after the first timeout (Emil). 2 s is
  about six times the slowest teardown transaction measured here.
- No VF special case, unlike what I suggested in the thread: a VF whose
  PF has been reset already fails fast through the existing
  idpf_is_reset_detected() check in idpf_send_mb_msg(), and a VF with a
  working mailbox leaves queues behind on a warm reboot just like a PF.
  Not tested on a VF; I have no VF setup.
- Compile-tested on net-queue dev-queue (W=1, allmodconfig and
  allyesconfig, no new warnings); runtime-tested as the 6.17 backport
  described above.

v1: https://lore.kernel.org/all/20260917105205.37561-1-luckilystar08@gmail.com/

 drivers/net/ethernet/intel/idpf/idpf.h        |  4 +++
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  7 +++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 28 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c8..5d2e8a346 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -88,6 +88,8 @@ enum idpf_state {
  * @IDPF_REMOVE_IN_PROG: Driver remove in progress
  * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
  * @IDPF_VC_CORE_INIT: virtchnl core has been init
+ * @IDPF_SHUTDOWN_IN_PROG: Driver shutdown in progress
+ * @IDPF_SHUTDOWN_XN_TIMEOUT: A mailbox transaction timed out during shutdown
  * @IDPF_FLAGS_NBITS: Must be last
  */
 enum idpf_flags {
@@ -97,6 +99,8 @@ enum idpf_flags {
 	IDPF_REMOVE_IN_PROG,
 	IDPF_MB_INTR_MODE,
 	IDPF_VC_CORE_INIT,
+	IDPF_SHUTDOWN_IN_PROG,
+	IDPF_SHUTDOWN_XN_TIMEOUT,
 	IDPF_FLAGS_NBITS,
 };
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 129bccaa6..fa27ee1cd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -196,6 +196,13 @@ static void idpf_shutdown(struct pci_dev *pdev)
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+
+	/* Destroy the vports while the mailbox is still up, so that the
+	 * device stops its queues before the next kernel reuses their memory.
+	 * A reset does not clear them on every device.
+	 */
+	set_bit(IDPF_SHUTDOWN_IN_PROG, adapter->flags);
+	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706..5f5d72671 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -190,22 +190,38 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
  * Cleanup the mailbox queue entries of the previously sent message to
  * unmap and release the buffer.
  *
+ * During shutdown each transaction gets a short timeout, and once one of
+ * them times out the rest fail at once, so that an unresponsive control
+ * plane cannot hold up a reboot.
+ *
  * Return: 0 if the request was successful, -%EBUSY if reset is detected
- *	   or Tx control queue is full, other negative error code on failure.
+ *	   or Tx control queue is full, -%ETIMEDOUT if a transaction already
+ *	   timed out during shutdown, other negative error code on failure.
  */
 int idpf_send_mb_msg(struct idpf_adapter *adapter,
 		     struct libie_ctlq_xn_send_params *xn_params,
 		     void *send_buf, size_t send_buf_size)
 {
+	bool shutdown = test_bit(IDPF_SHUTDOWN_IN_PROG, adapter->flags);
 	struct libie_ctlq_msg ctlq_msg = {};
+	int err = 0;
 
-	if (idpf_is_reset_detected(adapter)) {
+	if (idpf_is_reset_detected(adapter))
+		err = -EBUSY;
+	else if (shutdown && test_bit(IDPF_SHUTDOWN_XN_TIMEOUT, adapter->flags))
+		err = -ETIMEDOUT;
+
+	if (err) {
 		if (!libie_cp_can_send_onstack(send_buf_size))
 			kfree(send_buf);
 
-		return -EBUSY;
+		return err;
 	}
 
+	if (shutdown)
+		xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms,
+					      IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
+
 	idpf_prepare_ptp_mb_msg(adapter, xn_params->chnl_opcode, &ctlq_msg);
 	xn_params->ctlq_msg = ctlq_msg.opcode ? &ctlq_msg : NULL;
 
@@ -217,7 +233,11 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
 
 	idpf_mb_clean(xn_params->ctlq, false);
 
-	return libie_ctlq_xn_send(xn_params);
+	err = libie_ctlq_xn_send(xn_params);
+	if (err == -ETIMEDOUT && shutdown)
+		set_bit(IDPF_SHUTDOWN_XN_TIMEOUT, adapter->flags);
+
+	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 5d27805ff..b0809d149 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -7,6 +7,7 @@
 #include <linux/net/intel/virtchnl2.h>
 
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
+#define IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC	2000
 
 struct idpf_adapter;
 struct idpf_netdev_priv;
-- 
2.50.1 (Apple Git-155)

