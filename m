Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07350E5B0;
	Fri,  9 Oct 2026 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570737; cv=fail; b=tpjeaoKZVcMeUOABq2dO83SqEoFajJU7JpDkyIjgPnjzz31CI3snQByMkxzB3ysdViWJENMQJ/taFDFIgH3N7634xjdJ2bexy0xKl7TKPg7xveirsm4YucorHmT4d2q7t/+pkhBuBd/P45JRj8WCdlWUrhR0Hll3oWS3bMeDFm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570737; c=relaxed/simple;
	bh=k3yhTCglXYJ0j3y225cx2KNARTmo+MC49KNa5IlpHok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LSQy/sqQQvtpVwVFb+4ivC93eub2Tp6zzSE+FpDLLH9Y0qaipbhg30GiK0VVlhnlAlXycAQjgxvA/64d+W/W7ycFp3blXdUWLg9F2j1iJYTYpdivd00rHmmk8+V5fwLYYd36+EtmzeIofEo8NYQUtNoak9KNRd/2rwFqgBKzvfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=X8FTo1Z1; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=toy8scdx; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="X8FTo1Z1";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="toy8scdx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=MVsvne0g7XDNnSO+k75tBX206ktBLnRyo4WUbRYUz0k=;
 b=X8FTo1Z1DO7mZsqIOeNIluYtbgJGE6nuwaxgv+J4KVl7riwzjwb00aS+XbEJvXValifXsOOXG3MWamw6Z4+B4JUB3IrZCvfpuKlxgIfptjQxljw7jLnLSNLpLkRtJeAGtyjnj7zTNGVpTRj1Rvpa5RxmxIvd28rPgnJh3gt+qfS55iTS0PfvrTnpFt3mZoiols+x8inGeW58pbrkzqgJxlnzdeyqQHZzMu5Vsc76v37+dgzi4Nv08fnoW6N5iEzpIa4e2hbgmPPRXG+kl8eXCc4IL5HGXA07dw/o9kKZ91X2HEkjjoSYDpWVmFeYHJCobQs98bF++Cbb0tKcbZbTxQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023086.outbound.protection.outlook.com [40.93.201.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id BC873800011;
	Fri,  9 Oct 2026 18:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz3hO6pLMYuRUNdv932BUv+Y0552f1ch+z6dZy1+Qp3a5ch3ZJW90fYl1lPI0LHtf8R0TvsgrHwDPRMwRhKKVyIB8J7rB4yzjBnh/aeFr53qbj8fBV17cCet0XN0BleLOLeAgn1IzhidBmjM+IpA1OA/r9ApDxMhk/vz4iIINlxUXSV7aHzOP2EYEwyRSrM14eIIMklb/bYcVesx/S3OC727rs32rV87AQK8HhNT1VJpMNMnig9vKNgLmHUL3vfsuOMnTehL6IuPdldEHcymCNXPpbE6h3M8TzI2v1nVxk58XGIkc8XZMtyxiFil9bOWCPG0JsqlWdZv27Fjyc+xRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVsvne0g7XDNnSO+k75tBX206ktBLnRyo4WUbRYUz0k=;
 b=XpS8dRHLxfF977LQKhqLAtcGYrK50yTulvkWeVZFwRGzhcrxPcbs3MZwzVFdWXJbUyC6I5p2HNnWMOev/OzaW3/qcDTWF+OF3Yc/Rv7pBaHj4E4x+r7zuYnmjWrcgMBSklKAM71gYYoOltEb3L+F0ALNHGG0KFAbXpteY+Vf1JwqDTVtlgkhhEBIf02YuuahuasNwlSOwZz7WuMHx4dw9HnkeSQXXG1Px805GqPheVch5/sJFQxlKMG6gpr+DgVxdLvgIvI9tPgJLn29jl07uC549/qw9PWkCVPBNH1x9n8y+xEqCfDfu/oCSLXNuvZXiFXtLVMETpZAlWjvAJ2qYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVsvne0g7XDNnSO+k75tBX206ktBLnRyo4WUbRYUz0k=;
 b=toy8scdx2u8ZABmm4ZJ6Hjhga/MGBbhWFKiVx4gBMWOyK+Smzdn28TNyFK2xc7sJaOwpjmEr6pSbYYmxQaRDkCOLbCCmxCCOhW1i0R50Zk8reOEiuP0JacBPBCkmnO3GAAu6YGckRl5IhauVfDU++6+YUzSA/9L6auT1wtcVWtIL0gC3oyrayq6ENtUePcn5K7p3HpVoZM/XBwYFx9KFdslr3Brm1eHNB6nc975EW3pd57AEPtklVAX/+a5RVfP/r2bY5e9/onEjU0Huckti6f3fQ0ebWeXccCazSkHURl4ikC9Gn6nYt0QX+hJMcr2XJxHsN1NN5YZpJHgvwO4tsg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH8PR20MB995515.namprd20.prod.outlook.com
 (2603:10b6:610:2eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:32:00 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:32:00 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v12 12/12] dpll: sit9531x: model the inter-PLL sync
 net as a pair of pins
Thread-Topic: [PATCH net-next v12 12/12] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
Thread-Index: AQHdWBx5SvQNrPKPEEyMMQbCnHdNyw==
Date: Fri, 9 Oct 2026 18:32:00 +0000
Message-ID: <20261009183151.78497-13-arouhi@sitime.com>
References: <20261009183151.78497-1-arouhi@sitime.com>
In-Reply-To: <20261009183151.78497-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH8PR20MB995515:EE_
x-ms-office365-filtering-correlation-id: 09f30672-27c1-4352-bc66-08df26339bb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|5023799004|260925021311599003|260925021911599003|260925022911599003|10067099003|22082099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info:
 blo5nou9aP9WudYTLl4YJe7fSOvb0NCV4zy4liAvH5dCcDbjkaJG3GgisqR3IOxITqNVmj8g9xQL5fTGp2Tl/GxbSuGYIblMNA9dPCe8dGpigu1JRjJNjXRjjlus5/1by+Au7Xw9PckR+acmSKghuE30TrPBMP3z2pnDwkh9OYN5ITEOPrG4yBeDYZcVB6KLOTSvWDxfDE0ruiH0xCicvODB9F8WTDJ+csbE82ZojWzvLUzygD2Ym0hYukOGjtQJP1+i/4L4Eai6exQXfBSQu7D4XFQeJNX7UbcnC2CeBUXXoLKkZzHYKnzYkcyRJQlM0CWm+Wy5+KbOzFq0NVkzbZVUVPAW1ltKJEoLBXPxiaOqWE+nJwxzF4c5i8hUF1Bd816f6nWcMS/rixYtYpqRrj/xarht7MZJDjLlvQtsNvfpLtJ0rqmD9eRZt2gwuT1ai/VCD7Ow7Wo+xKLIflDTBBqTBBcKMv2yeVkTNijA5ZydoCoGF2Bi5yYVnoB3/K403crK4C/2IjsChsGxEkp9JoS8Y4V/iJOlJY04gVCAatmpzTJMUI/i9cnEg9ovQQ1+XnlwTosCzKL5hoBRMV3Al88wgo2pXwvj4lC0PiaipJV8BPRXg3rMz0UVL1Sl2wdfG2dHPoMRKk+Va11RlwUIvqaai8VkGE+rDa3i3eoQwCpYccc4qW9YcwUTiuqH6gSEL/2m7h6kAyKk0kpdVLJS3n9ambYzyR9xh17h0u0AuBg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(5023799004)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ObbORy2S65P6dUwq5EdpeN4pvE/ShzL31PCwuIW7mOBgGXE1oyaMU9pASp?=
 =?iso-8859-1?Q?khAqMVtslBYOXzSCX0xP4ex9e3LyS8x5pZv4PKSrNT3tBh/9JGu3UlPZ7C?=
 =?iso-8859-1?Q?Ii1NZXpF8RpAfp04wBIvAB+XKG6gsidlsEa3Zj7hpR0+zdRPKbe5h/rIAM?=
 =?iso-8859-1?Q?DA3yr3WQSaFOSkMqtUky6kP+pfedw76RIw4sX2O09Szr6PfKGmmUD3hBLS?=
 =?iso-8859-1?Q?jpyfrSY27ja+5u99Nlh1BTjj2TOYIxNyhlSXdYDKK+s4vmAhyerdMXxODP?=
 =?iso-8859-1?Q?+lPzWZuKiDLHOX8aAaHrEL03yKWfeFxxbS+sDdvNhNYMyxE5DJKP1kRdHY?=
 =?iso-8859-1?Q?Lrh/ASV1FFgYuL/Y8uScdiGmwAjGGHbA9dfNjgdxoHGVBg31uOiW0EhKQ/?=
 =?iso-8859-1?Q?2Q/tsmv+6CD38zo87VsJwcAOWddLndMaw6CV7dfk9xNza/qRUUEaxojFuA?=
 =?iso-8859-1?Q?d3FvS2Sb78JJSXaiaX4AwwahnqzOxPVPuok8SkANnAJrdw9wbB8smKSeum?=
 =?iso-8859-1?Q?VdeLN8BUfqzllVRVF3E5qaWOKS2K0jdbrmQbFuLE5BO2FkbmZO2dvLtegO?=
 =?iso-8859-1?Q?6DYRKAVY2+VeYKEv8CUmbay2qT4vZ9fVH/bO2F7u20r8s7h+sg83/Sj2HT?=
 =?iso-8859-1?Q?/RiGEPBGW6C/BWWkd2HU05Jce5A/zzVZLNWdz659vuR/id8bi2gSPvuZCo?=
 =?iso-8859-1?Q?xBr8jCN76S+WLf97h8bwpmKGGTt6Wp33M+IUV0B22JsE/wQUOMoettlSKd?=
 =?iso-8859-1?Q?N1ysSefwPkwF/qorELvkTsMKICGRxiNL9UCkaBjdPECDVlxKnsKZm1xV6M?=
 =?iso-8859-1?Q?CSng3g+s4r4TdgLCLP/5GrmspnnwJnLz1q1KCbJErpq0PWapw/C8OSCdrk?=
 =?iso-8859-1?Q?9X4F3oHt0bRPmkjNgXfbwPJYQaEESl8iyjmmf6NdBwdLAqnksvyXKyV+Gi?=
 =?iso-8859-1?Q?EhNKU0PnNTUs4kGGyTUQzqHx6R/4A+1fSyie8NjfZaIIdqZLH8NRs1FmKM?=
 =?iso-8859-1?Q?IIBbSXtVD158K4+Z0ysqnRy5bGaRDz9BLWrnCamwjZ/G8NHqo61hlFh6Mq?=
 =?iso-8859-1?Q?/aUUCFV7VQUOpLL+cwTsuzF0mPp3joenT40txond4MN973pxBWiGpugtkK?=
 =?iso-8859-1?Q?FOYkuyvB8H8IZIOzxzowvxRQQzd0gF7ZITAzT2xWlDLtIKdvhyXgCLWyG7?=
 =?iso-8859-1?Q?o4h6Y1EeFfZdIBBzWZ4eu3nlRLLzfSzNovkeul5CULkeQ2d45dILR2JCEc?=
 =?iso-8859-1?Q?8I7oIcVwmMVXjruFlJ3sbvnyegmMA6JnBeVFBuI11ehPB+ihsuEPEWaOys?=
 =?iso-8859-1?Q?TtmMkyYXPfcA7nx2NClO2tVC3cpjGv1RdXZpSceVnAeWhyY2pw1S1uLSHu?=
 =?iso-8859-1?Q?ibGXRFx+JcJpig7s/3rb6K2pN4Rf29NWVNUfbRh9uVn5JfRvinnbtnenJu?=
 =?iso-8859-1?Q?I6M2hKnV+aEJxQZLyLm89usWEPR2pYq/WstQuQn8aVzgLnO9K5UNsOihzV?=
 =?iso-8859-1?Q?YvjJxDiim28hN1TV5PdE8j+oT7GkQFpvcogzpT0VTObZzUAkttOj1Wl2qo?=
 =?iso-8859-1?Q?YqgMzCBW0iI6PgN2AA4epRm6TutLNJvsF4N030GLScP2ivVCX72LVNGgV9?=
 =?iso-8859-1?Q?J0sDCZvGg0mTaA3oKw3AygwzN6hkpI95ki+rq8+DfgKTgQ0hsHgKdH/K6h?=
 =?iso-8859-1?Q?vl9TJUubGxEeZMPFYPe8ZiaXmNK0RggOhL31OFcqWidXeadCVFtSy2Hmzl?=
 =?iso-8859-1?Q?aPgLXVr8xuTjhck22zRJDPWzRBLcteNKrase+uTNOOEdqv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	zvtY8mI2UEbMBMn0Zq2S0gXgF+X6j62zQKKxpMtr7WFmFd2jwvxBofhq+We3qKkN9AMR+SMwRQzqQWkOqCvquvbjNJvFTzNDtRHFDmCDT2eQEebSy3qXJ4J8vNpjH8rF/5LX+WLby0xhwcUKVmYhVLPhXCHkl2IgSLSuPus/L994yzuNiwQeZFB4hACkqPWsm6pB4LpDiBOcyHaCbv8Hy2bQB6AZ/W21Slfx7IxN1QEN8BqDl1meo4Pr7yGy0gBK/+WkVSX5Ko//+g3nLVU5lHnnOX9ak3rsMZHIc8jv7OLJ44ACmY550htM2GUedzC0Wj7DmrixMaf+e0FuWkYh/g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f30672-27c1-4352-bc66-08df26339bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:32:00.7121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urVZN8cdVdcDaDfgDsho36dLBWKzi+C+pQk3HIvTHhXr4SpfCtNt/jVWVSai4OV6UpPP+PytF5DaEciSh/xbOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR20MB995515
X-MDID: 1791570724-RbnniSsSwW7k
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791570724;RbnniSsSwW7k;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
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
A destination pin whose net no PLL drives reports no signal, as an=0A=
external input that lost its clock does.  The driver takes the net as=0A=
driven when it enabled the source itself or found that configuration=0A=
already in place.  The net has no signal monitor, and a loaded profile=0A=
can drive it with a configuration of its own, so a PLL the device feeds=0A=
from the net and holds locked also counts as the net carrying a signal.=0A=
A source that failed to take the net over, or whose configuration the=0A=
scan found only partly in place, is recorded as a partial owner, so a=0A=
retry re-runs the enable instead of being refused as busy; giving the=0A=
net up restores the global enable only while the net is still=0A=
configured, and the restore is latched as every other write to that=0A=
register is.  A failed request that moved the owner is announced.=0A=
Ownership and the output mutes are read back from the part on resume.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 414 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   7 +=0A=
 drivers/dpll/sit9531x/dpll.c | 409 +++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/regs.h |   3 +=0A=
 4 files changed, 823 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index fbac70787ada..c2d6fbd0363f 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -3027,6 +3027,381 @@ int sit9531x_clear_notifications(struct sit9531x_de=
v *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Close the debug window on a PLL's EXT page.  The key register opens=0A=
+ * every debug register on that page while it holds the unlock value.=0A=
+ */=0A=
+static int sit9531x_intsync_debug_lock(struct sit9531x_dev *sitdev, u8 ext=
_page)=0A=
+{=0A=
+	return sit9531x_write_u8(sitdev,=0A=
+				 SIT9531X_REG(ext_page, SIT9531X_PLL_REG_DEBUG),=0A=
+				 SIT9531X_PLL_DEBUG_LOCK);=0A=
+}=0A=
+=0A=
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
+int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	s8 src =3D -1, partial =3D -1;=0A=
+	u8 global;=0A=
+	u8 pll, ext_page;=0A=
+	int rc, ret, n_en, n_dis;=0A=
+	unsigned int i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &global);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	if (!(global & BIT(SIT9531X_INTSYNC_EN_BIT))) {=0A=
+		sitdev->intsync_src =3D -1;=0A=
+		sitdev->intsync_partial =3D false;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	for (pll =3D 0; pll < SIT9531X_NUM_PLLS; pll++) {=0A=
+		ext_page =3D SIT9531X_PLL_EXT_PAGE(pll);=0A=
+=0A=
+		/*=0A=
+		 * These are debug registers, which the enable and disable=0A=
+		 * sequences only touch with the EXT page's debug window=0A=
+		 * open; read them the same way.=0A=
+		 */=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    SIT9531X_PLL_REG_DEBUG),=0A=
+				       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		n_en =3D 0;=0A=
+		n_dis =3D 0;=0A=
+		for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+			u16 reg;=0A=
+			u8 val;=0A=
+=0A=
+			reg =3D SIT9531X_REG(ext_page, intsync_config[i].offset);=0A=
+=0A=
+			rc =3D sit9531x_read_u8(sitdev, reg, &val);=0A=
+			if (rc)=0A=
+				break;=0A=
+			if (val =3D=3D intsync_config[i].en_val)=0A=
+				n_en++;=0A=
+			else if (val =3D=3D intsync_config[i].dis_val)=0A=
+				n_dis++;=0A=
+		}=0A=
+=0A=
+		ret =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+		if (!rc)=0A=
+			rc =3D ret;=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		if (n_en =3D=3D ARRAY_SIZE(intsync_config)) {=0A=
+			/*=0A=
+			 * Only one PLL can drive the net.  If a second=0A=
+			 * one matches, the registers are not describing=0A=
+			 * a state this driver put the device in, so say=0A=
+			 * so rather than pick silently.=0A=
+			 */=0A=
+			if (src < 0)=0A=
+				src =3D pll;=0A=
+			else=0A=
+				dev_warn(sitdev->dev,=0A=
+					 "PLL%c also matches the INTSYNC source pattern; keeping PLL%c\n",=0A=
+					 'A' + pll, 'A' + src);=0A=
+		} else if (n_en && n_dis &&=0A=
+			   n_en + n_dis =3D=3D ARRAY_SIZE(intsync_config) &&=0A=
+			   partial < 0) {=0A=
+			/*=0A=
+			 * Every register holds one of the two patterns and both=0A=
+			 * occur: the residue of an enable or a disable that=0A=
+			 * stopped part way, and nothing a profile writes.=0A=
+			 */=0A=
+			partial =3D pll;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * An enable or a disable that stopped part way leaves a PLL holding=0A=
+	 * a mix of the two patterns.  Treat it as the owner, so that another=0A=
+	 * PLL cannot be enabled on top of the leftover configuration, but=0A=
+	 * record that it is partial: a repeated connect on that PLL must run=0A=
+	 * the enable again rather than take the PLL for configured, and a=0A=
+	 * repeated disconnect runs the disable again.=0A=
+	 */=0A=
+	sitdev->intsync_partial =3D src < 0 && partial >=3D 0;=0A=
+	if (sitdev->intsync_partial) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "PLL%c holds a partial INTSYNC source configuration\n",=0A=
+			 'A' + partial);=0A=
+		src =3D partial;=0A=
+	}=0A=
+=0A=
+	sitdev->intsync_src =3D src;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int __sit9531x_intsync_disable(struct sit9531x_dev *sitdev,=0A=
+				      u8 src_pll_idx, bool restore);=0A=
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
+	int rc, lock_rc;=0A=
+	unsigned int i;=0A=
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
+	usleep_range(1000, 2000);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev,=0A=
+			       SIT9531X_REG(ext_page,=0A=
+					    SIT9531X_PLL_REG_DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].en_val);=0A=
+		if (rc)=0A=
+			goto relock_err;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_pll_small_update(sitdev, src_pll_idx);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
+	rc =3D 0;=0A=
+	goto relock;=0A=
+=0A=
+relock_err:=0A=
+	sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	goto err_disable;=0A=
+=0A=
+relock:=0A=
+	/*=0A=
+	 * Close the EXT page debug window the sequence opened.  Nothing=0A=
+	 * else writes the key back, so leaving it open would keep the block=0A=
+	 * unlocked for as long as the device runs.  The net is driven by=0A=
+	 * now, though, so a failure here must not read as a failed enable:=0A=
+	 * the caller would then not record the owner of a net that is=0A=
+	 * driven.=0A=
+	 */=0A=
+	lock_rc =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	if (lock_rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "PLL%c: INTSYNC enabled but the debug window was left open: %d\n",=0A=
+			 'A' + src_pll_idx, lock_rc);=0A=
+=0A=
+	return rc;=0A=
+=0A=
+err_disable:=0A=
+	/*=0A=
+	 * The global enable is already set at this point.  The caller only=0A=
+	 * records the source PLL when this function succeeds, so nothing=0A=
+	 * else will ever clear the bit: undo it here rather than leave the=0A=
+	 * net asserted with a half-written EXT page.  The disable must not=0A=
+	 * put the bit back when it fails part way, as it does for a=0A=
+	 * disconnect: here the bit is what the rollback set out to clear,=0A=
+	 * and restoring it would leave the net asserted with no PLL=0A=
+	 * matching the source pattern, which no owner on record would ever=0A=
+	 * clear.=0A=
+	 */=0A=
+	{=0A=
+		int rollback_rc;=0A=
+=0A=
+		rollback_rc =3D __sit9531x_intsync_disable(sitdev, src_pll_idx,=0A=
+							 false);=0A=
+		if (rollback_rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "INTSYNC rollback failed after enable error: %d (original %d)\n",=0A=
+				 rollback_rc, rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The disable sequence.  @restore says whether a failure before the EXT=
=0A=
+ * page holds the disable pattern puts the global enable back, which a=0A=
+ * disconnect wants (see restore_global below) and the rollback of a=0A=
+ * failed enable does not.=0A=
+ */=0A=
+static int __sit9531x_intsync_disable(struct sit9531x_dev *sitdev,=0A=
+				      u8 src_pll_idx, bool restore)=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, lock_rc;=0A=
+	unsigned int i;=0A=
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
+		goto restore_global;=0A=
+=0A=
+	/* Small update on Page 0 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	usleep_range(1000, 2000);=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev,=0A=
+			       SIT9531X_REG(ext_page,=0A=
+					    SIT9531X_PLL_REG_DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].dis_val);=0A=
+		if (rc)=0A=
+			goto restore_global;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Small update on source PLL.  The global enable is latched off and=0A=
+	 * every register holds the disable value by now, so the net is not=0A=
+	 * driven whether or not this latch went through.  Putting the bit=0A=
+	 * back for a failure here would describe the net as driven with no=0A=
+	 * PLL matching the source pattern: the detector would record no=0A=
+	 * owner, and nothing would ever clear the bit.=0A=
+	 */=0A=
+	rc =3D sit9531x_pll_small_update(sitdev, src_pll_idx);=0A=
+=0A=
+	goto relock;=0A=
+=0A=
+restore_global:=0A=
+	/*=0A=
+	 * The global enable was cleared first, so a failure here leaves the=0A=
+	 * EXT page still holding the enable pattern with nothing pointing=0A=
+	 * at it: the source detector keys on the global bit, would report=0A=
+	 * the net as unowned, and a retry of the disable would then=0A=
+	 * short-circuit.  Put the bit back so the state stays one the=0A=
+	 * driver can describe and the request can be repeated.=0A=
+	 */=0A=
+	if (restore &&=0A=
+	    !sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val) &&=0A=
+	    !sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val | BIT(SIT9531X_INTSYNC_EN_BIT))) {=0A=
+		/*=0A=
+		 * Every write of the global enable, here and in SiTime's=0A=
+		 * sequences, is followed by the page-0 small update that=0A=
+		 * applies it.  Without it the bit would sit pending until=0A=
+		 * an unrelated commit through the same update register=0A=
+		 * applied it, re-asserting the net over a half-written=0A=
+		 * EXT page with nobody having asked.=0A=
+		 */=0A=
+		sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+				  SIT9531X_SMALL_UPDATE_CMD);=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+=0A=
+relock:=0A=
+	/*=0A=
+	 * Close the EXT page debug window the sequence opened.  After a=0A=
+	 * disable that took effect, a failure here is a warning, for the=0A=
+	 * same reason as in sit9531x_intsync_enable().=0A=
+	 */=0A=
+	lock_rc =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	if (lock_rc) {=0A=
+		if (rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c: debug window left open: %d\n",=0A=
+				 'A' + src_pll_idx, lock_rc);=0A=
+		else=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c: INTSYNC disabled but the debug window was left open: %d\n",=
=0A=
+				 'A' + src_pll_idx, lock_rc);=0A=
+	}=0A=
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
+	return __sit9531x_intsync_disable(sitdev, src_pll_idx, true);=0A=
+}=0A=
+=0A=
 /**=0A=
  * sit9531x_phase_offset_read - read phase difference via TDC=0A=
  * @sitdev:	device pointer=0A=
@@ -3678,6 +4053,15 @@ static int sit9531x_dev_state_fetch(struct sit9531x_=
dev *sitdev)=0A=
 		return rc;=0A=
 	}=0A=
 =0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to detect INTSYNC source: %d\n", rc);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
 	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
 		bool clamped;=0A=
 		s32 phase_ps;=0A=
@@ -4418,13 +4802,13 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 		if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
 			return true;=0A=
 		if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
-			return false;=0A=
+			return true;=0A=
 =0A=
 		return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
 	}=0A=
 =0A=
 	if (index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
-		return false;=0A=
+		return true;=0A=
 =0A=
 	if (index >=3D sitdev->info->num_outputs)=0A=
 		return false;=0A=
@@ -4860,8 +5244,34 @@ static int sit9531x_suspend(struct device *dev)=0A=
 static int sit9531x_resume(struct device *dev)=0A=
 {=0A=
 	struct sit9531x_dev *sitdev =3D dev_get_drvdata(dev);=0A=
+	int rc;=0A=
+	u8 i;=0A=
 =0A=
 	sit9531x_page_cache_drop(sitdev);=0A=
+=0A=
+	/*=0A=
+	 * A part that lost power across suspend comes back with its=0A=
+	 * profile's INTSYNC routing and output mutes, not with what the=0A=
+	 * caches say, and the poll watches neither.  Read them back here;=0A=
+	 * a cache that cannot be read is left for the getter's read-through.=0A=
+	 * Nothing races this: the poll is parked and the IRQ disabled.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	if (rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "INTSYNC source not re-detected on resume: %d\n", rc);=0A=
+	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		rc =3D sit9531x_output_state_refresh(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Output %u mute state not read on resume: %d\n",=0A=
+				 i, rc);=0A=
+			sitdev->out[i].state_stale =3D true;=0A=
+		}=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
 	if (sitdev->irq > 0)=0A=
 		enable_irq(sitdev->irq);=0A=
 	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 1ed20354f94d..a5b343033a41 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -211,6 +211,9 @@ struct sit9531x_chan {=0A=
  *			I2C client), 0 if no IRQ is wired=0A=
  * @intsync_src:	PLL index currently sourcing inter-PLL=0A=
  *			synchronization (INTSYNC), or -1 when disabled=0A=
+ * @intsync_partial:	@intsync_src holds only part of the source=0A=
+ *			configuration, left by an enable or a disable=0A=
+ *			that stopped part way=0A=
  * @irq_ack_fails:	consecutive failures to acknowledge the=0A=
  *			notification latches from the interrupt handler=0A=
  * @fvco_band_warned:	bit per PLL whose Fref * DIVN has been reported as=
=0A=
@@ -248,6 +251,7 @@ struct sit9531x_dev {=0A=
 =0A=
 	/* Inter-PLL synchronization state */=0A=
 	s8			intsync_src;=0A=
