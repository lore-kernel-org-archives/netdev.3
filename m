Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292886;
	b=WG04QO4oUef7IkPyBH58gB4T/WJXp7u26hduXwTk7Z+RbA5q1jTX3w7BmmDfu218FJaj
	 EwDAto6f4zxmTmB3yW8QSyP4+WT4Hy2CH5WfiwjS2YSQRcpudCFwr8JDHnpsmWzWlD+Rj
	 OfaNl0U1asi1IALDISi/yrL1CDW10qhb1xSwtqENu/BPskukBsOOzwHPCYJRK47HVqzCk
	 xTa1RX2Amehn6WRQCKczMB6u1Ky0ibfmvNJQO/j3aLBauCgFCYYCDKZkPj05k4CYedt5w
	 UcLS3xlYa3aiIS60JRra6xYqx3WSy52fTcba/PmgkmmkpSX/HO9IlgzILHCzsVStBmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292886;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UQrPmqa5vGFJYVLC6y8HymZQPxgzYznuIdXlfYLtwdY=;
	b=Pw1AK7KMh/TP15q0xh0DfTCAjM58yc0PzcSEcrKvpS6r1AYt4yi5APkIsaMnjbtXLePq
	 l51HH1ECD0ZIaOqYTzDLnYqgPl6BkUPVY997Uc9N71iJjUZ6RQk6H4+e5JCVS4aXrXRO4
	 Ew+XuzGR6yusQs587oZiOo8jhwzT+fVQxGdF6vhzgh6OSXE9+nAdtzuwzavYnOt0R0X6L
	 frIojxNZCNmAfUqLO90XzK2c/+EAIUCu/uLtqgKE1D+0Bq50EVA4djsLyMFmjmB6uUY/n
	 XgWgolAZIYDotYVtYuE23ry1POD8wlVmUHEKeaws/fIfZAe0RuvMm3oJxdT4uyI8sQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=gVGqBLC1;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D46B6070344;
	Tue, 10 Nov 2026 06:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D46B6070344
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=gVGqBLC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=gVGqBLC1A/okOTXnaQtxFXNmrSr3ZEmYyIQxfVjrSKVHs8by5p6+WpYKHzEAnWqILfg7z1DbC4oY5
	 paDIEF9NCLuNc5P2DTH9si64bcCWVhpzwClqIeLwprPxXcgp8Xznh0mKySpFIDKbgGq8o4BSRJ1gWE
	 y6YVPd5FG56iMSWM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af2bc93207-a75fa;
	Tue, 10 Nov 2026 14:41:23 +0800 (CST)
X-RM-TRANSID:2ee16af2bc93207-a75fa
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af2bc8e8a1-aa5dc;
	Tue, 10 Nov 2026 14:41:23 +0800 (CST)
X-RM-TRANSID:2ee66af2bc8e8a1-aa5dc
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
Subject: [PATCH v2 net 4/4] net: ti: icssg-prueth-sr1: Fix port scan issues in prueth_probe()
Date: Tue, 10 Nov 2026 14:41:17 +0800
Message-ID: <20261110064118.1138-5-laixiangwu@cmss.chinamobile.com>
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

Fixes: e654b85a693e ("net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0 platforms")
Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
---
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index ef1dc32ff..1a9dd70b2 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -922,24 +922,34 @@ static int prueth_probe(struct platform_device *pdev)
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
 
@@ -951,12 +961,6 @@ static int prueth_probe(struct platform_device *pdev)
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



