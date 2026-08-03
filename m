Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF961DFFB
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741763; cv=pass; b=bMSXRDu9pvbaC5SopUcEmJLbxaql1KmymflxX0HSDFT0+A5AvLZ6GZAu/rKk5ar6cRzNcG7i+Y1i32cl6p+ZXQc+gC3ShQV2lFTQlA68B6bpJbBW7Ei9gC/HU2bEETiV0muISOPVWYZLJHZa2v9iRd9vUjNcA5BpmKBuAy0WgLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741763; c=relaxed/simple;
	bh=A8u5ujOdUQWybgJKMqWZVqAeP8c+v+cuw6pgGBdqcGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Znrd47hFIP/e/aq8FdI9jj4m1Y6rnrAI+/mDACzNiQbAi8g7sdm7EPBjZXwn5tahu+u7fvvod8w+ulfCccqEakT2pFzWQwW/M4xogIMSvZu2w7QtphcddGmhvAzxRKC/2PSOFHQC174cD5y7W56bPir+XKmuSLowglehQ9ZbYtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtXkvoJL; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtXkvoJL"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-74ad03fa605so1747483137.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 00:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785741761; cv=none;
        d=google.com; s=arc-20260327;
        b=DnyH+qKgNrm7oPPtqIKnkDpKyOYR/nLUXVyyNRpwR2obvij9dg9Eo2BRnYvOoMp/cH
         7c5sckKOxBYqCibS/zibwZWr0oR56EK/F9s/5RollEKScQQ3Akb1zoIpj9DE6sk429hd
         iyJWv4r+QXJxEr/LYBFLm7CgQwXZqlRrB9YJUUgUOEtdUmNdz7ZLItkD5Fvsg3iyvaLs
         bxZsQD2RW82Ro/uZALi1e/xPsSycMbws/ZAetxT8iQ4NjAD0nSPOtX21v4nkT8ThgNy3
         73ddOO6KT45FXzrMojHd7v7rk6jc/6wIJqnrK1PcoHOmbXkpyBRXI00pIhe1cJ3YwdDr
         GgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A8u5ujOdUQWybgJKMqWZVqAeP8c+v+cuw6pgGBdqcGA=;
        fh=PogHKoGBZsVdjLarAhMBhW/0EKBpQiwtSz7Rw1EOyAY=;
        b=kcnrk8JOo9PFZadyeqHHOrGag5WH1Z5lAqk/2etvHladbp/weq0tlbVZDYxWXp7LgD
         +645TB3e5kcccAj/MUyMMzZmNkq9tGzwhmSk6UfcergVrYXkIK4E5Xv/rMkrBqpcMmy7
         Zb5hqheRSHCMY8HCo4Ls/iNAb6LaQLFUN4hLLVME8yRCdDQVgbLWmU+vfJN1bah4w5DA
         LL2WfvcfTEp3hh2jn/e5QglcXa/oi1a88/ne6uDEoYLI1kGYc37MZ+NizPmmJI5PomuC
         GoASVY3aVnEEffzzF4gkwnxe+01mL7zN3+avJflure2bdizrHewHFtxI5UklHG8bZik5
         30Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785741761; x=1786346561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A8u5ujOdUQWybgJKMqWZVqAeP8c+v+cuw6pgGBdqcGA=;
        b=RtXkvoJL0DeE5PV5je0JNzfJDfOA9W8nPRnPTBW5ZZKqkWRNB/qu/TN5lcPLpDtSB+
         +z3P/MB7YzoFfD/+97h5uCeroQ2rSfZs9LwnlKkcpUE4/JRmppCPXv51pWaJVwI3PEqG
         GujbFlNtSXSvX2ryz9x2PPAmnLinh6YFzD9FZ1bZ/4Do/Abmal4TCYrO4NZ+aN7W7Pg5
         ozJ460cJkeB+rYqc7lOlri6KfJmDNk1kR1AUpLSf9DRIRKXapqzAaprNm99Ns2txetmn
         eAxrzHAS0DBDJVGcpsnrkEAAneJ+oXtgXDf/OhDvQ5SnGRZtfDPdF3npz3diHOBl/x7R
         T43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785741761; x=1786346561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8u5ujOdUQWybgJKMqWZVqAeP8c+v+cuw6pgGBdqcGA=;
        b=OXPtcRSVGj8ErVjI9+ToSIXhvPSBpQAMF7rbajjYrbg9Lhxu11gmDFCUAsxyEDN6uv
         rn07hPqel32P/ILbgOwQe3CZRLR33kuB86rxThHvNDZRP2n40a/+pD52hCkQffmz03gP
         t/ao7P0yDSSasSkze7gxxo+YHVf2zNcVmX0PDwZKb7c2lUWStaL10tawr+SDu6qTWagN
         dshYvrvqVNwt50b81p0JcjyzRdwrnD5kHFoPzVP55/xHzRPcDbz7qfGysJN4lCqVG7dj
         Mrj8CD0vZW4eynImiU2w7z+enJfSkOPRiGUU9rn9HDqijhJVSyyEoOQ6njr8dro1FGwj
         3teQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6Fh8trSZt0yfB4RJYDm8Y8mDKnRG8UtiUFjbMetJP+TxbDvU9UG9wr/Lh3AenxiqnFwcAWlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3kO2Q3h4BbwPubaRmucvt9Xk1YbzBU7QrQh2mdQtzAayQXeV
	r7MKpgJUAUnPq7dSSBwCj2iaA7ToO2SiZqpd2t/cjhYilgj4wCzfLLrROk/E1aa+VbCxuCS0ySy
	MamucYxqdZVkuxpQ4jvjlrOGGj4e17Mo=
