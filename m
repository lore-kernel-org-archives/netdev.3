Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6BF43BDDA;
	Fri, 14 Aug 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703396; cv=fail; b=nloibFz0T8DWGTdu7S1ZhA4gvSmhxIgZl0JuB9QhoYC9yfuWlaURFoDKWc9J3nvQDwH11POgduiIjxvQRb3f9GPYAKs2y++phhzcyLxIiM+uhGT8SbJG8WMsGnf+H9AH9Y8ziJcsbhX4uE+a3a6l6Fd9rulJ0acO/a+HC48e8Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703396; c=relaxed/simple;
	bh=ckbEy6Np4NLe22SAfaOGXB9g9CD9pG9S6HEthygNArE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GQFnKau7YUNpBWN+Uql/4bDtg/XRAS1kVggWcCz+Dpm9o5nu8U32Rsx8kG8IAV3VHlMM+m7ugGmAN78A6lMcXNVLZq1a7ZhzI1OFf2v+j4hNHh8o4EsddO833CWI2ajXftEPnOJpWzk/DCHoaEBUHTZHbsSmmyR2ysPUQOIBnpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CYuKMmvR; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CYuKMmvR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4PJxR2JKGAsX6Z6+AEMVZAePInw2Fr+VSDTOO7G0sZ3ZUvQkb6lfoPaPDdmw3jN5KQMh+GWqtdFBb7z+waFRwp1wNLTNbLMpbp3Y83bpDW14IHxHV54QI23QpwqHKUnYlGNTXf1hF0M6zLkNzKz4pav/4WLF3XwddgsOqK4sfmdUYNiD5Yz1pTMg5EF5Icrxe6sLVh9LNRP5scY6bXb5xvOi1XpVJPmfKjPbM6WGZ8NQI5wvLcrQgNd2M5cRnqlr/uHMuNmKp/lRKJ3XVTIwZ7svpIHsns549ySqpnKuc1o3IoKllUfUwOzpHdk90bsna0WyN/xKS9ngXX9o+Agfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nj3lZPFjJoOLocarPROQkjuZCIFFrlkkF8jCb2xi/dw=;
 b=C8Rr1EY5WYpjsnMxwGlDHATSiRs3G3Y67zX6WW1oZ0qajer04a37IxHNJPTz9/MkduJmDmra+V6SvLdctjvbITdccHGJAO7j1JG0Fu+1nI4OIj0xtrXX0BoMXqRf58zeiZAHaqadBbkQoM5gWLY48z5ZeQyzNtR6FK2PBlinzOGep/NeT6aLySJFTTKfe2aXrHlKIv/om06ljCzOUPKtIfjWjVG/AkOaG01YCNU2GmvNeS0KWdv4NjPKQN6p0EU2VCPIWIYQEAwW6AMEMGRjP7UK2sH2x5wUwywqgZbke15x58LTxEwEiC7L33wRUX34gHcCJ9IQkmi01uYihet/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj3lZPFjJoOLocarPROQkjuZCIFFrlkkF8jCb2xi/dw=;
 b=CYuKMmvR5UmQbM0xOyVv0oOCcMaDfefp2RWOf0URlwT5ylZRj9ZZLpOpg6AAkfrKoUBL3RreFGUNlczFwdvNQUFpiseHTmDxsxJOOUIIhyRL7JXIxL98EJNS5HZNC+UuJE2aVQNE5Q5BKaFbRuyrZrNXDnTC70YpeL8iWLlkXFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 14 Aug
 2026 10:29:37 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 10:29:37 +0000
Message-ID: <ba624013-e8e2-4262-a451-650c29dc6b8f@amd.com>
Date: Fri, 14 Aug 2026 15:59:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] dt-bindings: net: add Xilinx TSN Endpoint Ethernet
 MAC
