Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384403BE64F;
	Mon, 30 Mar 2026 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914719; cv=none; b=lh58NzYCmjPMnTz4mxNpgx72xylyI8egQy2Q7a1u3JAXVjR7jgADazha8Dw/r5OHiqwksF+Xt/LsqH+/ewn34ACShvIwZ/ME/IRPShdo+e4nWWfnI5jS0IDeEwGLCCqCBfTY1PHl94aH6EpfE6v06hLMV1wTtivtbhCP/tGiP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914719; c=relaxed/simple;
	bh=dZPEfRMQC45032C6pl+fokgRYZwtsw/YLgIsU0w6lCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DM8Oa+8GomIUK18Bx5KIJDDrg+I2SmIj02Jqc+ThGQYy/53zAqZjfZqTCBGJsn3sP+3seiUmFsTPvp6XD+rDuPoC+Ay+NO48xg+O9Ip9203exo6tD1ehjlVaka0hs0SV14ZRE9qNuNe3/ksjjG2Ij5CarpIECiix0chToJQG10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI8OGNO6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI8OGNO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BA6C4CEF7;
	Mon, 30 Mar 2026 23:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774914718;
	bh=dZPEfRMQC45032C6pl+fokgRYZwtsw/YLgIsU0w6lCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mI8OGNO6UMKH8IcOgDz11ZWsG/AlRVMGFzJ7aMCYGiuzg8ufEYXh8VR73EbubvJFD
	 Zy+2+gRJocb0vybTfEawFx0Ca8aeyH8ilGMqI9BFqqbFoCBJHp4xRWLhOFnSZwLmzu
	 Ox5JKyyvWm9LJ3ruFTODipQ6XetFUfrcoxREAFlXTCFriEhUANLre3C60LKj9Hhh3+
	 1CBErO3A5XsQD1Z1nB9e6CgiI7SCB89DZzzSqSen4oiwoOuXMfFiPezP9lsBQh0BOy
	 3mkuniALko6rQlipJ8j6NUH+NKChEkfnVpkERKEBz27fT16ipzU7DxUi5m7ZZqYJcV
	 TYtxuOB3vIPUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E2A392FF85;
	Mon, 30 Mar 2026 23:51:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: sfp: add quirk for ZOERAX SFP-2.5G-T
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177491470279.1985303.13835397075068661976.git-patchwork-notify@kernel.org>
Date: Mon, 30 Mar 2026 23:51:42 +0000
References: <20260329191304.720160-1-jan@3e8.eu>
In-Reply-To: <20260329191304.720160-1-jan@3e8.eu>
To: Jan Hoffmann <jan@3e8.eu>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Mar 2026 21:11:11 +0200 you wrote:
> This is a 2.5G copper module which appears to be based on a Motorcomm
> YT8821 PHY. There doesn't seem to be a usable way to to access the PHY
> (I2C address 0x56 provides only read-only C22 access, and Rollball is
> also not working).
> 
> The module does not report the correct extended compliance code for
> 2.5GBase-T, and instead claims to support SONET OC-48 and Fibre Channel:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: sfp: add quirk for ZOERAX SFP-2.5G-T
    https://git.kernel.org/netdev/net-next/c/911e2c050963

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


