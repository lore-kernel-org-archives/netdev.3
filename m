Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0A306B3D;
	Tue,  1 Sep 2026 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788233249; cv=fail; b=dzKggxeQC2JRAUkMMyO98wHvp+1vLQWsE/ZXyfGEn6zzRD/jSAptZ/xRh8UoanZzT5cz4JrWuIw/hAkOixvuLIvnrZUy5SpiouBXz6ugul7vprUl4bn9j2KmYLOY5ZyDaO4LUTr3qBK1VmStC/Z/ZrLy7tppSX6Pu0pmV0kbm9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788233249; c=relaxed/simple;
	bh=q58WDDo+a7HY2exvo5rE4ancGw5LCZecrw/x9diG9XU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gwSTGDeMGvX6KYnHG4yqTvrlRDyPoxRFcCacSJaagFpDrxrQ+9F1M/eeIAD8W3A7xaqFPRiNj2r+yC4heUwnTYVImeHnINSbgCxqSDPLAkB1YsB6VVXSte5/N3bJW/6qFQcCjUUFhzqjX+kMKaUn40u9gZX2jdH56Pm3NxP94sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mJS/o3Al; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mJS/o3Al"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzkjz4I6I0g7JALWgYX9U0LcUjmE3OxriUG6i5tKTglcLkinbrnYlZIDOwW9bTPZgCbQvQWmNgDa4W0agU7o5DuDOfv7k1d8wBi39GhMyt8z+PMPMqheDA1AJnUbFRhEWORmiCetHHGAZJaZAILc2xXmBtfNxmlWX5FMcWbWkDB4l4Pzk2RbTPfVT9yGfr4VcL5IzrCCt4HCu+o27S8hROYAoCD9Ep3HCQUkf7hFcR2itJHpstZzC03wKPEYhHwcqmRO9ZpMm4YKUu6GqiNlKFIbEuIqJZfR1Ri6i/ZpT3jRcKPOnAVhiSP4f3SaqImA391fPHJCrawFDsrSLsCLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNXd4maFwM6ymhq7DSnfwltUs9/RBRUkD4BiMNRlYTQ=;
 b=TjqOpuSQV9yhHt9WXG8f2dnmvLTXMDa2vvbyGeqfDfMdJ7kFCAKVhcy7zoUE6TI0Lyfeb1r82TsDvdTUesZFsXeHXOhoStfzz3UVL1BWS9hY+dHNMCGmpJnStaUZG0eMUJikbG717LM/r1viad5kdyP5Fc0DHcLRsuOH5zD4PLWsr47brPxlrsKD0XCQpiietkE9uqgDpttEoMnJCGkKrLm6a1QRGIHFeS60CshYdSHLx4g7Pc5X2Niz2OlmDbz0w+4q++8SjU8CY2jN0bkCtEhJKIvMY2eVNMbXeeupUqChp6TEJKhcZaHQciMTmyxIHfz1i3qsigtM2MvHcCUyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNXd4maFwM6ymhq7DSnfwltUs9/RBRUkD4BiMNRlYTQ=;
 b=mJS/o3Al6WEA9560KJO7Js2GLwdB67N/uF0ycgSUZgA3FxfFFfOEh4LOr69y/9NkVlcxP88GTVK1t5CE6QgPyu+CsZ+fukMBekFWUR8kFAImMwj6zB4T6XfDOCk1xVN2HlrFgq8/y5T63CKlLzicsSSo4qPLRSTnt4fkFcDnCTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 03:27:25 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%2]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 03:27:25 +0000
