Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA083423E9F
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 04:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785816185; cv=pass; b=W6G+vafxt+XHjF4Vkf7eSHgQ7smNqZHLbVV8/4/lMmewEKlqWJQffLAfX1rqGTWnoMtuePZwUzlt2R6PosekugRQ+nF+c+SgArbSJErIEYLh284GF9Je872AXReOoD00rhER0iaQ0EPMda4BcLDMBlcoKkwhLBrCALYr3g+y/lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785816185; c=relaxed/simple;
	bh=RkdB92KGZY7tyP0CuxNF3WyK0sWw7koVzFr0NNoR0sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioxSU/UrRAgil82uChaROQ8ZQ+SfbKCA2sCK98FETzS54TeUcOzFOvTUsPmujH200/l4ae7eh7oVAR+GBOK++c/PTRaUMckDlfRKEYdlQKay/3OvfQ3IpMob4l846REcTJDKCoklY12CtJICICSFLQnO/bCx1ihMe6nJEwaD5Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb6qbD/g; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb6qbD/g"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-754ac74c495so1283051137.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 21:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785816182; cv=none;
        d=google.com; s=arc-20260327;
        b=r/A5yNw5R7gVThkuohQla76g9YOc5b08rJcx9t7tBE5NDn5u+Ib2AZHyf9t4F1tSMY
         g3pa76TP6O9Ys3lXOlHTM2kDUmjKJ3ia1PyUeredB8OvOAcqwmYYLBc8Tfsa5F5tyriL
         +o+X79zFex2Kvnhr1RU4tPPsrDV25CePrQGo/zSYjzaYHJuHYsp1mnXRsyZyuEMETyx2
         ZZFrZ2JdAbniR7ruBcsR6sr/ink8VNmhk87lJplfAXvHqRF2WqNBODtvuPVo7q8chQgX
         uQKZ2vZu9oIE4NrEH+kEV6iEfLy2fTNRohgiMnlpfdIhLHF3xRP6XwtwZcKSdSs6EYTL
         1Jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vjyfvHU8F3NgL4NW8N8+pld5mLwJIrHHWmLLvG4oy4g=;
        fh=jVxORfdOhrK9zDTGUDGmIiE9xZNd/MltMi+L2CZrGRo=;
        b=ULdUe1ueXfbg9mIcLiV/qj5XjMsvXNMmNCH4sDyue2LmZjJ87NmF4mtZwbYrBe07Nk
         4j5o7+A9XkB6sMgVCOWHLYT4QqA67gwl8Kl5XcJY46FThMfQMgryvP+0YV2FMQyoeeeq
         lpEhKytAP97rcpv9LzOm3yLYDlQdOg8GIm1rGqsFc7w7oqPK+Ue+Wy9qHxiTjtBWIXW+
         TFT7KzVEcfrL8GiBGkspvWQzWjPVLSgi38KrvMQCNpg4cDNPpx5Lx5P3r1HB70tLAwtg
         NM0wMOeF3rboeO+2VbxA0nuOndzF/8Z51XfP9Ga4CrZVCrcIZT0KJdY5Mcl7t946JqV2
         /P/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785816182; x=1786420982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vjyfvHU8F3NgL4NW8N8+pld5mLwJIrHHWmLLvG4oy4g=;
        b=Xb6qbD/gZN1fxX/kenbFvB0Ro308w++AMJG9KrgkmFLQjh37LT+apr5yEExHxIQfWS
         vS7dDwtgO3zUGSHvORS1I6gjydYmv+iz1zk7MbRBhpS09tFAXLKYpseGge9ZFX546xXT
         ANSKOfFTHDPLRbfoEXbanXm+Yl3Wpf4ixD1ef/DN7ltNZwmXrkYemL25RjqhHPR7H1qx
         Jt7+ua2zvaE3FSA0iUFTfhitzmq7dKa7svLIqeTTLYCbNfjAuC+pjmV3uQ2HN3OUUJur
         E1FXlrSXn2dthwG5naVNzxW7+LOJ863Kjl54IVd7LByAwUPUyK1Cw2fXatINDcMM+Z8V
         +WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785816182; x=1786420982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjyfvHU8F3NgL4NW8N8+pld5mLwJIrHHWmLLvG4oy4g=;
        b=gEtmtQNx9gRWrVJ5COiWsDnsqatFkwO12iXPJH3WLkTSmWc8cTJ0mW20+u41S/XYC6
         qGq5yqOEdYhd5R1wbM+sej4XuaFohpalQyZM4wOZlW0ELCx5RkcHklBEUa0lf3w0p4Uj
         3jU3ZdDjJBBpbVOBf7Tok4Qy08RYOE72XWOMgyd4Z/XUpL88l3f0mJdgBtJhaDkop7iY
         ii62H8+q+idpUUbcOIRBxjRXsM8z16oAn7LnIhGS9+kPwqqATwS1EWdmrQI0s0GSI1qE
         zkt/QVenEsCj/0cN7iK2q2Gv92p+oeOR2/0jdVgx3sbKGz0KGwpRsdTIUyMUl6X/kJz7
         hFdw==
