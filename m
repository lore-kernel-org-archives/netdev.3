Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1AA37A4B8
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285471; cv=pass; b=kY/xj+gM8NEGgC5qzz33KXQf/ALt8n2mhL27BNDJD2RmLK2fS49kclg2FZP7kzmfJ4jZmAJa+bfpGNwpVRjZ94Tl4RSJquVOmiMA3uIUcMi0JqqkQ7gxRbotvCqbnc8pBry/lx5DdfwrjOv7c0V7TZEE/WAhbMGgmkS/8mim/RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285471; c=relaxed/simple;
	bh=wtMim/ZKUUVD2LU1q4V7ckwd7xbQrB5ulh7CVx/7A4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjfLQCRksB+ecakQaAzPT6w89XCVf7LRZL+lj0AQ/yE6ubkMcKjN0atKM779jMpx2OQCFu+Dq7Jze6o+u1ok/E1rIDkZUgwUx4fXWVohZ346+bn+SOTkK0WaTV6cjwTXfPFAWOZJZ2/VuVPwIfSFKMUFR8+A2pO6atg2Zm9eymY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flQ5yOkO; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flQ5yOkO"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso2050844a12.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 03:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784285468; cv=none;
        d=google.com; s=arc-20260327;
        b=SnARfqlpkIM5foj04D9LsRx010YDeqhwpb5b5yo/XTpN0qS1YNORhCYgLaiGO59FdB
         3igPQiZzYaIktGccK3IIjkRxS7fEOhiv/2tivMw+pgeGwj2k8IrsKAUpU5EKHK1Hf7Sz
         9AYsFnD1uxUqUeSCBiFeSoAyLcI5qEraw8FQI9bKY1Ok0scSKO3ZwRvbnrh9IzJaOpBb
         lr2sxVOMPps+8pM/7S9Jk7GLVLP+N+gGXi5BGmA/Zyw7BMK5XAN94D+KSDh7w6frlc7H
         uJUxGbCRG3DsMupw2GlAUT8H3t7tK5ioLLsF9wjYU2/pDzb65pe9SrXdO+77Bmk26HWY
         Ia1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wtMim/ZKUUVD2LU1q4V7ckwd7xbQrB5ulh7CVx/7A4E=;
        fh=f/HpzX1Hlt+UikSn2sUj5kE7gWLvEFd51CP77kqHZNE=;
        b=ecsoGzSheUbOjE5JeM6s6gmlidTAKu7a/eZcolMdqUDXjUfgugo55XoHqxLUIoI6w5
         oLJe5g6ZIyMKtxf6bS5/aI7+nsomGEdSKOuKQg7X3KYPZN/kLPAP/DwrwtaZgcu0ZJhh
         /K4evL+/r6cqpZp620F7FmNT+lTRhQY2zC3FjY3uFOl9/fsbXCbbCppWUVsRPuhLtPbP
         s+5hH5krO+g+liSQotecXTFJ3RG81laOV0hFExRY7QdXPtw95HuMYNy4Rwhs1P7GpzDv
         4r4TJvy9j1yw/Y7ono6l3oXWwOgV63ARskcJ0zR709jsv8ZS7Ydo/MSJKdIMhY6KNC2P
         L8Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784285468; x=1784890268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wtMim/ZKUUVD2LU1q4V7ckwd7xbQrB5ulh7CVx/7A4E=;
        b=flQ5yOkOMsWdZNWpGQeCGk6fCVE/JY0nswtMP/Rvh2buK2RNd/Yfl8BHnkooiwy4Ua
         pTyGyHiW2qKQsfBOGy/FgraKnR1BG2f7io3Gm1+sPLUHQ21XPj6j7LoI/H31OQjqSSFC
         EosUgTqhMFWI9knpzmMG2nI+9GDNY3wnC+Es/3yvT0fQsBmjEu050bHIZ61g5Ccyvwwq
         dRJzijCI95noeoNuDSZFEB/yx6DME6zkqUj/Q/ng5ombYCQBYY8Z4sLFLkavBoGGjYGx
         32kxfetjTSRHqx+NCYw7CKTbdOTRTfqVFWdR1nIwMINHIqejFtb236/WIc5OCNadvKae
         jv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784285468; x=1784890268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wtMim/ZKUUVD2LU1q4V7ckwd7xbQrB5ulh7CVx/7A4E=;
        b=bjqX64fqKTfqiJ/12/f6ZiWgl9qBEyLJLpsKIES0tG9K+vhqc3IEv+xJHr/cfduB37
         xgIYDjqdF9up5IjM+dVjD9ypCB554kBOjrvOePPopAEu21fAj74r2zslzSwvEvhkKrJ5
         +JD5Y6zrnWuX7ezbqsu7C8QYuUTpGPPOSsMSkOUQY2c4qX5gOc5XzC6j/L0Ybr6rxoti
         qQAw721NlbxWjHPQjo+g3gVznUxQ9ZDADTOpkXh7fodcF5LD7YC5cKrA5b0hBmnle9V9
         14rF27iSl+7j1j9OO0ijtmdbQ+uIDbkvkPX3mYNnfL2P0oSjA3TvzKnQjhaU2p9PBvzF
         Ne9w==
