Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023137.outbound.protection.outlook.com [40.93.201.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B03A9D9F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090124; cv=fail; b=G4NIJAtImwrOIys4Gz65lNdGWjgJo9jczOCp9nIViJma/KwdD8ZwDgt9jCPsRSLapWbZnEkiLxzKATIfzk1mwlnUx5IopW1rfe8w2h/TFrFwaCQPNfGjWUgGntntyoDUUgyIvmQ4wUR+61w5OZkUb5K5fI2FT0PWAk7EUGIH5Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090124; c=relaxed/simple;
	bh=hHbzlVh68ZXSMZQmcPCSiCUfkKQDh4dO7ZwlxwRyQaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f3Oa+4b/c9bL8dNCXARDyvUbanFbOM6BsTtjKEsr2znGj7/4PkV5+L0RPI1ni2esvFTTe7DUCqBhLdP5TFsONaC7y7rtlI1js17RobNZN08s91aZv7Njg8uO9ytikuRSzS1FaWR6RYO00qEXMJw3m4HOPEo5F2HsOtMZpHkDUk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=0qe4pTPH; arc=fail smtp.client-ip=40.93.201.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="0qe4pTPH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIyk9uQJLbBu8wDv2dW74qUD7bc/wuctO9xT1oj44I27pkB+n54XU9gxdPkVH0kfu+G0yNUnGgQ9+KAxjty7h4+L0c2sro7rvrhj13/G86+x9LBztZCwFYbi5H2NJJ10M+U1wT7vb+V2okclNqGxZRzeRh9dQ1S5WBWsJMO9OHrTz44CIYxu5GyppIyFQS9mXozzuNDhRAS77/Pj1JaPBvVhPDuWyVA3A45EpsntIDZUwaPWyLT0R1WWhGNFjczfvvs5sv24QLJCF67AEUo9RHfXt0NlsyKbWfdY2/xNuKhW1mXFggO3EdJltuCWwxIfoUmkos1ZEZiqB5yXGh94QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwBIzEGlQyHAEbd4R/rTVpb7BZe0nenG445TffHO0Q4=;
 b=FXkWi+o/Mo0vgXl5vZdXEDTP+/eFbgB/MCi9jNwmKQIeJrXVsDqqHL1XMsiSm2SeVZS1dBunv1yswwqmUtjY1fIqDlHdLWzlcqdHfzMD3II2hjXa817iJDfEtJHMNHO2HgMiHPhplxQXhND5ZJtWbf19DOQ7v0/fQupsoYw9GO4WmAEhE6uUVIaDvVWvC1CPqf5t4ANso1fDZxaAMvQ4v884ineuivA12K4hG17XF/TtzACh3NRFvZJ6i4HxLBFzQVnjlyOZ0/b1ybda4kDL1xcpIH6w7hCc706oiSls0tS5isqJ4fLAj64c6LDM2WAt4V5ZedAvUCDIAtsHjM1Wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwBIzEGlQyHAEbd4R/rTVpb7BZe0nenG445TffHO0Q4=;
 b=0qe4pTPH3Hpy02wW90LqiQkURu+Sf+J68uTv/VtogEd7p/k+e93lexoxGnaMtyIUFJPlewzew37MsnpjZZKDPwYNxQLZrEDLyf3NNDLDFniMMn7gfF4Ld1s3M0yBuD8JAkq6CIztU+W+x4oUqTZa4gXhrcbTTwDg4C4gPxlEWVBouYhkwOQ8AHop91OH3EEsoWsdxnqYnNqapWIDPU6P1vRb4SrU2Murcdxqss/mBHXhmO+VSr+g8BrknK2PaoT7tWDo4GecQQsmePYUtBHLriohNY5Qsccku8at7fGdU8HKMkezMu5ZRzE3rpuZr3kfd53gxeXRqApagN2bfbKBcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 15:14:44 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 15:14:43 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH v6 1/2] net: macb: Poll for link state changes when using the internal PCS.
