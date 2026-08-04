Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50238399C
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870838; cv=pass; b=N2NGYuarSaBksgsdyhtEFKVyVYEt6AeCuBzWamgr9brhk4GckwMZcHTuGY45h6E/jlsyOReUBk/KSgj8cFdEq1GJSgLKLdTinxZo57uKH2HSV5wRpDKwOgMuvtd091e0hVkbsykahOb7mcqW6NVDioBFUxl0CajwFJarxqughPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870838; c=relaxed/simple;
	bh=hd5zHk+yVobv7CaHMqAXD+PdEmceY9xI+QAzkPqKuMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXtcReKUzj9IKU/HEUq4+ba3Ol/mu+bmkbsWHqKKvgljQiwECn4do0iC5jHLOsXUjxf1idtARMslb+1I/mnVaa/aumeIBPWkrjWU/tv88HorlXQU9y0yOZa6QdCnPooS9YjvGfyxe9d3yPFeYpQmWMWjSKxPXIohv0Q5dfSeMn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZaHXhk1; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZaHXhk1"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-74ab99038afso65555137.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 12:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785870835; cv=none;
        d=google.com; s=arc-20260327;
        b=b2e8FaHWHYGz1qP1xm0lCUZxRSVQBdGq0RCYVuFEV+oxwTMZIAicgNF4zNu/Yv9c1k
         jJeCT0g20S9q91zGnBRFozLMzQqEl7ojhRjP90x1lcnftv7cqT0zNzMaPFtQZo/1/g/9
         VdVoL4NSEYPkOvkYD1XcJ6qemhD3FuZGxLM/Jv9HQvji6YCWWJbnWFYctuorjQYL2dIe
         nxNvby71/YrO+Snw0WNoa0MCBB0E0/6ARkk+qgNPMQRBjTX87JLSm+HV5Sh+rHKwg4/T
         rmVbmttNbWQ3M/GrGWP7ysCTNT43TEgR2JEBCmWZ928nPtkK1rpX8EeDdfHp62uSedSf
         Mjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oaumWihiToMR49sZEz9K8oHxfPmHFhmNoW5o+oLOoZU=;
        fh=dRg1/n81vVXuj4fxwqE7MPjKVpBABT0+bC/jMpb8fmQ=;
        b=mS/YbIJpNMRZLM6BCeSe1YQaghnyjNZpcmXXZ26HodQMzmmVfjWZuZLCEubMDCPBN+
         iSiS0xQK56DW2JTEHOD3MPtRbufvnYlWRFvYkZNMCDPjTiUtpo8dCiv2wFuJIGxvArd5
         y8zMG1GZxnOemXRiMhnxY3lubPy7jU69mu/XUn4b/v++FplrXMzHyVTmd12/F7zivJ57
         8CoHkCnDZtYymQjOrtKTpNoIkZXQ1uJOg9dbS1bh1dYe+BxMZoFcqLJjsfMDdJyoanFs
         IDkMvX906gcf2mE10pqLCQqk6zPEeacEUK0tVlKVWyXiBTHpQIqg5Kn1FQqh1wFVqN3t
         Rknw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785870835; x=1786475635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oaumWihiToMR49sZEz9K8oHxfPmHFhmNoW5o+oLOoZU=;
        b=gZaHXhk1ecA3LBsBU4XpfZaoD6PYPN3WZitU4NlEG65NG31lmuoyEZOrcoEArjeSPf
         80ItkRH0VtRD5LqaPiJ+cQxnk/oCRKs6AUR9ABolX69EASEjmrTBJKvbkrIIxmVtGBCU
         31Z9Xay8GGPQtxja4AuPsxQdUAsnrPbnmomVYl+Ez/pgysXUnbIhWaE0Ib33BSqHDKJX
         FWnb57qcre3/Do/CFb9uoNcX2qTmyyNKSmIo6PmmBM0acOXZY4bT6U4Ph2WXZiCjQAqF
         iYC5LUQzdQyDumJGLR6sjQl1R3somoV3mmkDnHizz5uYJhq8kcmiwok3mEoptbfh2Pdi
         lg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785870835; x=1786475635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oaumWihiToMR49sZEz9K8oHxfPmHFhmNoW5o+oLOoZU=;
        b=StPtcAKs3LrSdIjcsKtZ58tjJtt6J0aHMBodYwTjJMO9PRmKrDK+Ts5c2xVe5a/0kR
         9xiKi+tVOPP2eYiLexAWGU0+3Lx/YEWJviHVuRiksGnjwvXzp18srCiQvBhh3CwkCD0Q
         f978crUXLX+vWqKcvHr53lzp1fkkQxUkAgpPc3sy7/UqpjvsZBQxzEjihoiWfnBpoJny
         R12NtrKE9VsyImgnaOMiBtJxnPk+rFs/NKzI5hwRbHYIH385Muv85CgKwwVljjmxPJs/
         JqgvdHSl0GEjDya/hYwyb7Evo7wA5g4l70lTtGdiFThKSGdv1//wk7whZP7LmWhLemFZ
         pSSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqaSOmo3WhO5Whr7OOESkrW9KL2w0ws90n/Mqs1k31PYbe0mhL1ykMCpvSh/ts/9ijD7Ob6g/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwED6aYBSgAvJ69iwHlzLdpc05ZlSlc1bSz816u20hEMGJjIBCR
	oOV4wof6H6MEIFXZT6tydGy5rBxfJ6iS8bwm46hl90kY7O1ssP0NzRXPxdXDmjRrpnaBmkk+1bH
	LsfKhsEcD/EDMqRE1VFXGs5wYNvAOn6s=
