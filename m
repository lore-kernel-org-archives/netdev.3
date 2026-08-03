Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3942BC57
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780221; cv=pass; b=J8mnDfZZNkcru/HEf/LZoPmbtwHddfD0rF0ZzHvtYBYYfejoQl6dzvzQOOy3aazgBH93RYvLVooyu24aWMn63KYFnnZBUlsAsdLuiqFTKD3ZG6vPQrJ8D2fX6iw+DGHcmb5//YuPmCCjJJB6s6KmUpqZYa8nPNh//OCuX/tpqkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780221; c=relaxed/simple;
	bh=ACfuI3AX9kRQ1+CBBBf5za/2rVC3FsYXI8omco7jK4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/K16t8cykR6VXhIhckYQIrxiqNyvPvKjltdyYivEkp6gBcR9KqWtcCbpJ9b+22bFaEmEq338AtY+S5uzDq23Rt80U/x3TzOrrAGXhST6Et2Na3zLVrGpC0Eg33nzkM/zfFo+QEaL7Eh17u12B6Lq5di+jX1Duz79P+QsbzjGoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8rdjtCS; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8rdjtCS"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-976ea28c65fso2168894241.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785780218; cv=none;
        d=google.com; s=arc-20260327;
        b=iWdvdUEIbDfjEqn7SbY3Kd820gtnfMPeWidU6A5MOQLZejnpp0aMtDesx6YIPk5QEn
         BhODn+IuK5N8fBiuZqGCK2HntW/9vBi0SRhFC8tNVkfT9S9kD6QILJ+30SLy3iWc8T9M
         BoToU3MQNEPGGfqzyPqZgfhfHvF2v8lXICNC5ZJQwFcY57YCx6W0M+DaWzmGWsxXRg4B
         ttf9RX4rGRZofRBYsb4Spbogxr2BeaH1sLJb1toitl5sDaAFVJzZkFxSTBrfevpQYbqP
         TN//X8upUzb5QBV0FjhQaV4ski4KmBJdEc31PsE4P/4JiHsNLHxBCkeeirlJQxKLlW3F
         uOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2r8t0fZLO1G1B7jNQrzEMX2EdERqWbCFEmueS3AzIlQ=;
        fh=Lih2r8EBZhm7/QHF7R7esOqPcs/uLDke/HxUbplPfnI=;
        b=VSKMjCim7a0G9ysALHT/HIBYaxtu9164ZZq0/Ae0TWoX/iJs5GZQlNz4RtwjtJFPwy
         WJN0ehEB4G87vn18NPTO7nqAiRxyVmP34KZNwBJzzIQ+AWRgOfm9pkZI1zKHMc4HX+3z
         Vw6RXWYlSc+5QIyYkGwB+ZSOPqMVFJ1TmvOLnP1mk3FWl4mxuxZ+ECuQYS7XXpV3cFxa
         BLvCTf0g/k6YG5gAkPmDEoDhOrs72uTr3junOiRIWlf3krGMBfgeJ1/ilKvmzub1KPVd
         FsJRW4pTAmejLHIZxK9EA8qPE5FHVZNIqpgBNEgH3GALmH3h2aYIhrHdHfj8mEBgKmsg
         OUig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785780218; x=1786385018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2r8t0fZLO1G1B7jNQrzEMX2EdERqWbCFEmueS3AzIlQ=;
        b=X8rdjtCSlSv+4fH0zqn/t1oQJctljVdd6i+nB9p4sblbQltjHgzQk3we5TxCPwj7gt
         SbRoev7y85CkzLEVDfAIXCGPjsU2RWS/XhyVMFb0lVxlGI8XvhInr3mjgTeDhMYbmyOJ
         rGlofDzjTHTcYGkM3HYJTwDLk3zwe77ZgAxRu8B7hNr5JuJFGtsPd0q4w1k7QgGvFj0w
         EsENgbjrOZ2gjvYvTtwrJPogTH4eaGWBSUfrwx5fBR4BpJiyqN+EOb+0WCOWOnIraheg
         HPMPrD6E8gFLQvWaC9XtnUL8L4t6TDmtROlli3oKaz0byG4Y+XLHywFJsfAxxnmNDxLZ
         S9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785780218; x=1786385018;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2r8t0fZLO1G1B7jNQrzEMX2EdERqWbCFEmueS3AzIlQ=;
        b=g3e8aWkHBgw5u9q2TLkzPAAo4M8H/Nn80xWCBOBq98/w3QLRh8Ad8rYLLNwa3ezCw9
         CwVtRezuRPvpXFDTHecOxIEKZaA0EgIXJBO4fa8yCFfu7K8spLBvtsNBFpneIGLNb7xV
         cWBJ4hRGCjuBlu/ZZQTorQMLXQxlhmzhAZLvVcE8ES3LKUB5omGFuxfmBSoYn8+nkG2d
         ez3rp6eMyExHjGcvoTGR+8JpSzAbwQB5lcgPZYwJF1pzuavP9F14Z1INWpzYqopKczsV
         IZcZZD/P9nBlvosydezk+x0Jm5IJupJ2qtm3Pvq2uGpmreTKDX1J6oERMMdCvhDV6grX
         sXCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3E2AeeSHakG64o+xiF1rv0SU3TLN8k3Xap1xk4sjqMLEt2TqA/3l1ONA43Ah0eCYVtFWhnRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0kI+HwN1/omPbBylltVO4ryCVW0rum325u0IzEiQ5RdK2GPG
	ezCo4dwkVXgo2CO1NXDpeKHhbiPoYEM2EP00q5qPCIJTq77KQJZvX9JosNX6hEdQOqXYEoEoXPt
	zEqehGCVyjMUnu77c/STT/cz8vuzdOhg=
