Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023102.outbound.protection.outlook.com [40.93.196.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F053033DF;
	Sun,  2 Aug 2026 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785642445; cv=fail; b=c3mxHhvqSbFtjr4IlPpujPvA1A8IlUgjwXP6bftAnuFI3SHgrDpnwZ91wp1xuJYtOKL+r4E8CDtcQIzhj71Tzl4PG0krkLa2x+d3RcGTkYe6SG6ShljRRiqOsUbl8uRkW3nkI5V2iku7pCH6FhgMYFEDPvzXKpfXo6N/ZcXJcZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785642445; c=relaxed/simple;
	bh=xaRyWiFLs9c3LZHPXrMIqKdDW0yC/HYAiQuIprF2+P8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIh/OPw0ujCZk3LGK6zngwwr6LSmbdpDBlY8aRfWOBlkLacx73d6NXJodqstXf3Fv39Ed22ouffzXkTaiQOWTzsUGJUhD21tNXZbqrOjfGb7ziDFL3H597En92VjGiifKG89C2rophrj0ky4H6UKPqhZ0K7l+HzgtGfTyAxnhAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com; spf=pass smtp.mailfrom=Mahcom.com; dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b=xE2w58QC; arc=fail smtp.client-ip=40.93.196.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b="xE2w58QC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAoo3tJbICbxPl56EUOI1BLMyfI7UL1nL8TZzB2uKJnRgSp35ax4zkM/FEAqdXvXGA32p98gDNzlDGNB6I18Gi3OTVM+9wwlcJh1e0Oa2/zZkSvF5JSCvAAhozrlnpWmZRAmlDL1n/qfr69Cew2et6ijIcbFQZd+6sftSJOQWNqJzp3FJQZvLUWwMEF3eNHonfrph7f8FAjttltgBs30QKq8uqzob6RKbPLmi/Gn6wLksUvXsnRfcxdMjBNMd3fHujLT8XESAEOSpQOexz7qCRXKAl4GpojfAFSNR2dycGVXRcNCVppTVJZofqTC9PwSJRnd66ok/7EYXzFqEMCjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RylGCz9Mcklua3IGIEQlR/PQqkxvhNqaP0QrRmna1Yk=;
 b=rv1uFHP2+AYT2+OLx16m0XLXGx4k/gIEvhVs1SyFmuEtnLKJPxqnJBqpIxdKp1Zfal13us3WlpbwL3Q20fExvmqkjzSTWn4hR5rmLVz3GdO2cjwZJpcBX9sKI+GNEcFVtCWt6ccLBHR/4IeKdeMytX82hwUYHF4tuNBO90/xHKtl54CzvLv5V9BT8JVhknpkeYd7CAF3iU+OIWO7PbEusG5R/v0wWgFaQxcIkPmH5OBrENyK8ZH9z212t2nZ9wZjcsFwxgllIyeWN74CWZTBFSQ5X5LT2Wch9Lr8e5W32KeeZJs7F+o4FyWGFoob6VjxNPwEvLfFgrJ/pJEzcvozFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mahcom.com; dmarc=pass action=none header.from=mahcom.com;
 dkim=pass header.d=mahcom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mahcom.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RylGCz9Mcklua3IGIEQlR/PQqkxvhNqaP0QrRmna1Yk=;
 b=xE2w58QC7ljwOzI6KLkW/k5sTFIBco7Q1k2qMGsSdEr14eqQu2GmPAm+apH9tzorf8q75l3kbcKt8jaxX9QwSjOJhVo1uVQxUo/Vpx0fjRMxpJ1KjMpQuZmu8wxzlmsBlDfHDCvTNM7+V1tSCdYO8dwzFKCJBeg3eht2S1RbilIcjU93ewpMdcao2xeoJ+85jbsRQtatrmUbN5vHWqvVTHe5MQHCOmCP0eywG2UjbZSMSKxKAaEbNFsSrmdMC/YfClUqvGOqfICoJro5Mp9TNsQ/ixjbDd+iB0DPYHaQOGEe52JggwAnVkzPYC6tGtoaoicsGrEC3GPAvQNWSu4J6Q==
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 (2603:10b6:20f:fc02::19) by SA1PR20MB4298.namprd20.prod.outlook.com
 (2603:10b6:806:235::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 03:47:21 +0000
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97]) by IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97%8]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 03:47:21 +0000
From: Brandon Mahdavi <Brandon.mahdavi@Mahcom.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "hzyitc@outlook.com"
	<hzyitc@outlook.com>, "lists@marzocchi.net" <lists@marzocchi.net>
