Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1294841DED5;
	Thu, 27 Aug 2026 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822339; cv=fail; b=bVL2Uw/1hYmWbYIaWhTiTL7kxOtAJl7XS5pBONBViUkCJYGmMJyfvQib6jPx/0EMvxix2ZdyzdBJUJ07hDdr6ZSwTbktqYNYG5kg0+DrKaxbPCKLv42JK1DRzCRmzeC+Uddf7mVUXE0xV4AB+zbnfAk4o4pv+AWg6hyKqp/PkCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822339; c=relaxed/simple;
	bh=T7ra2ePoq9vjaJ8zmAFKmsi09t/FTN9abfcvgbCxPYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d6ypJwCRnV7qNFb9n2G+IhF2SX96RPSCgpsoYkzHJ6VvexzksuelLgOs9pxi9IG8yUE7r8BQChDdCFehvLlC5L5E3j3F2bZIoTRw8eVG24mcB2aDDypGEMBQLH2jugrzz2KnYcctBMi5tw0ciMjTEJ6TKmlypwF1koT93Prig6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BLbGeucP; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BLbGeucP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkvwZQJImOb+tHUijgx8aoqQuLtZcc2pqPrW6wuiMDbWUbCNYJroPGB0v1/aA+jjjuWnco2nFdpJ1dOD9z3H2GGQM6SYO6vHzZy1i2jZ7zi1TGetM77jwKI92diai4DyZtjvfWTf8rlZ/DN7/9zFchRuAayoD1i6U/cS3hQfWWCAVBrOn38V33bgxWhqOtUlK9WDo943SnyGmuGtzMY/P5OS5kVqTZlti7oLmOKGhpH087PDRQaFT/gzUdTqiZWBt0teQ64jQyaWjRngztyvfa6N0v8C7UzuQPNLQVvwbF5g+oC7ZrxcGce8jxAHZ7Z20tsdKHpATBPqRlKRimvhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7ra2ePoq9vjaJ8zmAFKmsi09t/FTN9abfcvgbCxPYI=;
 b=RqbrF1OSx8H8na9nmAczVcbk9Nw1aWB3pe7lmgMHdgI15xBDuzQGPtXtH75bHhQiU0YMy3KjkGx5fLf3R38E+ulH31oaWO45sLA9W0n/PeUm/9WTwJNGPbSmsToJcMWK2ozsHjm80zr3/w5zn+Cma4Eg2tM6gBc/3BmRZVOiRm88QpEI+ya6aGGCSR+Eh1jnMxZaSyMETWMba8yhtOOfk14r6mZFrZyYOzeEFxebMaiZdx9Ph+JoyCJ9B/pkKSaNIR8xkrow+JSri7leFoxfM7sPUgWXeO/gr3p2Am3ARUlS0Mfpkt3JB5eEnPaNVHMa9eQPcgDIeHypcnbRCVUfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7ra2ePoq9vjaJ8zmAFKmsi09t/FTN9abfcvgbCxPYI=;
 b=BLbGeucPa2NwwNUOojh1WerYYPCqPli8lmR3roN5nVs8AHyXi3TizgCPbhLeVSw//rmej7hAOwQVMJ4dIet8cduFNF5+8tzwh/TGwlMPv3z1GxAOnGoALA9IKwHdrNPPcVKLT2PBEHKe3mMJkiTyasI432orBSyepYMQTrtjhxn5BLsbQy2EdOI4AQa+t9ABbw2o9/L38Ih2m5vYYL5Adskf5uBuPw7CJmt6Qbs425SEMkKFr03O6fLQnOYt45pkDGZkzoxrbEapOgtEhVVTntM5f2eV1iryLcGoZXKEUBJQz3BjDxV1TewCEVJpcESAd4BMgX+d2+8IstjL9agovQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU2PR04MB9211.eurprd04.prod.outlook.com (2603:10a6:10:2fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 09:18:46 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 09:18:46 +0000
Date: Thu, 27 Aug 2026 12:18:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Patryk Biel <pbiel7@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: pcs: enable autonegotiation for 10g-usxgmii
Message-ID: <20260827091843.ciajpqeh32ikqe3b@skbuf>
References: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com>
 <20260825214928.rz52tysloa5yxq2y@skbuf>
 <CA+DkFDaHQVE8g2iDUrSbRcY6-xihJQpRNommh57B8wRnePZa1A@mail.gmail.com>
 <20260826153634.ygcvnsbtc4ibpp7f@skbuf>
 <CA+DkFDZLv5BS7z7MEV_uBFdNgfrBQr_nkzGa2q6BKx_F4fU0xQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DkFDZLv5BS7z7MEV_uBFdNgfrBQr_nkzGa2q6BKx_F4fU0xQ@mail.gmail.com>
