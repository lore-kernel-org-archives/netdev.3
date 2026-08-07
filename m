Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020124.outbound.protection.outlook.com [52.101.85.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD341A4F2
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786133887; cv=fail; b=DQCzsSQd6/c0vZ+DhvQY3EvYo269Q4Azn9LUNY2JG9v0zITliniupkMf+grtTX3SF1npv/sJmGH2ul0Y1MfnZPA40fOiH4IzHPq+bmd8BWfiNsaz41fXdy41AZxBSlv5+isnLJCPtLRfIDTIDRM9tiHKa+LMcSoURKwcpcFkLZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786133887; c=relaxed/simple;
	bh=7dyg5QvMUVsYZX2NUOd8GIRdMiONCMkp3qBCMRIe4FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZLbfBh/8wn7R+r2+iuGlxQOBLof8MfbKu8Dn4v5fS/+pk5Tj4Xu/yL4RISCjJZLaT9ihkPafsZ6daQB6cHy9L4KzIqdRmL1c84ClO/TY3kNearQwezcvIKXPgZtkxYvd6wIiSn0PMbOVAAaesL41HVXl5flGKgwfqtuayLciRFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=0c+XEAwJ; arc=fail smtp.client-ip=52.101.85.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="0c+XEAwJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD6uOURfX9TiqtUAT+bNoF9APL0Rtdwk6joofCRoeEYKx29+c9vvYmrMZ6S0VTWP9c9lTdQ7sgsy6qB94/3j5SPtCUNO9/fXmUPwooXWG/I539dgXroLK9jKDSjq+Q68oMEuR0xxflsZHa3ZgxpTt2lLAOqTA7i/SjDfMPWF8GZ+WnMXcnNkQNuhT/L7UEzJNpMr7eSY1Bu9Tm+i8rrINBcf1y+PJ8whiIlBRsQTTDoRc/aQ7pGyvZVVZMGA10cNlwsJFnySi2mYGC/9bXtpDyFDjnFFJzKADeHj7Mu80Db7JEu1COIKY5TopqJEdN3lc59FcYnXqF+dLBJ/m3qlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiY6Mjjc7RrLVSFXaB3eB5rpTdDGLNqxB3YIuP9Itso=;
 b=otUywSAW+OC4nmZTyECNf4lFeTBjvCP1MeZx+uF+JhmPgYTt5bc8aXXbbHjKbgthW5tk5CjOCbTXeOOLH5M+vO65lxTu1rQaF63v6iqoVGg7AVRefD0/hrO2Hh1FC+dPwHR4YB43UsO+47UwnEuvY3/ODz4DY7+puqmTFDSuznFqQ2nTMsM5wGa1Mi05paaDJM+MuWweu2zytpefz6yUn4fZc+qxKL6Buoly9XX6J1MpR1d7v9Vfa9GP+NLiS+f/5k3vmJCBS/cxNK/Srr74eh/waA6uQdNeCTMfYHNP8ozXnQ14rB+4EBJf9Yjk4L/LVs7lnWS+sybAPimfcQgPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiY6Mjjc7RrLVSFXaB3eB5rpTdDGLNqxB3YIuP9Itso=;
 b=0c+XEAwJF1JzbjlVYuoyFE+Gq6OHNRp64RspTUgJFPbMSozDkjGUF40ljC7P2bMzOc0bApRxP7xaAoRa1vBnMcoQc9uXsemx7OtYLCuWST+8IT5RhfISPITgBJrRJx0nStffSZRqxyrwPWUxRUs9o8etyDtEFQmqRVJZqMuTHUQ/OzFUwDRN83bL+V/GgFll/3HBCz8qizj6V4HVDgnmmgp+1lEV0neuGMMNQryD2NJwx5Qu3YheXoA3TYh3nHwU9nmIQzzOn4C5I+H/aKf/5PKcoaJ9uwMlFt+sAzjFVY8iCPVLTJiJ63I3LwJoOY4aQuBAYGlpGCHlt4D+Ta+bVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 20:17:57 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 20:17:57 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH net-next v4 1/2] net: macb: Poll for link state changes when using the internal PCS.
