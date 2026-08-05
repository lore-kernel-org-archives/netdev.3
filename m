Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022095.outbound.protection.outlook.com [40.93.195.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1738C2A7
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785960878; cv=fail; b=Lbynh/pjQbdCQ4R8Rytfbxc+IyB6yPLzoUSuTEJHowq9NNqEMth0Aq3cZTIpTNVckw3A99xHi9wZwu7Hv57voLH/hV8z/gUTnGrzJw7tVX1ioXH/Wuyi3j9mqnsgAvOPyUBunFShTHwxfinE7JtvS4Q1LoOE3yv0HoN8UZlcR+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785960878; c=relaxed/simple;
	bh=08HOWyidukn9EF1Kw/67fhgtubPKzJ5aNHKybqlnU/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RfKDJcI/d6SHUO1UrsFm2PtL0ZeJTQaRqwoehLtDf3EhCI1+cgEteTKH7t/uu7kL1DCP/5FinfidmVXLjAmVfJmvC1HruIsvhIyQq2SvA/t4MIHRe3xnRdwxZApBxoymjHvfLkAJpj0JwQzCseLKh2ftp7Zr+9Av093SEoKljoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=jO7IW/Dc; arc=fail smtp.client-ip=40.93.195.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="jO7IW/Dc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ym3rQzJd8ngX8G6gu39BNOZPpCfYpLXjkdlkcgBZ0CA9Vx6DP/caj4Qf639zfd0ygO1M4nSJDcBSlCPY8s8xI+JqITIwWM/5ZMApmSkzDsEDTffqpIBeV5K9XBmHw84MRlIJEU8dOXQcD8u+/sTiib6htNZY5Gy04Heh27eiuSF9oneh/o+cjilppml58OF82+JlXxaXzXcHgGpAasJH7JmyOKAQL8iszXezJB6sJl1JBOIO2VTzBTtPzZ9tksjSJzIPWQUtR6REPe+gPQguy6Hgn9uaZGcS+XI3mZLM7K1NBmNOJvzGaWXaG14IgmAscbzl//4Br71GPRHxEoBolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/nyiXavUWeVmoacKVopmxxYE0/xaNqroE54kjphmS8=;
 b=vw4myzLAm9e4ymHWLSipS1R5tYdNKKC3+/eEHj0UeICXxRS+3PvrketIW3mgFkPdOfrq4sXV/6mkFsC/GOozgcvuwRVZPtlHSxzIWEM/4hcDpoCPUXH6IDwChYLI6PtRwurMEfRJqxsYjSOT2TPm+bcfyf+nv8Bht5ykWK0i9bmFuDjsVh/MEpemvGnFOzvLenAW52mKTI3SnwrnPy8Yq7saNLZd1KJJxy7xn7twkm5Lbhla8pMDXJ77b9B6qJHu1Mu47XcAZiMqzG2jQbKuYVnGjGAgKkhe0sDKBgIIzeuupcHIqrutOfQ1gqlLC/zJ0LLxwPFdt4MY9aGbZq17Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/nyiXavUWeVmoacKVopmxxYE0/xaNqroE54kjphmS8=;
 b=jO7IW/DcgXRh6TWeSIzYsijxD8WY4A7FBZP0P4yQvGEsHGaUK+98DWAzVJx+9qR5wTIyVRtXTwPV2BACa9YaOdUvwM+vUOJ7GY3TLnaO2IKjG/syvnS6q+JpTxzZHa/x17n47/ivYLvIZ5j4+E27n/4ugwyWLQ7KieOslaUJKCB/mJ/N+68/lPLhKHm6Zh2jx/Mvdsc0XRezqOFcQ1buF0A3co3zVpAgsJlJHKQPYKEuFuNtZ5nkXRH7yIzdR51rrrz94AkB5pP5nBUX3Np//DUSMbdyYRRIWChmzlqbGV1enecAbS4ckKLs8/dPE7MCILXlCgTT3Cxr0hk6mvdXEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 20:14:32 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 20:14:32 +0000
Message-ID: <22771a4e-d678-4269-8782-761c4a10a53c@pa.msu.edu>
Date: Wed, 5 Aug 2026 16:14:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: macb: Poll for link state changes
 when using the internal PCS.
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org
Cc: conor.dooley@microchip.com, charles.perry@microchip.com, andrew@lunn.ch
References: <20260729192748.6928-1-nwhitehorn@pa.msu.edu>
 <20260729192748.6928-2-nwhitehorn@pa.msu.edu>
 <DKH9MEANKO19.1B5B9Y1V1YEXY@bootlin.com>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
In-Reply-To: <DKH9MEANKO19.1B5B9Y1V1YEXY@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::18) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d88956a-ae7f-493a-cffc-08def32e2979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|23010399003|376014|10070799003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YGMMNLSIUtRa9gP4mjmBMWQitYB5o0YdgDNvoOEOhr2dJe9agfacexZ2xs+l5gTWqr64GgRGtZbzcse9nIhHfh7SkbN0LOo5KQnptIJ27AC1iy6ljApwRTApYcg/KKzK88pFNs/76c4xywT4pXeK9GVaURpJxUUyqmjukp2L93OMKHcNLQuULUYYAOUV1O8RA6wDsXAS/pTkJYeUhDflGr0oaQ41FMOGIdnlEUlrl+OcxNxJ9zjKrC7yAVqRItWrYE5HtYWN190mwBrEgZHXKztpnNVROr+FWSeiiKjz84S85FlbYBl85Wp5kSvfCJ4C1knPbbRY00DpN8ST146AyRqOuYfhiCZukXcQH0x8JyysvZ4ObvqNgrpy2lqb8WLF9P8b1anpwa0VkY+dYwdxSHCQAlpdeS59h5pjyTEJ8N6cPuzARyPGQEFEm30SKghJV0IvpctXoZUQ0Mz+DTBT8P9ptWwfOlf16d+O+SclE3tBfGopVg95oMqJ6//6JxNoDENJB/o0erKwOKIwQ4k1lj47XWXh5rb3SUC3cVtTs2c3lfrpD9EdYGT78WntNNnqglw3TOIoaYn4cVY29heDR41LXN8LBASCAC/ColzqrD4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(23010399003)(376014)(10070799003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHA1cXliUDFtVEJNajhEMU1GakNYWmZ0VVpLMndob1B2SWY2am1rVWJnRlpG?=
 =?utf-8?B?YncxWlVTbWRoVlZMS1U2RnRoS2N0ZW5tSXRwSFdENUdWZndjK0lhekI4aUxi?=
 =?utf-8?B?RUlKQmd0cjBXOE1iakVrcTdSQzRVaXczNld1UWtFdllVcEdqYjA1TmlDOHk0?=
 =?utf-8?B?ck50RnBzTk5MWk01RThEVG9RbzhzdTJyZDhxaDJWeXdNdXllZkxQNkhiMWZ3?=
 =?utf-8?B?eXBkV3J1ckJ6OHZGemF2czBkTlJ6R1RjZml4SGZjVGxQRnljdGs5bytlNUhK?=
 =?utf-8?B?MXVqU3h3TUNvbWJkVW8vdGVSSndUditNejJ5OUV3L3hlRVJNdW4rc0s5TEcw?=
 =?utf-8?B?b3l5TXNkcjljbkRIVlBRVXIvQXc4YkNIZjR3dXAzaWtVbnV4OExBL0txL2gy?=
 =?utf-8?B?blJ3Z0VyekhYTysrOXpiYldBMTlnemwxdEFNUE9iay9UL3hseWwzRWlQT1Fp?=
 =?utf-8?B?NEx5bDVXZ3FpWkxCaTJxVzlpT05KWmRmSHVBVE0zdnNKVzVVR2MyalJMa2R5?=
 =?utf-8?B?S2JiU1VEbzdtR01GcVVhNFltdC8waUFRV1h5bDRZR2o2YzBieUZ2ZmU2NnIz?=
 =?utf-8?B?aDhaTVNMU1dIVmlycFFQMU5SaEZ3VngzSlRrcGFBSW9kbVBNUGV6d0IrQUE0?=
 =?utf-8?B?RWdzME5qTmd0aW1PRWcvbmUveDMvbFd2YXpnclhWQkt2VG15cXRNamxUR3ov?=
 =?utf-8?B?aGx6MkpNTmFNMTF5KzJqdHhka0hhUHppc0VqakdXUjBhWG54NHNGVWFnTVU5?=
 =?utf-8?B?Y29KNjZWNU9PVCtKVlFFVE15dUpXcFZEUmJKeTIrWExvZnVlRVJvOERWZ0xH?=
 =?utf-8?B?Zkw0SEUzY1N2RXVvazBlRnlvanhLS0djZnpTQXpWUFAvLytIWENETFVUWTZr?=
 =?utf-8?B?dkZhNUl1R3EyZStrSjZVZFlsTHJZc1dERWFpYVZ4Qm1RdnhoL0tRQk5nWFF4?=
 =?utf-8?B?OFZBZ3VvNW1iRzdMcUZWeU9PVVpReThESlBxSnovK08wOXhocHZlQ1BEZ2Uw?=
 =?utf-8?B?bWMvRlpQRW91NlZUZ1Q1THN0RmVmL0xjR2hiSmNEY3R6Ym4vZk5vL2VhREdK?=
 =?utf-8?B?cytGcS9rYzR5ZVBuWTU4WC9sWHg1UXNoK1BZVzk1V3ZlaWsrMXphSHVoMUV0?=
 =?utf-8?B?bmVJUE9aTjlQNlduS0NtcWhIdWZRaS8wb2RjaElHK1dCL09NRXRwVldWR096?=
 =?utf-8?B?QWNEUXgzcUJYWHB0Mjh5N0MrWnlaQm1wbDk5akk0UmwzVmM1TXhGbm9jY0U1?=
 =?utf-8?B?anowTzlRUG5VajZDZzU0cmFzYk9INUdSZENyaXBidE4yYXkzeWYrbkQrdkxw?=
 =?utf-8?B?L0xCMnNYTG8ya09tK0xBb3ErQnd6bDg4T0pGUjE5WlNpNzI0UWZIMXdLakox?=
 =?utf-8?B?NWFxMzZWdjNlb2pNL2U2NmJtMmhsUENDUHpDVFVGUWY3L0VWdDVqYS84OHJq?=
 =?utf-8?B?MzVPRlVzcXZiSk8wa0J4eFVIRzBzc25vM2t0NHdNd2NOZjhmZnRqMTdPME9Y?=
 =?utf-8?B?TnA1bmV3SEpacmdkUVBHSkpHVVErWDM4enZVTHpMQTFDTHY3Nm5oc0daUUZX?=
 =?utf-8?B?cnJWaWx4aFRoWk45NFdNd1hPL1JEU0kyTDMydGRLM05VbDBGSEpFejQyNGwv?=
 =?utf-8?B?cVZGQVZKZEpBZU9ZcFNKdHFEMDdZaWFVemxUbjcxYXRsb1RzVVF5TjJySWVv?=
 =?utf-8?B?NDZhTnJER2VsUmQxRzFKQVkybExtUVEyQ054NHVXd1BxWlpJT29TM00rd1pv?=
 =?utf-8?B?YVFJNTJ2Zldob2k1RFdya2MrQUEwT2dWdlFqcExtMUlCMXpXVXdjODNLeS92?=
 =?utf-8?B?OUJZZWhETDBZYmlXM3VKZC90RUZIM0ViclFGZkY1Rm10YlAxcEVqRTVuejhO?=
 =?utf-8?B?RWpUdW9SSjU4ZldLYmp5bGRnUklWZ3loN1lZa0VIaVJYZFFGU0hQMEFXNXV5?=
 =?utf-8?B?R2Z1bDc0ZjRLL3lyMW0rM3VhcVc2d3ZPdXdubm9PNStaUkp1LzVFNWhTVmZn?=
 =?utf-8?B?MmNZTE9KNTJFTEYyOVY3T0tWVVdYaTZZVStwcTIvbWFMWUEzemdPb1RhSmJy?=
 =?utf-8?B?SThNNUtwN3l1MlppVnlnSks4MmIzRjNBVUp6Rm1HRzFQWWRKd0RYZ1pnRVV2?=
 =?utf-8?B?WVl6THF1U0xjR1dmaWoxa01SL3RpWEd0RkYwd0NXWE9IVGdsOEdITVExVmZj?=
 =?utf-8?B?NWtLMStQMHpCV3VkMHdsd3g3OElqMllBU1BtSERVWTEvSm15QWZZUkg3bTR4?=
 =?utf-8?B?Qlg2azJUdjQyQndWem1aSzNYSXlSNHZGdmhhS0FibTlDK21nZGs5dE11UnYy?=
 =?utf-8?B?d1orSzB4TnRSN0NzOWNHaTljNWkrNmNZaVYxVlhWYVdVU2dJS0ljUT09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d88956a-ae7f-493a-cffc-08def32e2979
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 20:14:32.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRCdKT8mLejHzJvDM3fQj5CSb/DoYHnFNhL9ZdXtzzBfF+dN4cLilMv5YyWJOwpn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255



