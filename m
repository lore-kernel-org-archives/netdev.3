Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867332F290B
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184479; cv=fail; b=OLGwGyiJYwWTXSjqW6C0oH6tBmwWs/fmcbTs+Vq1CverFPobozXdDpmNnqiVNJIibkGRYEEgsy+cR6jsbQaTMIipvhfTkXudOUatLzAtw/OQOSfrEUayGGvz4CHwK/TJNb3Chj4rvwvcVPfzY1deESKvSbUILEvDOoEXpnll6NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184479; c=relaxed/simple;
	bh=45LmnBbXG4UWm8KV8ABssG0V6XJT3u+3TpvhNfTNl0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=heNm8fx2a2ZRwofoMaDIvQibOswNi4GFtKcDKSC97x4D7BgotWmiBYVAJj+UniluTmQvEuaZ2A03nYWrj2gcSB7B3vk5hJRGAd13VVBy5v8QFKfOYry39TLlfmOMeLvJoMWXkY9PMqZI2m2HfgekX9Vd1KMi8CCbSJnZd5sEaHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qJ7QdaJr; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qJ7QdaJr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6kfsQA11vJ9GQfa5bAYDwBrmtD6cepR1szIVE4cpPGTIOqr0KFZz0v7NNayrFAn17N345nnmpUv16wsTSJ8TNnYFzWt1tdh5ti1XYXyz+v3zg93ez9sP5nVFE4uS080/wQi6kbHK31GfEZieR4cneUI+gH3dry5FreV+nQZA4t2oLGYBALlVEtY+oZHEEB1UGmHN3IbFGuOg2/wa2lilD2W2B9K37GFJB4JvMsmghDnY7xGIW8UTxNKhJlfKJGOeYV8+ZsoZeh2ZLWbBA9HEXiomxp1UrvOLDzLgx7hn0ojZIyMqeG6PjMjTboEflu9ttlbG8PWJLtJypuivJWGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUGuLvQwmcet7TFS1+qHino/srzS/1K28mBmwla0oIg=;
 b=quucThOTUxZS5FoNoDqHsqQ9nSiBJl7fvFsLAg05FP6jbgD1gF1SVUyYaPUYHrmQaztStEvXfHDzv6w1j9nfkW7WRzAmlFZ0KZgbL956GZYyvLv4j9V6qWTrnZgZqH7p1vqzvAkP72kxMCKQeFhXeeJVhQjkZxAD2QEElY5Q6ThlbCOy36PC/mr3D2L/dIRaes3FhrUU829asuE3KZG9cJMHVZiDo3Kgzbq1K2xuekD+TwN5pA0TRhjEkZVNioKlNaNgiN01HyTG2FH0/0A2Cm9yuR0FD/V8uqKOAwVZ5pib4tJIKRhkqpxoKukK3maOjvHAdR8zjD0YYER5kenGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUGuLvQwmcet7TFS1+qHino/srzS/1K28mBmwla0oIg=;
 b=qJ7QdaJrYJJp1nKfSkM6v7cxWDE+eCY8YzT7NaMfcqkrKKnrF9cMPE/ZN2mqi0GF6elh6Z0Ef3vFT4FmVx2OxZPDd3dr1BNNmdEpRvEWHnEkw0JVSMgHNb5zR/lQLwcIrqE3vZ1YLC3jSCCyAX0ai98ygrHbDoTJ7awCsxu0iYRkQEzCTcXLmssXl1dYvSuesYXkaICkWp+oKf8mIDpaLYuXZE8uK27WWJZbH/b6x4d7rxc8u+iDbAX1pjSfSD76wZu7AH8hu06UpmGTFW4qBLWNJrhMcma9RC89hMK0jDSLr0PAyRPqkPRZ06Q+Jch/DUfefj7vuw2ohqIZhNATlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:47:55 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 06:47:55 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	danieller@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH ethtool 6/8] module-common: Add missing CMIS transmitter technologies
