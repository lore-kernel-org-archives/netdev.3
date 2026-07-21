Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D505401492;
	Tue, 21 Jul 2026 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601330; cv=none; b=bivHSVTOL7o29Finkas6Hz0zJ3XYeSnkayHumqU6PsAsNG1KcrNF47mMtI61yKee6UjU8VDyjv9u43LQwEneieUW61brwcD+uN75QNELanFgRKJWM3Pd9lud1SYmPJI6nV4b++J33scvTK1yiU25sXrokNn88DFUIqguYtRp/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601330; c=relaxed/simple;
	bh=JJj5o37i385985F1b/QZFIFJxt3DXc5e1rLS5CNGjhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AGPKbMmPySB/PDPeBjxDrfBj4JuRcHj6W8914a/WzfGV2f1zCNu1r/tB7PCYFgxoUauJGdCUeK+q2W0v5LRn0DBjfyDnFmIE3PAnGcUchC2QAqJUTfVVvOK81C0fkUxNJi3wSONBaikehlS4O8/8Ss/5NGPTNB7clOk/deHOrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d2d52a9084ac11f1aa26b74ffac11d73-20260721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9df154ce-bb56-4648-a308-6211d9759bdc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:9cecef36158ac82cb24a66f026585700,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d2d52a9084ac11f1aa26b74ffac11d73-20260721
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 692568123; Tue, 21 Jul 2026 10:35:23 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: David Heidelberg <david@ixit.cz>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH net] nfc: nci: free destination parameters when closing a connection
Date: Tue, 21 Jul 2026 10:35:18 +0800
Message-Id: <20260721023518.1697625-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a connection is closed, nci_core_conn_close_rsp_packet() frees
conn_info but not conn_info->dest_params, which is a separate devm
allocation. Each connect/close cycle leaks one dest_params until the
NFC device is removed. Free dest_params along with conn_info.

Fixes: 9b8d1a4cf2aa ("nfc: nci: Add an additional parameter to identify a connection id")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 net/nfc/nci/rsp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 6b2fa6bdbd14..21c2fe64490e 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -360,6 +360,7 @@ static void nci_core_conn_close_rsp_packet(struct nci_dev *ndev,
 			list_del(&conn_info->list);
 			if (conn_info == ndev->rf_conn_info)
 				ndev->rf_conn_info = NULL;
+			devm_kfree(&ndev->nfc_dev->dev, conn_info->dest_params);
 			devm_kfree(&ndev->nfc_dev->dev, conn_info);
 		}
 	}
-- 
2.25.1

