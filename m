Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060410;
	b=hjkvru9WI0IRClZN5tco+2pq9Yco815z4KFoURrpXESLAIjfm8qiSfKVlI5dPmuN3ZQR
	 +EVMNv1emcKrbwlm0Zx1dJdkpoS3AeOf++VQdh/SBhmihhWGsxd37MtkbT+SIY+zBMKei
	 rlGVLM2gvUjVmOnqVu35209vuAoghRMfdkl4jlxU2X6nLo3/1YvG0yQ32XuDdYfVxHUvU
	 yMKZ7vRyFOJCOEABBEydhlq/ZUnxuEB4JgfjVVM40V0xh8SZXLNxLstiEEJYEr1zRpH/S
	 crOI6jA4gRviCn3fWhPyx0YtDKs3WP5+MHPPVIGXsZNABBReHKzND44gEHrd+ZEuAFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=z5yMdEX85VOBZEN2Z6tgJfp6LGnMgULilyZVIwVl1ps=;
	b=bDRWfAzaY/NIUmNS11zwobZ29aJKYA6ffLxlKz5TZOu90QmCghMWlhypMj5fKGXA8B6m
	 XnGQdl//RsxEyI4OEC2CxIaFdrrhn17+CPiPXpkhz6i+iSHYHmzRcoyzA2UMM8pgiqwUd
	 fXr51d4SmGytbLHs5ysSuL9YC/c57vVTZ+rHmPWwuPkNaOOI9vUirUnjPQOvejzTphnkE
	 EH1P5FM4q5LlzBHbuoCAbPIcYfEZYyNwr0nGyerNJ1raGZS3xKNWb0Qp6HKOerQhgl7bn
	 P7suUUWZ4yuwi6yDTZLAGFSARB21FZXZ2RkGrWFEgkSKvH+yqqGEwszOB4USEPI1Yxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gI6aX7NU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC02606A31A;
	Tue, 27 Oct 2026 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gI6aX7NU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE821F01825;
	Tue, 27 Oct 2026 00:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060409;
	bh=z5yMdEX85VOBZEN2Z6tgJfp6LGnMgULilyZVIwVl1ps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gI6aX7NUaZHB+nstPtBlGxdyGST/Fue/U8Mp6RO4Dd1fMA2gSMqtvqOrvdM5TJXbE
	 G88WdQF3e0CXUbC7GHJ94AzQ8BFhKHamUM3zUPR0ZRNW8dDhbtHKrkeWRKfnQI48C4
	 pOjI2x4rJEnhuDO3P/eHqE8FqXPnddTjnkQPq+GUnz4CL4PEzDkDSzl67n+Mqw5mHt
	 o3uu96vYRqT1UXgqzQ0EEIs99zV8twbhWnpxlK08JPniMCvgiv0UBMXRuA/m8AsU5d
	 fVGop3ehJcpvz9naVKMhedmNvomEjuJO3yPqnKmFrJ/7MlRC+7ZhotU70hL1y8TH2R
	 KeAsp9U9N6ylA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815023AA80F1;
	Tue, 27 Oct 2026 00:20:09 +0000 (UTC)
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
Subject: Re: [PATCH v1] net: atlantic: Unregister before clearing RXNFC rules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179306040832.3479540.17384661649261436191.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 00:20:08 +0000
References: <20261020022630.515209-1-18983559317@163.com>
In-Reply-To: <20261020022630.515209-1-18983559317@163.com>
To: Binbin Deng <18983559317@163.com>
Cc: sukhdeeps@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 10:26:30 +0800 you wrote:
> aq_pci_remove() clears the driver's RXNFC rule list before unregistering
> the netdevice.  Until unregister_netdev() returns, ethtool operations can
> still call aq_get_rxnfc_rule(), aq_get_rxnfc_all_rules(),
> aq_add_rxnfc_rule(), or aq_del_rxnfc_rule().  Those paths traverse the
> same unlocked hlist that aq_clear_rxnfc_all_rules() is mutating and
> freeing.
> 
> [...]

Here is the summary with links:
  - [v1] net: atlantic: Unregister before clearing RXNFC rules
    https://git.kernel.org/netdev/net/c/13b364c765e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


