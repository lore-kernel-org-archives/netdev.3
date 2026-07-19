Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78FC377EC1;
	Sun, 19 Jul 2026 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784443051; cv=fail; b=KfzuMTB6ieO4f8uXNw5hJW8o1APxIeG3JfpXdoxt0fN7XGMBqA9QynTEZm5MFXd94uRp+tOjQMQPspSCtOn75ydIOBqb0Zb3aecuw88jNHmbKFq1GtMYFXJ4+mgin4BHH2YpGKcSCX2Sb+8JXhZbP2EIN2U0o7BN3+NCQLrhTas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784443051; c=relaxed/simple;
	bh=NSGws63vnIOBphaOEiMLV1fSCswTKHOprWCOOcYYvnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ShXgfEadpzq9Qb8D1iXy2N6mbo4WybEI4eQDGsmzLHhZ+un7c/y7Y2B8KqLiVP546gBMkF8r+J5I1BvoqAgCYGo2Mz37pUm7AfiphEIjITVIVVMsSSGUhN/33a5L7Hx7t17uBMSzdFPZjVpIYnaO+EZhFt3Wye+Qwh9FDyra7Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S6eefGRE; arc=fail smtp.client-ip=52.101.193.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S6eefGRE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmaZO847TXqDEVq1Az2B1zUUGJC2yDIUruJJ5IG6/Dwqo46+13bApTwrslItgpIR8Sh1FYPwHNXTNx9ZMP60IeeNb9t0RWUNZPhGj/CGC+ZyMg4Rn1U+a/yO6X5GNbGAGNm04hY6219JQIp1SdClJvYBAFzQkrxdVt7WrA8RdQIUWTaoY70dC6ygLjoPmRK/VIk9/f+soJjxho15rCT0OwsgwMHVcYQ2UHL3FItxA3Tx0GXkMUuKuCqZJGe1ui0apSxBwsUHb9372egE8wWj7jN4XQXY4LqF50Wj2wsYw+IPQuw9PZn6nCP8hEfmSonwBVAk1t+HyyigtRibHsxATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUKSo7moZ9Y5hftZxQuu8u1dQP84f8OR5r5d26jj3Hs=;
 b=vOKVil004s/mhDmu7XsimVWc5+ctuLYbICvOyvHlj5SzNUp/BnIuLHviWyFo+0D7Oyha6iJ4beweE2qx87oAVce5dWui4+DdXc7gvsmuhl+dr/OQYSiijpcyMWjrCmL7EYTOAzwuQWzzYgH0kPKeSf5x+PEFuLEBqLVXDeVDMVWo3oTqqQedMZIrDpjmnbE+HF6Oxg8nOkvqXgPFdUqHpCJFALmE3rYQZVyFUXZ6zNrSVXrwvJmqARLI/9cF15hE2nbSVhR+ktlVoXMzMSc70Ie3ld2LaSf7AtVqPRKsHATCHgUR7Wozv0GoXiWphUjkXHmDfqUfw8sqc5I6Flq6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUKSo7moZ9Y5hftZxQuu8u1dQP84f8OR5r5d26jj3Hs=;
 b=S6eefGRE+gzi3zAlJ6RxTC1fhHwjCvEhvLTxvBcucZ41ac55ZGr1RUjcEwvszlTVyMYoukUOfRMNEStKpTEqeW6WqG1beolfBWAwPxQWEsMiUayTg0AJ2kL3RVJfKXjEmZkkuu26dHYDh+L/mNs/bIe7k5FQEi9LY1eOikqDrTGO2yFWBEZnfWFprN5VpP3EfcG2MbBnj6sJ2tqYjk2ao131jSU5eCADPk87eicN5JEaGmN43/UUG4LlHeQsCsN0Sg0jUvIzO8opGsTSTZSFP9NyPyMeZJmkqhWlx4e9RcPT8PTVdeTXP1XDN0PFDvBygHaim66+XBYLRdR/ULzntQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 06:37:25 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 06:37:24 +0000
Date: Sun, 19 Jul 2026 09:37:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Xin Long <lucien.xin@gmail.com>, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2?=
 =?utf-8?B?XSBSZTogW1BBVENI?= =?utf-8?Q?=5D?= net: ipv6: fix a potential
 use-after-free in ip4ip6_err
