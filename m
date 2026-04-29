Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2921ABBB
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426276; cv=none; b=DqppcAMfdO/Rfc1ipAasbykqJBml41dDeA4Kzoz6iB9KqcLIoCQQ8QuhHNGL5kEnD6SzwEljRRXMCKHTvO5sDl5RD+SebjMHoRm3VYwZ+BmSLi+KqqlfZ7Pa4mY3u0My7t5vjeNvsvB3KYSKMNuOr/j3q6cDQ1ZCdtEYUxP/HW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426276; c=relaxed/simple;
	bh=0sOqmd04CLb2lTxgJ5tDbcuOlfNcMFY2f1u1ZhVXTUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E7yC6ayLr4oqn+HDr8SqPOanT1+Wlsc6lAFDscSfg6z2FALdJ8P57p1x4QKXAsOyh8Peos21eEy/Gavk7fVCEfL6UfCGXj8To1QBQrBhWdijP2K7oZgigZd8B4Vw24C5E0GjJbspDVQhEL58iz4TB7Po4FW+dribIsOXAsXT0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEB7EXWh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEB7EXWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3C1C2BCB7;
	Wed, 29 Apr 2026 01:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777426275;
	bh=0sOqmd04CLb2lTxgJ5tDbcuOlfNcMFY2f1u1ZhVXTUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JEB7EXWhejR6E15KXm0dkPdy9I7GXhj5zF/Wh8q0sSPbmUeaMwkVgmEEjkW9tSLYe
	 5+bOEyw20N/sSdynmgloLXVbQtGr1PVPsEng6jtt18sVS1zLECXnrtvjAqzK11ZFh1
	 scMVApbDqkS6IOKVe63vGveYuNDX2HufEQomVNRa3RKYpVrnvnSejOYthuicBudNpn
	 XdGAvrU8N95Prlwo7BuyLoHnoAQ0qqJmUeyTa3JyF5oEw9diKzPzJSt9zs4JaOK4Js
	 mBgpGbyw6McX1eayFa5JEyD0O4jUuClIonAue7KvcecS4AlS5AkqfcgIJBUcr7+49H
	 UJY5DXaV8Ww0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D5239302C2;
	Wed, 29 Apr 2026 01:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: psp: require admin permission for dev-set and
 key-rotate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177742623180.1288483.17618104394692874758.git-patchwork-notify@kernel.org>
Date: Wed, 29 Apr 2026 01:30:31 +0000
References: <20260427195856.401223-1-kuba@kernel.org>
In-Reply-To: <20260427195856.401223-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel.zahka@gmail.com, willemdebruijn.kernel@gmail.com,
 donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Apr 2026 12:58:56 -0700 you wrote:
> The dev-set and key-rotate netlink operations modify shared device
> state (PSP version configuration and cryptographic key material,
> respectively) but do not require CAP_NET_ADMIN. The only access
> control is psp_dev_check_access() which merely verifies netns
> membership.
> 
> Fixes: 00c94ca2b99e ("psp: base PSP device support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: psp: require admin permission for dev-set and key-rotate
    https://git.kernel.org/netdev/net/c/b718342a7fba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


