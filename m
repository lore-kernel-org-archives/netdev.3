Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236147253A
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420219; cv=none; b=MjmL5aZoa22y+CPJYVVSGqH3ZgkojTaCRwNxYDW/uBUzWjRepU89o0ljjLInWglhOt3pJuOmNan/xAdY7yUEzT6/keBimhmrIRY2J+XgOCWVD9hp1RJgRUaws8mUlgkIg1236sKxaCIls5r2+J7zf8PbSrtV3GhmHhkQT/zQWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420219; c=relaxed/simple;
	bh=Kzm80LA/YaAXbwYvhrH2H0W43zczWduK9yCDz13qf3o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+7J2nLna2SFWwJHGKXK25EKJP7NKA0oliRYNZGI4aFfuOlUoZFd9qddpnIBuf4WVBw872JuBcxozVLnl7uHbFE2czKIAUg6x5mwG2A+YI3aBJee6O0dwHVTUspI7W6LR9fB+KgIXrE0/k03BGqoQ9s/Cfu9BfByvj2OnFDuOSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pz5oOeEa; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pz5oOeEa"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so2585124a91.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420213; x=1790025013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZHRD7vWiExXe59NWa93Ol+zrY+TaGYSNUGLpr0eYc68=;
        b=pz5oOeEaXqvXmdtBM0Cyju485fszD2iMQwuE3n6+Q1eDmMy5lYAfafvsZ+gzdfFb7k
         9gYubNGkrI3HjsA1mmMfz71l6wIQ84eDGhisLuBJ5sJI16Zr2vd3NmWLKV6QleE7k/B7
         t8Irq5mwSoUoji9aPhONTUjcG7CrrdotNdRNY60P9PYVK0Or3lYvVAUjqFsWiiJ3PZ/8
         BgPFxS+QIUSpSk1m+QcpxeLP1q9vgJZgi9IE3uxaCZClJdkpGqqwdo89n41Gjd8SM5Ql
         xyQloMJEFoChUJr1DfXxCQ3J7pySIM5oD6FM3IqyP84VxcX5/GvTHYpnkqHDzkfS6r8G
         S8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420213; x=1790025013;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZHRD7vWiExXe59NWa93Ol+zrY+TaGYSNUGLpr0eYc68=;
        b=HVmF13wqveAV81vgiK4Uk1wnnUYHsoMow2ngdH5DeanPeGTTUWKW3l0gEDqQTvXrex
         sG2Pg5x5svzZ1MvCIbE/CFU/pi2oG/INYEgZAnaA+Qy3tglU5RygS7Lz4h15uTQ0J7wn
         idhGtOLD2pvYbV6WE01J3UbJ5YwlhQH7YVH07OzTdkgHPb6sAvV+oj08IE6IormoUt6O
         X5vCSp7cwI+pNbLblec5VToTzlP91nVoRmeYcM01zWlsj7euSm1WXsO2QRym88uOHNgK
         vCv/YaxR26ijvEv6e6Lto//5ELQNmc9B1DwIO7vtza6lgI5OPNqzKMhI5ew7DHpSWBKx
         hFXw==
X-Gm-Message-State: AFuF++mnOofvtdPzh8Pzf0tzNclK/lsBWZH990NJK3xC/kh1i/zym15Y
	29c9RauejkTLbJzsMPJr4TI8MrHNEKG0GrSzfMIdAv3PRfruz8O5cfdC
X-Gm-Gg: AYBFou0YZOH7RtlEuznxVkksh5TvW1+h2JoXm+YTynNJR8FgI2jGg0ubMm9y1NLLUGJ
	I5K7l97gPCLpKdNYiyWGB2lrGSvQUKY3Ewa53he14WvtZWbNeD/D4T+vy3S6sFHKGeH8gjWRZWH
	yLBJ6kUzIJUFgbO3nh1BMY7c2nBwJJnCIuGQoHM+VVXXMzfx8UP0Ey4crzrwFH+OCUhOAZG3mu+
	DXxSV0RR/zjglzT6RuqdCnzmkXzos3d2Is+bESdFeqUh0zDFpOlxbPR5xcN57movf7i6gewpLkC
	zzLLjRH0fxXUZf05h+9BYVgbn2GOAt06dUwRuXUK41ye4BixXomx346BWgGqRLrpVs0QnNrV/e1
	iNOsGpeSvQUbxoyv0kYIIKgw4PdEjpawh+Kdd9kUw9c6HuS5LqR1EtR++6NJBxrujNnOrgeAKPV
	Hzx4oFCB//0QkZ1w3+opJgSTVbV2jm7q1Tr1HIjQ1tWowqPh6xLti7fp5cLW4vh3YibvstnbpTG
	9pdddnKZNaIJaNxD3SDi4YG2lrSxN4MgEhg0w2JgB6sHYfGUA7nHl8gUQBRT3Dm5YaB9631qXZ/
	j4ZAugy90f4SH0dHnXo=
