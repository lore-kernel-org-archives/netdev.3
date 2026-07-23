Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E70353A7A
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784797755; cv=fail; b=aRtRfIB+7JYi7Ue09wPWgvqzZmRSGtE1inU9jmEZ+AKbS4MkIUHn2knKQyjXTUJh0ZK3FscLEMWYv+WCoFFWI6JpTVfEVI2NzuJDDyDdesXse89fDaIbg5oN5iRr+bT0YJEnwVUVIdIN7UXhC2TPY0HU+85YwbWZ7pgUGSlv0FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784797755; c=relaxed/simple;
	bh=U5jTJhMWy0tXKcVgzwr5r1eeQTjc/kEW3VJvnqmvSHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t3Qj3X/bSpMjP5eEE7XT+wnMqhkG4KvkITaytqMM/GtIsVB+SkR/EBPHf5gIMv0YpWb5Jjec3NQzU+jZr2T+qgkzG+O5wJFaR0fHYlLGYpcCu4Zpe8j9UgfnrU/CNfgfzGacm/D4m5K48xKXgzw6gfVuhrztP295fEfa1mb4KSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FYi8QeiT; arc=fail smtp.client-ip=52.101.62.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FYi8QeiT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzri/8U0VuYSgbwokLP6xRZtush/q5qPexFMY/KwITdoxwthB433lnfFfjafiq1cg9LKAo5Q9Vh1M3XURKF9TreeiujNz3Iwj4t+F+RJfDo94M2JxM5JpzprPcTDgzhWJCSRXuSfohqXMrotsfK/fJDunegkWee5XzVr2iWSv7/XI5dH2DIp/PZRj1QDMmUR4f8gPLWubVBAWnTa9sOLpLQFqUINpa2oG2gCT/iwKEQBIm7j7BAdMyv5A22t12cwsFpNNaolPNfK8kzBVQwwS6z9woijCP45LZ6qcys3oqFWgReQFx7H+mG3UHRSlhmqCfinnai30Na+5t8jHhV1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxm72SADb8y8K/ePCm9vUaoKF+LKi2huWdVvdCj8x3A=;
 b=M6fx4EjRs6R0wDAUhP/k3v1l7vrShm7JJ93El4QTpUzI2YjvuIRGOvRAVfXLK6963Q9VX2/zD0ODnaKbfV1JrFHYaOCJRNc6ATg0ABV76X+Vj/MOWPrrzxB4lhDt2vnBJB/ysMw9Sm0mjArOv9QSv7n3PM1XouQPFjl/ZRKUloLUyEgQjkKfmyj3XhJgfGCnRQR5Eo2hGrxyUfldBx3LoaHEZCXh7OBEQUo7o817zzV6L3l8kBxrDytyE9qF8ehn6b2eoUjd0xzGVXwHkJtvaPuUDBbNDiyAtzOApPDeDXdui1gwhNvvL0Fb2aagwawAURFnHBP3ZQtE5vBbfdi5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxm72SADb8y8K/ePCm9vUaoKF+LKi2huWdVvdCj8x3A=;
 b=FYi8QeiTc3Tdf17UGEYClx9MTV/Z5xrkPyRTkYsgoCZZCB8Xw17yuOuG1Qga9FVC7O1IGNtzS+qnxG6sqRuvLi09/j6qttY74+exKG8wly6/Y8S2A0XHSJHONAHePBL/nlLVk7OaHpwjlPOCGfwqwu/g4ABC7eAcriyypFMcNaA/eIxKK8X1+V/sBrEKQWegCi/ZZzMi7yuN4aCT2oXeCwxl1GP6WuW5kNze5/5ED+0Gfe6kfoiVtfWvGvpJS8WWgrSxEJaTrg8yBQuzHBligzYVXxxC/NpxbAfX1d4MQHzuGYb417WcoKo1YBM0EZGhBgPEGNmbBFrfHw6EInCzhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:09:09 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:09:08 +0000
