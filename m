Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316817;
	b=zcyh9bojWGK7bHSML49mF73psRFxhzBCHZpUt9ZYRNS/jssZusp0VlYSv/vYn3FPQOBj
	 OnMS5Eus15gT67apgP86VC8fFwIsgLprxaIilVEgZLFEni5fcrCEK1Y/DllkioKJngEeN
	 JR/JFsuGPLEsWo5JE/5a30qC266AV+r3N70b8KRzuijQpmHOHUZeihEQJ/zhK0clkNqcj
	 X3Nk3PojFq8ds1QR5Inn2vVHZFkbAdQFpTHx9zkndgOTov6Sjx/4sXM4uM38XvNCU9muC
	 R+4kUE1YslElZMQaMR4IqLFG/KAbmFi4Mkpf6uKCvwfxXXV8Vhp40j+iVZVLm6NUNCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316817;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CQPixXX46SSei/PaZ3yIw0VntsQHSpf9e3B9af0Elag=;
	b=zmWWEvIQKR8ouMwAzoy0c+NPV9ekXH0zxlDg3Bk9aStdPcl+ZMmfnARRNJF7uffPjjQQ
	 kosZRQfjR8ek6CLYe4E4SPAm7qKC8gHfeREYbDcxm0CzW+1AGDiICNhng/fkkQk4aNvms
	 tzGUQ9rgqjbd0ez5zwcJgbGB80JVZcSFQJBTaT/PPz/zPlCvoUbOBN10Gnn7bBKflwYy3
	 8cinQLlwNSkKaZ0mSMluOQ2f/aq34yg9x85EnTkdadVgfWFZjKfWwV3qpkQl+Pa2g0Tsu
	 BvR69g3Qj8I7ktPu1wwCaeIwFV2zwg9v7oZtCGC16UdrGlFWxJYjo0819ckpYrM1PAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hP7Mcpyf;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BfNNuOr3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A26073B3E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0A26073B3E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hP7Mcpyf;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BfNNuOr3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQPixXX46SSei/PaZ3yIw0VntsQHSpf9e3B9af0Elag=;
	b=hP7McpyfzEd8W8W/5fEp2svtpLDmMuE3u9SBYT4ESTwvhBOlqzmsAW6R+tINNEoNkJyoyR
	Vy8C/omnO8Y1i4c7oKybE9Yki/eG4RIBvObD2qJ86G/8aJKzuPOZFGsWf+EJ6K9ZlOWGvE
	z8j/7zEFPb8o0ju2eos1B0+R9COKvjw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381--cVCZjLwPT6lrATIPGKIJA-1; Tue, 10 Nov 2026 08:20:14 -0500
X-MC-Unique: -cVCZjLwPT6lrATIPGKIJA-1
X-Mimecast-MFC-AGG-ID: -cVCZjLwPT6lrATIPGKIJA_1794316814
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c4163a5400eso15571766b.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 05:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316813; x=1794921613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQPixXX46SSei/PaZ3yIw0VntsQHSpf9e3B9af0Elag=;
        b=BfNNuOr3SMGPtD6SYG6M03lPaysC68itQ5pf9wq/ns6PD4Jgsi33X2nMwBzaheotFN
         DwxXoG3CnbWBH3zTnuZr34iv2d73zskH1Wp5ywwMbP9haM1XWbvJ0mFJNmf/lKZSX2/v
         ALNtqNQXGh+BY5czRB9LgaxMbjhfyS+XwLCpNxwZ907C2kRfPSJrKmdYLaDhjnWMdLXS
         0/dcFXgMsCS405cND3iR66pO2wVBeTZDZxnKjpUDjoV+F25fJdIiB/KL8s8SXdyt2rTl
         SiaqbOGNxBMcV3HoABz08mirSwF1/1LUfdp4bZfnxuW+XBF2R1R9GlmIuTXPBCEWzXd/
         eUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316813; x=1794921613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQPixXX46SSei/PaZ3yIw0VntsQHSpf9e3B9af0Elag=;
        b=d4Ot9W+TLfYcFj/Pqv8n/BBORzmmr1wxkaw0u80dVyoBmzJJ2Rp8D9041gpVv6sfXR
         C1eVqpc2WP1bPTJ8KP7rGVg4z24E4dfmCX4MX2Y7sZILW+uU3vnIr+IUuTUywsyM/8iM
         z7E56aD9wer2vynWeVSOOWyHrcu9UJ4k7V1EZ7ZYbT3xuhJK1Jsvqfdqh/h93r2uXjIR
         O+8NIMS0uQSy59cAhhUl5HfFRYzdsHovMfLoqNfZu+HsHxMF1BKP+l+E+xAth/lgT1af
         iyA75aKl7UXcwsGwyo30z2F3NIl7M6N/+Vqu3wRcwqhkdqa1mt7nIQax3/XcrFCdgWMO
         lVcA==
