Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC5466B57
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634005; cv=fail; b=Hu6xaFnpmGy9Fw9ygRqXldq7pcMnXoNS94e/5Edn/7cgc3ccrIpYagQtbeng0FxyHgDfLJLT5Qom5yPBOPnmaWCujuLrvk57Tk2DvThWQzJk2DctpcDO2GXPtHzY6eI8ggchPaRjKejRm4j9ahYBY3eBiKY2ACKicUJy3l6MXEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634005; c=relaxed/simple;
	bh=FfdAX4PqqOUbh2Zux1JBn+dmnX0XZ20gtoMPjnaHBUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TxS9upahEjNV8P0SD+aMf7IXQU+L03t/farPKD1HjmbUesJ7gDSERztfyaaSajzs9D2AbnXBktrgpRbQildAfT9umH72bge+wH/HKh5+wFvkKQAsO7euVFfaq4JqL/2vglFct1FjlXoQHo6XxKdKcajGK9vMJA0GYd1e7H3wNzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YwtijyFr; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YwtijyFr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siZT302zccAqYmZR0enNJ3dVU/bFEHBbnKyPwEKHWdg3xmFLncgNteZBzc+B1X8xzGVZFpAZruVopYrKwk0y2UqLFbWiGsfQNn2OTfmtEfeD27U6hPsxQqUyHk5XHebROV5IvkxHNFvfTKz2D1tigIemaDOieKEnydMugASPHwumAjvjwqf7D8HALPfh0gqTdJJpgeZfhl23Fw0CO/yoYx8EsQvVuITUkmcuC7pShQtoyjsrnPhZtiVR7LjF1beSHUT/N5Rh/t7O5Dzhm3kW/vIWwNhmFtuOnsUGFfcf38KOpNCCk1pJTKnDfD0hlptxwOhBh0SjYOsB1VlU8phydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oWTXzT0lXybKchJFvCqvMdjjSKY1AN6M0pAheE2E+Y=;
 b=wmM3FF3pcb1Mr0u/PxGZajY5js9/lYlgzhCe1rnitv2uX4KYO5zR+IVafibnVXHD2tv9J9g5WTgoLrezJVRecaSlTgd7HIZD38w9EGAX+Ez1EVHXMW2hPpFYXdDTW/SFqdvPpj0cQmR5Ljy5DycZJZFU8gnszmqR5mNXsRpcj9AgBgoaIJBiEvXdZM5kBCs2DHPuKHJqw1kKqI7clAqix3zm4E3hxG/hIBx6IVS1pswwH0rRzPOJa/rKvUk3JJl3Zk/OBt27t+JrRAD82F49a7CskPFXxHwLvx2n7JQLSFx0Za2krPtfdwNcK+hgRqCvMaudTtyeI8D+mgcHtCPyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oWTXzT0lXybKchJFvCqvMdjjSKY1AN6M0pAheE2E+Y=;
 b=YwtijyFr5hGiPGJUKdyXujo1irXDkowtsebdUep4cjdeeqkEdXda2I+YRpfdLXymy7AVu/esSF7cNFzzfclVw1fGt6kvqreZN6++zgU7bLZuqfm9AZyXmV8mRqRsreY3omMbt00mGpzF3mDh4/mWBTLl+EAh79C8+1PgAIc5vwYPTbdXmxX/p64tG0eAo2RnfHvA+xy0R+c9awBPDPwHGIHHRR946D33UiWoyA0B9SI6Jz+wJbeQnVOflnAV0AFpdfUa3ymYL59TZoBkg7DeTL1+afpQgiey3u4lWnxurk9UczSNcAmOZp4NuoZS+1wY1MFrDEZuJ6oMK7SKbQPCqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Tue, 21 Jul
 2026 11:40:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 11:40:00 +0000
Date: Tue, 21 Jul 2026 14:39:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	dsahern@kernel.org
Subject: Re: [PATCH 1/3 net-next] ipv4: remove unnecessary reset of position
 pointer
