Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23ED3446BC;
	Wed, 18 Feb 2026 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445194; cv=none; b=Iywmc1mMltDlI4V069KxcT9Nd/pCjaYSQw3Ltroudxkq2f5saKcgFQwysFFRLtK5Uo8CKbJUhXGgbkuwSelhheQy8Biv7jntueQ+n5pIGZLRhxb07E+QN2iqq5ZIeMj3YNDCo8hvAQbG1kMMqQG5xAJtLmCKmvvcSh1JPcrow7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445194; c=relaxed/simple;
	bh=t9dtKU4XnZbqbTDRSM7o72ls4AUj8ncaygeGYi6t65U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ToUb021AGf/8wOV4CJq66G6zd1gjTlx8A1eYbZkNZUYwH4RL5Ms3WE8ljwC4H1TnbtURXgT/hsPqXEpA7ivMvQO9pcqNmGPn2Melu0jw/UuDO6cNiLqcUSjgMyDJnnY6hzpwtoWGK/nWlNQvu8696wbh7dCOOmcuLdku6BeUERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=s2fRS5Fg; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="s2fRS5Fg"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A802FA3DBC;
	Wed, 18 Feb 2026 20:56:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771444609; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=+q3FhEgT8k1GxpsQfa9xCtOmB0xiLx3eBdQe+vhDXLk=;
	b=s2fRS5FgKr4K0DGRasXWKUtUscq9VWR/Vbm+J1abHFuAiZUnteS+Gn0zCNqfoetlUIkJMb
	UMgZhk0646HAd2vUSBky2fY2h8FQjxwcaj3pJxGtlU8TDoziZdUGEIFjngPtoF59EWugQX
	xlJx15EjV1roZ5zzNkNcdvQAdGeCdimpy+mAovxV2pRUR9RSjMdBdfSLp1MQNhfmgDpd8N
	MHz2pytvXeXB/XaaDy2HSh3E6iQbiRwpA2xnDcGNr5A9BnmE8V0MbH6XsCUCvlMG1Far/9
	4uZn/DLXMT+x+OlH/OCp7xGQHzRGCEJrJRVlS5lLq+ymnU/NbDAD0c9jGVHQJg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: microchip: lan743x: add ethtool nway_reset support
Date: Wed, 18 Feb 2026 20:56:15 +0100
Message-Id: <20260218195615.25655-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Wire phylink_ethtool_nway_reset() as the .nway_reset ethtool operation,
allowing userspace to restart PHY autonegotiation via 'ethtool -r'.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/microchip/lan743x_ethtool.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 8a3c1ecc7866..9195419ecee0 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1079,6 +1079,13 @@ static int lan743x_ethtool_set_eee(struct net_device *netdev,
 	return phylink_ethtool_set_eee(adapter->phylink, eee);
 }
 
+static int lan743x_ethtool_nway_reset(struct net_device *netdev)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	return phylink_ethtool_nway_reset(adapter->phylink);
+}
+
 static int
 lan743x_ethtool_set_link_ksettings(struct net_device *netdev,
 				   const struct ethtool_link_ksettings *cmd)
@@ -1369,6 +1376,7 @@ const struct ethtool_ops lan743x_ethtool_ops = {
 	.set_rxfh = lan743x_ethtool_set_rxfh,
 	.get_rxfh_fields = lan743x_ethtool_get_rxfh_fields,
 	.get_ts_info = lan743x_ethtool_get_ts_info,
+	.nway_reset = lan743x_ethtool_nway_reset,
 	.get_eee = lan743x_ethtool_get_eee,
 	.set_eee = lan743x_ethtool_set_eee,
 	.get_link_ksettings = lan743x_ethtool_get_link_ksettings,
-- 
2.39.5