X-Gm-Message-State: AOJu0YyLKgd9CH4YiB6sDSNB++z1c00gCzl35PxsBWo3+6pKo1n61o/D
	na0ExsuIzUuB0EmtzXfVSX7iVOcKClREvh66xseAKvzS141CJfOpt9iXf2o3Pm3CZ4JfxRBnmab
	AfCe9BdV75erab0FJOOHDSa0vCg35QeA=
X-Gm-Gg: AfdE7cm607pzTH2XZnu8wq917Xwl54CMfhMXehKONTHzcGkCia0FcVSMpJCwhh89Gp2
	1JkD7AefrbQAO/ytWVp2BWODNVo13g7Ccw4kreevlCbf85cEYLlMPQRTLHcgpM6DIfA+RS4E/tx
	wpQ5sdXFCBqsoz7taqMVQTswqJKRp6XffEQMw9CGTpCa3LjY4BtbcdDD99010epCNi0j3g4IE4U
	ewjPTv+B/gW1do81gLOt44r27jZyIZrt04q3O+fTWNWwawYORhGyTgPKbJDaTI=
X-Received: by 2002:a17:906:4fd5:b0:c16:64e3:945a with SMTP id
 a640c23a62f3a-c16b41370ccmr92556166b.25.1784285467779; Fri, 17 Jul 2026
 03:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716173325.653164-1-a.shimko.dev@gmail.com> <77f1cc14-cc5f-4f32-a972-f0350a60931b@bootlin.com>
In-Reply-To: <77f1cc14-cc5f-4f32-a972-f0350a60931b@bootlin.com>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Fri, 17 Jul 2026 13:50:56 +0300
X-Gm-Features: AUfX_mzSmKf21HSDXphC1gph7rPE_T36Tux4M65Qywsv6eC1VFfF4erCVlhOaJ8
Message-ID: <CAOPX746tZcytWVq-LqE166j8hoVNrndZfZGAgnhiE6Ry_BY8+w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet PHY driver
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Zhi Li <lizhi2@eswincomputing.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

I could suggest a couple options for how I should handle the driver:
1. Recognizing that this is a problem with the PCS layer, I can remove
the inversion from the patch
(but add it to my working project as a separate, non-upstream patch).
This way, we'll just leave the delays setting in the driver, which is
fairly common among driver users.
2. Leave the inversion in the driver until some future common
framework solution is developed, and
then adapt this part of the driver to that solution. I'd be happy to
help develop/modify that framework =3D).
A packet generator could also be added to it.
--
Best regards,
Artem

On Thu, Jul 16, 2026 at 9:11=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi Artem,
>
> Please slow down a bit, you need to wait at least 24h between patch
> submissions :
>
> https://docs.kernel.org/process/maintainer-netdev.html
>
> On 7/16/26 19:33, Artem Shimko wrote:
> > Hello,
> >
> > This series adds support for the DAPU Telecom DAP8211R(I) Gigabit
> > Ethernet PHY, commonly used in enterprise and industrial networking
> > applications. The PHY supports 10/100/1000 Mbps operation with RGMII
> > interface and includes features such as IEEE 802.3az Energy Efficient
> > Ethernet, IEEE 1588 SyncE, and an internal packet generator for
> > diagnostics.
> >
> > The driver implements extended register access via indirect addressing
> > (registers 0x1E/0x1F) and provides comprehensive device tree support
> > for RGMII delay configuration. The rx-internal-delay-ps and
> > tx-internal-delay-ps properties allow precise tuning of clock delays
> > in 150 ps steps from 0 to 2250 ps. The optional dapu,tx-inverted-clk
> > flag enables 180-degree TX clock phase shift for boards where signal
> > integrity or MAC requirements necessitate clock inversion.
>
> +Zhi Li
>
> This isn't the first time we see clock inversion being used to overcome
> RGMII timing issues, for setups that have too big of an internal delay,
> see [1].
>
> I'm wondering if we should either reject this on the account that this
> is bad HW design, or embrace that in which case it would probably be
> a good idea to come-up with more generic ways to handle that.
>
> This patch proposes the "dapu,tx-inverted-clk" property, while Zhi Li's
> patch has a dedicated compatible for that (and inversion is on RX, on the
> MAC side)
>
> If clock inversion is a common thing for MAC and PHYs to be able to do,
> should we add some way of representing the RGMII delays that are
> introduced by the HW itself in DT, and let drivers figure-out from that
> if they need to resort to clock inversion to align clk and data correctly=
 ?
>
> Phylib could maybe even provide helpers for that ?
>
> [1] : https://lore.kernel.org/netdev/20260707064159.1299-1-lizhi2@eswinco=
mputing.com/
>
> Maxime
>
