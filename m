Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF962404BF9;
	Mon, 21 Sep 2026 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021483; cv=fail; b=rMEt4vaQPCXwAps9huyUcKVvxeYdmwN9U/7O7lBQVuB9bfmeXj0AMQ+UhwMnOhhU0xFIfrEouye5F/+zg+WpQSNLsiv1YL0lI8oEL2ZSqdlq0u9mAw7eOXqp1cij88RMmCZdfZOkQgxtkLJa8qRSzKRk0qoOc+/trr6vsgRRAUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021483; c=relaxed/simple;
	bh=dBIFS9Dk2o6tTD1y7oWMggrJ2C06zNph19Wn7kfFPL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bZi3OoxIiKufOFZ1sG2u0JAPBdiS5c5C4Cdg07sWztQ5z7XfxNTglGdGndkfOpHQ2AkEHBP3ZIp5FSsZxlb6xZxYLAvQQtnTzBiCNcs/nWh2/tqts/OrVVmFlj4Zaq7vTOpd6xNcBOkoA7qjom82H/2Dy9PCYrFfag+PHBU/Cqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=m20ihlbv; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=TR0MhDWq; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="m20ihlbv";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="TR0MhDWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=yrBTbDxvLWVBobEvG160HhJnb46S8kz1YzuqxxY90RQ=;
 b=m20ihlbvfci449iH1P0AgQGuesdwxhT7XoJXXH/FuNiCDniZ6Q+qouIOAn5frxKD9GXyjEz70j6dDipvSn7UECNdento5uV/jcN6I4RWQzmHQKpKwmCac021xIF8kNHJgx9QjCs/XpYRG1M3U8CQ3s67suicSKhd1wANlY3iseeYgQPcOxp5edqRkr3HONDbU1f5f+iz/J+aX9pzVOuxSo1jGGUPSvr9UD6bKI9KyG5LNmS2Vh+TiqdO1vkL/seh9aGasGBET3vqT3MsEYEhZi0cma4PjMbsAulPUH4Yj1WpEYjHNKIj1zPrZ7lFrmtm0UZB1t7iH8aQ5aohIdQpiw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020102.outbound.protection.outlook.com [52.101.193.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B437780087;
	Mon, 21 Sep 2026 20:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHawfWQC9aFLNrCSHao1WvxCYspTPDNELkAjANP0TIHCDIrL4yV1kW50E2D65vI5em7sztiR0IvcJuW/tuopczoU9ChvrtTCpuUHLQeVeXoV3grnQLnxsP3EmGPl4Of56zvJmbN+usaunYrHMkwFLSNYStIFZHMe93fz48dVUFSvh3dJUgzZ4s9yGZjjzkwqSn1f+XZxLiQtYVbKzLylvwvFayyyUOPhvK2JN9mAUXMBfhzusaoDEu61g5kHG5qTZ3XyBOxZf5DIfYcUOqiz2hNabAv1XAES/2/gT1+rwtY+LWC/oIqUaBE7SYhhICIH+UA61trAGaUj5DfaYpyouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrBTbDxvLWVBobEvG160HhJnb46S8kz1YzuqxxY90RQ=;
 b=ovLbo+fCpXUv5YmJeqctznyM/ZEapaVHLgv8DmuEqUgx+tUc8LtK0YkafbL84wbz6byVDQp2cxFMG+qxhjG+MVREkHKPQpoFT4NaPVC7j1x1Ilc+ery8EPskidREyYQblNrZTw9vUo46P9J/qMl0paf/RW5XnmW7gFMD1m1WEiDvgjgLuodqjbf+r6dYsc97/wgrABFO7gUbRzPYM/P3ulpaWMSrMs/Ytsbd9Bw8S8vQYfooDjXLaa9sP4MNt8DnVWuSx0UgqOmIdAEg8gn2fTYqHWtKXn0CuwIj/pwmnCx5E3jaf1cSKiF0ZdNtFNC4sFEuBSiSL4wbGzROPUimKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrBTbDxvLWVBobEvG160HhJnb46S8kz1YzuqxxY90RQ=;
 b=TR0MhDWqEBTy8p1OLnqGHZIrJoFhLVX5ULCanM/x1L/36+B8PGwVnqbl2pCpfFUF75XX0wWBEe5+2bF5BlQnjT+wHZIN4fYpmWRoS92R4lqALJiB4TjODbL52rc51KWkOJmpQeS3skPa1PJQXtAIAUMwaPnRTT1GLPEvn/O7zt7jN0kf+qdA9tssn7gJXbcgmqfGtnpeVZ5IOTWe6eoORzvLYyOWyNoM9miAtGu4FcpobxXtEjQMsMPwHzTyHW1T5uOkKpb0SkTCc7Mgv+0/O5USyqsD4pLoOXUK67FIzkYDhsywHJmaFEoC+J0Oj/bCCAK1+ncvWeRcOoRQCebimw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:11 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:11 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "dev@kael-k.io" <dev@kael-k.io>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH v10 04/14] dpll: sit9531x: read DPLL types and pin properties
 from system firmware