X-Forwarded-Encrypted: i=1; AL+hErHU2DatTd+n80KkmHISUo3QvzmYvyWxIyzS24CZEB5LmMfLMFCOCRMP2tWqx1pylpc0Ba2hM2I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FzcVK/1mwoeP9VKP/YFVKj9ZP/8y9Y+t4ujrs7cNYWq37FufF
	lgI8URm/YWwh0bs8n9Cp9nNE5ilqeXTJVZqoagIajEQaWEA9WIimhVnrxIJGA8GTgrQfZ8jSncF
	ejct/tyNCk+dCzGkc1Be7XW8nMn5J6UyHUlLX94QyuK86g32kjhIOX9KcW9o8CmQuaQ==
X-Gm-Gg: AYBFou12oNyHqTtyq0jfPSwD4WqPBdQfpPnYOxq3wJoQo5zlvt+H66tKM1BRgmbxS+B
	LHcwiFkHTwSfz2mw5uhEUMbon9leSsqjguhz8c0C6S++FuJYYMaUIHlngmjNWNrXr7GBLgN40FK
	UsBAj3ja+CNYKsOUwVdHHME3InICcHo+kbNgfsi0m0KPYcXFnQb7g7bPYmD+ZhkLhem4HRGIAnG
	uMNCCk6tBSAUjvwDWhHUbVbDyW/yQn1uvd2ZBVaoU1sb0qhndnKp3snv+0JicFa1CRV4PUa8Lsh
	kbfXzVDhe+2EwbxVnjVW3GIEtRy+h4b4VSkdwYZc7bxcCnYUcDA4KFDzUkw2KN9GiZFKEylAAcK
	wOOzKnMJA3Yd7UHqExix1k4RJoI/1ZjA7A0KMIttWj8uGo0Eq6I6Xat15ZIYsUy69il5MK/GHB9
	jhBAHFzIhuaiFncdhDuJgb0dgMz5ioERLsg7QA+XZP3xkE6y+TKWLY+0vTrlA1UXYF2Z1Gd/YYY
	Yq69rmJvTjhN+b+aenIxIrWC2mwR8BScl+rZpJM9lGWpv9g+t25
X-Received: by 2002:a17:907:608a:b0:c4d:939:526b with SMTP id a640c23a62f3a-c5048c7308cmr238325766b.0.1794316813173;
        Tue, 10 Nov 2026 05:20:13 -0800 (PST)
X-Received: by 2002:a17:907:608a:b0:c4d:939:526b with SMTP id a640c23a62f3a-c5048c7308cmr238321866b.0.1794316812677;
        Tue, 10 Nov 2026 05:20:12 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:12 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 03/12] io_uring/opaque: add backing accounting and immutable versions
Date: Tue, 10 Nov 2026 13:19:57 +0000
Message-Id: <20261110132006.3280986-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110132006.3280986-1-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
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

Add bounded backing-byte and extent accounting, immutable version
references, vectors and generation handles. Separate ordinary capacity,
reply reserve and transient reservations; update byte/transient pairs
coherently for watermark hysteresis. Capacity returns precede batched
collector wakes. The feature selects the exclusive receive-owner support.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 io_uring/Kconfig  |  11 ++
 io_uring/Makefile |   1 +
 io_uring/opaque.c | 399 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 411 insertions(+)
 create mode 100644 io_uring/opaque.c

diff --git a/io_uring/Kconfig b/io_uring/Kconfig
index a283d9e53787..5b696cf266f6 100644
--- a/io_uring/Kconfig
+++ b/io_uring/Kconfig
@@ -15,6 +15,17 @@ config IO_URING_BPF
 	depends on BPF
 	depends on NET
 
