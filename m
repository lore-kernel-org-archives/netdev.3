Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF3399D00
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785666359; cv=fail; b=KvrY1n4gHw1YAxQnM8x6N6fFTybGanPzO5+9eRqS30lY3PKRWj9rcbV2OdkxVhjTw1pYbgta7gHRU3T4XycOU78d8L+orJsPbsJ6Xy2GxVcBp9ZpzcZckaOlP9kZvC7He0BVDMiWksBEiyXu7YBRUtqnjZGV15JDMY+OHM/JENI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785666359; c=relaxed/simple;
	bh=BDRF6azrvS0D87NkWJDeUEYZayq+1Fyuzxd+Sqwi7rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WJxR/rIb5htL1fZJLCf8cBma7pZkkNFUnhTGE+WPNgtaVhomDNxwCtMSdBRv9ajJ1C1Eryq0Jy2KcJb8aG+Nw4qZJf8xiALktfy5sPeNsqSlerqWq1VyIb2zsIu74aiuLRrrJiFrg/xj19k+acXEPbz6SFGwss6ZacL4HeyTgUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QXkO0ZcG; arc=fail smtp.client-ip=40.107.200.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QXkO0ZcG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJopTSaRWt3KzV5V9GgvegiSAeb/bKBc2YY/eeVnaHkZkR0ExAwd3Tp97lh9LIC5+6+6YzZBHyUtB354GhK+hpvel9gIZffY6DBXpGKo+kObICwlnZf8e0pNFVpSR2+ctHQ6BoibndhVAWBgJ+yJOv9oRPKP0TP+tO4OBjVULs4hi1qutvJxkP5eXDJBGpRv3SSzcoaP4nrOgHvwDXRHNurkORNa1S4qfXBPaZ/dhc1Dx5Si9WyoIVIHckiLCw4GZ2KSWVDUv/67ELpXMxqXI5oc+d6LToarCm9QqXKzav3WZSa9qbWqsl71JTqCPV1QlwiB/0f404l3OU3kD5XHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4aNZoMAgEHny8gqUD8eeyOKZsz8CA9kzAvkU0t/eBs=;
 b=efTdUWzjQ9+IkJ5zMMe9h7YN1X1xVDfi7o8OfIiOhkrrjFimOhMMD3X/TYQGFQAsqg7Lf6KqYpB168zkQgZQCVGdgo7XKm8QeEDPcpdJdfwCDRYBwK3hv06zde84+AVr7X8b52oSCS1AJJNhm0utfiU/rUSUmTbYhApql0svRz0r5JfVS+H61B9Zl9TD290gXZydZuj72w/YNf1DzUOIMtPtDKgAL+A3y1ri0IBr3kKGIzX9+AdniQj4KQM3ta3394+Lts8zKd01W8fSherAU0PFeQZs5ak4TF5YgKbsHdMvIQTBB1IjVj4msvNs12AI4WeDeWkJkL87DHqX6Mi7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4aNZoMAgEHny8gqUD8eeyOKZsz8CA9kzAvkU0t/eBs=;
 b=QXkO0ZcGeZXKpMP8y4cZOuI1ppHv6cW4oUAr26OvcZqQdKoRQj1klA3Zdpe1gNeWMq9An4uco4Sov6rFK1I/Ehu/cZIrjt9BlR7LWLOAJEl7/7WU9n+W61E1eRAj/BjOPOq8vgSUdRpn49f/JTetMmNguB4IgHk4S54z+8tS2QgJXCDQ9n8Z99nJX4pw8lO/qERfCNUBROz78OTioBZV8iL7Kn2WjHmWhL0ZZ3UnzgwK2h/oT2t729YbyfHgrK5+6ZXzqbKLzz+egta2FNbCKqVkMWFOIr9d/xmngNX0KWOtBnQNauys03vMgtsfc4DdogvjKR/5MON745XmNb4PWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 10:25:53 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 10:25:53 +0000
