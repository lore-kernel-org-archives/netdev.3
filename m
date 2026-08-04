Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29976395AF2
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828397; cv=fail; b=EtslKzDvM0uHLl1252RyO5Azu41Bry0NL71XmIAtbcEFqqoP0ol9O1sldJzrg/k2+SNNFE6Mey5BLHejtLNvUL8MffDU9z/4RTB4mnZHkUPtphgMPSd6dh5G48dU5tsOu0er7laV4qf0/UjkpFvry3uALrk4ZeJ9c3BjsC4GNFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828397; c=relaxed/simple;
	bh=uiyUnDBs6OnVB+pVpeHnNxP13/QBDR/ZD1W4hkQuYCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BAE9PVTlYCrQu7wlW/5n3btDo/Pe4FgVpcsa0H8O34p8QsrFVfEX+Zf15pTj1qiM2NqcJQaaFLtHo+x3ExtblcJFIMQlLtZtx+oZZAEwyNySp06ybBYxd2TpgJnR2n/XPXSiZEmDxeFWH1e2J3rEGrZYNLCK+zH+wc2HsIMGHMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iizbc/JB; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iizbc/JB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQwXB/cbW1h+FX86LOejzHf9n/OxghH4loi3/WE/w0cDejV1OlowIBzcViDlIsjh4kFvT/U76A3xRWc4PR6HijTq/xMVIp4jwgyULkRttpxo5q76bqqS3qTHDZGeWbQ1N5eRfewHgp3Dg5GKZFbdQBGoGXPoSqgSafp3tbJ5hCpGfXrdmnGyzGZyAkfGi9Skr88KLVA+w61vUqCv4EbJDoeSe0ryY4QIZk59ZslpT/KruSuCEI4ZImexak0gOCDgCl4rSLf9Wj+3f+ckh9iWzNKGJVjAE5JOeC43qE+vPsFvpL/gs1j4pOUC0p6iBgMcWpDHQ9JaPxn25nh9GwEyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXy9VY0ph/OS277ictUGo+ol+1ZaEfp6vLbd2Z8Y6ns=;
 b=VyuTqVuCFDWegLG/TgEOiyEw5NAGgZkGsiLvaxtLLFjsEw2smuSzvXIxDApvVK4ApS+VXzKsAZoacghC7F6Ssshi8+c/HNDkARcmC4kJop8X+uyAda51BvFJG+Ixq9Rp/vTRpf+jOkeE7dJjzqyIQJdae5k+SFpypkb8UAyJMmJGY+nHziOdUN8/4zXgwCjDzTHdwCvVFf6XmknfeXnh/seNcFJTHkfmyhr6iTsfmRgo8BVUbQ7Zxlt7Sjn78D/xmxDx18rn8ydouK0sakzsjYX5kXzTICy6VGpZRdIKAzojhFnHdsRBWASv1Uga0FFWdgc0D5KqbOn+oMXGAmNu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXy9VY0ph/OS277ictUGo+ol+1ZaEfp6vLbd2Z8Y6ns=;
 b=Iizbc/JBRRWDNXVcq1DgfXXTqaKlTGSQWX5nsnsggFwyo5XMWEU57+qt6Sd7H94valeMox/eftvoxBgQayUQ+sgpDQ+iq0k7+Q79o09zdo/lvZ8iRS24tsJEGUfaeYpZN/HsHtarxQZsse2AN6tZUGJn57FmalAdYSUMfjWmG9aa3F+AWDUfejaRzR7tYa3BNXIdFaChI5N2i2Qg1xyguH3zzmetx/XmpLn3/cBGhWAoyrtPfdANf9gXUYZtvy9fb9vK5Erb7bwmRA6Yms6MYGHivldBYG5Ye7jJHpb0QaydTf5KnJjxImhn1q0gmwEYztZdju6/H494HoJJobPc+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 07:26:32 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 07:26:31 +0000
