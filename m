Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727414F85B4;
	Fri,  9 Oct 2026 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570219; cv=fail; b=q8SMnryqA9f15ZY5VycPj0JdO+fgkTo0hpU6WT56LfyDQrJKwanSJRUNi+uyfHh5Mr7pyMmDY1FRhI03UKAz3JhvNdbxhwtaV4KOTozsQbNW//Pqn7aQnb5SEvVyjwFnbQkM6Wxc9aOqYdiRNx0cN515p2zaibh6nZjQdzQ7kkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570219; c=relaxed/simple;
	bh=zLxOVMiOKBswZhRjPFxxJJdBrEfiec/6KXwsID8L4Q8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8L3GIx+MEjGmSTAhhBMZLGICW65t6nnc8T0gRkHNjMe8Dt1BzaSR4bd09zvJnUXnYS5QBVHsfaIYdXsPmvg1DJnZYemF4DWyejHjL7mln5TcdxLLcWH4gNw4KTubWxIFpxWU5B5v6GszRB6Js+SN0rO/Dl7Gtmmi29zdicg6Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=k//phQCl; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=mw+yJyD7; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="k//phQCl";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="mw+yJyD7"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BA0B844D714;
	Fri,  9 Oct 2026 18:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=zLxOVMiOKBswZhRjPFxxJJdBrEfiec/6KXwsID8L4Q8=;
 b=k//phQCldY9Od38Cpz98EOnkXEaMYTnIiUChy/c0tyzyBm1VbBUVSV+88UMqKWgDavlu8yWyRYtm1HPLCAxPU5NGA2RFqIccMsqmD9qK/UBNAUHCfwP0d/fFIuJX4Tt+HdASPj9wI5xA6ByQebQ3j9X8XyV2R0HF0KitwGlotVqWZ3T8zG5J6SnElKLSe9PWpS3reXRiF4TLeuMBAylNMaQHjMQKSijshjBpdCU4BkEdKKSv7vLUNzrtOQD9koxQREi5gkKMoGHh91aKlpkPxKEIb7CO47St9OOIc0iqnNKUfeDYkqFPvzvZNj+CaMDEWfMhlKqgWhQ+EsT3ZX7OpQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022092.outbound.protection.outlook.com [40.107.209.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3B3F2100075;
	Fri,  9 Oct 2026 18:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1cXuGo4ajD7DJdQqOMa22rMlQSTg6L5f7/soxPWD6Fdt7O6HwHAw7ChRZipCBHfWgSydxm003KP9cJWxB8jOLXDJ2mWUPAfLyFSN8TBaadKn2m1jzhXmrM/VP/5LjuvbyFnL58Hr9x+1MCoLHz5jZdp3+RXbXmCfUfW2iapmaaTd6QRdEwGyRCq9yfNo+mwF86b0L412tLwihSxDbcbDxgQgzTG93P3/Cl8aNK4h2uq+3ndQXVZ4H/Ii8kSXpnCZ0YjK0ydJv10bzLGTegDT6NQVvoY5QvjGHyFwInluLYSicayArqJSLs8THkRk3H3fV6GLO8TLsYv7VV1UvPaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLxOVMiOKBswZhRjPFxxJJdBrEfiec/6KXwsID8L4Q8=;
 b=iw5PMk0xyrdkTTu462XUBEBV0YkCqb//QM/FHywqvV/+gRkkZN43ixRJVLVgtCL5hVRi4olEYlGrtzLptzdkNnhh8fLl7y5Z37u1FQfnGGKRHKam8G59KCmPs3XLCoX7MLQNWjP0rW9RoUPZJssvDTtsy1bOh3d/cwk/YH4tZuF/namgM1ZMNBr+EcutSQdgCN4zUMiwbkBk8oXTVaH5yoAOYdnROAkLonCSuBtfgLK9AEITzuUnGjWi64EeryPLcGsxlVLr9+hC+VyGo3EZ7TVCX1GFQ7071oghUsK2DhFLlIzW743t8RiPdb03pzuFoIDEjBRT/jz5agJveKbnKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLxOVMiOKBswZhRjPFxxJJdBrEfiec/6KXwsID8L4Q8=;
 b=mw+yJyD7WTFbqipF7G5YHJ7Xzwiyy3BPi5ExUpp4xrP71FdB57hfAXED2WlXPZK1sLe/TLdyuGbjNQqMmBQKhGxv3r7kILKuv9VcvWdFde9boAL7IroPxliYoA4spXPJ8lyG+A1NpCfuc1Wt659ROhw8K5sd9tIq/suu4P3Bzb1joIp5tdsmSLcYlqvuSObBS6w3dnrcUdm/sqdg5L4BrFV4DkWfJ5jPYnAWBbX0APYuvqIg01mBBuiy7WRkUuW8aoaUeZbvR0sURljNjYvlJU0tL9l2qUlt8rIx3I/cGHnpcjhksoWAI7rk3H6rn/lOYS482ZJLnoBpa6ZV9qiaiQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH9PR20MB007164.namprd20.prod.outlook.com
 (2603:10b6:610:314::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:26 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:26 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 06/13] dpll: sit9531x: register DPLL devices
 and pins
