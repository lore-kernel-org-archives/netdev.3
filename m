Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032D283FDD
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785641302; cv=pass; b=pcrkf/0lmzUEIbg/pzSEfgdSyJ1EZyHwP+upGun2FRdBFEEMa8R8EY+eamGg8y9z+SU+ls7987hCBaK/mh5lNzENJRvZHZ8PH3LJTS+DlR/2kg3OzCPm0xN10eMEd5jrfMn88fDhb4uqKWVyQWyOF4g+nz+LQUh4nUWsZykoOqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785641302; c=relaxed/simple;
	bh=/0w0YO134zBV85YwnHp+km6pCsaY5x0vppPkNuKA2EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGto3HB01V7dZ0KCQM5IgMkR3nsBpO144j7tu3AH5ExrdqnZMbb3x+VzJqa/XLwitcdm5OW4PLxULJAuwcj6cOwCM4PfNt20/Dauunj+QnotVJWJvwzBuj7UAqeTwuQc08GtebiGSx8KCTSvctAuKjvsZj0X5jaMdCBmvCorQrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYwSs4f4; arc=pass smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYwSs4f4"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c1971f5efc3so109438966b.0
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 20:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785641299; cv=none;
        d=google.com; s=arc-20260327;
        b=r2zch4w3Zw5EDrKZyn74Pjztp8iA/2E7TXW1Vjyl4Ykhf71I4tR59QiuH+/mjlzVa/
         Pg4WLwqZuDc2QxGiYKJjb+UA6V9zdWoPBadmT/Z1qjKoDAI09apvLkqqykZGByq/POtk
         LAcAEu3uo65K3zy83OrQkAU+VWPwnCUG5iq+KHC1wOj2N16BTNxqSTL0PX/cKxVzc3h6
         f4scpXPEV5DPJRaNvAwHJAIx3WLnBiUmE16CSR79QW5mg3nGAb5TafMu7NPh16dAHOyY
         2HijqqppdWxm2LRqTIyVHQbLLNkH6DVPFk2IVVO866PdYQ8OggWUGs4qz/BLOGErgcC6
         DRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/0w0YO134zBV85YwnHp+km6pCsaY5x0vppPkNuKA2EU=;
        fh=FvRI6uqfwNnZxT/k5VoZnPWz5suO3MSDCHdsSaGvpbY=;
        b=rPLgoRCxtrq8mGvoNOAqpmRjczgQI0tXC/8YqxcsBBuoXx2b7OG/o+7XmkhVbyif+c
         3xGnHpofptIbV9EHDImzo8650V1Rh4fLLtHTiOc+vi45j9dm2/JrOyFhxjSm8T4lONel
         9bomXUBjtt9ZkGAKIdrfgbBI97/bpcUD4EclC6b0XAHWIatAAm30+JQspOm7+c51FvX7
         0+YWw5WVKWnLh56i1r1J3uhpPbq3rXmN6F3cT2ZrneoqoGQeMYcpXyrw+4vZN5xMJPC3
         xJxpV4ii0vT4NxSL/vbUS+6Npkw8V4rT6RMYjdMLtVKqAU23MC3g8OKkhA0Gzhz99RM+
         BcDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785641299; x=1786246099; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/0w0YO134zBV85YwnHp+km6pCsaY5x0vppPkNuKA2EU=;
        b=lYwSs4f4QRVNApHpA5Fbhp2sxug4AuEXuNJXpblaWPsau5ckLJuoebcgMXgilkYW6r
         01VJi1tWXpw8fCCm0U5/qoWHZ9dZuZPRS9HL3Q9H86+0fowVsyTI00+HtBWXcwKehzho
         q/NwpTsDxXOa1KFvNVcBx79ISSJN3Sv9ChmFnHZa3cof4Mnugoe08/U7K7zjMaXZoHSe
         MxFR1aD/W5nbtsYvsT24JSkTbzXzXWXf+5x8GgEYVzzHWfpANXJhvZ5IsKl3c4+/kW0D
         xNkdiyAQAaQGUYpPwUTHsEhGkTjAogV7+wPIinPeZgmsQ7vyaMyQJPgLVLLzBvR/GHaP
         SOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785641299; x=1786246099;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/0w0YO134zBV85YwnHp+km6pCsaY5x0vppPkNuKA2EU=;
        b=qX0BUgmJCeslxyoXUQAcg6WN+hMZ3ipi+goK9mBFhBQjdvkdAMtPLZyARFh4TSa8E4
         OkCx0VObmy5FbYHFwXZ/atWxPORki473JpUmGoAhzFeeOiTDgRAbwHL7GnT7rfv6UbHa
         2F4SC+cQ2I+7PFRQiYDyChmxdIIoDxbK8XqqZPjzcq3YCoSVZIAz+11pUhtS38QHqHbA
         aTGybOJUYJ8BwN9o+rJjdiy2HqzAHEe0krXXxrySfnxCaOculymYsqFT+fos3MNm2XN+
         kKkL4StjZQpMK1JCYeaSxOKUbG5oc75y2eTr0fNr+kb7UIIUV76rMWaTW39nBPCqBlLt
         d+wQ==
