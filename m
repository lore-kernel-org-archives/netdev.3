Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509415;
	b=0cXlCFxm13fNluTpPQvm+WjxxP2/I1uLjnZcJ/VPZhm05jNjVbJWVEOHXSV5YqPl4uIE
	 Dt+WchSq+FehHtYgD+ph9aHgDIPBCI37iaQX6t0a+Xf8PObYSiWsJCQMTvFq7iKpGxhfo
	 N6gUs18WqHlY6zQp9VIJBmb0SB1dxEQL8XtThZEvDrcAvshu9Nb+933Bd7akyRZJJac/s
	 tDKAucorFN4pBNmBfes6twUOmxBZAyiWYfVSBgOJ5T/a2/mtNWE+54bN67/BoHvvvWBwv
	 BAME0WqJZZFMo5fcE41smCDoS+VtdCt9CxaG7pSdP491QE306BYKU4Ze69NlaI75Lgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509415;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2TSuYt+9U84TuJXlSvGBhEdxmWJbqCs5zxZfM3yUjAs=;
	b=rg/ek/xn1fqvYZ6xq0QaXhkvUC/AmVZQhbsik2UtlS+XKKFtLKjsQiDk9Lrsox6ETrD4
	 AtoRoV8wVXGu0IJlsO8jyG9hXSRIOOJNQXMyuRGGtMVX10Xn4ofwR6lV63hZXW3pxvXSh
	 wkpRkhm03lGjlH2jlxJQEeqwQg95V2SiZVJ8V5PRLbdMzCiZrw64dSY5Lu+T2w4BODHux
	 2uq41K+5lw3T/4VaJ197UVnWPGEXDIiWoVygX0H6TXLE+/imQkQ56CZgBmjudY1ImFKVq
	 REU3lDRNkxa8i9eJl5z7VxjVIOzLiQXXghGO2Cp8BAM9Pa+c1kip4nUdJfgZuvXlOxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYeOzPHb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440860A2610;
	Thu, 12 Nov 2026 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYeOzPHb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DA01F000D2;
	Thu, 12 Nov 2026 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509414;
	bh=2TSuYt+9U84TuJXlSvGBhEdxmWJbqCs5zxZfM3yUjAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NYeOzPHbP7RyzzKXOATROZI8l9pQxRoAM3QTlm+ZWVXoCjF8cvl+2kG2ZJbea+9bk
	 L60Pc0lWu2RiBPDo35dEJRHYpAuHQlh69+zEBIdqIvzmMmmJmbwSCuTbFA0dsFSlcX
	 YeLW7ngvl2PDEAC12rznsNiOUIQA/BvHmtxFHwu9f7MoZwGT3hM4D2/sWhelbw+Hzj
	 krkgwtWjkEeG1lUTn/1uX1VGJ34VCoQ4Hc+SxRfSE+PbVjpAZSWDWvKU5H56vOOgNx
	 ScXPbTtfdvJboImhMUTFE29fl+g2K9lXbgjqt9sNBxW5j1UyPoCfP0LyOafK8dmVoE
	 GcgyGhaVJKiSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4385391AF9C;
	Thu, 12 Nov 2026 18:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mailmap: add entries for Hangbin Liu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450941327.590019.3553289092982582016.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:50:13 +0000
References: <20261111-mailmap-v1-1-8ab349555808@kylinos.cn>
In-Reply-To: <20261111-mailmap-v1-1-8ab349555808@kylinos.cn>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 09:24:38 +0800 you wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> Add the active email address for Hangbin Liu and map the old or rarely-used
> addresses to it. This prevents get_maintainer.pl from listing not actively
> used addresses as patch recipients.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net-next] mailmap: add entries for Hangbin Liu
    https://git.kernel.org/netdev/net/c/c6e0a84a6e6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


