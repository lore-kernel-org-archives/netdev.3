Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503010;
	b=0kPIIrOG1Dkxc8cNvMgiGhpl4rgAXC16LcCa3Io3tlVbH6E12TN5xXahtlIlsf76S0OY
	 06ZtYUzB7I2qmiDeDvtNuKY3k1CF/g9WA2iQUOPo3cac2Dtb09TPKthdwp0VztadPn4vA
	 Bew3nQoTkiSVlOsuGpILKOLjLr/hB/z9+PL7EVe6o70yUm3NAWnUejmjsbfr6Fy5eeiwJ
	 r9MrnQ6F+NwbkEreu1bsZKyzy7g2sYR0yOsSbiTbI0MTgDnDETlt8YBmF1i2UTw031Wo9
	 A8mU+x8mEwiyjvAkvB00fHeTE+kaYjNnkrTrO7TApU5q6NABwVbR6JWDylgvY+qOKUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=L/oZ7txTnYWwg3FxFULepEhkYerIOO62/m6J9az2ziA=;
	b=A4Rvrj1iGrC6VDQw/OHETZDgdFhFnrRnv2j534yHBtTAwJuk7fZ5lFx8KOuvyfiXq+/i
	 BtHLQJGxeuMKIgwXJKZox8CUdKKiTde7C9kR2nes0yzIhNpKeY7HPa5S/bznKSQ9Oh7Mj
	 hh2alrlGtU2eHBrBxFSVl6vIxZBPukLbSS491eEyJrblpcABKWvU+BYqc5eI852Sq++G8
	 X2UkHtcvSRrGCkKDwKNnmP/YNQuGTZrQeeqZ+d5X1dE1dQWqUBQxqCz6efiUd2AZStd3E
	 2iekaK/UGbVrRd7Hz0Q7/AkWkmW1acux/bSZm6UTCJB3dT6/m08stuEyzFDUbAnQ1Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljOAtU9r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371CD606A331;
	Tue, 20 Oct 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljOAtU9r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3381F000C4;
	Tue, 20 Oct 2026 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503009;
	bh=L/oZ7txTnYWwg3FxFULepEhkYerIOO62/m6J9az2ziA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ljOAtU9rWM6VpNuQT6PGWza3eN7hd/w3eQ5qyRVPUtwmvGje2nwdNfDJ1M+5LjDMj
	 lShvIhTAudKJJDbKWdXmyTL1jn7RPcWrpJH+s9F5TRCHkIxZs4c0IN5AJZo+veE5RQ
	 g6QWJ68s2gJehmIXFC+oOrwChL6T0kdDnLRoZbev+pGU17XHJ+RiJArXDiJTXHdUaD
	 pG7hR+sqCdro6bpA1NLceM+4hxVIeRLscaAK4XP0N3s1yUQ8fsST02m3k0UzJl4l5I
	 lbjERlZuUcnPavnEcR7hWI28+63Z8BjiJQmW5DVPVpMuW7PLbaaIK1kUBIFmNeyj+a
	 bgtigax6YVwcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B444F3808209;
	Tue, 20 Oct 2026 13:30:09 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] rtnetlink: comment the RCU waits in
 unregister
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179250300827.3738467.10049279348392520462.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 13:30:08 +0000
References: <20261015081723.404990-1-parri.andrea@gmail.com>
In-Reply-To: <20261015081723.404990-1-parri.andrea@gmail.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 15 Oct 2026 10:17:16 +0200 you wrote:
> rtnl_unregister_all() and rtnl_af_unregister() wait for RCU readers
> before tearing down what those readers use, but do not say which
> readers they are waiting for.
> 
> A missing wait is then easy to overlook: rtnl_link_unregister() lacked
> its synchronize_rcu() until commit 3b70edea393d ("rtnetlink: wait for
> RCU readers in rtnl_link_unregister()"). Add a comment to both waits,
> naming the readers each one waits for.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] rtnetlink: comment the RCU waits in unregister paths
    https://git.kernel.org/netdev/net-next/c/ec636599b10a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


