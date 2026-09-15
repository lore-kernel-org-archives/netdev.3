Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96FD4315F;
	Tue, 15 Sep 2026 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430430; cv=fail; b=DOAEzk2i0p3IRDo4aBK1KQgNAnIn0VE7lHNdJ+aItNU6hzWPwVOCu7+FAUjtZfbhR32R91rj0sWGHHfwyOGwi/lvnajmCUIoKJF7TBX27Qal8YW0jnzxUzAv7VSeNIvu3Cge8vHDDB9hk422pLtHcFN6nkgK+3dzwDveI12BCCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430430; c=relaxed/simple;
	bh=ljdQIvsFUi48y5kzHWAmxyaOfnDhIUUR3jziVhcx3oE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KKqTCn331mMf9JFnUq7HnNwpw/EU6StEht2cEiWi9nLJW09E/K6Sxuf1O7PAiPfi/ag+zX0iG4w+GZU0C9TR+seyCYDU/7qoHqaAAws/0XlwNmKmmT5tbHTYSsXvuwB+PCR3MFOkmv9oNjEpQ6txlVdref9yd9aHZnbn/A7aZXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=onGrjgUT; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=SomU8R3b; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="onGrjgUT";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="SomU8R3b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=XgXZcYJsS8Qkdd8ARzjcVLbg8ZVpovsABxQ2FVoNhxw=;
 b=onGrjgUTjnqqwP2uS4B5jXW+Cr6ZR1n6eprhAEAA7cTks5p2uB9OGRIoUDhJNZTPw1Dx6KF2YupUkqPpTWvWzUo5K0+/1BGyp5qrZDRTyI7eOG+Uu95DvmU1o6AeVKtrHiY/T59wQxntxU7lhewng57f5hr8jA7Yzwfnj/XBtUWA+mQ3LBaWOeDt0uhdyHrF5vPOgxOQZZPmZxEYc6cdOeDVwanZoBmqFUcBgy3wBjvvt+RwXltQ09VypiOYG/z/Th1MmaZC+g5XRg0/iBmhbrsHJ7IswppYV0QlKcPW+JdR0hUhDwQer1IRmyXMqQviZWfZKmWQfYbQXmcnZCSQCQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 926A3100076;
	Tue, 15 Sep 2026 00:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4zBsXhu/sOmoS4GniIseBU3Xo7tsdz+RJJhFa8irOdY9WdZNyJsk+i83lBOee63N+k7t0P8enu47Leg5FVhkgpo3rvoYi5ih8LL8rIqc0g/Ru/5HNPxuNKmMwh+N92sSEKkBg4uXnQIYaumi+0D5beSruMDzQyvzd4i54IQyVAWfKtHobGtMAMFyEv6/eYRRKH2dtkh3qY0S7bj9CUQhNtD2/SMIvk9rwy4GnmcO889XSPcmrLjcmP5D8a9OJxhjLrIU43vUkxHCSxTmlHvdIeN0U1NVRWNy33Wk+VAh6an880P4gWHYXsXGOBXUq6VtN0RlM8UO4YJwbH6/ST8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgXZcYJsS8Qkdd8ARzjcVLbg8ZVpovsABxQ2FVoNhxw=;
 b=LT2/hmnmsQSEn6PIDxNP9477JrI1YuZdJzEiDc8kjy4xV1rrVU9jo8RkIRSJyVM4p4I50eR/dwKe+YvwFA83yROAwsSzU0ZtQ2sjmGDTupk2JPdzQeKfmz7I+4gSAuayf6O44JILM8YPhRmssH6Z1fp3jRQJdQxHkQfiQUC37CoQam5A4/F/mVyJge3lDnfHLiDtXWnyJBmWTwVLQpWf81K5S1tfINjCPQ7YWYVylCIlwAxChkZCfYGkXiVt9mR3QXgIryoioH0GtyD7FkCoEz2QXlCCZWulTY9iBoy/4RI8WgqBiUvhsYZKp8D4i8ofrFpLYoc7JPMqH6f4jWiDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgXZcYJsS8Qkdd8ARzjcVLbg8ZVpovsABxQ2FVoNhxw=;
 b=SomU8R3bL2ebC7xf0N8uzxA8fieClgPhtHV13tOl4sWpQUbrg0+QKF6iEBp0HxoH8waZKL5AdtvcitMJwmsDaDaMwZHiDCV4ipEdmf+nO/xLuEsqNEVT+WRiuQxRvNX8PiEKuqHibRCeCR5Rysbe9w77BOEjN31CKaHT7Rck4IXjTuq5UIB0juhekRr421glU7+QuNVqPUXPfa5zq4KXP8Upf6baItzrm+p6SWmRzjYufrCKtidEswhhxPDlbJ66suDi4dywTb6rbuj9f/AKp7CEfZvmzetd2VpdI8BuYxH/1HPWVJTI5ESbLCVZ7yXFBRSCtYI4Gp/+lcPHDTBD8w==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:19 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:19 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v9 01/15] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH net-next v9 01/15] dt-bindings: vendor-prefixes: add
 SiTime Corporation
