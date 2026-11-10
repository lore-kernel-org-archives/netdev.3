Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.184
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342410;
	b=tadEOmUw7ruGJQIExDYu4gNf9ecU7kDOpR+Ra/pPcvzSpSc3nafrPqi2hWhMXJgD8Ow3
	 i9Vsmd+HvOrI/ucQujW5vp9X/NDfbu7+3jKQQqoElWUTfW96ar5JMl96f+mPPhL65r8SJ
	 tsmhA7XZ8yZW4KVtqA3ldiFkKsMZV7dLs0TnEIqiRJvngsLrt1yAKL8QNjTIYwixviMTK
	 fAIAcUvl7bC14zIEjR7pq2bzZJMHcMFwXf+YnyOHRwKmuOxDTWLenuOeb8nfRTV1A972s
	 isooCI+Y07ZM66ubcDS1aCw5/7QorkWCGS8oQGpwqKjoygw9OQ4mTAZZCoo8HFsYeww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342410;
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
	bh=tx6rphhrTcsmy6Adbo5e7PwU2C6bc97/hpXttdBwyUQ=;
	b=y1QiA2SqFUmBeC+tp6eMq8Rs6GX2HDuL2F+dgv19fbrPMboiL14Og44zOSslmXandx7Q
	 F3swAz5YublgA4RR1kB3ax26kGWT7YrkaDbBHEL4WAvDfv166c3YENeMop4Emp7kLLxn+
	 gFAWcJkhoxnudj39RY79Olj2uGCkSJcV/PxMve2g7cM0g2WcK49UW+tGs5c9Oh3C3QBXn
	 5zStwTsOXG0IS/G1mNejR9CYmkK2U89ivbZ5ziFCz5y0Xyb7kXeSB+7j5i4slk5YjvwhA
	 yEwlcxteUhJWPlJLQvfFhhUwjdHFNUYQaJ6s/10/yokrObCRD4rJPoMSxUQcBvKedlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=S+goOnEQ;
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=xVPA0SMX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.184
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA30F60A2612;
	Tue, 10 Nov 2026 20:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA30F60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=S+goOnEQ;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=xVPA0SMX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=tx6rphhrTcsmy6Adbo5e7PwU2C6bc97/hpXttdBwyUQ=;
 b=S+goOnEQfkzwhLRefps1JmxFPbyb3/LG8b5cL7IuUzTEJ3muPWn5jEb3YZQLO0HHk1skgyK7dl4FEW6NJV7BlK9CSYvogwOUgPP1qBxp//twZZ8+bljSbXNcQ5HmJdFUE9xDP3tcIJwkeHD6dakGh0yshsOfCq3yEJ4pXiIaW5nfGQZLtEZ3W5WDk5NNIAvL0W1q0rtSchYEyfHQgkHpQfaZHdBJO3taYVlwIw9Fng//eNs/37cccx94WSItXkIga7kcmabhrgnZNgsNCj9ySuerQzV8Jc3M0bFBhllDpdBFe0Qvlr3hs0dB2FPkiLB8oxThFAiWGprq9w1J3rI7VA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023085.outbound.protection.outlook.com [40.107.201.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 982393C0078;
	Tue, 10 Nov 2026 20:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVH3EfmaLxU15tJzM6HM0WEje3xDcJ0AyKPkeFLErMvevulJ5c9BPUqadIRAL1yEAQcW6QW/1e3QO7WJG7poZ/AhjWWYcKZU519w6EjdR22j6XC5o+Yoddlr0N2oggHt/FK8Rq4YSCtD+5dS5RWhB87+bVbmKPMSanPjc5izpkKsCPnW6o8ElZe01V3Hfps7hjDMKJ+WxjLPijzHV8Qrkqdjp465sCkx8OJ6XOFfvfIZWFvbspYYRNc9eLmqN7jLWjhrUPvqhN9Qn7oIcaNMhxNBIzt1dr9PexghsD2NmX0fVKh45PT4W5OiKTJPsxgEhIULFeo6cRrPZ0x3MZ6pxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx6rphhrTcsmy6Adbo5e7PwU2C6bc97/hpXttdBwyUQ=;
 b=jTCtnrrsmZ1wC9wS3RbANfqXxK349/jX8h+6YWcMbJaQstmajnk4Fg9uncEZoOs3fgg7TmIgRcTZzXXyyV6rYmI+5qliJmz4M9QKBtWShPVRNJrun1dX1nXY0E8K6kdmYCCO01vH3fQK9XPtngkiRjOSRrEWbTgucwaoZsUTVlvoagxIfVQpaYUGPevp5S0xHrfw2JztpUSd2tsHgE6nagl2PWfw6iJVan/oIr2yW0H3B3HS+TGXObzfqWccpkYtkrd4AQUr2xNCWLa0HmSRVYLMwYjNXTFcLzsSE5irQxknCfnUcw5RNgyiG35/CmLauBHdLqeDFnNIHGYy97hcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx6rphhrTcsmy6Adbo5e7PwU2C6bc97/hpXttdBwyUQ=;
 b=xVPA0SMXybxzq//R9kUMWHM8rqmg2qWm3XOKE3N/RT78mP9n6Aan7nvZhL0lNHB+9ksHk9/yy1Eo8zZNl97jyxn649w0QEHmzP+rFqxmcYmK2ys6L3L3kL+P99e29Mf5QNrKXUPYQa5+kZuecIocQb0G+738EOZGWpsdwQpSASYLB70GDuOtKCalt7lOD+qoan/yIM8bya+aMMNyYCIIMnn10v2HMMvdfK9NOQ0tYHB2RHMjLUHq3fmCyz8w8Y7HTQ4ts1+vpZcqEDkCt6kigYOhuzbLY+4W6gj8YR9zF528YRnwG1j40FC4SqnOi7KHsobcnVRuREaNddw53nG+ew==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH3PR20MB5745.namprd20.prod.outlook.com
 (2603:10b6:610:14d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:15 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:15 +0000
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
Subject: [PATCH net-next v15 06/13] dpll: sit9531x: register DPLL devices and
 pins
Thread-Topic: [PATCH net-next v15 06/13] dpll: sit9531x: register DPLL devices
 and pins
Thread-Index: AQHdcVG604Chvtkde02H5C9QInvNoQ==
Date: Tue, 10 Nov 2026 20:26:12 +0000
Message-ID: <20261110202607.55744-7-arouhi@sitime.com>
References: <20261110202607.55744-1-arouhi@sitime.com>
In-Reply-To: <20261110202607.55744-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH3PR20MB5745:EE_
x-ms-office365-filtering-correlation-id: c0ea3709-6646-479f-d07c-08df3f68de72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|260925021911599003|260925021311599003|260925022911599003|56012099006|5023799004|18002099003|22082099003|6133799003|10067099003|261009223027099003|261009221227099003|261021121427099003|261028144727099003|261021123027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261022113327099003|3023799007|261021135927099003;
x-microsoft-antispam-message-info:
 AbcFGvtUNRPtHqyf3E95beaHXN2zAc7LNR0BOz7OfBAJbSqbGrS7YywtdDkS36oJfkMvi2/lDYASPDTnPMfDRlqDCAUlSq4S8qjy3w0jNoQcV1Ov+jO/7FpEGWwfhqCGofluROlNydBGSXi6IKIHL3mgY/C1ssPQ6vcW6gGtU4EnoqwluNgfl8JSL363X7O/vqv2avt2rk5F5gajKVG8bkJqKYiDdYMcXI8GWstxbJl0ViTi2LXOCnxMd30l+t9bhhz9uODT7nMyGvigSL8x8xz3SnGwvZhAl39gu1VjELg465tGu7b1nE7DjTFPWH0WgQoJMT/WvD0PmuK4l3UcqpGwn80vKAa2sLxfsDc2EPk6skSjtLyybaVyvokwNwsppNwPeSDmAgIINQX6h3T1K6zWsOxFiTiLzQIRUtx1cWJmiNA9SCA/udzkvtpoqMEYa7Kkkg5cPXrWVF8qPZG1IkySWDVpZtyE4XAKbBizSYHvsdatZtzLPfukGMUKjrlCk2+QIrw0amg2MJYX5p9eqptyAZb5RtrD2jeLFasGUEzIr/K5nBeFavKAfyuRJAev0H2x7nquYU+U2G6HadYPPLEXc0Wh6tBtmmysq7avwcOk8LsBNuCceOPLrkMyrc9bNz7vVUB82PqZclDBfVGXOCAQR9UFKEMMmmwTYEKwuXrE/7+j3ytP1xsQmD9leoaVvJAa9304wInNLjZE/2VR3uIEQdK3CgfMCfpiZSjK4Co=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(260925021911599003)(260925021311599003)(260925022911599003)(56012099006)(5023799004)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261009221227099003)(261021121427099003)(261028144727099003)(261021123027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022113327099003)(3023799007)(261021135927099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3R7bIAyWeqFp/w4u7ckXnB4ucA5Lf7ASvG5uYjJeN0dw/gZ1eENA2TFEnY?=
 =?iso-8859-1?Q?KLI0uuwT7AysOjokw6+ufODPV/r2KgLHgt/FDfw91CKJEc1p21N7+pu1rZ?=
 =?iso-8859-1?Q?9piJunycbyPm3hKvWR/LSpRMgVrM1OeaUtO1dkxExRfxbZpkaJ2PL9ne3N?=
 =?iso-8859-1?Q?/bIDBF2Tvf2pc7cBJm9BHI10QMNl86nBX6v6FlZiIIhkO3vkit8qf1c2ie?=
 =?iso-8859-1?Q?4wevONUBu+HBB42o68voRVxo5syQyvn0ZL1pZiL0V723DT49qJLprDZOie?=
 =?iso-8859-1?Q?4IMSlTRxdLMoNuH8AWzmuboErmkUAoh1BgwYk1/jbxyfosbI0nPVs2fMfz?=
 =?iso-8859-1?Q?LY2ZDm2Hh1t1gqLtnt2VMCQS4u+lQ/kODCy3S4GiBgVwEwtcVBFcS9gQMe?=
 =?iso-8859-1?Q?Zl5aNizTOxvWal/K9ARfqQNIqPfnQVO9ARzeEcFAYtPS23WRf6M3YmyFaf?=
 =?iso-8859-1?Q?TwZMibicemRiUVY0I0CzbZnGyk+rR5BBw8MaMqyYSEFoCil3usacLWeDA/?=
 =?iso-8859-1?Q?u4xF8iQ98fAla6d5pzgoXagtV7dhqkkjPvsakRhRF6i8TbKe1u2itb2GD/?=
 =?iso-8859-1?Q?VdiY4McIAAHNeEFH0/0Pqjx7RW6wrOW7o1KPExj58VVjVJFvYyNEYmDEp7?=
 =?iso-8859-1?Q?3JzdKFd0KmU7j/TlgCph3HnoD3Y6E6mAf8E9T4AcX5co+2LAZrrUxX8RtD?=
 =?iso-8859-1?Q?RWw/CbHCq/G1LH0/gtS1Fa6zAWdlOA1V0L35W9FYH+HxGJ4RF/GYcSl7HO?=
 =?iso-8859-1?Q?ujOqpiCTFDfnVDjjXjzVfuxBcepg9jSkt2XeaSqtqj/pLYpRTZ5c6XEQdx?=
 =?iso-8859-1?Q?hLgxpZHK7q6CVVXnfDshJdxhnY70J6eNN9ZOepZyonWixGBda1Vqjg+VDR?=
 =?iso-8859-1?Q?xlz0+wC/DG/5l0AnM6XusSg7QMKuuMQdHUgezfU8J9xHPElhGLTwdd2P0j?=
 =?iso-8859-1?Q?APfo16q9cQCeAtnVqQfLK8v0JBeOa6Fy9NlhYR9Id9wBibE8uPtyb7D3va?=
 =?iso-8859-1?Q?ERmdiqd5eGTG/YafqoPNBR3cIAm0XL9NkG5KZehFNaEpKta/+SOpqdeCe7?=
 =?iso-8859-1?Q?b2fRvlYaC5zrV+60o8kTs0nnvAQp1lwXbQijirRnmPVzseoUy5vikBA3yC?=
 =?iso-8859-1?Q?+JYi3+HJiedBHtWM35V+D8eVu2paNpewt1WhoreWvOXXva2dIjgJ2+Azul?=
 =?iso-8859-1?Q?2RBoPLtxyBHqE8K3K5rnnkXbmHSPqCdAAdE/yEsY1mr+3LrU3xb0QTVmrA?=
 =?iso-8859-1?Q?bl5VTnjgK5sBrirfedIgDDEblqA4gvokgaYypzQFWacgEZ/pLkFDjOSBNB?=
 =?iso-8859-1?Q?jxXaiesaMH/rIT+MP/f7fCaAij6awScFF5sE1Jlxqyzmjn0lPg/IwX5Yz2?=
 =?iso-8859-1?Q?U6JCmTOQsZir0izW5VYhkhGPrJ2Pl7mtKOWCFwaoI2MHI8SFVV6waQQ6XJ?=
 =?iso-8859-1?Q?czDtMZWWN9114KOsOFlWganf+HxqeyRFfG48hNQx/Umj6HdWNHJ+IcrXiA?=
 =?iso-8859-1?Q?3E/ClgGr+hmsC8ysE9X7J/Mg70DaaUszFinIEjH2Kp1qVBHiZDeJLI9wsT?=
 =?iso-8859-1?Q?NLmsfopoyBveP1pjSjuF12t4wxpYJ5Klv6kgwDkI8fk2UxRfcKqZYxrxJo?=
 =?iso-8859-1?Q?/uSEwq9yeSodu80pm/R56OKjaVTKpQH2Loy+jt9tZUdA9Ub3Y9FbqDxJE7?=
 =?iso-8859-1?Q?akLhmb2xBbsgR1LuMsfYpp2Nud/uWgn+Q7JSBxDL5I4CognoyyyszkcvbP?=
 =?iso-8859-1?Q?aZ4fxBIUkM0vkY2QtL8emeuqxZPqTCRvlpkomXwbfLgkCL?=
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
	klW9o2jiI76mWGIchktFkitemwHkrwKx3DI0ITSm2M9NxhGZ9bxTCZRkPNRBGWClhnBCKlMOJsqqxyBtj3UvrePPhlK16/D53ZqZkrfdiaUPlQChuGGBR/A5sECH9nYA/h8TriQHX3lpnyPwigPGHEAyQl8yLKnlEml39GpcZZgswCQXSngbM8C5rGwbkSAcVc7j6h/6ImdiiIVPGoRQS5xf1jno9NhygVRekjPWvAAAdBaDXjy4cp9PzoKjzfNehqey9F+57UkFPizw/6yCN7SnDkn7FPyeiletALwzHOgulowM9SpaswfylcImRjxHk7EbhqKjXhkly43p1G2+zg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ea3709-6646-479f-d07c-08df3f68de72
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:12.9776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdGSiBo7If4KxpdlBmXWEYZ1Wu2V8GceJrS2hlvia7a5pcUvGS1Rwpzad9cFS3mvM9Wi6N1D1TMkTnpZDNhv0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5745
X-MDID: 1794342401-ecusFLuJ1Sqz
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1794342401;ecusFLuJ1Sqz;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Register each PLL as a DPLL device with its lock status and mode=0A=
callbacks, and the XO as a pin on each. Inputs and outputs are=0A=
registered by the patches that add their state callbacks.=0A=
=0A=
A kthread worker polls the status registers twice a second into a cache=0A=
the callbacks answer from, so a netlink call does not become a burst of=0A=
I2C transfers; INTRB, where wired, schedules a tick early. Each tick=0A=
notifies the core of what changed.=0A=
=0A=
A PLL that arbitrates by priority is reported AUTOMATIC, one on manual=0A=
input select MANUAL. The clock_id is built from the SiTime OUI, the I2C=0A=
bus number and the address.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/Kconfig  |    4 +=0A=
 drivers/dpll/sit9531x/Makefile |    2 +-=0A=
 drivers/dpll/sit9531x/core.c   | 1466 ++++++++++++++++++++++++++++++--=0A=
 drivers/dpll/sit9531x/core.h   |  170 +++-=0A=
 drivers/dpll/sit9531x/dpll.c   |  295 +++++++=0A=
 drivers/dpll/sit9531x/dpll.h   |   61 ++=0A=
 drivers/dpll/sit9531x/regs.h   |  205 +++++=0A=
 7 files changed, 2116 insertions(+), 87 deletions(-)=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.c=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.h=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig=
=0A=
index ac5b7f31a034..47aea8674327 100644=0A=
--- a/drivers/dpll/sit9531x/Kconfig=0A=
+++ b/drivers/dpll/sit9531x/Kconfig=0A=
@@ -9,5 +9,9 @@ config SIT9531X_DPLL=0A=
 	  Driver for SiTime SiT9531x family clock generators=0A=
 	  (SiT95317, SiT95316).=0A=
 =0A=
+	  This driver registers each on-chip PLL as a DPLL device=0A=
+	  and exposes input/output clocks as DPLL pins, providing=0A=
+	  runtime configuration via Generic Netlink.=0A=
+=0A=
 	  To compile this driver as a module, choose M here: the=0A=
 	  module will be called sit9531x.=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
index 819af61123f5..b97d2656a460 100644=0A=
--- a/drivers/dpll/sit9531x/Makefile=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -1,4 +1,4 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-only=0A=
 =0A=
 obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
-sit9531x-y :=3D core.o prop.o=0A=
+sit9531x-y :=3D core.o dpll.o prop.o=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 3ec1ab5aa56c..209671e7917e 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -6,9 +6,11 @@=0A=
  * Author: Ali Rouhi <arouhi@sitime.com>=0A=
  * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
  *=0A=
- * I2C probe, paged regmap configuration and register access helpers.=0A=
+ * Core I2C probe, regmap configuration, hardware state management,=0A=
+ * and periodic work thread.=0A=
  */=0A=
 =0A=
+#include <linux/bitfield.h>=0A=
 #include <linux/bits.h>=0A=
 #include <linux/clk.h>=0A=
 #include <linux/delay.h>=0A=
@@ -16,14 +18,30 @@=0A=
 #include <linux/device.h>=0A=
 #include <linux/gpio/consumer.h>=0A=
 #include <linux/i2c.h>=0A=
+#include <linux/interrupt.h>=0A=
 #include <linux/kernel.h>=0A=
+#include <linux/kthread.h>=0A=
 #include <linux/module.h>=0A=
+#include <linux/pm.h>=0A=
 #include <linux/property.h>=0A=
 #include <linux/regmap.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/string.h>=0A=
 =0A=
 #include "core.h"=0A=
+#include "dpll.h"=0A=
+#include "prop.h"=0A=
 #include "regs.h"=0A=
 =0A=
+/*=0A=
+ * Extra pin positions: the crystal and the INTSYNC destination as inputs,=
 the=0A=
+ * INTSYNC source as an output.=0A=
+ */=0A=
+#define SIT9531X_NUM_INPUT_PINS		(SIT9531X_MAX_INPUTS + 2)=0A=
+#define SIT9531X_NUM_OUTPUT_PINS	(SIT9531X_MAX_OUTPUTS + 1)=0A=
+#define SIT9531X_NUM_PINS_TOTAL		(SIT9531X_NUM_INPUT_PINS + \=0A=
+					 SIT9531X_NUM_OUTPUT_PINS)=0A=
+=0A=
 #define SIT9531X_CHIP(_id, _nin, _nout, _name, _map) \=0A=
 	{ .id =3D (_id), .num_inputs =3D (_nin), .num_outputs =3D (_nout), \=0A=
 	  .name =3D (_name), .clkout_map =3D (_map) }=0A=
