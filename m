Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794313679;
	b=pFaMa9bLHr7mM6ZcSr+0x/5SVSkoVcE9HhzPHqF85ftVRQhZjdfzpF3vFnIAfvJ8VSZv
	 0wmKrsLbktJxd3J1PY4dqcjl3JeiLTrAf2sH12kT2MFzUqCJwTlHvIdxy9trcB3ljhdkV
	 Hv2hcpC68OZAH2zf32GfVw7W+4WtbRHsDdNzyPBsY31IffFBD462D6r/2yz+RNy73ODsc
	 S4BvHX0OIHiHFFI1M9qtVRVDUNGuZIlmwSArkrImgDw4CW7cQsQsH7JbT6EU0km8k59qD
	 QZNPQm3dvVoOIysUjs9Hk5CHEwR3R/qaOGtYtLozMCb8XaNNemGAAeuYZVhOvGUyG6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313679;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3FW3G3PY4N3YfUx1w1EJ2qYk2m4FbbpKN/Afe0zbJ1k=;
	b=1ea81a2Ogni3zhtjAIGwC/PIvGBv4vh9Y1Qb/r8ckPcChToyfBUGi+ss9wckWb6FlqSA
	 ZsT77ONEKZisI4H5ydrlC3GRIcS279U7+m1mDArgMD02RVogI9sDwd7hpd5YO8r7C5llm
	 ACRlguz8m7GBRWckDM3LxAPjgXmKq5XikXwnPfSdknVhQkRLfIMY9hZRy5t8PvdY9X0xt
	 iQzeUH4CvogVblK/lwAQ5yvcFTnecN4sTcAkURG2apeD0q7u1oW0NQXoLR6Bw3dhAVOfp
	 kLH9AFaCMKRplA8o/jexgqJkzQmvV/Qjpeon49dPneB/pCq/iT5BpvquB5VFzB4TOVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=foaaiYTI;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=JSTnVCV1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9D606A330;
	Tue, 10 Nov 2026 12:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C9D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=foaaiYTI;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=JSTnVCV1
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAB9t1t1180694;
	Tue, 10 Nov 2026 06:27:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=3FW3G3PY4N3Yf
	Ux1w1EJ2qYk2m4FbbpKN/Afe0zbJ1k=; b=foaaiYTIK1LZ3Qsavzd2UdxxuOC7C
	bGLbrtW8eFDQ+t2Xz1R85qZraK+3rHcP4jRB1lowNUlxoK3lAkyqvRVYDyEM2sL9
	cWYHBmY4Q6UBHqle6Qt3U+Mxx4sE5QXX+GOfdEwuLFl3+sHy8+DmrmngoOGRKGkD
	1EjbzA1lE2SwUF7g3/L7gbV8uVqQE12fEtMNQdwnAvQSitIqpZaX+4rMarz/3j0c
	yKT3Ytqzn60NQ+PsCSsCK31p53uv7ECEKBbjaYeWBekkP0O3jU1+TOExkLa2wj8Z
	fzlahSK6fCWYrWQwoy1USoUUmIykDR39NVRHOQNYEUJyq4mzpwWCrmMHg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hv0ksrrsv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 06:27:31 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5sj9oG+PscNB7ajZbAn0vQWaqdfu7vRRjfQJKDyBaykOVvKAZ4VUgd+oNqMrFdMoyTMtCilvmS7OakMBEkFxqWl8aFxjaR4TwciQHNk2vUntMsSo1KgjCfWRoRYqxbtR5rm84cL3MHAY8y9valF/ZgDd+V3REVo5CV2EXLtk5zGRPsYVjA+1kbm94VcyVcfAO6kEsdqRxt4AAxEiWVXxRVCmNRWwCwjJncc5Vv+npbaUUCwHo4DqpsVC+OQaIYsSO1DsLecYIo+aovolkVkrFQhRn77NYsrny1EU4Xt5jbu6XzWsa4WAFjiW5vZi+E/hV4C/DOprBXSIEO4cHba3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FW3G3PY4N3YfUx1w1EJ2qYk2m4FbbpKN/Afe0zbJ1k=;
 b=jbX/bX8q78coix7KvmrO9eHlHZOOAldnrS9vTm6V01MUWam642UR0TrOFk86v+hsxwYVA4GJbclbr03820baFz5olwFXw/G7iY0WARWjfEmYLaJgYFIO2px0jZbvZIx9AfvmXaKPH0kddt7P4TWX25V/hRnWF2h+vi92K3BQnGdaUn60PXeGrvjqjUbFZ2OExvK9QOCQ6O9z9Zib1IFIibfJUrwcnXIayWR0dGQ1dvyR7bM18pttd2t4TULhZ+YbQdexat9BqTpfu12kScW/FSBY9j2bANa5px1ap4UcIQFnx5606LsDLnfhzbpOk02DWlo8Jb2T2aBZ+xxS8/EpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FW3G3PY4N3YfUx1w1EJ2qYk2m4FbbpKN/Afe0zbJ1k=;
 b=JSTnVCV1cheyqlwGWJyLxp5V3H5mXRsHIy/7DMLLzLFNHzoLTYC3jcQhi+8Fjm5426N6OSZa6+JFQzY2YTVn0vAnBMt39xXwD70ZYw8zz/TvCG1DlfEyo1GpBPfkeYfyWbNG3xoWjW0EzoirFOLiPWXFv6+aELfEgub63TY4UaI=
