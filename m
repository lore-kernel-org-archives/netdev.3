Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8F43A7EE
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127881; cv=pass; b=cZ62u70OORh2jUDsdSJ9l1pGHKj5D5IA8F4M5dhw36P6AqlM710y+mU/OD/0zlSjyQF8urz6kdgv66GRppUQRmJEao94C0sXGzsZtOWkJDbt82/1YPVfePL+v0E7Rk6K5vZS2GMgtHYQI77MAG7QOKzOagTwi7hQywZEO/pMU1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127881; c=relaxed/simple;
	bh=J2Ex/vBwZIsuMi8zq3Q6TdHn7fEispCyHy5fZEUhOmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwREcEfXcpzyFYQ+KVSotofeOZYDn27tRrH5FhmSGj3tgCG0w5P/w7lqLvQxMvWfg9Fd1bmzJtK66Zsiv8Ky+O+UWldaRzLL0KaNEZUSLnI1CKTUzj2ErAxhZ0Ce1jeFK+EmY9ykFpIrNDhbtSZSGfyVqxDChhIPSCuMjx5zhPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJaAIuMK; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJaAIuMK"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15dd4b9132so805759266b.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784127878; cv=none;
        d=google.com; s=arc-20260327;
        b=Czfbm2FoqOh3AuVwDy2INUHJo3pRInlv1ogBATV1Qmkhf6St8Csf2Egt/SzySpP/bi
         0WJCR7J5Ijo6mVod0N1HlXQS7OlDln6YsOIywGolhb61aIIGUdsb1P5eqR9qhEXUVLaO
         423zi4DRJ3b0qi9MdOCQNkYu6TPlEYrc5hv2oEve2y0vI9smZUyY9s5oEqZ7AGji1PnS
         VqI4/Qhpx7NRkjjDlhe1sQ44cexiRjNz7GytTAuZOVu8EyJj7lQra8c673kRNHyt3rAb
         Pp8Gwg7asPP/Xs6Yicyom81+M5STnBUPPvd8ZC/ZbFQX79N3EWyv/7QVPgmCaaTTwnAh
         N0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DG9Q2oJgppieJnnBNek/PkQaa2uv3zufxUx3ZgWYTcs=;
        fh=Ap1nB4ERxqz9XMUFMQVUiQYsMiXbMC3PYYlS6+Wx/iI=;
        b=HDpNvwe6eMiVtCmgBovE9z2H5GOW9za6yFnTwU7GWojejvvsZQCrYK8lz8Y1C58M6P
         SwuQUaUkFVPNRtNGjx1NztJdkfb4NZvun5droen1hPUyDrT9msEur5AUX7EkATnMkTbW
         sBubrIRDve8YAVKN7TGFTn/c26bCInG6NOEsoXTvovtLptxMOgoUvuwykyAkQ/N2Znpo
         hnGEIJUFmqLJyW/jTkEzLhU38fXB0rqdOH7lSGFyLVitasAf7yzrFa2TCs4pi2RPQRpk
         HCvkvSoJAURm7B+F4A9NJhzV8E5ay2hRHW5d8HmpQaIdh9bHi3fdQNhHTrY2HjzrDirV
         PqSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784127878; x=1784732678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DG9Q2oJgppieJnnBNek/PkQaa2uv3zufxUx3ZgWYTcs=;
        b=gJaAIuMKPxXQVyISxn9VnnIyCwa7JD53mV15MdOsW/qk2RMyMu8ECJB1tedkCF8uhm
         dXwsbVshGE8t1vNH1hQHXXly2Ti+jEDYj04vy6oWBZO6fA2TFEM7enXIKQNfj6qyQ1eU
         0JD8/XRbNH1p/SnIdRQB6ptasP7VuF3XPwvHpEE0bwcfKof6b0XFyacVV3zMX80bIuDP
         cSR5jH4JNHUzG1obYh8iwhfMQhq5O5d36PeWUWwvhna7wGHPImmj3ftXQFIt8tKIHK17
         uiRKqdfIRShbVoo2LcJaW0BjYisSM93bqygHZLCe1zDRT/yiObA+zD087fEnF5ZtJhe9
         UynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784127878; x=1784732678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DG9Q2oJgppieJnnBNek/PkQaa2uv3zufxUx3ZgWYTcs=;
        b=GWhZ9hEuLl34PXjZ4weLlUx+Nw6rEJ7RKzG4J9MJGObwdvRB1TP2iBxcyWae4hog/8
         9vAJn/hACwFtBIdPu8EkrLfABSNHd5ICPEAEai2l6o3EWTx/KBaTX/zLfjOIeheajkLB
         oq4D96BTXQ6qVSmBab2KvksPIa4q0F2IwTBAfCnNk3dXyopXBS5xtZU/uDym5w7bvtLo
         C0pytvlMFsS6bqFt95GKXFHXF2I7J3IbKKmpJ5xvRK95O93w5Xc4IQyHe7vdm4N3QtIU
         x9T4ZtnxyDjlAxKkTnPvgWHbNUI7Ig/2FhAAjXMvDw6lPP7G637wFYeGntPVFgbTuTy6
         MQ2Q==
