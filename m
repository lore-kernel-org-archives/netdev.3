Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEAF281530;
	Mon, 10 Aug 2026 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358461; cv=fail; b=kpUWztRdnC6SrqIyt1OgoObfDjfTPHwjLxs2B55ghxWx0CcXcCn2clyqsWSv8+2FN45tFNnm1ZYiJb9gXy37V1SgM5F2ej7qLNmk3mtEBFHIbcnvyCksc4UcpcLuB2j+sCdlJpn4P8LpmzD30fQ86+rMzbCZ1YmD3q17h1ZpvJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358461; c=relaxed/simple;
	bh=K2aWi9U7ybnAxMiuktwxnznr52XfSKrMPiuKlqiArjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sjUQDgfhuLBXOQ4/KOzfrF4uxFFdUK8LeYrjUkC2g1QNd7fDhNO7djBZ81s6NKWhHyGMLrLcLFlSEzK3799PHuZmbHj1bDppWemYEZ96MzFt+shrs4gsEUc66mJihEhwPFDnIh2FGghzOxzWcXqWzJjlaNm2SWCastKRDDZBWHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rdz8Hvud; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rdz8Hvud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTtG4CT2U+LYZitsV8vwjh5F7UYWhk0kHInHesPXrxK2S0hvgbsLwYDxHJ1qKVM/EZzJqY/vmFMl2zxgPHJXc/gOASuGudkrA9udJawY0RcIOGvmf3rfyD8FxieIWygvzRlmYQlfTrZ3l9C9wb+7xxc6QRWxR5xqXY7vch2W5mwwUGm3SUD/OHFU/Ke2xef3TMokTrZqghPl320C3uGSLdVDQrWSlWAL4Ct4C6SmVzBkwLgD0TM75Y1OMODE64Dxrpo1Wj1ZdShICQXtdoyHJArPFDN1nheZZiq7/c1qGTBNA1Y0tP0ebAZmt9ySW088GOlKVbCFem4RSFGKeT5ePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FMGiAiMBmCYSjNEx0C79l2npPT5Y6MDIcsXK9YKAkQ=;
 b=Bo7qHj4ONkN1kv0tJ1hmxjjWacL9XYwCUuExcsl0C6N8gDWGV59+C9YGRWpoykAQuY5ngEydSJqCprxFmdLc4i2rsIQpzIGzi2Rwm7mH2MXaONMdT043gLZMheBV5bf7A88L59slaKMsJUBbBZnprUlF4U1Wkw0ysbuF4zv9gwYSk//8mGAVk+/i042GZw0W1sB/ggoOXSBBsGx1PLU2Sdzs3VvAiAXHJ/NNPbD+nCRb3NdWqERyBYvPvIp4xMvwApCNBESrV+3zEeSyZX0esvF33aTuHBfZwwOMe9qFueDirQ7xqDC9knynH2ZGHjQSQpbzlu/iU7zL9ZSI3ajdUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FMGiAiMBmCYSjNEx0C79l2npPT5Y6MDIcsXK9YKAkQ=;
 b=rdz8Hvudy09rh8PXNiXuVpLiOXxQorKnkGfqRboPljlgVRByKsTgcab4OrxW3x5ZTjA1k8Ju/qsg22Wr3cb+KRS9a5uM2KM/yMLxDj+lhcgrvBkdOggLiGdJfCDBjjQmxymp4Z+ZnTs06sX/bwhp4euwX2tDvrenq40oDa5XN4zTf87nWX3erlGPKi6wV8khOeYOpcq+xTACn2VtUYBoSbfew9atUbZH9aisiy70OVn+d8CdE41NI7Kar1/ZJV9WZ9a289bj+DgKO0udJ2jXS0V0SY0H96Q6khyp2/NhA2sXoVSl8WrC0hchTDjjyzQrEgrrq1U1plHwpROo4j13JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS5PPFBB8C78349.namprd12.prod.outlook.com (2603:10b6:f:fc00::660) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:40:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 10:40:56 +0000
