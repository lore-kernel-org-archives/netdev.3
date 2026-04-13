Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F54181334
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121234; cv=none; b=lv7cjpaU9dHs/Ez8aY6aTJ8DJWxV8jGCC2aIwhdvyqp54E/e357JL0h/gH3nMx63emVZNuUrOdSXOn/y2i3Qma4yj3hKWrB5GZ7aMwY1OOJ2nk4StQu2Ppw+sTlJILKS5cRJsdClFFiyq0IYTfutJnoK9PwyucL9Twk4kgIQMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121234; c=relaxed/simple;
	bh=QfovIeAl9xkXW4y/8iBr4kK8QRgLZAUgt41+SlUOfGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kRjqld/Gh+VJJjxRAfwIp+LGMKCmd3m1egtaorc3geyLlMk4U3iEQItVDywoR3EzbzuU7zXzKWDh4ySs6eodsV+6Ui+9r6DtP/0Ri+2jwm672BCHlRsnPCHnw2JSY/P3YqKy1WOCFNzsuSHjBiYpANTuYiiOsk3C2Mpo6wfPqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3OcX2tY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3OcX2tY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8E5C2BCAF;
	Mon, 13 Apr 2026 23:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776121234;
	bh=QfovIeAl9xkXW4y/8iBr4kK8QRgLZAUgt41+SlUOfGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t3OcX2tYmZlqi5nEKRy5/G4drws7UpuIxFLM/3QAw2UB3OIPvRtWYB89NEGpDd3ik
	 mCUaWQ5u/66cw43pl3IuVDv5bZnDtpvQ+h1sP2dgESBFmdBDesEPERibj+Lqle5hQe
	 tw7QqKIlUzk95csKEjGT1wzkb4EF5Fopv0vFutkrjDAJ3VzKxj/a/eF9H9t5XwaBmU
	 coNYGk6DqTDzxeeREhAauKFOzvQMWwTPUzfQ374tA1Zyx4ANIABpV34LMTG69ZTosf
	 0hM/uIFaPQ1qjCtTn0m5o/r0JkflKSqpAN5qNznuyXUgU+UrI774yle7z1iVQ7Y8Eb
	 rSGGhGZJMmXHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E9A3809A0B;
	Mon, 13 Apr 2026 23:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] udp: Force compute_score to always inline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612120555.590374.6235954624800726670.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 23:00:05 +0000
References: <20260410155936.654915-1-krisman@suse.de>
In-Reply-To: <20260410155936.654915-1-krisman@suse.de>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 horms@kernel.org, netdev@vger.kernel.org, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 11:59:36 -0400 you wrote:
> Back in 2024 I reported a 7-12% regression on an iperf3 UDP loopback
> thoughput test that we traced to the extra overhead of calling
> compute_score on two places, introduced by commit f0ea27e7bfe1 ("udp:
> re-score reuseport groups when connected sockets are present").  At the
> time, I pointed out the overhead was caused by the multiple calls,
> associated with cpu-specific mitigations, and merged commit
> 50aee97d1511 ("udp: Avoid call to compute_score on multiple sites") to
> jump back explicitly, to force the rescore call in a single place.
> 
> [...]

Here is the summary with links:
  - [v2] udp: Force compute_score to always inline
    https://git.kernel.org/netdev/net-next/c/b80a95ccf160

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


