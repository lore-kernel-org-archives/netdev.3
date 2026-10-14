Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA884A206F
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966477; cv=fail; b=iZ2MpZGSoird99J5DIN2QMdJcpu3ckRGru31U2nl5x89TFZkiWrOXcOuSHgwsctsv7v92uJsrKEMSudjFb+UjOHmFXufLXVsVa+BUxQ9gqF0rOHC5m4Hl621kbbKJ+3mvOOaUzuYHPRGC3thZcXb5awZizavnaBX/eF4f42ic2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966477; c=relaxed/simple;
	bh=X6TV4TOEMck5SidCcybK64+zZ5V+VmvdS+KabVxg7/4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B6pIQkJcQv3QNJKzb2OH/LvfvlOxXkyhhbZgHSoblir5zMBJt6KLQFgvHscZ7L3VpdAR/sPIXOD260rwU9eL+byug78Vw1X3xfyUIy1d/FOcW+z0heRN/+sthDnS3HWI9k5NxON3Hx9QqeVmDWxjmPitgJDND6rMG1v+lfJzYGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJ45hpmf; arc=fail smtp.client-ip=52.101.53.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJ45hpmf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQm0f1b+7uoFKGgSup/5hk+BsuqyzdbEKJDt3mJNjA5TKJjs0rL973BSdhd/+R07yAgAI0DBWE0RCdgp4nBGYaRnkSamfSu8dpGx58H4UxRkFTvKGNf79OOilxQNMa6kFBsr1o83HDhhop4RPOnElWRiGWQvmKhJFh8GEX3MaTvlELTYsda2rJdd8wkG5RrmXNIoXHBmb8OIhYO2uf2SkdhMc/sfpRoi0RzuUmQfqHqPDJQzGs0r4sbqTZj1N+/8hCDNUXjZVpi5W+OPhL0tRLT9XFFLb4JcoXrGYEV9XHq/ZzNHtvTpYUrsJFwfYZwxJ2R3tH5+hKAPGtBiJpr7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXFlEl/3B8PuQRSPU0gUARysfAj862Ux5c2xVNFh1jA=;
 b=NH/lpSSldHSwfbAeJkBrw03T+bd425tbdYT4xFvP6I8K4LJpM5tDtA4e+c59HdTdgUFCvAR4InApAc9r1iuxn1bNd6LWmvAvh8V5UBRANTVaqbmvMN5+pl0L9OUbSWRpLrkKZesqsXWkXoBxorzOlDZyfoy5D2v65rFppsEv3rj9C4TEOe85IlKom8hI67W0+ATZM9AnW64Yc9ba/h9E6+KxDpy5td6fLu1F+j++G0d6J5WiW+kXLGPFxjfgFo2Lgf6y1eMjLtIhYsEM6mnyy+ccYR6Bbw64PZ0xar+Xuzxh87rbo8XBYO634jDvjMhP2vmrgOxMmIPnDZeZBQkhxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXFlEl/3B8PuQRSPU0gUARysfAj862Ux5c2xVNFh1jA=;
 b=aJ45hpmfog0SmZODjqvugK/Lac2LkkYWV3ZCOjElOQbLpo5Q1xNmX7hnmIrD7nf8e7c5eVCOiFyRvKqu7X61cfrwPv87WlnZ5ssUuHArNVmryT5iqTLd+2ht2M1rxDAJsGtvWUA4XErdYUk7NHEwfcCIPV0jGNd7ohByTNcH1PROBPma8MJ17E6GNCuAjqRIsvk2KNtrnkJmTFTTfogOsB0oLTKqulmgGPuCsuttGHGmNfSiq2EFQU5p260Gbtd4VUFlswVgwuqHqLSF29nuIGWuuro7bcx3DwYSHwCi+nH3Kze4AFJ3r+w6dQAxbHM8TFCKpa4+zKiAz+ZSxAAt0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Wed, 14 Oct
 2026 08:27:47 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 08:27:47 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/2] ipv4: Remove netns argument from fib_table_lookup()
