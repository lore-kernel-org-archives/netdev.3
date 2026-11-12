Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794478937;
	b=f4MbFRa9T58XxzBILIHMCZP/kSQ6dDApgbbcCtt522hdY33tg+OqbS53W0vEY9JUuMpi
	 H5xmW/8UzWZ2SC6Q+1pevqReiwrW6S/0plsdyTeZl0WFUEWHqDvkSBAffmXXMppYGcXjF
	 I1EwweDUY1E6sokSBuUA9G6AmFvxQTPynFvwOKxqzAeKOvSmPDO0UDsASu2z0/G5ZrIZX
	 aueWTvQMG3C181OBrQ402zR8zKSM+qZ/HmoPAp0rgNwzgqpx7LiiW3fJ9fnRopHB4Idfv
	 XnSDzbXRCeeeOB/dkfGSSD1AV+ZyxVnJRppvVd65s4LuT98rYIxgj3cc5YI+aiXdBdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478937;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OKX0R9uRaeU6rm5xTyg87v9nl9FNTIScdmIsE2d9cH8=;
	b=AkXQbFnS1JuRvgCKStQBcLfi9RX+depQOGURUSMl/gm04bPrbfrRrwJTnlnhBHH0cniE
	 hrY+KzAMEajCfHk+gSTHuw0h54+d3JJKZHOFEcepUykZnsgT41QPb5yK+TP6vrVh5oAzn
	 1zNffeL1XEO/Pb94vkjo3gdxT18UkAqcHX3QivFA8LdYj5Otz4FJRQfjzLgxlaSM4rB9k
	 Z3qD71ecwy88Acj6yPQV7OjamrtN5oGUYFSJxOrRtPRtc4nagMUwwEEYLqA3nHqn0Urg9
	 SueP+JQ9Gtufy92sXu9tZD1jaHDJHEdb17hY+EilwdZ7rwCrpgiYG4F0pMAYiICs93Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cnuTKZFc;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=dWZ3m5Nb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC80606A321;
	Thu, 12 Nov 2026 10:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AC80606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cnuTKZFc;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=dWZ3m5Nb
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AC9M3xX3863367;
	Thu, 12 Nov 2026 04:21:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=OKX0R9uRaeU6rm5xTyg87v9nl9FNTIScdmIsE2d9c
	H8=; b=cnuTKZFcPO0E6nmNXfO/VzczIZ3kl9uu/Al+DnNMQuy09t4lP2DxLwp0H
	nS1Q8GYDma1BRPXQLtrM6wHjj0rJP2DoN3lNQND/Ld63DGE7YlD4oWMDFKXF3bVm
	m5Ego3JBZ0p9NxGXd5liV42/asJFteildwmb3VJuPqmQ3ggami4QAQohHuqiTftL
	YnEfX+picuUyAElwcPx3DjQRDhmSBsmm4vdaOr75tLSTHQ7pGaZNFXpKot7IW/jd
	gsoyB1Ak4+cJzfR2ruk5xBLpSm00Q0mdspYl4HUR9RqY+OB59YgV4aexN/uJ5G38
	w/iqPSaU4rF9SGLW/dzccYf6V9ayw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hwarhr8mw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 04:21:59 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=km/8iNZsOUBnB3vG5vjRLalgj2XGUjJxwKMt09YbMrhVUYkK2Oj7+emHDiq9FUE16+N2IsMLAyk5Ownx30sP00Wr6Z3ldQ2sqPcR3eAniraOJE3nSKUCRDXe12I+MA557VspI+4QPZc4L0Ao3ALW97fLw3UKXsEGJzD/wJ7LxeCzMAQc9+4n+cIL/WQ2cWZn6hptAialDMBxtcnzqCrM6YkFp77hw0356YqvDzScjVtoO7oyZA69Who9RrWKLQuXeNNHH9KgjZrWElfFWD64NtRIewY82nIJCr2kOnhnixBuPBc/4kqLhScg96flkUDY9rwY6LkyZd6D+mpQfB3FMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKX0R9uRaeU6rm5xTyg87v9nl9FNTIScdmIsE2d9cH8=;
 b=MfRkOD580bLhjQUKV1W4FjWsVhpDkZ5lVNHWXBI1DXZYuVgk5e5Zpo80P+IgJn+7Sqzjr3g3FN+Rjk60a5G4tQrqqeggS8+HmpcSDum98RrwO3N/SAbj0pN2rgt/wmnKjgs81YdPKlG91e2cLZ2T/tCbaZqkQ2+40gkIVpu3wf522mPXQBuA7NWLTW12z0Uyd23WZPgr7as1zVBKzEOFZfUz8kBxM3qvnc3O0wByXaePYYLi+RFSxYSVJ+PrxYLgjVtNFUUTCr5apropBjQaBvM1Vj2mq5svReSx7Pb4m8ucE+k0p6HyybRxomHE3i/HrI4Itsd8QsMyhb0bMXZu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKX0R9uRaeU6rm5xTyg87v9nl9FNTIScdmIsE2d9cH8=;
 b=dWZ3m5NbCTJD03BINpBih4Qyn1WfW3+imBfkPKyqHDNbkx4XjsIYMEsCtnK19Ugc6PSOzVMcDgY6INAyz3OlKWk8HvFssN6CJPLFWgMaAVCVeJhLO/ZSR9l4e6tc11PoIucVsX5eedGcoo+cjwJRBP6RbuCrNuPvitvtl7u2aqs=
