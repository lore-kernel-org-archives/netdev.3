Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D72368293
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701232; cv=none; b=ZdK8KaksVbKjOU1OC9OBwkq1JP3aa36nKw8mcVUpBDzZZip8qRKLXxV5wxKBvmAO2UVnjFQu978f6TLXthRw6XXzxQ/fmFgpE8wGUsxz3Wj7nv5EYX6RQ0UObpk8mMieWVyMI+tMT1ET86vDOlsne7gb8C6BCne0QoavSYKEvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701232; c=relaxed/simple;
	bh=3o7KTKIEcYRhtKue/mJ7//7cbEmrCMkleK45w74r6e0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qPqxZEWxRA3V4M4t2KtokUz0bPVgIObipXRGonVc1XRECIiJo/ItT91u35RSYNlzBQN72BeX3ZOMY1Qna3SZEhds2vwYox68YFSmfPEvIAPcSfvG1WRQccepxVIOnCTs4yrkMCi3/MOn8hnMZ7za5qZiDJSF1P3P1qggHPZVSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvard4xZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvard4xZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14AAC2BCAF;
	Thu,  9 Apr 2026 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775701231;
	bh=3o7KTKIEcYRhtKue/mJ7//7cbEmrCMkleK45w74r6e0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yvard4xZZ+4B3/UyTdNg18Fmn3/WwkcHLEgDjNqp6FGXWsXyWMHN1I4lNs2RqHVGf
	 d81vlna6yx9Qz92uDmwIFoHq4d4MzR7Dummb8qpb2KxbYBqMCQEN3NkFUn1lNFI6+9
	 H7+WjGhTZIc6za6WHu9Tobdmdu060YkyeRp/E5LAo+jSfXLiacs0zZgQ+pyVYcZH8b
	 PWnOnVbdjVlKvwuBs7eiwvYNVQHsQ8rjb3OVV2cRx37MWMb/sPwgmKF7vTuwvJowah
	 vpRbIG6rnQTpUCe0vSDPgGgw0cOstdqFyJb1rmgLISiOflUQqZBk6VDDokaJYVXmki
	 kYmQeEovOKcnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 403233930793;
	Thu,  9 Apr 2026 02:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ioam6: fix OOB and missing lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570120779.959042.1761186273558985346.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:20:07 +0000
References: <20260404134137.24553-1-justin.iurman@gmail.com>
In-Reply-To: <20260404134137.24553-1-justin.iurman@gmail.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  4 Apr 2026 15:41:37 +0200 you wrote:
> When trace->type.bit6 is set:
> 
>     if (trace->type.bit6) {
>         ...
>         queue = skb_get_tx_queue(dev, skb);
>         qdisc = rcu_dereference(queue->qdisc);
> 
> [...]

Here is the summary with links:
  - [net] net: ioam6: fix OOB and missing lock
    https://git.kernel.org/netdev/net/c/b30b1675aa2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


