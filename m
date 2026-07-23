Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736D41D23F
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814747; cv=fail; b=FR2eXDEbqkJlUF5mhPT/Tj5+ke7JT/QIHR603jyoVpYxYihyYE9samApqTEVZw0vSRKvpEENeGc0ruLwYDiZLSRS8c7ENjZsaoxOQS9PUwAQkRjnsTnyar+5PqTymnLk3hhtGf2OThDHe7q3LKNZtiR9uXDU37O5mec8eqrFEpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814747; c=relaxed/simple;
	bh=PhFINLVyhkk9i2bus2B5hYE/lNtpWMb0ztapt8Y7yDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=piu0jJroxnQfLGEluEhKVGAV3+cq7AzifHFMWTVEbPV46/Qw8PM88XODiZxyxe0sp9aYLI9TLcSw8jRbkQMwGKMcXfeCCIpf9m7Dm5a3XKrSTB2nZcZ4NCU1FUzBtFS7zwNsuM+eefHprrBRDNzxc7WaSzinsHRU8U5UhA8ZgYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zwv524D/; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zwv524D/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMZq/gMY5SP+Zd8+vx1kFybq8dZ4/JW+Wq3X6802VKR8Poih+3eult0t3gGQV8m1u5WkGV+PPewBzt92AyW+SGqdlGoPdLmVy5KCUY9wSIEO17D5xDS95XM3UJWNwuSt2gMm22JhDh3KcZNkFQUN88BHN6TDoF9OmS3G6L2FYnD0v56Pc1Dg0xGzXneM59lLDebU62TA06CxnNed17/6F0Znaz9pYtDC3sMyYlaXQpo+x0dSRGqdMxgvMTq2R7rGP1JeBe2H+YtGTrZHIvnMQ9nLF3+E+PFPefvHbhe1zLNPewO31Dc+8yiQYIKzBh1lfvb9ker4KXgGcdbBPX/q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQ5UHsVfDIKzofs5F7StsQ7rFMSOa7u1EiGphK/SDrc=;
 b=UmxFPNHDlLI2VIvJ/eRCNsSKqlWTovnhgY4wr9+IuE4LslKjazhL/uDxiahz3N3Uwp7xDaijU9z/JRCUg0OPuRy+ypbduZ34qqA2TizkPOS1UbX3QlncDerCr37Tpr7YxjKPMD9zo7Dv66WkqVvwC6AvxvDs6N5tlcViKtCqCzcbaPZ6zKTXWS/1CeONz5hHMpl4JhMvPUSNoDZ8Xh8dRZtzYKV+XoQGuEB7+63gvwfD+8Oo/cKfd7LUORNQDOkMouwuZv0TNv+2DM3JG8Cp+GkwIdstoGLtDT0HuSUTraVqLUUOpNV2RjefRn8vFfsy4FRuBBJPpseXFfUd0Hv5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQ5UHsVfDIKzofs5F7StsQ7rFMSOa7u1EiGphK/SDrc=;
 b=Zwv524D/zCRz/G7MJHciv9hnpiM1b615f1tfo98WwQE8RAJzRGTIsXyImOlcTk+ElNVnf/3e0CCQjnipSxI7/kx5gkUCAYZoQgEx+Tb8yIaCmkzCyX/fUgKDTJJ7GC4ktXN7/S6XHMCieCr2C9JH745B2KjBDMt5fxRbwPTZKpikl/ptfbTas8JrJ5TxD3tkFuocfKseqI8OOsJsO9pyywKVO78NRHu602+LKR71VAbTBimpSnaRB6JprcschzeCDfVyFGKXADyauLDbM+HiieaqBV+oGnWvYzwPFJbvA/fukqM1BvtNDi2HBDbyKKenvTZ6sSug2ry/+S42J81L4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 13:52:20 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:52:19 +0000
Date: Thu, 23 Jul 2026 16:52:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Muhammad Ziad <muhzi100@gmail.com>
Subject: Re: [PATCH v2 net] ipv4: icmp: fill flow parameters in
 icmp_route_lookup decoy lookup
