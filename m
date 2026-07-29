Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48443DA4A
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318271; cv=none; b=KTh2GxaInd6z2wEq7et2LcBFegmBXqYmYYDdrf1+CujPyYiCJ1bgxwWTN/kHEzXURZW85b6nuG1p+f9cNsFinhzoaGpQ5q3no9EhES3ZNHlHFeiojgsNPvqL+Z3XVNKGJVOStjSYj5w4v+0Ij29FETJuWpwHbNczomQ+ih3HHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318271; c=relaxed/simple;
	bh=eRCD8+c903mdyDGb3OkP+4+gNhLNWKjnmyleU8LBpv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VOT4e/3op0wDAQV8QnsO13BeLp7AUbxbx1EVUtEqY9LJqVR5CsBYIwj7YRXc7cvwMpyhVV+HCO7D19D9eYDUV558GmHgg1m0TDcG0K7BGCCtgrTi71DIUaOEieSHDFslB9iq3X6i8QT/47CS98H26dLMOXuVTYXAoEVW5PIivbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=BAaTcwG9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="BAaTcwG9"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51bfe810293so4098991cf.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785318267; x=1785923067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8qkElVMSbjg2zzOrMS39/7630HdM89/8AUYMYYV6/y8=;
        b=BAaTcwG9mITeH59VwGIt4cDWU5A6YMAhdU26N0/ObjO47q5puIHMUPYquJet7nomlt
         K7Uyp7O3A4k+3ew59idbBEYYhQPpUUYFMtVoqH0xFBdxXMV81fGqgkOT5L8iNqtfMCFm
         8yMvGm+jEJKwB/7VEU9BKXaDl3+YkDtcMi8H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785318267; x=1785923067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8qkElVMSbjg2zzOrMS39/7630HdM89/8AUYMYYV6/y8=;
        b=Jdi3Cz2fi80iPuSS76bKTtlkOwAeWu3+YAXOnf8drgDLPzF9Kj0Mk7fcNGs6ccRNXa
         e1Ak2zQ7FnGlOPx2uxRbE7K6EgX2hjXT81i2ipWg+NrY9e/NqMmmMkPAXDTDPXQEMhzM
         DG5LqdpXksrUsRkhIGRJfJweDBBN6zFzKLXjYCHhFQgNg3wx5Kw/WYtSF4vMed3Z3Bf9
         NG6YKNR50FZhce8R+1zdFiAnZJdUo7A8782pLwVuZz369VqDcdSsK37TgLS/LOMZkbCC
         KCyihU3vrYP45ScjqyWsTHrz0wf/15ZwI9VTmabwJ2lbG7u/dF5K7pkfXLJYoOB8jxLv
         c3Mg==
X-Gm-Message-State: AOJu0YxzjqIpeOq8Jtf/awUvML/fsd3Q/ewxbLM1QmS2mjgGd5eRbJw/
	Fv1OxWei2kjeWIXr4OD/Z+76EfxziN0/CC+TPo+MAZxZsKFEJgm623eQpNYm4Jmuofvs+P6BUqx
	0wkY=
X-Gm-Gg: AR+sD13mio6IRv2ekdt6YrPKRtjJuZ/ana1y4125YTBaQIWBGX/KUvyFtVgxyNDWvFZ
	sT4s7qW7VJFtfv/Yv6UnVW3toHjYUIseZH9AR3iJe4yz5JOF/3x2j05eDYSR+uyg2u3+H1XP4AP
	hzFxlWC5dt4flpRCgBsrtP0kKfq5Yng26GeHZ0Hn1X1FDhSmaX2V+QEzMYMgubtEBwdJqh6+cxe
	29r3dJQg+edXvoyUFHTtJ/vpPsBpJMFTRy6mJItHalZCmAgLM5Vc+tPW+yKYwYxFC+KJq9FM55p
	TupUehYgGzNACz81sOsbgo5UEa7VJn89YHhSKz/2ify4d2ZCt6TGzyWb5yGkO9IAl95G4lhGrJl
	WT1PnbgdxvPfz28SmllDoYUu/rKE4KbJKj0DVgwlGSNmLojpXrLLKH92EblqW3WXOyS2Mo/NQPo
	Y2WeKU41K09vy82l/NGIOyEJ760NEG/Dlale/AsAMoPSOE2EP7KCDA9HqpuCyLplscvg==
X-Received: by 2002:ac8:5941:0:b0:527:7d0f:863b with SMTP id d75a77b69052e-529d6fa1d87mr49728431cf.12.1785318267458;
        Wed, 29 Jul 2026 02:44:27 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2b67050sm15041351cf.12.2026.07.29.02.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 02:44:26 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jiri@resnulli.us,
	zdi-disclosures@trendmicro.com,
	santosh.kalluri129@gmail.com,
	victor@mojatatu.com,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net] net/sched: cls_route: fix fastmap use-after-free on filter
Date: Wed, 29 Jul 2026 05:44:11 -0400
Message-Id: <20260729094411.46257-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The route4 classifier maintains a 16-slot fastmap cache that stores raw
struct route4_filter pointers indexed by (id, iif). The reader
(route4_classify) populates this cache via route4_set_fastmap() for every
classified packet that hits a filter. The writer (route4_delete,
route4_change) clears the cache via route4_reset_fastmap() before
RCU-deferred kfree of the filter.

