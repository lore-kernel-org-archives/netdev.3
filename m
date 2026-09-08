Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2622253A1;
	Tue,  8 Sep 2026 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788825678; cv=none; b=m0IbxsYX8qtOvR9eoZrnNpcEFuXO3TpJGdZT+5EYY0pTvp9QtF5a5xW7cQ910Sge3AxTJcQ8a/OANLvD9VGSyHLpOro5mKewRbxKKVAPBErMhtP9BTMqMF8w0Svbu/1oU4iUMp0horY1cZ8Egt3EEGB5BKaPfetqsWdYSn/6STQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788825678; c=relaxed/simple;
	bh=Azm/rqdYsEZIuPBBARRxOLjjpuIV6TZQFxPQhLlZOWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vE/9rK8TLvqoEQBHn5xQr7VFgCAssgqkEP8BN1MQiwQN/WiCbqEYUQFhtCaJDRM32l03Ybr9JbkW84hqcU4EkxNbnLSazR3+AvLaktC6zqfi8r6jNvQd+JYnOgIk5V+qhIicAhbWWbr5I63kkVbXl+g+m5dzHc7ZFxE+7SlbhVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1sqoN8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1sqoN8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F64F1F00A3E;
	Tue,  8 Sep 2026 00:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788825676;
	bh=hDsy2ySWP2luWNV8iqsO2FRHRmm2/bUliYn/RAA6eWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B1sqoN8k2bVU5g1HlIIbwMFQI0mSl3Fps1L9sYWdjJdiGrYbIKjlaP5wKyrZsG5nC
	 afVW2FmJtWcHz8vH5iis5/DLmQbVIjAvmO054LrYf1RIHuRLmHaoZ1joo5d8TNFOE6
	 IKqVFQWjgVOqC1YLXWkWocRWd6o/YSo5bTvWIHziO050w+BtN0SKS+UnWJ6xq/yHGq
	 VoBsvpVRuKYF7j1aStWJFRoCEEaHzHnlTiY6dJNTrkTnW+JQ/lAO3zE2dpqQTDL2BK
	 FQ0rFXAqWkomrg5p0eMBgTGpAjaUOKnJJXUdO8XdrIY8A/7+rQRacQPKaU73wqAXbV
	 SmzBAgr361rKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB039E8A5A;
	Tue,  8 Sep 2026 00:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] psp: make tx key ops optional for drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882561539.3212362.10949911837502586488.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 00:00:15 +0000
References: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
In-Reply-To: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: kuba@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 03 Sep 2026 18:33:58 -0700 you wrote:
> This is the first of two series which together implement rekeying PSP
> protected tcp connections. Here are both series together on github:
> https://github.com/danieldzahka/linux/commits/psp-rekey-split/
> 
> This first series is mostly non-functional changes, except for the minor
> difference that netdevsim driver implements tx key ops. Its tx key ops
> were basically NOPs, and in the future PSP core can subsume the assoc
> counting that it was doing.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] psp: refactor psp_dev_tx_key_del()
    https://git.kernel.org/netdev/net-next/c/7b26ff200739
  - [net-next,2/4] psp: move code from psp_sock_assoc_set_tx() into helper functions
    https://git.kernel.org/netdev/net-next/c/4d3a7d1104eb
  - [net-next,3/4] psp: allow drivers to omit tx key add/del ops
    https://git.kernel.org/netdev/net-next/c/1e16b303109f
  - [net-next,4/4] netdevsim: psp: drop tx key ops
    https://git.kernel.org/netdev/net-next/c/da630d1da2b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


