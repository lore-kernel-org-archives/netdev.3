Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6D3B8124
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808906; cv=none; b=NfwyJ3czCl0Eu+90CWH11IOvO7V78nwplRPAieOe6xCDwDA5CKaOX0/3Lt4t8tQ06EhZ0cPnqRqT2C2atCID40gZr2Q4+RrJ/AioOF945eWh7KqS8RcGB2dAO/FyJ8dJ2ONgZxxSVsL/9dajqMqPRDBkrTBXbjXPAaOEGCzhFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808906; c=relaxed/simple;
	bh=7Jy5TAydXwue+f/1o9MjpjlR+URu5Uvu059mzYb7is4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOg1n5u3IRVpKmIqIugE+HOnty5/7AIKneHX2qQ76kmCzvKoni3ihojANEVchmeca7aCzvygx324e9q7b0fhingabejIVC/EZ8YD8fkEksm36wyqH7aMprgCV6o1sDgXkgtpHk7mmsbJ5qAbmpmN0hb+NpADCjsw+CfADqco/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=T79I385m; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="T79I385m"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-836c8bde2dcso17374587b3.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788808904; x=1789413704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08pvip6QSZqdrXwRg7+z8fnfvQkab4FogxIdVMviOtk=;
        b=T79I385mp09wRrr2T9wp1PLt0z2sQ4P5tdbpNs5BKKEC3avpLWB5lBGTwVSJlYEtoI
         6j4HOcLn7hdpQBi2tZ/zlVHGdUBSZRvoGV/jayrL7A5EJfKFIWIICtW76KN6MVctwUsv
         AKoPsH4ejtM1UMhwxHZCAVTlOiqs8IW2jGdgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788808904; x=1789413704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=08pvip6QSZqdrXwRg7+z8fnfvQkab4FogxIdVMviOtk=;
        b=FFF+xyeVQ/75TCY0cQwXMQXzoi8+V6hECTeB2+fhEVSamJGDYzx7gAzCmsI07P8R2o
         CUgO8G1vPHYXSlg0xhq1Bk66I4D8zzh7YWkGo/V69JWGN7+Cv1CfQ3ZGzVDQDxqh+/8C
         Xnl9vzJ8JNHMM256qr0m8ft1n8cJPt0nSCOctqYUjvI8YkMZ5G10g7ntvtjgEx2ukZUT
         m/7GEtGHO9fzLHA9RH3O0JehCVt+WVrQtKcoU1pebYccmOyddze4JaryJf8AACB9pRr6
         Li1R47Rt0rJEqnCJ5gukbcE6XtBn90pITCY73NY6F6XEnL349xDjAUAE7q9EtRnJYlfL
         ShCw==
X-Forwarded-Encrypted: i=1; AKwUvBwCVLgShVFRsPmiAK7lKfHXACU4HBRoNc30J9zi7lf+TuHrXC85nNfWo6tLTbz+0U+1wagRjyM=@vger.kernel.org
X-Gm-Message-State: AFuF++liYrBGUxq5FQ3ySezofAHoeVh5KwTxjJX6xnX2NwevOhsQAtAp
	zNIMDjYhelJfYFuRNVx1xJnDSVz1IwG+lYgQoiVN8f/BN7TRn8q/d6b7FOhC3o9E4A==
X-Gm-Gg: AYBFou2MHbJU9NQ2TWfv4RE4Ko9BopoVVuX1iRR1MQWobikQUgffhCE34P+L3A/9brw
	W2Y4VRGU/FhRIyLNP7aqQAC+hu6auVJBupthtMzjFbuE6URr37lS+509r5++qACLzmxWzUo9FlP
	IdN5ilSW5fbEcEl4yGq1S6rcnGN/xtCT6vs+RjB4rXaDyMpHmLUG5vlrErT692St+eKjOPlyxFZ
	qkTMXDKzo0fzDH2QbaAvpfqJ2tq9xhdYMJTmt1R8McUFATG/7Ca57XvpBAQTa/qWf/nlF3EXBk7
	DHNRGCqtQIm3WH6pnEBdEFxS5rxnm+aYrPdo6PIfxF81BqfIgcooZ3Ae3ZEJ4nwH9sGtUWQ0zP6
	zdy+qwfhqlXJNUOoMvY8S182uNnxuLFZw00DgdHUFI74GTmL2LO3NO+/i9jeWeSqfLyho8gtZaJ
	TVCjurhaIumsCOLzfqqbXY5LAZdyU6+lG5olbg8cVCMXSS
X-Received: by 2002:a05:690c:38b:b0:87c:800c:2eb0 with SMTP id 00721157ae682-87c800c2fdfmr9617097b3.14.1788808903753;
        Mon, 07 Sep 2026 12:21:43 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62bc77sm76546097b3.39.2026.09.07.12.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 12:21:43 -0700 (PDT)
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
Subject: [PATCH net v2 1/4] net/sched: cls_route: free emptied bucket on filter move
Date: Mon,  7 Sep 2026 16:21:30 -0300
Message-ID: <20260907192133.2639067-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907192133.2639067-1-victor@mojatatu.com>
References: <20260907192133.2639067-1-victor@mojatatu.com>
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

