Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793626536;
	b=o6eZ6jEAk2u75m8h6T++3WfBZZg8dDOWvKyNUbGa9zdKgeMvr6qU5sr0Pqka1Ko6xas4
	 KNNF4eFZushJ6rUrYew5sY+KGxPaQ5gUUuN3YHgceZKL+sii2bpZh1PCtjrUEwXqGErWl
	 ZdIKaJ2p3AJZKRu34GPi5Hk1UANSI6jUDTyrHuL8Ip+1SBy1G9fQBf4qgamBpvkiZgSZa
	 t3ebdPYzW9HI4r+R99+Sv8oMJjX0Vyj+mydEG47RuBa/yzRp/+1mtY4qXMb9ql1JNkb9S
	 G1UHw+QTZL9yLPbu3WvJnItNZ2Fk6+wWPnJYDW17s0DXNVFYK/dhSsLrl6mO4wJ0H5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626536;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zVNRr3Rx5yv7vL2g9aFRqQUNiCBStnWj4jxRh3M7R0o=;
	b=pxVvFDaE1wWQdZMqrRj4t8tDPU4l21IMOkJdACeMzZlS3KrFMiQOHjxvmOTwnF0BA+wD
	 ujxwN7WmPUsXGAV+swtxgntf/hyGHwsNxBFbcNUyVlQjB+vwnwmE1wR0U9vRJgW+8CJwP
	 vus/sIlMrDXOYLjOFkbt0wwCkOAeLbpxrsFiEI6DwyWb7Reke8gnp9xHu7p80znEIg3EZ
	 HyWKK/JIB76mfyZGHVd852O9ryJCShan1dbjBpHXpDsRSPCWDS56gRv1O3TMWTFIjWZIc
	 /XtOkKD0vSkKFH7Nhs6vltOE7oOUGFohojZ8OtT5WYLZLKQyKwFFlxjQZNH649/C8kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pascal-audio.com;
	spf=pass smtp.mailfrom=pascal-audio.com;
	dkim=pass header.d=pascal-audio.com header.i=@pascal-audio.com header.a=rsa-sha256 header.s=selector1 header.b=fZbzYlkz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.120
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023120.outbound.protection.outlook.com [52.101.72.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC73606A336;
	Mon,  2 Nov 2026 13:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FC73606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pascal-audio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pascal-audio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pascal-audio.com header.i=@pascal-audio.com header.a=rsa-sha256 header.s=selector1 header.b=fZbzYlkz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxT9KAsW4GH9QBUx3leibfkJdsjg1Li2q+UR55sGEUDSy02Qh51KVUL8TNOEg5I71CbGILpDZ3vdbPaoA6r4kSG6OSwjW83Ho7HxSuaTLZN9ZhsGRM4NkUxNqynbrGDrutwab4xmpgck9jF189m0M8lOqnWCekDXQnonEnyJwNX3KmDk8DMUXZaHxwTlvooXDtYg3pSUx5hYVDq4KQPDy9arBBnattQfS4/5GLeWQ2a7ep94VJZQQ4Exw3UgNJ8vYNKMhJDPYfNxrJmRcr7t0CL9c6RCO45nKWbIwQAE6l5DwkhDCJ1yq3RIeJD/h2cbFmHV2li/OivaMmN/Fe2p2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVNRr3Rx5yv7vL2g9aFRqQUNiCBStnWj4jxRh3M7R0o=;
 b=DBOepxVZqDDKqPDZHD1Ufs36lQGSi82wfBCHspOhf6innSOCBbskH2xcal5w1jAYSGbBgYyWqCfE3A/1Z0oO+69aL6a2JHpISgyBn/k3y9y0KytE/gLtYUAQ4NGgJ1PQBoBJA3I+IBNnLgdVrQE/l58uxt2YNKUlHhRLFuiTbk7Iw9/JyYnCe9WM2OgtvOa5AzFgVJcN8BXFOisCAYjH+/Xir4+OAd2HuRdX0GqWA9dXWZyLHdBG9xBvL259Jhgkd7EIzhKESxFVUBAXkw0SqDbbH3gAUcm9di1U7ttjTOb/7LQvoHEk+vyTmFp/v7Pn6A7yCX+R94bkRd8wwjj28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pascal-audio.com; dmarc=pass action=none
 header.from=pascal-audio.com; dkim=pass header.d=pascal-audio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pascal-audio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVNRr3Rx5yv7vL2g9aFRqQUNiCBStnWj4jxRh3M7R0o=;
 b=fZbzYlkz/b5BB9qefBhyUXqbICrIiGcU1o39zsK4A4Ak9GGbU9yPRPRJRqAKCtV+bNou0ii4aXTB+h5JECwoip860eDPrxV0zpHkqh2AtdlsTG9Jh3bgIYOPQFC8964BBTAdrWA1AMv005Pl2w2bBSdbxfW3ENfsGTlwd6cNGGk=
Received: from AS8PR05MB9908.eurprd05.prod.outlook.com (2603:10a6:20b:5b6::8)
 by DBBPR05MB11228.eurprd05.prod.outlook.com (2603:10a6:10:536::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:35:32 +0000
Received: from AS8PR05MB9908.eurprd05.prod.outlook.com
 ([fe80::523b:691e:1203:cd72]) by AS8PR05MB9908.eurprd05.prod.outlook.com
 ([fe80::523b:691e:1203:cd72%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:35:32 +0000
From: Jesper Lyager Nielsen <jln@pascal-audio.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Martin Kaistra <martin.kaistra@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: keep port and direction
 when matching PTPv1 TX timestamps
Thread-Topic: [PATCH net] net: ethernet: ti: am65-cpts: keep port and
 direction when matching PTPv1 TX timestamps
Thread-Index: AQHdaHFbruj7HTG+oEit5wVAObNI/LcaOB4AgACU9Aw=
Date: Mon, 2 Nov 2026 13:35:32 +0000
Message-ID:
 <AS8PR05MB9908A5534BB1DD88BDC4685C8A6A2@AS8PR05MB9908.eurprd05.prod.outlook.com>
References: <20261030-am65-cpts-ptpv1-v1-1-0bb4c370d970@pascal-audio.com>
 <810b7cc3-fa53-4be7-a519-bc289c94d9f3@ti.com>
In-Reply-To: <810b7cc3-fa53-4be7-a519-bc289c94d9f3@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pascal-audio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB9908:EE_|DBBPR05MB11228:EE_
x-ms-office365-filtering-correlation-id: 9e97d94f-f81e-4eda-aad3-08df38e62ac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|38070700021|56012099006|4143699003|261021121427099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003;
x-microsoft-antispam-message-info:
 3keBGWxmyN7pTroKcBH2cWj+BMqm6kWqu6HHZNbO/ZYm78nwzD7xd565xk7mCYK0vhDdZaDhFkimvtxdZ1VwxvrhzR+ENEyRj0F+XhyuOQJnvB8MNaHFHMd3FauWxvG2k37EG5DDx1J0B4Gcq7KrhUlDedMb1S5bls2Gs6q9alsQTTkEzb5pVkmPDcN8xZP8KnoYlcL3gbiK1Z/5QeMgWJQWCW91EEtqTRjVrDg47jE7FJL4BcSc7U7dedq0KwC6GbCx+YFvkJNZI5x9f/i1gWFpStvPkfTy2lgK7K6W4YF2ipegacpiJyut8GbACoExUcquEuNOR/tnniL6FGLu7VJfUlPBNzcfjhB2rMpx+umw08y0wPqjFgyrWCo9TrJWE07NWvIc3Wwnfh1KZ9m4wYLk/4H0LMESju+yMoNozX7KYbZqmeTCC2BUo3xpkWT848n1UiaLWZB+tseVxYFXfapUHccdns5QG7oxXJuwF+/UELwMnUacPTDdrB1v0SosdeEkEJSvZvCEKOq/njPCMByhwSpjtrpCcofskRfch1u6C/t35Huydx+MpYiNV/GRPHjHBlOSWTZA7Pp0gAMrAYeEfmgPKj7Ybs0CItYsCPfQThzwyS9OZpjpSg5PdBlHDnL0Hv4WbsB/UM2+6IHtA9DE77XZ+DWitTXRA874wDE5m5ynH9cIqr+0fkBYyXhOOw6jDOUuYxYPMamgTR+HTZZhF4vBEHHSkm+atA13bVo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB9908.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Y34H5WSLTDxyHxFDvYFt2h8j4nWzKNrVUqOv928gZLSoYfveS1rCg3z+A4?=
 =?iso-8859-1?Q?I175sdqAgUQBEAwhHDONQFTKChT2f2nRauDBoEma946Q963+FXjJfYHdnN?=
 =?iso-8859-1?Q?LiUpcNg8RPFV7h7HfTOcTS/5S2YC/ePraKTE6s8y3s1snuLZR0nI533V86?=
 =?iso-8859-1?Q?tJyvcNnCrarc0ZY8WN1eO/omCi1Ltt5PHCFigybxjxwYR9CGWHW9fxZ19E?=
 =?iso-8859-1?Q?+Y2vtLF2kRw9bwCyLhnHM8hNZWxUZM/7jDavab6gT+imYCpH2Ek2iMNvWU?=
 =?iso-8859-1?Q?y3+vVjrO3LoS8A4vtVA0ArpEDwOBv8b4rfhQv5qw6fZs6gusb8FKFvFzmT?=
 =?iso-8859-1?Q?zC3BIwQcV/q3MVGnzSXvYl0ykVmMvBLrzi3ThBNVtSotSPw2JRVzCBsqJZ?=
 =?iso-8859-1?Q?cj2fch4rEQjzi9l4mDuzwxekaZm8h0SCyRkSGfijyPhjbARuVKYJ3hD1PP?=
 =?iso-8859-1?Q?PrZ/7BlxC0LVPT/pzRpJd35s1nNnZdhyz6kwAMVl1a1EbUAXyvAeUOMmvg?=
 =?iso-8859-1?Q?Z4ENVmqkshSuJUOfp3mcX5DZels2T7Av3U8IjNn8NcsCTMLo/QuNfRiywI?=
 =?iso-8859-1?Q?+THMaNpF4tXHlGFrsudaHXk160r0U15LAmYNmLPG+8u+njNLmzkUJTYjhn?=
 =?iso-8859-1?Q?kPNe7dklilTg7zbTdVHkeI56DbyfhaVPYZSef0HTSPTZOgp7xCcf2SA1WV?=
 =?iso-8859-1?Q?Lp3CYw00JNXxYtqv/TrBMOakKcd4gcqQFHqfFeUwS/kyz2vKwolvEI3bKl?=
 =?iso-8859-1?Q?rBz80W+HYkDGDBKxK6kZEvisZ+5MgaAs8zytJyGa8M0nBIlteu245j+p/5?=
 =?iso-8859-1?Q?vlWm0bW03rB5JcFqHLoz7wKWNLefYYQpPaI95VOKzRcdXtR1iKHnhvQ397?=
 =?iso-8859-1?Q?BDSc+ETp79fOLiu57gweBEVPVoY1CZB8Tiw88KKkyomJhfurvb/5b4oQHv?=
 =?iso-8859-1?Q?o6iXvvEyf39tB8KDKx0X59cXkSiJKxACO0mx+aQVhCFRq/V++PlqIV4zhc?=
 =?iso-8859-1?Q?O7OmgeQPVZ26Ox502Ta6R1S0iivRObbajzJ0XFhqZtx9tmlXmbBgiA9f9T?=
 =?iso-8859-1?Q?xZbbObM05nxJZyxf/ginT1eLE6bHl08uKxHMyx/ivxxgcrlVKd7U8KxfGz?=
 =?iso-8859-1?Q?UKUCYKhOoCmPC8u/6W1Z4cFxnjfHtslScLKWalpcIBTH+XwaOXKbAd2P+v?=
 =?iso-8859-1?Q?GuUwVgTvmkSRhGoZfcsBMfW2VubC7LDbw3FPROqQ5+/+SiOjZ7wXPhMcfV?=
 =?iso-8859-1?Q?OWX/zxEJY00cxO4byu+iUq+evQyjlnJUbt4eF19OFuYgZgWCF+8UoQgmVF?=
 =?iso-8859-1?Q?296qEDpVqPDcVka7X3AxllgiBmynN9U4SulTUR/xx8cKVK1vVBqJnbdBaO?=
 =?iso-8859-1?Q?6/9JLkfrebj3FkIMY99/fUWa/MdvDyi76jD6vj4fXXMj68Nfqh/zT/16Ly?=
 =?iso-8859-1?Q?/3ULE6Fnpmeyn3IveTLgoBAOrlJ1UMYHE7tBaZvMwGS82zdQ9D4rlolsFy?=
 =?iso-8859-1?Q?ypUNpSfJ16pU26XFJjucu5XY5p11hdUyDYeQfjg6HvUUjOoeGfpPG4fnOs?=
 =?iso-8859-1?Q?G8ex+P5HEtQHb3HC/TBwNvx0HIMXCfJylTshdqcuXQorypsg6EpxWUMCn2?=
 =?iso-8859-1?Q?AbgEuxA0yVbvGPeLMNtFN1/UCicVEhr9b6K809lIhfDK72cppZ5Aq+T+cL?=
 =?iso-8859-1?Q?tefAPZBch6lh8X+B8rszYux6dRm2tpBHNO14LoZL1ILt/XDzYvGQgoVbgb?=
 =?iso-8859-1?Q?uxsYTyCuDZGdXJ9XQ7oPTViaR5UHTCTyCp4DAvrd5diMwX?=
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
X-OriginatorOrg: pascal-audio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB9908.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e97d94f-f81e-4eda-aad3-08df38e62ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 13:35:32.0817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9d8a222-2b31-41c0-af69-79ccc4b45602
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewCCIqUhfymhT5cg0sm8jR2HZAogBy/sG7Er07O2dum9HeKiGJtgnalmr2UbACqiE5AIA8d2oH614EL5yXwoqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB11228

Hi Siddharth,=0A=
=0A=
Thanks for looking at this.=0A=
=0A=
On 10/30/26 ..., Siddharth Vadapalli wrote:=0A=
>> For PTPv1 this defeats=0A=
>> commit a23c657e332f ("net: ethernet: ti: am65-cpsw: Use also port number=
 to identify timestamps").=0A=
>=0A=
> nitpick: This could be wrapped as done for the previous instance above.=
=0A=
=0A=
Will do in v2.=0A=
=0A=
>> With a PTPv1 master on both ports=0A=
>> whose sequence ids run in step (e.g. a Dante device with primary and=0A=
>=0A=
> Does this mean there are two PTP grandmasters? Is CPSW configured in EMAC=
=0A=
> mode or Switch mode? Is the PTP application bound to both network=0A=
> interfaces?=0A=
=0A=
CPSW is in multi-port MAC (EMAC) mode: eth0 and eth1 are separate=0A=
interfaces with their own addresses on two physically separate networks,=0A=
there is no bridge between them.=0A=
=0A=
This is Dante network redundancy. The audio device is connected to a=0A=
primary network (eth1) and a completely separate secondary network=0A=
(eth0), and every Dante device sends the same audio on both. There is a=0A=
single PTP application (Audinate's PTPv1 daemon), one process bound to=0A=
both interfaces, using hardware timestamps on both.=0A=
=0A=
So there is one clock, the CPTS, and one PTP instance. When that device=0A=
is elected leader, it is the master on each of the two networks, with=0A=
each port sending Sync/Follow_Up into its own network, both timestamped=0A=
by the same CPTS. Each network has exactly one master; it is the same=0A=
device and the same time base on both, much like a boundary clock or=0A=
ptp4l with two ports sharing one PHC.=0A=
=0A=
The daemon keeps a sequence counter per port. When both ports start at=0A=
the same time, the counters run in step, so Sync N leaves on eth0 and=0A=
eth1 within microseconds of each other. That is when the same-seqid=0A=
event of the other port can be matched.=0A=
=0A=
> nitpick: Unlike other subsystems, comments in netdev do not have an empty=
=0A=
> line at the start.=0A=
=0A=
Will fix in v2. I'll wait for your review of the code before sending it.=0A=
=0A=
Thanks,=0A=
Jesper=0A=
