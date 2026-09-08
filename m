Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EBB4EE847
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861968; cv=fail; b=VF1avsaKVxys3DrFmBGsGjvHDa8HHvx+Ev3Lfdf3mjYh+bRD5E7DC1R3l/dBjbBozuiv9o1yrvLva06t0eLBe2xgn19+p8WiByngQKBGUAtD5cyKDmqMNgL6uOtXb92hu4Z14B7/FAtypsWkZV/+oJ81dvq/zdfbPhr2MUMHuOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861968; c=relaxed/simple;
	bh=24d8x5loyn1EvP4KzOjEKNLfxUSrAx+YwNtwudus3lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mRdVUp2SI+I5TBZ1VlyqfiY1Fz6LbrHUZ38rm7YwrVKYhaFZJ7dNwoA14mmqQ9y3v5lVlfVBHUC7N462yle52Ot8OXglkKG6tx+eaYVmkwxmlL5fVoB9hsIAckrPP0Ytmv0g8G8wmQLpLZetQ01X51Nb1TCWP5V8qCLgHdDfluQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HUY1s2jq; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HUY1s2jq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6up/v9N+vFjD5AbDrFI6go26NSL0PoxWxArcnsj8rzUGGocjxNDKIbPlYnA4jOnftak73F2rJ4tvL+o3UTxeE78hm0MJ7TyH82NJ7HZWyFROcGjAjrwXxXkrSw254eK22aD/EVsy2xKMP/RDnX0cA2M7pDPWrRUhjjdoG6nqihF8R6uwzJZ9HFwTR9cak4sgYG7/dphgGbyccT9esYltxb9tcfOYuN44D5BVk49XE9cFqbqiKjRX57U7C4AwQYlAO3DHp5/HiW2qmtbOy1yAiHid6Le0sE+x7IUy/uOJh0I/HOEtZqwqu+qierqzhee+41RB6ROWcES5gwTV0Spfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2X+nQCM4tHYiIhNG6VDUC7SOsGKJaZhWdEigngqrM4=;
 b=m8SVMXAIBJiP81migdynDDPNccdisfrDPGL+dUUG/Ey4h8X7x/3vhrL2AtRLB1g1sosqXP5VW/p0NT7vwVQrSfprCwvtouzXgL/ynCaKO/u4FrNvCEL9lcOcpK7Iu5et3kg0VuW79KhqkNXE58vuYlfItYYYabIip6iVyPRTKAX/WeQw2USAeMgXtf2wNgalR7TZBmKEOVOogEyx5+f3S7JqH40DKQXdPRVOrIEODn9WR02Fa8ZYPdxa8zPZO4UKYNMZJckOZ/g8P086VIV3A8rLfCz+eOEmPN/Y8cbhbfQVE1RL9j3Eqsw/3nXs1s4MOCDPK7AH0ceAU/dUjnQlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2X+nQCM4tHYiIhNG6VDUC7SOsGKJaZhWdEigngqrM4=;
 b=HUY1s2jqxPwVzO3vuCEG4hNqqXrKM0WS6qG6XC+sDW/aUl/i5CjjlR9EXvUPbXdWdsM/raReGke8L8tvW1QqNi8lXwR6Acpun2+Q6JAkv+t/AelPmUBSD8vM4U7qEuIokQDu1ZFLKZ2k4xEaoijMGW/0NX4WQMxVNus5j+hNKVtIk0oT7UOnB5p10aoFPRsTZ4PQ3xIJJQQDwmnxkmnEZYcQazHxz2v2j3/rJ9DpHDZMtLSmAmHPZeMauYwhkf9ntfwEscO+bWwwWXwroC4C8iBDWZ8EFEIjp45lSVFr4+dGCUZtSs3GeZOVVcjeLZhMarnfRoOWwIQtMK4bgRNV5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 10:05:58 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:05:58 +0000
Date: Tue, 8 Sep 2026 13:05:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Yuwei Wang <wangyuweihx@gmail.com>
Subject: Re: [PATCH v1 net 2/4] neighbour: Enforce min/max to
 NDTPA_INTERVAL_PROBE_TIME_MS.
Message-ID: <20260908100548.GB903218@shredder>
References: <20260907215853.3709987-1-kuniyu@google.com>
 <20260907215853.3709987-3-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907215853.3709987-3-kuniyu@google.com>
