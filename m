Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9327A92D
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184456; cv=fail; b=Z6T3I6J9bfi6gBCM5nyeAM3m7S2cp6QYX9uNWavYlfdQ0MD81qckSmv6bgKHLM8Kfs0WUmytxXcQGaxz9Cm4Lqmvff0MNtd0uS6wvkZalc5TX1IyzAO33yumeBH+m8TremIRti3Jmtzc6IUgjsodV/kPZVLEaBot/rA4gWgYnQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184456; c=relaxed/simple;
	bh=WGCVNlDNV+8EuSumZRGoc/7cpnLiy3AGXe8Jbv6tfzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LjZvZIx9zDqjNqbYv+pnhSDHQT3h1Lc4h7PbPU71z/eKW9tP2nlEYDI2Jz+h0wWteE4WcoIHWfp1oPuYDfi1H6tofHUEYRnoDI2Kw9uTmzfgiJ71Tppv8SiF1CTs+q8iqf1e4QLsYbbpLW1Eu8ZaSI8QASPkvJYRfop/ubpsspA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jRxrMcqB; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jRxrMcqB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+ru1Qoc7gp5V16uzW3XWpUzEP/GCjCuxGUmHWAiSugxEKg1XyuNNdqNXgm9KxegPKkla7D0iQ5ReNQTNNdn0fI40Ux779Nf5IyjO57sGpcv0DOQuT5qLD7aDS5+esrPRaD5IMPwp5NTwG5HIkmFvPL9EVIEu9G0xySsbR8JKK4TD/i6I4u5dZ9wMEGX/vuXnmYdNMEVt+0r/egsP/MwOW5H6hwDKH9VmFc5F22klidx7qyWftnif540W0ETGTF2vpOCKVsbbkzrMh2Fy4GNCL+rOcfMEw55qaytqlNhSvWikKT7f+qoqSmFGai6/g5EfB9PaZ1QNPcPsOErYiDgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGpRXSsV/adhCkDwtLk0LIXNBdKl6qmtUI8JqFL3e5I=;
 b=QlHUWBShWBiBPJhDylc8I4CQtcywjWIA1I9cHWOVN7uejsvotMDzal+GDMKdKdQ5hLpUXl/6FOIbJFycyXZ0i5GQtgUABDQdYSq2zO/iSQS2u8ZFklTyZ2Rwar6KuiXf2ByF5Z3OryO5oMXZc/2v+TnV5T6bxQIjC6CAd4DtIac04xeFo7QQLJzb0J9OvnhBWEIxyELM1SI0dvHrkeLHyMJE7mDyOC9VdzOoha1LkzkO9TcimoTmhWi1KXhzA3l7gWw4Tf9ZFNqXEeoNStmQVFT8libw3m4CefxILUvJ80plmu+7kKAvXl0FFFSLpN/d8Y2Nkpve+Hv4xXDzO6HxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGpRXSsV/adhCkDwtLk0LIXNBdKl6qmtUI8JqFL3e5I=;
 b=jRxrMcqBPOoYgCbX+mvf0W3OqYd8Y1d7UuyeXFA09CyaisnvJZkdHrlhb3KaSyj1g1eYHR+NcVYtyuB3bSvOCwzfF8kUy3dVZ4UATv+KOh2wn2j5g/zsoTBL74csBO29IRuh3t7ueAI/Fuy6YBQWIITq7Jx3l/roBIASEgIRD5Y1/UuVtEgwT1xTP2T9kW1l9aWt8JGbX1bxH3t/zVL5nPEMAesfOqnnxNwk8VTXkqr9ht/ryM+qPhh5X8WEHXEvTml0giUbopnJSw+NhmRexDhZguDXGgUTTMnikD6OxrPL/xA3GKeoGg9x7Vv+fdEknILJpsEgfyOiHowzBo6z7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:47:31 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 06:47:31 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	danieller@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH ethtool 4/8] module-common: Fix printing of transmitter technology for CMIS transceivers
