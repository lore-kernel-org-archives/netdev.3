Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020124.outbound.protection.outlook.com [52.101.201.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E84854EA
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075882; cv=fail; b=dNHCMruN4ZDMKPHjLqV2Z9s06DQsDjXyLFQlIdUnbALwwRoxBIWQZaB3ofiTC5XFCO7X2YEg7yLEpOG/nBrfdUSUxgM37sdEpSrDpR77pLzUiLJaOanV8QyeNvV5RCBwLCaZt+f+i7htJXnWxmgjw6/5HtL/ZpMxfJBCy3r96iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075882; c=relaxed/simple;
	bh=SWWSVmrt9zf/hyJHR8452WfhUyqR9juYkGijAmxart8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WjbGEGtQ1WA6ijK2ECYYf4RX9BejcRUou/N31wrrYMNLFTX4d4WvPjXOYeCw1+oI029QgDrQZk0wYwOkZBX34PVwbpfOenye8MqU1FJ+UUBCFvEPcHk0AVsZjZPiH3tVzbczlTqcl25HZnJz5///8bvWiZHxnVeuR/xPaC91FI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=e8nYra3z; arc=fail smtp.client-ip=52.101.201.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="e8nYra3z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNGQelUGZVWcwjDUHa6rEOawcrq+ZXBY/iK/dvATOl/Qzpvaj2MhW4yrlprKJmrIFMv+zNAt6IlQgr7vLy5XVOIIhB24oKsFiTZv9OQcXnRgta4QBV3ZeFZ0vHYIWt7A2TZVPgDTZ4Usf7VHGBM4VxPZWXNXRTGft1P1GD5sfLtXAGEaBCV/IQdb3BwsND6OIdewkWE/VmBMzU1W6P7Lt8IWQZvBuAl99Ipx7zvMNZ9UiRopPtjzrCBHv1Jslzcm8fIM48FetYNIzCSEjIBecbyBPkWoURbpjl5UBvZVLftvIzkf1HnssMwGGLkdUhJpNh+fBIfURYW56ks8sHcnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya6rrRoMnGppRKTniXdgIg8Y8sv0P89lqqTnqVMGx7c=;
 b=bHtDTvQ45XUNdiJEJS3guIDmc5/3n4hwoEu1dYbCrayz6IlHDEeAPG0ymd+JBGCzj3JW/RwrzmD1hXqUPQr2narei4bYWsTRLKUCXWCzpQwpwFo6P19tdPp2/5kKAtE1MOr+NMtSc5QtQ1hFqg4Z8qR059InSen1PlowGNzNY9fDKJry53YDIQPicXUWgH6xAbzP3wOs5dGfkAxYRXXM3dZ0vWYImmECGUtNUNbgzxMv8BfByCMPVtggx3S7OwluzeaOrNb9wozV/NinZ9cpPD5EWPF5LLm3DscDqQcnDalO4meG1MflpQ583ChnpSsYyjdJLkP+fIvYGwxN3hz43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya6rrRoMnGppRKTniXdgIg8Y8sv0P89lqqTnqVMGx7c=;
 b=e8nYra3z0shMn7gx/InRG2ODeakVoc1mehGUErTQij1vBR/ZQrrHfL9Vfr1tl4dkMCwvZ56tgyPw8rIajdjgwpGbOJyfI91XliAyR3HAYg4Kj/UjOOVETRvsp/FbkF2Wyj7z3s/2Irmcvu1kmawj2ojKJLUIBg/K9v6Z/H49q6LZ3sKiileYoSGENTqiybB7NrvEyWIaOCSq/X9BxQU5sYtiHCg91lY1q6IPSBelSB2pxWeA/uJ593AB9DF1c1/l7WkTSYrsG4RfdkyT+Lx09Tm1tyvI1Us708MHWGf+IPV80V3n2or2iAH12O4k23GUYUIlgVMu2m87Q+Bp+3hixQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by CH1PPF989868826.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 17:57:55 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0315.012; Tue, 18 Aug 2026
 17:57:55 +0000
Message-ID: <621e5f0f-8fba-4912-8e94-825bb70ddcdf@pa.msu.edu>
Date: Tue, 18 Aug 2026 13:57:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] net: macb: Poll for link state changes
 when using the internal PCS.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, charles.perry@microchip.com, andrew@lunn.ch,
 kuba@kernel.org
References: <20260813153705.23407-2-nwhitehorn@pa.msu.edu>
 <20260818131419.191979-1-pabeni@redhat.com>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Autocrypt: addr=nwhitehorn@pa.msu.edu; keydata=
 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