X-ClientProxiedBy: FR3P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: 30287001-1e02-4c59-1d3e-08df0d90c766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|3023799007|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2+Xa/9XCTvpdWqcuHpmd18p+Rs+YnKnv/bdnxAiCy+B4X2tDjEhc+cOtDIuutqf79u5nklB18Sw4lxmUZBBvv6Gv7frgG3kUjKOa49jvsZOZlN1XctBaE3aTH93l3eRpyMMTK2nwibJdYWo9qrUQvJHwIQcAG43zWlUM4MBmLH34286zf3heuqsvbT4iVtm64vC+KCv/sex3MLF8/67P5iA8OlYZHKgTBTsVY21NwX6kFStPUCp+fla/y6KpeE3mg0VB4FD7CXt+V+IOxcms3wKanAN+Mhn8gRM4/QtbrjXFWJV/e/YgneTHidV9osehwJS6sWFhhheLjAO1e96vzmSK9ZDDI8yOwazJGNREB52yJUEH0ufm24SOSB2uQlGdAWYDyShlW01nrh9GLrMZJq3D123nRXSf/vNF2kc/Dl/g/3F61fyHQBWOmUrIyQiOVMEaINKLO51Cr6TheGYKhMmJd6UHKkcePj5wM50Vb+JDsIA6K+BlneJJELNikOMnyrx/KhaICG6/Ql5InEw+mqFZd7IW41CbyI1Lo2QH3AD3zUtbFaaU9IO6oJzqZ4w5fiFT2tjxpeSSS6FSLJEeOLB2RaJHSHcmN7otu2gcbcIUn9i0yEBztRPJfm/cNAEHyyK7/ZFrShGLIXL6YJ2OLLSE/ycDBhDw2L2z0TOrlMo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d1aRmIPV1Kr1nDvhmpurbCpGCJbqB6ua6Y9DSnE1m/y3miOvCVpbKiAnslAD?=
 =?us-ascii?Q?nMLKVZMNLD/V+T8coVUsQQ7397n0SH8WeL8Gk2x8assXjyvU8CaB/BywpCMV?=
 =?us-ascii?Q?IR2GU0NU3uE+QTDXDfQWWSaEi8B53N8JmTKd9MAQoZzFw5zjUvPsc2JEsK3R?=
 =?us-ascii?Q?iij133KEwWKZZgQ0bqLiR8CeC5goP1J53NMCEGS+qoZj+kYDsmzJG69mBNPm?=
 =?us-ascii?Q?D1EJQWu2wlVfC6vCNoOTNxSGck1cZvBWCXTRF7Eg/rFGtPrO6iIM4Le6fkjd?=
 =?us-ascii?Q?2g/tX9GTDOusU1mFsEJG0PUWRZrSKOu4kihv57etbiGVzvCYH0UA9xHySV6X?=
 =?us-ascii?Q?gkaQJgXPX/kiRI2j1gegObKySHvlP83CeQs8keZ6LaAc+MvldJtqMnPh76Mg?=
 =?us-ascii?Q?ctB5smVFeU7hS9VmDRMJR672DzC1GirayzZsj8ArD10lwxOk1zHqDd/l2BLE?=
 =?us-ascii?Q?aCPY2eP1vhxWNAOkWWhbAMdt7dKrsDRm4h4aFCraaHe8sQ/W9DSNASHB2Fi0?=
 =?us-ascii?Q?YoWa7KwdUULC1ojlM9H6U7qfOMs7Y/jCV75bozZ35M9ZE+1m0EUoPY4fAntA?=
 =?us-ascii?Q?Xr9tP6EPzGJBB1y1tgUwa6aorKq7O73zIvCaLm73iPP/xVkes4qCBm1z7eaO?=
 =?us-ascii?Q?4Qn0Aea8fsXY2q2RktaaImQZEGkaIuNG5L8g0YurBs+1YmirHrqXwpu30vJB?=
 =?us-ascii?Q?iNPULu9E5eX2qOkP7gSbMMDU7MhakGs27n/dBu9LkwM9x7pQptZ3R5lfmZgm?=
 =?us-ascii?Q?SVV1GXXUe7lMLdm4RTpSshJGXQKBQ3PJeLAFf0c1EjRY/VyTCp+AAzrctXKS?=
 =?us-ascii?Q?k728uXS/DHBe5Pjgysz4laZmg5bBCRjOCj5ERzuej/BEybkiVYt176Moc5gP?=
 =?us-ascii?Q?LfEEwQXJDIjv8AIitXbkiKbqlxk68wzL/gwTQdjo+l1VZyxgAOEg0JkfvkSC?=
 =?us-ascii?Q?yCsvzc5RdCcM0AevKrNNph2fF+uwqwtDpQWufYkxHXNRY+wGLcew96UfyRUt?=
 =?us-ascii?Q?MkdmNwiQfJfy+dRVphOj23jlukYcFO1Z9CPSSNi1MaqVUhwy4E4nzixMvbs9?=
 =?us-ascii?Q?AGHy5pSsAtMp4aBfBXadIfQEATjvn8qAESeG7MTH2F5P9CJKBXXUC8h6/ZSm?=
 =?us-ascii?Q?S8/wOZpZhAOqw4ujd/6qiEKMyyBCCmSqHM83TTtFgewL0vXzj7ZzW44WpWa4?=
 =?us-ascii?Q?2vdq/ihII0PSP3VFekKyPeSooXTOdjmwwtZEf4/UffhM4qSUhQAipyc619Dy?=
 =?us-ascii?Q?Ar2H9RkvxiHl+luF3V/Q9R/IDlg7mZa9G5cY0FFtJ2F+iWMAQpAVLlNogoxJ?=
 =?us-ascii?Q?Lzf9i7kTit8WD1HYpv8kQQ8g+jE/cgz3HQEkn7mK3rDX00E9pLsmyIJkRuLr?=
 =?us-ascii?Q?Y9FEhMuXZaEPGAqEYph33s7bj5ux/jTcj1/ZtrEb53iMRpq7zMmHaxBXyoRF?=
 =?us-ascii?Q?0i7j+Dmzjd/tO1M7GE0WQaAo63lfBJzra/ceZefB+dYNOLHUGQsYx6bkeiv6?=
 =?us-ascii?Q?7t9zZrWpaP1PakHWRIHyzWJ+ufCnJLcmDYalqS05Qz+DfbKkIbphxZt1i7xq?=
 =?us-ascii?Q?/Zs4tABItoangU1S3eUcBBGJtrTM9hTLnmdK1b5eU2tSxehl6nX8M/QEbE6j?=
 =?us-ascii?Q?RHRAnbOp8FRE+nyEVlsg1PM+l1iwumtRUkBjb1u0XOTW9x+JHwbLAHsXgnFc?=
 =?us-ascii?Q?HHqh8bGzstzvQkXzig/TioFb7t9UEA1JaPpWnBEHCDQKBxEI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30287001-1e02-4c59-1d3e-08df0d90c766
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:05:58.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XE2AGCac1pboT++BJVDj/jwUSkbIuDf8Kd92wVa/LXjvf2n9460odJITsQBFJNcb0NgV2T4pDEDm5Q8kYRZ7Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599