X-Forwarded-Encrypted: i=1; AHgh+RogFJ5X8avd17eJ9wfepbFFoV48YAAUqcuh/BCrduVAskEauJeb6INr+LAr3Q/qZ37oJWaDZfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzauCIWFNQDUuhNqAJnmulkT4mhmrf638P9u+s1PI2QTIeO3v1P
	YUSKZ083aB0RWpra9W9USFxeu53XX2Q6O2q4PjjjJbI1vA66f1yoF3IvgM11CRGucObfUKQU6z2
	O4LWvdZhhhVkIQQQ35amDxwsiskQye9A=
X-Gm-Gg: AR+sD12LPT53nOWRcSHVm2COLgVdXOoCFFj+6D5pG35J7fU8rvP5x4cQbuhWsERbAPy
	uAraa1wddLb9lmhziVNUN4JQti7v+DwPPJVxdIPv6TGormKKOWRAb9OsZzkHRJL0SC+SJm/ytXS
	VuHzZh1WAZpKbd593tXBdSIxUWxqtcqBlv0D8ugjeKFF5QxLO8znf8SQFfkFwEuZ3AfqZsJB+LL
	TFRz7DCDvYh0v5PgVpVJboEFYBNzrQONg06C7v3fQISOM7m887Gy6zlJLtf6Xc0SNUelMXyQm3o
	WBWkbYaanC+t1EYvEzfwU16e7LKRn9kmh7eSB4f5yi7b9QvPJHUZkfZPs84=
X-Received: by 2002:a17:907:7b9e:b0:c20:768:af62 with SMTP id
 a640c23a62f3a-c200768b973mr9148266b.22.1785641298865; Sat, 01 Aug 2026
 20:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801142244.679437-2-coiaprant@gmail.com> <20260801142244.679437-7-coiaprant@gmail.com>
 <2847036.GUH7pLUipS@diego> <CALj3r0gqvFZPb2SKRMPwf9chCx076rwCnXEoOMFch_V-fOKV6w@mail.gmail.com>
 <0e9d16df-7332-446b-9321-ce3de3111ffa@lunn.ch>
In-Reply-To: <0e9d16df-7332-446b-9321-ce3de3111ffa@lunn.ch>
From: Coia Prant <coiaprant@gmail.com>
Date: Sun, 2 Aug 2026 11:28:12 +0800
X-Gm-Features: AUfX_mx4aMsgyN6RI3IxSSP4ztvHebSR5krnQ6YdL4RSbunpB8OT85Rvkz3cx3w
Message-ID: <CALj3r0guMmNRN4EBbKz7stPNMSqkLBvms643YXBEDMzqHHM=FA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] arm64: dts: rockchip: rk3568: add XPCS and
 fixed-clock nodes
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
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

Hi Andrew,

Thanks for the detailed questions. I've looked into the clock tree
more carefully.

> Do you have documentation for these Combo PHYs?

Yes, the information is available in the Rockchip RK3568 TRM
(Technical Reference Manual).
The relevant clock tree details are also mentioned in upstream
discussions and patches.

> Can these clocks be enabled/disabled?

The 100 MHz input clock to the Combo PHY is a prerequisite for its operation.
It is generated by the SoC's internal PPLL and fed to the PHY through
a fixed divider.
It is not a gate that can be individually enabled or disabled by
software; it is part of the
PHY's fundamental operating conditions.

> And how is the Combo PHY fed with a clock? Does it have an external oscillator/crystal?

The Combo PHY is fed by an internal 100 MHz clock derived from the PPLL.
Specifically, the PPLL runs at 200 MHz, and this is divided by 2 to provide the
 100 MHz clock input to the Combo PHY.
So, it does not use an external oscillator or crystal for its main
reference clock;
it's generated internally by the SoC.

To summarize:
- The 125 MHz clocks (xpcs_gmac0_clk / xpcs_gmac1_clk) are outputs
from the Combo PHY.
- The Combo PHY itself is clocked by an internal 100 MHz clock from the PPLL.
- This is all internal to the SoC and does not involve a board-level oscillator.

I hope this clarifies the clock architecture.

Thanks,
Coia
