Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD33C4B91
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171413; cv=none; b=hwqX+5tg7KLWGhsQAG/nhtoJqyb1E98ZIMguSrz8LMVBDsWSCAZxmjIXjpqAdwQlMi6pkVaNDK8FAghl6Cjlphan75+eZc5ZCJqnYE1wIeZbTX61V0pD6lBOoe7YBM15XfWxQjBIBpW8Dr2z/eujDvpViIzmZ26jvGHH4Xmns0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171413; c=relaxed/simple;
	bh=3cGIHNV4sdbRlDRRQigqfHz+BG4fKl71L6LbY6AMbMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gSj1bEowLH3SYUFTzJxp8bMzM1lEXAqYUuvaBy4SZlWSCbD0VYc5rdYxz1/rgjMTz/RNeNItM92bJGfnKPbKvXq+WCnAx5MvdCc92CYfaWxG9MYWluKFj70W4m0zRVIqBJSJzdIq06ltbRHAZNBCs6RT9hPpyK1iaZu+fHwwyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAKwrr3b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAKwrr3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CA61F00893;
	Thu, 11 Jun 2026 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781171411;
	bh=NoZGIJtRjfbH4WdSjCJwKUnQukD9CKlD7VTq/fyT0hM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GAKwrr3bnZ82rWsQnPJsH++aJTgei99WwMi7OInIeVAJEpeIWCYHvKhf/7YKDtXWv
	 BI8TtxGnmCOJzAWM8v1abZ4VqIStveHu9KGFlm8s76HsjskCPl+IvIq8cj2sOWOKOk
	 8FaYDkGMpgt7rVf9Ya7+rnm2ybJ8Zxkh2KoJcK6RZ4gvCVWzKbFqvPk1wzhrGYuQKs
	 uiXsrBql2NRblivJgMVQpGlrG1ZFiBX6YiZc2GKbCxZkH+85ct60P6k6gSZnOKL7Y9
	 SKDnNKxDrMcRAzMvYC8uy69fvi0sRZgrI2qkZPkTjDWnvx3LMmWOMW9CUXz7oXRnql
	 P5htjIGPsqFNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938C03930E3C;
	Thu, 11 Jun 2026 09:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] selftests: drv-net: so_txtime: trivial
 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178117140939.3866402.16832857127184178646.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 09:50:09 +0000
References: <20260609180803.1093428-1-kuba@kernel.org>
In-Reply-To: <20260609180803.1093428-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Jun 2026 11:08:01 -0700 you wrote:
> I noticed that so_txtime is only passing on NIPA setups which are
> looped within a single host. The cross-machine cases just flat out
> fail. The initial bug is obvious - the test does not deploy the binary.
> But even with that I think more work would be needed to sync the
> time / adjust the expectations for a dual-machine test.
> 
> Willem promised to follow up on the fundamental issues with 2-host
> setups :)
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] selftests: drv-net: so_txtime: remember to deploy the binaries
    https://git.kernel.org/netdev/net-next/c/46411c889087
  - [net-next,v2,2/2] selftests: drv-net: so_txtime: check IP versions
    https://git.kernel.org/netdev/net-next/c/3bdd6852c2af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


