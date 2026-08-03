Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF322396D36;
	Mon,  3 Aug 2026 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785740719; cv=fail; b=suvlGyP/KLTcG59ZG6LY8EZVEFiYEB8fMZ66m8mFhPhojGkuCz3yA4kN7ATzrGrGG88NimQWbwXQDctPGJkAgmNGszsk1wMwmhJHmMp/8dI21lOpCP7dMf4xN28IcdpPxI2+2rzxNK7K/ct+SAqJxzcl5Kybg3Yb2p+nnlGpwpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785740719; c=relaxed/simple;
	bh=bH9iYq7T5iU4bGZr0pIN20V90UINWzda7OJtd4EzVxY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dGJjCVvzmK/ssNGEkeLpR4Mi8LDVzGc7scK7WaGGHTIieC5B1Z92zRJemVCrwKTmxU1O+Ei1pSDJbYvBc/7KFK8FC+ETmGYXVbyC7Wzqu8slRqqaRS34zfN9FndmvNm9az3Kt0BLKibDHTBM1LGlBzgJyOhBfOe1DlOtu44KY9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=U6FCEJYG; arc=fail smtp.client-ip=52.101.56.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="U6FCEJYG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPKVyuqSXNUF7Ul85oXETEy0geszZMnCkODnntRfgttiosWZyxttzHmtbqxvvtBipZSL13JuJ407rtipX3RD3Tv1SCi8jrf56/t4zvY45rFgv1hDQxagyKJYybW/9MJDgZY1wdQI4x31laTfE0Z/Qw0lUxzYw28p7wSJKNIYD9GLm/M8fS+avLblz5q7Y+eAQkLtK/1h/mF4rTMdaZDWUKeDK4xJcbrWcQJ0+8ixRKAvHARyRrB63Ap/FuoQk/eoQ5S6Wtd0u8P3wJiea3R1iJOG5iqfc8GNyjmJ7GEqYIm9SGBhYKY7hY0e/ktZh0z3G+P7/2BCn+zpsRMaXWQU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4XR7IOf+yi4tNmQAox9XYG4XJyQPF2r1BgQisA4cAM=;
 b=JuSmtMRUiFSiwbIkQ1z0XVCqhRYe+GHdlqtbt3yihnsWpawpMqBnx3KJKhs5yDpdeZy6vaLJZetate8VhmoQ2Jsry2pjWIIytKrJTjzZgOfx9yk9N0JHHJthK8XR/PgYr0BYppLPVqpgiF8UTPr8mP82Ajqa1zQONqPIYc/+lNU+scJU/ZeE6nNDCIuhv839Jz8Frh5H6GaZ8yoVUt+uSGmaCuDX1RNeCT71JGLE+5zFt0w2UeFh5liH1X0g2HDMPgD1xtggOoz9h7OVlJR1r5M55cvo/AXNxw016GRAvsnII+UpB+N51EaEkwoqgb9RrlRN2ug5f89yeOZnnQax1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4XR7IOf+yi4tNmQAox9XYG4XJyQPF2r1BgQisA4cAM=;
 b=U6FCEJYGHdAx6C6SBgxnJUQ+F6Xj0yCygrA54NOzS2PoqfbRyY5bVAjMCU2UI5Of/9azv0uwEw2/rdX9saisUBoZRzqPntVspQOWZ+k+ABaPEjVNp9YsQ/8q7Ry99A6eLX1wEiN038YDbnfR9dPi9qNBbtkkACqSbUC29snWVtq9cchQlPiOmAXF++s2fveomSOdWb50Nkxt0Nc7Uj0K1NpBPJdvFU/WJjxNHGDzZNFxQ2xp/EIm6Cawtwq97RXJB5MGwZUKVdyIT7NG/8kV5R7NCqrLBUD9JA/ZOTdUffnOgyBW2/jBZ8Y/fYs1C9qbkwYXdUPdn82kjfp2BBfy0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB989258.namprd03.prod.outlook.com (2603:10b6:510:3bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 07:05:15 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 07:05:14 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	dinguyen@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: stmmac: page pool Tx buffer quirk
Date: Mon,  3 Aug 2026 00:05:10 -0700
Message-ID: <20260803070513.4657-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB989258:EE_
X-MS-Office365-Filtering-Correlation-Id: 026276ac-0dbd-4de8-5660-08def12d9131
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|11063799006|56012099006|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LGoeal07tjVr2JBJLHqXewzNQk9WC4EN9Xyu9Ghx8CABBeiHbtN0bmGUDAwxgNK1eEEw4kLa2VX+7x3eR7mJ+4T3rxdKxc2MhOxXnjGTVUjFYSqI4IJHOiZI/j/8giLHYJYgOUgl0rO5/IBi5//kGEC//3+R+Qle6JQGOZLaaQouV9/J2vKD5Giso4NsW83ItkFUbdTFRpLEH48T3L5lRUMeVD7gSAvqLxnJYu1tZh+++kpxEDyGS8odB4Tq/7S3PvP+L3km7Yp75ZUp4/M3motdMlzSyxO91bqHpKivTe80QXbTPvYLdynhRcChGGdzjTAX/sA+BianVlx/kJ0VxFNUzug6J1RzEmiZhlpdKd8U8Av4+q9lXe9+7jhlKVFSIge2RfJ62y8GThVeZDbbG+GIhrSk6bf1HLGXu+NOL4Nj+0HiI7iyDIw3MA4xq3QhyALsnuUepKRZG/T0IftP64tpeBJVLkYZH6lP+jT7btA+biFsoM8kgF2Oq5fXwToBpbqmBzha0Omaj2sAZDTFS0IGjC+VgUAi4u6zcracS9iz+SittUirD8+9i7wrHR/ofIOB+X5nRvAzKa5B7Q2kZyahaqjgdljy5eCHRjpA84aeuakjSkw2e192WjJMX+BryF18/2GD/QUPhzR1uPMN3xACg1Vq0s0mg4+SdhBW9rQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(11063799006)(56012099006)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R1oOdQCuas6HtVgKluT+fc9uzm/huQXlu+tCFbRkLmEkD4xp+xoLoKUo1bMC?=
 =?us-ascii?Q?goq94awE2fmCAl1Q4zMJUA2lcF/ptaJeknQVGIbzfeKUlO1xzQL+xeQTz9IP?=
 =?us-ascii?Q?WrPwh1sD+7eKkSMx5qIUGrzlsMtL9j7SWxo/Z/AoxZ826DlUrEcKq6aahgSP?=
 =?us-ascii?Q?OeR9C4etoEfbbZNF0y90p6XBfAyNLo4UIiMs7Z5dywDA8K4p4crWkEjTcl4m?=
 =?us-ascii?Q?CJXRwRKVz2qE3hWdq6lxLYrSOaHlZuxlYxc90pFpdjGZu62FwcBWOg2VYlvL?=
 =?us-ascii?Q?lT+/sQ9fyGqxhbuUzXTQOnYtEnG+SYhSllMjRic5sOBJveH2dINWRcKrRXoy?=
 =?us-ascii?Q?d4DIy4FF8teJJ/8y7Q+FsRk+hrdkSQmJ+S0B5AVCadO+lDKp5/kP4cfLcIwR?=
 =?us-ascii?Q?dDO9wiTrvsmaMRcrGoRTm6JwQFXry4YQFpUpDI0TYjYgaYImziFnAVVHdgVO?=
 =?us-ascii?Q?QVpgWrZOcRX3YFUrO+Yj0/ydzv4iJAKbguL7rciUJhTPUUGcySIRuLWIFaxf?=
 =?us-ascii?Q?rJNfs9FxzxgViwCOUjR3FZcCFZHPMaGnv4lLDybAlsMnrwZ20D0akb3oxkhl?=
 =?us-ascii?Q?SNxa9br7DTh8XwNZWRj6YM0NE0RBkDpxvqNIeLf8wZB5VhkXXrw/MeiCpSQe?=
 =?us-ascii?Q?S6bozxTU8bvaeqM70O6Vjzx02KDOpkKsxKbhNr/oI1i4sW1pRljBWKv3SgFw?=
 =?us-ascii?Q?uIwA7maecQysoLm/BI6IWayHhG/2pbpzYobzugzf4cUNyv921/VZbQd4NU1N?=
 =?us-ascii?Q?WHWM1SwZb2bno3vRVra01/MIquFj/azIJAoEQLF+Odld+gxbgKtYFhkXJCfK?=
 =?us-ascii?Q?DCGdKlunrSRODqnbd5+F+o3koeE6LnGM6c1bTjIOftkl8G+HBLo8uanl6lgy?=
 =?us-ascii?Q?rqChIgYYliKEjoh8zZzU9e6AEh+UcJSoJMhKHL/h2lMbl6we2UkQt4m3GNwV?=
 =?us-ascii?Q?mKF4MMHcm7je5ZzDFMB5rIlrF1SDVHfQTaMW7nMJDyAnFHqFTR28oBzS/T68?=
 =?us-ascii?Q?kcdAfIkzpQJV+mVzBf/E0gQSUBtUBr+EfmDdhgBO7A78W9s+GQgYkh+e2n3Z?=
 =?us-ascii?Q?uLSXOq53BOZjWIEKrUMAXRKvLLmhM0wkU6hvF4VZkhXx2Cl9avhNUaNBz2ph?=
 =?us-ascii?Q?GPxJaW0Dqua42MyHVSShHN7s4cuvIuDq/wE8vN1eL/q1bRL0+ZftS89y46jX?=
 =?us-ascii?Q?ESG1xPDeCITtIPQ/e1CPbma9OcMKdMRQqm2Nx3y4zFGCnJuVL75DeuJEnL0/?=
 =?us-ascii?Q?tAELxwb90USN/Vo3c5mjEVeyxinK2CTl37IpWIg8Sf2J4FRZAJQk/Q1g0oh8?=
 =?us-ascii?Q?tFEA4N5VG+LPJVKOcifsu0oaylZ9hRTsx4gMp/lf2EpjrS3GWnqmNwvnJWj3?=
 =?us-ascii?Q?A3t+LmXuFduIHHVRgBXCQ6QekN105rQKKqLQGz9i2eUJ243l7n77jJHrWOaE?=
 =?us-ascii?Q?GwVT0VHFAZ0hADOrfbTlNgZigin3uq5FSIY8iJycbA+G+YUXWtRho9pTeBeA?=
 =?us-ascii?Q?csv80knKVIaf33Cp+/poHvx0M3I6EuLIMQN+sRY8yhzPRw0vWBdknsL0JqEg?=
 =?us-ascii?Q?/UzVXyBMLVGHuDLaibGwmlRCEstfE1h6Ebith0DFQ89rDbV+4ZfmoOU+cTrx?=
 =?us-ascii?Q?8zeoOowHcD+HCR042R245mya/6vRQMZkrLJKX7bAKyFQjmIyGvbWIV/VpsxW?=
 =?us-ascii?Q?lC1pgOOho+Jnw80p7EpX2XGIYwJ8Ms0qaWyVgOKcbffC2aT61q0v8H6b3qEq?=
 =?us-ascii?Q?rVsD2yxmGZJENoPa8S8YhXIpSDYYIXJCC0mFeYVZSDBMNIyeIHEWhmi90PiA?=
X-MS-Exchange-AntiSpam-MessageData-1: CNvsqIHXXvobCQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026276ac-0dbd-4de8-5660-08def12d9131
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 07:05:14.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yv2Krz8sser+nKtMdGVfWRfaLQKWTVeMpHQiGqcXMVV5886MMnfPhrYggxZf9Dfgyj/3UEP8nppcngyZALSeWHQsgbBiyS7DGILPVJm4Ov6zStIthFmeMRQ79d4i8hwHAvEhmPiw+MAhhHwYMPQDZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989258

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

This series adds optional use of page pool buffers for stmmac transmit
instead of per-packet streaming dma map/unmap.

On platforms with an IOMMU, the invalidate cost of map/unmap can dominate
small-packet Tx performance. Copying into recycled, already-mapped page
pool buffers can be cheaper. The feature is opt-in via a new DT flag
snps,pagepool-tx-buf-quirk, and is enabled for Agilex5 GMACs.

Page pool Tx buffers are only used for single-fragment, non-TSO frames.

Patches 1-2 are based on netdev/net-next. Patch 3 (DTS) is based on
Dinh Nguyen's socfpga for-next tree.

Nazim Amirul (3):
  dt-bindings: net: snps,dwmac: Add snps,pagepool-tx-buf-quirk
  net: stmmac: Use pagepool instead of streaming buffers for Tx
  arm64: dts: agilex5: Enable pagepool Tx buffer quirk

 .../devicetree/bindings/net/snps,dwmac.yaml   |  8 +++
 .../boot/dts/intel/socfpga_agilex5.dtsi       |  3 +
 .../net/ethernet/stmicro/stmmac/stmmac.h      |  3 +
 .../ethernet/stmicro/stmmac/stmmac_main.c     | 75 +++++++++++++++++--
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  2 +
 include/linux/stmmac.h                        |  1 +
 6 files changed, 81 insertions(+), 11 deletions(-)

-- 
2.43.7
