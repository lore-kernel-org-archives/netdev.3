Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C934D389;
	Sun,  4 Oct 2026 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791102064; cv=fail; b=kQ61dxCNOBWpJ3QNx0r5M06tdp3H0TIV4e87KgaQI7q9+N6KM828ROx1RBzKlxowRsBpHNqFTeD/msBCZWlOetg4ucTlJSdysG4LKy+6Xi4wmf1DNNVu4dHl3vrj0qHrPgSp/GgDMHiySrfz6JlOffDR2g6iAQd8yD4gii2ELDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791102064; c=relaxed/simple;
	bh=ZMeP7oZuO2y3vJISitoJgSQxR8OD71JULqhP9w54/FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RnPysOQJFNB2hmdNyzmV0PoBS6UQvXgkOBZLNom8GSC0BPtSg20R9RjDPLmjdWxs4VWg/hKpBNzYiX9JarNCCC1+dyEK+AJPTz+YFy5ud8dyLvpgfInrfGfqrnNSf4EWQjxY0dJsJXjPgIRbuS1FziYqxVJnHHQFDCfL4V5XMQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tpeYVMAo; arc=fail smtp.client-ip=40.107.208.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tpeYVMAo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pwtcyr3KtozFfayCzrp4kCwyDk7z5suPW6CW7EaHokbe7Ht2Jd6mOPyHdyL65dcB46sLffJZYFPWUtcW/e1IhIFcMwD41t6jajI29wa+4GrwhSwn+8rsRzQDiKfXQW5VvqzST2Ijo/I/Y2xUe+2zg9y7izctV3z9V4OtdEvDrV1u45DOmzlSA2+swA37afUijkQ8s8YAZr+nPpdgs/Z5BQNEwH6gj8Nhj3gtQTAh5oKVhwoYuiThX8lKxPQTi3LeKKHTMxTEiFZU+jlz3HuxGeNGeFm/58qild31oJzPIn26zv7G2YlH1vsa9FPwZKkk/MxlNw6eoY06pstj67np/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiqKHncbBWUizy/EJaigb57VrU0woArRfBwKnimDLV4=;
 b=gN1GVXH30ebxn9E7zBsQ26Wxz7dqbl5biJnvV6FqbsIcCJ/92/T8QToPnpD1UoI21glFXLeBEFgFwK8x+XzUo1BY3FRxswgutCUW0ryNq99zUFPxJ7mM/0WswlA8tjQ9T9O5F7OrIPVw+4ErTnfXupP5Neiu/wIvPVjCv5XXvVpmGCjk6UvB2TcRxjHdjxQm8Cd/fIRjTGkJI9+1+/HZvFO3Kb6kA/g/V0zFj7007EzvRRr+7XMuVJGSzX3sBhe6A+6nBKJv8JmGJLfdKtg2MBalh84YCKEjp+UwqdYxaPMaiZx4cn25oqk5zDcGaNVOCNOjuD6JHh07GldfdlveiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiqKHncbBWUizy/EJaigb57VrU0woArRfBwKnimDLV4=;
 b=tpeYVMAoP2L+kznsBXHOm6dE9qX9XBBmT9AtXlgSPb1Oe5NxyBS90j0Pgt+c/pORh9L7u4yjprsaHCAfsf7XtG+GQ4sg4BmOs7COOvp+KwOBRn87x4imUW4hxDoCOeCnGC1CAXdbwtDhG2quL5C/RKDKHYogSaBxjQqumETybwL8oa/a2348KaNMiwsNzBK1NsxjORylLxt2zTImlwrYlmElPKmf92IZk99fV+3VfKS16RJu4I0qFrTA99SIrtTi9IMGYl8FjLYMwOxfbBuJ5qQFxPgvramfUkF7a8K1U8Vmkh7JZsNJxXcFJMIibYkkCqH3/n3mE4/Tvl32HxqjyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Sun, 4 Oct
 2026 08:20:59 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Sun, 4 Oct 2026
 08:20:53 +0000
Date: Sun, 4 Oct 2026 11:20:43 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Donald Hunter <donald.hunter@gmail.com>,
	Amit Cohen <amcohen@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] ipv4: stop route notification sizing when
 nexthop group shrinks
Message-ID: <20261004082043.GB92032@shredder>
References: <cover.1790915964.git.4ncienth@gmail.com>
 <1054fa46165bba1b473782fa41367804aa908e86.1790915964.git.4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054fa46165bba1b473782fa41367804aa908e86.1790915964.git.4ncienth@gmail.com>
