Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FBE36B939;
	Sat, 10 Oct 2026 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791597712; cv=fail; b=R6UFO5vh1de4cvQXIwWEn+M8vV4T2nE4HruwkMzStM8NXgXWji2hr+/OaDO01b6Q0zcJRkqnSyyoED4gH6HjJyERIZFIai3KUgMqFWFhRvXU1ANOHxiKsbMREl659h5x5SlM5KfiQNa553Nbp+iLqgOqKNfIbfUumGxjSwDDY/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791597712; c=relaxed/simple;
	bh=5tbzjSLWZD5kYJO78qINBc0jHaz5sPYE6qlKIhIICBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t65wFdQkFs+tvPBQjpXRyvizEtan9WjDa7YTV4Xk70oxgfhg4whsqpuKO/V3ded2CzEGk75gMSTyIwrJhc96WT5j5tXxE9GRIvemdicHL4Go+vsCUaapyU1VCmwgHjTlWdkYs/iuLuzabimTV0hE72nvAofOi9VQ2wz9s37NpXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S9puvCLP; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S9puvCLP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxVexJdsdo3RTBkWqXeUQXn9bsYCAZP+yvwK8wz/AigocgLCTUDsyYllKaXRgD5Vaq19e5fUATo1wAmlvidI74EhVukW129cadr3cyAyihGhtqP9ywZQqKL9rVKPAl7IGtNpEYUiFbyhuN0wZ/lLl+46ADdnjQsqUF7qfFJkSuNAgIA4B3n4g5OxPQQLudmtWfA8xCymBg2FNJUKf+H3asGAUUW0yJQCjawvIDNJWk6h/VlCwNmgouuaaCuz1Qf7tDG8vmPDhQlfDVjtlN0LGCBadLP7Q/AehY59tmTajfrR0JmnSV/S9dGWvr/h78Ne71z5lEXsm60THUIebEfd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tbzjSLWZD5kYJO78qINBc0jHaz5sPYE6qlKIhIICBU=;
 b=NoAK/G473lC2jjxiVuwXyiWIiBqMf7TF31IhYZBUrRLsgoWMc+j2yn0z+rUzvzn3jos7o6XDiSG9XTEpQpheMxVDReBFaUMkU3fj9/olgEoKMXKqTmnhjoD9EoP9e5rG2tw6zUe5z3Sj8JIjASwD0w/YtkRkbzbgU3WZuzxvwYIUipezuBCz5wFMsJBvCiRjDPAjm24tobo9LKnqhZjQdZj69XTBE4dizYl8yfN++/9oUtPM0+q1R0+n9PBtmaguLPXNs/ub/tdlYybTg33yI/NQyFIkMorkPUNqOfSpR+2ruyRtx5AKmCeSARi+oGgbG09wQnwW14OqMNdRM8nnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tbzjSLWZD5kYJO78qINBc0jHaz5sPYE6qlKIhIICBU=;
 b=S9puvCLPmWXw/mxoZJ7sKWVFpjSXr8+f7Dk0wMQZLWyyNWOgcSb9Dr4nzD5zZnJ2FKkeWBA1pi9WztNVgVZLzJ+IDDCEPFHY/V5V3mIO+EgbsAHmwLSO6sX/uaPLrDvC0jN7DYjujbCaM8TETIOtacoFWsawczO0P/8Zyv0FsiKtUpATxp0P8Wq4B7F8IPEzmjJOjIYjqREdYG8GmHvlKImW8VnvGDMk7QWNr/n8xoVn+VpoJ7dgojtAvZhijGDDoXngKwZbl+0LRkj+AEeJ3XEp4qA37GrfaWun8gbwaEAsAEu4wiH8Z3thofv51YTQ1rGT9HJznhFNOef+nZb15g==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by MRWPR04MB11496.eurprd04.prod.outlook.com (2603:10a6:501:75::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 02:01:47 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 02:01:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
CC: dl-S32 <S32@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v1 2/5] net: enetc: Enable probing of version 4.4
 devices
Thread-Topic: [PATCH net-next v1 2/5] net: enetc: Enable probing of version
 4.4 devices
