Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6723B6BF5
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785562975; cv=none; b=jENmgTf6chTtw5EtuNMpBroL0TevFgxg+TS3l4cwuayK8VkhHB6L7zjKxPateYvwe6gtLBwjIb8pcY1gyh3uf7ALIfmx/eBgR683FCWq7oUXaOGLI+ScmtKip/RQOpMBkqYGLeDebdF1DIaw9pU+0YhVfw03BYj1x/pKlxwe7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785562975; c=relaxed/simple;
	bh=GALmEZvdh26PPGiAjWfxWB+e9ZYrjGLsH00RO4B1Xrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gl21O8FrjUjKu8YLkrRRcHUI55rPl8GTOejsagU8ZqEnDmNv7Vgbw9vaQUEGvL9fc3SaLRE+c3Tl2NYCAZwuIkcprsF9sS2k4gLGT0Bi649gT6Hbno2RqCHlVMBuKAPE3Ntc9YrJJoxldIQcCnF+Wo6NNjPOEbh5JOGMWAFOnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P71mzTUM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P71mzTUM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf420670bbso1529515ad.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 22:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785562972; x=1786167772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UYpVa28keFu2rtnNNRFvjEjsmc3FfTl8CCtVsMlnayI=;
        b=P71mzTUMNQzqQ9Bg8h+hYvh+09Ly5swIspPzZo8+X6afWF1D77F+B24/iM99V0UdF2
         g28LKUK1ceaYghCdYNMH0nCaVFSB9O9f/16i7bhIrcypE3S2uiE4AvdCx7G9mAQ2aOhX
         1oXufujMNviVN0GLSxsO1kiv/JDqxvuh+mQ2EVAIATJZvB5m72cw4PkyohX93fQvtdHF
         +SlbY/TeuT0JFe17UTlmrrvwQ++LjAyGARm37DXUvsPc/yPLttCLIpNrO5wg/pJLLqJ3
         2WoPbN1TsDcKafjTVRDXAwU+0fPTSaPcGcX+YL1/V8+L1Ay5SQTcZsIAcMop4Sh8CUCv
         NtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785562972; x=1786167772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UYpVa28keFu2rtnNNRFvjEjsmc3FfTl8CCtVsMlnayI=;
        b=a32z3u16YAbU1BEhs0PEsa6K6GgPiu47bQdA6DpFu8xArkEtlJCQHyk6SBCsG/dWZx
         x5DU7HJiF/OV2nLDQilo7Y6VnnlwRU1UlANLgWWzKkv8K6/oCpmu1HowZfGeECuLHoas
         tOcmcCxQUZgrTMWN/E8OP2i8DbzHGUD2GcgP7EuYLJ9GApC3zF0lzfJA+0A1p55bLH8E
         a43McMN8gNY2eI1Ilr3VRERieL29g6nGCoCFhgHQtNo/2kiSDehwlYi5PPegGsHn7FcN
         mXU0Wm6twm1moWqkV9bxoXM9mPzuq5WMlo2g4FnH0IVB9M6r0JfaREwAqvJwspx7Yj0w
         cm5Q==
X-Gm-Message-State: AOJu0YxUU4fAD0DBjbWuG3oIbHNBjOYrC02FpT9UT6oionpuwcUQwtFg
	0v3ujB0pfy3ntKkCfZ8BwO1FpNd2Xi+oSC/ryvWqNsgpesobvP1CVMVP
X-Gm-Gg: AR+sD10zp7OwswaE8u1JKQJAoxoR2PHCvh0npvqojX4t0SOqHZ2a15urPCHYJBkKNTz
	b1jSvZvqeGaqobT04+Fm67rGm4aXK9dZWUM8egHCboOF3GnlZvlvChXgqO93QcdrsP+KjFbJrG4
	vymtAGrAKm2TcSv2vSwNOLKR/T1YtKIhcJzLAm33pEFx5xRn2wG4rtSrk8Sfce3B13vkyzBbtg4
	Q+uA/D+bltPJxVKk2HVwyjC30OjbCaMe+yi+wgQnM7/xjkzx48ptNNV+yZLi6uz2RAZrTNoBynl
	w8k2X0m3SsHs9OVsTEHv8TWyBGdG/Dg1kgRI9Mc6IN+Cs1zbz8esUc8z8n5Fs4qkjNjDW9u5UK9
	L0T10zOLgDVZ18a61CrXcoh24zI6KNhGkvaA9CSroVpnzdWts0xAppj2oPsA2tlD/aGExFIbPOZ
	VJF0LEj3jJgVUWU5GhTjwOtQlr9IKnKsNYsVZKsRm1Vw67L44bnQLnWuHAGv20mX3FJVREFBqMC
	7YS0MsSM9JrZF60/ITlRzS/pMx2wP5rdG9OWwbcvCKOlMbM0ITR2G4=
X-Received: by 2002:a17:903:190:b0:2cf:7dfa:7f56 with SMTP id d9443c01a7336-2d052404e64mr34352655ad.2.1785562972005;
        Fri, 31 Jul 2026 22:42:52 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e70esm22692736eec.29.2026.07.31.22.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 22:42:51 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
	Dan Carpenter <error27@gmail.com>
Cc: netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net-next v4] rds: synchronize info callbacks with module unload
Date: Sat,  1 Aug 2026 13:42:34 +0800
Message-ID: <20260801054234.3535077-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rds_info_getsockopt() reads a callback from rds_info_funcs and invokes it
without protecting the callback's lifetime.  Transport modules register
functions stored in this array.  For example, rds_tcp.ko registers
rds_tcp_tc_info() for RDS_INFO_TCP_SOCKETS.

