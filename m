Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF773F65EF;
	Wed,  2 Sep 2026 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385263; cv=fail; b=np9aEvi/qGKkwnaP6b7KM9BwvjgdA4m1cV0tVHF4jfwUK7CZHW0MKhwRAemWliL6K+qkpFjB6cCng8uord/j+HUG4CxjJz2M3dborQK5TXz9CnInrFbm0XFCLuh1o7s+ozxhJpZhJ6pe88o51GQOSncdRklzk/ny1LgNgyRJH/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385263; c=relaxed/simple;
	bh=Qx5Huam+LHucUxlGfghUjb3gyNWQHWIPEC+rzAal3fE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ee8e36J00BvlthX7sDR+mJYrFQ5VoZXF0ygA/jxYRXGNoRf+up045ey4L9qg3Mt5N70jVhUu1Jyg5dU6/oh8wzUDJl8x2D4UILRSfue4fZVebj39NBQN0eLzUltTrs4ATzJI86R8tkrmxTkGib4QJ/KBqTJ/5I1wFmVHSzanEJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=ZSqspf/1; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=IB6eit80; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="ZSqspf/1";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="IB6eit80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=6YY3MjdA6H/tNRgDUXs7K4hvCD9ZsezMbssT09/Ejs0=;
 b=ZSqspf/1+gGjOIA29WZjEXM0iJDXB2t9ihF8XCj2DOsA7nkdPM2QeN7/hVJeM4giQJLs2BM8Iy4J4+I6a1qpqeK7ZX4wqnmJVw7sbU+KYqEKzJBV44+gD11RizIvv+3dygqvqDkQ69zVyMHjLvC1MQt/kCEwSiXwiFXybWPxr9K5HaworYbQkw7mU4shSwlUOpfrpGUqqoo5bUXo8stGI27qSPxPNAySwxMLxeZBADcofTiPvZeF7NNwkHiQ/5BPEKwl8rFLlYmhuvHy9Lx339veHW477+CGbmHyOjKJwZKestEZcFowVOrrzA9SXOZEahs2C9/JL4stkZnRRFAX/g==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023110.outbound.protection.outlook.com [40.93.201.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 605F33C0086;
	Wed,  2 Sep 2026 21:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHJEbIP09ySySDU+XCl5Lm7JsOQ+1FVPyvR/IVt9vCDY03nmZWXIkS6Aq3fGuNgYXGepbzDyDy/lCHE8bpJ3OpA+8y94MuK6XUpDOAj1kf4jtsVgOvf+A7loFpJmrETtYgrvyp0xX8HdrzGQ+zIBKvzAroxAX9VRkCty8ZKDyscbp0GjYKSPwsiEEVB7CXyK5sGv51uHCJ+CeJPzeLuEm4/YuF7vfa4ZpGai8iSDMg20s94LFDpEQORD5qA5ULeSVENne5UgsjaFu8RJCN7/TTWWQOc4rOCxMv/+ff4oviWYD36T9C3BACxK9Bg7VsMAtorkOTcFJelYlPvSK2Bi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YY3MjdA6H/tNRgDUXs7K4hvCD9ZsezMbssT09/Ejs0=;
 b=CnPETVuYo28uaWYEvm+Pf2fEiqT60VN5Zqq4luGBuFkUx0WKY8Kspb4e8luifMyWIca3LSHg6PCD7BoUCP19iS95iEdNUKmi2cP1XqRPfHilScnVLBCFxBFSdt4+aM6fvB8Vi3KjGyXfeNNXPXGdQuXVJxlHDDZQAvFSE0qCODTwMkadMUmiKq2aSFgP/NpE6dtmhyExiYNqDttkYn2Ary5UrsqI9iAhOjAbjGh5r183dSNhWliBkE28Zn6A94kncGhR7PBMy4w+LrC2DFiiDq5TkBVlRqUkgmwW9+a26QMjPKst6f72OfPzMhqU8aa7vbjszAah2sEV8zVni7S4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YY3MjdA6H/tNRgDUXs7K4hvCD9ZsezMbssT09/Ejs0=;
 b=IB6eit800XFczgJvAbuit+VbsNXrJTm3KxB9KatrXVoWAGpuEtbx2KyQ9pN6MeRl3Na3/KwXrP21ooevxQS8o4D2PHZJTAtbeytF4I1sc5zCV5pf/VaV12isRlXXHDYXRs/p2CkxETs72Va5ubilrEIvcSt+MlzL/vV8qvL292COoBv0xrx0jt32O4m0kdIe9TJN9iDug8Uip6MwbcC6KKIqZK2yR55NsxJxcUeN4ijx0eC06Or0p/11pBTQxTWvetZoWxyfXR5F7Tpf4ZG1UXcEzo4X1E+SbVu/8ks0wGQA3Vs9Ah4zS33YerrRA79gHIGv8+Dmm+k9NtVOExr6Hw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:31 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:31 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH net-next v8 00/15] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Topic: [PATCH net-next v8 00/15] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdOyOteVjEkYcikU67LBe2iMR+3g==
