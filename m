Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8381C3126DF;
	Fri, 16 Oct 2026 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112149; cv=fail; b=rRax9T85nOKjP9rXfROwkYFN2ip9dbbt1ihgp023NpkipYDfhXmDx38fPqF7sFAiB6sE6CpZJw+d1Te0NJLysLLJgT1QodUWDsJr14qlaHtum8y+o4lA97AIcSyf/hKANsAuiLQTW78lJ2E8sGVQ3OUznjWfuPJNG8yXApKggwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112149; c=relaxed/simple;
	bh=Pm4hA9NSiijBerQ0M02aI9EjmEgQ5xPJNmvYdHHwDwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gwqeZwVIDh0+5II1Y0R8IWP+N1bgAgP78kN8u+BxGNSHSVAjlU2K26B9aYqEdcXRa87hn09ONVjMCzC+zi3yspy2NDzi3nzODT3GinuMK5ZwSqX3AIdS4pgOCL4ZLuxQirUg3r8UiyqgUjHOgmFj25d3muRmkXOusROT1MHwmI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=m9ZAGV/h; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=SlDdVel7; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="m9ZAGV/h";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="SlDdVel7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=Pm4hA9NSiijBerQ0M02aI9EjmEgQ5xPJNmvYdHHwDwk=;
 b=m9ZAGV/hd6MVCQN02idz+9l3Zqg4ir5o/C0iVX2A6I2bDLXiWMovTfA4MWkhTRa/fnvgu/2MtwfEAYO3Tg0HCj2C8z4A9q39GC585Rubp/PYu9RiYMx6G9r7aBnAgqozYUbPLmj60HMLAHU3OUKK1r9U+IpaeFKVCrTUVDGlow2eBSOq6cjHq3yNR8Bp+cFf8vzOFUIiND5u17PvP7JUKdE6nE+xy+Ig7By0V2F6EOn1ad/MiMJO30/d06nyJqFBsaGIW3ifx5wdnF1p9Lw2N20mh94pJvxReiEyf8sAlddX7ZGdOj0oKZhrYO8+sSe7jFVq3QKbifRAkECK1Xm/bg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020104.outbound.protection.outlook.com [40.93.198.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B1373C006B;
	Fri, 16 Oct 2026 00:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3tgIykYLSUraj8dscY85a1pB2kNNMYKMs3j61qOc546HW/JT3d+jfyoS2gbF0Wc3z6dMybTR6brTrwyscnl81PWxvlBJulQpVwxwpKzy1rU+G1DTNiap5bbBH/nhDQDONTmGuVLw55BPL49w6p181Ndbq7g5G4u60ijhDl2GkEkgqm2UJ1rJgv0t2Mzs5WPO9wONQcOmySk89v2fnk1t+OEqPy2kf6yykNCcHD481kN7bxO/zyyKKJ+JxtgAmPuRiagLvtodz2ssAjvhVaCO+trgV/9QOUh2RbDLgEld1lOsf1MBtEgxVsm1I2mdJZFFXQ8FBCEBu58IKhAbHRdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pm4hA9NSiijBerQ0M02aI9EjmEgQ5xPJNmvYdHHwDwk=;
 b=qFQSItJhnF9oKWDZWNzmSqEgf6Ne6JwPDCRPJyHFptGQlto9uW/SRadtxOL89tHuXBPo/tYmZuHPdq1+E8yYZjswQj2nBdVJKl8XKAhPky0x/d3JN5XvosyCHsMYZz8z0hrXARMD1suR5d7+Z/pOKF6Q7mZ/Rx4KhcGlnuCGngTv5RhXGf2yuzSIQ15A1Knrz+3tRCCmfIMSLa8FN7qVGyT+iJ0HUXuphlI+LLfUubjUFvrePuCAw8tMKRo545k+FXnS0jP9D1DbSEAIS7ESKwca00t/sEOgDQtgCky/AjxxspCDJgJdllqwAAGWVKZN+yxM463FG4fiQ0dz3j3HgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm4hA9NSiijBerQ0M02aI9EjmEgQ5xPJNmvYdHHwDwk=;
 b=SlDdVel72c8QXYn9hZhexldGKCjAARjEed6M3i3FywXJrBcmW4mIPurKMPyrbFuiyilqjvQbX7sFxmH3tWMTpqraOzKrNY3XBxc0/6Ob3C1WNlny+RhBlmegzo4l3dIxu+MyZG6fBKH2r0yxPmKrosRKWDIS/PGZ1/yizdjyc5/YxQkqKB+oV95us17ZA57mO5wdfxJcWTzWej0uEhLQbAUjfnx/plLpu33cs2AuZeXd9xz5gcF6dvH5NJNTHqnAuIcqza0KPeFk+2aUoQoO7Lj3cftA25nMF5qCcznKCULEbAa5Jz5A5oo4vtciKJTx372K1UyGd9vSYH2Je5oBLQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MN0PR20MB4789.namprd20.prod.outlook.com
 (2603:10b6:208:3c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 00:55:45 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 00:55:45 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v13 08/12] dpll: sit9531x: add support to get and
 set frequency on pins
Thread-Topic: [PATCH net-next v13 08/12] dpll: sit9531x: add support to get
 and set frequency on pins
Thread-Index: AQHdW2QBp8UyZE8c/UGXh+YsRn/ZU7b9o5uAgAG3vIA=
Date: Fri, 16 Oct 2026 00:55:44 +0000
Message-ID: <20261016005541.11374-4-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
 <20261013224131.27149-9-arouhi@sitime.com> <sashiko-outbox-171996@kernel.org>
In-Reply-To: <sashiko-outbox-171996@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MN0PR20MB4789:EE_
x-ms-office365-filtering-correlation-id: 927226f5-7da4-4181-abfa-08df2b2035d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|4143699003|18002099003|10067099003|22082099003;
x-microsoft-antispam-message-info:
 c1CyQmuA4wGe0J45fCPRqZiA6xjpdaLzcteeVm6hhkrY0fV2EVwO0HOgwdf7QnvHxPKp03PCVThDWhnS0e3YLWMKP6z6/apa1w3rUVeqaanXzBjKSmXtSXGxSoat7sAGBtTauzAJj454mS7QskWGBIR9704oy0ev+DRtZGcvV/XRWWL/lBcAscFDpsojxRpCn5UQrM/ubePOREObPb5UVdtauCVq/3o4s9fRIFfkQKUDcWWm42nP9r7qRp8QD9XHiFk/f25RmctqIsVIgYMDmByoV3HFWZrvJRHu2Mb8+XFcr8EbeVDQh3qNxRvi4tujgwUZHwVCjp/wVYWoTvGem2Cc4vIM0NdSOnz8tD7XJge3kvHW4+Pub2j8WdOjqwbh0mLULVKGrIoH45zv3Ti9YZGhos1q6IV6gyCogD6iBGajO0PElCexAoLNtSjEJN2rN8199w9aWUiV37fCwUZbVdFdY6022U1GVrWy6yNbdz4GCO472V8eOoejh+N2hzm76wlFuTjBsvbDVMuh8n7hRCYWlNouxbr/cvsfWi8qo1I4NGrB892YkEX3Ui/GBsjn4k1YDGCa031nHhs+jYeO5nlDxENfto22exR/y+y4d64t9lEuqONy6dhHhrSaQETneOIimA5n/X8w39TYUvGzn44rq4ax0yPw4+/+EytFNizFTBHQRGNPl+bjvMcvu4zLjCGqFXULXvFjR7Bo1gn4gY2Qje/u9gm2fESrf9LsxRI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(4143699003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjRzZkRSdzZTbHk4bFJ4N0xVbmF5VVV1ZEZBb0IxcGF1czEzV3VIUGVOMUJ2?=
 =?utf-8?B?UE9sK2NJVkF0Q1p0cWlUNWtBVnVUOU50dWpZNDU5TGFqdHpIdGtHMUpGQmZ3?=
 =?utf-8?B?T2MvWlVYT1VMSU43YjJ6bDRzNTY5dEROd1RScE1Bb28xUVQzQjdnaGdHTlQ5?=
 =?utf-8?B?ZkJvVW5TR3YrVUpLUFgvSFpLd2IxZXpSOEZJU2J3MVJnY21VVktraFYwSUg1?=
 =?utf-8?B?ZTgrNG5KU3AvRjZhaWN1ZEJaUHdWWEJVWjUwMkVDNjJjRzFKN3A4dFpLUmxK?=
 =?utf-8?B?NndTN0U1ejRFNlNwdzhzRnJBRHQ5RjBBejlPUng5dkFlMFhvbWJhMndrSVFI?=
 =?utf-8?B?cVJtcXYrQzhGK3dqM3NNdTd2L3M4TExMcEt0QkpHbi83TmFYZEQwSTJQanhD?=
 =?utf-8?B?QjZBSVVrb0thdlEvVm82QUcvQmxaZTRET0ROK3lSbWtMVkhMZGw1YnA2TUVl?=
 =?utf-8?B?NXN4cXdpV2FFZDl1YVBBN0dydGlHdUhhZU5wemgramt4OW82eXhjbFMxK1hn?=
 =?utf-8?B?U25hb05XOU55V3RjQUtiTHdVeng5MVVvUmFCLy9vdS9wRUhkV1FtUjhhcE1L?=
 =?utf-8?B?RGVqU0RVdTBMY05ITXdHdDRpb3JtN0ZoSDk1TzVCbEJJZWhaMWJhSWNWTTY0?=
 =?utf-8?B?WER2SFYvUWNZOFhXWldYTm1NL2VBOVhQQlN3L1FLcG5RbTJmYnpjcUlwUlVq?=
 =?utf-8?B?QmNpTFdrTlQrMzlIQi9obXliaXhxNVFsVGxCZ3EwM2t4SWZQNnV0UGtQSStJ?=
 =?utf-8?B?dCtNUnQ1MjhmY2Y5NTBJMDFaNHFQR0hBME5md1IybDJPdkg4S2t1OGVpaUQw?=
 =?utf-8?B?Q3h2QkxPeUZ0NElZck9lOFFCMTRtNmJCalVmUDRubTlObkJ3WVVFMG1mcG1L?=
 =?utf-8?B?TWRNNUxtM2t1Q2VUQUV6N2NvSThoUlM4UWs5N1llZWZJSER6NHJNZ25GSGlv?=
 =?utf-8?B?N3pkTFZjaWNCSzVEbHFJTTN0S3VJdU8ybmE3QjdnUUlYZ3pxdWx3RXc2dkh5?=
 =?utf-8?B?ZkVXcWFQTnNobDZjZTBzZjhhZVZsWFk1d2FHTnJKY29lMVpwcnFENjNOWWI5?=
 =?utf-8?B?cCtPaUs4aGVQUm4wODZRQXBjd2k5VTBmZ1ZCNGNyM2s1RS9WbjFZM1MyaG9Y?=
 =?utf-8?B?U0dtazBYdTk4R1BrbDNRaWhUbmp0MHJuOFRzRTlPZzZCSW1GZ2FhTWVWdytT?=
 =?utf-8?B?dFpWWjRkVEZhcjV6eUdpZjFEQWJkcUVGcHJYK2dIc1hEN2NpR1dGRmlQNXdL?=
 =?utf-8?B?NTNCMmdheUgvK016cmJXaHh5ZUFFZyt6em44bkJob3hEVHJ0QXhqNFZZR3B2?=
 =?utf-8?B?elB0NzFEMkVCdnU2VjFoOElnRjh5WDcySGpyNm10TXAxYnlmd3phcVlSTGV6?=
 =?utf-8?B?MHBiNFZROEFhZmtYMjA4eXV6dEFuUlN1Y1VyM1Z6UTlXeGNFS1ZvSUEwQnlD?=
 =?utf-8?B?djVUSGhCbFR4T1VDcm1OeHBGMjA2S1VYVW9YV0VHZU05NEpHU1drbklMVnha?=
 =?utf-8?B?OG9aRTF3UHoxd1AxTFE5VmcrTlZsc3ZrNzR5Rm53VmJUWWtVR1lhZmgvdHhn?=
 =?utf-8?B?SVZDVVV4cllTZmZyVUlmSGpsNmZwNVBWVVJlRWdxNU9JYTN0OTZINzJtazV6?=
 =?utf-8?B?UXJ6OEhGRkJiejk5NmZEUzdUQlM1c1BJSytyWE9qN1NnSDBISC9mbm9zVjRo?=
 =?utf-8?B?dXV0QmRxSHZSOXRVcWlkRnFFb085bU5uL1B6YngxRkxsa25BZmY3TmNHWVRt?=
 =?utf-8?B?SGxpeXI4b0dzblE3L3ZqRy9KTU1YaE4raE1VcVNNTWZ0dU12QVdudDBHclJi?=
 =?utf-8?B?WWlYVjc5NTlJUVNCL2NKSGtKempMcmZrek80Q3F5TDdBYTgrNkpBVWFCNmly?=
 =?utf-8?B?ZUFZWml5L2k5SHgxb3lhWDE0SHJSa09rU2xlOEpzSXBsdkhDRTcyUGpCT1E2?=
 =?utf-8?B?TmNQc2FRWENieDlxQWhqSzFKbDE4WXQzRzRWbGZQdkMvSU84R2x2dmZsaTV1?=
 =?utf-8?B?dVRGNitXNVJIcXpONlFrTTNVSGpvamVHZzRQTkdHWFZxdnA2TC90RWtyR3h4?=
 =?utf-8?B?bW1TREdzZm1iTkhVK0Q4U2xGMWNRcXpvMWRmQVdGajJ0U05pLzhkQ280bFBJ?=
 =?utf-8?B?cjJWR21qNnl4djZuYTJhRVk2bUM1VjNxd3RBclVjYW9GNUticnJtUzNPUXI1?=
 =?utf-8?B?UFpHcVU0N1I1ZUlCN2JTV05rcWd0U3RHTllXclMyZ3RqVW1pNVM1c0RPdGlM?=
 =?utf-8?B?UEk0NS83VlZjMmlHZms3OCtQeFhsQUxNaDhUOHZTY0QzNU1QdUZJWStVbzQv?=
 =?utf-8?Q?K+BIP134RPLadjpS+6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	f465LcfCGn+VEgBOFrLd7gYBeHQM9JIKjELOPG2uWZvElCtXkmozgIY2YBCw/yNeIpcs3LcHHlEMH4fFYQHSKNn/L3us9fMiC0mOQz7LrH9BO3abyHN1rJhzxB68TrEUjLTzzTt5X50LK1+VcrO3grHBZU3UQwGDS88HCgnm1llkjyUz45hgaAEul5bsnGI8QgR1wGkcKOPkRoYozhjjmALMr7jnOLfqbbqBI5w/CF7DNhZvpxLrQYYPfiXbGoLs9jDAjdI1i4ZrZ+rQML5EfhvJPda3gYOzlCW49eNNNPQ/zoneUWjmkWrxDBdh4xxfJ5mfNXeFyF7ELdBSvQkMUw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927226f5-7da4-4181-abfa-08df2b2035d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 00:55:44.5215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFVmYulsV6Z4P4OxztnKTnIqsskCqHtPGcORb/1vYc56rdYnfw42kNYAkvpx9Agm6Aa/f4Ov9xREOrbICsiYvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4789
X-MDID: 1792112147-5_L03pBTs6wE
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1792112147;5_L03pBTs6wE;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

T24gV2VkLCAxNCBPY3QgMjAyNiwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToKClJlcGx5
IGlubGluZS4KCj4gW1NldmVyaXR5OiBNZWRpdW1dIFNpbmNlIHRoZSBkZXZpY2UgcmVnaXN0ZXJz
IGFyZSBiaWctZW5kaWFuLCBkb2VzCj4gdGhpcyBsb29wIHJldmVyc2UgdGhlIGJ5dGUgb3JkZXI/
IEJ5IGxvb3BpbmcgaSBmcm9tIDMgZG93biB0byAwIGFuZAo+IHNoaWZ0aW5nIHRoZSByZXN1bHQg
bGVmdCwgdGhlIHZhbHVlIGZyb20gdGhlIGhpZ2hlc3QgYWRkcmVzcyAod2hpY2gKPiBzaG91bGQg
YmUgdGhlIExTQikgaXMgcGxhY2VkIGludG8gdGhlIG1vc3Qgc2lnbmlmaWNhbnQgYnl0ZSBvZgo+
IGZyYWNuX3Jhdywgd2hpY2ggY291bGQgcmVzdWx0IGluIGluY29ycmVjdCBWQ08gZnJlcXVlbmN5
Cj4gY2FsY3VsYXRpb25zLgoKVGhlIGxvb3AgbWF0Y2hlcyB0aGUgcmVnaXN0ZXIgbGF5b3V0LCB3
aGljaCBpcyB0aGUgb3RoZXIgd2F5IGFyb3VuZC4KVGhlIG51bWVyYXRvcidzIGxlYXN0IHNpZ25p
ZmljYW50IGJ5dGUgc2l0cyBhdCB0aGUgbG93ZXN0IG9mIGl0cyBmb3VyCmFkZHJlc3NlcyBhbmQg
aXRzIG1vc3Qgc2lnbmlmaWNhbnQgYnl0ZSBhdCB0aGUgaGlnaGVzdCwgc28gcmVhZGluZyB0aGUK
aGlnaGVzdCBhZGRyZXNzIGZpcnN0IGFuZCBzaGlmdGluZyBsZWZ0IGVhY2ggdGltZSByZWNvbnN0
cnVjdHMgdGhlCnZhbHVlLgoKPiBbU2V2ZXJpdHk6IE1lZGl1bV0gU2ltaWxhcmx5IGZvciB0aGUg
ZGVub21pbmF0b3IsIGlzIHRoZSBieXRlIG9yZGVyCj4gYWxzbyByZXZlcnNlZCBoZXJlIGJ5IHJl
YWRpbmcgdGhlIGhpZ2hlc3QgYWRkcmVzcyBmaXJzdCBhbmQgc2hpZnRpbmcKPiBpdCBpbnRvIHRo
ZSBNU0I/CgpUaGUgZGVub21pbmF0b3IgaGFzIHRoZSBzYW1lIGxheW91dCBhbmQgdGhlIHNhbWUg
bG9vcC4K
