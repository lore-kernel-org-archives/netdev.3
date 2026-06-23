Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73A533D6;
	Tue, 23 Jun 2026 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251425; cv=none; b=QUFoQziCozKe6HRMx94fM0xK+g1mxQzLj5+wq9kgF4AWx0llGmYns9mSTmqEpZwjgIJyzQAcXe61mAG551Y3eS4d2GX9u7xmJ+HSFe2754sHQOBNd2GM6nl5wq2JGlU5nMjmPwUFPKLRGyQ7dkh4PPvf2NELWIdu1X0v0Bk8QmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251425; c=relaxed/simple;
	bh=LZC7biF3o9h2lnIqezg4X9Xf4ik6VwYqRCHvNYme79s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LasdP7e1PfjVQsEDsaAkNPCqzrg/MWZ259RxEWWF76mxva5sYI/4/8bFCC+sX4naSSkVBVRZUJMQ2CHDTAM0PVh9l9S8wQlMBzeHukwt7etAZLdgLJwrGz1ueQFFOymvvaa3Aj3S7887vxV7uxQwuRCMmmv4OnSFyaYAjJsev+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM1P0gQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM1P0gQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B7D1F000E9;
	Tue, 23 Jun 2026 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782251424;
	bh=lJeHTMjoPOx2e82GdsgLKM6JsFk9dxZkoFHKtFDXllE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VM1P0gQCOP2/YjM3QJchjgk5TPJAJ7IVoNcdJm9F6t+VSPV6PsjyLEUf1EEIjHQc1
	 74ZK0osyFyAHO/3o/+/2ZCPXYK9kK6gJjwY5eTaL+heK1qiqsNK2amNCY0aeVBbozY
	 kTQy6ml+IVpYXs6CgVc6ki8RAt6OxwC0I/i/JfaykpvMfkHEQfGTVnBPaL5GaOmrMl
	 0XfIII0qovl2Zfb80Fl+Nc4ooCf9PzOQMCGz55i7i0Nqs5lfQzOdnZw9TBjqbbBqEo
	 /PLEkp9hCNKbfChY5L9VHgFq/niCfUOJ4bxetL1JG/gu/q3Qew1jLaNCHpob5F3iaJ
	 pjYpg6mo5S6rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1980D393101D;
	Tue, 23 Jun 2026 21:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: sja1105: round up PTP perout pin
 duration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178225141375.2433118.8819337111696272699.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 21:50:13 +0000
References: <20260618110508.53094-1-aga@itb.spb.ru>
In-Reply-To: <20260618110508.53094-1-aga@itb.spb.ru>
To: Aleksandrova Alyona <aga@itb.spb.ru>
Cc: olteanv@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 14:05:08 +0300 you wrote:
> pin_duration is converted from the user-provided period to SJA1105
> clock ticks and is later passed as the cycle_time argument to
> future_base_time().
> 
> Very small period values may become zero after the conversion,
> which can lead to a division by zero in future_base_time().
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: sja1105: round up PTP perout pin duration
    https://git.kernel.org/netdev/net/c/aee5836273b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


