Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE152E0B5C
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791669653; cv=pass; b=POK/zTWpx/tVjMinWMdIR3uquoBoDXEpFde6bOYyZibjocV5cCWfVyX7ePdzAptACZ0X5nCuotNyRDhBrJVeZBZt1qq9wtvlE4/BhCMiKzKQqJZ+AHTNo2qEW9zE4sUDnBvYtVS3b/2KX4XIkQXlxjXazNzjfGvwNp+v28SOHB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791669653; c=relaxed/simple;
	bh=VsLa3yNmPbqAsvOEv+girJFBtwqO7wp3UAIL92BqneU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYNIjx9KWzThH8uo7qORl5vU8xKnixrMd/+m3IyK2oGpJKA1ltXdKvZwnvNBYxAlPVHPKpe5BIu1mJqtqUE1SgCAJX3gAuRyu7imrRDK/4sOsFCxrWsxdfrjZMNK97tpmvQkHzxukvfPgkHM/Zi4af/Z1JhwwDkg4QU4s4uPkSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Z+P3lxY2; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Z+P3lxY2"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-677bf06de21so497752d50.3
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 15:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791669651; cv=none;
        d=google.com; s=arc-20260327;
        b=sx9KtaeOIpGsHqxPPxRVGAspB4aRWYQ94dzJRZ57Pq31vFLGb8IbrTPVXn66c+XJR7
         e1M/a5PNiSgF3ptILg2fh8sy5k8GLWZnx6r0+UDdFuNDVe/FK3jdIQ6qNB/kh7cWoUnZ
         TSUE6CDM3DqQqwEooiSfeTYGtq4xJ1aiLLIcZvrd4Bw5/OxpThdTDQa1fbdETNcBYlLw
         UqhBepxYDgM48G0RgSO6LLQ3te73dS8E/t+FQ07W3F4wzFZ2IKz+WxWiYwcKYKaLH3C9
         8IvvWyU1vUP5w/FW2d6Nk2nJOjuX3z9FznHTjP5uDnVPzmv+OQvl9GQRJ0DRCHkEiUHk
         w5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=viEI3bB6GOdsd4kqZvlb/IfnNxfAW1h37zzw5ogvS/U=;
        fh=WeXQg1BYjdUEihFKoZLm+llWyA2enru7VF9iV7cO5ac=;
        b=LChiN5uFpDU77QWAArJVWRJfuS0WG+ME1JiJjoBMR36etcGIbd4Q7bnJpXy4L1mCEe
         opj/PeM35I79rbxcOtnzrU2an6fVq42LLXcQE2NqqP0vaolEJdZqwLs4MJYbnOG6tLvL
         oLs3+9CVi6fomjvBd6JQM6ycmk+bALSxKwP6iq2dhB6t2k5NHRtkF1XoDjyq3IgcPpjB
         UInsQZktEEX03WJ6Etcdl2HYkFcJ9gqSgJcggapGpNo9HAOO0rhTVUknYU4dH8Doesbl
         6/qoeL4vexu3dsuf225Zj10ZOriccdhDo84aBlvW9H4OHBotHAF7s/lxa2cNU9hg/MUs
         q+Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1791669651; x=1792274451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=viEI3bB6GOdsd4kqZvlb/IfnNxfAW1h37zzw5ogvS/U=;
        b=Z+P3lxY2zcf3Kb5thIym1/9pShU4pcsu19c2lYcYTIM4vhCVFK51rQVCb7734VU41k
         dqI+fbGue/8Cucl8f9uyXI/zYAaAJ4Fv2gm5rFFrCsQOhLi5VOF1Eow9TdguabLJmH8h
         brz9+JrfAF4RkW0hKjsku/7aCEZUpRN9iON6kmJX2PCVFWv662FKwFkAirHlwxLrser/
         xGyaQ+GHPIyhCTSzVa2cLL8pmlcM/ulykrmnT/OiyOXfJFJVXr0AgpU4ybSVQ+b9R7IR
         YkUg/AyxCu6sFxqOKZE+3HrmYiscDx+dDICnmpJ6YoFm+ElDyi3gOTlwPFat5FeCBNa8
         8PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791669651; x=1792274451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=viEI3bB6GOdsd4kqZvlb/IfnNxfAW1h37zzw5ogvS/U=;
        b=xpI1jNVheXph1VeJslxtCuA4A2q2Xu54UF5Tr/EMu/ES3XLV9Nqj/GzfubrfMZmbUn
         R4YynXO4/lKjwSSS+EA94XdBgnOd4Dws8fI/gn+c6MALS8Eu0RFELAK2P2bEUwX9b5Ei
         3Q/G0fCnUxvc7n+o7tYwvAvaPD7SpSUoMxcKspZM53QP4JfNN/JmYiR4bI5uY0hAdikJ
         VyVC3y8xq0ZwByEN0+R3l+6OKomhKOVjTmOi4ZezGf+tnUmyeqlQVBYK6VaDQOZi2EQp
         VpLcVW0Dot/RJnxKyt9hie7UmbmrB8Id8JN/wpHGb8UErOCWMk+rAEpXO9sOGvskl5GS
         6U4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxDgnXLVLxG1+p8ixl5OY/a+INH2y+PHfaoKE1AVwVZhrFJI+9PF0eu2tfJpRWIWoglzUvO9EA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmA1bfSsMT3jR5zI10szTseVRJJUhvydYraZQIpE5XXjYXuYRZ
	T3kU9Z/KEWofIbtbEiuld/06P5ZCrzmD8nq5VtNmVsHF1/X9882EBd6KeTfXW1apo5lUUZUKT4g
	WpvPGyLJMjvV5XbqjAJgPz+I/bD4bWEU=
