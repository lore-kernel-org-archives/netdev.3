Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778628;
	b=Hkxu8SkmzD+VrEHixg1HDmird+GuxJAWanhnc5IjHrK1hbO/GK9QvJXWjNOTZlgGBCMS
	 hr1JQxSmx/fsbyPOqzGd6yMaNtyg4TmUwKU+HT4ME/88RhcBcUxwMw3rHz7WIYDb5KQMA
	 g8JDYfTEhqZ3jUa3azjqKLaLsFrbATEESH2dRrD8LUsy7BuIF7TfwzDBsRGFaYhmfb+mC
	 9ZMpt0rziJwGZ80C0Kf4FA59li25b2T+3v46hggk+mESxjkhPmV1kNpWrmPfRho1Tn5Q7
	 /QYM9nnCuaBhHgUW0XCFmDOnOdEPAu3jLBa525oZufDcvb7QlB4GJVbUZrP5QxocQ9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778628;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ehtqtF1mQlApcVvUtORZ0T73fEOYE9F7ECr38Eww7ic=;
	b=rlKJsM0F9z8/nsjeveEAWl07cExHwN09iJnPuYOV/B9r4XTPsDxwSMiRwAJrI7lcUfon
	 PDkTG7LyxciMDrPdzCl3Jo24er3KXfT4YJ/8uVqPM5Y4r/89PLV/O24but++n3R2CDwFJ
	 YRyeIIvIRgRwMTpqxxmpkNFwLt6V3U+/sN8gKqf4iN0tVuP8m/t1a4bKLN/j3vOQyLHYH
	 6eVK4GGRA/aGYvqadR5Nl7KhzZP+RzzpFBvvU1+k1zl3YG/XreurjXcxHsmkPvkxCViqf
	 dB2Xk0E8udZFpBzG0eLmtMPSO7Nua348KL/mwegrPtdMdaoODZ5QASlt0qGgT5BOw8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44113606A331
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 07:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44113606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso177193a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 23:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793778627; x=1794383427;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehtqtF1mQlApcVvUtORZ0T73fEOYE9F7ECr38Eww7ic=;
        b=ReYp+EbiyMlUQXS60sWQVh4Vy7484Yd1u/4A8373rBa2fzl5w/9vcK4oxeYqTy7Mqb
         QHqXe+wU8ioWtIDEY0iKRVcATlYuD9L6QElkcIE/io7rDHKvOap0LRFoEEgc9toTBzWY
         h8yo6FTlFMABBNJje2c6Z0CdPLKde/MEJq+8P0m7l32Zc0RVetVx0fHZzRQKWpIqIOX/
         HKJuHUfaNG0/0W/daUAxC2DUko8r95+Yj6MqyS++NvvkvWjGGNi+uwn4XGXkS/6qEP7w
         2XDcpO31JNRkkuVjXiDP134t5ITc7n5asitAEOkVEV/iXSWGzyDJ2RitjDKx0XySyMpb
         5H2A==
X-Forwarded-Encrypted: i=1; AKwUvBxqJUfeGduRvsACO9BTNohZDFuLpkkQ7zBMA3lwxPOFLCSj4cM+vi3PoW2QAbk+z0Dx2fmpwQs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FPUgGylcJeWrKh0rFjregTTCVnKRkV7JQHGOgQT2oWAkXIYLF
	yQt0iGFpmuH2HfitbPHviFPF0xSeWNCFcd1Q4SWvFBva9gdu0OD1AJXXFwhBQE5G
