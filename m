Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA49F3CF976;
	Sun,  4 Oct 2026 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132631; cv=fail; b=QBWHWm2qSDngA7qJBeoDa5RXlLbq7pHn2mFJxaClsLGQuRNNrvsWh+sgJr/kRoIeOyiGZ8OHgeRW44Nls8YVwTbbUITA6hMu1yNq06stqWgNI8H3iEZv/IyhsEz8IXbxOmBpaB/yVLCz8nzgLN5df2fXVJBXm63h1GoaKGw1nDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132631; c=relaxed/simple;
	bh=V7PfFJpYybZksT9sQZVedlUbD32npP4UsQ5JaQtpnmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sV0FFRWGeWIAV2ghSXY1H/ra+zAbcWV3EkEAJ0owMhrg8mHripDgxCa3kysmGG/8LnDjW3lhDXS5k4H78KAQr2e0auSkN7iLzadtkAu6mc9xtZeVh2IRWAfLK9IhShYbK6G8ICJHx1JwIrk3ToWfDtNdyOsnGo1LZn2gljtPHys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=POKwxY/6; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="POKwxY/6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSgOcICvR2MapHF1O4BdlR35dtfjkOb+tyodtRYo467p3+/mNTysYHkXBVyYRwMdj1aw7XRIxI5UfIdB74j92ak45y3CcCKu3L9uQYT59S9tfu4yF29bW1/kf6A9xrgPMIJ9TNYuYjeF7GxwiNpzYOL8/XT3zmNNHblem/IMk1EjgIaRJAFS6FSqZQphByq3a5g03VksBsXliv+AdZiFCMRO03NPzApKSMl1HufWdwXzOFYbv40qMrqEgneFBOZE3umllaDKW6yO1+lr10b19J/BNweHa47hCvOlnyFS4zH3SB7ryinwacVXvy6WqtvnR2OrJYhnT+rRa72hLXKslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGFZcS+sijbsQtz4oMyzzrZ+x5lg3Ter8mxyRhdDehM=;
 b=WZTfYg0N0gCq97+7QeeSYXdoH+/gXLEWW8KQvHz2HIffoqg4TXX1HqdOHEQYUNeptvflsJ09/zdkoU9Pv0liumhu4FBlxMgfGJYX4/ihu/ju/N5ZCRnRbQZgcrKcEVF3woX64FKDUa1dzRB83+qVAvqhR6JtFnmWN0C9K5YqNMHgYZRXBlrRKYjWColVm/zykaUb6C0DU+URVSm7eVGNn1qtw2oAIhFJfkvG6Nxc2j+PkJZ3tkXVQxu3ubPzYRWNoQgxzE0tYJ6MZzHaCPGD/rb1YBvBQIMPYXM6g+vmpnomCvwoh4gn2W5EELE+a7RX2malQwVX3fGKb3HTR5KSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGFZcS+sijbsQtz4oMyzzrZ+x5lg3Ter8mxyRhdDehM=;
 b=POKwxY/6v3J6Ho4ku3rLJ+YYCL2e+3WW+qVEA+uVe+sqBrLu7Rhm6dCuenocz2ejc7SRY21NMiX7ZJjPfOPOEWlfd+Sr8GRrGrW6XeHrTR5vlGia1FlKpZEni2RCG9ZQttISX1NqnL2Rqk9uSxX9FCTqmSPF5LZ9YiGSBbgA6Qk+rbuZtwq1SXNRNbKCJzAWkWBMovZTKwwy6LX/W5WyyndmAHHiWrV6FyTdftYvOLK7cMxRg0MJnad/dieMehNPOv5w9qcAsCbh7XZtmy49Dn9j3lSZ3qhEr6ZfxCFvd71swDAAHOuCpu6cftaoLEfms03dV0p26LAb7d3/LUQQzg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sun, 4 Oct
 2026 16:50:21 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Sun, 4 Oct 2026
 16:50:21 +0000
