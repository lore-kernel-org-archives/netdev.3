Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671426CE39
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184506; cv=fail; b=cnMQ08vAw0ulUCq8dAWIgdMzEUUmKOC7xzeTuqKJ13WEg/hcv6ZccCsV+kYjisJPe7AkA2gg1EpZpIDH+KKVCIP6aw3o01fdY+5gmRbLXhBHxr8FDLRjYmGjo+B6akQHD7fsG7ZYFgbQco0Kq27pj/6slPv6/r/8RF4lnM9VREM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184506; c=relaxed/simple;
	bh=yWR1DJVn+E5j2pk+avqKyIsy61UgbZPuHBtMA8BT08k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iS1f6zg3uOThsk3nJ93oZjTJKOhSjkCHqaEHb5egQN2LX8uJI6jyc3wwED36O1y0UojAYAjxaH4yR9X59aiqXPBPGy97NKVf+83eBfwn5pvXp+dTe8NlcqFhvwaJrQFAZvCC9pttdw01HrgI3G2m5pE9gqllpYY4nrJt8jhfPFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Is2mNd4C; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Is2mNd4C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OscF+wvnVVNVP/qtP9k2XXwssCbPS5i4d2Wy04kMVKZz3im9Dd4SGkeJvoJ4xC4QbBxgh/znsuycpPsICBRY7otIZ3fCKNEAcBhplTSNgHKHTHWaBAtLiyiqrIdEgjxIRXTCbHHBa26maHIDPcm5NBzNQUrEwXrtaAvSnGrXu1Xgt4S5AOl9eUYbhUtdPL4irkxpJke2aY2iPsyuJiSg30jvV7mCwpzZsQ5JJAWg56SWOaPLz2+xYyV64ufGcf62eUUKgPm4hIc89Ipnfs9EfPWeXA15VOzB7lY2NqmtQkYePjsLw5blmIwao9mtFPF06+IzMBP1mQMokc4oO24t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+++k0Ecx7vL/bCMoRnysFDPMKtG7/zUscqKw6uwnc4=;
 b=gZ9Ds3neJzQf4fc4gjpMIhaISXJ6bz7wuUtiZa8ymcrA5PPqkVd0ogyrcnw7zSQZ08gQxVUfT1yM0EmvO8SQ1TVNth2iS8hLEOtk+IaFtH4Na/EwhJXUs5+gfwe0EgY63JMm6Ze26bfIw/e9pT5/a2XQ7wuhLWPmHEXNLF91bA2Cr1SYU/JzivAgWUrv0hImEHrjT7dqiliRwhqZuG9ps7rm54Ez2hRyFzfujOAzpOdV0HPJBpJ+CjV0nLtrdF4taKOU+EHUH78w6mhg0dTwPM2PvlCkVn4gXHEhtjshH1AG/0s7cvDzDy3iahLB0AzUqXXMyOiRiEKlxcH8BprGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+++k0Ecx7vL/bCMoRnysFDPMKtG7/zUscqKw6uwnc4=;
 b=Is2mNd4CqfIGknplEs96mHNPBkkZwCXgO209I8eH598b3RBHl+7egufKN2fVw7j18eQqKW8EOynkPkaIL6EL0jfx2VLYBgCCwD9RvyfBiI/DAy9WzSafXO67/qUgS832vdYzYCp/tLPWE2Z0MXfskkxK+QoW3E1DZQMAxwOvpEHgpL4p1Y3BSvF0OisBYEI3hJ0F/TCScM0W4SW4ZiYBpF5UNHlOKHcK3VHZx4wMADSZLRZaW22tZ8Jnxa5hk0evXuy26aUZc8HOtdLuaSvodFX8E1mkY5E3tD1jV6SUSKtRzJFKAodV1Js5ZhwC843gz5/QeAUML6fjpEcCCrIM4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:48:21 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 06:48:21 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	danieller@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH ethtool 8/8] cmis: Fix printing of link length