Date: Thu, 16 Jul 2026 09:45:30 +0300
Message-ID: <20260716064532.1522382-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716064532.1522382-1-idosch@nvidia.com>
References: <20260716064532.1522382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eed22de-9be1-4337-e65f-08dee3062a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|18002099003|22082099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1Z1Q+aEM3xyzfot97f1VUc0NXqyrB/WsacUNLkBn67UfTLQ3+shy5XPp75JF2vdWgSBg+bxsuVR+wrmroKMD3m1suEN0w6yR43ctDxSQ0A/8zVOQjigV1nI/6qcIJVSHGimqaDWVEDy4bS1AkQjwQUj/loQC9MEg+LOKv8q5nY7V6bsElV/bRjvOq99nRfK6Rc70tmMQ/a7MWV/62AzKG7WOfFtSsR5eeCfAah7CGx5l5tgkuDDiJSmtTNEODjKBxQIE4P4PTeNt1aGqou46ET7E3zhLCKj7aO0NtvW76AtjtWDpWzUGtNTO3+c5fZDLHllzP+uGUzpMoU/XCsQo0VsRBAv8Dqt6L4TovlY6j1ucRsF1Tr07WlbMQ1TJ41t2vL4K6V7hFZcOUZpZmg0jGmsJ3NW7jTh8MOvs4B03NFRp2b8ZYDhE3AwC4WWbLjiWliN7HvFlhphIQbv+Xxmb8t0C+0ie+5+ahngVhHSeGJiTnLGUT50cMeM7X/O1PtS910vhYyqJ7xFOIuFHoGbvjwlMeIoy9lejduvNHXTgVJ/X3tehpA6I46KI3h6bF44Ysm1OB/KyYNOcXW0pmUSbAw7Do8DJLeTFvtEM0TJgDP93nmnNVwlLnXa5+w45BHvK8QvDsLuLo42Xh032ZYpHFTzkM3+0bgfg2hqlRDgDl5U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kXse+U6sGeipNSXBCzmMUT/i/I5QsCsw3mH8k5nZaPkJ4nUH56w2Cbx9vlK0?=
 =?us-ascii?Q?mO/ghdRhnAsIrmfFZ4G+EWif1+iF+3hBZbNy8HhwMm+e0818e0MVLTPgymwO?=
 =?us-ascii?Q?hY+GV4vCbD8E8bncDzyfjFQ0kTyimq51pyj7xpEZzeg1e18KwK4W73s+21E1?=
 =?us-ascii?Q?MW/k4qFfUvtoXy7Ks1wEKxT2DAhxyk2VzXv7QQ8pH8dVLnEIRhizMojeX1RG?=
 =?us-ascii?Q?qXo7sxkXoi8nGdi/GmYQVUPudSSkAgxpBIjGLnrKt/lfPQcIZTPfXmIxIYrz?=
 =?us-ascii?Q?6KwwNsko6vRXRX9AAD/0e7KG5/+g/G/Tlav8zQUVmDrCIYI9ukqt8nxxt0+d?=
 =?us-ascii?Q?1tYj2xEb7EnbOUfzeKuIh4L/LD49d5SmByrCCegRcc2+kSmeJdmwUEOa3cY8?=
 =?us-ascii?Q?W7geqqc1fRppR/A/M4yZNmMYEVwD9OYOiRVxTDgzYo6X1HSeMA4vGBKgn/96?=
 =?us-ascii?Q?RWTr4BoaRHPehzTcQRZ5AiwP+xJ69tpRS/Tevji8N6Kr7lkU2PIq6LlcgLvM?=
 =?us-ascii?Q?eCrOUU3T5/6JXMm+q8NJePLwtwdsOyXxKE5XFAas1D7EUuW++ExAYZRxm6vM?=
 =?us-ascii?Q?8m9xgog5afflK9tC1luETfAoi//aFaMk1REz78x8uyVWT5RwkDF1GH9p4FtY?=
 =?us-ascii?Q?DdaU158kWote5EksGl6m8o5Lt6fvPg0mYMubTKyQl3W3Q30CygOwvO4Si8+i?=
 =?us-ascii?Q?L9nK4TN7vc51esmmwoMNd8kbWBOX+5zF/cmkWDt504Kci3S+jkcwZ8FU3KPA?=
 =?us-ascii?Q?X9VmRHPVNjl0ifL34+d7C75x+kYCtXxTCyVZgywvRxFURkRyjQ+eGjFf+Xrx?=
 =?us-ascii?Q?xEQtIFiolkitcMgC1/A0/PVKdRC/Q3fM7Uowu+TnopbBfjXUEFRDoa99D16e?=
 =?us-ascii?Q?3R9WQVgFBuikt23pjxofaK6B4WUKrTJWago3AKlPFVcb2Mp/etI5FPyzMv6+?=
 =?us-ascii?Q?JhiQqX8BGIMBxrIwpJ9kaniAbX3T8W+BD3G42+1zFjgGMiFwIR15ryBd0Kyn?=
 =?us-ascii?Q?AzQ7E9W/gnulGFJapT0ucna0NMgjKZvOtDBcLLvJUmIDR2S2mLTpaJ94B51e?=
 =?us-ascii?Q?CiavKq4XD8wahmaL+rcGKn5SM+w5aIyN+d1ym1Mqp/2dSUYm+27G6llwaleZ?=
 =?us-ascii?Q?Mg67LAwCes/VethcQMEdKAersjEOGmtg+Jy4mwt6YJWV/Cm6WPy0UGCwjUWR?=
 =?us-ascii?Q?RcAIyNMbjOCBTIbpBHtC5t7hFl0NAi5u1ENhzYhBXx5CYtM2zsyWnh0PTjBP?=
 =?us-ascii?Q?+8qdvFJIDB1NGsFcUkYfANgJ4OVqnMt3ILjSY+dqWiqQ0S2r4BzgfTftqcgL?=
 =?us-ascii?Q?sHaLdCQA3iwM7JRfSMP8oczduol3ePP9U2q8rqqVlhozJsO+Vf7MmtOlHwb2?=
 =?us-ascii?Q?B2X+bC/J09BksrllStTdL2es51N9PKw5J7duGBkUk0ntuZXRPGGRHGr15cqz?=
 =?us-ascii?Q?VyfXhTzk27jtH8iHl2nI2BaKNyadxciT0XeE9KTtRRI504i44/1WW5Aq2eg6?=
 =?us-ascii?Q?Z/AGwjC8qwjiWgWmZwV48X0Grg/71fkJ4a1de7PAhwotcouDyhOCD4oNZTVr?=
 =?us-ascii?Q?m+CTfpWZX1u3/qM40KX8s4ZlXJpZ8VKZX+bFBxZU4xzSoOL7J0TPydVpAUKI?=
 =?us-ascii?Q?IOcoxScftDXMxAq/RFqjvHu86mi7ChGDRS9kkK/Zwh5+8ibzrsR9udc9z6zs?=
 =?us-ascii?Q?c7wxoyOVU9uXeklFCj3p3UUDLWyXXrZGCel60UoFRyG3Uz3toKqFS/APYz4b?=
 =?us-ascii?Q?ugEC5ST63Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eed22de-9be1-4337-e65f-08dee3062a57
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:47:55.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIUiVOZw268vk1ccHidl6Q9JH9pDnVSZJECmkEmvAZfAP0Hsh5DjbUo2u/zp6JB0T+UrxrLrzJ+pp1UAg+VzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299