Date: Sun, 4 Oct 2026 19:50:12 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/14] tunnels: add core and gre drop reasons
Message-ID: <20261004165012.GB355212@shredder>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: FR2P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 3553b871-3715-4952-0b19-08df22379453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	3puXEy7unvfWzQhbqAxBH4pKhoPQI1l5hWPuf3EiS7m5cnPJQ/rowZpNAlbDxDImn6SqpNmFbBJ0TEYrNGA7UNjb0ymw5nHVevwpPLzRd9vKCSf36/D5iYq49EZijg6sAYzPfrQ5sImJ7Hr4uvFXU2xmvCppDAUWtEJMhnwXc+hhoIC/DRDp/qGNzn44tJ+TgHYEgFAdOLh6h/nQpkSCEVpV0+YokoKSOkJ6UdDcVhNtBNDDzuEMibq30UEo+4YCbrY8oOUEWRECjs6vFcxBHHtRN9OBxgLdKp8cFWeIEgEQmW12I3xTAInaJ9pI9Jc9bK48jemldJoUnkA1uZhRifDeBNlXzLMsNSSDRnv3bltrnX1K4QmPlEHax9GbzBEd6Jy1hgj83dUiwOvwZ/apizkDFvzgiGQU0xRI/D/R8voX53K2IvI7ldmOe5ACaon0mtKQbAwR6nQi5qsWS08Rm6j5sx2s2lUievGy1zUx31VjtJcpAPDCwuZUylPp7Tsz10z9K4OZO4S7/CUBip1hp/cWm7DoEW1PI9+0a6dgp1vaddRJQ8XoGg0NURy32tUw2jmaQHwlWXKPh0kxixGzEXQmPNsmofpOAt+MI24W9wAdszGiwyCrmksZo1YTUHj64Q4X/ygByEsaSovD590c3A9cWWK0MmbxRYhkLwbpr4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H4f0nHQYdyQ+CapbZxWW+J1RijX5G94Drtju+EYkdepDysXoNxdCVysd02eV?=
 =?us-ascii?Q?dRzphGV5vKFBBJKUDIR4icHU5ijx43ifMDJWbqVs75qOXKOGrTkK8sTXXdeo?=
 =?us-ascii?Q?kZcjukr0+VjKz7eg8aJ61a49dBPdkCIGRrfGan8JJEGH6a+/jcSAeFnhfgVv?=
 =?us-ascii?Q?hJVuqiIV4v92GLYD3oSWFTzLTmtVPj5reg6tSQuLGL6+Wamv2IjSY4FjImAM?=
 =?us-ascii?Q?1v9kaqkzK8T1EEB7G8iztmNmVUth9X0c+cOqfusyWxlQxgwVbUsSpv53ronm?=
 =?us-ascii?Q?iwq87hmzvyEZzTrwyX42raH4W1tRJeKIIJEQ/Zfycd+vXWoltMXQJ7ZLPjfI?=
 =?us-ascii?Q?DI+ag+yuquf3G2VZCSbe0OzA3pSFSpYJKwkmcH5jfT7jiYF5BXiXKcDASnKU?=
 =?us-ascii?Q?IdMpcD4J3bwA5RQomsLqUXzNTgJh0tE2Bm8GqVcBRs0EdjUbK/pV9b6WudQG?=
 =?us-ascii?Q?U+4/u194SZVpSevDJ3oCGWbkJmOeU8MV6uDzI8JbbmCqY3CBxOWw0orgsExg?=
 =?us-ascii?Q?Dl8lu6YnV7HiVzchzvlgExhPsbvhwFXvzsnF9IBnbARivI9hmT2zWg8sOHRJ?=
 =?us-ascii?Q?k2Il6fl5e98Cjuqz+jcBHtcxz1bG7hklRZxcu4poU1h2ycpiQ7ReU49RNhPX?=
 =?us-ascii?Q?CL5KOmj3ubqRbr2T8M5A7P3SlabxE0/DPu6b+/0bt0dL/a2iSu2iEM2qDQg4?=
 =?us-ascii?Q?YObnIN9gmufpG8rBYHd8LpC+UP56hHzNmzbBUHd3LDwVAAHv6zClSpGvUlq6?=
 =?us-ascii?Q?PKIHh3sTCzY172gpa3dtDm/xo7blEDfdY/NPTxz8wWkOphlLL2HfW96iy0pa?=
 =?us-ascii?Q?2b3x10/h2t5fO535OJ5vLyvjftj8zKTZoJrLLvn/FOxJhDkgHLWu9ugRT82q?=
 =?us-ascii?Q?a8w2mM2O/FPtG0p2j+P8yfS3Wc0M0flgKhUdu8hqzWJ6EzEkzM1qHgFII4dw?=
 =?us-ascii?Q?/JUKHANUB7d4XzzsmgYaXJ7HUGUSyEIKoDoNXFvNX49igWstmi6M/RDm655/?=
 =?us-ascii?Q?EQEWDkKU3X2pCgT7N5tuCTYKRZJU6W3nWUYgbhAAkaMjad1KPCLWv1WUpRtY?=
 =?us-ascii?Q?FZmM/8ut3RspxRYI/Lb8sjNHG8rph7oqFbi90Nwj06gOz/bL0VNI5a4bXOoR?=
 =?us-ascii?Q?oivVeDwRQ2W0DhrdIaAZcRKTApIobtigQijfldJ2Y3qukRJEjrqHTHNJOdbz?=
 =?us-ascii?Q?MiINmHIrENfkT8dUnUjdg7Co96WjJlLwsH00DjkCrOKQIXP1MdcQ80JXTWH3?=
 =?us-ascii?Q?3jtRPK7lQzGLA01nLzL/9NPFmplbgt8zYbQDkYAWBXaaCXSYQDbBEFV+EVJ+?=
 =?us-ascii?Q?G3o/N3yK6AVZZzCFPgJX4YaNxpHvPo+1n9VJgJNUZfQyr/BZUX+yoxvH16eF?=
 =?us-ascii?Q?4nJ/K1fnPgaviTctfqaTvpWNwcyLKV7HAo9O45Ok9uJWGkUS/eeq060dirZR?=
 =?us-ascii?Q?DQv8sT6u21QC8mjcGJfc8pwsjzKorvYtkW4Zru++npPqvB2GNXGsRKiyKVOs?=
 =?us-ascii?Q?bNkDpgE4jSLIiq40hRNw+y/SymfMRlv5mYxy1mLb1CQAd7QvH/dJUC0ltfnc?=
 =?us-ascii?Q?wzQSbu3/cW5zeYaNPBxYbvJT7WBglvWztlAam6VZiRUbS0SkkwZtdI6vOvj6?=
 =?us-ascii?Q?exZ9wkLp/N9V3sexdW5ASVfL3c0BxBM42KZMoTGtgi0cF+3PuVNIZmxdfjTI?=
 =?us-ascii?Q?2LtP3fxm/fe7EcqHF7R7WoPJeuKYjpOdN4cFElR67IZYmKNy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3553b871-3715-4952-0b19-08df22379453
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 16:50:21.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7JYhcDRKDcxSyrUE+ADUjqUKV6Dm4PgF2edtHNKc9qDDUot9qJYoJsjRIg7+3a5BBYukrtlrpJuXz0yycX09g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