X-Gm-Gg: AR+sD13AT3SkURRKRj0rIc2VbsufZ7vOhrLIjKGtn2+KUcb57eivJF7zpSCArYt/1xF
	RODqtIeudH2UCFJp4OHHUDjA2ElAlVnK0/uY8un4ESdIFqo0n9xjSz/6FdlLYnR7MJv3nu3qo7t
	kA902AWo+k/5Io5hpnBc+qDoj2HoNiiQuGl5X2LcBZ+9rEwysLnY1E9npQuTvw7KW79cqnWyb4e
	+Bda5T+1Vt0ngwPUIS04iG8A0JYtOFMZYEhfmet9NUK2rMpb2bp80wGwyet7YFwStMxvrqEuHVR
	HEZM+p0NpRkf+0wAa371dn+qfTBaDREIOwnoaAyfZPb3XMtBsQXhcVZ3WBnng0Zz1B/rNbNovPo
	tA6BQL74MZep1d/+ALQU6aypmevfNrbYQGNh67YHQcVBhMeS32BxJyYwpi6+U64VOkRMFHCeJqo
	Ql/R94JpRMtgX7P08qh00vbydJPrHxPahsRnXxWcPHdMnIHcM9
X-Received: by 2002:a05:6102:6899:b0:726:8813:2085 with SMTP id
 ada2fe7eead31-75b23d6e2d3mr8230898137.13.1785780218392; Mon, 03 Aug 2026
 11:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-7-0a53cd9e21cc@gmail.com> <2979768f-4f83-4f28-ace3-826f4b4c6844@lunn.ch>
In-Reply-To: <2979768f-4f83-4f28-ace3-826f4b4c6844@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 3 Aug 2026 12:03:27 -0600
X-Gm-Features: AUfX_mybO2gp37G6C7TCuAPmk0gNUYqtWf9KEEokxzjK6lix8AMcIQeuj4MOO0w
Message-ID: <CADvTj4prV688JDR-QAuNd+jTVFyE9aicRaciqq0M6sB0V2GiXQ@mail.gmail.com>
Subject: Re: [PATCH 07/21] dt-bindings: net: x-powers: add AC200 EPHY control
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

On Mon, Aug 3, 2026 at 7:40=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +  phy-mode:
> > +    enum:
> > +      - mii
> > +      - rmii
>
> Despite the phy- bit, phy-mode is a MAC property, it defines the MII
> the MAC uses. I would not expect to see this anywhere else.
>
> The PHY driver is told what MII to use, phydev->interface, which takes
> the values PHY_INTERFACE_MODE_RMII, PHY_INTERFACE_MODE_MII etc.
>
> Please explain why you need this here, why is the MAC nodes phy-mode
> property not sufficient.

I have reworked this for v2. The phy-mode properties will be removed from
both control bindings and their DT nodes, leaving the MAC node as the sole
source of the interface mode. The PHY driver instead passes
phydev->interface to the selected control provider.

There is one ordering complication: the control block must be powered befor=
e
the Clause 22 PHY identification registers become accessible, which happens
before a MAC has attached. Early discovery therefore uses the hardware's
reset-default MII mode.

For v2, I split the provider interface into separate power_on() and
set_interface() operations. Once the MAC has supplied phydev->interface, th=
e
PHY reset path calls set_interface(). If the provider is already powered,
this changes only the RMII_SEL bit; the normal phylib soft reset then
completes the handoff. It does not repeat the full control-block power and
reset sequence.

>
>     Andrew
