Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C7C4B8274;
	Wed, 30 Sep 2026 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811455; cv=fail; b=krS+H2JTHS/V3v5L0oAFYrlEdxkQ8XhQRrAtbTx9jlfItFZp/qy2L73najVv1iAfpXr/T0Hdu8oujN/D4IhoAigpLzIPx3h+2dknM6ssV+OSpaRdkenD/Xm+eDkXQrNpK+cOgiVZQlS7k27gYX32bDjEPb8ESDcGtlsLcZhxTfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811455; c=relaxed/simple;
	bh=JmEUgUa7+w1d+COoMghZwIs6aukl0PAgstoCfJqHg8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sJwpBEBYrHRT4TICqyVKwZRARrZXRUf7vOYdBpxWmyVI8ObkZ9BfUksnuKBSwAe/ey9AJCPTpJ/gQtVl1G5MbkbXGJ7GMm9MCx6U8Ua+XivRRO4AnfO9wgk78U3viV0Pzbn33XoTPE9aAvGWjynAMna0VJ3W0EG85Eg33lbj3E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=oyzhgBFI; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=qw9stDjw; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="oyzhgBFI";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="qw9stDjw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=khYolEA/gK34s6fhNSeTuRY77fPcT+7Xut+FQriZ77I=;
 b=oyzhgBFIQ4TvM1WRJuf83X6YjjFClfWhTcxYP6e78FU6GZGfRTl9OYeESZheJPpMb0odGZ9JWXGkTZZPOlHsJ3l+9nX30GiYmpsMYHLfWmLuIC5H9xEurzkK30F10rmBpeEZGi4MMu3+R+muVOmaRGgvntIw6uvJcWYkW05xedNwUpK/h/fzM/XWt+XAQdT1AiOL6OW3TyzVyjc3/BVxj/o+AepBPcqbkKQjm/wiiR3TRO2jNLuUv0LaYTLGIfcXwpIJCauxOiDA4SFRtbqEmeHhkFXkxaGGrt0SdOhOq+zm0QjWyVknetnjnXVTvNU76diOGREssNmNx0W7kgKKrA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020097.outbound.protection.outlook.com [52.101.61.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7791E10006F;
	Wed, 30 Sep 2026 23:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8jhPRrRAdnNX2dZBot1KwkyRr9XwtBkGnrIoOludHqN4CDISMuyaCFwM8fgy/h9szSY0QWCZc53Ca8JbFiift2iLw5ebDD0c4Kx8sgDVo/AQz9I4L2llCZekEqM3endpSHjduG0K3kyX9V4ZawXM3IpEvkIQarXJ4zuJP5uVh7XYfMvVuenaOgkcsCodyQyxY7coN6XeEQzq37vBy+eNIepfpc5Y+a+PtxVGHftzmyfF+/6i8NFMT3snTGnaAnO9BnDxxADxTeXPExhYLu9OppMxokFyt1UTBSD4pO8RzSJZgZmph82Gmy6stF22s5X4gJZ0AeQc4rFa/X/9+pBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khYolEA/gK34s6fhNSeTuRY77fPcT+7Xut+FQriZ77I=;
 b=o3vWBJuFmoZpdPsarxnGdMrv9lwpehk3bOTcxYTPMaPTV3lGVI/Ov1rnurixDq21sxiWB6RtXFu64wRTri/zIhDIsVPeoNCAHxkyYcBA1SQHi19myHpHKk23rc4BuMcT3qSwaXVcOgtJ9bCuUk9OP0jcwnatheqgkKv97Ta2CIumLPWxK9fXON7jhzjf75mIm4ZkRmQDcUDuArvPFs5Ii5OkFSRZE4AhA5i3haZg3U2lM04corHD/pZGfVyl+mJBURGmVFSbWZh3JzAAHDgrDzVhIuBm2s58AxHu+vcH8J6kPnuEjGylg+slk56eIaLIrWOAu+uLcU3lEBHlMSwUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khYolEA/gK34s6fhNSeTuRY77fPcT+7Xut+FQriZ77I=;
 b=qw9stDjwdTM2SlR7lq4uubXfI4LN6eWdmjxj3DS8ptqh37P66fbIfgPMBnvNT92vxplFjkWCBNRXFlxWxKUMUK33TUXyIWCKoNdC1iyQjxpjurZjx0/Ui7L4X/YlYHb1nuItfcYZ3voa9E57VWg10ZnteeHVka93hGSd0Nz0a+5NX9Bd7XZ/gnYVqesXoZBv++v5lrpS6YNLbOnZWvaeHjIe/JcHEmTWv2rSa1e/N30tkOGMNInLZJ4w83/oKDR9icfSH2dddh5rLKLXdfhKdJBCkvILlrfGlpBdytf8V7ZNXNcIoztXrLIqtruseo91a/uzBpF7JQ035Z5CzXMKUQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB5383.namprd20.prod.outlook.com
 (2603:10b6:806:29e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 23:37:22 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:22 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v11 09/13] dpll: sit9531x: add support to get and set
 frequency on pins
Thread-Topic: [PATCH net-next v11 09/13] dpll: sit9531x: add support to get
 and set frequency on pins
Thread-Index: AQHdUTSjc8zzrYEC90eRgotTdLpzYQ==
Date: Wed, 30 Sep 2026 23:37:22 +0000
Message-ID: <20260930233714.87679-10-arouhi@sitime.com>
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB5383:EE_
x-ms-office365-filtering-correlation-id: a741a530-ef06-4962-1fd3-08df1f4bc674
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|3023799007|10067099003|260925021311599003|260925022911599003|5023799004|260925021911599003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Uhvsg9/NftIrWZ1QZqSYTJHM33vBCqrMJR7dm46p9X0rmLmrQHJwjRDyVvCqapnMR8r68gAtCjPpBRCbBIMQH3bmrmsK0KOXNN/HuLDvEjK9oTvU4dOMlmLxWGW9aVyLXUBWqWwH40An9bWZmlB4amVvLrDQVTtcBsgQO05WW7d59KPew9cs2jmQjV8K8bBudkYw7X7qqPx9rgtXJApmyeO2+kFUxP7PjBDbih0VpPLcLq4CEJY8Z9lfntPCFUlaRKchF7s8WbzlTvNd5nWkGZ2vAkgtz1HXBw1hoDNXc2IZNswRDRO3jvlOPgJNL3DVSV3hMYExZKJ+GBF0DzyzIf6Qvr8hFRdo2cTG6cQfPMmsmlr2oLAihkl+xBDXXJtZlrv8pBityuBDO6fFwOG/XRBRoMgrTI3U+ntGOhRFLdGbpwhch4Jr2F/UX9MwjzHVpg7uD+JfxMeS1sI+WCRD2zbuZQMxmzkVjYwDs/SpukAh4MrusukmDI0LMgwJc781EtWFgum4oerdARi/xmeV+syClWYuAwZQO/uHb6wRKM+LTjPVgin9N5thmCjswwWBedb+hx0MjDhIchi813fNAvZF6R3666VF51TVsrWVx63Y27itm626sLFPY6pLGTmQANh9r/4FpvY711JXUUE3iVNribTJWkr7S49YDRZv53eYUqjD6XhlV10h09nJyu/Up3OF8DYkP6grPj3Fern5BBKQqK0OQ3YHhO//IYcAH7U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(3023799007)(10067099003)(260925021311599003)(260925022911599003)(5023799004)(260925021911599003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZuKORaoJs0EIntMzQ67CrjPSaxFAlk7AGgsxrPjT3OtmyELlhEGkH7w5Xc?=
 =?iso-8859-1?Q?Gu0N0CNOTsPmkUQ4yZpszrlk1I2Z5xw0RThwG8ddMaizMGlPY5HDcKwHgx?=
 =?iso-8859-1?Q?XV9WSj1hnJHN9qwtSfhT50Z3l/lG30yoTiepIA76n/hurvH/kAYFSQQlP+?=
 =?iso-8859-1?Q?89b152UQkiYWoCJf2KpNuB3SUsCtXzbd2qKqoCo3SQgawf7PdP2xsiR3Gl?=
 =?iso-8859-1?Q?tG5D2n3AS+26/jQQDaAP2jp4+FFnkmPs27UQeOdBqppLprlAg6DrmUFT1d?=
 =?iso-8859-1?Q?sNWu8wx2ocYkGsyAPKNrtiaR942CCdKEUtGV8iYJtOINh/kRE5DxTcSU2n?=
 =?iso-8859-1?Q?8zXQx4Q81SxAtDMXhXY6nh7PPl+k3v2Pd9Ko84UG++dYZxgo9p5H7Zbgq8?=
 =?iso-8859-1?Q?nBjLXGowPM/O79z6SqGe3NmlQa/Xr96Xhs+FflK7RWzo8h8L/sOoHKD/E+?=
 =?iso-8859-1?Q?20z+2RmbtKiyW5nj286gF6DdxSpU+O4sgTUfsqFhVRNzh7Rh3byE+arV42?=
 =?iso-8859-1?Q?TaBnIef+ppINihjhFPiCPKv5nRTS/Bax2U8Ke9OWpaimeZW4bMKBVvVfAe?=
 =?iso-8859-1?Q?ZJQQFL70EHn45J03jkAmRAnn7WxMQHE7mBOoEGxU59h2KesjePPyNqm/zz?=
 =?iso-8859-1?Q?Um2AaOzlpVAr/9JwCpg4puJb1+kxalO4fAx9KgGxu5ipF2ZQ/vwew76EhD?=
 =?iso-8859-1?Q?dZaG5JRAWFL7g+v2iW4J+YggmHX80cHlU1zI5hq+QhdRMVPJ40WgZDJ1Yj?=
 =?iso-8859-1?Q?bX/mAyVDSwnMw27ngRbSyKD1+iqkoo8alb4kDblDXSREsEUwp33IgqrvPD?=
 =?iso-8859-1?Q?ue0IQFS+cRCsgx7IC/F09R85O3ahX6vPjhHrMLNfOfqA5ghbOaULm6VlFv?=
 =?iso-8859-1?Q?EleDcxiOcFoobe4cPwF03ozdBXWu/rMvIqkmpuW6DFvYv2XmByJOWdJ1Ft?=
 =?iso-8859-1?Q?uBgtaIDhv7MnSGmulty4/bM5hXc8ZG8A+th0SuyxLNG7Y37eGQ9MMNKWg0?=
 =?iso-8859-1?Q?4oX5Kh6fy9Kyyjmw0SH4M+J2NKVsjW/UmGUUCfr3bMMSN1hSy0niSxly92?=
 =?iso-8859-1?Q?TimmpC3lctw4FKoCjoQjfkHsG2MkK7QiPCkKyHBcgIC9ZfWZBkdgRBKS8P?=
 =?iso-8859-1?Q?xu2ti9RQBCu+lMknDWkxyGn3n++N2AwqpPU9BALyG7OBlPBD1N+6q4Irxp?=
 =?iso-8859-1?Q?AEQ3ugQK1QOtmCYp2suf9YN57OmCor3/dxufbzC1G5E9l6azptgajVgGYd?=
 =?iso-8859-1?Q?uyQ9fzYusZ1Fi9WQ1WYMukwqzl1E7PP6/fMF2LhqXtRu7l9bmeKjF28xDg?=
 =?iso-8859-1?Q?FxxTxFJcwxontX2bbTnsGm1JMICdD/rL2yN+fz/WGgPql3txnsFaUfGXKB?=
 =?iso-8859-1?Q?Lhc/ZWSGMIUEazvopzV9vrUzGNXYdGbs0aUrlx4u6HcUw7HEiOZM/TO2FN?=
 =?iso-8859-1?Q?5l6G40MztFvGISvMkrNBeGMERK4JUBwPGO6f7H6pA8Dr8T2+/VKFNY/DHW?=
 =?iso-8859-1?Q?yXJM2EI81dO7YDsb2iydacQUF01IGxmiB4771ujlx6XltqquiGa+eS4bYi?=
 =?iso-8859-1?Q?UyXA74BEvYIP3VyV5SEoPGmuAyuB6c27JrDCyOOs2kyqonPQd+qol3kCxF?=
 =?iso-8859-1?Q?WiX75epJRSjbln+pNYutKh3yEq+vIBJAHLVAz4I0DMNRq8BMZWepX85gW/?=
 =?iso-8859-1?Q?ZBztmnxrplKBhLwKYnn4Xd7eRL6SLLtLQnyCAlZKNL/ILqWA11ct94WNcv?=
 =?iso-8859-1?Q?cLLp861aDlAmq/OnqVOC+Uz4dUMwrM17Jco64bwh0LUBlw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	0OpZxk25EdbtFISfmixnvqFRpJRxDZLAGa+Y89yP52XpmIx9cd+leWOCTeRNqgJe1SFjrRY8ynktfUq6A0hf/lXyM5d1Ey3JfGfteRRF1zNhPDlm/zn9k+D/NI4ziNlI5mHRhSpyyiRDhSZyDeLY0/mZ52KenakSsT5N9bDrgQJdbec+twJ4VAZlWgH97YAmGZFop7FeTKFdbjFIqBrVLxif4OvU8kq8soFvMLDhv8gzJAVg2xW0qNLlEiXlXzucF1Pm8GFrbRIvQkrfWJ0iP9Hgmagpv6JE7aIPa89+FYetX7RK8UcAME8NH0ckh9BFhqLwO1atoorIumZvhXW8Jg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a741a530-ef06-4962-1fd3-08df1f4bc674
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:22.1869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtiS3/Q0AYwfZkxSEoW6crdBS41B0TTRYgd1yWZd7LGGUdYm0nTa8gSnEjcnZT7MD4mP3GvF9JZ/ddZzipPWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5383
X-MDID: 1790811449-zV_tQXBIsVkg
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811449;zV_tQXBIsVkg;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Both directions in one patch, since they share everything that matters.=0A=
=0A=
An input's frequency is what the board presents, so it is reported from=0A=
the firmware description rather than read back: the chip has no divider on=
=0A=
an input whose rate it merely qualifies.=0A=
=0A=
An output's frequency is the VCO divided by that output's divider, so it=0A=
is computed from the divider read back from the chip and set by writing a=
=0A=
new one.  The VCO in turn comes from the feedback divider, which is why=0A=
the crystal rate is needed at probe.  A divider write only takes effect=0A=
inside the programming state, and that state has to be left with the=0A=
output loops re-locked whatever happened in between, so the exit runs even=
=0A=
when a write in the middle failed and the first error is the one returned.=
=0A=
=0A=
Programming a divider costs about a hundred milliseconds under the device=
=0A=
lock: a dozen or so register transactions, then the settling time the part=
=0A=
requires after the loop-lock command, which is a property of the hardware=
=0A=
rather than a conservative guess.  The DPLL core holds its own lock across=
=0A=
the whole callback, so a frequency set on this device delays netlink=0A=
traffic for every DPLL in the system for that long.  Splitting the wait=0A=
out would need the ops to complete asynchronously, which the interface=0A=
does not offer; issuing the commit without waiting would let the next=0A=
request program a part that has not settled.  A rate change is a=0A=
configuration action, not something a running system does per packet, so=0A=
the cost is paid where it is visible rather than hidden behind a=0A=
completion the caller cannot wait for.=0A=
=0A=
The phase flush that follows a divider write realigns every output fed by=
=0A=
that PLL, not only the one that changed.  The flush is a per-PLL function=
=0A=
in the device and there is no per-output equivalent, so an output whose=0A=
rate is set while its siblings are running will step their phase too.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 778 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h |   4 +=0A=
 drivers/dpll/sit9531x/dpll.c |  95 +++++=0A=
 drivers/dpll/sit9531x/prop.c |  28 +-=0A=
 drivers/dpll/sit9531x/regs.h |  21 +=0A=
 5 files changed, 922 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index f6c76cc78456..3254d119b939 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -488,6 +488,139 @@ static int sit9531x_output_forced_hiz(struct sit9531x=
_dev *sitdev,=0A=
 					muted);=0A=
 }=0A=
 =0A=
