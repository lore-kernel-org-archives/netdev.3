Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8602D8795
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150621; cv=pass; b=gmrNgb5RW+c3+f1LMiAgAVErvTU1oY7GsCYZ8GP8EriaZiNWCs9mZ790yXMUlbx38tg5no/WiweRANXS6yA77iPM2kz0BcWo7/sNnm1wnJvssruS2hqIc5l40yzWhpU7Tg5CrjhSsnGNXsihqr6geKloI27GYGR1iZSqGwsNwyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150621; c=relaxed/simple;
	bh=vLDo7KLVVS1EnD9wy+x+BOA+yAAhihoM7WQojo+Czdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRHfRrWJf0/chZOLcycoGNrp7Cjl8jMpTArZI6tBKuQX9F1/NnnCp2pu6HitQ2btVdTwjo6ufTqr+PTzIpZYrZJ6qyf+9AZhCgh7sYtUipFmR206L2Gl86pg3ArtZeqQB++1ez5lWc2ScpMCGphaLD3tEEfjg0GrrXbxYZmCbtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGucMNhl; arc=pass smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGucMNhl"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15e0279316so113123066b.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 14:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784150618; cv=none;
        d=google.com; s=arc-20260327;
        b=strQZ+2K1HYJCryjAb9gVQaN06jBcVS+Uw+OpVH7LIeVW6ygcBFfULurW/9RRFwcrL
         MhEu/oPA3UAoBfdHL++GhxgBC0PbCEM4Y5Ic7jMXjj4/vEML2Dc4a8HsSwGCWjirjuGt
         LzAaKk/pVStF34i/NB2BDgvDJ+k8k++kO2ixWHACXchSOLD4DNGH9b/o3OCjsbIhympF
         cREC+pL4ig+XNewJndmboFWF5aBE7VSQKejeAWY2TFu3/UHSJ8sUoBusCjtTbk/LbaAJ
         r1bMf+5IQL6leJ8HkB1JNLV66a81RT4I7CpaKpfyckrqlQ6iCHQZGFY/eMStpzAAyqTl
         DHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQDSv2OwEavGfPD7QFHW1wvt5oA5GKyg6BpElu5hA3g=;
        fh=FlffYyqYe4FRO7l3OC5G5+vYmwubCWrd/oktoy87lII=;
        b=aD15eQgBdLwLlhrgfe+8Fvp+Yw8wJL7cE4B8OD8Gz4Gn1OtH/8zjx62iqSKb/Sv9rG
         flyasU1UUiPmQVj4iKef+SdU1/XqI8jh1JzaL6OmLGW9xcMu3kjc3XEBBmiyyC3Qo3Na
         rarXg/RNs12bwODRV32fGgtUMFegEn55Wo4Xl4S1n4BhQIYsVwdq9G3V9c1hRiiBC60b
         I36/vECaMgVJKinfiIMl6RyfnnKhJGsMFCQnTG2UPWFVE2cA74jf+SXMAGoku6py+SGa
         4saELtwQLkS7OYlCp9yogRYSooKGlc6+bgTRD5cBhJhDLlfrWRJ2kXfZbvUimIwP7fCJ
         Rupg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784150618; x=1784755418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQDSv2OwEavGfPD7QFHW1wvt5oA5GKyg6BpElu5hA3g=;
        b=RGucMNhlRxq9+Xm91SMSYBhJMReVml/InGAe1hW3XgsT2g8Feza0hYDAMiKYEbKurL
         LqVtWJf2DfWZkfJ8p6psx8DsR6mkgbaGe/nV5ENXIFSmXRvMBM2zNKrK+Gj0Ya5J62XF
         fkXt3BSKYx6utnkh923dP+64gd5jXEKyv0aX6NQtQaMf2/dpAu1UirBvWHrP/QV32ReS
         XXDqo3QgSSEpa7jaEjBBYhfE/nxOO8fFZkklxCXwEbbQASheYdXzu2mAbAaE8O+fc5LL
         VHlxpc80tXWIS7uU/ItsXw3NdhmYZQG+uDxnV39VCXrsDDY77E0uoTO/WEh5hQHvSrA6
         A60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784150618; x=1784755418;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQDSv2OwEavGfPD7QFHW1wvt5oA5GKyg6BpElu5hA3g=;
        b=nvK2xn+IijarVGkVpEajhJ8od0fxdWDkE4LjogRZ8oh2L3B9Ni1/DBQEvqx8TEwyhI
         Kz4IZb+Kjax4eqL3TfMzeh+He+Ca6a6I4XGVKB1MJ2s5Wk/4wVmxkzD7Pg6KHrnzUOzS
         DF7jy/Mt/8mFSI/CTRGPb1oc0ESz72JmyZQKa5TIIHbf3bI9K/9/+7YKmU0eyqFjr5mw
         7FBfKSi5ejdH/KFgKR5GSn9RsQkInDaiIcVpIHgyLCKwCCqKDlO5uzF1XgJR9A500kAk
         9f0JqGlv5nRe1zSqZxstB2OfGBogQjKqxK7B/IKH0Pj/yoM4kd7DhtjjyhIuh2+GnXgV
         F7gw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7ePeK/Ub2pw25ES/1wmXkKXMCER0Vg0Ri62pE4hWyUBnRuJj62MeC6Vj27LSS4IJWZNKKk/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhW3YuoZFVV+Pg16tD7+UYrxey+9RgoqLmpVIt2voom+fxMRCF
	ulvnmbIFEnkefK2gQdwi0Iq+OdMwJkY19eXOHGzySYfBA6OPuxmd2ghTKaFWLAA0Mv+WNAchvju
	hjawZMA/VUsmH+pqlPBjzbsKfgkMv1+I=
