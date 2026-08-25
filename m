Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32883DE427
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646261; cv=fail; b=buGkXLu7vZq95zWI9GxT70cJLi2VXRK+USh65K3qgiDMfb6IzxUg78CblAgcuc3YQdtus1bIfSrLVCMudcQYV2qtFk+4d+yrhh6teznP2cqw/bs5jXaE929FzuBCeazDVhoMJ0pNZrOFpX+Up67KTGMRgPD1ZFtfjEgfJObXTJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646261; c=relaxed/simple;
	bh=AkB+6/JgYRVpHB/ssu8WUqq63kKVOg9KKaLqe67fQ1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=km133T36X3bEVO/UeWorVfh4tdGPp8Pl8uuRHWXGzkpgAsxXRL23C4uC7sTzGbl0W28Am57LbH/Ln7ssDHhyTLgjvz9j6qsB2sQzYlp21EiDt2F3GKOioTJhp8eLUlxp97yR+YF9Z2o+fXIV7ytKJrqMdcljmhUxb47VFt9f7/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ourL2WHg; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ourL2WHg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRYJsapB5nllqv9IYaHKuOappq26v4YydoqmPTbWn5FZyz5pknl2e4cczSIJohcl8SwdU4vYveyC6y80fpjoJNmoBmc6ZzL+HT2aZuwGcbg3Heovzy0CQXOzweUesquYxY96fXFXWYg3z7xzs4XN1370dursJpulBReO+exu5pHf6RKeMck/6VPkw+DML2nk2+pkaoU1eBg/joGyhnG7H0pUDujFU/PmZ+KsukdvHZooxnXt9u4Fw7eQAV6Oc1fmZVZ9sEfTM2AP+FBjMQ2E8ZygvErClGgmSCFhcS8G1393yF0m5NzKpTza95+DAl3RHU4yvfsSkIpsut4op77poA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wMHYm5JEgNpv+IpGrBKw4svF0olgqkoQtaWTKN7B4Q=;
 b=D1YA0VBeACqkJhLxHq7Axy24ZsPh7GGWaIn8FExNaV737D5aYQvKd7PoB4SIfu7Io3itd926sWYb63sRl6JVhs4B+wgvYERC+iD4C8ETrAqYJZ8w7iCtSzBGzEaMfgRwubRx9AeDaCXlkjfwiVVelD8Db7itEuZNWMMxBNfuu/ffnUcLcytyGOPT/V4A2K3E+P8YBz0d32WRPjggDTBxt8Qn+mYp9Ow3szY7EjoSpGUmlXKcIxbdyE8e1d9R7YKACcqEULr6rxfptplVlz8KhUkOzQlToku3nbrMI/CeYC2DiXWoB+g+87Al9qBSyzblwiQZMyJ9de0B7HsxL45Muw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wMHYm5JEgNpv+IpGrBKw4svF0olgqkoQtaWTKN7B4Q=;
 b=ourL2WHgsWgBTE6TT5ZqaUdkJz/X8Sbf/kF3MAn2e7WLOtHXJ6S/DGbu5OM/OFAwZn/6NTeC8O8dZC6Vo+kkoxlcmaAIIXsu6h3xuSj6UfdJ1coHnmEt1T1NoaK6CXgwaDoMBaL1ngq9NW2TqCxicWnTAeL0EkyLI/lJmDTBzgRggNKSiVEEC3zYaMwK7i2sqg6twXF8Bxj9fl+HrctOfVPThwAnc6vX3EHeXbPRhAGKbPU3aL3VqF4X1t15G/VScBvoxGoV1+JTTgRRCuyCS2ah4yiW1Ts1thou8y1GuYQ/KRWBfV1Pfe1ExobO9HW4Iukp7OAA+pswnsjjfLqA7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by DS7PR12MB9502.namprd12.prod.outlook.com (2603:10b6:8:250::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 08:24:14 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:24:14 +0000
Message-ID: <0444bbb8-39e2-40f8-b3c2-a5851e5bfa70@nvidia.com>
Date: Tue, 25 Aug 2026 11:24:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: MLX driver for host-to-ARM communication
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, ttoukan.linux@gmail.com
References: <ba322fd3-9f91-4e2c-9000-12d473ecb249@nvidia.com>
 <20260813081410.5fdeceb1@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260813081410.5fdeceb1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::8) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|DS7PR12MB9502:EE_