Date: Wed, 2 Sep 2026 21:40:31 +0000
Message-ID: <20260902214030.20955-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS7PR20MB4877:EE_
x-ms-office365-filtering-correlation-id: 3b4f6c64-4df1-454f-3ff0-08df093ad02c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 UnaH+N3I3r4ptAkJ535xnwjfIbqJVM1DQJhWur/9KoUe8ULRc5VPcT7E5hiyM95WzIYb1o62N1KI2jhblGMJ+OUQrlhf4Pewoy+L9UxuXDtkiffhvjCywz2zbpDFU6QYWNUKrwtoinIYuym1ve9jo7LKsTIh42G89UZ9bsxauQfVBQnYK56ThZZm7xFzY5b7vdwA+9trVnTxTF2w1x1N5aXinYZ3VtCQqT8xk8p3mBZkbDlHS2GjSh0CTgQdI7FNiCxAoz7d4FA/l6mia9rqeex3O5Ck7e9aJqsrokbX2QPwr2iJ/rkz5mvdrMa1bpaLTXrB/oyAeS9xKmeM5js58r/tKBrWEOInMMPgsS26pTY8947NDXcvtiBXoG5oh6TmXQ0Nv2WOycWVIDSdwibrP+k4beByzhI1Q0ZtTVPHCIIhiOuFYjX9zoyCX7roFTFuvElFWkGN4sVbnkKxAHgSvCukis6pWOem6G1lsJivTutvh5q4sKmaWfW43UrWTsqSSR01dgyssgqMUg0Z7dJ4E39tyzOKZLtdXjaeufba1oElxiQCdnFU9lrq/UJXu8amBbfXp3obIw/bIMoUrkXJG/hV6WUoocWGRX4uFx2WXvLlXSZoAOhywucguq2LkyIvwJv8j93u/SV/X9gQ59OXokebktQMXSGh3ddVGWzoNujDrgb4a9FiUoF+DQI+Gmfl2AOPdi+Ek5JpXd0K4bTGoEDdic5eGrzsbRLuJBVRrUw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TrK0kgsxXxI4u9MvonZPIyZAgCiQqCKpBTq4tejagrdjtye+frRL/6ypzJ?=
 =?iso-8859-1?Q?ywp+oCzYYTi0e2joB/TfMo4s7oEqYmABEu3pThA5cnUs1+sgaAChkC0cmU?=
 =?iso-8859-1?Q?8qH7At2rU2ELIYFSFrInnNExpSli3lmteIb3eMuNkxpw6gDeIhA6oXawAd?=
 =?iso-8859-1?Q?vYjHJ0CUw+RfRyw0uyRRK0su9+dDuP/dpIlgx+j1ostTBDuvReRuPZbTF2?=
 =?iso-8859-1?Q?Fa8P8Cm64ZYBCuGp4MN3hY09y+U06TxRz5sjNqxBQViInb5SfjdDZtdxW9?=
 =?iso-8859-1?Q?sv1FyhuxxtYF0E34VPP0eR8F2Uvl2M/StBuPwKmYb8SPFoQoNw/UN2mAHU?=
 =?iso-8859-1?Q?GSir/tuKlF3PgVOobmHCBGDwnin2e8W9QcKwOG/RB7u+xppf0HtPvY22bF?=
 =?iso-8859-1?Q?qOduue+g3Ht/Qhs4mi7S8FEu07jF47qw3GiedG+zeGx/hDurAN1Z7YjHie?=
 =?iso-8859-1?Q?M/9/+bSCA1WNQujHh2uUQMxF+qooH3atIVFvAoWMGdVCUsM+pxmJRNo7jN?=
 =?iso-8859-1?Q?Gp7MoTcr9X/zl0AtJxod/0dQzTlrCe1L1wOLYJAkDj/LUB6BxqZfRR8YPS?=
 =?iso-8859-1?Q?H5FSGXbReFZwSNP9P0AwgXqSpLK8dsMvN7U7/qRRcbq2fdvkFiOJOdRK7/?=
 =?iso-8859-1?Q?UzWmt/26NhaPSIc7e6ri0BE4+zEbIo290rk5HOSsojMZU/zbR5F3NuLRAi?=
 =?iso-8859-1?Q?mQIq19QHFiWBfA0tSzT0rxzU2T0ckkb8KpwFM5adwFt/qECHps8IjPfgdg?=
 =?iso-8859-1?Q?t/lark52EKmnArWnbhC9WL7nUKwyOiwxgeY5EFXWbXprtvh/JppwGRUzct?=
 =?iso-8859-1?Q?EPh5Tni28PZksM3AuZfC739ALuvzshEsMlFDNwzXF845UpSOIdv+3YIirA?=
 =?iso-8859-1?Q?bK6v7qAC63ozR6qJq3D+BKUhFrI5WFInhQH0h+mlrAne8YcaBZ4dQwFT15?=
 =?iso-8859-1?Q?tOVbooR8C1k7c731CNLRiUHNiZK+ed+ftOip2UXdkE/Z63gI2K773Bsxyn?=
 =?iso-8859-1?Q?8TdVoylDgvJULxyooHodtYVn17rcDgPgW4PPNoObmJZpJVWzfEO/T+/F8q?=
 =?iso-8859-1?Q?gbBzRkUhtFmfCY4AqW38mIOne9WZ+cscs8z7YC6SPKmSWBglsQyEhhagx6?=
 =?iso-8859-1?Q?2/GIHq9byzpor1yn4WEyl3sxJz/IhQHKycsb/MJ/7CbxymaEDW8m/Kj/gf?=
 =?iso-8859-1?Q?HQpRHi1kfrY0ezCXiolNLowSP8K+zI8koqR/K/R6D99AjgzHx7eL3EXin3?=
 =?iso-8859-1?Q?E+vG7Umd5HnrYa9AbDpV5f1I6n11vWnNYYDlTj6aCNewBtQ1mJsVyRUzSt?=
 =?iso-8859-1?Q?BioM8aYT3HVczcW18Ug865DnXFsEAYFEdm3GUcfKWXpPyBWBU+XDIwgzJq?=
 =?iso-8859-1?Q?CjUI1TacCv/yqjvMXDXVJBYLURdh5Yy3UoWnIHJJfxBBueE8aIOSKsRhzt?=
 =?iso-8859-1?Q?XlKMre8tP2YZMX+Nor0FMXBvyAU1o9zkOkc6OLkx7RL7IWwVqSVWe407vz?=
 =?iso-8859-1?Q?jgGCHUZB3ZChduRo9Kq8kRlt/oKmfY0LW49pN+OETDKVcBvKshDFQIKCUR?=
 =?iso-8859-1?Q?FbTEUDsmjIu77lv8J+FayghDC4e4aihfLq8ov+CK6zkEDGzgVX23IWadMb?=
 =?iso-8859-1?Q?J5g9GkWT0GIARSt1OGlrazgkM7nJPSx7fPWWHgYeyIxJjrz9KQ2oIzRqeM?=
 =?iso-8859-1?Q?DdATPKnrgvsR+OtAfkIBHM27xJjI+Xs4jJgF2nC88BW9F5/8+Ds6V3UIeJ?=
 =?iso-8859-1?Q?CAJ8mFwLjRQf93/5s6OCQU80EFfXZLs7Gf3HCxNeq+NxWg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ScIB31WqcY9ZgjnV700bIchvh3+vzv16109tB3cTVN8kZziTViF1op7j3+wfB/cz1dAR7XA55APPfEA+9jAgenaPk9wB9AcC1/9YdmqaH1YGYO72tWqVQTEpDLOHG46ZAKKqF5YlNX3vJZcPAbjEgFol6ZgRkjWrTHPlMMtdLO/y3DDYI3DpHeDJVlibHh528zgkwZ2zVPNcilI2KzehjFOcCsp7SUsdtnXu1duAsYPsBZLpnk/AfrAb6Oo2xazJkfin4GsNjWqm/NuyeBWQF0JWQuiZBXdEI5QLpbnymsDR/teu7Vy1zE6yCpqJZ4pUO4tJPC65sRmHr6EfM/m0ww==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4f6c64-4df1-454f-3ff0-08df093ad02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:31.4722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnINU0HJoktGlHZ7jTslBQfPgOT373a9vOcV7vDMw96Nu1YzeQZkKv4yvR7fPO3dvpK51QOgBbATyL7K9MiFJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385238-DYprTt_HtoIm
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385238;DYprTt_HtoIm;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

