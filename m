Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766294DC552
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605375; cv=none; b=Opj56s27GJ9RK+5ATTlhoKR3XWZDsiSkRwzYmUqwG8/egVUzKfWWiwsodgeJPgIs/8B66OmAaGnZc2kb8WkyOJ++Sq+WbIrBoZifF0TXMr9+Ipi8vcRJMUC0EUhIL6DdbWusV3hyGaWBxjM5CHdAAnZurt3gDNPufomxn1dhurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605375; c=relaxed/simple;
	bh=YA2Wm1A4Qv7haJ3jQwkBbi+1aXa908XRcduIl6boq6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUTNDc785wPSdj0qzAM/O60Qr4QO5T5Fx85QvoGWAGWhcxaNHLmWmXYZOXQnL0Ii4bPKBnm791sEdtrFijsSe5utwmw6kANuJ1il4YkBGJakiWCOVvkxtFtd18I7A1bpEgafHBBA9f05ru2lnADieT7VO9TyLLuHl9d9YkLKjE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M19acIDx; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M19acIDx"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5ccf4f65037so1562184e0c.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790605370; x=1791210170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pn16sVzXVlIUSfu9GdAYXGnqwMg1E4Z0EatyLn9hdGg=;
        b=M19acIDxictBHbpBjz8YQkUcl4RA+F/WD7I4MvbKtqIbceVb5raax7dm/m8yisJ+0o
         t/tClP5tFd+0zAPYOPNP7pIgc5RO7/fNWVkY/esmEGa/1x+Ewa3oaXvyf2MeMGJOv0Da
         lw9k1W9G/ZLSA1YzdDie2k8yfyFOhLQnh8shB4BbHr0ac4+q0NxQUtXsYs0YVAU/N4TY
         GymmgXCt1cGQz6vVM6A6Jk0Oz/8+Uzea5yzZiTuso/QwE++jq527nks0gYtFREyLdfFL
         l2QD3a80dCLlf/B5X+sH2SzNrD5YYunLB40BBksMLRVzqfpq/rgvA96iWDnT2raBFmyv
         Ta2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605370; x=1791210170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pn16sVzXVlIUSfu9GdAYXGnqwMg1E4Z0EatyLn9hdGg=;
        b=ch7wNO33ufFiFyej7/DlUUapL5Otnn5nzecvfW/eweBN7cMQEM5TXz9l58GN3ZI9F7
         a6pu3eUnO9g/KEnfp9WJH3nyygKGJMA4RY23r39miXAhfmoOJHz2GRaItC2lHVbSxDql
         sT8UwKcvWi/9iozp6ZT34JgstL3q9h6YqNXA9ym557omCNVYyjw2wiareQHXUz9Ef+8d
         ri0j0NcW3VUz4i8MK7IexC6eTMNYYX1rXwLsaXGgTLoLlmH97uEnTwepgGBP6pTk3QZx
         XOf1V6N8e4i+n5uTPufpz3rHf2sPTsn6kKG7BXPCux4wTpw0M6ThWjwBRccUsBg4TtoW
         4m7w==
X-Forwarded-Encrypted: i=1; AKwUvBwMxIReYKKIabfDagL6YTMwtSc+DKJUnhC+kbSpkRp+Xx3P4f7fh5Di9kxgMm/g08rtVwdqOGY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkm67/si3LYeLK/yqXVke2+GRfTVyigpp65ysRsJb2zQu4JKND
	Buab6OarkJbEvJB7AOT9BulkxA78d7DUZCmj+QVxZW53hQbvzgXI0y9U
X-Gm-Gg: AYBFou1wOg+3swtVsvajX6Qecs1C+6RtJLwxdf6tDSG2PMCPz72xFh/7GnFZQGGnYxW
	zO9RU4JsjrFDy1lVdtxXaHjK6zwP4F+ysupm3tRaBPjJMKeTR5mh4MeczI2ke8Iu2OlpRSGbs52
	T/nFMiqQfEy9pk8YwOwshFrPFPuIv07W3nKSPMe7a9EwTvR3R2ptlSp4Qkp1xGH9h6hC9FAVBu4
	Hj/+T/xC74aPH3Hgg79wDfWiX0oxfMuIsRDICC3Ow9WQK5hJ8sw0HkPwdSS5GSWkfJrfnzd3GEQ
	hhXRaCQOKJt7ohTVbqMEFF2iViryfNANuvvjFBUQyEXgjQVdtmK0nBWiwCt5f5spHl1Rs+cO57/
	9u4Wekoazw5TFXXndTM8wmZvgTzPWBBExyNOxzJ+89ZEug2wnFCPvoE3XqPHxTlDjtLK+sTM30A
	bOHApeexmcWjwCl7GbgqDsxLRuT61qG4mtU67pFxrRJTYYCdTZeMeIFpEyh1E/Hw==