Thread-Index: AQHdRKUwF2nwzO1gK0a/Z2oB3h1aJw==
Date: Tue, 15 Sep 2026 00:00:16 +0000
Message-ID: <20260915000015.80480-2-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
In-Reply-To: <20260915000015.80480-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB4277:EE_
x-ms-office365-filtering-correlation-id: 7f231573-7f54-41a4-161c-08df12bc5499
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 7G1JXK8AEU5vlMRPjUXWtPVEoSZnJ52mAkavbjBmEa80W9BJtnIGbtHGVr07gks97EEGz91GVsvazMGV95W/Azvk5vCj6CN0wk1kLKKUjplWqtAJsea2S7Zrq+9hDbv6ezccLYhKWXcEaDytp8d437fRqdqcXNMrw55DgGlKxYtBTg1J3k+in01jYgtPAIYvjuDQS1jj3ZQJMdio/LTpiqIW5+QbFvn08ALBavFb0ay8lICdAePeKcxHoDMSRha8QVn51y7Elr+7BoYTIJZ8GwS5csA61/sQC9QcBZhyUKyp8t3Pt6Yy6Pjg6NcxSoGWhgp2E7GpIyTzUji64Kw3hmsDJo7vPJKNm3r1mn1VR2TpKlSm+cpn6oiAZ+Rdn9iInkoJRFXEWgeTyhlgag1vhdDUDeguEHGnQnn1DjZUx/H8lxSa7xJYMR0M9fVzJr79bKdU5sbfHZ39B9qM/ko08JSIo6FXH3FosWM3vMHd1/fwWJuMUJlj4AfLad7cA0yVgwpTZADKR8nMx1dkK9Q0zM9+xRKmp3LJS5PLCxpZ0b4HSOf6FORCnfB5HSD5na101k65PvDRJfhOcRswwDR6SLFVl83EPFI2DcUZ6dnYwh+GCp9TfaX/wNFZkP+bR6borprmLATZvafWP86rQVQ1aArNrb9KQUFY4vJsiyXulTVpiM53dq9W/DjWWkwYr1oP5Nb27OwjkupPUIXhGuU7McTfwodw6xpW2Lxop4xNz9U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AxqoTCQW6xpjbRMEs0oCko82mQ7WwA6Wv17Q5ATlkoU2675RAbOmMGPvA5?=
 =?iso-8859-1?Q?qgR5ABeondtfLGsp4GJm7vFK5pwYIoaeSzvrZSQbdt8NaIWUQWb0EJUJkQ?=
 =?iso-8859-1?Q?OzkcOsb2oF+r4eFqhfbn0HUY2Oo00SXM0h0ht2Ow1zFEhrEtC19YxCtR90?=
 =?iso-8859-1?Q?F7idQWFADI1wCx+2oW7ZvjwNkacnmzYiDqAzN/Jgvtpb8JbB3+/Q78mpEz?=
 =?iso-8859-1?Q?WbPYFRxrHjIMsq7CRjUyzfCAZ/pELmq7o09QsPif7CewMiTY+rEWBv3B4i?=
 =?iso-8859-1?Q?YBB7xkF67lTO0rC8Kqc8OTG+MC/Opi9MfqRggDXzvh66Z5dnRvulbuc+hG?=
 =?iso-8859-1?Q?L/8pqLHn1fHmPrcjs/tNgoMNl4Fg7kDHl5H8OWy81rIM5neYTTIB1Ez4o6?=
 =?iso-8859-1?Q?ThlqUIMzOHCshYZX1Ljt3AOPwZKH7e5+UePHqd7Aj3jUqXGuzuO8HFsjBD?=
 =?iso-8859-1?Q?XzdRAAF7/h0M6cu9Fz8xyhV1QLfe2aeN/QhaBBzCs47mJUa1drrKFlCsY1?=
 =?iso-8859-1?Q?2/E4mtHvG56Pi2da716pzvrHk/XCGBKGwxx6v8/FshesGM7Sp7vJAMFKyI?=
 =?iso-8859-1?Q?3X/fNxR6IOcNLfJHmEEAGCGKRJRisBPZ+bUC9Y1E/52BeheiOhBITa9vFA?=
 =?iso-8859-1?Q?OygSGnhZXQr+48zyAZgKFjT6h19yn5nvJtG3TynAopadx68JnE0eAJG5Xj?=
 =?iso-8859-1?Q?G5Ovhf4+84O6wZwTdbuZnBK3MFVRTUQ53NU3z3ig1120E4ZxtbOw2lBrDl?=
 =?iso-8859-1?Q?6vvlkQUeeh3DKX3zGaj7PGTfNG13EU3R7wZyh+4vI2DA3NFUQqXyYJLLPi?=
 =?iso-8859-1?Q?ExmZshRYKvWCOem/kwo2jz+dDbtogciT3AQEBRzdL0sTmf+rAPDWxz7bcO?=
 =?iso-8859-1?Q?B8PqzZx3QbV/onTS4kc9lDRpJyKwd1Wg+++s+VQOctYS9mLzpK2kLavmW0?=
 =?iso-8859-1?Q?TyN/caTNr2yrYH3khiEeUwQ8ttK8PjTcZEMO0g0+b2Tov2wNdw7fQuKzoH?=
 =?iso-8859-1?Q?4QHZlRjxLYcSlFb9eqKYbzsGhE/VNqua8mWmdA8K1XdSrbm+zmkqJn/wy1?=
 =?iso-8859-1?Q?UFo6GMRNpDI4BcWKBXN+5XYASLzXd9oQAV5dciB4SZFSGSctT9EaJcdcR9?=
 =?iso-8859-1?Q?LALb2zwU3TCFVEqjYDI0adEEjcczKpzMQqUdB5mCRlm4JW8y+j4xLlNdGf?=
 =?iso-8859-1?Q?Z/ss6vRh8YugkyqKcWgEle22DWkOGSlPWoub0u9ICsFJMc1rFSUxt95zdg?=
 =?iso-8859-1?Q?/ny4CuHoNiRIOOP4Cl5sG3kkm8vaT33damroiTAxUGrDnS7xlBJsuTHSmg?=
 =?iso-8859-1?Q?KX+Fadf4rpj1kIQGqWZ3eXTuPGAsHMpZxQlkvlFH5fQ3wwLlBvbDI7mPc0?=
 =?iso-8859-1?Q?JgK5baDQHM5Jf2mySDpM9NXxUkhQrzp7AdD8bWdQi9ic3eL/2C8jCYHiYK?=
 =?iso-8859-1?Q?L3ftr1/CdqKU9/8Z28gxlwxhc87IHi7CMlUTEzIY58VBWdyZSTcvQCU8+k?=
 =?iso-8859-1?Q?m/qWLjS219HIFfvEe1WiFCT1/OQYGgvjfo4EpWe71ZVxH7mLJ/KBwMf2vV?=
 =?iso-8859-1?Q?7bPU06jNIS3PETbQlepONbh1k2tZ7ScwpWfNgvrmQUC3S3MGvpyyvgcGFy?=
 =?iso-8859-1?Q?Ez6ATqY1B0zHxU7+Z1xpxKAgwdF4E+Owz55X6lXeAuJzLgW3t6tIw9vBll?=
 =?iso-8859-1?Q?0cVkES86yvT2I+xw6UkHakG0o6WPhQItrJMeKC5+utrHFVK2s6kYN3PPZe?=
 =?iso-8859-1?Q?tQHJPNMkQ9RPwvK1ku2lQH/oCsCnUXbIrw21NHUrb53Fa3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	BGZW2daDZ3I614H8DSP6go2gaIuauudAo/EcilVF+4VPi/2YH7Z26zKZcJgSQ8X5KX8HJILflI6A05K+sHFAe+Knanc8RbFJ5GD3UV30GT035ZdS8aLJiNOi9f9vBX4YBCbLX1Wm8G3vdx+ThuMTzhI34QyLAnZGBpRk0MXO0Zt2pUwogAGncuefVNY03ewEG6mBEKAefS3/Tq8p6syNnFDRpdfPWfsZ4PmTy10V7jg5jajwrUnQ9766vrqrOoamVj7TSk1pBWz/oN3rjDJzOBwBrOhQ4cKeXAvO6f3Hv44/mb0jHLT0SaU0xLGjzPXE3G6RZNJvIp/4ikXPqvyqqQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f231573-7f54-41a4-161c-08df12bc5499
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:16.9069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5X6/23SKGmg3yc+CxuezEbhi1PDiKtFNSZPpjlwm5t12q/NMjUosw9eR+tKCo0blg4dr44r//UFnnpw6XNsxFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430427-kSb61dGh1FqS
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430427;kSb61dGh1FqS;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Add vendor prefix for SiTime Corporation, manufacturer of=0A=
programmable clock generators and MEMS oscillators.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Acked-by: Conor Dooley <conor.dooley@microchip.com>=0A=
---=0A=
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml=0A=
index ba2002969373..65da27d6e84d 100644=0A=
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
@@ -1563,6 +1563,8 @@ patternProperties:=0A=
     description: SiRF Technology, Inc.=0A=
   "^sis,.*":=0A=
     description: Silicon Integrated Systems Corp.=0A=
+  "^sitime,.*":=0A=
+    description: SiTime Corporation=0A=
   "^sitronix,.*":=0A=
     description: Sitronix Technology Corporation=0A=
   "^skov,.*":=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
