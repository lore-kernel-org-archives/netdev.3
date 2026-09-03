Received: from mail-ed2-f0.google.com (mail-ed2-f0.google.com [74.125.228.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448B400DE2
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425507; cv=pass; b=t2YAs+faLFXdq991W5cQHvX4XoYi0bs/fe2hzfb3MCsJA3fVe+pDy4m/e31R/TuTkRqME2WvzsocVHzCotSnyvyNPmgV/VbeozDOTvN9imSatT1iD0SBe74JjA2cin3yC4oVZwgyKxMtkhOibTGPsFo1PDiLmYSCPdU5kYgGrXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425507; c=relaxed/simple;
	bh=edjXy2PN+mcza+3kZSGSQQ3aYOZGZOPTwjWGFZXSb74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/H57IdN6u5T6ejMS2CsT2g7YWCTN099k7gQTT01578FYC1cv/TFYCdBwYQ1RVuHsrWxkiuoizNRbJU5bssKq4fEuIJQj7/8HHRS1b/w9EV7NtoK8WD3xJQrHYIVFQByNOsbKmXBwKN6O7ek7rhNLcfsJQI8rXy/nL9SVUvGKyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2bDsdyi; arc=pass smtp.client-ip=74.125.228.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2bDsdyi"
Received: by mail-ed2-f0.google.com with SMTP id 4fb4d7f45d1cf-6a5f79c6c4fso1026050a12.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788425504; cv=none;
        d=google.com; s=arc-20260327;
        b=ecLVifXNODV8ukN/WXXbNO8q/5YCV0PSIry0nxfdUTgdhsCpgnJxhOYZYM3mJIg053
         UpbtqF1Ec41xSN+qrGPErydutM2uwFlYKJXKATv4VMoY1luzYRbI7AUCy9znMDvtXt1z
         MJmHxpgEsagtv1IlvTQ0btIjKrkjvNDymxMk7j6V5BDKohLmrypxFmPcIUsvlXFp7k6n
         hiFhuyqFLxQ8fC6P5NyXQhUrbcCA2e1rtQzsbfYZx076BjkoN11QOQn9LzK9yyY2bDEg
         dodtvr7kXuWEmyc0HqRWiLpSHwq+dcb0Zra85OxFqwGUyWh4dn+uM01QxT6JXiDK9mls
         f3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=edjXy2PN+mcza+3kZSGSQQ3aYOZGZOPTwjWGFZXSb74=;
        fh=G7FTwwHjqonIT9XiTSd2gX6D+jRy/ao4taAjYFYjLAY=;
        b=h126WBxIIrOlBmDm1FVw0MK45JOuL83+tYuNM7xN8xfRgN+P8PM1mbezRPNVxDpf8P
         CblV5lm/vDPcVBJifh6ZrQuKb5pBf54j6VdqX1cZn0LUN3Y0/4zRUik2HjGeKvXHBSnT
         pqW1/Gy1pygZ4ArW6/aqzSLdw05M7AEducoRcSxsqSbVudmlmi//HPbNhYCNdhEmXSxn
         xAkd17s4CxeyqbVFLyf2BMgDPAs8x9hcOBFcO2tkcXpLvEtoc2yEsipG4OTro1X7doAd
         YAKkS1ALbdkcSEL9lvaH5vNks1BPftsamZKhy9wtpRRKAngMA+XanOUzoKaA4NLb7dua
         HZ3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788425504; x=1789030304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=edjXy2PN+mcza+3kZSGSQQ3aYOZGZOPTwjWGFZXSb74=;
        b=B2bDsdyie4uFLTSvRBI5G12tsRKBuEEPJP2lgXhdnzVTTLvYhGvF9EJ4Yc57LHB0OQ
         IBKSyzlieVHR7SzT++4+YZIW5ow82U9CPLW3Ajl7jRT83TQqXLUikvvirIpUzvTCt3lZ
         IeMapLnCg8QxqKZZaG4PNqZUTVbCxOF4soa/kJjmtmrTmOh00na+Ci1KnpYznJ5TvHWj
         7UxxIy+S7RSV3zXvLZ+uvjE1XWNnxNi9yeCwi6rrsFXRUxgv4/43OJ4GEA73qzKUnUy8
         ZoL7PuoGqOCagCNoSpRWdso+efjSz4y5eKXEgB3wPi3xpJwFkcHdog0NZNn+omepYfLu
         yXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425504; x=1789030304;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=edjXy2PN+mcza+3kZSGSQQ3aYOZGZOPTwjWGFZXSb74=;
        b=AFoIpXx9hDNCDfF0jSG6TwLLwEHQPpxOhhMv+fsPPQBSOb5+wmg6n0lgy9e5yLSG83
         3WwczBgClM7Tckiust/72GsMbJJxROuElaGF8mx0vYgT/f5oGsvs0VH74nPLIlkADCQd
         0uRC0tv7OvZXNOGaSTBAlK0E6VaU9zrqh57H/T1J9qyURlBhkhlU8qQf7fjc+Y5X0nfw
         F7PnMobxVNmd75Z5mpSZAbyObedbWsdKtQCwr26AiIt4JuSHXRenXo2CGrAKlQdrxZI9
         HGAlWuQiyVtFErPnRH3HXf/Cu7MMU1EF9/ZSaaux1oDo0CIk+WWgXCsb7QlBc7YRuEpB
         OPlA==
X-Forwarded-Encrypted: i=1; AKwUvBzdGaBldElwi7VGiGZAh6U5kqssAePFxFju8CC6AGsKbHmY1mqBvHAybvbYdEcFr6tpljfX9kk=@vger.kernel.org
X-Gm-Message-State: AFuF++m+xvq1UpMsSvAXtzgjjt8GUKF7ngfmsy/GBUvOn1nml56kn8M9
	j3avrKRs/A2yLih5SDeCF1dL+NM3zf74fC8HnBtidsUZ4IQKMopQK/YmAEmYRNLN6trBfpUiUGk
	2tSirBQYOVJpOkr6V+GWLtGPOu8XEi48=
X-Gm-Gg: AYBFou2OYggC/XuZVT6+MyHXDZUx6GBzLF+TCutUqMHd+5qBjT+17VHNB+fs327E8Wk
	K5wCLurVaStMvpYpHfXM58Lc3dTYqYNmmvPeTO9mJABlFU2uannxEEpq8vRSmn5HvS2V9Q/aXV/
	gBC2Utq0pJpFOS7AOSaEFKJWzwcD39VZUqBlCNH960msqvPa2uH0Ga7GXVH+A376864SouFKSmT
	aNkAlJeda5YE7UGKCkX83FTyLxIwP2CYCtNak/IZZ95VpP0qhuWkd3Jg1jB7taEVRBNhLhfRmX/
	6V1I9urcrQw4Wwv7p8NdM6I5V/VZn9u/vc2hxmz16OVMvS1IiSJBE1j3nKY=
X-Received: by 2002:a05:6402:460c:b0:6a3:87b7:b516 with SMTP id
 4fb4d7f45d1cf-6a68313fb0cmr6808251a12.6.1788425504326; Thu, 03 Sep 2026
 01:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901150111.141037-1-coiaprant@gmail.com> <20260901150111.141037-2-coiaprant@gmail.com>
 <0dec5462-f6d5-4ef9-9d02-5fdf7f3090a0@bootlin.com>
In-Reply-To: <0dec5462-f6d5-4ef9-9d02-5fdf7f3090a0@bootlin.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Thu, 3 Sep 2026 16:51:31 +0800
X-Gm-Features: AcwNN1VVEgAP8GgA8LdwjKHcWBmFmP5U9Mjud48d0pq7C7tHDzymcLYpjmHugJk
Message-ID: <CALj3r0i2msRXH-uqA2QX=cRkQwM_H2bFH9GiroEys2NfEbTtCQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/10] net: stmmac: move XPCS lifetime
 management to platform drivers
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Shawn Lin <shawn.lin@rock-chips.com>, David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maxime Chevallier <maxime.chevallier@bootlin.com> =E4=BA=8E2026=E5=B9=B49=
=E6=9C=883=E6=97=A5=E5=91=A8=E5=9B=9B 16:32=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi again,
>
> Sorry I had a second look at that after a good night's sleep, and actuall=
y here
> we may regress. The original logic checked for "pcs-handle" presence, the=
n
> for the pcs mask, but if no PCS is found we didn't error out, we returned=
 0.
>
> This is making it mandatory to have a PCS. Please handle gracefully the "=
there's no
> PCS" case :(
>
>
> Maxime

Hi,

This change covers all callbacks that use `select_pcs`. Drivers
without `select_pcs` callbacks will not have their pcs used by
Phylink.

Currently, only the Intel mgbe driver uses xpcs, and Intel has also
set a mask for pcs-handle not set.

This means that on Intel platforms, the parts that implement
`select_pcs` always require xpcs to exist.

I think there shouldn't be any problems here, but I agree with you,
regression issues can indeed easily occur here.

Best,
Coia
