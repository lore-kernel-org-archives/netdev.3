Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51A51B180
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702137; cv=none; b=FHRqmGQs+Yr8rgUaSXPWvtNO9rCHGcXXxxXGnyQw4CTF90JNsMRy9ZIREb2X0mK0sur446Lvnejn9dp2hAPe0dTpE3UCcFnrCgI2DUX+1N0nhU2ZJsMbOiNZx4tlzPdCljXJBQPY01QqfmSWEo05RlvR6mYeYZbHblUflv3oij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702137; c=relaxed/simple;
	bh=zIe0KG3lCKETMKNwyZ7USTtDkAG4C6Fy+0s+JFPdz80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jnHVu6nj3KYeobDSO5FuHO7kSd4ObwAQP5nhBB6HegWSPmH/YdD4+ZYy2axBWq8UhQUWM3yf/imN9pHLWJqbVJ7G8BguDDaQYRmzDrCUVEsU/bDbRkQL3mQl77A1xREh2lIGZTMkPmbaoBmgSE9zx62Pn0yfX4u7f4Sy+RzbHes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DBvONZab; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DBvONZab"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso33316575e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790702134; x=1791306934; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gliMXdJJkSbMhSXEgRAl5Ekvovgp6Cfw/QE4Z+KNG5E=;
        b=DBvONZabvKnsYyZDaFRrdDX4ywN2QKh0WQdGkCg4VuZAb8tWIBBXVgo69ctSNkC6iG
         R8Mb/fU3w1uQTatU4IMBRVI58LNV5eayLGJcEwEssU03d5eazY6TfsRi87hEhjgVXEgS
         KGD7qVj17lj4yPJwHCnA/zASIMl6qORzMoEMbWmaP3GWmyx4X9lVqBU2i8/GqD2MLR4v
         GjQQ2Qj3/SYPifWUoPyuGIefuLsSIQMeo8SxIHZOu6yIH4DapD4w2TzWbabU/ELl+A7f
         HZ+tH32EGR30KD/IGk6m25cjweaD5rmx+vUarLvuhpVA1EfjVSkVI09zvU2Olba2CmG2
         CgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702134; x=1791306934;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gliMXdJJkSbMhSXEgRAl5Ekvovgp6Cfw/QE4Z+KNG5E=;
        b=WNKrmFw4N0FNeBDj8wMWXAjYCSYu3Q29/mVzkFu2tt50N01XFMTDf1WhmSfwiv80dA
         zXPZsS9O0i92b/K1o4VjKI9Vo5oe06hkUclW0q0FeAHTUHeLSCTbdcHaUfjTm9qOyycG
         TJQ9nalpkAq9TCcY5tz7Jkog/OCUoxJi550xgtbr0YE1TKsU3yYzSNLQjChfcGnBMMth
         hzTKd2tnEnKziJeqiQXx/LPLcd8+WBjjdyvaBgm+rK8PIuixDAoVGcdhGmqkw7GIuVo0
         NkctRsHiOkrAVYafeom2zr5+prr7NQBwllSeXrsxWlruwO1RPQtzcJauWOMJw7htaXDA
         dLdg==
X-Forwarded-Encrypted: i=1; AKwUvBwguz/bgI4UmEjrUi8Lb5l9R27HpwpW/HcLUz/XOP6BaTUa+U+PPy0hVAlJ1E3wlKMZPQwEFQo=@vger.kernel.org
X-Gm-Message-State: AFuF++kJrP+9IBoQNRVmbPwPFkolmfWTHBEUA/CLMko0wiuHNbnvee59
	L/5aDoe0azogwhaJQc/f8FHa1WBiJlEtMhWFmBqR9e2mzLlG1VcR8qthY4cW5UHv6xo=