Date: Wed, 14 Oct 2026 11:26:10 +0300
Message-ID: <20261014082612.1280756-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0152.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bdb8b7-810c-41d2-6c10-08df29cd06d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|261009223027099003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I5xwNtfrn0Ul+7zjc4pmNsKmSVlKnmjhfa+F8MtASParmV3u6qreRrgA4jCmH4Jmnr/XOlsRU/lOuQeJZFEgxjRXOfKdJkzSYdYPb0Sk6fhmvwWVoKdCTdqZcYeLmhBz3wQre2DpdteQfs9F2YcGyIvTd3EwQlh69PVSU/WxfMhfeF+IpZHxhTigdk1Zbph+PjGqxqX2ELEdFWnoHexv0swKHf/7XSj7WE0/1/CbWpNkcYFFkP3EthYpvkKeWHT2aC6hvtudivWDTL/fmJbKFiJKqBS6TZuwkdFg1oXukEcQ5fQM0FAkWW2TTL+6+n86mXws7Ga9gK95H5tw9OZJFPcZiBXQ711J8vku5sXc+E3eN5AZ/CRMNcP22zYICO4b5+lOrhxnwOT2H9ASq4/lBpo7v81rlFzuLn97SicYAyxOy0qsEzswUvgZzbSAL5crfDw2i8BOWhNN1BImFM1aTGX+vtSHI9321V9wjgTK2hwm6Tlis9b8WHMQzj6pruhL7AQHcE5R74rsIEMyFi3Dz8Wsclpa/U4yJYdT8UR9X8LWeloKh1GQ8CjmvqDf6M53mU6+eyRZh2iVUIYKEliuZhRoOvDzaJawcbzGrsAkGCjqUZniN/8+Q7uThdRm0XOtWQZcyX6vNzl4G7i0okb+2y9BqVvW5TZHl3R7a/yBzic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261009223027099003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kTFFgBGGptn+4+JTefFvrLCSGDsQ+R1YCnh5X1Ca7gjJ7Kg9ED/IIabxa8ON?=
 =?us-ascii?Q?FQVO2+pkDrjow9ECZs8lbQR9j1awf9NjVsl/ngzexENzgR0YEvAPfVMxzS7c?=
 =?us-ascii?Q?L2xj/RdklEJ0xPYPCOGnXqI2z2OpkDEImTA8PzeYddMqtkyf/IL++9qcVuYR?=
 =?us-ascii?Q?ng9hDgUvbsRqkNdQh0eF43JWUuXu+BSQUvcf75ryXazNv2LCI6JlHrcuHLrJ?=
 =?us-ascii?Q?u1JTUetESfr2EbhwEU4B33YBXF2BVaqkRLnD15lvaqGqApgAg8lw0pRWUl8X?=
 =?us-ascii?Q?bkq6mZZSezQqFheOFc+0+VZNX6h8PudcvhvzYm6NFcw//mgiN45D+q+miAbw?=
 =?us-ascii?Q?PSRor9EOXQhRSi20n2vt8fXpH93E3KdIpJd/YGGwJVoFBhU5yA03JwrS9I/j?=
 =?us-ascii?Q?spkQZ3vVdBxoifGUuXp+2kYnBTPQVs5i9Cv2ok9vo1QMyOIeid+QWohor8O1?=
 =?us-ascii?Q?tXe8QX9qVW/RK+UqRcEmTXLN994k8G+o6k+EOjbDU45tI1azT0PTGjqbgfCn?=
 =?us-ascii?Q?vb8TnZRW2P5TXQDe2j57WdeGv/HLBONo4MFX1bdIG+znBQ6gnZmvVCijYGdg?=
 =?us-ascii?Q?/TtJMb2643BxgGQ8j5CrwIZUvlUwzn3b4vGXGtRcGpH7fy+dtMbsQre5Ssgp?=
 =?us-ascii?Q?gvxwGyOQND48MkWGcOe//n1y3g/UrCeoJm5R0mL+pmddyLrjInqlAv9PFYrP?=
 =?us-ascii?Q?KP93sHoMrbvdezO6YzLBQheOFWEQcHQmnl8kbrkIsnj02yryGLP75CJMULF6?=
 =?us-ascii?Q?froZArr4Ab9aNTElvOFzH+tyVMubr8wyM0C5Kk3ukaaUrQtAztR8HBMmplz8?=
 =?us-ascii?Q?XR/gWZZvDc/xpUIuVyfhCegRNH1NuFDDKh8yrFCaJBbFDr/ogvAWI5SDHeCb?=
 =?us-ascii?Q?U2Fwt1iWnmxk+G7MCigSVPWfBGvUegtMi+el9y6VBnmBTj8rf6ABmTGqWQez?=
 =?us-ascii?Q?m4s55hQ40FwBYWsGaGGIWuThZeGkP8+dfbzcFgYgFU+k6hUo8fdRtHeqzt3s?=
 =?us-ascii?Q?yT1TGJI3Q7pgUrjPhE/hESTzIO/saX8VKgyo7sXA652UEHiI0RGLHiqar5M9?=
 =?us-ascii?Q?AD/z0Bl9gmCie/2jL2MaFOdggt4dAXBM7efMGgCFD5AD9jhTkeOBEcoYLEMt?=
 =?us-ascii?Q?trrBD3nco58kRlvBmNYfem3ZSJi1vaB8zBp9R9VgcyOfBo+LWqH8edxTaPE2?=
 =?us-ascii?Q?bsDslVMIpIUGm7/d69i8lXF2uayV9zrkugcG0wUsz4awNAtjvrdoph1vr1Kr?=
 =?us-ascii?Q?yoGA+SXGmyvGtZE1VF0VLSpO/rhpzPwBYQk5RGwTEXmJIf/NQsaxnrYMRpo+?=
 =?us-ascii?Q?w/J/5ul9cNOkBMzupSl1BkiRcbTV9lh4bZaYHA9kBAqG1w36U2zb+Eee3zSl?=
 =?us-ascii?Q?gY0yjOyhpOmJoHhini9y/wjNJFrUsfcGSLJV1Y5JjqbCaqo01Pc62r1X/NjT?=
 =?us-ascii?Q?q77po5cGyrBOQedDg/vSHUOMWiZ5BR6YCZD2U5TXFPvEGAFPEtFK+gg6cI/m?=
 =?us-ascii?Q?mHSvMJ28GTgFIa+LiWgvzYsGx2IGyQyBmbXchWgHb73nM0qKTXOEJv27peZ4?=
 =?us-ascii?Q?ejqukcAzsksQ3rkXdpVYzjJwvZovt/Xq2P6yPZIXV7xXyU/98zIXnpg1kUd6?=
 =?us-ascii?Q?4UcvLxlUFXIRr25yq11RsbhI9FzWC7fkopeSJcYdWtKsVGx+9uEb76Ig6vjt?=
 =?us-ascii?Q?DFhKmdmeh61NBtlJq0F/hGLUc5cuO2j1X3mjzI8QLbbk1jJa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bdb8b7-810c-41d2-6c10-08df29cd06d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:27:47.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DPup0SaREIhsdG83st5K0UuXorepg0SWeFWz9Vdww6/mXlZk71IolDlk3/+AthZf6bz0gyItrKmC+XvbirUfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421

