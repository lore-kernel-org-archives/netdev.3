Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40223A4F5F
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927300; cv=none; b=MxOAcbeUITouWjTXTklzb77ABM8pK3zP92vtjiVYLF2RrJBZSRLS2t7pVjQeACWgJXOHyvaF86bUHNwCrKklGPPHCOzc3SPPuwrdZoan3i6RNWDJzbIQnWCux40f71D6Vtnk1kj68BgHr8n+Vmb9+o6b47qBG1R/asBXWdf6G80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927300; c=relaxed/simple;
	bh=AyofDjkGIbYWivWAEEyVoNCblr6Aa7b/CozB3nluYp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6pJXWcg/7JjTSOhZeC/Rwltc4jv1cBsQZOhdtbMuHGO1g7VNf7O9Be7RQvN1b9A4o1enUbQadrBAMmHfZHIx54rqrgGVPFH6nsCBW0j7WUmJHImnlfGr7Cv9NjrgMZin2/ei/IdkGcvzI1zxDIxdUprjR9ac584FVCsw2MCZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoxDyPHW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoxDyPHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B1CC2BCB3
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773927300;
	bh=AyofDjkGIbYWivWAEEyVoNCblr6Aa7b/CozB3nluYp0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UoxDyPHW4lBdtdbA6h/lAqYje1NK2Z2IcTAM3fSQUf2ptxGUQ9CEUoycY0yqdzikU
	 3EikZq4y/K/RgYkdKY+SMREb2KNiJJnXyI4OGEQH/d2fwQZhmKSjM4ilopov9Kvapy
	 7Gzg4sgaugfTWEPCoACdUNTehyTeSOTOcJQL8oIsDsLUWwP6QfkL+MOAw1Iq+UFmVN
	 /we0yz0HC9bxvVKP83FBk1i2qGL+PXbzgRltYsjr2VucZDAloH6sNM4xLzl6oNtjcD
	 clJyWRGBuZ4VF1uQWFV//Jq+4RIUBURG93YDrBGM4GLZjNnSJakifTWx+jnIrARo2f
	 sYaS2wao00Ghg==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79885f4a8ffso9182177b3.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:35:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUMUvpO+Iq2EDax2OebG2p7JyBOVPyOnx6udWO1yRof6x/YBPHq2tED+C0NyoRml5MlqWIIBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlK9LEjk2JibanVhgIzPVmPsHDTaQqnebDSFdESU9yFL47K+9t
	M6fSaDVwx+5tsLMD12+vu/dSSke/racYzVwhd9p4e+9xSc2sMaMptKDh/tFfGYDKpBTcPnvfeNg
	Jvw4FoAoMXPwVi7v42mPEd8qhIAPGw0A=
X-Received: by 2002:a05:690c:f09:b0:798:56eb:f238 with SMTP id
 00721157ae682-79a71ade0b4mr72621207b3.36.1773927300081; Thu, 19 Mar 2026
 06:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-gpio-mdio-hdr-cleanup-v1-0-2df696f74728@oss.qualcomm.com>
 <20260316-gpio-mdio-hdr-cleanup-v1-2-2df696f74728@oss.qualcomm.com>
In-Reply-To: <20260316-gpio-mdio-hdr-cleanup-v1-2-2df696f74728@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 14:34:48 +0100
X-Gmail-Original-Message-ID: <CAD++jLnC7dnMd3S93O21=Pd0AdNHW1wGJ+Rv=n+pFboK7PvT1g@mail.gmail.com>
X-Gm-Features: AaiRm52_nGZz9eWLxqQwu9My2vizXO7ELM5ay7SoyrgfjFUsvuQqrnRCAvge6Hk
Message-ID: <CAD++jLnC7dnMd3S93O21=Pd0AdNHW1wGJ+Rv=n+pFboK7PvT1g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: mdio-gpio: remove linux/platform_data/mdio-gpio.h
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 11:04=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> Nobody defines struct mdio_gpio_platform_data. Remove platform data
> support from mdio-gpio and drop the header.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
