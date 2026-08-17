Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D9B282F0E;
	Mon, 17 Aug 2026 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786961055; cv=fail; b=f+SE6ogqBMWBgjhveWpezy01mvN7VnkMGd4hkCWS8NrOF6fpIkj943hGVOb2qP3Gc5A1GCihm3ANbU0bsroml/teu8Ysvlx9nAIazBnleUNPDeFuxoVauwN+2QTXB2+nbUe4p1b7Dp32tiBJ+jC/bdxeP7aLcMSaCunNIuvOYNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786961055; c=relaxed/simple;
	bh=P01ZOdIMB1ZecvGqstmbrk59HwUeEVswmNRrB68EuKQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WZiYfJ27A1EXGgV0hXVrDjLhWN82vSl4Fg0u59Cpmd/ROAC8j7EDDIusXEO9xwMsh6VDZfzPLUu7pNFFQ74B9WtvyStYxfIoHjWkf915JyvtvFQwTNl6nJetJTzyT4lYmamTDzkkQ+JoI6GLvcMUPCNEzkgz7YTbNO6L5awoWC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oIjoNyEr; arc=fail smtp.client-ip=40.107.200.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oIjoNyEr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTWUT8zaZJ6/5trxzX6t5ObBPH0FC5DorBLzdOl7Pw+skIVzCq4BEJyDIPM5BTso8vQO0oHMk0ayQoVfeKXMaPDb/ARh13ovc4b24uDR7nZI6wD00uD0xZvjHyBbQeWw5eEuzRawLkBK/H2x7j2y0mQjsMcMuZiKlhRwSCpiABul0cQ/7cnDBvuZkEI0aoSFJwI7VFsHBzxLSxgfx6tYnwy6nHn7b2COWby3vLveAw1FaFqwq/KMFmk2+D8bzcw34OLjSDTEbAC/T02mGANCV4RPGDlqKBzvH7CgQA7TmMZETVDGasYSOskDGqP0BOkNklKAHgQOkET5tz/49GhMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEq44YM8srCrqasWkzTPxHmjyNX41xjenIAItmbJ1vw=;
 b=PJQzsFPyBiL0NV/skZYZWm+PWy/mwwWCFw0g4hfUKrM6k+X8WSSzzrMv0bW9j3UfFwq5mqicPcJaueu64vJtQXAQbQ0WRHTzFg+F0JL7grtFmClINltloyU64svklTSrnUPLd5eFQe7OoNAS2NH/kj1JmL2sG06CgFCDqfgc5eFoAeq4XnGn2o5gHhHI3PpVlvnHcOTVkM2zXVsxMblj9b9IWYkh+sqap2sHRB/TMtsv34K2wu48EqRbOTUPuoN9hsHmSq5/qQ9OpbSyx5ufqth74j2Ej0dVFFIr/xaZuenVGDw8cdbshr81dlOvR1NBWz6oyiZ4xlUP3CwXn5B8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEq44YM8srCrqasWkzTPxHmjyNX41xjenIAItmbJ1vw=;
 b=oIjoNyErpbI/eVCHjVPxvGJS5tRHG76vTP8SO9SH1gzT7JK/9l8WTMayqsoApM96vrzFBRVvmN83+lyWrxoNuD9XQNEn5UK0DOmNYxtMR4QT6b/8octGLQfoi+NfLpQVLoatoeOuXt2o28ooRqi/ct7L28ChKEmhJQfgkghl8NA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 10:03:53 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 10:03:53 +0000
Message-ID: <1d8922bf-5ed9-4ba6-9d3a-a7b981a41fdd@amd.com>
Date: Mon, 17 Aug 2026 15:33:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] dt-bindings: net: add Xilinx TSN Endpoint Ethernet
 MAC
To: Rob Herring <robh@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, nagadheeraj.rottela@amd.com,
 srinivas.neeli@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 andrew@lunn.ch, olteanv@gmail.com, horms@kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 git-dev@amd.com
