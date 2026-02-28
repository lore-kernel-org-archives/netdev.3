Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FCD20297C;
	Sat, 28 Feb 2026 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772248804; cv=none; b=rtfa7DaHgBifo0KHPo4pEloTgVg6PbWqRZ2qLI3K3mFz7lg8s5UCN42zceJ8tKXBAikVUzFXEC0R24stPvgQjNL0niZEyqb0vR9qC7uaToYhMh2FGWnR9d4GXABcm39MtwR77AR8kwvrfZWS9db5w54qAKjeq3uKGJSUKaEEe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772248804; c=relaxed/simple;
	bh=hM/rTiB9XyNbiwGTXzGVSnGV4+V4bj0hrZLzPWvUGqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i5JXjKc/wUp0rcNkFFw3okT0kC+0ut5kAoHXP+o867vBfnR4ablHk4CAyEOEm/+a3w4D8AlvPt42YXviDe7waESR0AmTXEJMhJg3naEJeIjmJPFop/kWwjahRcGBkWpmKSt0INVDDG46I/dOJk2018z/cfdZxurMwuf2XZGozGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf3zRnDb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf3zRnDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF63EC116D0;
	Sat, 28 Feb 2026 03:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772248803;
	bh=hM/rTiB9XyNbiwGTXzGVSnGV4+V4bj0hrZLzPWvUGqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nf3zRnDbBolMTEglg9umA11guQP4Zca1xxvVOJo6xZkFF/tpZBorvplSThXFK6inO
	 w+a4rG/kNKXgT2gg5BT/AD/tYHnkkpNHKw9959VmohnQkrplDjWio9F8K5S97fXTtS
	 eTEMjfts6LYSdVgH0WVUKMUgyXmpW8sK4G6F6lafwcbmXODGljqlJeW8CUF8g9eqi+
	 CXC7ld2qo0tKXvNa8/F70Oeu9kwpaiDKGyAqCgXhw7zWKfLm1M9/8Dp6dDQ+savqNY
	 x78YUkoaP9KImmHXpAFwbRoRQOrNKMguKRQWC/tEIZLm7GZPc4LFzEkERuGohuzXco
	 IKRYnAkJ69owQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEEA39EF96C;
	Sat, 28 Feb 2026 03:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/sched: Only allow act_ct to bind to
 clsact/ingress qdiscs and shared blocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224880716.2851960.3791246704632910583.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 03:20:07 +0000
References: <20260225134349.1287037-1-victor@mojatatu.com>
In-Reply-To: <20260225134349.1287037-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 taoliu828@163.com, netdev@vger.kernel.org, pctammela@mojatatu.com,
 km.kim1503@gmail.com, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 10:43:48 -0300 you wrote:
> As Paolo said earlier [1]:
> 
> "Since the blamed commit below, classify can return TC_ACT_CONSUMED while
> the current skb being held by the defragmentation engine. As reported by
> GangMin Kim, if such packet is that may cause a UaF when the defrag engine
> later on tries to tuch again such packet."
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks
    https://git.kernel.org/netdev/net/c/11cb63b0d1a0
  - [net,2/2] selftests/tc-testing: Create tests to exercise act_ct binding restrictions
    https://git.kernel.org/netdev/net/c/b14e82abf78a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


