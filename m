Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3473B27E7;
	Mon, 10 Aug 2026 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358016; cv=fail; b=tsVyivvgB9Kdn9kaGxpqzfakFwCX97VS0sfhJuzRqGfJusPYmXnE/4MHxIDE/3tKiexJrZNSy2on7SpEgLuj5SyGnQKjyLqMHhAPxQiLHNUnFR/zxdzKzOEH75yPB+renSk3l9pb/RsJFQE9vgm70inwG/YwiUicGbJDuJ7R0gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358016; c=relaxed/simple;
	bh=nsiPpD2WMvdgGZyngEHAtcnT6cnKNym29ujA5rN2rmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dc/MDY8wnQ3wY1UrzPl/7uImlAPuYGuCdxMjEVdVuyUgldX0+2d/oyWHcy1XIHlQbEnSCx4ZFPC2+oKj1q5dIWJp/YMrCmKia14TIDuvcif6pWQDBI1UvDWaK1XQ8QjXBLVfXuZDpYJ0HaCjuW4P56Q3YZI6IlP6SSTiPSBmv5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UwXf8Dys; arc=fail smtp.client-ip=52.101.53.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UwXf8Dys"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8q4Byt3w6HrMOMrbis27TdVa/BMPZ5kH4W4IYoWm1RKay32uAX2XtRrjXlYNpFIZlpTYJepn0SLViqw38CMFYg8wi3JOPGMEnu4e3CfWVesccLOV7FbvaS2eFExxEIX0bhXjPGaLPH0in6JxWKJBTUXNkEcmPoxMkC0dxvVUQ+FpSXFTKj9t8LphwxMAEyE2IbZiaZW6eR2XE9n5Giil7yAcuzyHo2SIW+uTgM2hEADMIS+H0oSjcEhBOyN+ThQwrseNlB1sCtnPraclUAXfsT0+Gztpm8kA6wfn/p++zu98bn1QdgQ30omEZO0Xtn3rJVtAibrM/QqF+368fWhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUbDSzlq4446V46MFqIicw+upjlVpM3WseE/5v6P2mM=;
 b=JcS4uz7lYFaJCsVyFGMkkfKSntWq+rKSjRob3FUXXORU/k3LEbQewsUrXeiW3BQXl0ZyXWaOFtQtEIp9lJbY+QMEXSEJ163ZI4lPqSvgCWjgiOxRMzatIt4JZB7B3K0GjqElWti6ZsZn5lYjxUh/NZ/YUzXJ52WhrEsUYKI+NpH/r2Fo/2ziTk1lp6RPUZhguuCsI/l7oyMgTqTpGkzXynx/UOlHX7T29vAGwusdY+wCFVECh6o1RmvNoeI+Mo+3VnXpWnDVmM8egw2OoQdN2INVApOGhcUgQJCS54y0WbZaovLIYDrEwL5462X9FHbpS6+LRWTZTb0V01FQlfGvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUbDSzlq4446V46MFqIicw+upjlVpM3WseE/5v6P2mM=;
 b=UwXf8DyssGcZR9JsgfMx+pGjrTXO80tSu8Rgg3VRLN67M/kS557ySgR2p5RkaTmJw48UQmxpZq0j43n1+A9Rokp5BNlVUOAz9kbmZ73wfx4C6L0o/tcR9lwRrDmjdxiLrjtLTpTXKNSj3jYLMfsE57vdP0HfSqUZFukjktvNfT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:33:29 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 10:33:28 +0000