Subject: [RFC PATCH net-next v2 3/6] net: dsa: qca8k: flood unknown frames to
 all CPU ports
Thread-Topic: [RFC PATCH net-next v2 3/6] net: dsa: qca8k: flood unknown
 frames to all CPU ports
Thread-Index: AQHdIjGfJMrBBcPf4UOMKclG0s5eyA==
Date: Sun, 2 Aug 2026 03:47:21 +0000
Message-ID: <20260802034701.3339052-4-brandon.mahdavi@mahcom.com>
References: <20260725032159.421627-1-brandon.mahdavi@mahcom.com>
 <20260802034701.3339052-1-brandon.mahdavi@mahcom.com>
In-Reply-To: <20260802034701.3339052-1-brandon.mahdavi@mahcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Mahcom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF42224DB53:EE_|SA1PR20MB4298:EE_
x-ms-office365-filtering-correlation-id: ae941938-14d2-414c-4477-08def048c21d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 94ksXKmqf5kun1Q+yGwaQ2y8m6vLi1RJ/kBQvTDmlrLuPDnX/5O2k37B+kI82pSUFkKWd2XPza6AwjXiEyu+rpnQn4AgVvyvk7sMCLas3PV1VtQz2HXr6KSKRpwIXlIRxheLzNBGlW8Ud1o2NlEf0sNBmsq+c8d84d8ou+LdyaYywIGf8n2CTfmyqJJJiJjblRI8sM1t8oYFZF5ZuzE/4wjnCkUDADGVLhYoo+o364ze5NL9JiBgHflhUlvECSNYWBlF8bRSWpIf2tqXSrf4WL7hJXJI0HgAoJpH3RX17g6cM9Ea2NKN5XPqjT8/8z0yfFEh7OfG/GoZrkZnNItnK4+7ASM2cUy8TCLyoNYktb38J61uCLVIhYgjyByydeCmdIOtdZgo6giCRBcEz72KpmOz56gTozjz/iMIW0PZseS7YbpHEPQGw9y+8LyQA7GCOuWNDx7aqm746ueBowV0JsZne2rs0I++Qez/YWjWmjRI8Gly0EzNbopApOSLY73p8xPJk8F6GD412h3bkvrDAW0zfdWBppPmUGpaHLMZhJxcrEavh5F9byZ257N6yS6BNW06unjnjc4neJCHVw/huh6qNfDr21o1fZ/DkXuw7E0RsK+BWaxzt1btgvskUfvVRePcOWI/OGDKao5ACIYRrxUnTbv16OQXVVfYq+hVy8OPdE6C/2vmP6dyynKgbV/947g65XJuFBUH1f+7uVrkMsULEiVM/X9pC33wVimJL1A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF42224DB53.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3I2reK0U0abMhJ4TJKbv7CvCGBVAy4LN0owdeGKglkcdNfsDEpsiaUmeq+?=
 =?iso-8859-1?Q?F/bIcX/GDZsu7prBLBOnKY0oT1tHyQfS74vz/LPePwVhYN/KkAk6Yt3XjH?=
 =?iso-8859-1?Q?CzplCBhdHySEil4BKCF1LauSI4GxrddbFofEIYCQaM27YW67p8Yw2PdW4u?=
 =?iso-8859-1?Q?fVCyr383XMQDL+VJrM/OTD2h751cg236WJHXqqHpGpcs46a74QMGPbi004?=
 =?iso-8859-1?Q?GEjBw26S+h9WU3kbA+mEI8Riy7cwNuD4TF8UVaHbgLDNov/VnLTZLiiwY/?=
 =?iso-8859-1?Q?VrFilDAylImo5sBYewB1yDPZR9TdaA9g9Pm7Yo4I+wGW239UwJM+GwLjjD?=
 =?iso-8859-1?Q?9HXLlTu6gFCXnt54AKLhTXJYnywXAWMoXMm3AcFwysWjiff5xTSngPPQ8x?=
 =?iso-8859-1?Q?n5HsmtXBZkLZ1gM5dF5/xdli/kPxDb7uaD/jSodWjgPkSlF5gNOBwjaA5z?=
 =?iso-8859-1?Q?wraftHdXRqJ/FfeJv8Gr94qD0oBov/UP4T0Mly7g2P8BeumF24KdXfUX4B?=
 =?iso-8859-1?Q?9ES7hLSHIewE/qto/ItZgDBfrLm7XFOCNE/nItdfLB8KEaBFjuqo/V0evH?=
 =?iso-8859-1?Q?UHxabH7ruK/gc+0JfDFEvGy79L2W0hDqHXq7jU2gZvRyAkAxRbJxAUnh05?=
 =?iso-8859-1?Q?7B8cLAGkSFJ9YaZ+GO/CHaaA+aQ+VQstjm44OYnce7ps9pJcvJ1F9Sf8wZ?=
 =?iso-8859-1?Q?/F0fHM5fHsyT9nSuCrWlBNJHnyn+VNF3md7bN35bAsFsFDTuQj1o8AVCyA?=
 =?iso-8859-1?Q?gtxeL1bVyb52/Hnpi1eWZraVGrVbhdPE55cr9n/iVKkiDeYSUaBARmGsJ5?=
 =?iso-8859-1?Q?6TjYy7MewlDHhchHHaH+JDvDV5s9FNtSJnGo2MF1Hr4LFuhYqtGSOXmCot?=
 =?iso-8859-1?Q?1GNjnNb3nt4fYWbIP3dIQ/WQ1M8t8ZYU9HY/9KEQkS+xIv92DhGK2fyTZg?=
 =?iso-8859-1?Q?YeS8rIe/tTIAyMpKCCsEaeucSSWjw/zPVkAoHRMZVW3GKStJcdcn1lmeB0?=
 =?iso-8859-1?Q?vahUwOGfFcFq1gi6n+sIsG6DWg2H0Fq9qWKPYqT22e9S5z43/ZvGuhK8m+?=
 =?iso-8859-1?Q?PRUQDdKHqOTjSHC1kI9kMUYx1fHIv7w5q8z0raRzDkt51LQWnb9NIg2ic6?=
 =?iso-8859-1?Q?j+IX9mshcyEDw3CdDdf9AVQQ85MA2lfb6VxBtliiQInQa2DPp6+CsgmXdC?=
 =?iso-8859-1?Q?QmQq9oFdRIKRjQevu5I6hk9UMNbp8XuGR8Y0X8iVTserHhprtY0Eg6Pcqc?=
 =?iso-8859-1?Q?hXYu1td9LxZ+qQ9mF8W3a6hHAEtFtNRczXuSCpCSaJOF/v1T4i56PCA5JL?=
 =?iso-8859-1?Q?lXaimQJBBmvKqcQBHNEr0PFt1udnAS14TBGUpX/26vJ2c7GPZf4cbGW2I0?=
 =?iso-8859-1?Q?PSeF7X2tbai8nsatWw58K0Bn8IX+z7kyHV99sOVHzAiPHM6fs+Q4baSL5f?=
 =?iso-8859-1?Q?m2Ql3QukDNzlCQ9su6v3RBNSadVKXjtnnCyuHIrWDRRLRIxJ/VdwOzHzAv?=
 =?iso-8859-1?Q?iKGsEuNLVi8NcXib4Yaq1EMdVCGORcrGkAsQcvT4u0CqaEmuezYd7B+JTH?=
 =?iso-8859-1?Q?5V+2tmvDGMQrqK6FciLskT4elhTsyThYBcPFSfYUIGcD4fVXA6CGnPUhZ1?=
 =?iso-8859-1?Q?4mn2gBlOAkww7TfeYjSEO8Eu8FCMLiJSIfjhtl4n4LEXCSWYG2f5Z1uZ/2?=
 =?iso-8859-1?Q?E/42ZS6rlWdfUR52x0VN8JzuB7Th5qBkuKBX4GD62P8b7Du7yjQTEidF1N?=
 =?iso-8859-1?Q?GCRCmHw4hfanLf/mHU9CbNYegSOI7bBECjSAMksC7bBm8CvSnFMirrp9C0?=
 =?iso-8859-1?Q?HI31NGFCMQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Mahcom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF42224DB53.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae941938-14d2-414c-4477-08def048c21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 03:47:21.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92901e00-cf2e-4465-88d5-f158582648a6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1+zbjcKiZk0evlTqG0MVWEo8BLtj7u58UalStInQPBE46jVsRQZfM3rSj4dVoKAp9dnVyReSZEUQOMPoUsmeldU+4U7FDFl199vULEFtTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4298

