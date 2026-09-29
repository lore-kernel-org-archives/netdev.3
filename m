Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490743C456F
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703465; cv=none; b=lwFlIoWuWor4K4heUXSy3mPC0RhGZhMIERwRe+J0QNDNKIylvNjOdJhh+3Up7yWPh9Zotd6CE7HD0BBUfEu252lI4Om/Dj+2UCDvat6xJvZ2vMvhUWtMgo7o5aLPgXnG6Il8fHSEYkgvJOwn7p1hRXHWzdp2nXrUHgZYLRaHzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703465; c=relaxed/simple;
	bh=DIoJg2nbqGI0AbbMvvT0cdi9VAuv9ZIUB+2oKOFih1c=;
	h=From:To:Cc:Date:Message-ID:Subject:MIME-Version:Content-Type; b=KDfF+aevthZienXZE6KLsKgPOgCiuDGAYMsLSDXPUhBEk7mf64zBxDhSTyKEVeorhIENRdasPNuiRG4ieehdahgZv1Ny2oPN51ZbAIlnptkb9WFduwWTJlz43G33mMWw0bTmr8XTsadtZAeJT/3/WAV4mQkBuABCTn2Sh1SRrrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxFFkOwn; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxFFkOwn"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a2adb9bc3cso1557513a91.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790703463; x=1791308263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :message-id:date:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MMtEMaLNv4OE7naboHkkwhRLjbqMr0IiSIVxyihv5gE=;
        b=MxFFkOwngJlNmfDr+gB+Igazk2PpZ7dzkXIazwTRqdN9rIcrJXXcuAKzbJzKFwi+FZ
         9I93U4l1olNjOJCit345R7c2k4FmEC+aa0tslxXys2b3/9un4JUuHkewK6ZVlQkXBmJM
         rYlp996aX/e48OU+bMdUgQyyLSJOcsiqhAO2Y/I/QR3sU2M+L1nrabUvVjpYZR8Pq3+k
         EgdiV4RMFC0w2ytKS8P0IfFzUORYXg2HWepKxivYgZK1bk2t5OZ3SrzEYeohn0yNG9OL
         TzmXj5UfM7l3bSHS+IDanq0a/tOsEpwFOhS9/CMFCTxVVW0N061P3epkI1W+LAdodUVP
         Ditw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790703463; x=1791308263;
        h=content-transfer-encoding:content-type:mime-version:subject
         :message-id:date:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MMtEMaLNv4OE7naboHkkwhRLjbqMr0IiSIVxyihv5gE=;
        b=kii8hm/Mp85yGzwsMEVg8kR7pztpC2EQzdy7cjkBTZExi8wIzFvcAMP/T3M+4cXB77
         7vd1HkRWvuWwQVKkosT5rGUSEAmdv8gxhRWuIznAqmx6nwmcdI+hmmovvmjP66UM32yP
         Zv+dShj5EjV2cyr4dTIWBNosRXna1Bf6rAYzABxBdTnIFUolw+CF6qn1D1DrdmFHFcWY
         DEAxUOMDDZqmyZIEXtxxf54XAoLvf0lUCBXTjFMOq2bmtMyHjFQQ6TrP/fspZ7Tnz2Ro
         uLR4iYgTV9FWAc8AGsFRl3aMnoRU3/Z07aH3Ku+aMCPGE+RcNWcJI6x4jJhPixzAPPbB
         wqcg==
X-Gm-Message-State: AFq9FYIqZdnkBaG9QFvT0ztD4vau4QlwUWCNX99EtIjlcjxDoCFtgGIE
	sqc1+oyeJ1xyE18JEpL+ssyo/QunWE3jnQ1oRLP5bsYIzp1ukWZUzd1EB9SArA==
