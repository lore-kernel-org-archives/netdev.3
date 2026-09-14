Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020136.outbound.protection.outlook.com [52.101.189.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A8F45D1A4;
	Mon, 14 Sep 2026 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403845; cv=fail; b=gbSVcUKaC/VTxhyyyF9ahGQh8WfoymG6X1x8MSYbx21RAvFUw/jQEVn7Nv5XRUxnYjPxGY50lTEgmp2upiXr9QZmmLCwRvzxDRj7INqGWy7BLF4YcTqLLqKXIoH3w8L7pXAOwg1Qz4z1edRD6IHBCl1ZqR/sIMIfL9E9EYhsS30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403845; c=relaxed/simple;
	bh=sCullHi9Nh8Tx9ks2m/y0Zf6U2qHr7OV761jJlOx8tI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=plNklciPKame00/vaWJpywV3RH8NFxFs+/bfEar/Pj0vDglKSlTgjBYqDqKLm3kRJx80yjt2ncQ0Bzumj6asu9JB+QV5LokXrevqOINLdhYa5WbDFORcOgsqVT35B7sv24oPscf8vLzWVg3BFoQNXlLhZ5DymcE0SrBvfc+2pdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reliablecontrols.com; spf=pass smtp.mailfrom=reliablecontrols.com; dkim=pass (2048-bit key) header.d=reliablecontrols.com header.i=@reliablecontrols.com header.b=Mvm3/77/; arc=fail smtp.client-ip=52.101.189.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reliablecontrols.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reliablecontrols.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reliablecontrols.com header.i=@reliablecontrols.com header.b="Mvm3/77/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgzxHPMCpF3M4u85+9OS5SB8Ah0zXef0LiQ9BOekT6+0RvGswzR+sjrZtaqea/7qwo18z2P9kVrck15DiMWrArTbLoeelLmrDKClCLcxWlTg1Z/qsE3y8yvxg/zIdaGfrdKM2Q0THCjx+3nUQEe9LCCyhjPNQLLpe8FedgLoi2OAuC+ZMRi6HTaL/v9P3DOZm4IMRZuiaU8yT5eU5xQN1FdocXDN5azI6CzC3Y4KRvwg3sMq6uvRBq1xwmB83WkSiWIfYizxZs96uQt7xnjNliHqdStWWWtm0ZouIQmtCWTBZyeA1xn5uzMA/T504D2EWkCSOBVeWdmd66mtxbteQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99PApyrQ/77Mptnn+e2AX44bUDu7/UnbJHCKAzLP9K0=;
 b=dd0KLqauNiHjQLJlrj9ovrq89//nURsKACWDBshKyN7Nzgfpuw2yyNY8lRgUWpO/LTJPXNzB4t+YqEY9Loj1sTzmqSY3PZEITkXCVuvqSwcSDpzrPuognvCQ5Tb9N048AsIC8tMbFfiBUonBFGBsCihZEDXMGATOYZkzjF3krZy/Tm72GhuR3X7Hf0LxyrYloNdeh4uauYyL7bA/AFWICko/+pxe12W13npNdA4tRTqHPlh3v5rhDqNl1TYblt95I3nzUpTKCvSXFR5e7nC22CFuix+RmqlmeEszNFUzm3szpZsh5WrXSrl+/u1gOVAjq7nhkiZTIsLA/WvUG22ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reliablecontrols.com; dmarc=pass action=none
 header.from=reliablecontrols.com; dkim=pass header.d=reliablecontrols.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=reliablecontrols.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99PApyrQ/77Mptnn+e2AX44bUDu7/UnbJHCKAzLP9K0=;
 b=Mvm3/77/jYCXdJ1NFtfZAjJ+rE+GP5r+zcJwt4zX7R8kbu1WA6xw5KgLrtSM6o9/ve4IV1pkq/qb5d1kD2DztP7oTUhqXUd9v7e5FlDEtnCDZ1SXIBo4ENPMiGml1CtruwE6hSAdP0yrD3r9ST0n1cImQSPgICBgIUlEwA4vocti3Rjg/NjktVwrlnbqUxrJAaSLtGLR6ke5pXOCwVCPjuiCKLDrBWg3Q5xmtMjNy0/T7TJhl0OiiRBO8mm0RgTllwcv4Bc+24+BX2RT/+CDdijamz+4MdLt0MYM3eEn4LEQZLp+PFkB6kKz7wCrLgeUguznydB8I4AipDvqTr0x1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=reliablecontrols.com;
Received: from YQXPR01MB6544.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:43::16)
 by YQBPR0101MB6587.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 16:37:19 +0000
