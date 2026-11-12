Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794478977;
	b=db0KlGeKr5XRPH+WoyLQEJx99Z4VIjB8y1vJ+AWTj91HxgMDkOBtLaNqaLGiMFJlYopn
	 idaES/P6GbGxCnVHuH/mvxDeQZ66+6m+tf6Jmyv2GM7/hsyegDcW2NvzVfZgN02aIsurh
	 X10ELfCVr9P5iJZvtPxIUd9mV7j+9RrwSZJs2yEHqszr+WbDpAVSfzzpL29GOWYB6zdoA
	 yA7LTs3pOjpGT/rftzPmrZYXUddJbHtIqdOhqP18adOW09+SQ9G7vboOhP2PKelEEMJqU
	 qWNC80+GW3nixbflUuMLApEyHUsLYr01fYz+RC0OtRFhVmLf1EUXiWe3f7xh35LgYVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478977;
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
	bh=K27BhB8uGOEHKSkOqtpvPMCYWkD0jG2bT05td2J/JuU=;
	b=4I7Z2mTcE9YoMiZJZE69j0MEw8QUjwras7B5XFVtXZtIP9ophursQC+Y3FZfkGpOkC0V
	 2ivcBc+FUNRdZS0elKftoqX15DSskrmVDT2zhr2GhsT18oNiq49Pm5CtVntO4siQPyVcP
	 VniHjRI0lzVIxh+rKoVB5eShpHNE7icTHGrGHcCQd5ysm8CHfNidqm89JfqI6c0n6V9Gf
	 WTP4WQ4OyCT4Zv6StCBDB2fHWHzAcZ7fvXMME0Lw0hSeYSuww+GcTkCBPWyLPEBjmwn56
	 pI8+nxz5URKjAxQsEu7JEVC7GtQJoQG11TTsMMRMGLiTQXmmPTKftPuqMG8CoVNfomw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=c6Dy42yv;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Z52h1Vtl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DAA606A890;
	Thu, 12 Nov 2026 10:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5DAA606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=c6Dy42yv;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Z52h1Vtl
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC7gu0X2308431;
	Thu, 12 Nov 2026 04:22:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=K27BhB8uGOEHKSkOqtpvPMCYWkD0jG2bT05td2J/J
	uU=; b=c6Dy42yv/zdFUlaQTsXhA3iE0XReNt9tnuPasyIg/Ygxja4TOq1helsjA
	bl2y/rEv+lBZv7kAk0c3jWG9PXkyddIgs9CvPzcU2woux3WEi+I3Tpac+PFJO9sq
	pjtldH5fr5EcP4t1zjca4GqLcpziAWCbkT8cb4pDavRadCXbu+Hl/RZZDk9TYVlz
	dowrAKCjqT4hpsmJcO0ISxLzjMFrMIzclTktwAvXKoOnFg92a0Pwoif+Id8aSQ8a
	EXOvYoV1WgmFmKFg+wP5WU7JVqNh7Etj3UPek0Rnwnnhh/oizjhz4frVlnNLYCcy
	iCRNqXRLDrcVsdeq+fJCoQ80Z5YUQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hvvr6w3e1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 04:22:36 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiYr0p0KaZdNYcfxSuOH6cqDy3Lld7APzi+86DSlRAH6EGyWwDLZ3x4pWkLb/nJ7Lm9ng0yY3glrmiV1Spu3NQ8FchZs5HcjlTK83kyC+n1X2VdyF4HOrqjN+6LEThit2l9JDa0bpd/rsUcCD4MBEPhuPzR4ZXDEXTa4nYvfM0tQp4CvOey/PKKE5ILMaPGx51HmJ5Ojm9uOZE7hb4aE7P3d3UAla/ds4nWNko/2hZcr9s4q+Q/hK/sFKHeF54ojqD4EjoBA8xLwPOKEK5N40ewKeZE3bIQe/8h94y20ZuNnjXWCUXq23fSDnINO411hYn0qPYZ3saGb69u+NGHGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K27BhB8uGOEHKSkOqtpvPMCYWkD0jG2bT05td2J/JuU=;
 b=Xj3FEQLk2pilC5+QTkhKR8yWh+ny3u4OB28mWBtCZApC6xh3JD/7samU4sJqv+qCbvQi+FuuJCbmGDhfeY0nmV7uUXBRnT/NTML0jygbAPnrefbEwPAnhQhUkE9t5qI3uqktY7pPN9x5PAfWTDV6Zck2tGkGZE3Dedff3QmHt2IB9D0HNjsGJm3MkQTNmuQcqAE3IZd4lL9USy0Ov3irv77/6FqIH8wrV9i2jThsU7hibeBLRhnyjyGzIC7/EjYPYNCUok/QFlT8sNPl1fusRtCx0UpDrX2S5lzQ4V5q/RJTvZU4cN0KcBh6NEDvdgAzZLTvOvMqwLraE9iJcki6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K27BhB8uGOEHKSkOqtpvPMCYWkD0jG2bT05td2J/JuU=;
 b=Z52h1Vtl0pLozMjsqoxLfm7RG4wICbfl7/3CN2M4sdGY/JMPbOrpd519ZsQlk1IgFMhq3FblUHJJS/lEzcKamZz7EcVHj3Yo5oaUbY/C6L6DAY/wAx51ZxVWlpgvilsXL8Ea6p4eRvDBeDcsMg+by1928GsH4yHjxXSxNRqQ7sQ=
