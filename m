Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2DF371CE0
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584947; cv=fail; b=XwMyejFue/nI+7rnBj0pMZ7ZhFeJyr9Vbl/VZZmRqs+fP6dWaDfC/lawrA3T+ZRnmsRCRM3WwWUvwgVr2BzchUyEG289fnnoE2NnGJGOzZ09fje4du4HqWG3qjYDIasP2di9ZeDOmwiFqGX1KrUbxOd26fCQcG7H4oaIkQORVdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584947; c=relaxed/simple;
	bh=E4NjO4sv9a9qFH1N7E8tg+WuESnqgvqa+Ger3b6I6kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y6u+kqARXEE3Dmqk03fbZTA86aGRFjuDOSsf8bl4ZbiXKKS6RMGQq2VdNPkj3fz2Xe1WMF9AsvOqbrTrtZ16BLiCUO7DIX25hzUSVTtazL3/9O7u+asozZhx/OuMkle1DwSkRh+Rt6XfHT13ttNUassD/bUvyH2+A/vLVZpoqyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UzLt6NhZ; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UzLt6NhZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B04jmnNzArRRz9ey42dBTREPBM8/y1ERemOehp+HVBSSAFGobJev/GPVgDKSZ4FUn0Q8p2QaUys0592ZPcCejF/m5Jh30+Uw8EngkzDRjII69dZewDAcK8oHU4gKInvHsCPKSfrrF7eJvvVbfYCStTTuTTF+VQWgmiz8gGf4XefbVjobmxW36Wzewn1nkHOSqu0+uM5BjYAEsW5lHoC6/vM76a9Nh+4zxpSFFnrv9MSsHq73cTotfxHGNtvqJzSM8LoOZ2DG0NXjxRlY80ZEh9uo/mIJoORcucJbcodfv8V/8YZt1aE2HY1oCcubX+p0KFdxm87gncMcy5Wp1P2fCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqjs+60OxJcS7WDJvE6pdf/yZud3INg94ApZBDJOqjE=;
 b=ILIpMMK7TUgERG/TKs0U2BjnmgtIo+pc547qQFwRgJu8sN2HAfCm7hBL1U/uUJZolgnFz2MDfCtITLYn6QzoBknt5DryvP8Xl+QktcclbPD+78erf4LO/HD2CHHpGo6pgp6YJESEUXX20yOszGG9eGh4b4yOKPMHhleG2AnVezHidQIrAOLj8vP2QqjFseX+xTVi+14gJzUGgp2Ga0CcrRFaoKj9WfV1hBoWS81QDNXJE6YFlG61VMW7IDMn+pzUEMpkqp6mUUlTxsq6Qa0H8uOxoedNydM7rPVADMbgzC+PAIliiQ1qKZF5rJ7Rp1DDtNmlbCZqdog9+XjXXqrwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqjs+60OxJcS7WDJvE6pdf/yZud3INg94ApZBDJOqjE=;
 b=UzLt6NhZrB7RbrhUBIRONM3c8KA9iCBX+18XXaDzMnk6eCvT60c0aFLVW56vU1SJoIisOoWVrVcAbzlvXrWTLd2BxTgNmiA2uQuwPrYcm7IG/WerBoqgb4dCMkdSKX0ZVl9/QkeEn+eKOzY/sFB++BpjyTE4iHwkQT4dEh+cNyQVL7uGsEVfZYgrX7iJade0/l9NGEBfEzS2WTFZVshCQweAb5kVsAo7TpWAW48fRJ0vgLhOeuz6aGsK0jbJco984QX7plP6LaTBhHt5fG5VhaayS5zqMrjc/RFC44Fbaf/7VTnPpMTNvWuMos9Cp4PLacClr3VZ+y2UISYE/FCjtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:22:23 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0339.010; Mon, 24 Aug 2026
 15:22:23 +0000
Date: Mon, 24 Aug 2026 18:22:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: ZhilingZouzhilinz@nebusec.ai
Cc: pabeni@redhat.com, netdev@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	vega@nebusec.ai, zhilinz@nebusec.ai
Subject: Re: [PATCH net v3 1/1] ipv6: flowlabel: cap duplicate leases per
 socket
