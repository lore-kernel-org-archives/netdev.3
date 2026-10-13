Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFFB56C656;
	Tue, 13 Oct 2026 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931321; cv=fail; b=uXVq8oLdpETBgT9Wi04PxC+wPm3TVzWWP/5ICAArjOrhIFHvIT6Ui/HYgzbjfTD6G5dqv6CMaxUVRbbxGzjBxpTqkVML9N5iCqsjwZk+JL9XuaSOEAun4l/9fb6bnan6xtv8FioVVm/ePFA7awk+ywQ/Q6zD+BMmCZaKWqVKqVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931321; c=relaxed/simple;
	bh=hUd7JoiPS6Ak1J3CLAef3etLUnTMx8aGWv4C2F6Ang8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=We4zO5YGiaN0QkSIgUtsJpU0aWEPPtupF08lrcFfr8pf+N/TNqazl86xMewviVrWOCC7KgH7zQY5sxy36WKYMI1/vH7tHi0NZhV6ca4JSwxdW7KIZeBaruOWbSvWwORQMiBQgwhHRYUO60pw/9I5+mchDuE3N1HBNL/bONS5E7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=A66LYGe/; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=aT6zfKpS; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="A66LYGe/";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="aT6zfKpS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=XRbj8uer2dgdOYYnIii0K7OCdcLWeAZre4SRKBRPnPc=;
 b=A66LYGe/SrMCS2AzVp8KeyxGIGwoZT6EdXc2VieSBWw+asMiQnWHvTdf1pgcOleP8D0vQpipQPZqL26nqa0tNoYxRwtEl2NEmDGzM1XCg6JPJRx59I2EEjo0Zg0A75a2Szcik7+u0yxgEbPoGgmIvlfNTc/gXA8g2aD6LBMI2Dwm2DlnzCRj5cCF7PXjwt9IqVymuBStg1th8yZG30bQHcsWpl2H15ZaRJ0bn+h0euzl5nXkP7sPNy8Ii7546n2YDrsX4bwmrHhLRz0B5XSs82Hdr3QQSzc4w/koeHajnO2+YSW5qeDHxKOApMwN6NM9S0j2X9HXetlCvM7jxAKbdg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020125.outbound.protection.outlook.com [52.101.61.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 426A18006C;
	Tue, 13 Oct 2026 22:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAVTamaG02Guj+/ppRckfAwoqE5Em5YeDuebuRUZSrLSJvDapxERCPb1I6sFDGXDfr64F8e2WrXyeLGZlxw7mzYkYD30aoQE9BhKKtmM+8G8UC6MmTtqBvNkLknBUkIdeepJBnLlj0DruxHyysUXDXid7MwBLVRgbzfA+yp1wZP0hMAOkql+B84E41r64gLAVtIm6WDuLpFe/tG99XJLqzXGviDmrWDSst4ihxR749EYYk368XUFCP8Wztql7VNZRSCN+oNm7PxliG9iF0kbIpWAbCWYYGOVkGmVq9XNw1Sy8kiV0OZsBLrVrVMZhLR7PO9g6Bt6kspNtq6j2lW7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRbj8uer2dgdOYYnIii0K7OCdcLWeAZre4SRKBRPnPc=;
 b=jTsi5GgX15OXmDkiXWGQ2XFyZ4cNNp8eovWuqQXcV2xEjfp+JFYIbNCZsvrm7CWYUchQm0+k1ntqdIIZEaDEEV3L8uD4Y+7QTXgkge5VwfvLfYeua75Wkh/M1Kk87Q57VxFMjmPvRWSGXa6xQm2hTmfjhfTyEswz+yQcUA7ahTcSS/btOiC+sorwWWTIYnWIlGjaudZp01am0ZXkLWD1A6UiggFpUojVewEDnoM3sArWrtNN+VdgfDfeXravpvNvGovK24lu3UbF4BGLdN5R4RzEs5cNX8VGHj3ChS/w5vZN+BbrscXsIfvKIo8+9ysXcpsmBmjeRZj4I2uv3/O5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRbj8uer2dgdOYYnIii0K7OCdcLWeAZre4SRKBRPnPc=;
 b=aT6zfKpShGdAnfJbR+5Qi9dzcrq1ZNgJj6V0zlaToxM+PgtV2VnrwYs99EG255DMshCow72X+YLn8RUszYqydiNHE26SBTpSAk9T95YHQDdLVV3J0cWzX5Oc1X4yUQvITZBLbMgLkWEw7dgXYsJ7a6ITfIeUzGVijepV5xo2TVpIa8NkfuGMgrHBJkbMhqu2zX8bfCvY+36DzFojQK7BBP3VaYqoG3+Koipb1mCPRsCRV4zrf5Q8nCpSu5xdFpP0O4fcS7AjSy+DQrHw1X4ARTv5W//ybDaub0jjSck8Spc7acW+Wd2JP3B2RjUj/IeUpnHdBmEPBAys4bsmWSuwoQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by IA0PR20MB6676.namprd20.prod.outlook.com
 (2603:10b6:208:480::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:41:37 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:41:37 +0000
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
Subject: [PATCH net-next v13 09/12] dpll: sit9531x: implement output pin state
 on a DPLL
Thread-Topic: [PATCH net-next v13 09/12] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Index: AQHdW2QBdhv+rkTQ7Ue2Ep7239Nd6A==
Date: Tue, 13 Oct 2026 22:41:37 +0000
Message-ID: <20261013224131.27149-10-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 0c1e0fa4-0090-46a2-40db-08df297b240c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|5023799004|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 3yMfOSVG1FX1zrmYXEYpGO37rzxv8pmLE6ofGlib3ybhmPLqSwXDHafUgfbtBpD2eUxbrUCnJvQbSy3zxOoiA+FdcWk5/rF/5tVvrR561LlfHbZAtgvtJjb18qxbgh40PBQeS8D96RzdhxwlTUtiKG3VbgpbNJnMzbj1thywlIcx4Le0kIhWbAvYRjHUSng2PprS/5NZA9WFvbULghkT/ylBnCKwBZLYgfTYVewDVwFV80jdtyjVPXb5kPHeoq6VmFskZumyn6NLonntWAKigq1UBU9iFsv2adagy+k/W9Y1BCgYcPG/i7aKzgijZLYvZr01tfOyCOmFCAtCXMQpbSKTrhOhlu2s5z8zWvM8k16csTRLwkQBBN57DcBjvP5qQUVAixjJibEJTNvClP4PHv3HNSgtj5m/DF7PR1eDhlvl/xQjD1vuwbdrTFbY3T+HnCr7KC8gQWGyfKPVrW7+oQzu1v3QB89fbodBqfFZkziVsbZ4GtwTqJxJs981rAU4Jj7dw8+w5CAoywBw9FzmlpCDhHu+wR30ol93soZGWDF/SB38d731AX70mhjgKH4r/ND0Y7y2fFsU/KpupbjnG5Ymleyuy2peR22l4nviGqnQoVMlKymhp50bvgPmniHrI0cDIrAt4/4dfIUDOa1XfZMbdnlBiWpNLgtmD6VRSqX8AykhUFxAg32Pzoln5AKrPFZcR9Z7/f3QLKrl/tlCSILnmdhGaF1MerC2vsxZ0Q4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?j9pLAaECp4x2FV/w+viy1avIQRAVAiJdyDxgOcxMyG6yaNk6GtxrUsj5Mb?=
 =?iso-8859-1?Q?3VKLBXY2Y51kYPSvV0kDFWeuB4hHscnWbLzGcccejgfFlFxrthKVqvTaEv?=
 =?iso-8859-1?Q?IfbLRUWUndCE1U/CRlq+Eat+XUhis/Zx30uJGNqZ/9FnpXJGG09U/8wxsw?=
 =?iso-8859-1?Q?n5vonnY1+JfWDrYUdyCX8fl6Yd+leCGpjOwu1+WhTE7fkOB8RG8dmNOzwn?=
 =?iso-8859-1?Q?llhhBbyAPh0w21ACDCb4rezuHSBTGMnU4Hy4Dm2WoEe0/m/+vyNV04jvIf?=
 =?iso-8859-1?Q?/gWwPzg9E6kB1KzoSv7zVwlT2IdyA54z8hlvRTk1+1E/vq7MDZVE+OkH7/?=
 =?iso-8859-1?Q?9O2UxK8brhV2yKHw8sEJS9cImDxJgGQDNXSEs1ti2XKcMbRvQxqL4VmgRW?=
 =?iso-8859-1?Q?hx+4BGb+4w8GClZiir7F2EPvUKL4/xOxy2UqCEdxgGDtsHYHHZK+0ZfI6L?=
 =?iso-8859-1?Q?/KLH3xoYR1es5Bvw1xQfhLIYI+9RM+bbCFoWywjJSszJEr5ObvJtNROj4h?=
 =?iso-8859-1?Q?kF2+AddsDNvRynjFZ7mW+Ok43+cCDfEF4iyR3umHg4SbjGrvPWJNKJCzSX?=
 =?iso-8859-1?Q?4WP1WGEpTb4vdN0gbl4Q8LGDUgUVL7jGcybjvvjm0CnrtzTxdOwwdz+qwS?=
 =?iso-8859-1?Q?TXqyz/FiRsuzR9Y3kqwyg5v1yggIjX3brif9Ri4NuPqHpDAzjB0XE1eKbA?=
 =?iso-8859-1?Q?DBSQNr2TzS5dINDjsc3SRWvBaZ3LfDMl4rCtptRO/t7QDRtG16tZUwlFP4?=
 =?iso-8859-1?Q?VYUO4n1QcL5I5S5ZG3PX6xb/ah0pYUePC5Ryapsrmy9FsPmS/0/8slosQt?=
 =?iso-8859-1?Q?UL2X8LslNxy43Jb9erN24JLDRqvUK6xc9/9PFT0IDT7iAsicAnfP8PpPf/?=
 =?iso-8859-1?Q?unZBaG+Fqun/VYW+xaf8gBjU1oH+sj3W8KtkvqlNpOpNrL9ADe/hwwkCzp?=
 =?iso-8859-1?Q?hBEs++9ug0MCNnQ0FOUap42rXy8BwLX85vi7Wi3PQD11MDFfGGVGEvl6b4?=
 =?iso-8859-1?Q?NwqUAGUsRTdy+se/+dqf/6BV02rVik5mvURjl/N8IrOE+d0ad4isrguCOa?=
 =?iso-8859-1?Q?X+F07f566RlFB0JIz+jrDZAuI6kU/YfyZtE4ZyYpNGJqb9NQF8DLNzzAxG?=
 =?iso-8859-1?Q?a8EHDSysD0kq1XEPXRjtq/BV1nsFVZVf1KwDGqk7/L7LenL94e9OMYKymA?=
 =?iso-8859-1?Q?eP6xVHV7EXvAOxfN1iDwaIp5o1X1IjJ+GsBiKWmM4qAGjybOkkWzXJtEXP?=
 =?iso-8859-1?Q?3uXJQx/LVBKMEE/CmXRIpcdOn8KwIthzIFxpcAHneLDQ3Ff5VF91QW7KOQ?=
 =?iso-8859-1?Q?IlLHf8qC68XEvN9WFuy+pVMD+ncGKmdzys4MrMBa1uZQA0no8AEeZoCeOD?=
 =?iso-8859-1?Q?zWp0sZV6aWfOIFUG1vib64+xDv/YGUIVUL1Qu9dTdSk00FMnLmDt+9ZwUW?=
 =?iso-8859-1?Q?YPtq+/t8VgEwGISAEztfCFxD7h/G44pIJ7jqGtbR2/ai16TZddHVSUTSYD?=
 =?iso-8859-1?Q?Y4vXJJr5B2hc5Smqz4uq/ridwaRVSkUEu6HA5EHIV7qrxMBslGSdlgD0Fx?=
 =?iso-8859-1?Q?uRuEGOvnGI8x1rC6K9KuJr+LoN552qWbqIY221sfhCujxPj+1l7ESPTWIb?=
 =?iso-8859-1?Q?YFG25ZKYyfeHbPg/OGLtsd8E7aNYcZEUxthc1kh1IH81vMubKilxa89Sy5?=
 =?iso-8859-1?Q?pLGvs8sFapduI0EGn9Ks3gbuzSEm8gT85dexdLh1x4IOLsVx0/7B2WjhWz?=
 =?iso-8859-1?Q?ZW7Da+m69SqRx/kukJGkWTwkwjAA5VBIHp0C0tCqy5y3EP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vlEDM9eYA5zu5IkfaR4dfEywtWpKvjD/6J6OBZZWHMfACHxkyyZG5N3DRiHEzUnllnphPKFWR/qFu63v8JE4ZxLIaKqUPQnVyX19lGQ4Y4EX372WzCZaW+6ny0tKzKr51XeFZYcDXtSN/uDUMucwimJF0y3Xhp0On5AzjaoL9K4g4qTtAgClzB7MW/bgTfjAeOl31luOT/oInM+yvLaz4MNuh/dZdSj2mZ44DY6yiNWTNSNc/gF6cFWU+929eBXUTF7iNhXBdjXIj2iIzGUcOwtrjqm9Jw8q40dvsc1968q3LEKynFuCI7YzUEY6vHoYNg2AqX8V6SJ6p5nRk0yBmA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1e0fa4-0090-46a2-40db-08df297b240c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:41:37.2092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbAPj+DJcTYxeF9ke2VctWhi5uBmB4C/q0mxJTnCYHSDvDl5MZ9IPSnE2uGZsbEtJ5RM1XCRVCXJ6dMkCdUYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6676
X-MDID: 1791931301-Ug8uStx4dryT
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931301;Ug8uStx4dryT;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
An output is driven by its PLL rather than selected by it, so its state=0A=
says whether it carries a signal: connected while it drives, disconnected=
=0A=
while it is muted.  Setting the state mutes or un-mutes it by forcing the=
=0A=
pad to Hi-Z, the only per-output control the device offers that leaves the=
=0A=
divider alone.=0A=
=0A=
The force bit and the state bit are separate, and a pad follows the loaded=
=0A=
configuration while the force bit is clear, so both are read to decide=0A=
whether an output is muted and both are written to change it.  Which of=0A=
the four register banks applies depends on the slot and on whether the pad=
=0A=
is single-ended or differential.=0A=
=0A=
A mute or un-mute is a per-output control, but each one that changes=0A=
something runs the device-wide programming sequence of the previous=0A=
patch, so a request for the state the output already has is answered=0A=
from the registers without entering it.  A request that fails after some=0A=
of its writes landed still announces the change, so a subscriber is not=0A=
left with the old state; the pin handle is read once, so a teardown=0A=
racing the request cannot hand the notification a cleared one.  A failed=0A=
entry into the programming state is left the way a commit leaves it:=0A=
loops re-locked and the settling time waited for.=0A=
=0A=
This is also where output pins start being registered at all: until now=0A=
the registration filter took inputs only, so the output operations the=0A=
earlier patches added -- direction and frequency -- had nothing to=0A=
dispatch on.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Reviewed-by: Ivan Vecera <ivecera@redhat.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 344 +++++++++++++++++++++++++++++------=0A=
 drivers/dpll/sit9531x/core.h |   7 +=0A=
 drivers/dpll/sit9531x/dpll.c | 130 +++++++++++++=0A=
 3 files changed, 427 insertions(+), 54 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 875a5fe783d5..9aa0d327b6bf 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -488,71 +488,50 @@ static int sit9531x_output_forced_hiz(struct sit9531x=
_dev *sitdev,=0A=
 					muted);=0A=
 }=0A=
 =0A=
-/* Attempts to re-lock the output loops before reporting them open. */=0A=
-#define SIT9531X_LOOP_LOCK_TRIES	3=0A=
-=0A=
 /*=0A=
- * sit9531x_prg_abort - leave the programming state without committing=0A=
+ * sit9531x_output_state_refresh - read an output's mute state back=0A=
  *=0A=
- * Entering the state is two writes, and the second can fail with the debu=
g=0A=
- * block already unlocked and the part possibly already in PRG_CMD.  There=
=0A=
- * is nothing to commit in that case, but the loops still have to be close=
d=0A=
- * and the debug key put back, which is otherwise only done by=0A=
- * sit9531x_prg_commit().=0A=
+ * Used when a mute could not be confirmed at the time it was written.  Th=
e=0A=
+ * driver does not poll output state, so without this the cached value wou=
ld=0A=
+ * stand until something else happened to write it.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
  */=0A=
-static void sit9531x_prg_abort(struct sit9531x_dev *sitdev)=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev, u8 out_idx)=
=0A=
 {=0A=
-	int rc =3D -EIO;=0A=
-	u8 attempt;=0A=
+	bool muted;=0A=
+	int rc;=0A=
 =0A=
-	for (attempt =3D 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {=0A=
-		rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
-				       SIT9531X_LOOP_LOCK);=0A=
-		if (!rc)=0A=
-			break;=0A=
-		usleep_range(1000, 2000);=0A=
-	}=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_output_forced_hiz(sitdev, out_idx, &muted);=0A=
 	if (rc)=0A=
-		dev_err(sitdev->dev,=0A=
-			"output loops left unlocked after a failed entry: %d\n",=0A=
-			rc);=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].enabled =3D !muted;=0A=
+	sitdev->out[out_idx].state_stale =3D false;=0A=
 =0A=
