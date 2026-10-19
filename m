Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20174E0204;
	Mon, 19 Oct 2026 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407636; cv=none; b=RIOpnY7hiM2lHfpJEuYSsuaJEHSULn9n0EAhAP9r5Wqz9xnx0y4acvxT+fwvMZauyeerYpJdS3NRUxwAtKYg3HkZBXx/8NPwUM5Yt86X/FzKh5ZRn34y3MsnYIZmwEmcmNWtBkp5v6rzZrdB9CUUHAKNrCl1bL9p/qxncnAFBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407636; c=relaxed/simple;
	bh=jYoztW5ZAzdHi8HfincA4CFV9xX3X9eAwegE7CacxUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTFgaBDD7F1HhfGVLgpo8WjydzaJiXMz1h+2wrGnBkmDIWVjym2OpaFAupakKr6f48ZVAfrbQ0+UnonVWkpzrMKybLdqFSlHnLxnp67RPzHW+bkMID4u/XhpOkyYPhAJdQs00uuUrJeJdyJpb3h3yLhc+/c0sM+7w04upniogN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=YZ7zWdrT; arc=none smtp.client-ip=85.220.129.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="YZ7zWdrT"
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp5.goneo.de (Postfix) with ESMTPS id 0D198240A1A;
	Mon, 19 Oct 2026 13:00:23 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id C817524045B;
	Mon, 19 Oct 2026 13:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1792407620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/FP0aSKPLpVvvZrQy0imcxS48xnjj4SOrgBH9s2RA0=;
	b=YZ7zWdrTp2Inj1yTtWlYs2in9EnAZNjEwA+iFre8zhWwx94NUlhC5K5S5dtnSFMFYpOd+3
	EQep8cYFCZ/PnAudrxDhMrE0SV/0EvRF4KNXIivpNqhCNQV5fICVcB5U+8O7hoTITTVTN8
	opr7wLi0S0Ncn7tKIMbIG7rVnTIEQtTXWzo57ksFv1AHu71XhD+R9I1jQLCqPfBhWY5k4K
	3C+XpP0YsCrKNCkRoSGe87zme7hUedIcoILOgszrxuUNm6fn3998xaqSaO6zy2AmajTAjW
	/eAJX2YoET8DGzqR6THtAji1IaCq4Ezmxhqf1n8XJT4deLg0JwU+dmmxliX6qg==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 29AB1240061;
	Mon, 19 Oct 2026 13:00:18 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: jie.luo@oss.qualcomm.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/1] net: ethernet: qualcomm: ppe: Fix multicast queue admission control access
Date: Mon, 19 Oct 2026 12:59:50 +0200
Message-ID: <20261019105950.3977665-2-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019105950.3977665-1-mail@tk154.de>
References: <20261019105950.3977665-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 92cace
X-Rspamd-UID: 454d19

Multicast queues have global IDs 256 through 299, but their admission
control table has 44 entries indexed from zero. Using the global queue
ID accesses registers beyond that table, leaving the multicast
thresholds unconfigured. Subtract the unicast queue count when
addressing the multicast table. Keep the global IDs for enqueue and
dequeue operations.

Each multicast admission control entry contains three words at a 16-byte
stride. Limit the bulk accesses to those three words instead of
accessing five words, which also reaches the next entry.

The indexing issue was reported by Sashiko.

Fixes: 806268dc7efd ("net: ethernet: qualcomm: Initialize PPE queue management for IPQ9574")
Link: https://lore.kernel.org/netdev/179143027873.434549.15034517641240789690@kernel.org/
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index 125b73be92b1..95b29db45580 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -1474,7 +1474,7 @@ static int ppe_config_qm(struct ppe_device *ppe_dev)
 {
 	const struct ppe_qm_queue_config *queue_cfg;
 	int ret, i, queue_id, queue_cfg_count;
-	u32 reg, multicast_queue_cfg[5];
+	u32 reg, multicast_queue_cfg[3];
 	u32 unicast_queue_cfg[4];
 	u32 group_cfg[3];
 
@@ -1530,8 +1530,11 @@ static int ppe_config_qm(struct ppe_device *ppe_dev)
 				if (ret)
 					goto qm_config_fail;
 			} else {
+				int mc_queue_id = queue_id -
+					PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES;
+
 				reg = PPE_AC_MULTICAST_QUEUE_CFG_TBL_ADDR +
-				      PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC * queue_id;
+				      PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC * mc_queue_id;
 
 				ret = regmap_bulk_read(ppe_dev->regmap, reg,
 						       multicast_queue_cfg,
-- 
2.56.0

