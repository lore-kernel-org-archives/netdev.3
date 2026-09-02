Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76513FE352;
	Wed,  2 Sep 2026 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385268; cv=fail; b=iAwrwvGSQ9OotWrNl0VYEB7J9GnymE/2GGTgYiHLo18rAJ1GivDSKJEVW1KiZt55hYBszIlgzv7a6yNbtTnfIgi21a2SlOpmshqNKUnlXw7ou0QzWXQ3Q7d+TxbYKE+ULZAUI8Vj4ekOz/Mf0lJ+BrEib9e3yMKzTlYfAaeFEug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385268; c=relaxed/simple;
	bh=r2rj0LjmgymaPz4GJ4SjZnNwyabbOf8xdWoBXMIhPCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A6oiDtHWVcDQLpcalHnLsjOOUXGX29DpSd7VtRmWxMKBqSFxHtdHRKZ/ju3Dv5Qhd9+B7gs/mr4EJtvFvcZdl4RnSB2H/o6utljJjELRhQ6HiUnz1EmlxFbnl/lKkymIveahj9Gt0JLTrkl7H19XFALnFwT9CscnQ4r8Ow0ZcvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=JKPdsAyH; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=xs+8OC0t; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="JKPdsAyH";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="xs+8OC0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=4Ls3JVP38amiHRnK9HvVY1hAG2d950EBqy0Pg8uF04Q=;
 b=JKPdsAyHkoX6TOlsm/muevcR00Eo0HXXGmtmcm7YmMagshfsPMc0r3b+ImVhHOP79sqIqJpUWViCAK9hPTXtGmkrf9mH9SsUvdQ8jrlZZCXPjunOSmwh1wNNqNRFL99PSmbCpANgoeJx+D3a6K4BqCil4CcNI8/bWhTg6EfjsoM7v9H5RxifUsupniB6j0YsXmqwolVdYmKZQNGIFpUgaUlZxfawocJVyoKkUT74Lf4Sf74GBYMt0Ph1SteViz1cbr1iIqwCJQu+/l0v5JHXq5g5qNRb/ydOuF+FEgwjrjWz8Kla1Lglks8HkIsb/NiBl1Qw/UZYSc9+AltWAOPRMw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020124.outbound.protection.outlook.com [52.101.85.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 93C002C008C;
	Wed,  2 Sep 2026 21:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9IV5R6la1hPimTvG1EfUONwoVJXuBzAhDFPm43qM1R7iPC8S336BSQJhpeCs6vj5gtDzNx+9yx4MtNVqHmDNsT06r0I5mV5Hgd+n5m2U6TS4mlgtkpCgZoofZqMXbGQ0qFUA6G4b9UzkeB+RN2i+Axd/FhW2JVID9LavHX2cJ1ZPZGODZcqs6XoFr3oQKx8EjwjIki6rDzCch37NT2GoSy9kzNGudz4xiANKetbGTQYxcMbCT9VO617frImYTCMlQaQFlVdmGPVIxcHc5pQZGqhmpk14pA9WQofBX9MDp58xQaIhv9ZjPxhBSRVp3YQt4qHd71n5tPMyLPuqnunfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ls3JVP38amiHRnK9HvVY1hAG2d950EBqy0Pg8uF04Q=;
 b=KL1cMCrSmYXW5UtA5FSQJK1jergm5aUwm4ilYM3I+hwGTeAVTqZ1X4EJW9W2fklIer676lFBK+ZcE83jdhGBNJbg2olJEW0L8r2CT+yKB2W5myAZGWIF9fTwDZY1Eb6+27Tt496tohQBk79bvP3oXDLCu2LM3yNX1PONKHlJr2zZ8jTlhQJjNle2kzUIQOJ6xGPo7oLb3u3KyKktuSyyF5XgUYdx0/QRpBazMUMG3C80niXaFv8sY4M50BvPZeyIKoDLnVFCI3/5p3PrpeMWOQITRx0lsYVMan1NR4hv8JfOl5F4bP75vtPBSlmnQR1yPntU/cKupowyXdQAikxXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ls3JVP38amiHRnK9HvVY1hAG2d950EBqy0Pg8uF04Q=;
 b=xs+8OC0tDoU5HSoq5njGs1nRSDNpq9UaZ8cZ2ts9s9eM8uWNPcDG+OpRRY2tPd52vq3RZ+r7uzC4ngzs7rBVKPrWIbarXtwH0JHcJTQsZzQQAhi94b0YIwDFS6xk+clxBwSyjXyCZgffm+25wOMWDHt9nf5ZRWTb7xycNHYPISxDr+ox4hE3RP4Sa0rH2SaOTUwM2YVYovyE3WkVkd/0BG1MqEkZtIMV5b0whjovZuj7APhnsMXWXydtSngTu6DrTX5g4gyAlUpzkrJqQ7/GcUL0TFV2PGFGpPCeyJx53vUJwkIHL849reZQbVwd6hnewPLimgo9anOK+pVcjjoaKw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:38 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:38 +0000
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
Subject: [PATCH net-next v8 14/15] dpll: sit9531x: model the inter-PLL sync
 net as a pair of pins
Thread-Topic: [PATCH net-next v8 14/15] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
Thread-Index: AQHdOyOxiUDGlhbKx0eOlCCv0G44Qw==
Date: Wed, 2 Sep 2026 21:40:38 +0000
Message-ID: <20260902214030.20955-15-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: b0933e5b-c05d-4863-3f5e-08df093ad41c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 rPUHSwNKbd4FwGR8z5kn47aidXvG6mOF8lm/191Irc2hvVGh/Dva1lfuqGqYtJXEDIL7SOo3/dn+fTBHGsXyhIHry/fVjpGdlAPWgDdGKA+OSIoZiH7LwtbQjG6ZM7+ErmhCUJOnm2V2nDZs63xrYMBEktspx54hbD4+Si8vTLRwSkoINrn0Nu/zd+ZjGbDcUihQmx0tx9qyxn/QejctFMoqoGcXkrTiVIm7uRMP8/cYilEPwLo7MWC1Kh40BPP3RBbyDa8CRXE/8vlcvPfgyncZeEYMtt++70r4EY/6bfcGMGP24p73/hY/4Oj8BqxpNxfN1tpIpAnpFKazVq3o2OVZ9pyz9sUqwPf69N1yt4nxuUqng07HjLEjmp2eUd5yGYrJMlGeUD59e/TJheR6FJ/QGJN5mabCDfehL0Cu2ICbjQ7rDK52VuUw9BP6tsvZ6Ih/6mgg17czPaISLSwOMoriw44k3KiTWmeKW09GSzxDBYrMyMKBiTTvNhh2ppRrOKFzpbEyQexFFhVp7qHsJBdtWqWIuKH3ivhTQVcEE5TbDbjSHoMH5mJ3ivf2MEPbo4co1ivxtCeT1O3Y4x2d4Z5KuRoVEqO0Ujcn0HLKDWeRIenK5kFIymAFYB27+PviNZecOq0UAL0ICbyWO+Y0A5dw3Vh5DuzWldxlK40qBVKtbut3P+9vyYb6/diaQnT5wviPmOZwqlj2ORvM4UFUpBEODpoaNHQzPUH7FRXLlqU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?geT+lCgUH3kQrz8URA8eIq8OL/643t97maFRzV4lCNb39xJlt6Vp2Be391?=
 =?iso-8859-1?Q?wXuWCUtFeW35CSL2h4qaZ1TuMRe7fmdCWkgss+4q9cRjBWVQXNIc7Q2wzX?=
 =?iso-8859-1?Q?+ibhJgyQKzbzzef/58eoJkmpLXxoS0vnt8+IGrM1iJO9NfemtrvrfYX6sY?=
 =?iso-8859-1?Q?FjyNLwAduoOA+1TWnDUO9RszgN3yXXRs3UzQuGGeU0qcVpmP+OMQY95aeg?=
 =?iso-8859-1?Q?c25juDYUEHl3OdTbGqxNqa00WeCdyF0nGpBQyZ/JM+1b6DeUk80R0Lqe6b?=
 =?iso-8859-1?Q?6MfHA7h0SfSxWB1hT70AZS6BMlFKiyr82R/rWV/y8PLIE2E9tj2XMUh1R4?=
 =?iso-8859-1?Q?c2JuLHrTSQ+DeclkRCfopay7ykLV0nGJCSeiQFPyxFym8BGXGAMFyIMNcc?=
 =?iso-8859-1?Q?bpaHaD9uTx3v1Z2OGUCGm90ZeJGnmb2urlfClC2wYvHPUdKh9YclPc1QsG?=
 =?iso-8859-1?Q?OiKc7gwKOEPD/niw9lu5rXTcoDnzQ2w1czT3bnq5h1GIlboOCj6BvAQSEq?=
 =?iso-8859-1?Q?HwSTYjx5M+/vhI9xX1XL33sLdpCe33pPID8SZANOQ/kNq688Y2woAx4345?=
 =?iso-8859-1?Q?3cyPbcPaOYC7T/LV8NNtdrbh8yHH+cvA5ga5z2YgCyWvt9oL/zn0eizP3Z?=
 =?iso-8859-1?Q?purDB3DHT4CMeJaaoW57gzex5jeZvedjyvyvTeNh0Cf0xk5ST+ylpso3KG?=
 =?iso-8859-1?Q?AnjP8tEjVggeg3jPWCN42Pni3jMNHh1EKhBglWL5hjldLHocJjzVVmwQuy?=
 =?iso-8859-1?Q?cPqL/urHGm7UODUu1PuCF0+OJknvrNfL2KinHeue6/5wIuws/1z3f97Q88?=
 =?iso-8859-1?Q?udHdpuXID66F2ul2I07MJvzCFWlIf2cmN9B7Xh7j1hxl3/lSpeMtHUJQa4?=
 =?iso-8859-1?Q?XmPPaJiDW40yUk1JON8UphI/UoiA41a7+Hui8PAijknPUDih1PDSmGCi/l?=
 =?iso-8859-1?Q?Z6d4ffKB5MUGTRxmDdxwKrSJpIc1+ABRmuDF2tBCXjT9G48vjkoBjMxrwf?=
 =?iso-8859-1?Q?3kceDvOrHhTOoIA58cMPbT8wEq5nK6TyNL2IEpP1yhz+sA7KtovETvMI3P?=
 =?iso-8859-1?Q?krKMFW/nEw2GhR6faPlQwzfliQ32AqSIjanVsP4xzwjK6wQx8aDD6TQysY?=
 =?iso-8859-1?Q?vcgagUd+elbBd0VdIdLalyFn1giAFVYxr3oGuTh1Tzhb0DODhMEwyDxHNh?=
 =?iso-8859-1?Q?KW72PMmrMkdb976E6srE9BdeleZnz70VPh7SGgOPehY8FznidbEbub3Op0?=
 =?iso-8859-1?Q?8SSQ6mZBqWNIoY0YCGdJTUvSVEagHlDANnN1dxNlkjgGyHX4y8uPK3xyzy?=
 =?iso-8859-1?Q?pvF7FoL4OspS70pP3Bh/96yoYr8NLu+GfCgYk/+f0ANLQTVTUhnNM3pLVD?=
 =?iso-8859-1?Q?iDb/a+Pxgu83AvXUz0gGh5cirpkjzKQrguujMmIIIF0w9d2mIcVUT+UFVU?=
 =?iso-8859-1?Q?lrWkOnqasoYASwqiRzp0YsFNrlTcV4KK8LwS/CbIb4GqJhf0DuKzVOnNgP?=
 =?iso-8859-1?Q?nGUpQxuNfxAjN8H0uwyC4WOG8+68R5fPw9blJYq3eTxo3GluFS0jd1A7Hv?=
 =?iso-8859-1?Q?ybD/crJfHbcGpJ2dO1FIqTt1Y5qi0OGWqpu1fDmHf0GxKyhVcsUNVPXqu1?=
 =?iso-8859-1?Q?FGf2vmklFOzdpI0YSVf6OSzLhxHRxLvLNQ08/EzEGnS4lehXDst03Pi9s5?=
 =?iso-8859-1?Q?iZe+U/CqrheaLkm5NfgFZKF6nYntu2R4ipT1ox6l9e38z0HfLy0rIFNbdJ?=
 =?iso-8859-1?Q?oNkPB44/9U0bvfP8zmjv9Q+emQZY9dRKIxwrFVDKYoH83e?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	5FE3b6Y5Yh3DSbwHRfxH0vUAopUUW3bwl+CWFVSnch3RbqI/2dYVRWxxSQ6Ql2q4mYVDMh5KeB/dpXzTPG4f2vdf9PrGI24KQz89cz1kF8Q1htpjG2LCHZahFxZOSoT2a+KYrq2kuVkYYXjuUB+tPFGmEfLQXZke/1Y/2ABTufgJhIPkBSCVHxTuDLmTptxT4yh35VH5GaLAUfxXht1+eww6cpDBziPwrADd6bIV6gmgI3y5tzZLKyHql3nlzs0sz4vdDjgc7Pc2QqMX3biMvL6co1AnoLLfwgVyPJ4iCRbCy7N7azeWFnBhMnP2u3ZF1rpolk3vbitn97d1lzzBew==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0933e5b-c05d-4863-3f5e-08df093ad41c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:38.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCkVONCFXhhVCGrfkza5eTVSRbHvA6zjzUh7NQ++941gAZ6u9e+AWaVdp99H8S2VyneNBIONpI7tm6kHU/gvpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385246-SN3K3r5GvoW3
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385246;SN3K3r5GvoW3;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The device has an internal net by which one PLL can drive the others: the=
=0A=
source PLL puts its output on it, and any other PLL can select it as a=0A=
reference instead of an external input.  The two ends are nothing alike --=
=0A=
one is driven, the other is selected -- so they are two pins rather than=0A=
one: an output pin on the source and an input pin on each destination.=0A=
=0A=
That keeps each pin honest about what its state means.  The source pin=0A=
reports whether this PLL is the one driving the net, and setting it takes=
=0A=
the net over or gives it up; a destination pin reports whether its PLL has=
=0A=
selected the net, and behaves like any other selectable input.  A single=0A=
pin would have had to answer both questions at once and could only have=0A=
been right about one of them.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 154 ++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c | 227 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/regs.h |   3 +=0A=
 3 files changed, 383 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index bd251ab60eee..c3d7c4851549 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -1686,6 +1686,160 @@ int sit9531x_clear_notifications(struct sit9531x_de=
v *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * INTSYNC configuration register values.=0A=
+ * These are written to the source PLL's EXT page to enable/disable=0A=
+ * inter-PLL synchronization (lock frequency PLL to phase PLL).=0A=
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
+ * sit9531x_intsync_enable - enable inter-PLL synchronization=0A=
+ * @src_pll_idx: source (frequency) PLL index (0-3)=0A=
+ *=0A=
+ * Enables INTSYNC global bit, unlocks the source PLL's EXT page=0A=
+ * debug registers, writes configuration, and triggers a small=0A=
+ * update on the source PLL.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx)=
=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val | BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Small update on Page 0 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		goto err_disable;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PLL_REG_=
DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto err_disable;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].en_val);=0A=
+		if (rc)=0A=
+			goto err_disable;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, src_pll_idx,=0A=
+				   SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				   SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		goto err_disable;=0A=
+=0A=
+	return 0;=0A=
+=0A=
+err_disable:=0A=
+	/*=0A=
+	 * The global enable is already set at this point.  The caller only=0A=
+	 * records the source PLL when this function succeeds, so nothing=0A=
+	 * else will ever clear the bit: undo it here rather than leave the=0A=
+	 * net asserted with a half-written EXT page.=0A=
+	 */=0A=
+	sit9531x_intsync_disable(sitdev, src_pll_idx);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_intsync_disable - disable inter-PLL synchronization=0A=
+ * @src_pll_idx: source (frequency) PLL index (0-3)=0A=
+ *=0A=
+ * Clears INTSYNC global bit, writes disable values to the source=0A=
+ * PLL's EXT page, and triggers a small update.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx)=
=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val & ~BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Small update on Page 0 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PLL_REG_=
DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].dis_val);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, src_pll_idx,=0A=
+				   SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				   SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_output_pulse_ctrl_set - program per-output PULSE_CTRL byte=0A=
  * @out_idx:	logical output index (translated to chip slot internally)=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 1a14255e89a8..993a991d5b25 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -41,6 +41,20 @@ static inline bool sit9531x_dpll_is_input_pin(const stru=
ct sit9531x_dpll_pin *pi=0A=
 	return pin->dir =3D=3D DPLL_PIN_DIRECTION_INPUT;=0A=
 }=0A=
 =0A=
