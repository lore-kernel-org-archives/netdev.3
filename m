Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29075632BE;
	Tue, 13 Oct 2026 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931324; cv=fail; b=VDW8fJq8HZ7hfwo8ocXJxGX0vIamUl1VkAmwoOeEzpm6DxXLODewPREuumO2bnM4bRRj0Y+MAwIpyoBlK86b/xXaMiOM9DgPU4AdVqT59CH/QmiKa5B8UqZdqCJnGg7YS1cEkPOA4nHQ3LnCD8zb3FRH84zveZmefT7I7/oLhuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931324; c=relaxed/simple;
	bh=2nZ4oFVdu1vteaFUJ4PYnoD+Ak2JFVxj6nzOm8pagcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XQbkuUEfdjCk+SWWvl6qNQSA2B1/rz8YNN4d7e6Yf4cHmKakW9OixElP1uEpMsTms+cnl7IzB/1uwyGui9w3l/p2NV/cH2g7IYTVXHNnoeQCyy+h4jh7U4/y2nub/P/NtdrWZNaDpSnrQ9451J4GCPPy9ehLWJGxj16OED3k100=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=ikBTEUQj; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=GzwUvxZl; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="ikBTEUQj";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="GzwUvxZl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=5iPjE6eqEyvCECqlfXuY/3MJAjVpFD81sHVKwOhU3No=;
 b=ikBTEUQjEdV4Bnv56unzf9KRXsfojsvsThaSHKqfnJbaUqWVn+yRPgDylks+Z8ZksdOQFiTtFSr8/47VZUXqmyG/qrzbhUI9hgPrzvsQ++AH3+4nA6wWUOS/daXjJ7SCo6OGqFCycpv0ZlpQ0n683YKJjD3hpJcN9qBHihPp8aYa1ONhP0L85epNzoxwpylZieHUOecSlbuRJFoaCFK+tSwFDiGeaxqKapu17hxE4AKlqJGoQ+h2ddRRp/jnWgtpklhR78o52cuVzHi5hgFHdAeQkRWcHVHCOPTBNhBScFQgRaouikkO9nakk791EgyAf/HDGhV1ZgEewrdsgsRg1Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020115.outbound.protection.outlook.com [52.101.61.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B3E15C00090;
	Tue, 13 Oct 2026 22:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdAhbb9WLfXbGTwxbaiLt97txxwJP0e3+cC5X7yuRaKC8UzA9OJY3UcCJpMwhLnIEvFgiD/PAnk87F7yJ1+WNEx2qxcAVjIMLmHXoiJvQez9Rp3DP+rNHMYHg6naV/BAj9ZCOlUpE7Pi8hto1iWu/98IK4gOBbj0vkUEezNUHSmtx6QV0YHdF6svnOHnHJyS6qIjsf26k62+o1jTruU6EEyEP+PT/fCIAfY0CO6tUAYh0QQKHKdeA1sH32sfrNLjQxijJhzI24Vxrsgwi+8k6zKy1R0UoaiPQubW8W9F8sdDX6DI8alOj9b9vYUaRmQ718cm0/ramuXvxcZNFEWg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iPjE6eqEyvCECqlfXuY/3MJAjVpFD81sHVKwOhU3No=;
 b=iU3ih8zuxvT/x1s1T/4S6vAoxZAkjhy/Ud+Z3ju0zGzX3So6+Xs3/357+VtvY4LANve/m2Zw8R2dU/LbR/fB8KXkebnJehmAusmv3PZWg02v5YZjIwwN56WfAYQ4RSYN5GxvR1aexUL92cxnm0+4Tjc7eHNSGrd+7r/GrT1aFlHivYQ50++NSxoN4np9tKnwRdUNqBIud7/82zh5+nv6A9JyTqKxm8jpe36x25K++sXHmMQZBbmzv/gVr6fDGUx5nOf6594Tbf8Acgt00tfAyM7R/Qy2VQu8MVs5LyMQlpZ5dJkIyzqyw7Z0EFdU6s8X3+8uPF7GMjacfaN5cCm0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iPjE6eqEyvCECqlfXuY/3MJAjVpFD81sHVKwOhU3No=;
 b=GzwUvxZlxk98JpmUewCDn2XLH0zRBfuhF5Dsot/7xqUvHde9eXARH/Wib5DYsdBr0IQiEWg1U41lJc36x3Ihx3BmritNPUyAbspuke+ZMZeKc5qGnwW3PjU+bphLvKMp3/Atfh4HBSZHjKuwjKWpySg+CSYSDXrKbU/FZu5sGeHzpnj/e81mQY2JtwpbTtpyIudkxo5y5rrLdO+sso6wPTRv6vDRUbpLYtWN6cW9Xd5TH0vmnUZYdG86+JqJ8UOqvPcSsKkRq1MxJB0wuvAXzsbDisPTXqnfRDtY7riFtVzhhKfpxuYb0cSlE/cSsasGdu/MMIcre+b90ogZvnSVDA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by IA0PR20MB6676.namprd20.prod.outlook.com
 (2603:10b6:208:480::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:41:35 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:41:35 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v13 06/12] dpll: sit9531x: implement input pin state
 on a DPLL
Thread-Topic: [PATCH net-next v13 06/12] dpll: sit9531x: implement input pin
 state on a DPLL
Thread-Index: AQHdW2QAm33U7eP690aeqfMLreLRKA==
Date: Tue, 13 Oct 2026 22:41:35 +0000
Message-ID: <20261013224131.27149-7-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
In-Reply-To: <20261013224131.27149-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|IA0PR20MB6676:EE_
x-ms-office365-filtering-correlation-id: 69ace99b-bf09-4d4c-3621-08df297b231c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|5023799004|261009221227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 I8bUcVX41UAG21afFs6xdEabU0W9pcTwKiK1Hfwqfibe3pudcSZw9S1Jx/IKhsAqpeC6IBzJnl6/SADu5McgxppQwqLisfK130VySzn+MAx3OGHwxkXFFAzHuJfQXA4gsR+6OmquVqFCgt48ri0pV3qjw/773K6XWEHfnSMK7V8AiIGpnxwkvgO7Ctti8JU3WbrI9rjU2IO887jnXozHB8I6Gxq2kwQTQ4751wDSu1L3kdPdBMunWxKSTfrXBdZQueKCUvpop2vieyIy4PER9kltKeB7MqNvvjm3skoi4wYEfWOBCTVIPuSWlpFLxNHvueT6QBdKnY5lyit45vNorN1vBt+3aQHbegTqNPXwmKMYVF+9FKDcyOtgPMar+fgS0IFzeLFc5JGONhCFEHGBHGvKYYgNSo2Gcfq4bQAx2GxpE25x8wxdD3j02XMU2tWFHAwSGl53GCeR7T1/VXXVogrOsvRN5SSh2YWBKxbji4ha0sWpq7K4c+NEaEjuszN+91iXZwYvYWgv0e30FCLYPERN2UDrXllNeiDa2vZ7xTdOx99QnOsRD7lUgOS928DJt3CS82v39+hyzPBPsOEQKngRF5OwomlAmGoZR6eBHMlPO5dOUmDzZy7iKmpihEDvH/SIRhNeFTDMNcpNroAlaFJnzI6gmabJA0TDd5tTzQ05aZAc33WZjUpJVmNjjTfHSyecX56pDXYeLXxVfIHC5w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(5023799004)(261009221227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NC3BeobvT3lnZ/Zocc9g1pdUQpnvvektXnd8PS8XxzP3n03i1QMai0cXWp?=
 =?iso-8859-1?Q?pEYmw9EZqRp5XnA422epDv+muO5FPa5MEMH6mi6/bksVjhbxjJZvlsd6mQ?=
 =?iso-8859-1?Q?uRFtam8yppKPTDZ1orezWgQ4TA6R3Xwu1T3xPbF964OWVdZvqj5WDhYIXW?=
 =?iso-8859-1?Q?DD3zbHzYqvFre8qNdiectOo1807d2dQELg+69j2g5HALHmWov0BLum+xO3?=
 =?iso-8859-1?Q?OHhgfT983/1FuPjEEivgChPI/t2uV92tI1Xv63ppUFMDmYUZ9qbjGaSqCQ?=
 =?iso-8859-1?Q?mUxPSxCiIAhHchLVWmjxb/1CmPkLuZ4S42mu2ecSPPq9kY6Roor5WR28Qx?=
 =?iso-8859-1?Q?NQO/nob0S3HQZaMaztZdTQZN7gNdbOoK01I71uLsX9PmSKe8SuUoQurn2v?=
 =?iso-8859-1?Q?2M0x3CKPW20dqSEHh/7OQ/QlgU2bQ/XS3CYdsEA2wKo3ohEhxLrtH+DbCC?=
 =?iso-8859-1?Q?91dJllMaOvSRBYHgzaiwKLYyCgV5NLtycGJYVRKDZJ7VEKyEb12IWJ2JYt?=
 =?iso-8859-1?Q?4Rt3C2C/Qv1Ea8V8VViAWTskQmFSwypgqE0l598QMOAcTPxybFfDHvajVX?=
 =?iso-8859-1?Q?8aL6VIBNC9ZgebmmlnMqPddhaqtEFyEAxvFQS1iAktxsL//bKct+M1Xgef?=
 =?iso-8859-1?Q?hVOR90LhqXloI0sfC1yEe00WmJIQ/3v5EqqeAh+vpgUr5jYX7fn7Y9eGf9?=
 =?iso-8859-1?Q?pPpQIFPIxXw28ao9GaUZxnYzZN71DWX4L5ct/lMe1ezuIRmznPASn5pdz8?=
 =?iso-8859-1?Q?3QcLipit/hcURysdQB125x/17brAEiPc2l3QBJsxR/6ZY0HCiwJe8o3TB5?=
 =?iso-8859-1?Q?TJCpYscTh4vL0FQWhYD5dSI06IvfQKlIk2XJ9Cpswia0vYVf7AhxGEpfFn?=
 =?iso-8859-1?Q?VHTeTI83smUfciB0m7MTmqJVC2B8TTn6wZHG9AUp0Q08TVLZn5FX3qYkeY?=
 =?iso-8859-1?Q?BSTJHbPhUk7mvach5lW8u/7YFAkfOd+DDr6wEXL3mcebq4DxeYl9Go6+sh?=
 =?iso-8859-1?Q?oQTzU/uxQe28m/1uiuo0XwGyLWzAZDC6c2wKAA/ifDpO3cVd3FbnuenuXD?=
 =?iso-8859-1?Q?gJ3PLyUsrNwpcAye+o94UrvxU+B2Cimya+LWAr76q5ohnQiCfl4tJb2Ego?=
 =?iso-8859-1?Q?KvBA1OL5F0aztsO+FHWpjTS5bZxLWlA4nbqKA2Q0lT3qPe8TZifxLE45SF?=
 =?iso-8859-1?Q?TuYmb1vVlmXQ41IXycehfWkvxFffRPxFN6PTc5gCRY19k8Kxp0WIs+zbrO?=
 =?iso-8859-1?Q?EKftPInD8wzIb/bmtvR7ws/eftLRwwNoi5CAHXqxQD9p6070o1MEqn59xy?=
 =?iso-8859-1?Q?IS3OBTTqjFfBI4pIyXmrFAeYEldREWgNLUCzhZSHBkbohLKo9KZd8U/t/+?=
 =?iso-8859-1?Q?uHEM6DrxYSr322RIK5K/LgyKuL+T4tABu/QR4VwB/FS6MhG1kk9frcyKso?=
 =?iso-8859-1?Q?M4ksWQ3ypariLB6w+eRUTxDS0f2YMYAg/BMAvI5ZKWaVvLdFBAWEYmy2ZM?=
 =?iso-8859-1?Q?5Q02QYyTjE9avh0zqYu3F8jsH2l/+8+j5I+Tpioad9cjERax6tyPg9p57s?=
 =?iso-8859-1?Q?bDFBkh26J/MTjEFyoIgE6Imu6TzOi7BccMvJgqXAQ5aBR6/jV9onb6Mxkc?=
 =?iso-8859-1?Q?AWUMHuqUmGM5Gxd1M6t7qKaksQWT/GXBwRbWnnFtaZvAN//iw5erw4cn2x?=
 =?iso-8859-1?Q?TYLVVFxokJ7hwzG5rzVMvvEEDtgXzbv5gxhtv0M2itrcfOgUII0WtmusXI?=
 =?iso-8859-1?Q?1qG6E5ZTSOUUKi8qK9Ljuq2J3a3GHZMxbzDGe0Zn8FlBYv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	n/0DjXrzqI7SkxKqz/im44/w4hhQy+mzx6yOTBjxxFR3765PFjWbEKCXp6Pot4rKXAjKGSHqqFPCfbpWToSQ/+HyE00nc7cZXCTqspM+B/GBnz8RGNBhaBlJe3JgTViudZGGQcEG6t/fBgWvbXTiZQbl1mxxRYH4D2VRAYNJlu92BnRg+07wb0uWlbIjSGIRif8VAKVcgmsKPWP7Q9/MTb06MTJqFytjcjrhAFbc/4qFUPEwXqSAH8Nyt/qhUBqn2VAc/z8u3TI8p7evBbGcPABQdqxTVIREIPGDQ2oNOA+IpemQixBUqo0/3nlYnU4MEs8NHgJaAUEqEPzl8+by7w==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ace99b-bf09-4d4c-3621-08df297b231c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:41:35.6478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r74IRz8WxkAoIjnXQceRLNtLLl1+vbM11g58+QSeDYwedeCzfZxFgHpeF2sXY6yHX7rvNHliESXhl+HmcqUOPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6676
X-MDID: 1791931299-otA6hSRmD--w
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931299;otA6hSRmD--w;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report and set whether an input takes part in a PLL's reference=0A=
selection.  The device selects its reference itself from a priority=0A=
table, so membership of that table is what the state means here: an input=
=0A=
in the table is selectable, one absent from it is disconnected.  Setting=0A=
the state adds the input to the table or removes it, and membership is=0A=
read back from the device rather than remembered.  CONNECTED would ask=0A=
for this input and no other, which the device cannot be told to do, so it=
=0A=
is refused.  A physical input's receiver is shared by the four PLLs and is=
=0A=
powered down only when the last of them lets go of it.=0A=
=0A=
What the device does with an input is its operational state.  The pin=0A=
reported active is the one the device says it feeds the PLL, read from=0A=
the PLL's debug status bus, while the PLL is locked to it -- outer loop=0A=
running, not frozen -- and its lane has signal.  It is not the active=0A=
selection: that names the source the driver asked for, and when that=0A=
source loses its signal the device falls back to another listed source=0A=
on its own and leaves the selection naming the dead one, so after such a=0A=
failover the pin the PLL moved to reports active and the one it left=0A=
does not.  The status bus names what is fed to the PLL, not what the PLL=0A=
is locked to, so the lane's monitor has to agree.  It is read only while=0A=
the PLL tracks a reference, six transfers per such PLL per tick; in=0A=
free-run the PLL is fed nothing.  The poll reads every lane's clock=0A=
monitor: an input whose monitor reports loss of signal is no-signal, one=0A=
that reports a frequency drift is qual-failed, any other is standby.=0A=
=0A=
The table is built from a priority the driver keeps per source and PLL,=0A=
seeded from the table the device loaded: members in priority order, the=0A=
slots past the last one naming no source.  The four-bit slot encoding=0A=
has two codes for a fifth input pair this part does not have, and one of=0A=
them serves as that.  A disconnected input keeps its priority for when it=
=0A=
comes back, and a table that would come out as the device already holds=0A=
it is not written.=0A=
=0A=
The last register of the table also carries the device's active=0A=
selection.  After a table write the PLL goes to the source it names, and=0A=
leaves it on its own only when that source loses its signal, so every=0A=
write names a source the PLL can use.  When the priorities put a=0A=
different source with signal first, the selection goes to it -- the=0A=
highest-priority valid input, which is how the DPLL interface defines=0A=
automatic mode.  A write that only changes the table below that source=0A=
leaves the selection where it is while it is still listed and has=0A=
signal, so an edit there does not pull a PLL off a healthy reference;=0A=
failing that, it goes to the first listed source that has signal.=0A=
=0A=
Removing the last input is allowed.  The selection then has nothing to=0A=
name, and left as it is it would keep the PLL following its old source=0A=
for as long as that has signal, so the PLL stays in the forced holdover=0A=
the write sequence uses -- the one state in which it follows no input.=0A=
The next write that lists a source releases it.  A holdover the driver=0A=
did not force -- set by the loaded configuration or by a tool -- is left=0A=
in place by such a write; only the hold the driver itself set for an=0A=
empty table is released.=0A=
=0A=
The pins fall into three roles and only the first answers this question,=0A=
so the contract for all of them is written above the operations rather=0A=
than left to be inferred: inputs and the inter-PLL sync destination take=0A=
part in selection; an output and the sync source are driven by the PLL and=
=0A=
report whether they carry a signal; the crystal is fixed and always=0A=
connected, since a PLL cannot be told to stop using it.=0A=
=0A=
Probe also warns about a firmware pin node whose reg names no pin the=0A=
device can have -- a lane or an output the variant lacks, or the N lane=0A=
of a pair the configuration runs differential -- since nodes are looked=0A=
up from the pins and such a node would otherwise be dropped silently.=0A=
=0A=
Rewriting the table means forcing the PLL into holdover, waiting for it to=
=0A=
take, writing every slot and releasing holdover again, all under the=0A=
device lock -- ten to twenty milliseconds.  The device has no way to=0A=
change one slot in isolation, and holdover is what keeps the loop from=0A=
chasing a table that is momentarily inconsistent, so the sequence is the=0A=
cost of doing it correctly.  Its error paths leave the device where the=0A=
request found it: a failed write is rolled back through the register=0A=
that failed, a force that failed is released all the same since the=0A=
write may have landed, the hold stays when the table the device holds=0A=
afterwards lists no source, and the selection is never picked from a=0A=
monitor read that failed.  A release that fails after the table was=0A=
written and latched is owed, and the poll retries it until it lands.=0A=
A hold with no source listed and no valid holdover memory reports the=0A=
PLL unlocked, as the interface asks, rather than in holdover.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Reviewed-by: Ivan Vecera <ivecera@redhat.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 1145 ++++++++++++++++++++++++++++++++--=0A=
 drivers/dpll/sit9531x/core.h |   42 +-=0A=
 drivers/dpll/sit9531x/dpll.c |  320 +++++++++-=0A=
 drivers/dpll/sit9531x/regs.h |   41 ++=0A=
 4 files changed, 1483 insertions(+), 65 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index ffb23a7ff935..1aad598930d7 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -239,6 +239,99 @@ static void sit9531x_input_get_regs(const struct sit95=
31x_dev *sitdev,=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_disable - disable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Sets the force mask bit and clears the state bit for the given=0A=
+ * input, effectively disabling it.  Register selection depends on=0A=
+ * the pair's signal mode (SE/DE) and the lane (P/N); the bit within=0A=
+ * each register addresses the input pair.=0A=
+ *=0A=
+ * Both writes are attempted even when the first fails, and the first=0A=
+ * error is returned.  Neither is rolled back: the force and state bits=0A=
+ * only mean something together, so a transient bus error can leave the=0A=
+ * force bit asserted over a state bit that was never programmed, and the=
=0A=
+ * error is what says the override is not to be trusted.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	unsigned int force_reg, state_reg;=0A=
+	struct sit9531x_ref *ref;=0A=
+	u8 pair, val;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_write_u8(sitdev, force_reg, val | BIT(pair));=0A=
+=0A=
+	ret =3D sit9531x_read_u8(sitdev, state_reg, &val);=0A=
+	if (!ret)=0A=
+		ret =3D sit9531x_write_u8(sitdev, state_reg, val & ~BIT(pair));=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/*=0A=
+	 * Drop the claim even when the pair could not be programmed.  The=0A=
+	 * force bit may be asserted over a state bit that never reached the=0A=
+	 * device, so the receiver cannot be relied on; leaving the cache=0A=
+	 * saying it is on makes the next enable skip itself and report a=0A=
+	 * success the signal does not back.  Clearing the force bit again=0A=
+	 * is harmless, so the worst this costs is one redundant write.=0A=
+	 */=0A=
+	ref->enabled =3D false;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_enable - enable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Clears the force mask bit for the given input, returning it to=0A=
+ * hardware default (enabled).=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	unsigned int force_reg, state_reg;=0A=
+	struct sit9531x_ref *ref;=0A=
+	u8 pair, val;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, force_reg, val & ~BIT(pair));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ref->enabled =3D true;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Output enable / disable (Hi-Z control)=0A=
  *=0A=
@@ -406,7 +499,8 @@ static int sit9531x_output_forced_hiz(struct sit9531x_d=
ev *sitdev,=0A=
  *   1. Force PLL into holdover (PLL page reg 0x6F bit 4)=0A=
  *   2. Write priority slots on Page 1=0A=
  *   3. Small change update (Page 0 reg 0x0F bit 1)=0A=
- *   4. Release holdover=0A=
+ *   4. Release holdover, unless it was forced before step 1 by something=
=0A=
+ *      other than this driver=0A=
  *=0A=
  * Caller must hold sitdev->multiop_lock.=0A=
  */=0A=
@@ -433,26 +527,595 @@ static u8 sit9531x_prio_slot_get(u8 val, u8 slot)=0A=
 	return val >> SIT9531X_PRIO_HI_SHIFT;=0A=
 }=0A=
 =0A=
+/* Place source @src in priority slot @slot of a register value. */=0A=
+static u8 sit9531x_prio_slot_set(u8 val, u8 slot, u8 src)=0A=
+{=0A=
+	if (slot & 1)=0A=
+		return (val & (SIT9531X_PRIO_NIBBLE_MASK <<=0A=
+			       SIT9531X_PRIO_HI_SHIFT)) |=0A=
+		       (src & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+=0A=
+	return (val & SIT9531X_PRIO_NIBBLE_MASK) |=0A=
+	       ((src & SIT9531X_PRIO_NIBBLE_MASK) <<=0A=
+		SIT9531X_PRIO_HI_SHIFT);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Commit a priority-table programming sequence through the Page-0=0A=
+ * programming directive register.=0A=
+ *=0A=
+ * A small change update is all the table needs.  The NVM-bank and=0A=
+ * loop-lock directives that the output system issues do not belong=0A=
+ * here: the former programs non-volatile storage from the efuse and=0A=
+ * the latter only means anything after an escape to the PRG_CMD=0A=
+ * state.  This matches the documented input_priority_sel() procedure.=0A=
+ */=0A=
+static int sit9531x_prio_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(1000, 2000);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_mon_fetch - read the clock monitor status of every lane=
=0A=
+ *=0A=
+ * Four registers carry a nibble per lane.  Loss of signal and frequency=
=0A=
+ * drift are what separate an input the device could lock to from one it=
=0A=
+ * could not, which the priority commit uses to choose the active=0A=
+ * selection and the pins report as their operational state.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock, or run before registration.=0A=
+ */=0A=
+static int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	static const unsigned int regs[] =3D {=0A=
+		SIT9531X_CLKMON_P_STATUS_01, SIT9531X_CLKMON_P_STATUS_23,=0A=
+		SIT9531X_CLKMON_N_STATUS_01, SIT9531X_CLKMON_N_STATUS_23,=0A=
+	};=0A=
+	u8 val[ARRAY_SIZE(regs)], i, pair, nib;=0A=
+	int rc;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(regs); i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, regs[i], &val[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < sitdev->info->num_inputs; i++) {=0A=
+		struct sit9531x_ref *ref =3D &sitdev->ref[i];=0A=
+=0A=
+		/* Lane 2k is INkP, 2k + 1 INkN; a register holds two pairs. */=0A=
+		pair =3D sit9531x_input_pair(i);=0A=
+		nib =3D val[(sit9531x_input_is_n(i) ? 2 : 0) + pair / 2];=0A=
+		nib =3D (pair & 1) ? nib >> 4 : nib & 0x0F;=0A=
+=0A=
+		ref->los =3D !!(nib & SIT9531X_CLKMON_LOSS);=0A=
+		ref->qual_fail =3D !ref->los &&=0A=
+				 !!(nib & (SIT9531X_CLKMON_FINE_DRIFT |=0A=
+					   SIT9531X_CLKMON_COARSE_DRIFT));=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Can the device lock to this source now?  Only the input lanes have a=0A=
+ * monitor; the on-chip oscillator and the inter-PLL net are taken as=0A=
+ * present.  A differential pair is watched through its P lane, which is=
=0A=
+ * the one its table entries are canonicalised to.=0A=
+ */=0A=
+static bool sit9531x_prio_src_live(const struct sit9531x_dev *sitdev, u8 s=
rc)=0A=
+{=0A=
+	u8 index =3D sit9531x_hw_src_input(src);=0A=
+=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return true;=0A=
+=0A=
+	return !sitdev->ref[index].los;=0A=
+}=0A=
+=0A=
 /*=0A=
- * Rebuild a PLL's membership mask from the source codes of its priority=
=0A=
- * table.  The mask is what the pin state getters test, so it is refreshed=
=0A=
- * from exactly the values the table holds -- here after a write, and once=
=0A=
- * per poll from the read-back in sit9531x_chan_state_fetch().=0A=
+ * Fold a source code to the lane a DPLL pin actually represents.=0A=
+ *=0A=
+ * Differential input pairs expose only the P lane as a DPLL pin.  A=0A=
+ * priority table entry encoded as an N lane for such a pair must map to=
=0A=
+ * the P-lane source for pin-facing operations (membership, priority slots=
,=0A=
+ * add/remove/set lookups), matching sit9531x_ref_pll_mask_fetch().=0A=
+ */=0A=
+static u8 sit9531x_prio_src_canon(const struct sit9531x_dev *sitdev, u8 sr=
c)=0A=
+{=0A=
+	u8 index =3D sit9531x_hw_src_input(src);=0A=
+=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return src;=0A=
+=0A=
+	if (sit9531x_input_is_n(index) &&=0A=
+	    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		return sit9531x_input_hw_src(index - 1);=0A=
+=0A=
+	return src;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_present - is a source listed in a PLL's priority ta=
ble=0A=
+ * @input_idx:	input source in hardware encoding (see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ *=0A=
+ * Answers from the membership mask that every table write and every poll=
=0A=
+ * refreshes, which is what the pin state getters test.  The priority slot=
=0A=
+ * cannot answer this: a source that is not in the table reports the lowes=
t=0A=
+ * slot, so the slot value alone does not separate absent from last.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				 u8 input_idx)=0A=
+{=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return false;=0A=
+=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return false;=0A=
+=0A=
+	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Take the configured priorities from a table the hardware holds: each=0A=
+ * listed source gets the first slot it occupies.  A source the table does=
=0A=
+ * not list keeps whatever it had, so a disconnected input comes back with=
=0A=
+ * its old priority.=0A=
+ */=0A=
+static void sit9531x_prio_cfg_seed(struct sit9531x_dev *sitdev, u8 pll_idx=
,=0A=
+				   const u8 *srcs)=0A=
+{=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u16 seeded =3D 0;=0A=
+	u8 slot, src;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		if (!sit9531x_prio_src_usable(src))=0A=
+			continue;=0A=
+		src =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (seeded & BIT(src))=0A=
+			continue;=0A=
+		seeded |=3D BIT(src);=0A=
+		chan->cfg_prio[src] =3D slot;=0A=
+		chan->cfg_known |=3D BIT(src);=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * A source this PLL has never listed gets the lowest slot, the value=0A=
+	 * it reports and the one it is connected at, so its priority does not=0A=
+	 * change when its state does.=0A=
+	 */=0A=
+	for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++) {=0A=
+		if (chan->cfg_known & BIT(src))=0A=
+			continue;=0A=
+		chan->cfg_prio[src] =3D SIT9531X_PRIO_MAX_SLOTS - 1;=0A=
+		chan->cfg_known |=3D BIT(src);=0A=
+	}=0A=
+=0A=
+	memcpy(chan->seen_srcs, srcs, sizeof(chan->seen_srcs));=0A=
+	chan->seen_valid =3D true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Build the table for a set of member sources: ordered by configured=0A=
+ * priority, ties kept in the order the hardware table has them, the slots=
=0A=
+ * past the last member naming no source.  Filling them with the code for=
=0A=
+ * no source rather than with copies of the last member keeps every=0A=
+ * source in exactly one slot, so the order the table encodes is the=0A=
+ * order the priorities say.=0A=
+ */=0A=
+static void sit9531x_prio_table_build(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
+				      u16 members, u8 *srcs)=0A=
+{=0A=
+	const struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 order[SIT9531X_PRIO_NUM_SRC], n =3D 0, i, j, src;=0A=
+=0A=
+	for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++)=0A=
+		if (members & BIT(src))=0A=
+			order[n++] =3D src;=0A=
+=0A=
+	/* Insertion sort: at most a dozen entries. */=0A=
+	for (i =3D 1; i < n; i++) {=0A=
+		u8 cur =3D order[i];=0A=
+=0A=
+		for (j =3D i; j > 0; j--) {=0A=
+			u8 prev =3D order[j - 1];=0A=
+			u16 kc, kp;=0A=
+=0A=
+			kc =3D (chan->cfg_known & BIT(cur)) ?=0A=
+			     chan->cfg_prio[cur] : U8_MAX;=0A=
+			kp =3D (chan->cfg_known & BIT(prev)) ?=0A=
+			     chan->cfg_prio[prev] : U8_MAX;=0A=
+			if (kc =3D=3D kp) {=0A=
+				/* Keep the hardware order among equals. */=0A=
+				kc =3D chan->prio_last[cur] ?: U8_MAX;=0A=
+				kp =3D chan->prio_last[prev] ?: U8_MAX;=0A=
+			}=0A=
+			if (kp <=3D kc)=0A=
+				break;=0A=
+			order[j] =3D prev;=0A=
+		}=0A=
+		order[j] =3D cur;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_PRIO_MAX_SLOTS; i++)=0A=
+		srcs[i] =3D i < n ? order[i] : SIT9531X_PRIO_SRC_NONE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Refresh a PLL's cached view of its priority table from the source codes=
=0A=
+ * the table holds -- here after a write, and once per poll from the=0A=
+ * read-back in sit9531x_chan_state_fetch().=0A=
+ *=0A=
+ * The membership mask is what the pin state getters test, the per-slot=0A=
+ * copy is what a rewrite compares against, and the first-slot array=0A=
+ * orders sources of equal priority, so none of them costs a register read=
=0A=
+ * per pin.=0A=
  */=0A=
 static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
 				     const u8 *srcs)=0A=
 {=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 first[SIT9531X_PRIO_NUM_SRC] =3D { 0 };=0A=
+	u8 slot, src, src_canon;=0A=
 	u16 mask =3D 0;=0A=
-	u8 slot;=0A=
 =0A=
 	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
-		u8 src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		src =3D srcs[slot];=0A=
+		src &=3D SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		chan->prio_srcs[slot] =3D src;=0A=
+		src_canon =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (!sit9531x_prio_src_usable(src))=0A=
+			continue;=0A=
+=0A=
+		mask |=3D BIT(src_canon);=0A=
+		if (!first[src_canon])=0A=
+			first[src_canon] =3D slot + 1;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Assign unconditionally: a source that has left the table has no=0A=
+	 * slot, and leaving its old one behind would keep reporting it as=0A=
+	 * listed for as long as the device runs.=0A=
+	 */=0A=
+	for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++)=0A=
+		chan->prio_last[src] =3D first[src];=0A=
+=0A=
+	chan->prio_mask =3D mask;=0A=
+}=0A=
+=0A=
+/* Attempts to release a forced holdover before reporting it stuck. */=0A=
+#define SIT9531X_HO_CLEAR_TRIES		3=0A=
+=0A=
+static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
+				    u8 *srcs);=0A=
+=0A=
+/*=0A=
+ * First source in a table that the device could lock to now, compared as=
=0A=
+ * canonical codes, or SIT9531X_PRIO_SRC_NONE when no listed source has a=
=0A=
+ * signal.=0A=
+ */=0A=
+static u8 sit9531x_prio_top_live(const struct sit9531x_dev *sitdev,=0A=
+				 const u8 *srcs)=0A=
+{=0A=
+	u8 i, src;=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_PRIO_MAX_SLOTS; i++) {=0A=
+		src =3D srcs[i] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		src =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (sit9531x_prio_src_usable(src) &&=0A=
+		    sit9531x_prio_src_live(sitdev, src))=0A=
+			return src;=0A=
+	}=0A=
+=0A=
+	return SIT9531X_PRIO_SRC_NONE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Choose the active selection for a table about to be latched.  After a=
=0A=
+ * table write the PLL goes to the source the selection names; it moves to=
=0A=
+ * another on its own only when that source loses its signal, which is an=
=0A=
+ * event, not a state.  So the selection has to name a source the PLL can=
=0A=
+ * use, and it follows the priorities the way the DPLL interface defines=
=0A=
+ * automatic mode -- the highest-priority valid input:=0A=
+ *=0A=
+ * - When the highest-priority source with signal is not the one the=0A=
+ *   table held before, the priorities now put another source first, and=
=0A=
+ *   the selection goes to it.=0A=
+ * - Otherwise the write only reorders sources below it, or removes one=0A=
+ *   the PLL is not on, and the selection stays where it is while that=0A=
+ *   source is still listed and has signal: a change further down the=0A=
+ *   table must not pull a PLL off a healthy reference.=0A=
+ * - Otherwise the first listed source with signal; with none alive the=0A=
+ *   first listed one is as good as any.=0A=
+ *=0A=
+ * A selection that is still listed but has lost its signal is moved too.=
=0A=
+ * The PLL has then fallen back on its own and the selection still names=
=0A=
+ * the dead source; left alone, the next table write sends the PLL back to=
=0A=
+ * it and it unlocks.  The device falls back to the best listed source=0A=
+ * that has signal, which is the one chosen here, so moving the selection=
=0A=
+ * there does not move the PLL.=0A=
+ *=0A=
+ * @old is the table the device holds before this write.=0A=
+ */=0A=
+static u8 sit9531x_prio_activesel_pick(struct sit9531x_dev *sitdev,=0A=
+				       const u8 *old, const u8 *srcs, u8 cur)=0A=
+{=0A=
+	u8 top, i;=0A=
+=0A=
+	top =3D sit9531x_prio_top_live(sitdev, srcs);=0A=
+	if (top !=3D SIT9531X_PRIO_SRC_NONE &&=0A=
+	    top !=3D sit9531x_prio_top_live(sitdev, old))=0A=
+		return top;=0A=
+=0A=
+	/*=0A=
+	 * The table is built from canonical codes, so compare in the same=0A=
+	 * terms: a differential pair selected through its N-lane code is the=0A=
+	 * P-lane entry.=0A=
+	 */=0A=
+	cur =3D sit9531x_prio_src_canon(sitdev, cur & SIT9531X_PRIO_NIBBLE_MASK);=
=0A=
+=0A=
+	if (sit9531x_prio_src_usable(cur) &&=0A=
+	    sit9531x_prio_src_live(sitdev, cur))=0A=
+		for (i =3D 0; i < SIT9531X_PRIO_MAX_SLOTS; i++)=0A=
+			if (srcs[i] =3D=3D cur)=0A=
+				return cur;=0A=
+=0A=
+	if (top !=3D SIT9531X_PRIO_SRC_NONE)=0A=
+		return top;=0A=
+=0A=
+	return srcs[0];=0A=
+}=0A=
+=0A=
+static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
+				      const u8 *srcs)=0A=
+{=0A=
+	u8 val, last_old, slot, attempt, written =3D 0, restored =3D 0;=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 now[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	int rc =3D 0, prg_rc, ho_rc =3D 0;=0A=
+	bool empty, ho_foreign;=0A=
+	u16 reg;=0A=
+=0A=
+	empty =3D !sit9531x_prio_src_usable(srcs[0]);=0A=
+=0A=
+	/*=0A=
+	 * A forced holdover already in place is this driver's own when the=0A=
+	 * table lists nothing -- the hold an empty table keeps -- or when a=0A=
+	 * release is still owed from an earlier write.  Any other was put=0A=
+	 * there by the loaded configuration or by a tool, and a table write=0A=
+	 * is no reason to lift it: the sequence runs under it and leaves it=0A=
+	 * as found.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,=0A=
+				  &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ho_foreign =3D (val & BIT(SIT9531X_PLL_HO_FORCE_BIT)) &&=0A=
+		     chan->prio_mask && !chan->ho_release_pending;=0A=
+=0A=
+	/*=0A=
+	 * A write that reports an error may still have reached the part, so=0A=
+	 * a failure here does not prove the bit stayed clear: nothing is=0A=
+	 * written to the table, but the release below still runs.=0A=
+	 */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,=
=0A=
+				   val | BIT(SIT9531X_PLL_HO_FORCE_BIT));=0A=
+	if (rc)=0A=
+		goto release;=0A=
+=0A=
+	usleep_range(10000, 12000);=0A=
+=0A=
+	/*=0A=
+	 * Two slots share a register, and this writes every slot, so both=0A=
+	 * nibbles are known for every register but the last -- build those=0A=
+	 * bytes outright.  Reading first would raise the question of what a=0A=
+	 * read returns between the write and the latch, and the answer does=0A=
+	 * not matter if nothing is read.=0A=
+	 */=0A=
+	for (slot =3D 0; slot + 1 < SIT9531X_PRIO_MAX_SLOTS; slot +=3D 2) {=0A=
+		reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+		val =3D sit9531x_prio_slot_set(0, slot, srcs[slot]);=0A=
+		val =3D sit9531x_prio_slot_set(val, slot + 1, srcs[slot + 1]);=0A=
+=0A=
+		/*=0A=
+		 * Counted before the write: a write that reports an error=0A=
+		 * may still have reached the part, so the rollback has to=0A=
+		 * cover that register too.=0A=
+		 */=0A=
+		written =3D slot + 2;=0A=
+		rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The last register carries slot 10 in its high nibble and the=0A=
+	 * device's active selection in its low one; see=0A=
+	 * sit9531x_prio_activesel_pick() for how the selection is chosen.=0A=
+	 * It needs the signal state now, not as of the last poll.=0A=
+	 *=0A=
+	 * The slot setter picks its nibble by parity, so the selection is=0A=
+	 * addressed as the slot past the last one.  This register has not=0A=
+	 * been written yet in this sequence, so the read returns what the=0A=
+	 * device is running with, and that byte is what a rollback puts=0A=
+	 * back.=0A=
+	 *=0A=
+	 * A table naming no source at all is what removing the last one=0A=
+	 * asks for.  There is nothing to point the selection at -- the code=0A=
+	 * for no source is not one the selection takes -- so the nibble is=0A=
+	 * left alone and the PLL is kept in holdover below instead.=0A=
+	 */=0A=
+	reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &last_old);=0A=
+	if (rc)=0A=
+		goto rollback;=0A=
+=0A=
+	val =3D sit9531x_prio_slot_set(last_old, slot, srcs[slot]);=0A=
+=0A=
+	if (!empty) {=0A=
+		u8 sel =3D sit9531x_prio_slot_get(val, slot + 1);=0A=
+=0A=
+		/*=0A=
+		 * Without a fresh read the pick would run on the last=0A=
+		 * poll's monitor state, up to a poll period old.  A source=0A=
+		 * that lost its signal since would still look live, and a=0A=
+		 * selection naming a dead source sends the PLL to it and it=0A=
+		 * unlocks, so no selection is written without the read: the=0A=
+		 * slots written so far are rolled back and the request=0A=
+		 * fails.=0A=
+		 */=0A=
+		rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+		sel =3D sit9531x_prio_activesel_pick(sitdev, chan->prio_srcs,=0A=
+						   srcs, sel);=0A=
+		val =3D sit9531x_prio_slot_set(val, slot + 1, sel);=0A=
+	}=0A=
+=0A=
+	written =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
+	rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+	if (rc)=0A=
+		goto rollback;=0A=
+=0A=
+rollback:=0A=
+	if (rc && written) {=0A=
+		/*=0A=
+		 * Put the slots that may have reached the device back the=0A=
+		 * way they were, the register whose write reported the error=0A=
+		 * included.  Latching a table that is neither the previous=0A=
+		 * order nor the requested one hands the reference selection=0A=
+		 * loop a priority list nobody asked for.  The cache is the=0A=
+		 * table as last read, which is what those slots held; the=0A=
+		 * last register also carries the selection, so it goes back=0A=
+		 * as it was read above.=0A=
+		 */=0A=
+		for (slot =3D 0; slot < written; slot +=3D 2) {=0A=
+			const u8 *prev =3D &chan->prio_srcs[slot];=0A=
+			u8 old;=0A=
+=0A=
+			if (slot + 1 < SIT9531X_PRIO_MAX_SLOTS) {=0A=
+				old =3D sit9531x_prio_slot_set(0, slot, prev[0]);=0A=
+				old =3D sit9531x_prio_slot_set(old, slot + 1,=0A=
+							     prev[1]);=0A=
+			} else {=0A=
+				old =3D last_old;=0A=
+			}=0A=
+			if (sit9531x_write_u8(sitdev,=0A=
+					      sit9531x_prio_reg(pll_idx, slot),=0A=
+					      old))=0A=
+				break;=0A=
 =0A=
-		if (sit9531x_prio_src_usable(src))=0A=
-			mask |=3D BIT(src);=0A=
+			restored =3D slot + 2;=0A=
+		}=0A=
+		written =3D restored;=0A=
 	}=0A=
 =0A=
-	sitdev->chan[pll_idx].prio_mask =3D mask;=0A=
+	/*=0A=
+	 * Latch unconditionally: the slots that reached the device are in=0A=
+	 * the table regardless, so the latch keeps hardware and the cache=0A=
+	 * refresh below consistent with what was actually written.=0A=
+	 */=0A=
+	prg_rc =3D sit9531x_prio_prg_commit(sitdev);=0A=
+	if (prg_rc && !rc)=0A=
+		rc =3D prg_rc;=0A=
+=0A=
+	/*=0A=
+	 * Refresh the cache so a get that follows a set does not have to=0A=
+	 * wait for the next poll.  After a complete write that is the table=0A=
+	 * just written.  After a failure it is whatever the device holds=0A=
+	 * now -- part request, part restore -- so read it back rather than=0A=
+	 * piece it together: the membership test decides what a failed=0A=
+	 * request rolls back, and it must not answer for writes that did not=0A=
+	 * land.  A read-back that fails too leaves the next poll to do it.=0A=
+	 */=0A=
+	if (!rc) {=0A=
+		sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
+		memcpy(chan->seen_srcs, srcs, sizeof(chan->seen_srcs));=0A=
+		chan->seen_valid =3D true;=0A=
+	} else if (!sit9531x_prio_table_read(sitdev, pll_idx, now)) {=0A=
+		sit9531x_prio_mask_build(sitdev, pll_idx, now);=0A=
+		memcpy(chan->seen_srcs, now, sizeof(chan->seen_srcs));=0A=
+		chan->seen_valid =3D true;=0A=
+	}=0A=
+=0A=
+release:=0A=
+	/*=0A=
+	 * A table that names no source keeps the PLL in the holdover forced=0A=
+	 * above: that is the one state in which it follows no input, which=0A=
+	 * is what disconnecting every input asks for.  The selection nibble=0A=
+	 * alone would not do it -- it still names the old source, and the=0A=
+	 * PLL keeps following that one for as long as it has signal.  The=0A=
+	 * next table write that lists a source releases it.=0A=
+	 *=0A=
+	 * Judged on the table the device holds now, as the refresh above=0A=
+	 * read it, not on the one requested: a write that failed on a PLL=0A=
+	 * listing nothing leaves it listing nothing, and releasing the hold=0A=
+	 * then would hand the PLL back to the source the selection still=0A=
+	 * names while every pin reports disconnected.  An empty table whose=0A=
+	 * latch failed is the same case from the other side.=0A=
+	 */=0A=
+	if (!chan->prio_mask) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"PLL%c: no source listed, holdover kept\n",=0A=
+			'A' + pll_idx);=0A=
+		chan->ho_release_pending =3D false;=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	if (ho_foreign) {=0A=
+		dev_dbg(sitdev->dev,=0A=
+			"PLL%c: holdover was forced before the write, left in place\n",=0A=
+			'A' + pll_idx);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Release the forced holdover.  Apart from an empty table, nothing=0A=
+	 * in the driver keeps this bit set, and a retry of the same request=0A=
+	 * finds the table already as asked and does not come back here, so=0A=
+	 * a PLL left with it would report holdover until some unrelated=0A=
+	 * table write on the same PLL cleared it.  Retry before giving up;=0A=
+	 * if it stays set, say so and leave the release owed to the poll,=0A=
+	 * which retries it every tick until it lands.=0A=
+	 */=0A=
+	for (attempt =3D 0; attempt < SIT9531X_HO_CLEAR_TRIES; attempt++) {=0A=
+		ho_rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+					       SIT9531X_PLL_REG_HO_CTRL,=0A=
+					       BIT(SIT9531X_PLL_HO_FORCE_BIT),=0A=
+					       0);=0A=
+		if (!ho_rc)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (ho_rc) {=0A=
+		dev_err(sitdev->dev, "PLL%c left in forced holdover: %d\n",=0A=
+			'A' + pll_idx, ho_rc);=0A=
+		if (!rc)=0A=
+			rc =3D ho_rc;=0A=
+	}=0A=
+	chan->ho_release_pending =3D !!ho_rc;=0A=
+=0A=
+	return rc;=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -479,6 +1142,155 @@ static int sit9531x_prio_table_read(struct sit9531x_=
dev *sitdev, u8 pll_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Rewrite a PLL's table for a new member set, unless it would come out as=
=0A=
+ * the table already holds: every write forces the PLL into holdover for=
=0A=
+ * the length of the sequence, so one that changes nothing is a=0A=
+ * disturbance nobody asked for.=0A=
+ */=0A=
+static int sit9531x_prio_table_apply(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
+				     u16 members)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+=0A=
+	if (hweight16(members) > SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -ENOSPC;=0A=
+=0A=
+	sit9531x_prio_table_build(sitdev, pll_idx, members, srcs);=0A=
+	if (!memcmp(srcs, sitdev->chan[pll_idx].prio_srcs, sizeof(srcs)))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_set - set an input's priority on a PLL=0A=
+ * @input_idx:	input source in hardware encoding (0-11, see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	priority, lower is preferred=0A=
+ *=0A=
+ * Records the priority and, when the source is in the PLL's table,=0A=
+ * rebuilds the table from the configured priorities.  A source that is=0A=
+ * not in the table keeps the priority for when it is connected: that is=
=0A=
+ * the pin's state, and it belongs to the state setter.  Other sources=0A=
+ * keep theirs either way, so no sibling's priority moves.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -EINVAL for a bad PLL or source, <0 on error=0A=
+ */=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio)=0A=
+{=0A=
+	struct sit9531x_chan *chan;=0A=
+	u16 old_known;=0A=
+	u8 old_prio;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	old_prio =3D chan->cfg_prio[input_idx];=0A=
+	old_known =3D chan->cfg_known;=0A=
+	chan->cfg_prio[input_idx] =3D prio;=0A=
+	chan->cfg_known |=3D BIT(input_idx);=0A=
+=0A=
+	if (!(chan->prio_mask & BIT(input_idx)))=0A=
+		return 0;=0A=
+=0A=
+	/*=0A=
+	 * The table is built from the configured priority, so it has to be=0A=
+	 * recorded before the rebuild; a rebuild that failed takes the=0A=
+	 * record back with it.  Left in place, a refused priority would be=0A=
+	 * reported by the getter, notified by the poll, and written by the=0A=
+	 * next rebuild for any other reason.=0A=
+	 */=0A=
+	rc =3D sit9531x_prio_table_apply(sitdev, pll_idx, chan->prio_mask);=0A=
+	if (rc) {=0A=
+		chan->cfg_prio[input_idx] =3D old_prio;=0A=
+		chan->cfg_known =3D old_known;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_remove - drop an input from a PLL's priority table=
=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Rebuilds the table without the source, which makes a disconnected=0A=
+ * input ineligible for automatic reference selection, not just gated at=
=0A=
+ * the input buffer.  The source keeps its configured priority for when it=
=0A=
+ * comes back.  Removing a source that is absent succeeds without touching=
=0A=
+ * the table.  Removing the last one leaves a table that names no source;=
=0A=
+ * the commit then keeps the PLL in holdover, which is what disconnecting=
=0A=
+ * every input asks for.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx)=0A=
+{=0A=
+	struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	if (!(chan->prio_mask & BIT(input_idx)))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_apply(sitdev, pll_idx,=0A=
+					 chan->prio_mask & ~BIT(input_idx));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_add - make an input eligible in a PLL's table=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Puts the source back into the table at its configured priority; one the=
=0A=
+ * PLL never listed has the lowest slot (see sit9531x_prio_cfg_seed()).  A=
=0A=
+ * source that is already listed leaves the table untouched.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENOSPC when the table cannot hold another=0A=
+ * source, <0 on error=0A=
+ */=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx)=0A=
+{=0A=
+	struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	if (chan->prio_mask & BIT(input_idx))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_apply(sitdev, pll_idx,=0A=
+					 chan->prio_mask | BIT(input_idx));=0A=
+}=0A=
+=0A=
 /* XO doubler register */=0A=
 #define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
 #define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
@@ -569,7 +1381,8 @@ static int sit9531x_clear_notifications(struct sit9531=
x_dev *sitdev)=0A=
  * @index:	logical input index=0A=
  *=0A=
  * Reads whether the lane's receiver is on, from the Page 0x02 force and=
=0A=
- * state bits.=0A=
+ * state bits.  Signal status comes from sit9531x_input_mon_fetch(),=0A=
+ * which reads every lane's clock monitor in one pass.=0A=
  */=0A=
 static int sit9531x_ref_state_fetch(struct sit9531x_dev *sitdev, u8 index)=
=0A=
 {=0A=
@@ -661,6 +1474,73 @@ static int sit9531x_pll_is_active(struct sit9531x_dev=
 *sitdev, u8 pll_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Read the reference the device feeds a PLL.=0A=
+ *=0A=
+ * The active selection names the source the PLL was told to follow.  The=
=0A=
+ * input subsystem feeds the PLL that source while it has signal and falls=
=0A=
+ * back to another listed source on its own when it does not, without=0A=
+ * touching the selection, so after such a fallback the selection no=0A=
+ * longer says which reference the PLL runs on.  The debug status bus=0A=
+ * does: addressed at the routed reference, it returns the source code=0A=
+ * the input subsystem currently feeds the PLL.=0A=
+ *=0A=
+ * This names the source and nothing more.  Whether the PLL is locked to=
=0A=
+ * it is read from the outer-loop lock and the lane's clock monitor; in=0A=
+ * free-run the PLL is fed nothing and the bus is not consulted, so the=0A=
+ * caller checks the mode first.=0A=
+ *=0A=
+ * @ref is the logical input index, SIT9531X_INTSYNC_PIN_ID for the=0A=
+ * inter-PLL sync net, or SIT9531X_REF_INVALID when the code names no=0A=
+ * registered input.  Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev,=0A=
+					 u8 pll_idx, u8 *ref)=0A=
+{=0A=
+	int rc, lock_rc;=0A=
+	u8 v, i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_STATUS_ADDR,=0A=
+				   SIT9531X_DBG_STATUS_ROUTED_SRC);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/* The first reads return earlier latches; the last is current. */=0A=
+	for (i =3D 0; i < SIT9531X_DBG_STATUS_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_STATUS_DATA,=0A=
+					  &v);=0A=
+		if (rc)=0A=
+			goto relock;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Canonicalise like the table entries: a differential pair fed=0A=
+	 * through its N-lane code is the P-lane pin.=0A=
+	 */=0A=
+	v =3D sit9531x_prio_src_canon(sitdev, v & SIT9531X_DBG_ROUTED_SRC_MASK);=
=0A=
+	*ref =3D sit9531x_hw_src_input(v);=0A=
+=0A=
+relock:=0A=
+	/*=0A=
+	 * Lock the debug registers again.  A read that failed is reported=0A=
+	 * ahead of a lock that did; a lock that failed on its own leaves the=0A=
+	 * page open to a stray write and is reported too.=0A=
+	 */=0A=
+	lock_rc =3D sit9531x_write_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_DEBUG=
,=0A=
+					SIT9531X_PLL_DEBUG_LOCK);=0A=
+=0A=
+	return rc ? rc : lock_rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_chan_state_fetch - read PLL channel status from hardware=0A=
  *=0A=
@@ -669,11 +1549,11 @@ static int sit9531x_pll_is_active(struct sit9531x_de=
v *sitdev, u8 pll_idx,=0A=
  */=0A=
 static int sit9531x_chan_state_fetch(struct sit9531x_dev *sitdev, u8 pll_i=
dx)=0A=
 {=0A=
-	u8 status, outer_lol, input_sel, inner_lol, ho_freeze, activesel_reg;=0A=
+	u8 status, outer_lol, inner_lol, ho_freeze, pll_status_1;=0A=
 	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
 	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
-	u8 pll_status_1;=0A=
-	bool active;=0A=
+	u8 routed =3D SIT9531X_REF_INVALID;=0A=
+	bool active, tracking;=0A=
 	int rc;=0A=
 =0A=
 	/*=0A=
@@ -696,22 +1576,6 @@ static int sit9531x_chan_state_fetch(struct sit9531x_=
dev *sitdev, u8 pll_idx)=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
-	/*=0A=
-	 * Read the input source the PLL has currently selected as its=0A=
-	 * active reference.  This lives in the low nibble of the last=0A=
-	 * register of the PLL's page-1 priority block (CLK_ACTIVESEL_PLL),=0A=
-	 * not on the PLL page -- PLL-page 0x29 is a config register.=0A=
-	 */=0A=
-	activesel_reg =3D SIT9531X_PRIO_BASE_REG +=0A=
-			SIT9531X_PRIO_REGS_PER_PLL * pll_idx +=0A=
-			SIT9531X_PRIO_ACTIVESEL_OFF;=0A=
-	rc =3D sit9531x_read_u8(sitdev,=0A=
-			      SIT9531X_REG(SIT9531X_PAGE_PRIOSYS,=0A=
-					   activesel_reg),=0A=
-			      &input_sel);=0A=
-	if (rc)=0A=
-		return rc;=0A=
-=0A=
 	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_STATUS,=0A=
 			      &inner_lol);=0A=
 	if (rc)=0A=
@@ -722,6 +1586,21 @@ static int sit9531x_chan_state_fetch(struct sit9531x_=
dev *sitdev, u8 pll_idx)=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
+	/*=0A=
+	 * The reference the device feeds the PLL, read only while the PLL=0A=
+	 * tracks one -- running, locked, outer loop on, not frozen -- which=0A=
+	 * is the only case the pin state reports it.  In free-run the PLL=0A=
+	 * is fed nothing and the status bus is not consulted.=0A=
+	 */=0A=
+	tracking =3D active && !(outer_lol & BIT(pll_idx)) &&=0A=
+		   !(status & SIT9531X_PLL_STATUS_OUTER_DIS) &&=0A=
+		   !(ho_freeze & BIT(pll_idx));=0A=
+	if (tracking) {=0A=
+		rc =3D sit9531x_chan_routed_ref_read(sitdev, pll_idx, &routed);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
 	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_STATUS_1,=
=0A=
 				  &pll_status_1);=0A=
 	if (rc)=0A=
@@ -739,12 +1618,21 @@ static int sit9531x_chan_state_fetch(struct sit9531x=
_dev *sitdev, u8 pll_idx)=0A=
 =0A=
 	sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
 =0A=
+	/*=0A=
+	 * The configured priorities come from the table the first time it=0A=
+	 * is read, and again whenever it no longer matches what the driver=0A=
+	 * last wrote: something else -- a profile reload, a direct I2C=0A=
+	 * tool -- rewrote it, and that table is now the configuration.=0A=
+	 */=0A=
+	if (!chan->seen_valid ||=0A=
+	    memcmp(srcs, chan->seen_srcs, sizeof(chan->seen_srcs)))=0A=
+		sit9531x_prio_cfg_seed(sitdev, pll_idx, srcs);=0A=
+=0A=
 	/* STATUS_1_GENERIC reports loss of lock, so invert it. */=0A=
 	chan->active =3D active;=0A=
 	chan->locked =3D active && !(outer_lol & BIT(pll_idx));=0A=
 	chan->mode =3D !!(status & SIT9531X_PLL_STATUS_OUTER_DIS);=0A=
-	chan->selected_ref =3D=0A=
-		sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+	chan->routed_ref =3D routed;=0A=
 	chan->inner_lol =3D !!(inner_lol & BIT(pll_idx));=0A=
 	chan->ho_freeze =3D !!(ho_freeze & BIT(pll_idx));=0A=
 	chan->ho_valid =3D !!(pll_status_1 & SIT9531X_PLL_STATUS_1_HO_VALID);=0A=
@@ -913,6 +1801,13 @@ static int sit9531x_dev_state_fetch(struct sit9531x_d=
ev *sitdev)=0A=
 		}=0A=
 	}=0A=
 =0A=
+	rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to read the input clock monitors: %d\n", rc);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
 	/*=0A=
 	 * The priority-table read walks the Page-1 registers, so it runs=0A=
 	 * with multiop_lock held like every other multi-register sequence.=0A=
@@ -945,14 +1840,22 @@ static int sit9531x_dev_state_fetch(struct sit9531x_=
dev *sitdev)=0A=
 		}=0A=
 	}=0A=
 =0A=
+	/*=0A=
+	 * The channel fetch walks the priority table and the debug status=0A=
+	 * bus, multi-register sequences that expect the lock; nothing races=0A=
+	 * with them yet, but they are serialized the same way as at runtime.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
 	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
 		rc =3D sit9531x_chan_state_fetch(sitdev, i);=0A=
-		if (rc) {=0A=
-			dev_err(sitdev->dev,=0A=
-				"Failed to fetch PLL%c state: %d\n",=0A=
-				'A' + i, rc);=0A=
-			return rc;=0A=
-		}=0A=
+		if (rc)=0A=
+			break;=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev, "Failed to fetch PLL%c state: %d\n",=0A=
+			'A' + i, rc);=0A=
+		return rc;=0A=
 	}=0A=
 =0A=
 	return 0;=0A=
@@ -968,6 +1871,71 @@ static void sit9531x_dev_ref_states_update(struct sit=
9531x_dev *sitdev)=0A=
 			dev_warn(sitdev->dev,=0A=
 				 "Failed to get REF%u status: %d\n", i, rc);=0A=
 	}=0A=
+=0A=
+	rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+	if (rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "Failed to read the input clock monitors: %d\n", rc);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_ref_pll_mask_rebuild - re-derive the input receiver refcounts=
=0A=
+ *=0A=
+ * ref->pll_mask decides when an input receiver may be powered down, and=
=0A=
+ * the connect and disconnect paths maintain it by hand.  A request that=
=0A=
+ * failed part way through leaves it describing a table the device does=0A=
+ * not hold, and nothing else corrected it: a later disconnect could then=
=0A=
+ * drop the count to zero and gate an input another PLL is still locked=0A=
+ * to.  Re-derive every mask from the tables the poll has just read.  No=
=0A=
+ * extra bus traffic -- sit9531x_chan_state_fetch() refreshed the masks=0A=
+ * this reads immediately before.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_ref_pll_mask_rebuild(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 pll_idx, src, index;=0A=
+=0A=
+	for (index =3D 0; index < sitdev->info->num_inputs; index++)=0A=
+		sitdev->ref[index].pll_mask =3D 0;=0A=
+=0A=
+	for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {=0A=
+		u16 mask =3D sitdev->chan[pll_idx].prio_mask;=0A=
+=0A=
+		for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++) {=0A=
+			if (!(mask & BIT(src)))=0A=
+				continue;=0A=
+=0A=
+			index =3D sit9531x_hw_src_input(src);=0A=
+			if (index < sitdev->info->num_inputs)=0A=
+				sitdev->ref[index].pll_mask |=3D BIT(pll_idx);=0A=
+		}=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Release a forced holdover that a table write owes.  The write forces=0A=
+ * holdover and releases it at the end; when the release failed, nothing=
=0A=
+ * else in the driver clears the bit -- a retry of the same request finds=
=0A=
+ * the table already as asked and does not run the sequence again -- so=0A=
+ * the poll retries it each tick until it lands.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_ho_release_retry(struct sit9531x_dev *sitdev, u8 pll_=
idx)=0A=
+{=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+=0A=
+	if (!chan->ho_release_pending)=0A=
+		return;=0A=
+=0A=
+	if (sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,=0A=
+				   BIT(SIT9531X_PLL_HO_FORCE_BIT), 0))=0A=
+		return;=0A=
+=0A=
+	chan->ho_release_pending =3D false;=0A=
+	dev_info(sitdev->dev, "PLL%c: forced holdover released\n",=0A=
+		 'A' + pll_idx);=0A=
 }=0A=
 =0A=
 static void sit9531x_dev_chan_states_update(struct sit9531x_dev *sitdev)=
=0A=
@@ -975,12 +1943,15 @@ static void sit9531x_dev_chan_states_update(struct s=
it9531x_dev *sitdev)=0A=
 	int i, rc;=0A=
 =0A=
 	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		sit9531x_ho_release_retry(sitdev, i);=0A=
 		rc =3D sit9531x_chan_state_fetch(sitdev, i);=0A=
 		if (rc)=0A=
 			dev_warn(sitdev->dev,=0A=
 				 "Failed to get PLL%c state: %d\n",=0A=
 				 'A' + i, rc);=0A=
 	}=0A=
+=0A=
+	sit9531x_ref_pll_mask_rebuild(sitdev);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -1272,6 +2243,84 @@ static void sit9531x_pll_states_report(struct sit953=
1x_dev *sitdev)=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_pin_is_registrable - check if an input pin is registrabl=
e=0A=
+ *=0A=
+ * Split out so input-model changes stay local to this helper.=0A=
+ *=0A=
+ * Return: true if the input pin should be registered, false otherwise=0A=
+ */=0A=
+static bool sit9531x_input_pin_is_registrable(struct sit9531x_dev *sitdev,=
=0A=
+					      u8 index)=0A=
+{=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return false;=0A=
+=0A=
+	/*=0A=
+	 * The N lane of a differentially-configured pair is not a=0A=
+	 * standalone input and is skipped (zl3073x model).=0A=
+	 */=0A=
+	if (sit9531x_input_is_n(index) &&=0A=
+	    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		return false;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Warn about a pin node in the firmware description whose reg names no=0A=
+ * pin this device can have: an input lane or an output the variant does=
=0A=
+ * not have, or the N lane of a pair the configuration runs differential.=
=0A=
+ * Nodes are looked up from the pins (sit9531x_pin_props_get()), so such a=
=0A=
+ * node would otherwise have its label and frequencies dropped without a=
=0A=
+ * word.  The binding bounds reg per variant; this catches what reaches=0A=
+ * the driver unvalidated, and the pair mode, which only the loaded=0A=
+ * configuration decides.  An output that exists but that no PLL drives=0A=
+ * gets no pin either and is not reported: which outputs a configuration=
=0A=
+ * uses is not a fault in the description.=0A=
+ */=0A=
+static void sit9531x_pin_nodes_check(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct fwnode_handle *pins, *node;=0A=
+	bool found;=0A=
+	u32 reg;=0A=
+	u8 i;=0A=
+=0A=
+	pins =3D device_get_named_child_node(sitdev->dev, "input-pins");=0A=
+	fwnode_for_each_child_node(pins, node) {=0A=
+		if (fwnode_property_read_u32(node, "reg", &reg))=0A=
+			continue;=0A=
+		if (reg < sitdev->info->num_inputs &&=0A=
+		    sit9531x_input_pin_is_registrable(sitdev, reg))=0A=
+			continue;=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "input-pins/%pfwP: reg %u is %s, node ignored\n",=0A=
+			 node, reg,=0A=
+			 reg < sitdev->info->num_inputs ?=0A=
+			 "the N lane of a differential pair" :=0A=
+			 "not an input lane");=0A=
+	}=0A=
+	fwnode_handle_put(pins);=0A=
+=0A=
+	pins =3D device_get_named_child_node(sitdev->dev, "output-pins");=0A=
+	fwnode_for_each_child_node(pins, node) {=0A=
+		if (fwnode_property_read_u32(node, "reg", &reg))=0A=
+			continue;=0A=
+		found =3D false;=0A=
+		for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+			if (sitdev->info->clkout_map[i] =3D=3D reg) {=0A=
+				found =3D true;=0A=
+				break;=0A=
+			}=0A=
+		}=0A=
+		if (!found)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "output-pins/%pfwP: reg %u is not an output of %s, node ignored\n",=
=0A=
+				 node, reg, sitdev->info->name);=0A=
+	}=0A=
+	fwnode_handle_put(pins);=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dev_start - start normal operation=0A=
  *=0A=
@@ -1294,6 +2343,8 @@ static int sit9531x_dev_start(struct sit9531x_dev *si=
tdev)=0A=
 	sit9531x_pll_states_report(sitdev);=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
 =0A=
+	sit9531x_pin_nodes_check(sitdev);=0A=
+=0A=
 	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
 		rc =3D sit9531x_dpll_register(sitdpll);=0A=
 		if (rc) {=0A=
@@ -1475,9 +2526,9 @@ static void sit9531x_dpll_pins_unregister(struct sit9=
531x_dpll *sitdpll)=0A=
  * @dir:	pin direction=0A=
  * @index:	pin hardware index=0A=
  *=0A=
- * Only the XO pin has a complete pin-op table in this patch, so only=0A=
- * the XO pin is registrable here.  Other pin classes are registered=0A=
- * once their state callbacks land in the following patches.=0A=
+ * For input pins: delegate to sit9531x_input_pin_is_registrable().=0A=
+ * A pin class whose state callback the tree does not have yet is not=0A=
+ * registrable: the core refuses a pin without one.=0A=
  *=0A=
  * Return: true if pin should be registered, false otherwise=0A=
  */=0A=
@@ -1485,15 +2536,15 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 					     enum dpll_pin_direction dir,=0A=
 					     u8 index)=0A=
 {=0A=
-	/*=0A=
-	 * Only the XO pin has a complete pin-op table in this patch.=0A=
-	 * Other pin classes are registered once their state callbacks=0A=
-	 * land in the following patches.=0A=
-	 */=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
 	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
 		return false;=0A=
 =0A=
-	return index =3D=3D SIT9531X_MAX_INPUTS;=0A=
+	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+		return true;=0A=
+=0A=
+	return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
 }=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index c88822d542c0..07a0ae47c056 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -38,7 +38,7 @@=0A=
 #define SIT9531X_INTSYNC_OUT_PIN_ID	SIT9531X_MAX_OUTPUTS=0A=
 #define SIT9531X_STATUS_POLL_MS		500=0A=
 =0A=
-/* selected_ref value when the active source is not a registered input */=
=0A=
+/* routed_ref value when the PLL is fed no registered input */=0A=
 #define SIT9531X_REF_INVALID		0xFF=0A=
 =0A=
 /* SiTime IEEE OUI for EUI-64 generation */=0A=
@@ -77,6 +77,9 @@ enum sit9531x_signal_mode {=0A=
  * @freq:		configured frequency in Hz=0A=
  * @enabled:		the lane's receiver is on=0A=
  * @pll_mask:		bitmask of PLLs this input feeds (bit 0 =3D PLLA)=0A=
+ * @los:		the clock monitor reports loss of signal on the lane=0A=
+ * @qual_fail:		the clock monitor reports a frequency drift on the=0A=
+ *			lane while it still has signal=0A=
  * @sig_mode:		signal mode of the pair this lane belongs to=0A=
  *			(detected from CLKINx_INPUT_MODE at probe)=0A=
  */=0A=
@@ -84,6 +87,8 @@ struct sit9531x_ref {=0A=
 	u64		freq;=0A=
 	bool		enabled;=0A=
 	u8		pll_mask;=0A=
+	bool		los;=0A=
+	bool		qual_fail;=0A=
 	enum sit9531x_signal_mode	sig_mode;=0A=
 };=0A=
 =0A=
@@ -113,15 +118,25 @@ struct sit9531x_out {=0A=
  *			loss-of-lock bit stays clear because nothing drives it=0A=
  * @locked:		PLL is active and its outer loop reports lock=0A=
  * @mode:		0 =3D sync (outer loop enabled), 1 =3D free-run=0A=
- * @selected_ref:	logical input index of the currently selected=0A=
- *			reference (the INTSYNC net maps to=0A=
- *			SIT9531X_INTSYNC_PIN_ID), or SIT9531X_REF_INVALID=0A=
- *			when the hardware source encoding is reserved=0A=
+ * @routed_ref:		logical input index of the reference the device=0A=
+ *			feeds the PLL while it tracks one (the INTSYNC net=0A=
+ *			maps to SIT9531X_INTSYNC_PIN_ID); SIT9531X_REF_INVALID=0A=
+ *			when the PLL tracks nothing -- free-run, frozen,=0A=
+ *			unlocked -- or the source code names no registered=0A=
+ *			input=0A=
  * @inner_lol:		PLL inner loop loss-of-lock detected=0A=
  * @ho_freeze:		holdover freeze active=0A=
  * @ho_valid:		holdover memory acquired, i.e. the holdover window=0A=
  *			holds a valid estimate to fall back on=0A=
- * @prio_mask:		bit per hardware source code present in this PLL's=0A=
+ * @ho_release_pending:	a table write forced holdover and could not releas=
e=0A=
+ *			it; the poll retries the release until it lands=0A=
+ * @prio_srcs:		cached copy of the priority table, one source code=0A=
+ *			per slot; refreshed together with @prio_mask, it is=0A=
+ *			what a rebuilt table is compared against=0A=
+ * @prio_last:		first slot each source occupies, plus one (0 =3D the=0A=
+ *			source is not in the table); refreshed from the same=0A=
+ *			scan as @prio_mask, so the two never disagree=0A=
+ * @prio_mask:		bit per canonical source present in this PLL's=0A=
  *			priority table, i.e. the sources it may select.  Read=0A=
  *			back from the table by the periodic worker and=0A=
  *			refreshed by every table write, so it tracks the=0A=
@@ -141,10 +156,13 @@ struct sit9531x_chan {=0A=
 	bool		active;=0A=
 	bool		locked;=0A=
 	u8		mode;=0A=
-	u8		selected_ref;=0A=
+	u8		routed_ref;=0A=
 	bool		inner_lol;=0A=
 	bool		ho_freeze;=0A=
 	bool		ho_valid;=0A=
+	bool		ho_release_pending;=0A=
+	u8		prio_srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8		prio_last[SIT9531X_PRIO_NUM_SRC];=0A=
 	u16		prio_mask;=0A=
 	u8		cfg_prio[SIT9531X_PRIO_NUM_SRC];=0A=
 	u16		cfg_known;=0A=
@@ -222,8 +240,18 @@ int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev=
, u8 pll_idx,=0A=
 			   u8 offset, u8 mask, u8 val);=0A=
 =0A=
 /* ---- Input enable/disable ---- */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
 =0A=
 /* ---- Input priority ---- */=0A=
+bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev,=0A=
+				 u8 pll_idx, u8 input_idx);=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio);=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx);=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx);=0A=
 =0A=
 /* ---- Output enable/disable (Hi-Z control) ---- */=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index e88fa4e29bdf..4c7cae4ce93e 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -34,11 +34,31 @@ sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin =
*pin)=0A=
 	       pin->id =3D=3D SIT9531X_MAX_INPUTS;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Status of a PLL whose outer loop is frozen in holdover.=0A=
+ *=0A=
+ * The interface has a PLL report holdover for a hold forced by=0A=
+ * disconnecting every input only when it was LOCKED_HO_ACQ before, that=
=0A=
+ * is, when it has a valid holdover estimate to run on; without one it=0A=
+ * stays UNLOCKED.  Removing the last source from a PLL's table forces=0A=
+ * exactly that hold, so a frozen PLL that lists no source is in holdover=
=0A=
+ * only while its memory is valid.  A PLL frozen with sources still listed=
=0A=
+ * lost its lock, and is in holdover on the device's say-so.=0A=
+ */=0A=
+static enum dpll_lock_status=0A=
+sit9531x_dpll_frozen_status(const struct sit9531x_chan *chan)=0A=
+{=0A=
+	if (!chan->prio_mask && !chan->ho_valid)=0A=
+		return DPLL_LOCK_STATUS_UNLOCKED;=0A=
+=0A=
+	return DPLL_LOCK_STATUS_HOLDOVER;=0A=
+}=0A=
+=0A=
 /*=0A=
  * The cached state this reports comes from the outer loss-of-lock byte=0A=
  * (page 0, reg 0x06), the PLL mode bit (PLL page, reg 0x31), inner LOL=0A=
- * (reg 0x92), the holdover freeze byte (reg 0x0A) and the per-PLL=0A=
- * holdover-valid bit (PLL page, reg 0x06).=0A=
+ * (reg 0x92), the holdover freeze byte (reg 0x0A), the per-PLL=0A=
+ * holdover-valid bit (PLL page, reg 0x06) and the priority table.=0A=
  */=0A=
 static int=0A=
 sit9531x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_p=
riv,=0A=
@@ -71,7 +91,7 @@ sit9531x_dpll_lock_status_get(const struct dpll_device *d=
pll, void *dpll_priv,=0A=
 		 * under a locked status would never reach userspace.  An=0A=
 		 * inner loop that is not locked is not a locked PLL.=0A=
 		 */=0A=
-		*status =3D chan->ho_freeze ? DPLL_LOCK_STATUS_HOLDOVER :=0A=
+		*status =3D chan->ho_freeze ? sit9531x_dpll_frozen_status(chan) :=0A=
 					    DPLL_LOCK_STATUS_UNLOCKED;=0A=
 	} else if (chan->mode) {=0A=
 		/*=0A=
@@ -90,7 +110,7 @@ sit9531x_dpll_lock_status_get(const struct dpll_device *=
dpll, void *dpll_priv,=0A=
 		 * counts a frozen PLL as tracking nothing for the same=0A=
 		 * reason.=0A=
 		 */=0A=
-		*status =3D DPLL_LOCK_STATUS_HOLDOVER;=0A=
+		*status =3D sit9531x_dpll_frozen_status(chan);=0A=
 	} else if (chan->locked) {=0A=
 		/*=0A=
 		 * HO_ACQ is locked *and* holdover memory acquired, so it needs=0A=
@@ -195,7 +215,8 @@ const struct dpll_device_ops sit9531x_dpll_device_ops =
=3D {=0A=
  *   the pin is the operational state.  Predicates, all evaluated under=0A=
  *   multiop_lock:=0A=
  *     M  source is present in THIS PLL's hardware priority table=0A=
- *     S  chan->selected_ref =3D=3D this pin's id (the active selection)=
=0A=
+ *     S  chan->routed_ref =3D=3D this pin's id (the reference the device=
=0A=
+ *        reports feeding the PLL)=0A=
  *     L  chan->locked && !chan->mode && !chan->ho_freeze=0A=
  *        (tracking a reference: outer loop running, locked, not frozen)=
=0A=
  *     N  the input lane's clock monitor reports loss of signal=0A=
@@ -218,12 +239,16 @@ const struct dpll_device_ops sit9531x_dpll_device_ops=
 =3D {=0A=
  *                   no mode that pins one reference (see "Mode" above)=0A=
  *     other         -EINVAL=0A=
  *=0A=
- *   The ACTIVE test needs L as well as S because the selection is what th=
e=0A=
- *   driver last wrote or the device last chose, not proof the loop uses=
=0A=
- *   it: a free-running, frozen or unlocked PLL follows nothing.  It needs=
=0A=
- *   !N because a PLL whose selection names a lane without signal has=0A=
- *   fallen back to another listed source on its own, and no register=0A=
- *   says which -- no pin is reported active then.  The INTSYNC destinatio=
n=0A=
+ *   S is not the active selection the driver writes to the table: when=0A=
+ *   the selected source loses its signal the device falls back to another=
=0A=
+ *   listed source on its own and leaves the selection naming the dead one=
,=0A=
+ *   so the reference the device reports feeding the PLL is read instead,=
=0A=
+ *   and after such a fallback the pin the PLL moved to is the active one.=
=0A=
+ *   The ACTIVE test needs L as well as S because being fed to the PLL is=
=0A=
+ *   not proof the loop uses it: a free-running, frozen or unlocked PLL=0A=
+ *   follows nothing.  It needs !N because the device names what it feeds=
=0A=
+ *   the PLL, not what the PLL is locked to, and a lane without signal is=
=0A=
+ *   not that whatever the lock bit still says.  The INTSYNC destination=
=0A=
  *   has no monitor, so N and Q never hold for it.=0A=
  *=0A=
  *   M is read from the hardware priority table, not from ref->pll_mask,=
=0A=
@@ -241,6 +266,124 @@ const struct dpll_device_ops sit9531x_dpll_device_ops=
 =3D {=0A=
  * FIXED role -- XO pin.  Always CONNECTED; it cannot be routed.=0A=
  */=0A=
 =0A=
+/*=0A=
+ * Report a selection-role pin's state on this DPLL.  @pin_id is a logical=
=0A=
+ * input index, SIT9531X_INTSYNC_PIN_ID for the INTSYNC destination.=0A=
+ *=0A=
+ * Membership comes from chan->prio_mask, which is the priority table read=
=0A=
+ * back from the chip -- not a record of what the driver asked for.  The=
=0A=
+ * getter runs on every poll for every input pin of every DPLL, so it take=
s=0A=
+ * the mask the worker refreshed rather than rescanning the table over I2C=
=0A=
+ * each time; table writes refresh it too, so a get right after a set does=
=0A=
+ * not report the old membership.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void=0A=
+sit9531x_dpll_selection_state_get(struct sit9531x_dev *sitdev,=0A=
+				  const struct sit9531x_dpll *sitdpll,=0A=
+				  u8 pin_id, enum dpll_pin_state *state)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+=0A=
+	if (chan->prio_mask & BIT(sit9531x_input_hw_src(pin_id)))=0A=
+		*state =3D DPLL_PIN_STATE_SELECTABLE;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Is this the reference the PLL is tracking now?  See the S && L && !N=0A=
+ * predicate in the pin-state contract.  This is also what gates the=0A=
+ * measurements taken against the active reference.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dpll_selection_active(struct sit9531x_dev *sitdev,=0A=
+			       const struct sit9531x_dpll *sitdpll, u8 pin_id)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+=0A=
+	if (chan->routed_ref !=3D pin_id || !chan->locked || chan->mode ||=0A=
+	    chan->ho_freeze)=0A=
+		return false;=0A=
+=0A=
+	/*=0A=
+	 * Fed to the PLL is not locked to: the device names the source it=0A=
+	 * routes, and a lane that lost its signal is one the PLL is about=0A=
+	 * to be moved off, whatever the lock bit still says.=0A=
+	 */=0A=
+	if (pin_id < sitdev->info->num_inputs &&=0A=
+	    sit9531x_ref_state_get(sitdev, pin_id)->los)=0A=
+		return false;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Report a selection-role pin's operational state on this DPLL.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void=0A=
+sit9531x_dpll_selection_operstate_get(struct sit9531x_dev *sitdev,=0A=
+				      const struct sit9531x_dpll *sitdpll,=0A=
+				      u8 pin_id,=0A=
+				      enum dpll_pin_operstate *operstate)=0A=
+{=0A=
+	const struct sit9531x_ref *ref;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (sit9531x_dpll_selection_active(sitdev, sitdpll, pin_id)) {=0A=
+		*operstate =3D DPLL_PIN_OPERSTATE_ACTIVE;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (pin_id < sitdev->info->num_inputs) {=0A=
+		ref =3D sit9531x_ref_state_get(sitdev, pin_id);=0A=
+		if (ref->los) {=0A=
+			*operstate =3D DPLL_PIN_OPERSTATE_NO_SIGNAL;=0A=
+			return;=0A=
+		}=0A=
+		if (ref->qual_fail) {=0A=
+			*operstate =3D DPLL_PIN_OPERSTATE_QUAL_FAILED;=0A=
+			return;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	*operstate =3D DPLL_PIN_OPERSTATE_STANDBY;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_input_pin_operstate_on_dpll_get(const struct dpll_pin *pin,=
=0A=
+					      void *pin_priv,=0A=
+					      const struct dpll_device *dpll,=0A=
+					      void *dpll_priv,=0A=
+					      enum dpll_pin_operstate *state,=0A=
+					      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_operstate_get(sitdev, sitdpll, dpin->id,=0A=
+					      state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static int=0A=
 sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,=0A=
 				      void *pin_priv,=0A=
@@ -253,8 +396,163 @@ sit9531x_dpll_input_pin_direction_get(const struct dp=
ll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state=0A=
+ *=0A=
+ * Selection role; see the pin-state contract above.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state *state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_set - set input pin DPLL state=0A=
+ *=0A=
+ * Enables or disables the physical input receiver via Page 0x02=0A=
+ * force/state registers (sit9531x_input_disable/enable()) and updates=0A=
+ * this DPLL's Page 1 priority table so the state is honoured by the=0A=
+ * PLL's automatic reference selection, not just at the input buffer.=0A=
+ * Selection role; see the pin-state contract above for the states.=0A=
+ *=0A=
+ * The priority table is per PLL, so it is always updated for this DPLL.=
=0A=
+ * A single physical input feeds every DPLL, so the hardware receiver is=
=0A=
+ * only cut off once the last DPLL has released it: ref->pll_mask tracks=
=0A=
+ * which DPLLs currently claim the input, and the physical disable=0A=
+ * happens on the transition to an empty mask.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	struct sit9531x_ref *ref =3D &sitdev->ref[dpin->id];=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(dpin->id);=0A=
+	u8 pll_bit =3D BIT(sitdpll->id);=0A=
+	bool enabled_here =3D false;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);=0A=
+		/*=0A=
+		 * The table write, the latch and the holdover release are=0A=
+		 * three steps behind one return code, so ask the table what=0A=
+		 * actually happened rather than reading the errno as "no=0A=
+		 * change".  A source that is gone from the table has been=0A=
+		 * released whatever else failed.=0A=
+		 */=0A=
+		if (rc && sit9531x_input_prio_present(sitdev, sitdpll->id,=0A=
+						      hw_src))=0A=
+			break;=0A=
+		ref->pll_mask &=3D ~pll_bit;=0A=
+		/*=0A=
+		 * The receiver is shared, so the last DPLL to let go turns it=0A=
+		 * off.  That has to happen even when the table rewrite=0A=
+		 * reported an error, or the input stays powered with nothing=0A=
+		 * tracking it; the first error is the one returned.=0A=
+		 */=0A=
+		if (!ref->pll_mask) {=0A=
+			int off_rc =3D sit9531x_input_disable(sitdev, dpin->id);=0A=
+=0A=
+			if (off_rc && !rc)=0A=
+				rc =3D off_rc;=0A=
+		}=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		/*=0A=
+		 * CONNECTED asks for this input and no other, which the=0A=
+		 * device cannot be told to do: it selects by priority and the=0A=
+		 * manual-active-select path is not wired up (see "Mode").=0A=
+		 * Refuse instead of quietly behaving like SELECTABLE.=0A=
+		 */=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Device selects its reference by priority; use selectable");=0A=
+		rc =3D -EOPNOTSUPP;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_SELECTABLE:=0A=
+		/*=0A=
+		 * Gate the receiver on whenever it is off, not only when this=0A=
+		 * DPLL holds no claim yet.  The two are tracked separately --=0A=
+		 * the claim comes from the priority table, the receiver from=0A=
+		 * the force bits -- so a PLL that already lists the input can=0A=
+		 * still find it powered down, and skipping the enable would=0A=
+		 * report success for a reference that cannot reach the loop.=0A=
+		 */=0A=
+		if (!ref->enabled) {=0A=
+			rc =3D sit9531x_input_enable(sitdev, dpin->id);=0A=
+			if (rc)=0A=
+				break;=0A=
+			enabled_here =3D true;=0A=
+		}=0A=
+		rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);=0A=
+		if (rc && !sit9531x_input_prio_present(sitdev, sitdpll->id,=0A=
+						       hw_src)) {=0A=
+			/*=0A=
+			 * Undo only what this request did.  A receiver the=0A=
+			 * loaded configuration had already turned on is not=0A=
+			 * this request's to turn off.=0A=
+			 */=0A=
+			if (enabled_here)=0A=
+				sit9531x_input_disable(sitdev, dpin->id);=0A=
+			break;=0A=
+		}=0A=
+		/*=0A=
+		 * Claim the input for this DPLL only once it is both enabled=0A=
+		 * and present in the priority table.  Setting the mask before=0A=
+		 * prio_add would leak the claim if prio_add failed, keeping the=0A=
+		 * shared input receiver powered even after every DPLL released=0A=
+		 * it.=0A=
+		 */=0A=
+		ref->pll_mask |=3D pll_bit;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * Leave the messages the switch already set in place; only a failure=0A=
+	 * that came from the hardware path still needs one.=0A=
+	 */=0A=
+	if (rc =3D=3D -ENOSPC)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Priority table is full of unique sources on this PLL");=0A=
+	else if (rc && rc !=3D -EOPNOTSUPP && rc !=3D -EINVAL)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input pin state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
+	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 9349ec722569..fd1068982cd7 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -126,6 +126,10 @@=0A=
 #define SIT9531X_REG_GLOBAL_UPDATE		SIT9531X_REG(0x00, 0x0F)=0A=
 #define SIT9531X_SMALL_UPDATE_CMD		0x02=0A=
 =0A=
+/* PLL holdover control (PLL page offset) */=0A=
+#define SIT9531X_PLL_REG_HO_CTRL		0x6F=0A=
+#define SIT9531X_PLL_HO_FORCE_BIT		4=0A=
+=0A=
 /* One bit per input PAIR (bit 0 =3D CLKIN0, ..., bit 3 =3D CLKIN3) */=0A=
 #define SIT9531X_REG_IN_DE_FORCE		SIT9531X_REG(0x02, 0xE8)=0A=
 #define SIT9531X_REG_IN_DE_STATE		SIT9531X_REG(0x02, 0xE9)=0A=
@@ -230,6 +234,31 @@=0A=
 =0A=
 #define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)=0A=
 =0A=
+/*=0A=
+ * Debug register -- PLL page.  Writing the key unlocks the page's debug=
=0A=
+ * registers for writing; writing zero locks them again.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DEBUG		0xBD=0A=
+#define SIT9531X_PLL_DEBUG_UNLOCK		0xC3=0A=
+#define SIT9531X_PLL_DEBUG_LOCK			0x00=0A=
+=0A=
+/*=0A=
+ * Debug status bus -- PLL page.  The address register selects the block=
=0A=
+ * whose status the data register returns.  A read of the data register=0A=
+ * returns what the previous read latched, so the documented procedures=0A=
+ * read it three times and take the last.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DBG_STATUS_ADDR	0xD1=0A=
+#define SIT9531X_PLL_REG_DBG_STATUS_DATA	0xD0=0A=
+#define SIT9531X_DBG_STATUS_READS		3=0A=
+=0A=
+/*=0A=
+ * Status of the reference routed to the PLL: the low nibble is the=0A=
+ * source the input subsystem feeds it, in the priority-table encoding.=0A=
+ */=0A=
+#define SIT9531X_DBG_STATUS_ROUTED_SRC	0xB0=0A=
+#define SIT9531X_DBG_ROUTED_SRC_MASK		GENMASK(3, 0)=0A=
+=0A=
 /*=0A=
  * PLL_CONFIG1F_PLL: bit 6 puts the PLL in manual active select, where it=
=0A=
  * no longer arbitrates by priority.  The other bits are GUI-generated=0A=
@@ -266,6 +295,18 @@=0A=
 #define SIT9531X_PLL_REG_STATUS_1		0x06=0A=
 #define SIT9531X_PLL_STATUS_1_HO_VALID	BIT(2)=0A=
 =0A=
+/*=0A=
+ * Page 0x06 clock monitor status, one nibble per input lane: P lanes in=
=0A=
+ * 0x02 (IN0P low, IN1P high) and 0x06 (IN2P, IN3P), N lanes in 0x92=0A=
+ * (IN0N, IN1N) and 0x96 (IN2N, IN3N).=0A=
+ */=0A=
+#define SIT9531X_CLKMON_P_STATUS_01		SIT9531X_REG(0x06, 0x02)=0A=
+#define SIT9531X_CLKMON_P_STATUS_23		SIT9531X_REG(0x06, 0x06)=0A=
+#define SIT9531X_CLKMON_N_STATUS_01		SIT9531X_REG(0x06, 0x92)=0A=
+#define SIT9531X_CLKMON_N_STATUS_23		SIT9531X_REG(0x06, 0x96)=0A=
+#define SIT9531X_CLKMON_FINE_DRIFT		BIT(0)=0A=
+#define SIT9531X_CLKMON_COARSE_DRIFT		BIT(1)=0A=
+#define SIT9531X_CLKMON_LOSS			BIT(2)=0A=
 #define SIT9531X_CLKMON_P_NOTIF_01		SIT9531X_REG(0x06, 0x03)=0A=
 #define SIT9531X_CLKMON_P_NOTIF_23		SIT9531X_REG(0x06, 0x07)=0A=
 =0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
