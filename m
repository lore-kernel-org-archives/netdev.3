Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473504;
	b=Qd4t/b7K7h07GaIcnRhnTkeSjl3kkjbD5gtSCwh5RBG6Ouj97Y456mmHeF4FOrMltpbA
	 z2opxsc9HrRTg7rpT7mINRzGpV9A0CoPJNaJJPQfHR+i7CttTM0PQe0AR0yhNLStlVwkI
	 1v8qMpRtXSK59e/PAkmKITRDWTYPnPHE+pH49Sk4kbxH6Wontaz0jiPB1jClQYLhOCMhg
	 kGhakUbn18x6PpP63j+Mv4d62p/uDXvke0uaqs984BMKRXEyMYMCy5QPw8wA0bhz4oDTV
	 /sf2EHCf11G642AsZvW85iWEt5/Dn4X++AgFfbYHBEyNVAdBwc3ZTmCy/DskUPSLySg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473504;
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
	bh=jt++C1ZNnguN/39H7lf00CEfy8uuee8pJv/ASVxiEoE=;
	b=zeH8AbRpqbf0er125NP2DjhVtJbuZB0z85GFQUtGWYtjov2fHjoGYGqfQ7vCW+eIJRWb
	 9HiXesQt/Wu/Sc2r7vyds2bTa9fBzSW0EXYh0mlHl1lwuDjweqDvVQX8upV/Afi8xJN4d
	 Oy5iLOCZ5t44aDOpSLCuF21XOBjI+4iaVkZ2eVr4iKQHvXlpMQb/tgFfDcttZFgCOqFcM
	 Zr9ihKHxgNKKlQOXj1+Hh684jId0AzxpGAKSoENaMMZEHSTNFjurmy1qc5Wg4IzMgWH0n
	 YPpRcLBc3CvVSJbEx8LB5GPpRUNK0xHIIEdLKGp9I3Vr7t7Ar6QSDTH0SVczSTmYe0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JWG8IlYO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.29
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEC606A323;
	Thu, 12 Nov 2026 08:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ACEC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JWG8IlYO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXoWjR1DcdOsluYgf0OYhxbaG0wGHGWWiKOySadYd+kCGh6SJildE4kRBVv+rUR8bLN0bGj4+J9enEir86FW2H+OADCLy6U+7JhzhXyAe27zBrFIKQ8eE/Z6RFNgZ4taPDSUkkbk/R4LaJSVLc4tJHmflljH0zGGQ7D/arXC2vzX1mjn4l0u+CSntDcXuPSMI3LPZzLv+QrN+EB2V6hPntoGjH0+oGN/ccQzPArEHaDPAFNWHwfHxG/9svWcIJTQ3rhr9So/urkIQyVY75ve6kpgEqUlZBu4MU8Q6BlZ9hfzN+cpiz4H2qeXYudyvZDXPIseq8ci6Q60phLqhHmGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt++C1ZNnguN/39H7lf00CEfy8uuee8pJv/ASVxiEoE=;
 b=UNgllfno8GYckuB1avsBRUifa9EhTIF7n2yct0E+8HN0eBdesjvxuViVnFEhnuMgdCZDChLxI7YtZJXlGU/UG9TUWBbtLBhlIckrYV4NUGfRQwBfEU95DfjGQ98CkiOU4K06JEoic+gbdYeO6ftF5PPhd/Pr/wh0rckN1DaBl27Q8wFBuqa/mkzVu0zAPumDVe9mPlQvrqlnCQD3o82ryiZ4zEX3KhhKPuzt4WQj/LEZdkcmgJiYZOTUpMDwiBhxoCVtkYNt4RnK4pcMke7WwlV8ECOV9ZotI96Q4XBqMFWf60+2DQQZy7bQkhmTSzTTHkukehSDiqz1ghCQ6Xp+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt++C1ZNnguN/39H7lf00CEfy8uuee8pJv/ASVxiEoE=;
 b=JWG8IlYODMLgWkBpKYLO1McnUwQo7bzRtdygtYcdkrLoSAfgt/sgylBohH94kGsvE2IYshcDwgT3CRlnVhZAeaJpERO4u4V8ESkZ4YRGEZb4v6ULve65MBFGTGeCbcmHN2AwElWHGdxSeGbDnB38nCveivCB/4Qtnf4u2CVNJpP/6WVdb2tqXy3s004QTC/aWmt1xPln13cy3MVCoSYwzlWCQOKLbYIQLwfvDIMx140XU5lMIUOiN5K0hWjRelpG4JJ/t23nqstzzVeqh+3vCLKNqRA+m06wlNJZl7svAPWMePc2D2wldrI2ekr27OO0Mzs4Z/U3AFXINFTpLn+xOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB999272.namprd12.prod.outlook.com (2603:10b6:510:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 08:51:42 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 08:51:42 +0000
Date: Thu, 12 Nov 2026 10:51:31 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] igmp: use the joined device when leaving a multicast
 group
