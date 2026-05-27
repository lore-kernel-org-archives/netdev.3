Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3811A08AF
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864847; cv=none; b=kc6ztxTs7UlWKnTFvq2xC2RLP6nPTqXYT1DNdGyohGITWoeTvqbshOwnRVO2fh/uxd5Af+8Whhe9iFnj6z/EJinGMPmdSA8vadhgc9MXrUTCnbbTQavMRx+quRMOWY8PVgmyzacGIP1LbB2t4WRivzeHlyT6RmxsVDbZu9unvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864847; c=relaxed/simple;
	bh=yEQwL3MUelaw6hKSCMnzIE/HbZBXjhlrn/C4wcCtYKI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q+z2GtowA3gAhj0PL0+mDPIPF1moc7iiTmt9TS3xL/ZFc4xYozqJjJmUeYR0BaI5AJo4cMIfAKwWXg8zDBJcKUL551FWq7M+e9SElWaTazEJdW7b39noSmeTOf07BXHsnaDhf6IA3ygH68kHSIPsA6mBhPL8bBewRoOpzJVqWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kAdjz4eo; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kAdjz4eo"
X-UUID: d2888576599811f1b1788b6acf885367-20260527
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=T3IulHUKib8JGWnWMEWHwbse8Aex4qYCKxD3FE3iZdg=;
	b=kAdjz4eoG1iroKQbNr1e7L71KGla+bnnPbHxZXppBwaUsQmVlsEdZ7gcKgi4+nTXW1r4WeGKPRstkKd62i64nRldUDO8CzEoDVWkIMFSKpDrxZ5ecCEZYKENCQnChyV9Nxmd25X9Jjed58AWcWkv4MSSUUeECpFU7cIN6Zqmx5Q=;
X-CID-CACHE: Type:Local,Time:202605271431+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:d4aa7c4c-6c09-4a7c-8c33-4047b55f2eb5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:acfee8f9-9444-476a-bc04-9e12dce7d69c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|836|865|888|898,TC:-5,Co
	ntent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d2888576599811f1b1788b6acf885367-20260527
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jianyu.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 145209192; Wed, 27 May 2026 14:53:52 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 27 May 2026 14:53:51 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 27 May 2026 14:53:51 +0800
From: <jianyu.li@mediatek.com>
To: <kuniyu@google.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <black-ch.chen@mediatek.com>,
	<ivan.tseng@mediatek.com>, <jianyu.li@mediatek.com>
Subject: [PATCH net v1 0/2] af_unix: Fix inq_len update issue
Date: Wed, 27 May 2026 14:53:40 +0800
Message-ID: <20260527065342.2463433-1-jianyu.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Jianyu Li <jianyu.li@mediatek.com>

This series fix the problem that inq_len is inconsistent with
actual remaining byte count when only part of a skb is consumed.

Jianyu Li (2):
  af_unix: Fix inq_len update problem in partial read
  af_unix: Add test for SCM_INQ on partial read

 net/unix/af_unix.c                            |  7 ++-
 tools/testing/selftests/net/af_unix/scm_inq.c | 54 ++++++++++++++++++-
 2 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.45.2

