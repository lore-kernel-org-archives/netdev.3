Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A033921DD
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614783; cv=none; b=qAD0UGkoPDApCYsXFccuWxPn2CF6/GgZbnCzbVTdjd2wQx+K506fVR3618cJqDRdz7IMiMdqu3BDFHyfZVr3p9zSkj/h/VF2PFA+smosQbH6LcCXyn+3kYxpYUUMZut9rBhpCmmMQD0bcft4cMRvdbJqTj7S3c9LqdYyk1lLln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614783; c=relaxed/simple;
	bh=w/uxlevJbWijFM1VnM7RD/UhrEhizbti9lYWzqkqjIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kh6UOBwCS0zx633erxh+qBZPSWm8VXeyjyN808pMsAqqSq3hupPsislphYFMeKHlf8VTMaPipEU8df+zxQaVbzz8lyn4/CM+YAK1kRlepfY1fMLD98xy/ocm9CUZI4fMeyv/mUempdSEtG7WLfVTgszF5cekWNEvGpW+ruMM6JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz9t1786614707tc099c961
X-QQ-Originating-IP: OJ8QN4yJVsN3EFUkykulq3g102YydAsjNcWly3Wx9T8=
Received: from localhost.localdomain ( [36.24.185.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Aug 2026 17:51:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9803155024728099084
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next] net: wangxun: protect ring accesses with READ- and WRITE_ONCE
Date: Thu, 13 Aug 2026 17:51:41 +0800
Message-Id: <20260813095141.88227-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: N45sc01EPjPxtbVmeCBzkq6KfiabZ9nGd9BXBQYRoZ/aFlovPwkTrs3z
	HDE7Z857/qaAKXgB5Uvra+RUiol44L2WHX+xImFhwoW32ogRORYFgw1My+v98/2XeIZsM62
	T/6dZqKLN4zc2oUM2+PF67yO1ck1uUForBcJMxdg/rDuXFR8r/6Hig7eTwUJi44YKVO2HQ0
	gmKOx0uExCvgOBrqvzRD/6Bn6DqWsiZBT69yoS+rO7K4NHqC+cebm4KumLLmfb0I4N4BDFd
	SiPciar1DNw3+kM6s/qmW5yTX7KO0e+5iOscSR7mydpsZfA5zhjr+WgA7mBdP4tanLhJRdS
	96sz/QgodY1bUvch0Pd9k1YKItkvFLGvdloD2GCqbuDOIGq8cmkdfiKa7U7i6tS1nq33KLg
	cfpLFrMsYvZ6Vo8quCZghq9dyUVSmG2WnStggiGpHyi/OhCjY3+vL41Rga8ZU6iT4vjFuOU
	csv4FEmIjM6mfYsbySAOn10tdHFMDlnnU6gExACg2E26RsMJ6K3m2CPUGLPGH/UeLD456IW
	oFKlvaMzWA4wW3Rzmt34wAa8gVxGc1q/u/OZcGadGC9uoZCWYmLlGlttgAxTqHLiUbUOawR
	R0oeJHo9fRSrZDOu73g/ig517z5aamBD8TfKdaFzqhNwpR6+YB/cNPA066W0sj7h7n235zR
	LDclYV0t6tpJQq+/nVVk7bY1cABeIXdLG8k9fSaHQjbvxPt1SkpmHi2F4qgkOOLvTaFhnM4
	daIU3TZFgDYiSh35eNrwLVrIdB6Qe1VfnaKPe1lB3IEBZuo96zEtLLG8WEzjDJhT/q5muYm
	3VKqkm3SkU/vyL1nUjVHmixtJiIA9tuBOfups6YpjN8LWtd8YdIBRgfzc3t3omIT0h9APNV
	NVv181ELduSX9B9SBBID9IPv32HjFuAHwst0UIlypgxS6x6tH7h+qzUMnXAQxSKTZiks5N8
	gHcI0+T4aaD3YExGzZJwcWtczDIHRX21YYoWewIpRZ81Cea6rDrGNKcUvqw+vypC5kYA1hH
	bAAwI1jcOSbCrwWVzfaNjBkQOQRBuNf6FukPtoZYdOIfg8VUVl7IikVtel6Ih8sJqG6XthG
	jCEDYr6Ti5zz7WNvifIdGx6DX3E+9p4f+9sxZFHSLnj1lv2hQiI6vANH16jy7ISNL8Q9O+y
	JWxI
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

In wx_update_stats(), the ring pointers wx->rx_ring[i] and wx->tx_ring[i]
can become NULL during queue teardown or reconfiguration (e.g., via
wx_free_q_vector()).

READ_ONCE should be used when reading rings prior to accessing the
statistics pointer to ensure protected access. As well as the
corresponding WRITE_ONCE usage when allocating and freeing the rings.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c  | 20 ++++++++++++++++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c |  8 ++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 122c4952d203..096fe7f3d84f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2893,10 +2893,13 @@ void wx_update_stats(struct wx *wx)
 
 	spin_lock(&wx->hw_stats_lock);
 
+	rcu_read_lock();
 	/* gather some stats to the wx struct that are per queue */
 	for (i = 0; i < wx->num_rx_queues; i++) {
-		struct wx_ring *rx_ring = wx->rx_ring[i];
+		struct wx_ring *rx_ring = READ_ONCE(wx->rx_ring[i]);
 
+		if (!rx_ring)
+			continue;
 		non_eop_descs += rx_ring->rx_stats.non_eop_descs;
 		alloc_rx_buff_failed += rx_ring->rx_stats.alloc_rx_buff_failed;
 		hw_csum_rx_good += rx_ring->rx_stats.csum_good_cnt;
@@ -2912,19 +2915,28 @@ void wx_update_stats(struct wx *wx)
 		u64 rsc_flush = 0;
 
 		for (i = 0; i < wx->num_rx_queues; i++) {
-			rsc_count += wx->rx_ring[i]->rx_stats.rsc_count;
-			rsc_flush += wx->rx_ring[i]->rx_stats.rsc_flush;
+			struct wx_ring *rx_ring = READ_ONCE(wx->rx_ring[i]);
+
+			if (!rx_ring)
+				continue;
+
+			rsc_count += rx_ring->rx_stats.rsc_count;
+			rsc_flush += rx_ring->rx_stats.rsc_flush;
 		}
 		wx->rsc_count = rsc_count;
 		wx->rsc_flush = rsc_flush;
 	}
 
 	for (i = 0; i < wx->num_tx_queues; i++) {
-		struct wx_ring *tx_ring = wx->tx_ring[i];
+		struct wx_ring *tx_ring = READ_ONCE(wx->tx_ring[i]);
+
+		if (!tx_ring)
+			continue;
 
 		restart_queue += tx_ring->tx_stats.restart_queue;
 		tx_busy += tx_ring->tx_stats.tx_busy;
 	}
+	rcu_read_unlock();
 	wx->restart_queue = restart_queue;
 	wx->tx_busy = tx_busy;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index ed5aad7857bd..c227e9ab8a4a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2191,7 +2191,7 @@ static int wx_alloc_q_vector(struct wx *wx,
 		ring->queue_index = txr_idx;
 
 		/* assign ring to wx */
-		wx->tx_ring[txr_idx] = ring;
+		WRITE_ONCE(wx->tx_ring[txr_idx], ring);
 
 		/* update count and index */
 		txr_count--;
@@ -2217,7 +2217,7 @@ static int wx_alloc_q_vector(struct wx *wx,
 		ring->queue_index = rxr_idx;
 
 		/* assign ring to wx */
-		wx->rx_ring[rxr_idx] = ring;
+		WRITE_ONCE(wx->rx_ring[rxr_idx], ring);
 
 		/* update count and index */
 		rxr_count--;
@@ -2245,10 +2245,10 @@ static void wx_free_q_vector(struct wx *wx, int v_idx)
 	struct wx_ring *ring;
 
 	wx_for_each_ring(ring, q_vector->tx)
-		wx->tx_ring[ring->queue_index] = NULL;
+		WRITE_ONCE(wx->tx_ring[ring->queue_index], NULL);
 
 	wx_for_each_ring(ring, q_vector->rx)
-		wx->rx_ring[ring->queue_index] = NULL;
+		WRITE_ONCE(wx->rx_ring[ring->queue_index], NULL);
 
 	wx->q_vector[v_idx] = NULL;
 	netif_napi_del(&q_vector->napi);
-- 
2.30.1