X-ClientProxiedBy: FR4P281CA0378.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ0PR12MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb566ca-c782-4899-d9b0-08df21f067f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|56012099006|10067099003|6133799003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tYCIGtUmXgfUr29Efvd3sWJNS/3Ohi6uljkDF2InQry2HCV/rIWa28GnUE8dS/YvNaW7BTIBpE55LpyWkapo8MKWkYALamkSFI5+IwPHYYr5Hd7bFsrRwiR179F8m/nf+4XIkoUKpaXcGmhG4q3FmOz3NqFUzIvrCQA5FhcPlSFs7s29emcFYKOaFuN+OS5Qu2kBFO4oXQD1n6t97mCbSoNif4QoKdVID4bASWvHCii4zbiKZwxVPOwj8DOi09LNbhFS75SupZdUY2CeRgS89u9NukCH9L10B6wgTDP6ysCN19AZ1FXO8A26W74Kb+S73W+BBYtq6S/NiKhbhGWYCb9EuyXN2/Zv/A18Gm4Tl6clDl92ytkZBTRe/9/CKwz9cPNVtGkc260El7juC6ksYn4dSCOBJIr5EAdFovNBD54pCxf8tXiDCWy9Igy9+Bghn1YP+5dEoHCDLuN52ZdD1LRjAMrPZyu0jb0TTuYzVTy6J84jeU8jRJMor39JHw7FnQbiedCOl/0YI+K7sqxAgEwcM/qRekS4WiAT0oKAseWg3K/fLbe3h/XBK7FZ/sUF+BGAxX2Hp3K21+ylLmyd1xa7dB60k3cHEbZMrdCadLSbbtw/4audcr9LhM9tgClOlu0TtDFbRVpl907cNpDqhcz9QzVfUjGQSpHY045EX5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(56012099006)(10067099003)(6133799003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jDjRz5jvQoOu+smOByk1Pbe8h3PTb8jZwXBxgFNwNtkAapXAkm4FyA8yBDYD?=
 =?us-ascii?Q?fkBHQbX6OKanFYop6guNa+HUyiselgts/YLlvZ5YGOOIlKijZ78lSm2fk31U?=
 =?us-ascii?Q?ElGhE60CjbpkJ+Jtatb74kKUaOOp9X+eA8JPm8xdKFlgaLaQ3mUju+fgjSoN?=
 =?us-ascii?Q?kaUZQBry+AYipK2rih9Ko2bWGr3WVlVx9RqqCSR3P4Sbfi2BJVAJy29jaKQA?=
 =?us-ascii?Q?Rmh2bm1te+GeVP9yq71KIfbSFWvdFy+4DWQNYvv09TmuHWdHRIgrrEeuLd2x?=
 =?us-ascii?Q?9BurcRmCRHf6RjX/DO427RxiPgWpBhtu1Tn3gKBpcjkSX12XPRPoRKDzzGym?=
 =?us-ascii?Q?gLB/nLK378bsGcO+2VHfsD0V02PE3FydWiB63XYFjH45bqBxtSQV7OXL/osO?=
 =?us-ascii?Q?tGucXb440jJCO2G2nwwMKsYq7nRfleU1GSwsvuKHuXUhdZ9emssppnR1Gw7T?=
 =?us-ascii?Q?+gPlBoxL4jb6DdlX9saxrK9jlHxglybSxDom3D5WdzXPWpjzqgP4XR62nsGf?=
 =?us-ascii?Q?WQENiE5xXUfMUtdZ48qtuy4N3MDrJhXHIM3REGrBT0Vfe4X4wcX1VRZtSeTf?=
 =?us-ascii?Q?XZMjP0rlelbwQ9o1yUaO2oCnxx8LgfWy5+FUn3GNFQ2zLsLMwu8TlKXYP22D?=
 =?us-ascii?Q?n+cHXyCh5rqEVX5N9DPJ3MVPmqipgLjBRRQzqO1UijLfeF5VWAa+zUxrF1GC?=
 =?us-ascii?Q?z7lPUUdkwCbwtN6KaLwz0FEyNpxoDrj261Bz2gfqAPPNaYUDApxkEBHiu3dz?=
 =?us-ascii?Q?8P4zPmaWj91BUIPfbaxjBMLQKo1BTA7OqMVwYKxBKBIF+iTdJRNNuYbmG5x7?=
 =?us-ascii?Q?yyoFOXsR8Ln8dXPRUhjGeMz094jmxf9c2bjiP+3yaSndt8/D23pT8EzVr1be?=
 =?us-ascii?Q?2+ZJABWIrPzVdDWecd5rHvFSnThCYRqOecW3ywQR6DjtCetHfY1WT/aZ8r9m?=
 =?us-ascii?Q?RvCX90hD4FX2Xcjllm2W6qenmSfLrWYEHHlszR3Q2qCXd2P1UhNlFx4+E3CE?=
 =?us-ascii?Q?lKzLM8qWV17rGsnf/lkowXYsf+gDhT54YBSCdY3OjRyc4Mr7r9x/VMxa9r0T?=
 =?us-ascii?Q?tf/LibhAG0sUUjJ2cE3O0tMbrCFjuBKlh+qqnbjyzLHTSC9DmR3GGdO32lFx?=
 =?us-ascii?Q?QVlsEkmZEoRi2y4PhWoYiD6iMCTumP9c2tBNTcyAX4x2cVKNo9i/SsSFAsAb?=
 =?us-ascii?Q?pG5bRtA/Z9mkFPbHjYzoYzLgwNlyX8VpglegQ34sZbkSsYdh68/vqM8so9A2?=
 =?us-ascii?Q?J1Tey5Wesp5PAQ0Eojkb+rsXhZW1GsFGfGFiiSsKcH52aE5amqOnhHbG0gpR?=
 =?us-ascii?Q?HK1F7JDyKaUK7NHROuwOJmcehDZBV9IeFAo4Ve+VXXwxo0NILZKuEiF7CHFa?=
 =?us-ascii?Q?pLgnHKCkdEMpOLbfgFZaSm9kqWoavdK2RpwhuxOh7KtI+68sO7VGwm72+8MP?=
 =?us-ascii?Q?aer9VTfEfwn+vhhCJc1sqqvqhXwoAMSLLp0XjTMvKob2fnDKYUKevP4SrkKN?=
 =?us-ascii?Q?TSrLSx4ihNQaiC4cB8G6Q9OAWHVWxvGDuq6rJxMFmTGy1JTJhhJtISs0S2gt?=
 =?us-ascii?Q?swqCiegFBGH4An33oZAsTiRmKh1VHiNpXRfhwc9eyRUwwYf8mGtaPwIIwP1d?=
 =?us-ascii?Q?TQrjIE2iIry9O+2myG5eNrWycgR8YbhvUlV3azPqD03D8yucQ1FOV3z+9gFq?=
 =?us-ascii?Q?dppl1CvATC64GisgXNDlxXmouVYbLqrt5hXXV70jrpPWBMYo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb566ca-c782-4899-d9b0-08df21f067f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 08:20:53.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHYXFNEkyxdfZ6azjw0R2DEVzaY4Q2kaL/G52Lh6sgT/4ZNaz6lrBczDa/PBSpHO0p4m3SJpGtw+r2Dg377ULA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115

On Fri, Oct 02, 2026 at 01:51:00PM +0900, Daehyeon Ko wrote:
> Commit 680aea08e78c ("net: ipv4: Emit notification when fib
> hardware flags are changed") added an RCU-only fib_nlmsg_size() call
> for asynchronous hardware flag notifications.
> 
> fib_nlmsg_size() checks fib_info_num_path() before each iteration,
> then fib_info_nhc() independently reloads nh->nh_grp. If
> RTM_NEWNEXTHOP replaces a group with fewer paths between those loads,
> fib_info_nhc() returns NULL and fib_nexthop_nlmsg_size() dereferences
> it.
> 
> Stop sizing when the indexed path is absent. Nexthop groups are
> dense, so the current snapshot has no later path.
> 
> Fixes: 680aea08e78c ("net: ipv4: Emit notification when fib hardware flags are changed")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

A group can also grow between fib_nlmsg_size() and fib_dump_info(),
leading to the latter returning -EMSGSIZE and triggering the warning. It
requires nexthop_compat_mode being set, which I assume most operators
disable nowadays if they are using the nexthop API.

Fix with [1]. If v3 is required, include it as patch #4. Otherwise, wait
for this series to be applied before sending the fix (to prevent sashiko
from flagging the issues being fixed here).

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 6ab95e19b3cf..ef3b1ac08ff9 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1079,8 +1079,6 @@ void fib_alias_hw_flags_set(struct net *net, const struct fib_rt_info *fri)
 
 	err = fib_dump_info(skb, 0, 0, RTM_NEWROUTE, fri, 0);
 	if (err < 0) {
-		/* -EMSGSIZE implies BUG in fib_nlmsg_size() */
-		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
 		goto errout;
 	}

