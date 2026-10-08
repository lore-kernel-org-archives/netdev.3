Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FFD3E5EC4;
	Thu,  8 Oct 2026 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444626; cv=fail; b=uOU+SX71zMUb2r+tOMVIP7u0v2PI6f44oOXT0kcNmd1d3LOe8Dfn1HBRMNbkutytie2hLVvWblHdb8ZEkfsdflMmtpdxT3am2kxWUtKSJBE1eHTbVDWaC+w/YE+6t8oqiYe0ChIae5QjQKMMW3sIrdcAd1zoRKUuNM1IOwTeDvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444626; c=relaxed/simple;
	bh=XXry5lHsm+CXSNMVFN70Mwj+KaF9Zjl+5nWg2t8P9cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lKWSsQzyEik4+J1hiDBvZqKomPY87aA6SaZlJCNfBrsrBu21pSHyhMsTIhBQa5vjUWQfIsa2uXSQartx1vYOPl7nSg7jC8QhuQs2wqsLlPuyvPvEU6p2JoM3CQlsFUntuDtpZHeXGGkALj3AdoT9x7ttzYv+bat6SXquVwjlyTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VS8RRbYZ; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VS8RRbYZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqPLSvuh63OgF/SyCAoTRYOzZLyNQB0SxS96LmzRHzNrYR5jjYZFrWHUNWli8o7XdJYTbNkn1BDJJTUi2hneVL3O7I0gHhCFklkWdHp1rKl2paOfpoI7xcgWoGY2Wj84kaV3zH3o6wPcRjR4wEkYqDZy2dbSQ0puD3zXLGi5Yzybem70TFmUFzQ4lt5aGv4z9qbV0NModtBFnSx7AAL3+UbZXkUgfTKAnGW5U9mqBhWbdaLd/b9Ls8mxQth1sArUGhzJDDR5cvt/ycgovYHz6LmW6VvGcML1O6lMjkveNJIXDFTfve18eW+f39n9eV93c3XtSkTYbRjHRdWiy/woeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDOX603uh41Qv0PSBJK2T+fggprebYy4CpsqqWXBE8E=;
 b=mUQ+gXRVI6ELOj1MxXr3agz5Rv0779DbE5JOdJcW3W1Jbh9iTEQbgF75kmHKU+kkgar9CCBv264uYyTKVZDuFSDCLyDfx2CSMxmG4s9jbQqUfTinhEyA8chUu+EhJogab4Ruqc3iO/fpj4TDwXjhzKbYevRDpCapv5/pQym0Gx5Jv1siV3Ifb4vg5EfSzzEkYlAQZ9BSUIIEG7puVhdboQbtCysiavbdBnUIOWTL3DuGzWDya9dgwkMPoyaZKa3fCkTKwwin3EM1gaFWoOSYI6WaEegNgKMEIUANrwsM9I5Lb/fEmK3hqFLFyB1nYo+Q8MrYPWTYfUst2SvHJZB7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDOX603uh41Qv0PSBJK2T+fggprebYy4CpsqqWXBE8E=;
 b=VS8RRbYZ7PQgOO2tFuE9kdiM7bFjtPzpqxXWGRP9b6A5nAVAzea2R5mL8DLpVPWA/eLYCAUAiFDTwQddDwJCx/0/ZEjdJtgxWhrnmbcEg1XMv/0c5fmwHsVPPgczyzHRAWHlsejPaVD65d4lVtoApnq7eWa+gXeo9t6oDByd4RHi3XwUpqptN9cZi5AOSY+0luBLJVej4K0JbLiPaM0hKBvoPGVfv0DS5GIm6mUUHWybKgWLz9hwduKOzYGD31XPwr+PUEllC/Lxzry/Li9lef0Wj5RPBir1GiX8JJsGpo6xDqa4l/Zmnk8wEHrQ4Dcef2WzYQ/NIuFZ/ffU5Lqzww==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 07:30:11 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 07:30:11 +0000
