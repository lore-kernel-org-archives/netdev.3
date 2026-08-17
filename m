Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274131A238F;
	Mon, 17 Aug 2026 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982472; cv=fail; b=I67Ty4W7CuaJpfGWZua77RW86oqYWf8eRTMbN96aoFvrncs20i1yYEqsBIP+Zljb7e5U6BcsGi4twm4FR1Ar1WKFcYqn3zd9332EUKuns0ksbhuHr9NvswRTuOxPESuoZJQeQ489AYR0TsAKGCRpzSLp5cJPPZGil42lSaMPbLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982472; c=relaxed/simple;
	bh=eQbS//Ihier5pfGQUgv4mIZ7I8qJ26diLiub0W/+n2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hsHtP7ATedahLRJQVs37EEFCrKgJLOGDLJsyhYvoM/zUNKqGRaeFICZech81nV3S4WoQQ4h6HdCW5npSwizBDx+a7Y78FpanA5WArsmURPHwYxzNmGgqIeU/Ied4boLC6H7TTyoZAopCclLKV4QUABhswC6Y4p4s41USLJp1/5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ABV2iMkp; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ABV2iMkp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RihGfMD4Q5T6IjH9L+m47LSAFPXfNDMlmcJdpaMfY0nuMANbyzGz6SHPmiUbsDPkh1OrX+scLedlH6CHTvQrZeGuzoylxA4w+V2w4RjNjlGMdaN1ZQR0M0Apcs0mRIy5HInew7bcK6neKOyJiUVzdArgYz0K/BDFjeKW5HZTeUjEPURMy2x16PomK8QlEtMsBU7s/8gMIudK2iMZnUIzB2XPaELGHmDVfDHs9EhtkKR60O6GKwlj8BsQCEcKYdMPjbCVz6Wra2npBtG7rLCldmu/UR4KUkhiM87w+O2B85C83lxraqboB62mbFHBktNT6kNa6lrwnRjb3Lo1q2a1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5T3Lo36vewV5MiQd7BOLKes2GrU5IUmchWBzmZvwBg=;
 b=ldg0qe5V6v5HCd2ZCIABaQcdIZWP7ObpO+qOFMg453YZWmgh5lE9JnFtlDAafilac0SdIEa3dqh+33fViMNivMxsyvWO0H+czu4kWIGJpuoZsX2L4O/6GaZCQ6Igr6bulNCQtQ7ODrXtwBiwl5sutbguUmFtZoVNb6zdewxbArAUgH14HTBTpiXjKZx9P2A5iYhCXMq2TBEWN/U7l5fBMaLwc15dmncOQ/AXaV0ZXm3S6zcmpK2uYZuNRFy01QwlZpdAH3H0F1I6eAr/BbzhEkFv82hIWP4QmYNbggM8BtLd9I9AU9VLp92lmcWzcI6+lBzjf4wLDW5tNZqFKf+uGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5T3Lo36vewV5MiQd7BOLKes2GrU5IUmchWBzmZvwBg=;
 b=ABV2iMkpcu0F20iG0U/As/cmw+8WIVX+qjaHQQx+/IgeG/IF0ExqIMUhuXkTSPcfW5DcoGiZxldpCaEWd6FIG3tEqm+46S3Y3RHapi/WSZ7VRzoTfj2OighjvWbjIVhpN45vG3vRFrA52SiShIK8C1gupTydCuYapWmIuZgOuzPFGB76axH1PyfhbIEDLwbOvnqbTM1T7YPc+rwDzuTZsR5ICRfc0l1wAdM7Nt/HB3qi5rgkFN5qGB8vP5WmwKwbAiZ9KZSTmIYOJVtyhskuDB2UChHg5aHQ7JVX3CPHaQYmKqiGEE7qY4863hCoROUJ5ikjcRp6uTMDHCB8o7pU9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV9PR12MB9758.namprd12.prod.outlook.com (2603:10b6:408:2bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 16:01:06 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 16:01:06 +0000
Date: Mon, 17 Aug 2026 19:00:58 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	jiri@resnulli.us, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, federico.kirschbaum@xbow.com
Subject: Re: [PATCH net] ipv4: Fix in_device refcount resurrection in
 in_dev_get()
Message-ID: <20260817160058.GA484389@shredder>
References: <20260815172032.79740-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815172032.79740-1-baul.lee@xbow.com>
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV9PR12MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f20ed5-153f-47de-e0f2-08defc78bee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qh0y3nyDjU3ncT0N6UZ8O7373I7Ja7YzNRsQ4T3rCcy2HYEp0qtaFuhJJRhrriD62f433rdPRcI/VqJfNjNUuFgVOwCQNXsI4DsUsh8roFXBPkVKBWh9npNNMX2VUWcq2JjHePbuKbOQ9XB33HRGPfnYMPda77HoiKdzhobXAO3bVr+zkigeMb5Oxu8JJuWLgDy/svh2bLDZJBZmBDsW7IgThGVFMJIjgwRmVdC2xcQUBNZas9yRT2vKzwu890K2lZwltjMnpTutIpauOTpZgcKQq+4vS1ooWCdIk5PuZs4nlvzr7KzzKCxi/WtcFaLJqclRg0HbxCXX3/gr1tsxtqeH4deHolXmE+JTumBs6S/7pj91f2drAiehkrYPr7g+/XL/c6s603Ay+rqFbd8SJ07gGEtxCYrUcou7Z1Uliop98DVjmt2n/+bgjs5nZc4VqRstjLgasKoD+GaMKCvDbSZW5uNjwXbQHpigkJlBQiIpOtG39pZQn0Z3fT9PZUiOPSqWeKx4w2DK/BxfmXcI1R3hdYxid5auc6a9V5dLlQnwiL7ojtR03O2r7gH1evXwG/ABZpO3T+tsT+45BNI+DlSYIaypZPXF2rJfyxGRUMG6lxtmfSxSXEsOTdPFgyXf5HpZrC8xaIkSZ3jA/y5BxYGm3gR6VhoNb/bpquHXM4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QHvY922ylwBhI/QcsVlBgj2eZulBet9XkmU8VJjr0aDWyPL2AQREr3tto/B1?=
 =?us-ascii?Q?IW8SV97SM1Iz4Bf3DeZoue7BKxeST6TRMj+qZzocvUbw2yriooxBtSJSyF4D?=
 =?us-ascii?Q?N7DyHQqlulK8mEU7aro+v/mnAeSCCjVeCNX+r17eJCTdVoHCT4waTVeT3ebH?=
 =?us-ascii?Q?XMj/9gI4UC+Tdx08PzN86FtBogwrp8DS4lTaAoLT8QQMjPvw2dwTuoFe1z+8?=
 =?us-ascii?Q?FICyjNpEIPt2kvmDEFzpi0bGm7RQsDrnHU9q0zS2ZtdiObqJ8+73x424SxHX?=
 =?us-ascii?Q?cqofwkadfQCMP+IXmQqE5X6oElLeJxWhE31w7IyLWhb6vrAuwt3whRJv23P6?=
 =?us-ascii?Q?z4YQgazgKWp0Y/888/7yzRFgGrSo/GxH2ZZmmhHdSuKAMIIOfuu93pVQsEbK?=
 =?us-ascii?Q?Is/Pta5IayRgpSE0shfWvflvft/WRCW0Fj5zu1hik/5lUAanQ6DU4C6qFHk4?=
 =?us-ascii?Q?/SbwqzG/FYR0psYCT/y+qMfAfGQFMdHNzKa3qzWDzURsLLwz2EFyll7Ck59F?=
 =?us-ascii?Q?woD22If6jXX+Nlz2nqRWNZ+YLNBpRoi+8nUYQc2DzNZ3DYlBHNJaFNSo1CVX?=
 =?us-ascii?Q?mQdFl6oPqIUKwm1TvDeifO0Z1LnTtTpg9KzL0h/7MgpXGxFoem8qxIacNzqO?=
 =?us-ascii?Q?2pNmLA+6C73GmreuB56SUeXJ3G50mEL2vZUX07blmaqO+WZDkQ/NN5oul8dI?=
 =?us-ascii?Q?qwdagMw+xPfIXkZx97SyFkdn+++QYSwL8yT3Wchyn47dvUR5VAoPe7+aKhVp?=
 =?us-ascii?Q?a+YeLfJJEW2OxIV6wdxJGtHsAgaN8jqcho8OGlz7QHQBS9ly2UXGQ1KGxpU0?=
 =?us-ascii?Q?Ptby6V7LaaUQOjt3q6vjnpElGkeH4SZGHgKLH1GNpm16so9qcd7w6zocwHCC?=
 =?us-ascii?Q?nW7qWuUICn6u5vkzkVUlW9pmeKxqkDNHROOF5gWarg9TTfWIc7rQ4uwfKlEc?=
 =?us-ascii?Q?wrGe9lQHTexZmdZYJHzaCT0u6PJfvgJ4aLx2WP/G6w3lgTQOpisLuaw0wrMi?=
 =?us-ascii?Q?k/XRMoJrhCm6C0ACql/TcTBHsgQtojLSeEJswtaiYuiMyoSd9sOXMEYZa9MG?=
 =?us-ascii?Q?P9tE2IGpC50znMkxMa+G1fO5RAleb+AP/uhb6Ex0WM7KDCXT1uByEXUlcx1E?=
 =?us-ascii?Q?2E691z02XaWmMU1YT68hFVC83wgVyszduS7oBf0nf4J7uJaYlTFFgD1Lz93e?=
 =?us-ascii?Q?WqO/GsxRIQM6wiWU1HzT6c8iMBPc9bSsvpU6hcMkC/5pNON4Dt3btmMNwl3k?=
 =?us-ascii?Q?v4Iw8H3iPKMJ5w2B9XF4Ys3hMA8k9/Kh7jpyghJKiCt8FNr222BUGfPlajvh?=
 =?us-ascii?Q?Eo1BuntI7wwYsyAAdxukmvCZiy8Tt+RJsEuR5DfDKGldFBNZeDwOEokgRv8S?=
 =?us-ascii?Q?R8BJnOLn1+REW6O/mh76oQLL4q4m0wUI3VANOLAn0gkORBAyYuNtxybgeT+U?=
 =?us-ascii?Q?kwqYUWjYmw1cOWG1UeDO00yKi9ieYumlsV5rpkH08Ttk2gPGB6Oj+aTToQYX?=
 =?us-ascii?Q?NMMUxJlo7TP8jurk74jP1UQ3LQGzii3vWp5IZhEov+pWBIimvb1YLlQnIuuq?=
 =?us-ascii?Q?WPuAuONF048/NoKKQwERgVbgI8aJKKQKRWFyUdgJ8Z0Rk/FKlby+bZ+a/9O7?=
 =?us-ascii?Q?XUfxQlTsbCgNrHCl09qpUNBBODiVX+duEVcdHN0gsTIAf8VPzdO5bjh0kXrx?=
 =?us-ascii?Q?D3BrvSj+t1VFIn0ZU+TAl0kiJBfxC2j3uGafLks6kfnarhOl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f20ed5-153f-47de-e0f2-08defc78bee4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 16:01:06.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5+EusFaKOrPFTcyMrJZyfr1VoLMx5EYXHzPD0iGXLvd4Qeuqp7NKYkyKIlNlkU838nClrDx2aVyO4BOj4pBUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9758

On Sun, Aug 16, 2026 at 02:20:32AM +0900, Baul Lee wrote:
> in_dev_get() reads dev->ip_ptr under RCU and then unconditionally
> increments its refcount. inetdev_destroy() clears the pointer and drops
> the last reference under RTNL, with no grace period in between, so a
> reader that fetched the pointer before the store can increment a
> refcount that has already reached zero. That resurrects an object whose
> RCU free is queued:

This part is fine.

> dropping the resurrected reference re-enters in_dev_finish_destroy()
> for a second netdev_put() and a second call_rcu() on the same
> rcu_head, and if the grace period elapses first the drop itself is a
> use-after-free.

Are you sure about this part? The reference count is set to
REFCOUNT_SATURATED when you increment from zero, so I don't think you
re-enter in_dev_finish_destroy().

> 
> inet_netconf_get_devconf() is registered RTNL_FLAG_DOIT_UNLOCKED, and
> rtnetlink_rcv_msg() exempts RTNL_KIND_GET from the CAP_NET_ADMIN check,
> so an unprivileged user can drive the reader side. Reproduced as UID
> 65534 on v7.2-rc7:
> 
>   refcount_t: addition on 0; use-after-free.
>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x14c/0x180
>   CPU: 0 UID: 65534 PID: 655 Comm: j1_poc
>    refcount_warn_saturate+0x14c/0x180 (P)
>    inet_netconf_get_devconf+0x4b0/0x4c4
>    rtnetlink_rcv_msg+0x434/0x4d0
> 
> followed by the matching underflow when the reference is dropped.
> 
> Use refcount_inc_not_zero() and return NULL for an in_device that has
> already reached zero. All callers already handle a NULL return, which
> in_dev_get() gives today whenever dev->ip_ptr is NULL. Callers under
> RTNL see no change: ip_ptr is cleared before the last put, so a non-NULL
> ip_ptr there implies a non-zero refcount.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

FYI, it was actually mentioned a few times already:

https://lore.kernel.org/netdev/20260802115639.GA270646@shredder/
https://sashiko.dev/#/patchset/20260731135202.566337-1-david.lee%40trailofbits.com

> 
> Fixes: bbcf91053bb6 ("inet: do not use RTNL in inet_netconf_get_devconf()")

I think you should blame commit 9d40c84cf5bc ("net: devinet: Reduce
refcount before grace period") instead:

1. in_dev_get() was called w/o RTNL even before bbcf91053bb6.

2. Calling in_dev_get() w/o RTNL only became unsafe after 9d40c84cf5bc.
Before that, inetdev_destroy() dropped the reference after an RCU grace
period.

The diff itself looks OK.