Date: Fri,  7 Aug 2026 16:07:46 -0400
Message-ID: <20260807201741.3275-2-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807201741.3275-1-nwhitehorn@pa.msu.edu>
References: <20260807201741.3275-1-nwhitehorn@pa.msu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:610:b0::15) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 63688a4b-bac4-4d15-4ba9-08def4c0f8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|786006|10070799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b7F7/l9Al6K5BIPC8D4yKMueF/g00TAorYLb6Jm2alnNfmQvBG/4/ug07CPcamZ7+lRw+ZyMrc6Zkkw5nmyi5hz3KUHQAczWf6EPwdUeR+Z3glDHg0btOP3DUIZk2bE5pWzZCaDOpoQzzf0hq2ABbT/PcH2dn0c0zcrajKlqXUq4jBwzPBHb4ufi6uAZQVuC0GV2fmK1jp3w83q75LReZOmyaHwOULd63kNiiA50EUyM0KQAlHkGYIn03ELxgyHF4dnLa1uKvmqRTLGA6Jxx+aJWdsYJ+TTJJ6jf9BrjF8eGi8Dy2cpEbwEjQHFAcn0CRPx3jFiwd5FS05Q+WbvlTfZmnpKs20+4wEcWXdeyRt42oN2ccLjFgvk2C5G6d6YBoNEVi/jBWxM8oC5GvTNkxiw6mf6aXMJt1BGLcVg3RbokxEAvQNQCQ0ZzoaqqOyeRL3XNzSaB5g9r016czxeM8YAeeDzoR2z5EQRm86cK7NxBPueID37DH6l4uHPKpzJxGnwaGZkWk/bEQuFVC4L7WMDiBdCE6lkreUKtWatEU4iMzdrazOknM2Ah1SDKBzNIMCrhOLv0bgYkMW4MsVOC28fdLqMLTXTV/AYygizNqToRZZJnTvxPm2yMQJ6FSv0/Jiu1AA1dBbgKCVdQ1Ot20w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(786006)(10070799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1owN3dXTk9UTWtSWUlRcVN6bFEvSnJBenNCQUxXd2s2ckRObm9obDdqRU82?=
 =?utf-8?B?Y0JIZHpaOHdjamZrSk50M3lPcmJxbGMxM0V5RDFBV09rc25MVHJScnFBRUZM?=
 =?utf-8?B?YnE3enYzWGZpaCtyWjJiR1ZWMVNTOE5Fa3RpK2psY1NxaFZvK25LazNwL3dB?=
 =?utf-8?B?MDREYzVhamZVUitHYTlVT2J1VGNORVMrRVhJS3dUSE05ajc5YU44S3F2YXd2?=
 =?utf-8?B?a2ZnRWx4Zm1tM0dIMHl2Sk40L2NkdS84dHBSbTN1NXJLSE9WZjg3VGVEVTE0?=
 =?utf-8?B?a1E3Q1VEUzcvaXdQa1U3OXZWaU9wQ0g0anVoRWREalAva3Zld2k1dDZVK3ky?=
 =?utf-8?B?Rm05TXhmRGF1TEE2dkNHU2d6NXozdmE4UlF6Y1p2VDRKbGJkdEhBa0tJTm1P?=
 =?utf-8?B?cFE3QVNzNmd3QUZWQVBjc1UwSE1MU204ZW85UXRubzhvSnhHRVdheUtkZDUx?=
 =?utf-8?B?dnRpd3g4M1ZqcDVTbkROQzJuU0prQXpFUkVIVDJ3aUpVNExPL0Y3OGV3K3ZW?=
 =?utf-8?B?akhtZlc0SE9zaWsrTUNrSm0rQTNjN1dEck0vVmkxdGJGR2Z6YmVjbE10K3hW?=
 =?utf-8?B?UG80cG9LVUs5N1o2MkxuTVF1R0xuaFFNOFVJcmVkUlMvM01SOGlYYzU0MEtm?=
 =?utf-8?B?WWRBSzM2YkYrZDZidElvN042UUtvSzEwYjlsenAvd0ZXSHl0NENVbno2Wkta?=
 =?utf-8?B?MVR1T0NIbFZhNHJHWXJOUVNOVnNjYjBDSGNjWjVpdFd5ZGpkUEl6ZXdLa041?=
 =?utf-8?B?elc1d1AzZjNkaUNGaHBHcE56NkRIcnprL3R1UUN6ZXpCTS9DRTJuazhpbnNu?=
 =?utf-8?B?RnNPaUFYeDd5RURQRGhwMnRTdHRsVy9rQk83VlVHU0k4L3hGb3VlT3JmUDVK?=
 =?utf-8?B?by9sV1g2ZkgzQ2h3SGhDOHNkMUZsOHBtcUZiYnMzMzZxWUpqY1VRQS9lTHhV?=
 =?utf-8?B?K1N0OUJqZUZxN2syOEZLNGpndmdXNGVjUWRZMFJPU3FzYm5lbnRZb09CcEhx?=
 =?utf-8?B?ZGtSV3dLZ0N3UnY4WHNQamtZVngwMFJ6NDd0U0M4UllCMGlsK2s2QVFVd2Mr?=
 =?utf-8?B?c1lqN3BQWGtOMTVvSVJYQ24yenhOSEF1RHZEZGo1SlVZNHVmNEpwN2ViZHBy?=
 =?utf-8?B?a1VPTHJrKzF2U1l3Z3JJMHdDb2JSZnYwNm8rUnQvc0htaWlNVS93WEQzSTRv?=
 =?utf-8?B?S2Y3RmdBOGlyb1VJQWtIaWR5S1pDVjhacXVnUnpOamxLV0U2YUdBblQyc2JR?=
 =?utf-8?B?S0dlN05ycDFKdVlvbzNTa2JpbnMvWFdiYjJmaHFtbW5PbnBlQnNvYTdITHZZ?=
 =?utf-8?B?LzVnWnVsUGpURlNrRUxRbDRpajRKa2NZbmVCRVZMaEhvT2FGMUZmV040ZVEy?=
 =?utf-8?B?ak12VGtGQU0yYm5TZG9oN2Nia1JPYTQ2UnFYMGdkeVNFbkVPTXZwdGJJWVNN?=
 =?utf-8?B?aXpXZitIN2Y1QUtxc3RpSzBnaTRLSThPWElUdmVEbHlnemxpWGE1ZHJTQlZZ?=
 =?utf-8?B?WDlpQmJOaWx3UnJ0N3RRRXhjRkp6ZGhOdGoxV0dtY2ZCelo0aU5DZ3duV1Zq?=
 =?utf-8?B?cFp0aG1vT2VjZW5IRE9QeGRSdWQ3QmNYSGNEcGNZSGkvS1VGRGJRNkN2eWZT?=
 =?utf-8?B?QXlzaHlWNExVWktOTjBHRGpwalpCMDdyNCtRZGxRYTV2engrOHI4UGhjeTE2?=
 =?utf-8?B?QVFOSllTY2l6czRNRWJ2VWVWbEFZUGlhNkx0YW84d014azNJWTgzZmJMM09i?=
 =?utf-8?B?ZnVQSEg3WWpEblNzOVFXcWhJMmFLcHY2K3IwaFJla0wzRmxHUlB2RS9YSVRQ?=
 =?utf-8?B?QWUwYlV0Yi9oWmxYc2c2ZGNpakk3UnJYUGxxaEhDcm02TFM1ZFBDUEwvdFlZ?=
 =?utf-8?B?K3JnS0g5YXIzbHVHOXpQVEVqMStKNDNCMlZCRmhUUSsyUHRzdzcvbWRxSUdM?=
 =?utf-8?B?eXZSTWZFQ2VuNFFKR1FWNC9zQ3FtNTdIUUdOVmZFYlE1aXJRY2RtUDZ0cGh5?=
 =?utf-8?B?dXNFdHdlOUxaZVlUcVZlYWtIN20wWldJMGNwcXhOTzFQTkZreEF1SW9RY2lE?=
 =?utf-8?B?MFdya3FzT25uaUlJcW82QUFiWlVPN0NmNTlXRmpRRkNyMHpXVFhXL2cxOHBV?=
 =?utf-8?B?Z3VDNGRxbGppWWxLSklkVDN4dnQvUFpNcUxnVW9FcjVQcitTT2xwd2VabnZu?=
 =?utf-8?B?MzRiMmJOWTU4MW5iL0JSZGRqb0NEQit0cmQySVNZUmtQQUVWSEpYeVJYcFFy?=
 =?utf-8?B?Tk5wemRmaFhFczN0dk53dWw3dElBSHFMZ3RrUG92K1ZGcTFnQ2llYXNTOWQz?=
 =?utf-8?B?R2MrVDhadVBkWkhKczgxbVFCRUhDNzlYWXY3dnlDWVNpTFlyeVNsZz09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 63688a4b-bac4-4d15-4ba9-08def4c0f8a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 20:17:57.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JQOyFsqf0+u11td7DG1FQKk6EfQanpdbfc3ntl48LsY8zYhELdTeJCVkF21p2j6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332

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
index d394f1f43b68..c15a9c7e69d3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1025,6 +1025,7 @@ static int macb_mii_probe(struct net_device *dev)
 	struct macb *bp = netdev_priv(dev);
 
 	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
+	bp->phylink_sgmii_pcs.poll = true;
 	bp->phylink_usx_pcs.ops = &macb_phylink_usx_pcs_ops;
 
 	bp->phylink_config.dev = &dev->dev;
-- 
2.34.1

