Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3033F4DE6
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827600; cv=pass; b=GYw/QWvmrzUdyIsufp83wDloHN12EFKr3SdS6W1XvqvY+A4tlmYgMvew8OMsvJACYFJh7XV1gw/T+nZIMJ+B8hPG7r4KTgxQKV91mVVaAZViwlzK1fCmpHo6KduuBsfvculxBtLmjof0i/OZk3ppYmJXNwDH6L7/bS7YwfLKyKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827600; c=relaxed/simple;
	bh=rva4hyw7gvKgQLI6nx2kY6fQhy1GsNHj8d008wglKkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXsCihQChdbKXtGkardwf3w0xO0fqIEe1oduDZR29Odyvp98q95ZuyfsNE/81jTbqnvcI/wsc1r4WNstYUaM3OBxsiriDjPYmrSm+LKizPLwmyTMF3lEBiR1fV4aH/yZzvVRsVlBeZoXLKn35lbvJFD47Z3PuXKV2JKvhBKKOnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isFJEwQc; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isFJEwQc"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so7400599a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 00:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785827597; cv=none;
        d=google.com; s=arc-20260327;
        b=piRMeczume69fuB0IMeW3zxXGHGhnVITUgLy5rt2HmdPSPu24OZp4y78l2N+X3JBV1
         qmltNfk6n6je3LRCH+6cQyChPJGj9nYP7qG1DXL4E7GUmER96oSgwcMblNQr9WMbZB+5
         u2lDjCkE2LeIEVX6qpDSbSTmDtlpPFCSa1rGW1RziY7wYtikatGkL0uJqH4XJDyjLF2K
         AbDF2+QAx8lG5srxqQu3QiO3JozePQxgoR23aV2Ys2euVDazoGM9HRCuVTnIBO3UzO48
         lISkhztoW/3+zvdbb6MWsUbJmKdUz/MwWc6WeZXyf0NxLRun9qteoEXA3ts3rocdj04p
         fz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rva4hyw7gvKgQLI6nx2kY6fQhy1GsNHj8d008wglKkw=;
        fh=Vld2zxj/xZjnE3RLNH/H4EIU4fJXydtO/ZAYYhaOfNE=;
        b=XrhsTs5dP7kcDZqUPeoeLz2fLywHSo8zBfICzv83djW4po/CXD5Ex1eOIMeilHea+d
         wdkX5vVLT38KJxy1UHIwxu0AJtvY5goAfl0b9RFD9HB/epfsgE3kr6IxOQMK71JjfAas
         geG4N+g0E4jmF89ymWO7yTkhLwDIcQ7cTgBhBnulwv8rJLlDHXKLZzpo/8pfW27ouqXR
         BlLxzBeFYoFYVAJZQRURtz8wDn/ZnC75yvL/l/pvc3alH6YbgPDCJB6q328bj9ogY3mP
         GcAX9MXWcP5hWBvATtSkhi/fayPqfES/DidMgJ1pqknfsKuksoJ+qL69QhivQtbh9pyA
         cfaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785827597; x=1786432397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rva4hyw7gvKgQLI6nx2kY6fQhy1GsNHj8d008wglKkw=;
        b=isFJEwQcN8Ge7PL0FMyyXPQ25cS3PxEcps8G/iVkEN4jygPt9+G4WhS9ULkKUt+MWZ
         /HpechSL3QSAI3Y5Z7QSxelF2ei8hRSQbtH/daqrTyEG+tW8j4aMbhun/BhwkcDuIVPZ
         KWnQTVjeHWvgHr+NL2uKY4l/COF6tshmdmVx4SsYJfRg5YYVTL+re1B/Oi+TOm/yf6N7
         n45q1KU8Si0+HZ4sASyRtMS6D2RGqWOsISJmquUZhb1257FUMssqGekRqoszqkMETvjP
         LjeoZTKbO5Os5bGWKCpzHL42ZNSUyFM+q+xKhhsmINCI43mfEzwVL9na/sFTmzUf5r6F
         sC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827597; x=1786432397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rva4hyw7gvKgQLI6nx2kY6fQhy1GsNHj8d008wglKkw=;
        b=dV3bSrZmFd8iXm+y6TJhPzLvaAeZSNyRIgCr1e/JICLZcBL5ksnmBlz5TFxUlIhzXM
         ZY7hcjxBE8IMTnYoyOwq2JwNKjgi1TsBP8csDxykMVfIezwy08LjqHAJUpJwMWWRwgZV
         sr67uhI7rNmxfpGRrx1ANKvY9u0FGyehcvG3L+gcCzGhX2IJOA8sC7uinlsCd0xG1D5l
         8cAdyDeNRc9+FiJwan8El1yBpVuK2aRZd0Eqg6kE4Gyi97m9r5QclsTuZ6K3k2IflTqU
         3pTYehFqg+NZKLEubgvbB0Lub6V6q73BOzz1ZdLnPx0EB0v/e48AgehGi4vG02+MJ9Kf
         x0Wg==