Thread-Topic: [PATCH v10 04/14] dpll: sit9531x: read DPLL types and pin
 properties from system firmware
Thread-Index: AQHdSgVYHrBu0DoYf0So6A9OA8QJ7Q==
Date: Mon, 21 Sep 2026 20:11:11 +0000
Message-ID: <20260921201108.42676-5-arouhi@sitime.com>
References: <20260921201108.42676-1-arouhi@sitime.com>
In-Reply-To: <20260921201108.42676-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS3PR20MB7783:EE_
x-ms-office365-filtering-correlation-id: fbef6006-08c2-4f21-0217-08df181c7b03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 J9YFtQ9u378uTAPkcEPPqr5IliwRcrIyp0H8fSZT2O6pil5Zjw6kDbMae2jtBmicNfuOOj7ezquaOChamNifQgIeOjrZ45GTi8R6XVYdwp2uxAsoaYyJxVG02LpTFpauiKkMySlwgECvi58Lc6cwsjjmFas6w86LAfEt67m5vNRvMfkxYWB2t7DJn7mP1PXSiHKBJ8wH+AQSgfQVwIdkNID8kYCAyOsQmZmd/w+yIDzFXc4P3glAsfd3ygrFHBet4qBQct6nynkHNdrHTiPmBRX74oULi9lVJUZoFfclBiLRLNhfVN4Dc6KTkIBZSIbTJBLhzCNywxR0aJ6iGnqJos90BK1byjwLtgWtmRRhr/VoJ+FOgc0sDUb++umUtY/WyfMOKoDoL2Txad+oJ0Uv8z/2+E6ORnrHHgKUmhBwyqBDaS/dNmPf0pbYyc7YBHa7Ls/fNuLU0H29bs5Hfc4KOz6KvTVt0qQZ9ItP9GG/icdqk8DEaFhkSta8+/I7S/zTdFG3QZw383A9mSnv7nWpGnelhgikJCaW1rlh1jmI35cRieb7o+drJhNzU7jd8fy0RdHFjrMkOewHY+JJHbrGu1FEqQ4c/xTpNFVwpq5pm8kHpblH2TfIXFTbm+0d8b4b1Y2Vno+w+jvYVIfV8HOPrj1H7bx2ZDuW+gt9o0tg/VbNMebrm8ApnPbQrQ/AUCuef8bNpVXPfPuxDPbXhtEJFM24bDStyUXuIm1RqnFWn8M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dujbF0muxJNizOxhKcEll3f6IYIRsPbxhuRHP3O0cYN8Dyn5cc9Hw7neX/?=
 =?iso-8859-1?Q?XS30DQzBoPLxHpnD+Y4xcbPQ2HsX1/FYLfZRzOLehgikPskfxnVk+t2d9T?=
 =?iso-8859-1?Q?RZeXTYi6W70+hj/Cqr41LOaiKj/E85XycEfIJarVghNWUQnJoxMYujHSDJ?=
 =?iso-8859-1?Q?M3vHNzFsHm6rYYC+asSJMJS/rhkw3TFN1a4NM0EZJMN5DTNiLkX6ZRfsss?=
 =?iso-8859-1?Q?HuksHIP7/WIhAraqH5e7MBHOQA+Ci5a8iBDG23917x4B2e6lyRPLKyLIW0?=
 =?iso-8859-1?Q?x/fryViULjRyEyP2Lfx2ngCLOt92w2X+ABqX0QTCImEff730fZx7170mOd?=
 =?iso-8859-1?Q?GgjDgyLdKvbwbpckxPrIWr86xPEWyI8DNhifJ+tMskoGs3JHyRk7g5tH8J?=
 =?iso-8859-1?Q?vX1d9JGBWifOzFCMMNOIvMkpCiuRV2qxF+XuFwJ76r/3OkfhXQ+3nP7Pox?=
 =?iso-8859-1?Q?FEmkI+ulzAxzj7MlUIzy2Z9RAzmxptTLfuRHxCgZREXmlzpEXgbf9lBXNU?=
 =?iso-8859-1?Q?8wtdVSzA/CSRjI6vifaR+3QNEB677Zm+1n6p9qRijOpczZab16js28lgUQ?=
 =?iso-8859-1?Q?lWeKRLLKduwR/f1Zy7vTi2Z50gj0z7Yibea3n8ZTyEdvZswztk+2130YUw?=
 =?iso-8859-1?Q?PqAxnQAIDrpJ1kXwseTIlJJ565jfWr6/wHsCdx2DhpBOcqB6ahyncyuHRT?=
 =?iso-8859-1?Q?6e4QbrCfu3gzkSLLi20hQnFxGLP5VqMHu7q+AYAVV8uKENRkPg4JIkufYk?=
 =?iso-8859-1?Q?lsvTlN0AP6CZPOSRQ+KKrmWefCat0tGdQdBwN6lo48voTQ/23lbsQ1lzXv?=
 =?iso-8859-1?Q?BiNxBhT6sSMwuPkNzrw9vkXNAe/TX45mu+/3gYUPU9uPzov9aqYmpfXmHC?=
 =?iso-8859-1?Q?pNr4tqhWDEgWGTV0s5qaH8VMnDm8olGEkm6RGaxva9gq0vFziKo2pXAFHn?=
 =?iso-8859-1?Q?sqRaPVzvk+Xm0+c6cTbDCR10frdpC8K/DlilxM5eTEA0dspgek7erkFFWF?=
 =?iso-8859-1?Q?4rH2KOnUkffX7em8Zp4DPsTyAD62gefgzKFtKKmT6KB2uyUgsBpvnrTnTZ?=
 =?iso-8859-1?Q?QCrscS8kXARF/7E2sZtajXujunEG4UYylR014FVIELjbId1vEFAunH3ak6?=
 =?iso-8859-1?Q?qQuZ+LM2BaA0GVrS+3KVhh1XJnZ4TMWqd8JolJXOVg0JqOPEIzD7QZ9qEj?=
 =?iso-8859-1?Q?kORurQ2q3k621JODCmb3KK8siKli+Oa9Jf+dcv7g7mzRPh4uOxEo/Xv2ke?=
 =?iso-8859-1?Q?MwJgu5clem3Tnw8bPjcHOy7KishiWZ9Wq4F9GOlnHLKyiIbQjRrLCDitxC?=
 =?iso-8859-1?Q?OQGQTbBspb7uc1EV38/tqDXa5xyWhUr/nsjI+4vZbHBzwM0qk4KqWfMwsP?=
 =?iso-8859-1?Q?joEIUEdCzC9hi+aSuoBNfM9Tem/BEONeKV6XLhlhxyyp6XnDPm8h6feqav?=
 =?iso-8859-1?Q?yAaIRipv2VgrT2oKuejJm8HIx8GDPoxLPG2L+SRYpRgOOv1VJGiwnOqINt?=
 =?iso-8859-1?Q?3b4NE5g87DKHMOSPht5DK8Vz8I06GljdCNcH89Gi3s3e4InAJopKoB2aH/?=
 =?iso-8859-1?Q?rKRm6OOXE2QOa0bLQvPmcV4qilTp5rPNE5XxIRvQ+Z0xIs7tkHHFWtgIUB?=
 =?iso-8859-1?Q?lkbj5YHiEVnAuNi8WJy7Ii2xtEYDVMUEBV+NTCw8SQR9kUqP9Pyl7uclJ7?=
 =?iso-8859-1?Q?enx0U5gv2aOjiitnGRX4IFu5aSPBNjB3MfQugmmksNWRwT0pS8NDwx0Avh?=
 =?iso-8859-1?Q?XTIqg6AY5KYLgvvZh+BNF/72THtAWT5dEpvncO40ojfS7C?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jsQPcoymPqIdSunUfubhcan4fEwhxwM9pEh5p2nTdnl5Vkh1oU7Cq7LXV1+5ioBryvZyqtRWr7eMqabbJNWEF7gD52tD57/3SoXJwqupA7+6h3pBXSooG9vHM87GS1EjlSFVdemPhOs3qhvxwLwLOpjl5NYHW4sfxcImCm1Lbh5V5nnx4UJEeBNYCfjp4qhvPUUI06UMW/kRVNEs5XhoRiJEUjC/50oPuDUX2RFph3RBPw8sk3lB2f0zipa16vpeExNimp5LBa47SHHTlvegIL/M6ompRZxjxNB1bPnukVTT5++cKtgo5LOjXE4Dkwr4t7an0F0c0B7XjAVE0KCdFQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbef6006-08c2-4f21-0217-08df181c7b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:11.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmMy+YlUO3vjcm9HvF7CA3rJAWr3dIJZAluHw6F/l09ghpMvU8D7aki2vIjzRGpxNmRgvpR1sQQMhb1PPwRjGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021479-9LXFKUtvIur3
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021479;9LXFKUtvIur3;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The DPLL core wants a type per device and a property set per pin: a=0A=
label, the direction, the capabilities, and the frequencies the pin=0A=
supports.  None of that can be read from the chip -- which frequencies a=0A=
board actually presents on a given input is a board fact -- so they come=0A=
from the firmware node, with defaults for a node that does not describe=0A=
them.=0A=
=0A=
Input pins are interleaved P and N lanes of four differential pairs, so a=
=0A=
logical index maps to a pair and a lane, and a pair configured=0A=
single-ended presents two independent inputs where a differential one=0A=
presents one.  The labels follow from that, and the two extra input=0A=
positions -- the crystal and the inter-PLL sync net -- are named=0A=
separately.=0A=
=0A=
Two of the advertised properties are worth naming.  Outputs get a=0A=
phase-adjust window of one millisecond either way, which is wider than=0A=
the dynamic range but costs nothing and is what keeps the subsystem from=0A=
refusing every request; the granularity is one picosecond, because the=0A=
achievable delays are whole VCO cycles plus thirty-picosecond steps and=0A=
so form no uniform lattice for the core to check against.  And an output=0A=
whose node lists no supported frequencies is advertised as a continuous=0A=
range rather than nothing at all, since those pins do accept a frequency=0A=
set; a request inside the range that the integer output divider cannot=0A=
produce is refused when it is made.=0A=
=0A=
Kept in its own file, and introduced before anything is registered, so=0A=
the registration code that follows has nothing to say about firmware.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    Named and matched output pins by the chip pin they drive rather than=0A=
    by the driver's index for them, which differ on the variant whose=0A=
    outputs are bonded out from a subset of the slots.=0A=
    =0A=
    Took an output's current rate from its divider instead of the first=0A=
    entry of the list of rates the board supports.=0A=
    =0A=
    Advertised the phase-adjust window and the priority capability from the=