Received: from CH0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:610:33::18)
 by IA6PR10MB997681.namprd10.prod.outlook.com (2603:10b6:208:5e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 12:27:28 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:610:33:cafe::7) by CH0PR08CA0013.outlook.office365.com
 (2603:10b6:610:33::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 12:27:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 12:27:27 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 06:27:05 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 06:27:05 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 06:27:05 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AACR5AV1788044;
	Tue, 10 Nov 2026 06:27:05 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6AACR3fW003275;
	Tue, 10 Nov 2026 06:27:04 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <diogo.ivo@siemens.com>, <philippe.schenker@impulsing.ch>,
        <haokexin@gmail.com>, <devnexen@gmail.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <m-malladi@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@kernel.org>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <danishanwar@ti.com>
Subject: [PATCH net v3 0/3] Fix switch mode for offload and non-offload cases
Date: Tue, 10 Nov 2026 17:56:58 +0530
Message-ID: <20261110122700.1849634-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
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
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA6PR10MB997681:EE_
X-MS-Office365-Filtering-Correlation-Id: 382e2caa-20b6-4fd6-9f08-08df3f25fb4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|56012099006|921020|18002099003|10067099003|261009223027099003|261102123227099003|261026140227099003|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ttRjIVuhw/flywBmEMTgh+Z0pjHpWGKzvVwUPDJuDtsattNENgidrSq//JOn+lA8Xzj1HSVWozM+D3jfTqA4uQS+dPI4qh7uEFLtdfFp+A9hqNDC47DGnPnmAjASni2z0cd1spMJhYZrLtAcz7yyaaeWNha6u6Z7y7gMWSzbNEY+pAmPatGe+rnC0kXuhTDM2hvYQmhkXycp3Hs7tJFwuj4JlPzTd1mO2OH8pQOJjoJ1GJzs5HbILLudDWD+8jvDWx1pUIICyZlLFBAnSFg5Q2O5uQv7olPCWY5R2IksV/B9VaRmuE+dcBAwtC4bTIvwjMEssPbn+j+Y5UB+iuQA5jrRj3sDPzOPxlagKgzx/RBcOHh+BY2A194JHYPPt4yIm6K/LN+9u0kyBAaH0RzCC1JNRUIFdbgngiLkrmK1/ef7nYdV83iw6vwRrYO4wgKISIqh2PZNwbC4xhSydlJLoXevLw3B/Y/XRHKpMrBN0TEfgnk5qPDnYatuEN5OCFSIyuz0KOm5BnZbhRJ4pQjbd/tJs4biuKxVV0UckRDmMdOd3UnO41M3O1ZXHgJ9Nb9N4q9107mln+zMod5ZvrNLcuEZD9FIz0U2XneaG0ZZCZjSUH9pcZbG2daGBQi85GxBVvx7U+xAq4+Hpz5kaCk9cdviKN8QCF4P3fnmx1HMUsJp81CuMu6LOTZsoZy6ZnuNBUCDmE8G2471Damcd+Mlhw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(921020)(18002099003)(10067099003)(261009223027099003)(261102123227099003)(261026140227099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eiMzUKRCZz9MEu+Hqd0Df/0IFFiWL9J23qzPxUBEiYmmenZvOSrSIXpxRuGnl39SKxpTegDv9ikzvC5OA5JgXiGu/hQWvpHH6o2+3iRT6tr91PSpaqh1Q19btIjyjlnHg8sRwy7vBZRRSfGR7wWKm3TxBYFzKpa8yRbVsnlrg4NyUP8Z1CGY+U3NuoAF3fECsVNNf+BPeFIaoT1bfS88OnzoO/UzNn66MvWiVE01eogf5Ss1peVhUhx9iw7GKcwxs+FX14xxSko1XvnqvGmQvGpq/gqP24+u1fTDBAm4S3vFxoTa5uFcWDvLZNHI6AtUDey8+DZBWwXQxxmzA5A10bmhxgfggVFqUZ239NtdawT34CXQ2lq57VhF9ROFL7MdjN1Lmq0uIx7iHI+m4J//WBRra9FvwE1OCrUhDiC0ZpWUhpEVrP6I+3OnaYgnJjws
X-Exchange-RoutingPolicyChecked:
	L3wY6fz6S5OFASPxm9S6gRixaC8pgEWM/+JcvVrkzbQRQhRB9Crqgb8p5vqYGssNVaPVBgjNA3DX2B+RcMViHAY4oi62JXUECQwEtSETrGW/IaowDiZnhLfzv589Ah/RJeLBeImLhWHE+JPF4y+v95So1A27ZLhvUiaFFShwpWmfi+BSe8Su2vnwaKZfWZAxVbR27f0o9zcMNE2tbNoXoaJy3Aw4O5AudUaa/U5+HZd/b8Egm8hZoe5znBeG9h+LARTkhHWoahWtdVWzWI3WhswvqeK/bGWJpLDD+s36Um/PEu4JlISOi9We43XvkD5jbWg6BBsg6MxVv0L/mmijQQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:27:27.1121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 382e2caa-20b6-4fd6-9f08-08df3f25fb4b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997681
X-Proofpoint-ORIG-GUID: YVCFvBzkTeUivlMQpl9-Ymp4fSZbmKwn
X-Authority-Analysis: v=2.4 cv=bcH+w+PB c=1 sm=1 tr=0 ts=6af30db3 cx=c_pps
 a=WV97qI32orZZISq0e28SMA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=lO2JvOloaZY23zWVXcUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0OSBTYWx0ZWRfX02WCvm/KbCQ9
 Yqh4UHmdFeKP+EjOYXU+J4/emJu4GTB7JExO+kl1Kg/rbKyC+CLzw4nU5InHw/RV3tUGKiMO4jl
 BmxU8SF7xq8lAebpvL8qwdfz8En/gFyFly1HAvDSmREMvTCrnM/OliOIAF3Rtf73s9A+M5Pu1+b
 4tpW8QG729sTNFDePj8z5piqVHRtM6HNmq9KhyZoLLgZOm08Nibp81is+mZl7DN3UtvNGbNNqKU
 Is73hqNO4eAOH9GnK+ZfozS3I5aVdyG9UjvWWniDj2i/+3P1qXJ6SnSJvwFRLvEMmdEL3tk3qI+
 X20CWwwofqvcHB5WXjvgzqZ7nIVi3TNeCa5bVLG5hDxkIvcZQdx4KCje1UV/fVrug9oVOwiz0uU
 bX4SNfrjS/blhnus+LmS8lMYhrhp+WrTvWfamotFSimJgc9/mOnV4pZJLYCjp16gYgW8YF0D5Fh
 Lp49RvPUx8ubxvL2DKQ==
X-Proofpoint-GUID: YVCFvBzkTeUivlMQpl9-Ymp4fSZbmKwn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0OSBTYWx0ZWRfX/G0iysZ6UtfT
 9QSRiTTstn4z2iGeROL//krQWcC0uCjS1iTl8GRSioPHDKVaWyAbpNwkvCQXIG/olwmgpB3JOwL
 X4C4eFIi95hA+RqlIsQpHPzMDfde37Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100049

Non-offloaded switch mode is failing to forward packets. This patch series
introduces fixes to ensure smooth operation of switch mode in both offload
and non-offload cases.

patch(1/3): Fix TX timestamp cleanup crash (ERR_PTR slot handling)
patch(2/3): Fix phylib stop/start in emac_restart (R30 command race)
patch(3/3): Fix bridge port_vlan and flooding state (multicast/unicast forwarding)

v2: https://lore.kernel.org/all/20261027131732.3411403-1-m-malladi@ti.com/

Meghana Malladi (3):
  net: ti: icssg-prueth: Fix TX timestamp cleanup crash
  net: ti: icssg-prueth: Fix phylib stop/start in emac_restart
  net: ti: icssg-prueth: Fix bridge port_vlan and flooding state

 drivers/net/ethernet/ti/icssg/icssg_common.c |  9 ++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 46 ++++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  4 ++
 3 files changed, 52 insertions(+), 7 deletions(-)


base-commit: af6f95c3300e3d234c813b80f831dd7b80b3eaf2
-- 
2.43.0