+/* Attempts to re-lock the output loops before reporting them open. */=0A=
+#define SIT9531X_LOOP_LOCK_TRIES	3=0A=
+=0A=
+/*=0A=
+ * sit9531x_prg_abort - leave the programming state without committing=0A=
+ *=0A=
+ * Entering the state is two writes, and the second can fail with the debu=
g=0A=
+ * block already unlocked and the part possibly already in PRG_CMD.  There=
=0A=
+ * is nothing to commit in that case, but the loops still have to be close=
d=0A=
+ * and the debug key put back, which is otherwise only done by=0A=
+ * sit9531x_prg_commit().=0A=
+ */=0A=
+static void sit9531x_prg_abort(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 attempt;=0A=
+	int rc =3D -EIO;=0A=
+=0A=
+	for (attempt =3D 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+				       SIT9531X_LOOP_LOCK);=0A=
+		if (!rc)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (rc)=0A=
+		dev_err(sitdev->dev,=0A=
+			"output loops left unlocked after a failed entry: %d\n",=0A=
+			rc);=0A=
+=0A=
+	sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			  SIT9531X_DEBUG_LOCK_VAL);=0A=
+}=0A=
+=0A=
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
+		 * loops open.  Callers skip the commit when the entry=0A=
+		 * fails, so close both here.=0A=
+		 */=0A=
+		sit9531x_prg_abort(sitdev);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Commit a programming sequence started by sit9531x_prg_enter():=0A=
+ * update the NVM shadow and re-lock the loops.  The sleep gives the=0A=
+ * hardware its required settling time after the loop-lock command;=0A=
+ * it is intentional despite the caller holding multiop_lock, as the=0A=
+ * whole NVM + lock sequence must be atomic.=0A=
+ */=0A=
+static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc, rc2 =3D 0, rc3;=0A=
+	u8 attempt;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_UPDATE_NVM);=0A=
+=0A=
+	/*=0A=
+	 * Issue the loop lock even if the update failed: every caller=0A=
+	 * commits whatever happened after the entry so that the chip never=0A=
+	 * stays in the PRG_CMD state with its loops open, and returning=0A=
+	 * early here would defeat that.=0A=
+	 *=0A=
+	 * Re-lock the loops.  Leaving them open is worse than any other=0A=
+	 * failure this function can report, and nothing else closes them,=0A=
+	 * so retry as the priority table does with its own latch.=0A=
+	 */=0A=
+	for (attempt =3D 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {=0A=
+		rc2 =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+					SIT9531X_LOOP_LOCK);=0A=
+		if (!rc2)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (rc2)=0A=
+		dev_err(sitdev->dev,=0A=
+			"output loops left unlocked after programming: %d\n",=0A=
+			rc2);=0A=
+=0A=
+	msleep(100);=0A=
+=0A=
+	/*=0A=
+	 * Put the output-system debug block back the way the device powers=0A=
+	 * up.  Its key register unlocks every debug register while it holds=0A=
+	 * the unlock value, and each programming sequence writes that value=0A=
+	 * itself, so nothing needs it left unlocked in between.=0A=
+	 */=0A=
+	rc3 =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+				SIT9531X_DEBUG_LOCK_VAL);=0A=
+=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (rc2)=0A=
+		return rc2;=0A=
+=0A=
+	/*=0A=
+	 * The programming is committed and the loops are locked by now;=0A=
+	 * only the debug key stayed open, and the next sequence writes it=0A=
+	 * again.  Failing here would make the caller skip what follows a=0A=
+	 * change that did take effect -- and the core drops an identical=0A=
+	 * retry, so it would never run.=0A=
+	 */=0A=
+	if (rc3)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "output debug block left unlocked after programming: %d\n",=0A=
+			 rc3);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input priority selection=0A=
  *=0A=