X-Received: by 2002:a17:90b:39cc:b0:39d:e54c:8658 with SMTP id 98e67ed59e1d1-39debf547abmr9816650a91.5.1789420212948;
        Mon, 14 Sep 2026 14:10:12 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:d680:cb2f:f831:8497])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd6a3e3sm1147589a91.13.2026.09.14.14.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:10:12 -0700 (PDT)
Subject: [net PATCH v2 3/6] eth: fbnic: use the Rx queue napi pointer to find
 the napi vector
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Mon, 14 Sep 2026 14:10:11 -0700
Message-ID: 
 <178942021136.7700.4391219358260544104.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The queue management ndos pick the napi vector for an Rx queue with:
	nv = fbn->napi[idx % fbn->num_napi];

The issue is this is only correct in the cases where there are no
standalone Tx vectors. In those cases we were allocating the Tx vectors
first and then the Rx so the queues would be pointing to Tx NAPI vectors
instead of the Rx ones.

The mapping the ndos want is already recorded.  fbnic_set_netif_napi()
publishes it with netif_queue_set_napi(), which stores the napi pointer
in netdev_rx_queue.napi, and fbnic_reset_netif_napi() clears it again.
Both run under the netdev instance lock that the queue management ndos
also hold, so the pointer can be read directly.

Use it and drop the divide.  The pointer is NULL exactly while the
datapath is down, so fbnic_queue_mem_alloc() can reject that case rather
than reaching into freed state: netdev_rx_queue_restart() calls it
before it tests netif_running(), and fbnic_pm_suspend() leaves
netif_running() true across a PCIe recovery that never completes, so a
queue restart can arrive after fbnic_stop() has freed the rings and the
vectors.  fbnic_stop() clears the association in
fbnic_reset_netif_queues() before fbnic_free_napi_vectors(), so the
NULL is always published first.  fbnic_queue_start() and
fbnic_queue_stop() need no check of their own, as
netdev_rx_queue_reconfig() only reaches them once fbnic_queue_mem_alloc()
has succeeded under the same instance lock.

Fixes: da43127a8edc ("eth: fbnic: support queue ops / zero-copy Rx")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c |   26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 81a30e2d449b..e93174fc1239 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -7,6 +7,7 @@
 #include <linux/iopoll.h>
 #include <linux/pci.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
 #include <net/xdp.h>
@@ -2829,6 +2830,17 @@ void fbnic_napi_depletion_check(struct net_device *netdev)
 	fbnic_wrfl(fbd);
 }
 
+/* Returns the napi vector servicing an Rx queue, or NULL if the datapath
+ * is torn down.  The association is published by fbnic_set_netif_napi()
+ * and cleared by fbnic_reset_netif_napi(), both under the instance lock.
+ */
+static struct fbnic_napi_vector *fbnic_rxq_nv(struct net_device *dev, int idx)
+{
+	struct napi_struct *napi = __netif_get_rx_queue(dev, idx)->napi;
+
+	return napi ? container_of(napi, struct fbnic_napi_vector, napi) : NULL;
+}
+
 static int fbnic_queue_mem_alloc(struct net_device *dev,
 				 struct netdev_queue_config *qcfg,
 				 void *qmem, int idx)
@@ -2841,8 +2853,16 @@ static int fbnic_queue_mem_alloc(struct net_device *dev,
 	if (!netif_running(dev))
 		return fbnic_alloc_qt_page_pools(fbn, qt, idx);
 
+	/* A failed PCIe recovery or resume can leave the datapath torn down
+	 * while netif_running() is still true.  This ndo runs before
+	 * netdev_rx_queue_restart() checks netif_running(), so bail out
+	 * rather than touching rings and vectors that are already freed.
+	 */
+	nv = fbnic_rxq_nv(dev, idx);
+	if (!nv)
+		return -ENETDOWN;
+
 	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
-	nv = fbn->napi[idx % fbn->num_napi];
 
 	fbnic_ring_init(&qt->sub0, real->sub0.doorbell, real->sub0.q_idx,
 			real->sub0.flags);
@@ -2893,7 +2913,7 @@ static int fbnic_queue_start(struct net_device *dev,
 	struct fbnic_q_triad *real;
 
 	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
-	nv = fbn->napi[idx % fbn->num_napi];
+	nv = fbnic_rxq_nv(dev, idx);
 
 	fbnic_aggregate_ring_bdq_counters(fbn, &real->sub0);
 	fbnic_aggregate_ring_bdq_counters(fbn, &real->sub1);
@@ -2915,7 +2935,7 @@ static int fbnic_queue_stop(struct net_device *dev, void *qmem, int idx)
 	int err;
 
 	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
-	nv = fbn->napi[idx % fbn->num_napi];
+	nv = fbnic_rxq_nv(dev, idx);
 	fbnic_dbg_nv_exit(nv);
 
 	napi_disable_locked(&nv->napi);