Date: Thu, 16 Jul 2026 09:45:32 +0300
Message-ID: <20260716064532.1522382-9-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716064532.1522382-1-idosch@nvidia.com>
References: <20260716064532.1522382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fde76a-7caa-4eee-eed8-08dee30639a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	H+v76zI/Td7+Q5UOYSaieA4RMo6I4XHvjdPnvH5bHWhJfVCSOrLvWjUkUEpkz2+Xa/kJ/of+Z5X5BFbnBIYi/m+6dJb3944yo1lgSdtwlI1edrk7v4m+zbvmA4+WdUyKI1h0HvLHIiT/ju9+ks3nD+nNrX63XmCfgwrsNf4T89KxdhnqmEAe/bGYCe+oC1Suz6SpWuCIeXiHXdckmzfyrzVjB1CEYI4Kzb4F1VG8HDA1vaF7z6TStIpPWdcCSstrJzZvwAHd0IlVMdfeGSYPPHFlnd/BlYet1Ir8q5rYQT6nl0jQQsk9pYMGbFGoW/lca9WAtz6wr4sw87HsFE+2+Cq7k8GGKNK3NpzxnUlGKnINDRsEPLPVxGar/NTD//QF0TXcIy72986pB1mOC71P+XbG10Wcd0C+tcmiYXmjkX6NnddZmAUSOjZQWk9IuKM9rpoDT7iqzpKXu7bgI4c74rEmrNH4/H7/cJa6NQlF7D9cnuptIAbXb7Rbp8aSUWFrLWcaVy2hVCnP2WQ3EyU6cvZ/W2FzIVzSH+TVFwW69z0KoxxKIZ2ld6ib1R0F+5SxGIqLZmmCNTwgM3yB544nLPKT4Nsl0pRXOcN2QQA42O9Sl8u6aigr8E1/OmtwyCo/SvPJ4GCmmB7NwPn2FT2Kud4Y2ucR2ay/AeJHHL04lpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NKT9t/wArhV9mL6Y633jQ66BB5bNH8gPRtN1lMkzkPGs0N+cJGj1js/CEc5z?=
 =?us-ascii?Q?Vw592ASjVJ4z25MlWjbYE34oV6cGTpldIPfa0hVisi99oCAaU86BhO+x6lLe?=
 =?us-ascii?Q?3+uIRiH4TkCjVYUiQ6eewudMPxetcSR2qvIcgxz3aB0cbksyjz6pvD3SxOEP?=
 =?us-ascii?Q?2g3aH+gvQE8FohBaihQcMk7HZDuXv+OKsbXX2vEst5Xw6RCa2CGBj9p7OFoR?=
 =?us-ascii?Q?tqCpJsdy0MO2XBlC9ESeBmnsRAuIz2TiF3EgvqBAXHf7gLa8VupUi2dspc4k?=
 =?us-ascii?Q?Z5Xy2zdzmoOSEXUifF7bTdilmQ7TuxkZL4sOamFNopf50bWzd9r3gyPfnke0?=
 =?us-ascii?Q?oXreUlX9aA7KJo3j9rR59MfBkRZgwAf6hzYtI2Rgm1SztrFQS6I70qOitONU?=
 =?us-ascii?Q?lbbW+BVS7KihxOyPRIQcSd0f50NvtI/8Mjl/SNp8OhN3NP+nyHSnccyWhOUw?=
 =?us-ascii?Q?r+DijSzIC3E2hnb8olQTlYibCIXULeCFmLE7J2JBeFj2OxO8mcFZbWsAKNVu?=
 =?us-ascii?Q?P1TLGT6mg3FORYz3g4NcODPg6K7m/pB7BvC85JszdhbOx1E7mH3i0nofCTL0?=
 =?us-ascii?Q?oM8ZMCqNHDBLDYOuG5AxL6I4Clwyw4KpebpiQbmJSDOnEfzRatjjsd/n01Lr?=
 =?us-ascii?Q?R3gWhJo8xl942OAEpFEyWpFuSVAfbJkhVKrEm956d8jbIEoQHSyrzreQ8B7L?=
 =?us-ascii?Q?J+MGBZSao09wdvGUkr3JHRPDLJzx0svKaJTE/l26TH1BPNz9MFJxj22dRlRs?=
 =?us-ascii?Q?4M6+dgGaGPPIFpaXzfGioaaul6TRS/epgRgRLDJTulBmxY7VaSW/QzmfdDyE?=
 =?us-ascii?Q?cxqCKF7400i7N414I1r21cC4GBm+MzV6c4xp40upMpats3DCc5xwXiK9PAQD?=
 =?us-ascii?Q?4Rr69nre3kE5iU2eeiQR1ec4xvcYEAlUEErRIOSuQQp+cFeJEX09ahIR0TcC?=
 =?us-ascii?Q?VvL0BAKVLsVkpF9piIkT+Te3CT6or3VW98h52mQF/kraZxMCAus3MLWwxz4R?=
 =?us-ascii?Q?NDTWXf/By8QJn9zoLYiZYzWq1HHGOZE2E3miPO39OYw0Da7zFuGmmHELPlkX?=
 =?us-ascii?Q?8e4vtK3cyR9vD5ylgiGzV8gu+Z5DejzxbxkjIhJt9D2O+d67ghPBLKKqQvDR?=
 =?us-ascii?Q?6DvEbYdStVzqhcbfIeqghj28zkVMyN2onihwmytly4hNK9DwromvzLlRWDPQ?=
 =?us-ascii?Q?oJWNfENsTsnQJ42TkKVJKBIUgtksQrNvITcckz/HvqsikwH1FbZTGu3I5iJU?=
 =?us-ascii?Q?JqF6ekBiQlM9mMIVrACfBgfbgxN3GvYou6Yn42DtLL9pFd+iWtFc1pK3b8OO?=
 =?us-ascii?Q?SqipAWPZyLoUzWCwG0ScCHuVAH3Fd4VFfVrrqdQRPWeWAJvzbrj4Zvb0o88V?=
 =?us-ascii?Q?46wh2h7q++Ywcaev7NZC/WrIPXol7R7OtcRfMAXURVP/sXPdAN4t7kgAnUxn?=
 =?us-ascii?Q?ItryAYvaXd76qHHL3p8Q5eWBT8S13lwvoamfYm09p+8psWUW4IWRLfp+OI0U?=
 =?us-ascii?Q?XzsF6qhyrBK4W0wNsc3jCQkfG29ncxJIWIg9b+wXNwlOzgMrbDDiTIwz8GB/?=
 =?us-ascii?Q?caDk2XVgYVGkhUqHKj8EOR122zWFxnsn6/07Jg9P4Unl3jWe/rqgr4DazFgd?=
 =?us-ascii?Q?AtJfXTps9y+b3n+E/NEgzzjjUmsyxm94GY1vdUwVBhfXboxJp1YGRNVdKMJx?=
 =?us-ascii?Q?ePKvP4OMKjqho4v7enz/hGGclt4C3ZooR8SINAXklPJY28m2FP+remv2f2Bn?=
 =?us-ascii?Q?uzg8AxEHnA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fde76a-7caa-4eee-eed8-08dee30639a6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:48:21.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QB9Wed1uFbMdiRAF8FDKmg/EFgWbOaWpbYIiBUlQ/ygDsCnV1TIUXY1HTUWRUu92X6NC6uFv/h5UNqYE+WE2eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299

