Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E92877F4;
	Tue, 16 Jun 2026 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647219; cv=none; b=jXWpSRolj4O5bmc3v+mj4dmdgTFzVLBXyJsGDmhNoBuWcrV66Vaa+Vlgm8m71F+nfJHp84iy6idT/7+BmoVLyrPl6HGtZM5HJw5/a4afmcWb0HycgD9yvznP6smNcgnpFbgRFNU1fxzAH9IZqsezI24aYdi0S2th3pJp2URF60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647219; c=relaxed/simple;
	bh=7a+p+OyXk5sFsbk1C1Cq816Ny9n0Mkp9sVLu/7ongXE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JrOYpqVwAfau0HuXgTvWUbhnLBuAKsuK6A15xr1QYcibJqwLG/qbrglOaST/56r/ThPNj4Bc2t+igTB+9sxlRznJWEZEDAem+Osx1k1smYx4VkHxzu4vzySrZHuXb5CMRWtC9qhD9hhJgFjfQro5hCMG7V/xTKs2TNTyuDRZOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1H0XPZ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1H0XPZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11601F000E9;
	Tue, 16 Jun 2026 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781647217;
	bh=ga1OeZSzR83I+bdZkALtFqlm11Tz5ZprDN2LnllVuuo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m1H0XPZ/YZbBgyH3tnrJ6j1r2M6+6elhCGuK0pN6k5a+sJSKsxxgIBnYMzgNBg+aw
	 8al1mUPkhgyi2bTVabXIYMFi/z5l4yV3wd6csAqc8I2mwclV8BxOmBPlGOcMtIo/ZG
	 wEg/r+6LoZPDh2ODMtYPbSPzrG48yfugOVhBI97AdZ7c8txuTlA276H8jaEnUntKSY
	 KgWy5tWRv1vQI8NErJqgroIv1pfhFiKdw2BZck/RCdw7Phs4t5+P6SaatWwO4rYFIQ
	 HTGCnonB9DyI7WfMUOqJG00HcUeqNVm1R+0aEbhZQHFrTqOfaICHHS4LarNk2bCyyi
	 Nrq80K5Jm6ssA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938A13930C2B;
	Tue, 16 Jun 2026 22:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178164721213.1257010.7015290603652926955.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 22:00:12 +0000
References: <20260615222935.947233-1-kuba@kernel.org>
In-Reply-To: <20260615222935.947233-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
 mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 15:29:33 -0700 you wrote:
> This tiny series moves appletalk out of tree, to:
> 
>   https://github.com/linux-netdev/mod-orphan
> 
> Core maintainainers are unable to keep up with the rate of security
> bug reports and fixes. Nobody seems to care about appletalk enough
> to review the patches.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] appletalk: stop storing per-interface state in struct net_device
    https://git.kernel.org/netdev/net-next/c/023f9b0f2f4f
  - [net-next,2/2] appletalk: move the protocol out of tree
    https://git.kernel.org/netdev/net-next/c/8a398a0c189e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


