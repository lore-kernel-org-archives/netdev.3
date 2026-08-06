Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970033806DA;
	Thu,  6 Aug 2026 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976869; cv=none; b=JAvQ1JF8NllqPGukRJYIz9AYjfb7i1QXDviJ9ZaCkp71GDYishVOA/qOjisHQAru5Qr8yEgUf06nBS3CYl080w184GkePbJETjuZhUD01zQEE4ubjaH7SUG6of/2uB7UYscOQ9aQPFvLKb5sgeJRdYm9jfy6EF/tkJ2mIgdBcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976869; c=relaxed/simple;
	bh=ydqezuBU5cqR/fbjsDsPjTECnTmw/3tLR7DC/Aiqe3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r+Wl2pzeESYlz/SHBmioJDQWLXaDNxZfuTjdGuLVzWlUuD6Cso8OoQT/sfenbfWfA8+rAE0uk4fcG4UzwRFPzDHT9laAOygEU14l9XcnbUdPb7EaG/eMrLN8Cvt5cHWrLXcZXvVmsvVp6ZemCwpX5vuKV1+UMVszFim4JW1Awrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imFAe9zs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imFAe9zs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3461F000E9;
	Thu,  6 Aug 2026 00:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785976868;
	bh=m0n2WxittutUIJ5uYuf1GdMg0RhzWKSugocopXEi7lc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=imFAe9zsfat6NdGwfu6nx2bxdmsYpXvbvSdAwXpebrJS4I8Z0kh7JuPlWkE0eqN7O
	 ozm/KoO7rJWO6tOGdpTZDaVW/E3ljxnucEmUMiGtIUjIkF5bcd+uWzSnzJ9K+0gBOz
	 jrl25odQE2tLJJb1xrUf3JJzKpXEj5vOZTopwAn5Hch2aflgnd+ZZIAPRjt+4qVvQ5
	 Zc/SJGwjbqZfv8xucwlLcPOdhcz2jYNj9LH4+v6V4DfyWXbnbp2OOQHHeifMi28R3G
	 qhpybsCa8TnEC8Mu37Q/+hsOVm6nh/UIJSC1B6IchuzCt8zpIh5AHKIPnsCPbReskV
	 uZRmzKTYBi/6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F0392FFD8;
	Thu,  6 Aug 2026 00:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netlink: drop unneeded semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597682763.580024.14160560649641149691.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 00:40:27 +0000
References: <20260801191002.1383835-10-Julia.Lawall@inria.fr>
In-Reply-To: <20260801191002.1383835-10-Julia.Lawall@inria.fr>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: davem@davemloft.net, kernel-janitors@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Aug 2026 21:09:56 +0200 you wrote:
> When a function-like macro expands to an expression, that expression
> doesn't need a semicolon after it.  All uses have been verified to
> have their own semicolons.
> 
> This was found using the following Coccinelle semantic patch:
> 
> @r@
> identifier i : script:ocaml() { String.lowercase_ascii i = i };
> expression e;
> @@
> 
> [...]

Here is the summary with links:
  - netlink: drop unneeded semicolon
    https://git.kernel.org/netdev/net-next/c/ced18ba79509

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