X-Gm-Gg: AYBFou2g9j+fyIQ0hrfzt73LxfBraikAYUbS8MIVtA1JyVulYSWhEUaxtedD4vJxVbd
	VT88BBzALPuzGHgSYqLk8F/C23Y/IneLaDt3mL2Cjd2zdKRwAi/Pd+7dVGM+jwxsnQOYcU95rYw
	NKFTq/Iy94x1fxhJy+kysccBhTYdw/VyVpvUyaZ5hG6RoT5rC7RPKtqzneWYX4SEVuTDMfcimzA
	5s2QCW+S8XW/3jpAHoPTFAtin4C+SK+aIUdKIRVNi99RcYLRhHJ9S4zpfwvRwwOkEUeNsMQE8yj
	dyqD5RdAJ2RyMXk1Ermxoq6HYB3PaVPQqkDKqhvi+5QohC/EhtLG2zpOyhhxnu6W/BCwKLkkMp9
	/ze2hLckUurZetducXO2h0QYhPvDUxOCa3tUUDXCEVD1QJP+BPY/UVwxhMHzSjxsvd63dsLwrbg
	dANBsqxxJj8qcNfe4AT61slupMt55iIO87Iz5DSGN4m87KWzl1+ubV7yq9z8gSiJBuiRK6M2Pjz
	AlfGJrn2pZ5C/beIA==
X-Received: by 2002:a05:600c:530f:b0:49f:ffdc:939d with SMTP id 5b1f17b1804b1-49fffdc9a4amr125086635e9.9.1790702133757;
        Tue, 29 Sep 2026 10:15:33 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfae123sm101113665e9.13.2026.09.29.10.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:15:33 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Richard
 Cochran <richardcochran@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Andre Przywara
 <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v3 0/5] net: stmmac: Add support for Allwinner
 A733 GMAC210
In-Reply-To: <93870bce-b18e-4eed-a9ca-1d01313c61a7@lunn.ch>
References: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
 <9cc61625-47c9-4bdf-97f0-0528f661a399@lunn.ch>
 <1j7bkb9h5k.fsf@starbuckisacylon.baylibre.com>
 <5fae3b42-552a-458a-9710-927360e58c37@lunn.ch>
 <1jv77u8yak.fsf@starbuckisacylon.baylibre.com>
 <491f043e-6dc6-4936-a490-31a3362c5b6e@lunn.ch>
 <1jse2x91oh.fsf@starbuckisacylon.baylibre.com>
 <b41e7fe4-2ec8-428e-81ff-47e1c75003b1@lunn.ch>
 <1jecec3xnd.fsf@starbuckisacylon.baylibre.com>
 <93870bce-b18e-4eed-a9ca-1d01313c61a7@lunn.ch>
Date: Tue, 29 Sep 2026 19:15:32 +0200
Message-ID: <1ja4p03rnv.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On mar. 29 sept. 2026 at 18:10, Andrew Lunn <andrew@lunn.ch> wrote:

>> Thanks for the heads up. So if I'm reading the doc correctly the PHY
>> adds 2ns
>>  * on RX if there a 4.7k pull-up on RXD0
>>  * on TX if there a 4.7k pull-up on RXD1
>> 
>> The schematics for the board are available here [1]
>> 
>> * 4.7k pull-up on RXD0: so we should have 2ns Rx from the PHY
>> * 4.7k pull-down on RXD1: no idea what this does. Presumably no delay ?
>> 
>> I've cross-checked the HW, the resistors are actually fitted as the
>> schematic says they are.
>> 
>> With the HW setup, the MAC setup that works for me remains
>> 
>> 	tx-internal-delay-ps = <1620>;
>> 	rx-internal-delay-ps = <1800>;
>
> These values suggests there are delays on both Rx an Tx.

I did not mean to suggest :)

To be clear, we have no control over the PHY delay.
The strapping/doc says the PHY provide 2ns on Rx, none on Tx (presumably)

But I must add 1.62ns on Tx and 1.8ns on Rx through the MAC for the link
to work properly (the values above).

I don't have an explanation for this. I assume the PHY actually adds no
delay, maybe the strapping implementation is broken. Maybe the PCB the
already adds a little delay which is why the MAC just need to add a
little less than 2ns.

>
>> 
>> I know it is not aligned with what it expected but still.
>
> I'm flexible, if in the end this is what is required, that is fine. It
> will need a comment explaining why it is needed, why the guidelines
> are not being followed.
>
> Where i have real problems is with developers who don't respect what
> the guidelines say, even when their hardware could do what is
> asked. They just do the minimum to make it work, and call it done.
>
> The comment is then important, because i don't want developers using
> this as an excuse not to do the correct thing.

Sure, no problem. I'll add a comment in DT when I'll submit it,
explaining what we have found regarding the PHY strapping and effects.

>
>      Andrew

-- 
Jerome
