Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD554DA9D3
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647675; cv=none; b=tQ+cv5TJaecl3ZKNCxulQa8Ch16TLHUxUmQQgZAd1l84M0mrm6X1oIUtLg+btfy7m8hQnSuYowJiN3ZU5xkQy1vqn7iP+nmOIuVtMIrodG+KLjmnDOkKYqfldYbtyyn4Ul93K6e7JDh26b5Pmr7QhFYovWb/HRsgdSoFfkbO/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647675; c=relaxed/simple;
	bh=NdR/u/tnrvig5CMc5o43UbF076rVFCIblJIau620RUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JbjSxqfl37CbMkyBIgJKBSvfTG+gZHPQcV1uO+Jp9aVxfpgZ0gunlKn+hRrJid64KAa7q4RnO80nnjoZlJLkZzwTmv3/kI8z9u3iG5GCQ5aITsk5ZjsjtZm10T8EAWybe6fhqOOOTnePx5WMU4xeyp20H2S9NTMYwwqFqzTgizI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKrb46xR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKrb46xR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CE21F000FF;
	Thu, 17 Sep 2026 12:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789647670;
	bh=vIhN4S0w8PzVihg1kc0vc+hqAwtJhWnvUOqboT8hXTY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BKrb46xRKqBEG/fe82CFjnrDaAvV+66ubxRtyIo5fQJ7QgX1Uflr30MCzyz8krrdQ
	 Mv0lWw0Ng+YbkIdKT61UeLWP5JTYsHN52MMd9mn+f6frRND+/RO0TZdpsQJKwU173l
	 hO5XNnXcK82yAU5DoiplwgMPFgHCZfOwRwLm0fGJbT1ZlaF13DrsdvXvxQsYhYjrsU
	 DlEq/WlmKD5Jp3HG+XzeUKEd0Pz0edq4IyESCqpVujHqi1jd+MctmCTOx0oks4d+ZX
	 vVXOQi9aHPtpX8v3tULzZFvlfdQqV5Tm+Fe3XK5LhlE+yEJkhhVKFxmgglDnaJ1hdm
	 qhKF2IOpjHSRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A7538111DB;
	Thu, 17 Sep 2026 12:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] openvswitch: raise internal port TSO limit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178964760440.3610434.14071440897470610889.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 12:20:04 +0000
References: <20260916065844.1380155-1-wang.zhan@smartx.com>
In-Reply-To: <20260916065844.1380155-1-wang.zhan@smartx.com>
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 i.maximets@ovn.org, aconole@redhat.com, echaudro@redhat.com,
 dev@openvswitch.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 16 Sep 2026 14:58:44 +0800 you wrote:
> Set the internal port TSO limit to GSO_MAX_SIZE (512 KB), as for
> loopback and veth. This allows the admin/user to set a GSO limit up to
> this value, to use BIG TCP for traffic routed through the internal port.
> 
> Only the capability limit changes: the IPv4 and IPv6 GSO and GRO limits
> remain at 64 KiB until changed by the administrator.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] openvswitch: raise internal port TSO limit
    https://git.kernel.org/netdev/net-next/c/859e40055c19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


