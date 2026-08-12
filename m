Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94D3845D5
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564573; cv=pass; b=l7vLJAR5yp0869uSSHMVO+Otry7gE5CDNTAfTfRaa7xnzYaO8IcYpInu0osPTFSWyoYnu16ilGfC/T9Sm7XN7Ny5LYPz2+ghe3dWLAUpJMb/CiFAZClTzzSGm7KuxB31/N2Ah4wiWsEJSLNX7PaDDT+LaBpKy3rXf/7wTxmUQOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564573; c=relaxed/simple;
	bh=EAQaKo9Jb+ILAqr1BVcf5D/Ei7LFlOvPRuPRAZrExRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaphEfdMSmRzx1QkeoNcOyKCBsPE+kTzW3fPDE/JCDUNK9iWOIdBEHg18aoR9QY6+kpXr/FddW4rPQikuEdV7tJwwr497gno0kHvVrGWMpH65O3AxopsNuZchwLqS31u8v4GUNiuFYpbG7/C2+jOIo6rQRmoBI6MbAFBTayfy6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4bmk++z; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4bmk++z"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so4556866b.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786564570; cv=none;
        d=google.com; s=arc-20260327;
        b=lwp4jpxM5nfgzOLh1yOgF12KmIu92jhX8XMJAZR2wMPEBZaXzfoG1iVOtyF9j7BpQt
         OWH/i+ojvek06yB0c9UTA66wKJHCYcg399/0q+XIsLktdsuXjMPTjlOgbwb8ZF9Fr4jC
         5qYBW+DkoF+DW99d4hK8UMCxKATRbWxJrfSYOxGHQ44jB09CKjVU0QiZ9Zu3/66ftRDn
         3N4Zg9YwimIvxTQUQq4NDjua1GiTmiBgrbI09u/9do2GBalhg9t/jNGMpG2At3sLUV+c
         u9BUvK2CQX0l+ydbkPNVBzFaAADNZRHgs+IPLVPzS6snZSpYWh+TjjUQh0LoxmbeEK4/
         UNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EAQaKo9Jb+ILAqr1BVcf5D/Ei7LFlOvPRuPRAZrExRA=;
        fh=rb+y+qRDFuBDLmOejYboa3ht3tvG8B9Qf2O+pILPmE8=;
        b=mYJP56AwKMv2I6yjhe1grqcalqxEql/pPzF5tx1KUo7JinOpnG5D4ekSRarcTyUJLX
         hsEGUeSnSTENBB8+0mpcFBIXZ4kKcpEnQi0VwEnUiJRQs2IOj6UjNIirSNwY/Y3oIr5r
         7SPrOhN9CIB9Pn6gjKJ9IiFFYu5h73tAS/y/y+X5L5UiWqDbpNhZbGP6u+xjjdfpoEgr
         h0QNKgEiM72MpeUsI1JmPPHxXWutt1Z4QDjEmkR/ruPN1wy5LGVUX3mTkjRHcrxBjHTQ
         eneNAs5goidC6ZDn5Nbh2iZCSAYrOip0SyYKtrhRYXW81en146I9Q/gWwK9ThB6hW8p8
         T3/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564570; x=1787169370; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAQaKo9Jb+ILAqr1BVcf5D/Ei7LFlOvPRuPRAZrExRA=;
        b=M4bmk++zTPNUDCnMPnoBXqYqkZwtJs09JSwmeAWOvb+sPD6Lrqy0+9CmZp3zKQ3//d
         O56H8zT30Gx7bSnwlrQ+k12u+kRmA2BJwjbcGSYuEL8jUutHX3VPfvfQjCg6I7nL6SPz
         T2TTii/+rBbiup+G2GvIN4m1vjluK1pZBbgcjm8dCt8cq4R2aOPv5e/3b+jBqJZ6Z7VT
         BwGlnx8SAcyEfZmwxSMTOjOeBcYFctrwUUcCEOr1V1K5Pj8DWqHarZ0qIOKI9m1fD7GX
         wjXsjpVgWFj9ohti9FYMFZM28U2MHPKK8a6nohKHl0Xj30WAO3nNC25VAH7k0ZdAqTQK
         kkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564570; x=1787169370;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EAQaKo9Jb+ILAqr1BVcf5D/Ei7LFlOvPRuPRAZrExRA=;
        b=BGOnmFNPCBRKGuTq9lFSNen8NtDTXbf18SmFTFTz0Lg1VxmXH7bh2BrAVd90Hz+Apx
         zwlmkeAyHd25wlzjZjshTANyDfH86+nPa8+827HHVXB2m5PVhMuQIeHmL1LXz+k/9+cQ
         S86C/3Ng6CKD2wZKQO0BmMiMhPwHiVKJpogsGdeyTx4wPcRninRckI+74ubKkNiDuwAg
         Iw1bxrN8BK6Z8Lokl4yco+7gYJdVXD6mNQBombVvEIu9sGcD0JI2s4gmavXS64HeS2a/
         ubIa4lEbww2qT2ZIbMDTZ4F9Ancc7gKEM3XHYC8UYx4gLqzEAELX5l4CoUOA2CCKdu/S
         oT6g==
