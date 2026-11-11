Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794392394;
	b=K19cRUZ0+EjdceABKtfGiESfyZMJ/p06soLaO+hfEd2/qxBLkKT72nntUWHs6UX2a5wN
	 ebx0GXDm0KwiC4L1mXBiD8g7dkciw0YLMZFWuWPwJwcvKxYlZ4cxOjlmf+wSOmkPnStVi
	 pq6ozZL9rc0UrjajCf4p7gc6QbV6QBNNfV0X/jEjhYRZe4LSyqUJFG2dgNqcxnctuiiUb
	 PLOqpxr1Ows4o8bP1bG9Kh53UltCbnKLe4XaKLgKrUde9joYT4ohf6pXEcvDK6xlL+Oy4
	 xoJeIlxzNeA7WOhqR3VzUwPTEBRz6VRPh/NU3yHcrux5gCYhkA7P575BVyAnC7U/YpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392394;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XeGp0nh1DicYVVhS4sZY9ZDmPeZ5HCOC2hGt6GdeQdw=;
	b=LCyp5pqPiFI/4dmc6aL2EK9McDwSrn2JWwLGczNP9jZ+akUeo05AH4QkeGhKaEWrotWv
	 waOJKWJsme6Cjb0f9e2xWYJW3nZWjVs+X7a814iXByFmQWM+v5N6JGCK1NTvHd++KJk25
	 F/RdKzuBK4XcwkKMGYVMEIwnUsmUSZKCserU377LDe4sE2kG6JC6ksGtANKYVW5tnTZLt
	 cJdb1gUWiyHISHTEVctn+rECMl9AjfGrmnSZPLchUUn/dBZRiYKZcw3htX+xtM71mriFM
	 kD68JeKnZysL4HlCqEJXjQswZx1xWEC8SmQU6MJ+RawE0VW65cW+vJOK0fLdRTVGwQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cn.bosch.com;
	spf=pass smtp.mailfrom=cn.bosch.com;
	dkim=pass header.d=cn.bosch.com header.i=@cn.bosch.com header.a=rsa-sha256 header.s=selector2 header.b="U/HZYvm+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.38
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B210606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B210606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cn.bosch.com header.i=@cn.bosch.com header.a=rsa-sha256 header.s=selector2 header.b=U/HZYvm+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhypXA4cVB5Cydt4MdWN2OWTcSixbd/zunjKfHVoBi/90obv5LszRQ18xrwvMaiqtwOMxVSkfWvqQG4Az6CRVRBiLmRExVLeYG9S4kR9FqN0GAweyXogwjHIwTZBR/rpkUgNaSWH0xZBeTnx/oZIbV6UqQV+Lg7GPlQVI3XdEAhOkiNYSe1yhjvAaSUAp+2NweSV2TzuYxAjAiO0AQ5dFsgh76GKJ/s9mnMfmPhAwnS7drkAq6S9yTI6WgEGshwo+FzcST5+Okwpe2Zgt/neYovkmyJuuT4YBjklLcnenzv923yh4LCHow9KC3l6XH7jhB/ru+tcE6cJPYdptoL/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeGp0nh1DicYVVhS4sZY9ZDmPeZ5HCOC2hGt6GdeQdw=;
 b=tWzVzyuiQh+X55dvRZspv4Fuo+qsb2p5KfYpKUc9Ro7+bOCBoM39FH0zmGJJ3MtGZW6mPdKrqvAtG2vDXnCcFO4EFDNKhnzNuLA39+w6/qgFgIrY5F5hvKR4J0w/TlMwuNoHotLuJVpb/Owx+ko4njeQLNYe7IcU+5J4U/u8Aw4aJfI7MYM3Nkpq0gTXMVN+E77o+0PHZj0E1ma7CWbr6w7jG4cLarZ30HCKJNXASOT/ESLjvvo2YA5I9hzBGPZL77bHTkLe+EGi8AxnyhsAdpXjVbb6qoQxguY+RTopHhyExNFiGaC/IFzqrPzqlLhyUVXVTkZgL0L1sPW5gwTaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=iav.lv smtp.mailfrom=cn.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=cn.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cn.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeGp0nh1DicYVVhS4sZY9ZDmPeZ5HCOC2hGt6GdeQdw=;
 b=U/HZYvm+l3QzaxM17cswnT7eXsS+dYjKjJhjo2ULa7DvJhzuDQ7C+hmceqLbSOa4k6cGICJ1eFlFTJVJakNuYnXsCmGmr0mjcon/jA1mXCt3B5LgkO7nAN3z4WjPqNy/NWcY1oRxA1kb2Vn4/DUqK5ksFZjxXKpb0/7NjZSbktynPpbmRCtCEpmWdlKpTIYweTm15RhWL6ZLAwTu6hfFnNbH+m+IQmIk2DZ+TRP/gTU1uZodLN3rLoapPLMXTnsa/3HI+PtlsC4vRu0Sr1zIbK1XIbp8CdSyTx1Vm5+P8s3rZxzl5/rRKTAE/F6q6RlCpfwxI0+Q3Ed9G+a7QJRFMQ==
