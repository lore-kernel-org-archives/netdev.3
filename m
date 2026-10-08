Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5249B1E1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466439; cv=fail; b=LUa7/1fYaK90D+f62H6SKVwhLE13ksMCdfZ33abxmh+vKr+NV64ryXCynMkcyRGQUNgiLQ495isjuj47US0pc1pKRKxn5xU1gR9kdd8gE/GhrmuO5DB+3nzHcRrhTAYHEO6e/CPK3VNNl958gGGmglAX10TP018stp908ckgv0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466439; c=relaxed/simple;
	bh=41v4S6uGg9as/qubn4wKHX9XPf9uNrCHoYj4HiofT4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PyQ9dKbiVS05JDb8P9f84ASTvK2YRFr8MxcdjI0hf20E09DXpK0NoZCbCaVcpddh51sl1EJihDWUMO8lL3dhEhQ7cUSat1NBZPcdK47618SwmSiICu85hXFXy+XlTxdUJBdR+UjXWSpp/a79DtgT7Z7erciC6hRX6pmlDi8Tomo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MNse3T/9; arc=fail smtp.client-ip=52.101.85.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MNse3T/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uneltb+o04uXicviE4GmYYHiyIcdpSju6RWi82PnDzCT+VedqoHC8y+bZqc/4YC3bSs7IaRpC3t93rEL9QOwXftt5C2QUYFL12UJCW9pnbAJya+CnZKbUTgX7tWvyhI47204czFfe+2KtDqm+NtCbA7a34Vv1PWMS797vE+VgM4NLtnQxgH2ww1ZYAvdZHTX5zJvoyKLNhkeTO0b9HeAWHaiiI1n+2yP4H9WSHGr47BFHkBdCVlJ3XvFJqSa2r/r5BrYxWmuPlEmr98DmEgPj6cekr0lqR1MitGtPAcb0R879gBIJJUbMsUSB7Jp2zQbW+YINbui2WhorOm7X1vnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Joz7RNQmGAQ6qWojBdbw5EpXciYZYqYcfnD/1GCylx4=;
 b=jaO9ec61T8m1GcoGPTxE1f8KI/9VQbE4lJ0jJUYBwuMTU8bsu/cn7a5CxpR+wHThNCGVdaQDJiZpzTcsc7XKZVadvWJevp9RY6082XTms4tlAyyVEkvBtna4yiy/w8pOc5ML6eYapT9FXfxWv5XqdzBEsftdV8pNhpk0UnPpbuUanJffFedLI34NHN/ISivgsjKeMzx2ElSMFviTagfPz/1qEMn862DVQg7oNaukqFFXB1Wqj4hSRcqYlWQ+pDyz0PpTj0MuWF/gm4i2kYEdbzZENjKCqDuWiYicJc1HJCBJ7CTrO5D0porfTRDceCSI8TPci76c1KlEiA9VIASgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Joz7RNQmGAQ6qWojBdbw5EpXciYZYqYcfnD/1GCylx4=;
 b=MNse3T/93voCw3HUUrOo4hy5lHLHW8+yi9wnCSzB8JYFwV1FEhb71/7AuzOPGBB7Nfj2b7p55DZEN9uam7Req/2SAx/2KeTNQ5mPDIUNCVCw04m8WqhZS/LNjQrWopvN0oIcJXSWIUzOWd0x93EQykBI1WvOJsuWGqyfzrPOhrw5uDRkYh8zE7vNEIQkpF6bZuPB6u/KUWTaCzYmMOZTOv6VKtEl/0LjsCKd3vPcgKVtuUVXfEIXtkrMFv5EENscfSgU8tk0OxK34ic8kmDxEJ7yS7zlFlGZ2QruAbQxSn2pED3SL1Rbgogo1wszasy6bmAce3ItBMnb4YnyVGLd1w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 13:33:53 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 13:33:53 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	daniel@iogearbox.net,
	petrm@nvidia.com,
	ferenc@fejes.dev,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 0/3] Report netns cookie in FIB lookup tracepoints