@@ -67,6 +85,13 @@ static int sit9531x_page_select(struct sit9531x_dev *sit=
dev, int page)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static void sit9531x_page_cache_drop(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	mutex_lock(&sitdev->page_lock);=0A=
+	sitdev->page =3D -1;=0A=
+	mutex_unlock(&sitdev->page_lock);=0A=
+}=0A=
+=0A=
 /* Caller holds page_lock. */=0A=
 static int sit9531x_read_locked(struct sit9531x_dev *sitdev, unsigned int =
reg,=0A=
 				unsigned int *val)=0A=
@@ -181,122 +206,1415 @@ int sit9531x_update_pll_u8(struct sit9531x_dev *si=
tdev, u8 pll_idx,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
-static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)=
=0A=
+static void sit9531x_input_get_regs(const struct sit9531x_dev *sitdev,=0A=
+				    u8 index,=0A=
+				    unsigned int *force_reg,=0A=
+				    unsigned int *state_reg)=0A=
 {=0A=
-	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);=0A=
+	if (sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE) {=0A=
+		*force_reg =3D SIT9531X_REG_IN_DE_FORCE;=0A=
+		*state_reg =3D SIT9531X_REG_IN_DE_STATE;=0A=
+	} else if (sit9531x_input_is_n(index)) {=0A=
+		*force_reg =3D SIT9531X_REG_IN_SEN_FORCE;=0A=
+		*state_reg =3D SIT9531X_REG_IN_SEN_STATE;=0A=
+	} else {=0A=
+		*force_reg =3D SIT9531X_REG_IN_SEP_FORCE;=0A=
+		*state_reg =3D SIT9531X_REG_IN_SEP_STATE;=0A=
+	}=0A=
 }=0A=
 =0A=
-static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)=0A=
+/*=0A=
+ * Output Hi-Z control: each slot has three force/state pairs on Page 0x03=
,=0A=
+ * for the differential path and the CMOS OutP and OutN pads. A mute write=
s=0A=
+ * all three, as in Output_Disable_Control_HiZ.py. ODRn_MISC0 bits 3:2=0A=
+ * distinguish a CMOS output from a differential one.=0A=
+ *=0A=
+ *   slot 0-7 :=0A=
+ *     DIFF 0xF2/0xF3   CMOS OutP 0xF8/0xF9   CMOS OutN 0xF6/0xF7=0A=
+ *   slot 8-11:=0A=
+ *     DIFF 0xF4/0xF5 bits 3:0   CMOS OutP 0xFA/0xFB=0A=
+ *     CMOS OutN 0xF4/0xF5 bits 7:4=0A=
+ *=0A=
+ * MASK =3D 1 takes control of the Hi-Z state; STATE =3D 0 forces Hi-Z, 1 =
drives.=0A=
+ */=0A=
+=0A=
+enum {=0A=
+	SIT9531X_HIZ_DIFF,=0A=
+	SIT9531X_HIZ_CMOS_P,=0A=
+	SIT9531X_HIZ_CMOS_N,=0A=
+	SIT9531X_HIZ_PAIRS,=0A=
+};=0A=
+=0A=
+struct sit9531x_hiz_pair {=0A=
+	unsigned int mask;=0A=
+	unsigned int state;=0A=
+	u8 bit;=0A=
+};=0A=
+=0A=
+static void sit9531x_output_get_hiz_regs(u8 slot,=0A=
+					 struct sit9531x_hiz_pair *p)=0A=
 {=0A=
-	unsigned int i;=0A=
+	struct sit9531x_hiz_pair *cmos_p =3D &p[SIT9531X_HIZ_CMOS_P];=0A=
+	struct sit9531x_hiz_pair *cmos_n =3D &p[SIT9531X_HIZ_CMOS_N];=0A=
+	struct sit9531x_hiz_pair *diff =3D &p[SIT9531X_HIZ_DIFF];=0A=
 =0A=
-	for (i =3D 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {=0A=
-		if (sit9531x_chip_ids[i].id =3D=3D id)=0A=
-			return &sit9531x_chip_ids[i];=0A=
+	if (slot <=3D 7) {=0A=
+		diff->mask =3D SIT9531X_REG_HIZ_DIFF_07_MASK;=0A=
+		diff->state =3D SIT9531X_REG_HIZ_DIFF_07_STATE;=0A=
+		diff->bit =3D slot;=0A=
+		cmos_p->mask =3D SIT9531X_REG_HIZ_SE_07_MASK;=0A=
+		cmos_p->state =3D SIT9531X_REG_HIZ_SE_07_STATE;=0A=
+		cmos_p->bit =3D slot;=0A=
+		cmos_n->mask =3D SIT9531X_REG_HIZ_SEN_07_MASK;=0A=
+		cmos_n->state =3D SIT9531X_REG_HIZ_SEN_07_STATE;=0A=
+		cmos_n->bit =3D slot;=0A=
+	} else {=0A=
+		diff->mask =3D SIT9531X_REG_HIZ_DIFF_811_MASK;=0A=
+		diff->state =3D SIT9531X_REG_HIZ_DIFF_811_STATE;=0A=
+		diff->bit =3D slot - 8;=0A=
+		cmos_p->mask =3D SIT9531X_REG_HIZ_SE_811_MASK;=0A=
+		cmos_p->state =3D SIT9531X_REG_HIZ_SE_811_STATE;=0A=
+		cmos_p->bit =3D slot - 8;=0A=
+		cmos_n->mask =3D SIT9531X_REG_HIZ_DIFF_811_MASK;=0A=
+		cmos_n->state =3D SIT9531X_REG_HIZ_DIFF_811_STATE;=0A=
+		cmos_n->bit =3D slot - 8 + SIT9531X_HIZ_SEN_811_SHIFT;=0A=
 	}=0A=
+}=0A=
 =0A=
-	return NULL;=0A=
+/*=0A=
+ * Read whether an output is wired CMOS. Only the Hi-Z pairs for its wirin=
g=0A=
+ * control the pad; the other pairs hold what the profile left. Caller mus=
t hold=0A=
+ * sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_output_mode_fetch(struct sit9531x_dev *sitdev, u8 out_=
idx)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, reg, val;=0A=
+	int rc;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+		SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	reg =3D SIT9531X_OUT_MISC0_BASE +=0A=
+	      SIT9531X_OUT_MISC0_STRIDE * (slot % 6);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG(page, reg), &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].cmos =3D !!(val & (SIT9531X_OUT_CMOS_ENP |=0A=
+					      SIT9531X_OUT_CMOS_ENN));=0A=
+=0A=
+	return 0;=0A=
 }=0A=
 =0A=
-static int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
+static int sit9531x_hiz_pair_forced(struct sit9531x_dev *sitdev,=0A=
+				    const struct sit9531x_hiz_pair *p,=0A=
+				    bool *forced)=0A=
 {=0A=
-	struct clk *xtal_clk;=0A=
-	u8 variant_id;=0A=
+	u8 mask, state;=0A=
 	int rc;=0A=
 =0A=
-	/*=0A=
-	 * Fvco =3D Fref * (DIVN + frac/2^32); Fref is the rate of the XO feeding=
=0A=
-	 * XIN/XO_CLK.=0A=
-	 */=0A=
-	xtal_clk =3D devm_clk_get_optional_enabled(sitdev->dev, "xtal");=0A=
-	if (IS_ERR(xtal_clk))=0A=
-		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),=0A=
-				     "Failed to get xtal clock\n");=0A=
-	sitdev->xtal_freq =3D clk_get_rate(xtal_clk);=0A=
-	if (!sitdev->xtal_freq) {=0A=
-		u32 freq;=0A=
+	rc =3D sit9531x_read_u8(sitdev, p->mask, &mask);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_read_u8(sitdev, p->state, &state);=0A=
+	if (rc)=0A=
+		return rc;=0A=
 =0A=
-		if (!device_property_read_u32(sitdev->dev, "clock-frequency",=0A=
-					      &freq))=0A=
-			sitdev->xtal_freq =3D freq;=0A=
+	*forced =3D (mask & BIT(p->bit)) && !(state & BIT(p->bit));=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev,=0A=
+				      u8 out_idx, bool *muted, bool *part)=0A=
+{=0A=
+	struct sit9531x_hiz_pair p[SIT9531X_HIZ_PAIRS];=0A=
+	bool pad_p, pad_n;=0A=
+	int rc;=0A=
+=0A=
+	sit9531x_output_get_hiz_regs(sitdev->info->clkout_map[out_idx], p);=0A=
+=0A=
+	*part =3D false;=0A=
+	if (!sitdev->out[out_idx].cmos)=0A=
+		return sit9531x_hiz_pair_forced(sitdev,=0A=
+						&p[SIT9531X_HIZ_DIFF], muted);=0A=
+=0A=
+	rc =3D sit9531x_hiz_pair_forced(sitdev, &p[SIT9531X_HIZ_CMOS_P], &pad_p);=
=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_hiz_pair_forced(sitdev, &p[SIT9531X_HIZ_CMOS_N],=0A=
+					      &pad_n);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	*muted =3D pad_p && pad_n;=0A=
+	*part =3D pad_p !=3D pad_n;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Procedure:=0A=
+ *   1. Force PLL into holdover (PLL page reg 0x6F bit 4)=0A=
+ *   2. Write priority slots on Page 1=0A=
+ *   3. Small change update (Page 0 reg 0x0F bit 1)=0A=
+ *   4. Release holdover=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+=0A=
+static u16 sit9531x_prio_reg(u8 pll_idx, u8 slot)=0A=
+{=0A=
+	return SIT9531X_REG(SIT9531X_PAGE_PRIOSYS,=0A=
+			    SIT9531X_PRIO_BASE_REG +=0A=
+			    SIT9531X_PRIO_REGS_PER_PLL * pll_idx +=0A=
+			    slot / SIT9531X_PRIO_SLOTS_PER_REG);=0A=
+}=0A=
+=0A=
+/* Slot 2n is the high nibble of its register, 2n + 1 the low one. */=0A=
+static u8 sit9531x_prio_slot_get(u8 val, u8 slot)=0A=
+{=0A=
+	if (slot & 1)=0A=
+		return val & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+=0A=
+	return val >> SIT9531X_PRIO_HI_SHIFT;=0A=
+}=0A=
+=0A=
+static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
+				     const u8 *srcs)=0A=
+{=0A=
+	u16 mask =3D 0;=0A=
+	u8 slot;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		u8 src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+=0A=
+		if (sit9531x_prio_src_usable(src))=0A=
+			mask |=3D BIT(src);=0A=
 	}=0A=
