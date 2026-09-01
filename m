Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3064431A5C
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276908; cv=fail; b=kJVLbTlOlRhySDpmsmiQEEXOLXtAOOrLnkbQFhH3gbkMdk8BVxS+w6749YbUKxfQxWGXr3PmIaibXu9nqLc1Bu/UIc8CoSAYz8zHDpSxr3RdWBRVTFSA7qSiXBdTgqh3IpgoTbofBJETzZdie8RoDQcOeRjSNrX6i2A/nnjmC+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276908; c=relaxed/simple;
	bh=fy/d7Ree5TYjgo3ippp5es3KQ5Ekqt+0qUWXzhCxWT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V/+55B8kOScugiJaVoyCXoO7n5bgirg7AMI6lvq3cmtYhzCBxEvzxkawX74XePLG7t/ZDA/06RF6DTqTNDXLoRWF5+KGKzmLz6omQ5fuP+x2P9uyq7USiEt7QORm1Q4kbcC3w/zMIX7ZHbcuVFxcOcNE+byod86Q7KBgRlNr5R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qXh5E2Pm; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qXh5E2Pm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3Sizm5RC5rVFN/RJMSLWA8DLeyyTqzIo9/79iPHJ1MvLa9XJhP7Kb6peQCtEm4SRBnl5EzlPxezMrf0grE7qQbh8DoZ3JbJyTtdyLsRv8epk7QoB7bLT7dq07/Iq0seHESmzarqvFRFexJejSgua6wYwoSWGQWrdCwHK2egPQjoeMbhfFirdi+HiAkCHAJKcajEUjIVWtFUBsxUXXHsiRMbS+CFk9XVH5eI6uO6VGoUpk7reaDaecozufFXYCxzH3crHpI7D5KjUFKZQYc3w6I2mWZbt7dV4zfaGCcss6HNgHFD0uRiJkD1rY9aGr/qp4wCUuamKE6k5VONMfVI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vq9Tvd7kWC5AstTqAG9NQrgZ0Z1s37TVUowXsBS+C0=;
 b=ByEpJAk87JoE+ZyLRcgSJb/ZNznO63bd3fYq6S0BhIew2+I2SJJ8D0yTgXNbhGegpuJ6p11j+tYMuKJzccL2nkrMyfv8dKw36q6EVWdGaII1YyEi0KQM1A+kuMG3nXHQJuM2STJ9sINZPtmpWgAs62Yuw04sGFydVYKMoxsyRUd3lwWrLI1dfr6TLUGqL69BSJ+wzC3hRlRb8nG+cSpT5pZjr3I96CP0Pywte3BTMZ7H+U+h6h0NO8EdvpTKPKuTjX7EkKy/aipdICvA9zMGdwrKoh5otWW5p+MEJOLTih08+kOsNccy0XU6x7XPIg6nlvcA1SIil2pqZGpBPBXXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vq9Tvd7kWC5AstTqAG9NQrgZ0Z1s37TVUowXsBS+C0=;
 b=qXh5E2PmOB7lyrJFvhoHh0cn5USIhi9SKqRK2eCQGKA3yCCcrOTXYH6GqS5UuUfPBCFkRnuWZEOA/MhOq6AV5ihW4/3xQoaT3aqF1rexnipyVIJIZGpM4a0hCyQ4GwswZrh/WOJEAr7tz8qIJcwrtG0d0UMlQAEgfhjkrQ4evjSVEnxuAd2xHtts1MDw7KAUC9wepG8kxX+XL3MOEAeEeF6TQr0C0LiEUY0CVZZI9Jwo0SBLfJ19pSJNfmd7i/K6BFKhZPhlSksDB+iTcWs0ufSg+hIT9gc0QR1jJWM7WGrOWTmKvsTJAckplwbXiMMiDZb6y1rq25qH7I6OXSjtlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:34:57 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 15:34:57 +0000
Date: Tue, 1 Sep 2026 18:34:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Martin =?utf-8?Q?Jab=C5=AFrek?= <martin.jaburek@suse.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: Re: [PATCH net-next] selftests: net: add IPv4 and IPv6 same scope
 address order check
