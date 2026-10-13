Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91F5650FA;
	Tue, 13 Oct 2026 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931306; cv=fail; b=Tq2NiKvDpWQdYlN6Kv2vBhjh3GLA8caaZn3DbdWA7Al+b85EGjePPDtnmBCwNIZ1YEEFU6Hd9idfzGSflCPWa+zzlM5L9wzOKfVpKyGdbOMT0LtetnBvv97zsaA4cXZN+4XoBtqhu35ogerDNPWgysrYkOA2UB1Mo1hECoxrnyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931306; c=relaxed/simple;
	bh=pOh1VsOTCLekw+lE2McN5vPCWms1JoDonZjLaTJwRQA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UiFVZnmSD7DNBBK4njfXSvISvmmYbW6+t4zxjIXygxHN3FLiTT6ow9BVlxbxNY1JNRI/IdjULVVis+iKKeJ8v2QM6O3kTG2o6I2n03+EJkLtObkXId/xm4S59I5JX+NW3j59wuBz9T3vwzwd/T6TuVhU+vPybF+SSL4OCmSXJdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=LjGaZiwB; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=T8Pm6+e1; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="LjGaZiwB";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="T8Pm6+e1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=oloPcwhh08Y1Woe27gV4jX9stU9X+9wi9TLfyZB13lE=;
 b=LjGaZiwBNTn6ExHjVkiwCbkOrrarV7KPGUifIHZTCcWHmYKJMFJCJsTJWM7A+NZXLAboLj0zrQ63IgHzYEq4TkzCFC9PEt3cfFfpXo/i/9G+DCRLUK3HVPpVuVgZyJdrJeTsGIjB7MfO1ty4wCcGw9Qmn8U7IzvnV8TlASKQwsSN7yFHgKTvB2sqKQ1m12BCb6tQIbriUBbToDyKiCG3s93VmNKzS8oE4X7R6IrSsYCggXCCj6p/obqxrqk8n5amxqfQaAMVR7xWYRtS9cWoW1TsyZEcTSKEKPrcPfdoF2tkz6iiWlM5iRIADQqvY6WowUKVGKUpqklbsK8I/aCtGg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020115.outbound.protection.outlook.com [52.101.61.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3EB78C00087;
	Tue, 13 Oct 2026 22:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLPCWoNXyptzlth56A0gHASGP3HqwONgDtrts8uTvFgESIXi9Q9AXxD3C5OsDlvMgK7BmQWHd3IVdtEp4U1DNRRBLTZiukfKr/uHRZV1VEq8u0uEdmkr7aMhFcYyfw6tOtT1taL92TM4mMN4T+PN9LwkJ7BS8VdgTOJRTOuTTUCt8+Jsso5xW5Jo5+pDRkFYyUQ+8nd4REejp/MPot+uBpqpr8WGrIUAuuH6JTuxXEcQ+qnJ3gMDklxKU7xgW362t19Lb+eWlyx7DZdevvEOQDFGQXXDNLrm6KizsANbnRvwtqZhsT4fcN4gcMC34zurQXiEzj1CH4sI5CEy0l95uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oloPcwhh08Y1Woe27gV4jX9stU9X+9wi9TLfyZB13lE=;
 b=V2By4RON9qGWa2Iiv/06QnbBAXjvgGaguTKYU8j/gpbwS8BRxuk5rwlR1ng/yK9VfRLeMVSga/3o4BNwwOJUYvSqZEepAfNLavwAhnR+oh4btSrNaeiebk6qCr6KxiA6uGVaSkYIP89P4nDxotVNRk1C7SUUJUdpFjFMCLgkjHJR38SORvaiPpAefbOEQ5pBokXMJ1AjB8dfdMIHp87te8EhCSKTKGSxjk4FhobQFcLpJyDTAOmj6mZDd6GgTOdH0nOnx6Clrk8v3O3RqSbBZ+4GgKcCNDj4B1rzPyJuR9F4h9tfzsR35lTBstDgKevbt0bmcGjsoH8kKKojnlYGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oloPcwhh08Y1Woe27gV4jX9stU9X+9wi9TLfyZB13lE=;
 b=T8Pm6+e1VybHUm7Jf2NN3lT/aJ/1N75dRsMcZG0fNrTA5nGuiEyyVnsRs3Bb6SCvnenwXX9u9VyCaoxapdQMKWZ5BSufbBLZRkaypMhC7zLNxk9sFXxlBKrQtvIOF5aTkAeD0zlmqB7QfrJwCeZiYX/pMSUdl9WK7F59xKGymU7JBd5bu2qlvl4NPLW977Y5LGi1ByanM2g1fRUWTT+EBPfo1dQgq9ZnVt4xt3NY5AWEaY5WVm4kaKwnvDETKtidU1s8ifqZovvLvtwbcxLb8Ml/uKztIHmbn0dOhpmatftCgPjbSvASwsWsW7Oaqayp0zRJqLA1NVjaXdOLjUD27w==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by IA0PR20MB6676.namprd20.prod.outlook.com
 (2603:10b6:208:480::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:41:36 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:41:36 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v13 07/12] dpll: sit9531x: add support to get and set
 priority on input pins
Thread-Topic: [PATCH net-next v13 07/12] dpll: sit9531x: add support to get
 and set priority on input pins
Thread-Index: AQHdW2QAQrcfgfafck6eJkLXnGlpXg==
Date: Tue, 13 Oct 2026 22:41:36 +0000
Message-ID: <20261013224131.27149-8-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
In-Reply-To: <20261013224131.27149-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|IA0PR20MB6676:EE_
x-ms-office365-filtering-correlation-id: 77bfa2e3-09d6-4342-99cd-08df297b2372
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|5023799004|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 J4s1S00NruLYDxiO5muz/ANa8rRJVQM4REmgSBUWbJ+87wuGVVDllQYPYIeYRzVhNVg00fFN+Z/Ywu+P/t4/XiK4pjg1l7+H0hkErQ7Sg5lAL5INz+y6wXSkxjAJ+aF1fZqfLIp3sI6zoYEuvxKGx0T3nTC3gLYff2l55bYwgb86Sjc9qtmihlCPVRzPbyRt08sKPMNgnqHQVw1gnjjGWXjJK1/Nuyj8nGMDeI6PlGt7JycI2LGCI+QcRcGnBUdaD4Y9h/FaiIVKbZ+f7xWuPXsg6lBnz6fev9uSvmQVWwQruUhxvXt316GP0/SlyAGkd7dxa+a+KXxGsF7J/3AcQeDP8CmKPD7TIGp7LFNCz8469b/6OY4djjHEEO8MVOWvxqWxqzYyVGoAdPYZA2j5RGB881NmQ0Tjs0147/LmtMnWii/ViZRTdMwQmDTK91W8/5SQ1KE1Jf/o1slYiZDNDSE2qj9FoWQIxHyZOp8i7s4Gitgr0FiNtANlteRQVRNWGLB/iIYf9meZivui54QmzjpWG/uIE+QGC0i7ps/9nrzAPwnMnIR2pXn6DhcXZ/zueMHke9EXt1F8MGhQVHD5V7DT8qEzbRMAHlvS73PWlpWQBwJqAlftIajALKjW6HP1gWrTANcab6fY8/zLBDCGi8pDlHWFDh7x9YUGDXCQwOOs2ybg+vcpz4FM71Sg1e6mRpdSTqzfDLyBrhBazUeOCWFYMEteKP3M14ApejFkYW4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5DVSTwLJWlAu3gbPqhN3j+gqn17J6ZmzQbplO9t/Ui6KLUPxGqpA44qPbP?=
 =?iso-8859-1?Q?HBJj51pjNPiANchUJWy09TsYo8fFYbI2ysbW2WDC8pIziqIxvUqx2nGLdo?=
 =?iso-8859-1?Q?Pp3a+1QPhNBUmkO1ObCL/rH72m79MRlZ63IUBKEX5Fusfeu01ByU29XhEF?=
 =?iso-8859-1?Q?JS0c2SC99ptcki/bYYkn4rDKvtypzpbFYlt78qO/FsdT3GGDophGf9lgyP?=
 =?iso-8859-1?Q?O4BaF25IKF9JXnBbFnEql+osX4Ixs7TXRyhRbzLTXyJnv0T7Fv2dMs0Yvp?=
 =?iso-8859-1?Q?hXby6O4iPrkaAhS09PWhYhXZ1Kg6gmsXqiO0ev8W30RPhmUFXGwaRkr6BB?=
 =?iso-8859-1?Q?oltFmTTLmceT3pHCvG4fufaii7dbjtzaxZCbgGd6puCh92spxtFBnLo1z4?=
 =?iso-8859-1?Q?8eMbr10RErIGR9hOxNc5lsh1OwfHcnnzb2toF9fwUbyuHBdwwS4KM2aYg4?=
 =?iso-8859-1?Q?LhHvzcrDLBLzoh0ARbwojCebxqHAoJcnc8FLNngtxAF2IVNZIW5PZXW/ZO?=
 =?iso-8859-1?Q?dVCmOlKUbK+FKZHn7mziw/0TW8FOEsDxcue7NITraZsSPcB5MyV/CUOS2f?=
 =?iso-8859-1?Q?UgPYtQY/cBEV4cBq53ce49qb+PlFtzT98wjPWvPAAPpvWKSEjLyt0v6uK/?=
 =?iso-8859-1?Q?lPwbMGZUG0n2ZMvE9Yr66euV82bwBxFYcllhRizK8BDUhQRxsZIBWy//FP?=
 =?iso-8859-1?Q?oxJ+CMFgar/URX6JCPe2X8hATlWGSpQtmReYmWs1WB1N/Dwh9Gq0a9V5F1?=
 =?iso-8859-1?Q?Gp6NyxQLgcC4GeQX7TIx+lKfZUcQ0pa0h6cUEBLetrelml/f9Aw2rH2WjJ?=
 =?iso-8859-1?Q?7GJpP5yOVf9t3M0OxBX6eJmgtAEKalWDqEkr826C1p1QMWKbr9jaQNnPDU?=
 =?iso-8859-1?Q?yfxUMZr2GQP324wfriep+SNqTagwCXCppqcd3D9+xZs9z03etDJhWhyx5P?=
 =?iso-8859-1?Q?GXPYSxw80PGhnCs4P7pNig75QR7zldB43u25IXUE7AK9HrzCGnNC97e3T9?=
 =?iso-8859-1?Q?lX93MTiIHTy9bR7HOi0dS83Qxv6sFPk4tecFav7lgvpNyQpN3nr9KI0JHg?=
 =?iso-8859-1?Q?9H/VfW6ONvKZrDTyb4J1/WseT1IOBSXcKIGLYVRxcZ0EvoOFDF3rUqK1Hn?=
 =?iso-8859-1?Q?I32dhtS1fxBojrG+J2yDf1298qbejIbrY/U4lBg9iPzjG3YUvCl0q7ZxM8?=
 =?iso-8859-1?Q?moGfrSo6IBxXjPeCpXaj9culaPkZJSCWxf4j//rJIz6PnlcmpiQbeg/ta9?=
 =?iso-8859-1?Q?qJc+L61K2+8LI/kZDeZ5n9niOwbykniAHZo1N8+pj5PfMU6T1EcZ9jEBw8?=
 =?iso-8859-1?Q?ZLzduN/ZzTxivl1QZljchIUhpmaTtW4dEOAJLBhIIt7DsJaqyXf7fdGYpR?=
 =?iso-8859-1?Q?D9g4N4zv03fXzNXSHrwD9lKpyIuzg9uCxfGgBcidjg4ne3LzeXGWf8o9Ck?=
 =?iso-8859-1?Q?67irUty9nDDlE5sf0ZqjcExT8d6wPewgAO2TaUvNFmfMcjf21YRk8TJD6D?=
 =?iso-8859-1?Q?TuRKZAwDBDVNR6Vyr0l+jOb53M1ZWrgRSTLi4ZZ3YaoWultSW/Cu15WYXM?=
 =?iso-8859-1?Q?xroLvNQyYcDNqn1+iOjvlpg8wkneX43MS14Ay5uwt9mmh1BjKbpzYZP4Vg?=
 =?iso-8859-1?Q?A/cjg1bZsfRON/GkxZVmq7wp930spGU3unNad3yq0PH3PJ6boVI0F7vcpZ?=
 =?iso-8859-1?Q?O/c6rfGzON5xpSrctrZ9XYk0+D3tQ3QuznRxulAAgZ6UxIQV/a4mzwZR0z?=
 =?iso-8859-1?Q?AN5cRXtNp5/BMFh2UYsZDTfk4lnjD4R2Jhu94wsM5UX8Em?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eGNOhflNyFuqj3Q0fonKhtZqbjqpVPmJyKytX3Yrz81YzNPgaYcyxVvLu0TZGx6uS/uZTn9sDyw6osN9ex3LIiywZ7H6G55jVFvtl9muhb76Xafbl+c27qZe5jOQcV6DPiLjho1U3rHoHP90sKzuZm1MaMskCY+UEOCOpNUly5OOY6t3t1gJutCi10WtfEYIs3ATjnDNOiWr8SEjzpwxHFFZQKJFQ847vTNh+qjRETtVlNUi8lmkgvqnTWaf+pN7d9afORsNI+sY4WML9QAbrxm54fADdQbtxu1fprqVsd5XNCFQlQAfXwCdEqYHr5zz67lRnYVDXES/YYlvMJ6XTQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bfa2e3-09d6-4342-99cd-08df297b2372
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:41:36.1806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Amv7iIG6pBip/VbD/pmceMRwb2LszHJrJ8Dbnr9cqEsZ9rDn0Ixaj/VBzBKNV1yq/jyxubW8DhAl28tcBiv7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6676
X-MDID: 1791931298-L2sVLzczqxPM
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931298;L2sVLzczqxPM;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
When the device has to choose a reference, it takes the first slot of=0A=
its priority table that has signal.  The driver keeps a=0A=
priority per input and PLL and builds the table from it (previous=0A=
patch), so getting a priority reads that value without touching a=0A=
register, and setting one records it and, for an input the PLL lists,=0A=
rewrites the table in the new order.  When the new order puts a=0A=
different input with signal first, the PLL moves to it; a change further=0A=
down the table leaves the PLL where it is.=0A=
=0A=
Priority and state are separate attributes, and neither moves the other.=0A=
A priority can be set on a disconnected input and takes effect when it is=
=0A=
connected; disconnecting an input and connecting it again brings back the=
=0A=
priority it had.  Setting one input's priority leaves every other input's=
=0A=
as it was, so the named pin is the only one whose priority changes and=0A=
the core's own notification covers that; when the new order moves the=0A=
active selection, the siblings' operational state follows on the next=0A=
poll.  A priority the table write refused is not kept: the configured=0A=
value goes back to what it was, so nothing reports a priority the=0A=
device never took.  The range is 0 to 255 against a table of eleven slots:=
=0A=
inputs of equal priority keep the order the table already has them in,=0A=
so distinct values are what fix an order.  An input the PLL has never=0A=
listed reports the lowest slot, the priority it would be connected at.=0A=
=0A=
A table rewritten behind the driver -- a profile reload, a direct I2C=0A=
tool -- is taken as the new configuration and the priorities are=0A=
re-seeded from it, so the poll now watches priority and operational state=
=0A=
as well as state, and notifies a pin when any of them moves.  The=0A=
notifications go out after the walk over the pins, outside multiop_lock,=0A=
since the helper takes locks the callbacks run under.=0A=
=0A=
A pin's baseline for that watch -- state, operational state and priority=0A=
-- is taken when the pin is registered, under the device lock, rather=0A=
than by the first tick, so a change between the probe-time fetch and=0A=
that tick is reported instead of absorbed into the baseline.  The device=0A=
lock status is seeded the same way, so the first tick announces only=0A=
what moved since registration.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Reviewed-by: Ivan Vecera <ivecera@redhat.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c |  43 +++++++-=0A=
 drivers/dpll/sit9531x/core.h |   2 +=0A=
 drivers/dpll/sit9531x/dpll.c | 202 ++++++++++++++++++++++++++++++-----=0A=
 drivers/dpll/sit9531x/dpll.h |   4 +-=0A=
 drivers/dpll/sit9531x/prop.c |   4 +-=0A=
 5 files changed, 227 insertions(+), 28 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 1aad598930d7..f3dbe949f219 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -671,6 +671,44 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *=
sitdev, u8 pll_idx,=0A=
 	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_prio_get - read an input's priority for a PLL=0A=
+ * @input_idx:	input source in hardware encoding (see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	output priority (lower is preferred)=0A=
+ *=0A=
+ * Reports the priority configured for the source on this PLL, which is=0A=
+ * kept whether or not the source is currently in the table: state and=0A=
+ * priority are separate attributes, so disconnecting an input and=0A=
+ * connecting it again must not change the priority it reports.  The=0A=
+ * value is seeded from the hardware table, and re-seeded whenever the=0A=
+ * read-back shows the table was rewritten by something other than this=0A=
+ * driver.  A source that was never listed reports the lowest slot.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	if (chan->cfg_known & BIT(input_idx))=0A=
+		*prio =3D chan->cfg_prio[input_idx];=0A=
+	else=0A=
+		*prio =3D SIT9531X_PRIO_MAX_SLOTS - 1;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Take the configured priorities from a table the hardware holds: each=0A=
  * listed source gets the first slot it occupies.  A source the table does=
=0A=
@@ -2588,9 +2626,12 @@ static int sit9531x_dpll_pins_register(struct sit953=
1x_dpll *sitdpll)=0A=
 		/*=0A=
 		 * Pins registered before this one are already reachable from=0A=
 		 * netlink, and the walks over this list run under=0A=
-		 * multiop_lock, so the insertion does too.=0A=
+		 * multiop_lock, so the insertion does too.  The baseline the=0A=
+		 * poll compares the pin against is taken under the same=0A=
+		 * lock, from the cache the create notification just reported.=0A=
 		 */=0A=
 		mutex_lock(&sitdpll->dev->multiop_lock);=0A=
+		sit9531x_dpll_pin_baseline(pin);=0A=
 		list_add(&pin->list, &sitdpll->pins);=0A=
 		mutex_unlock(&sitdpll->dev->multiop_lock);=0A=
 	}=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 07a0ae47c056..0b7418922cc9 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -248,6 +248,8 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *s=
itdev,=0A=
 				 u8 pll_idx, u8 input_idx);=0A=
 int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			    u8 input_idx, u8 prio);=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio);=0A=
 int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			       u8 input_idx);=0A=
 int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 4c7cae4ce93e..0400444d91a5 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -34,6 +34,21 @@ sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *=
