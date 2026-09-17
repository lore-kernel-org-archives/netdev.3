Received: from mail-ua2-f33.google.com (mail-ua2-f33.google.com [74.125.226.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19524E2F06
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649265; cv=none; b=l5h/Srfs/l8npfufivVFSWk2udVigvA0yLlJQMvfaAYHOVsCl5GAkNLLKZHP2uBOuBPrcRJrOwEiy8N4yLNg04DdRgGTTsFFj9IBzt7zHmkT3kD1ouA5r7Rp/CBpE33GvZBuhvPWm+p8T89toFyxogJxjEHPmTRXZ7tgMGpIoBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649265; c=relaxed/simple;
	bh=bMDV+aessESUwhQfKi3pWkJ1krvBva5WnJ3XGNN39fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bh15z9gFYAWfn30lkLCRh4PLkkbkrPvFWj2Oe6cWY2Wh747RRbah2xPN3jDdTCS9y7bgu3BSfDS8EtCoeNxooaDgvlyIFeuoWXFIxrpBfF2+o2To75pSokKH5hw/KbkZ4g6fBPLPxQlJd8+4R/oDIHKd1LvLmnDjnRxsW/1B+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=aV0xGYf9; arc=none smtp.client-ip=74.125.226.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="aV0xGYf9"
Received: by mail-ua2-f33.google.com with SMTP id a1e0cc1a2514c-982db8d3b79so196056241.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789649253; x=1790254053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZOKCPjVVxhJCScnWP1aWyJNWUyV//M5rxXE3nntZ5TA=;
        b=aV0xGYf9R/VXb3wHzMqzZPndZdCwZNaPulfk1ki1iavidZZYI3Lpd+4jyl0MQe6NPT
         NhDdO/Ff0HrsjENq0DIiuHGb9kagnWxGp4xrC/mydZ0+7SxbbQOF2nRI6r8dpd8Cw2Fe
         z2itLeXYFj8XKwDy22jAmP8Vwb3MSUuQY5ZPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789649253; x=1790254053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZOKCPjVVxhJCScnWP1aWyJNWUyV//M5rxXE3nntZ5TA=;
        b=Q0SiPILlrTySknvW8FALR4NJJ+90o4MpkUxIpc/vH6VQGjVYUHCkH3oljeHogCPOPc
         TQ/e4sjMA0TkcK7nWbXrbI0j76+g5PONUlL3B9C7NsYBMY6qJJgh8zVMDCTLgmt0Tazn
         JjUw5Bj3qgB6HYH/mMjZZIlNRXo1roLbq61EiTjMFaje5EtPmr3v17QHALGJvs+nHO0H
         shfrynSqo0kg0YM/2abDTQMpxHDIEaLYBIou7ssH0RHaBJ9tMvV2RB91w87moGaDTfAg
         lKALJqpY3SnLMrNsnebWgHv28TMB7KUCz1fJTp3FPvbrizDxvSFKqbr2jAmp6S26Ov/M
         pcSA==
X-Forwarded-Encrypted: i=1; AKwUvBzadGjjuFoF2xDaBtFPFcA09/QLv1MtRTjuL9FLFgsTGQwvcmzSHCR/kbNbcRwV72ORN+zOfBY=@vger.kernel.org
X-Gm-Message-State: AFuF++kGqCmDXRRNO1bJHkMRjftsEDlLbAc//QjUn3sDyCp0FpUMpiO7
	yEX1Qu1DexYNEsK8Y5k98KJdvx727jkceIgpFFvsX1fYR+NcXjAEIbjNtvwf6Majfw==
X-Gm-Gg: AYBFou2V+zvsiVpGbv3zLtWsnCLlwderx+DicLkpH4ZUgxCK96kCYTYdOtaianltO47
	1YRICHI2tmn5M//sMdiP9DjVhnfu9QYb94MQlL5xYfoR2gVXCYpk6507+E3k8uyLNZkLtcJxgkk
	9oPCbiXnuJ9UvN+OHaCJ0VwJyyYZVZQnst1azIlhvnrpfWu9GYG9QeSHPZ0lMoJjzo75murbkhv
	D5ycjjvLL82WnAaBW31ZxDEco+aNyq3m/63GiBzmNaUzPzRmxx9W4lE2tPFZtiDGkOdoSI6FzBE
	go4Mt13+EFdq7yYfoyOIip7cywj0ad/9QYK0NAb8PByJSKioLI0GIAfQ7L7sKC575Ad/zY8rhdZ
	uAXb7G9zhNsOJwTZDD1LVxsOVNh4rigEKDzP4mhL4/a2KcQyGoBDz2HeV38mtUfeINZz3I88Yfn
	EQo8X0BMLpCI0bFZDHoxf7g73+IgGXGAJSrTktpTk7P3Hfba43txxX7g==
X-Received: by 2002:a05:6102:5493:b0:789:5f54:2367 with SMTP id ada2fe7eead31-7a026088a71mr6392237137.4.1789649253137;
        Thu, 17 Sep 2026 05:47:33 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98323524dafsm2895358241.7.2026.09.17.05.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:47:32 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	vega@nebusec.ai,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] net/sched: Avoid quadratic handle scan in qdisc_alloc_handle
Date: Thu, 17 Sep 2026 09:47:25 -0300
Message-ID: <20260917124725.4127273-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qdisc_alloc_handle scans for a free auto-handle by probing the
per-device qdisc hash one handle at a time. With the 16-bucket hash
populated by tens of thousands of qdiscs, the failing scan is O(N^2)
under rtnl_lock. Each failing add holds RTNL for 0.6-0.9 s on a
production kernel and about 1.7 s with KASAN and lock debugging, and it
can be repeated back to back, stalling network administration in every
namespace.

First try the handle after the rotating cursor with one qdisc_lookup,
as the first iteration of the current loop does; that handle is
normally free. Only when it is taken, build a bitmap of the occupied
auto-handle majors in one pass over the hash and pick the first free
major from the cursor. The scan is cyclic over all 0x7FFF majors
starting from the same autohandle + 1 position as the current loop, so
it returns the same handle for the same device state and fails only
when all 0x7FFF majors are taken.

The root qdisc is seeded separately because qdisc_hash_add skips
parent == TC_H_ROOT.

When the next handle is free, only the single qdisc_lookup of the
current loop's first iteration runs; when it is taken, one O(N) walk
follows.

Measured as tc wall time on a defconfig kernel in a 2-vCPU guest, with
an HTB root holding 32768 classes and all 32767 auto-handles in use (a
no-op tc command takes 5-6.5 ms):

                                    unpatched     patched
  failing add, space exhausted      613-749 ms    8-10 ms
  add after a mid-range delete      572-573 ms    9 ms

The failure path returns -ENOMEM (bitmap allocation) or -ENOSPC (space
exhausted) through a handle out-parameter instead of the overloaded 0
return. Since either error is now possible, the extack message changes
from "Maximum number of qdisc handles was exceeded" to "Failed to
allocate a qdisc handle".

This is a less intrusive fix meant for backporting; a cleaner approach that
uses a per-device IDA over all qdisc handles is planned for net-next.

Conditions to recreate the bug:
  - unshare -Urn (Level 2, namespace-local CAP_NET_ADMIN)
  - classful qdisc (e.g. HTB) with many classes
  - attach ~32767 auto-handle child qdiscs to fill the handle space
  - the final tc qdisc add with no explicit handle scans the full space

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
v1 -> v2:
- Retarget from net to net-next - Jakub
- No code changes
v1: https://lore.kernel.org/netdev/20260911133146.3440982-1-victor@mojatatu.com
---
 net/sched/sch_api.c | 86 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 463ededcdcfe..f36c41224bcc 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -21,6 +21,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kmod.h>
+#include <linux/bitmap.h>
 #include <linux/list.h>
 #include <linux/hrtimer.h>
 #include <linux/slab.h>
@@ -770,22 +771,75 @@ void qdisc_class_hash_remove(struct Qdisc_class_hash *clhash,
 }
 EXPORT_SYMBOL(qdisc_class_hash_remove);
 
-/* Allocate an unique handle from space managed by kernel
- * Possible range is [8000-FFFF]:0000 (0x8000 values)
+#define QDISC_AUTO_HANDLE_BASE	0x8000	/* first auto-handle major */
+#define QDISC_AUTO_HANDLE_END	0xFFFE	/* last auto-handle major */
+#define QDISC_AUTO_HANDLE_COUNT	(QDISC_AUTO_HANDLE_END - \
+				 QDISC_AUTO_HANDLE_BASE + 1)
+
+/* Allocate a unique handle from space managed by kernel
+ * Possible range is [8000-FFFE]:0000 (0x7FFF values); 0xFFFF is the
+ * TC_H_ROOT/ingress major.
  */
