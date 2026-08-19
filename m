Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F664503E0;
	Wed, 19 Aug 2026 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787140269; cv=fail; b=X3zek1qMooiVgMVNx99tolG1cdwpe+7gLA+CnJ6QdeW/TwEMYKP3/rm3adyZ3P+Q3N/SRoI+3eBYoPmio5lUZvGCACkWmIFDjmsrPzY9ahDFbQ9K26lCJJ74eEdsd6D49RW1OMLVtzseEbsscGXhf94Sb63pOWD+sa9/T1LrJps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787140269; c=relaxed/simple;
	bh=xvP59TPfK55g3JPG+H+quUeGLim/BRQ1/gB6zlasCpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TuPwSkfr5vSUD3nI6WMVNT5J5ZXakUPomKhQRoKD7gOjmc34YAAROHXKkx+OS68JPVNM2o2udEQrHpu7sgsIGG+3+eIP4LRXgQj3A2wT/EC0AorN0RoT+OuKTOhEjtD9/qgtio7i75XhFiHz7rgKUBNBT0wcTS75aXjrIpLf74I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YIkagF6w; arc=fail smtp.client-ip=52.101.52.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YIkagF6w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abf7RXDdLrKxQP7zKPUsTyheLY8jpt7xMJWpOCcffYRFeuYkgiC1jb8QM1o6RLPO/mO5qq2CLeHTok96/RyEyBBCB6mWjuxWQ3QJkxT2FyVj0tmbE0lZR4IFNKBori1g2RErYgUDgTtMG36NIG4tMjtXcfBu9aD53bwKfKfjT20yFyrzGiHEQHkbr2el8zgnAkA+8Xd/PPMMpTfoOs2l4Eb2RTxVTul0wGgSncLbglYhZVe39ewyQOZprVaN3ZFXcvSCv/lhXKiee2NUTtZoLmyK8cdQo1PiRgHfPTRhJcLjWmnHPeDEWUTGrb63OOJA1AXLE7c5xcTnaRKFPFESRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypJR/270eq/HG+c14gfunlAtmJKN9jkfgRFKMcGhGUM=;
 b=pP4QPHBCA3feeSLfAkep/B5FzMYHTOlyT8kuAg8jWPC59erohEVmzh7IL2KvHmZiJNr/PVfA066FqNzprz/UyVwCzMtldzQWSQB606NUheJ68qmIJwxmBj2KsJsuKlJBBwrAreTYrwXDLbU5ai6xtFchIf55ZC3XNJfAC4MPOLpAbGcR0GjVmEwDeggZ4hgGupam3A6siDm7kORZfu4b8uHfJCf07wEvu9FzqaCeDUzaU+TTv8KqAwrvQsD5ppSC/Hb4nS4deRT6FkgsXRsiJqzY+ykae/hThx9js8JhxniJWZ/tLxwQaHE2i/SiuCKfXdEcSTtD8G/39ph/y0hWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypJR/270eq/HG+c14gfunlAtmJKN9jkfgRFKMcGhGUM=;
 b=YIkagF6wizWJeLYHBNEM05C0U+8wJlITCtGGKEzyYAH1GO3q4Vir1M7hNgy5SkYz/pId2sds3CQWGJiJBGFDQ2cTfaewIWQJY/avXtIPbwjLHaaKZpmVuzcHInjmom1O6TmFXAr8B3WKf09aUhkWgq2nKHGu3ZZb3wN2zAOXdhRwaJp16jbUoesywGMaD6UU1zm35mUIocMCUcgWZWL0P3bxkJqaIGWof2l1LKiZD6kwQPnh3c+9i34XLKZ2AcTYa33yqHeVJOLfkiCAL7Fpc4PjseAWmROlGVMbO1YDq4XvNQdyjAWXmnCUvdrdoE3ku5228PPOr5LXFVByY+sqBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 11:51:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:51:03 +0000
