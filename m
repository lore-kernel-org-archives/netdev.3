Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B940DB3A;
	Mon, 21 Sep 2026 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021486; cv=fail; b=XlcNt06loZ3YCGKiDl0wBa4rJWFaVAUDQMWgSG26Njimgzo6OrMED+xwP6jsWMo1/ni/1LRSHlLqbzHWxuSIFXH141hUzImyIdWzygvCXXxWwDr//vnlBJaCXzJSY/2He+UgvUxAKuAWQVhdYfft/th/+v7aQ9citprs8gEKzpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021486; c=relaxed/simple;
	bh=epgZdB47tbi71dDq+CeehZpuNBGyTMYSSqvo2zpaSjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RrNuEfstZo3ZO90VWgTQ5vZSn1rkP/MTq/qejQNEJpis2d/QmTzwH2XN7j+6mfJBpEFhq8w/Wwp5AXzl17qqlbj5WAnVf6UHxdSFZsiWEvwTKMBfTMLzO71vBzSM+BXTd1EQL6qM+AAyQwn/8jbWDnc2RiEo0/XTCtGmQGUoZZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=AeYszNRE; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=CKcEWOqv; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="AeYszNRE";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="CKcEWOqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=qYfestxojeM4cuuu9m+Xx1agfxfjOQzNWI0Tg5GdeZM=;
 b=AeYszNREJH2jDmfPzRMkKoxWF8byzh/V0LU80uX8ettb9Tm+W/6/hJwNRc2RqE+ihMf/w+XUpvD/89ec2TXxv2bPyyQ06PiQSLKalKjA+YJO0XwHzgcxCX13sYU8pSoGoQH/bhRbzUG4M7qtVgHiYZonPDi+OvwNDBe63NIMDlZddp2xsFgf6FIZM+/iPmbP46st8sxC+phHru2PSoP2u2e6pPcRWFkZRTRKZCPMfFqCGZsIDxycnB7inVAQSj5KKRW6xjMpAB1WZsGoi08xajkc8nq3UHnuBDGBGN0e5q+n1A4rRgzXBX5B/jhVoih15XZRrdCr66PexcbjipSiDA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020131.outbound.protection.outlook.com [52.101.193.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id CB7B19C00B8;
	Mon, 21 Sep 2026 20:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E18TmIA99Wh5XUF+nDoRco79v5k3ql4eGLMjBmQozLjIt0jQUlsaWWMdwRI9hcUW4bn6Iftwcpg79WPQiTM/JABEad93o+XdErxVRVLX5AKEqTGAhpPNBKAjF8b29cfzKzwMcI3jleKiJExrVzFnBxiXUhe82HW+XC0QhJ4MGQkDqFG5sTAE9B3mBA+kO8bg3uieZAGk9GyDbxtCPjjuxKNjQNgS/jPFN8PF9H/B10eOgS6uJslNcEwAi8ax3bm4lKC0xdhiPKYgtVdvHQ/kYLc7gxYqIzjiI96vLJA+yXBVj8XzZLNMmxsvxt8WCaA9kavdv+zdAxu/RHCC/4Z5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYfestxojeM4cuuu9m+Xx1agfxfjOQzNWI0Tg5GdeZM=;
 b=U/VuLLKpBgXtPaaSh3EIVa/OmaYm7xRlwOzbVO+1fLoquoun/qxPaYC6vEeLJ/fyo0kMKJchGh9EUmhA3PN23m1AKaEvidY0SUsXnaL+L16U6aUnHvX81ZP8U5uQS/0MUWmkpU2SKzGzJkYzFFY6F1+4EB6kvZeY0yknOoAC8RdtW7IcceXRjd0o0UXHzcitFxHWJUtd1QFUyHKPJbRvgcRc4XdxcLPgrIhUJzj9nzRVI+Md76mN9RhlP6cNCIc5Jj16QVa7aNVik3KPWcSZxmi1C/C5h6hSnEezJsQreqh3yX3Z+IkXCCeaRXzdHq9hnMmdAWCaRdzn81ZYwGCatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYfestxojeM4cuuu9m+Xx1agfxfjOQzNWI0Tg5GdeZM=;
 b=CKcEWOqv+78MqbWC+cV0vIyiO8r3110agFxQezUhhwKDX42c/qTrGnJSyTndhbRywNF1wqLJmy1nfJlwmfvckoUhxSAYQkn+157EI5IMEUzZ0HUvXjCBR4Avlmk6QQlXgQeAl2jAuWbxVnM2qrOuw8ZPaRX2JBmifOo5lfgIfLYOvQ4dGBD+BVaobwx3hVmkxAe6Ii40CdCXeXHFkHBf1dge/K2bF+OZoeqmCNOhGoeR20GN8B6i0CxsA+Ze+rh6/IbcK8bWgbn1uIofdSRIZjMJbHcWahtPwdsJIiTQzxH7MOtxOxqjr/dNe86r4wMMpwytSauPeNTWibCJWS8ogg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:19 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:19 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "dev@kael-k.io" <dev@kael-k.io>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH v10 12/14] dpll: sit9531x: add support to get fractional
 frequency offset
