Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42704257ACF
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525592; cv=none; b=QarVpIO5Ga1bxO2FJR0LwRdpU2rIpQv5qHUMBGFJ4e5VClDnJA9KAvL/qbopO0jSxQQdVM4ItVvmH9OEA2FoQ/09zwWKg3T7TPov/yG50FTnvP0IaFG1e4wylD4yGKR0fDwnvhkPH0S/BUve/wN0IvdWzlTYyHGpM3R3sGHYrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525592; c=relaxed/simple;
	bh=m5iTeZQJaWOmDHdhLUpG8T60sF/xGvfsqVSif6l6vXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ra0n0iCRz+cYGRP69SLOhdL6D4CN89tU1cvIyOQZu7y1rMs9w7xpXW0/dt/4ki0HV0bhuSyoX9kDUUG+9YoqFbmd7ap6CoTiCA+iYifqzvbLHRxR4Ohd3sIk2LQg2sdYFpHQFr31phWMF92im8Dt8ZeoiCm9CVsjZu3LP7N4SnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coMVIVFa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coMVIVFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC77C2BC9E
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771525592;
	bh=m5iTeZQJaWOmDHdhLUpG8T60sF/xGvfsqVSif6l6vXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=coMVIVFaSc5Yl0fG5/W2KKhvSWMI4xNABk+8P8rLZWPVKBhU9BeRfChpGmkccNeG3
	 uADaV6ePoVKcMRevQece17RRaVNriDC/t9Jugx5ZiXqYUnaBhbmH07Mmw7Xl108E2d
	 n5gn23bOuzonv8qfQUx+snqzyBkUdg/oM2gHHWVF/w/2zGY5VzfLMpsn9fP1sdOKAb
	 +P7Ymi7xBhgRuERIIBgyDTNyX80BhLVNn4Fxvb0y70MSyQe/hJXC8RjYG/9xNjtcQ1
	 KOWTO1GBXefmFYn11eaH5cgfD+FNiGSPfjbpQEHyLtIm9Mqvo9xAMWFOnrsKxzikDA
	 HDxr2f32Gzl9w==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79801df2524so11773627b3.0
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:26:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQmzFQCK3tu2JTBXMvxR1lTZQyh0iqFfGI3ocrXdtcmVP8XA+l2HLqFh0RViMl4yE91Sh0thQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Ne6bu7LPwKXFc2rrCdhOwG7sXkeN0sMvo73Gh0qNFou60Xvo
	pm9E6NGTH7mUWZcQDfxcBXGE6w22G8uJ5dVjjBx8s1zsnAB4oNe7KRo2YbFQTbHG4J7l4NN8fDg
	hmXwCJp8QehApjw8P96FHKq618gnpJ+4=
X-Received: by 2002:a05:690c:4c01:b0:798:f20:b84 with SMTP id
 00721157ae682-7980f200e27mr16409347b3.42.1771525591316; Thu, 19 Feb 2026
 10:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZYnWZqfzKwzzF4f@google.com>
In-Reply-To: <aZYnWZqfzKwzzF4f@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 19:26:19 +0100
X-Gmail-Original-Message-ID: <CAD++jLkfLFejuhJgYRiMaR3XBfi5nK4LX7f1z1q_hGgLC5sZ-w@mail.gmail.com>
X-Gm-Features: AaiRm52t-jBfjZKc_oPYwPAJHDGGYMDv_wl1K1lfnyP0Jfup4fc2F5SXbo3j5X0
Message-ID: <CAD++jLkfLFejuhJgYRiMaR3XBfi5nK4LX7f1z1q_hGgLC5sZ-w@mail.gmail.com>
Subject: Re: [PATCH] net: phy: qcom: qca807x: normalize return value of gpio_get
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 9:57=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The GPIO get callback is expected to return 0 or 1 (or a negative error
> code). Ensure that the value returned by qca807x_gpio_get() is
> normalized to the [0, 1] range.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
