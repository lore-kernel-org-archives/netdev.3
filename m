Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794217787;
	b=HOXCu+jxHtyRZknZc8sTaNS7CJuW6GAU5L0pXOqddk4TYTqNuhXaqQTjSaz3oHLw43/d
	 /EMUomRDujD+q02Bt7KciTKj9nYcvth9NalDia6wOG+CIe2og1hGOdMaAZRIqVO5kio9l
	 upQjZhGhLNKAY4WoI1bwcm4XxCa3gLg0Rtoh6VRZvVdK1D7UY/gawNeGgPFBTh7A92cTc
	 tSr9KgdvagRIRVHrZ+MaXoQ0wljVnq+8u9TqdeoHwurf1SrLvQRlraNTTv3phGSWzpQ8C
	 HMH9MOTaNxFnnOW7cnQiMFHZbOaf4D2AvxRj+wjVo6FGUALCZBVJpZDc+ayjPzzt0Aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217787;
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
	bh=elmYpMyESpXBF9VJQETJIKb36O+dd3Pcs0hdgF/ym+A=;
	b=wVP5BMulrnuUZY2gpa6H7cZcKC0ZhjS5s2WA79E5lUULfIFmDcB8EiYusSem4swY12nZ
	 4bmlbvJRVqLuc5jPllm9O4LG5qIzgUFi/XAJemp4oNZ//bvlbk239ztaK/Olvt/0uKtV7
	 KKGRoa+r51mgvLArOGq6M8jveVUnAAzEHoorS+k66GO4jUEW92UlEfuCASvFBy5b8E0eB
	 szJuCjAbFKHo+uVZ9R1WyA1LX40JCjXD9F7dMcbJKBYjWURH/N1CSbfSKNLmUxpcYYgmG
	 QmvpAX/gfp2ujcVn2S2W6yPzdI8HAvXi/MvVRqw7DKjx1TLL2H35B3DOb09OsdaJ2lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I52mdj7B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.49
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9B606A31C;
	Mon,  9 Nov 2026 09:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D9B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I52mdj7B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNUHED5xE2zL6/8YdTtifuoPg+V06yQmo8NOMAWRzTUFMZ/zk2U2Zq1IZQV81h9u864WKHw9IlIku+Icp/N0sW13ZPgZBTh4vnopyHeXvxDzQ/NSBV7NuVarLCDXytqDXrQCJ/PU/eyuAjV0GjptuhAQmidXW/TJQTAE6k7giqcHQMyUssfTxYnibuoH/KMcmhIUv0E9RLBRcwvgz0BagMSs5wU+ct9m5vO2gTLJTC2ESKqLzU6ED0TZexvr7gx1TqxBFXfD0qfRjyz33TbiKFXxI5Wwpg5zRxfZQhiiRABq0bv3Qy3KFj6AOwDG+H9Ovv8yW5ulKvJYILUJpSctXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elmYpMyESpXBF9VJQETJIKb36O+dd3Pcs0hdgF/ym+A=;
 b=KLHS0tLRrWf5cowGafb25zAT7sSYJBCRWs1IbkQsRboSI1zTNygK/qTMPcd2zm+cQslOXqPV54UGqh6WjPLdTKZ+JfNX8KfAhWh3HdBsiH9jsAOfkB3KteT/NbNWlT+ihF3n4GN5qb4/h6JN6tQw5/WW+KIgghhFqXX6wl1E1kDOaX0dLOkc5FygERyTH2RuKid/3StxGiD5I1fTX4uQa2mzV6liaxP72Lv6QPCgasp6XV/JhxvPcj4Mk6CAlcdmJRuPy2PH+Dlo1ucr57EVwShL+kjsh/+PVPdHThaPCCqutPsUKgqV7xx6okJzy4yHROjw2Hrxq0YAjJG7shQuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elmYpMyESpXBF9VJQETJIKb36O+dd3Pcs0hdgF/ym+A=;
 b=I52mdj7BmCMN0E4hHKU/lAssFLjctc3g7CUiYwlQu4wfOaOht2f5cVPZsImXg3Zdl+CDrLUOUtvQzOXfh9PUM5dEz0tIHCEhxAUP6WMJToX7qALaz9b5ZB9l5otMqieC4gbxJWnPGyntB3xlM3A4AOdloimPCw5kOfuHPclScEjt0NslMby62YEj1uILRdfm8Ea6HLiYhCjflrHXpFaLpykWg8eWyagr7F2dXUqj0FJoHg5qRMbWTzuVI3hHvk75u6GQN7jC3wyo+qyj6jz7LdLzwt3jauAxCy/KB24iIigXhYVKHgjo8OcqBAf5pu2bWoKeTV3h79rPa2V2Zw2QSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:49:43 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:49:43 +0000