pin)=0A=
 	       pin->id =3D=3D SIT9531X_MAX_INPUTS;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The pins the poll watches: the selection-role pins -- regular reference=
s=0A=
+ * and the INTSYNC destination -- whose state, operational state and=0A=
+ * priority can move without a request: the device selects on its own, the=
=0A=
+ * monitors follow the signal, and a table rewritten behind the driver=0A=
+ * re-seeds the priorities.  Outputs (incl. the INTSYNC source) change onl=
y=0A=
+ * through their own set callback and the XO is permanently connected.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dpll_is_selection_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       !sit9531x_dpll_is_xo_pin(pin);=0A=
+}=0A=
+=0A=
 /*=0A=
  * Status of a PLL whose outer loop is frozen in holdover.=0A=
  *=0A=
@@ -548,11 +563,93 @@ sit9531x_dpll_input_pin_state_on_dpll_set(const struc=
t dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_get - read input pin priority=0A=
+ *=0A=
+ * Reports the priority sit9531x_input_prio_get() keeps for the source on=
=0A=
+ * this PLL, connected or not; no register is read.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_get(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll,=0A=
+				 void *dpll_priv, u32 *prio,=0A=
+				 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 slot;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id), &slot);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * dpin->prio is not touched here: it is the poll's baseline for=0A=
+	 * spotting a change to notify, and a get refreshing it would hide=0A=
+	 * the change from the poll.=0A=
+	 */=0A=
+	*prio =3D slot;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_set - set input pin priority=0A=
+ *=0A=
+ * Records the priority and, for a pin in this PLL's table, rewrites the=
=0A=
+ * Page 1 table in priority order (sit9531x_input_prio_set()).  The other=
=0A=
+ * pins keep their priorities, so only the named pin changes and the core=
=0A=
+ * notifies it.  A pin that is not in the table keeps the priority for whe=
n=0A=
+ * it is connected.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll,=0A=
+				 void *dpll_priv, u32 prio,=0A=
+				 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	if (dpin->dir !=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority applies only to input pins");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (prio > U8_MAX) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority out of range (0-255)");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_set(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id),=0A=
+				     (u8)prio);=0A=
+	if (!rc)=0A=
+		dpin->prio =3D prio;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input priority");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -636,6 +733,55 @@ sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_p=
in *pin)=0A=
 	return &sit9531x_dpll_input_pin_ops;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The state, operational state and priority of a selection-role pin as=0A=