X-Gm-Message-State: AOJu0Yyf7awaRlYqF2gxaFKYd5tMkvQo8G1zDqY4ikxBuVnmlcbSLDhR
	KNA9xEcE3+bP9TNxG28mrPolQedueU66k8yt1ytQ0yg2tmZnj6zseY3MLj3bF0J1tQr4OkphkG0
	Od6tkFfIkhvbhmiscVNGMPemI3BsWwq8=
X-Gm-Gg: AR+sD11mc8e5NP/SYO0w2tu9yqumWXbJ/1WhkxTJZyzdAEZ8NR2PD2w/gUQ8YTNWlfM
	XqILF9QssArPKaoNXFI7acSw8CycmfX3wIv5BJyT+JOJb5oDtaWvAAuuidUoBbreL/A83eE4jfA
	THOx+vIFl8Pf4JODrU46IeRB6GEUMTGSmiEhTBWykD9vq6dXCQW3exzm+AnUeWCx5lQ4+Fcadk3
	+oK3JWQEABiJ7+Ih49M9O8e7AnMduztW8bpwKIhJf00CmSI0UsrF6bnrBrgt+WIgq5N91ezHGyu
	HkSilmFzoc+t5VGHkKZXWw6fhQsWTicFXJxWt3dcXXTZ2A==
X-Received: by 2002:a17:907:6091:b0:c20:2165:d74f with SMTP id
 a640c23a62f3a-c202165d8a8mr344142566b.22.1785827596816; Tue, 04 Aug 2026
 00:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
 <20260803101734.270821-4-a.shimko.dev@gmail.com> <239a7699-bbda-4fab-bfa0-604b1d8806a9@lunn.ch>
In-Reply-To: <239a7699-bbda-4fab-bfa0-604b1d8806a9@lunn.ch>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 4 Aug 2026 10:13:06 +0300
X-Gm-Features: AUfX_mxu7URC68Rp2eIqVenze66FGmXtUS8bwDr_GTr_7zs2xAgae4LnKHh4U1Y
Message-ID: <CAOPX744YEhdgmOFPT8PjfKp=v4tVq4XefYaRnk7N3J4MPB9sfQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: phy: add DAPU Telecom DAP8211R(I)
 Gigabit Ethernet PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Aug 4, 2026 at 5:30=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:

> Why 0.00 for one and 0.15ns for the other? PHY_INTERFACE_MODE_RGMII
> means no delays.
The 0x1 for TX is the hardware reset default from the datasheet, not
a value we choose for RGMII mode. For PHY_INTERFACE_MODE_RGMII, we
explicitly set both delays to 0.

Sorry, could you please advise me should I explicitly set TX delay in this =
case
to 0 or the default value specified in the datasheet =3D=3D 1 (150ps)?

Thank you for your review!
--
Best regards,
Artem
