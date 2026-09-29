Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D25448AA
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695512; cv=none; b=G2ncjR2lnLo0g8Duwy775vISAnhKvj29ANLzqrO/TefF7Sc8mmxKtLeVkWdVLmBWeeGDhczZ5ayCKNmwOevrT2VooghMd557l8P912dffN+muGJbXAVmMLTasd+2jWnI+F3Sajm0Wgw6gcdK27YaNL63ccyZioRC3xlUK1cYHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695512; c=relaxed/simple;
	bh=rMYV4MJQPjqIONFY6sAmuplTJiX72QqIAgPSaAKfacM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbERfgkqQXNOhTCK4DtS8fSIb031opzOGIQ6dxT/NyPk9bifU3ZC1euxTZQ65kRbzB97PsCnQTNIFf7togfd80khDhbCvoPYlNTbvI2Kr7lephcFVUPD4ayLoYElD+j/PTS3cEHEdarytFJ4TL79pqfs/uLz59MGsNW9N8Sifrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmP5zWV5; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmP5zWV5"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2e2a68e185cso15015635ad.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695493; x=1791300293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RoaKi5XCa2I68GF1aVkzZj7HfbAYluk0X3vR4zMEZl8=;
        b=GmP5zWV5Kf0B4lORcgq0LuQqB8WQ2+73Ye7jhdTe1dppNydW2GKuC9PVvDgiCU2Lmn
         R6rTk+aXdUN+6WC5m5SMeayP5pB4l5R0ziuPFHwKiDsNLxmadLtQtuhrrY4hztVLa0cI
         Gr+xlvWiNO1pdB9ygxl/1rt+KXhmzwa8P62cKP7qg+/EDJ1xUS4SkWJVcw7iX+zp7jte
         l4jbX7UXVnqNmMRBEpioKyxKBVphh9oBrMZ17/v/mZl8EXRHAEHlQfbe86UYorJINOjD
         CBxZLO45JGeHst80+t7fgteiykynnpUU23NQPIQ30y3bD50n/GWf0wqAbblLYNcQu1V1
         gYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695493; x=1791300293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RoaKi5XCa2I68GF1aVkzZj7HfbAYluk0X3vR4zMEZl8=;
        b=v5EL69/DCSTyPLOrSZa8h0cp+QFygqaEa/U7gog0owticmP8o7jQ9mqx8/D9/qIIow
         IXcZIxxgUjlTuyLyPog54aZNXy8swLFavjiE+M+daOE2bT8gUklHP4r+hEuGrCNhEZ2o
         sUPDSpDAjFZ5lJYb9l11hK79NyAO/CTzEsOPz6aPVm7ea+fut8oVWqxrFIlH0MJ/V8dc
         ouaaEWUE2duN/XmaZSKnO+9/EeKGzHZhkvUFsHggNvc+8xTWa4FHD7zjZtLNCdoZHuzO
         3wgBaz8N+okbwX/veBbQ8+vgo+6JFk6pHNsOcANRM8ays5GkUhfSONcgbvMUeQDTsOvS
         PsUw==
X-Forwarded-Encrypted: i=1; AKwUvBwHtWxaNqz+j5gJjdVOO4oc8PPmbwcN49C3Pbl0GD09LsfAidzwoPFHUVSHUJQmnSKpXFiEtzw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTjhrsxltPv8gat0WHA5WDMpXaot/NfHikZ6GW6earinCwSw+/
	TM+aItSJ8QH9ewXOWK2ZS/BkiJefxA+iY7YvmaSA9+H9Q5aZB16qRmDP
