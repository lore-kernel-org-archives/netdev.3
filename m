Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD6468C3A
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857210; cv=pass; b=rlF2PR8n+gugpwak4PpkPMNHdu5QXJNv4o16UPnpL68AYftQPaEldW4E8MociM+/uRAP2xBJ9Qiefbf4rUFOd4CzXauhxSu5Qv+CxNqP0o/vkls3gJdeaUcbFhsQRv2nWILJLFHQeHiAaxRMlBFnG4hxAfFvGFt+LCG6ZkfH3xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857210; c=relaxed/simple;
	bh=XUmOi/B6laQ6eMCxOrhzePhtH6HxroybD30jr5qhuKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrnpRG14pQ+8Q8QhoGzWroz2ayZU1KobItp/pLNCzN2lgAgzrw+ANJFmjpqs/jRi4Jk9U9oZvqy1WyZk9sfo5+Uz9JG0QBLc6KVKNBRKpsnuaiGMBOEhzRSn7Z9U7r7Qm+7gKgzM33slJfEuOAnNueMTfp81AhyrOhXfp1YdGq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZFOvsbb; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZFOvsbb"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9693bbb962eso2795259241.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785857207; cv=none;
        d=google.com; s=arc-20260327;
        b=hh+2T9wu7tF85TpGQIy+E6TLYN2nnB/DgG9zC+mZKvxrX5LVHyZfz2uf9pjMbrRefa
         rkLzfjpPCn+x8IFZabQ2Vm/IIP598/9ly3k4J8QZVIjHvUAu25AyAQ+T/IL2XfapUBqp
         6LnKX88XFNyYWtSpU4f7T4Go20HdhMEpvtlaQilcIlNTaIOc7dXXoRlsIedHiLvNgDEY
         XWt0FmazYmwMs1h8i03oCkbwPugrF6/T+ODrvCvQfj+V8hIngMdybp1OPJj3sHH0fL0G
         DHgpSHuxZ4Gm4o5rSyOxG6qLOgStk3hcLZNW+Ch/h9WbR478NG6K2ZokbthBOd79mx3z
         YyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DIzf+HYojrQvIG1FuzM4Jdr3lr/d2D1NXMxs/JfDycE=;
        fh=A1iWtzZmrtUt9+UMcMlhzHVhssSo1PPt6nx9uNwFeO0=;
        b=KrBVfJT9mr33zjdCb8qZnPH6jET6zFxeZNTh36nDLomHfe8EHFBbEvWG9WHtnLzmxA
         SQT+fcvfOxR1MM/D4IB/kaT0RlXz82O2vb+EtvUM4VEvGPbu5zfv608wiHrrWuaDPd68
         Wkqf1q25cVSeUi8HJy+IJ7/2wvnM/3quS3nGupuLxtfPbczplro58Sv11j6W2gSwE+jP
         Ska5IZ9g8kWn4wiZ1YftCJTOENPp3zBjdI7sWWsxqdwjrkTZpByU5VnP27yBKJVS8RMX
         iDUB2/M3qfBvhwe1ZFwRYpNDUIYFdN5cFm3e38/bRk0PkZTIl//BCkdYmzsyJvZJzYhh
         DNYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785857207; x=1786462007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DIzf+HYojrQvIG1FuzM4Jdr3lr/d2D1NXMxs/JfDycE=;
        b=kZFOvsbbm0JHFd/9XJGRnuUrvMfAh4TpKYi56w5dQWmSWE0KVaii9T+vo7U52I/ryE
         x3m292Z1MP9KCMWHjVHWxpqSnzOYCgeEHw0zYqcKUYWGqLjKMjgFvtK9gitR7gu4q4lt
         gs/XK+lLB7dA07fq36vAP6RK8PvbnzqPZd/oex2A8IGw4zNap3Utnf1wQp1hVroSRWCj
         WLsZ8b8bMBIHKsa4RDIqcdFyXB0ypkemA8OKlBGZW4Q8nSGvxwdtOu4WNYbGKvxAxLhf
         vJhAhCCaVGLX3wBIh0aZuhM4JKdq0iOmMYDQT9S95rqFzUtzUbwRddTg11tLgvsla2Ln
         Wcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857207; x=1786462007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIzf+HYojrQvIG1FuzM4Jdr3lr/d2D1NXMxs/JfDycE=;
        b=nd0QrYb3+2qXFMQevDwqOWfLa2nX96axBKi7i5LL64m7z6kM/PfZG77p+alNLmbp5C
         tb0Zq74WLjh6M7c4RsxtPoeAUxr8TytGR79BusMM51XKnF56MgcrNPG6w6AB5Za9noFT
         FoJ+322uLTHWnqZ3AIOYcHDS92wFYOCC5Bx4fOrLHwjt7ydedI05npWWaDYJz1EriGin
         DRcS9Mruec30DO6Hv+VH2JZ2odjoXUwAZ+M9nihFNFoLKjdLCLVx28+4Rgul3FlY/B8E
         rpj8XfRspzWrdAO+CVPVONugXC4Zljm5/iYZ7/jivZS/NCIYsknAplpACwLe2ZiERj1I
         uTRA==
X-Forwarded-Encrypted: i=1; AHgh+RoqEujFXqoPc7ngc1kkqyRIckXQFe8GnqUfFvQJvKsMW2jkiaYZ8KaRFkSCJW8IXF1vDw0FrDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9K+9OA9DoqmLkYYVTQUlsLKzSpHfclMR78zJNeLIlbVq3Z5om
	C3Su9Bfp+ztLUnRaNNj9Kppw5HXRgc/0odV69KCqeiDIZIMTNm1Ye9pV7vWSFrmJf3BItmLZ8i7
	Ttm4dqdog6WI+IbQeeLrtKrcpUL5ENyQ=