Message-ID: <20261112085131.GA2948232@shredder>
References: <20261109125312.2208874-1-graypanda.inzag@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109125312.2208874-1-graypanda.inzag@gmail.com>
X-ClientProxiedBy: VIUP296CA0139.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34a::12) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB999272:EE_
X-MS-Office365-Filtering-Correlation-Id: e08c6b27-59a6-446c-441f-08df409a2c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|6133799003|11063799006|261026121527099003|261022105027099003|261026140227099003|261028144727099003|56012099006|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	FQd9LdTSpJiZhDTNgyqZry51hKUIqulqg69DPN4HcsINKqshtucBoteNt0EyX/iMa39FRKig/hixU4KiHYsNRnDgb9yhF83zleoE6Lk1Una+3tiLl/lLt6Ggzn68CTswMQJ26Fms0GZSEYZrPAw6UTU1a1ynkSNbAjnZ2hGBxOW4cHL5pepOb7sWzox+WyTo2riSOPMU63QFWWegmGiWkbcsYhcrh9/Yh4s3+c069/E/Iv3P6U9hTBrtpPJ/Ygvx5+26ndtCwPFdaOooHFFPPImKdawcOuFN9Ks/sSU/K47lb+CJXU13TjCNiXVb6LggYUwUewd8DTMNA1kgbpr7IGO+3dSxlSk0iJ+heus6gglgg4cBurCPCu/a9PY1fzxKPAoYX6LOL5tbTUPTze4QvkR8SESe1bxpYaj2KxqGwv/3NDJh6R8LRL0r218RfljTrS6ZsaH6vaJM0A8sdbqcqX8KUv8UqvQeBSCaQWL5Ijbxqiu6XdOpkV94kQ30QY+OsuVZBowkc1JOTzT25FUbkHlekMKcl4uabONChsorHQzC8QYGryeGCJgEwXn83T1ZdDGPzeT8jacmiBKVtQVInEQa3yCbuIXZSU+jomERBSM2QKYaI7Vs3YK7mDBTG/1lcbhCv9XCFEOBvKoe431iEu/cHFAbgAvvFyldPUm3mOs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(56012099006)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PYwwcw45NPv3JCAvyxFLevFQcOjOQr/thzdI9B2YEJWwlKlvYo9SbUvgIWO?=
 =?us-ascii?Q?zhjVqt84pqqSwwY+xCEqkvhyU6phK+pHa1TM7EAV5ztoq7s8LZvcdLsv952z?=
 =?us-ascii?Q?3wXxoQTtQLAQ9aQsPbOl1HO1LbS3hMatc0BIY/YNEtbqfujSU/59BHkwYreG?=
 =?us-ascii?Q?+cHdAfT9+2ocuLw2SOPoYq9RlNO/kFC5pzmRRnO9b+qoVrGD0zqDdqBrUlzC?=
 =?us-ascii?Q?ebEQzbVF05cnaEBnFO7pZOdw9trGleYCS0/bqXvVOIVwV8oQFxUaz60RWnqH?=
 =?us-ascii?Q?zhYYxGWOq8TtUw9KxeNDbanxfqfSaBPVavPFu514GD2ZfaHpI3ac29mBbnbT?=
 =?us-ascii?Q?AlLNW1SUwHQ1cbo0euzgLMvOyYTjXZ2psWVT2g7Yi8ivONP7eXATbl+0TLeb?=
 =?us-ascii?Q?13f9jVGvwv03s2D7oTqF5ixt39IFkkoXpPCVRGmQZkO/uedTO1pzyzq19UPB?=
 =?us-ascii?Q?PzmY0+le/EF3xa78VjqeoUGS+h0q/NAj0gXsxKrulQuJI0QUuDKbyjc8ZDiJ?=
 =?us-ascii?Q?QzknKI63fZBHwonmNM/v6omXgpT4RJcuyAnkGht8/uqryZIxsgPdm6xohwVp?=
 =?us-ascii?Q?GBM9HgBIvXqSnJwgefXAkDv01HAQcwz/I+i3WU89AYkg/FPabW7zDc7xB4B0?=
 =?us-ascii?Q?DhloGtgE6qNAu/j4I99Y1ja4mDOLxOzOsvtagyll2yoN/KWpAT8Rljz0S1Ie?=
 =?us-ascii?Q?RsbVp5ic0NMqzSfoGBeZ4Mj1gQ6+opVqNJATHgu0TuKpaRHwZlAr2MwmIPN0?=
 =?us-ascii?Q?1l3/cT29+Wlk/Bkk312d6KAwU7WjSsjXgn7GLrGgwD3hUBmQ95h4ihTBTBtE?=
 =?us-ascii?Q?TxI/sdfxuj2h9pHZPp9r8xhZcgJCJY8McHxAmfEzEgNHo3+55wkYgnixTlJz?=
 =?us-ascii?Q?ZJGalfUY4Z9gFcgOiGe6PVv4Ncmg9EC7gwrzF7jX9YNjIIMjV9zYlyGRsPzJ?=
 =?us-ascii?Q?I5D63NKZZmhmbprJ4wyV4Y81i575S3iPOPJhEdGuKiJppVnXeRGTo2o2Kace?=
 =?us-ascii?Q?8huGWxcQabvXRlArWoDswCYQ44z0jScfkrk123RIEfyAL7Ts+MaMdT+y1jXw?=
 =?us-ascii?Q?0rZs0DUZd7fdEvGadXP6jypgMYTTGP3xWC3XxfIc7yksMGAI22DJktAcb0oG?=
 =?us-ascii?Q?Q2UCJoSlmhxi59fC7CATLfEibU6G+uAmnV6ZNW6qR3E21ADxfLOJrs5Q+CA1?=
 =?us-ascii?Q?9VSU9947ExerhsB/yXgkPWRQA1xbm1FdlAal33H7FO42hEDOLaYyRJHRTrZg?=
 =?us-ascii?Q?RVyYmSrsWT22dKJc/Vk61mX/t+0biX3LZQk0qqXvHrhz0V82kWVrJ+pjyWFk?=
 =?us-ascii?Q?4wlKVzaTBo7BP1dQUT7FB5/AiULCyZpQF5gEjoPXh5DKw8GzWNM5hMlahQpj?=
 =?us-ascii?Q?jeVYgw9cJRIoEV+miAkbkbmushwfJmCEXkuVlC4B/xJb9pAvVWBKQ5DD3OMP?=
 =?us-ascii?Q?uylVQ8Ug50xNL6jiGA6/o3e8pSgaDQB2vsNy1HDozU38WSjSg9LbDuTxymmm?=
 =?us-ascii?Q?/2NEN1DIjV5jg1u86I8mlU/YUAmFMzxiWpjNc8kF+eE1NVno1Bqp5wf4Jjq9?=
 =?us-ascii?Q?owG23vf5gmSPqALz0cQZqlBsKFqp9tC7HBTQ+I8QZSI+50gtuZEFZHUiOlbl?=
 =?us-ascii?Q?iUDWdpCOreZxAp4hqwLXwBlglB9PC0dq6cy6GnN5Fgs5tNO2pzjpNhLW1iU0?=
 =?us-ascii?Q?cEaCPvv+tFTuzLTOYAi8S2y3/ndY6/P3ss4P+J3otbABkqMq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08c6b27-59a6-446c-441f-08df409a2c1a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:51:42.1269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpPksRFYUcX4LhOYSikYNkXNN2K3wekoFJ5bFRwbM4hLnAkxXq5sxKUArSn5WENkulVA7cO3GLRfFq2VdfqKgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999272