Message-ID: <20260824152214.GA1112115@shredder>
References: <cover.1787387550.git.zhilinz@nebusec.ai>
 <69d00f6ba09b1d1afd9281370cf7ae5e2ce806b6.1787387550.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d00f6ba09b1d1afd9281370cf7ae5e2ce806b6.1787387550.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: FR3P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV9PR12MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9d961f-a420-4a7c-37f5-08df01f37ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|5023799004|11063799006|56012099006|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Ipcmo7TVPpo67K7vdJIEfzM7Ehblw2K5TToD2qR83m+vuvkRNxj27/7m8/e5dKo8AK8y7LRGiTQGvZLIx2K1Jyb9u1AQAfVHA888V0NlQ5lH6Jsj8ythn7zB9O07SarLv0H88HRogu9aro7ejJ3DZDcuRulieZqek3Eomj8ZCTNyn85YTtxL28liDD+4+Yu2kYkBFmGwCGDDUyzQ1ZpmRkMhMAqG7c3rb+1SUaEElCsHtUa+PRKk2ZcPcnN9vEKCYFe9ZnlEWv+FeFXRt/s+b8FEBaXVWG9CFhbSWAlsk7VEJHY8ffU1uh4DT9JP1fZ2g3iM4vNil4Ay0HlFn8bZU9tL+JNyOZLi/MNN2ABr3l9Jyj1HLskdgUXFQpbqOi510+Tgd8ZFlY3IqVTYclZcasYrSVvGNbpYdnCg0ucEpKHWaBXzMhEDLL/zfh3n/yHbt5rboYYMnFXtArgmMcaxcZg84y0hXSI01JaOp8uae+3bH2vJSzHx1B71g6r9aq/1IDw76TcFCz2Vbd36Mz1TV8kJfviNRh1bj7tTCQw63ieyxDqQfzOTyoxA3InsKeY+f4ySAfxIvlvXqX/GWBALGgR7cKPsezgT+dPYTAeFTN9Cz4GbuiNAFqLblIAsdYjqdswS6sRkK/k1T8Z9Ew0nj//sPpFdWR7rU7dDPD47dU0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(3023799007)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g6wB/DKAkVcndbi8FviKwIv9n4me4QFgcW2CfXrzBtGUpMOHOl4cEfvr3wjP?=
 =?us-ascii?Q?n0K+nm82emhqTFuaqJjt+oC988FpX/fdFGAKJ+UXFmW3pJWws4Z0wTMpQQxE?=
 =?us-ascii?Q?pm7AhDbDsNc/jZZy89xsV0+XsL4lyr4Ng0FcWiJJS1FFvpIjuYvqi4ncB4K4?=
 =?us-ascii?Q?jsntwVxUZLxOcOX8xfjwb6QMWh/jRny03oMYgYlDx4M6I5QSy2DBi/md5rdC?=
 =?us-ascii?Q?vqXDeaSs9Fuh3zSsi7YkLu1HD8Wls5YDu+ztJsx/JAfOKe7k0twMmntQnyRS?=
 =?us-ascii?Q?N+/VMzXQA4pcZLrb5Zf16bDeJV4obo0EDVsnVc4RrZBGLIVYoFl0LeC4k56t?=
 =?us-ascii?Q?zDQ0OUuA9JxzjaVsUyC86LfyukZLT1LjI9JtcFxZzygjDykgMvWxZt6snYDx?=
 =?us-ascii?Q?M42RBCgryQtOj4IM2pLcxExMp1WFg8Y7Q3LgSwRw8FoF44qg1MxvIreFeM6c?=
 =?us-ascii?Q?sa9q+buN6XHYlxokapHEZtHmyGh5wfHIRlRebtKX7DZ66w3c0eGy972QYM45?=
 =?us-ascii?Q?qp6Ok8iiwfkzmfRLtCvg2HXB4fP/AHAwaiUJi8W5LTMv2IVqOlW8VTVvrEnX?=
 =?us-ascii?Q?JxU0i6CNpTSKn70Wfkj+8MRE++yWn7pW2LWRTJKB2Rm+Lep2nW8KesIL5ZP4?=
 =?us-ascii?Q?VSW74x2mA63SxYpVOFfHjHOHz+RKcGa07W31ukh7kB4sTiaAOPyzYwRytMfI?=
 =?us-ascii?Q?Gjl5/ctBmUcMtuDzRydGckLQYF0Gb22BcUo8ho//yGj9iPTr/TLxcOHmVmqU?=
 =?us-ascii?Q?5dH9apzUOcOEmS6vpJIRCl5cwLSEOE5XJXRLZJOVeHMsBO4SkUxsk0zsJj4w?=
 =?us-ascii?Q?KCNLQm9i3s6T8hgzB/YM5wPKGdtqCA+WEc0bh832pFK0WuR6kw0IqiMNRKtx?=
 =?us-ascii?Q?85Adc/k9nSzyHC7xznr3SoXvjqxYZGT5Hsb0J+BFJyjiFsTmXPuXA98vXLd8?=
 =?us-ascii?Q?VFtpR3LSx1gByAgpek1qdKKZVtp5f3TKDrM4Lizqlh8u5xCO16IaeSsOu2/x?=
 =?us-ascii?Q?I5HPAfNDxsqS8G8+UzvUDMZTMa/wbrTZv6T+vQxfhbfXvR+DI/yfX0EW5GSy?=
 =?us-ascii?Q?RmQ1hlDWhbtnKVkhV7iqEddU7mr8SJVKs1jvaLQHam0/5MsPbh8XXHvG4X80?=
 =?us-ascii?Q?yneuYqhHWAmAvMCGrK9xTmFLEEpAVezW5Qqpb7t4W9nj40wLyJ+kG3dRepmg?=
 =?us-ascii?Q?SoYANJiXlsxdQ1RqFpx5vSCC8ixBu9L5/A/Aw6u/tfBeGfsthKoaxBIaFnbM?=
 =?us-ascii?Q?2Jompm4CYqrn2pVB6rLyCUBCHuBOuq1LlpbD1UfL05ZzOWakvj4M4oF+AE3F?=
 =?us-ascii?Q?Qn5nhi9CZEuymfn5d8GGQSuJAdbyZjNL9fsBaWUrcjW31W7x/pSc0u39sJmr?=
 =?us-ascii?Q?aWMKoWgF1hlt8QKTuPuX7h++c0oRTLTi8o0J7dhmQMgCtY5jqvjNXJyaF/6D?=
 =?us-ascii?Q?vKgIz7iPwzNwwesI0q2SVrnqgfEL8E3JBwSpJ419exiAn3cAHrUdpDiA4+VD?=
 =?us-ascii?Q?aYpToyRhv3UkPKZlREI0Dd748YMJGhEjunszhUb/0FwLFVbTv5zyWoMJEQ/l?=
 =?us-ascii?Q?i3HWGy07tx/6zrVtNPzmNcKmmzeEK/sRirOH5g+4PlctSyy0UTme9aB3ex8y?=
 =?us-ascii?Q?u8jTgxVpyIkPjD6LqpD5Ogxmd0E/KveeAZtrmsxrWoMwKROZC5sMGyWeQcmI?=
 =?us-ascii?Q?JMsSBCKxaWzLIOFTiCGdb2vG3mf5eZp88JRPTFkJg2v2vEpz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9d961f-a420-4a7c-37f5-08df01f37ef7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:22:23.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nIRwLL59N4bCYjyqEb47GIJxwJtPA149qW2JsjZ5dNfsP9bK+L44C+RLugrPeB43OMORGWuLDJaIQywi4noOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759

