Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743074;
	b=fgFN/D8X9Th6OYEOtxPgHsJL8vTR1gJx0MMFa4Zs1zEtmWlBJNWvWOhsQYe7e7mt/Xge
	 qEV5kNS+Y1kK0tfrigXdfvGJ/HRJlDsod+OHnZYoapMHOPiIcYvfdv/iaPQFaOTi+x/+w
	 6IIGolyeSlCEDlHxvaTmNhuznTMsmMp1DrFXrOzu4+/2+X66mrjjAfYGahbeSqFJAD42r
	 WB4k7GEpK6IUUlzPTYI31Fhd58cHMdrpozjTODqrSnjuh630YR5bdEoZe3x4QeRRYyZyZ
	 1OXYJXW08a4OSu/18xB6uXdJQ6JKhRya4Fsj7FB8pOCR3utrFgmrZMAdEyQ7naa3+0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743074;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4H8eU6z2JR3iXPnaXPV2uTwunMPI539+3YmBBPsTqq8=;
	b=oiGyC7Ai71ZNfzvP1V7O8qcIALxgQC/Sa3q2ynHqGLGe0kkTDkgOb+QtP9cDwjuprC8r
	 Kx4qZ8uR/1fQAKlb/X3ZWNPvFEK997UQKrd2MoxBJ2dRwu71Owq7fmKMDhhTUAApVSKIz
	 TZB6DIgbETlxSrTTcA6/Zf+PndTlbAy5jBuVcpMVpP8s3pzlaNJVeM+rDuGD6W1SzcczW
	 lC4Qr8To0pa4MRw5GoswcbYVBBB4Ce0jH+Mf1Dc6xMwWCA5MN281xAwWNOtgDhNVEltqV
	 OMzI9aGwQRQDoU/vPK/qFKOpGyZTMR0g5vPJqNaBUfN/n6OMY9NLFjipoVCC/71fOsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NN4zXVrv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F9606A33E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NN4zXVrv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A571F00A22
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 21:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793743074;
	bh=4H8eU6z2JR3iXPnaXPV2uTwunMPI539+3YmBBPsTqq8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NN4zXVrv4HX75rNjDW8n2rGhpIdcwT226SOYEzZIJkf4wky///aAUqXsW/LNjWIkB
	 +jqhBmbKEGHqpB/RfJ3IOme2x4Uro3Y6FFkYU7Lcb9k3EYVAL1RdZOfZBIO6UiCdmd
	 KU9/YPoFAEbimG8yPTj0+ET9beRolcznhTqYs/aM+V+aZskkRu62idx1+KnN4AwSau
	 1qKaj1M79st+FVG6mdkANAoRT1WY2ezZ902n3LEXe1SUMJ3M1nio7P61uGsrtysmqO
	 t+l8RFDh+9jqGqOg9Z/Kt58ZxPm2v6e40EATAVtiGV3R2E35gTnJzuKbjPNba1LZpc
	 +CFP4IuYefF8g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bfa686881fso1723e87.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 13:57:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwAu5i8IxUgDVE7oXz6vrOdYWb2PMbUxGsd2D877VxcIdYYpJT8SiTPomTXUiMGzsKVrTyNKH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Pl68Nnvopy8yhzBHrSUSvp9mMglsIw0KKJE3LnS7NZ021zNYM
	ly1PfEnIsUCXSw9heQ811Wrf2/OmNxRB57NVwUM1cYfFqx0P2Erth9AXAb2vqGmDVg+68CW3CR0
	ybWVI7DRtrBsVkLyUzs1IdQmuI5meTJQ=
X-Received: by 2002:a05:6512:a94:b0:5bf:b246:87a2 with SMTP id
 2adb3069b0e04-5bfd957b610mr4953868e87.10.1793743072116; Tue, 03 Nov 2026
 13:57:52 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Nov 2026 22:57:39 +0100
X-Gmail-Original-Message-ID: <CAD++jLm10TL4FkkyhvyF-CKNREA-mOSjbR5zKUisC_Wx1-nqgg@mail.gmail.com>
X-Gm-Features: AclHuK-xZTzLWXlPWAOCiWHBj5C4K-MSmY2Fnjjj517UPimoWDCn2vjwhrapfPU
Message-ID: <CAD++jLm10TL4FkkyhvyF-CKNREA-mOSjbR5zKUisC_Wx1-nqgg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ivan Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	Shawn Guo <shawnguo@kernel.org>, Chanh Nguyen <chanh@os.amperecomputing.com>, 
	Alistair Francis <alistair@alistair23.me>, Julius Werner <jwerner@chromium.org>, 
	Paul Cercueil <paul@crapouillou.net>, Dmitry Osipenko <digetx@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sound@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-tegra@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:53=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:

> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
