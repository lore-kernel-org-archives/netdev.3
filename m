Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020113.outbound.protection.outlook.com [52.101.193.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AA46EC88
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656933; cv=fail; b=uZ3Bm0Hjw68HUkxOAU9KElfsJTt5687iFUHhcd/q9t0ZKzWQl4MpdgFQNCEOBFlIAfVLMfOKrcpZDJRq5ku6q9zOJ+EU6EYrDBo23K+aXE5v3WWFLV6WHpCjKRAjtbaeZtceD0tq1DqdYdj21ZaQ0m9AZWe9lNrvhTl66/Pl9c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656933; c=relaxed/simple;
	bh=pV39M/8kv/YPn0dTVkYeIJjYAgBKfqkfrk+XGmnEekQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GMfqXZYqVKBxJI9BobqViUtRel9VGl4tpQqiNxhYQjwduOnTOmuwxxqCjYdPSniI6/10Ce56U9Y5bsGl3LHVry4fXUtdYP2Z+hC60akZEqfk4ss+3HS+qW8ldWt+5Fxj3KTjCKe7K6LHeidIsT2lnKJhyzUN0fegpWWTJ7S+YbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=Cgo2gq2N; arc=fail smtp.client-ip=52.101.193.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="Cgo2gq2N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c05RzDdCoKJnErg7zvLXwwp0Ihh5FZmbEnGldQqJAssOh72tc5KB2vlwnjnJOLSscK0nObA62r+BsmpGHeEa7Rs5/UDIRl94l8DPNTcRsO+MvdHZjmdHDRNszoqdLnbPqgaflvaViz43aZ6uVQFZfupBm/I2CIWzCsAjZKvDvJbd2L3Q94OEBBuUHdUIWilhZO+4f4Xbu5R50T3Br3I8pnP3VaLOkP+gBdAEIB38Ypwzho3FR18FGf7lejB/PEjkgO/lLSlQ/36nPZXTWUoQ2Bl9dLMMcUio/gJYUGcpu/3BeYmLeDczdDTIYWarSaMYPFXWDVnZ7U/o4Go1EEoxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5Dwe/Z5ukgUMO7PZRd2jR0yO7Ca7prxuXB1MSVwY+c=;
 b=f0tlzrOTZ7XU514n6Cw4CwkBBAJWqSdyktGe+LB8W1mg9QW/kR5+PmrjoRV6TE02v2n9/xTCg64R4OaA0ML2i3VoUdfPXyPg6kQ51/GT3yfHjwSvfVg1mPaCSy5njnV6G754MfXnEu4wO8x1Yc4w1uU+6ctHRD3kN1oWXcPFpFVQpbtyARsMKH5V422ALuKDd8dVJe7t9HTE7SJ+fwCBlefG21dtrGlyKyBeCTmHLIzmY7ZQ9LqUkgP30SxbW+68A7DT2BZXFRJiVwBKlj25d0jJ65iHPW0vZU+HKkXroKJW44gavXARv4ZoQgzR2VcY894v/u5D/j0FLt6D+ELyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5Dwe/Z5ukgUMO7PZRd2jR0yO7Ca7prxuXB1MSVwY+c=;
 b=Cgo2gq2NUEiqSpzclC5DsD/3z+h5yh99yKcQGpFdtzxX3dzOnogzqaDvTwwaAHyNJK36mmkzztUMTH4AiQZmtvndfax0YtrIaxgqFBRIjcws9UfDgmt5NiAotGWHKQIwr1yIBahMDzI4Uivcdbz2JYrn7iVgDCnVxeuTL46V3qP06+e4AA6RRhwdP7VSQ2Jzs33IRhx9EMMQdjOPMT8Rhn4yTX0F2We1r4hyQjr7ndtSrpES77Go1rwEVXnrrOLNR8Hpf8EwUVoObOHBhL4Rip7L4bA4hvXWd7wmYD+l82FRDj9rT5wfmluVm0RJrfLfuG3wH/4LpiK1HyS3eZk91g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 18:02:09 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 18:02:09 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH net-next v2 1/2] net: macb: Poll for link state changes when using the internal PCS.
