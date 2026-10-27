Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793107132;
	b=ze6WnV1Gzg/dRvlmj0xjXR5A1/tzEfDg5h5L89F5AdTuip8mfMBDQWmxQI/y4lLdpDqq
	 v3qTzJE+cHtC8gx/yVH4tsKapvyJehzgstlIRyquANqi1fy9wXfLPdOfmdcv1Lqtgrlnk
	 3Ex59hVIoONgu+tPCakK4KZv7ryqdTJGPJ3w2cI+tyQSLJUsuNOV9w3/c/YjoNzS2PmUp
	 S7xyicktwN7xlUY4Takw/7CI40CavP4CgREM8vGqNo/OJhLlbWTNOorN+bPXJ6XW14Zpf
	 HlwZtez9plZh8psp/23RylDePhUn5KfQi296bcPjt0GU03NxGzliFhaFqpWUifyE9fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107132;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ueHAQQ8aNMv3KtdmLcWKE1xkEdD2VKcoDfPMnQP5vO4=;
	b=igGlE/ko2wmO/IuVKBcsROE0TuEHqHG6+3Gi/qro13zkUJq5bM5jjm+nFaUICdamvyqC
	 xHym8FMh8A12/oYZRlZzlz0Uio5N8ijYZHizDCCaRksks+Nfeh+xV23yE2pU3OzrUPJp8
	 RZJWnFkKNo349nJ1b4XRBKJtFhU1cMrKMMvsqTlQCMQjh0uFFH2Cu1jVOzpz9kOl4qcQV
	 rSnR2GmO4njUuOWaQjinZ9nCTxLznGCrEwUmcy/M2zb3bcOVlYkpDOc0Eiv3GQIw3agpH
	 xY3iWQDkC6nPa5fAn2cwgVZxhGWwysfuiegXML1GJIbisGeZkzmWe1V5fuY51n0LXyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=pTxfjhQb;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=D2tIsKsH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8A606A32C;
	Tue, 27 Oct 2026 13:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C8A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=pTxfjhQb;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=D2tIsKsH
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R95fWM485509;
	Tue, 27 Oct 2026 08:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ueHAQQ8aNMv3KtdmLcWKE1xkEdD2VKcoDfPMnQP5v
	O4=; b=pTxfjhQbgybYCBF1gEZzN+mDIl3LtOnR5Qcste3sNmsQ1wfYNrqzQvgdm
	HNqtZAVa0qOLH++NS7GFQfxPGnabuGGGX8sji/AqU0ssGeFvbNMoydzmK/butdPn
	EzcAVGTnbWRsS+rWNP+DmZOGS2NNcFb9Q89i9qVD986ghylLWI/gN3ACThzBQz+0
	rE3WBzw7FtsE0Op+ktLQpp1FiCSkWg7SBz924KKG5OqqVLM/hwzE38DCVO8lPkEk
	tk47MuULiagxnBGcR+5Ybv5OOFT0/HMyTEWYiE3xs+BFliZQEGy1bMPRO2jpH0tN
	BLyn6LW7jFO/05uSpFcNy5gYuLIRg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hjp2yjesy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 08:18:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=howYitUUDnNoXJlPsfytiOfrmvS5aOBDk+n04r3ZJanPw817x7TwgzgHDQgNW8x8vUTwRenJoQGXAbNRKjsZ3Djy7bWfHZ9JXmVcgWiXz/3dVoyK1v7HckEz8BTF//YhyaTl0SI9Yq2acyopeJAEdhRINzgg120m/fO+Eqp1EtlUoOYSZ+MGVRVpzkltM8+lDVJ6ZpbU9C9eNkfitlhTK2kgE7zzPMT1O5Vd2jm3+CkixOQoTeUNVXwvu1YbP9VzBiXtseFWJ5gFzdypR4LL8YMtbSCKqUkP1+3JZ95mWPRcH1MrWHGT3YicUJuBDJ2stQ77PwTgcLHmNq/kIRObig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueHAQQ8aNMv3KtdmLcWKE1xkEdD2VKcoDfPMnQP5vO4=;
 b=QHcAxph4qn/AI8Lf2bDso1znrsxS31rT+OpXEqg+9dEh7eqaYG2vZNby/cV+mSlqL62nfWTAAgDdZrW2rRHEut8zvZ4UO/x40HyPLSu+FCRgyVYoZdGJL9/4hPq3eWMhLrFBrIrHQVV+oI0AT9hRKDTpoWM9JXvc0ciwH8chO6LYVv1ryz407Q8F/WXbtnLHo8iopy9OMIyj5IVuHcaOmBXAKJhUSVR5b586fJf1FxoS6vrlYJ/EUj8OfbIVvIkbIjK0PRipdAQSL1WPB8m5dkocWVJ+VtqLepq8Cr80EW6/kdf79klVVKS06wv2PaFp3klWhT2duKtgqaoWKacpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueHAQQ8aNMv3KtdmLcWKE1xkEdD2VKcoDfPMnQP5vO4=;
 b=D2tIsKsHXXChmNIteV1yKs+gWVDLYOVGz4Asb3GM4r/sTR98dLHg0GK7oEaxeRo//UWTskgnz9ynHoDBQuYmSc/XLGMBHWH6ECWo2IbyWAuHYaRSaoWzcPPGu0JTCx9rb+ZLBrI0GJU1e58Llr1TnH8AcYvCuNFazoQo7LTplIs=
