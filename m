Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38274550DDA;
	Wed,  9 Sep 2026 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956739; cv=none; b=TFdxJTFIW7bgj9SiBsk/evqpxzTfFXS1vQEtXYV6pG/oeB4IL4KnUMJK6lyb8sJTCm/Rqr3hMRM/6spsIP3Ppub6GnhsfF9Y3pU7eejXLkdWycScT9mJHVs2CU6IUAPgUT31LD8eupidFtAq3WJtE+a6WTfXgjbDjIz9uW3WhW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956739; c=relaxed/simple;
	bh=xMb94n5ci++ZfySiyYkZM9SC4xYqfdwapKQZj+qcWzA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=g8HDFHk0XbS+gGh7EvlDLimzJ8AIIpf4SKLVCznxW717NhB7vxtl/o2z7BI3551jEOtnEZ4PJQgpWvGOAmSaLbWGRDuvOzPUDhgqUHuIdJHsPTltlYFhyKngsSsJkcAIRtb9gOEBAIPtrV9/CzfDN+3C/6JvyTYuCYbkWpL5T34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yu5OMXoP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yu5OMXoP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 805D24E415B1;
	Wed,  9 Sep 2026 12:25:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 536D760448;
	Wed,  9 Sep 2026 12:25:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6220811C7AF96;
	Wed,  9 Sep 2026 14:25:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788956734; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=84CBflGEgtrFQdlVoKzIX6sEF0F5qk25QvC3/9WaHTg=;
	b=Yu5OMXoPK0bE0i4ZR7GbuKuVwM8SLoZB0+r2/fHXOw+PBAy+8WKuUjxkDOGkmNytu5K7BJ
	I2/V2ZeZgjR128qHJIOoHRr/+CZmx4f+V9yDHKfpgvwfVvFgj/KGw7AYXpjbLlD/UrZgWD
	v4X4lQ7NT7uP7XcVYnpv1MmWR6Xuy91YgFvyg6dzQHjVX225gRqw1tlGLMqujzlqIbEQD3
	W1peoYxyyEezzOXeA1rwpRPAMWyqjOx4JD/GSMSMje2F6Jda3PzIzBM4KMJhMoXub9jIuT
	+YfplJCnjMVYVxcdotUIWlteENaUxc94aIcj63WUhDKPj8RrFE/UjeOtaLEpHg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 14:25:30 +0200
Message-Id: <DLAS8GLF5E54.2TXTEZ229AHZI@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [RFC PATCH net] net: macb: fix ordering around PTP timestamp
 read
Cc: <netdev@vger.kernel.org>, "Richard Cochran" <richardcochran@gmail.com>,
 "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, "James Clark" <jjc@jclark.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260908053150.28694-1-jjc@jclark.com>
 <efc8c860b90e8f55882241267b0e242d@tipi-net.de>
In-Reply-To: <efc8c860b90e8f55882241267b0e242d@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolai,

On Tue Sep 8, 2026 at 11:12 AM CEST, Nicolai Buchwitz wrote:
> On 8.9.2026 07:31, James Clark wrote:
>> PTP_SYS_OFFSET_EXTENDED returns system timestamps that do not correctly
>> bracket the PHC register read on MACB/GEM. On a Raspberry Pi 5, the
>> returned interval can be as short as 37 ns, while an ordered register
>> read takes approximately 1 us. This biases the midpoint used by=20
>> phc2sys,
>> causing CLOCK_REALTIME to run approximately 0.5 us ahead when=20
>> synchronized
>> to the PHC.
>>=20
>> gem_tsu_get_time() reads the nanoseconds register using the driver's
>> relaxed MMIO accessor. On weakly ordered systems, the subsequent system
>> timestamp can be taken before the register read completes.
>>=20
>> Add rmb() after the bracketed nanoseconds read in both the normal and
>> seconds rollover paths, ensuring that the read completes before the=20
>> post
>> timestamp is taken. With the fix, the minimum interval on the same
>> Raspberry Pi 5 increases to approximately 1 us.
>>=20
>> Fixes: e51bb5c2784c ("net: macb: ptp: Switch to gettimex64()=20
>> interface")
>> Signed-off-by: James Clark <jjc@jclark.com>
>> ---
>> This uses rmb() to preserve the existing accessor and endianness=20
>> handling.
>> Would an ordered MMIO accessor be preferable for these two reads?
>
> AFAIU rmb() fits better here. Switching to readl() would also order the r=
ead
> on arm64, but only for hw_readl(). hw_readl_native() uses __raw_readl(), =
which
> has no ordered version, so that path would still need a barrier.

Agreed we want to use our existing helper and an explicit memory
barrier. Our mistake here is an helper called gem_readl() that doesn't
call readl()! Proper naming would maybe have helped catch this earlier.

>>  drivers/net/ethernet/cadence/macb_ptp.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c=20
>> b/drivers/net/ethernet/cadence/macb_ptp.c
>> index e5195d7da..8209ec190 100644
>> --- a/drivers/net/ethernet/cadence/macb_ptp.c
>> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
>> @@ -51,6 +51,8 @@ static int gem_tsu_get_time(struct ptp_clock_info=20
>> *ptp, struct timespec64 *ts,
>>  	spin_lock_irqsave(&bp->tsu_clk_lock, flags);
>>  	ptp_read_system_prets(sts);
>>  	first =3D gem_readl(bp, TN);
>> +	/* Ensure the PHC read completes before taking the post timestamp. */
>> +	rmb();
>>  	ptp_read_system_postts(sts);
>>  	secl =3D gem_readl(bp, TSL);
>>  	sech =3D gem_readl(bp, TSH);
>> @@ -63,6 +65,8 @@ static int gem_tsu_get_time(struct ptp_clock_info=20
>> *ptp, struct timespec64 *ts,
>>  		 */
>>  		ptp_read_system_prets(sts);
>>  		ts->tv_nsec =3D gem_readl(bp, TN);
>> +		/* Ensure the PHC read completes before taking the post timestamp.=20
>> */
>
> nit: comment should be wrapped, to fit in the usual line length
>
>> +		rmb();
>>  		ptp_read_system_postts(sts);
>>  		secl =3D gem_readl(bp, TSL);
>>  		sech =3D gem_readl(bp, TSH);
>
>
> Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # Raspberry Pi CM5, min=20
> bracket 37 ns -> 981 ns
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks for testing Nicolai! I don't have any Pi 5 setup (yet hopefully).

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

