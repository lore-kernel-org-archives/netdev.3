Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C79383338
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775016; cv=pass; b=j1hkJLYZ2VwjLTwjnlxD1NggR/i1ye85MjZa9Quq2+dx7DJ5GNgWuW2S3ykibNVeoJLGssNGsQRKY+09Vaech3ETy8BSJcCCYpuPby1DKJjTI6CyCQ+t8uVt9L+d3AWLOkjF25Lv/Bg4AUQtWtVCWlUQgM9mZFOADSvzl2g/hdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775016; c=relaxed/simple;
	bh=K7WSdWoRnNatXjyT6a0V545KuC7+pJeUxQF1yR9byhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3/Sy785jTV+V5JHN5vbtindkc5YE4QQXxNdKGGY8OFix4n1+mWL98Udff/HVBlBhQCbj3EZb028lm6Bw6bO5VXOjhLD/wtZ0f/6p8aOzmPAaZ6tETq6DBxnJIClmkEQq25EprusyBLjLiC2XXbb5fzdpypb1aF9SY6l4s8FzPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EykJ06Xx; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EykJ06Xx"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-97727c2064fso2387537241.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785775014; cv=none;
        d=google.com; s=arc-20260327;
        b=XkSDkwE3DPaV+Wm7LYe98i0GCKJ+Q/miy+fVx2Z5oC5RPFuFsh0XsdNZQ8G4YdqdcI
         +uuvrcYtI8MIwiJMo6bt7SmhBZwSg7NlBH9FoOA/lp5/g5qqfKUAP8f/QsO52AVaBmtt
         WUEpeUzw746an1n9m1QavShbaJs7aMIXwHq/IIojJ4lhlBFrf11aAxFAYBmEEVsDz3dK
         uS694bLMjWEOf3sO8jg3HPq9mWGb1OcHYel4R3ShTA+dHmaCbfAIxB9WfjNrSzWOrxO1
         ETp3FBsE7mVH3xwVngK3heiGftbPRVOZJGD/e7jPIdmeZhSEcwCHF5SrZa262Oh/wu2F
         wSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y2mO7QnlyPovrqJ9WwdH4iPAu4v/YWoM0OB9E5eGsqI=;
        fh=n+gIhvgloThxNUxUCT2PVgoPspZ4onGE/WOtG3njjzk=;
        b=k9t9skBsZxq1B6GZBQODi8ITQea+s579M3rOWXQqefb6v6fdXvHT982GoKsavEPCQj
         Wt/94LBuhykfP8orJCieC5iXytZFDNkPmnYD54QLOnCEtsjgrbcvDRhjff6FaxyWD+Hu
         cQSr9G7SAUULzz3b0u/vwghTpibF/02OnXjz1F1as2q0+DFnTyfly6xKN8Wqb0snbOch
         j6qPpSW9iX21sx0Z/coqYsJuWuVLeCvo3q1CATl60Jq5tEAIbuQ2+jUbTM8P1Ej/JP9N
         3OyIpLKYhRLCN6Zue53pqf9BDTOxn2zaFfx4ob48uibfNu3Uud2vRi+ZxIC+u5VJoxex
         L04w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785775014; x=1786379814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y2mO7QnlyPovrqJ9WwdH4iPAu4v/YWoM0OB9E5eGsqI=;
        b=EykJ06Xxy3io5WUp+JxhY3YKHP4TLnN1+ZdQYVPUJXq9avodpuMT58zhsh8LM3vZCn
         EALEza4CeBVCDJXGQs8JH+XDtnp1R+GOR21cKcpADE/S2QpagkdngTrQcpcsvaT3DvQQ
         3bzTjMNNvo04cpSh/5EvEq3Z6YtV3TfstqrtBRl1tPZDLkIvdDyCdWCGXOyrIkTTpvFj
         mPqfj/cxbVkYkTz8hsy0HTJ5WgNAJ9yHlnrTmW1y9ay6oCoSWTFH7KVAvh/ldB0lUFZN
         5nw25FquknG21anGdE4L9nqsMkHVT1JewOd7td7zRrk1+msGo4ExnpD4jZZlfsSUIu6f
         Z9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785775014; x=1786379814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y2mO7QnlyPovrqJ9WwdH4iPAu4v/YWoM0OB9E5eGsqI=;
        b=g+wfDozhZzI4tWZCVREa1S3sYKcUD9DMBbWbpF/KdhHuGZynHZKDcEiN0Yh2G7PxJU
         sxurPUohmfsdC2nes8F/TgoEzCVdSxMmXG4p/k0KNLRh2CBBOxK10Mjo9pMVuZM0f5/n
         MOq8JP858qtZCSzdJii2KESurWoauFa9ncG9+DRWtIV5vtp/OQNDKMbLF0LbRRmqytm4
         1FJzMiydSty6v7BmQ2bE9HFm6lFBanGv58WQK6iKemwKWw+OH0PJymfour6m6AxxP3EG
         8zH5AXfWibr4BxJjBQxOH1h4AepkwzBbenJ6BrUZMwxzeOHRpzZObZDTcGYVhyNCtv6V
         db6w==