-	if (!sitdev->xtal_freq)=0A=
-		return dev_err_probe(sitdev->dev, -EINVAL,=0A=
-				     "no xtal rate: provide clocks=3D<&xo> + clock-names=3D\"xtal\", o=
r a clock-frequency property\n");=0A=
+=0A=
+	sitdev->chan[pll_idx].prio_mask =3D mask;=0A=
+}=0A=
+=0A=
+/* Caller must hold sitdev->multiop_lock. */=0A=
+static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
+				    u8 *srcs)=0A=
+{=0A=
+	u8 val, slot;=0A=
+	int rc;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      sit9531x_prio_reg(pll_idx, slot), &val);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		srcs[slot] =3D sit9531x_prio_slot_get(val, slot);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* XO doubler register */=0A=
+#define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
+#define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
+=0A=
+/* VCO frequency bands (Hz) */=0A=
+#define SIT9531X_FVCO_LOWBAND_MIN		4915200000ULL=0A=
+#define SIT9531X_FVCO_LOWBAND_MAX		5898240000ULL=0A=
+#define SIT9531X_FVCO_HIGHBAND_MIN		6875000000ULL=0A=
+#define SIT9531X_FVCO_HIGHBAND_MAX		7812500000ULL=0A=
+=0A=
+#define SIT9531X_DIVO_MAX			GENMASK_ULL(33, 0)=0A=
+=0A=
+/*=0A=
+ * Phase adjust: per-output 34-bit coarse delay in VCO periods plus a 3-bi=
t=0A=
+ * fine delay in 30 ps steps, in PROG6..PROG2:=0A=
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserved)=0A=
+ *                    [4:2] PRG_RST_FINE_DELAY=0A=
+ *                    [1:0] PRG_RST_DELAY[33:32]=0A=
+ *   base + 1  PROG5  PRG_RST_DELAY[31:24]=0A=
+ *   base + 2  PROG4  PRG_RST_DELAY[23:16]=0A=
+ *   base + 3  PROG3  PRG_RST_DELAY[15:8]=0A=
+ *   base + 4  PROG2  PRG_RST_DELAY[7:0]=0A=
+ * Outputs 0-5 are on Page 3, 6-11 on Page 4; base =3D 0x15 + 16 * (out_id=
x % 6).=0A=
+ * PRG_RST_DELAY is unsigned; a negative adjustment is wrapped to=0A=
+ * (T_out - |phase|) modulo one output period.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * Clear the write-1-to-clear notification registers on page 0 and the clo=
ck=0A=
+ * monitor ones on page 6. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTER_LOL_NOTIF, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_HO_FREEZE_NOTIF, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_NOTIF, 0xFF);=
=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_CMON_NOTIF, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_P_NOTIF_01, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_P_NOTIF_23, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_N_NOTIF_01, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_N_NOTIF_23, 0xFF);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	dev_dbg(sitdev->dev, "All notification registers cleared\n");=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* Read the lane's receiver state from the Page 0x02 force and state bits =
*/=0A=
+static int sit9531x_ref_state_fetch(struct sit9531x_dev *sitdev, u8 index)=
=0A=
+{=0A=
+	unsigned int force_reg, state_reg;=0A=
+	struct sit9531x_ref *ref;=0A=
+	u8 pair, force, state;=0A=
+	int rc;=0A=
+=0A=
+	/* The XO (index SIT9531X_MAX_INPUTS) has no receiver to read. */=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
 =0A=
 	/*=0A=
-	 * Keep reset deasserted, never pulse it: a reset discards the=0A=
-	 * configuration from efuse or a pre-probe NVM blob. Release it before=0A=
-	 * the first I2C access.=0A=
+	 * A lane is disabled only while its force bit overrides it off; with=0A=
+	 * the force bit clear the loaded configuration sets it.=0A=
 	 */=0A=
-	sitdev->reset_gpio =3D devm_gpiod_get_optional(sitdev->dev, "reset",=0A=
-						     GPIOD_OUT_LOW);=0A=
-	if (IS_ERR(sitdev->reset_gpio))=0A=
-		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),=0A=
-				     "Failed to request reset gpio\n");=0A=
-	if (sitdev->reset_gpio)=0A=
-		fsleep(10000);	/* internal boot after release */=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
 =0A=
-	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &force);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_read_u8(sitdev, state_reg, &state);=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
-	sitdev->info =3D sit9531x_match_variant(variant_id);=0A=
-	if (!sitdev->info)=0A=
-		return dev_err_probe(sitdev->dev, -ENODEV,=0A=
-				     "Unknown variant ID: 0x%02x\n",=0A=
-				     variant_id);=0A=
+	ref->enabled =3D !((force & BIT(pair)) && !(state & BIT(pair)));=0A=
 =0A=
-	rc =3D devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Read CLKINx_INPUT_MODE into both lanes of the pair; a pair with neither=
 SE=0A=
+ * lane enabled is differential.=0A=
+ */=0A=
+static int sit9531x_input_mode_fetch(struct sit9531x_dev *sitdev, u8 pair)=
=0A=
+{=0A=
+	enum sit9531x_signal_mode sig_mode;=0A=
+	u8 mode;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_IN_MODE(pair), &mode);=0A=
 	if (rc)=0A=
-		return dev_err_probe(sitdev->dev, rc,=0A=
-				     "Failed to initialize mutex\n");=0A=
+		return rc;=0A=
 =0A=
-	dev_info(sitdev->dev, "%s detected, %u inputs, %u outputs\n",=0A=
-		 sitdev->info->name, sitdev->info->num_inputs,=0A=
-		 sitdev->info->num_outputs);=0A=
+	if (mode & (SIT9531X_IN_MODE_SE_P_EN | SIT9531X_IN_MODE_SE_N_EN))=0A=
+		sig_mode =3D SIT9531X_MODE_SE;=0A=
+	else=0A=
+		sig_mode =3D SIT9531X_MODE_DE;=0A=
+=0A=
+	sitdev->ref[pair * 2].sig_mode =3D sig_mode;=0A=
+	sitdev->ref[pair * 2 + 1].sig_mode =3D sig_mode;=0A=
+=0A=
+	dev_dbg(sitdev->dev, "CLKIN%u mode reg 0x%02x -> %s\n", pair, mode,=0A=
+		sig_mode =3D=3D SIT9531X_MODE_DE ? "differential" : "single-ended");=0A=
 =0A=
 	return 0;=0A=
 }=0A=
 =0A=
-static int sit9531x_i2c_probe(struct i2c_client *client)=0A=
+/* Read the PLL active-state bit (PLL page reg 0x02 bit 0). */=0A=
+static int sit9531x_pll_is_active(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				  bool *active)=0A=
 {=0A=
-	struct sit9531x_dev *sitdev;=0A=
-	struct regmap *regmap;=0A=
 	int rc;=0A=
+	u8 v;=0A=
 =0A=
-	regmap =3D devm_regmap_init_i2c(client, &sit9531x_regmap_config);=0A=
-	if (IS_ERR(regmap))=0A=
-		return dev_err_probe(&client->dev, PTR_ERR(regmap),=0A=
-				     "Failed to initialize regmap\n");=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_ACTIVE, &v)=
;=0A=
+	if (rc)=0A=
+		return rc;=0A=
 =0A=
-	sitdev =3D devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);=0A=
-	if (!sitdev)=0A=
-		return -ENOMEM;=0A=
+	*active =3D !!(v & SIT9531X_PLL_ACTIVE_BIT);=0A=
 =0A=
-	sitdev->dev =3D &client->dev;=0A=
-	sitdev->client =3D client;=0A=
-	sitdev->regmap =3D regmap;=0A=
-	sitdev->page =3D -1;=0A=
-	rc =3D devm_mutex_init(&client->dev, &sitdev->page_lock);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Manual active select (PLL_CONFIG1F_PLL bit 6) uses the table writes and=
 is=0A=
+ * reported AUTOMATIC. Manual input select (MISCINNER_PLL bit 5) uses the=
=0A=
+ * input-select pins, or GPIO_INPUT_FUNC_CTRL5..8 when bit 4 is set, and i=
s=0A=
+ * reported MANUAL. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_chan_select_fetch(struct sit9531x_dev *sitdev, u8 pll_=
idx)=0A=
+{=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 cfg, misc, sel;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_CONFIG1F,=
=0A=
+				  &cfg);=0A=
 	if (rc)=0A=
 		return rc;=0A=
-	i2c_set_clientdata(client, sitdev);=0A=
+	chan->manual_input =3D false;=0A=
+	if (!(cfg & SIT9531X_PLL_CONFIG1F_MANUAL_SEL))=0A=
+		return 0;=0A=
 =0A=
-	return sit9531x_dev_probe(sitdev);=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_MISCINNER,=
=0A=
+				  &misc);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (!(misc & SIT9531X_PLL_MISCINNER_MAN_IN_SEL)) {=0A=
+		dev_info(sitdev->dev,=0A=
+			 "PLL%c: manual active select, the selection uses the priorities\n",=0A=
+			 'A' + pll_idx);=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_MAN_IN_SEL(pll_idx), &sel);=
=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	chan->manual_input =3D true;=0A=
+	if (sel & SIT9531X_MAN_IN_SEL_FROM_REG) {=0A=
+		sel =3D FIELD_GET(SIT9531X_MAN_IN_SEL_MASK, sel);=0A=
+		dev_info(sitdev->dev,=0A=
+			 "PLL%c: the profile selects its reference from the register, input cod=
e %u; reported as manual\n",=0A=
+			 'A' + pll_idx, sel);=0A=
+	} else {=0A=
+		dev_info(sitdev->dev,=0A=
+			 "PLL%c: the profile selects its reference from the input-select pins; =
reported as manual\n",=0A=
+			 'A' + pll_idx);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
 }=0A=
 =0A=