Message-ID: <20260723135209.GA3377495@shredder>
References: <20260722104236.2938082-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722104236.2938082-1-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: ca74a6e1-7fa4-4721-6558-08dee8c19d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003|6133799003|11063799006|4133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3MZ+DEJmk6kvsXmv0dBAC5SIgINvWbtZmjXYLkKwKS9DZN+XvSwKclzWo7Sw/VLaUs2W8Rcs/ni6q8bEINfEKcZw0RYDR7qmlJtbFYfpXDwns3iPPdL451/Lx4wug9oplyysonVSBNN9czi1a4CbboTqXXvh54nXS1moN81GYjC8j/rBezqfNEMq41Cs/vAF3m+Dw0wUB0SrmDIQ0WUMFO1GRIL075Ys9w6XkqPWXJlz9Wk4CLadOD46vYJgTrgZfaRT1rxOn2R1tE/QQE8cZy5Ani40p148vDZNIjtPxo3lGyMi6MxzUWyZBVLJCm7MapDkK8pA5hNlkdwVRPJkfkgT0KPZKhhBS0Ucax6Btzhadk5AlIfNYKJsZNoRG3t93Xop4J9GCLt8GlSxPxsXV6dIltSYiHsPBqlCaqsrqkYJIVgZkNtLzIIEjZ+m3HTt2Nrj1rshCQOpf7+30Up5o2/EtQVxFJWllHEJtqhO70o6HUWJQA1xqsM5T28r+8plUxXUK6er7kSyaJMbQjW7GXfWoaDp7PUpUwUM37KITPDvfLl6Ymrg5dOLQ2A5ILyvJ1qFGyA1aZKm80TqrfHNVTg7aFAxdP+TAqVISD2hfI/rEO/rsbjVLPanZDFcQmOPfXRxAbgpKoHLWy6PWC8kwR821lhurhzfLhCwQNsE++0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(11063799006)(4133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ZWLT22VoNBVLTkcleLNA9ZUpubgU/N0euI/HRvuvNJ0vcMspp6DrPngmzfU?=
 =?us-ascii?Q?EOvNpAK8GCmYrTLRAODzgM1MDBaaq7IeyNCgDV04e6Y93IZa1k3gnVKJh9nP?=
 =?us-ascii?Q?ZqjQYKICeoGSDnkFYw6KbCqcDmTy/Mj0DdIa3HmV18N5SMkGdZxUxT+FdM/g?=
 =?us-ascii?Q?mzcqZJr37FzGzEgvRGsBarDMPBmHr6NMpbrJ4bf1FADjU+kNag/zZKH+s20r?=
 =?us-ascii?Q?jg21APvoTXLm2xNcZ52SHFit7PXzlM1dfCudUEbo42I6lAOx+ZkW5/x7V1lL?=
 =?us-ascii?Q?qhm/SEbv3mFT0kVxoYY2idumzT67SPslXfRK03t3Qc9yDxVzihhZGqC/lg3L?=
 =?us-ascii?Q?RxColSx1UHFi3M26ZkqigBlJmvm5JTw69JV1lQcK9tE0koNPdqaxE2V2gNlf?=
 =?us-ascii?Q?ad6lsdYjJO91jRJB4Fnrm95LyUtrpyTbJ9px+pex2dsuyTa+KXmanT0nDobF?=
 =?us-ascii?Q?HR6bpiR0gbizGViAZ74plzNV9TyMVck0HJMfvqKFfqeO6Wwm3bplp2/KemlP?=
 =?us-ascii?Q?7ZPVKR0AKM1IdKHNKlUTgM7R8BSSj2JZDKxx3QbNX9N3xTq8LVaJk3hbCOsn?=
 =?us-ascii?Q?ykmaxNJAnbbyxerKBxLaM+ZTjxiQJEOn1uhRpdaYBduIaHXoh23Shcu424hF?=
 =?us-ascii?Q?ppzvTkIkRf/NgoWHZ4al7rH/H1v5MsJMgZRPOjLfLhPKoWxZMgHTFQmTR4Ro?=
 =?us-ascii?Q?DvL6QUm0Kq3LLsoW40IzqqcBUtpi4sAlZuzuFy1ABGuH7pX11vCa2971J/mf?=
 =?us-ascii?Q?+xXmjoqtuXVGETvClt/YDYHOVXJTzH71QU1l0DJVMbHJwpssydK4R4YLnXZ6?=
 =?us-ascii?Q?mYZFXSQ5x/kNZX1JfONaBiQVGzMcrYouHwJWtyc3cG2XzfkL8pa/5ybL9iNV?=
 =?us-ascii?Q?Z+1W0ZZGOAPHl4JWiB1x6SasKbiAXndE3w8/wIkimbnTd8hOszUFQtr56urz?=
 =?us-ascii?Q?vUiFlyTevnITAhzNdiQMI9DQjaO5inkH260v5PCZ+mIOtXvYFMAdbKc5bNjz?=
 =?us-ascii?Q?i1MEwJebDsJFAxKoKflqGtqOPNBp3NdktIAni1rHUbguOHA+CZKf6wv+UBNP?=
 =?us-ascii?Q?KxLF1HKNfCf8dLBnizBI6zqWYr6f6VbHKwX/ZlwmT2bzAekHH7HwE4eTBPUe?=
 =?us-ascii?Q?VfK3d5x2AQjdyiK3FKYoG0+lLR0yCLmR6XdBStuFpnNoEqzGLsLEzAnU2Bve?=
 =?us-ascii?Q?zxHMhD30n+oIZxJAQIfK56Z3KkPCbWlUHcxnG1kh5+XxneX3Dk3JKzVWvWs+?=
 =?us-ascii?Q?fyeURVi/vRslRv3ZC6GcXYChB28xy4jzf8B9Nx1k4V4w+SU46SUzRZitSILE?=
 =?us-ascii?Q?+QJAJ27Ka1V/OKFQy+VnHPJph/40ESTLmgrhIO+X97a+KFTxHZXrT9O8Sa+l?=
 =?us-ascii?Q?cOqBgNvBcDJHT4EnJDhBrjSs20Fk4WC5y3Z/VpESqZEukxBsfiwZYDgSMeh1?=
 =?us-ascii?Q?GxWl2if3WTz+hoB3hoDxapKhkyUSAhvpB0cR0F4H+mN5g2o2AvaHFy6/PodE?=
 =?us-ascii?Q?zl9JlcTxPVSYof++dbQWKMsbikMQOrU88UrHDmWSCHYhmv5XcigkGxwKRGeX?=
 =?us-ascii?Q?G4v5+A2953tWySvWIXkIi0TS4k5NLv6lNBHiJUuBuj6+N2bEMQ5c0N3k+TPi?=
 =?us-ascii?Q?G8mzmbU7NmxwLaCqBSgXv9UjcZ3SOjRGEkPBq5gMBqujy0mWPoHHR0530+OV?=
 =?us-ascii?Q?pME+ewXK5GlhmpsPvePOI6SacUDCy5fGGh/WlP6XdaAJxwKbDbghiJc8Yi6H?=
 =?us-ascii?Q?NQw84uk8TA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca74a6e1-7fa4-4721-6558-08dee8c19d23
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:52:19.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUdpUVq3W+0E7ylE6pqO+4I5sSuCX/8kGHZP5hLyaVXRPIgMj+NqWw47RGMgF+RHhRWXYSLfhOeBEeJ/HpXong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642

On Wed, Jul 22, 2026 at 10:42:36AM +0000, Eric Dumazet wrote:
> When Linux forwards a packet and needs to generate an ICMP error,
> icmp_route_lookup() performs a reverse-path relookup. For non-local
> destinations, it performs a decoy lookup to find the expected egress
> interface (rt2->dst.dev) before validating the path with ip_route_input().
> 
> Currently, the decoy flow structure (fl4_2) only sets .daddr = fl4_dec.saddr,
> leaving .saddr, .flowi4_dscp, .flowi4_proto, .flowi4_mark, .flowi4_oif,
> .fl4_sport, .fl4_dport, and .flowi4_uid zeroed out.
> 
> When policy routing rules (such as ip rule add from $SRC lookup 100, or
> dscp/fwmark/ipproto/port rules, or VRF bindings) are configured:
> 1. The decoy lookup fails to match the policy rule because saddr and other
>    key flow selectors are missing in fl4_2.
> 2. It resolves a route using the default table instead, returning an incorrect
>    egress netdev.
> 3. Passing the wrong netdev to ip_route_input() causes strict reverse-path
>    filtering (rp_filter=1) to fail, logging false-positive "martian source"
>    warnings and causing the relookup to fail.
> 
> Fix this by initializing fl4_2 from fl4_dec and:
> - Swapping source/destination IP addresses.
> - Swapping L4 ports for transport protocols with ports (TCP, UDP, SCTP, DCCP)
>   so port-based policy routing matches correctly. Non-port protocols (such as
>   ICMP or GRE) leave the flowi_uli union fields intact to prevent corruption.
> - Setting .flowi4_oif = l3mdev_master_ifindex(route_lookup_dev) to ensure
>   VRF routing tables are respected.
> - Setting .flowi4_flags |= FLOWI_FLAG_ANYSRC to allow output route lookups
>   for non-local source IP addresses.
> - Using __ip_route_output_key() instead of ip_route_output_key() for fl4_2
>   so that raw FIB routing is used without triggering spurious XFRM policy
>   lookups on the decoy flow (the actual XFRM lookup is performed later using
>   fl4_dec).
> 
> Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
> Reported-by: Muhammad Ziad <muhzi100@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!
