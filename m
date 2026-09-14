Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D333E37E5F9;
	Mon, 14 Sep 2026 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426854; cv=fail; b=QKoryDe/U0cAJpjV8Z/gM55kmhxof2XXH2zKBCakE+pgu254JgShJiNpLnrZkqv2xehuBF1x77W9ePkko/qxex2mmOSrQUnIHlfao/uri73Szgi19a8U7tymo+GWCTo2ZKkPDBhziV/o/c9InKIuDUzs1t4Q1UIIOjAANYIrFoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426854; c=relaxed/simple;
	bh=pn86c4Bg/D4l76MACPwI1XMJH/iZYoiGKz0HanF/Pco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MP89wzNMQWe4YqCVnNp1mDfVr9urz+BCd63pvA7IajCNT+ndOcdn4CpYQ7hlbkvZOqzELJElA5uUGSMGZNAGVslt0ggg442i0zh0EPfV03YXhCUrBno3n3qO20DVCiNDYD+zga6IEknuvpjpc6fimU/Gd6L8k3PqIwc3W6abmEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=aDg1Ry5/; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=CiAKIDZ7; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="aDg1Ry5/";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="CiAKIDZ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=fEZGGiDzOiAYMS7WnmOtMaNC1hHR5SX9NvxNfHNe010=;
 b=aDg1Ry5/aJAwScn0Twiqja7vn9rMKoR7cB3yuywYCr3b1XbwONpNPs4VXzKU9oowTkn/zgzVYTc4NIlN8UU20dj3qMdk5dOs5Sg4RnfpmVAO0cbYnVkzaFJTWd7jTyGaiHT26JW7WTYu23O+k16vqhlWXAvKZaodrjejriLlJEwqrhezJaB4Si4ZkPdipr2y8sx0sM5+fhSApnfkRZlEeGPt4C9avPykl1q+8OlZ1nLdTmsP9RfT27gzNEikG/cV7hfpzR/uIU1vJCxMG17Q96WDZmSWUsGCa+ij7mMbadiUxjYoAX6Q15GxDTE90db9KKf7n2nUP3aApCWYMkPoyg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021110.outbound.protection.outlook.com [40.107.208.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 66F0DA80066;
	Mon, 14 Sep 2026 23:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kw7YbA0RbHOXrc4T/8E1c9rsTuE+Dt2q2PogKlSuaplgvQ2Y7l3/maZSbl5fPAOXQZEYrNBtw9UJmTgW0AaENxKYiKMYi/2LlZBKNA01cSD0Uuekc6y5uuYF6cQy3SeTwKSYmeLrXndnLSmdaHV133HqLgobUtv8D3VcmZ0Ka2o4EEoWTdibsNMfRXmZ5ytIh9xLLv6Wur5TmndnEszLtmKSfOYsXFtT2vvXEpDyKOt5nxE7fMBSIT2wiUYT0C0uiaTCKG9+aXQVqhssdaGUQA5fm9PdPpfYeDIDbDufPPzw2XV3gZfUumQK9B1emdXUpeqfNsL8Y8M+D0KRzVrn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEZGGiDzOiAYMS7WnmOtMaNC1hHR5SX9NvxNfHNe010=;
 b=zPCTt4y912OTv4lxQiAC9v8UV9irmRj7Yyrh/zKXafE+teJxO9gI78tciZVFxuZOM0oy56uTzTHrTLUEXNGx+gevFewzaAzmAFDhOvkcqlYnnRX+e33bn46Pi+w+WRoB1jHkerrQn19gU1NO8U3BTyIcvhYIHI9lxmH8jWqwVL8M8elPECMLduuN0wUayWMZs3ek2W6N43xPsRsZcmIlNVI71zchS6ZcE+eaouY5/CE8LvpCipCNbthWEjb9UtEDspQ7FF8gBbutLZ7hSwa9RVXuzawcWdWXxiVqCDsGoflyNFh6UBZLnrlmgKjE85V34HD76Qi4ODK8hFFu8Y6zbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEZGGiDzOiAYMS7WnmOtMaNC1hHR5SX9NvxNfHNe010=;
 b=CiAKIDZ7gZgIp2bC3vVvC2jewTSgPljdQmzsWf5EEwKgxtnZi9iOp0vAcuX+0tB0vxZCpDTCBcsZMCzsD4oLPpJcecIYd1MukBZ0lYC467xfDTly4w8ydrSSZht3HVY35jUAu4he7yCDV8b0b4Tm5Seq+zxrXaiERDWH6g3CNlJUUDCINZQVrgn7vcWh59LSzSkWoANm5qEoZFO5DOmgzI/LvwHnDP52VO52QSeAYOHuV69iGM2PlDf3WpypPKiVBz8vQkp2A4Ik+qk2F7jsSPX6vyagFvQwxBLNRd6ZDeaS1Bm9UvXnBjkI/19pI3gTW/JVkfvUoenQP+uFVWnTRg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MW6PR20MB6839.namprd20.prod.outlook.com
 (2603:10b6:303:23e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 23:00:39 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:39 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 05/15] dpll: sit9531x: register DPLL devices
 and pins
Thread-Topic: [PATCH net-next v8 05/15] dpll: sit9531x: register DPLL devices
 and pins
Thread-Index: AQHdOyOvJzMchKInk0avx2V4FNcwcbbEqYEAgAoZ3IA=
Date: Mon, 14 Sep 2026 23:00:36 +0000
Message-ID: <20260914230034.63861-4-arouhi@sitime.com>
References: <178887151400.219967.903139931205963081@kernel.org>
In-Reply-To: <178887151400.219967.903139931205963081@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MW6PR20MB6839:EE_
x-ms-office365-filtering-correlation-id: 786bbd7c-bd49-4d7e-1414-08df12b3fe9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|6133799003|10067099003|56012099006|5023799004|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 gphDFAK+2qBuK169OmdaAi9OJm300hY6iOb+tCHLzsCTOXrlLTXux671QksYhb0bMmAvzpwqc/74VPL0fgT9oBLlBhNI5PEVwC9avueGhbf9FTvNpAnRaRFvPX/8EGAOeTgLGpF6hjcMLoQdmLOBjfttp6Ps4kbxGSsMY3OyY1sj+bi9tx6jzgZgImpA/9jidTTh7m9HuLgzrj1QnPr5rLcEsGUdOzqtrW5/Juz39zXbQ3czpMFMfdgABOf7+p8tjSo6bXdNm6a53wCrNCXKQFXiBQ2UbwDFnX3+u9KNQpwU8R6BDyS9sh698rut9hLXn7xojrzrjJQqjDITECc+WGYOMHOWifPA7kNnuKqLuKxQCMLyeAmZ7KO4oDvQqsj8X1q1NrLSBBwA55UAFfWLmbSq7cjO9UBm+MhDdO1nwmDOknW5RamFhIO57V9NNFd1pnqohqB6CKueEeKXt/ENQP+8q8FSJsbbmAOtS5ent/BrZIs4ynGko8eoPUH44MjV16XTNyGRfScCw6QCxEa8Z+cA2UH6KLJYBmI8XScuES1MoPPfLegpFic3VTc0iD832wrGtbC/nNIP9z6nc3aNaIToh7NJ4baV/U/PeKx7RVCy/pWkfXUcYegUIql42tPdnYiwQe33Glv+0/i5+01OZY+Ol9rzUFm+wU4U+v/tXPP6S9EkGGLvguuj/LmIh8zlg7/R0j6vII7YLhlCpO1obQ+xJY1hANtPaZdp8mFmis0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(5023799004)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6RpXw2RvvY/8HQPXcl4c9eiVMFZ8WXiB4FyAEDstOHkUjpIDm6sIGwMYsc?=
 =?iso-8859-1?Q?aZVqSJlh9wlcom3P/BT/UArhcq5kU/yNgBk48HDhG0JYOAoxLIvKPgAvET?=
 =?iso-8859-1?Q?hix2+t2Y8tjPq/JKRezFigALqTGk1dts0X7888J/GooagM1YdaPUOHLEUd?=
 =?iso-8859-1?Q?EQaJ0FwB/HjiXgYcMHhO7Y3GoJqu2nreh4vsnMIEfLA6ESVm7kKGZTrbtn?=
 =?iso-8859-1?Q?mn2YfbiW3+fVE5tpIPcXhslzyY8+oOMR9nWXeVK24cTIApfRq1BnliCxkz?=
 =?iso-8859-1?Q?mqORG0KnfpPNEDz00yPpQH9U7pnG7HWlLuTofQ+LtlbxoqP3Wp86JGe8nH?=
 =?iso-8859-1?Q?OCY54xwVyxZFElbPV1h1werzAx6Jhg33QiIbmiquuQv8CRY98YR6iqrjBj?=
 =?iso-8859-1?Q?bMH2zhuvgPMeDoXelwjMSJX/Ac4tbXWPYR6HTAzD5HrolOWxc9ngq7gws3?=
 =?iso-8859-1?Q?Y2ZPEQZjitfCrY2i9mRyO1WMR9gDv1Qxa+2i4iTyb5cZOgqfpF6TkkEPy1?=
 =?iso-8859-1?Q?GebCwiK+I8X73bZVvdDhe0OJLfKNwf2i08EzJ6/ekNt6kuMnNLrfEJFNHk?=
 =?iso-8859-1?Q?iI8uUpKcJhDVSCabOGv/29WPzqNAhicTeLa+6DF5Mzm8JO7iCNfnjbFkOa?=
 =?iso-8859-1?Q?XOJznQ6y/ANsFAisuWufia9NXa9qex6rXupb96ICiGwmO6fiLXpag6YS5f?=
 =?iso-8859-1?Q?JL9FtuVj0SBdF/NSehWPtidTOOmiEnE25GAQv62Exn43vu0WYNJi0ur7oM?=
 =?iso-8859-1?Q?GG15q9vsdJ7/0VNKk0uGuKJY/C+ky2VlEe0dsQHmU/mgsbcC/BFqA7/QRi?=
 =?iso-8859-1?Q?MVQjV4pjPde5Qb2qmbjMrJotUU0jmf2ocML7uuIZzPwnsi4124iZgl8tOi?=
 =?iso-8859-1?Q?G3HkTvI7Ja/Tx6CqHFE56k0dgq7twEnTDb7AqK6eLoPBs4vsEq0Z/lLqTy?=
 =?iso-8859-1?Q?sCt71qO62emd0UrtjYDpX5HsRp1G+aZfPJlhY50D0Z7vgXv+zJU4hPs1uu?=
 =?iso-8859-1?Q?W6iYQOvE7lHiZdzFLKsQYAeZPoHDOLqGuQVkC5b5prYj+nvpqoH3Oddl1q?=
 =?iso-8859-1?Q?UR1ijjPSIt5AwRux6p5cGTmibgenPah2ZeA0IYPLEO1bH+m3w9FqFmmerr?=
 =?iso-8859-1?Q?K0+/Ev++naniEzQnceIg4VKxP1NHOXnfuTAOb2fAHvSLzlCYU7cSePquDA?=
 =?iso-8859-1?Q?B8dE7lTLdCqkL4MUMkqHOdoTbEldBsVuK5v15SwLdMl/Ajgtn2eCDU9Kxa?=
 =?iso-8859-1?Q?SOpPg+xbQn/kx1rZ+6LAqBuqwZrJhB3EdkgXPkrNf8bMLLqIvM/7uExwZ7?=
 =?iso-8859-1?Q?hPGYNEVlhXwS3AVp4YORxo9hXOceokbHVAnR7sT/21bg2yeHoK1mG0FbfJ?=
 =?iso-8859-1?Q?SVv5DuExOCf3Pe0syUaNnPoPJBbQQ2ShWWah6NanzBgEAoJI31T3TBsaNX?=
 =?iso-8859-1?Q?wGPQE8JWDJiBj2f/M1KrEJesZKD+QwpQSYJ7kAiUGYD3fL8xgNNlSYeyAt?=
 =?iso-8859-1?Q?4umPjFb1lwdZE3/xXDLcW0ZfBcQTVXZU1PonntXwx/dSYOLgRmmF9IB4S2?=
 =?iso-8859-1?Q?p2PHfMkTPSxRQY6FHoNpKrVts+eReU2RjYCiZHOJaM/Fmu3ufzE/cvROgz?=
 =?iso-8859-1?Q?kyrCptS53ahEOUJxQdMKygOOEl8p61ceE6WniO3zL2dtPzvouBccNpkWmz?=
 =?iso-8859-1?Q?dY3M4AjgUhg/Il/lpX1FEDjkfaHnfegxCO9IHG22t6iWZvskjfavzJWjQm?=
 =?iso-8859-1?Q?hadfnna5yYnx5IU2qYFF/BX5ttzmpbE9mM6oMBNbK3kbR6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	MW9CIJidRnxEHXlvg0DpFsePcxhAo3TKFq7Vt25jobC6oJmynF6pJ3ueM1WIG2UoThuoyFXsWDNGNuw1XHgHLlfYxNlpIPU24YxYyXc4zj1MtDZu1X7Q6mELnHhgvmfpPyF2A5IWGbGnEDyN3tn3qmTeS2Urk3Ausk1C8cGJ7EOTfA4rdnJFWRZ4zFEzm5yDev7sucYsiWc1pg08A06vD67HDRBkCtVGEPrsKuyQ4tKaImE6Eu+NanSPdZIzE08zOZmWIgiWppqD2fHNsSsiut3ax7o19A4w9pM2mZpBQ/yYXKn/gTuzWipGZqcmfK7pk7U4GhM64pIssL8kaYu3Bw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786bbd7c-bd49-4d7e-1414-08df12b3fe9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:36.4123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6xzREJASv2U0r1AlYVH2aKQHv7beDkH6xsqsx84pgwD8UypzdjfgIsSHeL78rfe806z5Z+5ToLk8ou740NcIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6839
X-MDID: 1789426843-EzoaPUOUZhcA
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789426843;EzoaPUOUZhcA;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> The register carries two independent bits, SE_P_EN and SE_N_EN, but this=
=0A=
> folds them into one pair-wide value and writes it to both lanes. [...] Do=
es=0A=
> this publish a pin for a lane whose receiver the loaded configuration nev=
er=0A=
> enabled [...]?=0A=
=0A=
The fold is intentional for classification: sig_mode only answers=0A=
"is this pair wired differential or single-ended", which is a pair-level bo=
ard=0A=
fact -- a DE pair must hide its N lane, an SE pair exposes both lanes as=0A=
independently selectable hardware.  A lane whose receiver the profile left=
=0A=
disabled is still real, connectable hardware; in v9 its reported state deri=
ves=0A=
from priority-table membership, so it shows DISCONNECTED until userspace=0A=
connects it, and connecting it powers the receiver -- which is exactly the=
=0A=
operation the pin exists for.  Whether the profile pre-enabled the lane doe=
s=0A=
not change what the board supports.=0A=
=0A=
> Can this branch ever run at this commit?  Nothing in the driver reads=0A=
> "sitime,output-pll-map" or "sitime,pll-fvco" yet [...] would it be better=
 to=0A=
> keep the binding and these fields in the same patch as the parser?=0A=
=0A=
The bindings land first by convention, so the compatible string never=0A=
precedes its schema; the parser lands with the feature patch at the end.  B=
oth=0A=
properties are optional, so a board using them just gets the pre-override=
=0A=
behaviour at the intermediate commits -- the same behaviour it would get fr=
om=0A=
a kernel one release older.  We kept the struct fields with the state-cachi=
ng=0A=
patch so the caching code compiles as one piece.=0A=
=0A=
> What stops this tick when the parent I2C adapter suspends? [...] The driv=
er=0A=
> still has no .pm member at the end of the series.=0A=
=0A=
Fixed in v9: the driver now has DEFINE_SIMPLE_DEV_PM_OPS wired through=0A=
pm_sleep_ptr(); suspend parks the poll worker and disables the IRQ, resume=
=0A=
re-enables them, so no paged I2C sequence can tear across suspend.=0A=
=0A=
> When the acknowledge write itself fails, this still returns IRQ_HANDLED.=
=0A=
=0A=
Fixed in v9: the handler returns IRQ_NONE when the notification=0A=
latches cannot be acknowledged, so a persistently failing ack engages the=
=0A=
genirq spurious detector instead of re-entering back to back.=0A=
=0A=
> Should the zero-CRC case be treated as "no EEPROM" instead of a warning?=
=0A=
=0A=
Yes -- fixed in v9: a 0/0 CRC pair is reported as "no EEPROM profile"=0A=
at dev_dbg level, and the v9 changelog mentions the probe-time reporting.=
=0A=
=0A=
> Could the changelog mention these two [INTSYNC] pins, since they are visi=
ble=0A=
> over netlink?=0A=
=0A=
Yes -- the v9 changelog enumerates the INTSYNC source and destination=0A=
pins along with the inputs, the crystal and the routed outputs.=0A=
=0A=
> Do two same-variant parts at the same address on different I2C busses (or=
=0A=
> behind a mux) end up sharing a clock_id?=0A=
=0A=
They did -- fixed in v9: the I2C adapter number is mixed into the=0A=
clock_id, so same-variant chips at one address on different busses keep=0A=
distinct DPLL objects.=0A=
=0A=
> [prio_add] When the table already carries eleven distinct sources, the=0A=
> source sitting in slot 10 is silently ejected [...] What should the twelf=
th=0A=
> request do?  Returning -ENOSPC and leaving the table alone looks like the=
=0A=
> honest answer [...]=0A=
=0A=
Fixed in v9: sit9531x_input_prio_add() returns -ENOSPC when=0A=
the table is full and leaves it untouched, so pll_mask and the table stay i=
n=0A=
step by construction.=0A=
=0A=
> roughly fifteen functions declared in this hunk have no definition anywhe=
re=0A=
> in the module at this commit [...] could the declarations move to the=0A=
> patches that define them?=0A=
=0A=
The module builds and links at every commit -- nothing calls a=0A=
declared-but-undefined helper, so there is no undefined reference at any=0A=
bisect point.  Moving each prototype to its defining patch would churn core=
.h=0A=
in nearly every patch of the series for no functional gain; we prefer to ke=
ep=0A=
the core API surface readable in one hunk.=0A=
=0A=
> If the small-update write fails here, the OUTER_DIS bit cleared by the=0A=
> preceding sit9531x_update_pll_u8() is neither committed nor restored.=0A=
> Should this path put the bit back?=0A=
=0A=
Yes -- v9 restores the bit on that error path=0A=
so the cached mode cannot drift from the hardware.=0A=
=0A=
> Does probe succeed with this table?  It has no .state_on_dpll_get, and it=
=0A=
> sets .supported_ffo without an .ffo_get, both of which the core rejects [=
...]=0A=
> Could the callbacks land in the same patch that registers the pins?=0A=
=0A=
Correct: at this commit dpll_pin_register() fails for the first non-XO=0A=
pin, so the=0A=
intermediate commits do not probe.  v9 restructures the registration so tha=
t=0A=
each pin class is registered in the patch that implements its state op (the=
=0A=
crystal here, inputs with the input-state patch, outputs with the output-st=
ate=0A=
patch, the INTSYNC pair with the inter-PLL sync patch), and .supported_ffo=
=0A=
moves to the patch that adds .ffo_get.  Every commit of the series then bot=
h=0A=
builds and probes.=0A=
=0A=
> Same missing callback here: [...] would this call dereference NULL if a p=
in=0A=
> ever reached this loop?=0A=
=0A=
Resolved by the same v9 restructure: no pin is=0A=
registered before its ops table carries .state_on_dpll_get, so the poller's=
=0A=
dispatch cannot reach a NULL member.=0A=
