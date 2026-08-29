Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61FC31716B
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788036874; cv=none; b=TVE59cHxgPjxyZRol0dsvyNeWmUohK7qa4vXq+S6IG/1/RD4DP/tF8unAi5wNBJgRt4vQmC5Y6D0WOERPA1ao1MsHNxhL9xCmNW2VbSIeESwzWOaspY133WqT/kvmU6/WlwKwnvuIsY667o2wR2nWKq1qJFENWMWSD7b/s39l7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788036874; c=relaxed/simple;
	bh=7Jy5TAydXwue+f/1o9MjpjlR+URu5Uvu059mzYb7is4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVRuItUxD6QJcRTHFtR2WzHAt5p/yYLwZD7P981LiNlw0WH1qp1aMO+6JVRgCffpBDlZAisoeNN4ixSeuCltKHAfLvjBcsN3lO4FEPQmWVL1JrRXEissBfT7IpuGg8u88EDKKt8tiAmaEHB7NV4sh/pEip9bAXFIiNM6MW6s7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=EAA2/9nO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="EAA2/9nO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6efd73032so27663615ad.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 13:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788036872; x=1788641672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=08pvip6QSZqdrXwRg7+z8fnfvQkab4FogxIdVMviOtk=;
        b=EAA2/9nOKIvq727lRg+SIy0U3b5OipoxmOFQQ9k7xIh3nbbGb3swL6o0626hQ/Ui3l
         q694xeVNkzg6344YIIKPENosocdB5l6QtbojCJWPkJu+FGHS1MVvj04cfNJFk2Ai6hgv
         swERCr7NzjmzSB0Gz2iUz2YLEHgsKtRHwN2PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788036872; x=1788641672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08pvip6QSZqdrXwRg7+z8fnfvQkab4FogxIdVMviOtk=;
        b=ZoEf1msazraK8YI2XHGE+fdBShRn2rIoJ1GKimdQ9xxyVdIPWpRtK97Rns6tHFF/20
         dgO1ypQ+Cfm2WDgKb2T9IXevGiSCa/0FWbldu1zLzT/urjmYWvzOdI6VZKJ1YsroTpCU
         y7OEQLkADqaGbRqTMA8mF4FuE4doIdnato6wJDV167WWr7kqsBz9JKpjBAbZMrKMAe0G
         xnB0bRh9eulOsU1j6eCzVhLRJ2nyy8Kzt+K3IHvYkqLIaDHsAbyuy+hqZHp4ir5LPgx5
         y3zKJPKuAgEL4kFHVN2ep4U+gxVlP4IsY4bHpbCgqKbAW37kshjYA3SWyLwNKrVPiM9g
         YaSg==
X-Forwarded-Encrypted: i=1; AKwUvBxaZ8YZgzrpHKFWuMuLoIHjZl/bCHMFVU60mdzAjpPM74p2vhOZhAyOX4WTRMgCZkD6n1G+glc=@vger.kernel.org
X-Gm-Message-State: AFuF++n4hUuxOBUyvs5DKN9K50sahPkHyIj/U+H+hbQIkEo+eVh5VAqO
	R/GRy7mY58hpNT5mwQTSoRjQv1Ezt/jm/KxlNpSpA2QGxWTJlFYK1PbP5SqXdbBzkE5qsQMUNDs
	xtGProQ==
X-Gm-Gg: AYBFou2VCow0Y5XQ8st1pewyCB2iyHxY7Mn0ZxXEZ8of3H6bEMbF6574frAmPqKKeIj
	eTJx0LRUifVaUb3iEy40IpS7/HyGu2bESnS2vhEfnEHYzmNY5MIBOeIHtV3S3cDHI9psPnQ1D+E
	OI1HTVCWIK1GuDlaAo3dp8j1ZTeMt0HyCCvmoL5mDPFuNNA14A6hcB1sHdOASD4DkIwkKw31BSs
	LqNs+1Z/BsvH3/zt6txzreJGZsHxjDNxedXqbDnwxGLo668Ga9p0bJJASXi6jrSHjuNUuJ8RDWF
	lBJ+ujBjd4HVMkpKnoDTiVwMHn8x2SN81W7bJxD7A9Q6ELkPM5ZD3xak6dDsmg9rasNs4tzzC9/
	YQbAkX1j3xvSwBwxpZeOD9tCxDtHOl1LJ8rpsKgN6PU/Fm58MvWgVIrFm17kU6Q63UAGk0ANdLN
	uhzpG1wzPYM0VfAZpShfWEhBrwKd1Be1/C544LguahaIU=
X-Received: by 2002:a17:902:ffcf:b0:2d7:1b20:e98f with SMTP id d9443c01a7336-2d725df6dbcmr273825135ad.2.1788036871945;
        Sat, 29 Aug 2026 13:54:31 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f95a160sm17848460eec.18.2026.08.29.13.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 13:54:31 -0700 (PDT)
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
Subject: [PATCH net] net/sched: cls_route: free emptied bucket on filter move
Date: Sat, 29 Aug 2026 17:54:22 -0300
Message-ID: <20260829205422.854785-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