Message-ID: <29d0926a-415d-4111-8378-7d7bc4087a04@amd.com>
Date: Tue, 1 Sep 2026 08:57:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: xilinx: axienet: Add 10G/25G (XXV)
 ethernet support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260831150816.1020883-1-suraj.gupta2@amd.com>
 <20260831150816.1020883-4-suraj.gupta2@amd.com>
 <fe83c236-ce55-4c33-aa1f-23028e978696@lunn.ch>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <fe83c236-ce55-4c33-aa1f-23028e978696@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::10) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1c4db7-1783-40f7-30bb-08df07d8f0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bNuJJbiikpszoLLJt4USC161xCRHYcNAjpIDGuAKaBCX5cyo42ehGGxIycxcZb3FMrk0M9aw8lSOeKseE1yJjt/c+gkMqjn9SfTPTPddlhN6tO9jQouV7eQh3XYh3JZxkHlJa0La1SpbWau9dY63Wuo4mKFc+fNGdi6XBOfLgpPjYMnCRrloOqrfqRD7m4RwsiBzScFxcZz/xGFhdLq7LjSDAIhRPW24mpY3AImj+esWq38twykAw6fO+FpNbX93erQMq2r06Q+mdCFa/8w2t+bV59BknUTJndJrt4MZy5eyQ6sHsCMH3RT9Uu1kSTqD+S1WbV1tR1vKM83kSYlDzke7o+rt+4vlz5pwZwmn+0TEAegerMil83iFlLyowE87BU6raPiViyDbW5OLX9ig2VK2WUE9wgDIiCFTyNXWCHKbiUBgRRis9yLQnzXyN7R4BxLwJsnK32rhJpm1kgwQKqiuaM93GxMEVv9NbK2lx/8FJSkc3Sy9bGFpm8F7kDR0LBYJML8bWByHHZJw3aUL4a+CnbiIWJvsAmMIRR1fIyDAU7fu91TjzzKG9WTRsb+TTIYXTiGOfzpsnt9ySUyMtVr5g+srNwJ8w5ZlpadayqHZbf7jn+0W6flNNEtAgB+nm2iIQt7U1xLpNTjl7WPh16PCfESlUJ5lC4wevjdMlFY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZldGMkNnMS9veDdkeWUxSFNodEVpZ092TUZnQ3k4aWQzeDZjSnFOcXVMNCti?=
 =?utf-8?B?YTZoMWpJdjRneW4vcmZtaDlmR295U3dBWnMzRkNUbk8wd1BKQ1N5SmZsay9D?=
 =?utf-8?B?UUtzZVpLWnRIUFplVGNpdUtraTBHeC82RTNZRmRUMHdvaUthUmduT0hvK09t?=
 =?utf-8?B?K1pvc0FuRzZzdzlCdjVHUGZrME1ZanZxcTVSbjVjVEFVRGV0Y0hLT2RJL29w?=
 =?utf-8?B?UHZjTVNsK1dkU2c4YXRrTC83WG1zeU1OeGlmd05hdmxkdUtaWHlsL3BxcW1x?=
 =?utf-8?B?dWJseGhsZVFCanBVN2xIWUJEZ3BtN2dvdWlndDQyUmNJYm9rcXdUUjNoL0Nm?=
 =?utf-8?B?UEdFTUZHOG5TQTN0RmxZRVN3eWVGWnE0VElldWlzcCs5aWtUb3JiejMrampm?=
 =?utf-8?B?TWZJeWJQQW1QamVIVUc0K0hmdERnVkk0bFZmR2xWeWwyNFNkTGN2QXltVDlL?=
 =?utf-8?B?UUpmdzczOHZLaTBscUdFNnBQU3hqMzJZNTVSNWtpeXBJUm5aWGV3TzZiM3Bu?=
 =?utf-8?B?bzQyRXRnUVUydDhmR1hnM2hyWkVGMXNQTXZ6WTFJcGVwVksvQkpwektscWVP?=
 =?utf-8?B?Y292RzJra0JpcGJIYUIwKzZUVjF5QkNVU3dpSEJsWmdtQm1vRXhDMGNTenVk?=
 =?utf-8?B?d3dDcGYrK1cwV3RIcTVmWVovMEhaUnVrWGVEalVxUkpXRUxmRlhmamRMWWs2?=
 =?utf-8?B?L084U1VET2didTI1MDZPYTkwSHlSU3htSmNoMXI4MzdZM201UldWOFF0UXJZ?=
 =?utf-8?B?YnBmL0xFejZqelB2L3JPdUZESWJsWWg5aUJQemo5TWZ5ZUxBdG1rbEFLOHoy?=
 =?utf-8?B?N0VWZlMvZE05cmoyWGlZVUdtVE8vMGNVMGc2Y3puK1JwcHpiWXZoYXNYMjFI?=
 =?utf-8?B?T1VrR0hQYkhiM1cwZHdnWWUrV1duOWxoeWh4SDIwWVN4SXlaVWdSTDlUbldG?=
 =?utf-8?B?WFBnZUNGUEgzTE9mVUExUTJnY2xvdm4xbTh4MlZSS2NTTGlBOGpkNVBGRlhy?=
 =?utf-8?B?S0E3ZnVuVjZJeXEzZE9xSkVKVktBSitzZXFsTVE0NTlWY3BVSmlMNFVWb2pj?=
 =?utf-8?B?SHM0K2tqdkJEcUZBaElqRzdJZmhSVXhxaFRDcWNkdXRaL2RrZFc5L2J3Smd1?=
 =?utf-8?B?VlNGVTZ4c1FpNjRBcHQzVHVRWEs3QmRNSGZ2NGQ5U1BDUFVEQWR2QzFVbWdn?=
 =?utf-8?B?bzZHbmpFalJLVjNiV0oycm5ld2RhTlNuazdwWnNqQ3VacE5HeHZkSUc5RUwz?=
 =?utf-8?B?TXZ5bGhkeFdGNlZoTWRSa2lCL05wYk4rUTQxaUZXRWFzQzBjb0hFR2lJK2ZJ?=
 =?utf-8?B?ZW9kYmJBWklETHFUM3UyWDBOd0I4TGVyUDc5Sk1YT2k5cHlHeElXZUhxb0Ey?=
 =?utf-8?B?S1N4RFVROHZkMlRZdE0vYmpwNitYWmZKVmxtM3p0cTFsUE9qOWt0bnRSUFB0?=
 =?utf-8?B?QmMyWU1RamlSaFZnZ0wwZkJTKzVKVGFUTUhjdVFVVDJzTFZMQ1FWcDV3MUFu?=
 =?utf-8?B?MDJkakRtOXB3V0p1RExkLzErQmJYWkw1clhzdEdwcGJ2ODU2U3hJYTZ3RDN6?=
 =?utf-8?B?bjdFRkpVQ0tHcFU2WkJTd2JrYUJQMFhHZ3FjSU50RWZqQlV3QnhsK1BKR1ZN?=
 =?utf-8?B?M292L1BVTGtPbDgxVE12RlluSm44OVduSVFQNmczRm0wRHFqT1FaVnlzYlNS?=
 =?utf-8?B?emw2aCtybTZkaFAzZ2IxcmFqbjNhWUh6eEYrMkM5Z1ZXQzdJVEo5eVRVYU01?=
 =?utf-8?B?RnNsWmtGcW93N085aHlmQWxLT2d2ZFptejlBMVMxQ3UyWXVHbmRyNGoyVGdD?=
 =?utf-8?B?aVdNN0JMWUx6V1Fhdy93TGdLbWp5Wjh2Ym14N3I0SkpKa3FmSzcyREtyVDBu?=
 =?utf-8?B?MHFEMStpOFF2aGEydnhSWmlDMEtlMDdtUzVjbUpHcTR4RTN3L2hOdUNldjl6?=
 =?utf-8?B?NU5DNWRuUWhqMlpYUXBkYzV5ZzRHQmpQODF5bUtZc2NRT1kzUTVvbmNEQWVI?=
 =?utf-8?B?dXlCSnhIK1FNNXdEVlV4c3BYcmN1c0EyeDV3RmhiYVlPSml2NGlXTzdVWlVS?=
 =?utf-8?B?K05VVW9vM1IrMEcrV24wQnh2K2xsR0RCU2ZXeUdSNHpSVlk0eFJFZWMvd2lL?=
 =?utf-8?B?WDVzVDdJZ3ZKYThtMW9kOWhIdnNYK2ZJR1YyTlJsS0N6V0h2ZTJFbmxSUFQv?=
 =?utf-8?B?aWVIeS9jV3NPM2hsQjdXSmI2ejhUU3dQQkJkL3V5MkRVV2hXWlIxZjhyMHc3?=
 =?utf-8?B?SEIrRWxPTExUbU9Iemh5d2JNQUpiSlVDQnlYbExJaXcrdTlURktGSENVcGJr?=
 =?utf-8?B?Z0RXQjhIMGo1SmNTcGxoeVdNQk12S3FwVmcwblo2NXlORW5LT2V5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1c4db7-1783-40f7-30bb-08df07d8f0e1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 03:27:24.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWxjQdPIUdQLxit8Z1DlDBq8N4nziRNZUgfWICCgfGLBTxwOcTC5LyMkAaQeTGoeZnZHP9ZMiuGpdq95Ta2p1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906



On 9/1/2026 8:22 AM, Andrew Lunn wrote:
>> +	/* This error handler runs only for the legacy embedded-DMA (1G) path,
>> +	 * whose mac_init() cannot fail, so its return value is not checked.
>> +	 */
> 
> Is legacy the correct word here. Have you stopped licensing the 1G
> MAC?
> 
> 	Andrew

By "legacy embedded-DMA (1G) path", I meant the legacy non-dmaengine 
flow in the driver. This path does not use the dmaengine framework and 
therefore does not communicate with the Xilinx DMAEngine driver; 
instead, the AXI Ethernet driver handles the DMA programming directly.

I agree that "legacy embedded-DMA" could be confusing here. I'll rename 
it to "non-dmaengine flow" in the next revision.

Thanks,
Suraj