X-Gm-Gg: AYBFou2KdJYq8W5DuV13dCia3k/0U2inMD56Iob+sRPSjcKiPeeje0f+j7Zkx86gQ8j
	S18PFzRGlXvaW0XGsDzNw/imOsGT9PYs0ZLSm2p9f+/gxq5IwUfTWH33bPdbcSHZJxHAfXCdbaM
	bWJuxy3mGdCEzWtt0ylcP1SaoJNPNGl7rwKYW7ZCSKVHoHDsS0YNDFeOf4RD4rhpcVd8zC+t8Zq
	qw+C0CYYGa5xHaJR9VpDdzSpzdz/sQ4dniFOUB0dOOB9PmjjfC7g0WcZdfpuKyS9Fi04DeLhEMU
	GMv2b2yI4lsjP/HDfGdmg8vpYsjmdF1M1Ev4d03pardKp9k0QM4OIXzRhUO2IwKdqbY0Ykvd4uE
	rn8dJ2fIdD/FCre/STmNAL0+aGp4zTK8JJ8SaP2WqzqCuGyPaKvN3Mjm/mAN+hHpcT6SVxV8z9u
	MNOv7Iw0zuObSUweaPxQ9+q9ysWFi4svrxNKY0ghTS8MPYnIlnJSImVlfLnkXJ0HARrB8DHUkwA
	+kcDHQ5DwEe8udcjMBR+WqcnOgG2wibrHV2dIXBANH3dt4osXUoRCcQksBM9SLTrM+Xl1yJ3os0
	ufhbMYPjvNclsMPJH5Fp5tIC78P+RlGHpKGWsjIM1pElMAfMr0Yaqk3Hr9gKwQWhau/I8lA7Vd2
	2qE1xoLR/SahgquYrc+8rvDdgeHViLvFmtpSpMxAyo4c=
X-Received: by 2002:a17:90b:5350:b0:3ac:7842:bd50 with SMTP id 98e67ed59e1d1-3ae896f51damr13367916a91.15.1793778627475;
        Tue, 03 Nov 2026 23:50:27 -0800 (PST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com. [74.125.82.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0945104dasm2971405a91.17.2026.11.03.23.50.25
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 23:50:25 -0800 (PST)
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36cad25b8b0so559499eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 23:50:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw5XmB/xCepnJafz1HDzzdL4l/OaCiC7ESMH7oG8L9a8NuyWmJIVqvEG54YoItUPl4fzKbxM0o=@vger.kernel.org
X-Received: by 2002:a05:7300:5626:b0:36d:3c0f:cc85 with SMTP id
 5a478bee46e88-36d3c0fd4ddmr336931eec.5.1793778624811; Tue, 03 Nov 2026
 23:50:24 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-mxl-gsw1xx-reset-v1-0-53839bf5c88e@telaak.dev>
 <20261104-mxl-gsw1xx-reset-v1-2-53839bf5c88e@telaak.dev> <aurg9vX3_i_ewWur@makrotopia.org>
In-Reply-To: <aurg9vX3_i_ewWur@makrotopia.org>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 4 Nov 2026 02:50:12 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ60av3BuwZLLd0hPrBwoG3pkn9F8UkC+_R955eR-hSgRg@mail.gmail.com>
X-Gm-Features: AclHuK8ba1AdAyiGMIqLrEIrq97_7kEVXJoVGnwsPAzijK50SZ_tiUWACXQK9rY
Message-ID: <CAPY4CJ60av3BuwZLLd0hPrBwoG3pkn9F8UkC+_R955eR-hSgRg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 07:38:30AM +0000, Daniel Golle wrote:
> Any good reason to open-code this instead of using reset-gpio
> (CONFIG_RESET_GPIO)?

Thanks for pointing that out. v2 will use the reset controller API, so
reset-gpios is handled by reset-gpio.

On Wed, Nov 4, 2026 at 2:38=E2=80=AFAM Daniel Golle <daniel@makrotopia.org>=
 wrote:
>
> On Wed, Nov 04, 2026 at 02:15:48AM -0500, Joseph Telaak via B4 Relay wrot=
e:
> > From: Joseph Telaak <joseph@telaak.dev>
> >
> > The switch keeps the configuration the bootloader left in it, and the
> > driver never resets it. The MDIO core asserts and releases reset-gpios
> > only for PHY devices, so a reset line described on the switch node has
> > no effect either.
> >
> > On the GL.iNet GL-SFT1200 the bootloader leaves each internal PHY of
> > the GSW150 one MDIO address above its port. Port 0 then fails with
> > "failed to connect to PHY: -ENODEV", and the PHY that answers at a
> > port's address belongs to the neighbouring port. After a hardware reset
> > every PHY is back at its port's address and all ports work.
> >
> > Request the reset GPIO in the driver and pulse it before the first
> > register access. The timing follows the vendor driver: asserted for
> > 2 ms, then 100 ms before the switch is accessed.
>
> Any good reason to open-code this instead of using reset-gpio
> (CONFIG_RESET_GPIO)?
>
