Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507908;
	b=kQIbm+lqMWEl77XDivg2V2oU9DIF/5Tt0/280G4tAHlkJT5oXLNhWUDQaEI0kFOcdvLT
	 IJRaQmx+TQz9XGui1OQxEztTttAIcChS6UNJCWXy5WKS3+k3ifWS84x+H1BqwosUuA2Oc
	 dydpPYaCNimeDB9Dwry6JHyd+B0c/zDYjk7xD2dFT96jHYjXyWm/DIDfFQ+YrYzZtFf9Z
	 GLa6n5cVao4yZuqp5g5YBJxYqsl5IY5uNMZln0rBncZwoeVQ24DBpr3kZD667SKRewP3g
	 ZnLempYooKtOKjlOby5dn46pcHf8B8RZwQLGYUlg88FrR9h5lhUIizkMw/ubNifigAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507908;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=FBHeTU63Usdq/raengLNx/gUay91rdd9cr74l15T2Ys=;
	b=ThKg/+EyoGdwFCw5vx4mc6INeTXUfpDRT5mgeTp6OMXzvnjYPzL7NW9mN92Qzw2QiPXj
	 Ze06EnEfhVP7AWa4/yJ1MenNWj6tBg/dCpr6U8xjL0KT3WgDVX5MMqyEXYppmwW93qQcM
	 RAEgHIJwViYj9EdqIrw9VbLzlC3Z/lqpj05krUgQ/leiRDLLlGNrmACupfYF3PkwlkpyJ
	 O6XER+Bbz3D2U4FHF5uz9fc6F5wZQVfDPPFu9kt784R07XQV73ZSanvstK1A5+T6/+GJ/
	 77P+DP8oPDnv7c18E1V95ohLtZgij7Cp4ATfCbRJZDLtoRHHgHQ4rviD6gWrZZRvU9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=a8IZkvpj;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D179606A31A;
	Tue, 20 Oct 2026 14:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D179606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=a8IZkvpj
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B115DA02DC;
	Tue, 20 Oct 2026 16:51:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792507905; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FBHeTU63Usdq/raengLNx/gUay91rdd9cr74l15T2Ys=;
	b=a8IZkvpjWvTGiQBHz6l2VTaDVZaT0cRv8IYQLvJPCy6+rx7PXK176X8AUW05vw9a1qWw9Q
	eSr9xrrzA9MpQRWJKIkxDsw15KXsgrvpCfH9hp6N/LOesJvYUPkYTafQasqB3A/9wU904C
	AnWB4kzMIHHSokv0SanVKJb6KWEwmEljrm+oLrrkEwpPjCh1w39so9LvyjH1yMA67zkIUK
	YyM+MCN/R8pdkBMIPbbtQ7UW2a4Btn8YYSe4yaG6YjFS0Mga2KBMR7AmEW4BqBkgfs0t33
	2492riex0ZEMgZmRPBrtdBRq4T5QwYbxHqdemVXRmvfmZgK+gwCV4abu/i2qaw==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 16:51:42 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, James Clark <jjc@jclark.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Doug Berger <opendmb@gmail.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Russell King
 <linux@armlinux.org.uk>, Conor Dooley <conor.dooley@microchip.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thomas
 Gleixner <tglx@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement timestamped
 MDIO writes
In-Reply-To: <2279ba71-009f-429b-a27e-dc72ab11cfbc@broadcom.com>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-6-jjc@jclark.com>
 <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com>
 <60accbd89cfaf0d4be1da5ec2fafd975@tipi-net.de>
 <CANz3_EYfcBopo=HgRioXkhoT6P+4WWpfFT7UeWkXd5eM_RNpSA@mail.gmail.com>
 <41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de>
 <68eeee64-7f62-459c-b53d-61ec04b4d8e3@lunn.ch>
 <6b5ff0aee5db9bba10828d2f949c9d67@tipi-net.de>
 <2279ba71-009f-429b-a27e-dc72ab11cfbc@broadcom.com>
Message-ID: <d2bf2454e4c1d815db5a745efc017060@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 16.10.2026 00:12, Florian Fainelli wrote:

> [...]

>>>> I've put together 3 patches, which do the clock plumbing:
>>>> https://github.com/nbuchwitz/linux/commits/devel/bcm2711-gisb-clk/
>>> 
>>> It would be nice to extend this and set the divider based on this to
>>> give 2.5Mhz, as required by 802.3, as the default. Allow boards to
>>> override this using the clock-frequency property.
> 
> Regarding the choice of the GISB clock to feed it into the MDIO clock 
> input, that's something for Raspberry Pi to comment on because I 
> vividly remember we did something different for 7211 and used a 250MHz 
> clock in the interest of being identical to the other STB chips. Your 
> changes do look correct however.

I received feedback from RPi today regarding the GISB clock, and they 
confirmed my theory. I’ll therefore send the clock patches soon.

> [...]

Cheers
Nicolai