This series adds a DPLL subsystem driver for the SiTime SiT95316 and=0A=
SiT95317 I2C clock generators. Each device integrates four PLLs with=0A=
automatic reference selection and on-chip TDC phase-offset measurement,=0A=
and is used for synchronization in telecom, networking, and data-center=0A=
timing.=0A=
=0A=
The series contains the device-tree binding, the driver under=0A=
drivers/dpll/sit9531x/, and the MAINTAINERS entry.=0A=
=0A=
v1: https://lore.kernel.org/netdev/20260511211143.19792-1-arouhi@sitime.com=
/=0A=
v2: https://lore.kernel.org/netdev/20260520191943.73938-1-arouhi@sitime.com=
/=0A=
v3: https://lore.kernel.org/netdev/20260731180951.65725-1-arouhi@sitime.com=
/=0A=
v4: https://lore.kernel.org/netdev/20260806232439.27551-1-arouhi@sitime.com=
/=0A=
v5: https://lore.kernel.org/netdev/20260810230439.22866-1-arouhi@sitime.com=
/=0A=
v6: https://lore.kernel.org/netdev/20260812175337.18155-1-arouhi@sitime.com=
/=0A=
v7: https://lore.kernel.org/netdev/20260815221919.64226-1-arouhi@sitime.com=
/=0A=
=0A=
The driver was a single 5.6k-line patch through v7. Vadim and Ivan asked=0A=
for it to be split into logical parts, with the first zl3073x series as=0A=
the model, so v8 introduces it feature by feature instead:=0A=
=0A=
  1-2   bindings: vendor prefix, then the device schema=0A=
  3     basic support: paged regmap, variant detection, probe=0A=
  4     DPLL types and pin properties from system firmware=0A=
  5     register the DPLL devices and pins, and keep their state=0A=
  6     input pin state on a DPLL, with the pin-state contract=0A=
  7     input pin priority=0A=
  8     pin frequency, both directions=0A=
  9     output pin state (mute)=0A=
  10    output phase adjust=0A=
  11    esync on outputs=0A=
  12    phase offset through the TDC=0A=
  13    fractional frequency offset of the selected reference=0A=
  14    the inter-PLL sync net as a pair of pins=0A=
  15    optional device-tree overrides for two board facts=0A=
