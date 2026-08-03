Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6109411A01;
	Mon,  3 Aug 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769924; cv=fail; b=G8/71Nd6jbym0+eTl+rc1g1B09EB4ZH8Nr98F/mIrBj5pH/9+BTklZ1F/wAkkezDZGef4V8dqrjOanPm060yt0Lzv8a7E1JpvwaxEM1TGQ/VtrEuXNVyhwwLzoQNyQIXon8qRAkuN101Bfdu9wjIUWoznoq+BQedZYolfRpwWYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769924; c=relaxed/simple;
	bh=7Z+BwRqz478XU2CGN05ze/zLEiUdZn5J7Va9yHiLM2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p3CLEifxU58hxOPJhpJk8v0kUYwLe32/Bjme6ryafqRMVCGOc9mHmBMmz28fyOEGg3eQfdo8rPgQ5Y1bCoZGTTZOQS2qokywOsin9/IC9IseVO7mkcpouROAvaRs1gsXLhzdOZFRAavQYnhmZBfKXuKTjApIXN1AAYKWiTj9VmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GR3bCcr9; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GR3bCcr9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVqGYYmE0A6uMiP3G0S5oRvNlu6u+T8GBxzO7IOBmswtfDKaTTSOdfgc6VL+RjxpzAIk7FZoIhhrAAjSiv/m2cf/7aHrFPjllAWfKpopvCNjSB21wvjBk+/hDZCT8U2g8DqSH97gYJGrIq5TteWDftm0AFcNKSRrIPfJ6D6NgrVSZowfho0Vzxrc1HPpqGWxmMgUDJTOE8Ox3vTK5nhQSRhsYK1tdKyokZ0I73BAIfcHTuBStznymJ73bC4jWQfhQ5gEfb1UyQjh+VmtzKhB1Tj1UpNp4Qt9pSdF0YUj7+nRPCvgwr/Aa1dAflZJONbQ7RCunrU9UoAWIT5n4OOmqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ndcYIqgEDDxg3Dri9H9BChwA93tXe0rdYrnm+7uNjU=;
 b=zM3pOkeHdhEjBQ61FUiMa2QVABbNWxcnuEBXqotxIGp1MiCCXv73EdHr+6+m5kujJrBWsxhgnPupJv+p8tdS0iFjMgH1bRcaa8f3L9BB0EZOBG2AD3ShT59RVZZbMhEvzBZIuD1MoyCfDfBSfAFCXWivIU5ayQWQNR/l2A29wk2r1yKXlY1cHdqbT7QYvssNtGi4T0KBJn/mf5tbqpUlbmGv0YL1vtfiykKwRwtBuFuexvfEuR6pn8N7wkovkcoXHnfvc0IyUJabVHxeP6rSFtipGRnKxxZ4OWmU6Lw7YjvhiQqevSVazyAZ6yupDobUlH0EOkyBTsJYDTvzGDkE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ndcYIqgEDDxg3Dri9H9BChwA93tXe0rdYrnm+7uNjU=;
 b=GR3bCcr9ABKJsoPD1kkWiAyNWOcNIIFXuWKpW3g5FFVOU1Sn9HeU9lmoaEUXL1a8sQPgCyenpPTa9M2kY5QuWzR2LKy/4fZL2NtkAN4wJFa+pODFmSK9BhJblle3IBpnpsG57P9MFPVx0Nj9thygKHwo/nr1BLcnArRgHfWo2J2hmzRqvz03Aky6B88mpd1Uc7Of3OPEFbDhUXXzc83gsYZ1c6iOZiV+nWzyuBX+55efZh3NGdNucBhkg8GRpZkx1HkEGNGkFmSgXfMqgY7ToVYH3hIrDWPFVMTQX7kIcxDeYQlPVwqjESyp6kSPoQ3ZwB8I1BtrRPP4fq94Es0UeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV2PR12MB999098.namprd12.prod.outlook.com (2603:10b6:408:353::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 15:11:58 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 15:11:58 +0000
Date: Mon, 3 Aug 2026 18:11:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yun Zhou <yun.zhou@windriver.com>, edumazet@google.com
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: erspan: set lltx to avoid sch_direct_xmit
 deadlock
Message-ID: <20260803151146.GA766007@shredder>
References: <20260730082238.676845-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730082238.676845-1-yun.zhou@windriver.com>
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV2PR12MB999098:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ef445f-4ace-4f19-b927-08def1718fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jJKtU6IR8hlOFxx8w1098iHL7Ffr8z4zCEvVAoCHZ95sDKChZkkh/6g6kegBpnCNdZDz4GL6BX8pIEZiegG4G4VKe4im1mOE4DY17h9aTJYmwXkWEi/JOjc/iidJfs6SzQ9YlXrHHFZgxJo77A3vH2tZ6yViADgFz2MgaXnRyLJAORMeMA5mJjhiE/hKcAxI80UBH5amtgyHBrIuWUcz/9ZBthBeyvV2nfDsyAhw7JDFRhtcJOURKc/yrmSszHc0/U29ZeKj5FFik6NxZuOxJrK+LgSOZ8V+OmfcqLLbZU6669yl8ZdKNaKmKWvMQonxwuv5DgoL2lV7Vg+Bddi/+90lN5FzLAclxXxzEg7NwxB/fcwgciZffJffNYRP1l+AjsA95H6PqYki+UH1m5/tO/K288UMvHDpZM7kAQo3vO4YkEqSpFJBi1FrOjxf7LnWc/dz3SG6uSokGYIeYYTqfRbwObxS5DzdDKCTj5hr2Z6V2yBdXSrdfd5Utn15Bt3MsY/iJbaXvmPGuyZJ8FZu+qNZfLpb3e9+bNh0z/ftpiz96R0jq1ua6S5TxPSRUUCVhQqkxpTTAkqzT6CtjkdEkRtJDPmcJaR607GzIbBlCou/urgeHzZgV46lvy5zTJ8wTEc4ZHpq2C3ZJdGiq9BiUjJNDQe37S5cCW/M7GjOB/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d2wGZAr/fdSIxTRmoka8HiOCRYo1chRV8JzwmIdzoNv6Kjm6mY2ER6SG8CWB?=
 =?us-ascii?Q?w6MIDDg7cGXoQyhQ2a80zKQnKQ51SovNKMlT6MwvymvYYt5igDIZeD3O7R8+?=
 =?us-ascii?Q?pHlTzfFqxMLfyr8GwTeUhs+NgXVlC6yeGaxuwM0oUphGH2tdftgBbqUzciY8?=
 =?us-ascii?Q?zz1h3VHtdXpvXez5rSuK5TmYfJ6vdZFyLeQ4GCm+Rg64Te3T8vIxxKJpGw6R?=
 =?us-ascii?Q?Pw1A/fRKsuM2Qq6W5XEXwr/34+ZAjOawsdVBzZ5WhJrQoljaynX1np6rKaZi?=
 =?us-ascii?Q?o4IlvsDZOAy0F3TVPqoGL77KoGg+D1uQcI0FRHGIf5wEZGNBCPPAeLLhVsaY?=
 =?us-ascii?Q?JJAp9JEtUdNpIZ3aCNQi1eCGxYyt8RT67I8zW0uHxa+9nN3A2Rg359o43pIg?=
 =?us-ascii?Q?wAJ1a/R1lR66lcmrrJSuqn+ns0J9sr6irQOgkcsk8jlYktOfmMZIrwlIamJL?=
 =?us-ascii?Q?EmxlivlrX0Fgxmt3LoJFqgvx4mONGLHk2HiZF2uuPNqAItBsX/1c7dPZS4/G?=
 =?us-ascii?Q?R8ow7d0YDhw43c67Ng4U0pobtIxLCL8jURP/uTfWr/sKPJoLXNd61NHTzOOP?=
 =?us-ascii?Q?mKIoHn6d4bzDC5Nm+4adPRFSaD7Wykym0bnwdqjgRLlNaG8b2gWzXx3JFtNY?=
 =?us-ascii?Q?35iwuknqHXHbyblJXt+pN9QcUjpIhy/qWxz+6TexnylqPkGX9GuTWXC/P1IL?=
 =?us-ascii?Q?Kszfu9xfXQ+SEgmhH6aFlA/mAB/7i76Kxx7FUdYNTIpoQJ5+YdkCV1DXHtgc?=
 =?us-ascii?Q?h/5hpRMZhFwgPOHBdOTxeBwHh52EQoS5rb07AECUeN8L1tBvyRE6xJocukbr?=
 =?us-ascii?Q?IiImBHFkhAD0anI2uFPu5Vscn1N3lOXFnb+QhY36tMsC83E87dtQB6n7xcZQ?=
 =?us-ascii?Q?In6ivXYCznBGedMwP631SPSythnadLcTG1P55zH4pLVasz/GkZx1wBbY6Ar1?=
 =?us-ascii?Q?CAd0sx2Dw3dy4jilHB1VdnW/JT7TrL0f0k6IXGtDiqc9EUeMC3SATZgnKalz?=
 =?us-ascii?Q?HAmaaLSlinYePrAZx3fw509hcCYURHpGZeHM8MfQoYbN7/8p0x5/ErJbwjVE?=
 =?us-ascii?Q?IBX+EXyBkIRP3RMFb/hdHu5vQe2Bg6DxqCpOH45424him/yOUl/IW/iN5zlF?=
 =?us-ascii?Q?/vepB28S8OFYCBP1HYr+9qDqgC/DG2k2EDx2zUp4RBCB8EuKoJA7r1GhjKcm?=
 =?us-ascii?Q?ZT2MJuWmwYKIQ2XRp6TN2Nmmg/gkYnlqAF/Vj5YCiZ5RjTq6hlGv462WBQGF?=
 =?us-ascii?Q?S1n92np0TxLYSv28qiMct9l+8aC6WaO44xpltMpon2fvrF95NdqkoWvcXDJ5?=
 =?us-ascii?Q?e/nLmGtqKiuDP40mdPXMMQH1lSflmVg5YURfV/Z0fpdVaZdc0ttvBQKtYxUn?=
 =?us-ascii?Q?QBnUoZAR4uD4AOurRZ5ZwlzXPysccMeKao6kYhtSlpD9lNfws3jO2dx/JZgf?=
 =?us-ascii?Q?Itm9ikkDIuPDNdLf74sFeiZSJ5CaWTZvRjl1zFwNcGNwAD+56vfyDjNlpBru?=
 =?us-ascii?Q?WlzbE62dQ+z2E1u/EE2OEK9l/zhuQ0Ksw7815ajXkTOwmEhEEd64raRTwxYs?=
 =?us-ascii?Q?Gm8oEG288o5UPHOjdFylrpyv3FYau+vgHkU970peuREKTLhNmooL5lqkhDHe?=
 =?us-ascii?Q?KcnOTzKW7EA39EbPnZroNWgna8QRmiPvz2E+mOOAQ/Jp3cSH890qLc00SPeW?=
 =?us-ascii?Q?EhYLYbCAwhvP1OdvzNkcCHRbL7fE2XNuWjEvQGn/1m4303N90ZqYEbkcrCG/?=
 =?us-ascii?Q?/QOqHLaCng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ef445f-4ace-4f19-b927-08def1718fed
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 15:11:58.4202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYAOOnFNpfn6AcMQT4x/XXO5ENoWwmfog1cZr9naVAxFJXjChRV5yp8ZkJJSpxVyfsNv0nXrprDmGLBqGjxmdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999098

On Thu, Jul 30, 2026 at 04:22:38PM +0800, Yun Zhou wrote:
> erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
> nested acquisition of _xmit_lock on the underlay device while already
> holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
> the same lockdep class, creating an ABBA deadlock:
> 
>   sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>   ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]

Sashiko complains that this is not accurate. Clarify that both the
overlay and underlay devices are of the same type (both erspan or both
ip6erspan). Not erspan and some Ethernet device in the underlay. See:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260730082238.676845-1-yun.zhou%40windriver.com

And:

https://lore.kernel.org/all/83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com/

> 
> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
> This is safe as erspan_xmit() has no shared mutable state: o_seqno is
> atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
> the sibling device with identical xmit structure, already sets lltx.

This is still not safe and in v2 I asked to wait for Eric's patch to be
accepted:

https://lore.kernel.org/netdev/20260720075352.GA2233846@shredder/

And it's still WIP:

https://lore.kernel.org/netdev/20260720135132.3957146-1-edumazet@google.com/

> 
> Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
> Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
> v3:
>   - add fix for IPv6

The commit message doesn't mention the ip6erspan fix.
