Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03E3368B0
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036234; cv=none; b=UKAR/w9esj+X5e9rNebXarb6XNFsAvX6A2S+tylLza5TOZYyvGw8ycMLs/m7gM0f6TNS6H/LD9PPbdSKTaHmAbgOdbD19JYQo+mhGXVeZVG8x5cE11f76USB0YaPw5HXZRcAaKWGcrDszApiRIPcFRjoKaoehyejtZQXwxtL1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036234; c=relaxed/simple;
	bh=k153DUjIMFjUgFA73Y8BqSLm951n83/LiLiTD2rmFjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RveJkX1ZWgqgThPY3SYQErjRX5DCfJdHt8MsRzitl+AboaTeG5dvrzmbSzGfmPD0z4Q3oygaFYLXPhC/hh4urts5q/OJXek0S+RwJyv5aOmsPSEML4eFS5ou1VGMIWPMA4ilbLgrvL3/iIo4NhK0Omxr1Th64uJHKqMTuqoTORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K55YAyXb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uWWo2AQl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K55YAyXb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uWWo2AQl"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787036231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k153DUjIMFjUgFA73Y8BqSLm951n83/LiLiTD2rmFjk=;
	b=K55YAyXbEmR7QI/wBoI+Ksm8NsDNnzECUAO1fcc9Nsa7XIq25Z0P/Z+Ixi7i3ebU0/uDgR
	J8ujkPyJfgBk5DaB+S5Ovw2+spa144Vis/di84QJ6dZneS1mD/4BC9ZCNEvZxKoRyemK1e
	pyiz5vs1QfL9RlsRcuT9s/VCN5Par1YZvg8TOBh0K0Xfq/1TV+s12CfdbWpJ24MWhCXYGY
	67nQtMKndZ/JGqfsvm9mNNLUjyxHBNk/F946aqydKrvvGuF9QWhejkQxzX5SNpElkYLb44
	oEd7QkJpnjiHnhoI8sOjf2BQFBEYDxI+3OpugRg42PGd+351DscHPuSl5Zb6sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787036231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k153DUjIMFjUgFA73Y8BqSLm951n83/LiLiTD2rmFjk=;
	b=uWWo2AQlddJzsHPIgvU34g8IZJRdjK+w/9EgsMmZCTPhhvPAKRQCGXb3Zhv25RV1bhu/CU
	Cmw8nvMEhXpBSECQ==
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
In-Reply-To: <20260817103337.74c30adc@kernel.org>
References: <20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de>
 <20260817103337.74c30adc@kernel.org>
Date: Tue, 18 Aug 2026 08:57:08 +0200
Message-ID: <87mrujzzjv.fsf@jax.kurt.home>
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

On Mon Aug 17 2026, Jakub Kicinski wrote:
> On Wed, 12 Aug 2026 08:28:57 +0200 Kurt Kanzenbach wrote:
>> TSO and TBS cannot coexist. Use the first queue with TSO and the rest for
>> TBS. Tx queues with TBS can support etf qdisc hw offload. This is done
>> similar to dwmac-imx and dwmac-intel.
>
> Can you explain your use case?

I want to use ETF Qdisc with hardware offload, which is currently not
possible on the stm32mp2.

> And how many queues the device has in total?

The stm32mp2 has four Tx and two Rx queues.

>
> You say "TSO and TBS cannot coexist" but can any queue on your
> platform be configured to support either feature?

I think so. The data sheet says: "Do not enable time-based scheduling for
channels on which the TSO feature is enabled.". But, I didn't find any
limitations on what queue/channel can enable TBS.

> If yes why are we configuring this statically instead of making
> appropriate configuration based on qdisc or some other uAPI knob?

It seems like a static configuration in the driver today. I basically
followed the same convention as dwmac-imx, dwmac-intel, dwmac-mediatek
and dwmac-qcom-ethqos. Only dwmac-socfpga does it differently.

Tx Launch Time requires a different DMA descriptor layout. Currently
tc_setup_etf() just returns -EINVAL if the DMA configuration is not
setup appropriately. I guess a dynamic configuration requires to change
the DMA config and perform a full release/open cycle.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmqEAkQTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgl24D/oD5pIbsJKmttKF5pgORFPdAeBIldyk
SJDlmLRbsKEvzsNC9upW0HDi48XGkXrQCaJjHwY8WLLbgvaBZhM7mDpfnI0GRXyc
XAyGdrQeO/BKPZ13oKJGWzu3IgV09rHW/tb4hT9wQDsXCNV88756qGey1h5pmrdT
rVqiP3muzIbHgXxZsomFPhe7eMOjttuYGAPRq2zFhXMCto8lqtn5GzdfxKXEnTxF
RMGp6gKZ/1onXl55AB/+E1DeUKilOkUyuc9b7SFCu0Czvtre0DllIO3/MwfX+hd9
+MUB1PP8bZ3CaN93N2d3pLyEZdY/NeqWOTmqnZforsvA5AXq8cexXNTz/PK+h35K
1N4gfK2szhFNyUmQS4joUj9j44PP6BunJIKHpvRZ2leVDb9JnJP0bprCy6b848H0
ifNkmYMIWKGdV+peW0ckNIfdg492rz5KZjLpzVZBwhH2j3XkRKiPZv1hz6i9ztgg
oncYVsNyXoCfUscIpCUfPOAy9DgIVvVyg7jW4Zj8wuG+atrIv0qybOLOD3xjLf6b
85nbZ18cyhXNFWyYxD0jHE8NkKe6CJu5QbfPSiPLYJtf2GrZPmp7YsQFaBRLU3HG
aUOXjDcgp7V1/SLyTjMpTDSsDIacT4E97SMnFLGHrGCxKpUC+PHB4tmi3u0W4WYY
TY9LCZK5MwqJvg==
=TQFM
-----END PGP SIGNATURE-----
--=-=-=--
