Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088739D6F8
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121837; cv=none; b=gGOAN7DllFsCR0t+gHeaUFkrR8TrbBhtttMLpkJQ78X9FiirtDaZcCkuXSja14IRrBH1Gv2lvfMHvtvkc+YXk7vd+nil6QE9mxsSYQhIEfKTUrWtAPx0uJb0vWyytcI2y2OlIRVZRkRSz2A05AFPTuHYHPX1tHt4KTniaxBFirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121837; c=relaxed/simple;
	bh=X+LNtnB3AWwcCUyCm9d5z68ubErmcMtXduQY8/H8Tjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eq5ZkArSGPGJVjbKyK0PsvvlJzcXJ0fL3B3Dx28Je2IRyAPxV3nV2fsaqvj/RTx7y5sf0qPGWc46LRQritNlrA0h4fpbBG22v2D/dIaTs3Zp1/ZpykIFHr2O30iSM6tktObLyL53zIGeo2Z/x4NCf6byWTmTdfzqahcUS1LgMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWYg+6eg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWYg+6eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511E1C2BCAF;
	Mon, 13 Apr 2026 23:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776121837;
	bh=X+LNtnB3AWwcCUyCm9d5z68ubErmcMtXduQY8/H8Tjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aWYg+6eg0MnYZPLQz8FIQ89Je5gbaMCfwTDBLnsG9e7YcfS+CKUp3J96uvrjyU/NW
	 pJ5x40JOh6OJwZ3E/cmBzx8+X7BRASafSXd+pQ/NyjSBUoBoL0UvGGy0J6nGKMwX/B
	 BI9jtfK7WPgzYp06htXa+MNbJaKjA+XOjHXmvwCYdVq3bm/p/GtklLMnhID/sqiSmf
	 RuDpLZFOiv/0ZD8bkC/lUwdps3gxNPPY4/TKlk98tpLjL5GJ9nwd2S2BbxYargs3XK
	 uHibBsHcjLMkSd66jJSQM+Ac5ZfT8JDkQmJ+NbHYBj6qGbbxJFl4M9ZAUHyrjxktvr
	 1up3xih5SaODw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E813809A0B;
	Mon, 13 Apr 2026 23:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Don't set treq->req_usec_ts in
 cookie_tcp_reqsk_init().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612180856.593344.15379063877643088001.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 23:10:08 +0000
References: <20260410235328.1773449-1-kuniyu@google.com>
In-Reply-To: <20260410235328.1773449-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 23:53:27 +0000 you wrote:
> Commit de5626b95e13 ("tcp: Factorise cookie-independent fields
> initialisation in cookie_v[46]_check().") miscategorised
> tcp_rsk(req)->req_usec_ts init to cookie_tcp_reqsk_init(),
> which is used by both BPF/non-BPF SYN cookie reqsk.
> 
> Rather, it should have been moved to cookie_tcp_reqsk_alloc() by
> commit 8e7bab6b9652 ("tcp: Factorise cookie-dependent fields
> initialisation in cookie_v[46]_check()") so that only non-BPF SYN
> cookie sets tcp_rsk(req)->req_usec_ts to false.
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Don't set treq->req_usec_ts in cookie_tcp_reqsk_init().
    https://git.kernel.org/netdev/net/c/c058bbf05b11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


