Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793690588;
	b=eN8tEMVNIxHdHTHrOLmntcIyL9TJxgoyXl+XforqY8MEYaZfG4pvvrsZEOy00wU7ppW+
	 VaZhOVJdCJthVtOlkMbHI/5rZlFlM7ZCDFGBbHBtQYh47FliVuN5ynkU70kaXM/xl5iCE
	 NmBPgzJRYdDfbC2kYTvm1pRyM//ndjW7r1QCljuVrhwP4YEtptD22dUHWo5hzaAIlHmpy
	 0bLFDDSdohUqdtT4ZNcICcLUSxpRKtP7J+Gju09KyAKydpd3Jvj6CpqFCnrjqOJTHmhYL
	 OTcJKI9/GtThlzeeL17LZG0DqphHJlGuQ0HP/D0ejRfPJrEUG3vaIW/We8p37koYRVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690588;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
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
	bh=uj6Z6hevB+BUuZJZBweVQCsGFUBzD8SlCQUlqdZ4sGg=;
	b=FHUzInawCEfkGL48YmUgCNjOV6iMFA8YbkmAMawOBjKlgmGfLrMTGQNrIWUYZMIwjAQr
	 KYTgTjehMQxp5RyjgYUtbuzrJAHdzBnYYavQoOzaYWJPUCo2DSoIil4uNvv5ZNR2pAuVB
	 2vhLiLNDA9jLvSzefSJHVPTBf5uEWcmOO7FDfCNSdT1F0NYNeK9oVzve796DHix/rGCn5
	 AL6mzsjK3FZgbr4EZcUY3c0dAr58EMBsiD7lbllHNEqkyrqHGCZVfSPiC4sRB59qxFH3n
	 nc1QRXLCxL9IaL0+dIUFaRTfBYbkjVv7wda+rW1nYyfxfeQ4siaRQyQ6Dyl/AcPLGdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cn.bosch.com;
	spf=pass smtp.mailfrom=cn.bosch.com;
	dkim=pass header.d=cn.bosch.com header.i=@cn.bosch.com header.a=rsa-sha256 header.s=selector2 header.b=eq0KFw38;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.39
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB61606A324;
	Tue,  3 Nov 2026 07:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB61606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cn.bosch.com header.i=@cn.bosch.com header.a=rsa-sha256 header.s=selector2 header.b=eq0KFw38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjS0aTuiH8n4ph9Iz1cGGypZSoBm9iFHvYGbty+X24ThTEbpISxCIfFGQLL3Rak4NH137T+UeCn8TgbdxAO7WiQScskeQFkB8nOCpTjbUO8tCjpqiIPcsVbyWZmYos3DdlumoUJxIHEDtKK2Zrw/SzTYs4IVJGfCGoHyDZM9XXDCENmCbw3VqHhWpCLtUj8stsOsyS8MOqD0Gm4yUxPhIjjMhWATZ9Uo7ge5LzSN0CUllrcvZPTTUHFeEEWJUqbkx2hlz8orDH0+GuIIZsQrTCo8JQEvooWKsbF3P2VDQSe5uHoAh0vmcQIrYzyq+NiZ/lgP2Hhv8uBfSxIWgrOjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj6Z6hevB+BUuZJZBweVQCsGFUBzD8SlCQUlqdZ4sGg=;
 b=t6kq2O+/ZTsd4fafnucYa/Gl9cBaHupgd8y05m1wTGBZwtxtpcWFc7rVH2DoxHdrCa8bS4w2WJCg5m8gMKuUVIwUkNoV+ny13SCeYQQIy7QnQ5+0WvCIPZxhtGCXfFWp5rXUMRe7nanoks9eyzqprgMM4sLBrWvANJunXlieqrajMQRdCfQ1MrQFskNfd7pJwVgNfyNPAxddRUblTVIwfduCVeFDjMQ+9v6SGkacVWAJTVSIn2gea5EAKxJn/wkdeFjuXq9flIFeCcB/F01JqufX2f6ROLg/Ngn/QhXsIvk4XZY/Fl7w1kq7B9REu45Aj+NIYheP0OsJTKjZMKimww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=iav.lv smtp.mailfrom=cn.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=cn.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cn.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uj6Z6hevB+BUuZJZBweVQCsGFUBzD8SlCQUlqdZ4sGg=;
 b=eq0KFw38suBc6Wjpp10myq4eaDLJNonXwPtIecbHH76Af31hgveBBeBQpCor6PGT9YJ2xGc1/s2pjF79wuZDwxI/YakuEZKyjbZZHBtCYMoIngv9755KFkfdK3Ge/sTF4C9JFMJYTb8mu34x6l2UFYyznqmplvqxWgxwUxof8lBx/XZqDjgZpMPQLZebxhtrhEPCcgyZWPuG4V7bYQGpYWsW/SvOjkpLhfuIidrpjdLGiFVpBANZIcHz+CuKxNGzjl3ZZep5tG9TUoKdfharztOhjPFjLj0dxJWjJD4rwDK6wtfEjFTrfIThr4wkrRhSuIfJ4ToQ0yVFG0sN67EbBw==
