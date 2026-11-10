Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342400;
	b=hY6BtryD/U4mG8QjLnIqWR9jgH0tUQgufQtuwcwUabKltw2+OynwfgEVJfnHsZMHW2mS
	 DwNOuDfAbKxSzOkN0QeMVYxpR4jyFl+ZFXd4O4panixdPuTRF2xKG7vqwN2RNzLe5pBGP
	 ZTXhbKY4C4rGk+ir18pHCiv0U8psFjnEJBYgb83IZ0uyjvhfN0Etc10QFh3w267x0r38N
	 F97WaJkALJ/n0Ds3Iw1x2/6B07eipjl5KvIswQp/DyJxxvjT1xxdh9qAGd5G5NrOx6Y9P
	 FKgqzQ8y7sGv28K9Hi3YaThBmf1iFBSeyco8TcWIUWOr+aURU/5EzbizAvnKh1ed6kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342400;
	h=DMARC-Filter:DKIM-Signature:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-MDID:X-PPE-STACK:
	 X-MDID-O:X-PPE-TRUSTED;
	bh=F6IHkkP7aExJ77G8FTsAgEmNofcm1QHyqmwHRx/qPFs=;
	b=qWFoRkmsScAxXAcezMQ3ZlN0kkh9hRxOKE02SGSyJxwMiMZcaDdP65rHAjemanQXfsQG
	 rSfTZaVryAgxPg37zL/QwDKSeIebWdiXMaKB/VoZvsP0SnDsXJrlpipJecB43IjHOk7C8
	 nnJVshNrSyJKFrF2M9j+Xg0miHa8fcrpzAjFiXM9hTNb6KAbvirDXm8QEiSbjOtXgmOoU
	 fswMDFqJK/7oVBMblBNVJi7KJ8ugcJDRnX0NwJaYFe6vjrMPBe0IPZ3bceVahxNHFpMGN
	 47GOPLjbDB+BjVGDEylYMMKZTPjL+piNHFjkwszt3XjHyZY5M8SjYvaukfNwwyxpxIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=DWdwBkuX;
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=VuloOqlx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.48
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53B60A5BEB;
	Tue, 10 Nov 2026 20:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F53B60A5BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=DWdwBkuX;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=VuloOqlx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=F6IHkkP7aExJ77G8FTsAgEmNofcm1QHyqmwHRx/qPFs=;
 b=DWdwBkuXX/cKu5+6yoEq/URsP+Wo6098M5nw8hVAr6lD6DUVi6jxuJ3P1sJ1CHYoaH40YOHYVWleBj6Gn+GK3C+RKOHYAMUQ6v6Tsbpgb+zIs1Cg6cDfLSrdJQYn+oZ/Ev3anHGd26+9W4Okpxvfc8rE1xbF8svRigWIYWRKL12KtlFj8LRa6LgygsvEygghcPLyLspNhaGpAtMc/k599+K6+s2E9EtnBEID/jwXfm8Siyc1c/GOQlOSonIKmrXqMCjlUnnVPuXDxF0TEPk1wTDaR7d+LX9zzHCuorQSRX9kWPhO/gySTPjLagyWWjobFRdagr6k2XKpGdf2KDM9HA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021098.outbound.protection.outlook.com [52.101.62.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AA6D21C006C;
	Tue, 10 Nov 2026 20:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdyoG1Wk5th+lJ48ltEa2abnEpHFmga9OiCP4e6NTCw/cs40Xsv2b0tHols7OMc8M6ORs2sM6Pch8k/cr8RN3NRzovsngEvEW/GmzRckBih5/hrbHjsG3hIeVMMgYnTIp6SmnYpQz4yUlHPHojdyYmbnMwmNfqpge/XDDsidoapalspWuE0qDgC50ES8UqjW0jKzj/z08N5Dk2UsLhM+7m7udU6WPjkHY4nJvK+KE2jb2m5/KBkF50bZgTjW4MkG3Krc3p/x5WFXhLJqs98960HUQ5jI2PMXILxsoIMs+BYXqThfLwtCKeMnaN8ejplzoal2A9kV7wH/UkgMZkWMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6IHkkP7aExJ77G8FTsAgEmNofcm1QHyqmwHRx/qPFs=;
 b=xPpZT7qjkoLYKJd6J17mvXGafk6ZD7fMHupjZTZ6nFk/sro8uqACm55M/hi8qqXmk2ohTrsd7iQNaVyk0YUR2T4uuql5EKvLf2tI1FHRMkdSO7HOUx4+WK8MEuIVlUL3Xrhh4mRRRMOBjaxD+wGiLGCqY2SSjWvJCbHP7+lU4WXRhuwObhaIR5LcxY9A4CD4+sfA3Z4+3fabGuk9baBMvLpLYBtbPunrx8hEJ5upi6fdj0cw/j5i4FmcfCJrsRaBNRXlrOu0MCzniF/O0vddGK/gJWAVTU2hXMj0r/lcrTztdQf2BNIu3MBshiMTxX0jEAILCUB1IfaQ6OL+gwUnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6IHkkP7aExJ77G8FTsAgEmNofcm1QHyqmwHRx/qPFs=;
 b=VuloOqlxogLb2BRGm5bX6Spec7dslggmKIgEGpfabttAJUht5aqHofhY+NiyUpm2frSzyU1FF0Ac/nykmI4EdK3vK38LjVrLVA/ufzM3EbPuLCnE8eDnGZLmIZmfWH3XfH1X51GDSzgmiim4NaG3t0bn+8O/PWOrCydXwackNSbm+OV52CRswCj7fnIqD9x9kAALDdHbpcjz8bRPL/FlU41MMNPIRJ+uoMwj2V2QSTGkFMIAbzb0txfFoAy1q2oYPRR0QzrvidnhvC+qMF5I89akuNi13yZfTK6JpevYdLq9mdb2qwg5dA8yZpbxB7tlTEKnLNOyiBGmQhcgv9gA/g==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB6205.namprd20.prod.outlook.com
 (2603:10b6:510:295::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:25 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:25 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v15 13/13] dpll: sit9531x: model the inter-PLL sync
 line as a pair of pins
Thread-Topic: [PATCH net-next v15 13/13] dpll: sit9531x: model the inter-PLL
 sync line as a pair of pins
Thread-Index: AQHdcVG9xv2EBzUMZkmHEZXAAnqpcA==
Date: Tue, 10 Nov 2026 20:26:17 +0000
Message-ID: <20261110202607.55744-14-arouhi@sitime.com>
References: <20261110202607.55744-1-arouhi@sitime.com>
In-Reply-To: <20261110202607.55744-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB6205:EE_
x-ms-office365-filtering-correlation-id: 4c0b8af2-1c53-443d-4f82-08df3f68e48e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261022115727099003|3023799007|261026140227099003|261022075727099003|261026130827099003|261026135527099003|261026121527099003|261021133027099003|261021130227099003|261021135927099003|261028144727099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|10067099003|261022113327099003|261102123227099003|5023799004|56012099006|38070700021|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 V8TlHaqTSDzN6JSOgI/NS6YxMhAJfiKPDbj1lp0oOr+FY8Kg8iiafjGtgu5VcQbggLNUEm6yOlk9nJ+nteELOKI59IShhvRCSs8oVx3Pc02NLFE4FK99gj14K/F1DHYuqNGjekCyXHuniB+5kV/fIBq4SYQJ9hSjvkv9T6dH5V6Q3bfXzDC4GZVz3gzmc1GyGIxvRIFsw4SYae+vEE9WHYWRUg6L6TTh7J8S0qMBcd8dwi16xP+SsgSKQ06aoc4YYu7MCGmUb8oDTppj/z6XR3muXzvMCEAnvfiit80BJgMCkiKZe1PugQNmEXeIDeNHlt1niUxMHew1TTrKwgv7ueVUbIPtO1HEn+vg1vjfjqweocPeOcPZGMynoi1S3b+xsLh4rKPhuBlEGh5TfA4iIq82GdPOFuxLwzSAo3c0WiVUDRGga4Xt14Q/vDcFhuOtLxItWkst4IdAlKLk5eLN+cSKiNun3UQulW/2JgC2fpBahfgD8XTckM7l7Tq03bf+GkAila2u5CsjFClR7/pGoskB7bEU2vpEUbc8bVLoz/pjUrPQowVkf722Ak0ba/wYcI5aRx6ZrSTNq55UuaNyuvYToe6NoYirVSC9wocizEc/MMHtqcvKyF3vU2UePLT1AwWHHCL42PdiCatuD0Wr9UAiznPmqjerbo31NBUOU0lvR959WgKOTIF2MvtxwVDKRuMuf1Q1AP76Jekqdr0qsWS8567cLbjGu6Fh2fa6Rxo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261022115727099003)(3023799007)(261026140227099003)(261022075727099003)(261026130827099003)(261026135527099003)(261026121527099003)(261021133027099003)(261021130227099003)(261021135927099003)(261028144727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(261022113327099003)(261102123227099003)(5023799004)(56012099006)(38070700021)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1P5Azf5qeLqxkMn9nvNhvwJZY8XO/gFhcPOBgeAf80U7iHwxyj27qZYtAW?=
 =?iso-8859-1?Q?zA+tRO2+dCSudL6c1QR9FEISPfEZLR1+ERaSCMpYXd3rc6GGFQr98UtKXb?=
 =?iso-8859-1?Q?hYxNTHW6ZDvhC5R12/zykIl1bLGrbuhOPvq9CMNFI/DH46DopKnvev9gyq?=
 =?iso-8859-1?Q?8dFAQjgyYCAtzM11mBw7iWBvgYdYcmeeX+5S8sG+JbKwwJACjxH71ff2s4?=
 =?iso-8859-1?Q?jkNtluYJxjtmSjG+qqouCHERObxyIkarl/YmIcLQ/XzhDCBCtCK9mHRUqj?=
 =?iso-8859-1?Q?h6dOz8JJ8ZiG1tAmJECvBtAeMbMfEbUibhk6TozkUc38jg5/+NN+qYz6Kc?=
 =?iso-8859-1?Q?PNkXKVYsXeNcl4AjUzqz2zaWTemD7nbuhMxH4t4OyVO+XmIFHT6ghl/89l?=
 =?iso-8859-1?Q?BxuMzINKRnGkRD5nlCsMXFzx9qcyHKt048E7QbhBqRs+bp16/3KOZUzrkT?=
 =?iso-8859-1?Q?1MWsaReyu+UTuBpQ25pN1Oq6gIVBqg1LmjrC7MbiZhu0wTE39zGUUVuZgx?=
 =?iso-8859-1?Q?bB50x2RNHBGys8VdsqqYLcRijDeGThk61C1HtRf6zQ0cNOfemuON8PQJ8c?=
 =?iso-8859-1?Q?/iWDnOWZwIgaREdfTxPt+5MJwxCagwHJK5GvbH33mtZ/yzIzKe3sTR+K/e?=
 =?iso-8859-1?Q?om/9pCtLnjn3Q+XK/59BNu1gyHMh1hWPe8nBmSJOL3HmWhDTKDr6waFk4V?=
 =?iso-8859-1?Q?81cmQodoK6ZL69LuWyG+Mfr5snVvHgEUvUmPpBa95ZbMK92srjcfbBjp+B?=
 =?iso-8859-1?Q?FDQdHQWpYc36Jy96uMiRM7szLzMvlnZnt7QpCOz0EfDMdNIoh8zNHVkCpQ?=
 =?iso-8859-1?Q?nNB88H9mYvY1TztpsjlC7VNZvKcYCHuMnQivb1IjAj9OeYLBOSJt53Jrk0?=
 =?iso-8859-1?Q?TvOGXG1yeXNymVBcNoPF1Eu/zrYQZVrgMwZM2n8eErGol+9Ekx298Y1ekO?=
 =?iso-8859-1?Q?JOb94GJ80uBfQkga+jHOkHnUESQQk4qic27GMUnW2RQQXbjyWk3ZehRCUO?=
 =?iso-8859-1?Q?sL4FzR8mbB6HrYnfzOGT6cVnLVTCwwpJVoYa7aHc5VP+eAwuF5Tfvm2Mlx?=
 =?iso-8859-1?Q?QUE9amaA8G6h/FHxn88TQC+PjbWB4mwZbvjCaS2whH8D+ZyCzJitbqRp13?=
 =?iso-8859-1?Q?5D9uGd6ri69QHGnL1jVTyCF81yQiYu0KJpmO6kiVC2/tEPJ21sUI2NIq3D?=
 =?iso-8859-1?Q?u766GvL92x1iIdTVRVY05y1kmS34As9NPGpKH6MlXatyPpkxfyDlVEP1Wf?=
 =?iso-8859-1?Q?LN9QLb8wBHoaB5qAVLn4gHt/YEdYLGAK2HG45IfKLq+L7fjeaMvcTrTiXK?=
 =?iso-8859-1?Q?ghSGJ6zdJt5BRtvAYF0YicDLOS9tADZTesEmE/eJhYTpBt9Zwy6ba9NhJW?=
 =?iso-8859-1?Q?2GvAGqbdwGwx+uuReCGzlG8S6+pnOEYyvlZ2g3zkPj9qzXwxE3e0RIE/7n?=
 =?iso-8859-1?Q?WF/cBHaoqj0sBWAsa238a85j1t5ZbvlTlEW9NMgVuyHmEw24oafMrMHduA?=
 =?iso-8859-1?Q?aBDS9sqzXkcS4zFpfu0EZWQ8I2rjhiyONbPHye6fEtMY2W27mLwdDVbvai?=
 =?iso-8859-1?Q?tBwnEaarn91Ai4ni2Kmme8oHMNF+w+xSwPuBKhZZccEJx85qQz3wH8F1Hq?=
 =?iso-8859-1?Q?31xAhrf6k9y2qxtH0WIfC78VsAgVg+MB8SevZpxPOxR5WV8jpRgtFMQzkT?=
 =?iso-8859-1?Q?ygWn3TtGymsog06M6vkyIZQV2GU2HIiWYazm+dNvcIKFuisR8ODlmc7AbM?=
 =?iso-8859-1?Q?EHI6ylkZ6fbzfGJKW7VkGZABRc/QQ0LcYCcLvpqPsC8BUw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YWqKOre/LrZlXZT8n5ohK856LWJSXNrsTc35r4W9t0SAzG1aKIwhV9+q3QhbrXZubMEioXfX3gNA/twYDPy0dpixD3uLcxky6oB25IhRKTSOeH8Ajdk3hvEnF3ao6OunN4CkGZyXgKEc29hxxuaa9RwLQlgU3epGEQNflZkMTgqbGJHm0Dz5bposWLsMNQbLamm28S91/hh89EnQpYGRfxRRKxDnjYI5LJb+hcwfS6CwXNgEyxpeDt84D58SFEMxioygP5tt/Ykq5jz06Z6DOo9l05+ZRlT1dnTbqWLKdq1U5tNJjjgeXYn/OgTye4LiHQLC9QXgChxvgT9AImORjw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0b8af2-1c53-443d-4f82-08df3f68e48e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:17.4634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdXRIk2gvw0YuuF3CnEFuOmhEtXzRklpsKnv+y7E2zqiFG9UMhVaSHaTGvKT1Z367AIbB3+m5MFbskWMv8oFJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB6205
X-MDID: 1794342392-UK25TE9ygUgL
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1794342392;UK25TE9ygUgL;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The part has an internal line by which one PLL can drive the others as a=0A=
reference. Model it as two pins: an output pin on the source PLL, whose=0A=
state says whether it drives the line, and an input pin on each=0A=
destination, selectable like any input and reporting no signal while=0A=
no PLL drives the line.=0A=
=0A=
Taking the line writes a pattern to the source's EXT page and sets a=0A=
global enable; giving it up writes the disable pattern. The owner is=0A=
read back from the pages, and a line enabled from a page the driver does=0A=
not recognize, or from two pages, refuses every connect.=0A=
=0A=
Resume re-reads the line owner, the output mutes and the output delays,=0A=
which a profile reload may have changed.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 708 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |  32 ++=0A=
 drivers/dpll/sit9531x/dpll.c | 398 ++++++++++++++++++--=0A=
 drivers/dpll/sit9531x/regs.h |   3 +=0A=
 4 files changed, 1112 insertions(+), 29 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 8f305cc27737..e3ce7b6cad6b 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -857,6 +857,8 @@ static bool sit9531x_prio_src_live(const struct sit9531=
x_dev *sitdev, u8 src)=0A=
 {=0A=
 	u8 index =3D sit9531x_hw_src_input(src);=0A=
 =0A=
+	if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		return sit9531x_intsync_driven(sitdev);=0A=
 	if (index >=3D sitdev->info->num_inputs)=0A=
 		return true;=0A=
 =0A=
@@ -1091,6 +1093,18 @@ static u8 sit9531x_prio_activesel_pick(struct sit953=
1x_dev *sitdev,=0A=
 	return srcs[0];=0A=
 }=0A=
 =0A=
+static bool sit9531x_prio_table_lists_intsync(const u8 *srcs)=0A=
+{=0A=
+	u8 slot;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)=0A=
+		if ((srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK) =3D=3D=0A=
+		    SIT9531X_PRIO_SRC_INTSYNC)=0A=
+			return true;=0A=
+=0A=
+	return false;=0A=
+}=0A=
+=0A=
 static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
 				      const u8 *srcs)=0A=
 {=0A=
@@ -1107,6 +1121,11 @@ static int sit9531x_prio_table_commit(struct sit9531=
x_dev *sitdev, u8 pll_idx,=0A=
 		if (sit9531x_prio_src_usable(srcs[slot]))=0A=
 			empty =3D false;=0A=
 =0A=
+	if (sitdev->intsync_stale &&=0A=
+	    (sit9531x_prio_table_lists_intsync(srcs) ||=0A=
+	     sit9531x_prio_table_lists_intsync(chan->prio_srcs)))=0A=
+		sit9531x_intsync_refresh(sitdev);=0A=
+=0A=
 	memcpy(back, chan->table_pending ? chan->table_back : chan->prio_srcs,=0A=
 	       sizeof(back));=0A=
 =0A=
@@ -2585,6 +2604,556 @@ static int sit9531x_clear_notifications(struct sit9=
531x_dev *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Close the debug window on a PLL's EXT page; the key opens every debug=
=0A=
+ * register on the page while it holds the unlock value.=0A=
+ */=0A=
+static int sit9531x_intsync_debug_lock(struct sit9531x_dev *sitdev, u8 ext=
_page)=0A=
+{=0A=
+	return sit9531x_write_close(sitdev,=0A=
+				    SIT9531X_REG(ext_page,=0A=
+						 SIT9531X_PLL_REG_DEBUG),=0A=
+				    SIT9531X_PLL_DEBUG_LOCK);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Values written to the source PLL's EXT page to enable or disable INTSYN=
C,=0A=
+ * which locks the frequency PLL to the phase PLL.=0A=
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
+/*=0A=
+ * Find the PLL whose EXT page holds the INTSYNC enable pattern, whole or =
in=0A=
+ * part. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	s8 src =3D -1, partial =3D -1;=0A=
+	int rc, ret, n_en, n_dis;=0A=
+	u8 pll, ext_page;=0A=
+	u8 n_pages =3D 0;=0A=
+	unsigned int i;=0A=
+	bool enabled;=0A=
+	u8 global;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &global);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	enabled =3D global & BIT(SIT9531X_INTSYNC_EN_BIT);=0A=
+=0A=
+	/*=0A=
+	 * Read the EXT pages even with the global enable clear; a page can hold=
=0A=
+	 * the enable pattern under a clear bit.=0A=
+	 */=0A=
+	for (pll =3D 0; pll < SIT9531X_NUM_PLLS; pll++) {=0A=
+		ext_page =3D SIT9531X_PLL_EXT_PAGE(pll);=0A=
+=0A=
+		/*=0A=
+		 * Open the EXT page's debug window to read the INTSYNC=0A=
+		 * registers.=0A=
+		 */=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    SIT9531X_PLL_REG_DEBUG),=0A=
+				       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+		if (rc) {=0A=
+			sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+			return rc;=0A=
+		}=0A=
+=0A=
+		n_en =3D 0;=0A=
+		n_dis =3D 0;=0A=
+		for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+			u16 reg;=0A=
+			u8 val;=0A=
+=0A=
+			reg =3D SIT9531X_REG(ext_page, intsync_config[i].offset);=0A=
+=0A=
+			rc =3D sit9531x_read_u8(sitdev, reg, &val);=0A=
+			if (rc)=0A=
+				break;=0A=
+			if (val =3D=3D intsync_config[i].en_val)=0A=
+				n_en++;=0A=
+			else if (val =3D=3D intsync_config[i].dis_val)=0A=
+				n_dis++;=0A=
+		}=0A=
+=0A=
+		ret =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+		if (!rc)=0A=
+			rc =3D ret;=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		/*=0A=
+		 * A page with the disable pattern or with other values is not a=0A=
+		 * source.=0A=
+		 */=0A=
+		if (!n_en || n_en + n_dis !=3D ARRAY_SIZE(intsync_config))=0A=
+			continue;=0A=
+		n_pages++;=0A=
+=0A=
+		if (n_dis || !enabled) {=0A=
+			/*=0A=
+			 * A page holding both patterns, or the whole enable=0A=
+			 * pattern under a clear global enable, does not drive=0A=
+			 * the line.=0A=
+			 */=0A=
+			if (partial < 0)=0A=
+				partial =3D pll;=0A=
+			continue;=0A=
+		}=0A=
+=0A=
+		if (src < 0)=0A=
+			src =3D pll;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Record a PLL with a partial pattern, though it does not drive the=0A=
+	 * line, so that no other PLL is enabled alongside it.=0A=
+	 */=0A=
+	sitdev->intsync_partial =3D src < 0 && partial >=3D 0;=0A=
+	if (sitdev->intsync_partial) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "PLL%c holds an INTSYNC source configuration that does not drive the l=
ine\n",=0A=
+			 'A' + partial);=0A=
+		src =3D partial;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * With more than one page holding the pattern, refuse every connect; an=
=0A=
+	 * enable on one would also set the global enable over the other.=0A=
+	 */=0A=
+	sitdev->intsync_conflict =3D n_pages > 1;=0A=
+	if (sitdev->intsync_conflict)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "%u PLLs hold the INTSYNC source pattern; recording PLL%c\n",=0A=
+			 n_pages, 'A' + src);=0A=
+=0A=
+	sitdev->intsync_src =3D src;=0A=
+	sitdev->intsync_foreign =3D enabled && src < 0;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/**=0A=
+ * sit9531x_intsync_readback - re-read the sync source record from the par=
t=0A=
+ * @sitdev: device pointer=0A=
+ *=0A=
+ * A page reads the same latched or not, so a recorded partial source is k=
ept=0A=
+ * unless the scan resolves it. Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on a read error=0A=
+ */=0A=
+int sit9531x_intsync_readback(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	bool partial =3D sitdev->intsync_partial;=0A=
+	s8 src =3D sitdev->intsync_src;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	if (partial && (sitdev->intsync_src < 0 ||=0A=
+			(sitdev->intsync_src =3D=3D src &&=0A=
+			 !sitdev->intsync_partial))) {=0A=
+		sitdev->intsync_src =3D src;=0A=
+		sitdev->intsync_partial =3D true;=0A=
+		sitdev->intsync_foreign =3D false;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/**=0A=
+ * sit9531x_intsync_refresh - re-read a stale sync source record=0A=
+ * @sitdev: device pointer=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 when the record is current, <0 when the scan fails=0A=
+ */=0A=
+int sit9531x_intsync_refresh(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	s8 owner;=0A=
+	int rc;=0A=
+=0A=
+	if (!sitdev->intsync_stale)=0A=
+		return 0;=0A=
+=0A=
+	owner =3D sit9531x_intsync_owner(sitdev);=0A=
+	rc =3D sit9531x_intsync_readback(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	sitdev->intsync_stale =3D false;=0A=
+	if (owner !=3D sit9531x_intsync_owner(sitdev))=0A=
+		sitdev->intsync_ntf_pending =3D true;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Check if the inter-PLL sync line carries a signal, from the recorded so=
urce=0A=
+ * or a PLL locked to the line. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+bool sit9531x_intsync_driven(const struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+	u8 pll;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (sitdev->intsync_src >=3D 0 && !sitdev->intsync_partial &&=0A=
+	    !sitdev->intsync_stale)=0A=
+		return true;=0A=
+=0A=
+	for (pll =3D 0; pll < SIT9531X_NUM_PLLS; pll++) {=0A=
+		chan =3D sit9531x_chan_state_get(sitdev, pll);=0A=
+		if (chan->routed_ref =3D=3D SIT9531X_INTSYNC_PIN_ID &&=0A=
+		    chan->locked && !chan->ho_freeze &&=0A=
+		    !chan->stale && !chan->intsync_dropped)=0A=
+			return true;=0A=
+	}=0A=
+=0A=
+	return false;=0A=
+}=0A=
+=0A=
+static int __sit9531x_intsync_disable(struct sit9531x_dev *sitdev,=0A=
+				      u8 src_pll_idx, bool restore,=0A=
+				      bool *owner_kept, bool *touched);=0A=
+=0A=
+/*=0A=
+ * Set the global enable and latch the INTSYNC source pattern into the PLL=
's EXT=0A=
+ * page. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx,=
=0A=
+			    bool *rollback_failed, bool *touched)=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, lock_rc;=0A=
+	unsigned int i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rollback_failed)=0A=
+		*rollback_failed =3D false;=0A=
+	if (touched)=0A=
+		*touched =3D false;=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (touched)=0A=
+		*touched =3D true;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val | BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		goto err_disable;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	usleep_range(1000, 2000);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
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
+	rc =3D sit9531x_pll_small_update(sitdev, src_pll_idx);=0A=
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
+	lock_rc =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	if (lock_rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "PLL%c: INTSYNC enabled but the debug window was left open: %d\n",=0A=
+			 'A' + src_pll_idx, lock_rc);=0A=
+=0A=
+	return rc;=0A=
+=0A=
+err_disable:=0A=
+	{=0A=
+		int rollback_rc;=0A=
+=0A=
+		rollback_rc =3D __sit9531x_intsync_disable(sitdev, src_pll_idx,=0A=
+							 false, NULL, NULL);=0A=
+		if (rollback_rc) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "INTSYNC rollback failed after enable error: %d (original %d)\n",=0A=
+				 rollback_rc, rc);=0A=
+			if (rollback_failed)=0A=
+				*rollback_failed =3D true;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Check if every INTSYNC register of an EXT page holds its disable value.=
 The=0A=
+ * page's debug window must be open.=0A=
+ */=0A=
+static int sit9531x_intsync_page_off(struct sit9531x_dev *sitdev,=0A=
+				     u8 ext_page, bool *off)=0A=
+{=0A=
+	unsigned int i;=0A=
+	u8 val;=0A=
+	int rc;=0A=
+=0A=
+	*off =3D false;=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      SIT9531X_REG(ext_page,=0A=
+						   intsync_config[i].offset),=0A=
+				      &val);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (val !=3D intsync_config[i].dis_val)=0A=
+			return 0;=0A=
+	}=0A=
+	*off =3D true;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int __sit9531x_intsync_disable(struct sit9531x_dev *sitdev,=0A=
+				      u8 src_pll_idx, bool restore,=0A=
+				      bool *owner_kept, bool *touched)=0A=
+{=0A=
+	bool in_window =3D false, was_enabled;=0A=
+	u8 ext_page, val;=0A=
+	int rc, lock_rc;=0A=
+	unsigned int i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (owner_kept)=0A=
+		*owner_kept =3D false;=0A=
+	if (touched)=0A=
+		*touched =3D false;=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	was_enabled =3D val & BIT(SIT9531X_INTSYNC_EN_BIT);=0A=
+	if (touched)=0A=
+		*touched =3D true;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val & ~BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+	/* A sample taken before this write can still show a lock. */=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++)=0A=
+		if (sitdev->chan[i].routed_ref =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+			sitdev->chan[i].intsync_dropped =3D true;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	usleep_range(1000, 2000);=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev,=0A=
+			       SIT9531X_REG(ext_page,=0A=
+					    SIT9531X_PLL_REG_DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+	in_window =3D true;=0A=
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
+	rc =3D sit9531x_pll_small_update(sitdev, src_pll_idx);=0A=
+	if (rc && owner_kept)=0A=
+		*owner_kept =3D true;=0A=
+=0A=
+	goto relock;=0A=
+=0A=
+restore_global:=0A=
+	/*=0A=
+	 * Restore the global enable, or finish the disable if the page holds=0A=
+	 * the disable pattern.=0A=
+	 */=0A=
+	if (restore && in_window) {=0A=
+		bool off;=0A=
+=0A=
+		if (sit9531x_intsync_page_off(sitdev, ext_page, &off)) {=0A=
+			if (owner_kept)=0A=
+				*owner_kept =3D true;=0A=
+		} else if (off) {=0A=
+			rc =3D sit9531x_pll_small_update(sitdev, src_pll_idx);=0A=
+			if (rc && owner_kept)=0A=
+				*owner_kept =3D true;=0A=
+			goto relock;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if (restore && was_enabled) {=0A=
+		int ret;=0A=
+=0A=
+		ret =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+				       &val);=0A=
+		if (!ret)=0A=
+			ret =3D sit9531x_write_u8(sitdev,=0A=
+						SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+						val |=0A=
+						BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+		if (!ret) {=0A=
+			/* The page-0 small update applies the global enable */=0A=
+			ret =3D sit9531x_write_close(sitdev,=0A=
+						   SIT9531X_REG_GLOBAL_UPDATE,=0A=
+						   SIT9531X_SMALL_UPDATE_CMD);=0A=
+			usleep_range(1000, 2000);=0A=
+		}=0A=
+		if (ret) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c: INTSYNC enable not put back after a failed disable: %d\n",=0A=
+				 'A' + src_pll_idx, ret);=0A=
+			if (owner_kept)=0A=
+				*owner_kept =3D true;=0A=
+		}=0A=
+	}=0A=
+=0A=
+relock:=0A=
+	lock_rc =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	if (lock_rc) {=0A=
+		if (rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c: debug window left open: %d\n",=0A=
+				 'A' + src_pll_idx, lock_rc);=0A=
+		else=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c: INTSYNC disabled but the debug window was left open: %d\n",=
=0A=
+				 'A' + src_pll_idx, lock_rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Clear the global enable and latch the INTSYNC disable pattern into the =
PLL's=0A=
+ * EXT page. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx,=
=0A=
+			     bool *owner_kept, bool *touched)=0A=
+{=0A=
+	return __sit9531x_intsync_disable(sitdev, src_pll_idx, true,=0A=
+					  owner_kept, touched);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Notify the output pins in @outs and, when @src, the INTSYNC source pin.=
 Call=0A=
+ * without multiop_lock: the notification takes the subsystem locks, which=
 are=0A=
+ * taken before multiop_lock.=0A=
+ */=0A=
+static void sit9531x_drive_pins_ntf(struct sit9531x_dev *sitdev, u16 outs,=
=0A=
+				    bool src)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+	struct sit9531x_dpll_pin *pin;=0A=
+	struct dpll_pin *dpll_pin;=0A=
+	int rc;=0A=
+=0A=
+	if (!outs && !src)=0A=
+		return;=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
+		list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
+			if (pin->dir !=3D DPLL_PIN_DIRECTION_OUTPUT)=0A=
+				continue;=0A=
+			if (pin->id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID ?=0A=
+			    !src : !(outs & BIT(pin->id)))=0A=
+				continue;=0A=
+			dpll_pin =3D READ_ONCE(pin->dpll_pin);=0A=
+			if (!dpll_pin)=0A=
+				continue;=0A=
+			rc =3D dpll_pin_change_ntf(dpll_pin);=0A=
+			/*=0A=
+			 * The source pin is one pin registered on every DPLL.=0A=
+			 */=0A=
+			if (pin->id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+				src =3D false;=0A=
+			if (!rc)=0A=
+				continue;=0A=
+			mutex_lock(&sitdev->multiop_lock);=0A=
+			if (pin->id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+				sitdev->intsync_ntf_pending =3D true;=0A=
+			else=0A=
+				sitdev->out[pin->id].ntf_pending =3D true;=0A=
+			mutex_unlock(&sitdev->multiop_lock);=0A=
+		}=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Re-read a stale sync source record; return true when a source pin=0A=
+ * notification is pending. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static bool sit9531x_intsync_stale_retry(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	if (sit9531x_intsync_refresh(sitdev))=0A=
+		return false;=0A=
+=0A=
+	if (!sitdev->intsync_ntf_pending)=0A=
+		return false;=0A=
+	sitdev->intsync_ntf_pending =3D false;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
 /**=0A=
  * sit9531x_phase_offset_read - read phase difference via TDC=0A=
  * @sitdev: device pointer=0A=
@@ -3022,6 +3591,7 @@ static int sit9531x_chan_state_fetch(struct sit9531x_=
dev *sitdev, u8 pll_idx)=0A=
 	chan->ho_freeze =3D !!(ho_freeze & BIT(pll_idx));=0A=
 	chan->ho_valid =3D !!(pll_status_1 & SIT9531X_PLL_STATUS_1_HO_VALID);=0A=
 	chan->stale =3D false;=0A=
+	chan->intsync_dropped =3D false;=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -3197,6 +3767,15 @@ static int sit9531x_dev_state_fetch(struct sit9531x_=
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
 		bool beyond;=0A=
 		s64 phase_ps;=0A=
@@ -3522,6 +4101,7 @@ static void sit9531x_dev_periodic_work(struct kthread=
_work *work)=0A=
 	struct sit9531x_dev *sitdev =3D container_of(work, struct sit9531x_dev,=
=0A=
 						   work.work);=0A=
 	struct sit9531x_dpll *sitdpll;=0A=
+	bool src_moved;=0A=
 	bool answered;=0A=
 	int rc;=0A=
 =0A=
@@ -3531,16 +4111,16 @@ static void sit9531x_dev_periodic_work(struct kthre=
ad_work *work)=0A=
 	 */=0A=
 	mutex_lock(&sitdev->multiop_lock);=0A=
 	answered =3D sit9531x_dev_ref_states_update(sitdev);=0A=
+	src_moved =3D sit9531x_intsync_stale_retry(sitdev);=0A=
 	answered |=3D sit9531x_dev_chan_states_update(sitdev);=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
 =0A=
 	list_for_each_entry(sitdpll, &sitdev->dplls, list)=0A=
 		sit9531x_dpll_changes_check(sitdpll);=0A=
+	/* The source pin is not a selection pin; the walk above skips it. */=0A=
+	sit9531x_drive_pins_ntf(sitdev, 0, src_moved);=0A=
 =0A=
-	/*=0A=
-	 * Clear the W1C notification latches on pages 0 and 6 after acting on=0A=
-	 * them; while set they keep INTRB asserted.=0A=
-	 */=0A=
+	/* The latches are W1C; left set, they keep INTRB asserted. */=0A=
 	mutex_lock(&sitdev->multiop_lock);=0A=
 	rc =3D sit9531x_clear_notifications(sitdev);=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
@@ -4015,13 +4595,13 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
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
@@ -4420,12 +5000,128 @@ static int sit9531x_suspend(struct device *dev)=0A=
 static int sit9531x_resume(struct device *dev)=0A=
 {=0A=
 	struct sit9531x_dev *sitdev =3D dev_get_drvdata(dev);=0A=
+	u16 outs_was =3D 0, outs_now =3D 0, outs_unread =3D 0, outs_moved =3D 0;=
=0A=
+	bool src_moved;=0A=
+	s8 owner;=0A=
+	int rc;=0A=
+	u8 i;=0A=
 =0A=
 	/* After power loss the part is on page 0, not the cached page */=0A=
 	sit9531x_page_cache_drop(sitdev);=0A=
+=0A=
+	/*=0A=
+	 * A part that lost power returns with its profile's INTSYNC routing and=
=0A=
+	 * output mutes, which the poll does not read; read them back. Arm one=0A=
+	 * re-select for a source lost and restored between samples.=0A=
+	 */=0A=
 	mutex_lock(&sitdev->multiop_lock);=0A=
 	sit9531x_reselect_arm(sitdev);=0A=
+	/*=0A=
+	 * Drop and report writes pending from before suspend: a reloaded=0A=
+	 * profile may have replaced their registers.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		struct sit9531x_chan *chan =3D &sitdev->chan[i];=0A=
+		bool retime =3D false;=0A=
+		u8 j, ho;=0A=
+=0A=
+		/*=0A=
+		 * A table write-back is pending only under forced holdover;=0A=
+		 * once that is cleared, the next poll reads the table from the=0A=
+		 * registers.=0A=
+		 */=0A=
+		if ((chan->table_pending || chan->ho_release_pending) &&=0A=
+		    !sit9531x_read_pll_u8(sitdev, i, SIT9531X_PLL_REG_HO_CTRL,=0A=
+					  &ho) &&=0A=
+		    !(ho & BIT(SIT9531X_PLL_HO_FORCE_BIT))) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c: forced holdover cleared over suspend, priority table restore =
dropped\n",=0A=
+				 'A' + i);=0A=
+			chan->table_pending =3D false;=0A=
+			chan->ho_release_pending =3D false;=0A=
+		}=0A=
+=0A=
+		for (j =3D 0; j < sitdev->info->num_outputs; j++) {=0A=
+			if (!sitdev->out[j].retime_pending ||=0A=
+			    sitdev->out[j].pll_idx !=3D i)=0A=
+				continue;=0A=
+			sitdev->out[j].retime_pending =3D false;=0A=
+			retime =3D true;=0A=
+		}=0A=
+		if (!retime && !chan->flush_pending &&=0A=
+		    !(sitdev->flush_arm_pending & BIT(i)))=0A=
+			continue;=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "PLL%c: pending before suspend, dropped:%s%s%s\n",=0A=
+			 'A' + i, retime ? " delay re-time" : "",=0A=
+			 chan->flush_pending ? " output realignment" : "",=0A=
+			 (sitdev->flush_arm_pending & BIT(i)) ?=0A=
+			 " on-demand flush enable" : "");=0A=
+		chan->flush_pending =3D false;=0A=
+		sitdev->flush_arm_pending &=3D ~BIT(i);=0A=
+	}=0A=
+	if (sitdev->flush_ctrl_pending) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "flush trigger source select pending before suspend, dropped\n");=0A=
+		sitdev->flush_ctrl_pending =3D false;=0A=
+	}=0A=
+	owner =3D sit9531x_intsync_owner(sitdev);=0A=
+	/*=0A=
+	 * The delay registers are reloaded with the profile too; read them back=
=0A=
+	 * as probe does.=0A=
+	 */=0A=
+	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		struct sit9531x_out *out =3D &sitdev->out[i];=0A=
+		bool beyond;=0A=
+		s64 phase_ps;=0A=
+=0A=
+		if (!out->routed)=0A=
+			continue;=0A=
+		rc =3D sit9531x_output_phase_read(sitdev, i, &phase_ps,=0A=
+						&beyond);=0A=
+		if (rc) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Output %u delay not read on resume: %d\n",=0A=
+				 i, rc);=0A=
+			out->phase_stale =3D true;=0A=
+			outs_unread |=3D BIT(i);=0A=
+			continue;=0A=
+		}=0A=
+		if (out->phase_adj !=3D phase_ps || out->phase_stale)=0A=
+			outs_moved |=3D BIT(i);=0A=
+		out->phase_adj =3D phase_ps;=0A=
+		out->phase_armed =3D !beyond && phase_ps;=0A=
+		out->phase_stale =3D false;=0A=
+	}=0A=
+	rc =3D sit9531x_intsync_readback(sitdev);=0A=
+	if (rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "INTSYNC source not re-detected on resume: %d\n", rc);=0A=
+	sitdev->intsync_stale =3D rc !=3D 0;=0A=
+	src_moved =3D rc || owner !=3D sit9531x_intsync_owner(sitdev);=0A=
+	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		if (sitdev->out[i].enabled)=0A=
+			outs_was |=3D BIT(i);=0A=
+		/* The mute state of a request left unconfirmed is unknown */=0A=
+		if (sitdev->out[i].state_stale)=0A=
+			outs_unread |=3D BIT(i);=0A=
+		rc =3D sit9531x_output_state_refresh(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Output %u mute state not read on resume: %d\n",=0A=
+				 i, rc);=0A=
+			sitdev->out[i].state_stale =3D true;=0A=
+			outs_unread |=3D BIT(i);=0A=
+		}=0A=
+		if (sitdev->out[i].enabled)=0A=
+			outs_now |=3D BIT(i);=0A=
+	}=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	sit9531x_drive_pins_ntf(sitdev,=0A=
+				(outs_was ^ outs_now) | outs_unread |=0A=
+				outs_moved, src_moved);=0A=
+=0A=
 	if (sitdev->irq > 0)=0A=
 		enable_irq(sitdev->irq);=0A=
 	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 8718c463c560..7dc78ddb18e5 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -142,6 +142,8 @@ struct sit9531x_out {=0A=
  * @locked: PLL is active and its outer loop reports lock=0A=
  * @stale: last state read failed; the fields hold the previous sample and=
=0A=
  *   are not reported=0A=
+ * @intsync_dropped: driver turned INTSYNC off after this sample; a lock t=
o=0A=
+ *   INTSYNC in it is not trusted=0A=
  * @mode: 0 =3D sync (outer loop enabled), 1 =3D free-run=0A=
  * @routed_ref: input the device routes to the PLL, as a logical index=0A=
  *   (INTSYNC: SIT9531X_INTSYNC_PIN_ID); SIT9531X_REF_INVALID if none=0A=
@@ -184,6 +186,7 @@ struct sit9531x_chan {=0A=
 	bool		active;=0A=
 	bool		locked;=0A=
 	bool		stale;=0A=
+	bool		intsync_dropped;=0A=
 	u8		mode;=0A=
 	u8		routed_ref;=0A=
 	bool		inner_lol;=0A=
@@ -233,6 +236,12 @@ struct sit9531x_chan {=0A=
  * @reset_gpio: optional reset line, NULL if absent=0A=
  * @irq: optional INTRB IRQ, 0 if not wired=0A=
  * @intsync_src: PLL sourcing INTSYNC, or -1=0A=
+ * @intsync_partial: @intsync_src has a partial source configuration or th=
e=0A=
+ *   global enable clear; not driving=0A=
+ * @intsync_conflict: more than one PLL page holds the source pattern=0A=
+ * @intsync_foreign: global enable set with no page holding the pattern=0A=
+ * @intsync_stale: @intsync_src must be read back before use=0A=
+ * @intsync_ntf_pending: the poll must send a source pin notification=0A=
  * @irq_ack_fails: consecutive failed INTRB acknowledgements=0A=
  * @fvco_band_warned: bit per PLL warned for Fref * DIVN outside its VCO=
=0A=
  *   band; written under @multiop_lock=0A=
@@ -270,6 +279,11 @@ struct sit9531x_dev {=0A=
 	int			irq;=0A=
 =0A=
 	s8			intsync_src;=0A=
+	bool			intsync_partial;=0A=
+	bool			intsync_conflict;=0A=
+	bool			intsync_foreign;=0A=
+	bool			intsync_stale;=0A=
+	bool			intsync_ntf_pending;=0A=
 =0A=
 	bool			loops_open;=0A=
 	bool			flush_ctrl_pending;=0A=
@@ -318,6 +332,24 @@ int sit9531x_output_phase_read(struct sit9531x_dev *si=
tdev, u8 out_idx,=0A=
 int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
 				     u8 out_idx, s32 phase_ps);=0A=
 =0A=
+/*=0A=
+ * Return the PLL driving INTSYNC with a complete source configuration, or=
 -1.=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static inline s8 sit9531x_intsync_owner(const struct sit9531x_dev *sitdev)=
=0A=
+{=0A=
+	return sitdev->intsync_partial ? -1 : sitdev->intsync_src;=0A=
+}=0A=
+=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx,=
=0A=
+			    bool *rollback_failed, bool *touched);=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx,=
=0A=
+			     bool *owner_kept, bool *touched);=0A=
+int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev);=0A=
+int sit9531x_intsync_readback(struct sit9531x_dev *sitdev);=0A=
+int sit9531x_intsync_refresh(struct sit9531x_dev *sitdev);=0A=
+bool sit9531x_intsync_driven(const struct sit9531x_dev *sitdev);=0A=
+=0A=
 int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
 				  u8 *ref);=0A=
 int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev);=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index ba4ac5e7d365..1bd2b962cdab 100644=0A=
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
@@ -177,16 +191,18 @@ const struct dpll_device_ops sit9531x_dpll_device_ops=
 =3D {=0A=
 };=0A=
 =0A=
 /*=0A=
- * Pin-state contract. An input is SELECTABLE while listed in this PLL's=
=0A=
- * priority table and DISCONNECTED otherwise; CONNECTED is refused because=
 the=0A=
- * device selects by priority. Operstate is ACTIVE when the device feeds t=
he PLL=0A=
- * this input (chan->routed_ref), the PLL is tracking and the lane has sig=
nal;=0A=
- * NO_SIGNAL on loss of signal; QUAL_FAILED on frequency drift; STANDBY=0A=
- * otherwise. The routed reference is used because on loss of signal the d=
evice=0A=
- * falls back to another listed source and leaves the selection naming the=
 lost=0A=
- * one. On manual input select, the routed input is CONNECTED. An output i=
s=0A=
- * CONNECTED while driven and DISCONNECTED while muted; SELECTABLE is refu=
sed.=0A=
- * The XO pin is always CONNECTED.=0A=
+ * Pin-state contract. An input or the INTSYNC destination is SELECTABLE w=
hile=0A=
+ * listed in this PLL's priority table and DISCONNECTED otherwise; CONNECT=
ED is=0A=
+ * refused because the device selects by priority. Operstate is ACTIVE whe=
n the=0A=
+ * device feeds the PLL this source (chan->routed_ref), the PLL is trackin=
g and=0A=
+ * the lane has signal; NO_SIGNAL on loss of signal; QUAL_FAILED on freque=
ncy=0A=
+ * drift; STANDBY otherwise. The routed reference is used because on loss =
of=0A=
+ * signal the device falls back to another listed source and leaves the=0A=
+ * selection naming the lost one. On manual input select, the routed input=
 is=0A=
+ * CONNECTED. The INTSYNC destination has signal while the driver's record=
 shows=0A=
+ * a PLL driving the line. An output or the INTSYNC source is CONNECTED wh=
ile=0A=
+ * driven and DISCONNECTED otherwise; SELECTABLE is refused. The XO pin is=
=0A=
+ * always CONNECTED.=0A=
  */=0A=
 =0A=
 /* Caller must hold sitdev->multiop_lock. */=0A=
@@ -215,6 +231,22 @@ sit9531x_dpll_selection_state_get(struct sit9531x_dev =
*sitdev,=0A=
 		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * For INTSYNC, use the driver's record of a PLL driving or locked to the =
line=0A=
+ * in place of the LOS monitor. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dpll_selection_no_signal(struct sit9531x_dev *sitdev, u8 pin_id)=
=0A=
+{=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pin_id =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		return !sit9531x_intsync_driven(sitdev);=0A=
+=0A=
+	return pin_id < sitdev->info->num_inputs &&=0A=
+	       sit9531x_ref_state_get(sitdev, pin_id)->los;=0A=
+}=0A=
+=0A=
 /* Caller must hold sitdev->multiop_lock. */=0A=
 static bool=0A=
 sit9531x_dpll_selection_active(struct sit9531x_dev *sitdev,=0A=
@@ -229,12 +261,7 @@ sit9531x_dpll_selection_active(struct sit9531x_dev *si=
tdev,=0A=
 	if (chan->routed_ref !=3D pin_id || !sit9531x_chan_tracking(chan))=0A=
 		return false;=0A=
 =0A=
-	/*=0A=
-	 * Do not report a lane without signal as locked, whatever the lock bit=
=0A=
-	 * says; the PLL is about to switch away from it.=0A=
-	 */=0A=
-	if (pin_id < sitdev->info->num_inputs &&=0A=
-	    sit9531x_ref_state_get(sitdev, pin_id)->los)=0A=
+	if (sit9531x_dpll_selection_no_signal(sitdev, pin_id))=0A=
 		return false;=0A=
 =0A=
 	return true;=0A=
@@ -256,12 +283,13 @@ sit9531x_dpll_selection_operstate_get(struct sit9531x=
_dev *sitdev,=0A=
 		return;=0A=
 	}=0A=
 =0A=
+	if (sit9531x_dpll_selection_no_signal(sitdev, pin_id)) {=0A=
+		*operstate =3D DPLL_PIN_OPERSTATE_NO_SIGNAL;=0A=
+		return;=0A=
+	}=0A=
+=0A=
 	if (pin_id < sitdev->info->num_inputs) {=0A=
 		ref =3D sit9531x_ref_state_get(sitdev, pin_id);=0A=
-		if (ref->los) {=0A=
-			*operstate =3D DPLL_PIN_OPERSTATE_NO_SIGNAL;=0A=
-			return;=0A=
-		}=0A=
 		if (ref->qual_fail) {=0A=
 			*operstate =3D DPLL_PIN_OPERSTATE_QUAL_FAILED;=0A=
 			return;=0A=
@@ -587,8 +615,7 @@ sit9531x_dpll_input_pin_phase_offset_get(const struct d=
pll_pin *pin,=0A=
 				       "Failed to read the input clock monitors");=0A=
 			return rc;=0A=
 		}=0A=
-		if (dpin->id < sitdev->info->num_inputs &&=0A=
-		    sit9531x_ref_state_get(sitdev, dpin->id)->los)=0A=
+		if (sit9531x_dpll_selection_no_signal(sitdev, dpin->id))=0A=
 			rc =3D -ENODATA;=0A=
 	}=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
@@ -662,6 +689,325 @@ sit9531x_dpll_output_pin_direction_get(const struct d=
pll_pin *pin,=0A=
 				       enum dpll_pin_direction *direction,=0A=
 				       struct netlink_ext_ack *extack);=0A=
 =0A=
+/* Caller must hold sitdev->multiop_lock. */=0A=
+static bool=0A=
+sit9531x_dpll_intsync_src_connected(const struct sit9531x_dev *sitdev,=0A=
+				    const struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	return sitdev->intsync_src =3D=3D sitdpll->id && !sitdev->intsync_partial=
;=0A=
+}=0A=
+=0A=
+/* Caller must hold sitdev->multiop_lock. */=0A=
+static int sit9531x_dpll_intsync_refresh(struct sit9531x_dev *sitdev,=0A=
+					 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_intsync_refresh(sitdev);=0A=
+	if (rc)=0A=
+		NL_SET_ERR_MSG(extack, "INTSYNC source could not be read back");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
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
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_dpll_intsync_refresh(sitdev, extack);=0A=
+	if (rc) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return rc;=0A=
+	}=0A=
+	if (sit9531x_dpll_intsync_src_connected(sitdev, sitdpll))=0A=
+		*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Driving the line is an explicit routing, not a selection candidate, so=
=0A=
+ * SELECTABLE is refused.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_src_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	bool was_connected, moved, owner_kept =3D false;=0A=
+	int rc =3D 0, detect_rc =3D 0;=0A=
+	bool changed =3D false;=0A=
+	u8 hw_src;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_dpll_intsync_refresh(sitdev, extack);=0A=
+	if (rc) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return rc;=0A=
+	}=0A=
+	was_connected =3D sit9531x_dpll_intsync_src_connected(sitdev, sitdpll);=
=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		if (was_connected)=0A=
+			break;=0A=
+		if (sitdev->intsync_src >=3D 0 &&=0A=
+		    sitdev->intsync_src !=3D sitdpll->id) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "INTSYNC is already sourced by another PLL");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		/*=0A=
+		 * The enable drives the line from every page holding the source=0A=
+		 * pattern.=0A=
+		 */=0A=
+		if (sitdev->intsync_conflict) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "More than one PLL holds the INTSYNC source pattern");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		/*=0A=
+		 * The global enable covers every page, so this PLL would drive=0A=
+		 * the line alongside the configuration that set it.=0A=
+		 */=0A=
+		if (sitdev->intsync_foreign) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "The sync line is enabled by a configuration the driver does no=
t recognise");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);=0A=
+		if (sit9531x_input_prio_present(sitdev, sitdpll->id, hw_src)) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "PLL selects INTSYNC as a reference; it cannot drive it");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_intsync_enable(sitdev, sitdpll->id, &owner_kept,=0A=
+					     &changed);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		if (sitdev->intsync_src !=3D sitdpll->id)=0A=
+			break;=0A=
+		rc =3D sit9531x_intsync_disable(sitdev, sitdpll->id,=0A=
+					      &owner_kept, &changed);=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	if (changed && !rc) {=0A=
+		sitdev->intsync_src =3D state =3D=3D DPLL_PIN_STATE_CONNECTED ?=0A=
+				      sitdpll->id : -1;=0A=
+		sitdev->intsync_partial =3D false;=0A=
+	}=0A=
+=0A=
+	if (changed)=0A=
+		detect_rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	if (changed && rc) {=0A=
+		if (owner_kept ||=0A=
+		    (state =3D=3D DPLL_PIN_STATE_CONNECTED &&=0A=
+		     (detect_rc || sitdev->intsync_src =3D=3D sitdpll->id))) {=0A=
+			sitdev->intsync_src =3D sitdpll->id;=0A=
+			sitdev->intsync_partial =3D true;=0A=
+			sitdev->intsync_foreign =3D false;=0A=
+		} else if (detect_rc) {=0A=
+			sitdev->intsync_stale =3D true;=0A=
+		}=0A=
+	} else if (changed && detect_rc && sitdev->intsync_conflict) {=0A=
+		sitdev->intsync_stale =3D true;=0A=
+	}=0A=
+	if (detect_rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "INTSYNC source cache not refreshed: %d\n",=0A=
+			 detect_rc);=0A=
+=0A=
+	/* The core notifies only a request that succeeded */=0A=
+	moved =3D sit9531x_dpll_intsync_src_connected(sitdev, sitdpll) !=3D=0A=
+		was_connected;=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		struct dpll_pin *dpll_pin;=0A=
+=0A=
+		if (rc !=3D -EBUSY && rc !=3D -EINVAL && rc !=3D -EOPNOTSUPP)=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Failed to set INTSYNC source state");=0A=
+		/*=0A=
+		 * Runs under the core's lock, as __dpll_pin_change_ntf()=0A=
+		 * requires.=0A=
+		 */=0A=
+		dpll_pin =3D READ_ONCE(dpin->dpll_pin);=0A=
+		if (moved && dpll_pin && __dpll_pin_change_ntf(dpll_pin)) {=0A=
+			mutex_lock(&sitdev->multiop_lock);=0A=
+			sitdev->intsync_ntf_pending =3D true;=0A=
+			mutex_unlock(&sitdev->multiop_lock);=0A=
+		}=0A=
+	}=0A=
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
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_dpll_intsync_refresh(sitdev, extack);=0A=
+	if (rc) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return rc;=0A=
+	}=0A=
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
+/* INTSYNC is an internal line; only the per-PLL priority table is touched=
. */=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_dpll_intsync_refresh(sitdev, extack);=0A=
+	if (rc) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return rc;=0A=
+	}=0A=
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
+static int=0A=
+sit9531x_dpll_intsync_dst_operstate_on_dpll_get(const struct dpll_pin *pin=
,=0A=
+						void *pin_priv,=0A=
+						const struct dpll_device *dpll,=0A=
+						void *dpll_priv,=0A=
+						enum dpll_pin_operstate *state,=0A=
+						struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_dpll_intsync_refresh(sitdev, extack);=0A=
+	if (rc) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return rc;=0A=
+	}=0A=
+	sit9531x_dpll_selection_operstate_get(sitdev, sitdpll,=0A=
+					      SIT9531X_INTSYNC_PIN_ID,=0A=
+					      state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The destination pin id SIT9531X_INTSYNC_PIN_ID is one past the end of r=
ef[];=0A=
+ * do not add ops that index ref[id].=0A=
+ */=0A=
+static const struct dpll_pin_ops sit9531x_dpll_intsync_dst_pin_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_intsync_dst_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_intsync_dst_state_on_dpll_set,=0A=
+	.operstate_on_dpll_get	=3D=0A=
+		sit9531x_dpll_intsync_dst_operstate_on_dpll_get,=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+};=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_intsync_dst_pin_manual_ops =
=3D {=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_intsync_dst_state_on_dpll_get,=0A=
+	.operstate_on_dpll_get	=3D=0A=
+		sit9531x_dpll_intsync_dst_operstate_on_dpll_get,=0A=
+};=0A=
+=0A=
 /* The XO feeds every PLL and is always connected. */=0A=
 =0A=
 static int=0A=