-static const struct of_device_id sit9531x_of_match[] =3D {=0A=
-	{ .compatible =3D "sitime,sit95316" },=0A=
-	{ .compatible =3D "sitime,sit95317" },=0A=
-	{ }=0A=
-};=0A=
-MODULE_DEVICE_TABLE(of, sit9531x_of_match);=0A=
+/*=0A=
+ * Read the PLL's run, lock and holdover state, mode, selection and priori=
ty=0A=
+ * table.=0A=
+ */=0A=
+static int sit9531x_chan_state_fetch(struct sit9531x_dev *sitdev, u8 pll_i=
dx)=0A=
+{=0A=
+	u8 status, outer_lol, input_sel, inner_lol, ho_freeze, activesel_reg;=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 pll_status_1;=0A=
+	bool active;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * On an inactive PLL the loss-of-lock bit stays clear and reads as=0A=
+	 * locked.=0A=
+	 */=0A=
+	rc =3D sit9531x_pll_is_active(sitdev, pll_idx, &active);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_STATUS, &status);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_OUTER_LOL_STATUS,=0A=
+			      &outer_lol);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * The active selection is CLK_ACTIVESEL_PLL, the low nibble of the last=
=0A=
+	 * register of the PLL's Page 1 priority block. PLL-page 0x29 is a=0A=
+	 * config register.=0A=
+	 */=0A=
+	activesel_reg =3D SIT9531X_PRIO_BASE_REG +=0A=
+			SIT9531X_PRIO_REGS_PER_PLL * pll_idx +=0A=
+			SIT9531X_PRIO_ACTIVESEL_OFF;=0A=
+	rc =3D sit9531x_read_u8(sitdev,=0A=
+			      SIT9531X_REG(SIT9531X_PAGE_PRIOSYS,=0A=
+					   activesel_reg),=0A=
+			      &input_sel);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_STATUS,=0A=
+			      &inner_lol);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_HO_FREEZE_STATUS,=0A=
+			      &ho_freeze);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_STATUS_1,=
=0A=
+				  &pll_status_1);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
+=0A=
+	/* STATUS_1_GENERIC reports loss of lock, so invert it. */=0A=
+	chan->active =3D active;=0A=
+	chan->locked =3D active && !(outer_lol & BIT(pll_idx));=0A=
+	chan->mode =3D !!(status & SIT9531X_PLL_STATUS_OUTER_DIS);=0A=
+	chan->selected_ref =3D=0A=
+		sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+	chan->inner_lol =3D !!(inner_lol & BIT(pll_idx));=0A=
+	chan->ho_freeze =3D !!(ho_freeze & BIT(pll_idx));=0A=
+	chan->ho_valid =3D !!(pll_status_1 & SIT9531X_PLL_STATUS_1_HO_VALID);=0A=
+	chan->stale =3D false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Read routing from the PLL output map registers and drive state from the=
 Hi-Z=0A=
