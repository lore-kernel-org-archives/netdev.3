Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899AE2DF128
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840015; cv=none; b=rRx9eGoygIa5Vjtzxotr7+f1KtcuN/6imV/bEo90ZT1uhIyX0IBJMWymmqDthmpd9N+qwPYB9Oj+/85TKzQF3ltBgpXUMKWQw3styuDl/EsW7bMbiU9A8G5dSrJzChWHA+C5QnmdHqK4Tw7sOuCt51WbEESlq4r6UHlCpPY63EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840015; c=relaxed/simple;
	bh=prgThMa3RDaqzpouVznTJCw2SnOG3567R/8UJXmM108=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVU5sWJvw4iqi9WvzhIItkFVhjMAR66y/CsIDQ1zijGU8wayfl71wuyVADfcfxW8bP13OQ8QalLCwn9gG+i8jPGT5OAorDr72LRSdKdSM9w/bvqyVRaOq6MZ2dK7TzmBO14LnOLmovIRiB98XV8PiAo2jiHR2d4b7Q8hJ0thlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTZR654g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTZR654g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9FF1F00899
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790840014;
	bh=6/ClGyojAdsXGc/BQReGBNWEln4ElamcBkeTBZDQp5g=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=QTZR654gJuawsV8WQZ4S2cC9ejU9u172RDHPIMUmSJPwuBAhJguLbYrAKBO3SfVlZ
	 sm74izZzPBFgtQhlIPjpVxWhVJCKuN/R2lfulXvfbJl2xU1LNeBY0FjcBWTs1WZQ1J
	 rj4XeWHTMG6PM1/8VznK7/Hi2znJdpa43ADDo1Jps9FRbWuOwp8HjUXVk+e4pHkduJ
	 17TI3DWeiSk4R1y6gYZMjzCpZWeuGhKEQz5rWDvEc0OytmT3RN5urWPWZhdiqgwHH+
	 BRfQQkN6gNDz35un6zsZd4eKnJZbsNV4ZM0dRbKTIYEufYBw4TgZbNBrbgSisY6ywf
	 3hO6xBRepmygQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3ae12b79so1555614e87.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 00:33:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxk7vz4KoHMh6/51EworAocrHm9F/t+1mlC/X1nWYLdpaRH7BafrXmZSWgYbt+PYrfVvF2nFlA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIctV53mT92N8nYkTV05QubuZPFhEiE5CZnpPlelZIJy2gpkxg8
	97Glc4ZE45v4lBtW9CQUfqjeUZUYB3xiKQUQVKHUej0O+DL9eMhccsfom6zitjcS3Q0ATiVkZhU
	dKI+db5W60/iMyJcZOwAQmmXL8Uqc2PFMvr31XGLeSg==
X-Received: by 2002:a05:6512:2115:b0:5b8:f4ad:6e49 with SMTP id
 2adb3069b0e04-5ba402b86b1mr998420e87.8.1790840013059; Thu, 01 Oct 2026
 00:33:33 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 10:33:32 +0300
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 10:33:32 +0300
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260930163217.4003d232@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-qcom-sa8255p-emac-v15-0-e82f33720737@oss.qualcomm.com>
 <20260923-qcom-sa8255p-emac-v15-3-e82f33720737@oss.qualcomm.com> <20260930163217.4003d232@kernel.org>
Date: Thu, 1 Oct 2026 10:33:32 +0300
X-Gmail-Original-Message-ID: <CAMRc=MfEHHny4x8pi-M-WqvcTxFY+98TvRa1jFTKQBjYCzy8FQ@mail.gmail.com>
X-Gm-Features: AclHuK_lOavdmNlSvx0sNUPmny1qPtgCYs4QE7hryCERWbwB8_l7zIoUuzlYZiM
Message-ID: <CAMRc=MfEHHny4x8pi-M-WqvcTxFY+98TvRa1jFTKQBjYCzy8FQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 3/9] phy: qcom: add the SGMII SerDes PHY
 driver for SCMI systems
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com, 
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, Christophe Roullier <christophe.roullier@foss.st.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Radu Rendec <radu@rendec.net>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
	linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Oct 2026 01:32:17 +0200, Jakub Kicinski <kuba@kernel.org> said:
> On Wed, 23 Sep 2026 17:14:37 +0200 Bartosz Golaszewski wrote:
>> Implement support for the firmware-managed SGMII/SerDes PHY present on
>> Qualcomm platforms. Do this as a separate driver from the HLOS-managed
>> variant as they don't share almost any code.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/Kconfig                   |  10 +++
>>  drivers/phy/qualcomm/Makefile                  |   1 +
>>  drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c | 117 +++++++++++++++++++++++++
>>  3 files changed, 128 insertions(+)
>
> Hmm, why is this here? is there a hard dependency?
> Otherwise it'd be better to send it separately out to Vinod,
> this is drivers/phy after all.
>

Heh, it's always the same question of whether to split larger series into
per-subsystem threads or keep them together in order to provide the full
picture and let maintainers pick up subsets of patches. I've been yelled at
for doing both in the past. :)

Ok, I'll split the next iteration into smaller chunks.

Bart
