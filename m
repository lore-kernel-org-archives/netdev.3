Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB232860B
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539131; cv=none; b=SMSnEouZz222GNANRLuNwEh60LlDvSl3CW6qrJ7IyAEy+24HD3kGeFxCVFCaWvNYNpAulCHDelSkUPHyMgw8xYLwkeMtl+JL7Wnmhvg3ZeWSTVkwGv4tGrp6qhCvZCPdK/FtMYAFGWexf7NlWwNAUGez37bYiEQ98yamX3cG69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539131; c=relaxed/simple;
	bh=zQsv1SxLw80HByEkrRnwAzZiBPxpnZQgyvEAyu3vhX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNAFFkl4tFkJVZghQJ3F4dOH+N0ZmBrTkg1S/m67XTE7uAC1SW+d0fnVxWlpKq5xFMkmt414qeRXvzFlLQanluwU9UNhk1VA5N558/alrCbH/aqzwffJeBlpWJig/i1Eg4zDH6QGYQR25H2uWQx1l+yY5zwo8nTGEIl1i46d7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cG+Hjj9g; arc=none smtp.client-ip=95.215.58.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cG+Hjj9g"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zQsv1SxLw80HByEkrRnwAzZiBPxpnZQgyvEAyu3vhX4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786539127; v=1; x=1787143927;
 b=cG+Hjj9g3BWKmZDP4j0cPIUBsQ7inbl69EOARG/7PZJu++uuBig2cfbSdG7wKSNaE5dmJzLg
 t+SaZJvKzrhP54tIe9VPqZCiKd6kAsfYCUnVUGkNh2C39qUvKQ/ZJ5L+YzBlctA4KxUR7lee9bR
 dpfSfn3r+kuAMPmTSbU4oOHg=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 15b4380ad7f88e16;
	Wed, 12 Aug 2026 12:52:07 +0000
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1 2/2] net: phy: call driver remove when core initialization fails
Date: Wed, 12 Aug 2026 20:51:27 +0800
Message-ID: <20260812125127.106255-3-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812125127.106255-1-xuanqiang.luo@linux.dev>
References: <20260812125127.106255-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

phy_probe() may fail while querying features or completing other core
initialization after the PHY driver probe callback has succeeded. The
driver core does not run the remove path after a probe error, so
resources that the PHY driver releases in its remove callback are
leaked.

Call the PHY driver remove callback on these failures.

Fixes: efbdfdc29bdd ("net: phy: Add support for asking the PHY its abilities")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f8e434daab66e..be714758360b2 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3705,7 +3705,7 @@ static int phy_probe(struct device *dev)
 		err = genphy_read_abilities(phydev);
 
 	if (err)
-		goto out_reset;
+		goto out_remove;
 
 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			       phydev->supported))
@@ -3722,7 +3722,7 @@ static int phy_probe(struct device *dev)
 
 	err = phy_setup_ports(phydev);
 	if (err)
-		goto out_reset;
+		goto out_remove;
 
 	phy_advertise_supported(phydev);
 
@@ -3799,6 +3799,10 @@ static int phy_probe(struct device *dev)
 
 	phy_cleanup_ports(phydev);
 
+out_remove:
+	if (phydev->drv->remove)
+		phydev->drv->remove(phydev);
+
 out_reset:
 	/* Re-assert the reset signal on error */
 	phy_device_reset(phydev, 1);
-- 
2.43.0

