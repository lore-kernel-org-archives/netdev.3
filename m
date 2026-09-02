Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E241B8DC;
	Wed,  2 Sep 2026 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385263; cv=fail; b=t1E0HFZ2WDsxVHif4w+YksOBHZwXjM+7up/O3c4TgchclX/JfO7a/U0pO8zIueYjnVBbnjx99ig1QJ8iQ/eiXYiXgN3id4E4h1IU2q2B04dR4WQmYZPKQi9H11zRcvLqSX7SVcOqJal5/544fMkbviQLqStrspmeT/h760uLCQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385263; c=relaxed/simple;
	bh=1a+7VaHUZ/C63FHrlnS6I6hH8TgW6rIW/EqHEFHLAJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tn7DLMXdHS37JNAF7kjACVZKsN3j3nYfj4uAJylML7qmJIwUFC/gsyYSS4ugrsQCm0fd9Mno/TKa8TtwjvzyXI4OLkhjni7atQp6RecrZwJ68wEXbvuJm5Bc8RzPmbeR/yh4uHyh98woVm1fisoWk+3jF91w6ICqsbUqhxYM5Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=ZSYeRqpm; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=oQ0SCG8l; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="ZSYeRqpm";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="oQ0SCG8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=kMddntS5dI0/s4sDGUTyP9b0pkYSuWALxVuPlvEtIuE=;
 b=ZSYeRqpmWSoxZAUD0GbhtSz8nCph0zcf8mdASLS+4BmhqC/ZpRCra0kuU7zuKpxyii6SnoIFQr3Nx4PjYTen7vmllbOrEVaso5yPSVIVsaocedX6FBs1iCublMe2r4z4o06F8ZVs/jOHS4FUT/UpmF+Qxwo6i+A9XBUXTCtnlfQt3wrAfsxwXe7YTILGT2tgp0xEswj5l6vktJ++eoL/RrgxjvOtQYisS1Wqi2dh/a2bH1H6KX4iP5urf6vIlINb82Px3YoIdXTfD9ND2WfzxgyfZyNiotb/2WS0CA7qmjnkpxZayXO1awQTHhHVyg+aM5lGcwS+p7gH9BXR/fKcOg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1E9A2240065;
	Wed,  2 Sep 2026 21:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsGjScq+YktjKoExhVoXpwZ5Az0sJXIt0+xuK4V8BoRZHmp3Atc1dIto9+juO4KEMyb7+WjXHgR5x0wqzAW9qcbt5NEluo74noE7gZ4eqxLZ7JHx9B5LADIOMqPNpQdLIMv5K4fv4HWxW4AB/bhD40TOYdQHER96LZ0y7stNDsxa8iHw0ue7qmMfwVPwruZHcvMXL0jJ0us82CL6KmKP1sFvKB9tUE3Ai/Sl6g2JC/tJS6JSU52lsz27LNJ/EKcQvO36MOyhUrLqMpVw/jhqRzl+zZEsYb+SG4Wz4HLPDZClHU//U00yJdy/BxVlpB4Q7T9vtaIVVQYdDkrIohUy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMddntS5dI0/s4sDGUTyP9b0pkYSuWALxVuPlvEtIuE=;
 b=rZKhJxjOUhuG5EkOewhvrpeEGswgsGbYUU9RLwbBUWvZA4DU/XwQJxsJCVYA/+w1bOFTy+3oubbUIvquCXC/eJP1DRKGz8dq+zVtO9e1oLMjZP2fXVwE9GVeupmccUQ91Q/zl6Sf+w4IaQ58++7lOLoTBLjC1nbzcJO3pCbC6zT77dYB1a95UNjhdMNSZU8LRYiblD1Z4/xiHUXEVIDys6LKX7YORHrAijBINbGil7zShmhWxV8bv9L5EL8zrJqdbr2UcQQWEQ3IPmFXeHK2h2ry1Inf1d59S3HbM9yXzUj4pcGN4KpWfrbVNSOjtvceDpYu0SRhzQPutCgWR2WOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMddntS5dI0/s4sDGUTyP9b0pkYSuWALxVuPlvEtIuE=;
 b=oQ0SCG8lcz+f/uQc8gjE/aTRd8kJXixMjESYyFCyF8kvZcHGqiiqUl9VAGSbYGwvJNTG4YmwjlujKtp7E/fMqa/BvZ1HQB3KdpQntdCaPi2v20mdCnIlCbPWYZDPViPIEv/1O4PHbCxw2me+2WE5VWyBeGib4Mdj/w6Pf36rZLZRQowLRNofrvIIkGNTAuBSfJ5eW/0hsIukCkaQ7dhHHGG/vyZ8pfDYE6uZ1S9WJ/PxjgXeBQHW2mGIJYqqzbsH+PVse7eTZDb2BZ0bsnDFdH6jUAbiAPVEMruPBNFDveIuHKCJV8kX37l9FkR6rpQc+ysN+ryYPO+eY+93R0hIWg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:37 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:37 +0000
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
Subject: [PATCH net-next v8 13/15] dpll: sit9531x: add support to get
 fractional frequency offset
