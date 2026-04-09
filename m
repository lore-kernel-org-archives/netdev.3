Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C692E7635;
	Thu,  9 Apr 2026 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703077; cv=none; b=G/zpI/ybJlb3khwOuNGJoifDULm886gn+v9O3lbxJ3TMZrGzWCD/RVe3RpqLFr2+OqC9XUD1OyCI9pO+8hUUSaMhPNmlBwCbcmjwJuAQwVc/5Q59rDH/ZRCb3UUR24RI26juGQxQXM9EVfNld4GLuNt4R54VBc+20Q8wNhn6Xv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703077; c=relaxed/simple;
	bh=l761m6M4jniye5UOO409lZQC2OC6qzOOlcdE2iqViK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mwe0e0JQs9UbxMXlfk9O3PQNEJrLYGMZ0DVNUeAFVVeAW5wl7PGCAILXFHyR+/0puThZp0qss9wrwSAQ+CrrpCMaYnCltBce3z161k0Kon6QVAeqm82Kum0P4iUbYvI8FB+8U2szO/0Z53YPTg7ws7AiQQg1Co21M5SB/7OgcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqC6Lk6v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqC6Lk6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2034C2BCAF;
	Thu,  9 Apr 2026 02:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775703076;
	bh=l761m6M4jniye5UOO409lZQC2OC6qzOOlcdE2iqViK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eqC6Lk6v4FDXp3Aw3mrHVmt2R1huI/8cix5V2SASVegzP5oz0MUpHX05i2NwkbSrX
	 6I7N4wcBZgfJEXcz8Ls0ni7h/rFk1om6/Ics/P9gMDGRv8FcHFqVt+stuMKstT3dlz
	 1bzAccWUe/9ZrxLzPFsS2wR0IYlX5Ny8EJ4+QIx1hbTWDe7xlOq00HPa1KcuMRGMzK
	 oKXL1y64ukPQwf+FCTJu/2npvWT1AOJfwqi2IBCM2TC2CAk0NrbylW71aoI/hDb7SJ
	 LYfKo9+YkVQHVo2paXbh/O8Vf9kLgoB1UtgZqGSZVDBMP026cQRTKOGlo/Iqp9Hs/2
	 u1qrnY/6kSs+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD043930793;
	Thu,  9 Apr 2026 02:50:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] devlink: Fix incorrect skb socket family dumping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570305304.968772.16983350750493132581.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:50:53 +0000
References: <20260407022730.2393-1-lirongqing@baidu.com>
In-Reply-To: <20260407022730.2393-1-lirongqing@baidu.com>
To: lirongqing <lirongqing@baidu.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mateusz.polchlopek@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 6 Apr 2026 22:27:30 -0400 you wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The devlink_fmsg_dump_skb function was incorrectly using the socket
> type (sk->sk_type) instead of the socket family (sk->sk_family)
> when filling the "family" field in the fast message dump.
> 
> This patch fixes this to properly display the socket family.
> 
> [...]

Here is the summary with links:
  - devlink: Fix incorrect skb socket family dumping
    https://git.kernel.org/netdev/net/c/0006c6f1091b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


