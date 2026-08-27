Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937EF35295C;
	Thu, 27 Aug 2026 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824102; cv=fail; b=dfb1bBoxT5xR/mggkdbH7p0u+e9MXJqPXK4Z6EMdn/xflfU02wOHgSQSVd7P6qP07bKPUTSTc3MiwPZbeOQdw0cwr4DkgqI4eWhbbL1nshu+QTRWqcECpwzfGpzJvbNpttwkfAuyUuNUkOU0iuaiEQztkqPv8XcOD0e1gNP7Jtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824102; c=relaxed/simple;
	bh=1YXN9LoS+7ij5q443BOZfL910UAWGag++d2HtoFrVWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ONumCoIK4fLnKbwW2iKdYuVaza9QK6cTbxFDNi3VAQQvmGgskedGiHn3XdMwfzxyg2t6mwpQ+LhH0+6jhWl/F2avOpEtVseVlSV5x/EBr9CVWOUjLY7HkUGBMQN710j00GZztHsKZIn4KErHqJZ7QOs4YEtuOc4tQtS6IPDfq9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QHWrcopd; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QHWrcopd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfIsVmPeZr8X+3Jn0LuyF/mzKTzpTLwXKCU17MVQdmFm0Ee+8/JHH68zo8uYCPdpROU2+qvHuzR0DbYJcrMfF1uarhr6+1DKnb8hxXWG7i22A8cO6eAV08DRsy67f22cFeLOENW9JbAFty1mgE3rgtaxD+ume3rSL05HIjbLeJvJmyW4mKOgi3GEjVjMcCEnxgYvzdfWRXUmZC1i9unCHG3g/Gw6/zibZkIOPfYZxFre57LEW5GsxI2TlITmU1c2bXGJ2ILgFwOoDUSiTdWLrZIn6GVu5GRoOyoAnw6Gmj9VA7cUN4vEKEy3jxlQDCzy/qBP/iSuluX0zV13nGakmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKTGFKMj8LY3sPx48avZoYwDPLadFbxmIG2ZIk+sVTw=;
 b=oGGwfzaRZJO9jJwP+3XsTN3ISFucOldOSfNEiTsm/Ys66xz11cK72kePJeJAXQIy66cpmF+K4RG8uQ8kDmPqaycMhHXnJENp9aUwmZuElgYpIDm3Fl/faXCdVmx1A54R/5qDEd8RQ+BUMto9XmUWwq/T+W2ybPztHLFATDnTrxuB6NBEJEmH/suHfU0pcFMiPSzp1cM0FE2TDEDdia7eoRWkuzrpUrWUbyXKaXI1CTr3pPd6fK6Dq0cIY4s+x9nbNM/Fh/XOIA7AT0Z3ReInNUah7dZUshgSLwMa2pkxAooNkFUUyd2AbRbMjDkSO8uUArzof6GrgUKAapUNs4p41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKTGFKMj8LY3sPx48avZoYwDPLadFbxmIG2ZIk+sVTw=;
 b=QHWrcopdCd5o5wqsZtgaoe1zewXtitolEBS5QlZeyjvYq06liJz/qBM+QDIzxqsmGau4mf8q4ze52VXrfxZrn2S7ntSCWFOEGAxbsttIJfQBZhAzZbAX/lvxc6zziSCFnWCsH1BdOTEu+4KX4owFNWCEeMA+2ie+6kmiTwwZE8Bj7X0BUG0bprBfeNBbTpzxLrURek6Kz9++LUcsM3X5PmUfFM+g3YsIcSOuf6LYaA2GiVJTxW413tejiIYiRxJNsEeT8XSwTgn2m5tmsPwGKFZ7sRkPABEZddhexoUfX/S0ESXcOpseTLbVIE1yfDDgyhBw7XbOvGIO15GEROd3Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU4PR04MB10912.eurprd04.prod.outlook.com (2603:10a6:10:58a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 09:48:15 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 09:48:15 +0000
Date: Thu, 27 Aug 2026 12:48:12 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Patryk Biel <pbiel7@gmail.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: pcs: enable autonegotiation for 10g-usxgmii
Message-ID: <20260827094812.52skjha73d3fddod@skbuf>
References: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com>
 <20260827085533.2a3ocp6llvhzczps@skbuf>
 <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com>
 <20260827085533.2a3ocp6llvhzczps@skbuf>
 <CA+DkFDboHq+fw1bYdQR_2M9hM+Vp6W=jR0VYCO8u7KXWVq9F4A@mail.gmail.com>
 <CA+DkFDboHq+fw1bYdQR_2M9hM+Vp6W=jR0VYCO8u7KXWVq9F4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+DkFDboHq+fw1bYdQR_2M9hM+Vp6W=jR0VYCO8u7KXWVq9F4A@mail.gmail.com>
 <CA+DkFDboHq+fw1bYdQR_2M9hM+Vp6W=jR0VYCO8u7KXWVq9F4A@mail.gmail.com>
X-ClientProxiedBy: VIVP296CA0041.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:356::6) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU4PR04MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: 598dfc16-a205-44d8-346f-08df042050ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|19092799006|1800799024|366016|3023799007|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hs/jTDJy/jlgYwGAbDuxHBT9wAQ1yQzY/ugxnk4fpyyOu+lp2+Y1CMp5lKpQMmFTPfFHhpnZvKZLUjGn8RO3bSrkDcOmP3Ue0aQ+gGNsQMSRhUXUJ798sw/x1zEcEmTbb5oyPj//Y5ODMNK56YIKMDt/xBd7vI7EOC9XWn5j5XKFCs8pxwi7t6WpDCSuTXggCPAoKbtHmUEQ/4CJySA16VKIPeOT1Z4zZb0abo8oDHtCk95GMHViwerY5T0qfl23FUmI7DvA9TTIibNozcxxLEgkFWz+P4A2b6csfbHFj3sUS7T83VJVsvUkpOGnPstqH01KVOazb1k7AfitdT3Bz/UG9j/EtkmmAo1jdN0AMhT/uMmVjJwHhpS3C0/CT4MscVaxRbeuUGeMNV6W4bBJyxyr48oIl75dA4qSytvaBXM7RoVL3xo+smenx4fWoU2HyCURoF+9kcHVn79d/pDmJxqgtveQiGdCwYWb+/a9BIdEZ9lqxcG6X0ZHtW8lCd0Y7Bmsms1R7rIgEyLPNf+TpdcbxymiEMhFbGdDhugnkmZmXpgu4iTxVzKZoMkAth9z0cHisyfx23ZCAFlLaDMp7ip7aRsqpMal8iIU9UstHSXvEUY4rnPq7q4t9WTBbQfRrT/67RBx5WY7Doeth9V+asmPvLDnXn8MGfOOtvrnUKY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(19092799006)(1800799024)(366016)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Kzd3LzdBdWpUY2hXbHQzeGZUYUVqM2ZLbGtNbWhrT1ZyRzBHR1V0clFZM2VI?=
 =?utf-8?B?VTdFb1k3eHpMTnlOMVRmd29ldExPODNSVWFreEJaVGR5alROaEZpOCtIWUt0?=
 =?utf-8?B?MFN0MEtNdUF5d0tFaVp4V0hqa29PSDVWTStsUkFEcTk4OUVmYXE5ZTlLbXJD?=
 =?utf-8?B?L0l6K1dOeWxNUFQ3Ny8vcFh4YURSdGtyTWRadk9tZURTQ0xPZ0tORmtva3RY?=
 =?utf-8?B?OEFPckxrNnc5VmdnbExrUCtZRnl0OTUwUGVBRjdHcHlrMmREdTRZTjFZRFlB?=
 =?utf-8?B?WlBCTXkzbmt3M0N2UVFUcVo0UE1MeFE2VVJIMEY1eTVJS1ZuaVBpUmJ4QUdr?=
 =?utf-8?B?K2xKUjhadmJvMFFjNlJSNEtkTElDNzh1SzNlL0F4aUI0bm5WWjJJOFZtL05O?=
 =?utf-8?B?ZW9pRmZLTUVvQVlKd3ZmVExsSVBiQlJjaVVKc09XVnE4aHhmR1VNcDRDYS9U?=
 =?utf-8?B?WW4rbWVhQlFUZElMay90UUU0Z0NiL1JPUnh2ZDBaVy8zVnFXZXRDRVRQTGZo?=
 =?utf-8?B?Z3E5NEJ1Q2VienU0SEdCMFpHTWNJdG0xTU1sSjBWcG51RktzL3ZKQjlNTGhT?=
 =?utf-8?B?d3VZL2NrM0RXbmI3NmVaaWVrbHltc2RheWFCV3hRbU8zaS92elIrdVpNOHhu?=
 =?utf-8?B?ZnU4RDd3anhpNXlSSnlqVHIvNkQ0dDlleU1UenRERzZJRTdTSWFpV3R1T0dZ?=
 =?utf-8?B?bHNhYklMT01xeGp2SXM5Vm9tTDNzOE01dk1LdTZPTWwvajlaUE1MMWNqMytq?=
 =?utf-8?B?S1MvYWErUHc4eE9QVk9KanBVbTZPb0o5OURZUFByWEJoSXBSZFBGaE1BcmRm?=
 =?utf-8?B?cjYxMXNXMGkyUDZId2J2VS9YZU5lcmszRGhGSkw3WjdWa0ZzM1duN3BTVHpR?=
 =?utf-8?B?akVxUDhDQUo0S0ZKdVZiQkhKYmNGdFlBYWdGb0Y3bCtkR2dOQk1YbEtIWUNZ?=
 =?utf-8?B?dXkraUZkNEtFVmhYUlNwdHFNRml4dldzc2FlTTc1aUNHSHg3cllDQVMzTG5M?=
 =?utf-8?B?NVNHWEpEeXBvTmtYSWIwK0RXZWs0bUp3cmVLaWV0WUYzUnFOTDdTcnFSOU1z?=
 =?utf-8?B?ditMOXZCSXJsSnZ4L0Vmd0NEbm4wNVc2ME1XY0dZY0lIaUxtd3pGNld1KzFq?=
 =?utf-8?B?eXg0VDlxdjhpaDVCQXFSc1hEVitKL2Vob1g4TFBWM0NqaDNaaVNrS2hIdFdW?=
 =?utf-8?B?K3FTUzhGQk9nVmg5b0M2dEZ1MWRwNUFvcG5wNW0vMDBlcmxTb1U3aHAxZ3Rv?=
 =?utf-8?B?QXdOS2tnTWRjajFjL20rWEttVDhpWCtDWHYySXZreVJXSXJQY09MSWRRekUy?=
 =?utf-8?B?YWRTUjR5UURSaFlBNU5wd2hjVmY2VDN3S2ovMmJTeDh1TEtyRjBUcm1LR1Jl?=
 =?utf-8?B?bEYyVDc0WjFhd20rbUlDc1dKbUVSNTVIaUdsNGtXUmtaZGdZNEdKYmhseVZK?=
 =?utf-8?B?MmNzTXdPcUlTaFhRd0R5Yzh0K3NENnpJclBvUGtGOHBpT3hZYTVMN3g0d3M1?=
 =?utf-8?B?aDNKMWhodGNRSlZvcG9YWDJES0pVYmNzMjJkcUZuK1JaYXJxN01rTEN2UUZH?=
 =?utf-8?B?SlJNTjFZQmwveXdvSE8zb20wSDdvTDVaZUxDZ1p0Skk1aHhLTFlocDg2emlT?=
 =?utf-8?B?Q1V6ZW1XeEVSNzVFNndHZU5iNktreUNpY2VMOGRuakNFZ1ZQOUFjbHcvWk9m?=
 =?utf-8?B?SUVpU0NxZWtzTXZ0ZU9Pd0NHdlZTR1cyMzJTSTBmNFAySDVaQURQNndpT3B2?=
 =?utf-8?B?MXk3Z2Z5VUh6djkxcFhNclpySWJmUzZ5c2laNXN2WmtEc0RnYnh5UGw1WmV0?=
 =?utf-8?B?Qk1Cb0NtalY2azRxRU9zeTdUTDBTckNESXRneUJodFFZWEs4a2ZzYzlHa1Jp?=
 =?utf-8?B?N1Z3SGR1T0oyTDF1TUoyMCtSRFJsK0w5TGtXeWN1RUloYU9JMW1GK1M0eG1B?=
 =?utf-8?B?SVdCTWxxdVpjZW1pYkhnQnhvM1hzV1N5K3RqZDF2VUhqVllRL1JvMFpCWXlD?=
 =?utf-8?B?RS9WV0pMZWdLSjgrNFc5Zm1nRkh3ejI1LzU3eHNkd01RYWFkVmJuaWNHbk1m?=
 =?utf-8?B?dEY4YVVTS3E2enE3WDliRDZKNEhCbVdSdlRtbEllREJQV1M2elZKMTNGS2V3?=
 =?utf-8?B?alhZdnUrWFFVenlpbW40djdINTJQaGFOV2FVT2xiNFNXaHpXYVdad0pHNE05?=
 =?utf-8?B?ZjVra2lvaUgxTmF6WE9GNUU5cDJCTVQ2bStDR1FwOHBuT0Zvam5IUnVKUkZH?=
 =?utf-8?B?NHJlUlBKc1Z4dEp6aGFOczFYL3MrZGJsNkVJTjkrV0RVVGdmaVJuaEtxNmR0?=
 =?utf-8?B?Uzl5UDl3STZtVXJHWWU5Yk93di9ETkZOU0NFKytDY1V4M1dqeXRFcVRDa0FR?=
 =?utf-8?Q?h8o0dOi4S3XPUzQA36SzwLAJTch9MPShJkOONEAmaOPU7?=
