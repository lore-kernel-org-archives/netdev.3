Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08933F9F22
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467314; cv=fail; b=kmLU98nMk1tBwwZJin60grVWZkbw5L5Y3ZCEPIYbWhN5W4Cb16KZpMZZePkyDONUNpYtP43N2wquq2cSX/VBz3hMXyNpOFYq7UfSUJuXJm/nZJ0ldaNbf+eV/21e2NVvZe95x6XR6YHd/wdZWvYg2tQ7gIdqQ6Xm5wzHFsZz3OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467314; c=relaxed/simple;
	bh=FRLv2Q07ZxK62x8TkZQTtCu1yqtIzG+PiCaTV6bTtKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ExSWoRr1myppAnb7AEpHdQnLgrusKFA2zeGsuw4e/kKNJC8j+WQ3kFT4/aUy35hfm7l4lNNih5OiEjam7CfjzwFFX6HlHe+6O76ZPWlABbt5HeUGfJgqMY4RVtICCPcDUrKqrWpKHGrdSv4ztIwQuAunOXQbrQgza3WHMK8CXWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JKrTU1iN; arc=fail smtp.client-ip=52.101.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JKrTU1iN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKleAqG488bQ5v1WfHhnCReLkZjopbHZVR6XEpocSUTBQHNMyJE12PuS6ZhWsPMm7Z/yUoo4MouhWm1e40ewKo8FL/kUdWqzt+DIfXeJ2rIfPA5c1zM9L/v5XiGe8sP6Iis/4bUlOvH5NHVYOCYyf/tJsE62DnL3yXlVMJcoWVz3ssXuE5rp+mHVdcZo8VE2iqxXsnvhPvuP6YclympHoNibnJiZxjFbdnDjNmEHmAjsdVTuegh9z51rBoLWrN0oRdpS+IcJyyF3MS2iYgd4k8sk6dypbByacnWUCG0ijwkH+Jccm7KU8GpJPjYT0zSyY3d9VBA/sXDL9QDR0b3nGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSOnr4GVOtsXKWPjma/8vtZyow1suJ/4VZZbaGeBieA=;
 b=olcrYwpvM6clJ4MQqLoGNUMGkWkrkIp2z0zkn0DCETk1HPZmwOpP4jHpT8TubozPD5XmJuBXQMn87C3iUJjRJjRJCSXmPq/Yyuo/KuMayY3SnMMWWT4J+edBUpNlL1XsV1623SwwclqzaN9szWislTxaAWeH9J5940j4anIhDdjOlwk+s+JW2S3zrmjH5Yfx+KbNIDMIo2WWan8ZRyCxqyQnYkrj4kOQ1/8HjU0DM9q1HyNxZobTOAV14r9hyyWguzM8sKCPV9sGQldhWHZBsYs9sySuQcLDfElppmDt7ufxELcQP7wtRy4Vw4E/mJhRAHAc+DuvUibGBB13oXQF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSOnr4GVOtsXKWPjma/8vtZyow1suJ/4VZZbaGeBieA=;
 b=JKrTU1iNoSDok3MZS5JNP+twnaxAh+24DMB5Gu2BWchYNjb/9pak1WXEAXuFA3c3tTAWneQCshWVAmq9JNHyEJDF+Qy0UybJSrTZZ+soF/aQkLag8kTrTBCZUT6ISM8KbkJXQCM3WDsabjEnQZhjenq9iX443O8L3n8iiD68p196SzjQ3jqbBttf/t8wH2jHR61oPpyFLK50hJGzyWXi9W/6Nm88MvxgOKXXa4mGn4eQZP7sX+Ge7sHbN7qNFRsIh4R4fTGsAeDxOMMeNocMzBzZZSnUKkMMGNyw5+gzaJAnxV8DXPlG4jaV6GxHFnoRPiafkuP4gPhogq5/rMfZQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 16:55:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 16:55:04 +0000
Date: Tue, 11 Aug 2026 19:54:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 00/15] neighbour: Namespacify arp_tbl and
 nd_tbl.
