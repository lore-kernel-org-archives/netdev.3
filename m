Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A33E5452B6;
	Wed,  9 Sep 2026 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955030; cv=fail; b=FONcXgftGP+iYqXYRkuWtvMIEWcIlTciEqy/KJNvVNBhTU2VG9nAqGmeqosuMZWwaRx3sFUpxMhYreDlFuI8U1tAV4a+gp6Ua89pYkroOjuGxX3WFUGPK17bo11bMpwLDmBCHpsLY5VBLGzemz9/m1RXrSeMRfC7dMccyQ3lTKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955030; c=relaxed/simple;
	bh=+PY6NXRYGDUhftPiAzBRdMLJ6rCqs+S5d6xQFZnD3dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rNfio3/Lhyf4v64t7KQeQP5KYCeSHjp1Rr80Wltze2OXprZRFxgeW3Z/w07GTQs7k7vA1pBG8Nna+5IG41WI00MDdlgXrL02qCXiHQcexaSXJ+Z7Zf6yIftwdAdbruG3INWpf3NXHzY7fnN4mDJx9ddFjMTQvs6/DOp4adJPnRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oK6T92Zw; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oK6T92Zw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op97cJlMH/XhllDlG5WT0++XPNhm/+jBPmNa5qR7HT9L99b/92VbbQnzbzyhhrXY4f0aCxOG9K/DklFVOVrzRUxYNr2YWIdwodx+7k5SIBpnSfQa1gaskdC0mBZRsVnHSZNQGLX2NYPsJo7UC41a58zIp1gqvLOpDa3KiC1S5r+V2QbMNxvMWhWTYFa7EaxthSTRBnZWpt60mSpXpLWi6TWwQn4xO1FAkcEKFXXpEk9E48yqCTk0EjCosfKMTP5fVO7KNxY5Es3Ult3IF5yP+sir+30UuIpGkraFqtEGPSzqP95V2d0q82MR6L1FDVA23IT9ttXAL7AIkeQhvh4Z5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BKbcpbY2MBe0Dylo5S8EwNS3wo+i3xbt0iXdCEEG0U=;
 b=jFWpstho9pL2XiuVyAAFzDdQg1P6qD2OytIBk79SXNQTaGSkwozR1gzaERQhq6phprpuzc9Q0G94cPmI4TbY7oghV+ZUw+YUAWwIJhNhTGTpeHjunsexaSQUv2j06VzDIDo9x7/Gr+LwbcinK6wZMyRz5p57OzhqScYPOmmGbbjezizV+FM617IamrTJNqctPoTkcDoY7G9yZzhUgT3FMSgcM2T3cuQxYDLRjwaZ7sHMuIqouf2kBKtzpAofmnpI4Zwk+mRMNproffU7k4Kylz1aLI0IrRYx1jsPNerFvDiPnVS0SfzKOf19bu0HBo2gHXENaRO4hpt+FHdpZTGBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BKbcpbY2MBe0Dylo5S8EwNS3wo+i3xbt0iXdCEEG0U=;
 b=oK6T92ZwbLBe/TcT8Se1x8xOfbafpCEcfFBroJVJzbblz+Afay+DKiSgaTSzCLYUrIRuWXmA9sH6EqTvSi+570wT0vBk6WARi4vaiV40y+AaKQxVKrLBRIPcJtrtpZbggKCycKrYe1kfcIQvP9z8kIA9zH9clbS0YVaq73xrS2MKRTJdawt5W9n+gKspvi8P0h1Z3ik230j1iwUte2WqRdFUEorsNDkRooyETI4z595SZY7j7tRUpesx3p3GorlAKmoT4fuXKl/Kzi0c3zNWF+Ikle2pOZ4Bd5GY/fQhGVX2td8Bfo9tTXgtvWtzufgUzjnBrBNJ5RQ3xvUnkEBb/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 11:57:05 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 11:57:04 +0000
