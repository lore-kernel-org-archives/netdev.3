Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293E4E5341;
	Mon, 19 Oct 2026 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414707; cv=none; b=IYCzeFGDvUjocsN5yym8Di0sUY8oKD1xtWchxsAYa8X5KhbfMYMKjXsAaeke2Fi6cSjN3m8PY5mXhblq3DSTmmRQvqMENDloI8L4+4V/DtnP9BFulHkSWi2dxi2+503W5xWIen7l3JrnP6uql1rpdJHIERaQrTRmsfuY03dYZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414707; c=relaxed/simple;
	bh=jkwrL9SqjiHAM4XC9CAH0pUcXzr6TDF91vmBkt3Y7+k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VilfDaFyf09e7bxt9Khk9fKuEdnrUZhFxDotc4XMBhCSS4idj9Ln1glIQT8Bb3jteLTBS1Hxx2Hfet6Xr3RvP3UznE67pgODQAeC7KtX0ucU0/bEWvnaZ8fbZqaQ3BCZLM7uV6I6yAmcLK8nMXlM/lTQUZaeGYZixm+TbAx7Rss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Tj3drLej; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Tj3drLej"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 829D8A156A;
	Mon, 19 Oct 2026 14:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792414702; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=f40FzgG6SThcTbG2AbDyY38pPngCPmk/NPimEK3lJ2o=;
	b=Tj3drLejj4yRUoSbUwI/IWkwoA1ESlO7xcjI2YsmpZnYMrQJmNz69axqttXgTRPXMYTNAQ
	X2g4Qt2PzM76OkD75oxgL81kuAAGiw/oP03KgYzCHS3gq57TI1tate+bXWyxf/R0nIJD/C
	KuHvPCl8Pq6UdCtIw8Hzbnc0PLW8JIeX4TBzbSyy/qh5khFwJhihy2VEkROGFang0Pkdn1
	usl2N0RYI/qTsBf19CmpcMwkaLvOLf9scpTJ3d1Ih2n+J3854LKcls4e0B2oDS34Kl8qbk
	TLLhaNnqN6pTZ/L5Ja04LE4cp5crK0Dw6JD/ro2lSuojGo4P9oIdasejMGePaw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 14:58:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Valerio <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next v5 3/3] net: macb: distribute evenly Tx SRAM
 segments
In-Reply-To: <20261016-macb-set-channels-v5-3-90ce0c0b8e75@bootlin.com>
References: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
 <20261016-macb-set-channels-v5-3-90ce0c0b8e75@bootlin.com>
Message-ID: <1113dac19771ff7881b60bfdd14b0af6@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 16.10.2026 18:58, Théo Lebrun wrote:
> GEM has registers to configure the Tx SRAM segments distribution across
> queues. The reset value is apprioriate (even spread) but we need to
> care if/when number of active queues is modified (or if we inherited
> unevenly initialised hardware from bootloader).
> 
> To distribute segments, we take as input the number of queues
> (bp->num_queues) and the number of segments (found inside DCFG6).
> Its output is a number of segments for each queue, formatted as
> powers-of-two (eg 2 for queue 0 means it has 2^2=4 segments).
> 
> As the distribution logic is quite complex (at least its initial
> versions had bugs), it is kunit-tested in macb_kunit.c and the
> implementation lives in macb_utils.c. To test:
> 
> ⟩ env --unset=CROSS_COMPILE make ARCH=um mrproper
> ⟩ env --unset=CROSS_COMPILE ./tools/testing/kunit/kunit.py run \
>         --kconfig_add CONFIG_NET=y \
>         --kconfig_add CONFIG_COMMON_CLK=y macb
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/Kconfig      | 12 +++++
>  drivers/net/ethernet/cadence/Makefile     |  5 +-
>  drivers/net/ethernet/cadence/macb.h       | 17 +++++++
>  drivers/net/ethernet/cadence/macb_kunit.c | 78 
> +++++++++++++++++++++++++++++++
>  drivers/net/ethernet/cadence/macb_main.c  | 19 +++++++-
>  drivers/net/ethernet/cadence/macb_utils.c | 60 
> ++++++++++++++++++++++++
>  6 files changed, 188 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/Kconfig 
> b/drivers/net/ethernet/cadence/Kconfig
> index 5b2a461dfd28..a901f74fd4ab 100644
> --- a/drivers/net/ethernet/cadence/Kconfig
> +++ b/drivers/net/ethernet/cadence/Kconfig
> @@ -51,4 +51,16 @@ config MACB_PCI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called macb_pci.
> 
> +config MACB_KUNIT_TEST
> +	tristate "KUnit test for MACB" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Build KUnit tests for the MACB driver.
> +
> +	  For more information on KUnit and unit tests in general,
> +	  please refer to the KUnit documentation.
> +
> +	  If unsure, say N.
> +
>  endif # NET_VENDOR_CADENCE
> diff --git a/drivers/net/ethernet/cadence/Makefile 
> b/drivers/net/ethernet/cadence/Makefile
> index 1f33cdca9a3c..a0740da68649 100644
> --- a/drivers/net/ethernet/cadence/Makefile
> +++ b/drivers/net/ethernet/cadence/Makefile
> @@ -2,7 +2,7 @@
>  #
>  # Makefile for the Atmel network device drivers.
>  #
> -macb-y	:= macb_main.o
> +macb-y	:= macb_main.o macb_utils.o
> 
>  ifeq ($(CONFIG_MACB_USE_HWSTAMP),y)
>  macb-y	+= macb_ptp.o
> @@ -10,3 +10,6 @@ endif
> 
>  obj-$(CONFIG_MACB) += macb.o
>  obj-$(CONFIG_MACB_PCI) += macb_pci.o
> +
> +obj-$(CONFIG_MACB_KUNIT_TEST) += macb_test.o
> +macb_test-y := macb_kunit.o macb_utils.o