Message-ID: <20260811165453.GA3163487@shredder>
References: <20260811022448.116235-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811022448.116235-1-kuniyu@google.com>
X-ClientProxiedBy: FR3P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 60af67b7-f99c-4016-61b4-08def7c94a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Xmqps5HTvFo4GLlO1qMS4ls3svZo8MQVBQS03sOja9C0aEZi/UOQnQGWQk7Wcom3LANhcgJlWHt2JOicaw+yCJYTzfL7M5tRwloLGX/T/TWTTAgKkZjGWebcdRODmP1eRDAiyNS/F4k37pZOBCnfVSun9o0ldVA1xNBih4L7AOQmVQ9ZWl0wR3pchWgHBM6JIzrF5E32pNFadFtMDq/FixA/wgiyWaa72zAOPRkcWUlVQahmC3BsVOgLVQsr52wVB7jJX3x68KWerD/acz31qFBcnoTYQjAfoqoX2QRcz3K1P48Ef1+p+2ZH1EM+B6UN6OX/JngsT0NtaO0A3BiOUaFRff0fV7VoY8VBRgouIgyLurKm/iLAQrMTMFI4qdh1yxY4DJ9Ae1fjE/0JnDWbXWhjItMG5R4DgcpXPoQXhqIi91mm0iyfwucfe5bOxU9zOJDYfMDhBa0CAYm3JWXbbGCZCXHtbem0dK/8wj9jO4L93go14KFbrBR4SKw7YE1vvuzQCnEbNPNeOKKcnJQrUrg1cnCsus6UUzIIpi+1298NUVXuJQl1QDHs4MMNwL4EFSBue5omUppxRYimM/XMIhP55eG5zjXfhQ2yqahqNh2ccqlfYUkcF1rq0f7eWF2PCn+E7tSswu/DPxX1LBTJWOzE6cAV7EehWl03QoBtT18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mT41wgXV/MyIxVsJzgvvfCqbkLZ8t1Qu7ifC86B5thDy2MdPLS+eCr1OBg5j?=
 =?us-ascii?Q?uct/xvmyvEj7mR95JUJ3/rrKoo5GUePjIez5QhJ+vOlpLaM8YfaD1vc8fs7Y?=
 =?us-ascii?Q?6wIYkf2BDD8rE4lBiZ+a9Z5gickkT45cw6lOd6GMoqPkaYRtPrcwqkv4sAuu?=
 =?us-ascii?Q?EK4jdRAmMyHoScjQUVt0+B41Z0uGeL02nQ0QqhSjOnVT6RBMDxaSRkUdjuE9?=
 =?us-ascii?Q?mplBW8LOW/wn3kDBoGJ7+xTsNyNI/PgnHxKzT/2MQZv1pyCdJszOsOU3BJmg?=
 =?us-ascii?Q?t7LFeRJjyczHanom2foXNFTBpnP4euTtTvoMB9B7cMCKvyq400mL5n8tDTM4?=
 =?us-ascii?Q?QjCer4JZWiuHUO0KlMakXVXoeYQwtcbVEN0Y2nYn0TeJTB0XyEGhDkjMViB6?=
 =?us-ascii?Q?hnF9E04VAYyhRLULpJUu18AN6o/fw7Tosnk0aErO/VYBqgutUFNtyOcrjNNZ?=
 =?us-ascii?Q?u/ScXE4FqxGWQIuPpkmzLwRXGkAxuoZjt4MaufYcSArphf97QSR27ZYLTkO7?=
 =?us-ascii?Q?vajGKF0+s9xV57y5Gtqj2EI5ncmkqPjwwuMgKwfxlDiLdV7TSwWWC/j7Y8sq?=
 =?us-ascii?Q?WkgiO4TbqFWO/nywj6IF48rw1v2PlJ3e7yXRt+ujn2jcEQM1N9n7x9awAl/2?=
 =?us-ascii?Q?PRmBqTIJCcuOIoNyovuWthvNf3GwGttWCo+k1Jm49D4veBAA4X5PbMvhCTEe?=
 =?us-ascii?Q?ZnOyLcpsgPPyr9S2Zncj6+wwXeYynBhLb8X4M+a03kFPX9VbvqkvaxZAOsM+?=
 =?us-ascii?Q?iZGNtSGLcJHc1ADsg6okh1/nMGmrBiCJxkdVcYzLcgXaPVxzC9ori0x7NBe8?=
 =?us-ascii?Q?urNLneGHxGNnnDrs7f2LK990x2FMOdx892HaBuwnglCw50bml3cEWAWQQVbP?=
 =?us-ascii?Q?gmB6c+no8AIkMrLkbSnXQQDLobyqJUxN73e/XVNukrB/YnclsL5EUlgh/7bR?=
 =?us-ascii?Q?D5PuK02CgeyOlW+UynDOkI+z1z2rdPhfbNHASjvWvb9VBzS5SjCHM8kEL+cK?=
 =?us-ascii?Q?7j/3jDao9Rlc/6aphzflh4+OzibAvmQfxX3LO+0tH1fomDU9dw4LymOaAQOv?=
 =?us-ascii?Q?HU0xspuUraQ3f9fa3UVbOHTZipVRqHvLGgG4sXeoB1dGCUEZ5il9ARctDkYy?=
 =?us-ascii?Q?nPn5XhqBKtjBLlvsip9QCV10fFshLqR578dHAWQOMHUqD5u/9KZOIeqwFi3k?=
 =?us-ascii?Q?IYgPYQtvTvP6NBHKQcrRGec/9WcRWwGja2SzOa/WwCTjRqENIV02fvQb6xGm?=
 =?us-ascii?Q?hR8JJYzAUrCa4fpV0h+56t+FGcuKCbyp8PISOAw3/BcKkZUAhGsrRlz/l671?=
 =?us-ascii?Q?DiPLaD+D5poGIqiBlyz7MMPjcCldOxVF8Wt4JYz4GOBYfNt73t60DnOEa9Ie?=
 =?us-ascii?Q?CLItH/VaGpqnUISgC/oyNp/EpM3ncN32QrEqZUbbC+TCsCMbCSTGj1GhqnJ0?=
 =?us-ascii?Q?+Fvkz/ppxNhCR8hOXmgK2BuBMpwyFckd3H64lU1YDG/qwFfnk7KRm3uibAP6?=
 =?us-ascii?Q?PO6sTYsomroNAXanytB4IC67lFlIiZZP0WClfo7pPCVg+zU7ImmJmZcaGoR+?=
 =?us-ascii?Q?X3+XnEwUbC6+qfEfJbIeCtpKYbpAHq1IDWG1iMaYE6XGouVdlx1BkpZepjhq?=
 =?us-ascii?Q?+Lvog2LSzvKbslhkfF36S4hJFsWzljr0vbOPOLhlUMU9ILOXyizsHy10wJ3q?=
 =?us-ascii?Q?XgfmaDOEvw7ps9neA+psoS1UJfWvCAuL5CnOQTZbRF/4DN+v5FcfzJNhz7Mx?=
 =?us-ascii?Q?8PA3Wlihfg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60af67b7-f99c-4016-61b4-08def7c94a5c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 16:55:04.3536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Be6urBqMBD57hc+AIadwPR5hxroXqp7HmrsmBxGRX3RVxtaWstVMy/2qanSL38Y33sLik8fGPBeFn37GAuJ39A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112