Date: Wed, 19 Aug 2026 14:50:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Amit Cohen <amcohen@nvidia.com>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: Serialize hardware flag notifications
Message-ID: <20260819115054.GA1136981@shredder>
References: <20260815095436.90534-1-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815095436.90534-1-sigefriedhyy@gmail.com>
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c3fdea-a5d5-4743-cec1-08defde8255b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|11063799006|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gXAaCHQILuveUbseHtUDZ6cEAyabBa90LGrag1luKoSgC1uHZlq5z+a+S4APsVtToqflFXIKe9qAw4b0GhzQjDmomZqsdc0YvGfOH6uycaGdNurLuZ2Syf3nxQ9PPjAtvptry0MUnRd0nz/2y1ENzzmi2K0xJcbPYN0cxQrptMg2hfv7zxS2+j2WUL/gc2ST5rB9XLNrnyKlBKokYqeIiN1yg+2oeZ+q8e2EbVhjI3e80lIyeT1iydnDAJ1yOiZcoOdq7vWQDB5ZZLc2L9RasUST7VTzP75HkBveVPl2dhYR1e1yDuq0LZo+pd7zlUVKn3uz6IMYlROZNDi2ZJIWz5dGLcF6zf4JEuyjzokdxePEFFKfqdGXaklu2785VR6IB0YsKwKLKOA6DJZPN1clbjJSXP26wKXl6+Pfvyi7Eu47UgY/a2s0YhySk2vht0r0wbNPhS1glR0U2FZGL887Jg6zEZo7cyLKQ3SrsOHy/b/ofgkudlGuPuSJa2rhNNvUFcuvO6MqV3Zr49NMtx9tmtlsieyIidN39RYlQKPsKKNQFdvCi0pxnteDR/JTuHBYbaZ6wdPShxFVsJ8OX2Bt4whF7OT0MPe+gudxIFfbIt61nhmyxfEasqand34KEgzzZez1CtWZxWlxAWP8r5GbNzrvaoGRTsR48Vc78e2deWo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cEYOa/YoZUCbr1pdOfIIArbacwiC0bXloAvKtalG2xzHSmyzio7bUH/c0XbV?=
 =?us-ascii?Q?uO9keNcmUw0v2KM17lug+XMiPu5qG0nj0UwTFtZ0J/M2BGRXx9iKA0Dhl6UI?=
 =?us-ascii?Q?HaKWrfeAr+AwUO/tu6I0W2O6N3IzGCt9A3SxKLMK+xfzL1pAF7eFEMWJn+SQ?=
 =?us-ascii?Q?zANJDBEV0dZ7RoThc5f+d08hFIFQ9+QSe5nhHY0lDCYZAAmDDdHjuADyaXVp?=
 =?us-ascii?Q?iRtjPaKk+dH45Ywo2iOVEUETo7x+pnJTl70eOEwcz4+DQ8qGi5Omzdy3Nbg8?=
 =?us-ascii?Q?sa800j7+1YoK05U4T3hSISEQrackkFbTZN5+D6gW238U+uZCM8z3704bDBPr?=
 =?us-ascii?Q?iiZNGa1nfOimgTWHgAruYXoaotrPGkKKzAszU9zaHiVvBMrADYgnuTQplsqC?=
 =?us-ascii?Q?0SqYIqW9ejCfH7jNktaMmIi3QGLOlNeQZkvEjs5xERXhVhepNUBC7CcmzcF7?=
 =?us-ascii?Q?rzAGqvPCvYPuDPc/6sE/uVGDtO3jSulWe+xiStb2AehOrq5i2CN9ejMjP038?=
 =?us-ascii?Q?AXN+d1jPy+8uZTlTeBiiWCb3AURbXZ2RyTJaKrsCs2Ru84FnSqu/SXjqMFWn?=
 =?us-ascii?Q?XOd0H2KbMp7JLwYUKzMZck92N8J4PLFBdcj3nyYnaIrSz2FqgNB6itH1p/xE?=
 =?us-ascii?Q?6lnPHPJ5RiAXCk4lOwO+tp0nzeoT6G74kBLENmm2Pb/+qjihQjU2CoEAJYwP?=
 =?us-ascii?Q?TvsbOMfO3SWp9QUftQnJCT71AnMJ1LLMd81Sm1kD74LnkJFBpiQx5I9KxBvn?=
 =?us-ascii?Q?Y0oqbKqg8fGy78/8YDp68IxhyXKehbRa+vupNKUjdywA18CjksFmAAIXRXaC?=
 =?us-ascii?Q?KLAhy24q9JPFci0aeIF/WHrEY6CLLMHSfRGY+1sjkwddyvcaVG9oEanv7v2V?=
 =?us-ascii?Q?IQpyOPdFyHKKZHXd+GmN5KirEYx51AjYlDfr5jJ0TamEM+2iGRhRTQ8i245b?=
 =?us-ascii?Q?oo3mI/FKUE7FjKvphSqN4Ai0sP2kvC7TIZ21tnyIGCMH8v/RyCnlA39eQ9qu?=
 =?us-ascii?Q?4lfQjI+ukkKz7dha/n3hH5Xd282olS16QQ2DzCR13XNGXm1m4AgdHcAkoKfv?=
 =?us-ascii?Q?r5m9xptnrAFijfQpvWmRMWenZtYuCYjHeQupOmPojG7WM5Xgub1CNJLHmn8W?=
 =?us-ascii?Q?xlQOdjRkJStXQfqjzy8TI/gkr+s707Y6he2xzSNxNdT3zhKGvWS99UfMBEhu?=
 =?us-ascii?Q?A1uAVMdtgVc52Cg8XOylbNHaweHxEycR21Af9blOtSr5WqYUAxwiz8nfRoif?=
 =?us-ascii?Q?AA0rx2Hl7uUv/kAGHqvUVy6/Xvx5Rfy9HWx8a2wJd7F1Uo/YOIFlfWQX6zw0?=
 =?us-ascii?Q?sAKSU8/btgGMj7dF+yPWdZGtnGv2pqOa1b/sw2rtETXlabkL2bhISZJRsi/d?=
 =?us-ascii?Q?bPux2PqA/lunq54ee1yWnSAR5JvG1q9UY4sq4x/MwvbXvFQRAjnHJ3TLu3sQ?=
 =?us-ascii?Q?0ZUvbSV68iot+bJKg3U6mNvg7MqcZe0uABjt10PERPpb+LYztkN1Ejpj9n0e?=
 =?us-ascii?Q?4gt5TRiIeeRNa5CO23+k2sAyR2/DfrS7jmq5PPWrROQsSUWDygwwuEdSckW7?=
 =?us-ascii?Q?np9ndq6gXQxsv4jU6OXk7EzH0HWmphCbZNJbbMNPt6E+WGrzQ9P4NQ26/peF?=
 =?us-ascii?Q?4KHbN0ligXSguZp+UsZ2UKIykfsVrxjju6m7LD/qsT39lEmGNHqzoOn+a8H7?=
 =?us-ascii?Q?zk9O40kAe85tPL+t5r2PA9ff/Sms71XRTAZh6f6O40l9SuT0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c3fdea-a5d5-4743-cec1-08defde8255b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:51:03.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJpcf2ADXPwBS9igcpwJr8UwJC1awLCrI0z48155SQYsJKn9EmMshsrMIzC0bat/O2i0+O1vwJrfxeAsSC8sEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167

