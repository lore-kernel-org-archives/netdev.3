Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794570575;
	b=F+h5bjTzlA5Qlew7hJ5pLMrp65h8dfI/pESrjMAr2oPmeHYglag/dDXCbnojFpVSO51p
	 GXGFylwhHiMp1nQqq8mqMutfNDO/XU/f9i+MFnjxcdODd26d/w92gc4wB10RYCMQs6NiO
	 ZsIRzWgCAW/UoPhmv6Egsu+vjQ2e0dDDihwOwNcaDwPwucKR3Gg6ARDIZjYFbNxrc5NRh
	 ratCFTQrKJUKXJwTDaQZZsM8pUHrFMuJevtAIiPOvBc+OrhXft95eTFQP2O7cqcLHasez
	 nMGo8CsykjYzzhxMTjXIQlIUdoZ3xikeRK51oy3kPjz+4ZY+tHVehcsvXzrfoSMgTuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570575;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NXoc4U1JzfFRyoJiXo63v8zJM+DBz+irZur++YrHMbQ=;
	b=nuvj3NKbamiCPVFOFLLaAG0KSMye5CEPeDsHyf+f3QAQLPBK9eY6TMrQ1QuGbYQacNa1
	 DU62rVPpndoyCqLDlNVUMhTuQ8Un0QOCsjzybd3quhCwspP7435XtJzCiQESjoH6mUct9
	 TuQHuVcwlKL/5+K9LDSk0rB7zuN2+CZnu4QrXKjKKVKnHKackjCxUGBA03DbTCE6siK6f
	 BhQsDv7HXXVVecW8OB3skEMyPhirRF594y1oCVGYtKr2+QaW9oQTuWzReKtMfikD5nOuj
	 SmG0elolx8O/VgUqV0tctF7O8Yug36siuUigpx30h45V6S45dNl4wj9hQV0o+haKtjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=KZEgI8sK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.64
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17B606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A17B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=KZEgI8sK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXx9F56yaXHAz8UNM0stu+e/qL+PKAUFGaODdxXWblTwVyoQqabOXpFJtVp+gb86+msMCLurq5iiZPFKsw4ksZyKTKLodRHjyKH7O5Sx3bovea0W8e69bzBxiRmUIvfrgqrEXrPu+LHGkiEyowfDkJdYBixPwxxuqW36nmA6j0Myph/0lqP8tvVIES7wTNiKq+2f0AKbDUujA/44bwRpVlwyQEVtb4O7F9LNfBExgGLCasXLHyEl/ApLg1dWbdMclYoX3ZveVAgEvhbS28k0vunwzRYbGo3UQe0Pl7e/m8scajZC5EiFqJsUQYSYZJAmSIm8gAKGhrpMUG5KBg9hhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXoc4U1JzfFRyoJiXo63v8zJM+DBz+irZur++YrHMbQ=;
 b=a3Cdelu0HZwfjTb7OIldFAthEKCFwwHQ0iGDKtqmS1nryPug+du+sbYOzmZsf2I4Uqk/AZtr39wS5gXNKPA0IK40lkUErGLC+6AA5TzJpBzGusU14v3+tI9GXz96h8AqcBWMtRNyi1krQrlCegrHmvcokxNNXeKjz1NxXasz1t8iqlYAGhg10X4mPv7W77hb1m2dbjxHtuY9AStFymwIhFEvMWdu4nnPJ7ldbQQC/YYV7mKKdDCeEvzBB0wi56PyhfOe15GPy1SHO4hyU+va8t0ZOAMfoSp4ZRtCfGFKAZlIzmxEquWg3mHsCjR0EU2gJAvsGtsmr4zHHudiDe7UKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXoc4U1JzfFRyoJiXo63v8zJM+DBz+irZur++YrHMbQ=;
 b=KZEgI8sKuSJdY3XCKBXeBoCp2ysUsPZBkmloOJQeCJbHh8WH0AMrXfYVGtEhQXiOM41mh3TCJXe1pJTytTYo6ovWTRSSj1nD+lSXhl1YsY83oGvuOoQgoG7rYW12cp6bimZ/XPcknJWYjxclLUUlrSEkMO+jEanWMje0bIdTYzHXhAk92zJiRkcr7RUf5mAhLC3XtbsAk+iMlZh/jdtErzdy+4z/DCSAfii3mjwfxE5igGyQAqgzpbgc0TO+P7lVumzqTmUxN5DsgddoigU+7Xgpi78s8/nZcrao6LO2A3aPqvGnTMZDAlDS9YZP7pwHGlMoyjaGTwA6fPKGTtKn9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU4PR04MB11054.eurprd04.prod.outlook.com (2603:10a6:10:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 11:49:30 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 11:49:30 +0000
Date: Fri, 13 Nov 2026 13:49:26 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: sashiko-reviews@lists.linux.dev, netdev@vger.kernel.org
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net 3/3] net: enetc: let core segment GSO super-skb when
 headers exceed TSO_HEADER_SIZE