Message-ID: <20260901153447.GA3578336@shredder>
References: <20260901082200.15570-1-martin.jaburek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901082200.15570-1-martin.jaburek@suse.com>
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 422e1ec5-c628-46b8-c3fa-08df083e9405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	XT3KERS+FDr+mvi92lSbdKiUA+mA+B+ofMsEuhfHLjpqaNAmma+OFzmSbmsGb1R51R/ZfxhgeJ5rXIm29t4TuHMmFZgV+PB6Y4htakPrOk1X6JzcErE8plPoME1HV2u/zRCPbWGIdf1lfpPO9TLeKP9jV3jlaTbnvdtE94y8lcIOW98IVWXhF+mCzLdjwsV9r8f3sYduUBLszONdBHd7dSd50oTuygtf7SFCyBtIWKLc4qrMN3munFrqbcPjwKF1QnMGS4F+DYGFmSSl+V6jC3LOmqG3BV/Q3F+KirecmXc9KP1R2K2YXLBMG8krySMDzAt0zTQxtTH1kHlOA89XPMzErZEq53hYLS/LvKz5ZQiiRVH6Dx0N5Drw2KcGdp7+sI8OM8k+3pKgGHy4gxdbCFPUDQdduSi53PN4n8xfh5wGyLMXJUSIHg64tOGdZTy3LHWcSGBEsbmaeDDM15TELc0X4TOaL1OtcYpDNRnRTxfQ367wal1lGHABm7lYCadyCb/zPI/zzJ0VZX8WVrfYmoV0hodDcDiiMUVhq3MXC1fiVi05xEqUvutk9kJFsZc6SCsglv3B5+96ZWCzljSXFs13xOpyWokqDnOAPbMdmkFo174rYNVAy+6NWXgAiQJKP8t249U5gpvUOgxLvgBoUxCF5rMaV2ddEAlle+E57Pk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVlBaTR1bEY5Vm95T2VRenZSNlIxNllLU1hCTWVBdjFaWktBK1VPRXU0VVdB?=
 =?utf-8?B?b3llWjZYdUIxcDNtcDFPV1UrQ0VBUDVRWWFYaXQ4TmthaG13dzkrQ3V4OWxV?=
 =?utf-8?B?Z2FGL1pGT2xIaFU2MktMb3F5c2x2QUt3UGl5RGRDS2xjdzNVRjQwUGx6MmJU?=
 =?utf-8?B?SGppMk9TS3c1c0Eyalh4dWtFYkNRNjhBM2ZOU2p1bUxFMjdEcGY3MkY4SC9o?=
 =?utf-8?B?N1dnN3RkOWsrSWxiVmFnNTZzTHk1NVVDY0RnWTk5MW1WYURZUXJqaGZ6aVFW?=
 =?utf-8?B?UjR2anY4VGorODVoNGpmVXpBUXNrWk00NlRJMVVuY0tyRU1QRFJUaXVKS0lW?=
 =?utf-8?B?MmlQTXUrTTdwNkFWUlpTREFZZzZzTkZqYmNwdDhSeVBIUDVERHNTaDZxeC9j?=
 =?utf-8?B?bWRjTmdZaERld1dES2RDSzJRL2VqUjVrcTExSG9YeFpuVDVsWlRZcEJ2S09y?=
 =?utf-8?B?NUNZTXluN3paWlFQTjBZWHY5UE9IL1dzSWNyQTRxVXA3NW81UE95V0d3MWc4?=
 =?utf-8?B?MVVuVXF1d1NRdk9VL2puUlVOUlU1b2VBRWtqQjZHMTFxMWRGdlBYUmh4dEpn?=
 =?utf-8?B?TEl4ZjRzOXQ1cHViS3hoVkl6YkcyUjBtWTh4Q2lyaTYxQVovRWVNamNkMGsy?=
 =?utf-8?B?bXhHMjRnM3FYM1lZeXcvbFE3Qy9mM3JEcUtSWHEzRHNlRXhlV1BFYUw2WGt4?=
 =?utf-8?B?LzBXMXpXakc4VUd4NlUxeGM2b2VyTFJGUENsR2JYbXZpUmNraHdGLzAyNUFE?=
 =?utf-8?B?TWh1YjlkRG1VZE9xdGtRQjdIcFZiWEEyeEZoV2tuRWpIMUZYbkM4Tm4wVkVo?=
 =?utf-8?B?M05tS0dTN0tsdWZUK2lHTkpKdm92blhNcUY5VStOMGtmM0QxUWhmcWQ3NXR4?=
 =?utf-8?B?SW9HeXE1b01OSXkwWHNjbTArTmoveGpXRHl0RkdEdlpNUTdqZlhWR1hlbmw0?=
 =?utf-8?B?MXJpVEhLQW1mLzArUDIwVERWNnJlSHZQOGozV3RaOFE3d1ZkM3lsakV4Q2pa?=
 =?utf-8?B?MGFVbjB4MVhhTUZpZTRadEd5WVR6QXk5WTB2bllaOWQ2djJ0anN5WlprM0Jy?=
 =?utf-8?B?eHZ6SjhvWGYxditPV2xYVFc3Q1ZjS1Q3NUhzdFNOUmt4eWpqZGlDdGlRK00r?=
 =?utf-8?B?Ym0rS3dobEFadXZYL1g3bWtWWDJuN2JxVzVzQ1FsZUZ4eHNvRGFzdVdPWHZ1?=
 =?utf-8?B?Z2tMVWhMd3JhZE01UnFMbEV0cUpzeXBURFhUVkNLR1N5ZWZyTUY2Mmw5MjlM?=
 =?utf-8?B?aml0TW5jUDBxeHJWLzRuV2Zha05NZThVQUpOb254Qzhwa1dPWnk4b1FXa2RZ?=
 =?utf-8?B?YnJjcDBEMHcvQnZkSHpsU0xPZXlNbE1Cd3pXeHU1Rys4UkpRUjVod0NiaXlL?=
 =?utf-8?B?cXJodlQrVDdIRlhjdFNWZGk4YWIzZit5OHRMbEYrRldyTmdaSFFpTTV4aEo4?=
 =?utf-8?B?OHZCY1daT3ZRUDRJR0hJc1h1QjVBL21SdlFpN2hiWGcwV3I5c0ZaWnpNNFZy?=
 =?utf-8?B?L3RTdmtYOTdtd1Riem9GOXJYOTVZVTdDMVRNdG5tNUFoNTczZlhMMW5aQUda?=
 =?utf-8?B?WDFES3VYZ1JIL0M0clhBVXFGaThqVnRwSmZnNEVic3JEMnh6Q2M0dnA2amlj?=
 =?utf-8?B?OU5laTI4cmM1dy9pRTlBbDZwQkVMV1pHUm0xL2F0RGtZUzY0N2E3RFEveVd6?=
 =?utf-8?B?WnJydDY2WmRxYjlpN1JKNnEwblNWMExrWW9MTkJiNHBzRHl6dnk4S3VNb1BV?=
 =?utf-8?B?ZVBJMFlhZTZLVTdxb1hNaU5CZU8waXNWMVNoenpQYUxEQ2g2T0Y3d1VnVTVL?=
 =?utf-8?B?YS96TlhkdmpxKy9wYnFPMndjM3FnMVlrL2RHcGNIMDhwcGZWTGJrOEpnZXRi?=
 =?utf-8?B?REwvRW1mR0NhR0N5SzZlVThHNnhKYzE0RzlTcnZ2dWx3MzJIRU05akpWZlRv?=
 =?utf-8?B?Y0pNY2FKZDJwakxwN2Vyd0x0Tkp2a2k0YmFOVFRvWU1TOFU3ZUdaM1I1YVIz?=
 =?utf-8?B?Ym1RNzh6Q09nY1daVCtPQ0FtYmN5cXhQZjBPVEZaZ2d5YXFqU2ZEaFZjbWFl?=
 =?utf-8?B?VEpSVjhGY3ZvVko2VTl2QVRmNnNudnNpSlVzL0ZmdVpKUittK1FhdW9Rcm1a?=
 =?utf-8?B?Skp4R1hkelU5VXc5LzRkUWhLeHlyTzNzRVJOR2NjZmlwR3NpVldMOWNrbmlm?=
 =?utf-8?B?SVVYRXZLQWYwOWE4SzM3SFJhVFo1RFhwSXpKOENKMy9UQlhVL1hHVzZEaDBM?=
 =?utf-8?B?RjZGSmJ1WGIrMS84WkVkNGhHM1ZtaG5TNXREcStoS3h2Y05ORzZzaXVQYVRq?=
 =?utf-8?B?cVZMWXAyTnNwNWZCSWptZzFGQW9RRFM3cEZ2OE9ZeTlkQ29DUUZ1dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422e1ec5-c628-46b8-c3fa-08df083e9405
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:34:57.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQrgWDi+ml9SSYDTVNrifAjNJ4SmbRtzCs2jT3zL/ODE20jG7w+5N2u5s78tct0SPElPt5Y7PnRNzo9ZML192A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417

