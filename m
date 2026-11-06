Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=3.110.59.157
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793945587;
	b=xQnHGWTB+XOMH37odab2K1130DEYx4uxFh5GrHhC8WFFaR3UVj6TMGlCVTqXoIK1GuYn
	 aMuEhvCoLTe431qzy9Km8csT9fChUwKYG7HPXq9KFS2ICHcvd4U3EFXQWkiwkL0Eos4Y3
	 5vzjimPZVb2Ov7bYzKCONQrkM+ljHaxk03ZrntTj1jY31VobbTNSKnYK+HoqTEbCNysSA
	 5aAgbEOjm1rcSL2+/3SL8laUboB/SypCkemk3fi41BqOp22haTHthCgiMxyB0QTyM0B32
	 i59Ae/mZk0+uBsKP9RAcIGKbZqMhEr9DR/5su6eq/CLSPAU6TH7WKEwoC6RtnJm/fyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945587;
	h=DMARC-Filter:Received:X-TM-MAIL-RECEIVED-TIME:X-TM-MAIL-UUID:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-TM-AS-ERS:
	 X-TMASE-Version:X-TMASE-Result:X-TMASE-MatchedRID:X-TMASE-XGENCLOUD:
	 X-TM-Addin-Auth:X-TM-Addin-ProductCode:X-TM-Deliver-Signature;
	bh=+ye29glBq9coOOJtJqn7+991NlGveEILZtOPXoY6+vc=;
	b=kmYclXF/Pki9y5gLkj71b3TDva1ICtuAUX1Mpc0zckeJRTfWB2VA9Z7u71z7pnByh1tM
	 1QNq5koA5K9rnYMjoH/clMS7aSnU6oxUgkfw4Hp3z3rJeH/NkFDDq3+OzkVqZXCQ0Y20M
	 f0hn4HO2DxCGat8uv4l6Jvs8h1Y/QcdSO6uOwJrB5AgASipQ9n761qlc7sgJ/9c72Cn+Q
	 iMmTanerdI7gNGTrJcxE5fxPDNJkap6BOKDIdPq5c4LlSDssof0Rt/APdRmii4vQnVKz6
	 vRaoY+BubL3oeg530MdaAEGvUx7O6MsQDS5Glf7i2ZKWsozP5Jfk6R/+0H9c5gc+fiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=electrifex.com;
	spf=pass smtp.mailfrom=electrifex.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=3.110.59.157
Received: from repost.tmes-in.trendmicro.com (repost.tmes-in.trendmicro.com [3.110.59.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788B606A335
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 06:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8788B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electrifex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electrifex.com
Received: from 40.107.51.91_.trendmicro.com (unknown [172.26.46.176])
	by repost.tmes-in.trendmicro.com (Postfix) with SMTP id D1FE1C000210;
	Fri, 06 Nov 2026 06:12:58 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1793945573.677000
X-TM-MAIL-UUID: e45e1785-045f-4488-9154-24ab5c92a37e
Received: from PNZPR01CU001.outbound.protection.outlook.com (unknown [40.107.51.91])
	by repre.tmes-in.trendmicro.com (Trend Micro Email Security) with ESMTPS id A5921C000400;
	Fri, 06 Nov 2026 06:12:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NArwQv0lWStkiFCvkrPr8yDEjPKE+76D2pWKXDOqO+JCwyfBzeNB/mqidx7YcrtAJ6rmgOLplWmXgDV2lqBezWTra8S+irdhWRhQt3761zG7zrS2uP+3oCFPYUDHFMHYLiyqzGdCmh4nvfaxbLj2q5koVf8tfV5uKSQ6V2msgoD3FT3khHkk48uGQWq6ZMuAQVmZWSzl//xp4UWlfOd9aUFdUji5Km/FhmGbOOgu7T4vxf8SfEudOhuK5ju8IhwuxEg1Ywfia8mh55JMgZVxDmbllUFGAuuXOv6VmwRKtoAeNDbSVhbnPqjhLqU2t1JW/3w0JJpkoqaUnDwsIYHl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ye29glBq9coOOJtJqn7+991NlGveEILZtOPXoY6+vc=;
 b=JTaCdChImo+pv8kUd/vGhL03OdabnnRGVaDWqaPLtPJI5KTunOBa9DCpJN0Ek/jVCZ2IEpAn5waGmziP39d+D4Gx26K09bP1fj1sI/H6Uyaywo88m0j/C0SbXKB2Qfkav/zBenBIsshUjXSgo7EjeXWpn4yqZhB6K41LFOdIUWOy/SE2k8fqh1/bTKqRPhg210PzXq//DBTqMJfpZwP0GobsroGgWlC+T3rtbE24jVFN8K7EM8NGCMV5yDYYICE+5AlyzNmkzB8tUatxuDugOsqXj7xI3ngHQ2+WyPuxETs0GCr842ZyOOFZzk0gNpFcxxH6GNF75iSpntUy+WakQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=electrifex.com; dmarc=pass action=none
 header.from=electrifex.com; dkim=pass header.d=electrifex.com; arc=none
Received: from PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2e4::9)
 by MA5PR01MB12822.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 06:12:51 +0000
Received: from PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::b5ca:719e:bc57:e90f]) by PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::b5ca:719e:bc57:e90f%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 06:12:51 +0000
From: Anandu Padinhare <Anandu.Padinhare@electrifex.com>
To: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jisheng Zhang
	<jszhang@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH net] net: stmmac: count XDP_PASS frames in rx_packets on the
 XSK zero-copy path