@@ -1252,6 +1385,11 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sit=
dev, u8 pll_idx,=0A=
 					 chan->prio_mask | BIT(input_idx));=0A=
 }=0A=
 =0A=
+/* Per-slot DIVO base register offsets (6 slots per page) */=0A=
+static const u8 clkout_odr_divn_base[] =3D {=0A=
+	0x14, 0x24, 0x34, 0x44, 0x54, 0x64=0A=
+};=0A=
+=0A=
 /* XO doubler register */=0A=
 #define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
 #define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
@@ -1265,6 +1403,646 @@ int sit9531x_input_prio_add(struct sit9531x_dev *si=
tdev, u8 pll_idx,=0A=
 /* The output divider is a 34-bit field */=0A=
 #define SIT9531X_DIVO_MAX			GENMASK_ULL(33, 0)=0A=
 =0A=
+/*=0A=
+ * sit9531x_is_xo_doubler_enabled - check if Fref doubler is active=0A=
+ *=0A=
+ * Register 0x2D bit 7 is active-low: 0 =3D doubler enabled, 1 =3D disable=
d.=0A=
+ *=0A=
+ * Return: 1 if enabled, 0 if disabled, <0 on error=0A=
+ */=0A=
+static int sit9531x_is_xo_doubler_enabled(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 val;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_XO2_GENERIC, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return (~val >> SIT9531X_XO_DOUBLER_ENB_BIT) & 1u;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * DIVN as a fixed-point value: int_part plus fracn/fracd, carried with=0A=
+ * SIT9531X_DIVN_SCALE steps per unit.  The scale keeps a whole DIVN=0A=
+ * well inside s64 while resolving far below the parts-per-trillion the=0A=
+ * frequency offset is reported in.=0A=
+ */=0A=
+static s64 sit9531x_divn_fixed(u32 int_part, s64 fracn, u64 fracd)=0A=
+{=0A=
+	s64 whole =3D (s64)int_part * SIT9531X_DIVN_SCALE;=0A=
+	u64 frac;=0A=
+=0A=
+	if (!fracd)=0A=
+		return whole;=0A=
+=0A=
+	frac =3D mul_u64_u64_div_u64(abs(fracn), SIT9531X_DIVN_SCALE, fracd);=0A=
+=0A=
+	return fracn < 0 ? whole - (s64)frac : whole + (s64)frac;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_divn_static - read the configured DIVN of a PLL=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @divn:	result, fixed point as per sit9531x_divn_fixed()=0A=
+ *=0A=
+ * Reads PLL page regs 0x30 (integer part), 0x32-0x35 (numerator) and=0A=
+ * 0x38-0x3B (denominator).  The numerator is a two's complement 32-bit=0A=
+ * value, so DIVN can sit below the integer part, and the denominator=0A=
+ * register holds the divisor minus one.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+static int sit9531x_divn_static(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				s64 *divn)=0A=
+{=0A=
+	u32 int_part, fracn_raw =3D 0, fracd_raw =3D 0;=0A=
+	u64 fracd;=0A=
+	s64 fracn;=0A=
+	int rc, i;=0A=
+	u8 v;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DIVN_INT, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	int_part =3D v;=0A=
+=0A=
+	for (i =3D 3; i >=3D 0; i--) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DIVN_NUM + i, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		fracn_raw =3D (fracn_raw << 8) | v;=0A=
+	}=0A=
+=0A=
+	for (i =3D 3; i >=3D 0; i--) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DIVN_DEN + i, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		fracd_raw =3D (fracd_raw << 8) | v;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * NUM/DEN is the fractional part of DIVN, so |NUM| is below DEN by=0A=
+	 * construction.  A pair that says otherwise did not come from a=0A=
+	 * programmed divider, and handing it on would divide by a=0A=
+	 * denominator small enough for the quotient to leave u64 -- which=0A=
+	 * is a divide-error exception on x86, not a value a caller could=0A=
+	 * reject.=0A=
+	 */=0A=
+	fracn =3D (s32)fracn_raw;=0A=
+	fracd =3D (u64)fracd_raw + 1;=0A=
+	if ((u64)abs(fracn) >=3D fracd)=0A=
+		return -ENODATA;=0A=
+=0A=
+	*divn =3D sit9531x_divn_fixed(int_part, fracn, fracd);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers=0A=
+ *=0A=
+ * Fvco =3D Fref * DIVN, where DIVN comes from sit9531x_divn_static() and=
=0A=
+ * Fref =3D xtal_freq << doubler.  DIVN is the steady-state Fvco/Fref=0A=
+ * target programmed by the NVM blob and is authoritative in both=0A=
+ * free-run and sync modes.=0A=
+ *=0A=
+ * Return: 0 with *fvco set on success, -ENODATA when DIVN is not=0A=
+ * programmed (dormant PLL), or the register access error.  A bus=0A=
+ * failure is never folded into the -ENODATA case, so callers can fail=0A=
+ * a request instead of acting on a guessed rate.=0A=
+ */=0A=
+static int sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			     u64 *fvco)=0A=
+{=0A=
+	u64 fref, fvco_min, fvco_max;=0A=
+	int doubler, rc;=0A=
+	s64 divn;=0A=
+=0A=
+	if (pll_idx =3D=3D 1 || pll_idx =3D=3D 3) {=0A=
+		/* PLLB, PLLD: high band */=0A=
+		fvco_min =3D SIT9531X_FVCO_HIGHBAND_MIN;=0A=
+		fvco_max =3D SIT9531X_FVCO_HIGHBAND_MAX;=0A=
+	} else {=0A=
+		/* PLLA, PLLC: low band */=0A=
+		fvco_min =3D SIT9531X_FVCO_LOWBAND_MIN;=0A=
+		fvco_max =3D SIT9531X_FVCO_LOWBAND_MAX;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_divn_static(sitdev, pll_idx, &divn);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (divn <=3D 0)=0A=
+		return -ENODATA;=0A=
+=0A=
+	doubler =3D sit9531x_is_xo_doubler_enabled(sitdev);=0A=
+	if (doubler < 0)=0A=
+		return doubler;=0A=
+=0A=
+	fref =3D (u64)sitdev->xtal_freq << doubler;=0A=
+=0A=
+	/*=0A=
+	 * Round to the nearest hertz: DIVN is carried in fixed point, so a=0A=
+	 * fraction such as 1/6 is already floored once, and flooring the=0A=
+	 * product again reads an exact 5 GHz VCO as 4999999999 Hz -- which=0A=
+	 * then refuses every rate the VCO divides exactly.=0A=
+	 */=0A=
+	*fvco =3D mul_u64_u64_div_u64(2 * fref, (u64)divn, SIT9531X_DIVN_SCALE);=
=0A=
+	*fvco =3D (*fvco + 1) / 2;=0A=
+=0A=
+	/*=0A=
+	 * A DIVN of less than one whole cycle passes the check above and=0A=
+	 * still truncates the product to zero.  Callers divide by this, so=0A=
+	 * report the unprogrammed divider it describes rather than handing=0A=
+	 * back a zero denominator.=0A=
+	 */=0A=
+	if (!*fvco)=0A=
+		return -ENODATA;=0A=
+=0A=
+	/*=0A=
+	 * A rate outside the band the PLL's VCO runs in usually means=0A=
+	 * Fref * DIVN is not what this PLL runs at -- a PLL fed from another=0A=
+	 * PLL rather than from the XO, for one.  The rate derived from the=0A=
+	 * registers is still the only estimate there is, so it is used as=0A=
+	 * it is: substituting the band edge would program dividers against=0A=
+	 * a rate nothing supports and report the result as exact.  Say so=0A=
+	 * once.=0A=
+	 */=0A=
+	if (*fvco < fvco_min || *fvco > fvco_max)=0A=
+		dev_warn_once(sitdev->dev,=0A=
+			      "PLL%c: Fref * DIVN =3D %llu Hz is outside its VCO band\n",=0A=
+			      'A' + pll_idx, *fvco);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* Latch a change to a PLL page with a small update. */=0A=
+static int sit9531x_pll_small_update(struct sit9531x_dev *sitdev, u8 pll_i=
dx)=0A=
+{=0A=
+	return sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				     SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				     SIT9531X_SMALL_UPDATE_CMD);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_phase_flush - flush the output phase of a PLL=0A=
+ *=0A=
+ * Fires the chip's on-demand phase-flush (PHFL) so every output divider=
=0A=
+ * of @pll_idx restarts aligned to the PLL phase.  Without it a rewritten=
=0A=
+ * DIVO keeps counting from an arbitrary point and the output edge lands=
=0A=
+ * with a persistent offset against the tracked reference (only a power=0A=
+ * cycle realigned it).=0A=
+ *=0A=
+ * The sequence mirrors the documented procedure: arm the on-demand PHFL a=
nd=0A=
+ * latch it with the PLL-page small-change update, then select the=0A=
+ * in-register phase trigger on Page 0 and pulse it.  The Page 0 trigger=
=0A=
+ * register is touched read-modify-write so the unrelated OEb bits are=0A=
+ * preserved.=0A=
+ *=0A=
+ * A PLL the loaded configuration builds without the phase-flush feature=
=0A=
+ * (PLL page 0x47 bit 7 clear) has nothing to fire; it is restarted=0A=
+ * instead, which restarts its output dividers from the PLL phase.  That=
=0A=
+ * is what SiTime's Dely_program_output.py does for such a PLL.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll=
_idx)=0A=
+{=0A=
+	u8 ctrl, orig, phfl, armed_mask =3D 0, parked =3D 0, i;=0A=
+	int rc, ret;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_CONFIG47,=
=0A=
+				  &phfl);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (!(phfl & SIT9531X_PLL_CONFIG47_PHFL_EN))=0A=
+		return sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					     SIT9531X_PLL_REG_DIRECTIVES,=0A=
+					     SIT9531X_PLL_DIRECTIVE_RESTART);=0A=
+=0A=
+	/*=0A=
+	 * The trigger below is chip-global: every PLL whose on-demand flush=0A=
+	 * is armed answers it.  Note which ones the loaded profile arms --=0A=
+	 * this one so its setting can be put back, the others so they can=0A=
+	 * be parked for the pulse and do not realign outputs nobody asked=0A=
+	 * to move.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, i, SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					  &phfl);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (phfl & SIT9531X_PLL_PHFL_ON_DEMAND_EN)=0A=
+			armed_mask |=3D BIT(i);=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		if (i =3D=3D pll_idx || !(armed_mask & BIT(i)))=0A=
+			continue;=0A=
+		rc =3D sit9531x_update_pll_u8(sitdev, i,=0A=
+					    SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					    SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);=0A=
+		if (rc)=0A=
+			goto unpark;=0A=
+		/* Cleared, if not latched yet: put back either way. */=0A=
+		parked |=3D BIT(i);=0A=
+		rc =3D sit9531x_pll_small_update(sitdev, i);=0A=
+		if (rc)=0A=
+			goto unpark;=0A=
+	}=0A=
+=0A=
+	/* Arm the on-demand phase-flush on the PLL page. */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN);=0A=
+	if (rc)=0A=
+		goto unpark;=0A=
+=0A=
+	/*=0A=
+	 * Latch it with the PLL small-change update.  Written whole, like=0A=
+	 * every other issue of this directive: the register is a command=0A=
+	 * register, and a read-modify-write skips the write entirely when=0A=
+	 * the bit still reads back set from the previous command.=0A=
+	 */=0A=
+	rc =3D sit9531x_pll_small_update(sitdev, pll_idx);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	/*=0A=
+	 * Select the in-register phase trigger, preserving the OEb bits.=0A=
+	 * Remember the original register value (with the trigger de-asserted)=0A=
+	 * so the trigger-source select can be restored once the pulse has=0A=
+	 * fired.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, &ctrl);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	orig =3D ctrl & ~SIT9531X_DIVO_PHASE_TRIG;=0A=
+	ctrl =3D orig | SIT9531X_DIVO_PHASE_SEL_REG;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, ctrl);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	/*=0A=
+	 * Pulse the phase trigger.  No explicit delay is needed between the=0A=
+	 * set and clear writes: each I2C transaction takes far longer than=0A=
+	 * any minimum pulse width.=0A=
+	 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1,=0A=
+			       ctrl | SIT9531X_DIVO_PHASE_TRIG);=0A=
+=0A=
+	/*=0A=
+	 * Restore the original trigger-source select.  The pulse above has=0A=
+	 * already latched the flush, so a one-shot flush must not leave the=0A=
+	 * phase trigger permanently pinned to the in-register source.  This=0A=
+	 * runs even when the pulse write failed, otherwise a failed flush=0A=
+	 * would keep a hardware trigger source hijacked; the restore error=0A=
+	 * is only surfaced when it would not mask the pulse failure.=0A=
+	 */=0A=
+	ret =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, orig);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+disarm:=0A=
+	/*=0A=
+	 * Put the on-demand flush enable back as the profile had it.  One the=0A=
+	 * profile left clear must not stay armed: a later assertion of the=0A=
+	 * restored trigger source would re-flush every output divider of this=0A=
+	 * PLL.  One the profile armed -- a board realigning from a GPIO, say=0A=
+	 * -- must not be switched off by an unrelated rate change.=0A=
+	 */=0A=
+	if (!(armed_mask & BIT(pll_idx))) {=0A=
+		ret =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+					     SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					     SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);=0A=
+		if (!ret)=0A=
+			ret =3D sit9531x_pll_small_update(sitdev, pll_idx);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+	}=0A=
+=0A=
+unpark:=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		if (!(parked & BIT(i)))=0A=
+			continue;=0A=
+		ret =3D sit9531x_update_pll_u8(sitdev, i,=0A=
+					     SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+					     SIT9531X_PLL_PHFL_ON_DEMAND_EN,=0A=
+					     SIT9531X_PLL_PHFL_ON_DEMAND_EN);=0A=
+		if (!ret)=0A=
+			ret =3D sit9531x_pll_small_update(sitdev, i);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_divo_calc - work out an output's divider and its VCO=0A=
+ *=0A=
+ * Separated from the write so a caller that programs more than the=0A=
+ * divider in one sequence can compute the value before it enters the=0A=
+ * programming state.=0A=
+ */=0A=
+static int sit9531x_output_divo_calc(struct sit9531x_dev *sitdev, u8 out_i=
dx,=0A=
+				     u8 pll_idx, u64 frequency, u64 *fvco_out,=0A=
+				     u64 *divo_out)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 fvco, divo;=0A=
+	int rc;=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs || pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (!frequency)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * The core validates the request against the supported ranges with=0A=
+	 * the value narrowed to u32 but hands the full u64 down, so a value=0A=
+	 * like U32_MAX + 1 Hz validates as 1 Hz.  Reject anything that does=0A=
+	 * not fit the narrowed width the validation actually covered.=0A=
+	 */=0A=
+	if (frequency > U32_MAX)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * sit9531x_get_fvco() returns the register-derived rate, so a=0A=
+	 * frequency get and a frequency set divide the same number.  A VCO=0A=
+	 * that cannot be read fails the request: programming a divider from a=0A=
+	 * guessed rate would put the output far from what was asked for=0A=
+	 * while reporting success.=0A=
+	 */=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	/*=0A=
+	 * Round to nearest rather than down: flooring picks the worse of the=0A=
+	 * two adjacent dividers whenever the remainder is above half the=0A=
+	 * request.=0A=
+	 */=0A=
+	divo =3D div64_u64(fvco + frequency / 2, frequency);=0A=
+	if (!divo)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * DIVO is a 34-bit field.  Fvco is used as it is, even outside the=0A=
+	 * VCO band, so a divider can come out wider than the field; refuse=0A=
+	 * it rather than truncate it.=0A=
+	 */=0A=
+	if (divo > SIT9531X_DIVO_MAX)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * The output divider is an integer divider of the VCO, so the only=0A=
+	 * rates the part can make are Fvco/N.  An output pin that lists no=0A=
+	 * supported frequencies advertises a continuous range, because the=0A=
+	 * divisors cannot be enumerated ahead of a known Fvco, so a request=0A=
+	 * for a rate between two of them arrives here.  Refuse it: running=0A=
+	 * the output at the nearest divider instead and reporting success=0A=
+	 * would leave the pin several percent off what was asked for with=0A=
+	 * nothing saying so.=0A=
+	 */=0A=
+	if (div64_u64(fvco, divo) !=3D frequency) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"out%u: %llu Hz is not Fvco/N (Fvco=3D%llu, nearest %llu Hz)\n",=0A=
+			out_idx, frequency, fvco, div64_u64(fvco, divo));=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	dev_dbg(sitdev->dev,=0A=
+		"out%u: Fvco=3D%llu freq=3D%llu DIVO=3D%llu (effective %llu Hz)\n",=0A=
+		out_idx, fvco, frequency, divo, div64_u64(fvco, divo));=0A=
+=0A=
+	*fvco_out =3D fvco;=0A=
+	*divo_out =3D divo;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_divo_write - write the five DIVO bytes of an output=0A=
+ *=0A=
+ * The caller must already be in the programming state.  Bytes written=0A=
+ * before a failure are put back, so the output keeps the divider it had=
=0A=
+ * rather than a mixture of the two.=0A=
+ */=0A=
+static int sit9531x_output_divo_write(struct sit9531x_dev *sitdev, u8 out_=
idx,=0A=
+				      u64 divo)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, base_reg, divo_bytes[5], old_bytes[5], msb_old;=0A=
+	int rc, j, rb_rc;=0A=
+	u8 written =3D 0;=0A=
+=0A=
+	/* Map output index to physical slot */=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+=0A=
+	/* Determine page and per-page slot register */=0A=
+	if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)=0A=
+		page =3D SIT9531X_PAGE_OUTSYS1;=0A=
+	else=0A=
+		page =3D SIT9531X_PAGE_OUTSYS0;=0A=
+	base_reg =3D clkout_odr_divn_base[slot % 6];=0A=
+=0A=
+	divo_bytes[0] =3D (divo >>  0) & 0xFF;=0A=
+	divo_bytes[1] =3D (divo >>  8) & 0xFF;=0A=
+	divo_bytes[2] =3D (divo >> 16) & 0xFF;=0A=
+	divo_bytes[3] =3D (divo >> 24) & 0xFF;=0A=
+	divo_bytes[4] =3D (divo >> 32) & 0x03;  /* only bits [1:0] */=0A=
+=0A=
+	for (j =3D 0; j < 5; j++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      SIT9531X_REG(page, base_reg - j),=0A=
+				      &old_bytes[j]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	msb_old =3D old_bytes[4];=0A=
+	divo_bytes[4] |=3D msb_old & 0xFC;=0A=
+=0A=
+	for (j =3D 0; j < 5; j++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(page, base_reg - j),=0A=
+				       divo_bytes[j]);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+		written++;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+=0A=
+rollback:=0A=
+	/*=0A=
+	 * The byte whose write reported the error may still have reached=0A=
+	 * the part, so it is put back along with the ones that did.=0A=
+	 */=0A=
+	for (j =3D 0; j <=3D written && j < 5; j++) {=0A=
+		rb_rc =3D sit9531x_write_u8(sitdev,=0A=
+					  SIT9531X_REG(page, base_reg - j),=0A=
+					  old_bytes[j]);=0A=
+		if (rb_rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"out%u: DIVO rollback failed (%d), the divider is part old and part ne=
w\n",=0A=
+				out_idx, rb_rc);=0A=
+			if (!rc)=0A=
+				rc =3D rb_rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Read an output's divider back from the device.=0A=
+ *=0A=
+ * Return: 0 with *divo set, -ENODATA when the divider is not programmed,=
=0A=
+ * or the register access error=0A=
+ */=0A=
+static int sit9531x_output_divo_read(struct sit9531x_dev *sitdev, u8 out_i=
dx,=0A=
+				     u64 *divo)=0A=
+{=0A=
+	u8 slot, page, base_reg, v;=0A=
+	int rc, j;=0A=
+=0A=
+	slot =3D sitdev->info->clkout_map[out_idx];=0A=
+	if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)=0A=
+		page =3D SIT9531X_PAGE_OUTSYS1;=0A=
+	else=0A=
+		page =3D SIT9531X_PAGE_OUTSYS0;=0A=
+	base_reg =3D clkout_odr_divn_base[slot % 6];=0A=
+=0A=
+	*divo =3D 0;=0A=
+	for (j =3D 4; j >=3D 0; j--) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      SIT9531X_REG(page, base_reg - j), &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (j =3D=3D 4)=0A=
+			v &=3D 0x03;=0A=
+		*divo =3D (*divo << 8) | v;=0A=
+	}=0A=
+=0A=
+	return *divo ? 0 : -ENODATA;=0A=
+}=0A=
+=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency)=0A=
+{=0A=
+	u64 fvco, divo;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_output_divo_calc(sitdev, out_idx, pll_idx, frequency,=0A=
+				       &fvco, &divo);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_divo_write(sitdev, out_idx, divo);=0A=
+	/*=0A=
+	 * Step 4: NVM update + loop lock.  Always run prg_commit() so the chip=
=0A=
+	 * leaves the PRG_CMD state with the output loops re-locked, even when a=
=0A=
+	 * write above failed; keep the first error to return.  It also carries=
=0A=
+	 * the required post-lock settling sleep.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Step 5: flush the PLL's output phase so the new DIVO starts=0A=
+	 * aligned instead of keeping the arbitrary phase the divider=0A=
+	 * happened to be at.=0A=
+	 */=0A=
+	/*=0A=
+	 * The divider is committed by this point, so the part is already=0A=
+	 * running at the new rate.  A flush that fails leaves the output=0A=
+	 * divider on its old phase, which is a realignment that did not=0A=
+	 * happen rather than a rate that did not change -- and reporting a=0A=
+	 * failure would be doubly wrong, because the core asks for the=0A=
+	 * current rate first and would drop an identical retry.=0A=
+	 */=0A=
+	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+	if (rc) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "out%u: rate changed but the divider phase was not realigned (%d)\n",=
=0A=
+			 out_idx, rc);=0A=
+		rc =3D 0;=0A=
+	}=0A=
+=0A=
+	sitdev->out[out_idx].freq =3D div64_u64(fvco, divo);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_freq_get - read output clock frequency from hardware=0A=
+ * @out_idx:	output index (0-N for this chip variant)=0A=
+ * @frequency:	output frequency in Hz=0A=
+ *=0A=
+ * Reads the 34-bit DIVO divider back from the output system registers=0A=
+ * and computes the live output frequency as Fvco / DIVO.  This stays=0A=
+ * correct even when the divider was reprogrammed behind the driver's=0A=
+ * back (e.g. by a direct-I2C userspace tool), where the cached value=0A=
+ * would be stale.=0A=
+ *=0A=
+ * The cached output state is refreshed with the computed value.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENODATA when the output divider or VCO rate=0A=
+ *	   is not resolvable, <0 on register access error.  -ENODATA and not=0A=
+ *	   -ENODEV, which the I2C layer returns for an adapter that is gone=0A=
+ *	   and which must not read as "no rate to report".=0A=
+ */=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 fvco, divo;=0A=
+	u8 pll_idx;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS || !sitdev->out[out_idx].routed)=0A=
+		return -ENODATA;=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_divo_read(sitdev, out_idx, &divo);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	*frequency =3D div64_u64(fvco, divo);=0A=
+	sitdev->out[out_idx].freq =3D *frequency;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Phase adjust (PRG_RST_DELAY register-based).=0A=
  *=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 8aa505f84e87..473171a19d94 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -260,6 +260,10 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitde=
