Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793573885;
	b=0u8piOxB0hbF6KB1KAo/nYPRqyt7hEips/dafOQbkNdVX7jas6YFsiccDNECI4qzvvIu
	 Gb+ZZ7kryCh7x/FHhP0UvGBCoM7QXcnQYiEOe/7ynyp15uweUhlEDgrfkJTFA3/jN3tVs
	 7n33PMOxldIG5ocDrdJ+MKtYUFfcUEKMhsMQiZtlwz3X0L8E/OWJvsn/bTtSJ6Xd62Pfq
	 KFj/N2g1ye5TJHvnLuW5HrjbjQRQQ1P4X1lVcokuET7xe4HbLTpl2JV9MeY6ugaIona15
	 TSHu1aRImgB+hsl7pznTwgVsN/df+ooKKVWZzF4H9qJQFacXc5Vfy5Gy+JaICWRFoeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793573885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5hA8T79umdOtjSmsdO6dNcesjyXAMCgZnStc1nU8y/M=;
	b=tCPiPzWjrhf2Tpmn66xRBGLJg5AUl2nvzb9qthwE5jAXQ5IF4R/Jia/5sbkXY53wn9tW
	 LendLY4wpnDfM/Swkww2oc8z01QX1jSULtYsdTVXuqZznELeDz1qfxbMCOhc0tSSqgf6r
	 uKK3gBVDtIWybOw2S1CXQWw5Y1bAtRuTLrnlr4omrY4bn9gVZRbYWQBzlABs6jZaVOhkK
	 fnwE/CDRXYxEqLfWPz+taf6CjZxEgijVU13dfJC1tmPOi9lWxeMX4ZojvK6q1CCPPWUuK
	 Ht2m5QWhPRAcNcxEyeRgCTHWH4QUpA8ciEiKMV9gNaSKpzE6oVDJH0LnMbtX0a18ncg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=0gw6988x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F43606A326
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F43606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=0gw6988x
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6798c43a3d6so1560769d50.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 14:58:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793573884; cv=none;
        d=google.com; s=arc-20260327;
        b=ruCK7EheMRQwvYQy9mdoUIN/9VCoW9Z5aEE8Y/MMbBT/GkSPEZ0ifWnBZzpTIDuLFx
         I+YGyRjNYk+kH0LPhxHYQIwTptsqtvD203C+OXWtW4DU+C+VWhpjXd6Fml0Z/fi/vGy1
         J6T5hkqqtq9GpbED1XR+bI9rGY+Znbtb4lLuU0te2672/NTvUa8Gon5leFLuGTdToxFe
         tFhs66zFczbySyt9tBULx9dxnTBbWocnXriMWNSrgFQAgjltdDT3MwEY/F62aKrsCTNk
         mu48o/LiOgkezkCMzLKn+PV4z/k9JXku9kKg78nmsEPnOtOsugkpUVKxMirT+7cmSK+5
         njCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5hA8T79umdOtjSmsdO6dNcesjyXAMCgZnStc1nU8y/M=;
        fh=NbeQ1LdEgALKb4XM/D/dWRr4aIABwCY+78xabdipTHU=;
        b=nyVgO72Aqs7a4AtebXTe87bxlibOGRG2bd/vKV3PqM2V8ZW+phqygm3F/Rqb4q5RN7
         JA2do2rH7qzp6uVSzwe1RpVqsQPvjYo/I5lN8z1j+PGEDTQnhwvLMxIpOpQop9onnjmO
         OcD7XT/M0AQ+KO8e0ct7fiwtwDB1tep+LTmEEae1JZI/sGx0+Po0KG989ENl/hD8FTwD
         +2Bhagu4u4PVIoCoxlSynO6x5uuWkxTsjxZMkbn2KoWuy35TZR1s9ADl1WY+jMBWmZaV
         jY0DIemUo3ej+b4pZsyTZ44BK+go9kfxyV8Kmzt6VCZ9uKqcorZ7MCDeSaFmclRzM2FX
         NKZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793573884; x=1794178684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5hA8T79umdOtjSmsdO6dNcesjyXAMCgZnStc1nU8y/M=;
        b=0gw6988x/OCDWClJuRql+I+XqjdNXzUvr8O7ZEWcoZLYy+VvIdMXHwqGOzr8ayBDVe
         yAEgvkjZgxnOlVYfaCDGwnezLFdbkElvBGH/pZz0JKPgX3IBpkZEB8IfvlFsOB5S7eiY
         mnxJzw5l3aG4qaWan6aQn88UimfqUzjZdxgFQGUx4s2is7MwTOOLzoXwLaoKR5Bri+uL
         SjsUMD+eYTbmShVuq1uk/p8J6RsKY3ex7k+P+oZ34VZqStq4oW11LtZUeXg0kaS7VjwO
         1v+5wT61XpShxrkIiR7xRWxyb0X2P+mLhm05+StfxvxoNrltq5aPXXECR5VB1PiwGdYK
         +o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793573884; x=1794178684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5hA8T79umdOtjSmsdO6dNcesjyXAMCgZnStc1nU8y/M=;
        b=MCmoh3rNs4tp1VqzmJSt7bVDL8aX2oOq7X0tzZWNGD/W2jVaIidlLNJ5Sh89LqZGGk
         z1f61CGnt2Rh1FAGuZDuOa6PjzvqwgdH1S/E2mNdYfJ9wAQz+znQSazDKujd7KNrnKLd
         ONayDJaDjwYuz4SBeLXTXWvFyaPXOko3jKSX0CRDDBq5rn065eQKdNORCNt6DE8MVykx
         PFdWjJe6KXdNL8CE/t4c7rtv8Y/IktB/DYmO+xMsA3Hpk6lkT56wxBdoPaXLyPp74s7d
         MpsERSXUNQLH5ZOVSmPjsXlXEuX1JiAvYfiID8A9brue5HbkOu3cjzoIuRAwxJdbTe1f
         oSYw==
