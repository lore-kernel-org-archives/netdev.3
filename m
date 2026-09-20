Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021121.outbound.protection.outlook.com [52.101.65.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA772DECBA;
	Sun, 20 Sep 2026 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789931342; cv=fail; b=MusZP4t52ANQHIKcAtDC+jE0zX+fZALLj9WQcFl7KXFg+YmxyJbfZhyx2lfHzYAcwhl+q5eiWG24Q0Kf3FzCaBv859zl0V6Ao4zC3t3/6RS2Zlo4XRi0/NCK7azIL1cLhxAyL2P+BvNv0SE/+STjNWcy0EgY8CfTFqv40FlzlBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789931342; c=relaxed/simple;
	bh=qE+huoo/RzHEJ5zaLWQWtHF/AKNzDHzIL3vwlRxHnqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UuojWr9qr5FJAvczDsepXFxEUPsvt6F7jNDTkmtiQHAAweLMA06HfrsAdWpgNrru84sBokNSJ7+LvRtAt529T0Zc5XwhmrCvd0E76tXEn6jVHRq4GtuJ+2k6SWPMDdycOftQrp6jvhQ6+gTOzcqjm0MEgynSbL8Dp7HJN84/meE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=studio.unibo.it; spf=pass smtp.mailfrom=studio.unibo.it; dkim=pass (2048-bit key) header.d=studio.unibo.it header.i=@studio.unibo.it header.b=vz2vDTP7; arc=fail smtp.client-ip=52.101.65.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=studio.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=studio.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=studio.unibo.it header.i=@studio.unibo.it header.b="vz2vDTP7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srO6qrZPIIoWFM4dLaLreqX9mXaUV1jpgj84M55vmqj8aTT6Nd5fx9W0SpeNE+sbTBtZqV7rVuP0gWhhV48DWtnYagOU0soycKd9GeKygRgVBz/URfC2Z9qGAjizt1Q0d0j8TN5ZYonU9KIkUznJTfEwqvuY4Z/ncAZXG5fy5V38frZqVlRwiffhcgMsfabIole/n3X7yavzAjTxuTU7nvEFxAv8+RfnNqDKB5VSPNvXa2TqyTCi9Ku95sBQwIXqmA8yRzZlVBYPpCRZzWS5GqO54kd84R+nbFz8GhcCCT3vr3SyV7KHN2Gv91MJQmqIKZfZ7uT9jqDXM63Ew8SUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRMTcsujZrF4iu4i/k90eSnJ7Fqcwo/InQHeyqvsgAE=;
 b=R/4ETOtRheK0LDuvIUPwkEuitKMxSZmkcKEO9+bnTYl7SnOhZAmk5pix7xm17ZterarkIOWnnk3RHD0fF94S6yoow6yT9yqyXxalrz71rW7CG3Y2r5RWXLE4FQK8u0w7e9WrbW3L9m7asWvoYMsYpqWTzZtrJNg8QOk9TiqUG9orwj+eQ2SgY7lVguYEpCcsh6Sk0xKzXhykvKZFsGgnRg2qZ1edNjvbel+q/UtnQ1Nup12up6M4YyaJVJ4+Rn0yLQzuKqvIw9fFqtrgZ+rvIPEsooL9kjnZGN9+18iI3gPyHVgAQNLAyVOKPXyZkPj7Oo9EumZ3604JDiVTHRDPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=studio.unibo.it; dmarc=pass action=none
 header.from=studio.unibo.it; dkim=pass header.d=studio.unibo.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studio.unibo.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRMTcsujZrF4iu4i/k90eSnJ7Fqcwo/InQHeyqvsgAE=;
 b=vz2vDTP7z9irFcrhTQzKgs8ODtHmvGCw8oG9WetHnEie15fz8UZsjAPJaskSo+uXmzFFtvrm4LNwcHGJc7/Wbw1c8mhVVBw61lVd1S6n4oH9D4vhv90jy21qmcT17nSTO0uKiwaNjgdOngR1IH34Kz5m8LSLTqJLz5OpvdZmZhwGLQgIRTLWgEJT7vaKn7L/el14ed70OPCYNkgL+Ll6jiwqjqNeORK6O6pnfHj7nQYq47Jbjw9L2g3nzBsTafHCJnjGKsiKguPMMsK2lvYnliy8/nxfJGIYsBBsRMW15SJzm/rOFJ+jc+0hCANUt7CixSfX+tNX/E51hJC+R7LuuA==
Received: from DU4PR01MB12163.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:620::18) by PA4PR01MB7183.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:f6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 19:08:57 +0000
Received: from DU4PR01MB12163.eurprd01.prod.exchangelabs.com
 ([fe80::bffd:753f:fbcc:c402]) by
 DU4PR01MB12163.eurprd01.prod.exchangelabs.com ([fe80::bffd:753f:fbcc:c402%6])
 with mapi id 15.21.0428.015; Sun, 20 Sep 2026 19:08:57 +0000
