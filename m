Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793107123;
	b=WK/DwiWmbp6foyq1W6iTrwjfO6nS8Sc5droHuyJjJiiZVcDmAdujC/Kh8s+iK1gBeRb8
	 kmzRdpfWZhv9nE/AIM1H2lKQUPXEfFoywnhXoL04QXWm7AuIkQW1PjiC3ODEhQGSpywkD
	 HdCn/6ccqdAod9uB41rPu9CKgbO7ZQk+mw988F3Hmv+SN+OU/IY36EDS6VCDByH1Y13TC
	 lnAQpV37oDRIswRtiHGiK2nMYaumDxkvfflx8Qw6cWn5JLef5Q2f1D7y1gDpOH5ARH9cz
	 OHooYy3WgZWNVwFUwya+I97UwRFVYeh3RYCEKjA2T099SMOJGqiJWSHpUpwmG2UizDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107123;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6NPsb6HK/y/Yw8PH/cX7qwKCOxDIUHzKELdvwBy3rvo=;
	b=ph3MMDxs8/sobqNCryfsUlMerOZHGsjD/JQjHkmaSJQUZ3ou592VPz/Ix9OCWuSUi+3t
	 J24fPqEnm9v8PkFzwuCWHujOpo2Mg8IY5dT1HJd3N6/Mw5W9gP3aaMvGCGdXofbAIzxEJ
	 zdJmoaOVVB0E/nN+2wXY/I2746KjbgzypTrdGLqRuqkuRowIgWKZSd0TL5cH9h3UBMcGY
	 iwaeS949S/Cs9PM6nM+5Ov5TUPYNquTUXJAMM9zAi+u54k197hw1Xw1z5p3jOLotVT/+q
	 iRk0++NYN2SIeKeDZPnxG8gFrhFQwcBFii+b0Cs+NeVcleRAW7afNZVgMTfcyN7ZZ9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TbYQFvWO;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=f1FVhgdE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2A60A260E;
	Tue, 27 Oct 2026 13:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25B2A60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TbYQFvWO;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=f1FVhgdE
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69R9REYG748479;
	Tue, 27 Oct 2026 08:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=6NPsb6HK/y/Yw8PH/cX7qwKCOxDIUHzKELdvwBy3r
	vo=; b=TbYQFvWOAD3XuUhK17zQRiDuvGbqnr1l+DQfYjlgv04PYNj6wUlD/KKTP
	hPrcMe8KCh5M4LQKer4IJDi/vC+He3TnOw7mlHUPRaZqbarS8UeRmU6sEvgDrauN
	u1XUZmu77rPrRTlwn/UOAhe5fNv4pf8nPmrHS+XGNWV79DlUpXtagcn9/6cyGMsl
	+4++RugK8mZRXiPYqmNnak8sXNtry+GUPy8QkPV3pq6g/hMVHWB3otUiw4I5Lz29
	0qSDbjYM5AuSUgRxC7Rgs97G4BWF+rOQe34No/AUO9a2DWAU4aQ8hBELYMz/hTQQ
	YtrAlIVFagIp/Fpy5fEtkF/bnk1iQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hjsbb954e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 08:18:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhDUkLhkQZNQPcrKSVR7wwwDd8w1HHjr8v4RGJEc0jtbJM9QMltqWpwQVJnQnAyEfy5NPQ/C/O8KcIpXTy0wTKCNm3DkDbB0GktGB8hiKsq0CdvQ0aHKaeCAT+KeccJpHQ9wYNWnuWzNz0CjhuknrWKXzCHlEbqKm7IbNlloBGML+Z7W5BYH1bpDK0V5Nzs8GI6eMo17T+sP/AB6GaxwUgovgVKl9d18ALSxg2uPQlWjSNGjrCyHBuCjdxf/I0B81nFk8b3Gt1tHK2vaEHbew/wKtIQ1Ebkbo/xY1Zxu4p79sEG1yv0MkfzZ1SIJvFIEo2dJUFaHrR1OboyoV/JjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NPsb6HK/y/Yw8PH/cX7qwKCOxDIUHzKELdvwBy3rvo=;
 b=sqdZlPovw3WBbWDknOCQKxU62oY/oMS260zc3blkJpRiEPP6orcPxTqdO31bkD3YeKjxI2w5jqv4V5UfuJYx9OcDmBI2U6B3BfyaU7U076Omdn1VB3D4ZF/71opyI4zC1ZOEirBt997B/60PRgfNl8koLnQEAri3LhjD/W2Dt9TfL5U8eecF0k9bT2fo7WBSXgvkhh6wnIl37FhNmfRzCnm4zvUnhna1d4VA7gaLzTCPmF99I0mmhUcG28qIwrPEuFVnGnh0eFQ/pZvsH1nYH17tscs9NZ8fnyZ6G3bkj2rQv1kC+tbNpBZ972M2qBd00va3SW+0p06qJiHQQSJg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NPsb6HK/y/Yw8PH/cX7qwKCOxDIUHzKELdvwBy3rvo=;
 b=f1FVhgdERBgIsplhQIuKqoAuGmlrZV4yBBPFKpMmxHScmO/iTyZHAx1LaWxIpTHiKMbMHvyteysWQUGf4HuqCXwtSsMlkf6aPUhxwg9YnuEOlSt+O+SqNYAiPi836Me8uvWChxfa+eMgG5i6bRLKqBIRxEu7EMeA7Oyg96KBTjo=