To: Jakub Kicinski <kuba@kernel.org>, nagadheeraj.rottela@amd.com
Cc: srinivas.neeli@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 andrew@lunn.ch, olteanv@gmail.com, horms@kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 git-dev@amd.com
References: <20260807104431.157230-2-nagadheeraj.rottela@amd.com>
 <20260808194815.132344-1-kuba@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <20260808194815.132344-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::15) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b51ae6d-1c2f-4cc7-fc7f-08def9eef111
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|10067099003|22082099003|5023799004|4143699003|11063799006|56012099006|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Pvu9s5j6VRVUXAmtq1cwSHpDu1yLFak70yhIBNlkkA6irLBVFyne4DRP3jagSOp/CaXGWZ8CAW0fLHsdGmDWHBumxbzlQSFo14VBFqf190vV/pwTru4OnCMaBFusynbhKyDlErGuWMa9JSFItN7Q4fT/7/uBAZSYL5oTMz0CNRl+guO0T0PRfsFAOkQn+Z/pHbmRGobUyUOsTbErZA1jc4twxl07ewTi1u2Spfxc61TfsBK3PVCLq8H8dDozCgUh4vzpjmi7IzDCE2ljmx0MIpwchhUl6AXWHPgTTpbWb2IMA+uYjGIq6TyaWGKl7+APRYiEFHzPg5gF7qiKz1KUQm4O7liXxXlDaJQVr7fWBM9fl0ZXw71/JtgCGZ5NjDMVn7QKAUMQwLjynghaYEM/W+Dh1Dp/hEDRLMzCsXuFWqG2m4P2EmSpOLxhH8/2xViQNN+cUX3MjFQUb25aAsDH+mm/59oNxvAsgFkNtPoF80GURORdIH54didVWrduu1jKZxGHG+VQV9NLn2i43ar/QAUTlLLjSdTqXF2Akh2dAzM9+2J7RVhyPmy/0C6RGU0PY988eV+/dyBU2+RonKb5EKHfefB99cZYDNfflBrNS1HK13TrXKFL5IcOP3ZSgZsmXG2mIhhhw6cBoYMxQP5nB3misBGkJ7Q8vvpmEuroleQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(10067099003)(22082099003)(5023799004)(4143699003)(11063799006)(56012099006)(3023799007)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bSt1MSszdDFuZzB2cHQxc29JV1pDa3RHUU4zRDNjNlI1OXRqL1hJblRjVTVr?=
 =?utf-8?B?a0xVaTV6NUhiZlZkV09xN3lva2hIcTg4a0FBWnhZdnBpWEY3ZTB6b1VYa0dt?=
 =?utf-8?B?QkQ0aEhtQnpCMUw5azhmejB5MVIzbjZ6V2YwektWUkZXNnJlcXI2dkpLY2JI?=
 =?utf-8?B?bVhCaUdZVkJJZjNkc2s0b3BLRUdscTdLUzNEVC9lNWR2RkZiNEUzOWo5TG03?=
 =?utf-8?B?YTBreDFMcm9sZ09ockMrcmcrNGc1YVg0L1hZOEZoY1JldHVRZzFDU2h0bUlQ?=
 =?utf-8?B?Y2JQb1daZlN2U1JvOWR1YUVvVXZrNWovZlhzb21WZGxLZnFzOGVQTkdpSjho?=
 =?utf-8?B?MWREL2p4aU5MQ3RkQ2RiTlU5ZG1uWW9FSzlPMjlFekY1T3lsL05zb05aUzRW?=
 =?utf-8?B?WUloWTF2VTA5eit3Q2F0QllOcWZMVlFTalc0MllkdzVYOXBWejdEQnJrNkU3?=
 =?utf-8?B?RWMvVFJDTDkwdzFWZER6WWp1UWd3SEZpQllocmlxdllncXJDVHM2am9yVStB?=
 =?utf-8?B?VkhHUnpuSmxyTm5XVFJaR1FhMkp6Nnc1em9vdUI1VUxKYVJYN1dBaEVJL3ly?=
 =?utf-8?B?L2dBcXVkNUxvKzdWdDdzZE5DTFUycjJkYm14bjhPWXhDbDN3Z2JmT0hZQnZ2?=
 =?utf-8?B?Y1NKWUJXRWFzRFErbUpqWkhKWkxIQS9XaGNQY21Kd1NDV2ZXQlRYRnFaeFpt?=
 =?utf-8?B?L3JORHpmK1lxUmpmMlBuK0VLcnFZUkh5TklYTkh3WXR3OWFVQ0U1a083TUxJ?=
 =?utf-8?B?Qk5HTEZ0dDVBZFRhc3FzcDN3MGp2YU9BS0duT2s1djBGWkN5SStBOURsbUhT?=
 =?utf-8?B?amIzSTZtaFcra3BFTjdxUjdMaS85clM2U0lwZDhBTWpQTnNrMHN3UU5jdVVi?=
 =?utf-8?B?NUNQekp1L1VmdE04Z2EvR1hCOEFxdHJxMEJkSzhFUUVaY0lxME8vM0hTdHA5?=
 =?utf-8?B?L2w1TDE4VUp0d0VUcFZPbEFuQjYxOFFNSmZTRVFBemN5VlhGelZITFRwU3lV?=
 =?utf-8?B?N0xrU1pta08yOFZ0S052WUNSblZha2tNNGozWWtGQWtudUF3aUNjbllFenhP?=
 =?utf-8?B?NUxSNVFpVHFwU2Vsdk1WOE1mMnhqS0cyWWFEQ0JoL1l3SW1sUktMb3lranYy?=
 =?utf-8?B?WVhHSDMwWFQxdld4bnMrSWFheW8zcnB2NVlPaTZWdkNBOExHKzBnMDgyOTZx?=
 =?utf-8?B?aTVqWFR1bG9la0FLc0toNlhjSWxHYXpLTE5IdWRndDdkSjk5V3NxZUt1VzFr?=
 =?utf-8?B?R2NQR0hYNnZ4OG5NUVBjMkRCeE1VUWNFeWlqckdScW9HUk9nK1lxOS9zNFgv?=
 =?utf-8?B?aWdqV2Z3L2Q4cjJNTmdNQ1FnM0hTbkh6VFpIZDFBMUZBN0E5Mm5Gei9zTVJU?=
 =?utf-8?B?ck5jK0pjTnFISWh5by9PWFZHYjZ3blhOVkx0cldpVFh3U0I0RkdtbVBtSEx5?=
 =?utf-8?B?ZlJYU1dQQ1l2Zi9VMytCb0l0WFgwNnJXMUdSNTFBT2lHZVJReTZ1ZkRhckZE?=
 =?utf-8?B?YmdIZ1d2WHduRlpKdmh3enBpblJoaytXSU50d1ozN3FISVlGbHVVQUYvYjJl?=
 =?utf-8?B?NjAvc1BxRnJXSjdtYUVvWUJoZGtZanFBdHVVcmpwOExSMVRTRnpTbnZWbW0r?=
 =?utf-8?B?OS9EcnZXMmcxY0ttaUt1aldheUNWdlRwYjlzNmJZUDU5dnpVcEpweU1CR21C?=
 =?utf-8?B?OUJDbWhpc0VWS08vQWp2THJKWEhSY0VkRzFwajAwTUNlZmdHWmZnd3crblJh?=
 =?utf-8?B?Vkk4QmZvTXVid3hGRmV0MG9SY25hTFArNjlLNkRJMjFlajZQVXZNNjdyYUJq?=
 =?utf-8?B?UFBQSU5LTzlDeDRTckJLS3VnSHU1Z3dOTVFlLzg5QnpsMFB5OFhoQUFteGlC?=
 =?utf-8?B?dlN4WlJDWGQxNURWOFJHZXg5cXJHUEFIYWsydzRIOGJ4QTdkeFJjTUt2ZnJI?=
 =?utf-8?B?VDlvUUxOZm9vTFphUDFQdGpkekprSHc3aEI3VFpCNjJEai9PcVBCOUMyb3JZ?=
 =?utf-8?B?RW4wVVV0eVhVc3RjQzkrR2FlUzl0d21NSjJ0QTBsSUVBTDBRQkVUR2lUcXQw?=
 =?utf-8?B?bnhYRzVBUDc3ZmVCT3p2a3F2YjRXMkJZUFZOUUtWTjRsSUJkT2hSb3Y1NXRl?=
 =?utf-8?B?T0FjNGdnMUJlMDBMdWQzNGVXVjZDclR3VW81TGxlNURpckQvUkkyaFFMRk9i?=
 =?utf-8?B?VmZzeXJQODRjR1lKWTI1M1V4SnZNY29NbHB4VnVySnhtZ0FwMjVEV21VZ2l0?=
 =?utf-8?B?cjJ6M0NJMlZ5cTRSdFZ6VjB4OFE1Q0xubHdDWmY3cG5CR3MxS2Q1WW5RcFFM?=
 =?utf-8?Q?Ah4XTf12Ne2TzavE28?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b51ae6d-1c2f-4cc7-fc7f-08def9eef111
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 10:29:37.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvXD9CtyyUB78A5XHyrZKAXzlA47fv1QnKCVxoyLOx9FZxE3kTNyuHN+i/5MWeiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111

