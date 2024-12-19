Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E8130E27
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734579025; cv=none; b=BgdUgvMXqzQrfLZfqklKKuoq9HLRX3tNcvlXKlL0UWMo5qYRXu/zOtmqu6SJZop7b7ymfwYmhDb0/9gP/fKMRTg3w9hmTsxtS3577qP5dvR9lPZvZoU2QoGW43FzTc/Uqlo8OFoFwMoWbi4jhpkjP6yemO1GtE+gGCRTu4lCfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734579025; c=relaxed/simple;
	bh=zKd4jttxiztCVhvsstlHB9IGCf1rgB7kM1emvFyZiQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UUpLQAIv6T+k/kzP91u/7mBvB/CFfwik/08FlkfYUGhFUKl7a4bRCDafpWV5yxX4emMLJEwI4eR4qxgIwpqAJl8y69zOOTw5IXkc5oKfyVKD+Ts+DCHXNiAhiiq20MrQU/56V2XquE/dwWoZry08MwoYTAp1D30yC8ebvuWb2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4Pawn68; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4Pawn68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF8EC4CED4;
	Thu, 19 Dec 2024 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734579025;
	bh=zKd4jttxiztCVhvsstlHB9IGCf1rgB7kM1emvFyZiQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p4Pawn68WbrKUMSvvGUyGtggCAIqlm2MgRbSljNPHW3p2CIOzJCfGY75834mCUvLE
	 ETDKNkRnVv+fH/h9Xatb3N9stAWh/iYUfDwtaOgPmzMvnFNTgb1jg21s+F8Q7bm+6l
	 6da1GY2h7xY6+KXb871FYBlCk0jUHRWZkb/TR1am+PykB5ryDTEmwDMmrzqaKRFnzw
	 C6hJbZz59bjwpZaRMK+gFJg+YkNl0Q1+BYwJOgrvvyxsymHtItW/Nz0hCqXTTl3/Bb
	 ULGykOPLyGxHy3T4AL+dwJTsPMqzGo55pembKUYTpaU0AmYk6YUYdFy++QvELOFXNC
	 93ZcKH/cV2zFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF73805DB1;
	Thu, 19 Dec 2024 03:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6][pull request] ice: add support for devlink
 health events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457904248.1807897.3995651625629711771.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 03:30:42 +0000
References: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, mateusz.polchlopek@intel.com, joe@perches.com,
 horms@kernel.org, jiri@resnulli.us, apw@canonical.com,
 lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 17 Dec 2024 13:08:27 -0800 you wrote:
> Przemek Kitszel says:
> 
> Reports for two kinds of events are implemented, Malicious Driver
> Detection (MDD) and Tx hang.
> 
> Patches 1, 2, 3: core improvements (checkpatch.pl, devlink extension)
> Patch 4: rename current ice devlink/ files
> Patches 5, 6, 7: ice devlink health infra + reporters
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] checkpatch: don't complain on _Generic() use
    https://git.kernel.org/netdev/net-next/c/20d00cfae627
  - [net-next,v2,2/6] devlink: add devlink_fmsg_put() macro
    https://git.kernel.org/netdev/net-next/c/346947223bac
  - [net-next,v2,3/6] devlink: add devlink_fmsg_dump_skb() function
    https://git.kernel.org/netdev/net-next/c/3dbfde7f6bc7
  - [net-next,v2,4/6] ice: rename devlink_port.[ch] to port.[ch]
    https://git.kernel.org/netdev/net-next/c/2846fe5614ac
  - [net-next,v2,5/6] ice: add Tx hang devlink health reporter
    https://git.kernel.org/netdev/net-next/c/2a82874a3b7b
  - [net-next,v2,6/6] ice: Add MDD logging via devlink health
    https://git.kernel.org/netdev/net-next/c/bc1027473986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


