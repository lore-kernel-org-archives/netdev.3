Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83647D479
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826684; cv=none; b=QSVAVugZsSR8qpVYajR7mpa5Qq59qA0kyuAodgjPXQgtR+9NWlY0/JeK4iQQk6MwQhacYiXkWy6Uv03Bnrxo8PB7dwEHh1Us/rlSlswRHUayU0F8liNr/RXVefTMwmbkFFhDFkeyNsAIWHhOrDvT0ThMjoGlO4hs7FlcA69siLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826684; c=relaxed/simple;
	bh=WSEK+gNoU0n9wbOxhXKW3aY/DCNtGpgs+2+Ssy7ni1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=drRwGAG+FujpFImPXr/zDAAw8stahhnz97kdg18kYtK86HyOnFVYELermOfV8L66ib6P2s8uLja/nOWryxTxyMaEeP132+abzN738TRu8LmlnRi06DyGRZJsdb/IpLt18wNPiRbxUNVT+HtDoLy3kvXKl760PIUNhLf0NZkfuSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkZDckmF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkZDckmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B411F000E9;
	Thu, 23 Jul 2026 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784826674;
	bh=jcyr5cfVSVZnMd1eGqSu3rlXNA5vkJxstTe9dicKFuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bkZDckmFFklJQJXUMfrweL33E8v4Wt1s1VnVZhsYZ3EsOl5VALKm3P+kFABgB/jTp
	 O+3J4phbNx9fBaEpbWNWRji+NrCVl7e9VXM7Fo4A4GPKyeEoRigTjGqt8TL15PlIR4
	 Ch3GRTD8Wm6/VO3oL6eY+Lzlp++fs0IMTwXJM5UhbOtWCVoO7O+fkwAL+Fg0M+LnVK
	 5udgjJqucaG5MrmpPQBWXWqx0FW1J9E20PndQ7nS2J5cm41iukN0JEUyCBn+xp2pI2
	 iKzzXVs2dv4xonpzN/QJhqdbtEvxi6THwk+KEc3AlA2k7cAjBWQLWOjaIqp9ifDzG/
	 hBZrx+1VoZSrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1997839244CB;
	Thu, 23 Jul 2026 17:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] mctp: check register_netdevice_notifier() error in
 mctp_device_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482661964.2789426.17876607896150059614.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 17:10:19 +0000
References: <20260720072518.112614-1-heminhong@kylinos.cn>
In-Reply-To: <20260720072518.112614-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Jul 2026 15:25:18 +0800 you wrote:
> mctp_device_init() handles errors from rtnl_af_register() and
> rtnl_register_many(), but ignores the return value of
> register_netdevice_notifier(). If notifier registration fails, init can
> still return success while the module is only partially initialized.
> 
> Check the notifier registration error and fail module init early.
> 
> [...]

Here is the summary with links:
  - [net,v3] mctp: check register_netdevice_notifier() error in mctp_device_init()
    https://git.kernel.org/netdev/net/c/d9a33cadc70a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