Hi Jakub,

On 8/9/2026 1:18 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> dt-bindings: net: add Xilinx TSN Endpoint Ethernet MAC
>
> This adds a new binding for the Xilinx TSN Endpoint Ethernet MAC IP,
> describing a wrapper node that owns the six IP clocks and
> xlnx,num-priorities, plus an endpoint MAC child and a three-port switch
> child.  A MAINTAINERS entry is added for the new file.
>
> A few questions about the schema below.
>
>> diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
>> new file mode 100644
>> index 000000000000..00f52b7b623c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
>> @@ -0,0 +1,343 @@
> [ ... ]
>
>> +properties:
>> +  compatible:
>> +    const: xlnx,tsn-endpoint-ethernet-mac-3.0
>> +
>> +  reg:
>> +    maxItems: 1
> [Severity: Low]
> Should the wrapper node have a reg at all?  It is listed in the top-level
> required list alongside ranges, and in the example the two describe the
> same window:
>
>      reg = <0x80040000 0x40000>;
>      ranges = <0x0 0x80040000 0x40000>;
>
> Every child window (mac1 0x0+0x14000, ep-mac 0x16000+0xa000, mac2
> 0x20000+0x14000, switch 0x38000+0x8000) falls inside the parent's own
> reg.
>
> The commit message says the wrapper only owns the six shared clocks and
> xlnx,num-priorities, and the wrapper driver in this series never maps
> that region:
>
> drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c:tsn_ip_probe() {
>      ...
>      ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks);
>      ...
>      return devm_of_platform_populate(dev);
> }
>
> Would it be cleaner for a bus node that translates its children through
> ranges to either drop reg or describe only a wrapper-private register
> block that no child window overlaps?
Thanks. We would prefer to keep reg as a required property of the wrapper,
for two reasons.

