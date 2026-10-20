Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501500;
	b=eVHXb3fF60XDEzhbOSUIjGaJyjhcsoprMr2lPDAh9bICqqupLPyt6xpAYP5ysJgt9dqr
	 9TeZI7suce2cRJuKNPlZ8Qt2pgdVYhphypBHahq5yQPonbxPjRVbcZ5aa1rjOMuKrndzp
	 feE7Mq9ym4pBuai0a+B3TiHbl5X7jXHM7K5BOIkJ1c/fC5V9XzMvufQOhgwW5I76ByZaV
	 bANHyaXY5ZFsJj3oMPf20GGUCbqouFAzHkP/DGhWqJnNB0iUdkQtypNxCLmw9ixcihZy/
	 Jz2DWDol6RZNs80dOYCIjUkdxQdqah1YS46Z0AgCJ3sjGNhjjDgYVsz7MnwK8s5bvuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hk6NzAT4XMI8WeTQvuAnkf91i6pcghLbbrlCX9l0Rao=;
	b=TLHMkpsJyU1NbW+1gJYzTRLiWSzJjU/sNrZmKK0HQKTqykJvvUbJnfSVB+bK3X4wjOdo
	 cgt32REDcwKiJPyXNzP4NR0bAMt0xRyRj3ebSUaKW3PqRnte9kNaHU+TO2Y3EIkfemJaG
	 fjwa7sAnJ4rQWaqPcpTKy17RITxwdnyXKtaG1uSUFaDv+rpjRBGf32DFU4zblGpgyYJP2
	 eCatR4aNQ05/QPogdjaLckWeZmU6xPQrQerRgf/lo7l6zNRpLPx96Er6toYcEW41kirsX
	 EGd5SjqhowZw4L4A++jnWmvP/EzO2jbLveIQ5DmpzrZJfJ/5ks9KSy9rNiS8gxhlIuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sartura.hr;
	spf=pass smtp.mailfrom=sartura.hr;
	dkim=pass header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=xF5CgZtM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14E606A323
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D14E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=xF5CgZtM
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so401495a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792501500; cv=none;
        d=google.com; s=arc-20260327;
        b=PyD1/x+jYOYgTBDU/ExjVYky7/aKyjnd8i4SAtnEcmWfaUlAI1iPZEFEO2JxhwZVPJ
         qY+mieRXHI6HA0Cigr8b7dBtsjlcYfGdAdwRskrCxhCnUQCxfcT8UU8+Z1kXcbr3bogl
         WqJLdfKWosAKMj/xvDHDuMhL4+tz6M1HK6YukyljbjXR+LAExQFQrBawUz4VKWIIv3tM
         G0kmFYm6N8gk5G9+OKDKnbkm6rHttS5dGqUj42fOVheFXBYt8JhAj6+elOXGCIixgBfC
         t1QHvpoJP7VZVSfiK+hyiKQgvsRsDxpj5aoDyTwT9ik0ZYpAl0vzY/HCR5E3Z8vcDreR
         sEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hk6NzAT4XMI8WeTQvuAnkf91i6pcghLbbrlCX9l0Rao=;
        fh=ko58IUJwB29FQdzbMed93hmhUdozv51CjBhcd5pm6Dc=;
        b=DBvPu99qz27yFPL8j3GsczMysirKZygPIzAWTPMurKA3BO50BSGz78WYwjvvtynjuy
         SHkdlNcSc8ZTqtFHZMdFF4SmglYk8Hx4kdbUdS9mkgwsUUjImcrq/30fLAtX9+FDdmGM
         6fifQPNVNMT3AZ1h9vM3YWPqFtOC0iRt5wSdxMeXXKqMLaZtRzvZDhPSjeP7k5lbbAxM
         cojkYZJAYF+9c56YEdY0SPj0H7lYzC5oFXGE/S8tqExbHslY6Coxn790rtMzlYq4L1pa
         N06eIgoZHYCAjJc/BYbxB0bY+huXUmm+u26GLWTN1TiGyE0WJvgtFoMT/K/86T+NFju7
         olaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1792501500; x=1793106300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hk6NzAT4XMI8WeTQvuAnkf91i6pcghLbbrlCX9l0Rao=;
        b=xF5CgZtM7ONqwjEt3lKLm698g3fWzyCOm0n5BjWOqpvFhg9vNkeqnuqF1kivJaAQiy
         BbyR27Q730S9zFPzDslSY8IWdOMVWgB5gbNE1aCM8IM9vpicXZOIN22To2gj2yrA26ok
         XyYkWMCkD4kG0pvvs4zJ3HFT9BDce0RLo62efSCvM3QO4chKPLw+TBqPo1/d1lElw/sW
         My/YP9OBng9gTSZj2mCEpTILobrvnnWAhQ49Mss29w02AySVE6JQqkIDY4W520ozszEm
         km6QiWF1uP98FQcrFj6arFGUsrm6dYfRlgi6o4LQN3qb1qt4tRl+0vRnumG12yF65Y9I
         XS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501500; x=1793106300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hk6NzAT4XMI8WeTQvuAnkf91i6pcghLbbrlCX9l0Rao=;
        b=Cg1JWOFEzH8nCTAQIvV3Hb26uNMmmVq0LYYbUZGssFoJHYtruf+Jq1EVjB4wgT8UxP
         w1Y8j9bz7h0alpN8w64bidC5LZBw0xsPhb3fUFux7KsLkPQ6L/EjEcyAQtrfDQ+nvP0m
         Kk4mwMeX+v96e8bMaLzE+SmjAl5oSsJl3EFo58UMYLZejOXM0w4wBp/DmtxzhF9wY++n
         SZKOY7UtL7A07O1n/R5NnsludfpDsIXHeHG4DlR0khYgg6vhPth///q2ILpBQ6TxL6H5
         Nm88s69pxc+8KrF3TCIt2a242Nm9SFDrm0WVTi4yTqhfYKhx6ssAAGBSGxuaiBO9ymM+
         2zfw==