X-Gm-Gg: AYBFou0saawBFQDZQvXJzw3/6vOwF7dFw2P9Cp479aUKkZp4tRfS3Flf9hwZsbZq03E
	v4Ea90jnxkNDr5eBew/nJpeUiZDpXTmKXh4MHrU78F87gf9PAJT2PC9dgPeVJmiCkBM1C+BMB9p
	IHHl4jLVJQ3RrHrBx6nr2Zs27cEujWB7EcnUr3C/iA+ridcD6Fy/3MJ7yrxswujXQDgjOYPqpRQ
	QI92dkzFteao0ev3lHLyOPq95ZR9ySuuHynb0yoeuMmXHps//2RAGYq0v5XM97Y6pnYaWudLUwk
	R/vRH4E8+/7mjXmS7vL6J4i6UxSdOD6xuPHQZjyy4ynwObhWRsMvqzG0kLEKMY8U/ByxkItsDwl
	COsUJq9IoawFmAU0AFJmQXNmeBMd1aZ3KPe0W7UR3saczQG7pRh40XQXVZNphcfC/qYUoiJk8P9
	xAdodRH1Lcq951Tqq+0rb9JGr4H7HNI3mMMCUMHaY3N3O9kfNcyqEBuwTVOu2pX9PpGCf+IQx+m
	LqmhHc4AnXDPpE2Iha6S6ZLBoRNcbwZ+73/G5tcwZgA8GMgQlFTSLnzH9/FCxW/Seepn2YVXVMd
	uJa8sU4ng8ZcTNdkTmh6dYqdH4MhLEk=
X-Received: by 2002:a17:903:94c:b0:2df:a4d8:579c with SMTP id d9443c01a7336-2dfa4d85ab1mr84179815ad.17.1790695493317;
        Tue, 29 Sep 2026 08:24:53 -0700 (PDT)
