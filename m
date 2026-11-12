Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794478936;
	b=CvDx6E1IYnmf8jjmJksgE2Muu1V+P0gWJUh7viFfdR3XboP/l0CE88LQfr9Q6S0ELtgH
	 SoXXzc6gSgz146XT14BMaFDMcCyt6yURsGRNM5vJ6a4o3S7lfLzxajCVYEjURlV+rt2FH
	 gcjJCKVnSZcWzAd55lIijeZAwNHLBIcQ/PZT+OeBhhG+iqpU/kaBGGXb/FnJuSpzR/OfL
	 C/PxCzw2rLzz6oa6rpRHe42qztd8idL4wcwqfUAcmdC1Os5CbufSbzAe7bbKGw4j/xRnl
	 etdBuFGIGpGONb5O7F1PVhe5yP7XIP9LWOjRyMkZayF/umXnSVLNw8cqA6Q8eriQb4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478936;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3FW3G3PY4N3YfUx1w1EJ2qYk2m4FbbpKN/Afe0zbJ1k=;
	b=R8kPkhSkRO5d52GtD2sAAjkJp1y3+EYyPW3KF9veW65Iv0pPoXHNt81KQXNgevpxHFum
	 ysIGWjTwhSjG0DUfwOYtDnt2V53omAn2jE+lscSqFB0/w3LNcaVr63kUgRC3iPXcJN4D8
	 r/JMAedPrD2cF2uyKzUhE9AMQ1ELOOQOuVFyo6KWqKMzXYFweyn9jqnnphbKTckcIfGZU
	 xI9rP0XRpe9gzN8czGaP844pkn5qvcaKCMtQHd8cqY3qIX6vR3B2xVcn/kGlZET9G3seu
	 oWzpXO6WFGBMi+Yczee2srXMkSmKYGKVfBJTwqL3fOSirBNGS/naygA3J7uVV4+KH9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Y4WnKWO8;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=UPvaRF3E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD11606A323;
	Thu, 12 Nov 2026 10:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AD11606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Y4WnKWO8;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=UPvaRF3E
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AC9Lnl43862724;
	Thu, 12 Nov 2026 04:21:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=3FW3G3PY4N3Yf
	Ux1w1EJ2qYk2m4FbbpKN/Afe0zbJ1k=; b=Y4WnKWO8yHCrQTgDZYp3vfq8uULyc
	kYlN5DI83ravBzU4tR3onlUYbQDbG6oWKJaaFC1XqLC8QnCwONRnTp97IjGlX4J0
	7xH9zW35OthIGCcOdtQTQkD9UDMoG7j7TCmsbarb+nweBSVKS/iG7MoS+azhWYMi
	2KGOYwJNOgjWThyJbczESc+P+67TGJQB8NpQvelQldihqSBiWcxxTrZb9o6knOFX
	hGub60ZIdDe7V6gBz0cu7k8zqQDzVoAtN40b3IwdJJGjgumIN2tgZuzUMNw7bYE0
	0ZsCtMuDMe45flgtrZ6IXs2WGNSbPBOX1badQPsWgNQNSdSggWbqP0Vuw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hwarhr8mh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 04:21:56 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rywFdvqfYp06rVfzvmoBWf9d6ZR5Z1XSFKfHLuT508JoL8KfmKbeJTpkXg5hqi4AgKVNDPX9TLrV02uzE+R4+YvPkL95cFHlXi4rNIiFQChmpgTf1iTnXTtLj1hulwQcpkCGEV3IwdVS94maAaU/yD/NHX4P9iUC8Abo27NprKgzwUi+gQj/9tb4Mkm2aLy/Oq7Tu4OUYSlFCmZg3s7/qadkTstkmuUus3I7WFY88ltPrsnc+LU0a5r8rks/dNzD9k4xjdutum/+VBgOjoBRgHbo0iv2DNnK7Q8E3tlsOXGWBn6cCdd2sv+ArLbuYm7+Kr6RZwMB9YzCTvu1nEjafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FW3G3PY4N3YfUx1w1EJ2qYk2m4FbbpKN/Afe0zbJ1k=;
 b=gEb+OFp8TeRB04KDvETenXw22ShwpslAk1quRyZTnkmJrnrquOZVv0JDYNBCZAochML7lDk/9L/43HeJ8PJy7A+BDsrd84VIUIm7J2y4P1/sK5K9YvyvNCPFcY1bDfwikjYUSAw5/41lq/tA5amkTHWSk+7HYoqx+O0+VnAZJXVCDjdhH5T5wBt1nYmWSkWPAYc73OBYCfRYK5FlTyFlGHGwlMViusxcwvb8nsRHM/CD9RGvt3BefatsW16qXgy/oLf0Knen68+1YA7mXruG4E6F8pxwyGjFlywC9kbScxopGHU7jPSGNQ7KP5a1d0vXfX+53padgGyVrHyDXiotcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FW3G3PY4N3YfUx1w1EJ2qYk2m4FbbpKN/Afe0zbJ1k=;
 b=UPvaRF3E1dC3CFtrceWuySOZMq+hD3PmRG3GxUGUteAFlUn8+G3D15PR7vVS1vHP6cJIJxop5fa3rABHf0COO9EdZOhPUDP4fLcyCVOGFD4S8KDBZGEMj5mtMmpfZCgaadDUmZo78ia7CQc9eP9u+KmLcABKeRvgweUKBZ0phs8=