First, reg describes the whole TSN IP register window, which is a hardware
property of the IP, and ranges translates the child offsets within it. The
child windows do not fully cover the IP window, mac1, ep-mac, mac2 and the
switch fabric account for 232 KB of the 256 KB window, leaving 24 KB
unmapped by any child (0x14000..0x16000 and 0x34000..0x38000). That 
reserved
space is where the IP places top-level registers that are not owned by any
child node.

Second, we intend to use that space. A planned use is a wrapper-level
build/configuration register that tells software which sub-blocks the IP
instantiates, so the wrapper can decide which children to populate. For
example, an endpoint-only build has no switch block, and the wrapper would
read that register to skip the switch node instead of relying on the child
nodes alone. That register lives in the wrapper window, not in any 
child, so
the wrapper needs its own reg to reach it.

Because reg is in the required list, making it optional later and then
requiring it again would be an ABI change. Keeping it required now 
avoids that
churn once the wrapper starts reading its own register. The wrapper 
driver in
this series does not map reg yet, which is a driver limitation rather 
than a
reason to drop the hardware description.


>> +
>> +  clocks:
>> +    items:
>> +      - description: GTX clock for transmitter logic and RTC
>> +      - description: GTX 90-degree phase shifted clock for RGMII
>> +      - description: Host RX FIFO clock
>> +      - description: Host TX FIFO clock
>> +      - description: Reference clock for IDELAY control
>> +      - description: AXI-Lite register interface clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: gtx
>> +      - const: gtx90
>> +      - const: host_rxfifo
>> +      - const: host_txfifo
>> +      - const: ref
>> +      - const: s_axi
> [Severity: Low]
> Are all six clocks present in every IP configuration?
>
> A fixed items list implies minItems == maxItems == 6, and both clocks and
> clock-names are in the top-level required list, so each DT must supply all
> six phandles.  Two of them are documented as RGMII specific, gtx90 ("GTX
> 90-degree phase shifted clock for RGMII") and ref ("Reference clock for
> IDELAY control"), while the switch ports below also allow:
>
>                phy-mode:
>                  enum:
>                    - gmii
>                    - rgmii
>                    - rgmii-id
>
> For a GMII-only build with no IDELAY primitives, would a DT author have to
> invent phandles for clocks the IP does not instantiate?  If those two are
> optional in some configurations, could they be made conditional rather
> than unconditionally required?
>
> Note the wrapper driver in this series is consistent with what is written
> here, it requests exactly these six names non-optionally via
> devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks), so the question is only
> about the hardware.
>
> [ ... ]
Yes. All six clock inputs are present in every IP configuration, regardless
of the PHY interface. Both GMII and RGMII builds instantiate all six, so ref
and gtx90 are wired even in a GMII build where they carry no useful
function. clocks and clock-names therefore stay a fixed required list of
six, and the descriptions refer to each clock's purpose rather than to
optional presence.

