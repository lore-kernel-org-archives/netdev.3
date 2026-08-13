Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020095.outbound.protection.outlook.com [52.101.201.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D148C3EF
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635458; cv=fail; b=KBNztIWntvcZtAjvaSUKqcxEgpEJmCgG7B0i0wPhfmFbKd6tugma4WR9nIp+HSbT0qGiM08/ZucauMLujkICEPmIL0RgbcCdtyi3naimLT9mWCNkp9hv/LpsB4a1jlyIo1apcqifXezNKSrRkEu2HqgD8+zyxAYOh4wlMndBk7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635458; c=relaxed/simple;
	bh=TQ1ap8QE57isXzGlmN5N9QdamEjsndFyquH1fGa4N9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FMHjRMzv5kt7EyqeZva93sJkULGWWFJ+q7w+TSaWYF+5TqVyFG2VDiUNbs0aJB50o58DVQ7USfam0B3QbHwKNHlAgRCtPX06EesC1LBgquZeNsJIqqE6DE9X1DwUBKwZxkB8omUOw7wvIZU3V9l8K4Nm0qbtcoZBmrwAH7pNIvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=n3fW5WwN; arc=fail smtp.client-ip=52.101.201.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="n3fW5WwN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iuihe0vLtzfx1HK4/WupuivqTVlssvvc3pP+NXYH+2YkvGoFNOh8QMpvSn+YrsWMDeVBoetEjUbVvaIJ3DleVDdEtWTRDwP3QHROJ85nfuWcegh/0Gz+64XUXZ+gKIK5E9ezYvjql060rePQ03mbUsF733bhyI8zBl9JmtaVAYeCEtqUbYJCxnb2tjMwkue+oQKIAKVqzn6lO4wndMQuVOUC3sq4yihx8SfmXWm0CLARdv5yztkRA+fIxjR0UuRnEp0xD6Sl86cM56HVIQUJfO/Hy1zTa+aPE2YjT3oVB7bgXptkunMG8BjoG3Vshtay/iuzs0df7S/yUtoSm2xV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tErTb07oLaH+UdvGzmBtlILIn6NV+EWGFOJPWrJbSg=;
 b=vTa0nQHz3B5klz3EeKq9TRmQ2tD1I18RJ+exr+wco8tjg09e7aYs05o6ntVj19Um6YkjJHBg0lcRm5rCosPlJkgWpBrewJYPjOGsIjfBlz/L5f+H4slC/A1eI6OvQ6PZjBNE0ULqLKLqTtieSu3kjFZFaKdjkOp7yrl2Apx6/6utuSNAJOcJisJ/NLN2NQpPJuBEldjlAeLz2CWWckIHAcdAi332e/KqjiG6lrhrrmbG3AOowe727qeuPbC9BSG02VQLW1QuS+a73ASfSllRt5ZHSQ3W9r+5ilYtHEYFFwlCHN4/4EtD0NOt5LBk5d05ZnYm0kzYQ/2N5tWr2xX9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tErTb07oLaH+UdvGzmBtlILIn6NV+EWGFOJPWrJbSg=;
 b=n3fW5WwNdoN4eLEoc9xI40+Tgi6DQt4iU2vQSUOfNpmmD3gboSXnwWZ3D/ZiNURuhnRBQyy0Z8XB6m/Ik5bunPmkgFDhb9Hu7T05v6YrxIUV2b46gmNzt87qoc/W3ewT0ltUBCiWIM2GITNFS5slchraIDTSJBeJ5k3t175UFoFSPVFUJc3qRqjwFxmePPmTrZ2AnmYToqx1zH6LVVDwtlZlYHisg56SVRcEuvRF+3fWHwuvD42Dqhz6eW5SDLSsOEN4ezilJl9jykBtuZzA9rKl0QbeWGzF/ejID10kZ6f4OdRQcRm8mLMntIgQauDrUnQrykguBXtoxVc57NfMHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 15:37:18 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 15:37:18 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH net-next v5 1/2] net: macb: Poll for link state changes when using the internal PCS.
