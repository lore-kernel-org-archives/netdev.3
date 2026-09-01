Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6BE375AB5
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 05:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238992; cv=none; b=UKrXZ/t1I6QUavzeGvRW2Fowhij6WyO8vl4pnBo1sT7KSONwnhQ2cp+i++C2bAGHLha23XB0IbdAq9zsRAyr1noywPIVje+++5FOWw8ks/PzT5uGPIZG4oyVopROusaRxAJ7teqhm6Wgsnzxyjwfvm5cSOairGlll/+FXnaOT5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238992; c=relaxed/simple;
	bh=mxLAjIGvo/CJp2UIrwHx7VBoRPp28nCjUt1T9FBm2jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bs2VSdrbCLNNq6SROSxUUmF8FCBHl/hqcgSIXi7UVBA/JOWQRVYMO5Ti0tYRmrfQS2y7pCiKRnftDOh4cQofO9EG1Wza5x/DL+4vH56uNjAr7vBAforg+W+wO8LxgJ5Kzkhts1pgiudb1vSpOECtQAX6y8bMxQFa4UUlbeI8sjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=imWNqMMc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="imWNqMMc"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9e7391839cso589925a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 22:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1788238986; x=1788843786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ZOAuf91GeJPRlB4hQQIOwIR/2cbyKo6tpg0ZFIeQ7c=;
        b=imWNqMMcYbC9Q/LCScKrr7E/IWOG/5BP2r2ix4z4T7h0gZMYLyaQQkZvuIidzl4Y00
         I+NyTROsoqrncdHjlxI5OXRza/NjUjX22GFA6qaMq0pIvbugo6ym+zpPkq3PMaHPSq9i
         D2BdFdfBWF1T+got1hsLt3K/V8EWc7H3fGDec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788238986; x=1788843786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZOAuf91GeJPRlB4hQQIOwIR/2cbyKo6tpg0ZFIeQ7c=;
        b=dC93LKq/q7gHxbHLGaDksuwpLdV64RL3qJ4dpNqbnICFXbVM+djGWAa7flDxoIUt7q
         nTO8PUUCW/ha0Sw2jk4qPgRU4UCr7tC2tR0s8xRVdxski21s93mJ5fWk1bzF3ao9B3zS
         r6vgBxf8o5wIrTeNSO0MSDJ1ITk1rYwDhsnMITNYJAJ6nle6mT2r+JjSRNFem5+xYRPK
         I55s0yJKlNeseUGy9x8Y5HtlnLj8YsI9o6sPrRscish4ozEkqeokYhl9LD9BkfX+WsnU
         mnNOsxXUBCaz/RIDJn+GSp+62M5Fu74aj0xrCGHwFaVfGZmbHTx6/rqL/oyyrqw/N5+I
         9sgA==
X-Gm-Message-State: AFuF++kl+ouhNgTz3z4l5hMpYD8ShOnpr6K95RcfpwGIpL58b4yC9dZa
	ByZ5FCRNcapP5kLyJTk76cdoSPiz2HbaqFjgnNygrSKGLN2aARiPuNVwiLhtEPrKyzBUgalUE5Z
	sZDB/dUJdoCkT
X-Gm-Gg: AR+sD13JBsBHy1UebmryzgaPuSUVU1/fdCeQI8HViWcJF/A7pCP4KH81KHV6mcCRvY7
	V4mu9jCRNtJyQVidkNiT2pBUN5yysKQy61jX1pqjmFdO7p0urBQbdKiKpZWzXKVZBMpYNfjDzbn
	8WMhEsbxuBnDC6d2tW8nw2iQ3jMvCtm0rQAZ8pkHIGXcF0+7WMUB/CAKnW/fiFY0CLewg3kF5Y+
	dHq0q+Yrnn8dFcKnFRVIMpHuo/KoFgj0e+Djxp1mmeiR6kUzi89EaSoRHRkQJb05kFrEZUUjFnz
	+C508UYvp997SHJlsHTHoPwlWjLg1vSr4iTo1DIpH+RmQKlJ+j9x0Bo4s5HfPrdMEp3/e7FmIUG
	JIbx2VkK3EMKosCxhb/EsfddWqtdiUaAg+PyOlqE+MR/szlJuA5CYwk6q3YZKBbx+Hxb8yEF6MU
	FsT5vGiid5Eaih3PMPk6hWhOc86M3QMY+9l1DrA92oanQmzcqenFX2RzPf3naaSv10Pl5q5ebVg
	I6dRUcMtXkQADYc7T/CqRx8V6CWGNyZThVAYWmsWAxR
