Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66490BE40
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735695015; cv=none; b=LgaGz8l92kHTRk3Vfw76GspfYzYlD6caETrwkgvknwoq4g3gGuSSqjgxFYEyRWt/g2yNERW9aqCvA8SBxBEsc2uV8xrLJIsH5guAqs8BRhRGsWGg3rUHUwuFzryEprvyL3SS9wa+lVv4AaezGUOPhxrRDxpKpKYX0cAsDKImSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735695015; c=relaxed/simple;
	bh=JcWq9Kd2eKEZUMyda+fzNORAWTK/HJBZqnouTn4H0ng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=as7WLhzFh2iUr6Fgk0S5+zcswKd/OyG4AbUXWZ3SHvQafQKItb8E+WJOC7hyuNxjIsWdlGpEHRRUOaKT7cg7ZFtXdugLDamHnp6gYzgxP5Rbj7XoGcVhrnOsDAbz+/Aen6fdOl5WA8f6gjqtWz6ssqRYXe80ZZ+YWXS3SbrSk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odFfOpEX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odFfOpEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3520C4CED7;
	Wed,  1 Jan 2025 01:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735695014;
	bh=JcWq9Kd2eKEZUMyda+fzNORAWTK/HJBZqnouTn4H0ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=odFfOpEX3zDnPUJjTR7DEX8OUYvxtc8cUp+8d6c5QRO5t53rt6QLB7OsM8KpIWF3T
	 sOhdV4niSDwPK27dKIojL+gkOE2qETfle+pP2M792ed5YdC/RHpPENK4d5o2+fqZs1
	 keOxQz0HzFIhWYC/qeCbvw9qK4S5jlhaoTR/gysfyr6wP0R+R3ymEjTZUOe1pw9H1G
	 kk5WUDigHSihAJMtzVeqAQKlBN7Itk/A4p0uietnBLNFE/FT6hlXtEjgHJXNQo8Ry4
	 V2FfVKnzZrxATDhEGwi7P16dCgoijPju8CykdomHpPy7D6ktprbVMkfkMmMKlHRABI
	 dWjPqISW0eueg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF8380A964;
	Wed,  1 Jan 2025 01:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] tc: fq: add support for TCA_FQ_OFFLOAD_HORIZON
 attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173569503475.1658795.16447883433251555627.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jan 2025 01:30:34 +0000
References: <20241230194757.3153840-1-edumazet@google.com>
In-Reply-To: <20241230194757.3153840-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 30 Dec 2024 19:47:57 +0000 you wrote:
> In linux-6.13, we added the ability to offload pacing on
> capable devices.
> 
> tc qdisc add ... fq ... offload_horizon 100ms
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [iproute2] tc: fq: add support for TCA_FQ_OFFLOAD_HORIZON attribute
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=3f8c7e7c8b67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


