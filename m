Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958E3C3432
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574411; cv=none; b=d8GOVsCkRZhysMzkp/vabt/dbikh3E9otCp5AkEAPFRcbyYpO/5/X3tggmVt/pYSVzsRnkA0wbB5sNTVksa50wZ7tUD+vKXyyZEPxdMza0j2lszj0bwa/zRbJABePUM6ixrpmaIRZDL+cyrHao7i1tPcKYqBvEoDcL6k7SeqoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574411; c=relaxed/simple;
	bh=VLSGmShOghrSXYnI4aK3+vKI8/mp2m0WvnYejAiprmg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=WhX2DiAV5Lu8BH0pOO8KhwcHhSRO8NB1t6ZK9QEe3TjNrgPKOiGjWDgHIrGKYaHsEG4gHTr5aKjhm+nZnc0pGFK/2Yors+qHL+uM2S+dBB9bEUxyloeCgaiDtVkZ/liTkhf0rJC+b8H2huPGj1aTfH9uk/dkBStEphucqCkGPRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ZAp2Ge8G; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ZAp2Ge8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778574398;
	bh=4vlvKM82lCQ7lznrUp6GIFP8zOg3p1TWy6CDl/8s3JQ=;
	h=From:To:Cc:Subject:Date;
	b=ZAp2Ge8GJcpTOFSqnKfzYQAhrfuXle45zDpt2QCa+gzuU8zZb3T7Bpjv/DQhGLQBo
	 8Rq2+4sHxOFl3jnvVwVPp9TYRT9alYDFedcEGZOLXHu9QNqAshSUR0lvfphI6uuums
	 pxMc71GzJ1RUW3VHBlwatVrWhAQ4dsSEzocLVK5w=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 6573A662; Tue, 12 May 2026 16:25:23 +0800
X-QQ-mid: xmsmtpt1778574323tbnhh6kx7
Message-ID: <tencent_F7CCFD2243D4A5BBFDEDEEB978E0E6479405@qq.com>
X-QQ-XMAILINFO: NYWR1JZzYCQ4zLaCbra3jtVFTKWuBvr+mb6MuR2M23FdU+lVyScX/pnzjE8C8g
	 GTGdinDO3hHZG2yj6VRJDAdT79+2uIhp2ejOduoXo4MnvBT1K5f07sfuFTGSqnQhSX9qUf3jEbvs
	 wuzb7N7zOzE5Bq9HR4BHqmc/QYtT6cQfffy7uq9Fi6KE9W5g5W3FPSLpnuOojHzL1VIeXfupqArJ
	 9ZckaT0HvZt68514oDX3gEYxMMB9b85O+Xu5QGBHzqP6NrIniHjbvpGgcsw4T6ddpeiuOvpdJTED
	 Mn5w3X/HSInrWv9WLCmlAcyjFhfn8dj/DvZ13K3B4AykKje+GM2x1tA4zscM3eO0+RHqQgCZOMmg
	 KTRMym7vGjCom2vB8p5fbJc3Ni75RfDxhfZf//Dq63+1YsxJbAc4Dio2PwBcMehwGMEMlkumO23/
	 z83x6eZCjXLYvZDQaxdf3+/rOZ1mh+/+MN/BA3C8fTLhlverSsvIelALiNP7zlI+ci4W5yUM1qbU
	 1ptM4opD+cvwXjFhmODOpLznB0dkUFWYJCX0jiG+EYnQ73FTgp2Yh0r4nvTm47fGZhZMph7bzAN8
	 TG2v8+EJ4LuSYUCDUh6Jts/EsHGHIgtFItSKcYv8bnixzqvtK6Q3djNBdYXIytYYoqfcc0UkdgNc
	 Kv33rrrMgd6RI4prjHROhpR9QuYTLNdtYz/rZxmh+ckaU5vVyaCVPRfEO4HtbyUqH0hjUykvj5we
	 TjKO0tHOZiddY87/+C8uPgYiRC1NrbxiIiWSNybyeElZZAxLDWledz7l66o7H9vOuFXQ/LDCleBx
	 oPiUdrZ63gyM1tBHHnKGE4vEHd4yBVBw8eqLgOcqJFVoALH6mYuzKu3HJIowcRVmte2cEDpwVG+B
	 gMjOlQDlUxQ0UcnRKNxMDSeFSkYYLxF9jFO7YIPNJAUe6ZC1xtEJ/hXKjlEEwkdzKwx2gFf8YBbA
	 F1WxhDU9MneJUkIm5Px1xJ4N60wBgZCR18KS1p56VfDi8wIzLMx1eKWGDFVuN7FeI6xQr0zgM=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Zhao Dongdong <winter91@foxmail.com>
To: davem@davemloft.net,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH] net: mdiobus: add mdio_c45_bad_oui_list for mdiobus_prevent_c45_scan
Date: Tue, 12 May 2026 16:25:21 +0800
X-OQ-MSGID: <20260512082521.382202-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

Added the mdio_c45_bad_oui_list to facilitate adding more PHYs that
do not support C45 scanning.

Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 drivers/net/phy/mdio_bus_provider.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index ce3a607a40cb..928586602eff 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -522,15 +522,21 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
  * devices have been found, see if any of them are bad for C45, and if we
  * should skip the C45 scan.
  */
+static const u32 mdio_c45_bad_oui_list[] = {
+	MICREL_OUI,
+};
 static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
 {
 	struct phy_device *phydev;
 
 	mdiobus_for_each_phy(bus, phydev) {
 		u32 oui = phydev->phy_id >> 10;
+		int i;
 
-		if (oui == MICREL_OUI)
-			return true;
+		for (i = 0; i < ARRAY_SIZE(mdio_c45_bad_oui_list); i++) {
+			if (oui == mdio_c45_bad_oui_list[i])
+				return true;
+		}
 	}
 
 	return false;
-- 
2.25.1