References: <20260807104431.157230-2-nagadheeraj.rottela@amd.com>
 <20260808194815.132344-1-kuba@kernel.org>
 <ba624013-e8e2-4262-a451-650c29dc6b8f@amd.com>
 <20260814180413.GF1981719-robh@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <20260814180413.GF1981719-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0227.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::14) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: 8906b3b2-80b2-4aa2-9e46-08defc46d7b1
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|6133799003|10067099003|4143699003|11063799006|5023799004|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gQoLjScchCWoI4zNIFz7iEZ0tVgZEAcQ5mleLzGlQreOegLeRzOoKgVUFIdTuUQJHJVwFHY37eKghjVdx990ANGBkZwLRKu/cuuN07FkaD1m+ikRERfSN7v4eyBbvxexqiizytDvZ1Rorl6z78dXDSFKxiwJ9Zips0t5L4SFgPs3r5SUIq1aiez+NiR1b6lmuZAPvQmQR+npau66lumi4JxVWIQyon17dwjt+ausisNkjlUk/H3sI3mtCdBfduNfQGNkgbPTS6T/sxHeaABSuiIJX3UsVJCAmxqjSFfZABG85XrQFprsc3+Iwozhd2bkeT0ZlG5XkRmv1zrcOCj58bLkZjKHYrrMr3sYH7dAr+Xvurt+2peLO/QhfNeWjWR5SCyRkslKKSchC/T7R6fOOzW6Y6K55OIzpjuHTfN6yGzVdOfrPWSFSgNrFKp0MmwTZ50OiFKMrXs/sA9DSTiS5ymkPo2HEA6i7wyMYZi5TMfpZljNAybCwMvFS4PgazMWenb++qyofBx5HTNGAQc27F04z0cUKun6ZgLYhkSt/8q+XSP0T+fBIPS5p1MzkFCtfa1RFtY4jFpB+Nu7Gu1I+Euy5jWqW+hGcrUnju1qyzAFGhE99ZcP8W8UmJpquAnaSB60egPiOSwgJi48jgQUnui+vQfgrJyRgJpzpopABBk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTBCTENQbG1tTWU0Z3hFUUIwVUtWenFjS041NzJOSjdXQzMyekxnaVdTSmdn?=
 =?utf-8?B?aXJsdENGNmFQVG9EeWEwQnV2WU5XcjUyOGpPQjNISmpHazJ0RG9WRTU1dnVF?=
 =?utf-8?B?NHEvN0hkc1UrQWYvTXA0SjdtcFluY2tPdS93OHJYa1NvR0hPSE9IS1pHejNK?=
 =?utf-8?B?dFhNbW1yWHhJOEtOVEhwYVorZHoxbDQ0NklUMlJSZGxqWEJNeWlncHg3N3Ew?=
 =?utf-8?B?aVlXZ2p4WDdUb3RvQWE0d1RzVWs2cE1xUjBwZ0hFQmRtMjRXWTN0Z3JadTJy?=
 =?utf-8?B?WDZnRGx2RUQvQkhvRkcrNHJjako4QlBGUmQ3UVhHUHFpOXQzNVlpMERnMVI5?=
 =?utf-8?B?TDNMcFRIV0hpY3MwYSt6U0hqSVQ1QkxSeWlub1lNRnYwZjVETFRDWHlQL0xZ?=
 =?utf-8?B?c0E4ZUgwUzQ2V05YNXNraGJoa0FLTmluMkJTYnpzMVRzMDBIQ1BYejFLV2gw?=
 =?utf-8?B?Vlh4TXFEVnZPUm5tTFNacHB0RGZLd1hEelIzZWJQMXBxTk9jT3FMNHlMSlFh?=
 =?utf-8?B?VzZzb083ZWxxVXJCVGlFVWppRmdDOHpxTkppT0svcFJxNGg2U3R1Y1lXNzMy?=
 =?utf-8?B?UUpLKzd3Q0liR2tIek5NY2VCVlJHMHRsLzgwSWozMEduQlFBbGZtNzZRRFh0?=
 =?utf-8?B?bFU4bWZNL1RueXd3c2tyRHBRR0w4VHh1Mk0yU0k5TkdBWnJJUHFqNGUrdFdQ?=
 =?utf-8?B?T3BzZTdHMlY3TEdhcW1uMmQrc3lqck0zOEoxd09OMFZTR1N2Vlc0Vjd3NVhh?=
 =?utf-8?B?VUw3RlpLODdHOVlyZE1TcktlYTFEZFRPK0Y2T0QySHZDOFBBSk1tR2NMY1Bp?=
 =?utf-8?B?UzgvdnBNUkVkWUx4WDJRcmpNVjNibUVpUlhBa1FIZmhKZ2haNitucGhrZG1H?=
 =?utf-8?B?MHhCUDBNcWQxb3UyRlZwWENlYmc3aTdzSUFtUk5EV2FmVVRwRzZmVStBeEVn?=
 =?utf-8?B?Y01TcW9IUW5RUUtQelVQQzhFNiszRFphZGtPL1dKWUErQmdZY1Y2ODRlcWly?=
 =?utf-8?B?UURFb0x2WTNkTGxWb2tBcHhBY1NxbUpSNjU5T3dBSGV3REZla1JJbXZueXVm?=
 =?utf-8?B?VU42a001VVE0OTBMZFYxVUxuQzlGNnIwWDQyMFpBa1NxM0M4cXlOMWpza2NN?=
 =?utf-8?B?Zm1uT2FXaVQ1ektqS01OK0hIVjh3ZGE3Mnh5WFh6Y3Jwa0RTL1ZvckZYN0ZH?=
 =?utf-8?B?UjhlaW4wVDk1L0hPVkduNnpVdnQ4TWp3RWloNGtCSVNCQkRrdFN2cnRaZjFr?=
 =?utf-8?B?OTBReE9zbXVmSXQ3Ui9JeW9QMFdzT3JUajBNMmZhMGx1NVRUSStBbk15WEt3?=
 =?utf-8?B?eE5EanEwODRmTnBScmp0cC9lem02Q3YxM0dXTUZVNWZGeE54S0NhaTRIenZw?=
 =?utf-8?B?NHpNcGZmbjFtZVdNZGlhZDc0OTNpNG5HVkNOcCtidVQ4MWg0ZnQ0azlMTG1N?=
 =?utf-8?B?cW94aE5IWXJvb2NkVitWbmVLbEZ2a1UydktHRTNDWjBTeXEwU3QydCtTcUtZ?=
 =?utf-8?B?SytWbnhJTG56ZWl0ZjkyYzJVWElQdVJRVWNsb1hEWlBNa1dka0ZUQUM3NTV5?=
 =?utf-8?B?U2VGb3J1ZE5QTHVGSWdOZnhYZ3AybW5ZUmhXQlB0blZwWlo0MlU2aGZCdUYx?=
 =?utf-8?B?N2hWZ2dSdS9vaEMwSXh2UlN4djNPZTBWUjhmcUhyUG5kU3JHUFp6MFF2dDQy?=
 =?utf-8?B?SFJYZmJEbWZMQndDZWlHOWY1U3BKaFJhVlpSeUpXYW03dTN6anhyTFRsV1Nm?=
 =?utf-8?B?R1NEbDR3dHkyWWlWSGYxcVN2MzZNMTloTW5ha1lqWkRxbzlaSmxlWmx0RnV6?=
 =?utf-8?B?bndCQ1Y1UUlBMVBHZTg5Ykl3VVYyeXVyMXJ4a3g1SEFjRkhMcUQyU1NyODI0?=
 =?utf-8?B?TEE0TlBObE9Ub2p5cUlLSmNuSGM4dWl3b0lmY0pBc29GWDh4eUxjWTI1UWJY?=
 =?utf-8?B?SnJGYlJLOWxJbWcwT1p3RStnSG5UbzhvZ2xLV1htWW9qajlMS3E4RDdlZkVp?=
 =?utf-8?B?UzhiMkUxNmluay9OMVpkeTA2Zmo4akRNOVoxZXhQNmozalVEVFh2VXBUZ2Er?=
 =?utf-8?B?U0ZtMEFza011RnA1Wk1aSk1ZUmVJVEh6ajFFK0djNmFTclZ6Vmx4c3hKeGVj?=
 =?utf-8?B?bnY2YmlJT0FmSk1MLy96RkMvU2p0SXFHUStBWGVNKzM5ckFjSU1oNEpwd2Uv?=
 =?utf-8?B?MzFHWnkxV25lSHB1V3c1ektrMTlTMnhYb1NVek9jZklPMXBKNTBXdHgvQ25l?=
 =?utf-8?B?bTJPWFlDbjcwOEVoK1JtbmFRdURjMlpXbGVoaUJYVnBnNmZ1UGdSVU9oam5t?=
 =?utf-8?Q?WqNWYzz+SQ1gvSgV4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8906b3b2-80b2-4aa2-9e46-08defc46d7b1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 10:03:53.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYaRIf3WF9yNHEdHgsNHD5bHQ2oIAHP/5eNR4AOsoUecoWeqy8zQym/cOGU52F2Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171