>> +patternProperties:
>> +  "^ep-mac@":
>> +    type: object
>> +    $ref: /schemas/net/ethernet-controller.yaml#
>> +    description:
>> +      Endpoint MAC sub-node. Provides the host-side data path through the
>> +      DMA channels described by its dmas / dma-names.
>> +    properties:
>> +      compatible:
>> +        const: xlnx,tsn-ep-mac
>> +
>> +      reg:
>> +        maxItems: 1
> [ ... ]
>
>> +    required:
>> +      - compatible
>> +      - reg
>> +      - dmas
>> +      - dma-names
>> +      - tx-queues-config
>> +
>> +    unevaluatedProperties: false
> [Severity: Low]
> How is an Endpoint-only instance described here?  The top-level
> description says the IP:
>
>    "provides low-latency network connectivity in either Endpoint-only or
>     Bridged Endpoint configurations"
>
> and
>
>    "It also supports GMII/RGMII interfaces for connection to an external
>     PHY"
>
> The ep-mac node declares no interrupts/interrupt-names, and
> ethernet-controller.yaml contains no interrupt properties either, so with
> unevaluatedProperties: false any interrupt or MDIO child on the endpoint
> MAC is rejected.  All interrupts and both MDIO buses live only on the
> optional switch@ child, whose interrupt-names list is fixed to MAC1/MAC2
> plus one ptp_timer.
>
> An Endpoint-only DT (wrapper plus ep-mac, no switch child) is allowed by
> the top-level required list, but ends up with no interrupt and no MDIO
> description at all, and there is one compatible string with no if/then to
> tell the two configurations apart.
>
> Should ep-mac gain its own interrupts/interrupt-names and a way to reach
> its PHY, or should the description be narrowed to the Bridged Endpoint
> configuration the drivers in this series implement?  Nothing appears
> broken today, the endpoint driver requests no interrupts and drives the
> data path entirely through dmaengine.

   Thanks for pointing this out. In the next version I will drop the  
Endpoint-only

  wording from the top-level description. As we are not supporting  
right now.

>> +
>> +  "^switch@":
>> +    type: object
>> +    $ref: /schemas/net/dsa/dsa.yaml#/$defs/ethernet-ports
> [ ... ]
>
>> +      mdio-mac1:
>> +        $ref: /schemas/net/mdio.yaml#
>> +        description:
>> +          MDIO bus controller for MAC1. Registers reside inside the mac1
>> +          reg-names window.
>> +        unevaluatedProperties: false
>> +
>> +      mdio-mac2:
>> +        $ref: /schemas/net/mdio.yaml#
>> +        description:
>> +          MDIO bus controller for MAC2. Registers reside inside the mac2
>> +          reg-names window.
>> +        unevaluatedProperties: false
> [Severity: Low]
> This isn't a bug, but the child node names contradict the $nodename
> patterns of the generic schemas this binding references.
>
> mdio.yaml documents:
>
>      pattern: '^mdio(-(bus|external))?(@.+|-([0-9]+))?$'
>
> and -mac1 / -mac2 matches none of the allowed suffixes (-bus, -external,
> @<addr>, -<digits>).  Similarly the patternProperties key "^ep-mac@"
> forces names like the example's ep-mac@16000, while
> ethernet-controller.yaml documents:
>
>      pattern: "^ethernet(@.*)?$"
>
> Other in-tree bindings that $ref mdio.yaml for a child use a conforming
> name (qca8k.yaml, realtek.yaml, renesas,rzn1-a5psw.yaml,
> renesas,etheravb.yaml, faraday,ftgmac100.yaml, microchip,lan7800.yaml).
> Would mdio@<offset> (or mdio-0 / mdio-1) and ethernet@<offset> work here
> instead?
>
> Related: the mdio-mac<N> nodes carry no reg, so nothing in DT locates the
> MDIO block inside the parent mac1/mac2 window.  The offset is instead
> hard-coded in the driver added later in this series:
>
> drivers/net/dsa/xilinx/xilinx_tsn.h:
>      #define TSN_MDIO_MC_OFFSET		0x00000500
>
> Could the buses be described as mdio@500 with a reg so the offset comes
> from DT?
  Thanks, accepted. In next version renames ep-mac@ to ethernet@ and 