Received: from CH0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:610:e6::34)
 by DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Thu, 12 Nov 2026 10:22:30 +0000
Received: from CH2PEPF000166C6.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::6a) by CH0PR03CA0299.outlook.office365.com
 (2603:10b6:610:e6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 10:22:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF000166C6.mail.protection.outlook.com (10.167.244.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 10:22:28 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 04:21:55 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 04:21:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 12 Nov 2026 04:21:54 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ACALsD41656003;
	Thu, 12 Nov 2026 04:21:54 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6ACALrZv018526;
	Thu, 12 Nov 2026 04:21:54 -0600
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
Subject: [PATCH net v3 RESEND 3/3] net: ti: icssg-prueth: Fix bridge port_vlan and flooding state
Date: Thu, 12 Nov 2026 15:51:40 +0530
Message-ID: <20261112102140.2744508-4-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C6:EE_|DS0PR10MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf390f6-438a-4163-a6ee-08df40a6dadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|23010399003|56012099006|921020|22082099003|18002099003|6133799003|10067099003|261009223027099003|3023799007|261026140227099003|261022075727099003|261022105027099003|261021123027099003|261021135927099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	XdJSNgoyMxbQAU5D8d6T1S9pVTEX/V4b3OZvz9hklf+G/em0abvhJfFC3s/dJz+Pp+xhcQU9KdumuznmokyKQ6m87cM/qoypGzvZRsrUT+YYP4PNS++7uYFgTs9f+aT49cRR7wNG0NiSmM9hbvIEa2LoafwCZ9OezQxtoO6GhDdM/Nvi+dSjp6DF6VkY8+l2Lt8xFHzUUwvVApKyFiBp79e17QCfeymvC5bT4rSyOj8e9zaDfux+OhAUQQMtMKOnh2+PenwwhQ8mPdEBg1oLZ2lyLq+YK5GnQ/1H352Aw8tH98VCQwhT/Hqhq6HVAFHsNeGFCvBvuTd5OrbeC4GKmnQ7vfAyshbdx3EyG4+3a2/AFI9xnq+AaeHNxR74GvzBiE/mDFP/3Jsav87hX6iNcQNFNrDbmu3mParL3c4XNoHXoJbfCClTiBFi0qaGGNCoKd2Rr35mzLHN9n0TLwt7I+K7CZaZJtuhxr+FsdKM4V/TfVelHrt79fLIx3O8QczV2SiONviJvfKWpg6VDUe3oT1M2QD0yMbCBxs5sEVYvQMUyJox+MTdDs8UmcM4PMlEptFVVPJ3lplKxzlW2GMzHaTSpd86jkZVs9qzhZRmvAnnsMkq6R2DiPyB64hiv7BtPPhur7u9rK49neJN5I++AeiwMpnoz5hgAyx2lN7gR0tY0qngh4/0dxUflQ89EjLOIsrPXhUW1Z14hu+1ALFIuPrVGmRtUQ2GdRIgZ82Iiqe88nlfjSQHhE/+CKUNFYuU
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(23010399003)(56012099006)(921020)(22082099003)(18002099003)(6133799003)(10067099003)(261009223027099003)(3023799007)(261026140227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021135927099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VmAp0a/DJTD4bPPxUDEmomQaR34ju00fuIyl70l2O9tjXpsUiY6xlbD506yCizj8pdRyoSacp3qEcx0sZ/RA9j7h9g6EEUnb97Nht0NGl2i3iRv7mRgJl2+hKdxlkPfF0PgjHaSycxH35TrO4yc1QNLsB/G5zGjuOPW5fPufMs6v0Jx/gLc6WgzDB/FbHZd7R5padr+nYCz3XI+5Gx6rgX0+Ago0qzZquzzltSvg1Qd+EaIK2w1KQDiHciRGqm7zriblgyLlW91L8+ZeSLjmoULR+KESr0QuwTj24arzD4iOrUGUd/ZAkjK5qMB6tgK7c8/nj2g9xja7vccxf/TV4XKM3hFB4vsVcpAagf7DB2teGb/QZTNulsstK9raEbHISRt72PEy6f4h2SJBXSvZsk3w/E3PeAQM+Zfdp5q00jbY7eeEGDShg2iHScWddWVS
X-Exchange-RoutingPolicyChecked:
	WT31IbcYBS8PWbFgQMgigMJ0LsipL0nBwRzw1/OrEgklI5qKerJKsDaNZ0D8sO91/5MGICx7mozxNsPQlzszywbXQ3Pv9ccK78B+li3N58CMAAQrb/szKuNUeI76WqXRBhPelfVJ+ACyuKi2q42aNALGNLbqrI/YSM/5rqY9DPZmshVtFhRmibbNjubg7NrsQxnil1DXa2roPkn/3lAWs9LxO7OQYGmjpJfo6CDfpfcg0oEH0ER8vaHa/a/bQ2kBpk8QCYXtaK0mCVX/0ugSxE5/owYeDOUxHgr6Ki0udLcW078X/yh9CZG+l5GS51UAgkKSc6B4nDO32pyeNAVRJg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:22:28.9593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf390f6-438a-4163-a6ee-08df40a6dadb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6078
X-Proofpoint-ORIG-GUID: eowFtW_G4BibHhWycwnAyDCt9cZjvbKS
X-Proofpoint-GUID: eowFtW_G4BibHhWycwnAyDCt9cZjvbKS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MSBTYWx0ZWRfX5Ll4ps9fE80l
 o6syDgY53fix7Ppmx+6lcfBpTF0cZbJ/61zDiGdxpH1saQ6FrkjoUcObVYpj0MFDktsytsme4ix
 Mtv8BilPX/iV+97h5NFV9/1UUbaI6zT0PVfNh6oHe413d8f201NnogLqrnO6VyTfavG3S8g2SkI
 mVoYS3/ihu7Z/FheX4rqy4AFIZaYxKTUocL3nARLaU5hS56FCykwN61cLDZziI5Q0bUU1AQyzni
 4ztFoIJ8RKCrSaFHhuLFwzzeahQtpL/auZBIeVEILOWtVT8QTbyT1YpGft+qNSGLWdhItKi9PcO
 V/wj6S/f74KcGAFoPg2Nc+mY1e/rBjOPgXFFjxLAhf/19jOKe0bxWHPWHwoLc03qeR1Z8TVGa1M
 zwbgMYPEIDKNKYhwomRAnVtt9YFVqurv8rN2RJLtVrEj0lOAFLhphSROJh0Y4hEWNt9RNWCD0Dn
 wYnHm9DVeo441I0zF6A==
X-Authority-Analysis: v=2.4 cv=MpLHeGae c=1 sm=1 tr=0 ts=6af5936c cx=c_pps
 a=mkiEHwHV8KLcq3bIK/dapQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=W48xRondKBpYVHpv39cA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MSBTYWx0ZWRfX+7SjTjI8hJkK
 ubZ7xRhOHUN+RxckeP9ZbAoQsAo63BvWF/xX1gRt1pRxohF+0IK812h3J8kcfqSylpEoDpDJaJv
 Xgs37zTT58Me0lXEGizk3yvihvEWo9w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120041

Bridge formation only set port_vlan on the second emac, leaving the first
without VLAN configuration; fixed by setting port_vlan on both emacs.

Firmware restart in non-offload bridge mode cleared IFF_PROMISC-driven
UC/MC flooding state, breaking unicast forwarding; fixed by tracking
flooding state and restoring it after every firmware restart, including
the switch-to-EMAC and HSR-to-EMAC transitions in
prueth_netdevice_port_unlink() and prueth_hsr_port_unlink().

Store the flood-enable flags before issuing the firmware commands so that
a concurrent icssg_enable_fw_offload() call cannot read a stale false
value if it runs between the command and the flag update.

Add a NULL check for emac slots in icssg_enable_fw_offload() to handle
single-port DT configurations where one prueth->emac[] slot is unused.

Fixes: 161087db66d6b ("net: ti: icssg-prueth: Add Support for Multicast filtering with VLAN in HSR mode")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

Changes from v2(v3-v2):
- Fixed race: uc/mc_flooding_enabled flags set BEFORE firmware commands
- Added icssg_enable_fw_offload() after restart in bridge unlink path
- Added icssg_enable_fw_offload() after restart in HSR unlink path

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 25 +++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  4 ++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index ef5dce595f68..48539460ee49 100644
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
@@ -241,6 +243,17 @@ static void icssg_enable_fw_offload(struct prueth *prueth)
 					icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
 			}
 		}
+
+		/* Re-apply flooding state cleared by firmware restart.
+		 * In switch mode, flooding is managed by the bridge via
+		 * switchdev callbacks, not tracked by these flags.
+		 */
+		if (!prueth->is_switch_mode && netif_running(emac->ndev)) {
+			if (emac->uc_flooding_enabled)
+				icssg_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
+			if (emac->mc_flooding_enabled)
+				icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
+		}
 	}
 }
 
