Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D90B34BA42;
	Mon, 23 Feb 2026 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838115; cv=none; b=hMwSpofN3bi4JV/IpcwXR/YHrIQ0OgMmXDWQQJyJPY0s+aAUarimaoqEFuFU9cBILh7NXH2TPVNLw8nl1LQTh1j+KwGgbs5GnrsVjlGnVIlX/SipDMvC3GvdafDY7cP0b3ajG+2tI9r2vvbleG5W6T3C5jogO1Y6U3+x356SQRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838115; c=relaxed/simple;
	bh=h2BiBz+DfieSHe3tI/Njgc7TA1kWLssBIRP/12PL2iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CDvBr2PVCKmMSlaiUBRYVnXKoOag0a+pT4gkX55geCm0eLfW2q3BhgQeVK6UTPfUfc6DbCWnRzFzawYt5Y4cI9U6hCH2MFOboB31SF77UTAG9RdKspVn8weCzShfkRbtIJaAz6xPUSBYBrMT+vhYlb/LFynIOrcovSzwhgKP+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=v+uIPekc; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="v+uIPekc"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD129A3DC0;
	Mon, 23 Feb 2026 10:15:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771838112; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=pR6GVLXGqByomxqwQ5CVsKqzX3AIx0j3FQbyTqkfcRc=;
	b=v+uIPekcO4IDDmMyIVj4nP/fXtqsrQI+v9x2MuFLqco7Tmb3otAxVkBSTbA3bzCg6uG0Mk
	GKKPWj9byTFECYtNQkSY66eURMfkeL0xMp4QXRdx5JrhdRKwmlMN9UbKBFfYtxC03mza3/
	WqsLZiZ0QE3JOBbIVOuMpMvWADzkoou/zTGQxWm6TMuk9lJYbhCOCZozPB12xlI1c0Tr04
	191dR6Iw5djiQTUVeVQ+qubhydkgiYWqs+ng/Rnyg74aosPhaNQzAnDFMW+OnuZwhh/NTe
	gvmP2gN8yXw9DQURylplBZ7QLpZXe7Xqjmg2PdYweBzDq+KcbyfBwZkhUvE29g==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: cadence: macb: add ethtool nway_reset support
Date: Mon, 23 Feb 2026 10:14:54 +0100
Message-Id: <20260223091454.44153-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Wire phy_ethtool_nway_reset() as the .nway_reset ethtool operation,
allowing userspace to restart PHY autonegotiation via 'ethtool -r'.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..47fd85cd9613 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3945,6 +3945,7 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.get_rxnfc			= gem_get_rxnfc,
 	.set_rxnfc			= gem_set_rxnfc,
 	.get_rx_ring_count		= gem_get_rx_ring_count,
+	.nway_reset		= phy_ethtool_nway_reset,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
2.39.5

