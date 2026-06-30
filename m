Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE82DEA75
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808950; cv=none; b=K3810z81zhC/5cUcO3KyMxcAMvu/IkT/oYV5XiSXLUR5fK5LG5euyI266vKR8DIaLq/lkG+tboRZlXLCUwUWZVGhWWmrGL3RfBUXfii8TqxA5zKf2KDjyHTpP/TnqARfjNcVnOW3xmzdYV1A62otmZHc6xD9orNY5kSgRCBDUdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808950; c=relaxed/simple;
	bh=j8zqaB7T04hBpqZcwzgtw7u5iuAAhaaqsYCQfcZUNBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cT7n7+5BS6uzsJVEpfTIQ8Wed378Jhx9JqUGhw+iL6A6f8feMj4BuwKFaX05KpYx7HqhVjRERsYLPsKn4xMJ1HlNiFiUImFmPfgi8cUXuwSUqnQlUxbWObggq3XIg0eHpom6tlWskGF8dibplnRcZJpU+H/qnBkHmF/py9rS5O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJFsstUP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJFsstUP"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8424b00710aso2972715b3a.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 01:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782808947; x=1783413747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7EeC63NFPzYUKRtuwuPqf7M5up4qWTV1M2HoxWcbP8=;
        b=UJFsstUPwLa724WNigvYHuUP+tM480v4gNbcwvmcolSgODF7338lMEfnbHD6cGk/Ym
         7S9ZMWNUyIOTc0lQkPM+edE2wZo+469yFBuhvbbSA+Z6ILYCl3CgWdHamALQNnJLxiUG
         e5FpRhdkuwhyQhrDWyY6ZI3oazdVxEcMHYqCPswmrI7bQZH67Lrh1SHCtk3Gu2BTRwPa
         xXfaou3yadsV1000g8ipqNgOnDj0e6yzOppaPl5Ou2gtJIDQwYbL/LZvgkIXha4Vn+6D
         df7bljFeXUI2qTFw/SLk1D5usNVwqFz4a99B74cNY7PGvgifYzP1lIbpm1LeA7C19si+
         02Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782808947; x=1783413747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7EeC63NFPzYUKRtuwuPqf7M5up4qWTV1M2HoxWcbP8=;
        b=eQDURGnaI9fv+NlbQ0Ij5fVHDb2OFaONPTbCV3zNo5Ucg8vYKlcbKEa4FObgVB/qCb
         lOURLoeudG4Q61GogunJkF6cR+NAcXnBwOzoxTVuFQWLM5UoxjpH6gltANN9hX48R3e2
         0JzsL5uI9GaKRetDIDJs9gVL+fY+ZdQawbrmRI7nDJWSHTsg+9j+4oGNS8USbIL9ugu2
         9UqtYRZ+MmKXWTvlkkX3YKElAt+i8Azh/KEbx73OVqwoTOxHkLgvl5HHtHRrsuhACWkI
         /sUXZQu68x7lMoKTxHA83MerDDlgYR5vKELleqdaccXSgGHkUW1h23pqDzRvXYG7MSQu
         VOgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8PqyClRpfigpU332QARbKRW+SpJS4nGQW92tDtLXEEKAzO5rytNNM40/KI2AaispZ+LEZ0r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQPaAvxQTRXYsrEY4eDngVWd93NDUjvq5RBVGErbkY5EWFn+t
	MXWmzUE/RSn9iLL1lY5Ax2qA6S3gPwsMtkqkd353AwL05kwUVfH1/2bQ
