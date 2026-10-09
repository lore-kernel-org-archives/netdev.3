Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021104.outbound.protection.outlook.com [52.101.76.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291D3D6CB4;
	Fri,  9 Oct 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556455; cv=fail; b=kemS9yMiH+FlzEILdeQvNc3oy93PYurLCSvRDv/ROW+pqLrSqXl+jYdWQhgc/ifY2BDM+Zt7PSGyGekzNjL+KqzAhm8RVXX21n8cUGAq79Nc2wtat33Hv2XmaUJKmGfJKzqHgY9ymHTa1yvcvm5zz+WRv9HtmFkt5QrQQfrbUDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556455; c=relaxed/simple;
	bh=LmNW0+ZQZqQcSQIkx4M4kueA6LW24mUG84S66KHsRDs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iPyF9zSwpRXwpvGuUUn4FDZnhwWhzKHXghgPQr1hlA+5MenPrFDZjVefAWPvNTwF/FZACuieJjklZ5diWJp5w0DlI2LLY1aYU08AUDyoHpEaN7t0/xa/3FVexWLfnFfXi50ei+QZsNVNhLTCRoacYoL0Vqjc7Y3f6DSPi/7mNdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=S2IvkVhY; arc=fail smtp.client-ip=52.101.76.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="S2IvkVhY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaIZnE5+Y3Ou0Wbfo/BIgH/idEZy2hP5FRK3ihEexGb/1mB2o8l+enSfBfUjvajz8RqJqEIimEpgvlfht/x8hADlgeZW89NSNLS0lW3squUqFsJZt9YBxm5c3rzKTwDpKI3g+VIc6C4ONKrcALQA6Vwm9m/ovDNrZ+9bUcnnsjr3FpZl9JJeN00ThXdU+pJMTJbs72oKg0BLU4SXEpPzfFyrYbjhonapfkqu0HWOwkPoFhZ1rNiH8C3q01JBZ3hPshHV8k1dKQuhLWca7fG9LBs4I8UIZDCGPRHExWycDIskkskOQ/I4sdGxTdFfINJv4VtSw1HMax12eMVbiD6Scg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxXIHSrqfE6CiZX2bEXtgwU/DYz/0uo5yKagxGjnW5c=;
 b=NEXFw52R5U24jW2HfHZ+mvED6HT7qgnyH5Dw7gYBBiXXwT5KNW6WvYYiQiAUMC0j5Ri+Sg3intK+UukLjAB5CdD5CiMef5ayXSivAJKn3/txCvco5XHAYnJ1MDg4ZwO7oiU4fx769AjJjU4hE/kLkltr8DS7xjWlpaiYK7ks+R3ft+jEKyqM8a5a6e3xtNEJUFejD7jZFggoxRQRpqX4g8EdWUuzciOXXn8KCXjyDsUWZ4jeLdEfTC/0eoVHgXuHScOsX37jO80k2S1Aq9GXDJqUsgsNsN+YIYdYMnvHYcJifYfhOzb3RHulrzFt4KzvhrwXwXQG7XL/chCydNvC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxXIHSrqfE6CiZX2bEXtgwU/DYz/0uo5yKagxGjnW5c=;
 b=S2IvkVhYpjaXanPxjMJY0kR4vyNd+bKqwRHM7q7+pANUWJBLAjfphWQbbH5Bt8AcRBsp9D3rtlnr58NLbdE22/4QCcUm7wILgO0zMnXVmL6YbiZsg878kyvR25fCN/TXVSbLfMO0hAq6xKZ3LxV531LFdm7BWil7TQEe6sZCUurmvSpqzxODdmo7gqf9KbNQqW4m7MJ/FXgEUd0aGfwQRpjPllzoY2TmQA0/EUO3dsHBRcTfD9mwEPJsuAMPO81USp11dwXHSONWlu2ZPiLZI7TrRPl6TZflSbOpIv5LyOo8id7yKwsom3epQ/jezTr2ghcf5Ve/YTXhSxDgB8zlBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GV3P280MB1062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:34:09 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 14:34:09 +0000
Message-ID: <ecd652d4-ac0a-48c1-84d3-ac57e73146a2@gaisler.com>
Date: Fri, 9 Oct 2026 16:34:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 08/10] net: ethernet: aeroflex: move setting of netops
 to fix crash
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, linux-kernel@vger.kernel.org
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-9-mmyangfl@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20261008022656.3592191-9-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0099.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3d::8) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GV3P280MB1062:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d151cd-adca-42e1-ad54-08df26126118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	o9OJW7SGHaxeSQo/EbJSEZY5b/qC5OqiMmCZu2+nIcEV/ldYRrNVcX9+HpugDwP1Y3XCT+8ysmNVCv6FV+QOtN+EM6erob/bE7TI9In/BXYP0QyHAexAiotIigmB1n9cHIEDHWDJ4YM1hzgCdCi7ef0A1jhw9//thY9l21Uyva/nCFXHbSJozGriEsEmSslPIiSVmgNoL1oEUtgSLM1Nd7238yMJUooUm1Yvi0dr8NJ/HwDUiCfFGmmbsjZT8I1uJERDp9qLi+UnhjsMHXTMaFjlt9+sFpiQww8ZD7ln+UYynyHWGtdJLp/6nWASFR63wx+K3A2kHLFVYjA08m9dJKLTkqQlWJOP4mi9l+PVNzZYU8U5vcmNBejtQXEhiuP7jEr30IZglzXE7JQlWk5N/ghbW9Vrv/mJ6Tfo9yAt+/vtZ2yhrDZZ9Gg14jdaOQ7ZW5V8KcHwJn2h6xKFB/kXt/5v89RUVDIXQdWGj7UIzTDajm+UveGPA6itfTBCwna0qWubAnXvN5UnWyI9cSSgPUhzD7udFRFAkk/9P/gDLa7VVtxyQhEhIoGz6528OAHjV//5XnvHjYm3kA+gH4PsFOBh/xSAV+scbg8WXgNXEqIF+x/DT2+bc1m6o54QgDyS4AID4ppXptC5IDOMLeVaEvIWPpKCJAeyI+AbHENZ9ag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkptSG9UcE95dkx3WTZnWnZWS2hyd0p2U0VJbDdqN01GY3VLT3MzWGtzZkhI?=
 =?utf-8?B?MVVpZ1NUVld2cS9hM1YxYkJ1MksyUVdtUlp0NjJQNUxVTXZXR0x5VEkrQ1Q3?=
 =?utf-8?B?dnk5dU5lTGMwVnoyb29xZENieXo0cWxrWlVqV3JESjJZNFYzUEtyOCtHTmVt?=
 =?utf-8?B?VWJlNnY3UkNtN1IvOTRMYUpINWZ4dmpQUFB3OE9xcWtxSDduNEh6eFZ0ZDZa?=
 =?utf-8?B?cWJxMjZvTTRYM0JRT3Bnc0ZXdDNyMGV6Mm5MZ1JlTHByd3lqc2grU0VEUm83?=
 =?utf-8?B?MXRES1R0dTNOM1IzSldpS2Z6Tld5Q2x4cUd2MjRJZkxOa1RqbFBGYzBBZUJH?=
 =?utf-8?B?dTFDYzhyZjlEYUxzd09CWG5hZ29tRytqeklMZ3V2SGNGMEtrUWc2ZlJGT2k2?=
 =?utf-8?B?VHc1cmpaaWdHU3VQa0drNXJsVk1mU3B4M3VHSE1Jd1dZeVZKd2JKZjBhWWJp?=
 =?utf-8?B?Rmh6TjBzMnRTZ0NBNjVLdCsyL3NFREZNanU2ZVNGZzZncksvN3FLWmdrZlJu?=
 =?utf-8?B?N3NKVFNYSk94YWRYWE9RKzd1dVA0VDlZcURQQ2lXZVp6bXl5WkEwWW5TS0M0?=
 =?utf-8?B?ays4cml2ZVNEb29NeUU1WG9UL0hqRkJTRkJ0T08wbVppVldFajZ3OHhYYlVX?=
 =?utf-8?B?VzdDZll6MWMwMldRWkpEZFEyWlVLalV4VGYvRkY2OXp6andoMUlmOHFMdHg3?=
 =?utf-8?B?SWFvZ1JPVjRyN1Q2ZDdiNmFIVGFzaFE0SFpnYk1YVkxWbFFnZTk4RlRZZlNk?=
 =?utf-8?B?aCtTMC83U0lFZFVEaUxNSjRFa2pNemk2b2lYM01yNUFJcXk1OCtrWFRkSnpX?=
 =?utf-8?B?aHJyK2Q5eVpkdGJjY1Btcko3clVsVUZrMkJ3T2wxNGo5WFBSNGFZdDNOYkRS?=
 =?utf-8?B?V2d3YXM3RjZqcGdWNGlqbE9MOVY5UHRjQXQ0N0VuU3RZbVo2NURPZXU0dE81?=
 =?utf-8?B?alhTN1A3TzhZMnZ4UXZTaHdhVnl6ZXhzekgxWExtaU9Ib3hBSi9mZ0lXbVRB?=
 =?utf-8?B?TmRIVmYwSTM0RFFFcDc3OHduaXBrOHZUNDQ3ZHluN0RSdzlQUjA4aWtzbUFV?=
 =?utf-8?B?MnpQbjdDMHcwZU9ZRDh2MVlaVFFBM3M5TnJnSTlCVXRJUVpoazZNakI3bUwv?=
 =?utf-8?B?djBZUlc1cjlkclVrMzhrejMyZFgxTklWbVU5eVRDZjkxUi92MVlLOGx2a3hZ?=
 =?utf-8?B?eFFtbEFBbDZDK3luTmtJZkdEakxEOHFJYmpIV2xCOFgvZXA4dHFmTi9xQ0Rj?=
 =?utf-8?B?SlpJNXEwMzk0aUxOTjlIcTJ5c3RwamVXNVFkeSsyRFRBV2pvdTJzWEJYNHVa?=
 =?utf-8?B?YmNUakJOZUFydGhJTUVSUkFQUGdSMmxKaHVCRHdhRlU5SVE1ODdNOHZEUGJz?=
 =?utf-8?B?c1hkNkpqTDFubjB5ZGpjbXROMnFmTVdQUHZFQmhOcGxhTnM2L003eXNqMGR0?=
 =?utf-8?B?NDB1MHJJQWkzNkN0RlJXZ21LMC9YMm9iVzlFa1RnUnROblJOU2M1d3IyUzE1?=
 =?utf-8?B?Y0s3WUtTUkE1bE9haW1UK0lqeTRCdWdjMXZ1VjBMMllvRzMzb09SU09pcllh?=
 =?utf-8?B?SjMwZXZNRWFFR1JsbXVLeFRtTTJ0RlRPeGFTWDFjRG5OL2FlanBhQVBrUHNy?=
 =?utf-8?B?UDd2MVdDZ3M1d0hHTk9MOXg0N0thWTdOMms0WDNNampPdnBTVmtNMDI0Y1NQ?=
 =?utf-8?B?R3BGVjU4aGxQa0swZ2xpU3J0MzZpV3k3eGhHN3hpckVaYTg1ZUY0a2lDdVlS?=
 =?utf-8?B?Nzl1SDdzaFB6aDVXYWVXTVhiQnpLdFYxTUlDTk1OZ2xGd2JINzBwbDVUYnF6?=
 =?utf-8?B?b0dTUHRvT0RRaXdLSXR6QmIwR1FGeGRnZksyK3pONnRyNWJjRFJpYzhRZ2N4?=
 =?utf-8?B?UG90dnB3b1gwMGFUY3RTeW0zU05WTllEZ29lMDNka0UzV3l4RkEwSmZGY09U?=
 =?utf-8?B?dng1RE5TaEtmOGxOcG1jckRqaGFITU9HVlVQZ3hOT1I0b1hpNisrdmYxTS9I?=
 =?utf-8?B?SkVLK21nSGcxby9XaVh4bkJjYURwM1RMMGhLb2tidUM1dWhtM0E5d1pQNXpq?=
 =?utf-8?B?NFdnR05OekRHaWVMblpTMkJsOExwSUV1N3MrT2ZwYWFmMW5qNER3SzROU3Nj?=
 =?utf-8?B?bHQ3VnIrQXZESFBPZDNYb3VnRjdsZlpMMDhDell1TnVPczRqdGtMRHRDUldn?=
 =?utf-8?B?bW1ZOFROU3ZvUTM5SGdZSFdNNmx6NStzd0JSVnVpUWg0WWlRWWlxdW55cTFz?=
 =?utf-8?B?K1JNRDF4Z0tpbUM2U0tPbGhJWUxHQzVQWEZYNDBuQWZySUJYQkRoSmQxTGpn?=
 =?utf-8?B?c0tTeXBGZ1BHRndYckVtcFhIc0FqUjMrcmRjVis5aG5kVitaNW1TcFVPb0Ri?=
 =?utf-8?Q?uVmMNWk5S3VVK6l0=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d151cd-adca-42e1-ad54-08df26126118
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:34:09.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcbXpH/wdLLd7bVFkbohb+fhOUKBRSOwem+l2kHifNwD5qXTyEVtRh/bNtIfI34wmA8BAwCAWYOcmeVncWE4CH0pLu9lJWxphtxNf7JB3xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB1062

