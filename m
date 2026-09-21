Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800E47D959;
	Mon, 21 Sep 2026 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032486; cv=none; b=CwwbNFN+CQx+1IYPQn90vRF1p592oUL2PvFKZFzrs551VK7kIx7yZklFEbKvut1JIl0D58l7/YXW5p7V0dVdn1Hy2cHB2H56JoUwjFPEVqBh/zX0oTHOe4as0A8Fq967Gx+OthuIo3iwaZzz8eO6NKFjzRHyVB1RHjYtRA274jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032486; c=relaxed/simple;
	bh=0pDu9zxMPYxcA+WTdxFtaLVQXA7kWFSBaSm0n0kMQ+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c562LGn+uTJnop69IsC9E63ZNCp0rEjyZggMPCJSsPGUxF+TYxFkewB1wQ+n5HCKQwtc7J4vwsi+pmIr5ozOOKYFPy7wJe6MkDMwnU9FrATWlNRtf20todrkCq9kUtH5tRyUnsrW7Gq5wjJpV6ArfUQ4DAS9TG8dYcGZ5MHaaww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=vpEWkRka; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="vpEWkRka"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 58A99C000D8A;
	Mon, 21 Sep 2026 16:14:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 58A99C000D8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032474;
	bh=0pDu9zxMPYxcA+WTdxFtaLVQXA7kWFSBaSm0n0kMQ+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vpEWkRkaVZl9ReAJGySTZqiUHx4yvhdOguOonuM0C7CCkndPdW8SRytHI/tna9Zpv
	 aS2SnGQGc4I82/VHCVs86+x/byx2Tr1fVgL1kdzTLXKK9gkMH4ah9RL8ptoLbgZViv
	 npHhDhVOOZhsFVqK3ZOTd7IZD30kvu9D0hmAVGNc=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 35AC4AE0;
	Mon, 21 Sep 2026 16:14:34 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 12/12] net: systemport: Complete resource teardown even on DMA disable timeout
Date: Mon, 21 Sep 2026 16:13:05 -0700
Message-Id: <20260921231305.394773-13-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921231305.394773-1-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bcm_sysport_stop(), if tdma_enable_set() or rdma_enable_set() timed
out, the function returned early with an error code. However, ndo_stop()
callers in the networking core ignore error returns, leaving the
software ring structures allocated, interrupts registered, PHY
connected, and clock enabled. If the interface was subsequently brought
up again, request_irq() and PHY connection would fail or leak.

Ensure all software ring teardown, interrupt freeing, PHY
disconnection, and clock disabling steps are executed regardless of DMA
disable timeouts.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index e5bb7fa84fda..2b064da4eb7c 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2088,19 +2088,15 @@ static int bcm_sysport_stop(struct net_device *dev)
 	umac_enable_set(priv, CMD_RX_EN, 0);
 
 	ret = tdma_enable_set(priv, 0);
-	if (ret) {
+	if (ret)
 		netdev_err(dev, "timeout disabling TDMA\n");
-		return ret;
-	}
 
 	/* Wait for a maximum packet size to be drained */
 	usleep_range(2000, 3000);
 
 	ret = rdma_enable_set(priv, 0);
-	if (ret) {
+	if (ret)
 		netdev_err(dev, "timeout disabling RDMA\n");
-		return ret;
-	}
 
 	/* Disable UniMAC TX */
 	umac_enable_set(priv, CMD_TX_EN, 0);
-- 
2.34.1

