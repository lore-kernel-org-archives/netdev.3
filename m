Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE55481A9A
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879567; cv=none; b=pbMQ7nHZz2noSSJezkvgEugzoJ8s5J97FRoV+20jfGphyHMlmWeDCR2BcCRtgQhncyn91exRI10MOjtdEGd/aVY8OfikZu4yxflluVzSZj9PrQqau4vimbEymDdgkaUbVy4LrhoD5SuOzTjj6i6GpQTHcDmM2hZxm4ChwXqc0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879567; c=relaxed/simple;
	bh=c0jHAqCKMMLGqElB9P0Zc/ra2eBZhFiyVAmWgrs0dpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHuEd0sDVOdOFBCIVxsILJBjgnJkXXgOuodRgGGaxEmZTnM/jIhp1A2tOF/liF2A5FaOAjMZVkEl4BfZ0DZ957RtQe4TqeqmSOJ2oWdFLslbxqmAyTzuthB2bVbKqhPWKsFn+g3pdepqSyQ5aPcupHSfehRgQoJsCXj3Y9gQUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6SmcVV5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6SmcVV5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d0407aedd6so4076825ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879564; x=1786484364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AVzPi9qdoodMQ73+79x+gG0Fw90m+Wzneqb+ihmK6gQ=;
        b=e6SmcVV5jfw8sFCaBIZVZtBXSOxoKLFnviVSNIVBBcs83peqIeViDqgJEo3jqTaY0d
         TR8/fjJmVb0hWCcPgGzufqhPCPutU31Xm4xTfJoOCv6teNG29GSiL+L0E48vQwy5jTQ3
         mA/7d2LQHgAacqW5xthUbx9uNEk+JkD2qY11MFzXLwQ3R2pLOPBZe7zB45/csv+uoVDa
         9WBxSmYkNRb7LDzTaCqlF0pqpjxCWtK+Z1M/wOpKyeQhWFNuWI4k+dD1XSOnqQGgwCaD
         djz6ydqXVE1xwO6hy1v8ouFil/C2+7sha/+kWbmx/lw4a3dnppMvVTTnxiIv4qzYIqVj
         2M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879564; x=1786484364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVzPi9qdoodMQ73+79x+gG0Fw90m+Wzneqb+ihmK6gQ=;
        b=tBVh6OwJnLXtavXPvLNAF4+o6Lb7OcJqZplsjK0bnlML4lrvyuP1prDiuHJHlm57J2
         SZQMzCHns8rbX3LRMSXeMpEK2oRj4L6jOx11UTdLaCpK7gXGofn8cCaTJyRxEt2qXtiZ
         HNM3re6Brr5U+pJVNI/SCA2cG+ojiDgVO9pveOZ03K4EMTDFQ04AIL6CGbW2XEhyRIWP
         KmdRlWQ8V+9oSTWpQwHxqNnrZj2QzEY4pWTNcBxOxvrr/b14lIKRP9P3nDhRNSHQ5/Pr
         7VDj6n8pQpn7o+SQiKZzD9YqzrXc6wFo6fj1x2J5e2cNmreoqnuR+bBWgxz5oQJciSEa
         aXFg==
X-Forwarded-Encrypted: i=1; AHgh+RoCtAE82XBBA4IHLelm3czr4J2fvvxmCatLHew+0jcv0jtClEEdLMkAanYmOgJqW7StLP9KrzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweBIQTNq8Uysd+FuQLhNCfQWpyh9ipG5nvNoT9wUTzOSAQPVTo
	FRGhx/GZHhHmwmqIGSwKLc92ui0/9sFpTJbPX76wFAznPLcD674FnavM
X-Gm-Gg: AR+sD13EN8tprztkYWpnZeurnmueVv2qN8MD28kWLZt4c5cZw074/Sk06mROUMNmD4z
	S7q9bBvOwqIcrBtZnqZAVob8Pn95nwI7X9MVozVAB24YxT03INAtIRGM5DrWoxVEXSK9/7yBSXy
	rUb9EtfdjqvFaPJWfEmEuZOh2VOwkUXaW0zt2cZuwqmkApu38/6jBLQlj95sWopmqIAJBl/UzJm
	pRYViyoNIZGRGak2hst/0ejK8QFZ5miWQzNYhsqcZzXO+Ou0t0yJAijy1th402yW2/1LaziveFT
	lVnCra03bwo90jL6mgX3QhsjZObwM5MiRmyqGbdlf101c7PuQkmYy0KKdvvSoIqKzEcT3/v9g6E
	xIFoPCassRaKuDS50v14dAXWHdiZbTWeBWbgq6IwlLAip6drwhPoteWNDGMR/uDQaK738WPvoCS
	dSzJs1gfk2uZgLOFNL0p4VrikBy4kKyromW14pgzbZUzg9PvArLza4SNjHbMA0C+P6Q1A6tPLeO
	aqfY8eN2irFNKySkLoqV0vwpU20KOtgWRK1FrCaxLk=
X-Received: by 2002:a05:6a21:a38d:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3cb85ea3663mr1881337637.21.1785879564575;
        Tue, 04 Aug 2026 14:39:24 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867bc341sm14727379eec.27.2026.08.04.14.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:39:24 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net/smc: fix sock refcount leak in smc_switch_conns() error path
Date: Tue,  4 Aug 2026 21:39:17 +0000
Message-ID: <20260804213917.3413525-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_switch_conns() takes a reference on the socket with sock_hold() before
dropping conns_lock to prefetch a tx slot. On success the reference is
released by the sock_put() after smc_switch_cursor(). When
smc_cdc_get_free_slot() fails, however, the function jumps straight to
err_out without a sock_put(), leaking the reference and leaving the socket
unreclaimable. During SMC-R link failover with an exhausted backup link
this leaks one reference per failing connection switch.

Release the reference before jumping to err_out. The err_out label is also
reached from the smc_switch_cursor() failure path, which has already done
its own sock_put(), so the put must stay at the get_free_slot failure site
rather than at the label.

Fixes: c6f02ebeea3a ("net/smc: switch connections to alternate link")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 net/smc/smc_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index cf6b620fef05..04c6ce608ec7 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1148,8 +1148,10 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 		read_unlock_bh(&lgr->conns_lock);
 		/* pre-fetch buffer outside of send_lock, might sleep */
 		rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
-		if (rc)
+		if (rc) {
+			sock_put(&smc->sk);
 			goto err_out;
+		}
 		/* avoid race with smcr_tx_sndbuf_nonempty() */
 		spin_lock_bh(&conn->send_lock);
 		smc_switch_link_and_count(conn, to_lnk);
-- 
2.43.0