Message-ID: <avbw3r3Wc5XFbSdK@lxl00025.wbi.nxp.com>
References: <20261111233149.479596-1-vladimir.oltean@nxp.com>
 <20261111233149.479596-4-vladimir.oltean@nxp.com>
 <sashiko-outbox-211955@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-211955@kernel.org>
X-ClientProxiedBy: WA1PEPF00005B70.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::609) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU4PR04MB11054:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd8e312-dc9e-48fb-b271-08df417c2d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|376014|10070799003|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	JEbXsL/o+qYYh0+t+fvQOH0YrwLo3g8CoW1NOYUUakwihzOvzTmMctljaxbh40p9CGccDKXxSjAe+iHgcCvUJkyEkuvjX2Sr2Anhy7GnDSawoja9/pSWNZRX4F/1vSiCdazB1MyC1oRJCXwRqUeqzE0SbkdRfhOLPtmN7fOuWYTzHP2CnkYr/jBFWFDZ6RL/36h67v3imjEC93B0FiegJ4Dlzwq6APmucm0xHYCBTR5tCsTILCsDWlwS5bbLfxK0bd5vGQyDcT76kzwbJdTlMTZMXKfCZKaSpxAyV28jW3dp+aNCgELjNmJR7JXTQ2dNrCI5p0EJ5zRa8iAFMUIZi4w9M0qdpsyplDHqOb7Ft8ms60/vbKGyYDX7bqVzGaDnYYmMY08R5hETkM0Pg3H8LzgTAAarCLWgBcKeT5Xn8qMxvNh3Jl1RJhLFcgBO38CSYSYmqxJ+oyLQU/RR0WfqfyqqHPTW/bcHBTF0f/fOtg4rmjUu5KSfCNNchh2sOWclreZjbFZedtnZwaMQskyKQtgPzMgBHPs6c+X7zBE7KaavFXvH2uuqproyOYJvL5eDW0UjGUhsd2nvW+KkDquQRmc5eLPtsRmXMEXRXXhGXLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(376014)(10070799003)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zcCSk319jiT8zSnd6/q6ZwSwng/JW1NhyG4aBHkTNIZTNPoffhzbDXw1fFG0?=
 =?us-ascii?Q?ypyBRK1/r2YDe5hcOJgWQcPSIITQ+ldC4BEdd8HYjNgcTZ8eJe2S4iXNR9wo?=
 =?us-ascii?Q?qRTt3MGlaWVOwt1+zYHYiqc1tQm66cBTOCjeWiNtCdWIn/+t8NSSMbxJ6Uop?=
 =?us-ascii?Q?E5YOhTBrakC8Ufu8eF0CNVDLDWXlGQt1JRpFdvePqj3AvYdOD2KbUUSeQ20Y?=
 =?us-ascii?Q?GM7ymeXhzDy8dLG2JgJM139yhikI8/RZBDcbGP+kbT0ScPIo07WLRkd8LwJ5?=
 =?us-ascii?Q?7pkrzcBLWl7aMNSDMu4+Dm0X7zncs9acIXEeXfcn0FcxREMHHMd+a7QjMoWX?=
 =?us-ascii?Q?4yHcSv4AywkKlxSGMOQPDoHe12JhTnGrKmIRCXh6oN1Ud7x9GsOLVGHgnxLp?=
 =?us-ascii?Q?lmjNksmPt6XFkt77dQFlMQC8mctzXx/XUrubcS7N+yxe5mB9/la8zAP4xaCK?=
 =?us-ascii?Q?6TXLozD3Ofkq9Dd2h/GWe4lI8P0AGmL5xX9WfR38IyaOTJGLOIQZeQhd/6zT?=
 =?us-ascii?Q?mwCZSbfejsMOH/QcVw/dgCPE0YjK39d8sjcJSLO5VL6v9iV/ArRitasNxbod?=
 =?us-ascii?Q?pmca4Cgze+uI+LUTwERXVO7KVdYQjTw9CIdM9tvKGKHw70I2ZF6Y1dhq23A8?=
 =?us-ascii?Q?sUfu56s3Z7IyR6MZsn9ocn9WF/Zjw8HmmX5iTvhzeYKuDaRqVV/DNMjhg5ql?=
 =?us-ascii?Q?sL/eiKgLF6C4viaNvPsWbPA0BMW1EZNWxJ4/JsZPFkSkxSFRsjGyiiYlIN/a?=
 =?us-ascii?Q?TqM/WAB5hMv0LXPECSDpO/K4dR9kHC8JOTVhlwzgbhSvV5D+Y7xL9UVaZa3+?=
 =?us-ascii?Q?C4S7tkiuajzwiHJyWb8okRHey6fO5gkn/VgLY2WAttal+YCo1zlcf6SyI7rs?=
 =?us-ascii?Q?XsDDWDZ8dZJQkRgzh9bWyHnu3r5C8AVL3Xq3DAy8M7TVKEJaTWJiaej5JwW/?=
 =?us-ascii?Q?IrG0BEmnZM9ZGBzMaN4iSkAMGUT8pEXNbF0tnEuqTsOPYtE/3sjdV+TvO28f?=
 =?us-ascii?Q?g+k+SQT3DqVBFlmApj2y8lVT2SUOykWH5EzJApEA8E+gD6XAAlPa19zPMMgb?=
 =?us-ascii?Q?enFX38IDEEbhznUcfV805d0Of1E2THBaT5BGXOLonGCi+nx6HmGKwpbK0bcB?=
 =?us-ascii?Q?T5kfFsvADy4vQmRCYkNBGHaUmy84JmdUVH0nEzPKDJvG65edWC/sCKuWas1a?=
 =?us-ascii?Q?PF7W7KEOXr8D1NcUPG+bdrt2kNIxITdTTk12vokoE/UBhRLVjUfb0HAGM7Bd?=
 =?us-ascii?Q?38pJzMrL320BDKwQsNGCno3JGBKgTBjwH326OaxogHN0hJT1iZ2H8v+XIN6A?=
 =?us-ascii?Q?a7o1YRgvMRdCaKd7d2Oo1LxX0Q3LJt3pHspPq9KmbuhxcGRD3EJecdtcsHms?=
 =?us-ascii?Q?JZu4Z14rCCC52zOc3qKMGSyTx+fapoOdG6wAoGXCk6LNpaKnz+4HIeYhAKkF?=
 =?us-ascii?Q?Ujusxc9zLDYVGfUnBMWNuHXs7hXq9po36cMtlUL8G9Bk1TqKn8StLG1NZocm?=
 =?us-ascii?Q?pH9B8xgPP5OxeF1gIX7EOdDdwyntdWAA7I+l/ZPveIzCyWAGdobX0cBoI+6G?=
 =?us-ascii?Q?IJwDDBsOR83tqKkQm/oDUcLkTxHY5Vx7xJ6R4ho5Ka+TaIBWadAxTCrUYo4f?=
 =?us-ascii?Q?2fBvowegJMsKQzdE1NZ6XFMJrlfKCFxSAY06551dCAiAAeQIT+EvVxwOGgLE?=
 =?us-ascii?Q?ilt7DiRsJUgW8QRBhxN2Kbj3s2mZvULv//Xss91n5DSbFsbHPf8h3aVwMarG?=
 =?us-ascii?Q?OzlavzY88XgKziVsyZk7oLZPKSyq94XYEOBdo10gtlMeCVm/olQyQTX7AgKa?=
