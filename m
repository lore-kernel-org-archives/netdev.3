Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602809;
	b=gATkKSYqiSmcXq3xsA4ho7p9K3Tt+KXQIivqp1zOCh5xQkeAFqoCnE+EnZ6pNkGf0szP
	 vGquCPlSa03IwhECBMqQDjIObel5mKFWynkyIFpX5XzTvR1HGbTJRfnErfFqlgD9ynhqB
	 y0FI/3Ykfp51YGNrDSYlPfrOLvwAQ0oz8nUnx+xPpkxHw3QcNxaMeFggamdMVmz/z0mVG
	 NRT4sktsbuYtv/5kyC4+5OHK8Eyg4Kt3CJx5yDRQb5IQh7uV5YFCAScgbWUx8kTntg0HX
	 D8ntE0rjL/m7UKWLuCJKpFzbU5Xz05BBJ2lksLyeipGU5pxd1EoiYuOVa1LwzVWVb1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TFjFXEQ8daX1SDzZ+zKTu3JqP3e56krBVno7avFksg8=;
	b=s4OL8JvrSiOeVBUN8kfavGpR1aiNSeji5RoT1APX16IKQslKCxrnrQ1W34X8tlvXCJi7
	 uhIdkSkR1hDCsLQbieCAzI/pgHcltQ3QrC/QnaPmaBuJruCVT7M2ff8YvqZIZddXZe2iX
	 97OCw0OBXzJccSoXwt5eAWY83+8pY6kz377tL8a0HLTC+DDMuf1I1kDxUbfjalSm6NY84
	 Dn81Xn7sayNDqprVLAkiJl7nZvG2VRyMjYPzgjjMkh6ZtV17sr2xCdZ5HvqwMcHi3FAi+
	 qtxJ24LfjcOE8EDbV3+DgESY9WzXIqNmy46RCivFBgmpMS8xesWPZEe+wjlYvMCv56w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=soWqeg8C;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86380606A327
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86380606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=soWqeg8C
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36681e85e87so1929371eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602808; x=1793207608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFjFXEQ8daX1SDzZ+zKTu3JqP3e56krBVno7avFksg8=;
        b=soWqeg8ClTWjGsUdU6T/pu3svwM0Pfxg2zZh/n9lNcDLCmLtKefWVOKifpL0zHAq1Q
         D6LtACxIh9ec8/1K2mp5qmfBvdxKMULxhe/jNV/dPtt5jFHja1SYX0/Qk340szBict3V
         QuZ38mRsn87CyEawQEZkkBVayuKUAZhkj9wst3LID72z3mWvw7f1HlpsHuR4B29d+rrF
         xNjBWHfVxPKiYyPiUwPc9mgdKoaBp28JqcNrF0lORvsQqW6BEXnCaE6rPU0vEBprTg33
         XKoK9jeF5X1sV46+j/eReNTBzPEMozvHY6FOKd82RD7CTFY/OSL1i7R6qF84ZAZO5HpP
         YEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602808; x=1793207608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFjFXEQ8daX1SDzZ+zKTu3JqP3e56krBVno7avFksg8=;
        b=t1g+KpiVlv8YkVh7+walVEOFXgj99j2rp1S5NQ04JJPt7XEDdtXBAxeHR6mTv3YdXE
         EiO7rFSjTl83Vzv/yQhknTwets2SdjfYEuhwln0eG4ha+XssBn0ksjprKFRPX7FifibF
         T/XzaYw5Jn6/dQQXo52zUJcgNkgF4LiWeXiB7KWpphZZ6yqBBGRp6grBpPibRKMK6uHn
         rjKFwrRNmh+Ynf732eOB7Y51S/64/lnFuu5zWcDjFWE3sHVpbTa37YxW3YL4TVxjw0/n
         p18UCy+7l1VbQp8+s2DLb0kuNoPa9Fb1EeiW5dXoTEWdq+WzR4NPyqbPVkrwRvX5Ejeb
         6pOA==
X-Forwarded-Encrypted: i=1; AKwUvBxFuAtor4OOw668UybL07XRiLHoABpOCEw10soANrgD8uN2SvrTObHVPN88EIBXmp05ugUkBVY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMkOFaipeQGWNYEY2jNCsgNjk9pifnzqFwa9JJ1vfkJu+PxVFS
	wpcAkvDHytj0zugr3LPyrPYtc8a5rP0xG7hFpdJ3rIVzXqaW8yVoJupI