X-Forwarded-Encrypted: i=1; AKwUvBwZS6PW/aTiSz9qG6twuQC4OswQU+HJYmfHWJ2D3TVess/EbS3giNeW14vBnTjj1BYi55+tv1Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8suQIBs8nFiQQQyQRJmMZ6tp1XCF6hgcL8h68TrMmgkBS8AoJJ
	sBnc2BCcm29IdpxlB4jssFqQxETa+feh1Dlgler5m3DGyYcEd/y6aHlu8gHPv42MdQHed+6sMaG
	4GDMqdUCSd1YPrEcsh4Ejw+R+LJhsdX8=
X-Gm-Gg: AYBFou0Wc9LcQPH1j7hRcUmU2cG3LVsGwRBL8mnNpwBsB3ouvdoNq/oEQ/Ae4JRqO/W
	1CYJFIy4oW9JVCPwtqBp9Lv8Lqboyj7ZVTh/L5pUhHtvygQKb35RK7f4Y51N1IfC6gY1W9J2xby
	9+y3sE+veyp213lezDKzZkCEVuf7sAXJRXNPrurFNDNHaYK8bjsrxmo67HnQgQjvBys/UDsiaFg
	I4BJXiRVx4zDa5XsIPPjbah9Cy9b+0LvZTjNxCkhzkpwyFA56O2wOfjg6UYsDa7vIWwA4uOpVLt
	MdSxwdk0ifqmf9zso+Zy4eXNWVVrV1IKKWJxmMM3wp1Ho4edPR8OljX9VgWWqGsFOAqFJrLKs76
	elPcx9WdBdm8rfRtbgA1ma2/coygBTk8D2c9UA1XSPF+WRHTtRnh2P/WuuUmgnUXy8Dk6Yg==
X-Received: by 2002:a05:690e:4507:20b0:679:5bea:d3f5 with SMTP id
 956f58d0204a3-67ba4f7cd36mr2946413d50.50.1793573884100; Sun, 01 Nov 2026
 14:58:04 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022200640.3101932-1-tanure@linux.com> <20261022200640.3101932-5-tanure@linux.com>
In-Reply-To: <20261022200640.3101932-5-tanure@linux.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 1 Nov 2026 23:57:53 +0100
X-Gm-Features: AclHuK9XeeIDEqdtINHt3p0JMcC8yqSM3_Rvc2uE8IOAzFd_ujX08owtUzvHpsU
Message-ID: <CAFBinCCtfPCsqN5yG7LWDFG=tyJ+aHix6x3yiXfaTAPP_A-hAA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] net: stmmac: dwmac-meson8b: follow the generic
 RGMII delay rules on the T7
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 10:06=E2=80=AFPM Lucas Tanure <tanure@linux.com> wr=
ote:
[...]
> +       if (!dwmac->data->init_delays)
> +               return dev_err_probe(dwmac->dev, -EINVAL,
> +                                    "missing init_delays callback\n");
I'd rather let this crash hard to make it obvious to someone adding a
new SoC that they forgot something.

Other than that this looks good.
It would be great if the netdev maintainers could comment on whether
this now matches the approach they had in mind.
