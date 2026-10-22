Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792699200;
	b=mejFOkaO5g2xWVgMMOuPR9io6E9IK00A1k2TBzQxBOFxTJzBTHngknhv1r1x0wBDmcLm
	 7LU+PcoLJtRrwp2G80hQM1Oj0QbZgy+ujSwzjQ6GpuJp1VWFWKAErp1v3P52afBArrnYi
	 sRtnyi9q2m6ZNw99/m5Z2DxTurenvw4HoALX+r4d1thPxqVv2QOcQC/2Y0P+P080CEE+Y
	 M7aYd9KYy07Hi0DR6er1A48pd08NsygGDQS2gPa7D6lZNrtToqNkttNptDlTBQxGv5qKL
	 EiJkXIpmIdn7cmI1XYAP1x9L2xfAhoHzPZF0lbOzeuXQq1t/K1JM7E4Bs/pzQY+fl5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699200;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=5ghk9VW0nILU6M1SVCvJ/4AkamCM8tcI/LTqceqZ/1Q=;
	b=TzG/l412IAhF7iFD8acTi94DQFCVXj9jLYyXG2Qfg8HISrZ6sngmc/Hui3TJsJQT1mPq
	 TrPFL5W0tBuQbXRmmUeyg6C1XbBR9sd/PvEV3g8GzYHd7tG5H6ioDO3zHsnCdbGNh7NqQ
	 U/gx6Cu5FZEPHCxW3583S0qBXoKVA+oaqPZhMoG4+kcpsioAbQYUH0z7/zlBNZNLBgZH7
	 b7yYEtQmO46922PoZuEOsPnbaNaRnvRPMfoPmykSaFBdknsAjn353+gZIjmZ2W9SEwLf2
	 xha02kUqyF5Dl9ioqugzfi0/JAB/sRf3Dh8JxXr9VXiNIYY7DArO3HLrmQKXt+t2T7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=tLv8aLow;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.68
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A297606A319;
	Thu, 22 Oct 2026 19:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A297606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=tLv8aLow
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wipceI56qzS/V6joh69XN1oOOKEA7wu6Li1hNbJJHWEtkTNQWoDcDci9xrigE+uECoJ3mLh2ERIr1x3gIYV6O57FBr2HNTyFCbfnKKz1U/fMLbb9vPy0yrBLAnAmgAR8veBe+p9x7NO1Bc8PGOKPj0WHj+WgUftXAEl1rRx6eYSAu7f4esU9SrnuWYJ6ACBdlIAFDjjh2PSUoSM0HYUgYaR0kmx0a3ZCpTn/KFJxND5ryoin8ukRe4KpUZPDf35mUsrpwMMkdzE0+mHqAYezHDL03fiEo9I9HaGCnVEEno7O9Iv/fwVydWiEqdFPVuxS0HNGnz1/m061ZmZ55iLnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ghk9VW0nILU6M1SVCvJ/4AkamCM8tcI/LTqceqZ/1Q=;
 b=Z+V+NRFVvSqTPs8PwagtVSVZ0uk3L1Roa2eXeesLGlnQnCm8Adt16UqmVPqm1G0crZ90EZPORVEx4JD/nrocI+oyjF1LxIg9eTM3QzfXo1WGe/rl/VJL2al/ttZ76DRmdNKlYxR4uzBD8BvHHI6pMfzQ/fENQaf5Ai7oT7thisR8nM6B4LssEhOT9HV+zji0QS0QqzYkUUTlNW9ReGpnZScDNcLITKEM2UkPteg8tUodhIb383MfITQ9MRrmDRcE+4JojLAKQp2pS2zKy66GU6gYnUdHjmTS41RYvfTAcof1DXgPLgX0PZDOEwkHPiyBtLLrkN0mAB66eeGQ6VF5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ghk9VW0nILU6M1SVCvJ/4AkamCM8tcI/LTqceqZ/1Q=;
 b=tLv8aLowlOxNVuc2V3EEf1cVRbiijp9IbJ2oLMZro8L2nDHxnhgwQx4lzQBflPOry5+5I1UTS8HOG7oxzxYEQvRo2E5WDl2h7MBi/E3WeOxlNy4+Nzm0s+n3LgxcdRIafOYb8QAAJH5L9c8zXNUgzN2dMZuS1ttI2NViNhUTJj3z4PyXbrDlt9QE2rnEFDRhttOaL8tLNU4I0rZZn8kLoKjVEdLM0LRTX0y9STfN8XKwkKMkcRuYIH+yL4bmYkpimRogRYdBdJ+I0eACgu/89HFpz31dk7qGXvy1YNVBFsgRrPRCwDBa/duS3HvveukZLQ7aWqK/ymGgW+WCwUn5sw==
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by SJ2PR11MB7600.namprd11.prod.outlook.com (2603:10b6:a03:4cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 19:59:52 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%4]) with mapi id 15.21.0546.017; Thu, 22 Oct 2026
 19:59:52 +0000