Received: from YQXPR01MB6544.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7277:8d53:e8ea:1185]) by YQXPR01MB6544.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7277:8d53:e8ea:1185%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 16:37:19 +0000
Message-ID: <3b638508-6c03-47e5-80ef-49b05961c9cb@reliablecontrols.com>
Date: Mon, 14 Sep 2026 09:37:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] net: pcs: rzn1-miic: Verify port number from dtb
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
 <20260902-rzn1-miic-fix-array-v3-2-3f7dccffaf5a@reliablecontrols.com>
 <81869e14-2dff-4bff-b2b4-07185c4e9086@lunn.ch>
Content-Language: en-US
From: Kyle Hendry <khendry@reliablecontrols.com>
In-Reply-To: <81869e14-2dff-4bff-b2b4-07185c4e9086@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0142.namprd04.prod.outlook.com
 (2603:10b6:303:84::27) To YQXPR01MB6544.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:43::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB6544:EE_|YQBPR0101MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: ad144790-6e72-49b0-c2b0-08df127e7185
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ciPiXlVxstKyZAN/64QKJCbP436zYJYFO8i0AeShK5faDh7LfK+h+QflktSMtzhvthQ0VAMrQjqF3FmUnqA3DeWjQu05S9mtJflGrWb7J/Zy0oXY7MBgVuKXP9GVb0KVafO6/Zmu3gwSkpceOS7gUrcu0gyCIL2Yu/V//pRAPR1vr4hF+dE5c19Xwy9ZC4v+6tnoeSf5w6DR0aqjpxVP87ICFaQ5ZU8w2Tz8I11i3ZFOVydbcTIv4VkoRTbiHqd25kg/OSRp5TDn+qZMzg//wBdLGeUWNRp3O4oqH/ji3yRwiWaW6mRGyzlbtln2YBcTz5YN+foi15pjgLtb57WgbIK0grypr3XB0n2RN45n0QJRJrUu0Yb4VWnVWQQAjJtN99Oc3hyVzcxHYSc0t0J+GNNeXIJjnIvTrdveIu6hKna60v14epObWwn8EJMlSUlcd1zTT8kBoDvH1rcdhoWsC1pQ/o251SxKb9ZAlA1NoesROj3tCMh1LEk37DArbMR7p2fdVUP1seg2AuGEeUBMo0gPGsZPnmONlPvOxzoFVtClqNNZKFZTDGhPSYm/a/PKVpWIMdyOaS241MmUKyIZmT0yBXWR6WYgJ/RM7/SeRMGePYU/sl7Nk+j6TuQh9hKcVF74+/WQbetGa+FsecmjyNiN22W/vZiVzU/Wd4Ej3SQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB6544.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(55112099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWFXVU80Q0p5ZktrYUtyMERKWmRkWUI3NzdHOUZZQnFwNmN1bWpxRU52dzBH?=
 =?utf-8?B?RnU4UlZGYkZTUTdYaFFQY1BBR2NEZlJSZVRHSnNvS2JZOHg5MUl5aGtnZEI0?=
 =?utf-8?B?SzdtSmpaQXJhcmNsc29rSG13QUVSSTJvUVRheXEvS2hYTG5nR0tYZHBzOFhv?=
 =?utf-8?B?bW9QTGc4Ym5qWTlRRG5ENmJsTEdXUWZDYjN2bFdrZzliL25uY3RqN2dJdVNt?=
 =?utf-8?B?T0NTSFBxV1VhSk1ZcHltd1NuUHJGNmhTOEtRYWtJSmpaOUdJcXd3OTFHMlN1?=
 =?utf-8?B?NUNOQ3d0dGxsOTVtbTNvM3JaQWVLaldwaFlpSjdDc3NUR0I3M2VlMWVCME1K?=
 =?utf-8?B?UGo3NUdkcGs0aElIOUhaSklFNjl5bkJmaHJUWE5kSjBNMC96V3hiRm43bmIz?=
 =?utf-8?B?cmdiRUkzUVlYNy95azlGcEpZMm8zeXQ1YUU2aE5udThpcmNLRUh2cmlWQzFm?=
 =?utf-8?B?a2x1TkduVEl6SzAzMHZ4cFgxNStGdnV2dWFEYVdWbzFjTWZ5Q3VHRXB2SHEr?=
 =?utf-8?B?VFVvblo5M1hTeDJMS1JKV0xGZW1lcUR5V1k2OWtnTnZtRHlrRlM2cVIzaUVs?=
 =?utf-8?B?d2dERE81VUdCbGRPQ2Z3ZEJ1L2JWNW1JdEp5MnEyRGhZaE9LV05wQ0xhUUEz?=
 =?utf-8?B?UEhSSnJiMnNjUXdtUnNIUm94QWxPRTVGMTZidENOVG92aGZOK0FyVVZxQXVK?=
 =?utf-8?B?aFRZVVFWTHZTcXhOV0N0eXhicmx3UHM5RWIzcENGcTBlbkN1czBNYW9RdFpk?=
 =?utf-8?B?TUhZWThqUXVrbjRvcDZvUForZjd4NVVQQ0V0aXhXNEI3S1ltRjdid0lUUVpX?=
 =?utf-8?B?NGx2YktHZkkzRHdvK0dRV08xa3ZXdFgzd01hV3NtODIxT21qL0IweWFtT2l5?=
 =?utf-8?B?aVpOMU1MTTFoSzVHTjNIMGFXdEJRYUZPY2hJQkZKTGt0aUhId0xhRHdGYkUv?=
 =?utf-8?B?cUNEc3lwNy9xRzBBUHM3KzVLMXUvQU5pT0duQWZNNm4rMUJEWjFESURYdm4w?=
 =?utf-8?B?VEgzNFFpanM3NTVnazlJMkQ0VUk1WFpUWXRMTktSUktnTEFaVWhzVkh0dG1G?=
 =?utf-8?B?eFdRZmxMczNidEVLdmxiY3V5RFg5UUNORmVqZTdXTVVSMGhMekt0YzhwcXpu?=
 =?utf-8?B?REprcnFPZ1FHclF3S2lXTmFtUmhjdTQrL1VndGQyejZRaks0TTlDdkVtdWZr?=
 =?utf-8?B?cXluQ1JJWW5qNjYxMi9EMEdBSWFCMmIvKzBiOVpuVU43TjhTNXMza1RZOG0r?=
 =?utf-8?B?enhXZTNLRVlKZi80OFlhSVBuU0R2blBWeGcvSmF2UEZlVUpYZEVBSlB4dW1r?=
 =?utf-8?B?R0FhTjVyZ21lbEpoOEh1YjdvaXlWYUN1WUZVM1krWTlhRmtic28veHFVaFJT?=
 =?utf-8?B?L0JrbkJpZ1l2MUZBK1dOVERYbDZiUlVCUXBiT3JTbVJQd29BUXdOUE5GV1g0?=
 =?utf-8?B?dW5ZbUJESERzSXY2QUVxcUg4VUQ3ejRHV0JDeDFjcGx6aGkzcnFIV3NzSHFa?=
 =?utf-8?B?cWI5VS8yS3R4QWMxQlVBaWl0b1V3VzBMakdVeWpaeTlxeDF6UFprU1ZsNDFa?=
 =?utf-8?B?OU1ERmJhdzYwR21qNXVmdGdnVnhTRlNyWFBqc3JLckZyQUJ1dzdjMnU0dzVL?=
 =?utf-8?B?NkVjQkViM1UwSnlUZmp5Z3BTTVo3U24wRkhoYzVDSG1YNFZPUStSVFhJR25D?=
 =?utf-8?B?NVdpK0NxRTJkYVdSWTBpeHNZOVJmQ0JyNXB1RUhIVWw0d3g5dUMxUkxRcm4v?=
 =?utf-8?B?R0x6Y1g3WUtZY1Aranh0eDllbkVMN0krZHBwd2RKeHN1V2lWM0VGeEFLcFJa?=
 =?utf-8?B?YVl0QTRxejRDZUVQdGgrb0dkaVJ6c0ZvdlV5bzU3R3JLR2FmakpxOXlxRTdG?=
 =?utf-8?B?SVczTE5KY1VWaXdaek1OTjFzK2hZZlpKYk5hblJqMjAzK0hybXlpRmhkNDZr?=
 =?utf-8?B?akhBODE2ekFxMGRmK2J2OFpMZm1NMFJ3OWJib0VhaGh2UkRPaFl6THNTaSs0?=
 =?utf-8?B?cE8zdG1xN2xWVlYrYWhnY3FlblBjU1ZRS0d5Z1FPNzlrTitaWjVwaUZlSkJJ?=
 =?utf-8?B?ZE9vdUJUbGg4ZmJqT1FlRUkvWDRPSm94bmFDNG0wU04vMFloc3ZwWi9YcWJj?=
 =?utf-8?B?ODByVHllUmZLaWsybld4Q0ZmazBSZFNLbXVWNCtuWXh1V252ZnE5ZEoyS0xY?=
 =?utf-8?B?dHluM0F2UEVwODkwK0NDM3VzTlZld1pSM05nTWNLMVBMSnQzVmVNcE5manFw?=
 =?utf-8?B?TDE3NlpncC9lMUQxWWlVeGNhaHRZR0lqRW5yaHB5aTZYbkZxMktPQnJQYVlX?=
 =?utf-8?B?cGNlZnFGQnhTY0NzMnFROG56TXlEbE9vc1h4emVFUkhyWVlvWExjT0pEdUp0?=
 =?utf-8?Q?V/8Bb6As3keGAgOM=3D?=
