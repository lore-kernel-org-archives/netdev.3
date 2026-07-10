Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEAA3D1A8E;
	Fri, 10 Jul 2026 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677681; cv=none; b=nhSvAdLdr/F0/9qhMA4JA6wO/du+qSOheCiqnrbUDJetLZXPbecVLlrhGI/eyZHUwo9g7gv6BoAi/3UbRRQ2hk90Oa1fyYAZaoWGmu0d3lQF5OhCrA9YSvFj9sLrS3yTjt3YAL7TkgfDJCo2sGYGu4D3MenP0U2jzUPNI8m8XAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677681; c=relaxed/simple;
	bh=fbvWIEu5St7hE5Qlyf31nm35SecWu0U/QrdNcl5EmNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDZgqgQxEP6Q3qP2W79dpbzwtOtGGQKPbdWGBzdAVdA0nf/gDbIYeiWZmxHGPcJCiypc9qSwGYhfJk7ML7VpPaaRxC6fA6an4Pu3xI179XGMCdAkIgr9Av+GqgSVS99/klnVJnx435l4B3+ycAhfk86gLw4+YObU6Z/Ud7JJDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from Vostro-3710.. (unknown [113.80.141.85])
	by smtp.qiye.163.com (Hmail) with ESMTP id 45b7e189b;
	Fri, 10 Jul 2026 18:01:06 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: David Yang <mmyangfl@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] net: dsa: yt921x: Fix external port detection
Date: Fri, 10 Jul 2026 18:00:00 +0800
Message-Id: <20260710100000.3018614-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f4b7943ef03a2kunm8a305c661062d1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSRgaVkkeH0wZQx0dT0hMTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSkhVQ0tVSk9KVUNOWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++

The YT921x switch has two MAC ports: 8 and 9. Currently, the driver
only allows port 8 as an external port, while port 9 is not working:

yt921x mdio-bus:1d: Wrong mode 23 on port 9
yt921x mdio-bus:1d: Failed to config port 9: -22

Update the external port detection logic to enable the external PHY
connected to port 9.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/net/dsa/yt921x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 555046526669..5f3b99e189c4 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -854,7 +854,7 @@ enum yt921x_fdb_entry_status {
 #define YT921X_PORT_NUM			11
 
 #define yt921x_port_is_internal(port) ((port) < 8)
-#define yt921x_port_is_external(port) (8 <= (port) && (port) < 9)
+#define yt921x_port_is_external(port) ((port) == 8 || (port) == 9)
 
 struct yt921x_mib {
 	u64 rx_broadcast;
-- 
2.34.1

