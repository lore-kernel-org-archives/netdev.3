Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734454AD7DB;
	Wed, 30 Sep 2026 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811717; cv=fail; b=V5aZWvHQnf/2HkPFX6DG6SCcf342Vj5uIO8DOVgoEywmUNDtIWhenwCcGTfCXM6qjpy32GOplTBXzqBscoyGM/Zkt/KrseXlpbG86TnHRIw4Jtm/18RuU0GjSrqtT/ehB0vvzvqDMhEt6E3fKUIJRzh+SV5+Ukuc96j+H19ZjSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811717; c=relaxed/simple;
	bh=V4SXnY3W0pA/sAsWP0SFLLOAf3ZGdIvd652BGObtRMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rs53h55HdKaPDccupeeBsvAEmf6W26BGbIz4Ab1tmxRgKrt2NWmNEy9clSiF+VTfzlo7D83keqlqF5LTXdE9Kmo2bZkTTxKppB8aGB/cqs1QE+2SsgyXXqRdr3wqWaEcTxLpkalLsd+rxIZg129MlGBQqg1D3Hy0kJDcvVsaYbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=nmCxyUZ2; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=wqOd+GzT; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="nmCxyUZ2";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="wqOd+GzT"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A78562496F3;
	Wed, 30 Sep 2026 23:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=YFmCLzphGq97vOdaHD9gBw062fvToINOv6a+OpApBto=;
 b=nmCxyUZ2mcsjV3EUeG4LSFnOUO0Oxzz3uGBe4S3fzvwR/bDn/g+tTHRAmiUoO8iPrbtBs1IG7FIt6hjpF2rUoxoQdR4OEFMqB75DP34Zh9j36e0vhbOy6I6VSin3clDSt0xbg5Z62WkfX0uG5kpP3vyo4qdcGpHaPXjGlnPqDepB5TanpUYxgjQO90dCOmtsG9jRUG9Itj4LXVX3+BYejkzDVk5jwQ7QUjNy/AmxCp442H2MxTPJe6Fgrlv1IjZCmjGMDkdajR5GaFDIHtBPhsC6QPcgADBNLRFIYvIWdwjOoiFwYDhGLnjbsk2YqfJgqLQ3gxozr1oz8AA4rFCXPg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021098.outbound.protection.outlook.com [40.107.208.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DB13BA80063;
	Wed, 30 Sep 2026 23:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0qdOyYQgkltTaVZEx+nWeVddf38xANfxazcL0Z0N+WsFMfjXlq799T+LuzuSzAz295lTyWQmsyIWvexoEwJD/cH4GQG8/u4OPAusUPSteTPJD+pMOHMqWktjAvP45A2b2NBXxP/aRt9rqYu7LMo1Knf7dCIjg82kHs2IOjAI5zcPn8D6OXFuQ7JsW7iWWJn205ZiBnB+qTwXK+VmkwAt+iQrr6BEvlCLElHDdA22EelO6pFcfKFiMobHJEAewkumzS9kioE0L4GqS/joMYtFZHfLYH0dF+R/cJkNl3BIEKTnONqjGjeJ+QqkMdvc1PRbEdVYvQdvKWBDeLQvGhgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFmCLzphGq97vOdaHD9gBw062fvToINOv6a+OpApBto=;
 b=MOcq8E3cN83KPVLm0sTdg59QyFVixFE0Vf/IA4zxxlmPubR1uPY9/DH9uDIYsTG+KbBcZsC+hn2WqGYc8FElxrOPpqdk2q5AHOe8JMlcpKvjBuHTABYsuD5VtaUIGLURXc8cqbbK2UEHe/ufKSn7IA56zFqYhesQS1rFIRRWTHJwQumDXlXfCKs+U+b0p7vICW6VEa7o4ALQXkyVGkS9NAYxm8K0/aJcWiOSWQ3QRAvJ+TDNDLAacrSWZ7RW/vxVBYkXuD3Pk0/BlMKnwPTLvSue3x6tM/vyYRRE3LNpMv61LrAGMy32zzzztQGMeotEXHdrfb0ARc1bnrriHHnHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFmCLzphGq97vOdaHD9gBw062fvToINOv6a+OpApBto=;
 b=wqOd+GzTbDr4vIc8KpIktQSF2ztvmRCkiJ5Wv8i+gMiuZwq1h9lEFa7fm2NMgYN5IOLlCOh/b2v2VP41XkFIiWGJU6vCLzG/wCf9bPiKcRhfaEW62zGpUNVWaxifTUoGN9IQxWPzZEZuS/zNxOAz3X8i3nhr5Ky1l0SetGexPG3xTQ8Ot5mgibLFCzlHuV9YEE4Ucs4Q+6S2MKvH3GbyJgxYqMJqKxJS3XK5WmwAMeo7FHyA8GIbdgzBLN42z1lZczQRquuBDK8Ek7jFdZQ6YnZD+zspx89/21JS5IRURxrcZRgycosiYEduBd5yxO1w48W2cbUk3JG2MG2Zde8HjA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BL3PR20MB6748.namprd20.prod.outlook.com
 (2603:10b6:208:3bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:33:17 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:33:17 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg
 Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>, Paolo Abeni
	<pabeni@redhat.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 06/14] dpll: sit9531x: implement input pin state on a
 DPLL
Thread-Topic: [PATCH v10 06/14] dpll: sit9531x: implement input pin state on a
 DPLL
Thread-Index: AQHdSgVZMNXNlyK8zE+dqQB+q0teIrbgKySAgAeo5wA=
Date: Wed, 30 Sep 2026 23:33:15 +0000
Message-ID: <20260930233306.81858-3-arouhi@sitime.com>
References: <20260926023445.1567707-1-kuba@kernel.org>
In-Reply-To: <20260926023445.1567707-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BL3PR20MB6748:EE_
x-ms-office365-filtering-correlation-id: c7fe5ede-eb34-4fe0-7d4c-08df1f4b34ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|3023799007|6133799003|10067099003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 v3Ifd8j6L5B0nUe4qtYFUWWGPETKKyuvD4METbOfpKY2yEB2GwZB+TT4kZPzqbRRZx46AScopewZaWKBv0EJ+yW7O3kHgHgbn7c8HxK6CBQT4AX5brzIRlA18yyqrUaSDVdylTUJdFEbHYVH17Ep6W7lzoMRkiNkhPAWFKMQ9Y2ZvLLA1HTGv0udUaS+z0qn0m0XYyX9DazdFhMIkswljvapYNHRwedz+KV3RIBx2Bf7/2ht/v2/DBd3XZ8JhAoBoTD8ye2JK6eMNXhfI1J9AqXK+979c3RZ1RctG3Gl6pciZ+41A9czQuL/75vfKoEx5FyuJhUvDq+SKOcEMESkBzxKgoWzTB96VYxfMI5op5lJPJEhRU74GWeR7gCPa4NVLwXGtGOgNE0jBHWm4iL6wXa+SbhnVSXXtt5yA7r6lyAocuhsKC4SAdb1Nu1rZYFTeYnpPMoOtacT/x+vfaP23RNWOZkBCvYvgtVdWyznxPwoYmJSbYhDvkC1MXJ6HP7hcxcwoHjmGTR/wzUHIl5UEQ/nI4lOZgb6IKjKaKzPSbq/v/LBhrPsciPZEws4rCB4ADoVfeV85QhHzlakgC8Z+5a2LNrTO+zfs5YorHlTjuBbkiC5GngLFygmD0lTbRvsjSCk37NT3zwHh48rNc+VUzTCIOvS58wlkzY7dKNLUOhpLmi4SN8fcA8zNEHx1WjJwH2Np9X5od/Y+9fk0qCb/C9O6zo08Q/z8keJt9r4Oco=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(3023799007)(6133799003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vqVkhxLFIv+HyYesp7U0yxRmhsGeX09IjNo7KwzjffEr2dsJLv6vearFzH?=
 =?iso-8859-1?Q?BOGT/ymfCZ2B8p2bApDAypXbRfnaQIiYlwb9XbbuLP75V38cm1rwbIlQkx?=
 =?iso-8859-1?Q?42ElUTI2yKijXekvIZoyPFnGIW8FNNPxzlHUDmAUzQUa84s84q4lRkjsVk?=
 =?iso-8859-1?Q?GjEENWGl+2dNvKE0441+EwUpmlvGhF1M68G6Q8jzoAusdvltiPRaQ20UK0?=
 =?iso-8859-1?Q?IlODm+XXr+ZgGiNHEk1Lx4E0qfLDGhXKuO16IE6cv27tNI4pmOWmJzc9h+?=
 =?iso-8859-1?Q?jGqVf8Y0piea1xhftX/nzPCsjT+aRpnPiz0Q9FtIZQSci19VYBA6z0yJHa?=
 =?iso-8859-1?Q?EeyqwgqtwCOvjw5oOXIWO+Do5oNMmEPD7HQ4K9QsVygZwxwqOKckwSrDya?=
 =?iso-8859-1?Q?BAaa6Phikh3A5dTEv/JU1PJ5WB9HB427BeANlvLdR0WonH0GVeJTdOzCgN?=
 =?iso-8859-1?Q?xYS3WmRCpjw5a5mtmTouok9Cwg0hMYEkWD+fDbvLHilvTbwRJwYpBY6RoB?=
 =?iso-8859-1?Q?Mu4oY5sAawmWcpaN1+Ea6Lo47aPTMbSLn3exYnefknsMmsQzWtgETAtD/g?=
 =?iso-8859-1?Q?hiHCT3uvRgh/4sW0IQuG/VkEFyCPK4UR3cooAxoJkNiP20xOuTXiKZZc3D?=
 =?iso-8859-1?Q?7zoi+oSJqVCyNL/vfmAPuPnh+/vDEkEg9PcTH5pJwlWH0arUOu5J9ghoVc?=
 =?iso-8859-1?Q?NDrTDhWE+wzqDIaLvymuMw2b5R1bB6TZifd80A35jij9VoCTE7T2/xtcio?=
 =?iso-8859-1?Q?83Cwmdv3aQOiQAH3SYIpmRPI44nvoKhRNEXY1k8oMSKI88T90Y1bTgfgde?=
 =?iso-8859-1?Q?dN8TzVM8l8Zcl3pSrfEuiQPFI5xsPrZRPgeOZLY26DnAaAM6zzFkAqNc6f?=
 =?iso-8859-1?Q?SPFB1tyVKQMo4MUJXnCo3Clw6m2DGK/fq6rXwVERZVEBrv9zs2aQKdrcdk?=
 =?iso-8859-1?Q?tDd8PCmZNelfX9dO9jo20znSi+0h7UIEg9A9jDNP3Wh6o7yHrqjjtKLshi?=
 =?iso-8859-1?Q?n5Ot8uQV2pA+Utrar96Xg8L8lPeP13IxhONMzw+blHD1266xVauGyBiHII?=
 =?iso-8859-1?Q?gbUmVbUuZ/R5MhzkGLFvmMLFxf3eIdEEYR6CHFPit4r6uqvDFPaol9Aw2b?=
 =?iso-8859-1?Q?XLmq610TvDi3S5BtMy8VORrVJnICrAMLi6mf6iWsc3bHTe/Yu7Pb250KkV?=
 =?iso-8859-1?Q?c2Avv/fXRzRkRbl8bryEFoGRnwMNw9pztYhotLDhy3tbkDHsLLXsovg/nh?=
 =?iso-8859-1?Q?EMIlhbxqABk+PqqJhybvCah1see1RySgKWUwYfTdLknxy/7/XK9VccMm/g?=
 =?iso-8859-1?Q?eUTkRIjFQwRHuv9aC+pFles3UA1xU2rmSnOSJoSlwX1IZQWPiDTzcd6bR9?=
 =?iso-8859-1?Q?DjXax2NoR8rNnZPkD7Z2cz/I8cCdHxTnOSB6x+8NWul1JE9Mp5dKCnkkWq?=
 =?iso-8859-1?Q?YwjJigve8vAKvavnu/2mQtEZYt+fUb0lQ9pxWo3+p7yfY4nCdJLY1ao0Ov?=
 =?iso-8859-1?Q?GTmobj+jO8Qtu2kQjEsu7T6FuhnzrgLGuTEzyJCAjoQxQn3YKE7tDuiKHP?=
 =?iso-8859-1?Q?JppOe2Z3bEW1m7oFqZqh2A/wlRznZdKUUEZt302ozHrsBDtJTBHfJItTD5?=
 =?iso-8859-1?Q?uArMWVB+Y2IAHrvaMkrvxY8PZVnjEyk6gJ5Viqdqig3+kmcRl73drGgsse?=
 =?iso-8859-1?Q?YJmwtoSNZUqbBD/uddj6BBJVhDuaGYpW2vpLKyiLiFTBs6KrGGaAx+t5hq?=
 =?iso-8859-1?Q?X+WGAjuoJ6Rc3/n/+G780m41OT2X/PpYCwcXuc8l8zHEVh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GpSTI3HPoXK4DouAkrzu4GhefJbod480tdWpf7MRVA4SNLPWsZJdBwz8dUqvODcsF01jzTcejbQhTGYt4DM6hSDzc3+aGS0M3tcUd/VanjD4jZfVeF+lNHZR/KODzNq7s0HUPorh3uPmn2JScscX9ce8K+2awEIF9OpUzAeRNbPCL1hr2dzFranI/7iV9Q1Rla8HSuqzPgHJrafV91NOZ+wBCy3GspU6eegVu1tup7yrQiKgEbWmsvWUTdbiTPjQZlSHjVtqJijuPUJ/AXiOe2ROp7fxz0ccrD/TB6o1BqsUYu9T7PJ5FzS3bcEViTTt7bMYrWoKIH9uBCjCzzUM9g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fe5ede-eb34-4fe0-7d4c-08df1f4b34ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:33:15.7357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sdsfbklk70piwDt7B5G01PLmplCQMlstbyivLdO//G1wvbeYjnqrIiT5QSypZUeKDPWP0797SLu5qK83vX2yrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB6748
X-MDID: 1790811201-CzpW5p5hAAj2
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811201;CzpW5p5hAAj2;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

On Fri, 25 Sep 2026, Jakub Kicinski wrote:=0A=
> [Severity: Medium]=0A=
> Does the holdover force bit take effect without a PLL-page small-change=
=0A=
> update?=0A=
>=0A=
> If HO_CTRL follows the same rule, the PLL would never enter forced=0A=
> holdover while the table is inconsistent.=0A=
>=0A=
> Nothing reads HO_FREEZE to confirm that holdover was entered, so the=0A=
> 10-12 ms sleep is also an assumption. All of this depends on the HO_CTRL=
=0A=
> latch behaviour in the datasheet, which I couldn't confirm here.=0A=
=0A=
HO_CTRL takes effect when it is written. The small change update=0A=
latches the priority slots; the forced-holdover bit is not staged=0A=
behind it, which is why the PLL is in holdover for the whole of the=0A=
table write rather than only from the latch onwards.=0A=
=0A=
v11 writes the sequence above the code -- force holdover, write the=0A=
slots, small change update, release holdover, with a 10 ms settle after=0A=
the force -- and sit9531x_prio_prg_commit() now says why a small update=0A=
is all the table needs, and why the NVM-bank and loop-lock directives=0A=
the output system issues do not belong here.=0A=
=0A=
Your second point stands, and it is better to say so than to imply=0A=
otherwise. The release can still fail. It is retried and then logged,=0A=
so the failure is visible, but a PLL that loses every retry reports=0A=
holdover until the next table write on the same PLL clears the bit,=0A=
which may never come.=0A=
=0A=
There is also a path that leaves the bit set on purpose, which is worth=0A=
separating from the failure case: a table naming no source keeps the=0A=
PLL in the holdover forced above. That is the one state in which it=0A=
follows no input, which is exactly what disconnecting every input asks=0A=
for, and the selection nibble alone would not achieve it -- it still=0A=
names the old source, and the PLL keeps following that one for as long=0A=
as it has signal. The next table write that lists a source releases it.=0A=
=0A=
> [Severity: Medium]=0A=
> Does reporting hardware selection through DPLL_A_PIN_STATE match the=0A=
> documented semantics? Documentation/driver-api/dpll.rst says:=0A=
>=0A=
>     Pin state (DPLL_A_PIN_STATE) reflects the administrative intent set=
=0A=
>     by the user.=0A=
>=0A=
> It also says that pin operational state (DPLL_A_PIN_OPERSTATE) reflects=
=0A=
> what the hardware is actually doing with the pin.=0A=
>=0A=
> The setter refuses CONNECTED. Yet whenever selected_ref =3D=3D pin_id, th=
is=0A=
> getter reports a pin the user set to SELECTABLE as CONNECTED, without=0A=
> any user action.=0A=
>=0A=
> Would it fit the uAPI better to keep state administrative and report the=
=0A=
> selection through operstate?=0A=
=0A=
It would, and that is the structural change in v11.=0A=
=0A=
State now answers what userspace asked for: SELECTABLE when the source=0A=
is in this PLL's priority table, DISCONNECTED when it is not. What the=0A=
device is doing moved to a new .operstate_on_dpll_get, on the physical=0A=
inputs and on the inter-PLL sync destination, reporting ACTIVE,=0A=
NO_SIGNAL, QUAL_FAILED or STANDBY. For a selection-role pin CONNECTED=0A=
is now -EOPNOTSUPP rather than merely refused, since the device selects=0A=
by priority and has no mode that pins one reference.=0A=
=0A=
Two things about the active predicate are worth having in the archive,=0A=
because neither is obvious from the register names.=0A=
=0A=
It requires the loop to be locked as well as the pin to be selected.=0A=
The selection register holds what the driver last wrote or what the=0A=
device last chose, which is not proof the loop is using it; a=0A=
free-running, frozen or unlocked PLL follows nothing.=0A=
=0A=
It also requires the named lane to have signal, and that carries a=0A=
limitation. When the device fails over on its own to another source in=0A=
the table, the registers this driver reads do not name the source it=0A=
moved to -- the selection register still names the lane that died. We=0A=
report no pin as active rather than report the dead one, so on an=0A=
autonomous failover userspace gets notification that something changed=0A=
but not identity. That is a limitation of the driver and not of the=0A=
part: there are status registers that report the reference a PLL is=0A=
actually locked to, and reading those is work for a later version.=0A=
=0A=
This patch is patch 7 of v11.=0A=
=0A=
Ali=0A=