Date: Wed, 9 Sep 2026 14:56:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: AnishMulay <anishm7030@gmail.com>
Cc: pimyn@google.com, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com
Subject: Re: [PATCH] ipv6: addrconf: drop "BUG: " prefix from pr_warn()
Message-ID: <20260909115655.GA1344764@shredder>
References: <20260807131300.2677228-1-pimyn@google.com>
 <20260810095136.GA2582170@shredder>
 <CAJWNTGyLJubRHn2KbqQMeV_jqexSgaLbzTe+xJnGzUw=RUtntA@mail.gmail.com>
 <20260810103517.GA2626301@shredder>
 <20260908043143.120335-1-anishm7030@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908043143.120335-1-anishm7030@gmail.com>
X-ClientProxiedBy: FR4P281CA0425.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::12) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 1890f9e3-5b01-481a-3b40-08df0e697712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|22082099003|18002099003|4143699003|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	9xapt3MgpzQEn2FOHYVd9rP6QrTwNXRSca7vSX/X9BTmbJ48gJnH+Ue//OkhAClF6rnIAtY3Z6ix/ebwt2Dk7zrdHyGpD3sxEXuRzDFAXI1G3kgtjsjINnbtx3stag+RloHl4BBluezKZi1jfRnUqdW+46j7hUtHCvX6XY3vAfu8Mzo6XCEl5rzTzky9TwqtBdsnUfP7jAu8e+bu0iIA/LgIZNLK5k+Y1M/OBme1y/LgqcJzVHJ4RTimGjM7cVpdPkWai/Dj8pBWfb+vVTyNRsD42rPJJ6heN2X4s474BcJqLE0qWlsIWMayWpojAKrZwMoWYUMKYKVJksRgd195mgMc26WZiagESlu7DHZLFk+tpfORGKNWUVj9v6KgZeM9SGO3sWQCX6mbxOlghaO99xEvdrESnoMY4v1LTfweI4lJ3qVAWI6B3rJp98Ozyla+WFZ6RDTZ33v/CtHOsVpUvormx4/WSEiCzxDuQvFQMbURMZGteCx6rWOo0K7Hd5TW6D8fPYGxSWiG7Q5TzxIZvjbBBBj93SZy+ZuQNc4oCBGkoQkI4bYqAuT0wMMnyVgAUoVR7BElhwpmfla0ox7iUQrUWsP6F9h7n9mQCGuf8LLK+75WzwRBH9ALaHhq99rHzCRis0F9DRHNNHzVdQ/dfdSOkSSmu1kkyLsdkN9FZgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nyj/1uyim65dkp5eD+pBlVXLIF1o9IabqHw7x+NJgbLm0M5eTX9hAdhHPtli?=
 =?us-ascii?Q?duuELlmxByGjMJxvqnlrbog9m5lOSEn9UWb7ZHeWylZh5z71vjE0nWJ2r7lF?=
 =?us-ascii?Q?cucfSfBCm9Lu3KWH3cWN/Hhn7t8Vbfw4qMmtclXfygrYwbysKZmNxs5PP0yM?=
 =?us-ascii?Q?2DuHZWTi+YpKJpNlFd+mHcTEszYdNaQnIHHmbawEKAd0Yoo0GUXy3IvGNKFI?=
 =?us-ascii?Q?r7V1EZ8RkXjiSIq+V6WwT2TIZbeQWSd8pnaA5fku524hFf/hplTzu0RCKcDg?=
 =?us-ascii?Q?NGl5arr9PdGzJ2Z67St5grc+eTcMDIjFAzI9w/SCOUa6TtuvroSmD8G28kFq?=
 =?us-ascii?Q?9+lY9wXySUAIwYD4TQEyPn7mLlrokzJbpIKk1M2miRkf98phgYViOJzNgWiB?=
 =?us-ascii?Q?gMhfMVGzFxo54iksNI0MZOkV+afYKBIZnqZ5feOPMDILHD1PgIG1nsT29Wsq?=
 =?us-ascii?Q?dJArPqdJobDIB04YeXa/Gc3V0sQI/4kKzqOJJxrWGIo3GswufB9nk02WFY+A?=
 =?us-ascii?Q?fa82p00SgACMxShA5ctK0heAGS62k4tpc01S10xKWfTlQEXxwSQcss6GphoL?=
 =?us-ascii?Q?cR1HHy4p9gUFtjnUkAsemXrKL9eNt+fG8/HXPFwaJZ3NIvv8i/SU0NZFeoQW?=
 =?us-ascii?Q?NwxPZCxVPfYSIq5L1f7g1uo95KWbOGRpUtXHaWbye3v7lgKLXvg3dRYnET/R?=
 =?us-ascii?Q?jc/L7M3Cx2JpAAbvdSE5a5yctUeKziIs3RQMoVG0NC320/40h3/k7zvZ4mpI?=
 =?us-ascii?Q?445YjCaDJb3sTY8sjJxBRSFzm4LIpuhbct/uJEip3oUGC7hqALJ8DuVzRbxB?=
 =?us-ascii?Q?m2E3RUSpe/bWSwIKRqJbhcgIoc6X8vlQu1nKhQ4hvQqhNTaWsmS/S6EG5TBx?=
 =?us-ascii?Q?NPlg7xQwPMNJqH4CXu+7hP/QB+Ghsd+ZjCu5Au2066Fmb47CehsXt+eJCX12?=
 =?us-ascii?Q?nIuSMSqmPRqe5V4Yp2NEfZvnb+sTC3VTnAXwBC40ymXYh9s2FNJBjv1d7iW1?=
 =?us-ascii?Q?0tgDiLcLaFcLPQIUvYoOZLWYo7xeUTpHUwH7kxNnnswNsd8yJEOCZ/uDNRMA?=
 =?us-ascii?Q?06/XjPYMi6j8o0RTpqXV8A8UymON3f9TtwXVdvG27hb2Oysa9LMxH4+YCbwE?=
 =?us-ascii?Q?N+iF6fKnxqrRAm+ynkWNZ0mmFGAl6X6l6cAwTMbCxppXjlC2qkNCA4fPHOIr?=
 =?us-ascii?Q?Vhu71bcfktV0TazRL9y9u89bKEbVPDUxyXS1tfXGjF9ohr7i8p4jNispcV+l?=
 =?us-ascii?Q?Eoi7GgfYBF53FaKOdPuwF5u/Okd4NpchaYPbVqf76RLwXEUvKS5EEaXKB87S?=
 =?us-ascii?Q?vkCk+JtRbAUuia2lTqPFT6L4xGP5vdjHk2No2JrmV/4jlxjN/J9pttt7QVug?=
 =?us-ascii?Q?yIa96osoJP4zx1JR1O3b+RwlUYIr7U/iBIsSYyyf9/CjufZqif9KEQjN4bZo?=
 =?us-ascii?Q?H3iuQDb7YI0w3P+2L7KgHOtGb6tmSDjjZBFC95YTgfKhbvD4vLfSw4Joqv9j?=
 =?us-ascii?Q?7KkV6c3eR16N50betPHPGlcK7dEQAO3S5NkOPgHxJ1IM4qYAvreC1LVyVxUT?=
 =?us-ascii?Q?VZJs4RJWsz4KkrXp2WsguWNGzyZuUhsifDi3MhIPp8DWGY5NrtOzCoYU7YA1?=
 =?us-ascii?Q?7HYrO3dF97npYKqWv7eowJ40yC6Ndb5Yd7oVkkQ8uCBLK/GIq5sJo1ZfXMtP?=
 =?us-ascii?Q?gmmKXIvMGFM1BrnlxvS7ZQABfBUSqsqvaTlRKtDFv0kdQZjy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1890f9e3-5b01-481a-3b40-08df0e697712
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 11:57:04.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INb+LPgkembDojq6PQYchNZivPOIvNejd9+v56IQvmUNU5j7KnqEWwzBBiDJhMfHLNGfsLUFVZe7zZC76z5O/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637

