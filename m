Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792672514;
	b=klLleU4V2q0A0lZ6ZypJ5WelgykmL493A+P/9hcICKYjuX/Uxbg5S8JOx337iVtt/Pi7
	 VjlGDZfltOZAAqBo4d2uj8SbCyabeyx2y9NvBxGkYfkOnL7XYsmi6onn56aTXom1aE3XX
	 9UowkM5vCarDHxZ3K1YnYvqrbCy3rM9H5oUkH1+fkgntNk081fh0Bff76NjklTGP+N3zs
	 pozu/TZheyXeZqFeUinQbaObipETPtTdTi3oyhkMsCNkjK1cSAUbKuycetpbs3hW+ClpV
	 Iin7G9fx1+RPE5xFrBXKsDqxctDguv7LWmO6Ut7mKu6acd41Z4RUCysMTAm1y3ZR7iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672514;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=cN3yjrUS+bIGsRfJ433np9N55gI53v8epZkOcISeaco=;
	b=HVqO8EaM8LfYSb3meVitNl8OJg78yoNV5+6lWD9h570lQycX9zLdWYD+q5LoDMjxoyFm
	 KA14+VqsDK7DZBlrcW5TfBLNdJD867vE7TcGXJT0Is3tb6yjs7F1CSYN44ex/HkDFCu9j
	 ZJYPLRddO/d4BzoobDLBpHI9jUa76oTZtKCF7swWbzy7jxgTaUOSzsmTOvsxSI1WuNyRI
	 U0jZO/nSWGFsp/XXQjea9wTPSKWkUtBnjQ0IatCsE1LKcw57tC7okmTToVB/3ljI05eHN
	 YzUfTEt/HFH2KKwLgzLdI/wXNxJ55LulvcfARRiEcdTTVdj6EbpzfBT605Ld/4aKTPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WlbOzqCa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.22
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF20606A31A;
	Thu, 22 Oct 2026 12:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CF20606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WlbOzqCa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meODwcZFz9qCgfbFQ6paJUHTzk6SOKT0/8ck4IeTweSPytj/dCfZ++Tyz65GhaMigiuzWwbet4+sYmiV8PKbVNHwuQO0+U9rnQkZHobj5cAHzwfmWFKbEDtp4apP7dN4+rLOdT/6j4OFRRxGeq4ZKC0FwiWPDfCWflLp4QW/gOp19waA0imU5w6gDQE0QRrI+r3Sw8qCh74OqtI62162pre81JZWLlld4gd38/urNikBLgddqemMzVtSGi8LHN604Aqi2mqAvU3oyp5o8++M4F7kSijqGivChUcruaMG1WIvwLDOa7luIgPC6KRxF5XhYtV2Bf0GlU4zLNorakZIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN3yjrUS+bIGsRfJ433np9N55gI53v8epZkOcISeaco=;
 b=Z+VxMV7XyiQL1LdrjnB0dT9w+2lku0gSGvr30mi2fFdWgjI0FEqwR9i30mGrnpr7d6lCkwxKD7gN3k9seAZgnxKchaiyZ4GD9dpTxhEnMAAq+y9DMGAw7196DC/u3Y+b8X2p2BSmWED5Aw2WzlZ36uLyVXbn2qSfOZoePNxkRVjwvxFTpYqN8epLeE4dnX3a5rArtHc7n/+6TotUs0nP+swnPbw5ut/FPqGpnMZz8Tr2hkLR6lNjJDjfRwszeIjB4cuDyDivpkGHwAD3LSKV+juUxo60WTBh6VHAyO+BVCVfq+mBNFMD91EjQMRzoEQK4lDhxYmMpSG9AP/9+DBDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN3yjrUS+bIGsRfJ433np9N55gI53v8epZkOcISeaco=;
 b=WlbOzqCaTAI5QCQMFy+jJp2+TjEA7ik0dv1Jhxulm3Z05N1sOumKnuHWxfjvgRHtf+lREIMKgyMcFIluqTklV2MDCi2kocn5Pt/otwmSbIA6TflzH0514ySYMCobhgelvjV7mwCDuYewBa1jUW0Nb9j6ClmqItKlQZnyz5AYDJMwUVlAl6vXttoJvwamlq8nW79cm0d4wqx4l21D1eEynPDaLFuST69NDBgM8V3OWOws1kmHwxSDjP+HNHUY0b45cK/1/rqd486szJC193G2EiKASrfdgcOgDP/jSWwaz7tj6LozThaYLxKaVpuGFmnFIBsKe0e+wl5rQLBbRHUxZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by MRWPR04MB12305.eurprd04.prod.outlook.com (2603:10a6:501:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 12:35:09 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 12:35:08 +0000
Date: Thu, 22 Oct 2026 15:35:05 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Zefir Kurtisi <zefir.kurtisi@westermo.com>, 
	Zefir Kurtisi <zefir.kurtisi@gmail.com>, netdev@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net 2/4] net: enetc: do not rely on mEMAC hardware
 frame padding
