Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718007;
	b=l7nxi9e/ZVoA6ETq48DVd4wdsiO0ZEKX9rylvbjepdL8JPYUK1hw58eytzAPvOCshuF2
	 w7wfuqL1SKO7xRG8yJiM3FzASJtdqW3UnaLn0KrqPkGejnWNMsah6ml2lcg6W7iZUPKJf
	 U1fJeYNsTBMZfqvzpJpJDWUemF3grIA1RoYp+5gswH+NloKOxHlscDOUs8cMEk47pi/0D
	 fPDJyuJWOvm3VuA6C8o6pLTfOjLzjdmBAHm8vVnOvT9lAa0Jw5ncBej4o80ZljR6Ba5zV
	 sBk/cazk0UfqH5nviv86COr5KMfChNnj5hJpXInSrYmhz0Q4/dw2yiccsCgo0Iqxx7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=qZmVJVY++gB7+dJFa2rdv7ugRYHNUM+bFI1bNN4cS3Q=;
	b=Dc77g3/inQU9jmYoeyNWtDwsTi/WhenQopp9D3rFZ9sR5oa4xA4+J1mFW6hoBh3wxyMj
	 jQ6gUHozAAKoYn73q/uSV3q8/b2J037QgLy32Ch/mCk60t8gLuKA1w7FY+PEMmuIj4bqZ
	 gZFOJizCSzmvVA8u2dZRxUlfQD85kR8rkRm9vX+pVZBwzlNzAlUPljfUY1evXX1ZH3dnV
	 iz0NbvMZiV+qm/PR0FcVbrhXGaDHpHqDJK1e2CVu7ZcW4fZbaWkfrcNeNdILUs2I1sSaI
	 +ovW6WFesDdZQoLE58fkO+p9CLx8wYoJGWYq/TiJ2wrK2/Tg0A6/PFtY/UNtRXux/5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQiTaTIq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B8606D2DF
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQiTaTIq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFC11F00919;
	Tue,  3 Nov 2026 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718006;
	bh=qZmVJVY++gB7+dJFa2rdv7ugRYHNUM+bFI1bNN4cS3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QQiTaTIqmWQY6ypZQUZ/U/NvJ0IFpFDqkg0k8HdmQ2gI/v3V1FQQ6J/xk4LraFlaV
	 f6pa87RpajESBJLS5wwxtkWf9mFYUGvqysEBKjpPk+jtFvI5pPdACMQH8Z0m1s4mCF
	 +aRoJVI4R9UyP12d3KyaFSMo5NiwaoOM+PcKTUESRk0ZM+1Yg0wGdLVrqZPXWrPVcf
	 gdSvoOg9poi23bhCAw+vTT5XxvqrJkp1gjEy64A95er9M7MMVaba9uLWh/ujBBk9ha
	 ZTFlM5GbLi/Af63Xtp5RKBHI+Nd+UhC7vED6uouPYXi1lAs7iK3OnczfDNad+9Az3p
	 7zYVKCV1rVtFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA32238007D6;
	Tue,  3 Nov 2026 15:00:06 +0000 (UTC)
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
Subject: Re: [PATCH v2 net] tcp: wait for TIME_WAIT teardown before freeing
 per-netns ehash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179371800529.1198064.9879042623576764067.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 15:00:05 +0000
References: <20261030075843.2567707-1-edumazet@kernel.org>
In-Reply-To: <20261030075843.2567707-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@google.com, ncardwell@google.com, horms@kernel.org,
 netdev@vger.kernel.org, kylebot@openai.com, jiayuan.chen@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 08:58:43 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> inet_twsk_kill() removes a TIME_WAIT socket from the established hash
> before it finishes using the ehash lock, hashinfo and bind tables, and
> before it drops the death-row reference. A running timer can therefore
> unhash its socket before inet_twsk_purge() reaches it. The purge cannot
> synchronize with that timer, and tcp_sk_exit_batch() can free the
> private ehash and hashinfo while inet_twsk_kill() is still using them.
> 
> [...]

Here is the summary with links:
  - [v2,net] tcp: wait for TIME_WAIT teardown before freeing per-netns ehash
    https://git.kernel.org/netdev/net/c/647b81ddefc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


