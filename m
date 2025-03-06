Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0920ADC7
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254008; cv=none; b=rRPFi7Uh9ULUgdYrdyuYc7U2Dm/JvmsyNNiYsaTsAy6FCBlThep7kFXv9CAQaA3g+D5qyISlD8t1McmDSyrR2QSx2JjkggxeWEbyz3VXNoIofcEypmw0s+EM6eqvke/VS1k6eHWjHD1fakL+j4WrDszb24CsYnMrdfZsxSGJEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254008; c=relaxed/simple;
	bh=ATdznG2ARGDQgclsnOUYpARUcrUisN92I5kmdd3JCpE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VYmpgwuuz4iqYFtWJpVZzs/ChJxP3hCpl5mGrPhMFOnrmCAy5PF4RQfUApqAHlZ8OuS44N3pYrjOhGxJ1uwYwyaNOsaKOC3+ptIGeTtwFx4u8MWWRizLopFiP15L6HELU95uFA8UHE6CEeel/EJMvZkBr8xxh7TXYlzkf04H35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMYpIrhA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMYpIrhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97B5C4CEE0;
	Thu,  6 Mar 2025 09:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741254007;
	bh=ATdznG2ARGDQgclsnOUYpARUcrUisN92I5kmdd3JCpE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UMYpIrhAYV3sztAGFqVPUdekCZ5UtGKlTzEhI+zuL9ZBlpkxQwffhEHS2krTrvWFb
	 6GrB9iIlKHFTq4dJHDJTaiZ8CmYgbQ+LL6GMCnRtmAlg29P46prPQgS4GH43M0zylh
	 fkDSEq7KoUVcKtuxbIiqAAUOyyPnAJP9HW9DwEUPVpJ0jW/RPSLN3itTLIhpC/mK48
	 pruLx3l/52i9n5P+bSx4P+zWb7Hd1xSzZ/KWarzNKR/LTAwRZWy/4NQT4edwoHfo4T
	 fMbNwqOPRfa3qa79URfA3gusMtKwy/h+GEg13OdrmM7p4R7/t8j1oMM672JXYUGhTu
	 1hBqU+xDpO1dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3510A380CFF3;
	Thu,  6 Mar 2025 09:40:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mctp i3c: handle NULL header address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174125404102.1197740.5192829086973292850.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 09:40:41 +0000
References: <20250304-mctp-i3c-null-v1-1-4416bbd56540@codeconstruct.com.au>
In-Reply-To: <20250304-mctp-i3c-null-v1-1-4416bbd56540@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 04 Mar 2025 13:59:51 +0800 you wrote:
> daddr can be NULL if there is no neighbour table entry present,
> in that case the tx packet should be dropped.
> 
> saddr will usually be set by MCTP core, but check for NULL in case a
> packet is transmitted by a different protocol.
> 
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> Fixes: c8755b29b58e ("mctp i3c: MCTP I3C driver")
> 
> [...]

Here is the summary with links:
  - [net] mctp i3c: handle NULL header address
    https://git.kernel.org/netdev/net/c/cf7ee25e70c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


