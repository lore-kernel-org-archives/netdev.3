Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9464A2619
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468015; cv=pass; b=EsQbPqdhDBlBFqjkgYvN7yB44Qr2weHtkdWuazZGlVf8sHHlluuVaD87xTEUdHaSanMJS5FNzW5dgc44pMfdYy1x/Cn59cm6xLB5syQ0MeicxKNS6p1pO4w/wU8jZmJSDMrsRcBg+XbKDJ5I11pJ1CNxOUgtoVeaCqvz2vBtpho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468015; c=relaxed/simple;
	bh=KXK9pniBla2sDNE76Gs46MAxBnpmatFIad1YQvYCKE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Krisw+H/TXZgljjx1pFCtWXNqAqScuP+nWtEv1+7wEA3YcJ99KJChSpcbbooBwf18py5bd2xFWX120sG8b6PTeZ+FPEeHY04aEBcy9QqYNM0GhWz8RWypZFioKsYyvkuXqdeDNu7t9M6l2hTf+ijBDyfZDKYGK1rnaRALTTIdPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nnpCVZzN; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnpCVZzN"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5337fa12431so258651cf.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 07:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791468013; cv=none;
        d=google.com; s=arc-20260327;
        b=NbWKWlfOym1pD1LhTzPWph86bKmq1rk+GNxlQ9+n0QG7Hv4pjuqNOrTp8d3VZyctBh
         4c4xR3hKU2DesS2rBsOIfUfV2dmWRyTByCvSq0402enMgziMOYEf0Td+6Zwwt9u6R/Bt
         SyWJWGRdo0gSsw95gDHxB1+FWTSQpa2fDvIYSEZarbHhlk+QpxvmfrucYuUxzu/d0JtY
         dqOnGniPlbXDpWkVCw6IF+iAHhxNTYah1tzlfwOUFg1VaVpmJfYv3Dpol2ZmXzZSLMDC
         WR6krsBsg+1CbK+RruVS2yuCgD5RbrV03JaipkHkYUtniUFp59VJ6T6MkP5qmlWtjx7A
         r3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KXK9pniBla2sDNE76Gs46MAxBnpmatFIad1YQvYCKE0=;
        fh=41MVOkYNCRG5LQ79Ymf9jAgainHtSrhRdxvVNu8w2A0=;
        b=GwJfiXukgfxLwkOA8UUX8AJf6xORX8s28fojZ7FOlMw2mzPosfPXvJ6qICEvhqld0n
         9PeP0ZL8ehapsHSEJhYosBywru5GvM73iEjap+CGDcAH5LetwoP7q5zXU5ubjcTirHas
         qru/L0R9rE0MA2H5UF6saiyRhNV9vKu4WckfCppC+ceiIGo4GCYDmmQ4UUUFM6wPqQSW
         9/65VmQ+LpyuNAu7Gl56X6qgrTS92oC2PCod1EVoqH3SxZDzsnuCosVuPyPV8Fqilmm4
         IlOOZe2cw0rBvPScFDHB5iB8oaFQ6Qfep29+Au+otUZ15EqzA2Jewacy+WuwcyGdXhsx
         uj7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791468013; x=1792072813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KXK9pniBla2sDNE76Gs46MAxBnpmatFIad1YQvYCKE0=;
        b=nnpCVZzNIPOF/t48Pam7Dn49sc97gyKL5gPFGfVEXQZdIZboW6XCnSv+v6w7ob5myA
         //c3z9dh69rc7jgVcs9KZ9uzhSzxlyXRLwLpFe1VHCnzMydoEosqv2uYuw4CV5h4xDi+
         v4jBlJ+d0ALcPJLHz970pOKcX3d/rSsTSZ6u3OdVAVezd93vY8mGUpc6ACzhP2Q370en
         cPesECrNkZZ9zbcNBHjn9wyHCK02zS0DJWrxu+kuLaS0tG/0NvhET/alr5pqg7ez/uZj
         07w8rTv53vIEj2STUvjvhgbKf9OIt6Y4kOGxP0UmvJj3CrFyGEg1k7sqyar80I3iwR8N
         Y86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468013; x=1792072813;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KXK9pniBla2sDNE76Gs46MAxBnpmatFIad1YQvYCKE0=;
        b=JQfdGPOEsoCm7BFxr0lMm0ND3y0xt447/nbNbINaFuzsIN0hx/MKhiXfUziInxuwfI
         5chXMxICA2cigfFbaaj5p+pDGwsY7nyLr2kpq/nRU7w0rI2JURwU7YRZbTsZCYJS8jPE
         GbQt/ZdoAjf3k/xCrZuaEVYpctF2QHQBvSDAuLuNLkoHbwRDjsPkFPpnDCqeEYxEV7zE
         xSOw4JFN/3Czb11Pjmu9erzjlqkdZe25FJ0zSDR3HDWX31S3PZ7Mpgr6YaVWeZLkjGRg
         8lLZDfhI88JWaDt1JXpqIlANBDJk58Ig5N21nJAYZdTBfFNVDCDIK0eyVye5l8kW0MgF
         iE3Q==
