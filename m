Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C773BD653;
	Thu, 24 Sep 2026 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246900; cv=none; b=N3gB/MBsmsVCkjYKJzf4DcoqlCuoL6w2U7/JXZ7qB6PAL7wfQ0yLMXzGuwLciaCxsg2zYEVLnI8KPCyt5sAexyoaNDhcSS4VBSSXTua4dp2jzZK0HSqK0wcCDSo8IdRY35hEL8m3XnTYfh5b7jSPmAauDcEbF5K7KyxVQEYG3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246900; c=relaxed/simple;
	bh=ic1G55jbyc7YsmbuR8Pwg2mfKH0FkybnexT5jQWf48A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HGrr+VknS6RyKb8+C4doACXnIBT1VNoyfcXhEW4GTr3xjFYHAth5aFhPu9z1sv6IGPEPiRUGMt6mVWVXOTrYgulvinWb65+xQZSE8gxteR1S0k6baRe4bCxUr16zx/7Z/vvGWuoSvA6VeSv8+4vdzur0YdXs1lS8G/M0cumXTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGWpsjmh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGWpsjmh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AABBC2BCB3;
	Thu, 24 Sep 2026 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790246900;
	bh=ic1G55jbyc7YsmbuR8Pwg2mfKH0FkybnexT5jQWf48A=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=EGWpsjmhIYoYuMzV5rfwxCEIdIu5dnt4U+Qzq85kN27MJ/9UDYHtYn/bDg83qXuyt
	 j3vd8aiRKpu7T61rzQohpOCAR6csb1nPqSKhT/WSyg2O5ZetIGzABUGIVyRhoap9Mn
	 PhLqhsvNCuAZXoJyT/LACrs+9M0g/jh+BRI6cVNTLYmiliZxV9LzsouiQ4nSSq+U5J
	 kXvUgLJxbcSQD/8NrOGgQcGOE3P4WXNYEeVIAilMUYIdR3hGuwBnfHkhtIopYSBFPk
	 8+33JvOD866c9GdZv4l1mO95xWax3IvvhUAKXyFtimd9ZJhCG49D+7mX1q544SCWnH
	 4IHjOKokVzBkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046DCC98317;
	Thu, 24 Sep 2026 10:48:20 +0000 (UTC)
From: Rouven Czerwinski via B4 Relay <devnull+rouven.czerwinski.linaro.org@kernel.org>
Date: Thu, 24 Sep 2026 12:48:18 +0200
Subject: [PATCH net-next v2] net: phy: mxl-gpy: add 2.5G for MXL86211C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-mainline-rouven-mxl2g5-v2-1-fc8367a4c3ad@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOQQ6DIBREr2L+ujTwDVq76j0aF6hfpVFoAImN8
 e5Fe4AuJzNvZjbw5DR5uGcbOIraa2uSwEsG7ajMQEx3SQNyLHiFyGalzaQNMWeXSIbN64SDZCU
 2rRQd3qqSQ4Lfjnq9nsVPMBSYoTVA/XP80ryoDUfvkR21D9Z9zg9RnMS/uSiYYIpTJ/MiF0r2j
 xRSzl6tG6De9/0LFfjFg9kAAAA=
X-Change-ID: 20260922-mainline-rouven-mxl2g5-72bc51d28970
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790246899; l=1635;
 i=rouven.czerwinski@linaro.org; s=20260126; h=from:subject:message-id;
 bh=pedhSXhCXKROiJuybTwA78NJnL4APYoFo51G1JpeoQo=;
 b=cmQqF/rb11o7qo13y20RyMgHjULPMyxDxiVftIoo7m1LhqkubyIySVl3QbD7rnu4cuDOV222w
 2ggwoUnUR4zBriij6Wy5+NnrDe4lhGd6wt2Un88nLTHUq/F42xyn8FH
X-Developer-Key: i=rouven.czerwinski@linaro.org; a=ed25519;
 pk=/5pmUK/XIAIIo8JA0axgfy1k8NRhRTQkxVwZYa1ga7U=
X-Endpoint-Received: by B4 Relay for rouven.czerwinski@linaro.org/20260126
 with auth_id=616
X-Original-From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
Reply-To: rouven.czerwinski@linaro.org

From: Rouven Czerwinski <rouven.czerwinski@linaro.org>

The MXL86211C also supports 2.5G via 2500BASEX, switch the config init
to indicate support for that mode. Datasheet checks indicate that the
2.5G speed indication is the same between GPY211 & MXL86211C.

The same should be true for MXL86252 & MXL86282, those are not modified
for a lack of testing hardware.

With this change 2.5G negotiates correctly with a Mikrotik
CRS310-8G+2S+IN.

Fixes: 9d844da693d6 ("net: phy: mxl-gpy: add support for MxL86211C")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
---
Changes in v2:
- Fix typos: Fix Typo swaps of *68*211 to *86211*
- add Fixes: trailer
both suggested by Sashiko
- Link to v1: https://patch.msgid.link/20260922-mainline-rouven-mxl2g5-v1-1-a0ed53631a5f@linaro.org
---
 drivers/net/phy/mxl-gpy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 0da2d4e9d8548..089a1a9e5bc61 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -1405,7 +1405,7 @@ static struct phy_driver gpy_drivers[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C),
 		.name		= "Maxlinear Ethernet MxL86211C",
 		.get_features	= genphy_c45_pma_read_abilities,
-		.config_init	= gpy_config_init,
+		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
 		.inband_caps	= gpy_inband_caps,
 		.config_inband	= gpy_config_inband,

---
base-commit: 2d7341a020a57b30c1826db38f81bbc257ae3bbc
change-id: 20260922-mainline-rouven-mxl2g5-72bc51d28970

Best regards,
--  
Rouven Czerwinski <rouven.czerwinski@linaro.org>