X-MS-Exchange-AntiSpam-MessageData-1: lhhVUB3FmjmXCA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd8e312-dc9e-48fb-b271-08df417c2d19
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 11:49:30.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KATUvByVHtYGseCUGD9o1VQoV7czzA298L7KZlLvPHLNj4a/XS3Xbl2MlSny76w05l9YeBVahQBetZsSLBeqzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11054

On Thu, Nov 12, 2026 at 11:32:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] net: enetc: VLAN tag push after enetc_features_check()
>   overflows TSO header
> - [Medium] net: enetc: u8 hdr_len truncation in enetc_lso_start() for
>   256-byte headers
> It also noticed 1 related pre-existing issue this patch does not
> introduce:
> - [High] net: enetc: lockup in enetc_map_tx_tso_hdr() via undersized TSO
>   descriptor [1]
> --
> 
> commit b5eb34f7b5b23a1224c351b91a143ecbd34866d9
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> net: enetc: let core segment GSO super-skb when headers exceed TSO_HEADER_SIZE
> 
> This commit clears NETIF_F_GSO_MASK in enetc_features_check() when the GSO
> packet headers exceed TSO_HEADER_SIZE so the networking core segments the
> packet instead of overflowing the per-ring TSO header slot.
> 
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 7f089a84d9a65..3c5478238e356 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -1122,7 +1122,15 @@ netdev_features_t enetc_features_check(struct sk_buff *skb,
> >  
> >  	features = vlan_features_check(skb, features);
> >  
> > -	if (!skb_is_gso(skb) || enetc_skb_uses_lso(priv, skb))
> > +	if (!skb_is_gso(skb))
> > +		return features;
> > +
> > +	if (enetc_lso_get_hdr_len(skb) > TSO_HEADER_SIZE) {
> > +		features &= ~NETIF_F_GSO_MASK;
> > +		return features;
> > +	}
> 
> [Severity: High]
> Can a non-offloaded VLAN tag push the header past TSO_HEADER_SIZE after
> this check?
> 
> In validate_xmit_skb(), netif_skb_features() runs before
> validate_xmit_vlan().  When a GSO skb carries an out-of-band VLAN tag that
> is not offloaded in hardware (such as an 802.1ad S-TAG, or an 802.1Q C-TAG
> when NETIF_F_HW_VLAN_CTAG_TX is disabled), a 253..256 byte header passes
> enetc_features_check() and then grows by VLAN_HLEN (4 bytes) when
> validate_xmit_vlan() calls __vlan_hwaccel_push_inside().  In
> enetc_map_tx_tso_buffs(), tso_build_hdr() then copies 257..260 bytes into
> a 256-byte slot in tx_ring->tso_headers, overflowing into the next slot or
> past the end of the coherent DMA buffer.

This seems to be a good point. Will compare against TSO_HEADER_SIZE - VLAN_HLEN
in v2.

pw-bot: cr

> [Severity: Medium]
> Can a 256-byte header still break the hardware LSO path because
> lso->hdr_len is a u8?
> 
> Because this check uses > TSO_HEADER_SIZE (256), a GSO packet whose headers
> are 256 bytes passes through to enetc_lso_start():
> 
> drivers/net/ethernet/freescale/enetc/enetc.h:
> struct enetc_lso_t {
> 	...
> 	u8	hdr_len; /* LSO header length */
> 
> drivers/net/ethernet/freescale/enetc/enetc.c:enetc_lso_start() {
> 	...
> 	lso->hdr_len = enetc_lso_get_hdr_len(skb);
> 	lso->total_len = skb->len - lso->hdr_len;
> }
> 
> Assigning 256 to lso->hdr_len truncates it to 0, so enetc_lso_map_hdr()
> copies 0 header bytes and programs hdr_len = 0 in the LSO descriptor while
> enetc_lso_map_data() maps the headers as payload.

This also seems to be a good point, but it further looks like an
artificial limitation. The LSO header length is programmed into the TX
BD 'BUF_LEN' field (bits 79-64), which is 16 bits wide, so I don't know
why it is only saved in an u8 field in struct enetc_lso_t (since there
is even a 1 byte hole in that structure which can be used). For v3 I'll
extend lso->hdr_len to u16, and then this patch should come on top.

> [Severity: High]
> This problem wasn't introduced by this patch, but in [1] can a GSO
> packet with hdr_len < 16 lock up the controller in enetc_map_tx_tso_hdr()?
> 
> While this check bounds the maximum header length, a crafted GSO packet
> (for example via AF_PACKET) with hdr_len < 16 still reaches
> enetc_map_tx_tso_hdr(), which writes hdr_len directly into
> txbd_tmp.buf_len.  An undersized first TSO descriptor below the hardware's
> 16-byte minimum stalls the ENETC transmitter.
> 
> [1] https://sashiko.dev/#/bug/linux-835a7475-1686-40c3-bf3a-572547fbf43f

Great, so the system has sufficient context to know what's the problem
I'm approaching towards, but not enough context to read my cover letter
where I explicitly said this is a preparatory series towards that.

This problem is out of scope for this patch set.
