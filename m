Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304812;
	b=ax04SXWQgucKGdbghHZvJE3os8fqKK5ZAgFcIwixAx06cLN9O6SzGzT91p+ofZ3lw5SW
	 jLvpE3/TLfA9B2MI2ZSDBS5y1uiLlMexpPwGbPEJbjmvqJQ2g9RmWWvnOdaF43IJBqQoQ
	 Ls/dN2EXARyj7z8gZsbaprZfe5pQe498dSL2hA4aj8FKTT4GsiZBKQ3O3ZJzZRpRS4qfq
	 RpkWS4tQTVs0eVJQPjCt1mqaKEyX8p3OssU2Q6bCuX1paUTomqGczeK0jHBP/LCi89L2f
	 /4ysggekDjMQioM4a23hpeI925spkH5Qk0BgwN6zFBWL2Fx+3nqQH8uSnFeL0bFJLPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304812;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
	bh=7gls5+Z1Gfxwoo2Wkv00K2xzjCnty8QfpdZxCxJH3TY=;
	b=GKwpY0TAp605XIY6jdRZUHbGwVoOKbUuoqUAAutCxaPHSscRKEP1CZay3vKiphxxgYfG
	 aIgOxHQGoK6eW/cxhxDgVQpuW3129cJaLF8QrrRCPBhj3Znd3R8vwJCCNMD2zjbuzU2Tb
	 fLEwvh/yZHuL5JEZlSLxcJ4ExRJkFUfMhDi4HTmeVsucDvqtdvnwt2GoOAqSn8Pr9kK+r
	 IsHET1vMaXh8KBo8s4p4jsGgzUEx7pb/w6qzDquWkufieQk/E0559tlWB5IDhvbVY0jiV
	 jx/1VemSEI9O4ct3232MKeoQgX7xHPl8sLisRsTPq/0XMf7A00f5iqCJnd+W346/n3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jmu.edu.cn;
	spf=pass smtp.mailfrom=jmu.edu.cn;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613EF606A32E;
	Tue, 10 Nov 2026 10:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 613EF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from Vostro-3710.. (unknown [14.220.232.40])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5425f999b;
	Tue, 10 Nov 2026 18:00:07 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Frank <Frank.Sae@motor-comm.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 2/2] net: phy: motorcomm: add missing trigger link for YT8521
Date: Tue, 10 Nov 2026 18:00:01 +0800
Message-Id: <20261110100001.1873309-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110100001.1873309-1-amadeus@jmu.edu.cn>
References: <20261110100001.1873309-1-amadeus@jmu.edu.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c4e692b503a2kunm6bb3c9f9144c21
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSxhMVhhOTkpNTk1PSBoZGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKT1VJSUtVSUhJVU9LWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++

TRIGGER_NETDEV_LINK is available in led_hw_control_set,
but missing in led_hw_control_get. Add it.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/net/phy/motorcomm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index bcd3afef0d49..5b1d17bd231a 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1901,6 +1901,11 @@ static int yt8521_led_hw_control_get(struct phy_device *phydev, u8 index,
 	if (val & YT8521_LED_10_ON_EN)
 		__set_bit(TRIGGER_NETDEV_LINK_10, rules);
 
+	if ((val & YT8521_LED_10_ON_EN) &&
+	    (val & YT8521_LED_100_ON_EN) &&
+	    (val & YT8521_LED_1000_ON_EN))
+		__set_bit(TRIGGER_NETDEV_LINK, rules);
+
 	return 0;
 }
 
-- 
2.34.1