mdio-mac1/mdio-mac2 to
   mdio-1/mdio-2 to match the referenced schemas. The MDIO registers sit 
at a
   fixed offset inside the per-MAC window the driver already maps and 
have no
   standalone address, so the mdio-1/2 nodes keep that form without a reg
   rather than mdio@500.
>> +
>> +      ethernet-ports:
>> +        type: object
>> +        additionalProperties: true
>> +
>> +        properties:
>> +          port@0:
>> +            type: object
>> +            additionalProperties: true
>> +            description:
>> +              CPU port. Wired internally to the ep-mac sibling.
>> +
>> +            properties:
>> +              reg:
>> +                const: 0
>> +
>> +              phy-mode:
>> +                const: internal
>> +
>> +        patternProperties:
>> +          "^port@[1-2]$":
>> +            type: object
>> +            additionalProperties: true
>> +            description:
>> +              External Ethernet port (port@1 is wired to MAC1, port@2 to
>> +              MAC2). Its PHY is reached through the corresponding
>> +              mdio-mac<N> bus.
>> +
>> +            properties:
>> +              phy-mode:
>> +                enum:
>> +                  - gmii
>> +                  - rgmii
>> +                  - rgmii-id
> [Severity: Medium]
> Can a valid device tree bypass all of these port constraints?
>
> The switch node uses $ref: /schemas/net/dsa/dsa.yaml#/$defs/ethernet-ports,
> and the referenced schemas accept both container and port spellings:
>
> Documentation/devicetree/bindings/net/ethernet-switch.yaml:
>      patternProperties:
>        '^(ethernet-)?ports$':
>      ...
>          patternProperties:
>            '^(ethernet-)?port@[0-9a-f]+$':
>      ...
>      oneOf:
>        - required:
>            - ports
>        - required:
>            - ethernet-ports
>
> The local constraints are attached only under properties: ethernet-ports:
> and only to the keys port@0 and "^port@[1-2]$", and that container is
> declared additionalProperties: true.
>
> So a DT spelling the container ports { port@0 ... } (the spelling most
> existing DSA device trees use), or spelling the ports
> ethernet-port@0/1/2, passes dt_binding_check while none of the hardware
> rules apply: the CPU port's reg: const: 0 and phy-mode: const: internal,
> the gmii/rgmii/rgmii-id enum on external ports, and the port@1/port@2
> only topology of this three-port IP.  A fourth port or phy-mode =
> "sgmii" then validates cleanly and is only caught at probe:
>
> drivers/net/dsa/xilinx/xilinx_tsn.c:xlnx_tsn_setup() {
>      ...
>      if (!dsa_is_user_port(ds, XLNX_TSN_PORT_MAC1) ||
>          !dsa_is_user_port(ds, XLNX_TSN_PORT_MAC2))
> 	    return dev_err_probe(sw->dev, -EINVAL,
> 			         "both MAC1 and MAC2 must be enabled as switch ports\n");
>      ...
> }
>
> Would matching both container spellings ('^(ethernet-)?ports$') and both
> port spellings, and dropping additionalProperties: true inside the
> container, close this?
>
> [ ... ]

Accepted, will address in next version.

Thanks

Srinivas Neeli