+static inline bool=0A=
+sit9531x_dpll_is_intsync_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_PIN_ID;=0A=
+}=0A=
+=0A=
+static inline bool=0A=
+sit9531x_dpll_is_intsync_src_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return !sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID;=0A=
+}=0A=
+=0A=
 static inline bool=0A=
 sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *pin)=0A=
 {=0A=
@@ -717,8 +731,214 @@ sit9531x_dpll_output_pin_direction_get(const struct d=
pll_pin *pin,=0A=
 				       enum dpll_pin_direction *direction,=0A=
 				       struct netlink_ext_ack *extack);=0A=
 =0A=
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
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+		*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_intsync_src_state_on_dpll_set - drive INTSYNC from a PLL=
=0A=
+ *=0A=
+ *   CONNECTED    -> this PLL drives the INTSYNC net=0A=
+ *   DISCONNECTED -> stop driving INTSYNC if this PLL drives it=0A=
+ *=0A=
+ * SELECTABLE is rejected: driving the net is an explicit output routing,=
=0A=
+ * not an automatic-selection candidate, matching the regular output pin.=
=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_src_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc =3D 0;=0A=
+	u8 prio;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+			break;=0A=
+		if (sitdev->intsync_src >=3D 0) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "INTSYNC is already sourced by another PLL");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		/*=0A=
+		 * A PLL that already lists INTSYNC among its references must=0A=
+		 * not also drive it: the destination side refuses the mirror=0A=
+		 * of this, and without the check here the net could be routed=0A=
+		 * back into the PLL feeding it.=0A=
+		 */=0A=
+		rc =3D sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+					     sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID),=0A=
+					     &prio);=0A=
+		if (rc)=0A=
+			break;=0A=
+		if (prio < SIT9531X_PRIO_MAX_SLOTS) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "PLL selects INTSYNC as a reference; it cannot drive it");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_intsync_enable(sitdev, sitdpll->id);=0A=
+		if (!rc)=0A=
+			sitdev->intsync_src =3D sitdpll->id;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		if (sitdev->intsync_src !=3D sitdpll->id)=0A=
+			break;=0A=
+		rc =3D sit9531x_intsync_disable(sitdev, sitdpll->id);=0A=
+		if (!rc)=0A=
+			sitdev->intsync_src =3D -1;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc && rc !=3D -EBUSY)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC source state");=0A=
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
 /* ---- INTSYNC destination (input) pin ---- */=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_intsync_dst_state_on_dpll_get - INTSYNC reference state=
