Received: from mail-ej2-f5.google.com (mail-ej2-f5.google.com [74.125.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31977550DC9
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083600; cv=pass; b=icExT/GMZJhR5R1B2tw25fSGjSRSZ2HVFwHn59vs450cTqOamxh+osrLEAIxbxpEHogcBoAIYh4NblaD0pUl2MZNb32Rt6lZLmoDJW+4nA0d7B5MD1m0n+S+n1LJpqdQhw0PHC6K/5I4k7WZVQ9OiyLKg9FwLXcSKUtG4bJ3BqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083600; c=relaxed/simple;
	bh=ofxcWs5wvUKXDp1OvqNuIaoTkk52/+tItoWNT6uQhGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/YLQ0fyx5U7RxJpSTRdH98qrgX/gAMbSY0eK5GAhHUUxFh6/6Etc2pcY+3W9zy4KZApRV844W7K8n0IrFCFtA4I3kvLaxLqF57FQB3TTS2eqlrwvflfGn58Vcd7I7E6yp++MavrdYt+X3av8N/+7Cf4Ej6v0bFw9/Uih1uKQOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7QG8UfG; arc=pass smtp.client-ip=74.125.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7QG8UfG"
Received: by mail-ej2-f5.google.com with SMTP id a640c23a62f3a-c2950c25486so346238466b.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790083596; cv=none;
        d=google.com; s=arc-20260327;
        b=eOQ6a0XBnaQIuPh73yEtB0qMrSTA4DBhm063pANP6OUSU6cbRIFfVbaYqsIiR5P1WB
         xZnqbg/28732E9IhvuUULWQ5UHwNrUEeKH7/tEv4f6Q3TYQuIxUnUq9vspFv1CfZkwc2
         rpd4JlI5Mhf2BbFAbQIEF+OeQ55OJxmTWq4clawtfkOKhmpiyUea8BgY71WRcoY7Btdh
         v6FApoQX6OQbrIOpHr+/r/nID9SP0/k9AdsOR15Iq3E7UcYTqH+j6AuOzDvt/Z3IckFG
         ZgbOilWTGstySlb0bjBGM2SWTxMASa5jYzkgS2eQsIS+DMQ8xhB6+9mu5P2TcY9+FBv1
         sxpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ofxcWs5wvUKXDp1OvqNuIaoTkk52/+tItoWNT6uQhGU=;
        fh=hB1JFR12QGECH0oBpP4cQGIehjQuumDN0gZZs2ugCQc=;
        b=nP4Gb4DOUILlWv/YYdL42HzSCvRtS47R9OuxZMP0BsWGohRMtgCyIy5deesuBExiQR
         uUlM+pqK3dtv788otZZJKFVbrydTKr4QqaK4C/dyFkPJkGMHTbSbAJTv7b+u0k4Ki9GO
         HSDJBFqKDyp1vskICTSUAFSx6rZhJ48Vh9lK1gbu77Fach8AgqzWh7onCV1QZXD6btjA
         FvrqZNWO+m87eoJUbwDCBKLv6h/HAhRX4DLoL8EUJZyZ6ME5e8zyer3xtmElRc7hSFQM
         WFuvzLUHWvTVyPxb7o8lJLvc58Sd4IU0co1K80DYwHHgQZV2HkMYtF1Wd5hrt3ck1mqT
         zGVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790083596; x=1790688396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ofxcWs5wvUKXDp1OvqNuIaoTkk52/+tItoWNT6uQhGU=;
        b=k7QG8UfGL/xP5ISOf4kC+7AALJAldDYhkiDW+EjNQKPVre7w3pFTtuQx+F+/KMLY+B
         YQmhjQkIYSLCNZ1JXYpF9virZ98xE1C/ssWGcowtGqjvaPoLhucfgT53NF68R6LqfkR2
         nUcDirZ3oSzhh5OOSp1WrpuA5v9W1BB4FhLutTyYulsKBFPQKlxNoBNncxDSnAwE0g8I
         epzOsk4jHMYeYjTrgSOqjCbUOiXAIHVrs/Mne5wM2BpEPM9Lu4Ab/vUJGhKJDdndxiTm
         4GdLNe48KukkU+J5NHIAhpHK7spOdXzUrbNJo8Rje2uNNTU3sdmbD7Gqvx5pfc64tw5y
         hSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083596; x=1790688396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ofxcWs5wvUKXDp1OvqNuIaoTkk52/+tItoWNT6uQhGU=;
        b=I9xPHfEWQXut/90GkesCuxtgxIQu4fRtRpsowIi4TwIES7y4F9e1XMsaaDSNjNgj8z
         O/b55RTiJqNtjKAJwGJbs2lIhfMOZ00Cj/PKBCKV5oRZ5HwGd6k69deWRiGdjyggur9Z
         bXVHHErwR/uW05P32/fLLawCJ6N5wzdwT/5SsJofpGr+BH1fMIMMHaQLJTfN7UsVbq1p
         9fKfdHQ6ycnrT+uPoD0tviYK4fbVwnoRdHE0UNHd8f3/BQjRuTVJxJsJ5xufHCCqyScC
         +uGIuM4A+SfoWeUSMBgcWWtrYgPdNF2tB4go7VtKqagDzRRJMojHtya/ilkf7QHKzIQe
         f5vg==
X-Forwarded-Encrypted: i=1; AKwUvBz/mItT+lK2jf4cEPZjSetj6+qTUJcy+9Ep1snZX0YFJxdopr5gPEf01GLc1ki6QPkAvwagSss=@vger.kernel.org
X-Gm-Message-State: AFuF++l024awfqLM0oEVVimKFBW46LyVOOJoq/r0o6U6hJpHzXyPMGg4
	3xRUo2DljJcXeep8fIgHSCaEypSodehJeymDpv22wVW+PliGWA5lA8vjC66jlCJkDyDpIcAsjzo
	RKZln/GcS7wzwPz2BCuRvhKcTkXJi+oU=
X-Gm-Gg: AYBFou2rZOkO655rWY0vY0Nj6JjZTMumNEEjcUd+cILrT8Ww9V2KoIbralPfydu4EsL
	+u7G8UkRcpmOIwNKAqMaEXaJxjWMJDJIVE3NsBoyXmLmOiRH8snXiLoWy1BfQ9xigaRicI4gbvS
	3qRVZ8K7odRS0h6z2uV3QWMpCpLqtne0smD8Sr0M06+PLnS4DAfVQTef/iola+sEyOUeDaW4F/N
	fClPUAjDk0rzJCPkiH8E9FvXQFvER/JSpkcH+j4VHu43mpBWy3RL9Y7hT9Sq6v2pqV6pRl7AUoi
	BXH5M+nbq0QGOdUNFS/hw068nDvfkKAn+74Srsd0gqCAgH0IgWju60jRLA==
X-Received: by 2002:a17:907:962a:b0:c25:6c9a:88bc with SMTP id
 a640c23a62f3a-c2a156ed781mr1064393666b.19.1790083595818; Tue, 22 Sep 2026
 06:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916235200.20712-1-ansuelsmth@gmail.com> <20260921135933.7e8857ba@kernel.org>
 <CA+_ehUwy9RUKCCHDnqoED3AMVnErgGr9RCrCR4ceg5QONq1wOQ@mail.gmail.com> <033fc935-c37a-4b0f-8b79-68248e45da8f@bootlin.com>
In-Reply-To: <033fc935-c37a-4b0f-8b79-68248e45da8f@bootlin.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 22 Sep 2026 21:26:23 +0800
X-Gm-Features: AcwNN1Ur2tt8b16s6pIVEQsDoiyvx1gOYWr_ba3DyTwWp74e1eP8TDNhMjUzs84
Message-ID: <CALj3r0gyfggFP-T+yXM2P=ooyQMk0AUfnpxtArk5ioU+wMNrxw@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/12] net: pcs: Introduce support for fwnode PCS
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maxime Chevallier <maxime.chevallier@bootlin.com> =E4=BA=8E2026=E5=B9=B49=
=E6=9C=8822=E6=97=A5=E5=91=A8=E4=BA=8C 20:50=E5=86=99=E9=81=93=EF=BC=9A
>
> I'm attending a Rust training until thursday, I'll see if I can squeeze i=
n some
> time to re-test on mvpp2 :(
>
> There're a few series pending for rockchip and S32 on stmmac that deal wi=
th
> PCS support and their PCS handle. It would be nice to have some stmmac gl=
ue
> maintainers that are using complex PCS to help with maintainance or at le=
ast
> testing, maybe Coia can help with the tests ?
>
> Maxime

Hi Maxime,

Thanks for thinking of me. I should be upfront about where I am though.

My focus this cycle is landing the RK3568 XPCS glue before the next
merge window so it lands in the next LTS, and so downstreams like
OpenWrt and ImmortalWrt don't have to carry a backport.

On testing Christian's series: my current glue goes from
ethernet-pcs-mii@N up to the XPCS platform device and hands the virtual
MDIO bus to xpcs_create_mdiodev(). Christian's series changes how the
PCS is looked up, so testing it now would mean restructuring the
Rockchip glue and rewriting the binding, and I can't fit that into this
cycle on top of the initial merge.

Once my glue is in and the lookup story has settled, I'll be glad to
rebase and test =E2=80=94 and convert to xlate if that turns out to be the
direction. I'd like to use xlate long-term, the timing just doesn't
work for this window.

On maintenance: I'm a student and fairly new to this, so I can't take
on the PCS subsystem as a whole. What I can commit to is helping where
I have the bandwidth: testing when I can, and sharing some of the load
on the XPCS glue layer (pcs-xpcs-plat and the platform glue drivers),
plus a bit of pcs-xpcs work. If there are stmmac glue maintainers who
can help cover the rest, that would be very welcome.

Thanks,
Coia
