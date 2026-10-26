Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057412;
	b=POslGdf/4x3eK7XoY6iv1WKo+CdBsRWNr0nI0e4scTWuSsqf8oANbU6nXSjKF7RP5znL
	 wJl4J361vB4v+vtrYvcBhro7U2j+6nZ93lJya2pjEDqgzCwhG6jZV7ukYuyUu2ndbBeFr
	 Ccs2wgtKNEITa28o8yZvA3ohaix0oUy+rSchn+LjecptQGrhFZh678jfecq9q9oENcZBi
	 3F/BuI42NJ/RSKNeTKbjwl4f80jSU23BxEpPfK6U1IvS5o2S4nFirB4Wkjz3Le9kkwSWE
	 zOA8L5PpuSEm5xgoYEljR5gBBb6MT0ojqsUIPl5DWUro2omJvmq6oLoiB8qYvvwjaeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=80tOCrOp6Ey2wC5e4eExDj1W6gfvC9XlwH5pQFkSK4o=;
	b=WgvANhCnwttoqxPo45gzToXUpIfjg/LmEwXPABpIUxD7XF9qXT3zWOGTFDBb8czwncdI
	 kNfZH0F8XvaJPw1MNWh4X1BPTbFAxkG6BkS9HnqF+WkQCyus+aAqz9JlHkRVLfvRX1/Hn
	 cjbnH9HQhTx+EpDVEuGOvJAMTTJRdIRnurjA28Vnvqez2KHl17wdI5+H1O6ZZ9kJCeRMy
	 noYj7rqimlVDb9xbJJbJAbSh51sBqV6UIga30AIV6hOcJslpD/hSZY605Ycf5fJ4ctcGu
	 Gq0JlUlDMXG48LM9zGhrHedrYFrCgxfMoNT/v8CBsnmJ3m3z04OKFhpQDKzOFnrO/tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuVmTPpL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7F60A260B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuVmTPpL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394AB1F031E8;
	Mon, 26 Oct 2026 23:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057412;
	bh=80tOCrOp6Ey2wC5e4eExDj1W6gfvC9XlwH5pQFkSK4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SuVmTPpLK77kSIxy4hvSzdoTok1prktEyt1QlKR2POcDp8v42uXO8S4cTC5gPM1UB
	 zfMjBYbMbiLWSiWS88wZRA0eLU+1oQeFlgI6CdmfXiGli1gsDqkKF8wqi3NC4qwnaC
	 SEIu8NFu0i8obrI5scFZdLui0kljUxnO/a743UhjYPFsj9fzAWBsjFDUulwQAA7ceq
	 JQ6tg78bq/8YR/kIMGBqHiDN1azaM3Y4sS0CO99OBJGOS3Z0Cs+Hpe9Bd6QA4dVSee
	 rIJhyaoqB26xjIvyR/mhoeS189IM/fQppi7+yJaAsrwF4V/WLpTP6de5Dvty1PshVp
	 +jKz/HOBspahA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2F32D3AA80F0;
	Mon, 26 Oct 2026 23:30:12 +0000 (UTC)
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
Subject: Re: [PATCH net] net/sched: taprio: unwind the netdevice notifier if
 register_qdisc() fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305741081.3456332.957586637723940788.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 23:30:10 +0000
References: <20261021155417.66254-1-phx0fer@gmail.com>
In-Reply-To: <20261021155417.66254-1-phx0fer@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 23:54:17 +0800 you wrote:
> taprio_module_init() registers taprio_device_notifier and then returns
> register_qdisc()'s error directly.  When register_qdisc() fails the
> notifier stays registered, but the loader's failure path frees the module
> image without ever calling the __exit function, so netdev_chain is left
> pointing at taprio_device_notifier.notifier_call -- a function pointer
> that lives in text that has just been freed.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: taprio: unwind the netdevice notifier if register_qdisc() fails
    https://git.kernel.org/netdev/net/c/c5234f89d7cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