Message-ID: <20260721113950.GA2592863@shredder>
References: <20260716203713.17392-1-fmancera@suse.de>
 <20260716203713.17392-2-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716203713.17392-2-fmancera@suse.de>
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c8cdfe-b07c-47a6-f11f-08dee71ccc36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oLDluczIsnsZ4eODVlhDWuYJygBdC5ONZSOZbhKFfHmyGo3pCOIYJiXJXmQvAGsiajc7G9cnRpZLxu2hJg4YYYCbFbQnLUwup4K13IvclasntCdQd9b4mXWrPkelz8yJMF+le5YPwPHrCAC9niJWuRKF3xtlLGfYZayfJQgcJ9ryg+6hWdaHbxLsjdBQMsFDMs4kSTziJ0aFPpCkXwN7F6bS33WKMvFYqxFhdqqGkYq2Yy2iT6DO7fdDMbVyA1GrKlUVBAMVO3Pk7eBjG3f+uWgqkEINK9Uq+hIOJHCajRD7vSFBX88XlDSPz6Qp4eJXoutGtF6Qp5Ryx5XSK7nLPh5IBV9jPxomOX6jxfvkLeaw5nZDmBrngoY85Qc39dpgWdioLocVB9Bbcj2aw5cEJMDNvWO3ZSbBdW0UlxKA1zYp6JBxRWmLlHLPviPlhQq9TtypxuwSmjbrh2Nm4Szl/47gI/fvaICeFAHpanh17dG7cHxa+SgG16DQXBHGIUcqIzeuEzCK4Fi83kvcb/ntBdwwqsOpiFgwg1Iv+682LjlC8hKESeT43XYzksQ2sVjpHRsqsUpIr9G0PKedWCLlnwFkt4ZRGv8iZ+5IVHKJJ6sm2nyiE5lkpuF7eg9HkXO2EGphEPoN+g64IizRK8/PyqQBybNIE8bNCvSB8OC0qmw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rKS+a5vIcFyQI1hsaYk7zctM7AMhvtul7DNY7pVYfCIe7q0nDlE1zpCcB4ou?=
 =?us-ascii?Q?Y1zjbbQMjY/l1uLCjyav2KoCZ8EiY6RKVJrpyPKJvlQnN0lkG2cDXo6XtaB8?=
 =?us-ascii?Q?43NHaWWNAGRDQqmOujEYbfDrQuomuvftHtDuUP0cr2bOflwhlAnbxtZDjGuz?=
 =?us-ascii?Q?p1wrEXAG905K4ln1ziX8XSZUeY+m5t2VNq1nstdEnUbpMwMb21J8utTVfr2u?=
 =?us-ascii?Q?TR3zceCXfvkbcLMxQBKx80qZO3eIs36veuvnYzBh+lQ4t/IEXp9jdRbm+iVO?=
 =?us-ascii?Q?EKhywmrUWuoCedFFbXZnOQYQXH2VVJmwuCUpMPJuzFqe0xECL0EoIQn56/W7?=
 =?us-ascii?Q?z0/W0nuOKKvhzPKGLjCjhrdD4DSRsj7oBnjnz6bSk4AxX99qCapO1FzzO0DV?=
 =?us-ascii?Q?TksVXBbluBMNU88izaW86Au+3bNhWnL+CmBdPWUJ1XTMUZO+2CXvnAg2L0lr?=
 =?us-ascii?Q?qz/hL7890xs8K23lNSF96naK1eVPsxKi7d7+wagdcm1t9bCEfSvptQR00c7V?=
 =?us-ascii?Q?69bMwIyRIhbJcB0UeT7Bcmbq2GUjL1MTwNy3JW7w6gyt5q0R/qbV/AYnr8nJ?=
 =?us-ascii?Q?wwe39W48Sg1Nge0SuOA8AhRMoKDh2OZw9dt1SnZKhHVhMXN+olYjwJJpoKiY?=
 =?us-ascii?Q?Xu8L28r/h5tEg4oeaace5VIF3JSNILadiN7WKkxUSSFX7K1teM0JNEACVtGC?=
 =?us-ascii?Q?9Q3bq1bnm87napmldDDBGQfBAmdzYLPv/F9lwvYhZQ/8cJj04u5TmZ9NOId5?=
 =?us-ascii?Q?DnQWExoaj+LQRarTtpt8sOKXqDT7fS4J/Rv56OiD5UrokyVSK+7G70IKydiq?=
 =?us-ascii?Q?jAF2klfcsmRPX8x/5nXMFyI4QlUgqWQ5KNBeGjZ/vH3+RDdGTI3WxTow3XX3?=
 =?us-ascii?Q?qR5c4isgquTVIn2FHDJ0jkYg9ASbDNIEkoAovxqCuhj+l+mm/QZXup/aQ0GR?=
 =?us-ascii?Q?61vOAfPUnZQPpsoNTg9+T1BrtvRzmvUVPVN+SoX3R190W2SzwvwXi07uBp7g?=
 =?us-ascii?Q?PPUzd8JS6K/1KdKkchM+rhs7vEaC07R5Ftc+5mSaXmMjcM9G70pjO/peOra0?=
 =?us-ascii?Q?HpeeIBSA9fyhnCOKq1WxSL+Q5mT325lKEy/dA2kQhKwnv/gCQaezHU7qJTzd?=
 =?us-ascii?Q?irRD0/DAVNHaxfI+4o+qgS4nyjw40N/kLkj3tWNfuRD8n9xJImj2Da+YbMN6?=
 =?us-ascii?Q?Sda6J0YetriQePhXFGfmPS0G/BoyGUAVZ/7c+Q5gJnnVxcQm0eZU7tj6kPn3?=
 =?us-ascii?Q?rrjSiN4VXuHSKJ5zySVWH3OtWROpymPvWQsErdxwhdD/wmX2hkMtECSsNteY?=
 =?us-ascii?Q?1yKgQY9yNEXJjrSn2WnN5q4H59DJ4x1QHYKBBwqKBeTO3OL7il3lKSxhdUmE?=
 =?us-ascii?Q?cl+j1vCecnNf6hQMpRxusAmi5HPb1a1mRqgVDHCpqmaxgFZgPB6l8ADtSqxT?=
 =?us-ascii?Q?1kVqwFX8Gt/NfAGTSMchzNPnqT7VW2X+fZuFuv+sdKCpBoNV44Wc0XcD2Z87?=
 =?us-ascii?Q?rKZwveGE3t/90yV2Igur/zVtQp9rdvAqhepxvHvpATgGuTNtSbtrOqJ8okxn?=
 =?us-ascii?Q?3MBv5mdL9buj3JCA+jJExdmnNW3sUbVQpl99Y2mb5tWwlER4G+eV19VL0G15?=
 =?us-ascii?Q?oaFF7aeFIVJwNF0Y+NXlXnSCF67Dnt7rel1oA5k7jSLZea5wz587zCDJYz8+?=
 =?us-ascii?Q?3P9jEoD1q0Uv9iPhMnqCF6mc5dxxcP1OOWYTm1cj0n+H7kYsvxVdFwKP4PMF?=
 =?us-ascii?Q?MaCwDcZBMA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c8cdfe-b07c-47a6-f11f-08dee71ccc36
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:40:00.5592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Mu4dzfSjqK407IgmSF+o6sRf6v6xi/jO2S5BGs4oOM/nPjcFbonp/y3B3Uyl07N7V8hHZjWD4CokzSYOYhFYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756

On Thu, Jul 16, 2026 at 10:37:11PM +0200, Fernando Fernandez Mancera wrote:
> The position pointer is only advanced if the return value of the proc
> handler is positive at new_sync_write(). Therefore no need to manually
> reset it when doing error handling.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