X-Received: by 2002:a05:6122:2204:b0:5c9:c60e:5cf4 with SMTP id 71dfb90a1353d-5cb0bc5ed09mr6039888e0c.18.1790605370469;
        Mon, 28 Sep 2026 07:22:50 -0700 (PDT)
Received: from adriano ([179.57.100.10])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde615a356sm9019144e0c.14.2026.09.28.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:22:49 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH net-next] net: sched: revert tx_queue_len on partial qdisc resize failure
Date: Mon, 28 Sep 2026 11:22:33 -0300
Message-ID: <20260928142233.1131459-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the old length to dev_qdisc_change_tx_queue_len() and, when a queue
fails to resize, use it to restore the queues already handled.

Fixes: 48bfd55e7e41 ("net_sched: plug in qdisc ops change_tx_queue_len")
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/net/sch_generic.h |  2 +-
 net/core/dev.c            |  2 +-
 net/sched/sch_generic.c   | 15 +++++++++------
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index f35bd06a6bad..0ce97b4b2da1 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -720,7 +720,7 @@ void qdisc_class_hash_remove(struct Qdisc_class_hash *,
 void qdisc_class_hash_grow(struct Qdisc *, struct Qdisc_class_hash *);
 void qdisc_class_hash_destroy(struct Qdisc_class_hash *);
 
-int dev_qdisc_change_tx_queue_len(struct net_device *dev);
+int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int old_len);
 void dev_qdisc_change_real_num_tx(struct net_device *dev,
 				  unsigned int new_real_tx);
 void dev_init_scheduler(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index f660fccfc0db..57e1fa320d53 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10002,7 +10002,7 @@ int netif_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 		res = notifier_to_errno(res);
 		if (res)
 			goto err_rollback;
-		res = dev_qdisc_change_tx_queue_len(dev);
+		res = dev_qdisc_change_tx_queue_len(dev, orig_len);
 		if (res)
 			goto err_rollback;
 	}
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5eb0..8fd0fce23cc4 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1422,13 +1422,14 @@ void dev_deactivate(struct net_device *dev, bool reset_needed)
 EXPORT_SYMBOL(dev_deactivate);
 
 static int qdisc_change_tx_queue_len(struct net_device *dev,
-				     struct netdev_queue *dev_queue)
+				     struct netdev_queue *dev_queue,
+				     unsigned int len)
 {
 	struct Qdisc *qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	const struct Qdisc_ops *ops = qdisc->ops;
 
 	if (ops->change_tx_queue_len)
-		return ops->change_tx_queue_len(qdisc, dev->tx_queue_len);
+		return ops->change_tx_queue_len(qdisc, len);
 	return 0;
 }
 
@@ -1465,7 +1466,7 @@ void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx)
 }
 EXPORT_SYMBOL(mq_change_real_num_tx);
 
-int dev_qdisc_change_tx_queue_len(struct net_device *dev)
+int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int old_len)
 {
 	bool up = dev->flags & IFF_UP;
 	unsigned int i;
@@ -1475,13 +1476,15 @@ int dev_qdisc_change_tx_queue_len(struct net_device *dev)
 		dev_deactivate(dev, false);
 
 	for (i = 0; i < dev->num_tx_queues; i++) {
-		ret = qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
-
-		/* TODO: revert changes on a partial failure */
+		ret = qdisc_change_tx_queue_len(dev, &dev->_tx[i],
+						dev->tx_queue_len);
 		if (ret)
 			break;
 	}
 
+	while (ret && i--)
+		qdisc_change_tx_queue_len(dev, &dev->_tx[i], old_len);
+
 	if (up)
 		dev_activate(dev);
 	return ret;
-- 
2.51.0

