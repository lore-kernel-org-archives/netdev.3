Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8047FB0F
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147438; cv=pass; b=RwcQKiOw/AEkLFQ46kHyN0XGi4ylim0f2hiSdD8SSXXl52aUgVnM85fJqK+UeZHlCt9tiffnmtZ4pvrAUDX80FeOEGB9wbNMPzrYxudgEz4x4lYiGoftLmrEfin5VgsE8w222wRkARp8pusVgnLhht3k4h3wKdcd2Egv5Zl9KW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147438; c=relaxed/simple;
	bh=l2DWYrMPEPkpCBeEGbcDPTrkRXyWOflPOtrsbcHJFDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfeBZSfRp4t1l3NQAW0UfAVwHq/bXpRKT70mYe3wSqVJ+L7OxTLq0nbq9u/MOumHPVm4F8uQtvlFEi0uvdp1sfe09GvcmmpEPXty2fOhJu106JQYoIVyJUeXOZqLYEy4OcQ1XIg/o4i9tPwJKvnI/wkwX6o5ezNPO7dNXlo48OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwSY2Q7t; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwSY2Q7t"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c112aaaf04so563671b6e.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 13:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791147436; cv=none;
        d=google.com; s=arc-20260327;
        b=gE4n+YOFoxp1Y8frvEZ2diH0hkKrDTrJrTLNehfX0V7/xblY7k3hYfpVy8NY5Wwb60
         A0hpAIzUAE8c1rn46YeAZQZNngUHfO1wq63rhR/2Iui8Ns973PX4oO/jykuKVxiUuVWP
         FwMY1oaniOzmGF19bjzP7EzF79DqlG84P4uYupZCsVlOgiBGayArqEXN88wev4evzQCx
         IP1E4Q8hWTcBSn6IhCP24KtD5yhuVffENNn34YBTU8YOkMIh8790ErxITpM/VN03Ltzk
         wXFC8oWWSu/l42Zi15T7ZIit9DORGlf1vQz57fQpNr6AuQH2IpZbPDZXcW/4nSEmJ1Zy
         kSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+gAZp/BShGctoAlT0g/webMwCwP75rSNvd4mdkXsmm0=;
        fh=Xskzwo5XZaFM/CJuJVhtDMxM6/OToS8n6tbCFGaK7Z4=;
        b=TWZ1YW7oTT98/GijLqwRrjbZiKNamKRCwjwEq+h5+XhoBFh0uE7Hy10dGsggryrU/e
         MsfVwJLvhJjzKm/8o7wJUButlI1BewrbLoylBDfdaUpr/xQXssG5CiF6tCXskCJRlV+x
         2CMoKIc3yPK941aQyg9kKe0n8Sc0c/EC2Svk9rP4V64G80FW40SamZAmUMExDGzhVCs2
         tuQM0NcVTrcd/NKyHs4MnhEUiBDLKkdaDWAX751oy+l5erGQTxAtF4GDhuu3bXryye6R
         6e13o1+xB7A4klbU8ga7Y/azt/ZI6dFj6fijtyYs1whwJhYlHJxVvLA1Z380kv1Xq7HO
         IFIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791147436; x=1791752236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gAZp/BShGctoAlT0g/webMwCwP75rSNvd4mdkXsmm0=;
        b=OwSY2Q7t/sSi5iPYIqUh98yNRWyIyoOWQLXQTSCdLZJh5WDAvnvmA5DLr0icwRuxe3
         xiX9j8I48Py1zP5pyb33kXcrV8h/a1c9FjKUErKombh4qmmRPODUHuGHlSS3za2Lvj2Q
         IChGacpuG54vi3GYWdNfjWXjjTpJjRcuhuc1yXh0EWk2dpEy1WHzh5SrhHPuOIGLpDUO
         8j1ifdtGekNQRIerjB20uf5DbdQxVUBREqOh8cDP9mCHa+0g4BTDewlwoEnGvo7vTncO
         pdHevkvPNDcGLBcdLuflzKaGefK3xPDufJ2+jsuaLVniqdMjQ3vGMc+uhQyvTmXNNfXl
         5pfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791147436; x=1791752236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gAZp/BShGctoAlT0g/webMwCwP75rSNvd4mdkXsmm0=;
        b=ZQLRgASQPVeVv6cgc3TL9mFufsQLz9ZH+HI3lcy2rV2LzupsGgSisfsKp6HfsyHLSx
         /UG0rkajMA8xdePlN+W4UtYjex2QZ7PpPz2IQW5Pk+Kasdh7d/Ambv66Fk0rsSVmJ9Sp
         Hu7Jhb7CzuN29ag91sYfInYV8iTzDh9zukyNxd1efGA647z596wVK5ZNc5DIshGRuF5f
         W4/LmGK4VReIwii2AZnnm2wblPGmLu47GUnvZJNcj/O2b4aAVq5kjPUCeqUxhwGbQHVj
         zSlyFWmJI0Yg12zZLw+S6KwM2WdMC7WDX1W9AjuRZ2y9xTySAC1VML0NVzjv9gujEMVj
         E6WQ==