Date: Tue, 22 Sep 2026 11:09:24 -0400
Message-ID: <20260922151429.23272-2-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922151429.23272-1-nwhitehorn@pa.msu.edu>
References: <20260922151429.23272-1-nwhitehorn@pa.msu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0c7644-8901-4c0f-ecee-08df18bc3a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|786006|1800799024|376014|10070799003|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	c3DGU3JC3vbdl2ZCDnfKWPQwV95sNK3iKujXC3AZ/CMgtTIARweziN/0jcTKpVVXOMFnRzHSqET5bKrZoyUXPcIzNW1TYzF3kSz37Fvde+mbrRCmqFhdP5l1IySEKHkPJ4LSrghpavmuWbJHwjU1jekCemU9OTGvUTAZovRLtLdqiVt8HQj6zWQG08X53PoeX9f6apkMEK/v7V3NYbgIvYeKMZG+Uxp71jb6F7B6IPaHNyolAK62qpY2dl7/HANOlboNX0L07CId0zskge+gLSKZVUVxx/EIQtvo735Jo+qOVyh3CgYMOTjqN6yVMhzzaLuUu0zTxYun6L72HdRk+D/+1gLpspEBAE6DTdXjahhFcVT8I+Zq0SY1AE7V7Bn3v+q5Vu/X6mYRfCGfFEXpjuW3hf8TyMs9ncNNsKKQBdRg8JfErxyLjHBCZdYS4hcZ13jzgG+kRfVXNTJHxljKTaMrIvlzpuk/UQ10e/unWobXdbzLOzRBq1r3Oj6s0Vk0HkjtON5akQ1LzexcxpO1X3+06ig1cexxtX/BWH0cQ2gT88R4hUVJI4ncp8C49yZIxmOoZg3wq1B29caC3WUBn7iio7nrfD6djgXGoS+EHNIsKR/znIxYV4ZUqxQ/yZfgdsLaQmOPuBau2ND/TWsDwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(1800799024)(376014)(10070799003)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm1QdDBMdU5iRUZ4QTAvbjl6Qy84ZEhrM3F6NE9WWG5aU093Y0ZvOEFhYTNu?=
 =?utf-8?B?eE94RG1PNHZya0twT3hxY2pQZGJQcEZLb204c0NrMVU1ZFhZLzgrSGMxbUY3?=
 =?utf-8?B?aGd1Q0szdDcxYWxUU253TDlBTFNOL0ExamJEbmlBcmw2T0ZDRng5dzB1UDU2?=
 =?utf-8?B?b1BBVXF3T290TDFTL3lXeGZGaDFHcUFKV0JuZjEyNE1pNDhDRGVqOUFrUnU4?=
 =?utf-8?B?RmZyc3RRak5ia2xudnA2MjdFSlZQUEdvcW1zeE9nMGY3SnhyWUF6MnREdXpz?=
 =?utf-8?B?SnBuZVYyN0hSclhaek03RUcyZmQwZ2Y0TnYyL2lEM1lidzJEN0JpUUlSekEv?=
 =?utf-8?B?dm83dU83ZEppbWFCTEJDYlVra09SM2xsYkNlT1lQejkzdHd6UFpDY01GdXdv?=
 =?utf-8?B?RGU1TUdoQ2x2bzdLcUxRaUhSQUpkd1JZeG9MRjRNTUZkZVpMMTd3YUZ6R1ZY?=
 =?utf-8?B?VWd5RVBxL0RuZEVVOWlqMFNYRWU1SWhQS0h1SkUrc04yZ2RPRW84dWRjK0hk?=
 =?utf-8?B?L2NIazRzNysxWGptQ0xvRUxNLzdUR05USDFVOU00ekpsaldBS25VeTAyTTJW?=
 =?utf-8?B?bmJYaXFDWHovM1g3U1pZNjdwbmVjTG5DcEJEblhQQWNnUE1NS216ejVxWnEw?=
 =?utf-8?B?WXNqcXczamZNVWJNVFN3Q09PSlpHN094cDdGWVdZb2ZQRlV6eHo3R3g5Zy9Q?=
 =?utf-8?B?ZkdNUzZMYkhkYmR0V0hFVkdQNnE5d2ZVNk1mRFBkdTVPVUZ3Wm5yYmIxbkEr?=
 =?utf-8?B?TXF1aEVwZ0VTYXhlczkwL2puTFBZOUpYMXVkTldnTW1MeVBSZmpMaUhKeXRH?=
 =?utf-8?B?TlJONHllOFdYRjhEOFdWUk9XYUZ6NG40N1FnNVZsbVhMUGdHb1hwSHVKdXZk?=
 =?utf-8?B?UUxwdVNkRXlrci9BT08veXpSNGF2ajNzU0hsUXFjWmtuOE1jcEJ3R0NMUVlO?=
 =?utf-8?B?YzlVRFNIOHg5RVRpOFpnRjNHWDV1MlVtaWZxcEYxUUI0Y1hHREIxZmEzZWdL?=
 =?utf-8?B?YmFQSzZ6d1pMaEZnbW1zRFZsNVhGQVNLdGt1VVhJZnBrYUhVcEx6YXFrNVpv?=
 =?utf-8?B?VWN5djdxVGVKMHpvdmVxYStMcEgzNzNqa3kyRW1nQjA1V3k0UytIRGllT0o3?=
 =?utf-8?B?bXN2WG5acHBRL0JGSWlva1Z6RFBoMVVuUERWbXQ0bDB1N3d6bHhvcHFOd3VR?=
 =?utf-8?B?Z3lYNlR1NzgxcCthRFhtbVFRQ2FuaUJNUUV2ckY0Nms2c2tjOGR4Uzd0ZEp0?=
 =?utf-8?B?eEx6M2RPVUpLL0pOeTRKM0hHV0FrTGhHTEFaS1ZKeE9zTkZzQzVNa1hNb25y?=
 =?utf-8?B?V0hNUXlvcDl6YzlZZU42cjc5NGY2ckgwUFZtUzcycHpySnR0T3UwKzhNbnJJ?=
 =?utf-8?B?Rm9NMitVVG5zZ0NLakJ2YUFzUng5QlZtL2FCL0E2NnBBb3dWTjluSVhWUDJE?=
 =?utf-8?B?clRjTVRCTlNKSWF3QnU2MVFRVHRsQ252RWZISFFjRDR3MkY4bmFSa011Ri9F?=
 =?utf-8?B?bHhibE5NVjczT1J4Rm1aMzJSclVJSmJaSHRweE81Nk85eDZaODFwQjBRR0wz?=
 =?utf-8?B?emlyNlA4WXZyNWtPbHdWY0w3eWhCVUZ3RkxxcjBxSks3Q2RuOHNXditDdFFX?=
 =?utf-8?B?UE9oMU4wUE04aGtySUxJVWdIajdkYmVjRVF2Umdsd3AwTXhURG9MOXMxTDlY?=
 =?utf-8?B?TUF3dGR4U3BKMWpTWURpczhjK0hOd1BEdGcrcFRLYkc2TnF3S1U3cUtheWlq?=
 =?utf-8?B?cnpFU1lDS1JFYXJ3aWZLKzY5S01LMWVxZEhLb1NOWlBKYkI4MFp3N0RRdXdS?=
 =?utf-8?B?SkgvRGxlci9pMVp5anQvTzIydXczS0hHaEVXSlYzNG5MNXUzaHJjazNSbTl6?=
 =?utf-8?B?SzdlU2VrQ1Q4a0hyZHN1R0pzOUIySmJ4VjZEaXkwSTNzRThpS1owQjRXS3JQ?=
 =?utf-8?B?cEI3WjNwMUNkbVcycFhTbDhsRzZWeDV2aUw3R1RmTG9UYlhQNDVzMkNyTGk3?=
 =?utf-8?B?eEhWOUF2NndzUThzMklIeHg1T1JPUmg1UXM2bVg2RjdtV1NrTVM4Q21zczNV?=
 =?utf-8?B?aXE1Ry8rMkxVV3BKVGh3RnM2WDNHWFhQVFQ3RjFvWEVnWmkxRWt6WlMzY29S?=
 =?utf-8?B?cTlTa3F0bldHWVNUSHBJcWxFNU91Q0J6ejM5WmtpTEhwWkpMUVlQbnNlM3BX?=
 =?utf-8?B?VEZYbU9SMGRYSTNCN05WNXRkeTFDZEpRZlgwek9nQUIrWTc1M0wxNmhyREJ5?=
 =?utf-8?B?WFBKbDZPTG9yc0I0eDZGamNMUGxNZm9iS1dWYjVqdnhvOXZpbzFaSlM3dnk1?=
 =?utf-8?B?NXNoemNleVFaa3RkblZmWGJJQmlXRkZ0T0hWSXlrQjE5UXdnajNIQT09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0c7644-8901-4c0f-ecee-08df18bc3a56
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:14:43.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+V+ePO8xKI6k7cGsD5iX9I+Ba/1Zj5oDm/FtdTHQaYFLKtIIyzgg5Ck+4PqlD0K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

When used with an offboard transceiver (e.g. an SFP), link state needs
to be measured at the PCS rather than an onboard PHY. Poll the link
state when the PCS is active to allow the kernel to detect link state
changes in this case.

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b8234ac4b602..99e40b0ce804 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1025,6 +1025,7 @@ static int macb_mii_probe(struct net_device *netdev)
 	struct macb *bp = netdev_priv(netdev);
 
 	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
+	bp->phylink_sgmii_pcs.poll = true;
 	bp->phylink_usx_pcs.ops = &macb_phylink_usx_pcs_ops;
 
 	bp->phylink_config.dev = &netdev->dev;
-- 
2.43.0

