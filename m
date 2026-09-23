Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65349BD70;
	Wed, 23 Sep 2026 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173178; cv=fail; b=NEKr8NTjubpO8jQ2pwfNUN2wBfr725NZzYPnW7ceE3qbhZnvA1VEbmd+obusCRGOmaGNUoPS+F5NdBJUsKd6Wy40Qgr0ZxjJXVXiWZx1T6ectxaYUwQdD3MyT5TR0V33+XIMz7ygn9nwScjmtp4z975RwijapxnIO91GKZXwkf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173178; c=relaxed/simple;
	bh=2ho/dNviXvM8/ugSw7S3VoLQJy+CYReIK+A9cWSnFr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bFn04e6c/RZV+8as3shD+7xp3h6EzeUrBYzIDzIDhJSYBaXyhHwkjltkAOc+XiQlpQ/mXfCIrVXWk3KoX0b2/P1tpdCWHIKgit4SZbhxkRFlsQ41AlbtqVX98sFessDHn97hDfZM6znBPCLbv5JAMBoCBXImA6jiqz8Jjsx71Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eBYBtlVN; arc=fail smtp.client-ip=40.93.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eBYBtlVN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWONn4qPxVk5WRNrp+GugnMd3Sq4tdmRhP9UayTgno79p7FqaXaQa1jNBv/HqUTJnQu5SprhFMVY8o/439dmIelPaHyCLyrdTUTQvKZG87cnTTg0xxNV4oSDYcBiDdHeJJm4nCJBSv+evEZEXk2ynDKIBMtoQ6EIWybQ/NcmZ1lH6BT2Y2GJn8YjvxmKf0gEzyYMtnIUYpavEcMSSBR/2rmbiazxc8vUv1elRj1Fl0xYSmh6ZwTaJiUQsHuR20GWRZdwn9LMBT7m2FdPdZYsLnDr5OC7Ilo+j2f/e+mUMTSqEJLMkYsPb8YoopkhK23V5nHDKP9uP4ufRbdSqZ3ydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLjK5SH00O6onMmOH75qU0XWQFfv2j0KKevkLTOs0mg=;
 b=bThjDS7mOjqJpNXx8xJevaVNw00aO8persvGtnIjMPHFt/DLGE83NL2FhKhNQqk0smX7If73trvwtiWY0M+lW0w8+xSsPrYe6kP5efhLW1v2klow7nIjBaJ7v/E1zm11Kwo8pwQflElVUfQ+Pq/gO3eTP564offSW8INGEykh+9NZIBGVvOgWp3Wf7qtvpcROedf8vP4/5zo9VSDT/svhukFXoK6we45kob13CzqE4R5035hIzInyJx7eXyEdPQj4U9tF5jXnn71A+kdnxCrT7NutpCMrLp6AoB7CfQ+m+Y/gxB9boscBjtt42nktb4CQLtDdEw1CAAVWS6phmBVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLjK5SH00O6onMmOH75qU0XWQFfv2j0KKevkLTOs0mg=;
 b=eBYBtlVN2eeCDyPGLXGa1iKxWsNIicbQW+tXtr5AZeR0haQ8Jm3Dj3rPRE9FUJ0rO/keAGU4mP+erYD0C2qIHeFCeqk6qSVFTStRAk2fL6wwlJqPFB2xFbDjssel6ZjwuM4Mra6yjFxy6RWYZxo2pXz7/siOIBSSCHndJeorEya28vQN8LQQ70OXqNGAXa80sDBVGSJryDjPQmSZ1DW3YtMRT+zY+OVG+eFjKS4jjzH2G9rmDY0ptbwMECy4jRKIaZvzDvWQxUuGWnTXrwlS0dmpfP7Yt27YrcGcJisISPe0rIX5wnMpq6gCFp1JMSVY2V/GRwGEMeK+TpeMvMJlVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 14:19:34 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:19:33 +0000
