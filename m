Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887810;
	b=T4+xY6Nt1tw07rQbO7vA+EAClDc0Qkvuly0qfMavu4qbaluydghAqOk7vtdd+zuBTV6j
	 EFETwS1iTdbIFCwRFXcnWwYduOVRI0l0e2tPWbLF0uJ9cAewSV1sC4U0hSXiT/CvCROAn
	 Q+KAQC/GoZ6qEwVcpDlX1lrpTd7PezdWDo4Mr02KD+47ZphzhzNor7fySrVQTu6y0ES1u
	 ssADg2Wln6574pzl38lEciMjVwgyJf8erDexcmKRmSXmWiNtMlzSBZ9SxaWtXEjj698Lr
	 MLw3y2mwRVemEeLEDQVuZZHF1bY653R6G9PDOvE+2n1nFDRMgLI1ZZbhdGD0olRGbwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=EeFVB9+aKABo5zhfWltZXf40lvIe0vKfFaoEEhO2ISg=;
	b=gvLDdIwq9H5HfMKYA0KXOiqKr+7NhYzjsoJCYOoNbEt1345SshhuLt3svtI/8gOkQIVm
	 zXzL78E9NI+Z1GDnOn7Gg045lsmubQUZe5abirJI5bvmQpE8XKQeC7WFeioc0uzSF7B71
	 wWcKtQEsz7JWhacXjQk+doEc8nyouwm1BBTrGfDWkEGGsyeBaZ8o5L0BmXogn9C8D5J7R
	 tLxv43zw6BvVFgJw0yqnY01pISvOdqhqDdKgD8Uxh8r21HB3SrRO1/08kTYHiKL1ixPkW
	 eHA/8Kf2S0TylSvW48WYSRQOsAnNqkkk27jYFgqk+2jUop7SdcLqx8P9ZhE2wMDJ/Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wr0AKzY4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576D606A33D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wr0AKzY4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20491F000C1;
	Thu,  5 Nov 2026 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887809;
	bh=EeFVB9+aKABo5zhfWltZXf40lvIe0vKfFaoEEhO2ISg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Wr0AKzY4iSgu7JFiqyDZTer4XwFDwp3P5pLKpcRN3wIHG+zTXmi4bcDcIe7w7Vydi
	 gBqDpKnB1OxfWeZD/Bgh4x4ZSB7gE+mjbJf2Q+z7ZmSxPwggSRj5f3+wFP+z9vIv71
	 DoJ9DMu3ZaTrPGGemgUKqE6+/wKZncHIlswrE/lmdxyHJhzxY9lVQX+4qIl7kD395u
	 hMS8sejVF2csxZq+2H7mpP4YZSWYc4GpWGk2e+Ktb8SuBd0SPlMtz8xQ1qZ1V/rkra
	 Vy6WxHBxs920AWHEyztEAVVNxP4URZHYb+lUBwLBObJQCNodzVe6v0LtGgSjMXts1e
	 IOp5kzN5O97Qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3F3391AF93;
	Thu,  5 Nov 2026 14:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: ipv6: free ireq->ipv6_opt after an RCU grace
 period
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179388780839.3729553.17307587914819291015.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 14:10:08 +0000
References: <20261103090011.4128420-1-edumazet@kernel.org>
In-Reply-To: <20261103090011.4128420-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, sashiko-bot@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Nov 2026 10:00:11 +0100 you wrote:
> ireq->ipv6_opt is only set by calipso_req_setattr(), when a CALIPSO
> NetLabel mapping is configured.
> 
> Request socket migration (net.ipv4.tcp_migrate_req=1, or a
> BPF_SK_REUSEPORT_SELECT_OR_MIGRATE program) clones the request
> socket with inet_reqsk_clone(), so that the old request socket and
> its clone share the same ipv6_opt, then reqsk_migrate_reset() clears
> the pointer in the old one.
> 
> [...]

Here is the summary with links:
  - [net] tcp: ipv6: free ireq->ipv6_opt after an RCU grace period
    https://git.kernel.org/netdev/net/c/fafbc4051123

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