+ * the cache has them now: the baseline at registration, and what the poll=
=0A=
+ * compares it against on every tick.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_dpll_pin_snapshot(struct sit9531x_dpll *sitdpll,=0A=
+				       const struct sit9531x_dpll_pin *pin,=0A=
+				       enum dpll_pin_state *state,=0A=
+				       enum dpll_pin_operstate *operstate,=0A=
+				       u8 *prio)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 id =3D pin->id;=0A=
+=0A=
+	if (id =3D=3D SIT9531X_INTSYNC_PIN_ID && sitdev->intsync_src =3D=3D sitdp=
ll->id)=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	else=0A=
+		sit9531x_dpll_selection_state_get(sitdev, sitdpll, id, state);=0A=
+	sit9531x_dpll_selection_operstate_get(sitdev, sitdpll, id, operstate);=0A=
+	if (sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+				    sit9531x_input_hw_src(id), prio))=0A=
+		*prio =3D pin->prio;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_pin_baseline - seed what the poll compares a pin against=
=0A=
+ *=0A=
+ * Called right after the pin is registered, under multiop_lock, so the=0A=
+ * poll's first comparison is against what the create notification=0A=
+ * carried.  A baseline taken on the first tick instead would absorb=0A=
+ * whatever moved between registration and that tick -- a lane losing its=
=0A=
+ * signal, a table rewritten and re-seeded -- and leave userspace with the=
=0A=
+ * snapshot from registration until the next change.=0A=
+ */=0A=
+void sit9531x_dpll_pin_baseline(struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D pin->dpll;=0A=
+=0A=
+	lockdep_assert_held(&sitdpll->dev->multiop_lock);=0A=
+=0A=
+	if (!sit9531x_dpll_is_selection_pin(pin))=0A=
+		return;=0A=
+=0A=
+	sit9531x_dpll_pin_snapshot(sitdpll, pin, &pin->pin_state,=0A=
+				   &pin->operstate, &pin->prio);=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dpll_changes_check - check for state changes and notify=0A=
  *=0A=
@@ -671,39 +817,45 @@ void sit9531x_dpll_changes_check(struct sit9531x_dpll=
 *sitdpll)=0A=
 		dpll_device_change_ntf(sitdpll->dpll_dev);=0A=
 	}=0A=
 =0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
 	list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
