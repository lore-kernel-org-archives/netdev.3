Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80633C52E;
	Sat, 14 Mar 2026 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504016; cv=none; b=KcqfKQk7xEAGdB7A6tMlVM39d6jLEpY9GgfJatEKndJjZZUvD9Wk5TIdJBVLFXT9KSUcVrdkh7awdCmxLTVhq30rQLUlea7YiktrELM13G11yF8tW4J6TN0NYTr8QutKeavASRAAJbdRHhTTnm94YtT0dOa3XFxyYrZtTegK5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504016; c=relaxed/simple;
	bh=79ROF36rOV1CZyMJQR5MzPp3tEUlUk7KPpSBAdGyHNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IIzFz4KW8W+WP0s2xZamwCKI+Os4/ZW9BuVPfjB7THIEElkoHAFQWp2Tc44P75kJ0C1HgKs3C91L/KTq4T952mmBzF7QLUeS0GKldD8hXUUm5F7qhcOq7/9seQmm4prDHLQDW40vZN23dDfvuLnwlYC5Kr/7B+W6DC7HR3nHm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UldUwR9p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UldUwR9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E754C116C6;
	Sat, 14 Mar 2026 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773504016;
	bh=79ROF36rOV1CZyMJQR5MzPp3tEUlUk7KPpSBAdGyHNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UldUwR9pLbHKEew34iu6x6claOWLSCO4MF8lmWFj5iLAn/a+VMedy1juUaBvGpPxo
	 ArvVweX1scI8369X7JZBQFAKnEej+AN4v84vHBl2/ft+58O7CswhSAHSE4ExgRt0Fc
	 VU8C7q7BWFCdvJtg1PP5TbKeY3Yh6+JXStZ61+zl38j7Tm58fsqdDO/YM6IIaYC8Nc
	 RX+5IWYhm9dmeFPOqRSMMacZgxQYHTS2BjmzxCUIYrBqsluMqledEhQ4faOL7MPriw
	 ARF70ZGEfZ4eUNpsrjVPacq4mgwsJsTgSHJ5Lw5MrfGZRjBkU4bn6LkQD4SGd1KNjf
	 b05abxeAlH9kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0713808200;
	Sat, 14 Mar 2026 16:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] hinic3: Fix spelling mistake "capbility" ->
 "capability"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177350401003.1721007.15753016257716203167.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 16:00:10 +0000
References: <20260312235922.3442120-1-colin.i.king@gmail.com>
In-Reply-To: <20260312235922.3442120-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: gongfan1@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 23:59:22 +0000 you wrote:
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] hinic3: Fix spelling mistake "capbility" -> "capability"
    https://git.kernel.org/netdev/net-next/c/425abcea830c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