X-Gm-Gg: AR+sD11bBolWfXBKLMmkQG0kqWq9cu+Kup0KPjvRtAFiHixsqtQk1W/xBe3Hh3TpsCA
	f4cD1vg5kFWdipqTGOuBxCmmpcNim7ZGD9ZKX4k5gEO7CDikSr1e8WCT80PEq7/iiPWlfwQiLOM
	snwwSBJ1aZ2VhJw/9OiAhVdNSbaDA5iYLuqNfOzq73CiAC2Q15QLzYhg1fw1NsgsdELl7zPPs1j
	gJXFdWeK644z4o9SvOhEEtGE3R45yD8lxl4yM6zjAzYXKH094miOgztOfU/elw0hbV/iRnWxD3B
	IgWBwDHrtUeS9uy60UzC5jkWwclDt7TpckWOzEgzTfl4vFSPOsuqGfaCqEMVojhPW6ypDo68zJ8
	icLFvOtlkmISJDgV/MVlrC9dYMYZY1ohBkXJsTMmLoeMCLPhgfxhEWq2r6HZI7OaV/VZUNTNWFe
	UsWjK6rXSKNNljgmHk6+tPzlsDd22sRUVAAMlF
X-Received: by 2002:a05:6102:5093:b0:740:2717:a1b2 with SMTP id
 ada2fe7eead31-75b21a600f9mr11149553137.1.1785857207439; Tue, 04 Aug 2026
 08:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-10-0a53cd9e21cc@gmail.com>
 <05b1e6a2-725e-4b8e-8629-249637bbcb81@lunn.ch> <CADvTj4o0JdjoO+FC4pO=qnjEQ8MRyzQdKp2Hxy9NsPU-gym5OQ@mail.gmail.com>
 <9b8be475-1fde-409c-a82e-be4b2e402650@lunn.ch> <CADvTj4pBovti19MXgQjFpxm=7aRm0sYQz9jxfo8bu3txH94THQ@mail.gmail.com>
 <a9ce53dd-0873-41c0-ad6a-fb42e6cc7aaa@lunn.ch> <CADvTj4qpHU3F0DrEmc0vFi+JiwTNERniiMHKo1LmBd8sg58wJA@mail.gmail.com>
 <205e9051-8e43-44bb-a4b5-4ec69a192fa3@lunn.ch>
In-Reply-To: <205e9051-8e43-44bb-a4b5-4ec69a192fa3@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 4 Aug 2026 09:26:35 -0600
X-Gm-Features: AUfX_mxUgphmHVN2nVqeDHtOoQ4DhYlfN2EUsZlGA6OuEq-kXlUnQLFlQtbWoRc
Message-ID: <CADvTj4qmXWbDsc-vigcSrF1N=zpxmZWGp3YaZ9PFcWK551h3mg@mail.gmail.com>
Subject: Re: [PATCH 10/21] net: phy: add X-Powers AC200 EPHY control driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>, 
	Richard Genoud <richard.genoud@bootlin.com>, Maxime Ripard <mripard@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mfd@lists.linux.dev, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 8:54=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I agree that the link PHY cannot be identified by reading its
> > registers before the package control sequence has run. I do not agree
> > that this means an arbitrary ID should be placed in DT, though.
>
> The ability to put the ID in DT is there for two reasons:
>
> 1) You cannot enumerate the PHY because of missing clocks etc.
> 2) The vendor messed up, and did not put a valid ID in registers 2 and 3.
>
> 2 does not happen very often, but this is one example. They are
> different PHYs, they need different driver code, when you consider the
> PHY as a whole.
>
> I also wound not put in an arbitrary ID, pick an unused ID in the
> vendors range.

The value currently used in DT is not arbitrary: 0x00441400 is exactly
what both link-side Clause 22 endpoints report from registers 2 and 3
after the corresponding package control sequence has run. This is case
(1), rather than case (2): the ID cannot initially be read because the
EPHY has not yet been clocked, configured and released from reset.

The reported ID does not distinguish the two packages, but replacing it
with a synthetic unused ID would make an ethernet-phy-idAAAA.BBBB
compatible disagree with the value actually reported by registers 2 and
3. If separate AC200 and AC300 PHY driver entries are needed to identify
the complete package variants, they can use package-specific match data
while sharing the common link-PHY implementation.

>
> > Both AC200 and AC300 expose the same link-side PHY ID and register
> > layout.
>
> No they don't. There are extra registers in different address domains.

The block diagrams make the distinction clearer. Both diagrams depict
an EPHY block with the same internal organization: MII/RMII, auto
negotiation, auto-MDIX, 10/100 TX and RX PCS/PMA blocks, LED logic,
clock/reset, PLL and EPHY AFE.

What differs is the surrounding top-level control path. In AC200,
E_MDC/E_MDIO connect directly to the EPHY, while the package control
logic and registers are reached separately through RSB/TWI. In AC300,
the external MDC/MDIO pins first enter a top-level MDIO slave and
register block, which then provides internal MDC/MDIO connections to
the EPHY. That top-level block also contains the AC300-specific reset,
clock, I/O and eFuse controls.

Therefore, I agree that saying the complete register layouts are the
same was too broad. The packages have different top-level control
registers in different address domains, but the diagrams indicate that
they contain the same link-facing EPHY implementation. That maps
naturally to shared link-PHY code with separate AC200 and AC300 control
backends, rather than two copies of the common EPHY implementation.

>
>         Andrew
