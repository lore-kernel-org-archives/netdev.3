Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF839B483
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506359; cv=none; b=BsMitJeukE2CV1Jsy3stcIwtj+K+hpFgeVG2C7hgm5QsBDAP+0fVMzTp1Dz9MaGbtYKniF1zmLWOlLvH77M+h10kEcjfCxN44XXlrgT9vC9UIZ7cvPTyqhVcBGGkXfiDHgIsxi1kb5RCYzx2dLLLVw0wxe+dhs+VU3b8JGBOh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506359; c=relaxed/simple;
	bh=ZnMbW+fpziZ0PZEKOCb/J5C/wBCYI4iMWttnZ2VNn6Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Wzbfo2xWDz7fubVASqQwpP1Gyw6fuKMHuIzYRuC5SZ85gaXtqb5ZDieRHN/IH/or7z9a7KSnrZzXMdFq4OzAyvXd5NX7aApIlR7R+zMoG9z13OLJZHQGkVXgBIcf61SWgIwosqhU6rMO57Ttyv6wCnGza9ATsUYCSOcmCvSLvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=AVtQyzF1; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="AVtQyzF1"
Received: (wp-smtpd smtp.wp.pl 12536 invoked from network); 6 Apr 2026 22:12:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1775506344; bh=BXbXy27fWuQinBpsk4sHIC8WyW47CIYRu1WCEgKQhb8=;
          h=From:To:Subject;
          b=AVtQyzF13Usmjo3UnXNQMacG1ZfPjgTYppsYQnP3d4zWCMO05IsaHhtE10r0hShKx
           EV5hjMp91aXBBfngH0wKFmvQGtECgV/A1Ygo7jHsZGKflbB4TpGnjBp5f8ijwXkoyI
           U9NtqEMgmbqzpK6tLHqaP5Ph3yXyvQ7OR+TLUj0TaS3cDKybCSTi+vGbiVIG+Cr2yt
           sqy/UwLARzqyUHExsocsV68qS9AJDjb/6vM6ICnBOFIrMIn68HS+Jn+TDeGR4QQvJE
           Q/fso1UcjWQVMsd112m5UpjyPowx6bNmX5qWV+eQ0oHC8J55QYAw5QUxGT9dx0vKTF
           GOTKTkaYuAYSg==
Received: from 83.5.158.210.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.5.158.210])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 6 Apr 2026 22:12:24 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	vladimir.oltean@nxp.com,
	michael@fossekall.de,
	olek2@wp.pl,
	markus.stockhausen@gmx.de,
	ih@simonwunderlich.de,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: realtek: get rid of magic numbers in rtl8201_config_intr()
Date: Mon,  6 Apr 2026 22:12:12 +0200
Message-ID: <20260406201222.1043396-1-olek2@wp.pl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: edd355c385dd0e7defdfdf90cf7b64d6
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MRMN]                               

Replace the magic numbers with defines. Register names were obtained from
publicly available documentation[1]. This should make it clear what's going
on in the code.

1. RTL8201F/RTL8201FL/RTL8201FN Rev. 1.4 Datasheet
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/realtek/realtek_main.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 75565fbdbf6d..e78f3b9e89db 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -22,7 +22,14 @@
 #include "../phylib.h"
 #include "realtek.h"
 
+#define RTL8201F_IER_PAGE			0x07
 #define RTL8201F_IER				0x13
+#define RTL8201F_IER_LINK			BIT(13)
+#define RTL8201F_IER_DUPLEX			BIT(12)
+#define RTL8201F_IER_ANERR			BIT(11)
+#define RTL8201F_IER_MASK			(RTL8201F_IER_ANERR | \
+						 RTL8201F_IER_DUPLEX | \
+						 RTL8201F_IER_LINK)
 
 #define RTL8201F_ISR				0x1e
 #define RTL8201F_ISR_ANERR			BIT(15)
@@ -346,11 +353,13 @@ static int rtl8201_config_intr(struct phy_device *phydev)
 		if (err)
 			return err;
 
-		val = BIT(13) | BIT(12) | BIT(11);
-		err = phy_write_paged(phydev, 0x7, RTL8201F_IER, val);
+		val = RTL8201F_IER_MASK;
+		err = phy_write_paged(phydev, RTL8201F_IER_PAGE,
+				      RTL8201F_IER, val);
 	} else {
 		val = 0;
-		err = phy_write_paged(phydev, 0x7, RTL8201F_IER, val);
+		err = phy_write_paged(phydev, RTL8201F_IER_PAGE,
+				      RTL8201F_IER, val);
 		if (err)
 			return err;
 
-- 
2.51.0