X-MS-Exchange-AntiSpam-MessageData-1: bxVwJjoGIhYe8KGmc0/tnR8kETljiAU6B24=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598dfc16-a205-44d8-346f-08df042050ce
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 09:48:15.3571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOMA6aZOvUqBCl8je989x7/12AQePkyRVWOV1ZyUGbUEdWZkLnZqDnRlEwX3n4PwXozUpGEEweb8Xkmh8jUggg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10912

On Thu, Aug 27, 2026 at 11:13:15AM +0200, Patryk Biel wrote:
> Hi,
> 
> On Thu, Aug 27, 2026 at 10:55â€¯AM Vladimir Oltean
> <vladimir.oltean@nxp.com> wrote:
> > Furthermore, you don't need such a long text under ---, it will be
> > discarded when applying the patch. Fold whatever information isn't
> > duplicated in the commit message and drop the rest.
> >
> > It is acceptable as an incremental step because logically, it is a
> > different change compared to also supporting PHYLINK_PCS_NEG_INBAND_DISABLED.
> > No matter whether you also submit that or not, they would still be
> > separate patches.
> >
> > I guess the more important question is: do you also plan to submit a
> > PHYLINK_PCS_NEG_INBAND_DISABLED patch? Any problems there?
> 
> Yes I plan to submit this patch also, however I'm still working on
> disabling in-band autoneg on phy side as the procedure is not clearly
> described and I'm trying to recreate it from vendor's sdk code, and
> it's not that easy as the sdk carries I believe support for all their
> phys.
> However I also have one question regarding
> PHYLINK_PCS_NEG_INBAND_DISABLED on the host side. I planned to discuss
> it separately however, since you brought up this topic here, I would
> like to discuss one thing that is not clear for me and as you are the
> expert in this domain, perhaps you would be able to give me some
> hints.