X-Forwarded-Encrypted: i=1; AHgh+RoPoiEbl4xRzU47dfxoGxncTdS83e0l8TJv/Pxic8tBUf6zdDhUmqN3OCSqyhuY6LWJV2FmGHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyicA26SzNThy/n6N9L/OPHeFDvaeNQ9n6ZpkWEyqcl6Q4LNUwz
	v7bIUCzUA3INuHn/sStGxCRpXnnZ+2c04z+pJ2oGnlnPTqhNy/1eFrJ9iXnh4xmJ7Clz/LESTsL
	oUwniH59LC6LHHx37xKa6gsllU6My3o0=
X-Gm-Gg: AR+sD11K+R/WuKh8si+FbPR/5qCHsibo7EIJs267A9Ndi+nj0Dw2WR303WIlqvzNdKD
	7VIRU35LG2VADsT+Lv0oxu4b/YMDGU8xwROmvo6HyfnhMWuCnVkgwNqrExPbB5dw/4WkuhsJP0r
	mAPocRMrjuaGkox53IAZRjEY6jc47p59itLK0ry3Zp9yB7+GMmYR5wIG47SU7xWWfSvmrziC6Br
	2xCFv9GIDbgcSN3lUmAYtcU6++apMSX+VPdZcu1HI/4ZRvpJb5U1PF6GXKEzLmW3oHQuU4dGY6C
	2xPvMDguYkToUjWZQqrSXsafYJzuGjoAP9rvpvoNqRO+7Q==
X-Received: by 2002:a17:907:ea8:b0:c20:f622:576e with SMTP id
 a640c23a62f3a-c2108fd8af5mr27935166b.22.1786564569449; Wed, 12 Aug 2026
 12:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811113901.3114169-1-o.rempel@pengutronix.de> <20260811113901.3114169-2-o.rempel@pengutronix.de>
In-Reply-To: <20260811113901.3114169-2-o.rempel@pengutronix.de>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 12 Aug 2026 16:55:56 -0300
X-Gm-Features: AUfX_mzmc_Vp1gf5pS3c9lLg2ncAAPiX2u8gP_ck4Dn8vmO3R-RtpUEiFH0GhC4
Message-ID: <CAJq09z4Z80NtBbWp75gYkXHXEvs1COweZGF5Z3CEX0rsVSbQ3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: dsa: realtek: add
 RTL8365MB power supplies
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Document the RTL8365MB power rails as optional supplies. They are optional
> because the rails are often always-on; some designs break them out for
> granular hwmon monitoring and regulator control.
>
> They are scoped to realtek,rtl8365mb: different Realtek switch families use
> different power-rail naming schemes, so these rails do not apply to other
> families such as realtek,rtl8366rb (VDDA/VDD_CORE/VDDIO/...).
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

It looks good. Thanks.

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
