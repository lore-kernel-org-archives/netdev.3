Received: from mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078F327C09
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 03:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787457418; cv=none; b=XIxO7g43WHbJWWbzFqdQL/HyU1ZCtyvgH2wCXllp4xqXg/jsuyOO2jsQVbqU37Cw3n8UjEs8agttrFhahWc8QAOlykDgx002tKKLO8G+MZA1yW2VOihZCe/kRYaaUVwRwVSCBl63qciI7KsfFPXowG2vW90wcgtJRXaohPVkNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787457418; c=relaxed/simple;
	bh=WWrAQqmLGA9HCXQj7NV+IJjhrsHfcuNd/jPdj6nKXOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L17KbFrN9FOtQSodGI1DkXqZynHv7y1b2H7zoGltVWXCd9iPW350vp2t8azMb0Q7yQm86tkicGt4OF76dlITBJDOW4GCoZk+S6jCKhINr5rFqaJ59eDFUDsKFIzW5kJj0VmlQ2BBVPdH4PZAK8yt51iEmLJQUbyraizjTU62pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r9fxohMY; arc=none smtp.client-ip=91.218.175.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r9fxohMY"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WWrAQqmLGA9HCXQj7NV+IJjhrsHfcuNd/jPdj6nKXOY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787457414; v=1; x=1788062214;
 b=r9fxohMYZ5xulc3f4ZnKoD5+N5E2wo79OGlwnWkyo8OTgXiZNy+Xo+NOWJDEsBQX7Wl0BYB1
 noDA4G6J8IcviqPMUe+FGX6j3mJ1+Pgs6HzPJJ//ajK+AkJGmP8Del1lzlFN2X2RG+zTSrigKqe
 v8MeuM1evhWlBRONjakD+yM0=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 1cda12b79cfeea00;
	Sun, 23 Aug 2026 03:56:54 +0000
X-Mizu-Trace-ID: 1cda12b79cfeea00
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	kuba@kernel.org
Cc: hkallweit1@gmail.com,
	chleroy@kernel.org,
	qingfang.deng@siflower.com.cn,
	hao.guan@siflower.com.cn,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v5 6/6] net: phy: avoid double-free after LED trigger registration failure
Date: Sun, 23 Aug 2026 11:56:00 +0800
Message-ID: <20260823035600.188864-7-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
References: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

phy_led_triggers_register() frees phy_led_triggers when a speed trigger
registration fails, but leaves the pointer set to the freed allocation
before clearing phy_num_led_triggers.

phy_probe() ignores the registration error. If a later probe step fails,
its error path calls phy_led_triggers_unregister(); normal teardown during
an unbind or MDIO bus removal calls the same helper from phy_remove().
In either case, the trigger count is zero, so the per-trigger unregister
loop is skipped, but the dangling pointer is still freed unconditionally.

Clear the pointer when partial registration cleanup frees the array, and
make phy_led_triggers_unregister() free the array only when its pointer is
non-NULL.

Fixes: b7f0ee992adf ("net: phy: leds: fix memory leak")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_led_triggers.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index 4eb7716bb9d6c..ff6e518395be0 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -126,6 +126,7 @@ int phy_led_triggers_register(struct phy_device *phy)
 	while (i--)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
 	kfree(phy->phy_led_triggers);
+	phy->phy_led_triggers = NULL;
 out_unreg_link:
 	phy_led_trigger_unregister(phy->led_link_trigger);
 out_free_link:
@@ -141,10 +142,12 @@ void phy_led_triggers_unregister(struct phy_device *phy)
 {
 	int i;
 
-	for (i = 0; i < phy->phy_num_led_triggers; i++)
-		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
-	kfree(phy->phy_led_triggers);
-	phy->phy_led_triggers = NULL;
+	if (phy->phy_led_triggers) {
+		for (i = 0; i < phy->phy_num_led_triggers; i++)
+			phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
+		kfree(phy->phy_led_triggers);
+		phy->phy_led_triggers = NULL;
+	}
 
 	if (phy->led_link_trigger) {
 		phy_led_trigger_unregister(phy->led_link_trigger);
-- 
2.43.0

