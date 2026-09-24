Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF63AE6F5
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231176; cv=none; b=tar5gTzEM99aVkNRpfKbO3LlW2NS2ljMylsWow6oGZ4TIjgZOwm4wVIlyfsOgoZJMcscM1HhJXAoViMHJpyp2XaunAyAkQePKS3Wg/XilQFJdh6bHBn8dxhX7qDFL3toU13yA8hjxdY/n8AZHKj1//wTQSsAKJX8Cretuc6UhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231176; c=relaxed/simple;
	bh=E08VtgF/rXHRCxE8eUUJsJea7kdObGQcooH9Heh0p+Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MfQ75rIZFQEpriedQxZ4uce/yZ4VdAhbsFXXnpHsI+gmEGLUkbfqIA6eieNBSN7DCHtDHecjouJCPoBo6Hzxwq/6FKrHDyLGKDt2z6ZzRExzrf015vkhZN3Y6BVf0hm5KF8RlCWVvBpeJzgowacpxFtinYtdjmmA/RI5mq+zy1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sunnytiwari.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EIuk2amP; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sunnytiwari.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EIuk2amP"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db3d832827so17500995ad.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 23:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790231174; x=1790835974; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+dxwBYKQFsgxaYrVWyrsAEec4E6upKeICubRLFxRf3w=;
        b=EIuk2amPAyZpvuUFJU1QC5IlNMthcFN6yb7yieT/kmsMl29JaRZ3i3LdusBm9uls9R
         wCgSShZpC8JgLHRsaYUx6xSTuuIyF/vEehh0gEJ16xacxOcQLXbyygsE3Bj1yA1R/C06
         mSGetFYrQdBjVil4GClCe1FHYcQz2c5X9l/cuVsFZKD7AH+7OySTVyFJrLhZV5+6BJ/0
         lNvoFpYUcobBXkfIxB+Tm0XU63fKj5XNCyoAHLwraxfm3wEzdYgIciGcOTCRIN5xreV6
         /V1k3p8qzCaGGS/t+lRnV8ylDxuIETJ6r0TAc/8GUUoKtN3BVB467y+lzy205OeOZ+Er
         JbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790231174; x=1790835974;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+dxwBYKQFsgxaYrVWyrsAEec4E6upKeICubRLFxRf3w=;
        b=pcgL+GIpOyG1cD8i0tTayu5kSmxx3d2n4rPhw9E7s36F9hzTIU1qsWS2yYoqNRwsWq
         7/abmwzhoayD8hOPbDPVbiilGvKxYyhtfVpDJ788MwgK0zHy/Pa44mii1mFfBIuYuVbS
         Wc2pNIwPU4bk7bqXMAM3E+WPrrE8dZmBNCul3zcWGsuqNqB7TQ47rk+UbOKfnZ2cq0V2
         OQ4K0LvKz9ZgAdMM/1oSqV8j5n2/k3LfMky/VohaL5wkCa/cKCD3+0xBQLCPtRgLHUbT
         OUrsj6SKolJP1ZC7cUVhg96RsXtUTSZ3k619OZ1hkL7MULxhZ/3DrEVo0zhnIYJkxxpm
         i0Fg==
X-Forwarded-Encrypted: i=1; AKwUvBzQwR5M3gAe18ZBM18LyalwmhwsYDoaGFI+HpCnaxhKFRZVf0QHEBmKDkjAborgVoZLqaK07Hk=@vger.kernel.org
X-Gm-Message-State: AFuF++lR1+By0KpUARiCNJdBEzKZzBQdnVb2KsuseMXgx0eDVK0Bc5ab
	FCHsqhm6ATCTatWm9BewgIJjyuRBR9kXHhuJzQaNTeeNPWUE0hKmzXAzA2n0uT8IX2g8D/ErdjC
	CvjoGbyNtI3+2sptZL+pxUyRt2g==
