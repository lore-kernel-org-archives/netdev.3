Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7E364959
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330012; cv=none; b=kcf+9bSilS+eCPrLDLWuUf+SIBi1BU5z6Vk+bD7+UyU7gr0K4RU0oL4tq/JFsR7wgsfAs+aQZtoxnPHUhaxysr1Epi2wT4Lziew2EnUsML135hadlPSxIafaWkEnsZzGzVRmxnss08z/SFWseI0DeBs6Lg0x4q51Nx5zrh0dXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330012; c=relaxed/simple;
	bh=9Uyg8O09YLNUSm9/QqL1bVl3Ghss4AwWLFEWMAe16NA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GzioPt71O0+Tdo7wLFOCp5GPWea1yxhKTNjJkQBseH8Q6sIUy3LHA+z6pKdh9hi8Dw23u77dshOBmorjeNzq9eWQBJNe45+LAM2MGZquMrVhFqU1w89hpxSvWfEMgOQZp/h1EouwqTWZcL975Bg7hdakLvMEqdR3B4hBwrUuqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNo43Up0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNo43Up0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698051F00A3C;
	Thu, 21 May 2026 02:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329998;
	bh=PGt+tPS32Lc2B5E5AhDconRwRn7Qu8Y+Jbulqw3fL84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mNo43Up0ZiYwubh7cex+oOPWlGyd3D06acOh1jSUuusHXjN8rFQxhC5qpbh3OoCUC
	 8q1NhJuJEGvqnW1/9Kf42XtyGG0cOJYBW0WvCMtSp8WnjTvf21DrKe8ls1nO1/s4bu
	 07rmdcoQgzDd1SlzGV9U9Ht80IdwcVZzFDOvNgjX9oq47/+G42ihY4CXQlgW78B3LH
	 ouX4VdsnunsMJLO+i6Pz+Zo6/A2ZxRpoIc28N+oE36w/yiFIUMjkrkBa6JRAhWpP2P
	 Pb7gv6KIqioFHd+QsuxtNBYhgMyfqgdc69uPS/+orNjHPCUwYSrbr04Y+bCeMKkVTH
	 pIIFgegbFlsgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09CB3930C38;
	Thu, 21 May 2026 02:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net] tcp: fix stale per-CPU tcp_tw_isn leak enabling
 ISN
 prediction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177933000839.3834961.9447712671063316418.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:20:08 +0000
References: <20260519084611.2485277-1-edumazet@google.com>
In-Reply-To: <20260519084611.2485277-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, clm@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 08:46:11 +0000 you wrote:
> Blamed commit moved the TIME_WAIT-derived ISN from the skb control
> block to a per-CPU variable, assuming the value would always be consumed
> by tcp_conn_request() for the same packet that wrote it. That assumption
> is violated by multiple drop paths between the producer
> (__this_cpu_write(tcp_tw_isn, isn) in tcp_v{4,6}_rcv()) and the consumer
> (tcp_conn_request()):
> 
> [...]

Here is the summary with links:
  - [v4,net] tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction
    https://git.kernel.org/netdev/net/c/1bbf0ced1d9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


