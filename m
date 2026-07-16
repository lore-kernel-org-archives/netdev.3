Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF91DED42
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184420; cv=fail; b=qNnZmur3SrowcATto+EsZKILWHuGfihIGN+8qWGo7vywRJ8QMCoTrn4/TimEf770oF3+EWVFwoN51z3hEJDGLk1eksOZFCdmHMZxzZwGOu7pQXZFcb0OeaFC/LMluSKE7bcApQ2Y9DUbbSwM/kXBXRr1BbMDLY0k1Ei2ku10hJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184420; c=relaxed/simple;
	bh=i7T4Pht+li/UmQVwBp/06dlbOG9/DHrg5XxZnG+U8II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DoGlMB9PTu/kQS7NtaW9pzwJMzUxQFFU9ZlyDnMhYaSQnu5E7qoAW36+EaxMW6brsrU7ReqiDMScGybVvvOxapZjOV5tsp5WPkxBcXh+ARxqvnnIEpn4YZMUqKwvCOZ/IDUJ8KCdpI1qH4Rj82By4iNg455eOEjTkVbhaen85hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hrIvmQ11; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hrIvmQ11"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocbDqDJqFdCrMYf4ElV6mSGwQY4lS9ldPic3v6K0wyRdXh1IS+DidPMikHCBrUXG7cgKsUCqPF59SQaebAfP5Vw34d486yPMIqqr2VtRrOqFHVaHeekgrND9WGDfKj4ZFXp6zDibBAyCW91dqP9nubuE74Y7l50wm0dXAEiQ7Zcw3rW8waxsehv0jE/kwLKfYlS3IeAeomCOx8XttIVnZe/Oh6PRSgQFZ4EVOU5qqRhH45a9sH7lUmycKQS77mw2kTcpturcQgaV/itSYdAUjwIxhKngJAebLLgm4pSI2FQlUXsSsRu1Eho/W4I1qcZOpTxCZJCp5xWjedlW6Lkhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE3FSy0H39QkfRNeLtygqAteTR5WMvUSUEBIQ71V3wg=;
 b=u0y0vbhyibigBpmFRS3q4h/1cqn5l0Mb7vhjMVZ16jfJ4fgfz/hyaxdKhuPz9GuBY995scxd1ohTB8b05mm9xFje0BEaDzYBMpYQpOE+SBTUS0RWW7Ftf6u0JT6jO1/oQib9hQIpLJNhdgFcYnGLkY9oKclv8+dkqTtu1VgaYKhCcUp+HjHMrqSWgpwacjKgE4dGg3kbNTuFbdNHlT2Qbps/TLBzeQC5F0D0IEejBahGqEeAdSU1YTYmhrO4ujGVB+Q6Ijv2Uwk9dCwzdnNyMHY7EWkI3zUWudehwjeXa/p2EXJv92/k7UBZXZzN+WdYBc4FjJHbshrByxN8aOag+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE3FSy0H39QkfRNeLtygqAteTR5WMvUSUEBIQ71V3wg=;
 b=hrIvmQ11hHzMtberaFjNDcmkFczK4kz6o6ntQWNFf9VZx71ZBZVabhbEzXxf15cLNqvkP0UX3iUxWT3JLsWLmPWcv7+LlzFFOwVpO6UZiU8RUz36UUA5mkrFUVTMTP03wNMXYZoer4wojgchMx3rpQ8vEHeYDbepXeUOn7lZc/3VkFQ18wnYYouF7LX3MpVXyyfNTUVwHNZVwJQGLbwHiI1/YR1iuRJegt2NRvnkCOStyHfuWexKtgml4NfSZ2QpG5sWprRCP0/k/TQAej8wgWrRqMdCJPgFUpJPZZKG6rL8fTWok5Nn5LtsHOaeOrquRBwY/lNjcHcWcqXLay9Pqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:46:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 06:46:56 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	danieller@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH ethtool 1/8] cmis: Fix printing of Tx bias current