=0A=
The two bindings patches come first, so the driver never matches on a=0A=
compatible string before the schema that describes it is in the tree.=0A=
=0A=
Each of the thirteen driver patches was built on its own, with W=3D1 on=0A=
x86_64 and i386, and is sparse clean. Each one also links: no patch=0A=
calls something that a later patch introduces, so the module builds at=0A=
every step of the series and a bisect cannot land on a tree that fails=0A=
to compile.=0A=
=0A=
The split makes no functional change of its own. The tree this series=0A=
ends at compiles to objects byte-identical to the tree the single patch=0A=
produced once the fixes below are applied to it.=0A=
=0A=
Changes in v8:=0A=
=0A=
  - Split the driver patch into the thirteen patches listed above.=0A=
=0A=
  - Advertise automatic mode only. v7 mapped DPLL_MODE_MANUAL onto the=0A=
    chip's free-run bit and then refused DPLL_PIN_STATE_CONNECTED on=0A=
    input pins, so it offered the mode whose one purpose is manual=0A=
    selection and refused the only request that mode exists for.=0A=
    Free-run selects no input at all, so on this device it is a lock=0A=
    state, not a selection mode. v8 advertises AUTOMATIC only and=0A=
    refuses anything else from .mode_set(), which now clears the outer=0A=
    loop disable bit so a PLL left free-running by the loaded=0A=
    configuration returns to selecting from the priority table.=0A=
    Free-run is reported through lock status as UNLOCKED.=0A=
