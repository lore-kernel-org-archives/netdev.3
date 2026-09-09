Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BF3AC0E6
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936171; cv=fail; b=dMEgfsoFOTiyuTlgU9NgONJ/+gHwYSw18LKvXt2H3SewtP0MlFm7a6iwiiTXaKlotL2zjMYbBC/O62xCdYok1vGSo2DXR5vfgiY3s3n5WgXys+aECJe6B/HDeCLMxrzUjaYNo73kGmoFH7sJk18v+cG2cfSTJc2TXb3YvSvHXM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936171; c=relaxed/simple;
	bh=R48jIY299gf7sJn9fiThJlg+gU7IOsoS/L9k+9R7MFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J5K9lhFX3zPQ6FKbYRYY8xZGXTeXDYA1zy0QS6P832hTBTTJddETvtc5gMbb8YzmVAU3j30v7C+BxXDCaDcocW6Y1ipMF51E7qv50nHbfdZ8TmvNMpzUUk31s/HbhiFHNJuNEwOkZXBrciIzhYiXwtIsrWrHr0KJOGvgOECscCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qmNgmIwa; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qmNgmIwa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brHXVJWTD+ihdPybw+pGeDdRYk9l0+ifF5xs+n3UL4kWdXhwwmn4QD6ODfgUNbkLfv0lPjLRxqzYcHiLmK5fSanKEkcLwoJeyM1JpYmUJT9o38FuojrF0JEiy+u/D9T+/ZfypzHRce5zAmjz/g9RumJoS+34y6icboDk0QXtsizE9fXMeVUaY32SYAHkUDtsu2zQAanGBVMN3m7X6RdylxO45re1eeGARCS2s5n7/gv8TbJR19ndbOudYJWF1pH0ZEiLveL6hnJd6mIb83gUXKffFHzqZsICR9V/1ltLMtrkrJ46kXH45gztoeBYIMyYGg4PPED65MwcV3idxS/VSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6gw7eXDXwDDc61b9lnpKeR6FV4cHZR0NaP3JSqkQys=;
 b=FcRmif0iaDqQ3A2no98DL48b8e9nXdRgB40Z5iL//drJmTIzs0rsMVI3VnXYttyPiyKhUfFugC9ecRu5GJZI8Oij3jRZfRs8G8QhmQm08SfLoTlr7MvyiGTQJRsNG4MvYhDfPcWd0wN+82lFEN1p2GVdOWSORrvCgp8229VQODeTv8h2coXqvvx9SukDQ9xtN1M/It1SnTNqyz1ol75J0fBb3KRLW/U2JKgOoauovy4F9bJJkOwaP7SJvq3WlXWnNSl9ooXCg0iKfRPb/rgWPxKGJr03z/jgpz+lEA8TyjyHC5ek09KRwT9mKOQIeR5kxjT13B0CDbUia064lDhfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6gw7eXDXwDDc61b9lnpKeR6FV4cHZR0NaP3JSqkQys=;
 b=qmNgmIwaNRJkKdjw3IU8UMTKDlBtBZlgPKpx0zRDNiEYNebyH1PvAA66RFH6YN0VBpb61WmEhP568+yPjj0xZ5F5Y/XP89I5JTkxsJlRWaqN3T5nr9webdaJOU3msAD2XSRjGaer/s6CyXAf4iyxvMxsdb7jqBxrabdLGFZb6EBv1EpgklvMSMoKdnn0oIk3fBCYa7TpGFkJZtPbJ0wSAW1QKAEtX89cUS1wu/LX24J0Dekvo7lYEz/lS4dtWG90O8qEwuqQTHldDw+DaT8RmFWRn7yDRV/BiaDI8NmH/Kqc2Lw5Jrqhx3RGQ/KG7XraWtqTTTsXUIknw493fDKdag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 06:42:45 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:42:45 +0000
Date: Wed, 9 Sep 2026 09:42:36 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH v2 net 3/4] neighbour: Don't render blackhole_netdev via
 RTM_GETNEIGHTBL.
