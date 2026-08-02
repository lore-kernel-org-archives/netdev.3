Received: from mail-ed2-f10.google.com (mail-ed2-f10.google.com [74.125.228.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B261D8E01
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785640310; cv=pass; b=rF4aDN7JBUCQk/JBagRZw1RfVUucwmRbjShENqHxR5WdN9DAhPwWAD0i5UzqyIY2Tdw6kI43kjMF66QgW5vAcYWkHpOFZaGjiNlORt5v5saTkKkJjRCMlUcbauc0jhNUhiIQAtgq6y4/mjOA9evCbYDeryJA3cU8FczzxL4g5wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785640310; c=relaxed/simple;
	bh=h/qPNbFzuWh+d9q8xOJUsBHHg8cmlcEFMBu7sZocerM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vA8xOQFE2UWfyu5tlCowg8lVRFcjK6BLN/k2v9i48l/INdQTHuW1LLuyWaURsviis8jetBu9Gm1o8syQ/K1OHmtaQtfjiljxzHG3reD7Aa46/qC6kGW8BQ8cMATFq+ZOMwhB+j3UB4NXAPzqGnrUDny+FP/R8MDJJwwhEbw+0To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4TjMDOE; arc=pass smtp.client-ip=74.125.228.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4TjMDOE"
Received: by mail-ed2-f10.google.com with SMTP id 4fb4d7f45d1cf-6a0942e63b9so1301620a12.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 20:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785640307; cv=none;
        d=google.com; s=arc-20260327;
        b=JfXv5HPPG9VTPvHNXVHjisYSfynaBtAICdQoOvOhyRTAfyOpXnYEAkUbaqf0yPMjsl
         LnMaKF4CwDl2rhv5EtDTr6wlle2Jgstbjjdpf/e3qqV4xwNU5bnKUye86kfSWdgfSOku
         0ZCAmDiBmGZpftXpvaEXNLeF5ZqyJBdCKOFU1AGDrX7tSBLm8XuKlqiZgw9APoyX+15S
         3crDAcXN86VUyX9QMdMnEL77LEUGoaj1mXrKxtgwUksLMj2Bor9R4wos2zDo9PC/ESLY
         G5TtgeL/H5zrly2YK5koElmW0yUAG+ecyj0qXO4yPUZ8KeBgxxWgTk3CGLsgc/xZgvjz
         qOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c7i9JdeVJzDWpjjDEXDdnp2erjUKykrkBMYRh4KI/Og=;
        fh=S1ii4sqKEBYQoJYz6JygXVC4htxrRMDoataiz1F/FxY=;
        b=PyfRr9wiSWx6TfOTVPA9vgcoLDXqh4K9MCfLnbhMXD7rZ2JAPFErSD24lN1qPQ5X4+
         mMj7hGdBEmJvHioeFh5ZQuCM2XUzkAambdGONoa8Ls3lXnUC3UQ1Zo4dBxFsXDuM3AS4
         V1uwTLgs3su0gCaLetuPkQfNCCSgF33mh93Uk2AT8lh7QvisSig6zYyzwz+jrN68AtK2
         eC6RbJ1CEi27gPWp2KBpptcZF3PZpxXLLBbTu3rdvrEqEq6giUCyUxCKiWo0EGv6BPJi
         5/HsFC+eGBNys9HmhQTxnrcNyFuqAy0zcwDxRJ0TZ3TysFSdD3ra+hgKgVmyg9yMSVqg
         Hbbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785640307; x=1786245107; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7i9JdeVJzDWpjjDEXDdnp2erjUKykrkBMYRh4KI/Og=;
        b=O4TjMDOEmS6pyMPSkwks2y9sHNkqT63FDsWuHoFfYw39SG54OcTdFKI6F1mRZESwHi
         UWxUrw1LT9JeOil82KahPV5/nGhoONpK3XhzHBHSXcp+EtD3Hj0smaKEmW5Pq9DanEzY
         QVWNXGz3ncBjC1jPCr8AWMqDSxiPiaRtGJ+bwgkxAcIX9KsFJcvFFlPfn1HcgtiX2icI
         e8UoFZXzqew8Ijm3ftCqmfrK80K8ta0lE9YEUIUWQlYb2frOdZpieJUdbdJuUFRwStla
         SdSC6IhGa8dbTwWpQcSBzEytd/5ykOJWbMwZO3iyXrrtlZu3uT/xdfMgKoMEGpsQ7+EG
         K8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785640307; x=1786245107;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c7i9JdeVJzDWpjjDEXDdnp2erjUKykrkBMYRh4KI/Og=;
        b=hb+T0Fb6o7GLHvaTvneqlj50ZLVTSvPe5fKTQ1dcYo1gYYjk4Xu98KKTI5Elp/921K
         TDS7iuuFBeJ+ZMyoHh6KxPDGyaAJxDSt94ZQnK8zSLYQbNCR/Y4EP/APZqWZuQW9WTmX
         63aGLR8+fPjzA8m03r+rn4UaqxLQ++3kwjRdRlYOayPru4xVlzzhL2SF+IC3relqB7p6
         3m0hWZ7Bi95fddo5ZG/6So+Vr6GIJJQKDLKgrSv8O5G/onbyrhbHeyX8DLl0cQsWF4m5
         Qx8kO48xT75SZseuPI2vNdy7+aQqpiA6hYw5XzD/diM2uQq87JduQeHummW9zbT+io/N
         nYtQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDhdumDg6M2wsnJgxWKmwZl1HSEC/lFK4JkZ/x0nx4DMovGyKq5m036TvLHDikirKwOSHl458=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd8RXfGEjMaJ3wea+Ka/70aFwkhw+At5LMFyCavcMPrPHCmpYP
	UaPjnvnhJWLk0FgY2c+0uwn5DMXeJ2W04V0nbkWVHUTmNLMgYA05Cpz0Jb2F3H9A3nZ5qW7aCIn
	G8tmMo8WAUvEga9/wzDcB7b5L+pEPBKY=
X-Gm-Gg: AR+sD13hFheIkx+79I9kCjjN4+7EYChlaTnvXmzqFb5rdVEnsEQbYAxmsXWfGizi4dx
	eni5bJq1oaUtWLg0V8atr1hH3HZ+17z+j07RC77P3WiToPlzvU0aEYVTTpAV9U5oZPahP5+Dq18
	9qwjgfFkFnf56zsUwgMfm/t++1+ip/o3IzM1zDekF+8KwaM6zoCeedKCNdRtehb2+qGA89GEzCo
	9xfuczpaGkLz8zqWuWJyPAj/WPxLx6ONBY/PzlvcUF7Fd8p+lNm9ZUOVZH+VAlk8OFBJFzx95Ul
	H/F0wVxaRGrOpuDTXXpRrQAdCnGUB8vS/XPnCVugmw5H54I5Vx6Rt03vIPc=
X-Received: by 2002:a17:907:a0a:b0:c16:318:34e3 with SMTP id
 a640c23a62f3a-c1fe7ee16b4mr409057166b.16.1785640307171; Sat, 01 Aug 2026
 20:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801142244.679437-2-coiaprant@gmail.com> <20260801142244.679437-8-coiaprant@gmail.com>
 <cfddb747-11d0-476d-8402-e0886cca582e@lunn.ch>
In-Reply-To: <cfddb747-11d0-476d-8402-e0886cca582e@lunn.ch>
From: Coia Prant <coiaprant@gmail.com>
Date: Sun, 2 Aug 2026 11:11:40 +0800
X-Gm-Features: AUfX_mxry2V8YGgxr6fvsxNhCSaA_pBDCP69byM5eyulpGFZP2LcAYzvhwycRyM
Message-ID: <CALj3r0i1TCTgvm8FrJAJqmZgoJp61NCxc_xmVYaDFd-gh4H=7w@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] net: pcs: xpcs: add ANRESTART support for SGMII
 link recovery
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Shawn Lin <shawn.lin@rock-chips.com>, David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-renesas-soc@vger.kernel.org, Jiawen Wu <jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Thanks for the careful review.

> This probably needs more wide spread testing. I would be afraid that
> if you kick off an AN cycle, you loose the link until it completes?
> You would of noticed that on your hardware, but other hardware
> obviously behaves differently...

The trigger condition is: link is down AND an_complete is set. This means
auto-negotiation has already completed (or completed with failure), but
the link is still down. In this state, the hardware will not restart AN
on its own on RK3568, so the link stays dead forever. Kicking ANRESTART
here is the only way to recover.

For a working link (link up), state->an_complete may still be set, but
the function returns earlier at the "if (state->link)" check, so
ANRESTART is never triggered on an active link. This should not cause
unexpected link loss on any hardware.

Regarding testing:
- Jiawen Wu has tested this on Wangxun NICs and reported no regression
  (Tested-by tag included in the patch).
- On RK3568 (Photonicat board), this fixes the SGMII link recovery issue.

I agree that wider testing is beneficial, and I'm open to running more
tests on different platforms if needed. However, given the condition is
strictly limited to "link down + an_complete", the risk of disrupting an
already-working link is minimal.

Thanks,
Coia
