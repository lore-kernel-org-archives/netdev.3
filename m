Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992F39448F
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 03:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295252; cv=none; b=guznBL2Zyx/UIaF0OSU4H8eumu5/F9m/W2FnDiDpTnf6f3IkyWhyHx7XXMv+Pv4F8cdIf+orN+YyMGWtacd6av6Qmx54rq/dFyDrA7QHpxeOr0oPqaK2O9LcKB8n+MkdYhm9jNA87DsnMlE6aXmLFuHvQ1w84xUhTGkE1IfzVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295252; c=relaxed/simple;
	bh=vIWIxpdpuQlriXmpXA2oXlhyae4Bl6gOBf5gcdiv+SI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gFwgQg6g3Cdh1Ofwi4O5G/tvKzQu8lWSIGwTREZK9wWPQ4F2pXWLkqcpQXUL2fniegcjRm0l8BBWkzs/N4S+ayELitEzgas5F5JM7fOSwRjQkwWkXcMyN14OpSY7ahSF0ecxDLCfTURY+unbh0MiJz6NV4Q9FqM5p3OFLBHxaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZX/fAxC; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZX/fAxC"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f2493c28bso101097685a.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 20:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792295249; x=1792900049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iyn+0emapJRMFzmJ+yA4KQX+FkaLwrtKwIvJ6VKAF2o=;
        b=JZX/fAxCwyykSJwNz1yUMfrQWkQFD645Oy0UGjKUCVavnltz7uojMPhbNMocD4A3VO
         nsUK4KZx5w4psWj2XDCNamz50R1caflcNwqyQD1n7Zfks9+O3UhCUes4mY4keIpdfm/t
         IQrLYVNnLm12xIO8nOKdUZ0qVI0u+ebsXxoWqAx7dgyS/RNUt7bZVpplLi78hN+Rs/b9
         15Ly/YbAgruLBqMcTgfK84nuoi9Rijv2r4dZhDy29hb/rUsvsKNe8lHXekhwcByiGXD/
         2A4kYTu76bPEPCyoJGKiuebgRkNV/sndNEvSDM9g1HSPoztIVeyckJIx718CpbRIykGQ
         GTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295249; x=1792900049;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iyn+0emapJRMFzmJ+yA4KQX+FkaLwrtKwIvJ6VKAF2o=;
        b=l48bnEMFQYqbzBu/sMkmO7nMPvf6l0hjc5E2/fVDALT5LjsSp2ENOqSMnrCY42ThG5
         q8PwapuVupuyNlqLLR7Qq04UqR2PGKUTuNjS0kz8wptsLjf1pNPzukbdvLw3tiTn5ire
         6aCcg9I0ypzeqjzMbtXAaFUV2Zym2hIJlJdXilnEYJ0IcN1TSE3mmT9pa5mg7t239cLp
         0qfSttCPcvciuUtzwhIgN0WX5FL3frR8gHAe2r1WJY9/rvegnqZR2BXnMnbOlewQ8bv6
         7SJhKxleppl8ITJol6l4j0FdbSudCkGvb0uZorXiOuHWrXwy1hzi8we+3yZS/TGkiXBH
         GxHA==
X-Gm-Message-State: AFq9FYKqEOywzIObO7Gbx4A34IT7OQKCwAJET0ScD75p4AbBTtxfeei3
	RwxopsXGB3fnnj7bzgn2RgB2rkTddYxPKeUz1bXT0Ofhk+PfmrVSagc=
