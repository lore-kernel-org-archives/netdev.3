Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127548F824;
	Wed, 12 Aug 2026 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570031; cv=none; b=LTKvcDS7fcCS+ZMki+YNnkZHUPoclzqgphpIzgfuXTp5tDaODELQS7BoiZI5ArG5+RWxu75S1NHfWNLRkWaL1M6NxS+ZVB5Yyzm0B/deTSj3szYxJQ0bCcD1pObqyaD7LZI5yGvadZD5ePb9dHg1taHCmacICa8sytqD3VmwCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570031; c=relaxed/simple;
	bh=CpI6uuxwaxqLVXsYvK8+NR6LrZBjzOqKCCyt8qKKSTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzOalcB4V8quzrl+RXV0+OvXh9jtLXU0kXQPihYI43PnZ13/Ex4opUWvAmn4Q2bXbbA959tfZRuUivMXY/DXJ4MTi2MLdewIPUSk0O1hstt0BdoE8L8CLNSLjLa0SAsLNeWwuKm7YVt7spWQ2FcRMaHWuPI8cOQFzJJ3CRtosgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMD7oP5S; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMD7oP5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786570017; x=1818106017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CpI6uuxwaxqLVXsYvK8+NR6LrZBjzOqKCCyt8qKKSTk=;
  b=FMD7oP5SwmUenUJSTuDQLcJmy2eK8QnEaol45f9lVGoo7qGKNeNLUQoR
   To9+m0AJO4V1S3fLnWxbEZqYmfUoSbqVl6nVRu9e/5rEe+dXGkFieXhx/
   OwggbgmKeSuYvKpZ2IveEpq92K2xlYk+mjp4XdjC3Uz+pEkOq+eeI3zPP
   KKI8JIWOTfOv+MZUyPS1usoZThQuZ3v5X63lT+Bw0PGSbFvSNswR/W897
   Oi2shd9iIaDwLZaarIWPc6E93I8nd7m6zfCr4RvXqlVdjUEjETSHtqjj5
   5xnyIf2YidMYCGirISZwt6zswqvyXIZw/zTFsqyK70j7iRlShm1OyObCz
   Q==;
X-CSE-ConnectionGUID: 9pzvtxSSRXmeQGFrEEveHA==
X-CSE-MsgGUID: jpLjw3woTFe4Y0gb2M4cqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97485639"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="97485639"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:25:45 -0700
X-CSE-ConnectionGUID: gZRJYgz9SrSn4wtf2lQ0Dg==
X-CSE-MsgGUID: cfQT+2AkSJOvl1ahrBl3Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="257546269"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 12 Aug 2026 14:25:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Bharath R <Bharath.r@intel.com>
Subject: [PATCH net-next v8 14/15] ixd: add the core initialization
Date: Wed, 12 Aug 2026 14:25:28 -0700
Message-ID: <20260812212532.905873-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260812212532.905873-1-anthony.l.nguyen@intel.com>
References: <20260812212532.905873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

As the mailbox is setup, initialize the core. This makes use of the send
and receive mailbox message framework for virtchnl communication between
the driver and device Control Plane (CP).

To start with, driver confirms the virtchnl version with the CP. Once that
is done, it requests and gets the required capabilities and resources
needed such as max vectors, queues, vports etc.

Use a unified way of handling the virtchnl messages, where a single
function handles all related memory management and the caller only provides
the callbacks to fill the send buffer and to handle the response.

Place generic control queue message handling separately to facilitate the
addition of protocols other than virtchannel in the future.

Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Bharath R <Bharath.r@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixd/Makefile       |   2 +
 drivers/net/ethernet/intel/ixd/ixd.h          |  13 ++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     | 141 +++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |  34 ++++
 drivers/net/ethernet/intel/ixd/ixd_lib.c      |  36 +++-
 drivers/net/ethernet/intel/ixd/ixd_main.c     |   3 +
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c | 190 ++++++++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |  12 ++
 8 files changed, 430 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h

diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
index 164b2c86952f..90abf231fb16 100644
--- a/drivers/net/ethernet/intel/ixd/Makefile
+++ b/drivers/net/ethernet/intel/ixd/Makefile
@@ -6,5 +6,7 @@
 obj-$(CONFIG_IXD) += ixd.o
 
 ixd-y := ixd_main.o
+ixd-y += ixd_ctlq.o
 ixd-y += ixd_dev.o
 ixd-y += ixd_lib.o
+ixd-y += ixd_virtchnl.o
diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
index 33eee0b7f0f9..4c970031451a 100644
--- a/drivers/net/ethernet/intel/ixd/ixd.h
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -14,19 +14,32 @@
  * @init_task: Delayed initialization after reset
  * @init_task.init_work: Delayed initialization work
  * @init_task.reset_retries: How many times to check, whether reset is completed
+ * @init_task.vc_retries: Number of retries to establish mailbox communication
+ * @mbx_task: Control queue Rx handling
  * @xnm: virtchnl transaction manager
  * @asq: Send control queue info
  * @arq: Receive control queue info
+ * @vc_ver: Negotiated virtchnl version
+ * @vc_ver.major: Negotiated major virtchnl version
+ * @vc_ver.minor: Negotiated minor virtchnl version
+ * @caps: Negotiated virtchnl capabilities
  */
 struct ixd_adapter {
 	struct libie_ctlq_ctx cp_ctx;
 	struct {
 		struct delayed_work init_work;
 		u8 reset_retries;
+		u8 vc_retries;
 	} init_task;
+	struct delayed_work mbx_task;
 	struct libie_ctlq_xn_manager *xnm;
 	struct libie_ctlq_info *asq;
 	struct libie_ctlq_info *arq;
+	struct {
+		u32 major;
+		u32 minor;
+	} vc_ver;
+	struct virtchnl2_get_capabilities caps;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
new file mode 100644
index 000000000000..8712e10c8c50
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include "ixd.h"
+#include "ixd_ctlq.h"
+#include "ixd_virtchnl.h"
+
+#define IXD_CTLQ_RX_TASK_DELAY_JIFFIES	msecs_to_jiffies(300)
+
+/**
+ * ixd_ctlq_clean_sq - Clean the send control queue after sending the message
+ * @adapter: The adapter that sent the messages
+ * @force: Clean regardless of send status
+ *
+ * Free the libie send resources after sending the message and handling
+ * the response.
+ */
+void ixd_ctlq_clean_sq(struct ixd_adapter *adapter, bool force)
+{
+	libie_ctlq_xn_send_clean(adapter->asq, kfree, force);
+}
+
+/**
+ * ixd_ctlq_init_sparams - Initialize control queue send parameters
+ * @adapter: The adapter with initialized mailbox
+ * @sparams: Parameters to initialize
+ * @msg_buf: DMA-mappable pointer to the message being sent
+ * @msg_size: Message size
+ */
+static void ixd_ctlq_init_sparams(struct ixd_adapter *adapter,
+				  struct libie_ctlq_xn_send_params *sparams,
+				  void *msg_buf, size_t msg_size)
+{
+	*sparams = (struct libie_ctlq_xn_send_params) {
+		.rel_tx_buf = kfree,
+		.xnm = adapter->xnm,
+		.ctlq = adapter->asq,
+		.timeout_ms = IXD_CTLQ_TIMEOUT,
+		.send_buf = (struct kvec) {
+			.iov_base = msg_buf,
+			.iov_len = msg_size,
+		},
+	};
+}
+
+/**
+ * ixd_ctlq_do_req - Perform a standard virtchnl request
+ * @adapter: The adapter with initialized mailbox
+ * @req: virtchnl request description
+ *
+ * Return: %0 if a message was sent and received a response
+ * that was successfully handled by the custom callback,
+ * negative error otherwise.
+ */
+int ixd_ctlq_do_req(struct ixd_adapter *adapter, const struct ixd_ctlq_req *req)
+{
+	u8 onstack_send_buff[LIBIE_CP_TX_COPYBREAK] __aligned_largest = {};
+	struct libie_ctlq_xn_send_params send_params = {};
+	struct kvec *recv_mem;
+	void *send_buff;
+	int err;
+
+	send_buff = libie_cp_can_send_onstack(req->send_size) ?
+		    &onstack_send_buff : kzalloc(req->send_size, GFP_KERNEL);
+	if (!send_buff)
+		return -ENOMEM;
+
+	ixd_ctlq_init_sparams(adapter, &send_params, send_buff,
+			      req->send_size);
+
+	send_params.chnl_opcode = req->opcode;
+
+	if (req->send_buff_init)
+		req->send_buff_init(adapter, send_buff, req->ctx);
+
+	ixd_ctlq_clean_sq(adapter, false);
+	err = libie_ctlq_xn_send(&send_params);
+	if (err)
+		return err;
+
+	recv_mem = &send_params.recv_mem;
+	if (req->recv_process)
+		err = req->recv_process(adapter, recv_mem->iov_base,
+					recv_mem->iov_len, req->ctx);
+
+	libie_ctlq_release_rx_buf(recv_mem);
+
+	return err;
+}
+
+/**
+ * ixd_ctlq_handle_msg - Default control queue message handler
+ * @ctx: Control plane communication context
+ * @msg: Message received
+ */
+static void ixd_ctlq_handle_msg(struct libie_ctlq_ctx *ctx,
+				struct libie_ctlq_msg *msg)
+{
+	struct ixd_adapter *adapter = pci_get_drvdata(ctx->mmio_info.pdev);
+
+	if (ixd_vc_can_handle_msg(msg))
+		ixd_vc_recv_event_msg(adapter, msg);
+	else
+		dev_dbg_ratelimited(ixd_to_dev(adapter),
+				    "Received an unsupported opcode 0x%x from the CP\n",
+				    msg->chnl_opcode);
+
+	libie_ctlq_release_rx_buf(&msg->recv_mem);
+}
+
+/**
+ * ixd_ctlq_recv_mb_msg - Receive a potential message over mailbox periodically
+ * @adapter: The adapter with initialized mailbox
+ */
+static void ixd_ctlq_recv_mb_msg(struct ixd_adapter *adapter)
+{
+	struct libie_ctlq_xn_recv_params xn_params = {
+		.xnm = adapter->xnm,
+		.ctlq = adapter->arq,
+		.ctlq_msg_handler = ixd_ctlq_handle_msg,
+		.budget = LIBIE_CTLQ_MAX_XN_ENTRIES,
+	};
+
+	libie_ctlq_xn_recv(&xn_params);
+}
+
+/**
+ * ixd_ctlq_rx_task - Periodically check for mailbox responses and events
+ * @work: work handle
+ */
+void ixd_ctlq_rx_task(struct work_struct *work)
+{
+	struct ixd_adapter *adapter;
+
+	adapter = container_of(work, struct ixd_adapter, mbx_task.work);
+
+	queue_delayed_work(system_dfl_wq, &adapter->mbx_task,
+			   IXD_CTLQ_RX_TASK_DELAY_JIFFIES);
+
+	ixd_ctlq_recv_mb_msg(adapter);
+}
diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.h b/drivers/net/ethernet/intel/ixd/ixd_ctlq.h
new file mode 100644
index 000000000000..8839f9f8f6d5
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IXD_CTLQ_H_
+#define _IXD_CTLQ_H_
+
+#include <linux/net/intel/virtchnl2.h>
+
+#define IXD_CTLQ_TIMEOUT 2000
+
+/**
+ * struct ixd_ctlq_req - Standard virtchnl request description
+ * @opcode: protocol opcode, only virtchnl2 is needed for now
+ * @send_size: required length of the send buffer
+ * @send_buff_init: function to initialize the allocated send buffer
+ * @recv_process: function to handle the CP response
+ * @ctx: additional context for callbacks
+ */
+struct ixd_ctlq_req {
+	enum virtchnl2_op opcode;
+	size_t send_size;
+	void (*send_buff_init)(struct ixd_adapter *adapter, void *send_buff,
+			       void *ctx);
+	int (*recv_process)(struct ixd_adapter *adapter, void *recv_buff,
+			    size_t recv_size, void *ctx);
+	void *ctx;
+};
+
+void ixd_ctlq_clean_sq(struct ixd_adapter *adapter, bool force);
+int ixd_ctlq_do_req(struct ixd_adapter *adapter,
+		    const struct ixd_ctlq_req *req);
+void ixd_ctlq_rx_task(struct work_struct *work);
+
+#endif /* _IXD_CTLQ_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
index 0d601fc091a6..481edccc35ff 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
@@ -2,6 +2,8 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include "ixd.h"
+#include "ixd_ctlq.h"
+#include "ixd_virtchnl.h"
 
 #define IXD_DFLT_MBX_Q_LEN 64
 
@@ -60,6 +62,14 @@ static void ixd_adapter_fill_dflt_ctlqs(struct ixd_adapter *adapter)
  */
 void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter)
 {
+	cancel_delayed_work_sync(&adapter->mbx_task);
+
+	if (adapter->xnm)
+		libie_ctlq_xn_shutdown(adapter->xnm);
+
+	if (adapter->asq)
+		ixd_ctlq_clean_sq(adapter, true);
+
 	if (adapter->xnm)
 		libie_ctlq_xn_deinit(adapter->xnm, &adapter->cp_ctx);
 
@@ -101,6 +111,8 @@ int ixd_init_dflt_mbx(struct ixd_adapter *adapter)
 		return -ENOENT;
 	}
 
