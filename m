Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C89231C91;
	Tue, 25 Aug 2026 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694937; cv=fail; b=ZnGbrDajSeeDyX+UPU+w4V84uMfC/Mzrk+sACyWJanoFwpqnVCu6ofz2b84BxSjvkh51Fo45NG3012r//f/gy6/wT2nke+UbbqGjKyV/UPwEbzEE4LKco0L72AO0LS8+Tmv6LDAoLIELMLpF4EROW4+p4FFagEVLQkRyBPpGvDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694937; c=relaxed/simple;
	bh=Be1eS0SqKB2+Tf236Zb+5Tsti/wwnVTwtF4rBkhx7PI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gUQz0SL8Dyz380bL8v9NzGqp+3Ka/8NSkffPoU0pTN5Pjxf0Ku/yHCAGb9uGH+qEufd38weC9yR/UAbj0jJpsiduvdEfHwQDLkvLw9HroHn7hNU29eyP2QoC3d17kCWExaA6TgjqvauyApETh6x0A7kPQub/XV0XVwGq37ETNpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=ULty2Hnn; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=j7RR802R; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="ULty2Hnn";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="j7RR802R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=Be1eS0SqKB2+Tf236Zb+5Tsti/wwnVTwtF4rBkhx7PI=;
 b=ULty2HnnIGATjksDrdLLX2Tp2YtbZJNcalr9ryr9yCG8/m0+3h8BUX3DF/uToZ54MedeRzvodnLVjepQoFetP8//LWab8QeHk/7ldf5eebfTxYXSES1CtRWcqMkJqbZJ5j18hbEkqH4l8oG6+2qQqL80c2AFCKl0ZvMn+Hdbfp8M+COWPD5fTI+Yu+fA0qiSb0b26yJ+jTB4ujivVv2EAgTJyXWUdNUxOK0UYekPYoWu+T1uOU9nLtCluuf35hVcmg3umpTxJNNIsLHEnSvvAMr1s3NFoUUyM3stIoXGhFMIL0obcMh9eQsfgLCxw3Aj5tLQ7kxsRb1dPmWjh9NTTQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023124.outbound.protection.outlook.com [40.93.201.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id CC722340062;
	Tue, 25 Aug 2026 21:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djNTkjmprwNWfqXSRNR4FiATC6eRjQBZ6dmcE8XtGV0eBpczL+LgR4VRIX4vjT25ilp0hRVw7eeln+iqHniMpuvk8fuuqyF7vsgHTcUYfb1kpduwBpnmlKwd1AaM7+YxXUaqYNCDNAZk4CR2YIMpoFbYLDJ8fnHd0Ks0T25G6z3Ta2lsVXBaSoy/9PS1lB4QhdnHUCbmisO5j7daarlnLColDEEtYh2XFVsBWvFUbps7LUuT2koLk5HZpwGMfkZrwnm/9E3twKaB8MIbXGiamtDknr3yhXs2IaLWYw4P6cITbTjNFwlx4DERWrR6viesJpYchtpowjcHkGuza5ZS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be1eS0SqKB2+Tf236Zb+5Tsti/wwnVTwtF4rBkhx7PI=;
 b=mP0j2+nVTvKkBZyoQAMEXgVHLQfMSjLU5wH6cWA1zdNaHbyg5UOx+r4l8SCdzco4w7e5K+4ccuuNBOJdrBrpGbJxbsrBuBimuwEnE9QdNViZojIDOm+Li3lSlxNoQoiqASUOuD/gW5A+EDMYX7YTv/LcAJR8aKpNlrg9vhGYIA2xQCAdw/hDCOgEa+099LNg66q/Pt/+bdhUNTov4yYm2IPv1FAvKYBn3MBVyX1qt4odRR+dreh6gXh5YZYbbn0M88D01RJHIa2idWroc9dgk0QJMnsvIkgNHgXbbeAmlM4uWdgdxSOcCoH/Yf4AMTayYHTmr9raUbgp5IUsTirwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be1eS0SqKB2+Tf236Zb+5Tsti/wwnVTwtF4rBkhx7PI=;
 b=j7RR802RHw9LTSNpKFPfOIMUDYJPcSaeSvlPl1yUxG70+H6JiYH79yLHgndRbBgqdob7RECBTIHIwXBIY1ydbg2/rF7q4+e5zKJTa9Ri0WioG1mrdyu5WMAzPi6VHXxBhhIJjxsshV6WndBNs5oS309BrbUhBVCqPnANkodAT9JwicuyA7WN9gyg9CTV41wFmi9Tz6ppYialltVgxknzkS0B5RCz2YiV77dc7SI6ZfyYwI9X+hxBcPQYlg40V6G10nv0JnCnVMUSATYxFvwfEYDlNzc1Be9ttOIxwCUjH3SrF8BW7VhGNYnf8OE1vFXxhJyVjLArGIUK8tnwu6MqNw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MN0PR20MB7536.namprd20.prod.outlook.com
 (2603:10b6:208:4c1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 21:55:24 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 21:55:24 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "ivecera@redhat.com" <ivecera@redhat.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "arkadiusz.kubalewski@intel.com"
	<arkadiusz.kubalewski@intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Topic: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdLQQfSg/FkjsHkkS39O51qCIspbal5eoAgAiggwCAANhmgA==
Date: Tue, 25 Aug 2026 21:55:24 +0000
Message-ID: <20260825215523.84195-1-arouhi@sitime.com>
References: <20260815221919.64226-1-arouhi@sitime.com>
 <20260815221919.64226-4-arouhi@sitime.com>
 <6a529684-bd6a-4187-9ed9-bb40f4b98065@linux.dev>
 <ao1Zh0uHO0mWj-2t@FV6GYCPJ69>
In-Reply-To: <ao1Zh0uHO0mWj-2t@FV6GYCPJ69>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MN0PR20MB7536:EE_
x-ms-office365-filtering-correlation-id: 18668a7a-c06f-445f-f09d-08df02f39140
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 hih8VQJXYTOePF6MqHu69+0ojApb9bUy/Z1CiT4niuJvYmLW9GD51JmUpo3LG5tuXtxYmvLze1PUvVIXvpYFwZzQSG2Js/be98+3UahHdyeyC9bJ3ILQeIk0AB99LrTgkXmYLUHPRiALNv18ktVV/7IcmXM2HBZGR9eVH46m7AeKRapYQcPoH5A2jEXEpXYSON8wIsvic3YQQGRqEsnR1q/EE2+QZmxkXqM76jxFSvODEjZdUMPEVu8H8ZaZgXaJWlXy4Sb5DT/Z3j4BkdkDTwn8R8rnil0xIYZU0/pHwkLo2c1PeQusTppDHc0PkO+nyG4xOm8mpd5JfMyxNjuu8ZH98jNE1Sfa+kKmFmNCTxNUSW8Or6GgRUx+p+scYuwf/CQdSIvQILY2pAk5WOz+zRNZ/L+gTpf3swMAUyHyKo29S2yZjFjyc/+GsnkLgM2rI7QE8cXECjfeLo5rSl8d8W3z1l5lpUriaAyBUMB6hwfXAyo7IElYJeCi+kVe/z79myBUVT71uhw2p0x7++gvbCmU+InIfObRVZbkONi83x7vMpnv+ywPKNpwhs4H9ZakJkblNA18Jb6tLA2GJPhX076QPm0Qb09L4uK3m9j7qNmkPt1eQWxrDvIHjCJMG5EVr6kmlImGQ6T4pQBnenXj6jyS/h4JkEGGHr+g37mwVvDSqW5+Xh6f1l5QZG5drZieyU4EBgqTFBnmi7/LNhJgNyNfqGRLT19+6ZHeZHGoGWc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWFVeU4zOHNkK1hTb2lrUnMybXk1V0laUFFGdFpkY3k4NWdOK1NvTWdrckxk?=
 =?utf-8?B?cHBTdHlzQUN4aVZ0aVBMSXBaODdNSUxnaDVpbit2SDFZbnY2MHFOTWtlWlYx?=
 =?utf-8?B?RWo4cU94d3VSSkRIRVM2Z0hwUXI5NVh0YVVkOUFnSlRseVFEd2s4V0MzQnI0?=
 =?utf-8?B?RDBQTk5TSE9ZNElvNU53MjhSRlJpckloNExFYU1ac0ViM2sra1ZJTDBpYUtp?=
 =?utf-8?B?emdoR0lqUW5mNEt4aDNCNTRnNkh1b0JIbkVxVmpveTEvTW1mL3RLZ3UydVBn?=
 =?utf-8?B?S0FzYXI5Vmd2WVE0ekJyK05kQlNJWGVqTzRic2U5VWJ1TFNMNHJneEszQUlo?=
 =?utf-8?B?eE5nVVJ0MTJyZ3ZpZm5ISTduR1dLOFUxWFpNcWVHaksrc3RhdUYwU3FnWkt4?=
 =?utf-8?B?eGovS3dkQjAzRlh5QTBPRWVCNDhqOUFDWDVxTy84dERXc2M1WTJlRStDdTdk?=
 =?utf-8?B?dEFndGV1R05xMEYvNGRQTlRTSEU1d2JCQjlKNnFIMzJWRHpaZXlKSStzV2VO?=
 =?utf-8?B?eUM3b0VOTDVaa01MTitoODJadUJIN29wZzlORlMvcndwdVBUZmVmQjhlZlVu?=
 =?utf-8?B?R2Q2YTNhWmg2bGxMcVpoRzVEYmoxNjAvQ3dzZ0x0N3IxbmExc1o1RlRCa3RW?=
 =?utf-8?B?R2tPbmpyV2psZHhPeDRLVkJJU0c2VmE2VHd2R3pMUERGbUZoUEtnSFlvY0I1?=
 =?utf-8?B?bXloaG9Nd0NEWmNrb3lQZ2dWemFKcW1RYklnTGFIUEhzM0RxQ0tDMng4UWhZ?=
 =?utf-8?B?azhtcXNmY3RaVTM3eVd4ei9MU1dDZmJ6QklGSVpkNDJNeGk3cXpScEZwZDFI?=
 =?utf-8?B?TkVGVzRjQ2hNRitnWGtrT2hUMzdCUm5heDJpbXordVZINE5LWk9wVUQyeEZj?=
 =?utf-8?B?V2lINTBaa3R5bFBod0NuR0t2aU4wb3RNbmlwWjlQRDFETk10N2tCcEduYUhv?=
 =?utf-8?B?TFNGYml5aDU1MWFZUEVqTjErZUFJdkY0RWF3Z2dyWnAzZlprajJtYkRsUitL?=
 =?utf-8?B?VlJEU1pnL2JqMXp0dzFsU044TnEvcmpFa0VFczJSajlqMWFkYWM0Q3BsQzlo?=
 =?utf-8?B?SmJVRHRjVDVLbXF5YjRxU0ZoRWFJZmZPRUhacmpPVXpxcjhnZWZtY1Bxckx2?=
 =?utf-8?B?dWFJZklxTXdnRmN2QXBoZkNadWFhWTNaT3pqaFVaemtiZnozb2dqZlRJTXlI?=
 =?utf-8?B?Y0swUmJmZG1vZjNRTU1neEhXVFBEeUpiWTYwc3R2U2RqV2R3Rmxvazhkalo1?=
 =?utf-8?B?ME5zM2xPNVFzSlE4NjZaMVk4Q00rRzhSSFF2RjFVUllReWYzRWgramMrSEdD?=
 =?utf-8?B?WEROMHdmS1JscVBBOFVmVXhkS3BBWkdVWWxDYTRhYVlCVk9ubzZtblRNbGtW?=
 =?utf-8?B?UzVjb2JyaVNnWmtZQ0QxZUJ2TG1RckRmSGdqNisyaW9xZExaWEpZcmRENHE3?=
 =?utf-8?B?anQxZG1iQ0lOVkRWV3BTaXlXMlUxNW4yZDVSQmsrZWMxanFmcTBreHpmZEpR?=
 =?utf-8?B?WXAyZWUzVldFbjhoWjVYSDdUZlAxMHB5dU9MUXoyUkFoU0RjMU13SUlneklO?=
 =?utf-8?B?bTNSTUpuZ21GL2d3S294ellYdEtNWVkwT3REaWI4dnR0bW1jbnNZOVpJUG82?=
 =?utf-8?B?ekgzSW1EcUdWeEROeitma1dhT3I5Wmw0QnFrV1RiUzBxM3JFREhWUFB3MDZ1?=
 =?utf-8?B?ZzgxNnp1MkowaHYyc0IrVVZnQVBLSWtrbWhXYStMYjJZYlJMczNIUXU5OE5J?=
 =?utf-8?B?di93Y05GM2pxYU1PZWpqOGEzT243dzF5bjZ0MUtvM3pWVVNMMGZ4RmJiV2dV?=
 =?utf-8?B?NDV4TW5Rak1pVEh5YU52MzFZeXRaeElXbHh2bzN2TXpYVjVtVDQ0Ulo2Z2w4?=
 =?utf-8?B?TmlxWG9paHQ0VnRSd1ZtUk1qWEhJM3hDK0hDY01oc3kwSk1PVkF3TWxHVkVt?=
 =?utf-8?B?RER4ZWhXOGxVcm0zMGFuVTlZVFlIeHQrSjR0czlBNDkySDRaYk44NjNRVUxP?=
 =?utf-8?B?RFhhWGVGcE54TzZ6Nk9FUjFaZ3JkNTdtdEZUZEZTQWpoMGJ4MWJsQlh6RWJR?=
 =?utf-8?B?dklobGw3SFFUK2gvbjNlSGxhRVZKZXJWM3RSQjJJclpLSjMwdnQ1Q21YaWFC?=
 =?utf-8?B?aVlsWkg3NjZ1UkhWTFo0WEFCYzZ6ZS9ZZ3ZudmxpcDNyMGJWV2hQdklPcVRO?=
 =?utf-8?B?UVBvUGNpV0RYUnFweldyNThUQk1oWDVJdDhBNkJTb3RTVlBmQUNlL2dvYUFY?=
 =?utf-8?B?Q0ZWdWhRS2xJV0FNazhBWm4xWTJ5c0RFTGpPdHB5MHk3RGhGejB1S3N6dmhE?=
 =?utf-8?Q?pAPYGsnKUWc2dkwlKM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hsOwFcdCl32jASNBeF4Bw2v0tGWCCSMVSCQSOZu97TMPesD/h6IaKuCsZM/KM2y70yi8jHF43etVClfJ1W6PrO+Fwl4/XxEbGzQGH76UzA0eZEgb9fe+bf5Pfe+iPdGRMEoFAgelNQKRkccG4zrOQlytQnne/SYLU0U7socRBg4Fj2rXCmUgsxUT8+buOsJxeuaMpaBm5yz30bdHe36df1YQL5MW62zr1yfzoXzST01OnxpPnxJWUxs7xTeUc3oOzTtPOZi5QYUq+8u5YukB8ejhmI8ujU0D5ddV1I8lfBwOUSdWdktM3DkmYXgSzPzy5X9h9we5yiFoTpCl6VgEjw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18668a7a-c06f-445f-f09d-08df02f39140
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 21:55:24.6465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0INXmsvgL84WHvZWZMNFrZnDikOIZfGr0a71jDl4TeVlgVsJfr6KXvTfkSbEeRdKXUbXzGQ1s8lurKP4CkUHQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7536
X-MDID: 1787694928-XbvqLGCybr7G
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1787694928;XbvqLGCybr7G;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

T24gMjUvMDgvMjAyNiAxMTowMCwgSmlyaSBQaXJrbyB3cm90ZToKPiBJdCdzIGEgbmV3IGRyaXZl
ci4gTGluZWFyIHJldmlldyBpbiBvbmUgaHVuay4gSSB0aGluayBpdCBpcyBiZXR0ZXIgdGhhdAo+
IHdheSBhcyB5b3Ugc2VlIHRoZSB3aG9sZSB0aGluZyByaWdodCBhd2F5LgoKSmlyaSwgVmFkaW0s
IEl2YW4gLSB0aGUgcmV2aWV3cyBwb2ludCBpbiBvcHBvc2l0ZSBkaXJlY3Rpb25zLCBzbyBJIHdv
dWxkCnJhdGhlciBhc2sgdGhhbiBndWVzcy4KClZhZGltIGFza2VkIGZvciBhIHNwbGl0LiBJdmFu
IGFncmVlZCB3aXRoIGhpbSwgc3VnZ2VzdGVkIGxvdy1sZXZlbCBvcHMsCnRoZW4gY29yZSBvcHMs
IHRoZW4gZmVhdHVyZXMgb25lIGJ5IG9uZSwgYW5kIHBvaW50ZWQgYXQgdGhlIHpsMzA3M3ggZ2l0
Cmhpc3RvcnkgYXMgdGhlIGV4YW1wbGUgdG8gZm9sbG93LiBJIGFncmVlZCB0byB0aGF0LCBhbmQg
dGhlIHBsYW4gZm9yIHY4CndhcyAxMyBwYXRjaGVzIG9uIHRoYXQgc2hhcGUsIGVhY2ggYnVpbGRp
bmcgYW5kIHdvcmtpbmcgb24gaXRzIG93biwgd2l0aAp0aGUgZW5kIHN0YXRlIGlkZW50aWNhbCB0
byB2Ny4gSmlyaSB3b3VsZCByYXRoZXIgaXQgc3RheWVkIG9uZSBwYXRjaC4KClRoZSBicmVha2Rv
d24gaXMgaW4gbXkgcmVwbHkgb2YgMjEgQXVndXN0LCBpbiBjYXNlIGl0IGRpZCBub3QgcmVhY2gg
eW91cgptYWlsYm94OgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjYwODIxMDEw
NTU2Ljk1MTkyLTEtYXJvdWhpQHNpdGltZS5jb20vCgpUZWxsIG1lIHdoaWNoIHlvdSB3b3VsZCBy
YXRoZXIgaGF2ZSBhbmQgSSB3aWxsIGRvIHRoYXQuIE15IGRlZmF1bHQgaXMgdG8KZ28gYWhlYWQg
d2l0aCB0aGUgc3BsaXQuCgpUaGFua3MsCkFsaQo=
