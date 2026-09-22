Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24233C1F4F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059345; cv=fail; b=oK7O59Ahb2UiwoU8BCPlQ4trZhPycZXv3qdTjpab21FrcKQg+/qSY1oUSg850hYsZ7NoSBcJ8wUbwnZm0Q4Rygb/sQrR5Pcz3+qz1aDFZn0l1I0aFBGlGzgJHy6lcyQYEAx2S5ep3/9+W6PyXN6hZt6xzRsNMPDpeAYcq548hM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059345; c=relaxed/simple;
	bh=Xy41DsEmpuaDvOQw0ljsfkccEKqqqlgjlbOJeuYCC/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TE8uvULUPxw2J9Lpdz4Ny1mywe14aQskUM4sTL4ddwSIreRZ+31GQzrBAeUUmLWUcW3KSHl5pttYMsGQ4w2nkySVYx7oMhv+qCdId7sjLYoR4brilkvxqLxRPIuUC9uFcIESZBVyf+NVX1+j+r7nFCbMEiibD0lUSL7k8NgZ9lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g6tUl3vB; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g6tUl3vB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5nAOSDttCjiuJnGbDYn6/wvYxN3FOy8OKwZxNN5qhvgFuBpzg2UItDCu8IcDEgMktwJtwZNTEcxSSNBJnxbdPM5uIrjoFQlWqmpFXtetqoLP6ABk7hkJWD6yl07AqOTbDfTX0qSBb4qOatJIiGIOd5BMIKeQSITpJFWGRAC/g+MdXk0Ptl/BY5+FM2/nojnbQihSiVc1J0rdUns44mDvpwt7meiB93fT4DmyktNHNQstwjc1C6HCsVmv7TZ0jd6NfvUzeICx+hqjmhgipHako/Q+oUyZ7DO4IJE1WambDgZEN5BH0UqC/Pc4XbyX68tSIDV2n0HOUEhx+ni7fTQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vslNVU+p3abMQpqnxWDBG8oS9UrijgCUBeI82dyxgEs=;
 b=TopxMcK1t5QcUsKrDxCz0uIKOG36q+JzRLN70+e1ydIzPh4eWT9j/7HW5jpabYPgcUGeqouP6dt9B21tK3Pn00C5WsGWhH4WvrENZmHqwFOzsLpLcqMha97HGzPcxxJgimOIZ4eoc9Og1HxK35RA2xfvK+gkg4nsX1aY81etFR/LO81fIj4oOPLtDatb3RycUymHvv42ftB5U5shKKKg4G5BuZBsNXpJbAOXwkPc7FmfbV7QP2NeIjWkqEXRhqR+hsZ0A39oQxQ+0zsu9VTi0aIBuIh38yBTPmQIAjE/0PHlZoIZDaa1ghzkBAZWVkhRC6drq/1xIRr0IBN9951zQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vslNVU+p3abMQpqnxWDBG8oS9UrijgCUBeI82dyxgEs=;
 b=g6tUl3vBSgKPEpKZHKakzwpB3BFWV7I6aAEQJBHgolG40P1laBawsKNGytpRiKctVh03G94R6EXxNYzKUqyqaOTquJW7Kx9AWK3g2WxFOh3lef/gcz3O0UBRdUASDC3W5d+C5lFzVKsnPeEp+aGkIrPJbrOUiIKlgmdgdy9motvQGsEmxMXee9w5+oHXqZqvXFt8McAlONJgCOX5xP6C3JFoqs3kpvmnRWdnxz4EwOSX7ksIW8h4G2i4RRaw3M0PGP4rzi/iEfy5+hPcEi6JiqZQIauqQWJQWtxiMgqTnxSlX5JwBhic6VsXXuKwCgfQKIvuYbP2JGKWpL/Xsn6jPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 06:42:19 +0000
