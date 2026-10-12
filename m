Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCEC2F7EE6
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792776; cv=fail; b=oEEkCRRrI5wXbI68rA58wi+KpUXXm4IaZCjrHGOxSvaEoefl6CPzcG7uCHUAQ0ZfbWjWMJdRC0hdhSyaXc1RnoxHyI13i2GcehBBGyc6jGQ+vd58l76HD+HZTHwi8+YirUkDd03/83/AP7j4eYNiOQHG6M5T9IVhXDVYtIEiTog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792776; c=relaxed/simple;
	bh=+2j41Wp7PNTzaXa5mxZeZCI3Je/an1uWXGwFVgrNpRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qk3OCG2GThhEJEDkoqDNg6fUnEUfHhLi/RqH5iPThzZUqhTV1xGboWBS5YSBC6P9RmG6P4w7ZQJmozypTjGRCikPn5+3mQj1PsQuEGmuBhRA9QG5//dwOWhj+bCxtOuQOZuzgxmZ2hMvxMMa6swA7JSjLIWEaCoNI4hZT3lkMu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O7qwQ/1A; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7qwQ/1A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO/EDXmvXLxcZDSre1lOOf9wOUTC1Ys5752jjFpkhwTxfK+JS3W2+Jq1tso3uVsStKTb4hydSqKJNN9EHyX9mZqyqmTUIVCSYFD8DFWQ81uv26ug0npw3rVeWOG1trPHaiupmGyKetaXMY6B+EOt5zC1V+87KY2F21jFqQ45yVI7JeLp0N0cianxghon511PKpJ8vQXBHfIBPvojkMcXrPPS+tbscDN3zEKSiVua1NxNXP9kPPBq1a2PTScuUZAe1YNip0VtwGByBRJ/Zo3xXebGdGWuH96f9lZ/arkycI3m9qs3uBfY7n6s9WeXPWBLHlTRbHL2kxSN2fnBmfgGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6zgqftog2buu1ydURosOgh3YRsRyhLT5wHYI8Zn7EU=;
 b=RwG00suDhkb20b/a0d8Y91v1JJmL4dUrdPwpUaxGJiJu2R6U830UPNZ0MWESNr5lA3PjyMWHdIPA5vchxIjpSSFUkfyxct/qJ+wI2cqkgLGSYeg7hj/ImQUjbk2r+cs/u7mBOllBE3bYf1bOsWfeCAsE1gzi809JZmSIgQeS95/jgLNCRmG0wxZ2c8uOfOzFwENurTXjA8xkrEQBJ4bYFkhbq+UPdftcPpuZcTxs/NGt/PO8gddRem771SsD3+b42Yb+BBvqg4IICVal40/Gfj4QRLV7/foQKz2RND09NqZZ4YVX3iM9p4n9dGVRFI5OxEfGmjOG8ww1BllqMNcv5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6zgqftog2buu1ydURosOgh3YRsRyhLT5wHYI8Zn7EU=;
 b=O7qwQ/1A4LLYZDw0NfGaEmxFz7t5sT9VNgu4GBWBuWuidsneXriH4gU8Y3WG8Q9PpzmF82xi6YArT9RH6Ft9UF5elUkdrDRl1qF5xIn0LBoeEf7t1AcGnUfKdQqd1iCcCMc1edQlNB1pzY8NQW4wJb+cGkrwz9ES6iSGi0+amZurCiBTgr6htxPGR+hfjEWs4950iM13dyH5ZVWH/LBiaFfPPJKW7VbUa51wPS3Ts/wRtVXvoNBc0npXoMX4rT1GYLRG1/+ZB6qmgrHlbpH744DMRAHaQLCz8IlnNANE+N/w3fc3UXBrtP39ShTgKiytLnevOxi0gILUmRjYn/zO3g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 08:12:50 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 08:12:50 +0000
Date: Mon, 12 Oct 2026 11:12:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Baul Lee <baul.lee@xbow.com>,
	Cen Zhang <zzzccc427@gmail.com>
Subject: Re: [PATCH net] ipv4: use RCU protection in
 inet_netconf_get_devconf()