X-Gm-Message-State: AFuF++n+QZRFX+9Lq4aLmIxGN808LEd2xeijI5BFXKtZ+DFzGCy6ffLQ
	Yi+hBX3T603srmul7ycfvD86M6z/43OOwybPCW1KdjNqSghFhVwu/cDVq+MIoKiSuImsdGRlPfR
	W4PURgIbZPk8OPQfdKr9x87hkRkf8ytj5dsPTxi6a
X-Gm-Gg: AYBFou3UpcV0XP57JaUHmn/h9qN4Q2DA+O3IoGY03WZJIXvasqyaiWMJaQcoWCtdLJ5
	jjYlRclmIyjSJDDTNo8TsdL/RFBFORaNzhtz881kN9J/MqPLq7wMuAWpwgpVZHwRCvdEpVoF6MJ
	dGP97UAHSxuyys7Mn7Z/hIrO0UcO9Rk3e2JVCnkZNp+uV6COq4mmOYNEsxn1bwmRjvQPvRfG451
	ZZ6DVNsKYv+l1WxGSv4IK4pdD4d2mS6YWXhKwaT1YZ7zWm2Brm36KmNkYFTWAZ9nHbgrB96xR/E
	xOQi3Dup/GQUmWEeO1DeDn8NA2bZ3vgRQD1AxBTmWZ3z27eJOF8E0+fXOmmDVp1pDZxXIBpTiHi
	P7EC5OGdQ7HBi5LenqMU6QmWibXfkucU4JjQ7YMwTIZqLCw==
X-Received: by 2002:a05:622a:148e:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-53589bdbce8mr17430381cf.1.1791468011587; Thu, 08 Oct 2026
 07:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007133018.1451958-1-antonio@openvpn.net> <20261007133018.1451958-5-antonio@openvpn.net>
In-Reply-To: <20261007133018.1451958-5-antonio@openvpn.net>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Oct 2026 09:59:53 -0400
X-Gm-Features: AclHuK8waoDhexgHY5f9cTtn8Ap-tyRL9bY5npXlfEk3kIu1zFQloGsKT9wbPII
Message-ID: <CADVnQymvjmpFE95MFDLwHJJpusZ+FfnHyLs4+bo80GjtrLhafQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/7] selftests: ovpn: enable TCP_NODELAY on TCP sockets
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Marco Baffo <marco@mandelbit.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Ralf Lici <ralf@mandelbit.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 9:38=E2=80=AFAM Antonio Quartulli <antonio@openvpn.n=
et> wrote:
>
> From: Marco Baffo <marco@mandelbit.com>
>
> Userspace now enables TCP_NODELAY by default. Enable it for
> ovpn-cli's TCP sockets too.

This claim is accurate in context, but terse. I would suggest a more
precise wording, like: =E2=80=9CSince OpenVPN 2.7.6, openvpn unconditionall=
y
sets TCP_NODELAY on its TCP sockets. Do the same in ovpn-cli so the
TCP selftests match that configuration.=E2=80=9D

Sashiko=E2=80=99s suggestion to keep an option for running with Nagle on se=
ems
worthwhile. Peers on 2.7.0=E2=80=932.7.5, and mixed-version setups, will ke=
ep
producing Nagle-on sockets under ovpn for a while. It might be nice to
have test coverage to ensure those setups do not get broken by kernel
changes.

neal
