Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BB282F1E;
	Mon, 17 Aug 2026 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787010655; cv=none; b=ijydG+/lPJ2oYuSsrUxO9O2Xvjx8FR+Te6shVOnZME1u7CaoUq7mJUDqpEPdYqdPmbVFp3TrAbYxikyB4NFwXiaHvnQsQ3RsSMXAuMSoGfVTDVL9OczMA+ODHmqAYhLxf/N7emQhrswOIIeQGpM4LVHU1YDyGREyK8VxTfRfNkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787010655; c=relaxed/simple;
	bh=/fPIcL/yBVIow/bD1gbrNztPocrnWkY0xBbw3rTAWzc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cp+IMAammlZ+LhqEZvJt7uG3eNNPaAky9B2ISlpqUk2RySaCfv6O8QCg7CS+pX3ZqOAUi0FxII5o3lo2kb7iOHbXF8mY4AoSO+5RsH9BmYFNZZ8i/6sVCqeqBRmPg+6xXhODMhAs+oWlTEQW+oBKXvIZkzgfz53HbgYHxSyCyFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqkNT8Kw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqkNT8Kw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC35E1F000E9;
	Mon, 17 Aug 2026 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787010653;
	bh=hrmMMS4tDRqVACoFhIORodq6WP/KVISUEN5h3n7rvGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aqkNT8KwxbfIuSNkf79r8pGditXY3QvHSRY4LZ0XDqBuNALwOUOt/3gti25TnLg//
	 E3LYHJG6brjKGoLM2er9GMWhujxJhTw7Nkn/jS7uLs0grQL0Efd6Hvj2g1/eW7Jk47
	 BbQ0AS0+72CbLAn3SQUkprpCornsoa6K8LxauGPw4j6vfEGJhC72dF0qHL6sAVObbh
	 W+hSHLmikbAA6ZYeK47n/7QtYrDBNhDfAH1paJgTfU5T4i0RYpza7FT0dvHoCuCDya
	 3j5re8gx71YA5edwF9+MJsdB1uogoteKvC6KDfg03LHp2TJZh3UlRkwvQ4//qLQldR
	 SFw0xbDz19QDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A7D3926276;
	Mon, 17 Aug 2026 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix PCS link check on CMODE read
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178701060564.1794559.14041650086891150375.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 23:50:05 +0000
References: <20260813153131.3952970-1-ruoyuw560@gmail.com>
In-Reply-To: <20260813153131.3952970-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Aug 2026 23:31:31 +0800 you wrote:
> mv88e6352_pcs_link_check() ignores errors returned by
> port_get_cmode(). If the port status register read fails,
> mv88e6352_port_get_cmode() returns without setting cmode. The link check
> then compares an uninitialized value and may incorrectly treat the PCS
> as active.
> 
> Save the return value and fail the link check after releasing the
> register lock. marvell_c22_pcs_get_state() initializes the reported link
> state to down before calling the check, so a read failure is handled
> safely until a later poll succeeds.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: mv88e6xxx: Fix PCS link check on CMODE read error
    https://git.kernel.org/netdev/net/c/7b196e27ad58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


