Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AA3FC5AB;
	Mon, 13 Jul 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944041; cv=none; b=qK8GRKKA6LQDPyLRdFpuoz/Cw3Om2Hy9ikL8S/nA8GxJXEoUVdT6oePdA07KrOCbFv2CM/EFX6LH9vLiY/yRCSRHn9CAQXwe4uZwIMcNO6YYWX17d/3Rvs5Iodb9GVzb5o4K1f/WFxy4Z0dcp1wMNz6KHGTupfi7Y/NAgZ7FCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944041; c=relaxed/simple;
	bh=qm3xUzh4E0ywYBwCFEH/i8xmIC0wMJQmeILIW6rSEP8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=QBFyuk8SBmW+HL40MS5qTIziLT/0MMdiznTVcSr2/cmB04r2zhOkDwEJorO2jfENHhD5dy0YXLricw3x8k+l0aUr200gQ6h7gdTuhBtHovf1YoHSB0lICAOZ2dGq0I1W+0bnCWo/pDar+eFVZTuXBY6/EoKHE/YOFsHymY+AA+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c2Vrxy6o; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c2Vrxy6o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 078E64E40D87;
	Mon, 13 Jul 2026 12:00:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6F9460341;
	Mon, 13 Jul 2026 12:00:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 875BF11BD2EA8;
	Mon, 13 Jul 2026 14:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783944035; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5Z60738iah/NhBHLA0grqgv2G2DvvCyo3+0QyK5b82Y=;
	b=c2Vrxy6oBYBaaN0IVFd3ZlwoSo3uw4YmRQE81dpQW95RW0nIaj/teJDrUgPu3y85MUmTFT
	kcwx32knfeqTdoFpQ0j3At7D2nHkMbql3QT+rZ2M+uiRULJFfkqQJtl/iDG3jtnIoCS88z
	B+WSruSB9u9QvjZHMHnEvv7tUJs9YnwV5UfpNg3i+ASzDkASKx8KuJ6tPFaTeyJvaCzOwY
	cyeAGiQ6zpIO9FmjBeOaw8MdzWGxznH9feYswDtll3yr9tT6mIaIhwTukBeyltBtkucuSQ
	a58Gtka2P0ZD0GbJxrbb+slHSq5HPzwfnVYVz3LyjDGqdLALvroleEeeXP8cMw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 14:00:29 +0200
Message-Id: <DJXFDPIB17FW.2BN105BPCBSKB@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v3 06/15] net: macb: allocate tieoff descriptor
 once across device lifetime
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-6-00268d5b1502@bootlin.com>
 <6e449ee7d40ec885e8a53fa18fe70e86@tipi-net.de>
In-Reply-To: <6e449ee7d40ec885e8a53fa18fe70e86@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jul 2, 2026 at 12:54 PM CEST, Nicolai Buchwitz wrote:
> On 1.7.2026 17:59, Th=C3=A9o Lebrun wrote:
>> The tieoff descriptor is a RX DMA descriptor ring of size one. It gets
>> configured onto queues for Wake-on-LAN during system-wide suspend when
>> hardware does not support disabling individual queues
>> (MACB_CAPS_QUEUE_DISABLE).
>>=20
>> MACB/GEM driver allocates it alongside the main RX ring
>> inside macb_alloc() at open. Free is done by macb_free() at close.
>>=20
>> Change to allocate once at probe and free on probe failure or device
>> removal. This makes the tieoff descriptor lifetime much longer,
>> avoiding repeating coherent buffer allocation on each open/close cycle.
>>=20
>> Main benefit: we dissociate its lifetime from the main ring's lifetime.
>> That way there is less work to be doing on resources (re)alloc. This
>> currently happens on close/open, but will soon also happen on context
>> swap operations (set_ringparam, change_mtu, set_channels, etc).
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 75=20
>> +++++++++++++++++---------------
>>  1 file changed, 41 insertions(+), 34 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c=20
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 8b52122bc134..951a7f080225 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
>> [...]
>
>>  static void macb_init_rings(struct macb *bp)
>> @@ -2832,8 +2801,6 @@ static void macb_init_rings(struct macb *bp)
>>  	bp->queues[0].tx_head =3D 0;
>>  	bp->queues[0].tx_tail =3D 0;
>>  	desc->ctrl |=3D MACB_BIT(TX_WRAP);
>> -
>> -	macb_init_tieoff(bp);
>>  }
>>=20
>>  static void macb_reset_hw(struct macb *bp)
>> @@ -5518,6 +5485,38 @@ static int eyeq5_init(struct platform_device=20
>> *pdev)
>>  	return ret;
>>  }
>>=20
>> +static int macb_alloc_tieoff(struct macb *bp)
>> +{
>> +	/* Tieoff is a workaround in case HW cannot disable queues, for PM.=20
>> */
>> +	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
>> +		return 0;
>
> Before, the tieoff was allocated in macb_alloc(), which the at91ether=20
> path
> never called. Now it's allocated from macb_probe() for all variants,=20
> gated only
> on MACB_CAPS_QUEUE_DISABLE, so EMAC gets a coherent descriptor it never=
=20
> uses.
>
> Add MACB_CAPS_MACB_IS_EMAC to the if statement?

Clearly. That EMAC distinction keeps being annoying.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

