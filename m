Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A53F660E;
	Wed,  2 Sep 2026 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385268; cv=fail; b=M2kFWYV4uIlYWfQPaHx69BXq7ZpNDjRIzNPr/bJmIH4U/kTurGqO0U7+sw4vVGDBf+5669bH23WBwTWwx2+JnQoMj7tZvGN5NbneZL2hYKBdZRxCmwRiw1RKpKLpuHk4/QLEmhWkviHvw/FsGfHgTgnczJQCu2TtaPMj69beYX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385268; c=relaxed/simple;
	bh=mrb0/9XKtXymEtcNkTUhEOT9b94bX+bK0DDvZgFtC6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tCJQe/+fyZi5ueFbM39CfGffkIkWKNJwlVkulnqSEOrTfLoXAdJh4qo7xQz1PpMaV+oBrqP/Y/2pjrqXBeVQ/NAAh7XkIhs/rGmXaNrWp2kJHl/bz6eJoEL1Rc5aO5TCslHKzeT6PlzAI1wN692x6gXjqRyHb8N8/cbQvzvIFuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=SISw8tXn; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=0hzI7G8o; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="SISw8tXn";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="0hzI7G8o"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DD5B660971A;
	Wed,  2 Sep 2026 21:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=7ezgSvfzEvCslbW7B/gt2rqsfaxEHDM9121oeIVrMVI=;
 b=SISw8tXnV1pe/XcnLIKvqRJ6LyQWJqepFGXi9L9Y0gzUm8eaXYbWCHx9p8WBDi60ffvSZySfJ8xnh6OEWrv1HSm36wNb0i6Uq2sab8Upq8wI+HiR8Mtt2QSiUw6dLCu3yvcO/WnwJywj2K4lN9lYbFvxEStc9/F3At2DJRgfSZoZEBUSR60TYdMpsDQ2JgHSRzVg8U6qvmhyq4SNe+/zHeERLv41/vjsXizaJvb6gO7ZbSNozBhzOuW/CMdyE2A8JbbHn7cWfu10ybgpLsjjWLSVl7ZncSgvxxfpPgdr32rIxHQs7xJhmaSh3NvR7kwfi+i40fu3ARtu6HhYUxiCdw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 35004240065;
	Wed,  2 Sep 2026 21:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTGNt9Ak6LqlAU6Mux2cKu0614zUeRj69Q2/EGoBb/sCsAxG3h2K6+q8zGBU3FJNU7X73L3d3CrsB8J1Xi/VwKmJmoyl8yr9u4qOBTUkr3d/Gm0ec0GybSGVDPMW4Ww96zvCvJnX3vNyPQDV4gHHxLjSG8y8Z1/LIYx4N3IYFRG3QImSXrqFYAU0bb/5+53ApAVnQ5ea9Z4k5IMyjchxeVMAszMBxMgIfCcPHP/KIA16d03PjqOWc00sS5zh1br1QegYJh7jAVRjrnHmpKj2ET8bpcSPMySVrGVinYQRSjvUSPNy95a/goVg/kVveCGxaogCB3oGLs/Jv/o5bDP0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ezgSvfzEvCslbW7B/gt2rqsfaxEHDM9121oeIVrMVI=;
 b=o1g16aQf8POBUsteanrKZCcUhHrytmbjDzBi3pnxlsurl70wOxDLw9S3a6kAJdkK+Arry6JMRgV7P+Y13humrbLzX62acc8/mznohJ2R9JCWoc+Ko+9S441TnVAUByQSjbmakCaFX3JbPsv2FcFKwM8u0X0/RVWDYNOXhsZZLO5cpv+KVYxG/Pjjhg2SVH4VBFYLyC1o6QADJLPQxPg+2TFjiMxMp0ti1czWQlTpg194Hd+0MH/SiL3rSCbblJQNnrOpzBHe46ZsoxHfUkE0DFRyhWbO3UcBZ95SvvsHzCrBZQ2xcFt/klDHQoKJmWZ7OPvdXPiEtaV6SUsUy9I6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ezgSvfzEvCslbW7B/gt2rqsfaxEHDM9121oeIVrMVI=;
 b=0hzI7G8oi0MV6DNxMvtSrLnDOvdT5IKxtnCelU6xSNpEcR1rdguXyBEOrcEqq0HAeMiO0kuQ6oIPRh39ecGBHYbA2gfQ+Zh6bJoIx8DSzYKQGOyiMP+324GHxMpJhTkt5JoX9I3kymhxZF59IxthPnLKH0wXvJr5aEFlRfXitdpPu27fsoev9bWrW58TBT0QBvoNJ/fuUmdf9YehymPQlW0lvTRnqCBAZi3sPI6LJPP9Q+bZ2AdUQeInxexl3bTGTMtErsCVDm5qZMfC+KuijmzoqkRxn7RCKfvmI+81R3xg9Q2p0KSCz1b9CnT8cgN17n58N4P+VlbqMJA75Dx9sQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:35 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:34 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH net-next v8 07/15] dpll: sit9531x: add support to get and set
 priority on input pins