Received: from NV-9MNJ414.tailae2068.ts.net (2001-b011-2005-5b75-0412-f652-3152-53f1.dynamic-ip6.hinet.net. [2001:b011:2005:5b75:412:f652:3152:53f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91476bb4sm59762255ad.83.2026.09.29.08.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:24:52 -0700 (PDT)
From: Yiwei Lin <s921975628@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH v2 2/4] rbtree: declare augmented callbacks per field with RB_AUG()
Date: Tue, 29 Sep 2026 23:24:37 +0800
Message-Id: <20260929152439.91443-3-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929152439.91443-1-s921975628@gmail.com>
References: <20260929152439.91443-1-s921975628@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

RB_DECLARE_CALLBACKS_MULTI() asks its user for a function that copies
the augmented fields and one that recomputes them from the children,
with the early-exit protocol of ->propagate() hand-coded in the latter.
sched/eevdf, its only user, needs five helpers for three fields.

Describe each augmented field instead: RB_AUG(val, aug, fold) names the
per-node value, the member holding the subtree aggregate and how two
aggregates combine (min, max, a sum, ...).  RB_AUG_FUNC() takes a
function for the per-node value.  The template then generates, per
field, a recompute that works on a local and stores once, and a copy,
and combines them into the callbacks; the early exit is the AND of the
per-field results.

RB_DECLARE_CALLBACKS() is the only template left.
RB_DECLARE_CALLBACKS_MAX() becomes RB_AUG_FUNC(RBVALUE, RBAUGMENTED,
max) in a wrapper, with its RBCOMPUTE argument renamed to RBVALUE,
since it returns the per-node scalar and is a different thing from the
RBCOMPUTE of the generic template it used to build on.
RB_DECLARE_CALLBACKS_MULTI() goes away.

sched/eevdf shrinks to a wrapping-safe min() for min_vruntime and
three RB_AUG() lines.  net/tipc's service range tree uses RB_AUG()
directly.

No functional change intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20260928213736.GA2947991@noisy.programming.kicks-ass.net
[yiwei: take a fold(a, b) instead of a "replace?" compare so that sums
 and counts can be expressed too, which also lets min()/max() replace
 RB_MIN()/RB_MAX(); wrapped the lines over 100 columns]
Signed-off-by: Yiwei Lin <s921975628@gmail.com>
Assisted-by: LLM
---
 include/linux/rbtree_augmented.h | 165 ++++++++++++++++++++-----------
 kernel/sched/fair.c              |  70 ++-----------
 net/tipc/name_table.c            |   7 +-
 3 files changed, 120 insertions(+), 122 deletions(-)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index d2fa1c41bfd2b..eac1d4edb9775 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -15,6 +15,8 @@
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
 #include <linux/rcupdate.h>
+#include <linux/args.h>
+#include <linux/minmax.h>
 
 /*
  * Please note - only struct rb_augment_callbacks and the prototypes for
@@ -86,6 +88,86 @@ rb_add_augmented_cached(struct rb_node *node, struct rb_root_cached *tree,
 	return leftmost ? node : NULL;
 }
 
+#define RB_FOR_EACH_1(what, RBNAME, RBSTRUCT, RBFIELD, x)	\
+	what(1, RBNAME, RBSTRUCT, RBFIELD, x)
+#define RB_FOR_EACH_2(what, RBNAME, RBSTRUCT, RBFIELD, x, ...)	\
+	what(2, RBNAME, RBSTRUCT, RBFIELD, x)				\
+	RB_FOR_EACH_1(what, RBNAME, RBSTRUCT, RBFIELD, __VA_ARGS__)
+#define RB_FOR_EACH_3(what, RBNAME, RBSTRUCT, RBFIELD, x, ...)	\
+	what(3, RBNAME, RBSTRUCT, RBFIELD, x)				\
+	RB_FOR_EACH_2(what, RBNAME, RBSTRUCT, RBFIELD, __VA_ARGS__)
+#define RB_FOR_EACH_4(what, RBNAME, RBSTRUCT, RBFIELD, x, ...)	\
+	what(4, RBNAME, RBSTRUCT, RBFIELD, x)				\
+	RB_FOR_EACH_3(what, RBNAME, RBSTRUCT, RBFIELD, __VA_ARGS__)
+#define RB_FOR_EACH_5(what, RBNAME, RBSTRUCT, RBFIELD, x, ...)	\
+	what(5, RBNAME, RBSTRUCT, RBFIELD, x)				\
+	RB_FOR_EACH_4(what, RBNAME, RBSTRUCT, RBFIELD, __VA_ARGS__)
+#define RB_FOR_EACH_6(what, RBNAME, RBSTRUCT, RBFIELD, x, ...)	\
+	what(6, RBNAME, RBSTRUCT, RBFIELD, x)				\
+	RB_FOR_EACH_5(what, RBNAME, RBSTRUCT, RBFIELD, __VA_ARGS__)
+#define RB_FOR_EACH_7(what, RBNAME, RBSTRUCT, RBFIELD, x, ...)	\
+	what(7, RBNAME, RBSTRUCT, RBFIELD, x)				\
+	RB_FOR_EACH_6(what, RBNAME, RBSTRUCT, RBFIELD, __VA_ARGS__)
+#define RB_FOR_EACH_8(what, RBNAME, RBSTRUCT, RBFIELD, x, ...)	\
+	what(8, RBNAME, RBSTRUCT, RBFIELD, x)				\
+	RB_FOR_EACH_7(what, RBNAME, RBSTRUCT, RBFIELD, __VA_ARGS__)
+
+#define RB_FOR_EACH(action, RBNAME, RBSTRUCT, RBFIELD, ...)		\
+	CONCATENATE(RB_FOR_EACH_, COUNT_ARGS(__VA_ARGS__))		\
+		(action, RBNAME, RBSTRUCT, RBFIELD, __VA_ARGS__)
+
+/*
+ * One augmented field: @val is the node's own contribution (a member for
+ * RB_AUG(), a function of the node for RB_AUG_FUNC()), @aug the member
+ * holding the aggregate over the subtree, and @fold(a, b) combines two
+ * aggregates: min, max, a sum, ...  It must be commutative and associative.
+ */
+#define RB_AUG_FUNC(val, aug, fold) (val(s), aug, fold)
+#define RB_AUG(val, aug, fold) (s->val, aug, fold)
+#define RB_UNPACK(...) __VA_ARGS__
+
+#define __RB_INST(n, RBNAME, RBSTRUCT, RBFIELD, val, aug, fold)		\
+static inline void							\
+RBNAME ## _copy_ ## n(RBSTRUCT *old, RBSTRUCT *new)			\
+{									\
+	new->aug = old->aug;						\
+}									\
+static inline bool							\
+RBNAME ## _compute_ ## n(RBSTRUCT *s, bool exit)			\
+{									\
+	TYPEOF_UNQUAL(s->aug) _old_aug = s->aug;			\
+	TYPEOF_UNQUAL(s->aug) _val = val;				\
+	struct rb_node *_node = &s->RBFIELD;				\
+	if (_node->rb_right) {						\
+		RBSTRUCT *_c = container_of(_node->rb_right, typeof(*s), RBFIELD); \
+		_val = fold(_val, _c->aug);				\
+	}								\
+	if (_node->rb_left) {						\
+		RBSTRUCT *_c = container_of(_node->rb_left, typeof(*s), RBFIELD); \
+		_val = fold(_val, _c->aug);				\
+	}								\
+	s->aug = _val;							\
+	return _old_aug == _val;					\
+}
+#define _RB_INST(n, RBNAME, RBSTRUCT, RBFIELD, args)			\
+	__RB_INST(n, RBNAME, RBSTRUCT, RBFIELD, args)
+#define RB_INST(n, RBNAME, RBSTRUCT, RBFIELD, x)			\
+	_RB_INST(n, RBNAME, RBSTRUCT, RBFIELD, RB_UNPACK x)
+
+#define __RB_COPY(n, RBNAME, RBSTRUCT, RBFIELD, val, aug, fold)		\
+	RBNAME ## _copy_ ## n(old, new);
+#define _RB_COPY(n, RBNAME, RBSTRUCT, RBFIELD, args)			\
+	__RB_COPY(n, RBNAME, RBSTRUCT, RBFIELD, args)
+#define RB_COPY(n, RBNAME, RBSTRUCT, RBFIELD, x)			\
+	_RB_COPY(n, RBNAME, RBSTRUCT, RBFIELD, RB_UNPACK x)
+
+#define __RB_COMPUTE(n, RBNAME, RBSTRUCT, RBFIELD, val, aug, fold)	\
+	ret &= RBNAME ## _compute_ ## n(node, exit);
+#define _RB_COMPUTE(n, RBNAME, RBSTRUCT, RBFIELD, args)			\
+	__RB_COMPUTE(n, RBNAME, RBSTRUCT, RBFIELD, args)
+#define RB_COMPUTE(n, RBNAME, RBSTRUCT, RBFIELD, x)			\
+	_RB_COMPUTE(n, RBNAME, RBSTRUCT, RBFIELD, RB_UNPACK x)
+
 /*
  * Template for declaring augmented rbtree callbacks (generic multi fields)
  *
@@ -93,18 +175,29 @@ rb_add_augmented_cached(struct rb_node *node, struct rb_root_cached *tree,
  * RBNAME:      name of the rb_augment_callbacks structure
  * RBSTRUCT:    struct type of the tree nodes
  * RBFIELD:     name of struct rb_node field within RBSTRUCT
- * RBCOPY:	name of function that copies the RBAUGMENTED datas
- * RBCOMPUTE:   name of function that recomputes the RBAUGMENTED datas
+ * RBAUG...:	list of RB_AUG() describing the augmented data
  */
-
-#define RB_DECLARE_CALLBACKS_MULTI(RBSTATIC, RBNAME,			\
-			     RBSTRUCT, RBFIELD, RBCOPY, RBCOMPUTE)	\
+#define RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,				\
+			     RBSTRUCT, RBFIELD, RBAUG...)		\
+RB_FOR_EACH(RB_INST, RBNAME, RBSTRUCT, RBFIELD, RBAUG)			\
+static inline void							\
+RBNAME ## __copy(RBSTRUCT *old, RBSTRUCT *new)				\
+{									\
+	RB_FOR_EACH(RB_COPY, RBNAME, RBSTRUCT, RBFIELD, RBAUG);		\
+}									\
+static inline bool							\
+RBNAME ## __compute(RBSTRUCT *node, bool exit)				\
+{									\
+	bool ret = true;						\
+	RB_FOR_EACH(RB_COMPUTE, RBNAME, RBSTRUCT, RBFIELD, RBAUG);	\
+	return ret;							\
+}									\
 static inline void							\
 RBNAME ## _propagate(struct rb_node *rb, struct rb_node *stop)		\
 {									\
 	while (rb != stop) {						\
 		RBSTRUCT *node = rb_entry(rb, RBSTRUCT, RBFIELD);	\
-		if (RBCOMPUTE(node, true))				\
+		if (RBNAME ## __compute(node, true))			\
 			break;						\
 		rb = rb_parent(&node->RBFIELD);				\
 	}								\
@@ -114,15 +207,15 @@ RBNAME ## _copy(struct rb_node *rb_old, struct rb_node *rb_new)		\
 {									\
 	RBSTRUCT *old = rb_entry(rb_old, RBSTRUCT, RBFIELD);		\
 	RBSTRUCT *new = rb_entry(rb_new, RBSTRUCT, RBFIELD);		\
-	RBCOPY(new, old);						\
+	RBNAME ## __copy(old, new);					\
 }									\
 static void								\
 RBNAME ## _rotate(struct rb_node *rb_old, struct rb_node *rb_new)	\
 {									\
 	RBSTRUCT *old = rb_entry(rb_old, RBSTRUCT, RBFIELD);		\
 	RBSTRUCT *new = rb_entry(rb_new, RBSTRUCT, RBFIELD);		\
-	RBCOPY(new, old);						\
-	RBCOMPUTE(old, false);						\
+	RBNAME ## __copy(old, new);					\
+	RBNAME ## __compute(old, false);				\
 }									\
 RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
 	.propagate = RBNAME ## _propagate,				\
@@ -130,27 +223,6 @@ RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
 	.rotate = RBNAME ## _rotate					\
 };
 
-/*
- * Template for declaring augmented rbtree callbacks (generic single field)
- *
- * RBSTATIC:    'static' or empty
- * RBNAME:      name of the rb_augment_callbacks structure
- * RBSTRUCT:    struct type of the tree nodes
- * RBFIELD:     name of struct rb_node field within RBSTRUCT
- * RBAUGMENTED: name of field within RBSTRUCT holding data for subtree
- * RBCOMPUTE:   name of function that recomputes the RBAUGMENTED data
- */
-
-#define RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,				\
-			     RBSTRUCT, RBFIELD, RBAUGMENTED, RBCOMPUTE)	\
-static inline void							\
-RBNAME ## _copy_single(RBSTRUCT *new, RBSTRUCT *old)			\
-{									\
-	new->RBAUGMENTED = old->RBAUGMENTED;				\
-}									\
-RB_DECLARE_CALLBACKS_MULTI(RBSTATIC, RBNAME,				\
-		     RBSTRUCT, RBFIELD, RBNAME ## _copy_single, RBCOMPUTE)
-
 /*
  * Template for declaring augmented rbtree callbacks,
  * computing RBAUGMENTED scalar as max(RBCOMPUTE(node)) for all subtree nodes.
@@ -159,34 +231,15 @@ RB_DECLARE_CALLBACKS_MULTI(RBSTATIC, RBNAME,				\
  * RBNAME:      name of the rb_augment_callbacks structure
  * RBSTRUCT:    struct type of the tree nodes
  * RBFIELD:     name of struct rb_node field within RBSTRUCT
- * RBTYPE:      type of the RBAUGMENTED field
- * RBAUGMENTED: name of RBTYPE field within RBSTRUCT holding data for subtree
- * RBCOMPUTE:   name of function that returns the per-node RBTYPE scalar
+ * RBTYPE:      type of the RBAUGMENTED field -- unused, assumed typeof(RBAUGMENTED)
+ * RBAUGMENTED: name of field within RBSTRUCT holding data for subtree
+ * RBVALUE:     name of function that returns the per-node RBTYPE scalar
  */
 
-#define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	      \
-				 RBTYPE, RBAUGMENTED, RBCOMPUTE)	      \
-static inline bool RBNAME ## _compute_max(RBSTRUCT *node, bool exit)	      \
-{									      \
-	RBSTRUCT *child;						      \
-	RBTYPE max = RBCOMPUTE(node);					      \
-	if (node->RBFIELD.rb_left) {					      \
-		child = rb_entry(node->RBFIELD.rb_left, RBSTRUCT, RBFIELD);   \
-		if (child->RBAUGMENTED > max)				      \
-			max = child->RBAUGMENTED;			      \
-	}								      \
-	if (node->RBFIELD.rb_right) {					      \
-		child = rb_entry(node->RBFIELD.rb_right, RBSTRUCT, RBFIELD);  \
-		if (child->RBAUGMENTED > max)				      \
-			max = child->RBAUGMENTED;			      \
-	}								      \
-	if (exit && node->RBAUGMENTED == max)				      \
-		return true;						      \
-	node->RBAUGMENTED = max;					      \
-	return false;							      \
-}									      \
-RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,					      \
-		     RBSTRUCT, RBFIELD, RBAUGMENTED, RBNAME ## _compute_max)
+#define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,		\
+				 RBTYPE, RBAUGMENTED, RBVALUE)			\
+RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,			\
+		     RB_AUG_FUNC(RBVALUE, RBAUGMENTED, max))
 
 
 #define	RB_RED		0
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7455a83a6a990..fa7f01159b493 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1004,71 +1004,17 @@ static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
 	return entity_before(__node_2_se(a), __node_2_se(b));
 }
 
