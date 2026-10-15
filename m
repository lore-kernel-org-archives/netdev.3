Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E063AB5C3;
	Thu, 15 Oct 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074736; cv=fail; b=FOXoRoPt/q11nwlDLIpBjL+MQ4YVKx9vq0Rl0iEaNlFBRtPGt7SBHG+dgUPsshycFHJodwmrYmqsr8KGuP/gABy1EX1PrNiXhgqjpuumhqlAsmHV3oSPI1PQprYKj6O/GN86XzLsdsz5wEHpJpq4/8Nz24FZn+7gclQc6o0x+IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074736; c=relaxed/simple;
	bh=ExBTkkS4TkW2GWxfBXe6DLPu0Jd1mdaz5FQ+khRFLww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b1Rfd3TV9YzxpaOCDBoVl5NS7wVLSJRyrV9RXqtSkmTCTOvQhff01Tjfm6e/jlwXUButFMjVA+m/V1AVvpYwal5T21NwnVsFg9lnSoz6FInyo4r9HzyYybCUDUS80ZBeYFxr1VbMDmzDwl109fIt3GKFzo0sQzr68EOjyilnTVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WuOEPWyw; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WuOEPWyw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dr77SEu4Zc6M+bZv+yRoEzyIfDRDMPAzEKfUKvRhzv+Tpo0tstyH2noG8Z1TVnPKOyzFhSZalchUjA0rvHWY5ULLumDHA3lqnzvCS6veyHZLWU9HspVnECpgqD+EEb4AGh0bDjmw9u+eog2IBFjWHUYhrIVHxtvFFo2N3sy2XmPjgQ7QlvSFYh1103YKqHHCLbYj54KNUOtDiYif/SK59m9ogttAhsRpN9DIbLkeT5KSIlWTiYfaF1LayBkjn8INkFDMdGQ9z2BThFuiJn70nrZZG7MjrIInQ1XFzrjtryKg5jbCI/HGNhSZZxIY2m7JwDefiREM9/ZePrJFifI3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXdrfzDakkCXdkLzL+cfjuA2dgLEEY4vG2g+u0HkYNY=;
 b=G66ZSMjBCfAsvkiDmo+EF2X+YdLWtWknscSTklTxBAxEGs8lfrUNcHdUyRDfrHCMUd0hZkAY5ShyCXQH9zmxQ+VKSGLLkrC4ukp/1WyPkc+/pcPCHXEP9oK91sgRmmItl48s/SgA0dcuqYOak9QFp6+k+vU3URbDN+SgA8TNX+r02+Bn4lDxGEveEeIH/r8z5T/xN8yaOWM2XQyyVJjCdZA/J6P1vc0QZeqd/r/CBYOF2jqmvlrsaEGUNSjP2o2HY5E4nr43Qd6uzQjgpdIFYXQ+uGP6l+ynObIJ/khQgloDHsZjp0Zw0r5HSt/lIRXJfrDv5CwxRr6O0pnhCCXoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXdrfzDakkCXdkLzL+cfjuA2dgLEEY4vG2g+u0HkYNY=;
 b=WuOEPWyw7EFmU2+ry8r+4UHE1iPT1+GekLzsoSb1b6Cksk+JgFAIEnuMQzptiDSnmKc9/yJZZEWlmUPvL6lDe78MfrPWqWCo6eB1c631XcN4BNUjhaWZ4t72l6Yy5lZEUf9Ldec7Afi1AxhHfC6tJaBBXxuvi6EGLdhPZL1V/upz7o2HKfxiHTbTGtKGPdePgJEfhhIYUGPCSsYG7pohIDBp99UqusKICSgm6zftVn3O5DihhSeeOmqzeqJtzYH6K8p75kZd8I9SQH7294DGoGbA6dQbebnwHzb3aneXYoZb5hjzfRzSSjoKUOFlTWutRz6G2RCXg4rCIP9+9BZdCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:32:09 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:32:02 +0000
Date: Thu, 15 Oct 2026 17:31:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/4] ipv6: remove ifaddr from hash during ifdown
 list cleanup
Message-ID: <20261015143153.GA1794897@shredder>
References: <20261015050651.1841557-1-4ncienth@gmail.com>
 <20261015050651.1841557-2-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015050651.1841557-2-4ncienth@gmail.com>
