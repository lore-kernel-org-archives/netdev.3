Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793594614;
	b=peCqBkZFZyFa7pF25G1FuYaY19Ujtb5qz2KS35068bkFAF6s+Zw+T1yx5RN6ZNlDmZP7
	 Ec87twjjw/bPfR2ayzEjofFneuecHHQlKR1eqj2VYQB62NjWe7ozqqr8r2rYSmT7tNxm9
	 SGe8Y5OtDX+NaLYf96mBATqoHLyGj5TnoVZ5PD8Q8sTFW7tcgnH07nbcIRsYmiDbQKsX/
	 LRsLHaLpordh8OyckLmjFbEn+xGA3OjELiXpBEedJH2jShS6AszC6/KMGXGO/HzKWxI5N
	 eon7KOwUAKCMvcutdT6Pd0gJknJ6hjGBMUXNQxlpA0tIxeDLafHQkA+02FsSQdOHSng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793594614;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:CC:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=J6P7jq5cnpjbDeJV8RSEIA1G5fc39U35fK1fECqe0Ns=;
	b=cLV0ayX6YV7LHjqmmbOccVaDvkiERoD3r9U4uBFHGGOjJ8xAQtl9njrWOX1UzrfavYhg
	 Xi1fVQ7UhUtA7X0LNqvSAA0F+2rgPwEbs6YQEwmbMUC5COWYEDR5XiuLVZJESleJuIGwN
	 d22octet+ZnfIquZb+e+SU8xKBlO2NxW3GxnYmpLfRDBS6DMRdvjtsXb6y32NHFz3AdrM
	 JgKzM/jpSncUc1I30gSbW4UFD2Rl49xuUQQmWndtlRkB6BzgFvcGcnRtpt6Ymh/HOC1pK
	 K1lZVj2Lb5yvHtLo+ZKa7IyikFHTyzh0CncHflRbIqkOIlYQxHOHbtP5y16bNPC0UgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=dc5r7Z9I;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=D8RpaNI8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A136606A324;
	Mon,  2 Nov 2026 04:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A136606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=dc5r7Z9I;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=D8RpaNI8
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A23voWb3507401;
	Sun, 1 Nov 2026 22:42:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=J6P7jq5cnpjbDeJV8RSEIA1G5fc39U35fK1fECqe0
	Ns=; b=dc5r7Z9IFS8h6OgdmRDRemw7Om1x0o3V5eanCgv4aZcCGNwhivgwHosMl
	JBenq0fNzFVf3XvEfD5xL6UU/pNKN5R1bj+2UDZn+WOCB8GItliXagNfXFuijdcw
	4l20XUMaUAC+iy8yhsaXt5DAhooKjykOPuuANa4IIx9PRFnxfHKWJ4ukG6hCYNSz
	D/mM5sCpr8YtKNSrVIwylhtwzKxq69f7QNtrhFBqazOCc3oheH4kZU9/muZkR7lw
	jLvFqx3Cv+FcWGhVSyO/qTrKtr2UKVJVuRwNX/SEv/6O2sOAGZiQpU2baKSSfxk5
	vTZeJHk1Js34OSiiRHM0fGU9LcFRg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hnyfnuk6n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 01 Nov 2026 22:42:40 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIepP30jUzK5+R/foPfaFHhhyewQsQX+3tGDVsDec5R/zDWj3TJF5eZeqGxX2AAjC+ruemj9Gmb5BjGXrKuYIiYpyhfLNN/uC/E+f5B+qP0L7Tarc3JXpbdQLJbfmd2MKv/97UBaNejvagxkMqhlRqRlWYSKPZpVJaPLofpm7Gam5EWlETIgJHifqdPdwJ9LyIgpqMXXZGgZ5KkPGWSzbPFmBKWUNaUKBZIksBHt/fXfGwYHlp15G5IIG4K5IaOHjOLpvXAjpEtgLC+XrrypKxwiByTZRHyEcTj9cwh5qGnPmWioSux/54qqhAGzW7hyq7k3wIqWKo8dbTPlomYUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6P7jq5cnpjbDeJV8RSEIA1G5fc39U35fK1fECqe0Ns=;
 b=Gjz/aiPoJyyZBpdQg9Hwyf0PB4wgGl8kyZCUD/+CzDQ8e1jel/snkHLd7RmCXGaLChLKiqE7JHl3iYgMUUaHIQrRGkQjV5L0m+wvRTS6hVrAq5KPsJaQbskD3gucutLQfuTIh5x8q7gvLtJnjit/m00KLO+nB6EzszCk+3rpFwutVsDhMBqQyjKptCODzQQRZh8oNzbdJCzJ5a6Kee9qHNNbff8aKNPeYgPvToZMeIJ7TRnuNC7Vkdu4tRNX+OHmmU8F6iyQL72mgGkOy738bd+iwUG/RTtf3t+zzOoocu9xCc/69OIERNhK/svbeYzgR9+20ZWT43p+xGSb4/6Zaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6P7jq5cnpjbDeJV8RSEIA1G5fc39U35fK1fECqe0Ns=;
 b=D8RpaNI8aq5VYqpLduXsrc7dbCKslHi0EIslB284ty2pzX9w+LLxPwo6Cg9qkT/+BAyXo0XrZgGyhzszNZTUgNEPmuejof410UXMqX+MhenDTaD1/U9LKCDBcqMxZSH8TFIwwtV+HFYjeAcweYAoELAA6eg99k0U0i23JrozHe4=