From: =?iso-8859-1?Q?Nicol=F2_Giuliani_-_nicolo=2Egiuliani6=40studio=2Eunibo=2E?=
 =?iso-8859-1?Q?it?= <nicolo.giuliani6@studio.unibo.it>
To: Andrew Lunn <andrew@lunn.ch>
CC: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: R: R: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if the
 TAI period is invalid
Thread-Topic: R: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if the
 TAI period is invalid
Thread-Index: AQHdSHBd+pGZ8FgfBki6KEuSlYSfVLbXjVuAgAAtc+WAABhkgIAAAq6S
Date: Sun, 20 Sep 2026 19:08:57 +0000
Message-ID:
 <DU4PR01MB12163D71C8AF5C7695B2FB8BD80852@DU4PR01MB12163.eurprd01.prod.exchangelabs.com>
References: <20260919-send-net-v1-1-4355c72465ee@studio.unibo.it>
 <66937bde-51a0-49d2-9ae7-f27fb4f8ecde@lunn.ch>
 <DU4PR01MB12163870875DEF21E5C39DD2D80852@DU4PR01MB12163.eurprd01.prod.exchangelabs.com>
 <fde8b48a-10ed-46fd-b477-18ac57df8a88@lunn.ch>
In-Reply-To: <fde8b48a-10ed-46fd-b477-18ac57df8a88@lunn.ch>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=studio.unibo.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4PR01MB12163:EE_|PA4PR01MB7183:EE_
x-ms-office365-filtering-correlation-id: 699d255a-6749-4998-716f-08df174a9f1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|786006|376014|23010399003|10067099003|11063799006|3023799007|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 lNn5b48dgNlK9uXoSlClex3Hrv81T2X6i8Wotsp2bwO4PVn+e1b+F3xJUSuih2ChFlD1GCIXuQdptdieJrts/Ugyj0PW9c7EoqyDN34QOn1bNhKezf5Pe7Gr1vV7lCXmPvFW/VeOFWGd2LU2tLCPxaaod88+4/lyFd9tQ86A0axBCJm6qJOQDRMXCazmo8g6UvKY+XhqkseaVDa0fsmwxoW/P++u6TkGBzmyK2gLAk2OclXgerqV4rJpqm+ktqdBcOpYf6QA76QmDCncbD2M0F0OicfjGJzeX6MpEIGc7cvh6DHS69gAXpOQP5Y6llas0l5UH9j9n/3KeStLTILWn/TWPNwPrlKP8/zh5+O9965ytFinSko+sU8NlXayPrpXCamKqJkAmhAS80LR7Sq2GoNGU51xm9vTCF57oPZ882NKxbvZPREzC5XFZFJsW9fVRb9xOYGR7VZ3Vlfjv0xsrQKQKLGaFuTl62H6Fb21raKRLp6QxO8rXg0geH1fkoy96oydIEVR+lm3jnHtvjmMNB7DADcapQ5lWUJfKGykA2SKhHXxmKIp8l2Re+YjroB91AlNW/S61oJww7m1XB/7YDJEr97/97NQdIveWfISC/YPKb/uho3xZ4a5x9qe1HDZrgL6WmA9NeExKVTeuEUuv+Be+mgr7BPAQDkuksN7Eksumy3TbFT/G1442bBaxyMtK924Je+nmdPzS366fX5ZZtppSvUm8z3Xvpepdt7Iq+g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR01MB12163.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(786006)(376014)(23010399003)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YDbV3hN6wXYA4pbUdsbCF3+8/J5UOgjIGj+rTbyf6I+nwuFPx0qCncTR2H?=
 =?iso-8859-1?Q?g/xEzlQ95rwEipoiUqG8K1bNX/U6se7L+NS0yB8eJNwidPmYVE/oD2oz69?=
 =?iso-8859-1?Q?Ct1SKfDe29ufvOlbHL7h9m6Z4RefHi8rSXXcMF9jGKR69FOoTf0nOE39D4?=
 =?iso-8859-1?Q?yJ/0Vp6VViOotqYh9QLG7ZBSvBzIlDb5EV1wTCHkfvWUrgebhMo1thGnTj?=
 =?iso-8859-1?Q?85Ei6mXC3taMMwb0YJAK/ThCOmhpA+DHSrMl5CWQptORkq58B21/hbE101?=
 =?iso-8859-1?Q?sHyegWBQAayAcLfGOpFPaXQYOKQWuRyjrT+6kvKoRxKuGcmbz0sIJA5Olh?=
 =?iso-8859-1?Q?Tl8lVImoHspGXCNX73DQSiX19Ml496SLdmRf8LV04vBRdcAy1HlXkQ95SA?=
 =?iso-8859-1?Q?8xmzCmBz22v5HxzJ6BBsMG+/Fbp3n1facDkKpmRvEbNpw/wqDo+N1f4Hyz?=
 =?iso-8859-1?Q?Pi9NGDOZmul1SFx8vsBgHo6ARQ4kNm8CtUUr4bMyrGIYCa37lz9RLXOdrN?=
 =?iso-8859-1?Q?fwJh048THv0CBf0dzo/Dw+iGXygyCfUuO2D7W2I+8SJBgUGhZ7+vGAvUbn?=
 =?iso-8859-1?Q?Cd9zuLxTjbra7hpALDuoWIWKagJE2xAdQVxlvZdK7OtkXNAv+4wU9R2G6/?=
 =?iso-8859-1?Q?+wkbW2Rjeva/cZ9HP7oj322/tlM893woxwnsLgCRN0p/JtCK5jPT12vJ41?=
 =?iso-8859-1?Q?+tJWS65bygpAbQ56VqJPWIbrdTOa12QhN+CIHUpQjYXLhZ4zhuma9XVL1F?=
 =?iso-8859-1?Q?mC1VfV6CApHaPjUT11EzdrWOQ1gC80SdT8MF9RCS5RvrEoB4nceQKblc7k?=
 =?iso-8859-1?Q?EGcqcBPyTQHPJyTlNFKxaQsH1aVff0EHBoXyXwDlPgK9botcMMiwy083rK?=
 =?iso-8859-1?Q?qI1BxKkICAkzROmvRG395Z98mxZRP72LX4I2xPWEjJBaLdKJ3ll9u651gy?=
 =?iso-8859-1?Q?520XOY+afYcUOjZ2sUpT6rH0szru0BtyLAoWJR9BHwyLf3GcPjsM3USHSG?=
 =?iso-8859-1?Q?yTPzhiLvJedQXuXHvENOjhqb6OE8jJadOisrEBKEXE4R7g80jo4sijhOzO?=
 =?iso-8859-1?Q?N3PU5c/E9Nq5UBljgNPPT+xGIeL9OtFkciXpVIeUq1YOLo6WKdAJSnqmxx?=
 =?iso-8859-1?Q?HQkI2ztuY8t7emAldKGue2yg6kw/6BQuyo/4Qb3+i6FMvxQb2IraFk5k1/?=
 =?iso-8859-1?Q?xWuRqm5dz/wUSlzohAqz6TPm9ZucZhq9aCNuSpgrBrNeNiOIXUg/uc3/UP?=
 =?iso-8859-1?Q?5VkO7aHbtUMnc2+ZvVAQcGMHcB/rG9P7ExhwRxLMKJdLCvq9CIlaemSFVj?=
 =?iso-8859-1?Q?31cng2A/mXUhTzWa05Ee0SaiNE7iyvtE7yV3BdwOnPQn24aLnMiqphVX/X?=
 =?iso-8859-1?Q?yvxW+OaLVeIKqCtp+HZvZX8M5Vrk8uRsF3tXwDdOz8+TaEn2zy8lpTUzad?=
 =?iso-8859-1?Q?eOyZbn4COWXpSrI93nE8fCbHX5vH126KKXZ3sasfjrMXJWxTnMdyDA8TLY?=
 =?iso-8859-1?Q?aR8mXmp+VwDjZ3duEJEsiZksAFSFYRpF46SQZK0PfD7ETOlSTpCbf3DPSS?=
 =?iso-8859-1?Q?fBSDL71rVqc7U29T0RWPvW9uoUDZWpV39OQz+I6N9vqXvyKXUjSCtBoumk?=
 =?iso-8859-1?Q?5XLQ1rH8Bbc8eApRa9iFFj18Illck+21OnGPKQ5Cm7xi7Tdj3U+lvAf2hS?=
 =?iso-8859-1?Q?jNxcwYXtCBV7bZkiRrrghLJsoPDy+XadKRrUCjFZQdE76YeckxWrFsfDZ5?=
 =?iso-8859-1?Q?l8BoZzPgqVrV2GIZFgBbzC/v2on1T0LYzn83X8RN2/YJ8OYiQOZY5ni2kh?=
 =?iso-8859-1?Q?GNcuKgtM2w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: studio.unibo.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4PR01MB12163.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699d255a-6749-4998-716f-08df174a9f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2026 19:08:57.4025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e99647dc-1b08-454a-bf8c-699181b389ab
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IkWf1lgk7TTR6WJ2DoWpqGnWwMqckR9GpEGU2MjTCnJIV6bjDhjakKhnJlfgPh5YUu370l+tWPh0dAIfm8IWK+Wf6nwMlDQe0dHYEbTTz/6KpDcEvCB6zplRrpcZc2aV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR01MB7183