X-ClientProxiedBy: MR1P264CA0161.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::9) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 30152ec0-316e-4085-403e-08df2ac913e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|6133799003|22082099003|18002099003|10067099003|4143699003|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	oWv4itZnnV4ISx107hzYipr6rC38QwP2+nO4ouH09RC8S0pO7zd91MpIMxpz1R8GkxMsYeLhihKoyBXCt8lmXX2v2UolUyEHs0+SoK/HwZ7ImI67n2WKlaoOr3qmHdg9Oe5XmnuDKl+DUD03jwB8iazJsqSfKg1U93+Pp76thUPp0VXS4Sn6RmqjOAZxG34B/YQ7/OyQI2YvDHW6sDm7s/e6MUhyNof1Rj9BU95mjSjBwfnKcI2WtUnMa9JHR2cmGNFpRUTUaX/6hbeVRDD/nP2C1MD9YUyXI2W8k842nLOi+jIJCYYfZFJEH7E8SMw8Zs+V/DXifitjzW49YvW8fT8++Bma1jW6HEkpdBUC4Vhie1kG4AU5C7SKkBziBZsJqx0zgTmWIOdVQKES62Fe6fyC1cUebeJ9M/UkO8UXBcJE1Pf93AS/MGOficuWiNfxNayfwRx54PXJJnm0pqKAb/i0j7uEhMNgeXDRhhmOblhzdeSRp4xih/oCicg9vc2cgifvNZvK6QHbVNMvN9xFaYj+A2lUd7xkAPWkTSKYfLOtCGGoPBC3R08iV4eUmQMpx6dIeD69N2nbN0mUOrIWtPbq/BI/bcP859cLKtgXcRHQZuVEj/qLhp+FnMKm3AGsl4gEB4kowHFhEl8835S5ZPzxHwBTZrYbr2VrDpbqjgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v6IPK3nu54BPkjxIWPWxXLBG0xRHNr8cMHDr0yXIGWXPKbZmHm0pTi9MoPi0?=
 =?us-ascii?Q?pxtLdkbPgzAwTTRvTrl7y7mXkPqAbPvrYg+hWqNm21OD0tcDXdk1/fRAXoIO?=
 =?us-ascii?Q?yxtcG2Zo/TlmkXAB6LxfXOeAuuZemHEC0RejFXq0qRqrtFATd25dx7uy6oAt?=
 =?us-ascii?Q?3YdSesjqtHxpxQ1j7oYOCjnYubKCJmVLxZcK7/7G2+HRFDZaTXqmno5YQTiK?=
 =?us-ascii?Q?1Wl6eNdJnzE5rOtfZlQJTKSRhmN2Umt/YRWTmUnh439neCMI1vtPcvfELoKs?=
 =?us-ascii?Q?hHM8J83DoHIWnrqn91O4uzq36jBN6GaVlG43L1fZ4w40xW48e/mw/vP3DSp3?=
 =?us-ascii?Q?IPhqX9OK0GnTW52HMFLzLaKhSrQNImmc8RpTwZBqwqkpeNo7Hq42hYZy+k0Y?=
 =?us-ascii?Q?T5EBrVjCDB+LWeE8aV79TRho1tKwq5HAwmR7cKpMbTmQLYZQstf1L5IDVB7Z?=
 =?us-ascii?Q?Wk2IlzGC8VytEfuUe4hYUy9Gi77bZFS9nhgjXgv+F9WBg6CSNrgtenzu7Iaf?=
 =?us-ascii?Q?H+OIwqhES8jFRRXrBt5vvWjMoO5/wzBlwKuZJIaTb8S/SFx/+YDGWucQG/Qb?=
 =?us-ascii?Q?8bxRBO+8Q8mF/zvrZ80xghKjvZuf622vxyNLsGT2X84x6gNbF2tweDg0yMxW?=
 =?us-ascii?Q?udwVpcJ2JXuFcct7imFw333SXaoHkxPZ5LISoaTyCsMJ/mg310pkR4ZxES5Y?=
 =?us-ascii?Q?MV17HmtJ49v71SkohliiMi1TZ4JmfrWIk7REW73SpqmsqpKdceNGK2jl0+bA?=
 =?us-ascii?Q?bJ9CFkIXjdK9OwJgbZW7/zogug5BrB29NpI16DPmdfvgZVplvR5vxv1WaJgp?=
 =?us-ascii?Q?GaObvZcFcBuYAEtYmXWy3LYoeIKDB6M/37Oq57vPSbuCB6Ki24CoeXyNVFer?=
 =?us-ascii?Q?6cD9cJZp0cZXl69vKIkSwHATikho+xuql+kstZQ35DXs2t/JV5Mlg1NODK6i?=
 =?us-ascii?Q?5KWQFrAfWjoB5av6HzyvVjAPZqZxMYhwTNJWa9VK4CqHxuAdCSWbET0fa6N2?=
 =?us-ascii?Q?NCFRRF1SnAMulVbIDVJ2HLUR40DjW9OqZEc3uHWT6rVxJsvRZfCnV5DV4uj4?=
 =?us-ascii?Q?cXWwjJpR4FGTnua0jgrDxMElWckGLh4J5opSM1lKxiFPpbqOh96A/Y5AcWTi?=
 =?us-ascii?Q?6y94H72qMW9FM/tZCITYWb0Qf2qxKKwob349Jja/2UbRIAFEnTJVYJ7smUhf?=
 =?us-ascii?Q?SYKMGFyboZ+Umik1VXXbT855yhdwbsANsq4NdOifRqsw/y41eLxbM6dz/osU?=
 =?us-ascii?Q?Buu37vZuBvDo8osgJDUeN+FGl2i99alvQRB7UTTZBOMAbNbgK3hWmgqj4Low?=
 =?us-ascii?Q?Zz8ckdNoHOEhy1q7wMAakto+Qk5PXwiLPGyYhoX4tOpgUWirxU62sVZXNPlK?=
 =?us-ascii?Q?XrORMGRSXzYJAhwBmyHiU+N6Nx/KsLAMatFtBGz7eAXQSWpyp/zKp5GX/7a4?=
 =?us-ascii?Q?mFhrM19l+GyP1DoD+Tg7knV9ooI905puNXDO7Azc6gH3eHcyhuKz13Oce3Rt?=
 =?us-ascii?Q?MQn9El11kHKhAdvtWS5eGd7gokpj3AXGdr/1pzjZ1pzW0wCm20sCCGa9vOLJ?=
 =?us-ascii?Q?DSR7a0rQrtO9yzwWqVT+ACJsroPQd9Ow5Zaiv3Z6ERC51ZuT8L3jpkvAsoEB?=
 =?us-ascii?Q?BU9u9iNEqcYEUyovrdLZCk57p2iGUnE4f1OztCYrBP32QG9Yw9TGhSFRkncw?=
 =?us-ascii?Q?VAgnybozQYWbgu+xoMkb6kPMYhacvrJ6p3eqe4aqv2ECgJd/kZu6CfBAiDR1?=
 =?us-ascii?Q?wdkvqsPciA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30152ec0-316e-4085-403e-08df2ac913e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:32:02.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0iViBBk0sWPpGg/myWe/neJ4GHsXsMzONAWp+cqSrcpFaumyTw9nPUHRy9mK9eTLRkUagpaZR8QNJND4Vgm0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