Thread-Topic: [PATCH v10 12/14] dpll: sit9531x: add support to get fractional
 frequency offset
Thread-Index: AQHdSgVcZJTHG7Yue0aY03dDJnkTAg==
Date: Mon, 21 Sep 2026 20:11:17 +0000
Message-ID: <20260921201108.42676-13-arouhi@sitime.com>
References: <20260921201108.42676-1-arouhi@sitime.com>
In-Reply-To: <20260921201108.42676-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS3PR20MB7783:EE_
x-ms-office365-filtering-correlation-id: d0dc6caf-9d80-4398-5d03-08df181c7fcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 IY/zZygRYcy9qoX/p/NTSg1rK8sW8g7lDC6U84CahL/MzBOgnlJLHKNoaoBLncdozRef3lwV7NBCJIozPbw4HNoZL56ncMxBsG32/KmMtqnmUrFriefQSFlxw7L5UHkt2kE3KnuWox+da5jrGSgfwVRhgwhd6qFZRvm+PkVVh0VE2qv9yFkbiMmYemfkPt9XAU+P69CkKmcST9lkrnL9kjpQsfmFwNIsH/a4fVGIlY+RU4HAX4lpwKj8NSzXpPcTRCIw/J9qx11tBK2ulI1Rn9oWhDRrPfrMOiYp689b+oKBThGXd1SSvoOuyb1aDAa+Svmz5uLv5PFdRNzHxqVgtyQIAS80KKns1BQxSpy7bYc9F96vitUHgb0PMY443kuQXM17C5Lc+wsiEfMNY0hbWQRilq7W0cPz/oREWYq0nfMz7B6Yp0wnKgcrxGU7VKg624U/iD8YHok7mfj6EFPWnVzmwY1yE+XMI7oSK/SkrYmldJ47jfIkyrvCSL1udA4PkpgbC6ggFuG8/M+Z7NgG680j43yLivbNsBMcmyLM/wN/5wFqWnSUR1LWD/z4w3uqOzrriOgpEBO8JwjgT6wgHI8EnW034Mz0sUUulEZf3bQyd0Z5odWnZDUDFZ2XYPFjsXSRlXTU+jtPeUoeNrRoXhiCd4Yqr1bfBDrMDkm2lN4WohPuritsBZYBniti2A0mXXqenyuYZByhCMbexvJFPqmppurcJdT4pGjMPp6VQqw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?A7NIEVA0vHgdsTGK+wNTstkBQ9FHjF+eaJyu7bklKBHabpjecjhLNOb+3g?=
 =?iso-8859-1?Q?4KFbPktIpWDfBNDENc4qJINtrG/k6crShwcFSV/iH4I0jEz8iy1Ds/j4B8?=
 =?iso-8859-1?Q?bDQFh22c5pU22NIbi/fh2mCaLSvTwqQq1Kf46xKD9OdmvCkCINrj8AJjr4?=
 =?iso-8859-1?Q?ceRiIAnEYg5raRgXEqdTodknWUewW9//6HiNdfRr7l7JmGBSZAeIjYKmTH?=
 =?iso-8859-1?Q?sU5EOmgzo5+AYIqm6YBEng9ZW3lQ935TzBo6KUDp4ZOkACl6Dovb3fHaAx?=
 =?iso-8859-1?Q?a1cusymfMgTZewguhtvTRc58niiJgPRAGRY4eBJHUu8zOoJdYa9tfCAUKb?=
 =?iso-8859-1?Q?78XHQx1qXpzSMjQPIibCVcfN9xr/9h05wDyEGh8+VP18btvdfcEeN5nyTG?=
 =?iso-8859-1?Q?vWyfEe0+kcCF5xmDQD8eMUhCBH8HeEfLihlCYurFO40MRapK/iTZ2wkK/l?=
 =?iso-8859-1?Q?xBBYdXiaBznQS8O6xh+aEg1U2AnTbnZV+AkdHaJVsdSfQDdhoFYTcUHe3t?=
 =?iso-8859-1?Q?4YHrJe2nrQ6HtcbujFaaKv6HNMc84obz7FD/BIa8ZDUOgiH1w991yo3QBG?=
 =?iso-8859-1?Q?cSBzvPUXnfyb1grp+kTJuFCchH/poCnK/LEjU5dHTLJiklTk7NS4QKk8Cm?=
 =?iso-8859-1?Q?GMhUN+GTmCJIvFFK1UcNxl1Tx1w0fYjPk9gFpoa/ph4g8MUv63jymbWcik?=
 =?iso-8859-1?Q?J5YzFLu7/MUp2NeC0ty11LHLDQMv3a20LS/JZx0k1Xg7Ebrxk1dMSPg7yV?=
 =?iso-8859-1?Q?kPT4fMW3+EcQ+K8LSopm+cOOG6iNv+qAoCO0vaMqMADvMybBJU/LmoRkoJ?=
 =?iso-8859-1?Q?4XX7dJ08cUGWCHJq4vPt8xLKIXLEmpYEj70WaFll0T7sUg6GLZEHJwsGjv?=
 =?iso-8859-1?Q?nhmfqMin/JiwPW19BatpUI15KncApJG66WfzXTCBhas+qLhSGOV8vCGsRM?=
 =?iso-8859-1?Q?lfCbdW1JeD81HN/9LMuQb1In9K+yWWPUnWjnH7YXFxgMIk+8FqQl5kXY7b?=
 =?iso-8859-1?Q?zxINf5SGDDl91f7Gd4euVF0EOvZfWIPqBbf72BVOvuTBGLiistV8XwZe6P?=
 =?iso-8859-1?Q?iBODzt1ugQQA6CvFeqvkS2voR74pVuUSecSWyq/FYeVEtFQY6WPqzoeFbG?=
 =?iso-8859-1?Q?hwhtbpinHzO6iscWxken4iWGMCV5QCQcmuxj3j3BF9RENvmTee/fvdbb6i?=
 =?iso-8859-1?Q?ZsQFMTNbDEa6tjt5kNK0DguqrFcpZ3Vjxtc4+abCUr2QsUEOI5sLpackqG?=
 =?iso-8859-1?Q?Xw2SaOh+5cHBXaVgq96HvG8TJFmxavf5zHU+FB/gkuKlvMVaUD6BzuHLFj?=
 =?iso-8859-1?Q?FacPKYNH7OgEPy9KxQHNfyiiyh++Za6vBEyHOpp0p+dgS84TJdYx6902+W?=
 =?iso-8859-1?Q?62hhOizd8QFVhg+YXh+OQsRt7exUiJmUdi5UDOMfVGE2WRhCjT0KSn0Iby?=
 =?iso-8859-1?Q?i1B0vyR/gqfaUUTrJHX3tEn61S0X/zQ+u62WFBwavfum8bJqA+fkoABBDM?=
 =?iso-8859-1?Q?b/82WSaru6wHXFRRWHl6J3XPicPtmacdV2biLDB7Clq9cAUfiW6WO3FbOQ?=
 =?iso-8859-1?Q?jzg6+ew++2GKGAl1l8CMBIOn+8osNmHyCcT76jalNo1h95k2elhRCVc4WQ?=
 =?iso-8859-1?Q?O/mDhcMHYJ8TxAtF8/QErgjGcRKKxxBEqGNvz9q3anxtJodj134Y7bf4xo?=
 =?iso-8859-1?Q?Mr1/UPmioJvn3KtmhmqC7taAbcuo0/9oODzxJf6bzZSMJSGBNiwmx+dTIU?=
 =?iso-8859-1?Q?DMVfFwHH1lJG693Wo4++eyaWKdoBQBhhlMOO0uYWnahMLP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	bAPrDbawdeAlXZHLEk+7L0t8mo8comDGvuRjAJyX/PPg4cTf/ipgjAO6pGHBr2mJ62Pyg99fUZxaqWu3SxwYUbsgpc3CMkaUh4WMynhA1VjEGKvvu/f1+pCqSuJ1mw25MrntFTEwPIcv8+Pc/xiy+Gfwd2XKfOhKCdnMCcvxFMgvW7z5f0IoM7DAO5sLRY/9omTDJkC0xafJI1QC5SebTWOoOvYhsPUWCAxIhmDki4gSENxCmU55LHkKgyjU4zBXF0gzbN8fFR+NCIWjrKCAjwEas3A/gC3P4rP+y4/k+cXQvVAae5ZB3vYPB2ud8p1deM1uTwUPNENw+huwS00/1g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dc6caf-9d80-4398-5d03-08df181c7fcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:17.2514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRnA8Yx4i6n2QyT3pmGnLgfRM3snuFh53OFJCkcGIW+rpnUA/+zfSy7JiRc91GRihaDzBSi+a3ut9j49CgJCBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021481-uyXquNQDup8j
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021481;uyXquNQDup8j;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report how far a PLL's reference is from nominal, as a fraction of the=0A=
nominal rate.=0A=
=0A=
The device does not measure that directly, but it does run a feedback=0A=
divider that the loop adjusts to keep the reference in step: the=0A=
difference between the divider the loop is running and the divider the=0A=
configuration asked for is exactly the offset of the reference.  Both are=
=0A=
read from the chip -- the configured one from its registers, the running=0A=
one through the debug window -- and the offset falls out of the ratio.=0A=
=0A=
The running value comes from the same latched debug window as the phase=0A=
offset, so it is triggered three times per sample for the same reason.=0A=
=0A=
The running divider is two numbers read through a window that exposes one=
=0A=
tap at a time, so the numerator and the denominator come from separate=0A=
samples and a loop moving between them can tear the pair.  On a locked=0A=
loop the divider moves by parts per trillion between two register reads,=0A=
which is below what this measurement resolves; the part offers no way to=0A=
latch both at once.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    Guarded the runtime DIVN tap the same way as the configured one, and=0A=
    gave the denominator's high bit its own name rather than borrowing the=
