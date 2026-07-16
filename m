Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BEB326951
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184433; cv=fail; b=ivlXc6ruPNpxHxzDVxGtamN+qjU2pc1zHAIYwFbL//MuER7efusXppV0/bYAc7kWfEzOXbyrYM5BdG7QBvEo6h7EN9nGuqa1quhj6HF4AuhKMJNFFt7cpA8iRBiTep3yNMjuUUwsJEGd9zZyPf6R6jFBbUXrDrJt9KCE3Pp1QVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184433; c=relaxed/simple;
	bh=CWAhXoRjrRpWLI4wIDAlvpL6WGISBEhNIjIe7X6yy/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GZ53feQXN5YMQ2cENVw2oXcU1Pmbo6D7OnyCasSbfZg8cdWyAw7b6HmsVFfb0JOPhAneL7SZcSZ9ShIO8OeJABArUZxkmznwqSLBd/VTOcE1ugn2TJF8wkw6QvS2jaQXKpzJ3qcHdJuUx9NpjmGg+02LIojMMdos2kOz7BmyCKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QuDauPnB; arc=fail smtp.client-ip=52.101.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QuDauPnB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k53BloV4nf635zujXMKA27WrUrJQ0HCcjjZXaqmfYLDy4EKj+U3b+u3dYmUtWSZ/tpQN3GxmCPu7eM/oU6UBBwENiJv93x+SacB+BDx9CRq0Z8bLGmlhLs9TCf5RzH+xSZgsEUroTEkIu62LxD5Kg/vLeqxE//GrI4a7C9GAmleP82iiUPbh2k3i5kaJ/ff+Rd5Ml98TgyR8G1RX3H+JP/r37SR5VH0XbLUzN2qBmyfQfZzGRrFlSAvVFFy8egvINR9s2LmSvpclj9kJMGiq+KSI/8lrqVybWFjYCzHUhR7BuOZeFzqa8ywsRaeSh+b9WeaR9jbsTm0ZiBwngyvikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tez7bTPfXCf4YjnwoDZjl8RxmAqkv6moUO3MuQxeos=;
 b=tW5ItNV8ghTSw+euIjyQ6tboeEYK0fqDillwSPDO02eaSkQS81BekYPAMZ84D5z2NL6EXwkPtkHhu3dzMkSTgWEF09F/Q8jbG22Q/oM8mC0NVDPX9V2vy7qy5fA/3gCrzGIFemjKmXu9wPfGXDVPdktC8shEU+ClEKkRuICBiidd0iA5mZ8d5NdFw6gharUgC3YvyRjMvB3v6AmZzQ7WMBCXvj8cdJzvYLqa72Qe3/4j7j3tw4mPJMm9aWdpnTcrJYWrWdCgIbsITRo/DwP/yj5aa7Lut4hFAqWMdhP2X/McBKSgghvgRNPgMCzpnLjpKyMM9KqXDfU3StpSEIngyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tez7bTPfXCf4YjnwoDZjl8RxmAqkv6moUO3MuQxeos=;
 b=QuDauPnBEleaI5kNqzl/TZe0NhytsfiEjhIampfFMgPn5krEbLKFdzCTwTYs2TscAwfTTQrbEYKHZ4lJunwE+kjKdWT7VWrxknq6/puW60g6rDGA5mkvJCC+W7JiNSSjaG1N45gP3MBOeW2t04V00bnJSw7Aje9kpvFOA/Y8HyHGppbpt1BRe4k1rcOJbQKEJQ1Z1rsP6OJMGUhdLWa48nTjRQZZF5+b4oop3TrlmL3U6ELz7DAjXbA0EUieugSXsy14ZQ16wdk0GhoGEU9Zv9deDZoc0ebDzjKTVv8cSvlCt3s6TEHHD9bV7isC6WW3F23e4LSYREUc48ZMPHNgzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:47:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 06:47:08 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	danieller@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH ethtool 2/8] cmis: Fix printing of channel-level flags
