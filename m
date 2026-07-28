Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086614A8B;
	Tue, 28 Jul 2026 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208894; cv=none; b=ZdT04FWhfxnWOjvUxnbuJtlxd9AVHkgh2fzahLtJIwE1Q6U8iA1qcwsT9/idVT/ikd2VqPqP43Dx5YeqXZISWwlsusGWlzDhDDJ1Qzbm8BybVLIvtIEzMNm1NV87aJU3I+NymvFRtQdBns2x3lJKqhRhtjo/9KJxlFo9kMt7SzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208894; c=relaxed/simple;
	bh=ZbNnOT9HNCHg2NPf57x97KZ2Y+nclTsktHy1zFqMWJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rR7Lth8cZQNEHUyST1gACDIF+cWm5RsUEmkiF1ZkQt3P/iJ2w6TIgIm/MdRJ5gPA7xxm82ovtqAbp4jhcqiO2XKbNM+A0v8JbmZwmBZ+rGXTmq6Apc9qf2Z6SQNIPx0Hi5PqTjbpKxBrm6Qubbt0ZtXdfxPpcH5SrYRiY6T6EKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6bbc98e88a3311f1aa26b74ffac11d73-20260728
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:54e49d0e-5d50-40ab-a163-f91150c058be,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:54e49d0e-5d50-40ab-a163-f91150c058be,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:a18a0f803ec8d44dc03282badea4e20a,BulkI
	D:260728112128CUUJJ6ZH,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|136|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6bbc98e88a3311f1aa26b74ffac11d73-20260728
X-User: pengcan@kylinos.cn
Received: from lenovo [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 968486915; Tue, 28 Jul 2026 11:21:28 +0800
From: Can Peng <pengcan@kylinos.cn>
To: manishc@marvell.com,
	rahulv@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH 2/2] qlcnic: move notifier error cleanup under CONFIG_INET
Date: Tue, 28 Jul 2026 11:20:46 +0800
Message-ID: <20260728032046.121631-3-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728032046.121631-1-pengcan@kylinos.cn>
References: <20260728032046.121631-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qlcnic_init_module() registers the netdevice and inetaddr notifiers only
when CONFIG_INET is enabled, but the pci_register_driver() error handling
block is outside that guard.

Move the error check under CONFIG_INET together with the cleanup it
protects. This avoids an empty if statement when CONFIG_INET is disabled
and keeps the cleanup code structured like the guarded registration path.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index ff4f7cd20c79..46d07faa24fd 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -4221,12 +4221,12 @@ static int __init qlcnic_init_module(void)
 #endif
 
 	ret = pci_register_driver(&qlcnic_driver);
-	if (ret) {
 #ifdef CONFIG_INET
+	if (ret) {
 		unregister_inetaddr_notifier(&qlcnic_inetaddr_cb);
 		unregister_netdevice_notifier(&qlcnic_netdev_cb);
-#endif
 	}
+#endif
 
 	return ret;
 }
-- 
2.53.0

