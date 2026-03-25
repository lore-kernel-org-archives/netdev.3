Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C21B983F;
	Wed, 25 Mar 2026 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774410626; cv=none; b=gut1NNu4z9mgO/7wo/KanHRCdoQoCVTINMxQX5naFLtVgXfI+dHfcGkEWOPubKAyWo6lq4qZ/elxvKmi8IclHXt2UpzdTzqzEUE5/gjOrNRwC+X9UDL+j5niqrANdvyl9aascs9g9WGzleVrb7d5+ZK0qY7Y8t0mBjJedk68+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774410626; c=relaxed/simple;
	bh=4jGndeVI5NjhSSlbjbmcTZ4pJvm9kcTBKIa6dC0RgPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cpxASEW1pD6lzJfENCUZ7n5TkWZ38q3VuILPCqaelSuF4MzKZ1bYT9bCU6Trvb0PVAlKglL5fNZLfy+NV4vbSiQh7/DeKy7BpzObo19UtM5rwp7NdH227dMLuS/9pmYqUDCEoFjBCuGMgGyzHG/PORrOQ/P+y/CbqCSt8roWiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU6KOqBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU6KOqBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0506AC4CEF7;
	Wed, 25 Mar 2026 03:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774410626;
	bh=4jGndeVI5NjhSSlbjbmcTZ4pJvm9kcTBKIa6dC0RgPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lU6KOqBM60lI8irgi6Q4V4TY4Z6//9eN86Al2yc5OTNxzjtzNM3NxgnxXyXutqD6X
	 ozjpjXW1RhBiuNzgVkl19r7F8Hp2cOtTzfMXPoo5D47o0G3ztKXpfdhKj79dBrK+2J
	 JsXlrdpgqIh2Kh0pEbouYT0LhpCcMw47cbGkpNYiiNzB1KN55WNXuPI3P2/SNfvljA
	 XLipE9lHLMG8FMpXi+Y+lTv8T3/Gu4+PieXqz19XZoV3N3IKt5+V/aExmbSyahuN0K
	 fUIQdFeN7YCzL5pRlPCZGCIc1pfa53HiBrbaOZ24rGl7lNmU+Xk/k3p0hfYn/jOgqE
	 O4EPq/Gyeh2nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FDB3808203;
	Wed, 25 Mar 2026 03:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: pass genl_info to the ethnl
 parse_request operation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177441061328.1414050.10772318671382842266.git-patchwork-notify@kernel.org>
Date: Wed, 25 Mar 2026 03:50:13 +0000
References: <20260323095833.136266-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260323095833.136266-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Mar 2026 10:58:32 +0100 you wrote:
> The .parse_request() ethnl operation extracts the relevant attributes
> from the netlink request to populate the private req_info.
> 
> By passing genl_info as a parameter to this callback, we can use
> the GENL_REQ_ATTR_CHECK() macro to check for missing mandatory
> parameters.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: pass genl_info to the ethnl parse_request operation
    https://git.kernel.org/netdev/net-next/c/10171b938330

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