Date: Thu, 16 Jul 2026 09:45:28 +0300
Message-ID: <20260716064532.1522382-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716064532.1522382-1-idosch@nvidia.com>
References: <20260716064532.1522382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: 204118c4-a394-4204-949e-08dee3061c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|3023799007|18002099003|22082099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	d0iRVkyCejTpbPq3+2/HXEb3LJnGMcsKr8pGSJDCCpR6KiJ2T3PW5zJepcYM2UNQaog6VArPPxl7MuAaclFzdT+wvCAT7L3m1Sm78wJEm2ptzk2IYzimmKgvbvsnN/GxmPKzWsW47abvcuNYuDwz6QmI8poy63F7CMb9U128MaazsJRt8tUT6S461tpyyawpgy1KnWDq9RHvI3JZ9BVETfBHzRxECwS6FLUEmMk/Jm7YnLl2aKX8Sy4w146fKXiYFf63x35VSYpoC543WoL7c+LBdfdE/c64MA0unQH55AC2E0gt0BkiJ3T4khlh1qfvd9K2v0rTw9HtGS2On4yaRfwg6p8X/j4WA9W0BKh4IhtafztMvBrye5+81hiD+JlSluhz4efCtneXta19kZ/fce8U2Sbe8H/fbwFg5B2bPb+zuQNLI2w/8tkU8SvHq4IK8+y6m6eHaAufyx8DyTvTq9vLM92Aj0+aKpCkyhIA+Z480CKbaUzdMV5EYEpF7gfFmYq/nTh9NuywjiJi21cwg95KsqU73i0LA0tFOpnUbF9SOyMRfotRjCOgC6Gh9sLJvU/Q+QCEDviNx+bRxru3myvMWVek46Gx2epBTzgHzDTLRuqOESgHheyDNLr7JtOiyOeKZwq2Q3t43z73jeuPBmwwOiLAXjOZIj16B0ruqUQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QxWWPD+mWjJSXZXVYzNorBrSzIhLPfZsJIJoP8bnssaEoIsIkTx5zRVHdHLA?=
 =?us-ascii?Q?FltlVomvmab1VvC9ItV4X4ZsYM0MlXAhYWgdgw5T9fX5TXtNVu0uGNhtvhbW?=
 =?us-ascii?Q?4G4gpBF2s/mGYGyGtU5Ly85kMGs9oMr74OWB9h/PPSoJ2y3hKCPfavyUxaXd?=
 =?us-ascii?Q?awmGwb3jJOfN47mAlG3kNnOpk2O6gHuQSA9fSOxeVGlQNwcOy46xUNXgbToV?=
 =?us-ascii?Q?hiVRegCK25aDqTltB/yRSmu2oZ/9MWiun6YaYL/aINDsvUqu5OWx1VTcYenE?=
 =?us-ascii?Q?PNGW2i6dIxnk+UnnzPa26ZdzF+hmGQnpjj6igG+XbMccR215Nc1PwBx2cm8y?=
 =?us-ascii?Q?7iwU8Myx52F+P0b0sAeikJGcKo0SCNM4v1ke84QOnc/zC0S3GGlbCqT7hnw7?=
 =?us-ascii?Q?ekvkURI+xTL0Z02wnWWrmY5f2M7VZ3zkDt60PR0tJ43JMJNQJ8ccUlxxJees?=
 =?us-ascii?Q?5Pj6nYckoj3qpgqTE2ljdg1DsCg+w6GoY+F9YU2VoGEvwq+tWKQZggLTBtXA?=
 =?us-ascii?Q?fKk2U2fBuiSHoLdoUaV0iCbWJy6n7JqF2eTwaNwY1hdyg24Nt2CJQHUjjx6j?=
 =?us-ascii?Q?vNzDCXor3x3Cf7M8s32LC1Oj0h4OCnPbJRCAcybU0cMqBdjOG77v2yAmEmIE?=
 =?us-ascii?Q?wST8cLSV0OgmSz8/7pVqNstrj1HnOt+fwIGg5QHZbt0ly5FlGc+vdvfO/d27?=
 =?us-ascii?Q?GcQV1McJMUsB0pCRjjrXEOn5lbUGYxA/2c5Eb+0WcLP4tPS2LAF5oRzahaIM?=
 =?us-ascii?Q?8CrmDq8RgBZOAukdjKX+x8CI9hpv3EldEicFghVa34Yn5KuQT9JTYFUrG25/?=
 =?us-ascii?Q?WfJ2oqj2nFiGZGRwpV1j6+E7vOMFdmh6+2mSVezUfk+f6JhJ0i/WUqHMqwAE?=
 =?us-ascii?Q?iIE4Zx6YRZamQil4Pyc3glI9gSj5gtzjw+XGzOsWylgDxz115XH+mN+LhznG?=
 =?us-ascii?Q?x81bbJsIjt/NF0JiTRobwjxib8DbDEVLT6zjif2uIreYmQeqdZa21PfoBBxC?=
 =?us-ascii?Q?oa/nvC8daI7EOn2ImV7ZHUzb4m2SPdCNIDjv0a31DfsIZNM4hC2RV7g3KNNL?=
 =?us-ascii?Q?qR68KkoHAn3XUX5+keq+F9xvYiaX5QGgmrjTot4T2rberyHDAsL9Og1Q33VV?=
 =?us-ascii?Q?/WtFTMJnJnPDZFn/Y9+ejbHNKzakVU+LfekhDsL/r1my4hMg0ixL3j8xScfl?=
 =?us-ascii?Q?CL/xHBrVWDgW+eFY6aas5cxgRSrwZWZH5Eo9qLP25xheeH0mdmYtn98YMUuo?=
 =?us-ascii?Q?R9lTcQ1LDihr3fZ2tkWOmv6S+MZqWmO7APoAbhkAOMmXkFm7wauVTMDUe+54?=
 =?us-ascii?Q?BfZ+wRAT/1DPQexfQXYXlG/qFBgvPiBkAd4kC1eWC5wnRo0+lWssU0MKarlK?=
 =?us-ascii?Q?atfQPltG4SvemVpzfw1v+oear58qTqCpz2RQ1HenAVK3U/d8FGini2Ue5e1B?=
 =?us-ascii?Q?NU18AtWTB/Er9XC/Z2BCwB8ur7664zzkQzMlA8yXEyY3Np0eNI5ycg8UUoUv?=
 =?us-ascii?Q?FvnZ2Q0WpXE9v1rQwd7KmAcen5UGtfn0b8p+y7Eob+o1e5S6fVYeoqejDGgB?=
 =?us-ascii?Q?G6Hd4+QyP0iPf1fL9yCgku/XRwCp7R29OQuMrvYTpqdX9kcGKwn+f2JTqvpO?=
 =?us-ascii?Q?2Tz68I+IphfTDJ9BhIqAggkgDgQUmizuxJW3hJk14NA2vAvLi0833z07FjIh?=
 =?us-ascii?Q?oxZhN2XBkaUPttkByDdRnLlVrNbsGAErFwt9uFa12YEBGiUBzYE1MlFrL4mZ?=
 =?us-ascii?Q?beFCaPsRrw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204118c4-a394-4204-949e-08dee3061c01
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:47:31.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMTHwGhtocaw2vw7roiaFpVZpJUgg3wsbUH9mXe6jOcldOUrTkZ+TQb6LVl0sQO5LpBZYQB2b5aRQTOmdYx8/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299

