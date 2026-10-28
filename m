Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192247;
	b=OgyGkhAe75Xo+igngFhsZUuHAmDbbWmlL2h0rE+Mu2zhPIjUI2KeDqupaUjfne1cT4FU
	 qJFl8gFoPDyd56c4BqYGiX6YhfmRAsY/U9dbKDA8wvIkxSc2ZGXdArhoEojmrCwrLhzxE
	 ZmzcZN+KNzk06WU+YkIobfFhFr4dwC53UiPxZY8p7kOYRUMpxWfz5jk1wNTjkiWYngA78
	 u88516KN+tMmvyo9lHbR18wFoDfxKtEhvkT3WTv2LcJAgbc1mHXRVHNH4AdQbEbJRX+nV
	 MS4gBrDo3OhTRREhl2+sHZbd1AGAs7rFYX2vc5vU11LojjlalbsqYxpO4/p3oYmFQNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192247;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=dhmDoHpcow4oeCOO/XWFtP3Gjs2nFgISQ/7ifIeA4nQ=;
	b=dTB8xcPOKJif+33B+HTtKtrMabpxm2fWJO6aoFe/Yc+XKehhUcPGzxK0jWck6i63nSMY
	 4UoB4hY45/C5aIVWs7wjv+DEaYOcKQUHbzJYhLwfsJCoMUEhfNY6O9RRatrafZbjwXkPa
	 EzXg+alxRbgra56ivP297w4FAEICiS5+t8TkVH33dwOvzm92AJyfwr3BJRm5TxeoxHsam
	 H2ly3pHyFY6WTF+Ecrd43ZvYpCH/mXpO4YXOyg45YkoBqKnLQIDe5Z2xY+Mv7QhiN4eWH
	 LbnnSlQNSRssizhzhvKgSa9s6ThYvip965TjG00uAhIrKKRfeULIouV7+AqXbr33MrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99766606A321;
	Wed, 28 Oct 2026 12:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99766606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1b95b216d2cf11f19a56ed5b684f684d-20261028
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_UNTRUSTED, SN_LOWREP
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:77d455e2-fe91-49b7-894d-0a60d85a2dc3,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.19,REQID:77d455e2-fe91-49b7-894d-0a60d85a2dc3,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:7db8b62,CLOUDID:c88026eb543dcb49def62787c24d0014,BulkI
	D:2610282057219KWK44G1,BulkQuantity:0,SF:17|19|66|78|81|82|102|127|850|865
	|898,TC:nil,Content:0|15|50|99,EDM:5,IP:-2|1,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_IBB,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1b95b216d2cf11f19a56ed5b684f684d-20261028
X-User: kuangkai@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <kuangkai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1840816433; Wed, 28 Oct 2026 20:57:18 +0800
From: Kai Kuang <kuangkai@kylinos.cn>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	kuangkai@kylinos.cn,
	kk47yx@gmail.com
Subject: [PATCH net-next 1/2] net: dsa: user: use kernel types in ethtool callbacks
Date: Wed, 28 Oct 2026 20:56:15 +0800
Message-Id: <20261028125616.460636-2-kuangkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028125616.460636-1-kuangkai@kylinos.cn>
References: <20261028125616.460636-1-kuangkai@kylinos.cn>
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

Use u32/u8/u64 in the ->get_strings() and ->get_ethtool_stats()
callbacks to match the ethtool_ops method prototypes.

No functional change.

Signed-off-by: Kai Kuang <kuangkai@kylinos.cn>
---
 net/dsa/user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c8ef..cfad269be75c 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1023,7 +1023,7 @@ static int dsa_user_set_eeprom(struct net_device *dev,
 }
 
 static void dsa_user_get_strings(struct net_device *dev,
-				 uint32_t stringset, uint8_t *data)
+				 u32 stringset, u8 *data)
 {
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
@@ -1043,7 +1043,7 @@ static void dsa_user_get_strings(struct net_device *dev,
 
 static void dsa_user_get_ethtool_stats(struct net_device *dev,
 				       struct ethtool_stats *stats,
-				       uint64_t *data)
+				       u64 *data)
 {
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