Received: from BN9PR03CA0459.namprd03.prod.outlook.com (2603:10b6:408:139::14)
 by DS7PR10MB5133.namprd10.prod.outlook.com (2603:10b6:5:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Tue, 27 Oct
 2026 13:18:31 +0000
Received: from BN5PEPF0004698D.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::95) by BN9PR03CA0459.outlook.office365.com
 (2603:10b6:408:139::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 27 Oct 2026 13:18:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN5PEPF0004698D.mail.protection.outlook.com (10.167.245.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 13:18:29 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 08:17:40 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 08:17:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 27 Oct 2026 08:17:39 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69RDHdnB2921252;
	Tue, 27 Oct 2026 08:17:39 -0500
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 69RDHcTl020381;
	Tue, 27 Oct 2026 08:17:39 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <haokexin@gmail.com>, <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@kernel.org>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <danishanwar@ti.com>
Subject: [PATCH net v2 1/2] net: ti: icssg-prueth: Fix bridge port_vlan and flooding state
Date: Tue, 27 Oct 2026 18:47:31 +0530
Message-ID: <20261027131732.3411403-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027131732.3411403-1-m-malladi@ti.com>
References: <20261027131732.3411403-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698D:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: b4dc10a3-a38b-466a-3545-08df342cca8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|23010399003|82310400026|56012099006|261021121427099003|261022075727099003|261009223027099003|261021123027099003|261021135927099003|22082099003|18002099003|261026121527099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	9aSCu79tRDJcIHmanEljCpaB2wcyOwEn9q2eiIBnLv00OSIWHHPRbf/UgPtHm8WRsZNv43/kC0rvDc9m+4IsNmqbuEG+gt0HcgLbHrCaxVYjVewwub+FtosGjHiHDDCl1FXgcUbJ9AO93JrsY1h5qFLGhlrYpZmhZCFIpt7xMG+LlFn4SYG1ATpyhrg38dCiuE//RlnByHRY9B8BzewHyI9yFhAKnbbN9DSBF3iO9a9MaupbuUro9wGNS/jMWa3kl2BalDjIvj6KlZvoAW3/IEa1qOdNz0GYQ8+VOvWUuz+FKZoVE5uPghsBBFjmObacHoaXrdtJ1y2EmDhiB9PA7q2Mz4VrWlJU1/xfzlmuWrsBW8Ryu636R3NW7+vntUTqth4jZKMCKJhLc89lbXbCzTabjwQPp3dHwlkEgoqAER10ahDRr4SFraEbT0xIQjaSNMMNMXEqFWG1morLzpKfvLVUUBppbRsQAZwfbkX5thHOMoeYtJ28LMRpLHw1trR6d/y+fwJn7/41CDjVQl36Pns5SwADdCX3UjcV4pyHt5rmWExGuhFTK9z/AyYMfX4DEeHijkIecT1z2R3s/L4kLXB0T0EQ5ik7SOsD/uAQPIjF40Yu8r+r2cGFYQKRa76+vunRfPZXwVlYOa/8qyF1mdZ/LtCvlnauCxaBSHnIDTccGALsGwkttxcNsOUMfRbDFkk5OW45SDvNDmX++P2cyA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(261021121427099003)(261022075727099003)(261009223027099003)(261021123027099003)(261021135927099003)(22082099003)(18002099003)(261026121527099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mY8RcDPrRiHB0G3UAHf5+z9A/U7Sn0mB4qmFPxVBiwNs0zxTheUspan24JMMjuIaIoSZRDrTZdX7uQrNg/gYlor8BvrtqsCg0BGqsFlz1tJcwexVBNqXQFYR6LH8Nm7RYC5mYkrtaLeExWpLmFP7OM4NGDjGzhSWOSMxgBhLx8mMsnSx0k3AAMfet3GTTBmi0t6LJ29P2RnenKOkn46fLx27au8pPKRbkvP2TTawWQXeQDekP5Du8Pna7mENZEWz1OV0suDqhSMyISAKuiZGmgB14T7wBj9kdgdB/x+Tt+oInzhzP2DyhtI1zHocpTNS1zKpcsfKbGSKIByAyJCc0uTkt7EgtVtRhiRne1EuaxNLWRlLqWg6q5Em32dLaP6Nj5PlGdmTxyjIgDgNay2KditVtL+2XlPS3Jc/JfW/O5Wlc1NYI47lwRmdllJxyHOk
X-Exchange-RoutingPolicyChecked:
	sh61VU94gpT8Comwvk9zcFoKKdg7mH40jKsyCrXTDYPrroetikEldMxmcqpRr2BE9hdQ1Yh+DduLhsS2I5vnSqTDKCFkcWTTaXJXcVk7it1L0leBmswPsek/CANUtHm3txqtI27tqGGeoeIrYB62FSLyebta3II+A9qnE1ysBHS81fWgnlo3r1+S3QXe09lA/ylomfsNOE1mIJdeSn2uS6OCyWdvpoVSYRC0EJMTwk0obcmXI+ecFWhs3H885bju66QLQtXgvLntPJA+IXuggZN4/loqZ6WFO7xF8Trk3hC8vIYKWDoWiuJ4/ZoWOfcybUncT3g+7sRvai5nSAuWyA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:18:29.0032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dc10a3-a38b-466a-3545-08df342cca8a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
X-Proofpoint-ORIG-GUID: vqvm3utwVZ7LSNgvpvbCku8cM9bYl1BC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1MiBTYWx0ZWRfXxNQRvLiUD2y4
 SKVz6oxe6t7jwsHsqgjDTrM0NlpQEpnCVRFPjW38cyH6i0poKLXso+CgmHbY/VBvyzlaM4rj9bG
 19gJyPBJoyYl0uTIOXykMyi13G7cwxDtv2uvibOSe3bF2uD+K2cwKSu3wRQpUjqwYL03reFrlme
 k5qoEDsJjpzhyMDh2TsiVMPNcb//x5UJ4GpVFA4BRbg7q3be/9eBUvZTccZsOQ9mBWLr7odveHl
 aXNUyXf2giAaqACaNvpDuZp0nLeg+nJEPEm9IqZ+HnDn7kbnklM2L2ED20Lj2VqgATMGBDGj8xC
 1t+7dod2dM3WoAsANoOSShehL0rxorZSp5SDJLjN5d5lWgWtE3t/9oZG6ya9HNd75MeHcfq/ITq
 7XZGwJ3t+A0sLvRaQEZ+Q/y7xgmgF+Hj19ybWbGR/ZF4epHaUqE3FKo3b9txMOq8GFRLalA4t6E
 f2Phy1NntOjFU6fltKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1MiBTYWx0ZWRfX1nsRkVsADRxk
 U+SMM+Vjn/c5Tp6tFqJ3Rvw4uRxpsmnvwMEZGL3rqVyM9b35tB/3T2FOaNKnwkwhiU3IU/Zx0n1
 Q1mVAuFE4m0j1pUvhAlOu4IVtYhT3ho=
X-Proofpoint-GUID: vqvm3utwVZ7LSNgvpvbCku8cM9bYl1BC
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6ae0a4aa cx=c_pps
 a=pvbKGUK/Si0pumwNLfsG/w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=jQx7Hug-f_1R7k7IXZgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270052

Bridge formation only set port_vlan on the second emac, leaving the first
without VLAN configuration; fixed by setting port_vlan on both emacs.
Firmware restart in non-offload bridge mode cleared IFF_PROMISC-driven
UC/MC flooding state, breaking unicast forwarding; fixed by tracking
flooding state and restoring it after restart.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 20 +++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b..746afd5d00c9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -241,6 +241,16 @@ static void icssg_enable_fw_offload(struct prueth *prueth)
 					icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
 			}
 		}
