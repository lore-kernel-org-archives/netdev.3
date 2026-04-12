Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129483803C2;
	Sun, 12 Apr 2026 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776027647; cv=none; b=Oci9fqNnxRmnAnRSYC7mmHGFh+8Uth3oGRyns3442HGeFVxGzieDi0taQo4pIdtIuntj7mwVeFLDAt/qdX0/MxeZ7wvng3wmzbfnUfA5yhqIJaNfLUsx7WBCZhik/NnATmmKOhNOV5CrlcEIDg6aPw+fd4aycAJ10BchIXdtPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776027647; c=relaxed/simple;
	bh=0kkJrf/sN/KJLKD6+Jn3pIHPTyPnQFMi7rT5ASifeck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JLJS9HjP5k31sNFn8G67mqG6v3+FuIgQsg6GAmKliqVppCm7jVQMq/I1XBWT6sOjwJQEa0nDdi0a/tT/E8Yb6Oay1q+YeqV2o8iNYnUyXcy4ubihcDyoCqyjtcQ06Mpjddx9cXTYjgpFB5L+VWt9bgL1xuLN8MLNGqivuwLP/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of/8gkvD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of/8gkvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB71C2BCB1;
	Sun, 12 Apr 2026 21:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776027646;
	bh=0kkJrf/sN/KJLKD6+Jn3pIHPTyPnQFMi7rT5ASifeck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Of/8gkvDKzLvqeqmi3RpmPjplsfAiGHyiFtQ7k9pY8OvPRasn+GfTas3tnW/92VUJ
	 4dQyC90LklTrT/QvQ6nyN7fZIBH1r9nvvTbGVj7IZPp/2pkkSuU7/c7e82KwHNcu9A
	 bXHXJZ0+ij3WllG5yGP9fnhWJQQK35bGnLkb6Oz9wRQJxqYRViZye2HimjimGWyc2f
	 haIN/B9W5J0TjB+TacJAnM19QBnlbLD8hnb3hnDYPOMaN8T71Dd823m8IKfDnl33fG
	 nDAq2I4nBveMUcmrKvQtVYpuazWBXYnW3ETDr+CvP2YZUgFyifHZZEqpsEyZFPEt9r
	 ShHx06a3EmAyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD403809A8C;
	Sun, 12 Apr 2026 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602761904.3408407.18432734570452504880.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 21:00:19 +0000
References: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
In-Reply-To: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
To: Josua Mayer <josua@solid-run.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yazan.shhady@solid-run.com, mikhail.anikin@solid-run.com, ada@thorsis.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 vladimir.oltean@nxp.com, conor.dooley@microchip.com, krzk@kernel.org,
 netdev@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 09 Apr 2026 14:34:32 +0200 you wrote:
> Add bindings and description for SolidRUn i.MX8DXL based SoM and
> HummingBoard Telematics.
> 
> Modify SJA1110 Ethernet Switch bindings to allow SPI Mode 0.
> 
> This patch-set is based on v7.0-rc2, because rc1 was experiencing
> deadlocks with imx8qxp clock driver.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] dt-bindings: net: dsa: nxp,sja1105: make spi-cpol optional for sja1110
    https://git.kernel.org/netdev/net-next/c/600f01dc4bd0
  - [v2,2/3] dt-bindings: arm: fsl: Add SolidRun i.MX8DXL SoM and HummingBoard
    (no matching commit)
  - [v2,3/3] arm64: dts: imx8dxl: Add SolidRun SoM and HummingBoard
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