+ * force bits.=0A=
+ */=0A=
+static int sit9531x_out_state_fetch(struct sit9531x_dev *sitdev, u8 index)=
=0A=
+{=0A=
+	struct sit9531x_out *out =3D &sitdev->out[index];=0A=
+	u8 map_lo, map_hi, slot, bit, claimed;=0A=
+	int pll_idx;=0A=
+	bool muted, part;=0A=
+	u16 mask;=0A=
+	int rc;=0A=
+=0A=
+	slot =3D sitdev->info->clkout_map[index];=0A=
+=0A=
+	rc =3D sit9531x_output_mode_fetch(sitdev, index);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted, &part);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[index].part_muted =3D part;=0A=
+=0A=
+	/*=0A=
+	 * Each PLL page holds a 12-bit output-enable mask: OUT_MAP_LO bits 0-7=
=0A=
+	 * and OUT_MAP_HI[3:0] bits 8-11. PLLA and PLLB map slot n to bit n,=0A=
+	 * PLLC and PLLD to bit 11 - n, as in the documented procedures.=0A=
+	 */=0A=
+	claimed =3D 0;=0A=
+	for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_OUT_MAP_LO, &map_lo);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_OUT_MAP_HI, &map_hi);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		mask =3D map_lo | (map_hi & GENMASK(3, 0)) << 8;=0A=
+		bit =3D pll_idx < 2 ? slot : SIT9531X_MAX_OUTPUTS - 1 - slot;=0A=
+		if (mask & BIT(bit))=0A=
+			claimed |=3D BIT(pll_idx);=0A=
+	}=0A=
+=0A=
+	if (!claimed) {=0A=
+		out->pll_idx =3D 0;=0A=
+		out->routed =3D false;=0A=
+		out->enabled =3D false;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	out->pll_idx =3D __ffs(claimed);=0A=
+	out->routed =3D true;=0A=
+	out->enabled =3D !muted;=0A=
+=0A=
+	if (claimed & (claimed - 1))=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "OUT%u is in the output-enable mask of more than one PLL (0x%x); takin=
g PLL%c\n",=0A=
+			 slot, claimed, 'A' + out->pll_idx);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Build ref->pll_mask from the priority tables; it decides when a receive=
r may=0A=
+ * be powered down. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_ref_pll_mask_fetch(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 pll_idx, slot, index;=0A=
+	int rc;=0A=
+=0A=
+	for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {=0A=
+		rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+			index =3D sit9531x_hw_src_input(srcs[slot]);=0A=
+			if (index >=3D sitdev->info->num_inputs)=0A=
+				continue;=0A=
+=0A=
+			/*=0A=
+			 * A differential pair exposes only its P lane; count an=0A=
+			 * N-lane entry as the P lane.=0A=
+			 */=0A=
+			if (sit9531x_input_is_n(index) &&=0A=
+			    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+				index--;=0A=
+=0A=
+			sitdev->ref[index].pll_mask |=3D BIT(pll_idx);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_dev_state_fetch(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+	u8 i;=0A=
+=0A=
+	/* Detect SE/DE configuration before any per-lane access */=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs / 2; i++) {=0A=
+		rc =3D sit9531x_input_mode_fetch(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to fetch CLKIN%u mode: %d\n", i, rc);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs; i++) {=0A=
+		rc =3D sit9531x_ref_state_fetch(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to fetch input %u state: %d\n", i, rc);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_ref_pll_mask_fetch(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to fetch input priority tables: %d\n", rc);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_out_state_fetch(sitdev, i);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to fetch output %u state: %d\n", i, rc);=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		rc =3D sit9531x_chan_select_fetch(sitdev, i);=0A=
+		if (!rc)=0A=
+			rc =3D sit9531x_chan_state_fetch(sitdev, i);=0A=
+		if (rc)=0A=
+			break;=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev, "Failed to fetch PLL%c state: %d\n",=0A=
+			'A' + i, rc);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static void sit9531x_dev_ref_states_update(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int i, rc;=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs; i++) {=0A=
+		rc =3D sit9531x_ref_state_fetch(sitdev, i);=0A=
+		if (rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Failed to get REF%u status: %d\n", i, rc);=0A=
+	}=0A=
+}=0A=
+=0A=
+static void sit9531x_dev_chan_states_update(struct sit9531x_dev *sitdev)=
=0A=
+{=0A=
+	int i, rc;=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		rc =3D sit9531x_chan_state_fetch(sitdev, i);=0A=
+		if (rc) {=0A=
+			sitdev->chan[i].stale =3D true;=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Failed to get PLL%c state: %d\n",=0A=
+				 'A' + i, rc);=0A=
+		}=0A=
+	}=0A=
+}=0A=
+=0A=
+static void sit9531x_dev_periodic_work(struct kthread_work *work)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D container_of(work, struct sit9531x_dev,=
=0A=
+						   work.work);=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Release multiop_lock before the change checks: their notifications=0A=
+	 * take DPLL-subsystem locks, which nest outside it.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dev_ref_states_update(sitdev);=0A=
+	sit9531x_dev_chan_states_update(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list)=0A=
+		sit9531x_dpll_changes_check(sitdpll);=0A=
+=0A=
+	/*=0A=
+	 * Clear the W1C notification latches on pages 0 and 6 after acting on=0A=
+	 * them; while set they keep INTRB asserted.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_clear_notifications(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		dev_warn_ratelimited(sitdev->dev,=0A=
+				     "Failed to clear notifications: %d\n",=0A=
+				     rc);=0A=
+=0A=
+	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work,=0A=
+				   msecs_to_jiffies(SIT9531X_STATUS_POLL_MS));=0A=
+}=0A=
+=0A=
+/* Queue an immediate poll tick; polling continues as a fallback. */=0A=
+static irqreturn_t sit9531x_irq_thread_fn(int irq, void *data)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D data;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Acknowledge here: IRQF_ONESHOT unmasks the line on return, and a=0A=
+	 * still-asserted INTRB would fire again at once.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_clear_notifications(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc) {=0A=
+		dev_warn_ratelimited(sitdev->dev,=0A=
+				     "IRQ: failed to clear notifications: %d\n",=0A=
+				     rc);=0A=
+		if (++sitdev->irq_ack_fails < SIT9531X_IRQ_ACK_TRIES)=0A=
+			return IRQ_NONE;=0A=
+=0A=
+		dev_err(sitdev->dev,=0A=
+			"IRQ %d disabled: notifications cannot be cleared, polling only\n",=0A=
+			irq);=0A=
+		disable_irq_nosync(irq);=0A=
+		return IRQ_NONE;=0A=
+	}=0A=
+=0A=
+	sitdev->irq_ack_fails =3D 0;=0A=
+=0A=
+	kthread_mod_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
+	return IRQ_HANDLED;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Report the loaded EEPROM profile and warn on a bad load. Caller must ho=
ld=0A=
+ * sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_eeprom_state_report(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u32 rec_crc =3D 0, cal_crc =3D 0, prof_id =3D 0;=0A=
+	u8 notif, v;=0A=
+	int rc, i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	/* Profile id: three bytes, least significant first. */=0A=
+	for (i =3D 2; i >=3D 0; i--) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_PROFILE_ID + i, &v);=0A=
+		if (rc)=0A=
+			return;=0A=
+		prof_id =3D prof_id << 8 | v;=0A=
+	}=0A=
+=0A=
+	dev_info(sitdev->dev, "profile id %u\n", prof_id);=0A=
+=0A=
+	/* Both CRCs: four bytes, most significant first. */=0A=
+	for (i =3D 0; i < 4; i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_REC_CRC + i, &v);=0A=
+		if (rc)=0A=
+			return;=0A=
+		rec_crc =3D rec_crc << 8 | v;=0A=
+=0A=
+		rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_CAL_CRC + i, &v);=0A=
+		if (rc)=0A=
+			return;=0A=
+		cal_crc =3D cal_crc << 8 | v;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_EEPROM_NOTIF, &notif);=0A=
+	if (rc)=0A=
+		return;=0A=
+=0A=
+	/*=0A=
+	 * A clean load sets only the read-done bit. Both CRCs zero means no=0A=
+	 * EEPROM read happened: the configuration was pushed over I2C.=0A=
+	 */=0A=
+	if (!rec_crc && !cal_crc)=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"no EEPROM profile (configuration pushed over I2C)\n");=0A=
+	else if (rec_crc !=3D cal_crc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "EEPROM CRC mismatch: stored %08x, computed %08x\n",=0A=
+			 rec_crc, cal_crc);=0A=
+	else if (notif !=3D SIT9531X_EEPROM_READ_DONE)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "EEPROM read reported defects (notify %02x)\n",=0A=
+			 notif);=0A=
+	else=0A=
+		dev_dbg(sitdev->dev, "EEPROM profile loaded, CRC %08x\n",=0A=
+			cal_crc);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Report which PLLs are active; an unused PLL never goes active. Caller m=
ust=0A=
+ * hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_pll_states_report(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	unsigned int idx, i;=0A=
+	bool routed;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		if (sitdev->chan[i].active) {=0A=
+			dev_dbg(sitdev->dev, "PLL%c active\n", 'A' + i);=0A=
+			continue;=0A=
+		}=0A=
+=0A=
+		routed =3D false;=0A=
+		for (idx =3D 0; idx < sitdev->info->num_outputs; idx++) {=0A=
+			const struct sit9531x_out *out;=0A=
+=0A=
+			out =3D sit9531x_out_state_get(sitdev, idx);=0A=
+			if (out->routed && out->pll_idx =3D=3D i) {=0A=
+				routed =3D true;=0A=
+				break;=0A=
+			}=0A=
+		}=0A=
+=0A=
+		if (routed)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c drives outputs but is not in its active state\n",=0A=
+				 'A' + i);=0A=
+		else=0A=
+			dev_dbg(sitdev->dev, "PLL%c unused by the loaded configuration\n",=0A=
+				'A' + i);=0A=
+	}=0A=
+}=0A=
+=0A=
+static int sit9531x_dev_start(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_dev_state_fetch(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_eeprom_state_report(sitdev);=0A=
+	sit9531x_pll_states_report(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
+		rc =3D sit9531x_dpll_register(sitdpll);=0A=
+		if (rc) {=0A=
+			dev_err_probe(sitdev->dev, rc,=0A=
+				      "Failed to register DPLL%u\n",=0A=
+				      sitdpll->id);=0A=
+			goto err_unregister;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
+=0A=
+	return 0;=0A=
+=0A=
+err_unregister:=0A=
+	list_for_each_entry_continue_reverse(sitdpll, &sitdev->dplls, list)=0A=
+		sit9531x_dpll_unregister(sitdpll);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static void sit9531x_dev_stop(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+=0A=
+	kthread_cancel_delayed_work_sync(&sitdev->work);=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
+		if (sitdpll->dpll_dev)=0A=
+			sit9531x_dpll_unregister(sitdpll);=0A=
+	}=0A=
+}=0A=
+=0A=
+static struct sit9531x_dpll_pin *=0A=
+sit9531x_dpll_pin_alloc(struct sit9531x_dpll *sitdpll,=0A=
+			enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *pin;=0A=
+=0A=
+	pin =3D kzalloc_obj(*pin, GFP_KERNEL);=0A=
+	if (!pin)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	pin->dpll =3D sitdpll;=0A=
+	pin->dir =3D dir;=0A=
+	pin->id =3D id;=0A=
+=0A=
+	return pin;=0A=
+}=0A=
+=0A=
+/* @index is the pin's absolute index in the clock_id namespace. */=0A=
+static int sit9531x_dpll_pin_register(struct sit9531x_dpll_pin *pin,=0A=
+				      u32 index)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D pin->dpll;=0A=
+	struct sit9531x_pin_props *props;=0A=
+	const struct dpll_pin_ops *ops;=0A=
+	int rc;=0A=
+=0A=
+	props =3D sit9531x_pin_props_get(sitdpll->dev, pin->dir, pin->id);=0A=
+	if (IS_ERR(props))=0A=
+		return PTR_ERR(props);=0A=
+=0A=
+	strscpy(pin->label, props->package_label, sizeof(pin->label));=0A=
+	pin->fwnode =3D fwnode_handle_get(props->fwnode);=0A=
+=0A=
+	pin->dpll_pin =3D dpll_pin_get(sitdpll->dev->clock_id, index,=0A=
+				     THIS_MODULE, &props->dpll_props,=0A=
+				     &pin->tracker);=0A=
+	if (IS_ERR(pin->dpll_pin)) {=0A=
+		rc =3D PTR_ERR(pin->dpll_pin);=0A=
+		goto err_pin_get;=0A=
+	}=0A=
+	dpll_pin_fwnode_set(pin->dpll_pin, props->fwnode);=0A=
+=0A=
+	ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
+=0A=
+	rc =3D dpll_pin_register(sitdpll->dpll_dev, pin->dpll_pin, ops, pin);=0A=
+	if (rc)=0A=
+		goto err_register;=0A=
+=0A=
+	sit9531x_pin_props_put(props);=0A=
+=0A=
+	return 0;=0A=
+=0A=
+err_register:=0A=
+	dpll_pin_put(pin->dpll_pin, &pin->tracker);=0A=
+err_pin_get:=0A=
+	pin->dpll_pin =3D NULL;=0A=
+	fwnode_handle_put(pin->fwnode);=0A=
+	pin->fwnode =3D NULL;=0A=
+	sit9531x_pin_props_put(props);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_pin_unregister(struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D pin->dpll;=0A=
+	struct dpll_pin *dpll_pin =3D pin->dpll_pin;=0A=
+	const struct dpll_pin_ops *ops;=0A=
+=0A=
+	ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
+=0A=
+	/*=0A=
+	 * Clear before unregistering: callbacks test it under the DPLL device=0A=
+	 * lock, which dpll_pin_unregister() also takes.=0A=
+	 */=0A=
+	pin->dpll_pin =3D NULL;=0A=
+=0A=
+	dpll_pin_unregister(sitdpll->dpll_dev, dpll_pin, ops, pin);=0A=
+	dpll_pin_put(dpll_pin, &pin->tracker);=0A=
+=0A=
+	fwnode_handle_put(pin->fwnode);=0A=
+	pin->fwnode =3D NULL;=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_pins_unregister(struct sit9531x_dpll *sitdpll)=
=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	struct sit9531x_dpll_pin *pin, *next;=0A=
+	LIST_HEAD(dead);=0A=
+=0A=
+	/*=0A=
+	 * Not under multiop_lock: the unregister takes the DPLL device lock,=0A=
+	 * which nests outside it.=0A=
+	 */=0A=
+	list_for_each_entry(pin, &sitdpll->pins, list)=0A=
+		sit9531x_dpll_pin_unregister(pin);=0A=
+=0A=
+	/*=0A=
+	 * Detached under multiop_lock, which callbacks walking the list hold;=0A=
+	 * the poll is already canceled or not yet queued.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	list_splice_init(&sitdpll->pins, &dead);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	list_for_each_entry_safe(pin, next, &dead, list) {=0A=
+		list_del(&pin->list);=0A=
+		kfree(pin);=0A=
+	}=0A=
+}=0A=
+=0A=
+/* Check if the pin class has a state callback, which the DPLL core requir=
es */=0A=
+static bool sit9531x_dpll_pin_is_registrable(struct sit9531x_dpll *sitdpll=
,=0A=
+					     enum dpll_pin_direction dir,=0A=
+					     u8 index)=0A=
+{=0A=
+	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+		return false;=0A=
+=0A=
+	return index =3D=3D SIT9531X_MAX_INPUTS;=0A=
+}=0A=
+=0A=
+static int sit9531x_dpll_pins_register(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *pin;=0A=
+	enum dpll_pin_direction dir;=0A=
+	u8 id, index;=0A=
+	int rc;=0A=
+=0A=
+	for (index =3D 0; index < SIT9531X_NUM_PINS_TOTAL; index++) {=0A=
+		if (index < SIT9531X_NUM_INPUT_PINS) {=0A=
+			id =3D index;=0A=
+			dir =3D DPLL_PIN_DIRECTION_INPUT;=0A=
+		} else {=0A=
+			id =3D index - SIT9531X_NUM_INPUT_PINS;=0A=
+			dir =3D DPLL_PIN_DIRECTION_OUTPUT;=0A=
+		}=0A=
+=0A=
+		if (!sit9531x_dpll_pin_is_registrable(sitdpll, dir, id))=0A=
+			continue;=0A=
+=0A=
+		pin =3D sit9531x_dpll_pin_alloc(sitdpll, dir, id);=0A=
+		if (IS_ERR(pin)) {=0A=
+			rc =3D PTR_ERR(pin);=0A=
+			goto error;=0A=
+		}=0A=
+=0A=
+		rc =3D sit9531x_dpll_pin_register(pin, index);=0A=
+		if (rc) {=0A=
+			kfree(pin);=0A=
+			goto error;=0A=
+		}=0A=
+=0A=
+		/*=0A=
+		 * Earlier pins are already reachable from netlink, and the=0A=
+		 * walks over this list run under multiop_lock.=0A=
+		 */=0A=
+		mutex_lock(&sitdpll->dev->multiop_lock);=0A=
+		list_add(&pin->list, &sitdpll->pins);=0A=
+		mutex_unlock(&sitdpll->dev->multiop_lock);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+=0A=
+error:=0A=
+	sit9531x_dpll_pins_unregister(sitdpll);=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static int sit9531x_dpll_device_register(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	sitdpll->ops =3D sit9531x_dpll_device_ops;=0A=
+=0A=
+	sitdpll->dpll_dev =3D dpll_device_get(sitdev->clock_id, sitdpll->id,=0A=
+					    THIS_MODULE, &sitdpll->tracker);=0A=
+	if (IS_ERR(sitdpll->dpll_dev)) {=0A=
+		rc =3D PTR_ERR(sitdpll->dpll_dev);=0A=
+		sitdpll->dpll_dev =3D NULL;=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	rc =3D dpll_device_register(sitdpll->dpll_dev,=0A=
+				  sit9531x_prop_dpll_type_get(sitdev,=0A=
+							      sitdpll->id),=0A=
+				  &sitdpll->ops, sitdpll);=0A=
+	if (rc) {=0A=
+		dpll_device_put(sitdpll->dpll_dev, &sitdpll->tracker);=0A=
+		sitdpll->dpll_dev =3D NULL;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_device_unregister(struct sit9531x_dpll *sitdpll)=
=0A=
+{=0A=
+	dpll_device_unregister(sitdpll->dpll_dev, &sitdpll->ops, sitdpll);=0A=
+	dpll_device_put(sitdpll->dpll_dev, &sitdpll->tracker);=0A=
+	sitdpll->dpll_dev =3D NULL;=0A=
+}=0A=
+=0A=
+struct sit9531x_dpll *sit9531x_dpll_alloc(struct sit9531x_dev *sitdev, u8 =
ch)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+=0A=
+	sitdpll =3D kzalloc_obj(*sitdpll, GFP_KERNEL);=0A=
+	if (!sitdpll)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	sitdpll->dev =3D sitdev;=0A=
+	sitdpll->id =3D ch;=0A=
+	sitdpll->lock_status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	sitdpll->lock_status_error =3D DPLL_LOCK_STATUS_ERROR_NONE;=0A=
+	INIT_LIST_HEAD(&sitdpll->pins);=0A=
+=0A=
+	return sitdpll;=0A=
+}=0A=
+=0A=
+void sit9531x_dpll_free(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	kfree(sitdpll);=0A=
+}=0A=
+=0A=
+int sit9531x_dpll_register(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_dpll_device_register(sitdpll);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sit9531x_dpll_lock_status_baseline(sitdpll);=0A=
+=0A=
+	rc =3D sit9531x_dpll_pins_register(sitdpll);=0A=
+	if (rc) {=0A=
+		sit9531x_dpll_device_unregister(sitdpll);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	sit9531x_dpll_pins_unregister(sitdpll);=0A=
+	sit9531x_dpll_device_unregister(sitdpll);=0A=
+}=0A=
+=0A=
+static void sit9531x_dpll_list_free(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll, *next;=0A=
+=0A=
+	list_for_each_entry_safe(sitdpll, next, &sitdev->dplls, list) {=0A=
+		list_del(&sitdpll->list);=0A=
+		sit9531x_dpll_free(sitdpll);=0A=
+	}=0A=
+}=0A=
+=0A=
+/* Runs only once the device is fully started, see the caller. */=0A=
+static void sit9531x_dev_dpll_fini(void *ptr)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D ptr;=0A=
+=0A=
+	sit9531x_dev_stop(sitdev);=0A=
+	kthread_destroy_worker(sitdev->kworker);=0A=
+	sit9531x_dpll_list_free(sitdev);=0A=
+}=0A=
+=0A=
+static int sit9531x_devm_dpll_init(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct kthread_worker *kworker;=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+	unsigned int i;=0A=
+	int rc;=0A=
+=0A=
+	INIT_LIST_HEAD(&sitdev->dplls);=0A=
+	kthread_init_delayed_work(&sitdev->work, sit9531x_dev_periodic_work);=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		sitdpll =3D sit9531x_dpll_alloc(sitdev, i);=0A=
+		if (IS_ERR(sitdpll)) {=0A=
+			rc =3D dev_err_probe(sitdev->dev, PTR_ERR(sitdpll),=0A=
+					   "Failed to alloc DPLL%u\n", i);=0A=
+			goto err_free_dplls;=0A=
+		}=0A=
+=0A=
+		list_add_tail(&sitdpll->list, &sitdev->dplls);=0A=
+	}=0A=
+=0A=
+	kworker =3D kthread_run_worker(0, "sit9531x-%s", dev_name(sitdev->dev));=
=0A=
+	if (IS_ERR(kworker)) {=0A=
+		rc =3D PTR_ERR(kworker);=0A=
+		goto err_free_dplls;=0A=
+	}=0A=
+	sitdev->kworker =3D kworker;=0A=
+=0A=
+	rc =3D sit9531x_dev_start(sitdev);=0A=
+	if (rc) {=0A=
+		rc =3D dev_err_probe(sitdev->dev, rc, "Failed to start device\n");=0A=
+		goto err_destroy_worker;=0A=
+	}=0A=
+=0A=
+	/* Added last: only now is every field the cleanup touches valid. */=0A=
+	return devm_add_action_or_reset(sitdev->dev, sit9531x_dev_dpll_fini,=0A=
+					sitdev);=0A=
+=0A=
+err_destroy_worker:=0A=
+	kthread_destroy_worker(sitdev->kworker);=0A=
+err_free_dplls:=0A=
+	sit9531x_dpll_list_free(sitdev);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/* See SIT9531X_REG_VARIANT_ID: one byte, reg 0x03 is not part of it. */=
=0A=
+static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)=
=0A=
+{=0A=
+	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);=0A=
+}=0A=
+=0A=
+static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)=0A=
+{=0A=
+	unsigned int i;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {=0A=
+		if (sit9531x_chip_ids[i].id =3D=3D id)=0A=
+			return &sit9531x_chip_ids[i];=0A=
+	}=0A=
+=0A=
+	return NULL;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Build the clock id from the SiTime OUI, the I2C bus number and the I2C=
=0A=
+ * address.=0A=
+ */=0A=
+static int sit9531x_derive_clock_id(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int adap =3D i2c_adapter_id(sitdev->client->adapter);=0A=
+=0A=
+	/*=0A=
+	 * The OUI with its EUI-64 filler takes the top 40 bits; the bus gets 16=
=0A=
+	 * bits.=0A=
+	 */=0A=
+	if (adap > U16_MAX)=0A=
+		return dev_err_probe(sitdev->dev, -EINVAL,=0A=
+				     "I2C adapter number %d does not fit the clock id\n",=0A=
+				     adap);=0A=
+=0A=
+	sitdev->clock_id =3D SIT9531X_OUI << 24 | (u64)adap << 8 |=0A=
+			   sitdev->client->addr;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct clk *xtal_clk;=0A=
+	u8 variant_id;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Request before enabling the XO: a probe deferral would gate the XO=0A=
+	 * and remove the reference of a running part.=0A=
+	 */=0A=
+	sitdev->reset_gpio =3D devm_gpiod_get_optional(sitdev->dev, "reset",=0A=
+						     GPIOD_ASIS);=0A=
+	if (IS_ERR(sitdev->reset_gpio))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),=0A=
+				     "Failed to request reset gpio\n");=0A=
+=0A=
+	/* Every rate the driver derives starts from the XO feeding XIN. */=0A=
+	xtal_clk =3D devm_clk_get_optional_enabled(sitdev->dev, "xtal");=0A=
+	if (IS_ERR(xtal_clk))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),=0A=
+				     "Failed to get xtal clock\n");=0A=
+	sitdev->xtal_freq =3D clk_get_rate(xtal_clk);=0A=
+	if (!sitdev->xtal_freq) {=0A=
+		u32 freq;=0A=
+=0A=
+		if (!device_property_read_u32(sitdev->dev, "clock-frequency",=0A=
+					      &freq))=0A=
+			sitdev->xtal_freq =3D freq;=0A=
+	}=0A=
+	if (!sitdev->xtal_freq)=0A=
+		return dev_err_probe(sitdev->dev, -EINVAL,=0A=
+				     "no xtal rate: provide clocks=3D<&xo> + clock-names=3D\"xtal\", o=
r a clock-frequency property\n");=0A=
+=0A=
+	/*=0A=
+	 * Keep reset deasserted, never pulse it: a reset discards the=0A=
+	 * configuration from efuse or a pre-probe NVM blob. Release it before=0A=
+	 * the first I2C access.=0A=
+	 */=0A=
+	if (sitdev->reset_gpio) {=0A=
+		rc =3D gpiod_direction_output(sitdev->reset_gpio, 0);=0A=
+		if (rc)=0A=
+			return dev_err_probe(sitdev->dev, rc,=0A=
+					     "Failed to release the reset line\n");=0A=
+		fsleep(10000);	/* internal boot after release */=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->info =3D sit9531x_match_variant(variant_id);=0A=
+	if (!sitdev->info)=0A=
+		return dev_err_probe(sitdev->dev, -ENODEV,=0A=
+				     "Unknown variant ID: 0x%02x\n",=0A=
+				     variant_id);=0A=
+=0A=
+	rc =3D sit9531x_derive_clock_id(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->intsync_src =3D -1;=0A=
+=0A=
+	rc =3D devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return dev_err_probe(sitdev->dev, rc,=0A=
+				     "Failed to initialize mutex\n");=0A=
+=0A=
+	dev_info(sitdev->dev, "%s detected, %u inputs, %u outputs\n",=0A=
+		 sitdev->info->name, sitdev->info->num_inputs,=0A=
+		 sitdev->info->num_outputs);=0A=
+=0A=
+	/* Before the IRQ: the handler queues work on sitdev->kworker. */=0A=
+	rc =3D sit9531x_devm_dpll_init(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Without an "interrupts" property client->irq is 0 and only the poll=0A=
+	 * runs.=0A=
+	 */=0A=
+	sitdev->irq =3D sitdev->client->irq;=0A=
+	if (sitdev->irq > 0) {=0A=
+		rc =3D devm_request_threaded_irq(sitdev->dev, sitdev->irq,=0A=
+					       NULL, sit9531x_irq_thread_fn,=0A=
+					       IRQF_ONESHOT,=0A=
+					       dev_name(sitdev->dev), sitdev);=0A=
+		if (rc)=0A=
+			return dev_err_probe(sitdev->dev, rc,=0A=
+					     "Failed to request IRQ %d\n",=0A=
+					     sitdev->irq);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_i2c_probe(struct i2c_client *client)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev;=0A=
+	struct regmap *regmap;=0A=
+	int rc;=0A=
+=0A=
+	regmap =3D devm_regmap_init_i2c(client, &sit9531x_regmap_config);=0A=
+	if (IS_ERR(regmap))=0A=
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),=0A=
+				     "Failed to initialize regmap\n");=0A=
+=0A=
+	sitdev =3D devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);=0A=
+	if (!sitdev)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	sitdev->dev =3D &client->dev;=0A=
+	sitdev->client =3D client;=0A=
+	sitdev->regmap =3D regmap;=0A=
+	sitdev->page =3D -1;=0A=
+	rc =3D devm_mutex_init(&client->dev, &sitdev->page_lock);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	i2c_set_clientdata(client, sitdev);=0A=
+=0A=
+	return sit9531x_dev_probe(sitdev);=0A=
+}=0A=
+=0A=
+static const struct of_device_id sit9531x_of_match[] =3D {=0A=
+	{ .compatible =3D "sitime,sit95316" },=0A=
+	{ .compatible =3D "sitime,sit95317" },=0A=
+	{ }=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, sit9531x_of_match);=0A=
+=0A=
+/*=0A=
+ * Stop the poll and the IRQ across suspend so no paged I2C sequence reach=
es a=0A=
+ * suspended adapter; the poll worker is not freezable.=0A=
+ */=0A=
+static int sit9531x_suspend(struct device *dev)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D dev_get_drvdata(dev);=0A=
+=0A=
+	if (sitdev->irq > 0)=0A=
+		disable_irq(sitdev->irq);=0A=
+	kthread_cancel_delayed_work_sync(&sitdev->work);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_resume(struct device *dev)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D dev_get_drvdata(dev);=0A=
+=0A=
+	/* After power loss the part is on page 0, not the cached page */=0A=
+	sit9531x_page_cache_drop(sitdev);=0A=
+	if (sitdev->irq > 0)=0A=
+		enable_irq(sitdev->irq);=0A=
+	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static DEFINE_SIMPLE_DEV_PM_OPS(sit9531x_pm_ops,=0A=
+				sit9531x_suspend, sit9531x_resume);=0A=
 =0A=
 static struct i2c_driver sit9531x_i2c_driver =3D {=0A=
 	.driver			=3D {=0A=
 		.name		=3D "sit9531x",=0A=
 		.of_match_table	=3D sit9531x_of_match,=0A=
+		.pm		=3D pm_sleep_ptr(&sit9531x_pm_ops),=0A=
 	},=0A=
 	.probe		=3D sit9531x_i2c_probe,=0A=
 };=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 7a81c9b14b7f..9e873432df3d 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -15,6 +15,8 @@=0A=
 =0A=
 #include <linux/gpio/consumer.h>=0A=
 #include <linux/i2c.h>=0A=
+#include <linux/kthread.h>=0A=
+#include <linux/list.h>=0A=
 #include <linux/mutex.h>=0A=
 #include <linux/regmap.h>=0A=
 #include <linux/types.h>=0A=
@@ -32,6 +34,20 @@=0A=
  */=0A=
 #define SIT9531X_INTSYNC_PIN_ID		(SIT9531X_MAX_INPUTS + 1)=0A=
 #define SIT9531X_INTSYNC_OUT_PIN_ID	SIT9531X_MAX_OUTPUTS=0A=
+#define SIT9531X_STATUS_POLL_MS		500=0A=
+/*=0A=
+ * Consecutive polls with no answer after which the poll period stops doub=
ling:=0A=
+ * eight periods, 4 s.=0A=
+ */=0A=
+#define SIT9531X_POLL_STRETCH_MAX	3=0A=
+=0A=
+/* selected_ref value when the active source is not a registered input */=
=0A=
+#define SIT9531X_REF_INVALID		0xFF=0A=
+=0A=
+/* SiTime IEEE OUI for EUI-64 generation */=0A=
+#define SIT9531X_OUI			0x0090C2FFFEULL=0A=
+=0A=
+struct sit9531x_dpll;=0A=
 =0A=
 /*=0A=
  * struct sit9531x_chip_info - chip variant identification=0A=
@@ -62,36 +78,104 @@ enum sit9531x_signal_mode {=0A=
 /*=0A=
  * struct sit9531x_ref - input reference state=0A=
  * @freq: configured frequency in Hz=0A=
+ * @enabled: input receiver is on=0A=
+ * @pll_mask: PLLs this input feeds (bit 0 =3D PLLA)=0A=
  * @sig_mode: signal mode of the input pair, read from CLKINx_INPUT_MODE a=
t=0A=
  *   probe=0A=
  */=0A=
 struct sit9531x_ref {=0A=
 	u64		freq;=0A=
+	bool		enabled;=0A=
+	u8		pll_mask;=0A=
 	enum sit9531x_signal_mode	sig_mode;=0A=
 };=0A=
 =0A=
 /*=0A=
  * struct sit9531x_out - output state=0A=
  * @freq: output frequency in Hz=0A=
+ * @enabled: output is driving, not forced into Hi-Z=0A=
+ * @cmos: single-ended; the CMOS pad Hi-Z pairs apply, not the differentia=
l one=0A=
+ * @part_muted: single-ended with one pad forced and the other not; report=
ed=0A=
+ *   as driven. The driver's mute forces both pads.=0A=
+ * @routed: mapped to @pll_idx by the initial configuration; an unrouted=
=0A=
+ *   output has no pin=0A=
+ * @pll_idx: PLL driving this output (0-3)=0A=
  */=0A=
 struct sit9531x_out {=0A=
 	u64		freq;=0A=
+	bool		enabled;=0A=
+	bool		cmos;=0A=
+	bool		part_muted;=0A=
+	bool		routed;=0A=
+	u8		pll_idx;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_chan - per-PLL channel state=0A=
+ * @active: PLL reached its active state; an unused PLL never does and its=
=0A=
+ *   loss-of-lock bit stays clear=0A=
+ * @locked: PLL is active and its outer loop reports lock=0A=
+ * @stale: last state read failed; the fields hold the previous sample and=
=0A=
+ *   are not reported=0A=
+ * @mode: 0 =3D sync (outer loop enabled), 1 =3D free-run=0A=
+ * @selected_ref: logical index of the selected reference (INTSYNC:=0A=
+ *   SIT9531X_INTSYNC_PIN_ID), or SIT9531X_REF_INVALID for a reserved code=
=0A=
+ * @inner_lol: inner loop loss of lock=0A=
+ * @ho_freeze: holdover freeze active=0A=
+ * @ho_valid: holdover memory holds a valid estimate=0A=
+ * @manual_input: PLL uses its manual input select (pins or=0A=
+ *   GPIO_INPUT_FUNC_CTRL5..8), which table writes do not change; reported=
=0A=
+ *   as MANUAL=0A=
+ * @prio_mask: bit per canonical source in the priority table read back=0A=
+ *   from hardware=0A=
+ * @cfg_prio: configured priority of each canonical source, listed or not;=
=0A=
+ *   the table is built from it=0A=
+ * @cfg_known: bit per canonical source that has a @cfg_prio=0A=
+ * @seen_srcs: table last written or read into @cfg_prio; a read-back that=
=0A=
+ *   differs reloads @cfg_prio from hardware=0A=
+ * @seen_valid: @seen_srcs holds a table=0A=
+ */=0A=
+struct sit9531x_chan {=0A=
+	bool		active;=0A=
+	bool		locked;=0A=
+	bool		stale;=0A=
+	u8		mode;=0A=
+	u8		selected_ref;=0A=
+	bool		inner_lol;=0A=
+	bool		ho_freeze;=0A=
+	bool		ho_valid;=0A=
+	bool		manual_input;=0A=
+	u16		prio_mask;=0A=
+	u8		cfg_prio[SIT9531X_PRIO_NUM_SRC];=0A=
+	u16		cfg_known;=0A=
+	u8		seen_srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	bool		seen_valid;=0A=
 };=0A=
 =0A=
 /*=0A=
  * struct sit9531x_dev - SiT9531x device instance=0A=
+ * @info: chip variant info=0A=
  * @dev: parent device=0A=
  * @client: I2C client backing @regmap=0A=
  * @regmap: the 256-byte register window=0A=
- * @info: chip variant info=0A=
+ * @dplls: registered DPLL devices=0A=
  * @multiop_lock: serializes multi-register operations=0A=
  * @page_lock: held across a page select and its transfer; nests inside=0A=
  *   @multiop_lock=0A=
  * @page: current page, -1 when unknown=0A=
  * @ref: input reference states=0A=
  * @out: output states=0A=
+ * @chan: per-PLL channel states=0A=
  * @xtal_freq: crystal frequency in Hz=0A=
+ * @kworker: poll worker=0A=
+ * @work: poll work=0A=
+ * @poll_fails: consecutive failed polls, up to SIT9531X_POLL_STRETCH_MAX;=
=0A=
+ *   each doubles the period=0A=
+ * @clock_id: EUI-64 clock identifier=0A=
  * @reset_gpio: optional reset line, NULL if absent=0A=
+ * @irq: optional INTRB IRQ, 0 if not wired=0A=
+ * @intsync_src: PLL sourcing INTSYNC, or -1=0A=
+ * @irq_ack_fails: consecutive failed INTRB acknowledgements=0A=
  */=0A=
 struct sit9531x_dev {=0A=
 	struct device			*dev;=0A=
@@ -104,13 +188,42 @@ struct sit9531x_dev {=0A=
 	struct mutex			page_lock;=0A=
 	int				page;=0A=
 =0A=
+	u8			irq_ack_fails;=0A=
 	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */=0A=
 	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];=0A=
+	struct sit9531x_chan	chan[SIT9531X_NUM_PLLS];=0A=
 	u32			xtal_freq;=0A=
 =0A=
+	struct list_head	dplls;=0A=
+=0A=
+	struct kthread_worker		*kworker;=0A=
+	struct kthread_delayed_work	work;=0A=
+	u8				poll_fails;=0A=
+=0A=
+	u64			clock_id;=0A=
+=0A=
 	struct gpio_desc	*reset_gpio;=0A=
+	int			irq;=0A=
+=0A=
+	s8			intsync_src;=0A=
 };=0A=
 =0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		     u8 *val);=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		      u8 val);=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			 u8 offset, u8 *val);=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			  u8 offset, u8 val);=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			   u8 offset, u8 mask, u8 val);=0A=