As they say, an expert is someone who has made all the mistakes in one
area. I've definitely made a lot of mistakes, but I'm not sure I'm quite
there yet :-/

> Looking at the lynx_pcs_link_up_sgmii, once the neg_mode
> differs from PHYLINK_PCS_NEG_INBAND_ENABLED, the IF_MODE register is
> explicitly programmed with speed and duplex values. I browsed through
> the manual but did not find any similar register for 10g-qxgmii. This
> may just be due to my limited understanding of this area, but is this
> intentional? There is no need to epicly program speed and mode for 10g
> qxmgii with in-band autoneg off?

Yes, I suppose there should be.

I also don't see a register in the MDIO address space.

I do see QXGMIIaCR2 field USX_FORCE_SPD, but that's in the SerDes
protocol converter wrapper space (which is handled by
drivers/phy/freescale/phy-fsl-lynx-10g.c), so that's a bit unfortunate.

Looking at this register, it's not clear to me how individual 10G-QXGMII
ports could have their speeds forced individually to different values.
The single register handles the entire multi-port protocol converter,
it's not like QXGMIIaCR4-QXGMIIaCR7 which are per port.
This is something else I'll have to ask internally.

> Given all of the above, I just wanted to add that I'll be on vacation
> for three weeks starting at the beginning of September.
> So if you'd prefer to send these changes yourself before then, please
> don't let me be a blocker.

That's fine, I'll also have some vacation time during the same interval,
you can submit the work to net-next when you return.
