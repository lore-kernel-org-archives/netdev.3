Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D076026;
	Tue, 18 Aug 2026 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035195; cv=fail; b=JmtUnNUZRbGyo0d+1XWQA18Y5vTFxoP29N9PTqaKfl9cPlKjIUkRjbak5xXUQaWzpDQiKWLIxXdUq/WmLVhu5VTvSFFDxV0JADV9GhsU2P3T7IB4jMfCnLpwyybtEZQidhIYmTMcOEShlHfPTTRkOnLoZtXdKTnAO9DSdMRlMj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035195; c=relaxed/simple;
	bh=cdRwpSTRhgzcbOZlm4XpGtimxZhKfBiYu+EhnFOUkzg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fymRBtvX8WbUeruJuT1nFsebj5DBYxBXJIEj2OJPDhXtfk94j1pDnKgw6mjPQKiCns4nBoJy2bn235iu8Emz3A3h523kStOmPi6pXUSTdSJxzqHuvEC3+9v3fvg6bfx0GgBrK75emMbzDiOmJH0rVqPCNrCD4eyzKOdx6N/+xZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SpWqfvfV; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SpWqfvfV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcdThPEpogsWbk+3TXWa0V99Z1Smnx4FhmQHQd7CCF4azqyUAOoukolkcfxAmo4kqYh9Zf52vwbFzYDRv4U0Ij5GFZJLyby2QIxKZrxJTJr/mUP1SGF+Fj/7kDFofiKx/oNf5ZeQ2LOK6JtIPsTdkgz4uw43VBUM7pSKz9FMGu0qNR+DqOZTG5pSGkAu8QR5YWNxs1OXvOyWCI9oDr9n1FvzusVGnwaN2xRoCaob22PEb1rmNqDSJbaURmT3A+Xcsu48+DL1y/MQ+NsWnuiU4r1GawyoubmCXDCSt9vC3i71g4HzX5vdRJtBWedai1icyfeEWmFDGhnvLrmzIoSe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiBCM1LSfOLRdy2trqmOueKmSZurPWdkXewGwVBgFh8=;
 b=zWSxLBVWxafYWyzx0vOt4DsOHdZCcEIJbgPVQqoj3Wx3lRETtCmJ+YF03zm7VXzDp7z7D6/uXeg+a4wamg8nfakkNmAfIaRU1u4Z6VX2B+gR0sZVoylBZZnT4y9iSV6dj62QtK7O4CmncTdh4S/njdYuvzgn6ImndaXrhv+gLOOvFTmKMF71bqfFIcJQiip9z4Y9g9YaSjicj3+n8uZLhIP9vZ43NlxHL4LudTo9pnmfBY3b+FXomMvO/yeuL9dckKlXGB0//0myJJH/xKmVW7tZpI5Cr6p2KYCOSSirV/EyFVllQBL9tdCtl1fmD129bObIy957LWnf8rqhLdz19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiBCM1LSfOLRdy2trqmOueKmSZurPWdkXewGwVBgFh8=;
 b=SpWqfvfVC+d+3Octg2XLjWxpuabDk1yZlAiJT8i1l3EgARBji8hPztANoi7ztXG5cwD3Yvn79kRH39KcGltFTj5c8+nfrkCarOpldubE7IwYmoHNaOYfcSzudO5UtxedfLCdYWH0k4fYfwo6e0IK5IAoVcMZi+S8CldvfuFIIdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8)
 by CH8PR12MB9767.namprd12.prod.outlook.com (2603:10b6:610:275::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 06:39:50 +0000
Received: from CH1PR12MB9717.namprd12.prod.outlook.com
 ([fe80::b26:bd7c:5076:9cd4]) by CH1PR12MB9717.namprd12.prod.outlook.com
 ([fe80::b26:bd7c:5076:9cd4%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 06:39:50 +0000
Message-ID: <38099370-269b-4d3e-a686-5b29d806e6a3@amd.com>
Date: Tue, 18 Aug 2026 12:09:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] net: xilinx: axienet: Handle optional IRQ return
 value correctly
To: phucduc.bui@gmail.com, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260817105241.63345-1-phucduc.bui@gmail.com>
 <20260817105241.63345-2-phucduc.bui@gmail.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260817105241.63345-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::10) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9717:EE_|CH8PR12MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: 5356c712-c3bb-400f-0b70-08defcf37df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	TG5B8AvnGdo4mLRe/CiOUOZlex3uszJoUNdAWAfE+WjNoRNLXOGv7kY/D5Ua3sSN7UFZj9v4jJCIPL5x0k/dg7R7ILbKoz16ChAEIRa4Fb0CuYjWYYJfAx17plLveWmggBUQ4NspvBwj+j2LENu9NPsgP/UjvMqnGzZhxcEcVKJF6U6F2QiRsCttTholdnDjoU6UeMiVZ4aNYIAoTZAWD+n7Zds9JAex8KwKy/UFqQngxOYL7kYJDKDN0tNRm82a2TLh3ilB3Tdcgb/0TF7GyNLfKvFHZ7+PwoD7wi3PkkjWAe9P/kX0a5VNHB/DgTew9u71Qy6Gc3FD+u9Xfy87SEc66glyDIaXlllvMqLEZ6ciCyrfv0zsN9iGuwL9RxErGYnTliHyMsZwWzYwZxum2xJfVGcxcIDUwk+SjRPFYHe8kaXC19vfJnWuDT4yK0yYDNpVSjIgN7YkG5k/mz4qcZNQJvLCNl4plvUrbg4dKYTCoDYubpLz9lNBbuHguU1Qab1nhzJhRMTaeM8HC/yDhDZjZXvnTNcEDep9XFwaV89Ej48CGg2fwr7CXW4juxjlLkZW1bG7BBV0TqkJjuOTOiAH8pHp1/AXeLMrctJ8iE5jwzDo2pfoMQX/Z8OP/TcttSoCXT4FhM7fxbblP2arYokPju4ao3LVlUgtGE8yGFk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9717.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emVGOWRkV1RZRVhiZlQ3M0J6Wnp3SThBR081cGI1QmErTkRUN0Z2VFBoN05U?=
 =?utf-8?B?V1JhbzViaytldTdoeW5mKy8xTFBBbmRob1JRak9NQ29CNG5mSzQzQk1SUWVK?=
 =?utf-8?B?TGx3R1haQm5ucGtEQ1JxcmtKVy9KU0xOOUVZUXRtRHVLblVIY1NPRm1udTRQ?=
 =?utf-8?B?d2NPUlRlUjBFd0QxekxlaWJudW42TlVDQnRFbXl2MHJlUzZUU210NEd6dTVy?=
 =?utf-8?B?b0R6N0JWbVhvUC90dk5DY1MxeDJzU1NIL042SkJJMHl0ODhodVZYbjJUUStl?=
 =?utf-8?B?Z3VLbEtUaENFV1pGZVhzWUd0cVJlb01IRzVIc3E3dWh1c1RLWUlEVzg5Q0Q2?=
 =?utf-8?B?MkdaZkMvSzVTUFFyVzJvcUpRaVdDWjJYa1k2Y2VuK0tkU0RXSkhzTVZoN1B2?=
 =?utf-8?B?U3EwN0JBL3ZXVjBDMHdrcDNtK2JLM3FTbUdkNGdwMTJFYjBFbXZncnZRSmlJ?=
 =?utf-8?B?SWtkRXJ6SDliRFJEWFh2d0NMMDU3QXpickk5QW9xM1ZUZHNmUk9NUWZtanJR?=
 =?utf-8?B?STVGUHp2aFJoc1F4VGJkRDFBUCtkRFVDQVNhd0FwUi9VVVcrWUVwY3dvMU1Y?=
 =?utf-8?B?ZzN0T3Axb2Y3L1pDZCtRL3J2QWFLUWNsZzlvZ2pVSWpQUDVlODNDbnQ5bkd1?=
 =?utf-8?B?UDEwVlFvaHdqUGdUWGI3SGl6V3lYc25JdE0xKy93SXBhdmdiZlpxamg5Z2lC?=
 =?utf-8?B?K1RudVFReXIyWUxmVDZUUUJDVGl0STZ2R0ZyWlQ2RFh0cHptemJVNm05YktQ?=
 =?utf-8?B?bW52QnVvK3JmMW0zS2JlMVp5V2p5eUsrdHFMdi9DV3RWbkg4cllJOTJGWGJy?=
 =?utf-8?B?MFZIYnpYeVJONks3MDRpc0hQaHRUQllzWklVMlBPMFpRM0Ztb1VVYjUwN25n?=
 =?utf-8?B?dGNYUlBtcGRZdUkxUDkwMmlvZW80R1hxZXRFeGtiUFJWaDZrVGhrc3hIUE5w?=
 =?utf-8?B?MGdBWEJQZXl3dlRkTlRKRnRvcEhmNXNVaXR0S2g4ZlUvNzVoOUJkMThEbXdh?=
 =?utf-8?B?TmFtaEk2MmU5N1p3Rld4cCs3b2wzM1pxbDFZNnlJOVErM3FYNnN1akhiUjQ0?=
 =?utf-8?B?VHl2bHBXOXJFd0QvcWJWSWxFVksyMVgxNFY2L0pHaWpGREJ0eUQ3MjloN083?=
 =?utf-8?B?M2t3MU11SkN1K280bk5HQUg4bXgvME9HVlhaZVZ2R1pYNEVreERacnhaU0pE?=
 =?utf-8?B?MnZHQUFRdjNHdG8yZ2xtRGk0SXZIeXFrZnEzNS83ZnhkWWY0dFBlOEVwc2J2?=
 =?utf-8?B?NlExMHhXLzBCREEvbXB3NjAzbEZnSW8xOXBHaHpZUTJ6eWhzNVdldVZkMENO?=
 =?utf-8?B?b2d3OEhwNjlYZHdScXAzSytNSzNhbm43S3IvTllSRnl6SWNkUXdiaENqa1Fv?=
 =?utf-8?B?djdET1E2cjYzRklCRFBIbUwzd056MHNSejIxdGdldkVGSjEvd3Z1UFNkZTdP?=
 =?utf-8?B?eUxBd2Y0M3Nybm1lU0VkUFVRSGQzaDNjY1BTVEpiaHhVUHc2UTZmUjZUSmo1?=
 =?utf-8?B?SURlU2pBbkE2YVg1cUFZaUJCTU5tR3Jkdm42bE1LOTZBOXQxdDFieWhVUVVx?=
 =?utf-8?B?VUtkUjd6R3FOcThlcU9UVU8vcURaWjhTbWtpalVpaUpzZU9lQ0Z5WGxydGdI?=
 =?utf-8?B?NXUvajVJYndndHV1ZlJjejBsWW5kbDFOcWRwNytNSi9VNTRLTVhCN2FrbXdr?=
 =?utf-8?B?WTRNQjcxQVBleDNNK1pLbDdLYWt4TmVUenN5TlFncTY4WUNpczRGZW1mN2Vh?=
 =?utf-8?B?L29OQXZUTWI2dW5VZ2ZPMzd0RjRadHNWRmY5VncrRlM1RzJ0RjNMRTlNY0h5?=
 =?utf-8?B?Y1owejdSWDlTandDeW5HVzRlUmMxZy9JRndvQnJrOWlqNWJRSFZPY3AxeURQ?=
 =?utf-8?B?cE84VWRMOTdDNFNmQVBja09nK2F6MGoxNUIrbG9OVnZvL0VYZVNVVFEzVzRa?=
 =?utf-8?B?VXJlVVJPMUJubStSTnlYOUQwVHBaSzhKdkh6R1FQSEliRlhqN3hYUUNTT3c4?=
 =?utf-8?B?RWJla0U1U2JFTkxMNzhzTTdqNzZwcWhoVWloOTR5WDVCNDA5Z1VoeXRUNjFp?=
 =?utf-8?B?R2NRUFZORXhvYkpMc0lOTUUyTDh1M3Jlb0l6WU42V0t3clR4NU1BMldLVVVh?=
 =?utf-8?B?Y1BwclAzc3hHT09tbW9mQVhMUWpSZGJQR0lQOUpmajVialkwbm5KRnVCT2E1?=
 =?utf-8?B?U3l6aE43Z3l4SFkwdnp3czBESzZKamJueGpxVzVGb1UvVkZQSEhwZnc0dTJE?=
 =?utf-8?B?TTdxb3prR0J2ZklJT3BOaEdMOURJakxpTkNud0ZXZGNpYllicnJnYzR6OE1F?=
 =?utf-8?B?dm1VckxDQWI3dkVSY0ZucHM0bjFST3lVRWgrM2xtWkZGY2paV2pVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5356c712-c3bb-400f-0b70-08defcf37df3
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:39:50.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylzlRVrXYcAVwkL57ac7EPsCp2LH3OKZCDGQCzGX2hd6oyoK8sfIAYw/HYm/0E+R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767

On 8/17/2026 4:22 PM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> lp->eth_irq is assigned from platform_get_irq_optional(), which returns
> a non-zero interrupt number on success or a negative error number on
> failure. Errors other than -ENXIO are handled before this check,
> so -ENXIO is the only error value that can reach this point.
> 
> Check for a negative value instead of treating 0 as an undefined IRQ.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index f92951422b2e..50f88a38b6f6 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -3049,7 +3049,7 @@ static int axienet_probe(struct platform_device *pdev)
>   		ndev->ethtool_ops = &axienet_ethtool_ops;
>   	}
>   	/* Check for Ethernet core IRQ (optional) */
> -	if (lp->eth_irq <= 0)
> +	if (lp->eth_irq < 0)
>   		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
>   
>   	/* Retrieve the MAC address */

