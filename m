Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17008284890
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377633; cv=none; b=hz94Ci7FLLRk5OEhB5WJQ/ojZbJEKYMT80GTBwnSkeoyUDHeDIpwxe0ZLDK9NN4KN6KVvEKIhHhukOEHT3qVd/yCpd2wa6hwn/+W8SvPCmn/MyC+myoJojU00QsoD//R2u6HZoPaPtvAVovRpgEQLIVhLSDzfD7M52RnKClB78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377633; c=relaxed/simple;
	bh=ZxFjjCS+YnhDU+/oa+kUlpEx8cWUl/P/VDsmNjABpXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wcx8QcxuPZS8Tx50oxGOu1rR3nZjPyfeCYst08SaQ54p8eATQ1fH+jjvIDQYir5MfA9HtxdQ3OwIWqXDs2jwP63/cZus+qyt/ET4/bP4wWuUYZ6iNAIhKyblYx+1CAFUY7vAg8uo7FyNNE2wFUkS2Ic9B9IOFMIInaFsykUgMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRbBNiu8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRbBNiu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D23C4CEF7;
	Wed, 18 Feb 2026 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377630;
	bh=ZxFjjCS+YnhDU+/oa+kUlpEx8cWUl/P/VDsmNjABpXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uRbBNiu80/9eBuGBkx+Vu1X2RvT3Q9MjID31yL+K4v4cj0hd6zKBfIvXGc7oIOLLf
	 6w/x+wWGBOMRCluauuc+cbtgBToT8cEsne4WgMOhwD1punC8Qn7t3IQkeljgYovLtU
	 +0oqXqmdVcsUdnIeri8Yqw2EBESKCorR7ho4DWog87+mhk4ULbHgQWoK0uUFz/XSQN
	 rQijO22/Fvg55k8tca3yF94eYMf52O6HG23DdLDr/dBRgktkRKLN5ePlhfDlrh7gz2
	 2elryU/fSnQYORmjl0D64xK9gpVuar+ml2e8U/KiqG1SCsaJ7HGk8qPtct21UeL6JL
	 vmwRdbLEfx88A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22603806667;
	Wed, 18 Feb 2026 01:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: do not delay zero-copy skbs in
 skb_attempt_defer_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137762257.765825.11990417995697717058.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:20:22 +0000
References: <20260216193653.627617-1-edumazet@google.com>
In-Reply-To: <20260216193653.627617-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Feb 2026 19:36:53 +0000 you wrote:
> After the blamed commit, TCP tx zero copy notifications could be
> arbitrarily delayed and cause regressions in applications waiting
> for them.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Fixes: e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> 
> [...]

Here is the summary with links:
  - [net] net: do not delay zero-copy skbs in skb_attempt_defer_free()
    https://git.kernel.org/netdev/net/c/0943404b1f3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


