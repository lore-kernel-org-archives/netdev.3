Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD123BCD20;
	Tue, 15 Sep 2026 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430441; cv=fail; b=WZWj4gKNBtE8XGTHY2lPwCsFCD5B16dOrK5GSBUHoyPaz+lK7xz8I9M3LZFt+E5MeIMCve/JJCcaPHUGgordY8UDPNBUq8qxymrxFKCrsKv49FKkGYCcsTU6KvMbvOxl8QQ/COs29yntTK5NwBoX9dGGnHMZnDdVAWAFLjCsMHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430441; c=relaxed/simple;
	bh=elmoQrEcK51WJEVfZ/GQL/yPZXFejI+QPAZa4u125SI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZSjc/J6uGuskTIDeNQCMD+cbf3QeKeEZZvWMInn/AMFd3fiUqRwGJhA8CrYyjrWNoRDFaLDGaH5Yc70bNPlymdqBpptg6Mucz2+13eG8uJcE+35BBrRlSgtNJAxupAOwj/cVWDwYXfEfsodDyhV9LQcow6Kp/47lTy6iEWlGBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Jw7NvHAH; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=iTFdTr02; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Jw7NvHAH";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="iTFdTr02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=DMtXwaEujTv6BTqzEMGH8DUmBLQqbFsRyj7ziJ94M7M=;
 b=Jw7NvHAHGKJLmWpOE3pAAchvFIz90DIacVpcO/m/7LJtt8W+aPnLuSd7VmeGm6lx8h0DMDmq6nv1KD6gyyAlmdLYWPDCGjaG4b0NWONLQkvYBah3BogUIxjqQQ1sTfMTN7vk/uy5T/w4uyNPI6OsdV3uwkg2jqbiibMD8I1otJvKBbplMUylXy2kJrocv5nF4y9D3+YucR9ddq+0XvnLm/WF3c021SvtU0yfeB5IXRotVABOhmGTAGKuhzcY/9bwjW/PbSFP7mKXuAFUdjvqxEAn35Z4AxLPYlNq0JlQX2/JzPytvAvB0PTGrxKhTZh7qKC9Be0XHTH/htj7uT/C3Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021133.outbound.protection.outlook.com [52.101.62.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B5B30B00069;
	Tue, 15 Sep 2026 00:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmIs8Tf/fB/Gc8F5qzDg0UqSSsIEMNhoefhqCkXOjGaQMxkchj2xxF+yCBmaYVz7gnR+2+mxwofWe8evz6hKN297L5kIF0zi/AJTsHss5/n7xQgJRaq8NXGFTQ/W8xoe5P+/9cxhGA9OlaenSNJV96Zg5g7F98SuFksnAFLhDQWKOaWkDT+IjHJbAeFmm93n2nuKa8T9sjXGkMgF1b6S06tZkzsovMvJ8bvmk3zysJEywFYA0VjZMB9t4Dk32eb4mfNEBJIa4KEMnHuHJn/VGoJy+HN7BxaFqF27oEnX7GHd7y7lqx/YJlNR9NO+2KLtjsYntfsb2E25KbVgaYpDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMtXwaEujTv6BTqzEMGH8DUmBLQqbFsRyj7ziJ94M7M=;
 b=uzbf2+mw8bGpa9BT4xkkmQuxZJxupJIVNRVwyjF3W7+5qLQc89UFlcQz+QHyxvM5Pahn6XOa/rtIWHi6eekV7xGVmGveQ5HMTLt/YsL7nPGUuUDmTVPuR6WYJrWKe31UULsm79hdjVCYqYvuzGMD3wZIZNBXUXqs4BbVe9u2Evd+VGK7tDNJtwH5VG57oSbjC3ri4MzrpSVqqLX0iZ6K2Ijm301d3QJp21b5/7GIC6XsTqswBzh4cSaPUtvDcvSFwkcUnQs6KwxVOfo4cx9VggOPM3AG78Ga7g6m8GZPRdJzOsVlXn9q3yEhvGHcAyCYVvty+ll8Y4Tjh5MMOzyiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMtXwaEujTv6BTqzEMGH8DUmBLQqbFsRyj7ziJ94M7M=;
 b=iTFdTr02apObv8gmH6qqLQTjK1+dsl1g2LcV1DNdNB7xlceQ3M4j1SrwEi+onc29ll5rGYqBFVmZH6a+qg3QYnVVJ1ccHglqy4TLDY3DSueSTey9e/yhRXaEadvGt9l+aar+dFsWC6EgIAfaFCatNwafCWErz/fFlKNmWClltWJ2hCMNyKTMR7zoAJey1dkBIZ5CE5ZCl3kxRJbF4NNcgcooX1IcZSyFVLo7P0yMPmNWIU/TN5k/iCvxgEIvAZAGj9UkpBTdFOPNpHc+pWQH5RZqp9SDrV1SIZ2iu7IDouhIA7enPh6u/LpfXCdMuiqY8LrUVjZ0cmigyvi1BhNDig==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:32 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:32 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v9 14/15] dpll: sit9531x: model the inter-PLL sync
 net as a pair of pins