-		const struct dpll_pin_ops *ops;=0A=
+		enum dpll_pin_operstate operstate;=0A=
 		enum dpll_pin_state state;=0A=
 		bool changed;=0A=
+		u8 prio;=0A=
 =0A=
-		/*=0A=
-		 * Poll input pins whose state can change autonomously: regular=0A=
-		 * references and the INTSYNC destination pin.  Outputs (incl.=0A=
-		 * the INTSYNC source) change only through their own set=0A=
-		 * callback and the XO is permanently connected, so skip those.=0A=
-		 * Each pin's state_on_dpll_get resolves to the right getter.=0A=
-		 */=0A=
-		if (!sit9531x_dpll_is_input_pin(pin) ||=0A=
-		    sit9531x_dpll_is_xo_pin(pin))=0A=
+		if (!sit9531x_dpll_is_selection_pin(pin))=0A=
 			continue;=0A=
 =0A=
-		ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
-		rc =3D ops->state_on_dpll_get(pin->dpll_pin, pin,=0A=
-					    sitdpll->dpll_dev, sitdpll,=0A=
-					    &state, NULL);=0A=
-		if (rc)=0A=
-			continue;=0A=
+		sit9531x_dpll_pin_snapshot(sitdpll, pin, &state, &operstate,=0A=
+					   &prio);=0A=
+=0A=
+		changed =3D state !=3D pin->pin_state ||=0A=
+			  operstate !=3D pin->operstate || prio !=3D pin->prio;=0A=
+		if (changed)=0A=
+			dev_dbg(sitdev->dev,=0A=
+				"%s: state %u->%u operstate %u->%u prio %u->%u\n",=0A=
+				pin->label, pin->pin_state, state,=0A=
+				pin->operstate, operstate, pin->prio, prio);=0A=
+=0A=
+		pin->pin_state =3D state;=0A=
+		pin->operstate =3D operstate;=0A=
+		pin->prio =3D prio;=0A=
 =0A=
 		/*=0A=
-		 * The first pass only takes the baseline: the pin was=0A=
-		 * registered with this state, so nothing has changed yet.=0A=
+		 * The notification helper takes DPLL-subsystem locks that the=0A=
+		 * callbacks run under, so it cannot be called with=0A=
+		 * multiop_lock held; mark the pin and send after the walk.=0A=
 		 */=0A=