Date: Thu, 23 Jul 2026 12:08:58 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: jch@thehaxbys.co.uk
Cc: dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] net/ipv4: discard icmp timestamp requests
Message-ID: <20260723090858.GA3224213@shredder>
References: <20260722102441.8762-1-jch@thehaxbys.co.uk>
 <20260722102441.8762-2-jch@thehaxbys.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722102441.8762-2-jch@thehaxbys.co.uk>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: c898ffe9-f88f-4883-352b-08dee89a0d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|4143699003|56012099006|4133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LE3HEKRsI033pYs9I77/XJbbqMk3a3NDB0vJsaBULz2GioaerYcMXlgIPaqBBl/WZ9k0WPovrbda1tiR0X/KDpFcDRdEV39k1QBLdSSlg+QJp0d8WNMYMaDwIKz7zY1lczBgaNuIg7d+QzPwsi83aBVawNd6d0qn53fskhERiUs1G4mSOKZ2NGjhfCd8u46cEkedEqe5smHgcjMMjdntrJBOmtYnMIIN+luO65TjtR4mdLur8yjQpT/J3DekufHsOX5p5otXPnXUj0equ2VHXk9NfKnyrzpCVgYpEumqsqC/WjJBIWQoIOauhqUlhyscRPmjhwhKA8+/yeE2NQimcWUME/QxW7WKzSx45AM9SvusouxqhLvMMwZNpFkTw1sxjoBgdKLeSHoaXFPEkiZZ0OGU28DUBQtOrHtowwD63LXbjS5i4q7LCKmrGcu7YnhiCHhut7SUVoUidcZV9GStTI53ogUqTODRsoniTpbmd9Pnk7xDajb2w2a74HT6TYFyYn5wyjlMirRbDqhzoAZMPRbPi34nqrmCYFN85wIks3WcvhVoAl5q7CeC1fzpE6Q8UrY6OoVaCPzDViKCk3OZzlMFRUf6ZyDczGtgM7xJJFI6Z3AEMv+ulqysRT9hG8aV0Ri66Oca+ukexqrBe/zKyezWltfkVFWJRzDGJjcDosY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(4133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?suS1AN+SpuWDFQdkAf/PZJy7onVyF7tqkYbZIYuh4GbN7glOMavH4801ifFN?=
 =?us-ascii?Q?fmjAniYP7sI2fOuJ72WJp26K9BPQpAGfo3AgtZl8o4C09pB1Dur7UR1CSBYW?=
 =?us-ascii?Q?yREjMmEunBKEGdWkbg+qXx+xNrVMn7KV+04gv30t/yXDpIvmJtuWlYdH39Ea?=
 =?us-ascii?Q?rQIID+hlg2H8oeK8h4hwvHa1/dA0QdYmQseZ5fdlfUj9iwhWP8wAnl4Wok50?=
 =?us-ascii?Q?tAqBLZHi+xM4ZiwcOM0qgr/k71x0Vzy/K4eQqhtkQ+lfo+OMdfKZF8eEXr5z?=
 =?us-ascii?Q?T+BBWhWwTTRfsVOZ5HscNXBO9pw8KFCO/zxocae3iMVLGvbCiaFG8H4xPCMf?=
 =?us-ascii?Q?SVihSd12V4LbdHhYGR5W3295jAKUr2exC85m9w/Et2JsU+WfwgHr5bHQXbQk?=
 =?us-ascii?Q?9DzRMVveyFLlGXlozCGpP1uved8mxvZt+tm9lvRctUjhTsvMed+bRjdG3BpS?=
 =?us-ascii?Q?rWNy1a/7ryVoiWTAwMmqF0McANVKtDBAW9m3sDbk/++SJLS+ZHkOwSqM3ear?=
 =?us-ascii?Q?ZrnfHksPwgfqV4OU4aFxgOml4G8X3ZGOnPuHHLIRxms/puEdftATeleiaH9K?=
 =?us-ascii?Q?nfKzb9rtTE9K0lRjn0EdMogx/brmCSdqgq3tawhoBh/jXVniYTZlvB47EYpF?=
 =?us-ascii?Q?tnbs8GQNK1gmcqzBUDN5LyyYA0pQNrtQN5yVBEU1cdOavFeJqrsltxmh6FVy?=
 =?us-ascii?Q?+aDXvcn5YlT7NzhW7M1jA2zBmVOhI4r8ktAvxA8EW0jVuOtXOFJdZN8jEsCV?=
 =?us-ascii?Q?STyGn90e5JNZ4SGsSfXG8wZOHGwt/+p9gqnVOPwoOVyQszJddNjONwpSfdnr?=
 =?us-ascii?Q?SKL5G6DdBVRIBtIk+1zrW7QhKTYYQxAnlr5RhxM3LUNF0TVX7uI2NUiZcaGb?=
 =?us-ascii?Q?R0b/79RgkT9Hk3Mv1R/Hsf0Shh7LhWBBxqQ6bMUh7NAH0etXouypedrkScTz?=
 =?us-ascii?Q?EchnxErRmz9QseExXtnuyOTLChs8egb3rsZ6LQmtTQmzlwoj9SnMvvga/Cyg?=
 =?us-ascii?Q?Oy7moOjuF83Sn6OmmAXWj8CmCFf9IR0BvoMouC+7xxXomkgUWbAuLNp/oMb1?=
 =?us-ascii?Q?e5bZ5kn6Xsxm+EfvPquh0fmJo4vDUe429vHEJASfEjUAYUMdipgTCu0O+TR0?=
 =?us-ascii?Q?73q6SFy1X5iQWk1UL6g6pa2wbJ70W3dYqTg2YGyyPcvfrKxS14fizyDKb0Dj?=
 =?us-ascii?Q?BQyvO9A3ehPcUtY8P0bPkTOFc0kEzp9eQbdxPT44fxOBq9rV0HfT7RFbmd6a?=
 =?us-ascii?Q?Jp5sKmxsJqKenW24IrKBYsK+fQVclNS7XatoCPDvUnhVm/uFpRBzenBC5YeZ?=
 =?us-ascii?Q?8TbB9Xfw2kFBa+pXk1LGjXGNMLZwfvxXn0KqmM3EZbDyNlx5nCMP8C2eBM4m?=
 =?us-ascii?Q?K5WARh4/Vx6dKxfw9kokMbDwVkl4FDGBNY1MLXxEn5zx0cmvTOxvT92Fy//O?=
 =?us-ascii?Q?+Upixai7PYIeI4RxncCAQ8Mbk80+IaBCEK1B9qBQD3R2ln1wdo1cgGTa9aIP?=
 =?us-ascii?Q?8+iYCMnNiOZIBXnRwHEnQDrnPFtKIVWKIldP6/I2SGsQ++F4Vi3Ij8MJwsvQ?=
 =?us-ascii?Q?57PjYQsRujOr/iGpCadoiPEQwp+Mie1XaSObd80t1Ifnj9OZ9Yj5zhp8wQNQ?=
 =?us-ascii?Q?gg0hsB/hMNijGmJeMZhAWmTsTHxk8G83U8xk2EVVrx2kYdSb+5p85R5366gQ?=
 =?us-ascii?Q?XlLSu8iQPDeNDy8t2srL3hKE3YDYcDevkt/rkWwqJAbcmOb5AVPKHEXZwHol?=
 =?us-ascii?Q?FH3s3Vfxzg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c898ffe9-f88f-4883-352b-08dee89a0d92
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:09:08.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q62hAIwuTfLu4GIcucHLdsxzBIcxPZP8jq9ouQ7G2NGjiwRMDY0T1rGsrg99nDjncOLvPjcOKIaE7CM2uzwEMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565

On Wed, Jul 22, 2026 at 11:24:41AM +0100, jch@thehaxbys.co.uk wrote:
> An icmp timestamp request is classed a a minor security vulnerability
> (CVE-1999-0524) due to an information leak.  As pretty much everything
> uses NTP these days, it's not as though this is an actual problem but
> scanners flag this so for everyone's sake, let's just discard timestamp
> requests.

The idea was discussed in the past and was rejected:

https://lore.kernel.org/netdev/1557711193-7284-1-git-send-email-chenweilong@huawei.com/
https://lore.kernel.org/netdev/1557754137-100816-1-git-send-email-chenweilong@huawei.com/
https://lore.kernel.org/netdev/20240520165335899feIJEvG6iuT4f7FBU6ctk@zte.com.cn/

I don't see a reason to revisit this.
