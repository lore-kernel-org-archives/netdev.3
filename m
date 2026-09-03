Received: from mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0A37756A
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423026; cv=none; b=XVCSnKwGdAa4FTvXUOY2IeggyHVdvMG7P/oNuZLmS6abB6eIA7Tdj+g2IMSTzlhRqrgJHNR2NWyHA6SbS1k3QQ47W/UyXyRYZXpnpylfr1cdkT4Hj36nRPad5tjwgzfC7Yyzj9imUlZGnsB0wrFrC26GuegvwHoVAuxb9Q3Cjy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423026; c=relaxed/simple;
	bh=WNzNi+Fi0D5M1zjbayGX6xW2DqCZ/1Xp7MKHBohSweI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZdekXYwlUWT+VXuPzuMqEsVkKnw0rEShejRcDcOkqk5/UqwpMlYaJpTPyXLpA+Ue1+gHO9F1NviTYhndtZnAni0M0SxBPERiaHQZcXecDjCfRz/5wP2qGLzcaJVHy9bkCNUamiz8AGvLSFu1fbJEIg7CmeJPxIbb0DqOrAqyWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CaIH8nYA; arc=none smtp.client-ip=91.218.175.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CaIH8nYA"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WNzNi+Fi0D5M1zjbayGX6xW2DqCZ/1Xp7MKHBohSweI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788423021; v=1; x=1789027821;
 b=CaIH8nYA77MK5Reik2lPPT5qGHrRU+r6K6GCjgjqwY7twZcB8Ayn/h1TyQshYN/9N5ln5VgW
 A7A3oO/ClJnaE6u7tO+mQeusA7altvz0/SA+WDz2CGFP9TBDsrxpQIJAtUvRST9hPGgD9eOEOTZ
 KaUqalONwwcG7Vp4N9tbLoMM=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ec4dce2f0100e021;
	Thu, 03 Sep 2026 08:10:20 +0000
X-Mizu-Trace-ID: ec4dce2f0100e021
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 03 Sep 2026 16:10:09 +0800
Subject: [PATCH net v2] bonding: fix slave_cnt leak on XDP error paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQqDMBBEf6XsuSkxrRp76n8UkRg3dalsSiKhI
 v57Q449vhnmzQ4RA2GE+2mHgIkiec6gziews+EXCpoyg5KqkVq2YvQ8DXExCQfLq9AaW21rJ83
 YQR59Ajr6FuETGFfoczhTXH3YykmqSlV8nVT/vlSJSlwb7OrR3Uzj3OO9LcQ+XixDfxzHD08oE
 ieyAAAA
X-Change-ID: 20260807-bond_slave_cnt-88e78c5f0ab9
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Jussi Maki <joamaki@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

When bond_enslave() succeeds up to the XDP setup stage, slave_cnt is
already incremented. If XDP setup subsequently fails, the error paths
jump directly to err_sysfs_del, bypassing the slave_cnt decrement.

This causes slave_cnt to drift upward on each failed enslaving attempt,
which would lead to unbalanced traffic distribution with round-robin
mode.

Fix it by moving the slave_cnt increasement after XDP setup.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Changes in v2:
- move the slave_cnt increasement after XDP setup (Nikolay Aleksandrov)
- balance-xor mode is not affected, not mention it (Nikolay Aleksandrov)
- Link to v1: https://lore.kernel.org/r/20260902-bond_slave_cnt-v1-1-36e95bf4a6ff@kylinos.cn
---
 drivers/net/bonding/bond_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 947d92a669b6..f3290aee50d1 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2284,7 +2284,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		}
 	}
 
-	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
 	netdev_compute_master_upper_features(bond->dev, true);
 	bond_set_carrier(bond);
 
@@ -2339,6 +2338,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 
 	bond_xdp_set_features(bond_dev);
 
+	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
+
 	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
 		   bond_is_active_slave(new_slave) ? "an active" : "a backup",
 		   new_slave->link != BOND_LINK_DOWN ? "an up" : "a down");

---
base-commit: 70f3995830d3f1e79faa14eb0605914f778feca9
change-id: 20260807-bond_slave_cnt-88e78c5f0ab9

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