X-Gm-Gg: AfdE7cnXyp1Fgmw+d9L9K5cuKS3pDeoUYwXL+JA2hJ6kvf23I/aQeqSVN1reemuCAvU
	wEMH6lYPuA16wNOcOZGNTdFiWYw4mGupc3stfv4k5VVFalC8WZ9FNBELIivX4xm/DERHPOxi4O8
	hJLLWro+owvPUjHXfvRPXHtuYxyJd6sZcTbarmPdVQ5gn0sFzBNQtchV3vlyiKt6A8IaklKfkWg
	G88aHo8RKx5OBmCkH5QWaxo3OtkYWsJ/RTBxmVbtcWVxTbEgT35b4OvmTJ9fcZRDSn1zd6jmFrS
	VRjGkqxUTcd5xvc0e3D0S3+dmoaeyKWykclA/jyDv22eTQSJ5qOZoq+Ngy1TlacYTQJ75QQ5fkT
	mPr4rseP2EABT5J5YTz4PffXwK797lgtZVGhSg5UT7SI37PKWA6kG2KP4ogcN5iDxRH8AjBbIdL
	huOMrx9ivEiyXR8Xx13SfrUE63SjoTlobjkKULjg==
X-Received: by 2002:a05:6a00:3e21:b0:845:cd11:37e8 with SMTP id d2e1a72fcca58-8479f1155ecmr2288803b3a.24.1782808947354;
        Tue, 30 Jun 2026 01:42:27 -0700 (PDT)
Received: from online.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a02d1597sm1456636b3a.31.2026.06.30.01.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 01:42:26 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhangqi@xiaomi.com,
	baohua@kernel.org,
	zhangpengfei16@xiaomi.com,
	Pengfei Zhang <zhangfeionline@gmail.com>
Subject: [PATCH v2 net-next] ipv4: fib: fix route re-dump in inet_dump_fib() on multi-batch dump
Date: Tue, 30 Jun 2026 16:42:20 +0800
Message-ID: <20260630084220.2711025-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inet_dump_fib() saves its progress in cb->args[1] as a positional
index within the current hash chain.  Between batches, a concurrent
fib_new_table() can insert a new table at the chain head, shifting
all existing entries.  On resume the saved index lands on a different
table, causing already-dumped tables to be re-dumped and the
originally suspended table to restart from the beginning.

Fix by storing tb->tb_id in cb->args[1] instead of a positional
index, mirroring the fix applied to inet6_dump_fib() in commit
9facb861dc6b ("ipv6: fib6: fix NULL deref in fib6_walk_continue()
on multi-batch dump").

Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
---
v2:
 - Drop Fixes tag (not needed for net-next)
 - Fix variable declaration order (reverse xmas tree)
 - Reference IPv6 fix commit hash

v1: https://lore.kernel.org/netdev/20260626085636.1524451-1-zhangfeionline@gmail.com/

 net/ipv4/fib_frontend.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 42212970d..248895e7e 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1019,10 +1019,11 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 		.dump_routes = true,
 		.dump_exceptions = true,
 	};
-	unsigned int e = 0, s_e, h, s_h;
 	struct hlist_head *head;
 	int dumped = 0, err = 0;
 	struct fib_table *tb;
+	unsigned int h, s_h;
+	u32 s_id;
 
 	rcu_read_lock();
 	if (cb->strict_check) {
@@ -1054,29 +1055,28 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	s_h = cb->args[0];
-	s_e = cb->args[1];
+	s_id = cb->args[1];
 
 	err = 0;
-	for (h = s_h; h < FIB_TABLE_HASHSZ; h++, s_e = 0) {
-		e = 0;
+	for (h = s_h; h < FIB_TABLE_HASHSZ; h++, s_id = 0) {
 		head = &net->ipv4.fib_table_hash[h];
 		hlist_for_each_entry_rcu(tb, head, tb_hlist) {
-			if (e < s_e)
-				goto next;
+			if (s_id && tb->tb_id != s_id)
+				continue;
+
+			s_id = 0;
 			if (dumped)
 				memset(&cb->args[2], 0, sizeof(cb->args) -
 						 2 * sizeof(cb->args[0]));
+			cb->args[1] = tb->tb_id;
 			err = fib_table_dump(tb, skb, cb, &filter);
 			if (err < 0)
 				goto out;
 			dumped = 1;
-next:
-			e++;
 		}
 	}
 out:
 
-	cb->args[1] = e;
 	cb->args[0] = h;
 
 unlock:
-- 
2.54.0

