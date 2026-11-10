Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292888;
	b=Oi5ZkYx5RTwNdJAiZiRk6NWKgOovfHzI6O3ypfziibHDNS2q5QZ6jTiJJBOk/tjc5/eR
	 LvGaqiyCiN+1UJYGTMsXxg8EWYbJOhN9ASAYo30lVDbqhrY7rm5qqr3sDYbrxWjsKfMed
	 sa4hnoPsFaoOeiFb7Lg7mtmRCp8luJMQSxdApVbWgUVozk3JsNsfPtoV1c1OMTPZqGVFZ
	 wDLoH0CzJsvNZGx6P3YEI0kqhZ+Xnto6Isemajg4Cm+wS6MJFMEKOcf7ZuaXQKK/2ko4t
	 W+q8oA3c4JbzX9rJETkYenZxdGWZfB4QdNp1qo5GpZg0hMGa8q63TTGqm0Q9GqpYeVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292888;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WfIAYqdF6wZYpZzaWY38Xxjrq+wOS8yWfdzFcKWXmbc=;
	b=PipeAvIpxoEqzqgtvULZGnz1SyiCbt1I0oGmYmfLyMauK7nw09P1NOkDQmHqRn4xxnjS
	 IPgyXeleIhD20Qm95VLKphSjOi9AQ4XJ/3BZMq/ixv8UWHtI+B7mKsSHuFKBo+3neu6jV
	 w+X6huCLuyiEhvHmRDI/BTN4xTr3jO3iH8shM0MXl+BEscF0Khhb6j/psWixCaqNwZlBN
	 bWHNS++U0aJojJFe6tPa6zv1QoZsYoaFOflA4MFjvschk8qmvxFH6D0CYNM7r6lOsrCQK
	 z9ucGjMzQ5+D1eSOrY8FOKz/9dQGpRa/CbNGhaYQMSElRrRq2RTeCvP7wSSqh4fTxfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LkZG1Aaw;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9492A606A643;
	Tue, 10 Nov 2026 06:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9492A606A643
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LkZG1Aaw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=LkZG1AawQASF5XJO37toqyMRyC6pBLcNVPI5P9kppwgBnI9iFh6P/aNgaDEqsV3uAtmw6qxocLngn
	 xgZTbuw3n4D8ZYLtOM7gSNikmWPuRvD8jU10nYTYrClp0ZtTck+2inl7ic7LObxlz/YZkJB901Qiwu
	 leyRyftDdEMioqA4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af2bc92851-6b667;
	Tue, 10 Nov 2026 14:41:23 +0800 (CST)
X-RM-TRANSID:2ee46af2bc92851-6b667
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af2bc8e8a1-aa5d9;
	Tue, 10 Nov 2026 14:41:22 +0800 (CST)
X-RM-TRANSID:2ee66af2bc8e8a1-aa5d9
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	jan.kiszka@siemens.com,
	diogo.ivo@siemens.com,
	haokexin@gmail.com,
	horms@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v2 net 3/4] net: ti: icssg-prueth: Fix port scan issues in prueth_probe()
Date: Tue, 10 Nov 2026 14:41:16 +0800
Message-ID: <20261110064118.1138-4-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261110064118.1138-1-laixiangwu@cmss.chinamobile.com>
References: <20261110064118.1138-1-laixiangwu@cmss.chinamobile.com>
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

The port scan loop in prueth_probe() has several issues:

- When reading the reg property of a port fails, the error is only
  logged and the uninitialized value of reg is then used to decide
  which slot the port node is stored in.

- of_node_get() is called on every port child before the reg value is
  validated. If reg is neither 0 nor 1, the reference is never
  released. If two ports use the same reg value, the second
  assignment overwrites the first pointer and its reference is lost.

- The "port0 and port1 can't have same reg" check after the loop is
  dead code: both variables are initialized to NULL, each iteration
  assigns at most one of them, for_each_child_of_node() visits each
  child exactly once, and the both-NULL case is handled by the
  preceding check.

Fix the first issue by skipping a port when its reg property cannot
be read, and the second by taking the reference only when a port is
actually accepted. Reject duplicate reg values, which is what the
existing check intended but never caught, and remove the unreachable
check.

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 26 +++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 9b971d1df..c19a51174 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2217,24 +2217,34 @@ static int prueth_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(dev, "%pOF error reading port_id %d\n",
 				eth_node, ret);
+			continue;
 		}
 
-		of_node_get(eth_node);
+		if (reg != 0 && reg != 1) {
+			dev_err(dev, "port reg should be 0 or 1\n");
+			continue;
+		}
+
+		if ((reg == 0 && eth0_node) || (reg == 1 && eth1_node)) {
+			dev_err(dev, "port reg %d already in use\n", reg);
+			ret = -ENODEV;
+			of_node_put(eth_node);
+			of_node_put(eth_ports_node);
+			goto put_cores;
+		}
 
 		if (reg == 0) {
-			eth0_node = eth_node;
+			eth0_node = of_node_get(eth_node);
 			if (!of_device_is_available(eth0_node)) {
 				of_node_put(eth0_node);
 				eth0_node = NULL;
 			}
 		} else if (reg == 1) {
-			eth1_node = eth_node;
+			eth1_node = of_node_get(eth_node);
 			if (!of_device_is_available(eth1_node)) {
 				of_node_put(eth1_node);
 				eth1_node = NULL;
 			}
-		} else {
-			dev_err(dev, "port reg should be 0 or 1\n");
 		}
 	}
 
@@ -2246,12 +2256,6 @@ static int prueth_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (eth0_node == eth1_node) {
-		dev_err(dev, "port0 and port1 can't have same reg\n");
-		of_node_put(eth0_node);
-		return -ENODEV;
-	}
-
 	prueth->eth_node[PRUETH_MAC0] = eth0_node;
 	prueth->eth_node[PRUETH_MAC1] = eth1_node;
 
-- 
2.50.1.windows.1