Add missing transmitter technologies from table 8-40 in CMIS 5.3. This
is a prerequisite for the next patch to help us distinguish between
copper and optical transceivers.

Fixes: 88ca347ef35a ("Add QSFP-DD support")
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 module-common.c | 18 ++++++++++++++++++
 module-common.h |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/module-common.c b/module-common.c
index ea4514ab3899..f8e4681d8d63 100644
--- a/module-common.c
+++ b/module-common.c
@@ -628,6 +628,24 @@ void module_show_mit_compliance(u16 value)
 		snprintf(description, SFF_MAX_DESC_LEN, "%s linear active equalizers",
 			 cc);
 		break;
+	case MODULE_TT_C_BAND_LASER:
+		strncpy(description, "C-band tunable laser", SFF_MAX_DESC_LEN);
+		break;
+	case MODULE_TT_L_BAND_LASER:
+		strncpy(description, "L-band tunable laser", SFF_MAX_DESC_LEN);
+		break;
+	case MODULE_TT_COPPER_NF_LINEAR:
+		snprintf(description, SFF_MAX_DESC_LEN,
+			 "%s near and far end linear active equalizers", cc);
+		break;
+	case MODULE_TT_COPPER_F_LINEAR:
+		snprintf(description, SFF_MAX_DESC_LEN,
+			 "%s far end linear active equalizers", cc);
+		break;
+	case MODULE_TT_COPPER_N_LINEAR:
+		snprintf(description, SFF_MAX_DESC_LEN,
+			 "%s near end linear active equalizers", cc);
+		break;
 	default:
 		strncpy(description, "Reserved or unknown", SFF_MAX_DESC_LEN);
 		break;
diff --git a/module-common.h b/module-common.h
index fba1d36f7f86..e9bf8c19a9bb 100644
--- a/module-common.h
+++ b/module-common.h
@@ -99,6 +99,11 @@ enum module_type {
 #define MODULE_TT_COPPER_F_EQUAL		0x0D
 #define MODULE_TT_COPPER_N_EQUAL		0x0E
 #define MODULE_TT_COPPER_LINEAR_EQUAL		0x0F
+#define MODULE_TT_C_BAND_LASER			0x10
+#define MODULE_TT_L_BAND_LASER			0x11
+#define MODULE_TT_COPPER_NF_LINEAR		0x12
+#define MODULE_TT_COPPER_F_LINEAR		0x13
+#define MODULE_TT_COPPER_N_LINEAR		0x14
 
 /* Module Flags (Page 0) */
 #define CMIS_VCC_AW_OFFSET			0x09
-- 
2.55.0