X-Forwarded-Encrypted: i=1; AHgh+RrWpc3+HwS9A3qm0vlgwtXE6zDn4xl71EWN61OIW7UePVlzblLrCVQzM/9hbxHpWRNn4K0wxkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypB2sT/KJL0akm2QRYA0DYSoTdJbWPS732RYTvN8Eh4F0qbXGS
	W3JGGek+yJzHRcm5R9Ur9P2LagoX2GFrI1tApt3y1beTEjsxpEXvN8YZnxQSGDP4cZNb2zH5BpC
	hPC1tMx+hdon8pxVJI8814EWN29s/M+8=
X-Gm-Gg: AR+sD11az4lE9L8hbfSF/YBSeDc1B831l6Bm7bJUOptrJnDs/MS2+r1PAsbwCKqayTF
	W7q1xGojLC94hwvC7+yYWGMKgfoAmH5HQupdVSJlim/f+YVvrcS2S/tdwWo2soV1CKG8fwRJ+3X
	JitHVfY5h+VakRwfjA9hfqPD2g5u6iVnub4BQNvOyqzc0cCYMivJHXgcOGP9MKY08t17nb5Qd9R
	YH4HgUwqKnHKnFGy6PItwVhJ5c1Ml0jnhC4ngWhvsR7K54fPxJZ/p5CkUQnyY98ab8LE8lwZ7ao
	Rrl5gMvUsIHlHgecGjVL0kK+eiWtZ7LuGbqStIZnnCdK8/QWrz8P0DIu1JC4wWeR0Unm84nPKvH
	u8LFDS+Z/FAPhTL5U6BHj8jQ+LkBromNR8fi5AUi68HpDKl2ETswmbssMvJibZoeFWs51Df7kVo
	yJOwnsVAY2gjG+tO/BgiUBazphlKbUjaUauArIxn9149mynUY=
X-Received: by 2002:a05:6102:41a9:b0:740:2bcd:24d2 with SMTP id
 ada2fe7eead31-75b2245a880mr8777953137.5.1785775013743; Mon, 03 Aug 2026
 09:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-8-0a53cd9e21cc@gmail.com>
 <f2cc3c90-060f-40c1-a55e-e2ed91e65487@kernel.org> <CADvTj4q7HnOYJZE-M070-1npEdne__Ct5D9FeUNVVXa8Bsm7qQ@mail.gmail.com>
 <e198e8fa-6c5e-4c8d-a4de-d8bb25aab0bd@kernel.org> <cd177647-827c-481a-9ac6-5f5a1882f14e@kernel.org>
In-Reply-To: <cd177647-827c-481a-9ac6-5f5a1882f14e@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 3 Aug 2026 10:36:39 -0600
X-Gm-Features: AUfX_mxf143l7ltuwFHdM8jtybu0jFAqTogB47kH9lIVgz-FaKgqQGV-oPrZGYA
Message-ID: <CADvTj4qby5jow6BkvumZFK6cF8aLCTeQZz39VKEdm59jEtRp8w@mail.gmail.com>
Subject: Re: [PATCH 08/21] dt-bindings: mfd: x-powers: add AC200
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

On Mon, Aug 3, 2026 at 2:21=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 03/08/2026 10:20, Krzysztof Kozlowski wrote:
> >>>> --- /dev/null
> >>>> +++ b/include/dt-bindings/mfd/x-powers,ac200.h
> >>>> @@ -0,0 +1,13 @@
> >>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> >>>> +/*
> >>>> + * Interrupt numbers of the X-Powers AC200 interrupt controller.
> >>>> + */
> >>>> +
> >>>> +#ifndef _DT_BINDINGS_MFD_X_POWERS_AC200_H
> >>>> +#define _DT_BINDINGS_MFD_X_POWERS_AC200_H
> >>>> +
> >>>> +#define AC200_IRQ_TVE                        0
> >>>> +#define AC200_IRQ_EPHY                       1
> >>>> +#define AC200_IRQ_RTC                        2
> >>>
> >>> Hardware constants are not really bindings, even though you use them =
in
> >>> the driver.
> >>
> >> Should I do something different for this?
> >
> > I would just drop the defines and the header, because these are fixed
> > hardware numbers.
> >
>
> Hm, unless they are not and you added abstract ID numbers for both DTS
> and drivers? Then this would be fine.

Yeah, these are more abstract ID numbers, they aren't really hardware
constants as the driver translates them.

>
> Best regards,
> Krzysztof