Hi Rob,

On 8/14/2026 11:34 PM, Rob Herring wrote:
> On Fri, Aug 14, 2026 at 03:59:27PM +0530, Neeli, Srinivas wrote:
>> Hi Jakub,
>>
>> On 8/9/2026 1:18 AM, Jakub Kicinski wrote:
>>> This is an AI-generated review of your patch. The human sending this
>>> email has considered the AI review valid, or at least plausible.
>>> ---
>>> dt-bindings: net: add Xilinx TSN Endpoint Ethernet MAC
>>>
>>> This adds a new binding for the Xilinx TSN Endpoint Ethernet MAC IP,
>>> describing a wrapper node that owns the six IP clocks and
>>> xlnx,num-priorities, plus an endpoint MAC child and a three-port switch
>>> child.  A MAINTAINERS entry is added for the new file.
>>>
>>> A few questions about the schema below.
>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
>>>> new file mode 100644
>>>> index 000000000000..00f52b7b623c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
>>>> @@ -0,0 +1,343 @@
>>> [ ... ]
>>>
>>>> +properties:
>>>> +  compatible:
>>>> +    const: xlnx,tsn-endpoint-ethernet-mac-3.0
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>> [Severity: Low]
>>> Should the wrapper node have a reg at all?  It is listed in the top-level
>>> required list alongside ranges, and in the example the two describe the
>>> same window:
>>>
>>>       reg = <0x80040000 0x40000>;
>>>       ranges = <0x0 0x80040000 0x40000>;
>>>
>>> Every child window (mac1 0x0+0x14000, ep-mac 0x16000+0xa000, mac2
>>> 0x20000+0x14000, switch 0x38000+0x8000) falls inside the parent's own
>>> reg.
>>>
>>> The commit message says the wrapper only owns the six shared clocks and
>>> xlnx,num-priorities, and the wrapper driver in this series never maps
>>> that region:
>>>
>>> drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c:tsn_ip_probe() {
>>>       ...
>>>       ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks);
>>>       ...
>>>       return devm_of_platform_populate(dev);
>>> }
>>>
>>> Would it be cleaner for a bus node that translates its children through
>>> ranges to either drop reg or describe only a wrapper-private register
>>> block that no child window overlaps?
>> Thanks. We would prefer to keep reg as a required property of the wrapper,
>> for two reasons.
>>
>> First, reg describes the whole TSN IP register window, which is a hardware
>> property of the IP, and ranges translates the child offsets within it. The
>> child windows do not fully cover the IP window, mac1, ep-mac, mac2 and the
>> switch fabric account for 232 KB of the 256 KB window, leaving 24 KB
>> unmapped by any child (0x14000..0x16000 and 0x34000..0x38000). That reserved
>> space is where the IP places top-level registers that are not owned by any
>> child node.
> Why not describe those 2 ranges in reg? Otherwise, you are mapping the
> child addresses twice potentially.
>
>> Second, we intend to use that space. A planned use is a wrapper-level
>> build/configuration register that tells software which sub-blocks the IP
>> instantiates, so the wrapper can decide which children to populate. For
>> example, an endpoint-only build has no switch block, and the wrapper would
>> read that register to skip the switch node instead of relying on the child
>> nodes alone. That register lives in the wrapper window, not in any child, so
>> the wrapper needs its own reg to reach it.
>>
>> Because reg is in the required list, making it optional later and then
>> requiring it again would be an ABI change. Keeping it required now avoids
>> that
>> churn once the wrapper starts reading its own register. The wrapper driver
>> in
>> this series does not map reg yet, which is a driver limitation rather than a
>> reason to drop the hardware description.
> If there are registers outside of the child nodes, then absolutely you
> should have 'reg'. But please describe what registers and functionality
> are there.