Thread-Topic: [PATCH net-next v8 13/15] dpll: sit9531x: add support to get
 fractional frequency offset
Thread-Index: AQHdOyOxG3yjaFbvnkyfK1qvIjRTJw==
Date: Wed, 2 Sep 2026 21:40:37 +0000
Message-ID: <20260902214030.20955-14-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 207f177f-bb03-4c0f-e0cc-08df093ad3d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info:
 XvZSMSq4SB3aKdJb4Kr1WbZfDg4vKIEL7FevAqoZ0py79YlL/GJWViTIVv5EocAYNMGbudevQ1K8cPWL8sLyMwWCvzn0QxkMniY/TtOabNm7xt03BUzr3TI4qkjSb0aQJo+HEB2tjnjOX7GfTdvIKWHr9xW9YUiSro2A9yNHi8Dl2ZL19BBbv5Y9EZduQq08Z9KuvGCA8lCOp38uNiEH6bMJu29/4QYrljEzA1WudJBtu76qhSQOzTcBySGth8kNbLo8grLu6+X2ZMhF+qNMMFzklhW4DxVvlSDdUkhtaKgyHAP9UN48YY5WrWo5cLqNztVBGYFr/iuYxLJ/0a+P6h4P4zaZXHxHNxLXmNQC1XZEvvyg+L+uxdkUAPWbTvwiYk1Nq+eCv4A9CP19kfZvWgTx62GCTDIvoc5XpwvggMWfGv6PYM0vsLBOXzwNgRMLxYB7YATAub7woyRHVp8COuAaazR8Vxkb1fQ+lj1qMtSKMB8sLkdUwW33UfZSnQYWCFqI/jp7y3kRjbDAsAcZA3zkRIlwFHguXJIePMQLpRC99TzfMNaS/rqkOnqygJS1/29qEJW8Vrihvzgz6vBhrQ80CMWNnqlMZMBrMXh0TXy9c8AwyROkdMO38zA7UApTa4rALZ8GTM5GxOg7NHlmZx69K26DBpTa50O2hcunlSecIihsmn3Nlvyj426snjPTdG6nu3+bA28qK25sQt9fcqxY+gf2WgZsCxNbwFCqdQE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9wTQSoz60/LmqK6eNnaEsO+Ac9sSHxzoklCmAlZWcm3CHxXsopMRdevVqT?=
 =?iso-8859-1?Q?Bch4nZzpP/EADCPe/aW1vsk2bbFIf7NHwbLsJb6OfNYClGunvWqn9g1Mag?=
 =?iso-8859-1?Q?ddUstPKdwfMajJJbXhXfp+lX2NHNAk77HBd4vyazBNho2EHDM5fzf3aJtq?=
 =?iso-8859-1?Q?2aEFlbWrWtEPezBkoC0woB4vUb2Jkz+JCf9iu8OIEy/SR5CYI7itcTuNAu?=
 =?iso-8859-1?Q?+canIjFMGSLCspo9lKHqy3ixNYl3XDnyIpEO/WAqqBgM6qBF1Y1o/cwnH3?=
 =?iso-8859-1?Q?6Ec0v9E2rBtiRlV74Qk0kg5O7dsgs9zJC5CNtEzCsDeFMNlQP6jPuHc4SR?=
 =?iso-8859-1?Q?ICQXFC98bGhUSfZSAkSnx3II2YDe6LZCWQ9SqVis5DwM60O+jBYJd9fXEy?=
 =?iso-8859-1?Q?hQrda/1JTnODZR+Usj0Ns9QAd+QNwBsbk7Y0OfVY7f3K+/hsHLMqpZgO6X?=
 =?iso-8859-1?Q?9CJrC3REM980I5FrXHFm3RBICZOHAN0cMadCY+YM/hoeNmbxXpCAmv2FLi?=
 =?iso-8859-1?Q?gSED1RXd4AqFj/bQrol82gpiK4CucjuOpIExGijF30Q+wE92K3zbm3yokr?=
 =?iso-8859-1?Q?ShgRIW/R2VmqH9aH4CQaJhOY72DsWG0Gx3fTprxDYCG4ubOZ463RY+P1qG?=
 =?iso-8859-1?Q?+SWpyiHS0wQliRS27V7Jo1p+bkcK0pO9oEUcWmJpDFxFZ2SDIJHMLlCnl+?=
 =?iso-8859-1?Q?mqwpB5T8EtC7Lc7TsPcmmz9s3tEOgKhZVMqdONFIdEToSXk6cpRTl6iFCJ?=
 =?iso-8859-1?Q?VLE5dSoHapAlTnVx+MhMoXUB6s2U6z/zVBCIp34d5bMcKHcqRnni8RAjq4?=
 =?iso-8859-1?Q?sbizIHiehaZnbrqlordnibNH/AmXHchA0x8MAbwf7zZMGt08DEGP1oRRwy?=
 =?iso-8859-1?Q?N7X0vu9V9JibEx90SSL9i50tCKtFsd9SgQXYCk/VIqcfMoXcZdks9Iga8T?=
 =?iso-8859-1?Q?mRQchSJG96NCAw+ZcmxeT0uoZfsx3tYaKe5vcacsYjzbZNvLDGWwBtoBrf?=
 =?iso-8859-1?Q?E0Qhs60WIXY/twsjknP0/dXTLlvyn38AWy7JUaGroZQbW8BXoSXGbJ58/O?=
 =?iso-8859-1?Q?dH2B1aKMv8k9ueb6/W5eII/dD5F4gV2ooOmON4+Fc7YA5onM2VSjKVm3EY?=
 =?iso-8859-1?Q?48AFT10kAZ4CpurZqHWzi8N1Okh4gXf4MQpg3LmYPOu49O9lNQeI8maIZl?=
 =?iso-8859-1?Q?2aP73fb1i87OF9JEOxcSY9TnlaIexhj4TiWVCjhOaO0TFU2ihYxaHj3AMY?=
 =?iso-8859-1?Q?UPUtzxBwc18d2HVcLXPSOEY4ImWuu7xe908vwnTw3C5ftEuklNBYw4SBlt?=
 =?iso-8859-1?Q?Ilwn1YaG8yvW+uiL2LAso6Qv7GCIRaYZgd5KYDl7HL9MgozMM5AJaL1PnR?=
 =?iso-8859-1?Q?JJeK7NK9nY8uQYTnJJud9dY2aeht5e4GtU2D29LsP1hSfTo+8PkByOm7rJ?=
 =?iso-8859-1?Q?xWYArAXrlu2uLzUnIkaVVZtOa/Qd+r8mOa4TTX6M4dsQrBvIx7LQv49XTt?=
 =?iso-8859-1?Q?JnwW4KWkP/dwmWSiwOzlfmjSbmYIZ5k2zlc8FO0VjiMCByZBA9dpYylEJ3?=
 =?iso-8859-1?Q?SplhSrc+8n7XEKtL3ZTGPEhb+5jC5iiP4uNj0qXsLbGfnCaYfsRxqHPw69?=
 =?iso-8859-1?Q?VGdLgtIFbik2QSMv5L0JlLv4QA0XJfOC8A8pR0it0iIunUHOkX2+608ddu?=
 =?iso-8859-1?Q?yHzjOQc+KUI4YNeXJNTKoxHhIvFtzw6Z5ZlPW1MJwymDVk+/NAChLM7bR0?=
 =?iso-8859-1?Q?iyFN8IRjNmNH4sU9F/QN/2COgOPG3OT7zc0JSfvUcNBVs0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oFLOIfP2bGrEuULsHDxH5ViHtIZZ864f0KebBPzw/Mj4nqIzH94vzgGM0zocd17+D0b1+mzTgo0p+o2xvQDYyYu2/7UGic3kFuGJXw/6xnKQ2YoLOKw1Y8b8aTqwmFmTglgaSGr46I7wSScqVY3N9yb+ztVoPUSBauzLYdmcSHZ9fcNpWzrXkz+df99wRVTcGsFGyRANttyAxqqfZEBxw2JSP2Iuns4H5DVWmnHkdpYCaEn99o1QAl7LrkOS5jQCW2yj8BojOo5O9ofCAEScIzWGfGqJFDG9QGTyDRdHTFUOWPcKc+mhJBEo0E98M5+zJ96pEttESFfzGjAfip/pXg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207f177f-bb03-4c0f-e0cc-08df093ad3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:37.5945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/mByl24bYvWiwrDGthRMhmmq23htHUn+D+pYrOcCxMb8kKGJxSjIhitH9LUakR6vcuVLeP/cwP0F3JC6T+gFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385244-dIrfGQTTJOzk
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385244;dIrfGQTTJOzk;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
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
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 151 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c |  47 +++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  12 +++=0A=
 3 files changed, 210 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index f552a9c73796..bd251ab60eee 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -931,6 +931,61 @@ static int sit9531x_is_xo_doubler_enabled(struct sit95=
31x_dev *sitdev)=0A=
 	return (~val >> SIT9531X_XO_DOUBLER_ENB_BIT) & 1u;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dbg_sample - latch and read a signal pathway debug sample=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @read_code:	which tap of the pathway to sample=0A=
