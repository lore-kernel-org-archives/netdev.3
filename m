Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7DE3A16A1;
	Wed,  2 Sep 2026 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337296; cv=none; b=GdYMkn+QwOq+5b5/QXfpfW5aP3jFBOCQsbSsALO+lJjqVClnfjo1jOcC7ULm08RQzhos+8y2i7D1UBFX5qCVKDrX7RSNRHgC5Q78AYvlpcPYPHVhb2U52Q/zEU3JrOjV4eyM6psprFUDbalgqXsQvW0lL8gxXszROzNYVWO1LHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337296; c=relaxed/simple;
	bh=OfRGk2dnEgFIYme9xYZDFqGVajvAojXwRpM+Sf88x0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUh6JQ9J1+6vFJaBNhAQ79lmgMcjRrB1NMFhyZlxcUKc2xVMLpw8Aivmn99WVlTjnKCW77jbVlJGMMaA7u4dNovwmJM5+xF3oNhx/rJU0fDOY7K2hQ6ReGBZa4iy4gFbsj8eIuOd3ONzTle+ozKpblzXbb40nd7Kqe230oqnwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0nejyZ3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0nejyZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788337295; x=1819873295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OfRGk2dnEgFIYme9xYZDFqGVajvAojXwRpM+Sf88x0Q=;
  b=I0nejyZ3ao4f2rwMmIFIalz+Ltkb5msGm2ebEJta7jOA5NByQqnIod3Q
   wlovCGvdUGmJoi9bf4u3okngBR6hUNFS8aY+rZxfCaz6/NFO+p2ZKhfwy
   1eg5zqBCqF/5cPKn7TBSyI9g/VTBzYnztGuagr0ETPenh1758F82ehdqS
   ynwsyhwA/IVnqGSiJbewBKMWdg3SPu5hOw/q5iN+WI7CGUyXWMbJ65/Zc
   Y9AFWjRwWsjut19ELnk7KPGWIqyR/iitenje9pcLCQ7ANQBa8ECRaHfUl
   R8oyybk57Y6XsGOStNswCz/w8bo1Iu2P+lRw0PALqgrZ4pj+Bt25v0drt
   Q==;
X-CSE-ConnectionGUID: er7Gg/cuSKqIwRq9/lVPQg==
X-CSE-MsgGUID: 7PYkbgKeSl2A15qew1ZZtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88664306"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88664306"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 01:21:32 -0700
X-CSE-ConnectionGUID: 4i9UMuHfRwe+VzBucGKSEA==
X-CSE-MsgGUID: t/lGpYRRTkmB4rhd/3LaWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="273521570"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 02 Sep 2026 01:21:29 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 243BA82; Wed, 02 Sep 2026 10:21:28 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] thunderbolt: Allow batching of descriptors
Date: Wed,  2 Sep 2026 10:21:27 +0200
Message-ID: <20260902082128.1148463-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260902082128.1148463-1-mika.westerberg@linux.intel.com>
References: <20260902082128.1148463-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware allows queueing descriptors ahead of updating producer/consumer
fields. This way it is possible to avoid unnecessary register writes on
hot-paths such as when transferring networking packets. For this reason
introduce an API that allows Thunderbolt service drivers to opt-in for
this and take advantage of batching.

Assisted-by: LLM
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/nhi.c   | 58 ++++++++++++++++++++++++++++++++-----
 include/linux/thunderbolt.h | 42 +++++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 11 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 5827c498c628..a5ecfcf127e9 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -227,12 +227,37 @@ static bool ring_empty(struct tb_ring *ring)
 	return ring->head == ring->tail;
 }
 
+static void __ring_notify(struct tb_ring *ring)
+{
+	lockdep_assert_held(&ring->lock);
+
+	if (ring->notify_pending) {
+		/*
+		 * The doorbell carries the absolute index of the head
+		 * so a single write covers all the descriptors posted
+		 * since the previous one.
+		 */
+		if (ring->is_tx)
+			ring_iowrite_prod(ring, ring->head);
+		else
+			ring_iowrite_cons(ring, ring->head);
+	}
+	ring->notify_pending = false;
+}
+
 /*
  * ring_write_descriptors() - post frames from ring->queue to the controller
+ * @ring: Ring to post the frames to
+ * @notify: Notify the controller about the posted descriptors
+ *
+ * Unless @notify is %true the controller is not notified about the posted
+ * descriptors and the caller is expected to call tb_ring_notify() once it
+ * is done queuing frames. This allows batching of frames before
+ * updating the producer/consumer indices.
  *
  * ring->lock is held.
  */
-static void ring_write_descriptors(struct tb_ring *ring)
+static void ring_write_descriptors(struct tb_ring *ring, bool notify)
 {
 	struct ring_frame *frame, *n;
 	struct ring_desc *descriptor;
@@ -256,11 +281,11 @@ static void ring_write_descriptors(struct tb_ring *ring)
 			descriptor->sof = frame->sof;
 		}
 		ring->head = (ring->head + 1) % ring->size;
-		if (ring->is_tx)
-			ring_iowrite_prod(ring, ring->head);
-		else
-			ring_iowrite_cons(ring, ring->head);
+		ring->notify_pending = true;
 	}
+
+	if (notify)
+		__ring_notify(ring);
 }
 
 /*
@@ -305,7 +330,7 @@ static void ring_work(struct work_struct *work)
 		}
 		ring->tail = (ring->tail + 1) % ring->size;
 	}
-	ring_write_descriptors(ring);
+	ring_write_descriptors(ring, true);
 
 invoke_callback:
 	/* allow callbacks to schedule new work */
