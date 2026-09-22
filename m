Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FCD43E066;
	Tue, 22 Sep 2026 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076312; cv=none; b=EQBHKJVpv+zmbkEeb9mj2w1ULRtCInaC5iZbqo5pTrh/uVNQ5oKJ0p9cMqcfCwRQWnVaKK90F3r9a2gqm7UYPK9cLxR78YT9JSYyqs2cpc3Z93Erzdrg7nTCbqd8r6jjDlexmWJh81zKRw4V/nYrtLvnDOD2x7PjpYbMNUL4Hhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076312; c=relaxed/simple;
	bh=yjAOdJxpE1xtRzakmMUG+xk8gE312jRtw4fYjg8deBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aB5ZpgjDhv1IvhCkqCDUPzYMpNVG1zkUzu4M+e2Hvh/NPg03M4wtl1/vbl8yL2TnJpYnvL7yjazarzV7ByTAUM+o8h3YAkz5kVi8nJOfRA6oL/pd8weMn/aAD0YFd+ZWphPkzdeJH2cj6q9kG2L/xT8UXPndtyV+zRhWGkfcgyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOjMcEw7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOjMcEw7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14512C2BCF7;
	Tue, 22 Sep 2026 11:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790076310;
	bh=yjAOdJxpE1xtRzakmMUG+xk8gE312jRtw4fYjg8deBI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OOjMcEw7OkCEq5Z9tj+0dx9dUycG5kPAQF0bGcQ99MZMq+HQdLc1IJDO+y7uSjRx9
	 4rv3xnMJmwU7tCYlmgIaFAzQIIbeDxSTd75ygsK9YfqC9KoXEVtP6gbjT4hCiH1Hmd
	 /7vjV6ynhrQuvhbocKKw9Lw/lXxxPc20vCIwGd2hGmGZRBcjFuTmQXLz0Y8qV3VKXw
	 aRZsi3VGnHA81QfBdH7KaEzbaVeYRmOi+9y/kWbmyFwCXN9356nlGtSuVbtPDLcIAZ
	 xhk/mb7ssDXW7dMvoZFYM5MtsvRSYKqmvS8LSacXN9oXhSraJqjUzvnDIA9edQVvnI
	 clfa4cz4h7jsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DFCC982FF;
	Tue, 22 Sep 2026 11:25:09 +0000 (UTC)
From: Rouven Czerwinski via B4 Relay <devnull+rouven.czerwinski.linaro.org@kernel.org>
Date: Tue, 22 Sep 2026 13:25:09 +0200
Subject: [PATCH] net: phy: mxl-gpy: add 2.5G for MXL68211C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-mainline-rouven-mxl2g5-v1-1-a0ed53631a5f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5EQBBA4atIrVXSKvE3V5lY0AollEk3IhF31
 8byW7x3gmcn7OETneB4Fy+LBiRxBHaotWeUNhjIUGZKIpxr0UmU0S3bzorzMVGfYk6NTZOWijI
 3EOKf406O//hbvfZbM7Jdnxtc1w2+JTMfegAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790076309; l=1299;
 i=rouven.czerwinski@linaro.org; s=20260126; h=from:subject:message-id;
 bh=FhxIeimRH2FMtZe6AVDcaAIBuNHx/BLHGEk99OxHqR8=;
 b=3yHtTW7SSXcyJX6qd70w7Pzh8M+YvhdIFCee0ZdsEGtHIKDwlye1fUmIn5TryCg/6lQDfIRbe
 hbC5QSYtAZUCMyr/CFlcycDZBM4bBkWp9LMptWPPwrBbT27eOvsmXsy
X-Developer-Key: i=rouven.czerwinski@linaro.org; a=ed25519;
 pk=/5pmUK/XIAIIo8JA0axgfy1k8NRhRTQkxVwZYa1ga7U=
X-Endpoint-Received: by B4 Relay for rouven.czerwinski@linaro.org/20260126
 with auth_id=616
X-Original-From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
Reply-To: rouven.czerwinski@linaro.org

From: Rouven Czerwinski <rouven.czerwinski@linaro.org>

The MXL86211C also supports 2.5G via 2500BASEX, switch the config init
to indicate support for that mode. Datasheet checks indicate that the
2.5G speed indication is the same between GPY211 & MXL68211C.

The same should be true for MXL86252 & MXL86282, those are not modified
for a lack of testing hardware.

With this change 2.5G negotiates correctly with a Mikrotik
CRS310-G+2S+IN.

Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
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