With MACB=m and MACB_KUNIT_TEST=m (so allmodconfig) kbuild complains:

   drivers/net/ethernet/cadence/Makefile: macb_utils.o is added to 
multiple modules: macb macb_test

Maybe build the test into macb.ko instead, or use 
EXPORT_SYMBOL_IF_KUNIT()?

> diff --git a/drivers/net/ethernet/cadence/macb.h 
> b/drivers/net/ethernet/cadence/macb.h
> index 51835de0f2a1..60d61efbf3e4 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -194,6 +194,10 @@
>  /* Screener Type 2 match registers */
>  #define GEM_SCRT2		0x540
> 
> +/* Tx queue segment allocation */
> +#define GEM_TXQSEGALLOC_LOWER	0x05A0
> +#define GEM_TXQSEGALLOC_UPPER	0x05A4

nit: unused now?

> [...]

> diff --git a/drivers/net/ethernet/cadence/macb_kunit.c 
> b/drivers/net/ethernet/cadence/macb_kunit.c

> [...]

> +static void macb_sram_segments_test(struct kunit *test)
> +{
> +	const struct macb_sram_segments_case *p = test->param_value;
> +	u32 val = gem_sram_distribute_segments(p->num_queues, 
> p->num_segments);
> +	unsigned int i, sum_segments = 0, max_assigned_segments;
> +	unsigned int num_queues = min(p->num_queues, p->num_segments);
> +
> +	for (i = 0; i < num_queues; i++) {
> +		unsigned int q_segments = field_get(GEM_TXQSEGALLOC_MASK(i),
> +						    val);
> +
> +		q_segments = 1U << q_segments;
> +		sum_segments += q_segments;
> +		KUNIT_ASSERT_GT_MSG(test, q_segments, 0, "queue %d, val %#x",
> +				    i, val);

This can't fail, 1U << x is always at least 1.

> +	}
> +
> +	for (i = num_queues; i < MACB_MAX_QUEUES; i++) {
> +		unsigned int pow = field_get(GEM_TXQSEGALLOC_MASK(i), val);
> +
> +		KUNIT_ASSERT_EQ_MSG(test, pow, 0, "queue %d, val %#x", i, val);
> +	}
> +
> +	max_assigned_segments = min(p->num_segments,
> +				    MACB_MAX_QUEUES * num_queues);
> +	KUNIT_ASSERT_EQ_MSG(test, sum_segments, max_assigned_segments,
> +			    "val %#x", val);
> +}
> +
> +struct macb_sram_segments_case macb_sram_segments_cases[] = {

static const ... ?

> [...]

> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 2d069454795b..b70b81f51161 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3163,6 +3163,20 @@ static void macb_init_hw(struct macb *bp)
>  	if (bp->caps & MACB_CAPS_JUMBO)
>  		bp->rx_frm_len_mask = MACB_RX_JFRMLEN_MASK;
> 
> +	/* Distribute Tx SRAM segments evenly based on active number of 
> queues.
> +	 * TXQSEGALLOC is only documented for some GEM integrations.
> +	 */
> +	if (bp->caps & MACB_CAPS_TXQSEGALLOC) {
> +		unsigned int num_segments;
> +		u32 val;
> +
> +		num_segments = 1U << GEM_BFEXT(SEGMENTS_BIT_SIZE,
> +					       gem_readl(bp, DCFG6));
> +		val = gem_sram_distribute_segments(bp->num_queues,
> +						   num_segments);
> +		gem_writel(bp, TXQSEGALLOC_LOWER, val);
> +	}
> +
>  	macb_configure_dma(bp);
> 
>  	/* Enable RX partial store and forward and set watermark */
> @@ -5854,6 +5868,7 @@ static const struct macb_config zynqmp_config = {
>  	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
>  		MACB_CAPS_JUMBO |
>  		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
> +		MACB_CAPS_TXQSEGALLOC |
>  		MACB_CAPS_USRIO_HAS_MII,

AFAIU zynqmp can't change the queue count,so this only rewrites the 
reset value there?

Also, where does the limit of 8 segments per queue come from? With a 
single queue
and 16 segments half of the Tx SRAM stays unused.

> [...]

Thanks,
Nicolai
