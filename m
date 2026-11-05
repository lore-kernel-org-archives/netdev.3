Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846398;
	b=VZ2iIYeTgqX+q0fZnhYqzCt44mxJJPn8azCtgVdrFAoWpC48NyqRLPXXP8nKd/zriJhX
	 ciBB+qgA2cOo78uMwAoyESI0LwYCafV71swZWjgYcG59tOC3sMEiNXKXHNtYFseB4/BZm
	 sX2ARckvHQxJJFiaYs6aF1IFARxn3znN+D8s7fnTAwiFzwHQGq5cz9dkihaWypkqxe4R5
	 fqoQWnJ5+c5WkF5z/oVJdKw0/mxJR4qLy5yAbq7fEolchyJujvXvvtPn3SutDyfj0erKC
	 UmS1TgRF1lN3etGNp3YjuxMLtE/MrziTgyksTNJpHQEMfWujvNddmiHZQbV4TqhU85g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846398;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=8nHg2KK9YdUFsDyCN5OyhUk3RMp8EQBW/fDZ8x8OirA=;
	b=c1onkSTVXCOTfeJ3k3/xvfrpoNGuUO7v346xYB4xRd/WIEJfJnFFfPlUyaRX4B37g8yA
	 bL0pO8wh0dc3aFkSTaxXWpdxZDItkglMMN4E2aR0hgfS22vd97eSI3hVeulWNln+GFaLT
	 GwLxBt+NMn4YGxTvsol7up6l1ZTeyb0bktvi7mxL5ZGotv71t42AX/eob3kVR2FfJCASK
	 waNkO8dSfygbEV4ioIjy2w2M0DZVh62dCQ1Elee7F6/DtJ7T50937Sd0HnrvWRUOBpVoy
	 /nlRgm8cEVwUIqVzjXI7r/kKxFENa1GmAlhank1DUvIHj7S/OjZosRhnKnFUWZQHeTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=KM6jG51j;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468CA606D809
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 02:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 468CA606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=KM6jG51j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793846388;
	bh=8nHg2KK9YdUFsDyCN5OyhUk3RMp8EQBW/fDZ8x8OirA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=KM6jG51jfXUoSCb57V4cpBGaTQ+dTrgtvDKc7ult3QhPfcC4XqYOot3xI8+s56T5F
	 4p78QdFKgK1wTJxD2na7iIGYuuw6fGfVhGkO0ZdIlBOgi/OtzDf3u8aEo1FEXJiFys
	 Y9/rnd3Z+0HSwmDAR1GMB01LNKfhtvmSxzyyVA4M=
X-QQ-mid: esmtpgz13t1793846385tdffaa191
X-QQ-Originating-IP: BAH+a6VjNCwRD9Fpphm0b10gyJZGSPQYF+Ue9Sw3l8E=
Received: from mail-pj1-f42.google.com ( [209.85.216.42])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 10:39:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11391047176999143390
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so1226784a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 18:39:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwfBy+FrP1Tw/Y/EM3G74xUkW35qzrPALAPyEvTtC/UXwLGlmQTW68QcIMrTWyLJh0AhOyKQNk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+u5Y6SBIIeBeb/NrPZsyoNyu9hhGN4RbV3b+3/z0SKJ/FeMuVU
	jTi/WbgYVJ4l3BF+RUYXUOGtHnz//PUlNI9UhkwYk7lQDEJ/D8D3OGrjPPXPSJj4Wmg7VRfhedS
	EZRaWZ2Lw+kjJRcn0cKj+ENmI+g05WDM=
X-Received: by 2002:a17:90b:562d:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3ae8982c1ffmr16206466a91.45.1793846382617; Wed, 04 Nov 2026
 18:39:42 -0800 (PST)
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
From: Chunyan Zhang <chunyan.zhang@linux.spacemit.com>
Date: Thu, 5 Nov 2026 10:39:06 +0800
X-Gmail-Original-Message-ID: <872B2B4EAE847E62+CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
X-Gm-Features: AclHuK-lEE7dv-iC1Lsio6aPGOufL5hgelB1hFojisk2-zoMsjC0hhsp9HraOXA
Message-ID: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ivan Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
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
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, 
	Chanh Nguyen <chanh@os.amperecomputing.com>, Alistair Francis <alistair@alistair23.me>, 
	Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>, 
	Dmitry Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M4VMz4Hll12Od2RSE2pnqHYjd009pdv8uxqepaPgdhnN1qM7Opv+6B9Q
	Otx/4ApvEvHCMVCn5To/FpneeW5kY0pa2Y4VaqYF4X24CZIwtSTqgn373BvYctXVxfJThBD
	EfqfdDhv02/sfXldZUTXBJHnsjagzp7DtSP3d/IaWL9FQR+hT4gAX9HAgFrNRWohFRij0+2
	zs2KjHrzKyP4TDujAM2/Js5jn6iE5GuPJzUEu0yQ/DHGaObkwBOva5oB0Jcnem4lGNQukZk
	XNUYlrEGIgznvj7PnmkZvGmqSd/WPDsW2Hbm/Aua/77nTELmATF9/vjwLK21LQ1gjw1qGAx
	zT8kWHidgOVUox/b9pwiXqlB6fwlAPx+Brjr68g7E0/yfZUzGsj0eYzpcVB7CVe4ONUbCDU
	Qk8C1iAY9VevmSijneS7/Si45Gzhk7C9xRRyvc49cd7GwH7tkAyq+J98AH8C/KOrGi1xfsf
	ObfHx66KpnBaVM1VUMXUGMv6S8yERx83mVedEf0rSsldjx0Lh+79Vaf+Ejqadgt/f4z/i87
	Hg8EcwkJ2IUi2wmBVrWY0XqhyPdTBX43TEPfQ3hYKF/1t4phNg5SXIuYBZ+6s+OXDLMG5An
	yzr7ea9KSRz3EU6PMxu8N9xsFc3/F34GTHKcIMbV37NVuzpSMzVQNO5NZ5hlcqwyzlmfSnu
	0SUhaobQTB4LG6R3bx8rOoOid2o80TYfximhtXB2KndUejCMIOULyQtfjU7OPL6dJQbP3Yb
	Dq6VaOVriSrkNjHJhBnjLFdih5vVstBZtsAR0vt7KBn+polz15pfNL2I08Wn2Du1xljOUHY
	Oz+oNQyULOMrWYSIQO3GPwA9cg0H7s+1b7Eage8+TCQsXv/SBhOKhwk/lHfyomG3bSxs6Ny
	9dgxtLhRE7eCo70AvyVrn6jDhXaZUc+55zSZL5dDS/+JKVhyNN1rHQiOk5PbTYU08hucTFK
	ThQ08P1xXZZADwYpwFol734hUME0ysmdfcxDP/v0BAZTO5lJHgREwuFcPjqpV1Jf/kumGZO
	Pg3BJYTWR9UtO0tIxhsCi3ZXQRLRdtqT9NFOVQ1lm/TAbP92ez
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

[snip]

> diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> index afa551f6185f..222d70baef1e 100644
> --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> @@ -47,7 +47,7 @@ properties:
>      const: 0
>
>  patternProperties:
> -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan
