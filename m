Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867738E5C4
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120880; cv=pass; b=lRcEeaKKZKIEMQBVhDg0Yxu2S+gJwJrp8MJ5evrzgL+9vyWhVoQ7ghPL/nooms992uT7UAhegbeNNzujBc1mkLj4AClSJ9Irie6hiYimbEDgsvTqxKMcWdXOmV74pnzYgILSC3M+h257sUmmDWqeztRjP/RCe1jWw90seC0jSHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120880; c=relaxed/simple;
	bh=H4YOFrL1KfBu3NDle8YUdni3Mk4BFwaMFq6LZ90tQgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObUu2ltHh3UZN32lWeinwFJIF9JnAXy3uWVGxHZ1uUPWwzxm25zUqx/oCeppI3BKiEOmj6j5q5YaxkTwhPIYEJAmb5pjolNjJ7x5KEYpCJg79We6HKmRLqfJLDmdXmPwuEUmJNt/ZXtOndFmayD7tdG4ECfusbqv5dmGYdWMT2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQWRLutR; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQWRLutR"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-969524c1a63so2517565241.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 09:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786120878; cv=none;
        d=google.com; s=arc-20260327;
        b=PztbWYOwmadNqvPrIrszfj/pvANbDgMQ1M8Ekr2qn8lV/pFx7u38tX7CUdV5GCQ82J
         CfWYCZAke709ogHfkV3L7Tg28TYf5q6ehUkS14yb4EyIq/i5l0ZwJvK8uw+er+AMZx25
         ErvNoPigLivOGanu4DSyCxO7JTSSFZBBSKSu/PRYNYaFQ/4ziT8zuTWlx6kh713FYO40
         2ABgX5W5LB1gZU3fb2MXIo0bEyjv1bJrICA3gYd75j/ZWvzeuUtyTvevHmF+oI1PWxJS
         809xHdGbgwgf6+b5mKWq9XWJWyHurHAG0ZsbNOxILqUfQ94eG1mDlwnGK2+6PTg7nuzx
         s4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VbYKBFSni/MXYcTbspULgZDCuPfk5qG+Byfv7cl+Zzg=;
        fh=8n61rF/eVGdUYSRFxirYdm+/rE2TUO5lRQZzVkH07N4=;
        b=jDgkDaMmohgxDzlR4UZHSWcc/Z3q1puHH4w3BzKDjqFoDnTWO7JB6fAXuLIx2x6rzR
         XEEsvCnADdU6wTsXVhBzAZY3b6Rycdo2VpU26m2yA1y3j4uk1ZVHKw2TdkQ20n6kp5N6
         LF9hiVjMKGwFCZbPrWs4qhtB0DNrlbNKWleK4TKdt2dU1iUQb1wi9EB73QPse7ct21m0
         JAtv9d/SJfJa71Eb+Cx2sfRMkGek1ZLxjbpTe4Uc44eymyEfM43EFz963Qfgh75T66wX
         72G7a2GvGvJhjeGawDuq0V8MACM1bAr9j3nkLp4Njvxbh4RGQT7UamUuzebWJm0JkriJ
         orPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786120878; x=1786725678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VbYKBFSni/MXYcTbspULgZDCuPfk5qG+Byfv7cl+Zzg=;
        b=bQWRLutRFUKY/OF/6kmInYCWZcLyGaNyhItdMuuSNqAsCkK5solo5inhvi1d1BllN4
         f2FoUM7mxHcL13xsdSR/PjkSNpSbqJj/E0MbKsRafc9xqsmfzHCyWRDEBQgN4b+JLK08
         UYTx5SRS4fJuAJpBFSxSuNzed4SPx8gdwyYj9WsGBB6ueJggMvg9FWBWELo6wWhOn3rA
         y1wE/RT0j5aT2IJEjyV1D4zko8RrVkwsyjdXrAGkhLFYzeBU+1Gc6EYCzu+62B5DJ6Gy
         HfDT1izxLFumQm48VEMQWq8NdYgygHFzGxLO+uJr732wFlpsz0FiOW8K3ymk2DOyCMxc
         APhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786120878; x=1786725678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbYKBFSni/MXYcTbspULgZDCuPfk5qG+Byfv7cl+Zzg=;
        b=ejomCnnHPbyMcMrPaBYrpMkG3y6LmMD1rpStK5mdVaJ6vUAW/mmziKIFadyfwqIGGz
         70GzK1l7dZCrzh94Ho13Swxqq0lIoZ+6WU9oDTkKt7Dj2XZjHMXdnnwvG0iFjdezTTka
         W1l+eWyavDPK1GIeaZlmGZ+gIK7UFlvFD+AFfXy4bhJkLeiV/KVjB7LRVGj7qtZkthvq
         7Fr+fenvtkpwcdL1E0D8TI74Eq89OsAheMfvYZd9hdVkyxQbcQh0KrLpiwSOAC8NYCoh
         SLgCDvbEN1LnBKi6yxM2+bp9Gc6Yeytl6nEoAhANn7og8rK3aRUv5bUMOt0NWd6XX7WW
         k7cw==
