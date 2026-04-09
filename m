Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F235DA44;
	Thu,  9 Apr 2026 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721630; cv=none; b=qBiw0trfstwPwA6doKtSdVEkaSl/Q5eHTZpPrm00Cf26zU70fJpJs/OczJ1CwW8lFEpaFp+I+0Btj92Y/wYaQNgk5zFH0oy254da419JH4R+qygk+00JEVClx5MNVK3lFeUXUQeri+5Buargkiue1kSCYXddEeGRJgTtuPhkf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721630; c=relaxed/simple;
	bh=vWhJwvXJLo5iz6DRP2dmGFaGe9c+eA5slOqT30o7uIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gk7Wlm+RWonjERjTXUF32Cvih/dKDP1JI1ERXoKD3VH6/suzf9AR3pLcwtpRxMBNQ6w5urxFhRtJeWkI/7HMfrN44APfPcHALwuPd/geATbALPGiOmLff2CRt/W1D4gI6VxC9Hk58tUc4DgUlRnl0vjqe5hZP79t21FRnSBl5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q14kSXwU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q14kSXwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8469CC4CEF7;
	Thu,  9 Apr 2026 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775721630;
	bh=vWhJwvXJLo5iz6DRP2dmGFaGe9c+eA5slOqT30o7uIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q14kSXwUk1N02mrzc5h+DXMR1JKBV8ri8A8HQu6QKwvwTpjk6yemVIQCBCnuu0wtg
	 03ch1CrsNlA/nnrnov5P0ZADVJ8jcDNeQV3KaLGvKHWibJm8bkJclafpIimh8MF1Zt
	 1sS6OqMXbN03e0xlnxZtShbdEGk5FGMDQTxZeO5Lw0OQ16/41rTCM/ZnrRm5sItk/t
	 D/eveuaZ6mF6ELfiMpv6amrT/arwxCtYt9Hya3GRIBzRRHVFOIzM8BdDvLYslgLIfb
	 VMqzGKdKiu2QiS5gYJhpaRSIuUY/geXct/P4swixqAZW2g4aYXBiqb49lbaH0jAi0J
	 MLxubjzDddVrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E0239307A6;
	Thu,  9 Apr 2026 08:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/6] IPA v5.2 support for Milos and Fairphone (Gen. 6)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177572160654.1053850.6904532011284602186.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 08:00:06 +0000
References: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
In-Reply-To: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, akoskovich@pm.me,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 03 Apr 2026 18:43:46 +0200 you wrote:
> First, two fixes that unbreak IPA v5.0+, which can be applied
> independently.
> 
> Then add support for IPA v5.2 which can be found in the Milos SoC. And
> finally enable it on Fairphone (Gen. 6) so that mobile data (4G/5G/..)
> starts working.
> 
> [...]

Here is the summary with links:
  - [1/6] net: ipa: fix GENERIC_CMD register field masks for IPA v5.0+
    https://git.kernel.org/netdev/net/c/9709b56d908a
  - [2/6] net: ipa: fix event ring index not programmed for IPA v5.0+
    https://git.kernel.org/netdev/net/c/56007972c0b1
  - [3/6] dt-bindings: net: qcom,ipa: add Milos compatible
    (no matching commit)
  - [4/6] net: ipa: add IPA v5.2 configuration data
    (no matching commit)
  - [5/6] arm64: dts: qcom: milos: Add IPA node
    (no matching commit)
  - [6/6] arm64: dts: qcom: milos-fairphone-fp6: Enable IPA
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


