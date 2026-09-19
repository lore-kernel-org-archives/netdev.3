Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD23546F4
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779090; cv=none; b=tn699lL4l6QMfQAdhmE/5hBEYEuxTBkU6xzV8Jj7p77+eKZQU5CMXezkfmHqTASpScMBs8p4auC8jIRuOD2e7UfWCC5RmslQQz5Ilg5iVLev1t3kzIocFQWc/10hIJFtSGiGN83QW4VtULKjoM1wv1Ci94zwmiQQjgN4lkNmJVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779090; c=relaxed/simple;
	bh=tB/5AYGChxsdD4KFZAchs9rFSVs/aWnbdSyQXAwg3qM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CQOiLHre5wiKb8vyJWlFIIXGjeFSdpaPNWKdLjjZgfEfMyvWOpJSGwcWotazMhmfklib4EkBORwmK0RdSQhTIQebFlDzlZt4cRUlxqclkcCNsFnPt1Knio0Ksadd2MThae4QWvwf0y5bwZphkfu5LzOV2HeAQBid0vemeY04i0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6Lt4iub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6Lt4iub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EACE1F000FF;
	Sat, 19 Sep 2026 00:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779081;
	bh=xXYVjLLt4QNICLL4Xo7n8hKzrCiXngxaW+lTkBtSHd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A6Lt4iub+nvtj1fG+ziEfhjieuAzUh1mTXOUo8xDpC2oh5sL1Fu6hW745vyp8L/YC
	 hiKc8B9yM0sPNMZ6qz48gJWFNdxnjELxnkb7eHQAUVJpZgiM6qwHBDFspaUW2SFqAD
	 Hd0+351FLxv/yTBN6V7vOptb6W7JnVJBr0Hs0PCgIAWhY+iyOO9hnKb/eRbtqUPflX
	 wKiOHfPNI6io/OsjmaIezO5+flKMH/715YNbmMU7rEF2keFBu6EopEXMrsvSwRu9dC
	 wqpN0FfUDs90YugMo+Uqq/sVbh4fdob3odEab3jo2M4Vfkgo96rjMCCE6vwhuBiXzx
	 jplK2uvT3xd5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93D863811978;
	Sat, 19 Sep 2026 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] tcp: Set unhashed_state in
 inet_twsk_hashdance_schedule().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977901414.1211687.8227210808199457040.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:50:14 +0000
References: <20260917191554.1600494-1-kuniyu@google.com>
In-Reply-To: <20260917191554.1600494-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org, daniel.zahka@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 19:15:52 +0000 you wrote:
> inet_unhash() sets inet_csk(sk)->unhashed_state only when the
> socket is hashed because tcp_set_state(sk, TCP_CLOSE) could be
> called multiple times, e.g. tcp_abort() calls it directly and
> tcp_done_with_error().
> 
> However, inet_twsk_hashdance_schedule() also unhashes a socket
> when replacing it with twsk, allowing the socket to bypass
> checks for inet_csk(sk)->unhashed_state.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] tcp: Set unhashed_state in inet_twsk_hashdance_schedule().
    https://git.kernel.org/netdev/net-next/c/404381b4f105

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