Received: from SA0PR12MB4367.namprd12.prod.outlook.com
 ([fe80::2815:8a95:1a44:be1c]) by SA0PR12MB4367.namprd12.prod.outlook.com
 ([fe80::2815:8a95:1a44:be1c%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 06:42:19 +0000
Message-ID: <bc5c6362-e310-4b01-a033-c586660fe6b5@nvidia.com>
Date: Tue, 22 Sep 2026 09:42:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 0/2] net/mlx5: Bridge, fix remaining switchdev
 ownership gaps on merged eswitch
To: Bernardo Soares <bsoares.it@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 saeedm@nvidia.com, Vlad Buslov <vladbu@nvidia.com>
References: <20260918095931.29792-1-bsoares.it@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260918095931.29792-1-bsoares.it@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To SA0PR12MB4367.namprd12.prod.outlook.com
 (2603:10b6:806:94::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4367:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 6053e408-6749-41c9-eeff-08df1874a5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uolO4a5edJrkTZLI1BHaPRfgA1WPdlC85PpzEJ94k0GVhVP3zatODfXfH45mLMsL5r/n3Io/flb3Q6JSSBu1WRYTGXiFE2wySA9S5DJzgqS2M+1+h5cPbrjZ3Y/qi6tuzg8w9T1scr2pB5HjWzDiUJbklPEiInu/JPGRXgK39BatOucRKPUwyc7/lprJJDVpPvpBLAqOyrc33vFp7GpZncq657t68rCaV+q1VVyzyDSBvPtDZUm5k3H/096LVm2b4ldJ1miNatRKdetdGi+8TBfULw7N0OLpp/M5/PfIluPXijnJgBVQhCFBMIs99Os921CpnXLPuid/0El9GDQbrw7gx+cm61U6kkPt5CbGXPl1SMn7XfgIM0MZ9/NEIKwq/2PWy13+znWEcLzNv2Av7A7gdmuB7TRRnk6fGiPQqHDZ8NIFU7Qi3an0PMeXqDVTahPEejrYzEStRV9yTqxD9pOT7i2gbReGoH4Tlx1uQnZNYh29A/6sc4cvv6rwDYHhPJbZ9VELW2FTMLQ7tElp47laMNUOQOhCBrwbVWUgUkNaBeaA41ZU1bu4w8SFaGjB7C7r1SFIb+Brxj3II4htnZozrqFN87SisLWZ7x3DY97LadWarDrmBO8JAvRFFBugddT9Y/cj+z9MgPUrtBzSReYoT93BDzTCG2Wbd9pqxO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4367.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bm1zVHRoM1UwNnlvWFB2TUR2dHVwNTh0OFVweG1EUDBhMnhoalFPUUJ3c0ZH?=
 =?utf-8?B?VTRPcXVTc0xLT0tyVU1IK0o0Umh0dXFjQmtKZklvWG94MXJIcVJRendyTHRp?=
 =?utf-8?B?ZmsxbEJETlN2UkE1QUN3UlZkV3BGWE5WYm9jcWNYeEJYandlNld1Q0twN0ls?=
 =?utf-8?B?TWVTckszOE1oREdZOElWZWxacExSdzYzRGRnNUJjZU42WU04VFNMUjVNK1R4?=
 =?utf-8?B?QWpxSXNXWk55Z3BuT0FkM2pPRXFWd2ZvdDBZWVFXTUhabzJiTnlDbjltZGhp?=
 =?utf-8?B?SUtJQlh2VXdUdFBCNmhVZFhiNy91amtJU3dIcTRXRE5Ia3ZYYmxqQmgvTFFi?=
 =?utf-8?B?NjlvL3VtaGxCeXlwYi9lVVAwd3VybittUTFENFFFL1V3N1I5UGlFMklaVFhH?=
 =?utf-8?B?bXlGYkdzcE52TGV6T3RrWWRPMnQrNDNOaHR2WjE0S1gvNFdKaHdHN29zbmww?=
 =?utf-8?B?Tkgwc1ljREJxUm5DNDFqK0dSSFJqaDg2d3c3eHczNGh4eWdtWFB5b29UVTUy?=
 =?utf-8?B?ZUpVN2ZyejJGS2FHeEZQRUU3cmlhSDZ4YVFxck1qTyt4Z0NnZEN1aVBDNTB4?=
 =?utf-8?B?d3pieDhaaVNtdzQvcVp2L0ZBV2QwK25oQ1ZVMlVhWlBhRUNxY1NFOUJiMnZh?=
 =?utf-8?B?SXY2bEtMZWFwVTVjanVLLzlzOGFCQTNCWWlvdEgySGF1VmNHSnVYeUF4aWZu?=
 =?utf-8?B?QWZMU2RiQnhxc21LQytiTmFFaEV5VTRTZXFZZUQ4RWpPM0QrV3ErQnZ5b3hv?=
 =?utf-8?B?TmZZMnUzSlUrbFU3MThVTEsvM0x3c01tQnV5SkdONVMyaFNVOXZLRS9uUkhs?=
 =?utf-8?B?WkhEVFBpaXBEOG93YVZ2ZjZ2emI0S0ZiRi9EeUVCSm40OFhWYldHNkUwSHpz?=
 =?utf-8?B?UDJKbkVMZ2U4QzV4Ym1xbVo3ak5yL2NteUZWUzd5NFNYK0pVRlVNb1ZJdGQv?=
 =?utf-8?B?ZWprbkdLYjhwZnl3VFRwUGE4bEtEUVQvT0t6MmJzcU5aZnlMMXFJd256K1M4?=
 =?utf-8?B?Z3lNaWVQVzhmQng0QzRwRnZFb2xVNmErMkoxYnRyUDB6WkdFMCtnekZHVzZm?=
 =?utf-8?B?MnB6WFBFUWE4QkJRM2FsY1p5TkxLaURHVm5GWWE0MkJNUUpVSGdEc2xrc3o4?=
 =?utf-8?B?Tml0MEQzK3lsOTl6OTA0Z2pyR0VtZlRDcEVoei9qTFB5UUlNS1FiVUlQcVh3?=
 =?utf-8?B?R2t1WDQxWWE1YzhoelZwenpubXRoNUJ4R3YvWnl0WjZRQVB2NnlBVDYrckls?=
 =?utf-8?B?cVh2RFUxYitrN0tmc1J4VTcxMGk1Zk9YRGY4NGlrOWNuOHJLTmdCS2hDWkov?=
 =?utf-8?B?KzVWMXV2OHlNTWR2ZEJPb1RQcm5MLzJHZG5wU01mSmxLVHFDcXU1MWtGWUhU?=
 =?utf-8?B?L0Z0U2ZzbFZGZGRyK0twLy9qbmtTV1g2c0J0TWpuWXNhWXJjYVZlVjdTQXZz?=
 =?utf-8?B?OW5LN1hhRGxlKzdYNUprTW8zVFgvc096RElrOU11NVllcEpWTk1lZFhZbGJV?=
 =?utf-8?B?ZDd1bE9peEdNc0lrVkY5M0xTTVhxall6QVJidCs2d3VieSttZTc5TlFaYVdx?=
 =?utf-8?B?WGFaamwzbFdaSGhiUWNLcGxZeERVOVJNTWR0NzhQNlYrTkNYZ1lKejBZNUx6?=
 =?utf-8?B?SmFUaXNwclNHTzBzUzFWbjZnWXF6M3RjREhuT3pjdHorQjFSMGM1NmgwKys2?=
 =?utf-8?B?dk0zbUhUcTlOcm90dEtFd2M1RXB6QlhoclovZlduMlo2UGxZTGFrdXpIRnVP?=
 =?utf-8?B?dXArNUE5YzF5L3p3WnowREVYa2N0UWlHWFNjYW96dEY1MWJnMW1USjFWZzNN?=
 =?utf-8?B?RmpVYVkrcGllU2hPZ29ya0p2ZTFER1h3ZHNhRmU4K0N2emFwSG5sZVVUQmxz?=
 =?utf-8?B?WEdkVEJGTnVLU1oyL3g2R1d4V0c1RGw2TnUvODAwdUxrVlVOamZRdEpSTVpW?=
 =?utf-8?B?MTdGV1p1d29qQlBUS2NKdlRBTjJlQzlmKzM0MUxzQmlNNnhmVVd3azc2S1ZL?=
 =?utf-8?B?aXpwM1dzbHUySm9za3N6MWwzZGpNandqOWZGeDBEbktybGgvb1p4OFFURlZ4?=
 =?utf-8?B?TGxTdG9naFlaNkFRVU1aZzNabTAwa2F2VGtZZjQzK1BldnYxSGIzWXBPcy9H?=
 =?utf-8?B?R3FPYWFEUm8vUG8wM2ZYbkMrSGRvd2kwbmk5ajVlcFVybnJMeGQyQWxQRUpG?=
 =?utf-8?B?djVPSnJiVlhRY2ZCRVJORTBOZDJTQVhrMTR4dUsrY0NXWmlkWlpVdnRFNVY4?=
 =?utf-8?B?QWIra1hFZThDTndiZkpNblJEV28zdGp1VHRDY2krVUl2cUE5cU1uRENpaStH?=
 =?utf-8?B?bjE0K1VVazI4Q2kxZUd2bE51aVNxeTZ4VGNkVmtvam8xUGp1cXkwZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6053e408-6749-41c9-eeff-08df1874a5e1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4367.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 06:42:19.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ji66WLu7cPor9IzRTO+CiqZ+zHbJttUaRKv4SxdWLB8y5PguJOZZ4bS8XUbBYprgqJxz0aeKodSCvzg1YOozkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588



On 18/09/2026 12:59, Bernardo Soares wrote:
> v4 of "net/mlx5: Bridge, don't fail switchdev events of sibling
> eswitch ports" (5f324c5d1b12), addressing reviewer feedback on v3:
> 
>  - The v3 commit message for patch 1 wrongly attributed the recursive
>    lower-device walk fix to LAG bond enslavement order. As pointed
>    out in review, mlx5_esw_bridge_lag_rep_get() already filters on
>    mlx5_esw_bridge_dev_same_esw() per candidate and cannot select a
>    sibling's rep. The actual bug is in the generic recursive walk
>    used when attribute changes are emitted against the bridge master
>    netdevice directly (a bridge with representors of more than one
>    eswitch instance enslaved, no LAG involved): the walk returns as
>    soon as any lower device yields a rep, and the underlying base
>    case only checks same-HW, not ownership. Commit message rewritten
>    to describe this correctly; no functional change from v3.
>  - The v3 commit message for patch 2 claimed a "replayed/duplicate"
>    NETDEV_CHANGEUPPER unlink as one of the reachable cases. As
>    pointed out in review, netdevice notifiers are not replayed, so
>    there is no such duplicate delivery. The actual (and only)
>    reachable case is a sibling instance whose bridge offload notifier
>    registers after a peer port was already enslaved, so it misses
>    the link event and never tracks the port, then genuinely receives
>    the later unlink event. Commit message rewritten accordingly; no
>    functional change from v3.
> 
> Tested Patch 1 on a ConnectX-7 NIC (MT2910) on my single NIC system.
> Patch 2 requires a multiple eswitch instance setup, so I wasn't able
> to exercise its code paths.
> 
> Note: v1/v2 were sent From/Signed-off-by bersoare@isovalent.com; v3
> and v4 are sent from my personal address (bsoares.it@gmail.com)
> instead, for unrelated mail delivery reasons. Same author, same
> person.
> 

For the series,

Reviewed-by: Mark Bloch <mbloch@nvidia.com>

Mark

> Bernardo Soares (2):
>   net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
>   net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer
>     ports
> 
>  .../mellanox/mlx5/core/en/rep/bridge.c        | 45 +++++++++++++++----
>  .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 15 +++++--
>  .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  2 +
>  3 files changed, 49 insertions(+), 13 deletions(-)
> 

