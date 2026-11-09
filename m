Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794215118;
	b=kyF1FHGsDeGWDyKDZNPT4RQLiXd/xmYAfNJ0TtNVwfaBPYkK4xMibTBhUvwY6/aBMqW9
	 DHtSsTgGtUoaS66dp2ExBMq4Q90fN+KlI5faTBnhd8+BwS/Rzy7EyFDQxSge4aw9r7OoL
	 bItowdu9OBZvq9tTwzlp1FIz75pd045TWliIHnAMh3mM/BYFh2WF3Q1P+VwFNRGfGckeO
	 6O/Gasn49oUmMB9+4cjwPP8Q4gdr6NhXgLEI/wojDyj4Z0hJSOp7MasUZ5PDCWnAgv9MX
	 xEkpnACa7BN8ptQbVDkLNI4+P461KwAl/My+u33SZZb1otrS0Cmr+Ihy40QOpsD3VmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215118;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HQch/dRFmzcyBN8tXONiT70AyKond+X4j45yJyf7WOY=;
	b=jceH3eBNZ/coKOx5KQiHlGVsUjC4MxHBmf9df1x4cNYD0z9OITUcZPxLKhC1MkZbK99e
	 ZA60ftcLP/qPGTMy+9nWMdH7Iy7D/HOAReqAK0UWbH8pIBCxLNsNUBMXxkSwB3nRBfF+t
	 VoFNTZCm/Yts44ftBH3n142JX6Gt+t35cZ7vuw+LW6aNbU0KxRn3ZqLVw8cxGz3Lu7lDK
	 bqfJ9Xrnbl3G/hl0MhWBf+oCT3SMgQWfXUDChq3jA34NbifAU4zBsRcFCoDJD/rzEv+5c
	 U48hOIb2DpH4QhhTUvksGrNWOa2uGf6N0NsbqP6/PDzwtdPZEVvZTbFEnr7RbgRIU5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RvjVVUlw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.35
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE0606A31C;
	Mon,  9 Nov 2026 09:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FCE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RvjVVUlw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdkgUPG1RvFtyiaM/zt30hjyihYOuAf1FN/Ercp5+Q3mJkYC9LNLpxwoVUPpTxpua2H3+MEdVUY0Hp2rkNmMvzQNqGrHOkJTTYfQlYJb1/oUEq0qhWjYRnn49RsxaPlXSUlts0AFwAC9gkLy2jCz1xtY2SzvRdCAe78iLshHq3PTJzFsB9nxZa2I5Py/9uxXyiHTadPOP8isDrv51RlxHkdc4RTXLQJri28c4UKunnkO1JcEIBhYNh9gimP6I97eWlZHXsAiOCgIU1kiElQFxPyFWmtiVnmEh0CZlN36hexStiI9Wqtp8nG96L35HNOPxVBjsrsymsGxVExOLDTMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQch/dRFmzcyBN8tXONiT70AyKond+X4j45yJyf7WOY=;
 b=IMi44hRnUnadQfW6C8CLj1AqEqOTSST5vJYdTWlYtLCSjxQjAVMoCYQvqnVb2piuvpCifQEpAhtXNqMh2VeBol8z1t0zUF/Y/h2BpZWxQGza+a30P6ffz3XHiD8DvS41yg4wapCAgz4fhKbwU8IOXYeYDxS//CtFSnp/o8sedYE46kviIE7pRmQs5c9Bi40RVYkBr92yLIZlki90kRaAHJLt8GjrsC8t7/NBjX9YqQE962TDgEg8F96N0UzRGQiwAQ8jCGSKwQQdU5Of4zLL3OVIXT6gxl+gXbGj2fz4RK4Wq3dj7AqV7rLbeHwIZ2RIUdaFDXJMoTtqpDlr5rnaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQch/dRFmzcyBN8tXONiT70AyKond+X4j45yJyf7WOY=;
 b=RvjVVUlwjdECJNwed14KKzbTTq10uW/xrwxk1uO0RAXjqiM747geGKv+XHnYdo+Uhsk8ui+wd2bj+xrMux5qR6prUh+5HpFhJpxR+dzUg3VmFfZDsLuUbm+FQ612Dc9NQ//vJ2B8Te/r0JU9imDXDl84dkkmJ9DaEwupk50KFcmIQUV9q8LC9X7Kp3Jf9lfFgs4qqLHJgkSzsiyU8h8j6CFdWB3XpCiuYZ4fgiheKJGdQeja1j/CrB9fuqOjh8ZBQAds+X5PXIMjKH5SRHLj7qvyj5juDnH8TVrsajtw3ISsY52VmnJlHQ7ucru/tD+NgUn8Wrwmoz7R1Ebdnqm9tQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:05:14 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:05:14 +0000