=0A=
    patches that implement them.=0A=
    =0A=
    Described the advertised phase window and the fallback frequency range=
=0A=
    in the commit message.=0A=
    =0A=
    Dropped the esync-control property, since the patch that read=0A=
    it has been withdrawn.=0A=
=0A=
 drivers/dpll/sit9531x/Makefile |   2 +-=0A=
 drivers/dpll/sit9531x/core.h   |  72 ++++++=0A=
 drivers/dpll/sit9531x/prop.c   | 430 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/prop.h   |  37 +++=0A=
 4 files changed, 540 insertions(+), 1 deletion(-)=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
index a221fe55386a..819af61123f5 100644=0A=
--- a/drivers/dpll/sit9531x/Makefile=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -1,4 +1,4 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-only=0A=
 =0A=
 obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
-sit9531x-y :=3D core.o=0A=
+sit9531x-y :=3D core.o prop.o=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 76a2632f0ce4..230b21b9e238 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -23,7 +23,17 @@=0A=
 =0A=
 #define SIT9531X_NUM_PLLS		4=0A=
 #define SIT9531X_MAX_INPUTS		8=0A=
+#define SIT9531X_NUM_INPUT_PAIRS	(SIT9531X_MAX_INPUTS / 2)=0A=
 #define SIT9531X_MAX_OUTPUTS		12=0A=
