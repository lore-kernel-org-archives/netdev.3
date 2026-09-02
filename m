Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAE41A517;
	Wed,  2 Sep 2026 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385257; cv=fail; b=KQJIu/Lmvu+7P318M8Dy9UL03VoQtc19gstPppay6LdaGjMcM4q+hMK25FUtr3smMr4ElYuXu20P/jD+LmIXKyKDWj4M+PrvKenUxgCW8hcSnVp8VM31vIb2tFiOBniFmvgiEyCqxKY+7HYPNd4Vks5dKTnhTMC7qy8LssIApsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385257; c=relaxed/simple;
	bh=Va9GuHpxBWSDJPZ2gYxkXBY9LL4imgs1E+RMMSb2WS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vy0CBQ26r7dE+3h9RH0L9+GC6fiTQhQqMb11RisOKUfoiHaxsbH8ru1t0y+1lyHtczaaiU/RAotRdNyqy8GcurCl4ck3Co+VZk0xX3aYLtuo2IpjHZ5kkXl5bImsxxnfQalerJyEVO1M479YivgOM2CgJtWphujBmR1HQmV5kTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=ShRrFtTo; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=EeecK2EW; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="ShRrFtTo";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="EeecK2EW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=ZOB1yyUkCEfpxXL8fRslw+BqZhXFYPhHLJzmx5/4R8Q=;
 b=ShRrFtToxcMB55zut9BuJPoXs1rGxkT0LoXEkFHmjWBp6VeXvZifMpu3eRhbx/HwAo6Dj6Znredt+cXJV0P7mzwRGjyBlsHR7guIoPrrP0CyPnVVzJhSp/gMwb1MKA96sI0udJduRTPaa5qvTChbIh/xnVHStL9cCLp42dBNnh3WjwA8pkseQXMCdCqOJ7q6/4Sf/GdKM9hPsCn3mpfjsT4V+UeYFPkI9JGvI+OJ1qeHDL+J0i8kINGHq3J16mmoSJJml0gUakmpg8R1IJv1tXJdKjY5nx4XNKT5XIBeU7GSIv4KJlGQvsCZJUrtl9f6+jJ2+NXKosB2wnDjS6Ip4Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7CB12240069;
	Wed,  2 Sep 2026 21:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ni2ApdKMdSvGfjzctOYdQQ8o2DSM19Ogqk+wk1s2DAOrnLTC8iYtR1E1V4xg3VxeZoNk08yWU9WOTolI3hWEf3EczVY2bw0lnHYJWacrp7Y6QO5fS4cZyAcoC2VZUylC1ZMVmkEqdr//Xx9TPbgPK0idFOS9kLTXOYaEHYrZogBirQRcke8JP8t5YNHSTWCC336Fu1LGs4yp9UmsoHjqj+b3IYuUJ5d/yv1xXNk9a5IUlgo8wHRMSWbQx8ofUHGoNcxjUymW+8VIfn+EX9WjifO5ZdfqMcHFO5In4H+Ij8qodewgnmE42Ls4To/j8ZuOexWjpalD86XcR03V7f8HiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOB1yyUkCEfpxXL8fRslw+BqZhXFYPhHLJzmx5/4R8Q=;
 b=GWFfN/nQiT/IML9pPIrFvX+Xuj87+gr1Un2g+JB+3coRHs+0UhR6msDz2sEzzD8Rx4MNXz0U0B/Qz7hx9DmlJ5ix0HpmGBXOHdugO90kYP0SHGNoqF5gJgBlw50Vl4UUv8CBA8lDpl71HgPqqGwINk5vWJF3DSek5mXrujc7DsyAxwsXvm8ErnqC9ttCDDSJHuA2NYRt85hb2xdfFiNnjvdr1GCEB4b0WeED+/80/C8zppxeog0X/KfWd7KmAka6c8VpRl/g3eM5474xSMkKscdJao0O7T/v7ifPwFcFCqQyyHWUO3WUxu9Cnjh9E9aMtsw46LxjSVVqVAIKvWUptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOB1yyUkCEfpxXL8fRslw+BqZhXFYPhHLJzmx5/4R8Q=;
 b=EeecK2EWMkwcc+povp1/cRG552NiImfFdcHy2KJg0Bt41eCMBEBwnqM6wlSflxVMSNvfDjV1+alwwmM5tYaCMvI17F0AmNLiZZpjcsqR6RtfH4bXRnga0TfqUboLQr8Tk/6hY2x4LYcDQwMl0xhMIzxcZRJXiHU+NjubePk7PRh3f0nxeQLWEyMLDyfsIGEYZVq24DoMrZEeI3Qb+5DhZdsopZFkOU/E4+M23BGA8d4eeyGubpOW0NJm8C3JuSqtl78a1loHsvtR4tg+WO0lHajjE35wymEffWm4VKiUneEaWk6XalD1mFyI09t7U5f4PxJKHla2W5KmIIj0m5NZHA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:36 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:36 +0000
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
Subject: [PATCH net-next v8 11/15] dpll: sit9531x: add support to get and set
 esync on pins