On Sat, Aug 15, 2026 at 06:54:36PM +0900, Yuyang Huang wrote:
> fib6_info_hw_flags_set() first performs a lockless check of fib6_node.
> It then allocates a notification skb with GFP_KERNEL, which can sleep. A
> concurrent route deletion can remove the route, set fib6_node to NULL, and
> emit RTM_DELROUTE while the allocation sleeps. When the thread wakes up,
> it can emit RTM_NEWROUTE for the already deleted route.
> 
> This can cause userspace routing daemons to receive RTM_DELROUTE followed
> by RTM_NEWROUTE and incorrectly believe that the deleted route still
> exists in the kernel.
> 
> Allocate the skb before taking tb6_lock, then recheck fib6_node while
> holding the lock. Keep the lock until RTM_NEWROUTE is published. If route
> deletion wins the race, the recheck sees NULL and drops the notification.
> Otherwise, deletion cannot remove the route until RTM_NEWROUTE has been
> published, preserving notification order.
> 
> RTM_DELROUTE is sent by fib6_del_route() with tb6_lock held, so
> publishing RTM_NEWROUTE under the same lock is sufficient to guarantee
> ordering. rt6_fill_node() does not sleep in this path, and the
> notification uses GFP_ATOMIC, matching inet6_rt_notify() which already
> broadcasts under tb6_lock.
> 
> The race was found by Sashiko during code review.

Yes, it's racy, but I don't have good solution that also covers IPv4.
IPv4 routes are protected by RTNL and taking RTNL in this path will
cause lock inversion.

Also, as far as I'm aware, this isn't a problem in practice. These
notifications (disabled by default) are mainly used by routing daemons
that want to suppress the advertisement of a route until it's offloaded.
If they added it and immediately deleted it, then it doesn't make sense
to advertise it.