Date: Sun, 2 Aug 2026 13:25:45 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v2 1/1] ipmr: only copy pktinfo to cache reports
Message-ID: <20260802102545.GA245758@shredder>
References: <1b809975e5bd9c0a1dd6fdd1db534e701fe5a4b6.1785379072.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b809975e5bd9c0a1dd6fdd1db534e701fe5a4b6.1785379072.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: FR4P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1c1674-0931-4cb4-b442-08def0806e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	NF8BJhO+iPrf6BeGmfkCeDMrWfntMX0o4tRir0UB0ZAA4PZC8+JDMNdvjYa+X8wkSp47mNytxzAu5rFWppAqk/igKhg+8ndiGTtp1zOnZnVVknxCPoJEM4Aatu0wUwcqaleuF9ZWGJXKSqgErn1BZuVU1zI01pe6dme+P8bJx1jux8I3PEEym66VRhGiJ2esDR3RCT6GAleRFVcrnCqlFF8+T4B0pIHtNsc8ATfZZ3G7CtUXdCZhhMlewq8cytNO8Swgj20/TlJCNHC2I9bsfiOXPjUenpZbuNtkJexHQQalGt/gQuicV/WGxTh3NAfEArHAkwndl7aARv9gVfzmsU4Mfjlg95IA8Qr3E5Cz4wjo2pGDz/k25PXFeKqQGIsDZ+8RYJYdJmf3K7pBRvHSK+AwRKh1YkaqYb84kdmnZT7FjF/9t23tvTBk3lHzOkocWnqkuqrbwuhhwcchgzzfKv75tPSoKbeQQo/p0aYNvvkgHe/6mcjKCGCt5hJYUQs9RoIR7xwCAOeZN5TH3spycA+bQOBaDNu4Sy4yEnhcZ2nxhHgP+Qh+po9STwzSMq8yuPNfrZcnZXEi30FZcqpyrTroLfpo8L9ABQSJaYWnbzIFu0G76pv/iClDyNWQqXr5vIMeu0cjiPSLmD5xlZolrdwKrQCQKhyE0qEfJqIQzJg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UmyTIwtP1m1GfS75l30m+Ms1IQKJjEGQxua00p8yUnXjoTh3vau38o/XqEK0?=
 =?us-ascii?Q?qMMttc+F4Q6sFJFonKou5g0/M9pZI109ZeZTEe7Ova0rewOT/Ng7LAD+dljr?=
 =?us-ascii?Q?cddCaxUpTFk9I61ZFLeUsDb6/8zgrDvrHE3TzupMu7JInam33o6H8bwQqOge?=
 =?us-ascii?Q?ygVsyEL7jbJgnEzuA/n3RnqHX1S64StAcYFHycSW81+44Z6n9ha1BkVvbRwT?=
 =?us-ascii?Q?8xWb/4ic9besAPQkwvyDIaWEnpCXJOq6ToHfy9NgpWS4CBhtf4hFfkUQdjK6?=
 =?us-ascii?Q?lBSCIOUNZdGFujOUaed2OLKydpoGKafuGZ5N+XznF97JK1Xgs7mLVei7dW4T?=
 =?us-ascii?Q?a3lNCs+u9K7Tro1JA6uuu6wGZAxSI4aLRxZ/HBlkosJ1M8lVw26HmOvzQDnQ?=
 =?us-ascii?Q?m5f2srJkTPAvvzIx9Lx4/2+yprlg5sD5boeTWPKkSuiTUIzXmnPviofoDPK5?=
 =?us-ascii?Q?OtvybRFnPlBuLwKDw+zI5O/oK5sXizL1J2bCOXxUndC/NJy+SLTmCLphJaRh?=
 =?us-ascii?Q?Em4KGRBAbHkKWLc9xn+Ueklrqtgv39+M0xQ5bx9H/i926n8R4tl+phirPxRx?=
 =?us-ascii?Q?3RnwyszEYpoxrw7ohUFH7t754I5kp8ZjPoNmbh2M1ZcJDpbQaOiqiFtwoolu?=
 =?us-ascii?Q?sEOQIJg+GaHEbDu1CNKNG5O0kLNt2+l6I6y3F2r1DLo5Yd2WkMoLhprHdSbb?=
 =?us-ascii?Q?1X79EzSZOsBu9C7F+MeeIV+uUpVD1kfs9WHoFxsEie/3/e0/d0WPm4fDw79r?=
 =?us-ascii?Q?6h7lu6H+8tJZ59XZKOXe3Tg4BUc7pESsOBoNWq1T+4N5lZ0gxuK2g1r0V/qO?=
 =?us-ascii?Q?MDZcuyFKRu0e+4vbyVs13w7/AtG4tQ+SVe/TdZT1eJ6d0R+7DH6iw+ZgELLE?=
 =?us-ascii?Q?WoMqQH/KOezXSn9BVUSbHn10xOB6ESs9dmd0YGbvAWHzE62wJJE+NloQHrN6?=
 =?us-ascii?Q?yuTHGvI3oIueBQy6SwWuysRZt/KI1eACyZIMKF/VWmc51PV18f/5kKM4SMuS?=
 =?us-ascii?Q?C8Yr8pZgYsSqrzZgGwku+BOojwFljwQhtIJhWtn6oxyAISFIJVdWcUsPHLUk?=
 =?us-ascii?Q?8j+Zol0I5BBjWdPAolhnl5N1jR22oE9hKAeqpIVg1URTUWkx9kUC5g9Y1aGb?=
 =?us-ascii?Q?ReV0O3xSJRUj2hytcijLhoXdcHXTh0PMJDXQ0NMM8S+wr6h9tW2oc5G7a7tA?=
 =?us-ascii?Q?kM0w+60FnSM+h6UPoW68ey5N4nTzt5aBA/UnmvKe9Aq/g+m0h9YNYZ34Q9nI?=
 =?us-ascii?Q?KQNcmYvCKISB2gPo2v/7MyW1jAJu6HDnxV/Y4WvvqgsgnuS86TcIf3E8hvhh?=
 =?us-ascii?Q?76aldOyJtQT+FB2ao1Q86a2DPNAdutQKf4hEVNB5kh47i76i+wr6GBqz9Tzn?=
 =?us-ascii?Q?GHbrq5B8HpuBYvQWLYNFNuG2Qso2v7U7MWizCslaS3Ra5bxSba8WQQ2Zq2WS?=
 =?us-ascii?Q?/E2sNldjVIwMsVz8jEAsHCSxRHITzt3sGTbTs3YI1j2eh2K6pH1syAI9b2pv?=
 =?us-ascii?Q?aHAbAKKx9L9s3cvN+YQAcVIwXNKYcFi9vkYpQDZFJilObwhJuw6FBhpkbWe3?=
 =?us-ascii?Q?lZwpvVJOli/sEO28I6iWTCxUrMbCMmOniBG/8WL+Ya9v4MAglJ+bMcDt9r+R?=
 =?us-ascii?Q?J1ZmoMOihDDvg2b2LPjSHtOBFOQPrJpYDNJAD5QZ9CauFpAhGXOxJ9SwfLlJ?=
 =?us-ascii?Q?5RwggzSCEEKkXZOf2HrPBg704DIwTh/hIjmy60RPkXDmoGVh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1c1674-0931-4cb4-b442-08def0806e7f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 10:25:53.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fShY8fgk4N6FtRtC7IdgYIaiwtYj/X7UeRYGSRdRDB9dTitk4LlyASH90asawHTXXiavpd9FoaPZPpaRi87RKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

