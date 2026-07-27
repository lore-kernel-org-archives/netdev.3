Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149AC3DCDA7
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136475; cv=pass; b=NQp2qMjpJd9IM6NTsiZC++1zwa/ku7Z+mQz54eOeRXc01+jOd28qyMsteGMFSv8fhIPJmKIx7VMrZNWfe3AAZA9vxvPISn4iJzl5ckXa1QhWVMj8AGZU8Vuq0LtJSa5FZbCGOAwIY8ykRy0uwf9tWP90bGaZt++djxv3sLADXW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136475; c=relaxed/simple;
	bh=6DQJFvDiJ28dVkS82oPqp/ycFEM1kxGwvdKytkDLGJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VukJ+gHCPaX8k4hfjURIhAsqJdr6iLXnB/z7MmNyVWKtqQpT/6RZQyeid2UmxkJqHcxN1Cx/TrgNiF8cSfMZoKYaj5t8Bh6163/mZi2CljXjC2cXlO2MxUq9Bpxnm5GrRFjjuiizmHY6sAq7aX0YtZezepLaA8O6arI+2FgSw54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeAO5kro; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeAO5kro"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5d6f35c1so203774385a.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 00:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785136471; cv=none;
        d=google.com; s=arc-20260327;
        b=gEF13F2cjU7mt83HRuFz+jY2UB59kHbUe0P3FvkPMfRsokYjqiDho4Rp+MH5alKGuv
         5rfKDTIhX1AjN+0M4GHgBpcuisWLpS/uIfWim3kyNrXozxLg5Uq2tIRYWCdXeYhM3SRZ
         PbwGbLX10t58VXAvYPZQyK6mmbfKUvAA7K1RlgUjZt8q78ZDaxFxWdH2sS5nBbQvVUEx
         gNq/VJdufCiWBpfJmIjCICFXKuYZS3gn23+tf8HLcJesEtdHA/xSNlPK/SkCa4Rmbf+2
         CsnRBOcZcFEW8v0KsIcqVceQo5LVLc7rtwMh40oeH0LomteHH1fmrzopMDSJQmzyB/5y
         n+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+/mmi/yKE1XX17GxFkgO2afry/vumxMd+JoqMLh+sdI=;
        fh=fOX9hR5z7dVD7i5VshHMhn98qEMwoVZ7Q2iKUqWn7dk=;
        b=hvEZDoo7XJ/oyczz1kU7UFo4xPYPz1MKYLuzNfnDpwKDyx+gU0KI7yfM1JiAcHCc83
         clwcnXXTSPe+UpOkjgfs6h41V3pejyL9aaAlwcdbA8PutKGbM+m47GbteV6E6IJXITuM
         3k8qGPK/ojDNRJEXBCAy5E8MnNY1cBYdDG9h24AVJdgwkgLDeTGo/zt64SvyjNL+AR3K
         U4BX9Fnq6WDRhLEw9RrJrEfY0njJqoaTZIMVcCnF8jxIxHDKuxWQTGVSmHka/hNbyQz0
         EnQ1y4AmOgparnUtRUr7F1vY4rLsFmZAW+N+7anW6yTRNLFiEhLg3MhX+q9hkqzY0mZS
         LuuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785136471; x=1785741271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+/mmi/yKE1XX17GxFkgO2afry/vumxMd+JoqMLh+sdI=;
        b=HeAO5kroARxCWgCvOdv52davu2OFeefaVb/kJr37JGMvWxCKIwsbr3/8vxwRc5OOVf
         XXd8phVPq2CS8E826SfCFzQCXvROTppQjcD3hFUXxkVrx56t2UCCD+ysWQ30PgW+HhxE
         YuWcYHJCSjrOhDut0/k7H+9RrBEDzYoCaBiDYFcT8PDyc9bG8UoS0AAq45a0R3872y9H
         qEksfrZGsFRwf88id4zAAYooJ+J3zIiRQss6QiauUGacdF86lSHyFPxcfakGYZLbYr6b
         OuFeJE3L5DW0aAxn0YWx0idzDzYRADS7cz+g5qPdJF79SOUE+y2l9iiloAHyRVysBu5X
         hHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136471; x=1785741271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/mmi/yKE1XX17GxFkgO2afry/vumxMd+JoqMLh+sdI=;
        b=lvxW5fIjdEzxaQR95X2lK1yIH0F0RqsUgR3JnfDVtZB0M4tcu5+9k6/57mMin2M+FL
         O4Y0QDcnoLJ4DFmfI4DgJp0CUEmILogJE8CrNrhvmohadXjLK/GF18bOXpsABp52ACSL
         gSfb224TAiw6dksQum46owsoXyNH3AHe0qRr4Uk8TZjU3cwz12CwlS1wgFLlttECj5yy
         QtvpwEGTXgcALjlS9BGsxnEmP4W3vFwRU93zcFFKpNTd8vv1JCO5HsU4i2McItsdg7u/
         KTbRKHs28zPKgmE2eWIjAz8N0lwF2YG+tsRq4DNBmMwnQbfsnMlx+1tFGMU1bx0hNlsG
         3CjA==
