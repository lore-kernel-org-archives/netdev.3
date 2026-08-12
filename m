Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFCA353A80
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564868; cv=pass; b=d1H6VB64ZxHI33rkv9jWt1f3da/r3TCjzTXkrXMxjLpm0tDcIWw3hBfztL+H40Fnqf6jU5lcLsLk16FUf9BddvoN71AcgPK664Ux+rDKTOlFMGSelmo82Ay76NrVHA7nZcD1T9maAd+RmIEWsNTJeIAcL6Enw8xoQ6PX6E686Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564868; c=relaxed/simple;
	bh=VaHALOUSG2g6G7WyQkiHkXR0si2CeSLue94vqPiIyjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7EbYEzZaavK1kw3RDs9r29CyiJfh4emLa1DpcQpp6xjEZK1X86PpyKd2fdItXL6YDyWvVjl4AzMc+xNfvjAPZ8XcwtG15ZDeByWoBWTvAdp4yquo9Yl4tWlpstXhnHkutnnXRo418U6W3a1sNoLsUe7LPjYhveSxmvYxRyu0/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IphyRB4s; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IphyRB4s"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15d47266baso157944766b.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786564865; cv=none;
        d=google.com; s=arc-20260327;
        b=nkjDMZrRRQQ2+rieHwueTDd95BaO/FveZ67IAdehu24owZjMUrgJUhgU2Nasg2h/HH
         brBPocBskrngNWYyX5beT9mMgBxxE3dlKBxHXky5FsGb0bAJlLl7cBZB9yapFkAfYkY6
         rxY8964E+H2UuNNlv/JrTyA1Ar1vs4dLRe3jcUC4rm26xHRFu+xGrpgtX35z0lPIELXw
         LFnOp7qFJTj9S36Syk27okUw/oFVcjCbmcmiVcE/9dS1WY9FGqgVgLN/Jb8AC7rHmlQu
         N73wlVKWXN56ozNpDMzvwTNEfbA3mTYGk+/CrVxVCk7VqgErCiGQ716Mv2L+Feg9gW37
         dxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b1mkxMAVLNmutCK/Iz5uJqbRh9hbAkmdvbl6ODqSfCs=;
        fh=1lE0SF0d+i9XTP+HwlYP7vXPNI7hmauYqoMgFX/bxFw=;
        b=GD7MFIVcEMk3xEiAGcsnSBKpkjHHDDrFp6AhrKK5acjEdqzHw01YAAguCHempaLmMs
         jbNKit6R9byfshqAGKbfJGd0Nc8C7jDjigB4Szqw/7LljWVoVnd9pC03RsxYDfLKjQxw
         yjXsuzf52aIcxMt4aArRg920h1isXERKUx7x1UsZDMFSaAqn4StI5vfv3J8Zx2OtlxVx
         +QtBqZEC8LsjwASonw/Sd3b6Kj38GQvVwgtinFOhDagoz4FNu5zo7flJyJNrFOSy1iNL
         tnDoIXXIRkWZ+1PyQrczDmR651IfICgBBwV76hGJirIpE+9najmRZ9MnOLcrOsWsPgtj
         7WjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564865; x=1787169665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b1mkxMAVLNmutCK/Iz5uJqbRh9hbAkmdvbl6ODqSfCs=;
        b=IphyRB4ssQ9jJwquQ4/pvIerb4aCM/JCp0AUOi9nSRy3QXrhKJwTuAaOe1UQXNoao+
         t847nmOzlEBLXHYExjiU/4ojNKlhXC3vY8R0F8Im9jn5hLO3cgiApJ/QeVh6ZpDa3dLq
         LgmubhFiaVR39lVs2dq1897WUh8YoIV8OMDU0fE94zZASFY1EQM+4Rh1L/K61P/DPgAI
         mc1j0d4plUsS93o3ism1ciy0rQlQiyjMpFvJLSmnguMon+ozuaMRoJtmoa23z/m9g0nY
         Ry2IcF4XIQIEHD7iblh6l0hAA+NaFi6jgyKKYtHS7rXc2vNHyIp7JMxK1WUsA8g1IT3+
         0cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564865; x=1787169665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1mkxMAVLNmutCK/Iz5uJqbRh9hbAkmdvbl6ODqSfCs=;
        b=hlNkdCs/wEvuYUVFd4aETrhEE14UWpcTRcj+YRTKRRXfId5JQ679s4bePAwfNiZ1t9
         qRdl8WQGIZ5xhPnDylqk3iuDotBQEJC71lPYFBlXqq8DkqoqVTFwfA1UWZsHEauyo5V+
         hvvu6pNQjbohQUotkp2hRM++jnUAuyLAij0PvegIYPCpIm03i+YkF5kKfJ1Pl5+Yh1Nw
         7GDlcqveJM4gzdIn/jZX7QFqiQh4H+wnOBUfUfoGcgA81wgtUo/EM7iMCNwiz5XFN110
         XLr1r/E9Xgl8hdwMjhWdsd53jjFK/EzUW/JwyZ0qOhQTjJ8ST5oq/8u5Pw9tZSFETSGM
         rUuQ==