Date: Thu, 16 Jul 2026 09:45:25 +0300
Message-ID: <20260716064532.1522382-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716064532.1522382-1-idosch@nvidia.com>
References: <20260716064532.1522382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0427.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: cca0df68-4aec-4358-5ab3-08dee3060704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ILkJ1I5swCSUD7eLwSDqlBktfrRMHbM3nyINR+5eP4E1AyuMNzzpcUjvrlme1M+Kd5d+ADcnGA3GbVNYUyEeF0N3c0/CVBDcJ+dbQNvwD/OvwP9QwmYM/eV6Jz8YuTQFCxUpidgI8VwGW6NBZx62pGoMlmh2C6CFH0Pt3xyII18p3UVDlxYjc1T8pWFl5QWR2yDIbn9Zj04nRPJNLMxrNTahhutGuzR6CiQea7xnkpogOhx/5WS4yBoFTkW8RdAdUd0NeXeUBUqRFKsVVoUs9I76I1L60LB6RS5hxTZ/0LsikGd6eJalAfiMYpHoXBDhBRq633nDIZPNydIZnSJWmNhs/duU6aLxC4kCyytedeyYobo63ZhUF2ImlVfuGkhgKOol8s5NEc65NomYBsh1IaAs8hOQBY+Qu1ax5DnrjmwaHRyxC+/xeFyj7Hd3Zfxts7P/2kqxV+/PGGuYdaDIYbSmq40hEluxgSYSYRHTQxQjfM4RZ3LfxQsN1aiSDtbl9vItELzAHN8F3M2hm7qbgbwsE4NfCFDoPD1UgYDTZ5nRsJEeQt2+58UUbzHi3Wngy840iPSOJYp0RcEM14CWHRCOMAYW3e8ItXC/jxWod0eqpl920elFGQo8DVgTAfNI5jsC08FAbb087k0u5eiDxBr6dUje6MqCGHqSB/XaTR8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vft5Qlt/IsbbttrD/ATJo9m0cr6S18bQd/x7n8vxWtLw/ALgBl9qSvNTH03y?=
 =?us-ascii?Q?FSNrfsFIzShY4myuD4gaqoYHfFf3XcBdcst+63F5pwJY+M9faxtNDYFvAmDv?=
 =?us-ascii?Q?Lau5bzShXNW+yT0G9UUPUgsEOu7SQHnB/lJTqKkjrvOK5A931hN7Sgxk7diU?=
 =?us-ascii?Q?DZ1PlIfnh/Ig0hsNGSss6KjEc3izWs2A0KcYh92KzU5ZveepyTw/tPMJcObc?=
 =?us-ascii?Q?QAPxfIVWXOHjimKIibVyN66p2Z4zPv8r96WxOibFxMrdSrJP67ARESALXIdF?=
 =?us-ascii?Q?kP0PgSt0jdGcisEj3GJn8Ly+Pl3Bf+d6pMdnWsExV7Af+Cf/0Z4M7xqisY4M?=
 =?us-ascii?Q?VRAqbeR9QU63TdnDtg9mTq/XTWqKxnr9O3eOHOE379DXzjT8IhLgiNnWGK+0?=
 =?us-ascii?Q?JVlyopm22zNUK0N30pmswPLwelRfyBhTlQLnODThNPBnJpbAdlfHwqElIcxq?=
 =?us-ascii?Q?6pyaDp83tfTiDUWk8EJtRtdtX7fhtUGupk0KEdyYY1vlKFmUvZhJzL8Ue9Tu?=
 =?us-ascii?Q?Z6TQbatx8asM4mFL3Y2FL7MszPO/O6qpb+P7c4kmz8WC5ce9CtzbRSnfVyvG?=
 =?us-ascii?Q?veO+/mIhtsYXH0m3kTE8buPP04SnnQncIidMGq1gG2nxnx8xAOa3uJlhY62O?=
 =?us-ascii?Q?j44CBfjfnTeSEB1Rv54Y0lpvjtUxjAxdcMo1NT39olj1bSC7ieqd7ApMp5ux?=
 =?us-ascii?Q?O1I+3++V9TZ2ngieRf7f+40IgUKpREqkMCfegOdOnQlSa9KZnxmAcvePP+YE?=
 =?us-ascii?Q?BThoW8UVllrv4FbCgQoiwYATcy7xK3HTb855lgwVmqsxIdpSj+QjorMCi0OW?=
 =?us-ascii?Q?KwRQjp1YthO2k/uMbwmxSi80YstOUDEK8yS05ta8xiwx4DmzSS3LDgDkLur2?=
 =?us-ascii?Q?+ZYXAHn94j6ITGih5zcEaanQ9PCv5yENtzmQz7+M3tf+3tZcl8oXioc6wMyu?=
 =?us-ascii?Q?ceM0w62XsF+50qEswj0e3GgCw8AfbopuM3Z0rKc6Zewa+MffPchaHPvlIJFC?=
 =?us-ascii?Q?/l3XRWFVE7KtcfdW4P9EcKz5Kqmw3gws5DNwMFj0Kc0iczgCXnTGvEMHiHpF?=
 =?us-ascii?Q?smLR5INUMSDZCCpDINrgqq19mJTcUdFnXebKNsC+Ti3lNMBHensNnM+a3tHJ?=
 =?us-ascii?Q?40LHBitE//hoyBCJU5OwkJHOUKsQPSbER5nGnUjR/Lovo0hZgFuQqQ6c2hLi?=
 =?us-ascii?Q?0oKT00oGpwI/C56onu+2b9PmAJsDRTWXuoOo9Ys2LspoON/ZAhfy2k4R0gJl?=
 =?us-ascii?Q?AFaXYrF4hazgIA6WBGAtjSuEsAUJTNFFLOmCUIkff/x9ZpTnDceQsKxXZLRd?=
 =?us-ascii?Q?kpiXnJutqRQ+uZ0J3xQE4yRXm/Vzm6RIDzEUidXs+kVLG9SlCJbuWqzQIM2Q?=
 =?us-ascii?Q?NOZUNMt6hp6a9BdPjGVYIOIvS1CcBcUiEKoYR3CFhY8KWhozDZ+MUUhCSnT1?=
 =?us-ascii?Q?NRUCV1KcF8FvrSuqyTy8PLmv4XPLSZNxJc04rjX2nYMo+9CkLymMWGSEFfRG?=
 =?us-ascii?Q?QIV0C3vvpyiyPn9rqRSBCrhwxezlzDNEdPLIB7CYSyU3FGimxQw7xqPijPru?=
 =?us-ascii?Q?HsjQ571NPtZTfs4iiZiBI739MOEWBiWoxxRF89ISSipMGWcKGRQz+ZghMBw6?=
 =?us-ascii?Q?NTj+j3/hgUXSr0KYhbYEN7F2x5hScVnNbb5EfnkPF4Ixbm07BvzcqXkg6T3v?=
 =?us-ascii?Q?0YHv692p1x/UPuQH2cC5rrmwvSKkz5SYV1x9u8nYdQtvqaY2sRVH5IBVWZzU?=
 =?us-ascii?Q?NCmAZb2Jig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca0df68-4aec-4358-5ab3-08dee3060704
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:46:56.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ya0Z9HMK7GkcS/4UtISgWJJETxAFGMlE8X5w+OAS/DyDrW/d1uL1eZgcMHTRxjj4XsmFyEyTFB34xzyxNU060w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299

