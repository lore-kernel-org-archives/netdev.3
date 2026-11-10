Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292885;
	b=IKHqE5CLhFwXeSAe8e1WhyO6NB3br0e01MSTAqZwLbIiBbQEH9dDP3JuRn+e79c1B2t4
	 CzNca+yk50G36XGJ5I8yZB67hc4whez6rwSPE4I5PSAbMhr3uQQsedB5dwTCU7pTtLW5Z
	 UvMTT0SNZNhu4D9wTXpBxm4y04eNEcn0Z9zYOmZMfZXwX+Telbhkj7kzeLOrRfrQIYM8Q
	 fXtlFOWIl4d8w8OH1+tRg5C8y1ryoVjo4rBNh5AG3Mh9fd7/00+zrwKTbduSu2Xm1z4bb
	 3iqCQl2l/LefGjnpVuYghzKODbkDbRJr5rRZ5THToig1LKaiyB/LaiA9jIVuP56rV5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292885;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nqrKlaQeTl4WKKKVqA7nnyA6CfFqXKex3ZpEO+A2IBE=;
	b=fEGmqMhHucoQKyzhyUrjUr0ZdxHzoBLswz6hPT2CkwjaaGyx7+gPKRf2PyvVMpS0Qsi1
	 L4VmrImMOMtYOwkfnvr9bn83iAsQYG7sCDFdCuqRv12uZjie0sH4CHqnTegfZOPagvBc4
	 soUrA/Tfx/8n4Bm0sJRwSWZfGeQFV14k/SzbNRLr58HOgaBe3ZXrO+tJwhCseEUCJCADC
	 yKszzh8i8lp67wBQ4xfRsG7cJ2xPeHOsnYyR8kjiH+LqMVfVaMtegMLWQBmyeenw1Ytan
	 r34Ca928peJBdbarcl0E1YUbqrY6dz44+ad/6d9rWi/2bcQ39VLho4B08AKEt8oJyoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="gANfaS/U";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E12160A6F70;
	Tue, 10 Nov 2026 06:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E12160A6F70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=gANfaS/U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=gANfaS/UWWdXR08x+aDCE54qPEJ4CfFC6jv2c/+eRudejEQ1i6KPOJ91D1bUIizMIXj+GSMA/jA4d
	 AI8KTa3FqGHaJHAsMb+Vi8AegNapLbLhy8bVrG4nEAWveSGIhN4Wq+w/XzePr8IAlY6LjkIiy9U2sY
	 IHDORU3LkeUfpD2M=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af2bc92205-a75f8;
	Tue, 10 Nov 2026 14:41:22 +0800 (CST)
X-RM-TRANSID:2ee16af2bc92205-a75f8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af2bc8e8a1-aa5d7;
	Tue, 10 Nov 2026 14:41:22 +0800 (CST)
X-RM-TRANSID:2ee66af2bc8e8a1-aa5d7
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
Subject: [PATCH v2 net 2/4] net: ti: icssg-prueth-sr1: Fix device_node refcount leak in prueth_probe()
Date: Tue, 10 Nov 2026 14:41:15 +0800
Message-ID: <20261110064118.1138-3-laixiangwu@cmss.chinamobile.com>
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

prueth_probe() takes references on the eth0_node/eth1_node device nodes
with of_node_get() and stores them in prueth->eth_node[]. If either of
the "ti,mii-g-rt" or "ti,mii-rt" syscon regmap lookups fails, probe()
returns -ENODEV without dropping those references, leaking the device
nodes.

Jump to the existing put_cores label so the error path releases the
eth0_node/eth1_node references like all the other failure paths in the
function do.

Fixes: e654b85a693e ("net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0 platforms")
Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
---
Changes in v2:

- Collect the two independent fixes into one series (suggested by
  Simon Horman).

- No code change since v1.

Link: https://lore.kernel.org/netdev/20261030085851.2019-1-laixiangwu@cmss.chinamobile.com/

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
-- 
2.50.1.windows.1



