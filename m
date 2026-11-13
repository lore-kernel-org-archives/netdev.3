Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592878;
	b=fRhbFD/osboUCjiFYTxRX3aB+HVDVDsy/Qmgx6dWQviPAShMznfTfXbcBxoA0N6u+DAZ
	 sQUvpVT0DZITA8azvnbvNynNOOtyu5M8C8Ww6KyGe4fwsoCDoMM8aD5tGmtSTe4mn9rTo
	 NMOEL4yw4uqPeXDYs1fJmJH+2uCo+vNFvHClPgf7aQOWdX35LvDIcG8nygi7iJ8L/AXCN
	 WXXYK/xlPwFXD7juybyHxe6psVNkkXeyR9lrID0pBkCrwT3PjSh3LegZL6DELJ1jF43ow
	 MsTkXX2q4D4P9R7Iou6Tw9HcmTsaLlwbSS0Ege4OZ34AxZD+i+r/tnIft5PnwWWv5Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592878;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:To:From:
	 Subject:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=dUDTpOSe78S93gTX70d7wKAS67QLAU64om/H1x2MYfI=;
	b=qqF+OqIQkmK17cTh3DeISEWC7cLoOKfiSSBTNpHK1Kk9/RSmMqlD6AweouIa9u4uof/1
	 1pcRqoe24SnEm3DW2VOghOSiXstJUuE7t5himtluvd2afUJO4Mgs//jc0fgmnsXreoKei
	 /y3UO45278GaxgHOcP2uSzWikrMcM4gtZbzTH3l1sK9Oc/07xR7JaJMTaRSpoAutItaEU
	 O/aFLNdrr/GhcJ0I3Jxf8LZGRtY4nHvSxrHa2FAzh0E5FN73XjogN+TL9SKJujHPcJQAq
	 aqeqmPQXb3jG2YEn9GDngQRfxvFrRDqoOkXzML+h6rU5Aoc/DZFanl74fc4120xHeTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JNhOU1ci;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D03606A8A8;
	Fri, 13 Nov 2026 18:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22D03606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JNhOU1ci
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 768FE1A1649;
	Fri, 13 Nov 2026 18:01:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3434C60015;
	Fri, 13 Nov 2026 18:01:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 492D811BC1271;
	Fri, 13 Nov 2026 19:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794592875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dUDTpOSe78S93gTX70d7wKAS67QLAU64om/H1x2MYfI=;
	b=JNhOU1ciCQ5jv+4qeFlBfr1bS+dgjUDm5QnQxTUbkN7oOYEid6MfYPwWWgzpqJlnDsEwjP
	1FOoyIGvNmbCLvAfE11RDLtTGZfkoSOyFH8Qd3vdAIUEgyL5+wcQlNyHPiaBbqjOyviDsZ
	AVilF+imHcj8LWP5YqNfIAzvYopQRKgC0YxJ+pJOqRv//5nLJA1M2KdoBKFqUVGjr11ruy
	+Medyy8Q2CI81QRWZ0fhM3Y5jp/AnYxeaL0Cg3pyF42YnJsb+qTywxCW1EE1BYUrCCGP7F
	Iab3gewfc9pycITlkujX1p+yCHFNp4i3ioiONyfXjovtX1Wx8DuZ3ELy4qJBTw==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 19:01:09 +0100
Message-Id: <DMUA2UVGDEMD.107M3U652ZH0X@bootlin.com>
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Paolo Valerio" <pvalerio@redhat.com>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 3/3] net: macb: distribute evenly Tx SRAM
 segments
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
 <20261016-macb-set-channels-v5-3-90ce0c0b8e75@bootlin.com>
 <1113dac19771ff7881b60bfdd14b0af6@tipi-net.de>
In-Reply-To: <1113dac19771ff7881b60bfdd14b0af6@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolai,

On Mon Oct 19, 2026 at 2:58 PM CEST, Nicolai Buchwitz wrote:
> Hi Th=C3=A9o
>
> On 16.10.2026 18:58, Th=C3=A9o Lebrun wrote:
>> GEM has registers to configure the Tx SRAM segments distribution across
>> queues. The reset value is apprioriate (even spread) but we need to
>> care if/when number of active queues is modified (or if we inherited
>> unevenly initialised hardware from bootloader).
>>=20
>> To distribute segments, we take as input the number of queues
>> (bp->num_queues) and the number of segments (found inside DCFG6).
>> Its output is a number of segments for each queue, formatted as
>> powers-of-two (eg 2 for queue 0 means it has 2^2=3D4 segments).
>>=20
>> As the distribution logic is quite complex (at least its initial
>> versions had bugs), it is kunit-tested in macb_kunit.c and the
>> implementation lives in macb_utils.c. To test:
>>=20
>> =E2=9F=A9 env --unset=3DCROSS_COMPILE make ARCH=3Dum mrproper
>> =E2=9F=A9 env --unset=3DCROSS_COMPILE ./tools/testing/kunit/kunit.py run=
 \
