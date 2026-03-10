Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CA18AE3
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111638; cv=none; b=Wc5pUR/F/tLFPvnzyHWZxH1L6H3QtZD6GycJZv2+vdxkWGrizVPNXjAB0v32Ksl5IGWIRZCjepKUPAzYV61pmDtPxgI16sWUfV28Fx/dYttOfoOPWGhTFB3Fs85Z8PEh58Fx8FBz1jklylK/NVpjiOjZ/JxBXI2VSMicaQVbO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111638; c=relaxed/simple;
	bh=0Cds6kc09BVIRVjCoSPKhdBQsuXH0Iml0FDgoBrHwWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VljbtKMX43F9BePoPTSka1+0rlHaD6MmtFfLuteT7DsxYPJp3TPYKasmPAWSG6neyNhr6oH+2/xiDrnw4DH1sQh3gZ/0CE+CemRyoBwtPLaW6lTuaBsyvr1GxaY+1XLWoNGnExPz2l887AdL5aBpxqFXWQUTQgVBPIhQ/fX/9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3yv+jr5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3yv+jr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD9EC19423;
	Tue, 10 Mar 2026 03:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111638;
	bh=0Cds6kc09BVIRVjCoSPKhdBQsuXH0Iml0FDgoBrHwWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n3yv+jr5PBzgHxFh9U6Z63J3WEC7wrixS11Co244TfLFocCf8sEUkmggqFyrqfJRX
	 VsBFMEhcx6eENrMKibiJvD0WRBFqfmwEjqWxCzLmFr3QOAzQ0Mj/AeU+vDtyrIY16U
	 t57l01dwH7nE+gDijjkg9s+unb+f3/rx6h06n3g4PWhyhkJ3x2xvFKzDyg5PvSjmQt
	 7G4+BqeFJ6FeULNDTFr8tD5ZOfTTLGh6mR9gLujLk8y/ULYPMT+KAlIgu+JM+LsuME
	 E+8sT21I6ynzFJYdkeMWo2EIBq5QHZOjVsGldaJ+5SGaa8rDCkhqQ3bp08dh7UwjIc
	 68XAcBzf+7tOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEDD3808200;
	Tue, 10 Mar 2026 03:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: further ptp cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177311163503.2039470.12160246560923313829.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 03:00:35 +0000
References: <aawDiK7DjcSXSs1X@shell.armlinux.org.uk>
In-Reply-To: <aawDiK7DjcSXSs1X@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 7 Mar 2026 10:52:56 +0000 you wrote:
> Hi,
> 
> A couple of extra PTP cleanup patches.
> 
> The first uses a local variable when setting n_ext_ts which is a minor
> simplification of the code. The second removes the now unnecessary
> "available" flag for the PPS outputs.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: stmmac: ptp: rearrange n_ext_ts initialisation
    https://git.kernel.org/netdev/net-next/c/b560d4434f98
  - [net-next,2/2] net: stmmac: ptp: remove redundant priv->pps[].available
    https://git.kernel.org/netdev/net-next/c/687e7863f027

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