On Tue, Sep 08, 2026 at 12:31:43AM -0400, AnishMulay wrote:
> Hi Ido,
> 
> I ran into this same warning independently (different syzbot report,
> address 2001::fb rather than fc00::, extid 57f410c9a4f8d7a441d6) and
> ended up tracing it down before finding this thread.
> 
> The mechanism in my case: keep_addr_on_down is set, addrconf_ifdown()
> clears ifp->rt and deletes the route for the kept address but skips
> its notifier. On the following up, fixup_permanent_addr() allocates a
> new fib6_info and schedules addrconf_dad_work asynchronously instead
> of inserting the route itself. If a second addrconf_ifdown() for the
> same device runs before that work item gets to execute (I see this
> happen within a single "ip link set lo up" call, which drives both a
> NETDEV_UP and a NETDEV_CHANGE through addrconf_notify()), the fresh
> route gets torn down again with no notifier to re-arm anything. The
> work item then runs with ifp->rt NULL and nothing left to insert.
> 
> I have a patch that regenerates the route at that point instead of
> only warning, verified against a C reproducer translated from the
> syzbot repro (no warning, and the /128 route is present after the
> down/up cycle, across repeated runs). Since you mentioned you were
> looking into avoiding this state, I wanted to check before sending it,
> in case you already have something further along or a different angle
> on it. Happy to send what I have either way.

