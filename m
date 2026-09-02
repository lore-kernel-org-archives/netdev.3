Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F32F12AB
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359447; cv=fail; b=qUSfyF/+dETs3/Nf8+kyst6ncCXMjFhOcKm3n9cRPgHUsxsRHR0gX1v9KIA/YAblXT25XMA/jL02gjs42NxhrbJEowGVrInZ6gcH6UtzrrfAsWuHShJU7OWfBQ5yf1XgL1tQse27rQeIcEn2sb1VyHjG31ovCPs0cVEXGWX0y1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359447; c=relaxed/simple;
	bh=g0KVZSwR1srYMt203u9wVyA7U4q4qwOCsagtb53kz/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UpQey+hnEp7vVb7SW1lFR3wBKJMGcEbIDXu4BntKWhHijyuQfBmmjLqPMH+sbxdDkm/qL/Q52ZjLYenGbndD4dWTG0PlSyqf47dWa6+rynaO95uZYSg9PK+FrZvz4YuzP2PyqyaylZEdcWblA69yFQri5xfvGfwExmhj8/c9iqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHgDioaH; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHgDioaH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2pjlNRkPVelAB1HKlloSr7Kev1duistvIp6fGFbx3gc/BPj9WxZMPfdq17a1mGVUf/eljvVUw+/lVBnCJn/dFq7s1YBWCd3bD42Apd8RBGhAdCT8dBm7UuC6B1ARoBpKCQBh6As5MnVs/FKBJSOill0+nq96zxVdNTe8nF+mPj7hF1sE3D4h8uMx0UiPM8ebW3p3gMqf4gZy//8K+VsIAMbxz/5MVTf7N2LrVFiIq3hWMnU7nZubga+nwue62Kmtvh8atIm4v19cur8X02RaTLL6LmeclXEaq3pr8lhR2TbFdbA5WHiCZ4rQ+u0qIpG4W7jo6SbA0HKERB6OLGbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HL3E3Q7ktrxMfUmoQLiDEys6XmKwlczpJ4/jNYlYPc=;
 b=grsv1iYFWJRPS9FkdvP4HZsbKxeWbMwvYKrOliNCk3JJXxj7RE4tdBUShpazMJ9NVmJYWt9hZyqEH0Lb9QbdGEvwjWyOIL82szI0Ji8Jda8n7jeGJ9VGcNLzF5jb7BEUovNgXZLUFUk0Kzv4pjs/oyPGy3Ivz45G1++N3xyrGOL+FB3h/QV3pcEhOVQQOS7WZXC+VdRf0CFjknRgoUyj/7CCLMMEL0KVo6Em/lMty9/leXczFwxptph+TTCCG/NirpZOYR9A9VerQNVq/PzREAj+97FM99LyOAs+PjpAxSdhpOUg8fAZVQFfghHRcTzre+tFZolC9aooMNYicsnR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HL3E3Q7ktrxMfUmoQLiDEys6XmKwlczpJ4/jNYlYPc=;
 b=iHgDioaH0AacN5f97H1WcdazvIpYJCoMVFmdUdI5HFE1IIAS2IvtQ4fMtbkzOFteBSEQKaS3spveWt9QPZ4oEGKLtzPHXM7InctU2U/7eMvWIpqex1iXbp1IGsIkVuFwJUOGzfc+zai60C/EIWoUpw+oPcNN5+QnKG1kxnbGso85gqs6zXoKlys60poHya5pK6S9tsm67BzA8A4GTsSSKPXrE4hbLJSb0uY+hdnDkLcYNy4YUeZhXFcrDDAAXxQCikOnXa6W6dXBz39DsVK9KACabHgtNunQNRPR6eKRENyNMGrk8cV6P2Oia2genHmmfPr4ojH834cOt/MOdRWoig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 2 Sep
 2026 14:30:36 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:30:34 +0000
Date: Wed, 2 Sep 2026 17:30:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v5 net-next 00/15] neighbour: Namespacify arp_tbl and
 nd_tbl.
