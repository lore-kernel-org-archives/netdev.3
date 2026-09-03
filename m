Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC7317145;
	Thu,  3 Sep 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458800; cv=fail; b=od46Qky0oDv8W7qJEgX8joZPPUN/PuyLfm+tWThJi4ZeGUBp9tPkNQp6+dp13r63H+Q5bVJGVC8vYuWq5L5fDzJ0yZN5GvEifrrp8sR6pJGItWVjCLFk/WYSte+We+EEnOpO64EJWVn/MX4Xd/t5L8+r9ClGg8NUWB1G4xbUa/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458800; c=relaxed/simple;
	bh=YTn47qygp+N9ZO/g2enN6dGbWpKxSHuAR4ENogdyl2E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pgnf4j/UQ1DvtcBsr5NP3dNWiAU71ZRNyMj9T/QPBrTZVP/fvdVO4ffrTH5F2m55Qf7gNSBC27XHfDuPHQEvtL9DBWFReAZ3E3uFRkor4Pd4pYShy24X/nEl3a8zHjQ1L32LnA2DUakR6erAVIeqkyq9LRGadncIcQK+LN2rgmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=disney.com; spf=pass smtp.mailfrom=disney.com; dkim=pass (2048-bit key) header.d=disney.com header.i=@disney.com header.b=Qw3Jut7w; arc=fail smtp.client-ip=40.107.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=disney.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disney.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disney.com header.i=@disney.com header.b="Qw3Jut7w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIuqpBUidO97NTe6tcBlRrZHUO9mBeqRRYxIPRC/rDNpJvk0RmtQCfZsHmJA3Vv4f19arhICi5yko0I3DdteGxvHFTeQ8I9GhTRKCurIAVIMO5nfJOlDfFcy7ZCRJ4VTbKhrOXJLuN3LiXQvmSvi2jyiDeT2hYACiy1mBodbh5/7QQbgPiE4odz5YMrh3jt3KzIN0BL/VmuSxaZdqkJA31eQIbOQSctZrrMMNbgD+79InNgi52boyHYKr6Y7zORyOFOtea6+f2qpY2WAe0fEFRMXnKP4ZxweO8PGrBeUUZVxfRgBCAt61UMdjfEEI7tiuzmhtK1CwPhVLUwlrLlIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1v8PicgJ4iassEVMu0hm6M6gqiusxvhZuFnTq2s824=;
 b=wS5MmSX1oi+QmRK96n7A+sU6VRPWq+Q3YvpGahatp+HCmg93pcjbdbBfpTiSu7OR5QkPPHElKbQFN+SczKbbyzdfX9CC9b0UFSrY59yi+zjuTY7MhhJMLH57zL50v0AFHbh4OBfxHU2tqrjAPN5G6SCjWmwTVY9kdrJBkNuNnqIqVD1BGrFA7VSWHMApS8wyM6yi3rwuf94rjKRRhINayC4p2LfyqlqDf/qWNmEnmBAe4CNChtOASuGJ6KOmyMMQTSyBn7vwEt1GbFyXC/kBHzpAY6zaab0UrzoGOEPQmxqYv2cmoY7nq0IO8Hs66Ae6O14S0VEruS05JGpkiZWO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=disney.com; dmarc=pass action=none header.from=disney.com;
 dkim=pass header.d=disney.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=disney.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1v8PicgJ4iassEVMu0hm6M6gqiusxvhZuFnTq2s824=;
 b=Qw3Jut7w0kroOY4HtECgHGUPuhEEiUDDvpWihpKD1eMet1+lfxFB9dxKv2KS+feqAcn6zldZVhd4vxyENFmYaSDbGMWrUQi1/0258jWUaxt/qLD45POJrAuS1wOpMm+rYmCgQrLl92R3rvq5TKr4i7YsLfz3NO2ZXu9SY9gCnMnuQZz4WQmZLTJf9P+jCg2dqYhFfUp47ag0gU9bL259BAbKVfGYw4cg5rXrJtn0yay5cOmFNDffEQs8WGKXML62PZyGF6yMd4hp+SZc6m6KuhWBY3Yp/hbQfBUlgGebIxE14Oifzgl5Rh1I4h6j5tSNeRRKYGxm3d2vetEviIU4sA==