+
+		/* Re-apply flooding state cleared by firmware restart.
+		 * Not needed in switch mode; FDB handles forwarding there.
+		 */
+		if (!prueth->is_switch_mode && netif_running(emac->ndev)) {
+			if (emac->uc_flooding_enabled)
+				icssg_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
+			if (emac->mc_flooding_enabled)
+				icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
+		}
 	}
 }
 
@@ -1288,14 +1298,21 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 	if (promisc) {
 		icssg_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
 		icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
+		emac->uc_flooding_enabled = true;
+		emac->mc_flooding_enabled = true;
 		return;
 	}
 
 	if (allmulti) {
 		icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
+		emac->mc_flooding_enabled = true;
+		emac->uc_flooding_enabled = false;
 		return;
 	}
 
+	emac->uc_flooding_enabled = false;
+	emac->mc_flooding_enabled = false;
+
 	if (emac->prueth->is_hsr_offload_mode) {
 		/* Track basic add/delete via callbacks */
 		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
@@ -1919,7 +1936,8 @@ static int prueth_netdevice_port_link(struct net_device *ndev,
 		    prueth->br_members & BIT(PRUETH_PORT_MII1)) {
 			prueth->is_switch_mode = true;
 			prueth->default_vlan = PRUETH_DFLT_VLAN_SW;
-			emac->port_vlan = prueth->default_vlan;
+			prueth->emac[PRUETH_MAC0]->port_vlan = prueth->default_vlan;
+			prueth->emac[PRUETH_MAC1]->port_vlan = prueth->default_vlan;
 			icssg_change_mode(prueth);
 		}
 	}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index df93d15c5b78..832e654a102c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -242,6 +242,10 @@ struct prueth_emac {
 	bool offload_fwd_mark;
 	int port_vlan;
 
+	/* UC/MC flooding state - preserved across firmware restarts */
+	unsigned int uc_flooding_enabled : 1;
+	unsigned int mc_flooding_enabled : 1;
+
 	struct delayed_work stats_work;
 	u64 stats[ICSSG_NUM_MIIG_STATS];
 	u64 pa_stats[ICSSG_NUM_PA_STATS];
-- 
2.43.0