Received: from BN9PR03CA0515.namprd03.prod.outlook.com (2603:10b6:408:131::10)
 by LVUPR10MB997832.namprd10.prod.outlook.com (2603:10b6:408:3a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 10:21:53 +0000
Received: from BN3PEPF00022BDB.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::2c) by BN9PR03CA0515.outlook.office365.com
 (2603:10b6:408:131::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 10:21:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF00022BDB.mail.protection.outlook.com (10.167.248.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 10:21:53 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 04:21:45 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 04:21:45 -0600
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 12 Nov 2026 04:21:45 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ACALjHZ324290;
	Thu, 12 Nov 2026 04:21:45 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6ACALihi018491;
	Thu, 12 Nov 2026 04:21:44 -0600
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
Subject: [PATCH net v3 RESEND 0/3] Fix switch mode for offload and non-offload cases
Date: Thu, 12 Nov 2026 15:51:37 +0530
Message-ID: <20261112102140.2744508-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BDB:EE_|LVUPR10MB997832:EE_
X-MS-Office365-Filtering-Correlation-Id: e12ebb87-0815-40a7-115c-08df40a6c5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|36860700016|82310400026|921020|10067099003|261022075727099003|56012099006|261021121427099003|261021135927099003|261009223027099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261028144727099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	pMllZmc6iVpVEAjSdIPnCNl1dPCfgdeZtNpNJmxoN66dFy4oC5SMqB7Mlgs7zPYORIzFzdquxkLHstc3DpVg8TgIlhhcrY8xJHB5iGuJC8crf2vl7T7keNxxTPQsbIbKuBgiGJAR2SRGbObN6nj3Ysyf7rr2d1L0Y+1gMj/PJRN9R5Jttk5bHnfiWPuAf0BgRQxWdNFCVN2FIAxSyjFDBGmHfRl8arDsEdUWEH9qvFStNqCwMEzq8XgDhzx8eE4KDwjATgTniQCrSyCZPEWr2po8eYUs+6yKCySNiIYNMxI53Sj7UE5cV08Eos45gurK1us4dfzIoY8tGsW/utKwBswohedPhEw4ztAf5NLpj3yVPnW64hkReFqeVQDTK3ZKGHOsNdRLUG2YdQ8qzWEHYP7/dIzIaMYVYK0rbYpWEPQhyxz0XmLc0Sv6i9sBoKCeamUEP0Eh8O2wa+xb+OjopVUseOkpBWG3t2vxAR2/X+Sc6V/9T8uCiKLHA6icOGc80n8NdLCsEvByD78me0fZ2fmXItUoc58P+ERelpptS9NjtHnvBEK5XPEg5lEW9+rR0Ej4I9qBm0aLXoKqIWrmRQkZT0z890jtb1qFk3yHJ6cFJIUxNtr9MY3C9KFeCQH1IAiVMPMU7PA6Jbi8FM9Km1MxmbwnZ5lj/AZ6BHxoqJ6qu5mZSi3EpgUydhv6wPe29efzTeHQ6DzOw7i3aRk3iw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(36860700016)(82310400026)(921020)(10067099003)(261022075727099003)(56012099006)(261021121427099003)(261021135927099003)(261009223027099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261028144727099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uQHd1UCsDp1qmLDE7utimjRsdbEUTvo/ZDrI8fZRmrS/hMhalynmF5vN9dV8LWWkm0dklgtRaXxr/8nwDPkBRliFMFkpTOpbaDDVOrCNp18TwJYgsglu1CgU7cWxlvtOvSpn8lKqWLWSXbkI3PfNVnsud/WFupt24u2fRvaNocW71V+OV2k71YdkADhWU+Lym//cVCOSVBDxQMZ/2QAOsdEP7eKSSQoFgOaIhKw66c58Vf8Z9P3Z/1jcLBTwRw/TZAHieLekzMulcHErjhVMkRFOHefVylNaXZjWxerVlu7YslpzLkvrkL6rImcFGfn+sVewK1wW4ETjjrS/jylgLKrxeQ6PtPLgkCCFOKnzGfSlqHUteSBDJInd7p4h3AJ2Zs/uBKhrU6HKYTBqDbLICpoZi46AMHXVKKu+q8B3DKt8EZ/uRAC/C/+6WpmlWxK6
X-Exchange-RoutingPolicyChecked:
	c3HDQtFxhPi9qkFRHrl/S38kspqbmlKWHwem7xD4djRV2f24RTvtI5KEGgDQoolLh6+HO4+NsINehF/HeiO+5ALjMKaQMD42pbZ7UNDzqcqlFd0YQcFiHNKmttsTIpLQaZzvXswMH7AMxM+eOLbCMELOs+UllfgJokuLItUaOeP/7oRBCgyaIvTiWXCLcKTS7CQmF3dr+TRJVGjHTfX9MkNxAF6i7HrQR49nwLT6ZoFgDubB/GGtXuIppNM5Nwt9d37YP83IQq1KawRoDXxG+4uq/z8GRMywTHFxV2WDdZnBd7Qxx83meyMFL4PCSYLAwMGryNBksb9J7p+7iZD1Gw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:21:53.3863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12ebb87-0815-40a7-115c-08df40a6c5ad
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BDB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR10MB997832
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX+GDFnk05wyrQ
 apFYs31gmgdbASDAkqs59b+Nt7pEyaCZGVaEe33WMSuWsJmZASSnCkfMvhklOg+Hqsz0Sj5Oz92
 eKuHxPZmt3E5BbLVj7UPzjl6EISlKqs=
X-Proofpoint-GUID: AxRKEAQ0Eh93hbY-xGKoVrkCBekhpreS
X-Proofpoint-ORIG-GUID: AxRKEAQ0Eh93hbY-xGKoVrkCBekhpreS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX32p/JyPiCt7p
 +TUgg1ig0JgLIFMEWajK/sgkGRzttxRhSqrazM/g5Hq5ddiLguQytgzvwXqIp6aJsbFhxeiLesV
 J51JAGCs2feijDoj0m+O63jMvn+zi+DhzoUMfP0vV2MZ6bFgm4n6Ss83H3M4SA9FicYYRyhktkp
 xl4nBH5PIMAHBYdcBs1jyBxnhyAXn+UjYz97ClndJ/BRtxN8wd5r7QbHOJl/DvZu69qIkGaXfjC
 rJ+wBM9QF2Xmlu8Isf2USeZSx/RcIgzJ9lfUoKzdVNTKKlIU19BHmeGrgwCDlxbqF3S+FrGc0ht
 iwM4O3fGODfk89km7Hw2k/NmqfK9xFazhFZHf8aPMcuchaNN4LvMdP9ztLJmvCW2XjojX9KH9h0
 6eG59BIY3LHzAbav8kYNaE/1xaxjbBz5itMfK7OTomOwXZKs7s2sVCWmquCi34XuoJN/oloJsnP
 9cqmtSzKl9rcqPxSdNg==
X-Authority-Analysis: v=2.4 cv=Y4xtIReN c=1 sm=1 tr=0 ts=6af59344 cx=c_pps
 a=qId4hgiKfVM5Ptks7FQs9w==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=lO2JvOloaZY23zWVXcUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120040

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

