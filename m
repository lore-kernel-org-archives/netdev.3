Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BB34AB03
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535362; cv=none; b=MfhtIQeHWRK/wbCPAko1f92nXZtYEE0z+b1pqZJobm7XVg3VJqCDenGGmJZCoRxOB19QNxIHlFPwIR+a13A/A7CTrcN+5Fb1k8V/OclFfQIavVi8hhzdSleU/8AuFBLZWHNpVEdGex95vj1E1hT+cUWzYHXEXIpVJXBp3kznv7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535362; c=relaxed/simple;
	bh=NwvisoGKc/wOBgvMGFlq4i0Z1hpIzUHHX1thQgmCedo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PfK77wKofBa+pYXMhYjT1vy4k3yKu3lZWqdaYfdh/Bsw8mmAdG5OCev7b5psf1s6K+Ki69x3uslCX+bsa09yB8L5GgSu6HFKinVa2tNy0CnJ1Q9s/iL8qYnAjmdn569P1Eo2R6xHjz/ijVBuBYnRDlIZ4+UmgUSfZoN4Aut5Vi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvXqnS8A; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvXqnS8A"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8486ac3f347so2816323b3a.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 01:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784535360; x=1785140160; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cbgTA/Fdi35MAcDt+VL5REq8VSaccpXMdCOmLmcj2D0=;
        b=kvXqnS8Ad0VlNjFwWjrxD2EOFBOQi4go/jSe7BNwS3ncgU0y3DXClloVFBGk1nAiVx
         vEx6mww+srWBOcrFyvKtuFlYzitmZxHbO7j0Se0nF0ufZLYT6X7V9Cs0rTzn3zInEF2p
         iU735EWletXqxlMK0eXZrZQna6hJO8qOPpVIk7ABw3lUpWHRZ/eHdLbK6oyjmFM4LnAd
         08YTZV78s4p/+URx243ZVA7+Q0xZSk/LcB/faahhWe2+Pp5YHqmSJRIwb+ofil6ARg0P
         ndNTqs+7ckJj0pSu9dmK5MAPojWXMqLJucM6mmUTTqQ4c68iNHyIa1riUNlrd9uUc227
         +onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784535360; x=1785140160;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cbgTA/Fdi35MAcDt+VL5REq8VSaccpXMdCOmLmcj2D0=;
        b=YYd1eX9uh3gBOcHxwRKAhOqpE6bcgQs/K+DVYwN0M5jDxFKnScBMEuMZ8JteFEobiS
         XJLzSoICSAhh+7HfgMPZiBKNbbkgP4xya7CZN4Qz8tK+1K8bwoqqX/F+MYPGzHTfJMA1
         PpzGLxyBpnl0YsjvrEpHCQ3i9FII7akWuyo00hyEDXMc2WmIs2N4C8+oyJuvSEhxDBsE
         pTwQ9LM/4NU9F12BDloxfkNxZrUJGFN+zKmc/SFbFo26Tanq5dq/WB5HdA0pBiNPVd3R
         eyewVJVCYT5M9rOFO6nlIa0Zb81EMfgDc59BCoQ457P+j6B6UVcWTb8yH8AWKbNwL9WA
         x/Tw==
X-Gm-Message-State: AOJu0YxNH3KQHkQ0KXa9NlfnBtRJZS6TI4peUbaX/pZVwrjks8ZonFhi
	M597+3lGIVWg+CWrza8mHFOjnGKpcz8mul1tvEFtznf9iXiZ7qLQHi5a8Xx8APl52HY=
X-Gm-Gg: AfdE7ckZbUhymsvUUkJ+cP0lysvXDOYTgGaF0wfn+ngGBfHTj+cSapcJC8h4cvczFlc
	wL6ITS1iGRrzdeKpsXsSHtJSEheZ+ysHtx2BQw3qVYT/qlTtd/WS93VGf9pR7uc6lgrhMP22zbP
	13BPdHUCwzc/1iD9oBFItUDVqU55IBx1d8nm09+CtsHjWlnG/Qfcmqmdrac6+X8FaMf3wd6v+IP
	hFwjyzGlrJzTnWrJBZf14H5ou1TWJK6qHlFXu4rHG39rZEEBHzWiROkn0MybBBIn4pD5+yMNHQz
	bmCgAxwqgO7zl/3ubScCARfefEnhXzrnjV/7UhSZjtz5fTCcPTCwPdB4g+RPyELSRIuTGMwFMAN
	e/l4Ak29QnKRtjv5Nu8OfRhMdJt4ykJP2avI2aSq0uijJTy0m46OkJRE/OqsB1eEbffOcfdhNa5
	M=