From: <Woojung.Huh@microchip.com>
To: <nb@tipi-net.de>, <cbabroski@nvidia.com>
CC: <Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
	<Raju.Lakkaraju@microchip.com>, <davthompson@nvidia.com>
Subject: RE: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that
 fail to stop
Thread-Topic: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that
 fail to stop
Thread-Index: AQHdXLZWKGSR1g1QR0aAGQorZSFDpLcIciIAgAGTgFA=
Date: Thu, 22 Oct 2026 19:59:51 +0000
Message-ID:
 <BN7PR11MB28366F837E956013E2C312FFE7652@BN7PR11MB2836.namprd11.prod.outlook.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <bf487e5d01fe6352069d4314087f680fea717cc5.1792008404.git.cbabroski@nvidia.com>
 <ad9ebf0ebbb05424676b3d80b935f58c@tipi-net.de>
In-Reply-To: <ad9ebf0ebbb05424676b3d80b935f58c@tipi-net.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2836:EE_|SJ2PR11MB7600:EE_
x-ms-office365-filtering-correlation-id: ad3d3733-bdde-4bae-f56e-08df30770900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|4143699003|11063799006|38070700021|261009223027099003|261021123027099003|261021121427099003|10067099003|261021135927099003|261022105027099003|56012099006;
x-microsoft-antispam-message-info:
 1iuJixntohXyEUVR/raQEKLsOrvWTLaaq0daF2fPO5zEFQY+aV+SIXHet4znO23neoR6iNKAGyJiyuelMXviukM1bFdfBAYN+6r4+WLrWzDces1tXpkW0SnonOVZ3+MS5Cm9OAF4WFAkr7AoakXglPRdFZIX3lXalUUhn5mc32H+W9ZcSZ9rWoBB/3CjTTh3b130bPO5ZI3q4yU6S5I04V7QftSra9XzbW/WdpxZAeCBdd5LtWRTAygMUQqidNXlwSaOcQUQhiuzo3KXZZdqY3j1frgmzYqwOvE/wgbC97VbQ8iu2ZN1Sp0y8uaOVf00Ud24PJZa/+KhBnD4Bz/k8G2jJe0vpvTl35fb6uz1FdqY3EUMja/nxDz+AhDt0RqGR9vmT4+oEuea8ZDN9D67fLq/Zh2afeotp9ZlhTuoTr+c3ZLSA1xeGgKBFDrHuadGueFsqrYERBeo1cFYkwxSZcGYNACDt7ntQ4QsdAClT5X6ZAX3VqOSLPM13zw55Dy9dJPZGJBVw3oZtZU+Pqksd1BPeKQng4rodw+ZK6wmpp4ew7VG1mX86EMRqQj7jrkC6HHttUO/f+pF0LeasPWnq/Q2gVLVJiueJKYzSLD+mmemNpXyYETzYgiaY3Mf3fLidtYZkA9HDexJfPoJD0L3Iu7IsoDodH74W3lazgHbzKjvRAXewQhNtdmDHv+5HrbRTu+IJ0VHfjZULN3+fgpr1krUu+iVBdnT211Pe5k2ctM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(261021135927099003)(261022105027099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Fm6s2bJdAe7KYZe18zJNkximn1CWwmSCmWlITCygiluV9HMaEgpkiJH5rDI0?=
 =?us-ascii?Q?d6xajyM32cjjgrWTepQvw09ZKyA1Z+d8zVv68L8NC0CZggIjLeWPxFBUy43C?=
 =?us-ascii?Q?vSOcTkeGJW326Ku5IxbNWxSWmLXosOyH4wjaOXGgpkIFcRvs0/ZEtMZFSIfo?=
 =?us-ascii?Q?s1pGsyFe7BPH/0CWtdc27vjkpT6cWwV7XS3cHjjP3hD1vrTLsYMLzdPZkXey?=
 =?us-ascii?Q?dsX/h/sSSo7/CAP87i0NN/SSuv1lZFocWmia1vlGKSZwDU8Ye6ZgwwAdaXDA?=
 =?us-ascii?Q?NTqRKzEIThwLUkercui9b3kX0StNP3EBSBpCGaZ0EFGCrxdi40SXM5JHax35?=
 =?us-ascii?Q?nce2uPENlMy9GLt0MtSFAOgsZRVL6di5fGfwI9TQKcu5RdRLRDmBg8W2fbCG?=
 =?us-ascii?Q?cT4R619qB2GCb+7ksTYclyg8LM8o/pgIu3NtIG9jwqvk7HpndE0mf83CpdX3?=
 =?us-ascii?Q?PQCMHXVqBNHGlikoSuHjWs2jTukK+E1yaLqUUbzFGwxvHwykz0j5kgZ7A/F8?=
 =?us-ascii?Q?u0oVPAPRQWcrxta/f1YWndhxRMYGe98+1fQqwIU1auTmqxI/AqSx0yEPQ+kC?=
 =?us-ascii?Q?r5hhUnFVTHm3Y6SImUw988OO74JXWpaGdz6B2RPdecqMXUh4WuwjRVucquRb?=
 =?us-ascii?Q?WsBu4MewXZAwcv/jy7GRKuzTsHixmJpDBiW4AWpIzC9l/T49Ko0tpqHx3ERx?=
 =?us-ascii?Q?4+B5nO9gXzz1/IwiGzK+DBuvvHsrTgTkCEhuuFG+uKkcE2OeZ74rT3pMixLz?=
 =?us-ascii?Q?ar4H1JaObrsQsUuzv50qw3ehlx7pd1rfOoalrutVBNdfvNDoo7OOp35vtw9d?=
 =?us-ascii?Q?fU5XBsuBx00x+5vbQ1jhvUbeBi4dV1BaZVRlOFfVqjqgg7VCLRV5Upi2e/I3?=
 =?us-ascii?Q?Tr9DVCpEjHeu5ey4I7D5/rreLBLBP44Kab2NIXAFNt9LvpLrsSo2d21ZUNNM?=
 =?us-ascii?Q?9pUp8V+00kXA/Lo8O3cLzvgDjb3izJDG60mtXAC6EH3qp9vUGb9QBhFqxEK4?=
 =?us-ascii?Q?gUgr0EcM5ZJl+H87kkuWA4O0AKmib9Z7dKxq9O0ljoI7YBtoC37neh+inUmV?=
 =?us-ascii?Q?9MGey0b2S+VSMsd31y1SKhFWzvAdCovz1bNJBFbI/uKZ7pdWsBnUp+us1qjl?=
 =?us-ascii?Q?yrbcLb0yq9NneoCiZ+a5y1ejko06Sljab/K38nYGQDqEHFF4XE7uzKf3dgyK?=
 =?us-ascii?Q?aSKzmpHucgjiEjhx2fHOtam8hK2p4XzyoiaWzwf6vPhNxekztrcXhbqWWSyb?=
 =?us-ascii?Q?lLqsmc/vgOTOYdIhR8B60PqQvIkhEMEsJBit7QuHmxOGcqkTd8aZmkv4XftQ?=
 =?us-ascii?Q?sSn8ym6yuTeMQ+/fjmrV0B9W2zqp5a0FvSngLcWFHtqIVNeU2VUIN3VD4a4h?=
 =?us-ascii?Q?kJfrIcVB9qtTCKWt8QDTdgfp6LEKXoEkAgFvjkFrlbKFKnLMYjrRehalHC8M?=
 =?us-ascii?Q?nQMPtjVEWTL2hhX+LReabGyExjvlr+smssd4LPwEgLgHPj8ERkipzVUvzutI?=
 =?us-ascii?Q?QqOduWCpPvcAO3X18Jw2fHYbLUzJzYkSe1UH5sXczzg1/DVBPOGIUzuOZwoY?=
 =?us-ascii?Q?eAPq6+luqWPt4kvm8KEvEmBSP+8wBhD6aCGgicOR7dp2WwrSC1brJUx7YN+W?=
 =?us-ascii?Q?pnrAEf1rUTsFSAxvqUo9YxB26psjZjtOQ0gigFR5Fc/9MGauIXEeKMBB3m4T?=
 =?us-ascii?Q?4w85WA9SuApl7txK5Ts+IVa3OtfC+pe9/bVH4W5UMwHmva7LyRJg11Qxtzax?=
 =?us-ascii?Q?Ld+e9wrmTQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3d3733-bdde-4bae-f56e-08df30770900
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 19:59:51.9836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYjU/XNGZXbf6BdzbDDwFKuNPYV8Y0uZI0zKL4BEPxM24hner+TQ3SHejNdU18zZDrYrdGUiTPM6oA/RFkJd0kSCxDRix3SQjIikIYbI9yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7600

Hi Nicola

> > lan743x_tx_close() and lan743x_rx_close() ask the DMA controller to
> > stop
> > the channel and wait for it, but ignore the result. If the channel is
> > still stop-pending when the wait gives up, the descriptor ring, the
> > head
> > write-back buffer and the packet buffers are unmapped and freed while
> > the channel may still be fetching from or writing to them.
> >
> > A TX channel has been seen to stop making progress, with its head index
> > no longer advancing while DMAC_CMD still reports it as started. A
> > channel in that state may not honour the stop request either, and
> > closing the interface would then free memory the engine can still
> > access.
> >
> > If the channel is still stop-pending after the wait, or still reads as
> > started, issue a channel soft reset and wait for it before anything is
> > freed, and log when that happens.
> >
> > Use the same helpers for the channel resets that lan743x_tx_open() and
> > lan743x_rx_open() already open-code, and log there too if the reset
> > times out.
> >
> > Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x
> > driver")
> > Assisted-by: LLM
> > Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
> > ---
> >  drivers/net/ethernet/microchip/lan743x_main.c | 64 +++++++++++++++----
> >  1 file changed, 52 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> > b/drivers/net/ethernet/microchip/lan743x_main.c
> > index 82d3ec20ba25..9e1276cf313c 100644
> > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
>=20
> > [...]
>=20
> > @@ -2221,11 +2239,22 @@ static int lan743x_tx_ring_init(struct
> > lan743x_tx *tx)
> >  static void lan743x_tx_close(struct lan743x_tx *tx)
> >  {
> >       struct lan743x_adapter *adapter =3D tx->adapter;
> > +     int ret;
> >
> >       lan743x_csr_write(adapter,
> >                         DMAC_CMD,
> >                         DMAC_CMD_STOP_T_(tx->channel_number));
> > -     lan743x_dmac_tx_wait_till_stopped(adapter, tx->channel_number);
> > +     ret =3D lan743x_dmac_tx_wait_till_stopped(adapter, tx->channel_nu=
mber);
> > +     if (ret < 0 || ret =3D=3D DMAC_CHANNEL_STATE_STARTED) {
> > +             netdev_warn(adapter->netdev,
> > +                         "TX channel %d failed to stop, resetting it\n=
",
> > +                         tx->channel_number);
> > +             ret =3D lan743x_dmac_tx_reset(adapter, tx->channel_number=
);
> > +             if (ret)
> > +                     netdev_err(adapter->netdev,
> > +                                "TX channel %d reset timed out\n",
> > +                                tx->channel_number);
> > +     }
>=20
> While looking something up in the registers for the other thread I
> stumbled over this in AN2948 about TX_SWR_x:
>=20
> "This is an immediate reset and will cause any, in process, PCIe request
> to [be] aborted. This may likely result in a corrupt PCIe packet."
>=20
> A channel that did not stop is the one case where a request is still in
> flight, so this resets right when the datasheet says not to. Is there a
> sanctioned way to recover a channel that ignores STOP_T?
>=20
> Woojung, maybe you can say?
>=20

Understood your question.

Talking to hardware engineer whether there is a way beside hitting TX_SWR_x
in this situation. Will update when getting answered.

Best regards,
Woojung