On 8/5/26 15:43, Théo Lebrun wrote:
> Hello Nathan,
>
> On Wed Jul 29, 2026 at 9:21 PM CEST, Nathan Whitehorn wrote:
>> When used with an offboard transceiver (e.g. an SFP), link state needs
>> to be measured at the PCS rather than an onboard PHY. Poll the link
>> state when the PCS is active to allow the kernel to detect link state
>> changes in this case.
>>
>> Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
>> ---
>>   drivers/net/ethernet/cadence/macb_main.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index d394f1f43b68..c15a9c7e69d3 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1025,6 +1025,7 @@ static int macb_mii_probe(struct net_device *dev)
>>   	struct macb *bp = netdev_priv(dev);
>>   
>>   	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
>> +	bp->phylink_sgmii_pcs.poll = true;
>>   	bp->phylink_usx_pcs.ops = &macb_phylink_usx_pcs_ops;
>>   
>>   	bp->phylink_config.dev = &dev->dev;
> Hardware has an IRQ for that, would you want to use it instead of
> polling? The user guide contains more info.
>
>     /* Bitfields in ISR/IER/IDR/IMR */
>     ...
>     #define MACB_ISR_LINK_OFFSET  9 /* Enable link change interrupt */
>     #define MACB_ISR_LINK_SIZE 1
>     ...
>
> I've checked with an on-board SGMII PHY and I get an IRQ once unmasked.
>
> If you don't care, then:
>
> Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>

Thanks, that's really good to know! I will look into it. For right now, 
though, if it is all right, I think I would prefer to keep this as-is 
and come back with a later patch that switches this to use the 
interrupt, just to get the base functionality into the tree.
-Nathan

>
> Regards,
>
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


