Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38D3FE347
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961290; cv=fail; b=E2Zk4SGtVEWcQCyxkelMsu8/omelZrKusvXAhUKVgCAB65zLDszLEIm96lUUBQHs5miiTPJT9zFkWSvGTey11fPZ2OfhWqaoaBBuJzJ2zxvmnulE05Kl6hPn2ik9grx6a2HmoM+GhITs584DmGmiH4KxkC/uxYeQQrjyeLys2rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961290; c=relaxed/simple;
	bh=/TWa8shVgxSHQNpcNPwXr73nudbQKH58rO9ddtl/lTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fH7OLTh+T0bs4h9DmmMUCFKJBrDfsucxRIGDSROaGx3RTEqNIWWGru4PXF9LUhf2WF7UXEjz+Aj94w5j9WlBHS+9IVfa0hB30Lhj20ftpzTgbotJsbpFfF3AjblfwfuXKqA5ImthyFmqJGdg5dm5tebS3s1vcy0TkZQI8bCDHhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t8GpupJE; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t8GpupJE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVbSf+SJL8kKK3gAOuhjCDHqEmP+eRJMMNgD9hz/EovWMiZD2DgcAe2ow6harlAq80GjftWlTMzbhHZbKX4ujohYKY/RHKwuFkuk/zp9uuXydUpMaF9EeRU15Y8b2kpX/nCk93BNhWb5rR8dzLtWDCj45qtnILVPkgy22TDbTdWaq9QXVcZBf4A7durNeB5/il1oBy0scMyjzotQRVLq47zCeeeqRV08gL+k3opAzyYgIG1bd+3RlHEdc5jgXM9NW5NP/4ZHhUg+td2krHnuWJsLZqBjmUpyIaTSsQXwBbYZ5rU2EWmrn41d2Vd03W0MGEJZXZ4ZnKtx0CMokFEfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEYmY/VnQSa0j1a4h8hCllCulQ+QivcKSLIofXKTr4s=;
 b=m2iKsZYEWu7+kV53aD6fRQZ8FZ21G59i1Zsuw680keQ4+vzeWK/lHo3wqOf0H3K8BZG9zew47CJVRWILF6ZE4q0qn+vSLVP/GflScUlG7wtpT62/mBnNEK7fgXxBgMiFdichRJFCDONnGuZXbgJjULRab2JFQML4SSQ3GlOTDP94k61zCA4AoUvl3uHfbSOlymvMu4oprWYefk3zEKoXO3+g3mH8m2jaNmkfrNUC2yi2pBmksB1yRXZJqmDkw4MfO9Cj6i9O3Ma/AITx1MJlF1lcg5vTW0yj8UmnZhQcA6nBEDL+Qh4aHqllbKN/V/O8Th4MUlUe82sldUX5aYK1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEYmY/VnQSa0j1a4h8hCllCulQ+QivcKSLIofXKTr4s=;
 b=t8GpupJEA4v6dvjDfQ9LBUhx8ySY9oOivr/qagfgGyO/Y8ubtj9RdYZSaOajTxfIhwpK+2/Y2cNeLrsp5/1+ZG03zvvb0TeRIddVQXztYBXqw5gFYa9nH53BG1drDDdyGBtQCFhQOvAKK/Zbgwigyk8yvCJs6atuhq15yuBRlQBjIxTr5Esfh9NiWpZyEwF+Fz9ICNzzxuvAIO4VsZRh0kdRctLziSeBj8Lq9A3R1/WIez1TsBZ94raVbbfAhriTizJZlT5KbaNmDQ0lQ7Y8TI1klFnUCdgeRwvHkzP3sf9H6Bz2JfAH9lCq7AeU7VdWKlcNDXPOcjKcpw/FDwbacA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Wed, 14 Oct
 2026 07:01:25 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 07:01:25 +0000
Date: Wed, 14 Oct 2026 10:01:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 4/5] neighbour: Floor INTERVAL_PROBE_TIME_MS
 at 1000.