X-Gm-Gg: AYBFou3Lo5+1YhvcxWM+dUKfZoAp6fztlcVhj6PPpfG1Lvn1yKGvpq3fzqMj9Ls7woK
	r0gPK1TPy2pmmJ/6R1CcKZItbWEDakSXVaughDcgtgp+L2v798DyBVFSvEcHqgErGUIS0EBahkG
	bembj0U8LOfLFEC+46g64CmcVefg0NG12s3u4/9QQIKWbZYlzsLyFVUZqF+rdUYJYCuKVuxWRjR
	Jz9DAe1PrkF9eloQ7I4wn1Ex2w+kZAnmp4VCEMkNUL3jHFkHD76FV0c3IC5qhJq8+zkWsC1fU5/
	xn3oOJ//qgAf1HO/MWvd67GouJJsB1C6kHcz6d75QZBU1ieEkOsb0EPHVajDhKan6hwwdGyTL2a
	c79hohBI0h3pg
X-Received: by 2002:a05:690e:810:20b0:671:5206:72f2 with SMTP id
 956f58d0204a3-67936049a53mr1141845d50.56.1791669651100; Sat, 10 Oct 2026
 15:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010105900.247342-1-tanure@linux.com> <20261010105900.247342-8-tanure@linux.com>
In-Reply-To: <20261010105900.247342-8-tanure@linux.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 11 Oct 2026 00:00:40 +0200
X-Gm-Features: AclHuK-1AFCBBfJ7Kfb5Ikey6DbHIu9yDPTfwBVIgnuMS2JnhjeqsjRPSCAltBs
Message-ID: <CAFBinCC8iKESoc2zEXJMEmqk0cwWbVap-a2KcAtB7-KFKO9Atg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: amlogic: t7: khadas-vim4: enable the
 ethernet port
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 12:59=E2=80=AFPM Lucas Tanure <tanure@linux.com> wr=
ote:
[...]
> RGMII needs a delay on each of its two clocks, and on this board
> both come from inside the chips, not from the board traces. The PHY
> adds the one on receive. Its transmit delay does not work here, so the
> controller adds that one.
[...]
> +&ethmac {
> +       status =3D "okay";
> +       pinctrl-0 =3D <&eth_pins>, <&eth_rgmii_pins>;
> +       pinctrl-names =3D "default";
> +       phy-mode =3D "rgmii-id";
> +       phy-handle =3D <&external_phy>;
> +       tx-internal-delay-ps =3D <2000>;
You're stating that RTL8211F's TX delay doesn't work but not explaining why=
.
I haven't come across this behavior before and I'm worried that that's
an issue with a batch of RTL8211F.
What if the previous/next batch of RTL8211F will have working TX delay
again - wouldn't that mean 4ns delay in total unless the RTL8211F
driver is changed?