Date: Mon, 9 Nov 2026 11:05:05 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ipv6: Add NETCONFA_FORCE_FORWARDING to
 netconf messages
Message-ID: <20261109090505.GA1495012@shredder>
References: <20261104-ipv6_add_netconfa-v2-1-6f660990062f@proxmox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-ipv6_add_netconfa-v2-1-6f660990062f@proxmox.com>
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 2482ab65-cab6-4d94-f641-08df3e409111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|11063799006|56012099006|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/1eDlpw+DMNvKxU7OnR6gcgPQ+DNQO9uJnCoAOBoarJJCMlhjI6jaD+6T9HEsam3bOLZTySwNP9jOWO9h3YFnIyiI9Zv89n3DrrjtYgD3QknXw6RNqs23pcYdy5dSVUbjfrz+XcRr4Uit7iZlAPM7j3uvRrQR00MMHUnYtgPTFAyUrwBahIX/NgIBWSk15yLNjH9svt/3qQrCFlf+LC6debM3aP0zyoasL2MKUgRLJqw0Q9WjlAQ33l/fLtypz+OtttWi4acSMRyLwAMJf4SndErTbbpIH48ZjLPJ/3MJDv6pjPtrA0dbNKjFy4otej8sP4hScgRDHv1SZA6kiWMxISMAx3xAZRTCGk0ZG7AMNlaDCXDO1t4gp7wBIEoplAPaSLauKac1W51HRAYVYhULoUHxm72SyPPn/1cWzJOkOjfWVHpV6n2Ag173mRnS2Q406j3eoYA9EsoFi1kE/cSj2/8voVtfOyVoPaIsLxQu5xr+4rQ0yen3fqn90GIRdrXdrHYz8li+8jWoQaARqL+BiEWTPZP9YUrQDbAkUGmI+JXdFjF+VtReNAothlUUU8yrmR49TVKmHfRLwveP0KXLStALkTJZiZB8kIsGmRgp/R5bmwGIa2yQ4rdhgZq3HDAZ5WcyMYMHZUrWLBtz3xPOt8Es4L+VdEeqWzff296bpI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r3kXXjw+ztwhyQAyveo65FNr0yf6fK5Ew1DsA3ihriaDP6YSpcbO39iAEpKv?=
 =?us-ascii?Q?bXoQcgj0zkutpPmC4ma0ptrDqR3r5osa+Wvr4aSunA0yS/olYrzTTjTMTTKk?=
 =?us-ascii?Q?Zs2nO36zkwz18frK6yBVGDOrNxahHmaWJbzzjoBg4ZBQ13Aqgdr9ZCCKHxxt?=
 =?us-ascii?Q?D96lUdtWBqliTr8Cek0xLc9RbU6eoqpx1ZhnbZzPEpTXGrV2osCPhJUZO6IG?=
 =?us-ascii?Q?dps3uJuxO+eNY00ydPxIE6ck5E3RnV0EvlelnCYUu6V6+8NgZarivgWPcOA2?=
 =?us-ascii?Q?KlwFV1tyU5GGQNXLp3YjqOHura7OBZmU09CXf2t3ltNZ/9ev/MDIDay2Ma2L?=
 =?us-ascii?Q?oRxQieG85H+jjRsR6f2VfL8hMNTJy8TsRL4J6RvfnjSavaq5nfbW7OwJHqYx?=
 =?us-ascii?Q?dRDnIj8Np/YIjrKfsf8tdTlDhv2S3BnZPuxiKKGUOCxXisABgE45S4Lja9uM?=
 =?us-ascii?Q?RqBYQiB7S13jH5ThHA1gMpgjulpht3ySP9zcSjJEyG/DwnTClatvtJI6YY3N?=
 =?us-ascii?Q?UktWA/o4++ihkl7MREeqw+RZndQ92rlzSjS5huswtvARSYSKv2Qo/9oDWyTw?=
 =?us-ascii?Q?90pfaJulmiFKJ3mPeLJpwizLXuJokmwC0OlrL2TU3Hhkur+S+SYPGeZe7Kqx?=
 =?us-ascii?Q?sFdXn3nVli/3jhGApUyYFoXhSHgh0qDGyJVY6ekMfqyoWO4IJ6uWgoJMYyxz?=
 =?us-ascii?Q?MddDe8HzsmLnvgHT42l3tqnSm8zpSHADK0MvwztbCtQETfDC7QLfZLhefAyk?=
 =?us-ascii?Q?dFr5EBqNW6Iz0fjL9nDk3RxeKmpqB5vrXUf7+KnJ5r4YtYQhpgq7JZ6IDUpv?=
 =?us-ascii?Q?ysFwvzW7eCqMz/aiApFklD2mU3fiJRlibU1NJivn+QYSMDDiND6ySnwSusV4?=
 =?us-ascii?Q?thaQ2H9BaAyRORR2ckE53kdgXZQwb9YZd5JbRBbyF6uSZlYh3CqdkJsnaYMe?=
 =?us-ascii?Q?EBNzs/fVEqSt9HcOEnedBa0GSrMJxZieFSSubsfjA4jx1IZU+MiLMvfjwo/d?=
 =?us-ascii?Q?N3zoVT1Or4/ANIPbx2dfTbaEw5nPZIuy+Wgr8jhoevPkvsabIS3WpSoJzDnF?=
 =?us-ascii?Q?s/XGuo9j6XSGEo8EorHur2OoP3MpmJ9erVwXR2xN6LijmtPsoOelsJgYgl9h?=
 =?us-ascii?Q?4sJV1WGR0idTGYgRdv8c+aRnDEKyz+leO7DZLs+MiLH2YWRwaAIxKyhLkljk?=
 =?us-ascii?Q?ehdMU8xBFDhMwJCOwYhAShkQr0dYYClsoK39QkGIyGTviuPyuoItZ09BUj6E?=
 =?us-ascii?Q?mH8Jdap7wiW3zPsjB+ElKDY5s43fqBmN98h7QGGNK354BWlnit5z8sSVuQdn?=
 =?us-ascii?Q?X1VvSgodojnn0Qx/UsG9d/6Ye3QPG8R0xeOEMdExRWsL4lo4fS/qZCiJRGV0?=
 =?us-ascii?Q?SxeD71Q3nRebZcYQiDGqGVabQL/oy8tdG8IR2S6IJtq8t5cD20Ad3GWEALF9?=
 =?us-ascii?Q?AP6tDU+/XIRnHy1mG5SiRzuxi14/kzYZTiC2lsQV8Csod5OSsVx3o3H+rRCs?=
 =?us-ascii?Q?jlIYLgEu202IiAbzuZaQgLQvTT6aThqPZpT1wHOqg4u6xjAqN2DQA0ie+BN8?=
 =?us-ascii?Q?6ynDTYMIPuFO2DCJhxt9k52Tn2tDpB0964oid0NrrgWYmRwwLbTfopVqBSmS?=
 =?us-ascii?Q?VLRxx5EynTJ0O/HU1HengmR1FZoIWPaV2Kjd7TvECdWVNguqXEo7wzXdHm/d?=
 =?us-ascii?Q?QS9X/VafbKx5tv/MiyXgpll+O45JoZVLFohfBL9VdVZ+pxq8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2482ab65-cab6-4d94-f641-08df3e409111
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:05:14.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvjvT0BLPONn0On95s8JRZ7/aOLqy0wIlSK+3eYz/em3OA/crTO8zvLrU4wLpaqPLL+pBrNy1BUKlPo4mg/RCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311