Thread-Topic: [PATCH net-next v9 14/15] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
Thread-Index: AQHdRKU0Rho/XEQU1U25zeXQcy41Rg==
Date: Tue, 15 Sep 2026 00:00:23 +0000
Message-ID: <20260915000015.80480-15-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
In-Reply-To: <20260915000015.80480-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB4277:EE_
x-ms-office365-filtering-correlation-id: 71034859-1182-48d5-a3aa-08df12bc5c5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 I1scbFhXFpAGIBCVWKHi4vcyj9Ehs9gpCrQ06tFDI9stx3gG/IPjfeUCAdtP6kySmCWYjm1pCp7yRB75EvqpqJ1OL9nl7DREU7IKRWs2sflZXzNi0veQt9OMKVblHqfqs45qPTRYxTJ/t4L48aYxLQDlyM/xGdvAQcm/0okS9S7mtT5qVaUrRR4StAsHTYCSg7ARvejMjaZTgtLlWYeLGDpHH3ft5rgZdx2PuOPX8tDoy1vtA5nmxcu16f6v8ny33HsD2vb+5ttaYt328yXu+sbntz8y216iCloAejNXJDFfl91d+7kEMQrrd/sFjFle3CVkEggwzqrLg/AkLNLxGhAMBhCY9Im9w+lsqMxetnJOlS3LFw7IzvVV/mwbbRA+i5Hdi2MXD4E3kUxiiMxsUSb9BkdwJWVyYp6Y7iEJBuGCL1k03N4BXQpROH0Hfl6gKCqSXfj1e1lkyEM8VcRF7P84/XEyN987GsihpqMVNdMWKt7nNIz0xJJIJ19KtyOmGYCoVpFlyBpBXnP2DOJG63FusuNAshWDo6HvtH2mK57J61EHmQc+s0qu/qrRyI6sIeQlub3Qymz3CZbriGXQGojSfKmAoMejUPjBi8QreFRG/rHYEU7/6Tszx3FulwyGVLA2qjPXEnRz9sAEimvthC+TbRhM0JkB7PW9xwq+1ynMvJeBzgMPmXvF9eGEiKholX7BFrSZH+Kp4DxnOKfTcLy1o2t19IacfW5ZhwtAAlU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OyGklxhfbGAuZOfSE7ztWRJD3dfgJTfd4lq8BEXtmnGG/gYH8MT+CE/Yl4?=
 =?iso-8859-1?Q?MR9z2Co3G+EFXgqQnZmCufmUBjuEg8UfvYL+DXH1IRLOs9Ypz8Zar4oq+A?=
 =?iso-8859-1?Q?7Zos9HjizBOISBr3HOBuL4f49y+8EGmOmXrkpz7io6Yf/6CfF2oTX/VvBF?=
 =?iso-8859-1?Q?Ao7EY1+kD/suyK+1DDiIPE9XZCvyTG4sMP1aIkaoFT0WIDPXJISyiSwwYz?=
 =?iso-8859-1?Q?MkfaZ75liQAtdRlM6MZLDk8bbFhQldZ2zBgIOv1i11Olua3El2G3BtoZHp?=
 =?iso-8859-1?Q?yXEusdMNfuldKziR3b4sAW21AQas7ASLoxVdhqLtTvs+50+tTrISEl0cU9?=
 =?iso-8859-1?Q?kjTq/+Mr5xRYhJVrprtvMSPRHNBsWVI9gML9So+YaJuRs93qkhebqki43b?=
 =?iso-8859-1?Q?memcGyev//hRaoS8QO9P5gM1tqxx7DNwaiDQZWr7mp0OU6s2DV5U3Hx9H+?=
 =?iso-8859-1?Q?X34FDLdFr/PVtEmws7D8cK9M2StrNtA9OLE8Nh6U7rvD15cksICLpq/Ed7?=
 =?iso-8859-1?Q?NAde0pD8m6/i5Z2BMIBdFI5t40rQ5bPQ2JawG3n0CpAhcrMeKEhzttwIdv?=
 =?iso-8859-1?Q?T04oCX1P6AROonobGbsLCtkcKt71/b2UUk/S4L7b8AfhDZ59TR4ALyyDWM?=
 =?iso-8859-1?Q?rUGe2LCHpmNz0p1JEnV7tqDu48XF7BcVXNKz2Y4SaNuS/JDdrpPfJ0h2zq?=
 =?iso-8859-1?Q?HJF9Y3D0TPyasmTQhK9FmFQGMqEbccPEJMGYn5nS8wGMRPi603stRDACI2?=
 =?iso-8859-1?Q?7IYaS+hbYAPREK7whyRXbbnqVoJWNQ7YXbQxTCPuInT/rGA97hqJVyTP1B?=
 =?iso-8859-1?Q?TwZhfASoeIK5inBFFxml/lAyrnlvIy05U9HG6v45PWoAwRMmgBwEbA6To+?=
 =?iso-8859-1?Q?5VKI9jfKt9m43UWywIwRhqKVBRCEq3zy/tI0qOEWf9YmJWsbJ45ln3N9wg?=
 =?iso-8859-1?Q?t/brCaBBbDxldggsEBcFBv+pHNL11mwf2poJKM/X3ibZuyb42uv2gCuBin?=
 =?iso-8859-1?Q?FWMGTYFh4YixSDFa0oGSGRZ8kQsOZM8WJ9fmd1BzhqmvaGkG8IaI3HnlHl?=
 =?iso-8859-1?Q?W9zNiJtu872pOqHV4sp72hEPJwRfc+ZoZrs6YzChUhusL4JNFsv1n5tvVt?=
 =?iso-8859-1?Q?WM+cfco095AIL/IzZmX6xGn4pJ0RQeH9VRIre7bKeFvLxWvVg3ZSrvVrY9?=
 =?iso-8859-1?Q?41pOSTs73VzFFzrZFUl0kYPONDOxz8SCpUtygJlB1bYHuqOFmgGCeX3eAQ?=
 =?iso-8859-1?Q?PgNja4zSSZjK58PdVJ6YiVzsRuBOl+aBR6C8VPYQjQeLYfDHennMk6qFBF?=
 =?iso-8859-1?Q?Hkq/WONDD5WnqLDgqOgt276iL+K4WZCmUJlRAT30jDp1qPvRMIytlHOKCi?=
 =?iso-8859-1?Q?VJf9gYddqFPoVO1AVdKsNjr+A2SOIVPckqjiJ9wmtEbSTZnbPTt4pfTrjy?=
 =?iso-8859-1?Q?VYBa0dCKABNp7ChEig+A70hSJ/KhRgSc3LcgMa26s7FnBjFh8/ag231chM?=
 =?iso-8859-1?Q?tyTyDX2A/lfgCSUORc4UpdoRd1BpX3QF6mf6R8yme9XFOOcepXUaU1dSqj?=
 =?iso-8859-1?Q?itM6NQDS0u3E8VhvkYQjG0Zb+nyIaaF1oRDw8VEjH6iCw6k7e62PDnuQ00?=
 =?iso-8859-1?Q?syMCRGLwRzmkP7AEH4xXPvwVSg6vdZ0vKs3GJehbLm1kdbF+BsRyQu8uo9?=
 =?iso-8859-1?Q?0xlEsdnYdh1UKt1x9/plHir1utgOEOUMCmShLl3MfKXJVrB/IwAsbOpFNd?=
 =?iso-8859-1?Q?v/oai5uxlAynkBjm7hwjlDA1qjdNGBnjn4qtWTdna/Iwtc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	DvvnmYDsY7DcU4ZCUBE8SXW9LLW/kVJH5HCosIHfzub14sRiyl/6rLx1Z8po08MNHAc6MhsxPouqBepBRRsTPlTp8DzWVH1cASpeawzR6DIqHjs2pT+hzSC+ztbYsyl2SdW+O025QQ0dNj8HpQP9yTCG3HpmldLv6q5pklifv39cJu1r9aOgmkAACw3DAn/rMMxpUyUZdUXjpViiTqkmySgd5WA8nexg9b1K22LFUAEZiMDYZiB9xYttPYmU7gzR9SJz34v8/vrVfou/mCgF5IjmrxfhOiDCCPJULjqwIKQpIowEqaz5mKd8vklXObV8SgwAv1jpeS8Pnjy9mAcmmg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71034859-1182-48d5-a3aa-08df12bc5c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:23.5771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvD1aJrigQpHZEI2cEofgO7CD61XKuG83glFOKuEmOinuqtyhDG5OZiyYj1WGRYsujh0zP9rH4O/12k4PRglkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430437-V2TmIE38fRxG
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430437;V2TmIE38fRxG;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The device has an internal net by which one PLL can drive the others: the=
=0A=
source PLL puts its output on it, and any other PLL can select it as a=0A=
reference instead of an external input.  The two ends are nothing alike --=
=0A=
one is driven, the other is selected -- so they are two pins rather than=0A=
one: an output pin on the source and an input pin on each destination.=0A=
=0A=
That keeps each pin honest about what its state means.  The source pin=0A=
reports whether this PLL is the one driving the net, and setting it takes=
=0A=
the net over or gives it up; a destination pin reports whether its PLL has=
=0A=
selected the net, and behaves like any other selectable input.  A single=0A=
pin would have had to answer both questions at once and could only have=0A=
been right about one of them.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 243 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   3 +=0A=
 drivers/dpll/sit9531x/dpll.c | 235 ++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/regs.h |   3 +=0A=
 4 files changed, 476 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 88bfa63b2975..b15859890caa 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -2024,12 +2024,13 @@ int sit9531x_output_freq_get(struct sit9531x_dev *s=
itdev, u8 out_idx,=0A=
  *   base + 3  PROG3  PRG_RST_DELAY[15:8]=0A=
  *   base + 4  PROG2  PRG_RST_DELAY[7:0]=0A=
  *=0A=
- * Outputs 0-5 live on Page 3, outputs 6-11 on Page 4, with each=0A=
- * output's block at base =3D 0x15 + 16 * (out_idx % 6).=0A=
+ * Slots 0-5 live on Page 3, slots 6-11 on Page 4, with each slot's=0A=
+ * block at base =3D 0x15 + 16 * (slot % 6); the slot is the physical=0A=
+ * output position from clkout_map[], not the logical output index.=0A=
  *=0A=
- * The chip only supports unsigned positive delay.  A negative phase=0A=
- * adjustment (advance) is wrapped to (T_out - |phase|) modulo one=0A=
- * output period, which is identical for a periodic signal.=0A=
+ * The chip only supports unsigned positive delay.  Requests are folded=0A=
+ * modulo one output period: positive delays wrap naturally and a negative=
=0A=
+ * phase adjustment (advance) is rendered as (T_out - |phase|).=0A=
  */=0A=
 =0A=
 int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
@@ -2282,6 +2283,225 @@ int sit9531x_clear_notifications(struct sit9531x_de=
v *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * INTSYNC configuration register values.=0A=
+ * These are written to the source PLL's EXT page to enable/disable=0A=
+ * inter-PLL synchronization (lock frequency PLL to phase PLL).=0A=
+ */=0A=
+struct sit9531x_intsync_reg {=0A=
+	u8 offset;=0A=
+	u8 en_val;=0A=
+	u8 dis_val;=0A=
+};=0A=
+=0A=
+static const struct sit9531x_intsync_reg intsync_config[] =3D {=0A=
+	{ 0x2D, 0x02, 0x00 },=0A=
+	{ 0x50, 0x08, 0x00 },=0A=
+	{ 0x51, 0x04, 0x00 },=0A=
+	{ 0x54, 0x02, 0x00 },=0A=
+	{ 0x55, 0x28, 0x20 },=0A=
+	{ 0x5C, 0x0F, 0x00 },=0A=
+	{ 0x5D, 0xFF, 0x00 },=0A=
+	{ 0x6C, 0xDD, 0x00 },=0A=
+};=0A=
+=0A=
+int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	s8 src =3D -1;=0A=
+	u8 global;=0A=
+	u8 pll, ext_page;=0A=
+	int rc, i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &global);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	if (!(global & BIT(SIT9531X_INTSYNC_EN_BIT))) {=0A=
+		sitdev->intsync_src =3D -1;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	for (pll =3D 0; pll < SIT9531X_NUM_PLLS; pll++) {=0A=
+		ext_page =3D SIT9531X_PLL_EXT_PAGE(pll);=0A=
+=0A=
+		for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+			u16 reg;=0A=
+			u8 val;=0A=
+=0A=
+			reg =3D SIT9531X_REG(ext_page, intsync_config[i].offset);=0A=
+=0A=
+			rc =3D sit9531x_read_u8(sitdev, reg, &val);=0A=
+			if (rc)=0A=
+				return rc;=0A=
+			if (val !=3D intsync_config[i].en_val)=0A=
+				break;=0A=
+		}=0A=
+=0A=
+		if (i =3D=3D ARRAY_SIZE(intsync_config)) {=0A=
+			/*=0A=
+			 * Only one PLL can drive the net.  If a second=0A=
+			 * one matches, the registers are not describing=0A=
+			 * a state this driver put the device in, so say=0A=
+			 * so rather than pick silently.=0A=
+			 */=0A=
+			if (src < 0)=0A=
+				src =3D pll;=0A=
+			else=0A=
+				dev_warn(sitdev->dev,=0A=
+					 "PLL%c also matches the INTSYNC source pattern; keeping PLL%c\n",=0A=
+					 'A' + pll, 'A' + src);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	sitdev->intsync_src =3D src;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_intsync_enable - enable inter-PLL synchronization=0A=
+ * @src_pll_idx: source (frequency) PLL index (0-3)=0A=
+ *=0A=
+ * Enables INTSYNC global bit, unlocks the source PLL's EXT page=0A=
+ * debug registers, writes configuration, and triggers a small=0A=
+ * update on the source PLL.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx)=
=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val | BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Small update on Page 0 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	usleep_range(1000, 2000);=0A=
+	if (rc)=0A=
+		goto err_disable;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PLL_REG_=
DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto err_disable;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].en_val);=0A=
+		if (rc)=0A=
+			goto err_disable;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, src_pll_idx,=0A=
+				   SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				   SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		goto err_disable;=0A=
+=0A=
+	return 0;=0A=
+=0A=
+err_disable:=0A=
+	/*=0A=
+	 * The global enable is already set at this point.  The caller only=0A=
+	 * records the source PLL when this function succeeds, so nothing=0A=
+	 * else will ever clear the bit: undo it here rather than leave the=0A=
+	 * net asserted with a half-written EXT page.=0A=
+	 */=0A=
+	{=0A=
+		int rollback_rc;=0A=
+=0A=
+		rollback_rc =3D sit9531x_intsync_disable(sitdev, src_pll_idx);=0A=
+		if (rollback_rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "INTSYNC rollback failed after enable error: %d (original %d)\n",=0A=
+				 rollback_rc, rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_intsync_disable - disable inter-PLL synchronization=0A=
+ * @src_pll_idx: source (frequency) PLL index (0-3)=0A=
+ *=0A=
+ * Clears INTSYNC global bit, writes disable values to the source=0A=
+ * PLL's EXT page, and triggers a small update.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx)=
=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val & ~BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Small update on Page 0 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	usleep_range(1000, 2000);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PLL_REG_=
DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].dis_val);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, src_pll_idx,=0A=
+				   SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				   SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_output_pulse_ctrl_set - program per-output PULSE_CTRL byte=0A=
  * @out_idx:	logical output index (translated to chip slot internally)=0A=
