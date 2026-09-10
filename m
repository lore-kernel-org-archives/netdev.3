Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA70E3644C7;
	Thu, 10 Sep 2026 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005069; cv=none; b=d1c8lIldHlqI7drEhKGq+av6aISXRB8z9yiZ0l4RgijBLG1HqIktpKiNtutMX7tX6s704g2Ymr0GV8E7x0nqGzjmOxGgGEd5ZK/eqoGOmOJhDYDoCChI2gUmjN7LVPGBoSCvjw8IM0fRDPjbhjYfR2J/4E2kMlDti3iiwtawrH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005069; c=relaxed/simple;
	bh=nNCMzyyB06PeFMro9i8s2v7a+HYVwNUWX1c5yP0kFDg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JYN/XigvI6wD6li5zXaxAuM5oLxJgsaa/lqdcZOoc93wZo7oAO87nNBxMtywR+GVd8+Y/FcaOYrADZD8W9K8ZsMVXHBMm/NlgdwNCTThvNOtishxlZh0cfWszFURe63jNRNQ4Fy9XAD1ZdOJ7VZ1K9nmGp6n86YJzgtDrgveEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8RBbxV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8RBbxV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC4B1F000FF;
	Thu, 10 Sep 2026 01:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005067;
	bh=Ynx3CzuvMfQl+ECIYvRehwvtMR3x00AEB6EapXi+ZCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q8RBbxV6k8CrSbVYKu/FbnBlCLJ5/z5DnuvTDJsYc3YMQmQZDhJ/9tbzMP3PojD6s
	 6TUkgmsu0tmgsWOcmz0DnWhFkD4QFwrYmFi3tFWPW2+OcogOX//0AA2in16GHqxzNI
	 08kMm2yjD/LUgek7eanPCmJJwlDCBcHaikySnI9RBn3OEv9lP/70VNcP5uuNdI/kPq
	 MCIlHgOnT7xa74EO6zrLyH/z0sImeTFt0tdQPGtGDbd8IJtgc3xFnYn0YP6MNggPOy
	 MwxISRvt6SBbqswGniuvx5bZA1K6FMtdFgnObAWIbP2r/vPsJdYmhe66GgRz/iHGQw
	 07Cs1CUABXenA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E1380CEC7;
	Thu, 10 Sep 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phylink: initialise link_state before a forced
 major
 config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900500538.1147948.10957190868823159726.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:50:05 +0000
References: <20260904185540.2844261-1-f@lex.la>
In-Reply-To: <20260904185540.2844261-1-f@lex.la>
To: Aleksei Sviridkin <f@lex.la>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Sep 2026 18:55:40 +0000 you wrote:
> phylink_resolve() leaves link_state on the stack unpopulated on its
> disable and link-failed branches, which set only link_state.link.
> phylink_apply_manual_flow() then reads the struct's advertising on
> every mode but MLO_AN_FIXED, and has done so since long before
> force_major_config existed.
> 
> force_major_config turns that into a write to the hardware. It is the
> only trigger for the major-config block that does not require
> mac_config, so phylink_major_config() programs the MAC for whatever
> the stack held, a zeroed interface is PHY_INTERFACE_MODE_NA, and the
> write-back stores it in pl->link_config.interface.
> 
> [...]

Here is the summary with links:
  - [net] net: phylink: initialise link_state before a forced major config
    https://git.kernel.org/netdev/net/c/113998aa372f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


