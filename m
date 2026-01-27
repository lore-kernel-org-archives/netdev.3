Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C423451C7;
	Tue, 27 Jan 2026 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512219; cv=none; b=SCk1zq03L3c4deG72Q+8LBmcJVSjY1zHNMhxKp/z8FuvtnWwRR7oY7qtUP5UjOiCqU9QFq21MKF3FgY+t/9iH7YA+e4BqaRiInU40RuCMLcdTmyMnoS076jJlc+q2ng5PLzyCyNaS0H63R4PQ0mDlRLIpb+Hs50lpUCecT6Hd5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512219; c=relaxed/simple;
	bh=CT7gkiw9r7kylQTCxIe4QQuX3+OPKkhnoO764jxtLtc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=chMKzE7RGkZe3raI/ZKb+WacfyR7W463HVoXKGSPPpZ8kXg8AzpAdqW6SrAV1VLR9QbDQEeKmoVc/BlxaAiIJN4WSB5knOQnSSKTSAIYVTp3Yu9BrrJaE6UvK9x2/NxPF6/nT7vkG7LQP9ZuB2AD+h/yvQ92h47FWTt3akmeVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pb1lKKs3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pb1lKKs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0121EC19425;
	Tue, 27 Jan 2026 11:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769512219;
	bh=CT7gkiw9r7kylQTCxIe4QQuX3+OPKkhnoO764jxtLtc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pb1lKKs3NfyALYoWCAp4K1s0r7HsIHj3SfY6u7nAVkV6WK+FIFI4eEueOs+R+iW8f
	 +oZtjbhLCg3ajGulisJ/78kaxsK8dE6hfaqwNvCO8xSwdpdC3mHxtAbUEJuOmInELe
	 QzMr4ZBF1pdsarelRpEtLXzXrVmi5MwHihJ3l6VmXchU+KSK8r+tU4iSAv3+YgC+M1
	 CpAjs8bTjJq94IoIdz+KOMypcDUPiHUmWT0x9Jp5PwaOifo2gPVN9kBPOtf1/0NNh1
	 7nTd+8QdoOZSG/LH4SEHM21BbSI5q5VBQSLSLrLjf7PjPZaP+1xc82SJW4KcZh2Kpk
	 Hegi9zxcXQF3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EAA8380A977;
	Tue, 27 Jan 2026 11:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/6] net: dsa: lantiq: add support for Intel
 GSW150
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176951221310.797896.17949211366612962251.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 11:10:13 +0000
References: <cover.1769099517.git.daniel@makrotopia.org>
In-Reply-To: <cover.1769099517.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ptpt52@gmail.com, xinfa.deng@gl-inet.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 Jan 2026 16:38:36 +0000 you wrote:
> The Intel GSW150 Ethernet Switch (aka. Lantiq PEB7084) is the predecessor of
> MaxLinear's GSW1xx series of switches. It shares most features, but has a
> slightly different port layout and different MII interfaces.
> Adding support for this switch to the mxl-gsw1xx driver is quite trivial.
> ---
> Changes since v5:
>  * rebase on top of current net-next
>  * update Kconfig to mention GSW150
>  * allow configuring RGMII slewrate introduced by commit dbf24ab58fec3
>    ("net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration")
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/6] dt-bindings: net: dsa: lantiq,gswip: use correct node name
    https://git.kernel.org/netdev/net-next/c/b6d6f017022f
  - [net-next,v6,2/6] dt-bindings: net: dsa: lantiq,gswip: add Intel GSW150
    https://git.kernel.org/netdev/net-next/c/e7e354aa496b
  - [net-next,v6,3/6] net: dsa: lantiq: allow arbitrary MII registers
    https://git.kernel.org/netdev/net-next/c/338375118514
  - [net-next,v6,4/6] net: dsa: lantiq: clean up phylink_get_caps switch statement
    https://git.kernel.org/netdev/net-next/c/6d6228402249
  - [net-next,v6,5/6] net: dsa: mxl-gsw1xx: only setup SerDes PCS if it exists
    https://git.kernel.org/netdev/net-next/c/99f465889a60
  - [net-next,v6,6/6] net: dsa: mxl-gsw1xx: add support for Intel GSW150
    https://git.kernel.org/netdev/net-next/c/afe813fd89ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


