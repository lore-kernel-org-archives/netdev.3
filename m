Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8C19067C;
	Fri, 29 May 2026 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017613; cv=none; b=C0eywEwxh2COn4iDvL7y7keRw7canqj0l+d6LZ6UOFATwLcxOHWJDX56xhQW9He1k0c1qKkqFqQwadtmwyaHf1wmIQoJFVFsqPah1x55mnlvAnlxoYhhlkUJO1/nM9uv2HCmyz+JPWQ2QWj6EYn7SDpC2gYExQS0ZzT85IuWPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017613; c=relaxed/simple;
	bh=eCxv2XQhftM5vTggu9Ps8S9rcCz2nhE3rv2tQ0QOZQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J+XYWuqSNJCoCNV710Y/+oUKJYToW6Kkg290X3rWj+Gu8sA1+YLn/SwXGuPSFUF4nilZjY1UTuT1iq0lWMXYp7iHt/PKK9Siq6GneHkbHQIrc4NTvEd0du35zUHx9K+XFfNOuWFGNCK3zBqdGFPBt60owfEqtCNz7I8KPZ8IDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwPvK2hZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwPvK2hZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495831F000E9;
	Fri, 29 May 2026 01:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780017612;
	bh=vp1sp7O+SkJWYMsiMbNLWUdk9CPc3FRDPwRpVN6tDsY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XwPvK2hZGllDTNRe92WD2Cgm1P8um5Jh98+G8gvsBVNNYNpcdo96VHE1HTTEEU7eH
	 GMXkLYsmEPLtM/YsEQpzPlQqw0rMmBWP+N0LyyYPbf5NKlELqdtvmT4r68W143CTZF
	 AEgX20XNfkLHn+OHt6D/Ju2v6u8BJ49a23Vr7euw5MrqCEbIcTBQcjW5FmKhAT3+rv
	 j0J+DEhmSWlDxdWV1O3ulmx0vP352iredBos+Yv07TUy09IiyZHdUsDU1/MTHDM/21
	 5XVQRKnjSQmF1GdxDmBs+y/WcJtXx2snfS0E5TxDt+B1PzTSStFOsqn0NKEdcfRy5D
	 wIkZfZglLsFPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A1E392FFFE;
	Fri, 29 May 2026 01:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] docs: page_pool: tweaks and updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178001761613.1584301.7882255916128039608.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 01:20:16 +0000
References: <20260526155722.2790742-1-kuba@kernel.org>
In-Reply-To: <20260526155722.2790742-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 tariqt@nvidia.com, dtatulea@nvidia.com, linux-doc@vger.kernel.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 08:57:18 -0700 you wrote:
> I'm hoping to start feeding our docs into the AI review tools, instead
> of maintaining a separate repo with review prompts. To experiment with
> that we have to refresh the docs a little bit.
> 
> This set exclusively focuses on the page pool API. First patch is
> a straightforward fix for information which is now out of date.
> Second one attempts to clarify the NAPI linking requirements.
> Third drops the dedicated section about the stats; the document
> is primarily developer-facing and the stats should require no
> development effort in most cases. Last but not least minor
> API cleanup.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] docs: net: page_pool: drop reference to removed PP_FLAG_PAGE_FRAG
    https://git.kernel.org/netdev/net-next/c/63c4530050d0
  - [net-next,2/4] docs: clarify page pool NAPI consumer requirement
    https://git.kernel.org/netdev/net-next/c/bbf2313cbeaf
  - [net-next,3/4] docs: page_pool: drop the mention of the legacy stats API
    https://git.kernel.org/netdev/net-next/c/ac0056e4f14b
  - [net-next,4/4] net: make page_pool_get_stats() void
    https://git.kernel.org/netdev/net-next/c/81a4d039537a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