X-Gm-Gg: AR+sD12Ohlu/pZ0Y/I7arGfsKI4M7G2CzGpBnxoZ/eKy11zcR+HVXn1tPxgnOnnRo5O
	1UdZPe2kFYeKvXhHQ0XmfhHw6RBtij4pJvzxIpVZeURxq44mxknWa9LLuOmTuj1Dd/vACCUd++x
	I1Ept/3t419yUy+0G/3JsE5rq1tfY22p60W+P9mTlB2MoT30wsQXKhLN/LCdmZGqkJEl8U/E8LA
	Yn+rBqAFEf1hRN9/7MO7s66KmFiyz8aOR3yuZaWkPoEl0dBnVfBeg1qzSBkbAB0Q2rn+J8mw4fx
	TtU6+HPOkSyzrf8l4c2YcGkOCV2yHe1zhu3dSu2+KzKYy4C1dOwgGmqYwf+1AsbDxhmySIaKQ/1
	dB+2wkOs+HhOkCx8J+p5jw6ZtbYiyArluBMmILkEKSoF45N0Jl2ugdcG6VEdFTSdPo+qGVsidZ8
	BgqmVoEPtS2ux+YZV1WceKCDvWxL4J3LrlvGe7
X-Received: by 2002:a05:6102:441a:b0:738:1ef6:51b9 with SMTP id
 ada2fe7eead31-75b22260dffmr6459811137.5.1785741760783; Mon, 03 Aug 2026
 00:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-21-0a53cd9e21cc@gmail.com> <c3171c59-bc83-4be5-beb4-e93bfb4d05a2@kernel.org>
In-Reply-To: <c3171c59-bc83-4be5-beb4-e93bfb4d05a2@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 3 Aug 2026 01:22:29 -0600
X-Gm-Features: AUfX_my5qRz2h8yblU9_NUKeJ1t5ekFC9VrjQ-ysDEg0WGg4G6m5XNTvE_CWbqw
Message-ID: <CADvTj4qg8Yjwr=6KVO_J+r+tEC=6TDrU3o_8YG7vuEdDA0ZpTQ@mail.gmail.com>
Subject: Re: [PATCH 21/21] arm64: defconfig: enable X-Powers ACx00 Ethernet support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>, 
	Richard Genoud <richard.genoud@bootlin.com>, Maxime Ripard <mripard@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mfd@lists.linux.dev, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 1:00=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 03/08/2026 07:14, James Hilliard wrote:
> > Build the H616 PWM clock provider, AC200 MFD, both variant-specific
>
> Use full names. Is it Samsung H616 PWM clock controller?

It's the Allwinner H616 PWM.

>
> > EPHY control drivers and the shared link-PHY driver as modules. Enable =
the
> > netdev LED trigger as a module so DT-described PHY LEDs can use hardwar=
e
> > offload.
>
> Why? IOW, which upstream board needs all of these?

The Orange Pi Zero 2W for example would use this along with
any other boards using this copackaged x-powers ephy.

>
>
> Best regards,
> Krzysztof