-static inline void __min_vruntime_update(struct sched_entity *se, struct rb_node *node)
+/* min() for wrapping vruntimes */
+static inline u64 __min_vruntime(u64 a, u64 b)
 {
-	if (node) {
-		struct sched_entity *rse = __node_2_se(node);
-
-		if (vruntime_cmp(se->min_vruntime, ">", rse->min_vruntime))
-			se->min_vruntime = rse->min_vruntime;
-	}
-}
-
-static inline void __min_slice_update(struct sched_entity *se, struct rb_node *node)
-{
-	if (node) {
-		struct sched_entity *rse = __node_2_se(node);
-		if (rse->min_slice < se->min_slice)
-			se->min_slice = rse->min_slice;
-	}
-}
-
-static inline void __max_slice_update(struct sched_entity *se, struct rb_node *node)
-{
-	if (node) {
-		struct sched_entity *rse = __node_2_se(node);
-		if (rse->max_slice > se->max_slice)
-			se->max_slice = rse->max_slice;
-	}
-}
-
-static inline void min_vruntime_copy(struct sched_entity *new, struct sched_entity *old)
-{
-	new->min_vruntime = old->min_vruntime;
-	new->min_slice = old->min_slice;
-	new->max_slice = old->max_slice;
+	return vruntime_cmp(a, "<", b) ? a : b;
 }
 
