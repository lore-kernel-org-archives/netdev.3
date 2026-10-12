Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37C490C12;
	Mon, 12 Oct 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816782; cv=fail; b=m9gpe+XXRvso7JyBckB19L+lmjfYV0I/Z6XgLM8z+/0PwwFgLn5U0dFMS6rT42kLZ1FH6YtCI+h9GKiVErkzqeQUScyx2qpazsx6shD2W2LGozLXIha9Gw3i2EdFAiI7mK75wQXdStCUTyFvfnxFKF5LgAPLDV6U/KFc1P6jsGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816782; c=relaxed/simple;
	bh=SnW1t7OyMXM3wcUksdQAp4PPuwmu9sZX7fDof1XekNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RltSuS9CCkLaupeJ4kGJtSov4tmlDkTAGSg8Mu5uP10KA6inzRilNPWd0sHO+tcDbWie7iIljE8h2Wk+4yKP8I5rdTpd5qq0giTTOsxebODXarRc+sUC4v2WnfqD7Zlm+W2Gsam4ce2XjH6h5rg2t39pbaXXytvrdR+UYVLCM1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j8ZEM874; arc=fail smtp.client-ip=52.101.52.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j8ZEM874"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMJjVRnzHlS9e754R6m1CQsSMGXp7IchYcUGfcLJoR32iePc/nZLzfjWV8Ea03kaYtfa7qeozl9DVPwc/D/p/JTBbigW/ZOY/YUMyZnrmiwBX1DVRZYLMXPrfJ0qUnQKEjmWu5vxmdiWXEg5haZ8rWngBUNk/yDJJKi7JePtRfHyREHtgFZn+OgoGo67NxomF2ZeB0hA0yYUMSPkfcvb1PiOlb4uPWxUoGfIrVt4kSsGA+8D5qIhL5Xm7esyVeuB3N+5L7rnG8U7UvexiFFuc8CsH/6N7FXFMjnNIqnKeR2AcX5kdVDvK6tQBQflPN+9T6DfON6huSTcItrbWJ149g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnW1t7OyMXM3wcUksdQAp4PPuwmu9sZX7fDof1XekNM=;
 b=pfdJWZSVzza0CTIysHaD1SZiub68f5jxe0Lbv+21ywH8dBgQ889VScdE6toOCSOi9RXI/ZxOqW17mUTcZVqqWbmPS32pL1dpic/1Iu3XU5ZwQxqVLYcE4NNMBTkZM9AxNME81vQXtbxplRb00tL0D1KLOa2udAqMs8sn8p9AJBNyevkvZle5cdoiEtPSrgpi0CiLxr8nf37g38GzWC2jc3OYgCatpv0IkGuqIfaRrmr5azwFywfeyi58MPLDf7AlTBCcT7IrHRdwqoep0Ek0nomygTmmw5gGehTN0zkjWvLfqD3XGiOPm1qiaswrI/1M2ZbJzjjzp2ouERR3wil9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnW1t7OyMXM3wcUksdQAp4PPuwmu9sZX7fDof1XekNM=;
 b=j8ZEM874SuGC3t+fPmjHpSqBipBogIV+ppnM6wlFwv8jz7iDpXZ96jKYflNXzSyzkrchVDiJdzEuTQgrxxmwlOd0zupRQR8rSQSA1KGt+kQQ6l3Z1+bi5p6MoPwUjznU+m9HcACU3nROHmLYg5zkelXGhcKWMh8LpnS/A+OIPQgRWPnryQLhjLy0pX5bBsSLEXVyhwxURwr3CBmDhENezwMb+1OF2TM+C7SlSbLAxwriwe8wdx8kwfOWvnc9GLHJtFK0abd52OzblJOnG6W4FMLxz/XWBSs5BCdyil1lzJX30/2A+pMZloCQQYDWGEsrhXnKkHnMHhPN44TBWusZ0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 12 Oct
 2026 14:52:51 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 14:52:50 +0000
