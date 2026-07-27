Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4762BF3F4
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136764; cv=pass; b=OJd7eJ4BMmh81wMdlay93qcJptnZbn9WRNMR2bOTtA1W0nx6gJvI/l6NVcMClZxl8JG4xhbwtT2jtjPkmYRlI2TzrKG9g32QqunPdcjOFVwj2WSyMnG1bXI9+EU2WlX0Jm5EP4VDJTg8H1L5tUK10sQwNgHhpkwHUyGEV9mRqvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136764; c=relaxed/simple;
	bh=3s0ZWapk6CSKQG7LinS/fqM/+LO7TASDUFIgGuAFciw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzgmMUbdtV/7Iow8FjxrlxHXSSS99Oj2WpBhFNwzo7vp88+TNL2VQIOteClUtRPyZ4XPDEPL10OZED5Lilgje3G/8Dm2zTpzhYFLTT2Mtf967VTL3ejDAuJ3cnFqS2UWQ6byTyCJZ/Dz80dzx+pUx9H5wva9r7a3nHuYZlAjWxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/kFbSE8; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/kFbSE8"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e6391b114so169833385a.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 00:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785136762; cv=none;
        d=google.com; s=arc-20260327;
        b=oHITnztrRz5eVFGk9zpJsCtRbDqgLi4yayHpybVnlUg3f3blZ+ECsJAB0Qx9RcQEdg
         ZES2RIsKL4/Ws/9VEvn0VGIffiv50KswlYVAlgWofkzhHc3GsbAU9sgqAufkEyKyHi1X
         F6ghOKvIHqoH6GJWTvJyQ5/ziIbYAhySIdmXI9tfMZ+u3JRmZWC2uRCe/QWtRRHdIbYO
         FdCEQJ3L2K6wBohTemZCMBglL7KDHBuy9ENgSK5cOrBZCs78cSxxOhjGBHFt+fRfEVrU
         lmSyRlQa5NFhFSq2KghflOXiu2FWvXAcU/5+45oFa02vlKzsOygwfjSPrkgs2EeDZcnV
         GU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3s0ZWapk6CSKQG7LinS/fqM/+LO7TASDUFIgGuAFciw=;
        fh=wumzwKoc4gFT7NnPa0A7r1TPWFZgC2il7MRj3YWHG8A=;
        b=jnuHstV+6kjMoAZzy4bmaH89Tf1wZD+h2x5PUjntUx9dOfa2KmnV01KAo1g5I4kOfj
         IW0QrC/ojP/MADeVfTwgIsA28u9SNAjBDM0kLlSr6CinOfTZpPnFzmUsPCISTZjstTGK
         d1QRGd58aUqPHGp9UCxjzshozcKSmVNYlOXN/R0/W1ZsJf5l+yjTWX4H2wBKnZDC0lMS
         cTIBruAamYde/u6yS49m19IpGwg71Xz+vjm9mBaasGjyHXcfE36CV2efNtsUlObIrMCC
         cd0jn1F1W9/Oyju1hsf3x4yBVTE3GsxiXLLE32DtQi7zE1ORnIp7N58T8OVeRKYvjSeq
         TF2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785136762; x=1785741562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3s0ZWapk6CSKQG7LinS/fqM/+LO7TASDUFIgGuAFciw=;
        b=A/kFbSE8v6s5tI3pBO/5rLUHnTdZN0KAFptsSL68fmIbF5MAlrgGEETmBmeywd2Yvk
         jRqqaKd/ZgSUyhZ7y1fNfETnWf1xFcjmRTp0unhu+H7BCPWdHYZKSQ1Y8y3jUmD4Fwp4
         53V+YhSlzpJm1SYcF7itobWri2piT9C8uYtO+3hfMwDj4UF/yqdq9WP2BFwHIakk6ba3
         vv5R4qOOZnVaYr8iMqNKng1J5BITNt7Vh2OiL894myajocI4/N1bZ9i38yoiLpVakkS9
         WbKxbPiF1rrE6FuUWcjl6dRJnPeqrHOs2FsTeX3K79qeEQuKeOudZs6KTQJMyI4ZMhn4
         ZZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136762; x=1785741562;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3s0ZWapk6CSKQG7LinS/fqM/+LO7TASDUFIgGuAFciw=;
        b=MSB7iDuwxdJOKerb1DDsUbW4ImsupPFPPkz5ZgctMHbukJa2oaQHZvngGpMrhZgEke
         6rJd/FfaBFyxleN+mIU3Np3M4ta/sIMgH8mOiefXEM+RvsoVuQccVhhcC+4uTAfilHma
         O/KrJuuzfet6qetjFcRZeZVh/ARL6zrNHj+tic9GCCfWuWvLkju/H0hEE6PjaFS15IqP
         0E9j2OHWwTrOv6xrklS7+92Z3gZTRjU4efiC6cmfnaPRvrdeALkc1kL/N7zYf+j8xnSf
         k0BuAezFEekZJsycFfX2R7qEvjinDDQRSPI6kmt1OH2SklQIn7LBl326971o2cT+R+9X
         wMQw==
