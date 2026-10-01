Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35453E7BBF;
	Thu,  1 Oct 2026 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845808; cv=none; b=eRf/R09D/9JICgCRA/eMbWj7s7mRO3def6WxpsvMQeGIV7kPElg8MS3rl2+afhAlRrCT09bXzg6sDtsg4kYN0uQRMruXRWcCcSvvITmbRRHIPb8/5GqiBDsU7H7Ez1RYITo91F2e1qMqo3R3tZ+8KPv/QVjYE8MfE4u+SUS37us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845808; c=relaxed/simple;
	bh=iz4zL4yBCgC3AJ04PE5Ll1z9DQ9v77rl6QMbdHtvGzc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JwLL4mhY/Qv/hPbNsS2YpPXYWschC7oHrJY8EFFzuC2R36n/KSj2sHryQB+oA2PFqVE2WrwpbvZIYTgi5tvwTQ1WYBldX87I4DuR73q0nazzIFcY/mXeFCWdctNy9pbGfZRutSUUmALP1VDHdawPons4gqc8PNWLfJyzeRwe7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLYmMBIv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLYmMBIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E901F000FF;
	Thu,  1 Oct 2026 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790845807;
	bh=eoou3OPTFrEt1YlBn5GTaN2Kc6JUFffer/XbT4HVIgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TLYmMBIvIp1RffFDpzuOuAkDROhMEq9uK5qoFy3hTPU1sDTsuegRipWG/I2jjREsQ
	 D0Dh8ucHfv8MUJZoWWwZWLbdQV5VL3zOTZOoMBUXq5zTICX8Z+Kiifpdm4gUYzwXLK
	 zmBAFaH1mNPi+AZFWIkFJfGMkElcBtrHFE/Y0jotteLIFhPFSssDYNu+1OK9CiGoB0
	 AUSedN9HwTBFSjP3OcWn05UuesM8WY9Th24w+DMb+w3KgXfBzgiyz61dUnWtIb0GZd
	 4h4IK+ljSq6UtTA7XBe+7KGiiXaVa+4htQUoTNKOfr81wMS1EHs2Q3vw7waRVhOHkB
	 7zsBmtK88osqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A33C380DBD7;
	Thu,  1 Oct 2026 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] tcp: annotate lockless access to
 sk->sk_err
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179084580603.2345972.12417462062055169444.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 09:10:06 +0000
References: <20260925-mptcp-sk-err-net-v5-0-0cac04d6ea48@proton.me>
In-Reply-To: <20260925-mptcp-sk-err-net-v5-0-0cac04d6ea48@proton.me>
To: Quanye Yang <quanyeyang@proton.me>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 matttbe@kernel.org, geliang@kernel.org, martineau@kernel.org,
 jiayuan.chen@linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 25 Sep 2026 05:47:55 -0700 you wrote:
> do_recvmmsg() and getsockopt(SO_ERROR) call sock_error() without the
> socket lock and clear sk_err with xchg().
> 
> Patch 1 covers TCP. Peek-only sites use READ_ONCE(). On the no-data
> recv and splice paths, call sock_error() once and only stop when it
> returns a non-zero error. tcp_bpf_sendmsg() folds two unmarked loads
> into one READ_ONCE() and uses that value as the returned errno.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] tcp: annotate lockless access to sk->sk_err
    https://git.kernel.org/netdev/net-next/c/3b49f11cc92d
  - [net-next,v5,2/2] mptcp: annotate lockless access to sk->sk_err
    https://git.kernel.org/netdev/net-next/c/97870870b7dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


