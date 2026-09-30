Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67394AB1BF;
	Wed, 30 Sep 2026 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811456; cv=fail; b=iFs2/Tz3KZ9KE/GA+WwwkjjQ72kqf7btVZnYk+BIqHic14YJao3HItEtKlL8pWoryWIlrLYdqwTFPpucPjyhaHBv4bjQ0ksI5UAMxnwdTgWLA4IPQrTDSuNrMNIH0HiKWXPItHvO0MfkY0GMwj3f0y3nd2kU/kIAmkGmYyr+lmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811456; c=relaxed/simple;
	bh=BsagPFaEp+oQ53j+8owkgBnu68sJwMKqj4cdOBKggiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SHfNU+jLoNLWHjolw23gH5Jfk6fGWHH/p4cz/EfwXRd6HD2crLdb8DUcXpS3FjktnTDpZhRCdvXeQWcC+TZpZQwO6Vwn3lddIk9r5gpLd2cO0yZx/W5chYgqaiXtzD+lPWBxBkO/FxAdxRjnSpPBKcxnp2X5Pbz3+iCmRcIDPds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=gORgWrNR; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=LEBFY03x; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="gORgWrNR";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="LEBFY03x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=fZJjkSppTXUZ+TaAYLrIRi+0MyChkNhKZ0ZvwbfXiDQ=;
 b=gORgWrNRhQ+IhU1wCDbUtYcdBkdm2bMhB1Lt3b26p4gYEUEGXAw4/BRDtO40DFuUW904wv6fCFAXA1+24Rdr0PSTTtFKE6c/F0uPt2Z3GA6OKut1tTgunqlNiK5N2t7v/GHYcnJjoUtiPNTtnNYuTFn8sWJx4vcM0iJKRFVgZYIsZBZY7zuBB9LvHlrbN8rPfY3D3B/9wKGK/yPT+48JLfY9DFqnoQ3SOtGI60LEUAHCps+JrZdgJ1PX+xsfAN/ubxOQNU0o8g8KXwvg5Ov8j8mQegKde1AZiOePICuhDYK6H4MC5Zy41JTkDeqbcJau9+soBUlnHtJgHhXZhF672g==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020097.outbound.protection.outlook.com [52.101.61.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2A020100066;
	Wed, 30 Sep 2026 23:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqcU1GC9f9P+/f58JS28l9XfNhStjt4ODpB3PLCfgwAHQDa+dOqrfxMJ55KLXDaVjzGNokmLHXnNMmgPA3ZeJEWAzFd+BP2xk78t7EzCKlvIy9r3QpWHEGHY0BoWc54Wcto5tlQTMEjJjOlV2A8cwWt7V/S7iHZHbvHy+8Ka9jYBT7ZtpBDe3Y1S+1xgLwpto3OSuw98xTEr2Nq75d+n6YzTk9XuPlgzfBh9NGkn2DX21IJGoRu+MMBR5lY2HOI55UbXTSiNfoSAX3XPr9HEf6pmRirZJ5Y94v3h1vteK4wJtXpEqauV4QAp09rMjZ2av8Zw5jqCuYqo8u1zSyYVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZJjkSppTXUZ+TaAYLrIRi+0MyChkNhKZ0ZvwbfXiDQ=;
 b=e4HaL2SaBY8ss+gX+NtApVCr6sp0LWGO8znbXERiXu0EA4A2Eu4YyVE5NgseIJ9au4JbRaTmDCnGSLpJoLGWBD6dx2vHzCRCG4+VgILE6phLtBM20y+Y4ALSjrTQCL+9zzrlWqUKjbrFgW4JjP679jCZIRlnXQGJmhZg2EBu/ofddhqbz9bvtPn5/lp5Iqwwsu/73mNdYaTQSEUpjDnaGw86lgWoCtm14h+MUzkC8ngyXaqQ+MwZC/vnNeVPk4WQW6TKi/s9vtHYLUVo0iunH+FCBoYQwaFI2mGd9ilYvqom9gcGYu4bXQxqAm2Ox1wIClu8dDBODPTlqoiMAGcpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZJjkSppTXUZ+TaAYLrIRi+0MyChkNhKZ0ZvwbfXiDQ=;
 b=LEBFY03xkRBnwGwST/DJEh4X80OYtPDjbE4hyFJtP66q1MLBmF0yi6Kur9JW++hlPth01q0gApMAE7R7MWzIh2K+FTOZTpa1oAX8DLoHPYtBoEp7peVDQyuBIj08uX44fr6WAVzQeL2jJ2QKH5lmaxSymLE9p+IiJG7DtuzDUZFJSPUfNpLERIl77mH382xjGUFAiuUdXL7xJuAKEVwNORe9H3PImhFDG0aCkY6U1AJlz1LeNP5FRmBY2TIVWhdAoCqrnyVkrrF8Yemix3NpvYcvbMLhWyk3MUBmmkTnrdtX5dpjcK4QvZvGdZ/UvBr+X8/84aUk3OalsFRyuJ1PrA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB5383.namprd20.prod.outlook.com
 (2603:10b6:806:29e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 23:37:26 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:26 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v11 12/13] dpll: sit9531x: add support to get phase
 offset on the connected input pin
Thread-Topic: [PATCH net-next v11 12/13] dpll: sit9531x: add support to get
 phase offset on the connected input pin
Thread-Index: AQHdUTSlKd+aSrBCJkC/Wmzis1EAbA==
Date: Wed, 30 Sep 2026 23:37:23 +0000
Message-ID: <20260930233714.87679-13-arouhi@sitime.com>
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB5383:EE_
x-ms-office365-filtering-correlation-id: 83d80218-3c94-4523-1897-08df1f4bc933
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|3023799007|10067099003|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 RVfHq+UDPHqdm3SiewUvYLpuuD8MMyJemROm06uqCzpACTIvZBhE6HDTmiEEtMJyGjXPwuCTsugHNRRuaxB/oG4HSjqst21YPtiB6aQwIyDPWVoKmwx+WRBOf45qclqFzhc5WCdjxvMc9sI6Q7nYFrgHfJi791257uRyNRVBJYDUZQ131ksshJR4HwAJLhMEH2p314tuItvvzPwdHscDVcZwfxWPp+r5Asv+M1eFLDY4fbF8GpA7XyPfwa6XYUQjqzC+XQ/M5Msf+so+YThP1yJl+oX5L6/XNTIj4xPLEftpFPl/yi6YE3v0nyZMY0XHHmgtftVdvS1z8F/U/SCczQsknoiNacocmY5PYLOibKkI1gxWRGt+x1Sp/CpC3D4LYrE0OdqkEbhiIJeXegiW9k+T1RPegxkiCeJHqan5vUOEbmljDnMFOoUEpUbx9ob57hUBeEj56+YOd2aIC2qKjXP2r5LShiP1k3F+LsaH0KcI/JRadkyP/peC3Cfe3Tvv9lzy/WeCo+nuGfn9SH7o+RMg8ua2GhFsTcghnUpVktzBaK/6VbZ4r++Sgquk1DoKH+CmwDYlzDT+T8rOEQkMZt7zq/3G76kaYzEwzBqpFqkJgYsg9L3695wbbfs5uRN+0jCZW8mMRe84faTach8fRKIsNIyLW8mll1dEc1YI8Fuxa7T6/3KPigF+jKTFGO+RHR0ler86yb9LEPHpa1l7IV6KppbhiyQ6iIinEQqD9sc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SZtBydMiTaWb45NKUW8dSA7O+4aWj95hB301HfEyJ/j+xxvSbUS/XCTPui?=
 =?iso-8859-1?Q?ZiUZ3809h125hJzBDC0X6ecJU3iifN+fyRNpkoF5zu53rMLU6FK3R7pKOC?=
 =?iso-8859-1?Q?EfrpxeFyfavfZboc2RErfOgFqazEXeBM8/gNeZ2Cy1pwDuMWF6XiD0dbaw?=
 =?iso-8859-1?Q?1k1O3/UGYJtQ1RwKvI0cOkzhhV9J0uhIFJ9zeDkQ9RA95DL7Zmicd3J7Fx?=
 =?iso-8859-1?Q?X6NG8O4Rbaof/hBVAyNNighywEFW745l7ZZUzeDismQQf85HTjN/Bb8DoW?=
 =?iso-8859-1?Q?Xt3PwS9Ise5V4AhuDP6aBUwBhmoewXA94IwunQj8n/NTxVOWyWzswxd4u7?=
 =?iso-8859-1?Q?LnDYldXlUQVnLs5BgkcPkW+IL2DqJYzzXJM3p4s2NUZMBfhAGv4Q08IK/a?=
 =?iso-8859-1?Q?Ur5Rw77xemtdyI1zh/GTz0Sifh/+TKmj5YDDI0K5Uiflgb31f2OA+FI5n+?=
 =?iso-8859-1?Q?MONtpLWG5xPGg/Wg6mdGofAl1scCKIjhTB12hRU3Pu824ETXMyGmEWirtb?=
 =?iso-8859-1?Q?AOe2+VHoAFUqXgOvREAWUMix1HIL3AvcR0K2O7cWgJ83LOGfGsopPMM+18?=
 =?iso-8859-1?Q?BZkjHbxxPI3PKDOuE3vkFsI3nxbpRNFwEAmo6mIpogADZoiz5LLHO1Hnzj?=
 =?iso-8859-1?Q?MJIPr0+O1RdzkK5bxrZ9BzwJhgeEXi9KUMOEO5qiDgQ+Wg67X74g0arJVM?=
 =?iso-8859-1?Q?GJ2s79qVLPxRHXcCnaSNu5jX1OqSe15zXIrVPBcV2gmnbn8wJVbCi3CfXu?=
 =?iso-8859-1?Q?gK1OufW1+i4o2GUBwCDEGh90h+ZArIHMYcb/kSlzOZDbWUbw0sC+0HJrr6?=
 =?iso-8859-1?Q?bK1gADZNmVBGXbgdjyCdbAr5y2M4Q3tNIevWt5JpZV9ZLunhl2IOZW8qQH?=
 =?iso-8859-1?Q?W9ZevEjKDhedbTBclH8Xzpkyy97ZN3TluB9ScwfqPPNw0KsYqccuo412Dq?=
 =?iso-8859-1?Q?pws7+v4DNQsrwBxgf4fEBMKJuxXNJ8d8h+B+nY1Ae/uJ7fEzKL03O2q+6P?=
 =?iso-8859-1?Q?mp8NCTDN1+Ht/5nYud8q0ZTQbyVBWzrWPH8JQ1Upgan5CwHi09ksmn5aEM?=
 =?iso-8859-1?Q?RQy8ARFs4hM87wgcs875yAm3F6LJfoYUVZaPeOff7V3ZlEVzOj6qe4srDk?=
 =?iso-8859-1?Q?dR14bcrbD85tR4I84diIUoacLzrPolXXine4peAHA9qrcP0LihWM2lvmnF?=
 =?iso-8859-1?Q?MbiQS+zWTCCnhD1oCGOJDWI5Wd1OQLLsVR7YtJdgUMiQG2hkvcQ2VMusnk?=
 =?iso-8859-1?Q?ZBw7lVmd4OT6p6MDEOpMUwGrmOsKQHzqAkpL1PZQXjzolQWujtxgva98oW?=
 =?iso-8859-1?Q?QliDm3oob92XzBrrBFhZKI95QRc8FtmcgS4VnWVxl8a6okRh1luYLZDg7/?=
 =?iso-8859-1?Q?Y5WnWaSQ53YhaAWDxuk8NEWbY+Hg7uUMIjXMY6czDu/UXMsM2jtkOac1qF?=
 =?iso-8859-1?Q?Wp/bRqBxYYAUVWrliaW1zQzqwv6ycS0Xa50L2frO6936h51YrxDH/aU5kJ?=
 =?iso-8859-1?Q?kqXtbrmeUL4BtQ30MahbITZZjqAa69P+Gy6pE1RdgGWeJpBMwtedJc9Y6p?=
 =?iso-8859-1?Q?oqOKQaC7A/36ICEfhcn5l0ONpBLjbU/tp/1TIB+A7M2v4xu9AROWzhqan9?=
 =?iso-8859-1?Q?pyjHt6qVXSD777W1HNmfnt5auwsylnVnoZVxnN5LpHqkRZMV3zhcJpuzzT?=
 =?iso-8859-1?Q?ekAfaZqQRAcOjt8yZv145XJ1IUVcOhyXDRD7Jn61gK5GD5Wg5fh83XNPQl?=
 =?iso-8859-1?Q?Hwcjoh4wzC/bl5bGAA/T68Mf7UrQvNdvlL1qS/War4kmxz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WfafMXjYuSDyRTkq9t8gXeiKy/tjZMpcgFgGKxyl9oSyMo5QBBBeIDeqOFfdDoVcuO7oiLw3PDMzgcJfTNsMZaTZXVqp4haQtpsyMYR9NglFVAyfhrCuAUWcNdNVLoZPtHbomOV5ye4vL98PDxGMrhdeTVd0OX6wlPg1eF6IUz8ameG+kZTMfUdT9OSU3VcwyHKwnqDG4DHg+d5HSiouPVfedoDxTxodrMZk8uwcgb5RFWEj2NIXr9RjXMdK+LmMWwh/0S8xZrYHHh15BoRZNYAezFvD8hQr2eQmRwrWBG5fTUk7IIJzOPSe3WQ5XW6b15sqN65tG1w+XRnC3X3pJQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d80218-3c94-4523-1897-08df1f4bc933
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:23.9627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAirPzVPMoR3lGdpqESXv6NQgeGQ+oBYPCeMs3QwTZNdVMqrrXtDBf2DNG9K4k2bUvbXB1IDjJhlrYbJoIG3MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5383
X-MDID: 1790811450-F2zOpA5EauaO
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811450;F2zOpA5EauaO;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report the phase difference between a PLL's reference and the PLL itself,=
=0A=
which is the loop's own residual error and therefore trends small on a=0A=
locked device -- that is the measurement, not an artefact of it.=0A=
=0A=
The value comes from the on-chip time-to-digital converter, read through=0A=
the debug window: unlock the window, point it at the converter, then read=
=0A=
the trigger register, which latches a fresh sample and returns the=0A=
previous one.  It is read three times per sample for that reason; a single=
=0A=
read hands back the sample from the last call, so a repeated measurement=0A=
would look perfectly steady while saying nothing.=0A=
=0A=
Only the input a PLL has actually selected has a phase offset against it.=
=0A=
For any other pin there is nothing to measure and zero is reported,=0A=
because the core abandons an entire pin dump on an error from any one pin.=
=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 229 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h |   4 +=0A=
 drivers/dpll/sit9531x/dpll.c | 130 ++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  35 ++++++=0A=
 4 files changed, 398 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index d2719ff24249..45baa703aa45 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -2760,6 +2760,235 @@ int sit9531x_clear_notifications(struct sit9531x_de=
v *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * sit9531x_chan_selected_ref_read - read a PLL's active reference now=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @ref:	result, logical input index of the selected reference=0A=
+ *=0A=
+ * chan->selected_ref is refreshed by the monitor twice a second, which is=
=0A=
+ * close enough for reporting pin state but not for attributing a=0A=
+ * measurement: the device picks its own reference, so a sample taken now=
=0A=
+ * can belong to a pin the cache has not caught up with.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+int sit9531x_chan_selected_ref_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
+				    u8 *ref)=0A=
+{=0A=
+	u8 activesel_reg, input_sel;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	activesel_reg =3D SIT9531X_PRIO_BASE_REG +=0A=
+			SIT9531X_PRIO_REGS_PER_PLL * pll_idx +=0A=
+			SIT9531X_PRIO_ACTIVESEL_OFF;=0A=
+	rc =3D sit9531x_read_u8(sitdev,=0A=
+			      SIT9531X_REG(SIT9531X_PAGE_PRIOSYS,=0A=
+					   activesel_reg),=0A=
+			      &input_sel);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	input_sel &=3D SIT9531X_PRIO_NIBBLE_MASK;=0A=
+	input_sel =3D sit9531x_prio_src_canon(sitdev, input_sel);=0A=
+	*ref =3D sit9531x_hw_src_input(input_sel);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/**=0A=
+ * sit9531x_phase_offset_read - read phase difference via TDC=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @phase_ps:	output phase difference in picoseconds=0A=
+ *=0A=
+ * Reads the Time-to-Digital Converter (TDC) code from the PLL page=0A=
+ * registers -- a 35-bit magnitude with a separate sign bit -- then=0A=
+ * converts it to picoseconds using the VCO frequency:=0A=
+ * phase_diff =3D tdc_code / fvco.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENODATA when the PLL has no known VCO rate=0A=
+ * (nothing is sampled then), or the register access error=0A=
+ */=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_ps)=0A=
+{=0A=
+	u8 v, old_write_code, old_read_code;=0A=
+	bool have_old =3D false;=0A=
+	int rc, ret, i;=0A=
+	u64 fvco, mag_ps;=0A=
+	s64 tdc_signed;=0A=
+	u64 tdc_raw;=0A=
+	bool sign;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * Get the VCO rate first.  -ENODATA means the PLL has no rate to=0A=
+	 * convert against (a divider this board leaves unprogrammed), and=0A=
+	 * there is then no reason to open the debug window at all -- which=0A=
+	 * also keeps a bus error while it is open from ever being reported=0A=
+	 * as that benign case.=0A=
+	 */=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc) {=0A=
+		if (rc =3D=3D -ENODATA)=0A=
+			dev_dbg(sitdev->dev,=0A=
+				"PLL%c: Fvco unknown, skip TDC\n",=0A=
+				'A' + pll_idx);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	/* Unlock the debug page so the TDC registers are accessible. */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * Remember the tap selection so it can be put back.  The key=0A=
+	 * register is re-locked below, but the mux is not part of the key:=0A=
+	 * leaving it parked on the TDC with a slow sampling clock selected=0A=
+	 * is a state change the caller did not ask for, and the next reader=0A=
+	 * of a different tap would have to know to undo it.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				  &old_write_code);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+					  &old_read_code);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	have_old =3D true;=0A=
+=0A=
+	/*=0A=
+	 * Select the debug clock for taps below 200 kHz, then point the=0A=
+	 * readback at the TDC.  Only the one bit is touched: writing the=0A=
+	 * modifier register whole would clear the fields belonging to=0A=
+	 * other taps.=0A=
+	 */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+				   SIT9531X_DBG_READ_CODE_TDC);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * Latch a sample by reading the trigger register.  A single=0A=
+	 * read returns the previous latch, so read it three times as=0A=
+	 * the documented phase-difference procedure does.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_DBG_LATCH_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_TRIGGER, &v);=0A=
+		if (rc)=0A=
+			goto relock;=0A=
+	}=0A=
+=0A=
+	tdc_raw =3D 0;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_4, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	sign =3D !!(v & BIT(SIT9531X_TDC_SIGN_BIT));=0A=
+	tdc_raw =3D (u64)(v & SIT9531X_TDC_MAG_HI_MASK) << 32;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_3, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 24;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_2, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 16;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_1, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 8;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_0, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D v;=0A=
+=0A=
+	/*=0A=
+	 * Apply sign.  Per the register map the sign bit is active-high=0A=
+	 * for a positive offset: bit set -> +code, bit clear -> -code.=0A=
+	 */=0A=
+	tdc_signed =3D sign ? (s64)tdc_raw : -(s64)tdc_raw;=0A=
+=0A=
+	/*=0A=
+	 * phase_diff (seconds) =3D tdc_code / fvco=0A=
+	 * phase_diff (ps) =3D tdc_code * 1e12 / fvco=0A=
+	 *=0A=
+	 * mul_u64_u64_div_u64() keeps the exact Hz denominator; dividing=0A=
+	 * by whole MHz instead would lose up to ~40 ppm of scale on a=0A=
+	 * fractional-DIVN Fvco.=0A=
+	 */=0A=
+	mag_ps =3D mul_u64_u64_div_u64(tdc_signed < 0 ? -tdc_signed : tdc_signed,=
=0A=
+				     1000000000000ULL, fvco);=0A=
+	*phase_ps =3D tdc_signed < 0 ? -(s64)mag_ps : (s64)mag_ps;=0A=
+=0A=
+	rc =3D 0;=0A=
+=0A=
+relock:=0A=
+	if (have_old) {=0A=
+		ret =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					    SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+					    old_read_code);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+		ret =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					    SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+					    old_write_code);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Close the debug window again.  The key register opens every debug=0A=
+	 * register on this PLL while it holds the unlock value, and this read=0A=
+	 * runs on every pin-get of a connected input, so leaving it open=0A=
+	 * would mean normal monitoring permanently unlocks the block.=0A=
+	 */=0A=
+	ret =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_DEBUG,=0A=
+				    SIT9531X_PLL_DEBUG_LOCK);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_ref_state_fetch - read input reference status from hardware=0A=
  * @index:	logical input index=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 66c87e8f0387..bebdc9f5abce 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -296,6 +296,10 @@ int sit9531x_clear_notifications(struct sit9531x_dev *=
sitdev);=0A=
 /* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
 =0A=
 /* ---- Phase offset (TDC readback) ---- */=0A=
