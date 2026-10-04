Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117913BCD15;
	Sun,  4 Oct 2026 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098935; cv=fail; b=lhBQO4UjDOuZlTcMr+PUzmbP/hg+Z4bQ+pMz4alyY5SkGNcAwPk5RM3J5tMueiRtVY/b80bj/0Tlv1o7LqUynCfmkd8TpGBy1lzryHrt5AFwUZkog4XJDWdjD/fRdFcyIQj+v19Hz/vm9+nCsQ8Gj6zIvDydqDfCh37M1rzkJ3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098935; c=relaxed/simple;
	bh=9i8zAx2cdzpxR9uFIyEYLWrnvPCqj3NxHGk2/KWc/8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TbyXOFYXvuIHBMsoblWtqW3v16Cdsz5NbboyGVD2/KuwN/IAdX+RU9Vi+xYchqdQ/mTxfnMv5h5zEranTye+R0mQP7LNUZyeSYD/CXPLwFq5SE4UbvccBH9EBZrawaktq+bu4K0LWn8cUVhLcI+fAyMnuTFOHjMSzJ0of0i+JtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R6Xa2det; arc=fail smtp.client-ip=52.101.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R6Xa2det"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMShfNeE1x/pJqfQzCyJcmdh2dmHZBoCggMIBOdZ1RwkaqfeZQO4NM2l5TMYK1Idrjn9bB445fWgkBmQJ2RlDU1IbGp2tWMhT6/XSw6dbi7PgP1z1OhIZX0Ny+vcy50DyEgHe5VlWAdKb4rJeYQ1NUyYDIsXT59bIdtiBw5nj4amxrEe2QBWL6Gv2Ff2bLTTWT8OnxMlXf09zEKCmqpYzUmZroeRnN6nwGxB7gB+LCegzZ/5Q4hSaCPEpMDGf/AKi/kabufsf0xG4b/sjbaIrxZEsU4SXU7b8E4cdSG3qJ5Kes/1JjyxS5+s1t7kPXvS4qgNwZ6G68/Hm6JqGX35Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP8TY9ZLbC3D2kuBFBCX/PHgz07yhK/WjgU9rJ+/DGk=;
 b=f1/s0mygEeVQNAai4eLZt3o0WOHk29Ta7kqzyESIH0vFC61gnmpDVjbTCYxpLY0pGnDxK2Xme0iMZ9h89v71Ffuv/z9yE3Y6hxV1oScHfad96gDP9V1KeNEM3jvn73IvtBvieTh1TziEbNXch1CXMuA1+d18m4inDcM8QUuTT1gRGaz6UvYV3ji5bO+pj1SiepTpyubwmSp1R7ci1dm5SHj/lb6oq6vvarIiq+iJCy1sINPcfiRJg2t6zLX2l11Bp+AFxtd9eclfYr1W4Z2DHVubj6efrCj7BdRd5/wvNFqrdcXNvDp876CL7ofexSJVlFeiTPBtQqcuduxWDz7kEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP8TY9ZLbC3D2kuBFBCX/PHgz07yhK/WjgU9rJ+/DGk=;
 b=R6Xa2detFdT8NqO7S0YwicEF2YkudVTZuZzqS9eEJfoh6KeqUq5ev33UiIDIothyDtBtq/Xf8GAPboIXHERLIa6SjbUA9RGK3AhzlXO2FTE/B27kX7l6cMmEp7xghA1Vh2XmCAuBdlN0+7K6LhG/mojRqP0MzEnCMrKGlxxxpLgxwFcPYatg0kuosGrsXMntaVHX5iGsRapxjZ6lzuinTPdbMT+IY4+WEZ67h447gs9kjtRaWn26Sb+UXW4qv00y1FSQUQaIIkEFp6v30Hd7lVfyDKM9uJbyQm74wYO2m/1ROd+cQX9pkI1K5XjZF8s+/80GX70CPEtAvLBG2hVt7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Sun, 4 Oct
 2026 07:27:52 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Sun, 4 Oct 2026
 07:27:52 +0000
Date: Sun, 4 Oct 2026 10:27:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] tun: use pskb_may_pull_reason() and remove
 SKB_DROP_REASON_HDR_TRUNC