In CMIS, unlike SFF-8636 and SFF-8472, the Tx bias current can be scaled
(i.e., multiplied by 1 / 2 / 4). Fix the application of the scaling
factor from shift right to shift left. In addition, increase the size of
the field that stores the scaled value from 16-bits to 32-bits to avoid
truncation.

Fixes: 340d88ee1289 ("cmis: Parse and print diagnostic information")
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 cmis.c       | 10 +++++-----
 sff-common.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/cmis.c b/cmis.c
index f494268ba3b7..a4bf455c2a77 100644
--- a/cmis.c
+++ b/cmis.c
@@ -517,7 +517,7 @@ cmis_parse_dom_chan_lvl_monitors_bank(const struct cmis_memory_map *map,
 
 		sd->scd[chan].bias_cur = OFFSET_TO_U16_PTR(page_11h,
 							   tx_bias_offset);
-		sd->scd[chan].bias_cur >>= bias_mul;
+		sd->scd[chan].bias_cur <<= bias_mul;
 		sd->scd[chan].rx_power = OFFSET_TO_U16_PTR(page_11h,
 							   rx_power_offset);
 		sd->scd[chan].tx_power = OFFSET_TO_U16_PTR(page_11h,
@@ -544,16 +544,16 @@ static void cmis_parse_dom_chan_lvl_thresh(const struct cmis_memory_map *map,
 
 	sd->bias_cur[HALRM] = OFFSET_TO_U16_PTR(map->page_02h,
 						CMIS_TX_BIAS_HALRM_OFFSET);
-	sd->bias_cur[HALRM] >>= bias_mul;
+	sd->bias_cur[HALRM] <<= bias_mul;
 	sd->bias_cur[LALRM] = OFFSET_TO_U16_PTR(map->page_02h,
 						CMIS_TX_BIAS_LALRM_OFFSET);
-	sd->bias_cur[LALRM] >>= bias_mul;
+	sd->bias_cur[LALRM] <<= bias_mul;
 	sd->bias_cur[HWARN] = OFFSET_TO_U16_PTR(map->page_02h,
 						CMIS_TX_BIAS_HWARN_OFFSET);
-	sd->bias_cur[HWARN] >>= bias_mul;
+	sd->bias_cur[HWARN] <<= bias_mul;
 	sd->bias_cur[LWARN] = OFFSET_TO_U16_PTR(map->page_02h,
 						CMIS_TX_BIAS_LWARN_OFFSET);
-	sd->bias_cur[LWARN] >>= bias_mul;
+	sd->bias_cur[LWARN] <<= bias_mul;
 
 	sd->tx_power[HALRM] = OFFSET_TO_U16_PTR(map->page_02h,
 						CMIS_TX_PWR_HALRM_OFFSET);
diff --git a/sff-common.h b/sff-common.h
index 3c02a69ec7f6..59ae21038c9c 100644
--- a/sff-common.h
+++ b/sff-common.h
@@ -126,7 +126,7 @@
 
 /* Channel Monitoring Fields */
 struct sff_channel_diags {
-	__u16 bias_cur;      /* Measured bias current in 2uA units */
+	__u32 bias_cur;      /* Measured bias current in 2uA units */
 	__u16 rx_power;      /* Measured RX Power */
 	__u16 tx_power;      /* Measured TX Power */
 };
@@ -157,7 +157,7 @@ struct sff_diags {
 	/* SFP Temp in 16-bit signed 1/256 Celcius */
 	__s16 sfp_temp[5];
 	/* Measured bias current in 2uA units */
-	__u16 bias_cur[5];
+	__u32 bias_cur[5];
 	/* Measured TX Power */
 	__u16 tx_power[5];
 	/* Measured RX Power */
-- 
2.55.0