On Wed, Nov 04, 2026 at 10:46:10AM +0100, Gabriel Goller wrote:
> Since force_forwarding was added, changing the sysctl sends an
> RTM_NEWNETCONF notification of type NETCONFA_FORCE_FORWARDING, but
> inet6_netconf_fill_devconf() never emits the attribute. Listeners only
> receive NETCONFA_IFINDEX without the new value, and RTM_GETNETCONF
> replies and dumps omit it as well.
> 
> Also send a notification when disabling all.forwarding resets
> force_forwarding on an interface, which previously happened silently.
> 
> Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")

Fixes tag on net-next is only valid when the blamed commit is only in
net-next, but maybe Paolo / Jakub will agree to strip it, so wait with
v3.

> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

There's a report from Sashiko [1] about a pre-existing issue:
all.force_forwarding not being cleared when all.forwarding is cleared.

# ip link add name dummy1 type dummy
# sysctl -wq net.ipv6.conf.all.forwarding=1
# sysctl -wq net.ipv6.conf.all.force_forwarding=1
# sysctl -wq net.ipv6.conf.all.forwarding=0
# sysctl net.ipv6.conf.dummy1.force_forwarding
net.ipv6.conf.dummy1.force_forwarding = 0
# sysctl net.ipv6.conf.all.force_forwarding
net.ipv6.conf.all.force_forwarding = 1

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-ipv6_add_netconfa-v2-1-6f660990062f@proxmox.com