X-Gm-Gg: AfdE7cknsgyHbWFyPS9ITOKScg6brR7dcz5FJHZBX0SJxEwSWMVt0Z3peuYGyr6C2up
	7jq6qeyi9YeqKLXxr39qFV4ezgbdS7IiJ0dA9IV8aoLYCGegJbJtMTLU/FFw27ruSRvQeRI3wR3
	ZsYNk7u3TzU6KZfJ13uo278grLTT5mq/SPOZiLHtwb84Kqij0mC3ywYbkomG4Sca9d3N0+LXRlu
	zyyoydRDrKPxk4JTVgr79fMndVGZ6vWGMm0Tr2eZFHSuY0NkFwuI5tULENSH4lG
X-Received: by 2002:a17:907:9622:b0:c12:da4a:97d5 with SMTP id
 a640c23a62f3a-c161f404f86mr992959166b.50.1784150617701; Wed, 15 Jul 2026
 14:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714191341.690906-1-coiaprant@gmail.com> <20260714191341.690906-8-coiaprant@gmail.com>
 <4823c1d9-51d9-45fa-a96c-f2caab1cb29e@bootlin.com> <CALj3r0h4cFd-tp9-UVxihL9-a1W7_4nvnKoXW_cP5WECKc66Hw@mail.gmail.com>
 <1d92078f-3009-43d1-a228-c3e67a1f4f4c@lunn.ch>
In-Reply-To: <1d92078f-3009-43d1-a228-c3e67a1f4f4c@lunn.ch>
From: Coia Prant <coiaprant@gmail.com>
Date: Thu, 16 Jul 2026 05:23:26 +0800
X-Gm-Features: AUfX_mxzLgLRVJ8_d4XQuIss8MuWS0O5h7pFciiDmngjjPthH3hDcKxQHuYBdj4
Message-ID: <CALj3r0gBnyEVwo3rK-dKssYN9F4nFn93QJ24FVv8YBLjNNgPmg@mail.gmail.com>
Subject: Re: [RFC PATCH 07/10] net: pcs: xpcs: add Rockchip RK3568 platform
 glue driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2026=E5=B9=B47=E6=9C=8816=E6=97=A5=E5=
=91=A8=E5=9B=9B 03:57=E5=86=99=E9=81=93=EF=BC=9A
>
> > This is intentional. The SerDes is attached to the XPCS node because
> > on RK3568, a single SerDes serves all four XPCS MII ports in QSGMII
> > mode.
>
> This is not the only device supporting QSGMII, and so the issues you
> are addressing should be common to many QSGMII implementations.
>
> Please take a step back. What would a generic solution look like?
>
> Can the reference counting be placed into the core somewhere? The
> common clock framework allows a clock to be enabled and disabled by
> multiple consumers, and the core clock code does the reference
> counting, only calling into the clock driver when state change is
> actually needed. Maybe the generic PHY core needs something similar?
>
>         Andrew

