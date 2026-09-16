Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9522083;
	Wed, 16 Sep 2026 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517478; cv=none; b=O4hQxu0QD6zuu+UcTqV+jC63Z6YucWe9RGbofYsnR6Jlf4DJBcs/TOGtQz2aRBJa5bwWPQvpoJb9DyieACxQEkcNDd4LlPzZcYNOmUQ4ffRnAa3tGRnIDj3dNtPaN6wV20ZCXkQLbQEx4f5UrOof4pMNmHM68NzLcPMHB3Dlbvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517478; c=relaxed/simple;
	bh=GKjByeS2V20YpgXXvnRu+fWanA37sRO2r1CVQ3uZEyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cmb7JDc5TRMRKvyJGnmLqxUSGNXatp9cvCfiKo/9RhROm1AJi2ts9NMOYkXgrY5f6sVWEAL4ZOO/MrrD9cQMD1nj9yt79hdQpoi5MKvZlKJRIenOVMVIyIH6JzBAz6TGEruAoJXykoLimFCka08LEo05dylRGJC/68bFfsVeBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIbM5vTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIbM5vTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9EC1F000FF;
	Wed, 16 Sep 2026 00:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789517477;
	bh=5rK1rWnBh++gROsv+UyY1GaDgnU5dFOCi7UFPW2r/WQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CIbM5vTfUoa/hp0YqfyeGQCRL+TqbBXFoUX0Ab4ixOTNfQ/GqokjgbXiGNwP49moZ
	 eID6xLdciBY91U+pANvSTOMJaaBugKpVSjlTe1D6csjYoNYT9endwYQsK21Efu6pk2
	 qDG/GB5DvCamcgPAtw96ot7U3/Bo92PhWKz54UuIHxyz5LBux8cXCjy4k6kTV1UaUt
	 yHQ9NN/Hv6iI7V5a+aHKT51WGjE8HVIhF4JYa4SB+qX0CugB+livcREk4fdysxrLt5
	 2u6w8NwTWhiLfhm9fOIdEvTI2nlcag6WSkGm8a944YJVhUUvWCXhwD54tLLvSKyBZL
	 Wbbf+439d+mTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AF7392706C;
	Wed, 16 Sep 2026 00:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: realtek: improve firmware write
 speed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178951741112.2328807.2101088633373412951.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 00:10:11 +0000
References: <20260911094527.1928-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260911094527.1928-1-javen_xu@realsil.com.cn>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 freddy_gu@realsil.com.cn, nb@tipi-net.de, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@makrotopia.org,
 vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Sep 2026 17:45:27 +0800 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Firmware execution routine unconditionally uses phy_modify_mmd() for
> all OP_WRITE entries which introduces an unnecessary read transaction
> when updating an entire 16-bit register. So we optimize this by
> checking bitmask boundaries. Use phy_write_mmd() directly to speed up
> firmware loading process.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: realtek: improve firmware write speed
    https://git.kernel.org/netdev/net-next/c/3d989d1f40a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