On Thu, Jul 30, 2026 at 11:17:07AM +0800, Zhiling Zou wrote:
> ipmr_cache_report() builds reports for mrouted from a packet that may be a
> synthetic RTM_GETROUTE query. That query skb stores the netlink requester
> portid in NETLINK_CB(), but the report is delivered to a raw IPv4 socket,
> whose receive path interprets skb->cb as IPCB().
> 
> Commit bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP
> msg") added IP_PKTINFO support by calling ipv4_pktinfo_prepare() on the
> original packet and then copying the entire 48-byte skb control block to
> the report skb. For synthetic route-query packets, this copies
> NETLINK_CB() bytes into IPCB() and lets a controlled portid corrupt
> IPCB(skb)->opt. With IP_RECVOPTS or IP_RETOPTS enabled, the raw socket
> receive path can then copy past the short report packet or overflow the
> stack option buffer.
> 
> Keep the IP_PKTINFO support, but initialize the report skb control buffer
> and copy only the pktinfo fields prepared by ipv4_pktinfo_prepare(). Do
> this in the common path so both short reports and whole-packet reports are
> covered.
> 
> This removes the accidental IP_RECVOPTS/IP_RETOPTS behavior on the
> mrouted socket, but that behavior was only a side effect of copying the
> entire control block and was never intended to work for these reports.
> 
> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v2:
> - reword the commit message to say the entire 48-byte skb control block is copied
> - mention that IP_RECVOPTS/IP_RETOPTS on the mrouted socket was never intended
> - move the pktinfo copy to the common path so both report branches are covered
> - v1 Link: https://lore.kernel.org/all/5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz@nebusec.ai/

Sashiko keeps complaining about more bugs with this code. I think it's
better to fix one bug at a time (with different Fixes tags). Let's go
back to v1, but please remove the memset() given alloc_skb() takes care
of clearing the control block. I will fix the remaining problems after
your patch is accepted.
