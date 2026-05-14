Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EBF224AF7;
	Thu, 14 May 2026 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750144; cv=none; b=EDnCyZlQmX1FDo49kygGGpo6RoaYLT4U7Z/bOuNPP0R/kR99daoeOsQmepNGZYPnLFMb56g8uhB4M66ay9BVc57iMxrLeAjnigsYhsTZ7RCgDa4nFtd6pkmuG/noPdQmGh+hn2Yne1E1YwVPB2BS5Qg8Z3mnEgx0DEU9cOGDG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750144; c=relaxed/simple;
	bh=lYiFJp6gqDq9Q7YubMzYwrmnKcJfyatolsLB4e4EjWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JYlMzHg4lN+bPXSONWhRqvorxymPGys989Mz9YAq330QfxC8QGCiGs5El9jBgkpihLMdGf2Nhhpq21hgP9Ic1FiakvRvpuRBGB38jyr5UAs/L2c4INA9SiQRpzWgu3Md319UFF1jDDmlGCl18QWUW5/XmqrQGZ55AgZTcPBV/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 754f38fa4f7511f1aa26b74ffac11d73-20260514
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:28426545-0486-408d-8cb1-c0373e8eb157,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-40
X-CID-INFO: VERSION:1.3.12,REQID:28426545-0486-408d-8cb1-c0373e8eb157,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-30,FILE:0,BULK:0,RULE:EDM_GE969F26,ACT
	ION:release,TS:-40
X-CID-META: VersionHash:e7bac3a,CLOUDID:992a84fc99c04c1616e62cfdada4d799,BulkI
	D:2605141348416UR7UHPW,BulkQuantity:1,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 754f38fa4f7511f1aa26b74ffac11d73-20260514
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1124531172; Thu, 14 May 2026 17:15:32 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/ethtool: fix HWTSTAMP TX/FILTER BUILD_BUG_ON in tsconfig SET path
Date: Thu, 14 May 2026 17:15:37 +0800
Message-Id: <20260514091537.1544154-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BUILD_BUG_ON(__HWTSTAMP_TX_CNT >= 32) and the same for
__HWTSTAMP_FILTER_CNT reject the valid upper bound of
32 enum-derived bit positions in a u32 bitset (indices 0 .. 31).
Use > 32 so only counts strictly larger than the u32
width fail at compile time.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/ethtool/tsconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index e4f518e49d4c..bdf26352de2d 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -302,8 +302,8 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 	struct nlattr **tb = info->attrs;
 	int ret;
 
-	BUILD_BUG_ON(__HWTSTAMP_TX_CNT >= 32);
-	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT >= 32);
+	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
 	BUILD_BUG_ON(__HWTSTAMP_FLAG_CNT > 32);
 
 	if (!netif_device_present(dev))
-- 
2.25.1

