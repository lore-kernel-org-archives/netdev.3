Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4A6273D8D;
	Thu, 29 Jan 2026 05:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663438; cv=none; b=N/Z7lcOSefpq/wAVhno0uSubapQbXNYayF8ifj0z6JjEMA7hDqToEEPtqxsUnNGAHLVeOggEsOyle0thCqp0whAtkCuxOn9RLqrKchwQsPzKwQFrJhc5leDTaSpEbn+UcMJmDOLEZt9tRkRGV6yEiQ9P+qczltjuLIvXcKYasvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663438; c=relaxed/simple;
	bh=/QRvDVT9GAiToi3v8vcF+/vGPRfAWiWi238lSh1gI44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wc1jVxFcJ0TWTFZQA6IVNlpQ8qCcL3JBy9WvRx7mdQljw2cxPneMiI5TxXDOrpUwxK0hAJoImeiZoWC9E0VwoiWqfyMhjEJ/1gm9SFukXwKuaeNdDxwILqoFoP+3RDqz0ZTzwh8aqo7zrAywKDrU7VTEEj2NoIfYf89AmapwH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6V3DB04; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6V3DB04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB9FC116D0;
	Thu, 29 Jan 2026 05:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663437;
	bh=/QRvDVT9GAiToi3v8vcF+/vGPRfAWiWi238lSh1gI44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6V3DB04Gz6boAr8Vs3t5FEeQjtRG5O84q1Ij/YXCv8c2F0w+MP9w1Tl2kPB0FcD4
	 Xl/KgTLm0SxwSQJXbGYJ6tfseKUXZ+CFjkOf/nUEoHgjuj7x/FKMxVShY+7j4ttbhZ
	 5+sfRBkBxbb962nCJs7GbfVtdy768H2Exifqa8Ha+bB7KZvUd4Xo/aKskK81XNQGkw
	 lnlgJId6jwxkrazRSAnNzK8/QoGifKaPigQScm3ox0Q/GRuIa18M4rZWDdeRxfa2zP
	 LTWyvIAL7Ydpp1ig4pj/yLFBMNtFHQ+unTB2PyaqFIOEAul1W7rReRwo/4Dg3LnP0r
	 jlcHsRNYrgHlw==
From: Jakub Kicinski <kuba@kernel.org>
To: dan.carpenter@linaro.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	jan.petrous@oss.nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	imx@lists.linux.dev,
	chester62515@gmail.com,
	mbrugger@suse.com,
	netdev@vger.kernel.org,
	s32@nxp.com,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	kernel@pengutronix.de,
	linux-stm32@st-md-mailman.stormreply.com,
	shawnguo@kernel.org,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com,
	linaro-s32@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	alexandre.torgue@foss.st.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	s.hauer@pengutronix.de
Subject: Re: [v5,2/3] dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
Date: Wed, 28 Jan 2026 21:10:35 -0800
Message-ID: <20260129051035.375905-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <939fdaf94038613486bdbba510a92a1e57e18c71.1769592679.git.dan.carpenter@linaro.org>
References: <939fdaf94038613486bdbba510a92a1e57e18c71.1769592679.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon

This commit adds the nxp,phy-sel property to the S32 DWMAC binding,
allowing access to the GMAC_0_CTRL_STS register via a syscon interface
instead of the previous ad-hoc direct register mapping.

> diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> index 2b8b74c5feec..65633b10e49e 100644
> --- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml

[ ... ]

> +  nxp,phy-sel:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the GPR syscon node
> +          - description: offset of PHY selection register
> +    description:
> +      This phandle points to the GMAC_0_CTRL_STS register which controls the
> +      GMAC_0 configuration options.  The register lets you select the PHY
> +      interface and the PHY mode.  It also controls if the FTM_0 or FTM_1
> +      FlexTimer Modules connect to GMAC_O.
                                       ^^^^^^

Should this be GMAC_0 (with a zero) instead of GMAC_O (with a letter O)?
The rest of the description uses GMAC_0_CTRL_STS and GMAC_0 consistently.
-- 
pw-bot: cr
