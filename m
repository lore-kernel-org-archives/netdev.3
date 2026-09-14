Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BED03ACF12
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427151; cv=none; b=bHTEGWRGEVVEZnPTnIYHZInYzRc24S5xV5fz/lFrzdZhtpg9ROcqpp+AziVEktYNQBHORJMpHvlMgmqkPJqGDmFT6dnxu+tcBxeqS0/JySjsZRUxZkI5IDujQDQvQVjz7rgWDMS6F2LYz+BySDvt5PBcoy8UHT0WYW+NO53t4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427151; c=relaxed/simple;
	bh=2KoHPjsAHxPo3nIbxfVJxqkhA+ZJXDX3Ce7FCTkVtR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9BjyBOXUGFZIbxBwH1R/zU67iz3AnHmfgQFG+j0VYO8vEZQsVVw883X9yfo3i0EECRArMNkU2O2lDmT3JdebZJ1HTzyg/W1HzDqbuQmp0yL+7B3cTbFI0+YpI7tT7oCAHt1urZDqOGt/hFGc/KDY3IrrsizqDMJ9UfortgTAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Vu1yxwXU; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Vu1yxwXU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bw4oc5DLF9c3gOEPfGZiQT1lxobwSrd7ZD+ekmX2O7E=; t=1789427150; x=1790291150; 
	b=Vu1yxwXUThXju9Ok6i3D/9v6SY/LdOOgo26n3MEJMbOd9IK+5b6ZYVqwh1jxDGB0//DOyMlI4Gg
	sbUOBpdr0Iq+SmaCF/iNsCNhOzyTVnnNAjVZ/v6+gYOOFm3IdTuu2TH9gHsqRTVSynA74ZR6S9Dx4
	/8wC0ExbplH0sj0DauRZksOy9ODPCOTxXO1ECH2yTyt8vO57RspkLmgcQafHqNlpOdpEGw02CCUde
	h/UkqYvuZhSi6KAj8X6hCfluDloQReEqxY1ksmy6B7eP7SlJ/rqnEVhFP4p7vCs3Ha/9fqEOugL7O
	6DT2E0YCR3D10gTXvZFciZQttoCYpzHgjDjw==;
Received: from ouster448.stanford.edu ([172.24.72.71]:60752 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1x6FkC-0007WN-Ku; Mon, 14 Sep 2026 16:05:49 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	skhan@linuxfoundation.org,
	bagasdotme@gmail.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v11 11/15] net: homa: create homa_utils.c
Date: Mon, 14 Sep 2026 16:05:11 -0700
Message-ID: <20260914230517.1190-12-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914230517.1190-1-ouster@cs.stanford.edu>
References: <20260914230517.1190-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: f381877c06e33db9b8e2eda11595152b

This file contains functions for constructing and destructing
"struct homa" and "struct homa_net" objects.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v20:
* Refactor outbound message management:
  * Outbound message data is now buffered in kernel pages that are
    independent of skbs; skbs are then created "just in time" that
    share access to those pages.
  * This eliminates the need for Homa to retain references to skb's
    after they have been passed to ip*xmit.
* Cleanup after errors in homa_init.

Changes for v16:
* Use cpu_relax when spinning

Changes for v11:
* Move link_mbps variable from struct homa_pacer back to struct homa

Changes for v10:
* Remove log messages after alloc errors

Changes for v9:
* Add support for homa_net objects
* Use new homa_clock abstraction layer
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)

Changes for v8:
* Accommodate homa_pacer refactoring

Changes for v7:
* Make Homa a pernet subsystem
* Add support for tx memory accounting
* Remove "lock_slow" functions, which don't add functionality in this
  patch series
* Use u64 and __u64 properly
---
 net/homa/homa_impl.h  |   5 ++
 net/homa/homa_utils.c | 119 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 net/homa/homa_utils.c

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index d52b6a631b0c..a3ac3574eb60 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -363,11 +363,16 @@ static inline bool homa_make_header_avl(struct sk_buff *skb)
 
 extern unsigned int homa_net_id;
 
+void     homa_destroy(struct homa *homa);
+int      homa_init(struct homa *homa);
 void     homa_message_out_init(struct homa_rpc *rpc, int length);
+void     homa_net_destroy(struct homa_net *hnet);
+int      homa_net_init(struct homa_net *hnet, struct homa *homa);
 int      homa_resend_data(struct homa_rpc *rpc, int start, int end);
 void     homa_rpc_handoff(struct homa_rpc *rpc);
 int      homa_rpc_tx_end(struct homa_rpc *rpc);
 struct sk_buff *__homa_skb_alloc(int length);
