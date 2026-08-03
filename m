Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1EE32470F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743670; cv=pass; b=phNQAxKV6YIPGMvZnitu/xMPbzFSqWiuB+twJoeCYiNFl4B9vudCajaVbgs/QwUDrKSI4BF9ucTnjKA9PoUAt2ggYk1Av9kIKZnmW0DEMG+cdGLtNvURlxcGtWXK/TakXjA0YBBAjOBp0t7Jh6YXZEIW8FCTPinEd89/8Lm+uxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743670; c=relaxed/simple;
	bh=BfoGLnxKqkGHS3lXZmpg5V4S04rgmYKSRo//J2O5u7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGwIk/ad1M0EV2jI0i3noHP+F7qdpyTh4fIU0v/JzOTzS/vPDhr7+CJYTUrkokRE558byMmNUogAX4yQyC3rB+Wr+t0JfpzsAd9fgjdQysTrE6AjLMYIcJ21KVI70Kv4k1w0wVE+2h4LlBJD880w3WAPoTEGmwUInWW6rL9qP5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA3iWe/o; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA3iWe/o"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-747355a8565so682000137.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 00:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785743667; cv=none;
        d=google.com; s=arc-20260327;
        b=WyBKjpa3urO1luVEJi2U7MxvjawQfatWNtwo+SRp35/HjtwVbemDQCCcJt4or3uwR0
         7aEMJt/9/oL358UF61koxJqXtX1RZU1unuemA6HKtso7/N1MEBWxiNSS8OnfgSZbmE08
         r/eTk62EUEw4O5CGmUWJGijDQo0zOv1sOiH3h0zGv3XWbDLvQl9oPUOj2QEX3p5LWZAX
         8TbNHAtmXsXuL8dPPITSNFYgEaai4wRAVskoEk90d36+o16UrEPNyzOqDwPU0fkMb9PW
         BEDsUafu475JcsDHazMfS5wmdom7xmNmYE8zYhfV05M5PpqRTXET71AwnhxFtFGl+m1a
         XyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=psfVqHSrgaZTUpwYinIDfYYI61bABe7ffXMHd3MgwJ8=;
        fh=tLes+XRZ46RrWrtvRODJP6Ey3chKdsFcXY7sawLkLhs=;
        b=rxp3s3l6Psjv7nXckEVwV2vCrYHdfIdc+MS+gPbhmyre9ScRU3OB6eeIC15HkSIWpM
         ml2txO/llcjVFPkrf7Xx6LNLgp5508tggpXtXG+sMX5zidixNEldlxMkWVMvkiKIiBA6
         RznHwnWQ7Kx59/GkzM3zSl21jGvdhOzFGwdV2mR+otDC0QyAn+KDJxD6l8oPtYuTuQZM
         iGJy8HAahx6cxd4kLnyLWDHG5m80MMSayYaRPq4ZPOMM/3g36bxahNaibPhFvY9snzaP
         tE+y9IbmuKHFd5aFw8ZarZ3+unphS/CU7zAaUz5v9peS32MBWgIpW1AOS0ieAUHc6UJw
         OfHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785743667; x=1786348467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=psfVqHSrgaZTUpwYinIDfYYI61bABe7ffXMHd3MgwJ8=;
        b=PA3iWe/oEWZEuC3LIWxmC553fpSLbGw/IDCbHHqTqmP+LN6RQHf4nzjamfd5V+D8J2
         M8GnKDzNfuPoizj7Lm1J6PzvoIgXhy/Qxw19WjnWQVGlu447My9v+K7EqyufCbrWWQ2i
         D3tmDjfieJNUrI/032Y6ewKklek+TvHqbBCXv+DDU+/ykQhzlCgOPJGGIMk/mtIGsZ2/
         9v3OAa9FphGNqwDTzbS99nrzXqYhA/G4HN91FQdQvF74Vz5NZ5WP//2cLKSnC8vEE7f2
         07PKbfG6a2xk+t9yg9Nc3qEwpKu2PqJ4u/GYMqBh9WfpLN+N1YmtIhiDVlXN9uxPnShp
         GkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785743667; x=1786348467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=psfVqHSrgaZTUpwYinIDfYYI61bABe7ffXMHd3MgwJ8=;
        b=ONdYBozFhq6JQmmIWv0o7B/cnIUTp+Qkh5Gf78Sbue6sAjXQU2zq7eavtZ8+fTWn6w
         OjNh7x5YijX5F10AN4puCIn9AuxLQFlmKefUmoEOxyPo5Np/PY+TdSEFs5ZyGD6hiH8U
         uYgF4nce6VS77EnpDgHTjUHqKlt0ETSacYaWFaRh0p+QddtJYKDlehdue+s9ugoigsZV
         6JQlYaAK7dcOT/4icQCSxnoxGacM21nSTnyZgw2mbiOhMW6KJfjWekFPkOzDPR83qakt
         4y7e9huizc0wTd6Jjv61iyx4vKUYi8LeVpcXKcZIwAhHWbj15AdOOf3WuZGmU5t7OpGi
         hG6Q==
