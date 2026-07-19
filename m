Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964D53812C8
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784455730; cv=none; b=dRmqx/GYR7s4zllxou8Ila227zXN0GT6qBjhgII4o9qDpPhOY+4Zvigz47lnLAR76ztxxvYQ1LOV7Ep7xaPUiC3SypjRrMH5mm2PdRwHirE9y2b8ahphpBzsDvucFp+9gscM45UwEn7IiWWeWd3RvNc+u2lgz81INWcQ9DAAxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784455730; c=relaxed/simple;
	bh=kujYwA5huiR00a5moC2jXD5JT7I3K2qi4rdIjitwZ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiEPdHPOizZ+Y8H4hk4K8/mi54EIErqavkF/IQDJV1Xy4Gzh/b4IbahzgeVhZmpm1k5JRW5vsLXpWnzgtRLMkzOtwKV6psJsHfDB4eGHkYOmXJ2pEoXKck1muwEwssB2Mrby8jzfTvtolCsx0adV61pC9xcQ51sWMMqcosUBq6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=XMJSHXpT; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="XMJSHXpT"
Received: (wp-smtpd smtp.wp.pl 8891 invoked from network); 19 Jul 2026 12:02:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1784455320; bh=NTjFPtMAcH5zVgMn59JZ1WDUM6nit5XlJiJgUbI0jW0=;
          h=From:To:Cc:Subject;
          b=XMJSHXpTbmhKPAbkN082ouBMsWfGkFPP2/W//UyDHqa7qsKkROWfTQ378wq0/aTg4
           RyjTNxFyxt3w6YI4Pm7ly+3U3JoBPyoZZ7W/ectSPpSgMHc78SijTsQSC5gA5PyuhA
           46HNavUXRJd0fQc2LaM9CTlqDnwplWfxc3P3juR8WGldZiBA2NdgIp4lWe17u878AG
           ALJftXUFT8QJH8NKgwyhSu+Zb07p/dQaxyLum2y2eR7XCyou3tTH143xKnk3WDJDnP
           D5/a9nN7SE2oQHcygZTJr7DiYFjrw59FkIouFdK1f8JjhCSFANmaWe7LQlGd8zsl1y
           JREdYfUX8RKeg==
Received: from 83.24.141.3.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.24.141.3])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <linux@armlinux.org.uk>; 19 Jul 2026 12:02:00 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH net-next] net: sfp: add quirk for HORACO copper SFP+ module
Date: Sun, 19 Jul 2026 12:01:55 +0200
Message-ID: <20260719100158.874882-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: df7ffee50f79839d448a9667e2fb647c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [cbJ8]                               

Add quirk for a copper SFP+ module that identifies itself as "OEM"
"HC-10GE-113C". It uses RollBall protocol to talk to the PHY.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/sfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f520206734da..6c25b73c668a 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -594,6 +594,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	SFP_QUIRK_F("YV", "SFP+ONU-XGSPON", sfp_fixup_potron),
 
+	// HORACO HC-10GE-113C uses Rollball protocol to talk to the PHY.
+	SFP_QUIRK_F("OEM", "HC-10GE-113C", sfp_fixup_rollball),
+
 	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 
-- 
2.53.0

