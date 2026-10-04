Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDA392C28;
	Sun,  4 Oct 2026 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121892; cv=fail; b=KhMKFlSr0dYJM+CLu+zOVJmSO7EomAgh/RzFUCsuR6zSXS3pTCceqYhHtTEfiPAyAKssQBa/gkJGItEuEQQdvRzwwAt1tjIqPsf+Ux7ZJxgS7vLFmyvmI3uvnI9ZOwtpBiutyhF2onjNSG1pikwsebRjxLvetd9Vs2xL3Nq2HcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121892; c=relaxed/simple;
	bh=lu0xweacUaACBwuVRkFh9hzdelHwHcu8U1ThUtTFrGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=drE0PrnmOldY+0uL99TYFg/hrjHmNHlX3JG+Jut4JrNY9NUaFjf5hibqTFHyhVKci1uGc9an9F8JjAuAVPpw2odVXlbAaIrQzQIz17Yjro+h9DOIIlRuMQX6kizZhfG5Np6u7F0MzpQfXkZ5uDQqG8ApTNRqvTTGAbuk7e7cBuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hMIo3gTS; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hMIo3gTS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9cqQB0PS1mOEqO6h/pKe/uSy8UwzZgFDwtSttCUKa/286lvSO3N0iNDGnV/i3ZNMoMUBo6BMvuIEManKRkxzByyge6ZaskWAjKK8rrYvsy/M9Qil/yAaBYNUU39nEPSd/9stQP1wJs93AimyvEwO8sIF+a7YxDWUgjnynV9a4JziqaCVE5waoexsJaXKgVjAu6UkcCGVmcrFwcOTZVaslf6SfJQpECQiRpBtCW5NWZkautAI4KYaL11BlF/hbdD55XF41phGNZGe+WQ9vbtOZ5HQ0z8hc6WTb3Ehj4ivq4ZODihf7HJ9/6fUp/HHj4wp8ZfV1fb8yFawYUqurfi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAl/CTWoXmnjbkAqwBvLnMdRhEYm+1RHHzoQvXVsvcQ=;
 b=qDiorHaZomWKiQLc6Iv2JGMB3VASc5Xpr8fLU9wrEOqUloNnotMWgsXb1OHLzgvGE5KDYE1NY3gaHkR609htC5RSRcT6JMbYZApgud51i8PzDSZmZ1/LR9/hDwwL5Eltp+HJnLXPueFdi/QqSY2/cWudb2DR5KKDsjsLo8BwEfyZQSshj5Kf7AV9+r3wvC5yWKVg16EOI1gzTXAa3q1NhQferfDrFPtblcqexxvvad8lamkecLuABeJjmBd8mtuSgPRp3vAZFUenksr/67r1PG/ppUAI39lx+DUYVNaiHLtmFto4rof23plGDaHYJfYGqRY6cADm+tKBDjK4sV69+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAl/CTWoXmnjbkAqwBvLnMdRhEYm+1RHHzoQvXVsvcQ=;
 b=hMIo3gTS0H3jGAevhW97iAHQSk1v7JavRL3M/gS3l5iD33NJIElVraawH1F8HeWqWwOyNiaNb1rEJFUzb2Ec0nhXgWMA7WumIf/JBYmU14rFOAYKZdbpqs7vAlho02WkGmwOITFUla7qUNfMORCHSZ7WIzRF9lNO9kjhqtXsAX+f9hkMZSlrFBFARwJ6otnkpuQDWK3qWkiNH5AmktjqSPdPSNt5gE4tatYb6O6cEUYzJ5WZ7x2lKut9lO96izViIVA1Z+s4M1FQnzcwLpa/dB7pAjN6WRY4BVRU/9wvVtSYxGkkCOensQGOpgEXdmaqgzvq1gKibrBvfdxjvxnD8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DSVPR12MB077799.namprd12.prod.outlook.com (2603:10b6:8:4fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 13:51:27 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Sun, 4 Oct 2026
 13:51:26 +0000
Date: Sun, 4 Oct 2026 16:51:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: serialize address publication with
 addrconf_ifdown
Message-ID: <20261004135117.GA206930@shredder>
References: <20261001052150.136559-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001052150.136559-1-4ncienth@gmail.com>
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DSVPR12MB077799:EE_
X-MS-Office365-Filtering-Correlation-Id: 200e8804-fe57-41e5-788f-08df221e9570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	lhDYNmaNbVWKA8FmsRjD8pIdrNzxLHJoHnnalOhrC5A+/VnzsQJvAtrWSzzAZEw0+YaodNKf8xdPokoGNe5yokbcpVZoQGIf7fReJBgh4eDevizI/a7bjrAnBxUHXYEvRb0asFKNSlz4zLiry5MSOscqG1sICrt0IvtsyKP8HhO4RFcybKhsObqQf02NV45PcFFCTNS+brwK7QEudMv9BLeViP/ZDURnfDpvgvLYt/XTpwmIh2m3tLAi8NcyXJlmEcA410SonEhCabBgFmNxXHOkzuihdGbMm184xY26RoAjd9fbkq3OAhe/lso2qVUkT2xpT4p/WFmMdXWTDgog9o8liMNEGDP6USijeO4of4vAUkdTcU2H8qNYlCdkNy2c8DsmhqGb2Fw9wo4uKW6MmTv++DkKxvPOjZuzBmiXsy8aGMugR2tBc8n4QNmYC8VeLcyPENJ1odEa6UTiyCC7TXCNvN8Iil2Xs7ETD2HUUOIr69X/aCHwgVz4FK+jDuXfWsOzyME/UW6G0QX8n5EPt9ZKrCbE6EBDVJlMs99VkgvarF8WrabWCuGvuLbDOyFPcFJJ3ggVt9tPr+WCVnLzdsSXewm2LkCVUb+xhE6HrZUAONeWjglqbkcynHkV28FJKEgZA+vf0GkAwLZoFd3dEaonE+A5UPJQJVm4j6tJ3MY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mEQbmo+tmO2orw9/aAcKREjNv37WJNry3LCxYfXt6kyutWAAyRIGzYGPjd5A?=
 =?us-ascii?Q?FUcv9cv/TBgcHWd22BMIPgLPvpxU8MtJPDz8Id7BnCxY0nZ5QirXfx7szVPD?=
 =?us-ascii?Q?vfFhx6y6yHPTMkAxtqJ9dIqTiMlFNnIvR2f+OnKIvaVaA+hEvc5rcTlrKXwv?=
 =?us-ascii?Q?rQdAplCqKGSjuV7WDMgsWoG5OkHrU2Mnzc16zwLq7ON6GJienKH8WLwSU+57?=
 =?us-ascii?Q?bommIC9y9+oYTn9aBLV8lIjHJDDYXcAbP206mSDo3yuGQx8GH0/bp95+9mU0?=
 =?us-ascii?Q?mrQ5BehK4kn++UKlEb2D3yt6LrYe4CzvWML/aVRZTh3/FD8w95x+9R4ZOomN?=
 =?us-ascii?Q?WObzH/PmAduHsdqbFm9oYRDiMQm7LFzfigIujT+rRhpZD1TJDMmz2FoNaL0t?=
 =?us-ascii?Q?UIhd/iblHXIIQvtdnOpR2gHrx7ZVYYV//IyWBNIEkXkviOnxoJ9reQQWJQzn?=
 =?us-ascii?Q?9Q+upAYonWCA9XTVrYHGj/ediy4DxlxuhLWNMArExiBMQC5nC9RX3U8uk/US?=
 =?us-ascii?Q?pCVYbLjid25Kd4Hlk2BaFwwS3ZR80e4RWGLbvZQmS57su9dLHdpfDFYU4PD1?=
 =?us-ascii?Q?JK1kBcMg1ekETX40THgLGANt8iwOWPTzuTaAomTvDI0o3bzz5SRRmZIsQSAG?=
 =?us-ascii?Q?rIF5zIOGeDUOoenwgon0nJ9YUWL05rzmFNMfVZK/l/4guAeFnx13etltghCg?=
 =?us-ascii?Q?NZn9A0QNQ4I9Z1Bjwb/krzhZUKxbmPcvAeOYrioygfLrXdehbSj9tsLLkulG?=
 =?us-ascii?Q?7b2UCburE+HaPW2OiaLSZw+tPmfPT4i5V/6UGA7pJNdKRV8+aSlbzZgViKvr?=
 =?us-ascii?Q?6V+PX6jv1QPJYJNsSdPayLYXibrSMf0P7Z7MYOOYdy2IuH8ul5ziMpBP42vZ?=
 =?us-ascii?Q?YicIwCT59AD7UtMBdv67ALEXE1trtr2oiLyDJLibVfkYPa5hQdK/WPN/qj8w?=
 =?us-ascii?Q?IDHpQvXpA9kq+FppcUvbhn+LkfwLOD4MDpiucsnlmHpaqSJzCk92kUW0610P?=
 =?us-ascii?Q?AdGyWf8g6xraQAGZFQ9fIgc1mNmqlXxTIfSyNm3fzzdFALae1BQoVok8m5eH?=
 =?us-ascii?Q?wMO/opvG8Feaayre98EAdXAF/LQFuvYoRTytxRqFKkIwo162VhUAEGL5ibM8?=
 =?us-ascii?Q?LVN9JkWNu/MtEph+eCt8H1bZ3/CvijvcgIsdDKg4EH+FSWWhzwKHF4WkcR8n?=
 =?us-ascii?Q?B0ztd+vK3YwW4MUzW/kOLF9c+f1gEpEcOphxO2wQ/Bg3qkACRi49YcHVdwjK?=
 =?us-ascii?Q?1+G7HqSwh0v1LhCMhw9KRkEA1PGOOnhM879e1GuQaik2YYc0I+6noMwamcuE?=
 =?us-ascii?Q?//o9R58z030bQ1vDx9gmhim/arM6AvnEwxLzZA9qJFhnXLN8TTugBZSckYba?=
 =?us-ascii?Q?arWKK7iYi3T3niNOWqBgDqcjQqGZNycd+Iw+0tvnBMjkSB1Ce7hNceIy7unV?=
 =?us-ascii?Q?gzVqO/jkrQQULrOQwMFsqWcVn7Esa4GDwiPhQcQP6o2umuN2Ad4Vgj/oHWqQ?=
 =?us-ascii?Q?87znS9y8O0HgYxVyFEZH88aBbOagldIvrDPLsPK+mLYC2Qh9HcWTBI7hNCx9?=
 =?us-ascii?Q?/1CF6vsy4EqWA+eirJxxhVNCU1G1Oo3Yi2wbEqmd8KTPJfO3sR8hp8BWwIgK?=
 =?us-ascii?Q?KAqh0uCwU9EJxBsV6v8hmzaUOPK21ljMgUBDcGKReFTndKRPWg+oYP1XUsGK?=
 =?us-ascii?Q?4NnqbW8GhJmqYYxlF79hyQlXewz7awMiYkdG5M3RU5x6g2eC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200e8804-fe57-41e5-788f-08df221e9570
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 13:51:26.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHgCmbIIVrTVjJzjEoLcRjNiYkU4MtCi+Kh4EhsOHzUnWJDLEUtl8kvWcAde0NimT84GfkzGWcc28o5romSh+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB077799

On Thu, Oct 01, 2026 at 02:21:50PM +0900, Daehyeon Ko wrote:
> ipv6_add_addr() inserts an inet6_ifaddr into the per-net hash before
> linking it into idev->addr_list. addrconf_ifdown() clears the hash first
> and snapshots the device list later. A nonblocking add can therefore
> enter between the two teardown observations.
> 
> When a non-loopback device's MTU falls below IPV6_MIN_MTU, teardown
> marks and detaches the idev. A late add can then link the ifaddr into the
> dead idev. On v7.2, a deterministic interleaving left the object
> hash-visible with idev->dead=1. ipv6_get_ifaddr() returned it, and later
> device deletion waited indefinitely with usage count 3. During network
> namespace exit that wait can stall the single-thread netns cleanup
> workqueue.
> 
> MTU changes require CAP_NET_ADMIN in the affected network namespace.
> Where unprivileged user namespaces are permitted, a local user can
> obtain that capability in a new user and network namespace.
> 
> Publish the hash and device-list memberships while holding
> addrconf_hash_lock followed by idev->lock. Recheck idev->dead and
> disable_ipv6 before either publication. If teardown wins, the add fails
> before publishing the object or taking a list reference.

Adding to the per-idev list under the per-netns hash lock looks weird.
Can't we instead do the following?

1. Make sure that the dead indication is written under the idev lock.

2. Extend the critical section of the idev lock so that it also covers
the addition to the per-netns hash table and only if the device is not
dead.

Something like [1] (untested).

Also, note that this doesn't solve the problem of addrconf_ifdown() and
ipv6_add_addr() interleaving when the former doesn't mark the device as
dead (e.g., upon NETDEV_DOWN).

ipv6_add_addr() can add an address to the hash table after
addrconf_ifdown() cleared the hash table, but before it cleared the
per-idev list. It will trigger the WARN_ON() in
inet6_ifa_finish_destroy():

WARN_ON(!hlist_unhashed(&ifp->addr_lst));

Can be fixed in a second patch [2] (untested) in the series.

> 
> The same forced interleaving now returns -ENODEV and device deletion
> completes without a KASAN or LOCKDEP diagnostic. A real Router
> Advertisement separately reached ipv6_add_addr() with can_block=false;
> bounded natural stress did not reproduce the full race. A reproducer is

"bounded natural stress did not reproduce the full race" is LLM speak
for "mdelay()s were placed in ipv6_add_addr()"?

> available on request.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Blaming 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.") seems
more appropriate.

> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

[1]
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3dba94bd2ba0..51add8f91139 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1171,14 +1171,18 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 
 	rcu_read_lock();
 
-	err = ipv6_add_addr_hash(idev->dev, ifa);
+	write_lock_bh(&idev->lock);
+
+	if (idev->dead)
+		err = -ENODEV;
+	else
+		err = ipv6_add_addr_hash(idev->dev, ifa);
 	if (err < 0) {
+		write_unlock_bh(&idev->lock);
 		rcu_read_unlock();
 		goto out;
 	}
 
-	write_lock_bh(&idev->lock);
-
 	/* Add to inet6_dev unicast addr list. */
 	ipv6_link_dev_addr(idev, ifa);
 
@@ -3900,7 +3904,9 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	 *	   Do not dev_put!
 	 */
 	if (unregister) {
+		write_lock_bh(&idev->lock);
 		WRITE_ONCE(idev->dead, 1);
+		write_unlock_bh(&idev->lock);
 
 		/* protected by rtnl_lock */
 		RCU_INIT_POINTER(dev->ip6_ptr, NULL);

[2]
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3dba94bd2ba0..eae51b5de690 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4022,6 +4028,9 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 		}
 
 		if (!keep) {
+			spin_lock_bh(&net->ipv6.addrconf_hash_lock);
+			hlist_del_init_rcu(&ifa->addr_lst);
+			spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
 			write_lock_bh(&idev->lock);
 			list_del_rcu(&ifa->if_list);
 			write_unlock_bh(&idev->lock);