Message-ID: <20261004072744.GB72754@shredder>
References: <20261003132340.4175269-1-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003132340.4175269-1-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf25ded-66fd-4b1c-06f0-08df21e90030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lTUWO0ICDAd9lb3FChysggxvmMSYoNXy3I0q9MRA++CZoYt6h4YRod1rg/opZcQrZnx1WeH5DNI8oKq1ujaBfGQrkYUR0lR+Xh47WhzeRciYh9PY8oEaOBZw7HJMeW3Ge6c5j04FCAwyZsXVwVBWhzYDJ8j7HfElZEshDFOSq5infgOy8CSQeQomcsnHz1KcZhtgt/UMmCJvuYB+9g+DPRj57Xer8hput2x75Vdp1N55+vyPBAXDqEHlVpMTURjAhPEWCs77T7rGcM/X1h0mvWJDbgav0IMazxGE/w195FcuRk76CUaWGQzZwsfqXFPlmzdOpUAiZitwppjZA+2+uCuUo4MZ53yjZPA86NYEZSp/71eRAj+ZgPA+GFv7qTZ/nwtfpt4v8iAYq3ZZqg0y5IM6iqQAAWjMe2fDjBwm5YsEgd8Phlfg4B/EuwctLl9Tx46287/McjR6mpcNWuhv3jBRjCAOa+VG3rNjkkouxMwM2owwUmZ4f03IzLgGw9SWqG8OyAvYJ+o0rZ2zIkIXQa8DbMXNz4QkS+PvlXyOLqCPiNFgAWCkMeI7Me+tScKvj8M8ybyvTC2RgI0SbUBvdoDpug/TQL7oetrHM384RjD5dhX/vWArAQ9ALiMHmrDd3eup9oqCbeJbtiIwexIsxu9hF5Nfh6gMY4vkmKVOU4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rnAesRtGqJ0Gim/UbY16eBsX58SZePRawjKpuQLwAOUVnGs+RcrN8E3BzfNt?=
 =?us-ascii?Q?93kf5zxwMlZBUotfGfXsrZVYNYU/2u9Ii6fOQ6x9wRHRyqsSBXkBZyV4KXDH?=
 =?us-ascii?Q?kmy1Ybf9dAvBTyy73m99y3ayikHp6ba9q73iDRQCA+vQXmH94u5vvi9PmcUb?=
 =?us-ascii?Q?U3PX9JIzxHThUpmQIU3KQY3M8Tqp0LNafi81Yw7gw72GoPZv2k2znoLtnwiU?=
 =?us-ascii?Q?9Ik1l6jb3aBHZAyg+8RZGWNdPIETxSoQanLXbXzd+cKtDZbBep7WFAg/c0pJ?=
 =?us-ascii?Q?/xU1yILDI3FiZnYiry/Frdm8KahYiEu0uJPrJX1YOBh2XP6mIktaoAnqT6MI?=
 =?us-ascii?Q?2ALMxcxxpS56BUFQnsn5xkGt5UeVhrHnMDsws1iVBVmbkESu5NYT/zxJ50MJ?=
 =?us-ascii?Q?H76q7c2QHIRhzkDYS+kX0hnb6OrBqstL1pSRFTRPbAduoilgynadJcin6/27?=
 =?us-ascii?Q?EMVKkc1OhsZZi6+IiKlymOUwmtFG0QuHRhrmsc3nbR6/UQFlc6BZV30AELYK?=
 =?us-ascii?Q?s856Y6W2+4iTc9U4RorJrGJaLD9a8CRHAWChZFCmKSsyXnMzMXiZ2CL8XkOK?=
 =?us-ascii?Q?ovXccdcnPrafxQbgK43QAhoUpcaCbMewpRYNQkFwiEJ1O1yQ9pQwG0M/O01Q?=
 =?us-ascii?Q?SAVJwIiHDtxP9SNhqBx8yfTv77kK+lcv/zv8hQbZq81E8xcyz8jg/tWcGcV5?=
 =?us-ascii?Q?o7TTg79XK5xPf0XhmKsdeqH4NnqLxS51zYnAcodOYr81QqWMybbvRmLniUKd?=
 =?us-ascii?Q?HuS7PzE52cCiDzealBwzDIIzjeA9NxQUHXIlAN7JHJ2m+1CrTVF/67gaSYpy?=
 =?us-ascii?Q?7lC7Bpdyg6PrmC4RJbBWWPIqxyGV3Up7VdE/yBj8fu9NOJvfZH8lbdFhw6jo?=
 =?us-ascii?Q?6YYX4Qkkpz1Ds4AMvyGU9eIJsvr9V0Pbiy+SBixIDska88TYL8U3UeZzusoV?=
 =?us-ascii?Q?GYByBwxmdOxVjEIxUvePJt+8BrB1scPlB+XdZl8rthg2IMpBP0E6N9iuP3x7?=
 =?us-ascii?Q?+0PTLBB/qAmzOYQn5OaG8Wf36+Ov7RRQxghDgP3+lrulL2ysi8rJc0g9Ft2B?=
 =?us-ascii?Q?g6n/ESwB/vDttkK5UUIUSK4pXYs5PBTEjWAh77i1jx9gLM8MhKr1q+iiwDNT?=
 =?us-ascii?Q?f3aQ9+ez3xgJjT7H99hD/yZ6nw8DWJbSpIFi2w0nDAMkVJlau2Wo1pZerSK9?=
 =?us-ascii?Q?ARmOJta8wxBnB6p1nDLde+eBCV2xWTwCqDJhwWzZxqTuNz2CtJL0gDfdwX20?=
 =?us-ascii?Q?2GZIIM8bR6sE3G54FkvDmNcWJSvBFHDiopwH/WzaoNOmkchQTI1TKG+qUz+s?=
 =?us-ascii?Q?M4mFdAvpzxPYo5MODwDsoTndS/MHQI5/N9dmCCVEAGpUMHYvGk/7pzwKJYFf?=
 =?us-ascii?Q?5ZjjREOjkepsWBcd+Qwb+Lfq1sCMJgE5M2QQ/YKoX7YcERDm1sl02URPJeHW?=
 =?us-ascii?Q?yvtNmdG1fqweUaBtwl8tO8yAXczCY7PZcsEvYj0W4Ag32d5JhVL8IU7jwcyS?=
 =?us-ascii?Q?CX4g0N9Vbef+KsKJxiMR04yf8Gjc2DCKKCYskLuprY8YWnJO1tRfBUeRZ7zv?=
 =?us-ascii?Q?ywTFFxp9JkT158GLZ7oCl3OpOlvpUMx0ofWKjg4sYyOD+k/jCpBUdKwNeyy3?=
 =?us-ascii?Q?xS/pwyqL+Qt6XH+6Z6yQ0vC5EabTijmjagqXgFW5kuFae6s1VglOMCqS6kGd?=
 =?us-ascii?Q?ylPJWjDB+89vaoUW6GoUWPMeVd5AZjwNc8zn1Nzw5OgPTUC1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf25ded-66fd-4b1c-06f0-08df21e90030
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 07:27:52.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AwTr2zy1NaHdV2pYD4KosRkxMl2PABuqsTTiYsl0LpXp2Ez2CB9WGRydO8GCc4vptSVyRFd9S/e9EGwxm/yXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762

