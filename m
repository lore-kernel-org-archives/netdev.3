Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1443B483;
	Mon, 17 Aug 2026 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975106; cv=fail; b=dnc2OGtJRWd3Ba94RZYTuXTd94j/gYkmCSBifq9Qsz7RX6glhP2w+dt816lCJr6gtp2mCSy+Fe/BgtMo7U6MrBBxZWhyblW0ki5dVqEJ0anp1UvKA9K3qemyh1q73tc/BsNrhf3AM73w6vxrk2zpriaiqQCPVSLYdePqpxkc8Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975106; c=relaxed/simple;
	bh=qrRPQxgSqpEVR44sZlHI3xLgzW8y7KG+5EAxZaTqVmg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FGTfvTAfUYV3uRD3z8w2oVKhlprwjQfIYWkx1Ij0AJtDgN4jCLwTfEBmspnZTUzDz71LVt1TTiAzRX8wgFBrNtWzCoVWU09xoDbLuGLWWKlF+oxs+BmZwFYchNw/0lIZyeJJRyogynzQK0BEhUVcFZ03+bK5iraSE+vZL/sHz+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qAnvaoJi; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qAnvaoJi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qm/OiiTfg4s4RLq2aSaY1he128g9QuwuIXItDqZI9rnqOKgUZJGLVJuyooYcwPYQmpjq+v2MqK9ZC8Xd+BK+KW9qEN/LORzf+47/wcSgzuX2+9aNQOTGv6R16uqhJEpqWz8GHX6AyUMe8LnNMfL6aLs9z0j5fmgWsHzI4ncUewOsegjP5viTfQ6Dp/AyG33k0o9a+DhGp2BUOQRUgJaEmj1BCUGhI12ZRegQWxvUGxfRkZ6s4SLnJ3l97GnED2z62OfjUIfzQxdyucHZBLd4wgc0dA0DjkXzNbwPZM8gZhSxkFI2UvbqNxsXSLtKZ2txkRx2IDcSMskoZMlUMgFEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zTjy6O6uybvfPxcgqH6QnK7U32G4vAnUh4izrwXhS0=;
 b=GcYdMNk7E1T2TmXs8tJuqNaQ4jNFp4r2U5ON6fh533/1ZVR18qxaky37dswt/6CYulQSkjaJG95ADA63hPjEWARmeUeLOMC/FCD2YmpcSJ6rZ+3L/QeWYx6IcO9tOm0GsL3/2+UzoM5kpn0FUMBxjcjGlPf9jg3BPc1VQHgEWAWUWA+8WYEEnd+JneNJfcgT/hlBkb1evvFD6ypltUudrOcHYhZa2G9J/L810dyZr1iPNXg+3ooBTCuxcRCX36L8FSysZSsyRGalht/hi5Nk+AXTClCnppa29uKaA8rwgRL/Jqe7XeXnblHIv3WF256puEi+dB3B6bWx5ppByBhovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zTjy6O6uybvfPxcgqH6QnK7U32G4vAnUh4izrwXhS0=;
 b=qAnvaoJiaZt3uFfwrp30cptEZTXIlBLmg5AgeR1uPJVkASBkRAx6k7SzF8yR4PCzMuY/vraTMLektBJLQR6DA0MaIX3qT6dZ0ZYi8OyZFgTpHvyJSZB/so9gEg1zGSrt+lLCbLRHjlwr3bj8+vsZ/aG8pMZhTTwqAEMrnyND+sI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 17 Aug
 2026 13:58:18 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 13:58:18 +0000
Message-ID: <0c2740dc-eefe-4ca4-8d6a-0b4a9fa8e139@amd.com>
Date: Mon, 17 Aug 2026 19:28:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: xilinx: axienet: Propagate errors from
 optional IRQ lookup
