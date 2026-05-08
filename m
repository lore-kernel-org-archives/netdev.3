Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA4371CF5
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778224489; cv=none; b=A7ANbYukDg3UfasmB2wO4bu1X36CQwc//+0QKqPNi+APMlQkMdqkzCfW4xQ75P31nB+0ABHxT2f7F2XwyFPI4xDJJVpnh7RVm+5QB/ZxLr/BtM7n2RTFpWFCeAo5GNoU2AvPHCsfCSi1qXA4WTmNWP4t8pqXH8vOq8Xzp4llS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778224489; c=relaxed/simple;
	bh=N1JEOCDOPreY6GbPHGQzg3SJVqZsYyVQve9aR9rWbGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ta6FJPCoyRaA1JnDI2ilkNn7T/d6FLcrHHADLYncWO5jL5DS/+7J6R9LfX/phG6K2tegHJvqwUyNVdz3dS4GaVYjv5/bFqnh2cLF6Yc+qe9NC21TDo7peS86Tn1OVMSIKODhtp7eqRwopMxn+rIf7miGbwg4SNZArsGUHXcN+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8f920e444aad11f1aa26b74ffac11d73-20260508
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7243540b-95ec-49f8-88b3-9821bcd809b6,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:7243540b-95ec-49f8-88b3-9821bcd809b6,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:d45dde80c5f44ad1daf72f7632d998ce,BulkI
	D:260508151432W47RJNLT,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_AEC
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8f920e444aad11f1aa26b74ffac11d73-20260508
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1948737763; Fri, 08 May 2026 15:14:32 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: andrew@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] net: ethtool: fix missing closing paren in rings_reply_size()
Date: Fri,  8 May 2026 15:14:02 +0800
Message-ID: <20260508071402.183909-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sizeof(u32) on the _RINGS_CQE_SIZE line is missing its closing
parenthesis, causing nla_total_size() to absorb the subsequent
_TX_PUSH and _RX_PUSH entries. The resulting size estimate
happens to be numerically identical due to NLA alignment, but
the nesting is wrong and misleading.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/ethtool/rings.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 0fd5dcc3729f..9054c89c5d7b 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -63,9 +63,9 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_RX_BUF_LEN */
 	       nla_total_size(sizeof(u8))  +	/* _RINGS_TCP_DATA_SPLIT */
-	       nla_total_size(sizeof(u32)  +	/* _RINGS_CQE_SIZE */
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_CQE_SIZE */
 	       nla_total_size(sizeof(u8))  +	/* _RINGS_TX_PUSH */
-	       nla_total_size(sizeof(u8))) +	/* _RINGS_RX_PUSH */
+	       nla_total_size(sizeof(u8))  +	/* _RINGS_RX_PUSH */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_HDS_THRESH */
-- 
2.43.0