@@ -2875,6 +3095,15 @@ static int sit9531x_dev_state_fetch(struct sit9531x_=
dev *sitdev)=0A=
 		return rc;=0A=
 	}=0A=
 =0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to detect INTSYNC source: %d\n", rc);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
 	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
 		rc =3D sit9531x_out_state_fetch(sitdev, i);=0A=
 		if (rc) {=0A=
@@ -3355,13 +3584,13 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 		if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
 			return true;=0A=
 		if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
-			return false;=0A=
+			return true;=0A=
 =0A=
 		return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
 	}=0A=
 =0A=
 	if (index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
-		return false;=0A=
+		return true;=0A=
 =0A=
 	if (index >=3D sitdev->info->num_outputs)=0A=
 		return false;=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 1f77ff28ec81..5275733a3b4a 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -252,6 +252,8 @@ int sit9531x_input_prio_set(struct sit9531x_dev *sitdev=
, u8 pll_idx,=0A=
 			    u8 input_idx, u8 prio);=0A=
 int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			    u8 input_idx, u8 *prio);=0A=
+bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev,=0A=
+				 u8 pll_idx, u8 input_idx);=0A=
 int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			       u8 input_idx);=0A=
 int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
@@ -279,6 +281,7 @@ int sit9531x_clear_notifications(struct sit9531x_dev *s=
itdev);=0A=
 /* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
 int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
 int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev);=0A=
 =0A=
 /* ---- Output pulse control ---- */=0A=
 int sit9531x_output_esync_program(struct sit9531x_dev *sitdev, u8 out_idx,=
=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 2a973364a9cd..3efe6fc90701 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -42,6 +42,20 @@ static bool sit9531x_dpll_is_input_pin(const struct sit9=
531x_dpll_pin *pin)=0A=
 	return pin->dir =3D=3D DPLL_PIN_DIRECTION_INPUT;=0A=
 }=0A=
 =0A=
