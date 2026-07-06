Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4596423773;
	Mon,  6 Jul 2026 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339610; cv=none; b=tpfCABbwd0Gh0pXUFwz1VrL2fRFnFy6UrUjpK69avB2wC86Yt+dyQon9yE54uSrs5DQqN0/08iDgW7y0I0B1wRBB3KDv7TWAAhX/2hjXvwFBGZhfAhBzNpR3vjlAnuMD2ybgmk9C1e/ka4+uUQky7FMcQNLL5b23h6gu3Qvek7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339610; c=relaxed/simple;
	bh=bSePxGlPV78dUbSgcZaZysr7JG3efJZaJDSGKaNO2cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DnO4aRSEuPzEveUIPEkBqYNwk44LGIMjM/qO16MQ0PUdlP8RHW4e8pKB5fN9Zjgynim1ugl6QYf+AQuRYPvfYb3sv1ZFYmyldFFX87EaeSXzyI6d3r6l/OwVTLUFukLpDlFXBYP4p/tF8N8njrozbB8kSuJlNrhgxduzLn4EYko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgabhSAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgabhSAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C911F000E9;
	Mon,  6 Jul 2026 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783339609;
	bh=oZnk++9zPHxagMECbgGisjnpDlRwKv6L5/Tjkd0+JKc=;
	h=From:To:Cc:Subject:Date;
	b=FgabhSAVE15AuD/y3njCkZM0a5YhBOYZKqkLNHxbvcQLgtHxeXxBJw6jAzgzUR53A
	 18ttcM2EMKN9NCyH83R/a/WJSdbfJslW6t/U/OlzbG9EGu9sI/qxEwmYZsXLNhdQkI
	 Pk7D0KE+enu0S82RLICF23hDx+iIDvhonqH4pWpsgnROpPRg6WUeaKyX/5BJHTlMKe
	 tiDnIlxIViOfIs2fVA9oNvD7SGj7Xrh52tyUk9AIvlTTxk1QSWjct7oXMd2FjYwaVk
	 fUxPvtRGAg2YA0ePyM3Fsg8QL3NXnNFbtWYDyH3R4gJYO0AwqCHbaWT1oGK3h7omRU
	 HmJk8vNdTr6DA==
From: Michael Walle <mwalle@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH net] net: phy: marvell: fix return code
Date: Mon,  6 Jul 2026 14:06:27 +0200
Message-ID: <20260706120637.1947685-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return the correct error code, not the value written to the register.

Fixes: a219912e0fec ("net: phy: marvell: implement config_inband() method")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/phy/marvell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 7a578b5aa2ed..f71cffa88406 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -753,7 +753,7 @@ static int m88e1111_config_inband(struct phy_device *phydev, unsigned int modes)
 	err = phy_modify(phydev, MII_M1111_PHY_EXT_SR,
 			 MII_M1111_HWCFG_SERIAL_AN_BYPASS, extsr);
 	if (err < 0)
-		return extsr;
+		return err;
 
 	return phy_modify_paged(phydev, MII_MARVELL_FIBER_PAGE, MII_BMCR,
 				BMCR_ANENABLE, bmcr);
-- 
2.47.3