Date: Mon, 12 Oct 2026 17:52:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev-bot+sashiko@kernel.org
Cc: 4ncienth@gmail.com, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/3] ipv6: initialize temporary ifaddr before
 publication
Message-ID: <20261012145240.GA779501@shredder>
References: <20261009054042.272944-4-4ncienth@gmail.com>
 <179161099665.434549.5858601179492551889@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179161099665.434549.5858601179492551889@kernel.org>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad1fa38-a2df-4e43-4fbc-08df28707c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|7416014|10067099003|56012099006|5023799004|11063799006|4143699003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	XWn74Ms7CUuuSuE/ZpY0mPZjXjF3HFIqFeBJwj75xEz8FlqenBTsG47YUk25AbnBHDjrx4bgaXLgeRKmveWBd2/x+HelHQufjg8XRm2umPOA0ogT2BeQ3dS402aXWrA5/B/EQ+UIekUZV/AdO5vKoAStgZNmEIfTMsUf9OaxUwmBant4w5xkZKfbVUQZkcXoBJ1/P1mRvRdaoTNkbYKHhcbl3pG+VExq4G+9p1+0KOSXdBUwvO0pb1soXJBAaulWLrRSBgocgaJh6XvXhKhMEiAtLx0byLn6ntIpVyucDxxMLdEhj7ZuoKKYK9S+ewDxsqlWv7KwwLWFc89fjbNMMNnaq27St7pnY0juxGkTtY44x2c4zGA4gUBK0KRLWsTzM7jKXJGRe0nSCbtocUF4BlF3p2qDFWT6EcDm98wvPOicSMcRn/UXvEf+qk6f56aVP0knDKJMFEDZCM9ARsDPkGPcSAlJXVapQSzC+oS8lS9/m3MhoPyclKm1BrK5vmUGoeSQ3VKI2jNoS3j0AU7pMUJIMgbuaAwMg0/d9Mks+HO4C3T55DmKxFB0IceLwjOPLZir6KDkb4HAzSKRlA2Yo2CpFo52m8aE+GJpKpMGbtga3rtluoBtbLKYYaRYqLxBeQY9xm0HVcLkxt2izVLjflCr6kEe83A0Ao8C+rJTcsw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(7416014)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KX5+wlMAiE4dmb8tMFUd1hg1aa4dOJMeAp8Je+rWh+j+IuvgrdTlVmWe/c+Y?=
 =?us-ascii?Q?r8INRYOlGMmlffGX4XGB8YAXBvn62fhaQRoQga/3CV8LgKHciYoLpIpY8ipP?=
 =?us-ascii?Q?axtJUs9YKaKhSqrtOHXE3vtRxhWtFoy8SZsN3gOYRgBjR090v1URzQbSoIJH?=
 =?us-ascii?Q?4wQPrFWc/1RSEuOUG4t7h5kIikdeuFnXJO17/B2YWC9KU6KNtSDVI2F6hpIN?=
 =?us-ascii?Q?2Of489SjhOx2MKNcsP9kc93108Ycyrs+DajTLqubODtVL2zLNN+mpuJxDm9h?=
 =?us-ascii?Q?ZZOICO8BcgzAy2RDRFWUgqg2wHrDiKRekFUJN7YfQb3QAWZKYGNOV1X0opTm?=
 =?us-ascii?Q?Px4HUt9oX66P+8rNmNEjb1OS+dK1h8o0qiRavH8jvri3LLi3/pZkNA/OQjUz?=
 =?us-ascii?Q?ZsR6Dh305osZxrN2KejzLCqnGLGE29wH3kOiDo3HOuApjZhDGj+1ixBJD2+C?=
 =?us-ascii?Q?upjxEeHxXkMp8i3Mr3XOyyg6zikj/NOtfnH+XDgo6pSrBTWPK8gGvQ8y1lMT?=
 =?us-ascii?Q?2e9hSnjcUraOqGG3wolifvoWmXP2rN5qmTPZ8SQ6Ep5KMJAODBvJxUe5cDYr?=
 =?us-ascii?Q?ezd4NE7hZpkC07J/zDAlZhV0BSo3eNFWyi4orgBjj3QkXYsFCRC1dtQp+tlJ?=
 =?us-ascii?Q?AwRdMmHFI98TJ26ORY/lIP/hi0Lv2RCBWoBMtup4NXUaoSw7jxDmr/Dv7YFV?=
 =?us-ascii?Q?LpsUbIux3pMj3KM7h7uyusltXUFx8S/7Hg8zTKv5G51wPQXLtGeZY2X8dUMW?=
 =?us-ascii?Q?9PAw6qaK17ER8MCPinnfElSBmnDcKzzk1Llm6YsvYZA8prK9HCS3Xvojoz29?=
 =?us-ascii?Q?fUetsLo3Yw4YZ9l0chteyqim91Bstlgtz7uwD00xMs39ocXp19E9CMGJ8UVT?=
 =?us-ascii?Q?Bi7jQTzyeoXpErGdF48U9R8eQ8dp9+a48LLqvtrdvfdcq4Bm04MdIijgaIcc?=
 =?us-ascii?Q?T+IUClRgJUqVxj1d/diyFAIYCKqma/2Z7rEjGYB4BNLS1N4CKjna73RnxWME?=
 =?us-ascii?Q?y2JcRIN2J2EqXRpFJMwE9lU+dsphIOJoNWyw9qOSf1DbFVTjoUh/Vs7qjjsw?=
 =?us-ascii?Q?zDdWKFpqXfiyk/5KECtL+87mhB2hNG2p9KvbQ9jqnYskmJPk+5z18QKxrniQ?=
 =?us-ascii?Q?Mt//LBKezVyggF9bxPNLXyA4W+XMkNNChaopv7jTY3qRtRE1jIS5UXsq7Bcq?=
 =?us-ascii?Q?9EWCsib10BLHfrfFY8PgE04kyDfS7ITT/cWqPPUPcZjnZQeUoyunTXJEbnRD?=
 =?us-ascii?Q?f+0dBvcZ/c8b+90GspfsurustT38KNOouxoKg24o7jX6xn+TG4hqPy5w4ZRw?=
 =?us-ascii?Q?PA0ycGhb92rYpdSz790ytHh4yqf/qMw1v9eXb9N64bl5JypcEOxmT8ycJxrT?=
 =?us-ascii?Q?lEtM9+snEC1JvGKQ3qxNEUdDoiqyylIbDvLk7uD3S/717Qm5G6GlpQQNT+5V?=
 =?us-ascii?Q?bNjiK6Y+48ymM73MohdL9jtCOOxGYVngwCrS/eNDY13Uilvs40fnRfRWiC6r?=
 =?us-ascii?Q?N7FIwGAyfSxYgSAY4Nn0dDzi8dNfnOfRKj22Svgv759ecI4Qnijwv3/Cn2fk?=
 =?us-ascii?Q?9k0sdSfOxosWm70LDJmXXQ8VwcAj4QH1IO0T+mVcVETsAKPlggVIqV6XcJ1u?=
 =?us-ascii?Q?8njjJDrsn2lTO5IEYgH0C5Gwcbxz2Ful4sfCAzyCds51ZKLJ/gp7I/n3yeV7?=
 =?us-ascii?Q?vA6qntic4xUACzyVlbmkJ3O1LXdeGGTK2R0Uy9FLSJX/YCa9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad1fa38-a2df-4e43-4fbc-08df28707c7d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:52:50.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cd0tKusAMnjCmFTbYN8Hu01dueocQD+njQsy97UhGk9L+WbV8lpQ7AZXsEblU6Dh8DN5IImKlOvaujC0I+KRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671

On Sat, Oct 10, 2026 at 05:43:16AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Could cstamp and tstamp also be set before publication? One way is to
> pass the timestamp through ifa6_config, or to set it in ipv6_add_addr()
> next to ifpub. Then nothing in ift is written after it becomes reachable.

Yes, I suggested that:

https://lore.kernel.org/netdev/20261007192032.GA1212364@shredder/