-		changed =3D pin->seen && state !=3D pin->pin_state;=0A=
-		pin->pin_state =3D state;=0A=
-		pin->seen =3D true;=0A=
-		if (changed) {=0A=
-			dev_dbg(sitdev->dev, "%s state changed\n", pin->label);=0A=
-			dpll_pin_change_ntf(pin->dpll_pin);=0A=
-		}=0A=
+		if (changed)=0A=
+			pin->ntf_pending =3D true;=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
+		if (!pin->ntf_pending)=0A=
+			continue;=0A=
+		pin->ntf_pending =3D false;=0A=
+		dpll_pin_change_ntf(pin->dpll_pin);=0A=
 	}=0A=
 }=0A=
diff --git a/drivers/dpll/sit9531x/dpll.h b/drivers/dpll/sit9531x/dpll.h=0A=
index 9eb26505f94e..c2706ced92cd 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.h=0A=
+++ b/drivers/dpll/sit9531x/dpll.h=0A=
@@ -31,7 +31,8 @@ struct sit9531x_dpll_pin {=0A=
 	u8				id;		/* hardware index */=0A=
 	u8				prio;=0A=
 	enum dpll_pin_state		pin_state;=0A=
-	bool				seen;	/* baseline taken by the poll */=0A=
+	enum dpll_pin_operstate		operstate;=0A=
+	bool				ntf_pending;=0A=
 };=0A=
 =0A=
 /* Per-PLL DPLL device state. */=0A=
@@ -63,6 +64,7 @@ void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdp=
ll);=0A=
 =0A=
 /* ---- Periodic change detection ---- */=0A=
 void sit9531x_dpll_lock_status_baseline(struct sit9531x_dpll *sitdpll);=0A=
+void sit9531x_dpll_pin_baseline(struct sit9531x_dpll_pin *pin);=0A=
 void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll);=0A=
 =0A=
 #endif /* _SIT9531X_DPLL_H */=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index 3635ea497e41..934db566c002 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -187,10 +187,11 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=
=0A=
 	    index =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
 		/*=0A=
 		 * INTSYNC destination pin: a PLL locks to the INTSYNC net as a=0A=
-		 * reference, so it can be connected.=0A=
+		 * reference, so it can be connected and re-prioritised.=0A=
 		 */=0A=
 		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
 		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D 0;=0A=
 	} else if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
@@ -214,6 +215,7 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
 		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
 		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D sitdev->ref[index].freq;=0A=
 	} else {=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
