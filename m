Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F7338929
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025006; cv=none; b=s9CSKcINyLzpJs4f5j97OGbCqezzIWEC0t+B6v/29Vl+Y2sTl9tITvSbaI6iABjqO2//HPgza4TFuRbXvCeTGufR3tZ3XyUBb6ILsJU3EJgpxa0Fx6OHmp+NJ7xokly1ITPLD6xiZ4aea65uQaSf913OGZ3iVsQKLMUv4+A12Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025006; c=relaxed/simple;
	bh=hK5zvF0xQcdNDqLevJUPsy8UJt+QCtUX+8/Z0JPxSDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eKPcmIyhj+N9fJqDTyUspdOqWV1RBBfO0+KrRKC6OOShN+l+yL7EYV4VCmn7j+Jii3fxtumNWoVyuZZ7B8/nFhXtMZu/6uYP5nUfL9U2uNXUJe6/Is1X8uhy6mLoFTxc6Ayq5pSx3uNFisZ7zOtWmAqy/Ckc/avgnBQTscXK6gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWD+Gz30; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWD+Gz30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4919C4CEF1;
	Wed, 21 Jan 2026 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025006;
	bh=hK5zvF0xQcdNDqLevJUPsy8UJt+QCtUX+8/Z0JPxSDU=;
	h=From:Date:Subject:To:Cc:From;
	b=hWD+Gz30VKjiqZn+3qAJ0BlW4Dxy/mQR3AflyxgN+7wYh5Jg0cCv4ROwjm42OeN1v
	 2ktWnloat8Pso+Igybo/Q2Ipf5vMmevLsL9J86FiJU1t2f7MPW6cpZ0B+JjJIZJDgZ
	 CFiTsQnZxTYKW2CFfowOrzfxRMWNwPo3dIs3kzyStNe3c6iEw6QDd64om4OXdeRe8Q
	 SmoLOwrAHfjZuvsR0Up2BjRW3ImiO4L8z5dg9OwDSdge5GdZNoAdnWSaRqht40pWvd
	 HZk5TIRzOTsyM83vuNec/9QyOI91FNzxIaEg/Z7jVOR/1x/uHFXqsGq3OcaDIIBEK9
	 xED/H4IaWR7eg==
From: Simon Horman <horms@kernel.org>
Date: Wed, 21 Jan 2026 19:49:52 +0000
Subject: [PATCH] net: phy: Grammar update for comment in genphy_update_link
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-phy-gra-v1-1-8b4d178939de@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN8tcWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyND3YKMSt30okTd5EQjYwMLU6Nky+REJaDqgqLUtMwKsEnRsbW1AGj
 rFy1ZAAAA
X-Change-ID: 20260121-phy-gra-ca230852c9ca
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Enhance the grammar of the comment in genphy_update_link()
describing momentary link drop handling.

Found by inspection.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/phy/phy_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f624218bf3664f36d58332ac1c78f01334dab0ce..8a3eb1839a3d7748d94ef95593c2283eae9f8665 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2472,7 +2472,7 @@ int genphy_update_link(struct phy_device *phydev)
 	/* The link state is latched low so that momentary link
 	 * drops can be detected. Do not double-read the status
 	 * in polling mode to detect such short link drops except
-	 * the link was already down.
+	 * if the link was already down.
 	 */
 	if (!phy_polling_mode(phydev) || !phydev->link) {
 		status = phy_read(phydev, MII_BMSR);