=0A=
    integer field's.=0A=
    =0A=
    Completed the kernel-doc and the documented return contract.=0A=
=0A=
 drivers/dpll/sit9531x/core.c | 217 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h |   1 +=0A=
 drivers/dpll/sit9531x/dpll.c |  51 ++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  14 +++=0A=
 4 files changed, 283 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 8f6f8ffc8dc1..1cb691f04019 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -1396,6 +1396,93 @@ static int sit9531x_is_xo_doubler_enabled(struct sit=
9531x_dev *sitdev)=0A=
 	return (~val >> SIT9531X_XO_DOUBLER_ENB_BIT) & 1u;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dbg_sample - latch and read a signal pathway debug sample=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @read_code:	which tap of the pathway to sample=0A=
+ * @low_freq_clk: sample with the slow debug clock, which taps below=0A=
+ *		200 kHz need=0A=
+ * @buf:	result, least significant byte first=0A=
+ * @len:	bytes to read, at most SIT9531X_DBG_DATA_BYTES=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+static int sit9531x_dbg_sample(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 read_code, bool low_freq_clk,=0A=
+			       u8 *buf, unsigned int len)=0A=
+{=0A=
+	unsigned int i;=0A=
+	int rc, lock_rc;=0A=
+	u8 v;=0A=
+=0A=
+	if (len > SIT9531X_DBG_DATA_BYTES)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * Select the debug clock this tap needs.  The device never clears=0A=
+	 * the bit, so a read that left it to whatever the previous one set=0A=
+	 * would depend on the order the taps happened to be read in.  Taps=0A=
+	 * below 200 kHz need the slow clock; the divider taps do not.=0A=
+	 */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT,=0A=
+				    low_freq_clk ?=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT : 0);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_READ_CODE, read_code);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * Reading the trigger latches a sample of the selected tap.  Read it=0A=
+	 * three times, as the documented phase-difference procedure does and as=
=0A=
+	 * sit9531x_phase_offset_read() already did: a single read returns=0A=
+	 * the previous latch, so a caller sampling repeatedly gets the same=0A=
+	 * value back however much the tap has moved.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_DBG_LATCH_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_TRIGGER, &v);=0A=
+		if (rc)=0A=
+			goto relock;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < len; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_DATA_0 + i,=0A=
+					  &buf[i]);=0A=
+		if (rc)=0A=
+			goto relock;=0A=
+	}=0A=
+=0A=
+	rc =3D 0;=0A=
+=0A=
+relock:=0A=
+	/*=0A=
+	 * Close the debug window again.  The key register opens every debug=0A=
+	 * register on this PLL while it holds the unlock value, and these=0A=
+	 * samples run on ordinary monitoring paths, so leaving it open would=0A=
+	 * unlock the block for as long as the device runs.=0A=
+	 */=0A=
+	lock_rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					SIT9531X_PLL_REG_DEBUG,=0A=
+					SIT9531X_PLL_DEBUG_LOCK);=0A=
+	if (lock_rc && !rc)=0A=
+		rc =3D lock_rc;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * DIVN as a fixed-point value: int_part plus fracn/fracd, carried with=0A=
  * SIT9531X_DIVN_SCALE steps per unit.  The scale keeps a whole DIVN=0A=
