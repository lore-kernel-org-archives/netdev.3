Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412610;
	b=wgTgZaQ/0ap7qVx49+xxFualPDG/Eycrn9ryfL1LUlCIEQfRpp6nG9e3JBa/foME/7VW
	 htgdGB1RSzjihMDdffjz+QEqujx7wn1f0xi4NMaMZ4oSww1vQLUuoO+xeDwYUxtczfuDw
	 xXQ4SyPtit6P9DFKalgazVCXYGHxYwIfa4kNXhnjAiWoDeEHYH/oiMN7n/Qk9J7EgPJhx
	 XkWi6rFytNplQCkaJbpk+Ty8aenPHhVMYpID26ihfG5AcRT/MZboZnJHPJ+4av5mYu30b
	 QCWLg/8w8KfygQmewBwz8S9LlCtjteE0wuxtJRWYTP41Gn8TvsQx0umuN0huRZy5t9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412610;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=DG+m/XO9xepm/CmAAY8Jh8/MFW0sg28+p+YY1flBFdc=;
	b=UjDstQ0+JpK24uj8E83qVuswUefD6m+TdbYfW9/4danUz6oQFwx8NvnI6HUE5V6mkxbR
	 TLBru+uROg/SZLMrA82fthmPY0MvC+0cjBXwHPEuqLyAbzKjj9S9mZUtiMZUVVft7CN4E
	 9PFrBTWeSScsZKzPAdUDsg/jRkDAWvKyPVV+8TCen/MqfuPmNmGjp24KcKGUXxMdUE62E
	 z8KTiDzolFNbaPsbTGYWVh9ZVzWpDcLomPI7mfWGqSNDm2vFnfaTfDg9F1HtAcWD29WkS
	 PC5oU7YiBdktXcWtCJqOAsK0Z1yvUKWrvty+HQsAGaRQ1JZqHaz+8SYlefpAz7RYRkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7mw3AIi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7F606A322
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7mw3AIi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9BB1F00A16;
	Sat, 31 Oct 2026 02:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793412609;
	bh=DG+m/XO9xepm/CmAAY8Jh8/MFW0sg28+p+YY1flBFdc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f7mw3AIi5E0Oe8NTQejFLX8zBT6sUY4Bo6u2htkzNb5kxD9KdqDqAVZhbYfwzwdBA
	 kmk3K/dZcAeBJgsHGXv+JVb1WwUpSkvQFery6TBwpylMG5uFftYvCr+anGL+02ABBT
	 PKr4Y9DNv7h3e/naOlXwUqACxEgNHGu0qsM+RRuRPLKnNa5EHl21+/quhZ0mQUf7kB
	 lXhXVKOVovyG1FFarO1l8zMyCCQ1wUztNS1eNIZjY30Q45fbq6/Xu84MLfKTQsDWQp
	 KIrlgF+3oH+J0HHX67Cw+k67Kzmka9kfacd4qd9nzcQWBqHYeP45Tu6eLDmbQ0N5qL
	 FRFLLeAA3VEHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2583800479;
	Sat, 31 Oct 2026 02:10:09 +0000 (UTC)
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
Subject: Re: [PATCH net v4] tipc: reject attaching bearer of different media
 to
 the same occupied device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179341260804.1900554.4171793488688637328.git-patchwork-notify@kernel.org>
Date: Sat, 31 Oct 2026 02:10:08 +0000
References: <20261029030522.8306-1-tung.quang.nguyen@est.tech>
In-Reply-To: <20261029030522.8306-1-tung.quang.nguyen@est.tech>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net, xujiakai24@mails.ucas.ac.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Oct 2026 10:04:48 +0700 you wrote:
> Currently, two bearers of different media types can be added to the
> same device (e.g., "eth:eth0" and "ib:eth0") via tipc command:
> 
> tipc bearer enable media eth dev eth0
> tipc bearer enable media ib dev eth0
> 
> For each command execution, tipc_enable_l2_media() is called:
> 
> [...]

Here is the summary with links:
  - [net,v4] tipc: reject attaching bearer of different media to the same occupied device
    https://git.kernel.org/netdev/net/c/0a0257228be9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