Thread-Index: AQHdV+todoZtUuB4hEiKAorU+ERkYLb2Aydg
Date: Sat, 10 Oct 2026 02:01:46 +0000
Message-ID:
 <AS4PR04MB9338CC6990BCB8781706AAD088912@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <cover.1791548316.git.claudiu.manoil@nxp.com>
 <701f38d08f9ea371877645223e6ac919af7870b5.1791548316.git.claudiu.manoil@nxp.com>
In-Reply-To:
 <701f38d08f9ea371877645223e6ac919af7870b5.1791548316.git.claudiu.manoil@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|MRWPR04MB11496:EE_
x-ms-office365-filtering-correlation-id: 690e9d85-7a98-462f-51fe-08df267270be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003|10067099003;
x-microsoft-antispam-message-info:
 PDaa6n5O7l1klPEDyD2O/sfnCzL6GlxwuG8Fy2gLFVrbCzYHBqDYW42YoCltj31H7ZqzjPlkIvz9e9ofaFJUtLg60N6f4p1gzzSmBjxTJZxfy7QIrfyBmDBjgyaRW4+ESOD1Q3j3gPee3XmHiKVUXx5ok1CIItVTp9Pktq+9soh5pkItVEgxuNybxkr44IOeaKY7I7qEJmrCnAA4NPna1PUQLZFCGN7DbXNgE/+so7+ksjLNDhgH1YkYXi40QfOIsIYpy9iB6mmSN6ZsZwXI7g0asweU2ZvFJViS3th7NyyFcOGH4MYdzF3+BF7BTTVm+2sglhR3ByodU5REQlZLpMKeZofDv9PFYX+QoLszMf2akXdx9ku1/p9BSjH3cQ3jGpQR8UTb0OZhJV9vcj+v3gSst+pfnFtkC7Vytd2IQ3ERb7671anoFF+tKst/5kdhsKFl5X0c9lViGu/v3kQ5Pr3Dr+de4fMzVNlyQl54plGuGy7xcx/oWxW9IerFmrIn9DOqypmPH28UoL4/YeTaD0U/Sjj3BPfcX5ubirVKgPvWmaXw/uOGKOGfp2ACsvm2QtVw4jvrQ/gr4G602rg/LKtmZMa7qsS52FgCf5mLK9jvdkt4qoYGONdr27ypHDCdN1ButCGvb8th5QjsrstCoJEROLrbb6hN96bjRP+7Ejtgo84zgMlKBF4I/SBMgPGba0hI2S6G6r5Fvvoaa5KcQ/03sBAhKZMMyQxHSX9LwPI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NGRwwB7UOCSfiFzh1RqRvGxzsap8ZE9YxZZDO6Xf2kxC4ARwtuv7W/EsPDXw?=
 =?us-ascii?Q?u9qrMMH9v0FhPrOzEgpf9ZG9OdGeB3CT/IEZ9FS6jiwAAMXIkVVy2bzDEK6U?=
 =?us-ascii?Q?r4FmsdsYziStjOM/sGu+rYs1Lp5+CPP8zMgGUeMf2WtVk7Qtzw8lOd68GSTS?=
 =?us-ascii?Q?q5KPwxHYDGC8TGBNqeXQxljjY9ghErJI+SE7ztVYZmQrM77Glxa6Exqh4O8I?=
 =?us-ascii?Q?9sAIsK3VVJvqECJWUIhV+UZA9WY6OjVrzFybxG6JrNYrtLvQbeXM9B4AqXR6?=
 =?us-ascii?Q?1CZwrTGjhOrS3+f4emwFzdrukIXWaR86bp5nOHCEk69UNSAPTnNUydqhYRCC?=
 =?us-ascii?Q?jI7CGLRP0xHkc+Knvh7luarkUuvEwjOdEK8NgImMVprZ3YpP7PyHUxDqaLvp?=
 =?us-ascii?Q?oM/IgB3ba9yqKpkgJXiqf/ZAQnzxyuthFYX6+HBaIhfH9SGuxq/0MenVjbW7?=
 =?us-ascii?Q?1DD7Br+3+yQMBCU92M6GE/+o0gvHIWB0JfT4z4tz9zr4V9ihqt1ob7sFkvBi?=
 =?us-ascii?Q?zEyXvs4yNHxCaCKJzTPYnr8SV77k5nnM1swNs/DYdQzFJ9cgKygxZhNX/4+5?=
 =?us-ascii?Q?UE0EmrB4b1Eo+DoEWSqXJomCRW34if3jtb7gVgGNdrp5AnPcC2K9A7quXVMH?=
 =?us-ascii?Q?w9jwIlw4UgW9OQhGF1eJLhWh4KzkJVmQqgjQ42pHxU3r2PEsl4ItWbqNoJ0P?=
 =?us-ascii?Q?/mi87cctCLoHmWkqeGzrVkCNSIQqTEYK/MCn+EqCh036GokoLZyig+NrJfj+?=
 =?us-ascii?Q?AVOEdXePNIHJbB/8ZkFZOnWr9U7UXdX3u+QhH8HKJsJkCdXe03jAMJUodSi/?=
 =?us-ascii?Q?fEEtCnHnPOK/u6hupn2qcM8Fpjo4VOFVLEmNd7lxPyXF2R45cw6M7+f8tvNR?=
 =?us-ascii?Q?5MZpOZ2W9ONuOkDfnDBS6hFwb3TK1fmfKl8G8xVmn0iQl50bBJkIDA6desSx?=
 =?us-ascii?Q?AQ1hwY+yK96pqj/diHGaIcA9XkNbbeb/7GQjHLRzUP9GyEsG6Ynr1S7f8Rsu?=
 =?us-ascii?Q?G8xHE6fb7fXMUuQHP+RJPJA3g0OTJZGn1N3/KRB3/wsKiKHZTFl0IYrJWTsT?=
 =?us-ascii?Q?bo9dTH7C2dZWO0+w8J9VseQQGht/tQ74qZV69902yaXPNr+klifnsKo5esal?=
 =?us-ascii?Q?CuIMvzCQrdpDAeAabh8eNnds5EuPtUmWDvd52zPz9Tif9NSqYNM4DrZxUV0d?=
 =?us-ascii?Q?bj5WA7On0vlTOrHrn1x0egakL35P5ywPt+PHH8oMOKGka0atJgN9UPruOojb?=
 =?us-ascii?Q?L2/SMXpHN3kxJtSIpHi3sEufCl3lmgm0p7cLbsupjnB/BXeqg1hltFG+5rrY?=
 =?us-ascii?Q?TwVaoXCi/CPpR0Iwy/DfGzR/s+hbWd6nYN0V29vA6ky5jjyhezgWrKcMQ4Pr?=
 =?us-ascii?Q?yvQTIxuATtZtrJmnL7Rb3x175IwJ44ajgg0V6B8t98jX3U7HLgq5W1KPZSnJ?=
 =?us-ascii?Q?MpKk+FJV5bZYQEgwtUd45DU2sPMJ0/e0QpE/WNcAnXGSF6z55FWcsG8UHMv3?=
 =?us-ascii?Q?nXRS0+W82zts21BQYyh6pdSIwBWHT3ccxTjMELHZYaW+QDosc98WeyUIlCju?=
 =?us-ascii?Q?rZ0iJN9xaFA23lEbBHpQRjrtWoNwntsj1zUWZgOillfx5fSvbleJ58MJnFuO?=
 =?us-ascii?Q?zGH+R9mAHT3O4qVoy0eWG5lVDRF4EA2AnwNm3/oCm+v1FPUDkouT5lIS4FbS?=
 =?us-ascii?Q?TOlUdsMidJA0i5XEoWdODUfyzGrlGEXmMVRxvtLg8TEmWoPG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690e9d85-7a98-462f-51fe-08df267270be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 02:01:46.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjjwbTLVjOb38lgs5PONpAcU1ELYUiUR6KjKXmFI3eNt4/0orLeGk1uW7G5IYUGYXEQUdG8jQz/sd0rsSqQoYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11496

> The ENETC v4.4 devices are present on S32N79 SoCs and feature only
> Pseudo-MAC ENETC ports, whose PFs expose both the 0xe101 and 0xe110

I think the device ID of the ENETC PF with the pseudo MAC should be 0xe110.
The device ID 0xe101 should be only used for the standalone ENETCs (without
pseudo MAC). Is this a hardware issue? If so, a workaround is to set these =
PF's
device ID to 0xe110 in IERB module. Then the device ID 0xe110 will be prese=
nt
in the PCIe ECAM space.

> PCI device IDs, while the VFs answer to the usual device ID of 0xef00.
>=20
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>

