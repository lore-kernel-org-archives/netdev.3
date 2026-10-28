Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192216;
	b=Tc+rUvKUuLNFi8nmw3iUTpDZKFpmxqHfLy1viIBhi6HI1T+wHcjR9ztz5ZLp4/xYMZQp
	 twQCeZY02X8Ls3WYVMB17qPLSbOLvUrNv82AxPQPDUuqxlWQSLYMvoPb76ibnXXj5leVH
	 Snsq1Jc8y9Bt8SIpF4YKRua0lTls6P+4pf3OqVoi37E5gcACX4W7ivBveYCIpefBZllH/
	 QNv363JgdCCBNtzES7kh7iLe+toxRW2y9wZ6ZnHJgMc5+3oi/jKoujIVZW5w2fwp6BnPI
	 z1TspGSlaokVNhUl0qUoaYNZdAE+ldCHt4S8YhTmvElQS0TVfZb7sC59wUcH8BbhbkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192216;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xo10oPJFlElutpdw8+Niy1EcmDhjHjySmQmxuN8Pzjk=;
	b=1vvNlAm04X7+gIySViHw2uBUg2oN9+CiYedyYKaQsQ7BysGXNy0u7AWA+IvzUQ8y6fdG
	 GdZA09VG+1Q+ZKc9fk/4jQOMvw6oMC4OMDMuoG/xJpWk0uEiJEl+ft+0JEbg54z2Ou6zK
	 VhYLSbpz8TqwjY3eHg1En+rI2zkkcOocVgMzYcWILIXMVpw8maq+eg+fDrW2eDAPe0xHh
	 tVyx62QlwWRMbcaYBpiIMrlG4FwGNbSOSucYcpLa9jWHvgrD8zbKkPq785+v3d9rCIcEw
	 DwBbo+beo3YPxCE8BMiAWotOdawddYDbeK0GXkfxnYDPLT+1stf/2dKaa9pKRw/B+tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EEA606A31A;
	Wed, 28 Oct 2026 12:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6EEA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 07c4ab0cd2cf11f19a56ed5b684f684d-20261028
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
X-CID-O-INFO: VERSION:1.3.19,REQID:6e7a09f6-279b-4e1b-92cf-1cad2ba2746b,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.3.19,REQID:6e7a09f6-279b-4e1b-92cf-1cad2ba2746b,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:7db8b62,CLOUDID:81d9e67e5fe83f34ee69fd3959b34d10,BulkI
	D:261028205648ZJS9BQFX,BulkQuantity:0,SF:17|19|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50|99,EDM:1|-100,IP:-2|1,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_IBB,TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,
	TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 07c4ab0cd2cf11f19a56ed5b684f684d-20261028
X-User: kuangkai@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <kuangkai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 572954561; Wed, 28 Oct 2026 20:56:45 +0800
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
Subject: [PATCH net-next 0/2] net: dsa: user: minor cleanups
Date: Wed, 28 Oct 2026 20:56:14 +0800
Message-Id: <20261028125616.460636-1-kuangkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

Small, self-contained cleanups in the DSA user port code, found with
checkpatch.pl --strict and targeted at net-next:

Patch 1: use the kernel types (u32/u8/u64) in the ethtool_ops method
implementations, matching the prototypes in include/linux/ethtool.h
instead of the uint32_t/uint8_t/uint64_t typedefs.

Patch 2: document the plain wmb() in the LAG DSA conduit migration
path, which orders the dp->cpu_dp stores before lag_dev->dsa_ptr is
published to the concurrent RX path readers.

Both patches have no functional change.

Kai Kuang (2):
  net: dsa: user: use kernel types in ethtool callbacks
  net: dsa: user: document the write memory barrier on LAG conduit
    migration

 net/dsa/user.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