X-Received: from pldu18.prod.google.com ([2002:a17:903:1092:b0:2df:8053:e258])
 (user=sunnytiwari job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1246:b0:2dd:c100:a5dd with SMTP id d9443c01a7336-2df7dd6c414mr12253515ad.49.1790231173881;
 Wed, 23 Sep 2026 23:26:13 -0700 (PDT)
Date: Thu, 24 Sep 2026 06:26:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20cbfc32678019daadd3c67fd75262b8264aa180.1790178801.git.sunnytiwari@google.com>
Subject: [PATCH net-next v2] net/rds: replace tasklets with workqueue
From: Sunny Tiwari <sunnytiwari@google.com>
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>, Allison Henderson <achender@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: rds-devel@oss.oracle.com, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Sunny Tiwari <sunnytiwari@google.com>
Content-Type: text/plain; charset="UTF-8"

Convert the deprecated send and receive completion tasklets in
net/rds/ib to BH work items queued on system_bh_wq.

In rds_ib_conn_path_shutdown(), replace tasklet_kill() with
disable_work_sync(), and call enable_work() after destroying the CQs so
the work items can be used again when the connection reconnects.

Assisted-by: Gemini
Signed-off-by: Sunny Tiwari <sunnytiwari@google.com>
---
Changes in v2:
- Use system_bh_wq instead of allocating a custom rds_ib_wq workqueue,
  dropping the net/rds/ib.c changes.
- Use from_work() and disable_work_sync() / enable_work() instead of
  cancel_work_sync().
- Link to v1: https://lore.kernel.org/linux-rdma/6b07af04b3ba66a09009e1a0a7b98ec5ec85d3a0.1790109248.git.sunnytiwari@google.com/

 net/rds/ib.h    |  4 ++--
 net/rds/ib_cm.c | 29 +++++++++++++++--------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/net/rds/ib.h b/net/rds/ib.h
index 5ff346a1e..190122636 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -159,8 +159,8 @@ struct rds_ib_connection {
 	atomic_t		i_fastreg_inuse_count;
 
 	/* interrupt handling */
-	struct tasklet_struct	i_send_tasklet;
-	struct tasklet_struct	i_recv_tasklet;
+	struct work_struct	i_send_work;
+	struct work_struct	i_recv_work;
 
 	/* tx */
 	struct rds_ib_work_ring	i_send_ring;
diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 6e3110a04..3ebe13d00 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -253,7 +253,7 @@ static void rds_ib_cq_comp_handler_recv(struct ib_cq *cq, void *context)
 
 	rds_ib_stats_inc(s_ib_evt_handler_call);
 
-	tasklet_schedule(&ic->i_recv_tasklet);
+	queue_work(system_bh_wq, &ic->i_recv_work);
 }
 
 static void poll_scq(struct rds_ib_connection *ic, struct ib_cq *cq,
@@ -279,9 +279,9 @@ static void poll_scq(struct rds_ib_connection *ic, struct ib_cq *cq,
 	}
 }
 
-static void rds_ib_tasklet_fn_send(unsigned long data)
+static void rds_ib_send_worker(struct work_struct *work)
 {
-	struct rds_ib_connection *ic = (struct rds_ib_connection *)data;
+	struct rds_ib_connection *ic = from_work(ic, work, i_send_work);
 	struct rds_connection *conn = ic->conn;
 
 	rds_ib_stats_inc(s_ib_tasklet_call);
@@ -319,9 +319,9 @@ static void poll_rcq(struct rds_ib_connection *ic, struct ib_cq *cq,
 	}
 }
 
-static void rds_ib_tasklet_fn_recv(unsigned long data)
+static void rds_ib_recv_worker(struct work_struct *work)
 {
-	struct rds_ib_connection *ic = (struct rds_ib_connection *)data;
+	struct rds_ib_connection *ic = from_work(ic, work, i_recv_work);
 	struct rds_connection *conn = ic->conn;
 	struct rds_ib_device *rds_ibdev = ic->rds_ibdev;
 	struct rds_ib_ack_state state;
@@ -381,7 +381,7 @@ static void rds_ib_cq_comp_handler_send(struct ib_cq *cq, void *context)
 
 	rds_ib_stats_inc(s_ib_evt_handler_call);
 
-	tasklet_schedule(&ic->i_send_tasklet);
+	queue_work(system_bh_wq, &ic->i_send_work);
 }
 
 static inline int ibdev_get_unused_vector(struct rds_ib_device *rds_ibdev)
@@ -1099,12 +1099,12 @@ void rds_ib_conn_path_shutdown(struct rds_conn_path *cp)
 		while (!wait_event_timeout(rds_ib_ring_empty_wait,
 					   rds_ib_conn_path_shutdown_check_wait(cp) == 0,
 					   msecs_to_jiffies(1000))) {
-			tasklet_schedule(&ic->i_send_tasklet);
-			tasklet_schedule(&ic->i_recv_tasklet);
+			queue_work(system_bh_wq, &ic->i_send_work);
+			queue_work(system_bh_wq, &ic->i_recv_work);
 		}
 
-		tasklet_kill(&ic->i_send_tasklet);
-		tasklet_kill(&ic->i_recv_tasklet);
+		disable_work_sync(&ic->i_send_work);
+		disable_work_sync(&ic->i_recv_work);
 
 		atomic_set(&ic->i_cq_quiesce, 1);
 
@@ -1123,6 +1123,9 @@ void rds_ib_conn_path_shutdown(struct rds_conn_path *cp)
 			ib_destroy_cq(ic->i_recv_cq);
 		}
 
+		enable_work(&ic->i_send_work);
+		enable_work(&ic->i_recv_work);
+
 		if (ic->rds_ibdev) {
 			/* then free the resources that ib callbacks use */
 			if (ic->i_send_hdrs) {
@@ -1234,10 +1237,8 @@ int rds_ib_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 	}
 
 	INIT_LIST_HEAD(&ic->ib_node);
-	tasklet_init(&ic->i_send_tasklet, rds_ib_tasklet_fn_send,
-		     (unsigned long)ic);
-	tasklet_init(&ic->i_recv_tasklet, rds_ib_tasklet_fn_recv,
-		     (unsigned long)ic);
+	INIT_WORK(&ic->i_send_work, rds_ib_send_worker);
+	INIT_WORK(&ic->i_recv_work, rds_ib_recv_worker);
 	mutex_init(&ic->i_recv_mutex);
 #ifndef KERNEL_HAS_ATOMIC64
 	spin_lock_init(&ic->i_ack_lock);
-- 
2.55.0.1082.g2b9226bbc0-goog