X-Forwarded-Encrypted: i=1; AHgh+RqH/olHah9TVJiz2R0sQW5IDyMSz/htsL2fETQXQpkYpM9cEJeyNWvni4YCvkuG5uzW44o28GU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eIi+fzYr0QkZYntAjpeTUQgoYq8A9jXaU6XEQ01dFt/wxTkA
	bPE1afy1H8rbSL5/YSHKkssnrqQu1HD4GU4oiWemT+yDf8787oQpcCftlYnzFk85ftrx7rBds9g
	VSD9wkYlFV1YemfEcY5vEL1zlsEm0MQI=
X-Gm-Gg: AR+sD13Jvm1tzry8tvUm2GTf27UXGGZCDneNmFPeLH/13zwVylHSRZKTDfMZbnlZhww
	TT2ikqwCVhI1DuanhZeICzkBy4MJjRlaqkXk1kkXnt0x5i7t+Z5lFMYMfTYkYBcTSDsB6uORhXR
	6ZYfLLoTxNBiAJ+xfbRvhF8SVIAZVt4mAyo7Cbjte1Kgmg2z4jFDDnNfkHgXTah4RkeU/pF1Xz5
	AQlHOYVnwMHH5Inx4/TKzplyyRHVen9xFbGPnenxIW+T3IDJ9ER8Q+t0Vi5WS8Q9RdsPs2LQnQU
	fyozbQO7Yy317pV4kuzTKFvf3ZBbEDLRqi1TIZkL1igUluV/nYuQ4be5xBiyz0Z56QkGAG/13NZ
	weyREykV1kFmMZVjhvHOClLgzqP+js4w3FddJwkfnLSTm3+3r1yAjRAZaCbfB2GSq2fXxvTr+BV
	IxU1k5kY4LJqx63xt1eds7hLrich6qWb1JjSos1FZZ3y9kjOr+
X-Received: by 2002:a05:6102:6899:b0:726:cd42:d023 with SMTP id
 ada2fe7eead31-75b2375d6eemr8045788137.11.1785816182410; Mon, 03 Aug 2026
 21:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com> <c1c5ce0f-2c65-4c19-a525-cdd2ef33b6e4@lunn.ch>
In-Reply-To: <c1c5ce0f-2c65-4c19-a525-cdd2ef33b6e4@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 3 Aug 2026 22:02:50 -0600
X-Gm-Features: AUfX_mzYnShoXS6dXEQ_Ip01VArc0qPkR2yK0Lso7PSkwQm8kgd7SY9mx0R0MLc
Message-ID: <CADvTj4o+B933k4TUshgcvZ4tENDbit3fHEBtwy5ODpsf60osyw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] net: mdio: support dynamic OF device changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 8:06=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 03, 2026 at 05:48:09PM -0600, James Hilliard wrote:
> > MDIO buses enumerate firmware children only when the bus is registered.=
 A
> > later devicetree overlay or status transition is ignored, unlike on I2C=
 and
> > SPI buses. Supporting live reconfiguration also means that population a=
nd
> > removal can race address scanning, PHY attachment and bus teardown.
> >
> > Patch 1 factors fixed-address child registration and legacy PHY scannin=
g
> > into helpers shared by initial and dynamic population.
> >
> > Patch 2 serializes MDIO device-map changes, reserves addresses while
> > registration is in progress, and coordinates scans, attachment, removal
> > and bus teardown. Dynamically removed devices remain pinned until bus
> > teardown, preserving the borrowed-pointer convention of
> > mdiobus_get_phy().
> >
> > Patch 3 adds the OF reconfiguration notifier. It supports fixed-address
> > PHYs and generic MDIO devices, scanned PHY addresses, and Ethernet PHY
> > packages. It also preflights overlay removal and rejects removal of
> > attached or in-flight PHYs before their firmware nodes can disappear.
>
> This is a lot of complexity which i think should be avoided by just
> getting the bootloader to put the correct nodes in DT.

This should all be generic OF_DYNAMIC support for MDIO, so the
changes shouldn't really be tied to a specific PHY driver in any case.

> If this was a hat on top of a SBC, with an EEPROM indicating what the
> hat was, then maybe DT overlays would make sense. But from what you
> have said, this is a fixed PCB design, nothing hot/cold plugable.

Some H616/H618 boards have the ethernet port on an expansion board:
http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/2=
W-expansion-board.html

>
>      Andrew
>