+/*=0A=
+ * INTSYNC (the inter-PLL sync net) is modeled as two pins.  The=0A=
+ * destination PLL that locks to INTSYNC sees an input pin=0A=
+ * (SIT9531X_INTSYNC_PIN_ID, in the input id namespace after the physical=
=0A=
+ * inputs and the xtal); the source PLL that drives INTSYNC sees an output=
=0A=
+ * pin (SIT9531X_INTSYNC_OUT_PIN_ID, appended after the physical outputs).=
=0A=
+ */=0A=
+#define SIT9531X_INTSYNC_PIN_ID		(SIT9531X_MAX_INPUTS + 1)=0A=
+#define SIT9531X_INTSYNC_OUT_PIN_ID	SIT9531X_MAX_OUTPUTS=0A=
 =0A=
 /*=0A=
  * struct sit9531x_chip_info - chip variant identification=0A=
@@ -41,6 +51,39 @@ struct sit9531x_chip_info {=0A=
 	const u8	*clkout_map;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * enum sit9531x_signal_mode - input signal electrical mode=0A=
+ * @SIT9531X_MODE_SE: single-ended=0A=
+ * @SIT9531X_MODE_DE: differential=0A=
+ */=0A=
+enum sit9531x_signal_mode {=0A=
+	SIT9531X_MODE_SE =3D 0,=0A=
+	SIT9531X_MODE_DE,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_ref - input reference state=0A=
+ * @freq:		configured frequency in Hz=0A=
+ * @label:		board label from DT or default=0A=
+ * @sig_mode:		signal mode of the pair this lane belongs to=0A=
+ *			(detected from CLKINx_INPUT_MODE at probe)=0A=
+ */=0A=
+struct sit9531x_ref {=0A=
+	u32				freq;=0A=
+	const char			*label;=0A=
+	enum sit9531x_signal_mode	sig_mode;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_out - output state=0A=
+ * @freq:		configured frequency in Hz=0A=
+ * @label:		board label from DT or default=0A=
+ */=0A=
+struct sit9531x_out {=0A=
+	u32		freq;=0A=
+	const char	*label;=0A=
+};=0A=
+=0A=
 /*=0A=
  * struct sit9531x_dev - SiT9531x device instance=0A=
  * @dev:		parent device=0A=
@@ -48,6 +91,8 @@ struct sit9531x_chip_info {=0A=
  * @regmap:		paged register map=0A=
  * @info:		detected chip variant info=0A=
  * @multiop_lock:	serializes multi-register sequences=0A=
+ * @ref:		array of input reference states=0A=
+ * @out:		array of output states=0A=
  * @xtal_freq:		crystal oscillator frequency in Hz=0A=
  * @reset_gpio:		optional reset line (DT "reset-gpios"), NULL if absent=0A=
  */=0A=
@@ -59,11 +104,38 @@ struct sit9531x_dev {=0A=
 	/* Serializes multi-step register sequences */=0A=
 	struct mutex			multiop_lock;=0A=
 =0A=
+	/* Hardware state */=0A=
+	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */=0A=
+	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];=0A=
 	u32			xtal_freq;=0A=
 =0A=
 	struct gpio_desc	*reset_gpio;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * Logical input pins are interleaved: even index =3D P lane, odd=0A=
+ * index =3D N lane of pair index/2 (IN0P, IN0N, IN1P, IN1N, ...).=0A=
+ * Index SIT9531X_MAX_INPUTS is the XO input.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_pair - get input pair number for a logical input index=
=0A=
+ * @index: logical input pin index=0A=
+ */=0A=
+static inline u8 sit9531x_input_pair(u8 index)=0A=
+{=0A=
+	return index >> 1;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_is_n - check if a logical input index is an N lane=0A=
+ * @index: logical input pin index=0A=
+ */=0A=
+static inline bool sit9531x_input_is_n(u8 index)=0A=
+{=0A=
+	return index & 1;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_pll_page - get register page for PLL index=0A=
  * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
new file mode 100644=0A=
index 000000000000..1a09bd168163=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -0,0 +1,430 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Retrieves pin properties from Device Tree firmware nodes (or=0A=
+ * applies defaults when no firmware node exists).=0A=
+ */=0A=
+=0A=
+#include <linux/dev_printk.h>=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/err.h>=0A=
+#include <linux/fwnode.h>=0A=
+#include <linux/property.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/string.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "prop.h"=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_pin_label - fill the package label for an input pin=0A=
+ *=0A=
+ * Split out so input-naming changes stay local to this helper.=0A=
+ */=0A=
+static void sit9531x_input_pin_label(struct sit9531x_dev *sitdev,=0A=
+				     struct sit9531x_pin_props *props, u8 id)=0A=
+{=0A=
+	u8 pair =3D sit9531x_input_pair(id);=0A=
+=0A=
+	if (sitdev->ref[id].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u", pair);=0A=
+	else=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u%c", pair,=0A=
+			 sit9531x_input_is_n(id) ? 'N' : 'P');=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_pin_package_label_set - generate package label=0A=
+ * @dir:	pin direction=0A=
+ * @id:		pin index=0A=
+ *=0A=
+ * Generates a package label string.  Output pins are named "OUT0",=0A=
+ * "OUT1", ...  Input pins are named after the physical pair and lane:=0A=
+ * "IN0P", "IN0N", "IN1P", ... for single-ended lanes, or "IN0",=0A=
+ * "IN1", ... when the pair is configured differential (the N lane is=0A=
+ * not registered in that case).=0A=
+ */=0A=
+static void=0A=
+sit9531x_prop_pin_package_label_set(struct sit9531x_dev *sitdev,=0A=
+				    struct sit9531x_pin_props *props,=0A=
+				    enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	/* The internal INTSYNC pin has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		strscpy(props->package_label, "INTSYNC",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* The internal XO reference has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT && id =3D=3D SIT9531X_MAX_INPUTS)=
 {=0A=
+		strscpy(props->package_label, "XO",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* The internal INTSYNC source (output) pin has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {=0A=
+		strscpy(props->package_label, "SYNCOUT",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+		sit9531x_input_pin_label(sitdev, props, id);=0A=
+	else=0A=
+		/*=0A=
+		 * Name the chip pin, not the driver's index for it.  The=0A=
+		 * two differ on the variant whose outputs are bonded out=0A=
+		 * from a subset of the twelve slots, and a package label=0A=
+		 * that named the index would point at a pin that is not=0A=
+		 * the one being driven.=0A=
+		 */=0A=
+		snprintf(props->package_label, sizeof(props->package_label),=0A=
+			 "OUT%u", sitdev->info->clkout_map[id]);=0A=
+=0A=
+	props->dpll_props.package_label =3D props->package_label;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_pin_fwnode_get - find firmware node for a pin=0A=
+ * @dir:	pin direction=0A=
+ * @id:		pin index=0A=
+ *=0A=
+ * Searches for input-pins/output-pins child nodes in DT, looking for a=0A=
+ * child whose "reg" property matches the pin.  The binding describes reg=
=0A=
+ * as the hardware index, so an output is matched by the chip slot it=0A=
+ * drives rather than by the driver's index for it: on the variant where=
=0A=
+ * the two differ, a board describing the pin it wired would otherwise=0A=
+ * have its properties applied to a different one.=0A=
+ *=0A=
+ * Return: 0 on success, -ENOENT if no firmware node exists=0A=
+ */=0A=
+static int=0A=
+sit9531x_prop_pin_fwnode_get(struct sit9531x_dev *sitdev,=0A=
+			     struct sit9531x_pin_props *props,=0A=
+			     enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	struct fwnode_handle *pins_node, *pin_node;=0A=
+	const char *node_name;=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		node_name =3D "input-pins";=0A=
+	} else {=0A=
+		node_name =3D "output-pins";=0A=
+		if (id < sitdev->info->num_outputs)=0A=
+			id =3D sitdev->info->clkout_map[id];=0A=
+	}=0A=
+=0A=
+	pins_node =3D device_get_named_child_node(sitdev->dev, node_name);=0A=
+	if (!pins_node) {=0A=
+		dev_dbg(sitdev->dev, "'%s' sub-node is missing\n", node_name);=0A=
+		return -ENOENT;=0A=
+	}=0A=
+=0A=
+	/* Enumerate child pin nodes and find the requested one */=0A=
+	fwnode_for_each_child_node(pins_node, pin_node) {=0A=
+		u32 reg;=0A=
+=0A=
+		if (fwnode_property_read_u32(pin_node, "reg", &reg))=0A=
+			continue;=0A=
+=0A=
+		if (id =3D=3D reg)=0A=
+			break;=0A=
+	}=0A=
+=0A=
+	fwnode_handle_put(pins_node);=0A=
+=0A=
+	props->fwnode =3D pin_node;=0A=
+=0A=
+	dev_dbg(sitdev->dev, "Firmware node for %s %sfound\n",=0A=
+		props->package_label, pin_node ? "" : "NOT ");=0A=
+=0A=
+	return pin_node ? 0 : -ENOENT;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_pin_props_get - get pin properties for a given pin=0A=
+ * @dir:	pin direction (INPUT or OUTPUT)=0A=
+ * @index:	pin index=0A=
+ *=0A=
+ * Allocates a pin properties structure, generates a package label,=0A=
+ * looks up the firmware node if available, and reads optional=0A=
+ * properties (label, connection-type, supported-frequencies-hz).=0A=
+ *=0A=
+ * Call sit9531x_pin_props_put() to free the returned structure.=0A=
+ *=0A=
+ * Return: pointer to pin properties on success, error pointer on error=0A=
+ */=0A=
+struct sit9531x_pin_props *=0A=
+sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
+		       enum dpll_pin_direction dir, u8 index)=0A=
+{=0A=
+	struct dpll_pin_frequency *ranges;=0A=
+	struct sit9531x_pin_props *props;=0A=
+	int i, j, num_freqs =3D 0, rc;=0A=
+	u64 *freqs =3D NULL;=0A=
+	const char *type;=0A=
+	u64 curr_freq;=0A=
+=0A=
+	props =3D kzalloc_obj(*props, GFP_KERNEL);=0A=
+	if (!props)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		/*=0A=
+		 * INTSYNC destination pin: a PLL locks to the INTSYNC net as a=0A=
+		 * reference, so it can be connected and re-prioritised.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+		   index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {=0A=
+		/*=0A=
+		 * INTSYNC source pin: a PLL drives the INTSYNC net.  It can be=0A=
+		 * connected/disconnected but carries no priority (driving the=0A=
+		 * net is not a reference selection) and no frequency.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+		   index =3D=3D SIT9531X_MAX_INPUTS) {=0A=
+		/* The XO reference is fixed: no state or priority control. */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D 0;=0A=
+		sitdev->ref[index].freq =3D sitdev->xtal_freq;=0A=
+		curr_freq =3D sitdev->xtal_freq;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D sitdev->ref[index].freq;=0A=
+	} else {=0A=
+		/*=0A=
+		 * A synthesized clock output is an external connection with=0A=
+		 * no more specific meaning; a board that knows better says=0A=
+		 * so through the pin's connection-type property below.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D sitdev->out[index].freq;=0A=
+	}=0A=
+=0A=
+	/* Generate package label */=0A=
+	sit9531x_prop_pin_package_label_set(sitdev, props, dir, index);=0A=
+=0A=
+	/*=0A=
+	 * Both INTSYNC pins are internal to the chip and have no board-level=0A=
+	 * wiring, so they take no properties from the firmware node.=0A=
+	 */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    (index =3D=3D SIT9531X_INTSYNC_PIN_ID ||=0A=
+	     index =3D=3D SIT9531X_MAX_INPUTS))=0A=
+		goto skip_fwnode_props;=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	rc =3D sit9531x_prop_pin_fwnode_get(sitdev, props, dir, index);=0A=
+	if (rc)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	/* Look for "label" property -> board label */=0A=
+	fwnode_property_read_string(props->fwnode, "label",=0A=
+				    &props->dpll_props.board_label);=0A=
+=0A=
+	/* Look for "connection-type" property -> pin type enum */=0A=
+	if (!fwnode_property_read_string(props->fwnode, "connection-type",=0A=
+					 &type)) {=0A=
+		if (!strcmp(type, "ext"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		else if (!strcmp(type, "gnss"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_GNSS;=0A=
+		else if (!strcmp(type, "int"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		else if (!strcmp(type, "synce"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_SYNCE_ETH_PORT;=0A=
+		else if (!strcmp(type, "mux"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_MUX;=0A=
+		else=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Unknown pin type '%s'\n", type);=0A=
+	}=0A=
+=0A=
+	num_freqs =3D fwnode_property_count_u64(props->fwnode,=0A=
+					      "supported-frequencies-hz");=0A=
+	if (num_freqs <=3D 0) {=0A=
+		num_freqs =3D 0;=0A=
+		goto skip_fwnode_props;=0A=
+	}=0A=
+=0A=
+	freqs =3D kcalloc(num_freqs, sizeof(*freqs), GFP_KERNEL);=0A=
+	if (!freqs) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_freqs;=0A=
+	}=0A=
+=0A=
+	rc =3D fwnode_property_read_u64_array(props->fwnode,=0A=
+					    "supported-frequencies-hz",=0A=
+					    freqs, num_freqs);=0A=
+	if (rc) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "failed to parse supported-frequencies-hz for %s: %d\n",=0A=
+			 props->package_label, rc);=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Seed the runtime ref->freq / out->freq with the first DT-listed=0A=
+	 * supported frequency so the netlink frequency_get callback reports=0A=
+	 * a sane initial value before any pin_set occurs.  DT lists the=0A=
+	 * physically-wired reference frequency for each input pin and the=0A=
+	 * default output frequency for each output pin.=0A=
+	 */=0A=
+	if (num_freqs > 0) {=0A=
+		if (dir !=3D DPLL_PIN_DIRECTION_INPUT ||=0A=
+		    index !=3D SIT9531X_MAX_INPUTS)=0A=
+			curr_freq =3D freqs[0];=0A=
+	}=0A=
+=0A=
+skip_fwnode_props:=0A=
+	/* Neither INTSYNC pin carries a frequency attribute */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		return props;=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+		return props;=0A=
+=0A=
+	/*=0A=
+	 * Advertise only concrete values from firmware plus current runtime=0A=
+	 * value. For outputs without a firmware list, publish one wide range as=
=0A=
+	 * an explicit fallback because those pins do support frequency_set.=0A=
+	 */=0A=
+	ranges =3D kcalloc(num_freqs + 2, sizeof(*ranges), GFP_KERNEL);=0A=
+	if (!ranges) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Publish the seeded rate only once the pin is certain to be built.=0A=
+	 * The allocation above is the last thing that can fail, and a call=0A=
+	 * that reports failure must not leave the device's cached rate=0A=
+	 * changed behind it.=0A=
+	 */=0A=
+	if (curr_freq) {=0A=
+		if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+			sitdev->ref[index].freq =3D curr_freq;=0A=
+		else=0A=
+			sitdev->out[index].freq =3D curr_freq;=0A=
+	}=0A=
+=0A=
+	j =3D 0;=0A=
+=0A=
+	/* Current frequency first, when known. */=0A=
+	if (curr_freq) {=0A=
+		struct dpll_pin_frequency f =3D DPLL_PIN_FREQUENCY(curr_freq);=0A=
+=0A=
+		ranges[j++] =3D f;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < num_freqs; i++) {=0A=
+		struct dpll_pin_frequency freq =3D DPLL_PIN_FREQUENCY(freqs[i]);=0A=
+=0A=
+		if (freqs[i] =3D=3D curr_freq)=0A=
+			continue;=0A=
+		ranges[j++] =3D freq;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT && num_freqs =3D=3D 0) {=0A=
+		ranges[j].min =3D 1;=0A=
+		ranges[j].max =3D 1000000000ULL; /* 1 GHz */=0A=
+		j++;=0A=
+	}=0A=
+=0A=
+	if (j > 0) {=0A=
+		props->dpll_props.freq_supported =3D ranges;=0A=
+		props->dpll_props.freq_supported_num =3D j;=0A=
+	} else {=0A=
+		kfree(ranges);=0A=
+		props->dpll_props.freq_supported =3D NULL;=0A=
+		props->dpll_props.freq_supported_num =3D 0;=0A=
+	}=0A=
+=0A=
+	kfree(freqs);=0A=
+=0A=
+	return props;=0A=
+=0A=
+err_alloc_ranges:=0A=
+	kfree(freqs);=0A=
+err_alloc_freqs:=0A=
+	fwnode_handle_put(props->fwnode);=0A=
+	kfree(props);=0A=
+=0A=
+	return ERR_PTR(rc);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_pin_props_put - release pin properties=0A=
+ * @props:	pin properties to free=0A=
+ */=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props)=0A=
+{=0A=
+	kfree(props->dpll_props.freq_supported);=0A=
+=0A=
+	if (props->fwnode)=0A=
+		fwnode_handle_put(props->fwnode);=0A=
+=0A=
+	kfree(props);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_dpll_type_get - get DPLL channel type from firmware=0A=
+ * @index:	DPLL channel index (0-3)=0A=
+ *=0A=
+ * Reads the "dpll-types" string array property from the firmware node=0A=
+ * and returns the corresponding DPLL type enum.=0A=
+ *=0A=
+ * Return: DPLL type for the given channel (default: DPLL_TYPE_PPS)=0A=
+ */=0A=
+enum dpll_type=0A=
+sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const char *types[SIT9531X_NUM_PLLS];=0A=
+	int count;=0A=
+=0A=
+	count =3D device_property_read_string_array(sitdev->dev, "dpll-types",=0A=
+						  types, ARRAY_SIZE(types));=0A=
+=0A=
+	if (index >=3D count)=0A=
+		return DPLL_TYPE_PPS;=0A=
+=0A=
+	if (!strcmp(types[index], "pps"))=0A=
+		return DPLL_TYPE_PPS;=0A=
+	else if (!strcmp(types[index], "eec"))=0A=
+		return DPLL_TYPE_EEC;=0A=
+=0A=
+	dev_warn(sitdev->dev, "Unknown DPLL type '%s', using default\n",=0A=
+		 types[index]);=0A=
+=0A=
+	return DPLL_TYPE_PPS;=0A=
+}=0A=
diff --git a/drivers/dpll/sit9531x/prop.h b/drivers/dpll/sit9531x/prop.h=0A=
new file mode 100644=0A=
index 000000000000..a65efdfd9ef8=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.h=0A=
@@ -0,0 +1,37 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_PROP_H=0A=
+#define _SIT9531X_PROP_H=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/fwnode.h>=0A=
+=0A=
+struct sit9531x_dev;=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_pin_props - pin properties from firmware=0A=
+ * @fwnode:		firmware node handle (NULL if no DT node)=0A=
+ * @dpll_props:		DPLL core pin properties=0A=
+ * @package_label:	pin package label (e.g. "IN0", "OUT3")=0A=
+ */=0A=
+struct sit9531x_pin_props {=0A=
+	struct fwnode_handle		*fwnode;=0A=
+	struct dpll_pin_properties	dpll_props;=0A=
+	char				package_label[8];=0A=
+};=0A=
+=0A=
+enum dpll_type sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev,=0A=
+					   u8 index);=0A=
+struct sit9531x_pin_props *sit9531x_pin_props_get(struct sit9531x_dev *sit=
dev,=0A=
+						  enum dpll_pin_direction dir,=0A=
+						  u8 index);=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props);=0A=
+=0A=
+#endif /* _SIT9531X_PROP_H */=0A=
-- =0A=
2.43.0=0A=
=0A=