Hi Andrew,

Thanks, that is what I needed. I checked it on the board (chip ID 0x1930, s=
o the driver entry is the 88E6193X, family 6393, which uses mv88e6390_avb_o=
ps and mv88e6352_ptp_ops):

- TAI register 0x1e reads 0x0000, so bit 14 is 0: the internal clock is sel=
ected. Register 0x01 should then hold 0x0FA0, but it reads 0x0000.
- The whole TAI global block reads zero through the driver's accessor: all =
32 registers of the TAI global, of the PTP global and of one port PTP block=
. Writing 8000 to register 0x01 and 0x8000 to register 0x00 reads back 0x00=
00.
- To see whether the block is somewhere else, I scanned the whole indirect =
space of the Global 2 AVB command/data registers (0x16/0x17): every port fi=
eld 0-31, block 0-7 and address 0-31 with the 6390 command encoding, and ev=
ery port field 0-15 with the 6352 encoding. Every read returns 0x0000. The =
only exceptions were a few reads of 0xc801, at a different place on every r=
un, which looks like an access by the driver interleaving with my raw scan,=
 not a register.
- The commands complete (the busy bit clears and there is no MDIO error), b=
ut writing a pattern to Global 2 register 0x17 or 0x16 reads back 0, while =
other Global 2 registers hold non-zero values.