@@ -1286,16 +1299,23 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 	icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_DISABLE);
 
 	if (promisc) {
+		emac->uc_flooding_enabled = true;
+		emac->mc_flooding_enabled = true;
 		icssg_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
 		icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
 		return;
 	}
 
 	if (allmulti) {
+		emac->mc_flooding_enabled = true;
+		emac->uc_flooding_enabled = false;
 		icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
 		return;
 	}
 
+	emac->uc_flooding_enabled = false;
+	emac->mc_flooding_enabled = false;
+
 	if (emac->prueth->is_hsr_offload_mode) {
 		/* Track basic add/delete via callbacks */
 		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
@@ -1934,7 +1954,8 @@ static int prueth_netdevice_port_link(struct net_device *ndev,
 		    prueth->br_members & BIT(PRUETH_PORT_MII1)) {
 			prueth->is_switch_mode = true;
 			prueth->default_vlan = PRUETH_DFLT_VLAN_SW;
-			emac->port_vlan = prueth->default_vlan;
+			prueth->emac[PRUETH_MAC0]->port_vlan = prueth->default_vlan;
+			prueth->emac[PRUETH_MAC1]->port_vlan = prueth->default_vlan;
 			icssg_change_mode(prueth);
 		}
 	}
@@ -1960,6 +1981,7 @@ static void prueth_netdevice_port_unlink(struct net_device *ndev)
 			dev_err(prueth->dev, "Failed to restart the firmwares, aborting the process");
 			return;
 		}
+		icssg_enable_fw_offload(prueth);
 	}
 
 	prueth_offload_fwd_mark_update(prueth);
@@ -2024,6 +2046,7 @@ static void prueth_hsr_port_unlink(struct net_device *ndev)
 			dev_err(prueth->dev, "Failed to restart the firmwares, aborting the process");
 			return;
 		}
+		icssg_enable_fw_offload(prueth);
 		netdev_dbg(ndev, "Disabling HSR Offload mode\n");
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