Thread-Topic: [PATCH net] net: stmmac: count XDP_PASS frames in rx_packets on
 the XSK zero-copy path
Thread-Index: AQHdbbNiSrQn/Jt67Eaff1ljtvq7gw==
Date: Fri, 6 Nov 2026 06:12:51 +0000
Message-ID:
 <PNYPR01MB11444552E41C2B17A992492C0FD762@PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=electrifex.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PNYPR01MB11444:EE_|MA5PR01MB12822:EE_
x-ms-office365-filtering-correlation-id: 3e607e99-3652-4762-a044-08df3bccfd37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|10067099003|38070700021|56012099006|261022105027099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261009223027099003|261021121427099003|261021123027099003|260925022911599003|261022075727099003|260925021311599003|260925021911599003;
x-microsoft-antispam-message-info:
 NZ81FZmZLNagcp3Wmu2Odfay1Zki266EhQZI7pa+urcFE7Zbmln9zVBiOXhhIoJH85VYZSsPOsWGPxESpoMFn4ZEcxpk4cUhRWKWx9cge38g/MRvHpP9lUQLT0d+EsI05H9NlY1nbcXmaSSE0dydYVpk2DCqJQ5bCiCDqlXCysKuafcnEf9ROTsicwWJUGeUwIirXtaNo7L3z3abWKTxs+rXycV0EHmYQoLq4zuKqjozOJgG5d6gaQc8XOlaoq0uswO2oK4C+71DKAYzA1h6YzhfFQbO0AnQZb8n2ZPHwUpeHYmm3BpykhegLpOMUeaWfbTsQrKu3rJ8zy+E8GVON3AoMeZDPWUhd8+YsczIiHMsX+huEY39gcgpOu+dLDw2XBRgVwxaNciCDalm4tYQ8k8s5qJGZ4OwPyc8sbf4K//D6cJ4KKV7VdwkPCYOzsO8tije4lz6vZh14c+9VdzbtE/I4cNYo+62TIPqcCyzEZT+IS6TcgM3XQawCmxvqDLhuO7lzvDB0ZywBduQHDA9dzSl/v6wO16LnM1+6zXIb/xWO6QQaJdFrTQI5bJwkaZAfaUX4VV6P6uyTU4xG8/OF6lIfSW3OsLabEhI4b0gQ1FZde0DzaKI/dbFZ79m1AuG/eXIrJvgs8zb1EyOgnJcpJruXyQTxl9lVKcvJDbhClUgGZX7aBCViCORhvIxh8kaOBcNYTBqU1LUT3kfsrXD3ATC73GXhVBM/9Hva3R8cnc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(38070700021)(56012099006)(261022105027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261009223027099003)(261021121427099003)(261021123027099003)(260925022911599003)(261022075727099003)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zRebLIjwaXGsS7/77bucB8YQMs+sQxh97hcZRF5TvbqKlMjnroWoNJLpum?=
 =?iso-8859-1?Q?KyUl08NGrdI1uLIlklW0e8VldMBXq6qEfmXgNDN9AvmAJCZOdlRpkI8e+g?=
 =?iso-8859-1?Q?nws4z11iuwmQMY42oarj+3lj0cW8BvjsQZu4zb+bZ9VegGH5oh4ijYSu0k?=
 =?iso-8859-1?Q?CbEa5bHjU7JUnKQudlSAoxN9qsd1VvtIouQw9l2jTK9jrr+5yTu9Y2VIwh?=
 =?iso-8859-1?Q?OiDuvT8t/mJPneYcDS/ou2RdmwIX8P+absX0dqg5+ypMQR7JGTP7/2POzc?=
 =?iso-8859-1?Q?7tEB4rGhzEbXBXO+lwAmYjxMzqX/wD/KWDHoBM3aRz9M5io3WdQxcuZRuU?=
 =?iso-8859-1?Q?uSEii+GDlorBp3/bmFw45queytV41DeOe+4g6XXBu7d7JHE0zvx9R+XqbN?=
 =?iso-8859-1?Q?k1uSfjSpaPuaw/KuWfayH+EQJYPe4puVvCJy9b/aGHERXOsahQ/1ZF3BsF?=
 =?iso-8859-1?Q?QDyRI6JxeIVSWkF6EjG836MjV1kAL+SM99nOGFGzX0k3Jzz2vbno3uhC+5?=
 =?iso-8859-1?Q?YGLIBTBH1ZnMoK3jToEpj8WLBsxQCGJn9XeJXWwBXDuPXP67r4GOekYGaj?=
 =?iso-8859-1?Q?My6LC4bvhcYHvBpDDKyo18lNlYuxh+lgoVyBfh3Cj+ZUc1x6mLDk6BsP95?=
 =?iso-8859-1?Q?jCc0cIVtK0vhBi859CD4CpX+Er6QzQH6eSvNycqvipng87tMZ0wZ3zQnHV?=
 =?iso-8859-1?Q?83siifiHk4qQI2f1ZMwBv5c5lJglhE0dqEMVqpadvAdclTCpaZbLvDZKGB?=
 =?iso-8859-1?Q?Vo1u/xZlAsdDvuvLnv8m0G50ohS75tjwDA8YY3EqNZt3kT4bkOfGbJS3WJ?=
 =?iso-8859-1?Q?OetCCQLn6VtiaFEozhsjERXvVWT7Z7TmzAa85gc0Y0x2v388UzYxDHMq/e?=
 =?iso-8859-1?Q?aCHPrw7mlNg61bkJgPog/GmHEdlNht5Wg1OidKzXenNNm8URuNQAO2sIAs?=
 =?iso-8859-1?Q?otbODezG9ZwlfQOTd0oHwAv3CsMPZXm5Ud1l3JArG2K3QuUx/c3Jf6ABF5?=
 =?iso-8859-1?Q?VWa/yYM9YTkvKZqfBm95PQ772DYmDcYVyhfuX59MezvxnzLzzT7srYKdX9?=
 =?iso-8859-1?Q?toB8BWx0cgauOIQODaedSxIi8rnf4KOOYftTj7rZC2XaVj5ERWuOjh+6Jw?=
 =?iso-8859-1?Q?JXB4232r5cLD7rZiHe4nEhCcdElW3RjJsbLPGJLoIL+jVtXTcPxj0rREm1?=
 =?iso-8859-1?Q?caWVdq2+8XFbvdQRySGd0sEugQmhsFfRPgNqjLnx3vEH9VJtF0w0eF3pEa?=
 =?iso-8859-1?Q?d07FqhdqFuQG1MljMin//n9yP2qZqjF3yfowtHE1z6FrZcwhqiHMyBdB4g?=
 =?iso-8859-1?Q?OIEO+6/+aA4tHm1cLaLHkW7eCF4bhoHmECpJV6GPLOl5yvdTYSx4lOCOfZ?=
 =?iso-8859-1?Q?hERc1Q0Wn0O/Kp9I1eV7ClEkswQ0wFIuZw5KJVD1AxuDimlWybFMSUoz+r?=
 =?iso-8859-1?Q?Jjgzw+Z4rSbUnY8ksQEFVXx0btb15LSdMcF77cmxKV0Mmp53KGAw3oJ0ji?=
 =?iso-8859-1?Q?LMkFCPBk+iy6pC2mBMGoZNcxQEMGxq7d2Bcd4j7khjjkI194mF0OMJ35Qw?=
 =?iso-8859-1?Q?vIRlHHF7GSXSMWlh6Ud9grzNSdUodut16I2AqhCrlJDUQ3p3u+4h+BhZfF?=
 =?iso-8859-1?Q?q2XMAfQD26YZ2fqvr0w9zo2Pkg1qWPd95CM66Fct4+WLM2/1Ni21VsyGbY?=
 =?iso-8859-1?Q?A5qGhBKtd3D30S8bUMbioWPqojdJAKDmEWfk/plIxmZG7PXnYwwo/DX3gg?=
 =?iso-8859-1?Q?aWEhMatlVYk51b67Hi/n3+yEzCYl5aP5c3YkcKwP5BeTgrK0fokNQXVpWd?=
 =?iso-8859-1?Q?ZRMCSG1257zUgFvh4KFb/stqfCYCEo0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
	fs9mS8oLK934AbAv7sP+QcZOLTP9HJDN6bBM26iU70OoU0u9L476WAcWNzo3pWwrfuOGRmwNfiyK8BIovcTRAeXWHN91ybgQQvPSGz9xuFRAKyJcbQ//E4ogAVf9YvPw3ZgBnLGyGAWBdFnNV35QpkgqyBBkbh7qu2wC+fXz5mlv+TG0X+PcUeKu2oVoU2h4OIhPsGTzjONsSw7LhKU5/troq1QatYacYmF5eNkfFePuACUBEycvV0h/1EKvOF0v9FBe9r+s4mZM3GgQCcsVOhErwXT1UywS5E5do876djpZF6y+BsiWctwzSDNtRT0c9SAEFOt5r5Q60srIXyJZ2A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	18Icy5kpdp3p2aBd2NCHfCRklDW4zhJtodu4ulBNumLDNl+7oEVx6r6dNC1OROAil+yQMdpItfOGeFwXorpmONyfVXeam2l1K7GV466sd8JG8f+Bjb3xEr0WQcAz2k+YGczkgk7TxNFUlEa2jySUlTi+d4RtfUT5JCzPutv/M64h2PzGg2zf+ZpMNslaXlZZBsy/udKV1bGEccc2/MU5NHtFHspCBx6M66W3rppBsZNTkTthZSpkf5D7f6/KEZumKjH4i5FqEHlsltWOuO52oX+R0wmzy6B7+VIIohrPxpJA3uHl+CkBSQCOoRl+G+kduw4jgKz0ZEm+PUALq6tTMmhznW8TGca96ZEJG6gC/2dNGpopRLvlQj74zsQAhfiuvltfauAowRr8pzBdBVQZiIcVZz9Ory8QsuRmWwfSAYrdbXWkm58t5+X4gipiCGW6pdfCrpOh4Qyj7ZguAR6lMWQnqit11CI0nnM9Ih7XGlEzKHQu9EMSVJoUOvMBdzOzOgyqzC4kJ8aiSZRsnC2b0DkaO4b9sHYAMMfrNUjV/VkYAD8wz2LWgYo419yLYT23Vh/Qej2cXr/N0KbwgMTJ6L+MsVXAwPjCBzbR8Yjj6t4=