Thread-Topic: [PATCH net-next v11 06/13] dpll: sit9531x: register DPLL devices
 and pins
Thread-Index: AQHdUTSirK6vvqwIv0yxJhRl8uO+lLbuKhKAgAdqBQA=
Date: Fri, 9 Oct 2026 18:23:26 +0000
Message-ID: <20261009182323.76166-4-arouhi@sitime.com>
References: <179116259911.434549.6587142199088743518@kernel.org>
In-Reply-To: <179116259911.434549.6587142199088743518@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH9PR20MB007164:EE_
x-ms-office365-filtering-correlation-id: 4fb015a1-ce09-464f-8f36-08df2632695a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|38070700021|56012099006|5023799004|22082099003|10067099003|6133799003;
x-microsoft-antispam-message-info:
 upP1zQX//xe2E6w0GIgSWMlFxstUOd8LMCcozWFedQL/d6ScPSNM3XgBTezn+W/bclSyYz2tmq8byaUlFQMnEuqtx5ykwOn3C/NrzgxBFg389AmIPXq68KiDMfkNbyCLw+50uY8P67uhUhwtewAxnmXsRXKrsEJJ46XU2+9UUh4MnqesJ1zUjM46Z2KzIFb8d1tvxZaF9+gBNpGzjqfmZD7cTD7QYVHcW9Uq8nPlzaCPflPRnPMFUWgiImQ1zipGqWhhB1jTzs18U6Ijtt2mY+RORXbO7XGvVYYLwnsRWzd3Ue3enEgNZgL6z4HANiU0FK5v21kK+grox+dGZzC/g27lFaxPXs9v3fLU4mwISPCyfYU1cYLgH3BAV15Mn8TPqJpQagjO4LVIfHfgPlnsNUBwGgV7qxcrxJ+DU83c+xeeodK7H39RtU3ti5/Mze4i5ORax8nNdlQ/bQhiSueKahMmMYdCEG79/wyZtOE2eMM4vxjekwZsv2eYobm6PZO0GHkxy4TaLFr/fer+CviQiFi4+txjBSSi2nOnJoM7NRwhwNWc03FBXKoBdT4hOPi6qFwhzJkW6pcdZQp6ebEj007MseBJOt4D1oqT/N4N3Nygym2N/v2Z9+WODAO+jQqvTRbHiIqpTCyK+rcmzYaW3QL3sO23gkGacrW6p1yEO1ahfEEhWw56MUyu7Pl5N/OOW/aPzP0kf9i2n0klamnNVI2cprGr6wRcaYsD4NY0js8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(56012099006)(5023799004)(22082099003)(10067099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zJ85/FkfXpogQEgenqnzYoK20heK1nYjxGMWX67VR6+zXynil7OvKNsgtH?=
 =?iso-8859-1?Q?co8Sb5/urz8rqyplFL5AoAzak+guYXyDomE2oC5VDhSkhGIgoxNOy5f5i+?=
 =?iso-8859-1?Q?GZ9NNsjIexAYc8tyO1EEiWKlfpBzg6rgE6eHB4WvxbxmdAywILvghllLV9?=
 =?iso-8859-1?Q?hKTrv8wvuAeQ46O4AGphYtq3c8nspHas3pEtOnI6ccWox+J5swpIEr61JQ?=
 =?iso-8859-1?Q?Y361RQGFUp0prvOkhQI4xDKceFQmMqa2AiowK6ZN/YRocJntjPheX8ypZW?=
 =?iso-8859-1?Q?z7i00DTz50ywjar5h2UpHeDS+qd1sp7wfOWLGz4aQGkuM3NUlECWV+IEiK?=
 =?iso-8859-1?Q?NSBmIjkDBvq0yz3fmjNBeHeMw2j9TyvpNTsxDXBbKikcOTQYtuvK/wqVSo?=
 =?iso-8859-1?Q?VhlyJhnVL0L7Kox/UVdm6W6DFUNlXRnOQzvJxxtgBZ1+S7UQFD5NvKGVlk?=
 =?iso-8859-1?Q?0GgYhJ9gc1GfeOQ72i1FWQbf+8w4t+/nkV1EM0ea4uMxz1y1XIEDfVvPiZ?=
 =?iso-8859-1?Q?Su1n21l3ftLsr8j5+McJVnVa3RCkPcIaCxdod09twqSDNmyjXuqvL//mbi?=
 =?iso-8859-1?Q?vkFwu77tBDnlITx5BkwgBxYgndN0iQpnX3w8+n7PRp6N23SLl8dYr8SvXe?=
 =?iso-8859-1?Q?GjZtX0/upGisiXZ85C8u6LDBgXwH7fPSuqBxrtx6U58qTc/J6E5Q5h46dh?=
 =?iso-8859-1?Q?pFe8nQMVCeFxyNO1HUhP8pnHvFrhwHcdaHtmRnpDxYRLPDmEXN1pMCWqkq?=
 =?iso-8859-1?Q?tWup00kpClcZOIeUHi9Q2UpRFiUjNRUdBkzk0ckkhuyfonZJUfu6zLUDbs?=
 =?iso-8859-1?Q?E0ECCnEwtRjSREnF1AQ4D/+gdOreSoFsVcn2eqys829eofXQNyo/VtbgUZ?=
 =?iso-8859-1?Q?TkW8ZOKcaU6XHlVjvhdBUioy11r432BAFAPokhEEX5YrgcvL79Fz2afcsF?=
 =?iso-8859-1?Q?jMO/WxnguFOPrqlIbzTQT1Ec1WP63oxcRtqtttUGFnGXhroNp+HLBpsIq/?=
 =?iso-8859-1?Q?QPZojGo6P8KKrqZyxvamspL6Sqlq2UR1zLhWOc1NojuoqU3AS6b/dwIn1i?=
 =?iso-8859-1?Q?HS5/PoMsNi9InHQAlBLwy64IKpXu5QQU0lEuN+1qpa0EK4OXe7+96yZJI8?=
 =?iso-8859-1?Q?nFgTxZGMtRAwj03ojQCBT6Db4f8WhKeGBVmBuUYbf2h50N81pMFBpsEfzk?=
 =?iso-8859-1?Q?d3+zRhlbu0wikh67JMXhhdgj+2pdN5s//I0OAS8snEkjdA+QG+O5WJBHpH?=
 =?iso-8859-1?Q?5aaDx9ERErK4jtljstHxOvPBveOrSs+IowZk5TQv04w8ChhzXF+rwKHJGA?=
 =?iso-8859-1?Q?PtSPNnJzFF3SNQAZ3YfmV1jDj4UgjQJktwRNspKrbzlsa4flT+5PUaHXXb?=
 =?iso-8859-1?Q?vtFraLG0JXdL/fSRBlCaPeP/5gCd2qZLnaHsRDB1h/Dtf8cCOYVoO53IgP?=
 =?iso-8859-1?Q?n8CmF+m4mIn3oi0cn3flBNd8eZN2FWTT1mXMbBhISx3G1mk7Abaqw4fqr+?=
 =?iso-8859-1?Q?a8+vcHDn2utskYex0c0UFBKvi+v/lWHP69vD83lQ9Nj6WwVO9sAfaI70PK?=
 =?iso-8859-1?Q?DWL384oiHZVDjW4R0B/QbD9oYnAVRFTL0oE1JiRk4F/yzV5X9VXsl+9hNh?=
 =?iso-8859-1?Q?+RgRdIN1SOqrffStqzdQqf1pZsEh5RNT8JeHi3AAVZ/bFnnQvP3wUG7Am1?=
 =?iso-8859-1?Q?DOZC6YZHq5dmQzs1baZaMcJefcSG9u/hVguttcbcO09XlmIfwqNYBcPI6i?=
 =?iso-8859-1?Q?Lpg7HRzlMJbZqdP9A2Dt17iOepy7m2sLP4yZzSCCvjksZw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oqw+QcGo7nUTqFd7CymSeklbob7vmwTsgyWD1GNr7sepHp+eaCw/XxMb+rinESZB0LOk0DNqtwdCslWI/8aeCnmnbCfhQE0z92iv0fx4tn5vadC1wcbUpmn6Us8Xh1zDlctNjGIfV+nezj4GEpLJA9naOeIiOyPAKy/X/Yfhy0yMFsssgbmuYAPof2RFT0tnRhBx/NYGgHHm+bv6R+YQkDw2IdrRKjFObW0dzgUvk0s0P35v2O5lHE7UTP/bxajVNqCvrdoHUqU5w1Kiqpc7OMnviUYTkdrKK7UfzUxKHFY/pIa2PrJek+3ExFVZPWsDZYhfCOgG7EReD5nJa6FtnA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb015a1-ce09-464f-8f36-08df2632695a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:26.7529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGfWhi2vUrNaEby8Tw6wUsITBFUT89Vjsel8nMjg4Z7OvoztgMrRWG0P83L4iivRSeoScBK2HSdL0K04/okjnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR20MB007164
