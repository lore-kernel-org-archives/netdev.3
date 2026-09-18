Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4400E36F901
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739528; cv=none; b=IT2jJ646lkTcSZMiZ5hIQ0UPL6SVfh7qLr3XG5lgMh0qYFX9RvltGfc4uC/o6qQPc6qmwDV+ONliFHOMYX2BMML5bjoJ79hXSc1Jkg6DZFAp/P2rRpJFvqB9n9zMeptORaGjGToV89TaYOsK9cNQ7XYuYlP2Lg9v3xfmvFAupkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739528; c=relaxed/simple;
	bh=BPtztj0cdpC4TtHy/SOA1EDXs/HnrFUzeKNfaIXOYsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+H2htoEexxqZ9HPPR42Hpj721dzJzcO1OEu2tyy/e3oE7s2UCmXux3OONo1ZMONPUJvEwTYmGsWV7pdOLZjD6pt4Hy8N6YiOL4H9EoYQaKY6zKA6+/ip4931OdFkNP1I9mz/+Z/2sG/lzFRnmUnhtY8EmsWD0i+IekIcgLHO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=IuCHRoa+; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="IuCHRoa+"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c67e5292faso271408e0c.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789739525; x=1790344325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P6pLfyiBs8ZAHmlcAD0q7z7Fzb6hUAn6VDnCimQKrtw=;
        b=IuCHRoa+9YBO5ABR5+2+VxQUJ77qB234vcc5bzk+u7h6KxCKn1QUhIJ7u8yk4wGEiL
         JZnd32vJh5E6OIX5I5WRJwqa0svyAo8CAONOReUMDi7fdBhIKSxDP0kiWKW2wY1YTqj6
         JAJbFtnGSsz0gEiiY1OrusKG8nzIVC9JRB+9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789739525; x=1790344325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6pLfyiBs8ZAHmlcAD0q7z7Fzb6hUAn6VDnCimQKrtw=;
        b=LMMQ6nGzvUoahunEXXsdE5sr6nrdd4sKmQlIUcz9aoU5RxygLbXg/HrtgXH8pcI5NH
         YaTzl+5tBBepcoMdJZ3V/glcYNrWvK9jEk08SU2TnRUvhM3oTSweEtySiLZwNu0Oe6WY
         ijOSx24An+RAAn6uViOw0gnk14+30Vb6X8THAje4QfUK7C8J+D5Fzl468C5icrrB+s7t
         YrpVifdFzNyhilwJkWrfcHk6hkzMV5ONSwNGF+b5WEjpDzptTuvc0qfU24Fsh6xdLj2V
         JxOI9sgvJIAJKEY3psnVo5ZVoZhVF64wwNCBdhQAqWrGN01LYnuk3UFRjvK/Omcn4wVn
         a1xQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjkcdEyD3ljI1x/TbK2CUqBz9FnnoBkJQyqqNltwjzeTPINEOoUkTfB0hLl7uu6knuHV9yZuo=@vger.kernel.org
X-Gm-Message-State: AFuF++mZbj+A0ccFqt54GkQiRdBj7yO7PIfYEzycnKmppStjjr0DrZ9G
	QIFJ8P9MlZMwZZMcrAZ9TImBqmNMKKouMr98Esmw+06yb4GN/ZNmDt2voiQ13HqyjQ==
X-Gm-Gg: AYBFou0yLjQN5A0F4TFS4k7E+xBHexLzWF+SZ41KIXGIZ6VOkwMSYUgjV9nCCHI2SNB
	aPIQMsFiVFnE9qaLVduWUJV5UYwIrskGTYrs/z/O2G9g2Jtm9hHa3zyA4dIBerKWXp4La0QHoy6
	b5pt7SNEBFB9by5GiIUm7TxAcAx2aGq5Rw1zF10iI7I37j28J9IXQUVGKM6FWrcoKzXUD54UwB3
	pmAUYQ31nMz/Amxz5gT5uZeky+8zjEYcoKkQz7xMKDOMhWmUqZYEzQg6KCrntETSKfyHzCbE7gv
	8OfIGuOPjl4065H908cR3TdblVAu2s+EjQpVhxryzKbz4pppdJ8gg6uG4rdo1/esDU3Va81E8je
	6RGG7wneMD9oImFlMv+PYFv9gDMX7y0ihILZLcmiBwcl9zmX2nQkNGVSeEH2oJqGnlyRuvvRq6c
	503sL2dFbraP/CbIBVW3NWKFaY+odUFARa6j/ct+sgdU2NgfZxfuolzg8=
X-Received: by 2002:a05:6122:e230:b0:5bd:b2e1:e1f5 with SMTP id 71dfb90a1353d-5c9b58fd54cmr853927e0c.2.1789739524595;
        Fri, 18 Sep 2026 06:52:04 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98337df9ae3sm1617686241.9.2026.09.18.06.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:52:03 -0700 (PDT)
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
Subject: [PATCH net-next v3] net/sched: Avoid quadratic handle scan in qdisc_alloc_handle
Date: Fri, 18 Sep 2026 10:51:57 -0300
Message-ID: <20260918135157.163015-1-victor@mojatatu.com>
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
under rtnl_lock. A single failing add then holds rtnl_lock for most of a
second, and rtnl_lock is global, so all other netlink configuration is
blocked for that time.

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

Reported-by: Vega <vega@nebusec.ai>
Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2 -> v3:
- Removed fixes tag
v2: https://lore.kernel.org/netdev/20260917124725.4127273-1-victor@mojatatu.com

v1 -> v2:
- Retarget from net to net-next - Jakub
- No code changes
v1: https://lore.kernel.org/netdev/20260911133146.3440982-1-victor@mojatatu.com
---
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