On 2026-10-08 04:26, David Yang wrote:
> greth_of_probe() calls greth_mdio_init(), which connects the PHY,
> before dev->netdev_ops is assigned. phy_attach_direct() ->
> phy_link_topo_add_phy() reads dev->netdev_ops through
> netdev_need_ops_lock() since the commit in question, so probing crashes
> with a NULL pointer dereference when CONFIG_NET_SHAPER is enabled.
> 
> Assign netdev_ops before the PHY attach, as was done for emac in commit
> 7c9f391ec89c ("net: emac: move setting of netops to fix crash").
> 
> Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/ethernet/aeroflex/greth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
> index a593adc16c78..fccb67beebee 100644
> --- a/drivers/net/ethernet/aeroflex/greth.c
> +++ b/drivers/net/ethernet/aeroflex/greth.c
> @@ -1421,6 +1421,8 @@ static int greth_of_probe(struct platform_device *ofdev)
>  	/* Check if MAC can handle MDIO interrupts */
>  	greth->mdio_int_en = (tmp >> 26) & 1;
>  
> +	dev->netdev_ops = &greth_netdev_ops;
> +
>  	err = greth_mdio_init(greth);
>  	if (err) {
>  		if (netif_msg_probe(greth))
> @@ -1498,7 +1500,6 @@ static int greth_of_probe(struct platform_device *ofdev)
>  		dev->flags &= ~IFF_MULTICAST;
>  	}
>  
> -	dev->netdev_ops = &greth_netdev_ops;
>  	dev->ethtool_ops = &greth_ethtool_ops;
>  
>  	err = register_netdev(dev);

Acked-by: Andreas Larsson <andreas@gaisler.com>

Thanks,
Andreas

