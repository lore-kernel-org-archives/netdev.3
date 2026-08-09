Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8AF34DCE3
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786304017; cv=pass; b=TQNb4pqJ0sf4JpEpQs6BOZ31jC3Ri8+uUmW4+inX31bG79JaCwqQtU6IsurTvBzkUsOYEbNxFDpjdwLaNoB9f43XATpaQONCKGY2768Vaf0CEHI1J1vyt+h770QTuQyIn4Ca1yJk8i7/BsoFj41a7/rLPruOIJZBT+HOUuDGcB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786304017; c=relaxed/simple;
	bh=RPr4HbeOYBx0UUfRs5eyQeh6mneGGhSTFXdVw6+j5y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpbYMfetxU7evIOu39VX2+DwuORGvA8x9h+y5pFAUkR+W9Y/AaIFOs9LCTPR4Bo9Pe8ggHh09y6zakzodMnYFjpKCM7FP5BWXpFYOQpZ+D8aaf7E1yq7YwqAoNWfmTxjkkWpMLuqpYh+5QZvnug+ACzSEMp6R3Mzcky028Nc0mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGchOm0l; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGchOm0l"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-97727c2064fso872465241.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 12:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786304015; cv=none;
        d=google.com; s=arc-20260327;
        b=Bai3iePpJ8h768zYDbNTXyAwAB5uyipU3iM93LRR1i3b58+a6LcNIExURJwR+/+c39
         wYlHrRen+1JmPOWQJ0RkRkxUWuPrRr2ZqPYOHFguH8S/yCtYbFeVoxvkWFWcgKDXySoH
         6ZU1NUKyDz3lQsWAMK7Di9DVh2Gx4cyQEAJIz07HldWc/Exq342AQWm2Z09uJmIyvO3Q
         u/F7l6h4Xcs35+GuVXtR2HN85w9YT/5UWIb1YdyfABp+eXArLAz8JY6sY8A+pnoSMzxu
         BGS3C025GTSGNSoEVTUyOT+bVJKbmTqroZqkoqU7LUHJDTETGZn1xtyysRSvH0U5rUqw
         QHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TGS68oaa5am41wZZT817t30c1pv9fxqQGsu7xsnoMpU=;
        fh=tWwIrHCmpDSHYRf2m1pIshgk3qltI7Q6Yx9kx/DegIs=;
        b=m+tVeoXUJk+mMK/OTQbdTM4ousiaTyimiDC5XZrU6keOUerEvZ7n+6D/0OZjlhb6Dx
         eHwhbK5PJLgn4psZSnDl8OmojqyyCYkUu1V5KK8Y0cRRhdkYVr5qDj0R5rjatZJINUh/
         Gs26xaNd9UrGDWgjJKjPUwg1RVq+yEWlLZfu7zTlhzcMGNlXz7aBen2lhw0nzs1DVc4m
         CVIP3fFSkOvZ4ydZYPivt9fAKIfatqHwATFBvKI/j+0BMjAXyk9jTwx/P3CE2NiF5gZV
         LHOcsPbyYlhyCom9l/wQmElqtOgVnj7g4VssBHmHTcrWZ6wu5r43PwEmOhh5s6OTa5Hm
         OdtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786304015; x=1786908815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TGS68oaa5am41wZZT817t30c1pv9fxqQGsu7xsnoMpU=;
        b=dGchOm0lZ3GI5CKC/QppD8tK1h1Sl5Phx79Rn0lUGlvzBYd84feRbiN7LBtjwbsNpb
         FBGYdCpCXdONGzxn197nWUsLvIsel2ulXVGAJ2tkxvOm8PK9X25kPux1TusxX/j+eFu/
         rTBJ9xekAU9zfzkzKmjwXWiR9MPr3gcjv7EygW6At4KrS95V0AgF6VVXZF9CsNo45bj/
         D1xL+l8hQ0DG9dlz/GcjCAayKhx6Vx9jnFsmBbRarPUet0uyNnY1mkXxzZb0DruLq9fl
         A/JnJ2EYoiGltuT8FCWIEYv+QQOIOHgIY/D1Hq74InEU34txdJ2LgPQZcVNV7P+098rJ
         6rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786304015; x=1786908815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TGS68oaa5am41wZZT817t30c1pv9fxqQGsu7xsnoMpU=;
        b=eSVUK6kA3/PXP2cpmR+yN/Rlw3jrzSDkf8knjD1S3ZZm9LJ5E83eyqxbPGpi6Y5Ue8
         RH7IDouIbnqv5j6PjdPLJcmqvTZRsARq6JrtSocHUpdIu+71ZcuOb0Hr0iUMJI46oA1a
         AtbA6sFKl0tXfvGHI1j03Qj6zeZq+katXwoTrYx5eu9VhHbhw59a3wurRCo0cP1lXTTq
         NyycH0FqC3cExFaOdMRqAfabdoHT7ieuEb3OUVV8Hv6GNa9YCzGCgMuHgFLRx8AulA34
         TjDkxF0yQxF4UxHjZmIEaGQ1ib/wlVOjP/enOjt2dVhB4N4dSA1XucOxtedfJNfQTb09
         h8FQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqn08u6+vVkFqF9egTGF7+uTLPRU6pzl3oS24ip9UR1HkQjrK/Mdco+l2apaGuz+5M0ZMaa2ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxrRigZ0O+JzrQesojrA2o2wvKEfCCIqyEyzLXWUIGK+YXN97K
	ZDC9c2N09jQxI+YoDKQsYs4OdaIp+z/sSgI7Y1SSLt4VrPU0gWvsOgLOnnldm2mM8/sNYp/ARbl
	dpPGwOQOLCmcP0ZvNA414IiB6iEjIovU=