-static u32 qdisc_alloc_handle(struct net_device *dev)
+static int qdisc_alloc_handle(struct net_device *dev, u32 *handlep)
 {
-	int i = 0x8000;
 	static u32 autohandle = TC_H_MAKE(0x80000000U, 0);
+	unsigned long start, bit;
+	unsigned long *bitmap;
+	struct Qdisc *q;
+	u32 handle, maj;
+	int b;
+
+	start = ((autohandle >> 16) - QDISC_AUTO_HANDLE_BASE + 1) %
+		QDISC_AUTO_HANDLE_COUNT;
+
+	/* The cursor moves past every handle it hands out, so the next
+	 * handle is normally free: try it with one hashed lookup before
+	 * walking the whole hash.
+	 */
+	handle = (start + QDISC_AUTO_HANDLE_BASE) << 16;
+	if (!qdisc_lookup(dev, handle)) {
+		autohandle = handle;
+		*handlep = handle;
+		return 0;
+	}
 
-	do {
-		autohandle += TC_H_MAKE(0x10000U, 0);
-		if (autohandle == TC_H_MAKE(TC_H_ROOT, 0))
-			autohandle = TC_H_MAKE(0x80000000U, 0);
-		if (!qdisc_lookup(dev, autohandle))
-			return autohandle;
-		cond_resched();
-	} while	(--i > 0);
+	bitmap = bitmap_zalloc(QDISC_AUTO_HANDLE_COUNT, GFP_KERNEL);
+	if (!bitmap)
+		return -ENOMEM;
+
+	/* Mark the occupied auto-handle majors: the hash holds all
+	 * qdiscs except root and ingress ones, and the root can carry
+	 * an auto-range handle.
+	 */
+	q = rtnl_dereference(dev->qdisc);
+	maj = TC_H_MAJ(q->handle) >> 16;
+	if (!(q->flags & TCQ_F_BUILTIN) && !TC_H_MIN(q->handle) &&
+	    maj >= QDISC_AUTO_HANDLE_BASE && maj <= QDISC_AUTO_HANDLE_END)
+		set_bit(maj - QDISC_AUTO_HANDLE_BASE, bitmap);
+
+	hash_for_each(dev->qdisc_hash, b, q, hash) {
+		maj = TC_H_MAJ(q->handle) >> 16;
+		if (maj >= QDISC_AUTO_HANDLE_BASE &&
+		    maj <= QDISC_AUTO_HANDLE_END && !TC_H_MIN(q->handle))
+			set_bit(maj - QDISC_AUTO_HANDLE_BASE, bitmap);
+	}
+
+	bit = find_next_zero_bit(bitmap, QDISC_AUTO_HANDLE_COUNT, start);
+	if (bit >= QDISC_AUTO_HANDLE_COUNT) {
+		bit = find_first_zero_bit(bitmap, start);
+		if (bit >= start)
+			bit = QDISC_AUTO_HANDLE_COUNT;
+	}
+
+	if (bit >= QDISC_AUTO_HANDLE_COUNT) {
+		bitmap_free(bitmap);
+		return -ENOSPC;
+	}
+
+	handle = (bit + QDISC_AUTO_HANDLE_BASE) << 16;
+	autohandle = handle;
+	bitmap_free(bitmap);
+	*handlep = handle;
 
 	return 0;
 }
@@ -1308,10 +1362,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		handle = TC_H_MAKE(TC_H_INGRESS, 0);
 	} else {
 		if (handle == 0) {
-			handle = qdisc_alloc_handle(dev);
-			if (handle == 0) {
-				NL_SET_ERR_MSG(extack, "Maximum number of qdisc handles was exceeded");
-				err = -ENOSPC;
+			err = qdisc_alloc_handle(dev, &handle);
+			if (err) {
+				NL_SET_ERR_MSG(extack,
+					       "Failed to allocate a qdisc handle");
 				goto err_out3;
 			}
 		}
-- 
2.55.0

