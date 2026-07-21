Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7C434E5D
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664044; cv=none; b=M007pefZNO9WREYM+Pu5jxTInUsXhvXu6CMXj9MfXUW7D3sqHPiXC8WZPYwqxHUE9NzlNKFIX8+otpzt05ckfA+I5I33jI1ZVuUOy+Yk4h/JRph7GV0D3oUD/GR96PEytIDkU3vkEm5selstHajhYFYP9ejo4x/OFgZgkkVOpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664044; c=relaxed/simple;
	bh=OeT4SozvwC9H+Pl/vN4HGOPZ+Gi6VBCH8/9qZYrUqMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GbVoiK1rJv/jp8m5n99puJ9vARGiQ4SxzLOBqsG59YYj2ttnTmlBnspbjuZ7YU+GMtI0nGUEAiPcb463xqLzyZPhr3CPvj5UiApXFb+ed3ww0Jz0GGK+9oTrXXOOAmzl4DMg9+mjDU/xuyiFwQPvYY0cEV8AaatMYhknppL+osA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYqosbi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYqosbi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1A31F00A3D;
	Tue, 21 Jul 2026 20:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784664042;
	bh=VG0IL8GjDPlHVJnpfZ4jWA4sf/Wc+WvSkoEmxWye8P4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kYqosbi8DNd0Ru/gevaimx1tgBJAZbw8jIhcRLsKkHXBsUSdzhfUa7GeR7Fjbw4LU
	 nW4q+ovY8jxrLjIlN15gzsE3uED6E4xuLjPbsx1hV+xc/sLD9oTHoGTyvRdTKwIvmc
	 dvMietu7Sf1tDz3OT9KI/oQb+VbuHspJqnDY0XsmNNiggQ5UMB8y4DXy3orz4VvsLS
	 F5NFAveiO6T+MkV2rVkxHedcqznodLqk+8ZAxEo8lN+F5wPnKlN9/Cp2OZuRxgJKjY
	 5iwhlIb2SNcSZYScy8/UPaAV0kgkK1Qw02mFWSIbX1wuX3SOWYpGWMe8pEo+tXtJRw
	 KB5hbC1ggoxPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939603926242;
	Tue, 21 Jul 2026 20:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pds_core: check for workqueue allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466401213.1013514.282698608244093789.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 20:00:12 +0000
References: <20260714212713.1788438-1-nikhil.rao@amd.com>
In-Reply-To: <20260714212713.1788438-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jul 2026 21:27:13 +0000 you wrote:
> pdsc_init_pf() does not check whether create_singlethread_workqueue()
> succeeded.
> 
> Fail probe on failure. The workqueue is set up before the timer and
> mutexes, so its failure path must unwind only the earlier setup.
> 
> Fixes: c2dbb0904310 ("pds_core: health timer and workqueue")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260629200358.2626129-1-nikhil.rao%40amd.com?part=2
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> 
> [...]

Here is the summary with links:
  - [net] pds_core: check for workqueue allocation failure
    https://git.kernel.org/netdev/net/c/3a660ca49e2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