Received: from CH0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:610:b1::12)
 by LY0PR10MB465448.namprd10.prod.outlook.com (2603:10b6:404:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 04:42:37 +0000
Received: from CH3PEPF0002457F.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::82) by CH0PR13CA0007.outlook.office365.com
 (2603:10b6:610:b1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 2
 Nov 2026 04:42:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF0002457F.mail.protection.outlook.com (10.167.252.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 04:42:35 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 1 Nov
 2026 22:42:08 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 1 Nov
 2026 22:42:08 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 1 Nov 2026 22:42:08 -0600
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A24g3H11349430;
	Sun, 1 Nov 2026 22:42:03 -0600
Message-ID: <810b7cc3-fa53-4be7-a519-bc289c94d9f3@ti.com>
Date: Mon, 2 Nov 2026 10:12:02 +0530
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Martin Kaistra <martin.kaistra@linutronix.de>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: keep port and direction
 when matching PTPv1 TX timestamps
To: <jln@pascal-audio.com>
References: <20261030-am65-cpts-ptpv1-v1-1-0bb4c370d970@pascal-audio.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20261030-am65-cpts-ptpv1-v1-1-0bb4c370d970@pascal-audio.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457F:EE_|LY0PR10MB465448:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ba4b08-63d0-47a6-4c43-08df389bb776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|5023799004|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	KLsc2krTOD4+v+XE4FBgPisp5/G1N9XgTzSo0bT1teB+giC+E64U/JvgEXXJPK6Zbf23ujDjVFbGSx8gRRqThukw4xe4TIzhAFTa1k76gFi3mr7bR5Ituf2w0cNufzMmw/8ifz29iY2gjEkwOA6/j2mtRsAjidKWqpRQJhWVQKcId+LNa0+KHxugAyLpZz4m/ivtdJHb7jyNSyGD3UfDkmLCiks6l4le10fizmIwATzwtcmW3/e+oiwD2BEK1CTYZYM9CwUscg7fiHcH+oTzNA8L1qnHTNXCsKq7Es188UWCnVQ7SjnFXTsuHokUTFCkX9htdv9U5zaiIgsG0GD7MXdr4wbcZbcAcSgyiYzR0wkIhWeAEQ3LY3e+ml8+uGrJ0dAUX3YCP0hwfRKlMYg3FkOXyiBzMHvSNJILKBjedRzBoNMyGPg2rA143vh0zWcDlnOv3ywQMmDFNZJSOPGh/GMxotprHYdROA2pjRtweHBcFn0DrAGZao1HP13w++IMfB9ckMhf6qhQnYDUCF/LTcIVe0fxg177dijzzKNm6wotyb0tLAB5KoB1qZrn5nCLYFQ1kukSCWgPVSOkt3tX/0u3ikQLYgLRIJGLOqwpBVhzHLXCsMit5Z87DuxHKtBT/uKoiPXjVeCmfTQml/FmdsO0YmwNKEEPtoSysSJYJ0GjByjWR65P02sA6nAlPga8CAVRL50sb0C+yfP2Qstdng==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(5023799004)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tdpa5aF27bU/anjCTFI2EFARoxkY6yYE4fs9LKlwp+8IARkgkUuR879Bq6JUHfekxJYlSfZobgYGK2oDON5or+Rt3VBeRm/vit836pfKynYXY7XDzDBQ2jd8TU0xnWapYzSfKuWSwt3ONX6UGeeOQuih0jio/x1A6S1AOHmNC+mw+EzijRNH5KqL3chql+5Jmz0eSTs/7NUZb7j+VAeuiOy4xiZWNh7kDN5XgZk80JfHaG5nSLJFtlXSD5i17rGgViBC6GRsC5W5cagCCLGcCNiym5LSmyMZ83QHKNb/0hZiOdhjHZKfY4As2kdWoN9EVLRuikHOfgMQgUjGfMON9U1Zkvhrjxqh617+2IXRRFmG6DQouX/e/NbeBeeF1EOPjZ6bRUgGE8+iLS1CoWgBQYJsh5MNn/v4GfpaOn2Omo4A3DDPL94gKvqmMq+mDePR
X-Exchange-RoutingPolicyChecked:
	tZJC6wFT6imIpy9bhih0AR4iDmW+Jf+IKVj7SHMqm6lS6JEwjA0tQqi2QuQrtArjrUUOE7XBjIjBeU/dURvVjjwlVnsqvFiIOU4WR2Tnl8mGxzyGticsx7V2F90plkWXlaOAHDRVYd0dZUHCkODpPnfYlZ4BcBk2P17sxjhM2N4NWKwImBeN2qYcwT6VjB9MmmhEJITRPVe7VjSy0U0BfEj06TS/09Wun+qQQ4n5yWhdGcyfUo4sGWGUu+KuozvicluqunTfniN0F4RVNA+CRQYNKdPgDiJDGVUPJ2fwHv5gspLU9Kf5pw1pyWGlCpNzdOVnvqlDqO8tQ3PQKkqO0Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 04:42:35.7974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ba4b08-63d0-47a6-4c43-08df389bb776
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0002457F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR10MB465448
X-Authority-Analysis: v=2.4 cv=Sfxi5fRu c=1 sm=1 tr=0 ts=6ae814c0 cx=c_pps
 a=RzNzSA3Xhmsnv5027CV2rw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=Lpg-e_CJAAAA:8 a=1LiGybNod8jMbOq3DUwA:9
 a=QEXdDO2ut3YA:10 a=Rd6YnAgPz_nnXFc5Nq4i:22
X-Proofpoint-GUID: IEDooL3RhioSvGV5FU2nwYR4zcFxcfyN
X-Proofpoint-ORIG-GUID: IEDooL3RhioSvGV5FU2nwYR4zcFxcfyN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxOCBTYWx0ZWRfXxgwxxjlAVS8i
 JJYgfkHsT7VQRJYO0nmks2tfQBojvCXfeXG46LCPmK43JU0FJvC7c+6EHNP1i4ynFrCbsgM+5G1
 G04KHMTnJzJb0cSetPCGPDmw8k+9rxA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxOCBTYWx0ZWRfX8dgW5tr54WMZ
 Bt6r1Ao6tMJHbzkvWw4+J2kmynbWoDwPBOG58z6OLkSZoT4SBD9uGY6pjwRhynBEvyIfNV/P95M
 dFx7Qxh71ZqpHUEA4qjxHKyp48A9muctg34KYNpYxSve1S/xuNrFO8N4fHBDUoKrAIHIanaLIwC
 wa1GCcRJ5MJ5GrvO+R7E6UDLiRrF1gphqNhHHmrqW1GLrssKcEmYTyaHddit3pJ1+JDEBFIKaY4
 YOdApS4Jqs5i3szKqqTv/OaMAi/+LlCiJ7RMV9ALO4JsOTlcVLfBrNK7vuxRtjLdG2Eztzt3WOA
 NP+wNaeu5WWyHYb26qCRwVR2HVbn2Srg8VOhtQtu1xV94JVmaXKWQ6sCSZSVEa1dUT1OMsLRUwZ
 0U50Ss0ZSHPrTCZdoOqV3MrldsAv7VVR1Mb7FB2m4KuABDymNOP4aPMBI9r5TDSB9NRyAo7vXJ4
 /tRAku0iOvNP/2riliQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020018

On 10/30/26 6:49 PM, Jesper L. Nielsen via B4 Relay wrote:
> From: "Jesper L. Nielsen" <jln@pascal-audio.com>
> 
> The CPTS reports the message type of a timestamp event using the PTPv2
> header layout, i.e. the low nibble of the first header byte. In a PTPv1
> header that byte is the upper byte of versionPTP and always 0, so every
> PTPv1 event is reported as message type 0, while
> am65_skb_get_mtype_seqid() reads the PTPv1 message type from the control
> field. To make PTPv1 match at all, commit 1b9e743e923b ("net: ethernet:
> ti: am65-cpts: Fix PTPv1 message type on TX packets") overwrites the
> whole value compared against the skb with the skb's own value once the
> sequence ids are equal. That throws away the event type and the port
> number of the event as well, so a PTPv1 skb matches any TX event with
> the same sequence id on either port. For PTPv1 this defeats
> commit a23c657e332f ("net: ethernet: ti: am65-cpsw: Use also port number to identify timestamps").

nitpick: This could be wrapped as done for the previous instance above.
> The overwritten value also sticks for the rest of the TX queue walk.
> 
> Since every PTPv1 frame reads as message type 0, the hardware timestamps
> all PTPv1 frames to UDP ports 319 and 320, including Follow_Up and
> Delay_Resp, for which no skb waits. With a PTPv1 master on both ports
> whose sequence ids run in step (e.g. a Dante device with primary and

Does this mean there are two PTP grandmasters? Is CPSW configured in EMAC 
mode or Switch mode? Is the PTP application bound to both network 
interfaces? The reason for me asking this is that there is a single 
instance of CPTS and we can't have two PTP grandmasters simultaneously (if 
configured for EMAC mode). Could you please clarify the network topology 
in-case I have misunderstood it?

> secondary network started at the same time), the unclaimed TX event of
> Follow_Up N on one port is still on the event list when the other port
> queues Sync N, and am65_cpts_find_tx_ts() tries to match before it
> checks for expiry. Sync N then gets the transmit time of the other
> port's Follow_Up N, and the master announces a preciseOriginTimestamp up
> to one Sync interval early to every slave on that network.
> 
> For PTPv1 replace only the message type of the event with the skb's and
> keep its event type, port number and sequence id, and compute the value
> per skb.
> 
> Tested on AM62x with ti-linux-6.12.y and the port number commit backported:
> without this patch every boot in which both ports started PTP together
> (10 of 10) sent wrong Sync timestamps, with it none did (0 of 29).
> 
> The bug was tracked down, and this fix and changelog drafted, with the
> help of an AI coding assistant (Claude). I reviewed and tested it on
> hardware as described above.
> 
> Fixes: a23c657e332f ("net: ethernet: ti: am65-cpsw: Use also port number to identify timestamps")
> Signed-off-by: Jesper L. Nielsen <jln@pascal-audio.com>
> ---
>   drivers/net/ethernet/ti/am65-cpts.c | 32 ++++++++++++++++++++++++++------
>   1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
> index df5659ead7..e30fae0bcd 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c
> @@ -788,6 +788,29 @@ static struct ptp_clock_info am65_ptp_info = {
>   	.do_aux_work	= am65_cpts_ts_work,
>   };
>   
> +/*
> + * The CPTS decodes the message type of an event using the PTPv2 header

nitpick: Unlike other subsystems, comments in netdev do not have an empty 
line at the start. So it should be changed to:
/* The CPTS decodes the message type of an event using the PTPv2 header
  * ...
  * ...
  */

Once the setup/topology is clear to me, I shall review the code below.

Regards,
Siddharth.

> + * layout. For PTPv1 that nibble is part of versionPTP and always reads 0,
> + * while am65_skb_get_mtype_seqid() takes the message type from the PTPv1
> + * control field. For PTPv1 take the message type from the skb, but keep
> + * the event type, port number and sequence id of the event so that an
> + * event only matches a packet of the same direction on the same port.
> + */
> +static u32 am65_cpts_event_mtype_seqid(struct am65_cpts_event *event,
> +				       u32 skb_mtype_seqid,
> +				       unsigned int ptp_class)
> +{
> +	u32 mtype_seqid = event->event1;
> +
> +	if (ptp_class & PTP_CLASS_V1) {
> +		mtype_seqid &= ~AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK;
> +		mtype_seqid |= skb_mtype_seqid &
> +			       AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK;
> +	}
> +
> +	return mtype_seqid;
> +}
> +
>   static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
>   				  struct am65_cpts_event *event)
>   {
> @@ -797,7 +820,6 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
>   	bool found = false;
>   	u32 mtype_seqid;
>   
> -	mtype_seqid = event->event1;
>   	__skb_queue_head_init(&txq_list);
>   
>   	spin_lock_irqsave(&cpts->txq.lock, flags);
> @@ -810,11 +832,9 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
>   		struct am65_cpts_skb_cb_data *skb_cb =
>   					(struct am65_cpts_skb_cb_data *)skb->cb;
>   
> -		if ((ptp_classify_raw(skb) & PTP_CLASS_V1) &&
> -		    ((mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK) ==
> -		     (skb_cb->skb_mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK)))
> -			mtype_seqid = skb_cb->skb_mtype_seqid;
> -
> +		mtype_seqid = am65_cpts_event_mtype_seqid(event,
> +							  skb_cb->skb_mtype_seqid,
> +							  ptp_classify_raw(skb));
>   		if (mtype_seqid == skb_cb->skb_mtype_seqid) {
>   			u64 ns = event->timestamp;
>   
> 
> ---
> base-commit: 5838f10563d58afca6711edb5e4eda968ca181d9
> change-id: 20261030-am65-cpts-ptpv1-45cc3c7276d2
> 
> Best regards,
> --
> Jesper L. Nielsen <jln@pascal-audio.com>