On Wed, Sep 30, 2026 at 09:38:56PM +0300, Anton Danilov wrote:
> Anton Danilov (14):
>   vxlan: rename the drop reasons for use by other tunnels
>   ip_tunnel: make __iptunnel_pull_header() return a drop reason
>   vxlan: report the drop reason of __iptunnel_pull_header()
>   ip_tunnel: add drop reasons to the generic RX path
>   ip6_tunnel: add drop reasons to the receive path
>   gre: make gre_parse_header() report a drop reason
>   ip_gre: add drop reasons to the RX path
>   ip6_gre: add drop reasons to the RX path
>   ip_tunnel: add drop reasons to the transmit path
>   ip_gre: add drop reasons to the transmit path
>   ip6_gre: make prepare_ip6gre_xmit_other() void
>   ip6_tunnel: make ip6_tnl_xmit() return a drop reason
>   ip6_gre: add drop reasons to the transmit path
>   vxlan: report a circular route as SKB_DROP_REASON_RECURSION_LIMIT
> 
>  drivers/net/vxlan/vxlan_core.c |  26 ++--
>  include/net/dropreason-core.h  |  53 ++++++--
>  include/net/gre.h              |   5 +-
>  include/net/ip6_tunnel.h       |   5 +-
>  include/net/ip_tunnels.h       |  14 +-
>  net/ipv4/gre_demux.c           |  65 ++++++---
>  net/ipv4/ip_gre.c              | 199 +++++++++++++++++----------
>  net/ipv4/ip_tunnel.c           |  64 ++++++---
>  net/ipv4/ip_tunnel_core.c      |  22 ++-
>  net/ipv6/ip6_gre.c             | 236 ++++++++++++++++++++-------------
>  net/ipv6/ip6_tunnel.c          | 153 +++++++++++++--------
>  11 files changed, 556 insertions(+), 286 deletions(-)

This patchset is becoming too big. Patches 1-3 and 14 look fine to me
(wait for the bot to say its piece) and they are mostly about VXLAN. I
suggest splitting them to a separate patchset. Wait for them to be
accepted, then send the others which are all specific to IP tunnels.
Patch 14 will need to be adjusted given that it references previous
patches in the series.
