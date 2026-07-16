Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4465372B5E
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221291; cv=pass; b=YZlrzBRoSauDdTI2uGwhUMxtYErjef3LVw08WCkq7Xt66k/YaSfkd+/PVJzsfaFY0f2ic3BpVD5wVBeqUkp2QG2EUVCF06gAbiVLIjZvsluxwztOkCB42MIKe7rnnAQmY0N+wshCFLXBvxENrF4YQCTenZhtM9ZOVP02fJOPbOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221291; c=relaxed/simple;
	bh=4h0sRg3GsMnzMqv1J/fmmCFy78xb8pm2m0ZoBq9L4Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJHN6TEDk81Bej+q2mQSV4hg9yZmapWf9+yWsgSOSCeuZkohOEe+l4uc+M9hp9QS3SNKG6KBNgNfDP4tuYFZdBEY9jYUA8d8iXcbRGYWIN2y7jVg0F15fqZYkTLZatECFeDLcSHKhMPTywH443fL/6lIgmUb0TLc3EUGkaBpCO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk/bbkGJ; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk/bbkGJ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698bf7a1a2dso9824742a12.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784221288; cv=none;
        d=google.com; s=arc-20260327;
        b=lM9bfuQKnZvj5fQsa6hKc0+DJngcHzsx5/j8HpnfScRPUkIeHU2hdFdZ+2yVeU4Iuz
         N/PoxoigbVRZ1MgoKxpbHSrVLnmrwspkv+6ks+jFqmGBHicutk6EbmHg5ckDdgc8RqxM
         JDSyx0fezm++JIs3Li6zqTL5BzFiIR9sQEgAWrWZI1SGbzPySpPQrra4xFXttp8X13j2
         DWY33v+5xA4QvCQFaGlttBdyjMmyPvE8FshhgFQ62dJlOF9/coaybRfSvIWQ4mJZ78J+
         8XWZoL9FPimxpCjuW0fwXreQWdGhEcsTFQW8n/LK5CfBbNhQ8Wr9GP8Yl3igFutDMymB
         uZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XS0UmqIKYMykgWaY9+AHkSpVUpr/nsVzh5HTFZmlsow=;
        fh=Ap1nB4ERxqz9XMUFMQVUiQYsMiXbMC3PYYlS6+Wx/iI=;
        b=C2AlABqTdS7q6TFhw46+qXXsyGdRmoDmAILL+HU0BA8SEsRk0LgqmVM3jzT6EVmtBq
         +nUOjUbWH9ZbpBYlzilPQPzuulB0PRfiGYHzTK8gFMdnWvlljsqu79P91CL6/ZQ6/qDc
         ezjmP+6JYkgTNaj1ksob4Q7IAMT8L3YF/bbKoq/ViBz/PV0vgMwldrx1Ekk8r4IjEu2e
         WTBTc0q3jBzWJoHWb2/DzaU+kBqOP9yYq3guNF/dSMA9CPpEu5ve9sNojDitBO05QEDH
         LZ/bNtnuFcx/ZZ0jSBgMszjWArqLqQt0ME//D4GTNffONebl1rNSwxnlefiNVDzVgbif
         nKuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784221288; x=1784826088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XS0UmqIKYMykgWaY9+AHkSpVUpr/nsVzh5HTFZmlsow=;
        b=Xk/bbkGJmzzMOigf7P3WZMLA32hYjpjw5tjobpm3vywdRDEFyQOEiMw2KwUKOzbIt3
         f/KrPqoKOzCjUe8mvhD+ri6JRBafN+rPxAbZSRp0gk0sDJWycd2zNufoT6A1aHSPSey7
         bfn1Y/0MY6ZCUlc5OpCBo3NKVGCbsOoGe18SyBDEUg+NS/7BLOKLwHAgQT4Y49L6zgN3
         XbHV4b0t/E/5xAfd/1T1ee8Fj0ignQEtSLcB1VdHbClOKepOdqAj4cSfsOr0U1suqEtn
         oVe3Kr6tn1hV+7vruZYdF8w6/clPkQ+X1j3KI9PEYkU5brEidpL2Wvah4l/CmfIZInf8
         zlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784221288; x=1784826088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XS0UmqIKYMykgWaY9+AHkSpVUpr/nsVzh5HTFZmlsow=;
        b=kP4TQsQJOHekePpU407Px22dTmbQKKmsSChW499gzmh5zy6nljmymDvqrzBaQ+0T7X
         oPv95mOL3JHCwwchdE+pr9gyFDbgLS9RUeoDuam4q7trW+Y4puHCEugRA2yqeSdQRuSk
         T+lrxPQ4XgPiqofYlml8bCLuaT9cK25y3atan+DrFnZN/jXDK+9iXY+qlhyRaZ822KQ6
         Qp9oi9Ja4NwaoK3PpPzNw03ojkcbmyGBD5r+BJgm4+b+AgblZ+tRzM30JhYOZYtsC//1
         bHRWn6+xAXmXkbmavCPUsAsd1t53N52qWD3jsmpoPDMB9f6GMrKF7TooDAK1/LGXpFD9
         z1IA==