Message-ID: <20260719063709.GA1841238@shredder>
References: <20260717143315.1942-1-lirongqing@baidu.com>
 <CADvbK_cEUR9m-QyKi5jj2MTqF2kGbBj7d1mUXmCsHgDLNJ-bPQ@mail.gmail.com>
 <098518d8f02746a0abeec70110dcb5b8@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <098518d8f02746a0abeec70110dcb5b8@baidu.com>
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: effe6337-39be-411c-6cec-08dee5603117
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|56012099006|11063799006|10067099003|4143699003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	U80AFFOKiKYJz8PFU30k9YBkZsz1LieyZfeqaQjdMwL5lwuJdmOJBq2AdGE9slePfik0YMUTyPpxrb7c+kIXgGceWeSWL5lGtzEt3HAhypKjfXZm3xepLyoFS2WtmlVAFAvMmkFVHfC6W8G2+JoMz11TUtJHZRROYsADF6VWhQB+xV9slK/yP7pVmaSRTgdGf8lxKZEr5leGj/JgcnXMemMe7YMScCdnr2m1a9qIp9q1i0fFm89xBekXSpKaobXBsS+W54Aq8OGC8MY+LtCu3s4vXfk3w+y3Fm3GbxJzgPdQsNp57z3qKm41lkhGooW6F1f0vy5Yn6Xzs9x+uwfy1AIhzjyx17O2oBKJDnLkaCSDkj0grzkaIhgTrkVgJh0P5+0LojNrkhLCyn7mWY7oyk9tWOGHLUtGAnclKhPkwwJ9LXlVAnv92QsrpKSzFt9susLrdK+pog2C9XS6j8+VZF8fzGKO5s7CP3wvSDZaNZmV82XfTiY/WNgX+n0bNAopiq4R5KZtYuK1x748s4xAnODbt+4O3pQ9N7qRdFQXw5agvJUvbzSvAuA7jSBzg+x+RmRU/PQZ7JR7iDwwof1lUO0FBK5uBNtnuj1DP2subhySxzJuzBaas+m0hsshuneHKvqXc0IMiBmJNN2nzyDIx4lB/NmtprMnrnrDP4uhwF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(56012099006)(11063799006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2JHNWlCcjgzazB0cWwzK0VuK0FwNlV5SFBOcENTTmo1VFdaY1hhU1BITXJm?=
 =?utf-8?B?MGN0bWp2VFc2bmwzMkdsZk1qRTRIOWxPUVdiYTN3YUJiY0FRWXdtS2ZnZEJG?=
 =?utf-8?B?TDBYY25xWjdQcFZHY1NmNU1UQnpDTVZxd2o0SHBQeEdmZkFWai9GOGRJUVp1?=
 =?utf-8?B?TXE0dFFnVlpmNDI5dXduU0RVbXNqcStKRzl4dWlRSFRpdG5pV1pORFZ1a1dz?=
 =?utf-8?B?M096MTRTY3NVWmpZZEVaTm5VTU9kOGc3cG1HZnNKS3hQUUdvbWJiei9JYyt6?=
 =?utf-8?B?M1JlQnFycEFDV1RSdnptenhDYUU5L01QRWlwTGY2b0lROGh3Qy82R2NIOEcw?=
 =?utf-8?B?K1ZmaXpIZG5mNGlUSDYyWlh2SFQ3TUFMTDN0Y2h1VndGbWxQU0IxRWxvYlBa?=
 =?utf-8?B?TENyUFMxWjh0UnZNZytYYlJGajdDY3dIZG1qQ3RLTFp2UXE4RGxmNklQUVM2?=
 =?utf-8?B?ZU12SG5xMXRabUhNV1RFWjRpZUlVOWcrWkNKUkVtd1lxQ001RFNHSStibklm?=
 =?utf-8?B?dzZZdnF5YmpLWWZoQVF0c2FQYkE3RTNIM2dCVTFLQUVHVERNeXZDeUdVNVA3?=
 =?utf-8?B?d212Q0k4WkNSK2dpUFBBRnppaEc1VmsxRUlTTU50a3huYlhRVW90MGFma1VU?=
 =?utf-8?B?VWlNVG9aNTZ5cjd4NmtpNHFQOVY4ODlrdGRYVDRSSDZicTJERXkxMFp1OUVV?=
 =?utf-8?B?RFFwekFhNkRHckxzNytuWkZIWlVsaDJyOXB3N0pDOXBUZytzMmUrOUdGWmpq?=
 =?utf-8?B?RWhPRmhCVmlISzArZTJvWk81eTdxZWtZak9pUTk1amwyY2JMZFlEQ1dtOXJP?=
 =?utf-8?B?QmErRTBjc1BtRE95SlVmQXNuN1c5K1BSTUdZZFhrZkVOU1FpN0FOcE1qeGVU?=
 =?utf-8?B?UUl3QVJaa3BPZzB1Vjh0QmxkRTdRSVB3ZXdlVE8rb045QXlodHZWdEpOYURD?=
 =?utf-8?B?RVBERmZqOVZXMXlrdkd5eUpCVnFvTGhGYUlxOUU0YUhRK1grSXAwWllsNGpi?=
 =?utf-8?B?VElURnhySGFxWEVta1RwS1ppQjB6cXRMaTBuVjhrUmwxL3RFYkplNmplcjFH?=
 =?utf-8?B?OVk4RVBZRE1TazFQU2xqVmx5aENqWEVNZi9kTUpkSGEyVjVuYnZUNUVPNzY0?=
 =?utf-8?B?MkZQWCs4Wks3MXhRMlNlRTFuNzRNRHZ3TFE3T1NzMStPNXhaelJaYTRSdFJZ?=
 =?utf-8?B?V3UvTVFZaUY0QkpDVUpwMlgxUzF1bHMvSVRqeHA1UzFPczRFamU0TkQ5MVA3?=
 =?utf-8?B?Vk1Td3dZc0hVMmtkR09UZFgzOU5aUWROZVFQWGpVcW9qVWE2bmtPL2l6WDBt?=
 =?utf-8?B?YjdBTHc1WDJtTDBHeC9lSzVJSDZYQTlnUmxSUkFYUjhDNkJmTHZUTHFHakhk?=
 =?utf-8?B?N25YamRWbVJ6MHFIOG95RDJHTmlIMGhQZ09kZTNoSGg5dk5FSW81K2JPeFBz?=
 =?utf-8?B?Z09tSjF1TjdpNXU1bThxWVVwSk4yYnN0L3ZkMkdvTDh3cUU4VUpFS0JEMytr?=
 =?utf-8?B?WVo5RzBucU9DRzhhQVlDVUZHUkFnV01NTklHb01sV3VBKzVhMEtUUXRRZXJP?=
 =?utf-8?B?ZDczYUZRSjdkZUUvNE1FeXc0WEhVdzRzam5qVTdkY2g4MkVUTmY5aEp3UUpx?=
 =?utf-8?B?QUFxQ01ndFdtVCtlWS96ZmdvQUZWL09tZ1UvS3pZUC9VODQ3ZkZPOUFjZmh4?=
 =?utf-8?B?TFRxUTBoU2dreC9FdndLODB3dG1waHkvMEVCSm1zSktPaTZpUE82aXQ5Tmky?=
 =?utf-8?B?SGNmWmNYVTZiQTlvbEVYbEhZS1o2bGdkcUxhVStZTlUwMUlmeXA1aG1ZQjZ1?=
 =?utf-8?B?U0NuY0lXN1BQMk44c3FxdFg2Tmx6TDJmeXJzdU8rb1BkaVdNc2lWeUp2OHNQ?=
 =?utf-8?B?OWE3L1puWGt4MmhNZStYNXBuZXpTYkRIcHBzN0hNUXNPaXlqNGduMVpVdzJK?=
 =?utf-8?B?aE11eGpHangySlRyRXVMUmdKbHJJYUJUSVo1TVZUcXJyR0JERTh6cEJhOHU2?=
 =?utf-8?B?aDREaFpPK2NrdE52dURXdDZXejV3a1diSFR2T0RRdlp6VUZrcU9yUXdZc1Vh?=
 =?utf-8?B?cWdDV3V0V3lWSzBmK01vdm03SlpoMlQ0cmVwQ2hMZXMya25oMUxxSE9PK3Rx?=
 =?utf-8?B?eE0vSWl3K2RtemxNNWlsT1FxZFpaaHBzSFNkTnNyRnZieUVUU3RGZXFDd2RE?=
 =?utf-8?B?M3ZCUW84UWJlcFdyZGUwRGc3TmNpVEpNRHY5WCtpMmtLWHdVMjdZMjhyRFJS?=
 =?utf-8?B?LzczN01uQmp4a2hyMmNDU1d4SldGOFJkZlVZa1NTV081RDIxakhaZ1FQeGdU?=
 =?utf-8?Q?6pJV6QifLB1UjOlVV2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effe6337-39be-411c-6cec-08dee5603117
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 06:37:24.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1EwxC0AvewWm+JIw5viBJP0KUCJW0+OaU5U70el+1A8GHmCoUWajWsTFklG+3AXltiSr8YZBCo5VOI4RgPR4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

On Sat, Jul 18, 2026 at 12:43:48AM +0000, Li,Rongqing wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: Xin Long <lucien.xin@gmail.com>
> > 发送时间: 2026年7月17日 23:53
> > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > 抄送: David Ahern <dsahern@kernel.org>; Ido Schimmel
> > <idosch@nvidia.com>; David S . Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> > 主题: [外部邮件] Re: [PATCH] net: ipv6: fix a potential use-after-free in
> > ip4ip6_err
> > 
> > On Fri, Jul 17, 2026 at 10:33 AM lirongqing <lirongqing@baidu.com> wrote:
> > >
> > > From: Li RongQing <lirongqing@baidu.com>
> > >
> > > Fix a use-after-free bug in ip4ip6_err() where rt->rt_flags is
> > > accessed after the route entry object has been released via ip_rt_put(rt).
> > >
> > > If ip_rt_put() decrements the reference count to zero and frees the
> > > rtable structure, reading rt->rt_flags immediately afterward results
> > > in a use-after-free pointer dereference.
> > >
> > > Fix this by caching rt->rt_flags into a local variable before calling
> > > ip_rt_put().
> > >
> > > Fixes: 77552cfa39c4 ("ip6_tunnel: clean up ip4ip6 and ip6ip6's
> > > err_handlers")
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > >  net/ipv6/ip6_tunnel.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c index
> > > bf8e40a..984cb0c 100644
> > > --- a/net/ipv6/ip6_tunnel.c
> > > +++ b/net/ipv6/ip6_tunnel.c
> > > @@ -569,6 +569,7 @@ ip4ip6_err(struct sk_buff *skb, struct
> > > inet6_skb_parm *opt,  {
> > >         __u32 rel_info = ntohl(info);
> > >         const struct iphdr *eiph;
> > > +       unsigned int rt_flags;
> > >         struct sk_buff *skb2;
> > >         int err, rel_msg = 0;
> > >         u8 rel_type = type;
> > > @@ -627,10 +628,11 @@ ip4ip6_err(struct sk_buff *skb, struct
> > inet6_skb_parm *opt,
> > >                 goto out;
> > >
> > >         skb2->dev = rt->dst.dev;
> > > +       rt_flags = rt->rt_flags;
> > >         ip_rt_put(rt);
> > >
> > >         /* route "incoming" packet */
> > > -       if (rt->rt_flags & RTCF_LOCAL) {
> > > +       if (rt_flags & RTCF_LOCAL) {
> > >                 rt = ip_route_output_ports(dev_net(skb->dev), &fl4,
> > NULL,
> > >                                            eiph->daddr, eiph->saddr,
> > 0, 0,
> > >                                            IPPROTO_IPIP,
> > > --
> > > 2.9.4
> > >
> > Have you already seen any problem triggered by this?
> > 
> > I don't really think there's a use-after-free issue here.
> > 
> > The entire IPv6 input path, including ICMPv6 error handling, runs under
> > rcu_read_lock(). Since dst_release() uses call_rcu_hurry() to defer the actual
> > freeing until after the RCU grace period, accessing rt->rt_flags after
> > ip_rt_put(rt) is completely safe in this context.
> > 
> 
> Thanks for the review. However, The issue is that after ip_rt_put(rt), the rt pointer may be logically freed if refcnt drops to zero, and dereferencing it afterwards is illegal even if memory isn't recycled immediately. The patch avoids this by caching rt->rt_flags before the put operation. This is a defensive fix against potential UAF reported by static analyzers. 

I agree with Xin. I don't see how a UAF can happen here. If you are
claiming to fix a use-after-free, then reproduce it and put a relevant
trace in the commit message.
