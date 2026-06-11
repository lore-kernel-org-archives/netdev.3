Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF753911C3;
	Thu, 11 Jun 2026 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217614; cv=none; b=oB3PRbkiRHu0AtQyEhcQdN3/Jv+pYPDc2rBQNR3L9uAwUXjdFycTMSXOqotoptYY4rJqbLJHJXtAYN8ukfaUw5vUImobw9XWt8ham4aONooQjxEwvWWQfygM5b2YVm+Iz22sCj8oiTAHDlBHB5T8z0GVF4OgdnxyqOtVkxIXJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217614; c=relaxed/simple;
	bh=RY7CxJeIveyKbuepkh6uGaQu1Y4O2yPcM3s2Fs3qnrM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aNOFiMo82YXI8FfmZaGd1nGFK51YnsEX5HCjQWw3mFPDhivrTg7ub8nYbIY3y60OeNNHVKWoPha35fxaYKqSEzVPzdClZoorHljy0djrr7zAyloSGPe8czNKJwda6a0AkYISPLFOce1R+n/pKNDP1gLtEjQ8YrUpzzjMlhXGFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjUgX1FB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjUgX1FB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D241F000E9;
	Thu, 11 Jun 2026 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781217612;
	bh=yzBvDN3ySHiDTN0aX1O6FkoHQ6Jtqg3Qawn79gL14FA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HjUgX1FByKXb2OD6trFjME8d4Ju8zc6fbdk26+uBUdOgHSovnKnSYUF1t+ZKA6Y1O
	 v7tiRjuykWJWxcak5OfADB2bdcUzYWBs3BgDYNxBNFSv23OHSfUcSARjH9Tr6Rde9K
	 cgG5GA6h5KpIZzrFXGweodXiSukaI7n+3y0DM/RQgoMxw2e82KRt6QZJV4xUnVqeXP
	 rWHCk6Mqh9thLoZakzXNSpLx97kACHAv9RF52Zl2OcyXsHkS1c/t38jrEk8AFVGT45
	 TGnKyB2PxQPooAFq34QSAeVVFt/s8vJumrdbRbEImvjduS+P9BJcsIu6l/EKr1mVCE
	 4lpetApCZxi8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199B93930FAF;
	Thu, 11 Jun 2026 22:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] IPQ5018: Add and enable GEPHY RX and TX clocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121760964.392273.7381174880248445354.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:40:09 +0000
References: <20260608-ipq5018-gephy-clocks-v4-0-fb2ccd56894b@outlook.com>
In-Reply-To: <20260608-ipq5018-gephy-clocks-v4-0-fb2ccd56894b@outlook.com>
To: George Moussalem <george.moussalem@outlook.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, andersson@kernel.org, konradybcio@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, konrad.dybcio@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, conor.dooley@microchip.com,
 dmitry.baryshkov@oss.qualcomm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 08 Jun 2026 09:09:15 +0400 you wrote:
> Greetings,
> 
> This patch series addresses a missing hardware description issue for the
> Qualcomm IPQ5018 Internal Ethernet PHY, where the data paths fail to
> function correctly unless their dedicated RX and TX clocks are
> explicitly enabled.
> 
> [...]

Here is the summary with links:
  - [v4,1/4] dt-bindings: net: ethernet-phy: increase max clock count to two
    https://git.kernel.org/netdev/net-next/c/19e00bdfbb1b
  - [v4,2/4] dt-bindings: net: qca,ar803x: Add clocks for IPQ5018 PHY
    https://git.kernel.org/netdev/net-next/c/fea4ae4b5b50
  - [v4,3/4] arm64: qcom: ipq5018: Add GEPHY RX and TX clocks
    (no matching commit)
  - [v4,4/4] net: phy: at803x: add RX and TX clock management for IPQ5018 PHY
    https://git.kernel.org/netdev/net-next/c/cf6077e4903f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