Sorry, I had misunderstood the IP here. My thinking was that we might
eventually want a common register in the wrapper to drive some behavior,
and that reserving the space for it now would be cleaner.

I checked with the IP team and that is not the case. There is no such
register in the wrapper, and the reserved memory is only there for future
extension of the child nodes (EP/switch/MAC), not for the wrapper.

So I will drop the reg property from the wrapper node and keep ranges for
the child translation.

>
> [...]
>
>>>> +      mdio-mac1:
>>>> +        $ref: /schemas/net/mdio.yaml#
>>>> +        description:
>>>> +          MDIO bus controller for MAC1. Registers reside inside the mac1
>>>> +          reg-names window.
>>>> +        unevaluatedProperties: false
>>>> +
>>>> +      mdio-mac2:
>>>> +        $ref: /schemas/net/mdio.yaml#
>>>> +        description:
>>>> +          MDIO bus controller for MAC2. Registers reside inside the mac2
>>>> +          reg-names window.
>>>> +        unevaluatedProperties: false
>>> [Severity: Low]
>>> This isn't a bug, but the child node names contradict the $nodename
>>> patterns of the generic schemas this binding references.
>>>
>>> mdio.yaml documents:
>>>
>>>       pattern: '^mdio(-(bus|external))?(@.+|-([0-9]+))?$'
>>>
>>> and -mac1 / -mac2 matches none of the allowed suffixes (-bus, -external,
>>> @<addr>, -<digits>).  Similarly the patternProperties key "^ep-mac@"
>>> forces names like the example's ep-mac@16000, while
>>> ethernet-controller.yaml documents:
>>>
>>>       pattern: "^ethernet(@.*)?$"
>>>
>>> Other in-tree bindings that $ref mdio.yaml for a child use a conforming
>>> name (qca8k.yaml, realtek.yaml, renesas,rzn1-a5psw.yaml,
>>> renesas,etheravb.yaml, faraday,ftgmac100.yaml, microchip,lan7800.yaml).
>>> Would mdio@<offset> (or mdio-0 / mdio-1) and ethernet@<offset> work here
>>> instead?
>>>
>>> Related: the mdio-mac<N> nodes carry no reg, so nothing in DT locates the
>>> MDIO block inside the parent mac1/mac2 window.  The offset is instead
>>> hard-coded in the driver added later in this series:
>>>
>>> drivers/net/dsa/xilinx/xilinx_tsn.h:
>>>       #define TSN_MDIO_MC_OFFSET		0x00000500
>>>
>>> Could the buses be described as mdio@500 with a reg so the offset comes
>>> from DT?
>>   Thanks, accepted. In next version renames ep-mac@ to ethernet@ and
>> mdio-mac1/mdio-mac2 to
>>    mdio-1/mdio-2 to match the referenced schemas. The MDIO registers sit at a
>>    fixed offset inside the per-MAC window the driver already maps and have no
>>    standalone address, so the mdio-1/2 nodes keep that form without a reg
>>    rather than mdio@500.
> If there is a register address associated with them, then using that is
> strongly preferred over mdio-N.
>
> Rob
The MDIO block sits at a fixed offset (0x500), but it isn't a separately
decoded window. It's a few registers inside the MAC core register space,
which the binding already describes as one window via reg-names
"mac1"/"mac2". Giving it its own mdio@500 with a reg would overlap that MAC
window, so I will follow your previous advice and use mdio-1 / mdio-2 
form that
mdio.yaml allows.

Thanks
Srinivas Neeli

