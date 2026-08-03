Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B4352026;
	Mon,  3 Aug 2026 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727447; cv=fail; b=DdpX85m56W15soThr+Y4TKDAN8YJyBVZGy0K8JmEOsMSO138fmt9iATuxfs8GXCzpIuoLuEoOO1WH2KnEAO7yb6x5JiHZOelozVI65KHdAY7P2EgKXR+6pejljesKsePjNpLAKD+5mXaltih+wTUrkCcznh9/Tm92Rat73ItNVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727447; c=relaxed/simple;
	bh=zeCurmdmsxY0txIbfnCir4OvOOMdik+t79oANtWE34I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SfFijt6ZWSwqP1mt25ZKR5HUf2BqEx+R9AaD9+qV6ZTW7wxqAzz97697UqEp8dq13vA9YDCvOxi8ehodPPU7jhgpxpuiPFX3v92GmDaVubOhkOhNDsxzr9RruTUk9RntIPz9mQL0MKPIV9AFLpDFe13yoq34HMkA8UaMstq2Kk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=IDKqrEiD; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="IDKqrEiD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA/QEcE9JjDf5WJTaAi63FKf36/Z0W8l6nTMz0bAIxX1QeRADiVQxx17xrXpSK7nqoV8dkHmtn0wxsWoEwEdVbFq3BoZMQ7oxelEHfOWyw82OXiscxENWfjgE3dLXZ+sa/zT62488oxirzGZYhX2woZ2gCQSukS2rcYOglOjq8hrkREYBsGocEvzKLDIliS11j8PFeRDOVdOo7TVWyrFjahbjCLnACCHAFpMdPmNwdpCf5WcmsoVi6lCBBU4pHE4hgVV8yEJYnbcY36tOGpwv6elepJX5wrtsCo8NJNHzlGfdSWDSKal083Nx5O1V7fzHsiA3xgE67pS3SzjRNkOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ujnk5wlepFe54qG7baPRbU3tIkHa3V1zNVQeZG6u4Tg=;
 b=IBsBWUpNEA72RPEhPiZeZ+HvyepIvHyeIPJsfzbx3+FEArIL5beB5pleZnN3TY55DglcoP6sZAYNrJ3JU1QkfRFa/5GYT6LBXPZ66ZwjUB0v+2geHRCzuTOE/egEvp5g9Gucuiq+t6mctkWapPZTlSKCBYMmQhHNfTRJ14MWBPKxXAOM3IztYWyfJaKNyLZDcG2aF6SLke7lHnEgyzSr2KQlY9Pkrs2FwLl6GFBm5mxZQLgFbVe0OmF14M0YQKLYQY9NibLsI7gioNpwKhkZ0F6VlZgo9OCRLCk/FkUkTfjZkYIFu18XDdiM/9grChyuimYWeKngtHH1Bz+PTZpElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ujnk5wlepFe54qG7baPRbU3tIkHa3V1zNVQeZG6u4Tg=;
 b=IDKqrEiDF0WWq/aMApPkehV+EgRKyqa3ekP3TEzB+fvAnIXYyQHNmvVcTYQPmmmJh7qD75EaW4026XDYDo2wxJg2a9nfzswwm+faHRf1GpKtyFoPrC0u4WlFw3Yiml5WH6rt9WUVmvT4OWSsl0XWUlHDhfCghysQU3/cXAeNZtIT+a/sFHeZ8cT1MrhpBVfLaOglFQ8kjOv6A36jvPT7tIbgLW6KFx2WQIEcJXsLQExYhTYzD2BWcYDwoxAohMdR2XxMTTBQGmJgp3pxjuqc0l79DO3ejnXgYCRTT1JypTiAqCSIOdVNnVtytKOJ2bStlGhoCoFrstdoZS/WAMONSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CH2PR03MB5335.namprd03.prod.outlook.com (2603:10b6:610:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 3 Aug
 2026 03:24:01 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 03:24:00 +0000
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
Subject: [PATCH net-next v2 0/3] net: stmmac: fpe: pmac and fprq fixes
Date: Sun,  2 Aug 2026 20:23:55 -0700
Message-ID: <20260803032358.16282-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|CH2PR03MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d73c03-1835-48ba-9c97-08def10ea8d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|56012099006|6133799003|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zYIev1PqmrHO887L+Ie7DlIgZLr0edB5FCZNjoM9wJgqyhDCcflDYJPIKhPOsZMl6GnGewcpTOQ4bPpnSNqnV4AOi9uosycERy56z3rlo5/ssbvUfUPuHxlQpgn/dnNdped7DLhsBBSvJC8iGowqSiBYp4Y/dyQXY+VAnHQ7PevaJns6aZbzhEj1uaHs1+0DPDuyamPw0h62X2MdMTzl2CPxLqA9GCK4EmZjRiUJdvr6h1yDVtxbVY7FaVK6gm7FNsV6QOW1eCZzDjvnqPqqrpjwx0Xa/y8VC2ssTQAr5JRC/fqJvUe/K+ApiXGZFmn/F/GqKd4HO95dytuJmtOsHcd5cRVzGnCHFWImmX26JlzYVstF39FciDtFiE3/RLjGPT6aL3d3P7x6AJbeWUVv/HHIWLYJXw5KOTP51Gyd7FY/WEN6zFc6DO/hHneqDF8vp2G1UGGMdK02Ef+EBr8d3EDdslr39+SQYZHd5XIKXBfHE3nyIzKNdUWTa+gsfBTXNWuWBF++yeKJb4g2si2dDBp5pmTn2PNxqZA7HSetCw8TILhChN1q+4yP8GyXgz1Kz+8OpxPznHtpDCnJNshnhdP9pVeAQAVzX+p3G2jMEpiOL2PILutoyPXUExaiYZXsIFVVmf8dNiBlJnrkcSk26YKyFT9jbomWtmv90hFCvek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(56012099006)(6133799003)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R3Eh0A3aqtTe3GrnEHhH+Gz23ANq9F7EnFB2K3GbC23sGq2hfQ9j4kAKLFGB?=
 =?us-ascii?Q?+9c7027K9meYBg6JkTJfWlFiejsR7OquPCUPZw47rU4OVBMQHkypnBZnFO/p?=
 =?us-ascii?Q?MrFjDG4jY3qiUNsKZCKFW5CHpM3G7yhflbjrVEyqAVMjcwtLiTJ4PiG+te9o?=
 =?us-ascii?Q?0bKEHW44Q3ASKVOwAPpqjiLf1GqJ02ym3XyzKkggic3/GqQwuaOuGJnYaxQX?=
 =?us-ascii?Q?DBjyCDCYzZCC1BBgPKljmyICuJoy2MXQnnOX7PHp74KBSExEnFAxFx1Y9ZB+?=
 =?us-ascii?Q?YRqEJKIlPzNM0GJEACsa2+whng8Ml9KyVHVbMYW3PibZUBZ57DJUa2ATeI+d?=
 =?us-ascii?Q?jJIEDrm0rRf4X1vHrzuppubUkBwP7/45R+J5UPilwva0VuhYQyLLU9GrvxM9?=
 =?us-ascii?Q?0SIoU+Ssy4n1SufBWxzGpQYdGO5ky6f/ffFE3CGLRT1URTx4s7fpY7DaEg4X?=
 =?us-ascii?Q?+8fvXcWqPKT9KA8iCJhC/MbEg8tv2UPG0PxU6aYvQpQvMo/5Dn6mlkWAbYEG?=
 =?us-ascii?Q?ye4NVL+ECH9qIhcIcYIqVkAK07GTjWBsVWm4TAMgHXvEvfUponz3CAXEyj1J?=
 =?us-ascii?Q?OnUIMkRxJXMb/G0Eqg3Xb2R0XzTmQYWJt0aXRtpQP8v2i4DH+lM6wAff81OV?=
 =?us-ascii?Q?Ji37d20A5JNbePab0bOcKzEy/6z9oeSrgdLt8ll+5576cAzAlso68sWjbiMy?=
 =?us-ascii?Q?cNF2hEI1LQ2zJVT6bc4Jj8m252lGDZXd9fWHuNNuBOo6Gq9kUh900LbzQJlL?=
 =?us-ascii?Q?Ssyn+ymrdhsEu9vjRdB9miYJreVgz7p9U3V8Yl0K9ijXQ7I2LhdBaQa2aiQ/?=
 =?us-ascii?Q?fG/WF7UT0cwnVNASEoohkfAyYTAQmoLcKRDqHzOYVepwedMwnqe9PGt5HUcq?=
 =?us-ascii?Q?Y2Z2iaUc1m3YD2Uh2sW0CrfETNodga9BWKfI0Sdali1Xut6kWEV87OrZ7TsE?=
 =?us-ascii?Q?TjalJ6Y65W8q0MpJgGUA9s9jP6joHHG6nAIxjbMYQ+f1PegQ90teIUh7kQTN?=
 =?us-ascii?Q?8RZIxKWAT3EiK7ZWpnUmdJVv7ptYlaerG4CPCvWQ/mOglSwZJ+Li9RsuvoYI?=
 =?us-ascii?Q?3bSmXCl7ZpSrZ3C4TgI7oAHv1gZOBi1F8MSy+xdg1dO9dz8JVoA6RA1oFFcM?=
 =?us-ascii?Q?KuBVhtYalEOqXGrJxmOvZhRkQZ0qo3nQFNOziEdDSMzyMVp5T8ig6DsTIwZ7?=
 =?us-ascii?Q?o/tq0L0efBP8JaaqXe/2dk5KWElBLwp99NcE3dIaZbmXoN7DDJDJQdXE8q5a?=
 =?us-ascii?Q?nW8bwZyemKrZO9MDfZcPFRf0q25WGUasqwSw6zrb1wqvt7bpO2bpDtDx7BBB?=
 =?us-ascii?Q?aJ/2gti1eM7eonPWBCdoGEdCOulGVwD+hUFdzMQPuT/7jALt2PcwB6GmfQOM?=
 =?us-ascii?Q?dqQN0RJcW5ZSaKfklwuR/jHM4K3J8De9bY2Hfffd0OdfzYXY8WYUvstNWB+W?=
 =?us-ascii?Q?9WVufbwDUV6cWoItCWtb2cgNDgGDrKy0CkOxy8QGIf1QUIcQwZUEL4qfnYjI?=
 =?us-ascii?Q?OgGBfJetgKJ+WNodtmnbZZeUAwohbFyqiCwsMp6PopSX9A/4wtzNJP0xUS3A?=
 =?us-ascii?Q?IvbrnIqijWUnDLHfQ4lg9+eXkekUS433Xtu+sDAvKc9iXxZUABWIHBeBRaov?=
 =?us-ascii?Q?FhxfyLjggeOk0c8q0jUblChhPdZUyVeo6gTVVCfaxibS9P0Sf2TSC/AYkAa3?=
 =?us-ascii?Q?24AUc26ZfP5r1C2HTVEu7rXO/zO7RgivSkhrfJAaAjdYgYN12BkiliIQHbaO?=
 =?us-ascii?Q?ODNkh0DnBMqxka+1J0yuUWX+6t37Eee0b7qMf9xnSVccU5acmBHJmsSZtnGt?=
X-MS-Exchange-AntiSpam-MessageData-1: AvEgzm6Haw6PFw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d73c03-1835-48ba-9c97-08def10ea8d1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 03:23:59.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejNLrusW4jDvJVflLirIG6SgwQ2sJdSQvqMRs6oTS1H03tUNCLEO9nQsuhk6OupGj1xwLXVEdAxikvWJAZ6bjW0PP4cNZujTFDM7iXQC4gAdRUViLJ5kXV1nSY61RTSbWS0VkkBJs0tQhWZHgQWDEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5335

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Three fixes for the stmmac FPE implementation:

- Keep pmac_enabled true in DWMAC since the preemptive MAC is always
  on, enforce this in set_mm(), and guard set_mm() with fpesel check
- Fix missing return in stmmac_fpe_init() when FPE is unsupported
- Move fprq configuration to stmmac_fpe_configure_pmac() where it
  belongs

v2:
  - Drop u32_replace_bits() in patch 3; fprq_mask is not a compile-time
    constant and triggered __bad_mask on x86 builds. Keep the open-coded
    mask/shift update instead.
  - Collect Reviewed-by from Maxime Chevallier.

Nazim Amirul (3):
  net: stmmac: fpe: Enforce pmac_enabled in set_mm and keep it on at
    init
  net: stmmac: fpe: Add missing return in stmmac_fpe_init()
  net: stmmac: fpe: Move fprq configuration to
    stmmac_fpe_configure_pmac()

 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  7 +++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 34 +++++++++++++-------
 2 files changed, 29 insertions(+), 12 deletions(-)

-- 
2.43.7
