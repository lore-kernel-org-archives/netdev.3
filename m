Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E333AD52D
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729551; cv=fail; b=D61v8FmPAPeINh6thqDNwC/OEnfT2lV/AIUEl2pNitz0TkkNfrMLgcTBocH+5oFC511cC0wkcPj2vCmaej9yVIsTiUCfXIv54YwaxMr3jJsi37JcjJcVLJlyZpdYqbXdI2FIQZnfqSFv8SD20NgDV/Pp4emeZ8zeHpO494h7fXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729551; c=relaxed/simple;
	bh=onAa58bk0yxl7nhYPrtDZdXKuUZXIWHBskrSkvLU9wg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EuRO6wd0LMT6XVnS4xVfLquRJ0pUm17zqs7S+qaBohO2NxiU4SVNxTIDQe6jTZsNGTG+jxBEBWYgjpF85bTM2wj6k12Ys5FYEi+uMpP9cDkhwPfXoOJQHbuRDftVLr6HBDp1j+uNWANHiqEX/P7N74HyWgXpWpwu3Yte7IrO1VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=K5t/gVV8; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="K5t/gVV8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjTw1jsoHPFvSlu9g6dxdV2MUbLlM+9f4sGh1gd4ghue3+F9zC+8xALZ/P2doDe+7Jkt/9LVoYEm/JGVF8E/hnM69wpVIs+QhtZVRgW14tBkaTZgBBp2wZIuP6w1JDvxDIHBqjJa2a8LRCfPaQl7RCl2Cp/1hCawKLwfYZ9hhbUfXl0WV+r+EPoqhIzU3Jx8YefaMXqi53ypwC6D0KFgK7u9A8ZK74f7yphDHfUvB4JKJYadINk5PBd//mdatduNdhA63XMb5nhSF6V9YxuUHpL+OFio4GmSUAQtRpHWuNuYc5v0lfRKlVgg5MlqnmR5tvpYR3QI8QmNe5kUtbasQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJxg1etIyg9SuKXQlBWEqzhUUQU2pUlcqLEH1X70Sgg=;
 b=FWnXHi68yto00OoQshMDv3arbSKDu3bstymxwBZ5qtO1rohVuCvqZbM3m8iw89h+k1qgJw0lXTA1lf6fdjh3jTrk2f66+CYKnjClxYR8xoUjPfYyA9e1tP0F6vgAYm6k2NedwrM03MVlF23ZEC6JXd+cgYP03w+J6gp7pyPA7G+bhcGroGGWEsrRIMoFdregmEnLEq0czjo560acopf2iZUMKh0nOxrfppW0TwimxQVjcNOvSX/aTkC2GCVJCbsKS9k+yZtZ/ukcPUTp/1ORQxOcbt7Bah8qa3ltQv27CN5j7LalBpyV5y2fki+7ENoONgpb8iN5FH+fBnbsGg5hLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJxg1etIyg9SuKXQlBWEqzhUUQU2pUlcqLEH1X70Sgg=;
 b=K5t/gVV83Hn9Q13CRzH7BrwVwxmHB3thq8ILcUXjxSRNTbGV2wVUG2A0FMSKSqVaFPvzKetwt9OCSJIlCz9tnl1Ze7cXY1tXFZXaaY6HA9BQSli+38HPVytNjfdwu6CxlzYnPOnLy76h29/yQeK2LcLUmsVeu8SaYn8pWAd6nZiG6TGBeSh3nWWNvraHdBC3VWeLW2bKN+eWDFLPVE3kxrG2qQ9IV/euDiYxWbhnpNzZY3Qwavq2GvnW71U3fWLeIm7yncLSpALlabyWTBHHKgT2K5mLKRoaLMvLDpnAs1pKGql/nQn3V9RYlWj+tMS4h2pbrZydZJVdFZEnTX76Ow==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA3P189MB3262.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4b6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.8; Wed, 26 Aug 2026 07:32:26 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 07:32:26 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Srilatha Addanki <saddanki@fortinet.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>
Subject: Re: [TIPC] Enabling an already-enabled bearer triggers brief link
 flap (~243ms down) despite 1000ms tolerance
Thread-Topic: [TIPC] Enabling an already-enabled bearer triggers brief link
 flap (~243ms down) despite 1000ms tolerance