X-OriginatorOrg: reliablecontrols.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad144790-6e72-49b0-c2b0-08df127e7185
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB6544.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:37:19.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70dc28cd-aa9f-493c-abf3-5c1ff69c0ddc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6pCZpWIDm98x1+V/5xepmJTlFzeTHs5h5NF/eTszxfbCPPHJnvAp00+sc9srV7uuytXelDnXOmeMG75oi1/kWLNbOH85v931cAXZa2Ncgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6587

On 02-Sep-26 11:50, Andrew Lunn wrote:
> On Wed, Sep 02, 2026 at 11:37:36AM -0700, Kyle Hendry via B4 Relay wrote:
>> From: Kyle Hendry <khendry@reliablecontrols.com>
>>
>> Add check to make sure port number is in range before writing
>> to dt_val array
>>
>> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
>> ---
>>   drivers/net/pcs/pcs-rzn1-miic.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
>> index c50b65d064fa..3ee40eb9d545 100644
>> --- a/drivers/net/pcs/pcs-rzn1-miic.c
>> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
>> @@ -692,6 +692,12 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
>>                if (of_property_read_u32(conv, "reg", &port))
>>                        continue;
>>
>> +             if (port < miic->of_data->miic_port_start || port > miic->of_data->miic_port_max) {
>> +                     dev_err(miic->dev, "Port number out of range: %d\n", port);
>> +                     kfree(dt_val);
>> +                     return -EINVAL;
>> +             }
>> +
> 
> While reviewing this, i noticed:
> 
>                  /* Adjust for 0 based index */
>                  dt_val[port + !miic->of_data->miic_port_start] = conf;
> 
> Is the ! correct?
> 
>          Andrew

Yes, this is correct because dt_val[1] is where the port config entries 
start.

Depending on the SoC, the port numbering might be 0 or 1 based, so this
prevents the input config entry at dt_val[0] from being overwritten. The
logic works out to the same as:

index = port + 1 - miic->of_data->miic_port_start

-Kyle