On Sat, Oct 03, 2026 at 04:23:39PM +0300, Anton Danilov wrote:
> tun_get_user() is the only user of SKB_DROP_REASON_HDR_TRUNC. It sets
> it when pskb_may_pull() fails to pull the Ethernet header of a frame
> written to a TAP device.
> 
> pskb_may_pull_reason() reports why the pull failed: PKT_TOO_SMALL if
> the packet is shorter than requested, NOMEM if pulling the data into
> the linear area fails. Use it for both header pulls in tun_get_user(),
> on TAP and on TUN devices, and remove the now unused
> SKB_DROP_REASON_HDR_TRUNC. The pull of the IP version byte on a TUN
> device with IFF_NO_PI was reported as NOT_SPECIFIED and now reports
> PKT_TOO_SMALL, for example when only the virtio-net header is written.
> 
> After a successful pull drop_reason is SKB_NOT_DROPPED_YET. The later
> error paths without a reason of their own, the unknown IP version on
> TUN and the path that finds the queue detached, relied on the
> SKB_DROP_REASON_NOT_SPECIFIED initializer. Fall back to
> SKB_DROP_REASON_NOT_SPECIFIED at the free_skb label, as vxlan_rcv()
> does, so that these paths, and any later one without a reason of its
> own, keep reporting it.
> 
> The errors returned to user space do not change.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20260923145931.GA2859441@shredder/
> Assisted-by: LLM
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