In-Reply-To: <20260818131419.191979-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:610:b3::11) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc1f840-046b-4642-cdeb-08defd523b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|23010399003|786006|1800799024|6133799003|4133799003|56012099006|10067099003|4143699003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+pM85dGuW9nC9VqGEiQlEAu6Gn6xDIyDogTKWPKzSxvXFi4Gu+eMNk4C4RjpXU14nJCKY38ezMqOaSlaYMLzUSyV/a7LUb9Nkwlkm7VBu/RaHpKSrKB/d04u20o/3XCExHijXtPTdtxCFbYwEXIWwFYqYUDvzSnAMVgXxn1A802xvrpfj7GXfZvw9boIc6y24jyA4IBIeqDVVfA6xthJ3GxTbuc714B/bntSg+PPCTrH2hIg3DpF76mlEwCDyIXv0YcWHg9ftw25Bcfw1cVAdZTMwgG3fmR9njTiObkeLJRY0iJIiXicVggiNP1bIbLH2oaXBgaVd1YfW/KDyelDEpu5b3Jfpi2RTAmXtOeWOXmkFX60ftAIwPg4YpA9MpjmIQZjgARRbBlPD9BsiBo798LHb8jxwbGsL7OHKeKpkAeawMGhJwhRR6NDmJjBK5Q8/GBejkJUfkjbUY8ng90rHC6RSWxcgTMJbL6/ZrEzpbYpo0h+GL6/KuOSoL0gHeo+A+KN2HhfZJzUp2QWghjWyzdbVDopNqTU7a1IoxO6a25FbSkgg4POabr4Y+PpWXjh8cRjLG+P/MACRyccp/8A0+/abyWrIEh/tIc8BxBb3MgNIWzNlUZlm9EVEMa/0Sya
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(23010399003)(786006)(1800799024)(6133799003)(4133799003)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk1jTjZHNEVoY2NCK3UxUzErMlZ1UnZYM2padWxFWEhETTFnTHhURG4yQ1U2?=
 =?utf-8?B?bDVMbnU2QVpBL0MxaDIrYmQ1VG5kQkpSRnNRU3gvRjRrcktReGFSRzhHdUNS?=
 =?utf-8?B?ajRLQXM0VUlkK1Jra2h3ZllxRUNjTE9YZWVpRU9vWndGM1QzWUR4aUFvclo1?=
 =?utf-8?B?U1dBd1RrNEdjdElNMTYvYW5SbUtyYXBKTG94MHVJRGh3N3owSS9BYy9WSC9H?=
 =?utf-8?B?N2pHczI4SVd3SUlESlZ4UW5BeGphcXkyZWRHU3RoQ0M2SVpDL3NsNUMxYjEr?=
 =?utf-8?B?b2g3ZnhTcU1iWEMxQjVCZklEV0ltZkwwL3cxdmdFdC9ER2JWUFRtUlYxMCtT?=
 =?utf-8?B?eVdiUjhUSFYyeXF6V2dtVk1OVlZoMTBHek1rSGlrU1dXd2RMOFZOU05XYmJt?=
 =?utf-8?B?NTNSNEFvY1pUd0N4Rlg2VGpwOXpOVFpkeFY4WVlRM09kZ0RMdTVKbG1zNHMz?=
 =?utf-8?B?RVZmUm9Jc1U5ZS9BTFN4U2IrT0kzSXpJZlJ3Z0FPMHBWcE1KNlhDaEt2MTNq?=
 =?utf-8?B?dm9RYjVzS1RtMnhHTW04K3VvSndrSkRpOHAwU2w3bWtDUzA3ZHI2SmtxY3pv?=
 =?utf-8?B?b2kvYlpKOFdOamY4Y2pOQzNpTlllZjEybGhGUEhZY09SOU4rT25XUWtPckR5?=
 =?utf-8?B?Q3RtQUdwcWZUMDhEV2xJS0ZwaXZQRDZVTVA1VWNGR0o4SjVwQ1lwK3pIUUZP?=
 =?utf-8?B?T3BkRmVBcmNJZExoQXNOUzFtUjE0MFQwczZNdHlUQ0ZyTHQ0MVhqQzBSbXVD?=
 =?utf-8?B?RVZMUWZhdWk0blpzMWRjVFVBZm1BK3hHNHpPWVpyM1pkVlVOWnJZWC9Dcmg3?=
 =?utf-8?B?OVk1RkVJU3BwWllRcUY2RlJMTVpjVEpNMnd1Wml5aFVKUDFxUnNyWTlFU2F1?=
 =?utf-8?B?bVF0N1hrb2xiV1MrZTl1ZEF4Uzd4MTIzd3ZuTWRJWEN1elRtUDJjbDZUSjJq?=
 =?utf-8?B?Zjl4ai9ZaFdCVTlUVHduRnpsUHN2MTBIUGQwZDVBSUZVci84VmVjSjcyclBz?=
 =?utf-8?B?cnkvTjF6OWl3cFVxbS9ZeHRYdE01cklkcGlpUndmNmFRd2dhMG5rSkRXMlNj?=
 =?utf-8?B?bG5aNU5MMDRJcUZqa2dja3JVS3JCZnZ2aSszS25qa1NaQ01iNm1TbDEvVzA0?=
 =?utf-8?B?TENkeHQ3TzdQcGQzendSVHVyVjBEazNjczhtU29ZSjVQUVY2QTNJb2NyRUY1?=
 =?utf-8?B?VUlQamJTMmRhS1RRVnhjbHU4V0VVOFZxeDFqdUxxZmFScWNNNkd6S05vTDRr?=
 =?utf-8?B?cnErMFR4OTYyTStxYS9rV1JSUi9sSHNCWmFZVXNQNENsWitBSWo2NmMyN1Rv?=
 =?utf-8?B?TTZ2TDBhN2JzWmt1emphVGpFTXBhSy9yRGplVWwyTGVTZURNTDhMQ0NUa0VN?=
 =?utf-8?B?RWVTdmlnY2xHZ04rdFhackpOemErN1RuK2dtUnNZd1F4UjQ2czZ2Y2Vpdldz?=
 =?utf-8?B?d0tJTHlNbjExMml0bGtEMHlNSW5mYW9wRjRVUkR4RDZmeG9EdzUvMlVrMURl?=
 =?utf-8?B?dkhHYmhSeG1hV1JWSC9XSGoxNll6SUU0Q29FSjVTWG1PRVJPU0creGs1aFlt?=
 =?utf-8?B?K3N5aXRYZklRdFhkc1NYRHlESTIrREFmUnl3d1RWelpWVDR2ZW9BZ2NETFV2?=
 =?utf-8?B?OFNZVW5lTW1Ua0hSQ1M1UHJkWXhEM29PMGw4WGtUWFpRWmNpYWtDUXlMam9J?=
 =?utf-8?B?b1J4WHZpNzUyZFNUaHIyVzhQc3J5MThSczFjbDdxTVlBVUdzS3hDSy9QRTVw?=
 =?utf-8?B?eWVxSnRiS2c3RWsvNHZhRGpDbTVBK05RNnk4Q2E2NUVONHRsRmpyV1BUOGRW?=
 =?utf-8?B?eFp3M2dXSTdjYUJqRHZyMVR1bW4xcFhYL3hIOHoyOE1ocWZlaDh2SkJHeXJv?=
 =?utf-8?B?aGpBUThzY1JhYm5PaGpxaWM4dmpSM1BJWnVMK2dGcDVTRFhsOVJwM1FtRzNk?=
 =?utf-8?B?eUx1ZEhUZ2pybHJtRkdnUDZiNTFOWnE4UFUzenZhMUFmdEhNWFByaFR0aENo?=
 =?utf-8?B?Wmw0aWg1QzRhWVJwZE5qRnlhZFhFTlB3clh0V3RTTkhRclJ0azRXRDBVeXQ0?=
 =?utf-8?B?Vmtsbk5lVk5tZ2UrSjFaUjl4WmhLcGVSZm1oOWFaN0duL011eXdLdmMxUkha?=
 =?utf-8?B?R0Q4d1JqZXV6R2hPZWFRemltYXhDVFVFMjgvK21FRFBFSDR5MzB3NDZneDdN?=
 =?utf-8?B?ODNDSURxdGdySWJOMnJsV3E4cmJONGY1cDIyZVptQjV5SjZFeVg2YzRFMlA3?=
 =?utf-8?B?bEgzSklHbmJQT0lvbWl3WHRtS0dZLzk2MUp0VmFZTWpKTFJSMHJLcFF2T2Zu?=
 =?utf-8?B?angvcDJKV1JkNWRYYjBDWFBSd0hheDdiZXdLbERTQU1EdVF0UHIySU1XTnZp?=
 =?utf-8?Q?mfXIhs1wjWj+6TSDWO07Py8URo3fYhNHp0tfs?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc1f840-046b-4642-cdeb-08defd523b38
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 17:57:55.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcVJiccIjWK8L2ucplzazuvq1xJC6Ek0xY6ohVnk7FCYb4h6DVHCHCMj3rNyD40c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826