X-Gm-Message-State: AOJu0YwrVP0pitu+BiUBkD6GmvdYtq4ErJDoDwRZkO8HFJhSfUhVp5TX
	RrAe5Et4bv2D0Ni9um5GdICcHkk/nke52JZXBmuWzq3BQ8e0n6xozUa/l0IwEgKc+eE5EGap4HD
	dNZVZVfy22gZjESeCucMlKyFfSvszakk=
X-Gm-Gg: AfdE7cle8Vi1TgkNpQvSpIDWWfMhsDtJ97lO0fkevAP8ODUdmNWERb/IjFaOYAXtJ6g
	Q0cC2gkRJZzpWvni9R0tqnF49ZKC1moq0zTJY0P9yfKuyIg18gA8Y+DBNZ6zObLDD2n0s2PFH/g
	vmMixXGmVfHV5N35jptp/i3UOhrbFt5ULl2rCnzkwYchb6ETcFzJe9MEUkGt78+WKTvrnYGGkWy
	uq9sKSEtRvmW6dzQzGNq5CaVPNjFxvZlHeYQ7/nbxY8fpyenKcyRH1Dvz2zETk=
X-Received: by 2002:a05:6402:234c:b0:698:1973:1da9 with SMTP id
 4fb4d7f45d1cf-69e199c4036mr5003292a12.19.1784221287783; Thu, 16 Jul 2026
 10:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716113805.593215-1-a.shimko.dev@gmail.com>
 <20260716113805.593215-3-a.shimko.dev@gmail.com> <f3be1229-1d46-4cb3-a83f-0715d6789651@lunn.ch>
In-Reply-To: <f3be1229-1d46-4cb3-a83f-0715d6789651@lunn.ch>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Thu, 16 Jul 2026 20:01:14 +0300
X-Gm-Features: AUfX_mw8ClbUaZoBn4r4Iv1iQaSKbKk79pCbvsv0ZhuCJcFgz03_1qcx4Pm6zN8
Message-ID: <CAOPX74651bEHyHQaKmjFheG8_sfbuD7PUagkAOQfYKYBXaEqgw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: phy: add DAPU Telecom DAP8210R(I)
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

On Thu, Jul 16, 2026 at 4:55=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     /* Wait for reset self-clear */
> > +     do {
> > +             fsleep(20);
> > +             ret =3D dap8211r_read_ext(phydev, DAP8211R_PHY_CON);
> > +             if (ret < 0)
> > +                     return ret;
> > +     } while (!(ret & DAP8211R_PHY_SW_RST) && --retries);
>
> This does not have the usual problem, but it is still better to use
> something from iopoll.h.
Thank you! I will replace the manual loop with read_poll_timeout() in v3.
--
Best Regards,
Artem