X-Received: by 2002:a05:6a21:e081:b0:3cc:ebeb:3efe with SMTP id adf61e73a8af0-3d26720dffdmr41931451637.9.1788238986109;
        Mon, 31 Aug 2026 22:03:06 -0700 (PDT)
Received: from DESKTOP-2P4OM44.localdomain ([175.195.197.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36f2a29sm5558745a12.31.2026.08.31.22.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 22:03:05 -0700 (PDT)
From: Seungwon Bae <qotmddnjs@ajou.ac.kr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Seungwon Bae <qotmddnjs@ajou.ac.kr>
Subject: [PATCH] vxlan: serialize nexthop fdb_list against cross-device concurrent updates
Date: Tue,  1 Sep 2026 14:02:53 +0900
Message-ID: <20260901050253.47197-1-qotmddnjs@ajou.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct nexthop.fdb_list is a per-nexthop global list of the vxlan fdb
entries that reference an fdb-nexthop.  vxlan serializes it only with the
per-device vxlan->hash_lock.  When two vxlan devices reference the same
fdb-nexthop, their entries share one nh->fdb_list but each device takes
only its own hash_lock.  vxlan_cleanup() (the aging GC timer) runs in
softirq with only its device's hash_lock and calls vxlan_fdb_destroy() ->
list_del_rcu(&f->nh_list); a concurrent list_add_tail_rcu()/list_del_rcu()
from the other device corrupts the shared list, leaving a freed
kmalloc-128 struct vxlan_fdb linked on nh->fdb_list (use-after-free later
consumed by vxlan_fdb_nh_flush()).

On CONFIG_DEBUG_LIST/KASAN this reproduces as:

  list_del corruption. next->prev should be ..., but was dead000000000122.
  __list_del_entry_valid_or_report <- vxlan_fdb_destroy <- vxlan_cleanup
  <- run_timer_softirq
  BUG: KASAN: slab-use-after-free in vxlan_fdb_destroy

Serialize all nh->fdb_list mutations with the nexthop's own spinlock
(nh->lock), which - unlike rtnl/hash_lock - is usable from the softirq
aging path.  Lock order is hash_lock -> nh->lock at every mutation site;
vxlan_fdb_nh_flush() keeps traversing under rcu_read_lock().

Verified with a KASAN + CONFIG_DEBUG_LIST kernel and an unprivileged
(userns+netns) reproducer that runs two vxlan devices churning
add + aging-delete on a shared fdb-nexthop: BEFORE = 490 list_del
corruptions + slab-use-after-free; AFTER = 0 corruptions, 0 KASAN
reports, no deadlock.

Signed-off-by: Seungwon Bae <qotmddnjs@ajou.ac.kr>
---
 drivers/net/vxlan/vxlan_core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ac88d1c85..2a427e89e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -843,11 +843,15 @@ static int vxlan_fdb_nh_update(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
 	}
 
 	if (old_nh) {
+		spin_lock_bh(&old_nh->lock);
 		list_del_rcu(&fdb->nh_list);
+		spin_unlock_bh(&old_nh->lock);
 		nexthop_put(old_nh);
 	}
 	rcu_assign_pointer(fdb->nh, nh);
+	spin_lock_bh(&nh->lock);
 	list_add_tail_rcu(&fdb->nh_list, &nh->fdb_list);
+	spin_unlock_bh(&nh->lock);
 	return 1;
 
 err_inval:
@@ -938,6 +942,7 @@ static void vxlan_fdb_free(struct rcu_head *head)
 static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
 			      bool do_notify, bool swdev_notify)
 {
+	struct nexthop *nh;
 	struct vxlan_rdst *rd;
 
 	netdev_dbg(vxlan->dev, "delete %pM\n", f->key.eth_addr);
@@ -956,7 +961,14 @@ static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
 	hlist_del_init_rcu(&f->fdb_node);
 	rhashtable_remove_fast(&vxlan->fdb_hash_tbl, &f->rhnode,
 			       vxlan_fdb_rht_params);
-	list_del_rcu(&f->nh_list);
+	nh = rcu_dereference_protected(f->nh, lockdep_is_held(&vxlan->hash_lock));
+	if (nh) {
+		spin_lock_bh(&nh->lock);
+		list_del_rcu(&f->nh_list);
+		spin_unlock_bh(&nh->lock);
+	} else {
+		list_del_rcu(&f->nh_list);
+	}
 	call_rcu(&f->rcu, vxlan_fdb_free);
 }
 
-- 
2.43.0