+static bool=0A=
+sit9531x_dpll_is_intsync_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_PIN_ID;=0A=
+}=0A=
+=0A=
+static bool=0A=
+sit9531x_dpll_is_intsync_src_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return !sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID;=0A=
+}=0A=
+=0A=
 static bool=0A=
 sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *pin)=0A=
 {=0A=
@@ -792,8 +806,222 @@ sit9531x_dpll_output_pin_direction_get(const struct d=
pll_pin *pin,=0A=
 				       enum dpll_pin_direction *direction,=0A=
 				       struct netlink_ext_ack *extack);=0A=
 =0A=
+static int=0A=
+sit9531x_dpll_intsync_src_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state *state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+		*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_intsync_src_state_on_dpll_set - drive INTSYNC from a PLL=
=0A=
+ *=0A=
+ *   CONNECTED    -> this PLL drives the INTSYNC net=0A=
+ *   DISCONNECTED -> stop driving INTSYNC if this PLL drives it=0A=
+ *=0A=
+ * SELECTABLE is rejected: driving the net is an explicit output routing,=
=0A=
+ * not an automatic-selection candidate, matching the regular output pin.=
=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_src_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc =3D 0, detect_rc =3D 0;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+			break;=0A=
+		if (sitdev->intsync_src >=3D 0) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "INTSYNC is already sourced by another PLL");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		/*=0A=
+		 * A PLL that already lists INTSYNC among its references must=0A=
+		 * not also drive it: the destination side refuses the mirror=0A=
+		 * of this, and without the check here the net could be routed=0A=
+		 * back into the PLL feeding it.=0A=
+		 */=0A=
+		if (sit9531x_input_prio_present(sitdev, sitdpll->id,=0A=
+						sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID))) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "PLL selects INTSYNC as a reference; it cannot drive it");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_intsync_enable(sitdev, sitdpll->id);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		if (sitdev->intsync_src !=3D sitdpll->id)=0A=
+			break;=0A=
+		rc =3D sit9531x_intsync_disable(sitdev, sitdpll->id);=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Re-scan hardware after source state transitions so cache follows=0A=
+	 * partially failed enable/disable paths as closely as possible.=0A=
+	 */=0A=
+	if (state =3D=3D DPLL_PIN_STATE_CONNECTED ||=0A=
+	    state =3D=3D DPLL_PIN_STATE_DISCONNECTED)=0A=
+		detect_rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	/*=0A=
+	 * The refresh only re-reads what the device now shows.  Failing=0A=
+	 * the request because that read hit a bus error would tell=0A=
+	 * userspace the enable did not happen when it did.=0A=
+	 */=0A=
+	if (detect_rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "INTSYNC source cache not refreshed: %d\n",=0A=
+			 detect_rc);=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc && rc !=3D -EBUSY && rc !=3D -EINVAL && rc !=3D -EOPNOTSUPP)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC source state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_intsync_src_pin_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_intsync_src_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_intsync_src_state_on_dpll_set,=0A=
+};=0A=
+=0A=
 /* ---- INTSYNC destination (input) pin ---- */=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_intsync_dst_state_on_dpll_get - INTSYNC reference state=
