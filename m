Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794313680;
	b=IswbordALDPJrOF/msYozNPeX7Ag7IpMqQcyBfHpBc6ulo42nW1B1IJFKbXCdkQz47ko
	 qugpcSCVB7Rk7p2jzXGiLGmDqSRfnc0lM++vLCNLJD/TBWmHOS8fXooPS85MocfcwXZQj
	 IXREH3VUMOomkPAoWU4EmW7KeCBUkWkeqMgubfGc3Kz+QrHy/C5aW1QIxyR+/bZTUFmmD
	 60fYnTq00XTat4iHuv6+gsDMzB+Lpvrz5lvck2FL0dHrZWJP9WbHN3Jvd9F0HOVuQRSkT
	 okChEY0jHVMA0fVUaScLypcKA4DXjBI2DSXBhUlV79ELPBT6StvgRRR+hUckGZjbqLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313680;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=X+OXF9VL0IiKcmb75y51nGMUNWN4hcn/DxnM04i/Jwc=;
	b=xC+4i27F2OemyqtRt7QpGa+HrJrQCKOjkfVOPDCJAA2WP8JrZP2Ou+4pSa9W89HODDgN
	 gpshgy0bJXJmwfnoJSKYllFXVgAwXMjqwdQEiy+UwZs1jDqIciS6nRywg1Llc8y3whoIP
	 Hf1w2s7e4WlttMnU2RTVVlUcteQYRAH9UHi5Ua01xYAqMTiifBir1AS0Bd04cjtrb767C
	 C1Odl5ufecw1087opc0Qjy54xBASX60JclM21dSK9dwr+kpIDxRXbes2d1f9xBlrzsvPX
	 97wtLLaZvEVjr9+kIhLKAT/u4P/G7vNMzzdt5Tb98TAI36456iqi1kqpf7PRILQzk8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b="fzz/FzRq";
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=BubXO+ZX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E58606A332;
	Tue, 10 Nov 2026 12:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63E58606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fzz/FzRq;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=BubXO+ZX
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABASga1182493;
	Tue, 10 Nov 2026 06:27:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=X+OXF9VL0IiKcmb75y51nGMUNWN4hcn/DxnM04i/J
	wc=; b=fzz/FzRqNTMv/KmoIcB2TNsVFc+81BX+8iPabl9BeO62M9eNGNJ5/d3dg
	QUed+32xuOROUhLX9SQRrOsPXoWbG22/1UOdCrf8ajbrR2p7nSMZ3+93fr0SYF9R
	ynxaecZEZ/Q2Th59CqeTCwub9hEyhkdhvpRP57+8gaQNidqhE8eVuNgowXU2LJ2c
	Tl9rYb+XHpGd/yfTk36Tu9yl99BWnT0PBp24wUPY9t/V3z+Lz3KiTtxbg7tICk8X
	o9xgC+AEQ6fiD1u57pp6FqG1qENPaDjeGG2IkRHLH9s0FsItV2px3J3KKU3NMsRE
	w5tZZ8WHzz8t+hrvaMJZDGic0F1cA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hv0ksrrsw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 06:27:31 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnR+xp+e7KtLWUNF9XK/PIMzHgWy2e34hr091mY+yr6ulJJASAaQT+uyeARTRhczVjq8FXLP1LyBo1hK023JnI0FIiAK3rIswtQyI38+AgKtzxpgej9icSWMV4EwsJ0fjkxucE2ALu1AIKlmO9uIc5schRYY8WE1AhEllfU11UbgWm8ERN5MuM5M2AZSmur9b6jpxgMQEdZY9PyGy4b8LHscFoLr2CK+itJ+vLsKLnLIvrNIPIJhYapnbXei71R8NCMlv0fIfxlrwYSt9O06XKipPS2/QysHC/vO7IRifR2r7iRBWI1iZIbVSM8CGdJmRsN1Xu43/ONr4FoZ9LDyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+OXF9VL0IiKcmb75y51nGMUNWN4hcn/DxnM04i/Jwc=;
 b=hvgLEj+oedhX6jPJp9NYFiVksR5VMF3B9M+XbBwx7ucJZQKQIOSK0nDerCskH9TfDXXSm56pqA4Z4IYJzzaTHsthmGf32Sl2No0zu7roXDdHtdtx3tYVt+twM52YgZBW9bf2uDnsGdJp+7PfTAkjWDoeKV+e8VHz4Mb0LCgz6wdnQ8BZ4J4ri+XS1cW/gebCK2OtKrmbIp94N9mrvu1VhkdtDwHFrMrisfC6bS2Y9XOSXrL4Vir3D1d8PUL0S+YhuyRScRc6crb3I/04nKsMCUrYuF79czAJfgs84tXe7+nH1QV99IWDzZuzlnC4xjY02QUr4XWiq+ZcHtFyVx7AlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+OXF9VL0IiKcmb75y51nGMUNWN4hcn/DxnM04i/Jwc=;
 b=BubXO+ZXzkitF+UiiV5Ld+qkC1dlAGfRhME1z3JWm6kVGckU4IudZI6DbMLJD6+bytpq0NHY5cbuqmJyiVU8iE5q0I7yGMJbQManVZy9mG+nJcyq4p8ao+GeFamBccRQFbFGf0kZM6mdIRBfq0RAwXG0ah29Pv3qZ4Sr6/kL2BY=
