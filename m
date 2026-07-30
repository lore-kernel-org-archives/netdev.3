Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B840F75B
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411554; cv=pass; b=VqDDD7paR4YbE2a4iij7Rtsz7IfMFlsF5uWz9o8A7xKsU+HihaB2z8Z590SJ+hXEhKd4P7sHH+FthTQ+qBCFMdCflfi79VzZnmplPURCbdFjE6AZz8WnrCRmXZ2wjm6/YjnAM8ItgsQdTXsC374tTINuyx7RPLB8aV1EwWkHi8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411554; c=relaxed/simple;
	bh=ME/is5f2x3bVVRap9DaBRmHa3BSV8SR739rjkJab5+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDPVbW5oo27rFWlqFLnu9e/AXjZnM2JgGgxqZ9njZzRfGyQsDEMErWz6EdYKK+8XSeSW4/RIBHi3OQvroTmlqDvXRNWQFPjlFPpJevl3cZM5TPuCUWRoOLbtHHTIWEWp74jFAjw8fcDXWS3gJMJgBuLgdm1MdAWO9gESv6g+C7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJfnhqQJ; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJfnhqQJ"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81e83f1f15aso9491667b3.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 04:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785411551; cv=none;
        d=google.com; s=arc-20260327;
        b=F37NXhsD6G8HW4MnEm7FCT6hdrVTkjXdcTWOZWG+T2n3JCNEoYrYXcqs0zJ5WAjnby
         Q1/jFdEOPknIxRXjRyml5DxfUNr7FMwuY2XvEPfztuCqXJq7+Nn7+I6EPLgdp++h785h
         mfjUGSZHVtY3FwryqbjatbldmXczw8plz7K9uVwtUk4x8sxtS4PjXI0Bt6ZeRmJ5GYcd
         8xKPOOlv/F1tIpbbbhyYliNdWgtBPH4yOpQc1lb1Sgns+BW6IePq8viM2rTxVEVWDXvb
         rDWVJokGawnpZ5fxJ5tAtgUx982XjFCZJ0lTh0LQcZnI+Q4MVhriMKCpa14bbcvvWKxW
         ajow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOxhSnayK8QxbrD63cf2oNZmoFkPournY0d5EVv7OdM=;
        fh=43WiJAr9XiyI5kESp8buCk+7ZeICX7Y8hTWetTtUDAM=;
        b=sFIMYXJlcBwqEU25XUjHOzjXeN3T99SG0n5l9FP+bjRvwhGj3ew9APEH5PY6n7s6TH
         w4wyVW/Fr5WFVj7NsZFBGoF3jmdDpv3JtLdVbzWAniEF1Vg1c1yw8MqSnEy1Gkz8ZCu2
         o9lcA0hZoy/CKn0/MTGxTc2bSdSHYmxr3ccmk+eDePt1QWLZOJZL8U27Ruifm8VMTOE4
         +Gs2/GI+AHjbHT4kx64rf/PHoqomHWwpxHsI1e8p2ChjIw5X7O5jiaVQ1sUqkoQcCWXQ
         SmOLCgpiaEm0yqZjwChAhd6VRU4vUb0yttfHHF7plLdhsVnkOebamMW/w7NwKFEh1Z8c
         IK5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411551; x=1786016351; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GOxhSnayK8QxbrD63cf2oNZmoFkPournY0d5EVv7OdM=;
        b=KJfnhqQJAQUxSf/WQlgztU6OSmEeLNUeLCYZUi1pwpKyxtzna0dHGSsn/l7yOkp5/A
         C5cf6NKBlzFw/D6CsZ21W+xWPLhV27nupmlafuusDrBt1vrYKsi9mFc9kTabiuSa/skH
         ch/aZCLAP438wb0nLzLFhmJs2KrDPcK37QqxU4hDcH1NkfO1BeOagUs1ynkEQYGJwxab
         jVgEDhlNL59sgObpkrF6n+Z5wxuteQ5FB+yuhw+VgdDXgG2ogCQ5qA/JSA0/IGUWv5Do
         2i2LSxURvuNWRVXVFDjH8AA85BhhIWQxIXmq069SM1kYtiCb+6LOlb22IW1LRIUJ2kRq
         qNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411551; x=1786016351;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOxhSnayK8QxbrD63cf2oNZmoFkPournY0d5EVv7OdM=;
        b=faUyAu90euK20hAxN3xln4JmyuLTml94Igbdgjk0RjtlTY/DYDrRypejtQ27Bbs8MF
         Drk0eJ4ruAoP9DtJsPPK7zwKmVx5uovdRAZv5W+WQu5rw0Z4JX6/o9u//oneZD2U4U6d
         sQBJv/SyrLa3UTMzU4sTPfhxCRq+sfTQZWo62+AoXUrSaWkmXyg9Sg5LWJJMEYNpzD4V
         hppQmJc/XFCXO+T2lw/gq8aOLH8dqh8DSoe2Knk5z743dC3RtPt+PmqIgGCfZ0+hUbuu
         rfwgOaTu6Fmv4w+l077oJ5SmZVaME6W15pfWwzn8/bC0m1SdU7K07WIFF3A3X7EQlC20
         +Dbw==