This creates a UAF race:
 1. Reader walks the RCU-protected bucket chain, finds filter f
 2. Writer unlinks f, calls route4_reset_fastmap(), then tcf_queue_work()
 3. Reader calls route4_set_fastmap() and writes f into the cache
    *after* the writer's reset, caching a pointer about to be freed
 4. After the RCU grace period, kfree(f) executes
 5. Next classified packet on the same (id, iif) tuple hits the stale
    fastmap entry and reads f->res from freed memory

Reproduced with an mdelay(100) accelerator in route4_set_fastmap() and a
concurrent add/delete stress test (provided by both zdi and Santosh).
Both triggered KASAN slab-use-after-free reports in the route4 fastmap
paths.

Fix:
Introduce a per-filter boolean dying flag to suppress stale fastmap
republishing by in-flight readers.

Fixes: 1109c00547fc ("net: sched: RCU cls_route")
Reported-by: zdi-disclosures@trendmicro.com
Reported-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
V1->V2
1. Fix based on feedback from the Sashikos
https://sashiko.dev/#/patchset/20260723105210.817079-1-jhs%40mojatatu.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723105210.817079-1-jhs%40mojatatu.com

Restore the "if (tcf_exts_get_net(&f->exts)) route4_queue_work(f);
else __route4_delete_filter(f);"
preserving the tcf_exts_get_net() contract for netns teardown.

V2->V3
Revert earlier suggestion from Santosh's rcu sync to Paolo's suggestion to use
the dying flag approach.
---
 net/sched/cls_route.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index bd6f945bd388..eded7aacd3f7 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -52,6 +52,7 @@ struct route4_filter {
 	struct tcf_result	res;
 	struct tcf_exts		exts;
 	u32			handle;
+	bool			dying;
 	struct route4_bucket	*bkt;
 	struct tcf_proto	*tp;
 	struct rcu_work		rwork;
@@ -66,9 +67,11 @@ static inline int route4_fastmap_hash(u32 id, int iif)
 
 static DEFINE_SPINLOCK(fastmap_lock);
 static void
-route4_reset_fastmap(struct route4_head *head)
+route4_reset_fastmap(struct route4_head *head, struct route4_filter *f)
 {
 	spin_lock_bh(&fastmap_lock);
+	if (f)
+		f->dying = true;
 	memset(head->fastmap, 0, sizeof(head->fastmap));
 	spin_unlock_bh(&fastmap_lock);
 }
@@ -81,9 +84,11 @@ route4_set_fastmap(struct route4_head *head, u32 id, int iif,
 
 	/* fastmap updates must look atomic to aling id, iff, filter */
 	spin_lock_bh(&fastmap_lock);
-	head->fastmap[h].id = id;
-	head->fastmap[h].iif = iif;
-	head->fastmap[h].filter = f;
+	if (f == ROUTE4_FAILURE || !f->dying) {
+		head->fastmap[h].id = id;
+		head->fastmap[h].iif = iif;
+		head->fastmap[h].filter = f;
+	}
 	spin_unlock_bh(&fastmap_lock);
 }
 
@@ -297,6 +302,13 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,
 					next = rtnl_dereference(f->next);
 					RCU_INIT_POINTER(b->ht[h2], next);
 					tcf_unbind_filter(tp, &f->res);
+					/* Mark the filter dying under fastmap_lock so
+					 * any in-flight reader that still holds it
+					 * will skip the republish in route4_set_fastmap().
+					 */
+					spin_lock_bh(&fastmap_lock);
+					f->dying = true;
+					spin_unlock_bh(&fastmap_lock);
 					if (tcf_exts_get_net(&f->exts))
 						route4_queue_work(f);
 					else
@@ -307,6 +319,11 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,
 			kfree_rcu(b, rcu);
 		}
 	}
+
+	/* All filters are unlinked and marked dying, so no in-flight
+	 * reader can republish a stale entry after this reset.
+	 */
+	route4_reset_fastmap(head, NULL);
 	kfree_rcu(head, rcu);
 }
 
@@ -334,11 +351,11 @@ static int route4_delete(struct tcf_proto *tp, void *arg, bool *last,
 			/* unlink it */
 			RCU_INIT_POINTER(*fp, rtnl_dereference(f->next));
 
-			/* Remove any fastmap lookups that might ref filter
-			 * notice we unlink'd the filter so we can't get it
-			 * back in the fastmap.
+			/* Clear any fastmap entries that may ref this filter and
+			 * mark it dying so in-flight readers can't republish it
+			 * after the reset.
 			 */
-			route4_reset_fastmap(head);
+			route4_reset_fastmap(head, f);
 
 			/* Delete it */
 			tcf_unbind_filter(tp, &f->res);
@@ -558,7 +575,7 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 		}
 	}
 
-	route4_reset_fastmap(head);
+	route4_reset_fastmap(head, fold);
 	*arg = f;
 	if (fold) {
 		tcf_unbind_filter(tp, &fold->res);
-- 
2.34.1