Date: Thu,  8 Oct 2026 16:31:55 +0300
Message-ID: <20261008133158.1438907-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: af587ba9-4243-4c01-0159-08df2540cb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	kU+UbJG1VWy2iLuNW1AKh158ovF472xCVE3UZCotlARSvvDC60xt+HnlFUO+F/cTVjg6Q4RCC/3mgLIAQHVkTiQs6/VbXXE6gfDlLqp7r6CsdF93YZnha35aqaKwy46MkAq2cG621kfkDkzyHOxSOoBv5iLDxP10hUGLCxdgLKVLhrIZ3VGH+oYnz52YWPwVRfdUpKiJUtlMebbVftLlLiEiwk1mOWOUyVu6yA4QMqtCq08BODCsY4hZerpxGa0qhSm1pExGb/P7XmRSHDg9z5hRteBai92aZtxf+tTRPJfR8w0LJoAjnfCC7FKyUPm+nLSHh+/DFmEYqYODm0Qn/n4u9n/fN/sv9iF+vCAe4Qq9Dsva+/5ZKNqKycdwxYKkIlVFXg3PY4l7o6Gy0mDYccRyIK/vlQNeTZBNbYoStDO0v6c2QP/FD7vHuuZ+R8PBCDhV4uSIEEttCNu5lMTelF5FYA8guHwmI/X03Iczv8VOyLmVgpNwJXBYQKFlxgE9rltXeCXaA9ugccJLnqZ/1vjIALNVcL47pl8hp2yp6nVYf1HHqzjLfhGIFzsUWFyPH7h1hjKsFquwdRzTrFjSHatZvCG2NBePBp6cQa5a0IiTGBFRsSXScA2yY6SPKXNvr7NfhJk4GckQxfR591tIpTGEgYyKAN/qKqhh8z9BRRc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g2Q21jWFBCMIZvDOaJoPStkCbsQZ4qXP9aqjCWS5hh6nQ24znvnegBaKW91a?=
 =?us-ascii?Q?1khD0sTvQny3OaENlqFv193kRYvFceNucCABd55cXwJXJdzup/2KLqerSglV?=
 =?us-ascii?Q?wYlAOtD4PU/3anSLwMw80J9lZfBq+I0YIeqsvCLifyLJ5wDOvRgLFVwHukTj?=
 =?us-ascii?Q?LRLrIwdU4rAwVoI5e7TZkVqw0v0HjL2WtzRUXBV10E46b9YdCR3UXVZ+oRso?=
 =?us-ascii?Q?uTqzfAAEbRP3J8CYnoxFeg+panIJeRpyJg6v3Sp+ZeYoRP2CQZastAFekkZh?=
 =?us-ascii?Q?kPihGZemt4iFkcKxVexJrSHXJtglq2dwclBSMfi6WfdyPUF/BPE7Wol0RDut?=
 =?us-ascii?Q?NlvXqpHi24+n3cujD7GFP+eueUxUDZY7Iz6Uzue8U8OHCG4sqQu5AdVvrkx8?=
 =?us-ascii?Q?WmzgqXHReQEcr8f8xgOBIHAezsY8GuQEXtFKkZ7MK24GjcsqfANQJp8WOwrr?=
 =?us-ascii?Q?nGJGmvWoZvH6IvCSZVxuUbQ6ptFUTvWT7xdyMqJ1ivy76AAmLFJuW/6qGKhC?=
 =?us-ascii?Q?jIfCUTiRdVzHrGOd5+QK16z//ZB/0aF+jCDbvmxnLLUbzd25rBkgTokaBKL6?=
 =?us-ascii?Q?A6wZPFZhcoltJ2p+qQYSH47RCk2GOmwmob78/gV/nPTgGIWES4kikyInnqoh?=
 =?us-ascii?Q?fV/K/MEk4nKJMGtmSoIDm9lLKkddMGbeHxsMQCCYeQ00g6aRxu9pFXj9u5uR?=
 =?us-ascii?Q?YJO4+Il2eIugNya8MZUmitF3iKS7KI4+Ao76vN4+BTOQg0hwN9TZIVCCmE0w?=
 =?us-ascii?Q?It1AE0V/vGq0uGcMgDF9kvxNUI+z8OLFY1vRhTEy7j3ovY0PI3Ee1Pb2N36g?=
 =?us-ascii?Q?/vQ4UIZWEAep00brCAFTtKvXD0mfkpFsymB4U3CzHWsqUMORWT+FHUMmPZ9w?=
 =?us-ascii?Q?U+Nah2RlpDNAUIW6Ya8UB+X+TPSIuPVGerPrvz3bXLGQqyk30vGgfiqt6eFf?=
 =?us-ascii?Q?fVkAWb0UQICAsRJM2UIKvaiz9Tw4sfBjvFoy3VwQQ/AbNdPJZt/dsihcmRJU?=
 =?us-ascii?Q?mOZjamP6SSitBSF0t5L6qPAUWCcJUdZgKYtR8SiZv+UtQDggA/OglFMhegpX?=
 =?us-ascii?Q?isnLnGNE/ZDsBX7DXYU1ebpxTdGD/te3FfbDI/ogE0HzAigYEm2aGgKNjcMg?=
 =?us-ascii?Q?1tlF5ceHkC2K07g5/F8Tho/wEXDIELIQmaW2Es6YOaaezF/oRzNRmso3vh53?=
 =?us-ascii?Q?Eid6LMJUg3T4a8xfMy0wlNSTrCUhuBCOM27V92ODhCjkgQ1z08xtLj0qoMhN?=
 =?us-ascii?Q?epMThQxl2cQ28OPXAbohA6gxXDsOFi4q/rJA6NIQJS6PhrCZsK1xCmUgb6kQ?=
 =?us-ascii?Q?ycH9J5cvbd/r3xhg6ad0KO0M1Mtdrv2TLGIQyUJDGHXQjf0VFpcE4Hyv6emC?=
 =?us-ascii?Q?MrBUtu4mvaCyNV3mBc4xVppT9rSzqHv++Ry8JC+B42i/sMOZlwAMNsP8i0G1?=
 =?us-ascii?Q?A06TKHqX19ijTjQLTo70ayxiL3S9Q4vIUrEDJJ7c+f88tmJoBulj76ohqBKE?=
 =?us-ascii?Q?4VbGi5QHLRTjYCulHhsEnH4dKGNflZk617/Dnaw0NgugNRoLvJnFJ6D058Fn?=
 =?us-ascii?Q?pydK3AG0/5/9gWV9a+2jG1aU1vk9MtfowExw/jeF3T9ckAdIplWVruYnaAcB?=
 =?us-ascii?Q?bgIXO5w5CibzeNpnWNguPeLUqrNFooz5VWr3UNvDGjEXEiJvnwIRh/uhYwxF?=
 =?us-ascii?Q?zPJUQEwX4hKkzHrsIqSTxj/I+wJc6qh2G4z7dNePm6SSfj+r9CNbJ6pCw02F?=
 =?us-ascii?Q?3TY0aYmsyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af587ba9-4243-4c01-0159-08df2540cb77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:33:53.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPLZ71bBUC7lZEb7PwIjFy7Gm7OnkxB61V6U/IfNKyBSjfLi/2xns7cLd1PLALNBlnJeXbMqmYYPDF8irjjwBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070

