Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05A3E49F7;
	Thu, 27 Aug 2026 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820942; cv=fail; b=VXkptpcTfNynx3zCS23JaQ88Go+tZPYrVmpPRTCD7yHO4XvwlEhUk3BK1CMg14GtNIRzdOc3RAdHMkHh9mlzIDtK7neuu3HBw5y7O3GODjb+/A90X8OfDaIlRDXH1ZQoNbkd3FoNCisg4+W30vI8o+NGBl7DFtGHPfNwxhYbSrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820942; c=relaxed/simple;
	bh=XVc9BGwdGOoQZHg0sfKBsYVxaSwQyq9UJd3aOmtvN9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YY4IsMDQXp6t7L/lEJThlaxzopBoQY+fO8JkwBWIc6K0vwLk52PiYh/UnmZN3ezTNZfKoBMBHO/c/dEgSFoH1UjdD/+BAc1esb3l/0RSglrQaUkWYwNrQuO7WlTE7qcVUBFkEzy0tW4v37HiqR/2qmIVybwNl7aSeATRGGCzcHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EDhzpc8F; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EDhzpc8F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrbFltDGQ7B94sBJi/nftjLQrEA9UTwinOqPlNS5vonTUdcMuJ1COwPgwBR4rQlhTuTkKHTUIAYFULnBBvMOLvNZyaNp/7E8PY7ZKSZSYJb/XyDI2r+3XJ68HMZzcZwqJFiDow8rOgEDbAcF1UmvzbuJ8+RHd5+vW7oWXo02eUKrcK3feKkzwW/DZvu64aAqENYlAO6SpQzcbn3qEGEPht1aXZYuGNMJ07bnF75h4frbaygkeiYf8gUvfZ4eFwoY4a7it+sL4NQZ+K+LHxEjE6GYRM1C4lyx6MDuz12qFVTXya/TlysScv1TSUEq2SZLR0EvzU33p1QQUqbd6MbyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQChZYZOdd50Gb09LwNlW4uu0GZjfDqu9kM6lY+P98w=;
 b=VxXlCe+zSFESfd7XI5Nq03mThNigcJyyDRskQgQ4auLrNh03HphdWyWprQWn7FXQRjsMGi0dowOmA30kpf55n7NKPtJLqfqcry7aY9EOTmRMHDnCoEalJh0/oBj0Zz6K9POg1zFWhLbgqsFCzuxwYcTF0x5W5FlugV1FfyRketML2WmqxGXzUjSGKAWaSz1EHqC54z2Ujlts4lt8KAmR13+2MpPMpEUzyGWX43MbCwOTVH+miDT6Spu7TUhl870BTmwLQnKBwKZ9xov3ZStj1DTxP5/TIx3kHhGFbV/YFhiUngHKw26iPCmroE6YmlAZAMWAbphGs8KRUAbcxTJZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQChZYZOdd50Gb09LwNlW4uu0GZjfDqu9kM6lY+P98w=;
 b=EDhzpc8F7w1AshVIOId6Kluzq9tcfHhc70QoX/VLQ5hlJzty9cGzpAjkv21N7Md3EgQIAgJZ1FiTBNvYhvFXb/MG8jqKLYkNfYY6pYj2tRTb2dNlmQ7mL1jObyfAtZfJsY39XPdXL57EDxkKKf4rnficJW7dMkUQqfTFk9GfZlwsaLfQLmcwaQLL60S4oKJQaCgXcAVVei3KG9JKlt6hkXKNeXcrmOG7NiQbTgUm0sasbMjXGWNXByvsuKclpavj6XYERkS1CCSICjLhDsfLI3fAXptslg/jkWvguo32V+tmecLTODFVcBfOPShEXdbMwG2ciN4zjgl8AbZ1wjsnzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 08:55:37 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:55:37 +0000
