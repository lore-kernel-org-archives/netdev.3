Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C760390214;
	Wed,  2 Sep 2026 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385267; cv=fail; b=eMmTbTZaurjN/CgrJKrBnUziu3Jb9M9/+dj6GJ55L7GomOpgLKqFSZf0NZgDR/RqfE5Yw40oMqGbdbVylfrQJSvEOvYZGCMTmdRZ2jZbW7c2I/k4g9Ea3exspo5hdNwAd/0SO33zmA5Yqdw+ZpyuMk5YRYvly5YYT9D2M1lwNkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385267; c=relaxed/simple;
	bh=YoHN1WYpxNyr/XghjrH7swFy3FYiO8OAb1BnuK7bcFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uc78mKDlR4I59ZBPhIfHXVmI2/hO6J0bYIaozLI5nCLZrDexJqpEEYM1iZQbQxJK4V6M/qj2lobry4a9CZG1Ivj57WnKXvxAowvKQRxX5lP4+3jZCxQQZ2Gy0GRgoIziEnen1lRZu6PZu70PAIvjqVm8R0q3A86C1PUz3OU1MYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=RpXBkLci; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=PtfM9wb0; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="RpXBkLci";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="PtfM9wb0"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0152C6096F3;
	Wed,  2 Sep 2026 21:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=gQP2v1zWAKFh0LS7osq5fGWHxV8cMGHSUO08kcfM9ps=;
 b=RpXBkLcioEBzcW2KM2gFop6dG8wFQKg6Bfvq+iy8expqO8wuCLAkQfaTJrOmIAu7G5ajJ6usv35Bu7POwbLs2AWAIJH8pKHoMRDPLZ0K6QQX4mrpO0WrLZUA1wQ7JfrOMCtghebZn0O4PZMJYsBhtOlB50CYvVImLY9e7Mc5Yi91iTINmmGnPH7urOVDyw95/FBvGY0SdqUqYjvGu/NPP8M5jhc9jv4I6jsmwu3gl6EPvdl3CLFQd9A8JoUsTZMsfc+esk6J22SfmxzAyM7EsEJ7xwTerF5FSPLKQKIyagVNt3Nt9mMrKheXh/fTcFJYN7ER3uyHVUr7vG3OxoWx0A==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023110.outbound.protection.outlook.com [40.93.201.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 97A183C006B;
	Wed,  2 Sep 2026 21:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmvIcU6lqqd7NQ9Ep6k19cTZ4WVN3wiWVEYtjmx7m+u1n0lehmDS8EBBhJRU03nzwhg2XLyytO3jU9ib+bDvFNfvOqh/kW1M+A0TrgFh1ml76aZKie5GlRn/QTBlmnNZWlurPXNdYwMMWhBJYAKACOnhm712vrp/YRa50WAN4g0BsnY4hI+bgtk+qWSAvXzNr5uVsSDkECMs/C6P/jR5hS9PV/OB+MMBguIyoI2fXv6SC7Hc98SU4s7dkjI8F16K4F9Uric1lgcv4oWJxzvWcUlJ/6OvfPG+mHgYyAWpzFeLy0m1vytFUIE5VZPEUljf9W0eUiMxJ/JdNXpin/36/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQP2v1zWAKFh0LS7osq5fGWHxV8cMGHSUO08kcfM9ps=;
 b=ltxNYM1tMxiHa6zozJwBcgSKkNohsVGk8TRL/vbfecZgmvyGJOKnJrpoWprRhW4Hgm76/nzSc6x1A1gg5/n6pnEeZxCWE2e/dCCIC5t51qRCUGuc5/VEiatInTAlOT+6GjF2X+x9iE7EdMEgcOv1bRQsfIacWdxxVI8DPEr8HHMHe1dLdmXqNZNLdP/HdMRb2A3s4vqEtF/DP8lbgBOsPTrX+IGG5TAeWYSVCIdBlQlosthQIQoJOvLKoVAECJms5kS5qOrozXQfZLxGjsAuXeZm++c/Kj3/1fpTeJPJvuhmWQeLKAi+Kdi/NpcGekDYgTmiSKQNyUm5VWrFw2T7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQP2v1zWAKFh0LS7osq5fGWHxV8cMGHSUO08kcfM9ps=;
 b=PtfM9wb0Q+nMuCxbEIzhy7bBUEFGlXJfcVQ/Kcwpx0kiENem9BxqcFbTiZHmEcng3FxAZXUeaDASRIo/nRxIstO/L5ojdngorsjXrZ3536twKciXFAiIjVNthX0qsmDVf+BUKUrXFPWHXDlfYSQGBayJca0dEerlL/azs+fY+nD1NMZ+66pO6pNNaT+q/6A6JIoRDrc/Kmi0/6kdIzqYQYkMwQJop7onXQ68550yI59f3M4Is76fEJgD1NaAPQPNr1WCgRz8w4w2bHzCjLSA0rEK61evapBm0fk6LVec6QmnjvUZYdguzM81bYA/lMm5u3T6HZqDSO6ZxQLKtnV8Fg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:32 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:32 +0000
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
	<linux-kernel@vger.kernel.org>, Ali Rouhi <arouhi@sitime.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next v8 02/15] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Topic: [PATCH net-next v8 02/15] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Index: AQHdOyOuGzNhwr/bM0uX+E4HTMfYqQ==
