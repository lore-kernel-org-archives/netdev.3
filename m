Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292885;
	b=N0WOpabirjb7sznATpfDZaz2JMTKTfGvzkJAsOmZ6ThF5RQseJJJljI+rh2H4wDyznPz
	 ONk6NizUoUUUWuMB9TjFdpjTs0Q5nouB2tMXq7vgxaERAuA198JNpUOkiWlU10aItl4zd
	 slza9vStzI3RHqptql/J1KTikiueKg+Vf1fOd4QZBUwMwaxp5DGMi5ifzATo4GKpYnhCg
	 k7xWu6EOzLceGQjXcJLSL32IITVslpOHzPA2efzEsMbYIqMEvQugcDmw2OT17AlWDp0dY
	 WUakwki/k6H/cgB93EsA7jVU0bKbWeoRMA0970ATgriA9PWvh/uMHt5TqyErkk/u4ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292885;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AcfouenU4KIPThaRw9r968DyKfyGZV3RnZDZtnqf6zo=;
	b=dnJw6tFNBLY/y3a11edp/eDUmI2q2W40Bhnlfv4ustR9C5ulQ7QGpYWvlesgIqY439xS
	 5YYxGnyqRHKPE0kZ1XaXgCBeze4Bke1XgLlgxOtdE/NN5YKRE1jm668/LJ/u46Z/8CTW3
	 y+mJJkaurG9QMiBnmdBe8+mVR/+fox1d+2fSJAGcTwBpf4ybZq8K3d1DNhiECqvorl9Wc
	 fdb7/Vppn2A56N/YGG8i54QKrsZo4VKrPPO3nGi8dVfum6YbWfiLoJVuWLkNEZwwbyP3m
	 BSnfPd4+FIY2nH/Y87BlIJQhBBAAd1OYdfS0bZZ6xMMC9Wyt6z84QxOxC8dsFYS+BJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=IzczfaiS;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2D560A6F47;
	Tue, 10 Nov 2026 06:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC2D560A6F47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=IzczfaiS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=IzczfaiSQgI6fDN+NLxxBudjE63hv/B1HxrUmpyqJQUosMdCB8+Qmcf9+vMejuj39WFeIrjMf/kNT
	 ljrmm6jewS04cjn6MZVBkBdHrbBziMgQK8pds39uCJAI83rQPZzDAqy1ZaB63cn9nwT7oNoYns6rOB
	 sey85DuNumvTLY8E=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af2bc8e42f-97bdb;
	Tue, 10 Nov 2026 14:41:21 +0800 (CST)
X-RM-TRANSID:2ee36af2bc8e42f-97bdb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af2bc8e8a1-aa5d2;
	Tue, 10 Nov 2026 14:41:21 +0800 (CST)
X-RM-TRANSID:2ee66af2bc8e8a1-aa5d2
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
Subject: [PATCH v2 net 1/4] net: ti: icssg-prueth: Fix device_node refcount leak in prueth_probe()
Date: Tue, 10 Nov 2026 14:41:14 +0800
Message-ID: <20261110064118.1138-2-laixiangwu@cmss.chinamobile.com>
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

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
---
Changes in v2:

- Collect the two independent fixes into one series (suggested by
  Simon Horman).

- No code change since v1.

Link: https://lore.kernel.org/netdev/20261030085651.1944-1-laixiangwu@cmss.chinamobile.com/

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
-- 
2.50.1.windows.1