X-Forwarded-Encrypted: i=1; AHgh+RopWrLSuzFGyv/0eKlRGwamSGqifmuf2TdxQRKBi7gNZSKEREAE4Gw29hisBlCwy1kQTFhOlxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+hanfP1RC02vsORin38cvtrT14hmOd/o8nZGB4euII5I/do0
	P4ntmxMuFvfGauoZf4t+KUZtim66n1XpAGRUlMu9V7D3clb+tikfyTfCtgf8zffGtdLIf+YczrC
	TS4mu3tnPd8FiWedDNMGGEQtwiNEsd84=
X-Gm-Gg: AR+sD108GKoABK3F3wasUdCZF0pqn7EhOMmAj43lM0SnPAdjAkm4685f3kz0MMBvwlT
	af0GtEFnzgVgSLHvEhI4jRmPDsylTKf7aUAiM0YWFlg3o3Y7KE6nplaMhNyA2x/6s3TC9PrMa++
	wTbkOmDT81PBz9srwWl9MRAuBB05wA97N8T2jknQkCLJc3IMM6gO+FrxO9Ma+uCIiM8ENJEQA15
	/jV/+GiWTOp3h9vvXxi8oMRBB/N2OKDdFoPQdog4Ygb1mxHtnpumTmPV0oXTT9PLIps6FAnMzhw
	6SulFhqTSGsXewSCrGi08rIwleGy7+se0TsQ3lkb15pFAETbdBUk36BeR0rM4AQW0h4zu9aWFM+
	nODcCKPIeUmKHrY66FIwpVZGzdvEJB2WEn0hyJtTga5oyTwToGHiafrZrIIpwNkdsLaiXLFYMyB
	odw+UaCMrYZ0N7SlfV2MqwFOedRP5GiWRvpxH22NtrsDjTf5c=
X-Received: by 2002:a05:6102:160e:b0:65a:fcea:5a8 with SMTP id
 ada2fe7eead31-75b21860c9dmr6557280137.3.1785743667347; Mon, 03 Aug 2026
 00:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-8-0a53cd9e21cc@gmail.com> <f2cc3c90-060f-40c1-a55e-e2ed91e65487@kernel.org>
In-Reply-To: <f2cc3c90-060f-40c1-a55e-e2ed91e65487@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 3 Aug 2026 01:54:16 -0600
X-Gm-Features: AUfX_mzypJX8cJAuXN5et4vt4pytYhwgZWhNFqSZnDYLwz1Lp-gZapkTkGPrkCE
Message-ID: <CADvTj4q7HnOYJZE-M070-1npEdne__Ct5D9FeUNVVXa8Bsm7qQ@mail.gmail.com>
Subject: Re: [PATCH 08/21] dt-bindings: mfd: x-powers: add AC200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>, 
	Richard Genoud <richard.genoud@bootlin.com>, Maxime Ripard <mripard@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mfd@lists.linux.dev, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 1:07=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 03/08/2026 07:14, James Hilliard wrote:
> > The AC200 is an I2C-controlled mixed-signal companion IC containing
> > audio, video, RTC and Fast Ethernet PHY functions.
>
> This fails when applied, because you did not explain the
> dependencies/merging of this patchset.
>
> This is THE MOST important information of cover letter. The first thing
> to explain.

I did mention in the cover letter that the pwm series is a dependency:
https://lore.kernel.org/all/20260703152215.192859-1-richard.genoud@bootlin.=
com/

With the pwm series first this should apply on top of master. Should
I just mention that it applies on master or should I reference a specific
commit hash or something?

> >
> > Describe the parent device, its input clock, required function supplies=
,
> > the optional SID bandgap calibration cell used by the vendor initializa=
tion
> > sequence, and its optional Ethernet PHY control child. Document the 24 =
and
> > 27 MHz rates encoded by the public EPHY clock selector.
> >
>
> ...
>
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - ac-ldoin-supply
> > +  - ephy-vcc-supply
> > +  - rtc-vcc-supply
> > +  - tv-vcc-supply
> > +
> > +dependencies:
> > +  interrupts: [ interrupt-controller ]
> > +  interrupt-controller: [ '#interrupt-cells', interrupts ]
> > +  '#interrupt-cells': [ interrupt-controller ]
> > +  nvmem-cells: [ nvmem-cell-names ]
> > +  nvmem-cell-names: [ nvmem-cells ]
>
> Why do you need all these dependencies? What are you trying to express?

Looks like we probably can get rid of all except these:
interrupt-controller: [ interrupts ]
nvmem-cells: [ nvmem-cell-names ]

I was just trying to express the MFD controller dependencies.

> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        mixed-signal@10 {
>
> ...
>
> > +...
> > diff --git a/include/dt-bindings/mfd/x-powers,ac200.h b/include/dt-bind=
ings/mfd/x-powers,ac200.h
> > new file mode 100644
> > index 000000000000..cc59e2ab4912
> > --- /dev/null
> > +++ b/include/dt-bindings/mfd/x-powers,ac200.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * Interrupt numbers of the X-Powers AC200 interrupt controller.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_MFD_X_POWERS_AC200_H
> > +#define _DT_BINDINGS_MFD_X_POWERS_AC200_H
> > +
> > +#define AC200_IRQ_TVE                        0
> > +#define AC200_IRQ_EPHY                       1
> > +#define AC200_IRQ_RTC                        2
>
> Hardware constants are not really bindings, even though you use them in
> the driver.

Should I do something different for this?

>
> > +
> > +#endif /* _DT_BINDINGS_MFD_X_POWERS_AC200_H */
> >
>
>
> Best regards,
> Krzysztof