On Tue, Aug 11, 2026 at 02:23:34AM +0000, Kuniyuki Iwashima wrote:
> The neighbour subsystem is almost ready to drop RTNL.
> 
> However, the control paths are serialised by the global
> per-table lock.
> 
> This series converts arp_tbl and nd_tbl to per-netns table.
> 
> Patch 1 deflakes test_neigh.sh.
> 
> Patch 2 ~ 3 are misc cleanup.
> 
> Patch 4 ~ 7 store arp_tbl/nd_tbl to net->neigh_tables[] and
> remove the global neigh_tables[].
> 
> Patch 8 ~ 9 replace the direct access to arp_tbl/nd_tbl to
> net->neigh_tables[] using new helpers.
> 
> Patch 10 ~ 12 finally replace the global table with per-netns
> table.
> 
> Patch 13 ~ 14 clean up unnecessary net_eq().
> 
> Patch 15 updates test_neigh.sh.

The change is good, but the cover letter should explicitly state that
this patchset introduces a behavior change with a regression potential
(as evident by patch 15).

I'm aware of at least one deployment that will most likely regress
without some changes in user space before upgrading the kernel. In this
deployment, the host has several namespaces representing different
routers with hundreds/thousands neighbours in each namespace.
Currently, they set the GC thresholds in the initial namespace so that
they are high enough for all the namespaces combined. With this
patchset, the GC thresholds in the initial namespace will no longer
affect the other namespaces and the routers will fail because the
default thresholds (128/512/1024) are too low.

I can ask them to keep doing what they are doing, but also set the
per-namespace GC thresholds. It will fail on current kernels (harmless),
but work on future ones. Similarly for the base reachable time which
currently they set in the initial namespace to the maximum among all
namespaces.

Another thing worth a discussion is the policy regarding the initial
values in each namespace. With this patchset, new namespaces all get the
same default values instead of inheriting from the initial namespace:

# sysctl net.ipv4.neigh.default.gc_thresh1
net.ipv4.neigh.default.gc_thresh1 = 128
# sysctl -wq net.ipv4.neigh.default.gc_thresh1=129
# ip netns add ns1
# ip netns exec ns1 sysctl net.ipv4.neigh.default.gc_thresh1
net.ipv4.neigh.default.gc_thresh1 = 128

Assuming that today people configure the initial namespace before
creating namespaces, changing the policy to inherit from the initial
namespace will probably result in fewer regression reports. There is a
knob that controls this policy for other settings (see
devconf_inherit_init_net).
