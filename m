Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F42D061C
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064818; cv=none; b=g9tDMU18IrBz6vJBR2D2+WfV4ye00x2Wjf5jaEa/ipjXnf7LuKeP/wqk6BzWfveNm6+S+c4iuGL9AE8XQ69rCWjYM77vi28luQBdMFghZXhZ+A3Orjz7s47GoeH8VZafVHO1JW4uaFuRRVs4S1ilZUWvfVSzxvASvVeWwmabctE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064818; c=relaxed/simple;
	bh=neK2JaH11CvGMxWIp1XEqkxU0+X+dCwL3hHK/4h4EX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jtfo0ay0keY8HcxgnvXX1Aw/Zu0QG4rwA478ZWTspndiT1lcYroVtMpaTK9XQE0RyYX5kXKGqio803G8tOely7XHjb+gB4s0UEFdu/rqI/OvAssk8eVGh6u74x2Mktx9gpQ52YkVnaH9Y0fQXfufCDs1UGdi0Osbu91KBtAOK+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM6OC7ry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM6OC7ry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8612B1F000E9;
	Tue, 18 Aug 2026 14:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787064816;
	bh=neK2JaH11CvGMxWIp1XEqkxU0+X+dCwL3hHK/4h4EX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GM6OC7ryr4qSDg6PuZ+CZYelvm0V99JVbkDZEjHp640t/vN2e60J7/B5nOyffBCWo
	 ZdZWCqtnISKA+TfmxspOgNC+vq56kt0tAqbY4wQKdAHEMzD0MpS3bXb48gL7yEqnfW
	 JL2CAHqJXTCiceK/Dze8H42gquBt7WcU1xhJUnsapa1i/19W/1BzH03GMHDX1TIWjg
	 J9EE/jSrgZqMJjqMot+TPqeWW13wIGwdXlVJWu61ikb2MgDNqpgPbjkIJBnkHXbjb1
	 K/o0WjLbbVidxa5Eqz1XLx8suOKb49kdIOdkkoyE5BBmjUzowwUG5FU+c4EeImzQ1H
	 kOQOhqwQnTWCg==
Date: Tue, 18 Aug 2026 07:53:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH net-next] net: stmmac: stm32: Set TSO/TBS Tx queues
 default settings
Message-ID: <20260818075335.48936b08@kernel.org>
In-Reply-To: <87mrujzzjv.fsf@jax.kurt.home>
References: <20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de>
	<20260817103337.74c30adc@kernel.org>
	<87mrujzzjv.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Aug 2026 08:57:08 +0200 Kurt Kanzenbach wrote:
> On Mon Aug 17 2026, Jakub Kicinski wrote:
> > On Wed, 12 Aug 2026 08:28:57 +0200 Kurt Kanzenbach wrote: =20
> >> TSO and TBS cannot coexist. Use the first queue with TSO and the rest =
for
> >> TBS. Tx queues with TBS can support etf qdisc hw offload. This is done
> >> similar to dwmac-imx and dwmac-intel. =20
> >
> > Can you explain your use case? =20
>=20
> I want to use ETF Qdisc with hardware offload, which is currently not
> possible on the stm32mp2.

Do you need multiple queues for ETF/normal traffic?
Or one ETF and one "normal"?

How do you sort the traffic between the queues?

> > And how many queues the device has in total? =20
>=20
> The stm32mp2 has four Tx and two Rx queues.
>=20
> > You say "TSO and TBS cannot coexist" but can any queue on your
> > platform be configured to support either feature? =20
>=20
> I think so. The data sheet says: "Do not enable time-based scheduling for
> channels on which the TSO feature is enabled.". But, I didn't find any
> limitations on what queue/channel can enable TBS.

=F0=9F=91=8D=EF=B8=8F

> > If yes why are we configuring this statically instead of making
> > appropriate configuration based on qdisc or some other uAPI knob? =20
>=20
> It seems like a static configuration in the driver today. I basically
> followed the same convention as dwmac-imx, dwmac-intel, dwmac-mediatek
> and dwmac-qcom-ethqos. Only dwmac-socfpga does it differently.
>=20
> Tx Launch Time requires a different DMA descriptor layout. Currently
> tc_setup_etf() just returns -EINVAL if the DMA configuration is not
> setup appropriately. I guess a dynamic configuration requires to change
> the DMA config and perform a full release/open cycle.

release/open is not ideal but still better than hardcoding?