+=0A=
+static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
+{=0A=
+	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input index 2n is the P lane and 2n + 1 the N lane of pair n; index=0A=
  * SIT9531X_MAX_INPUTS is the XO.=0A=
@@ -126,19 +239,52 @@ static inline bool sit9531x_input_is_n(u8 index)=0A=
 	return index & 1;=0A=
 }=0A=
 =0A=
-/* Register page of PLL @pll_idx (0 =3D PLLA, 3 =3D PLLD). */=0A=
-static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
+static inline u8 sit9531x_input_hw_src(u8 index)=0A=
 {=0A=
-	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
+	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+		return SIT9531X_PRIO_SRC_OCXO;=0A=
+	if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		return SIT9531X_PRIO_SRC_INTSYNC;=0A=
+	if (sit9531x_input_is_n(index))=0A=
+		return SIT9531X_PRIO_SRC_N_BASE + sit9531x_input_pair(index);=0A=
+	return sit9531x_input_pair(index);=0A=
+}=0A=
+=0A=
+static inline u8 sit9531x_hw_src_input(u8 src)=0A=
+{=0A=
+	if (src < SIT9531X_NUM_INPUT_PAIRS)=0A=
+		return src * 2;=0A=
+	if (src =3D=3D SIT9531X_PRIO_SRC_OCXO)=0A=
+		return SIT9531X_MAX_INPUTS;=0A=
+	if (src =3D=3D SIT9531X_PRIO_SRC_INTSYNC)=0A=
+		return SIT9531X_INTSYNC_PIN_ID;=0A=
+	if (src >=3D SIT9531X_PRIO_SRC_N_BASE &&=0A=
+	    src < SIT9531X_PRIO_SRC_N_BASE + SIT9531X_NUM_INPUT_PAIRS)=0A=
+		return (src - SIT9531X_PRIO_SRC_N_BASE) * 2 + 1;=0A=
+	return SIT9531X_REF_INVALID;=0A=
+}=0A=
+=0A=
+static inline bool sit9531x_prio_src_usable(u8 src)=0A=
+{=0A=
+	return sit9531x_hw_src_input(src) !=3D SIT9531X_REF_INVALID;=0A=
 }=0A=
 =0A=