=0A=
+ *=0A=
+ * Selection role, so the contract above decides this exactly as it does=
=0A=
+ * for a physical input: the priority table is the eligibility record, and=
=0A=
+ * whether a source PLL happens to be driving the net right now is no more=
=0A=
+ * a state than a momentary LOS is on an external reference.  The one=0A=
+ * addition is that the PLL driving INTSYNC is never its own destination.=
=0A=
+ */=0A=
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
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
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
+/*=0A=
+ * sit9531x_dpll_intsync_dst_state_on_dpll_set - lock a PLL to INTSYNC=0A=
+ *=0A=
+ * Selection role, so this accepts and refuses what a physical input does,=
=0A=
+ * CONNECTED included: the device pins no reference on request whichever=
=0A=
+ * source is asked for.  INTSYNC is an internal net with no physical=0A=
+ * receiver, so only the per-PLL priority table is touched; the source pin=
=0A=
+ * controls generation.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
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
+	if (rc =3D=3D -EBUSY)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Only source left in the priority table; it cannot be emptied");=
=0A=
+	else if (rc && rc !=3D -EINVAL && rc !=3D -EOPNOTSUPP)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC input state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Do not add .frequency_get / the generic input state getter here: the=0A=
+ * destination pin id is SIT9531X_INTSYNC_PIN_ID, one past the end of the=
=0A=
+ * ref[] array (INTSYNC is an internal net with no ref[] entry).  The ops=
=0A=
+ * below only ever key on chan[] and the priority table, never ref[id].=0A=
+ */=0A=
+static const struct dpll_pin_ops sit9531x_dpll_intsync_dst_pin_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_intsync_dst_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_intsync_dst_state_on_dpll_set,=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+};=0A=
+=0A=
 /*=0A=
  * XO (crystal oscillator) pin ops=0A=
  *=0A=
@@ -1044,8 +1264,13 @@ static const struct dpll_pin_ops sit9531x_dpll_outpu=
t_pin_ops =3D {=0A=
 const struct dpll_pin_ops *=0A=
 sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)=0A=
 {=0A=
-	if (!sit9531x_dpll_is_input_pin(pin))=0A=
+	if (!sit9531x_dpll_is_input_pin(pin)) {=0A=
+		if (sit9531x_dpll_is_intsync_src_pin(pin))=0A=
+			return &sit9531x_dpll_intsync_src_pin_ops;=0A=
 		return &sit9531x_dpll_output_pin_ops;=0A=
+	}=0A=
+	if (sit9531x_dpll_is_intsync_pin(pin))=0A=
+		return &sit9531x_dpll_intsync_dst_pin_ops;=0A=
 	if (sit9531x_dpll_is_xo_pin(pin))=0A=
 		return &sit9531x_dpll_xo_pin_ops;=0A=
 	return &sit9531x_dpll_input_pin_ops;=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 98425c04d3d0..1db6dcf342e5 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -317,6 +317,9 @@=0A=
 #define SIT9531X_PLL_REG_ZDB1		0x1E=0A=
 #define SIT9531X_PLL_ZDB_EN_BIT		BIT(4)  /* zero-delay buffer enabled */=
=0A=
 =0A=
+/* PLL EXT page INTSYNC configuration registers */=0A=
+#define SIT9531X_PLL_EXT_PAGE(_idx)		(SIT9531X_PAGE_PLLA_EXT + (_idx))=0A=
+=0A=
 /* PLL STATUS register bits */=0A=
 #define SIT9531X_PLL_STATUS_LOCK		BIT(0)=0A=
 #define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)=0A=
-- =0A=
2.43.0=0A=
=0A=