X-Gm-Gg: AYBFou3AQjWTPmMoyhqYEXBMEfTlYS88baWl0b8RQixsj/5LBNRR7PQPW3UE6bI04Yj
	xnTvhxoX4JkM8s7UW0Vxx7IxviMCTSQG/P28nUkyGa3TEmn6m2PWgBjtW96+hAzlMUL9uZ6fLej
	TuUrJTZRnoqSX6NQNtG8qZ+pSYweL+prcTYvOqsq+yEQ2zWAhokkCinSoUe9ulTHEJWf6I0D3Hl
	OHzfowH+v2MEKu2wbItOe0DpX2CpB9CqzVzR7F/JlOqfSMNflICKbW7eQSKs/4GIjyMgMko7p9F
	N7KrpZqnvPGVex3d/Rp9BsVLNjVsk2l40sAgZBRIx6MbDUhbIEXvcJrXw6jqRq+tIQI+avGMOOy
	3haZv7P4PWqbkEyUlwnwXsJ8RO7F3hCd2rDNTuSDQ90prH9Rk4+VhLWBY/v/UmlT+Z6fdtEfwSL
	jVeHsLAnDX8cY1WFQIOPi1UHrQt9AKjHpfLqSYC52M3Gse78as1oMhdV9YauX34RQgDd47t6KDL
	96KVqSksmLELthkoK8V3pA=
X-Received: by 2002:a17:90a:e7c6:b0:3a0:e243:28fc with SMTP id 98e67ed59e1d1-3a4bfe94b3cmr36459a91.35.1790703463434;
        Tue, 29 Sep 2026 10:37:43 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4bf19bf4asm124187a91.2.2026.09.29.10.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:37:42 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
To: Ayush Sawal <ayush.sawal@chelsio.com>
Cc: netdev@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
Date: Wed, 30 Sep 2026 02:37:34 +0900
Message-ID: <179070264839.12871.11715792321728503844.idr-bug-51@gmail.com>
Subject: [PATCH net] cxgb4/ch_ktls: disable softirqs around tid_list erases
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

chcr_ktls_cpl_act_open_rpl() inserts into tid_list from the receive path
using xa_insert_bh().  The array is shared by the adapter's connections
and initialized with XA_FLAGS_LOCK_BH.  However, chcr_ktls_dev_del() and
the chcr_ktls_dev_add() error path use xa_erase(), which takes the XArray
lock without disabling softirqs.

When cleanup runs with softirqs enabled, a receive softirq for another
connection on the same CPU can interrupt the erase and spin on the lock
held by the interrupted task.  Use xa_erase_bh() at both sites to match
the insertion path.

Fixes: 65e302a9bd57 ("cxgb4/ch_ktls: Clear resources when pf4 device is removed")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Compile-tested with x86_64 allmodconfig and W=1.
I have not tested this on Chelsio hardware.

 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index f5acd4be1e69dcb551758dd27808a1b1eec374bd..dbec95b4977736b9b2fefdf5648a7eaca16429cb 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -389,7 +389,7 @@ static void chcr_ktls_dev_del(struct net_device *netdev,
 		cxgb4_remove_tid(&tx_info->adap->tids, tx_info->tx_chan,
 				 tx_info->tid, tx_info->ip_family);
 
-		xa_erase(&u_ctx->tid_list, tx_info->tid);
+		xa_erase_bh(&u_ctx->tid_list, tx_info->tid);
 	}
 
 	port_stats = &tx_info->adap->ch_ktls_stats.ktls_port[tx_info->port_id];
@@ -577,7 +577,7 @@ static int chcr_ktls_dev_add(struct net_device *netdev, struct sock *sk,
 	cxgb4_remove_tid(&tx_info->adap->tids, tx_info->tx_chan,
 			 tx_info->tid, tx_info->ip_family);
 
-	xa_erase(&u_ctx->tid_list, tx_info->tid);
+	xa_erase_bh(&u_ctx->tid_list, tx_info->tid);
 
 put_module:
 	/* release module refcount */
-- 
2.43.0