X-MS-Office365-Filtering-Correlation-Id: d53fd07e-6e1c-45fc-617b-08df02823f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|4143699003|5023799004|11063799006|3023799007|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gzIj+vepGfnsixD2PAp4liy1tyfHto1GwfZhDXfPA+4PT1rkrQGBzOPRLw+qasYd491bvw2MojNJD23PzWxAZoEg10rFHdcIaC9UvEfas4An41MXNMPyvwwsb3vqAezKlum7JSeJgEKvrGnrsNvPfcCFNovYYdkShUhGZj+J+Kckp+SXPG6mS47DWhxVCLmgovQIGJzLhP/fziNgHW5BG/bk1LvkWba4UPwJZkpdBCcWX8zt3uMVs64Vor8PBCKzXRNmPInOCl9utML4t8LmPDGS2DSbLKtG9s+812qtQfZBhkC3rTrV2YJgFV889C2yBjT7qdKaUeZuqbs9VKuihhp0J0oDZH2IYo8w8/6ml+HPctvNc5kgiEIY+uW9JvNOkgQkhn+moSqdFeiIoFRATGTEiTZVKct8bJR1/nhoYlw5p8Y8oiDDWFFkgaR7gakkpjLTaulvYDEHYpiWYUN14ogJ6qqFExO4A9JItFyLw2BF8OcMhEBNlWhz2qWYHfk9CofS55qj2FzXz+4zd8PhplB0sw09S0tIouQ+V+ZTa51A+lFQfobkuik+TrbCI64tkg0rMbWYzixXX8tL39GMdudaniYsXZj3M9TXWDMfNnm6VnQa76YykU0mL8ErHXDNIkI3Xnk4Yl8kRFmBHwxc4HkumQcFNC13g8KMiI2y4ug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(5023799004)(11063799006)(3023799007)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnZiazVGenNsU3B6V0pkUG1IenBLcng0L3FTZit1WnUzeStHWGZjRERXZlRX?=
 =?utf-8?B?K0M0S2xrR2NSdkdYaTRMa3BHQWJsOEd5b3N2THhiNHRaWUdZRDF5a1U0RjUx?=
 =?utf-8?B?eDZPbmcrY2lXNkRHcVdzVnBmK1dyTG55VVdhV3hMb29LbnF1RjNLK0ZFZVo5?=
 =?utf-8?B?RklXa2twRHovVEs0SndaL1Qzd0dTS01PKzVPbWJuY2dJVXQ1Q2pldUpQRlJj?=
 =?utf-8?B?dTlRY2h5V2JyK1g4dXVIMTRXWWpsdkVaZmFEU0J6N3FwZTJidDYrVDhyTDhY?=
 =?utf-8?B?aWNtRTAwMWIwNzY5ZHc0SUVSQ2sybk1NUy9WS0tlZkUyNmFjVFVsKzUzUGla?=
 =?utf-8?B?QU56SnN0YU5mb2tXdmVwZWhRbmJjZnpyU1BHMGZudnd2MnZzaGRiTmpBaU5M?=
 =?utf-8?B?M1N1RmhSbHVLUForZ3Q4YVJJdjIxNXZQbnlNYUhCY20vbjVpL1JLOUlERG9k?=
 =?utf-8?B?eitxMW5wMVJtT1RMK1dZVUU5UTZRa1d0NFB4eUJOeG9DTW9iMlRFOTNoOWYx?=
 =?utf-8?B?VlpTV29EbUJkT3VTYmdkeXFFSHZ1S2I5WmpLbUFjcDJsWTBSTzdoT1grM3RQ?=
 =?utf-8?B?MWFMaXZjbi9SNVdNam85eUs0NmZ1SytoTTdyOUZMYk5UYWlUSlVxOTBOaERM?=
 =?utf-8?B?NmdURGVtSGlOTnFuUEIyU3hHL2ZuRXlabmdkN3J6WmVWOTA0TnVzMTEwZDBT?=
 =?utf-8?B?NFQ0R2tRcDIyQUp6ZU94ZHhyZHRXd2FyL2NNc1QvOE8rcjF4OFFFUXdUcmZM?=
 =?utf-8?B?S25xN3ZvdUVMaEVsNE5nLzhFdmdVQndaa2FKYzI2Ty9EN0syS3Fnb2xxa1pC?=
 =?utf-8?B?bzRmRWVsSzJtMVB4ZzAvU1V3NDg5MjhvTXJ5MlBVb3VYckJMYTQ2MFl5Zldx?=
 =?utf-8?B?d2dPTEtUbitWcWdJei9pWVJnallxdzRWRXJKOUV0Mk8xbG9YRnlLSUIvSXlK?=
 =?utf-8?B?Y2FzRnpQUnhmdUIwMG54T2JCbW1kVEVudHZiRlNUamNvdWtUMjlqUTI3dTJ6?=
 =?utf-8?B?aUtmaE1MdUp0b1k2S3M4TlVraFpzRzhKUXVSSnRLNWQyeitTZ3VsYlYxTGkr?=
 =?utf-8?B?cEQveFdLYVk5Y3JQclNTbFB2dEJqZUprYjRpWUpHa2tyeXNhTnErbzl6M3di?=
 =?utf-8?B?U01PT01oZklGKzJqandDYUtlcDB5Ry90b0NhM1RUWDBTU2pJbExiRnlsZGpr?=
 =?utf-8?B?c1htTHhlbGt3V0x3SHNXQkk1dVF2MzF4NlR4NkgrblFOcmZIUFh3aHdHVlRw?=
 =?utf-8?B?cjNQRWdHNTBHaE1QVVoraktsMGFJT0xEMHhncGVPL2V6TDJ6dzN0bnZZUVdO?=
 =?utf-8?B?R203emZqREJHb1lnbHJQZDc0RXFNcUpJaU5JVmIzTkdqVXY4MWZkL3A1b2hF?=
 =?utf-8?B?L2JrN0ZpMVQvY1FldDh1MGpWUENuOFlvaFB5eGt2OTQxRkRXNVdCbDJlNXhR?=
 =?utf-8?B?MWpUbHpXdXB3ZjFmeWtGK3QrNEVISFEveEl5YTNvNGo2MGlCaVlCN3krVFM3?=
 =?utf-8?B?NkR5RzFtck9TL2RXVGdFbHVrdjRBNURKcXpFTVFiRnJtNlg0L3J2TTZzY2I1?=
 =?utf-8?B?Lzl3cW94VGNBLzNIUlAzSmgxSUgzYTRFaHc5SVRuVURmZGpvVWhoek1sVlJ5?=
 =?utf-8?B?S2pMLzNtZXZnR09pc3Zyckl5aW5MbzBkcUxzUDRsNUJUMnUzTk9IUlpaTVdZ?=
 =?utf-8?B?N0NrNm96dURaMDFZeXoxWnBUazBFNkQrbUk0VUcvQXh2V2oyUkNOSHk1UVYz?=
 =?utf-8?B?amczeHZKVEdaZFlvR1o0eXZiUkN4YnB3dmlzWDg1TDFKcC9OczI0QUE2QkhN?=
 =?utf-8?B?dVB5NWE0NzRVMHlYaFpONFVmeWxMMVhqVHFyRVFkL3RFZkZuTHdKd0dhaTJB?=
 =?utf-8?B?d0RPQUhQRVJjem5zS082b0VSMHBraUFXcmZMU1FQSkt6L052Zi95R1VYVTlu?=
 =?utf-8?B?cEhiZE5MT0N0R01UZjlLYm1kL2NJNFo1M3RobmpWYmlBRUIrY1lrazBxNXRn?=
 =?utf-8?B?M1dEdDZQcmRJdFg3dzl1T29DM0JRTE5YWjJQMm1xVWllaStQVXpPaEdpOUlZ?=
 =?utf-8?B?Vzd0NktSNkFUSzZrbVhIaGFua2hsbjd1WWNnYTVLNURmbFpTNGJlL0Jtc0FD?=
 =?utf-8?B?Znoyem42QnlKUW1EZm54bXRqWUc3U01waTNaeUlJWWVCWm5Wbk5kUUNWNjh6?=
 =?utf-8?B?K1c4dEo4OWgzalN0VGVYM2lhallwa0pLWmsrL3VNVTZmSHZ0VGNrQzZuLytw?=
 =?utf-8?B?SmVuRUVpRjlqbnRuNjd0azFUaFNZWHhlaTRLVkVaTUxTWFZ6UTV3TitPWTJF?=
 =?utf-8?Q?HKw4JCSIEMZmWv2HCE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53fd07e-6e1c-45fc-617b-08df02823f70
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:24:14.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Io57oIa9Mf/QSTffgTTPE6yDLH8foDN78zURjNVyzzgDo4HV9k/xDTE1er4HduB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9502