X-Forwarded-Encrypted: i=1; AHgh+RovEjXjTG1/Gv+taEFuwYo6sbH1X8UqFb7eZASa6N8JCKlrRey/CoYYKj5CgtsrjDI8i9IFRgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhcR9EbckNYcYA41zgeWrJ6c9utqxlRFBLCrw62jrgS4xTI+qe
	H/WyxfxorbUBjv64E5ljwIrW7TNQSzewF12nfSyix8eB9S3PkKT8xA4ky/QvXgnLspydfOfcA+t
	R2LZ5jbJdbAsoZBuc5xdU9744S594Y5I=
X-Gm-Gg: AR+sD13H3zhusBU5w8VImol3RUPOrriW0A+ukvIoUEf9ZKRNz7+sTPnOH/8bmht37PU
	w6VjifVTI4s77LHxEYm6vd1zj7akxX6oSSn8qjKCH0eGDV8L6t+fOCoeTb7Cr4VbrGNwkg5mdyf
	R8J/DysKdGHmiMlcL2tSENtKegHzzWghowo2kHC9p1RmSYTJXFktyK1bmCfqTzMMB4kgHWeo4Hw
	TSaOS0/7z7eHIjmD9Z5rLmvttMwhLm+fx1wBNQkgDJCIgDnti1aU96cZAnErPSzCRtyoQWBJK2l
	/I1t7RPDD53PdCEk+P/T3vXaVBvr3Nc3rMnAdxM7EjP6
X-Received: by 2002:a05:690c:6b01:b0:7fd:5508:b2dd with SMTP id
 00721157ae682-81fb97f7a2emr12051367b3.22.1785411551310; Thu, 30 Jul 2026
 04:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727021048.3375444-1-attinagaoxu@gmail.com>
 <20260727021048.3375444-2-attinagaoxu@gmail.com> <20260730-lucky-strict-oryx-9ce8de@quoll>
In-Reply-To: <20260730-lucky-strict-oryx-9ce8de@quoll>
From: Gavin Gao <attinagaoxu@gmail.com>
Date: Thu, 30 Jul 2026 19:38:57 +0800
X-Gm-Features: AUfX_mzaCwnwh8yAtjVvunPNaTB-XiGKKcyJxT9ge1AJjv97-ODm4c4wF7ehf-4
Message-ID: <CAK2JjQVoaHjzf4Z=_LDVzTj0R-ey1Z4T+1OF_xYACdz1C4yReQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: rockchip-dwmac: Add 25M
 refout clock
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, richardcochran@gmail.com, 
	nicolas.frattaroli@collabora.com, sebastian.reichel@collabora.com, 
	sashal@kernel.org, alchark@gmail.com, chaoyi.chen@rock-chips.com, 
	amadeus@jmu.edu.cn, rmk+kernel@armlinux.org.uk, horms@kernel.org, 
	alok.a.tiwari@oracle.com, david.wu@rock-chips.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:27=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Mon, Jul 27, 2026 at 10:10:45AM +0800, Gavin Gao wrote:
> > Some Rockchip GMAC instances can provide a 25 MHz reference clock outpu=
t
> > for an external RGMII PHY.
> >
> > Add a clock name for this 25 MHz reference output so SoC dtsi files can
> > describe it separately from the existing MAC reference clocks.
> >
> > Signed-off-by: Gavin Gao <attinagaoxu@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml =
b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > index 0ac7c4b47d6b..074ac274f2e0 100644
> > --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > @@ -81,6 +81,7 @@ properties:
> >          - pclk_mac
> >          - clk_mac_ref
> >          - clk_mac_refout
> > +        - clk_mac_25m_refout
>
> That's the same as clk_mac_ref and clk_mac_refout. clocks are not
> outputs but inputs, so explain how does the device take three SAME
> clocks: clk_mac_ref, clk_mac_refout and clk_mac_25m_refout?
>
> Best regards,
> Krzysztof
>

This is not the existing clk_mac_refout clock. On RK3576 the
REFCLKO25M_GMAC[01]_OUT clocks are separate 25 MHz reference clock outputs
intended for RGMII PHYs, while clk_mac_refout is the existing refout clock
used by the Rockchip DWMAC binding for the RMII reference output path.

--=20
Best Regards,
Gavin Gao