On Mon, Nov 09, 2026 at 09:53:11PM +0900, Junyoung Jang wrote:
> ip_mc_leave_group() resolves in_dev from the leave request before
> matching the request against the socket's multicast membership list.
> This lookup can return NULL even while the interface recorded in the
> matched membership (iml->multi.imr_ifindex) is still alive:
> 
> 1. An application joins a group using a local IPv4 address, that
>    secondary address is later removed while the interface stays up,
>    and the application leaves using the same 8-byte ip_mreq.
> 2. An unprivileged user joins a group with a 12-byte ip_mreqn
>    specifying a valid imr_ifindex and a nonlocal imr_address, then
>    leaves with an 8-byte ip_mreq containing that nonlocal address
>    and no ifindex.
> 
> Because imr_address is nonzero, the early -ENODEV check is bypassed.
> The loop then removes and frees the socket's ip_mc_socklist entry
> (iml) and returns 0, but skips ip_mc_dec_group() because in_dev is
> NULL. Closing the socket cannot release the group via
> ip_mc_drop_socket() because the socket membership entry has already
> been unlinked. This leaks the interface's struct ip_mc_list reference
> and multicast MAC filter beyond the socket's lifetime, allowing an
> unprivileged user to repeatedly leak multicast group entries on a
> live interface.
> 
> Fix this by looking up in_dev from the matched membership's saved
> imr_ifindex under RTNL, matching ip_mc_drop_socket(). If the interface
> was genuinely removed, inetdev_by_index() still returns NULL and the
> existing hot-unplug cleanup behavior is preserved.
> 
> Fixes: 4eba7bb1d72d ("ipv4: igmp: Allow removing groups from a removed interface")
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

IMO, the commit message is close to being unreadable. Simpler (don't
respin):

"
When a socket joins a multicast group, the ifindex of the device is
stored in the socket's membership entry. When leaving,
ip_mc_leave_group() resolves the device again from the request. If the
request only specifies an interface address and that address is not
assigned to any device, no device is found. The membership is still
matched by address and removed from the socket, but the group is not
released on the device it was joined on.

The group is then leaked on the device until the device is unregistered.
An unprivileged user can trigger this by joining with an ifindex and a
non-local address and leaving with the address only. It can also happen
when a socket joins and leaves with the address only and the address is
removed in between.

Fix by resolving the device from the ifindex stored in the membership,
like ip_mc_drop_socket() does.
"