X-OriginatorOrg: electrifex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e607e99-3652-4762-a044-08df3bccfd37
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 06:12:51.7394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f2626450-e675-4872-bae6-db17376f7643
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNrsvxk12GDh4AIerzNrZrUvoOYDsWK6G9ShM7ME3w4dfb/85h7r1M9KObA9BkEn/QUMTuF1Fn+I5TTU82OpWq4z0tKcDniQHa9O+jErHfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5PR01MB12822
X-TM-AS-ERS: 40.107.51.91-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30302.005
X-TMASE-Result: 10-3.165300-7.000000
X-TMASE-MatchedRID: 9iO6RCDEnJdtj953YDPlOn0R968WXL3fzURsIup2lU4c9rEVpV2JbDas
	lHciyNgL60WHnr36f3PU9FvFs/hd5YGwLl3VtQvHnwLkKEwNiIGq0ui/bxZsSeU0ANNKseCV12q
	/FSZ4puYBGeLVeuUb8CEEB+1mvDOosh8VdhSKGElLH2YCHEpiPe5zvRYCQLoVAD+929QDkWGLz4
	gav4lvdTKT8fDhc32N1Bybflz6EmixWgw58aiOhqSYFFz3IpxkyfjF8MS6pxVBRmUI+A4g/Czec
	Bj190z12HlzhM3zNtkSb0WXk5NAD9hiRHs224+Holi4ZoiOHT8Rdd2on6IgT0pCa9ZC1tR5a99Z
	N8ko1oHxe8op5rWcZa7KrJKPYgd2PMSJlOxR7nk=
