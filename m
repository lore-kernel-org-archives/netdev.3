Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915F376A09;
	Sat, 22 Aug 2026 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428881; cv=none; b=XfHfkMhOCnYy82tmV4Wk4BU+y8Fd7XmAcjuZTxVQFGooyZ3ek7HKmTJHgXZm+3DkWkyiUX/8TJnKoF6H2guUJcjtxHsq23G36gWzmL3CaggmK6tA1X01Tk+3LnFt/oUNcQiKmCBGQgU2NLXEqYynwB4ZDkKMt8ayv/RmqNHJua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428881; c=relaxed/simple;
	bh=F8atr3k1yEi8P5zMkfkAfX0/irWfF6avzFo19r5vvHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Iqi3ZEkGRUiyy9+w+BFqHt7TgRQYNAUixr5bxSuUBiexXqS1a+MBgINgcKq/SHaL8tP6FBtWBb7YcsxTz1TbFjB+bImvXVhiio2/z7U+HQvKoplD3YartQ79Xy5jwb+M5c9YT+XvtEwrp6sQaIV9b9oiUfrQ1V9N42pRSN/3Iqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2e0B8pl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2e0B8pl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DAB1F00A3A;
	Sat, 22 Aug 2026 20:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787428877;
	bh=CuD+9Vvqz+pT+o8q2BK80rpEdxAwuZhW2aQtRrmiRbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=o2e0B8plFnqWzaQNZ37gDUq9QGtF1ayJ0XI/SNY5ZSlupqBaurb8byxcdiqvd6+ZZ
	 dhHuQT9ZXQZ2JyWVUwOPRe5GZ/P+ZzLHxub60Frsbu8qsqK4SMTrc+OUzmzMo3/k8o
	 7kmd59MEwhrgBIpwzZatxTdgeLc6OSXxw9K+YjQ4eWyhPBCCGRtFUfUcGAMTftcYO5
	 d3ehLdA2+Wg89lGiHZUk74ANBmWjITMdoyYPuf7+t3NFLXIDRveK57Bb0hJ1+niuGD
	 5NtaiYqQdkDCGLQsNsc2ieWzN28NxgGV7il5e+fCZYRZRbASnfzgH0IDLj8uJ/ROnp
	 T9wEXgaU0AAMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569E8380CEF9;
	Sat, 22 Aug 2026 20:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bnxt_en: Fix call to hardware monitoring event handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178742882588.1812309.229528138073093887.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:00:25 +0000
References: <20260821044512.663941-1-linux@roeck-us.net>
In-Reply-To: <20260821044512.663941-1-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kalesh-anakkur.purayil@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 21:45:12 -0700 you wrote:
> The first parameter of hwmon_notify_event() is supposed to be the hardware
> monitoring device. The bnxt driver calls it with the platform device as
> first parameter instead. This API break results in undefined behavior and
> may result in a crash.
> 
> Pass the hardware monitoring device as parameter instead to fix the
> problem.
> 
> [...]

Here is the summary with links:
  - bnxt_en: Fix call to hardware monitoring event handler
    https://git.kernel.org/netdev/net/c/622d698df423

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