Message-ID: <21ee2a8b-4699-436a-8a52-4285853d77c2@amd.com>
Date: Mon, 10 Aug 2026 16:03:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net: macb: Add TSN CBS TC offload support
To: Conor Dooley <conor@kernel.org>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
 <20260807095012.640223-5-vineeth.karumanchi@amd.com>
 <20260807-kissing-liver-2ab4ec49c015@spud>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <20260807-kissing-liver-2ab4ec49c015@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::10) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef3df37-26d2-431f-693b-08def6cad134
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	QWZtfSdRDbbm8TTqdlBJolDSw1/toyeLHNlIA7EelpCh8pmai22yD2wyaFiwHVCMFPPi/0xX7i1/EVlRy0hewd0G8UMdom9D74Y1H3Aw1gTYL3QPFeSeTV4prptv/tulJbluh/MyT1FKEauHb5gYXcvBbPR3MKO9VutQlbsn+8YHJqsyHRKR/ui4EIHZwY+Jjs8Sv70sxK+DHCBhpqzn0Sm7At/H/XqSX4dhgFP7WHzjSozLmo1tKJguT85oZCmtC06kgRBbFTE5ARk6qdfEt2anbwOKTStCFvHJQKJ8gLH6MAukiH9KEGE7F4qm27AUAWvRF3c55/2rTgI5mxgPuPPZBrjecI5BnFJrA/TwJfN8IRULVb+H0Dgb74PWbRKad5IMSP+UzuSn/yVI+/2V9sRKxUMH68ewd/5OXhg5Px4SGD0DIMyCw0Lgu3NVLJhOZtvxz5/QMZYkyFhPNDc4doOlGiEbhWrsjY5FrBUp1amy0y1CTYRuBLhjYmteOYR/ShxQ9xcefc55CIbLgksfn59MT1bEAU6sFDcLE9bRDf5KVpjPZvRqcLsNnMvQdc/XLvPfT8nU8htC4liOKQtD29dyiHajR+qxy3nTF7ttWFMmnE0puOzQnSWXXNwecVdeRn5p4U3x5CLWNM1wNaEyskm6imeCCrFznxZKE37NQL4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmtrZko1cUl2TXNDUFpFSFZ4VEtLRTRkMjFpL1l5L1dMK09ZKzRjdm93ZEc2?=
 =?utf-8?B?QVBId0dzVStGQzdCalFoakwvWVB1MmlHVlNYYnlHdkR5MXZoZkhhWVpDZElt?=
 =?utf-8?B?RHVFUml5dDhjZlhjT2xFRGVCYkZJSnJNMDl3eDhpeUZXWmg3b0gvVEZNQW5D?=
 =?utf-8?B?ZjBNUFBDNVZEdk1rZ2g5TVBjVjBHWktTZlIwUE1KSU82dThPajFvSmlTbzho?=
 =?utf-8?B?RWRkUmRJcEJGMk1HdnpLVnZCNE4wVHF1bVlTWlpCYks1M0xjakt0MithRDJH?=
 =?utf-8?B?aTFIUGh1NGVTRUdOZlp5dGJoU0dOY2ZQdFZoTWtuSENlZTl3UTJhWFMzTkc4?=
 =?utf-8?B?K2JZVTJEQ09ueVFYUTk2bUNMSHpNanVGbmlNS2REcXdITXdPSW9abDVWb2ly?=
 =?utf-8?B?T25waUR0SWt0YnI1Tk1mM2o0TGV6eitxa1BHMjNDSGRaOVZqUnQza1dYZWMy?=
 =?utf-8?B?V0J4ZktxUWNvRUovQU1DeVNFSTkrNWhQU1VRNzYrVWdKU0NsbnNVNHVzd1B1?=
 =?utf-8?B?TzV1N3NlMFpONFF6MGs0eUo2Q0pKWjRUclRNR3E4cklKRmNxR3g4elpJTEMr?=
 =?utf-8?B?S3RmSS9Mb2NIejhaeGo4dUM5OFUwc0E4alRlU3drcnNvZnZxd0pRcFBJVVBN?=
 =?utf-8?B?eWs2WEhKRnlza2Z5Ty9aZGZNM0xEMS9wOXZ2RUtHak15MUhLaFFGTkdXekxY?=
 =?utf-8?B?WEdtM3ZsT29EVHE4ZnZZVVlXTVVIUm41ZlliNU1WWTRQN2ZXcEpOOTloMm5u?=
 =?utf-8?B?b1Z1cER2NmQzL3FmNU9yOXFmSUxQZWt3eTkwbWZ6MTByN0U2aGZmVC9DVk1O?=
 =?utf-8?B?SHpPWU1QWWZjT0JQT254NjlCRjFSWlhIQjJBcWxmK0w2azd6TnlYb1RMdFJv?=
 =?utf-8?B?VGM5enI5bDVRV1BLWnhBWnZ2MjQ0MERjMmJpTmFSdVJTZFR5SFVJd1BmZXFu?=
 =?utf-8?B?NW9DcmxyUnJ2VkRJMzN5MEJNckQ0aldseVlUM1c0RzF2aDVCbVE0cDVGMjEz?=
 =?utf-8?B?UGxtSVg2bnM2VnFUK1Y2UTAyYXpiZ0g0MFM3N1c4eEo5WlRFcXhuU3N3aDVw?=
 =?utf-8?B?cm5ONytySWZ2VWJrNzVNWWdyRzhZTEQyREUzZml0QUFsSmRlbmU2VjhPRlJJ?=
 =?utf-8?B?QnJFVTRTVlQvMEdRWm5oMktVL2pMVm9VSC9YU1ZVWFlnSjIyMTJFRmFNOFd2?=
 =?utf-8?B?WjU2TGFrS2JzMGlyNVlpSFdOTmJzcVRhQjB2KzJrZERRcW91L2lneDBOVUZU?=
 =?utf-8?B?M21HbmVvM0taOHJNdGhIeVhRYUNhZkM1TVNFcW0rRlpsSGl3OVYzUnhVN3Nr?=
 =?utf-8?B?eCt3UWlYNy91ZjhVSlFBbFBwYVFEdEZLNXhaaDhxa0I4eit1ZmkrMWcweUk2?=
 =?utf-8?B?aUhLbTdWdlVWYzRjaFdmSFNZaE9mNGJ6bDdPdkZMYUdKNjRCY3BUTTIvRUF4?=
 =?utf-8?B?djBWZllpY0R3T2lvL3JvUUxSWkViY3JLZHZFUlRjNjUzYXo0bDVOUTBUZ0ZL?=
 =?utf-8?B?RUFrQTZDdnM5YjczR09yUlRScHFBRFJmMlNMSG96ajUxUUR1alNxV0pSM2xC?=
 =?utf-8?B?OHRwUEgwTDNMQmNpektqYnN4OEtwSjVJS0JPenFLQUs2YjNYZUhMcFNyQzY5?=
 =?utf-8?B?VDNrRTM3Y1N2VTBNK2F1UEJmQXFXNUlQN25uZmlBR3FQWGpYQ0ZocmpsVVBv?=
 =?utf-8?B?R0JxYUhYMUxSZUpJd0gzMXNuYUFOWDR2MWNteVZNelIxRCs0ZnFFNTRRNnVm?=
 =?utf-8?B?K1RNWmYzZk84aXMvblJpVzZkL0k5NGJpajBmbHZLYUwyMjNxNHZkMlVyUEpi?=
 =?utf-8?B?NVg0U2swVHNoWi9lT0xPZ3dGdFZXZUVZMG1KM0FGblhwR1FiS1hKRTJRcjJH?=
 =?utf-8?B?SkdGUHB3dXA2NUFjYndibisybGd4OUlJTzhaUEZrVlVJdHpSL1lXdm5mRXZB?=
 =?utf-8?B?WGZKMHdQMCtRZUI5SUJsZWlnYWU5bHN2V2UzdnNET3NJN1R6dXg0akdLTW1u?=
 =?utf-8?B?bFZGY2hwZ0hsVWVweG5IVTNtNjBWaDZLQTloU3R1OE1Bd1IyVDJYVmJJQ2pX?=
 =?utf-8?B?dW9BTXF2TWZiWnlCd1Nadm5LbWVjb0tpenJIVnVoNkxSMUdRcVZDU3gxem5U?=
 =?utf-8?B?YmNoam4zREpENFc3am9KVGpJUnZ5UnpLVVRwcFRhOUJKYUJjb0VzSDZKQ2Iy?=
 =?utf-8?B?bko4OUZRVnZNZFhyZmVOZHR3UGpOenNFQlNLL0trUEtEOXpXSW5oUnI3TWg3?=
 =?utf-8?B?ZktWb2hRU0x6bmgvT280elcvd0ZEaVUvTFppWmFtSWJKVnBhWnlVUkhXbjNG?=
 =?utf-8?Q?7xKlfk763JVQa9vliZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef3df37-26d2-431f-693b-08def6cad134
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:33:28.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shhu6whzE+s4/RDJmYAVS/oviyC0DvhsQPLtPlYhImQlciXvZ8V/O2d5Mmaj6Zt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942