+	queue_delayed_work(system_dfl_wq, &adapter->mbx_task, 0);
+
 	return 0;
 }
 
@@ -129,8 +141,30 @@ void ixd_init_task(struct work_struct *work)
 
 	adapter->init_task.reset_retries = 0;
 	err = ixd_init_dflt_mbx(adapter);
-	if (err)
+	if (err) {
 		dev_err(ixd_to_dev(adapter),
 			"Failed to initialize the default mailbox: %pe\n",
 			ERR_PTR(err));
+		return;
+	}
+
+	err = ixd_vc_dev_init(adapter);
+	if (!err) {
+		adapter->init_task.vc_retries = 0;
+		return;
+	}
+
+	libie_ctlq_xn_shutdown(adapter->xnm);
+	ixd_trigger_reset(adapter);
+	ixd_deinit_dflt_mbx(adapter);
+	if (++adapter->init_task.vc_retries > 5 ||
+	    (err != -ETIMEDOUT && err != -EAGAIN && err != -EBUSY)) {
+		dev_err(ixd_to_dev(adapter),
+			"Failed to establish mailbox communication with the hardware: %pe\n",
+			ERR_PTR(err));
+		return;
+	}
+
+	queue_delayed_work(system_dfl_wq, &adapter->init_task.init_work,
+			   IXD_INIT_TASK_DELAY_JIFFIES);
 }
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index a085b40dc75a..32046e4ba553 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include "ixd.h"
+#include "ixd_ctlq.h"
 #include "ixd_lan_regs.h"
 
 MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
