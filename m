Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D3344031
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184452; cv=fail; b=TmvIj5DnfOMe1UQ8QbeGdssAVCnYq/6Qo1wldkgT4VN3yf2HtCti96Ez7bUODpHzOceNEtUpNt1SonVFe0LUaAwIpy+lEPrO4lihy/XFDwdvouaWHEEVK7MPx+V2w1J0l/HoPKkgtH5PLvqgPnrN3Ippx6PGvktvIw8i7FFt/4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184452; c=relaxed/simple;
	bh=HJwZcIOL614aGDCjkJrNv0YA80Gi9+GrGs8ij/qXC7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+QA+8sPXuIfU2G4GCq64IC4xSrOqEx8PiHnmi8CCdfgO93coYWvuQfduYv383BQWbD/YOwoKpg4+d5xAxramT90bgnLbvwwGQz3p+GnDgSFmZwH/Q3bjxs94oar5kQ4OMucn6RebuNTZzMdxMpAqJX19pC5knZd5pQqGtkTTQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SEZQ/fDP; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SEZQ/fDP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8nrdTItlB/YMigVgJk8AQ4ImlvsaTSftrc0DiA01yES6j1ApnL1b+o0EW6O2Ot1A9YFak4g0BMsmOiYAlnp9PMLP6jeFUPRtdD1QHcPHu8ewY+iVrgS2XZaPRaXpgc0qQntfHXjGKiHnfe67MhSW1XhUyq9ECL5pfPCYzIXavQc2IPR3zSk544p3n2c7T8wpNYUQNcz1q0wAKsldgUVmxbc4L24h/XYzQg7pSL+BFTrQkKEuxGqw0if20q+DzfIiKDZm2MNIq6qHrSbm//qifm8eUPhZQOlQHwAqTlYBb1nK77ecSTWGg7OA0qioBVylyPtvADI4ud+z/aXy4RBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fU7DQFWTDWXgyY1IfCYp9MxhqxEn68O5vqLkzWy68Zw=;
 b=G51Y/A1bkdUD+mucnVKAa9crhQZE6IkCsrZpZBGd5QkNMIrrp1pF6KUjfEX7T/My8M0HkRteBn9CFK8bI/GqHY6Z8DA51E3NHsRFOqfe/vymggvR6SHv0gNIePk4rAV+s3PxK0euR/57udaaIq4LM9BnxORV6h2Qtj4pP49FbcTW1mYAEIAWzXFGRKaOJWuUX5O98FZidFB+XQFRQ7zQJ4XHr5QtHPr0IJ8gPUoOI+icMSZJ6D8NJnbpx8gQIZJiKvxoHEY86Eo9X/U9/N+ABTuDrsGypPZIsXFuQKiRZyezRCV21En/qpd2CaTabHX1dxfTYU5uI2xLLxu1C+c9IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU7DQFWTDWXgyY1IfCYp9MxhqxEn68O5vqLkzWy68Zw=;
 b=SEZQ/fDPyOpttNYsJSZzuRMc7fOxXLiktgHNd0usqiSRX2xu7UNizJplYCF/DEpWd8qE1FM8hrzhkvcAOO+F0077elIN6GnzHKN4TPpXDFk0VGWtQXHRT2UyWJ/FXbWsPfMaAHNaQkkCbBXgrHq4B+Cbg1Nuk5KYRwCJuaBADnRFPSSHWxkuWqDDs+ERouhGsjUTMNAp9MYk6u9l61oA4QnfL5iC/QzQOefhtkgd9z5zrabHoNIA3dfzIV8ylM095qSkR8NRYCB+NOGp2sQ+pSiXA7Ov4Ge3RxS3UVJkgCzYrpzYf0kk07a9TFHCCGy11r+ustwkVBLPLL0/dVwbnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:47:23 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 06:47:20 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	danieller@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH ethtool 3/8] cmis: Fix printing of CDB EPL pages