X-Forwarded-Encrypted: i=1; AHgh+RoslIX95/6aIzwR6lgf5mC6W4rn+xMU53Uqu69dnLLpx+gKuHGFcRBMVADRKf0fcDbX0kwr6zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysNwYNsSWM15NF8C/xn7cDcPcDMeMsSdXT6wKZCmCdnGKLXfDr
	4wqYyJcL0XKgjd6OEebdneLmQG2lAfjsp9SA4UvVj7tYABm8yHL6Psjs7GgpryIZIfFE7gj5o3M
	52pMFNNlBOMPFai4aRRXqytzmjk1gubQOw1d48v8=
X-Gm-Gg: AR+sD11bVzuQC/EGSoIKdyqU35er85TQx2MMxTQ2M8bR/1OpEXPBDkQMCXYId9rQ94b
	bKWKieS258MRmx13YQJVZDLaoLYNxC7QYLdHwAVhEhWc8C453qUDfg0qF5/9nRpNXBLHxjBkTYN
	aRixjdfKptKemwyFMDU5Cr/j/DC6sGOtCNF0UxEEGzPP+zxYVmQ/fqim57mDQwXWctGmbPQ5jkv
	BLzHYz1TleCq+7QUGTCmi/KRKiShqsNmO7m8KR5uB9yRksMxXZiLSPI/wzkeBa2nIoo3q6k+izV
	Ypy8TyMUHomV2UbGQTbRHjOQm0YtK74DjuvyS0qzmExoaA==
X-Received: by 2002:a17:907:608f:b0:c16:4e5:944a with SMTP id
 a640c23a62f3a-c2108fdac65mr34618766b.21.1786564864596; Wed, 12 Aug 2026
 13:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811113901.3114169-1-o.rempel@pengutronix.de>
 <20260811113901.3114169-3-o.rempel@pengutronix.de> <CAD++jL=p3Y7-CmDqwB1-K6HGXg6AM=vkzP=9u-8FSG7t4AUFug@mail.gmail.com>
In-Reply-To: <CAD++jL=p3Y7-CmDqwB1-K6HGXg6AM=vkzP=9u-8FSG7t4AUFug@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 12 Aug 2026 17:00:51 -0300
X-Gm-Features: AUfX_mxAHT_MlkAfu1c4BZ9pzu3H2y1aVflMqpkdyIJinD0i_NQC-53KQ2MAm-A
Message-ID: <CAJq09z4cOBUJK_2trDW+sg_Fs0nJ_Hsf8hsBnkv83o3gT+pWHA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
To: Linus Walleij <linusw@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Tue, Aug 11, 2026 at 1:39=E2=80=AFPM Oleksij Rempel <o.rempel@pengutro=
nix.de> wrote:
>
> > From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> >
> > The power supplies powering the IC may not necessarily be enabled by th=
e
> > time the driver probes.  The binding describes the power rails, so enab=
le
> > them at probe with devm_regulator_bulk_get_enable(), before the reset l=
ine
> > is requested and driven, so the chip is powered before its pins are dri=
ven.
> >
> > Boards that do not describe these supplies fall back to dummy regulator=
s
> > (with a "supply not found" warning) and keep working as before.
> >
> > A board that describes supplies but no reset line still needs to wait f=
or
> > the chip to boot before the first register access, so apply the existin=
g
> > start delay in that case too.
> >
> > Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>
> Kudos for all the detailed explanations!
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>
> Yours,
> Linus Walleij

Nice work. Thanks.

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