@@ -1477,6 +1564,136 @@ static int sit9531x_divn_static(struct sit9531x_dev=
 *sitdev, u8 pll_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_divn_runtime - read the DIVN the digital loop is commanding=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @divn:	result, fixed point as per sit9531x_divn_fixed()=0A=
+ *=0A=
+ * Same quantity as sit9531x_divn_static(), but sampled from the running=
=0A=
+ * loop rather than from the configuration registers, and carried at a=0A=
+ * wider precision: the numerator is 48 bits, two's complement, the=0A=
+ * denominator 49.  The integer part shares its tap with the numerator.=0A=
+ *=0A=
+ * The denominator is taken as it reads.  The configuration register holds=
=0A=
+ * the divisor minus one, and correcting for that reproduces a profile's=
=0A=
+ * stated VCO exactly, to the last bit of the fraction; this tap is a wide=
r=0A=
+ * field sampled from the loop itself and the documented readback uses it =
as it=0A=
+ * comes, so the bias is not applied here.=0A=
+ *=0A=
+ * The numerator and the denominator come from two separate latches:=0A=
+ * the debug window exposes one tap at a time, so the pair can be torn=0A=
+ * by a loop that moves between them.  The divider changes by parts per=0A=
+ * trillion between samples on a locked loop, which is below what this=0A=
+ * measurement resolves.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+static int sit9531x_divn_runtime(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				 s64 *divn)=0A=
+{=0A=
+	u8 buf[SIT9531X_DBG_DATA_BYTES];=0A=
+	u64 fracn_raw =3D 0, fracd =3D 0;=0A=
+	u32 int_part;=0A=
+	s64 fracn;=0A=
+	int rc, i;=0A=
+=0A=
+	rc =3D sit9531x_dbg_sample(sitdev, pll_idx, SIT9531X_DBG_READ_CODE_DIVN,=
=0A=
+				 false, buf, SIT9531X_DBG_DATA_BYTES);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 5; i >=3D 0; i--)=0A=
+		fracn_raw =3D (fracn_raw << 8) | buf[i];=0A=
+=0A=
+	int_part =3D buf[6] | ((u32)(buf[7] & SIT9531X_DIVN_RT_INT_HI_BIT) << 8);=
=0A=
+=0A=
+	rc =3D sit9531x_dbg_sample(sitdev, pll_idx,=0A=
+				 SIT9531X_DBG_READ_CODE_DIVN_DEN, false, buf,=0A=
+				 SIT9531X_DBG_DATA_BYTES);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 5; i >=3D 0; i--)=0A=
+		fracd =3D (fracd << 8) | buf[i];=0A=
+=0A=
+	fracd |=3D (u64)(buf[6] & SIT9531X_DIVN_RT_DEN_HI_BIT) << 48;=0A=
+=0A=
+	fracn =3D sign_extend64(fracn_raw, SIT9531X_DIVN_RT_NUM_BITS - 1);=0A=
+=0A=
+	/*=0A=
+	 * sit9531x_divn_fixed() drops the fractional part when the=0A=
+	 * denominator is zero.  That is right for a configuration register=0A=
+	 * that was never programmed, but a running loop reading zero means=0A=
+	 * the sample is unusable, and returning the whole part alone would=0A=
+	 * put a wrong DIVN into the frequency offset without saying so.=0A=
+	 *=0A=
+	 * A numerator at or above the denominator is not a fraction either,=0A=
+	 * and would divide by a denominator small enough for the quotient=0A=
+	 * to leave u64 -- a divide-error exception on x86 rather than a=0A=
+	 * value sit9531x_get_fvco() could reject.=0A=
+	 */=0A=
+	if (!fracd || (u64)abs(fracn) >=3D fracd)=0A=
+		return -ENODATA;=0A=
+	*divn =3D sit9531x_divn_fixed(int_part, fracn, fracd);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/**=0A=
+ * sit9531x_pll_ffo_ppt - fractional frequency offset of a PLL's reference=
=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @ffo:	result in parts per trillion=0A=
+ *=0A=
+ * A locked PLL commands whatever DIVN keeps its VCO tracking the=0A=
+ * reference.  How far that sits from the configured DIVN is how far the=
=0A=
+ * reference sits from the local oscillator, which is the fractional=0A=
+ * frequency offset the DPLL ABI reports for the pin feeding the device.=
=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error.  -ENODATA covers every reason the=0A=
+ * ratio cannot be formed: a DIVN that was never programmed, a runtime=0A=
+ * sample that is not a running loop, and a configured divider below one=
=0A=
+ * whole unit.=0A=
+ */=0A=
+int sit9531x_pll_ffo_ppt(struct sit9531x_dev *sitdev, u8 pll_idx, s64 *ffo=
)=0A=
+{=0A=
+	s64 configured, running, delta;=0A=
+	u64 magnitude;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_divn_static(sitdev, pll_idx, &configured);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	/*=0A=
+	 * Scaling by a divider far below one whole cycle overflows the=0A=
+	 * 64-bit product and comes back as ~0, which would be reported=0A=
+	 * as a plausible offset.  A DIVN that small is not a running=0A=
+	 * loop, so treat it as no measurement.=0A=
+	 */=0A=
+	if (configured < SIT9531X_DIVN_SCALE)=0A=
+		return -ENODATA;=0A=
+=0A=
+	rc =3D sit9531x_divn_runtime(sitdev, pll_idx, &running);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	delta =3D running - configured;=0A=
+	magnitude =3D mul_u64_u64_div_u64(abs(delta), SIT9531X_PPT_PER_UNIT,=0A=
+					(u64)configured);=0A=
+=0A=
+	*ffo =3D delta < 0 ? -(s64)magnitude : (s64)magnitude;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers=0A=
  *=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index f2750c319ff3..1d77b89e83ec 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -289,6 +289,7 @@ int sit9531x_clear_notifications(struct sit9531x_dev *s=
itdev);=0A=
 /* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
 =0A=
 /* ---- Phase offset (TDC readback) ---- */=0A=
+int sit9531x_pll_ffo_ppt(struct sit9531x_dev *sitdev, u8 pll_idx, s64 *ffo=
);=0A=
 int sit9531x_chan_selected_ref_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
 				    u8 *ref);=0A=
 int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 5f7c2d01562c..fcdd19e0bd3b 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -638,6 +638,50 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin=
 *pin, void *pin_priv,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_ffo_get - read the input's frequency offset=0A=