This permits the following interleaving:

  CPU0                             CPU1
  rds_info_getsockopt()
    func = rds_tcp_tc_info
                                   rmmod rds_tcp
                                     rds_tcp_exit()
                                       rds_info_deregister_func()
                                         rds_info_funcs[offset] = NULL
                                     free rds_tcp module text
    func()

The reader can therefore branch to an address in unloaded module text.

Protect callback invocation with SRCU.  Enter the SRCU read-side critical
section before loading the callback and leave it only after the callback
returns.  Clear the callback with WRITE_ONCE() and call
synchronize_srcu() before deregistration returns, preventing module unload
from freeing its text while an old reader is still executing it.  SRCU is
required because callbacks such as RDS_INFO_COUNTERS can sleep.

Keep the callback array unannotated and use READ_ONCE() and WRITE_ONCE()
for concurrent slot access so sparse does not have to apply __rcu through
the function-pointer typedef.  Replace the two callback-slot BUG_ON()
checks with WARN_ON_ONCE() and return without changing the slot on
mismatch.

Link: https://lore.kernel.org/netdev/20260720184955.3008978-1-nicoyip.dev@gmail.com/
Suggested-by: Allison Henderson <achender@kernel.org>
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Allison Henderson <achender@kernel.org>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---

Changes in v4:
- Use READ_ONCE() and WRITE_ONCE() because the callback pointer does not
  publish associated state requiring acquire/release ordering.
- Keep the local variable declarations in reverse-Xmas-tree order.

Link: https://lore.kernel.org/netdev/20260731160942.3245965-1-nicoyip.dev@gmail.com/ [v3]

Changes in v3:
- Use ordinary loads for callback-slot validation under rds_info_lock;
  retain acquire semantics only for the lockless reader.
- Drop the Fixes tag because this patch targets net-next.
- Add Allison Henderson's Reviewed-by tag.

Link: https://lore.kernel.org/netdev/20260727174826.135662-1-nicoyip.dev@gmail.com/ [v2]

Changes in v2:
- Split the info callback/module-unload race from the independent
  inc->i_conn lifetime bug.
- Keep the callback array unannotated and use smp_load_acquire() and
  smp_store_release() to resolve the sparse errors.
- Replace the two touched callback-slot BUG_ON() checks with
  WARN_ON_ONCE() error paths.
- Rewrite the commit message for the callback race and omit the unrelated
  inc->i_conn KASAN report.

Link: https://lore.kernel.org/netdev/20260720184955.3008978-1-nicoyip.dev@gmail.com/ [v1]

 net/rds/info.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/rds/info.c b/net/rds/info.c
index 21b32eb16559..31e7ad108459 100644
--- a/net/rds/info.c
+++ b/net/rds/info.c
@@ -32,6 +32,7 @@
  */
 #include <linux/percpu.h>
 #include <linux/seq_file.h>
+#include <linux/srcu.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/export.h>
@@ -68,6 +69,7 @@ struct rds_info_iterator {
 	unsigned long offset;
 };
 
+DEFINE_STATIC_SRCU(rds_info_srcu);
 static DEFINE_SPINLOCK(rds_info_lock);
 static rds_info_func rds_info_funcs[RDS_INFO_LAST - RDS_INFO_FIRST + 1];
 
@@ -78,8 +80,11 @@ void rds_info_register_func(int optname, rds_info_func func)
 	BUG_ON(optname < RDS_INFO_FIRST || optname > RDS_INFO_LAST);
 
 	spin_lock(&rds_info_lock);
-	BUG_ON(rds_info_funcs[offset]);
-	rds_info_funcs[offset] = func;
+	if (WARN_ON_ONCE(rds_info_funcs[offset])) {
+		spin_unlock(&rds_info_lock);
+		return;
+	}
+	WRITE_ONCE(rds_info_funcs[offset], func);
 	spin_unlock(&rds_info_lock);
 }
 EXPORT_SYMBOL_GPL(rds_info_register_func);
@@ -91,9 +96,13 @@ void rds_info_deregister_func(int optname, rds_info_func func)
 	BUG_ON(optname < RDS_INFO_FIRST || optname > RDS_INFO_LAST);
 
 	spin_lock(&rds_info_lock);
-	BUG_ON(rds_info_funcs[offset] != func);
-	rds_info_funcs[offset] = NULL;
+	if (WARN_ON_ONCE(rds_info_funcs[offset] != func)) {
+		spin_unlock(&rds_info_lock);
+		return;
+	}
+	WRITE_ONCE(rds_info_funcs[offset], NULL);
 	spin_unlock(&rds_info_lock);
+	synchronize_srcu(&rds_info_srcu);
 }
 EXPORT_SYMBOL_GPL(rds_info_deregister_func);
 
@@ -162,6 +171,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, sockopt_t *opt)
+	int srcu_idx;
 	int npages = 0;
 	int ret;
 	int len;
 	int total;
 
 	len = opt->optlen;
@@ -214,8 +224,10 @@ int rds_info_getsockopt(struct socket *sock, int optname, sockopt_t *opt)
 	rdsdebug("len %d nr_pages %lu\n", len, nr_pages);
 
 call_func:
-	func = rds_info_funcs[optname - RDS_INFO_FIRST];
+	srcu_idx = srcu_read_lock(&rds_info_srcu);
+	func = READ_ONCE(rds_info_funcs[optname - RDS_INFO_FIRST]);
 	if (!func) {
+		srcu_read_unlock(&rds_info_srcu, srcu_idx);
 		ret = -ENOPROTOOPT;
 		goto out;
 	}
@@ -225,6 +237,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, sockopt_t *opt)
 	iter.offset = offset0;
 
 	func(sock, len, &iter, &lens);
+	srcu_read_unlock(&rds_info_srcu, srcu_idx);
 	BUG_ON(lens.each == 0);
 
 	total = lens.nr * lens.each;
-- 
2.43.0