Date: Wed, 2 Sep 2026 21:40:32 +0000
Message-ID: <20260902214030.20955-3-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: b114f228-1d18-4b99-fa98-08df093ad0d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 7WLMT/5gE2F6WljsuqBZ/2+5NsnETPv5u/QzB5zh+RB1KheHYqOFldiG3zQGnUJkc2xmEXYn0cnkTAixfHVUQzjzfusBQcgIutneKQv95QNec+fVfLqalPlPbcJ7++78En8FfU+bz71i742SIF5cKZuMgH2yv9qDVwBnibgTvCf9LdzjRmcDVN9tmCx+BA6WpBB7L3SoojjKbZg+AdLJiqZXvPfawxNLZfg7lC/sOAoX9QMxisOrwqF1esZLPOqzY5zchlLeke4QhcQvZXsUGJslCItgJGitSQgo5lgvlZQ14ZNPQWTTvko0A6QhfwzYbGHHGtTzpYG9PJ3VrwVfxygHLiLhLMjGS9ZflpT8CvsZRSqLfLdxAN6/gKklqtLTXyn8rb9zwLAgl7/gE+BtizKGs4QXHS+cfHB6kexahkfL0P0eueAmilQ3nJ3uWb5pbGinVi2DR6wlVlrdhGqrfOeuRfk/UC/iaC1T5JCujnbYyoC+dv4EcxvADoBEbsnUyT9DYXu7qjHqfYCg2ZAkyz6q5xGUgORqhbN3kTmATYPDlAqG2PNpydMT/YLST2EngNFbcn5O38orARHMk5BlWiteyiVuCbbOmwLUGiAk72SNjvIEDhBSFEqe02E2AY84W3vmPYxjNwuoSL0HwGlclX7YiAYWWP5Yt4rfkS16Hpw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oZ38InLVTe5fTlZR8SoANygYGNIX6rVK+0OkYKJAWkR2IaxIL1pT5nhhnX?=
 =?iso-8859-1?Q?3NuTgCdK+Sgne5YTrMjDHCRjw66deUEtMvHpAMT/osmP7ati9avskhxYys?=
 =?iso-8859-1?Q?S04r4lU1/N4fWn0u3/gLCswcyite3YpOVoVaeH/QaKW+pN49jbTqszGl5M?=
 =?iso-8859-1?Q?rFFB7lHGVT2wiSv76WCL6UC851shd1QTSEOWCr+eQoKjljQj/ozw6KDlPO?=
 =?iso-8859-1?Q?FTNUF8V5N8KC/YZT326f4KJc8IHKSmDhfuj3kedeEny1n0q4+ugfX12b2+?=
 =?iso-8859-1?Q?QWZuoPaPDt9zstD8SQuvGvNeK2h0y3fKxidX1iYU7JkDpXg1AbIobLXHLv?=
 =?iso-8859-1?Q?rmAS/de0DH84B0gua+ZYjHCjEqlbtLT6W+ZoV4M1RECdRBCqZHsHfKwDLx?=
 =?iso-8859-1?Q?CCYZqRxK02IMDuGSC5XZEP5G+bHUZsGTIfOC/OqYN1rpwVuNF9VXx1t19s?=
 =?iso-8859-1?Q?YXAxb47JZ7AnsglC5KnJmgDTnL3T6V1g0WmEvapBSUf4Xtrl6RdNk4X7JD?=
 =?iso-8859-1?Q?RyP5fqchRajf2KmZkzTmQY2YZ/T74wlI1A5z7Ngq1+2atXrV6boXP+7CmS?=
 =?iso-8859-1?Q?JxUMJbB3FKPuYKp4A3nv2eJODzjLre5hvDXrGqo1ocCDGpzHjagEVDzgal?=
 =?iso-8859-1?Q?YL3Uw1xnZi/ft0+rvQPvbjImhWcN7FgOhLSfF6DU2kVZBu6fMS9cVAxd0s?=
 =?iso-8859-1?Q?DlV/LC2wmwML/FOj7h5V6c82r83DshWJsEZxDkhenCrkHWeeXQLbsxUNn3?=
 =?iso-8859-1?Q?zYssLrGSXN1eD9UJuE0lvdMweMkxGTtyBzM9keBnrsNSbnF4s+zN/W+mUt?=
 =?iso-8859-1?Q?PQkAVHq03UO9xjEm8Q5K1FTIErM7VaNc2+xvX/EqF6hC+P/2tgZJnIJ1GM?=
 =?iso-8859-1?Q?ZPnQvZ+HD/bbrwJQOGoTOAeqkp2M5aDwRCs3tPB2OG8qAYUrfYO+w14H3w?=
 =?iso-8859-1?Q?NpimQtL3pJGmW2Z9YudImgaN2TuDGtGLSr0b8ObhRA2ekt6KT+QkMrN1EU?=
 =?iso-8859-1?Q?d6RwvkvWCWBpahrpNeQQ722D6K6UhvktuCK1KwTStzwxIwvextwDoBuXId?=
 =?iso-8859-1?Q?X8nPx0h957d3Vbpt66/MkxuxJCMtbV+LhijbYJRGFG8GyHf/qluHEsQF0B?=
 =?iso-8859-1?Q?p9dHX+qRqsQKN5mEGcxgwHlB6MD4/bCDZsgWzIq+uleCUlf8ZP5n+Q8iRZ?=
 =?iso-8859-1?Q?rC9EhQQ7z282SG658uNNP/r133neR1rJ2Snm8JhL2XJ3qKXgd5/k86TiEU?=
 =?iso-8859-1?Q?JRZ33YrbURHb4UYhO8DDBEK5RtlYOyL6CSR8niolRUU+Qait42/6yYTfDA?=
 =?iso-8859-1?Q?aAt1ZRilnqBaQv59wU34xqGiThQ88KD7nEHObcwSzkxKuBwpt8HCGhPSMn?=
 =?iso-8859-1?Q?7FrngFw14E0IW8HgVs+wx7S/ezbVgnc/GJ77/Znml558I9RUYyA2YNJmhx?=
 =?iso-8859-1?Q?+F1HGcANuPkGAoTGOAyOis0i7mw8KFfm2lS0fjHAauwp8vAgaokcxBzZN7?=
 =?iso-8859-1?Q?Ix/Y9zNziho0yqWYUwJFphCEhD4qNobwUFtaE9ZpThPT6V9wI8RfsZerRH?=
 =?iso-8859-1?Q?Ia7KDyraT7BL7axx3gCW2ICsK0+FEAiemYl3ktyWAqhODtluOVzMf1m5zR?=
 =?iso-8859-1?Q?KDsND7Ix5AdrPTQ19kqSzP+auBaLg7qkOQ8TtW1biBX+b7Ifs97As2jB7T?=
 =?iso-8859-1?Q?LugYVhf+2J8huQ5wDigqtKGYCfAIM/wl5gDMpmNA8t9J2rpVt9tt2FTCTq?=
 =?iso-8859-1?Q?sc+VzvG5qyAPR+CI6Hp3kNsL/ybs2s3DD/u+kJCQv6dcYm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	15c7kLFmk+lXKgo4JIzzOqSzWG3K+y5xWqqlnJ/TE7i4qbwFI6LHo9zLRrbEoYfG3HHm23OkeVZ9n/uzcSSktoYXsiJXFbhKBGpyJZx95i6P+AsWana96KnxAP6ZVL4O5GRYebqSeNfHloNScTtV3YFFQv5ZHklvcbqucwzfe9sCD7TLnEAO8A4rM5q9gumC9q3wEZpdIRM1/z6X/r7WvFaqGqCLgqcHiunIsZoBnOtSC8D1rgWV1rAwauIl4tNkgEsVUYWpPnST0KtIQFBp4WPwbJHJHKUAA90are3Jn/rpMuAYcNUg44ydxNGsaf6IKJr6N604almery3Ipk8uDQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b114f228-1d18-4b99-fa98-08df093ad0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:32.3823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJxgG1W5cDuJrtKVsRZBv6A+NmCXZaK7GDJuJpax1bSQbfPfOlns6/DIWU5WOrZj3YU1ZlTrGpAWNaNwoRXHeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385236-LbAB7fBOW8iM
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385236;LbAB7fBOW8iM;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a binding for the SiTime SiT9531x family of clock generators: an=0A=
I2C-controlled device with four independent PLLs, up to eight input=0A=
clocks and up to twelve outputs, described as a DPLL provider.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>=0A=
---=0A=
 .../bindings/dpll/sitime,sit95316.yaml        | 171 ++++++++++++++++++=0A=
 MAINTAINERS                                   |   6 +=0A=
 2 files changed, 177 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/=
Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
new file mode 100644=0A=
index 000000000000..b3cf9d5a8267=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
@@ -0,0 +1,171 @@=0A=
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
+%YAML 1.2=0A=
+---=0A=
+$id: http://devicetree.org/schemas/dpll/sitime,sit95316.yaml#=0A=
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
+=0A=
+title: SiTime SiT95316/SiT95317 DPLL Clock Generator=0A=
+=0A=
+maintainers:=0A=
+  - Ali Rouhi <arouhi@sitime.com>=0A=
+=0A=
+description: |=0A=
+  SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock=0A=
+  generators with integrated DPLL for synchronization applications.  Both=
=0A=
+  variants contain four PLLs with automatic/manual reference selection,=0A=
+  DCO frequency adjustment, and phase offset measurement via an on-chip=0A=
+  TDC (Time-to-Digital Converter).=0A=
+=0A=
+  Both parts have 4 differential input pairs whose lanes can also be=0A=
+  driven independently as single-ended references, so 8 inputs are=0A=
+  individually selectable.  SiT95317 drives 8 outputs, SiT95316=0A=
+  drives 12.=0A=
+=0A=
+properties:=0A=
+  compatible:=0A=
+    enum:=0A=
+      - sitime,sit95316=0A=
+      - sitime,sit95317=0A=
+=0A=
+  reg:=0A=
+    maxItems: 1=0A=
+=0A=
+  clocks:=0A=
+    maxItems: 1=0A=
+=0A=
+  clock-names:=0A=
+    items:=0A=
+      - const: xtal=0A=
+=0A=
+  reset-gpios:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      GPIO connected to the chip's active-low reset pin (RESETB).=0A=
+=0A=
+  interrupts:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      Interrupt from the chip's active-low INTRB output.  Asserted when=0A=
+      the device detects a status change such as lock acquisition or loss.=
=0A=
+=0A=
+  sitime,pll-fvco:=0A=
+    $ref: /schemas/types.yaml#/definitions/uint64-array=0A=
+    minItems: 4=0A=
+    maxItems: 4=0A=
+    description:=0A=
+      Per-PLL VCO frequency in Hz for PLLA, PLLB, PLLC, PLLD.  Neither=0A=
+      standard frequency suffix fits.  The VCO bands are 4915.2 MHz to=0A=
+      5898.24 MHz and 6875 MHz to 7812.5 MHz, so every valid value=0A=
+      exceeds the 32 bits "-hz" allows, and the band edges are not=0A=
+      whole megahertz either, so "-mhz" cannot express them.  Hence a=0A=
+      plain uint64-array.  Override where the standard=0A=
+      Fvco =3D Fref * DIVN derivation does not match the running VCO --=0A=
+      for example a PLL operating in INTSYNC mode.  A value of 0 keeps=0A=
+      the register-derived computation for that PLL.=0A=
+=0A=
+  sitime,output-pll-map:=0A=
+    $ref: /schemas/types.yaml#/definitions/uint32-array=0A=
+    minItems: 8=0A=
+    maxItems: 12=0A=
+    items:=0A=
+      enum: [0, 1, 2, 3, 255]=0A=
+    description:=0A=
+      Source PLL index (0=3DPLLA .. 3=3DPLLD) for each output 0..11.  The=
=0A=
+      value 255 (0xff) marks an output as unmapped and prevents the=0A=
+      driver from registering it as a DPLL pin.  Override for=0A=
+      configurations where the chip's per-PLL OUTPUT_ENABLE bitmaps do=0A=
+      not unambiguously describe output-to-PLL routing.=0A=
+=0A=
+required:=0A=
+  - compatible=0A=
+  - reg=0A=
+  - clocks=0A=
+  - clock-names=0A=
+=0A=
+allOf:=0A=
+  - $ref: /schemas/dpll/dpll-device.yaml#=0A=
+  # SiT95317 exposes 8 outputs, SiT95316 exposes 12.  Bound the=0A=
+  # output-pll-map length to the variant so a SiT95317 node cannot=0A=
+  # describe more outputs than the part has.=0A=
+  - if:=0A=
+      properties:=0A=
+        compatible:=0A=
+          contains:=0A=
+            const: sitime,sit95317=0A=
+    then:=0A=
+      properties:=0A=
+        sitime,output-pll-map:=0A=
+          maxItems: 8=0A=
+  # SiT95316 has 12 outputs.  When the map is supplied it must describe=0A=
+  # all of them, otherwise the trailing outputs are left ambiguous.=0A=
+  - if:=0A=
+      properties:=0A=
+        compatible:=0A=
+          contains:=0A=
+            const: sitime,sit95316=0A=
+    then:=0A=
+      properties:=0A=
+        sitime,output-pll-map:=0A=
+          minItems: 12=0A=
+=0A=
+unevaluatedProperties: false=0A=
+=0A=
+examples:=0A=
+  - |=0A=
+    #include <dt-bindings/gpio/gpio.h>=0A=
+    #include <dt-bindings/interrupt-controller/irq.h>=0A=
+=0A=
+    i2c {=0A=
+        #address-cells =3D <1>;=0A=
+        #size-cells =3D <0>;=0A=
+=0A=
+        dpll@68 {=0A=
+            compatible =3D "sitime,sit95316";=0A=
+            reg =3D <0x68>;=0A=
+            clocks =3D <&xo2>;=0A=
+            clock-names =3D "xtal";=0A=
+            reset-gpios =3D <&gpio 78 GPIO_ACTIVE_LOW>;=0A=
+            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;=0A=
+            dpll-types =3D "eec", "eec", "eec", "eec";=0A=
+            sitime,pll-fvco =3D /bits/ 64 <6900000000 0 0 0>;=0A=
+            sitime,output-pll-map =3D <0 0 0 0 0 0 0 0 0 0 0 0>;=0A=
+=0A=
+            input-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkin0";=0A=
+                    connection-type =3D "ext";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <10000000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkin1";=0A=
+                    connection-type =3D "synce";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;=0A=
+                };=0A=
+            };=0A=
+=0A=
+            output-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkout0";=0A=
+                    esync-control;=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkout1";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <25000000>;=0A=
+                };=0A=
+            };=0A=
+        };=0A=
+    };=0A=
+...=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 0b42e898f4d8..ef07a53b5fc4 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25157,6 +25157,12 @@ S:	Maintained=0A=
 W:	http://www.winischhofer.at/linuxsisusbvga.shtml=0A=
 F:	drivers/usb/misc/sisusbvga/=0A=
 =0A=
+SITIME SIT9531X DPLL DRIVER=0A=
+M:	Ali Rouhi <arouhi@sitime.com>=0A=
+L:	netdev@vger.kernel.org=0A=
+S:	Maintained=0A=
+F:	Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
+=0A=
 SL28 CPLD MFD DRIVER=0A=
 M:	Michael Walle <mwalle@kernel.org>=0A=
 S:	Maintained=0A=
-- =0A=
2.43.0=0A=
=0A=
