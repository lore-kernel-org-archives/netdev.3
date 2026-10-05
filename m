Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA63921E4;
	Mon,  5 Oct 2026 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238221; cv=none; b=H30fiewRH/K0jp1jWdureGp4xHDX+CjY/WcdHjPBakAq+6rCQVLymrN9OM0xHG3OPrcUCbtgjR4s2KbTGJTcQvF/EhW5QCvJcY7hQoSnEAELlsxBrI5ps7e9ryTOeTNikMtprDSIBpeTTXZbDr7N/g59PMRXS3wtFCv7TLaWjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238221; c=relaxed/simple;
	bh=jXOyOQt9BXH1FGTMMGku2tJHy6PtFmBruDUC+pXemMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uGA0rdoAUPyBnEB3S83ki55tov+5yeMI1NHzeFrP0QTp9rnw9XRwB63zWqHx7Ch5z8dOEIgPBuBt4hisqJ4w0sAsVcAziwEsjpXsKe1aCYlO8zUSNcUqLYVDcNcQr5yG32uxfqrwsgnHwkfIStBBaHAaA8zAEsfGkioxLYvmO4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0n+853F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0n+853F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBCD1F00893;
	Mon,  5 Oct 2026 22:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238219;
	bh=tH0ZFnziyXwMi24IcLr/Qa5eRjbd7BhoZUMwWhvyn+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g0n+853FbExRNgPbNkK1wT844PyXC3swwphioNYrCXjKJorb6+f3+zj6av1/za4Yl
	 hciImy9FmmRtcnjZS6syHkaCp9u4p9ScVOUhE0x53vlkdSE5GxVGQSvXyi6MIKy3Hg
	 SN3Q5OWMXCQCbCJNH7K7qDMxOBf06mQ9tjSZLXJbeX1lyM4Wfb8Bj1Ytap0m7Dqxol
	 imCrCwWAOwEsdGNqJlC4+EU1r6M27rM9Mzn0sdjTq53dAZ5aeUcQSRSdS2uetcEsXY
	 O/HDGytFUIs/OndO9vsz9m3sfugvJt/mG2tT5S16cFj6zYCi1arheG3tw4ZvEzPfms
	 J59J2H15QK6Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B467D3926672;
	Mon,  5 Oct 2026 22:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] dt-bindings: net: Convert hisilicon,hns-mdio
 to
 DT schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179123821827.1914306.473796169242822126.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 22:10:18 +0000
References: <20260930201906.74125-1-robh@kernel.org>
In-Reply-To: <20260930201906.74125-1-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 shenjian15@huawei.com, shaojijie@huawei.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 15:19:04 -0500 you wrote:
> Convert the hisilicon,hns-mdio binding to DT schema format. Add the
> missing 'subctrl-vbase' property which is already in use.
> 
> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
>  - Make subctrl-vbase required and fix the register offset descriptions
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dt-bindings: net: Convert hisilicon,hns-mdio to DT schema
    https://git.kernel.org/netdev/net-next/c/c0402d7640a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