Thread-Topic: [PATCH net-next v8 07/15] dpll: sit9531x: add support to get and
 set priority on input pins
Thread-Index: AQHdOyOve1+fEKZOQ06z+rugORS3AQ==
Date: Wed, 2 Sep 2026 21:40:34 +0000
Message-ID: <20260902214030.20955-8-arouhi@sitime.com>
References: <20260902214030.20955-1-arouhi@sitime.com>
In-Reply-To: <20260902214030.20955-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS7PR20MB4877:EE_
x-ms-office365-filtering-correlation-id: b914f182-862f-4a39-5499-08df093ad237
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|10067099003;
x-microsoft-antispam-message-info:
 DV9A4BnXRs2TKf4QlqIHGjowCBeCNyAxHzFpTmO73t+of7ySopRka7nSvlIudLU8osyVNEA45HVxMdHS0itjQm+Ry4ZMqdG1KjeP5d1LMXstu7zJlMa96kgEBeghJFNB/P1bGU0ED05XjbrLST+/vHsKJei60MP8R1l8D4RdQ8wH/tQgZK6qlmYC+ZVzV8CpnpizGvo2lXG4LaZ4vJbtYrIY/q77lBWaP3jhc4RSlhBckA4uWgRRwrX49EpYopLiUU0cyg9eetYYX4WE7SrNAuCyrpZKMrrd6iWKBnmDQawznv4zwCuUj5Gv0xVkCJBlsh5MTVFrCfX3ai72u+Ix9aRJUMHahfQ/gG0zNqM6buPFAjvq+PSQrz7LaNqvvojZl/KuJ3kw2GKL60Z66O+1otXwYX+nyG0oprYbEX0jTyu5HIxofS7/sLCJ+S9ba4wEGkGycUnU0UcDklRRIoJuOls8xljSbYROA9BF9gs5+/nfhXZRbmq3MpyDE1Azvw54kyNgqLA/dTkBVUpm5g98ZS4e00Nk16135NYjesNVpGxAzbTsaZuU2CEBRiKtmtq+ZBqtHrlW18S39CupYZEguOATlVEda6u17Qmz2VipB+Z52gj5mFCBIucl0OLMFgOaHpAkRUEGc5R3M98cpty/iMpi83b9Q/NEkQaVt4bhABaxstsfUSY1meEwDohJKs415p9ZYrkZgVKeu357L9lf0ibf1A2/Y6eJH3Ubncr882s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UFUqdSslzDdWSvSCjtzxnSfkOlbKmfxHoNjqvKoTHJsfX7hxNPm4NFVGmT?=
 =?iso-8859-1?Q?yi5FEiChHARNbGD7dgNAE9uCtkSHs268FFFOMnuVIk6rvRrRS9jItxkFMW?=
 =?iso-8859-1?Q?WZb5cYO2qvzuSE+Ud4TYdpPe2NFa1inCFiyW3C3K+cc/qiOGvOn7apue49?=
 =?iso-8859-1?Q?GAGGKR43ZgRIGWFZXHPhs0tRnaWekkt3hmGRFsH7B/01VFhv5JfNCnECkq?=
 =?iso-8859-1?Q?tKRFM6tDwCxEDVscSTBLSaUKnqzB2A+G3a6DiAqUSlhRLdsq8So5bo/+n5?=
 =?iso-8859-1?Q?VLVhfd2/ntgjDn4I3ieoUqmWaiY92//IO7rtdVf/+MOH4oAfvYPQ2yaVJj?=
 =?iso-8859-1?Q?ytUcWZB29pKQv0sp64Kh1Z8KGO/aisLFFQh7p8n7jR+4IzzIbn6EuFZthI?=
 =?iso-8859-1?Q?jZ5xzhAjeAmtlo6mk54rPhS5dwvFADOorecu1KjmRDmFuJpcV443GHX1EW?=
 =?iso-8859-1?Q?RIMtjIfbuUEgW19ikJOTgKF/cyy3KTUzsujpU2HRUYS4lAMX22HSqmrf1u?=
 =?iso-8859-1?Q?e9/YQ2J1c1ASgnIf63aSwCC9LpAO9ilEJwv8kEXcrMdcRoUfjHPYCA5Hk3?=
 =?iso-8859-1?Q?RAo2RAvLwBwz2o67yjfPkqkjirbXrutN5ABExJx0aIh85MhJEqMLUZjGh7?=
 =?iso-8859-1?Q?QWGBOBw8YjX/a3kZpqDwgm/BuQ4B+VgpMsVZ7PRr7bVUj1AiB5JNPNILlP?=
 =?iso-8859-1?Q?loC7jKa/hv3UaQagtWThXVIeeFixy0UfwnmtukxNuBx47RR8xj8zZgBQNo?=
 =?iso-8859-1?Q?Jh1qA5aUrGL8OgeLI5u896FiAdUw8J6bYCz7nt88b51GTeW4VaYa1x+cF4?=
 =?iso-8859-1?Q?1bujRrTNG+94ACWqrI6iFzbfaYMTRySZ2JALmhPyGgVi71VpKFBTf87nmz?=
 =?iso-8859-1?Q?UB5Vpwne86BIBn8j5D52zWiqnaQwSsBV8FU9naAZRc2Cb7RM69ubBcljRk?=
 =?iso-8859-1?Q?QszJDvhcukyYeHLNjj55i8chW7ofyDXpj9UWIEXI4NMYuq4vmSZHIZtTwR?=
 =?iso-8859-1?Q?xXy5hAOpAkC/5im+tISYFZEmBkNp6B3ovcUXT/H+/YrTkSl/59HQltj3Nf?=
 =?iso-8859-1?Q?ZYaEpnN5bDOEP8e9TpgmK88CUw2ednsbz42yIIylCTxxYyFr9tKltHNFb6?=
 =?iso-8859-1?Q?Jl5mS3ErF1XSnJgqEvyGgE9GDGIkhGF6RmJrleFohJyZvuZ8/VGC6C/Qyy?=
 =?iso-8859-1?Q?oBJWtijrICaKk/R3g9ZuHxViz9bA+1mORVxXrvBke/EMIV43/vvm5omU8u?=
 =?iso-8859-1?Q?9e3duIbyi6dNeJBxnsjZiB60NKqfbGQIMWNAXL0TOfXSVnGvUv1vZzWRXC?=
 =?iso-8859-1?Q?rZqayvVu8AK0MhJ4zY2q9TI5Rqnm57JaHOHbtbX4PHBJbXN0IKBIqjaGTt?=
 =?iso-8859-1?Q?KxLPadczJJQ3q8/wWQvUIJFECUYwiO8Kd23BiMiGwuWGP5LQ39TOMoY5FC?=
 =?iso-8859-1?Q?y/HEs1x3CV6Hn97F/YWFLqxYSYl1VUHQfgX5khVv5T5iDdJ0VQ7K3/tSYq?=
 =?iso-8859-1?Q?wfrebsrXHnmX8qsfJ1qBFBqag6yyGfR4vg9wxClQiKAcNQMu63V47BiMoJ?=
 =?iso-8859-1?Q?F5JboLb3Nbm20Jr94O9/FLyloq6CXin8iAPP9P61s3CqJdKyDsBTNYxfEt?=
 =?iso-8859-1?Q?XQZlphz5VxbJJvzxho8d7DEjh9N6w2X0zI2G6jeW/eEahXoSY4n+LA7p1M?=
 =?iso-8859-1?Q?zxYklAoSX+HsZPhQiVQ+D3KNuN5nuuxxzJpYxVbPtgeDuV67+rqFRP8qAE?=
 =?iso-8859-1?Q?J75P2/rIWu43WR3JVvjKBvfkK1ugME12QO1CsT9n1mkEuX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	czxKoZnOYa2N8l9V+VHLUy6oKIxENOta+n/2J0XXNb2rtOeRbq4kBYajMkgC2Gdc8ms/vXhRFE0RJscLVAjv8ZhvAHCBWDDkm1eeRHg3GNEOAvzeX9D8/SzgYLjTJ6oZ4Vh2y+u2AO/nJnbbIPCo3ZUuG99R5oHYHmxO+QeGZPuvQyL84EQlMlUPcIcs5oMx19sFcumo7S6py4IHkuqCMiVVBp0lciMhgRW6F8TWWPiWUtYjTra38SDqGx+j7dBZkIC1nksOqSh6qoHYA8c0tKhc5DJLh/60WmbRG2jZ62vo+pzAMmRE3fAKj+QNhLVz7YCEP4MQ6QavpAB7kcuzZw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b914f182-862f-4a39-5499-08df093ad237
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:34.9201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puKCUVrP7r7iZxqoi1vCg+lukiRXs9NZx02ymajxj5J4E8ejsxWbtnKVuQ3hMZ1pLcVnKFDxEVHECuXfUhaB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385239-drNg0Z66fm8x
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385239;drNg0Z66fm8x;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The priority table is ordered: the slot an input occupies is its=0A=
priority, and the device selects the lowest occupied slot whose signal is=
=0A=
qualified.  Getting the priority is therefore a search of the table for=0A=
the input, and setting it moves the input to the requested slot.=0A=
=0A=
An input absent from the table has no priority to report, and the core is=
=0A=
told so rather than handed a made-up number.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 43 +++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c | 80 ++++++++++++++++++++++++++++++++++++=0A=
 2 files changed, 123 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index f42c41d8a42e..e706f6942f65 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -414,6 +414,49 @@ static int sit9531x_prio_prg_commit(struct sit9531x_de=
v *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_prio_get - read an input's priority slot for a PLL=0A=
+ * @input_idx:	input source in hardware encoding (see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	output slot position (0 =3D highest); set to=0A=
+ *		SIT9531X_PRIO_MAX_SLOTS when the source is not in the table=0A=
+ *=0A=
+ * Scans the PLL's 12-slot priority table on Page 1 and returns the=0A=
+ * highest-priority (lowest-numbered) slot that references the source.=0A=
+ * This reads the value the chip actually holds rather than a cached=0A=
+ * default, so pin-get reflects the real hardware priority.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio)=0A=
+{=0A=
+	u8 val, slot, src;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      sit9531x_prio_reg(pll_idx, slot), &val);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		src =3D sit9531x_prio_slot_get(val, slot);=0A=
+=0A=
+		if (src =3D=3D input_idx) {=0A=
+			*prio =3D slot;=0A=
+			return 0;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	*prio =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Rebuild a PLL's membership mask from the source codes of its priority=
=0A=
  * table.  The mask is what the pin state getters test, so it is refreshed=
=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 29088707a3e6..67b9fbba9f2e 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -417,10 +417,90 @@ sit9531x_dpll_input_pin_state_on_dpll_set(const struc=
t dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_get - read input pin priority=0A=
+ *=0A=
+ * reads the PLL's priority table on Page 1 (via=0A=
+ * sit9531x_input_prio_get()) and returns the slot the input=0A=
+ * occupies, so pin-get reports the real hardware priority rather=0A=
+ * than a software default.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_get(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll, void *dpll_priv,=0A=
+				 u32 *prio, struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 slot;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id), &slot);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	dpin->prio =3D slot;=0A=
+	*prio =3D slot;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_set - set input pin priority=0A=
+ *=0A=
+ * writes input priority table on Page 1 via=0A=
+ * core.c sit9531x_input_prio_set().  Forces holdover during update.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll, void *dpll_priv,=0A=
+				 u32 prio, struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	if (dpin->dir !=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority applies only to input pins");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (prio >=3D SIT9531X_PRIO_MAX_SLOTS) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority out of range (0-10)");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_set(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id),=0A=
+				     (u8)prio);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc =3D=3D -EINVAL) {=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Pin is not a reference of this DPLL; connect it first");=0A=
+		return rc;=0A=
+	}=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input priority");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	dpin->prio =3D (u8)prio;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
 	/*=0A=
 	 * The measurement compares the PLL's running feedback divider with=0A=
 	 * its configured one, so it describes the device's own reference=0A=
-- =0A=
2.43.0=0A=
=0A=