+config IO_URING_OPAQUE_OBJ
+	bool "io_uring opaque TCP payload objects"
+	default n
+	depends on IO_URING && INET
+	select SOCK_RX_OWNER
+	help
+	  Retain immutable TCP payloads as kernel-resident objects that can
+	  be inspected, transmitted and compacted through io_uring. No network
+	  device zerocopy support or mapped receive area is required.
+	  Applications manage payload lifetime through generation handles.
+
 config IO_URING_BPF_OPS
 	def_bool y
 	depends on IO_URING
diff --git a/io_uring/Makefile b/io_uring/Makefile
index 965bb60e9f7b..81710127046c 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_IO_URING)		+= io_uring.o opdef.o kbuf.o rsrc.o notif.o \
 					query.o loop.o
 
 obj-$(CONFIG_IO_URING_ZCRX)	+= zcrx.o
+obj-$(CONFIG_IO_URING_OPAQUE_OBJ)	+= opaque.o
 obj-$(CONFIG_IO_WQ)		+= io-wq.o
 obj-$(CONFIG_FUTEX)		+= futex.o
 obj-$(CONFIG_EPOLL)		+= epoll.o
diff --git a/io_uring/opaque.c b/io_uring/opaque.c
new file mode 100644
index 000000000000..2fd9db898e67
--- /dev/null
+++ b/io_uring/opaque.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Kernel-resident immutable TCP payloads. */
+#include <linux/bitmap.h>
+#include <linux/bvec.h>
+#include <linux/file.h>
+#include <linux/highmem.h>
+#include <linux/memcontrol.h>
+#include <linux/overflow.h>
+#include <linux/rbtree.h>
+#include <linux/sched/mm.h>
+#include <linux/skbuff.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <net/tcp.h>
+#include <uapi/linux/io_uring/opaque.h>
+
+#include "io_uring.h"
+#include "cancel.h"
+#include "opaque_internal.h"
+#include "rsrc.h"
+#include "tw.h"
+
+static bool io_opaque_budget_ready(struct io_opaque_req *op, unsigned long now)
+{
+	struct io_opaque_store *store = op->store;
+	u64 limit = io_opaque_rx_limit(store);
+	u64 used = atomic64_read(&store->bytes);
+
+	lockdep_assert_held(&store->wait_lock);
+	return !time_before(now, op->retry_at) && used <= limit &&
+	       op->need_bytes <= limit - used &&
+	       atomic_read(&store->extents) < store->config.max_extents - 2;
+}
+
+/*
+ * Let in the waiters for budget that the budget lets go on, at most
+ * IO_OPAQUE_WAKE_BATCH of them in a hold of wait_lock. Those left over are for
+ * the retry work, and that is why this says whether there were any: a caller
+ * that wants them in now repeats it. The work comes a jiffy later, or as late
+ * as a timer that is already pending, which queueing never moves earlier.
+ */
+static bool io_opaque_wake_budget(struct io_opaque_store *store)
+{
+	struct io_opaque_req *op, *next;
+	unsigned long delay = MAX_JIFFY_OFFSET;
+	unsigned long now = jiffies;
+	unsigned int woken = 0;
+	bool stopped, more = false;
+
+	guard(spinlock)(&store->wait_lock);
+	stopped = READ_ONCE(store->dead);
+	list_for_each_entry_safe(op, next, &store->budget_waits, wait) {
+		struct socket *sock = sock_from_file(op->req->file);
+
+		if (!stopped && !READ_ONCE(op->stream->closed)) {
+			if (time_before(now, op->retry_at)) {
+				delay = min(delay, op->retry_at - now);
+				continue;
+			}
+			if (!io_opaque_budget_ready(op, now))
+				continue;
+			if (woken == IO_OPAQUE_WAKE_BATCH) {
+				delay = 1;
+				more = true;
+				continue;
+			}
+		}
+		list_del_init(&op->wait);
+		/* A wake is not a reservation; the collector rechecks on entry. */
+		woken++;
+		/* Native multishot polling also observes FIN, RST and urgent data. */
+		wake_up_interruptible_poll(sk_sleep(sock->sk), EPOLLIN);
+	}
+	if (!stopped && delay != MAX_JIFFY_OFFSET)
+		queue_delayed_work(system_dfl_wq, &store->retry_work, delay);
+	return more;
+}
+
+/* As io_opaque_wake_budget(), until the batch leaves nobody behind. */
+static void io_opaque_wake_budget_all(struct io_opaque_store *store)
+{
+	while (io_opaque_wake_budget(store))
+		;
+}
+
+int io_opaque_memory_mode(struct io_opaque_store *store)
+{
+	unsigned int seq;
+	int mode, next;
+	u64 used, transient;
+
+	if (!store->config.high_watermark)
+		return IORING_OPAQUE_MEMORY_NORMAL;
+	for (;;) {
+		mode = atomic_read(&store->memory_mode);
+		/* Watermarks measure payload held: compaction copies and framing are not. */
+		do {
+			seq = read_seqcount_begin(&store->transient_seq);
+			used = atomic64_read(&store->bytes);
+			transient = atomic64_read(&store->transient);
+		} while (read_seqcount_retry(&store->transient_seq, seq));
+		used = used > transient ? used - transient : 0;
+		next = mode;
+		if (mode == IORING_OPAQUE_MEMORY_NORMAL && used >= store->config.high_watermark)
+			next = IORING_OPAQUE_MEMORY_LOWMEM;
+		else if (mode == IORING_OPAQUE_MEMORY_LOWMEM && used <= store->config.low_watermark)
+			next = IORING_OPAQUE_MEMORY_NORMAL;
+		if (next == mode)
+			return mode;
+		/* Recheck occupancy after winning a concurrent mode transition. */
+		atomic_try_cmpxchg(&store->memory_mode, &mode, next);
+	}
+}
+
+bool io_opaque_charge(struct io_opaque_store *store, u64 bytes, bool rx)
+{
+	u64 limit = store->config.hard_limit - store->config.reply_reserve;
+	s64 used = atomic64_read(&store->bytes);
+
+	if (rx)
+		limit -= store->config.compact_headroom;
+	for (;;) {
+		if (bytes > limit || used > limit - bytes)
+			return false;
+		if (atomic64_try_cmpxchg(&store->bytes, &used, used + bytes)) {
+			io_opaque_memory_mode(store);
+			return true;
+		}
+	}
+}
+
+/* Give bytes back to the store, and let nobody in on them yet. */
+static void io_opaque_uncharge_quiet(struct io_opaque_store *store, u64 bytes)
+{
+	atomic64_sub(bytes, &store->bytes);
+	io_opaque_memory_mode(store);
+}
+
+void io_opaque_uncharge(struct io_opaque_store *store, u64 bytes)
+{
+	io_opaque_uncharge_quiet(store, bytes);
+	io_opaque_wake_budget(store);
+}
+
+/* Restore both budgets before waking collectors after a failed reservation. */
+static void io_opaque_extent_unreserve(struct io_opaque_store *store, u64 bytes)
+{
+	atomic_dec(&store->extents);
+	if (bytes)
+		io_opaque_uncharge_quiet(store, bytes);
+	io_opaque_wake_budget(store);
+}
+
+/* Charge bytes that watermarks ignore; bytes and transient change in one write. */
+bool io_opaque_charge_transient(struct io_opaque_store *store, u64 bytes, u64 limit)
+{
+	s64 used;
+	bool charged = false;
+
+	spin_lock(&store->transient_lock);
+	write_seqcount_begin(&store->transient_seq);
+	used = atomic64_read(&store->bytes);
+	for (;;) {
+		if (bytes > limit || used > limit - bytes)
+			break;
+		if (atomic64_try_cmpxchg(&store->bytes, &used, used + bytes)) {
+			atomic64_add(bytes, &store->transient);
+			charged = true;
+			break;
+		}
+	}
+	write_seqcount_end(&store->transient_seq);
+	spin_unlock(&store->transient_lock);
+	return charged;
+}
+
+/* Uncharge and stop excluding transient bytes; the two amounts may differ. */
+void io_opaque_release_transient(struct io_opaque_store *store, u64 uncharge,
+				 u64 transient)
+{
+	spin_lock(&store->transient_lock);
+	write_seqcount_begin(&store->transient_seq);
+	atomic64_sub(uncharge, &store->bytes);
+	atomic64_sub(transient, &store->transient);
+	write_seqcount_end(&store->transient_seq);
+	spin_unlock(&store->transient_lock);
+	io_opaque_memory_mode(store);
+	if (uncharge)
+		io_opaque_wake_budget(store);
+}
+
+static bool io_opaque_extent_reserve(struct io_opaque_store *store)
+{
+	int nr = atomic_read(&store->extents);
+
+	while (nr < store->config.max_extents) {
+		if (atomic_try_cmpxchg(&store->extents, &nr, nr + 1))
+			return true;
+	}
+	return false;
+}
+
+static int io_opaque_memcg_charge(struct io_opaque_store *store, u64 bytes)
+{
+#ifdef CONFIG_MEMCG
+	if (store->objcg)
+		return obj_cgroup_charge(store->objcg,
+					GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN, bytes);
+#endif
+	return 0;
+}
+
+static void io_opaque_memcg_uncharge(struct io_opaque_store *store, u64 bytes)
+{
+#ifdef CONFIG_MEMCG
+	if (store->objcg)
+		obj_cgroup_uncharge(store->objcg, bytes);
+#endif
+}
+
+struct io_opaque_extent *io_opaque_extent_new(struct io_opaque_store *store,
+					      struct page *page, u32 offset,
+					      u32 length, u64 start,
+					      bool reserved)
+{
+	struct io_opaque_chunk *chunk;
+	u64 charge = page_size(compound_head(page));
+
+	if (!io_opaque_extent_reserve(store))
+		return ERR_PTR(-ENOBUFS);
+	if (!reserved && !io_opaque_charge(store, charge, true))
+		goto no_space;
+	if (!reserved && io_opaque_memcg_charge(store, charge))
+		goto no_memory;
+	chunk = kzalloc_obj(*chunk, GFP_KERNEL_ACCOUNT);
+	if (!chunk) {
+		if (!reserved)
+			io_opaque_memcg_uncharge(store, charge);
+		goto no_memory;
+	}
+	refcount_set(&chunk->backing.refs, 1);
+	chunk->backing.page = compound_head(page);
+	chunk->backing.charge = charge;
+	chunk->backing.accounted = !reserved && store->objcg;
+	chunk->extent.backing = &chunk->backing;
+	chunk->extent.start = start;
+	chunk->extent.offset = offset + (page - compound_head(page)) * PAGE_SIZE;
+	chunk->extent.length = length;
+	chunk->extent.embedded = true;
+	INIT_LIST_HEAD(&chunk->extent.list);
+	return &chunk->extent;
+no_memory:
+	io_opaque_extent_unreserve(store, reserved ? 0 : charge);
+	return ERR_PTR(-ENOMEM);
+no_space:
+	io_opaque_extent_unreserve(store, 0);
+	return ERR_PTR(-ENOBUFS);
+}
+
+/*
+ * Let go of @extent, and of its backing if it was the last to use it. Returns
+ * the charge of the backing that went, for the caller to give back to the
+ * store: giving it back lets those waiting for budget in, which one free does
+ * once and a list of them once, not once per extent.
+ */
+static u64 io_opaque_extent_release(struct io_opaque_store *store, struct io_opaque_extent *extent)
+{
+	struct io_opaque_backing *backing = extent->backing;
+	u64 charge = 0;
+
+	list_del(&extent->list);
+	if (!extent->embedded)
+		kfree(extent);
+	atomic_dec(&store->extents);
+	if (refcount_dec_and_test(&backing->refs)) {
+		charge = backing->charge;
+
+		if (backing->accounted)
+			io_opaque_memcg_uncharge(store, charge);
+		put_page(backing->page);
+		kfree(container_of(backing, struct io_opaque_chunk, backing));
+	}
+	return charge;
+}
+
+/*
+ * Free the extents of @list. What they held is returned to the store in one
+ * step, and the waiters for budget are looked at in one go: each look takes
+ * wait_lock and walks the list of them, and a 1 MB object that is not one
+ * mapping can have 700 extents. The look is repeated while it leaves ready
+ * waiters behind, so that they are let in by the free and not by the retry
+ * work.
+ */
+static void io_opaque_extents_free(struct io_opaque_store *store,
+				   struct list_head *list)
+{
+	struct io_opaque_extent *extent, *next;
+	bool any = false;
+	u64 charge = 0;
+
+	list_for_each_entry_safe(extent, next, list, list) {
+		charge += io_opaque_extent_release(store, extent);
+		any = true;
+	}
+	if (charge)
+		io_opaque_uncharge_quiet(store, charge);
+	if (any)
+		io_opaque_wake_budget_all(store);
+}
+
+struct io_opaque_data *io_opaque_data_alloc(void)
+{
+	struct io_opaque_data *data = kzalloc_obj(*data, GFP_KERNEL_ACCOUNT);
+
+	if (data) {
+		refcount_set(&data->refs, 1);
+		INIT_LIST_HEAD(&data->extents);
+	}
+	return data;
+}
+
+void io_opaque_data_put(struct io_opaque_store *store,
+			struct io_opaque_data *data)
+{
+	if (data && refcount_dec_and_test(&data->refs)) {
+		io_opaque_extents_free(store, &data->extents);
+		kvfree(data->bvec);
+		kfree(data);
+	}
+}
+
+/*
+ * Build the version's segments, and for a version of more than
+ * IO_OPAQUE_SEEK_STRIDE of them the anchors that find one without walking
+ * from the first, in one allocation. Both are made once, when the version is,
+ * and never change. The anchors follow the segments at the next multiple of
+ * eight bytes: a segment is 16 bytes, but only 12 on 32 bits, where an odd
+ * number of them would leave the anchors four-byte aligned.
+ */
+int io_opaque_vector(struct io_opaque_data *data)
+{
+	struct io_opaque_extent *extent;
+	struct io_opaque_backing *previous = NULL;
+	u32 nr = 0, anchors;
+	size_t bytes;
+	u64 at = 0;
+
+	data->charge = 0;
+	list_for_each_entry(extent, &data->extents, list) {
+		nr++;
+		if (extent->backing != previous)
+			data->charge += extent->backing->charge;
+		previous = extent->backing;
+	}
+	anchors = nr > IO_OPAQUE_SEEK_STRIDE ? DIV_ROUND_UP(nr, IO_OPAQUE_SEEK_STRIDE) : 0;
+	/* Where the anchors start. An overflow saturates, and the allocation fails. */
+	bytes = size_add(array_size(nr, sizeof(*data->bvec)), sizeof(*data->anchor) - 1);
+	bytes &= ~(sizeof(*data->anchor) - 1);
+	data->bvec = kvmalloc(size_add(bytes, array_size(anchors, sizeof(*data->anchor))),
+			      GFP_KERNEL_ACCOUNT);
+	if (!data->bvec)
+		return -ENOMEM;
+	data->anchor = anchors ? (void *)data->bvec + bytes : NULL;
+	data->nr = nr;
+	nr = 0;
+	list_for_each_entry(extent, &data->extents, list) {
+		if (anchors && !(nr % IO_OPAQUE_SEEK_STRIDE))
+			data->anchor[nr / IO_OPAQUE_SEEK_STRIDE] = at;
+		bvec_set_page(&data->bvec[nr++], extent->backing->page,
+			      extent->length, extent->offset);
+		at += extent->length;
+	}
+	return 0;
+}
+
+/* Handle encoding is internal; zero is never a published handle. */
+u64 io_opaque_handle(u32 index, u64 generation)
+{
+	return generation << IO_OPAQUE_INDEX_BITS | index;
+}
+
+static u32 io_opaque_index(u64 handle)
+{
+	return handle & IO_OPAQUE_INDEX_MASK;
+}
+
+struct io_opaque_slot *io_opaque_lookup(struct io_opaque_store *store,
+					u64 handle)
+{
+	u32 index = io_opaque_index(handle);
+
+	lockdep_assert_held(&store->tables);
+	if (!handle || index >= store->config.max_objects)
+		return NULL;
+	if (store->objects[index].generation != handle >> IO_OPAQUE_INDEX_BITS)
+		return NULL;
+	return &store->objects[index];
+}
-- 
2.34.1