On Mon, Sep 07, 2026 at 09:57:53PM +0000, Kuniyuki Iwashima wrote:
> NDTPA_INTERVAL_PROBE_TIME_MS sets .type and .min but misses
> .validation_type, so no validation is applied:
> 
>   # ynl --family rt-neigh --do setneightbl \
>   --json '{"name": "arp_cache", "parms": {"interval-probe-time-ms": 0}}'
> 
>   # ynl --family rt-neigh --dump getneightbl --output-json | \
>   jq '.[] | select(.name == "arp_cache" and has("config"))
>           | .parms["interval-probe-time-ms"]'
>   0
> 
> Moreover, nla_get_msecs() uses msecs_to_jiffies(), and u64 is
> silently cast to u32, so a larger value can bypass the min check:
> 
>   e.g. 4294967296 == 0x100000000
> 
>   # ynl --family rt-neigh --do setneightbl \
>   --json '{"name": "arp_cache", "parms": {"interval-probe-time-ms": 4294967296}}'
> 
>   # ynl --family rt-neigh --dump getneightbl --output-json | \
>   jq '.[] | select(.name == "arp_cache" and has("config"))
>           | .parms["interval-probe-time-ms"]'
>   0
> 
> msecs_to_jiffies() returns MAX_JIFFY_OFFSET if the value is
> larger than INT_MAX.  Also, INT_MAX ms overflows int NEIGH_VAR()
> when HZ > 1000 (Alpha, MIPS), and passing a negative integer to
> queue_delayed_work(unsigned long delay) causes sign extension,
> which wraps around the expiry time to the past, resulting in it
> being handled as 0 delay in the timer wheel.
> 
> Let's use NLA_POLICY_FULL_RANGE() and limit the max to 1 day.

Please add a note that this controls the probe interval for "managed"
entries and therefore a max of 1 day is unlikely to break any
deployments.

> 
> The same max check is applied to sysctl as well.
> 
> Fixes: 211da42eaa45 ("net, neigh: introduce interval_probe_time_ms for periodic probe")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> Currently, the sysctl range check is not applied to
> interval_probe_time_ms, which needs this fix:
> https://lore.kernel.org/linux-fsdevel/20260905233819.1064529-2-kuniyu@google.com/
> 
> Cc: Yuwei Wang <wangyuweihx@gmail.com>
> ---
>  net/core/neighbour.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

The maximum value should be documented in Documentation/networking/ip-sysctl.rst

Also in Documentation/netlink/specs/rt-neigh.yaml:

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index 0f46ef313590..c8e55c98d564 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -341,6 +341,9 @@ attribute-sets:
       -
         name: interval-probe-time-ms
         type: u64
+        checks:
+          min: 1
+          max: 86400000
 
 operations:
   enum-model: directional
