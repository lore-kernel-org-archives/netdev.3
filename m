Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAD394EBA;
	Mon, 14 Sep 2026 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426856; cv=fail; b=VWxel/DGO+bcbS/m+V3GXFODzvjRds4SiH9QGcbJgSjJlu5C7vOdij1jYDw9YNXhzfJBU/O1Y4XkTKPWJIFosdUKItV9/Sq8aJuNts/gSQUcP+agvD02hkR2eD8eX6nO6SLdthBOvXjYvYFzy7kayMsnITnGvDpP8oa29aoqIio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426856; c=relaxed/simple;
	bh=snf8lJhRPLstZRjro3gM+KqyXVk3lecxf6J0V4YKiOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WTkGERElkE/SqGnZ3OV9IfvuV/LutGvP4EtFvdOZBj2e+wpRfq7KdfkBVRkgwC81t0xs9x7NTPxmgX6AlvJvG7IWtvSN8R2twwmhw+gctENgdE/iOPjbzFOOMtQ0TPWJHN+QrcuP4mCTYv4hwtkNaaBBtX7a58QDxQFOMszoolU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=hhagIwqp; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=efSA6jug; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="hhagIwqp";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="efSA6jug"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EFB2C1C625C;
	Mon, 14 Sep 2026 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=IjRukBej4kFFJOoQInh+sxd60kjASkA/ccKPaQT4gYk=;
 b=hhagIwqpQAPP+RijyYaEAaHLVvUIjouX9lArhQ67EHOrgqDAxPu/Wvz5SVnLyktAwj6TIsaLNbgMvB2pWq6lrsmsSxn8eCxQ0EArkUV1FxjojheQPwQaj/PSFp0bAKVRb2wdetOAsGyIiFWvtOfdjbmYTOjpvMDar3BovPsqpwKV9B2Sd5QvpU0iSYW8YVk7zalx+kjdmFtu3GKYxoMh4pJB+wI3P1rm2FrZ9qsgCDbH+/wGGCKueJXv+q9BmSkc6Y2meM6v9u1hNIn4tJJTSFzv/+4JhhMzOg4eYdopTWvaU0fcnoKCel/p+1ssxC4cyMIdkG0iWBbmUp9NiKSaMg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021086.outbound.protection.outlook.com [52.101.52.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0041594006E;
	Mon, 14 Sep 2026 23:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1gUA8tnBiSs3cG95ifDyiYDo6+dEojxfk301glmai9zIH93LbNgBV3baVtAwlep6r8tguOSrjlNFdDBhpFHYkCXCQj4yB99bNCyshCDvAjs8+nJT81VRFS3O/rQ4vWi0KmbBY+OBs+q5f3BtUfveuB0b3Tf0B7IxtuvDIdSds77cdsUHkcgjkGQ2pimtvruDHHA3DVouRSbpE7gMxuBFWtX1lngXzm3Mre4arbl57m+DDY5BMswdCtRDBa6o5Jb/hxMb2WkjWkG96IpzFPkubMtNksMP/l2LwiJQurRGsX9LSPVO00QzB5+kztmXvKf3RO2prS6S4MrXLEuqRP6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjRukBej4kFFJOoQInh+sxd60kjASkA/ccKPaQT4gYk=;
 b=e2spRtWdurOFAB+9Kd7HgIBAqgLgRBmWI5zVcoj9Mm8JZeF15MCvCadXwDWW5z1Y929H5kAh5W8VjFSHp6y9e29UBettlKMbnsKwOxugSStNDTdgPzfDj9LJ5UrnCFf86i2olNpjpEzceSOz8vIjOUrlYThkZQ/7Z4jnu2e40yIcAbxx7iF1bGdj6pQZXrH46KSvRluzooT3jwZth3sb6iNj/GOxDxN6khfWq/ZKyAjKrrXeR3z3b1mwiQNaWevJaeHmSVUcoTIVI9pE6HNAYGxPFKeDY4Z5kHP4/JwgJv6r2Ob7ZGQzv0redCWwmOcvaJqHk4r6w5dTMvOVgUc4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjRukBej4kFFJOoQInh+sxd60kjASkA/ccKPaQT4gYk=;
 b=efSA6jugNbSjHoEZ2DQZw4SlUAy3T9x4HORIIkNyKGurremuJCWXBmlG4elkz+809DQ5lnmUVj7H9KDOnHfVwgshQ79syoACSkFOSzzdGQ4AaTYESYlWJdVm8pVwL52euEWCD64cmWfn1J2nXKafvLs2Cn02+Y2eGR/uaCt+NsV8U0ATaLFKpWCpiXbYUehQq/MPByFf2JEcl0/B+Z6KWvRygdy83PkSJXbG3J7LBMF6088jyY9qjdgZxAYN+rc42Ju+zf4ApoKf8RlSffByBKmIYWhGjnz7k96cQCzl8mt9/6GAFrctOgg0j5QAd7xKvAE8Tl7w6qllnVKfyZaLRg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MW6PR20MB6839.namprd20.prod.outlook.com
 (2603:10b6:303:23e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 23:00:39 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:39 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 06/15] dpll: sit9531x: implement input pin
 state on a DPLL
Thread-Topic: [PATCH net-next v8 06/15] dpll: sit9531x: implement input pin
 state on a DPLL
Thread-Index: AQHdOyOv4Fp9BWvewEGjh8Jw9FVnyLbEqYOAgAoZ3AA=
Date: Mon, 14 Sep 2026 23:00:36 +0000
Message-ID: <20260914230034.63861-5-arouhi@sitime.com>
References: <178887151547.219967.15430227040039289728@kernel.org>
In-Reply-To: <178887151547.219967.15430227040039289728@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MW6PR20MB6839:EE_
x-ms-office365-filtering-correlation-id: e890f943-1fa9-459a-5bb3-08df12b3ff01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|10067099003|56012099006|5023799004|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 CoCY5xt4rOINijqWwiwtL9KT/THo7JIB5lFpFZg28VWM225OSEsKd2Qqfd8HJ4orHuQek6voWt1i91nMq93cVM9d4dC41/eDuK+AL2AW4I/evb2DThxH4Zkx8xRvN9FoxspSysJyAOUx1oJoj8ffl4yO0KqR5JffL6sZtJm9REx5HE0lcssc8ciw/bGeOC61f6Km0aTJsbta4/3V0J5bCw1j/UH6yioJOYy06iYKabNI9AJcYjjt9gJJoMIh/OvWC10e19iKjVa+sN1wSqhmgHWpsWpJpqX3NtKxXZoo7S7y+LKrqX9elp4PnahJy36N+sguFAxUd608f0AaO5MEHW+5jn5XbnLUb0PjRxXDI+eeCcZjoiLZ6aSoXFsizVCpOQ4T+Q/nnFXGkHLmI0TxLB8cnCyu/WHfa8O8ScAaE4wzyvWytfGWwnVDSF7XJo05kF4+DWwV5R29AObldLpI4hGfL1cbwGmbuqykoX2UElMjOXf8yWeGhUxXpeibbY3fWG5WvCM1EEFujnuiJfhKcHjQpTGwbZI9B+meYA8B0QJXCX1sEekrBqT0J0zytUVyQ5NvEnlO62qTA/ZPzGY2oeM45gScOk61CTxlDJIRpSVeeSoXqpYhNT0yHpcET3N4BDbOlxleNRsecUX1mTqjfcroMQ11uIy+gpiHmAorrrU0zp6qW41sj7GE1KnYnAAeyhLm8s5MpPyicwJ1oQZDzspIIEPo6N3mLs4sG2JNjfg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(5023799004)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?z84COJxV1XCcq/bb4U49MaUSIQMcwBOCVAPFnrScYHmpepSkWsz9NL5sHC?=
 =?iso-8859-1?Q?auE8DLJpiBra8jNbRBhViCf6b2JTuuhm1dDtogNRo1/iCWrhCxTsEkdsOw?=
 =?iso-8859-1?Q?n0Pp+nvG7SHscuhw/wo2qj5Ery/dvoMDg/vkTKntEesko5fNM0U/tSKH1v?=
 =?iso-8859-1?Q?zBKjs0Pg8j68vV3YHpPXsFKhHynKs+G2BLXvQHhM5Ilw3vDJ0hRpUmErsL?=
 =?iso-8859-1?Q?lTK6bT+pk2SOSRzCZFXODzVKsbzRz4huvvolx81KPklbtIW2inRYnMBBLU?=
 =?iso-8859-1?Q?2PScaG9yTZ14jxy8ySmG1Hw6s/MMV/PfTJ9p1bLUCinbiphhO5qphA7l6p?=
 =?iso-8859-1?Q?8M8hcbP/7qfaSA4rkhFGiLvhAFVS4hevzEvRYs+sYJ1KxUSQu3uUndUqmr?=
 =?iso-8859-1?Q?sr+ppoQHUmmZiA8VFqxGejIBa+q1CX5LLV7r/8fFd4244M/kfgZhfmTysC?=
 =?iso-8859-1?Q?ULvEL5nkZgonHbrcRIAHT6xq6wbUdO29JGLsccXZc/JrmK33hEGpL9DvgU?=
 =?iso-8859-1?Q?hFRz78UiWjvB3CHekCVeA6LFoRvIJSyelOjT1Ky5BUXm0cBYSsxVGoJoPa?=
 =?iso-8859-1?Q?0gAsb1U1GJZtWIEASB/UfPpqHp/YIWIklzQMPm2aoUPTv5AHjBdL6LEetP?=
 =?iso-8859-1?Q?Mg+1BlA9EexwbfZcv0L8W59k1fF2xLTKFJbSDuXtP8Khha3w7bmFPAGkse?=
 =?iso-8859-1?Q?LqOskSMyl0Dwuqhmj4AE6sp05Y0a+0dvXmLVzmEzWuHmCyCogXy5Louz85?=
 =?iso-8859-1?Q?bkxbc4ZzhwqH3cdooCIsPVgjZrS+GTtHVZ3nDdL4WPi4CIcGUXopSXTK96?=
 =?iso-8859-1?Q?0Xlj1hLrGl6yTh9HqoLDudOJmfkqI8xG4J/BiBRWO8tRuCjlKdY9TfY3Y8?=
 =?iso-8859-1?Q?Um79NctHaQ3VVJN+3mOWeIpLchISxwqG+usm6yBgFk2udFLCmLTtAI+zeK?=
 =?iso-8859-1?Q?uAQMpelQ8WjVK/BRh7n2DMr2Be8vROlAgwwBrnJxeJj7bcIXgEtaWVFDKw?=
 =?iso-8859-1?Q?Wbhad9FrLacFJq6PUKZd8q/Ek1BPoGUyxp/5qiXUaJE3J6F7smzeDmC/u+?=
 =?iso-8859-1?Q?P8pgMzzqPZReNyeF1L1okojtgN4zhA+2cy3wM7YS7E1PZCw2W8vH7n4Hgs?=
 =?iso-8859-1?Q?K9wDw2oQ+3tefsUNPhX/BJ971X3RYolh8K1B7h932krdrPs6rZpasyOqxr?=
 =?iso-8859-1?Q?wiU7FqFFvSynqjijeHsvxaJ8xPsORKUmIx1oIhhe5oIDVSyo0S7wScjJB2?=
 =?iso-8859-1?Q?QjcvDYJN1CwIyi3Hw1v040EUBKKWwpClcsxqiaUvwb//1pfyqyiTry5QOW?=
 =?iso-8859-1?Q?qhn3Hr9l1EgD56wxwdakWp2HUpssTomjFSRRzfS4n5sW94FpDchTwUz/8V?=
 =?iso-8859-1?Q?LoYd6ARivp8cNB1UpiE4hQm8A+cQ1N8BX5D6Dtasnzaq2mJfa3Zra84d+T?=
 =?iso-8859-1?Q?RYYqOXsQLc3LM5jXzAtcf5S5h5rf5ft6Ptf9dnaTiDhjqKehLx/Uw0NKgO?=
 =?iso-8859-1?Q?PntBjq87ooJ2qJHz8sD45sf1JURDCP47O7Uj7QSJfGeLuHs/l9vdcFjkFQ?=
 =?iso-8859-1?Q?3yl8TrZpcjZIqTKkEsRKcWhQ/IZnTdtvD1sYy9iJhLrzYsRCDz15aOSY4U?=
 =?iso-8859-1?Q?95OTUv9tRHH//n63VuGNOEsbIcy1+GnJ4xwguVdAHzOWWPNZu/dwYnS1m+?=
 =?iso-8859-1?Q?lB+zLBs1AEjrrpYva1//yhZJwI4yRwbRxyFrzf9ejCfXAHAOf11WvXSraN?=
 =?iso-8859-1?Q?DVfM2u2J16R7z7KXJDLKvT+p4vdI+ocqsDQDKw4vrOxxQl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	g8HYOF7Kvu3oO0Fx9K6L0+9MHQASwlOA+Y+khBuZV8CV4ohbbF6IGNLgzf0Q27V34OUmKL7mRnkMioEPPAK0kYxAwUQk8rglBsHl4AdDKNlfE4DK0KtvdFGP5tw5A/JMEjExcw6SNAYEomUBHEheNh2JjYes9W8cocRTDv9JE+X7VP6WOvv9fZ525rmztZ0BeW15c5SFNBL190XcVcp9VuJSVkKF95sQ1ueywe3W20/e159IcqNlELrrkn/0Bcx/x2Wk/JP2T4eKA4G9giji0rSemWJYDy6VKHHecVPkTq3euO8eNYqiC622UI8Fd6oZnNSfrs3r5+knPN2CcrjTEg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e890f943-1fa9-459a-5bb3-08df12b3ff01
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:36.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++wOf0y2RikdSDTUFVzuFIQ6zcKM/HdblZg4eC6HesMgss49E2Lo+6Y4pDjATgvAMmLOlzRrJWYbfHRY8iRTMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6839
X-MDID: 1789426843-P8mA7ecdbusj
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1789426843;P8mA7ecdbusj;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> The comment says "The five pin ops tables below", while at this commit on=
ly=0A=
> three exist [...] Could the commit message avoid crediting this patch wit=
h a=0A=
> comment block it does not add?=0A=
=0A=
The contract comment deliberately describes the complete=0A=
design so each later table can point at one authoritative statement instead=
 of=0A=
growing its own; the count is correct at the end of the series.  We will=0A=
reword the v9 changelog so it does not read as if this patch adds the block=
.=0A=
=0A=
> Can this index sitdev->ref[] out of bounds when called for the INTSYNC=0A=
> destination pin? [...] Would an explicit index check in both helpers, and=
 a=0A=
> separate ops table for the INTSYNC destination, be preferable?=0A=
=0A=
Yes.  With the v9 registration restructure the=0A=
INTSYNC destination pin is only registered together with its dedicated ops=
=0A=
table, so it can no longer reach the generic input helpers at any commit; a=
nd=0A=
the helpers gain an explicit index bound check plus a=0A=
lockdep_assert_held(&sitdev->multiop_lock) annotation as suggested.=0A=
=0A=
> The force override is asserted before its state bit is cleared, and an er=
ror=0A=
> in between returns with no attempt to undo it.=0A=
=0A=
v9 finishes the force/state sequence and keeps=0A=
the first error, the same shape the output helpers already use.=0A=
=0A=
> This isn't a bug, but the reference is circular. [prio_set holdover/latch=
=0A=
> comments]=0A=
=0A=
Fixed in v9: the three comments were reworded so the holdover/latch=0A=
sequence is documented where it lives (the table-commit helper) and the=0A=
callers no longer cite each other circularly.=0A=
=0A=
> Is the unconditional mask refresh correct on the error paths?=0A=
=0A=
Reworked in v9: the latch is still issued unconditionally --=0A=
slots written before a failed write are in the hardware table regardless, s=
o=0A=
latching keeps the device and the mask rebuild consistent with what was=0A=
actually written -- and the mask is rebuilt from the array that was being=
=0A=
written, which is closer to the truth than the pre-write mask either way.  =
The=0A=
periodic poll reads the table back and corrects whatever a partial write le=
ft=0A=
behind, so the cache converges to hardware within one poll period.=0A=
=0A=
> Does this silently evict whatever already occupied the last slot?=0A=
=0A=
No longer -- v9 returns -ENOSPC when the table is genuinely full (see=0A=
also the reply on patch 05).=0A=
=0A=
> Should the N-lane code be folded onto the P lane, the way the probe path=
=0A=
> already does?=0A=
=0A=
v9 folds the N code onto the P lane=0A=
in the priority paths for differentially configured pairs, matching what=0A=
sit9531x_ref_pll_mask_fetch() already does, so a blob that lists a DE pair=
=0A=
under its N code is found by the getters and setters.=0A=
=0A=
> When sit9531x_input_prio_add() fails here, the receiver has already been=
=0A=
> enabled and ref->pll_mask is left at zero. [...] Would calling=0A=
> sit9531x_input_disable() on this error path keep the enable and the claim=
 in=0A=
> step?=0A=
=0A=
Yes -- v9 disables the receiver again when the=0A=
table add fails, so an enable is never left without a matching claim.=0A=