route4_change can move an existing filter to a different top-level
bucket: route4_set_parms recomputes the handle from TCA_ROUTE4_TO/
FROM/IIF, and the handle-mismatch check is gated on the 'new' flag, so
for an existing filter the new handle may differ from the old one and
land in a different bucket. When this happens, the filter is unlinked
from the old bucket, but the bucket itself is never freed once it goes
empty. The stale empty bucket remains in head->table[], causing
route4_delete to report *last=false even after the last live filter is
gone. That pins the empty tcf_proto and causes a leak.

Fix this by refcounting the filters linked to a bucket and freeing the
bucket when the count drops to zero. The existing scan in route4_delete
goes away with it.

The count is updated at all sites that link or unlink a filter during add,
change and delete, and the bucket is dropped from head->table[] as soon as
it reaches zero.

Conditions to recreate the bug:
  CONFIG_NET_CLS_ROUTE4=y, CONFIG_NET_SCH_INGRESS=y, CONFIG_NET_CLS_ACT=y.

  tc qdisc replace dev lo clsact
  tc filter add dev lo ingress protocol ip pref 100 route from 1 to 1
  tc filter change dev lo ingress protocol ip pref 100 handle 0x10001 \
    route from 1 to 2
  tc filter del dev lo ingress protocol ip pref 100 handle 0x10002 \
    route from 1 to 2
  tc filter show dev lo ingress | grep -c 'pref 100 route chain 0 '

Fixes: 1e052be69d04 ("net_sched: destroy proto tp when all filters are gone")
Reported-by: Vega <vega@nebusec.ai>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/cls_route.c | 45 +++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 0d1324c90583..17b0ebb76662 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/refcount.h>
 #include <linux/skbuff.h>
 #include <net/dst.h>
 #include <net/route.h>
@@ -41,6 +42,7 @@ struct route4_head {
 struct route4_bucket {
 	/* 16 FROM buckets + 16 IIF buckets + 1 wildcard bucket */
 	struct route4_filter __rcu	*ht[16 + 16 + 1];
+	refcount_t			filters_ref;
 	struct rcu_head			rcu;
 };
 
@@ -336,7 +338,7 @@ static int route4_delete(struct tcf_proto *tp, void *arg, bool *last,
 	struct route4_filter *nf;
 	struct route4_bucket *b;
 	unsigned int h = 0;
-	int i, h1;
+	int h1;
 
 	if (!head || !f)
 		return -EINVAL;
@@ -362,23 +364,14 @@ static int route4_delete(struct tcf_proto *tp, void *arg, bool *last,
 			tcf_exts_get_net(&f->exts);
 			tcf_queue_work(&f->rwork, route4_delete_filter_work);
 
-			/* Strip RTNL protected tree */
-			for (i = 0; i <= 32; i++) {
-				struct route4_filter *rt;
-
-				rt = rtnl_dereference(b->ht[i]);
-				if (rt)
-					goto out;
+			if (refcount_dec_and_test(&b->filters_ref)) {
+				RCU_INIT_POINTER(head->table[to_hash(h)], NULL);
+				kfree_rcu(b, rcu);
 			}
-
-			/* OK, session has no flows */
-			RCU_INIT_POINTER(head->table[to_hash(h)], NULL);
-			kfree_rcu(b, rcu);
 			break;
 		}
 	}
 
-out:
 	*last = true;
 	for (h1 = 0; h1 <= 256; h1++) {
 		if (rcu_access_pointer(head->table[h1])) {
@@ -459,6 +452,7 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 		if (b == NULL)
 			return -ENOBUFS;
 
+		refcount_set(&b->filters_ref, 1);
 		rcu_assign_pointer(head->table[h1], b);
 	} else {
 		unsigned int h2 = from_hash(nhandle >> 16);
@@ -468,6 +462,8 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 		     fp = rtnl_dereference(fp->next))
 			if (fp->handle == f->handle)
 				return -EEXIST;
+
+		refcount_inc(&b->filters_ref);
 	}
 
 	if (tb[TCA_ROUTE4_TO])
@@ -500,7 +496,7 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	struct route4_filter *fold, *f1, *pfp, *f = NULL;
 	struct route4_bucket *b;
 	struct nlattr *tb[TCA_ROUTE4_MAX + 1];
-	unsigned int h, th;
+	unsigned int h;
 	int err;
 	bool new = true;
 
@@ -560,17 +556,20 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	rcu_assign_pointer(*fp, f);
 
 	if (fold) {
-		th = to_hash(fold->handle);
+		b = fold->bkt;
 		h = from_hash(fold->handle >> 16);
-		b = rtnl_dereference(head->table[th]);
-		if (b) {
-			fp = &b->ht[h];
-			for (pfp = rtnl_dereference(*fp); pfp;
-			     fp = &pfp->next, pfp = rtnl_dereference(*fp)) {
-				if (pfp == fold) {
-					rcu_assign_pointer(*fp, fold->next);
-					break;
+		fp = &b->ht[h];
+		for (pfp = rtnl_dereference(*fp); pfp;
+		     fp = &pfp->next, pfp = rtnl_dereference(*fp)) {
+			if (pfp == fold) {
+				rcu_assign_pointer(*fp, fold->next);
+				if (refcount_dec_and_test(&b->filters_ref)) {
+					unsigned int th = to_hash(fold->handle);
+
+					RCU_INIT_POINTER(head->table[th], NULL);
+					kfree_rcu(b, rcu);
 				}
+				break;
 			}
 		}
 	}
-- 
2.55.0

