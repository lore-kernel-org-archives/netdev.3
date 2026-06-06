Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9C39DBE0;
	Sat,  6 Jun 2026 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780747401; cv=none; b=dAn6J3hFhk0DCJzRWTdEHbptGfQ37gGgR6wqbKirCuLLR2uWcsupR8KaUm/8+om825Rvz6OyCooiI/dleSUobndas35GAWUDN55aZb1nlZ2r6NvuikOr/df3sH/nxpzIB0CgKRNuPvhy9vPbs/kIIGJx5KET/47RQo1gWbyR1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780747401; c=relaxed/simple;
	bh=nHGBurcIUF67LJvrhQ+KIQA2Rsd3qCjQO1RafX1Kntw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMUQZIrp2CcNRi5YO9+cvblzh13TuKu6DvTSTg26i9sgYTJPqVmoqTkjAmulfxUVMl7xbMFkXlWD+QleIn9ool07pnqg/Tqyq1wZ5Wj7EzCLX07r/3atzvh55Pl4d0H5uevrj5xBczCgtDdiiemPyMLLGWTz6s0Uj6wKOVoZAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IcvkpkKr; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IcvkpkKr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780747395; x=1781006595;
	bh=nHGBurcIUF67LJvrhQ+KIQA2Rsd3qCjQO1RafX1Kntw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IcvkpkKrp2Qyk+JMx+nIkCJmGnQcWG2ALAbMn6j7AeS7vgiSkcBdwb7MehEZqeySr
	 XyZsDMcIKvaIIGrKCCfdo/DRTXt/iGksR8KDm4CQekb82xXYwp48JFEmXsHExUXwW0
	 VWGNvqvu6QH1cE8nxQyMDzL/d4WAjWioXn4saUmlM+uKIt2FIeqkZGsEdHZcAWTpKp
	 6gVEVEQAXd8mmt7mHLDh9JepRGGHnyLmKCFGyFJ0+NmGIOwZYWAEijDHUrYCu/w16m
	 td35kJVZ14h58rApz5FtqzBRG+jAN0+CLMA6/AywBhlAUcaqFP1QVm2Hntmo8XL7ci
	 3qxJkreuxuZPw==
Date: Sat, 06 Jun 2026 12:03:11 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: =?utf-8?Q?Leonardo_M=C3=B6rlein?= <leo.moerlein@proton.me>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>, Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Buday Csaba <buday.csaba@prolan.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: mdio_device: leave PHY reset deasserted on unregister
Message-ID: <uq8ChQ1OcJp0_nDVZuQ4xinQjP5UbPYysTtMrxJWvw5VCKmOUzDIJVjV9dcN2HTqWroeIAAdCAXiTnHns2GBA7v3C_iNop5DnDPHZVyslro=@proton.me>
In-Reply-To: <5b7e9dad-d346-40a8-8c7b-cfe10f8388a7@lunn.ch>
References: <20260520151355.1371163-1-leo.moerlein@proton.me> <57b43ade-2c7b-4eaf-b9fa-406edee0fe44@lunn.ch> <hRNIpXMBtfUH-OrabbMVvOWAZ5J4O1XNTvx0lMYIDdSLqFL9hhZKdb3CzPo7VgUrwKi6MD3qlj2li6eHybgzFBB_Wfqu5Lc4dABXt9mpL2s=@proton.me> <5b7e9dad-d346-40a8-8c7b-cfe10f8388a7@lunn.ch>
Feedback-ID: 198615653:user:proton
X-Pm-Message-ID: ea82292b0b8f9d1c857606b508c5949764e2d083
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, May 21st, 2026 at 1:39 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Can we take a step back, and look at your actual hardware. What is the
> state of the hardware when Linux boots, but before the MDIO bus is
> enumerated?
>
> Is the GPIO is configured as an input, and there is a resistor keeping
> the PHY out of reset?

I tried to check the state input/output state of the GPIO before the kernel
initializes it by using the GPIOD_ASIS flag.

Unfortunately, the xway pinctrl gpio driver does not seem to implement
get_direction() here:

https://elixir.bootlin.com/linux/v7.0.11/source/drivers/pinctrl/pinctrl-xwa=
y.c#L1352

Therefore, the only thing that I can tell is that the level of the gpio is
corresponding to "reset not asserted" before the kernel starts to initializ=
e
the GPIO and I could not get information if it is an input or output this
way.

> Maybe when we probe the PHY we need to ask the GPIO subsystem how the
> GPIO is configured. On unregistered of the PHY we need to put the GPIO
> back into that state?

I like the idea that our code should take the responsibility to bring
devices into a defined state that works for us irrespective of which the
state the hardware was left in before (by whoever).

Turning it into an output and controlling its level is the thing that=20
currently feels the most simple to me. Especially respecting the fact
that not every GPIO driver seems to allows to query it's full state.

I think, this also the direction in which Buday Csaba is arguing. I will
respond to his mail in a separate reply.

Cheers,
Leonardo

