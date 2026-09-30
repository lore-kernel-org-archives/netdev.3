Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871BD4A499F;
	Wed, 30 Sep 2026 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811140; cv=none; b=U1CjMpMSGWbEXpiFsYw4dWqb899crKLIa94Gpa1fzCKvqZl53/LBA+QY//PM57JxgjGHQ2oIku0lMQguSituHFwX4EG3hB4BGYWmVDh6RXJDpGpVTy8a3llmpfcW2hzDej/cRuxhqPHkmejRzi1Uu37RxY4zXUw+/474OCQ5d/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811140; c=relaxed/simple;
	bh=klMsnEP+vb9DhYgoK6Y/sENCG6Q3x+RrqvetvjVh6zM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAU44vK1MFSJHz9XgBSCO08e8oMeRsOksD9VymdgV/RBXyFb3YB7dQTyHomHO1jF72jwV61n/Y2XduHGqljMHaD7BhmAxiiAOwUNEUbcZF9pq2YJe9jg+u3uUUBfvq5HWc6hkPKi335MEvmFJzJM/F5fqURnlJqxHI/bDTxw4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKzKQScV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKzKQScV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C3C1F000FF;
	Wed, 30 Sep 2026 23:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790811139;
	bh=ng115hWZ2LMwKhDc1Httr+OsIIIboQhXGl5/aPDAQoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YKzKQScVQVhjWvsISsBvvd+RZk8usvWcSOdVDF+hEZmkCSypcdgnfyxLAOWFWnGUi
	 QQEtlC7xApH7XqyAoqUafqECurZATIh9SGxK2FQ0WsjPQgbReJZlKuzNRlqWqi4EPw
	 8SPR0Dl+eXnngN0zEKgnmlMMy3a9TkzwfiLB0VmPHYpMR3k8e0iCbwYDWCIiRllFh5
	 vOckl23hCF9F09n+LN0KGaC+Y1drrkXrkVoBItWgbdX7P/CqiN3H9WihVWBbDes6E5
	 hmQ9VdXbGtwO/GBtB/pNrkR78Ld9LQx9p6P8JW2bgZbSZTLc3hZldUygvFbZw/h2IT
	 rp0CwiCFJHtvw==
Date: Wed, 30 Sep 2026 16:32:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Vinod Koul <vkoul@kernel.org>, Giuseppe
 Cavallaro <peppe.cavallaro@st.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>, Fabio
 Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>,
 s32@nxp.com, Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, Romain Gantois
 <romain.gantois@bootlin.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Christophe Roullier <christophe.roullier@foss.st.com>, Bartosz Golaszewski
 <brgl@kernel.org>, Radu Rendec <radu@rendec.net>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Drew Fustini
 <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
 linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
 linux-riscv@lists.infradead.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v15 3/9] phy: qcom: add the SGMII SerDes PHY
 driver for SCMI systems
Message-ID: <20260930163217.4003d232@kernel.org>
In-Reply-To: <20260923-qcom-sa8255p-emac-v15-3-e82f33720737@oss.qualcomm.com>
References: <20260923-qcom-sa8255p-emac-v15-0-e82f33720737@oss.qualcomm.com>
	<20260923-qcom-sa8255p-emac-v15-3-e82f33720737@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 17:14:37 +0200 Bartosz Golaszewski wrote:
> Implement support for the firmware-managed SGMII/SerDes PHY present on
> Qualcomm platforms. Do this as a separate driver from the HLOS-managed
> variant as they don't share almost any code.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/Kconfig                   |  10 +++
>  drivers/phy/qualcomm/Makefile                  |   1 +
>  drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c | 117 +++++++++++++++++++++++++
>  3 files changed, 128 insertions(+)

Hmm, why is this here? is there a hard dependency?
Otherwise it'd be better to send it separately out to Vinod,
this is drivers/phy after all.
