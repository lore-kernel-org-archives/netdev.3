Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CC34C989;
	Fri, 13 Mar 2026 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370228; cv=none; b=rb4ban1I4uMWHS09SMNLK74xvU+6IocDHk2hna6kc4CPztc7kjOFj2rI21wKwQm2WrW+Ru5mOY3o96bABXH0KxQS34HOpVTyNiQEWMxZWO3sHGxvztZosEeamcBD9sRuh9zytZiFzFVmlP5OT0pLMP9b/TXShp1+LwlXyPpipuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370228; c=relaxed/simple;
	bh=3etnwP+P9OA+vYCo+MXEVJWERSIkqq39Vhbz8gzvifI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q+DTQPhufTeiogv4svU6YgTU9srgLR26Vkjooi/7ovUxdnX3krkeg8IjRFi9dMs9HxMA6xF0jB0AQLQck0ALUnS+8HryafMUgac1cWRR7XXT76WmezZg9CqPxFe0ezjgppRSYy+W4gN0whHYi6mODnrpILmPFW7at38Q0cJqi6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNYJwT7Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNYJwT7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D387AC4CEF7;
	Fri, 13 Mar 2026 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773370227;
	bh=3etnwP+P9OA+vYCo+MXEVJWERSIkqq39Vhbz8gzvifI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SNYJwT7YabrwmLI4Q+PQtxLb852l2fx0u8WXKUjucZlAA9a67oI2GSQp+hPiJifaG
	 Gdxtc+o/v0vnKSZ/KMdbVPRO64qDbiksutMXVa9bCNttCPDhUtlZFysWNBnuKJaCY1
	 fY/R3caGhyw7LayYn1VjXy2Nq7CwqYajIa2IRNTxzUN3Is449zvmjzbF+dJqu01brI
	 qMwA2WgmgN8jxH/Ud/P9dFALyqnjyzH5uDaB/u/J5yvb+4dIH+XKbNb//yqRkF8iPT
	 mCY0E48WnkujtQT+T1h47fqNUqOHUXXuaUsr1a1Gd57BHjTKVWlVMOFbZYGIZLKXQD
	 qzd9QST7+LTHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD0A3808200;
	Fri, 13 Mar 2026 02:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: page_pool: scale alloc cache with PAGE_SIZE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177337022304.648356.2556762129398077891.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 02:50:23 +0000
References: <20260309081301.103152-1-noren@nvidia.com>
In-Reply-To: <20260309081301.103152-1-noren@nvidia.com>
To: Nimrod Oren <noren@nvidia.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com, tariqt@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Mar 2026 10:13:01 +0200 you wrote:
> The current page_pool alloc-cache size and refill values were chosen to
> match the NAPI budget and to leave headroom for XDP_DROP recycling.
> These fixed values do not scale well with large pages,
> as they significantly increase a given page_pool's memory footprint.
> 
> Scale these values to better balance memory footprint across page sizes,
> while keeping behavior on 4KB-page systems unchanged.
> 
> [...]

Here is the summary with links:
  - [net-next] net: page_pool: scale alloc cache with PAGE_SIZE
    https://git.kernel.org/netdev/net-next/c/15abbe7c8266

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


