Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848508;
	b=Db8nwLwUGUhLDqdcQggaXkjisNmuLBCPv/XAxnhhXiPRpwuI4E7x3FNPOvl1mWGMWey9
	 R6Ns3b6hh8cmwWbXAzJcRPwhjkdLCZYJg3O4GWeW+6J0S8CPzIRd4Xv5AxE3KpRpJ8b3S
	 JwwimA9Um7Yz8Rq7IFkOj9HK7poj4OhkGNlYpm6mmTN1LmnnLN1b9/xXYJUu0fO+RkgHh
	 EsE2TM7Oo9iYpia6EfIZOqqE4sPKXjh8qiQXj7KNZw/6jh3tTjZ5XT1VrOHfGyH0gSMKX
	 RyRFNFYpo6gf4YDlXxZCHMQBnd6vavk8rCEIun0hW6fqX7VZtgPuUmEz6kLJqYWT2rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848508;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V5RlhqgKhlTlth2eFxHvAB9iHeMZyhFFICDXcLOzhqQ=;
	b=PiEdqHTltTOWllCMuuSa2hvUT6r9j3JmrJnypNot3r5tm7MGlGc3J/79UysZyVGgPpzh
	 aa47rgS9UnAmM/xiI+hWGI+PILIptwwFQ2h6+/nlUKwgOEqrqwIRUocPy8L7gEzzb1r1t
	 zk/ZHY5p/mqGPm9GUhz6HhJL5bYrjaAUMzvQAr625l/0aap0rkhqKqjXozqgqZ1CW9esl
	 kiJdmu31pwHGl9gj13UhJqxRqbf4bbA9edHQw9VJEPLBjKKMqYPa4l3C9ihy+lEs2AJ6n
	 2BW1CIw+iksyXGNGI+AmFhM2gaD40sKPWRp9RqLiptm3sIeOeDiw6V2NU/0h2muOYcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.76
Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA8606A334;
	Thu,  5 Nov 2026 03:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8BA8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2046428|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0277549-0.000560708-0.971684;FP=12422888191386374020|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jx7-i1g_1793848492;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jx7-i1g_1793848492 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 11:14:52 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: [PATCH net-next v17 3/5] net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers
Date: Thu,  5 Nov 2026 11:14:40 +0800
Message-Id: <20261105031442.4164960-4-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261105031442.4164960-1-kyle.switch@motor-comm.com>
References: <20261105031442.4164960-1-kyle.switch@motor-comm.com>
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

Some masks assigned to u16 and u32 fields are defined with
GENMASK(),which is an unsigned long constant and wider than
the field type on 64-bit builds. Convert the YT921X_MBUS_CTRL_*
masks used by mdio_bus.c to fixed-width helpers.

This is a type cleanup only, with no functional change. Other
GENMASK() uses in the driver are intentionally left untouched.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c     | 2 +-
 drivers/net/dsa/motorcomm/mdio_bus.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 2dd4240ee246..059775fd184d 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2285,7 +2285,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	ctrl = GENMASK(10, 0);
+	ctrl = GENMASK_U32(10, 0);
 	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
 	if (res)
 		return res;
diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
index 83f0212551ff..3aa1111efaa4 100644
--- a/drivers/net/dsa/motorcomm/mdio_bus.c
+++ b/drivers/net/dsa/motorcomm/mdio_bus.c
@@ -159,7 +159,7 @@ int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 	mbus->write = yt921x_mbus_int_write;
 	mbus->parent = dev;
 	max_ports = priv->series->max_ports;
-	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);
+	mbus->phy_mask = ~GENMASK_U32(max_ports - 1, 0);
 
 	res = devm_of_mdiobus_register(dev, mbus, mnp);
 	if (res)
-- 
2.25.1