Received: from BN9P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::23)
 by DS0PR10MB7019.namprd10.prod.outlook.com (2603:10b6:8:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 10:21:54 +0000
Received: from BN5PEPF00046987.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::21) by BN9P222CA0018.outlook.office365.com
 (2603:10b6:408:10c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Thu,
 12 Nov 2026 10:21:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN5PEPF00046987.mail.protection.outlook.com (10.167.245.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 10:21:54 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 04:21:48 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 04:21:48 -0600
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 12 Nov 2026 04:21:48 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ACALmQk324312;
	Thu, 12 Nov 2026 04:21:48 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6ACALlgC018499;
	Thu, 12 Nov 2026 04:21:48 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <diogo.ivo@siemens.com>, <haokexin@gmail.com>,
        <philippe.schenker@impulsing.ch>, <devnexen@gmail.com>,
        <horms@kernel.org>, <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@kernel.org>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <danishanwar@ti.com>
Subject: [PATCH net v3 RESEND 1/3] net: ti: icssg-prueth: Fix TX timestamp cleanup crash
Date: Thu, 12 Nov 2026 15:51:38 +0530
Message-ID: <20261112102140.2744508-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112102140.2744508-1-m-malladi@ti.com>
References: <20261112102140.2744508-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF00046987:EE_|DS0PR10MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e702fc-e165-4580-b7a7-08df40a6c67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|36860700016|376014|1800799024|82310400026|10067099003|921020|261026121527099003|56012099006|261009223027099003|261102130727099003|261021121427099003|261102123227099003|261022075727099003|261021123027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	hsIxuXS6wSvFq73ETEX+wcjie90gPOKZbk/yhQZqL6PCxAS0dOs18nLaiEv/OQRVsUQoxfNkS5G3cfTZ+zNg9ZqRzFlc2m1IHQJlecwWz0OiK/9m5TMgisbqLmZrgWiZsdSVfljiDXT895502pib1vbRZIcxAIXs1o3dxCSoan9RVKttzsGHu8Me71tQC6R+0BPf3pkq+8a0nNSu8BPF7IXuSh3HpGp+JG5VkFGcDXmNA/Rx4wkveeNdHts3kynY/b1JfGbdI4ro5ZWQd0AyaK35t14SJlOX8GlZ0CXcIALoo+GLneGSdFdTLo+jACv7k8glZUSTu6t7F4VZ9WefzABYK6aQ7VCWkOQ6GvZZ80usrGQ3xRL7lLcpmWgXKfb5X96umBMmWLrdTXtnZZBSboiq5foer6kIevUMnJLQaNKR9LOhhvzlvF7h/as2g27ySh11Az+Rcik8B2LIwc4zXztajnXYhFK8xW/f0P9qJ19KKUFJJkv7FO6mALElD42vyihJncDwsZAWWZ+KdRsusLA9WLalXOJ0o8qmbzQtBRcut8yfxGGfAs6wjmI2EfRn20t+whlDIf/CoMzqGHGp2er04oS2Tf8+iT53/VKS8Y+Ze72SFJBIJb8iRZ+ySPvgYv/Zpk1Vtyil+kdOwoWiB6xrMRzlN0hAppovjJaaSp/jlY0fHDQutOrCNr99J4l8JH95xnJXZU3MbFblomHCcOYO8xFh2QgR+NO5o623wdZrC4SNLyK6oByjvfKpNBVJ
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(921020)(261026121527099003)(56012099006)(261009223027099003)(261102130727099003)(261021121427099003)(261102123227099003)(261022075727099003)(261021123027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ffrzE0Bp4OxBGI/TzP5wNxvcH5jKSAFafRiCwJvQPJLLb5HKaEzLUHwej6y3xlKzakzb7BDI3rpGamVv5c8QVjLuW8ZVgnoqDUEpHKtX+6ERDuixoUU+bT3LV0DideF9ID52QuGu0dh3XB5JF4jlU43CpbN+nMnRbWkB1skeo8kjgfL3h5oBvrTdxzzlQJ9JCu5mMdv9nOo9/+4hXveNoM8W5N/6Yoz/dlqT+ZZpQID71+VySVXIXioTd6NH/wc7yfaMOfhUMy3VyVFfkKiTAiJcBYnql6DIUxSRje5M5yN9C91EwsqOAuv9FBLnODcpGt4I/iqG+rwqCiVKv0iAduLFt8c7RADzTaWOFfCpO4tIku1fugepwtrOBa+2iEFdB3AVHGzxbR6dgr6BmQzL7nt1/jzdWZnrxZB55bE81GPXZziJG0VtX04hozxYvsAA
X-Exchange-RoutingPolicyChecked:
	PS7pvDi/rMhKDlRzI6GBzx8+TUbCn2oZbWeUrFdschK3U+6SNvtmSRego1ByJ0mZNIGFLnCjPLtRo8ZUIzss90E5ruzx9DTBGT1CkiPwO9K8kx9iaqczK9sb1VKoa/s8QV4Yv+II10UETqwL9N5XadRKUImrkKNNoe+NCR2k7RimTvLBA8u1Ko/LLkSSGCeNKN8Vgt9lrm8VyErAjGJJIraiRJnQKEiPbxkOZIOC9O0oq39w/7Z/L2lAoIdETtibyTtSo8kCycIxMgkx+BLI1G8wyyzW8Bwvk06zkm5rKbl1UbnYFS1ruJXalzYPCpfBg5blpoGXEIg7XKRBuYLisQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:21:54.7510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e702fc-e165-4580-b7a7-08df40a6c67b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046987.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7019
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX2b9+5ev8v7qO
 9pX90yB1ebK4WtScjBnDTHMx2QuEboHLXSUBC4xuMi4PlXBopUuYdUu8V1JYJVBRHygUGBWA8z9
 IgvSMg6K69oxjOQKY2pDL+N5Qft4XhI=
X-Proofpoint-GUID: nrCBs43Tgk3TyiYikeIWdhbyD468oTYs
X-Proofpoint-ORIG-GUID: nrCBs43Tgk3TyiYikeIWdhbyD468oTYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX/Abnb6H1TY0B
 SnHsVyFIgcD9RDiEAtZdkRRfMxNDaiKejpHx5xVk+7B00KwdZWzCpyoqqIU/mPEZeusVLqYGPQf
 jvAsglGW4MwNBE2R6hMXV52fRdB++xgespXOa8CdHmiWPKDRWewxrNJP05DzV4tHK49oRFXvmNV
 Yv9xq14tekddGIlLcW26yhXsAyzVu2PYfOCRKTrAhRyDU+VOWdriTpRmEKSmB3r4RTxRlUAnTgK
 Yk4ZvchIW44lnO7QWWXJieXd0oAFeQtoC/HenrsbuJMYkcWRFzXJWAKkCKlDU+6HqVxTv+ewqXw
 /2bnQ8xkttdwhe/sB3luArGz2jxHHLJSIQN4l/4EQqBQrbmALszPshZRbvFM1xxgy/kmD0ZoXZk
 jspsExLO+XsTgY+GUVoCgmHzWVH8wFjIlj7Ga/ndCXgzbqtvlAt8L5K5rFJkmb13qgfmjKx7yyS
 KjrOSajWKkz6BmMTy+A==
X-Authority-Analysis: v=2.4 cv=Y4xtIReN c=1 sm=1 tr=0 ts=6af59347 cx=c_pps
 a=0/XwxnXJ+7qPZvmcTWkk5A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=pnYs4th0mlcjFpja-eoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120040

prueth_cleanup_tx_ts() incorrectly frees ERR_PTR(-EBUSY) slots. The TX
path reserves slots with ERR_PTR(-EBUSY) before storing the real skb
pointer. Use IS_ERR_OR_NULL() to skip these reserved slots during
cleanup, preventing NULL pointer dereference and freeing errors.

Fixes: e2dc7bfd677fc ("net: ti: icssg-prueth: Move common functions into a separate file")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

Changes from v2(v3-v2):
- Added this commit in the series which fixes the pre-existing issues
  flagged by sashiko

 drivers/net/ethernet/ti/icssg/icssg_common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 4a7d1a6f470b..8cb2ad2ebece 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1426,10 +1426,13 @@ void prueth_cleanup_tx_ts(struct prueth_emac *emac)
 	int i;
 
 	for (i = 0; i < PRUETH_MAX_TX_TS_REQUESTS; i++) {
-		if (emac->tx_ts_skb[i]) {
+		/* Slot may hold ERR_PTR(-EBUSY) if the TX path reserved it
+		 * but has not yet stored the real skb pointer.  Skip the free
+		 * but still clear the slot so it can be reused.
+		 */
+		if (!IS_ERR_OR_NULL(emac->tx_ts_skb[i]))
 			dev_kfree_skb_any(emac->tx_ts_skb[i]);
-			emac->tx_ts_skb[i] = NULL;
-		}
+		emac->tx_ts_skb[i] = NULL;
 	}
 }
 EXPORT_SYMBOL_GPL(prueth_cleanup_tx_ts);
-- 
2.43.0

