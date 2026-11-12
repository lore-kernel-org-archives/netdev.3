Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794497501;
	b=OJVnEj9h00mSoM4bDPifYyxQZLY++HcvfVlBbb/Vwopmbn3jB1qLNJfuJrsHCxACECBA
	 MSJ9Czvl/qdV2BpjYvhEMsWrCsPLVMI3bF1JWTOwWi48Asysnom8uuk8b926cW0Q9HAaP
	 +hE1T9ELYtVi84DiNppqHs791lm1AHXJ73dm8bBIZQLuDXNbXtcg3xO/OdDix8CHq7uLr
	 bjeOVoDHzKyGwoMSiuoo2Rktf3UFlFszEik1omk0qHjVt/pkvJeFaEtFmqezyLSRCxBXK
	 GjJBqPItlwp+cbsyBYiJ7///11RqWzk6T0M7UevL5iw4HFfkJxa3sLIJq0FYIGGHOjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497501;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tuyxhvQNRsiGECIkdgOYgb/sR+3LrIdTdmkqp7XJET0=;
	b=NyifOnlvqY+rcHT6r2gvxC5jXxqCvo0obx5iuciPuf4LR3ecjrDdYt+5r7rJhZ+1audk
	 WJcEVwfJLdMQKZr8xyrymRocR3i1HrK2Pjiaot2fhZGpMVx0M1Cq+oF3Nb9DgV9LzNH55
	 takxSFt49a8rVI672YUXKDS9qlD9uCzf4v6lofwZDYBFpHqFQB6wtIhiSq6kFDpkTm6Lo
	 633CmvnI4LGVtvzevXXy4OprnRakUWzvkbMdLHFMncQesosbaqc5SGMxswWwt6vof+aTY
	 ie+8eZFYH1zVxrCfCDqpVKAFpKmktWB92ee1q6oUWUWCcjfvSpukFigiwbnMpDuKvGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=md1KEldz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.67
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F04E606A33F;
	Thu, 12 Nov 2026 15:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F04E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=md1KEldz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bICbYQzjFSJkEMhsTYIr3abUixS3JERGv6xK5Lqcm75pG/WhHZDtzKRqVAFseA7yIaHJNXJ5V3XWTd4VeUi734cCur0L/PHkFA5ikE2Q3aR0sJ1wj9RN0ItC5gcOYdNFv+I+1C2Dd54u/Ynan/ra2OgfKejpzOlIB65u/F4Zqo0iRHQPwfQ8PgJhMbd1nOvAmhKIGzE3T8v4dREC21b7FOhDhDJx9eb1IxIJHIRpTN17FNYrBSDKr9cU9x98Pq6XGWK2Y7rv5lbCGPJUFtDofvPqWsLmLNLPB+sRyYlzuCAkQzv2eHhkh+uFuvrfDAI5jaaBihYisGWogTJPPRwiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuyxhvQNRsiGECIkdgOYgb/sR+3LrIdTdmkqp7XJET0=;
 b=RGlSi14r2N86zIH9CXnxLMTgsBa3tVfpZl85N6hR9GL6GInBd+j7HP1JmXc9s6TUZmPm+8s0yYxPgneSrgguvrW+kH5W1Vh/i2leBNAv08ZgcfKSeb8DggrrW8dqcvAZ/whWGjHZCJoq426G5H52wi4120BOsEFor6h7tUMbqyQCYV2PoX35Wdl7SsipO89cpnbYOAuck1WI4lVMy9pxNxDJcdMWM436QuNUBQMgGmcJNmXt+F3MM4KBEFrzrngZlezpYTHo3Ybvs9pgS/aBEgcriNoM/KUEII7MGmn4zOITRxqg3t3yYRpx5c95DOVW5hQqQDT/iawZF/TQxQKejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuyxhvQNRsiGECIkdgOYgb/sR+3LrIdTdmkqp7XJET0=;
 b=md1KEldztdyh/kOwdkABtpJovpaW7lNiloYGpMxu3a7KsgzTCRuqioV+41lC46DrNgAquWl6vcXe/W5/S2032GJTGubaZfE+juJBhoMyE68D8dRfsT2q7hPW/7uTsXFIshMrlx3A/PhJVX6m7R4TqFnAIQnJnk2uQlFvj3CMu55af+PZHCn2ZVW5qxA+0vIMI2dg2B3ikRE9NSjsFaLmlMA1M33E7ZybaPSpSiDsXT96bbw3EIVMcXHBTZlhzav5CIOW0sZAFSulrNXnWdwJtSaqO2tE/7e4VU9PH3MQT6RxOkv+yh/MA1G4QHoxr2jlEVFuE38oz0QyjL4r+IGgBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 15:31:30 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 15:31:28 +0000
