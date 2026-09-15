Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93F313E0D;
	Tue, 15 Sep 2026 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479659; cv=fail; b=PVkHXxPvm/nCWXui7DAwMMqM1tN9EVxZA3rjoITU/Ij6ONJtUsEYuVotnwWO96hgamdG2QaMnhutgRk62s6y+a7i80ZAYyUB4mgbOZ7AGD/RT69Isp3793YUbAzHjz4R8pRjR3ieok1BA5j+UGdyeSaGsf5/ZmKO94MVAtbRZCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479659; c=relaxed/simple;
	bh=TcTUXUX8Hk9iKErzK7uos8Xuf2jUht9A/dmJawElJ/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kAa9g/ThM4VF6bF6/o95JKhfJO24PIQxukSBSq7KyNw0dlRxvgOgDylzL7rpdBUoIVPtTKmcxF70RRCX/wYnrY8xPUYQnl4l5KgkMs7Ba9on+ahXr9IFxfAFVrvZYIDoyVuJWdJCoRsswCBvlbIGfjInkiMJusNLQEzFWd1FoG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jew5fMoT; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jew5fMoT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYjaT0IlUwGgaOOoDsm7ETPN8Z1ct1UBNXOQ5HTMLuOSFGm17UqBixzHzJo7gvMRt5v5LWZbDqxzPoUY241xqb8+2NQCqyxAfwGwQwWQS2QhIfNPf7XhbnGsCWk2zn3YFIpzl2TVbZelx0uj5achPFmE0urwWqla+6zPS9K5sV00HKEBij1nUarc84k1VmMXQ8jXTjD3cJG4nsbjXsApq1YqhtYtdLL6jaeg+O3/pckvgHs5vJ2TcHia3pti34gtxHbujXlJwTfJRwoz6g51lzk6nLL1TeeliEnDAnkTF8Q09BFOBZJVnFwmkpGwfHMHhN3OC2Y+BYkKIb7qSE0QzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va5ntMv/hWRRCzOHRLCaQTYMkjtjgJrXcLclFKPL3iQ=;
 b=FGkhwSrBuYYvjbdKVoPT6vh25pOzHXTezQeJclQt6Vb62DjfgYm5/vlwKdKMLpPSPDuamTrBmi1P1S3XbFhJwbwhInsphvQXYULfmoHEvXlaqIzILS18/wheZnptc+GQii3mOKSGzuf1rWDh7K7Ze0rl8xS7/W8j2WsTXs7pPQ02xxBU1iNp4bSFlZGrsAbflVvt9Hw60laeJRiciFw2vApkFQOeMw+uLIEZ6AQFC62k2Js9HIfSSd1Z2uudH/sSGTC//+3lCV7JgsC1UKBgrE51/B9jJ+am7StpR5L4kcWBbyyauDReHxJ+cVs+zX90cDsATuRmiiz4wsYXJVwlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va5ntMv/hWRRCzOHRLCaQTYMkjtjgJrXcLclFKPL3iQ=;
 b=Jew5fMoT+dZ3bYxRo0t5OlmI47dtrpmczN52J94W9zD4sdGWDom1lS9ZdE9aqTf5WB/wgzPtsikNcAmCECjKXSpfb/aSOezKZlrXfAwNDCmqgbrthG3wPi/5bbA0F82QsKl4x7xoPrNq626OW1tYFkkJ4aot1/bhXah/0/Jzx+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 13:40:51 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%2]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 13:40:51 +0000
Message-ID: <07b94065-9296-4124-a84d-6b9bfaca04c4@amd.com>
Date: Tue, 15 Sep 2026 19:10:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: macb: Move TC capability and PM
 checks to macb_setup_tc()