+ *=0A=
+ * The offset is derived from how far the PLL's running DIVN sits from=0A=
+ * its configured one, which only says something about the reference the=
=0A=
+ * PLL is actually tracking.  For every other input there is no=0A=
+ * measurement, and -ENODATA leaves the attribute out rather than=0A=
+ * reporting the active reference's figure against the wrong pin.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_ffo_get(const struct dpll_pin *pin, void *pin_priv=
,=0A=
+				const struct dpll_device *dpll, void *dpll_priv,=0A=
+				struct dpll_ffo_param *ffo,=0A=
+				struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	enum dpll_pin_state state;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * Publish FFO only for the input the DPLL is actively tracking.=0A=
+	 * selected_ref alone is not enough (free-run, LOL, holdover), so use=0A=
+	 * the same CONNECTED criterion as the generic selection-state logic.=0A=
+	 */=0A=
+	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, &state);=0A=
+	if (state !=3D DPLL_PIN_STATE_CONNECTED) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return -ENODATA;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_pll_ffo_ppt(sitdev, sitdpll->id, &ffo->ffo);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc && rc !=3D -ENODATA)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Failed to measure the frequency offset of the selected referenc=
e");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dpll_input_pin_phase_offset_get - phase offset of a reference=
=0A=
  *=0A=
