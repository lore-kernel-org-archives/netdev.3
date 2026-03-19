Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8AB342C80;
	Thu, 19 Mar 2026 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773884422; cv=none; b=CubKux2+Dbb94JTZUJJ6n8+/xBRC3ugHMHHonCMq+7fSt/LW6YBMPnvYvjlfyVx/Jl+B2cEslVVn+pNCCpIe0eCXhoQuE4JPCWaMph07WJySw4hT3p+yBW9va5wMAG2hRGRPlSuX8yEI4CdKKK/g+f1CxIJjvtt8fgvw2SULpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773884422; c=relaxed/simple;
	bh=Etj4al/7SeZasNQkvjUUEANgd5yowKqyJtzhmtbu5Aw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CeX3FmT6wZVsgccuUS9XQrFSJUyc81qNbiQ1lJWGka0R90D5pcdg/shQxhuysCrYUCg+G/n1OYJPUmSnvb0amhvN5xjgDxDEcaR5FZzgfRUSmUXv/0cuhOpAOj8pmv/dlP4rr/4bC1ZhQonuVwJ+eFcEvYtcbkDlvnvrFli8WeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxOYLXkk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxOYLXkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5F9C19421;
	Thu, 19 Mar 2026 01:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773884422;
	bh=Etj4al/7SeZasNQkvjUUEANgd5yowKqyJtzhmtbu5Aw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YxOYLXkkaXu70yLZvGTebsJm6ewdYSQ817a8E9u8QSe9IsJoTIYN5azFNjCgh0Rx+
	 TasCZ6uP8uoXtaOWPJGGSevA55NnQjTgDdUQ2Mdlc4ApURTeD/5222bTvx/pnrSQJE
	 p3MfDhzFu6gsaDaDfWeLzZGBzZpGcEaPlLXqZUVtnDnulwPou3Q+r4YNIMnPhmO6ZZ
	 lISOpbM3db3O1XoECMWenCaC+Ve0GlPorDlLYxgQ3wI0gSzGLnCiLK5rjGnwhp8fo4
	 NzVR/kSzhfdJPkhR/39RJjBmtbXkpwF1BOOW+zOE0YcYnl2SFe5Znv9mY0TEBvqoS/
	 J8yZEIxqQfr+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1333808200;
	Thu, 19 Mar 2026 01:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: mdio-gpio: remove unneeded headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388441353.982294.16887647711350693574.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 01:40:13 +0000
References: 
 <20260316-gpio-mdio-hdr-cleanup-v1-0-2df696f74728@oss.qualcomm.com>
In-Reply-To: 
 <20260316-gpio-mdio-hdr-cleanup-v1-0-2df696f74728@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linusw@kernel.org, brgl@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Mar 2026 11:04:02 +0100 you wrote:
> This removes linux/mdio-gpio.h and linux/platform_data/mdio-gpio.h as
> they are not needed due to the symbols either being used by the
> mdio-gpio module alone or not used at all.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Bartosz Golaszewski (2):
>       net: mdio-gpio: remove linux/mdio-gpio.h
>       net: mdio-gpio: remove linux/platform_data/mdio-gpio.h
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: mdio-gpio: remove linux/mdio-gpio.h
    https://git.kernel.org/netdev/net-next/c/9c6b4009da59
  - [net-next,2/2] net: mdio-gpio: remove linux/platform_data/mdio-gpio.h
    https://git.kernel.org/netdev/net-next/c/356d4fbcf3de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