Received: from AS8PR04CA0150.eurprd04.prod.outlook.com (2603:10a6:20b:127::35)
 by GVXPR10MB6008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:16::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 10:19:47 +0000
Received: from AM2PEPF00070CF5.eurprd02.prod.outlook.com
 (2603:10a6:20b:127:cafe::15) by AS8PR04CA0150.outlook.office365.com
 (2603:10a6:20b:127::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 10:19:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 139.15.153.206) smtp.mailfrom=cn.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cn.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of cn.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM2PEPF00070CF5.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 10:19:46 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 11:19:27 +0100
Received: from WX8-V-0008J.wx.apac.bosch.com (10.190.167.205) by
 smtp.app.bosch.com (10.124.11.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 11 Nov 2026 11:19:26 +0100
From: Haoning Cheng <Haoning.CHENG@cn.bosch.com>
To: <iav@iav.lv>
CC: <netdev@vger.kernel.org>, Haoning Cheng <Haoning.CHENG@cn.bosch.com>
Subject: Re: [PATCH net v4 5/5] net: phy: postpone PHY interrupts during sleep with MAC-managed PM
Date: Wed, 11 Nov 2026 18:18:29 +0800
Message-ID: <20261111101829.89599-1-Haoning.CHENG@cn.bosch.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031-b4-phylib-mac-pm-irq-v3-v4-5-5ba23b3ff9a4@iav.lv>
References: <20261031-b4-phylib-mac-pm-irq-v3-v4-5-5ba23b3ff9a4@iav.lv>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF5:EE_|GVXPR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bdadca-2efd-4e4d-c282-08df3fdd4fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|56012099006|5023799004|11063799006|261021121427099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rqvHIfFIABJ33s25wxAmgiTDguR23AWkTO6F5pk9/SD9jINw3eR9AJ8uSnZT3qLTqBAkSXBWyBbdgwImgas0oJnZ5/MuQghtTrueCKk/l6W4inaN3h2ZzF69jXoGeSxiLKnlJm+j/Ete+8X01EcePoJK7DjHKRoUv0JQ7X7Iulyn+ilqd9W04doOmzSsIYoXyg7tio5RCJgkrPBjDNvwk0r03Jh4dRjwSMm90fOv2RyAZYGN5AhZMIUfC/s9bmBoo2JMNgZuTax+HrjzJHpaJjeCr7MVarBb/TqLGda2c7aNlLG87u0ecn4TvSMvOEEbdFs1i/PWFMUwr4jEpgDk4/acSvr+hbyyr7kzvj/9mR5X5SAESqMqq4NBJWFHaghr/Q14poRrtTWliA2bR+05EyjpcXI7NIDjMH/BAa9N2CFP+7BW6sM/ZTa3/TFDVZosAufzTBXyl4Hilk5Tws86qcFQlBuTOi5ruGUA32R09eXSavydcm5+l1BhUN7kD/lFe6nyaUG2TaEjw+D2RJUUeGrbz9ZNHr1EDBc4rVeWT/pcexiPZ/AVdiD4pwI4fBzM+YN2B2tx+9j8XQ0+Y8UV6vjF34unU7F5RpbRgjOSZbMW7l/A65GNk5FoQWkYTsi99fJq8ZtS3bw5oP6xmgVNq2QRUExmfn6p8eEPH3ZV20LP+uUySld4nbsJKa0hezOk
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(5023799004)(11063799006)(261021121427099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	msm3m8Sl3fofPErMclNCvjRF5t0iZ5kG93TMZtwf3xFR7R7pdlOldoJimX43EsS6arDI0pivOFp+cPo/TGYKmAP5krkYagAZPxtCmrMMgZd1kaoHLYV5wB4GRp1CkNXtfkE68CNN2v80QJ9bwhYWeICji7CX6SS9a2eN4nZy+QkudpDLj3SpUvFY0jEhIP7sdIEwcwp35YfeOxYoLI67HDYuN0xQoQ0e6AcmLQRjCMUWkUGh8HfRgDfOMt4ruWBckepqZtaeqfL7NOHbQ6JSan2EDl2OFuIPutEBgfiJnwmpTQxo7XKrm1VR0tIU69EASWNmxXr3g2CfyikINSHAFFeq9+b3GWspPbQgJMTvhVB8VscNxWcDXFCxK4GqJIUscNyc0zPqt1tJUQjT16R0AV9IJ+/0fLX3ae+kcVEmWryNWASCHp7cApI1jWkjkIfV
X-OriginatorOrg: cn.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:19:46.9223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bdadca-2efd-4e4d-c282-08df3fdd4fda
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6008

Hi Igor,

I tested the complete v4 series on our i.MX6 FEC platform with
Linux 6.18, including minor compatibility adjustments for the
backport.

Suspend/resume testing passed without PHY IRQ-related MDIO timeouts.

Tested-by: Haoning Cheng <Haoning.CHENG@cn.bosch.com>

Best regards,
Haoning