Date: Thu, 27 Aug 2026 11:55:33 +0300
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
Message-ID: <20260827085533.2a3ocp6llvhzczps@skbuf>
References: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com>
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM7PR04MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eab3a4e-a06f-401d-684d-08df0418f66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|366016|23010399003|376014|7416014|1800799024|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	neIaSRAhTvppTB53kt9NA/U4Hg/p8qRIq+xdHqKhuBAYskHEDKQXZOOtQNGCB6jRkv3w3RMAUkRQfDcwrr01ZVXbM7P2xiJRq4R0ij5/MSDiv5XelR46ao70BBr011ze+DJg8xddmOYrLMKvrnvciN32xx4GkIE0/qc/gEet3yzeFmVY49p11/nYcHAPRRyGwaMHNlcsRa8zQ5pZJVQvNDKjqbRGlNbqocB0kmgWTUHiFa861Sbl3Hf6HWUB6XN8k7G9p/InX8YB2QgzFJdkEZzib2gfm+kogpASySiRFyuECvy/W++X8faNL6XG90fudffU3XfUFtfS+SUd47mP4F2sPMrQ6THTvbzWKUs8k89mVjVs5XsR86AnZlCA+xTrP7ODJ99HuUs0GivG9QTkU2gLa5UTWB2HHpZtA+JPTGk8mbN6NbiNhF0/Mi9wFmDVwyyvgoRVBNVhp6hnw5TRDURehFsXvCUBcYYL3ZeaDvD4oy5z2plmVRCuXVTBjBN18mU0AIklVpUEON3ZMaqx88W+Rdagsa+i4FOSrNH7gnLA7h2QN6ouxBQ5zK0j1gH1hueA9bUwjDWDw4UblX+cQS0oSkVHAJGCO4Px/Yydh92S9zUEsvPJacc5CRkkwWvht6n/UkVCPEoIhbsqPQA4jLiAPRRPDwI4x+vbCdE3bq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NO+oZRHQPC8rewHDOTbcRAOZ0748c58qAZDCPhp8AUyjTqODOfo4MVryzjaj?=
 =?us-ascii?Q?LaoUn/7Cm6LbPN9jpPhMccr6Yy5s/yoZxp29opS+53TVlHdichysJYMPRVmL?=
 =?us-ascii?Q?gZdq2TekyOM+fEw/Hgy8QU0oww6QkN2B67nWxAGSaHQ8mrTwjf2ZDBxgtGHB?=
 =?us-ascii?Q?m4YJDeiyqt+TTPSdQk8aSDc1ZXrQPkPQwxDWISavRCGsEZczwlbzFCg1Lu4Y?=
 =?us-ascii?Q?1PFBYSNiTJEnxpOMs0MDdMLPEb7IxZTZ4K77Bhd5iGJEgXd4k0yb3NASHAR3?=
 =?us-ascii?Q?gbHGflTn5M2c0Ki8Y9ncpqIFXdlTNNv86+p5h6x/XeV4RV0Z70B9ykZLhuYP?=
 =?us-ascii?Q?SoGbIp68Lxwp+hF0AGqazqaqe037pe0MkJJ61ObAbNOw28ftorHxcrJP3Hux?=
 =?us-ascii?Q?S104SBufSs8FvMCPCNpWAUuwJXu+fm4o4Gvru4nE1GGu/zgoZqLDlLUuH175?=
 =?us-ascii?Q?BAhxCvAtRcDXlNusVuMWqe7mz7yzwGcftKX/TPEOYVCx+w2F7eZRoHziRLo0?=
 =?us-ascii?Q?PCDiCxdBuXMRp3EDT9IarxjZkOzhz9GrIapSoG1AvV55OBkvzGR7Ie/jycCA?=
 =?us-ascii?Q?8WBeD1WL0aN6pH99YTidr3GUdfRnt/fiZHooAGfpnrKOhJ2Z616kZdX54AzP?=
 =?us-ascii?Q?zae6Ak/gSV0q41eSX9ezMVStQGq+vCLgY26IpTd8MciKB4kWjehllXnYBF5g?=
 =?us-ascii?Q?qwGGSric/65ch8iG15zqAyNIna4nQizK8PvKX4wrwhmoU69Rn7z1Od+VPPu5?=
 =?us-ascii?Q?2hYoj+f0EZElZQDgezmV0vDfelqXIuvu49ncGMCEzI03klJ7eesWTAL2DKyc?=
 =?us-ascii?Q?im/hN8rYkUdVLFt8Ws4Mi/z1fmJjDz6sJsmAmbsMUc837YzdkIKtSneqlMS4?=
 =?us-ascii?Q?L4MDOdtxB7Fx/E4kAOlDDHyeMmzTfYZ6b06uO03tdIbQmBBmpzqrAcdEmbmQ?=
 =?us-ascii?Q?NlngbOWR7t/ZJm/f82ftP1gMy7T+LQlcUqwksKyjS4WgXYHR4KLRtYPpdzQV?=
 =?us-ascii?Q?BvdlFfdG8KkGHMO9SEJRFvDjKaWmZxuKq3cDwg34KQhVZonLFL4pvQBbdam/?=
 =?us-ascii?Q?iGMTb3Q5fiGe6W7Au0EcyqN1j9sQj45JrPFtfC4VhFKribNat4M0HHZ4CBAe?=
 =?us-ascii?Q?r/a3eVSD3Mui3nl+W4xc0ctQBpK/AASVIo/xa7ohzHEiqqRD9K3tkcOJZ/hS?=
 =?us-ascii?Q?020Vp+NJf4lbDubwVTCaoWdbm25QLb4N3Aq3WLQQacyc77+/hAGd6dWuBFYk?=
 =?us-ascii?Q?k1f6hpFvFq5l6QsBt0kHX5urp3DOpSQJz7/RmwkQrtpUCCVSEHQMzVn1RHz8?=
 =?us-ascii?Q?r4yJftEGTB0zIvA+DdGy0SXEzjawEVetrOqme/Nf1tamBlgtCJ9YGq8R0CMU?=
 =?us-ascii?Q?YorFxJvWbYnHdxYu8WFZBEA/fQ5lxhIvBiAYr3YYkDe8Lm7lwa9O9RN2Ff98?=
 =?us-ascii?Q?v+noJOweh2pSxvLzFWUtjstJnki5/QswB6PPKpW2hSqZ4y7GLtK5asyMMZep?=
 =?us-ascii?Q?+iM2OK5Gms3FaWioV/zvqTykQ7ByZUdKHYA0U7u8Mt5ZLd9EWUTlUp00PZ3i?=
 =?us-ascii?Q?K4tdlo6U2QYDbor/Rd7Q6EKd4UFAjmulZQCTRh7b0vVgvP8Vdlm1TqTbd2PC?=
 =?us-ascii?Q?L5sxLfgmA6XRWKFZMcEYt2nn/K4Y4h+owa85Vz7k2F0Dld6mT1RL3VHkyl0j?=
 =?us-ascii?Q?DkOpYx5/h0BcTz2n7GeFwkOkV60zjzdwYzhlredi/vppPGhwMEk7rE/2PdeR?=
 =?us-ascii?Q?EDxyt+Jj392EbN/zhRQ6Fzz8b5IcrsfN3pu0gOEc5R1qzpbvwORUcTTd5yyI?=