X-Forwarded-Encrypted: i=1; AHgh+RqKRT7S4sa8RJKYMtIX377z0SVVZAWF4r+0qOL2IP6TaWl1BJfWNgpStOXlYdGtSsOxBOsfP/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJj0KOyfyUkdF2SBw1/4t6EajnsO+kj7cnoWQm27xUH8folpNs
	T3Gn5rJEP5a7zGN0nb0miQG1WgKmB4xytIdC0C/XjYcwpIJBrhM8kt7j5+bqdQdrrAcy/tXTicC
	Xrnvnd1tCrVs9gu566h4wLKArj1Is47Y=
X-Gm-Gg: AR+sD11LueRZRksNgGJTdRL4FMLE7cS2nymHGyXucIpw2iSbWxg2sp1j0KxSQRl2YFo
	2WKLJor9/l/MxGDValKnsmG9uv3UKuLkq4war9l4mY6OcBNuIql6vsG6NhoY36uVtVytMNtIlvZ
	3pKmp7oRhTwTPJMBAL7qcnAAzn5JkLQzIBvCWS/UxvlLwgwnByk5+hHhRt6FRr+ri7nWp13kz0A
	n91LxZZJtVFBvwt34l1bIRxyv/W5fwMI/w9BXjjrItmpssnaTWqIMvZkrrtAW4Kcc2HW9gtxGYb
	gWMeaxtmOxk+RSUxuaBTgTmg6Q7xdzKVmjWOgR64Ti38XPgWimtA+wbdHyX7fCU9GMMx9Vce6NO
	x4KJQmUYBMjvFs7WQfi0lBrCLbOkWkwCaPTCKM/AAu92NYxthEZuZuI0mYfnN8SbW2JI7xCkd+l
	Ym5B9OaWHws16Pn20qkXCi8JJyzjoRmYH1Ecd+
X-Received: by 2002:a05:6102:578b:b0:737:5c42:858b with SMTP id
 ada2fe7eead31-764e72c3a27mr698784137.11.1786120877713; Fri, 07 Aug 2026
 09:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
 <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch> <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
 <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch>
In-Reply-To: <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 10:41:06 -0600
X-Gm-Features: AUfX_mwLDixIRmddCRIK4ioEeGf1D4LRV-vMQxIFETRbvqYEEeJik4zuAKwk_IU
Message-ID: <CADvTj4qxGVw+PW2LeF-a3h1XfmirQZGfJA9-6Czt72XASbVLBQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: mdio: support dynamic OF device changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Ciprian Regus <ciprian.regus@analog.com>, 
	Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>, 
	Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
	Keyur Chudgar <keyur@os.amperecomputing.com>, Michael Chan <michael.chan@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Timur Tabi <timur@kernel.org>, 
	nic_swsd@realtek.com, Byungho An <bh74.an@samsung.com>, 
	Steve Glendinning <steve.glendinning@shawell.net>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Thangaraj Samynathan <Thangaraj.S@microchip.com>, Sebastian Reichel <sre@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 9:10=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Aug 07, 2026 at 08:59:47AM -0600, James Hilliard wrote:
> > On Fri, Aug 7, 2026 at 7:16=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > On Thu, Aug 06, 2026 at 09:54:19PM -0600, James Hilliard wrote:
> > > > MDIO buses enumerate firmware children only when the bus is registe=
red. A
> > > > later devicetree overlay or status transition is ignored, unlike on=
 I2C and
> > > > SPI buses. Supporting live reconfiguration also means that populati=
on and
> > > > removal can race address scanning, PHY attachment and bus teardown.
> > >
> > > Please make the bootloader work around the issues, and drop this
> > > patchset.
> >
> > This is just fixing OF_DYNAMIC for mdio now, it's no longer used
> > by the AC200/AC300 PHY patches anymore.
>
> Meaning it has no users?

I think OF_OVERLAY depends on OF_DYNAMIC?

I guess it can also be used like this for live dt modification:
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/t=
ree/Documentation/devicetree/configfs-overlays.txt?h=3Dtopic/overlays

> We don't add code unless it has a user. To do so pointlessly adds
> Maintenance burden.

AFAIU the patches other than the last one are still relevant regardless
since they are fixing a bunch of generic mdio safety issues in code that
has users since MDIO maps already change at runtime through non-OF
paths(i.e. SFP insertion/removal).

>
>    Andrew