X-Forwarded-Encrypted: i=1; AHgh+RpCmUs2A9Lzmv+w1ZLMzFetFLSsU80JV4x70iDj/l58XbPwa1tL5YtBv+OWR2I2gES5C5lKsts=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4rGc4WE9GHw+165BbB8m5Ttm4U50X+SJJ5nFWU0rwQuCZ/HE
	xM7G5nq/kI95InpRie/xaSZFIA8gZulXxQaDCcGm8Sx0d8+YPS46x4QlcS90zqB0ogK5+ME3moh
	Y141WBS57NcfPEKdUMFooXutmUwPBMkM=
X-Gm-Gg: AR+sD110sraNFOv1H1URnG0Fm3m3Wv9NH3eiyvLJCTgHkGT3Gk69Sm2QSD6I0W89hQH
	4qRhUYTe/eQJqNF2i/RJAxw4kQnjcVvH0xKrGdV8TqGuhuqE1YMmxNc2K7YpGM8lVMIYV+nVxJf
	hMLpMWekGuIgqjrosHlc8J2iYkJtP2ODrjasy5iGDz/VmtpWQTNTYbdXzAN5ccYf0t/fvoMQu7j
	cNujmYxiAGlsIJkIU7/6pE5TKEfZiz3zrvqE5DgV8byzIh3F3P/gzZWqzvwHN/99ZqOc+PFctQb
	ChFimrW/0xt1NC+m9w==
X-Received: by 2002:a05:620a:a41c:10b0:92e:4e88:f453 with SMTP id
 af79cd13be357-932df72fa5emr557474685a.52.1785136762304; Mon, 27 Jul 2026
 00:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727021048.3375444-1-attinagaoxu@gmail.com> <dae67c46-62b6-4233-92fc-69a09944baa5@bootlin.com>
In-Reply-To: <dae67c46-62b6-4233-92fc-69a09944baa5@bootlin.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 27 Jul 2026 11:19:09 +0400
X-Gm-Features: AUfX_mzMsY03HyPmF8nz7hhTY-FL_h-TDf2dzG1Lg1NUJL_NPUJrMPEieD7G1Rs
Message-ID: <CABjd4YwyBmTvw6cVQxLEzZEXSRb4QFEuQmrYY56WdmSfs-z8Kw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: dwmac-rk: add RK3576 GMAC 25M
 refout support
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Gavin Gao <attinagaoxu@gmail.com>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, heiko@sntech.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	richardcochran@gmail.com, nicolas.frattaroli@collabora.com, 
	sebastian.reichel@collabora.com, sashal@kernel.org, 
	chaoyi.chen@rock-chips.com, amadeus@jmu.edu.cn, rmk+kernel@armlinux.org.uk, 
	horms@kernel.org, alok.a.tiwari@oracle.com, david.wu@rock-chips.com, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Mon, Jul 27, 2026 at 11:11=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi,
>
> On 7/27/26 04:10, Gavin Gao wrote:
> > Hi,
> >
> > Some Rockchip GMAC instances can provide a 25 MHz reference clock outpu=
t
> > for an external RGMII PHY. Boards already describe the MAC clock direct=
ion
> > with clock_in_out =3D "output", but the dwmac-rk driver does not curren=
tly
> > request or enable the corresponding 25 MHz reference output clock.
> >
> > On RK3576, this means the REFCLKO25M_GMACx_OUT clock may be disabled by
> > the common clock framework as unused, even though the board expects the
> > GMAC block to provide the PHY reference clock.
> >
> > This series adds an optional "clk_mac_25m_refout" clock name to the
> > Rockchip DWMAC binding, wires it up for RK3576 GMAC0/GMAC1, and enables
> > it from the dwmac-rk driver when the MAC is configured for RGMII output
> > clock mode.
> >
> > The clock remains optional, so existing device trees and SoCs are not
> > affected.
> >
> > Tested on a PicoCOM RK3576 ACP board with a Motorcomm YT8521 PHY.
> > The GMAC 25 MHz reference clock output remains active and Ethernet work=
s.
>
> I have a feeling this is using the common clock framework backwards. The
> MAC in this case is a clock provider yet it uses the consumer API.
>
> Shouldn't the MAC instead register a new clock, as a provider, for the re=
f
> out ? The PHY device would then need to get/prepare/enable that clock.

The clock name is a misnomer frankly. It's configured in the CRU and
muxed to the output pin via IO registers, so it has little to do with
the GMAC itself - rather it's SoC wide. It's already exposed by the
SoC clock drivers, so nothing to be done in drivers/net/ethernet.

Looks like Motorcomm PHY drivers don't request the clock though, thus
we're seeing a second nearly identical attempt within the same
development cycle to shoehorn clock enablement into the GMAC driver
and binding, where it doesn't belong.

Best regards,
Alexey