+	bool			intsync_partial;=0A=
 =0A=
 };=0A=
 =0A=
@@ -308,6 +312,9 @@ int sit9531x_output_phase_adjust_set(struct sit9531x_de=
v *sitdev,=0A=
 int sit9531x_clear_notifications(struct sit9531x_dev *sitdev);=0A=
 =0A=
 /* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev);=0A=
 =0A=
 /* ---- Phase offset (TDC readback) ---- */=0A=
 int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index aab5a4f0f946..4c86ee9e7980 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -27,6 +27,20 @@ static bool sit9531x_dpll_is_input_pin(const struct sit9=
531x_dpll_pin *pin)=0A=
 	return pin->dir =3D=3D DPLL_PIN_DIRECTION_INPUT;=0A=
 }=0A=
 =0A=
+static bool=0A=
+sit9531x_dpll_is_intsync_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_PIN_ID;=0A=
+}=0A=
+=0A=
+static bool=0A=
+sit9531x_dpll_is_intsync_src_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return !sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID;=0A=
+}=0A=
+=0A=
 static bool=0A=
 sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *pin)=0A=
 {=0A=
@@ -311,6 +325,59 @@ sit9531x_dpll_selection_state_get(struct sit9531x_dev =
*sitdev,=0A=
 		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Does the device feed a locked PLL from the INTSYNC net?=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static bool sit9531x_dpll_intsync_tracked(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+	u8 pll;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	for (pll =3D 0; pll < SIT9531X_NUM_PLLS; pll++) {=0A=
+		chan =3D sit9531x_chan_state_get(sitdev, pll);=0A=
+		if (chan->routed_ref =3D=3D SIT9531X_INTSYNC_PIN_ID &&=0A=
+		    chan->locked && !chan->ho_freeze)=0A=
+			return true;=0A=
+	}=0A=
+=0A=
+	return false;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Does a selection-role pin carry a signal?  A physical input has the=0A=
+ * device's LOS monitor; the INTSYNC net has no monitor, and what stands i=
n=0A=
+ * for one is the driver's record of a PLL driving it.  A partial source=
=0A=
+ * configuration does not count: the source pin reports it as no=0A=
+ * connection, and the net is not confirmed driven.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dpll_selection_no_signal(struct sit9531x_dev *sitdev, u8 pin_id)=
=0A=
+{=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pin_id =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		/*=0A=
+		 * The driver knows the net is driven when it enabled the=0A=
+		 * source itself or found the configuration it would have=0A=
+		 * written.  A profile can drive the net with a configuration=0A=
+		 * of its own; then a PLL the device feeds from the net and=0A=
+		 * holds locked is the evidence that the net carries a signal.=0A=
+		 */=0A=
+		if (sitdev->intsync_src >=3D 0 && !sitdev->intsync_partial)=0A=
+			return false;=0A=
+		return !sit9531x_dpll_intsync_tracked(sitdev);=0A=
+	}=0A=
+=0A=
+	return pin_id < sitdev->info->num_inputs &&=0A=
+	       sit9531x_ref_state_get(sitdev, pin_id)->los;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Is this the reference the PLL is tracking now?  See the S && L && !N=0A=
  * predicate in the pin-state contract.  This is also what gates the=0A=
@@ -334,11 +401,10 @@ sit9531x_dpll_selection_active(struct sit9531x_dev *s=
itdev,=0A=
 =0A=
 	/*=0A=
 	 * Fed to the PLL is not locked to: the device names the source it=0A=
-	 * routes, and a lane that lost its signal is one the PLL is about=0A=
+	 * routes, and a source that lost its signal is one the PLL is about=0A=
 	 * to be moved off, whatever the lock bit still says.=0A=
 	 */=0A=
-	if (pin_id < sitdev->info->num_inputs &&=0A=
-	    sit9531x_ref_state_get(sitdev, pin_id)->los)=0A=
+	if (sit9531x_dpll_selection_no_signal(sitdev, pin_id))=0A=
 		return false;=0A=
 =0A=
 	return true;=0A=
@@ -364,12 +430,17 @@ sit9531x_dpll_selection_operstate_get(struct sit9531x=
_dev *sitdev,=0A=
 		return;=0A=
 	}=0A=
 =0A=
+	/*=0A=
+	 * Standby is a qualified source the PLL is not using.  A net nobody=0A=
+	 * drives is no more that than a lane in LOS is.=0A=
+	 */=0A=
+	if (sit9531x_dpll_selection_no_signal(sitdev, pin_id)) {=0A=
+		*operstate =3D DPLL_PIN_OPERSTATE_NO_SIGNAL;=0A=
+		return;=0A=
+	}=0A=
+=0A=
 	if (pin_id < sitdev->info->num_inputs) {=0A=
 		ref =3D sit9531x_ref_state_get(sitdev, pin_id);=0A=
-		if (ref->los) {=0A=
-			*operstate =3D DPLL_PIN_OPERSTATE_NO_SIGNAL;=0A=
-			return;=0A=
-		}=0A=
 		if (ref->qual_fail) {=0A=
 			*operstate =3D DPLL_PIN_OPERSTATE_QUAL_FAILED;=0A=
 			return;=0A=
@@ -869,8 +940,325 @@ sit9531x_dpll_output_pin_direction_get(const struct d=
pll_pin *pin,=0A=
 				       enum dpll_pin_direction *direction,=0A=
 				       struct netlink_ext_ack *extack);=0A=
 =0A=
+/*=0A=
+ * Does this PLL drive the INTSYNC net with a complete configuration?=0A=
+ * What the source pin reports as CONNECTED.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dpll_intsync_src_connected(const struct sit9531x_dev *sitdev,=0A=
+				    const struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	return sitdev->intsync_src =3D=3D sitdpll->id && !sitdev->intsync_partial=
;=0A=
+}=0A=
+=0A=
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
+	if (sit9531x_dpll_intsync_src_connected(sitdev, sitdpll))=0A=
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
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc =3D 0, detect_rc =3D 0;=0A=
+	bool changed =3D false;=0A=
+	bool was_connected, moved;=0A=
+	u8 hw_src;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	was_connected =3D sit9531x_dpll_intsync_src_connected(sitdev, sitdpll);=
=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		/*=0A=
+		 * A partial configuration on this PLL is not a connection:=0A=
+		 * run the enable again so a retry after a failed one repairs=0A=
+		 * the device instead of reporting success over it.=0A=
+		 */=0A=
+		if (was_connected)=0A=
+			break;=0A=
+		if (sitdev->intsync_src >=3D 0 &&=0A=
+		    sitdev->intsync_src !=3D sitdpll->id) {=0A=
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
+		hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);=0A=
+		if (sit9531x_input_prio_present(sitdev, sitdpll->id, hw_src)) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "PLL selects INTSYNC as a reference; it cannot drive it");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_intsync_enable(sitdev, sitdpll->id);=0A=
+		changed =3D true;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		if (sitdev->intsync_src !=3D sitdpll->id)=0A=
+			break;=0A=
+		rc =3D sit9531x_intsync_disable(sitdev, sitdpll->id);=0A=
+		changed =3D true;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Record what was done before confirming it, and only when this PLL=0A=
+	 * actually changed: the core forwards a request for the state the=0A=
+	 * pin is already in, and a DISCONNECTED on a PLL that never drove the=0A=
+	 * net must not erase the owner.  The refresh below leaves the cache=0A=
+	 * untouched when a read fails, and a cache that wrongly says nobody=0A=
+	 * drives the net would let a second PLL be configured to drive it.=0A=
+	 */=0A=
+	if (changed && !rc) {=0A=
+		sitdev->intsync_src =3D state =3D=3D DPLL_PIN_STATE_CONNECTED ?=0A=
+				      sitdpll->id : -1;=0A=
+		sitdev->intsync_partial =3D false;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Re-scan hardware after a transition so the cache follows a=0A=
+	 * partially failed enable or disable as closely as possible.=0A=
+	 */=0A=
+	if (changed)=0A=
+		detect_rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	/*=0A=
+	 * A failed enable that the scan still finds on this PLL is partial=0A=
+	 * even when every register reads the enable pattern: the small=0A=
+	 * update that commits it may be the step that failed.  Mark it, so=0A=
+	 * a retried connect runs the enable again.=0A=
+	 *=0A=
+	 * When the scan itself failed, nothing says how far the enable and=0A=
+	 * its rollback got, and the net may be driven.  Record this PLL as=0A=
+	 * the partial owner rather than leave the cache saying nobody drives=0A=
+	 * the net, which would let a second PLL be configured on top of it.=0A=
+	 * A disconnect on this PLL runs the disable and a scan that settle=0A=
+	 * the record.=0A=
+	 */=0A=
+	if (changed && rc && state =3D=3D DPLL_PIN_STATE_CONNECTED &&=0A=
+	    (detect_rc || sitdev->intsync_src =3D=3D sitdpll->id)) {=0A=
+		sitdev->intsync_src =3D sitdpll->id;=0A=
+		sitdev->intsync_partial =3D true;=0A=
+	}=0A=
+	/*=0A=
+	 * The refresh only re-reads what the device now shows.  Failing=0A=
+	 * the request because that read hit a bus error would tell=0A=
+	 * userspace the enable did not happen when it did.=0A=
+	 */=0A=
+	if (detect_rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "INTSYNC source cache not refreshed: %d\n",=0A=
+			 detect_rc);=0A=
+=0A=
+	/*=0A=
+	 * What the pin reports may have moved although the request failed:=0A=
+	 * a disable that stopped at its last step leaves nothing driving=0A=
+	 * the net, a failed enable leaves a partial owner.  The core=0A=
+	 * notifies only a request that succeeded and the poll does not=0A=
+	 * watch this pin, so announce it here, as the output setter does.=0A=
+	 */=0A=
+	moved =3D sit9531x_dpll_intsync_src_connected(sitdev, sitdpll) !=3D=0A=
+		was_connected;=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		struct dpll_pin *dpll_pin;=0A=
+=0A=
+		if (rc !=3D -EBUSY && rc !=3D -EINVAL && rc !=3D -EOPNOTSUPP)=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Failed to set INTSYNC source state");=0A=
+		/*=0A=
+		 * The core's lock is held here, as the helper requires.=0A=
+		 * Teardown clears the handle before it unregisters the pin;=0A=
+		 * see the output state setter.=0A=
+		 */=0A=
+		dpll_pin =3D READ_ONCE(dpin->dpll_pin);=0A=
+		if (moved && dpll_pin)=0A=
+			__dpll_pin_change_ntf(dpll_pin);=0A=
+	}=0A=
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
+	if (rc =3D=3D -ENOSPC)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Priority table is full of unique sources on this PLL");=0A=
+	else if (rc && rc !=3D -EINVAL && rc !=3D -EOPNOTSUPP)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC input state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_operstate_on_dpll_get(const struct dpll_pin *pin=
,=0A=
+						void *pin_priv,=0A=
+						const struct dpll_device *dpll,=0A=
+						void *dpll_priv,=0A=
+						enum dpll_pin_operstate *state,=0A=
+						struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_operstate_get(sitdev, sitdpll,=0A=
+					      SIT9531X_INTSYNC_PIN_ID,=0A=
+					      state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
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
+	.operstate_on_dpll_get	=3D=0A=
+		sit9531x_dpll_intsync_dst_operstate_on_dpll_get,=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+};=0A=
+=0A=
 /*=0A=
  * XO (crystal oscillator) pin ops=0A=
  *=0A=
@@ -1197,8 +1585,13 @@ static const struct dpll_pin_ops sit9531x_dpll_outpu=
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
 	/*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 1891679698e2..601dafbb2179 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -312,6 +312,9 @@=0A=
 #define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
 #define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
 =0A=
+/* PLL EXT page INTSYNC configuration registers */=0A=
+#define SIT9531X_PLL_EXT_PAGE(_idx)	(SIT9531X_PAGE_PLLA_EXT + (_idx))=0A=
+=0A=
 #define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)=0A=
 =0A=
 /*=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
