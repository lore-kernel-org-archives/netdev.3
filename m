Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48DB1632E7
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426285; cv=none; b=gvvB6Lg/jmyMQstoGFyDXDZPWEGwfFsz5fTjCsgUPMvyKo6vKeprmLUKuIqPS6wdlwxOmM5Uq7xkVDbvb+T0wGFjWRymR/EUn7JpuFtOeaOrPX0kDxnGNzohZYPQWA3LueoeuTz5j4bGOxob1IP02k1N9a9OAdbDBDqCEXdAGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426285; c=relaxed/simple;
	bh=NeARogNHzVvlJX5T4kJZc3mIvsSyih3ysIE0Gq2mNGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pm4+kSJWQOdPBErk2H/sPB4zY1jSTF5f6QFPnQC2P9ku7RWP/R1vO3HH3kaDZNWQERPlKLQLmVVR/j42UhtInO9qafaeiJkb3akahHCr5qOfaattz+m8GRdeX9g+Ibh5RYJl5QZOgp0XNWcvwtgW+r24rycvuThcCnAof3d3QrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7dyAV0i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7dyAV0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCFCC2BCB7;
	Wed, 29 Apr 2026 01:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777426285;
	bh=NeARogNHzVvlJX5T4kJZc3mIvsSyih3ysIE0Gq2mNGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B7dyAV0iPs9cLr3pQUoxj4nEKohPagj/NDMo8qHGhOapAnaF75zzyEb8rkq4LXO2I
	 ZkTVIOPQTGX9eImEhsq4Ey9RzpxdvJ9EmFvG5a7mamQL6+HpihYmdUjqpDR7UETOgz
	 p8UMk8ym/IDxKsijvqwe/0gIGUwQavr7jw5jgsi9gvvjNA4UNzjAFFBmsnvuxKUafZ
	 3pBe7BIqcsftf1LGGpBDKDtUfbEOxUt7H6h9oSgsO+pHrX9q0cxqa/H2vQCfB3yphz
	 Ae4/Oa37mxZjM2eDM7fz4WOeclB6Cs7MAEqVt/Wao5ng9Ft50ch5iqVdOILbx6Wktc
	 2RAOtHsPOYSOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C833139302C2;
	Wed, 29 Apr 2026 01:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dummy: do not acquire RTNL for too long
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177742624154.1288483.16574395460783232936.git-patchwork-notify@kernel.org>
Date: Wed, 29 Apr 2026 01:30:41 +0000
References: <20260427091016.737015-1-edumazet@google.com>
In-Reply-To: <20260427091016.737015-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Apr 2026 09:10:16 +0000 you wrote:
> Instead of holding RTNL for an arbitrary amount of time,
> call register_netdev() for each dummy device created
> at module loading time.
> 
> Tested:
> 
> modprobe dummy numdummies=10000
> 
> [...]

Here is the summary with links:
  - [net-next] net: dummy: do not acquire RTNL for too long
    https://git.kernel.org/netdev/net-next/c/bed510e44095

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