X-Gm-Gg: AYBFou1Jn9TOgXTBr0W+ozBkkKfWTiV1PEJogylN++uJV4H7+lptlnICsD58N6HbBg2
	LaH2ZQn9qxKQHmsxi6VpKP4mW+GGdY3DWpkb1fBB9IrM38A1hf0Fe3wKOzOJjjRNMEplpG3mnNM
	mJoZywnNn680k77APwJwaDCEC1pq3JQj0HNuQi1ntkndL0sL0aeK2FLM2leMk6XnnAGIAh+W1Jq
	0+Lgj1DX1Uk2ReVmALiNVpYt8ChT9u5RgYsplpb+wsPkyjnAmreAD0KvfmO8z5oCvqamTdPiOfZ
	jAu5lCe64BVcbV9seHEqb5TzqCiLNeVxcAVOoe4rgysuOTb+ovZUS4CR5LgmiByx1fa8uRp+3gf
	PXL6mfBdq1Xk9NPyJEVAlkxr+7ROVqNyPNS/2TpBSA5bP/jivYRWHUMBGDy4dwkaXW+eac7nZ2a
	R6LttxrwlwvLBTSPf0XZUrxvujbKrsawbl6VnXYI+kgvaruVEsZUIJfy/OCKRH1BItg+Qtn9dn6
	YHHmqwML9eGtEUZKiRDJcGJanZ/77JE/Na9TIVv8Y4AeZ5bUDYLHHumMqSISSmPbt1KLzKtki95
	bvlb+iznJiwqteZXKnv/4HFUWkoPFg==
X-Received: by 2002:a05:620a:408a:b0:93e:c12c:9b6b with SMTP id af79cd13be357-93f29dc678bmr715284285a.70.1792295249474;
        Sat, 17 Oct 2026 20:47:29 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a16c21esm611054285a.16.2026.10.17.20.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:47:28 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: pxa168_eth: quiesce the interface before releasing resources
Date: Sat, 17 Oct 2026 23:47:26 -0400
Message-ID: <179229523656.3967907.9986872484125740449.pxa168-eth@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Canceling tx_timeout_task at the start of remove does not prevent the
still-live netdev watchdog from queuing it again. The recovery worker
can then stop and reopen the interface while remove releases its
resources.

For an up interface, phy_disconnect() clears dev->phydev before
unregister_netdev() invokes ndo_stop(), which then calls phy_stop()
with a NULL pointer.

Disable and drain the recovery work first so subsequent watchdog queue
attempts are rejected. Close the interface while holding RTNL and before
disconnecting the PHY: ndo_stop calls phy_stop() and must stop DMA
before the coherent hash table is freed. Keep RTNL through
unregistration so the interface cannot be reopened in between.

Disconnect the PHY before unregistering the netdev, while both devices'
sysfs directories still exist. Release the MDIO bus and hash table only
after the interface has been unregistered.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: bd70957438f0 ("net: pxa168_eth: Fix a potential data race in pxa168_eth_remove")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
Compile-tested with Clang, W=1. No hardware runtime testing.

Based on mainline 0fcb05b72344f40806cbe810de8872f1698bf053.

diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index bbbbbba..2d59491 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -27,6 +27,7 @@
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pxa168_eth.h>
+#include <linux/rtnetlink.h>
 #include <linux/tcp.h>
 #include <linux/types.h>
 #include <linux/udp.h>
@@ -1528,18 +1529,21 @@ static void pxa168_eth_remove(struct platform_device *pdev)
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct pxa168_eth_private *pep = netdev_priv(dev);
 
-	cancel_work_sync(&pep->tx_timeout_task);
+	disable_work_sync(&pep->tx_timeout_task);
+	rtnl_lock();
+	dev_close(dev);
+	if (dev->phydev)
+		phy_disconnect(dev->phydev);
+	unregister_netdevice(dev);
+	rtnl_unlock();
+
 	if (pep->htpr) {
 		dma_free_coherent(pep->dev->dev.parent, HASH_ADDR_TABLE_SIZE,
 				  pep->htpr, pep->htpr_dma);
 		pep->htpr = NULL;
 	}
-	if (dev->phydev)
-		phy_disconnect(dev->phydev);
-
 	mdiobus_unregister(pep->smi_bus);
 	mdiobus_free(pep->smi_bus);
-	unregister_netdev(dev);
 	free_netdev(dev);
 }
 