So the indirect AVB interface used by the 6390 ops does not answer on this =
chip: this is not only a TAI period register that is not programmed. Either=
 the PTP unit is not reachable this way on the 6393X family, or it is not p=
resent or gated on the 88E6193X. The 6393X entries in the driver reuse the =
6390 ops, and I cannot tell from the driver whether PTP was ever verified o=
n them.

I do not have the datasheet, but you said you have others: does the 88E6393=
X family datasheet put the PTP/TAI access somewhere other than Global 2 0x1=
6/0x17, or say that the 88E6193X and 88E6191X have no PTP unit? If the acce=
ss is different, I will write a patch that fixes the ops for the family; if=
 the 88E6193X has no PTP, I will write a patch that clears ptp_support for =
it. I will not send the patch that only skips PTP.

Thanks,
Nicolo Giuliani

________________________________________
Da: Andrew Lunn <andrew@lunn.ch>
Inviato: domenica 20 settembre 2026 20:58
A: Nicol=F2 Giuliani - nicolo.giuliani6@studio.unibo.it
Cc: Vladimir Oltean; David S. Miller; Eric Dumazet; Jakub Kicinski; Paolo A=
beni; Richard Cochran; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
Oggetto: Re: R: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if th=
e TAI period is invalid

On Sun, Sep 20, 2026 at 05:34:01PM +0000, Nicol=F2 Giuliani - nicolo.giulia=
ni6@studio.unibo.it wrote:
>
> Hi Andrew,
>
> > The point of the failure is to indicate an assumption in the driver is
> > not valid, and we need to examine the assumption.
>
> You are right, and my patch only works around it.
>
> > What does the datasheet for the 88E6193X say about this register? Has
> > its meaning changed? Marvell like moving registers around, is it
> > somewhere else?
>
> I do not have the datasheet for this chip, so I cannot answer that from d=
ocumentation.

I don't have the 88E6193X either. But i do have some other datasheets.

If the device is using the internal 250MHz clock, the register is
expected to contain 0x0FA0, 4000picoseconds. If i remember correctly,
the patch which changed things was because different devices have
different internal clocks, hence the need to read it.

There is however the option to use an external clock. This is
controlled via TAI register 0x1e. If bit 14 is 0, the internal clock
is used. If 1, the external clock is used. With the external clock,
you need to write to register 0x01 what the external clock period is,
in picoseconds.

So you probably want to check what register 0x1e contains.

        Andrew
