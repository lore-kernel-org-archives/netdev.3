Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A525D530
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787457392; cv=none; b=GTSf8zUS/yHVJ7D2o3g3C90a+87kUECU41Q9cnSragD70LxlzZ1t1ABBn/ZN/BLeScXixQ8hwT/eX29pJC7SSBB6F3x4LxfI4n95cMajIrSJhme0PqwHapwNsgTTQWnqTV/DBZyM+1ka2uO0OnZjSuR+XBepa0BBLenDar87GFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787457392; c=relaxed/simple;
	bh=GvttE+5qoZxwgHSuqBfxoxt73ASry55/zhgE1ht6V44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxvWrE51jpIQ81xwlCiZdou4wmGeFhWdSWsG5JkQIAqooybq0y8+gtl6cCxsK57KMdg58h0smNuGHL1foBhp5pYiGmKJDoTy8nqutJ1Sa2AhrS7z47sRQVoQq0tpA+/4HVWsyP2silNlkJ8yvsBXPX+gTEeuVGvqZzwvCsr4MME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o6d/xRNB; arc=none smtp.client-ip=95.215.58.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o6d/xRNB"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GvttE+5qoZxwgHSuqBfxoxt73ASry55/zhgE1ht6V44=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787457388; v=1; x=1788062188;
 b=o6d/xRNBKt5SaEMewZFAfykW10zn7tuUSGFDNndBxfGkDJi7nVVAbgy4n8Goo0jh6NNv4r2t
 5N/aCvVrPHOxptTYPNQRVJYRHjVKdfWiBFoe2+Omliq5QXmKzHtNG0oTr6t5TqnspqAKP9906uc
 jZ3sfIfm+ZMPEIFR7vTPH8XU=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 07ca76bdfaf43557;
	Sun, 23 Aug 2026 03:56:28 +0000
X-Mizu-Trace-ID: 07ca76bdfaf43557
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
Subject: [PATCH net v5 1/6] net: phy: split phy_probe() error paths
Date: Sun, 23 Aug 2026 11:55:55 +0800
Message-ID: <20260823035600.188864-2-xuanqiang.luo@linux.dev>
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

phy_probe() uses one cleanup path for failures at every initialization
stage. This runs cleanup for resources that have not been initialized.

After a successful probe and remove, phy_led_triggers_unregister() can
leave phy_num_led_triggers non-zero after freeing the trigger array. If a
subsequent probe fails before LED trigger registration, the common error
path calls phy_led_triggers_unregister() with a NULL array and stale count,
causing a NULL dereference.

Split the cleanup by initialization stage so each failure path unwinds only
the resources that may have been initialized. Unregister LED triggers
before releasing the SFP upstream and ports, because the LED triggers are
initialized after those resources and must be unwound first.

Fixes: c8dbdc6e380e ("net: phy: register phy led_triggers during probe to avoid AB-BA deadlock")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a37..2cf70471ae089 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3706,7 +3706,7 @@ static int phy_probe(struct device *dev)
 	if (phydev->drv->probe) {
 		err = phydev->drv->probe(phydev);
 		if (err)
-			goto out;
+			goto out_reset;
 	}
 
 	phy_disable_interrupts(phydev);
@@ -3727,7 +3727,7 @@ static int phy_probe(struct device *dev)
 		err = genphy_read_abilities(phydev);
 
 	if (err)
-		goto out;
+		goto out_reset;
 
 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			       phydev->supported))
@@ -3744,7 +3744,7 @@ static int phy_probe(struct device *dev)
 
 	err = phy_setup_ports(phydev);
 	if (err)
-		goto out;
+		goto out_sfp_release;
 
 	phy_advertise_supported(phydev);
 
@@ -3753,7 +3753,7 @@ static int phy_probe(struct device *dev)
 	 */
 	err = genphy_c45_read_eee_adv(phydev, phydev->advertising_eee);
 	if (err)
-		goto out;
+		goto out_sfp_release;
 
 	/* Get the EEE modes we want to prohibit. */
 	of_set_phy_eee_broken(phydev);
@@ -3806,20 +3806,22 @@ static int phy_probe(struct device *dev)
 	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev)) {
 		err = of_phy_leds(phydev);
 		if (err)
-			goto out;
+			goto out_unreg_led_triggers;
 	}
 
 	return 0;
 
-out:
+out_unreg_led_triggers:
+	if (!phydev->is_on_sfp_module)
+		phy_led_triggers_unregister(phydev);
+
+out_sfp_release:
 	sfp_bus_del_upstream(phydev->sfp_bus);
 	phydev->sfp_bus = NULL;
 
 	phy_cleanup_ports(phydev);
 
-	if (!phydev->is_on_sfp_module)
-		phy_led_triggers_unregister(phydev);
-
+out_reset:
 	/* Re-assert the reset signal on error */
 	phy_device_reset(phydev, 1);
 
-- 
2.43.0