Date: Thu, 16 Jul 2026 09:45:26 +0300
Message-ID: <20260716064532.1522382-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716064532.1522382-1-idosch@nvidia.com>
References: <20260716064532.1522382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f9ad0b-484d-4b60-5f45-08dee3060e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	D0e+9iQ8YrOD6+LOobTgWHb+Oz4JDS3qrOyutPjvU+ODfgbMHxE867+yVsrOzwVeohk/WidrPWuc0EDKZ+XSTS/ZNL42MYxs6fbxnIZvMFRlgilGNdAVkJOfOW/S9wjjBTJ46zP7OJsFgpAd4Q6UNoA0izKa0bS03C5w9eMQBEJC4mw68sVX5man6lIvilrKoDxbjnitMkuJDLAZ/U/5gipMFaz6hga1bvPHD3lswLPJRJHN7o37MVMr2d4o8xHOar2rHX8CbuAFXQN3+g6xC9oTbx90eKfBW8RNLTQAJGGBtcn+HrXQGe8C/ctxGJIXgyDCG6DLlkxKj6cf0e+Z3ukhj4ed8+V5jnNWvXIjdgfTr5FQOdIV3xjwJhq5OoCxndmrF/JCkh4vp5Rn0vs+cFPsoZqsA/do2dWkeg+LmdbhQ7F6zorGHNbjaU3ew1Oy0r7vNiWDMFl4YGixwlV2rXCLO7pR4QYDlr7ur1PEB44pv90/gZJ9WLkQl7EhWZwR/wJuWxPKSRIaiReUk0GIRSoRtbLxan57AU7xu+RrQhaqpx4ZAqDN1izo0kKnsZH98lkabUHMAxlkbK7zTPY3bT+AASWWqBXDnoQPI6iwMV03Zts3d76RFyfxO0HNU20vlZf/zQEkjCa4I+LhXCBauZYrTCTd6cDlDKyVgmLdS2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6C0/DLTbg/vbIgNOqiYnvimX1h3ubQmkZ5GgGOOEXabvVpyLGebPLysS/I10?=
 =?us-ascii?Q?nReUoAP1uE46xIUZQ28rx04+2XYdgdQ0V983Gu3Rzr1+H0XKz2XMgrYxq0L5?=
 =?us-ascii?Q?GVUJuymjJ/XADwK7w/oKFXKRMVIPRCTDLRxvK7xSukMYDYbul0CzaiDr7Euh?=
 =?us-ascii?Q?ZU5HkzbgvC6A36vzpvtpbWAqBDbjqE6ZrQfbNkIL4c1Gl46rugddmHD8WlRQ?=
 =?us-ascii?Q?a15mgr4TPpsO34M9zr2ZEZMb79kiOY53jAmg5bsSTs+bDrV8HMJaI5LA7UqM?=
 =?us-ascii?Q?PB9DGmnHaAEqCtvjDt/UhKt7IwS/3cAfE+uFCTMtqpNHs17kg0BhF5BK+1CW?=
 =?us-ascii?Q?rxvFWl3K1jLGuVYaY0LTa/ZlyBivLs3jglL7KG3Regu3ve8UQ6iBBtB8xQyC?=
 =?us-ascii?Q?gvGofpTODN2CJv97+fv1vMdBHmASYb9b7PyZZEsgFwkGosuqjISeHP13f6CL?=
 =?us-ascii?Q?LH5oZGcBFxVfyafglWie+MM0EQFZwaFawL1RZ1eE3cvbpQihQd4+tVSBW+Gv?=
 =?us-ascii?Q?A/7MTtSqgz8rx4Eqw9/TAFrwjGAUMMAEi/h2642OjY+/psLb4KXWbUts2nHd?=
 =?us-ascii?Q?to7yh7ZuUv1C/wvBJ4SdyzyJgam6SUbZAey3PLbdd97h5IzN6wT7eamlHSyO?=
 =?us-ascii?Q?ehPwx14Mp6pLVaNwjv1gZoBs9n41pq8IImcH16MPgtyGsVrxT1RIlwotV+cB?=
 =?us-ascii?Q?FuOwuHLxyca5bxeOJQqxeTxWwi/QeBpvjPeDYpM2FKW0uH4mNvBM10oHOFP2?=
 =?us-ascii?Q?hiblyYeFDcd6S5X7Con0jNiV7smXrpuFBV+pHZLCS7YT3fBeSxqUMlADLeiY?=
 =?us-ascii?Q?M6gJXUNG1ddVBLJW76AoQKb8VoYfY5LSlNa1inPQHufmvuMgovgGzPTm1w/0?=
 =?us-ascii?Q?QkfdPhb77Okg96ZbHMZn+zNi8yKa0EBzNn3vwM9KP6VSpyW0Vha4wof/qDMD?=
 =?us-ascii?Q?hmzKT2+fnLo4JaTcGkfxQ/A5F/hotzopEg9t+HI5VGHuZkKHBtNHBHpJyOkm?=
 =?us-ascii?Q?zBel2OBB/wevzmaXDcbQjSvqkgA3seBAuUluLksokoR7c7VbGQ9NZ8djlGuu?=
 =?us-ascii?Q?+1tcj9nd6cwpEaP+Z2oIB1aMVV1fyAyUBOWQRfQ+IOR9Jg82l1xAFdC24CGY?=
 =?us-ascii?Q?izybZFZAt32V6cJnA/hjC8phAXWrJihH3DJh/qQqc5UOFe6GFDkcLsUygLqX?=
 =?us-ascii?Q?iPw6x5d26jp/nTRNt6ZkBC+kR070PvVaYS1OLH4GHr1WRB72xyNcYST43vEO?=
 =?us-ascii?Q?CMp8+cFQBeY+GaaUKHllncIbPgSX+Kkipr3WgqFPbZDeCZ19XTEWQlCIALb0?=
 =?us-ascii?Q?8XOEsiehFONwD9ZvGXiAQB+GKFWmvoHBFDIDDFsUdpGbShxqjEe+hpHtiA9v?=
 =?us-ascii?Q?bRCjMzVDUaTkffBKgkRpK9ESCtkL+awYuqvNFfLlwCGu3jm7ZOCNWJBLaqZO?=
 =?us-ascii?Q?o1ata4E+kmYmlykjTc9S8phROm8mj8fAj8r71t7e3LZmWk8saIj7ewYQEdYp?=
 =?us-ascii?Q?PMKGdVe/3v1kQzfH6tENI4tWxbIjnYacph0BWX4FJgRCB5fVVF9sBLZWSYp2?=
 =?us-ascii?Q?nAalp09F4MrfjxTLrues0NVnY01/+X7XRFkq242EYx79sutZIDJBkqZovLlS?=
 =?us-ascii?Q?xyWrOBDVmQwaL+oqKIvo+wrjMIJ0wczeT8Gnga4sm4AriLydh7a5Kg+JcKRd?=
 =?us-ascii?Q?icsmRqCfp3ANAo6sOAPLA1SCXdcMh02UmOppS6WxjndqEs64Q7qkgviFfIx4?=
 =?us-ascii?Q?2/KIf6/RKA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f9ad0b-484d-4b60-5f45-08dee3060e3b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:47:08.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzx/b4C2FOzwvC0Zzz2q1yLQ6bWK3HskbvI29MVrmJ9s53kNqhpYhgUEBKbNVssqdsCES11l/CU1Q8+dFiBhtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299

CMIS encodes different channel-level flags (e.g., "Laser bias current
high alarm") in different bytes where each bit corresponds to the value
of the flag in a different channel. Since CMIS supports more than 8
channels, these flags can be banked (e.g., channels 1-8 in bank 0,
channels 9-16 in bank 1 etc.).

The code is currently applying the wrong bit mask (the channel number
itself) when extracting the per-channel flag. Fix the calculation of the
bit mask so that the channel offset (0-7) in the current bank determines
the number of bits that are shifted.

Fixes: 340d88ee1289 ("cmis: Parse and print diagnostic information")
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 cmis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmis.c b/cmis.c
index a4bf455c2a77..16f168a3b1af 100644
--- a/cmis.c
+++ b/cmis.c
@@ -766,7 +766,7 @@ static void cmis_show_dom_chan_lvl_flag(const struct cmis_memory_map *map,
 		char str[80];
 		bool value;
 
-		value = page_11h[module_aw_chan_flags[flag].offset] & chan;
+		value = page_11h[module_aw_chan_flags[flag].offset] & (1 << i);
 		if (is_json_context()) {
 			print_bool(PRINT_JSON, NULL, NULL, value);
 		} else {
-- 
2.55.0

