Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225656;
	b=oaURRFslKwesNtYQse7eFcQG5Yit0qY86x/yN7H7+4k0el1lrSY2fR4ja8Yey/WA4YDn
	 +TcyrohjSZJZzowqd+t11M131MFqElvpknqcE93uP1mWC/ex0LUOXd8cjq7nbuKgyGZ+W
	 kI0IBTrWS3ZU1OUa5FDuw6+AJ0Y8vZwtNahDw8wODWGqJpvNnEEJEd2zjUxlWVnlzHFMh
	 iSrbwXEcIO1T8J9TrbsHx61C3ZYyTTInbqcImCuz7xPboUO0LietMVbSt87km1ZOZBvmI
	 n2whVckBY8hEDw+EqnFoc7js4Hg4A5NqZVDeG1Gjm8cHnQMezV5bSv1dHGKvBHOkVqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225656;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=z/9m8jGbYMEFvy4QqCnRe2ILhwoTCTG2pULHvotixXo=;
	b=VpkLWbZppyR0Qfs7OgYqPNZvD4m+Z9OXfWKq/4sSrsLBsL9euFjsOQatsVoeo6hTNCM5
	 5b9vFgAyK2eJ5K2kicocek0jVn5G8LbOpwu5vj2wvmfQY/nq424zrH3XO4Vk9kCkNaNsm
	 IHrc471eaKtjp1aam3dApnRnmbY6FmBljsy2i5igSI+ebB9wH5R4/ZKW311kmuIjEVrue
	 RHt0Fdu56QZH4opXkegjyFVpfrk0bD9taGA5FbKugntudXqSqBpsIcrBqHQCW605Ynig0
	 QdvdXZWkyC8Iu8rmCQXzVK+f6lxhURJ3Z4wz7ucerTm2Wnj9FiyU9gNVrOvtw9RsSIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	dkim=pass header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=HEbS3ug6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.73
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023073.outbound.protection.outlook.com [40.107.44.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8E606A334;
	Mon,  9 Nov 2026 12:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23D8E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=HEbS3ug6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGr8Rf+/TF905uOs2yFTbsh9eK9OhKsHD23kzDc+UMOO0Mz+8yM4aOcMKI1GWFS5I7bj79PxoL+G1q0iRmU3K/jWnHJ7kysoxFMcttKO16fHvgjhk2yn3iqU2iQnkj5azTAoNNzPBfpiBHut6Soz7eFDgcTTdkdYsrfuLeAnsWi+05ncKI9zvaOatsoBaCnUFCZfI35pCF//uB1PMaIDuWv1ULOK/8GcSY+8jZhAbs0kOkjQaqTQHIa/dTofSCzbIun83hg21mqOUtxWxw6Rsf9aqNcIV9du4ZUyAQsTvchXQoSO0h0b1+ItBG+tLmPi2N7mKhkyboh8RIne0pKPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/9m8jGbYMEFvy4QqCnRe2ILhwoTCTG2pULHvotixXo=;
 b=GxiAZsPrjmExuz5LP2oZtyNMEqCIsh9tCjEDSY1uRxLrCsdIgoYXlXDxSgIHDtSfpVL3JsxotJguTaAxbFpzROQExnydYbtV+9uO8BcSJgl6m+IcIhXtQnixwceo4lnKoOzGur0Ne4/DZNps0TkQkbNdq5lvru8EkvEEFL3uTrixZH3EBh2F7cPHACn8a8v0c8FmfcigB6Du/AXNTCfl92fNqPRivPVty2fkuUEtwpiTI+7KKfqdPvj8RTwHW9vZDbofmjbaahtLktldBchM/tOnfeCQzrJbma7LElRR8IkuWUy4IxNiKW75NnOYWOMxsuJZbvF33yk3n9g6pR12rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/9m8jGbYMEFvy4QqCnRe2ILhwoTCTG2pULHvotixXo=;
 b=HEbS3ug6KhJ1pgZGJeENMxihig6oR1ikRXrMcOzyXoduAp4fuX7mde8kb96jZoMQi3uF39FQ4x8e0VbMUnfW9sMZW8FdoCDfsVxk+xkpV97SurTPPSGZKG1UMJPbPUdHPIFwTnObadfTPy1Ez0K5iwpsk8+CfiBdcw2H6U+rIUkXtmEYEbkjGGjMpfnNBVoFbithxcAt1Wjlzy/CAX9lt/sWfR9isu2FBXvNI3t61//rdmbzGxmen2mAc7yJ+Icau9YkrDMTrwdlK6Uid8QL2ITGdM2XcfDc2sTpRGnEhwOKPBOn07NEnh7ROM3lgp2BahirR0Om4KpsOm0rTX9U8A==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB8792.apcprd06.prod.outlook.com (2603:1096:101:338::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 12:00:52 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 12:00:48 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Eric Dumazet
	<edumazet@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0Dogpl7C0Dogpl7C0DogW1BBVENIIG5ldC1uZXh0IHY1IDEvN10gZHQtYmlu?=
 =?big5?B?ZGluZ3M6IG5ldDogZnRnbWFjMTAwOiBNYWtlIEFzcGVlZCBjb21wYXRpYmxlcyBz?=
 =?big5?Q?tandalone?=
Thread-Topic:
 =?big5?B?pl7C0Dogpl7C0DogW1BBVENIIG5ldC1uZXh0IHY1IDEvN10gZHQtYmluZGluZ3M6?=
 =?big5?B?IG5ldDogZnRnbWFjMTAwOiBNYWtlIEFzcGVlZCBjb21wYXRpYmxlcyBzdGFuZGFs?=
 =?big5?Q?one?=
Thread-Index:
 AQHdbBy8iK0bacl+gkmJItDgUE8TnbcduOEAgAAHQtCAAaHKAIAADZTggAOpboCAAo9ToA==
Date: Mon, 9 Nov 2026 12:00:46 +0000
Message-ID:
 <SEYPR06MB5134D4BD4DD0131C09B2E2269D732@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
 <20261104-support_ast2700-v5-1-44057f4dde75@aspeedtech.com>
 <20261104-helpful-courageous-hedgehog-f05bbf@quoll>
 <SEYPR06MB513412E04F4F0AE8ADE0375E9D682@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <20261105-ambrosial-natural-ibis-7cecb6@quoll>
 <SI2PR06MB51406DA90F387ED0C64073869D772@SI2PR06MB5140.apcprd06.prod.outlook.com>
 <f44dead2-c5cb-4684-ac7d-2f4409af1ab3@lunn.ch>
In-Reply-To: <f44dead2-c5cb-4684-ac7d-2f4409af1ab3@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB8792:EE_
x-ms-office365-filtering-correlation-id: 2bdfb203-6f43-43b5-06f3-08df3e591753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|18002099003|22082099003|38070700021|4143699003|56012099006|261009223027099003|261102123227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|10067099003|6133799003;
x-microsoft-antispam-message-info:
 xBDeQ85roWWPvd5m6+OcBORG0Xf853k48wXIymGxwJ9HV6i/VXvc/kxjM5c2IRAvggjKwjvIIg25JX5iP/ncbKwIxCVOpcQPj+Tp0OsvWXUQpjL7opdRqm3xbRUv+3z1P+AMYviypuKAnyjX7wTMcoPsfT7QSrtu/HRnE7NiGJVw/U57Q+3pjY7DR39u2GHEoOGtqMJM0mb1DNSiytO/vaDyod5+Vi33KM3jhlFuEl9SbscRx7Kq1ROPk14kwr6a2xrgPZ/skLkAPlcGPAJSIzqDqXGfUYOi/kdFvNUUH9MADFhMLuZOwO2AfOkU0wwwxqArFMw/yP01VyHQrXU+dMw6UN89Prin7p8XGDrm2smJIoN25dYYaR+ULrMcFYk8jMxJHvfukXsXqv7fm8R5lyIk6XCYA2KuOzBEUCy3pa9eypTwN+jFbUazn3Jom7gaEbQhYO4hZGrhUT1aofv98V03VFu5ildzD52dwjNXMDSyvaDxxZ8ZFVW20j1DYAFKCXF24YJ8cQTHW6y1VXiJLYT8d+8q/0CCX2y2cD9m17AsvnQvx5MwA28Gkhxr/nxE6z/OGkdaUjiiCK3coACKQs+47fGCeEPSr1jl1oIaZBsoVdC9h5mzxdTM1yPFgRAIUb+7YYF9LtbhCaYBvndm2tafeMu7+kbR+tL03eNnBvGKZA61XApwIVzD2dIiSLaad21CnX+7+DWSHGC1o+7vC1UjL+1CHQXwJ68+K8g0DdE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006)(261009223027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?K0YwMzZ6bThCNHNhUzZxd0VwajQ1SVdxY0tlRWt6UlVaYlR4OTA5dWxQVVI0bnB5?=
 =?big5?B?eTJVL3hTdHE0d0UvZlJyNms0UzVIc3Rram5QVzVrNE90SDlVTTFmUkpGbFlOLzZF?=
 =?big5?B?c3Q4cmd5bWRtcXpUd2o0cEtDdUVXanFndFBGcU9vaVR0QlpCWUlHblE0Q1BtdmpP?=
 =?big5?B?dHhxQUovQ1FtT3loZGJEUG5YZWRDZVBjS2xNY0VvY2tYR2tOWkFWMjNxUStSd2E5?=
 =?big5?B?NlVYdFhHbVhsb3QxUHNUNHk5emRhbkNZWXF6MW4weWVVeEhuamJJYWx0QjhzZFlQ?=
 =?big5?B?ek9KRFhWR1pkVGJQR0RVenpEYUtGRzRjNDZ5Z3hiYjBoQ3h2T3k2aVB5ZTZ4NDdy?=
 =?big5?B?WnAvck84RzVwOGJXWGt5Z1dEbHhtMEJoWXllTVRyLzB4WWwvTUdDckR3cUw2TU1p?=
 =?big5?B?UC9ZeWZqdy92aU9yc0xQVnN3bzJCOHVuNGNxYjVCVHRiWjBmSHhIcnJCdGQ2WHRX?=
 =?big5?B?VUFTdkZoQytqL3RlSFNsdHY2UUhkMVN4Z0ZYbHRTUFRpaWRMeDRidGlwaE5YY0NH?=
 =?big5?B?SFN2alBrc3UzS2hEeHVnRmZaSm9CeDhFVGgzQ1RYTDJBNFVCR0tnc1dqd1oxYTQ5?=
 =?big5?B?b0JqS3ZzV1hGcEhwMG02MkF4TEVpSmppU2FXRTVzWWdpTm9FYksyUEU0U2hodVdv?=
 =?big5?B?MUVvRy9Fc0Jub2d2SW16cDJFd21FajNtdlR5cGdta0R2UzBrWFc3NXRLdUNDdHFq?=
 =?big5?B?bHhNMnJxSmxYUkhsVzV3VTB5S05aYW1UTzB3NlFnekJjMExhcEpLZFVFbnB6cVc2?=
 =?big5?B?OEdxQjgydGtheVBMMDdqTGh4MWhIdzlQVkVNWWZQUGQ2NmhWNm9xT3RldXA0TURI?=
 =?big5?B?MkpOWldQNjMydThkMnNMRmNmSjlnSTg2cTRGMUJWTHJ4WHV3MjZmTDN5Nyt6aEdJ?=
 =?big5?B?L3Z0ZGlkd0NNV2NCQ0JBWWtnZEZzZldlc1lPQlM5OVVNM0NkNllnOXp3blYveDhi?=
 =?big5?B?MVdlYzdhVGRwQ2Jwa2RyWWNnUmM2eWI0YlltYkxORlVFeW93N3U2YW0wdmp3WFlC?=
 =?big5?B?ck11ZUNIRWZFU3VPY2VzdlJ1RUdCakxNMjBWdHk5clc0UmZVUDVPSDZ4Zk5IV1ow?=
 =?big5?B?TnJ4dzhDdzVyL0MySzhmYUVvbjlEOWVMNGV6U1dlSGZHT1BCTHVvQnpqTTZhVC9E?=
 =?big5?B?SVNDMGYzR051dmt4YUtLWVFQSXE5VVJhNjc4ZmNKK3BKSm03ZkhaVWp5dUlpWmM5?=
 =?big5?B?c3JWYUtIRm1vM3pLM0VsbHlZbVllaEV4cUFpWnVqTXlFdzVmTmJVYXF6Zk5IazJq?=
 =?big5?B?dEFlTVZidS9Eb2MwTzYyajVYMXlkZUJlUklpMC9MajFHTDVVeDR6RDB4MUNpRTM0?=
 =?big5?B?NTBrNTNYS3ZKUW5Zc3cwMFlWcU5JNmJJTHkxWk5pUk0wU0JYS2dLQkFhNElOZmJx?=
 =?big5?B?cW1zYjJsaTlmVm5nWTdQYzJsTThQd3l6c1VEYUhzeStLaU9VMjJYVmtINmIxQ3F6?=
 =?big5?B?OGhzS1hxTk5yM05nL0xKMElWY1NQUjVqNHZLSGQ2SGJlb3dpRWlnL29Pc2RlNHNR?=
 =?big5?B?Y0JXaXZTcDVDMUo4WGNlWmt2a0w2RHpDNWVXQUVDSWZWYmRIMlVKczJGT3Fac1FX?=
 =?big5?B?N21HcUQzeDBiSkxFc1B1RkJLM0J4M2YwbFRhYkpvMzF4YndYaDNscUlGVVZncDJ3?=
 =?big5?B?UXJRM3BUanBUQmxmeXhnNnV1aFJrazBRWnVoQ2l1TXR5OFV5L2JvelpINkxuSTI0?=
 =?big5?B?WnRvMThXLzBkOEJTMjdKUU4wNTArS0k5VkNrSmFtZVhXUjRMSEtPQmM1eUlTUHRI?=
 =?big5?B?MWNHTXE3blZSbjk4ZTdRSTRCeFAyNEhONDhtZUkwc1JwenZQaXVlalZKTUFpeUFO?=
 =?big5?B?UzNINzFsaStuZFhVdWZUTGhGSWJzZmhIeDgrZWVtbElmUUtnaGFLZXJBSjErNzJt?=
 =?big5?B?endDVGVZaTdaZmhoaGFYcWMrcGgyMTZXR2ZOc292cVI3K2FaYWkzVnVDNVVySG9J?=
 =?big5?B?dmQ5N2MvYTNZWkFxa3VCVFVMcmY0K2hiUituYWUrcDYvQ3NjNVNwdXFVSUx5K3Ra?=
 =?big5?B?Wi9Ld3I1Tm4zVHpmNFRhdnd1a3E5bzFPMlNUcHF6RWcxSzRiZzZzV1NjMVZGbC9v?=
 =?big5?B?RlVuRjRLNkt3K0EyRXJSUUFjSUNQSDNFZXVGbUhLQ3Mvc0hvbDZ3SGZLekV4TFds?=
 =?big5?B?MXR0Z0hXSUp4VG9heE1SRk5kQ200QlUwVHJBSjYwaHFyU1JUS1ZmS1RXdElVVDZ3?=
 =?big5?B?MngvQ3JiUDVKMjhGTUlTVXY3ZDZaZz09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vAEsa9Tb0RkORxH4Fkusum91BbqggeUbehCfO1/bXNlP1gv/QLtqGU5sI2mWJCo9mizyHaMik97wQHFidZO9lyhCBLilG2K7sudmtujyjXnN6RGMA7CIeCaoFDR2kQrOyjS8CCk3pRZlLebrVbbmt0WDF+4GZ6YgFGUOALrGL2FRJ86hCwQ8b+EIciRczauw5axGcvNPLF137gFveYPAo1A++QTQQGBGYSAZ7B5a/FGyEUkKibYbdmVMJ43czo4wE8DvCZ1kauyXMlZy0suaixZpfoojbdpzLvBfpXh0/fS67CUIF/z2TgDT9fILrxj4rmpXJAwHv58WNd7IViUJ1g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdfb203-6f43-43b5-06f3-08df3e591753
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 12:00:47.3649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BT8FjWPhTk3VTYLcrRq0n2lrNgBWa8d9WLLl8FT5G/exxbG8gJg2hAL9Hb2Jg3KHXXQh+9w4AWas2GTJ4X5uZBkkcEFKdRPI1WqK0kTNHz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8792

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiA+ID4gPiA+IFRo
ZSBhc3BlZWQsYXN0MjQwMC1tYWMsIGFzcGVlZCxhc3QyNTAwLW1hYywgYW5kDQo+ID4gPiA+ID4g
PiBhc3BlZWQsYXN0MjYwMC1tYWMgY29tcGF0aWJsZXMgYXJlIGN1cnJlbnRseSBvbmx5IHZhbGlk
IHdoZW4NCj4gPiA+ID4gPiA+IHBhaXJlZCB3aXRoIHRoZSBnZW5lcmljICJmYXJhZGF5LGZ0Z21h
YzEwMCIgZmFsbGJhY2s6IGlmIGENCj4gPiA+ID4gPiA+IG5vZGUgZXZlciBib3VuZCB0aHJvdWdo
IHRoZSBnZW5lcmljIGVudHJ5IGFsb25lLA0KPiA+ID4gPiA+ID4gZnRnbWFjMTAwX3Byb2JlKCkg
d291bGQgc2V0DQo+ID4gPiA+ID4gPiByeGRlczBfZWRvcnJfbWFzay90eGRlczBfZWRvdHJfbWFz
ayB0byBCSVQoMTUpIGluc3RlYWQgb2YgdGhlDQo+ID4gPiA+ID4gPiBBc3BlZWQgQklUKDMwKSwg
c2tpcCBBc3BlZWQgY2xvY2sgc2V0dXAsIGFuZCBsZWF2ZSB0aGUgRE1BDQo+ID4gPiA+ID4gPiBt
YXNrIHRvbw0KPiA+ID4gbmFycm93Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQW5kIGRldmljZSB3
b3VsZCB3b3JrIG9yIG5vdD8gSWYgZGV2aWNlIHN0aWxsIHdvcmtzIGFmdGVyIGFsbA0KPiA+ID4g
PiA+IHRoZXNlIHN0ZXBzIGFib3ZlLCB0aGVuIHdoeSBpc24ndCBmYWxsYmFjayBhcHBsaWNhYmxl
Pw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQmUgZXhwbGljaXQsIGJlY2F1c2UgSSBoYXZlIG5vIGNs
dWUgd2hldGhlciBBc3BlZWQgY2xvY2sgc2V0dXANCj4gPiA+ID4gPiBpcyBuZWNlc3NhcnkgZm9y
IGRldmljZSB0byBvcGVyYXRlLg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEl0IGlzIG5l
Y2Vzc2FyeTogZnRnbWFjMTAwX3NldHVwX2NsaygpIGVuYWJsZXMgdGhlIE1BQydzIGNsb2NrLA0K
PiA+ID4gPiBhbmQgb25seSBydW5zIHdoZW4gcHJpdi0+aXNfYXNwZWVkIGlzIHRydWUgLSBza2lw
cGVkIGlmIGEgbm9kZQ0KPiA+ID4gPiBldmVyIGJvdW5kIHRocm91Z2ggdGhlIGdlbmVyaWMgZW50
cnkuIFdpdGhvdXQNCj4gPiA+ID4gZnRnbWFjMTAwX3NldHVwX2NsaygpLCB0aGUgTUFDIG9uDQo+
ID4gPg0KPiA+ID4gVGhpcyBwYXJ0IGlzIG9idmlvdXMuDQo+ID4gPg0KPiA+ID4gPiBBc3BlZWQg
cGxhdGZvcm0gd291bGQgYmUgbGVmdCB3aXRob3V0IGEgd29ya2luZyBjbG9jaywgc28gaXQNCj4g
PiA+ID4gd291bGRuJ3QgYmUgYWJsZSB0byBjb25maWd1cmUgcmVnaXN0ZXIgYW5kIFRYL1JYIGF0
IGFsbC4NCj4gPiA+DQo+ID4gPiBTbyB5b3UgYXJlIHNheWluZyBkZXZpY2Ugd2lsbCBub3Qgd29y
az8gVGhlbiBtYWtlIGl0IG9idmlvdXMgdGhhdA0KPiA+ID4gY2xvY2sgaXMgbmVjZXNzYXJ5IGZv
ciBiYXNpYyByZWdpc3RlciBhY2Nlc3MuDQo+ID4gPg0KPiA+DQo+ID4gWWVzLCB0aGUgTUFDIG9u
IEFzcGVlZCBwbGF0Zm9ybSBkb2VzIG5vdCB3b3JrIGF0IGFsbC4gV2l0aG91dCB0aGUNCj4gPiBj
bG9jaywgZXZlbiBiYXNpYyByZWdpc3RlciBhY2Nlc3MgdG8gdGhlIE1BQyBpcyBub3QgcG9zc2li
bGUuDQo+IA0KPiBUaGVuIGZvciB0aGlzIG5ldyBjb21wYXRpYmxlIHlvdSBjYW4gbWFyayBpdCBy
ZXF1aXJlZC4NCj4gDQo+IE1heWJlIHRlc3Qgd2hhdCBoYXBwZW5zIGlmIHlvdSBtYXJrIGl0IHJl
cXVpcmVkIGZvciBhbGwgYXNwZWVkIGNvbXBhdGlibGVzLg0KPiBEbyBhbiAuZHRzIGZpbGVzIGZh
aWwgdGhlIHRlc3QgdG9vbHM/DQo+IA0KDQpUZXN0ZWQgZHRic19jaGVjayBhZ2FpbnN0IGV2ZXJ5
IGluLXRyZWUgQVNUMjQwMC8yNTAwLzI2MDAgYm9hcmQgLmR0czoNCm5vIGZhaWx1cmVzIHdpdGgg
ImNsb2NrcyIgbWFya2VkIHJlcXVpcmVkIGZvciBhbGwgZm91ciBBc3BlZWQNCmNvbXBhdGlibGVz
LiBPbmx5IHRoZSBwcmUtZXhpc3RpbmcgImNvbXBhdGlibGUgLi4uIGlzIHRvbyBsb25nIg0Kd2Fy
bmluZ3Mgc2hvdyB1cCwgZnJvbSB0aGUgdHdvLXN0cmluZyBmYWxsYmFjayB0aGF0IGdldHMgZml4
ZWQgb25jZQ0KdGhlIC5kdHNpIGNoYW5nZSBsYW5kcyBzZXBhcmF0ZWx5Lg0KDQpXaWxsIGRvIHRo
aXMgaW4gdjYsIHNwbGl0IGJ5IGdlbmVyYXRpb246DQogIC0gYXN0MjQwMC1tYWM6IGNsb2Nrcy9j
bG9jay1uYW1lcyByZXF1aXJlZCwgMSBpdGVtIG1heCAobm8gUkNMSykNCiAgLSBhc3QyNTAwLzI2
MDAvMjcwMC1tYWM6IGNsb2NrcyByZXF1aXJlZCwgMS0yIGl0ZW1zIChSQ0xLIG9wdGlvbmFsKQ0K
ICAtIGNsb2NrLW5hbWVzIHJlcXVpcmVkIHdoZW5ldmVyIGNsb2NrcyBoYXMgMiBpdGVtcywgc2lu
Y2UgdGhlDQogICAgZHJpdmVyIG9ubHkgcGlja3MgdXAgUkNMSyBieSBuYW1lIC0gYSBzZWNvbmQg
Y2xvY2sgd2l0aG91dCBhDQogICAgbmFtZSB3b3VsZCBzaWxlbnRseSBuZXZlciBnZXQgZW5hYmxl
ZA0KICAtIGNsb2Nrcy9jbG9jay1uYW1lcyBkaXNhbGxvd2VkIGZvciB0aGUgZ2VuZXJpYyAiZmFy
YWRheSxmdGdtYWMxMDAiDQoNClRoYW5rcywNCkphY2t5DQoNCg==