@@ -324,7 +349,7 @@ static void ring_work(struct work_struct *work)
 	wake_up(&ring->wait);
 }
 
-int __tb_ring_enqueue(struct tb_ring *ring, struct ring_frame *frame)
+int __tb_ring_enqueue(struct tb_ring *ring, struct ring_frame *frame, bool more)
 {
 	unsigned long flags;
 	int ret = 0;
@@ -332,7 +357,7 @@ int __tb_ring_enqueue(struct tb_ring *ring, struct ring_frame *frame)
 	spin_lock_irqsave(&ring->lock, flags);
 	if (ring->running) {
 		list_add_tail(&frame->list, &ring->queue);
-		ring_write_descriptors(ring);
+		ring_write_descriptors(ring, !more);
 	} else {
 		ret = -ESHUTDOWN;
 	}
@@ -341,6 +366,22 @@ int __tb_ring_enqueue(struct tb_ring *ring, struct ring_frame *frame)
 }
 EXPORT_SYMBOL_GPL(__tb_ring_enqueue);
 
+/**
+ * tb_ring_notify() - Notify the controller about the queued frames
+ * @ring: Ring to notify
+ *
+ * Notifies the controller about frames that were enqueued using
+ * tb_ring_tx_more() or tb_ring_rx_more(). Does nothing if there are no
+ * such frames pending.
+ */
+void tb_ring_notify(struct tb_ring *ring)
+{
+	guard(spinlock_irqsave)(&ring->lock);
+	if (ring->running)
+		__ring_notify(ring);
+}
+EXPORT_SYMBOL_GPL(tb_ring_notify);
+
 /**
  * tb_ring_poll() - Poll one completed frame from the ring
  * @ring: Ring to poll
@@ -788,6 +829,7 @@ void tb_ring_stop(struct tb_ring *ring)
 	ring_iowrite32desc(ring, 0, 12);
 	ring->head = 0;
 	ring->tail = 0;
+	ring->notify_pending = false;
 	ring->running = false;
 
 err:
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index b62dfa52b149..7fb9e7e1aae4 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -553,6 +553,8 @@ struct tb_nhi {
  * @work: Interrupt work structure
  * @is_tx: Is the ring Tx or Rx
  * @running: Is the ring running
+ * @notify_pending: Controller has not been notified about the posted
+ *		    descriptors yet
  * @irq: MSI-X irq number if the ring uses MSI-X. %0 otherwise.
  * @vector: MSI-X vector number the ring uses (only set if @irq is > 0)
  * @flags: Ring specific flags
@@ -582,6 +584,7 @@ struct tb_ring {
 	struct work_struct work;
 	bool is_tx:1;
 	bool running:1;
+	bool notify_pending:1;
 	int irq;
 	u8 vector;
 	unsigned int flags;
@@ -672,7 +675,8 @@ bool tb_ring_flush(struct tb_ring *ring, unsigned int timeout_msec);
 void tb_ring_stop(struct tb_ring *ring);
 void tb_ring_free(struct tb_ring *ring);
 
-int __tb_ring_enqueue(struct tb_ring *ring, struct ring_frame *frame);
+int __tb_ring_enqueue(struct tb_ring *ring, struct ring_frame *frame, bool more);
+void tb_ring_notify(struct tb_ring *ring);
 
 /**
  * tb_ring_rx() - enqueue a frame on an RX ring
@@ -693,7 +697,24 @@ int __tb_ring_enqueue(struct tb_ring *ring, struct ring_frame *frame);
 static inline int tb_ring_rx(struct tb_ring *ring, struct ring_frame *frame)
 {
 	WARN_ON(ring->is_tx);
-	return __tb_ring_enqueue(ring, frame);
+	return __tb_ring_enqueue(ring, frame, false);
+}
+
+/**
+ * tb_ring_rx_more() - enqueue a frame on an RX ring without notifying
+ * @ring: Ring to enqueue the frame
+ * @frame: Frame to enqueue
+ *
+ * Same as tb_ring_rx() but does not notify the controller about the
+ * enqueued frame. The caller must call tb_ring_notify() once it is done
+ * enqueuing frames.
+ *
+ * Return: %-ESHUTDOWN if tb_ring_stop() has been called, %0 otherwise.
+ */
+static inline int tb_ring_rx_more(struct tb_ring *ring, struct ring_frame *frame)
+{
+	WARN_ON(ring->is_tx);
+	return __tb_ring_enqueue(ring, frame, true);
 }
 
 /**
@@ -714,7 +735,22 @@ static inline int tb_ring_rx(struct tb_ring *ring, struct ring_frame *frame)
 static inline int tb_ring_tx(struct tb_ring *ring, struct ring_frame *frame)
 {
 	WARN_ON(!ring->is_tx);
-	return __tb_ring_enqueue(ring, frame);
+	return __tb_ring_enqueue(ring, frame, false);
+}
+
+/**
+ * tb_ring_tx_more() - enqueue a frame on a TX ring without notifying
+ * @ring: Ring to enqueue the frame
+ * @frame: Frame to enqueue
+ *
+ * Same as tb_ring_rx_more() but for TX ring.
+ *
+ * Return: %-ESHUTDOWN if tb_ring_stop() has been called, %0 otherwise.
+ */
+static inline int tb_ring_tx_more(struct tb_ring *ring, struct ring_frame *frame)
+{
+	WARN_ON(!ring->is_tx);
+	return __tb_ring_enqueue(ring, frame, true);
 }
 
 /* Used only when the ring is in polling mode */
-- 
2.50.1