X-TMASE-XGENCLOUD: 3d2822fe-9cc3-46d3-8d9d-e6282f476921-0-0-200-0
X-TM-Addin-Auth: FuI6SvRmGisLI5Ai9NQumusbyUzpmc2fdYegASdRkK8SzaqUxHCBqNpLYuU
	dBzgbt/EA7/zlhwYmPgpy4ubVHdiJrMq9zRDbHDvvZHDX1oFbyJ+dIkXENIubFmMiyOG/1Q4mhM
	WIzf0s+EKzwJDVgz7GYjAe+Mdvb0nDjwUHRjPQO4q8lnXsAvpi3736UQ6uBZ38S0ZXvnXKieGSj
	EFqLjyuEY8SzDlcFdhoLmPO92jR5MO7BDtcbWngr3EMKDDfu5RYe8p5NlEbu9vJkl/1q8Iqll0R
	5T8gjqdidiL0s8zQ+ucuoXI6fcr+HMNqJjtJEW/HvkjEn46uaOTk0SMVWA==.PfSnaUCQAIZZ5s
	PLgbUyjwL0r70oK/Q1Kv1ll/1KqotdA13J48gWkVOVEfpm+oaIXgH0WLNhSTcHuZc0ESuCvOTxx
	RBoDVGAxMCo0J/Dmhr9DcOtPcUb2P7P7YNBaDoajCziWArBhGXS7h2Wz73zTXcGYsfGzTCxmVYL
	dzYJ7VMQTfWypnLQ2aTz3MVLUYnqlj4QwqnSArG2fksD4k9oqkAh1XI7RohD2O0y+Hte/h8n0QB
	t4xoGLB0I6WRO9FzBsRjw96cbBClymRULB1MULdniFgj3C4IqXeeaGwfCxuLSXHjcsS2hM5dwNU
	Og2a6WMnsBmPhJWYeEAhuf2/xFog==