Commit c436a624f89e ("ipv4: Pass netns to fib_table_lookup()") added the
network namespace as an argument of fib_table_lookup() so that it could
be passed to the fib_table_lookup tracepoint. As noted by Paolo [1], the
function is called in the data path where the additional argument is
unnecessary overhead, as the namespace is only needed when the
tracepoint is enabled.

This patchset stores the namespace in the FIB table instead and passes
it from there to the tracepoint, so that the namespace is only read when
the tracepoint is enabled. The tracepoint itself is unchanged.

Patch #1 stores the namespace in the FIB table.

Patch #2 passes the namespace from the FIB table to the tracepoint and
reverts the signature of fib_table_lookup() and its callers to what they
were before the above commit.

No functional changes intended.

[1] https://lore.kernel.org/netdev/43857d08-c4f4-44ce-a0b3-0e7fcc56bf90@redhat.com/

Ido Schimmel (2):
  ipv4: Store netns in FIB table
  ipv4: Do not pass netns to fib_table_lookup()

 include/net/ip_fib.h     | 16 ++++++++--------
 net/core/filter.c        |  2 +-
 net/ipv4/devinet.c       |  3 +--
 net/ipv4/fib_frontend.c  | 12 +++++-------
 net/ipv4/fib_rules.c     |  2 +-
 net/ipv4/fib_semantics.c |  2 +-
 net/ipv4/fib_trie.c      | 22 +++++++++++++---------
 7 files changed, 30 insertions(+), 29 deletions(-)

-- 
2.56.0