Hi Jakub,

On 13/08/2026 18:14, Jakub Kicinski wrote:
> This will be nacked. We nacked multiple such drivers over the years.
> Most recent one not more than a year ago.
> 
> If you model the device as a network node it should be reachable via
> the normal networking path. If it's a control channel - explicit
> control channel APIs should be built, rather than doing pretend
> networking.
> 
> Every IPU vendor gets to this sort of design sooner or later because
> it's an easy hack when running a user space SDK. nVidia has clearly
> turned from upstream work to pushing your DOCA stack on all customers.
> No matter how many shameful lies y'all told about fwctl not being DOCA
> related. This is just a next step. But please commence your bullying
> campaign. What do I know, right?
> 

There are some unrelated accusations here, I'll focus on the technical
side of things.

No DRAM NIC (NODNIC) is not a new interface designed for BlueField 4 or
DOCA. It exists in our NIC since 2015, and implemented in other OSs
drivers long before DOCA existed.

It is a lightweight NIC PF intended for simple packet transmission with
a small memory footprint.
It sends and receives ordinary Ethernet frames using SQs, RQs, CQs, and
EQs. There is no private encapsulation or command protocol. You can
connect this PF to any other NIC on the other side of the wire and it
will work.

On BlueField 4, the firmware connects the host side NODNIC PF to a peer
PF on the DPU side using ordinary vport forwarding rules. The Ethernet
packets are forwarded unchanged, both sides are Linux netdevs.

The purpose of this is to provide network connectivity between the host
and the DPU OS, particularly when the DPU’s OOB port is not connected.
Standard networking applications such as ssh and PXE use it.

To be clear, there is no hidden FW involvement or handling of the
packets, these packets are forwarded as is between both sides.
It makes sense to use a networking driver for networking purposes, I
don't see how control channel APIs are better for this.
