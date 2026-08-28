Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52615361962
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787958086; cv=none; b=fTyBMeipT9bXfoMXShfbkKsWhONytcAJdKKZtacCD578ZTtzNd2U4M8FrUtodcMdtt9XjCO9EYH93grISfPP8sZX4bVrMtvRJQ/xb66K/+SyCYYXZX4U9jZ9pUdm6M1BKo9Gm7ldT8FLjzgHmyoEnWwVUQ7Gd8PbOwfvVAbgYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787958086; c=relaxed/simple;
	bh=LGeI7YnUncRZE8NiAZepCDbG1V4fCnmxoIQZWhxCmYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QwM4hBuKh8pGqJNOStGNiI6gNN+G7dEuhybRhHOjcXxooSkCmCWsOYs/C8PFM9dJCQGAIzevN5zkZ/JngkOcfSHkplcKNGU90H129GFPlcTgm9Jbeh4Nt2kONTsllMelzKXfFjgcTHdLGsgE2mi5/mceivdTX0wUlBGj3o3D5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIrdYY4r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIrdYY4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F311F000E9;
	Fri, 28 Aug 2026 23:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787958075;
	bh=SRMmQpYtvQiUITUZbYVM6Zhm2wK0/xp+pYwn0YuY5NM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VIrdYY4rKedH5/tfG9ZRa+dBDgTwrMzcy5FJsLca6lky8UJYmWp+QEYWIvCi6G7Bz
	 XaWBZqxDfX7rYPHU/s5LF+HaRwtJZ/H7D4QlpzS/EC2fbVm8c2UXzPcvUQuvJxIm8+
	 AVPlJithuLFg3n9Xjf6wVTeCPQND3EhhBV2Al97vUIonHK6ov8zq4DpZfUDiEg0t3H
	 lAEDm9PnwZl+/fbp0EeulvTYCkbU/Fulc5M8ttwecVn8l4y3LmApqQcmW+q4icND8A
	 IxtzHcA5jFSurgJqvJSW6h3o8usoVl8k2FsLLbv6KL2jwd0XruYi3V/FZecI+8PVyK
	 qaDr2bpoHxPVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0954380AA69;
	Fri, 28 Aug 2026 23:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] tcp: use GFP_ATOMIC in tcp_send_active_reset()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178795802039.2832451.17041314817734736256.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 23:00:20 +0000
References: <20260827095936.551524-1-edumazet@google.com>
In-Reply-To: <20260827095936.551524-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Aug 2026 09:59:36 +0000 you wrote:
> tcp_send_active_reset() can be called from contexts where gfp_any()
> (in tcp_disconnect()) or sk->sk_allocation (in __tcp_close() and
> mptcp_do_fastclose()) evaluates to GFP_KERNEL, which includes
> __GFP_FS and __GFP_DIRECT_RECLAIM.
> 
> Allocating with GFP_KERNEL while holding the socket lock (sk_lock) creates
> a lockdep dependency:
>   sk_lock -> fs_reclaim
> 
> [...]

Here is the summary with links:
  - [v2,net] tcp: use GFP_ATOMIC in tcp_send_active_reset()
    https://git.kernel.org/netdev/net/c/18666c73afe9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


