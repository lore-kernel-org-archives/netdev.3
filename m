Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C0F78F2F;
	Fri,  4 Sep 2026 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788480673; cv=none; b=j9O2uavC5KffWJYczLF3KZBF9z+cOEdCzFTpYQegy2HqiAHTfKyzqUelbqocHkEer7FsIumrR446ZoUaU+w5ZdUQGClOXZH9W/qNk5jI1qrjFj2KN4vrI/jAIgiGtvyYZi/Hnf3nRSDGFciNcRPshWDuLCM37bc7z2ti3rasuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788480673; c=relaxed/simple;
	bh=EiTcvI4B6l0ePJkFefHi0zPw+R3AbkT2yuq2RDEK/xA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=do9NmoRjvybY+b6sCnoyGLCjuByJ/N4FYU4XMzIWh4LPy6lCf6pBVSRDA7QC0ampd4byJKuw74oSeY6+oE0zXfjHBYtqOYcFwwe6HIxWgrQIj1/tBT/zA6d2YiJGwcNZe2tCTNifx3a55f6znpbdp6ym9ec7vtkxA6nLpvc92kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlkZ7jbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlkZ7jbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18DD1F000E9;
	Fri,  4 Sep 2026 00:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788480672;
	bh=6igfylbiPVH55AzQH8lmo4FGKJAEbNaVtc7IkHl15UQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OlkZ7jbpGyCOa/V6KcYnKC196+ll9RLBQC+xTTSpYy0y/yX3PDpLToLaGfZnRgqIG
	 gyWuVFHy+6Y4l+AK0flugcPqdyz8aS98vwtAwmKn2NU2Qy5W8IcRnmGeAgpQNWhZLG
	 oAwUPfo9+32Vp6HubM+XzkSHj9kcTcNm7q2xcT77arKF9Zh0kbc6jAIJbO/c5NguvY
	 +A7wdn/uaH2EwirSEzBJb8R5JVCTyVh/Pn+SitrKllj7jjbJbetvRy1u8u5LQLNu9c
	 vkNM/lnvY/ogLEmodQSax5z2LK745YQi1+tpyziB8lAcTDxCM75bpt26XCy9lmxkss
	 Vi+QJ/fBbSzUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569D338119E3;
	Fri,  4 Sep 2026 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netdevsim: take bus device refcount before
 registering
 device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848061288.4080441.9633200438937067830.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 00:10:12 +0000
References: <20260902025704.34606-1-adrianox@gmail.com>
In-Reply-To: <20260902025704.34606-1-adrianox@gmail.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org,
 syzbot+989ff6506f5c6d1ff56b@syzkaller.appspot.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Sep 2026 22:57:04 -0400 you wrote:
> nsim_bus_dev_release() drops nsim_bus_devs when a device is freed, but
> the matching increment was done in new_device_store() after
> nsim_bus_dev_new() returned.  When device_register() failed inside
> nsim_bus_dev_new(), put_device() invoked the release callback and
> decremented without an increment, driving the refcount to zero; a later
> creation then incremented from zero (refcount_t: addition on 0).
> 
> [...]

Here is the summary with links:
  - [net,v2] netdevsim: take bus device refcount before registering device
    https://git.kernel.org/netdev/net-next/c/d5f5853f167f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