On Tue, Sep 01, 2026 at 10:22:00AM +0200, Martin Jabůrek wrote:
> Introduce two new tests `ipv4_verify_addr_order` and
> `ipv6_verify_addr_order`, to check the ordering of
> a set of IP addresses after insertion.
> 
> The implementations of these protocols are inconsistent
> in regard to address ordering. IPv4 addresses stay in the
> same order as inserted while IPv6 addresses appear in
> reverse order. This incosistency has prompted attempts

s/incosistency/inconsistency/

> to unify the ordering, so both protocols act the same
> (as IPv4). This however caused user-space regressions in
> certain applications, which relied on the order as it
> was prior to the change (particularly NetworkManager).
> 
> The addition of these tests aims to consolidate the
> behaviour to prevent regressions in the future.
> The expected behaviour is the initial one, where each
> protocol acts differently.
> 
> Tests were verified on a recent commit with the expected
> behaviour (61eb236c41c2) and a commit making both protocols
> act the same way (cb3de96eea66). Tests respectively pass
> and not pass as expected.
> 
> Conversations detailing the decision process for creating
> these tests are linked below.
> 
> Link: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
> Link: https://lore.kernel.org/netdev/20260529112357.5079-1-fmancera@suse.de/
> Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Martin Jabůrek <martin.jaburek@suse.com>
> ---
>  tools/testing/selftests/net/rtnetlink.py | 58 +++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
> index 5cc3ebdcf08d..1ee604e4e5f6 100755
> --- a/tools/testing/selftests/net/rtnetlink.py
> +++ b/tools/testing/selftests/net/rtnetlink.py
> @@ -314,11 +314,67 @@ def ipv6_route_del_reason_absent() -> None:
>                          "user deletion must not carry del-reason")
>  
>  
> +def ipv4_verify_addr_order() -> None:
> +    """
> +    After inserting multiple same scope IPv4 addresses, their order
> +    must be the same as the insertion order.
> +
> +    See function ipv6_verify_addr_order in this file for further details.
> +    """