v, u8 pll_idx,=0A=
 /* ---- Output enable/disable (Hi-Z control) ---- */=0A=
 =0A=
 /* ---- Output frequency ---- */=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency);=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency);=0A=
 =0A=
 /* ---- Output phase adjust (PRG_RST_DELAY register-based) ---- */=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index ebbf7f5a3394..a576d918e68d 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -350,6 +350,29 @@ sit9531x_dpll_input_pin_direction_get(const struct dpl=
l_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_frequency_get - read input pin frequency=0A=
+ *=0A=
+ * Returns the rate the board wired to the input, the first entry of its=
=0A=
+ * supported-frequencies-hz; an input has no frequency setter.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_frequency_get(const struct dpll_pin *pin,=0A=
+				      void *pin_priv,=0A=
+				      const struct dpll_device *dpll,=0A=
+				      void *dpll_priv, u64 *frequency,=0A=
+				      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	const struct sit9531x_ref *ref;=0A=
+=0A=
+	ref =3D sit9531x_ref_state_get(sitdpll->dev, dpin->id);=0A=
+	*frequency =3D ref->freq;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state=0A=
  *=0A=
@@ -584,6 +607,7 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin =
*pin, void *pin_priv,=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
@@ -643,6 +667,7 @@ sit9531x_dpll_xo_pin_state_on_dpll_get(const struct dpl=
l_pin *pin,=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_xo_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_xo_pin_state_on_dpll_get,=0A=
 };=0A=
 =0A=
@@ -658,8 +683,78 @@ sit9531x_dpll_output_pin_direction_get(const struct dp=
ll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_frequency_get - read output pin frequency=0A=
+ *=0A=
+ * Reads the DIVO divider back from the chip and computes the live=0A=
+ * frequency as Fvco / DIVO.  Falls back to the cached value only when=0A=
+ * the output is not resolvable through the divider chain (e.g. not=0A=
+ * mapped to a PLL), so transport/register errors still surface.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_frequency_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv, u64 *frequency,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_freq_get(sitdev, dpin->id, frequency);=0A=
+	if (rc =3D=3D -ENODATA)=0A=
+		*frequency =3D sit9531x_out_state_get(sitdev, dpin->id)->freq;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return rc =3D=3D -ENODATA ? 0 : rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_frequency_set - set output pin frequency=0A=
+ *=0A=
+ * computes DIVO =3D Fvco / frequency and writes the=0A=
+ * 34-bit output divider to the output system registers via=0A=
+ * sit9531x_output_freq_set().=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv, u64 frequency,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 actual_pll;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Read the PLL that drives this output from its OUT_MAP state=0A=
+	 * (populated by out_state_fetch from the chip's OUT_MAP registers).=0A=
+	 * That is the index the output register programming below is keyed=0A=
+	 * by; the output is registered under the DPLL matching this PLL.=0A=
+	 */=0A=
+	actual_pll =3D sitdev->out[dpin->id].pll_idx;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,=0A=
+				      frequency);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc)=0A=
+		NL_SET_ERR_MSG(extack, "Output frequency set failed");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
+	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index 934db566c002..42f3e53b6def 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -295,15 +295,35 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=
=0A=
 	}=0A=
 =0A=
 	/*=0A=
-	 * Seed an input's runtime ref->freq with the first DT-listed=0A=
-	 * supported frequency: for an input the board lists the rate that is=0A=
-	 * physically wired to it first.  An output's current rate is what its=0A=
-	 * divider produces, not an entry of the list it may be set to.=0A=
+	 * Seed the runtime ref->freq with the first DT-listed supported=0A=
+	 * frequency: an input's rate is a board fact, so firmware is the=0A=
+	 * source.  An output is left to the read-back below, which knows=0A=
+	 * what the divider is actually doing.=0A=
 	 */=0A=
 	if (num_freqs > 0 && dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
 	    index !=3D SIT9531X_MAX_INPUTS)=0A=
 		curr_freq =3D freqs[0];=0A=
 =0A=
+	/*=0A=
+	 * An output's current rate is the one its divider produces, so read=0A=
+	 * it rather than assume the first entry of a list of the rates the=0A=
+	 * board supports is the one in force.  A rate taken from firmware=0A=
+	 * that the part is not running would be reported as current and,=0A=
+	 * worse, used as the output period the phase adjust quantizes=0A=
+	 * against.  An output the configuration does not route has no rate=0A=
+	 * to read, which is not an error.=0A=
+	 */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index < sitdev->info->num_outputs) {=0A=
+		u64 hw_freq;=0A=
+=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_output_freq_get(sitdev, index, &hw_freq);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (!rc)=0A=
+			curr_freq =3D hw_freq;=0A=
+	}=0A=
+=0A=
 skip_fwnode_props:=0A=
 	/* Neither INTSYNC pin carries a frequency attribute */=0A=
 	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index d5e378715110..d2e1ac547cbc 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -200,6 +200,7 @@=0A=
 /* Debug register (same offset, per-page) */=0A=
 #define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)=0A=
 #define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