Date: Thu, 8 Oct 2026 10:30:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jiri@resnulli.us, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	jjzuming@gmail.com
Subject: Re: [PATCH] ipv4: Serialize netconf GET requests with RTNL
Message-ID: <20261008073001.GA1257678@shredder>
References: <pm-ip-core-objects-candidate-0002-v3-4af089192b0b62b40b9c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pm-ip-core-objects-candidate-0002-v3-4af089192b0b62b40b9c@gmail.com>
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc6f535-5611-4037-e960-08df250dfc95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|22082099003|18002099003|5023799004|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Q69sT5FykGQn1b9syO85RtjwBjcfaIkgTTiq/zZDzZPsTDdrLOBZqIFkxAJL+SRAD40uwWU9am3eQE3GoIdABxoKRtG/K/MPmjm0MTkXVh5j5N/hsGXCK6vETKpM0NxaKFG60aNQmGGkL4iPeO8lHIl3eWsDj0pb0ElqmPK9GT387/eCG9un2l8xbT6YIL7bK3kzQqzijSfP1dAo/NKUcboaWw3Bq5jlfqjoiUgwoqEwCTT4jNnqPCyaYil3oOZNt3ZTUy7uMxmN3898mf1NFQij/qWSvByi9AqRA8n/7qQ46WImhL2HtGvlt2btproUGhwjVyXbkPkRSfgMksJ8qP3VXi6ooiZ0FScjIN9F3FJ/gm0pz6g29MlEgYGFPCUWdHZPei+Li7+PFEsoOJHO0L6S2vVTQB4o58h24W/mSzCvscn0OD8otdHOdScH5wRN1lDL2Lj15KY7/7Dzvwo5NiBQbUYoOjtptm8YjDc8n/1DbGZK/txZOFgHEUspO55NTPinRMIu2Z+dXX74MGFILyGvGitBuF55xGm+XTDfzuRYlaRhxWjKucBCKBqj+7Ik2J2z3+iMJNieW/r1qleoiEV9oKUMJlWk4KUq18n5LvKokjcISpnkzmJUtlESsfBwuB+JzlT0lsYMAQ1C/OJJwTZJ36OmhFEjtNdL8lx5IjQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(5023799004)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlZkVTI1enZySTV6UGJhYmc5YkpWbEdUUUxsT0hnVVVINEJtMXdFMzZ5SnVJ?=
 =?utf-8?B?aDZreEpFdDZ1bGkweEtqZjNGdGp3NGVRaFl0N255NFo2RFEwNnc3dXM4M0U0?=
 =?utf-8?B?YWpnTGxSeFlkNmdrYjV0azBLUklhS0c5VXNxRE11UmFIdGwyWTBGb2Y1aUNx?=
 =?utf-8?B?d3pPeXV6MTQzYm9kb2p0VnNlakg3Vk1HaS9hWjhPbzZpZDhFZnhGMFVRSWFQ?=
 =?utf-8?B?ZXZxZVVoL1JSMUZqT2ZjOU5mTEVDYzFPZ1Z0NFhSOXFpQm1HbmUzaVRDbEFM?=
 =?utf-8?B?WDhpNCtiSDlZbzBTWE41QXYrQVJxbUNlNUdweUlVNkZTZVp3aGk2ZTdMc2dv?=
 =?utf-8?B?aGhHaUhsZzdBRklKZ01FYlRNQUJJbDhKZWl0YVAwaWhhNFBiOGhQR0hXQjdO?=
 =?utf-8?B?dElQMlJQZUxCRWJ6d25MdDQrbWJhRDV0a2xCK2YxTDRJVmJMcmpBTUpWaUJx?=
 =?utf-8?B?eTJKVHprb05nL0ZmZk1QRlNZRVViOUE3aTFKdVlHRVNpa21oVDJFQXJaWk03?=
 =?utf-8?B?SWhzQjYvR1RYWElNV0JHaHpBZWd5d1kycGc4VWFtLzdyYy9VQ29qcGdmNFlm?=
 =?utf-8?B?YSthdUxhWTBlY2t5Y1FDdC9KVEFUNzR1ZkVic2FBaDVvSEZqZ2xVL2dSOGJG?=
 =?utf-8?B?QzN0T2orVDZhdUJSb1llb2ZYbmEzQ1dzQVZFeW5wcTlabm1jR3NaN0o4bGZW?=
 =?utf-8?B?RngxQk9aQlk1V2ViOFJoV3VFYkVTemthbVdURGpqK0IwTCthTXlTUEFNQloy?=
 =?utf-8?B?SW13RGNKK29IR01qbHg4eUdlOVQ3SnNLYzJlcWJTazFRMktod0xKdzF5dEti?=
 =?utf-8?B?T3VwZis4aWtzeHVsSGhjbXVnV05sbnpVa3B2TXM3dEpvM2tBMldzS0dZTzlK?=
 =?utf-8?B?Skw1V25nY1BLQzRHNVFMRXdhMTFwcmNHNjkxYnYraUthSEpCTVZxZ1RicUFI?=
 =?utf-8?B?RjJMUWw1WXZrdzh6c3dNbGJ2V3dCdkcyUTErWkZHeUxQUkRaUkR5RE1ld0Fu?=
 =?utf-8?B?OTRhVkRJSTVpSk9QQnVYTkVlTm0reTltdHZxbDFTWUR2cXRBNlNxaGZFVm0y?=
 =?utf-8?B?VTBkeVB0Yi9ORlU1SjJTb1BoRUR5d2dtT0lxWGlia3ZHL1YrUi9LL2hiNmZQ?=
 =?utf-8?B?YnpiaVZBQUtReWJNSzlFWmhrVTR1ZGVwS0psMUJnNE5NMmgyRkhJaHl3bjZP?=
 =?utf-8?B?WW90UWswd2JxOVFHN1VSMEtobWlSQlVJQ3ppVFNUMVpOVnY2bmdxRWdtU3B5?=
 =?utf-8?B?Tll6dVVoaUhZR1Y0SUR0emljOGNUNDEvRXU3a0Z2eklVeUhMK0RTTEZOWlNY?=
 =?utf-8?B?WVZYcWVaZm4zZVRoZzIyT0ZRS0JmSVZyV01MNmxFMkkwa3phYnRGMUJwcjlv?=
 =?utf-8?B?ckExOEVnQ3M0d0tMNGFTSkIwZHZ6cWttZEVyQzZWYzhqNXBnVkErQThSaWk2?=
 =?utf-8?B?TWs3bHdqVFhoME9FckVJbVB6SExJZ3lSc0JTVXhqQTFkeFltSnhsWXdWRmVB?=
 =?utf-8?B?b2xsUkdNZkN3NlgvUVVOeFJxV3FuMTJCZ1pOTUZ2M01iQVFsQ2h4TEJ2TWR6?=
 =?utf-8?B?VVVaMXNUNkxZYVBwRkNUblN0MHlZTUFWN2tBWmlnYW1BRWpPVnRiUDBYVDdm?=
 =?utf-8?B?MFl2dmlmME10OXpUTFRaZTlEaDUwZGZxL2dVajVIazlSa0pQTkF0ZEkzd3po?=
 =?utf-8?B?VmpmQlM2SElYQXN5VkJoYTRMVFNzRWlmWXRBdE44OU1kMEpmVmNPbk1uNTJn?=
 =?utf-8?B?Z0F4Mm9OTVZZOCsvdnVRVmVHL0tnUElGYUhxeFh0SEI0bGlUR2I0bERaa0ZN?=
 =?utf-8?B?NzhsSFo4WjhIelArYWdKZzg1NGlYOVN0T1ZyVTFBakZoL1ZNZlpLY2VpMVhU?=
 =?utf-8?B?czJUSWJIcmw4bWlwbndqeEpKOXZGTEVkRlRjdE5PZE93Z29abjdJQjBHRFRu?=
 =?utf-8?B?U1RFSHFVREpmVy9RZjFGaWJiM0Q2N21vYXdKMHErMldXaEwyQW51Smx0TDBu?=
 =?utf-8?B?N3ZCeWRSWWhFRFJ1R01RYVJ2bkJCTkdKUHVRSXZWbnJLSmw0RFZGTDg2ZnMw?=
 =?utf-8?B?WlhEM0xxWnJTMHI5Wll4VUtIVEdyVkdGVU1xUFlpKzM5aDZyTUhGSkE0d0R1?=
 =?utf-8?B?bjEwV3Eyd1FtSXZhZkppSjJtMElJK0lTRmtlMlFSRXBTSkdIQndjM0c2bHBC?=
 =?utf-8?B?Q3pxbFlhMXRGZmpXNUt1WEtQMVI2ZUNLbFd3NHpZMWdYS1oza0srUnhCRmVR?=
 =?utf-8?B?SGpMOTNIOTV2My9adGZPL2VmNDBrSHNLNXRYMUxPS216dVA0RTFBcXFOYi9j?=
 =?utf-8?B?R1FybXZDeC9wMklvU3VyeUJwelVVbXQ1NWw4Q01peXpSbnA3VlNyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc6f535-5611-4037-e960-08df250dfc95
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 07:30:11.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6ZF5anK/33wcflRsnYsiQH8VZZ4nXTdkvvkQSMKmXCzeLOqpC9w4eoWpw9MnFlwhZnEvlrjrefaDZZGWxErWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876

