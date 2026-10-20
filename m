Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525224;
	b=tVZu0Uw6CdnYhy/ayd+vbaHQEv7+7NTnQLFvZXmXhMKtfKOFX2p61Wb0rwHldxpE4lft
	 3un8gme4Nj7TvfBVML9+JyfWh7PGMuP30Agxr+38ypVmJYqOhIu+d8kjSkhoxmU3clvAr
	 y0CD4CTEfJKI8+E/Jvxs2VXlhEtIql1rGcd50c8kz/0WgAZv8kGZCKDal3n3g0cC2cSi4
	 254m08Uuhr6eLzjcjaoDkMAFBfkr8501Di1UtVcwXM3WGrdr0O9I8v3l2oV3o9F4RdFq8
	 PzQgOEIVWpQFbjLzLEl4wuIQrAwpty9wtnXUiWDFbsD1Dh1qfre2Pv23DXt7JwxBsTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525224;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=GMhgKHULm70PnSZy6eK7GBS1zL92BfoLg0BqlRDj9NY=;
	b=fXwkXLaKLGaBnjyg5vgon6YPaX3G/wRnpvW0/eq+2mH5rFP86hjaoLvFu0uxIj9Jy6BL
	 vObuwhWa68s/pP5D3w2wi49NCwLXdr1jAJsOgrEY+fGsV50kG9Whiu0PjVReGsPUw/rQE
	 xqP2DH1UxeISavW+h6a2u71/SrUKdv853GgcJ33AfN/fD8hPNJZBzd2Ir6upLgKzxZR9b
	 G3tQGWYNkgnp8PcKd1po9nco3OzrfTuYQTh8vbwVQ/Q2iclubJ3b6fgvkMUtBvUjgokxc
	 /Lm0WiYLYVWotdY7Vzt4ylqvlLKn9ioGjLwmUa26ERibvTwOIzb43UXVHAl4kEC+LBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+Q+hs9a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB4606A31E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+Q+hs9a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805291F000CA;
	Tue, 20 Oct 2026 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792525223;
	bh=GMhgKHULm70PnSZy6eK7GBS1zL92BfoLg0BqlRDj9NY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X+Q+hs9aFbV4VMCw5gVN3HyYQVvo/NK4jg2lSrOatK6dSGrTr50PQEVBFqmJkYvS9
	 aFnDHuNTOAxN8wrVlr1Tu+VTtuIPFStl4uUoCWpQKb5fSXLq1GKC4dzhOiGoHtjeUr
	 FJfuNHnDLw3VjhmHWYz8mRw/hncprDTBTUhwaP2XpZBoN4f6s8yNyxdBcdkrqXrsPe
	 KY9vHI/IKA9Ch4ajt5aue5Msa8jXKcie5X5uSAtA2/C01v8GlHEyLz1AvPAC4L0qau
	 QOmFbsOdzpckr/+K0VlIZsVaTYED4O+wIWzQ2SNvZ9TIT9Ogl8cRwcqywrOiyZvvZh
	 qtvFEY4l566QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774503809A09;
	Tue, 20 Oct 2026 19:40:23 +0000 (UTC)
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
Subject: Re: [PATCH net] tls: device: protect async RX resync state during
 device-down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252522202.176933.15986245052236382358.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:40:22 +0000
References: <20261013213517.2219663-1-rjethwani@purestorage.com>
In-Reply-To: <20261013213517.2219663-1-rjethwani@purestorage.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, sd@queasysnail.net,
 kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 15:35:17 -0600 you wrote:
> tls_device_rx_resync_new_rec() can run in process context with the
> socket lock held, but without an RCU read lock: from the strparser work
> item (tls_strp_work()) and from the receive paths (tls_rx_rec_wait(),
> tls_rx_rec_done()). The resync_async pointer belongs to the driver RX
> context, which tls_device_down() tears down from the netdev notifier
> without taking the socket lock; only the softirq entry to the parser is
> implicitly inside an RCU section.
> 
> [...]

Here is the summary with links:
  - [net] tls: device: protect async RX resync state during device-down
    https://git.kernel.org/netdev/net-next/c/f89a22812523

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