Does your reproducer rely on both keep_addr_on_down being set on the
loopback device and its MTU going below 1280?

The loopback device retains global addresses when this happens, unlike
any other device:

# sysctl -wq net.ipv6.conf.lo.keep_addr_on_down=1
# ip -6 address add 2001:db8:1::1/64 dev lo
# ip link set dev lo mtu 1000
# ip -6 address show dev lo
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 1000 qdisc noqueue state UNKNOWN group default qlen 1000
    inet6 2001:db8:1::1/64 scope global tentative
       valid_lft forever preferred_lft forever

# ip link add name dummy1 up type dummy
# sysctl -wq net.ipv6.conf.dummy1.keep_addr_on_down=1
# ip -6 address add 2001:db8:2::1/64 dev dummy1
# ip link set dev dummy1 mtu 1000
# ip -6 address show dev dummy1

And the local address (::1) is not restored when the MTU goes above the
minimum IPv6 MTU:

# ip link set dev lo mtu 2000
# ip -6 address show dev lo
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 2000 qdisc noqueue state UNKNOWN group default qlen 1000
    inet6 2001:db8:1::1/64 scope global tentative
       valid_lft forever preferred_lft forever

So, given that this state is quite broken and unlikely to be used by
anyone other than fuzzers, I would like to simply align the loopback
behavior with other devices and avoid keeping its addresses when the MTU
goes below the minimum:

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9d89be7e0544..2f7c872421b6 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3908,9 +3908,12 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	}
 
 	/* combine the user config with event to determine if permanent
-	 * addresses are to be removed from address hash table
+	 * addresses are to be removed from address hash table. IPv6 cannot
+	 * operate below IPV6_MIN_MTU, so treat that like disable_ipv6 and do
+	 * not keep addresses without their host routes.
 	 */
-	if (!unregister && !idev->cnf.disable_ipv6) {
+	if (!unregister && !idev->cnf.disable_ipv6 &&
+	    dev->mtu >= IPV6_MIN_MTU) {
 		/* aggregate the system setting and interface setting */
 		int _keep_addr = READ_ONCE(net->ipv6.devconf_all->keep_addr_on_down);

Regenerating the route in this case is more complexity for a case that
nobody is hitting other than fuzzers.
