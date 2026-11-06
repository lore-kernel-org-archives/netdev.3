Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945692;
	b=k8zoiBhxZD9tJ0oeaSUtQQAkd9wQ/9sv4XJOKYmzcrnm+IWYz7G7DMdy6JFNUSxz7vf0
	 9VQUCh5kMD9RbY8JYJRSpwOoraOTTLHPPFweHioz1FdxrMQz5p5sRRMY0uptElyKt8vSt
	 oHOZ4Y/pIz8bxIaSMpAmHAPc9XkIIe3m7+5B5bLL+1JEXJNs//FhlpehtGXz7LxoAUBVf
	 QwLrehjaRoY8B2ITkDCUOuu6gAyMGU0qLOwox/++/IRl0Sf54syksL0/dIZIT8Ok0vWU5
	 Cobm4fsF3U18n2NO23ixWDxstKfFsFDsWNaQ3LP1m37db+cO++SPsnB+h36g43ILYAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945692;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=EMVJfwTiM0Jw/uP1/+IxtH0SlT1B7Mqt1m5WYVMjPNo=;
	b=bds1PVKx8BaSeLSqy3q6hsDc9IifnN4EKW6d3C5i1oGZGdm+OnYvBDCffr6uVk1lx3Jj
	 41vAgupTqIrBWSAWP/piyfeaudPRTqQvFY17Qltp409XFBPhwhM0F362dgd1z36Hy7z95
	 dONUpVPn2m3BEl18qGo4Pjt3d4GatLETE7WYQ6XJiK6m+r6vYGoso/v5CKTrN135EaaUp
	 czzdmg8NfVosX5XidZ4Whbjr+qIdcMSkSDBpQO2emeKgSFGeCaUZc/7nwtfTBqgXfaCxa
	 nPKDuDE6eis/OYttA1BV7vO8avxmWQ2cfeklXnvgQ7VXSDgsrkqutu8Lpw4wO6zRQew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=tF+1j+5d;
	arc=none smtp.remote-ip=113.46.200.218
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D533E606A33D;
	Fri,  6 Nov 2026 06:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D533E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=tF+1j+5d
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EMVJfwTiM0Jw/uP1/+IxtH0SlT1B7Mqt1m5WYVMjPNo=;
	b=tF+1j+5dAuJOyWmnkWVtUfXtxIE0Rvk4gFIhgB+PhiQahzNozBrmX7xb69HnDyeuQYZ5pOeq+
	WKkcb7P674FfiNhAimDgzB3oYcX4L1SzYPSNtHM5gdyC0y7Me7vKG79aYcNQikJoc9FNYZgKZot
	gMyNcfJIDUl2Eoq1Rq8BQEg=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jLTR00yl8zpStg;
	Fri,  6 Nov 2026 14:14:20 +0800 (CST)
Received: from dggpemr200005.china.huawei.com (unknown [7.185.36.89])
	by mail.maildlp.com (Postfix) with ESMTPS id 757DF40561;
	Fri,  6 Nov 2026 14:14:48 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr200005.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 14:14:48 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 14:14:45 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
Subject: [PATCH net-next v01 3/4] Fixes: Ensure secure concurrent access to adaptive_rx_coal.
Date: Fri, 6 Nov 2026 14:14:30 +0800
Message-ID: <8e91de49c919cb2cd105bcb33ff54e8e1c5754be.1793946318.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1793946318.git.gongfan1@huawei.com>
References: <cover.1793946318.git.gongfan1@huawei.com>
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemq100015.china.huawei.com (7.152.185.230)

As noted in the subsequent review.

When disabling adaptive RX coalescing via ethtool, does the driver
cancel any pending Dynamic Interrupt Moderation (DIM) work items?
If adaptive coalescing is disabled but an already-scheduled DIM worker
executes asynchronously in a workqueue, could it blindly apply
dynamically calculated DIM values to the hardware, silently overwriting
the user's newly configured static parameters?

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c  | 2 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index e7d6c2033b45..b4e58d4c8ba8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -20,7 +20,7 @@ static void hinic3_net_dim(struct hinic3_nic_dev *nic_dev,
 	struct dim_sample sample = {};
 
 	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
-	    !nic_dev->adaptive_rx_coal)
+	    !READ_ONCE(nic_dev->adaptive_rx_coal))
 		return;
 
 	dim_update_sample(irq_cfg->total_events, rxq->rxq_stats.packets,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 0a888fe4c975..ad0e831ed82b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -51,7 +51,7 @@ static void init_intr_coal_param(struct net_device *netdev)
 		info->rx_pending_limit_low = HINIC3_RX_PENDING_LIMIT_LOW;
 	}
 
-	nic_dev->adaptive_rx_coal = 1;
+	WRITE_ONCE(nic_dev->adaptive_rx_coal, 1);
 }
 
 static int hinic3_init_intr_coalesce(struct net_device *netdev)
-- 
2.43.0

