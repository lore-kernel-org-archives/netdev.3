Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80531F9AC
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785695814; cv=none; b=OpZeBpDQyYhipaOZvsTsk37Kvfqp8wiPOq8wRu/t0yzWBz6TSb0XZlM/pvUX3BXHGs5CPPlilw+/uOkbYGxwPzrIJvMq0fIOthsBGfHPZXJsfZILBlzaKDE8yWFjZuo7eLl2A2zdU/EUNQvDbSl3XRap6tRyi3IbkE7pJr4jloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785695814; c=relaxed/simple;
	bh=/lrjM5Smcxb7KqlCg0ur2BChesqCLeJ8dHbdBo8GvSY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dVuq3lrCamWvwu2C6GXK1vE9NT7eTVJrS+bdy7GGhoIi7w0Dm8JX8fxRlDRGSgAn/yTbHporzk1rSaeQEyQ3WWOl0WXcsYKyMG1K3BCcWyYz9HZZc/Td8+ZvZlFnij15H14apeLFpcf6q0TEOXxHTdX8M69YMY+fuDz1nLDmzVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjvNI/vk; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjvNI/vk"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cabf1f1051so6604465ad.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785695813; x=1786300613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aG1bOt8IUbOOdwkN9+W7WbkC/YNxezey+sMvkLFdoso=;
        b=SjvNI/vk1RispaP20h5FV4RDd2ekYNepT7BlM6NHyJn6dpkUSY+yJwYUD2iSJx2YfV
         MSllNMz2aZHwIBCAMJO5Y9YehAunXGIiBnHZuxTtqGK73q59SPn58jwd7/HHVTrIkLUZ
         CxEP9t8OIVlTQqRCcPzeNS7j31hnPXtUXl52FNbvXENOkkE82KKCwTrvRQ6idSG2EH1a
         Uvsvu9UUXwweFZzLqFz/D7HWO+5J/AIGs2LPF2jSrn7du2pc5ckJye9xZYZTQ7rTCPH/
         60rmRpe0jr6AUh9dg7rKidNAh2dvc7eJnMzT2OjF1FO0tdY9IK66XX8Z8Lms3YbAJ2w6
         JIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785695813; x=1786300613;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aG1bOt8IUbOOdwkN9+W7WbkC/YNxezey+sMvkLFdoso=;
        b=SXJIao2D1KoVHEG8qjAbrOpnGliyqtsF9SCEfIC8gcGUSYNSY2w1lokaI7nJXM8EVT
         uav/y9LfBl7Qe5buNND2QlfMofSh5KM4B/ZqPZnCUNW0ghkmki/9P3fCTAZTntysqbSG
         3MI9vBway6idg3djWYBkRFE+OChcw2YPZQ1vGz1KOobkU9/4KneCGM5s8/wTh1vw5xQu
         TxYgd24eibaG/nLM74cRWaWulcPqvFTYuR/XEs6h4UNOENn9kY2+Vc+3WH1C76Q/fp3Y
         Mfg3q4SR6xgNsDRjMLK4/9eqgNJ/wJLXHvBqkdFGIZ+pFb+7in97RI25w1cJ9FlZl8Rv
         GPsw==
X-Forwarded-Encrypted: i=1; AHgh+RrZ33CFNEd5696FfsemGZ/NzpXtkVVktu90fm5lJQ6ZZZLXbuhU7O8eRjaaois1Udbrf/IUbNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7Ju/0j0LgUiCVSgoxfdkC2awcDD2qbFgDzOWnBLFnS7yMlC2
	evd+3DvCEqi935NUKa2B/hk4MMlf91BGMEFXNdeqqJjW4g+URdE73hEE
X-Gm-Gg: AR+sD135WB+UglB5cssvz3YuZ4yDMccpk2MO9v0SirH4tgyN+6m3o5hBPi/7MRh3YTi
	/Yrlgntco4K7JJ4rOrwA/47kIMKt5SkJqmRWyoRQjAI9xl9sXJ1+Oljw1TXgrWi+ZCs5uyLn6xG
	jnalmYjpFxg7QMS5YUCisfTTMWrAG/ZRKhbEUCXFbbLy5KTQRCXotXo2PLeeuzIO7fxX9RYu1hI
	KZ9x4GUcbGVTtx9ioChhO+gTwiLg2TPPHBoKfxQy8a0j7o3b+N15R5piZEroxYqWSfiXDCgpoBh
	diotSETSsSkGYoZXMGov4ABjAnv80aZYpCu036dN2UBVRyPKJvwSdts9iXZ62dkGk09CHcOm7W6
	tSGtrHJQUMaKaaFBOccvOFeyTcTQJsYICPzSRrMs5X3vf7aHgnrLMPem5XkkLwyZUiOY7lexOiU
	0Hxa96Mejowwj3afBTH6/CMkiiygnn6U8XTRoiZ0DlXyAh6lDin2nYeQ==
