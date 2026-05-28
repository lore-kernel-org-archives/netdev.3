Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073811F5858;
	Thu, 28 May 2026 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934802; cv=none; b=Qd83RXVQBo044MwLkX+9ckfBdI3OwzXhQqU1XKI7mo13ykqvH/SfJinC6c5inr8nju0jD/OlwxCRtyS6NLkREfoLh9ymwUt6gB6bVtJJ7pW1cZZcVvg74eVKzhTLrSoR5ePoC43+OONskOhtBNTFqR5mMTBGEHnXYUd8r8FOgvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934802; c=relaxed/simple;
	bh=HOzg/dvIeG9Ja/PqBbxkp2vf7WFYqBZXngUSeC85kbg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gzMEQtiOSu7N7/gPDPtFG2zl3xqJ0Lk/BSyueiRYvd59NCHppgxKfK1AImvK6UpVIU6ylk3csvsWoC64kTSDWm7Y278CXGwj84xX+uUaqqWBhSBfI5VOf7ZwhYNQnXM/FSpQ/gUkYrSsTUQcgLtUczDWyRcYjOAkhpv5DF0NnlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7QNWo83; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7QNWo83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36641F000E9;
	Thu, 28 May 2026 02:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779934800;
	bh=yvDJtRypZBbxQi7iTRMpFHJ0Xf2K73yxjqlzagEc4gY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j7QNWo83+F3a/ytTipCx7AhNtYhgN25axFQH8Kb5PGnLTWbyvXmQOjhqrSLpWB8sS
	 LhdVvj1M9vT6kouEktnTnBNeq3gUNKHGvFLpddKv34K6Lv1LbrGU9AZF30a3LqGX+8
	 91g7DlB6C92ZVNFwkQos08CzyCcm9HaoWkvzWrDuJQlJNTSge6obt1FB6PJ9ZqTdey
	 SIn3IruzrjfJ4KPAdqJr3Gd2nx2MpAODCKQXaNCN+fE/RMwDh+5GjedmxjLg53jWt/
	 zXNiKGVDzfXmLolTFdxwvE9SPxrTrxzgsLGoPJhdXYR273ANU/Jm8JwVVFlS9ehcTI
	 8UNEPbQxeo6IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0F44380CFF9;
	Thu, 28 May 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: rpl: fix hdrlen overflow in
 ipv6_rpl_srh_decompress()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177993480564.718177.17841853640746767104.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 02:20:05 +0000
References: <20260525154031.2290876-1-rc@rexion.ai>
In-Reply-To: <20260525154031.2290876-1-rc@rexion.ai>
To: Rahul Chandelkar <rc@rexion.ai>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, alex.aring@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 May 2026 21:10:31 +0530 you wrote:
> ipv6_rpl_srh_decompress() computes:
> 
>     outhdr->hdrlen = (((n + 1) * sizeof(struct in6_addr)) >> 3);
> 
> hdrlen is __u8. For n >= 127 the result exceeds 255 and silently
> truncates. With n=127 (cmpri=15, cmpre=15, pad=0, hdrlen=16):
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()
    https://git.kernel.org/netdev/net/c/9d5e7a46a9f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


