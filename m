Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571352;
	b=mgS3fce2/f6qWulx3uKcKerAB3F4883Mj6nz9moYVh7zx4I2LYQkdXSH6ztfglD2h1fc
	 HqTuBqq9BgQoDKDckrkN5vcM7+qXBOyrjp5IgKmp9T8ZDRN+EwdRadkgBnkLpYbfgafv6
	 1gRcS8SxoumuQQn7C4VakI+z3LVGhBlEMuMW6ED1CXjKUAFlD7LNpqtjWKBdZCNyXkc8y
	 sbDfseWZksfVsjF4OgpTuNYNvfR72jIXIzOQLF1Rt50apO5HjRsgnpePNyxAOoELkcTLe
	 w3F2K2bc5VlliNiatW1ZHciG3UqX6NZZws6l7P6qoa10xbkSeh5R8OFtwr1og1W0dNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571352;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FccY8w4XVKmL62rTrNsIiuAmg2iirAJ9NTvcPUeI7l0=;
	b=gHJVEuPoGDYDvvuDVPeXogMMrPklQpFKMaQvovgqStOx48wWGo4SB0tzswvXFpOT8lKq
	 BT6LRXioRGKGN6uhtgHJWCA7MtzKgvHoYmnqyl2a2U3rVRn3SGjnTcm+Ea3y0fDM2SP30
	 yxEu5VF9SDpTJZ1n0nJx4jO6W9aAGeXcCb+gL7f16guPQ4ITsFI72L2fkezi7vJc+r5X1
	 rALoOSYtG63mOc7awlQrMtoQixiu7uELNbsJ85dvfZC3wbWanecw6LpKksRp7nsEN47s2
	 GpDTL12zu1aWBTkGqOG1ds9oQP42jztvxgqP3TmojtmKST/pWxj3Syc2aPmQUofQnhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+V9Dv3q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8EE60A260D;
	Sun,  1 Nov 2026 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+V9Dv3q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9D71F00A21;
	Sun,  1 Nov 2026 22:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571351;
	bh=FccY8w4XVKmL62rTrNsIiuAmg2iirAJ9NTvcPUeI7l0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K+V9Dv3qcTj5160hj+SlEd6bb36GPd0hfxFxqjLqYo66VpB8oCIm4PuHm9pjlid/h
	 xICIzZcud0NUgf8UqhSDgZUnCOe+E4H24SE9jF1p7O4fFeppaF6xJ19c2x3GponAYK
	 zBB0xnPMXK3KXJyJgXpeecppENU8uStUTuAYpN58z1zi5XdcZnpfMOTU/Sjz04mpNh
	 EBDswN/2U3tv2zVNouRalxGVIPr45mrQWsWqgkUoAJAzcLHlFn+u4O5aPuxyp1V9hh
	 nqI9MBjEMOeTC+Cpzk8pdEQbjpMVozvCH8kCeYtfZV/f7RAOqeoEUa4gaQ0O3fobrF
	 9dSJrBw8PPsVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D3DF38003B8;
	Sun,  1 Nov 2026 22:15:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v16 0/7] net: stmmac: qcom-ethqos: add support
 for
 SCMI power domains
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357135004.2624073.6498267080189807632.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:15:50 +0000
References: <20261014-qcom-sa8255p-emac-v16-0-0266c2ead980@oss.qualcomm.com>
In-Reply-To: <20261014-qcom-sa8255p-emac-v16-0-0266c2ead980@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, vkoul@kernel.org, peppe.cavallaro@st.com,
 wens@kernel.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com, shawnguo@kernel.org,
 festevam@gmail.com, jan.petrous@oss.nxp.com, s32@nxp.com,
 mohd.anwar@oss.qualcomm.com, romain.gantois@bootlin.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, mripard@kernel.org,
 christophe.roullier@foss.st.com, brgl@kernel.org, edumazet@kernel.org,
 radu@rendec.net, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, dfustini@tenstorrent.com,
 linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-mips@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 sophgo@lists.linux.dev, bartosz.golaszewski@linaro.org,
 sashiko-bot@kernel.org, martin.blumenstingl@googlemail.com,
 krzysztof.kozlowski@oss.qualcomm.com, prabhakar.mahadev-lad.rj@bp.renesas.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Oct 2026 14:36:39 +0200 you wrote:
> Add support for the firmware-managed variant of the DesignWare MAC on
> the sa8255p platform. This series contains new DT bindings and driver
> changes required to support the MAC in the STMMAC driver.
> 
> It also reorganizes the ethqos code quite a bit to make the introduction
> of power domains into the driver a bit easier on the eye.
> 
> [...]

Here is the summary with links:
  - [net-next,v16,1/7] net: stmmac: dwmac4: don't program the 1us tick counter without a CSR clock
    https://git.kernel.org/riscv/c/d09d7b8e86e5
  - [net-next,v16,2/7] dt-bindings: net: qcom: document the ethqos device for SCMI-based systems
    https://git.kernel.org/riscv/c/534198a05d92
  - [net-next,v16,3/7] net: stmmac: qcom-ethqos: set serdes mode before powerup
    https://git.kernel.org/riscv/c/7af44cb9e447
  - [net-next,v16,4/7] net: stmmac: qcom-ethqos: update phy_mode to the resolved interface in mac_finish()
    https://git.kernel.org/riscv/c/05b3ea7346e3
  - [net-next,v16,5/7] net: stmmac: qcom-ethqos: reuse the address of ethqos_emac_driver_data
    https://git.kernel.org/riscv/c/92719abd6378
  - [net-next,v16,6/7] net: stmmac: qcom-ethqos: factor out linux-level setup into a separate function
    https://git.kernel.org/riscv/c/acf1e3db9151
  - [net-next,v16,7/7] net: stmmac: qcom-ethqos: add support for sa8255p
    https://git.kernel.org/riscv/c/bb3183e1c938

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


