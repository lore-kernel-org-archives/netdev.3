Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021092.outbound.protection.outlook.com [52.101.62.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BEA43CE60;
	Wed, 22 Jul 2026 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740031; cv=fail; b=Skm9BNL2Ez5xFaNtV2qvghr+spOsKT03Wr+KQJ2+kPtCRuSSgFkgy8XuCdvxJwNuBY4EHpJNtNMgv6Zjn2DQPSxxNZiHZfHG/4Ifb1nYObBe4+gyvrtjGb0KeSFUBiOp78+CSXDhk7LskFgq9XulNp4MYdQUccDrvdtcC7efZOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740031; c=relaxed/simple;
	bh=1dMVA6beOCLMajf9aGepgbKjgGzleE8dR6h9Zs4FrLw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OezD6WqbOR6lqTNqBzK+xottxXfklGYiFpJOzJE2266L0fvDlX3HRrHEh3rOfuUJmAshUNEn4MU0B0aDYFWXE/3WAB1S3OqokfRlh5lGZXkTU1bqBCvwEGa89ho+/Vfvf/5ugaLqSD/h6NK9CQD3OG/eaC6IbMAqf9Vynh2a8LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=KzsBbuLJ reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.62.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="KzsBbuLJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKTNvcYaNtv7LX+PXjM3ALvyqrIS+H6mBrvnq9YW4WAvPesQYFESzwvlpuskzoo8L+MOL5thEGNxmTeaKy+KNFUSWzgGfFAL+00Sai5nj+fhVmbo60T9cj8TTIIH0c6C0d+BcaZ9YsarM/TJ6zMbYyjoZ77733CovzpTCZI3p/zSTvpPj30VMOnFHEfPtxwwMDk59BYZA6PRvX6Bj6jdAsHFk8S2m4KYQODsKu9wkcxAEqmlSC2nag2Bpsf+7Lf4XoyM5BtQPAVbIySz83WA0/m5q2xbxUe8a7yeuAAO+w6YELq73sAhCUqiwdvCSltsIPn4HfvK8mZ2GWFs8I5KZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW4Q8TVNaQpESl8b1OEHiWF8RW/t5XS/vjcPIlX6gTg=;
 b=dqQl+Ly8jn9iLCqrVf6HUPuoff6TyG86w/gVSADwnymn+6SGuI40tGVm1jpt52Xz4rDFJmloWknCJ6AJlN6u3COIzxDO66CuHqzWoH4ntRnzp7Xna2MZ36PfbFRTP81dGC9iQKMgTiPILFQMaRc/CR8hrwEfi9scEA0vLzbztHTAVsINjS0A546oaqB8zF3P+35LHWWkA+M3dS19FI9w1A5PWugIuhEnqI+qcpTbcGPoeu/J5hgVupmwZSLhHwcmb21ZEnXljloSLWvcfqNtZcYE2SSRyY9MF5+PsoEIzW2MuSesTikzvNBNGgtoucqRoFZEcDZ3YxJ81dE/0MOX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW4Q8TVNaQpESl8b1OEHiWF8RW/t5XS/vjcPIlX6gTg=;
 b=KzsBbuLJ551hyalOFU5zhp92Uz/A8FYJ3zCYSDVODk71oAACvZ4261PVCD3GDOmZeCN9xUCsOb54d+ggUzb6sThKFLDsHze0DgPB/fSyzQpzF/xy0pHhakbbgoHY0H+ePZAy7cTuLEf44JymCs6yoMeLJBGZ+uxQyQtYJJ0Elp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BY3PR01MB6611.prod.exchangelabs.com (2603:10b6:a03:36a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 17:07:06 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:07:04 +0000
Message-ID: <901c66d2-4286-4ad6-b1e4-d971f4a52805@amperemail.onmicrosoft.com>
Date: Wed, 22 Jul 2026 13:07:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v45 3/7] mailbox/pcc.c: report errors for PCC clients
To: Sudeep Holla <sudeep.holla@kernel.org>,
 Adam Young <admiyo@os.amperecomputing.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
 <20260721175258.87600-4-admiyo@os.amperecomputing.com>
 <20260722-quantum-efficient-loris-adb10e@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260722-quantum-efficient-loris-adb10e@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:610:54::16) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BY3PR01MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5b4d69-1acb-43b0-9f4e-08dee813a74b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10070799003|6133799003|55112099003|22082099003|18002099003|4143699003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	IU0XjLau6M0RQj0KtnHOg9Ytzixt0zFiJAqaAN+dGi2O0zM3OAADfGBwzTpkbi7zzuOGzoAqxNJqmfsI2apoa33im9BsYt4hNUtm8Xi5G4ytcDvi/PyrD9NRH8u/8joRkDPdfDCgQSuXdm/SXobaX1XWSDfh4tjPzB9agkMQi1ks1WMIHK/Li240aPYcxIon15FVyja7VyoIG/Rq25ET4hWsbzgEm5sOv/MLYHF1HZI3257vF8VeCL6D2PlADpuNlik1L93xpXciNgKbfD0oPFzWxXN4WRHyH3ILBbnta6ctq+3dOoeUBB8FTXPWvLgIGxYfOazSGL0OQXhhq1JWavvl+zXn5tOtJnstO6J2NQHNxktcWahkeaHABjIxvgni4DzuqxsFyNNPbpF+tWZxnhdzk9ncU7HJvRBugF7SuBAaLxlRoepXBIXBAqoQMWi771EdnhLrvUYmBxDfBzMHVN8R8RquNNlNiFVAjQ/XN5xSKX2ZGr/GADYwqkldA5yLnmTeTKCC9GmxVP71OeTKjOo0h3MGrMcq9FIKFuIctbFVU+b/R5wkYSEx6IjFmYXSvTJiumbVaZh16WIw/Xyx8aOO75yzCxkzcaWIkPPQI/WFxy3+jm04eDLSDz9EBf40MKhKmpQoPJR41VGmT6PQkzPKZJyzmhyrzsNPfAeEDwg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10070799003)(6133799003)(55112099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjNNZ2U4eVVTc2c3czhCWE5QSTdSZjRZZlJxaGc5VkhncmYwcUtKL3hNSlNu?=
 =?utf-8?B?TWE1MXVwM3VhUGVHaGlSdDFrdlRvK2JzVmlUVHlKbFA1RUt4YlFnYUhvUHNo?=
 =?utf-8?B?OTlySk9zTm8xdlUwR21PMkUvcm85TEVhRVZXYVdXdVVXR0FtWHBtRURlNjkr?=
 =?utf-8?B?UGtMelZhUDVpSWdxSDU0dWd2bkhoendQTHIrWDNwTXFrOGpsVC9vS2tnNTVJ?=
 =?utf-8?B?bGxyQ0pDYnhnNUhGUzQrcDdVNkxweWwvdCtFWGIzNGw3Z2l6RmRkZzVtTmxo?=
 =?utf-8?B?SFNuWHFZL1lOT2M4V0FjdTdsTTc1L1hJUzdBZm1Cc1J3ek15UTFyMk1iNG1x?=
 =?utf-8?B?RW5EQzY4L0RKdm1HTFVXM2R6NVllWE01cjRkL21FaUZOUDJrWkFmS0xBSldO?=
 =?utf-8?B?WUxBM0F3WkJjMEplY3BlYjdUdEM3MlJpR3ZEV3h3Q2dFVlhVbmVTRXF1UGdn?=
 =?utf-8?B?ZzBkaTdxVVZFbEVqMEgwNzV1TTdYL2JmdG9kQjdqajl4VFZMcEZaQ3VRRHJI?=
 =?utf-8?B?WG1aL3A5clFVSkZsbzdHZHZOVjRMNm9ENE5DYWJZbWpYL0FPRlZtR3A3WWdJ?=
 =?utf-8?B?UnJCTWlVZDJua0l6L3FnQXAyUDg1ZUI4UDRkRi9aOHh6Tms5NUMzUVB5ZU4z?=
 =?utf-8?B?ZjgrL0F0enVsRHNWS1hCdDZjenlmQ1pHdzcwVEdxb0VONFFRQU9XMnZFN3My?=
 =?utf-8?B?dTBsaFpIL1lUZUpmbFRLTmlKOWc3Yk1tZkJ5VWxwWHNCNmdrcnZyY2t5RjBw?=
 =?utf-8?B?L2l3YWsrNnRtZXdHQzJXbTZwaCtxZGhWWlIzOWduWU9TaE4wRGMxUnBIbUFC?=
 =?utf-8?B?VmEzRkYvNytsQVNiV2hGaFdlS2lRQmJVVUFaTmUwendkVVdnQ285bGFXSjFH?=
 =?utf-8?B?YTdsekI3M0RDVG92UWxEVkZ3ek1KeDVEM0lrdXBvNnNDeCtXdVNvQ2ZLVWJI?=
 =?utf-8?B?RWZveEZRSUtNU3I5N3l3TEd0Mk0rcjlPMDZxbDJwaTBMdUdyalBpRGRsWHZu?=
 =?utf-8?B?ZjJyNTBkNlRubTBiZjhNMFJTMEJHTm9UbGtUYWVwRC9sMXl5bDBEQ1BGcVFz?=
 =?utf-8?B?QXNKb2RsNHgyWVliYjNHeWZRdFliakthdEo1YWFkYjRqRWswdVg1UUdWMEMz?=
 =?utf-8?B?WWFJY2JNUlZta09HdGJOSWd6MGlpMG95OWdHU2s5dG4vaWpUZUtPZkJmV3h0?=
 =?utf-8?B?TVltQ3hWUmdGbFI4MDJsQ2FWS05nZG1zNFl0Z3dHaTI2U3dNdCtaTlZXZkFj?=
 =?utf-8?B?ZWF5Z0tCQ2w3SGJtKzJnekxQWCtvNk9DZkxCQXNsNmxaV2Y5NllZSHhVenht?=
 =?utf-8?B?QlFYcjFJclBXM3pBMGt2NzBVamdKcHlMdUVYdjl5cE94bjA3TFBIUGNmb0E0?=
 =?utf-8?B?NTRlMFNrVmhhdFZWN3YySEZZVXFIbEpvWmpmMFAycDJ3Vm9zenZxejZnQit6?=
 =?utf-8?B?WUN5MXpJVEN2Tnk0b0RTUFZVZGJTNW12cEV6VEVoTVJqZWZ4RWYrUWlocEpL?=
 =?utf-8?B?dHdYMjBjOTE4aVVyRzdjcjhuejdaUkFCV1ZyK2RnL2h5Zzk2UUMrUHNmWFZM?=
 =?utf-8?B?dGJpMUlrVVE3TmlmRDlzTlVlSmxWdXZ0SmtqVEFtS2g5dHFEMHFYTnl3MlNt?=
 =?utf-8?B?bitKNVlUNllpV0lLUjJ1b1A3aDRvQjZwK3VBV0pHa0pFYmZnU2g5aG9hNi9L?=
 =?utf-8?B?eUVJV3pHdGQrN3ZBL3h4NERLVEthaUN5dGhPYURIVFJxaEFmWWpPZnhEdkcz?=
 =?utf-8?B?NnZGMzNVYnF1V05SZDRMbmNHcjFhd3NDVENWZ2JyNkN4eU1QeFRBSUNjQmc2?=
 =?utf-8?B?TGVkclRpSnhtL1FHQTFtdkJobUY1OHlRVEp2Mkt3d0F3L1RIVXpFMXZzTlVM?=
 =?utf-8?B?d0VpT2VEY0RaR1hTNjQvb0N0YmF5d0RSUlA0SkM1Wkduc3M4RUhBSTIxcW1u?=
 =?utf-8?B?RS9MNXMvU1dycytNanAvT20yRG81T0kyY0U0VkN1cFdxR1lvMXdsSksvUExn?=
 =?utf-8?B?SUpybUpkbzJTK1hidlRJK0xmdC9yZm12by9pekJLczVZMFVOV25vVDZqK3RD?=
 =?utf-8?B?Y2puRGo0Q1ZoTXNFRTkxaVdKQVhyWjZCcmdPNldkN1JjQkdHZ2VYWXhWOEwr?=
 =?utf-8?B?QWFQUSt4QXBrKy9lMTV1UE5nSEk3VnIxZnhKNjM0QWV0VGlFVW9CUlVCRDVu?=
 =?utf-8?B?bjNrTzlONFZBVndLVGpPMitaTFNtZG05U2UzaThoWGplbTV4bHlPcGExblk3?=
 =?utf-8?B?NWhLcFkydmJVUUtVMDB1RllDZWovelA1RGVqaXh5aWRFRHI0YnpKWm10dGFE?=
 =?utf-8?B?Si9wdmkraUFNcHJLZHlsaVRvTllidFl3YTkrZVVHblhsb3p1TXR1RW9idzRy?=
 =?utf-8?Q?2AtrhfoLIKDD/fTbAsTUKe0bY8GCayVey7eCJnGOatWrB?=
X-MS-Exchange-AntiSpam-MessageData-1:
	hJoRyJ1cF1q8uZ2XmeEtm1mGSGJ8EAF4YwDo28KEjMX+gTQnjbUItSwR
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5b4d69-1acb-43b0-9f4e-08dee813a74b
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 17:07:04.3198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjBFyZkt3vIdV9lnHgufpS4LRT2qCcSg1wbTL9Aeca8aEMIT9eTCfPwhh1y5XaLZu7/r1mo98r4xXtEpqRmG2vTL76y/Xb25YK4UmJZeqrLgArBegCmegY7CLgtFDNih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6611


On 7/22/26 05:07, Sudeep Holla wrote:
> On Tue, Jul 21, 2026 at 01:52:52PM -0400, Adam Young wrote:
>> The tx_done callback function has a return code (rc) parameter
>> that the tx_done callback can use to determine how to handle an error.
>> However the IRQ handler was not setting that value if there is an error.
>>
>> The following clients are affected:
>>
>> drivers/acpi/cppc_acpi.c
>> drivers/i2c/busses/i2c-xgene-slimpro.c
>> drivers/hwmon/xgene-hwmon.c
>> drivers/soc/hisilicon/kunpeng_hccs.c
>> drivers/devfreq/hisi_uncore_freq.c
>>
>> All of these only use the error code to report, so they
>> are expecting an error code to come thorugh, but they
>> do not modify behavior based on this code.
>>
>> In the case of an error code in the IRQ, the handler was returning
>> IRQ_NONE which is not correct:  the IRQ handler was matched
>> to the IRQ.  This mean that multiple error codes returned from
>> a PCC triggered interrupt would end up disabling the device.
>>
>> In addition, if the error code IRQ was coming from a Type4 Device that was
>> expecting an IRQ response, that device would then be hung.
>>
> I recall reviewing something similar and may have had comments, although I
> cannot locate them at the moment, thanks to your random patch inclusion
> exclusion scheme in this MCTP over PCC.

That was Re: [PATCH v02] mailbox: pcc: report errors for PCC clients


>
> Could you please avoid continuing the MCTP-over-PCC series in its current
> form? In the previous v44 revisions, PCC changes appeared to be removed in
> some versions and replaced with unrelated changes in others, which has made
> the series difficult to follow and review.
>
> Please post PCC changes that are independent of MCTP as a separate series.
> Where the MCTP implementation depends directly on those PCC changes, they may
> be posted together. However, the current series appears to include several
> unrelated cleanups described as part of the MCTP-over-PCC work.
>
> To keep the review manageable, please separate those changes going forward. I
> may need to NACK future revisions if unrelated PCC cleanups continue to be
> bundled into this series. I will be away and would like to review any PCC
> code, so your patience will be much appreciated.

Everything here is related to, and required by, MCTP over PCC.  I had 
posted some of the PCC patches in stand alone changes, but got feedback 
from the network  reviewers that MCTP over PCC could not go in until 
these were fixed.  MCTP over PCC seems to be one of the first drivers, 
if not the first to make use of the Type 4 interface, and getting fixes 
in place to make that work is prerequisite.

So, apologies for the earlier separate of patches.  I am trying to 
follow the guidelines for getting the patch into the kernel, but this 
spans two very different subsystems with different maintainers and 
guidelines. This is one of the reasons this patch series is at version 
45, and why I am still working on this 2+ years after the initial 
submission.

I am going to keep all of this work together.  It is the only way I can 
be sure that all of the work is reviewed end to end, and maintain any 
semblance of order in managing the patches.

The inclusion of AI in the review process has brought a sereis of new 
issues to light.  Before the kernel started producing automated AI 
reviews, the set of reviewers had reduced their concerns to fixes within 
the MCTP Driver.  That expanded earlier this year to numerous changes 
required in the PCC mailbox.  Some of those changes will have the added 
benefit of fixing corresponding bugs that have not been triggered 
elsewhere in the PCC drivers.  Her's a brief synopsis:

shmem map/unmap was added to the PCC layer for the MCTP Driver over a 
year ago.  It was based on a change I suggested for MCTP driver 
start/stop.  These operations are much more likely to be called in a 
network device that will likely be brought up and down on a running 
server, than most HW devices that are only started at machine bringup 
and stopped when the machine turns down.

The changes to  ignore errors on type 4 channels was based on your 
feedback on a different patch. MCTP over PCC will depend on the Type 4 
device functioning correctly, to include error reporting.

In the message Re: [PATCH v02] mailbox: pcc: report errors for PCC clients

The discussion  was:

>> I think we may have to skip the check inside 
>> pcc_mbox_error_check_and_clear()
>> for Type 4 channel as the spec expects OSPM to ignore it. It is a 
>> separate
>> fix, just noting that here.
>
> I think that should be in this patch, for correctness.  It is a small 
> enough change.  I'll update.
>

Actually, it is a fix in its own right, and can be merged regardless of 
this patch, so:
https://lore.kernel.org/lkml/20260604163306.160017-1-admiyo@os.amperecomputing.com/ 


Which got no feedback.


The query channel patch is required for MCTP.  While no other driver 
will need it yet, it does prevent a false-start situation that may help 
other drivers.

I did order the patches to post a couple fixes to PCC after the MCTP 
driver, as they are fixes that affect all drivers, under the general 
idea that general fixes for a subsystem should not hold up bugs in the 
subsystem.  Those are synchronize-IRQ-before-releasing-shared-memory and 
wrap-pchan-chan_in_use-in-READ-WRITE_ONCE.  Again, these were exposed by 
AI code review during the MCTP process, and me splitting them out 
elsewhere would really make it hard for me to track.  A network 
maintainer could argue that the sync IRQ fix really should go in before 
the MCTP driver.

So, while I do appreciate the additional load this puts on you, I think 
you will agree that this set of changes needs to be kept together for 
the larger reviewer community to be able to see.  It is hard  to make 
things easy for everyone.  I appreciate your patience and diligence in 
the review process. I hope you can get to these reviews before you 
disappear.