+#define SIT9531X_DEBUG_LOCK_VAL			0x00=0A=
 =0A=
 /*=0A=
  * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
@@ -214,6 +215,18 @@=0A=
 /* ---- PLL page registers (apply to pages 0x0A-0x0D) ---- */=0A=
 #define SIT9531X_PLL_REG_SMALL_UPDATE	0x0F=0A=
 =0A=
+/* On-demand phase-flush enable (PLL page reg 0x3D bit 7) */=0A=
+#define SIT9531X_PLL_REG_PHFL_CTRL	0x3D=0A=
+#define SIT9531X_PLL_PHFL_ON_DEMAND_EN	BIT(7)=0A=
+=0A=
+/* Whether the PLL has the phase-flush feature (PLL page reg 0x47 bit 7) *=
/=0A=
+#define SIT9531X_PLL_REG_CONFIG47	0x47=0A=
+#define SIT9531X_PLL_CONFIG47_PHFL_EN	BIT(7)=0A=
+=0A=
+/* Directives_GENERIC_PLL: the restart bit restarts the PLL, self-clearing=
 */=0A=
+#define SIT9531X_PLL_REG_DIRECTIVES	0x05=0A=
+#define SIT9531X_PLL_DIRECTIVE_RESTART	BIT(0)=0A=
+=0A=
 /*=0A=
  * Loop-filter coefficients on PLL_PAGE regs 0x10-0x15 (3 normal +=0A=
  * 3 fast-lock) are GUI/NVM-generated by the timing configurator and must =
not be=0A=
@@ -229,6 +242,14 @@=0A=
 #define SIT9531X_PLL_REG_OUT_MAP_LO		0x28=0A=
 #define SIT9531X_PLL_REG_STATUS		0x31=0A=
 =0A=
+/* DIVN registers (free-run divider readback) */=0A=
+#define SIT9531X_PLL_REG_DIVN_INT		0x30=0A=
+#define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
+#define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
+=0A=
+/* DIVN is carried as fixed point, in steps of 1e-12 of a whole divider */=
=0A=
+#define SIT9531X_DIVN_SCALE		1000000000000ULL=0A=
+=0A=
 #define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
 #define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