X-Received: by 2002:a05:6a20:918a:b0:3b4:b259:74e3 with SMTP id adf61e73a8af0-3c38dbc0b74mr19255850637.31.1784535360103;
        Mon, 20 Jul 2026 01:16:00 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fe1014sm33656404eec.7.2026.07.20.01.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:15:59 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 20 Jul 2026 16:15:48 +0800
Subject: [PATCH v11] mm/page_alloc: boost watermarks on atomic allocation
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-feat-mm-page_alloc-v11-v11-1-7376b02c27b3@gmail.com>
X-B4-Tracking: v=1; b=H4sIADTZXWoC/x2MSQqAMAwAvyI5G2iKC/gVEYmaasCNVoog/t3ic
 QZmHgjiVQI02QNeogY99gREeQbjwvssqFMSYI2tTG0NOuELtw1PnqXndT1GjERYuoLKiQuWwUC
 KTy9O7//cdu/7AcHMrXZpAAAA
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Lance Yang <lance.yang@linux.dev>, SeongJae Park <sj@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>, 
 Jing Wu <realwujing@gmail.com>
X-Mailer: b4 0.13.0

Atomic allocations (GFP_ATOMIC) are prone to failure under heavy memory
pressure as they cannot enter direct reclaim.

Handle these failures by introducing a watermark boost mechanism for
atomic requests. Refactor boost_watermark() using an internal helper to
support both fragmentation and atomic paths. Apply zone-proportional
boosts (~0.1% of managed pages) for atomic allocations, while
decoupling it from watermark_boost_factor.

Implement boost_zones_for_atomic() to iterate through and boost all
eligible zones in the zonelist, respecting nodemasks. Use a per-zone
1-second debounce timer via last_boost_jiffies to prevent excessive
boosting. Check and update the debounce timestamp under zone->lock,
alongside the watermark modification, so concurrent callers on other
CPUs cannot all observe a stale timestamp and pile onto the same zone
within the same window. Verify with lockdep. Integrate the mechanism
into the page allocation slowpath specifically for order-0 GFP_ATOMIC
requests.

This approach reuses existing infrastructure and ensures emergency
reserves even if fragmentation boosting is disabled.

The mechanism is bounded by construction. Each zone accepts at most
one boost per second (the debounce timer), and zone->watermark_boost
is clamped to zone->_watermark[WMARK_HIGH] / 10 regardless of how
long the atomic pressure lasts or how many zones are boosted in a
single slowpath call. Worst case, sustained atomic pressure across
all zones in a zonelist adds at most one extra kswapd wakeup per zone
per second, and the boost on any single zone cannot exceed 10% of
that zone's high watermark. It cannot run away or starve unrelated
allocations beyond that ceiling.

This failure signature keeps recurring in production: a host running
a downstream 4.19 kernel logged 144 order-0 GFP_ATOMIC failures over a
4h15m window, all through the same NIC driver receive softirq path,
across several unrelated network-facing services on the box. This
confirms the underlying problem is real and ongoing. It does not by
itself measure this patch's effect, since the fix has not been
deployed on that fleet yet.

Allocation failure logs:
[38535644.718700] node 0: slabs: 1031, objs: 43328, free: 0
[38535644.725059] node 1: slabs: 339, objs: 17616, free: 317
[38535645.428345] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535645.436888] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535645.447664] node 0: slabs: 940, objs: 40864, free: 144
[38535645.454026] node 1: slabs: 322, objs: 19168, free: 383
[38535645.556122] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535645.564576] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535649.655523] warn_alloc: 59 callbacks suppressed
[38535649.655527] swapper/100: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
[38535649.671692] swapper/100 cpuset=/ mems_allowed=0-1

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Jing Wu <realwujing@gmail.com>
Acked-by: SeongJae Park <sj@kernel.org>
---
V10 -> V11:
- Fix a debounce race: last_boost_jiffies was checked and updated
  outside zone->lock, so concurrent CPUs handling a multi-queue NIC
  RX storm could all pass the once-per-second check for the same
  zone before either updated the timestamp. Move the check-and-set
  under zone->lock alongside the watermark update.
