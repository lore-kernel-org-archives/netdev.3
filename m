Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A34AE126;
	Thu,  3 Sep 2026 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441651; cv=fail; b=cls4xL0jMllYAIr/LI0iEfkpm/DGgHZgPsV38Br2Cyl3pA90CM3CTrHzZQh3SyeOOblbFIo2S8aA35cEtYB1tzNjom037v5cXg8wvDCrwmvAIJgtF4BPowundMpVacZ9Z1f1Bn42vXphm9IxXrmZpfhCIP+Gu2/tLXnpPgyhTP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441651; c=relaxed/simple;
	bh=5zEM659iwUxzTwTQJvywiY/PvF6vYd7lQwgsV9F9/Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tphS8/lZ8J8tQ15MlT1Df8umMPQPjVogZJNNL1hJEBSfQoqrEYA1Nw16v9z6CtWvKZ1wFSGChgsjqKs28qfaotcJLNeU1+ffpSA8/3vmdKusqGQc9LosB4RBNZ047a8gKRYOvhBMjI4+nM7w8UBRhoyxToXY4sS1hcD3LXXaz5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kRtawYFa; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kRtawYFa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwZUPk7NIFS7x+8xIVwuekIYv1XjPSxToA+G8owWhCJl1KTVKc8RlWzOoDpVp2xXhVqtwsWA3aXkFaXEtpvNimCo4rWv89XT7ev2VGGW7sE9qSKvp7CJW9m8JWKod7xOKEL4EV+iK3zJ730SHb3K3C1UiU/LktgJALQHX/C8N6PPT/fTx1Hjvz7oP6kU1/YZZqMfXjEPKotsQPtFQZEopyD7lKJuKJyobZOB5gEIuw81kN4ymp94lW4UYQ6u/NLyQwQixSHmvBSA9wLamG639J4Xu+xTl3Uj2VoxakXdqzHFLvsfUBGrOXFZ/2UC50E8Kl6E1X9sonbu8MYm2GsRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHQm0q52Z5fe7jzQhTDgSy5blIv+xHar935aVlhBrOI=;
 b=SodSoXzQZjWOlQ42noqpII419X/xl9+2Fg87mhQPZHlqEc0/RO4M+VVPpKnJ5N/lAlkFVVYneiTLT/Ov6P62y+93S2rinXNaU2LJK2Zo1g0E+pXmc6bUpuZ4/yO3L8BOtoDxvdG7bOFfjKcDUJKTrjBfG9DTPwWPwNj7lMBeQREU7R8xFdT32g7nuzOTReKSN83GBwPTXMhCDafB/1+welWa8q86LvGzLdzI9M2+QOEK50xoAQaGbSEp98TrDdqONrI/hCEXEOD9X/FkMDWA6Cn1a4InH+H47ewP/4cri09bnkGALRfGcpRjkNslEb3laG0rqn9OALlr0o4DxpwEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHQm0q52Z5fe7jzQhTDgSy5blIv+xHar935aVlhBrOI=;
 b=kRtawYFap/2x7rljuDp7XeMOoKJWYxG26jHOh85pJ8RW8XXYr91sTTcTkjcuceHlc3FtiZ3WbeuSTFAL9mETs+XYJsvDdjEDSUjHdQwj/UVFa9ukvTHr/JXCr2OR6YkEnIetyaf5JdwHRHeyvV66snHw7u3MkczYc0CjzhRSK7+CC+HIvpasQrY4Ln8EhLrmxTDrff/BL36PgfP+8ug+wPt0s5qCOdTRenSHjBmHI1505SVxhxYo/2TYouPuvwV5vdcJYaHqHhdd1vi2MYl8a/CBdw2KVupZalkfJztODK35c32R7juvwPBkTdkAC4Ig6r8B1lrPz9IPXTcuJj0iWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:20:39 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:20:39 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list)
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 0/2] ice: simplify PF nominal-state checking
Date: Thu,  3 Sep 2026 09:20:34 -0400
Message-ID: <20260903132037.81346-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:208:239::29) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 34648ed9-dc16-4deb-ccdf-08df09be25e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	KkcRylHjViEzqcLx8waIIruh+fINJDb/jXriRnSoicDhBLNbhW/LO1FgL68HSnM2dxCKtmViFx60XLgfZ3aeoHvASifDyB3dLLcvcU6xpzteevlFv1bgZm4+Uro4oR/Ba8qmXLPNy9mptHfdj1IFRDwtSVtZdrTJV+Ci7RwAmS3GMyAPSPp0ORAwrLEi8/isDD6J6jimUz/OJIJJ4x3P4nCudja6iUct70Pwkyv3UN4X7kA9V5vize8JiYUOxlH7q8MmDVFz6eYazX2XI32omjApCSUAy7ODWHmRwlD5SO2dr3pmaBS2PxqyuewpH6E90kpFKNaLbczJoNWphsFWDEN5P/xpWPu+MWagrdHx5sEYi1w9ZHTk/YHjt27iYCktJ9krsuqzXuN8bcF0FiV6j2Y00iRdhEmLBmIBtpIQjo6JXea+arDuCevr3q0KwItyUe8zt1sr507lzo++A+FJcOiMd8rgHOYADBh5LhWG3F1zzXWKBTEVcksMM6Ouli/SbxDRSEgTPE2oVaBvLvdiBWMHp0H7ChyVaYHuTqHZmnN7kbOUrB174Fsj3AhgJEEBP881l29zkAsLzKxBJ65pTKujRQnN8PbWmQ2gjQlPMsAinFX1y3FrOOuH86GnO4dhek5yxFBgt6TkRjtA2lF0GNgmvnMWnYyk5rBf/ohp+2hE4G9gTIvo4LuCNJLPMh78UotxbC075WrZ5sfuaZV6qg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/b5I746Z/f6RiBQ24CUFIlg+CP+NzpDGgP3AJ0fGDbG+Mb14C+EofmuVBi+U?=
 =?us-ascii?Q?TMcBrMVj+JS0a7M1sPZQyz5OMzqJXyDaSke828QbfgM/GR2tqJBWS1juv+Qd?=
 =?us-ascii?Q?8j6ZvYRu87Z0G+sQ1yiKqVf8fJY8LC9hqgIl95WSGMH3wZEdByGeBOJ5MEHQ?=
 =?us-ascii?Q?GNhwJxgIBw60rmo/1MjAqjDKIUJlFC0/V7LQ0OC4yD7m9/Wcfn35NV4O0XO1?=
 =?us-ascii?Q?3DFI9KFqg4iyB4GLuZNtrteYSDJqyYDhtBOlRC6a2zj2+kgs1lzi+hNcu9Gx?=
 =?us-ascii?Q?ngK8yn6GFFZfck2HzE7w3eZLtR7DDE6l9Zlxy1I7uuLY71QmtAHIiiaM9QJw?=
 =?us-ascii?Q?B84wyfrc0jpUqSzOyx+mV2U33UXEAAF/HC0ZWeUienPlMTBVWCkkWBj4TcPx?=
 =?us-ascii?Q?X5m5FhzKkLbC5ujjL296tNSFW9uWGXBLUQ5AE0BPCkzacp5rcaxvhdMAakRA?=
 =?us-ascii?Q?WStvizfEsN8jPHWsa63cjk4DqWzH5KZ4kcCrId5hSI09mYxSKjkyUdilFCGN?=
 =?us-ascii?Q?IytrcQlqkW8u7/6dI+QAfg1M1NzVlUu9WClV+V2zom6UGzMiX+q0Ab5Vl1g6?=
 =?us-ascii?Q?GNTHADJr718vHAQRxkf8FdD8xDvNmIZLE/hfE7wpEaudrUZZEvVStylOzmV2?=
 =?us-ascii?Q?n4NHpqNP3mLrceFwDdaytfgVK9s6iFIuY5x122FN/+TSEpnI0Tl9k4Gu/8VQ?=
 =?us-ascii?Q?iMuCcM+pt2pN4t2cOZM8xKLBGBy7HjI1h2D3knY0EkQf0Yq0wufptsp1web5?=
 =?us-ascii?Q?3X0yjqhvwEOSuvMylvypZWxiCDTRVCN1BjqNb3vv3q9CadknGgSniWi0Mnm+?=
 =?us-ascii?Q?FEUwOFMPC80kpjt7DfGe8knLvoPCFTRxIEDUIyeaZKcykDc7BQbiv/wXHDkr?=
 =?us-ascii?Q?XySqCLdXr2vpn07CbYFSNoPQBnnI4NXnZXWXmylENAGiWaC05Vr+60nKVdsr?=
 =?us-ascii?Q?tN2Fbnip3sSFygk2Uhp+WrVwluRNGU4Y7T+81uRqhMGi/AcmcYj2Nf2zLXWV?=
 =?us-ascii?Q?ZFwtorCHlwG+Ja8OmVxOvY/U+w9XCGI7O69xnp9lzymczZxOpX+m86UC4IGq?=
 =?us-ascii?Q?rRxnkq66RXChtb7C9X4xaLUJ6R7uwInvUDwQknMhHcaqVll5YgH1r6b3tPz1?=
 =?us-ascii?Q?jU0z9pZWAARfaYHF9E9sfalHZ1E8S6X5N7brOg70u+Lc8QGdcJHp6aCZzFtD?=
 =?us-ascii?Q?dl0h+MvWSYWbci+dcfTsucWV7vYM+2Tjq4lOX//9g4wTbTNpNleSm+2Lor3I?=
 =?us-ascii?Q?2jh1UzL2x5OFy+K5LCpR9WafvPbm/P/M7bU+6x+YQwTH8SAsHtyAzIVSVDoX?=
 =?us-ascii?Q?ibzQUHFtvhwJ70+vzueP+jNOSI1WnwqmA1fAKa0WC8mMtAIghOp/5zGfgnt0?=
 =?us-ascii?Q?nFaICwa7nhpN4DNWapdRx85UnQfSjP/EbEAKKQBzg4ELBT0d0BimHEr7xCsd?=
 =?us-ascii?Q?+y556HyHvtoCmdSRVnD6J2VBj2DFSPITiWcfyelS1RdH8rady95AZ5fMFgAy?=
 =?us-ascii?Q?lHsGcT2d8yGU69AdipTorQGJRgGnBgs5R4vp2spSID7R58ncZnl36mCxjpBL?=
 =?us-ascii?Q?CNu4mgxeC+h3CR0TOOoYZr75KpCDVIIww88NJ7AlDScJxi8R+p1HnAHKV0H2?=
 =?us-ascii?Q?yAreNHpVh7A+Mgk9hOfLCiYRYSTCLcC601rUuviMYsik5slLf0skWmTgg55a?=
 =?us-ascii?Q?dDtUwkDLmQtyVAvtTPr2oCyMGJDoKT+n5EoLknxA+phM+HlcU8e6vpsbmTj2?=
 =?us-ascii?Q?Hf+a0iUUzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34648ed9-dc16-4deb-ccdf-08df09be25e6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:20:39.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HX9bREbYDWEFqEattGuYWUyQJN8mN/ywycG6gn3mT7mKqhijlTUKN/utkzTvWn2zJzsuLdMktigxzehs4Wgflg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811

Simplify ice_pf_state_is_nominal() by checking the relevant state bits
directly with bitmap_empty(), instead of constructing a temporary bitmap
on the stack.

Two of the three callers dereference the PF before calling the helper.
Move the NULL check to the remaining caller so that
ice_pf_state_is_nominal() becomes a one-liner.

Yury Norov (2):
  ice: simplify ice_pf_state_is_nominal()
  ice: drop pf == NULL check in ice_pf_state_is_nominal()

 drivers/net/ethernet/intel/ice/ice_lib.c  | 11 +----------
 drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
 2 files changed, 2 insertions(+), 11 deletions(-)

-- 
2.53.0
