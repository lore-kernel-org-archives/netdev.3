Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916D43499F;
	Tue, 29 Sep 2026 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688622; cv=none; b=nRRy8oZ16SNKUfAVJbJQA8xtBjN/Qyg+dKsUKP+UUNIHtpTxxkVlFBtgoaMjxm60EyIZtOh3Ujnf3Bxtg1GFjuxaNQyIYUYPYMzcGeErV3hGGi8zR7oxcfxg4Z3MtHgr0oEq3d5G3O+ALujGzB8bjX+kVXY6BREAP3Wa4y2xwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688622; c=relaxed/simple;
	bh=MF6duWhTiBFHqLC41xuN9KjW/NE56xlCsiwhtGn2EyQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M1QQ9dC+5q3u4zpE0RVDscjP1vht6iWK3Y+mnbdZ8Uch9whkGHSmfWOBBOrnVrpOCPKx7JyLHj1s/8oNtp8Prs23EBdK6jO6CXyt/57hYtfTqPIoinZH9dm2oNi/bNUPLPMDxNPqFDhuEvVXFWVke7oE3AjXFeD78ThMWekP4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xied+oiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xied+oiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CF41F000FF;
	Tue, 29 Sep 2026 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790688617;
	bh=tpxMtyLbJXm5U49c0BCLy5KnG5A91nXoFyuhUI/S+qo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xied+oiSfn9HZ6lELwC/+DN2FHwBndWOy2yW2njfKtYiP9QDZ6JdlXd0uQR6/PnHD
	 4SHuClGtVd+JfvjOwZCDldDgdGA65AgupaOKdze460wiAglgMwrC6ajgsUH2PZTHba
	 SXP/WRko8h7VV+OhKiTE3E1j3BkufxiZD9XyIOHSiEPNmO253eg7aI6Sx51gQqi2Fz
	 4XtwXlx3LksXNRbJYCN8TwnFYOI85qBJwMW6UXYdWHu5Cq4OFQ6D6hoXEau6I0+Wm8
	 rgLuGqIF3Vd2zwFvQpfnL/ifaYIlmhos9kUSalmwaoBfL8acgN814NTi8ZdJ/BbVjE
	 JVlzOwdv98j4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773EB392665C;
	Tue, 29 Sep 2026 13:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: pktgen: return bool from
 __pktgen_NN_threads()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179068861628.494842.3816676679388537158.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 13:30:16 +0000
References: <20260927135406.3969970-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260927135406.3969970-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 27 Sep 2026 21:54:05 +0800 you wrote:
> Callers of __pktgen_NN_threads() only check whether a pktgen_dev was
> found. Returning the pointer exposes it outside the helper even though
> neither caller uses the object itself.
> 
> Return bool instead and keep the pktgen_dev pointer internal to the
> helper.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: pktgen: return bool from __pktgen_NN_threads()
    https://git.kernel.org/netdev/net-next/c/2a5043c8b7d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