X-TM-Addin-ProductCode: EMS
X-TM-Deliver-Signature: 746D2270CAD07B84B82E09CAADFAFFBB

In the AF_XDP zero-copy RX path, frames that the XDP program passes to=0A=
the stack are handed over by stmmac_dispatch_skb_zc(). That function=0A=
increments rx_pkt_n instead of rx_packets since=0A=
commit 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where ne=
cessary").=0A=
=0A=
stmmac_rx_zc() already adds every processed frame to rx_pkt_n, so each=0A=
XDP_PASS frame is counted twice there, and rx_packets, which=0A=
ndo_get_stats64() reports, never counts them: on a zero-copy queue=0A=
rx_bytes grows with the passed frames while rx_packets stays still.=0A=
=0A=
Count the frame in rx_packets, as the regular RX path and the code=0A=
before that commit did.=0A=
=0A=
Found while testing AF_XDP zero-copy on an ADSP-SC598 (adi-dwmac,=0A=
100 Mbit/s link): rx_pkt_n grew almost twice as fast as the frames the=0A=
MAC delivered, while "ip -s link" counted almost none.=0A=
=0A=
Tested on that board with a 6.18-based kernel, whose zero-copy RX=0A=
accounting matches net. An AF_XDP zero-copy socket on queue 0 received=0A=
frames of one EtherType while UDP traffic was passed to the stack. In a=0A=
run with 60 s of traffic before the change, rx_pkt_n was 1.88 times the=0A=
frames that reached the driver (MAC frames minus RX FIFO overflows) and=0A=
"ip -s link" counted 55 RX packets. In the same test with the change,=0A=
rx_pkt_n equals the frames that reached the driver and rx_packets equals=0A=
the frames passed to the stack.=0A=
=0A=
Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where ne=
cessary")=0A=
Signed-off-by: Anandu Padinhare <Anandu.Padinhare@electrifex.com>=0A=
---=0A=
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c=0A=
index a2177777727e..f8dceafdda2d 100644=0A=
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c=0A=
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c=0A=
@@ -5587,7 +5587,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv=
 *priv, u32 queue,=0A=
 	napi_gro_receive(&ch->rxtx_napi, skb);=0A=
 =0A=
 	u64_stats_update_begin(&rxq_stats->napi_syncp);=0A=
-	u64_stats_inc(&rxq_stats->napi.rx_pkt_n);=0A=
+	u64_stats_inc(&rxq_stats->napi.rx_packets);=0A=
 	u64_stats_add(&rxq_stats->napi.rx_bytes, len);=0A=
 	u64_stats_update_end(&rxq_stats->napi_syncp);=0A=
 }=0A=
=0A=
base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1=0A=
