Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB5729A326
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014618; cv=none; b=LI6nxEbjxOuDVWbi4VN091loY3bMW/1/zRNHp1FOKNNqIZ6mXpR3DG8RqfWZZ3HmjPvUJ0Ee8oXIwgPypOw0axhSKZbafz2fAO5aGNsvFXm2RhIS6ckvqqGTL3HZSKfGHfioMNZ/VunE2TotvqdxPys2wt95d+1rRsV6Gn1N1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014618; c=relaxed/simple;
	bh=k8aK1CeDxzOduVS3gFLoL6VVtq3WzmIK3OM8WIAELNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IwlyBvJOxxUwBRJzzaFDyOlYHarfAaZ7PYKpWBG0O67vCgOVeMPZlZK5CR/6ykGJGlCBU+7HOuayxAMQtArzxck5jzXtxA8Ukqs9Nb9vONmvA3QsLtnzSVSuC1g7AQ1tvyQfI+rcsgktBzrYAWuct/e0h0T7xBJkQdfFpf44dSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiDZY5kT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiDZY5kT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C088EC19424;
	Fri, 13 Feb 2026 20:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771014617;
	bh=k8aK1CeDxzOduVS3gFLoL6VVtq3WzmIK3OM8WIAELNg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TiDZY5kT+ZRyHMh9iaEhissVXcpylLjAc22JffBGJ0td41/VEzz1zq3KR1LKxUxDc
	 tfaS1FzO5b70ZtxXeUqoV8ZlrN/GOfzlDI6rh9S978CmxE9bU8N3NgmyI5vOexfz/a
	 MNuciWEkLexdgig33/7FxTJ4hqLekdw48EzbHPWZ8/3XyUZN/9x9uI+uWhwsiDecZf
	 vJUVzVsYzmHdhrse4iGQcm7oEAKk06rKkYX0tJ1lMAW/2IAeFF2sN9itckZLcVd2LA
	 vsUS2cwm3GgZPKBNe+x9uyOa55QR29g/VeRy0GHKvaJE1D1fgv/RQDsQrzeCdYKYUJ
	 2+Xyy+4mdDhoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C227D3811A44;
	Fri, 13 Feb 2026 20:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipv6: Fix out-of-bound access in
 fib6_add_rt2node().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177101461132.2548179.11036881071505557933.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 20:30:11 +0000
References: <20260211175133.3657034-1-kuniyu@google.com>
In-Reply-To: <20260211175133.3657034-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, syoshida@redhat.com,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+707d6a5da1ab9e0c6f9d@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Feb 2026 17:50:21 +0000 you wrote:
> syzbot reported out-of-bound read in fib6_add_rt2node(). [0]
> 
> When IPv6 route is created with RTA_NH_ID, struct fib6_info
> does not have the trailing struct fib6_nh.
> 
> The cited commit started to check !iter->fib6_nh->fib_nh_gw_family
> to ensure that rt6_qualify_for_ecmp() will return false for iter.
> 
> [...]

Here is the summary with links:
  - [v1,net] ipv6: Fix out-of-bound access in fib6_add_rt2node().
    https://git.kernel.org/netdev/net/c/8244f959e2c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


