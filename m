Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504894F68DF;
	Fri,  9 Oct 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570222; cv=fail; b=VUs584GIWvhwKTVFAH2VSxMY4nROpbXMgBlGzAIHDX83PjkZy4q4h/bMyF3kVNJGEVeuf5sFgU8ikKmS3WcMPeKFC9Q9OhjOvlTiHOIj20iA6XZK1UEQa1a0hnu0ZPCAJCAl41RtMsBeY0aJVPA+bYMjqXjs7GsrUAbr19rgv38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570222; c=relaxed/simple;
	bh=2xVdMhE9KX5I+TUc5XE0SdsEDWsRJkTpvVjbflrwpCg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pqNMxWIqfVAQ7b8XC+Vl8dxz1Yi9C0CPzrDuQOWzw7ZJO1qcgTjPFZCFWYSEtZNhIpMo8wfOeYWmmJ8BYiBWHHjGjHui2mz+9OZjVHaxy9MAutyUP6Xen2gdfIhxyRC9BdVfTr4IWMru9hDFOqEarbMSuSobxWqmQFyD7ahXr9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=nExTiTf/; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=OTkgSxEy; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="nExTiTf/";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="OTkgSxEy"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A539A24D792;
	Fri,  9 Oct 2026 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=2xVdMhE9KX5I+TUc5XE0SdsEDWsRJkTpvVjbflrwpCg=;
 b=nExTiTf/4INH98PG0JmYz7OHv56TW6aULlDDl5gBgKp2ZxjwishCbRYJ/pyb9CsXBrCLthCYHLtPKtKE8YczwnqXgn/ei4BafYNdrZvF8L8nKVOzI67g6dlC5ABsSvXEDjzyfp8UP7aX4THGrjhNvz+POYQ4itfTztuC8dCweexcORDIfd0m+rLHwgAoyRFdMCOYRrh5bv1YXkxcGYXMa+fyopDx98BCYBtNDWAIzinHW8bGinAvK41jH55n93E7Aa3y10rtEalz+K4lt13xe4xUihGtgRKlTnj+k4RFo3sblMYmqBM7tUT0YhHO0TsD6sVREpFEEOdXMNVzy+L/Yw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020076.outbound.protection.outlook.com [52.101.56.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C3B81C40074;
	Fri,  9 Oct 2026 18:23:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7KfpEJw5b1DbIHu31fmm2kYxKXmN4Jde0u3lTN6mZxBcANaVKIMxgFZkmwCIdlf1wudrgox21JYnLIYU96921tmtIWAR83C9lGQGy6jf4png4yyyalPT/+7doFrq6FB4I1KeQyW7vp32DGQ5O/ifSgSpUGccXNuy7AQbv5eTZBGKoxQwFt77ALqIyKvJ2kw+/ON2ASiLgdjuqaveEo/H2ST8oqZJ4Ztx1OXDbPvn+FDiy9HxeEKgHjOJi3WGq0rBfuTie3UDQfpi+JQBQju2Uwrw9noieL2lXtnMtHrJBsa/6AZ96SqQ6JuvQ5ASYFSPsLHsaUpiB8nOyCepVQyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xVdMhE9KX5I+TUc5XE0SdsEDWsRJkTpvVjbflrwpCg=;
 b=Thcd2miXCzbPuEazhUNFKO7ZU1A5j6bk6wg3LTY/MDeikK/rbsalCd8pFl/bioxMyA7fNml4lt/so49TKQila3UzecAtgAYb+7ZgXqw3ejrm8JFEgPbi1w9VYKXzvyJWN6/j5IMx5yMMsBvWNViY/VvOnyI66u9FFDCAoSmHhYNfo9HxfWNWwqajy5jqmVRsU37q/W9apnlme8C1jVDsSntRv+YagbRMbS1jj5/896Og8c7HJ8eznZbsmbLzhwtvA/9F3PYpLSDALySbOL9Dx4SQPEZo20zqwAknIMRVXpWAOoEHIj7XOkAl40GIp/K7asjG9vu7U2oMqbPvgCENiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xVdMhE9KX5I+TUc5XE0SdsEDWsRJkTpvVjbflrwpCg=;
 b=OTkgSxEyA2ow9BZ/OQ6D4dU9kDCmV/NrQcxnYYN2rvB1CeddHCHmeX7R2aHylUBDRhiodKwjvc0XREaAcOHyOuGjEZnHPCGDUxD1JMWvCMfB37wSJfVdJEJ2/i6HsAWU0dq1LDSiWJrbRUNvbMYPWQpson4N1Lt3QXnS2IOZw/ClRTLy7/miIaJNkF00qpiMBeunfMXHVKwvAI5CM6lDYoDKt5MCNv4B9V10qk6sRbLJLQ+s2ejiXRP3H8gk8xxtnIZWM6ZCKD2m3XnB+DB7nr1gsQWl1I71tFp5QIRGVv+mfbqq4vGxAHW+eUIert20FiDgwEPtC8RAVNGPQWeV1A==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH9PR20MB007164.namprd20.prod.outlook.com
 (2603:10b6:610:314::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:28 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:28 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 09/13] dpll: sit9531x: add support to get and
 set frequency on pins
Thread-Topic: [PATCH net-next v11 09/13] dpll: sit9531x: add support to get
 and set frequency on pins
Thread-Index: AQHdUTSjc8zzrYEC90eRgotTdLpzYbbuKhmAgAdqAoA=
Date: Fri, 9 Oct 2026 18:23:28 +0000
Message-ID: <20261009182323.76166-7-arouhi@sitime.com>
References: <179116260535.434549.287018391203993508@kernel.org>
In-Reply-To: <179116260535.434549.287018391203993508@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH9PR20MB007164:EE_
x-ms-office365-filtering-correlation-id: 67ceeed3-f326-4501-4c68-08df26326a43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|38070700021|56012099006|22082099003|10067099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 zt369CnX4LKSV+PjWGlTNMxR1XRpt17QCDReoy1+iWQ//43aZUMJP127xbFQy1f/WkUSuig5ZWKmUUOlTsHrD4ObQIkjudfDoTaGItj0j2E5i9MQFbC5ltS5YtYJQuri/HMV1qksfAfV8FBwq4z2TeEeyN539GrXLqEQCMIQ5hJ4yNQNYvol12d89oAvfMoNcNpDpwkvoerYtqlVKORSxOly18hJ+RyuGx/rI69nO+gyYlBcyqqN/E9GzgNbcvyqwgNUpByMs3XP/gg+N2idumx283q+M/rbkEeAEi0qVn0un52EscOepCsT1emkYGQGksafY2cdOLXtII59IUGlmVpzqs3nItDx7bPj6br3aPpiLkV+TYoLGztdSZBeSLAp7Jd7P6rT4MO/KYZZguyctHIpno+RSagQjLTlWKTIaxOY5pSJIQZ1AcnFADS4Sq8r0OyVGvB/gPQrs54bqOF23Efmbez0H3NGlobpFpZHrHDzAjCzNPg6P9T/p8vAhqLqnZsC9/AMzCVSurzRxGEXwwA9C9WpnvJJ8BY64VlNciFriOBqpNV/gfMuBl4x590gqXtj2+udLhGXLHzZGPPs6uNS9LZJVR2T+ZC834Sfypqts3Lp2eflhyOuWbv7x7vrdAh1q9ABtPPGoSv3Vydg/9gsv5TydhouYYy/X9YZ6sXRL1VUpZzuQ2+5ULO5kk32y+v49EiO2paubdkxhWTSv7VqDGPakxeNZqDSSPNsZbU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(56012099006)(22082099003)(10067099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9fCasGJ00fT+Bw6THfUoeEBsRuU8HzULHgrpNVxDNiaOX8xLYRmm7CTFpo?=
 =?iso-8859-1?Q?QOjGmJ+Ub2jf7SrtlMKZmHA0w2tLr46bNk8Gu3xI95T/wB7VleMVcCR1md?=
 =?iso-8859-1?Q?cchychWTSlmTTdWZbJZtwroDOZ2bFXbCk8CmneaijY4vgDGGh/v9i91MTR?=
 =?iso-8859-1?Q?Fsa2erz894tsthneFWKzUbJeIMVwb2Yq5QHZsrddyDIGOqlj1E3Xx7QCrk?=
 =?iso-8859-1?Q?pk0bhkfJ7JxfGypab/EtiXoQsvK23OkzUFcHKQaeG5UizTsKCNaSnu9gNr?=
 =?iso-8859-1?Q?as0lJG+81xgPaiF/SA57kTn/S6NJK6bsTIVp8EApsPAcpBgKqIJlKCJxqF?=
 =?iso-8859-1?Q?TJUgJ58CjRJOdKfbwFFCiH+MN1xWK1gRVxfmHJbbv6He/xp7s2DkqyBf8Q?=
 =?iso-8859-1?Q?i9zamIwF+nGGbJR655PKqvw32N5RqH/g48yl+XtxFMvwWeAOlkIm/vvGvp?=
 =?iso-8859-1?Q?GJj1xD/dic579yMNLCIpDn8zi+pdeDH1hwysTcn0vFnQM1ocCzOzFZVEPa?=
 =?iso-8859-1?Q?by+0Y7WTzXU/2UQH2XJb4yBmSME5bu18xbmQk6eGZCBUDsLrommpKyLht/?=
 =?iso-8859-1?Q?tBr3z6msHzBDsmKtY8lIQLRMW6w3O3bPYoSIf5HQUhGYdLB8uIGXyOmXw+?=
 =?iso-8859-1?Q?8/bJfIETvgqnllCR3K7VY9RKCSv19TnZTFqyoPkp3sfVrplU5KRoCon048?=
 =?iso-8859-1?Q?Id8LzL7henoKMA8K+X3lVdS0+U6vprVldZUISCpykR3YWFwt26Thzs+/Hz?=
 =?iso-8859-1?Q?0IbAOY242L7aqaZ4h3mayeQCZizimIA2fk0UNDFBfM8lMbA3pz8VdWZWuX?=
 =?iso-8859-1?Q?vRY1k1SfGPs3Yinpd72Qi6hTPgXysnKdqBAbsVxLdJ4k/LGMISp5cKvbxI?=
 =?iso-8859-1?Q?yHfGy/1hpSckEgtPSFsCi+uu/Eu3OGZ28lBvbJf+ENg6qTat/O9qoSwE8F?=
 =?iso-8859-1?Q?jGnpBozw4CxHQodNv+2jEpwCvSrZ+82JFQxg4oDLvSUPeBAS/rNXmOCDik?=
 =?iso-8859-1?Q?63xAQiNlCgAQl19IQwf93Np1YX3pPZhZkZzVBIIfKHqWI1pYw47Rw2cTkl?=
 =?iso-8859-1?Q?drAb6iUyTYGeywhugVnQNpVwTPQ5JekIzLEBqxZJd2Rpb+gDVaZ2B6mwvT?=
 =?iso-8859-1?Q?mbLXhwCX96v0xJe/IhK3UMyscIsjE+8VqpO8AjvIW6Jv4Q+V7YNgSgozQY?=
 =?iso-8859-1?Q?K+VT8f0gOJojeN2Mg+OFEC0Mt6gXtZd46Bzzx1/hrYqrZCH0kR9J1WA7ED?=
 =?iso-8859-1?Q?OlMf7r+eo/5BslwycsRPrr3eOjTvMZR+al6iZmfO3TwkX7ECC5KUNTL1YH?=
 =?iso-8859-1?Q?DOSeg52G/iiNWTuQ2n0yaSSdkbTdBLdv6Hz5hODmBc0UdETmax89BKYyQA?=
 =?iso-8859-1?Q?krYMFr1CRBA24JaBlE0fGasiYDs2tCX+QLvqy+LHLlYIbPy+ox3Q8Bc3LN?=
 =?iso-8859-1?Q?aCwSd+l+0GYc+UDzUbBIKasztLm9tjC1y4yEdM2CNVL/2kiz8VmYz/xltC?=
 =?iso-8859-1?Q?e21v/33SCUskEBf8iNzX9kexY+nsExhXXvK9/PWhGzCU5RKDMiYj+tb4M6?=
 =?iso-8859-1?Q?2OM3iBgiRJCAfvVgQTmgfjxLfwbIp2hFaa534D3OrlHRGHwEK/jQD8pG7k?=
 =?iso-8859-1?Q?lotqDtbKoofKWFZkW1xWmdiT4YaykmIokgbg8OISYjuTlbcx3wVJl7wl1K?=
 =?iso-8859-1?Q?kg2maFvS8qxk/Re87vRReqV+yibzDmQ62yva6b8XOFiHhBXuTrykvYPd02?=
 =?iso-8859-1?Q?1jEFA6x/GQODqSdk3tTym9egCx/Q4o/1Nc5/TO/sHyi67m?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ftOSMZgWHCUmdkmACKiWYWC93cVE9XV0P3lNe4ABF0EviGsJq73mBsSZ/hVpvZyZNy9M/SdN89NizSfVDgAdfIfZ6zqzHhDH3ISE5Canj6jvl8pHFozivhWNCun7kbEH4525YISv3DTwbQvyo/g5ZLphgrM6D0XhKHSLsw5lfsaORdLqiyHTu4BtnA2+HamAhdlxaInaiAIfXF98TuH3s9+vMHoNxelhpRaD8kt/RkwdRF0KMwfzfRdLGECskhY7JP2B7Za2dGu2zlOAbIr1zgb7RxsyuB9PxnLm053tD2LkJTQPi6fK/DnnqGXiwMrx5D4984wTaQ4DCz4wTbZyPQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ceeed3-f326-4501-4c68-08df26326a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:28.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9rifbJLcmezODCSxYzDDo9C6jEZoujoSyHucDw6yYQFQkv/Z3kA5CVmvyLsObV8Gg363HiwT03OOE6uVQ50GsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR20MB007164
X-MDID: 1791570212-116fZFMH75jw
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570212;116fZFMH75jw;<arouhi@sitime.com>;5de2396b9b83917d02f0372d9ae54394
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, netdev-bot+sashiko@kernel.org wrote:=0A=
=0A=
Replies inline, in the order of the summary list.=0A=
=0A=
> [Severity: Medium]=0A=
> What does this report for an input that has no firmware node, or a node=
=0A=
> without supported-frequencies-hz?=0A=
>=0A=
> [...]=0A=
>=0A=
> For those pins ref->freq stays 0. Every pin-get, dump and notification=0A=
> now reports a frequency of 0 Hz with no supported-frequency entries.=0A=
> Before this patch the attribute was simply absent.=0A=
=0A=
Fixed: an input the firmware gives no rate for has no frequency attribute=
=0A=
at all, through an ops table without the getter, rather than reporting=0A=
0 Hz. The core abandons the whole pin dump on an error from one pin,=0A=
which is why it is left out rather than failed.=0A=
=0A=
> [Severity: Medium]=0A=
> With the new input frequency_get, userspace now sees this first entry as=
=0A=
> the current input rate. Does the binding give the first entry that=0A=
> meaning?=0A=
>=0A=
> [...]=0A=
>=0A=
> Inputs have no frequency_set, so userspace cannot correct the reported=0A=
> value.=0A=
=0A=
An input has no divider the driver could read, so firmware is the only=0A=
source of its rate, and the first entry is that rate. The binding now=0A=
says so; see the reply on 05/13.=0A=
=0A=
> [Severity: Medium]=0A=
> Elsewhere in this patch, in sit9531x_prg_enter() and in the=0A=
> sit9531x_output_divo_write() rollback, a write that reports an error is=
=0A=
> assumed to have possibly reached the part. Do the error paths here need=
=0A=
> the same handling?=0A=
=0A=
Fixed, all three: a failed source select restores the original source, a=0A=
sibling is marked parked before it is cleared so a failure cannot leave=0A=
it unparked, and a failed arm disarms rather than unparks.=0A=
=0A=
> [Severity: Medium]=0A=
> Should this path also wait out the settling time after the loop lock?=0A=
>=0A=
> [...]=0A=
>=0A=
> The abort path also never issues SIT9531X_UPDATE_NVM. Is LOOP_LOCK on its=
=0A=
> own a valid way to leave PRG_CMD on this part?=0A=
=0A=
It is not. Fixed: a failed entry into the programming state is now left=0A=
the way a commit leaves it -- NVM update, the loop-lock retries, the=0A=
settling time and the debug lock -- instead of a bare loop lock, so the=0A=
exit sequence is one sequence, and it is the documented one for this=0A=
part. prg_abort() is gone.=0A=
=0A=
> [Severity: Medium]=0A=
> Can this make frequency_set report success for a rate the output is not=
=0A=
> running at?=0A=
>=0A=
> [...]=0A=
>=0A=
> Using the out-of-band estimate also reports the result as exact, which is=
=0A=
> the outcome the comment rejects for the band edge. Would it be safer to=
=0A=
> refuse the set in this case?=0A=
>=0A=
> Also, dev_warn_once() fires once per call site, not once per device or=0A=
> PLL. After the first warning, other devices and PLLs are silent.=0A=
=0A=
Fixed, in two parts. A derived rate below the low band is not a rate at=0A=
all -- a feedback divider below one cycle is unprogrammed -- and=0A=
sit9531x_get_fvco() reports no data for it, which also closes the 64-bit=0A=
divide the TDC and the phase code performed on it. A frequency set=0A=
against a rate outside the PLL's band is refused with -EINVAL rather than=
=0A=
programmed, since a divider computed from a rate the output is not at=0A=
would be reported as success. The warning is per PLL rather than once per=
=0A=
driver.=0A=
=0A=
> [Severity: Low]=0A=
> This isn't a bug, but is this comment accurate? The priority table's=0A=
> latch is sit9531x_prio_prg_commit(), which writes once and does not=0A=
> retry:=0A=
>=0A=
> [...]=0A=
>=0A=
> The only retry in sit9531x_prio_table_commit() is the loop that releases=
=0A=
> the forced holdover, bounded by SIT9531X_HO_CLEAR_TRIES.=0A=
=0A=
Right, it named the wrong retry: the priority commit writes its latch=0A=
once, what it retries is releasing the forced holdover. Reworded.=0A=