Message-ID: <kaqeg262ql6mucqzn46axaniowt35eq3hd52nefev2uvvkbfkz@6onteyxyjypx>
References: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
 <20261021145314.1435049-3-vladimir.oltean@nxp.com>
 <20261022093359.723c7e93@pumpkin>
 <euqz7djxfn4tqbd63ymcj2bnu7k2bb6hzlmeilao3rvjdhyisf@bk3wj5hinfnr>
 <20261021145314.1435049-1-vladimir.oltean@nxp.com>
 <20261021145314.1435049-3-vladimir.oltean@nxp.com>
 <20261022093359.723c7e93@pumpkin>
 <euqz7djxfn4tqbd63ymcj2bnu7k2bb6hzlmeilao3rvjdhyisf@bk3wj5hinfnr>
 <20261022112218.11a1faa8@pumpkin>
 <20261022112218.11a1faa8@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022112218.11a1faa8@pumpkin>
 <20261022112218.11a1faa8@pumpkin>
X-ClientProxiedBy: AS4P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::16) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|MRWPR04MB12305:EE_
X-MS-Office365-Filtering-Correlation-Id: fcde4849-59e5-4b79-7925-08df3038e85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|7416014|376014|366016|18002099003|22082099003|4143699003|11063799006|261009223027099003|261021135927099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	aoFis67tVBM2sssiZiKP1CpaHjRPqsi5ITm6zcK5pKSKBFOaW505Bq+pbracuMX0bgbbv7FLfl5G/WyJHUu7dxYJkXgV8gIExnYrT+Gh6+CLHSWNY/0pjkIh0ULZ51VHWyKxmJWXvzYqNYsALQZY3VCyeaHQ5ZLBeYMoyJLEPdxlN0gi1ABM4Q81cSoAFE08t+F8DaGKamtUoe5JzBJDNgzrWFp3BD39frk9S4CyEOjJQp1BnLyjomWeFfgSnwWw/lVihVRDx+35Dwwc8eCzbJcsoPPU2sVFY6Paog1Gfdx4D/IX7X9GsYFBWBxGQ6P1kkiHmVnFFb4xdl/DOfP/Gm2i9ojqmM+JTve4dJH/C4WsMhaWrdi5fVYHLc6m7aql8DiewNBNWGx027iBkO+8Zy9e3Vxz6RbcXJg293IM/OFh9pUxGq/ysd8eCBEtyDMgxW2ai/gCjt82Gez/HDD7serH8lN9k0+mAp+63ieSTExgmgSkNo2XEHB8hwKElzfetoeZFwQpzaKE13gbPqbqXZ626fVz0mElpPI3GHT2w5p+j3tU6jIkiTX+e1mK2RlA9f3NX6MoYH7GSkzh5W1XWMCHALYr5y5AgUqhV86ySJrRvJtPMoy/5ofDuTA6QKyS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(261021135927099003)(261021121427099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O9CVPyOlvZk3OTq5stXJKr9eErBAC4X2CGRODNIyYVeav1qSXGzAxwGVMlh/?=
 =?us-ascii?Q?HQyDNdriMYN4REc7A2HWw45sNKBq6YdYQH2lHimQtHjQg7yPznju0VkghJL2?=
 =?us-ascii?Q?2GQklxoYW2WiE954E0d5eSZzy7ijJx0hAc0AzLOieiqxkLLaBCjPXEan1f/u?=
 =?us-ascii?Q?zzlNZh94nSl5HgAdgMzh1LsQlun8arq8RaDvi4iFwUecArr6yYywlZrTycZv?=
 =?us-ascii?Q?+WSDImo+8Xambk2p24O6kKoN5WfhKBy7aTIyWo8KQ2IenzsBWy2pBJDs4OGF?=
 =?us-ascii?Q?JbF+EJ8Ld/wdGScNfPEyygxEZS8XBy9mMqyQwzPuahOZSPZDaarVXos2A6v6?=
 =?us-ascii?Q?QuP6ZuJoZwYnc6klio/9wR9YXQmt3I4RLHZwO6URnp12gLZqvcy4mBvD22S8?=
 =?us-ascii?Q?LcQewUNm97X0DDDC4MZ6MlfalOg+gQOjvSMeGAApNbR6GEcpCbj9IShjgqOz?=
 =?us-ascii?Q?CBLF3gemvOY/mJLvQX4x1t4j8AW2A8QpbzPP33SHJ4nPSfyNkuuOdG1Fi+/e?=
 =?us-ascii?Q?5MKgVtCbwFcAV0hDmokimKaLnIu2aOBWYmTMOBByAlRGhg/t6ZdukQ7B5Qbo?=
 =?us-ascii?Q?qh0uxYEwICBPAtk1L0tGkeYwZgmOMYsNBhvbhojmx99FViX9jXiwaJybhGyO?=
 =?us-ascii?Q?zF2yNzIbi+dp863fjJaresRs3jukt+sGejgjj8w1Mi8Z1T3iiuRF7OEPvzyu?=
 =?us-ascii?Q?cuXFpkr8V9spfBL0y/+ScaA8G17L9y5gyHQ+VPXOxPI9Jk+8tRhI/Tzu6Eyu?=
 =?us-ascii?Q?WyDhS+V5gLLjn1mPwJJMN9Fvi92l1TRhAR+6iaZcQJvShsHxY82zwHTWhZkL?=
 =?us-ascii?Q?14BuM1AoibEcV0jKH9TfEK8QNUnmWXEBPzS0NKPbbFLwASQZq2SdsiUIveDI?=
 =?us-ascii?Q?vGuH2TMwRtL0c6X4Gm4B03MwWGbFfwEmkOAGuAdJeyuP7ZMgtmzCATm9ykBe?=
 =?us-ascii?Q?RlhrcnC1vJf+bUv1cxK+TSDWeE3cav7gjK4JS3yeJvG4yHcarAW7FrOp5VCY?=
 =?us-ascii?Q?pdk40Jy4icaxkCtINCiwhHAZZgeKYDkyATBnSSzxzxm7frPq12i8CcR5qhYK?=
 =?us-ascii?Q?sV9TrLhy42kWJP1s7IsSgPsp41HW0HQxNaeuQldJWcF4OK8Ab2Lw1vxlRB9k?=
 =?us-ascii?Q?nWXXxwf5gbCu5e1qBevMjp3xOeLAEClSnz3SLWZxD1h3iDgw9qMOzVFX8G2n?=
 =?us-ascii?Q?USSU2XJ3/6BsSMcfqX5AIzsx4f/EYEd/o7HKz/VOzZUEgd/Jz716Kd0OxaEj?=
 =?us-ascii?Q?ewlmQkn3kVik6nyGL+NOZxr9Dmub81c8vgFfLa114o92Is/3btcJtT15OBo1?=
 =?us-ascii?Q?wQsRLHbXPYxg8nIrHanDyH9wSLu5SIEDBS7uLgdAmIOtavvuVtSOun8V2thq?=
 =?us-ascii?Q?BCDJlu/7ZPpDuygsSJJXVQyRV/FHs8/X+keZZTy768LRH6Fq98ywLeAqHtLm?=
 =?us-ascii?Q?jkwQRfByXxoRA33WtHLH6ZyghIu0fAf/3OoRxD5EzgmyNeU5YUylU6XbD3Wh?=
 =?us-ascii?Q?zLZMnTCMSdVnvKGQtLKeBAlJRmEA2tGo7C6oyxlPy8BNIWPx6AtSR2HKYuRc?=
 =?us-ascii?Q?S3tdPRJZcl2na8SQPj51neCgHcSRNPPNLmwbsjis2LdeJGkHWRL/wbpoMgDn?=
 =?us-ascii?Q?SZkBfVBYFHCYaJBWIkK2McbOPZ71CVIvFsXqSNt2F+WD58Hz5BT/Kusy/Uog?=
 =?us-ascii?Q?2RWo5nC0Kalcj6WZ3dEanm2G8KP0gNBoxOurjOYy68xMvXAKwvUbPksTkJpP?=
 =?us-ascii?Q?Hl7vtUlM2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcde4849-59e5-4b79-7925-08df3038e85d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:35:08.6477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFG4/n5KH03HRTeg/UPdqQmp+oDVqKDrIbp9V+CkQPgwcRkUAGgp39ndjPTTMGROL57VIqXqviIQim3cF6Oq9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12305

On Thu, Oct 22, 2026 at 11:22:18AM +0100, David Laight wrote:
> On Thu, 22 Oct 2026 12:41:49 +0300
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> 
> > On Thu, Oct 22, 2026 at 09:33:59AM +0100, David Laight wrote:
> > > On Wed, 21 Oct 2026 17:53:12 +0300
> > > vladimir.oltean@nxp.com wrote:
> > >   
> > > > The driver sets the ENETC_PM0_CMD_TXP bit to pad short buffers.
> > > > This works, however sending short frames from user space and looking at
> > > > the padding bytes inserted by the MAC at the link partner, we notice on
> > > > LS1028A that the first octet of padding is sometimes not 0.
> > > > 
> > > > This is fine per 802.3, which does not require that the padding is zero.
> > > > 
> > > > However, there is an unproven suspicion that the padding bytes may
> > > > come from internal memories, and unfortunately I couldn't get sufficient
> > > > priority for this octet's origin to be investigated by hardware
> > > > engineers.
> > > > 
> > > > To be defensive and not leak any sensitive information from the SoC,
> > > > let's pad all frames to ETH_ZLEN in software, so that the MAC doesn't
> > > > have to do anything.
> > > > 
> > > > There are 2 distinct cases to handle, for GSO and non-GSO. For non-GSO
> > > > things are trivial; we need to call eth_skb_pad(). For GSO, things are
> > > > not simple, because user space may set gso_size to a very small value,
> > > > which could make the GSO super-skb smaller than ETH_ZLEN;  
> > > 
> > > That isn't sensible.
> > > The minimum frame is 64 bytes (including FCS), subtract that, the MAC
> > > header (14 bytes), minimum IP header (20), minimum TCP (20) and that
> > > leaves 6 bytes for user data.
> > > I doubt it is sensible to do GSO for anything under the minimum mtu
> > > (128 bytes rings a bell somewhere).  
> > 
> > My fault for not being clear and inviting this kind of objection.
> > 
> > Since we do GSO in software, we advertise NETIF_F_GSO_UDP_L4 too, and
> > there, Sashiko came on v3 with the observation that for UDP GSO, user
> > space can set gso_size to a small value using setsockopt(UDP_SEGMENT):
> > https://lore.kernel.org/netdev/178960175550.22033.10648880872141935672@kernel.org/
> 
> I'd fix that in the setsockopt code.
> But that might be a bug anyway.

Why a bug?

> UDP segmentation has to use IP fragmentation and that is usually done because
> the interface/path mtu is too short.

In my testing, UDP GSO does not generate IP fragments, but rather, each
UDP segment is its own datagram.

Are you thinking of UDP Fragmentation Offload instead? As per
https://docs.kernel.org/networking/segmentation-offloads.html#udp-fragmentation-offload
this is deprecated and AFAIU not what this is about.

The docs do also explicitly say that UDP Segmentation Offload does not
generate IP fragments.

> But there is a minimum mtu for IPv4 of (something like) 128 bytes, and
> it may be invalid to fragment into smaller pieces.

I have no idea what you are referring to, here, with the minimum MTU of
128 bytes.

> > Sensible or not, it is possible, and I did generate a test program using
> > an LLM to confirm this.
> > 
> > Regardless of that, the last segment of a GSO super-skb would need
> > padding anyway, because even with a 'normal' TCP MSS, the skb->len
> > modulo gso_size could still result in a last frame < ETH_ZLEN. Padding
> > just the GSO super-skb, as I did in v3, would also not fix this.
> 
> True, but that is a different check to the one you did.

So what is your suggestion for the driver to do?

> > > But does this code allow for the VLAN tag that you forgot about in the
> > > other patch?  
> > 
> > Not sure I understand your concern here? Is it that with VLAN TX
> > insertion offload, we pad "too much" (i.e. to ETH_ZLEN, then the NIC
> > pushes an extra VLAN_HLEN)? I'm not sure that's a problem..
> 
> That is a problem, VLAN packets should only be padded to 64 bytes
> including the VLAN header and CRC.
> However such overlong packets are likely to be tolerated because
> an ethernet switch can add a VLAN header before forwarding a packet
> and it can't know whether a short packet is padded.

Well, if it's a theoretical problem but it's not a practical problem,
I'd prefer leaving it as is.

Since eth_skb_pad() itself is unaware of VLAN TX offloads, I'd be
opening myself up to an endless rabbit hole ("why didn't you fix this
in eth_skb_pad()? It's a generic problem." followed by
"changing eth_skb_pad() broke 20 drivers!")...

Unless it's very clear why I'd be doing this, I'd very much prefer not to.