Date: Thu, 13 Aug 2026 11:26:09 -0400
Message-ID: <20260813153705.23407-2-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813153705.23407-1-nwhitehorn@pa.msu.edu>
References: <20260813153705.23407-1-nwhitehorn@pa.msu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:610:cc::12) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e51c90-7bc6-4048-8a98-08def950c1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|786006|10070799003|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	FfcA3jjlDevyYVYbifyLhq/rlsPsqgcflSK0XGIgQpC/s++eWs5cEY4F4EwmPi+JGGErOJOPupBdFdObsgsUS2Oh/xR4B0jSD4RYt8++xxmaNHkQHgp9jx5U4sZtH7+R4n/N5ZivcCPOzlYRa5C2iPHQtweRPlxejl5OtUrwfrvKZyIhDPkxfQPCe9HZZAigzjNwODDHwweWqS9TDmJ8d0rYDmfDJpPvPPXuXfSI48z5bmRuBdZouvGlluOywATULxLXR/d4xZRs6TsYqAYGraeAv7hukFaVVoWpV2TkTkeGZyto+JHxyEqi3Bkq2wptjOUmZevPp0xsx7qOHV9vObO+ieBm71YJ9ZbDQ3E7f8TwapWtfS+JrGqpDj/KswWwWTyI1kYmxgWSGKvl4OHR63sp0Jg3j6d3RBvT6RUYUV7G2DmYx95fZ0rmK6yel7TmubNTD/19IpciDjiqdFS1wDcS1TnmkzGPzTKialB3I4kwNwFZCnaZwU81FZI7jx2KkzOFirzIIUsEWnTOcoyY6S1Qj/NgR93+Rvwv2K/uI9geHuTw6fRh59BBa7LZXAE1qJy19mFwNAKcq0kGzS+vuLriD5XMXuKlrU91/HTxOcCkF6fu6rcirTQlAhR/GL77LNRisSl2MaEVX4xz0Q25JQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(786006)(10070799003)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUIrN0tvbWpEQWxsTG5SUUdSY2Zvd2FXTy9kZlI3c1VsaTIzaGFUWEhxQVkv?=
 =?utf-8?B?a0laTUQxYktEdkI2YXZOeHVPS2JKcCtYUGo4Q1ZrUnVMVHlDZ2VwZkhHTFRt?=
 =?utf-8?B?bTZIaWxwbjRvMHpFR3V4bTBteFRrZkhpZEY2T2ZvZzVqb3E0NWg4RExjUksx?=
 =?utf-8?B?TXRSckVFSEJIazlWaDJ1ZlVkenlOUDEvaC9qNjB4cWh3UXVCZHlhb1BNOTVJ?=
 =?utf-8?B?TGhVZ25rbWV2c1dMSmwzellHbE5TWnp5d3QyK0lxS09IQnVCWHZmZzYzQzls?=
 =?utf-8?B?VFhEMlYwTms5U3R6NjZpV041Yzhza1orSVJyQlphcHRVbVkxa3BrTEkvNlZV?=
 =?utf-8?B?eG9UVytYWmZhbTh4eE45WDVjSlRJU1liOVR0UFgrTUxZdERrWHovY1FVVFpa?=
 =?utf-8?B?YXo2K1lqbmJLTVdnRzdTRFJNd29mYkFPK3h2Njg5L1NZaXhWb2JxeUo5ZVpN?=
 =?utf-8?B?WFFsTlZxbXQ3WTJKQ3lWZWFDVkFacHltS2hJb3lUUVY2VTJna1NPa2lJTmJO?=
 =?utf-8?B?dkdjYktuV1BURVpUdzVaL2tnZXQzcFM1L1dvTUdsRE5ucHhDcnNHOW1FKzdw?=
 =?utf-8?B?QTBDTTVpUzB3di9uTW1LZDZWV3h3OGxRQko1ZzJQbStrK0VsUTZxcWw2TTVm?=
 =?utf-8?B?ZDMwZ2U2UmF2TGZvakpaSDI2bWxPcng4SDE4ZGI4eXFMajFFbmpyUlUrQ3p1?=
 =?utf-8?B?Um9hM0tPZHBON0Y2NjR2Q3B3VmJxcjRoNy8wQjhLVmVneTgwTmJLNExwU1NB?=
 =?utf-8?B?di9keHZmMmNvcHNkaVYvQ21Ea1A2T20yL1VmeUYrRXAyRnBhNVI1dG9QcnNx?=
 =?utf-8?B?RE8xMG1NcGI4a3UvYkI2MURvTkVaaEdHSXN2WDFVb2pSTEU5T0Z2TXo3Vjgw?=
 =?utf-8?B?bDRXZnhWM0RiOFM3cm9KMGoxd2ZRSzRFZ3hnSWlsRHBuUUdLU2tIS0FVblk3?=
 =?utf-8?B?cCtTRFVlZUNmSW1ZeTNXRW5rZTFnb0JOSHErakJyL29BUFBxM2FHMUxSc0FZ?=
 =?utf-8?B?TXZISS9iSThXUzVCZEFGNTk3bFBxQTIrWDZsenBwQTQzaFhaeW10cFdvZUVw?=
 =?utf-8?B?ZUpGQUFSczIyMnZSVEpmelovQ0hFWHhwYkxGcTFyOFVtS3p0SC9IMWM3a05q?=
 =?utf-8?B?MmxNWGpmdVFQenJSOVlFSjNHdmlDUjJNNkVLamxGbmRiQjVUbXR5eEpCWWxF?=
 =?utf-8?B?VjFObU5oWERXZzFvM1FZUmtTYWhkZXdQTDhwZ2ZzT2d3OFI0Vk43WWF1dG83?=
 =?utf-8?B?QlBxbGhtd3hoY3g0UitONGJPM3lVR1U1RWpCbGFHL09RNFp5WTNSNXFoV1Bj?=
 =?utf-8?B?QjQzR1FnNkZHbTNNbFAzWVd6VVc1eFQvOUZYWitmVnV6ZU93cWJMeVFVNHdY?=
 =?utf-8?B?ekVtYkJGZkwwY0p6L0RYMlJEZ2kyMVJRd3IzY2xJZ3VOamhEUUlKdUxxSUxT?=
 =?utf-8?B?bDc5bzFsanh1NUwrcHNVdEpCNHp4U09TQmVJWlVKY2RhTmxrSHNtVWVIc2J2?=
 =?utf-8?B?aFMvQ2pYenBnYmNtZHhRYWNwcGV6TTVmUmk0WWtQbkp4TlVVTlp2T2p5UzZ0?=
 =?utf-8?B?a09iZDRaMitpRlUzWmUybGs0RjFPdVhPMnBsaS9YRXNBcEdSZTh3V0xITFFK?=
 =?utf-8?B?QlNuSDc4Zzh5VTdHQ0pYdW04REM3cXB1K0tLSTJML0Q5WUt2akdEdERCSExk?=
 =?utf-8?B?elRGSy9sZUZqUzJYL0NVRUh0RTdOVHNOL3piWkVyOHVoTmpwTEZUREpidnVH?=
 =?utf-8?B?UmRzSk91QW1CQ1R5NDgyNTFVaGxqdnp6ZkhXeFlWQytNd0xBem1qcWVnUnM1?=
 =?utf-8?B?RTcrNTFMNTdhZFdzMkMwZ0ZvYzYxeE9MRnlPS3Y5ZG9BVGRsSWFUbDBZWG5L?=
 =?utf-8?B?ay9zWWtVeWNYWk5WNjhVWVd6NXlNQ2lJM1d1YWt6cEJBTWRZSTl4RS9oRVpj?=
 =?utf-8?B?ZHc5Umt5RzBRbnZ3enp2bWdzcllNU1NLU1NJTENCVGhJaUZVNC9jYUFNTk9k?=
 =?utf-8?B?QWwyTXNYK2F1djZsb0Y0N000VHAyd2tkNDhwdkxlV3hhY0lSK09QL0pUTVV6?=
 =?utf-8?B?QnIrUWh5eWxVR2ltOVhJbDZ5a0FBNG5aMmd6Q0dsdk94M1pQc3Jva3M0b0RE?=
 =?utf-8?B?WlFjMkFuMFUrY25VQVEyTGpjdUw5Qml3aWpLY25ya0VnV1RsR3ZqTnltaFht?=
 =?utf-8?B?SHBoZUVnaUxPd1ZiVS93L1k5dlRVZWpxM0M2b2t2N01OSi80YUtKMDNCU0k3?=
 =?utf-8?B?c205ZjFjWVVVZGU5bGp2ZGI2MHlaZHhLcjFBdDFoQzFjZHdIN1VqYkxUQjJl?=
 =?utf-8?B?Ukp6VmtNZzFJRnNlNllKK3RUZC94c3pwbkhkREJxNjlkN29xSkZ1QT09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e51c90-7bc6-4048-8a98-08def950c1bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:37:17.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3bnIjfAbUPc8H+zbZGWZWvEPRg5ullzyak69/X+yFF+5qf+91iOwL49f8yMIG2h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

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
2.43.0