Date: Wed, 23 Sep 2026 17:19:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/10] tunnels: add core and gre drop reasons
Message-ID: <20260923141923.GA2841095@shredder>
References: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 54656d89-40cf-4f16-9649-08df197db0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	JrUxoKmJyGxlgjOMonWuzR2PB1m41V4shgJzhMXmwv8cHwFmK8IWrgjEoYptIu5kqXbIPBX7jLXfpdxp/i7n2z8s4oJEbDftSrHr2Sg526h84pXoLDixtDBRxA1yj1NE2dM5zRVELvkkddkwxN1QiD/Hyytiv1Im3fSwLluh8TIdk9yI1Tvy+scIt4bUqgIJdXMG/8wGDbT75f0Z+OhxtCRdUYfXMC8H8LFccNuL7X3VEy9h+kR8I7cVOzImFBOmM/EqBot179ZEMV2j5AnzQCXE8+vkZJu/yG0L7dv5wFpAsuduYXS7rfZmzZ4RfWilJ7HahcrCitjeIKdGwe6v7M8QL4RVtyuebBGbBzsj/nGXrDbN/oaQnZ/efbcVJszxauppRFRVX6MA2aAP/N/utlfIq9Ecd8vR8Bigoxb4jGeABmCPp36bBYMrcOmwnVT+pNr67bxzl8pNYFq0Tawb7sURfOAWQ/wPsx+qlfm9fmHflCX6KiFGW8YiWGul4XzFkPisDu85NaEqnkCAglwWOEdN69RKVRa3LbXftZwa49jwjiJ/Et+oHsZWBxp8J4O7bgUulvqbWPpZSxCv/vHFI2KXpRNtooqLmP1sIqmD96t9V0AokockQf6JNWiKPaH8Scdo1b/lYqZ1/xxz+o7aviiDoEAi0P+JSFrnEQReF9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PGpwDU/18jkhs+R4J9QIgSnIFes51IOmBRVUIJH2bW/d6xZC6W6uHWeezDz0?=
 =?us-ascii?Q?ml9CkqNtJf3ERRnc3NGfW6LpzBhXtptP1Qqke8+SnOR5nV2WbnwWWryAqGfI?=
 =?us-ascii?Q?5BHaAQOROaXUxDjhxN4Wv9/CaqptdiAWKBJ8ZVGB8g4UJpnVa/84a7wpjpAk?=
 =?us-ascii?Q?3J6uL/OWOpRbi8K/ozpdULxSCKh0NP/Fg+6MkastI39hw4klrEuXHderxYyN?=
 =?us-ascii?Q?Qj7mA8fyhPG06iU/+YMCrpF2jeX88qDqiyfVpMKdLdDlgQz2EV4fNUdzyKbQ?=
 =?us-ascii?Q?ovhZAU0S3YZwvd/nik65R12TQFHb/4RSK/u5mEY0n/tGy9o4uQEvbtKkNrje?=
 =?us-ascii?Q?E2VxKo5Q6GLAlz5uHDuuSx68KFTXEjCD9HpdBznmkeh5LfBDsomlb0gWSnx2?=
 =?us-ascii?Q?Uyyqms9T41olErWKeJYpDWs94R9ivGLA0Su8qg35ckoDgWR4REjSwMpjtfS8?=
 =?us-ascii?Q?ujIscKSQFnBYRsXqh2mN//Vsb6zVNfyV6NT/7A0tgalqpm3+XqKcL6gOvbgR?=
 =?us-ascii?Q?xMZ/YxmvhvU3cE9FcbJOgqcvQ05dcKmlw/G5V81aEAefOFFfly1/8tJ2t0qp?=
 =?us-ascii?Q?9YhYxRG7y4uJnmpn8Pw8fdzTHWfQqrI/ajZlCf9AeoDG2hAwSGW/GfmE+fp5?=
 =?us-ascii?Q?jj5xPhgxrwu1BJKA1cOjewGvwaCuaukhlSrtUSdoWUs1v46SNuDXwn0Kl1dH?=
 =?us-ascii?Q?usytfKTr6FQPB2uRU+teIOw35sC6wKqDN/zIav76Xg6POfj/glYApODCHSzI?=
 =?us-ascii?Q?cSXhGQM8hKPViWQeNXlu5zCcM1/U/383RAv1NUTBts1MtyBjdV7qzii1MVAc?=
 =?us-ascii?Q?7jURivL9Dtlnvw3aUdDh00SqOOlNfy57DWjQZatdlm5RNmxEqguBlAdqg5pY?=
 =?us-ascii?Q?6mfzcWWb7TvskgiFWpNoP4ARzlHQmlYcTXFBPp/M73prB9zDEiqnClmMe1sS?=
 =?us-ascii?Q?dGhSBcOwIR6wmYLZ9+oxynA891hfuKDYio6SabdFmeP3wAnrsKVQFlP6vQLS?=
 =?us-ascii?Q?+KwTJu5gluKme8u0qrcxZndsUqger31ShpJikLvR1dtkGeh7kWvclSw2eK/M?=
 =?us-ascii?Q?vl57PHo5P3/BTM6ZxENm0g6UHXRA00tbfQbUCS/4ltKwtKVWOeUomsBoqYCy?=
 =?us-ascii?Q?DKzUIOxXx8B8+pfR/BYNDJUacjowMB3H1jYFvGh+AbAjvJX7tghLHhYsKv98?=
 =?us-ascii?Q?44CdZl4D/+j9fWtNc8BdYa2W5ZcdtyF0ZHgAakDmEjlPJQAueA0xhlwR/wHw?=
 =?us-ascii?Q?FuJ6f8Q1nGtylI2BBQmce0E8/Cl/8Wc5gXODLW4Z5NgRGzMsYU/Wyp7BT9fU?=
 =?us-ascii?Q?CGXJ3uSqO8W/8PH4/vanA8yhRKW1LHxgkrNkhPRW6URI6WIj53Cp5CxuWFqr?=
 =?us-ascii?Q?262xhKvEtSuXiotYR3IaeuaQo6SHXtNC7EWFSFEWm/3TGdK9qHbRRpsWNBCz?=
 =?us-ascii?Q?g73iQYwrAhP1OYyF14gPq8yQeD1FRhdNpiIeDU8MD0G4Th8bF2qokQ9dHSdg?=
 =?us-ascii?Q?3i3llbKTAs5qTTWT+pcyH4141MG/PCZ79VXqEhoAZkzgkMrO14cnNapXMk1b?=
 =?us-ascii?Q?dqhCfqsU8tDQ/MQ30UpmMSGTcI50MQNJQ0nF6//nEVYOo/Fiyj7mPAvqJP49?=
 =?us-ascii?Q?S/B42lGKLF5gcjh1xe7X9iIbQFY6/XDlmnme7vLe2z09HciAmIfTkGpCKW1u?=
 =?us-ascii?Q?lFIg8YjzMxiG7+MGczJd1eMHW/Ycw2cMbKW0SwnmX5Nl3ez5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54656d89-40cf-4f16-9649-08df197db0a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:19:33.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mM3y3wtVzmatEu4Uz12QImojly1RUH+hM3Vaej9xI1wLETU+0tqkmYnG1T9CQUZ6KlCi+dF043bKugps1GMIQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