Date: Tue, 4 Aug 2026 10:26:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] ipmr: only copy pktinfo to cache reports
Message-ID: <20260804072622.GA947277@shredder>
References: <e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd5cd4e-9ff8-4920-0b20-08def1f9b4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	CAE//hfUaRB0+Ir6dAHsfpdbMjw0qG/D1Lp+DbiyrL4c/KEMQeuWVqvsSsygp3yQspTHz0GMCmNaZyokNQJm0aC4ZWAtzgWtOqz1b1J/DOBiMVNwWmW9NiqI0bltYU4nVpnMZgOYL2rmT0/ZB0xO8bEKF2SLFoUgPtwkrnjrRJeqdICX5OkpBFoEBCZ6s2fYxmYjvNCDUpMYNjaX50gQbEO/ub3aN4pucVxlyRHn1d4L28lYrIGV/oZxkMfBPNMlSy8TESaAY6W1TcyazGVJzkZQ35ldRx3sguZGJdhm3k09FIYUpS3g2jA0qQWhuyVHEjlDiFuF1wK6J3TuMoXAfgeBHuHx4F6vFMuCxtszL7DSEdFVWjLo5120tSo3v8k+YyMfC0/4nYbNo7yxr7Dm8hjU+o+ElIifBT8P5fgwjc03dT9Bt/ff1AQnMhWHlMZKapb6PdzuBCgrE52vVCpZEOwJE4ZNhLOhj8AQe1zInCV0UsmBlUUdA8kCwpFIROOJpuLBdxW3CbPN2xpCMoy8cgbZOwSGD7iCH8+8m3rue24dDqiVVW7/I386xzMvEayWu6c9BtZ4thK8NpPhT8+f5/rbeeSCmKXB3ODWrF0CKKGEWr0pgieKW6i1uud4Z6skgjdB9YmYLEaQctyqUuAz7G8WdY+5F0z0kYQ422Z4qdI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RENmlGnWaYOvj3SExhu0iBey2BPW3Hp/RCZKX2XJsnMQ/L+zGTb6V/jiUCyq?=
 =?us-ascii?Q?YtvOx00HLpgakVlX8TgVSH0+KPWF8JZIf3EdvbEhcapvuP2fXiBgrdggURnG?=
 =?us-ascii?Q?QQdKtgg6iih3isEs9BrJW+X+F9zA7rVs5dNgRPF1CnrEcpVL1m7YEGMvGQVM?=
 =?us-ascii?Q?tOnyav7zVK3GenmhOsrmxUJglQwTwQq6A0fNOQKLqdahidNWbFCgImM8FgRm?=
 =?us-ascii?Q?rFnyyCj2uEPA3CRukDB2XWWwf00lolahDbVO4lIq+xsiR9yWF/vtGlaRvOaq?=
 =?us-ascii?Q?7/bRV6bCVw5JQ79HyRN016ygmKiqQMbR1bLIoJwfmSDFzT5u1M354+7/BpvU?=
 =?us-ascii?Q?Ow8PAXlu7R1dC6qLsZUcPDkgj93JXuL2TrLXKngQyQs0aizhx6kFPOFrXU1d?=
 =?us-ascii?Q?+eUI3YI3MDit/yPuiJ7Rd/i1S9kuu2o/8idVO7wXdn0OUhFB8s/BHXSM0qyh?=
 =?us-ascii?Q?ZRzRcwVAFKxvYGuxDoEVDeEszr0+jYVy37pNpKP3oWsoGgtwZgI4sSPVDIN6?=
 =?us-ascii?Q?FW8+FmUFhR+lDfyjtBw844kBOj8TcGJhK9UGLE3843GIQToiS+sDVJqCwra3?=
 =?us-ascii?Q?3XFIpfnbZ/GPLSVP9a+gM08bqySPxkWl1emeBf9F0F1dvKWbhevNe0ulv0Yb?=
 =?us-ascii?Q?AFxUviCuzvehrTt3UrouuspdEDzz8qx1KQor5tq4s3wiuAHaLKBVFgEMCSez?=
 =?us-ascii?Q?36BUm2/ctI0qHRTwihZfeooHFCd+8onf32mxZtPfhYoj14JfewQb31o/lZNg?=
 =?us-ascii?Q?46uNk+yeG1hsoALwe4Lb+JmKhipEv6QRp6whDo7cno9Q2gSsfJhf7bJ8N5DK?=
 =?us-ascii?Q?NPz4KaUVAo6SYTHRJvQUe9pG49aFigBdtb2rvZslLCAyh06aljrWUMwZDIyd?=
 =?us-ascii?Q?gDDcYG50CSLUiS9SsaIRHHXKYrbbVjIwsJj2sH1k7I16kWPX3S0WOAynm9u0?=
 =?us-ascii?Q?bppRTtCCdgXY6w5/SAyPD2J4OeJkxSYytYpFhC4ArEjwxIJFYJydox9AHRNa?=
 =?us-ascii?Q?dvkR0KF1/sFBASObz7ummpp4EOhXC/EHoHZzchxX05bxflvOrLj3Ebvt1Tl+?=
 =?us-ascii?Q?tZ4yfyYvW+MSzoW5k4L2G4dVviipkkJHUze+B1J/8OrJdqzHA4VAi2qFFJLy?=
 =?us-ascii?Q?ZJ0mb3fJLHYIpoTbD6dcpoNGpgpoFHZAj4Yv/h/ISqrMpoAs3G6Z+eYa25Xj?=
 =?us-ascii?Q?ELptLtZi3OThM10Xi4H7ZMNe+Rp9y51SenzGBk8YQPj78wUO4Vf1hwYHUMlp?=
 =?us-ascii?Q?R6/m+cxIZqRCrob1VBkIANU5xOYtPeFXh9ibnKcDW4n76CooxxgfUufbI9Qf?=
 =?us-ascii?Q?JK2bLsoPq4EjN9O+eqEEB0IbXnf+vefittsUZ4hhBPy0s+SQH1WuGZOV+F3I?=
 =?us-ascii?Q?YVYS7AEXKeJLIieiluyBn/1v9+gkAHcQCqz188K5IQ8YtqpttVUH8zJlovUo?=
 =?us-ascii?Q?MYAVa1wtlBuHjTLjtBTClW42aEDc0ydhqTF4p06odrKIqfEj56+Jc/xfQu0G?=
 =?us-ascii?Q?zOY7swv4dmukp4QSuUCnwoGd0yhQvPtcTpFZowZJr2OQ9mbpe+nQS9ewv6mp?=
 =?us-ascii?Q?t9ADES6BnmTWWgQJzziEMM1CqoXQUg6Na4/V3mXgc1qd+veG7/s5JtJ64Ars?=
 =?us-ascii?Q?UK/mfOL+npTXcSGk6hRoO3rFEpAlZgY0bvofD5gTueWQpeD09Eh42MnGKvUA?=
 =?us-ascii?Q?UBIuZfEiugj3aS9Cc8Dhe9Qm1FwFMoBXoBFMKwHILmAMDAueycTjtCEGtZ5p?=
 =?us-ascii?Q?TBC8iDAuzQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd5cd4e-9ff8-4920-0b20-08def1f9b4d8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 07:26:31.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mj9BtdWzqxuVmYWjMwQ9h3KmQqzSq6FKdFXAg9ldqFzZ/0tesMT9HibPIycswaYV/QR2LtVR1y7JfRZaNfg6Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975

On Mon, Aug 03, 2026 at 09:17:55AM +0800, Zhiling Zou wrote:
> ipmr_cache_report() builds short IGMP reports for mrouted from a packet
> that may be a synthetic RTM_GETROUTE query. That query skb stores the
> netlink requester portid in NETLINK_CB(), but the report is delivered to
> a raw IPv4 socket, whose receive path interprets skb->cb as IPCB().
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
> Keep the IP_PKTINFO support, but copy only the pktinfo fields prepared
> by ipv4_pktinfo_prepare().
> 
> This changes the accidental IP_RECVOPTS/IP_RETOPTS behavior for these
> short cache reports, but that behavior was only a side effect of
> copying the entire control block and was never intended to work.
> 
> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

There are more bugs in ipmr_cache_report(). I will fix them in a
follow-up.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