Received: from AM8P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::35)
 by AS8PR10MB6392.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 07:23:02 +0000
Received: from AM1PEPF000C1ADB.eurprd02.prod.outlook.com
 (2603:10a6:20b:21a:cafe::34) by AM8P191CA0030.outlook.office365.com
 (2603:10a6:20b:21a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 07:23:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 139.15.153.205) smtp.mailfrom=cn.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cn.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of cn.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM1PEPF000C1ADB.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 07:23:01 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 08:23:01 +0100
Received: from WX8-V-0008J.wx.apac.bosch.com (10.190.167.205) by
 smtp.app.bosch.com (10.124.11.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 08:22:56 +0100
From: Haoning Cheng <Haoning.CHENG@cn.bosch.com>
To: <iav@iav.lv>
CC: Haoning Cheng <Haoning.CHENG@cn.bosch.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<lukas@wunner.de>, <rafael.j.wysocki@intel.com>, <wei.fang@nxp.com>,
	<niklas.soderlund@ragnatech.se>, <paul@pbarker.dev>,
	<florian.fainelli@broadcom.com>, <opendmb@gmail.com>,
	<Thangaraj.S@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 2/2] net: phy: postpone PHY interrupts during sleep with MAC-managed PM
Date: Tue, 3 Nov 2026 15:22:23 +0800
Message-ID: <20261103072223.66463-1-Haoning.CHENG@cn.bosch.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026045343.837889-3-iav@iav.lv>
References: <20261026045343.837889-1-iav@iav.lv> <20261026045343.837889-3-iav@iav.lv>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1ADB:EE_|AS8PR10MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 583f3174-a672-4ddd-b543-08df397b4b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|261102123227099003|261022075727099003|261021121427099003|11063799006|4143699003|56012099006|5023799004|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	xY7tdcmYMs//E1yxIwrfUOpTRmjtH4i21GY3Olg6nHvzyOCsTHr400lYIPYwMDvXREYYF37ZK7801NKecLEdj9tkQfmyhQXRWN4hS4lxoibNcGGDpTl6vtNiNI2Y+fjgzmF2JYLQ+UzLQH1yud71ihAcGpU2X5MSVUsbbqvjyapT8IWissHukfBn3NJvMFphTCmk9zXjVzRZWG62tOBsjsP2VecnszJlz3d/e3JXUKGgckTCG5haS2YVVa2GJ9kGbbaPRN8VXIvHxQ+Kr/SgZm6dL3l12DqU10paCBmGeaGFJbT0X6MLRfTBjmbdAD6RwATN2o3YyhOXhdXM2NairkCFvFdTdmluwuNJHudreLWWT6XNUN5UPi6tf+Mgmwn0y0tzydwrnuGQ06SgxqRvaamlsUh3/6jX1QGsoZ2GZWB9nM/FUFkbZq6pn1deOQi7zfyJd1/HDEzSjIBvAhR0N0mtMXuadra2CcxdlTyzNmcDpFaoBbM3/ZG/rolinXQDPuAidfv2l83xYwdVeIxZs3PPWJf841DBUA43A17SUy39TfADfNTVQmHiwOgOcOmj2vrUD8mha1s2TdbTb1nOhS1UHg/RRUvBddmJNezxj6Wvs+4xoblN4pQ4D18XFk93UKBHqtGOCSrZhKvpXJ0orJ4cxTQoqQJ73SUHI3KUT+QtfxGwmCdWcDCi6gimxCM7zgODZDLhUQKY872IgIyhoQ==
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(261102123227099003)(261022075727099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(5023799004)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4uhAhIK3nBiAc4bHcx0aCfcoRadLdkwtIl1J01lT6JLVQ2Lwr77a0SwOdpC5d/VDFEk9pPn+ooaheFn01OrmPlWeNAMxpKGnfZoKIab/nNOnHkyMCM8jOy0VQaUD6cydCak+vOZKVem4shXCLoD1maaCeDAeDcd7d6wLkPTsX3AQFjL2sisNJwfyMsBQgaEHbDVgknhIO7KX8qfpO3X2lJfdL9SdcHMp95IuLHANuLadv84cTXkJCOS4DpTURlilOcxLg+3SwggfdXxpxKYEfd2Rh98HJm91WGIPjtcl1WVtMBh+z8l65bjLV0ZTH0YjVrQjPfbnR4t5Wwr6gUB1w3QixVtHY+5ZK9+LjV1NRAoM5t5XGP2KloH64g661h3eqovtekslb6GZeax5721HUC7bsZiYoHu8Atwo4WuQUReFeq47ct5sYP6nrCRCySn+
X-OriginatorOrg: cn.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:23:01.8811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 583f3174-a672-4ddd-b543-08df397b4b74
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1ADB.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6392

Hi Igor,

I tested the complete v2 patch series on our FEC-based platform.

The patches successfully resolved the PHY IRQ issue during system
suspend/resume. No related issues were observed during testing.

Tested-by: Haoning Cheng <Haoning.CHENG@cn.bosch.com>

Best regards,
Haoning Cheng