To: netdev-bot+sashiko@kernel.org, vineeth.karumanchi@amd.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260909142056.1433875-3-vineeth.karumanchi@amd.com>
 <178905149422.219967.17478774177902422624@kernel.org>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <178905149422.219967.17478774177902422624@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN5P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::9) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: ac154909-fb24-4715-918a-08df132ef504
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|6133799003|3023799007|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	LOrj9z3pQVHbntGvI0s4xHqctb0onBg1t07MYJtLGycU7kHlybF7yUGFWzX32dAICU3AJuG8cMYsxDQdSOo0RIF321Uqp2xFYAbrjB0tgtnFIo5kvfvxAnezThh98YfQrp5Jst59AdRtBOrP3bmoZQQehNQOISn5DLVZ9YAtqAh9epYG91TqaiyiMZCLlFevssKxhTN+Rp675zlUqaRPGzX++5dkwAihAbAyFGt/hG1R4blEwvri7bjEQRryB0Anyn8mg/wal3HOiJY71Lc9qCs9rLmr/Y64VLeNb6Wt8o3y0YLsC1vuep5iyq/8FdppQhP4bFKs+RsOGuVPTLn5croE+/YxxNleoD346DmH+BrJUpJCTGE1qCCCxZVsXlCpWAMK54PbWl/ZTwfdPnt8oHDbAD6/vOb6CLwVGgXCVCYTIm5UZc1WEAIxJ7+rtN+n1BOxQru1NLMoA1nO00tRi48tQxNx7THledVkc/X7pxvh38HFTN9v0ishj2wgRqZvQ7JNnjPyGHQ4/ZrDWOjZeCVryFsQqlTXxJr4uvtFelby5mExV0dIIKE+TQRDQKHRjWn/6saZnntoYt7hKEWaAjrS+F7dR7RVkMWIrQIIAmNwpgsMeWmeXKIBbpKKTAiynefr7CmiT0qeg5iWuO7OpBLzoezEL2UV7VjtdoW0uwM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZllSS3BCcGE5L1lXUXVYb3V0cE45MXlHWUZrcU5TYjN3ZXZxaEtQbXo4M3JN?=
 =?utf-8?B?Nm55WVk3ZXdaV3lqYmhPV09ibFpBQUJHdlRnQjBtb3lvY2k2b3E3RGdGQXlF?=
 =?utf-8?B?YndIV3hjWjZ0Ulg4L0lSS0w3QmlMVDJVY0xJMkZ2UzVPVm5jenIyUnRVL21r?=
 =?utf-8?B?aEVOQWY4MjdWVVpMTG9VdGk3aVJDdEExOUhqMEczOUJoZmlHTWJwbGNJaWpx?=
 =?utf-8?B?VlE3VUVBOEQrTy9rUEhCTHNFVktIMHBCWWpLaHdhcGdwNlZzamZJaGZraEpQ?=
 =?utf-8?B?VjZua0RFeFU3UnB4S2tOR0xPTnJiYkY1UkdWL0plK1o0ekVhaG40S1ZrMVVX?=
 =?utf-8?B?MmNJRUJEVVV6TDlUK3BlUUxOaXJRa2g0OFVkQmc2R2pXam1WUzFqMjJnN2M0?=
 =?utf-8?B?OUIybHVrKzl0TVovc1pQTCtnaFlQMG5uTHZ3aXBKa3RBVjh4MEFSTHB1bHp2?=
 =?utf-8?B?RnVhbytmRnBYZks1enRvcnFuY3huQllUNmRFbGh2U3NiNUQvZUZlV2cvMUxi?=
 =?utf-8?B?YUlLQzJaM2VjTm16LzZHY2N4OU1iK05hZ0pMcTJtZnBnam1mcE1EMkFocG5O?=
 =?utf-8?B?L2FMMTBneWtuOWU3MDBpNjBJRkYyVFJWTXpIc0svSEJkMGw3TUNXYVlzRzFm?=
 =?utf-8?B?V2Vpbkw2SWcvVEF4U2U3TVpmdk82alRIZzJTMHVvSm5KQ3Q4ZExrN3FyY3Rs?=
 =?utf-8?B?TEd4Z090UUZxTWY3UVVBWGRwOWdsUnhsQjNFQkZZTnArZHpBdzM5b0RVWWFh?=
 =?utf-8?B?SUlEYmcyTE45dXcydTdRN2VOdCtXVTVQcmd6akFUeU5HQzNFRHQ2dlZWb0tY?=
 =?utf-8?B?MjFJRFozektjQnV2NHVXeEF2VnU1cFVrT1N0MFZwQnE2amFOUG1teENJclZC?=
 =?utf-8?B?RjdKNDcvYnJ3STZiUXZSK1NLRDdQbm1GWVV2L3dDS1RDL2J3VEJVaFpDZnJs?=
 =?utf-8?B?RCt5YWZoWEhJZFFYa0tiY2tOUlBoMWdpK3B0VUo3bW1ZNWNLOTZlejNLZ0I4?=
 =?utf-8?B?cVNnYTdWQXVLZEkwemp0eFFadWVEdUJMaHlIMWpoMXNqZXUyc0R4SHZLTlY3?=
 =?utf-8?B?V0NwdEJ3SzloeFd3bjJzQm43a1BZcStNWGlIQUdNOGpiNURmZWRjTGphMkV1?=
 =?utf-8?B?cG01ajl3MlhMTkN3UjRUVzM5UEk3WEUvVWhVWGRJZ1ZXMnRlZDlmNklnS3Rz?=
 =?utf-8?B?cXZwWVdZc2paQVZ6UmlNMEgwRGgxaWw1RnpRVXZRZUFwWHBQQk1SKzhrdTBl?=
 =?utf-8?B?a2pYSGNaekNZa3ZQd3dOamFNMHVQQWhMV3psdlNHR1E5RHhNQmF5MVRaNmFQ?=
 =?utf-8?B?RkprWEdoSHE2RExFdUhkMEF2MTk0dGVpMnZKZmtYdGVxRWc3d1pDbnQzUDlw?=
 =?utf-8?B?N2U3SGRCblJ1OWpVZmRSK3YrZWNSQnU4Y0R5M3R1RU5UQlZyVnByelV3N2Rw?=
 =?utf-8?B?N1NiT2d5RWl3TlNCRFkzcW5XWjlCVFg2d3hJNThBNGpRQzNCVkRpL0xGVWVu?=
 =?utf-8?B?UmJOZWlJVGxNVVdmWkxSNCt2WnJqRGhZelFzeUlXVTBZVEZ4cVB0cEFabDUz?=
 =?utf-8?B?N0t4c3RuR1VnUzZWTGhPaDRVcTZ5N0Mva1FvYXptdm9CaGFYYjlzZjQ2UlRm?=
 =?utf-8?B?cWRwZ0NLUjh1blBHUEtENnhlT2hma2J1QXBOYjg5UGZpQ05wRUI0SjBxQ2lU?=
 =?utf-8?B?NlQxekZpZkZQSXNSOE4vNHZlTTNEaG5tb2Nna2tDT09xVUJpaU0yeE1aRmFC?=
 =?utf-8?B?UTYzMWdBY24yU3ovcTBsMzNkWTR6NGlVK1ZVS0tscWR2Z25seE1jS3B2UDBo?=
 =?utf-8?B?NVNYcmIyUk4yRDlMUVFqY09LVnJuQlF6QUFaM2ZUbGFqMUJHaUVQYnlrQkxt?=
 =?utf-8?B?UXlSMkQxcGxkQ2FwSGVVcVFOVjNEMHhmYnFFenU0UDVqVThUcWRyQUlXVGNn?=
 =?utf-8?B?RTlzMWljUHZPL0JTYmord2lmQUJGTCtzZ3F2UU9INE1BQkM3cGF4Y1JIY0FC?=
 =?utf-8?B?OGNXdlQyQXdsaFJUN0dkLzV5UFUrZkZ2WllqWlNZbUFUWWIzZisyLzNmY3oy?=
 =?utf-8?B?TUhxdTA0WmpGTVFIR0VhNUkzNHhTYzVQYkRtQ3YyN1pqMDFUOHB2ZnBvZk04?=
 =?utf-8?B?cVp4eGJiVE5JYXgrT0RRN25la2pEYllxTmMrODk0dEFQZnYyeXEzS0NXVHVx?=
 =?utf-8?B?bitYUC9ZZlJJZ3pzY05BRWQrQkxyZ2xWYWpGQk5JV2c2M0Q5a3VVZ1JZQ1Ri?=
 =?utf-8?B?MXA4aHBjd0hWMzZPUEk3d284SldSMzdsdnl3NkJicm9mMmFvWG1xamhnSFk5?=
 =?utf-8?B?TE1FNWVYWTJIdXBvNHQ4NTRmbjNWY2IwOHZEeGZ5Y1ljcHVCeXRlQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac154909-fb24-4715-918a-08df132ef504
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:40:51.2368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KR6sDR/A50Ji1CqkQJAC7Bgamb/TkWFmcUZqyNSVsD/XljD7SKRNH5Adf/7xhRW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203