On 8/18/26 09:14, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://urldefense.com/v3/__https://netdev-ai.bots.linux.dev/sashiko/__;!!HXCxUKc!1c62Nd-KqBSJoooZYqRXvyr1xBH2SrYG0Qj-vjwRbTXeO230CuhteNJg0IKZip8kZa8eox-PjTqUg6Jbyg$
> ---
> net: macb: Poll for link state changes when using the internal PCS.
>
> This sets poll = true on the macb internal SGMII phylink PCS so phylink
> arms its periodic link poll timer, letting link state changes be observed
> at the PCS instead of at an onboard PHY (for example with an SFP).
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index d394f1f43b685..c15a9c7e69d37 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1025,6 +1025,7 @@ static int macb_mii_probe(struct net_device *dev)
>>   	struct macb *bp = netdev_priv(dev);
>>   
>>   	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
>> +	bp->phylink_sgmii_pcs.poll = true;
>>   	bp->phylink_usx_pcs.ops = &macb_phylink_usx_pcs_ops;
> [Severity: Low]
> This isn't a bug introduced by this patch, but should phylink_usx_pcs also
> get poll = true?  The commit message speaks generally about "an offboard
> transceiver (e.g. an SFP)" and about polling "when the PCS is active", yet
> only the SGMII PCS is updated.
>
> macb_mac_select_pcs() returns &bp->phylink_usx_pcs for
> PHY_INTERFACE_MODE_10GBASER, and phylink only arms the timer for the
> currently selected PCS:
>
> drivers/net/phy/phylink.c:phylink_pcs_poll_start() {
> 	if (pl->pcs && pl->pcs->poll && pl->cfg_link_an_mode == MLO_AN_INBAND)
> 		mod_timer(&pl->link_poll, jiffies + HZ);
> }
>
> PHY_INTERFACE_MODE_10GBASER is one of the modes accepted as in-band by
> phylink_parse_mode(), so with managed = "in-band-status" the USX PCS ends up
> in MLO_AN_INBAND but with poll == false.
>
> macb_usx_pcs_get_state() is a pure register read:
>
> 	val = gem_readl(bp, USX_STATUS);
> 	state->link = !!(val & GEM_BIT(USX_BLOCK_LOCK));
>
> and macb has no phylink_pcs_change()/phylink_mac_change() call anywhere, and
> poll_fixed_state/get_fixed_state are only installed for SGMII.  Does that
> mean USX_BLOCK_LOCK transitions are only sampled when something else (such
> as an SFP loss-of-signal transition) forces a resolve?
>
> The USX PCS behaves exactly as it did before this patch, so this is a
> pre-existing gap rather than a new failure.  Could the commit message say
> whether leaving the USX PCS unpolled is deliberate?

