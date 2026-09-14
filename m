Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656243B3E6;
	Mon, 14 Sep 2026 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426872; cv=fail; b=Y5xCYp4YnLiOFoqM3n1P1Sar+fT0djzMT7QgMjQGLSNi7E2HboCuD5uGEvNCA80lNDkMQAmTBKRfe0392anNzPpiadOsAaT3yo4yrxWbkFFZtHmPvkUremQ7XX7WhZYSmrv7dzQUhIomt+R53Jm0JsGHkZ9Pc4SHBPu7SEJqVLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426872; c=relaxed/simple;
	bh=H584gortRqsNYVunZMw2gXIvApxTA8WbZmdZtI4Kwz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SxvDtOpCNBiQq5rDiXNbgiHOVLeTFI4Z7gxPQQNVDQRCv362me0YiSJAQYq0Y8rHYSnKp9beXVsSFVcLDH2vuPxQhkpod1jsuc0ZzVi/eloBf6kxD68KfRCA/Oc3f8JL1k5XhEP3Z4I36e8kahyxuNcx4SMu2cnk6dnHkedQLP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=WBhvcMGh; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=ZYpAxbb2; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="WBhvcMGh";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="ZYpAxbb2"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CD33C1C04AB;
	Mon, 14 Sep 2026 23:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=QvHTsU3PQHWQ64ZX6cltrMKfoUYLWWcZVSTdlJsDbCo=;
 b=WBhvcMGhC588Y4I6N779n5KwvaOuUAjw6SccW8klzqWUZyzdlDTveyhzspo2lQ6LnmlghKP5JxD1rt+9j2jWOYNJQkw7ulZaQe8frewGgaso+IhTshYSZC8zAaUMvl5Td9jp4MoeTiPxWK8fXsh4luj0DnjNDhdljy6zqRprVKUMlrt+fP+BO+A0vlpBzG2n2wQ1RsUMdezvxDjztDE/qZyWoNij53KTMET5ElNKIGKPOKLgNJvOhhwQhnEfq0fY+g0K2Hlw2xWQJRZlcTrUG7AEkefPf3SCVlx86tfKel+ho7bU1QnLhTKTZirRQPVbcCimm2nXYvjffi3oSOnG6g==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022095.outbound.protection.outlook.com [52.101.48.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7CFF38007A;
	Mon, 14 Sep 2026 23:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj/FXFpsI/AA7X4xJR1wctqVnKuCWqChawDC7lc00kMkZdt6VLcWEaJTe1SBpt/Z/vzn3woVNptvXD5sn1+5lHIQPojnW0SUaFsgVNmQzBGAS9hzw6ICxLG6ldbK3TBti2bIlHuIL2kXZChq6/00y/z5JbBcSjW/pd1lukmnTzNG6saVP+b2j0hzQn2Jd5ZGWej3Hggnqqza6bdDMlrVZw1+HVQrstObGEAGYF0g+6HOJZkKyt7Ft2CpvLBUjIZadL2DliE0c40OIINj0gh9Rs/YosQBYesFdJslT95iElu97oi509mbvJ0mCxMws551IcyJv/yCMrTcAN3PuBeOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvHTsU3PQHWQ64ZX6cltrMKfoUYLWWcZVSTdlJsDbCo=;
 b=jtvylrw2LSnoUR2LxScoWnm8qns4txlJBOTpEzzjTBtMqrfNdN6cuUaLc2U0Y7WJf8jcVIQluQ8Gt9oy9SIaykiIqnS4riLw514xx+kbtUcdA+lAVyU8uWHdS1LNHEa0UWeNuVkqGLsLSr9OVuVHovs2/gbAVkFpVrGRk6uAhF9GsRItgBh5iax81yLsYhuuJXZ44Tc33J4K6p8fU2s5G4nBxon5AOPrDQHvXkJ0on5b7ybh6UtC+VZgZBm4BoGT+U4FyifFFDvAgUlMKEk7kWeGBhYn1QRqQ+6cTmX40IxEFzZY3F7dbrp6Yy6LUrS/qeQUlxQkIsbWRgRGpeeiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvHTsU3PQHWQ64ZX6cltrMKfoUYLWWcZVSTdlJsDbCo=;
 b=ZYpAxbb2dmoI1oVuGAdgy78BYricerZX5USAbNp1Nk9yu8w75ajFYAAaz3m/AxXUje4MO0x2rz0GRPHD1vD1Da+ZqcGFoishcnSOgJnJ7OAHAvvpt2jAhLyfwfgXkavKBcRV5zsedeVjf2Q0UunVAMtMyDT6tkcC/muInm7ZOH1cm3kxvEr3mp7D2lAyPWCzptGXDx1jfnoGuwF7KF9nvyrizHrOXzGZ9PXt6ww/fWz/AZenK/epXX16QAdhU3dL5ikvAn27MmbLWU69u731LNkUjYrMnpSDsuzAHICm2qwgK92OdDF6CoX+hBFcl5NmjFXMA/0kL9VXbAYJG8rodA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MW6PR20MB6839.namprd20.prod.outlook.com
 (2603:10b6:303:23e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 23:00:43 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:43 +0000
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
Subject: Re: [PATCH net-next v8 11/15] dpll: sit9531x: add support to get and
 set esync on pins
Thread-Topic: [PATCH net-next v8 11/15] dpll: sit9531x: add support to get and
 set esync on pins
Thread-Index: AQHdOyOwbuY3GSPEK0aUf9+si1JKiLbEqYqAgAoZ2oA=
Date: Mon, 14 Sep 2026 23:00:39 +0000
Message-ID: <20260914230034.63861-10-arouhi@sitime.com>
References: <178887152134.219967.16181634650893462486@kernel.org>
In-Reply-To: <178887152134.219967.16181634650893462486@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MW6PR20MB6839:EE_
x-ms-office365-filtering-correlation-id: 3a198215-a22f-4b9c-22b5-08df12b40102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|6133799003|10067099003|56012099006|5023799004|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 V4I3E6rAqmPQt0i2D8m5MRZQtqiVUKR543ju9fc0M5pYfSgtpbOmSUItIoT62UtC379cOpCrckv7GNoxNNpBSJXWcz1qlxH5+iceQeiGwolE+LlURqmjUm+Zhlu0ysn4iOi5q15eynBndr1rChiWOcCznZFUo+N2PJ98ctIDKZuBEDoqURwSlS22MwLhT+shu3o94ut9RxwFzkUbNWCWn9i3mBMjyiyolrIXUMbQ1W7iHRsBPHT5sbMFrzBw7/n9+PHMneGvvnq0ScsEwVCXM6u9GPXOWJIEcjtkWqGilz59NrzWc8XjvGiBDds9NJLDIa4uwnFAHWfbcF2bhHpRUNh0sc8oBGdYFciGXPdtAu4hRciUZngnAONQ2CWMN8u+/4/4W0DyiJpkweEzIl+eFPFGSKRxehMSECg9IsYnDT1ezY9NGEuHZfluQNIbBWi0YCRxI5vxbBPoPzA9G72nb0GI2BBaz7/Em5loj4KsixhMupL3uR0pQltJmjFOsm2wzxrYYb84LwNntkNxzAigsRiJXVCdm8BFOgFQDy6Qv9J7e6cmFksxVXueuKxZcymKOEbaNz5g9mDfETBXyWD7tc1zp+gri/rnJSzMhpLPZZ79ZxmgLeKkUmas6fGMsB+IJJzIVA9AxFj07tbZiCPFInDapfA5vstUzVsv7e5dXHkIJFx/5Rl5Fr/Kh4w3bkm+HtnQXfBeze0dyMPyO5SEH2S4Oi9IrrTPHZwMYD8am5g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(5023799004)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?S9vKo/R9deRj6AatexqoFXjsPp7IZvRaQo3Je6W0dJhs/RP2wSllkdx/Uh?=
 =?iso-8859-1?Q?1x91IpHW4eZNqulzJdIMDxrr/xiCSJc1q6FdJfFAM97DVB16EsLHi09jHl?=
 =?iso-8859-1?Q?BJyYTbhZQV1SfQ4OfRs1yAUBDtqIvvdjgfoCJYK917PPpH1pce+YZ0jE6F?=
 =?iso-8859-1?Q?BzzcdBxW8n81nCQFt+I2E4dJMdrMjyXpRma2+s4jygeFkyN+doQClAB+1D?=
 =?iso-8859-1?Q?dy2wnbCIfdu5/yfoAQcuohiOLkPbl9J9QTa6nb3y7vG089SdwiHtG2TSmx?=
 =?iso-8859-1?Q?VrXfcIrbjLqrvMFqBNQDclh+Jyfekl637EgeEUKx0H5M921r/ggMufZDWw?=
 =?iso-8859-1?Q?PI7pbiJfxDxTHynCINPF0EZ8xmlP5l5SCNT0OlptHSErj+/OX5Z8+rg3j6?=
 =?iso-8859-1?Q?fKBnTDVPqPNWhlBJ1JXz3AczQi6UZhJCd9aYx7byzsgFpt9CPhjv+3Gaqi?=
 =?iso-8859-1?Q?Cb7rf6QS78RFJKWToszrC3iQHn/SqUaDCGi4yZfXubo/TcARwB9L+riDFl?=
 =?iso-8859-1?Q?gaom+nNk73lLa56MfHNGTOieiIG2cVGk8C3S0zRs1JTaj40xtj9x9k9M+L?=
 =?iso-8859-1?Q?EUjPLQId9z4Hhrbu0Z5m8aARFKN6ODOaBlAGQN9+mlK9c5xXuLDmr+c0ni?=
 =?iso-8859-1?Q?xWof1j1pmEyD6uuyZLC6pI/RuyA7BgWas8P5YIIAEC4YzkCU3twPkgeYXS?=
 =?iso-8859-1?Q?Xnexhd1f4SYWI4uEvPCws+td9n7zk7htmk0AM0bZWuXqe/23MI1Chdf0u6?=
 =?iso-8859-1?Q?C7d5J6w7LucIjMi86iek2FQuQhdmgu8Z7LqkBO1V9mTmwvi5NhZp81miM9?=
 =?iso-8859-1?Q?7N0WAAU7cxRF+zE5VkhLKkAzNt0xQ5Z0aVDIm1NJjIaPKHmNt0SfohrUvx?=
 =?iso-8859-1?Q?5rMvpAIkVIvBgIvEUI8mYn4nEd6P8nX0QBclcknm79NQ0skENM/KC8XzFG?=
 =?iso-8859-1?Q?Eyugmz2Zg6WxtZsR9GegM+00J/yFQELDwAklV3dZoGzFB9P4i7L6M+aFIb?=
 =?iso-8859-1?Q?OhjBKUDuRE9KSXpT3VPIBnMIZP7e88QEwBXyAgm816TrrSw/+FPwVv0bUX?=
 =?iso-8859-1?Q?I/XrgFF7tN7iOfEGlFk3BIpv0Fla/n/7owQIXAmuiq3MjLuRf6ZFrwPSjP?=
 =?iso-8859-1?Q?Hd7EETSc58/fJE4k4c21mrXgaKA8xnCytMWexNZQfUX1x+/jhPnJK8Z3/W?=
 =?iso-8859-1?Q?e0vRhzvU0DbKAvfsDSA8GFLXvLkurrVvX+b65uhko/Af4UREgRjTrMMLm6?=
 =?iso-8859-1?Q?Q0c4qRFOZO9oE4Duk1RqTc/d//I8SX13DN+pSuniXKPZnKcVgLaMHCpp0p?=
 =?iso-8859-1?Q?gfaf3peWaEPenAvHm5oy7x+NObCe9wVbkXQUiTUtF5x3OfRfuSdvu5Khf0?=
 =?iso-8859-1?Q?0w/BiDw16xfKTj75E9IlHuS8Z4bowKvJ8oMNljvUp2BIe5X36Jm+gEu6J4?=
 =?iso-8859-1?Q?aPcC/XFLUgWaIKPDJW9wgwU8sY6H5oTjFHzF+q2ECce3LDe6eLPwX77Wcz?=
 =?iso-8859-1?Q?8obdkH0ZUQ7amDPHqoo2FPNmfEbR18WzYf6gtep+VC3OAOxb7VqkH+CLfI?=
 =?iso-8859-1?Q?r4o5+pFN3biWkUpUD96G/soDrhnyMRRucDTVGbVmheCW28VfY2mQ5ZdxKB?=
 =?iso-8859-1?Q?Gw0io+Ae3ZR5ZyhgiCfwsYPKkYXeOIgpw7dLqaJmbLuxuAmMmh+nw6ssJK?=
 =?iso-8859-1?Q?P2rN0ORr8hxyECVSl3Z9OD4Rc4EXGNhd8Sk/0pkFWaNDmtr23zLq8VqOGN?=
 =?iso-8859-1?Q?qryz2qvWJjAxss7mUiOi/vVZcaJP4UzwQuKSWSL/thffT0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eu3/udpRc9Gt2r3lYaD6Zk3ZdFsPZ1b03amZHGGrJ6WIP3P2wTZg3ghzTrUFNixvvljq6bq2/hwq5iCnK7naVCR9Q0DtJS0L3BpSOk9HOWSjf39+R6Y5diIw0o9IRkxg7DrTW03muHHU7o/QmGWxh8hl3NLUu9LC1Bt5+nGD0GlD97d1S8oAthvPLmU66PBRv+nOeZp4grl9LAiNt46u7FLHxPoxUCifg9vzBzjMGeK7qQJ2NyzidCGvxGptVrUxSJ2thAJVxwP8hRzdmIRymm51bqaJHBe7f4nICyG2ERO7dqeEXIKjJZ67uYD3IbjmRll/LcciPGlBgIoWo0KEGg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a198215-a22f-4b9c-22b5-08df12b40102
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:39.3667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6Qq2Wukoa5StzrlTxuzYAVfvOOT3ze9bE+VofP/N6H3pIJPQ43KO85XO+kDn5sJdl9485qA3+opI38Np1cCNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6839
X-MDID: 1789426847-N5uqAT_CGKN7
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1789426847;N5uqAT_CGKN7;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.  The esync path was substantially=0A=
reworked in v9, which resolves most of the points below at once.=0A=
=0A=
> Is the embedded sync frequency here the marker rate or the carrier rate?=
=0A=
=0A=
v8 conflated the two.  v9 implements the uAPI=0A=
semantics: the supported embedded-sync rate is the 1 Hz marker, the carrier=
=0A=
stays the pin's separately configured frequency, and the changelog now=0A=
describes exactly what the code does.=0A=
=0A=
> Where is the pin's previous output rate saved so this path can restore it=
?=0A=
=0A=
Fixed in v9: the pre-esync rate is saved when esync is enabled and=0A=
restored when it is disabled, so an enable/disable cycle returns the pin to=
=0A=
the rate userspace configured.=0A=
=0A=
> What happens if the second or third step here fails?=0A=
=0A=
Fixed in v9: a failure after the first committed step unwinds the=0A=
pulse-control write, and the cached esync state is only updated when the=0A=
whole sequence succeeded, so the reported state cannot claim "disabled" for=
 a=0A=
pin whose carrier was already changed.=0A=
=0A=
> Can dpin->esync_freq go stale here?  [frequency_set / disable do not clea=
r=0A=
> it]=0A=
=0A=
Closed in v9 from the other side: a frequency_set on a pin with esync=0A=
enabled is rejected with -EBUSY and an extack asking to disable esync first=
,=0A=
so the cached esync state and the carrier can no longer diverge through tha=
t=0A=
path.=0A=
=0A=
> Should esync->pulse be reported as 0 when esync->freq is 0?=0A=
=0A=
Yes -- fixed in v9, matching ice and zl3073x: both fields read 0 in=0A=
the disabled case.=0A=
=0A=
> it looks like one constant is being used both as a uAPI percentage and as=
 a=0A=
> raw register value.  Which of the two is it? [and: full-byte write]=0A=
=0A=
For the single supported configuration (1 Hz marker) the=0A=
PROG0 pulse-control value that produces the emitted marker corresponds to t=
he=0A=
50 percent duty the getter advertises, which is why one literal appears in=
=0A=
both roles; the v9 comment states this explicitly.  PROG0 in this mode is=
=0A=
wholly the pulse control byte, so the full-byte write does not clobber=0A=
unrelated fields; this was verified on hardware (SiT95317 evaluation board)=
=0A=
by checking the marker against the blob-programmed configuration.=0A=
=0A=
> could this byte be written inside the window sit9531x_output_freq_set()=
=0A=
> already opens?=0A=
=0A=
It could, and it is a good micro-optimisation, but merging the two=0A=
windows couples the esync path into the frequency helper's error handling f=
or=0A=
a saving of one commit cycle on a rare configuration operation.  We kept th=
e=0A=
operations separate for clarity; happy to revisit if the extra commit cycle=
=0A=
turns out to matter in practice.=0A=
=0A=
> The comment says this byte applies in SYSREF / SYNCB modes.  The new esyn=
c=0A=
> path does not select either mode, so does the write take effect at all [.=
..]?=0A=
=0A=
The outputs wired for esync on our reference board=0A=
are configured by the NVM blob into the mode where the pulse byte applies;=
=0A=
the driver's esync-control DT flag is what marks exactly those outputs, so=
=0A=
the path is only reachable where the write takes effect.  This is=0A=
bench-verified on the SiT95317 board.=0A=
