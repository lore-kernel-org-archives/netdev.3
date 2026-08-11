Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93922236F7
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432863; cv=fail; b=GflTxKNJGCykpKVSdWEJGe0MqkdVULg1K0O/97Vsjy8apTXbyv2pj+AIPYaarIui0GzGqolWHpTL/2OiqApBCNDvDJKG9vSD+ijC7KRj6NsawR1HXeHz3oOXjlBhrjEKBRRK76j1BZUaomfiihDG9HxWCmZK25bFXjnDC4hsFZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432863; c=relaxed/simple;
	bh=aDN5zQ1Un6+ZZxzM54LzSII40LFnho5L1xiBVUxAfxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yl/b4Xex+mxMdj5oa5zYNXqpDUFX7kIXWLlAj2VlYmy4vPcxN/OyUTikX9pSk825qGp32DnkhH0nsT0iNSAhLvZA+zaDJuNI0wBsYO8uYWfDx3xB5TVb7ViJ7ViVry/osuzCw0iu2EUyd2iqU89Mc6MQeCIX0wLGlw5Fe/iIavA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ItrQCAVJ; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ItrQCAVJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZySxYRS+0EIPQJGEcvG06cN6o2DKQPZr0uS6D7AqcStLWCrPa+JxMHcBg3rYtBVIT4sJvsDD+Cxwi0CpQA+6aKX7rO5lCSST0aJq6jQnaFzoAoJMD7sgqok+2KAVp3ZksDpUz4x6pjJ/JdSctU22WEqUdgNteZpr9b6F3LCIYsukIqVpxZuwjjCjS4ahfIn09nUcx/LOnSkxivbeQ4SNdc6HHOb4WV1mTg9/LOfgE0kTfsFAoBiS/C3Ffl53WtScCoQM7o4f1mJEa/5zXcJ9295uZ8duCEB040PVPeyVlnb9FMF6KnkRvj6p30fZlqAImIGoKJQFI4yCC9QNjIey1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znUc6z7KO3wqrRT15m07Yzs7rcsqPFLgcKgTVnLunao=;
 b=G8JHKcpR4oaoNIkCwjvE7zjhBtAiBCcR0kd2A9eQoTpJiCwI6Ba70AdSIg3LendkE7xCHmbFRSZS7zD6B5NTgDoh4JDsTxnnrG2CJlxqrozzWAwnsxKkNopoYa75/Op7jw6KNl7CwzaVO7E9ZkrR4QRFWijrZ60K3ClASJwMJF58uC7s+r0yH7zmFW4o6hBHceSL8D9gJCxa2gCR5SS70kKByRRb4ZlA5c9J6j+6nCx1UVXQKeLKVQsR77bl/DkmUKSJXrT/iaTHGBgyzkrni81yX9iMna+xQqGl24Zk6NUY8yhs4YWNAead6PusrQo8q7A3VUwRjt9q9GN8JH5gSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znUc6z7KO3wqrRT15m07Yzs7rcsqPFLgcKgTVnLunao=;
 b=ItrQCAVJO8TgZtIUd2zdH1EtlbhMnRDtrPUUPghAC1YQ2nQtrO/oRbqJddL9G7mkswcbmVPEMKHrcV9XFUXcAzv3me6yugrLj+EJ7+PEzlGQfBDICBdSPVZ/Xf3Jq/BCQoQCIZkwOHfqftV6j25acZZktBuiBPGgo45TmDVeWAmlTwBH78Qm4i45spw5A6413SuGpMBqYVAoBU6DB4+YIN19GNwtlFLgpMS0UJFWY/wsMmVw8KC25U9rOvcGUYToUWmkqnYwf3RkzW6JxnX6yLSvfOs9tELAAKnHMW/PC1yRTPcmKbS7YfnTOcTcHSWNiIdQggSis6gsLI0WZ7Il0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 07:20:57 +0000
