Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46F449B01;
	Wed, 12 Aug 2026 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557338; cv=fail; b=YxsHVYOaiEsS1obr7TjaiAzoJR0CsUzx2J9UrqyjiCwTrwVR6YicIIo2EnglD7MbjasvwiWvidBSI0V/baQvHvq0fwDs0k9booZy2bRYtJcHEPKzhTOEQYN7T1zFJ36X7RO4GefZC29zq3F+1wEf+VYdGnkx6KzyE7vSdAR9KCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557338; c=relaxed/simple;
	bh=3WwpCp71PMlAFW/NCbn4U6rhLAbqRyM6W7SFA+Kpt0k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EeiQzqrB2P1hIQQfX9skKvbvAmQdu5chVtaPryiUVxz4Pa2U/4GdtdOGicvvBVNhvxu0o+Ui6CccH7eULGivY/CLrC50EcIhTKJfB//orTHQ2rGyhqMeRtGuqfnoqPqyPgnknIxMi5MiLSNGN5BUz836oK2FsGCAFMgdO/5Fvk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Z+0iJmxM; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=swh2IUw1; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Z+0iJmxM";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="swh2IUw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=vDdn4KLbr07Zw2s5YFXb1GHMCg3G51KvU5nxkAa5EDY=;
 b=Z+0iJmxMetaxypNE4MSXtrXXKt+K8Yt1BGNYxv/JD9jsmM/ZmCjBXIOMY+bPNTIElDhX0vG3eYs+yRH8kO8CcGhDO9+iGsVNuWFaKtnMMN3fi1K5xNo/FYh6+4po+sBzaNZ9kL43uLOn/6/fBCjE6f6mj+ccFEZBi2fCDZXfKH61+3hjiJQGu+RsxuBCAw1/m8W6hWyLy6DWc0tSL0ns/NqqRuVnja4y7bpKU0DTpb5QxPPDAIXlN3phBx4ff3rk4jSZnsqcZy7G0eH8sjji6VVhVaGvP/MnXakbyq5zMjJOu6UFqnvzoAKdVmD+5SAOkIhQsED8Wx+BzQXT4hrrFQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020110.outbound.protection.outlook.com [52.101.56.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id EE756340065;
	Wed, 12 Aug 2026 17:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qC/SSR2WKZJtfBWNoNG2vqWrbgzRxPeEnIJGIDNK3bbNTGv8tntZB09e1lhPmUwCuv0KWmSzB4u3Qqm9wopvN44Lke0Lg6mbAdUIN75Jg45S2pBRC6AOAWZHgtcWvMI/5dEPzbjEs6EVs3KZOJJTt5L2kM082YV3Xrc+gag+EIZrG37OToS8/ymp3HQfIoioVvzgDeoBKvaR7InvXhgTdT+YkcAXuqr7J406kg/ZeLDFzab+JutspIZhQ+RtnZt8RoT9X7BIC2jgrFZpoII2r7MLQMbrRGSPz8yZ8Mp9NOLqk7FfiyYnCNTCjf9SFyQz6jx8y9TTJz7WtSAqE9He5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDdn4KLbr07Zw2s5YFXb1GHMCg3G51KvU5nxkAa5EDY=;
 b=p39mue3YQE3k4swZGsRfrwIeny35md+4fJOCaiRjL+JHJiAPoqjsFlgym/lIPBlpK+zH+P0cpUzLXAraI0ZuHSEJoovD9/aj4ykBqpbYrl3nO5znCkV2yXVS0zQgOxD7gVH4nwzgEqJwqhLtmqOe9jTta+ustyyYikRQEapAviOiYxlr14fy+3XbCqFRJbDdrPTZSufjVETmTodJGB0h8uXZMWQTkDM/WHhtIvKtlvkj2l9dG3SObo7B7rJX5rcbatPXiuuKw9BRpDOo/QPUckdLYLpfmqtp0x9yxOX0DgQbfnolWrldGFmUQS69FnN972jxeKuGerwQtHXZNz7fVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDdn4KLbr07Zw2s5YFXb1GHMCg3G51KvU5nxkAa5EDY=;
 b=swh2IUw1MBv/VQhGvxTdfauKh0vQcs7ucHxxB5jWR1d+Cyi6K9Ug3sxzKMmwCb0KVDgUZOGyxAO/NKZM72IFMBLrE3Q7bUTB9UZ8SXTA57PFBoDfIJEyAUXY4Bi3xIsyfk+Rv86KGmP9vtIcH19KrFRYimk4e0cvsiERehQrG8g94yzLaO5E/UJ6xSkO9DaFBnOhfLvN43GLASps86sLj+m8908o2m4qNfbfPWJ58BQ5U8+zf8tvzN5CU9Z3/qy23I9PYjwzbg2MMrygOgkCwKUUZoK+ew647RHb59z0C8+Iu88kfzd8vbhXDlsUdE60bF0oYMigTEXOJFKlSweoGw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DM6PR20MB3282.namprd20.prod.outlook.com
 (2603:10b6:5:2a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 17:55:24 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 17:55:24 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v6 0/3] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Topic: [PATCH net-next v6 0/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdKoPA5O2xPuoPAkmDEx3PGXhoCQ==
Date: Wed, 12 Aug 2026 17:55:24 +0000
Message-ID: <20260812175337.18155-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DM6PR20MB3282:EE_
x-ms-office365-filtering-correlation-id: e812da12-19d9-451b-caa4-08def89ae2e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|56012099006|18002099003;
x-microsoft-antispam-message-info:
 ddHU4TbPuKyzlMPJN7w3wBwvxuGwht4SIfgyLvKFSICInChEYOJFkSIW0Z0nQqVsfPFvswihcVb4giN1ucuERXNAFxfJcZUGJGi4EJJm/BR6oCLMuwIAEeSMpEsE+cBSNHg0BN9C4bJLOBU36VqX00sJPRvA52rdAIzfbmU5MV7ayTlUFmKVi6bSC2IPhSVMsZYY/EQo0aWbE51uAmU/BZO7OFvGyX/+HfNzG98iRLl+ZOONOJKxiAq+b46HhWgybnqAeVjqeXQltMG+wH+9ZHwnkKx0gfT/7HUXfjif+qIgahq4nD6Yi/x3Ip7MShQbs9sEgLiKvMWziHuNdqrKNzlNCRWh/fbOuTYEjzsKnBDfD8rqiLb6ktT4iIaHN21ViuCz2NEgebpz/yIgnpE1SVDTPWqjcEp7qtIZeWRU52qhh3/jfW2TwxYuLbVLMULSVkTT9Nn2kqGhlzI4dXODNXNl1zDWuV65oWb4oGcivKjP4ie5pDiPQkZEhyk7Z5F4B92zTc+iOpztdiwSojXe0rKqJNofKVm7Gp1G6lSMMS3KP7dG97ucGgto94l+3Fa8wJHqHUo7/XHq3BkN6fPm4MMO9K/DzuxdZTuQi9j/p2fVW4y/GQPVGj84r3M4OH42F5PJa0j3cLYvzRMfsJoV0dJS0YejQlMTYTxduwAajMLoSUtOA6ETaqfrv2dHJnatr/bQGIHhHfL3djPKR3xsaRiRjypAf8PFyLDukKpX71A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pzU6lO/hf6p4E4iWkRpUzx3q58jAZ16G6t+6wc4wXC37YFdoichrS1y97X?=
 =?iso-8859-1?Q?ru5q2qoOtlOR5jZvHe8rYNwg+PvPEgZ4wQvWsM/cw9JXe1e85wPfSCVc4U?=
 =?iso-8859-1?Q?9zZZrJ3TudXB8fbusyOlurL0/Ipdpbgz0K8/x64HGaMfJS+u1fbijN/IkD?=
 =?iso-8859-1?Q?ydSa9gUnKF5yCI2sCrL254RqEs6PJBuzELTcghgcL6hBJXt3FYYejOTBsL?=
 =?iso-8859-1?Q?hkGVtOy9RRV1UHWMyQrvOlaUqlRJs9EkI70wjiuf+/DtLRZy9qHqEojQ+X?=
 =?iso-8859-1?Q?3iYfAU/9T/GBtutOYHIVHL7vXKgiRjx/X7Tk5tMqcXsaqOmaSIps5fTT4b?=
 =?iso-8859-1?Q?sKNTEQ4pR+5YEKcrAImfrl+WC1BO0jZtEvfByRckWeke9dGMfr+2sXDWi5?=
 =?iso-8859-1?Q?ks98aGH22/IXnMSUSm8E4AkLgZpCtQRN3MXp0pqlBRtErZDNWLS1YtUmzr?=
 =?iso-8859-1?Q?esX9KbtjuWCcLtbiSLu+/0/fW9ReEoc+F3bZbUTdNYXnQdkfo++Ag8f1a6?=
 =?iso-8859-1?Q?Cgx5eTjUQnX6FDGo3HTz1+vv72PMMntCzbjwF6GZ+/HJVFY2qcLytJcT6d?=
 =?iso-8859-1?Q?J0/VKj+d3IMaNaZ64zoQrBtx3mqe0MIFcPjaIOsj56MDRdiSXS63DvPYis?=
 =?iso-8859-1?Q?WLmfK5NwvbwjbRdI4VJdt14MPSBnYF7LbwQPr6uVUuj/48YuR+8Fof/MdE?=
 =?iso-8859-1?Q?5Pu2p94RNlngyub0u6hUvwo927DCz7tsG/z7FDwRo9ZGXWWuWTSdlxX+/W?=
 =?iso-8859-1?Q?e26iAybqssNxMxngpmWS2VXyqniq6xPOWmaWtCurP5Mizv1HzNQ7uOJhg5?=
 =?iso-8859-1?Q?noPUYxiO1EE0EEi1JBYpgspcYYDORtJE5U9Cq/aLqC92udCeb5AQtkVg2X?=
 =?iso-8859-1?Q?DKgu99hOHed+KDjxRLUXdIuyHYQpRAWTO0+PiUq2t1wv5Et1cnBNNqrkyO?=
 =?iso-8859-1?Q?cwYUNEJOWhhDvQdOzepNtejt4nAFwWUGcJMAykASI+DUo4sYuZO1kuA7E5?=
 =?iso-8859-1?Q?nBN4BcBZe6W4MqPM2dMQ0+lUQdNQt+Cq4jgIJmaloSaxI03olK13DSrlng?=
 =?iso-8859-1?Q?CH1PzE+ZO3LpZ2UBZsw8sqp4iGIMZ0Bx36tOER4/xg7+ALl01acuJHKUXO?=
 =?iso-8859-1?Q?p+NShBC9arQv+AOWSdFQdAwAAbDuXg6hHszqRnUSp3E173RScALXUyfiE5?=
 =?iso-8859-1?Q?1y9rXXEFamLFbvWrk6AYLQtLzhedAEpJ4Aq1PXOQ+LTJVkn7xKABq1VDeC?=
 =?iso-8859-1?Q?U+k4ssPMc83ZiCK1QVNyLRQkTkORq3aO0sLGarDQdKUlj3Z5tk7M7IRoFD?=
 =?iso-8859-1?Q?ARTKSNdqWIrFI3mpgW+cYFnwZoeCIb7AEIcTh3EyuzDlvvlYOJ40+5C5ru?=
 =?iso-8859-1?Q?bZUxmiks8ykux0iIoHl9eEGqcANJtajwfipnrBKdenA9Vkhh2A6+d2+Ms/?=
 =?iso-8859-1?Q?WPz19APQMCElZfa8v1Lqb8Ee7hEPhVrji1pl4xtOKCnVPQ/dcHAQXBuxjP?=
 =?iso-8859-1?Q?H5NCkacATB24r6KXBosDe5ARQ/gdz9UX9e3uJsgHmqeyqBw/+WARaivWrq?=
 =?iso-8859-1?Q?tRhftEGz6K9oXo6sDN7QpZ7i18f+5x38N3EODDDD/XKy2NoEJ+Nxk2VJMu?=
 =?iso-8859-1?Q?WdImumIW8YMre5DBOTPWyqJMpYHbsNoR0AeAnByrqFLhr03SDzl6pJvObm?=
 =?iso-8859-1?Q?fEQ1iL/lztH8KqFUBoQyvjq5m3Pw8K0xiS1WIwv7jgm5kpxIgmUnnJtjjg?=
 =?iso-8859-1?Q?53GLEWg7CRw9g86eYD47iqyowEnsV374jhUu+am0SUwV4J?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XeHI8ooFflaQDzoiJECUX/GhUMJxtPhNYsJik8Fs22IOLe2M0c+dIeSIt3e9DADd4n+GW323AIuSccGCNY4rbjz+GssGuOZF3USPyyi73R34KvE1ZRWyMYZIIdu6H/JCy3SKadyc8S/RvWCiIBS4sWQGx4x6njdjsZrEP3UqRXw16Pir4yZ+e4RVR6Jkbfxhkyam7cDWZ9GXC5Wi20+tX47CVFykJd/kR/Jp998BoGHVMT4O8+R9xQCSihrLg+S/SvrGfsf4I2cSiuLZ+/YY7/cTRJL5tpaz0AXG8g1L6zug3oLo2TMLZGw7vAn7FmvLkcEZqgfbY5yHb4YGHbJTgQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e812da12-19d9-451b-caa4-08def89ae2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 17:55:24.8299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smvCFVRaoGbBjmIT8RTQOF2Vp5qXmr5zHFONRxeNX57y+WnZylPzJQOsvQqz5pWdroDBC0KY3c/Qc0ENX5xLOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR20MB3282
X-MDID: 1786557329-Viw81oai_mZR
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1786557329;Viw81oai_mZR;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

This series adds a DPLL subsystem driver for the SiTime SiT95316 and=0A=
SiT95317 I2C clock generators. Each device integrates four PLLs with=0A=
automatic/manual reference selection and on-chip TDC phase-offset=0A=
measurement, and is used for synchronization in telecom, networking,=0A=
and data-center timing.=0A=
=0A=
The series contains the device-tree binding, the driver under=0A=
drivers/dpll/sit9531x/, and the MAINTAINERS entry.=0A=
=0A=
v1: https://lore.kernel.org/netdev/20260511211143.19792-1-arouhi@sitime.com=
/=0A=
v2: https://lore.kernel.org/netdev/20260520191943.73938-1-arouhi@sitime.com=
/=0A=
v3: https://lore.kernel.org/netdev/20260731180951.65725-1-arouhi@sitime.com=
/=0A=
v4: https://lore.kernel.org/netdev/20260806232439.27551-1-arouhi@sitime.com=
/=0A=
v5: https://lore.kernel.org/netdev/20260810230439.22866-1-arouhi@sitime.com=
/=0A=
=0A=
Changes since v5 (driver only; the bindings are unchanged):=0A=
=0A=
  - Read the input receiver-enabled state back from the device, so inputs=
=0A=
    are no longer all reported as disconnected after probe.=0A=
  - Fix the input priority table handling: it has 11 slots, not 12;=0A=
    correct the priority-slot to register-nibble mapping; and latch the=0A=
    table with a small update after a write.=0A=
  - Do not report an unused PLL as locked.=0A=
  - Report the reference fractional frequency offset through the .ffo_get=
=0A=
    callback (DPLL_FFO_PIN_DEVICE).=0A=
  - Read the DIVN the loop is actually running, and treat the DIVN=0A=
    numerator as a signed value.=0A=
  - Name the debug readback window for what it holds.=0A=
=0A=
Ali Rouhi (3):=0A=
  dt-bindings: vendor-prefixes: add SiTime Corporation=0A=
  dt-bindings: dpll: add SiTime SiT95316 clock generator=0A=
  dpll: add SiTime SiT9531x DPLL clock driver=0A=
=0A=
 .../bindings/dpll/sitime,sit95316.yaml        |  171 +=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +=0A=
 MAINTAINERS                                   |    7 +=0A=
 drivers/dpll/Kconfig                          |    1 +=0A=
 drivers/dpll/Makefile                         |    1 +=0A=
 drivers/dpll/sit9531x/Kconfig                 |   17 +=0A=
 drivers/dpll/sit9531x/Makefile                |    4 +=0A=
 drivers/dpll/sit9531x/core.c                  | 3120 +++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h                  |  372 ++=0A=
 drivers/dpll/sit9531x/dpll.c                  | 1202 +++++++=0A=
 drivers/dpll/sit9531x/dpll.h                  |   69 +=0A=
 drivers/dpll/sit9531x/prop.c                  |  397 +++=0A=
 drivers/dpll/sit9531x/prop.h                  |   39 +=0A=
 drivers/dpll/sit9531x/regs.h                  |  371 ++=0A=
 14 files changed, 5773 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.c=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.h=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
=0A=
base-commit: 001b5d347d8ba39b2dccaefcc57967b18caec8fe=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