In CMIS, the transceiver technology is encoded in the
"MediaInterfaceTechnology" field which is 8-bits, while in SFF-8636 it
is encoded in the 4 MSBs of the "Device Technology" field. Both
specifications share the same encoding for the common values (0-15), but
CMIS supports more values given the field is 8-bits.

Given the common encoding, cited commit consolidated the printing of
this field between CMIS and SFF-8636. The CMIS parser passes the
"MediaInterfaceTechnology" field and the SFF-8636 parser passes the
"Device Technology" field while masking the 4 LSBs. This creates a
situation where both parsers pass different values for the same
transmitter technology (e.g., "1310 nm VCSEL" is 0x01 in CMIS and 0x10
in SFF-8636). To overcome this, the common code matches on two values
for each transmitter technology.

While this works most of the time, it is going to create a problem for
CMIS transceivers that utilize the 4 MSBs of the
"MediaInterfaceTechnology" field.

Fix by creating a common encoding for the transmitter technology field
and have the SFF-8636 parser pass the shifted value of the "Device
Technology" field to the common code. That way both parsers pass the
same value for a given transmitter technology.

Fixes: 504c4f573571 ("module_common: Add a new file to all the common code for all module types")
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 cmis.c          |  4 ++--
 module-common.c | 47 +++++++++++++++-----------------------------
 module-common.h | 52 +++++++++++++++----------------------------------
 qsfp.c          |  5 ++---
 4 files changed, 36 insertions(+), 72 deletions(-)