-	sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
-			  SIT9531X_DEBUG_LOCK_VAL);=0A=
+	return 0;=0A=
 }=0A=
 =0A=
-/*=0A=
- * Enter the output-system programming state: unlock the debug=0A=
- * registers on Page 3 and issue the PRG_CMD state command.  Register=0A=
- * writes that reconfigure the output system only take effect when=0A=
- * they are made inside this state.=0A=
- */=0A=
-static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)=0A=
+static int sit9531x_hiz_set_bit(struct sit9531x_dev *sitdev,=0A=
+				unsigned int reg, u8 bit, bool set)=0A=
 {=0A=
+	u8 cur, new_val;=0A=
 	int rc;=0A=
 =0A=
-	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
-			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &cur);=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
-	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
-			       SIT9531X_PRG_CMD_STATE);=0A=
-	if (rc) {=0A=
-		/*=0A=
-		 * The debug block is unlocked at this point, and a transfer=0A=
-		 * that reported an error may still have reached the part --=0A=
-		 * which would leave the device in PRG_CMD with its output=0A=
-		 * loops open.  Callers skip the commit when the entry=0A=
-		 * fails, so close both here.=0A=
-		 */=0A=
-		sit9531x_prg_abort(sitdev);=0A=
-		return rc;=0A=
-	}=0A=
+	new_val =3D set ? (cur | BIT(bit)) : (cur & ~BIT(bit));=0A=
 =0A=