X-ClientProxiedBy: VI1P195CA0080.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::33) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU2PR04MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e1cdc4-a993-4a9f-2fd8-08df041c3292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|10070799003|7416014|1800799024|366016|23010399003|56012099006|10067099003|4143699003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	K2uKsyU6GU0RzVd3c2BKFOBRkCvYkEcrK/37MT3HWDbh5Cwg/qNPIha+6OScehB6DjPrUKeWOwZBKzoEATaPfPk6fNqQrGh53/C2fEGw5XotZKJB8uQoCQ75i09AVphf5JKq0PSEK7qCrEVX+BTNnEtt84fhSIk+vbZ7f/gTE65b8eFjd6MCCB5HvSNJaW2E0AIGqw3XpORSqDZtUrCLdvJingNFe0DX3sM1eoxFijLADDgV1qaldFi8oCIvSYuu5QtZlQrkaM7qczPLuh8C1gL+ecqlhK7HMBoQC53wAun1BfaXHZVQ4LdLWF/ULa7SPsNMPOuOmnXiCkh+/mJx692gsklze0j8Fc/aQagUAxwkHmTgaUk2c6NIZ/RypbMrD+0B5/wS8nMkVo5RKG5qtak5Fd1RT1ASfx67VYdcRY5J+/IxkSpdZY5vOil1V51+LPYfXG5ihy6Ci01EqXZfH6VXw9Gy1lhDXpyl8KQndTugsp0UEinoi2GAG3RqFpHMdxvtIbm+dM5qVL4PYeFz5zQUeuiahgJeruZ1eoM2ji/+gDQ0C0jIWjWZKsRF6sfPOLndzZfUrZkrQLI64PJoDJSoGj0UAIs8M5T7xqB6SqfZQV5rtA+HiLA3u+Bwrswf2adGhS2+HZW56vFJYP4Gr87E9zr6XnODqftuax5CfGM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(7416014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SLcIHDa+O/HUC37paxOhxkOpivnPpgbxMp7EGww57vcEsYbcrQxtJEWaZ5PN?=
 =?us-ascii?Q?4s2X4sXPlZeykNmaCtNPcVUkhxzfnhuaRh5W/1K4T8lSBPytKLZVPQyK+yjq?=
 =?us-ascii?Q?GK/tfpkPc4Ls2CjSFZm8vGn+z/MlmYCuC+oSXDtYVQUKzzLpbSJff2ROHla/?=
 =?us-ascii?Q?DS9HrdpIWT8IwQi4j8onBEdXIF1Pcus4D+kzUulbjBunNixVcxbpnZB2DYZJ?=
 =?us-ascii?Q?AdiAFxDR/eBvwZK0J+AxdQ8ePD2VgEW7xvuKYS3PJJJAJ1LRdRQBMoK4r2Z+?=
 =?us-ascii?Q?W8WZZqrmqLZlcibXq8v7+CskzuuqiDhe2AjqHvXbtixvwmllvRglxvRnGq5A?=
 =?us-ascii?Q?rzNHGabNcIdnGXtzYYeyltQFhUaFu55d43mls3nX8SbJeR0PVte8HiO5aITu?=
 =?us-ascii?Q?QJlbcgxTpYXHEvUGXrQSNpL07KxiYBAz7POGZbLccyckfRubootk7Az0j3cI?=
 =?us-ascii?Q?upu+RNyZjDA0DJLBug29Kvrr1EiGFFu9hIxnA3lVtrl6l7W4GT71Tizcj148?=
 =?us-ascii?Q?kSc2oiihob7BxsFR39OSwLRJGIJoqiJXli0wcl4M6J1eODckVHFKBO7SOgub?=
 =?us-ascii?Q?0KxQqSS54bP3f9aQmgVdhwjYMNOOMs8N7eGMCDfhwOiKpjvwjb40yMhbvyml?=
 =?us-ascii?Q?8XUoL3PpimXv0Rq9fTzl6kpkDKn8ClTAKuSUvX0K+YvOBdXOa2OrnIMxb/OX?=
 =?us-ascii?Q?iElICQknd5q0sOgYNXkgCLzzd7mYA4hNJlm59F4k6MHC7OOumj9r8KriApfS?=
 =?us-ascii?Q?hso2lLtrc1oqICauxiz2fQQ5VsKybrWIM/Z98gNzVQ2N95z8tPOdqbY/NrMZ?=
 =?us-ascii?Q?iO6dqjWKCxMc4giEO95VsGj2t4lkbwN448Y9JjmZI8MCQQDX0v6hOkAr5kgd?=
 =?us-ascii?Q?y8JUaHDEtOQP0ywnr3+pPetwO8YZ8WEPbTnXWY6NjuJSnJYidFXFcNVC78dA?=
 =?us-ascii?Q?psaN8d9JR5SShU2TwSkd2yvQahgEDXxzpP8aClZJ6nY9v7khmvwUjjG8j8m9?=
 =?us-ascii?Q?jTY+Qh1p33TMaPSewh5tiS5QoxPJhk6/ldT2Q9CpPhyDlsMY21XyC02pdl4V?=
 =?us-ascii?Q?42l10jYlqJBgsxqfgnJpNt6i4rFeJdGLYzk0hDwfNGm0uVBLeI0Mv7YUKO2q?=
 =?us-ascii?Q?gk0HLnlV8wSqSFYqiKK/IixHvNEZyxMMCOd2k2Y7yJXVqbJ/l93kRtxnr+yP?=
 =?us-ascii?Q?225/+kE7vYJujeq9/3mKxQ2DLq8nCCB7YNsCRgTa03nU3eRvLzmP8Soof+07?=
 =?us-ascii?Q?zFrDQi6O6NW6POAMStoqeqUPr4yPMR7cuegQpubIJlpCiMMcSFUHEf+/7TJ+?=
 =?us-ascii?Q?RZiTtCHYqRParg8Q0csBLHjrG/C+lsy2brWkNarKVaQJF6WVwLjMe+SZugrZ?=
 =?us-ascii?Q?TpdgDdVMp+CInNgVESm+XmQ+r8/0KoVKf9k/OPG6Ywj11ypaPayWDga+9h7E?=
 =?us-ascii?Q?7XcqbBS/tSD8dwG1YUCl76r6N7Kgn9N0MZRUyQF20kkPSe3XEDOsCtspJA62?=
 =?us-ascii?Q?Ng/tZ6KBWkW4qhYJ8pKm4yEViXA7I9oCffesZVxwYKx/+LjyNg+Q+BxjQdjO?=
 =?us-ascii?Q?6J1qqeTuxBQPnqzsKSuGMjD73zSqOjmKjbuYDdaTVSoDqnHmBfuz5iPUmtLJ?=
 =?us-ascii?Q?LTLRwnMa2Li+cBLsdDGgxoLQBj2Q2mAEj+QqGIfd3D/gX+LgPo1uUJEgkzGU?=
 =?us-ascii?Q?nvSUZhga2DdU34hfwMODwDeEdHkms22Ciu0oxvBj6qLefVpWIp5mLxNtd7ME?=
 =?us-ascii?Q?p9CrJRkDUaAEuNqt+mGILAe64sV9gj5i5TNHCQsc/FkYhYOwUNJuLWUVHlrY?=
X-MS-Exchange-AntiSpam-MessageData-1: w8eZIUGx7B2M71yeA1Td+zf5qD0xWnH34nE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e1cdc4-a993-4a9f-2fd8-08df041c3292
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 09:18:46.4785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVvLPb60L/nJAgSMbtj5IoJjAfFOCovYMZ9aAGpRIW/uAYr1o14cozHcRWn5osxalpz2hd9SNv4bpRf4uuxTiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9211

On Thu, Aug 27, 2026 at 10:59:40AM +0200, Patryk Biel wrote:
> I tested it and it keeps working fine. Logs below, but there is
> nothing new compared to the previous test.

That's great news.
I've started a discussion internally, hoping to get a confirmation from
the design team that our documentation is indeed wrong.

> Given your other email, for v3, I understand that I should retarget
> the patch from net to net-next.

Yeah.

> I'm just not sure how you'd prefer to handle your changes. Should I
> fold them into my patch for v3, or are you planning to send them
> separately?

No, why would we introduce a bug only to fix it later? The AQR412C
systems must continue to work, so you'd have to fold my change into
yours. Per Documentation/process/submitting-patches.rst, you may use
Co-developed-by: and Signed-off-by: to also credit me for that part of
the change, if you wish.

But note that net-next is currently closed due to the merge window.
https://lore.kernel.org/netdev/20260816155953.072d73da@kernel.org/
