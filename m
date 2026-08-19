Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704723D5C38
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124946; cv=none; b=EPrJcVuGSMn5MSZzNb4bnVEAz/uwhmafSoxrdsfpo5lvyCDXOD6dAKJ9q+5bAtwTJfrjPU9S6v5geMqn3uJY9SVR4eseHvlZseyZfaQX1uz7n+TouKRx8z9FC0TGH9Z/+fqEYV5uHjoKDIS3WKCx9WOmo7wKmrKY1mvNCS8sKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124946; c=relaxed/simple;
	bh=clk/n6pumG3opxLvd5On/fYpcU0JnfpXa4vVA7g4aws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=syjwD9BX47yrRDqLZnONyFL3FjG807QglBDIa4NVqG06qvow6xY7UuvczCyk0BwvozJ/EvquDonpW2CYjQ1OpQmLrfPRhz9RSxMCVt8Y35EjYOCB3nfCWoHsYMT8GkpfSrSCJxJjtfQihCe6SDSATXRpkXVyp0/xqg9Aa8D6slk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0HYLD9Vv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lMq9Nn5S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0HYLD9Vv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lMq9Nn5S"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787124942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goqEykEKegwDFkfqL5I9VFkOm02WZaoo6bvfZ7k1Q3s=;
	b=0HYLD9VvLJ3x59kBiz3dXhEQApXuCSrJg5ACQjUJjcxj4wSXCmrzyCqm1tMSXni5Sd+YUc
	j+1I1gHBLAfb2hhPCQnyk/0moz/UNMhZvuiMJTVDAgkjfnN4wngVoyDEkiKaHo67bB0s/o
	ebFRd06gkK72ZAyIXLMzZOz6HVfdgdFikO8e90Rayo++AHYNNyoi7eqUAF7oKa/h91ohq8
	R4LePQrcfmEq1jFiiLh9DNyIf4sdUuojhWYUXle+74qNHO4UFZ84Hs+bq6Pel0j1EBUg05
	K4N6JtIupJOGpwjg7xUSh7W3RsnhU2O81NKPWFJTERygDIS5V6xUhElLLqAByg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787124942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goqEykEKegwDFkfqL5I9VFkOm02WZaoo6bvfZ7k1Q3s=;
	b=lMq9Nn5SLbabNns8Jv5+s2257LiA+Pd08zRHY234ON1BrT3i3b3M30qd84QK7uyHS4E4Wp
	cmN+lzOdoFCDaCBQ==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Lorenzo Bianconi
 <lorenzo@kernel.org>
Subject: Re: [PATCH net-next] net: stmmac: stm32: Set TSO/TBS Tx queues
 default settings
In-Reply-To: <20260818075335.48936b08@kernel.org>
References: <20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de>
 <20260817103337.74c30adc@kernel.org> <87mrujzzjv.fsf@jax.kurt.home>
 <20260818075335.48936b08@kernel.org>
Date: Wed, 19 Aug 2026 09:35:40 +0200
Message-ID: <87h5kq1s1f.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue Aug 18 2026, Jakub Kicinski wrote:
> On Tue, 18 Aug 2026 08:57:08 +0200 Kurt Kanzenbach wrote:
>> On Mon Aug 17 2026, Jakub Kicinski wrote:
>> > On Wed, 12 Aug 2026 08:28:57 +0200 Kurt Kanzenbach wrote:=20=20
>> >> TSO and TBS cannot coexist. Use the first queue with TSO and the rest=
 for
>> >> TBS. Tx queues with TBS can support etf qdisc hw offload. This is done
>> >> similar to dwmac-imx and dwmac-intel.=20=20
>> >
>> > Can you explain your use case?=20=20
>>=20
>> I want to use ETF Qdisc with hardware offload, which is currently not
>> possible on the stm32mp2.
>
> Do you need multiple queues for ETF/normal traffic?
> Or one ETF and one "normal"?
>
> How do you sort the traffic between the queues?

So the stm32mp2 has two CPU cores. I've isolated CPU1 for Profinet. That
one uses Tx/Rx queue 1 with ETF to reduce the Tx jitter. Everything else
is routed to Tx/Rx queue 0.

Config looks like this:

#
# Tx Assignment with SP.
#
# Tx Q 0 - Everything else
# Tx Q 1 - RTC
#
tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc 2 \
  map 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 \
  queues 1@0 1@1 \
  hw 1

#
# Enable Tx launch time support for TC 1.
#
tc qdisc replace dev ${INTERFACE} parent 100:2 etf \
  clockid CLOCK_TAI \
  delta 500000 \
  offload

On Rx incoming frames are steered via PCP field (vlan tagged).

>> > If yes why are we configuring this statically instead of making
>> > appropriate configuration based on qdisc or some other uAPI knob?=20=20
>>=20
>> It seems like a static configuration in the driver today. I basically
>> followed the same convention as dwmac-imx, dwmac-intel, dwmac-mediatek
>> and dwmac-qcom-ethqos. Only dwmac-socfpga does it differently.
>>=20
>> Tx Launch Time requires a different DMA descriptor layout. Currently
>> tc_setup_etf() just returns -EINVAL if the DMA configuration is not
>> setup appropriately. I guess a dynamic configuration requires to change
>> the DMA config and perform a full release/open cycle.
>
> release/open is not ideal but still better than hardcoding?

For sure it's better than hardcoding :). But, again the driver does it
statically. Maybe there's a good reason for it. Maybe not. I'm not that
familiar with the stmmac driver. I'll prototype something to see whether
we can enable TBS at run time using the ETF Qdisc callback. It may take
some time though.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmqFXMwTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzghRQD/9uHst2zo6d5r0JYGcVZ4MHFTIIh8l0
teLNkO1VeJ3i7ZyEPlGf4Q9FiU1fZYytYBGzoZxHajf3vuBQu0PIo5lL9nVQWX9k
6KVxIhRCApW3FAhyejNvJHorLEElycsO4u0beprPSAQ8w8sH3j6sdMHgMgEIsYkV
bul3Qaacdmw9vjIKqK64YNYHsykxdzz+tXkqmJJWBYUb9mLdrC4ZCZxKYhJIvaSI
YlM1CNWs2v5wuarCPpg2kQu+jmAd7ID0/tHRt9ctZgcx4aEOdPzR4J3jsu/kk69i
y0bGoukD4NAXqcKjMCSSQVqITWf1/VF9LirXLZklilklYhbQyeWAbK9HtWCuCMWK
iVvlH90peld+3htir6u5MeWsdVDxJnrLagJdUSdYR+JvBd2qvkMtJ+4So93Yyc7k
2Smu1NhB7u4PiPt/3YUQgm1JT77Jhs7j3QxCpSyjoonRF/oXiclNXLgwBuHjMRHy
CGA7p5MgbeF6ciVqvmNijCMelyUll3oO2gr4QmeUinvCXStznzwsOcQNbW5Nk6oa
qNRxbV4rr9lU2pfLtOJCUXiAXJWe+amXX8xthoF4MhKHT9CwJ7Bpy+q0iNFPFGRZ
zoOOkwTpCy+qxf+GFuX3ZQUtYNwUn49TviYqfm8JsD6msYVt3bQEA1COqhS2jqvW
PFAQiorz9ko9Yw==
=qS6+
-----END PGP SIGNATURE-----
--=-=-=--
