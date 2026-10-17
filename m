Received: from mail-ej2-f8.google.com (mail-ej2-f8.google.com [74.125.228.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C53E51CC
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216324; cv=pass; b=Mv5DhHoPp3gXQm5yXIvfO+8XtzkIs9ysq9J6pQxBTXol1TH5nwpGSiF2ML9lXI/z0/90Il+10M2hW/Ma2+RI1Fsoh2PpXTNn1bsvqPvO8ynzyOpILmOfBz/1acPhxjT53Ld5p9OIhjZFbg9hXFM8eN18rYtxH5BdVDzRC6frSxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216324; c=relaxed/simple;
	bh=dAGUxU7S2OS9o0qphDYnHj84WBQWlXZXMIpBTNhn7O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrFbiTHfJ6hSeIzP6gMQh5fBoyhEH7VrQxs/u8ezNw/OTuvDwbKJcO/u/LzHpUnfkCH8nHWr15OoRKXns9nm+hshi1Q7+98AbfuS4gx9Ftk5eDBBAUr25SqT7SsAbpCCCDfZhtX5CwX2Ps3Dct+L4KEYnIrKEv0YxWBheD+SN98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTIcAt+/; arc=pass smtp.client-ip=74.125.228.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTIcAt+/"
Received: by mail-ej2-f8.google.com with SMTP id a640c23a62f3a-c2e790c38caso22091666b.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792216321; cv=none;
        d=google.com; s=arc-20260327;
        b=A4CGaRylC58Bk9SOSXsg6dJQ/1a+G26zgxJ3o88sNIVjSjgCQxQ+7F1JagWjJS9i5t
         93KD43gM5DKIrppzKbSjgyfK6XEbyU4z3mted619xMjLnuhapZunQF6gNJyKnCa/1fsj
         adVPGR65ZXV9ii4zMgt1Kwr1wYt7I6pUPXbmJSZdZcJu1ZNREQ900AxEP/nn9O5ES44+
         Ftui8b43EmI0P+BK0VsvGpP6rZxbwnW7dvA4zJ3ckC3+caVEHUIvExldTLp9NGbcNLR2
         9IpsLSAJbKgV0fBkw5zoPo2nI6xHPqdvX4EMGbQ/7wbndtEg2FaC9UGWStrpw1kfBWpq
         aB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1NQoVsKz0LnNjJ4rVcBhJaqVhtFod/04Q9AhzSfJg/Y=;
        fh=G9SjStp7gDO7RtC0Gn5/CgCQplLvVOyDTHXSA0HY+c4=;
        b=K3rI0koQvpOGijowGp6VsyajWCX5RI0bsCv0ZiqGYVwwU3jPAFS+9gkox9MpSBV/+H
         oa+3URS1IvSFa5MoaNDSnxwKUO0+8czu11izF3/rMvFj80vMQpe8mOCI3b86q23h1Iu9
         bsvtSoKT7x/ewqj7evT/OSXsyKFvLkpyvrMXAmUSDlCj0NyzHbvw+GD1O7bGB53kxNlD
         QR1/l96aV8cLW79XLFIOdt6ftEcyU/vXdM1bYizJ/jtDFePqxj0ds6PgdkHgaD5PR+50
         0r+o5mn0dFQeaM+Ypk05ZLfZeQuw9eJZTWP1v2YhU3RnScP8MDlapB5VuBQYE5k0fiJ9
         qkPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216321; x=1792821121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1NQoVsKz0LnNjJ4rVcBhJaqVhtFod/04Q9AhzSfJg/Y=;
        b=CTIcAt+/DjtvuOUNJ/C8+B9Ul4Pfgo9Hd50liLLvWB9X9EcIhi2mqhlrzQtpDUdFVr
         AOSotTOXeJZWdUufE3JhQM7vxV9lTtfY/9lav8VkX4jaVTtbp83eH6/enwqquVT/A79D
         uUL0G72MNM6IQqZWuWC5WRiYtUbIE3U41j9JMCd4OETLzkwO24p0deL5B0nEtG3bJWHn
         waLXY34d+3Gt0pJSmTSGdKa3p31xn+w71x11gJHqZOyysc9qsbTjFLYWJibflIdzHULU
         zCcmw057Fp3ty5bi/ldnjxYOGRwo/LFQOMEa0iCqiu/ugstznCZkuMXKAVJottIHq0eC
         1k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216321; x=1792821121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1NQoVsKz0LnNjJ4rVcBhJaqVhtFod/04Q9AhzSfJg/Y=;
        b=cCe3IqdLdOi7AMB0Ccby2NAxqfxl3VzJBe38gShTH0i1aYjAH4Xb+nm2o/S3kLMU5H
         DZY3PkCg8SX9ln9MeLzLuMWhLvDDRFYEu24cBhp8FyxqK1guYc1CbIANTHF88GWPGFsB
         tOAlMyk4wf6joqZectUqeIWJWBD7Y5UAnXlpSHrQomA4Xul3Vuu+FFLUsX6tJbNp4M35
         nwadTt44tLPMGOBVQ6pK1MJdEUzqH2ER1I3Lu4OQbfuJMqMAdX3A9+2XvMJhu1Nq21hm
         1NZ3vF8auTjSb64Ok/xN3hQ4GWDoMojP8OIxxBhgVcCi9X/gfI2P5yTpDMokwubeRApZ
         FOOA==
X-Gm-Message-State: AFq9FYIr8lPJOup/LxAefrw7kdtAwoCRGr24IzQDZfDIdLD1uWRNuesS
	m4fTvl7QKXPytxWmvjzE4spnLjgG9xn76f/DIoDCrWov82AV4G3C9EGVY4rcR3QquuOomirCx6H
	sfKtoxQTnJE9Aw2V5I52SNFtfDb65F1g=
X-Gm-Gg: AYBFou0wAufOtclkXeuWSXlII/82ufs7Ba+PBGpyTw0tkFqLguXHl8LH1dGC6gDPxsB
	W6P18oA+CyIQTmiEYGSKDY2wz3BX3RK0O9MSFpMdy3FMAJ5zuy6wdKtT231zzOlvh4tYdQmpoCN
	xjn8hK54XB3gvpJWqmS4d2BrW02DbbMq9DkEyhZTp/WmI57+riQ2YuFnqSCIJ7+csEns73jA1Hh
	GF9j+nCLtvbsQoE8HjFLuiOxp7hHZQh+C5z5W/EJbfwdEqChYIfZ8QBh7qg+J9R/j9G8GPeXTPj
	Ni1LDOiqe47STSmjxW6oD+Bc+LB2qkohga3XILE8ETdMeiRVl8LVTGuHGQ==
X-Received: by 2002:a17:907:930e:b0:c31:8c48:e18b with SMTP id
 a640c23a62f3a-c419df3d9e2mr123713166b.14.1792216320815; Fri, 16 Oct 2026
 22:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008175225.3375274-1-coiaprant@gmail.com> <20261008175225.3375274-4-coiaprant@gmail.com>
 <20261016163709.00cc7c12@kernel.org>
In-Reply-To: <20261016163709.00cc7c12@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Sat, 17 Oct 2026 13:51:48 +0800
X-Gm-Features: AclHuK9gR2DkSi4xw_m2fA1Jz76Zlk0PlqVhdG4GFOV5ZHbiAG1eg9HG8sAydCI
Message-ID: <CALj3r0jc4GECe=Dp_gngTsVL03YmXhAt+BSQJei4QRrwLRrerA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 3/6] net: pcs: xpcs: add Rockchip RK3568
 platform glue driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	David Wu <david.wu@rock-chips.com>, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8817=E6=97=
=A5=E5=91=A8=E5=85=AD 07:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri,  9 Oct 2026 01:51:57 +0800 Coia Prant wrote:
> > +config PCS_XPCS_PLATFORM
> > +     tristate "Generic XPCS controller support"
> > +     default PCS_XPCS
>
> Why the default? Surely there are platforms with PCS_XPCS enabled
> which work today =3D=3D don't care about the new code?
>
> Linus is known to hate _any_ new symbols defaulting to enabled
> on olddefconfig.
>
> > +     help
> > +       Generic DWXPCS driver for platforms that don't require any
> > +       platform specific code to function or is using platform
> > +       data for setup.
> > +
> > +       If you have a controller with this interface, say Y or M here.
> > +
> > +config PCS_XPCS_ROCKCHIP
> > +     tristate "Rockchip XPCS controller support"
> > +     default ARCH_ROCKCHIP
>
> Same here.
>

Thanks, both defaults are dropped in v12:

- PCS_XPCS_PLATFORM no longer defaults to PCS_XPCS. There is no
  in-tree user of the generic snps,dw-xpcs glue that needs it selected
  by default, so platforms that need it select it explicitly.

- PCS_XPCS_ROCKCHIP no longer defaults to ARCH_ROCKCHIP. DWMAC_ROCKCHIP
  already selects it.

Link: https://lore.kernel.org/all/20261017054406.1828061-1-coiaprant@gmail.=
com/T/#t

- Coia
