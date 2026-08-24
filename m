Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3253876B3;
	Mon, 24 Aug 2026 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787597484; cv=none; b=SrP06XEdsiQaMS38iIAY83ytzexOIGIBzhX29PVbWcwdsAVnhKehPQllswmetI7TFSaM4bQytd9Mq/9QrSUdtTQc2yh7j20ORtQUx+gXwoEzOVBzNBLwUgvlvieDxPAkAAgGAAH5W+2Dr4dVWVE5LUMEqqcXNm2Kb1Y+RMNLCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787597484; c=relaxed/simple;
	bh=KJkKDicdG+s27wZZYH9ly8Tza/9W/BL0Iwz3twDjVQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d9Ook7pAteY+5wGVWM77MvKNDKJzeJr+8ZjstHFUL7KAf7knIj/zjrZ+IPKJfrpOykPXW1/gXKcon/Y/m7L3B7dMTtM/YWDFXP/Ubdc6uFYBNRl/5mlD0Q+rstXBWZftkO/MrGxRJVItFPvkvzut9mEyzhrmIHisvhKppsMvo6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxGUIvGG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxGUIvGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945321F000E9;
	Mon, 24 Aug 2026 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787597473;
	bh=SB4zKdWBZJd+8Kw4rF3REKisypYbvAPO0nL6k1kAnVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YxGUIvGGGsUE3rzpQlrnti2zf4KShEA0JhJRo6F/+vomUUcvCQ3/GFTk32zMiLZDs
	 TVtdAqhH8qZODDrR+6k3WVqxbt6vu+a/NJRGTAzt3S5t/9Dzu7DCWP94XT9Rub1Dgw
	 WWKEdFjWdG0nAfIxIhkxnU/ikCyIJ1aszPkves6ZtfrhzxHorGsIMaThxDuTTONsDu
	 ByIdZZp4rwx3YSNEG3sOA5FmThIYguN6lPq91abUWgP3suOSahdOvVjJKy4w7WSWVU
	 f4iEfvVswVUvCEpWarUkp6lrl6rplZzl5VRWpg9WqzO1DEwvzvUGrBkq7XQAqpmDea
	 KRZa8dJ+CoR2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569653924A4C;
	Mon, 24 Aug 2026 18:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v9 0/1] openvswitch: Fix CT limit teardown
 use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759742088.3062482.4048404364016754764.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 18:50:20 +0000
References: <cover.1787280296.git.xuyuqiabc@gmail.com>
In-Reply-To: <cover.1787280296.git.xuyuqiabc@gmail.com>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 pshelar@ovn.org, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, yihung.wei@gmail.com,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 vega@nebusec.ai, tonanli66@gmail.com, enjou1224z@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Aug 2026 11:19:37 +0800 you wrote:
> Changes in v9:
> 
> - Rebase onto net/main.
> - Drop the data parameter from ovs_ct_exit_finish() and read the detached
>   state from ovs_net directly, fixing the build with
>   CONFIG_NETFILTER_CONNCOUNT disabled.
> - Rename ct_exit_data to ct_limit_exit_data and stop moving declarations
>   around in ovs_exit_net().
> - v8 Link: https://lore.kernel.org/all/cover.1787129643.git.xuyuqiabc@gmail.com/
> Changes in v8:
> 
> [...]

Here is the summary with links:
  - [net,v9,1/1] openvswitch: Fix CT limit teardown use-after-free
    https://git.kernel.org/netdev/net/c/403f96c32c9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