Very happy to update the commit message here. I don't have the 10G 
version of this hardware and had avoided touching it. Longer-term, as I 
mentioned in the cover letter, I think we want to set up an interrupt 
handler for the link-state change notifications from the PCS, which 
would remove this, remove the similar polling on fixed links, and 
obviate the need for similar behavior in the 10G PCS case.

> [Severity: Medium]
> This is a pre-existing issue, but arming the poll timer adds one more
> asynchronous context that touches the hardware, and macb_suspend() does not
> stop phylink on the Wake-on-LAN path:
>
> drivers/net/ethernet/cadence/macb_main.c:macb_suspend() {
> 	if (!(bp->wol & MACB_WOL_ENABLED)) {
> 		rtnl_lock();
> 		phylink_stop(bp->phylink);
> 		rtnl_unlock();
> 	...
> }
>
> phylink_suspend() is never called either, so with WoL enabled
> pl->phylink_disable_state stays 0 and phylink_resolve() keeps running (clocks
> stay on because macb_suspend() skips pm_runtime_force_suspend() when
> device_may_wakeup() is true).
>
> If the PCS link state changes after the WoL arming sequence, can the resolve
> undo it?  macb_mac_link_down() clears the receive engine that magic-packet
> and ARP wake detection rely on:
>
> 	ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
> 	macb_writel(bp, NCR, ctrl);
>
> and macb_mac_link_up() goes the other way, re-unmasking every queue while
> NAPI is disabled and re-enabling RE|TE:
>
> 	queue_writel(queue, IER,
> 		     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
> 	...
> 	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
>
> phylink_resolve() does not consult netif_device_present(), so nothing appears
> to gate this against the suspended state.
>
> The same 1 Hz poll already existed in the baseline for MLO_AN_FIXED SGMII:
>
> 	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
> 		bp->phylink_config.poll_fixed_state = true;
> 		bp->phylink_config.get_fixed_state = macb_get_pcs_fixed_state;
>
> and phylink_phy_change()/phylink_sfp_link_down() can already drive a resolve
> during a WoL-armed suspend, so this patch only adds another trigger for the
> in-band SGMII case.  Would calling phylink_suspend() (or phylink_stop()) on
> the WoL path in macb_suspend() be the right fix?

I think probably, but I don't know enough here to be certain. As you 
note, this slightly expands the scope of the pre-existing fixed-link 
case, but I don't know enough about the pieces here to be sure of how 
best to resolve this or the rationale for the current fixed-link polling.
-Nathan

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