X-Forwarded-Encrypted: i=1; AKwUvBymoN4NC08abRXFMN4HbZpLSr5fz6a5bmOOT6iGV6FoPGPT81cPZkdMRpJYFxM7dSGRUhz9Pu4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWxqtL3A+6gj4MfYdFGn21n4vncMXUFGVwnpMp1mjL1dsc+9rk
	C2HGu5Vt9AhnuuyrKojvoPCMSG9awIhZ4rpvo1SfZMG0goYFH+YKKJOTl3w2Ty8kKzFzMiaoVAY
	FCET8mL7CFe/3DMYuYMp2/LMZg0gYPeXDANybCsXDqw==
X-Gm-Gg: AYBFou17mRf84V94aSodxPRI1+UTlloQ54iTfKf7BwLtCPqB8yhzDMv0/j5tmc4uPii
	DIcQZ/WgrXIEWYCPhVqO//uXkX09SxvGNLtLWKB2ryUQeV66mTKvBFtqvRAxI+XJon+bIFI8YUl
	UZviWFsWdl+rSvJtV1m1IzUCUmLl53moYHyQXhf40qFAmm7oCkQwEVtRbqwMQ/hRlSTqKkXgm0j
	8VgexYAYVogoaavLoFnJgUhNRg+IPXzvDWkqOgYrLw9hB/CYj9NWe6bTOzoNq6wGrl8J+SsF+FH
	uJnsDi8fRPkaGizkNjG6iXBzW77CyYm8bEzjg6uX1qg3W0DFxE2g8gDsIthxyl+T+ycC297agaL
	mzKK+fO2dcoY0e35iL1Cn7rxGoeOGi25Fng==
X-Received: by 2002:a17:90a:d50:b0:3ad:676b:28dc with SMTP id
 98e67ed59e1d1-3ad676b332fmr808023a91.14.1792501499592; Tue, 20 Oct 2026
 06:04:59 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020093655.344585-1-robert.marko@sartura.hr>
 <20261020093655.344585-3-robert.marko@sartura.hr> <21892f3a-8e0a-4c72-938c-b2e77b9f0dbf@lunn.ch>
In-Reply-To: <21892f3a-8e0a-4c72-938c-b2e77b9f0dbf@lunn.ch>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 20 Oct 2026 15:04:46 +0200
X-Gm-Features: AclHuK-2Vur9-XXFhf7sHu604ujSpE4RJ1TCAk85iRxwFehzOQjuEaxeKnqe0nU
Message-ID: <CA+HBbNGLc+imr9geBVSZthromLUCBTbC-4roVuz7SM2PdYPfuw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/5] net: phy: mxl-gpy: release MxL86211C
 Super Isolate
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, 
	michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lrosu@maxlinear.com, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 2:48=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 20, 2026 at 11:35:36AM +0200, Robert Marko wrote:
> > The MxL86211C can be strapped into Super Isolate mode, leaving the PHY
> > halted after reset until software releases it.
> >
> > Release Super Isolate before gpy_probe() reads the firmware version. Do=
 it
> > again in config_init, where optional VDDP setup is reapplied after each
> > hardware reset.
>
> This needs expanding a bit. All reset actions by the core should
> happen before probe. So why is releasing isolate in probe not
> sufficient?
>
> If the MDIO bus voltages are lost, what else is lost? Should
> phy_init_hw() be called again?

I think that Sashiko confused me, it claimed that PHY HW reset could
happen during interface up/down, etc, so these would be lost.

Is that correct?

Cause if PHY HW reset only happens before probe, then doing the
voltage and SI in .probe is fine.

Regards,
Robert

>
>         Andrew



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