On Thu, Oct 15, 2026 at 02:06:48PM +0900, Daehyeon Ko wrote:
> addrconf_ifdown() clears the address hash before snapshotting the
> per-device address list. A concurrent ipv6_add_addr() can publish an
> address after the hash scan and before the list snapshot.
> 
> The ifdown path then removes the address from the device list and drops
> the list-owned reference while it is still linked in the hash. Once the
> remaining references are released, inet6_ifa_finish_destroy() warns, but
> a DEAD address continues to kfree_rcu(). The hash therefore points to
> freed memory that later RCU walkers can dereference.
> 
> This follow-on was found by source review and was not separately
> triggered at runtime.
> 
> Remove each non-kept address from the hash immediately before removing
> it from the per-device list. Keeping it hashed through the delete
> notification blocks same-address publication until NETDEV_DOWN has been
> delivered. hlist_del_init_rcu() is safe when the earlier hash scan
> already removed the address.
> 
> This handles a late publisher captured by the list snapshot. The next
> change serializes publication with teardown so an add cannot miss both
> observations. Both changes are required when backporting the complete fix.
> 
> Fixes: 73a8bd74e261 ("ipv6: Revert 'administrative down' address handling changes.")
> Cc: stable@vger.kernel.org
> Reported-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/r/20261004135117.GA206930@shredder
> Link: https://lore.kernel.org/r/179161099539.434549.2238120015372268173@kernel.org
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
