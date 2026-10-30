Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350737;
	b=c0EE47t1S7Yxiqrv07tdkgmsD9L+e1jH5UDXzvlrxv9TttyWILHv+qV+hxneyscAxIJ9
	 iaHHkfuipQZKSjG9bKwRRGVPMIyXGRkJg8WqTwMoZp2RrZfPwa7bZhiKrYUCk7Bg5dJHm
	 tKMtxya3uJmQFg72puIT+/vqftb0zTeiLwRkMTAK14gwUp1NI5WB+D6u/JPyKoCE4PMvH
	 4DaS+qiC6vCTFdNaxd5YqH3ZtAwLB3mX8O3kcNyqUzI7q4tLiGUhizAyzRFXErs0gDCYs
	 r+5hbhp0gp2j1dgepzivolHuC85e5G8WiwJNHMMhkJ5y56m9eJYWw+2LqhFna7WFVjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350737;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FGYjc1WDwG+DBcG/E4vUnJWguzsaM5whGyM2s0RYAtc=;
	b=MyUZCS77YebahVAtYNbO2Km4yaCQxWEYnB6bAd4C+QSzo/sLlUdc0epDpodIjsF3B6bV
	 Rwj0+bC+93GP1OgjpvPLWEjKKbKRf4/NbMb1p6WIMb6zuOafNC5ZY8dos+wHLInI9LcYU
	 Prd6vMYJ6qAVj5M0OH8/4YEnx7M9abXJ29bRRpxR2FVM3Y1umt6BRswjNkctWD0w/IH1i
	 1315CO+csP7ufb9f1CyMpmX5SH2rVwO7WDhKPZL6MBvEsSs2bwvAD+QDblwDhxE4MT76+
	 q/u61dhceOjlH23U5N0C36VR4PGYOgZfWs+sYPl/G8s2ezPFoR6qg+asmoWKwPB7D5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vESj5NoO;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFF9606A31C;
	Fri, 30 Oct 2026 08:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FFF9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vESj5NoO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vESj5NoO9/PGNU5IPaSAr/gcfFf3Zo+H1wZENYuWd53kNzWAS2SWOrPoG3XSNdK1bdgWKAeTrUqBz
	 adewOlM3Zbh+T8ozXp63XcPt/8lDnakq1sayQFm8ImhpM7bWRSbxsBs1dNvW4BrWKJUcDGZyzqe39z
	 ZfGISGs61E2087Ho=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ae45c4e583-714b1;
	Fri, 30 Oct 2026 16:58:54 +0800 (CST)
X-RM-TRANSID:2ee56ae45c4e583-714b1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36ae45c4ca2e-54c00;
	Fri, 30 Oct 2026 16:58:54 +0800 (CST)
X-RM-TRANSID:2ee36ae45c4ca2e-54c00
From: laixiangwu <laixiangwu@cmss.chinamobile.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH] net: ti: icssg-prueth-sr1: Fix device_node refcount leak in prueth_probe()
Date: Fri, 30 Oct 2026 16:58:51 +0800
Message-ID: <20261030085851.2019-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

prueth_probe() takes references on the eth0_node/eth1_node device nodes
with of_node_get() and stores them in prueth->eth_node[]. If either of
the "ti,mii-g-rt" or "ti,mii-rt" syscon regmap lookups fails, probe()
returns -ENODEV without dropping those references, leaking the device
nodes.

Jump to the existing put_cores label so the error path releases the
eth0_node/eth1_node references like all the other failure paths in the
function do.

Fixes: e654b85a693e ("net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0 platforms")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index b8115ca47..ef1dc32ff 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -963,13 +963,15 @@ static int prueth_probe(struct platform_device *pdev)
 	prueth->miig_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-g-rt");
 	if (IS_ERR(prueth->miig_rt)) {
 		dev_err(dev, "couldn't get ti,mii-g-rt syscon regmap\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto put_cores;
 	}
 
 	prueth->mii_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-rt");
 	if (IS_ERR(prueth->mii_rt)) {
 		dev_err(dev, "couldn't get ti,mii-rt syscon regmap\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto put_cores;
 	}
 
 	if (eth0_node) {


