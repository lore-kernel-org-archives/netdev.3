Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F33859FC
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971207; cv=none; b=b3dqA7TmzMMDqj5f74pXyUCE8idhJhxn5agvabcUnshdyWsyH9i3OiIJZI+gLDQlTaNQJvENI4NqPIumA15eqxyKwGrdL5FocYRIW3movhUV+jCzi5TPn821olB3Zv4rmRkd9tCK58CHm8Nb4yponjbzdL9Qsdo7TZ2KWSoBZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971207; c=relaxed/simple;
	bh=LiX3QcpiOvRJzdza0Q+1JN/9QWJgSPH1oQJhYKAOpeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KqJrMKYXr9seOKplmq88HcOoVqTZt4YEiC8bZudZZ8k4pMOEcqMrZvHyObUQwkZSUTv66GstJK+nmdJsFEM3TicRSxseqkSsSrb4NROxuxW3DK1BngbjmlF98tvG+znlxioQUorKr+vk246hfrY3U1/SnNkDRjXCkBPFi/TFu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhqx2XqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhqx2XqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E93F1F000FF;
	Fri,  2 Oct 2026 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790971206;
	bh=cABRFd8bFcKiHSUZCV09hdfPsz2VS9mJ8S+46tbLiBA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Bhqx2XqDE64zw2jg13cOF/Gx9sl5TcGI7SdIxgz0bX0nDqXDOL/OESgSrOwGZt0xM
	 AltQPcRu7JjDC65sxFQF7qSLRWsnVplnTuI6LiHjrhMUZAd2/EGQ3XbuM+zvj5ksb+
	 peXOwSouMMxvYN8Izcbiy0tplnp2dIu+uxcWPhdbm+9qwx7/sDeDD1y/A/pt9LsKrZ
	 GHxAzMNRS7l3RQct2CNr33IqObPXrdpLkLPyo9w6lhsQijpkx0fFJJktCeKaZ9PqFy
	 P10fopcMmNFzHDV/0pzk+yl/ac/TYjTwBodA4OKiFqaT4cj6atp07TxWdHVQqy2R0O
	 FE/hFf0l6KFUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F12A63811A72;
	Fri,  2 Oct 2026 20:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: fix the program leak when XDP is replaced
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179097120453.3565478.4300903300332450854.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 20:00:04 +0000
References: <20261001012639.298690-1-kuba@kernel.org>
In-Reply-To: <20261001012639.298690-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
 joamaki@gmail.com, daniel@iogearbox.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 18:26:39 -0700 you wrote:
> We need to release the reference on the old BPF prog, whether
> we are going to no-prog, or replacing the prog with another.
> 
> Spotted by AI while running tests for the propagation series
> (leaked programs were accumulating). Selftest will come in
> the net-next series to avoid conflicts.
> 
> [...]

Here is the summary with links:
  - [net] bonding: fix the program leak when XDP is replaced
    https://git.kernel.org/netdev/net/c/184b5ddf82d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