X-Gm-Message-State: AFuF++kqE5eWlaLwCWl2VzJjObbLM3dOuODJAfH0wXGRsZByiHjuC2SY
	eSdqttk2N3BbK75oCY+K4YBIoRJXf2VA1l/4lV6H4N61/2tDOaOnA/RrCB2Fob3bQK3fSZEwD2n
	5p3dh92bUgMOzJN7az9NmquJT162+uQA=
X-Gm-Gg: AYBFou0eeYI/v2klOcDwI1x7AOGHTR0YKhHl7Gw+ph7rtlJt6PNdm9siuW9lKt1PNAf
	dOtR5E5UVv/kgaodPPRiIcoTl3ooSApY35NC8l9gQ+EnjUTsGGbOxQ6+JQ06ApuXpyOV3VP2Jv3
	qNHOaVKzbFeHw1KcNQcOpj8Cw8Iji0KyZ21qEgq4olUpA+IImVeoV7VnkljK1sHdrIyo0v/wcy+
	qikWpOGS0j/AS5cTJBnwl+Jhh3GwdivARwrBz6NC9ffOqBsY78rD9cXW5u0TUBJwKvUL/EWRozs
	t2bnELGSmYi0nGI+YYSMCe6no8oN3jwN4hE530IwTVB3SmHIY1DqdbB5rtavU+aySWYBI+Tm8in
	PajgWBzQ9pw==
X-Received: by 2002:a05:6808:14d3:b0:4cb:26a3:a0dc with SMTP id
 5614622812f47-4f529a0c087mr8651948b6e.20.1791147436337; Sun, 04 Oct 2026
 13:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004184246.1260426-1-mmyangfl@gmail.com> <8a9ec69b-0823-48b1-aac1-f40cb4713f23@lunn.ch>
In-Reply-To: <8a9ec69b-0823-48b1-aac1-f40cb4713f23@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Mon, 5 Oct 2026 04:56:40 +0800
X-Gm-Features: AclHuK-Gqsq1sWsTwqtU_9nAXJD_m0-GFmjnDbkG-2Q4w2Mrh_J-t9h4WYXOnMc
Message-ID: <CAAXyoMP_8Pa3XpTdTttTP2HgQOrVqT-_P-vK-M1qJNi79Ed6RQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: motorcomm: Add cable test support for
 internal YT861x PHYs
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Frank <Frank.Sae@motor-comm.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 4:17=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Oct 05, 2026 at 02:42:43AM +0800, David Yang wrote:
> > The YT921x switches integrate GbE PHYs of the YT861x family (PHY ID
> > 0x01e04281) on the switch-internal MDIO bus exposed by the yt921x DSA
> > driver. Without a specific driver they bind to the generic PHY driver
> > and lack the cable diagnostic facility. Add a driver entry for them
> > with cable test support.
>
> Since this does two different things, it should be two patches.
>
> Does the cable test code apply to other devices this driver drive?

I don't have other devices to test with.

> > @@ -18,7 +19,9 @@
> >  #define PHY_ID_YT8522                0x4f51e928
> >  #define PHY_ID_YT8531                0x4f51e91b
> >  #define PHY_ID_YT8531S               0x4f51e91a
> > +#define PHY_ID_INT861X               0x01e04281
>
> Is this the ID of the switch itself? It does not match the pattern.

It's live captured from the system. By the way the serdes PCS does
show something matching the pattern 0x4f51e899.

> >  #define PHY_ID_YT8821                0x4f51ea19
>
>         Andrew