Message-ID: <20261012081240.GA601865@shredder>
References: <20261009074405.727999-1-edumazet@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009074405.727999-1-edumazet@kernel.org>
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 95975191-847f-4898-cbb4-08df28389b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|11063799006|56012099006|22082099003|18002099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	xSVir36q673f/Bzf7sulKVtyafDchKnDDEWmWb+4KaofiMqBf8aZDWeUU0FNrVgTvb7VwypVPD0393C2944fODVoN9EBWck1ROOKd2xjsZIAT+cWU0zVjjVettHXIdusK6XKSPVyYy5Xxz34BRLY29uyEZzgFEZ9jPjunL5MOSzR/w3Zf94x4+xfUiKZMz61CeeKEI1PpWY2u9nSTj+UhWPBbCKwwTbSIIQCzs/niNYfcmVrZ5lfN4JFNWchsiJielcHUG74bmC6TT3CRNkvdX9ooeq9SU3tyD84bQMYrBUXDW7AX6JHiHloZ99rQ0NKWzQ9cs/plnVal3gIBmqUsX2T9kjc/n+eJmyDzYyt/9+wPK1ljOS0ZmATnu+Me8JilPLUPdTVE+XY4EU4rKSe5eDuds/wigNITcy6GagfQBhNF6A98anUtJzExAEprk92MhchJqWXFDR08uA6UTwtQK8OFqSAu0eibH9CgAOXfUk2i9fItufRqZM+b2pE+BP8ICJ1EMHQD8tdxJ0kVhpD9pVGl4s7HzjX123ylrwShQoRfQ4gpx2namgH8g6wqhCeFHPm+WqE5Y6b0k+L4mmGcR4nyzzt3tEWKyinKBKGVj5Ka5Tf+8xQO/ftlYb61c+Iw0/EJfY7pxHFuyH5DYDquph3cWlPdtkXboVXMbGGO5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bdcJSCucRnjrVWuDOPd7ohIs3Te7PLc5PQw6B/n46Gnoc8d4ll5T4KQMls7w?=
 =?us-ascii?Q?BjCUvL21r1TFHyTYNyKHq6/J/bf+Sx9bbxeWSPEEv2KwjZ4792GAD67dvwQZ?=
 =?us-ascii?Q?CO9cbamWtxDAuRcMHFbguTRpIRyDj5TfMgLfrT3O5mC+4UNB+XLFdwHGwFZQ?=
 =?us-ascii?Q?MmHO1/NePvRcRO3WnW7vOc+OPRmcGHie06VdVY5jFbb8dQM5J7VrSlHvCtYf?=
 =?us-ascii?Q?8IBxyCE65jTqEHU3IFqKIk5IgqMqhkWKxUW+5hWFTEHAt9OOTgVCrOgsFzSU?=
 =?us-ascii?Q?/hhfH/rK5wleV5X2ZpeLw90olhAp3VWGtyMz+7ApdqRtpWgDe1IZo4HnyUbE?=
 =?us-ascii?Q?UTLSvKL9L2yD5asfqxurjntM0i4w+aVUnEESf4cra2xbel2kr+6TbwGUy+wR?=
 =?us-ascii?Q?BQGiPLrLQXt4YcZzbXk/8OO7OIAuMI12e9Hh/WUTqAQMFP+IoJF5obVCPs6/?=
 =?us-ascii?Q?TC5CkxzrabjYPtiaNHzWUCXm+bFf+3g6zCy7syTMpI25Xqq1pr1MOCn9gJcK?=
 =?us-ascii?Q?9W6nqh4jjCiZ6Xpy3uJIKhMrKdfAqKdOgpZDY6mVXerAC4eV/SyFbEOmYhGn?=
 =?us-ascii?Q?rxdR4oN9XrJgnJuE6x/3e4EZsCjopXzOBHG8mbfBxsk1qyfQDtrffce5gJP5?=
 =?us-ascii?Q?rcLx03BhFHPmd6QuZtdvjtwkN2F6Xxd2rR+t4NVJOsUaqSOO94pXxI+lagxj?=
 =?us-ascii?Q?VKj1Xz/YKAGNFamrLWhnPK1w3vskRpbrFwLX6R6taKkH0tIC20De8dLK8MtT?=
 =?us-ascii?Q?vssFrYQS9uBFR/YwWrel7IVewb3gOkAvSCH72Mg+dzjh2o/KNh8DBKOKR5/O?=
 =?us-ascii?Q?SvSeGTJLLFsoylhX9OhjpdOhnywE5s8j42OurXqvq4eNjG9qGgyFYxWxBXiS?=
 =?us-ascii?Q?AMo7c5Je80pTlwS12CPRdxQpez2mAjSixT1512Twryy3wx2ZzC2Cu7aKknm7?=
 =?us-ascii?Q?AsPgGc0XosIYMbSvSUKcHQMDL7zXn7TTQ+aDWHFtJvdyACapadVycnCrtyIY?=
 =?us-ascii?Q?XmhT+fvjArtYBKzulHtzW3XDP69uF4UfbpoScE4pp519y2prFfTsQwxRMp5J?=
 =?us-ascii?Q?lexPBUiP9BZheSzgpkxhOGXoI0YwJhAX8wSh4LvMPe1+5qeWrxx+8aLGUov2?=
 =?us-ascii?Q?IkqlLmYfHH08thTd80VXfd8jSj4XvewYQ4tITf4T+lvpd0wiez4MPDAQOwVd?=
 =?us-ascii?Q?l+4bOEPi/eeM5/fIA9N6WvKS0Uf+LtOgBWIjOIMAf6+pELhjlCSde/+tZC7O?=
 =?us-ascii?Q?YTyA8++f6ici6Pmy+9+EnpY/Xhf9U6H1SvnsxhSG7TpqBcXU+/PYXOBtQz9G?=
 =?us-ascii?Q?ATPwEGq2qgeTJn/YldVSsEy2tm5Jd2geAWyNw0LbZWWfQNLY3igqKSE9vaCR?=
 =?us-ascii?Q?nZzYT8Kk83PkIhf3LYlXoi7cJRopvyAJ6NggiW4bdQgmwyiNyZAvdkXjmeJQ?=
 =?us-ascii?Q?A5hmI9HBr01mXwLwBpEv+BFPymKFMtYsGaEwVdhMOaGRMvip7CwzkZqD8JWd?=
 =?us-ascii?Q?5D16F7gcDt3aH0AHHp9TFVE/g/U6arSHCrHvW06PvtBAtMRXhhJe9rbQ89ZU?=
 =?us-ascii?Q?HYEUyOfX8717++2QJsEPWjxgi+P8x77NorjEnOczt3+sh9+E2GFa+gl/i411?=
 =?us-ascii?Q?t5eaGzXeBpU4pDvrxqf5Hmtcly0rsI7LRPs02501mFqyBrXA8AK7q4v1NE5V?=
 =?us-ascii?Q?gQbraiBbYvLqPtZ1qF/lLo3YjX+myPrctBgKAXNQCWLL0l9m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95975191-847f-4898-cbb4-08df28389b8b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 08:12:50.3936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKA8Cp28sIBksM/Npni+zhSE11SL5EmlDGpf9yWRvFTBPK+LkKpEJE9UeeqKOHGm30RzXcVyrXjTtNY+n6TNuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275