@@ -19,6 +20,7 @@ static void ixd_remove(struct pci_dev *pdev)
 
 	/* Do not mix removal with (re)initialization */
 	cancel_delayed_work_sync(&adapter->init_task.init_work);
+
 	/* Leave the device clean on exit */
 	if (adapter->xnm)
 		libie_ctlq_xn_shutdown(adapter->xnm);
@@ -109,6 +111,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_DELAYED_WORK(&adapter->init_task.init_work,
 			  ixd_init_task);
+	INIT_DELAYED_WORK(&adapter->mbx_task, ixd_ctlq_rx_task);
 
 	ixd_trigger_reset(adapter);
 	queue_delayed_work(system_dfl_wq, &adapter->init_task.init_work,
diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
new file mode 100644
index 000000000000..fc3b6d2e28c5
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include "ixd.h"
+#include "ixd_ctlq.h"
+#include "ixd_virtchnl.h"
+
+/**
+ * ixd_vc_recv_event_msg - Handle virtchnl event message
+ * @adapter: The adapter handling the message
+ * @ctlq_msg: Message received
+ */
+void ixd_vc_recv_event_msg(struct ixd_adapter *adapter,
+			   struct libie_ctlq_msg *ctlq_msg)
+{
+	int payload_size = ctlq_msg->data_len;
+	struct virtchnl2_event *v2e;
+
+	if (payload_size < sizeof(*v2e)) {
+		dev_warn_ratelimited(ixd_to_dev(adapter),
+				     "Failed to receive valid payload for event msg (op 0x%X len %u)\n",
+				     ctlq_msg->chnl_opcode,
+				     payload_size);
+		return;
+	}
+
+	v2e = (struct virtchnl2_event *)ctlq_msg->recv_mem.iov_base;
+
+	dev_dbg(ixd_to_dev(adapter), "Got event 0x%X from the CP\n",
+		le32_to_cpu(v2e->event));
+}
+
+/**
+ * ixd_vc_can_handle_msg - Decide if an event has to be handled by virtchnl code
+ * @ctlq_msg: Message received
+ *
+ * Return: %true if virtchnl code can handle the event, %false otherwise
+ */
+bool ixd_vc_can_handle_msg(struct libie_ctlq_msg *ctlq_msg)
+{
+	return ctlq_msg->chnl_opcode == VIRTCHNL2_OP_EVENT;
+}
+
+/**
+ * ixd_handle_caps - Handle VIRTCHNL2_OP_GET_CAPS response
+ * @adapter: The adapter for which the capabilities are being updated
+ * @recv_buff: Buffer containing the response
+ * @recv_size: Response buffer size
+ * @ctx: unused
+ *
+ * Return: %0 if the response format is correct and was handled as expected,
+ * negative error otherwise.
+ */
+static int ixd_handle_caps(struct ixd_adapter *adapter, void *recv_buff,
+			   size_t recv_size, void *ctx)
+{
+	if (recv_size < sizeof(adapter->caps))
+		return -EBADMSG;
+
+	adapter->caps = *(typeof(adapter->caps) *)recv_buff;
+
+	return 0;
+}
+
+/**
+ * ixd_req_vc_caps - Request and save device capability
+ * @adapter: The adapter to get the capabilities for
+ *
+ * Return: success or error if sending the get capability message fails
+ */
+static int ixd_req_vc_caps(struct ixd_adapter *adapter)
+{
+	const struct ixd_ctlq_req req = {
+		.opcode = VIRTCHNL2_OP_GET_CAPS,
+		.send_size = sizeof(struct virtchnl2_get_capabilities),
+		.ctx = NULL,
+		.send_buff_init = NULL,
+		.recv_process = ixd_handle_caps,
+	};
+
+	return ixd_ctlq_do_req(adapter, &req);
+}
+
+/**
+ * ixd_get_vc_ver - Get version info from adapter
+ *
+ * Return: filled in virtchannel2 version info, ready for sending
+ */
+static struct virtchnl2_version_info ixd_get_vc_ver(void)
+{
+	return (struct virtchnl2_version_info) {
+		.major = cpu_to_le32(VIRTCHNL2_VERSION_MAJOR_2),
+		.minor = cpu_to_le32(VIRTCHNL2_VERSION_MINOR_0),
+	};
+}
+
+static void ixd_fill_vc_ver(struct ixd_adapter *adapter, void *send_buff,
+			    void *ctx)
+{
+	*(struct virtchnl2_version_info *)send_buff = ixd_get_vc_ver();
+}
+
+/**
+ * ixd_handle_vc_ver - Handle VIRTCHNL2_OP_VERSION response
+ * @adapter: The adapter for which the version is being updated
+ * @recv_buff: Buffer containing the response
+ * @recv_size: Response buffer size
+ * @ctx: Unused
+ *
+ * Return: %0 if the response format is correct and was handled as expected,
+ * negative error otherwise.
+ */
+static int ixd_handle_vc_ver(struct ixd_adapter *adapter, void *recv_buff,
+			     size_t recv_size, void *ctx)
+{
+	struct virtchnl2_version_info need_ver = ixd_get_vc_ver();
+	struct virtchnl2_version_info *recv_ver;
+
+	if (recv_size < sizeof(need_ver))
+		return -EBADMSG;
+
+	recv_ver = recv_buff;
+	if (le32_to_cpu(need_ver.major) != le32_to_cpu(recv_ver->major) ||
+	    le32_to_cpu(need_ver.minor) != le32_to_cpu(recv_ver->minor))
+		dev_warn(ixd_to_dev(adapter),
+			 "Virtchnl version does not match (expected %u.%u, received %u.%u)\n",
+			 le32_to_cpu(need_ver.major),
+			 le32_to_cpu(need_ver.minor),
+			 le32_to_cpu(recv_ver->major),
+			 le32_to_cpu(recv_ver->minor));
+
+	if (le32_to_cpu(need_ver.major) != le32_to_cpu(recv_ver->major)) {
+		dev_err(ixd_to_dev(adapter),
+			"Device initialization failed due to virtchnl major version mismatch\n");
+		return -EOPNOTSUPP;
+	}
+
+	adapter->vc_ver.major = le32_to_cpu(recv_ver->major);
+	adapter->vc_ver.minor = le32_to_cpu(recv_ver->minor);
+
+	return 0;
+}
+
+/**
+ * ixd_req_vc_version - Request and save Virtchannel2 version
+ * @adapter: The adapter to get the version for
+ *
+ * Return: success or error if sending fails or the response was not as expected
+ */
+static int ixd_req_vc_version(struct ixd_adapter *adapter)
+{
+	const struct ixd_ctlq_req req = {
+		.opcode = VIRTCHNL2_OP_VERSION,
+		.send_size = sizeof(struct virtchnl2_version_info),
+		.ctx = NULL,
+		.send_buff_init = ixd_fill_vc_ver,
+		.recv_process = ixd_handle_vc_ver,
+	};
+
+	return ixd_ctlq_do_req(adapter, &req);
+}
+
+/**
+ * ixd_vc_dev_init - virtchnl device core initialization
+ * @adapter: device information
+ *
+ * Return: %0 on success or error if any step of the initialization fails
+ */
+int ixd_vc_dev_init(struct ixd_adapter *adapter)
+{
+	int err;
+
+	err = ixd_req_vc_version(adapter);
+	if (err) {
+		dev_warn(ixd_to_dev(adapter),
+			 "Getting virtchnl version failed, error=%pe\n",
+			 ERR_PTR(err));
+		return err;
+	}
+
+	err = ixd_req_vc_caps(adapter);
+	if (err) {
+		dev_warn(ixd_to_dev(adapter),
+			 "Getting virtchnl capabilities failed, error=%pe\n",
+			 ERR_PTR(err));
+		return err;
+	}
+
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
new file mode 100644
index 000000000000..1a53da8b545c
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IXD_VIRTCHNL_H_
+#define _IXD_VIRTCHNL_H_
+
+int ixd_vc_dev_init(struct ixd_adapter *adapter);
+bool ixd_vc_can_handle_msg(struct libie_ctlq_msg *ctlq_msg);
+void ixd_vc_recv_event_msg(struct ixd_adapter *adapter,
+			   struct libie_ctlq_msg *ctlq_msg);
+
+#endif /* _IXD_VIRTCHNL_H_ */
-- 
2.47.1