-/*
- * se->min_vruntime = min(se->vruntime, {left,right}->min_vruntime)
- */
-static inline bool min_vruntime_update(struct sched_entity *se, bool exit)
-{
-	u64 old_min_vruntime = se->min_vruntime;
-	u64 old_min_slice = se->min_slice;
-	u64 old_max_slice = se->max_slice;
-	struct rb_node *node = &se->run_node;
-
-	se->min_vruntime = se->vruntime;
-	__min_vruntime_update(se, node->rb_right);
-	__min_vruntime_update(se, node->rb_left);
-
-	se->min_slice = se->slice;
-	__min_slice_update(se, node->rb_right);
-	__min_slice_update(se, node->rb_left);
-
-	se->max_slice = se->slice;
-	__max_slice_update(se, node->rb_right);
-	__max_slice_update(se, node->rb_left);
-
-	return se->min_vruntime == old_min_vruntime &&
-	       se->min_slice == old_min_slice &&
-	       se->max_slice == old_max_slice;
-}
-
-
-RB_DECLARE_CALLBACKS_MULTI(static, min_vruntime_cb, struct sched_entity,
-		     run_node, min_vruntime_copy, min_vruntime_update);
+RB_DECLARE_CALLBACKS(static, min_vruntime_cb,
+		     struct sched_entity, run_node,
+		     RB_AUG(vruntime, min_vruntime, __min_vruntime),
+		     RB_AUG(slice, min_slice, min),
+		     RB_AUG(slice, max_slice, max));
 
 /*
  * Enqueue an entity into the rb-tree:
diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 6fda36ab17669..45189012a0f94 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -88,10 +88,9 @@ struct tipc_service {
 	struct rcu_head rcu;
 };
 
-#define service_range_upper(sr) ((sr)->upper)
-RB_DECLARE_CALLBACKS_MAX(static, sr_callbacks,
-			 struct service_range, tree_node, u32, max,
-			 service_range_upper)
+RB_DECLARE_CALLBACKS(static, sr_callbacks,
+		     struct service_range, tree_node,
+		     RB_AUG(upper, max, max));
 
 #define service_range_entry(rbtree_node)				\
 	(container_of(rbtree_node, struct service_range, tree_node))
-- 
2.34.1