-int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 *va=
l);=0A=
-int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 va=
l);=0A=
-int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offse=
t,=0A=
-			 u8 *val);=0A=
-int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offs=
et,=0A=
-			  u8 val);=0A=
-int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 off=
set,=0A=
-			   u8 mask, u8 val);=0A=
+static inline const struct sit9531x_ref *=0A=
+sit9531x_ref_state_get(const struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	return &sitdev->ref[index];=0A=
+}=0A=
+=0A=
+static inline const struct sit9531x_out *=0A=
+sit9531x_out_state_get(const struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	return &sitdev->out[index];=0A=
+}=0A=
+=0A=
+static inline const struct sit9531x_chan *=0A=
+sit9531x_chan_state_get(const struct sit9531x_dev *sitdev, u8 pll_idx)=0A=
+{=0A=
+	return &sitdev->chan[pll_idx];=0A=
+}=0A=
 =0A=
 #endif /* _SIT9531X_CORE_H */=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
new file mode 100644=0A=
index 000000000000..6d676fabf13e=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -0,0 +1,295 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL subsystem callbacks and registration=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * DPLL device ops, pin ops (separate input/output), pin registration,=0A=
+ * and periodic change detection.=0A=
+ */=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/err.h>=0A=
+#include <linux/kthread.h>=0A=
+#include <linux/list.h>=0A=
+#include <linux/netlink.h>=0A=
+#include <linux/slab.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "dpll.h"=0A=
+#include "prop.h"=0A=
+#include "regs.h"=0A=
+=0A=
+static bool sit9531x_dpll_is_input_pin(const struct sit9531x_dpll_pin *pin=
)=0A=
+{=0A=
+	return pin->dir =3D=3D DPLL_PIN_DIRECTION_INPUT;=0A=
+}=0A=
+=0A=
+static bool=0A=
+sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_MAX_INPUTS;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Report the lock status from the last poll: outer LOL (page 0 reg 0x06),=
 PLL=0A=