The fib:fib_table_lookup and fib6:fib6_table_lookup tracepoints do not
report the network namespace in which the lookup was performed, so
lookups performed in different namespaces cannot be told apart. The
recorded PID does not help either, as lookups in the receive path are
performed in softIRQ context.

This is a problem, for example, for netns-aware tracers [1] and
multi-ASIC systems where each ASIC and its ports reside in a separate
network namespace.

This patchset reports the network namespace cookie in both tracepoints,
as commit 27cb3de7f43a ("net: add net cookie for net device trace
events") did for the net device tracepoints. This allows filtering
lookups performed in a specific network namespace, for example:

 # perf record -a -e fib:fib_table_lookup --filter 'net_cookie == 12'

The cookie of a given network namespace can be retrieved using "ip netns
cookie" [2].

Patch #1 reports the cookie in the IPv6 tracepoint, which is already
passed the network namespace.

Patch #2 passes the network namespace to fib_table_lookup() and from
there to the IPv4 tracepoint.

Patch #3 reports the cookie in the IPv4 tracepoint.

v2:
* Patch #2: Make the network namespace the last argument of the
  fib:fib_table_lookup tracepoint. I kept the tags since the change is
  minimal.

v1:
https://lore.kernel.org/netdev/20261006155454.853588-1-idosch@nvidia.com/

[1] https://lore.kernel.org/netdev/c28ded3224734ca62187ed9a41f7ab39ceecb610.camel@fejes.dev/
[2] https://lore.kernel.org/netdev/20260923161756.2914560-1-idosch@nvidia.com/

Ido Schimmel (3):
  ipv6: Report netns cookie in fib6_table_lookup tracepoint
  ipv4: Pass netns to fib_table_lookup()
  ipv4: Report netns cookie in fib_table_lookup tracepoint

 include/net/ip_fib.h        | 12 +++++++-----
 include/trace/events/fib.h  | 13 +++++++++----
 include/trace/events/fib6.h |  8 ++++++--
 net/core/filter.c           |  2 +-
 net/ipv4/devinet.c          |  3 ++-
 net/ipv4/fib_frontend.c     |  6 ++++--
 net/ipv4/fib_rules.c        |  2 +-
 net/ipv4/fib_semantics.c    |  2 +-
 net/ipv4/fib_trie.c         | 14 ++++++++------
 9 files changed, 39 insertions(+), 23 deletions(-)

-- 
2.55.0

