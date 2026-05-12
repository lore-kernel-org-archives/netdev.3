Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87107246783;
	Tue, 12 May 2026 01:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550576; cv=none; b=GGWTXxrmru0His4lnK00OAaRkl52UNhTAPuuI5ts+HR31GsQoYfX12EttRGPkFK5YZndSejDRD94f3hYN14TORCPScdFe1NGcs6FRaVNLQ1vycPTAmU4+3jMhnVRF4v7yfQztbscJMnqpmiyXgBseBL4J+r9P+txCjQURbJt2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550576; c=relaxed/simple;
	bh=N+mG9VFd1nAHybK56YS0zxGfciWo+eOuQjecD+z9q8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=np2K02y6+DTFJRdVkVymIA4Lc3pXtX4nIUZJe7i+mWSK9bX5EKtRXxkIadHxwtuHdTmHBRZ0fRwWW++YglLIQg+R6K/SmcxAan5V58jdCeeIQEC1Cmn5IQRs4oPPuVnIaaIHFwqifKv0kC/v8qHOCLnzPuka2c9q9BG5azU8Otc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpXwvmom; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpXwvmom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2583CC2BCB0;
	Tue, 12 May 2026 01:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778550576;
	bh=N+mG9VFd1nAHybK56YS0zxGfciWo+eOuQjecD+z9q8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WpXwvmomJWm7adLexcQZz3ZRztF4TgcZ9JYvsuICIiPewbrCPLeD2JUwtPWtNCva9
	 mQ4jqE1qJJ9Rz2O7zCjxG3XHVa5/8Q47N001z3egzZ/TF5c6uJDUzs0tVpFazvNibR
	 Xa9+6dt/oK4sUanmp1LOYTwZz/sAQfRfbMZj4m8EFBSDO9VEtkThp3m/ZYCXbDmne6
	 KIpg/Yt76guGhufOVxfyF/at61/c+0U8wj9ZlkwLAAB6vR5O6O0LSEPpji+khwx2h6
	 jAxPE1kxmlM+1K+FHQYca3eZTUgQGSdRJ020K/aJgwpg6bOw7XQVdoyT++zWfmQ7EK
	 KzIANtciJxZKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FB139308E9;
	Tue, 12 May 2026 01:48:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] qed: fix division by zero in qed_init_wfq_param
 when
 all vports are configured
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177855052229.2567715.13167262625389092988.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 01:48:42 +0000
References: <20260507145520.23106-1-evg28bur@yandex.ru>
In-Reply-To: <20260507145520.23106-1-evg28bur@yandex.ru>
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, horms@kernel.org, bhelgaas@google.com, darinzon@amazon.com,
 Yuval.Mintz@qlogic.com, manish.chopra@qlogic.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 17:55:17 +0300 you wrote:
> In qed_init_wfq_param(), variable non_requested_count can become zero
> when the number of vports with the configured flag set (including the
> current vport being configured) equals total num_vports. This happens
> when configuring the last unconfigured vport or when re-configuring
> an already configured vport.
> 
> The function then calculates left_rate_per_vp = total_left_rate /
> non_requested_count, which causes division by zero.
> 
> [...]

Here is the summary with links:
  - [net,v2] qed: fix division by zero in qed_init_wfq_param when all vports are configured
    https://git.kernel.org/netdev/net/c/be48e5fe51a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


