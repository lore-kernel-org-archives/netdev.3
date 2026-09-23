Received: from mail-ej2-f5.google.com (mail-ej2-f5.google.com [74.125.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04937E310
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166684; cv=pass; b=KxeFQZJz33K7yD/loV08B82O9CnhPCBuadUKt5FUUNoLJ2aLTDZI8FPSZolnHkVDa6m0rmsx98VqAzzK/aT1ikP25TlfOdZH64RC+xTjcef9CrS7nkcC5BFXPsY/kjswN7fVG7F/MUn7RtNelJ+91gpeIoPxA150F/cDhGcMHR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166684; c=relaxed/simple;
	bh=N5H/My5yGDkDx9/kp/ToxETnGGeoXC/DTFu6XXuB/a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We2XB0YEVvHNt/LVKW8wXILGdvhsoG2N7CvpgHnWSrvM7iWAVLUaWmn+KcDjxQP/q66wZ5oi29FGlrEkFcV4GwkgYQTjLrJzmC6EiDY1mhsaZnYUxJFKbtI5N62GSunRUlXywjxh0y8yR1s4+3uWA+XyY7RIveAW6NvCX9u5jdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGLZtH4w; arc=pass smtp.client-ip=74.125.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGLZtH4w"
Received: by mail-ej2-f5.google.com with SMTP id a640c23a62f3a-c2950c25486so63231266b.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 05:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790166681; cv=none;
        d=google.com; s=arc-20260327;
        b=VanXEDZsmDjvyMPaWd9ilg8bA4j0ynlDN3dK2c9uiiMMRv9tz0bKqmO2hdxpJmwqys
         LoSbgmqJhZ0X31lBD4gNJOUzT3ZX+3NdWPevFVtKDoLqbKW7Eb5CPJikanuavdpAH+NK
         g5MkxfNwhXqhYo1OKLSFI3norELd0Xjksjcw/k6F038P1kRjTpT90nL6kbfBq1OVT6oP
         WIcAjDq6cnnfpsHcS9izbHE1VHFNgaZ5kib9721MR0xIUYr04Y7bsEiPbKD10HXNM9mz
         h/2TzkDzUWpB75S34xbgpwvq/xhh/KeqfPhTTjGxs0nPsYrgoRmuz/3OFPG640hVhJst
         G9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=geosNIRimRwfO8HRfTW0XaPt8QyFJOsPlxIx1190dzs=;
        fh=bi83I5VVDPUySKncZfxd9UoObBVIzEmuYyn4frFhC40=;
        b=WbW19lryYAdjD6DHm6wZHeQd5CdI9HipvLdTZbf8fTJM2hMwjXflpYc1+4uL7EbXwc
         vaO7f5BV1OblCHPI9KoYnAGDRwqrt2E19H4npwx2VUIrUe3W6j7GkyIqPte/AzfWZqf6
         xCdCUGzB0dALXrzy2y3gRCb2obiY0kIHEajjQVLOPenxLwbfkxHPASVD0ss8tzd+ycJ9
         IWdhTXLhRe9hKdkg0h8FNJFXOxWIJN+XNTrALGNJ+k1O8EM6OsA+5/5cte2rfH7E6g/K
         hP5R00/XA2+LXcMMFz6esJZfmzs2u3olfeFSIMCo9qa6OIqn+SOWYde887G1kfmkJuwb
         m3Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790166681; x=1790771481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=geosNIRimRwfO8HRfTW0XaPt8QyFJOsPlxIx1190dzs=;
        b=GGLZtH4wkgEHP3gt/fuSWbFGDdMIcc6K+AUcRCYLM1E95lE38MtYEUG/kIvD13fmLz
         P4TUqABYomrf6+WZnOWouZXi9EuerYpR1g2nB6Nt4B/TL0z6BSR4bCBUtWjPELJWH/qq
         obaklekAKBAPxnX/RTD6Y9KsZ2g3ju9sXPUJpQ2CeilwTiNwvpGcuBGnC/2Ion7iUzdD
         aiV/L1hPlGWcicr0b0YYXAT6f9Y5WYt9apFYDopXFnkkxOidbN99b7QJ6dWB9/vsdYFP
         vvQkmLbuHOmkV3CljYMSi886E2H6GsnwwWxAJesd4W8/xV1DD+V0ciho/J3m678LnqZZ
         7DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790166681; x=1790771481;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=geosNIRimRwfO8HRfTW0XaPt8QyFJOsPlxIx1190dzs=;
        b=gjhStkuMTzR/pTi9pZfl06yEy9dKClnrKKkjG9uJaC5OHmsBmjPMZfmByE0cgBgPZW
         luLtYu7YGnQLFgT/vesxN3e0Nu+3xyVEIHPj+QluysP/qpQzXv/zuOTMD3OU/3N5KGD+
         qEYEiPbSMPXz7b1lZh2leyFFM+PsxyHPD+LO/bzqtUpOegEorNhoPBKTglJLMagr7Twk
         5qOKB8p52hOUKibuOypGcRh1jdaRbSRJ8JlHMRS+PT+A4ygLXl9MQDieyydlHJUsbrZA
         X9BTm7HlkoSobto1tKs/A8R9jkKmrDQoUMyBA+NdH5oEVIEHkAkDABEC5CITccARkAjS
         lV5g==
X-Forwarded-Encrypted: i=1; AKwUvByl0ofTm6o4uycGOmiCo8DyiAw+A73OUVLM565++CoTtilamvfPNI7JmQV6GCGzfocztjO7Wk8=@vger.kernel.org
X-Gm-Message-State: AFuF++k1+IS8LjIFLr0UK5P90Y0Et9Uud4nHTyt62B3BzrdKq0qoEoXO
	yxUeMuFrVordkUwlasQ6K4nB3XW/kwzc7iagKZZYne5MEfVzHA1a6hfMwRSs/JaXwiEQOO9hQ6R
	zsJCjbIgZdElduEkqJ8kpAEkivYO3vqLzQfR6NZk40w==
X-Gm-Gg: AYBFou1BCkZmqS07P1hml3Bkp38olMyg+K3c1ZKSoxmYY/aODTxuB9ra9gVBgZmkWw4
	pvgCy5wGCaHqdECr1DoGLs1LnclpOkZUaRld3Ep9zJvu5Ch3ipsNRDgAcwmmgwdKJ6a+yUgub8O
	DbB/Gk96uf7XfEpnR1kPzj1ew1JR7V1B1/GpwFGNb0E2GqFVyxkG1LaBhmdHgwunOod4uAkP+Cz
	mFxMEXipXcWVHfE9ouIiZla4PJxg6zSXYnIPvemyf/MJIRO3qMjljWDArvVUQuP8taiJ0RtyHnu
	f2KsKNqllOE8xWYpYkFJi8e0RX1g5h9fUdrHeXyQ3/q2awfORxN3LWHEz+gSXR7mtVcmPg==
X-Received: by 2002:a17:907:a312:b0:c29:f5d8:9c6b with SMTP id
 a640c23a62f3a-c2aadc48e63mr193301966b.26.1790166680835; Wed, 23 Sep 2026
 05:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919174223.2356964-1-coiaprant@gmail.com> <20260922191758.2730da7a@kernel.org>
In-Reply-To: <20260922191758.2730da7a@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Wed, 23 Sep 2026 20:31:08 +0800
X-Gm-Features: AclHuK-NKWB18tJ6bEfQMpRWykl2_zQElAqMu29cCy0C8SHDtVbj2c6Zd_8DHvQ
Message-ID: <CALj3r0gPjraK9wy_WbTkeYD1OK_HhSeMi8bDmk03gOVJUb825g@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: stmmac: dwmac-rk: fix bulk clock leak
 when the PHY clock fails
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=B8=89 10:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, 20 Sep 2026 01:42:23 +0800 Coia Prant wrote:
> >                       if (ret)
> > +                             clk_bulk_disable_unprepare(bsp_priv->num_=
clks,
> > +                                                        bsp_priv->clks=
);
> >                               return ret;
> > +                     }
>
> Missing a bracket, EBUILD. I almost appreciate seeing a human error like
> this these days :)
> --
> pw-bot: cr

That's what I get for hitting send while my brain was EBUSY. Will fix
and repost shortly.

Coia