>>         --kconfig_add CONFIG_NET=3Dy \
>>         --kconfig_add CONFIG_COMMON_CLK=3Dy macb
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/Kconfig      | 12 +++++
>>  drivers/net/ethernet/cadence/Makefile     |  5 +-
>>  drivers/net/ethernet/cadence/macb.h       | 17 +++++++
>>  drivers/net/ethernet/cadence/macb_kunit.c | 78=20
>> +++++++++++++++++++++++++++++++
>>  drivers/net/ethernet/cadence/macb_main.c  | 19 +++++++-
>>  drivers/net/ethernet/cadence/macb_utils.c | 60=20
>> ++++++++++++++++++++++++
>>  6 files changed, 188 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/cadence/Kconfig=20
>> b/drivers/net/ethernet/cadence/Kconfig
>> index 5b2a461dfd28..a901f74fd4ab 100644
>> --- a/drivers/net/ethernet/cadence/Kconfig
>> +++ b/drivers/net/ethernet/cadence/Kconfig
>> @@ -51,4 +51,16 @@ config MACB_PCI
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called macb_pci.
>>=20
>> +config MACB_KUNIT_TEST
>> +	tristate "KUnit test for MACB" if !KUNIT_ALL_TESTS
>> +	depends on KUNIT
>> +	default KUNIT_ALL_TESTS
>> +	help
>> +	  Build KUnit tests for the MACB driver.
>> +
>> +	  For more information on KUnit and unit tests in general,
>> +	  please refer to the KUnit documentation.
>> +
>> +	  If unsure, say N.
>> +
>>  endif # NET_VENDOR_CADENCE
>> diff --git a/drivers/net/ethernet/cadence/Makefile=20
>> b/drivers/net/ethernet/cadence/Makefile
>> index 1f33cdca9a3c..a0740da68649 100644
>> --- a/drivers/net/ethernet/cadence/Makefile
>> +++ b/drivers/net/ethernet/cadence/Makefile
>> @@ -2,7 +2,7 @@
>>  #
>>  # Makefile for the Atmel network device drivers.
>>  #
>> -macb-y	:=3D macb_main.o
>> +macb-y	:=3D macb_main.o macb_utils.o
>>=20
>>  ifeq ($(CONFIG_MACB_USE_HWSTAMP),y)
>>  macb-y	+=3D macb_ptp.o
>> @@ -10,3 +10,6 @@ endif
>>=20
>>  obj-$(CONFIG_MACB) +=3D macb.o
>>  obj-$(CONFIG_MACB_PCI) +=3D macb_pci.o
>> +
>> +obj-$(CONFIG_MACB_KUNIT_TEST) +=3D macb_test.o
>> +macb_test-y :=3D macb_kunit.o macb_utils.o
>
> With MACB=3Dm and MACB_KUNIT_TEST=3Dm (so allmodconfig) kbuild complains:
>
>    drivers/net/ethernet/cadence/Makefile: macb_utils.o is added to=20
> multiple modules: macb macb_test
>
> Maybe build the test into macb.ko instead, or use=20
> EXPORT_SYMBOL_IF_KUNIT()?

This is all dropped, following recommendation from Jakub. LLM will
generate that in the future if needed (and the kunits are available on
the mailing lists anyway).

>
>> diff --git a/drivers/net/ethernet/cadence/macb.h=20
>> b/drivers/net/ethernet/cadence/macb.h
>> index 51835de0f2a1..60d61efbf3e4 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -194,6 +194,10 @@
>>  /* Screener Type 2 match registers */
>>  #define GEM_SCRT2		0x540
>>=20
>> +/* Tx queue segment allocation */
>> +#define GEM_TXQSEGALLOC_LOWER	0x05A0
>> +#define GEM_TXQSEGALLOC_UPPER	0x05A4
>
> nit: unused now?

Yes. It is unused and I kept it on purpose. I want the offset to appear
so that if there is a register offset conflict we see it straight away.

From the datasheets I aggregated, I see no conflict. But that's the kind
of offsets that could be reused if the feature is not available on a
slightly different IP.

I even thought about adding many more #defines for unused (at the
moment) offsets, to act as "documentation". We could even improve the
offset comments to export more docs from datasheets to code. Long term,
it could be useful. Anyway, this was a long rambling to say that this
offset was kept on purpose.

