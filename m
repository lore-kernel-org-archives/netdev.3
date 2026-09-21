Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F74418A3F;
	Mon, 21 Sep 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021498; cv=fail; b=XXYj7iE3AEtMPEkFud8IwbCCx9lzkXdwTqOT2pgy5O5lv4KHSITQpCsWJWDQJWRYxfL+Wmvfark5jQM/s+TjqT1Ll9l1bkJaJfSYC6NnEdHwjHEitnjmk4kUC2kbR7oG+s4b06Sj0UkIVdz32kCuuqm7jaTzYNXxHm5fz4A3f2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021498; c=relaxed/simple;
	bh=fFR8yDd10AbLv9Df4d3Vya9bklcq7PX8tmjfWQL25j4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O8soQrnAgLVImp/nepJXLmL5OmHL/OkavJBJPrmF2jq63FoKPho5CFkfZzw0WKwuxM4x/jGzzN970Y7U6iiHB1VA6z/ugST3yty1PZJsLajA6vm6tEKRVYp7EtFn3YH25z3iO5gb8uNtSoAJe3+ZjmE5PUZghNLVlzf9HOtrRk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=XIl2JqYQ; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=Gj0Q+RYt; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="XIl2JqYQ";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="Gj0Q+RYt"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D0CE11C7957;
	Mon, 21 Sep 2026 20:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=N39pBbRzEIAIXqGWQFgKfr0ot0dXGm3viRwTsos5P3k=;
 b=XIl2JqYQC5i9QFWWBcmGctWUIhHpVihPtflZai0tA1QOFM7f7+53PEyCenA3s38Up3jWv+DgTU2SldGCrbI/HM+mV9KeosxNFEjvJB50btB/zEUQ2KJcJh0oqGyfMxwNmrHB+X5dqu89mwBgtIeQMm3Q1TtIP/dTZO/61V24bHVtMC7tIq1DFes1JAuQpHvIHZ1G3asJZSEySo50pjdQxjB4vK9gKUgepr5hyfCN8LP1HGGKRwXDn+REVz8oqnv3ymLdbjoLN+dvb7gHw2Sj3LqwmsFHJtihv71RutzsEVXAHrvTozNnV/0unvtPLaqoF1s5riLIMiYJjIEz/3TgWg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020131.outbound.protection.outlook.com [52.101.193.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 280B89C0085;
	Mon, 21 Sep 2026 20:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeCqg1nGOMGvArVQ3TzwHtGJU5LtmkLYdf5YQcn/kcrQxOCMl8RabRen6fD8WDCniar0opCHSnlZ6lUu5VOLpwNYgW9jnx8aSx6JwiE7ObbEMQ2U3J9UI4RRwmJ1Cojnp2erWylRaQl862Iqh0ycb4ePPxoL7fDGviIM/MxhPRvwuLPtGD5nhF0PwFook6hec1QTauFjHJqble+lLo2/1ZssD5uZxnxHchUlNq0BxJLmLK3fV7q7b9HvBtJrauxxsdwxmaBaxbKLM3g/ryF1VHh0C4IpfGTeOw1YS7qaps9syhMPvyOu+/Rg/S+zLw7Zv7XHnuJ0E/59FYAm3fs66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N39pBbRzEIAIXqGWQFgKfr0ot0dXGm3viRwTsos5P3k=;
 b=Mkn4RH+HDeI5iAVQDmlHp5y42HhqDXUTY9Zy3mRWBQAFzb/GmLKkxViuCU2iPnx0VWLM1cQPxjkHYN78lrf0pNme2Z1GEtwqBAxT8j8Q/Ofp3qt6TZkGXLInVm8AfxiWPgiD1whA4eRo/rQass583gdhT3OFzijzSxx2X+zHHDyeTNYVUkaZ7uMOpF8/oxgVAIn/EZo5qSdK+JCdhAO9evMiwju3w+H5HRT8p9nm/aEbO2AoaCIIBCjidgMo5ToUIrGdUvjmBUhaFFcd64Soq0zG9ghmdzhv7qHvZkI+Zz5f0o0ADme2xqrpo9Iril5ebkApedFFDgTYwpJWIRabLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N39pBbRzEIAIXqGWQFgKfr0ot0dXGm3viRwTsos5P3k=;
 b=Gj0Q+RYtfLZQXEwScSnQ2GE6LRt+euqm4bb+vXd3Bh8A1gYDypjhtAJMLATLeOlnEK+gQJr/STUkrTqN2icip5u5r0wgl+Sm8tHJwC4NhB3mkmdv84KQrok6bKEwsedMK0kBCo+7KJeH48C7UrW9Gd54jCI184j15ssisZ72EKYfNDm2pWSUskS8+uvuE7L8Whph7g93ImU618mozKgWyTX0jM8UxFNpJdis4Z9xgF0RQJXcw57HRSbEursdp8RJFOrHRBbviupl28hZlo9VAgtJWTSz2isyH8AHuE8idO03lIq34evMcACuty+N8+YWtZUQ+aF5DAEds4wpcoRS9A==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:19 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:19 +0000
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
Subject: [PATCH v10 13/14] dpll: sit9531x: model the inter-PLL sync net as a
 pair of pins
Thread-Topic: [PATCH v10 13/14] dpll: sit9531x: model the inter-PLL sync net
 as a pair of pins
Thread-Index: AQHdSgVc40qUlDeCzkytlQ8xnxUSgQ==
Date: Mon, 21 Sep 2026 20:11:18 +0000
Message-ID: <20260921201108.42676-14-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 703ce26b-d0dc-441b-9236-08df181c7ff8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 wlbyLvQ92lUvOIfbW4CjR03sfH/YWr+ybih1t6h7JoR+YqwIfKyTGvvLNzke4weRbFbLw6zXNkpY5yyf7FGBTGZWsERio86yloQjCVTA+2w/B9FKvxce7HKp9e/jLH86LE4+Z2AuHHtkyHr/BhBOA8pcA7rWNQOCD5AwmlBkRCdujovIUluHhehwrru9qNwnQXUOZtGZr4C+YobZfFl12Yl13AjCX63Jx2GEphiLXeaXm3B5HrPDnhEEgSP9yy2DNub2J+MQMO8sIgQMXsch0uRXxwTDEL23BrEB0PaG8YQOyIWwchRgb6OHm0pRiu9UHvQ9qvP4yyLjAmChpRTYLONStd635dRGK6c0NOiH6KOwo+xuPt/vXVNA4a+06L5MzoPk2sTq1VvC8jnGjXFFKQE23ZPSupgGL9Bznbv+d9PFIjsBGub7XUaTvttlh90MESifo/x1t6KpVnexVrAAw6pLuk+h71RFp5/1nER3nrur/75FetuacC4j2UojicKBCCREI2o6Yf9cROe6KPqTs3aaDgxPONjtgNd6eS6TocmkTcik+rrM3N5DCmdcpBMcd5gIElI0eTYt+mjPAGH3PX8mr3ei8AsPpyDRYWjBG7n5vEZxJpUT1nTipJBmcn4zXBNP/eX9fwnzZiTW8aPtOuL4dKk3oHaZtgGWqhzL2cPaFbxQXLkmhmJCh63bcpi6AGHg4/K2ANYDEJ/JK0PGSrleoAtk/mOLu58kqGTKNUY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RuMqbavA5XsVPfLCTRt/MLRcmMWdJnRhvUqGK1G70ZW1yjGA/MpDeEkWv5?=
 =?iso-8859-1?Q?je65Y2WWdS/4FspDoRvT4Ygw3neH1d9bMeQCqL7W0i1YA5aaQ4B5RYKWGh?=
 =?iso-8859-1?Q?RUYDHVdCMp7864qS20CJ3BLPVUY4b7bDkxJcrsz2eEL49jRr2TB7LCGxum?=
 =?iso-8859-1?Q?l/79/9L+ho8WCn56mRWPChmbSyI9xNZPtYd2eS1M+VYmMtGEoX7UFTD3te?=
 =?iso-8859-1?Q?IlhaaZ0CFdscao7YeF3rCSbX2yEloscDxkHefUTppHo1VIfliridwSpThE?=
 =?iso-8859-1?Q?TJO67Ej/Ut3Mh3A12TKn7P7z7FXJ3AZzt3tszwInADnI5crHvUYLnCJaTL?=
 =?iso-8859-1?Q?N6NUIzeVwqI3ARo9KFpuSusoRUpRAaasYlbcFCceD7owK8H6pBNLK3IZEA?=
 =?iso-8859-1?Q?X3bBFL2ZfzX14quqyaH6KS1zL8WGpGvMDf2dj3b9ZzNj0MUlfKDN6JlPRP?=
 =?iso-8859-1?Q?7EQhT+eOZ7lAjT3HFNRgb+2CNhOgKU3oEpxJ+ql5+oMLaklGDEvmHF+/Mz?=
 =?iso-8859-1?Q?MvsSSU0EbO3lwf4IMSvwgtNr7ZI6Pr2iqaYDvcEKuwSOZadBtmvQ4k2Tug?=
 =?iso-8859-1?Q?XsE2MJ7H4QeTv88y13vYag8dgZwP6usCtBzuMGGHC84JBadRHEEPk5tiYQ?=
 =?iso-8859-1?Q?HkZbIJBf+5DPWBCIn02Ss0cI++4h3Z8RCk8U50VILNdYOaoicXpAmprj9D?=
 =?iso-8859-1?Q?OxUHy6UwlX/z4JqCuor0hOro/Nwj6zqIiQEKy5xA1dGHeJxeb4u4CCy1T2?=
 =?iso-8859-1?Q?yuQRdGSdXyJ2EUtEqix9zIQc1Sxiw6z1KCWiP/KLgVCYz080bps7n29xG2?=
 =?iso-8859-1?Q?MmIUkvUb93Dxj1xCcA9y/uDzKjKm2CQgsifzzFMcebO0dYAvW4byZ9hcAX?=
 =?iso-8859-1?Q?ac5GLC4TpejQl5Lh2KfEXTX9bAhEmjXaTmvn2IANobiq3xbv/qxjPesLyR?=
 =?iso-8859-1?Q?6USJA+opis0pxcp0wmqMDwdxvYZr7QP3HvGQvfh/I1EYJkMhF4ktDJQ4oj?=
 =?iso-8859-1?Q?x1cSZo7a0/FmvBeTG8m358vj6o46e01SAo2DmyryqkcKwN0YdIwEHhlqe+?=
 =?iso-8859-1?Q?9rxePa7KxzRHySYHuwSD1ZsQMY+Gm5jt/kTiLexB7KnWKONEOI6cIqZh1S?=
 =?iso-8859-1?Q?IvGAfzqYwPFeIK7elfzJzGc85XfWZJmOE+0zeIja+qLko9y4zQC9szIU/n?=
 =?iso-8859-1?Q?hDKgON2av1FNg5Pa8kHhLhbCak31rQxckYfzBRDjOuCGczUwXhhtroi/yr?=
 =?iso-8859-1?Q?w+IXWlg6S0A/dfbV+2IW1qwePGlOtcjVvcfS7L8vzYBFQg0RAeVveYmDcT?=
 =?iso-8859-1?Q?il4zSLWvP/cEJUXfBwFSicKF9OQHaZ3vh98D0TpTvJK7k6Bj0JX9tawx/l?=
 =?iso-8859-1?Q?i8NpiScFEUDEy/tykm4I8z6XcuQl3pUGTJoift2pW9JqZpT3avgBZaboC+?=
 =?iso-8859-1?Q?Vf/WaMW1eUNv5NDUfjTDl91RxAZtofxEqH7mdYeTmCB5GQKfuNhJICXC/K?=
 =?iso-8859-1?Q?A1g45odjd176KsEZP/CznAQ6cd2sscZSOofZ9hunJpOfvW9FMf+y4supO1?=
 =?iso-8859-1?Q?34uCZsZ6Ty1Bq3JHnI9y2PMMMr+pu2xxo3eaQLe/faR3MIkH047Y198ihx?=
 =?iso-8859-1?Q?WxzeoUIDPWmmpuXJxUJTO6q7n50UNZbjI/VuDavzNV9RbJOPQcWFSW0exQ?=
 =?iso-8859-1?Q?HZkB5RwPfZUe3f5Qix3ZL9UUvknNFJDVJz9KQz0e28PmS+DiO4qFzS7r9I?=
 =?iso-8859-1?Q?DHkoaRDFo+YdT1E1o1Q6U9PGc7wkuis8/SqdoqypqO/iTt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Q7cu9pxW6EFQynO/ZhLHGFLtWAsVX5ot+sq2q6b+rVbh70tlfyWrGloyJqiMwzskAyiQ7nFIxyQyUAZElNR9/xVUyw+HMIo4dLsuo+1FvBBMshstuioxEiVPS58sMxBlBjwqtLK0Ngt9GKdmhhar7MaVynOBhoR5GtoF0RS5tA69VXYb0KdkHDn/MuLnFOR9H26rvVckoRH+lXHyvpwbg/y/pSlagoW0IpLwA6cZ4Wp00KrSpcUfE/7tSwg2kprGJ7E5LSV1h5zBNH7QT3OGRW1uEjrLZNvA9yFa6Jt1CEnFp2XA2FRRfb/uL0UswZTBF0cbkHR6lCifJrZ8AM0G3A==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703ce26b-d0dc-441b-9236-08df181c7ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:18.5374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZvuVP+c0vnHl8+nwcQsI89uuqfQyiMSadX/0FsN6nFCdqoWFYpyUanmuBPtb3Wrp1i/5RBpVS+Ouwy6/WlVDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021481-YoUtPG6g5vIw
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021481;YoUtPG6g5vIw;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
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
=0A=
Notes:=0A=
    Changes in v10:=0A=
    INTSYNC ownership: recorded before the read-back that can fail, and a=
=0A=
    disable that fails part way leaves the state describable so the request=
=0A=
    can be repeated.=0A=
    =0A=
    Error reporting: a full priority table says so instead of reading like =
a=0A=
    bus failure.=0A=
=0A=
 drivers/dpll/sit9531x/core.c | 291 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   3 +=0A=
 drivers/dpll/sit9531x/dpll.c | 247 ++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/regs.h |   3 +=0A=
 4 files changed, 538 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 1cb691f04019..e8d47999f1a9 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -2264,9 +2264,9 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sit=
dev, u8 out_idx,=0A=
  * block at base =3D 0x15 + 16 * (slot % 6); the slot is the physical=0A=
  * output position from clkout_map[], not the logical output index.=0A=
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
@@ -2531,6 +2531,278 @@ int sit9531x_clear_notifications(struct sit9531x_de=
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
+ * Close the debug window on a PLL's EXT page.  The key register opens=0A=
+ * every debug register on that page while it holds the unlock value.=0A=
+ */=0A=
+static int sit9531x_intsync_debug_lock(struct sit9531x_dev *sitdev, u8 ext=
_page)=0A=
+{=0A=
+	return sit9531x_write_u8(sitdev,=0A=
+				 SIT9531X_REG(ext_page, SIT9531X_PLL_REG_DEBUG),=0A=
+				 SIT9531X_PLL_DEBUG_LOCK);=0A=
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
+	int rc, lock_rc, i;=0A=
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
+		goto relock_err;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev,=0A=
+			       SIT9531X_REG(ext_page,=0A=
+					    SIT9531X_PLL_REG_DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].en_val);=0A=
+		if (rc)=0A=
+			goto relock_err;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, src_pll_idx,=0A=
+				   SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				   SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
+	rc =3D 0;=0A=
+	goto relock;=0A=
+=0A=
+relock_err:=0A=
+	sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	goto err_disable;=0A=
+=0A=
+relock:=0A=
+	/*=0A=
+	 * Close the EXT page debug window the sequence opened.  Nothing=0A=
+	 * else writes the key back, so leaving it open would keep the block=0A=
+	 * unlocked for as long as the device runs.=0A=
+	 */=0A=
+	lock_rc =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	if (lock_rc && !rc)=0A=
+		rc =3D lock_rc;=0A=
+=0A=
+	return rc;=0A=
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
+	int rc, lock_rc, i;=0A=
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
+	rc =3D sit9531x_write_u8(sitdev,=0A=
+			       SIT9531X_REG(ext_page,=0A=
+					    SIT9531X_PLL_REG_DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].dis_val);=0A=
+		if (rc)=0A=
+			goto restore_global;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, src_pll_idx,=0A=
+				   SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				   SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	rc =3D 0;=0A=
+=0A=
+restore_global:=0A=
+	/*=0A=
+	 * The global enable was cleared first, so a failure here leaves the=0A=
+	 * EXT page still holding the enable pattern with nothing pointing=0A=
+	 * at it: the source detector keys on the global bit, would report=0A=
+	 * the net as unowned, and a retry of the disable would then=0A=
+	 * short-circuit.  Put the bit back so the state stays one the=0A=
+	 * driver can describe and the request can be repeated.=0A=
+	 */=0A=
+	if (!sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val))=0A=
+		sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+				  val | BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+=0A=
+relock:=0A=
+	/* Close the EXT page debug window the sequence opened. */=0A=
+	lock_rc =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	if (lock_rc && !rc)=0A=
+		rc =3D lock_rc;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /**=0A=
  * sit9531x_chan_selected_ref_read - read a PLL's active reference now=0A=
  * @sitdev:	device pointer=0A=
@@ -3109,6 +3381,15 @@ static int sit9531x_dev_state_fetch(struct sit9531x_=
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
 		s32 phase_ps;=0A=
 =0A=
@@ -3664,13 +3945,13 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
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
index 1d77b89e83ec..1fc14eabb621 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -287,6 +287,9 @@ int sit9531x_output_phase_adjust_set(struct sit9531x_de=
v *sitdev,=0A=
 int sit9531x_clear_notifications(struct sit9531x_dev *sitdev);=0A=
 =0A=
 /* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev);=0A=
 =0A=
 /* ---- Phase offset (TDC readback) ---- */=0A=
 int sit9531x_pll_ffo_ppt(struct sit9531x_dev *sitdev, u8 pll_idx, s64 *ffo=
);=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index fcdd19e0bd3b..856c9bdf33d4 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -27,6 +27,20 @@ static bool sit9531x_dpll_is_input_pin(const struct sit9=
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
@@ -843,8 +857,234 @@ sit9531x_dpll_output_pin_direction_get(const struct d=
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
+	u8 hw_src;=0A=
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
+		hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);=0A=
+		if (sit9531x_input_prio_present(sitdev, sitdpll->id, hw_src)) {=0A=
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
+	/*=0A=
+	 * Record what was asked for before confirming it.  The refresh below=0A=
+	 * leaves the cache untouched when a read fails, and a cache that=0A=
+	 * still says nobody drives the net would let a second PLL be=0A=
+	 * configured to drive it as well.=0A=
+	 */=0A=
+	if (!rc && state =3D=3D DPLL_PIN_STATE_CONNECTED)=0A=
+		sitdev->intsync_src =3D sitdpll->id;=0A=
+	else if (!rc && state =3D=3D DPLL_PIN_STATE_DISCONNECTED)=0A=
+		sitdev->intsync_src =3D -1;=0A=
+=0A=
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
+	if (rc =3D=3D -ENOSPC)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Priority table is full of unique sources on this PLL");=0A=
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
@@ -1126,8 +1366,13 @@ static const struct dpll_pin_ops sit9531x_dpll_outpu=
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
index 4a928126473d..09a2032f7bf0 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -315,6 +315,9 @@=0A=
 #define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
 #define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
 =0A=
+/* PLL EXT page INTSYNC configuration registers */=0A=
+#define SIT9531X_PLL_EXT_PAGE(_idx)	(SIT9531X_PAGE_PLLA_EXT + (_idx))=0A=
+=0A=
 #define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)=0A=
 =0A=
 /*=0A=
-- =0A=
2.43.0=0A=
=0A=