+int sit9531x_chan_selected_ref_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
+				    u8 *ref);=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_ps);=0A=
 =0A=
 /* ---- State helpers ---- */=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 8a5e3a1decd0..6bf4efd3c633 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -605,6 +605,135 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pi=
n *pin, void *pin_priv,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_phase_offset_get - phase offset of a reference=
=0A=
+ *=0A=
+ * What this reports, and what it deliberately does not:=0A=
+ *=0A=
+ * The ABI defines the attribute as the phase difference between the signa=
l=0A=
+ * on a pin and its parent DPLL device, so this is the loop's own residual=
=0A=
+ * error, sampled with the loop closed.  On a locked DPLL it therefore=0A=
+ * trends small -- that is the measurement, not an artefact of it.  The=0A=
+ * documentation describes the reported value as one that may be averaged=
=0A=
+ * over prior measurements, which suits a closed-loop residual and not a=
=0A=
+ * one-shot open-loop capture; the core publishes whatever this callback=
=0A=
+ * returns, so the averaging, if any, would be this driver's to do.=0A=
+ *=0A=
+ * The chip can also measure the reference against the local oscillator=0A=
+ * with the outer loop's correction frozen, which is a different quantity=
=0A=
+ * and the one the documented phase-difference procedure produces.  That=
=0A=
+ * needs the digital loop filter held (and, on the 1PPS PLL, the automatic=
=0A=
+ * phase- and frequency-lock helpers held off), which leaves the PLL=0A=
+ * undisciplined until it is released.  A netlink read must not do that,=
=0A=
+ * so that measurement is not offered here at all; it belongs to a caller=
=0A=
+ * that can own the freeze and restore it.=0A=
+ *=0A=
+ * Precondition, which this callback cannot create: the TDC compares=0A=
+ * against a signal the PLL drives, so a PLL driving no output with its=0A=
+ * zero-delay buffer off has nothing to measure.  SiTime clock=0A=
+ * engineering confirms this is a property of the hardware, not of=0A=
+ * SiTime's TDC measurement procedure, which satisfies it by mapping a=0A=
+ * spare output and restarting the PLL -- side effects that do not belong=
=0A=
+ * in a getter, so a reading taken in that state is simply not meaningful.=
=0A=
+ *=0A=
+ * Non-selected pins and a PLL with no programmed divider report zero=0A=
+ * rather than an error: the DPLL core propagates any error from this=0A=
+ * callback and fails the whole pin dump with it.  The core has no per-pin=
=0A=
+ * "no data" for phase offset, as it has -ENODATA for the fractional=0A=
+ * frequency offset, so it is a value or no callback at all.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_phase_offset_get(const struct dpll_pin *pin,=0A=
+					 void *pin_priv,=0A=
+					 const struct dpll_device *dpll,=0A=
+					 void *dpll_priv, s64 *phase_offset,=0A=
+					 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	bool drives =3D false;=0A=
+	s64 offset;=0A=
+	u8 selected, i;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * The on-chip TDC is a per-PLL resource that always measures the=0A=
+	 * phase difference between the VCO and the PLL's currently=0A=
+	 * selected reference; it cannot be pointed at an arbitrary input,=0A=
+	 * so an input that is not the active reference reports 0 rather=0A=
+	 * than the active reference's value.=0A=
+	 *=0A=
+	 * The sample needs both: the PLL tracking this pin as the poll last=0A=
+	 * saw it (locked, outer loop running, not frozen), and the device=0A=
+	 * still naming this pin, read now -- the device selects on its own,=0A=
+	 * and a cache up to a poll period old could attribute a live=0A=
+	 * measurement to the pin that used to be selected.  The device is=0A=
+	 * read again after the sample for the same reason: it can switch=0A=
+	 * during the dozen transfers the sample takes.=0A=
+	 *=0A=
+	 * The TDC also compares against a signal the PLL drives, so a PLL=0A=
+	 * with no routed, driving output has nothing to measure and reports=0A=
+	 * 0 like any other pin without a reading.=0A=
+	 */=0A=
+	for (i =3D 0; i < sitdev->info->num_outputs; i++)=0A=
+		if (sitdev->out[i].routed && sitdev->out[i].enabled &&=0A=
+		    sitdev->out[i].pll_idx =3D=3D sitdpll->id)=0A=
+			drives =3D true;=0A=
+=0A=
+	if (!drives ||=0A=
+	    !sit9531x_dpll_selection_active(sitdev, sitdpll, dpin->id)) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_chan_selected_ref_read(sitdev, sitdpll->id,=0A=
+					     &selected);=0A=
+	if (!rc && selected =3D=3D dpin->id) {=0A=
+		rc =3D sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);=0A=
+		if (!rc)=0A=
+			rc =3D sit9531x_chan_selected_ref_read(sitdev,=0A=
+							     sitdpll->id,=0A=
+							     &selected);=0A=
+		if (!rc && selected !=3D dpin->id)=0A=
+			rc =3D -ENODATA;=0A=
+	} else if (!rc) {=0A=
+		rc =3D -ENODATA;=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * -ENODATA means no reading: the PLL has no known VCO rate, or the=0A=
+	 * selection moved off this pin around the sample.  Report 0 so a=0A=
+	 * full pin-get dump does not fail over it.  Every other errno,=0A=
+	 * -ENODEV from a vanished adapter included, is a failure.=0A=
+	 */=0A=
+	if (rc =3D=3D -ENODATA) {=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "TDC phase readback failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The ABI reports phase offset in units of 1/DPLL_PHASE_OFFSET_DIVIDER=
=0A=
+	 * picoseconds: the integer part of the attribute is the value divided=0A=
+	 * by the divider, the remainder is the fraction.  The TDC resolves one=
=0A=
+	 * VCO period (hundreds of picoseconds), so the fractional digits are=0A=
+	 * always zero here, but the magnitude still has to be scaled or every=0A=
+	 * reading would be reported a thousand times too small.=0A=
+	 */=0A=
+	offset *=3D DPLL_PHASE_OFFSET_DIVIDER;=0A=
+=0A=
+	*phase_offset =3D offset;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
@@ -613,6 +742,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pi=
n_ops =3D {=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index b805cbc41fc1..0ba3c73aa3ed 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -283,6 +283,41 @@=0A=
 #define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
 #define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
 =0A=
+/* Debug register unlock */=0A=
+#define SIT9531X_PLL_REG_DEBUG		0xBD=0A=
+#define SIT9531X_PLL_DEBUG_UNLOCK		0xC3=0A=
+#define SIT9531X_PLL_DEBUG_LOCK			0x00=0A=
+=0A=
+/*=0A=
+ * Signal pathway debug readback -- PLL page.  Dig_Sys_ReadCode selects=0A=
+ * which point of the pathway is tapped, Dig_Sys_WriteCode carries the=0A=
+ * modifiers for that read, Dig_Sys_read7..read0 hold the sampled bytes=0A=
+ * and the trigger register latches a sample.  The TDC phase=0A=
+ * measurement is one tap among several, reached through read code 69.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DBG_READ_CODE	0xB3=0A=
+#define SIT9531X_PLL_REG_DBG_WRITE_CODE	0xB4=0A=
+#define SIT9531X_DBG_LOW_FREQ_CLK_BIT	BIT(7)=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_0		0xB5  /* [7:0] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_1		0xB6  /* [15:8] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_2		0xB7  /* [23:16] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_3		0xB8  /* [31:24] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_4		0xB9  /* [34:32] + sign */=0A=
+/* read to latch a sample */=0A=
+#define SIT9531X_PLL_REG_DBG_TRIGGER		0xD0=0A=
+=0A=
+/*=0A=
+ * Reads of the trigger needed to latch a fresh sample.  One returns the=
=0A=
+ * previous latch, which the documented procedures work around by reading =
it=0A=
+ * three times.=0A=
+ */=0A=
+#define SIT9531X_DBG_LATCH_READS		3=0A=
+=0A=
+/* Read code of the TDC phase tap, and the sign bit of its sample */=0A=
+#define SIT9531X_DBG_READ_CODE_TDC		69=0A=
+#define SIT9531X_TDC_SIGN_BIT		3=0A=
+#define SIT9531X_TDC_MAG_HI_MASK	GENMASK(2, 0)=0A=
+=0A=
 /* DIVN is carried as fixed point, in steps of 1e-12 of a whole divider */=
=0A=
 #define SIT9531X_DIVN_SCALE		1000000000000ULL=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