Hi netdev sashiko,

On 9/10/2026 8:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0 (1)
> 
> - [High] macb_setup_tc() only samples the runtime-PM state with
>   pm_runtime_suspended() (macb_main.c:4509) and never acquires a…
> - [Medium] macb_setup_tc()
>   (drivers/net/ethernet/cadence/macb_main.c:4494-4519) now runs the…
> 
> Pre-existing issues:
> - [Low] The relocated gate in macb_setup_tc() tests the immutable
>   capability mask (`netdev->hw_features & NETIF_F_HW_TC`,…
> 
> --
> 
> net: macb: Move TC capability and PM checks to macb_setup_tc()
> 
> This moves the NETIF_F_HW_TC capability test and the runtime PM suspend
> guard out of macb_setup_taprio() and into the shared macb_setup_tc()
> entry point so future TC qdisc types do not have to repeat them.
> 
> A few questions about the relocated checks below.
> 
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index 8223ad81215b..ff7e02d3fab8 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -4476,18 +4476,8 @@ static void macb_taprio_destroy(struct net_device *netdev)
>>  static int macb_setup_taprio(struct net_device *netdev,
>>  			     struct tc_taprio_qopt_offload *taprio)
>>  {
>> -	struct macb *bp = netdev_priv(netdev);
>>  	int err = 0;
>>  
>> -	if (unlikely(!(netdev->hw_features & NETIF_F_HW_TC)))
>> -		return -EOPNOTSUPP;
>> -
>> -	/* Check if Device is in runtime suspend */
>> -	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
>> -		netdev_err(netdev, "Device is in runtime suspend\n");
>> -		return -EOPNOTSUPP;
>> -	}
>> -
>>  	switch (taprio->cmd) {
>>  	case TAPRIO_CMD_REPLACE:
>>  		err = macb_taprio_setup_replace(netdev, taprio);
> 
> [ ... ]
> 
>> @@ -4505,9 +4495,22 @@ static int macb_setup_taprio(struct net_device *netdev,
>>  static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>>  			 void *type_data)
>>  {
>> +	struct macb *bp;
>> +
>>  	if (!netdev || !type_data)
>>  		return -EINVAL;
>>  
>> +	bp = netdev_priv(netdev);
>> +
>> +	if (unlikely(!(netdev->hw_features & NETIF_F_HW_TC)))
>> +		return -EOPNOTSUPP;
> 
> [Severity: Low]
> This isn't a bug introduced by this patch, since the test is only being
> relocated here, but should this gate look at netdev->features rather than
> netdev->hw_features?
> 
> macb_probe() sets:
> 
> 	if (bp->caps & MACB_CAPS_TC)
> 		netdev->hw_features |= NETIF_F_HW_TC;
> 
> 	netdev->features = netdev->hw_features;
> 
> hw_features is never touched again, so this condition reduces to a
> MACB_CAPS_TC capability test. macb_set_features() only reacts to
> NETIF_F_HW_CSUM, NETIF_F_RXCSUM and NETIF_F_NTUPLE and returns 0 for a
> NETIF_F_HW_TC change, so after
> 
> 	ethtool -K ethX hw-tc-offload off
> 
> does a subsequent taprio replace still get accepted and programmed into
> the ENST registers, and does an already programmed configuration stay
> active?  The usual spelling for this gate elsewhere is
> dev->features & NETIF_F_HW_TC (see tc_can_offload()).

OK, as this patch is currently relocating the check, I will fix it as a
separate follow-up patch.

> 
>> +
>> +	/* Check if Device is in runtime suspend */
>> +	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
>> +		netdev_err(netdev, "Device is in runtime suspend\n");
>> +		return -EOPNOTSUPP;
>> +	}
> 
> [Severity: High]
> Since this is now presented as the precondition for all ndo_setup_tc
> paths, is a plain status read enough to keep the register clocks on for
> the duration of the offload?
> 
> pm_runtime_suspended() only reports runtime_status == RPM_SUSPENDED, so it
> returns false both when the device is RPM_ACTIVE with a pending
> autosuspend and when it is RPM_SUSPENDING. macb_close() drops the
> reference asynchronously:
> 
> 	pm_runtime_put(&bp->pdev->dev);
> 
> which arms the MACB_PM_TIMEOUT (100 ms) autosuspend. Can the timer then
> expire right after the check passes, so that
> 
> macb_runtime_suspend()
>     macb_clks_disable(bp->pclk, bp->hclk, bp->tx_clk, bp->rx_clk, bp->tsu_clk);
> 
> runs while macb_taprio_setup_replace() or macb_taprio_destroy() is still
> writing ENST_CONTROL and the per-queue ENST_START_TIME / ENST_ON_TIME /
> ENST_OFF_TIME registers?  macb_taprio_setup_replace() does sleeping work
> (kcalloc(GFP_KERNEL), phylink_ethtool_ksettings_get()) before it reaches
> the register block, so the window is not small, and bp->lock does not
> exclude the PM core.
> 
> Every other register-touching path in this driver brackets access with a
> usage reference instead, for example macb_mdio_read()/macb_mdio_write(),
> macb_open() and at91ether_open() use
> pm_runtime_resume_and_get() ... pm_runtime_put_autosuspend(). Would
> replacing the check with that pairing here be preferable to relocating
> it, given the MQPRIO and CBS handlers added later in the series inherit
> this precondition too?
> 

yes, will fix in next version.

>> +
>>  	switch (type) {
>>  	case TC_SETUP_QDISC_TAPRIO:
>>  		return macb_setup_taprio(netdev, type_data);
> 
> [Severity: Medium]
> The guard above now runs before the switch, so it also fires for
> tc_setup_type values this driver never handled. Is the netdev_err() on
> those paths intended?
> 
> net/sched/cls_api.c:tcf_block_offload_cmd() calls ndo_setup_tc
> unconditionally with non-NULL type_data:
> 
> 	if (dev->netdev_ops->ndo_setup_tc) {
> 		int err;
> 
> 		err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
> 		if (err < 0) {
> 			if (err != -EOPNOTSUPP)
> 				NL_SET_ERR_MSG(extack, "Driver ndo_setup_tc failed");
> 
> and -EOPNOTSUPP is a normal outcome there (tcf_block_offload_bind() falls
> back to no_offload_dev_inc() and returns 0).
> 
> So on MACB_CAPS_TC hardware whose interface is down and has autosuspended,
> does every clsact/ingress qdisc add and delete now print
> "Device is in runtime suspend" at error level while the command itself
> succeeds?  The message is not rate limited, so repeating the operation
> would repeat the log line. At this commit the same applies to
> qdisc_offload_query_caps():
> 
> 	if (ops->ndo_setup_tc)
> 		ops->ndo_setup_tc(dev, TC_QUERY_CAPS, &base);
> 
> The TC_QUERY_CAPS case is later moved ahead of the guard by the following
> patch in the series ("net: macb: Add MQPRIO qdisc hardware offload
> support"), but TC_SETUP_BLOCK still reaches it at the end of the series.
> 
> Before this patch these types went straight to the default case and
> returned -EOPNOTSUPP with no PM inspection and no log output. Could the
> commit message mention this, since it is described as centralizing
> existing preconditions?
> 

yes, will fix in next version.

-- 
🙏 Vineeth

