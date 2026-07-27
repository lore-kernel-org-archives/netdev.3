Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29D3DB630;
	Mon, 27 Jul 2026 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135325; cv=none; b=Y4T1zfIeqoHSWrXDrV9+wn7c+/btBp8mS6VIupkfTby9ByVjU2CC81fe3sysKY8oQftVN4EPxizXacG4dxDzTF9rSXo6BbD/akpB5BTc3WlSL7YB+X6twuS6gR1IhPgwrfBITFGKjHSCpDMSjXmJmSrNGxKBs5yHCi9PWlZ3IB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135325; c=relaxed/simple;
	bh=JLQfU8LTnsccN49cNqFtIn8LQ4Ah22f5dG0AEZYjW5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnieHgVkFQyqp9Ikh8/eILFZRUPIJtczsxU+C8BBdqMrt2ZbLC2fZfk6IZx+OvFAbMTa3bHiajQ3stjOzHo/WorTzoiHu8nAxDxpFRh7ve8vOvhJhoF6ArR34HspQVlSzql83sh/4cRF5GyBnOHu7sYkhayIlbjb6en3bdUmu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=itQoMQc+; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="itQoMQc+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aDE2je3Bpb8uxDwoDWbk3xEvEe7VSlI7a7A7yJPYa18=;
	b=itQoMQc+dnO/XMWtgmIJXWw9/mxJtxvUeePIg+K2v4FisAtknemyAOaFkCVXEYgIGt+8LnO4D
	FGHkGSMbNGD+nxg+kiAafC7btmeV/tk4cEiNqQl65Loq45ilWb1b6PPwHFhcZjckrHN/c7HY2J6
	Iii7MtCKe5eb64ods6Ku0SU=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h7pyL3cS0znTbJ;
	Mon, 27 Jul 2026 14:45:46 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 01561402AB;
	Mon, 27 Jul 2026 14:55:15 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 27 Jul 2026 14:55:13 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri
 Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chen Anwen
	<chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v12 3/8] hinic3: Refactor channel state machine for dynamic queue configuration
Date: Mon, 27 Jul 2026 14:54:54 +0800
Message-ID: <72153d9a0d0ec42e472c9d3df297b7cf72b1a700.1785120952.git.root@localhost.localdomain>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1785120952.git.root@localhost.localdomain>
References: <cover.1785120952.git.root@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

  Renames hinic3_uninit_qps() to hinic3_get_cur_qps().

  Splits hinic3_open_channel() into hinic3_prepare_channel() and
hinic3_open_channel().

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../huawei/hinic3/hinic3_netdev_ops.c         | 27 ++++++++++++++++---
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |  4 +--
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |  4 +--
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index da73811641a9..def671abf064 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -288,7 +288,8 @@ static void hinic3_free_channel_resources(struct net_device *netdev,
 	hinic3_free_qps(nic_dev, qp_params);
 }
 
-static int hinic3_open_channel(struct net_device *netdev)
+static int hinic3_prepare_channel(struct net_device *netdev,
+				  struct hinic3_dyna_txrxq_params *qp_params)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	int err;
@@ -299,12 +300,25 @@ static int hinic3_open_channel(struct net_device *netdev)
 		return err;
 	}
 
-	err = hinic3_configure_txrxqs(netdev, &nic_dev->q_params);
+	err = hinic3_configure_txrxqs(netdev, qp_params);
 	if (err) {
 		netdev_err(netdev, "Failed to configure txrxqs\n");
 		goto err_free_qp_ctxts;
 	}
 
+	return 0;
+
+err_free_qp_ctxts:
+	hinic3_free_qp_ctxts(nic_dev);
+
+	return err;
+}
+
+static int hinic3_open_channel(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
 	err = hinic3_qps_irq_init(netdev);
 	if (err) {
 		netdev_err(netdev, "Failed to init txrxq irq\n");
@@ -321,6 +335,7 @@ static int hinic3_open_channel(struct net_device *netdev)
 
 err_uninit_qps_irq:
 	hinic3_qps_irq_uninit(netdev);
+
 err_free_qp_ctxts:
 	hinic3_free_qp_ctxts(nic_dev);
 
@@ -458,6 +473,10 @@ static int hinic3_open(struct net_device *netdev)
 
 	hinic3_init_qps(nic_dev, &qp_params);
 
+	err = hinic3_prepare_channel(netdev, &nic_dev->q_params);
+	if (err)
+		goto err_uninit_qps;
+
 	err = hinic3_open_channel(netdev);
 	if (err)
 		goto err_uninit_qps;
@@ -473,7 +492,7 @@ static int hinic3_open(struct net_device *netdev)
 err_close_channel:
 	hinic3_close_channel(netdev);
 err_uninit_qps:
-	hinic3_uninit_qps(nic_dev, &qp_params);
+	hinic3_get_cur_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
 err_destroy_num_qps:
 	hinic3_destroy_num_qps(netdev);
@@ -495,7 +514,7 @@ static int hinic3_close(struct net_device *netdev)
 
 	hinic3_vport_down(netdev);
 	hinic3_close_channel(netdev);
-	hinic3_uninit_qps(nic_dev, &qp_params);
+	hinic3_get_cur_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
 
 	return 0;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
index 87e736adba02..0e7a0ccfba98 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
@@ -484,8 +484,8 @@ void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
 	}
 }
 
-void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
-		       struct hinic3_dyna_qp_params *qp_params)
+void hinic3_get_cur_qps(struct hinic3_nic_dev *nic_dev,
+			struct hinic3_dyna_qp_params *qp_params)
 {
 	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
index 12eefabcf1db..cd33f197216f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
@@ -136,8 +136,8 @@ void hinic3_free_qps(struct hinic3_nic_dev *nic_dev,
 		     struct hinic3_dyna_qp_params *qp_params);
 void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
 		     struct hinic3_dyna_qp_params *qp_params);
-void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
-		       struct hinic3_dyna_qp_params *qp_params);
+void hinic3_get_cur_qps(struct hinic3_nic_dev *nic_dev,
+			struct hinic3_dyna_qp_params *qp_params);
 
 int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev);
 void hinic3_free_qp_ctxts(struct hinic3_nic_dev *nic_dev);
-- 
2.54.0