- Add production evidence of the failure signature recurring (see
  commit message) in response to Vlastimil's repeated request (v2,
  v6, v10) for real-world data on whether this problem is real and
  whether the fix helps.
- Drop Vlastimil's Acked-by: he took it back in review of v10,
  noting the v10 changes were not trivial. Not resending solely to
  drop the tag, per his request; folding it into this update instead.
- Cc netdev and add Matthew Wilcox, per Andrew Morton's (v1, v5) and
  Wilcox's (v1) requests to involve the networking maintainers, which
  never actually happened in v1-v10.

V9 -> V10:
- Refactor watermark boosting into mechanism (__boost_watermark) and
  policy logic.
- Decouple Atomic boost from watermark_boost_factor to ensure
  emergency reserves.
- Simplify Atomic boost calculation to ~0.1% of managed pages with a
  10% high-WM cap.
- Boost all eligible zones in the zonelist while respecting
  nodemasks.

V8 -> V9:
- Use mult_frac() for boost calculation. (SJ)
- Add !can_direct_reclaim check. (Vlastimil)
- Code cleanup: naming, scope, and line limits. (SJ)
- Update tags: Add Vlastimil's Acked-by.

V7 -> V8:
- Use spin_lock_irqsave() to prevent inconsistent lock state
  (softirq-on vs in-softirq) as reported by LKP.

V6 -> V7:
- Use local variable for boost_amount to improve code readability.
- Add zone->lock protection in boost_zones_for_atomic().
- Add lockdep assertion in boost_watermark() to prevent locking
  mistakes.
- Remove redundant boost call at fail label due to 1-second
  debounce.

V5 -> V6:
- Replace magic number ">> 10" with ATOMIC_BOOST_SCALE_SHIFT define.
- Add documentation explaining 0.1% zone size boost rationale.

V4 -> V5:
- Simplify to use native boost_watermark() instead of custom logic.

V3 -> V4:
- Add watermark_scale_boost and gradual decay via balance_pgdat.

V2 -> V3:
- Move debounce timer to per-zone to avoid cross-node interference.
- Optimize candidate zone selection to reduce global reclaim
  pressure.

V1 -> V2:
- Add basic debounce logic and scale boosting strength based on zone
  size.