Date: Mon, 9 Nov 2026 11:49:34 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	yana06070@163.com
Subject: Re: [PATCH net-next v2] ipv4/ipv6: preserve multicast filters after
 a failed source leave
Message-ID: <20261109094934.GA1537299@shredder>
References: <20261104061419.87989-1-yanxia@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104061419.87989-1-yanxia@cmss.chinamobile.com>
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ef6136-3139-49f2-2f9b-08df3e46c7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006|261028144727099003|261026121527099003|261102123227099003|261026130827099003|261022115727099003|261022113327099003|261022075727099003|261022105027099003|261021135927099003|261021130227099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	V6nCz5gCle3rVN0MaH8uPlp3mqtkys7AG3y5I0O5DKt0V6s4ivg8GsOlRK5JKTecI0uhwoHuhbKVal+59rxjZvaHV/9Sl9ah7nynRTakc8b2/EG04/AwLmewikLTlKv6Wu+hf1IS0cjf9J4UV3mn9i0qxQRwUtpINBv885nlFJt86w27tkVr7jHdSOE+W1Lgq3em3O/dkGO2wezR/tm4GRrf1/ShmWLrUpFrC+3J7bVJbbWadi2xO+HwWM+6Ku2EZXUGOgZlxbOQB4c9NkbdeB+fDzzyRwSWEPv1/B6jJQD0ixL5AV4H9SAMH5O/1wpryi1d0r1dAw/W45FZd4o4JMoSUFmZ5PhzxISunVJiRaEQvMc4V6iaUFYcq/kXICccfdQiclJRWC3qnoNvpSYu0z7MxDWoWWjc2DFWv7tQyrIUIgpl0wijfNtaU0Wu27jsKfx5ar3XZfBxN/l6Q9225JrbbAy3iFlTj3L0bZeIvaZm0iBVUjlJghNq8LoFux47HmPuRmGvxqVudbTAJGcw6Cp2cDTCUiGKduhR5QToncfWvm1yUtRspQUn3Jb9hWK5i0m59DoYIuc9F/X1H52JmApylQF+zf3bEKlxq6/QO5O0uxHBBvj/TV+LF5CoPURnQET1uXr0xxtqbVGnN+aN3hi4xu+Gwq/JE8T8rbeo6bY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261026130827099003)(261022115727099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021135927099003)(261021130227099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wF0Am63Uunqgxdb6OO5HCZZGY8VdKSQZkturKdvNLtUjN6Uf4tKixSvXwxG5?=
 =?us-ascii?Q?5kAS0uKTodKAiBKFP2Gd5Q1SaylirFAmdG1P6rOYRoYhWqBzWyp3ooIwNhF6?=
 =?us-ascii?Q?A74hUoJO1BzE/VurtMzakd8G0CpXMTH7iTHWdLasoRqLeILBF1v+kvHR6San?=
 =?us-ascii?Q?wGS/mLgzktQ8lUYW4zfjpMv4+xlBDWUM50dsjpYMofo25sqcV9IFDzC9m3y7?=
 =?us-ascii?Q?+pVK9EqM0NWGbtktAPCUiqgJYyUv6k8c+xrGzNKTkLyJECi4uohh22wWMmhz?=
 =?us-ascii?Q?E9RhQETZ04sSPR9p56LXmKGCreu9xkivc6dAcYqv2yOL4g6yndrg4UDhdDUL?=
 =?us-ascii?Q?AsgRIBGu4ZCatOQeXv08lkl/B/EkFFZL8auAlkZB2PplQ8axePgT0ZkuMSSK?=
 =?us-ascii?Q?s/UEZ7scLJ4hy7DCvJmWCMwLDKvtgjgRGte7Xpm3JQQ13HsiAVM5O/KvOXXh?=
 =?us-ascii?Q?I7ZD3vLWwu7Z5ZEwjt6xM014mnGFf2kJLTGgruccQfFo0NIOqUf2qcC4AU44?=
 =?us-ascii?Q?A5NOHEVy69+5j48jtswK635NH1CD1X1iPUyUyjvV+YnBPdsdYMx199hJq60S?=
 =?us-ascii?Q?cim4tt9X1yJ18UF60m11EGDCcUsAgISz9KkpBIbpy90ZiSaQ1Xp4SMzBJef1?=
 =?us-ascii?Q?WNSD8vLkKC9lHdKK01LPEapkOr524sgK3KEpenSgnGpaYIizj7yI+D8SgGec?=
 =?us-ascii?Q?ZMcXZPAYR5JR/Ybc3mxIYURj/zQRPhwpY3jnUh+rz+Qa5s/rGrk1hOkPcV/o?=
 =?us-ascii?Q?38Z8w6TeOw+SdmfftW33/s/ebRl0EQfWMs1sDU9iNhP9wDb9mCETvNKtwTxe?=
 =?us-ascii?Q?6P4OEJ4E+ME4U5a2cFU5WMppNOMGcX+RdQ0ZFKsR+fxvkgzMjmi1E33kFqZB?=
 =?us-ascii?Q?4vIFVXv4Bfz8hzqeBNGII3ebyK9qmmNnh8CrBQfU5i1NxoLFdCfHPMX/xSqH?=
 =?us-ascii?Q?EFTEdEbn3Vguoe/YQ6URwgnUavTW4JKb19dNhK1BmTMherNmNno9T+pPYque?=
 =?us-ascii?Q?RzA8p/Vlz/OoJjH3GY7g62bIKc2BgIqbwKB7eDfjJM70QfTyi4MAxf8qqyhf?=
 =?us-ascii?Q?UhcAe97A8SCM64tXeB32xUXQact+YKDNHbAhdXdOMNVlykwVTRiGJp5DJD5P?=
 =?us-ascii?Q?OObBqkbPsWSyBdrWuK7l6ylZlJK7UcK/o2fuLT5CIzQftRUAEB/jn16ueTpK?=
 =?us-ascii?Q?saz/FCrkd2iz/5mf11uhOqzrPXhk3w7iaoU80TOlXc/UdSdyqhZaysFUXavu?=
 =?us-ascii?Q?aKxLlfuK/Wn0oaXN5UZdIOhWHDc2pUKz4eI50uz6CAAO655iYWdqdQ6Q2bLh?=
 =?us-ascii?Q?lpZxCL0EICQLZIbd98rm76/huGgsDcLhiS1JKur+igYYmCUXYn5bFQdzwFL6?=
 =?us-ascii?Q?bpDe/r0lvFC8h4OtxFiYjnhVUS62iiIByHZ/rlG1ERyBrX2lTWK2pMXMQzYu?=
 =?us-ascii?Q?JpA9rh/gEjxHztgOIZcM6UoPy2yqnsGnhtombbgIyn4uFqur8gqjjis6h7Ba?=
 =?us-ascii?Q?Sldw+xUPHrTDVljrB/W9kbPAkawVIllJS4jiVIMUDOeEltzYlSI6jDtB1Pcu?=
 =?us-ascii?Q?Y4AC9azTAUsjzLjvCURDtQuPrkohqAuUONdSStqzDxr7Nc8CnHKxLO4VTZp2?=
 =?us-ascii?Q?l98WuDsvRJdvrHh1hfzY5oPNQqVsrBKXC1B4wedyySlUhGREn9S6pSgBe2jE?=
 =?us-ascii?Q?h2zGTBo5ftifphaZciM/wSGlxT3p6ncVi79V2DJvfKPGp8tl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ef6136-3139-49f2-2f9b-08df3e46c7e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:49:43.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aeo5pWHmKSjD1D0APkMuuv3mYN9EryUEqxJhq+AQryp07NcyfZEKRXid3LfAh4OE3km5O8pSLTdocjGDur3Rrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908

On Wed, Nov 04, 2026 at 02:14:19PM +0800, Xia Yan wrote:
> After joining a group with IP_ADD_MEMBERSHIP or IPV6_JOIN_GROUP,
> MCAST_LEAVE_SOURCE_GROUP for an unjoined source returns EADDRNOTAVAIL
> but switches the socket's filter mode, so the existing membership stops
> receiving. Leaving and rejoining the group restores reception.
> IP_DROP_SOURCE_MEMBERSHIP has the same problem.
> 
> ip_mc_source() and ip6_mc_source() allow an empty-filter mode switch before
> checking whether a source list exists for deletion. The failed request
> changes EXCLUDE {} to INCLUDE {}, so the socket no longer accepts packets
> from any source.
> 
> Check for a missing source list before changing the filter mode. Preserve
> EADDRNOTAVAIL for the rejected deletion and keep mode switches for valid
> source additions.
> 
> Found while reviewing the error paths of ip_mc_source() and
> ip6_mc_source().
> The reproducer uses socket calls without kernel changes or fault injection.
> 
> Tested with a UDP socket reproducer under UML using the IPv4 generic and
> legacy APIs and the IPv6 generic API. All three paths lose reception
> before this change and keep receiving with the fix. Source joins and
> leaves, block/unblock, last-source leave, and ordinary leave/rejoin also
> pass.
> 
> W=1 x86_64 builds with derived allmodconfig and allyesconfig configurations
> also pass, with no changes to the warning sets.
> 
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
