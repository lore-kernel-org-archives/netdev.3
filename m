Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF32ED15F;
	Wed, 20 May 2026 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779317605; cv=none; b=ElAZ8egyKHFpBGHhtCzQ93majayujXaU9rCD9cGzppcL6n+2yUQysOVQVVv9oT7W0y4/sr1FRZNZQFqeMw/Q6rzSU5sbsv2SF4utgu1oSqw+FVwVT0VS1AUGZ3GJP4FmHytWz79vpXL6x/tNJ9gNbxUDboh4mNhYnK7zzlrLBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779317605; c=relaxed/simple;
	bh=qNikdgeiKVBRFgFJ39PFmYjSGDbNWlnWbk0EyQ2H4k4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhgIthNNLMKcwoBQmA2MgyVQY0DDOOw6jB2JX3viQOb7KIbWz4Xn+vmO9HecHtEUs2sFflHtps8vIAi3GBLE9wk/GW9FOaNQ1bbLR2j1WKWaouXWOTIsl4m8/NSARwTf70zf2Sj/ebXST+5o/9+6D3VnzPw5Ok/s+xdSRDGT5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iFK4Evxj; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iFK4Evxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779317590; x=1779576790;
	bh=beHSVE97jeS2xt2HG8In3PKj2U+OwNaO9BZF99tFWZA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iFK4EvxjnyV/zJLkQjpl5ohUjDSAS8AWsyXn+ba8e+XgnLeCIxCWHucPZQw5CgmnC
	 nB7K8Dn2Sq2NV3AggVbhjHSJb/gnqhBS4Wq9lzUsuHxQnHt8QDpF5JYdiY5mVgmARB
	 QUs+Nvlq21wP/zE1DuRxUjruA4g9JRzLTQLAtJTIfiGSjMYFiA3wKRH9p1RqMHeX+c
	 miqoKp6bxssn32XmrQbUTZLHGtTb/Rr3ph0UOKb+J9FMNDvsa5gsVBx0Shy2UX7Io4
	 VHsdhvk/jMS8k1ZWuiXYLhEetrZo8o2/UYfuamspOMa7SYt07u1PRdZ6FTZazrsUCN
	 ceCgI9SLcBUbQ==
Date: Wed, 20 May 2026 22:53:04 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: =?utf-8?Q?Leonardo_M=C3=B6rlein?= <leo.moerlein@proton.me>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>, Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Buday Csaba <buday.csaba@prolan.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: mdio_device: leave PHY reset deasserted on unregister
Message-ID: <hRNIpXMBtfUH-OrabbMVvOWAZ5J4O1XNTvx0lMYIDdSLqFL9hhZKdb3CzPo7VgUrwKi6MD3qlj2li6eHybgzFBB_Wfqu5Lc4dABXt9mpL2s=@proton.me>
In-Reply-To: <57b43ade-2c7b-4eaf-b9fa-406edee0fe44@lunn.ch>
References: <20260520151355.1371163-1-leo.moerlein@proton.me> <57b43ade-2c7b-4eaf-b9fa-406edee0fe44@lunn.ch>
Feedback-ID: 198615653:user:proton
X-Pm-Message-ID: d8fbefd47c00ad9f2d26c893102476e1b63a6e93
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> I'm wondering if we are fixing the wrong thing here.

In general, I see two options to fix this. Either we fix the
tear down or we fix the setup of the device.

Let's look at the current state of the setup code:

Assuming, the reset is asserted when the PHY setup takes place,
it fails because of_mdiobus_phy_device_register() fails with
ENODEV.

This happens the following way:
- of_mdiobus_phy_device_register() -> ENODEV
  - fwnode_mdiobus_register_phy() -> ENODEV
    - get_phy_device() -> ENODEV
      - Asks for the device on the bus.
      - (The phy could only answer if reset is deasserted here,=20
        but get_phy_device() currently does not ensure this.)
      - Returns ENODEV since there is no PHY present on the bus.
     - =E2=80=94=E2=80=94 early return here: ENODEV =E2=80=94=E2=80=94
     - If the early return wouldn=E2=80=99t happen, the code would continue
       calling phy_device_register().
     - phy_device_register():
       - Handling the reset gpio would start here.
       - mdiobus_register_device()
         - Asserts reset.
       - Deasserts reset.
       - Things would go their proper way...

Currently, it seems that this case only occurs when the kernel
leaves the reset asserted. The bootloader initially leaves the
reset deasserted, at least for my current hardware.

Now, we have two options:
a) Deassert the reset in get_phy_device() (or somewhere around it)
   before asking for the device on the bus.
b) Deassert the reset in the tear down of the device.

My current patch implements option b).=20

> Rather than take it out of reset, should it not be put into reset?=20

If we go for option a), we could do this. But then, I do not see why
we would care at all how we leave the reset?

> When the GPIO is unregistered, are we leaving it as an output?

My current understanding is yes, since mdio_device_unregister_reset()
only calls gpiod_put().

Cheers,
Leo