On Wed, Sep 23, 2026 at 01:14:57AM +0300, Anton Danilov wrote:
> Only vxlan reports drop reasons among the tunnel drivers today. The ones
> converted here free what they drop with kfree_skb(), which drop_monitor
> and the skb:kfree_skb tracepoint do report, but as NOT_SPECIFIED, with
> the call site as the only hint at which check failed. That hint does not
> go far: all the failures of ip_tunnel_rcv() end at one call site, and so
> do nearly all of those of each transmit function. The call site is not a
> stable interface either: its offset moves with the compiler, inlining
> and the configuration, so a filter on it has to follow every rebuild.
> The reason stays the same across kernels, whether NET_DM_ATTR_REASON
> reports it or a BPF program matches it by name. The device counters
> group the failures coarsely too: rx_errors and tx_errors each lump
> together unrelated conditions.
> 
> This series covers the generic paths shared by ipip, sit, gre and their
> IPv6 counterparts, plus the GRE specific code, in both directions.
> A later series will do the same for geneve, bareudp, fou and the
> remaining IP in IP drivers.

Please only annotate drivers that you are familiar with, using and can
test. Otherwise it's a burden on the reviewer and potentially useless
code churn that will make it harder to backport future fixes.

> 
> Patches 1-2 convert the generic receive paths, ip_tunnel_rcv() and
> __ip6_tnl_rcv(). Two reasons are added:
> 
>   TNL_OPT_MISMATCH  the options a packet carries do not match the
>                     tunnel configuration
>   TNL_OLD_SEQ       the sequence number is older than the one the
>                     tunnel expects, like TCP_OLD_SEQUENCE for TCP
> 
> The second one has a failure mode worth naming: when a peer reboots, its
> outgoing sequence number restarts at zero, and the receiver drops
> everything until the peer's numbers get past the last one the receiver
> accepted. By the counters alone that looks like a misconfiguration: a
> packet without the sequence number option bumps the same rx_fifo_errors.
> 
> Patches 3-6 convert the GRE specific receive path. gre_parse_header()
> returns -EINVAL for every failure, and the only detail its callers could
> get was a csum_err flag that none of them read: both ip_gre and ip6_gre
> declared it, passed it in and ignored it. gre_parse_header() now returns
> a drop reason instead, and its callers take the header length from
> tpi->hdr_len. The receive helpers below gre_rcv() return the drop reason
> instead of a PACKET_* code, and the PACKET_* codes go away. Three
> reasons are added: GRE_INVALID_HDR and GRE_TUNNEL_NOT_FOUND, mirroring
> vxlan's VXLAN_INVALID_HDR and VXLAN_VNI_NOT_FOUND, and GRE_CSUM, like
> TCP_CSUM and UDP_CSUM.

GRE_CSUM looks fine as I'm not aware of other tunnels that have a
dedicated checksum, but GRE_INVALID_HDR and GRE_TUNNEL_NOT_FOUND should
be renamed to something more generic (e.g., TUNNEL_INVALID_HDR and
TUNNEL_NOT_FOUND) so that they could be reused across drivers and
replace the existing VXLAN ones. Note that you don't need the drop
reason to encode the tunnel name in order to know which tunnel driver
dropped the packet.

> 
> Patch 4 adds __iptunnel_pull_header_reason(), because
> __iptunnel_pull_header() reports a packet too short to pull as -ENOMEM,
> the same as an allocation failure, and ip6_gre calls it for every GRE
> packet, before the tunnel lookup.

The series is inconsistent about this and returns different reasons
(HDR_TRUNC / PKT_TOO_SMALL) for the same condition. I suggest that you
convert pskb_may_pull() to pskb_may_pull_reason() and return its reason
instead of HDR_TRUNC.
