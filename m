Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7D30F7FA;
	Wed, 30 Sep 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733007; cv=none; b=A8pLFGDiu76VcGYP5vcABc/mGpyYAXNgvJeoC/oC+OCIVTuXub1zh5QkXtmOrVxWZWVix41jsDxuKBY0hntnkH6zz8ITwYt9IT2YQxE3oKts7O7m9df+5JYRSFC1Z2THVWlh51B67M6TF2yug4RpGC+aHpwu9nLR4Nt8F/FjrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733007; c=relaxed/simple;
	bh=Ml3vNcdJW6ri/ZLlXNC9+TY6Pb4AY9oC8pAzCxel0aY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o69XyKfKKLHqj55qdGvmvsDvLEm2xh1V86p0vFb0JG6gTLyvSYMCK9LR6rIBmExUGLaH7awcSUZexie46f11zxHl2Wrrjj7N+w0Tqg3nw/bUlfo9ABsKmUi72VtwQRtyAu4iFkDmH8kNG8afpIjZJ3W41nGEMmoTT9rVxU6u2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYAjBSkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYAjBSkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073291F000FF;
	Wed, 30 Sep 2026 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790733006;
	bh=Nk+UUTf9JXcqEDE+S+PEz11B0VuCM1QB2A36z1POzi0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kYAjBSkIaatxHGARCU9Yjqem8iShDEXqZWfczwjNI9DH9njF5A2mo0agWk1Kdy9L2
	 SJPc6fUgSEycKMjG1/Iu0fLn7YNp6jbIpyJNK8wfKGqEfiaey7prtNIDN2yGyYJ6O0
	 PntlIUZnZGS4TS+iWaj+y0JZLhEA4BjfVicwxfOzOTflDs0Nfc7wpGIZTbQbVaoJ14
	 tA85KzNZOQqjTuq56Q/6SFhQb5cZZxY3fpuRPYiqYIBxXmUErCRt29qQU1g93P6Slm
	 e+bnMil69lzafHiAZy2tJIcTYjaygn6QyTKA9Uiae+41yw/Ej2h+IeBsg8Bv/wuCVl
	 v4d/UeT2cwyVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15503924FEA;
	Wed, 30 Sep 2026 01:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: qcom: at803x: Fix IPQ5018 short-cable DAC
 values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179073300479.1202110.17640935695557451649.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 01:50:04 +0000
References: <20260927155136.2489-1-yongzhao.derek@gmail.com>
In-Reply-To: <20260927155136.2489-1-yongzhao.derek@gmail.com>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, george.moussalem@outlook.com,
 hzyitc@outlook.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 27 Sep 2026 17:51:36 +0200 you wrote:
> When "qcom,dac-preset-short-cable" is set, ipq5018_config_init()
> programs the MDAC (MMD1 0x8100) and EDAC (debug 0x4380) fields. Both
> fields occupy bits 15:8 (IPQ5018_PHY_DAC_MASK), but the value 0x10 is
> passed unshifted as the set argument of phy_modify_mmd() and
> at803x_debug_reg_mask(). Neither helper shifts or masks that argument,
> so both fields are cleared to 0x00 instead of being set to 0x10, and
> bit 4 of the low byte, which is outside the field, is set.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: qcom: at803x: Fix IPQ5018 short-cable DAC values
    https://git.kernel.org/netdev/net/c/20f3599d85b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