Message-ID: <20260902143023.GA3966681@shredder>
References: <20260901183327.3332855-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: ead2cf02-d7d5-4207-e3ce-08df08febfd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	0Di2GIbof8MsOD5EMxxIO7udRCUiEoj4NoFkhO8gJsgUhGVKINDvn+7JoJsIcWTJIW5iqf5KsnavIk/cA2oHkvRAJFOBi55NDHnzeD74AYUD873/i37KIkn9EMgKbgAoaxFtp6Vq1lxoMx+inVWm+/PPHjNiJOyVtQO4jSvPqLVSBIw2s5+9nYX7bK3ymcDh1U2Q9oWNjSI5wLsli5UK0VQdDpexXCUYiqT/uJNBx5EkQY0kWlCvB4K9ZZDoe87qno0brCYTooIWhS3/MefktQVLlzsMEJZFZGHxE/aUfrrZZBKJ5/mWR73lteZOQpwpzuL1y+a5xaVUaACzHVoW5kTAGTcs7GF9Juduu32LVYVKK/ZlWNheBoBncl2fi6gup9v7EoZzxxmV1sfMMkp265vWIXsG+EWfy2tssnRYw93+jKkgNtCssbHwSzWzazorNEfGTJ/IkRBuiwaxTmYsK7wyAdOe6SxZl3axvmJi4SreKyd4pU896mRzyUIbPkuOpGZA0frkcM8/Y4HVUVIop3wDvkBDwf+ZIhTA3y8AkSoQMnRbPaSHZeBRH2PzUtsFY9rzsxhSEX6T7FtzghKtg1UPFvOrqF5jxhliUZS85iavsMkccRZVLK4LRAY87nX7HCHULe+F+RBlBatKsc5MfrMLES0Kiu6TRI9bNhq1I8U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VcLIlrv3QUKHylLnJ7Pbs2DaKe5EFnArcV75mMBBnEThictzw1Ia7JCMKaYr?=
 =?us-ascii?Q?Aw0nNXfDqXVWJrnBkeIYGifUu84tHggK4I3pCtLgCc0QiN7+hQXbTLarbsHL?=
 =?us-ascii?Q?SB6+5fF1O4kThsJyFYvh239JwvRk7czf4uWyVuAGbn4Rvh7Eh9iq1UpwaiC6?=
 =?us-ascii?Q?NBrRSVlGNaBlf2zZLmHHofGzJ0S+3xrey8OIPVu3oSVwV9397LB3b/xBN0q8?=
 =?us-ascii?Q?xeFOw4v2zr6PKuiS8F24rGd7ZiyUdIjE35DC40jCADQzgTbPlb8Lenx4Po4D?=
 =?us-ascii?Q?aH6EJAuQEDIOPjQT/4HLlQqAJDfgw2WE2jDqrXscUJLnj0gHVd20rGeVdgjL?=
 =?us-ascii?Q?gXha1m+YJ0szLgZTcxqCAqLCNgkOgfUD71E8lKj5Z9RroFygX1qi4nia7ZT/?=
 =?us-ascii?Q?e9AzRp0rsJ6zyl9Dd2QcFg2VtLIT5vJUhBluguZbjz2mL47UQjQ4MVYWzhOv?=
 =?us-ascii?Q?qNlsNwNZ/HLDpimrP4T8sOqNicobO/3T8Pdklxnf7BKIILtTEoZL/nRE0sZ/?=
 =?us-ascii?Q?HE2f6HYj/sPPMOIda4I1Q+CYmpsek3G34z/VaAzFzgg+Wd9iCSqASembMJZK?=
 =?us-ascii?Q?XRTWSDG8pPrFGxDvb/HaGYX4NAgFTDdF9U/w/pu14vRYXmCeTwv7CSsQ3LaS?=
 =?us-ascii?Q?QjSfTyIU3glrKnaStxk+uzQH/ykhQxzRwml8GqOgfxRIDQiZkNg+fAe92QPb?=
 =?us-ascii?Q?5VENMYDSggtDysMjb7iIGMW0HZiaf18LJo74+DhL6zkLUAfLDOqi4azMgcks?=
 =?us-ascii?Q?kj2Fi11AfnKwcoQgmkhl8AJC8pxAc0Hh43yMr2Ae4bol+JLGtBletkdLp5il?=
 =?us-ascii?Q?mhvfwO995hTztWYs9Y2VnMpfZ5KrBCFoD5ozU4wgokl+yCvd/yL71T+GpogK?=
 =?us-ascii?Q?qbTqLK99SUj8DVC+1hmDRO2xh24BudDfnIaeY8OcTgVmWorBoJb4iaw+j/65?=
 =?us-ascii?Q?1WFEQlrTym1cMK1ZaKbzRUHPEBS8S0nP/EQrYSM1YccgcSnt1WQFW7UiN0nO?=
 =?us-ascii?Q?H7HcrPa7pU16vfUxohdtJOXia5fbjZ7PDn04Wja2+NvyAK+wJehl11OgA7aK?=
 =?us-ascii?Q?316NFY6Xu42pGcYjueMlcmG9P7blEPCyEwpkq3+JZu2uQCwdDKpwT4G8Hhlv?=
 =?us-ascii?Q?DHxvrYOYRnBWx4vHMYJ9eBd+EcLAxW6iCiIW6iTkxK+vFjRZGj7dsFtq2/zI?=
 =?us-ascii?Q?A30nmxxhK/Fjhwdv4nIr/fP3Kfns//RbE4k4xdA0nQdvywscElW4MdtnCGhw?=
 =?us-ascii?Q?+0IssLuDjKom556sjh9Pf/pR8c9lkk0PnudxKgwLBAyfV6mZGl2Hjdss7kR0?=
 =?us-ascii?Q?o1j2+0dvqVOUpfl3cPmKxFu2T8BZmrUf9w66l8R6rdZTkht5qF9AldohxYJL?=
 =?us-ascii?Q?LN8ogh+Xq1yDbSMq3BJEeNpwny9v37Dtkvr7uHNGW5ruSNMuQ4PJPLEkIDxR?=
 =?us-ascii?Q?rYFyG8IyA2/32+SxBdFe22G8QUyMWiqwyZF+v1e5/fJKmfuHNBbMPNS23LP/?=
 =?us-ascii?Q?9pS7IZ3q8e2K3G1LCkXCYxJQxd/hbNYpqxG1BXaAb0wZ8s55EsGQsbtfbwB8?=
 =?us-ascii?Q?NaLv692IyAn/IQAdLbSCkhwqd9m3Uy+ptgTWV8lphvjAQ5y4FoaDpwB2u5D5?=
 =?us-ascii?Q?C9aTMf0PH9wz802CWb5xXcXg1Y/6+fo6vpPgj+ti4Ny7ZRzOiKlBZqF9zn/R?=
 =?us-ascii?Q?ondIUgeEYC8IVS77aXMvQ0TftAxZVkKdlFwzqTv9RElJfNdI9OHQs/oDbdgg?=
 =?us-ascii?Q?LQqDJIxnxA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead2cf02-d7d5-4207-e3ce-08df08febfd7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:30:34.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPR+wSf3a0dh8/MteHWIcPQhcuoSlCsYnIK18/XLgp5p6YCffYNbRfNzcynPUaud4OEJu9KDopMH8zLdm9tbaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783