+ * @buf:	result, least significant byte first=0A=
+ * @len:	bytes to read, at most SIT9531X_DBG_DATA_BYTES=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+static int sit9531x_dbg_sample(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 read_code, u8 *buf, unsigned int len)=0A=
+{=0A=
+	unsigned int i;=0A=
+	int rc;=0A=
+	u8 v;=0A=
+=0A=
+	if (len > SIT9531X_DBG_DATA_BYTES)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_READ_CODE, read_code);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Reading the trigger latches a sample of the selected tap.  Read it=0A=
+	 * three times, as the vendor phase-difference procedure does and as=0A=
+	 * sit9531x_phase_offset_read() already did: a single read returns=0A=
+	 * the previous latch, so a caller sampling repeatedly gets the same=0A=
+	 * value back however much the tap has moved.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_DBG_LATCH_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_TRIGGER, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < len; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_DATA_0 + i,=0A=
+					  &buf[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * DIVN as a fixed-point value: int_part plus fracn/fracd, carried with=0A=
  * SIT9531X_DIVN_SCALE steps per unit.  The scale keeps a whole DIVN=0A=
@@ -998,6 +1053,102 @@ static int sit9531x_divn_static(struct sit9531x_dev =
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
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+static int sit9531x_divn_runtime(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				 s64 *divn)=0A=
+{=0A=
+	u8 buf[SIT9531X_DBG_DATA_BYTES];=0A=
+	u64 fracn_raw =3D 0, fracd =3D 0;=0A=
+	u32 int_part;=0A=
+	int rc, i;=0A=
+=0A=
+	rc =3D sit9531x_dbg_sample(sitdev, pll_idx, SIT9531X_DBG_READ_CODE_DIVN,=
=0A=
+				 buf, SIT9531X_DBG_DATA_BYTES);=0A=
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
+				 SIT9531X_DBG_READ_CODE_DIVN_DEN, buf,=0A=
+				 SIT9531X_DBG_DATA_BYTES);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (i =3D 5; i >=3D 0; i--)=0A=
+		fracd =3D (fracd << 8) | buf[i];=0A=
+=0A=
+	fracd |=3D (u64)(buf[6] & SIT9531X_DIVN_RT_INT_HI_BIT) << 48;=0A=
+=0A=
+	*divn =3D sit9531x_divn_fixed(int_part,=0A=
+				    sign_extend64(fracn_raw,=0A=
+						  SIT9531X_DIVN_RT_NUM_BITS - 1),=0A=
+				    fracd);=0A=
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
+ * Return: 0 on success, -ENODATA when DIVN is not programmed, <0 on=0A=
+ * error.=0A=
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
+	if (configured <=3D 0)=0A=
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
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index f813126077e1..1a14255e89a8 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -528,6 +528,52 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin=
 *pin, void *pin_priv,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_phase_offset_get - read phase offset=0A=
+ *=0A=
+ * reads the TDC (Time-to-Digital Converter) hardware=0A=
+ * to measure the phase difference in picoseconds via=0A=
+ * sit9531x_phase_offset_read().=0A=
+ */=0A=
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
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * The periodic worker updates selected_ref under the same lock, so=0A=
+	 * test it here rather than before taking it: otherwise the=0A=
+	 * reference can change in between and the measurement gets=0A=
+	 * attributed to the wrong pin.=0A=
+	 */=0A=
+	if (sitdev->chan[sitdpll->id].selected_ref !=3D dpin->id) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return -ENODATA;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_pll_ffo_ppt(sitdev, sitdpll->id, &ffo->ffo);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dpll_input_pin_phase_offset_get - phase offset of a reference=
=0A=
  *=0A=
@@ -641,6 +687,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pi=
n_ops =3D {=0A=
 	 * rather than a port rate.=0A=
 	 */=0A=
 	.supported_ffo		=3D BIT(DPLL_FFO_PIN_DEVICE),=0A=
+	.ffo_get		=3D sit9531x_dpll_input_pin_ffo_get,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index aa60be243e6d..98425c04d3d0 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -292,6 +292,18 @@=0A=
 #define SIT9531X_DBG_READ_CODE_TDC		69=0A=
 #define SIT9531X_TDC_SIGN_BIT		3=0A=
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
+=0A=
 /*=0A=
  * DIVN carried as fixed point, and the unit the DPLL ABI wants the=0A=
  * fractional frequency offset in.  Equal in value, distinct in meaning.=
=0A=
-- =0A=
2.43.0=0A=
=0A=
