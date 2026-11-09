Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226008;
	b=RpUu5Q2HoKi6piinHPMNp+s8J8lUiXbbE4vf1JDjgsTeHvnI2t1pijp3GPnQvji2mPy8
	 jL0/mgwGZCyATqoifUGaU2nMqIw/BZmGqnUvqUzVJSeUHO+vCWEPg9VRRzXJvLv7X3AOf
	 Tlzy8qDqqihc9KnAi1+IIrb2+iPHdepb1jFrR72K32CvYA1vS4cwt/y7HsYEodzlxdkfi
	 eIYPSL1aU6KqKLUvsQMzxCtZPN0UtTv9rbXHJFHPRjbkB2FrqUBHEC/MvpwnLG4EWjxMr
	 uE+1ZhexZVr6IU7C9r/gbwgkIehtT2ijcMGqlvjMFjdEORnsITFjr+1tz4jCbKPZi1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226008;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=yt3WbBNsokrx1GLsVBUP/kPCjBPvwq521Pazi0r7iec=;
	b=DQ8wazfhhGKipmGmFj7JCXE+KmrMmmVqWUG2OkcIgXoS0tUd4P4outhgH1DsIHl8WgPQ
	 /BUHhzjW9Po01GRFG9OQNPAcmGZcNHFQcOQLmXfI4lDYbsn62FTUNgKedoH4jCinbMUq3
	 1t3q0XCkFdNacwE6zeWkQqQBNKGLQJNAwddC76+ZR3X+tdxBWwp/il2vZQYLJyI5QC2jm
	 6oZ7r7OERkzzWaX4rpyPF0Hc5MHn3RrD45cD5OFKCdsiT6gryi3fkn3+Szu/nngaBa6ZR
	 1ot8DgZibgQpOBZfVBmD4W+H9IGa2C8nnHT5SKJHHEaaDVWCt+BHB6OBxQGuRVMQuAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98429606A336;
	Mon,  9 Nov 2026 12:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98429606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0311fc02dc3611f19a56ed5b684f684d-20261109
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:110ebaae-0c75-4773-a1ab-e4e701bafbd4,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.19,REQID:110ebaae-0c75-4773-a1ab-e4e701bafbd4,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:7db8b62,CLOUDID:f2f08f75042da4d684049ed9daa7bb04,BulkI
	D:26102820572488I2YTO1,BulkQuantity:2,SF:17|19|66|78|81|82|102|127|136|153
	|850|865|898,TC:nil,Content:0|15|50|99,EDM:5|-100,IP:-2|1,URL:0,File:nil,R
	T:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP
	:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_IBB,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0311fc02dc3611f19a56ed5b684f684d-20261109
X-User: kuangkai@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <kuangkai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 169206442; Mon, 09 Nov 2026 20:06:36 +0800
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
Subject: [PATCH net-next 2/2] net: dsa: user: document the write memory barrier on LAG conduit migration
Date: Mon,  9 Nov 2026 20:06:07 +0800
Message-Id: <20261109120607.344544-3-kuangkai@kylinos.cn>
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