Date: Mon, 10 Aug 2026 13:40:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Pimyn Girgis <pimyn@google.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com
Subject: Re: [PATCH] ipv6: addrconf: drop "BUG: " prefix from pr_warn()
Message-ID: <20260810103517.GA2626301@shredder>
References: <20260807131300.2677228-1-pimyn@google.com>
 <20260810095136.GA2582170@shredder>
 <CAJWNTGyLJubRHn2KbqQMeV_jqexSgaLbzTe+xJnGzUw=RUtntA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJWNTGyLJubRHn2KbqQMeV_jqexSgaLbzTe+xJnGzUw=RUtntA@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS5PPFBB8C78349:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e19332f-8c13-496d-fdd5-08def6cbdbee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004|4143699003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	tYTU2n0uuQ5KrhNYsR9CA5T2D226vY6hn+eg6c0pZ4k/D5zFWIBZ73Fb2O641ZSTGEX58BWEAeo1J3S3w2mwJOCoFZ+3DxvAFteUF97nEmGBZoQTlJ65oVL6oxKn4uj3FzMkAhHDYeFhokPFY+Dc7X6kjgU5+UUBy1RUM1S+OdGJKONataegUoJuKzjcg3iA1S+RSub/Dnv4gZKirxJmM/sjNgMoe9nlsq/KrcJ92ayPSwznb5gLAVlERWCMvD/DoUwbkZCRz1+0j/X/SDxVHSManF2wpiK1rLxMfg5H3JZJ1Xc3NqV9Eph3r4GVkkI7+pMknSn2ZIp8gD2EKpApggd+VdC9Gh/SrHYAPjhplOje38woixJQJh9Ta0TDUE6NwPSr6t57BUgW90Zu3UU2gUVaVulfNqN1832Zc7u7qz+pdgV0j9zN4HRw2g9WY05qnXkRr7fm0iz2Fln7/1k2z/82W9XAYdFyg1ep8zRgXFgVs7jFo9qFfiqAABfJd71iCAMOFd8GeBymZizzWIx7oG81oI7Wp1Jj3SRuJqR1i9jVpeERtJN3EIphewbgSIPE9pEiMlb8r9/9Vyu4jqoBQUGSahdo030AVWIUskzuiX232xfHypTu+tkdHq2L8uEiGn4gaU6YTLxCFGDM5J6RcPPKiUra7e1IWljdvQjJJeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXhKWnR0eEF1eC82TEZwd2VwTHhBZ3d5TkE0R2FROFpVNy95VEVUQnJyUFNk?=
 =?utf-8?B?WGxZc001TWR3NmREbmcxa1ptb3h5RisyMmlQWlpCUTNoMHRyejdMZ25xMkFQ?=
 =?utf-8?B?V093WnJMN09yYmNhbDN4d3YyM2JNL2NVenljeGNSVDE4TDJ6RmN6R2dpYnFV?=
 =?utf-8?B?YmprR3VnSkRLVTNlQ1VDT3lqdWJveG56dkNyK2g2RGtvblJBNUNuWHJkb3pS?=
 =?utf-8?B?U2VrcWV4SEkzTjAxZk05WFBUN0NIUzF1aVRhYTJiaDBnZVl3VVhNdDA3UER5?=
 =?utf-8?B?ZjQ5cEc1Q1ZQdHlqajlUcU1ud1RlbzZkRXdneTg3d290RmlCc0M2R3o2SWRL?=
 =?utf-8?B?aHNmenFaOWxPMkRWSmRzdTdVcVpwVTJzZDRucHlleTBPNjJmMXZLM1QwNm0z?=
 =?utf-8?B?RWJWUyt2dE1iSTFLSzlNZkx4NmtuQ0JXRUF0L3RCOTgraFZyZmtPRjN5WWJ4?=
 =?utf-8?B?WkQ4TElDdDFKK3VidW9xZlVjMWtBenRDZWtHaVlzbVNaSzJKM2V3UnpHMzFY?=
 =?utf-8?B?RlZwNUpVY0FodlNsRXJtOXdXVkhhaldsa1ZNRXp2dEpCamRXKzM2SHlmVUVm?=
 =?utf-8?B?N0JkYUoyUkVhOUFoUElQNFAyM0tkNG1vUlRiaGdhV0VuWWdSMDVPcXVOV3d2?=
 =?utf-8?B?bDhudEZVRDc1NXNQcDYzT3lmSzBNS2o4ZjI0OXpUOExUa1VvYk9aKzJ5NGcy?=
 =?utf-8?B?dzdhT3RxYitKM3BXM3ozdTNudWRTaUx4V09CWTVUbldldTkxa1lQSURGalVR?=
 =?utf-8?B?RTZuRHVFS2FQSlNZcDU4dmloM2YvbWRkbXlkYXFZd0dycVNlU1oyU2pUd2Fo?=
 =?utf-8?B?UzhlRC9mV3hRc3lXc0RUTEppekNhQzdwTmRETjNkeXA1bHY2WjUwblhzSHdO?=
 =?utf-8?B?aGRXb0lZeDhtcmNGMDRzakMxTDc5dzlwbEpMLzhTenJhQUJLclBpNkI0S21n?=
 =?utf-8?B?WHM3Z3czcHhRbWVaVUJvMXNwZUE3U3dPV3l5ZTR4d1pvSXVPOUR2cjRvdm0x?=
 =?utf-8?B?S2NVSGk2c0Y3L2pqc1o4VnR1d01zUzNYK2I1WitsTWxQNVF4RWVNWllpV2Jm?=
 =?utf-8?B?OTVCTjQvSEFuenU2b05kSk8ybHpGNDZWdXU5QU81TW1LR1c3cnBTRTZiNUw0?=
 =?utf-8?B?VHhvWFNHTmVYa3Bjai8zQkhJMTRvUDdKbXR3djBpQzRRUzdqZVBqMEtwWTNY?=
 =?utf-8?B?eDlpSlowd2Q0QXgvTlVWVHNpdjlYK0FTUkNLajdBVmk2bTMzaTFPc01qaGho?=
 =?utf-8?B?MUFpazVsQ1NybXc5SFdOWlg1emdJSG44cnMxTUVLbjRFeGttQlFoS2xLNlc0?=
 =?utf-8?B?Z1E2QWptSTBBRVpGMEoyanZiZUFkbUdwdXgxbGR6bXl5aytzbjBHdG9qM3dl?=
 =?utf-8?B?SVQrMkU5T3poM2k3UURIODZkUUlkbEhpNTJzWXNRWnpsUmwrM0t3Q0REZW5s?=
 =?utf-8?B?ekxueCtSOGsrN0s5ZGdxNmtLSm5CNUxvS3RqZy9OS3lsWWo0Q1NKcVJSQk9M?=
 =?utf-8?B?ejZqT3cxVEZYRmZuVWxVeTlaSzU3eHRPMHk1cm9hcm44Wm5VT052eDVJY3F6?=
 =?utf-8?B?RVFvMzZNQmZaN2owSnRaSGR5S2p1Q2dtU1FzMlZKMHVPNTJOV0o4QW8vaVM0?=
 =?utf-8?B?VFc2TGQwYnQ3RjBaV1FSd2xnUDZtTHIwNmR0WDBQUG1xMGcvU1QydUZhajhE?=
 =?utf-8?B?RzJzdE1ndEVwUGNLNEUvdVlxL1JqV3lVZlE0NzIxMFNLM1JJQ0hJMHlNdUNn?=
 =?utf-8?B?amNBREFjUEJWeDVnODZwK1lDMWtpbjljN2xBSUNtYkplcTlhUlUwd0FRUFVv?=
 =?utf-8?B?TjdqL2ZWbmVNS0pXOW9aUE1UZGRtMVQ1bVNOa1JnSFpQcS94Y1o4VkxZYkw5?=
 =?utf-8?B?ZGJZZ3QrMlNMWk5KQmhXSmgvR1NLYTY3dHRCYm5BV1ZvRk9kakFsem9qUkcw?=
 =?utf-8?B?Q1dyRTN0S29PMHdIVUFoZVlvZlRQT0sxeXVZS0U3ZXhFMWhkSVBoanJMcUE4?=
 =?utf-8?B?VjZ0ZmJGN0E1UFI5a3h1Ukg0S2pGVUptNkNsdEQyODJNYStWZzhFcnlTcGJo?=
 =?utf-8?B?UzJyWXc3K1pHc3ovL1ViTUJnaUtJRyt2UFk2QkhLYytYcDkwaGEvVFRiSllN?=
 =?utf-8?B?TVE3SG1ENk5IOE90clhLdktKV2gwMkVnUk9rTFBtZzJQOWxld0xZV2cvUms1?=
 =?utf-8?B?cU93bTJXSHZvL3FTK3JFR3pBUEJEWnc0bFIwTk5FNGViNHR6cWY0YTk3Vity?=
 =?utf-8?B?MEhIejUxYTlKcTFOenhWemhCWlVlQm1QU1dUMjk2WlNtQk5DVlV2SUdSSkt2?=
 =?utf-8?Q?SNug4uv1e2LOmkKZwy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e19332f-8c13-496d-fdd5-08def6cbdbee
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:40:56.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWAvN7fhfxWZ/6GVrZKFI5ezquhOx43+v1w4J7TNDkkQW/O/LYM/wdbFttTXcP0BzLyEWzSQrCbfGGu0hq9cbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBB8C78349

