Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B91F4611;
	Wed,  8 Apr 2026 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775611858; cv=none; b=CAZy6ZkhIX8tuPFlUe66JuzvCGqoXXud34Xu9EP5muuN2kEoSN4MFjtOO/mUKOcLcud/emPqSgQBvZ/BEjKmKUpWWJPemMU3xnVMvK+F9iFB2XDNCtWvCuuRXj3TGLlJRynuY7BfjouFGIYdspFz6GIg3+oM/DlCSoedctOkLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775611858; c=relaxed/simple;
	bh=qgo8I/wpNH6jeC0cNL5xsJZ46riNHlTNnZFYPV7CYJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uvI2AZW6qKNECubjJ5dGjuZEejL/jRiPSiuKzLWL3UbbugfeiTrR2ck7/IhEqb95szxuMMQg9aMvJUSVQkoBUJkgH+wMI/GBAKsUdhldydPMuHt3AP1yfZNwEB1P8RfPEuxRS8NqBqmgZ+EXWV/gx8SpR79yFSis528ZRjYFYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaNbCHkO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaNbCHkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABB7C116C6;
	Wed,  8 Apr 2026 01:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775611857;
	bh=qgo8I/wpNH6jeC0cNL5xsJZ46riNHlTNnZFYPV7CYJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MaNbCHkOaRbxQNYvIOKGkeM2NoYXsv72YCd0B+w0RSHlpZVlTvMYrl2RA+1mpKzoq
	 0+3fifZM1YoFUtriE5mDUNNVCa+fUJHPNx0ZQkdMre8hhbR65yVubXcd8uGun6lyV0
	 W9/UxiPhKhT+KJfjjR4NObIEpMtJN4K2Knrj3ZzlyPOxdtJxXlyPQhZudysdVA8xFq
	 4+TVSUbwjIH9YP0MUaBucUvWSnQzGKpLlZa5U7yuAlqwF1nr1BdTd5nsTpo86AxzBH
	 Jfv9EBsaj7v+aUOuJgDwF4mnBk6TgZpg4Kktfjvgtk0fzHVYDMrhK8SlOrN5EAt7mQ
	 gOaRoSAZErcQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD2D3809A3D;
	Wed,  8 Apr 2026 01:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: dwmac-motorcomm: fix eFUSE MAC address
 read
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177561183503.28494.18367414550123221005.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 01:30:35 +0000
References: <fc5992a4-9532-49c3-8ec1-c2f8c5b84ca1@smtp-relay.sendinblue.com>
In-Reply-To: <fc5992a4-9532-49c3-8ec1-c2f8c5b84ca1@smtp-relay.sendinblue.com>
To: Johan Alvarado <contact@c127.dev>
Cc: me@ziyao.cc, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ggo@tuxedocomputers.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Apr 2026 07:44:25 +0000 you wrote:
> This patch fixes an issue where reading the MAC address from the eFUSE
> fails due to a race condition.
> 
> The root cause was identified by comparing the driver's behavior with a
> custom U-Boot port. In U-Boot, the MAC address was read successfully
> every time because the driver was loaded later in the boot process, giving
> the hardware ample time to initialize. In Linux, reading the eFUSE
> immediately returns all zeros, resulting in a fallback to a random MAC address.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: dwmac-motorcomm: fix eFUSE MAC address read failure
    https://git.kernel.org/netdev/net/c/f2777d5cb5c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


