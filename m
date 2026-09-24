Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4D47D44C
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250661; cv=none; b=D3e6ER1DCgjdEgADMzndOQPxduwunqmUFc+kKlOi5a0BJ6FfSVNvn/kg9smxoklSCQBPaMviqNVoYALq5P2lTZKhpXCSJ0KxrPuWH5CeBmF0YnNUsuUls09U9yXfgsTezMR91obCLkiKESxd9I5DqulzvBxWnrXHHpU8FVig9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250661; c=relaxed/simple;
	bh=TG7EhwqBg1HZ/Vsjo9UyTxwEEVzFIwabk2MkFTGQh70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LTb8j+0DepnsPDCFWIrTrQGVaZ9dd+aOxpPXL60WZUHYsxP1bdSJLGpvmKJtjpHZJtz52MAJDCb3Fxh6JfsHymNIaAN739jnuND5QODNighoUyCVQKSpzP78FaTuIglIbb+yljshT4ktBnbqzpOogluFNudkHh/Q/9j1JwIvxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk784AKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk784AKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F81C1F00893;
	Thu, 24 Sep 2026 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790250660;
	bh=RMEjOiFdR7uAm3Iu8fQDosLQy++bvZpDoTiMkstsyok=;
	h=From:To:Cc:Subject:Date;
	b=kk784AKnM/4OKybuTNuq3D89AJjX7+y4beHyiSNdOsdWZWBoEwDrP+LZAz3JqndWg
	 eYnhN2Pq6iVakZ75Uh58ItFHkiW6tjEjassk53ib3joEJ9vmxvMroH8YSrj4vwkfvS
	 qCoerH2MzDWPwV+nNv/VEKflHp4yAOxefZBBLxhr9XwpOTeaaPe4qJPtWYq26Si3WW
	 gHf5TDl09Jgx2yrv6aphZlwUQo7vAV+z6jGhX+6VBeps3ehzfVsSNVkj1YIZrlXMoe
	 8oCD96vHUFirEEyS0jv/9KOXeYRcgrmoznKWFEdavWAdqqDhhbAHC05dim1LivZfxS
	 Jt8MQChCuX8hQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Marcin Nita <marcin.nita@leolabs.pl>,
	John Pavlick <jspavlick@posteo.net>,
	Andrew Lunn <andrew@lunn.ch>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next] net: sfp: ignore LOS also on Hisense GPON modules
Date: Thu, 24 Sep 2026 13:50:55 +0200
Message-ID: <20260924115055.196631-1-kabel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Similar to commit 87d126852158467a ("net: sfp: improve Huawei MA5671a
fixup"), in order to be able to communicate with the module for
configuration even if the fiber is not connected, apply also the
sfp_fixup_ignore_los() fixup to the following SFP modules:

  Hisense-Leox LXT-010S-H
  Hisense ZNID-GPON-2311NA
  HSGQ HSGQ-XPON-Stick

Note: tested only on the Hisense-Leox LXT-010S-H module, but applying to
all three modules, since they were all added in the same
commit 95aca8602ef70ffd ("net: sfp: add quirks for Hisense and HSGQ GPON
ONT SFP modules"), which says they are all based on the same chipset
Realtek RTL960x.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/sfp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 6bbb02117217..96361584791b 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -594,17 +594,17 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// can operate at 2500base-X, but reports 1000BASE-LX / 1300MBd in its
 	// EEPROM
 	SFP_QUIRK("Hisense-Leox", "LXT-010S-H", sfp_quirk_2500basex,
-		  sfp_fixup_ignore_tx_fault),
+		  sfp_fixup_ignore_tx_fault_and_los),
 
 	// Hisense ZNID-GPON-2311NA can operate at 2500base-X, but reports
 	// 1000BASE-LX / 1300MBd in its EEPROM
 	SFP_QUIRK("Hisense", "ZNID-GPON-2311NA", sfp_quirk_2500basex,
-		  sfp_fixup_ignore_tx_fault),
+		  sfp_fixup_ignore_tx_fault_and_los),
 
 	// HSGQ HSGQ-XPON-Stick can operate at 2500base-X, but reports
 	// 1000BASE-LX / 1300MBd in its EEPROM
 	SFP_QUIRK("HSGQ", "HSGQ-XPON-Stick", sfp_quirk_2500basex,
-		  sfp_fixup_ignore_tx_fault),
+		  sfp_fixup_ignore_tx_fault_and_los),
 
 	// Lantech 8330-262D-E and 8330-265D can operate at 2500base-X, but
 	// incorrectly report 2500MBd NRZ in their EEPROM.
-- 
2.55.0

