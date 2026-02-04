Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C343BB5A;
	Wed,  4 Feb 2026 03:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770175209; cv=none; b=eb3SUwAlQ56UnZa/vS+Vjbt5/kCS6D6ORHbcS2/s61dLXcVoFJECkNRtLlkTI2zYw+ihPJ/9Eqqq1z+1A4TYL7pEOMSs52hY3Helkix+loNVTJdzh9Ha5zkpZVZQ2C6dDFeB6KitxfpzZoWinf3gevKv8aFgpQe/12UuGqzA8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770175209; c=relaxed/simple;
	bh=Wi11qSXLkjp1rMgO4esIkVs4uZpWAHv8qcssbxXX480=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FLTFZlJsdxoxhi6vzu+A7J66B5EuvEwRKSTmj+FAzmdUAZc4WGrQrHuJIQ7N+5eAIv9fwj8H7R/DxoAOgweXDeMXMXrfX1JbKBSTTfSZXB57b/Suhr7bFnTzZKZLWeUknqLCgFp96l7uxKoKLXsyh0zVN+Bk7Mou9NjsDkLGraE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY2TEKYO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY2TEKYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B25C116D0;
	Wed,  4 Feb 2026 03:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770175209;
	bh=Wi11qSXLkjp1rMgO4esIkVs4uZpWAHv8qcssbxXX480=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UY2TEKYOgJTVj/V2jhWLqr8HnRK3iB1MKu0xDRLWBMQJAx60QH9/8NVSBNbMYC3Ah
	 Wc8Be+cTHAQ2bl4rq1QW2DUcuj+6uonCIw9VCPeufvlI+LE47C7d1Tan/s9AbQyZn0
	 HgsyVYHyPAn6z0CnYujA8suLlhgOj9xxeh2z4jac+c87iik+41gjvn+CUsoR35TXFX
	 T+zqdw7EHHz1Z89WwSzeFZUJo8+Ad/Yo8WKq4HhSs8ByyheMXeS7A7BHcnJQJ/s+PG
	 5wyT3E8DASLi4yfJFpEs7AGXwxJfbKZuakLgwtCb+wL4xeNVs3D7aNtTbQnXMhzdPm
	 GxcQq6AEwVGRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CE0223808200;
	Wed,  4 Feb 2026 03:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: adi: adin1110: Check return value
 of
 devm_gpiod_get_optional() in adin1110_check_spi()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177017520563.2163463.7076254684537955937.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 03:20:05 +0000
References: <20260202040228.4129097-1-nichen@iscas.ac.cn>
In-Reply-To: <20260202040228.4129097-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 nicolas.dichtel@6wind.com, alexandru.tachici@analog.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Feb 2026 12:02:28 +0800 you wrote:
> The devm_gpiod_get_optional() function may return an ERR_PTR in case of
> genuine GPIO acquisition errors, not just NULL which indicates the
> legitimate absence of an optional GPIO.
> 
> Add an IS_ERR() check after the call in adin1110_check_spi(). On error,
> return the error code to ensure proper failure handling rather than
> proceeding with invalid pointers.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: adi: adin1110: Check return value of devm_gpiod_get_optional() in adin1110_check_spi()
    https://git.kernel.org/netdev/net/c/78211543d2e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