Thread-Topic: [PATCH net-next v8 11/15] dpll: sit9531x: add support to get and
 set esync on pins
Thread-Index: AQHdOyOwbuY3GSPEK0aUf9+si1JKiA==
Date: Wed, 2 Sep 2026 21:40:36 +0000
Message-ID: <20260902214030.20955-12-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 21db14fe-68d0-458a-f13d-08df093ad34a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 Hb3OvJDEmKPF8lEALJHJIFd6YAtcdFjv0k7CEfA7RRjl7vrKymOLvT9uSj1MuljXfhtWjc9uj/8TM5wHkZpqAA0qXQvBhh8T6Tv4pxJdGG56/J24zT596QjIzMtwKsHonNNzeXhxjA4gqwPixZbvau+jt2l9Urojn6hO9IvQz1Y5ukmqhuCvJnLe0brqBdBsq+IPDo7LiOByEJBKlxEyCs3wfdRI+eWHcj3hYZx1uLzC7/3jlROLP8/eMnanRvLFJh6792j2ZQ4GM1Vg8xl8PQf/ASWJ78ItvVbAVHBwGlv+Dy7KtPm6Y5llJwisXVWZlRQez9UdB8dt+sNo7qkMqokuEYGzHtYodNY8RAkG9y9Fs8Jq5adNSBswf08dnZqVbnmIsuiF+MZ1kDYkyLvaYcCNunCXxsq0hBacLwoeIYPYdMGmY07GUs2tH8Lb5hv635WviHQL+xqUIh8YPnnld9oZjJbMV3/gac3kIhxeuaC1HXnxtQXhq8wOUW6+kdz+YdQafrkhsiT5qjflmhu0DlovbCmCixdaREVHBQvsH3++LM9Xn/kSxKVj+OOuSaHyw9cdJrMbc9eHE5E0Gmv8MUFiFgG+ASik6dPhpe4kfK+64hJc71XC3XSIkrq/1w6J6TdQp/A+A4RW55W/oJXefeqX/AIHlQ38OeD+c+BNLitGuVH3TrlngwMUWyShHbmfWM5vPvP2ZFLiwgA+e/1dymtPcEJKF+8W1kse3xC9HEM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TnZvqMg9Sza+ZOeuIjU6jcguJc57UHbjLcUSWY7Iu4CUy7sAGrj8b9JBWR?=
 =?iso-8859-1?Q?TpQPs21AAlhMkIbn+n9fTNsfBTw0oaQwltmkQu4dUYlv3Hynbl4P7MXuu8?=
 =?iso-8859-1?Q?WSlubhjq6ZYn9Q8TP6jJ4R71vaONDgTUPcz0MPbA0Itj/7szzMm91Ol8Cv?=
 =?iso-8859-1?Q?PWere+jaxMWACFhRNo1ylKzF9W7O12+WSZ8Ea3STaTMyV6Kt4IWOWUMX++?=
 =?iso-8859-1?Q?+XJI4l+EUE70IBTjlqjeW0TjG7ZyD+DCgqMt5WaaoRH9AuPyjSLMKFYf7b?=
 =?iso-8859-1?Q?XFUXuhUB2M4TONkxOtrSAY8fxUiq3D7GBgl9kTVEqLoyFnCfaxarpr0WnS?=
 =?iso-8859-1?Q?t1aSC1acxK0Us7yMz1grep5CGJZdqmf1smigQhjJCFq/Pg+RFo75a0RdgR?=
 =?iso-8859-1?Q?qnHz8PTnhr/GPMgIw2GI8685zYMlR5efooK1vlTMVDysv1OgUJvP6ZCNeX?=
 =?iso-8859-1?Q?2vO8rPwQfwilwcB0KUBeGw36HW8brAQP58mZwMyQyKkj5fysYAeFnJUMFQ?=
 =?iso-8859-1?Q?EPZJq1nR39PelG8nuAwbjrQufHk4YMXHpcdqxdcEw5wEko2l7vuyiWBKLG?=
 =?iso-8859-1?Q?9y40T7+36grBbyBu/Yoi1W4CTHTPiiKTI8GRZsBLQ/VB4ofp+7jKGGVmxp?=
 =?iso-8859-1?Q?t4NxwZ6DOUDSMWlsGmUIlurnXXzTNO/AtFS1opXkzg7yK5aSA7nsWdC9mN?=
 =?iso-8859-1?Q?qGpwScS4FHi+xHmS0TLcGk3C/DtwvOzJhXa7g3ShmkJzOuNOdnf/Zkvn/2?=
 =?iso-8859-1?Q?ySsfY/dZG14OtfVNwCysH5gKgNeexy4ZuxOVXx5Qc7jlxlQw2AgQdvmQmL?=
 =?iso-8859-1?Q?EddtevhLryo1XgVF5ci2cj8KWr01+0b0gZh9Bv6VPdMqeXwTjYtHp3bRZ6?=
 =?iso-8859-1?Q?npWdcbzTSsS7/BXnP92o5Wpbqf3h+W167fnCqavuM+HLByDgrZTmDaCWX7?=
 =?iso-8859-1?Q?F/jObLBMSQ4Nk1rmH+hzfhkdjQBCbf4szg41U8CEzvRPDlkqgHw0ggUApl?=
 =?iso-8859-1?Q?s4ZZiaNwRo9LddrRDkkF9n6v5PQGjiy7vjS7IhDZjJXWiDvKLlZbBkgKz2?=
 =?iso-8859-1?Q?SUByLOQqzUivjkW2lAIxt7BOMVRXT7Jo0eo1gd8Ke5+mcsFXlVoqGEbcmF?=
 =?iso-8859-1?Q?vBD1Y7DLh7XI+bYO5ZVkJ3yzSsaMfZLGtCBq9N60upU+7oZPBh3jhBc9//?=
 =?iso-8859-1?Q?uwjIJnUGfyrrnQGeuNYfg+WZcW606yExJRl6XNmp0VU5UjeVb+zYIc/5BP?=
 =?iso-8859-1?Q?xIfvOIa4CVnbd4HlFLtbSKEOgmyk357vEqZvcYxw7ZUGjEidTAVZBsm6kq?=
 =?iso-8859-1?Q?NBQgBMuR0XAA8rRKPpAvrLs23x37e74PgV5kIC1xUwlTtZRg5eILQFK+zY?=
 =?iso-8859-1?Q?xyZSEzJDCavxpvxOuoJ4iedhBzet5VxQ9UWhpukFBrQviGc+8diKf8VoUW?=
 =?iso-8859-1?Q?WLfpVkmeOCCpIRadfD2Pjqajc4pj49kJdrQwzBiamiynlIiz1FRzxDEe0I?=
 =?iso-8859-1?Q?QHWH4LZ/LYHjcgEbkHja3tcdSQ37eC+4bHmpBlmSkC2EOYo4i0MTNzEr9j?=
 =?iso-8859-1?Q?gZSq9uDjnWUoQu/upA/VPzy6zpCWPlos/bE+p8vO6cnAzn1qkfiYytdYXF?=
 =?iso-8859-1?Q?6fb52U/VsQFSMHwfFbb7uK2iBt+SWApWalztGT76A4WApujcFNgN/T6eJn?=
 =?iso-8859-1?Q?0u8zdW6G7PwkahX3Zzap+Wmov/rSI3pf7rqmUP1t8EXg1LsQfGEnkXYCMa?=
 =?iso-8859-1?Q?rKoV9GQdM9KO/YKrbV7kASG4gXe7q3SYJKy4SmjNe7jSBG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	y0CMC2OtgMvbxYANV3PnvDJaothfCc4colhRoi3XUUw0u6IxqYZCUHtJLpw/X8UvsEnp6xvm/l026H24gs6aiC2DGVFSbjyDm1jTSNXzXiGWxCZ33bsEIJOliWBjXOMNwKifzC7TjlYc2E8BERnREDtSmuyh6PcZpkyybL27Aig/lH6krYbdTriowZFEz7q5IYQ133d4hJEK2sJJfLQ1L054/9rbvova3FT+7GBFnge6+GQkMOQ5Xj4oYULMrK+BCmPULTYsu1m4XhTYuaIOaA5v2qlxWgRU4LxxKeue419ghrDh/5Ac/DGm19bzannBn920oFHC2ZMYVHgnMl160g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21db14fe-68d0-458a-f13d-08df093ad34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:36.7203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTQP3Yml0cbDho7zfOClDI5OpL+Q++NqY/K6RII51h/46lxUvCg6K+skA/IQI4rSmurm0zlbFekJwylRBm6NYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385244-H8mOVcevCEDB
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385244;H8mOVcevCEDB;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Embedded sync marks a one-pulse-per-second boundary inside a higher-rate=0A=
output by widening one pulse.  On this device that is the same divider=0A=
programming as a frequency change plus the per-output pulse control, so=0A=
enabling it sets the output to 1 Hz and disabling it restores the=0A=
requested rate.=0A=
=0A=
Only outputs the firmware describes as esync-controllable offer it; on the=
=0A=
rest the operations are refused rather than silently reprogramming an=0A=
output whose board wiring does not expect it.  The pulse width is fixed at=
=0A=
half the period, which is what the device produces, and the core is told=0A=
the supported range rather than left to guess.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 51 +++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c | 99 ++++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  7 +++=0A=
 3 files changed, 157 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index be033d7cfe7c..c93578f3b750 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -1535,6 +1535,57 @@ int sit9531x_clear_notifications(struct sit9531x_dev=
 *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_output_pulse_ctrl_set - program per-output PULSE_CTRL byte=0A=
+ * @out_idx:	logical output index (translated to chip slot internally)=0A=
+ * @pulse_ctrl:	8-bit PULSE_CTRL value (PROG0)=0A=
+ *=0A=
+ * Writes ODRn_PROG0 on the output page (Page 3 for slots 0..5,=0A=
+ * Page 4 for slots 6..11) at offset 0x1B + 16 * (slot % 6).=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,=0A=
+				   u8 out_idx, u8 pulse_ctrl)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, reg;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+		SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	reg =3D SIT9531X_OUT_PROG0_BASE +=0A=
+	      SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);=0A=
+=0A=
+	/*=0A=
+	 * PROG0 lives in the output system, so like the DIVO and=0A=
+	 * PRG_RST_DELAY writes it only takes effect inside the PRG_CMD=0A=
+	 * programming state committed to the NVM shadow.=0A=
+	 */=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, reg), pulse_ctrl);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD state via prg_commit(), even if the write=0A=
+	 * failed, so the output loops are re-locked rather than stranded=0A=
+	 * unlocked; keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_ref_state_fetch - read input reference status from hardware=0A=
  * @index:	logical input index=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index c07fb2256510..76d7d7d21d3d 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -25,6 +25,17 @@=0A=
 #define SIT9531X_ESYNC_FREQ_10MHZ	10000000ULL=0A=
 #define SIT9531X_ESYNC_PULSE_DEFAULT	50=0A=
 =0A=