X-Forwarded-Encrypted: i=1; AHgh+RqU2dSM0LkYv+FfPIQnaDoV5E2P6ultgEO9qzZr7W6jKl/EV65QIZrZ1nYbtoWEFFo45HJNlTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJpycx21UnadyUPXtWxGC+UfU5jWD/fx9N92ObmlR7Ktr2OfRX
	tI9LAIuPpHGpoQ+Qj5LgZA8cWXfaLe4b7aiQUDzreGbFbIDINDoh/QJKbDVEk1iXDRoYH2SJjhF
	f4mfCAJeP1P9XdzBqQ8B8eBEqLHoHPoA=
X-Gm-Gg: AR+sD13+yOV3QbWPYP+81iTaPu/6WmpmnKcysvJbl/+FSiU3bfsuTnZyRK/dykMaDn5
	eZb+Og9blCgfAyrPPuPPLFQPQ0QtP6oNCNhAZ7REiWXENAYhmh0iSgaKT6kYSrFvmgcZ6BQaU2C
	P9zAWc9hIYhUNiJhMih5VjmKWOiUZd73afmGAW3+Uokuj751sEtYdKe3xfBX8ZtoqRv7Dw7BanZ
	REFBd0tDq8sCWUDL6Yjwjuv96K5DbiPBmC8OVPFxWf/PWFWJkGJwGip6woxQtbvpyywbzk5pzcC
	oREt1lFkCywL52WrKg==
X-Received: by 2002:a05:620a:271c:b0:92e:c118:18b0 with SMTP id
 af79cd13be357-932df725cdfmr696946585a.79.1785136470873; Mon, 27 Jul 2026
 00:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727021048.3375444-1-attinagaoxu@gmail.com>
In-Reply-To: <20260727021048.3375444-1-attinagaoxu@gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 27 Jul 2026 11:14:18 +0400
X-Gm-Features: AUfX_mx7QqYbJPKColdFHefAnfy7L2wNcFUU2ZgtkbVju2YipXpKoC8heF-3qZs
Message-ID: <CABjd4YyohxfbVufd1pwJGsm8a8f3Cm6rJiz=WLz=jBjAQRLj4A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: dwmac-rk: add RK3576 GMAC 25M
 refout support
To: Gavin Gao <attinagaoxu@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, richardcochran@gmail.com, 
	nicolas.frattaroli@collabora.com, sebastian.reichel@collabora.com, 
	sashal@kernel.org, chaoyi.chen@rock-chips.com, amadeus@jmu.edu.cn, 
	rmk+kernel@armlinux.org.uk, horms@kernel.org, alok.a.tiwari@oracle.com, 
	david.wu@rock-chips.com, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gavin,

On Mon, Jul 27, 2026 at 6:10=E2=80=AFAM Gavin Gao <attinagaoxu@gmail.com> w=
rote:
>
> Hi,
>
> Some Rockchip GMAC instances can provide a 25 MHz reference clock output
> for an external RGMII PHY. Boards already describe the MAC clock directio=
n
> with clock_in_out =3D "output", but the dwmac-rk driver does not currentl=
y
> request or enable the corresponding 25 MHz reference output clock.
>
> On RK3576, this means the REFCLKO25M_GMACx_OUT clock may be disabled by
> the common clock framework as unused, even though the board expects the
> GMAC block to provide the PHY reference clock.
>
> This series adds an optional "clk_mac_25m_refout" clock name to the
> Rockchip DWMAC binding, wires it up for RK3576 GMAC0/GMAC1, and enables
> it from the dwmac-rk driver when the MAC is configured for RGMII output
> clock mode.
>
> The clock remains optional, so existing device trees and SoCs are not
> affected.
>
> Tested on a PicoCOM RK3576 ACP board with a Motorcomm YT8521 PHY.
> The GMAC 25 MHz reference clock output remains active and Ethernet works.
>
> Gavin Gao (3):
>   dt-bindings: net: rockchip-dwmac: Add 25M refout clock
>   arm64: dts: rockchip: Add RK3576 GMAC 25M refout clocks
>   net: stmmac: dwmac-rk: Enable RGMII 25M refout clock
>
>  .../bindings/net/rockchip-dwmac.yaml          |  1 +
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  8 ++---
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 33 ++++++++++++++++++-
>  3 files changed, 37 insertions(+), 5 deletions(-)

Can you please try something like this [1] instead?

[1] https://lore.kernel.org/linux-rockchip/20260719034555.3623003-1-gahing@=
gahingwoo.com/

The GMAC on RK3576 neither produces nor consumes the clock. CRU is the
producer, and PHY is the consumer. So the GMAC driver shouldn't be the
one to enable it, nor should the dwmac binding have anything to do
with it.

Have a look at how other boards already upstream handle this. For
example, the RK3576 EVB1 uses a similar arrangement but with a
different PHY.

Best regards,
Alexey
