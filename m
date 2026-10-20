Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529413;
	b=RN3xrj0OhzT/jdHcoE3HO4hj+rq+MlwYjxYoTfGaBIuWLHaXcdFfj+aaRcY08RJsa91+
	 toUTxDUA7PB8YgZpaXHRGqUz3jFpEVIlClF4Z75+km2lpZGJvzfqeH8fhkHz81adoSyJy
	 KgI5QFP1vtBTTV5DQEaOXhdZrz20z6SZrJ1U0ZBgRyFI3ey7BE2Ts3YYW4C4Khn7kL2V9
	 t2G3fDgdmkwRaoEkfiZa/HoUTbvpJpA05WlDLC2TkWTusiCrya4Ge4tpZHwDbh/wJmMuV
	 WrZurqsbLCSQlmL+FYY+ZaqhehXGtOV9g/MhqNFL1ckZcMGkL+/+kmQ+CXYRSR9xGZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529413;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=k4QiIIceOxh8s42YNDmLH0hltpfLcmAsKRADJcClGxU=;
	b=Zf5ZCtcbVQyXPb5CuPx/sS7rMo810xBm8dIulBPheUQXQjRW3JOX1NZwwKL5Qs0Wk94u
	 xtPqR7pSrYhcnNgy8R/r+tJm6Lf3eOG4FAhkuTnc6ULAeZpbIMrfdrDAIcQdLEZSDSpNb
	 vA00t8NmPT5c9HWG9ZuKcZqg220T+7splGeDFl0qNGjlXNouc3gADJOCN9y1hZT9j8UnB
	 2Yro35FgkDw4jmEpK5CN2u7wiw8ettKXFTB6upqO3QAK+fNQBqSsz8YgL+SdBhyXR373X
	 3Aj4ZzuwQrp722xAyFAo74mHvn7ORZkyti4HbknrE/zvoseOUmLQYDctcswHQI/ZEbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFkNsSuS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE2E606A31E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFkNsSuS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421D81F000CA;
	Tue, 20 Oct 2026 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792529413;
	bh=k4QiIIceOxh8s42YNDmLH0hltpfLcmAsKRADJcClGxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dFkNsSuSTuEo9Kc1bUdiM5ZcxOWaOuWOvcfcZdsRkXJNZYm6dihsfFYkfy8MLM4u2
	 /7fzyjjjqI9c/QsYp4M84A+BfRB5QwFWl80dhtKdJdGgQd4p9TQeqHEH+wGmWWUI7X
	 Vopta2ywWxY2cZdE8rVRAwoNGiOeWjtXg/ewwIOUZSN9RONc1jAsQyA7brF/sM2EBc
	 5H3lBdB5yDuKWsm04Kkzt6vHmUS9srjWNiKhZGeAULzNi32EY2Cr6qlB1jfpR1fD/B
	 bp5KpC+sK+FG2/5BQC4pBjdnxQ0j2CMLBzt8bq4KfOmC+qqVCtO3v/BFzzZtr0TilT
	 g4/6KUGUZufJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3943809A09;
	Tue, 20 Oct 2026 20:50:13 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: Port skb_segment tests of the test_bpf
 module
 to KUnit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252941177.202014.1438547262680039100.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:50:11 +0000
References: <20261015151033.591439-1-daniel@iogearbox.net>
In-Reply-To: <20261015151033.591439-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, memxor@gmail.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 17:10:33 +0200 you wrote:
> The old test_bpf module is going away, therefore port the two test
> cases which were added in 76db8087c4c9 ("net: bpf: add a test for
> skb_segment in test_bpf module") as well as cf204a718357 ("bpf,
> testing: Introduce 'gso_linear_no_head_frag' skb_segment test")
> into the net_test.c to retain coverage. With it in place:
> 
>   # Subtest: gso_test_func
>   ok 1 no_gso
>   ok 2 linear
>   ok 3 frags
>   ok 4 frags_pure
>   ok 5 gso_partial
>   ok 6 frag_list
>   ok 7 frag_list_pure
>   ok 8 frag_list_non_uniform
>   ok 9 frag_list_head_frag
>   ok 10 frag_list_no_head_frag
>   ok 11 gso_by_frags
>   ok 12 resegment
>   ok 13 resegment_multi
>   ok 14 resegment_tail
>   ok 15 resegment_one_mss
>   # gso_test_func: pass:15 fail:0 skip:0 total:15
> 
> [...]

Here is the summary with links:
  - [net-next] net: Port skb_segment tests of the test_bpf module to KUnit
    https://git.kernel.org/netdev/net-next/c/e64bff85e3c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


