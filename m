Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5661D5CFB;
	Thu, 30 Jul 2026 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370267; cv=none; b=BQR/axuMiBpn+lU34pw4Ysia/SnefzmqPf7pkQP59Lhqud89gtT0YIKdUxdMUJB5sYu+/lYTzjOCXwfmSaqlwEs7K4ijhFuv993cm3R2DQJCTiKfTgXmttv3JBhzMTsI6IeeaGN0OL07k/DPEuo26c25Pytrjt2oYFvxIIkJiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370267; c=relaxed/simple;
	bh=RQR74oZpi6Jc12LtJTOy6B27LVH61L+S9Kr9ntFIoVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nfulk+9qHbeikdUSuyBwoeYvHeQEHxEh0V9TEjXyZtTOYro9ehbizwk3n7j65dEW70PvOf2A6PfYcR3QXaKgrfB8HVWyb9JI3h1S6mqXXta3bf9QP1O2ikHmwHkOLcxoicylRFdWpIZrqtdHSnDJ2jQziUALcP+LREt3VacCQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWBK5EvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWBK5EvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9A01F00A3A;
	Thu, 30 Jul 2026 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785370264;
	bh=CmtsYrfAh+CcYVC4SMfUXggvgre6+mM2oAaW/NnS0DY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mWBK5EvWyHommCP1pwQqOGEXcT+9q08aUTHqJHq3byb70mtoWuJ5rB/XCDBU76pN4
	 GEGSFkbvedbdwp1JC3x5ZodMu/4epxN7dp2UVs2AooHrBbSXL6S0tJ10JQhALqIjDl
	 3y9lnolxns7WpfMqkh9k5Z+7tHPjzJsBf325HXp4vfpspdzqusROVXz0ABY+4P2M9u
	 iI4PIvNo3P1I84UlNELz4T9lCoweItS6LvcLl/d7uV9mo7KHRV/aEv/ApQib5hWJhw
	 k8lYgo1PQCycrekvQkr/HY8tIPk23EaFiVXuGAbBHB76aFMOGkOFOtxOSxIhmXbXEQ
	 0TZMj0cBMVe0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A3D3926250;
	Thu, 30 Jul 2026 00:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] netlink: specs: nl80211: fix TOOD -> TODO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178537022839.3290991.9616480521704728604.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 00:10:28 +0000
References: <20260728154142.12133-1-shaikhkamal2012@gmail.com>
In-Reply-To: <20260728154142.12133-1-shaikhkamal2012@gmail.com>
To: shaikh kamaluddin <shaikhkamal2012@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 matttbe@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Jul 2026 21:11:42 +0530 you wrote:
> Fix spelling error reported by codespell in description strings:
> TOOD -> TODO. Attribute names are untouched. No functional change.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> ---
>  Documentation/netlink/specs/nl80211.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netlink: specs: nl80211: fix TOOD -> TODO
    https://git.kernel.org/netdev/net-next/c/bb3fed50cb01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