Date: Thu, 16 Jul 2026 09:45:27 +0300
Message-ID: <20260716064532.1522382-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716064532.1522382-1-idosch@nvidia.com>
References: <20260716064532.1522382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: fc19a5ad-6ba4-428b-d9b7-08dee3061551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	DKXZ0L/9ntFHYSK3a77Y/gCQeZwFzrMr01rArD1eJX9B8I/7CbarW9J7Zr3URG626p27r4D3Rmho0aO9kE4XMfJhWlHY8FMkjjMo70XJAkHc6Ill3aUm70uHMhzMobpvlHyN6Pp3Y2av0D1B4UaphMo0gl5GdKcbTc3zNdmwLgpXk5lidqcHu84pLX5WBigo+vAalSo5wXkZzMfQ6MCPl7StXJm6CaU8uaEW8OmngsnxvQFWnOHpl9r8zkWri0jYOioz7mr1x18U9aatwq05AcA8nl7TkgIGNOvIS+Q0XvwPr8mzf8m84+raWXL8x+Q7jOy+9AkZnBLh+n4pqa/ViZTVLM1ee2jdEi9u0fD4OuWfs2UTHxXr3p8lpNWPf25IkXo8z/hLT6NWYY4MiEi/uArT2VIerz9TeFkx5wnW544zCUYCAFcJr5spiq7KMSYPFbGar9vRJV5mn/2MlPe2Qbfa3qcW6FPAjHfGLbYGtt8xs/Nw38PTeKEhEKSVYBIRfY9RilgXeebvWAVrA5GNxHpJvvdBA2bmDma4eqemnEXRSpdr98x2HV4eNAqhG3Aqh37nXxm6e0UJb+Rit8KehTdTBGd7FijU1jq1HOlPKMi+FxUkW5EZTr5VNZQPwVGN4chXpuP5JFY6+nvb8IZVg6ngpIfSSz48ScW+BIfVvzg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DXDI/PzqO92UOMZNDLTQd0UIIEqk8t98sbue0bhSxhlqkxA43llbc2VTffnG?=
 =?us-ascii?Q?3MxP0Hy2lbmLWSxL2dB4iPIV2o6egThlmzIgMRZ+xYRGZid4HCR00/D//dtI?=
 =?us-ascii?Q?aHYP2V/ZFko5GKRiHGagR9N4EHMFGCXNAgBObRTJllzB8vFAsnb+qW1FBtRe?=
 =?us-ascii?Q?jig/yqrKSgrDIXBS25gzI17WXQ2aAS5TRocb0IrTPv7ngPc+oQf/5SMcSrGV?=
 =?us-ascii?Q?5eagW8BGIQWGUZNQzZzMnbsN8RBPs5V+LDVh6u/dtP5sokZv6EdYdZWvzcDy?=
 =?us-ascii?Q?tjM/TqvKeRSyZRngNkuA0Ex54r1NZxA/cBJwm+0iQTj1qdDJL4x+M7MSffkY?=
 =?us-ascii?Q?TMpzBaKRIbnGHicnA6Ucc9V9pMcPkUCVFaK/91zTP89Vf6g68dURdkn5MsiU?=
 =?us-ascii?Q?Px/hiJuLCLju1baXULV5qyHXWelRGRhGNx7XTl7XULhzsk/SC9gcbRgwl6YT?=
 =?us-ascii?Q?HnB4HGIkLSLBggbtHdbJ5HP4N9SDoTqM2t+a4WulA3tGqab8NzS7u28gXtfU?=
 =?us-ascii?Q?jQGdsaSqzZkKpm8Cwkcc8HhpNc1jtSOrdI6SSeXN+Odoy+Jdu7zZdv7K3KXt?=
 =?us-ascii?Q?H9sMu1hdBtpACfRUqOsYg5FbQkyGxjtnjm7JZ1uNlTdB3l3FCTZaAd4FAQBt?=
 =?us-ascii?Q?Y00A41X8eJSQW2+NrW2YVzheJv+iCiq65lUWBJ6hNTCyOt+GFNSdGlmlwuXq?=
 =?us-ascii?Q?2BLYQgQnLMq6nVowNUMZUELE06W+ANSg7kSvSpbwmiP3jOGhSYql+EaK9AnJ?=
 =?us-ascii?Q?yjaQNO9D/C9t45as2wd7/rgg6mbQNAQ6XEzOywhgM5O8zy3mf3APs9WekqjM?=
 =?us-ascii?Q?Z6KwbfukFWfM1gU5gBfgw9vL6GRxNVco5CAH7KHjpzCg0uT0EMbBr0ZzQGE5?=
 =?us-ascii?Q?pZLYsOB6SGE+oxRwgFSNvwzV0VQLZiRrIgdOi+tmSiAJBJ5iksnjWDTyXyXf?=
 =?us-ascii?Q?PAOn+VONAwFDZ+8vQZO7gtUZFElmO/b5LWe7pBvNnvMWflD++mtyuwK3uPXR?=
 =?us-ascii?Q?m+GGQvuP/j56M0nCiUR3eMvYhr2QghJrw4l7c7AqL22KDAaLvSBOvT4h2C0e?=
 =?us-ascii?Q?Zxb+SrHpdQ1IovJeInlBXR2m1uCLaYKN0CsiSrOE/nveYV+M8hPnWoyIBXds?=
 =?us-ascii?Q?OBG65AL5Z1xT7q0MYw8JRj8B8/7qCTZxgrMDfWbuTTjydC2DIz2fjlwlnBi0?=
 =?us-ascii?Q?XxPWySiuMP+TPoXWL9o5jzIBDW00eMkp24mNyQROM5Cdq7mbIsOrTHHLbl1G?=
 =?us-ascii?Q?WYc6tdmsO+BQcIQ7L+kU1sdbmzk4CX/8gof60drKc2Nk86mPdILex/uQLBZ8?=
 =?us-ascii?Q?2WedVaW2U/hb91P5OGXLcxf4cog0zJYdJAUkjZEv1EF83nT8wWzzu3q6jubj?=
 =?us-ascii?Q?6h+O5WpPH3zmCHjZwIYz/XDnZas8UO36rEoftC0y6MsUzHaKbiH2zD7JbtPG?=
 =?us-ascii?Q?zMM7lx7zFAMjl51IdAyvVgqbs3DPxe3z4WKktkjufxqxhgjThrMcMSMRjK37?=
 =?us-ascii?Q?Oi3FWVOkIOrEMvECU5dyV1fu4iMXQkHy9cstNs03GFBj4NJLqXTsZPXI+XwZ?=
 =?us-ascii?Q?an0h1Hnz97SdM3nZidumLWP5Rj4UXqRVTQaI9I7GSMr4XBbr6ceBUFlq1rnw?=
 =?us-ascii?Q?MCkKG00fyBiYb791UM2EBTx040RTJX31WfjyWvE/W4z9rYfxi0H1vFAQ2adh?=
 =?us-ascii?Q?nSUjS8tqBnRW6uTS49Gsg9g5ChejBo6IBth2B9wkBy8Alf+1i4yxThsrm+GX?=
 =?us-ascii?Q?5ie2J4nibg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc19a5ad-6ba4-428b-d9b7-08dee3061551
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:47:20.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJD8SoBLA8wYQ6w/HuVI3fsRRZ63eRs2vLe5ccPcg0r4h/w3WCBLMS5VEsltK9QDe6OtVBSj05ajfPTGIEy2vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299