The CMIS parser only supports link length multipliers of 0.1 and 1, but
revision 5.0 of the specification (May 2021) added a multiplier of 10
and revision 5.3 (September 2024) added multipliers of 50, 100, 200 and
500.

Add support for the missing multipliers.

Fixes: 88ca347ef35a ("Add QSFP-DD support")
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 cmis.c | 8 +++++++-
 cmis.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/cmis.c b/cmis.c
index 351e18484854..7a7e928ebb2f 100644
--- a/cmis.c
+++ b/cmis.c
@@ -188,6 +188,7 @@ static void cmis_show_cbl_asm_len(const struct cmis_memory_map *map)
  */
 static void cmis_print_smf_cbl_len(const struct cmis_memory_map *map)
 {
+	static const float smf_mul2[] = { 50.0f, 100.0f, 200.0f, 500.0f };
 	static const char *fn = "Length (SMF)";
 	float mul = 1.0f;
 	float val = 0.0f;
@@ -203,7 +204,12 @@ static void cmis_print_smf_cbl_len(const struct cmis_memory_map *map)
 	case CMIS_MULTIPLIER_01:
 		mul = 1.0f;
 		break;
-	default:
+	case CMIS_MULTIPLIER_10:
+		mul = 10.0f;
+		break;
+	case CMIS_MULTIPLIER_11:
+		mul = smf_mul2[(map->page_01h[CMIS_SMF_LEN_MUL2_OFFSET] &
+				CMIS_LEN_MUL_MASK) >> 6];
 		break;
 	}
 
diff --git a/cmis.h b/cmis.h
index 82fd2456a3ec..387809e00cd5 100644
--- a/cmis.h
+++ b/cmis.h
@@ -120,6 +120,7 @@
 #define CMIS_OM4_LEN_OFFSET			0x86
 #define CMIS_OM3_LEN_OFFSET			0x87
 #define CMIS_OM2_LEN_OFFSET			0x88
+#define CMIS_SMF_LEN_MUL2_OFFSET		0x89
 
 /* Wavelength (Page 1) */
 #define CMIS_NOM_WAVELENGTH_MSB			0x8A
-- 
2.55.0