On Thu, Jul 16, 2026 at 03:57:22AM +0200, Andrew Lunn wrote:
> > This is intentional. The SerDes is attached to the XPCS node because
> > on RK3568, a single SerDes serves all four XPCS MII ports in QSGMII
> > mode.
>
> This is not the only device supporting QSGMII, and so the issues you
> are addressing should be common to many QSGMII implementations.
>
> Please take a step back. What would a generic solution look like?
>
> Can the reference counting be placed into the core somewhere? The
> common clock framework allows a clock to be enabled and disabled by
> multiple consumers, and the core clock code does the reference
> counting, only calling into the clock driver when state change is
> actually needed. Maybe the generic PHY core needs something similar?

Hi Andrew,

Thanks for the thoughtful question. Let me walk through the design
constraints on RK3568 and explain why I chose the current approach.

First, I want to emphasize that this is still RFC, so the binding is not
frozen. However, DT is ABI once merged, and changing it later is painful
and often requires maintaining compatibility with old bindings. So I
would like to be careful about the architecture we settle on.

The current design
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The dependency chain I chose is simple:

    stmmac (GMAC) -> pcs-handle -> XPCS node -> phys -> SerDes PHY

The XPCS driver is the single owner of both the SerDes PHY and the
power domain. The MAC driver doesn't need to know about them at all.

On RK3568, phy_power_on() is effectively a no-op for the Combo PHY in
SGMII mode; only phy_init() is required. So the PHY is not a
power-controlled resource =E2=80=94 it's just a one-time initialization.

Power domain management is handled via PM runtime:
    - XPCS probe: dev_pm_genpd_rpm_always_on() ensures PD_PIPE is powered
      (this allows us to use PM to manage csr_clk)
    - Each register access: pm_runtime_resume_and_get()/put() controls
      the CSR clock

This is the simplest model that works for SGMII/QSGMII today.

Why not move SerDes to stmmac?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
If we move SerDes and power domain control to the MAC driver, we
run into several problems:

1. Reference counting for phy_init()/phy_exit(): in QSGMII mode, four
   MACs would all call phy_init() on the same hardware. The generic PHY
   core does not currently provide reference counting for these calls.
   Adding it would be a larger change affecting all PHY users.

2. User misconfiguration: even with reference counting, if a user sets
   `phys =3D <&combphy2 PHY_TYPE_SGMII>` for GMAC0 and
   `phys =3D <&combphy2 PHY_TYPE_QSGMII>` for GMAC1, the same PHY would
   be initialized in two different modes.

3. The stmmac SerDes callbacks are legacy: the existing
   serdes_poweron/serdes_powerdown hooks are called from
   stmmac_legacy_serdes_power_on/down functions. They are marked as
   legacy and not intended for new hardware designs. Building new
   support on top of legacy APIs seems like the wrong direction.

Current QSGMII usage on RK3568
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
I searched OpenWrt, Armbian, ImmortalWrt, and GitHub for any actual
device using "rockchip,rk3568-xpcs" with QSGMII and found none. It seems
QSGMII on RK3568 is limited to specialized evaluation boards or niche
industrial applications. Even SGMII users are rare =E2=80=94 most boards us=
e
RGMII simply because the pins cannot be repurposed.

If QSGMII does become a real requirement in the future, the generic PHY
core could be extended with reference counting for phy_init()/phy_exit().
That would be a cleaner solution than pushing SerDes management into each
MAC driver, and would benefit all platforms with shared SerDes resources.

That said, I had an earlier test with serdes_poweron/serdes_powerdown
callbacks in stmmac, so if the community strongly prefers to move
SerDes control to dwmac-rk, I can do that in v2.

But my preference is to keep the current design: XPCS as the single
owner of the SerDes and power domain. It works today, keeps the DT
binding stable for future QSGMII, and avoids complexity.

Do you think the generic PHY core should grow reference counting for
phy_init()/phy_exit()? Or would you prefer to see a more generic
abstraction for shared SerDes resources?

Thanks,
Coia
