Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9ED3815FB
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979721; cv=pass; b=HI0lM1TCedPxvPx6lDepIBz5p13S220zyQjE8tBG0doQt98mjBlSeCjgNTQyUL0muGXOx0Tb4yfh+cKlWTtaP6HqF8htXyIz1cxPRiB1RsQKd8XPqOeugvSM5WQHa4ZSzcSieKae0chS4UP6QK+en+iHtiSDS15SUrGMsaUvmiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979721; c=relaxed/simple;
	bh=yo8evkMojxMVckjP1gDBAO39OsFlfMPJ9XhfjhA5mDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLrGf1LVJ8iJ+i+zrPJ26RO0g5CT/N0TDiZLoF+VNnBrCqWl0IHSqH8UoONz9Tu9Jw/Jh7vHM/NAERkr0YdVm8YlRah8UcXIVsljnGZPzxCpRibAsiiOWbBzVbDRePAVDgW3cAOnXWmbnvrQqO8o9U3x1EREbAA7RIUyAP98EHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6w6y0P4; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6w6y0P4"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-97723f98735so1053266241.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785979719; cv=none;
        d=google.com; s=arc-20260327;
        b=GUkogIwlVHwj+hgEuEq39rGOD0MUJuYRKU9LzmLH4b1XfgCj2wIuYC6PQjVHSmApiR
         ossfvED/bARkyfhn5FTuVhbcXKmmEoO33ICxBGg1Lv07kzBBma4LYIHQFjXk57JKZSaR
         cdfzw/GtSy3V0ul3lNOH4TpgjAjrolM2KF7TZOo1zAYZG/5rqHwbN6+gCOqCbbhHdSpL
         59H4Wk0KDSeueBzA7lVc3TGXdf0w5ZiHyOkAR6r5FxpfNKWZ7/hsBg3PBKi1hT72eqjY
         msg6ZuUMo5cG2K0iH6F/E+h0NXVi8XcVikUxVtXCM0Tkx/tE+iy+Mj9mJLzAwwzuxAPm
         7aGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=edLN34k9foZMVhZcUUtF6FHiGZ8AVNOJWI7MIXQI8QA=;
        fh=ydCp1JNLN3MVJMWKERWjXcV1bteIHtugbpCKNqTEWDQ=;
        b=k/7pOmsZaPRnl5EbJ4q5t2t8lsRVKC47D0w2x7atgZRICc1rGwQTZjGjtyiJRsk1T+
         hAMK2IRGn+BtLDGtNcXG7kjwVvIhPWk54P08KPtg8OoA4YvXW2A83Rn8ikXZANDnIitg
         3kKKMNKi/mqGF6Ohr9dNGHCqEua5DTMJjCro6NpTEn8KmY1CMNjCH+fjegnUdJd0VA7S
         fOserkaC7B2R1Dwt6h+hcbJkTyblCeMzZKi0HLneEee2uaXU9BL+BECkwuFvI46s7hBv
         oJgh6fam3w1Zt/yELwrNG4eNO5K4mWxP40WbpOZEap53zxfQWHrBc955/84sDquLkzIo
         ZPFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785979719; x=1786584519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=edLN34k9foZMVhZcUUtF6FHiGZ8AVNOJWI7MIXQI8QA=;
        b=V6w6y0P4hhlnODGlqL1PZdS7WJRrft3CAqqNpW+ygV1nUltbuMwjweEjzSmHw7hzFT
         CzbKiaO0J9jQ+cJt54buCxPooaNoF05oGA5/cXkOz45+dM4qm4aLqp7kluBMMEoqnvU8
         k2H48FkP6ogjHn5mBrpFNU4b4KxwWeE7vbuvU9yVMPlrqoIByOceCz9e5ZDk3T+nA+/O
         5v3M6z+oyFo9wRgxFra0qYi6d3ZY8b75YO1ap9I9vyzzBES8PpPsPx6xSgm52CdmMMRp
         R6wCmwKMNXxhSnI8DJSOMw+sOu6EF0Xxt7q9g7EIpas8B+ouBBFFtbDNYh79PCPqHes5
         wcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785979719; x=1786584519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=edLN34k9foZMVhZcUUtF6FHiGZ8AVNOJWI7MIXQI8QA=;
        b=TKTnzSdnGnCEi0fn0M0DKINnYudMdbb0/h91nKXp0gJvy+eqVymjXczwjtA0naQp3s
         hZukwR0I2crufvxXZfatDx1h8D3/GWYNPA5amx82HXiteCh3GOZxlF7c0K2xqpjP7/hh
         Ux0mi4INJeNBg7z3zWGvrg3B4sXJH9ydhZhAibjzgmAIzqqcNxah1TzLf6hieol2OBzI
         2JydH2jbK2ifs4p3Rumf8YMNxwRJ7yz5KljzDDyL+qNm71eOPwZrGf7lb6ZW6ej8DHVv
         gIapN322QabGmpy00Hax6RWB81ZHYD5a732t7xEsYblHVPJkutU/a9mNhBBSCIdjnmfB
         1lhw==