Message-ID: <20260909064236.GB1183641@shredder>
References: <20260908211419.882954-1-kuniyu@google.com>
 <20260908211419.882954-4-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908211419.882954-4-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 178b2068-c32a-4983-0e00-08df0e3d8e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|3023799007|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wf4AZh2KAPyjKQ0ZVrDGaTi8mYJDd0uaFoZdDDVb0nI2qH/K8V/WwJeDLRPEL4Z2DyK8kGVd/A+ma4wiNBvzw4Dhs1XwjB7t6q4fVmLLvtNjR2mUtwU+mrFz+qBmNNIzSkOhb6hxjyFfLCXLtqqsfMK7STWQBDMVhQhrfjKwzbXAWiOY2Y4u1WzkGCzPhUhx7WlnWTtI14gbkgoDyJlrSpqi/XNe06dd8PSM2e2oOX7znrG+1GC2zW6HrSZuRqElzNeB4NeM1KupUupVkVMQun++2pRPzj2JgtMBJZj9M8EXRzYk+x1fxh2sHEzCY9SRUleZoQN8V2H5eNvSuTslUgC4AB1DVIZ2Ss/jBcOzGLbWw2/XVii0qLqq6m38m9ISteztA8xTnseiEqbusb/0Oa4dpOYzVUvn9kFTGBhuOjRU72UlrhSPHrMaGOuBUoAD7Qvgh2SMoZxhTBcyh2yf0wPVg06wH2f4Zas+iww030nWOPEyjvivtXzbvMoW/Sq9OiCaBr5TkJ5yuP4pqoeQr2T4evAPI3re3gNAaky7dGfwGSCcZaOqrTNGSDXdJznsMImoOe+iv/4Yh5V6N+0ynQNVhV7xZlUzvywAXKm/5vuqeQctyVlzmauWVfzpCHvrXDGIN11hyWDbAcU59Ji7bNeXkC5ZrDp6QKXZutarMk0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(3023799007)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CJsWm0h7ZOETUvuBA1YEcpTddyHtPwRXWVuVRCbATzzF+lfgUJ/Vs3JlArSz?=
 =?us-ascii?Q?jayKAS1sJYbplpSk8j5arKmD4cDjWChnDX6lsa/1VVT03dvYhVT9n6wvdfFm?=
 =?us-ascii?Q?AJzbTboFCGoprSbUeOeVaesNoTGswY5XUYhnYJE9hz0EiPYGd5bGXm0yqTjH?=
 =?us-ascii?Q?muFdGrrFzYblsq1HP2bEo3GJz57tIZ4fJvucRnMHDWJ3acP9jbpA6ls7B+EA?=
 =?us-ascii?Q?kYS1+/b15pa83CWgSPKd9cnZPDPQlFlKcppx49yySqC8Xm7Z+nldCAc2DAt1?=
 =?us-ascii?Q?++lNmZIKjqgxcbasXjEpPKYHyB4nW1MVOu2j1ZaMHz5BVwjxQi/bLi4tWarx?=
 =?us-ascii?Q?oTvjMXdWXvTumkpzIPqH/c8LVuVZED+4cnihX+4rOeJaX0lNMcqEzonpEXgL?=
 =?us-ascii?Q?aaUpu8ZCvy3aAKYR1mwQv6b3NsFXlr6XclB02/QymgvW4FpZRxkM00bjrfCe?=
 =?us-ascii?Q?euXA74LarIOUW8aptQQcdFECPhEgQUtCsqyVBSTIJGCgzHPfJND+hdzMccOD?=
 =?us-ascii?Q?FKIgZYjaexE0Z/2iq5JehY9NYCfUumuvb2znYa3612Iz0vq+HSbT3ZgBREqp?=
 =?us-ascii?Q?gyi86XiyYavxAk6fqAVL353aRTu230XlhjeML9w+MBGk2kUcqBNM7jXrTtVi?=
 =?us-ascii?Q?oRAeqTmp40JoLBw7Jwr50R0IjKFAFjr6ved5yLhEiRLDB3A5Z7ng0yiC4gC0?=
 =?us-ascii?Q?5qOAXRfno2cRz7ZoywtWP1J8b62shvn1AeFIkFk71v5kBmAd3r5L+UJsy5mE?=
 =?us-ascii?Q?zHh9JgXXorUBRU2BOz+nenIAqaVdxcJrKO+xzt/inXezHbe2pdTAXCHE5vK9?=
 =?us-ascii?Q?7Hyry/u9Jnr7b134DMD7Ppy8ELLiybFoEUXe88DZQzq3uj8M6oa+dKn1NB60?=
 =?us-ascii?Q?QPRSS+Y2cjKdx/crEu3PFw5dORQ6+ilLxjrgM+A+laZZKqFveqt6xHj7F8M5?=
 =?us-ascii?Q?AGUYP7yqVicWkc4ViLyQw5YxcKawCaYFZ6QQTMy+4dPUw/tEcNqNFfE2kz9m?=
 =?us-ascii?Q?m8T3S9xZLOGuHmK7qf0RpRLeZuqGh9EHoGmMWPsPmstpOsOhrpY4iHWpXX4i?=
 =?us-ascii?Q?qSfwIUuvxcbG36h+VBjxZC1RBAMtD1HCDevVolncoBlcmY/EUr+qDFKoIuho?=
 =?us-ascii?Q?F/8dR6aaQkeyyIfYg4Ij9oDGJd6qYvJzW86LvtViNehEXBlucdIs/s9GlPjY?=
 =?us-ascii?Q?EgPcQxW3gPl10LULRllUPmWkwLCEGhMALFfz2f/qDVw8hBEKtga+ArJJz6gI?=
 =?us-ascii?Q?4Zj2JkOLVww4JAhUqmN4Dpzi1y9TdPOK1MLKWPaD9uZSYMdrNxAESCl/jhTy?=
 =?us-ascii?Q?0vNeTry37y0S8vPCPAVttcQswa55wwTa7C+TmA4evJRxHpqKmQ0K2F4EWWzR?=
 =?us-ascii?Q?WG9WNSsASmvuoWXdoMQRwCUWVghWGFzLTxmmncmmQpqSDMNEUvsBJ5K1Hskb?=
 =?us-ascii?Q?RaWlNECpikwKYDCqxlNqKVcIM+FtnOI3wzewO7Pg33urq1i8P53OYE5SwVIR?=
 =?us-ascii?Q?dk9L1LQSpLz+31mDkW1QFNEssY+Gqszukbm77trW3awisjaa3P75q/kPlj5n?=
 =?us-ascii?Q?wIdxvrQNfziU4j6t0IAxWa1n4WOQBeTlpTdIvggyvZAGT93ZXvtlNFZ/en80?=
 =?us-ascii?Q?DRURIeCyL6c/zK2+BK6Y7leJtZ1Gkeoa3i6Yu4wys1IMnikDZjwhQq5oujeZ?=
 =?us-ascii?Q?QxYiHjkmK3qSGKxuC+aqE1Jmm9Kk3TzAnH/dK3n9FqWRluDw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178b2068-c32a-4983-0e00-08df0e3d8e7d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:42:45.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/8TOzhLVTJOLz+LULx/Ub4gEC92ccGM7yzazIl1CzK7XmnRMX5mP3H/njnjEQIQ3XHC/J+1E1EORExj1KEQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167

On Tue, Sep 08, 2026 at 09:12:47PM +0000, Kuniyuki Iwashima wrote:
> The cited commits started to initialise blackhole_netdev with
> neigh_parms_alloc().
> 
> This is visible in init_net as the ifindex==0 entries via
> RTM_GETNEIGHTBL:
> 
>   # ynl --family rt-neigh --dump getneightbl --output-json \
>     | jq '.[] | select(.parms.ifindex == 0)
>               | {name: .name, ifindex: .parms.ifindex}'
>   {
>     "name": "arp_cache",
>     "ifindex": 0
>   }
>   {
>     "name": "ndisc_cache",
>     "ifindex": 0
>   }
> 
> For RTM_SETNEIGHTBL, ifindex being 0 means wildcard.
> 
> Let's skip blackhole_netdev's parms in neightbl_dump_info().
> 
> Note that lookup_neigh_parms() does not need the same change
> because the default parms is always the first entry and matches
> with ifindex == 0.
> 
> Fixes: e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev")
> Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