To: phucduc.bui@gmail.com, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260817105241.63345-1-phucduc.bui@gmail.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260817105241.63345-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0076.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::10) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa4ea65-d661-4091-e673-08defc679738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Y7ifhbnierVsRlDkZm+HqGjmPBGPOaRR1bo91mdofjSB6QONSjSN/zRYLozURJcdPAQ9OjZmtAe1k73jHcxCxTz+QmOnhYiR+pL32K3o0lAx8WYR/VD0EnpBUdFstvm7aSa2obpCxhfjEyJvjnZxQXd/GRC5tau5B7FqhKar/GJEvqOVrEsgMPSIBAnukl3DWBUIU/YOKCKqKElN10RIBDs5uSJKzr1yryoGlQdoGynkzKV39fyBLegftco3jfLV7NStusqfFpX7GouiEqVVd2c5F38fRnSutyw9x0cOw38vFhFVi0CwjZmlx0ivQtLmhhMYCUv97OqP6zts6b0rOXTc6lPI/459ELpHwwZYLZZIxrQfKMUZKW7MTlC3hpdC/JBigvce0r4VxlreZhSoedWJqdj1/dkMxWuT4aVK4wHI+Hm/0E4heRKnpD8h4ZntULBz+WHromaXgj6/lewz09ED8HzOwmNcE1N6y35j+zrUQHU7AGIYYzXeSXytYoQkCvHWL2fComSAD8Agf3ufXobrtOsuwc+cOihKEQZtaHMNbal8upTFNX0a2hB8VQ0wHdJG4DC09vwyqPbY0w78MAROpzg2QtJJ4AU+lKAS1zGnX3uW3fgs713R4doLuJ5fO1/7rwJOTQ0ydCzJdOGaxbEkpHZXACw58mTXRtX7Ym8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFlUUjQ3WSt0VzV5N0g1SExwTmEwbEE2RHpoUi93VUZxclNQalhKQ044L0o3?=
 =?utf-8?B?VHpmL2IvQXAwV1dRTHdpUXlQdTFBN3RqbnY4UHlqZE84MElYellVMmRBblhY?=
 =?utf-8?B?a0lPc00zaFVYK0pndk9KZmJJRzNuTDNWUHFrYnBEWVE2TVEyd0s2aUxveUVR?=
 =?utf-8?B?RW5MT21KNmxCQ3lUT3RMY1RFNDlnQXprSjkzbWlYSWFsNTZ4SE5ha2w1blpO?=
 =?utf-8?B?TElSRzM1MDZhNFRYRDVWeWU1YXpnREVyY1N1R1VNODJqNXdqVnRTWDNEdG5J?=
 =?utf-8?B?Nkl4NmJkZUR1N3RyaDR3TGRDWkU5Q2ZTeFg2NWlBUXlyZjZwMGErdG1kdUxJ?=
 =?utf-8?B?dGZBZzVucXNabWh5eVQxVjdUdFZENE9xSG1KcjJFS1B5WjkzVG1zWnZERitz?=
 =?utf-8?B?N0RyZjUwRjE4RkVkQXczUVkzT0ZsV0NRanpFQXVXUlJUa2ROcEVJL3kxT3pq?=
 =?utf-8?B?VXQ2cFRHKzZHclVmVDlxQzc1RzNMZWdlZVkzUEV5UTVhT2U0Y0VWVmIxODk4?=
 =?utf-8?B?K2NsWHp3OHo5QzdlcFZRQ202T2ZXQnZPb2lPakxNajJkUTliYjk1NzRQMmdK?=
 =?utf-8?B?N3BkUGZyN3o3L3RWdm5KVFZYZ05Jcm96KzRhMndoOTBnZmpPNERWdGtwT2xG?=
 =?utf-8?B?ZmpxdDhSVDlEbC9id3dpMGdodDZ3bkZNYWgvZDhsT2xtSGpOaXl3ME5ueWU1?=
 =?utf-8?B?TjdTcUMwdFpUaU54MTRJK2F0TklpK2x2dWt0N25LandYbTVKZXJLQVRqZWJx?=
 =?utf-8?B?OG9oNEZkU2FUaDR3SGZyUmZzTW5WempWZkx4VE1tZ1ROcDB1aDFmUDlPdC95?=
 =?utf-8?B?dmdlRFNJRUh2ZXUrWkVwNnY1Q2VoWis5UThkTkI1L3BWV1I5VnBHeHNDVzVQ?=
 =?utf-8?B?UGRtejBRbWM2dndNdWpneG1sOWhtd1dhWVpKQVVGREJJZ1YxTVdvRys0ZTRk?=
 =?utf-8?B?SEdlaE1ySi9qU3g3NVBaNXhEdks1NlZaMDZUTjd5aWQ1ZWRYVjhGZU1JSDlz?=
 =?utf-8?B?KzRqc292RTlJV0htcDNpM01KK1ArcmljTnNSeEszbG1VMjl6Tk5GWHVwY0NV?=
 =?utf-8?B?MTVBQmtqenQ0UGlqdWgxcDZsRDVrYzU2Z3JwSzBwOVBmVlNjUUdidGFxRjJ0?=
 =?utf-8?B?TnZ1QTlRWWFSQTdoeFN0bjV4MDU4dDg5ZURSTElQYVE5VitOMGJtWWNWb3Aw?=
 =?utf-8?B?OE1Oc0xiRUxhOXZOSENYbld4aVR1UEZ6WXJ5MFFTMDljYmluUGthVllYMHRi?=
 =?utf-8?B?am4yL1ltRm5nL2prWWNKWHNIZUdPMnBqTW0vaXpFTTNETm9ib1JDbGdtRlI0?=
 =?utf-8?B?M09vUXJ0eURIQVBMam1TRk1jMEdSa092UXB1bGNhUjF4VHVLanZRcEJiUE8z?=
 =?utf-8?B?MHh2elRyekR2ODI0aU1MMEQ2UDBXT05CNEVXVVVaSkh0OWliUTQyUUZDMDNF?=
 =?utf-8?B?eVhWRi9FU2NrdGx3ZytLakpFTXZXUFkydHRpR3ozdmFlVUVBQzBReUlCc204?=
 =?utf-8?B?MWRmKzVLU2g5SEx3R0NkazUzcWJIL2diRzcwTmtDWHVhcEIwM25Ja1E4S1p0?=
 =?utf-8?B?MHRML1FIREFweDcwM2YvaWZmUy84ODV5UmNnTlJ6UUpScUxaVG0rdHJaUXNa?=
 =?utf-8?B?Uy81TytCeDgrVUViUnYveng4bnhSZXVnU2J4WGJxT1gwcWtZbVVBL0daOC9J?=
 =?utf-8?B?OHR6OHJwc3hDNTU1SXBNSmhBbmhaOXlod2lrMzdmTVUxb3l2UlFKdzRaQUVk?=
 =?utf-8?B?ZTRYc2dpYmtkSGRTenFBQ1R5L0p6Tjk0OVpObjRkTENGcjN4RFB3ajdVZDMr?=
 =?utf-8?B?dWU1cm9vb0JjR2ZuUjZTRkV4c1hBKzJUZklVTkMzTGgrbzJTYWpKYmRyalhk?=
 =?utf-8?B?SjNaOUpJMURwK2ErcndOQXBWVTNJUmVwV3pubWJreFErMmxSck5TcEw1VElL?=
 =?utf-8?B?Yk0rS1hPZ1IrTHJWM2JJd0p4K1p5VHFxQ3RyV2dabWE4eE4rdnZQMzJaMDhu?=
 =?utf-8?B?S3BhQzR1ckxkME9RR3doWG5kbXFhOFdRRnQvQk96RlBjTG1pZk1CZ0NIZW5G?=
 =?utf-8?B?d3lhT0MxdzF0cldJNHUwdWZsOTNlUHFqeEJaNVlwcUd6YWJJc0FoUDR6YTZw?=
 =?utf-8?B?R08zSXU3REN6aDVRbk5TVTNkUjVXMlF5cTQ3NDQ0SGJpazBmWC9qTGdxK1VC?=
 =?utf-8?B?R2JObyt0VUpOMHE5WS84Y3d5bXNvTDJYQnFCbS9LcjROaGFTYVlubCtnR0sr?=
 =?utf-8?B?amZWZ0JSSkE3ZlFZSkdMalVtbk1RTDNzQ1JaZUVPNGd1Zkxwc0lxakp1cnp6?=
 =?utf-8?B?WXVtZFdtWldIVjdOTnpONjVWVUlWdlJmMzEwbm8xZ2l5RmdqUWJUUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa4ea65-d661-4091-e673-08defc679738
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 13:58:18.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG4m2ia0vQtFEYxvpdN/hKzrOrOJFThqVJvmTuVEoXqOdSQ7z593QdvCi1ZirVrI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786

On 8/17/2026 4:22 PM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no optional IRQ is available, while other errors should be propagated.
> 
> Propagate all error codes returned by platform_get_irq_optional() other
> than -ENXIO.
> 
> Another call to platform_get_irq_optional() in the same function already
> handles the return value this way. Apply the same error handling to this
> call site for consistency.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> ---
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index fcf517069d16..f92951422b2e 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2972,6 +2972,8 @@ static int axienet_probe(struct platform_device *pdev)
>   			dev_err(&pdev->dev, "could not determine irqs\n");
>   			return -ENOMEM;
>   		}
> +		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
> +			return lp->eth_irq;
>   
>   		/* Reset core now that clocks are enabled, prior to accessing MDIO */
>   		ret = __axienet_device_reset(lp);

