Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011035.outbound.protection.outlook.com [52.103.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9E442BC34
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414459; cv=fail; b=oqibdXEwdghe0fC7ll3FoJbCJsZjJf662cQBIJ9ggynRBIusXyspQ/v6nMrurEWbBULpNzNxtSo2SOxgpzX6If/cappe6amqvbokXmoRE+tyexSnxpz6b3ZWy92p44QP3BUegtj7EbG/SUNft2682jl4hSh1StCCkUBTJKGdYuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414459; c=relaxed/simple;
	bh=C6ydyCRZ9x2us3OOq+AjGBfREt3D9OXmOSDGtBvBRlY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aOC5Pz3K2tLGapnSGw4os4cbS1cDEvDwNpOsBfmyOXCBhBlocKJFuvWg4644NTEfXGViqZwvhInhGSgYTLSKXEYE85HDPn9SnP41ARVPJynQLlBB2TVEq8m9DJ6OPX+Mopn+OF24EmYaRWM25EvzWJkf6b0esSyBOGOK3BPjl0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Y/I/bVrN; arc=fail smtp.client-ip=52.103.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Y/I/bVrN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMNFfqUJ+x1PzuHvpQo+FY2vTlJ/was07BmBFJTzNDB71lK25m6THRN9QxktKac0+RzFlkHhvdDAFVGiYEigWCBs4UeLTLDsyOeyuwTKN9TG79QX+ZY00yxhizFkSpa8qosBJmKAvekJqxdDrRtW6iuvhLenHG+YVxK1OHIM0EdzNhGOMEW+9moUaOBLKlSTllw4y+6plVZJqeGM+/1Njyw88ZaTm0tVMGo4sYd+uMxF+Yx3SfKTge7sjMwT4q85nHWhvhVma+8EOC7Zs1Szl6qu627CadT38Z3Mj6WlRqUu2TzEotkylBZd5DgGAGaeGbOG7X22IL1cNtl6cf96dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6ydyCRZ9x2us3OOq+AjGBfREt3D9OXmOSDGtBvBRlY=;
 b=GlLTtRu5X3NeNsnZasGM+bCtSgW5QGdtA589VWhSuTE9u03E4gEPutUWqXq7FiJ5k3OCo8RCeF6QGcgT/Ib7bee1cagu4pRtvmmxczA9gzyO3BCVwuJDAzNH224Oya3iI410SdG7PhS2L6A2AtRBvQ7dwxeaws78Wsv6n2iuZYCgp9LRw2Vn/C/g6+3DHHrwjyLyX0rfVTeEqsLC0aBCJe/dEdWBbjcsJodYPyp3JOFguxndU7q7dInqwos1EC9cD3mZvN8/M3JpBcqKNvvEtiUpa6/GNaQkYzY8RldcIOULLcRKZOr9jFm+d8H19Zbn/ucqQxgH4IW/sPBAMnjDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6ydyCRZ9x2us3OOq+AjGBfREt3D9OXmOSDGtBvBRlY=;
 b=Y/I/bVrNAumKkcnRyXrd8siGb/TQ84XHQUxFB8U/Id7CHk3v4civHauJa/qmZ9pC4iZVOWbHLUa6cPlNpyBNqQ2zYptYdUO3BZrnQ2UO7kB3mp6mhjCToygHCZTgXpFTTGghPJ07f2oFn1tJmbVv47YL3HTCMe/LMYL0P2UkaIXkJfePbjvu0twTwGhbOD+zFI9a9DvWl+HuIfqP+vASFuw+dHQ+wcwVYU8xYVGPieFfHi8iPAw2MY3qsip4ZPRUC5mK4h0JqN65UTYfoK+GVxvEp8hw+fBas38Mic/Bf9v/aWSr13iihShPQe26j25+3wOfuNuRaTLPMXJAnz6ndQ==
Received: from TYCPR01MB8566.jpnprd01.prod.outlook.com (2603:1096:400:153::14)
 by OSCPR01MB12675.jpnprd01.prod.outlook.com (2603:1096:604:33f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 12:27:34 +0000
Received: from TYCPR01MB8566.jpnprd01.prod.outlook.com
 ([fe80::48f2:133c:842a:2755]) by TYCPR01MB8566.jpnprd01.prod.outlook.com
 ([fe80::48f2:133c:842a:2755%6]) with mapi id 15.21.0245.012; Thu, 30 Jul 2026
 12:27:34 +0000
Message-ID:
 <TYCPR01MB8566FD415B7837A5202E4601BBC92@TYCPR01MB8566.jpnprd01.prod.outlook.com>
Date: Thu, 30 Jul 2026 20:27:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/sched: reject overly deep qdisc hierarchies
To: Jamal Hadi Salim <jhs@mojatatu.com>, Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vega@nebusec.ai
References: <cover.1785304107.git.milkory@outlook.com>
 <99183398d8534a2bd65e8819cde9dae92dd97114.1785304107.git.milkory@outlook.com>
 <CAM0EoM=VxHRg-xULQqPLvC5_XveZ0EvvaCH3EmL6vTWnM9+aNw@mail.gmail.com>
 <CAM0EoMk8bgBKQv90YEvoKxWkrsoEauhkbeXee9xYtxc9gU+n8w@mail.gmail.com>
From: Zijie Huang <milkory@outlook.com>
In-Reply-To: <CAM0EoMk8bgBKQv90YEvoKxWkrsoEauhkbeXee9xYtxc9gU+n8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0101.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::16) To TYCPR01MB8566.jpnprd01.prod.outlook.com
 (2603:1096:400:153::14)
X-Microsoft-Original-Message-ID:
 <1017f4f0-9a92-4c31-b331-fa67caf2c718@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8566:EE_|OSCPR01MB12675:EE_
X-MS-Office365-Filtering-Correlation-Id: b7697fe2-7068-4044-2f86-08deee35ef00
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|41001999006|8060799015|19110799012|25031999004|12121999013|15080799012|23021999003|24021099003|25010399006|6090799003|5072599009|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1VwdXpWRlhBN2h2UVA4bDdDc2tQQ3NYMzY5WnVoWnpRSHNIQU8rSEtaZVk0?=
 =?utf-8?B?eWFlT2xGaktFUVlXNFZZTHBwUDBLRmJpdkhkSjk2ZHBQQjIya1F3MGZZMlF1?=
 =?utf-8?B?ckdDSTI5Q2lvVGFhRUpqS2lxSG5XK3VQOW9hbDdITzhWZkM1OEUwVzMyQ296?=
 =?utf-8?B?ZjlYNFFLVkVlOXVGcmhORE4zWGpLSzEvUENUR0ZvWGlSY0Zhckx3cjV2RUR1?=
 =?utf-8?B?dEVyYkhYZ3ZjWDF2L1JXR1FIM1ZOYS95RjFhWCsrWkVaV0IwZ3VXeDc3RXFz?=
 =?utf-8?B?bHNuZ1JTODVka3hOcUxmZmVQTkkwYzkyemZwc0kxbTF2dUxiVmdtaExmY0R0?=
 =?utf-8?B?QmVwNjE5MERLVldiSllacklvbHlmUnJHNlhPbjE3WE1LRjlSaHpPVVZpWmhC?=
 =?utf-8?B?WE5Pb3NQd2tDUThyZVFlR3VHMVRZOTVuYUNrTElhTzJDaitucDVsSEpJN1NV?=
 =?utf-8?B?TitZVHRsQzZIYVFjZHdPaXVPd0JkTkR1VlUyY29RMlJPVEdFd2oxODdncDZN?=
 =?utf-8?B?ZkpMRDc1NjhNcXowZ1oyeTQ5b29LTlJHRThsYU1BWnZzeE5JSXg0UWZ3VFAx?=
 =?utf-8?B?ZzIzNzgwd20xNlArZFpwb3lxMlZCeGx5cVpsa2NzM0JNYm4wWHdpWXZtTGph?=
 =?utf-8?B?MTkwUlNXZDNKYTJXbE9JSWpNV0diL1hlSVB4Zk0rNngwbExRQ0FGVnhNaFJF?=
 =?utf-8?B?OFhGbjdKNWJSenh1SVhiOGtldHpXZUJxcERuU3NsM1RNQnRLaWpwSVBXYitM?=
 =?utf-8?B?WUhvT2tyRWlueDh0ZDdRQ2J0QTVYOUFvV01VbkRGNnlXcHhWcGVwRlpRU09z?=
 =?utf-8?B?WFdsenR2cFlaMFpOVnRTSjFtU21SK3pXa3BRdElyS0JjeFRFZE04ME5HTE1Y?=
 =?utf-8?B?cjgwRWxYbGpsNzdNRWs0bENNWFU3b0o3dmdkNXFDTXBMcS93NkR1Nmx5Qm16?=
 =?utf-8?B?K29wa1o2d3RjaXg2OWFXT0RkQkxpL1VsdkI3bDcrQk4rS3diNVhGY2t5YnVp?=
 =?utf-8?B?V0MyQ3Q5TmVlcVdlaGRyVVZ4UFdSSHNhTzBRQWRnaDNQRHZWbzFCait6THlZ?=
 =?utf-8?B?T01OMDhUcTZwQTFJWUJaYjM4bzhiZzJWclBBbjFWd1FlL0VQT2pjZTFSV1I2?=
 =?utf-8?B?MzVJNE5CQ1ZIZlFpK2xSOUlTTEthUVhlbW8rVmhzaml5MFo3d3ZXVG5kNUNw?=
 =?utf-8?B?RStRckhjY3FzSmNrSG1adlhSNS9TVGxmTlVEamdXak5FU3BuaW5QYjdONG5P?=
 =?utf-8?B?ZEtWRjZSOUpjQWhjM3NjT0szSC95V0dMcUZlcFgwZkdCVEQreTRrUTVZOE9j?=
 =?utf-8?B?bU1lYXRpSUo3eFY4UGtRZm1KcjdvbHZjdVhMQmprZTE4TmF3S2NxZ24rMVVv?=
 =?utf-8?B?KzlMZXh4V1VSSFVha29QR3ZxRXc0OEd6TjlRK3FXWHJuTmovaklBY1M5V1pa?=
 =?utf-8?Q?t/AULtyq?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGxVdDFUbXIwRnYxc3VhK0FRRjBhamhEQ2tYbGZkOCt2ZmNhVko4S1h4OURx?=
 =?utf-8?B?ZGR1OGFpWkl4R21TaUZnUStxWVQwZjNUM2NsUGo2YUx2RURuUWlBRGdNeXRq?=
 =?utf-8?B?OUF5eGpvRUU2Zm54NWMrSER2dDNRRmFHbUFoRWt2V3oyMXU5L21DWGFwbVVL?=
 =?utf-8?B?T0dtb091dll2YVBtYTlXNlZ1TUZiL0sxaXc1Z21wVVhKTHJLWTlFSWlib3lr?=
 =?utf-8?B?YWtqbm9pd290cU1tS2dVb1lWK0ovRHByNGs3Q1pHWkRxUVgrQTQ0TUJxNGF6?=
 =?utf-8?B?ak41MFdFaHM1WTlwRHV1cGNBWVdzNTBBcURmZmxwODVuRFV1WHR6YjdBZSt1?=
 =?utf-8?B?Z0UzQ2o2VUFYQlBuS0dJbnlEYXdtK1hZU0tpYldDOFFrR2dXUjAreG5JQWxJ?=
 =?utf-8?B?NkhJWHZ6ZXBFY0NRVThmTmhRUEpxTjVPTlUxVE82ajZScXZ6NkVHYy84UEQr?=
 =?utf-8?B?VWViTVlnV1hLTk5iOW4vQU1xWCt1Y05xTVNXbnV3UmpueW5ROEgwMlQ0VDN6?=
 =?utf-8?B?Vi9LemcxNFJGQy9FVGVtQTE2aDFQdWxpaktWbDgyRUdmMTJRRTg0T1ZhaDVM?=
 =?utf-8?B?bmFKNTZyeE5kVEF1cVVMTGhLRGJCU3lSaTM0THNmdjY0VWlzZTBvSElxMTdD?=
 =?utf-8?B?aXpWM3BlaFhUVytkZDdpSnBUOTRhT3lLbWR3QWY0M0Zoa0UxQnpJang2TlU5?=
 =?utf-8?B?amwyV0RxRzZNRzA4eDZSOXl5Zlh5WDhLMkdOTHFteUhLWDBrN2ZMcUR2Vlkx?=
 =?utf-8?B?akU5TW5ldWtCWFBGQXFBdytKeFp0MWNHbEl5NVlnMHJvYVdobmVBL1Y5bTF0?=
 =?utf-8?B?YUtCWDJzVWVXUEZGRWZObTJXRVF0U2NBNlVhWXZaaUxCUHFrOVM5aFhpeDAx?=
 =?utf-8?B?aW1rYnppSG9UNC9GL2hyUzJCK1g5NjVhTW1VV204ZlphSXdTSjJCYkpIUEZI?=
 =?utf-8?B?eWl2VVg4WmNQTVl3ZXd0RldCTjhUbUZrVkxPMmdDTDNLS2tWSmpENTMvR1Rn?=
 =?utf-8?B?aGh6UXV3ZTZ3dGVKU2tJbzVPcUJXQ0RLempZajJRMXhRTDVKRlp2T1FpOU45?=
 =?utf-8?B?d2htYkkrczJPeUxnSE5nWldJemIyUWo3SnRZUjlZTll3OWtTY2lOZ0lWUkhG?=
 =?utf-8?B?YnhLU2dPdTNSM3g0TGtQaTBla0cxOGhLYzNtc3ZlMmtaWGdsbm84M2FMMlhJ?=
 =?utf-8?B?NFdSNnp4NU01MGVlZkJtUDV4ZVlueEJRQ0l6RmZiNGdpM1dldzBlMmM2Z0kv?=
 =?utf-8?B?d0VOZHdCUUYxM3J6aWJlQWZXWnVJaE9LOGNYUEcrckxMc1ZmT2Rabkw4eHBn?=
 =?utf-8?B?YlZIeVlGdU0wUnhVeStTbUhmcURHbTFzcE5UZEZoOXZLdHlxUHR5QmE5ZmNT?=
 =?utf-8?B?ZUZuTXBtdGJxNFhaUWhRWDN0SWlnanZHNGVlL1d2eExZd3FyT1ZQeXdsUkJR?=
 =?utf-8?B?VHVGQ2ovYW5yMzNJQ1RZV1dRd1ZzQ3M2ZnZTa0xORTFrWWU5Q2VYMVBMZ0dD?=
 =?utf-8?B?eThzTE1sNHlZKzY0L0VnUFlPVTVOU1RseDhVVTkxblczMU9ERldPdXBKWXZj?=
 =?utf-8?B?R0hqMVFPR2FxeGxEekVhckVQblg3dnYzQnFsQWVxcjl6TTE4MmtvSC84dGE2?=
 =?utf-8?B?SEJPdWJjalNIdTNnU29uOWQrbHdmbWpZQmhMUVd0Tm01eDZMNEU2K3AwT01L?=
 =?utf-8?B?VXhpODBldW9FS0plZnNUOFJkT0EvdEYralRsYUdyVVNGNzMxcVpCRjlMYnVI?=
 =?utf-8?B?KzVmR0hxeGwyVmVGcGJjSTNrc3BnRURONkVhRmRtbmpLSE9iZ1d6T0Joc3NY?=
 =?utf-8?B?bWUvMzdoVkdYeWhyaStUcVArY0dFNEVDMHNuZlNJNFcwRzFPeDFKQlNlMDVn?=
 =?utf-8?B?MGZVNWtTMk9JYlczTVNpMk9TazEyQlV2TU9Qb3prZlRKWk41MkpBWFJJeitQ?=
 =?utf-8?Q?5sztVEvk4hhujwf33rm2kau2pp2UU7jV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7697fe2-7068-4044-2f86-08deee35ef00
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8566.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 12:27:34.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12675


On 7/30/2026 4:59 PM, Jamal Hadi Salim wrote:
>
> On Thu, Jul 30, 2026 at 4:42 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>
>> On Wed, Jul 29, 2026 at 11:41 AM Ren Wei <enjou1224z@gmail.com> wrote:
>>>
>>> From: Zijie Huang <milkory@outlook.com>
>>>
>>> When creating a new qdisc under an existing classful qdisc, the current
>>> code does not check the depth of the parent hierarchy before grafting the
>>> new qdisc. This allows users to grow a qdisc hierarchy one level at a time
>>> past the intended depth limit.
>>>
>>> Reject the operation before creating the new qdisc when the parent
>>> hierarchy is already too deep.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Vega <vega@nebusec.ai>
>>> Assisted-by: Codex:gpt-5.4
>>> Signed-off-by: Zijie Huang <milkory@outlook.com>
>>> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
>>> ---
>>>  net/sched/sch_api.c | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>>> index 668bcd60d183..09d57ad76b89 100644
>>> --- a/net/sched/sch_api.c
>>> +++ b/net/sched/sch_api.c
>>> @@ -1467,6 +1467,24 @@ check_loop_fn(struct Qdisc *q, unsigned long cl, struct qdisc_walker *w)
>>>         return 0;
>>>  }
>>>
>>> +static int qdisc_parent_depth(struct net_device *dev, struct Qdisc *qdisc)
>>> +{
>>> +       int depth = 1;
>>> +
>>> +       while (qdisc->parent != TC_H_ROOT) {
>>> +               if (qdisc->flags & TCQ_F_NOPARENT)
>>> +                       break;
>>> +
>>> +               qdisc = qdisc_lookup(dev, TC_H_MAJ(qdisc->parent));
>>> +               if (!qdisc)
>>> +                       break;
>>> +
>>> +               depth++;
>>> +       }
>>> +
>>> +       return depth;
>>> +}
>>>
>>
>> 1) This check is expensive because it runs for every graft.
>>
>>>  const struct nla_policy rtm_tca_policy[TCA_MAX + 1] = {
>>>         [TCA_KIND]              = { .type = NLA_STRING },
>>>         [TCA_RATE]              = { .type = NLA_BINARY,
>>> @@ -1749,6 +1767,12 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>>>                 return -ENOENT;
>>>         }
>>>  create_n_graft2:
>>> +       if (p && !(p->flags & TCQ_F_MQROOT) &&
>>> +           qdisc_parent_depth(dev, p) > 7) {
>>> +               NL_SET_ERR_MSG(extack, "Qdisc hierarchy is too deep");
>>> +               return -E2BIG;
>>> +       }
>>> +
>>
>> Could we introduce an O(1) variant? Store the depth in the qdisc tree
>> when grafting a new one and then just check here and reject?
>
> Something like attached. Compile tested only.
>
> Also - since you can reproduce this without much complexity how about
> you also create a tdc test?
>
> cheers,
> jamal
>

Yes, I will include one in v2.

>> Also, if we are going to check here - i think the dump check for loop
>> is obsolete now?
>>
>> cheers,
>> jamal

The loop check seems to be obsolete for normal tc paths since bc50835e83f6
("net: sched: Disallow replacing of child qdisc from one parent to
another"). I think the whole regrafting path is mostly historical now, but
maybe not related to this bug fix.

>>
>>>         if (clid == TC_H_INGRESS) {
>>>                 if (dev_ingress_queue(dev)) {
>>>                         q = qdisc_create(dev, dev_ingress_queue(dev),
>>> --
>>> 2.47.2
