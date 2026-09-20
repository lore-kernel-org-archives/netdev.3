Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011012.outbound.protection.outlook.com [52.103.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E22343DEA3
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908337; cv=fail; b=OUL0/MF0GCESCN4U7ple26WqxLnzA6JQ6dq360vkxpz7FrmGoIacM+c6HETvweK31yFgAoxLubG+SPZPABJzAmocugmf3BYPLZOtrPf4d+ENRKo0n8Qu1k3cLZNps44CBXwgRhkxlCmA/cGpJMHKuyULH4vDYgKJhAnXUNzS2bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908337; c=relaxed/simple;
	bh=wUCcnSGX2OkQ9Dr0uzXzOu1FpFj8ymaU5ypapWNmsAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sUwVEJJbhikBVHZYIBPZTW+xOAbtRdnX4se+gA7wpszyRm8GIBXzEnKCe7pu7Sn4gmx/yIRhEyMRXbwmWXY3Y03s2kO7P7r5KeLzLpXn5NX3MZgFSGr0mSjo9Kf20MsOycha0iCXDLaTWH1KRDiGCR170neCyV4D5K4iG2R4qJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lyaujent; arc=fail smtp.client-ip=52.103.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lyaujent"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThVMwwKikLUkluVoUp9/bTYI7szxYvo9eldhffilvDo3Z5bSlhDqseblDd0B/YUQ0TPdizIMnyzjZABqmvVf8mOBbW/gQHJtcyK/NyOF02YKfmbIWpvCxTivpfsZfzmiVBq4zHX0hT676PO3k4zs0NyAmjfv2exvy3xYYZp7VeYLwnLwgbco2QCcx9c5+lDhKFSAKfObgavbhRuxgYCl+fi87LqVHBPzliiuRPd7H/ykClKNgjnjmKeq8uf/871QTp6hDM7vEN/xaDtcgFhuC/G3jc2OJXcc1OCX+0bTJlpoKUeUE82D89ddUnXUWYMJrSnN60IYYHjlzInnbQb2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUCcnSGX2OkQ9Dr0uzXzOu1FpFj8ymaU5ypapWNmsAI=;
 b=QPAxpQX4jr94Kwq+O+NxmzEng84QkBOOzCQb8BePuMjBRzRMg7wMjFutpIvihBUtkdExTxVgjHcZtTtd2K0rlKz+yloOd3VLhon9qxmIoQp4dho2G+FrWnPPxqKwwK6PlvUlh4btI8z2lyLVNeD4ZK2Jv0RPwgRxYQu70aaWaQBmhwapua+llGJSyMFnVlwj9+rYujAsXwSedyUmOEomM/yFtHKbFcE7UPtmvhQ8OMP5jzoPgkL7HfC/7O1mbIVmgHa00CclRdYtyid/hdvDTuLakThXFBTX4OqeNddy4ItsoX9J/srFQ5X8IK22GROkcZbWjUL2oTzRkLattQBxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUCcnSGX2OkQ9Dr0uzXzOu1FpFj8ymaU5ypapWNmsAI=;
 b=lyaujent1AHlxqcawqxN9+wD2F6Aq6t9Rdj7gMpSdAr5ZQqml4dkhhh9Kf7Xc4YUdVePP6YvFcorN6Fo9Dh12k/eoyaChLLFAHsAp1uSbPFweAdePA2odmqihhC3PeL8m8fw5UYbBiSA37GrhDJUk9u3aw3aMRvSOnfBQq2HTVLEtlHy1rZlJ+Jzm1ssmemo0Yc+tFeApvTqxMsoIoPpIX9p2Khc/UN928wSrUPBCD4KuKiiXwcDT387XEEn+F94ZK8sleE1spfTe1oDebUreHLhM62fuQK6gs2BO4q2FZfBPknUa1HE0zEupz0C/t5GFEjlqTpaMQnBVKYvswg9dg==
Received: from TYWPR01MB8559.jpnprd01.prod.outlook.com (2603:1096:400:170::12)
 by TYRPR01MB12479.jpnprd01.prod.outlook.com (2603:1096:405:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:45:15 +0000
Received: from TYWPR01MB8559.jpnprd01.prod.outlook.com
 ([fe80::9c39:42d9:c678:8bfe]) by TYWPR01MB8559.jpnprd01.prod.outlook.com
 ([fe80::9c39:42d9:c678:8bfe%6]) with mapi id 15.21.0428.011; Sun, 20 Sep 2026
 12:45:15 +0000
Message-ID:
 <TYWPR01MB8559447EBA7586C04E95DFEBBB852@TYWPR01MB8559.jpnprd01.prod.outlook.com>
Date: Sun, 20 Sep 2026 20:45:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: arp: reject unterminated device names
To: Ido Schimmel <idosch@nvidia.com>, Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jiri@resnulli.us, vega@nebusec.ai
References: <cover.1789648438.git.milkory@outlook.com>
 <7f570426c2fe95743f017cf1a14cdc7ace42851a.1789648438.git.milkory@outlook.com>
 <20260920070314.GA1791430@shredder>
From: Zijie Huang <milkory@outlook.com>
In-Reply-To: <20260920070314.GA1791430@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0009.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::19) To TYWPR01MB8559.jpnprd01.prod.outlook.com
 (2603:1096:400:170::12)
X-Microsoft-Original-Message-ID:
 <17a174d9-69cd-455b-8855-be8718983230@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWPR01MB8559:EE_|TYRPR01MB12479:EE_
X-MS-Office365-Filtering-Correlation-Id: ab043a98-e2a7-4f5a-95ae-08df1715050c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|6090799003|15080799012|5072599009|4140399003|25010399006|8060799015|19110799012|51005399006|24021099003|25031999004|3412199025|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SS9heEVnSjlDMDBDSE9oYU1XdVgyYTBsSkg2UGQyVFdpSDFybTdhMXpuakxO?=
 =?utf-8?B?dlVaS3ZWMERMeEQ5c25jYjRqMms5ZStEbkVNd2NDTm5PaWc1dkJJK0xKSnFX?=
 =?utf-8?B?VlRkVThscmFiUERvTXlPaXN6NnJCWUFFMGRJNVVOUmN6YURQY1NyWFJVaTlv?=
 =?utf-8?B?Ly9jMVZpai9jb2U2UWtmNmFlYjdLUlc0ZHZKWm51V2c5d0J5WmdxRFNjVXBK?=
 =?utf-8?B?SEtObkpCbTJPelRiZFdkT0o0Y0lacnZqU2UwUU92VUl3Ly9sb05iYUZjQXpH?=
 =?utf-8?B?K0Y1U2xqakRBZVpaUjR3MlVnQ05kMkdhM2EvVmxKdnNqTi9uQ3RiNGkwTTFo?=
 =?utf-8?B?RmRVbkt4QmMydlRSTHd4dCtpaVBMand0Z3dVWjlkTTVjS1cyWlR2akI3MHNo?=
 =?utf-8?B?UTJuT0dSVWtjZk9uem54SSsyemFORFFvenFIWVY3R0M1anBoQzUydVlUYlE4?=
 =?utf-8?B?b0trZ3g5TzlkRmdQZWlvbkRBblFVWStzYmE0UnV3SUp2dnZTYTlSZFhpWWNS?=
 =?utf-8?B?NE9ZUXhlYWZCaUgvY2VodXdObHcvVkVnNUQ1VTVXR2U1MTZ0K3FYaytKdjdX?=
 =?utf-8?B?VFQrZlJGZFJ0SjFtZzI3UjJINGFlRGR6UE5XZTFva1d4SHp1ZkhIbEp6QnpW?=
 =?utf-8?B?bW9rRkpHdC96UHhsbDRTd29Xc0FXa3drUUlUejdjZmdjVEZoVk9uTW5QN2lB?=
 =?utf-8?B?enVCYXJVeGhJRGV1eXdwUVgxODlCaVJXOUYvKzFMbk40VzFxODBWci9lMHVs?=
 =?utf-8?B?TVhFVW1ndVM3VDNLSXpyRGtSbEpocGlFZTBxeXhpcUFncFdhYU8yQVd6V1h2?=
 =?utf-8?B?aEpSOGs0ZkJFaWRVNUQ2eWVlTDZOWDJIbWVoeTZyS21tT0Mvc3htZjFsc3pW?=
 =?utf-8?B?V3pOWUNyN3FjNEtyYmozcXVpdkUwdVp0NWpqd2tZTkc2K21wSXZWOWZYMVJ6?=
 =?utf-8?B?ZkZWMm9kOG9sa2Y3Z3pnUnhkbE1TSktIcXF2RzFEeUcvc1JQQU1kNXVTRmp5?=
 =?utf-8?B?Y0tDS3VJRHdDbXR3ajgvdXRmUGpzQkppOUNIQ1g3OWRWREJRRmhlVW1GR0tr?=
 =?utf-8?B?QU0yeFoyZTljVFJyMW9CQ2pYd3B1UCthM01TeEI0TytnZGQyeUdPWVJoVnd1?=
 =?utf-8?B?SmdqVzIvTlVDTlIvamFNdm5jdjNwS3Z2NTM3NXMzeXAzT1hzbU1BVG1wRGlP?=
 =?utf-8?B?OXdWbi8zZFRPRSttd3JBbTJUd1pCakdYUEdDWkpVL2h6S3ZuM3pJLzhhM2Uy?=
 =?utf-8?B?UEcvOFRwZmMxY2VNNU9qMkhnanRQWEtYRDdqNmtrN3p0NFdUUXJkY3ZINUNU?=
 =?utf-8?Q?gY3AyLvR7XMC/vgOy1G9dmlaKSifbSuvVJ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkxnYVNDajNIVTd6UEdmUVpZaTU5NHZRMUx1bXpqZjlhNTlUT083a0RMTGJZ?=
 =?utf-8?B?ZCtHRG14Q0pEbktOd003c3RYTGhJMzIyN2h3b2tXQ3NuNEQ0WGtEWFQzcDdV?=
 =?utf-8?B?Yk1DMzRObCt2TUU5TjdnMEo3K2JIOXVEc3B3TGJwWjkwa1BlRlpBS0RBQlZ1?=
 =?utf-8?B?bTIvenZSa2JCcnRqVDFEdUlmbHMxSU9VZFg4UHhmeTY2UWJJM1RSWk1raml3?=
 =?utf-8?B?VWMxanFUaUJLSkU1MkwrWDBranh3U0lTTStsMDhGWXE0bGJoK2hRdlNOS1lw?=
 =?utf-8?B?dTNUamMwc2ROd2Y0WTR3ckpDcWpzWFBwcGhGUjRkREd1ZzBueUtNd0RqdGdh?=
 =?utf-8?B?eWpRd1hRUkUwMzNIcldEMTFMT1duaHlHQTVWMVBDS2NzYTlHejlHTDJvaTRC?=
 =?utf-8?B?aUtBVU5ncmhaOFVtRnAxdk1kTzI3QU5EaHZ4YWtaVFk0YkNFa0l2Tm9TRkxp?=
 =?utf-8?B?Mjh6SFMwbU1uSU9rOWM3c0kzUHJVendDbzIyRW02bk9zUFlCeTNwa2pIOEQ0?=
 =?utf-8?B?UElqNEVvcUJuL2NSbEpmQ3RJYmdlM2JiMU1TSXlBbE5kRldnaU5QWXFPNjlL?=
 =?utf-8?B?dWM5OUdkNTQwL1RQT3FqZkNzZ3l0cGhDQk0wNmJKTlg5bWRmWUovSGhkU0Np?=
 =?utf-8?B?T2NtVVhoR3ZnN3VPNXU2VDhRZ1NPVGJsNThnd1BlQ3k5dDBmYmxpR1RMSHcv?=
 =?utf-8?B?aUVWaTRmL3pva2VFdnBMRVk1VWxtU1BpWFd1ei8xYWdkeVlQNEp6TEFuS3dr?=
 =?utf-8?B?blM2Sml6ZCtoVjMwV3hUSkFiVi9zSk1IZDE3Q3BuWW9aTzZPOCtvdFZWR2t6?=
 =?utf-8?B?cElhb2NzdlgweWVCL3hjRTljZmtBVW5SbGd1NXptdzBrVlBOUUpGRlI5MGQ2?=
 =?utf-8?B?djNnczRsUVNjbTFyWkh3c0VWb0dqcTRyMTNMRGx3a1A5UjE0dkVXUHJuQmtw?=
 =?utf-8?B?V2lMdXY4QldmTkRUcEZqakRUYmFJSEQwTjlWVm0wbXkyTmQxbVc1bjVtREJ1?=
 =?utf-8?B?anNxSmpOWUkyNTdvYktuY1dpbXJmV2JkK29oQTA2UGJqbEQ4bXBqNXNvb3c5?=
 =?utf-8?B?YTJSalNITGhKRWszTWlQQkVGS0dOenNjUkp3N0s5UUZMczZ2U09pRllieTNt?=
 =?utf-8?B?MVFwbncvWk9WSVVJUHdJYmw3SlMzdDgxajl3eVVPYy9ibTkxUGlDKzNwQnZF?=
 =?utf-8?B?ZTdBYXhRZWRiWDNNNlRyd3BnUGEyeitUV2V4OUVKbitHWVQyR2RGSi8veFpy?=
 =?utf-8?B?ZGhQTTQyTENzTjQwSHh1amJUUGNpRWRqb1RGekdzUWQ4OHdSRS8zY0tMUjhB?=
 =?utf-8?B?S3hhNG9rK3owaUlGdGZqblFxUmN1cGNpYjRzUDJXYWhaendNTjQ5NVNKWExp?=
 =?utf-8?B?c1RlL0J6eXJNZ2JOUWdndlMxbEhmU2cyTE54YXF4NUdtNXJTTWk2ZnBDTjlI?=
 =?utf-8?B?VU9ONFY3VnNOamdnSzB6anVjMVl4ckRYekhXOFh2ZjdUcW1yalFFR1ZCQXpW?=
 =?utf-8?B?d0lSQy9SbnpXWjlrNmpLQ1hlR09uQitpVjlhZS9VdHhTZkF6T1JIODh0MkRJ?=
 =?utf-8?B?TkJEaEozdFI3L1pXTzlZdmxxRWxSNTBZSmwySWJiT2ppVFJQNWlraEQ3S0tD?=
 =?utf-8?B?TEtjQXhHaGZNZGRyekNnNlQyYjJnaHRlY1JyRFk3citHWVhldGpoMmRMblUz?=
 =?utf-8?B?R1djMjB2VWZVa1oyOVlMMWZObDBpbmU4ZmE0VE5iMk43NzBDTlIxR01HejJn?=
 =?utf-8?B?cU8vSHpZL1lYRzlGUUJJR0FDTzcxSXNjOFI0ZS9LK3Y5TlUwSDBUZlMxUWF1?=
 =?utf-8?B?dVVac0dyR2R3dG9jeXVKNkRZM0pSTlpQOVRTNU5OL1dKRGROOEo1emoyRnZi?=
 =?utf-8?B?TmRRZ1pzK0NLTUNHK0hZeERSL3Bzek1MVExJQ2FqSTdjUmc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab043a98-e2a7-4f5a-95ae-08df1715050c
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8559.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:45:15.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12479


On 9/20/2026 3:03 PM, Ido Schimmel wrote:
> On Fri, Sep 18, 2026 at 05:32:16PM +0800, Ren Wei wrote:
>> From: Zijie Huang <milkory@outlook.com>
>>
>> The ARP ioctl copies a user-provided struct arpreq into a stack object. Its
>> arp_dev field may contain IFNAMSIZ bytes without a NUL terminator.
>>
>> Such input is passed to dev_get_by_name_rcu() or __dev_get_by_name(), where
>> strcmp() can read past the end of the stack object when a matching
>> alternative interface name exists.
>>
>> Reject non-terminated device names with -EINVAL before the lookup to
>> prevent the out-of-bounds read.
>
> Other ioctl handlers (e.g., devinet_ioctl(), dev_ioctl(),
> br_ioctl_stub()) simply add a NUL at the end. Is there a good reason for
> doing something different here?

No, I didn't notice that. I will make a v2 patch to be consistent with the
other ioctl functions.

>
>
>>
>> Fixes: ff92741270bf ("net: introduce name_node struct to be used in hashlist")
>
> Nit: Blaming 36fbf1e52bd3 would be more accurate.

This will also be updated in v2 patch. Thanks for suggestions.