On Mon, Aug 10, 2026 at 10:54:58AM +0200, Pimyn Girgis wrote:
> On Mon, Aug 10, 2026 at 8:54 AM Ido Schimmel <idosch@nvidia.com> wrote:
> >
> > On Fri, Aug 07, 2026 at 03:13:00PM +0200, Pimyn Girgis wrote:
> > > Kernel warning messages emitted via pr_warn() already have the
> > > appropriate log level (KERN_WARNING) and should not include manual
> > > prefixes such as "BUG: " or "WARNING: ".
> > >
> > > Explicit "BUG: " prefixes in log strings can mislead testing tools
> > > like syzkaller, which scan kernel console output for "BUG: " to
> > > identify kernel oopses, panics, and fatal conditions.
> > >
> > > Remove the manual "BUG: " prefix from the pr_warn() call in
> > > __ipv6_ifa_notify().
> > >
> > > Fixes: 2d819d250a1393 ("ipv6: Handle missing host route in __ipv6_ifa_notify")
> > > Reported-by: syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=ded267b328e950a7c0c4
> > > Signed-off-by: Pimyn Girgis <pimyn@google.com>
> >
> > I am able to reproduce this (there is no reproducer from syzbot, so I'm
> > not sure if it's the same one) and will investigate if we can avoid
> > getting into this state. If so, there wouldn't be any need to touch this
> > message.
> 
> Hi Ido,
> 
> Thanks for looking into this!
> 
> Correct me if I'm misunderstanding the code comment above that check:
> 
> /*
> * If the address was optimistic we inserted the route at the
> * start of our DAD process, so we don't need to do it again.
> * If the device was taken down in the middle of the DAD
> * cycle there is a race where we could get here without a
> * host route, so nothing to insert. That will be fixed when
> * the device is brought up.
> */
> 
> It seems this state is somewhat expected/handled and otherwise
> harmless. The main issue here is simply that pr_warn() includes the
> literal string "BUG: ", which leads syzkaller to treat a non-fatal
> warning as a critical kernel panic/crash.

The comment refers to the case where the device is down, but the warning
fires when the device is up. According to the blamed commit, the state
where the warning fires should be impossible to reach: "Add a warning if
the host route is missing AND the device is up; this is a situation that
should never happen". I guess that is why "BUG: " was used.

I have a reproducer that always ends up in this state, so it's not
impossible to reach. I need to see if we can avoid ending up in this
state, and then it should be fine to keep the message since it should
never fire unless there's an actual bug.