=0A=
    The device can also pin one reference while the loop keeps running,=0A=
    so real MANUAL support is possible later. It is left out here=0A=
    because the mode mapping becomes ABI once merged, and it belongs in=0A=
    the same series as the userspace that needs it rather than being=0A=
    approximated now.=0A=
=0A=
  - State the pin-state contract once, above the pin ops, and let the=0A=
    two selection-role pins share one implementation of it. The driver=0A=
    had five ops tables and five hand-written encodings of the same=0A=
    state machine, and every review round has found another place where=0A=
    two of them disagreed. This closes several findings at once:=0A=
    CONNECTED reported while the outer loop was disabled, membership=0A=
    taken from the shared-receiver refcount rather than from the=0A=
    priority table, SELECTABLE on an INTSYNC destination userspace had=0A=
    disconnected, .prio_set() inserting a source that was never in the=0A=
    table, and .prio_remove() returning 0 when the disconnect would=0A=
    have emptied it. The last two are now -EINVAL and -EBUSY.=0A=
=0A=
  - Report LOCKED_HO_ACQ only once the holdover estimate is valid. It=0A=
    was asserted whenever the loop was locked, without reading the bit=0A=
    that says the device has accumulated a frequency estimate good=0A=
    enough to fall back on. That bit is distinct from the one that says=0A=
    the PLL has already switched over to holdover.=0A=
=0A=
  - Fix the 32-bit build. The output phase adjust reduced a negative=0A=
    request modulo the output period with % on two u64 values, leaving=0A=
    the module with an undefined __umoddi3; it now uses div64_u64_rem(),=0A=
    which the rest of the arithmetic there already uses. Reported by=0A=
    Jakub Kicinski.=0A=
=0A=
  - Correct the register model comment: the page selector is at 0xFF and=0A=
    a page holds 256 registers, as the definitions right below the=0A=
    comment already said. Reported by Ivan Vecera.=0A=
=0A=
  - Type ordinary clock outputs as DPLL_PIN_TYPE_EXT instead of=0A=
    DPLL_PIN_TYPE_GNSS, which claimed a GNSS-disciplined timing port.=0A=
    Advertise a phase-adjust range on outputs only, and drop the input=0A=
    pins' .phase_adjust_get with it: inputs have no .phase_adjust_set,=0A=
    so a non-zero range promised something every set would refuse.=0A=
=0A=
  - Always issue the loop lock in the programming commit, so a transient=0A=
    I2C error cannot leave the chip in PRG_CMD with its loops open. Undo=0A=
    the global enable when the INTSYNC enable fails partway. Take=0A=
    multiop_lock before testing the selected reference in the frequency=0A=
    offset getter, as the sibling phase-offset getter already does.=0A=
=0A=
  - Latch every read of the chip's debug block the way the phase read=0A=
    does. That block returns a sample of an internal measurement tap,=0A=
    selected by a read code and latched by reading a trigger register.=0A=
    The generic helper read the trigger once where the phase path reads=0A=
    it three times, and a single read returns the previous latch. On=0A=
    hardware this showed as a frequency offset that would not move while=0A=
    a phase measurement of the same PLL tracked a temperature step=0A=
    cleanly.=0A=