X-Gm-Message-State: AOJu0YznxOb2XOyYMLzoiA4jSY3lRDZbWKxPkUAiUM3UYnF0WnQFOYHN
	Ik1VbVSpxzV8jYdG4bJ5sY98GobJ74aiUKaUiRA15PfzErePClW4K7/JpWSymCCMu9QDwIp+btM
	M2Wl283iJfPywLtsiV4tLqLwVSIHa4C8=
X-Gm-Gg: AfdE7cloOSR1lgrgv6N+ABaDv5jKdsCOcGvo7sMeyZXfiS44wJKI98DrbS2GCui8++u
	okQ/+xSuOA2OUHNakr9JCccDPiCySaotPDB0gIETdaiIFsZJ1CgcYIMTNlf5FWu0gYH6FM2jq90
	BYJTQSGUT+yPctFPRLf7r+bVg0FMKLNyV0ZQsU1UN7Mv2BYC9H39x1lAjHIW9cUzfc4p5SIUBpa
	sHx+e+it7B97xC8xoHmx/Hz9rGOJXQEAX2E1NjNK8s1//rlaFNFO7mA0UEO3o/huemX3/FHzw==
X-Received: by 2002:a17:907:3d03:b0:c15:f476:9685 with SMTP id
 a640c23a62f3a-c1667a4d040mr437375366b.30.1784127877536; Wed, 15 Jul 2026
 08:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713131223.279555-1-a.shimko.dev@gmail.com>
 <20260713131223.279555-3-a.shimko.dev@gmail.com> <5c95a7cd-d5d7-4998-8641-7dee1e34078b@lunn.ch>
In-Reply-To: <5c95a7cd-d5d7-4998-8641-7dee1e34078b@lunn.ch>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Wed, 15 Jul 2026 18:04:26 +0300
X-Gm-Features: AUfX_mzls_I9Vp10-hyrFrNgdKmPyVr__N8ZHCRFExvJHAlqZdwP3XzRo9bwUe8
Message-ID: <CAOPX744Xi8oJqcDHB+TokuRJtY8fqjeuQ=xm2QmLs=PUyo4Qhw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: add DAPU Telecom DAP8210R(I)
 Gigabit Ethernet PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Jul 15, 2026 at 12:25=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:

> Please drop all this. Many PHYs have this sort of facility. We want
> one generic API, probably via ethtool, which all PHYs can follow, not
> N different incompatible APIs.
Got it. I have dropped the entire debugfs interface in v2.

> This can be simplified.
>
> First off, there probably too many phydev_dbg() messages, specially
> for normal case things, using defaults, etc.
Okay.

> of_property_read_u32_array() is documented as not touching the results
> value, if it does not find the property. So you can do:
>
>         u32 ps =3D DAP8211R_DEFAULT_DELAY_PS;
>         of_property_read_u32(np, prop_name, &ps);
>
>         return dap8211r_delay_ps_to_sel(phydev, ps);
Agree. I will simplify the function as suggested.

> This is one of the less well defined areas. PHY_INTERFACE_MODE_RGMII
> would mean either the PCB is adding the delay, or the MAC. There is no
> reason however why the PHY cannot perform fine tuning, adding a small
> delay, say 150ps. So you should respect the rx-internal-delay-ps and
> tx-internal-delay-ps delays here.
Understood.

Thank you for your review!
--
Best regards,
Artem