X-MDID: 1791570208-C5BhKzAKklEj
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570208;C5BhKzAKklEj;<arouhi@sitime.com>;5de2396b9b83917d02f0372d9ae54394
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, netdev-bot+sashiko@kernel.org wrote:=0A=
=0A=
Replies inline, in the order of the summary list.=0A=
=0A=
> [Severity: Medium]=0A=
> Is DPLL_MODE_AUTOMATIC the right value for a PLL whose profile sets=0A=
> manual active select? sit9531x_manual_sel_report() detects PLL_CONFIG1F=
=0A=
> bit 6 at probe, but only warns:=0A=
>=0A=
> [...]=0A=
>=0A=
> With no .mode_set, the core already refuses mode changes. For a PLL where=
=0A=
> sit9531x_manual_sel_report() found bit 6 set, could mode_get report=0A=
> DPLL_MODE_MANUAL and supported_modes_get list only MANUAL?=0A=
=0A=
A profile can set the manual active-select bit, and the driver reports=0A=
it: sit9531x_manual_sel_report() reads CONFIG1F bit 6, MISCINNER bit 5=0A=
and the MAN_IN_SEL bit at probe and says so once.=0A=
=0A=
With the inner manual bit clear the PLL follows CLK_ACTIVESEL, which=0A=
this driver rewrites on every table commit, so the selection is the=0A=
driver's and AUTOMATIC is the right report. A read-only MANUAL would=0A=
describe only the case where the inner manual bit is set, which the=0A=
loaded configurations do not do. If one does, the message at probe says=0A=
which bit, and the mode can be made to follow it then.=0A=
=0A=
> [Severity: Medium]=0A=
> Can a PLL that is frozen in holdover be reported as LOCKED here?=0A=
>=0A=
> [...]=0A=
>=0A=
> Should the ho_freeze test come before the locked test?=0A=
=0A=
Fixed: holdover freeze is tested before the lock bit, which is also the=0A=
order the pin-state contract uses (a pin is active while the PLL is=0A=
locked and not frozen). A frozen PLL whose outer loss-of-lock bit is=0A=
clear reports holdover, not locked.=0A=
=0A=
> [Severity: Low]=0A=
> The pin loop below takes a first-poll baseline through pin->seen, but=0A=
> this device-level comparison has no baseline.=0A=
>=0A=
> [...]=0A=
>=0A=
> Won't the first tick send a dpll_device_change_ntf() for every PLL that=
=0A=
> is locked or in holdover, even though nothing changed?=0A=
=0A=
Fixed: the device's lock status is seeded at registration, through the=0A=
same getter the poll uses, so the first tick announces only what moved=0A=
since. The pins' baseline moved the same way, see the reply on 08/13.=0A=
=0A=
> [Severity: Low]=0A=
> Slots 2n and 2n+1 share one register, so sit9531x_prio_reg() returns the=
=0A=
> same address on two consecutive iterations. Is it intended that 5 of the=
=0A=
> 6 priority registers are read twice, for every PLL, on every poll?=0A=
>=0A=
> [...]=0A=
>=0A=
> Could each priority register be read once, and the global status bytes=0A=
> once per tick? That would remove about 30 transfers per tick.=0A=
=0A=
The count is right: the table is read a byte per slot although two slots=0A=
share a register, and the three page-0 status bytes are read once per=0A=
PLL rather than once per tick.=0A=
=0A=
None of it is a correctness problem. The poll runs at 500 ms and the bus=0A=
is 100 kHz, which leaves it idle for most of the period. Reading the six=0A=
table registers once and hoisting the three global reads is a mechanical=0A=
change; it is planned for a later revision so this one stays about=0A=
behavior.=0A=