+void     homa_spin(int ns);
 int      homa_tx_copy_from_user(struct homa_rpc *rpc, struct iov_iter *iter,
 				bool xmit);
 struct sk_buff *homa_tx_skb_alloc(struct homa_rpc *rpc, u32 offset, u32 *end);
diff --git a/net/homa/homa_utils.c b/net/homa/homa_utils.c
new file mode 100644
index 000000000000..94799976a8ab
--- /dev/null
+++ b/net/homa/homa_utils.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+
+
+/* This file contains miscellaneous utility functions for Homa, such
+ * as initializing and destroying homa structs.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+#include "homa_tx_pool.h"
+
+/**
+ * homa_init() - Constructor for homa objects.
+ * @homa:   Object to initialize.
+ *
+ * Return:  0 on success, or a negative errno if there was an error.
+ */
+int homa_init(struct homa *homa)
+{
+	int err;
+
+	memset(homa, 0, sizeof(*homa));
+
+	atomic64_set(&homa->next_outgoing_id, 2);
+	homa->link_mbps = 25000;
+	homa->peertab = homa_peer_alloc_peertab();
+	if (IS_ERR(homa->peertab)) {
+		err = PTR_ERR(homa->peertab);
+		homa->peertab = NULL;
+		goto error;
+	}
+	homa->socktab = kmalloc(sizeof(*homa->socktab), GFP_KERNEL);
+	if (!homa->socktab) {
+		err = -ENOMEM;
+		goto error;
+	}
+	homa_socktab_init(homa->socktab);
+	err = homa_tx_pool_init(homa);
+	if (err) {
+		pr_err("Couldn't initialize homa_tx_pool (errno %d)\n",
+		       -err);
+		goto error;
+	}
+
+	/* Wild guesses to initialize configuration values... */
+	homa->resend_ticks = 5;
+	homa->resend_interval = 5;
+	homa->timeout_ticks = 100;
+	homa->timeout_resends = 5;
+	homa->request_ack_ticks = 2;
+	homa->dead_frags_limit = 100;
+	homa->max_gso_size = 1000;
+	homa->wmem_max = 100000000;
+	homa->bpage_lease_usecs = 10000;
+	homa->bpage_lease_cycles = homa->bpage_lease_usecs  * 2500;
+	return 0;
+
+error:
+	homa_destroy(homa);
+	return err;
+}
+
+/**
+ * homa_destroy() -  Destructor for homa objects.
+ * @homa:      Object to destroy. It is safe if this object has already
+ *             been previously destroyed.
+ */
+void homa_destroy(struct homa *homa)
+{
+	/* The order of the following cleanups matters! */
+	if (homa->socktab) {
+		homa_socktab_destroy(homa->socktab, NULL);
+		kfree(homa->socktab);
+		homa->socktab = NULL;
+	}
+	if (homa->peertab) {
+		homa_peer_free_peertab(homa->peertab);
+		homa->peertab = NULL;
+	}
+	homa_tx_pool_cleanup(homa);
+}
+
+/**
+ * homa_net_init() - Initialize a new struct homa_net.
+ * @hnet:    Struct to initialize.
+ * @homa:    The main Homa data structure to use for the net.
+ * Return:  0 on success, otherwise a negative errno.
+ */
+int homa_net_init(struct homa_net *hnet, struct homa *homa)
+{
+	memset(hnet, 0, sizeof(*hnet));
+	hnet->homa = homa;
+	hnet->prev_default_port = HOMA_MIN_DEFAULT_PORT - 1;
+	return 0;
+}
+
+/**
+ * homa_net_destroy() - Release any resources associated with a homa_net.
+ * @hnet:    Object to destroy; must not be used again after this function
+ *           returns.
+ */
+void homa_net_destroy(struct homa_net *hnet)
+{
+	homa_socktab_destroy(hnet->homa->socktab, hnet);
+	homa_peer_free_net(hnet);
+}
+
+/**
+ * homa_spin() - Delay (without sleeping) for a given time interval.
+ * @ns:   How long to delay (in nanoseconds)
+ */
+void homa_spin(int ns)
+{
+	u64 end;
+
+	end = homa_clock() + homa_ns_to_cycles(ns);
+	while (homa_clock() < end)
+		cpu_relax();
+}
-- 
2.43.0