X-Forwarded-Encrypted: i=1; AHgh+RobsoHahMpR1S0j2wjqyuvcf4oA+8jcV2A1Wp3ymk4qj+SyhPQ+MMoQ6/bdXayotnptWkRXd54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzeICgPV0xZ/fYXWebkEb28BtVgS/ASYWti9pjvR9PiI28mbZQ
	W8sXuVGU9J1mFUZCPu5vbXfAwL07z0zAIZC8pZQSMmCXa2cvBdbTTpatHWlM43ARq1iKOOhONMS
	ePM7EZuZ+WnQmxFO/ucc/DKVPV35meNkQwTvk
X-Gm-Gg: AR+sD11vNi3XWuAXlvb4zqBLor1GT9VvnVqCcZOhuq+IfERpTacRpR4H2n6sD4VPM/8
	Y6dEvZuvfFU1ZcCMoaL8nhAT2UsV6gYB6TRUCVahv6SswGCnAfL7vzULZg6cgLa7IFMn8Wwq466
	Lp3Aap8wS6NMnjsAEmMBhbYiuLVZjvQCLx8OVOJ4+idHMr0Iqq4Tjg+1zsoYF4esUqIYZLsJsIr
	KcgKg4cMSOeWB35xXmWfzQIDReIW3s9/OPuHHSB7Yl5WJmhgMKxMqjVOP5rrTXWDWoOAL9JFrr7
	v4BOmWoqsHkQWgbY4z0/7fqDU9m4uj+VArQ3hX/GTJMbehty2XCge5VM/UX2fYGhnQupqAcKAZO
	OeKCJjVMOqcghMh13C8jgxtHqc0mbsfeXaTUKyZc0t0FRfbfjRrMaBsO5L6UVZvSqP44zteXqme
	NYQMTdDsRsjLXQLd6pxAi1izKeNIvJbNK/fB1TJE00aWGoF+4=
X-Received: by 2002:a05:6102:5689:b0:739:4fa1:50aa with SMTP id
 ada2fe7eead31-760e8f3596emr3241387137.14.1785979718818; Wed, 05 Aug 2026
 18:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
 <20260804-submit-acx00-of-dynamic-v1-v2-8-3eef49ff1d8c@gmail.com> <30bab755-3356-4d4a-a939-8488aa487874@lunn.ch>
In-Reply-To: <30bab755-3356-4d4a-a939-8488aa487874@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 5 Aug 2026 19:28:27 -0600
X-Gm-Features: AUfX_mwRHCzyF7gAfwi_ObKJnDFQfjNsCJSXem_hxMypqW9gycQbdES8PR3dd9k
Message-ID: <CADvTj4r5y7ME1jb1OxnvjXoQRhpnQq1L=QgdUE7ESNgS2jzTBA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 8/8] net: phy: add X-Powers AC200/AC300 EPHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:38=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int acx00_ephy_disable_eee(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +
> > +     ret =3D phy_modify_paged(phydev, ACX00_PAGE_1,
> > +                            ACX00_PAGE1_INTELLIGENT_EEE_CONTROL_REG,
> > +                            ACX00_PAGE1_INTELLIGENT_EEE_ENABLE, 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
> > +                               MDIO_EEE_100TX);
> > +}
>
>
> > +
> > +     /* Set the hardware default before phylib reads its EEE advertise=
ment. */
> > +     ret =3D acx00_ephy_disable_eee(phydev);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret,
> > +                                  "failed to disable EEE\n");
>
> If the PHY is capable of doing MAC based EEE, that should be the
> default.

AFAIU it's only capable of PHY based EEE

> Why clear MDIO_AN_EEE_ADV? This does not stop the user from
> re-enabling EEE for this link mode. phy_disable_eee_mode().

I think I was doing this since I was trying to align the driver defaults
with the vendor driver defaults which disable EEE entirely.

>
>         Andrew