-	return 0;=0A=
+	return sit9531x_write_u8(sitdev, reg, new_val);=0A=
 }=0A=
 =0A=
+/* Attempts to re-lock the output loops before reporting them open. */=0A=
+#define SIT9531X_LOOP_LOCK_TRIES	3=0A=
+=0A=
 /*=0A=
  * Commit a programming sequence started by sit9531x_prg_enter():=0A=
  * update the NVM shadow and re-lock the loops.  The sleep gives the=0A=
@@ -622,6 +601,251 @@ static int sit9531x_prg_commit(struct sit9531x_dev *s=
itdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Enter the output-system programming state: unlock the debug=0A=
+ * registers on Page 3 and issue the PRG_CMD state command.  Register=0A=
+ * writes that reconfigure the output system only take effect when=0A=
+ * they are made inside this state.=0A=
+ */=0A=
+static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_PRG_CMD_STATE);=0A=
+	if (rc) {=0A=
+		/*=0A=
+		 * The debug block is unlocked at this point, and a transfer=0A=
+		 * that reported an error may still have reached the part --=0A=
+		 * which would leave the device in PRG_CMD with its output=0A=
+		 * loops open.  Callers skip the commit when the entry fails,=0A=
+		 * so leave the state here the way every completed sequence=0A=
+		 * does: nothing was changed, so the update commits what the=0A=
+		 * part already holds, the loops are re-locked, and the=0A=
+		 * settling time is waited out before the caller drops the=0A=
+		 * lock and the next request programs the part.  The entry=0A=
+		 * failure is the error to report.=0A=
+		 */=0A=
+		sit9531x_prg_commit(sitdev);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_hiz_write - mute or unmute an output=0A=
+ *=0A=
+ * Muting takes control of the pin (MASK=3D1) and forces it to Hi-Z=0A=
+ * (STATE=3D0) on every Hi-Z pair of the slot -- differential, CMOS OutP=
=0A=
+ * and CMOS OutN -- because the output must go quiet whichever way it is=
=0A=
+ * wired; unmuting releases the override on all of them and hands the pin=
=0A=
+ * back to the device.  The caller must already be in the programming=0A=
+ * state.=0A=
+ */=0A=
+static int sit9531x_output_hiz_write(struct sit9531x_dev *sitdev, u8 slot,=
=0A=
+				     bool mute)=0A=
+{=0A=
+	u8 mask[SIT9531X_HIZ_PAIRS], state[SIT9531X_HIZ_PAIRS];=0A=
+	struct sit9531x_hiz_pair p[SIT9531X_HIZ_PAIRS];=0A=
+	int i, rc, undo_rc;=0A=
+=0A=
+	sit9531x_output_get_hiz_regs(slot, p);=0A=
+=0A=
+	if (!mute) {=0A=
+		for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+			rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+						  false);=0A=
+			if (rc)=0A=
+				return rc;=0A=
+		}=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Remember every pair as it was: if the mute fails part-way, that=0A=
+	 * is what the pad goes back to -- which may already be a mute, from=0A=
+	 * an earlier request or from the loaded profile.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, p[i].state, &state[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		rc =3D sit9531x_read_u8(sitdev, p[i].mask, &mask[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Forced value first, override enable second.  Muted is decoded as=0A=
+	 * MASK set with STATE clear, so enabling the override while STATE=0A=
+	 * still holds whatever the loaded configuration left there can pin=0A=
+	 * the pad driven for the width of an I2C transfer.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+		rc =3D sit9531x_hiz_set_bit(sitdev, p[i].state, p[i].bit, false);=0A=
+		if (!rc)=0A=
+			rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+						  true);=0A=
+		if (rc)=0A=
+			break;=0A=
+	}=0A=
+	if (!rc)=0A=
+		return 0;=0A=
+=0A=
+	/*=0A=
+	 * Only part of the mute reached the device.  Put every pair it may=0A=
+	 * have touched back to the bits read above -- override first, then=0A=
+	 * value, the reverse of the order they went on -- so the pad ends=0A=
+	 * where the request started rather than on part of a mute, or=0A=
+	 * un-muted when it was muted before.=0A=
+	 */=0A=
+	for (; i >=3D 0; i--) {=0A=
+		u8 bit =3D BIT(p[i].bit);=0A=
+=0A=
+		undo_rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+					       mask[i] & bit);=0A=
+		if (!undo_rc)=0A=
+			undo_rc =3D sit9531x_hiz_set_bit(sitdev, p[i].state,=0A=
+						       p[i].bit,=0A=
+						       state[i] & bit);=0A=
+		if (undo_rc)=0A=
+			dev_err(sitdev->dev,=0A=
+				"slot%u: Hi-Z override left part applied (%d)\n",=0A=
+				slot, undo_rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_disable - mute an output (force Hi-Z)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Sets MASK and clears STATE on every Hi-Z pair of the slot, differential=
=0A=
+ * and both CMOS pads, so that the output is muted regardless of its=0A=
+ * electrical configuration.  The=0A=
+ * writes are wrapped in the PRG_CMD / NVM update / loop lock sequence=0A=
+ * so the new state is applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	int rc, ret, state_rc;=0A=
+	bool muted;=0A=
+	u8 slot;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_hiz_write(sitdev, slot, true);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/*=0A=
+	 * Keep the software state aligned to what hardware now drives even=0A=
+	 * when one write in the sequence failed. The commit above may have=0A=
+	 * applied a partial mask/state combination.=0A=
+	 */=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		/*=0A=
+		 * The writes may well have landed; what failed is the proof.=0A=
+		 * Mark the cached state for a read-through rather than=0A=
+		 * reporting the value it had before this call.=0A=
+		 */=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_enable - un-mute an output (active state)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Releases MASK on every Hi-Z pair so the device drives the output=0A=
+ * again as the loaded profile configures it.  The writes are wrapped=0A=
+ * in the PRG_CMD / NVM update / loop lock sequence so the new state is=0A=
+ * applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	int rc, ret, state_rc;=0A=
+	bool muted;=0A=
+	u8 slot;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_hiz_write(sitdev, slot, false);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/* See sit9531x_output_disable(): commit can apply part of it. */=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		/*=0A=
+		 * The writes may well have landed; what failed is the proof.=0A=
+		 * Mark the cached state for a read-through rather than=0A=
+		 * reporting the value it had before this call.=0A=
+		 */=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input priority selection=0A=
  *=0A=
@@ -2515,6 +2739,8 @@ static int sit9531x_out_state_fetch(struct sit9531x_d=
ev *sitdev, u8 index)=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
+	sitdev->out[index].state_stale =3D false;=0A=
+=0A=
 	/*=0A=
 	 * Each PLL page holds the PLL's output-enable mask, twelve bits:=0A=
 	 * bits 0-7 in OUT_MAP_LO and bits 8-11 in OUT_MAP_HI[3:0].  PLLA and=0A=
@@ -3323,7 +3549,7 @@ static void sit9531x_dpll_pin_unregister(struct sit95=
31x_dpll_pin *pin)=0A=
 	 * afterwards leaves a window where the field still reads as live=0A=
 	 * and the pin behind it is already gone.=0A=
 	 */=0A=
-	pin->dpll_pin =3D NULL;=0A=
+	WRITE_ONCE(pin->dpll_pin, NULL);=0A=
 =0A=
 	dpll_pin_unregister(sitdpll->dpll_dev, dpll_pin, ops, pin);=0A=
 	dpll_pin_put(dpll_pin, &pin->tracker);=0A=
@@ -3373,8 +3599,8 @@ static void sit9531x_dpll_pins_unregister(struct sit9=
531x_dpll *sitdpll)=0A=
  * @index:	pin hardware index=0A=
  *=0A=
  * For input pins: delegate to sit9531x_input_pin_is_registrable().=0A=
- * A pin class whose state callback the tree does not have yet is not=0A=
- * registrable: the core refuses a pin without one.=0A=
+ * For output pins: the pin is registrable if this DPLL is routed to it,=
=0A=
+ * whether or not it is currently driving.=0A=
  *=0A=
  * Return: true if pin should be registered, false otherwise=0A=
  */=0A=
@@ -3384,13 +3610,23 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 {=0A=
 	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
 =0A=
-	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+			return true;=0A=
+		if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+			return false;=0A=
+=0A=
+		return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
+	}=0A=
+=0A=
+	if (index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
 		return false;=0A=
 =0A=
-	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
-		return true;=0A=
+	if (index >=3D sitdev->info->num_outputs)=0A=
+		return false;=0A=
 =0A=
-	return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
+	return sitdev->out[index].pll_idx =3D=3D sitdpll->id &&=0A=
+	       sitdev->out[index].routed;=0A=
 }=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 890a52831484..1464ba0b6614 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -99,6 +99,8 @@ struct sit9531x_ref {=0A=
  * @cmos:		output is wired single-ended; the Hi-Z pairs that=0A=
  *			speak for it are the two CMOS pad ones, not the=0A=
  *			differential=0A=
+ * @state_stale:	the cached mute state could not be confirmed against=0A=
+ *			hardware and has to be read back before it is reported=0A=
  * @routed:		output is mapped to @pll_idx by the initial=0A=
  *			configuration; an unrouted output has no DPLL pin=0A=
  * @pll_idx:		PLL driving this output (0-3)=0A=
@@ -107,6 +109,7 @@ struct sit9531x_out {=0A=
 	u64		freq;=0A=
 	bool		enabled;=0A=
 	bool		cmos;=0A=
+	bool		state_stale;=0A=
 	bool		routed;=0A=
 	u8		pll_idx;=0A=
 };=0A=
@@ -259,6 +262,10 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitde=
v, u8 pll_idx,=0A=
 			    u8 input_idx);=0A=
 =0A=
 /* ---- Output enable/disable (Hi-Z control) ---- */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev,=0A=
+				  u8 out_idx);=0A=
 =0A=
 /* ---- Output frequency ---- */=0A=
 int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index aa021b374c45..f6e76318a567 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -831,10 +831,140 @@ sit9531x_dpll_output_pin_frequency_set(const struct =
dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_state_on_dpll_get - get output pin state=0A=
+ *=0A=
+ * reports CONNECTED when the output is driven and=0A=
+ * DISCONNECTED when it has been muted via sit9531x_output_disable().=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					   void *pin_priv,=0A=
+					   const struct dpll_device *dpll,=0A=
+					   void *dpll_priv,=0A=
+					   enum dpll_pin_state *state,=0A=
+					   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	const struct sit9531x_out *out;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * A mute whose read-back failed left the cache unconfirmed; there is=0A=
+	 * no poll of output state to correct it, so read it here rather than=0A=
+	 * report a value that may predate the request.=0A=
+	 */=0A=
+	if (sitdev->out[dpin->id].state_stale) {=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_output_state_refresh(sitdev, dpin->id);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (rc) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Output mute state could not be read back");=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	out =3D sit9531x_out_state_get(sitdev, dpin->id);=0A=
+	*state =3D out->enabled ? DPLL_PIN_STATE_CONNECTED=0A=
+			      : DPLL_PIN_STATE_DISCONNECTED;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_state_on_dpll_set - mute/un-mute an output=0A=
+ *=0A=
+ * Forces Hi-Z on the output through the Hi-Z force/state register pairs=
=0A=
+ * of its slot, the differential and the single-ended one.=0A=
+ *   CONNECTED    -> enable (release the override, the device drives it)=
=0A=
+ *   DISCONNECTED -> disable (force Hi-Z)=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					   void *pin_priv,=0A=
+					   const struct dpll_device *dpll,=0A=
+					   void *dpll_priv,=0A=
+					   enum dpll_pin_state state,=0A=
+					   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	bool enable =3D state =3D=3D DPLL_PIN_STATE_CONNECTED;=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	bool was_enabled, changed;=0A=
+	int rc;=0A=
+=0A=
+	if (!enable && state !=3D DPLL_PIN_STATE_DISCONNECTED)=0A=
+		return -EINVAL;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * The core forwards a request for the state the output is already=0A=
+	 * in.  The Hi-Z pairs say what the pad does now, so read them and=0A=
+	 * answer such a request from them rather than run the programming=0A=
+	 * sequence, which holds the output loops unlocked for the 100 ms its=0A=
+	 * commit takes and would change nothing.  A read that fails leaves=0A=
+	 * the request to the sequence and its own read-back.=0A=
+	 */=0A=
+	if (!sit9531x_output_state_refresh(sitdev, dpin->id) &&=0A=
+	    sitdev->out[dpin->id].enabled =3D=3D enable) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	was_enabled =3D sitdev->out[dpin->id].enabled;=0A=
+=0A=
+	if (enable)=0A=
+		rc =3D sit9531x_output_enable(sitdev, dpin->id);=0A=
+	else=0A=
+		rc =3D sit9531x_output_disable(sitdev, dpin->id);=0A=
+=0A=
+	/*=0A=
+	 * A read-back that failed left the cache unconfirmed, and the=0A=
+	 * writes before it most likely landed: count that as a change too,=0A=
+	 * and let the getter's read-through fill in the state when the=0A=
+	 * notification is built.=0A=
+	 */=0A=
+	changed =3D sitdev->out[dpin->id].enabled !=3D was_enabled ||=0A=
+		  sitdev->out[dpin->id].state_stale;=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		struct dpll_pin *dpll_pin;=0A=
+=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set output pin state");=0A=
+		/*=0A=
+		 * The core notifies only a request that succeeded, and the=0A=
+		 * poll does not watch outputs.  A failed request whose=0A=
+		 * read-back shows the output did change, or could not show=0A=
+		 * whether it did, still has to be announced, or subscribers=0A=
+		 * keep the old state for good.  The core's lock is held here,=0A=
+		 * as the helper requires.=0A=
+		 *=0A=
+		 * Teardown clears the pin's handle without that lock before=0A=
+		 * it unregisters the pin, and this callback spends the=0A=
+		 * sequence's 100 ms under it.  Read the handle once: NULL is=0A=
+		 * a pin on its way out, with nobody left to tell, and a=0A=
+		 * handle still set stays valid until this callback returns.=0A=
+		 */=0A=
+		dpll_pin =3D READ_ONCE(dpin->dpll_pin);=0A=
+		if (changed && dpll_pin)=0A=
+			__dpll_pin_change_ntf(dpll_pin);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
 	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_output_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
