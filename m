Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C9383312
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291868; cv=none; b=DKmYqRvGRhXUacUTBiE3EDmDY8UeGDYOt1Fnex2Gyar/1bpjDg6T30nIWKNJXYY6HhcT/WUHtBe1FmUf97UkxHrKfcGIViS1QajgO/E4z6IoNqxhcC4whFNG/2ec+ftHxgF2mJ3PvKJW8cEY/dOArLx84JfJfJ6SgJrjcWpNc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291868; c=relaxed/simple;
	bh=VegC6J9gni9wLSQrbDq1hZYsQqCQiWAPBDqy/WYEg0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e61V2QRMeKPLplOouYQ/YxqtLDNXH0V3P8BNqmkyE08HODwlMDAwDqnYXz5UAhefeEGnav/mj7YRL+9kRsqW5JUBXBjtODpyhGEgZlG9kaG5tmRUJrA+4l8KFiHu69ySUIVyOaKmEixBd752wsFg7GT2XHyP870lEdw8s1gcdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/RIhTyc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/RIhTyc"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e58034d05so471481a91.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 22:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787291867; x=1787896667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p4zubKJfP4d5jonGYtKrpPAyp+ZFeoBJ9/vh3Z7kgRY=;
        b=G/RIhTycuaI5NaQuj3io/qYgL2Q+GnpVaHW0tVVhEwm/ZqtVTG4CFjYsw0YhxpkPVW
         Ny/Hkr/jnXnbq4el/mFKU7M0YNl5THx0ItqA9xSUjP1O2fwkm2oChWlszNzyXfM6xIX1
         cVl84mJC8rLoOEaFIpmPGGmkoXhJvDWd9NNwm83u8DY3V8icKZVfkQSnFzGTkmDt+Vuf
         7GA0h1msG/KIAp5Pe1TNyjYIF52qWMRhmfD79r4jTR+5CAtjOlhURaFThhSY5QmzbX1G
         nDO7g+jJ8Zg1sb6uUpYMnfEm0L2L/+EmnwbqUBhgSGSY+Za67jkd2bRjLZQtZYmJfeWd
         UEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787291867; x=1787896667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p4zubKJfP4d5jonGYtKrpPAyp+ZFeoBJ9/vh3Z7kgRY=;
        b=SOkMOW01ahc5VnSLjyoVeZEMq8fGQKl7TZPugqYAUinarQfnCmJRF+AEV5ciOCEtgd
         x54StiSCF11rZN6rRo+ZYMXmaFpXQM/Wpg/uwRivAVPRcG3yqtBwOGm+33kkE7EzGs9R
         kOwtBV41QO12SjKlKXu4+px3MAiT+Fydj4gaR+i3iSiUPQYmDf9KlZT4lGhYXRvUFln9
         VgwnBiIAdpP5iv49gBoFSF9tS9sVf4b9DgjiBFSo/1Z41NXErZjUQuP+ZkisV7xUaZbq
         TKDwOpph6SO72CMgk7S5uZp4SIJAP0zkzezTn8cIEGedNgLCP4sEkZDuyCiLmCdngt7x
         8BUg==
X-Gm-Message-State: AFuF++lK3AZIn2nfl4mRy9yNmMbrws2qb9GQzD0iCMZMg09o/2OO59+1
	5wmcE3YtDA4zA3lKhqWlleCSZLD7nZIRsWsBxp5ySp8qyAwzKWA1nDq4
X-Gm-Gg: AR+sD13ZoHb7U9m7zQv80+NTQBVesszfUxv0TKe1a6273uEIxNUBMfnKQckUNlzkRdq
	USdZWgiwnP9KkflhCvdEpCttKiyQagKD87rLaMdbZOY5nlAj6+lEVQ2iCsdlfWNLyij1M+2h1oC
	fJYkEu/iLkiOKb07oI5Dor2z1cjxmUGKYWq9Y0f2hG+8LgIAyHDQflycm6dfnY+82QSsZGlUVX2
	srUfkIr164ihyL2FKuwNQ2F2nUwHbOF5MMt5DJvA7LLtGSn9yhfXXsaHVsfkXEXRErhdQzc574V
	0UyEzyEwGjiCGkwVCI7XV29Merdcl0dAHwIFjP+OR5aOx7Seimo/UNWNnVs0X19z82WExGoisui
	QPZOq9JF8JCGQhzwAmQMTjCMTJMTgNwAx6+eeQN1nIMeFoYT35yH6FtxfIOVEjAAe8xIhhP9cm6
	SianiL6/Lu636rc6K62rdyAom+nG5fV1qo3X1IeA4cbBO4Qwg5m0dAwIJmhV92xqfYDqCDRUBrp
	01LjIJjUQLyv+gX3/iyhcoL+XlXFQD+Yxes6sdvvFKDqZ4=
X-Received: by 2002:a17:90b:6cb:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-395c2f13243mr8189537a91.0.1787291867058;
        Thu, 20 Aug 2026 22:57:47 -0700 (PDT)
Received: from DESKTOP-8BCFI4I ([202.12.123.126])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad3dd15sm20391581c88.2.2026.08.20.22.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 22:57:46 -0700 (PDT)
From: Md Rabbani <rabbanyhmm@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Md Rabbani <rabbanyhmm@gmail.com>
Subject: [PATCH] net: stmmac: fix device node reference leaks in stmmac_mtl_setup()
Date: Fri, 21 Aug 2026 11:57:18 +0600
Message-ID: <20260821055718.57-1-rabbanyhmm@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In stmmac_mtl_setup(), q_node is shared across the RX and TX queue
parsing loops. When the RX queue loop breaks early because the number
of parsed queues reaches plat->rx_queues_to_use, q_node retains an
acquired reference count. If the error check passes
(queue == plat->rx_queues_to_use), execution proceeds directly to the
TX queue loop, where of_get_next_child() immediately overwrites q_node
with the first TX child, permanently leaking the retained RX child
device node reference.

Switch both loops to for_each_child_of_node_scoped() so child node
references are automatically dropped upon loop exit or early break,
and remove the now-unnecessary function-scoped q_node variable and
its manual of_node_put() at the exit label.

Signed-off-by: Md Rabbani <rabbanyhmm@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index dc5f951a31..6128ed1bd5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -130,7 +130,6 @@ static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev)
 static int stmmac_mtl_setup(struct platform_device *pdev,
 			    struct plat_stmmacenet_data *plat)
 {
-	struct device_node *q_node;
 	struct device_node *rx_node;
 	struct device_node *tx_node;
 	u8 queue = 0;
@@ -169,7 +168,7 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 		plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
 
 	/* Processing individual RX queue config */
-	for_each_child_of_node(rx_node, q_node) {
+	for_each_child_of_node_scoped(rx_node, q_node) {
 		if (queue >= plat->rx_queues_to_use)
 			break;
 
@@ -227,7 +226,7 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 	queue = 0;
 
 	/* Processing individual TX queue config */
-	for_each_child_of_node(tx_node, q_node) {
+	for_each_child_of_node_scoped(tx_node, q_node) {
 		if (queue >= plat->tx_queues_to_use)
 			break;
 
@@ -276,7 +275,6 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 out:
 	of_node_put(rx_node);
 	of_node_put(tx_node);
-	of_node_put(q_node);
 
 	return ret;
 }
-- 
2.55.0.windows.3