=0A=
  - Report which PLLs came up and which EEPROM profile was loaded, and=0A=
    warn when a PLL drives outputs without having reached its active=0A=
    state, or when the profile's stored and computed CRCs disagree. In=0A=
    both cases every register still reads back a plausible value, so=0A=
    nothing about the failure is visible until the measurements come out=0A=
    wrong.=0A=
=0A=
  - Say what the phase offset getter measures, next to the callback: the=0A=
    loop's residual error sampled with the loop closed, which is the=0A=
    quantity the ABI asks for -- not the vendor's open-loop=0A=
    phase-difference procedure, which would need the digital loop filter=0A=
    frozen and would leave the PLL undisciplined until something=0A=
    released it. A netlink read must not do that.=0A=
=0A=
  - Drop fifteen register definitions that have never had a caller.=0A=
    Eleven describe that open-loop sequence and the PLL restart path,=0A=
    neither of which the driver performs. The other four -- the PLL page=0A=
    macro and the three DIVN2 fields -- had no user in any patch of the=0A=
    split, so there was no honest patch to introduce them in. Each will=0A=
    come back with its first user.=0A=
=0A=
  - Binding: put the example VCO frequency inside a band. 6251500000 sat=0A=
    in the gap between the device's two bands, which the property's own=0A=
    description rules out; it is now 6900000000, which a shipping=0A=
    profile on our SiT95316 board runs. This is the only change to the=0A=
    binding since v6 -- the property and its description are unchanged=0A=
    -- so Krzysztof's Reviewed-by is carried across it.=0A=
=0A=
The AI review's use-after-free report on the pin properties remains a=0A=
false positive: dpll_pin_alloc() calls dpll_pin_prop_dup(), which copies=0A=
freq_supported with kmemdup() and the labels with kstrdup(), so the core=0A=
owns its copies and the driver has to free its own.=0A=
=0A=
Ali Rouhi (2):=0A=
  dt-bindings: vendor-prefixes: add SiTime Corporation=0A=
  dt-bindings: dpll: add SiTime SiT95316 clock generator=0A=
=0A=
Oleg Zadorozhnyi (13):=0A=
  dpll: add basic SiTime SiT9531x support=0A=
  dpll: sit9531x: read DPLL types and pin properties from system=0A=
    firmware=0A=
  dpll: sit9531x: register DPLL devices and pins=0A=
  dpll: sit9531x: implement input pin state on a DPLL=0A=
  dpll: sit9531x: add support to get and set priority on input pins=0A=
  dpll: sit9531x: add support to get and set frequency on pins=0A=
  dpll: sit9531x: implement output pin state on a DPLL=0A=
  dpll: sit9531x: add support to adjust output phase=0A=
  dpll: sit9531x: add support to get and set esync on pins=0A=
  dpll: sit9531x: add support to get phase offset on the connected input=0A=
    pin=0A=
  dpll: sit9531x: add support to get fractional frequency offset=0A=
  dpll: sit9531x: model the inter-PLL sync net as a pair of pins=0A=
  dpll: sit9531x: allow the device tree to override two board facts=0A=
=0A=
 .../bindings/dpll/sitime,sit95316.yaml        |  171 +=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +=0A=
 MAINTAINERS                                   |    7 +=0A=
 drivers/dpll/Kconfig                          |    2 +=0A=
 drivers/dpll/Makefile                         |    1 +=0A=
 drivers/dpll/sit9531x/Kconfig                 |   17 +=0A=
 drivers/dpll/sit9531x/Makefile                |    4 +=0A=
 drivers/dpll/sit9531x/core.c                  | 3317 +++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h                  |  381 ++=0A=
 drivers/dpll/sit9531x/dpll.c                  | 1335 +++++++=0A=
 drivers/dpll/sit9531x/dpll.h                  |   69 +=0A=
 drivers/dpll/sit9531x/prop.c                  |  406 ++=0A=
 drivers/dpll/sit9531x/prop.h                  |   39 +=0A=
 drivers/dpll/sit9531x/regs.h                  |  377 ++=0A=
 14 files changed, 6128 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.c=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.h=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
=0A=
base-commit: d0ec95a8a4e79f2fd6063fc8932415db8c227689=0A=
-- =0A=
2.43.0=0A=
=0A=