X-Received: by 2002:a05:6a00:ad1:b0:847:9518:a6fe with SMTP id d2e1a72fcca58-84ee4824d25mr6884770b3a.26.1785695812531;
        Sun, 02 Aug 2026 11:36:52 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:5a0:1000:10:233::14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d7ff7sm2615191b3a.49.2026.08.02.11.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 11:36:52 -0700 (PDT)
Date: Mon, 03 Aug 2026 02:36:43 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>,
 David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_05/10=5D_arm64=3A_dts=3A_rockchi?=
 =?US-ASCII?Q?p=3A_rk3568=3A_add_XPCS_and_fixed-clock_nodes?=
User-Agent: K-9 Mail for Android
In-Reply-To: <4106e359-aec0-4f38-b74f-e9757a48eebb@lunn.ch>
References: <20260801142244.679437-2-coiaprant@gmail.com> <20260801142244.679437-7-coiaprant@gmail.com> <2847036.GUH7pLUipS@diego> <CALj3r0gqvFZPb2SKRMPwf9chCx076rwCnXEoOMFch_V-fOKV6w@mail.gmail.com> <0e9d16df-7332-446b-9321-ce3de3111ffa@lunn.ch> <CALj3r0guMmNRN4EBbKz7stPNMSqkLBvms643YXBEDMzqHHM=FA@mail.gmail.com> <4106e359-aec0-4f38-b74f-e9757a48eebb@lunn.ch>
Message-ID: <2810D16E-6D32-4D01-846A-65A853279603@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 2, 2026 11:19:37 PM GMT+08:00, Andrew Lunn <andrew@lunn=2Ech> wro=
te:
>On Sun, Aug 02, 2026 at 11:28:12AM +0800, Coia Prant wrote:
>> Hi Andrew,
>>=20
>> Thanks for the detailed questions=2E I've looked into the clock tree
>> more carefully=2E
>>=20
>> > Do you have documentation for these Combo PHYs?
>>=20
>> Yes, the information is available in the Rockchip RK3568 TRM
>> (Technical Reference Manual)=2E
>> The relevant clock tree details are also mentioned in upstream
>> discussions and patches=2E
>>=20
>> > Can these clocks be enabled/disabled?
>>=20
>> The 100 MHz input clock to the Combo PHY is a prerequisite for its oper=
ation=2E
>> It is generated by the SoC's internal PPLL and fed to the PHY through
>> a fixed divider=2E
>> It is not a gate that can be individually enabled or disabled by
>> software; it is part of the
>> PHY's fundamental operating conditions=2E
>>=20
>> > And how is the Combo PHY fed with a clock? Does it have an external o=
scillator/crystal?
>>=20
>> The Combo PHY is fed by an internal 100 MHz clock derived from the PPLL=
=2E
>> Specifically, the PPLL runs at 200 MHz, and this is divided by 2 to pro=
vide the
>>  100 MHz clock input to the Combo PHY=2E
>> So, it does not use an external oscillator or crystal for its main
>> reference clock;
>> it's generated internally by the SoC=2E
>>=20
>> To summarize:
>> - The 125 MHz clocks (xpcs_gmac0_clk / xpcs_gmac1_clk) are outputs
>> from the Combo PHY=2E
>> - The Combo PHY itself is clocked by an internal 100 MHz clock from the=
 PPLL=2E
>> - This is all internal to the SoC and does not involve a board-level os=
cillator=2E
>>=20
>> I hope this clarifies the clock architecture=2E
>
>So what is the purpose of the fixed-clock DT nodes?
>
>If you want to describe the hardware, is the PPLL in DT? Should you
>then add a fixed divider to give 100MHz? And then a fixed multiplier
>to give 125MHz?
>
>   Andrew

Hi Andrew,

Thanks for the follow-up=2E

The fixed-clock nodes (`xpcs_gmac0_clk` and `xpcs_gmac1_clk`) serve as
clock inputs to the GMAC controller=2E From the GMAC driver's perspective,
the 125 MHz clock is a fixed, external input=2E The fact that it's
generated internally by the Combo PHY from the PPLL is an implementation
detail of the SoC, not something the GMAC driver needs to be aware of=2E

In the device tree, the principle is to describe the hardware
interfaces, not the entire internal clock generation pipeline=2E The
PPLL configuration (200 MHz) is already set up in the CRU node via
assigned-clocks=2E The Combo PHY's internal PLL that generates 125 MHz is
part of the PHY's own operation, not something that the system clock
framework needs to manage or represent as a separate clock node=2E

If we were to fully model PPLL -> divider (100 MHz) -> Combo PHY PLL
(125 MHz) in DT, we would be overcomplicating the DT for no real gain=2E
It would also make board variations harder to handle (e=2Eg=2E, if a board
uses an external oscillator instead of the internal path, we'd have to
rewrite the entire clock tree)=2E This approach is consistent with how
other similar SoCs (e=2Eg=2E, pcs-xpcs-plat) handle fixed reference clocks=
=2E

I think keeping these as fixed-clock nodes is the right balance between
accuracy and simplicity=2E If you still have concerns, I can add a comment
in the DT to clarify that these clocks are outputs of the Combo PHY=2E

Thanks,
Coia