Please also test the inter-scope order. It also differs between IPv4 and
IPv6 and recently someone tried to align IPv4 with IPv6:

https://lore.kernel.org/netdev/20260721090114.GA2510713@shredder/

> +
> +    DEV_NAME = "dummy_dev"
> +    TEST_ADDRESSES = ["192.0.2.1", "192.0.2.2", "192.0.2.3"]

All the addresses are in the same subnet so this only tests the ordering
between a primary address and its secondary addresses. Please add
another address from a different subnet.

> +
> +    with NetNS() as ns:
> +        with NetNSEnter(str(ns)):
> +            ip(f"link add name {DEV_NAME} type dummy", ns=str(ns))
> +            for addr in TEST_ADDRESSES:
> +                ip(f"address add {addr}/24 dev {DEV_NAME}", ns=str(ns))
> +            ip(f"link set dev {DEV_NAME} up", ns=str(ns))
> +
> +            rtnl = RtnlAddrFamily()
> +            addrs = rtnl.getaddr({"ifa-family": socket.AF_INET}, dump=True)
> +            address_list = [addr["address"] for addr in addrs]
> +
> +            ksft_eq(TEST_ADDRESSES, address_list, "Incorrect IPv4 address order")
> +
> +
> +def ipv6_verify_addr_order() -> None:
> +    """
> +    After inserting multiple same scope IPv6 addresses, their order
> +    must be the _reverse_ of the insertion order.
> +
> +    While this behaviour is different from how IPv4 acts,
> +    updating the IPv6 implementation to act the same way
> +    has proved to cause user-space application regressions
> +    (particularly in NetworkManager). This behaviour is being
> +    tested for to consolidate it as being expected and correct.
> +    """
> +
> +    DEV_NAME = "dummy_dev"
> +    TEST_ADDRESSES = ["2001:db8::1", "2001:db8::2", "2001:db8::3"]
> +
> +    with NetNS() as ns:
> +        with NetNSEnter(str(ns)):
> +            ip(f"link add name {DEV_NAME} type dummy", ns=str(ns))
> +            for addr in TEST_ADDRESSES:
> +                ip(f"address add {addr}/32 dev {DEV_NAME}", ns=str(ns))

/64 is the more conventional choice.

> +            ip(f"link set dev {DEV_NAME} up", ns=str(ns))
> +
> +            rtnl = RtnlAddrFamily()
> +            addrs = rtnl.getaddr({"ifa-family": socket.AF_INET6}, dump=True)
> +            address_list = [addr["address"] for addr in addrs]
> +
> +            # We ignore the link-local address present by default.
> +            ksft_eq(TEST_ADDRESSES[::-1], address_list[:3], "Incorrect IPv6 address order")
> +
> +
>  def main() -> None:
>      ksft_run([dump_mcaddr_check, dump_mcaddr6_check, ipv4_devconf_notify,
>                ipv6_route_del_reason_expired,
>                ipv6_route_del_reason_ra_withdrawn,
> -              ipv6_route_del_reason_absent])
> +              ipv6_route_del_reason_absent,
> +              ipv4_verify_addr_order, ipv6_verify_addr_order])
>      ksft_exit()
>  
>  if __name__ == "__main__":
> -- 
> 2.55.0
> 
