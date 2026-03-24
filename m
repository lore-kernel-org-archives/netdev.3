Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94D3074A1
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312219; cv=none; b=KPKprf6fOGmcmXjzykGLz3EruuPB+kAUA+u9BIWFbjv2/cC8Aj6W20lD9vR+Guf+k/soyQDBAjioxKxA50bop9jxXDg9ol9Vke3sOFWKrFsmQltrEwtJjLe7sn9WGbfCamcPjo6sIGZyEy7dJTzMbgUwsiexsjHfCH42RJOGZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312219; c=relaxed/simple;
	bh=rJXAUAHKP12XnC8hSCOlmPsbfvYA0AQKStzCw7+L4eE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tjiNDo9x0L7u04yh8Jmg66WrbWjP1Z1ULf1Zpfvg2FWfVwCt6oteDgXcW7pHa+B5gq2nGJ+02CZtj3LTmfW2K9MpCyFJJg5Yegf6PjAPXj9++bl+fWAgBci8AvT2BKCialV/Bkc2/2KlAWhxsMsrxfVIEQ4zAumomv7HbU05LvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5QSsFDb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5QSsFDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E26BC4CEF7;
	Tue, 24 Mar 2026 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774312218;
	bh=rJXAUAHKP12XnC8hSCOlmPsbfvYA0AQKStzCw7+L4eE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q5QSsFDb6HUQvAn+i4mYLcw+qn7f7rUbV9vHL3PMPPxD+CV1kcrBUEhe2zw6RnQmu
	 gLa3uSTlI4JDFKei+sAIuAAk72cX79UVelBEju14JdxlzOJBKmSJpLXBfuKizMf5Ny
	 Izi8XT9LdYkFEyc5Ro/dk8V6F8lrMFfrEb0xEtekeoFVI4Z93ZTaq0/SAoB9XtxDIV
	 7ranY4cPDgDMjCflme/ppNYtu8pSW4CqAObFtLxsecisLqs9/+8Buua9iUNyTx/aIK
	 0pF9RLnbnffTy1kfBazDLKP+e4r8A+hMIJycRhF0HTEU9lPIdtRSCVRb5H8nMciIun
	 UqJo255g/P6HQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E6C3808200;
	Tue, 24 Mar 2026 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fix fanout UAF in packet_release() via NETDEV_UP
 race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431220654.388684.858242122188558644.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 00:30:06 +0000
References: <20260319200610.25101-1-echelonh@gmail.com>
In-Reply-To: <20260319200610.25101-1-echelonh@gmail.com>
To: Yochai E <echelonh@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 22:06:10 +0200 you wrote:
> `packet_release()` has a race window where `NETDEV_UP` can re-register a
> socket into a fanout group's `arr[]` array. The re-registration is not
> cleaned up by `fanout_release()`, leaving a dangling pointer in the fanout
> array.
> `packet_release()` does NOT zero `po->num` in its `bind_lock` section.
> After releasing `bind_lock`, `po->num` is still non-zero and `po->ifindex`
> still matches the bound device. A concurrent `packet_notifier(NETDEV_UP)`
> that already found the socket in `sklist` can re-register the hook.
> For fanout sockets, this re-registration calls `__fanout_link(sk, po)`
> which adds the socket back into `f->arr[]` and increments `f->num_members`,
> but does NOT increment `f->sk_ref`.
> 
> [...]

Here is the summary with links:
  - net: fix fanout UAF in packet_release() via NETDEV_UP race
    https://git.kernel.org/netdev/net/c/42156f93d123

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


