Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707209;
	b=RPDeH74Zer/DgZEc+WdquEVowA5aqKUX1M2SR5qhzh3Tnx9sDafuo8ZAJmcr2Zzoy2Ba
	 8xVHC8anieDVHwB0yyCUqWOZBFEawQo8rwbEgbkJRD66zZpz9U/darngIW/+aqRQwd+4Y
	 /68DL3i/Onvg3UGiDOzuDckVVCQ6q9DV3ktJ7XiKO/YWGMOP+YvNqCBN5v4cZx0cAZNrH
	 yKLxwTIzHwAaTkN2rcektUWlzAixqaXalQ7ctkuL1H+Pwx9eiw4wi+m9zFjQEpbE4IKGr
	 S8XBY8iKD+y9bhsM0w27IHjSN+egm5eejzqKgWUoTCON1Qs98l0N375nFQk4ip+LE3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=jV8h0NXn/SxKcAuurxKRg3/+b9VBEbkYMCmTc8z0Vo8=;
	b=IUqLq9TnMtZCmkvBoxrc6KfJJFkzBjYNUnT4zKk3veBEdQAe8optE529qbsU0fNRNFU9
	 QXyVxHtrC38m1fJEx0c9zYdwN8mAHZacVD4wjmIdtyVvSAFJl2Wp1hvDgDZfwfkKLGrHv
	 tLb6+54h39/VBm1RQBDe5aBPNTRYwuWGRMSP8vQyonllU4xE4fdflVeN3X6Z38Y4HF9hY
	 Su1GrSb0g76nG4RfYW3uzmLmGg6eDn5f7rCYCM4yiOFD45IDDTJTVL5f8/sTzdQFDGIOC
	 IMxvM0n8+mBFugWP1Ouyw1uVXZcMoD+aGn31wdXXM3cina7aUUf6TUSpEsp3R0zXcuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVg02yYI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A71606A32C;
	Tue,  3 Nov 2026 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVg02yYI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB27E1F00A02;
	Tue,  3 Nov 2026 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793707208;
	bh=jV8h0NXn/SxKcAuurxKRg3/+b9VBEbkYMCmTc8z0Vo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WVg02yYIgO33RkXCix96WKTfnUqe2hzyK/33E97NQmAMiZjDed9wF4QEezhJBoJt5
	 eBwpEk6ePqcGElHO1XCuMC93rEet8MwZutoWpSHz5XCyoGIfR5o33bSO4mQvrf5yw7
	 keNyz3//ngI65L2OATcSHDaP3cQxnOfPR8y3QDWq08JsbmXYYhIXfrmDfwqb320cCu
	 IqiuEOYIQuD7gxb1Laqmfn3S91sN6CO4su5i2W6T8XhBhm92nszSeC5ulkf5mjj/FH
	 ED38NNAFoKpJTYKYeUkXrmGzousv0MFUZWbZ+Ekh8bGd8G29YO9ctaWWTRtvYG3KOl
	 XiIZANAGgehdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6B2A3805CDD;
	Tue,  3 Nov 2026 12:00:08 +0000 (UTC)
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
Subject: Re: [PATCH net] docs: netdev: try to force agents to disclose info
 for
 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179370720733.1083709.17569222025256007017.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 12:00:07 +0000
References: <20261029153459.2257998-1-kuba@kernel.org>
In-Reply-To: <20261029153459.2257998-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 08:34:58 -0700 you wrote:
> "LLM-driven-developers" are not including the info about discovery
> method we want to see in commit messages. Try to add more forceful
> language to make agents ask for it. claude and codex seem to load
> maintainer-netdev.rst already.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] docs: netdev: try to force agents to disclose info for fixes
    https://git.kernel.org/netdev/net/c/f56daaadfeca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


