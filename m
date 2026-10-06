Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CB23393E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245432; cv=none; b=gkvSyQwjZGoV31pK1mzYsSd0+S16oJcDFtJWzy4l7HeIxh2EX9P2b/AjbkilwEtRDkqhNHBKTkC1oojEGvBgXjgNeIAZ3msS59/yflYfYCtv+R2fcK5Irg5STRxdT9yMpOUpecIcnitTWPmFmNF/LWpEOvtCM8V8laj1rIwdM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245432; c=relaxed/simple;
	bh=p09gLgusBJbnyjx9MOZxQpfDc7xMSlDOWYILZyhOLO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qfdXAIguCdmwvpL/JtpGiQzzngIuOJ0O3r8gGdXOKJ8FitN6c1f7y8PHvrGWT84rmRgLljbkTQfLIaGgj50Tgg9s+rfVUbFlPrXE85RQbtkr80PI3uaufWej8sTIQVC/ZJ39hDd/gG6KWHi1bGGGhjr9RLkN4NkGBszqONWUVF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7d+xqpp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7d+xqpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D4E1F000FF;
	Tue,  6 Oct 2026 00:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245431;
	bh=crNKsHM/01ifbYuDRQdI1lbe+GpWO2933vEh51uWzTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B7d+xqppxDrmIdbY4RPa2igX/RWmbLqLlQGvylBr6UIsoyo+nNPdGAP70WG6cj/FL
	 ZoCVjPxeV8CvyNfTTLFPZKXSsKCpXemK9M8Mm1wk0mi07SX7m62u2Dt3twdh248SXt
	 2Br7qLEn7eBOy0DIEoaarWmdYnseLFqVtOpgw3yaWAjMQYLuLdMrxpOn2xF7GLCEZV
	 5ZUPuMRj9O3kMEuDsTJZiHMWc02G2nbkGXc7PEXnZm/QJ3l2gbTQY/7qC9qXdaPmZh
	 tRFKZx5ytEj9WfKOVRfDoutSd9nbOSHssRpV6ayTtIVj4uCM5huxGnhid6RXKVyTM+
	 DOINwyzJ0N90A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F130E392667F;
	Tue,  6 Oct 2026 00:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfp: flower: remove merge entry when conntrack
 offload
 fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124542952.1947351.14252868477518237942.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:10:29 +0000
References: <20261003.final049.214b9988b1e1f0a7@gmail.com>
In-Reply-To: <20261003.final049.214b9988b1e1f0a7@gmail.com>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: oss-drivers@corigine.com, horms@kernel.org, netdev@vger.kernel.org,
 kuba@kernel.org, wentao.jia@corigine.com, lcy8047@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 02 Oct 2026 19:47:40 +0000 you wrote:
> nfp_ct_do_nft_merge() inserts nft_m_entry into nft_merge_tb and
> increments nft_merge_count before calling nfp_fl_ct_add_offload(). If
> that call fails, the error path removes the entry from its lists and
> frees it, but leaves the hash entry and count behind.
> 
> Remove the hash entry and undo the count increment before freeing
> nft_m_entry.
> 
> [...]

Here is the summary with links:
  - [net] nfp: flower: remove merge entry when conntrack offload fails
    https://git.kernel.org/netdev/net-next/c/a032c035272a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