@@ -763,6 +807,13 @@ static const struct dpll_pin_ops sit9531x_dpll_input_p=
in_ops =3D {=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
 	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
+	/*=0A=
+	 * The measurement compares the PLL's running feedback divider with=0A=
+	 * its configured one, so it describes the device's own reference=0A=
+	 * rather than a port rate.=0A=
+	 */=0A=
+	.supported_ffo		=3D BIT(DPLL_FFO_PIN_DEVICE),=0A=
+	.ffo_get		=3D sit9531x_dpll_input_pin_ffo_get,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index a9731c360bc0..4a928126473d 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -291,6 +291,20 @@=0A=
 #define SIT9531X_TDC_SIGN_BIT		3=0A=
 #define SIT9531X_TDC_MAG_HI_MASK	GENMASK(2, 0)=0A=
 =0A=
+/*=0A=
+ * Read codes of the running DIVN taps.  Unlike the configuration=0A=
+ * registers these report what the digital loop currently commands, so=0A=
+ * they carry the correction the loop applies to track its reference.=0A=
+ * The integer part and the numerator share one tap, the denominator=0A=
+ * has its own.=0A=
+ */=0A=
+#define SIT9531X_DBG_READ_CODE_DIVN		0x57=0A=
+#define SIT9531X_DBG_READ_CODE_DIVN_DEN	0x56=0A=
+#define SIT9531X_DIVN_RT_NUM_BITS		48=0A=
+#define SIT9531X_DIVN_RT_INT_HI_BIT		BIT(0)=0A=
+/* Bit 48 of the denominator tap, which lands in the same byte position */=
=0A=
+#define SIT9531X_DIVN_RT_DEN_HI_BIT		BIT(0)=0A=
+=0A=
 /*=0A=
  * DIVN carried as fixed point, and the unit the DPLL ABI wants the=0A=
  * fractional frequency offset in.  Equal in value, distinct in meaning.=
=0A=
-- =0A=
2.43.0=0A=
=0A=