On Fri, Oct 09, 2026 at 09:44:05AM +0200, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> inet_netconf_get_devconf() runs without RTNL. It uses dev_get_by_index()
> and in_dev_get() to pin the device and its in_device while the reply is
> allocated and filled.
> 
> in_dev_get() is not safe for a lockless caller. Since commit 9d40c84cf5bc
> ("net: devinet: Reduce refcount before grace period"), inetdev_destroy()
> drops the final reference before the RCU grace period. A reader can load
> dev->ip_ptr, then call refcount_inc() on a zero refcount after
> in_dev_free_rcu() has been queued, and keep using the in_device once it
> has been freed.
> 
> None of these references are needed. An in_device is freed after an RCU
> grace period, ipv4_devconf is embedded in it, and
> inet_netconf_fill_devconf() does not sleep.
> 
> Allocate the skb first, then perform the lookup and the fill under
> rcu_read_lock(), using dev_get_by_index_rcu() and __in_dev_get_rcu(),
> like inet_netconf_dump_devconf() already does.
> 
> Fixes: bbcf91053bb6 ("inet: do not use RTNL in inet_netconf_get_devconf()")
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Closes: https://lore.kernel.org/netdev/20260815172032.79740-1-baul.lee@xbow.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Cen Zhang <zzzccc427@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