Message-ID: <20261014070116.GB1220477@shredder>
References: <20261013205816.1642597-1-kuniyu@google.com>
 <20261013205816.1642597-5-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013205816.1642597-5-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c30b4a-c61c-42fe-0628-08df29c0f683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|261009223027099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1rJs9zVya9kQGr6GsXbIBUuOGQsuHmjavSpQ96r5fr9qFbYP/tEnNsBNI8HDlSjTvuuOLmG+4/YF2ULIVhE/HBaRfhGLzdi6e4fdokQnmcCxghMVyahtkATncSJawlJJbp++w0n14SjttPaCN1+8+QB89up1QbLB/rQJyhLfoa+T05XS2rEqRdJceK5dzmc8yI5JBZRancRsJgbjQK6ljFlwGkOiEYKFI4rbVtdv4hlv5IzsWqhT5psPjhXLHz8TYvEF03NkNHLPNsrK/W9siRqjmJn+YRYiYp1Al7SrpEhWFg32h09T20SktF+AUoHPz3Ubb4MIqc3zI/jOFWz0l0VRtP548ckzj6yUgnN6+HLdrKigDllnSqMZ20TQvChFGyLaA2QFfufn8tf/Q6Qu8B8Yi9mHujRC3mJFDFX38Tx7Jy32KvjeZNxn9UqjIBX5l/xYM5u6v9p6HwymE2TIiR3bEBAYc363xfj8j6FtNKq+T6n/NdamCoY+PBnS5VcICAlDisbyA9LbMqadlpk6Wvy3prpzs0SICYHWuesJMiNYlcQ/mBW8R67C6vGow7ZmKxW/94WkXMnB6b7FQOPl5sz06Z3LNIKTFrt8IguvAyYREmfpxmp8C+ddbsJrBZqWDAIgMJUsK5OpQc30XEmIeUhatAlVV0W8eh4fwUJK3ks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(261009223027099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6LOvn16JY9FbQ/sYqjw6NY45C6nrmF0IhnjwUX5jd3KNgcdRd2eQgdH57Fqb?=
 =?us-ascii?Q?wZj87UMCJh1wSHPsVP2fsd1s8BBcuLlq3fM8XThJUDezqW6jNXDA9lQ0Xcdq?=
 =?us-ascii?Q?PY8ixcBAsK/a4GV53wOpvRxniwINb/gFKV/GDwMWeWDCD4UhBybvIiZ1bCc4?=
 =?us-ascii?Q?Bl2db2OLyGOmBuRDtGfdnOfIRWrupZYG1Xf5AEycG6Hazkpml+s+foU2k3By?=
 =?us-ascii?Q?hcsbPv6pFwQyl+e1Swe9xo7Ynk7HwwsTdnLMLxKc90G2UH7VOXjMi9tDvFfO?=
 =?us-ascii?Q?w2Mnb74P7MIfCXZrVAS8EEbIlIYRz4U74hsTQn4vYOBIR2itoFlV8oshcT72?=
 =?us-ascii?Q?oxmp1awoA0ZZ1GmiLKR1tIQ/qDprozW3GQwgvgiPX0G+v0IT1KpsQ6SrcFg5?=
 =?us-ascii?Q?WbzCI9O0xPYQ7Ae+vImjvSb9VnLY/b5OlwTdnwmEGep+xvckEYNuenUdm+xZ?=
 =?us-ascii?Q?M0Znx0pkYwJHQ0VjNX4F4PGfNewyMVLCtsh7wyDUq8AcAVzyZlq94O94Ffr5?=
 =?us-ascii?Q?MA9sojjIwonE7sktwT8/93EMV3faPdd4XUj1vQznn66LD+mIxaMy9FdynxGc?=
 =?us-ascii?Q?4Zo/65FL/ulflooyStk/dk9RYftRxyZAz364GhdAZ2rgfTJGYrI8zdklut9C?=
 =?us-ascii?Q?qxcHPasXCxHO7X8Cmvm0oa0+Ty0ctcZmYOpWkBLSSCf1aQqmYpT07I6FJ03T?=
 =?us-ascii?Q?c24APKsWuDhDPSyJYOIJdbXGZpv0PXEaIc5eQ82Z6+5ai9qOeOWDxxQNnZkR?=
 =?us-ascii?Q?Qyuiru6Kw0PffN8rkoYwMmJ9tnsqe4GKL3aQ0hvkaom1g4GCvcXeKw6ZzkWQ?=
 =?us-ascii?Q?+LdnG1ItjAp/eY/MibipFq0aXF/BEG0TOlJVXsA5UlhH5B3RxQdLUX9yYdJH?=
 =?us-ascii?Q?KgxAcLjMLVEKhKMig28Ero6KuEbx1mdD6eQlo4X6KaACzQcDM0zZunjO40/m?=
 =?us-ascii?Q?JY5V/jh1TWcFx2+FUugcrZDdjQcS2DiW+LkZEOHssPb9FSaNhkgG//JsN1ff?=
 =?us-ascii?Q?1zYRh6fwZweiv5Ui5PEPbSLJ8QzIOzSJvGBj95/SQOwe3Z3rhDAu/Iks8CyB?=
 =?us-ascii?Q?/SpY5GOj4lMnK5GT6f/Zcul0ooECGzewasrLLTxkDwEgOGnJ4+gimZD+3PfK?=
 =?us-ascii?Q?z8dGiTZhjOyi0H6EwVb5A8HiePdUtxiEwD5LZlXmJP8Toss1EaoRbDKglxrD?=
 =?us-ascii?Q?1auorqPCtBDdIg5AEvrOm5ZZ6i9QQFjYQihNN5WzeqUJTJcTCBAn9cwdT/Wd?=
 =?us-ascii?Q?fANrYGq5eYgpO1Q8NSx+qglT0y1x+N6lpj/mPqN9TCRfTiO+4/S8AvSxIugo?=
 =?us-ascii?Q?IU8fBp5BQoVUG91PdePMAXdkyk0QNn3ICynSlCpNo/x366HtB2c45eb6eTdR?=
 =?us-ascii?Q?Y3esjqW5/E/fEf5oQNzhWm+7VRRwSumBHciupLhOcRUAzGx8O4qStAOXMlVf?=
 =?us-ascii?Q?l4WsmGLMAQWVYdTluooe6mhswmvPOym+oomc+QQOH1CZnAf7ldNT2OWuZDGN?=
 =?us-ascii?Q?PN45Ft7pfPzu/KIISub8LCMzor9nuqSx6+zEvfpkVdxBKJ8RnvQSEo0T4iJe?=
 =?us-ascii?Q?l5Tn67QJRfwUJt9ovD7VQNUa4Ouu2VvzaKfoIpjakvdV87rJ6TP7SmraIciX?=
 =?us-ascii?Q?o73B1+Mf2tcW3TsHY524HsQ/sP8oMVhVjkUxOfQX9bXe1voxvf/13TKNDBHN?=
 =?us-ascii?Q?K+35cRpIAIzjAIys0klMBH3fpYoKQzbI/BiIUMdE4RkKQqos?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c30b4a-c61c-42fe-0628-08df29c0f683
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:01:25.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdYItArgv6gT9gamw54TK5+4hHUIanSETtUUw2UuFUsyL9MaJU6w8b4XvNu+4qf0Att8boHo9pUkpb7m43RUCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

On Tue, Oct 13, 2026 at 08:57:31PM +0000, Kuniyuki Iwashima wrote:
> Previously, neigh_managed_work() was not rescheduled within
> 1s since commit ed6cd6a17896 ("net, neigh: Set lower cap for
> neigh_managed_work rearming").
> 
> Later, commit 211da42eaa45 ("net, neigh: introduce
> interval_probe_time_ms for periodic probe") added
> INTERVAL_PROBE_TIME_MS and changed the limit to 1ms.
> 
> The limit actually did not work but was fixed with
> netlink_range_validation by commit 6d79b223ec44 ("neighbour:
> Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.").
> 
> neigh_table is now per-netns, and a user could hog CPU by setting
> INTERVAL_PROBE_TIME_MS to a small value.
> 
> Let's floor the value at 1 second.
> 
> This is a user-visible change, but given we had the 1s floor before
> and the default is 5s, it is unlikely that anyone but syzbot is
> setting it below 1s and affected by this change.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
