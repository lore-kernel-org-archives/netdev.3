Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03D1096F;
	Mon, 17 Aug 2026 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786936273; cv=fail; b=p64A/nq7jlFrNBEp5DganrZWLtA6psHfvxGWdDmC9Ji1nyGBiWE25Wm+t1pji/5fZ7S9m1oXUaKgiEb0IfsJKbJggRHVYkrUd7h8ZrWNg4vckkbaarBAjZUW9qCUNT10G4sh+H9rVVCvSClS1x6mKPSBLxubtBKC7C1xklKzf9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786936273; c=relaxed/simple;
	bh=/tvBL09jUbqcdwYRHn+68gl/OVOmhVUONIotskVmPHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TURiVxO96APehJXI+ICKMqhQ2MtCQci+hvEoSDUf/oMccge6yW0cbKJX+G2OJRtq4YtBtKGBhqCc7CPa3xspCIQPBLKYJ6cDus0670i7ctanSIrt92bSJkkiumZjprSwRfIZWPXmcrqwS6BcaDCr6nWAFE2o6NW2jcJSOWupQ+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=tf7OdVaR; arc=fail smtp.client-ip=40.93.198.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="tf7OdVaR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5m5Ma7oqw6zwBo83LJhrV5OgG36QK9xHvqkX7Lo1TICYkOptn6IXW9o0jz67bbdiY0LdEL+ieumC6Yj4OpP+/rgG51hmrbMyl0WLMWmFeoHQ8G9LG/uaH8Q1oqQkBwXwaJROPBxCrrd0deU6RasGberSWUeIGGj117BjFkv9KQdMOohyMmy2F7W7+NhnXh4VIA3uC7G1pK8bXlLs70XxkTbuvw6QVPjsrGCzUFCdv8IsqymPPPDEW3tQdc6kvYKuYYGyMZhhQSQ1PNII9MGbELH8XkB05oDQW48oq5P7wbDXjMikiMJhVLF2D9bKyp1ArbQp2ygddPen6uVXBIyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tvBL09jUbqcdwYRHn+68gl/OVOmhVUONIotskVmPHs=;
 b=hE5kktOO5MolloUpd3j8V6d3zkLHCzp+zhjj0J4YenT+EBkIMIPLwDaZE0quEh6Ei5YDvKvRusq8iIwg0zcFxFGgltFnWVkAIoUDArmjPxSrz6LTK7xRSzkHWmaWICv6BXmUdpHo+9sUYoKAsXfhOAKdJANEjAIwye6AZ8jnehYWJqrl1ZMt1OzukJNbNU5ik8P9jgwLC491d7UibjoJLoi6p/wXxkEy94rZ1kkv92UeDBBN2+M4ocoN6G+K9rFJrU6OAmLk5DQYNPLW5dTBiiDc7ImkLvr56xBb3apctTh/Od9vWu4JqfXQ/r3NbD0YA5HVP1cdVGEeYeRJjrCaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tvBL09jUbqcdwYRHn+68gl/OVOmhVUONIotskVmPHs=;
 b=tf7OdVaRtj0tQgbQg6Ub3Xkgjw0G9tYhFsRXMgR2xASXff9rTt6k111zxWJ0LqhKuHAvy98mGaHJSHu24Qs2X8LPpJPvrG4opZQIEDD0duZcc6nKq7rsv9uez2JOy64jh70paZGOFB77SBLmzFxbxqorVq1d4G6bRRCPmO/HfGNg64rzQdS5s/lElDLXnXeDBybdYXKUtydaglrx19cihcrq5XL1v3YR1uMVmn66HeC+pA4S73z6+/nHzV9GkEaCt9LImCpDffs2bhvCMJ2fbND+8uZiQfPBOj8zSL3GujjD5CbGCTcpwlG2K8+aNeoDQXt/SRl6PxykjOlFcjgOmA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5719.namprd03.prod.outlook.com (2603:10b6:510:36::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 03:11:08 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 03:11:08 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: zhu xin <zxyan0222@gmail.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: stmmac: dwxgmac2: add XGMAC timestamp
 interrupt support
Thread-Topic: [PATCH net-next v2] net: stmmac: dwxgmac2: add XGMAC timestamp
 interrupt support
Thread-Index: AQHdKmQVc8IGJjxZz0Om5Hwepxjxy7abizQAgAYMHYA=
Date: Mon, 17 Aug 2026 03:11:08 +0000
Message-ID: <f18dfd79-c252-4e78-b37b-e5aaf1bffecc@altera.com>
References: <20260810100221.9166-1-zxyan0222@gmail.com>
 <b3d90606-781a-4055-8529-e68e22a45ce9@bootlin.com>
 <20260812202027.976@gmail.com>
 <96146485-03f4-4c82-bb4b-9338b6591b2f@bootlin.com>
 <CAP7veT+fufSoBZBOQg+MQoGeedfzQBRtFrRPz8si2DJSJJ7NtQ@mail.gmail.com>
In-Reply-To:
 <CAP7veT+fufSoBZBOQg+MQoGeedfzQBRtFrRPz8si2DJSJJ7NtQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5719:EE_
x-ms-office365-filtering-correlation-id: c2c7a32c-925e-4df4-a37a-08defc0d2ed5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|56012099006|4133799003|6133799003|18002099003|22082099003|55112099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 e8Dokf/FbeyOnvJEemdM7uGOB6wywx9o1OH7rV+Pr02F5FB4v+GeXoi4iaxwpn8lwiJ1WhkJchdE0xfEbO6PUZTWvSpMLShRKgNBAiyLOBvvtrI5S9MecLBlG2EzQAVaJH29TK2e1gH+m+iyetLWIF3Ckf+1paCSZaST9pBvqIiQHfD3Mp2/PtkWSCEWdgicvsWZz6piYR+UX0F6CVk5TuQKRhRv4dAWcaETm++gpI2JL/pQSMuYOGnnn17qjJMMF8pp6hxPiNYb3lYU/MYUliTAdXc8BG7K+X81NibfxhYZLzKZvjgRtNkpkHxh7X+tPgUbpd0rvL0Y+T34dqbzGlNA6a4ra2XxUURHWOTXQfWvhqq++ARw4BkuAKMRXqXkacRy7nGdSf8JrWGzsb+hfmmfO3nCpTtAkFSciLNiKHXyvrniCBHIhx8ZaPjqMpCpWJp6n8Nh9diIxaL8/Qjz3c/UhPnqz9CwtRyZ5BZaI5ancTUkVTYHSqGFe5o5SUIF7X0i3Ay2eYj8nTIxU3qeP1nmdv7cqsR5Nxbn8gPKVSbp9YmDV6XuNwqffW6t4xfFERhwIXQXFgdMIeOsqyUepUvdBoe9u7E4aUrshIyiQUhC3SwP40PnH7ac7GkfvSdcbf5fYUbjNIJtyWVqj2u/5402evIqOtPDVjx9MW8nQtg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(56012099006)(4133799003)(6133799003)(18002099003)(22082099003)(55112099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OStuVmJvck95L1pIZ25leDUzQnc1Q2NBY2ZCbUR4eVFLNXhTaEVDbFNaUTRa?=
 =?utf-8?B?SnFUb21Jcm1aYWNGcEF3TUp6SnIxTFZMa2c3R0RtOC9pZ24vZ2RyQVE3NnlO?=
 =?utf-8?B?emZlYUhISHNHVVMvTjNNUTJ5dTUwZVRwRjltMGhtbDVSK2xnYXNCYytLZGt2?=
 =?utf-8?B?cDhHYlpSNDVsL2lhdU1JWDFYN1J5WncxMVV2N1prOFV1Z3JlOXFmaVQrZTIx?=
 =?utf-8?B?TndiTTFHWHROTWlNSE9ZbWdtUnNjWWs4UzN5cWxnSVhSeWdTaENQcEd3Und6?=
 =?utf-8?B?OVdiTEh5dEwrZnNrTmZrM3pIaDV4YXNOa2hpTlJycjZXVUpCRExNcWx4d2ZK?=
 =?utf-8?B?cFZQWm4zTENxa3VCNFJTT1ZTcGdFV1AyUXAvWDBBUUNHYjNaVFVPWDVUWUdi?=
 =?utf-8?B?SnE1MXBpbVRKa3ZIN1FQNnlDZnVQaStnZEVTZ05SbTQ5VjJ2UWZ3djd1VWxW?=
 =?utf-8?B?S2k3eGFmZzlMazlHL0xqNzR6VmF6bEdQTXpYbG8ybmsxWi9BdHluWDlVZlIz?=
 =?utf-8?B?UXZqZndEeHBiNkZzSW9RbmM4eEd2bk5WZXV5U3VWeUE1MGR5OUN2M1crbnpD?=
 =?utf-8?B?cmkzZWFwQjRrMXBkRkZwc0V5RUhqYkszZnZ4QmZ3WGJDeEhWcThyb3lIcFB0?=
 =?utf-8?B?cU8zMTNPaWgvYWV0b0FHejRYeWxxSjRLRjJMQnpYcTY3OFh4dlJRU05BVEFl?=
 =?utf-8?B?T1BmOVQzTjV3eGYreitPZDdqMzZKNE5pOU9aRVlSSnVXaVJZNy92YjUzak9U?=
 =?utf-8?B?bUpDdmNjeEcyc2w4dnB6L2pqdnZ0U2Q1YlZlRmZjcW5PTXd1RjIvTkZkaWFF?=
 =?utf-8?B?Ymd5NUdSakdmdU5SOGlwemFyRk9LT3B0T3VOcDEzbE9IWElyWVdIM2tUOXht?=
 =?utf-8?B?c1MvYjZ1T0dSbkJHVHM1dFNEbmJ0LzhrN2RqWjhlenkzdXIwVHBIWXVyeTlV?=
 =?utf-8?B?YzRZdXd5emlMam90eGZvd1pnVDl2bG02ZzFJMG1zMk1acXBiK0o0TENzQ0t5?=
 =?utf-8?B?UlJTaFZhbk9kV1NnWTNjUXlaYU16RHFoSDlvdzZwSjlnRFJab0pZSVZ3TERl?=
 =?utf-8?B?bnVYa0ZsLzRlVmpBeTRMdG10NGd5VnZIa3oxb1k2c2wvMFhEdlFDUFY1ZU91?=
 =?utf-8?B?ZDhGd09tNExxaG1kK1RaeEtjb2pJMWhib2FoUm5WWG1LS0UybTY5K2IzUW9S?=
 =?utf-8?B?dEVOUzlxMWJ0Ukd5cFZvdlJqTHJGTjNzUWN0aFZ4cGtPQW1UeHpYakp0VGNQ?=
 =?utf-8?B?TWNwOEVqWHNOdkQ3WFF1citWQlVkbXpYY1pyaUlPSG01eXpKaElJa084UGVr?=
 =?utf-8?B?dTQya2pINHRKV293N0hpdjl1bnlkQzZYY2E4YkUxUiswL011c3dNNnNNeWwz?=
 =?utf-8?B?RUNPT2NRM2k3OHY0YnJSUmExN0JEOHFJOU1LU3RLSk9mblhvVllpQmRVV1ZH?=
 =?utf-8?B?Y1B2Z2ZRNi8wK2JCVktXUWtyNzNOblMvRU8xUUphdlZscUV5d2gyNGRHaTd5?=
 =?utf-8?B?T2ZQYlB5WVMway9HT05icnVZMjgyK2RmYXA4YXJWV0h3eGVQcHNtOTk3bnZy?=
 =?utf-8?B?c3NLZy84VERuMHhjTWgyTytrRXdnWVdyMVkzWVZwOW9XSyt3bmVndFdzQzh6?=
 =?utf-8?B?TzY3S3pWeU9TS1BtR3RiUngrQjlST1hFdnZSM2tQUHNGNHB6c2lhY1hGTWJ0?=
 =?utf-8?B?c3J1ZFhOenVEL2dmQlZTbGV2RjBPZXRTdzlBZkJWeDJSNDRZeHRBVzlyLyth?=
 =?utf-8?B?MXcyRSt1elEwWGhENng0V09tT2x3L2g1QndoUzNHMzVnUnZrZ2lkU2dQTU9o?=
 =?utf-8?B?QTZaZ1B5L1UxdHlWYlNPT282NjEzMkVSWFpEWDduVUc4ZXNyM0tqWWtVdmI0?=
 =?utf-8?B?aGVGdGNLbnpYVVhiYklnQVBweklVWCt6YmhUcHE0TnVXcUVKMTJ2eXBmMHNR?=
 =?utf-8?B?Um5HWTh0bWlPaDQxVkUyaTAzQThRNmRSdGsxK01taUxCM053dUt4b2RqUmY1?=
 =?utf-8?B?T1ZiNWsyQ0JkVlA4NXA0eUtZTFplVmh2M0oxVVpwRWFpSkw2eUpxVWhudm95?=
 =?utf-8?B?T3hNcExoR3dGY2FQMFM4U2kzei84QncrRnRXaWs5YjZYS1lkTFRUU3F2Sjgr?=
 =?utf-8?B?ak9hTmZ4dzZRYUF1VFpkTmhHc3VyMzRiZ2RzL2JkV1RmQ1NjRmYzK3NUbVVk?=
 =?utf-8?B?NEFZS1NzUE1WaWIzZ3RRNWF4cGI2R3JwU051TXB5NHdPTUxLMFdud3FtMm1P?=
 =?utf-8?B?ZUE1UWtHZ05kVWMyS0JFRFJLK3lFYWdYczRoRVhBalRCWkRaWFlvSnF0aExF?=
 =?utf-8?B?MmY5aVlXWWlhOXZ4c1dIRk1XTHUyV2RSY2lFYWViY3lHM1ZpRW1tV1ZzTmRN?=
 =?utf-8?Q?lzZKok9GOARZYaeUu/3UBMFxIO219w+N2r7MEv1dB2QZd?=
x-ms-exchange-antispam-messagedata-1: Cif07OI9FP/Ztw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9B13C5897F6284088A0EC923EB58C5A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c7a32c-925e-4df4-a37a-08defc0d2ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 03:11:08.3267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUQisWwCOF5FmvrG1IXkRN9ktRes+UtOpOiIsqlMaZ7EeYxvV/+3a9xd+p6sCQJmzsUkV3WpHREEk37fkChUSgvF1I3js9BuwKiglyaZxTRX+kD1+DMKELZuYYOSIBsHSL4SXm2C8R7c6jLbg7yrMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5719

T24gMTMvOC8yMDI2IDI6NTAgcG0sIHpodSB4aW4gd3JvdGU6DQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4g
Z2V0IGVtYWlsIGZyb20genh5YW4wMjIyQGdtYWlsLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1w
b3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBd
DQo+DQo+IEhpIE1heGltZSwNCj4NCj4gT24gV2VkLCBBdWcgMTIsIDIwMjYgYXQgMTA6MDjigK9Q
TSBNYXhpbWUgQ2hldmFsbGllcg0KPiA8bWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb20+IHdy
b3RlOg0KPj4NCj4+ICtOYXppbQ0KPj4NCj4+IE9uIDgvMTIvMjYgMTQ6NTksIFp4eWFuIFpodSB3
cm90ZToNCj4+PiBIaSBNYXhpbWUsDQo+Pj4NCj4+PiBPbiA4LzEyLzI2IDU6MTAgUE0sIE1heGlt
ZSBDaGV2YWxsaWVyIHdyb3RlOg0KPj4+PiBJZiB0aGVyZSdzIGFuIGludGVycnVwdCBzdG9ybSwg
dGhlbiB0aGlzIHNob3VsZCBwcm9iYWJseSBiZSBhIGZpeCBmb3IgLW5ldA0KPj4+PiB3aXRoIGEg
Rml4ZXMgdGFnLg0KPj4+DQo+Pj4gVGhlcmUgaXMgbm8gaW50ZXJydXB0IHN0b3JtLiBYR01BQ19U
U0lFIHdhcyBuZXZlciBlbmFibGVkIGJlZm9yZSB0aGlzDQo+Pj4gcGF0Y2ggKFhHTUFDX0lOVF9E
RUZBVUxUX0VOIHdhcyBMUElJRSB8IFBNVElFIG9ubHkpLCBhbmQNCj4+PiBkd3hnbWFjMl9ob3N0
X2lycV9zdGF0dXMoKSBtYXNrcyB0aGUgc3RhdHVzIHdpdGggdGhlIGVuYWJsZSBtYXNrLCBzbw0K
Pj4+IFhHTUFDX0lOVF9UU0lTIGNvdWxkIG5ldmVyIGZpcmUuIFRoZSBhY3R1YWwgc3ltcHRvbSBp
cyB0aGF0DQo+Pj4gYXV4aWxpYXJ5LXNuYXBzaG90IGV4dHRzIGV2ZW50cyB3ZXJlIG5ldmVyIHJl
cG9ydGVkIC0tIGEgZmVhdHVyZSB0aGF0DQo+Pj4gd2FzIG5ldmVyIHdpcmVkIHVwLCBub3QgYSBs
aXZlIGludGVycnVwdCBzdG9ybS4NCj4+DQo+PiBBaCBpbmRlZWQsIHF1aXRlIHRoZSBvcHBvc2l0
ZSB0aGVuLg0KPj4NCj4+Pg0KPj4+IFNvIEknZCBsaWtlIHRvIGtlZXAgdGhpcyBvbiBuZXQtbmV4
dCBhcyBhIG5ldyBmZWF0dXJlIHJhdGhlciB0aGFuDQo+Pj4gcmV0YXJnZXQgaXQgdG8gbmV0Lg0K
Pj4NCj4+IFllcyBtYWtlcyBzZW5zZSBpbmRlZWQuDQo+Pg0KPj4gQ2FuIHlvdSB0YWtlIGEgbG9v
ayBhdCB0aGUgc2FzaGlrby1yZXBvcnRlZCBpc3N1ZXMsIGl0IHNwb3RzIHRoYXQgdGhpcw0KPj4g
Y291bGQgaW50ZXJmZXJlIHdpdGggdGhlIHRpbWVzdGFtcGluZyBvbiBhZ2lsZXg1IChhbm90aGVy
IFhHTUFDIHBsYXRmb3JtKSA6DQo+Pg0KPj4gaHR0cHM6Ly9uZXRkZXYtYWkuYm90cy5saW51eC5k
ZXYvc2FzaGlrby8jL3BhdGNoc2V0LzIwMjYwODEwMTAwMjIxLjkxNjYtMS16eHlhbjAyMjIlNDBn
bWFpbC5jb20NCj4+DQo+PiBNYXliZSB0aGVyZSdzIHNvbWUgc3R1ZmYgdGhhdCBjb3VsZCBiZSBt
YWRlIG1vcmUgZ2VuZXJpYyBieSBtb3ZpbmcgdGhlbSBvdXQNCj4+IG9mIHRoZSBzb2NmcGdhIGNv
ZGUgYW5kIHB1dHRpbmcgaXQgaW4gdGhlIG1vcmUgZ2VuZXJpYyB0aW1lc3RhbXBpbmcgY29kZSA/
DQo+DQo+IFRoYW5rcyBmb3IgdGhlIHBvaW50ZXIuIEkgbG9va2VkIGF0IHRoZSBzYXNoaWtvIHYy
IHJldmlldyBhbmQgdGhlDQo+IEFnaWxleDUgY29uY2VybiBpcyByZWFsLiBPbiBBZ2lsZXg1LCBz
bXRnX2Nyb3NzdHN0YW1wKCkgcG9sbHMNCj4gWEdNQUNfSU5UX1NUQVRVUyBmb3IgVFNJUyBpbiBw
cm9jZXNzIGNvbnRleHQgYXMgaXRzIG9ubHkgY29tcGxldGlvbg0KPiBzaWduYWwuIFRoZSBwYXRj
aCBlbmFibGVzIFhHTUFDX1RTSUUgaW4gWEdNQUNfSU5UX0RFRkFVTFRfRU4sIHNvIHRoZQ0KPiBu
ZXcgaGFyZGlycSBoYW5kbGVyIG5vdyBydW5zIG9uIGV2ZXJ5IHRpbWVzdGFtcCBldmVudCBhbmQg
Y2xlYXJzIFRTSVMNCj4gYnkgcmVhZGluZyBYR01BQ19USU1FU1RBTVBfU1RBVFVTIC0tIHRoYXQg
cmVhZCBjYW4gd2luIGFnYWluc3QgdGhlDQo+IHBvbGwgbG9vcCwgYW5kIGdldGNyb3NzdHN0YW1w
KCkgdGhlbiB0aW1lcyBvdXQgd2l0aCAiV2FpdCBmb3IgdGltZQ0KPiBzeW5jIG9wZXJhdGlvbiB0
aW1lb3V0Ii4NCj4NCj4gT24gbW92aW5nIHNvY2ZwZ2EgYml0cyB0byB0aGUgZ2VuZXJpYyB0aW1l
c3RhbXBpbmcgY29kZTogdGhlDQo+IGNyb3NzdHN0YW1wIHBhdGggc3BsaXRzIGludG8gYSBnZW5l
cmljIGhhbGYgKHBpY2sgQVRTRU54LCBzZXQgQVRTRkMsDQo+IHBvbGwgVFNJUywgcmVhZCBBVFNO
UywgcG9wIEFUTlIvQVRTUikgYW5kIGFuIEFnaWxleDUtc3BlY2lmaWMgaGFsZg0KPiAoR1BPMCBy
aXNpbmctZWRnZSB0cmlnZ2VyICsgU01URyBNRElPIHN5c3RlbSBjb3VudGVyKS4gT25seSB0aGUN
Cj4gZ2VuZXJpYyBoYWxmIGlzIHdvcnRoIGxpZnRpbmcsIGFuZCB0aGUgcGxhdGZvcm0tc3BlY2lm
aWMgdHJpZ2dlcg0KPiBiZWxvbmdzIGluIHBsYXQtPmNyb3NzdHN0YW1wLiBUaGF0J3MgYSB1c2Vm
dWwgY2xlYW51cCBidXQgbWF5IGJlDQo+IG9ydGhvZ29uYWwgdG8gdGhpcyByYWNlLg0KPg0KPiBG
b3IgdGhlIHJhY2UgaXRzZWxmIEknZCBsaWtlIHlvdXIgdmlldyBvbiB0aGUgZml4IGJlbG93LiBU
aGUgc2ltcGxlc3QNCj4gb3B0aW9uIEkgZm91bmQgaXMgdG8gbWFzayBYR01BQ19UU0lFIGFyb3Vu
ZCB0aGUgY3Jvc3MtdGltZXN0YW1wIHNvIHRoZQ0KPiBoYXJkaXJxIGhhbmRsZXIgY2Fubm90IHN0
ZWFsIFRTSVMgd2hpbGUgc210Z19jcm9zc3RzdGFtcCgpIG93bnMgdGhlDQo+IHNuYXBzaG90IEZJ
Rk86DQo+DQo+ICAgIHN0YXRpYyBpbnQgc210Z19jcm9zc3RzdGFtcChrdGltZV90ICpkZXZpY2Us
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc3lzdGVtX2NvdW50ZXJ2
YWxfdCAqc3lzdGVtLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqY3R4
KQ0KPiAgICB7DQo+ICAgICAgICAuLi4NCj4gICAgICAgIGlmIChwcml2LT5wbGF0LT5mbGFncyAm
IFNUTU1BQ19GTEFHX0VYVF9TTkFQU0hPVF9FTikNCj4gICAgICAgICAgICByZXR1cm4gLUVCVVNZ
Ow0KPg0KPiAgICAgICAgLyogbWFzayBUU0lFIHNvIHRoZSBoYXJkaXJxIGR3eGdtYWMyX3RpbWVz
dGFtcF9pbnRlcnJ1cHQoKSBjYW4ndA0KPiAgICAgICAgICogY2xlYXIgVFNJUyB2aWEgcmVhZGlu
ZyBYR01BQ19USU1FU1RBTVBfU1RBVFVTIHdoaWxlIHdlIHBvbGwgaXQNCj4gICAgICAgICAqLw0K
PiAgICAgICAgc3RtbWFjX21hY19pcnFfbW9kaWZ5KHByaXYsIFhHTUFDX1RTSUUsIDApOw0KPg0K
PiAgICAgICAgLi4uIGFybSBBVFNFTngsIEFUU0ZDLCB0b2dnbGUgR1BPMCAuLi4NCj4NCj4gICAg
ICAgIHJldCA9IHJlYWRsX3BvbGxfdGltZW91dChpb2FkZHIgKyBYR01BQ19JTlRfU1RBVFVTLCB2
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh2ICYgWEdNQUNfSU5UX1RTSVMp
LCAxMDAsIDEwMDAwKTsNCj4gICAgICAgIGlmIChyZXQpIHsNCj4gICAgICAgICAgICAuLi4NCj4g
ICAgICAgICAgICBzdG1tYWNfbWFjX2lycV9tb2RpZnkocHJpdiwgMCwgWEdNQUNfVFNJRSk7DQo+
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgIH0NCj4NCj4gICAgICAgIC4uLiByZWFk
IEFUU05TLCBwb3AgRklGTywgZ2V0X3NtdGd0aW1lKCkgLi4uDQo+DQo+ICAgICAgICBzdG1tYWNf
bWFjX2lycV9tb2RpZnkocHJpdiwgMCwgWEdNQUNfVFNJRSk7DQo+ICAgICAgICByZXR1cm4gMDsN
Cj4gICAgfQ0KPg0KPiAgICAvKiBldmVyeSByZXR1cm4gcGF0aCwgaW5jbHVkaW5nIHRoZSAtRUlO
VkFMIGRlZmF1bHQgb2YgdGhlDQo+ICAgICAqIGludF9zbmFwc2hvdF9udW0gc3dpdGNoLCByZXN0
b3JlcyBYR01BQ19UU0lFICovDQo+DQo+ICAgIHN0YXRpYyB2b2lkIGR3eGdtYWMyX3RpbWVzdGFt
cF9pbnRlcnJ1cHQoc3RydWN0IHN0bW1hY19wcml2ICpwcml2KQ0KPiAgICB7DQo+ICAgICAgICB1
MzIgdHNfc3RhdHVzID0gcmVhZGwocHJpdi0+aW9hZGRyICsgWEdNQUNfVElNRVNUQU1QX1NUQVRV
Uyk7DQo+DQo+ICAgICAgICBpZiAoIShwcml2LT5wbGF0LT5mbGFncyAmIFNUTU1BQ19GTEFHX0VY
VF9TTkFQU0hPVF9FTikpDQo+ICAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICAgLi4uDQo+ICAg
IH0NCj4NCj4gVGhpcyBrZWVwcyB0aGUgZXh0dHMgaGFuZGxlciB1bmNoYW5nZWQgYW5kIGp1c3Qg
bWFrZXMgIndobyBvd25zIFRTSVMiDQo+IGV4cGxpY2l0IG9uIHRoZSBjcm9zc3RzdGFtcCBzaWRl
Lg0KPg0KPiBBbiBhbHRlcm5hdGl2ZSBJIGNvbnNpZGVyZWQ6DQo+ICAgIC0gbWFraW5nIHNvY2Zw
Z2Egc2V0IFNUTU1BQ19GTEFHX0lOVF9TTkFQU0hPVF9FTiBhbmQgd2FpdCBvbg0KPiAgICAgIHRz
dGFtcF9idXN5X3dhaXQgbGlrZSBpbnRlbDogY2xlYW5lciBsb25nLXRlcm0sIGJ1dCBhIGJpZ2dl
cg0KPiAgICAgIHJld3JpdGUgdGhhbiBmaXhpbmcgdGhlIHJlZ3Jlc3Npb24gd2FycmFudHMgaGVy
ZS4NCj4NCj4gT25lIHdvcnJ5OiBJJ2QgbGlrZSB0byBjb25maXJtIG1hc2tpbmcgVFNJRSBmb3Ig
dGhlIH5wb2xsIHdpbmRvdyBpcw0KPiBhY2NlcHRhYmxlIG9uIHRoaXMgcGxhdGZvcm0gLS0gZXh0
dHMgc25hcHNob3RzIHRha2VuIGR1cmluZyB0aGUgd2luZG93DQo+IHN0aWxsIGxhdGNoIFRTSVMg
KGp1c3QgZG9uJ3QgcmFpc2UgYW4gaW50ZXJydXB0KSBhbmQgYXJlIHJlcG9ydGVkIGFmdGVyDQo+
IFRTSUUgaXMgcmVzdG9yZWQsIHNvIHRoZXkgYXJlIGRlbGF5ZWQgcmF0aGVyIHRoYW4gbG9zdC4g
RG9lcyB0aGF0IG1hdGNoDQo+IHlvdXIgZXhwZWN0YXRpb25zPw0KPg0KPj4NCj4+IEkgZG9uJ3Qg
aGF2ZSBhbnkgeGdtYWMgYm9hcmRzIHRvIHZlcmlmeSBzYXNoaWtvJ3MgY2xhaW0gdGhvdWdoLg0K
Pj4NCj4NCj4gSSBkb24ndCBoYXZlIEFnaWxleDUgaGFyZHdhcmUgdG8gdmFsaWRhdGUgdGhlIGNy
b3NzdHN0YW1wIHBhdGggZWl0aGVyLA0KPiBzbyBJJ20gcmVseWluZyBvbiB0aGUgY29kZSBhbmFs
eXNpcyBhYm92ZS4gSWYgdGhpcyBhcHByb2FjaCBsb29rcw0KPiByZWFzb25hYmxlIEknbGwgc2Vu
ZCBpdCBhcyBhIHYzIHdpdGggdGhpcyBhcyBhIHNlY29uZCBwYXRjaC4NCkhpIFp4eWFuLA0KDQpM
ZXQgbWUga25vdyB3aGF0IGtpbmQgb2YgdGVzdCBuZWVkZWQsIEkgY2FuIGhlbHAgdG8gdmVyaWZ5
IG9uIG15IGVuZA0KDQpCUiwNCk5hemltPiBUaGFua3MsDQo+IFp4eWFuDQoNCg==
