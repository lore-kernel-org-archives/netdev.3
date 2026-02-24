Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5439C64C;
	Tue, 24 Feb 2026 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938978; cv=none; b=MjCpxbgVZpTlGRZ/5Ud2srS4Ph98m16SY1nOQhLLHfHRLijWacKkyMlGYkQ073pLr05MX8N9It5gXUYymQYaF1fO3wx+7iVGS/BoTG4KSM8gHth++XcrOr5DSqy9TVHYppkkeDORqa21LlH1tXkrJOyt9N7oIHxKYF2BV7DHbzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938978; c=relaxed/simple;
	bh=piTICk03gyySJY/rmyPdJDdA3q8tjm7nIVlT98bRjgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHEKxzjgobFGt3zw8G4me1yq1wsi5GMGNH/v5VqafILRzc76ArgdOisRghMPpkCNPocxCJRkLxDCCZ2DqQaUNUP8P7dTEJwQEAV9JOwAy0XmBKnS3EX3I9p4YBOK41vDRYNtUlDfnCfz36YIDglZMnPhV/G2+1R+s1mNX+Goego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PTxrXiaI; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PTxrXiaI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zOgGPvfDC99ROaDQZy0YgezA0R/9BYReTv2IpGbPAgE=;
	b=PTxrXiaI7Y6vftsdUqljMfUxcKUlanls8gG4Fhk2jhbBOUVUoCnu1xudJ/bFrlRIQamTRCxYN
	mOuySXJ5YYzlb0AyVUONCS7QP4Py4i+SoAWtPys6VZUZdLiXDjEzCnLc9DcaVCxqM+/M+lNVDIR
	A3d6QWb3cNKnxGDNBMJjGQA=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fKylx51YkzLlSJ;
	Tue, 24 Feb 2026 21:11:25 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id DC7F440561;
	Tue, 24 Feb 2026 21:16:11 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:10 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>
Subject: [PATCH net-next v01 05/15] hinic3: Add msg_send_lock for message sending concurrecy
Date: Tue, 24 Feb 2026 21:15:42 +0800
Message-ID: <a1acb44d9f09e9d8c2471889ad54900dae5e9d80.1771916043.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1771916043.git.zhuyikai1@h-partners.com>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c | 5 +++++
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index 63cc70bce8b0..8554291f852d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -396,6 +396,7 @@ static int hinic3_mbox_pre_init(struct hinic3_hwdev *hwdev,
 {
 	mbox->hwdev = hwdev;
 	mutex_init(&mbox->mbox_send_lock);
+	mutex_init(&mbox->msg_send_lock);
 	spin_lock_init(&mbox->mbox_lock);
 
 	mbox->workq = create_singlethread_workqueue(HINIC3_MBOX_WQ_NAME);
@@ -723,6 +724,8 @@ static int send_mbox_msg(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
 	else
 		rsp_aeq_id = 0;
 
+	mutex_lock(&mbox->msg_send_lock);
+
 	if (dst_func == MBOX_MGMT_FUNC_ID &&
 	    !(hwdev->features[0] & MBOX_COMM_F_MBOX_SEGMENT)) {
 		err = mbox_prepare_dma_msg(mbox, ack_type, &dma_msg,
@@ -776,6 +779,8 @@ static int send_mbox_msg(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
 	}
 
 err_send:
+	mutex_unlock(&mbox->msg_send_lock);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
index e26f22d1d564..d972d2bfd528 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
@@ -114,6 +114,8 @@ struct hinic3_mbox {
 	struct hinic3_hwdev       *hwdev;
 	/* lock for send mbox message and ack message */
 	struct mutex              mbox_send_lock;
+	/* lock for send mbox message */
+	struct mutex              msg_send_lock;
 	struct hinic3_send_mbox   send_mbox;
 	struct mbox_dma_queue     sync_msg_queue;
 	struct mbox_dma_queue     async_msg_queue;
-- 
2.43.0