X-MS-Exchange-AntiSpam-MessageData-1: +ihG4QehBSomw4IkeLDOXsLn7tF7/gK2HAI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eab3a4e-a06f-401d-684d-08df0418f66d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:55:37.6787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4LGlgsyQiEV7vibXdRmfFOBiLNRWtqDJU1ZCd9nXZwLfh6L3+qLLNa6W2qGasJJdptKGwU5CtDxdFKw2N8BIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886

On Mon, Aug 24, 2026 at 12:36:12PM +0200, Patryk Biel wrote:
> The Lynx PCS USXGMII setup programs the replicator advertisement, but
> does not explicitly enable and restart in-band autonegotiation or program
> the replicator link timers.
> 
> This leaves the PCS dependent on firmware or bootloader state. Systems
> which do not get the USXGMII replicator preconfigured before Linux may
> therefore fail to negotiate the link correctly.
> 
> After programming the USXGMII device ability, configure the replicator
> BMCR with reset, autonegotiation enable and autonegotiation restart. Also
> program the replicator link timer registers with the values used by the
> ENETC/Felix setup.
> 
> Signed-off-by: Patryk Biel <pbiel7@gmail.com>
> ---
> This is a follow-up to the discussion started here:
> 
> Link: https://lore.kernel.org/netdev/CA+DkFDaW_wJ5p9_P7pMpz-8iE6xeKkdF-MQcd2m2GcyVUE3S4Q@mail.gmail.com/
> 
> To summarize: on systems that don't rely on the U-Boot Felix switch
> driver to pre-configure 10G-QXGMII in-band autonegotiation, the Lynx
> PCS USXGMII code programs the replicator device ability but never
> actually enables/restarts autonegotiation nor sets up the replicator
> link timers. This leaves link establishment dependent on bootloader
> state that isn't guaranteed to exist.
> 
> This series only addresses the PCS side of the problem: it configures
> the USXGMII replicator BMCR (reset/AN enable/AN restart) and the link
> timer registers whenever lynx_pcs_config_usxgmii() is called, so that
> in-band AN comes up correctly regardless of what the bootloader did.
> 
> It intentionally does NOT yet remove the "only supports in-band AN for
> now" limitation, nor does it wire up neg_mode-based configuration to
> support the managed = "in-band-status" property being absent from the
> device tree. That part still needs more work/testing on my side (in
> particular the in-band-disable path isn't behaving as expected yet
> with the PHY I'm testing against), and I'd like to discuss the right
> approach for it separately before sending a follow-up series.
> 
> Feedback welcome, especially on whether this is an acceptable
> incremental step or whether it should be bundled together with the
> neg_mode/in-band-disable work

Furthermore, you don't need such a long text under ---, it will be
discarded when applying the patch. Fold whatever information isn't
duplicated in the commit message and drop the rest.

It is acceptable as an incremental step because logically, it is a
different change compared to also supporting PHYLINK_PCS_NEG_INBAND_DISABLED.
No matter whether you also submit that or not, they would still be
separate patches.

I guess the more important question is: do you also plan to submit a
PHYLINK_PCS_NEG_INBAND_DISABLED patch? Any problems there?
