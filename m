Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586C4AD7FE;
	Thu, 24 Sep 2026 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271089; cv=none; b=XEj6309KulVv/SCXmLr0dHgoyQ+xYkyQkl3wvRlnkX7lQMN9lkQXDSZZ8uJA9ZdZpNE6vjlF7wx15FndDvBO63RVKiH2YFfsqyhoZ7iJaet0TBLGSy86vvHTYmovXqrrgGMW6IuzrkngjxJLxZvyycutSgvFX9np/R0KhMvOMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271089; c=relaxed/simple;
	bh=p9ZmUGtZrrE2iXRki3h88NeWe3LCz0pKx2ehoj1MQro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqluvv6swYRNbHleuTgLObLO+3JYdzccTwPq2B8stWnrjicvIMNbGc9NKxSzst1R35eeDBCzowfUqWj13EKh5a7GxClYaqsP4aKexWNpomu1zuwLrlrLbbH5E6/wyfxuaAj1zEZP4f599bwJp/NTsx1HLo2IV2jtkELoDy8ww1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFJ6qKpb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFJ6qKpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7EF1F00893;
	Thu, 24 Sep 2026 17:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271088;
	bh=kKpEA4ZPnZmLYqk1f/RKbe5kuhGWjOaRK5RvklV0zEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kFJ6qKpby7HHI2Kz9duCs07w63gwz6v43jCON6/FzziI+gGBUV3FRBrZWdsP+bWth
	 8FesBk5iDOLX8vKT4z2sYbzCaOst+7ZP3FLcKaZL6l5XmcDxCgLqfhx143VDGH2aCd
	 lXrbzKkgExkpZ0WkRqoid4gI3tJiU2W4g6lWMzGTMd1yyj9IVif7Jphn+Q6PmkNO9v
	 bTMNcMnM7NngWGRYNegKT8ZoKM/FAlydChLWNUniK1b3WMPCa63rLTddVQhdHnwu00
	 vouZbiffjxqGtf9R6T8d1NmWfcLbA+FoLx9wMeeEPybNfR2BI7i2489c+bm+Jc3JqZ
	 ya1GQGh3G4ImA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A603A566DB;
	Thu, 24 Sep 2026 17:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: Fix a data race on mon->peer_cnt in
 mon_timeout()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027101689.1669750.10034423915812616755.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 17:30:16 +0000
References: <20260922080909.21123-1-ginger.jzllee@gmail.com>
In-Reply-To: <20260922080909.21123-1-ginger.jzllee@gmail.com>
To: Ginger Li <ginger.jzllee@gmail.com>
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 16:09:09 +0800 you wrote:
> mon_timeout() evaluates dom_size(mon->peer_cnt) before it takes mon->lock,
> while mon->peer_cnt is updated under that lock by tipc_mon_add_peer() and
> tipc_mon_remove_peer().  The value can therefore be stale, and the decision
> whether the local domain has to be recomputed can be based on an outdated
> member count.
> 
> Read mon->peer_cnt inside the write_lock_bh(&mon->lock) protected region.
> 
> [...]

Here is the summary with links:
  - [net] tipc: Fix a data race on mon->peer_cnt in mon_timeout()
    https://git.kernel.org/netdev/net/c/8e1937fed673

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


