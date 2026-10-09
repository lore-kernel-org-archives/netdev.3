Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5994F7965;
	Fri,  9 Oct 2026 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570221; cv=fail; b=rjvUgYUij1Kx4q0aPjzZ+p4wxi5EeIzj9diehVJb6ulEN2j0CeMhbXciYDuenSGz9CvJ0Kcpk50M2emKDzlfG6RHrtR1eiDqq/KH0+iIDKO3x9UO58jCzYXW00pHDWTku3UuC3SR1ygNBZr1UCz8XvO8OCM7FlHCWZD3Ziiizpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570221; c=relaxed/simple;
	bh=jaqmT95i48lm9+uMDU4ORGzUa7V6I3ebXqwFSfTvau8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BcME7u5/FhEnjb6w0eTBV9bXkHpTTT8SW+267TeCX2HqrzzqQGjhujkvldl8eImYB0kdV+KtaXxvSKoNKhINJLyrErGKtv0BlD0C9rKt9zU8fDzUfVp+Kj/ulr9oAzBcYCTflCJtri9QLcPcI3bJW/5f0LAR/Hvd7Kdg/XQ9Qb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=NGun7C5S; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=kguMWKSw; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="NGun7C5S";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="kguMWKSw"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7F53C24D774;
	Fri,  9 Oct 2026 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=SUO++Xpa2AedQbqpcMY8K8QXAGvINpBJFMF83mkv2Jc=;
 b=NGun7C5SHM55OcDnLUJFGq00SZCbWtUQtRs9GHZMkmCoKP2+7cDdP0x/gJVjZUbehdNrXxy9n3+07c8DmrLjHNzYoZFkv14nawmCHvQFPDIaFPm27c4UM2I/ARSYKdQdO/KiQlchAPTiUbfpTyAYuUVwnTSfmzpEIUGGDDzgUcZ43u4wdYy7T7gYDFpq4VhrY7Pj0BE3xo524rLlkYlsWI5cfgUp/F+6JdTJ65N0U0CuF4Q8Wz8sTUyJcEUZurrl/8IZ0X0ul0Mfzqaoluv2Dc34yYP4hS1kr271ILenYF5eXBpVkonpa2Xud8D4EaqyD+ilu/wPRZUaERBDz7zncg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022092.outbound.protection.outlook.com [40.107.209.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DBDD710006C;
	Fri,  9 Oct 2026 18:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWp+oEqdo9Htp73MknnROJfTzCRWrF7NKwzlNfs2R4adayBl7USG52nIa0d5tK2lBTEgZovbIWfSawhot3u22fZ1YY6FVUQiFx8MQ7MuRm0PxAIhTm2bkOMhEfJZ0ElZMfhPEAsxge5I0/OjCu0XMd8PscCjOZUn1xH7vBefimuQzOHrJk+uRs+LZBJaAyuJUIs4xJxT5X/7VD3oJlzQlmV86OLJrN9bxxIk8r2SCpVQn/Kf/ICF3zTgPe7BbEJ/hvu4fW9HLl2Z5/CKmhs9LfGw4RuShejJ/rR7X488LQQVWyJCmJx4njsVPae9fB1F/BnjhGLi9/uLNd+KpTe/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUO++Xpa2AedQbqpcMY8K8QXAGvINpBJFMF83mkv2Jc=;
 b=M30mF6ety+tp55ozujbUbdoDik1fSEzNHazIfHhR+OtJK/KsgeumAvvHYdL2Pl0al4QYTZfZe0xM1UZ7Cm6GNudb76eNWE/H6LHzyEo5hvHAMh3AIUQ5LIbvIgq0FGYy96TI0jjgFA9WSlVjH6JD5p+aGVZvI1LgWoWUE2s4gm5pEldrNBYoSDa01rlgYXrhOkkaAX7k6mdZZ4Q/ABTxodSbyk76npwxpy+DBYqfCMs2AdT4q02STqYFnh8zZuqcIjyiMCwKCmCjfgji7/ClJfUvPgFqfGQMrZhZ1xl6lmQ1dl3ziF/7mkB7FibsMsRtULfesqKZ4wsrYOrsK27XVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUO++Xpa2AedQbqpcMY8K8QXAGvINpBJFMF83mkv2Jc=;
 b=kguMWKSwQPvekxOrOP9um2eQyXAojjSr50ym9m4/2qbt2frvEvDp6JHdDhHQmHwo2mTJH4XlKHa3I0QYyiyIEhHy3/2KXlV/kyK/Y8g6PHsCRQvfjJY14X9GL6Ck9vdul1WIVf6z6mZ/tM1CrX7fgkmgm0ftgawHAikAPp0oJSIbKKbITfXXqbL0qqmqGA6iE0CXnWvaHIs8ZAdYDLqOUvE2A0DZYqc+mzN7p5Z2AQhL4xUPgUXdHeqZTggcksQ+CoVPxZm11PmKGd9iLj+4K0mzeTg89SvMfw2HFuR8hujmQJ+eqF5DtMmpf9rqS3vAMm2KZCf7qm9PgL52Pcxk7A==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH9PR20MB007164.namprd20.prod.outlook.com
 (2603:10b6:610:314::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:27 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:27 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 08/13] dpll: sit9531x: add support to get and
 set priority on input pins
Thread-Topic: [PATCH net-next v11 08/13] dpll: sit9531x: add support to get
 and set priority on input pins
Thread-Index: AQHdUTSjYJab91Weo0yHPNESYimFVLbuKhUAgAdqBQA=
Date: Fri, 9 Oct 2026 18:23:27 +0000
Message-ID: <20261009182323.76166-6-arouhi@sitime.com>
References: <179116260241.434549.7401028968217040174@kernel.org>
In-Reply-To: <179116260241.434549.7401028968217040174@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH9PR20MB007164:EE_
x-ms-office365-filtering-correlation-id: 6da584f0-bc1a-49fc-a8db-08df263269ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|38070700021|56012099006|22082099003|10067099003|6133799003;
x-microsoft-antispam-message-info:
 vhsIZ7SJJVNVvDJHRcwKFFxFVD7zheEomjXAoMRE3gxFLREw1Tk9Si3xdLLeDVveOHKsFAYvE/evwE5EDXbvOD5y8odRL2Couv4a0MzOGAIH+CedLk7yCbicxTO7/vBVZ/brboeBQmdb7B4NEc1sT38kzrzrNVIs+VhKPlM3Vh0SeGnZCO1t+Nh4aNkczqvH7XDCx4ug8Qlzb3WJGlj57t/xWDoqKDj+4rofSl2FTM4Mohg1KQor0olXSh8+j8M5qHYWgbDwSFOThWkNhixv9PxL3inkdhlc7VPe080YBPvVXuHFgAF0u+a02aqmqY/5RjTWkUZ778E44KOkOBybhL1aFt/lsc8CRXx0JjHX2EUd49hjA2vZM0qGsBiXHhcFJs3L4IkwUp1WxIXuW5g03gUASAWGG8wD2Cktg7gTgbWca5mARtA00VgGeV/fJ7tri/NoDL5C26nvldVAyjC1TcnisMAN9S9Mtb5mkbiFLEi4lDdBX9L61DNPcDCkgFr4QxJHJAbS32haiq8PZWHtapuWs2OpwokGmSIs5L/kLvpiAWhWtAZn13CIhDEIpDNH4L9WwJ1ZsAy3kt4EV26p+cEFbHvhbTkJOrPliyabt4mL7SLFX8v6WvZb7l+ucprYOtpd5/nZu1hjvZ1E8hfOtPvxBzrm5dd3gqP+6YxDMzHSQtSbHJbR8Uxeh85Weomuzr//nT31w7HZ24/xV/uqNED+o42mWh5wxyQaZrm/UkU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(56012099006)(22082099003)(10067099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zkrgz/zJ+CHQ9r28Ejl65YGkhU0VLoJuhYmLuhWQ++d9BpiSP9SyO6Z9Vd?=
 =?iso-8859-1?Q?JIiQKnC7d0JTHFgGXj+4wMXB4WYFNcOfy1nenrUvZqkwyPfn7F98tz/Gn3?=
 =?iso-8859-1?Q?OYcPp2FrzGA6caUMAZTr2pb1aSjCpM1jPIUPEKIlOTLqYugptILtuzMieQ?=
 =?iso-8859-1?Q?XVbDwxLBr0WWfiIeYarH1kPzUwiTmEmU015kIs+cMP8JhEygqAodKklU1a?=
 =?iso-8859-1?Q?HGJhE7IhSl+LU3oXJsJ3Tt8c+4ZIjS3F+EQAbXdXQcFvA9UMdYAw1+sRml?=
 =?iso-8859-1?Q?78S2zKU8zA7LQTlZv65ZjFXyxAzeKSKZHkb0RA8ncR6MZqVc4jha2UZmO5?=
 =?iso-8859-1?Q?Q6jbd+yUSjLQh7GawjXULM3x88sH/WBLXHOiGY/njhknb0Pol9++xzk1w9?=
 =?iso-8859-1?Q?4B+Jb954fLFsPybJyyLw5UvWlLCtVKSjNVC9HBi2QTJAGP04zeaNo9C+km?=
 =?iso-8859-1?Q?NvnUw4oZp89gFv6Bl5J02GImwBo+6HPZtYUYwk4qintxCcIHdpnFLjfqBH?=
 =?iso-8859-1?Q?l93TBUFW+wGB0pehVotEibfy4fSsDKaHsxY6ljqw21hCNrlHO1gbLiVPQq?=
 =?iso-8859-1?Q?zHNe5okzYHUYKEeDvkwwD9DszeiASZRSVmvs6fWK+D2D+fw6DTVw2tly2O?=
 =?iso-8859-1?Q?Q0xurt0nJMAeg8eWxKOjO/m9IGF7kOHep8E2HHilWtR1APdxvXn802C68v?=
 =?iso-8859-1?Q?PfBXw0h2l9u+hNOWVkLBD17rxtbIABno/DGtR2aQM8VI9B7igrfLjBZkNH?=
 =?iso-8859-1?Q?rfeLIA+0ceclpmypMTu/45GsxvYq1njuCSYKwpXhui1B8ULVi7V1EbXOle?=
 =?iso-8859-1?Q?YiCw2H/kf7v6NsA3aclHcVeb8Yt6eNIv2lYWRfqVvEzdX4xpc1PNiNC3tQ?=
 =?iso-8859-1?Q?URxvUa3kmR+3Tn2dYR/iCmTXENFoLFuVBEfsWfbMX6XmWtQMAcUKsuZyOK?=
 =?iso-8859-1?Q?ZP3I6U5Gz/7LFb35UxKWm/b7Xrya15LU92imTeYJMr1ebTneGnqBwKAQor?=
 =?iso-8859-1?Q?D+Tzc97wwyat6TANl05nH7H2RuCpNibQmCKsbEWCIgzfrRfjW07FCtU5Am?=
 =?iso-8859-1?Q?i7dYRcTuGGzzpnCWICjeqlmIRb8nC1nmsdxFtaVwPHBQgAIewgBKyyNZ/l?=
 =?iso-8859-1?Q?x3ro4YSHQNC0Nw+DV/11dldmirGyxKTXEWxJvNs9UJ09kNpfsgaMnQwZ9B?=
 =?iso-8859-1?Q?1uoxi+MhOl505HtqVernMXiHzB6+43nwkcbPv2B2wQk5pDIAe3ZMuww6o6?=
 =?iso-8859-1?Q?/gIaINOH/Fjkp6+VYa0Pm1A9kHMFjgtCvf46u7WendF3bhHqAPMa0O3RYK?=
 =?iso-8859-1?Q?V75b+LFbBac8pEuQKDoVBV13izvw1seB3iWpWkk31l9JB984ySzTH+MHRR?=
 =?iso-8859-1?Q?x9YcN2FYLO+17AV1LmQl1E6+W+9rvqEu/XD6kD6Aqr2UQu8L/h7vot0t5r?=
 =?iso-8859-1?Q?WVuSDQJ4GWdeRYR+QV22e5oWsgKareSe3jJ7XLV5WaHLoXp18vNHs3ZZ1x?=
 =?iso-8859-1?Q?2vQRapm2jkR2EpP5xkZXWX04pnR5AQgTnh4+BAG33KKw9BU2kV1TXjpwhT?=
 =?iso-8859-1?Q?dtAYRI8FaBbu+Y+MzHVVJa5Qwaz+qpUiqBcx+ukSiEIsruy073UEVg0Bd+?=
 =?iso-8859-1?Q?/pcMpSWuJXdEseognJo4b0RYMphhikI/hNbqYYHKoAkCP1dK6fdfj+T0C3?=
 =?iso-8859-1?Q?cgIIo7QXxjbwy/tq8aIG9uaom6zvdlvTwipZy3lpJGJsSRk3eQFdeXlU1a?=
 =?iso-8859-1?Q?YQZaCbPLFm/dJm1oaAPMesMcfHTNcBLLyY8MySi2HUmZef?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	u6VjKvH6JGooWY335Myy+dzRp+dkY+tjbnASrzbHViMH97UhDytEpnkqz8Be8RrheilEfzPEpxcN8D1Mz5fJUVsgwzNldNKsqSsjaqeZdOAKqcjjba1+A+78QK6GZMBNHu9/tyaEAaQHtlGUFoNIEo6lu8+DWVSKuo6wxpeJZKoLxibGKCxoPbccEcv2fNT+XZv/nqYBK0Cq5JwVXMpDIKTQGxPI9+aeAI+MIJTxHZJTL8Xe93GAA+bRDWPr8oRuggal/vHhNUTi68xizfOBQyRaCVYxbS6squn61MnwrCfR3RRVf90wMXZH2fi2bcm84J1+63hOkb5TxkBtbH5VzA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da584f0-bc1a-49fc-a8db-08df263269ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:27.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBfgLHBK65wxVvwpXebBrlNWfOiGquXkMKLYgx5kvz38YRkv7MDzotIRmUMu0ebSE/nM8AEMO0gBLfsutLB+2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR20MB007164
X-MDID: 1791570211-OqS5LfiPtLai
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570211;OqS5LfiPtLai;<arouhi@sitime.com>;5de2396b9b83917d02f0372d9ae54394
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, netdev-bot+sashiko@kernel.org wrote:=0A=
=0A=
Replies inline, in the order of the summary list.=0A=
=0A=
> [Severity: Medium]=0A=
> If the table write fails, does the driver keep the rejected priority=0A=
> anyway? sit9531x_input_prio_set() commits the new value before calling=0A=
> the step that can fail:=0A=
>=0A=
> [...]=0A=
>=0A=
>   - prio_get reports a priority that the device rejected.=0A=
>   - The next poll sees cfg_prio !=3D pin->prio and sends=0A=
>     dpll_pin_change_ntf() for a priority the device never took.=0A=
=0A=
Fixed, and answered on 07/13 as well: the configured priority and its=0A=
known flag are saved before the apply and put back when it fails.=0A=
=0A=
> [Severity: Medium]=0A=
> Can the first poll pass silently absorb a real operstate or priority=0A=
> change?=0A=
>=0A=
> [...]=0A=
>=0A=
> This patch adds operstate and prio to the comparison, so those attributes=
=0A=
> now share the gap. The cache is already valid at registration, so could=
=0A=
> the baseline be taken there instead?=0A=
=0A=
Fixed, and taken there: a pin's baseline -- state, operational state and=0A=
priority -- is taken when the pin is registered, under the device lock,=0A=
rather than by the first tick, so a change between the probe-time fetch=0A=
and that tick is reported instead of absorbed. The per-pin "seen" flag is=
=0A=
gone with it; every listed pin has a baseline before the poll can reach=0A=
it.=0A=
=0A=
> [Severity: Medium]=0A=
> With prio_set now available to userspace, can a reorder steer the PLL=0A=
> onto an input whose monitor has disqualified it? sit9531x_prio_src_live()=
=0A=
> only looks at LOS:=0A=
>=0A=
> [...]=0A=
>=0A=
> That seems to contradict the commit message, which says "it takes the=0A=
> first slot of its priority table whose signal is qualified".=0A=
=0A=
The code is self-consistent: sit9531x_prio_src_live() means "has signal",=
=0A=
and the selection, the ACTIVE operational state and the commit all use=0A=
that one meaning.=0A=
=0A=
The commit message said "qualified", which is the monitor's stronger=0A=
condition, and that word was wrong; it now says "has signal". The driver=0A=
does not veto an input on drift.=0A=
=0A=
> [Severity: Low]=0A=
> Is the claim that "only the named pin changes" accurate when the reorder=
=0A=
> moves the active reference?=0A=
>=0A=
> [...]=0A=
>=0A=
> The sibling pins, and the corrected operstate, are only notified by the=
=0A=
> next poll, up to SIT9531X_STATUS_POLL_MS later.=0A=
=0A=
The claim is about priorities and is accurate for them: setting one=0A=
input's priority moves no other input's priority, so the core's own=0A=
notification for the named pin covers the attribute that changed.=0A=
=0A=
The operational state is a different attribute. When the reorder puts=0A=
another live source first, the active reference moves, and that shows in=0A=
the siblings' operstate on the next poll, up to one period later. The=0A=
period is 500 ms and a re-selection itself takes the PLL several seconds=0A=
to relock, so the report trails the device by less than the device trails=
=0A=
the request.=0A=
=0A=
The kernel-doc and the commit message now say "priority" where they said=0A=
"pin", and the message says the siblings follow on the next poll.=0A=