On Sat, Aug 22, 2026 at 04:41:42PM +0800, ZhilingZouzhilinz@nebusec.ai wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> ipv6_flowlabel_get() allocates an ipv6_fl_socklist entry for every
> successful GET. The recheck path for a compatible existing flowlabel
> links another lease without applying any lease admission check. Repeated
> GET requests for one shareable label can therefore grow a socket's lease
> list without bound.
> 
> Count the socket's existing leases during the lookup and reject a new
> unprivileged lease once the count reaches FL_MAX_PER_SOCK. This matches
> mem_check()'s per-socket accounting and also covers leases acquired from
> distinct globally interned labels. The IPv6 sockopt lock serializes the
> count with fl_link() and PUT, so no global ip6_fl_lock is needed.
> 
> Check CAP_NET_ADMIN only when the socket reaches the limit. This avoids a
> capability audit on successful unprivileged GET requests below the cap,
> while privileged callers remain unrestricted.
> 
> Do the admission check before updating linger and expires. A rejected GET
> does not refresh the shared label, matching the existing socket-list
> allocation failure path.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v3:
> - Count the socket's full lease list instead of only matching leases.
> - Defer the CAP_NET_ADMIN check until the lease count reaches the limit.
> - v2 Link: https://lore.kernel.org/all/528bc30d301bcf32aca37cda1933b617d2d295f4.1786447968.git.zhilinz@nebusec.ai/
> 
> changes in v2:
> - Count only leases of the flowlabel being reused.
> - Fold the count into the existing socket-list lookup.
> - Keep new-label admission under the existing mem_check() policy.
> - Stop after the first matching lease for CAP_NET_ADMIN callers.
> - Explain why a rejected GET does not refresh linger or expires.
> - Correct the reuse-path explanation and trim the Fixes hash.
> - v1 Link: https://lore.kernel.org/all/cf4fdc79ae4dc46bd4eb7eeb57e5de2091c13cd3.1785746178.git.zhilinz@nebusec.ai/
> 
>  net/ipv6/ip6_flowlabel.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> index 1ab5ad0dcf24f..b864dfc87f779 100644
> --- a/net/ipv6/ip6_flowlabel.c
> +++ b/net/ipv6/ip6_flowlabel.c
> @@ -617,6 +617,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
>  	struct ipv6_fl_socklist *sfl, *sfl1 = NULL;
>  	struct ip6_flowlabel *fl, *fl1 = NULL;
>  	struct net *net = sock_net(sk);
> +	int lease_count = 0;
>  	int err;
>  
>  	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> @@ -647,16 +648,20 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
>  		err = -EEXIST;
>  		rcu_read_lock();
>  		for_each_sk_fl_rcu(sk, sfl) {
> +			lease_count++;
>  			if (sfl->fl->label == freq->flr_label) {
>  				if (freq->flr_flags & IPV6_FL_F_EXCL) {
>  					rcu_read_unlock();
>  					goto done;
>  				}
> -				fl1 = sfl->fl;
> -				if (!atomic_inc_not_zero(&fl1->users))
> -					fl1 = NULL;
> -				break;
> +				if (!fl1) {
> +					fl1 = sfl->fl;
> +					if (!atomic_inc_not_zero(&fl1->users))
> +						fl1 = NULL;
> +				}
>  			}
> +			if (fl1 && lease_count >= FL_MAX_PER_SOCK)
> +				break;

I find this hunk confusing. What do we gain from it? Unpriv users can
still walk the entire list in case of a miss. Also, we can get to the
recheck label from the fl_intern() path which is outside of this block.
How about something like [1]?

Also, please mention in the commit message that capable() is used
instead of ns_capable() in order to be consistent with mem_check() and
because we want to prevent unpriv users from consuming the host's memory
by creating a user ns and a netns where they have CAP_NET_ADMIN.

>  		}
>  		rcu_read_unlock();
>  
> @@ -679,6 +684,11 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
>  			err = -ENOMEM;
>  			if (!sfl1)
>  				goto release;
> +			/* sockopt_lock_sock() serializes the count and fl_link(). */
> +			err = -ENOBUFS;
> +			if (lease_count >= FL_MAX_PER_SOCK &&
> +			    !capable(CAP_NET_ADMIN))
> +				goto release;
>  			if (fl->linger > fl1->linger)
>  				fl1->linger = fl->linger;
>  			if ((long)(fl->expires - fl1->expires) > 0)

[1]
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 1ab5ad0dcf24..006585dc8b5c 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -461,6 +461,21 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 	return NULL;
 }
 
+static bool fl_sock_at_lease_limit(const struct sock *sk)
+{
+	const struct ipv6_fl_socklist *sfl;
+	int count = 0;
+
+	rcu_read_lock();
+	for_each_sk_fl_rcu(sk, sfl) {
+		if (++count >= FL_MAX_PER_SOCK)
+			break;
+	}
+	rcu_read_unlock();
+
+	return count >= FL_MAX_PER_SOCK;
+}
+
 static int mem_check(struct sock *sk)
 {
 	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
@@ -679,6 +694,10 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 			err = -ENOMEM;
 			if (!sfl1)
 				goto release;
+			err = -ENOBUFS;
+			if (fl_sock_at_lease_limit(sk) &&
+			    !capable(CAP_NET_ADMIN))
+				goto release;
 			if (fl->linger > fl1->linger)
 				fl1->linger = fl->linger;
 			if ((long)(fl->expires - fl1->expires) > 0)
