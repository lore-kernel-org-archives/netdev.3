Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9539FCC6;
	Thu,  5 Mar 2026 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715006; cv=none; b=YAZKHrrSN/pxIfFoDeSeKjzpFGhoQZ39aWSAnwUGGk+R2EhungCu7hDweWGzTtGHq/8ndhWMjTHm6oJAOIxUzZnSxCDBBOA8dIU8buxl1k7yUyHMK0Qik15EsEOlCBKh4KRqgyrXHfVW/4ojk2D/AbEhhZ3ylf8RMI22ia6861c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715006; c=relaxed/simple;
	bh=YzH6U8Jocq6Dw70JzuSux1lxwebehTtYneLmK8LfMFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NgueTyipWC6xYBm81HU2lM84jLoq7EQbH59F/ztlXn/T9TfT0XpQdgQSCxG80PaZgQzRUYDot9kVLBW9ENBb508pbCw0Mg1BwmUCtDYYITW+LI/Ow6rXq9qqajyNGWeV+LFVERcYPkJLOAGOw2DtMxeKUADMdzZY77MEGukkIZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHaYJvm0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHaYJvm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207CDC4AF0D;
	Thu,  5 Mar 2026 12:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715006;
	bh=YzH6U8Jocq6Dw70JzuSux1lxwebehTtYneLmK8LfMFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DHaYJvm0v2g1SqgoLKjMnQDg+J3nWd/fv0UppHojXNlhUISwkEJqB6xQRhjudyOd8
	 e24uKTPxnC/DDKXkbvVOo9aBWWosyWeDBZFGSbIYIS8emOzMTS6NTarHoQlPD0OwCS
	 G6W4co/7vgjjc9ss+7aOxzTvbHJw6Qtwu6aY0XsVrrFhnMgVDaLoGf70XcIUFgxw5q
	 55pQWphgys/7fyVKk5wDMWnSS8nfhQACs0Wp6AFKt1MIQo35rPbopehrwyWmMe82Z3
	 orU67EWBhgINjJrbZD17YGgvpxRGtvqLigFpVc8dsw0VAUSFaOJ7F5b86tUUZA9S5e
	 B4BP0SobeRTBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401793808200;
	Thu,  5 Mar 2026 12:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] r8169: add support for RTL8125cp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177271500580.2696007.10532998813994915924.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 12:50:05 +0000
References: <20260303094611.450-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260303094611.450-1-javen_xu@realsil.com.cn>
To: Javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 3 Mar 2026 17:46:11 +0800 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply
> different and firmware for RTL8125cp.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
> [...]

Here is the summary with links:
  - [net-next,v6] r8169: add support for RTL8125cp
    https://git.kernel.org/netdev/net-next/c/a90e3029f20d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


