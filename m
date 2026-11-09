Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226004;
	b=TC6a/m2aqvg0uBshI4yB7R+K38wb5yC1pktGVDDibVf87fp4FU8jQS3xeKtNLwziTG9l
	 8biMyh1eMndtE5o4TjZUtC+zii9rfaJDZrQiAgyGMGv2AEkSZRD6YJ/an9f/OPyhOmoVB
	 WuFeN+nzBm5nfXj4UEH5Vqs/0vP/J1WBC5+XW97pyNWI5/iNYwuGB2+4mfnL/+8EZh/WX
	 cv1WA5BoQiiq+PcG8bMGiASbX5iAp5IuycHWRPqZRcy/WgLrjkVU/G1Q9t/8LtuuqEzzc
	 Hx2Pu0E0jITXw4nR08JJvWl6wNhhjl9uE4MFZb6qjj6jPvImMrW2d3mkM+qHR1tiEsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226004;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=dhmDoHpcow4oeCOO/XWFtP3Gjs2nFgISQ/7ifIeA4nQ=;
	b=DPQYtX1cq62FnsiY+ZLlwyj3sZHRvkr0IYS5vy9VBH8MDq673QShIixBPej19ConOl/D
	 tVSV9WDa/2o4Xrt7fSzWcPxjqIrcqf4fadBpAYeP5I4puOXBKVDx0QBOKoGmlxda95/pD
	 OwesQlEWYjel1w8V0XBzKB4wpbz/ziwtsyeQAY/HbSJhl7IXnTP8GY9B02gRTQ3ozMo5A
	 Dbm7Li9CBgIYiO6uv4iXOmLj43RFuGY3Di9q6UMy3OZFfCU6efAifby4FUQIn8UPgLu0x
	 g3SEtuCTqLHs4GxRyWwFzi33DIfqyfibs5lSpWv8Q761OSR4Y6sQflMh823OV2lkPZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B6606A322;
	Mon,  9 Nov 2026 12:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C3B6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 019087eadc3611f19a56ed5b684f684d-20261109
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:513d9d1d-d390-48a6-b635-ece02fcaca58,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.19,REQID:513d9d1d-d390-48a6-b635-ece02fcaca58,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:7db8b62,CLOUDID:d478ab28b2b66b0ff79888d1af9bcec7,BulkI
	D:2610282057219KWK44G1,BulkQuantity:2,SF:17|19|66|78|81|82|102|127|153|850
	|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP:-2|1,URL:0,File:nil,RT:nil,Bul
	k:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_IBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 019087eadc3611f19a56ed5b684f684d-20261109
X-User: kuangkai@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <kuangkai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1700418290; Mon, 09 Nov 2026 20:06:33 +0800
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
	kuangkai@kylinos.cn
Subject: [PATCH net-next 1/2] net: dsa: user: use kernel types in ethtool callbacks
Date: Mon,  9 Nov 2026 20:06:06 +0800
Message-Id: <20261109120607.344544-2-kuangkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109120607.344544-1-kuangkai@kylinos.cn>
References: <f69cabe3-d835-4fb6-b654-d0e172bde743@lunn.ch>
 <20261109120607.344544-1-kuangkai@kylinos.cn>
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
