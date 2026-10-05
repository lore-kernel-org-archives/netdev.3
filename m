Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A444330F
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192804; cv=none; b=kywN6lsuLAhUq/a6LIxfJnvRGmiKLrkpDNCqlO/ZzDxI+7WlJbaJWGhlMBXLI+d90CfSSiaj3M0VopFjJsBaEo0XOsfjOukNp3JeOWjmMYlnkLv5z+HdkfMM3YFUs8pLzunHa4zi/VSqxBSuOkVoJOcqs0DxbkBlosjkZY3oeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192804; c=relaxed/simple;
	bh=3FvDwta9Xf3GP3LDRe0DabkVYoyNOvdxsyyWBqGq3OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q93R/GJStRzvRmEHrVGYAYUvs/LWEMUiDEee6YboB2U/uX4omVU9k+FKf1dvhcVHRC4Ya5n9LpCrVlovu3f9+gtda+SrzP1L3z1wl0zLJYVb+zRR+SisFypBpXcPNHgyaOJanVFfQmHTrK/XedwaxJ1VD+K64KLLXBIWmgEi41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLqM/8oB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLqM/8oB"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so413645a12.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791192792; x=1791797592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=arIGX95LvslT59XRwqPoOPq+NzM9JaE9o6id1HunDJ0=;
        b=RLqM/8oBZKiVtFN+o4nJ/4gwEaNBfHyP+SmB297jtczY50sqzWEIwWPUxSt69YfGTU
         GD3OTlnUMeJIyTgwFrfI++Bo+P8a3ZLNQ/7zCvJNM9Ql1a5oi9B/Mwfu9g9E3JnwD+ZE
         58ZUs1QIjQiYi44xN8yhVTcfT4uspAi2XYJteQA6FieIllb2fiQqEg1YAjYmXGROgroC
         mAnJq3IcGeXg9VyBSEwprhX9lNRnftGntVeHwhcZvXJHsGO6G+Ay0tZR3+X1IfIyobrI
         Oq+5k5aq+A3U5DMDtLkIid1PAeZndBvnWLNrhx/a9TMBnugijBySCnKexV6Dsu/I0MhI
         wuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791192792; x=1791797592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=arIGX95LvslT59XRwqPoOPq+NzM9JaE9o6id1HunDJ0=;
        b=AkLCQUEYMTrZtdq2ha0gQLOdi+M4ZLylkxSKCHPbC8mUaCoTEqpcwyHMwmNd2oQPxV
         B5bFHRiSm3KFhDBSQxqO8Ei9o0CxfnduKQwS4W7MGZnt79kLGb/zYYNmENlT+CwsbGJy
         VVFRGnk8uvsI0zP03TgXJxRzCJA2LaQKZj802YTzD3yBcdaRUW51vGGGF60+Pd5HF93U
         tuHtFOuE9IOZ7qKyPz0/0yIhc2vwQjdVP4HPq1yTDpM2UJ/BXNVW/kNtpWh3pED/p7ix
         dL886R8YLNWCmuiliJLNViWmaOQIlGp52fGw8QmMqOBFZhn+LPWpWjSLnnz/CZLwy1fx
         oR6A==
X-Forwarded-Encrypted: i=1; AKwUvBw087N64FeythkvJQTdFafy4gNPMHyEfvw8qb5E7/oXsH9HsGLJB+ISVRQV7AeNFOB+tooTFm8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhFpYPUZIwk9RWVTxAb825AYwOoj2BBe/3AyH+sQBgMa/j369q
	RD1VM6RrlpjZ1Z4J1K/YgLwGF6RhUIWQ1466KrfVjoj+gR1UZKyKzQC8
X-Gm-Gg: AYBFou1D92Y0RRLFP1nl1JW5IRDjmyisDeqE5otlfX+pfLCLrUAIOfPBkTm7Smuh2xb
	CT/XprMZetxPF2TFOlPt3kLB5yxSKxs2IEcAWWwkxLkaf+2BguZkNeVG/xuieYEV3aVa7iEco7U
	LcfZMFeok3ftzhSnxMVjjnl/8+H/mAc9rpYeaSwi9UMMVrgsjmVVHvB1kXp802WBPtp0jU2rchW
	q2mBH3G+/GkdTB+ALXkFrVCUlI0+HERMZTV7fSX3//YABDANTc1v+S5EVdXQDqp7PTs12eI0Ryu
	pk+vdvwZWKk50Q+LPOI9mJpmfF1KVosKaQ/Xzct1IvdadsTCvi3pOzrRa2aaLmR7ILTODrtpUWd
	8XNuejp0SHWUHyZvPQrvvu2Iv5+1Ai/oGAVFGIBzH9cmVXtx6Vu8HAIGhHnF97Hi4TiEpUfjYeR
	eu1hRSUTsud2BmskdnCx+i7vI8xODM2qKNO1lKZOt5IF7jFbO65JsYhHqjEYtb23eS97AOQLRHL
	/7QJMHANCBGOFNqCK8=
X-Received: by 2002:a17:90b:134f:b0:3a0:ca03:3e1f with SMTP id 98e67ed59e1d1-3a7872b2fdcmr5300419a91.32.1791192792227;
        Mon, 05 Oct 2026 02:33:12 -0700 (PDT)
Received: from NV-9MNJ414.tailae2068.ts.net ([72.25.121.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7ad87874esm4527886a91.0.2026.10.05.02.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 02:33:11 -0700 (PDT)
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
Subject: [PATCH v3 2/4] rbtree: declare augmented callbacks per field with RB_AUG()
Date: Mon,  5 Oct 2026 17:32:34 +0800
Message-Id: <20261005093236.62702-3-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005093236.62702-1-s921975628@gmail.com>
References: <20261005093236.62702-1-s921975628@gmail.com>
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
 include/linux/rbtree_augmented.h | 167 ++++++++++++++++++++-----------
 kernel/sched/fair.c              |  70 ++-----------
 net/tipc/name_table.c            |   7 +-
 3 files changed, 122 insertions(+), 122 deletions(-)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index d2fa1c41bfd2b..fbfa675dce5fb 100644
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
@@ -86,6 +88,88 @@ rb_add_augmented_cached(struct rb_node *node, struct rb_root_cached *tree,
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
+	if (exit && _old_aug == _val)					\
+		return true;						\
+	s->aug = _val;							\
+	return false;							\
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
@@ -93,18 +177,29 @@ rb_add_augmented_cached(struct rb_node *node, struct rb_root_cached *tree,
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
@@ -114,15 +209,15 @@ RBNAME ## _copy(struct rb_node *rb_old, struct rb_node *rb_new)		\
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
@@ -130,27 +225,6 @@ RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
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
@@ -159,34 +233,15 @@ RB_DECLARE_CALLBACKS_MULTI(RBSTATIC, RBNAME,				\
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

