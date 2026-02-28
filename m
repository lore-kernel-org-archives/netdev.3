Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085D307AE3;
	Sat, 28 Feb 2026 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299203; cv=none; b=FSvCaUCUBtQmbKOEUzbe5hWHYbQQLD1NO45CVWXj8ead+eYSy0Imi2ZiHADVkQkzgjtIy4A0/8wZbcesN8o8jd4llb4M2wtdHZMFydM/n5UJomEfqt11hu+4F3rX3zRpLt6/X2ID9ta7LY5fNCDxJHCSkIkCeJ0peKHkYBsY7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299203; c=relaxed/simple;
	bh=OhF8YS72DsRMISZJclWzQnqaxGkmyI7Uol113aCLDVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gclB3LdT4W64xoNCq7RhGD8xmfVm3sP+Kgn0v/l78Y1oDlOOhYRBg3yrWuQsDQwHSAzRFRaq1cRSFpEJXwXhQBmOQZ7XzrZhqaAT0rUjpdGBKkypDx/jiDaHoKnSSPKKbOygZgsxkyT8sQchwU8QfYuz9V59qHLaYyczOHrCOEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRYDRODC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRYDRODC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E3FC116D0;
	Sat, 28 Feb 2026 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299203;
	bh=OhF8YS72DsRMISZJclWzQnqaxGkmyI7Uol113aCLDVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oRYDRODCnr+XIK4HeTj2R2tvuJU3dkq55OBk+K8bA6JmRDW5iJwNCHPYQtVwotDUl
	 pefbWV5W3mWG/NRO3tscAUfQz0ne37ydri6ewNOXOsPa90X5qQ+h+dfQE+yC1BHh91
	 rjd6M7e5Jnf+FNOkH5FR6c4chcB4+XOsq8pSVlJoBUZi8nbOLzMxv727akz3yp6sjv
	 TVuMD8d4b+gcWX1ijzeGQgPniLHc4+mSVvZFtkWwY48bMHlNDicsz42ybYMOGfoFy3
	 fIv1D9eLsNFOwRIH5TZYl7tMehNleUVXndpBUJ42Is3vRLb2TzL8RwW/HX2Mta/lIa
	 WvDATrArVnDyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FFD39F2022;
	Sat, 28 Feb 2026 17:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dpaa2-switch: Fix interrupt storm after receiving bad
 if_id
 in IRQ handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177229920630.3019354.11284025791830317467.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 17:20:06 +0000
References: <20260227055812.1777915-1-linux@roeck-us.net>
In-Reply-To: <20260227055812.1777915-1-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 moonafterrain@outlook.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 21:58:12 -0800 you wrote:
> Commit 31a7a0bbeb00 ("dpaa2-switch: add bounds check for if_id in IRQ
> handler") introduces a range check for if_id to avoid an out-of-bounds
> access. If an out-of-bounds if_id is detected, the interrupt status is
> not cleared. This may result in an interrupt storm.
> 
> Clear the interrupt status after detecting an out-of-bounds if_id to avoid
> the problem.
> 
> [...]

Here is the summary with links:
  - dpaa2-switch: Fix interrupt storm after receiving bad if_id in IRQ handler
    https://git.kernel.org/netdev/net/c/74badb9c20b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


