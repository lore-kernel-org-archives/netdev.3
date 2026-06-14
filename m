Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2D395ADF;
	Sun, 14 Jun 2026 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781425817; cv=none; b=OsQRtLtm0NuVJgHboeOij4RfvMM1NN4uTGxjX6wH7ICart+Bnd9pEbfWcb+WLnBmzIo7/rlCKiR3NlLdfgab8u4bKFy1fdwYkFhU9ZEoiWNV1ZjE/K81tiYQXuQII70Q2O+o8K4sjtmdbGYJ3zsN58Kvb84DIZzJy/O9P7MnHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781425817; c=relaxed/simple;
	bh=DDh1tSSFF9Oq3/BXw+iRri0q+haQ8yCLbV6/wOfXlf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jv7Wt2SZ0MG0kbtXo1LeMaxqTLhksYwBgJBJjI5uGUPkEnbDMdGPTItlep2X2jXjHLhFsDVqCEEvuzc9ocfjQSJt8ixiuBcn7Vww+wnRxr5DxHcBTRg2wdtr+92gd8RrmhVEEsrItfN7WHrH5wGIFrjbN0y5/3jvOOdyOWEbLnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIcSpm4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIcSpm4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69FF1F000E9;
	Sun, 14 Jun 2026 08:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781425815;
	bh=KMGB2wtC4zxl8cCTED2HYAxFst6WblhGP6lozRxr7Dg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aIcSpm4/ewrbI6jYGdBXehraHHe7PiI5eHq14/xJaRP6yZuQPF4JSNxQwJ6/8psWc
	 TajR4E1B0zVgqMuBxU7v1iqQB5YjasOC+Nmw54vlwatjyEBMwOr2i0xuNt3gDyBo7C
	 v6KXL0TsKIg/I/Ubo+MKOJCq13J4sQtxPc7vCC7Amgxx0xeG7JFBQD8Dx9lRpaDGvA
	 4wxXc8Sg5O6JiORVjStgyeGhgZvhzYgwO4VDu4yp9w/ySOjDqIIipB3qt/pdtLbDrR
	 lWZk6zNmjyJ47w6q7ZNmQEdO27gw77H6T1vKxj8nO0D5SkcYb/IH9QJLAB4uoEsCK/
	 aGM7XA5yNnMMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09683A54A36;
	Sun, 14 Jun 2026 08:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] kcm: use WRITE_ONCE() when changing lower socket
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178142581139.1725970.11900596432572188440.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jun 2026 08:30:11 +0000
References: <20260611053543.2429462-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260611053543.2429462-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 11 Jun 2026 13:35:43 +0800 you wrote:
> kcm_attach() replaces a live lower TCP socket's sk_data_ready and
> sk_write_space callbacks with KCM handlers, and kcm_unattach() restores
> them later. Those callback-pointer updates are still plain stores even
> though the same fields can be read and invoked concurrently on other
> CPUs.
> 
> If another CPU observes an older callback snapshot after the live field
> has already been restored, callback execution can run with a mismatched
> target and sk_user_data state, leading to stale or misdirected wakeups.
> 
> [...]

Here is the summary with links:
  - [net] kcm: use WRITE_ONCE() when changing lower socket callbacks
    https://git.kernel.org/netdev/net/c/47186409c092

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