diff --git a/cmis.c b/cmis.c
index da1ced75e4ef..19a3eb7cf925 100644
--- a/cmis.c
+++ b/cmis.c
@@ -254,11 +254,11 @@ static void cmis_show_sig_integrity(const struct cmis_memory_map *map)
  */
 static void cmis_show_mit_compliance(const struct cmis_memory_map *map)
 {
-	u16 value = map->page_00h[CMIS_MEDIA_INTF_TECH_OFFSET];
+	__u8 value = map->page_00h[CMIS_MEDIA_INTF_TECH_OFFSET];
 
 	module_show_mit_compliance(value);
 
-	if (value >= CMIS_COPPER_UNEQUAL) {
+	if (value >= MODULE_TT_COPPER_UNEQUAL) {
 		module_print_any_uint("Attenuation at 5GHz",
 				      map->page_00h[CMIS_COPPER_ATT_5GHZ], "db");
 		module_print_any_uint("Attenuation at 7GHz",
diff --git a/module-common.c b/module-common.c
index 42fccf68301b..997dd2b37ce7 100644
--- a/module-common.c
+++ b/module-common.c
@@ -575,71 +575,56 @@ void module_show_mit_compliance(u16 value)
 	char description[SFF_MAX_DESC_LEN];
 
 	switch (value) {
-	case MODULE_850_VCSEL:
+	case MODULE_TT_850_VCSEL:
 		strncpy(description, "850 nm VCSEL", SFF_MAX_DESC_LEN);
 		break;
-	case CMIS_1310_VCSEL:
-	case SFF8636_TRANS_1310_VCSEL:
+	case MODULE_TT_1310_VCSEL:
 		strncpy(description, "1310 nm VCSEL", SFF_MAX_DESC_LEN);
 		break;
-	case CMIS_1550_VCSEL:
-	case SFF8636_TRANS_1550_VCSEL:
+	case MODULE_TT_1550_VCSEL:
 		strncpy(description, "1550 nm VCSEL", SFF_MAX_DESC_LEN);
 		break;
-	case CMIS_1310_FP:
-	case SFF8636_TRANS_1310_FP:
+	case MODULE_TT_1310_FP:
 		strncpy(description, "1310 nm FP", SFF_MAX_DESC_LEN);
 		break;
-	case CMIS_1310_DFB:
-	case SFF8636_TRANS_1310_DFB:
+	case MODULE_TT_1310_DFB:
 		strncpy(description, "1310 nm DFB", SFF_MAX_DESC_LEN);
 		break;
-	case CMIS_1550_DFB:
-	case SFF8636_TRANS_1550_DFB:
+	case MODULE_TT_1550_DFB:
 		strncpy(description, "1550 nm DFB", SFF_MAX_DESC_LEN);
 		break;
-	case CMIS_1310_EML:
-	case SFF8636_TRANS_1310_EML:
+	case MODULE_TT_1310_EML:
 		strncpy(description, "1310 nm EML", SFF_MAX_DESC_LEN);
 		break;
-	case CMIS_1550_EML:
-	case SFF8636_TRANS_1550_EML:
+	case MODULE_TT_1550_EML:
 		strncpy(description, "1550 nm EML", SFF_MAX_DESC_LEN);
 		break;
-	case CMIS_OTHERS:
-	case SFF8636_TRANS_OTHERS:
+	case MODULE_TT_OTHERS:
 		strncpy(description, "Others/Undefined", SFF_MAX_DESC_LEN);
 		break;
-	case CMIS_1490_DFB:
-	case SFF8636_TRANS_1490_DFB:
+	case MODULE_TT_1490_DFB:
 		strncpy(description, "1490 nm DFB", SFF_MAX_DESC_LEN);
 		break;
-	case CMIS_COPPER_UNEQUAL:
-	case SFF8636_TRANS_COPPER_PAS_UNEQUAL:
+	case MODULE_TT_COPPER_UNEQUAL:
 		snprintf(description, SFF_MAX_DESC_LEN, "%s unequalized", cc);
 		break;
-	case CMIS_COPPER_PASS_EQUAL:
-	case SFF8636_TRANS_COPPER_PAS_EQUAL:
+	case MODULE_TT_COPPER_PASS_EQUAL:
 		snprintf(description, SFF_MAX_DESC_LEN, "%s passive equalized",
 			 cc);
 		break;
-	case CMIS_COPPER_NF_EQUAL:
-	case SFF8636_TRANS_COPPER_LNR_FAR_EQUAL:
+	case MODULE_TT_COPPER_NF_EQUAL:
 		snprintf(description, SFF_MAX_DESC_LEN,
 			 "%s near and far end limiting active equalizers", cc);
 		break;
-	case CMIS_COPPER_F_EQUAL:
-	case SFF8636_TRANS_COPPER_FAR_EQUAL:
+	case MODULE_TT_COPPER_F_EQUAL:
 		snprintf(description, SFF_MAX_DESC_LEN,
 			 "%s far end limiting active equalizers", cc);
 		break;
-	case CMIS_COPPER_N_EQUAL:
-	case SFF8636_TRANS_COPPER_NEAR_EQUAL:
+	case MODULE_TT_COPPER_N_EQUAL:
 		snprintf(description, SFF_MAX_DESC_LEN,
 			 "%s near end limiting active equalizers", cc);
 		break;
-	case CMIS_COPPER_LINEAR_EQUAL:
-	case SFF8636_TRANS_COPPER_LNR_EQUAL:
+	case MODULE_TT_COPPER_LINEAR_EQUAL:
 		snprintf(description, SFF_MAX_DESC_LEN, "%s linear active equalizers",
 			 cc);
 		break;
diff --git a/module-common.h b/module-common.h
index 4063448f3eea..fba1d36f7f86 100644
--- a/module-common.h
+++ b/module-common.h
@@ -83,42 +83,22 @@ enum module_type {
 #define  MODULE_CTOR_VENDOR_LAST		0xFF
 
 /* Transmitter Technology */
-#define MODULE_850_VCSEL			0x00
-
-/* SFF8636 */
-#define	 SFF8636_TRANS_TECH_MASK		0xF0
-#define	 SFF8636_TRANS_COPPER_LNR_EQUAL		(15 << 4)
-#define	 SFF8636_TRANS_COPPER_NEAR_EQUAL	(14 << 4)
-#define	 SFF8636_TRANS_COPPER_FAR_EQUAL		(13 << 4)
-#define	 SFF8636_TRANS_COPPER_LNR_FAR_EQUAL	(12 << 4)
-#define	 SFF8636_TRANS_COPPER_PAS_EQUAL		(11 << 4)
-#define	 SFF8636_TRANS_COPPER_PAS_UNEQUAL	(10 << 4)
-#define	 SFF8636_TRANS_1490_DFB			(9 << 4)
-#define	 SFF8636_TRANS_OTHERS			(8 << 4)
-#define	 SFF8636_TRANS_1550_EML			(7 << 4)
-#define	 SFF8636_TRANS_1310_EML			(6 << 4)
-#define  SFF8636_TRANS_1550_DFB			(5 << 4)
-#define	 SFF8636_TRANS_1310_DFB			(4 << 4)
-#define	 SFF8636_TRANS_1310_FP			(3 << 4)
-#define	 SFF8636_TRANS_1550_VCSEL		(2 << 4)
-#define	 SFF8636_TRANS_1310_VCSEL		(1 << 4)
-
-/* CMIS */
-#define CMIS_1310_VCSEL				0x01
-#define CMIS_1550_VCSEL				0x02
-#define CMIS_1310_FP				0x03
-#define CMIS_1310_DFB				0x04
-#define CMIS_1550_DFB				0x05
-#define CMIS_1310_EML				0x06
-#define CMIS_1550_EML				0x07
-#define CMIS_OTHERS				0x08
-#define CMIS_1490_DFB				0x09
-#define CMIS_COPPER_UNEQUAL			0x0A
-#define CMIS_COPPER_PASS_EQUAL			0x0B
-#define CMIS_COPPER_NF_EQUAL			0x0C
-#define CMIS_COPPER_F_EQUAL			0x0D
-#define CMIS_COPPER_N_EQUAL			0x0E
-#define CMIS_COPPER_LINEAR_EQUAL		0x0F
+#define MODULE_TT_850_VCSEL			0x00
+#define MODULE_TT_1310_VCSEL			0x01
+#define MODULE_TT_1550_VCSEL			0x02
+#define MODULE_TT_1310_FP			0x03
+#define MODULE_TT_1310_DFB			0x04
+#define MODULE_TT_1550_DFB			0x05
+#define MODULE_TT_1310_EML			0x06
+#define MODULE_TT_1550_EML			0x07
+#define MODULE_TT_OTHERS			0x08
+#define MODULE_TT_1490_DFB			0x09
+#define MODULE_TT_COPPER_UNEQUAL		0x0A
+#define MODULE_TT_COPPER_PASS_EQUAL		0x0B
+#define MODULE_TT_COPPER_NF_EQUAL		0x0C
+#define MODULE_TT_COPPER_F_EQUAL		0x0D
+#define MODULE_TT_COPPER_N_EQUAL		0x0E
+#define MODULE_TT_COPPER_LINEAR_EQUAL		0x0F
 
 /* Module Flags (Page 0) */
 #define CMIS_VCC_AW_OFFSET			0x09
diff --git a/qsfp.c b/qsfp.c
index c82a3dec9b0b..20b6c2173284 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -562,12 +562,11 @@ static void sff8636_show_rate_identifier(const struct sff8636_memory_map *map)
 static void
 sff8636_show_wavelength_or_copper_compliance(const struct sff8636_memory_map *map)
 {
-	u16 value = map->page_00h[SFF8636_DEVICE_TECH_OFFSET] &
-			SFF8636_TRANS_TECH_MASK;
+	__u8 value = map->page_00h[SFF8636_DEVICE_TECH_OFFSET] >> 4;
 
 	module_show_mit_compliance(value);
 
-	if (value >= SFF8636_TRANS_COPPER_PAS_UNEQUAL) {
+	if (value >= MODULE_TT_COPPER_UNEQUAL) {
 		module_print_any_uint("Attenuation at 2.5GHz",
 				      map->page_00h[SFF8636_WAVELEN_HIGH_BYTE_OFFSET],
 				      "db");
-- 
2.55.0

