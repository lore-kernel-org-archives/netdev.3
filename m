Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350617;
	b=uHzoCaGPA7Mm18+5+8qzAXDzrXHaoHFASkqzEZpgcWadieVKkyblwfEsqJPxC+SW7lOe
	 vsR85tUORP92N1CCKk4LDEPA1fv6qisOedecp0vcbKi3pmG59wNPlH/lVgeD5kDqBHh8g
	 4SL50Vz1bZxzVTAwKlLL72e1XytBBU7TVrqUahvSk/NgVTcUb1z/SImM0L9j7qunChzeJ
	 KaZIDIS6InEJzxXRYa5TeOjRdKyEKYAP5EBDGGqz7VkIwZJx35TSZVgu3pCMr7tZlwQEF
	 xK9adbR1ATUVTVlQTDq/MigDUoY6QBRK1FnXslnN282ZCZA8SzKVop9d8SaoodezQMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350617;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aMditivvB8pxtCKUsZ0mFq1B70fjufwLAAbtdoOj80I=;
	b=fZ+DJzq/WLvV9paHtxtBR4tTx4pSTG0jbO+/Lzwh3OP34dzkU/ahqMbCzcahReoUbQZ4
	 xoCmHY3LV2v/TFMLdu/Sh0brWImhvm0bNQeuXACUgMnvv0/gxA4WDT+uqGmhuYbDpnreD
	 la1NRXOEV7VV/wKi2i5Cj3DkiSEHQFBt7nozxLv/U2e7EZZiUjE1VUFfTCqmx0t2OmU0N
	 y1aDRKLHG+qqgJBfuAxxf9fgaFfk1mOZLYQkoVJXHgSKqZVNiUvdMbrOlKc+yqtEqTXlQ
	 8jwfR8xTI4wtrKvw8ooeMsFIsGxRNS4MqlOACdLBElU1eiG6fJWt5RpU/9k90QFmaIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=n1R1FqHT;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8016606A31A;
	Fri, 30 Oct 2026 08:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8016606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=n1R1FqHT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=n1R1FqHT+finxy/sStSfTQPqYX4vah9mqlqucmpT4RnpDXPheUwchOVWYNaK6824x134rGTx/oJkt
	 /oASJKAaGkm3maI+UBTjAFL4apy/xe3ktQ89KYlB1LozNoo643RaOMkTjzAisNnqhakZolYOIFNdNb
	 X4G9mR+U8MlK5U/M=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36ae45bd5a65-3fa08;
	Fri, 30 Oct 2026 16:56:54 +0800 (CST)
X-RM-TRANSID:2ee36ae45bd5a65-3fa08
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56ae45bd44c6-577a8;
	Fri, 30 Oct 2026 16:56:54 +0800 (CST)
X-RM-TRANSID:2ee56ae45bd44c6-577a8
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
Subject: [PATCH] net: ti: icssg-prueth: Fix device_node refcount leak in prueth_probe()
Date: Fri, 30 Oct 2026 16:56:51 +0800
Message-ID: <20261030085651.1944-1-laixiangwu@cmss.chinamobile.com>
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

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c80..9b971d1df 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2258,13 +2258,15 @@ static int prueth_probe(struct platform_device *pdev)
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
 
 	prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");