On Tue, Sep 01, 2026 at 06:32:49PM +0000, Kuniyuki Iwashima wrote:
> The neighbour subsystem is almost ready to drop RTNL.
> 
> However, the control paths are serialised by the global
> per-table lock.
> 
> This series converts arp_tbl and nd_tbl to per-netns table.
> 
> With the series, /proc/sys/net/ipv{4,6}/neigh/default/ can
> be configured per netns, which was only configurable in
> init_net.

LGTM overall. Two notes:

1. The two periodic works (GC and the one for "managed" entries) are now
per-netns, including their intervals. An unpriv user can set an interval
of 0 and hog the CPU. Previously you needed CAP_NET_ADMIN in the init
netns.

neigh_managed_work() already has a floor for the re-queue delay since
commit ed6cd6a17896 ("net, neigh: Set lower cap for neigh_managed_work
rearming"). We need something similar for neigh_periodic_work().
Something like:

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 27602bcbeb69..17817e30944b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1038,7 +1038,8 @@ static void neigh_periodic_work(struct work_struct *work)
 	 * BASE_REACHABLE_TIME.
 	 */
 	queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
-			      NEIGH_VAR(&tbl->parms, BASE_REACHABLE_TIME) >> 1);
+			   max(NEIGH_VAR(&tbl->parms, BASE_REACHABLE_TIME) >> 1,
+			       HZ));
 	spin_unlock_bh(&tbl->lock);
 }

2. Related to the first point, we are now going to schedule periodic
work per-netns for "managed" entries which are quite exotic. Better to
schedule it only when we have such entries instead of unconditionally
from neigh_table_init().

I think both can be done in a follow-up given you are already at 15
patches. The first is more critical, obviously.

Thanks!