The "CdbMaxPagesEPL" field is 4-bits. The code currently assumes that
the value of the field directly determines the number of EPL pages, but
values 5 / 6 / 7 correspond to 8 / 12 / 16 EPL pages.

Fix the printing of the number of EPL pages by using a translation table
and avoid printing the field if the value is reserved (i.e., 8-15).

Fixes: fe8e296aa023 ("cmis: Print CDB messaging support advertisement")
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 cmis.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/cmis.c b/cmis.c
index 16f168a3b1af..da1ced75e4ef 100644
--- a/cmis.c
+++ b/cmis.c
@@ -924,10 +924,14 @@ static void cmis_show_cdb_mode(const struct cmis_memory_map *map)
 
 static void cmis_show_cdb_epl_pages(const struct cmis_memory_map *map)
 {
-	__u8 epl_pages = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
-			 CMIS_CDB_ADVER_EPL_MASK;
+	static const __u8 epl_page_count[] = { 0, 1, 2, 3, 4, 8, 12, 16 };
+	__u8 epl = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
+		CMIS_CDB_ADVER_EPL_MASK;
 
-	module_print_any_uint("CDB EPL pages", epl_pages, NULL);
+	if (epl >= ARRAY_SIZE(epl_page_count))
+		return;
+
+	module_print_any_uint("CDB EPL pages", epl_page_count[epl], NULL);
 }
 
 static void cmis_show_cdb_rw_len(const struct cmis_memory_map *map)
-- 
2.55.0

