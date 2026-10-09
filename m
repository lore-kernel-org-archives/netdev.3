Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12048513569;
	Fri,  9 Oct 2026 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570233; cv=fail; b=OB/MpIQoOV6/+eFWRRV7vsFQtjaakV8FSaevfu6VH0Hc9DNNUqOfGAQSXr/qOX44Mbzhy++A7000+QLkeT5uDuKkjIdfX8vRsIMj2/9CXwAFltJG9o0jNhxJZFvlx7lxEIEtiXzra2OvCZesA+7iemWBoOLkRymzhGCVU6rtJSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570233; c=relaxed/simple;
	bh=RG8+mCL1PliRTb9X2SpF0qMFCAhtY2jUiuHoCZrguNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QNIv8HIQJqvIqsQMSQpBbE05rLTqPqI7I0OS93rbZzlgmXn5yUJGCnwwCH55SEvJwFwrAfc3gGRyW9aAdbiqEgBBuuaFimslgb75XAZtt87rKkJ2M5hKPK2630+qFzbbrVbVj8u2yzRTbYEOYQk4BxrfhVycsbi/TTCFr6X5jek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=PNVAtLCe; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=jKWy9rU6; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="PNVAtLCe";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="jKWy9rU6"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C85B51CBF00;
	Fri,  9 Oct 2026 18:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=RG8+mCL1PliRTb9X2SpF0qMFCAhtY2jUiuHoCZrguNI=;
 b=PNVAtLCe0hjulZhY/tryR5WEaSNskRoUS9hxc+tZKrsWInLYGvyzYFN548hQsT3kPE9JcRe+kX13bcT/dcUk9/+MBZ8+vb3aNPQ3WnPGPSG5EYB3KJd3SQ4uN7j9QfovrMzaBm5tI6+bZYAwYmUQ7oAo7DmKfxi7OkGedoUmxQ3+qVOWHUTjAFMnhjKzNBjSnCYxoRLgw5LuK+QqncWy6+8SxvZ37R20arRbhuawXmXktG646dpEwOK2TcI/xYSJjRsE6ZdbAjE312kkJX8Cqu/7TVK7FFiHkLltdoXq/7a0qS8s9ozzssCyWzdNzIlnW/kDt6fXBpwX3nrcYY45lA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021124.outbound.protection.outlook.com [40.107.208.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6C913B00076;
	Fri,  9 Oct 2026 18:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLNIiUuHWBwMpNhbr39JW0g9o2Vtgmta4YSci+K3nLde77P5iC1W9T0qSUwm5enRy/CvoRrCaoM2Z7sGkhWYnhNfrhzwN42C0TROybSorekfaPrpEdzWz2k6vacENIUHeAHteMkDSWe99VMPcXcsIbS3OEsi54ZBZj2SM3Fc4sVlfuarbLYU+IP+IyVlbslUIimjX+JTQroLohxaRhCVfqekg+f8SeqKRCz3cPlOoloa71l8hEWRSwWFTintLqfo3eAxummDJ+jFEev4j/witYDj11DAyF7vqS+/4TDR5GqPoyu1grVMWSOUzbJLmD15crQlUFFgMnvaBN4mzoSKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RG8+mCL1PliRTb9X2SpF0qMFCAhtY2jUiuHoCZrguNI=;
 b=LfyILshejzolumzQC4HdLKefxWRVucph2q7WywWZ1RwEHcgbm9Ev6SNzOV15Hr4J7WXXH5PmMh9tZd/GY/38HXUgYnKjRIgZZ+O4FAm5usfDEy8N/8GBk5q4reEzT8+vtZ8exRbseGSzzAdxqKppHBIGFie6fBR/B30Opf3c6Sw0OANW9pr3jmMOp5cCv4QjNv3i6mzgJXoam2C2K+b/KTPlB8dHpPTFGkoztcfZyjOproR79VMWk3N3BdcwODhYyMUrulYuu1AvpysS5e6XO+RLplWOSfoMfWMCi2yXsuYrE6UgNCqnoAAyTbQ6QSQeXsGx1GjvMMUWplqGScoKlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG8+mCL1PliRTb9X2SpF0qMFCAhtY2jUiuHoCZrguNI=;
 b=jKWy9rU6DhlD0VAOwYrqZe3nFE+WTYQMW9xq1mhFTJ4o9nC7QQU/CPFexUWnTZfl2o9WozdSNc4IN7nuxxzY4qORgxRLEzFcT1YsizOVSrKa1A5TfRzGey8nssoHJ5BBS6rJG6j9tPwO/e/Zl4S5hRoGjtp4vOp4VQv3JDlyawzoCaZBcpUVudNr3n++KkM0h5DiZYs63IMiCEcn17sLlXDjgPuJBMn+YjOeuUnSz8wiQiXzBNIKP6a+aD/EVcg9Xrf+nLTCNlVU3ZBbXrS+3L5ZRHtFLbiWjMKchIBl/GwMtB1e0z2k6130pNNTun+SkpmxmbwkD7Xt9mP+wxeKzw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BN7PPFEE39645EB.namprd20.prod.outlook.com
 (2603:10b6:40f:fc02::76d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:30 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:30 +0000
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
Subject: Re: [PATCH net-next v11 12/13] dpll: sit9531x: add support to get
 phase offset on the connected input pin
Thread-Topic: [PATCH net-next v11 12/13] dpll: sit9531x: add support to get
 phase offset on the connected input pin
Thread-Index: AQHdUTSlKd+aSrBCJkC/Wmzis1EAbLbuKhwAgAdqAgA=
Date: Fri, 9 Oct 2026 18:23:29 +0000
Message-ID: <20261009182323.76166-10-arouhi@sitime.com>
References: <179116260823.434549.634351809975661119@kernel.org>
In-Reply-To: <179116260823.434549.634351809975661119@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BN7PPFEE39645EB:EE_
x-ms-office365-filtering-correlation-id: 66e1672f-d365-43ab-a29f-08df26326b90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|5023799004|6133799003|3023799007|22082099003|10067099003|18002099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 bLvv0/Ep7Y/Pe31DaMftj7zmHkX8IDyZ0rB1oJgAjMMSHwyWelprK1tdOhqvsdBa3xFhFKfyOQ1Mh8w1COQP6gUvC96nRaXVQuIrgRkmkOelo2Xnuo1Q2GKjGORwGZ+ZgdWI1L2LPffh+h+drKNUghsi9edFhw0FgdC0GAvhJwJFW+mITikO29MPCHA68SD+YYsP1UGbxS070BwaSikJDvQbC3OtRP4as05VOU9/Y5Uj+8YGwrvwFU/B00rC0kgbHE/Qoixr5vaTWd5ee4qZrjypPCjbxWtXGuFBdqhUzA5s6T1/T8eVOgRmDGPP4DTX5d/aGT/enRxY6ffKgBjDKMKIGfLN3OrJWSqV1tA0bTiG8FACtdbNfjNAVNx5J+imAlm1fL9qje6sVkc3XLddSE9pZuQKMTkRZ0rVS8cC5B5UC2nNeUP7U3iondGrbX3C357fdrel6/vhA6Rx59tA4p+iyOmLM5m5SBBeqCdWSrO9AJT8Mp2mi4UOUSNo6mYeVIcLHX9BWbSaC/dcbOY/H2IjTkH1+n6gvIm6KyqpmfR3QOIA2IG7ypB7WE+JTYfYNnR+mXazcI7JClzVa8s/5cD9DU9/mDWrxNtC5HHE4nbGVo3dPI3JGObPkfM1FIOvd7Z+4GR0Z41ghw3AyNqNiAALXoYe1DAjGTOWO1OYnri98GGL9rrymR6SX8eIz6anA0KSyjf8QF2u9apwY/LNPsSmqpZDYt8jyNn1WU5gPug=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(5023799004)(6133799003)(3023799007)(22082099003)(10067099003)(18002099003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VA9NHWE/2cs0imIJc3H62QDGWPiaTAZ2KWD1Vb1LljDOyQ1cLAgaxF0pxQ?=
 =?iso-8859-1?Q?zsLC9uzCQy6wHrU2FumP7JwOtUdRUELQ3F7wA4hg0zz88z9rNcBsdYPJn7?=
 =?iso-8859-1?Q?lKlNV+fNG8H5cWm9GAHWB8nIDVuxRgmwuShfMEf5jiUGsybGZVuUJHWoFV?=
 =?iso-8859-1?Q?EdrAzm4MbLQXBRr/UqFmGP9hagJgXexdiOjtqhJrO6p2QjOae+bwaQty8Y?=
 =?iso-8859-1?Q?SNXAIRRm2M0E2iM8gmHdaT10ZZMys8CPQZNLRAo2JT8divi/ynJXGOq5bN?=
 =?iso-8859-1?Q?ugK7DmIPp8v2okqZqlpMRIKyWequevZ7qy32BG5CkOSVoMzhMYzv1N+zu8?=
 =?iso-8859-1?Q?ueHv+TV+h6NFKNh1PkctReM6lHTEa7D6BUo+ASGR0Kkm5ldP6K9HY74GTh?=
 =?iso-8859-1?Q?Y1dJSx8BhixwNLjzNypGnW8mRWVmjW/3jqCQEXmacvOvSn0/VUPhOaNguP?=
 =?iso-8859-1?Q?tamaZaIOw39r+964/CnZCQ7YtaJjnTHYl2ONyjxStOLpp6prWSODfBNMIX?=
 =?iso-8859-1?Q?UvPabCZujfK4t5Gd2V6lSRrVMdD71tPCLqUpEgjJqRVir7Mzxo0B04P58P?=
 =?iso-8859-1?Q?bUrTSDS6/xwZDxLSzw/4sAsWsSTMQOMuYR7dyTcsU+19/6niO5zzlFR/KS?=
 =?iso-8859-1?Q?kDZTEW4tXpGY1o5o7LrnDHspV8V6KkFf55lqa0HCTxwhIjH47nH8Mw94fj?=
 =?iso-8859-1?Q?G71GKxUq1RX7NE5/hSkPlmSSC6fZbG8Z6TcUMWGrUa1j4VT/L9qipMVXBR?=
 =?iso-8859-1?Q?qEH01f45/Ic6bO4CGUj+5MoFzxxd3A3ZuIfMWwaIAfEWdY3JTAxRgSmn8Q?=
 =?iso-8859-1?Q?4IIliq5B27WyHX7lq1Sp2v9TMl4Q0r7kvI3L1TDbdFHxKYkiwEXC/12KTu?=
 =?iso-8859-1?Q?n14h51YSXZTJKcR+CBJFKUgLsQb9hd+gywlbMxhzXp3qN+C6MY/xikpi6e?=
 =?iso-8859-1?Q?m3N7yP5YxhtiR+dFFF2mz6CgoyNJZFqnAgmEfJOtb3q9klNyrS9PsNV5I7?=
 =?iso-8859-1?Q?tiFJS9YeF6Nj9EI95WFs1uMe/JSuW9SjJl25FiYitgikP7J/Lpbkr+n32Q?=
 =?iso-8859-1?Q?iqE3Q1WV2R3VwseOrvhY0rAVqfo//qdp9BRSyzTwMu95cUP8QL07EBZcez?=
 =?iso-8859-1?Q?0Ckeg7PyktPqNeqrprf2XXfYyFP1dZqiUXHpaGi9Js1q4507vLIDg5SKfw?=
 =?iso-8859-1?Q?lQl4PHRrby8eHJs7CWOhOyfj86/AjhPgIPYoWXhNJxL6j4PMMXzDjxeaXh?=
 =?iso-8859-1?Q?Yz3s2LAdmwub3zwgyBOyvZBp7DNIB3jlVngvXSWRXPy/lIQJT/widtl7Kt?=
 =?iso-8859-1?Q?5NFGkmFWBvnUwlCt3q99mOD36E704Nf0NyUg7yXxuj52AFAKG2doSOIuqd?=
 =?iso-8859-1?Q?ZH1WUMvmQTNA1KluZ46+o36af69B1oGYeNWv4wHz51Obya/TCxv3fnsR0L?=
 =?iso-8859-1?Q?ozXOeZt1vpxYS8SFw8/F5VD6AATsbiPS/wg23dQ1WCTmjbBu38yhgeoscO?=
 =?iso-8859-1?Q?ljVK86x0Z1PwqiA9j+KdecxbXVz6PnJE/EuQuVfebo0PAcsFKL2uiqS+TO?=
 =?iso-8859-1?Q?t4MPPfwpUhyS2hWyyHJKLb//iZgttgBoYZeNqSx2ae9eaL0lWNrgDE8OTl?=
 =?iso-8859-1?Q?cf5xqNtz0FSfE1Pu0icLmxrwGf+JfbhoCRcfN9RmzFXK9zccPImR+Ax7ps?=
 =?iso-8859-1?Q?ngn2St56KUqUk7mRQCBqc8TG+PSrCXQyvGf8vM/IvIaKGA4em2Wp+Wyw1j?=
 =?iso-8859-1?Q?scUFCqU66fByddT26FrdJJVpv8V0TQ3rX2UC1jjlTf7ug6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Glk9FV1oJ7mnwFlNfCMDNjEE/2OUszwE5o/2i923yj6I/RMf88wnyI7WBcoW6ySF1Dfw52guOmnaG8Czfmfo7hL1HfeIeNuojuH1X19UuhHapBaCvBSllHegNg8FRl7p0gTKiYb2lTYyTII+oMweOQrL8+c2z78bYZhtTlRzVZjz3jngTCShOKN0VS7vBAggbsNh5qjGIRecfkJYwZoFb2fzGXC++SCNwFD1vm6G8agpsm544C42eTYCAZyb9KXS1i6lX0by86J7ZGivSNVKnqJzI2w3kDnGqmINCs1F0Oo6lQPgUXo+empP+xqQYPK4qfl/QBHRhmypMtKloTGY0g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e1672f-d365-43ab-a29f-08df26326b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:29.8767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCr9MFuKvpVNzkmwO2gTyNvFV4DK8+Am+RYkq/QpV6akagSK60LQGNSVcVRoLO5crbx7GUi60HUGd32l6po74A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE39645EB
X-MDID: 1791570216-QkeuSQUwq40j
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791570216;QkeuSQUwq40j;<arouhi@sitime.com>;5de2396b9b83917d02f0372d9ae54394
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, netdev-bot+sashiko@kernel.org wrote:=0A=
=0A=
Replies inline, in the order of the summary list. Four are fixed; the=0A=
third is fixed in its loss-of-signal half and answered in its lock half.=0A=
=0A=
> [Severity: Medium]=0A=
> What limits the size of the quotient here?=0A=
>=0A=
> [...]=0A=
>=0A=
> Should the TDC conversion get a similar bound, for example by rejecting=
=0A=
> an fvco outside the VCO band? Later patches in the series don't appear to=
=0A=
> change this code.=0A=
=0A=
Fixed by the VCO floor described on 09/13: sit9531x_get_fvco() reports no=
=0A=
data below the low band, so the conversion never runs on a rate small=0A=
enough to overflow the divide.=0A=
=0A=
> [Severity: Medium]=0A=
> Should this loop check sitdev->out[i].state_stale?=0A=
>=0A=
> [...]=0A=
>=0A=
> Could stale outputs be refreshed here too, the way the output pin getter=
=0A=
> does it?=0A=
=0A=
Fixed: an output whose cached state is marked stale is read back from the=
=0A=
device before it counts as driving, and a failed read fails the request=0A=
with the same message the output getter uses.=0A=
=0A=
> [Severity: Medium]=0A=
> Do these two live reads catch the case they are meant to catch?=0A=
>=0A=
> [...]=0A=
>=0A=
> The callback comment says the live read exists because "a cache up to a=
=0A=
> poll period old could attribute a live measurement to the pin that used=
=0A=
> to be selected". Should lock, holdover and LOS for this pin also be read=
=0A=
> live around the sample? Later patches in the series don't appear to=0A=
> change this code.=0A=
=0A=
The selection is re-read live because it is the one thing that moves the=0A=
measurement to another pin. Lock and holdover do not: a sample taken=0A=
after an unlock is still the phase between this pin and the DPLL, which=0A=
is the quantity the attribute defines, and a value during holdover is the=
=0A=
drift against the reference the pin carries.=0A=
=0A=
The loss-of-signal case is different and the point holds: a lane that=0A=
lost its clock after the last poll makes the device fall back on its own,=
=0A=
and the sample would be credited to a pin the PLL is no longer on. The=0A=
lane monitors are now read live before the pin is judged active, so that=0A=
check is live as well.=0A=
=0A=
> [Severity: Low]=0A=
> The commit message says:=0A=
>=0A=
> [...]=0A=
>=0A=
> Could the commit message also say that the connected pin reads 0 when no=
=0A=
> sample was taken? That way a 0 on that pin isn't taken as a measured=0A=
> value.=0A=
=0A=
Fixed in the commit message: the selected pin reads zero too when no=0A=
sample was taken -- the PLL is not tracking, drives no un-muted output,=0A=
has no usable VCO rate, or its selection or the lane's signal moved=0A=
between the check and the sample.=0A=
=0A=
> [Severity: Low]=0A=
> Is the reason given in this comment accurate? One TDC code is=0A=
> 1e12 / fvco ps, which is usually not a whole number. A 4.9152 GHz VCO=0A=
> gives about 203.45 ps per code, and a fractional-DIVN Fvco is usually=0A=
> not a round value either.=0A=
>=0A=
> [...]=0A=
>=0A=
> Documentation/driver-api/dpll.rst defines a 3-digit fractional part for=
=0A=
> this value. Could the conversion compute |tdc| * 1e15 / fvco, with an=0A=
> overflow bound, so the fraction is kept? If not, could the comment be=0A=
> corrected?=0A=
=0A=
Fixed: the conversion keeps the fraction of a picosecond the converter=0A=
resolves, and the multiply by the attribute's divider that followed the=0A=
truncation is gone.=0A=