=0A=
+ *=0A=
+ * Selection role, so the contract above decides this exactly as it does=
=0A=
+ * for a physical input: the priority table is the eligibility record, and=
=0A=
+ * whether a source PLL happens to be driving the net right now is no more=
=0A=
+ * a state than a momentary LOS is on an external reference.  The one=0A=
+ * addition is that the PLL driving INTSYNC is never its own destination.=
=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state *state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	else=0A=
+		sit9531x_dpll_selection_state_get(sitdev, sitdpll,=0A=
+						  SIT9531X_INTSYNC_PIN_ID,=0A=
+						  state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_intsync_dst_state_on_dpll_set - lock a PLL to INTSYNC=0A=
+ *=0A=
+ * Selection role, so this accepts and refuses what a physical input does,=
=0A=
+ * CONNECTED included: the device pins no reference on request whichever=
=0A=
+ * source is asked for.  INTSYNC is an internal net with no physical=0A=
+ * receiver, so only the per-PLL priority table is touched; the source pin=
=0A=
+ * controls generation.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Device selects its reference by priority; use selectable");=0A=
+		rc =3D -EOPNOTSUPP;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_SELECTABLE:=0A=
+		if (sitdev->intsync_src =3D=3D sitdpll->id) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "PLL cannot lock to the INTSYNC it drives");=0A=
+			rc =3D -EINVAL;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc =3D=3D -EBUSY)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Only source left in the priority table; it cannot be emptied");=
=0A=
+	else if (rc && rc !=3D -EINVAL && rc !=3D -EOPNOTSUPP)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC input state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Do not add .frequency_get / the generic input state getter here: the=0A=
+ * destination pin id is SIT9531X_INTSYNC_PIN_ID, one past the end of the=
=0A=
+ * ref[] array (INTSYNC is an internal net with no ref[] entry).  The ops=
=0A=
+ * below only ever key on chan[] and the priority table, never ref[id].=0A=
+ */=0A=
+static const struct dpll_pin_ops sit9531x_dpll_intsync_dst_pin_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_intsync_dst_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_intsync_dst_state_on_dpll_set,=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+};=0A=
+=0A=
 /*=0A=
  * XO (crystal oscillator) pin ops=0A=
  *=0A=
@@ -1187,8 +1415,13 @@ static const struct dpll_pin_ops sit9531x_dpll_outpu=
t_pin_ops =3D {=0A=
 const struct dpll_pin_ops *=0A=
 sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)=0A=
 {=0A=
-	if (!sit9531x_dpll_is_input_pin(pin))=0A=
+	if (!sit9531x_dpll_is_input_pin(pin)) {=0A=
+		if (sit9531x_dpll_is_intsync_src_pin(pin))=0A=
+			return &sit9531x_dpll_intsync_src_pin_ops;=0A=
 		return &sit9531x_dpll_output_pin_ops;=0A=
+	}=0A=
+	if (sit9531x_dpll_is_intsync_pin(pin))=0A=
+		return &sit9531x_dpll_intsync_dst_pin_ops;=0A=
 	if (sit9531x_dpll_is_xo_pin(pin))=0A=
 		return &sit9531x_dpll_xo_pin_ops;=0A=
 	return &sit9531x_dpll_input_pin_ops;=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 78e8a47e96ab..3e902a169937 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -334,6 +334,9 @@=0A=
 #define SIT9531X_PLL_REG_ZDB1		0x1E=0A=
 #define SIT9531X_PLL_ZDB_EN_BIT		BIT(4)  /* zero-delay buffer enabled */=
=0A=
 =0A=
+/* PLL EXT page INTSYNC configuration registers */=0A=
+#define SIT9531X_PLL_EXT_PAGE(_idx)		(SIT9531X_PAGE_PLLA_EXT + (_idx))=0A=
+=0A=
 /* PLL STATUS register bits */=0A=
 #define SIT9531X_PLL_STATUS_LOCK		BIT(0)=0A=
 #define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