Received: from CH2PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:52::28)
 by SA1PR10MB5784.namprd10.prod.outlook.com (2603:10b6:806:22a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 12:27:29 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::43) by CH2PR04CA0018.outlook.office365.com
 (2603:10b6:610:52::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 12:27:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 12:27:28 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 06:27:11 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 06:27:11 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 06:27:11 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AACRB0u766074;
	Tue, 10 Nov 2026 06:27:11 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6AACRADD003470;
	Tue, 10 Nov 2026 06:27:10 -0600
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
Subject: [PATCH net v3 2/3] net: ti: icssg-prueth: Fix phylib stop/start in emac_restart
Date: Tue, 10 Nov 2026 17:57:00 +0530
Message-ID: <20261110122700.1849634-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110122700.1849634-1-m-malladi@ti.com>
References: <20261110122700.1849634-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|SA1PR10MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f6d77b-04b0-446a-ab0b-08df3f25fc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|82310400026|376014|36860700016|1800799024|22082099003|18002099003|10067099003|3023799007|921020|261009223027099003|261028144727099003|261102123227099003|261022105027099003|261021123027099003|56012099006|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	IPjS51gAnuZbINCHqSbv1KRhcTY+Oi+B7RJYXwGLwJOifGoNLQLIssJLid3SyO75AZ+HBXXZ+kI76rjwXUE9DMd/TVeq4D6NhAtAdD5swxs1i5kZOybDoeXJfkzAhp8PF+ntl0Kc1qe4m6AZnq/gpMX9Y90zSw4dh1P21c/67MIvM2Caa1MzSMN+r+KvpRChJts8wFpksjPpi/matii4VWXfvX7GmBVIY455x1c38Yh5P8NbnZ6awLQeTXsKYFoVdN1hZSniIKMX7lUP1hgFEdEL9Qz1nbRwp6sTe08YsZ0NZSIG9P4ojZRyt354qt/xdTexFzM28imqawTZ0cJ9s8Q++eN4/r5dJkl3t6XcXjMQkJ5XmR0RV0Sps/iKiIV/5xeMm2Ab+3GvRvQulxxUqYDWfJith6mMRpa572FLRUfzyF8vHJpoB1aZIY8isAMyzX9HtKp0aO5TyC9f/xKUqgHtHXGi0ye96Uy/OrHXWPYJ6IHyj6SJM5PN6YuLvwZoPTtTEVUDSbIP7mpH6nWYeBVhP2+PFCpVjSqsOdMwn9Ct492P6VZjRcAZrcQ6MiDLecWv9Wj2riFWiKG/Fk/V9aa2hkhf9sxXQbY3rAgRHMf3QZvEzsvCjyXefPXYemCGy7axXBr4MKNDVlsQrHUjjOmLArVoqd/u1MnPMylxkSw88PU1hqfW0m1y/hz0sSpUnoYpeoS7FCIC5rwY9OdybTNJkito5YgTTpbWTJDE7fDTz+4uoVaXIbg0IhwzjlDC
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(10067099003)(3023799007)(921020)(261009223027099003)(261028144727099003)(261102123227099003)(261022105027099003)(261021123027099003)(56012099006)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ARq1HErFARCPENO6BRaGAI3EgCkHREc66T8JlkCgkZF2k89YJceClH9aM4OKD2VaNrsiVfPY2Tc3xk2WaPgosTZJAsgKqglQqdsr4henJarJ47N1D1o8gRNLiTS2y0TMk7zDGjKoWlhER6qfCYIbNLhYxV06z8r4Rc+TQVMr5qtlA4UWAjtwyq0CeWEIjSiQ6dLsF5maR3f1YjDPFz+AVQA4h28F3p0skn6NdqTtYL3K8cqzQ2Q+hDbqn3E45U3PR0S3HqMxNlcD6LHJLGO7t9mA2eyxRFucwUb2xiFOnrT0SRkaWfE1nI7igWMNcsIjWCyfXGnW/rtTQxkZJy3wU4Ex0W2n9TmTiv6BpDS2X8cj6CFwjBcqD2+IRYLufa2rNN8hNUAgoj0CQX3i6RHTRWN0c7R9IGKXh/8TbnTrHSbwEyX5Eq1xJRSV9dx4YLAR
X-Exchange-RoutingPolicyChecked:
	z/8ZSJ8ZlVWNc2bNK00D6cU7ADwbHw8QI0o2PAOHLB+Hbw26Q2bQTx/id/ASoXRCJJ7JTuIbuzyA7+l3F4RGAIyxr2F68wH2q1Te8iLjQGcsvPtnnZdgP/WnqTCeh+GGysjPuE1GkjpoWUnxIQWKAiIA/lH4P6LBywLFA5SVHIsxX64p/mycdMyhxA//8O7grsDR7dcyh/bzGRb0vxkky4TmdJ5rc8TKIpPfxWHZH61N/P9dZ8S1lmmNcrYvNRKtgflZoPQFBS/xQKxYgbmpFe3zDjG8GRWqw+B6DSStA6aBDlft3myDzQCzKb0xWnz6T6IVlI55qZc05I4Ps4IP4g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:27:28.7266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f6d77b-04b0-446a-ab0b-08df3f25fc41
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5784
X-Proofpoint-ORIG-GUID: 9a5p3br-7BNEqEgj9OrPTkiwpsATFHRL
X-Authority-Analysis: v=2.4 cv=bcH+w+PB c=1 sm=1 tr=0 ts=6af30db3 cx=c_pps
 a=T5SYj2RWWwK9pVLeGBda9g==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=-OF9Ws2OJ2pFFvDUBdgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0OSBTYWx0ZWRfX3ITDaV+Wtk0o
 np2fRJSfp6/wSM4piDHUXbM1KkEszfb5I/JS/4E+e2j8a+MuWpm1q70MKzHmmjxu3ARBLtkSN7F
 ZxpHFcGuu6AnwWQ5YoWQA/ptOfkex0KtyR02R8eypg21SgZfehhYc6ZxshK1lKikhhjNHE/wft5
 M+S38KBqs8vaw2OXI19ePFfi6riM0l+JGKrUeUYxclnNu9PK4+bYX5TA1BnKJea8yJt4LtxqbJU
 1ZLk6yUQiANWgzr4U4G+ygmTCjulEtBLmiHiePXmf1i4An49emsX8Hr0jQaZ1pIBKKlcI97KUdg
 WCt2w/jm1XAMcFdOyKTpKZsFxLJNpWSTMdwAX8IzompGbDa9fMbF9pwbSWzSAk0kl7acS+jYUcW
 SBzWYXJtyR6EWIS1h11hoqnIhwzLkwf3QCG7i8Xv17FhXKxxlQVqPgN7xro71QraWIRQzD4+L97
 9kLb0s1Wa0gjVf5lQ9A==
X-Proofpoint-GUID: 9a5p3br-7BNEqEgj9OrPTkiwpsATFHRL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0OSBTYWx0ZWRfX3hnMMlckEois
 AcZTSSnGQjeh/vAk/QLEwWw/5m4X8+tzgXA3Z+V1VVn8RouTIhE3RIaMZLjmCxh8EEpTGYHGsML
 TVibQAPRtBdVBp6grJskKevhu6DbRiY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100049

Call phy_stop()/phy_start() around the firmware halt in
prueth_emac_restart() to prevent phylib from issuing R30 commands
to the stopped PRU. Without this, emac_adjust_link() can race with
firmware reload and write invalid state.

Fixes: 9facce84f4062 ("net: ti: icssg-prueth: Fix firmware load sequence.")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

Changes from v2(v3-v2):
- Added this commit in the series which fixes the pre-existing issues
  flagged by sashiko

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 21 +++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b..ef5dce595f68 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1837,6 +1837,14 @@ static int prueth_emac_restart(struct prueth *prueth)
 	struct prueth_emac *emac1 = prueth->emac[PRUETH_MAC1];
 	int ret;
 
+	/* Halt phylib to stop emac_adjust_link() from issuing R30 commands
+	 * to the PRU while the firmware is stopped.
+	 */
+	if (emac0->ndev->phydev)
+		phy_stop(emac0->ndev->phydev);
+	if (emac1->ndev->phydev)
+		phy_stop(emac1->ndev->phydev);
+
 	/* Detach the net_device for both PRUeth ports*/
 	if (netif_running(emac0->ndev))
 		netif_device_detach(emac0->ndev);
@@ -1847,20 +1855,20 @@ static int prueth_emac_restart(struct prueth *prueth)
 	ret = icssg_set_port_state(emac0, ICSSG_EMAC_PORT_DISABLE);
 	ret |= icssg_set_port_state(emac1, ICSSG_EMAC_PORT_DISABLE);
 	if (ret)
-		return ret;
+		goto restart_phy;
 
 	/* Stop both pru cores for both PRUeth ports*/
 	ret = prueth_emac_common_stop(prueth);
 	if (ret) {
 		dev_err(prueth->dev, "Failed to stop the firmwares");
-		return ret;
+		goto restart_phy;
 	}
 
 	/* Start both pru cores for both PRUeth ports */
 	ret = prueth_emac_common_start(prueth);
 	if (ret) {
 		dev_err(prueth->dev, "Failed to start the firmwares");
-		return ret;
+		goto restart_phy;
 	}
 
 	/* Enable forwarding for both PRUeth ports */
@@ -1871,6 +1879,13 @@ static int prueth_emac_restart(struct prueth *prueth)
 	netif_device_attach(emac0->ndev);
 	netif_device_attach(emac1->ndev);
 
+restart_phy:
+	/* Resume phylib now that the firmware is running again. */
+	if (emac0->ndev->phydev)
+		phy_start(emac0->ndev->phydev);
+	if (emac1->ndev->phydev)
+		phy_start(emac1->ndev->phydev);
+
 	return ret;
 }
 
-- 
2.43.0