X-Gm-Gg: AR+sD11O0nhJ/DypiEGKtDmoAZwGa9HP4GiOO4sfdnHBOR10XrHMQZzetoskwY22t9h
	T0n32Z0F/kSU9O6ttMUdWOMHTBkoZRj4HKGAvb1dUKQWdtAF6iyyomN5udhFmOXQCLiDp9c0mjU
	oCqwAMUVhjf50mgknDTiLeORoFg2mGoH3GFOCaDWq+hwe0SSZF8KSCUlgaYe8g2wc0Rd7053Sn9
	Mrgddzjpf9UaIaWjDGw2X/Po1ZzgcwR8hIDTn/ysHlL7VDnUaauL5gZ5aGTrv+OMLuHzXmrGWEP
	qXvlCBft+F2cZU03T24GUTJBD6DU87A1mHMK11cJextmYMkppZ0Y+hwQFQER2FZRaEiJ12cFqJv
	Nw16HDWrcJDc/oiR+4/198ZfcjXoD76Pfat+KJSK2AcPk3MJ84h6zUcFDonp6JapJA5tXVDLWK6
	PpR1SZAyD3ofbC+rMfW9tRwl1kiCPusFrogCjYPeeMmNepquk=
X-Received: by 2002:a05:6102:801b:b0:744:dd70:a364 with SMTP id
 ada2fe7eead31-7634d10f5c8mr7573848137.9.1786304015056; Sun, 09 Aug 2026
 12:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-acx00-of-dynamic-v1-v4-0-9bf2f7441632@gmail.com>
 <20260806-submit-acx00-of-dynamic-v1-v4-1-9bf2f7441632@gmail.com> <0cdd9998-51e7-40eb-8c01-54684f6944dc@lunn.ch>
In-Reply-To: <0cdd9998-51e7-40eb-8c01-54684f6944dc@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 9 Aug 2026 13:33:22 -0600
X-Gm-Features: AUfX_mzOq97FjaI0PSkDYysmL-_ryYIJwwwtqJFoOnJ9tJbRQVWAa9v1yb6KcCE
Message-ID: <CADvTj4oa=G0WYAG1Hw9se3dCXxer24X-L0Oe2X-D14m7FpLOFg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] dt-bindings: mfd: x-powers: Add AC200
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, mfd@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 9:34=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +description:
> > +  The AC200 is a mixed-signal companion IC containing audio, video, RT=
C and
> > +  Fast Ethernet PHY functions. Its control registers are accessed over=
 I2C.
> > +
> > +properties:
> > +  compatible:
> > +    const: x-powers,ac200
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      AC200 input clock. When using the Ethernet PHY, its configured r=
ate must
> > +      be 24 or 27 MHz, matching the rates encoded by the documented EP=
HY clock
> > +      selector.
>
> What is the scope of this clock. Is the PHY the only consumer?

No. This is the AC200's external CKI system-clock input, not an
EPHY-local clock. SYS_CLK_CTL selects that input as the source of the
chip-wide SYS_CLK, and the audio, EPHY and TVE blocks have separate
downstream clock gates. The audio clock tree also uses the 24 MHz
system clock.

The AC200 core therefore owns and enables this shared input. The EPHY
driver only checks its rate in order to program the EPHY-specific
CLK_SEL bit.

> > +  ephy-vcc-supply:
> > +    description: 3.3 V supply for the Ethernet PHY analog front end
>
> This sounds to be specific to the PHY, so the PHY driver should be the
> consumer, not the MFD as a whole. That then would allow the PHY to
> perform power management, turn the regulator off when the link is
> admin down, so suspended.

EPHY_VCC is specific to the Ethernet PHY, even when a board connects it
to the same physical 3.3 V regulator as other AC200 supply pins. The
regulator core will retain the shared rail while any other consumer
still has it enabled.

For v5 I have removed ephy-vcc-supply from the AC200 MFD node and moved
the supply to the Ethernet PHY package. Both variants now use a common
vcc-supply property, connected to EPHY_VCC on AC200 and VCC1 on AC300.

>
>         Andrew
