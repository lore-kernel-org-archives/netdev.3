Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D021257F;
	Wed, 29 Jul 2026 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289976; cv=fail; b=EchH4FPyYYMVahtX74NeUVR8wE8tPPt1iBd/ayStY+plj24RjoWQIfWOqY481uGFu4ULdE1uxmSbSwuU+xrgBM31XDegRrvnaQk3X/aUg3Pqelyk+GY8+97iSTmXnKEWNm8fY+S0b7i+2naWcRm5pDNhlJCjwm3kKutBb1CfDOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289976; c=relaxed/simple;
	bh=GqwvbK/5THJyOqM30+3trp13tlBbppH62BNs9bOFwTo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FDEoixqibvLo44c68cTbcMu6ECv+XBknvxRQDuFdsCFx8OKaAYC0m3IIt3Z3NkPUs2nzKPphDvoKt0ABBjWYiU/mhbcfogf2hwqjTSVFwfhmTzE1qWWRvdiL+rRbgN2i0G4baaJhFtWJP/89O5YMdRSTRhZDGnFD31JvWr4cXE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MOz0L1vW; arc=fail smtp.client-ip=40.107.200.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MOz0L1vW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUQY3BXHAZJGxoXzBtw/MfDv1a5Rg6BwaLKA/hWglx57h+hdqi33bnVdrc0BwJOkRCaRE3u/GtTfHTsV6vQfzFhfjyOtWbMhz0PcqvJPGlbhh8Ik7E3YL3JjsMsmoP/idN/chD+1Y/S6/f/GkfET8P0Uaz6wS1nZ95NZyTzpJ3dh+bLXrgHqd8cRAfjujSy0JacHMC4RsluaHEM0v09pfco17ZpkYdee8eKf+VQ4VttDEU4bDzA3BevqvNr+AZvmjTdpkKZrynHTQiz4A9dpmEwBAPd1B9eryJ8oHQubxTGfovxZMmyeZVWlOkiBLnB1LvWQpr/Cph/r5Y5tyO3JzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYX+/9vUi98w2/hSw+HGybUDhZ5LPhYi7kG5ifOGwRs=;
 b=Zv9L04IkIH0WKLx0GkKgZivAuN3BicWvbFYVhukec5BbqqH2bR6GW0NoWLOsSaEGVeVOJX1+n08oNqPVOCDSKT9MFtsttUwyJQh4feVQsyLX5njYCpWnxbjF/fxqx2Y7AZHTYG0NcAAICVdOPQaVM/g/xB2QGCK8AUcJPGajqOIDcMQCoty8IuYo+EpVT8zLhyNu2UXipf5eUUFJUDq2N/ssGtbaqq0Gna1hRQUvtOCdx+Cz0J4yLRK03rHQ+zlDc1+gprueOmd/4/50fPRSzVRyhjFOZnroMmioUZicflE1fanI+ZA+8PnME1SSKoqTfeia+QWBw4OCvAJRCbuJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYX+/9vUi98w2/hSw+HGybUDhZ5LPhYi7kG5ifOGwRs=;
 b=MOz0L1vWIuFRCLDj498g4KdpPnMD9yXMJdFGud276ueAExvfguQA+ldCxlVfnPJt3auAkiwyuYSJ3rvSn3UHmsQ4Fz+U4b7tMFqM5JWL5zimnCGCpeWx0Z9f2RNETEGmvtNJselCj+goUOdhZEmLaZAeNo95/blX0NiYgVAlFAhDvhs5+pRYwUxiImQJf23yo6VrMOzHFojjUziy+5Pbq2yg+3qbLmMKhikau3DXqxFk0b/J91j/TLFc9JOzW5RJnmSrVlzSoPUagg6DbqAybTWSX2FqSOcAiJIPRuxC/otm+BASe2qr2PH04iq3lCRvaOZBlyWg0D519ZtGQjwjKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MN6PR03MB7550.namprd03.prod.outlook.com (2603:10b6:208:4f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 01:52:50 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 01:52:50 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: stmmac: fpe: pmac and fprq fixes
Date: Tue, 28 Jul 2026 18:52:44 -0700
Message-ID: <20260729015247.25774-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::14) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|MN6PR03MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: e82f30b4-65f3-444a-b4fc-08deed141823
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|6133799003|56012099006|11063799006|55112099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	K2US3yyv5uraHzfqCHBRvNjYH4G5BXDVDB6F/W1s9KiNW6HBjP+SiRPYFe/boT4/NfZAr4PxZoRmlKXMHYXELC5JbA5yBirFW9GvWuaAYgJuGJ6aaCk/Sj8OiYLuQf8gTH8MaUedBH+s9yJDLRkTdBEdtaeasA3doI+x5LcdwmlbM05NpBe7jtCza3V+auVQ1ib6P7D+ZXbfmnreLzYi2ixr7dCG4fSNk/o+T+qOZUuY2zngvecU6PsD2Q6o3rEY8PGz+d/Lo87ae18WBCoYlPHXuzsX7Xc7KgaDYvCO6VCmcltLelEsMxNOCscaqL0fJA8NcZzNJfXniqjltjFkv3Y1g+isoeAjYAyzwenEl7XGFJkwJLzuvezIyQUVk2b+2MOKX+G8mj1o9TCsczfBl7y8ZXIQYkV92GYZp/k7Y4AAPsj5VrlxpP1n2lOsQKx68G+4hal7WCac7rxxcMwlqAWhHpX0LuYUgiOhbXg2HNzv7CekGEmuM3xA/4/mUdk1Y99NHbfmb7BwN15s3YAjEMndIG3e9ZvlIG6C46yLGa5Z2AIEI2jWbDG8HwTJQETbe9vi0kB9V5DJrByV4XK0INZTq6n8fa2AgPX5rfJ1I233DRD5qIK/uMaeDsTFcMuq3vo7iYg6qtW02adJ5nAl7qAvNzVumL3svmhuTN3jiAM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(55112099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AgPIbqQVXBqi/gtf9hTNdQzdphKtMZMQCH1iMJFgbLdyA50xZCgsxVwDTqC9?=
 =?us-ascii?Q?JMS5/xIaO0LLhSClztVsAL6l9bgLcdXzKxvbtUxPBKwnCTdPnYWFQ4slMqgG?=
 =?us-ascii?Q?FZ7UU1DAHhKJL2FEAS23t9H5VAqXIx3c3i23gX+yiTuQA8Quc7p4zRDvUdCZ?=
 =?us-ascii?Q?aMKSkOLLQEIkugG2RfeYLYA/E9ycYNXkLS/IsEx44VfhO47YtrY+gDqYKG1R?=
 =?us-ascii?Q?5SaiH+08jFqEFIGGW0iDeTvyraYPGhHbCSAoorLuDm1KCJ6Kcm/XZ8nnk+TD?=
 =?us-ascii?Q?o/8kL5YEsAZ1Mu3RkUtZFMCcDVUfuCiuKYXh3ilkcWEovB+CQhk/jqzQhs/U?=
 =?us-ascii?Q?ELYqisZmrOeVHcNw+kUn5WU8jTEoeRyNMg9yVG0quiC0cvGrQXlzfJsEemPg?=
 =?us-ascii?Q?Ms3ut2BPbsYNMENQHGVe2/8GIeb/ELGeRd45MomYiUViJvk/8X2LWprgk1zI?=
 =?us-ascii?Q?LVWgxPtM/LQ91jEn2DkNy07/3q7Ik0qmbqU/Ht/4KtIXCiyo074sNPSFJCPU?=
 =?us-ascii?Q?VlpEy+Mq8WlB20c7D0NmKJM55IIL4Sj7A0qvLpnSPJTG36ZhvN9tuqg3jZ/+?=
 =?us-ascii?Q?IKCEexk5xi9ru4JtLweBt5x7ewhbPkcn7Oco9Q1tPikiGrOCH/0HOZ7wEAOb?=
 =?us-ascii?Q?W/z+nCU6fwVHDF+U0+GKUxtMKG9zrmlPlwj6L3yxMpCiMtPzh9AeAUI7sRzc?=
 =?us-ascii?Q?Hg3JMnvPBTkXvXs5Vkf81tipSwOaAZ7Pz7Y1l3uaMzwGRZIsWGp1C0tn51p4?=
 =?us-ascii?Q?AWHLvMrLz6WEdGPfdeX2z2x+Xi2GkLblCPfYpE8YHXOD24xIHjXHDa2lp2Fd?=
 =?us-ascii?Q?CZPCK7umjGwCkkQhW6ByFcMJkgEsKpaX6/vWkGDS+Dy3auJA2Muuqvsmb5gC?=
 =?us-ascii?Q?7AyQzXmaGgEIJFeBIy8eYi7goPoG4LjBeweUyes66/CK5AL4rWQhFhfUMhZ4?=
 =?us-ascii?Q?j8fg1ibpGrYmwRYQ9I+M1l3Q0TR84YqWTft2hLr1q1e1MVciDV6gmgPPclhr?=
 =?us-ascii?Q?HbBFNU0VnpnIYe9xNvBugAXaC3KCQgZHzAirAia9sWu87d8cHRuIF7zxNvBw?=
 =?us-ascii?Q?z36wBIS0NVm9PjKqtBviPYz1n2b6+7tYQ9dLC/sq4iyadkpI2peDjL6BT9Dd?=
 =?us-ascii?Q?bDwaZPOibKGNaNV8yUoCzld01mZSLBJGt9fPFu2a7bssXRy79lewouSuq92T?=
 =?us-ascii?Q?1qN/68S6sPRE+yJUtK+HMRUTUClizAjQZQEACWgEdO3sKqNjRjcSd+bv+tcd?=
 =?us-ascii?Q?PIcRA4LoxOwPd0K8P6ZyCbKGCVGaGheBq2PmdJOyxSQoaXbD5aOQVSKYzLHP?=
 =?us-ascii?Q?7KwIuZQyfLKEGFbtQkcvQtOFAQVb3ATsAkvFNrys8DFlR3wi+vw5omQJZGmQ?=
 =?us-ascii?Q?mYp3GrYb1Rl2XEEojlIED2eukM2z1nlmIHN/5BKuUjyLb9yIha/AJ8FgbxhC?=
 =?us-ascii?Q?D0trWprpyvkUbd+zSciznZI7HGfFfBXr7d1IoqFKA/fEC7aEKNteuVm+6u8V?=
 =?us-ascii?Q?Gq9rQVShnLzCLrDJceFUEy0Fw8vnx4lmFGRk7VnwK9tXsS6vtD+efmLdF8AH?=
 =?us-ascii?Q?QjhUzcedDunKCuWGkRKkxXXX7ZmgZl+PgUWYh78o1HGqnbUP/c1GHMX7lXLE?=
 =?us-ascii?Q?QsrfbRJkrbf/uJcKtcPoRFdpXFYVrk1xZ57EWpViaH+b38UKjA3pCoaVozBN?=
 =?us-ascii?Q?oLLj6WCDuMMLGl/IXEJBKIMBCHbwSOY1yhgmJPRQJeHrsBdRAcwqMawcUVD9?=
 =?us-ascii?Q?0eUh6zacFTioTMjCkFCsNo7AwfTHLFbsrLsnSJusdQrB0MtkeQMARXTCr1Jf?=
X-MS-Exchange-AntiSpam-MessageData-1: G6RbKfhqM+pPZQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82f30b4-65f3-444a-b4fc-08deed141823
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 01:52:49.8197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OK7Jb0muVrhN8MdmOWHlk07zESx47T/g+2FNg/2aYV1XtZ//EI6ilTcpvDv5+o5k2R13sHk04PtbN19+y7BTvg37fJnm4345VrOQcvdZYJIyiNitYNpu4d3DQbjlm894DcCVvKXVxe2TnXc2+HZ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7550

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Three fixes for the stmmac FPE implementation:

- Keep pmac_enabled true in DWMAC since the preemptive MAC is always
  on, enforce this in set_mm(), and guard set_mm() with fpesel check
- Fix missing return in stmmac_fpe_init() when FPE is unsupported
- Move fprq configuration to stmmac_fpe_configure_pmac() where it
  belongs, using u32_replace_bits() to simplify the update

Nazim Amirul (3):
  net: stmmac: fpe: Enforce pmac_enabled in set_mm and keep it on at
    init
  net: stmmac: fpe: Add missing return in stmmac_fpe_init()
  net: stmmac: fpe: Move fprq configuration to
    stmmac_fpe_configure_pmac()

 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  7 +++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 30 ++++++++++++-------
 2 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.43.7