+static const struct dpll_pin_frequency sit9531x_esync_ranges[] =3D {=0A=
+	DPLL_PIN_FREQUENCY(0),=0A=
+	DPLL_PIN_FREQUENCY(SIT9531X_ESYNC_FREQ_10MHZ),=0A=
+};=0A=
+=0A=
+static inline bool=0A=
+sit9531x_dpll_esync_pin_supported(const struct sit9531x_dpll_pin *dpin)=0A=
+{=0A=
+	return dpin->esync_control;=0A=
+}=0A=
+=0A=
 static inline bool sit9531x_dpll_is_input_pin(const struct sit9531x_dpll_p=
in *pin)=0A=
 {=0A=
 	return pin->dir =3D=3D DPLL_PIN_DIRECTION_INPUT;=0A=
@@ -785,6 +796,92 @@ sit9531x_dpll_output_pin_phase_adjust_set(const struct=
 dpll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static int=0A=
+sit9531x_dpll_output_pin_esync_get(const struct dpll_pin *pin,=0A=
+				   void *pin_priv,=0A=
+				   const struct dpll_device *dpll,=0A=
+				   void *dpll_priv,=0A=
+				   struct dpll_pin_esync *esync,=0A=
+				   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+=0A=
+	if (!sit9531x_dpll_esync_pin_supported(dpin))=0A=
+		return -EOPNOTSUPP;=0A=
+=0A=
+	esync->range =3D sit9531x_esync_ranges;=0A=
+	esync->range_num =3D ARRAY_SIZE(sit9531x_esync_ranges);=0A=
+	esync->pulse =3D SIT9531X_ESYNC_PULSE_DEFAULT;=0A=
+	esync->freq =3D dpin->esync_freq;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_output_pin_esync_set(const struct dpll_pin *pin,=0A=
+				   void *pin_priv,=0A=
+				   const struct dpll_device *dpll,=0A=
+				   void *dpll_priv,=0A=
+				   u64 freq,=0A=
+				   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 actual_pll;=0A=
+	int rc;=0A=
+=0A=
+	if (!sit9531x_dpll_esync_pin_supported(dpin)) {=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Embedded sync not enabled for this pin");=0A=
+		return -EOPNOTSUPP;=0A=
+	}=0A=
+=0A=
+	actual_pll =3D sitdev->out[dpin->id].pll_idx;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * This output is a dedicated embedded-sync pin.=0A=
+	 * Treat freq=3D0 as a request to disable the entire output.=0A=
+	 */=0A=
+	if (!freq) {=0A=
+		rc =3D sit9531x_output_disable(sitdev, dpin->id);=0A=
+		if (!rc)=0A=
+			dpin->esync_freq =3D 0;=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	if (freq !=3D SIT9531X_ESYNC_FREQ_10MHZ) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Only 10 MHz esync frequency is supported");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,=0A=
+				      SIT9531X_ESYNC_FREQ_10MHZ);=0A=
+	/*=0A=
+	 * Program the pulse generator (PROG0 PULSE_CTRL) so the embedded-sync=0A=
+	 * pulse is actually emitted; without it the output carries the clock=0A=
+	 * but no esync marker.  SIT9531X_ESYNC_PULSE_DEFAULT is the same duty=0A=
+	 * the esync_get callback advertises.=0A=
+	 */=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_output_pulse_ctrl_set(sitdev, dpin->id,=0A=
+						    SIT9531X_ESYNC_PULSE_DEFAULT);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_output_enable(sitdev, dpin->id);=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (!rc)=0A=
+		dpin->esync_freq =3D SIT9531X_ESYNC_FREQ_10MHZ;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
@@ -793,6 +890,8 @@ static const struct dpll_pin_ops sit9531x_dpll_output_p=
in_ops =3D {=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
 	.phase_adjust_get	=3D sit9531x_dpll_output_pin_phase_adjust_get,=0A=
 	.phase_adjust_set	=3D sit9531x_dpll_output_pin_phase_adjust_set,=0A=
+	.esync_get		=3D sit9531x_dpll_output_pin_esync_get,=0A=
+	.esync_set		=3D sit9531x_dpll_output_pin_esync_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 91d33abd15c3..251c98dc7cbe 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -215,6 +215,13 @@=0A=
 #define SIT9531X_OUT_PRG_FINE_MAX		7	/* 3-bit field */=0A=
 #define SIT9531X_OUT_PRG_COARSE_BITS		34=0A=
 =0A=
+/*=0A=
+ * Per-output pulse-count control byte used in SYSREF / SYNCB modes.=0A=
+ * Slot N within a page sits at 0x1B + 16 * (slot % 6).  Same page=0A=
+ * mapping as PRG_RST_DELAY: slots 0-5 on Page 3, slots 6-11 on Page 4.=0A=
+ */=0A=
+#define SIT9531X_OUT_PROG0_BASE		0x1B=0A=
+=0A=
 /*=0A=
  * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
  * DIVO_PHASE_SEL_REG selects the in-register trigger source and=0A=
-- =0A=
2.43.0=0A=
=0A=