>> diff --git a/drivers/net/ethernet/cadence/macb_kunit.c=20
>> b/drivers/net/ethernet/cadence/macb_kunit.c
>
>> [...]
>
>> +static void macb_sram_segments_test(struct kunit *test)
>> +{
>> +	const struct macb_sram_segments_case *p =3D test->param_value;
>> +	u32 val =3D gem_sram_distribute_segments(p->num_queues,=20
>> p->num_segments);
>> +	unsigned int i, sum_segments =3D 0, max_assigned_segments;
>> +	unsigned int num_queues =3D min(p->num_queues, p->num_segments);
>> +
>> +	for (i =3D 0; i < num_queues; i++) {
>> +		unsigned int q_segments =3D field_get(GEM_TXQSEGALLOC_MASK(i),
>> +						    val);
>> +
>> +		q_segments =3D 1U << q_segments;
>> +		sum_segments +=3D q_segments;
>> +		KUNIT_ASSERT_GT_MSG(test, q_segments, 0, "queue %d, val %#x",
>> +				    i, val);
>
> This can't fail, 1U << x is always at least 1.

Code has been dropped!

>
>> +	}
>> +
>> +	for (i =3D num_queues; i < MACB_MAX_QUEUES; i++) {
>> +		unsigned int pow =3D field_get(GEM_TXQSEGALLOC_MASK(i), val);
>> +
>> +		KUNIT_ASSERT_EQ_MSG(test, pow, 0, "queue %d, val %#x", i, val);
>> +	}
>> +
>> +	max_assigned_segments =3D min(p->num_segments,
>> +				    MACB_MAX_QUEUES * num_queues);
>> +	KUNIT_ASSERT_EQ_MSG(test, sum_segments, max_assigned_segments,
>> +			    "val %#x", val);
>> +}
>> +
>> +struct macb_sram_segments_case macb_sram_segments_cases[] =3D {
>
> static const ... ?

Yes! I think some proper compiler or static analyser tooling flags could
even have warned about that.

>
>> [...]
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c=20
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 2d069454795b..b70b81f51161 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -3163,6 +3163,20 @@ static void macb_init_hw(struct macb *bp)
>>  	if (bp->caps & MACB_CAPS_JUMBO)
>>  		bp->rx_frm_len_mask =3D MACB_RX_JFRMLEN_MASK;
>>=20
>> +	/* Distribute Tx SRAM segments evenly based on active number of=20
>> queues.
>> +	 * TXQSEGALLOC is only documented for some GEM integrations.
>> +	 */
>> +	if (bp->caps & MACB_CAPS_TXQSEGALLOC) {
>> +		unsigned int num_segments;
>> +		u32 val;
>> +
>> +		num_segments =3D 1U << GEM_BFEXT(SEGMENTS_BIT_SIZE,
>> +					       gem_readl(bp, DCFG6));
>> +		val =3D gem_sram_distribute_segments(bp->num_queues,
>> +						   num_segments);
>> +		gem_writel(bp, TXQSEGALLOC_LOWER, val);
>> +	}
>> +
>>  	macb_configure_dma(bp);
>>=20
>>  	/* Enable RX partial store and forward and set watermark */
>> @@ -5854,6 +5868,7 @@ static const struct macb_config zynqmp_config =3D =
{
>>  	.caps =3D MACB_CAPS_GIGABIT_MODE_AVAILABLE |
>>  		MACB_CAPS_JUMBO |
>>  		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
>> +		MACB_CAPS_TXQSEGALLOC |
>>  		MACB_CAPS_USRIO_HAS_MII,
>
> AFAIU zynqmp can't change the queue count,so this only rewrites the=20
> reset value there?

Yes. But their datasheets indicate they support segment alloc registers
so I prefer putting the caps flag anyway.

> Also, where does the limit of 8 segments per queue come from? With a=20
> single queue
> and 16 segments half of the Tx SRAM stays unused.

Argh, I was sure I had a good reason for that so I sent V6 and wanted to
reply to you afterwards. I thought the number of bits per queue was 2,
but no it is 3 and we should have:

   num_queues=3D1 num_segments=3D16 -> TXQSEGALLOC=3D0x00000007

But currently we have:

   num_queues=3D1 num_segments=3D16 -> TXQSEGALLOC=3D0x00000003

I'm not sure if it matters; it requires HW that has much more segments
than queues. For example EyeQ5 has 4 queues (the most I am aware of,
equal to mpfs) and 16 segments. To reproduce the bug on a 4 queues
platform, we'd need 64 segments.

From the datasheets: zu+ and versal have 1 segment, EyeQ5 has 16 and
mpfs is unknown.

This will wait a bit more. I'll send myself a reply on V6 to clarify I
have pending changes.

Thanks Nicolai!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