+ * mode (PLL page reg 0x31), inner LOL (reg 0x92), holdover freeze (reg 0x=
0A)=0A=
+ * and holdover-valid (PLL page reg 0x06).=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_p=
riv,=0A=
+			      enum dpll_lock_status *status,=0A=
+			      enum dpll_lock_status_error *status_error,=0A=
+			      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	if (status_error)=0A=
+		*status_error =3D DPLL_LOCK_STATUS_ERROR_NONE;=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (chan->stale) {=0A=
+		*status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+		if (status_error)=0A=
+			*status_error =3D DPLL_LOCK_STATUS_ERROR_UNDEFINED;=0A=
+	} else if (!chan->active) {=0A=
+		/*=0A=
+		 * An unused PLL never goes active and its loss-of-lock bit is=0A=
+		 * not driven.=0A=
+		 */=0A=
+		*status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	} else if (chan->inner_lol) {=0A=
+		/*=0A=
+		 * The core reports the error detail only with an unlocked or=0A=
+		 * holdover status.=0A=
+		 */=0A=
+		*status =3D chan->ho_freeze ? DPLL_LOCK_STATUS_HOLDOVER :=0A=
+					    DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	} else if (chan->mode) {=0A=
+		/*=0A=
+		 * In free-run the outer loop is disabled and its loss-of-lock=0A=
+		 * bit is meaningless.=0A=
+		 */=0A=
+		*status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	} else if (chan->ho_freeze) {=0A=
+		/*=0A=
+		 * Test freeze before lock: a frozen PLL tracks no reference=0A=
+		 * whatever its outer loss-of-lock bit reads.=0A=
+		 */=0A=
+		*status =3D DPLL_LOCK_STATUS_HOLDOVER;=0A=
+	} else if (chan->locked) {=0A=
+		if (chan->ho_valid)=0A=
+			*status =3D DPLL_LOCK_STATUS_LOCKED_HO_ACQ;=0A=
+		else=0A=
+			*status =3D DPLL_LOCK_STATUS_LOCKED;=0A=
+	} else {=0A=
+		*status =3D DPLL_LOCK_STATUS_UNLOCKED;=0A=
+	}=0A=
+=0A=
+	if (status_error && chan->inner_lol)=0A=
+		*status_error =3D DPLL_LOCK_STATUS_ERROR_UNDEFINED;=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Record the lock status the create notification carried as the poll base=
line.=0A=
+ * Call once the device is registered.=0A=
+ */=0A=
+void sit9531x_dpll_lock_status_baseline(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	sit9531x_dpll_lock_status_get(sitdpll->dpll_dev, sitdpll,=0A=
+				      &sitdpll->lock_status,=0A=
+				      &sitdpll->lock_status_error, NULL);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Report AUTOMATIC for a PLL on its priority table, also on manual active=
=0A=
+ * select, which uses the same nibble, and MANUAL on manual input select=
=0A=
+ * (MISCINNER_PLL bit 5), where the select pins or GPIO_INPUT_FUNC_CTRL5..=
8=0A=
+ * choose the input. Free-run (PLL page reg 0x31[5]) shows in the lock sta=
tus.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,=0A=
+		       enum dpll_mode *mode, struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+=0A=
+	/* Read once at probe, before the device is registered. */=0A=
+	if (sit9531x_chan_state_get(sitdpll->dev, sitdpll->id)->manual_input)=0A=
+		*mode =3D DPLL_MODE_MANUAL;=0A=
+	else=0A=
+		*mode =3D DPLL_MODE_AUTOMATIC;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_supported_modes_get(const struct dpll_device *dpll,=0A=
+				  void *dpll_priv, unsigned long *modes,=0A=
+				  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+=0A=
+	if (sit9531x_chan_state_get(sitdpll->dev, sitdpll->id)->manual_input)=0A=
+		__set_bit(DPLL_MODE_MANUAL, modes);=0A=
+	else=0A=
+		__set_bit(DPLL_MODE_AUTOMATIC, modes);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+const struct dpll_device_ops sit9531x_dpll_device_ops =3D {=0A=
+	.lock_status_get	=3D sit9531x_dpll_lock_status_get,=0A=
+	.mode_get		=3D sit9531x_dpll_mode_get,=0A=
+	.supported_modes_get	=3D sit9531x_dpll_supported_modes_get,=0A=
+};=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,=0A=
+				      void *pin_priv,=0A=
+				      const struct dpll_device *dpll,=0A=
+				      void *dpll_priv,=0A=
+				      enum dpll_pin_direction *direction,=0A=
+				      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	*direction =3D DPLL_PIN_DIRECTION_INPUT;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * INTSYNC is the inter-PLL sync line: one PLL drives it and other PLLs ma=
y lock=0A=
+ * to it. Each DPLL registers a source pin to drive the line and a destina=
tion=0A=
+ * pin to lock to it.=0A=
+ */=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv,=0A=
+				       enum dpll_pin_direction *direction,=0A=
+				       struct netlink_ext_ack *extack);=0A=
+=0A=
+/* The XO feeds every PLL and is always connected. */=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_xo_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv,=0A=
+				       enum dpll_pin_state *state,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_xo_pin_ops =3D {=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_xo_pin_state_on_dpll_get,=0A=
+};=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv,=0A=
+				       enum dpll_pin_direction *direction,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	*direction =3D DPLL_PIN_DIRECTION_OUTPUT;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
+	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
+};=0A=
+=0A=
+const struct dpll_pin_ops *=0A=
+sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	if (!sit9531x_dpll_is_input_pin(pin))=0A=
+		return &sit9531x_dpll_output_pin_ops;=0A=
+	if (sit9531x_dpll_is_xo_pin(pin))=0A=
+		return &sit9531x_dpll_xo_pin_ops;=0A=
+	return &sit9531x_dpll_input_pin_ops;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Send notifications for changed lock status and pin state; called from=
=0A=
+ * sit9531x_dev_periodic_work().=0A=
+ */=0A=
+void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	enum dpll_lock_status_error status_error =3D DPLL_LOCK_STATUS_ERROR_NONE;=
=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	enum dpll_lock_status lock_status;=0A=
+	struct sit9531x_dpll_pin *pin;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_dpll_lock_status_get(sitdpll->dpll_dev, sitdpll,=0A=
+					   &lock_status, &status_error, NULL);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev, "Failed to get DPLL%u lock status: %d\n",=0A=
+			sitdpll->id, rc);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The core publishes the error detail with the status, so a change in=0A=
+	 * either is notified.=0A=
+	 */=0A=
+	if (sitdpll->lock_status !=3D lock_status ||=0A=
+	    sitdpll->lock_status_error !=3D status_error) {=0A=
+		sitdpll->lock_status =3D lock_status;=0A=
+		sitdpll->lock_status_error =3D status_error;=0A=
+		sitdpll->ntf_pending =3D true;=0A=
+	}=0A=
+=0A=
+	if (sitdpll->ntf_pending && !dpll_device_change_ntf(sitdpll->dpll_dev))=
=0A=
+		sitdpll->ntf_pending =3D false;=0A=
+=0A=
+	list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
+		const struct dpll_pin_ops *ops;=0A=
+		enum dpll_pin_state state;=0A=
+		bool changed;=0A=
+=0A=
+		/*=0A=
+		 * Only references and the INTSYNC destination change state=0A=
+		 * without a request.=0A=
+		 */=0A=
+		if (!sit9531x_dpll_is_input_pin(pin) ||=0A=
+		    sit9531x_dpll_is_xo_pin(pin))=0A=
+			continue;=0A=
+=0A=
+		ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
+		rc =3D ops->state_on_dpll_get(pin->dpll_pin, pin,=0A=
+					    sitdpll->dpll_dev, sitdpll,=0A=
+					    &state, NULL);=0A=
+		if (rc)=0A=
+			continue;=0A=
+=0A=
+		changed =3D pin->seen && state !=3D pin->pin_state;=0A=
+		pin->pin_state =3D state;=0A=
+		pin->seen =3D true;=0A=
+		if (changed) {=0A=
+			dev_dbg(sitdev->dev, "%s state changed\n", pin->label);=0A=
+			dpll_pin_change_ntf(pin->dpll_pin);=0A=
+		}=0A=
+	}=0A=
+}=0A=
diff --git a/drivers/dpll/sit9531x/dpll.h b/drivers/dpll/sit9531x/dpll.h=0A=
new file mode 100644=0A=
index 000000000000..6c02aa131328=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/dpll.h=0A=
@@ -0,0 +1,61 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL subsystem interface=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * DPLL device and pin structures, and function declarations for=0A=
+ * the DPLL registration and callback layer.=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_DPLL_H=0A=
+#define _SIT9531X_DPLL_H=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/list.h>=0A=
+#include <linux/types.h>=0A=
+=0A=
+struct sit9531x_dev;=0A=
+=0A=
+struct sit9531x_dpll_pin {=0A=
+	struct list_head		list;=0A=
+	struct sit9531x_dpll		*dpll;=0A=
+	struct dpll_pin			*dpll_pin;=0A=
+	dpll_tracker			tracker;=0A=
+	struct fwnode_handle		*fwnode;=0A=
+	char				label[8];	/* "IN0", "OUT3" */=0A=
+	enum dpll_pin_direction		dir;=0A=
+	u8				id;		/* hardware index */=0A=
+	u8				prio;=0A=
+	enum dpll_pin_state		pin_state;=0A=
+	bool				seen;	/* baseline taken by the poll */=0A=
+};=0A=
+=0A=
+struct sit9531x_dpll {=0A=
+	struct list_head		list;=0A=
+	struct sit9531x_dev		*dev;=0A=
+	struct dpll_device		*dpll_dev;=0A=
+	dpll_tracker			tracker;=0A=
+	struct dpll_device_ops		ops;	/* per-instance copy */=0A=
+	struct list_head		pins;=0A=
+	u8				id;	/* 0 =3D PLLA .. 3 =3D PLLD */=0A=
+	enum dpll_lock_status		lock_status;=0A=
+	enum dpll_lock_status_error	lock_status_error;=0A=
+	bool				ntf_pending;=0A=
+};=0A=
+=0A=
+extern const struct dpll_device_ops sit9531x_dpll_device_ops;=0A=
+const struct dpll_pin_ops *=0A=
+sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin);=0A=
+=0A=
+struct sit9531x_dpll *sit9531x_dpll_alloc(struct sit9531x_dev *sitdev, u8 =
ch);=0A=
+void sit9531x_dpll_free(struct sit9531x_dpll *sitdpll);=0A=
+int  sit9531x_dpll_register(struct sit9531x_dpll *sitdpll);=0A=
+void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdpll);=0A=
+=0A=
+void sit9531x_dpll_lock_status_baseline(struct sit9531x_dpll *sitdpll);=0A=
+void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll);=0A=
+=0A=
+#endif /* _SIT9531X_DPLL_H */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 3a6151f44d61..832d0360a398 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -30,6 +30,211 @@=0A=
 /* Reg 0x03 holds an unrelated revision byte, not part of the variant ID *=
/=0A=
 #define SIT9531X_REG_VARIANT_ID		SIT9531X_REG(0x00, 0x02)=0A=
 =0A=
+/* PLL inner loop loss-of-lock */=0A=
+#define SIT9531X_REG_PLL_INNER_LOL_STATUS	SIT9531X_REG(0x00, 0x92)=0A=
+#define SIT9531X_REG_PLL_INNER_LOL_NOTIF	SIT9531X_REG(0x00, 0x93)=0A=
+=0A=
+/* Clock monitor PLL / XO status */=0A=
+#define SIT9531X_REG_CMON_NOTIF		SIT9531X_REG(0x00, 0x9E)=0A=
+=0A=
+/* PLL outer-loop loss-of-lock */=0A=
+#define SIT9531X_REG_OUTER_LOL_STATUS	SIT9531X_REG(0x00, 0x06)=0A=
+#define SIT9531X_REG_OUTER_LOL_NOTIF		SIT9531X_REG(0x00, 0x07)=0A=
+=0A=
+/* PLL holdover freeze status */=0A=
+#define SIT9531X_REG_HO_FREEZE_STATUS	SIT9531X_REG(0x00, 0x0A)=0A=
+#define SIT9531X_REG_HO_FREEZE_NOTIF	SIT9531X_REG(0x00, 0x0B)=0A=
+=0A=
+/* INTSYNC (inter-PLL synchronization) global enable */=0A=
+#define SIT9531X_REG_INTSYNC_GLOBAL		SIT9531X_REG(0x00, 0x40)=0A=
+#define SIT9531X_INTSYNC_EN_BIT		6=0A=
+=0A=
+/*=0A=
+ * Priority table: six registers per PLL from 0x16 + 6 * PLL, holding slot=
s=0A=
+ * 0-10 and the active-reference nibble; slot 2n in [7:4], 2n+1 in [3:0].=
=0A=
+ *=0A=
+ * Source encoding (4-bit):=0A=
+ *   0-3 =3D IN0P-IN3P, 5 =3D OCXO, 6 =3D INTSYNC, 7-10 =3D IN0N-IN3N=0A=
+ *=0A=
+ * Codes 4 and 11 take the place of a fifth input pair; they read back as =
no=0A=
+ * valid reference.=0A=
+ */=0A=
+#define SIT9531X_PAGE_PRIOSYS		0x01=0A=
+#define SIT9531X_PRIO_BASE_REG		0x16=0A=
+#define SIT9531X_PRIO_REGS_PER_PLL		6=0A=
+#define SIT9531X_PRIO_SLOTS_PER_REG		2=0A=
+/*=0A=
+ * CLK_SPARE0SEL_PLL..CLK_SPARE10SEL_PLL; the twelfth nibble is=0A=
+ * CLK_ACTIVESEL_PLL.=0A=
+ */=0A=
+#define SIT9531X_PRIO_MAX_SLOTS		11=0A=
+/* Number of source encodings (0-11), unrelated to the slot count */=0A=
+#define SIT9531X_PRIO_NUM_SRC		12=0A=
+#define SIT9531X_PRIO_NIBBLE_MASK		0x0F=0A=
+#define SIT9531X_PRIO_HI_SHIFT		4=0A=
+/* Codes 4 and 11 both mean no source; the driver writes 4 to empty a slot=
. */=0A=
+#define SIT9531X_PRIO_SRC_NONE			4=0A=
+#define SIT9531X_PRIO_SRC_OCXO		5=0A=
+#define SIT9531X_PRIO_SRC_INTSYNC		6=0A=
+#define SIT9531X_PRIO_SRC_N_BASE		7=0A=
+/*=0A=
+ * Low nibble of the last priority register: CLK_ACTIVESEL_PLL, the PLL's =
active=0A=
+ * reference, in the same encoding.=0A=
+ */=0A=
+#define SIT9531X_PRIO_ACTIVESEL_OFF		5=0A=
+=0A=
+/*=0A=
+ * PRG_Directives_GENERIC_0; every page has a copy at offset 0x0F:=0A=
+ *   bit 6  proceed from the PRG_CMD state to loop lock / active state=0A=
+ *   bit 4  update the NVM bank from the efuse=0A=
+ *   bit 3  read the efuse into the volatile registers=0A=
+ *   bit 2  program the efuse (the driver never issues it)=0A=
+ *   bit 1  small change update=0A=
+ *   bit 0  escape to the PRG_CMD state=0A=
+ * PRG_CMD sequences close with bit 4, as the documented sequences do.=0A=
+ */=0A=
+#define SIT9531X_REG_GLOBAL_UPDATE		SIT9531X_REG(0x00, 0x0F)=0A=
+#define SIT9531X_SMALL_UPDATE_CMD		0x02=0A=
+=0A=
+/* One bit per input PAIR (bit 0 =3D CLKIN0, ..., bit 3 =3D CLKIN3) */=0A=
+#define SIT9531X_REG_IN_DE_FORCE		SIT9531X_REG(0x02, 0xE8)=0A=
+#define SIT9531X_REG_IN_DE_STATE		SIT9531X_REG(0x02, 0xE9)=0A=
+#define SIT9531X_REG_IN_SEP_FORCE		SIT9531X_REG(0x02, 0xEA)=0A=
+#define SIT9531X_REG_IN_SEP_STATE		SIT9531X_REG(0x02, 0xEB)=0A=
+#define SIT9531X_REG_IN_SEN_FORCE		SIT9531X_REG(0x02, 0xF2)=0A=
+#define SIT9531X_REG_IN_SEN_STATE		SIT9531X_REG(0x02, 0xF3)=0A=
+=0A=
+/*=0A=
+ * SE_P_EN/SE_N_EN set: that lane is single-ended; both clear: the pair is=
=0A=
+ * differential.=0A=
+ */=0A=
+#define SIT9531X_REG_IN_MODE(_pair)		\=0A=
+	SIT9531X_REG(0x02, 0x1B + 0x10 * (_pair))=0A=
+#define SIT9531X_IN_MODE_SE_P_EN		BIT(0)=0A=
+#define SIT9531X_IN_MODE_SE_N_EN		BIT(1)=0A=
+=0A=
+#define SIT9531X_REG_HIZ_DIFF_07_MASK	SIT9531X_REG(0x03, 0xF2)=0A=
+#define SIT9531X_REG_HIZ_DIFF_07_STATE	SIT9531X_REG(0x03, 0xF3)=0A=
+#define SIT9531X_REG_HIZ_DIFF_811_MASK	SIT9531X_REG(0x03, 0xF4)=0A=
+#define SIT9531X_REG_HIZ_DIFF_811_STATE	SIT9531X_REG(0x03, 0xF5)=0A=
+#define SIT9531X_REG_HIZ_SE_07_MASK		SIT9531X_REG(0x03, 0xF8)=0A=
+#define SIT9531X_REG_HIZ_SE_07_STATE		SIT9531X_REG(0x03, 0xF9)=0A=
+#define SIT9531X_REG_HIZ_SE_811_MASK		SIT9531X_REG(0x03, 0xFA)=0A=
+#define SIT9531X_REG_HIZ_SE_811_STATE	SIT9531X_REG(0x03, 0xFB)=0A=
+/*=0A=
+ * The SE pairs force the OutP pad of a CMOS output; the OutN pad uses 0xF=
6/0xF7=0A=
+ * for slots 0-7 and 0xF4/0xF5 bits 7:4 for slots 8-11.=0A=
+ */=0A=
+#define SIT9531X_REG_HIZ_SEN_07_MASK	SIT9531X_REG(0x03, 0xF6)=0A=
+#define SIT9531X_REG_HIZ_SEN_07_STATE	SIT9531X_REG(0x03, 0xF7)=0A=
+#define SIT9531X_HIZ_SEN_811_SHIFT		4=0A=
+=0A=
+/*=0A=
+ * Either CMOS enable set: single-ended (one lane, or both as CMOS); neith=
er:=0A=
+ * differential.=0A=
+ */=0A=
+#define SIT9531X_OUT_MISC0_BASE		0x1E=0A=
+#define SIT9531X_OUT_MISC0_STRIDE		0x10=0A=
+#define SIT9531X_OUT_CMOS_ENP		BIT(3)=0A=
+#define SIT9531X_OUT_CMOS_ENN		BIT(2)=0A=
+=0A=
+/*=0A=
+ * Output divider: 34 bits in 5 bytes, LSB at the slot base, MSB in base-4=
=0A=
+ * [1:0]. Slots 0-5 on page 3, 6-11 on page 4; clkout_map[] gives the slot=
.=0A=
+ */=0A=
+#define SIT9531X_PAGE_OUTSYS0_SLOT_MAX	5   /* slots 0-5 on Page 0x03 */=0A=
+=0A=
+#define SIT9531X_REG_PRG_DIR_GEN		SIT9531X_REG(0x03, 0x0F)=0A=
+#define SIT9531X_PRG_CMD_STATE		0x01=0A=
+#define SIT9531X_UPDATE_NVM			0x10=0A=
+#define SIT9531X_LOOP_LOCK			0x40=0A=
+=0A=
+/* Debug register (same offset, per-page) */=0A=
+#define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)=0A=
+#define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
+=0A=
+/*=0A=
+ * Register-triggered phase flush: DIVO_PHASE_SEL_REG selects the register=
=0A=
+ * trigger; pulsing DIVO_PHASE_TRIG high then low flushes. Preserve the OE=
b=0A=
+ * trigger bits [7:6].=0A=
+ */=0A=
+#define SIT9531X_REG_GPIO_FUNC_CTRL1	SIT9531X_REG(0x00, 0x65)=0A=
+#define SIT9531X_DIVO_PHASE_SEL_REG	BIT(5)=0A=
+#define SIT9531X_DIVO_PHASE_TRIG	BIT(4)=0A=
+=0A=
+/* PLL page register offsets, pages 0x0A-0x0D */=0A=
+#define SIT9531X_PLL_REG_SMALL_UPDATE	0x0F=0A=
+=0A=
+/*=0A=
+ * PLL page regs 0x10-0x15 hold the loop-filter coefficients (3 normal, 3=
=0A=
+ * fast-lock); they are GUI generated and must not be changed at runtime.=
=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * Output-enable mask, twelve bits: bits 0-7 in LO, bits 8-11 in HI[3:0].=
=0A=
+ * OUTn is bit n on PLLA and PLLB and bit 11 - n on PLLC and PLLD.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_OUT_MAP_HI		0x27=0A=
+#define SIT9531X_PLL_REG_OUT_MAP_LO		0x28=0A=
+#define SIT9531X_PLL_REG_STATUS		0x31=0A=
+=0A=
+#define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
+#define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
+=0A=
+#define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)=0A=
+=0A=
+/*=0A=
+ * PLL_CONFIG1F_PLL bit 6: manual active select, no priority arbitration. =
The=0A=
+ * register is GUI generated; the driver only reads it.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_CONFIG1F		0x1F=0A=
+#define SIT9531X_PLL_CONFIG1F_MANUAL_SEL	BIT(6)=0A=
+=0A=
+/*=0A=
+ * MISCINNER_PLL bit 5: in manual active select, use the manual input sele=
ct.=0A=
+ * The register is GUI generated; the driver only reads it.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_MISCINNER		0x18=0A=
+#define SIT9531X_PLL_MISCINNER_MAN_IN_SEL	BIT(5)=0A=
+=0A=
+/*=0A=
+ * GPIO_INPUT_FUNC_CTRL5..8, one per PLL: with bit 4 set the manual input =
is the=0A=
+ * low nibble, otherwise the input-select pins. Bit 6 enables the indirect=
=0A=
+ * choice and bit 5 picks active or spare; the driver does not decode them=
.=0A=
+ */=0A=
+#define SIT9531X_REG_MAN_IN_SEL(_pll)	SIT9531X_REG(0x00, 0xE8 + (_pll))=0A=
+#define SIT9531X_MAN_IN_SEL_FROM_REG		BIT(4)=0A=
+#define SIT9531X_MAN_IN_SEL_MASK		GENMASK(3, 0)=0A=
+=0A=
+/*=0A=
+ * HO_VALID: holdover memory has been acquired. HO_FREEZE (page 0, reg 0x0=
A)=0A=
+ * means the PLL is in holdover.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_STATUS_1		0x06=0A=
+#define SIT9531X_PLL_STATUS_1_HO_VALID	BIT(2)=0A=
+=0A=
+#define SIT9531X_CLKMON_P_NOTIF_01		SIT9531X_REG(0x06, 0x03)=0A=
+#define SIT9531X_CLKMON_P_NOTIF_23		SIT9531X_REG(0x06, 0x07)=0A=
+=0A=
+#define SIT9531X_CLKMON_N_NOTIF_01		SIT9531X_REG(0x06, 0x93)=0A=
+#define SIT9531X_CLKMON_N_NOTIF_23		SIT9531X_REG(0x06, 0x97)=0A=
+=0A=
+/*=0A=
+ * The device compares the CRC stored in the EEPROM with the one it comput=
es.=0A=
+ * NOTIFY_4 bits are sticky; a good load leaves only the read-done bit set=
.=0A=
+ */=0A=
+/* 4 bytes each, MSB first */=0A=
+#define SIT9531X_REG_REC_CRC		SIT9531X_REG(0x00, 0x8A)=0A=
+#define SIT9531X_REG_CAL_CRC		SIT9531X_REG(0x00, 0x8E)=0A=
+#define SIT9531X_REG_EEPROM_NOTIF		SIT9531X_REG(0x00, 0x97)=0A=
+#define SIT9531X_EEPROM_READ_DONE		BIT(0)=0A=
+=0A=
+/* Profile identifier of the loaded configuration, page 1: 3 bytes, LSB fi=
rst */=0A=
+#define SIT9531X_REG_PROFILE_ID		SIT9531X_REG(0x01, 0x44)=0A=
+=0A=
+/* Consecutive failed INTRB acknowledgements before the IRQ is disabled */=
=0A=
+#define SIT9531X_IRQ_ACK_TRIES			8=0A=
+=0A=
 #define SIT9531X_VARIANT_ID_95317	0x17=0A=
 #define SIT9531X_VARIANT_ID_95316	0x31=0A=
 =0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
