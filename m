Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8D39DBC4
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948869; cv=none; b=GemkxD+EO5LY9Ec0eYGr86pz7vfeH9z2watHHaOXOTqqGh7Z1c5zFxC5W4ze//RjtgGI8HzkXqU/NGeoSE2Gem4Dt0Wmx1y+/XhPySw5TPqhLcPTxbNw2vSnot7RVcnJji1t00kGnPCRTLluuitjkmcVb1o8LydWnexCxX4M3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948869; c=relaxed/simple;
	bh=EdqPuaDiqOxiu4Pm1cc9IkgEx+MzC9d6COE2s0kE8+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gi6xlMBNnzHp8Ky9NZRKUqzzXl5/QBt65PlCQ6raKGyWO2pvzNlL3SYvXKqSENxLgZYAXLY1fNPhdKO/HCAfVYo6Ka/aRQuK/uty12QwmJDU1g7JGV9pdWtkUPL6Jg6o//YwsAZEogJFg+d/bjzYap2jNig+DNW+XtzXNqAOLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr9jNaSp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr9jNaSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3A5C2BCB8;
	Tue,  5 May 2026 02:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948869;
	bh=EdqPuaDiqOxiu4Pm1cc9IkgEx+MzC9d6COE2s0kE8+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jr9jNaSpOBH5p/6Iu+iulmmt9QBt+8/gw3b88tVRIV1k+97SI191IWIfQBQ+SOJ/5
	 ecqJskcaOPLFSbm+YMOlehFNHvVg5pWd4UBBoUjPVrxz+dGtN7hqAEN01YcmWbUR5s
	 kU4hXy559PhXQ5PR6gFsdMxcB2C0KsvnjOzFop4t7rEskzCAFm4W9CdywPof1ogmcP
	 yBHfoFw6wk1kDhUC3O3li75arLh2GY4LV1oDsiOqUsVFsDdI2l45XK3XcqX8w+gNiP
	 Lg7SUDDyPFVoV6OtApJwcaNnHIXi6VE8GnrGsr9NUQTsHt9/vYT5u+WM2INIzctqh5
	 sWbWupCY7K2fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FBFE39301A2;
	Tue,  5 May 2026 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: speedup tc_dump_qdisc() when
 tcm_handle
 is provided
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794882004.1397274.13628832774580358402.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:40:20 +0000
References: <20260503114515.2460477-1-edumazet@google.com>
In-Reply-To: <20260503114515.2460477-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  3 May 2026 11:45:15 +0000 you wrote:
> "tc qdisc show ... handle xxx" filtering can be done by the kernel.
> 
> A followup patch can do the same for tcm_parent.
> 
> iproute2/tc needs a small companion patch.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: speedup tc_dump_qdisc() when tcm_handle is provided
    https://git.kernel.org/netdev/net-next/c/c1e5127b577c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