Date: Thu, 12 Nov 2026 17:31:15 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 2/3] ipv6: return EMSGSIZE when first route in
 dump does not fit
Message-ID: <20261112153115.GA3255418@shredder>
References: <20261110172925.3293312-1-stephen@networkplumber.org>
 <20261110172925.3293312-3-stephen@networkplumber.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110172925.3293312-3-stephen@networkplumber.org>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 447d277d-90d4-4f4d-5c2f-08df40d20389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006|10067099003|261102123227099003|261022075727099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	Rj200Tka34IBeAEQIfb7j66B0irYz5h4lzdd1qlMY0I/tFQVrDCQ47sOZBVkwI6b17AwpSbmA6fNQQajsCeDDCeuG0gTlWuuhPdWpcGyF8fU6fPK0gCLZFvOCd9H47bao8OM5xqZhlHSsL51WjKeR1+PAyEb8ZdT3+/i2QUNHFjL9DyOKBD5cWumuxGehjJhn57yPbStCikmkWd4EARWeVqTX0llyEX/dMxCbpKJJFMb59dcbZrV+iL4ReQMaqgHAUbpemuRj52wzdVQXD3mQ1Se8HtMZxMyd4KumIKPERGHg9U8HEK/6ZQbF/B3GyTvATq0EIbHNSOit7FRW2bLhZUR3PJxrTQMrLKdOVJqIQus5+USA3b/WeQwBkpkW4mlKJSG7StU5Hn122egSeA2zE9WifAjfKgFRWBjE1+oFqKmPGAjwaOs+J+9fYFCHGvp92d3L7FHwJem8ZtZgjrpj0Uyb25Jhj1c+UdjTrvRR4BS0AfEE2QPHC3lEdWLylp5KLW90cSHf3FmhhOlzoG/h8vhHuosVbbrw9Ult89bsoYMBem+h/lLowIoc90bpRPcakiEATESusVvOOzNPviLHNTyc2dqPa4woY5Bqa9VizMDRrZ7YiIfRXa+g1Cm0pjOyO3Gmbx6EyyM0kjGlsILbU4BdtW9WGdd1sLxDCDVvYQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022075727099003)(261026121527099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?onbgfxf4chE0EGuzKSFvaCJt4sA6ja3vvnWbWXB48GT6z4d7Rr3HR1Pzcx+o?=
 =?us-ascii?Q?WH9CgMEQAp/ROWlvysWGknH1u4pK/r3OeuR7Z2ixUToz6te+W6o74uqy36Kd?=
 =?us-ascii?Q?4JJ/fxIMdNPLymsJQgFPRubNSwmBp8dFVaVxxg0u76G48gVomrzvRfxpWfvM?=
 =?us-ascii?Q?8oTro4c6Z7RCXql/9by03qvFv6kF6C3Iqk8I6UkCdX52Fe955iwd1zdhfJcl?=
 =?us-ascii?Q?gcB4c1rcJT0+aZf5jXhAoTxbVaZyaZlXKrkQW8LFCUZVvNjmmQQ4by+NNIih?=
 =?us-ascii?Q?eX7nZ180K8sUlVp3fjfDuuQNzRu1b9AGPvEGS8Dt5IfRaQqdShKSOjeAnM4b?=
 =?us-ascii?Q?qliwo0vxd5PMPfsJ2V+y6xry6ekEZrOCMuVluCyGv+Sst33LPipkt7IVEFbC?=
 =?us-ascii?Q?od8JIlyPbGwwAoe4ZQXKgNhSmQBSHAMktDMDOyOrqyC8PlNq0Q/+AStalJ/+?=
 =?us-ascii?Q?O4/0p2LbYIh2rMZoEOn5tWzHZKI8/pFEST5Me8Q+NX9Dv9EfRl3Bko2mN1Xi?=
 =?us-ascii?Q?h37WLWCOL4q4/rxnrG3Rv8Q7HW4lKunH8Dy2v1Ro4tOUjicFflOJ/Yn59EKs?=
 =?us-ascii?Q?vk42tuc9RN1VqwpoYmxXGEGRnFSnjo9zV/wFGE/ZufL8WaazyFbb4yaCz/Jq?=
 =?us-ascii?Q?VRdXWmn5rj03eSHFnpqRrT0dvufqugel2o/Zim31MWN5cboczoRC2DuRvrCT?=
 =?us-ascii?Q?DcquDMuGjQAySbG6NbyX414zed5p2VOBjhVjxB8pzCc/FObkpq7dMcs3uXRS?=
 =?us-ascii?Q?EuHhFvHQ1nBmutJ0IpzTThLJcwA3ReDHomW8kyYBnF7zDcUR0dYtTakxI7SL?=
 =?us-ascii?Q?4VVitzPpECq5AKNO9kcebPU0ZsOT7LIkJFxYRRhzvb5T8UoZTSDHmzSSlfed?=
 =?us-ascii?Q?CNf/aHYQgbvHqvV2g3zTOuyXS0b0R0tcbPTvoHbsKl9sc5eR3BlO3x2b72Rk?=
 =?us-ascii?Q?wuLGVjDF/T+GaurNpsmxNLn1J6IVzgo4tm3km4LqcjfIkipNFQ/PWP2rxwhi?=
 =?us-ascii?Q?rWLpwEXWbkZlNzpXRMzCBK7NcI5rJAuJf68OB0U0J2BEFZU++2faK/w+pwvl?=
 =?us-ascii?Q?3ge0U3EIqck6WkZFqqJbf9ftKan4klWM2wCK7ihHsjmMlGsjrDGlKDe7oNTh?=
 =?us-ascii?Q?hDrMnIvDyYURLCAh2Z3g8OVbP+s8DNb0/B2HcpLX0GQvjXfYqxLIu6Qsd7S0?=
 =?us-ascii?Q?Ju1MEOWjbVLLs9oOYwFTTb6Ei0rMoxY2fCN2snFY4ciHCzzBeitX1+gEb49O?=
 =?us-ascii?Q?n/GeONKLsp98wiQ9T8X95QfWRh4KHRV2W0Ds6dScOOmjavipy3ijD+27EUUF?=
 =?us-ascii?Q?EmeaJjnv/uuS8rkya+SrRy7vgLF6o39p0410O9A3AHxad8OoxaUIh53jp2YO?=
 =?us-ascii?Q?61FZyzEhY/xifZXXHe6sOIRfnxQM2mDtpWEgpy/PQYY6y+a2NpdRf+JapAJx?=
 =?us-ascii?Q?x/mR0aRcYfAuqZgUxHzJgyn6HmN2p6h0Ty2BFKJpMVaufimT6d+nuXVJsw3A?=
 =?us-ascii?Q?f4j97dgXkkPNzLpTj7aaJoeduyHEcprshvfj+aSZ6WZpgn8N1rG4TJO3r3mZ?=
 =?us-ascii?Q?8h9kXV5C4QaUUlbWs/mBClyp0YjdQOeL155NUPwXWhzDjrbD/oquLdImuCqI?=
 =?us-ascii?Q?+dDCXIV201PmtB2DS/Y1cGTQmi8vekuThj42Wq/bzNx5NiwpUd2EMc/vupY1?=
 =?us-ascii?Q?ZHogref7ZPrmBIE423rLamRt9aPbvhWFcc8D1PEhr7ai50I9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447d277d-90d4-4f4d-5c2f-08df40d20389
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:31:27.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbmEUr1GWelBuxWh0HYsInBrzUFD24mq4NbGAL2Vhn/iELWBDk2NrQS0lnhvf9XzoE/WoTZGWzcZB9TrmraByA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923

On Tue, Nov 10, 2026 at 09:26:17AM -0800, Stephen Hemminger wrote:
> If a route does not fit in an empty dump skb, fib6_dump_node()
> suspends the walker and inet6_dump_fib() returns 1. rtnl_dumpit()
> then returns skb->len, which is 0, and the dump ends with NLMSG_DONE
> and status 0, silently dropping the route and those after it.
> 
> This became reachable when multipath routes started being dumped as a
> single message with an RTA_MULTIPATH attribute; a wide enough route no
> longer fits.
> 
> Return -EMSGSIZE in this case, as IPv4 does. This depends on the
> rtnl_dumpit() fix in the previous patch.
> 
> Fixes: beb1afac518d ("net: ipv6: Add support to dump multipath routes via RTA_MULTIPATH attribute")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

FWIW, given that "It takes some non real world stuff to do this", I
think these patches can be routed via net-next.