On Thu, Oct 08, 2026 at 02:32:18PM +0800, Cen Zhang wrote:
> An in_device returned by in_dev_get() must stay alive until
> inet_netconf_get_devconf() finishes reading its cnf. However, the helper
> samples dev->ip_ptr under RCU and unconditionally increments refcnt,
> then returns the pointer outside RCU without checking whether the count
> was already zero. The net_device reference held by the request does not
> retain the separately allocated in_device.
> 
> A down interface without IPv4 addresses or multicast owners can have
> only the ip_ptr publication reference. Lowering its MTU below
> IPV4_MIN_MTU invokes inetdev_destroy() through the RTNL-held
> NETDEV_CHANGEMTU notifier. RTM_GETNETCONF runs without RTNL, allowing
> the final put to follow its pointer sample but precede its increment:
> 
>   RTM_GETNETCONF                   MTU change (RTNL held)
>   in_dev_get():
>     rcu_read_lock()
>     sample dev->ip_ptr
>                                   inetdev_destroy():
>                                     clear dev->ip_ptr
>                                     in_dev_put(): refcnt -> 0
>                                     call_rcu(in_dev_free_rcu)
>     refcount_inc() from zero
>     rcu_read_unlock()
>                                   in_dev_free_rcu(): kfree()
>   inet_netconf_fill_devconf():
>     read in_dev->cnf
> 
> The zero-count increment warns and saturates the refcount, but cannot
> cancel the queued free. Once the request leaves RCU, the callback can
> free the attachment before the configuration read, causing a
> use-after-free. Restoring a valid MTU can publish a new attachment on
> the same device while the request still holds the old pointer.
> 
> Drop RTNL_FLAG_DOIT_UNLOCKED so rtnetlink holds RTNL from lookup through
> reply construction and reference release. This serializes the request
> with inetdev_destroy(), preventing the publication reference from being
> dropped during acquisition or use. The dump handler already holds RCU
> through its configuration reads and keeps RTNL_FLAG_DUMP_UNLOCKED.
> 
> KASAN report as below:

[...]

> 
> Fixes: bbcf91053bb6 ("inet: do not use RTNL in inet_netconf_get_devconf()")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

The correct fix is to use refcount_inc_not_zero() in in_dev_get(), in a
similar fashion to commit 0e243671bc7b ("ipv6: prevent in6_dev_get()
from resurrecting inet6_dev"). Please base your v2 on the following
submission and the feedback I provided:

https://lore.kernel.org/netdev/20260815172032.79740-1-baul.lee@xbow.com/

And please read:

https://docs.kernel.org/next/process/maintainer-netdev.html

Notably:

1. "designate your patch to a tree - [PATCH net] or [PATCH net-next]"
2. "don’t repost your patches within one 24h period"

Also, trim the traces (preferably decoded) to what is actually useful:

https://docs.kernel.org/next/process/submitting-patches.html#backtraces-in-commit-messages