X-Gm-Gg: AR+sD13IBRLZNBgJ/2Bd1YwsRdEv/Uspg4qUJhzMvsfqMPqC/B/l8jDp2KOCjYbGNNK
	NLZxF3SRqzQwiy+kYqtqt0V8HCarDjOhmSWfZa7AuWpaRwKUBjLxlUR9m8FQXEnVCukYhedmQ3N
	Hb5wZq0aymwjG0ru5Gi7J9ttDsftASYhDqgwiZp00ioG9hs9elbxn5YomxooOuN1V8v2QiZ6Jsl
	htBBWm5E6v+i6oy0mky+zlxkyHp1JgJHWWSZbRUnFMkmM8VmFQYbFz0XhzzcGU3HkefinSTm/XJ
	a0oy6gUAf58ngp7U8677YQiuEVVzVF8aXWqh2ni7PS47Ok/EhR/qbWAZreUNIo7ms9mRaiiCbzo
	Q/TBMQyytnB5FmzavP43WNz38k9OQ0p62ubRsFtChHper/Vj3wJ3nHVWs+uYXiCnWQLh08eHBzM
	tCKiMn8Xqg81rijwPb54nn07x/PCoADHtcH1ir
X-Received: by 2002:a05:6102:5045:b0:74d:ce64:efa9 with SMTP id
 ada2fe7eead31-760e9951613mr360293137.12.1785870835475; Tue, 04 Aug 2026
 12:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com>
 <c1c5ce0f-2c65-4c19-a525-cdd2ef33b6e4@lunn.ch> <CADvTj4o+B933k4TUshgcvZ4tENDbit3fHEBtwy5ODpsf60osyw@mail.gmail.com>
 <c6f001d6-b9db-4434-8468-4705d62ffdbb@lunn.ch> <CADvTj4rA5QaeccDvSP2qrseFKv+7MKhj=pRWdSnNzKKjMCdK6g@mail.gmail.com>
 <2536faa6-0888-47e1-be99-127e098929fa@lunn.ch>
In-Reply-To: <2536faa6-0888-47e1-be99-127e098929fa@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 4 Aug 2026 13:13:44 -0600
X-Gm-Features: AUfX_mw2lc5eE_Y0nOfCYqQraRgviIPcW4MPAnQ7Ers4snXhX7otKzMctiJHOnM
Message-ID: <CADvTj4riSs0n4W8UFDGFEdc=dqaDYdq90xQKwn-stuKaaqx+2w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] net: mdio: support dynamic OF device changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 12:57=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Aug 04, 2026 at 09:10:30AM -0600, James Hilliard wrote:
> > On Tue, Aug 4, 2026 at 6:54=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > > > If this was a hat on top of a SBC, with an EEPROM indicating what=
 the
> > > > > hat was, then maybe DT overlays would make sense. But from what y=
ou
> > > > > have said, this is a fixed PCB design, nothing hot/cold plugable.
> > > >
> > > > Some H616/H618 boards have the ethernet port on an expansion board:
> > > > http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/d=
etails/2W-expansion-board.html
> > >
> > > I don't see a list of pins which go across the connector. Does the
> > > MDIO bus go to the expansion board? Is the PHY on the expansion
> > > board. It all looks passive to me.
> >
> > Pins are listed under "24Pin expansion board interface pin description"=
:
> > https://orangepi.net/wp-content/uploads/2023/10/OrangePi_Zero2w_H618_Us=
er-Manual_v1.1.pdf
>
> So just the lines after the PHY, basically the UTP lines without the
> twist.
>
> So please stop wasting my time by making invalid points.

I'm confused how this is an invalid point.

Presumably one may want to use OF_DYNAMIC to dynamically
enable the PHY only when the expansion board is installed.

Whether or not the MDIO bus is wired to the expansion board or
physically integrated into the SoC doesn't seem like it would make
a difference in regards to whether or not one would want to dynamically
enable the PHY using OF_DYNAMIC as that decision would presumably
be made based on the actual configured hardware setup. If the PHY is
not physically connected to an ethernet port then presumably it should
remain disabled due to that being a non-functional hardware configuration.

Or am I missing something here?

>
>    Andrew
