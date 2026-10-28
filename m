Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192249;
	b=V7SOE119cfJueyfgpvQIsS+A1IvYHTpT1S/Z+5TkTqnXVXs2Nl+MoL0WDZ5o2gRlCcqg
	 eLgMD3skWnGtNJXQDwcQusRfQaAgq/mzHWvTUPmO19fARTrXJwk4sHHxhJX4Fbnm3jkUe
	 22y2c6hklHVi+BgpZKghgQjyNU4TxA642Z2yiiwvJdGDUwsb/vtgA2X8MIZytoUYUb4+G
	 8aSWWoVUHJ851i947JPAsHDTrAPj/cNndiBAI+/AHeyomd2J++5uemDubPZUavvTgueZz
	 hRFUUhqjKMsoaqC6HMIrmYlgAPeicavMgwZYMIQKNJz8Z/h+7tcErSrmHVHZDQUOYPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192249;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=yt3WbBNsokrx1GLsVBUP/kPCjBPvwq521Pazi0r7iec=;
	b=fcKZ4VWDNaRVhjeqBwgxDks1e0q0U7ONCJbk9lCXhqs9G7Qq4/JwhZ3bTefd0RWHN9iT
	 yZojrPkj2y/hu96Tw8q+jC6ghPeNEGOrX2qLWYv/MtBG3UptVOAE/c2pDHPzi23rS+CgO
	 yRWP+WdMOzTOCIgQ0ynB8OpL84F5VzuTFtH6sqXMmWLkVVa2Ujd7JVJgS359sWad7j0J4
	 FK8KrzwCgkys0tj/91FWmCVemo5C6CwKOoZOe2gWinqcfg5ifyxFre0aJEmtg2iBw1975
	 WMlczvElXJQLet/UiO5oVps0hedsKdZHB3wLoOjvx9ZlJZmJe5H8UnAPH7jlh7AFIxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2E606A336;
	Wed, 28 Oct 2026 12:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE2E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1cf1a732d2cf11f19a56ed5b684f684d-20261028
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
X-CID-O-INFO: VERSION:1.3.19,REQID:576d841e-cc06-49e2-a1f6-4be0eb9aaf51,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.19,REQID:576d841e-cc06-49e2-a1f6-4be0eb9aaf51,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:7db8b62,CLOUDID:591dd44481f074b18c1761cf62751fc2,BulkI
	D:26102820572488I2YTO1,BulkQuantity:0,SF:17|19|66|78|81|82|102|127|136|850
	|865|898,TC:nil,Content:0|15|50|99,EDM:5|-100,IP:-2|1,URL:0,File:nil,RT:ni
	l,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_IBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1cf1a732d2cf11f19a56ed5b684f684d-20261028
X-User: kuangkai@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <kuangkai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1177936434; Wed, 28 Oct 2026 20:57:21 +0800
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
Subject: [PATCH net-next 2/2] net: dsa: user: document the write memory barrier on LAG conduit migration
Date: Wed, 28 Oct 2026 20:56:16 +0800
Message-Id: <20261028125616.460636-3-kuangkai@kylinos.cn>
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

The wmb() orders the dp->cpu_dp stores before the new lag_dev->dsa_ptr
is published to the concurrent RX path readers. Document this, since a
plain barrier without a comment is hard to interpret.

Signed-off-by: Kai Kuang <kuangkai@kylinos.cn>
---
 net/dsa/user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index cfad269be75c..96393d4b5da1 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -3435,6 +3435,10 @@ static void dsa_conduit_lag_leave(struct net_device *conduit,
 		 * physical CPU port
 		 */
 		lag_dev->dsa_ptr = new_cpu_dp;
+		/* Ensure the new dp->cpu_dp values are visible to concurrent
+		 * RX path readers of lag_dev->dsa_ptr before the pointer
+		 * itself becomes visible
+		 */
 		wmb();
 	} else {
 		/* If the LAG DSA conduit has no ports left, migrate back all
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