Thread-Index: AQHdNL/5gg/ZiuzKC0+waAp0eE4DvravIHDwgADJzBs=
Date: Wed, 26 Aug 2026 07:32:26 +0000
Message-ID:
 <GV1P189MB1988D232DCFFF279C4EC4595C6AE2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <BN3SPRMB0002D8DE46CAA989F8F3961CB3AF2@BN3SPRMB0002.namprd18.prod.outlook.com>
 <BN3SPRMB00020EA67E11CAB28D9EBE6AB3AF2@BN3SPRMB0002.namprd18.prod.outlook.com>
In-Reply-To:
 <BN3SPRMB00020EA67E11CAB28D9EBE6AB3AF2@BN3SPRMB0002.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA3P189MB3262:EE_
x-ms-office365-filtering-correlation-id: e6bd6fbf-81e7-4d49-c225-08df03442d5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|10067099003|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Q/gtGe+TH3ErHH4HN6/EpPIftBbrP+wOKFtpBfHKIok4xXhJJPjXXpzACZjqgCsf/+Hm5dzyZpULU8CpBqmhuzOoZwhJnO+WcngtvedpqN03DHlLAgbgEmZ6ceKJtRJfADDXM/XLYOe95hA8BtuHS5BTZXDd9+ddRKTCcEcRlWpI4W/7bgtwWDTiUslawVzoSULuPmEFzpmxB20ts8O/GEMKK2LI+5PHIPKeXe883swI7kuFIMgKrGskWd3T85m3KjyeQ4Oz9+uyNI1HycQzf65ISjhf4p9y0qibZPX+dB52C1BFCoaIKapRZwVturqj7IjxUn2k61PgPsZVGGXNGdpFSEpuMGiEmvM9VKxzmMofCxlfh7YXs3bn67M4Ffc6QdYalvkoHvgIkqpeHNb0DTOntu8CT0bR+tXCBytLJ8OQ/dE941iGDOCBL42pkXsoF7BEWul4DwkT8MG07jJKDvFLSpnJ2OuvCC7ZaqjM5cvZ2WEuSFITtentxvclD4v8RpBVZQEVSETufJ3S5hzqkDKVnnDqI1IYkiDhA4XKZvpLZYivM/A1lDFa9KWX1XVzeLSalz0Q6KUhd1HU+zF3iA94IEEaTe+C2cKY5GtDBZG+Vo0XfGZr9kOsvlur1jUQqGMtRahOOGcOXCnRE0HkiT1+OtiaiO+g/X38NMkZVreQF++bxRAs3FkF3OQw4NwBbkshCPokdG8z1OxA8XGhGyFncQI333PH42prreljCxk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oX2hMXJNZfKiuD5/gcM5OgywwOZSkLmrR4id6IUGeKjmC34muC1wRyS/zM?=
 =?iso-8859-1?Q?UkBXV7xcpQZxw5zcw2lJSGBLVvy1JNI4I0ZV0kBrUdPPbFnsYyIYcz+7pb?=
 =?iso-8859-1?Q?F85HjG3m3pCqV0npOjknlZawjCwZmD0WkkUki8Rc6n0nAzI9IENIr6fM+6?=
 =?iso-8859-1?Q?xe8TjcGWu7aFatuL6sODziBPQ9OEOuj3M7YexHkQnqvqoa3RMQHOAHNH/U?=
 =?iso-8859-1?Q?i+BGdisBSwCwZR+ZVBOVuTxK8PCRMv9ZZ5mPAmVKYwob47ehgt53Qp6rk/?=
 =?iso-8859-1?Q?PfYdB1lfpG1BHL4+1tJwn1mYDjxdCSq4aB/ngRQ1Hld0vm4rzI8SXhYwBQ?=
 =?iso-8859-1?Q?PCQKr6aVhtdEUDdMmm/muezDbABbwiafsDIKu0geXjViJZTE8zZ3xAu1eL?=
 =?iso-8859-1?Q?hY7PJ78DQycb+MnUQvYan+1sDLnGUTlbbA+0gXpznC+4/U1eBi27GO2jQz?=
 =?iso-8859-1?Q?aZo/WkNtYW5TjbBpusS7GDhY5+ySaFbQmVlHT/sg6Rj62EoA9oEA5qwLEk?=
 =?iso-8859-1?Q?OWyB1hA37s4NJbNCnoL8uIgvsP75UtWtMloOjv9i4Of1HSlTTT9ESa1KcV?=
 =?iso-8859-1?Q?Bum/By3893UpetxCy8cMhthr7vTFwo0KERdx+Rw+SI97de4eYRlyPvVDjg?=
 =?iso-8859-1?Q?yW1dqsf1YUre2KAXf3Zg4bof4QqPiDm0Swz6xKngVmWmwSl5/fD67eEenP?=
 =?iso-8859-1?Q?8lrbmQlG7jPsqW10tNiNxrlzhxX/TJHTbxesxgZYXWtnB1BsYrxcbJqhFD?=
 =?iso-8859-1?Q?wrvDDwYS60UAIdF+CXLzHhms/MFJ8clwvWgZ8w1XP0HVZU1wltMBcsgmGI?=
 =?iso-8859-1?Q?7JEhUq0OhMgbOdDHzcWp1lJmgx+vZCjpvdq0rZ0fDyz+BsnapUlojvRHWu?=
 =?iso-8859-1?Q?Qa1Ii6ZlDqk7MLLpnSwDtjMKL9o8ztJVVGCrWfZlyMXOjPU5KjpAwTb+2F?=
 =?iso-8859-1?Q?ZBiXx4XKrkMmoeFeqWV7q0G5O5cqGOyynrkVRDUuY8l6WG2c3Z5LQNKmab?=
 =?iso-8859-1?Q?zEf+0IiIHkdPSq9wfJs18Mjgy/c2cvB0qrMFTJmXohG3rLvH4QqT5XkANQ?=
 =?iso-8859-1?Q?HxDHMRKt4oPkX96KugESjT/qt8p9oWkfTmYxs3ujAjSpsnXHSyE5txZQ5F?=
 =?iso-8859-1?Q?DmZehSE+vWghd1BhW90aSeBvG2lxDFaPMEJ28qT/GRtt4ZBt1OvuxX6tEn?=
 =?iso-8859-1?Q?Aw8f8ruhOpjcBCcR20ls74iDwBKFzoZ8GVpOWRP8Sv88We3tqrffJZhlWf?=
 =?iso-8859-1?Q?XJujSYlknvcvhUah6YoLLVefVWPqzdFX4OAsCv2rka2sTQ277kyBg/CinV?=
 =?iso-8859-1?Q?zlrx1N6SIPDU+WjAdMh5cUF9ro9EMdqhRkLFSMdbg6cTWUmbTEnVhvUv2s?=
 =?iso-8859-1?Q?G+orPVpqjeOLoHAwkjwgNupKtKsOxavZXbh6ACGh+3vye5XlwhWLxalYzV?=
 =?iso-8859-1?Q?WgpaIXO6i71H2//VBBe76hIeCrc+SQT/H/Fpq/3rdipMEFytcOkINJ2f/z?=
 =?iso-8859-1?Q?0iazGlDAJWFZVm8SCfQFsPZJ8SA+GN3VMn4zViCEIb7VdhP80q0kdNrOPZ?=
 =?iso-8859-1?Q?01LwnTTJNNCCfvfG/Z1zw2YRr9Q+fEZ9eLSV1aW/VpoJ+CzT+t0SAI62CU?=
 =?iso-8859-1?Q?HsxYZ1M13kVrrQSWgWsgBRemawh3vRqJ5nCQJa22qmxatSt2l2rl4AxMse?=
 =?iso-8859-1?Q?HsmLzjB5M/a1rn/SJnNihtRj1LVHJ9PSgu7qDVZ9xz87srQ4v47gDEdkRc?=
 =?iso-8859-1?Q?+ETcDl1zg1hzJDh6jVwN35/Syt9K+DRe1S9iKwmbRvEfWV2dGeDyIiiriR?=
 =?iso-8859-1?Q?HBe0l3MZgA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bd6fbf-81e7-4d49-c225-08df03442d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 07:32:26.3184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/yo5OuWeiBWw2X39MtVJftaCtPY4RZokZuKx8S1UE3PCsj6ohBBxKkaldY59ddaOnN0qg5dapP/R7pSEgsPHnSYwSAq6c0iRDFDS7zS4Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P189MB3262

> Subject: [TIPC] Enabling an already-enabled bearer triggers brief link fl=
ap (~243ms down) despite 1000ms tolerance=0A=
=0A=
> Questions:=0A=
>  1. Behavior: Is re-enabling an already-enabled bearer expected to reset =
the link?=0A=
=0A=
No, re-enabling an active bearer does not reset that bearer/link. TIPC kern=
el rejects that command and returns error message "Error: Already enabled".=
=0A=
=0A=
>  2. Tolerance: Why does the link go down for 200ms when tolerance is 1000=
ms?=0A=
=0A=
There is no relation between tolerance and duration of down link,=0A=
=0A=
> 3. API Design: Is there an idempotency option for bearer enable?=0A=
=0A=
I do not understand this question. Can you give an example of the "option" =
you expect to have ?=0A=
=0A=
=0A=
