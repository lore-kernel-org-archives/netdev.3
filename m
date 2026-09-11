Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C0126F2BF
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133518; cv=none; b=hucetVn9SkxKUjdIEmZphGn9UX4qtEZYUFU4Ls2LZEk0VsBmCJhoEvBtc/q2xr5hx8ygQwVwJTBPg3X/8MGE7WkSdRG8A0MjgQ4NXzL6K2H2ESoGDG227vSfuwIAVNNol7HODMXvExBX6Gb6POXThY5G8UR0aNb1mNSwAILIVAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133518; c=relaxed/simple;
	bh=Iw/79JhCPU696fOSb+CT/YJY+fJdSUVfHZeq1bbglYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9/BOs16huWa/vFXjrvDkwylpfyQ5up2YM3aiRmQAWrAdcNSJpYaQPdZNXe+BIOYi5N9bsCy3Eh1oMc1+wetFXYHo2C5xVCbs7aU0m4jxIgG5Pnj9RBmZIBNWQDHMeJY8RWxVsWsCInCMBU6pAtda0Gy0eCdefpuDoPuuxrdb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=yi9eXP2g; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="yi9eXP2g"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-783fffcfb96so672443137.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 06:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789133515; x=1789738315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WJ5QGp/RHasx0Pt6CqWQMH+rjLbyG9qkRjIB/n6UBZU=;
        b=yi9eXP2gGBf4+NMY8eJGDjK7uDiTe4gOICCTJRmgsyQqYxjmerz11L69Ybsgq7jTLK
         I5hjmGCz9a0O1Sd6YDg0uAkCtiYXwNB1/jAT5gIFH8f62tuv/AmZKVKDr+sJMU653k9d
         CBA7bUHgL16EvmFfgEiqKOuRMZ7PMYmEVfJCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789133515; x=1789738315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WJ5QGp/RHasx0Pt6CqWQMH+rjLbyG9qkRjIB/n6UBZU=;
        b=ieRJi38jhxO8FfhP7Dtin1k53ZjQ2YccQS8Vs9/5BqyGw2F3TWJdkXMC7ORjccF0Dl
         7PiMjlZG4RwR71xP0DCpMHqaFwIZvc5MpNccSQhy4N+3IuS/EusVhgo1z7HERVjg25l1
         FIuCSwnMB+4M7XXNfpMk6vsyBhmPoAGC3zC2CEK105xMAqiBoN3/EpwomeMSU33w4BBb
         Y75mJ5sgVP/b9vHWgOsdgT0xKiH3WGtipUzRiHSNSgx5AJ716z9baqkg1o7VGirRJAo2
         cBKHsC1JlLO34ISa6MVnbAkUe2jI+CTweZkKfIE5TH+eel/xASzDZOX0kPmURclWVyHU
         +IRg==
X-Forwarded-Encrypted: i=1; AKwUvBzBtvuKiBAp6gbh7AdliFTIQhpRsdzlXJhBYAImeXB296X6PIQyrke0kPoNSbNymYorFa7jLZ8=@vger.kernel.org
X-Gm-Message-State: AFuF++k+mLAmW6PLGmtSFleYt3avd/MDV2rTj6f3owvTRDA/8qg58nLU
	m8lOPwLJBzFJ19YbMAquJoWMcT/Dgjk9SfCzZERKPEiC1dyuPHVlSUpW0F7g/ZAwLQ==
X-Gm-Gg: AYBFou09HNuEn8Nz9Tjqn2EXYGgzo0z0F/gL+5A2QfyvvW9oEkE18g3VcDbZfrIS7tp
	WIefozgLJiOlj/ITD9SCLBLJZijvqVmaqYU4hR4goCFsZv+rsyQIF8TAlmEh26t9mRuTmm7acWk
	lj94HzG5lWbh/2686idkGIWl0C8w806Yfgj9bpxHiNFcIgJOIXXchBL/oLwhrKoME2e6A6v9G9h
	3dhO3QtKT9LGYZrcD3+xDSRY//l8M9OhgtRAxtvknXjO06WcZNTsQDBpDNoZ4F436KZt6o4mJwk
	lYk48zxpGTYhRNURgDrXbf1AUzC1UmWRfd0mPc1sui3h18GDlfWYM1s9duFu1fWmq9ebifdoAM5
	KmjKt+elLNT3LZFV7sytEiO3NAdDhYr3c60i+rc58TZIN/bv/f/L/wKKTbvMCW7GRG6s2OEjFYQ
	n+eo0L91CHwMr8Zz/mPd2uugLXQdPvNlocDxFOhbkRiNs7arRdN/6Org==
X-Received: by 2002:a05:6102:5493:b0:784:b9ec:9144 with SMTP id ada2fe7eead31-792abb23c2cmr3909872137.8.1789133514650;
        Fri, 11 Sep 2026 06:31:54 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7927ccd35edsm2367957137.5.2026.09.11.06.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 06:31:53 -0700 (PDT)
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
Subject: [PATCH net] net/sched: Avoid quadratic handle scan in qdisc_alloc_handle
Date: Fri, 11 Sep 2026 10:31:46 -0300
Message-ID: <20260911133146.3440982-1-victor@mojatatu.com>
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
Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
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