Received: from DM6PR03MB3836.namprd03.prod.outlook.com (2603:10b6:5:4b::31) by
 SA1PR03MB6670.namprd03.prod.outlook.com (2603:10b6:806:1c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 18:06:33 +0000
Received: from DM6PR03MB3836.namprd03.prod.outlook.com
 ([fe80::faf2:9f59:6b8b:ac36]) by DM6PR03MB3836.namprd03.prod.outlook.com
 ([fe80::faf2:9f59:6b8b:ac36%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 18:06:33 +0000
From: "Rawda, Tony" <Tony.Rawda@disney.com>
To: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"vitaly.lifshits@intel.com" <vitaly.lifshits@intel.com>,
	"sasha.neftin@intel.com" <sasha.neftin@intel.com>
Subject: [PATCH] e1000e: set fixed clock frequency indication for Alder Point
Thread-Topic: [PATCH] e1000e: set fixed clock frequency indication for Alder
 Point
Thread-Index: Ad07zqXgr+5utV32TBiUFVTVUh+ZFA==
Date: Thu, 3 Sep 2026 18:06:33 +0000
Message-ID:
 <DM6PR03MB383684B3604D2B332361B810FAB62@DM6PR03MB3836.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_ActionId=f0aad0bf-412c-4de7-93b0-9ab0ea7dad74;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_ContentBits=0;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_Enabled=true;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_Method=Standard;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_Name=Internal;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_SetDate=2026-09-03T18:03:55Z;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_SiteId=56b731a8-a2ac-4c32-bf6b-616810e913c6;MSIP_Label_c62e0584-010f-4004-8a6a-d5c118c8b4bd_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=disney.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR03MB3836:EE_|SA1PR03MB6670:EE_
x-ms-office365-filtering-correlation-id: 54851f29-cd48-44c1-5fa8-08df09e616c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|56012099006|3023799007|38070700021|10067099003|11063799006;
x-microsoft-antispam-message-info:
 pUY4wecrUCL6eFz+8qO2CO5GAIrL1cCT2xxqb9GMI167/VaE44PXS+Oxj1X1680XcN24i9tLq1Sszaek15fwipFGXuIyRT1dzDe+ldllSBBIV7g8SjL1pKdqvrmh24pPtK1xIXps5WyxgGwlWvUagaLQeBXYY0EB5y5+ePtW9vNIva/S6rb3jnlZU5UNP8n8dk2PKd9xuBSsd3bJ/l1vLPRrqvRxRltyObVyk7pcbAGh8ovwcOZaUK6rRL/DiDD3d0Q3dSU1rZZw7OI5kqcMS2rivWcWCWQK2Y8qMcfhWQUF/k9xDJMRTCzbKapY55ViikUM91OL1utAa+jJrDwNIk75TJgC1vbgn7oaMp9NgxNPCyH4ta0GHRnCKV5Ff9K0RVXL2drkTBsDYf4e3+BaKz+wZpQi1YBoDe4WhFS+CBhZO8Xle3py4l9a7ZBJyE0fnigu2VEN6nyk1uBMFNOPvhTgtbSEqI85IgXR0ULctWBlNxdIwDzrKvZJsG/816iP8Ke7qUbowCWuX7o8okuRu2lNG5XM4hoUlxN9DcNH0DxxOiiQmFtczUaPQWHvkml/gzVvjLFJHbGejgWd79CAniKSn0Oiihq+upSHzUGCISPqCH3u3/ZUNwSM0DUSETm+4g9Y+6v3a6YQi24cqNUb9aj5mo8MK/2MMGOXU4s4IRvKUtboLm8U7rd9hUU+UH6NUBi+LnnsuzrFop9Rix79dojBvyqHfpbbcjN0vxpEFbU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB3836.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(56012099006)(3023799007)(38070700021)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w2/oSz0U1Qb5B7NHhx1fpjiM3SdzYqUt3+T4M3WXUzTVB5Bz/L8K3S0C03Wn?=
 =?us-ascii?Q?l1anbJq+M/k9FJes0EUfVtdpNOzQFeZ3d0YSZ8/uCYhN5rYTMjKYvLkHPghK?=
 =?us-ascii?Q?YJsqRc/deEi7UW7MuX1SRe2QVT5T9HhR7eFq/S9fih0YJ078pdH4QL50XDrH?=
 =?us-ascii?Q?m9zAYpD61Y/Q5NvCrlUTKI9bONgFb7kgH8LfDJcdn3GE+ZN7SUUw+zPYqI54?=
 =?us-ascii?Q?FYLL39ENp/hq8cSBU/eRV9CRv4uRvfBgqIV7nHMVi7mg/Gy1zxyddt1eOFOt?=
 =?us-ascii?Q?bhyyLYx8jKEBVJYdgI7K4YJPu7vqO1uIKzzMjC1s1+ND3DVo0QCIbJNRZmxQ?=
 =?us-ascii?Q?VNz433R44VXr0O87vfgFiuBiIme1LETKSsfPuKGiHaigdIRPUwyeOl4NmNbS?=
 =?us-ascii?Q?PKZINOhaHBIWtivc95ok6uoPuZZZmSyYz4R3wg9VMmJCGN8nvtRBDnYQqHcX?=
 =?us-ascii?Q?FBdkpdUd9vwVTgyqk0+z3t4eIeI/+JEAlHyB7MpZIN8ZPdY8cN9Wn0+r+Qyt?=
 =?us-ascii?Q?Y5rb1G2aceHU3b2YlPC6yK1Fdfuf5tti3THeqlJj3gFIgQKO1nwiDTkxB+x8?=
 =?us-ascii?Q?hmm235bPmKkD694fxDvTU7vhOAarxtsDANp8B0T4OjYxThQfrMOXk+ZDxNYY?=
 =?us-ascii?Q?ivH7TFWmJ8fb/mZZBIpUNEKifS4a1N+X0giw8FlfAD6wSdNrUyEKuZawc1Pm?=
 =?us-ascii?Q?A7pUCjaa+boJ31/CddttRLKlEOJmIjp2hk5WPqvUQp+ZWsBwOf7A730wuhdK?=
 =?us-ascii?Q?KWpUCJyvqcMSJh1YRzn9j0lX0IQogPkRcSd/lyMVTdvSOPDvnMMOI6yVCxEu?=
 =?us-ascii?Q?Lu5rVlLiq+6crrRp1BquUl1gxC+9wJJRdz8+H8T4mQR4LPyaU6HhanLvZ0KO?=
 =?us-ascii?Q?mcBCwbAJAa/IlFmklVLokqMhEaQ2IRmH59EpnODv30+oVCixk0ICt1FFqGf0?=
 =?us-ascii?Q?HyubswW4FBp4RNsAoPBL0WUhA+iKfgWZVlt4ZZF+l+iJZ2DkuMZA5zbM8tGM?=
 =?us-ascii?Q?M1BbgmmqycFmWLeXShbsM3o/bxmViXKhizdffgE9cytNMuGA+Io33fBxiL/v?=
 =?us-ascii?Q?TKeRXyerT+EtKP0XHcH8iX8lDz9QBGDD1bHx3nASuiXfKP9WRTfYsdLM/bvx?=
 =?us-ascii?Q?EuHwFb/jKxJFBtXLmQUnAl04z7z936VlWKTL9FPOi4E2FBQYXv1VUerVBMsI?=
 =?us-ascii?Q?WMuTSDSEV+NtG867mBN1gmAgodVhqyRctixQhL2svPnFkXZijoNx+DY8l9gq?=
 =?us-ascii?Q?ALSiBp7/juhl8w2s/6CDlhm63hnnDrunlatzFEIzIzSrqpuF6tW0Q8SUiWXR?=
 =?us-ascii?Q?rCJ745Wz6IemRbJ2vb9RfSSEX6QoWop043UgXZK0JeaxN7nw2ViCLd70oo8c?=
 =?us-ascii?Q?O+n/7xoGkPdZuG/jVJRvjS32tdtTXns8iY0dkQxXXbEsO47bx0+lXzL9IqgX?=
 =?us-ascii?Q?0FrOIOtgySZhg9aCbV6fUCKVRk6JnipI5nVucVDp0hB3AAq8+RucflSZHevl?=
 =?us-ascii?Q?hRMheVeCcZuLQrp1ASihLJdbLL8RlNczqks9kfc1c7Nww+4bIuk7gAMpPggQ?=
 =?us-ascii?Q?l9TIucUvn8X08vWp3w41zguNIgyapD/Kk2MCf5NQz8EtcIr6CqEFVslKzmyK?=
 =?us-ascii?Q?YnmZcG8FQPldcn78I5v4MFC1Xil+mz2FSM1VQmF+fjhzGmjmTw+V9MAlFg9x?=
 =?us-ascii?Q?ku+4TcGxhujZ3OHGtwDnfbp36V2nI3qsfY37fprEuSbIAyWy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: disney.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB3836.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54851f29-cd48-44c1-5fa8-08df09e616c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 18:06:33.8514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 56b731a8-a2ac-4c32-bf6b-616810e913c6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIKDb8oMMSDs9E50+ebAtlwqrPJMR2mc8mFcF+3/GHr62gYAJWH9tvridO2bB3EX8eNjHaL37q3NdxOoW0QXjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6670

On some Alder Point (e1000_pch_adp) platforms the XTAL value reported in
the software STRAP is incorrect, so the SYSCFI bit in TSYNCRXCTL selects
a 24 MHz base frequency while the SYSTIM counter actually advances at
38.4 MHz. As a result the PTP hardware clock runs ~1.6x too fast
(38.4/24), which prevents ptp4l and other PTP-based time sync from
disciplining the clock.

Commit 688a0d61b2d7 ("e1000e: set fixed clock frequency indication for
Nahum 11 and Nahum 13") fixed the same problem for e1000_pch_mtp,
e1000_pch_lnp and e1000_pch_ptp. Alder Point silicon likewise always
runs at 38.4 MHz, so give it the same fixed-frequency override in both
e1000e_get_base_timinca() and e1000e_ptp_init().

Observed on an HP Z2 Mini G9 with I219-LM (17) [8086:1a1c]: before the
change the PHC advanced 16.0 s per 10.0 s of wall-clock time and
/sys/class/ptp/ptpN/max_adjustment read 999999999 (MAX_PPB_24MHZ);
afterwards it advances ~10.0 s and max_adjustment reads 230769100
(MAX_PPB_38400KHZ).

Fixes: 59e466888038 ("e1000e: Add support for Alder Lake")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Rawda <Tony.Rawda@disney.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 drivers/net/ethernet/intel/e1000e/ptp.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ether=
net/intel/e1000e/netdev.c
index 844f31ab37ad..635a18cfc93f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3543,7 +3543,6 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *ada=
pter, u32 *timinca)
 		break;
 	case e1000_pch_cnp:
 	case e1000_pch_tgp:
-	case e1000_pch_adp:
 	case e1000_pch_nvp:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
 			/* Stable 24MHz frequency */
@@ -3559,6 +3558,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *ada=
pter, u32 *timinca)
 			adapter->cc.shift =3D shift;
 		}
 		break;
+	case e1000_pch_adp:
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet=
/intel/e1000e/ptp.c
index ec39e35f3857..4955d29e47f7 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -291,13 +291,13 @@ void e1000e_ptp_init(struct e1000_adapter *adapter)
 		break;
 	case e1000_pch_cnp:
 	case e1000_pch_tgp:
-	case e1000_pch_adp:
 	case e1000_pch_nvp:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI)
 			adapter->ptp_clock_info.max_adj =3D MAX_PPB_24MHZ;
 		else
 			adapter->ptp_clock_info.max_adj =3D MAX_PPB_38400KHZ;
 		break;
+	case e1000_pch_adp:
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
--=20
2.53.0