v10: https://lore.kernel.org/r/20260214-wujing-mm-page_alloc-v8-v10-1-bdfea431fd97@gmail.com
v9: https://lore.kernel.org/r/20260213-wujing-mm-page_alloc-v8-v9-1-cd99f3a6cb70@gmail.com
v8: https://lore.kernel.org/r/20260212-wujing-mm-page_alloc-v8-v8-1-daba38990cd3@gmail.com
v7: https://lore.kernel.org/all/20260123064231.250767-1-realwujing@gmail.com/
v5: https://lore.kernel.org/all/20260121065740.35616-1-realwujing@gmail.com/
v4: https://lore.kernel.org/all/tencent_D23BFCB69EA088C55AFAF89F926036743E0A@qq.com/
v3: https://lore.kernel.org/all/tencent_44B556221480D8371FBC534ACCF3CE2C8707@qq.com/
v2: https://lore.kernel.org/all/tencent_6FE67BA7BE8376AB038A71ACAD4FF8A90006@qq.com/
v1: https://lore.kernel.org/all/tencent_9DB6637676D639B4B7AEA09CC6A6F9E49D0A@qq.com/
---
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 80 ++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 75ef7c9f9307f..8e37e4e6765b5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -882,6 +882,7 @@ struct zone {
 	/* zone watermarks, access with *_wmark_pages(zone) macros */
 	unsigned long _watermark[NR_WMARK];
 	unsigned long watermark_boost;
+	unsigned long last_boost_jiffies;
 
 	unsigned long nr_reserved_highatomic;
 	unsigned long nr_free_highatomic;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c380f063e8b7b..4517e2c1310ee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2158,12 +2158,15 @@ bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struct page *pag
 
 #endif /* CONFIG_MEMORY_ISOLATION */
 
-static inline bool boost_watermark(struct zone *zone)
+/*
+ * Helper for boosting watermarks. Called with zone->lock held.
+ * Use max_boost to limit the boost to a percentage of the high watermark.
+ */
+static inline bool __boost_watermark(struct zone *zone, unsigned long amount,
+				     unsigned long max_boost)
 {
-	unsigned long max_boost;
+	lockdep_assert_held(&zone->lock);
 
-	if (!watermark_boost_factor)
-		return false;
 	/*
 	 * Don't bother in zones that are unlikely to produce results.
 	 * On small machines, including kdump capture kernels running
@@ -2173,9 +2176,6 @@ static inline bool boost_watermark(struct zone *zone)
 	if ((pageblock_nr_pages * 4) > zone_managed_pages(zone))
 		return false;
 
-	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
-			watermark_boost_factor, 10000);
-
 	/*
 	 * high watermark may be uninitialised if fragmentation occurs
 	 * very early in boot so do not boost. We do not fall
@@ -2189,12 +2189,70 @@ static inline bool boost_watermark(struct zone *zone)
 
 	max_boost = max(pageblock_nr_pages, max_boost);
 
-	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
-		max_boost);
+	zone->watermark_boost = min(zone->watermark_boost + amount,
+				    max_boost);
 
 	return true;
 }
 
+/*
+ * Boost watermarks to increase reclaim pressure when fragmentation occurs
+ * and we fall back to other migratetypes.
+ */
+static inline bool boost_watermark(struct zone *zone)
+{
+	if (!watermark_boost_factor)
+		return false;
+
+	return __boost_watermark(zone, pageblock_nr_pages,
+			mult_frac(zone->_watermark[WMARK_HIGH],
+				  watermark_boost_factor, 10000));
+}
+
+/*
+ * Boost watermarks by ~0.1% of zone size on atomic allocation pressure.
+ * This provides zone-proportional safety buffers: ~1MB per 1GB of zone
+ * size. Max boost ceiling is fixed at ~10% of high watermark.
+ *
+ * This emergency reserve is independent of watermark_boost_factor.
+ */
+static inline bool boost_watermark_atomic(struct zone *zone)
+{
+	return __boost_watermark(zone,
+			max(pageblock_nr_pages, zone_managed_pages(zone) / 1000),
+			zone->_watermark[WMARK_HIGH] / 10);
+}
+
+static void boost_zones_for_atomic(struct alloc_context *ac, gfp_t gfp_mask)
+{
+	struct zoneref *z;
+	struct zone *zone;
+	unsigned long now = jiffies;
+
+	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
+					ac->highest_zoneidx, ac->nodemask) {
+		unsigned long flags;
+		bool should_wake = false;
+
+		/*
+		 * Check and update the per-zone debounce timestamp under
+		 * zone->lock so concurrent callers on other CPUs (e.g. a
+		 * multi-queue NIC spreading GFP_ATOMIC allocations across
+		 * several softirqs) cannot all observe a stale timestamp
+		 * and pile onto the same zone within the same window.
+		 */
+		spin_lock_irqsave(&zone->lock, flags);
+		if (time_after(now, zone->last_boost_jiffies + HZ)) {
+			zone->last_boost_jiffies = now;
+			should_wake = boost_watermark_atomic(zone);
+		}
+		spin_unlock_irqrestore(&zone->lock, flags);
+
+		if (should_wake)
+			wakeup_kswapd(zone, gfp_mask, 0, ac->highest_zoneidx);
+	}
+}
+
 /*
  * When we are falling back to another migratetype during allocation, should we
  * try to claim an entire block to satisfy further allocations, instead of
@@ -4742,6 +4800,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (page)
 		goto got_pg;
 
+	/* Boost watermarks for atomic requests entering slowpath */
+	if (((gfp_mask & GFP_ATOMIC) == GFP_ATOMIC) && order == 0 && !can_direct_reclaim)
+		boost_zones_for_atomic(ac, gfp_mask);
+
 	/*
 	 * For costly allocations, try direct compaction first, as it's likely
 	 * that we have enough base pages and don't need to reclaim. For non-

---
base-commit: b54345928fa1dbde534e32ecaa138678fd5d2135
change-id: 20260720-feat-mm-page_alloc-v11-5f415da4aeb0

Best regards,
-- 
Jing Wu <realwujing@gmail.com>