Date: Tue, 21 Jul 2026 13:56:01 -0400
Message-ID: <20260721180158.13014-2-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721180158.13014-1-nwhitehorn@pa.msu.edu>
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
 <20260721180158.13014-1-nwhitehorn@pa.msu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:610:11a::31) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 286d8184-b97d-4331-f07a-08dee7522eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|786006|376014|1800799024|10070799003|366016|10067099003|4143699003|56012099006|11063799006|10063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TqX1TmmIEUKzKdrB9Lv6TzOQhC6j0ucU9PSRStX9l0J4bYefWVw6EVM7DkPkSLGTot5pce41YsMuewUSLO3+nXpv3WfUsQ2yt97k69bQkp9RJWe85KimX4o1Px3F2Bwo4v/2Hfmkk8D3gyQ6UqT3RW4ymS98/i1ufyIE6zi0PaD+hBcBvMztm4vM/a3CYglGofwGmNjoB4HJgYxQiLadsT5ZSodFJj462AO1Cn7Zw3XtCvzGBSPRNuUFoSwGkI8fThaHTiFDSSwR9LAVmajY/I8+nkQpUWbWjrAf/UDBrDHlkQw7RWLJ9ApUPhvhlMlWALh6Sa/W0WD8PMK4aR1dFs6+yPeQWMainDd71YKh+HQlZvnOAU3H+axjbVJ95/jxuO4Q9oByv++kBhYLeagLh6C0ohGIjNSB9cIRJezQ4UdWwPPAguZrOLdBReK8JwXkP1J+WfNkUFwHazTJ/Tfx8Wtgb1R1ZuwExeJWG6Kv2btDW+SQGifxcOL+YHO1hgrSdJiAAuYqWAofKKf5w1d+OlxcbiKf9gRGDXliUrKC2ZlGCLFbUqobdwQUtUugV73rChkt1G31qFUb5SXF4jwJw2LsfFny4hU6jBlpljoPCBbPwz/NdhR0rDUwwzKAN+G52hO+EVayCbPdl05MDKY7Pw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(786006)(376014)(1800799024)(10070799003)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(10063799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zMXrWsYouZtgf+cy+U6Y0DSa837R1oXVrumDwZwKo+mm8ol0hFpQFhZdgQ8N?=
 =?us-ascii?Q?7NXKsrUuCJpdqvMBa+gAjwuOe73XRiIPtOkSceaSI+bsWTDif4WPtAnQzSLq?=
 =?us-ascii?Q?3fpw75Efbt33aWNcznp2uVy0Wg0CFdG1sEV2EoRGHMCvkDNlEQsMn9PBr+Et?=
 =?us-ascii?Q?Rt95/3M5wj68x/6F7/w2FIPexuDbfPdNMMMzWgcdUVCZglkJFGSHZHKEmFS+?=
 =?us-ascii?Q?Bj1m5Ej/q20ciTOaI8vxajypMQTr6Lr4P+p6r6MUbU49eEVkWnu1eKXJnM0D?=
 =?us-ascii?Q?XOmRXFyuLvg8sHINDYoXR74UUALvNDz3Rc05RLRbb/jvUtEP7lHP8MFzuDtR?=
 =?us-ascii?Q?OQpzfXAOOz1Pa1nDLqqYfZSflMb6pU9gQmoiZ04AQ2HowdDcPAH/0/a2tU+U?=
 =?us-ascii?Q?65hy5dVme9G0vDuZFxsbFcd/HL/s1FbG6RNoqxVkiNzBivE9HWRty1soLEaF?=
 =?us-ascii?Q?sjoQjT4Jtx5ofCPbNhM/OwqpITVQPD6P7S1VnGUziSy1TATw8JYBSNjmyb0K?=
 =?us-ascii?Q?Jl6TKgsGCZVwD6hGzfO129qs4xPN8lawOJ9PtTyo96NbxnQBNk72GRJUiw+o?=
 =?us-ascii?Q?AmtpvRwUnYVs/Qw6deXj3sPdDF4gCdFhaWNYmb2+ID2EMzaGqGF1qpe3BmUb?=
 =?us-ascii?Q?GaM6EskfMJR7lVAxmNBLSjvH3Q7er8r8viRxZI9f9hcVNGKfegg3GLBp7NSc?=
 =?us-ascii?Q?8enj4NeiKvU/moBpXDIYOpMm+oBrV3JjViZf/RLcpZ9lW8XnylEUWr0rvsYn?=
 =?us-ascii?Q?81wng7L0GgELBfvoMprUWwV/U1WJOO7dDkip9hc178ZJ2tCR8tDPTfTYVtG2?=
 =?us-ascii?Q?wbMVAkA7a5RI3aabt3PBOsLnBtJ+DtaEKUnB7i5Scz7qxYcmkgFHEFIv2GRy?=
 =?us-ascii?Q?aDcNdrHXzdTc/wRIVW4vkYMQvFGKg7fetyI1YhP0DICaSXbyA3cDxb5sskxl?=
 =?us-ascii?Q?f5Ru5+kOGH81uTShVCo4rGCKMtHPxTxiyqNL00ruR9KjHaiTLrqaiqudPX73?=
 =?us-ascii?Q?lOsim05hRHuUWyCVh+Rm5L02a4lIvpqKuJAml+xdwx8YKjbiQSvntIFPm5RR?=
 =?us-ascii?Q?HWtSy7yO9ARU7UjsRPJ9dbgf3xlgTb8bhaF+2VTLhhlc27qbj2Eiccrwam4S?=
 =?us-ascii?Q?Wc2IzhI1UOrteBImdUWaq7tqI/p/OED9gvcDDiOyFibBfyU0KmKq6MiPDPAy?=
 =?us-ascii?Q?J28avPVj6qHJZLKHmfruuiR+3hKkFcVa55EcWYLPPQ2F0kL/YsrtGWGRXelA?=
 =?us-ascii?Q?TUrSNjzweR9dSyHviav+M4I78EfxMD2G1EPW6oP7Mkb136QtgvBE34EJfTMX?=
 =?us-ascii?Q?Y42yuqF/IGfSFYJULTIZK90d/gKFpjZJax+ADySgDkCWRVEQgXnqXrzqxa69?=
 =?us-ascii?Q?frl3NPrbYWXhgEccjMqsAicia2HYesfkQ9aMS4MCASJ0ANKl0XipOC25Q/IV?=
 =?us-ascii?Q?QnHOREe66t5bsAr2CKIRmcc+qzoGwFPFe/4kXDWdAgu61SWE1z5UBdIk9oFK?=
 =?us-ascii?Q?1R2Q7yB1VeUWxy9BRajw7eLIwS8WHh+p8pvxogTBo6veIMYGsR/GQGjjsYar?=
 =?us-ascii?Q?r8pi6CLxBf15LV9b/ykxAC9G25xkoANTbz4fw2a+FopApdkeyjuv2dkc05f8?=
 =?us-ascii?Q?W2ra1nrRFHbgdl+d/9lLDzg5di5FwWkWsy28xGoD9RFzjVPpuAOHtr6B8rzG?=
 =?us-ascii?Q?HQMDlOLdTvwCyQsd6m2Uz5veU4L8MVaOLbxrZZcrSGtapoe8ed0eXuXHw265?=
 =?us-ascii?Q?SRLvyk3YDw=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 286d8184-b97d-4331-f07a-08dee7522eee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:02:09.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5ePgD2U7TN9LdabAnQkzpzh7H8BNpsGFO2nl6Dxb1buW0MmWOuKCXCA+TMuLRDZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295

There is current support for signalling to software when this changes
via an interrupt etc., so poll once per second. This is required when
there is no external PHY (including an SGMII-attached PHY) to convey
link state information to the MAC.

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
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
2.54.0