@@ -974,12 +1320,18 @@ sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll=
_pin *pin)=0A=
 	const struct sit9531x_dev *sitdev =3D pin->dpll->dev;=0A=
 	bool manual;=0A=
 =0A=
-	if (!sit9531x_dpll_is_input_pin(pin))=0A=
+	if (!sit9531x_dpll_is_input_pin(pin)) {=0A=
+		if (sit9531x_dpll_is_intsync_src_pin(pin))=0A=
+			return &sit9531x_dpll_intsync_src_pin_ops;=0A=
 		return &sit9531x_dpll_output_pin_ops;=0A=
+	}=0A=
 	if (sit9531x_dpll_is_xo_pin(pin))=0A=
 		return &sit9531x_dpll_xo_pin_ops;=0A=
 	/* Read once at probe, before any pin is registered. */=0A=
 	manual =3D sit9531x_chan_state_get(sitdev, pin->dpll->id)->manual_input;=
=0A=
+	if (sit9531x_dpll_is_intsync_pin(pin))=0A=
+		return manual ? &sit9531x_dpll_intsync_dst_pin_manual_ops :=0A=
+				&sit9531x_dpll_intsync_dst_pin_ops;=0A=
 	/*=0A=
 	 * Set before any pin of the input is published and not written again.=0A=
 	 */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index d6c6b4a6a6bb..6913f9f7f0ad 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -254,6 +254,9 @@=0A=
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
2.39.2 (Apple Git-143)=0A=
=0A=