Received: from BN9PR03CA0266.namprd03.prod.outlook.com (2603:10b6:408:ff::31)
 by PH0PR10MB7079.namprd10.prod.outlook.com (2603:10b6:510:28a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:18:36 +0000
Received: from BN7PEPF000000A7.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::97) by BN9PR03CA0266.outlook.office365.com
 (2603:10b6:408:ff::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.20 via Frontend Transport; Tue,
 27 Oct 2026 13:18:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN7PEPF000000A7.mail.protection.outlook.com (10.167.245.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 13:18:34 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 08:17:43 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 08:17:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 27 Oct 2026 08:17:43 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69RDHhD32921320;
	Tue, 27 Oct 2026 08:17:43 -0500
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 69RDHfZf020391;
	Tue, 27 Oct 2026 08:17:42 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <haokexin@gmail.com>, <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@kernel.org>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <danishanwar@ti.com>
Subject: [PATCH net v2 2/2] net: ti: icssg-prueth: Fix R30 command timing and NULL emac dereference
Date: Tue, 27 Oct 2026 18:47:32 +0530
Message-ID: <20261027131732.3411403-3-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A7:EE_|PH0PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2a873e-3d20-45f3-948d-08df342ccdbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|36860700016|82310400026|261026140227099003|261021121427099003|56012099006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|22082099003|18002099003|261026121527099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	d/s9yzyardf2Dra0hVd8THQ4BCGVfmoI+tB3ErGKdFte5eXM+V5UFZY/X2SevNLyjqXR3uvDbqrsYbWwSbjnX9hzfgzKOBoixvCPQu59v2vEJU1NVCahih8evnZnfSK+dN7kb/pZ5H6+AVXRKKOwGJ2f4GKKoK1BrEXZ5Laz/8DT6N9VyWuDFsDBCj1MoxOA+njWNHT2bgkXf/jgfsvLgEPGb9/GP8gBEkoNuUv0vOexl3VDUYT3ezCA2EJlHHiRS3yP3qOI3aqtTbFdHs/KE3uAXZp+68FMZ93+KbRRidVNGWy+7lzOygrGIbI0t5H7Fu8B8Q8Hz3MfSavwiexXEf8s9rNMbe9x8X/C1TNGkK31QFVPDPIPPEpEgy4SrrbzRYQidx38GZB+6jFIvoFU9YC/7gCxo2dIOSZcO+OrjKJIpTbeV+UCoUNWDxCKmJzhD2g47pKe4gNXB7yM6yCFhN3CjIufb29y113dowcxfsKXJ0r6DKWN3mtAMwIKA8PXhOe8toNby62u1pkExibOowrtXIvTGC9sZzBTuyLa17cjeqNSLnrdkEIq/T4PEgrXKlSIwqPup4sTjIS+xg7+Napv3dXkvrWlzPV8DxIZXt+6IVrlbS8s5KN6mLC+4lwqoHOUPL7H1fRjZ1MxQwIYbMQ3HmbxZIKjCeDkmmwMik+K+/2ekhuL32j8lw/gYQA+ew9PJKz504hbHyUgT+9kfA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261026140227099003)(261021121427099003)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(22082099003)(18002099003)(261026121527099003)(6133799003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uuoj8P3/6JkpWqb1S3VbKYwKnUle+tx0NTpgZ8bG1/6M+uvqwn3JRL9eVeuo47Vi0dlNaJUpcvaxRDX8/BCB3+R6omP46rE0iW3ZENfw/q3ib7yPx6oDUq9EiFlN5wNGveE/4bflcOMRrj4mS0pei+8RMM1Q0gotnc5AOeg2ODIE+QNVgm2aZ3AHOCK8QZ8Beymz6EUcwsfofl09Yi3rzE9ypooKidd3EzEizmdhNaMB+a3KCLazKuT5jjszq2NSSe2uJFUfKF9A+km6R3iSEYYjsNae6DU2aXkmBOLczQsMSZkrPG3I7nkG//CX20koUun5BI9CtXgbrnCMJiDN5abQcOEpcZLqBpiwbZF3+79oJfYC/0aWOEG0Uf/ECrrvod0jg/ZHE1vlMoy97utuXzFyLfVkfaOkldwPXeVS2SSDPy46mFOBT/2FBAOrirWH
X-Exchange-RoutingPolicyChecked:
	Xbbdtnh2lDsfaesXJoVskXInc/o0jAJ2q9FzVdzowk6JJE/6tJ5OuBOvo6xgspPaD5PrgIcKYJ58FDMgXfsAN4onSdw/+jcBisOGpOscDHh0ML9OYqtTSIUJSXA+LSAX/CVbkabNJmTICiHdcWBc0+JP841Y4Tv8sidu50cty5vglNsHvRUDxbFzIgudJd+kA+v33MRb00m8V4Bg+WjURVuQdc5F9UOHS2R9wsdU3JkQMcP0otGyy7ekgvURZYWiNwXFtBFTaskDPiiNZ+F2fByPoKyhYEz/1fpooUrjxAGFsyaCGmF7keD+suE/Vi/026zkzM1KRCCuX6NhtU+8lw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:18:34.3667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2a873e-3d20-45f3-948d-08df342ccdbd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7079
X-Proofpoint-ORIG-GUID: YLTOcxbQYeRo4mxcucZKdPUeqS4qpaXA
X-Proofpoint-GUID: YLTOcxbQYeRo4mxcucZKdPUeqS4qpaXA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1MiBTYWx0ZWRfX0Dc7aAvYuZA/
 bjp4A1KfqK071a9NpSlJq9vcN42GBNdLNCd1U/o/hzwi3pdy/n7tSMVjnCDu0dEshfcc6B8LKOT
 R/mFyQGaTj0xgNnj0RdQK1e4c6XuOF/iCYCFd/HJOFX51E+GkFZr2PhNtwwgYOGXLIcXNQoPpvn
 Mg1Vkb9USOwTIATr38JQsFCoWhVM286UCSAGAkkC4kmjZaAPznBLlMBj+8xmtajwCDQD10CUw49
 ffHNZcHbm1rlr6UquNm4QqQsLOMRG3kDzYo+Ybavr6Th7iqi7IuMi0WS4Af0+aLWuAE+v+cf0Qo
 J2fMVD1I9Z/8mjhUqrmA2gJL+PWBlv5xI1bq9BTxB3xYG7aOeQLEHU47H93VBLoJYOf398uUDSz
 RhOMqSkHfxXILkLND8oMokDHke41IYq59Kj/uNv7Whqym89XkSJmS+HAG7UEulMTp1ObYftVCXK
 GCpnYwmvO8omruhNtyQ==
X-Authority-Analysis: v=2.4 cv=FbaiV5+6 c=1 sm=1 tr=0 ts=6ae0a4b1 cx=c_pps
 a=rpDl8c4QES63uqz6MGSAyg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=vszCMKIuiFNvG7wiJGkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1MiBTYWx0ZWRfX4f9iofomivbx
 KqrzNxf/qyOM3gdCVFYbrZ+e8Wzw03rpkPPxu0H31cgqwWCXyNXlnj6e0yI9gByrplQQPX5m9Xd
 gBsv5uj5P6SJXyqLfOFUTYaERz6UqTg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270052

emac_adjust_link() called before prueth_emac_start() caused R30 FORWARD
commands to time out (PRU not running), leaving stale R30 values that made
prueth_emac_restart() fail; fixed by deferring adjust_link until after PRU
starts. icssg_enable_fw_offload() dereferences a NULL second emac slot when
the first port opens before the second is initialized; fixed by checking
emac existence before accessing.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 27 ++++++++++++--------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 746afd5d00c9..9afda5da3ca3 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -213,6 +213,8 @@ static void icssg_enable_fw_offload(struct prueth *prueth)
 
 	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
 		emac = prueth->emac[mac];
+		if (!emac)
+			continue;
 		if (prueth->is_hsr_offload_mode) {
 			if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
 				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
@@ -288,13 +290,22 @@ static int prueth_emac_common_start(struct prueth *prueth)
 		ret = icssg_config(prueth, emac, slice);
 		if (ret)
 			goto disable_class;
+	}
+
+	ret = prueth_emac_start(prueth);
+	if (ret)
+		goto disable_class;
+
+	/* Reset link state and reconfigure after firmware is running.
+	 * Must be done after prueth_emac_start() so that R30 commands
+	 * (e.g. ICSSG_EMAC_PORT_FORWARD from emac_adjust_link) reach
+	 * the PRU firmware instead of timing out with stale R30 values.
+	 */
+	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
+		emac = prueth->emac[slice];
+		if (!emac)
+			continue;
 
-		/* Reset link state to force reconfiguration in
-		 * emac_adjust_link(). Without this, if the link was already up
-		 * before restart, emac_adjust_link() won't detect any state
-		 * change and will skip critical configuration like writing
-		 * speed to firmware.
-		 */
 		emac->link = 0;
 
 		mutex_lock(&emac->ndev->phydev->lock);
@@ -302,10 +313,6 @@ static int prueth_emac_common_start(struct prueth *prueth)
 		mutex_unlock(&emac->ndev->phydev->lock);
 	}
 
-	ret = prueth_emac_start(prueth);
-	if (ret)
-		goto disable_class;
-
 	emac = prueth->emac[ICSS_SLICE0] ? prueth->emac[ICSS_SLICE0] :
 	       prueth->emac[ICSS_SLICE1];
 	ret = icss_iep_init(emac->iep, &prueth_iep_clockops,
-- 
2.43.0