Received: from MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587]) by MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 07:20:57 +0000
Message-ID: <7caf12fd-f63b-46f0-a5bd-e9887cb25f9d@nvidia.com>
Date: Tue, 11 Aug 2026 10:20:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
To: Jakub Kicinski <kuba@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260804094518.53b56d24@kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20260804094518.53b56d24@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::14) To MW4PR12MB6802.namprd12.prod.outlook.com
 (2603:10b6:303:20f::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9d66b8-f777-4e22-c272-08def779161a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|5023799004|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	yQsQLzCpNrtFEpHS5eU+He5mOCGTn/qnZkM3VBOC/zFV96eJPmiiGaaWaNpTo27z2PrlI2SlyzQR6hiJ/50w8Eyap0M7FIELSxJymFx4oDJuZLkBCh3BpYeE2fdZeNDU3GbcEVFnqDTBMZ5unukKcTS+TXg9FEEeFgdFVwjIfkJS30/PLL3QYEnucnoWtjsohKXmu/7skLxJ7kIhQHdC0hijQzvEnOnELLNwFDb6vgQc+JoqrIiVftRcH1EOK2d21vbqZVvzede7FLnLPJW+DKCpV4TnS7mG+62Du+qvPFcviDAJPI7cjoj3HsofJbWnQCIx/vnvMoWrwFPr27MjpB3StbobZddnLVPPEaGWgUvOiu7Dn1YCyCQwE4YaejHyJyO9Izd/6nEH4mhRvLxwMitFBYrpfNLlVHPOQHYXn6PvSKvToPZo+fj1Wj69rKSzDlhh9JyAJsVeY7+33H+Iyl7Ne5RxvSiadr4PHPp/FIhU76x2RaIjXTt69X9O/1RaqzoS+tQf1l+bxt8hp4E70m9tTtkK4XOmsFOAtwfgYOH2sRUliDkGwlbwwiprIZmuFCx9qh3HVELIghShkyVXoLdEQNn3CBbPOuB2l1FT77RLw6QgTwIoSFIY1Dr/gGAzeVKifLKnUDNrCiNOGfzXqqMlJS0f3gNMbtT8WnlSdkU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3FoNzVrMlM5dUN4Y0VMbC9UOCtHZ3BibEx3UzluTlR2cFNwRlFiSStvc3ZW?=
 =?utf-8?B?Kzh0Wjd6WkRrcWVEL1JKa1VHN1REN3lFcjhDWTZPemxZNE9xT3F1Sm1IblhL?=
 =?utf-8?B?eHdybFB6d0IxZXNNaWZRT0YzMEQ2ZWoxaituVnBmeW5oc2JVbkhTL2JDQ2Q5?=
 =?utf-8?B?UTRkTW1zZTVCTDg5dFZDV3kxTWVpaG9memU3TjhPTXNKek91cTFqSTFweGhn?=
 =?utf-8?B?RmxpTTdvMS9BS3RGWWdoaDVHaThDN2twWXhSV1hrcFVaSWNjTFdmbnFYQmpt?=
 =?utf-8?B?bkd2UXFyNmU2WDRmN2JSb0lWZTJIMFZGNHd3aE1EVi9nLzQrQlYyai90M1Nz?=
 =?utf-8?B?VEN6cjh1T3JwR01xOU02TCtzNWtLUnNXa0lMNjVGVElNOVdzR1N1NE1GRHZX?=
 =?utf-8?B?MnlBOWZ0YVlBOUJyUlB4MVQ3UjJKbE1uQWVkelpWL3RjZVJlNjlyOHJKKzUv?=
 =?utf-8?B?eE9xR1ZCbitHbXZYalNWZXhURDZXRHUyRzBxek9nckFjbGk5TXlaNHAxOVcw?=
 =?utf-8?B?MW5yWDRQTys2LzNEZkVMQXdubVVVc2gyRUMvay9TZG51L0JKSVVabEZYR2lR?=
 =?utf-8?B?Sk9jbW91Tjc0dDB3T204bGFHWXA1a3NLWUVab2xzNlZyTndwb2ExenIwNE1h?=
 =?utf-8?B?OHpuaE4zZ0g5bERQMGwwWk5uaU54UElXVjF0cU4rRFVKM0lkTUJLUG9sRlJK?=
 =?utf-8?B?VmdNY3FDNXZJV1VQNmFKQUpOT1NjZEg3RXhUVTBPQm91dTQ3VE9ndzJHaEU5?=
 =?utf-8?B?YzVqVjNFaWZ4R082RU5talp3SC9BZEthOXhXNE1oOVBvdkhQdDBSTE5SUysx?=
 =?utf-8?B?NC9vbzJpRjZyaEpwT2szWUd2eGFyUDFFQVYxN0d6S0xqNE5OZklZSnZvNE1R?=
 =?utf-8?B?WW0wSWdkcXdiYmNWeFhsWGNiRFR5MUZVbWNyNmh2dnVKK0syVGhiSXpVQWZZ?=
 =?utf-8?B?VE1PMXUvZEFqZ29rRmNxdHV3R1B3WEVJbzBHT1lJSDY5Sno0YmM4dUNTZUxT?=
 =?utf-8?B?VG5jUS9URDk4dklOcEhPVWx2am1HaU9yekpiUzhuc0podExmOVBjQ29YNTNw?=
 =?utf-8?B?WWgzek1udG5iUG9BbkZKL0FQZWdBV3M2QmNSS3ltWHZXOVh3YVdvRTlGQmxi?=
 =?utf-8?B?NmZ2RXMxVjhkZEpwTFdzMFEycWJZTkNmYWFYSmFIZlRRL0J6TlloVjByWjhF?=
 =?utf-8?B?VFdtOGVPMzZCZmtTZCtWM0pmeU91M001Y1dTYUVROHdzMUo0OWR3ZzBTb0xQ?=
 =?utf-8?B?OU9hU3VPcjB4QU55aFJYS2JlbVNGZXJNWkx5K0JucVZmZmZhWXA4b3RiKy9V?=
 =?utf-8?B?Ui8yeU1VT0dUaTdsODNGQWw2TGdQL2ttc2wwVWJ6ajFubmFZTjBFbUJKYndI?=
 =?utf-8?B?bVlQNU8vQ2NYZFg4RFpseU40c25RRkFOT0lSdjEzUTd2ZERBVDVYdmdWcG1Y?=
 =?utf-8?B?bUZ1aEtNS3Y5cGhnRGFJMFNKc2RrVU9CNUJlc1pGbXZyeUhudlBtc3BTNzlT?=
 =?utf-8?B?T3dvdVJRank5RUZhKzQrOWlSY1UrTEdxMDByQmVQSFI2Qm9iUXV3SFdTYkRD?=
 =?utf-8?B?UGNGQ0kxUW4zYlkwdHZ6cnBvNlFlUEdhRko4R25mRWQ3VmlMT2hIOFE2dk9R?=
 =?utf-8?B?c2Fjdk5WbDE2QUFvRGkrUkFjTC9abDlCbUVMSGYvTDhXZExFNmpnbW11dWJm?=
 =?utf-8?B?WmtTeS81YjR2bnMvT2VXQjhxN1NsVi8vYzRDVVZ2ZVFTZjZNMjRQUjlwSG1E?=
 =?utf-8?B?SmVPQVBoRndFd2FqamdOQ0YwTmlWT0JVZTRHVkZLUmN4REFGMFlnaDU2ZDF4?=
 =?utf-8?B?eHN0Rm16RngzUEpUSHh6T1dINFU4OHNQbVQ5UDRCMitmVVdTYm8zd2RiTkUz?=
 =?utf-8?B?aXFZeEkwcVhXeWN5NXM2QXFuekhIVm1IaHIyWjcraGVmT3BBNE80cWdldVps?=
 =?utf-8?B?R0hIVTFhZnNDdk1uWXFSai84OE9SRHB3UnZ5NmZDOE5Bck5zSDZHaHlQQWNq?=
 =?utf-8?B?cUg3SUhlVWFVbmhYTkZJRDJoTlpJYkxKRnFVUWFOVmplYVg3eXZYbXZrNS84?=
 =?utf-8?B?cy9kaXVkTWxCTnlmWVdEOFg0bEV6RDlzeVVsb25RMW9xVUkydEdsbUY5NDEy?=
 =?utf-8?B?enpkUUUzVkFGRFVieVRHMDBvWkVQa0piSHJiOXFSQ0l3OFdwQjFrNUJOSW9i?=
 =?utf-8?B?cGpUdm02aDhMOG42aTNvU2VyVk5zSTUxbEdxU2F3KzRET1lMS2FXYkZ6UVhp?=
 =?utf-8?B?SU9aVGdyRFJZbHBQR29kL3Zwc3dCZ0xYY0YwSG4rTTFEMmtKN25DNlhvOVc3?=
 =?utf-8?Q?bkhGHLR2GsigEuv2j4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9d66b8-f777-4e22-c272-08def779161a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 07:20:57.3551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVh1fiK/MnDG+oCNKar/71eLeojtTZ9pnGaSj3jXe0w1JDQgDR1vGhWcmxr9n83mWe4Rk+MTHz8pCltkkNeNeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686

On 04/08/2026 19:45, Jakub Kicinski wrote:
> Hi!
> 
> The CX7 testing in NIPA is looking pretty good, one major source of
> noise, tho, is that the pp-alloc test sometimes locks rtnl for
> a minute.
> 
> Here's a failure in that test itself:
> 
> # # Exception| subprocess.TimeoutExpired: Command '['ethtool', '-G', 'ens25f1np1', 'rx', '2048']' timed out after 20 seconds
> # # Exception| 
> # not ok 1 pp_alloc_fail.test_pp_alloc
> 
> https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/763842/test-outputs/36-pp-alloc-fail-py/stdout
> 
> Then the next test that runs also times out during setup:
> 
> # subprocess.TimeoutExpired: Command '['ip', '--json', '-d', 'link', 'show', 'dev', 'ens25f1np1']' timed out after 20 seconds
> not ok 1 selftests: drivers/net/hw: rss_api.py # exit=1
> 
> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/37-rss-api-py/stdout
> 
> pp_alloc test can fail, but spilling into the next test is a problem.
>

Seems like the bigger culprit is the earlier xdp test, which leaves MTU
at 9000:

# # Defer Exception| net.lib.py.utils.CmdExitFailure: Command failed
# # Defer Exception| CMD: ip link set dev ens25f1np1 mtu 1500 xdpdrv off
# # Defer Exception|   EXIT: -15
# # Defer Exception|
# not ok 17 xdp.test_xdp_native_adjst_head_grow_data.ipv4
# # Totals: pass:14 fail:3 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: drivers/net: xdp.py # TIMEOUT 360 seconds

https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/763842/test-outputs/13-xdp-py/stdout

I'll try to reproduce this internally and investigate what happened.

Also, I noticed that the pp-alloc test isn't properly restoring the rx
ring size due to the timeout. In the subsequent retry, it's attempting
to double it again, this time from 2K to 4K:

# # Exception| subprocess.TimeoutExpired: Command '['ethtool', '-G',
'ens25f1np1', 'rx', '4096']' timed out after 20 seconds
# # Exception|
# not ok 1 pp_alloc_fail.test_pp_alloc

https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/36-pp-alloc-fail-py-retry/stdout

The high MTU and ring size along with the heavy debug kernel likely make
the pp-alloc test significantly slower. I'll also prepare a patch to fix
this pp-alloc cleanup issue.

Thanks,
Nimrod