From: Christian Marangi <ansuelsmth@gmail.com>=0A=
=0A=
A multi-conduit setup requires unknown traffic to be eligible for=0A=
delivery through every CPU port. Program all DSA CPU ports into the=0A=
global IGMP, broadcast, multicast and unknown-unicast destination=0A=
masks.=0A=
=0A=
Per-port lookup membership still controls which CPU port can receive=0A=
a frame from each user port, preventing duplicate delivery.=0A=
=0A=
Link: https://github.com/openwrt/openwrt/commit/500dbaefd2a6a1c9c0d81e275a2=
8c6a8e26519e4=0A=
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>=0A=
Signed-off-by: Brandon Mahdavi <brandon.mahdavi@mahcom.com>=0A=
---=0A=
 drivers/net/dsa/qca/qca8k-8xxx.c | 13 +++++--------=0A=
 1 file changed, 5 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8=
xxx.c=0A=
index 9dce23aaed76..4adc5081d05d 100644=0A=
--- a/drivers/net/dsa/qca/qca8k-8xxx.c=0A=
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c=0A=
@@ -1922,15 +1922,12 @@ qca8k_setup(struct dsa_switch *ds)=0A=
 		}=0A=
 	}=0A=
 =0A=
-	/* Forward all unknown frames to CPU port for Linux processing=0A=
-	 * Notice that in multi-cpu config only one port should be set=0A=
-	 * for igmp, unknown, multicast and broadcast packet=0A=
-	 */=0A=
+	/* Forward all unknown frames to CPU port for Linux processing */=0A=
 	ret =3D qca8k_write(priv, QCA8K_REG_GLOBAL_FW_CTRL1,=0A=
-			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_IGMP_DP_MASK, BIT(cpu_port)) |=0A=
-			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_BC_DP_MASK, BIT(cpu_port)) |=0A=
-			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_MC_DP_MASK, BIT(cpu_port)) |=0A=
-			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_UC_DP_MASK, BIT(cpu_port)));=0A=
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_IGMP_DP_MASK, dsa_cpu_ports(ds)) |=
=0A=
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_BC_DP_MASK, dsa_cpu_ports(ds)) |=0A=
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_MC_DP_MASK, dsa_cpu_ports(ds)) |=0A=
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_UC_DP_MASK, dsa_cpu_ports(ds)));=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
