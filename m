Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0299286D7D
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426814; cv=none; b=deS2Qqfxmnf9SLFCQ0WjeAF+iiW7ggmFcjklrBpQ4Z3kdhnvd7kh/r/W1iV04gogoNWO06IjSzNIU1SAjn+uD6fT4GmXF9G7y6Mx8GlCus7+APomBocTWt3Chi/Gao3KMLyZcPM9K6SaP02sQ8Za8kYFe4qfCRmwbc0sfN/98hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426814; c=relaxed/simple;
	bh=PEiOhUqSi39MzdM25L+W0Bcab4+xpmg8ltgBk6u1EWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nP370CaCg3W8COg5gZlLXL8s7Tgzx/u7+Drzj2xObOHvEsnVS+8F+sn9Esma3mQdYD2GRSvdBcqJwRylZUi4fs2MIpwI51aGClWGC+q2aneUv0UdgjLtsZODLzIiYDse6zJMu/n1b9vuaW85Pvjg96C1CQDyAE8dHGvwGyotG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyyM/hyw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyyM/hyw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD501F00893;
	Tue,  2 Jun 2026 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780426811;
	bh=vA1dkpnE7GAkQbG3DEaaa1gmLrRpo0VleTtz+CWvfYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dyyM/hywngPYGlvN/fZRoU9nzlUxqOuC/GTjQRE70rAopERtE8S8KL69H0GZipyFz
	 629R6O7YdIdVcZAUnrVkGqBCOfBBdUsVan9mnNYpERms8MLS2OXuvj4yZDNiPGqs+i
	 iR9JJZ4wutUc5uERPHrWZUUeu/AcrJdpQfko7DZh29DadCZ7oWJWkexoC001vJswHz
	 RDA14IGRbNAryL5JRpukAxEtw7FZ5P8Z5JGxwx5k3aXYNoEEqv9VhxW/RPLAjtlI6l
	 8VDC/EvxPr6j1WgtY3oiiBCIzFZ270/8VT+p14xeEjPm0VfARZxTUvxR0TojAhnFPN
	 eib1XkvzeZSIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AB33811A6C;
	Tue,  2 Jun 2026 19:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] af_unix: Remove sock->state assignment.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042681313.1007375.15414829129961897305.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:00:13 +0000
References: <20260529191829.3864438-1-kuniyu@google.com>
In-Reply-To: <20260529191829.3864438-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 19:18:02 +0000 you wrote:
> Both struct socket and struct sock have a variable to
> manage its state, sock->state and sk->sk_state.
> 
> When both are used, the former typically manages syscall
> state and the latter manages the actual connection state.
> 
> AF_UNIX only uses sk->sk_state.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] af_unix: Remove sock->state assignment.
    https://git.kernel.org/netdev/net-next/c/ed9ea881746b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


