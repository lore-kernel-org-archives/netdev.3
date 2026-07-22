Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7A43D508;
	Wed, 22 Jul 2026 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758252; cv=none; b=ZIBqOAcq8V/1+87Fzt83XCmDCmlc61BfPpmFSmmFhjTyfTl6hHbHDjmzJlWYIkBGRSu5PzTfLOaGihfKgIKybV7tzKzISj6X5sjTTjBPPRkORqGbJMoAVAr2+C5FL07EKK5TGILEXmmCowOtwGfe1BomOPpPPkHXnJiTBkTztcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758252; c=relaxed/simple;
	bh=EiRXLAO0kIIaDFnM2RrFVOGaGdI4o/c5UJzI1mPtzYE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wc2SOyzXO2EM+z9dqV9US6B32AoadurDMkS7b37lccqTAOvPkRgZEY/BuyXrlqcdO1BhnfCad1RL3t86UVzKVAx1fUClp7MdxZA8cuIWzPnoxctvzfrrRZTdDTEKFhgDiIm6PzlONe6qmV34oXv1rI5l3xb5TRaodq5uFrCjKy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNAj8/Ue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNAj8/Ue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380641F000E9;
	Wed, 22 Jul 2026 22:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784758250;
	bh=vO4dOrRhzNPjMz8/QxPObGp6cgcquyLhw+VK7bXgaCg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kNAj8/UeZFNGwPsdnUq4YdtgfAA28hyuDN5SzP4x+Nnalaj6H5agbyJRZcNKRtdWm
	 Y6/ecydGy24g/y9qcZ/NjIhVoEnNpY0C1Ossj9O8FRpgmTUKFxQLt9LFX6Tn/viF9y
	 E94VfJrlvP51a0/CV6Zjj1GCqdqkvYhZVMay074AOST3bUlDn65xHiCg65nM5tGX9t
	 O9egyQ87Z+YG0j/sgRmlyhwlcf+xMLn435MUKfSnG+9Z48A1FmlLv1hHcVuCfPrAF9
	 3/2ywsGWeiMBQpSO3sHaxVPXmJ9NXjgIeS1jkV/MkeNcEMbaSrBkAHrWNK0FMx4mTK
	 5mWcBRzflaIJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199BC380CED7;
	Wed, 22 Jul 2026 22:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: motorcomm: Enable optional clock
 for
 YT8531
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178475821864.2043959.11664720343882039324.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 22:10:18 +0000
References: <20260714-motorcomm-yt8531-clk-v3-1-10dc303ef1a5@gmail.com>
In-Reply-To: <20260714-motorcomm-yt8531-clk-v3-1-10dc303ef1a5@gmail.com>
To: Yanan He <grumpycat921013@gmail.com>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jul 2026 21:11:01 +0800 you wrote:
> Some boards feed the YT8531 PHY from an SoC-provided external
> reference clock described by the common ethernet-phy "clocks" property.
> 
> Enable the optional PHY clock during probe so boards can model this
> clock as a PHY input instead of keeping the clock alive from the MAC
> driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: motorcomm: Enable optional clock for YT8531
    https://git.kernel.org/netdev/net-next/c/42310a24389c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


