Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD961274FE9;
	Thu, 19 Mar 2026 03:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891104; cv=none; b=iAtfvuRe3HThNgfAqwuzafUjE1Dt3zfp4+3uYiHgQT+7kdyeLM1lbpTvgrwcvaYUNFz44uDRZ6ofTV7z6FvEQR90mPvD/erTwBoRt3Q6BWxAYsMgWW0i+w/sEtTLvF0rOTa5Xw0eiVoG3PHK5DhgoocufDdn4FfQ4XM8PgbZeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891104; c=relaxed/simple;
	bh=m+7yrCwC+pKYWfsgDv/RmSxQGUtkYG7HQcXYhhoK1Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbfJjjB24UuLpeMzZ6F7MKpaV/aY3oe6LLQvPJ6v6n9BA5mKUTDQ8Yj5Aw5pl9MjNNqRIvkTsNBVrP4voJcL5c0pj6tJzi1G0GrR8QBViW08yjI3GycOirlmCQDZAbLtR+LGRTep9iUQ63DTVnkxR2i/X0Po8nM5ssFEQnPIFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL2OWio9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL2OWio9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA2AC2BC9E;
	Thu, 19 Mar 2026 03:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773891104;
	bh=m+7yrCwC+pKYWfsgDv/RmSxQGUtkYG7HQcXYhhoK1Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cL2OWio9s/e8WqQqUw+A10U0mNOcSuv+0NpUIL0/w3MjH7yj3L1xiD+z1njhimWoL
	 EFNJXtPOX0WKVydg7ozZAhJ0Bj5ypCLtdvfOXq6TDTvltF+Wz9On/Ip3orcKQaJ+EU
	 JjTSMagtrxYn1zjRB9efoDG5xw6IrM5pPxnzCHSMcQLDdbffoPTZgwIWJ+evLfsNFO
	 8YaoD5aNdk0Ou1dfjAgDqO1jTB2bhB5lfnyQ3BfMGJi7QOZdWBlM3LGR92POkR5Tad
	 NdD+6Zx8A1qygq006LFuHaAGctmk7mRawSdcpvpQr7vlrGNZAXQ1PM0my8PuqkYngz
	 nbR6l2HCmd17Q==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: richardcochran@gmail.com,
	r.mereu@arduino.cc,
	m.facchin@arduino.cc,
	geert+renesas@glider.be,
	arnd@arndb.de,
	dmitry.baryshkov@oss.qualcomm.com,
	ebiggers@kernel.org,
	michal.simek@amd.com,
	luca.weiss@fairphone.com,
	sven@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	kuninori.morimoto.gx@renesas.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/7] arm64: dts: qcom: Add support for Arduino VENTUNO Q
Date: Wed, 18 Mar 2026 22:31:19 -0500
Message-ID: <177389107887.16612.14059777501996296925.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 13 Mar 2026 10:38:15 +0000, Srinivas Kandagatla wrote:
> This patchset adds support for Arduino VENTUNO Q board, which is
> announced recently [1]
> 
> VENTUNO Q board is based on Qualcomm Dragonwing™ IQ8 Series processor
> along with a dedicated STM32H5 microcontroller.
> This patchset adds support for below peripherals
>     - USB Type‑C connector with dual‑role support
>     - ADV7535 DSI‑to‑HDMI bridge
>     - MAX98091 audio codec
>     - 2.5G Ethernet PHY (HSGMII)
>     - PCIe0 (to onboard WiFi chipset and USB bridge)
>     - PCIe1 (to M2/nvme)
> 
> [...]

Applied, thanks!

[7/7] arm64: defconfig: Enable configs for Arduino VENTUNO Q
      commit: 56f809222ea762f38f58e01d09aa58f0f3c4b788

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
