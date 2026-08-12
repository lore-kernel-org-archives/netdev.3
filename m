Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F73264CB;
	Wed, 12 Aug 2026 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514844; cv=none; b=pp1iYhZHWZ4i9u6W205rr7rn2f1P2JB+yqMFdTAn0wKfA8iSRPcYGwg6ivqoDG0ynDz7EvhYW0FzoLBsCptWOK6cfKKASpOxLVIyzdWh4/GXvytlq5O/MXzUF1rKdJVsy8Vvz3e62pZlCzp13YcTOYZaT3RmeA/hzyNRbOg5tl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514844; c=relaxed/simple;
	bh=24lud8Z9XAXInmSyN2Mzoq2WG60MdV3MByguSIfmD+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LqHhWqnpW12lbwCgRLmdUuQo8ss1F62vipE2Kcxyv6ZaVcJrbZDEMkGBkpSQKhxDFAraRk3cAb4xbhCq9RZ+fvyFw01WECQkRzKVGbBCQ+qP3ExBt9SMMo/cp/c5Dj4HqZ+z8/RIGYidyV1bNNoiVhAheojMO2EVgsTGt03nzr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0ca70856961411f1aa26b74ffac11d73-20260812
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_UNTRUSTED
	SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fe2fff54-1a5a-481f-999e-a0a014724482,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:fe2fff54-1a5a-481f-999e-a0a014724482,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:7cc1386515968cedc9c2597e6dadd70e,BulkI
	D:260812140710S785HLRB,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0ca70856961411f1aa26b74ffac11d73-20260812
X-User: kuangkai@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <kuangkai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1677921544; Wed, 12 Aug 2026 14:07:08 +0800
From: Kai Kuang <kuangkai@kylinos.cn>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	f.fainelli@gmail.com,
	linux-kernel@vger.kernel.org,
	kk47yx@gmail.com,
	Kai Kuang <kuangkai@kylinos.cn>
Subject: [PATCH net-next] net: dsa: drop explicit NULL comparisons
Date: Wed, 12 Aug 2026 14:06:44 +0800
Message-Id: <20260812060644.210997-1-kuangkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace explicit NULL comparisons with the boolean form to follow
the kernel coding style:

  dev->class != NULL  -> dev->class
  user_dev == NULL    -> !user_dev

No functional changes intended.

Signed-off-by: Kai Kuang <kuangkai@kylinos.cn>
---
 net/dsa/dsa.c  | 2 +-
 net/dsa/user.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 9cb732f6b1e3..d72d7a49e113 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1382,7 +1382,7 @@ static int dsa_switch_parse_of(struct dsa_switch *ds, struct device_node *dn)
 
 static int dev_is_class(struct device *dev, const void *class)
 {
-	if (dev->class != NULL && !strcmp(dev->class->name, class))
+	if (dev->class && !strcmp(dev->class->name, class))
 		return 1;
 
 	return 0;
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 072fa76972cc..7d65bb307c91 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2779,7 +2779,7 @@ int dsa_user_create(struct dsa_port *port)
 	user_dev = alloc_netdev_mqs(sizeof(struct dsa_user_priv), name,
 				    assign_type, ether_setup,
 				    ds->num_tx_queues, 1);
-	if (user_dev == NULL)
+	if (!user_dev)
 		return -ENOMEM;
 
 	user_dev->rtnl_link_ops = &dsa_link_ops;
-- 
2.25.1