Hi Conor,

On 8/7/2026 11:02 PM, Conor Dooley wrote:
> On Fri, Aug 07, 2026 at 03:20:12PM +0530, Vineeth Karumanchi wrote:
>> +static int macb_cbs_get_queue_params(struct macb *bp, u8 queue_num,
>> +				     u32 *enable_bit, bool *is_queue_a)
>> +{
>> +	/* Queue A is highest priority (num_queues - 1) */
>> +	if (queue_num == bp->num_queues - 1) {
>> +		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_A);
>> +		*is_queue_a = true;
>> +		return 0;
>> +	}
>> +
>> +	/* Queue B is second highest priority (num_queues - 2) */
>> +	if (queue_num == bp->num_queues - 2) {
>> +		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_B);
> 
> What's the point of making enable_bit a parameter if everything you do
> using it bounds a conditional section gated on is_queue_a?
> 

yes, agreed. This approach initially enabled optimization of the idle
slope update path. However I have found a better approach and will
include it in the next revision (v2).

>> +		*is_queue_a = false;
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int macb_cbs_add(struct net_device *ndev,
>> +			struct tc_cbs_qopt_offload *qopt)
>> +{
>> +	u32 enable_bit, idleslope, speed_kbps, ctrl;
>> +	struct macb *bp = netdev_priv(ndev);
>> +	struct ethtool_link_ksettings kset;
>> +	bool is_queue_a;
>> +	int err;
>> +
>> +	err = macb_cbs_get_queue_params(bp, qopt->queue, &enable_bit, &is_queue_a);
>> +	if (err) {
>> +		netdev_err(ndev, "CBS: Queue %d not eligible (only top 2 queues support CBS)\n",
>> +			   qopt->queue);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* idleslope is calibrated for the current link speed; CBS is not
>> +	 * reprogrammed on link-speed changes, so it must be reconfigured
>> +	 * if the link speed changes.
>> +	 */
>> +	phylink_ethtool_ksettings_get(bp->phylink, &kset);
>> +
>> +	if (!kset.base.speed || kset.base.speed == SPEED_UNKNOWN) {
>> +		netdev_err(ndev, "CBS: Invalid link speed\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	speed_kbps = kset.base.speed * 1000;
>> +
>> +	if (qopt->idleslope <= 0 || (u32)qopt->idleslope > speed_kbps) {
>> +		netdev_err(ndev, "CBS: invalid idleslope %d (must be 1..%u kbps)\n",
>> +			   qopt->idleslope, speed_kbps);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Calculate idleslope for hardware register:
>> +	 * - High-speed GEM: scale to full 32-bit register range
> 
>> +	 * - Standard MACB: multiply by port transmit rate factor
> 
> I think this comment should probably mention that the register expects
> bytes/sec in 1G mode and nibbles/sec in 10/100.
> 
> This generally looks sane to my naive eyes otherwise.
> 

OK.

Thanks,
Vineeth

> Thanks,
> Conor.
> 
>> +	 */
>> +	if (bp->caps & MACB_CAPS_HIGH_SPEED)
>> +		idleslope = DIV_ROUND_UP_ULL((u64)qopt->idleslope * U32_MAX, speed_kbps);
>> +	else
>> +		idleslope = (u32)qopt->idleslope * (kset.base.speed >= 1000 ?
>> +					       MACB_CBS_PORT_RATE_1G : MACB_CBS_PORT_RATE_10_100M);
>> +
>> +	scoped_guard(spinlock_irqsave, &bp->lock) {
>> +		/* Disable CBS for the queue before updating idleslope */
>> +		ctrl = gem_readl(bp, CBS_CONTROL) & ~enable_bit;
>> +		gem_writel(bp, CBS_CONTROL, ctrl);
>> +		/* Update idleslope for the queue */
>> +		if (is_queue_a)
>> +			gem_writel(bp, CBS_IDLESLOPE_Q_A, idleslope);
>> +		else
>> +			gem_writel(bp, CBS_IDLESLOPE_Q_B, idleslope);
>> +
>> +		/* Re-enable CBS for the queue with new idleslope */
>> +		gem_writel(bp, CBS_CONTROL, ctrl | enable_bit);
>> +	}
>> +
>> +	netdev_dbg(ndev, "CBS: Configured queue %d with idleslope 0x%x\n",
>> +		   qopt->queue, idleslope);
>> +
>> +	return 0;
>> +}
>> +
>> +static void macb_cbs_destroy(struct net_device *ndev, u8 queue_num)
>> +{
>> +	struct macb *bp = netdev_priv(ndev);
>> +	bool is_queue_a;
>> +	u32 enable_bit;
>> +
>> +	if (macb_cbs_get_queue_params(bp, queue_num, &enable_bit, &is_queue_a))
>> +		return;
>> +
>> +	scoped_guard(spinlock_irqsave, &bp->lock) {
>> +		gem_writel(bp, CBS_CONTROL, gem_readl(bp, CBS_CONTROL) & ~enable_bit);
>> +		if (is_queue_a)
>> +			gem_writel(bp, CBS_IDLESLOPE_Q_A, 0);
>> +		else
>> +			gem_writel(bp, CBS_IDLESLOPE_Q_B, 0);
>> +	}
>> +
>> +	netdev_dbg(ndev, "CBS: Disabled queue %d\n", queue_num);
>> +}
>> +
>> +static int macb_setup_cbs(struct net_device *ndev,
>> +			  struct tc_cbs_qopt_offload *qopt)
>> +{
>> +	if (qopt->enable)
>> +		return macb_cbs_add(ndev, qopt);
>> +
>> +	macb_cbs_destroy(ndev, qopt->queue);
>> +	return 0;
>> +}
>> +
>>  static int macb_setup_mqprio(struct net_device *ndev,
>>  			     struct tc_mqprio_qopt_offload *mqprio)
>>  {
>> @@ -4594,6 +4713,8 @@ static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type,
>>  	switch (type) {
>>  	case TC_SETUP_QDISC_MQPRIO:
>>  		return macb_setup_mqprio(dev, type_data);
>> +	case TC_SETUP_QDISC_CBS:
>> +		return macb_setup_cbs(dev, type_data);
>>  	case TC_SETUP_QDISC_TAPRIO:
>>  		return macb_setup_taprio(dev, type_data);
>>  	default:
>> -- 
>> 2.44.4
>>