X-Gm-Gg: AYBFou0rFKBt+o7RLpLIkp4MUJp+H9g98v8m0+ZRIHnuZHUlHEhf92dJoy+Amjk4qcm
	RF+KbwkTERNBZ51V1XKf1AI6EMQLDOnh3IQnFy6JjkrnD+3197R+PGqSsSBiqZS4IJFEzBf5Db+
	vTIpyefg9OSJZWtAQ6OLBV1Wbx6QGMDig+Brg1YBxv5jokcSBJmyhDGx2WeZ9Qxoa6P35ziAQ3C
	3WfviYE7KyFpouG2SrXWW60jEACm2reR16M+2t2KQceiMmEICoKc7Gxv8ueqpvkOdlMl3kygP4H
	WZ4QJchEnz48jO9zG/g4y0DR8TuM3rKojqWNmmIWQmeGcboS1Ot7rZ1LiuKigQ4hBlrja8B4bCJ
	pXa7/t3lIL/Wsv43oQKpjyrntTFBsyIOipf1iWXbInUnX6BcQNHuljWU0bWw+9uZ4bJt2KspvoF
	J5dbcGi15krdIFQapl4LWflElLdUyjx79F24kC0R60C2iPAFwtg6K4aeb5WwWuZgZYcOP9qN8L3
	vqYN75D/Cl4LkHUjk4pCsLajNEyqDEyQwEk7dld0yekAGqEy5e9t22/2ONUOFMlCsqkzS/7vVqJ
	gtGSyIC1r60dD1cmu4b63JuO/Q2N5g==
X-Received: by 2002:a05:693c:60cf:b0:353:8205:8558 with SMTP id 5a478bee46e88-3674b82ad86mr4897440eec.5.1792602807507;
        Wed, 21 Oct 2026 10:13:27 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm12947635eec.24.2026.10.21.10.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:13:26 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Ursula Braun <ubraun@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net/smc: reject CDC messages after connection teardown
Date: Wed, 21 Oct 2026 10:12:57 -0700
Message-ID: <20261021171256.166870-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_cdc_rx_handler() drops the link group's connection lock after looking
up a connection. Concurrent close(2) can then set conn->freed and release a
registration-failed receive buffer before the receive handler obtains the
socket lock. The handler subsequently dereferences the released descriptor.

KASAN reports:

  BUG: KASAN: slab-use-after-free in smc_cdc_msg_recv (net/smc/smc_cdc.c:376 net/smc/smc_cdc.c:431)
  Read of size 4 at addr ffff8881064a4720 by task kworker/u48:2/233
  Workqueue: rxe_wq do_work
  Call Trace:
   <IRQ>
   smc_cdc_msg_recv (net/smc/smc_cdc.c:376 net/smc/smc_cdc.c:431)
   smc_cdc_rx_handler (net/smc/smc_cdc.c:503)
   smc_wr_rx_tasklet_fn (net/smc/smc_wr.c:445 net/smc/smc_wr.c:459 net/smc/smc_wr.c:498)
   tasklet_action_common (kernel/softirq.c:961)
   handle_softirqs (kernel/softirq.c:645)
   do_softirq (kernel/softirq.c:546 (discriminator 19) kernel/softirq.c:533 (discriminator 19))
   </IRQ>

  Freed by task 209:
   __kasan_slab_free (mm/kasan/common.c:285)
   kfree (./include/linux/kasan.h:235 mm/slub.c:2748
          mm/slub.c:6508 mm/slub.c:6801)
   smc_conn_free (net/smc/smc_core.c:1244 net/smc/smc_core.c:1283)
   __smc_release (net/smc/af_smc.c:322)
   smc_release (net/smc/af_smc.c:361)
   __sock_release (net/socket.c:735)
   sock_close (net/socket.c:1526 (discriminator 1))
   __fput (fs/file_table.c:512)
   fput_close_sync (fs/file_table.c:617)
   __do_sys_close (fs/open.c:1560)

  The buggy address is located 32 bytes inside of
   freed 128-byte region [ffff8881064a4700, ffff8881064a4780)
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Both smc_conn_free() and CDC message processing run under the socket lock.
Check conn->freed after acquiring that lock. Discard messages which passed
the lookup before teardown. This keeps the existing lock order and prevents
access to receive buffers released by smc_conn_free().

Fixes: a6920d1d130c ("net/smc: handle unregistered buffers")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/smc/smc_cdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df321..499a2473b79b 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -428,7 +428,8 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
 {
 	sock_hold(&smc->sk);
 	bh_lock_sock(&smc->sk);
-	smc_cdc_msg_recv_action(smc, cdc);
+	if (!smc->conn.freed)
+		smc_cdc_msg_recv_action(smc, cdc);
 	bh_unlock_sock(&smc->sk);
 	sock_put(&smc->sk); /* no free sk in softirq-context */
 }
-- 
2.56.0

