Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5A2765ED
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527835; cv=none; b=ZEIbn617au4bukQiZb6kbEbhSe+AB228HbW07wiPlrfshb7WHQIYLDChovlUkdbA5Rssxr/IbBqbSaZ7boYtEhIYskw8tC5NQnSEjthxIScqzpzzUOn/7H/dSHqYWxayzvg7SpxCOQNtThJ54bRN3FKk3L2wFPymSQBUbbgz+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527835; c=relaxed/simple;
	bh=cZvbFYNNTdoL1nPpqXp/4nddnsJwM+78pVmG/00ZNrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NA2Jmfs6WdRrfZrGeX4v4hapgOKaNoPJs8Qv8UmEKfth3r/HjIVtm1frbESzPsEe1T5nKrF5aETH9b50lm6OIeGd3mfrWE26s8FmhC5KZUUyyaD8g/TxL9ng5QygsfrsmTIG+6azj5P3zQAMAeCZ7p3z15yCeCcOOZunQfUeWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWLMOdFF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWLMOdFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D18C2BC9E;
	Tue,  7 Apr 2026 02:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775527834;
	bh=cZvbFYNNTdoL1nPpqXp/4nddnsJwM+78pVmG/00ZNrw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dWLMOdFFOWG3SmEfLMHJUSxejizcQzs/kng41Y2Dy2hHtJQa1BDPN1yAKr4Ce+MKf
	 TUX48YssgxwPATPcbx5wTL2l9EIUg2bkgAAsaBYTEl2kVYcRzLMey9ebRi+GmZEbTa
	 gdlzqDUepfkR0CKoVDCufZ+Es5BtQh5GgLocJ32whqHYkfX4b4GonZkY9c87XEymW7
	 PAynw2VoW6197nHdiOrLhUIvmrYwP8Wrh2sRYrrXorK1L6jydflajLGz5vVWI9m0QI
	 q9TjaK5BRgEJgCk0zHtIVznoyD3iQbxIqTUaB0jf/Wg74yZSakmwmcpnVhfyfu2KFX
	 A6bqgXBOsFjhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FED83809A28;
	Tue,  7 Apr 2026 02:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: macb: Use netif_napi_add_tx() instead of
 netif_napi_add() for TX NAPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552781304.3342975.1284218351726081413.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 02:10:13 +0000
References: <20260403-macb-napi-tx-v1-1-08126a60c65e@gmail.com>
In-Reply-To: <20260403-macb-napi-tx-v1-1-08126a60c65e@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 03 Apr 2026 22:23:39 +0800 you wrote:
> The TX NAPI should be registered via netif_napi_add_tx() to avoid
> unnecessarily polluting the napi_hash table.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: macb: Use netif_napi_add_tx() instead of netif_napi_add() for TX NAPI
    https://git.kernel.org/netdev/net-next/c/c321b5676d0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


